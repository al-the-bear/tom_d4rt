/// Thin Anthropic Messages API client with SSE streaming.
///
/// Speaks just enough of the wire protocol to:
///   - send a single user message with a system prompt,
///   - optionally enable extended thinking,
///   - parse the server-sent-events stream and emit typed deltas.
///
/// No dependencies beyond `package:http` and `dart:convert`.
library;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// A single streamed delta from the Anthropic API.
///
/// `kind` is the high-level event class:
///   - `thinking` — extended-thinking content (only when enabled)
///   - `text`     — assistant text output
///   - `status`   — informational status line (e.g. "Awaiting response…")
///   - `error`    — fatal, generation aborted
sealed class GeneratorEvent {
  const GeneratorEvent();
}

class StatusEvent extends GeneratorEvent {
  final String message;
  const StatusEvent(this.message);
}

class ThinkingDelta extends GeneratorEvent {
  final String text;
  const ThinkingDelta(this.text);
}

class TextDelta extends GeneratorEvent {
  final String text;
  const TextDelta(this.text);
}

class CompletionEvent extends GeneratorEvent {
  /// Final concatenated assistant text (all text blocks joined).
  final String fullText;
  const CompletionEvent(this.fullText);
}

class ErrorEvent extends GeneratorEvent {
  final String message;
  const ErrorEvent(this.message);
}

class AnthropicClient {
  static const _endpoint = 'https://api.anthropic.com/v1/messages';
  static const _apiVersion = '2023-06-01';

  final http.Client _httpClient;
  http.Client? _activeRequestClient;

  AnthropicClient({http.Client? client})
      : _httpClient = client ?? http.Client();

  /// Streams a single-turn message generation as a sequence of typed
  /// events. The stream completes when the API closes the SSE stream
  /// (after `message_stop`) or when an error occurs.
  ///
  /// Caller is expected to consume the stream end-to-end and dispose
  /// any cancellation via [abort].
  Stream<GeneratorEvent> streamMessage({
    required String apiKey,
    required String model,
    required String systemPrompt,
    required String userMessage,
    int maxTokens = 16000,
    bool extendedThinking = true,
    String thinkingEffort = 'high',
  }) async* {
    if (apiKey.trim().isEmpty) {
      yield const ErrorEvent('Anthropic API key is empty.');
      return;
    }

    yield const StatusEvent('Connecting to Anthropic API…');

    final body = <String, dynamic>{
      'model': model,
      'max_tokens': maxTokens,
      'system': systemPrompt,
      'messages': [
        {
          'role': 'user',
          'content': userMessage,
        }
      ],
      'stream': true,
    };
    if (extendedThinking) {
      // Opus 4.7+ requires the `adaptive` thinking type — the older
      // `{type: enabled, budget_tokens: N}` shape is rejected with
      // "thinking.type.enabled is not supported for this model".
      // Thinking depth is now controlled via `output_config.effort`
      // (low | medium | high). When extended thinking is enabled,
      // temperature must default — the API rejects custom values.
      body['thinking'] = {'type': 'adaptive'};
      body['output_config'] = {'effort': thinkingEffort};
    }

    final request = http.Request('POST', Uri.parse(_endpoint));
    request.headers.addAll({
      'x-api-key': apiKey,
      'anthropic-version': _apiVersion,
      'content-type': 'application/json',
      'accept': 'text/event-stream',
    });
    request.body = jsonEncode(body);

    _activeRequestClient = _httpClient;
    http.StreamedResponse response;
    try {
      response = await _httpClient.send(request);
    } catch (e) {
      yield ErrorEvent('Connection failed: $e');
      return;
    }

    if (response.statusCode != 200) {
      final errorText = await response.stream.bytesToString();
      yield ErrorEvent(
          'HTTP ${response.statusCode}: ${_extractApiError(errorText)}');
      return;
    }

    yield const StatusEvent('Streaming response…');

    final buffer = StringBuffer();
    final assistantText = StringBuffer();

    // SSE: events are blank-line-separated; within an event, lines start
    // with `event:` and `data:` keys. We emit deltas as they arrive.
    try {
      await for (final line in response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        if (line.isEmpty) {
          // End of event — process the accumulated buffer.
          final event = buffer.toString();
          buffer.clear();
          if (event.isEmpty) continue;
          await for (final out in _parseEvent(event, assistantText)) {
            yield out;
          }
        } else {
          buffer.writeln(line);
        }
      }
      // Flush any trailing event without a terminator.
      final tail = buffer.toString();
      if (tail.isNotEmpty) {
        await for (final out in _parseEvent(tail, assistantText)) {
          yield out;
        }
      }
    } catch (e) {
      yield ErrorEvent('Stream read failed: $e');
      return;
    }

    yield CompletionEvent(assistantText.toString());
  }

