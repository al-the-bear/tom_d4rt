/// Owns the generation pipeline state.
///
/// Drives a multi-turn agentic loop:
///   1. Send the user's description + the current conversation history.
///   2. Stream assistant content (thinking / text / tool_use blocks).
///   3. If the turn ends with `stop_reason == tool_use`, execute each
///      tool call against the in-memory [VirtualFs], build a
///      `tool_result` user message, and continue.
///   4. Otherwise: flush the virtual FS to `example/<appName>/` on
///      disk, notify [SampleAppsNotifier] to pick up the new entry,
///      and expose the run-ready path.
///
/// Hard-caps total tool calls per generation at [_maxToolCalls] so a
/// runaway loop can't burn the user's quota.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../sample_apps_notifier.dart';
import 'api_client.dart';
import 'generator_tools.dart';
import 'prefs_store.dart';
import 'system_prompt.dart';
import 'virtual_fs.dart';

enum GenerationState { idle, sending, streaming, executingTools, done, error }

enum LogBlockKind { status, thinking, text, toolCall, toolResult, error }

class LogBlock {
  final LogBlockKind kind;
  final String text;
  LogBlock(this.kind, this.text);
}

class GeneratorNotifier extends ChangeNotifier {
  static const _maxToolCalls = 60;
  static const _maxTurns = 30;

  final AnthropicClient _client;
  final SampleAppsNotifier _samplesNotifier;
  final String _exampleRoot;

  GenerationState _state = GenerationState.idle;
  final List<LogBlock> _blocks = <LogBlock>[];
  String? _generatedMainPath;
  String? _generatedAppName;
  String? _errorMessage;
  StreamSubscription<GeneratorEvent>? _sub;
  Completer<TurnComplete?>? _turnCompleter;
  bool _aborted = false;

  GeneratorNotifier({
    required SampleAppsNotifier samplesNotifier,
    AnthropicClient? client,
  })  : _client = client ?? AnthropicClient(),
        _samplesNotifier = samplesNotifier,
        _exampleRoot = samplesNotifier.root;

  GenerationState get state => _state;
  List<LogBlock> get blocks => List.unmodifiable(_blocks);
  String? get generatedMainPath => _generatedMainPath;
  String? get generatedAppName => _generatedAppName;
  String? get errorMessage => _errorMessage;
  bool get canRun =>
      _state == GenerationState.done && _generatedMainPath != null;
  bool get isBusy =>
      _state == GenerationState.sending ||
      _state == GenerationState.streaming ||
      _state == GenerationState.executingTools;

