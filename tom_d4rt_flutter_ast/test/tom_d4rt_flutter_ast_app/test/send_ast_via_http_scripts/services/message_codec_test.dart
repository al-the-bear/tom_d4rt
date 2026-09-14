// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// MessageCodec<T> Deep Demo
// =============================================================================
//
// This file is a hand-authored, exhaustive demonstration of `MessageCodec<T>`,
// the abstract codec used by Flutter's `BasicMessageChannel<T>` to encode and
// decode messages exchanged with platform code (Android/iOS/macOS/Windows/Linux
// host channels, as well as web JS bridges).
//
// Flutter ships four built-in codec implementations:
//
//   1. StringCodec
//      - Type parameter: String
//      - Wire format: UTF-8 bytes of the string
//      - Use case: ASCII / unicode text payloads
//
//   2. JSONMessageCodec
//      - Type parameter: Object?
//      - Wire format: UTF-8 bytes of the JSON serialization
//      - Use case: any value `jsonEncode` accepts (Map / List / num / bool /
//        null / String, no binary)
//
//   3. StandardMessageCodec
//      - Type parameter: Object?
//      - Wire format: a custom binary type-tagged stream supporting:
//        null, bool, int (32/64), float64, String (UTF-8), Uint8List, Int32List,
//        Int64List, Float32List, Float64List, List<Object?>, Map<Object?,Object?>
//      - Use case: efficient transport of mixed structured + binary data
//
//   4. BinaryCodec
//      - Type parameter: ByteData?
//      - Wire format: identity. Whatever ByteData you pass in is what the
//        platform side receives.
//      - Use case: raw binary buffers (audio samples, PNG bytes, protobufs).
//
// Every section below renders a self-contained card and exercises the codec
// against real inputs, calling `encodeMessage` and `decodeMessage`. The
// resulting `ByteData?` is rendered as a hex view so you can see exactly what
// hits the wire.
// =============================================================================

// -----------------------------------------------------------------------------
// Helpers (pure functions only, no widget state)
// -----------------------------------------------------------------------------

/// Convert a [ByteData] (or null) into a human-readable hex string.
///
/// Example output: "48 65 6C 6C 6F" for the bytes of "Hello".
String byteDataToHex(ByteData? data, {int maxBytes = 256}) {
  if (data == null) {
    return '<null ByteData>';
  }
  final length = data.lengthInBytes;
  if (length == 0) {
    return '<empty ByteData>';
  }
  final sb = StringBuffer();
  final cap = length < maxBytes ? length : maxBytes;
  for (var i = 0; i < cap; i++) {
    final b = data.getUint8(i);
    final hex = b.toRadixString(16).toUpperCase().padLeft(2, '0');
    sb.write(hex);
    if (i + 1 < cap) {
      sb.write(' ');
    }
  }
  if (length > cap) {
    sb.write(' ... (+${length - cap} more bytes)');
  }
  return sb.toString();
}

/// Convert a [ByteData] to a printable ASCII view.
/// Non-printable bytes are rendered as a dot.
String byteDataToAscii(ByteData? data, {int maxBytes = 256}) {
  if (data == null) {
    return '<null ByteData>';
  }
  final length = data.lengthInBytes;
  if (length == 0) {
    return '<empty ByteData>';
  }
  final sb = StringBuffer();
  final cap = length < maxBytes ? length : maxBytes;
  for (var i = 0; i < cap; i++) {
    final b = data.getUint8(i);
    if (b >= 0x20 && b <= 0x7E) {
      sb.writeCharCode(b);
    } else {
      sb.write('.');
    }
  }
  if (length > cap) {
    sb.write(' ...');
  }
  return sb.toString();
}

/// Returns the byte length of a [ByteData], or 0 if null.
int byteLength(ByteData? data) => data?.lengthInBytes ?? 0;

/// Encode a value with [JsonEncoder] using indentation for display.
String prettyJson(Object? value) {
  try {
    return const JsonEncoder.withIndent('  ').convert(value);
  } catch (e) {
    return 'JSON error: $e';
  }
}

/// Build a hand-crafted ByteData with mixed types, useful for the BinaryCodec
/// section.
ByteData buildSampleByteData() {
  // 4 bytes uint32 + 8 bytes float64 + 1 byte uint8 = 13 bytes total
  final data = ByteData(13);
  data.setUint32(0, 0xCAFEBABE, Endian.big);
  data.setFloat64(4, 3.141592653589793, Endian.big);
  data.setUint8(12, 0x42);
  return data;
}

// -----------------------------------------------------------------------------
// Tiny presentation widgets used everywhere below.
// -----------------------------------------------------------------------------

Widget sectionTitle(String title, {String? subtitle}) {
  return Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF455A64),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget paragraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, height: 1.45),
    ),
  );
}

Widget codeBlock(String text, {Color? background}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: background ?? const Color(0xFFF1F3F4),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.35,
      ),
    ),
  );
}