  Stream<GeneratorEvent> _parseEvent(
      String rawEvent, StringBuffer assistantText) async* {
    String? dataLine;
    for (final line in rawEvent.split('\n')) {
      if (line.startsWith('data:')) {
        dataLine = line.substring(5).trim();
      }
    }
    if (dataLine == null || dataLine.isEmpty) return;
    if (dataLine == '[DONE]') return;

    Map<String, dynamic> payload;
    try {
      payload = jsonDecode(dataLine) as Map<String, dynamic>;
    } catch (_) {
      debugPrint('[anthropic] non-JSON SSE data: $dataLine');
      return; // Ignore non-JSON keepalives.
    }
    final type = payload['type'] as String?;
    switch (type) {
      case 'content_block_delta':
        final delta = payload['delta'] as Map<String, dynamic>?;
        if (delta == null) return;
        final deltaType = delta['type'] as String?;
        if (deltaType == 'thinking_delta') {
          final t = delta['thinking'] as String? ?? '';
          if (t.isNotEmpty) {
            debugPrint('[anthropic] thinking_delta (${t.length}c)');
            yield ThinkingDelta(t);
          }
        } else if (deltaType == 'text_delta') {
          final t = delta['text'] as String? ?? '';
          if (t.isNotEmpty) {
            debugPrint('[anthropic] text_delta (${t.length}c): '
                '${_preview(t, 80)}');
            assistantText.write(t);
            yield TextDelta(t);
          }
        } else {
          debugPrint('[anthropic] unhandled delta type=$deltaType '
              'payload=$delta');
          yield StatusEvent('Skipping unhandled delta type: $deltaType');
        }
        break;
      case 'message_start':
        debugPrint('[anthropic] message_start');
        break;
      case 'content_block_start':
        final block = payload['content_block'] as Map<String, dynamic>?;
        final blockType = block?['type']?.toString() ?? '?';
        debugPrint('[anthropic] content_block_start type=$blockType');
        yield StatusEvent('Receiving $blockType block…');
        break;
      case 'content_block_stop':
        debugPrint('[anthropic] content_block_stop');
        break;
      case 'message_delta':
        final stopReason =
            (payload['delta'] as Map?)?['stop_reason']?.toString();
        if (stopReason != null) {
          debugPrint('[anthropic] message_delta stop_reason=$stopReason');
          yield StatusEvent('Stop reason: $stopReason');
        }
        break;
      case 'message_stop':
        debugPrint('[anthropic] message_stop');
        break;
      case 'ping':
        // No-op: keepalive.
        break;
      case 'error':
        final msg = (payload['error'] as Map?)?['message'] ?? 'Unknown error';
        debugPrint('[anthropic] error: $msg');
        yield ErrorEvent('API error: $msg');
        break;
      default:
        debugPrint('[anthropic] unknown event type=$type payload=$payload');
        yield StatusEvent('Unknown SSE event: $type');
    }
  }

  static String _preview(String s, int n) {
    final flat = s.replaceAll('\n', ' ');
    return flat.length <= n ? flat : '${flat.substring(0, n)}…';
  }

  String _extractApiError(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map && decoded['error'] is Map) {
        final err = decoded['error'] as Map;
        return err['message']?.toString() ?? body;
      }
    } catch (_) {}
    return body.length > 500 ? '${body.substring(0, 500)}…' : body;
  }

  /// Best-effort abort of the in-flight request. The current `http.Client`
  /// implementation doesn't expose cancellation, so we close the client —
  /// the streamed body will surface as a read error.
  void abort() {
    _activeRequestClient?.close();
    _activeRequestClient = null;
  }

  void dispose() {
    _httpClient.close();
  }
}
