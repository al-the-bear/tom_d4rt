/// Thin Anthropic Messages API client with SSE streaming.
///
/// Multi-turn: callers pass the full `messages` list (Anthropic's
/// content-block shape) and the available `tools`. The client streams
/// one assistant turn's content blocks (thinking / text / tool_use),
/// emits typed events as it goes, and at end-of-turn returns the
/// reconstructed assistant message via [TurnComplete] so the caller can
/// (a) append it to history before continuing the conversation, and
/// (b) execute any tool calls and feed the results back.
///
/// All event data is plain text — base64 signatures and redacted blocks
/// never leak into user-visible output (they're preserved in the
/// returned assistant message for the next turn, but not yielded).
library;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// A single streamed delta from the Anthropic API.
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

class ToolUseStarted extends GeneratorEvent {
  final String toolUseId;
  final String toolName;
  const ToolUseStarted(this.toolUseId, this.toolName);
}

class ToolUseReady extends GeneratorEvent {
  final String toolUseId;
  final String toolName;
  final Map<String, dynamic> input;
  const ToolUseReady(this.toolUseId, this.toolName, this.input);
}

/// Emitted when one streamed assistant turn ends. Carries:
///   - [assistantContent]: the full Anthropic-shaped content-block list
///     (thinking, redacted_thinking, text, tool_use) ready to be
///     appended verbatim to `messages` for the next turn.
///   - [textBuffer]: a flat concatenation of every `text` block for
///     display.
///   - [toolUses]: the tool calls the model made this turn (same data
///     as embedded in [assistantContent], hoisted for convenience).
///   - [stopReason]: `end_turn`, `tool_use`, `max_tokens`, `stop_sequence`.
class TurnComplete extends GeneratorEvent {
  final List<Map<String, dynamic>> assistantContent;
  final String textBuffer;
  final List<ToolUseBlock> toolUses;
  final String? stopReason;
  const TurnComplete({
    required this.assistantContent,
    required this.textBuffer,
    required this.toolUses,
    required this.stopReason,
  });
}

class ErrorEvent extends GeneratorEvent {
  final String message;
  const ErrorEvent(this.message);
}

class ToolUseBlock {
  final String id;
  final String name;
  final Map<String, dynamic> input;
  const ToolUseBlock(this.id, this.name, this.input);
}

/// Internal builder for one in-flight assistant content block. We
/// keep the raw `delta` payloads on [thinking] and [text] blocks so
/// the next turn can replay the FULL block (including signature) back
/// to the API.
class _BlockBuilder {
  final String type;
  final String? id;
  final String? name;
  final StringBuffer thinkingText = StringBuffer();
  String? thinkingSignature;
  final StringBuffer responseText = StringBuffer();
  final StringBuffer toolInputJson = StringBuffer();
  String? redactedData;

  _BlockBuilder(this.type, {this.id, this.name, this.redactedData});

  /// Materialise this block back into the Anthropic content-block shape
  /// (the same JSON the API would have sent for this block — including
  /// the thinking signature so the API accepts it on a continuation
  /// turn).
  Map<String, dynamic> toContentBlock() {
    switch (type) {
      case 'thinking':
        return {
          'type': 'thinking',
          'thinking': thinkingText.toString(),
          if (thinkingSignature != null) 'signature': thinkingSignature,
        };
      case 'redacted_thinking':
        return {
          'type': 'redacted_thinking',
          if (redactedData != null) 'data': redactedData,
        };
      case 'text':
        return {
          'type': 'text',
          'text': responseText.toString(),
        };
      case 'tool_use':
        Map<String, dynamic> input;
        try {
          input = toolInputJson.isEmpty
              ? <String, dynamic>{}
              : jsonDecode(toolInputJson.toString()) as Map<String, dynamic>;
        } catch (_) {
          input = <String, dynamic>{};
        }
        return {
          'type': 'tool_use',
          'id': id,
          'name': name,
          'input': input,
        };
      default:
        return {'type': type};
    }
  }
}