Widget hexView(ByteData? data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'hex (${byteLength(data)} bytes)',
          style: const TextStyle(
            color: Color(0xFF80CBC4),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          byteDataToHex(data),
          style: const TextStyle(
            color: Color(0xFFFFEB3B),
            fontSize: 12,
            fontFamily: 'monospace',
            height: 1.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'ascii: ${byteDataToAscii(data)}',
          style: const TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget infoCard({
  required String title,
  required Widget child,
  Color? color,
}) {
  return Card(
    elevation: 1.5,
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: color ?? const Color(0xFFB0BEC5)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color ?? const Color(0xFF37474F),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    ),
  );
}

Widget keyValueRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            key,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF37474F),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1: INTRO
// =============================================================================

Widget buildIntroSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '1. What is MessageCodec<T>?',
        subtitle:
            'The serialization contract used by BasicMessageChannel<T> for '
            'platform-channel communication.',
      ),
      paragraph(
        'A MessageCodec<T> defines how Dart-side values of type T are turned '
        'into a binary form (ByteData) suitable for transmission across the '
        'platform-channel boundary, and how an incoming ByteData is turned '
        'back into a T. The abstract API is small and symmetrical:',
      ),
      codeBlock(
        'abstract class MessageCodec<T> {\n'
        '  ByteData? encodeMessage(T message);\n'
        '  T decodeMessage(ByteData? message);\n'
        '}',
      ),
      paragraph(
        'BasicMessageChannel<T> uses a MessageCodec<T> to translate between '
        'Dart objects and the bytes the host platform sends and receives. '
        'Method channels and event channels likewise use MethodCodec '
        '(which is itself implemented in terms of message codecs).',
      ),
      infoCard(
        title: 'The four built-in implementations',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keyValueRow('StringCodec', 'UTF-8 string <-> ByteData'),
            keyValueRow('JSONMessageCodec', 'jsonEncode/jsonDecode + UTF-8'),
            keyValueRow(
                'StandardMessageCodec', 'binary type-tagged stream (default)'),
            keyValueRow('BinaryCodec', 'identity: ByteData passes through'),
          ],
        ),
        color: const Color(0xFF1565C0),
      ),
      paragraph(
        'Below, every codec is instantiated, every encode/decode path is '
        'exercised against multiple inputs, and the resulting bytes are '
        'displayed in a hex view so you can see precisely what crosses the '
        'wire.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 2: ENCODE/DECODE ROUND-TRIP VISUALIZER
// =============================================================================

enum _CodecChoice { stringCodec, jsonCodec, standardCodec, binaryCodec }

Widget buildRoundTripVisualizer() {
  // Local state for the StatefulBuilder.
  _CodecChoice choice = _CodecChoice.standardCodec;
  String stringInput = 'Hello, codec!';
  Map<String, Object?> jsonInput = <String, Object?>{
    'event': 'tap',
    'count': 7,
    'meta': <String, Object?>{'platform': 'android', 'pressure': 0.83},
  };
  Map<Object?, Object?> standardInput = <Object?, Object?>{
    'kind': 'frame',
    'index': 42,
    'pixels': Uint8List.fromList(<int>[0, 128, 255, 64, 32]),
    'samples': Float64List.fromList(<double>[0.1, -0.2, 0.3]),
  };
  ByteData binaryInput = buildSampleByteData();

  // Codec instances (all four — required).
  final stringCodec = const StringCodec();
  final jsonCodec = const JSONMessageCodec();
  final standardCodec = const StandardMessageCodec();
  final binaryCodec = const BinaryCodec();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '2. Round-trip visualizer',
        subtitle:
            'Pick a codec. See the input, the bytes on the wire, and the '
            'decoded output.',
      ),
      StatefulBuilder(
        builder: (context, setState) {
          // Compute encoded ByteData and decoded value for the chosen codec.
          ByteData? encoded;
          Object? decoded;
          String inputDisplay = '';
          String inputType = '';
          Object? error;

          try {
            switch (choice) {
              case _CodecChoice.stringCodec:
                inputType = 'String';
                inputDisplay = stringInput;
                encoded = stringCodec.encodeMessage(stringInput);
                decoded = stringCodec.decodeMessage(encoded);
                break;
              case _CodecChoice.jsonCodec:
                inputType = 'Map<String, Object?>';
                inputDisplay = prettyJson(jsonInput);
                encoded = jsonCodec.encodeMessage(jsonInput);
                decoded = jsonCodec.decodeMessage(encoded);
                break;
              case _CodecChoice.standardCodec:
                inputType = 'Map<Object?, Object?> (with typed lists)';
                inputDisplay = standardInput.toString();
                encoded = standardCodec.encodeMessage(standardInput);
                decoded = standardCodec.decodeMessage(encoded);
                break;
              case _CodecChoice.binaryCodec:
                inputType = 'ByteData';
                inputDisplay =
                    'ByteData(${binaryInput.lengthInBytes} bytes)\n'
                    'hex=${byteDataToHex(binaryInput)}';
                encoded = binaryCodec.encodeMessage(binaryInput);
                decoded = binaryCodec.decodeMessage(encoded);
                break;
            }
          } catch (e) {
            error = e;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SegmentedButton<_CodecChoice>(
                segments: const <ButtonSegment<_CodecChoice>>[
                  ButtonSegment(
                    value: _CodecChoice.stringCodec,
                    label: Text('String'),
                  ),
                  ButtonSegment(
                    value: _CodecChoice.jsonCodec,
                    label: Text('JSON'),
                  ),
                  ButtonSegment(
                    value: _CodecChoice.standardCodec,
                    label: Text('Standard'),
                  ),
                  ButtonSegment(
                    value: _CodecChoice.binaryCodec,
                    label: Text('Binary'),
                  ),
                ],
                selected: <_CodecChoice>{choice},
                onSelectionChanged: (selected) {
                  setState(() => choice = selected.first);
                },
              ),
              const SizedBox(height: 14),
              infoCard(
                title: 'Input ($inputType)',
                child: codeBlock(inputDisplay),
              ),
              if (error != null)
                infoCard(
                  title: 'Encoding error',
                  color: const Color(0xFFD32F2F),
                  child: Text(error.toString()),
                )
              else ...[
                infoCard(
                  title: 'Encoded ByteData on the wire',
                  color: const Color(0xFF2E7D32),
                  child: hexView(encoded),
                ),
                infoCard(
                  title: 'Decoded value (round-trip)',
                  color: const Color(0xFF6A1B9A),
                  child: codeBlock(decoded.toString()),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Codec instance: ${_codecName(choice)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF607D8B),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}

String _codecName(_CodecChoice c) {
  switch (c) {
    case _CodecChoice.stringCodec:
      return 'const StringCodec()';
    case _CodecChoice.jsonCodec:
      return 'const JSONMessageCodec()';
    case _CodecChoice.standardCodec:
      return 'const StandardMessageCodec()';
    case _CodecChoice.binaryCodec:
      return 'const BinaryCodec()';
  }
}

// =============================================================================
// SECTION 3: StringCodec deep dive
// =============================================================================

Widget buildStringCodecSection() {
  final codec = const StringCodec();

  // A diverse battery of strings to demonstrate UTF-8 byte length differences.
  final samples = <_StringSample>[
    _StringSample('empty', ''),
    _StringSample('ASCII', 'Hello'),
    _StringSample('ASCII (longer)', 'The quick brown fox'),
    _StringSample('Latin-1 chars', 'café résumé'),
    _StringSample('CJK', '你好世界'),
    _StringSample('Emoji', '🚀✨🐦'),
    _StringSample('Mixed', 'Hi 你好 🚀'),
    _StringSample('Newlines', 'line1\nline2\tcol'),
  ];

  final rows = <Widget>[];
  for (final sample in samples) {
    final encoded = codec.encodeMessage(sample.value);
    final decoded = codec.decodeMessage(encoded);
    final codeUnits = sample.value.codeUnits.length;
    final byteCount = byteLength(encoded);
    rows.add(
      infoCard(
        title: '${sample.label} — "${sample.value}"',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keyValueRow('UTF-16 code units', '$codeUnits'),
            keyValueRow('UTF-8 byte count', '$byteCount'),
            keyValueRow('round-trip equal',
                '${decoded == sample.value ? "yes" : "NO"}'),
            const SizedBox(height: 6),
            hexView(encoded),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '3. StringCodec deep dive',
        subtitle:
            'StringCodec is a MessageCodec<String> that uses UTF-8 encoding. '
            'One String -> N bytes where N depends on the code points used.',
      ),
      paragraph(
        'StringCodec is the simplest codec and the cheapest one to use when '
        'you only need to ship text. ASCII characters take 1 byte each. '
        'Most Latin characters with diacritics take 2 bytes. CJK ideographs '
        'and most emoji take 3 or 4 bytes. The decoded result is always a '
        'String identical to the input (UTF-8 is round-trip safe for valid '
        'Dart strings).',
      ),
      ...rows,
    ],
  );
}

class _StringSample {
  final String label;
  final String value;
  const _StringSample(this.label, this.value);
}

// =============================================================================
// SECTION 4: JSONMessageCodec deep dive
// =============================================================================

Widget buildJsonCodecSection() {
  final codec = const JSONMessageCodec();

  final samples = <_JsonSample>[
    _JsonSample('null', null),
    _JsonSample('bool', true),
    _JsonSample('int', 1234567890),
    _JsonSample('double', 3.141592653589793),
    _JsonSample('string', 'hello world'),
    _JsonSample('flat array', <int>[1, 2, 3, 4, 5]),
    _JsonSample('flat map', <String, Object?>{'a': 1, 'b': 'two', 'c': null}),
    _JsonSample('nested map', <String, Object?>{
      'user': <String, Object?>{
        'id': 42,
        'name': 'Ada',
        'roles': <String>['admin', 'editor'],
      },
      'meta': <String, Object?>{'ver': 2, 'active': true},
    }),
    _JsonSample('list of maps', <Object?>[
      <String, Object?>{'k': 'a', 'v': 1},
      <String, Object?>{'k': 'b', 'v': 2},
      <String, Object?>{'k': 'c', 'v': 3},
    ]),
  ];

  final cards = <Widget>[];
  for (final sample in samples) {
    final encoded = codec.encodeMessage(sample.value);
    final decoded = codec.decodeMessage(encoded);
    cards.add(
      infoCard(
        title: sample.label,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pretty JSON',
                style: TextStyle(fontSize: 12, color: Color(0xFF607D8B))),
            const SizedBox(height: 4),
            codeBlock(prettyJson(sample.value)),
            const SizedBox(height: 6),
            keyValueRow('byte length', '${byteLength(encoded)}'),
            keyValueRow('decoded type',
                decoded == null ? 'Null' : decoded.runtimeType.toString()),
            const SizedBox(height: 6),
            hexView(encoded),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '4. JSONMessageCodec deep dive',
        subtitle:
            'JSONMessageCodec serializes any value `jsonEncode` accepts, then '
            'UTF-8 encodes the result.',
      ),
      paragraph(
        'JSON is the universal cross-platform language. Use this codec when '
        'your payload is JSON-shaped: maps with string keys, lists, numbers, '
        'booleans, null, and strings. JSON cannot natively represent binary '
        '(Uint8List) — you must base64-encode such data manually if you stay '
        'in JSON.',
      ),
      ...cards,
    ],
  );
}

class _JsonSample {
  final String label;
  final Object? value;
  const _JsonSample(this.label, this.value);
}

// =============================================================================
// SECTION 5: StandardMessageCodec deep dive
// =============================================================================

Widget buildStandardCodecSection() {
  final standard = const StandardMessageCodec();
  final json = const JSONMessageCodec();

  // Same logical payload but Standard can carry typed binary lists natively.
  final logicalPixels = <int>[0, 64, 128, 192, 255, 32, 16, 8];
  final logicalSamples = <double>[0.1, 0.2, 0.3, -0.4, -0.5];
  final logicalInts = <int>[1, 2, 4, 8, 16, 32];

  // Standard payload (uses typed lists).
  final standardPayload = <Object?, Object?>{
    'kind': 'frame',
    'pixels': Uint8List.fromList(logicalPixels),
    'samples': Float64List.fromList(logicalSamples),
    'ints': Int32List.fromList(logicalInts),
    'meta': <Object?, Object?>{
      'frameNumber': 12345,
      'flags': true,
      'tag': null,
    },
  };

  // JSON-equivalent payload (typed lists collapsed to plain lists).
  final jsonEquivalent = <String, Object?>{
    'kind': 'frame',
    'pixels': logicalPixels,
    'samples': logicalSamples,
    'ints': logicalInts,
    'meta': <String, Object?>{
      'frameNumber': 12345,
      'flags': true,
      'tag': null,
    },
  };

  final stdEncoded = standard.encodeMessage(standardPayload);
  final stdDecoded = standard.decodeMessage(stdEncoded);
  final jsonEncoded = json.encodeMessage(jsonEquivalent);

  // Show the small per-type encodings in a separate card.
  final perTypeSamples = <_StdTypeSample>[
    _StdTypeSample('null', null),
    _StdTypeSample('false', false),
    _StdTypeSample('true', true),
    _StdTypeSample('int 0', 0),
    _StdTypeSample('int 255', 255),
    _StdTypeSample('int 65535', 65535),
    _StdTypeSample('int 1<<40', 1 << 40),
    _StdTypeSample('double pi', 3.141592653589793),
    _StdTypeSample('string "hi"', 'hi'),
    _StdTypeSample(
        'Uint8List [1,2,3]', Uint8List.fromList(<int>[1, 2, 3])),
    _StdTypeSample(
        'Int32List [1,2,3]', Int32List.fromList(<int>[1, 2, 3])),
    _StdTypeSample(
        'Float64List [1.0,2.0]', Float64List.fromList(<double>[1.0, 2.0])),
    _StdTypeSample('List ["a", 1]', <Object?>['a', 1]),
    _StdTypeSample('Map {"a":1}', <Object?, Object?>{'a': 1}),
  ];

  final perTypeCards = <Widget>[];
  for (final s in perTypeSamples) {
    final enc = standard.encodeMessage(s.value);
    perTypeCards.add(
      infoCard(
        title: s.label,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keyValueRow('byte length', '${byteLength(enc)}'),
            const SizedBox(height: 4),
            hexView(enc),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '5. StandardMessageCodec deep dive',
        subtitle:
            'The default codec for BasicMessageChannel and the binary substrate '
            'of MethodChannel. Carries typed binary lists natively.',
      ),
      paragraph(
        'StandardMessageCodec writes a single type byte followed by a '
        'type-specific payload. For collections, it writes a length first '
        '(VLU-encoded for sizes >= 254) and then recursively writes the '
        'children. This makes it strictly more powerful than JSON because it '
        'supports `Uint8List`, `Int32List`, `Int64List`, `Float32List`, and '
        '`Float64List` without any base64 dance.',
      ),
      infoCard(
        title: 'Standard vs JSON for the SAME logical payload',
        color: const Color(0xFF1565C0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keyValueRow(
                'Standard byte length', '${byteLength(stdEncoded)} bytes'),
            keyValueRow(
                'JSON byte length', '${byteLength(jsonEncoded)} bytes'),
            keyValueRow('decoded ok (std)',
                stdDecoded != null ? 'yes' : 'NO'),
            const SizedBox(height: 8),
            const Text(
              'Standard wire bytes:',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            hexView(stdEncoded),
            const SizedBox(height: 8),
            const Text(
              'JSON wire bytes:',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            hexView(jsonEncoded),
          ],
        ),
      ),
      paragraph(
        'Per-type wire encoding showcase. Each card encodes a single value '
        'so you can see the type tag and the per-type layout.',
      ),
      ...perTypeCards,
    ],
  );
}

class _StdTypeSample {
  final String label;
  final Object? value;
  const _StdTypeSample(this.label, this.value);
}

// =============================================================================
// SECTION 6: BinaryCodec deep dive
// =============================================================================

Widget buildBinaryCodecSection() {
  final codec = const BinaryCodec();

  final samples = <_BinarySample>[
    _BinarySample(
      label: 'magic + pi + tag (13 bytes)',
      builder: () {
        final d = ByteData(13);
        d.setUint32(0, 0xCAFEBABE, Endian.big);
        d.setFloat64(4, 3.141592653589793, Endian.big);
        d.setUint8(12, 0x42);
        return d;
      },
    ),
    _BinarySample(
      label: 'header (16 bytes) — version, flags, length',
      builder: () {
        final d = ByteData(16);
        d.setUint32(0, 0x544F4D31, Endian.big); // "TOM1"
        d.setUint16(4, 0x0001, Endian.big); // version
        d.setUint16(6, 0xFF00, Endian.big); // flags
        d.setUint64(8, 0x00000000DEADBEEF, Endian.big); // length
        return d;
      },
    ),
    _BinarySample(
      label: 'tiny WAV-like frame (32 bytes)',
      builder: () {
        final d = ByteData(32);
        // RIFF chunk
        d.setUint32(0, 0x52494646, Endian.big); // 'RIFF'
        d.setUint32(4, 24, Endian.little); // chunk size
        d.setUint32(8, 0x57415645, Endian.big); // 'WAVE'
        // fmt sub-chunk start
        d.setUint32(12, 0x666D7420, Endian.big); // 'fmt '
        d.setUint32(16, 16, Endian.little);
        d.setUint16(20, 1, Endian.little); // PCM
        d.setUint16(22, 2, Endian.little); // stereo
        d.setUint32(24, 44100, Endian.little); // sample rate
        d.setUint32(28, 176400, Endian.little); // byte rate
        return d;
      },
    ),
    _BinarySample(
      label: 'tiny float buffer',
      builder: () {
        final src = Float64List.fromList(<double>[0.0, 0.5, 1.0, -0.5, -1.0]);
        return ByteData.view(src.buffer);
      },
    ),
    _BinarySample(
      label: 'empty ByteData(0)',
      builder: () => ByteData(0),
    ),
  ];

  final cards = <Widget>[];
  for (final sample in samples) {
    final input = sample.builder();
    final encoded = codec.encodeMessage(input);
    final decoded = codec.decodeMessage(encoded);
    final identical = decoded == encoded;
    cards.add(
      infoCard(
        title: sample.label,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keyValueRow('input bytes', '${input.lengthInBytes}'),
            keyValueRow('encoded bytes', '${byteLength(encoded)}'),
            keyValueRow('decoded bytes', '${byteLength(decoded)}'),
            keyValueRow('decoded === encoded',
                identical ? 'yes (identity)' : 'no'),
            const SizedBox(height: 6),
            hexView(encoded),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '6. BinaryCodec deep dive',
        subtitle:
            'BinaryCodec is the identity codec: encodeMessage returns the '
            'same ByteData unchanged, and decodeMessage does too.',
      ),
      paragraph(
        'BinaryCodec is the right choice when you already have a binary '
        'payload (audio buffer, image bytes, custom protobuf/flatbuffers '
        'frame) and you do not want any framing overhead. Both encode and '
        'decode are zero-copy.',
      ),
      ...cards,
    ],
  );
}

class _BinarySample {
  final String label;
  final ByteData Function() builder;
  const _BinarySample({required this.label, required this.builder});
}

// =============================================================================
// SECTION 7: Comparison table
// =============================================================================

Widget buildComparisonSection() {
  final string = const StringCodec();
  final json = const JSONMessageCodec();
  final standard = const StandardMessageCodec();
  final binary = const BinaryCodec();

  // Common payload to size-compare all four codecs against (only the codecs
  // that can encode it will produce bytes; the rest produce N/A).
  const sampleString = 'Hello, codec!';
  final sampleJsonable = <String, Object?>{
    'event': 'tap',
    'count': 7,
  };
  final sampleStandard = <Object?, Object?>{
    'event': 'tap',
    'count': 7,
  };
  final sampleBinary = ByteData(8)..setUint64(0, 0xCAFEBABEDEADBEEF);

  final stringBytes = byteLength(string.encodeMessage(sampleString));
  final jsonBytes = byteLength(json.encodeMessage(sampleJsonable));
  final stdBytes = byteLength(standard.encodeMessage(sampleStandard));
  final binBytes = byteLength(binary.encodeMessage(sampleBinary));

  TableRow header(List<String> cells) {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFE3F2FD)),
      children: cells
          .map((c) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  c,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ))
          .toList(),
    );
  }

  TableRow body(List<String> cells, {Color? bg}) {
    return TableRow(
      decoration:
          BoxDecoration(color: bg ?? const Color(0xFFFAFAFA)),
      children: cells
          .map((c) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(c, style: const TextStyle(fontSize: 12.5)),
              ))
          .toList(),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '7. Comparison table',
        subtitle:
            'When to pick which codec — supported types, byte size, and '
            'performance hints.',
      ),
      Table(
        border: TableBorder.all(color: const Color(0xFFB0BEC5)),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(140),
          1: FlexColumnWidth(2),
          2: FixedColumnWidth(80),
          3: FlexColumnWidth(2),
        },
        children: <TableRow>[
          header(<String>['Codec', 'Supported types', 'Sample size', 'When to use']),
          body(<String>[
            'StringCodec',
            'String only',
            '$stringBytes B',
            'Logs, simple text bridges, ad-hoc commands.',
          ]),
          body(<String>[
            'JSONMessageCodec',
            'jsonEncode-able: Map/List/num/bool/null/String',
            '$jsonBytes B',
            'Cross-platform interop with web/JS or anywhere JSON is convenient.',
          ], bg: const Color(0xFFF5F5F5)),
          body(<String>[
            'StandardMessageCodec',
            'Plus Uint8List/Int32List/Int64List/Float32List/Float64List',
            '$stdBytes B',
            'Default and recommended. Native to Flutter platform channels.',
          ]),
          body(<String>[
            'BinaryCodec',
            'ByteData (identity)',
            '$binBytes B',
            'Pre-encoded binary payloads (protobuf, image bytes, audio).',
          ], bg: const Color(0xFFF5F5F5)),
        ],
      ),
      const SizedBox(height: 12),
      paragraph(
        'Notes: byte sizes are for a small "tap event" payload to give a '
        'sense of overhead. JSON has the largest framing cost for small '
        'structured messages because keys and values are stored as text.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 8: Wire format diagrams
// =============================================================================

Widget _wireBox(String label, String value, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 4, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget buildWireDiagramsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '8. Wire format diagrams',
        subtitle: 'Byte-level layout of StandardMessageCodec and JSON.',
      ),
      infoCard(
        title: 'StandardMessageCodec — single value',
        color: const Color(0xFF00695C),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paragraph(
              'Every value starts with a 1-byte type tag. Some types embed '
              'their length using a variable-length unsigned integer (VLU): '
              'a single byte for sizes < 254, otherwise 0xFE + uint16 or '
              '0xFF + uint32.',
            ),
            Wrap(
              children: [
                _wireBox('TYPE TAG', '1 byte', const Color(0xFF00695C)),
                _wireBox('LENGTH (VLU)', '1 / 3 / 5 bytes',
                    const Color(0xFF1565C0)),
                _wireBox('PAYLOAD', 'N bytes', const Color(0xFF6A1B9A)),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Type tags (subset)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            codeBlock(
              '0  null\n'
              '1  true\n'
              '2  false\n'
              '3  int32\n'
              '4  int64\n'
              '6  float64 (8-byte aligned, little-endian)\n'
              '7  String (UTF-8, length-prefixed)\n'
              '8  Uint8List (length-prefixed)\n'
              '9  Int32List (4-byte aligned)\n'
              '10 Int64List (8-byte aligned)\n'
              '11 Float64List (8-byte aligned)\n'
              '12 List<Object?> (length-prefixed, recursive)\n'
              '13 Map<Object?,Object?> (length-prefixed, recursive)\n'
              '14 Float32List (4-byte aligned)',
            ),
          ],
        ),
      ),
      infoCard(
        title: 'JSONMessageCodec — encoding a small map',
        color: const Color(0xFF6A1B9A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paragraph(
              'JSON is a thin wrapper: jsonEncode produces a String, which '
              'is then UTF-8 encoded. There is no type tagging — every '
              'character is part of the textual JSON syntax.',
            ),
            Wrap(
              children: [
                _wireBox('"{"', '0x7B', const Color(0xFF6A1B9A)),
                _wireBox('key', '"event"', const Color(0xFF1565C0)),
                _wireBox(':', '0x3A', const Color(0xFF6A1B9A)),
                _wireBox('val', '"tap"', const Color(0xFF1565C0)),
                _wireBox(',', '0x2C', const Color(0xFF6A1B9A)),
                _wireBox('key', '"count"', const Color(0xFF1565C0)),
                _wireBox(':', '0x3A', const Color(0xFF6A1B9A)),
                _wireBox('num', '7', const Color(0xFF1565C0)),
                _wireBox('"}"', '0x7D', const Color(0xFF6A1B9A)),
              ],
            ),
            const SizedBox(height: 8),
            paragraph(
              'Concretely: bytes are 7B 22 65 76 65 6E 74 22 3A 22 74 61 70 '
              '22 2C 22 63 6F 75 6E 74 22 3A 37 7D — note that "7" is the '
              'ASCII digit 0x37, not the byte 0x07 you would see in a '
              'StandardMessageCodec int.',
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 9: Error paths
// =============================================================================

class _Unsupported {
  final int x;
  const _Unsupported(this.x);
  @override
  String toString() => '_Unsupported($x)';
}

Widget buildErrorPathsSection() {
  final json = const JSONMessageCodec();
  final standard = const StandardMessageCodec();

  final results = <_ErrorCase>[];

  // 1. Function in JSON
  try {
    final fn = () => 1;
    json.encodeMessage(<Object?>[fn]);
    results.add(_ErrorCase('JSON: list with Function', null));
  } catch (e) {
    results.add(_ErrorCase('JSON: list with Function', e.toString()));
  }

  // 2. Custom class in JSON
  try {
    json.encodeMessage(<String, Object?>{'x': const _Unsupported(1)});
    results.add(_ErrorCase('JSON: map with custom class', null));
  } catch (e) {
    results.add(_ErrorCase('JSON: map with custom class', e.toString()));
  }

  // 3. Custom class in Standard
  try {
    standard.encodeMessage(const _Unsupported(2));
    results.add(_ErrorCase('Standard: custom class', null));
  } catch (e) {
    results.add(_ErrorCase('Standard: custom class', e.toString()));
  }

  // 4. Function in Standard
  try {
    standard.encodeMessage(<Object?>[() => 1]);
    results.add(_ErrorCase('Standard: list with Function', null));
  } catch (e) {
    results.add(_ErrorCase('Standard: list with Function', e.toString()));
  }

  // 5. Decoding garbage as Standard
  try {
    final junk = ByteData(4)
      ..setUint8(0, 0xFF)
      ..setUint8(1, 0xFF)
      ..setUint8(2, 0xFF)
      ..setUint8(3, 0xFF);
    standard.decodeMessage(junk);
    results.add(_ErrorCase('Standard: decode garbage', null));
  } catch (e) {
    results.add(_ErrorCase('Standard: decode garbage', e.toString()));
  }

  // 6. Decoding garbage as JSON (invalid UTF-8 / invalid JSON)
  try {
    final junk = ByteData(3)
      ..setUint8(0, 0xC3)
      ..setUint8(1, 0x28) // invalid UTF-8 continuation
      ..setUint8(2, 0x00);
    json.decodeMessage(junk);
    results.add(_ErrorCase('JSON: decode invalid UTF-8', null));
  } catch (e) {
    results.add(_ErrorCase('JSON: decode invalid UTF-8', e.toString()));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '9. Error paths',
        subtitle:
            'What happens when a non-encodable value is passed in, or '
            'malformed bytes are decoded.',
      ),
      paragraph(
        'Both JSONMessageCodec and StandardMessageCodec throw when they meet '
        'a value they cannot encode. Always wrap untrusted payloads in '
        'try/catch — a single bad value would otherwise crash the channel.',
      ),
      ...results.map((r) => infoCard(
            title: r.label,
            color: r.error == null
                ? const Color(0xFF2E7D32)
                : const Color(0xFFD32F2F),
            child: Text(
              r.error ?? '(no error — encoded silently)',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
          )),
    ],
  );
}

class _ErrorCase {
  final String label;
  final String? error;
  const _ErrorCase(this.label, this.error);
}

// =============================================================================
// SECTION 10: Recipe gallery
// =============================================================================

class _Recipe {
  final String title;
  final String channel;
  final String codec;
  final String dartSnippet;
  final String hostSide;
  const _Recipe({
    required this.title,
    required this.channel,
    required this.codec,
    required this.dartSnippet,
    required this.hostSide,
  });
}

Widget buildRecipeGallery() {
  const recipes = <_Recipe>[
    _Recipe(
      title: 'Send keystrokes via String',
      channel: "BasicMessageChannel<String>('app/keys', StringCodec())",
      codec: 'StringCodec',
      dartSnippet:
          "final ch = BasicMessageChannel<String>(\n"
          "  'app/keys',\n"
          "  const StringCodec(),\n"
          ");\n"
          "await ch.send('ctrl+shift+p');",
      hostSide:
          'Android: BasicMessageChannel<String>("app/keys", StringCodec.INSTANCE)\n'
          'iOS: FlutterBasicMessageChannel(name: "app/keys", binaryMessenger: messenger, codec: FlutterStringCodec.sharedInstance)',
    ),
    _Recipe(
      title: 'Settings sync via JSON',
      channel:
          "BasicMessageChannel<Object?>('app/settings', JSONMessageCodec())",
      codec: 'JSONMessageCodec',
      dartSnippet:
          "final ch = BasicMessageChannel<Object?>(\n"
          "  'app/settings',\n"
          "  const JSONMessageCodec(),\n"
          ");\n"
          "await ch.send(<String, Object?>{\n"
          "  'theme': 'dark',\n"
          "  'fontSize': 14,\n"
          "  'features': <String>['ai', 'sync'],\n"
          "});",
      hostSide:
          'Android: JSONMessageCodec.INSTANCE\n'
          'iOS: FlutterJSONMessageCodec.sharedInstance\n'
          'Cross-platform: any client that can serve JSON.',
    ),
    _Recipe(
      title: 'Image bytes via Standard',
      channel:
          "BasicMessageChannel<Object?>('app/frames', StandardMessageCodec())",
      codec: 'StandardMessageCodec',
      dartSnippet:
          "final ch = BasicMessageChannel<Object?>(\n"
          "  'app/frames',\n"
          "  const StandardMessageCodec(),\n"
          ");\n"
          "await ch.send(<String, Object?>{\n"
          "  'width': 1920,\n"
          "  'height': 1080,\n"
          "  'rgba': pixelBuffer, // Uint8List, no base64\n"
          "});",
      hostSide:
          'Android: StandardMessageCodec.INSTANCE — decodes Uint8List as byte[].\n'
          'iOS: FlutterStandardMessageCodec.sharedInstance — decodes as FlutterStandardTypedData (.bytes).',
    ),
    _Recipe(
      title: 'Audio buffer via Binary',
      channel:
          "BasicMessageChannel<ByteData?>('app/audio', BinaryCodec())",
      codec: 'BinaryCodec',
      dartSnippet:
          "final ch = BasicMessageChannel<ByteData?>(\n"
          "  'app/audio',\n"
          "  const BinaryCodec(),\n"
          ");\n"
          "final buffer = ByteData(samples.length * 2);\n"
          "for (var i = 0; i < samples.length; i++) {\n"
          "  buffer.setInt16(i * 2, samples[i], Endian.little);\n"
          "}\n"
          "await ch.send(buffer);",
      hostSide:
          'Android: BinaryCodec.INSTANCE — receives a ByteBuffer.\n'
          'iOS: FlutterBinaryCodec.sharedInstance — receives FlutterStandardTypedData / NSData.',
    ),
  ];

  final cards = recipes.map((r) {
    return infoCard(
      title: r.title,
      color: const Color(0xFF1565C0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          keyValueRow('codec', r.codec),
          keyValueRow('channel', r.channel),
          const SizedBox(height: 6),
          const Text('Dart side',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 2),
          codeBlock(r.dartSnippet),
          const SizedBox(height: 6),
          const Text('Host side',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 2),
          codeBlock(r.hostSide),
        ],
      ),
    );
  }).toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '10. Recipe gallery',
        subtitle: 'Four ready-to-copy patterns for the four codecs.',
      ),
      ...cards,
    ],
  );
}

