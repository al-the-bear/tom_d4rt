/// Owns the generation pipeline state.
///
/// Drives a multi-turn agentic loop *and* a multi-prompt session:
///   1. `generate(prefs, name, description)` resets every per-session
///      field and runs the loop for the initial prompt.
///   2. Each tool call mutates the in-memory [VirtualFs]; once the
///      conversation reaches `stop_reason != tool_use` the FS is
///      flushed to `example/<appName>/`.
///   3. `sendFollowUp(prefs, prompt)` re-uses the existing
///      conversation history (including all `tool_use` / `tool_result`
///      blocks) and the same [VirtualFs], so the model continues
///      editing the same project. A short "[Current project files:
///      …]" header is prepended to every follow-up user message.
///   4. `resetSession()` wipes everything (UI calls it when the user
///      starts a new app or types a new name and clicks Send prompt).
///
/// Hard caps: [_maxTurns] turns per prompt and [_maxToolCalls] tool
/// calls per session to bound runaway loops.
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
  static const _maxToolCalls = 120;
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

  /// Per-session state. Survives across multiple agentic loops
  /// (initial prompt + follow-ups) and is wiped by [resetSession].
  VirtualFs _fs = VirtualFs();
  final List<Map<String, dynamic>> _messages = <Map<String, dynamic>>[];
  String? _sessionAppName;
  int _sessionToolCallCount = 0;

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
  String? get sessionAppName => _sessionAppName;
  String? get errorMessage => _errorMessage;
  bool get hasSession => _sessionAppName != null;
  int get sessionFileCount => _fs.fileCount;
  List<String> get sessionFiles => _fs.listFiles();

  /// Read the current in-memory content of [path] from the session
  /// virtual FS. Returns null if no such file exists. Used by the
  /// File Inspector tab to render the right-hand viewer pane.
  String? readSessionFile(String path) => _fs.read(path);
  bool get isBusy =>
      _state == GenerationState.sending ||
      _state == GenerationState.streaming ||
      _state == GenerationState.executingTools;

  /// Run button visibility: as long as we have a flushed `main.dart`
  /// on disk and aren't mid-stream. Persists across follow-ups; only
  /// clears when [resetSession] runs or a follow-up deletes main.dart.
  bool get canRun => _generatedMainPath != null && !isBusy;

  /// Kick off a fresh generation. Always resets the session — call
  /// [sendFollowUp] to continue an existing session instead.
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

    // Fresh session — wipe FS, history, blocks, run path.
    _fs = VirtualFs();
    _messages.clear();
    _blocks.clear();
    _sessionAppName = sanitizedName;
    _sessionToolCallCount = 0;
    _generatedMainPath = null;
    _generatedAppName = sanitizedName;
    _errorMessage = null;
    _aborted = false;
    _state = GenerationState.sending;
    _appendBlock(LogBlockKind.status,
        'Generating "$sanitizedName" with ${prefs.model.label}…');
    notifyListeners();

    _messages.add({
      'role': 'user',
      'content': [
        {'type': 'text', 'text': description},
      ],
    });

    await _runConversation(prefs);
  }

  /// Continue the current session with a new user message. Re-uses
  /// [_fs], [_messages], and the session's app name. Prepends a short
  /// `[Current project files: …]` header so the model has fresh
  /// awareness of FS state even without calling `list_files`.
  Future<void> sendFollowUp({
    required GeneratorPrefs prefs,
    required String prompt,
  }) async {
    if (isBusy) {
      await cancel();
    }
    if (_sessionAppName == null) {
      _failPrecondition('No active session — send an initial prompt first.');
      return;
    }
    if (prompt.trim().isEmpty) {
      _failPrecondition('Follow-up prompt is empty.');
      return;
    }
    if (prefs.apiKey.trim().isEmpty) {
      _failPrecondition('Anthropic API key is not set.');
      return;
    }
    _aborted = false;
    _state = GenerationState.sending;
    final preview = prompt.replaceAll('\n', ' ');
    _appendBlock(LogBlockKind.status,
        'Follow-up: ${preview.length <= 80 ? preview : "${preview.substring(0, 80)}…"}');
    notifyListeners();

    final files = _fs.listFiles();
    final header = files.isEmpty
        ? '[Current project files: (none yet)]\n\n'
        : '[Current project files: ${files.join(", ")}]\n\n';
    _messages.add({
      'role': 'user',
      'content': [
        {'type': 'text', 'text': '$header$prompt'},
      ],
    });

    await _runConversation(prefs);
  }

  /// Wipe every per-session field — FS, conversation history, log
  /// blocks, generated path. Called by the UI when the user clicks
  /// "Reset session" or types a new app name on the Generate tab.
  void resetSession() {
    _fs = VirtualFs();
    _messages.clear();
    _blocks.clear();
    _sessionAppName = null;
    _sessionToolCallCount = 0;
    _generatedMainPath = null;
    _generatedAppName = null;
    _errorMessage = null;
    _state = GenerationState.idle;
    notifyListeners();
  }

  // ── Conversation loop ────────────────────────────────────────────────

  /// Runs the agentic loop until `stop_reason != tool_use`. Flushes
  /// the FS at the end (success or error). Caller is responsible for
  /// having appended the current user message to [_messages].
  Future<void> _runConversation(GeneratorPrefs prefs) async {
    var turn = 0;
    try {
      while (turn < _maxTurns) {
        turn++;
        if (_aborted) break;
        _state = GenerationState.sending;
        notifyListeners();

        final turnResult =
            await _runOneTurn(prefs: prefs, messages: _messages);
        if (_aborted) break;
        if (turnResult == null) {
          // Error path — state already set.
          return;
        }

        _messages.add({
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
        var bailed = false;
        for (final call in turnResult.toolUses) {
          _sessionToolCallCount++;
          if (_sessionToolCallCount > _maxToolCalls) {
            _appendBlock(LogBlockKind.error,
                'Exceeded $_maxToolCalls tool calls this session — '
                'aborting to protect your quota.');
            results.add({
              'type': 'tool_result',
              'tool_use_id': call.id,
              'is_error': true,
              'content': 'Aborted: session tool-call budget exhausted.',
            });
            _state = GenerationState.error;
            _errorMessage = 'Session tool-call budget exhausted.';
            bailed = true;
            notifyListeners();
            break;
          }
          final exec = executeGeneratorTool(_fs, call.name, call.input);
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

        if (bailed) {
          // Flush whatever we have before bailing — keeps a runnable
          // app on disk if the budget ran out late in the session.
          await _flushFs();
          return;
        }

        _messages.add({
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
        await _flushFs();
        return;
      }

      await _flushFs();
    } catch (e, st) {
      _state = GenerationState.error;
      _errorMessage = 'Generator crashed: $e';
      _appendBlock(LogBlockKind.error, '$e\n$st');
      notifyListeners();
      // Try to flush whatever we have so partial progress isn't lost.
      try {
        await _flushFs();
      } catch (_) {}
    }
  }

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
          // Host executes the tool after the turn ends — no log
          // mutation here. An explicit statement is required so this
          // case does NOT fall through to TurnComplete and trigger
          // an invalid downcast.
          break;
        case TurnComplete():
          if (!completer.isCompleted) {
            completer.complete(event);
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

  /// Persist every file in [_fs] under `example/<sessionAppName>/`.
  /// Updates [_generatedMainPath] based on whether main.dart is
  /// currently in the FS (a follow-up that deletes main.dart should
  /// disable the Run button).
  Future<void> _flushFs() async {
    if (_sessionAppName == null) return;
    if (_fs.fileCount == 0) {
      if (_state != GenerationState.error) {
        // Distinguish "model answered a question with text" from
        // "model produced nothing at all". The former is a success
        // path — the user gets their answer in the TEXT blocks above.
        final hasTextResponse =
            _blocks.any((b) => b.kind == LogBlockKind.text);
        if (hasTextResponse) {
          _appendBlock(LogBlockKind.status,
              'Text-only reply — see TEXT block(s) above. No files '
              'to flush.');
          _state = GenerationState.done;
        } else {
          _appendBlock(LogBlockKind.status,
              'No files in the project yet — nothing flushed.');
        }
      }
      _generatedMainPath = null;
      notifyListeners();
      return;
    }
    try {
      final targetDir = p.join(_exampleRoot, _sessionAppName!);
      _fs.flushTo(targetDir);
      if (_fs.read('main.dart') != null) {
        _generatedMainPath = p.join(targetDir, 'main.dart');
        _generatedAppName = _sessionAppName;
      } else {
        _generatedMainPath = null;
      }
      _samplesNotifier.reload();
      // Don't downgrade an error state — only flip to done if the
      // conversation actually ended cleanly.
      if (_state != GenerationState.error) {
        _state = GenerationState.done;
      }
      final files = _fs.listFiles();
      _appendBlock(LogBlockKind.status,
          'Synced ${files.length} file(s) to example/$_sessionAppName/: '
          '${files.join(", ")}.');
      if (_fs.read('main.dart') == null) {
        _appendBlock(LogBlockKind.status,
            'No main.dart yet — keep iterating or write one to enable Run.');
      }
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