class AnthropicClient {
  static const _endpoint = 'https://api.anthropic.com/v1/messages';
  static const _apiVersion = '2023-06-01';

  final http.Client _httpClient;
  http.Client? _activeRequestClient;

  AnthropicClient({http.Client? client})
      : _httpClient = client ?? http.Client();

  /// Streams ONE assistant turn. Caller is expected to consume the
  /// stream end-to-end and dispose any cancellation via [abort]. The
  /// stream completes after [TurnComplete] is emitted (or [ErrorEvent]).
  Stream<GeneratorEvent> streamTurn({
    required String apiKey,
    required String model,
    required String systemPrompt,
    required List<Map<String, dynamic>> messages,
    List<Map<String, dynamic>> tools = const [],
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
      'messages': messages,
      'stream': true,
    };
    if (tools.isNotEmpty) {
      body['tools'] = tools;
    }
    if (extendedThinking) {
      // Opus 4.7+ adaptive thinking.
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

    // Per-turn accumulators.
    final blocks = <int, _BlockBuilder>{};
    String? stopReason;
    final textBuffer = StringBuffer();
    final eventBuffer = StringBuffer();

    try {
      await for (final line in response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        if (line.isEmpty) {
          final raw = eventBuffer.toString();
          eventBuffer.clear();
          if (raw.isEmpty) continue;
          await for (final out in _parseEvent(raw, blocks, textBuffer,
              (sr) => stopReason = sr)) {
            yield out;
          }
        } else {
          eventBuffer.writeln(line);
        }
      }
      final tail = eventBuffer.toString();
      if (tail.isNotEmpty) {
        await for (final out in _parseEvent(
            tail, blocks, textBuffer, (sr) => stopReason = sr)) {
          yield out;
        }
      }
    } catch (e) {
      yield ErrorEvent('Stream read failed: $e');
      return;
    }

    // Sort blocks by index so we hand them back in arrival order.
    final ordered = blocks.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final assistantContent = <Map<String, dynamic>>[];
    final toolUses = <ToolUseBlock>[];
    for (final entry in ordered) {
      final b = entry.value;
      final block = b.toContentBlock();
      assistantContent.add(block);
      if (b.type == 'tool_use') {
        final input = block['input'] as Map<String, dynamic>? ??
            <String, dynamic>{};
        toolUses.add(ToolUseBlock(b.id ?? '', b.name ?? '', input));
      }
    }

    yield TurnComplete(
      assistantContent: assistantContent,
      textBuffer: textBuffer.toString(),
      toolUses: toolUses,
      stopReason: stopReason,
    );
  }

  Stream<GeneratorEvent> _parseEvent(
    String rawEvent,
    Map<int, _BlockBuilder> blocks,
    StringBuffer textBuffer,
    void Function(String) setStopReason,
  ) async* {
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
      return;
    }
    final type = payload['type'] as String?;
    switch (type) {
      case 'content_block_start':
        final idx = payload['index'] as int?;
        if (idx == null) break;
        final block = payload['content_block'] as Map<String, dynamic>?;
        final blockType = block?['type']?.toString() ?? 'unknown';
        final builder = _BlockBuilder(
          blockType,
          id: block?['id']?.toString(),
          name: block?['name']?.toString(),
          redactedData: block?['data']?.toString(),
        );
        blocks[idx] = builder;
        debugPrint('[anthropic] content_block_start idx=$idx '
            'type=$blockType${builder.name != null ? " name=${builder.name}" : ""}');
        if (blockType == 'tool_use') {
          yield ToolUseStarted(builder.id ?? '?', builder.name ?? '?');
        } else if (blockType == 'redacted_thinking') {
          yield const StatusEvent(
              'Redacted thinking block (encrypted by Anthropic, not '
              'shown).');
        }
        // For thinking + text blocks we no longer emit a status placeholder
        // — the actual streamed content fills its own log block. If the
        // model produces no content for the block, we surface that
        // explicitly at content_block_stop.
        break;

      case 'content_block_delta':
        final idx = payload['index'] as int?;
        if (idx == null) break;
        final builder = blocks[idx];
        if (builder == null) break;
        final delta = payload['delta'] as Map<String, dynamic>?;
        if (delta == null) break;
        final deltaType = delta['type'] as String?;
        switch (deltaType) {
          case 'thinking_delta':
            final t = delta['thinking'] as String? ?? '';
            if (t.isNotEmpty) {
              builder.thinkingText.write(t);
              debugPrint('[anthropic] thinking_delta (${t.length}c)');
              yield ThinkingDelta(t);
            }
          case 'signature_delta':
            // Base64 signature for the thinking block — preserve on the
            // builder so the next turn can replay it, but DO NOT show.
            final sig = delta['signature'] as String?;
            if (sig != null && sig.isNotEmpty) {
              builder.thinkingSignature = sig;
            }
          case 'text_delta':
            final t = delta['text'] as String? ?? '';
            if (t.isNotEmpty) {
              builder.responseText.write(t);
              textBuffer.write(t);
              debugPrint('[anthropic] text_delta (${t.length}c): '
                  '${_preview(t, 80)}');
              yield TextDelta(t);
            }
          case 'input_json_delta':
            // Streaming JSON for a tool_use block's input. Accumulate
            // raw — we'll parse it once at content_block_stop.
            final partial = delta['partial_json'] as String? ?? '';
            if (partial.isNotEmpty) builder.toolInputJson.write(partial);
          default:
            debugPrint('[anthropic] unhandled delta type=$deltaType '
                'keys=${delta.keys.toList()}');
        }
        break;

      case 'content_block_stop':
        final idx = payload['index'] as int?;
        if (idx == null) break;
        final builder = blocks[idx];
        if (builder == null) break;
        debugPrint('[anthropic] content_block_stop idx=$idx '
            'type=${builder.type} '
            'thinkingChars=${builder.thinkingText.length} '
            'textChars=${builder.responseText.length}');
        if (builder.type == 'thinking' && builder.thinkingText.isEmpty) {
          // Adaptive thinking + low-effort sometimes opens a thinking
          // block without streaming any visible content. Make that
          // explicit so the log doesn't look broken.
          yield const StatusEvent(
              '(Model opened a thinking block but produced no streamable '
              'content — it thought silently this turn.)');
        }
        if (builder.type == 'tool_use') {
          // Finalise input JSON and emit a ready event for the caller.
          Map<String, dynamic> input;
          try {
            input = builder.toolInputJson.isEmpty
                ? <String, dynamic>{}
                : jsonDecode(builder.toolInputJson.toString())
                    as Map<String, dynamic>;
          } catch (e) {
            input = <String, dynamic>{};
            debugPrint('[anthropic] failed to parse tool_use input JSON: $e '
                'raw=${builder.toolInputJson}');
          }
          yield ToolUseReady(builder.id ?? '?', builder.name ?? '?', input);
        }
        break;

      case 'message_start':
        debugPrint('[anthropic] message_start');
        break;
      case 'message_delta':
        final delta = payload['delta'] as Map<String, dynamic>?;
        final sr = delta?['stop_reason']?.toString();
        if (sr != null) {
          setStopReason(sr);
          debugPrint('[anthropic] message_delta stop_reason=$sr');
          yield StatusEvent('Stop reason: $sr');
        }
        break;
      case 'message_stop':
        debugPrint('[anthropic] message_stop');
        break;
      case 'ping':
        break;
      case 'error':
        final msg =
            (payload['error'] as Map?)?['message'] ?? 'Unknown error';
        debugPrint('[anthropic] error: $msg');
        yield ErrorEvent('API error: $msg');
        break;
      default:
        debugPrint('[anthropic] unknown event type=$type '
            'keys=${payload.keys.toList()}');
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

  void abort() {
    _activeRequestClient?.close();
    _activeRequestClient = null;
  }

  void dispose() {
    _httpClient.close();
  }
}