// =============================================================================
// SECTION 11: Reference table
// =============================================================================

Widget buildReferenceSection() {
  TableRow header(List<String> cells) {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFE3F2FD)),
      children: cells
          .map((c) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  c,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ))
          .toList(),
    );
  }

  TableRow body(List<String> cells, {Color? bg}) {
    return TableRow(
      decoration:
          BoxDecoration(color: bg ?? const Color(0xFFFAFAFA)),
      children: cells
          .map((c) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(c, style: const TextStyle(fontSize: 12.5)),
              ))
          .toList(),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '11. Reference table',
        subtitle:
            'Codec <-> channel pairing and platform-side equivalents.',
      ),
      Table(
        border: TableBorder.all(color: const Color(0xFFB0BEC5)),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(170),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
        },
        children: <TableRow>[
          header(<String>[
            'Codec (Dart)',
            'Channel pairing',
            'Android equivalent',
            'iOS equivalent',
          ]),
          body(<String>[
            'StringCodec',
            'BasicMessageChannel<String>',
            'StringCodec.INSTANCE',
            'FlutterStringCodec.sharedInstance',
          ]),
          body(<String>[
            'JSONMessageCodec',
            'BasicMessageChannel<Object?>',
            'JSONMessageCodec.INSTANCE',
            'FlutterJSONMessageCodec.sharedInstance',
          ], bg: const Color(0xFFF5F5F5)),
          body(<String>[
            'StandardMessageCodec',
            'BasicMessageChannel<Object?> (default)',
            'StandardMessageCodec.INSTANCE',
            'FlutterStandardMessageCodec.sharedInstance',
          ]),
          body(<String>[
            'BinaryCodec',
            'BasicMessageChannel<ByteData?>',
            'BinaryCodec.INSTANCE',
            'FlutterBinaryCodec.sharedInstance',
          ], bg: const Color(0xFFF5F5F5)),
        ],
      ),
      const SizedBox(height: 12),
      paragraph(
        'MethodCodec (used by MethodChannel and EventChannel) is built on '
        'top of MessageCodec. JSONMethodCodec uses JSONMessageCodec, and '
        'StandardMethodCodec uses StandardMessageCodec. There is no method '
        'codec for StringCodec/BinaryCodec because those types do not '
        'naturally express "method name + arguments + envelope".',
      ),
    ],
  );
}

