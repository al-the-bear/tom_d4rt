/// Owns the generation pipeline state.
///
/// Responsibilities:
///   - Drive the state machine (idle → sending → streaming → done|error).
///   - Accumulate streamed log entries (thinking, text, status, error).
///   - On stream completion: extract the first ```dart code block and
///     write it to `example/<appName>/main.dart`.
///   - Expose enough to drive the Log tab UI (text panes, run-button
///     enablement, error banners).
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../sample_apps_notifier.dart';
import 'api_client.dart';
import 'prefs_store.dart';
import 'system_prompt.dart';

enum GenerationState { idle, sending, streaming, done, error }

enum LogBlockKind { status, thinking, text, error }

class LogBlock {
  final LogBlockKind kind;
  final String text;
  LogBlock(this.kind, this.text);
}

class GeneratorNotifier extends ChangeNotifier {
  final AnthropicClient _client;
  final SampleAppsNotifier _samplesNotifier;
  final String _exampleRoot;

  GenerationState _state = GenerationState.idle;
  final List<LogBlock> _blocks = <LogBlock>[];
  String _assistantText = '';
  String? _generatedMainPath;
  String? _generatedAppName;
  String? _errorMessage;
  StreamSubscription<GeneratorEvent>? _sub;

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
      _state == GenerationState.sending || _state == GenerationState.streaming;

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
      _state = GenerationState.error;
      _errorMessage = 'App name is empty.';
      _appendBlock(LogBlockKind.error, _errorMessage!);
      notifyListeners();
      return;
    }
    if (description.trim().isEmpty) {
      _state = GenerationState.error;
      _errorMessage = 'Description is empty.';
      _appendBlock(LogBlockKind.error, _errorMessage!);
      notifyListeners();
      return;
    }
    if (prefs.apiKey.trim().isEmpty) {
      _state = GenerationState.error;
      _errorMessage =
          'Anthropic API key is not set — open Settings to enter one.';
      _appendBlock(LogBlockKind.error, _errorMessage!);
      notifyListeners();
      return;
    }

    _blocks.clear();
    _assistantText = '';
    _generatedMainPath = null;
    _generatedAppName = sanitizedName;
    _errorMessage = null;
    _state = GenerationState.sending;
    _appendBlock(LogBlockKind.status,
        'Generating "$sanitizedName" with ${prefs.model.label}…');
    notifyListeners();

    final stream = _client.streamMessage(
      apiKey: prefs.apiKey,
      model: prefs.model.apiId,
      systemPrompt: buildSystemPrompt(),
      userMessage: description,
      extendedThinking: prefs.extendedThinking,
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
        case CompletionEvent():
          _assistantText = event.fullText;
          _finalize(sanitizedName);
        case ErrorEvent():
          _state = GenerationState.error;
          _errorMessage = event.message;
          _appendBlock(LogBlockKind.error, event.message);
      }
      notifyListeners();
    }, onError: (Object e) {
      _state = GenerationState.error;
      _errorMessage = '$e';
      _appendBlock(LogBlockKind.error, '$e');
      notifyListeners();
    });
  }

  Future<void> cancel() async {
    _client.abort();
    await _sub?.cancel();
    _sub = null;
    if (_state == GenerationState.sending ||
        _state == GenerationState.streaming) {
      _state = GenerationState.error;
      _errorMessage = 'Generation cancelled.';
      _appendBlock(LogBlockKind.status, 'Cancelled by user.');
      notifyListeners();
    }
  }

  /// Resets the log/state so the user can start over without leaving
  /// the previous run on screen.
  void clear() {
    _blocks.clear();
    _assistantText = '';
    _generatedMainPath = null;
    _generatedAppName = null;
    _errorMessage = null;
    _state = GenerationState.idle;
    notifyListeners();
  }

  // ── Internals ────────────────────────────────────────────────────────

  void _appendBlock(LogBlockKind kind, String text) {
    _blocks.add(LogBlock(kind, text));
  }

  /// Coalesces adjacent same-kind text/thinking deltas into one block so
  /// the log doesn't fragment into thousands of single-character entries.
  void _appendOrExtend(LogBlockKind kind, String text) {
    if (_blocks.isNotEmpty && _blocks.last.kind == kind) {
      final prev = _blocks.removeLast();
      _blocks.add(LogBlock(kind, '${prev.text}$text'));
    } else {
      _blocks.add(LogBlock(kind, text));
    }
  }

  void _finalize(String appName) {
    final code = _extractDartBlock(_assistantText);
    if (code == null) {
      _state = GenerationState.error;
      _errorMessage =
          'No fenced ```dart block found in the response. Cannot run.';
      _appendBlock(LogBlockKind.error, _errorMessage!);
      return;
    }
    try {
      final dir = Directory(p.join(_exampleRoot, appName));
      dir.createSync(recursive: true);
      final mainFile = File(p.join(dir.path, 'main.dart'));
      mainFile.writeAsStringSync(code);
      _generatedMainPath = mainFile.path;
      _samplesNotifier.reload();
      _state = GenerationState.done;
      _appendBlock(LogBlockKind.status,
          'Wrote ${code.split('\n').length} lines to '
          'example/$appName/main.dart — ready to run.');
    } catch (e) {
      _state = GenerationState.error;
      _errorMessage = 'Failed to write generated file: $e';
      _appendBlock(LogBlockKind.error, _errorMessage!);
    }
  }

  String _sanitizeAppName(String name) {
    final trimmed = name.trim().toLowerCase();
    final sanitized = trimmed.replaceAll(RegExp(r'[^a-z0-9_]+'), '_');
    return sanitized.replaceAll(RegExp(r'^_+|_+$'), '');
  }

  /// Pulls the first ```dart fenced block out of [body]. Returns null
  /// if no such block is found.
  String? _extractDartBlock(String body) {
    final fence = RegExp(r'```dart\s*\n', multiLine: true);
    final start = fence.firstMatch(body);
    if (start == null) return null;
    final after = body.substring(start.end);
    final endIdx = after.indexOf('```');
    if (endIdx < 0) return null;
    return after.substring(0, endIdx).trimRight();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _client.dispose();
    super.dispose();
  }
}