  /// Kick off a generation. Returns immediately; UI listens to
  /// notifications. If a previous generation is in flight it is aborted.
  Future<void> generate({
    required GeneratorPrefs prefs,
    required String appName,
    required String description,
  }) async {
    if (isBusy) {
      await cancel();
    }
    final sanitizedName = _sanitizeAppName(appName);
    if (sanitizedName.isEmpty) {
      _failPrecondition('App name is empty.');
      return;
    }
    if (description.trim().isEmpty) {
      _failPrecondition('Description is empty.');
      return;
    }
    if (prefs.apiKey.trim().isEmpty) {
      _failPrecondition(
          'Anthropic API key is not set — open Settings to enter one.');
      return;
    }

    _blocks.clear();
    _generatedMainPath = null;
    _generatedAppName = sanitizedName;
    _errorMessage = null;
    _aborted = false;
    _state = GenerationState.sending;
    _appendBlock(LogBlockKind.status,
        'Generating "$sanitizedName" with ${prefs.model.label}…');
    notifyListeners();

    final fs = VirtualFs();
    final messages = <Map<String, dynamic>>[
      {
        'role': 'user',
        'content': [
          {'type': 'text', 'text': description},
        ],
      },
    ];

    var totalToolCalls = 0;
    var turn = 0;
    try {
      while (turn < _maxTurns) {
        turn++;
        if (_aborted) break;
        _state = GenerationState.sending;
        notifyListeners();

        final turnResult = await _runOneTurn(prefs: prefs, messages: messages);
        if (_aborted) break;
        if (turnResult == null) {
          // Error path — _runOneTurn already set the state.
          return;
        }

        // Append the assistant turn verbatim so the next call can
        // continue the conversation correctly (incl. thinking sigs).
        messages.add({
          'role': 'assistant',
          'content': turnResult.assistantContent,
        });

        if (turnResult.stopReason != 'tool_use' ||
            turnResult.toolUses.isEmpty) {
          break;
        }

        _state = GenerationState.executingTools;
        notifyListeners();

        final results = <Map<String, dynamic>>[];
        for (final call in turnResult.toolUses) {
          totalToolCalls++;
          if (totalToolCalls > _maxToolCalls) {
            _appendBlock(LogBlockKind.error,
                'Exceeded $_maxToolCalls tool calls — aborting to '
                'protect your quota.');
            results.add({
              'type': 'tool_result',
              'tool_use_id': call.id,
              'is_error': true,
              'content': 'Aborted: tool-call budget exhausted.',
            });
            _state = GenerationState.error;
            _errorMessage = 'Tool-call budget exhausted.';
            notifyListeners();
            return;
          }
          final exec = executeGeneratorTool(fs, call.name, call.input);
          _appendBlock(LogBlockKind.toolCall,
              '${call.name}(${_summariseInput(call.input)})');
          _appendBlock(LogBlockKind.toolResult, exec.summary);
          results.add({
            'type': 'tool_result',
            'tool_use_id': call.id,
            'is_error': exec.isError,
            'content': exec.content,
          });
          notifyListeners();
        }

        messages.add({
          'role': 'user',
          'content': results,
        });
      }

      if (_aborted) {
        return;
      }
      if (turn >= _maxTurns) {
        _state = GenerationState.error;
        _errorMessage =
            'Reached the $_maxTurns-turn cap before the model finished.';
        _appendBlock(LogBlockKind.error, _errorMessage!);
        notifyListeners();
        return;
      }

      await _finalize(fs, sanitizedName);
    } catch (e, st) {
      _state = GenerationState.error;
      _errorMessage = 'Generator crashed: $e';
      _appendBlock(LogBlockKind.error, '$e\n$st');
      notifyListeners();
    }
  }

  /// Runs one streamed turn. Returns the `TurnComplete` on success, or
  /// `null` if the stream errored (in which case state was already set).
  Future<TurnComplete?> _runOneTurn({
    required GeneratorPrefs prefs,
    required List<Map<String, dynamic>> messages,
  }) async {
    final completer = Completer<TurnComplete?>();
    _turnCompleter = completer;

    final stream = _client.streamTurn(
      apiKey: prefs.apiKey,
      model: prefs.model.apiId,
      systemPrompt: buildSystemPrompt(),
      messages: messages,
      tools: generatorToolSchemas,
      extendedThinking: prefs.extendedThinking,
      maxTokens: prefs.maxTokens,
    );

    _sub = stream.listen((event) {
      switch (event) {
        case StatusEvent():
          _state = GenerationState.streaming;
          _appendBlock(LogBlockKind.status, event.message);
        case ThinkingDelta():
          _state = GenerationState.streaming;
          _appendOrExtend(LogBlockKind.thinking, event.text);
        case TextDelta():
          _state = GenerationState.streaming;
          _appendOrExtend(LogBlockKind.text, event.text);
        case ToolUseStarted():
          _state = GenerationState.streaming;
          _appendBlock(LogBlockKind.status,
              'Receiving tool call → ${event.toolName}');
        case ToolUseReady():
          // The host will execute this call after the turn ends.
        case TurnComplete():
          if (!completer.isCompleted) {
            completer.complete(event as TurnComplete);
          }
        case ErrorEvent():
          _state = GenerationState.error;
          _errorMessage = event.message;
          _appendBlock(LogBlockKind.error, event.message);
          if (!completer.isCompleted) completer.complete(null);
      }
      notifyListeners();
    }, onError: (Object e) {
      if (!completer.isCompleted) {
        _state = GenerationState.error;
        _errorMessage = '$e';
        _appendBlock(LogBlockKind.error, '$e');
        notifyListeners();
        completer.complete(null);
      }
    });

    return completer.future;
  }