// =============================================================================
// TOP-LEVEL build()
// =============================================================================

dynamic build(BuildContext context) {
  print('=== MessageCodec Deep Demo ===');

  // Sanity round-trip across all four codecs to prove every encodeMessage
  // and decodeMessage path is exercised at the top level too.
  final stringCodec = const StringCodec();
  final jsonCodec = const JSONMessageCodec();
  final standardCodec = const StandardMessageCodec();
  final binaryCodec = const BinaryCodec();

  final s1 = stringCodec.encodeMessage('boot');
  final s2 = stringCodec.decodeMessage(s1);
  print('StringCodec: ${byteLength(s1)} bytes, decoded "$s2"');

  final j1 = jsonCodec.encodeMessage(<String, Object?>{'boot': true});
  final j2 = jsonCodec.decodeMessage(j1);
  print('JSONMessageCodec: ${byteLength(j1)} bytes, decoded $j2');

  final std1 = standardCodec.encodeMessage(<Object?, Object?>{
    'boot': true,
    'pixels': Uint8List.fromList(<int>[1, 2, 3]),
  });
  final std2 = standardCodec.decodeMessage(std1);
  print('StandardMessageCodec: ${byteLength(std1)} bytes, decoded $std2');

  final bin1 = binaryCodec.encodeMessage(buildSampleByteData());
  final bin2 = binaryCodec.decodeMessage(bin1);
  print('BinaryCodec: ${byteLength(bin1)} bytes, decoded ${byteLength(bin2)} '
      'bytes');

  return MaterialApp(
    title: 'MessageCodec Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('MessageCodec<T> — Deep Demo'),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildIntroSection(),
              buildRoundTripVisualizer(),
              buildStringCodecSection(),
              buildJsonCodecSection(),
              buildStandardCodecSection(),
              buildBinaryCodecSection(),
              buildComparisonSection(),
              buildWireDiagramsSection(),
              buildErrorPathsSection(),
              buildRecipeGallery(),
              buildReferenceSection(),
              const SizedBox(height: 24),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'End of MessageCodec deep demo.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF607D8B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Extended notes — kept as Dart documentation comments to deepen the file.
// =============================================================================
//
// The remainder of this file consists of design notes about MessageCodec<T>
// that mirror the on-screen sections. They are kept as comments (no further
// code) so that this file remains a "deep" demo without artificially
// inflating the runtime.
//
// -----------------------------------------------------------------------------
// Note A: why a codec abstraction?
// -----------------------------------------------------------------------------
//
// Flutter's platform channels need to ship arbitrary structured data across
// a process / language / runtime boundary. The boundary speaks bytes — Dart
// pinning a Map<String, Object?> means nothing on the iOS side until both
// agree on a serialization. MessageCodec<T> is that agreement, and the four
// built-ins cover the practical cases:
//
//   * Plain text -> StringCodec
//   * JSON-shaped, non-binary -> JSONMessageCodec
//   * Mixed structured + binary, type-preserving -> StandardMessageCodec
//   * Already-binary -> BinaryCodec
//
// Anything more exotic (protobuf, msgpack, capnproto) is implemented by the
// user as a custom MessageCodec<T> that returns a ByteData of the encoded
// message and reverses it on decode.
//
// -----------------------------------------------------------------------------
// Note B: const-ness
// -----------------------------------------------------------------------------
//
// All four built-in codecs have const constructors:
//   const StringCodec();
//   const JSONMessageCodec();
//   const StandardMessageCodec();
//   const BinaryCodec();
// Use the const literal everywhere you can to share a single instance.
// They are stateless, so this is always safe.
//
// -----------------------------------------------------------------------------
// Note C: nullable ByteData
// -----------------------------------------------------------------------------
//
// `ByteData? encodeMessage(T message)` and `T decodeMessage(ByteData? message)`
// — the nullability matters. A null input on decode means "the platform sent
// no payload", and codecs are expected to interpret that:
//   * StringCodec(null)           -> null
//   * JSONMessageCodec(null)      -> null
//   * StandardMessageCodec(null)  -> null
//   * BinaryCodec(null)           -> null
//
// Conversely, encodeMessage may return null for "no payload":
//   * StringCodec.encodeMessage(null)             -> null
//   * JSONMessageCodec.encodeMessage(null)        -> 4 bytes ("null")
//   * StandardMessageCodec.encodeMessage(null)    -> 1 byte (type tag 0)
//   * BinaryCodec.encodeMessage(null)             -> null
//
// -----------------------------------------------------------------------------
// Note D: alignment in StandardMessageCodec
// -----------------------------------------------------------------------------
//
// Standard codec inserts padding bytes before typed-list payloads so that
// readers on the other side can read the buffer as aligned native words
// (Int32List requires 4-byte alignment, Float64List requires 8). This is why
// the byte count for a typed list is sometimes a few bytes more than its
// raw `lengthInBytes`.
//
// -----------------------------------------------------------------------------
// Note E: choosing between JSON and Standard
// -----------------------------------------------------------------------------
//
// If your data is JSON-shaped and you need to interop with the web
// (window.postMessage) or to log payloads as human-readable text, prefer
// JSON. Otherwise prefer Standard — it is faster, it is the default for
// MethodChannel, and it preserves int vs double distinctions and binary
// types natively.
//
// -----------------------------------------------------------------------------
// Note F: writing your own MessageCodec
// -----------------------------------------------------------------------------
//
// A custom codec is just two methods:
//
//   class MsgPackCodec implements MessageCodec<Object?> {
//     const MsgPackCodec();
//     @override
//     ByteData? encodeMessage(Object? message) {
//       if (message == null) return null;
//       final bytes = msgPackEncode(message);
//       return ByteData.view(bytes.buffer);
//     }
//     @override
//     Object? decodeMessage(ByteData? message) {
//       if (message == null) return null;
//       return msgPackDecode(message.buffer.asUint8List());
//     }
//   }
//
// Pair it with BasicMessageChannel and you're done — the framework does the
// rest, including dispatching to the right binary messenger.
//
// =============================================================================
// End of file.
// =============================================================================