  Future<void> _finalize(VirtualFs fs, String appName) async {
    if (fs.fileCount == 0) {
      _state = GenerationState.error;
      _errorMessage =
          'Model finished without writing any files — nothing to run.';
      _appendBlock(LogBlockKind.error, _errorMessage!);
      notifyListeners();
      return;
    }
    if (fs.read('main.dart') == null) {
      _state = GenerationState.error;
      _errorMessage =
          'Model finished but never wrote `main.dart`. Files present: '
          '${fs.listFiles().join(", ")}';
      _appendBlock(LogBlockKind.error, _errorMessage!);
      notifyListeners();
      return;
    }

    // Flush every file to disk under example/<appName>/.
    try {
      final targetDir = p.join(_exampleRoot, appName);
      final mainPath = fs.flushTo(targetDir);
      _generatedMainPath = mainPath ?? p.join(targetDir, 'main.dart');
      _samplesNotifier.reload();
      _state = GenerationState.done;
      final files = fs.listFiles();
      _appendBlock(LogBlockKind.status,
          'Wrote ${files.length} file(s) to example/$appName/: '
          '${files.join(", ")} — ready to run.');
      notifyListeners();
    } catch (e) {
      _state = GenerationState.error;
      _errorMessage = 'Failed to write generated files: $e';
      _appendBlock(LogBlockKind.error, _errorMessage!);
      notifyListeners();
    }
  }

  Future<void> cancel() async {
    _aborted = true;
    _client.abort();
    await _sub?.cancel();
    _sub = null;
    final pending = _turnCompleter;
    _turnCompleter = null;
    if (pending != null && !pending.isCompleted) {
      pending.complete(null);
    }
    if (_state == GenerationState.sending ||
        _state == GenerationState.streaming ||
        _state == GenerationState.executingTools) {
      _state = GenerationState.error;
      _errorMessage = 'Generation cancelled.';
      _appendBlock(LogBlockKind.status, 'Cancelled by user.');
      notifyListeners();
    }
  }

  void clear() {
    _blocks.clear();
    _generatedMainPath = null;
    _generatedAppName = null;
    _errorMessage = null;
    _state = GenerationState.idle;
    notifyListeners();
  }

  // ── Internals ────────────────────────────────────────────────────────

  void _failPrecondition(String message) {
    _state = GenerationState.error;
    _errorMessage = message;
    _appendBlock(LogBlockKind.error, message);
    notifyListeners();
  }

  void _appendBlock(LogBlockKind kind, String text) {
    _blocks.add(LogBlock(kind, text));
  }

  void _appendOrExtend(LogBlockKind kind, String text) {
    if (_blocks.isNotEmpty && _blocks.last.kind == kind) {
      final prev = _blocks.removeLast();
      _blocks.add(LogBlock(kind, '${prev.text}$text'));
    } else {
      _blocks.add(LogBlock(kind, text));
    }
  }

  String _sanitizeAppName(String name) {
    final trimmed = name.trim().toLowerCase();
    final sanitized = trimmed.replaceAll(RegExp(r'[^a-z0-9_]+'), '_');
    return sanitized.replaceAll(RegExp(r'^_+|_+$'), '');
  }

  String _summariseInput(Map<String, dynamic> input) {
    if (input.isEmpty) return '';
    final parts = <String>[];
    for (final entry in input.entries) {
      final v = entry.value;
      if (v is String) {
        final flat = v.replaceAll('\n', ' ');
        final preview = flat.length <= 60 ? flat : '${flat.substring(0, 60)}…';
        parts.add('${entry.key}: "$preview"');
      } else {
        parts.add('${entry.key}: $v');
      }
    }
    return parts.join(', ');
  }

  @override
  void dispose() {
    _sub?.cancel();
    _client.dispose();
    super.dispose();
  }
}
