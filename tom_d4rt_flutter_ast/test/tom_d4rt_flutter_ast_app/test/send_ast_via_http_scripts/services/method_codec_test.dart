// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// MethodCodec Deep Demo
// =============================================================================
//
// MethodCodec is the abstract codec used by [MethodChannel] (and its variants
// like OptionalMethodChannel) to encode method calls and decode responses
// across the Dart <-> platform boundary. Built-in implementations:
//
//  * StandardMethodCodec - binary format using StandardMessageCodec; supports
//    null, bool, int, double, String, Uint8List, Int32List, Int64List,
//    Float64List, List<dynamic>, Map<dynamic, dynamic>.
//  * JSONMethodCodec - text-based format (UTF-8 JSON) using JSONMessageCodec;
//    supports the JSON-compatible subset (no binary buffers, no NaN, etc.).
//
// On the wire, every MethodCall produces a payload of bytes. Every response
// is wrapped in an "envelope":
//
//   * success envelope: 0x00 | encoded(result)
//   * error envelope:   0x01 | encoded(code) | encoded(message) | encoded(details)
//
// (The exact byte-for-byte layout differs between Standard and JSON; see the
// wire-format diagram section below.)
//
// This file is a hand-authored deep demonstration intended to be readable
// inside a Flutter test harness. It exercises every relevant entry point of
// MethodCodec (encodeMethodCall / decodeMethodCall / encodeSuccessEnvelope /
// encodeErrorEnvelope / decodeEnvelope) for both StandardMethodCodec() and
// JSONMethodCodec(), and renders the results as visual UI sections.
//
// =============================================================================

// -----------------------------------------------------------------------------
// Color and style constants
// -----------------------------------------------------------------------------

const Color _kBgColor = Color(0xFFF5F7FA);
const Color _kSurfaceColor = Color(0xFFFFFFFF);
const Color _kAccentBlue = Color(0xFF1E88E5);
const Color _kAccentGreen = Color(0xFF43A047);
const Color _kAccentOrange = Color(0xFFFB8C00);
const Color _kAccentRed = Color(0xFFE53935);
const Color _kAccentPurple = Color(0xFF8E24AA);
const Color _kAccentTeal = Color(0xFF00897B);
const Color _kBorderColor = Color(0xFFE0E0E0);
const Color _kTextPrimary = Color(0xFF212121);
const Color _kTextSecondary = Color(0xFF616161);
const Color _kCodeBg = Color(0xFF263238);
const Color _kCodeFg = Color(0xFFECEFF1);

const TextStyle _kHeaderStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: _kTextPrimary,
);
const TextStyle _kSectionTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: _kTextPrimary,
);
const TextStyle _kSubTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: _kTextPrimary,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14,
  color: _kTextPrimary,
  height: 1.4,
);
const TextStyle _kSecondaryStyle = TextStyle(
  fontSize: 13,
  color: _kTextSecondary,
  height: 1.35,
);
const TextStyle _kMonoStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  color: _kCodeFg,
);
const TextStyle _kInlineMonoStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  color: _kTextPrimary,
);

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

String _hexDump(ByteData data, {int maxBytes = 256}) {
  final list = data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  );
  final clipped = list.length > maxBytes ? list.sublist(0, maxBytes) : list;
  final sb = StringBuffer();
  for (var i = 0; i < clipped.length; i++) {
    if (i > 0 && i % 16 == 0) {
      sb.writeln();
    }
    sb.write(clipped[i].toRadixString(16).padLeft(2, '0'));
    sb.write(' ');
  }
  if (list.length > maxBytes) {
    sb.writeln();
    sb.write('... (${list.length - maxBytes} more bytes)');
  }
  return sb.toString().trim();
}

String _asciiDump(ByteData data, {int maxBytes = 256}) {
  final list = data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  );
  final clipped = list.length > maxBytes ? list.sublist(0, maxBytes) : list;
  final sb = StringBuffer();
  for (final b in clipped) {
    if (b >= 0x20 && b < 0x7F) {
      sb.writeCharCode(b);
    } else {
      sb.write('.');
    }
  }
  if (list.length > maxBytes) {
    sb.write(' ...');
  }
  return sb.toString();
}

int _byteLength(ByteData data) => data.lengthInBytes;

String _safeArgsToString(Object? args) {
  if (args == null) return 'null';
  if (args is Uint8List) {
    return 'Uint8List(${args.length}) [${args.take(8).join(', ')}${args.length > 8 ? ', ...' : ''}]';
  }
  if (args is List) {
    return 'List(${args.length}) $args';
  }
  if (args is Map) {
    return 'Map(${args.length}) $args';
  }
  return args.toString();
}

// -----------------------------------------------------------------------------
// Reusable section / panel widgets
// -----------------------------------------------------------------------------

Widget _buildSection({
  required String title,
  required String subtitle,
  required Color accent,
  required List<Widget> children,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      color: _kSurfaceColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kBorderColor),
      boxShadow: const [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10),
            ),
            border: Border(
              bottom: BorderSide(color: accent.withOpacity(0.25)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: _kSectionTitleStyle.copyWith(color: accent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: _kSecondaryStyle),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String text, {Color? accent}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(6),
      border: accent != null
          ? Border(left: BorderSide(color: accent, width: 4))
          : null,
    ),
    child: Text(text, style: _kMonoStyle),
  );
}

Widget _kvRow(String key, String value, {Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            key,
            style: _kBodyStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: color ?? _kTextSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: _kInlineMonoStyle),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

Widget _divider() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(height: 1, thickness: 1, color: _kBorderColor),
    );

Widget _paragraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(text, style: _kBodyStyle),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 8),
          child: Icon(Icons.circle, size: 6, color: _kTextSecondary),
        ),
        Expanded(child: Text(text, style: _kBodyStyle)),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Sample call set used across multiple sections
// -----------------------------------------------------------------------------

class _SampleCall {
  final String label;
  final MethodCall call;
  final String purpose;
  final bool jsonCompatible;

  const _SampleCall({
    required this.label,
    required this.call,
    required this.purpose,
    required this.jsonCompatible,
  });
}

List<_SampleCall> _sampleCalls() {
  return <_SampleCall>[
    _SampleCall(
      label: 'getBatteryLevel',
      call: const MethodCall('getBatteryLevel', null),
      purpose: 'No args; expects double or int back.',
      jsonCompatible: true,
    ),
    _SampleCall(
      label: 'setVolume',
      call: const MethodCall('setVolume', 0.7),
      purpose: 'Single double argument.',
      jsonCompatible: true,
    ),
    _SampleCall(
      label: 'setBrightness',
      call: const MethodCall('setBrightness', 0.42),
      purpose: 'Another double-only call.',
      jsonCompatible: true,
    ),
    _SampleCall(
      label: 'shareText',
      call: const MethodCall('shareText', <String, Object?>{
        'text': 'Hello from Flutter',
        'subject': 'Greetings',
      }),
      purpose: 'Map argument with strings only.',
      jsonCompatible: true,
    ),
    _SampleCall(
      label: 'requestLocation',
      call: const MethodCall('requestLocation', <String, Object?>{
        'accuracy': 'high',
        'timeoutMs': 5000,
        'background': false,
      }),
      purpose: 'Mixed map argument.',
      jsonCompatible: true,
    ),
    _SampleCall(
      label: 'startScan',
      call: const MethodCall('startScan', <Object?>['BLE', 'WIFI', 'NFC']),
      purpose: 'List<String> argument.',
      jsonCompatible: true,
    ),
    _SampleCall(
      label: 'showSettings',
      call: const MethodCall('showSettings', null),
      purpose: 'No-arg navigation call.',
      jsonCompatible: true,
    ),
    _SampleCall(
      label: 'uploadImage',
      call: MethodCall(
        'uploadImage',
        Uint8List.fromList(<int>[
          0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
          0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
          0xDE, 0xAD, 0xBE, 0xEF, 0xCA, 0xFE, 0xBA, 0xBE,
          0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
        ]),
      ),
      purpose: 'Binary buffer (Uint8List) - Standard only.',
      jsonCompatible: false,
    ),
  ];
}

// -----------------------------------------------------------------------------
// Encoding result wrapper
// -----------------------------------------------------------------------------

class _EncodeResult {
  final String codecName;
  final ByteData? bytes;
  final String? error;
  final MethodCall? decoded;
  final String? decodeError;

  _EncodeResult({
    required this.codecName,
    this.bytes,
    this.error,
    this.decoded,
    this.decodeError,
  });
}

_EncodeResult _tryEncode(MethodCodec codec, String name, MethodCall call) {
  try {
    final bytes = codec.encodeMethodCall(call);
    try {
      final decoded = codec.decodeMethodCall(bytes);
      return _EncodeResult(codecName: name, bytes: bytes, decoded: decoded);
    } catch (e) {
      return _EncodeResult(
        codecName: name,
        bytes: bytes,
        decodeError: e.toString(),
      );
    }
  } catch (e) {
    return _EncodeResult(codecName: name, error: e.toString());
  }
}

// =============================================================================
// SECTION BUILDERS
// =============================================================================

// -----------------------------------------------------------------------------
// Section 1: Intro
// -----------------------------------------------------------------------------

Widget _section1Intro() {
  return _buildSection(
    title: '1. Introduction to MethodCodec',
    subtitle:
        'How method calls travel between Dart and the host platform via codecs.',
    accent: _kAccentBlue,
    children: [
      _paragraph(
        'A MethodChannel is a thin wrapper around a BinaryMessenger and a '
        'MethodCodec. The codec defines how a structured Dart MethodCall is '
        'serialized into raw bytes, and how response envelopes from the host '
        'platform are deserialized back into Dart values (or exceptions).',
      ),
      _paragraph(
        'A typical platform call follows four stages:',
      ),
      _bullet('1) Dart constructs a MethodCall(method, arguments).'),
      _bullet(
        '2) The codec encodes the call to a ByteData buffer.',
      ),
      _bullet(
        '3) The host platform decodes the call, runs handler logic, and '
        'replies with either a success or an error envelope.',
      ),
      _bullet(
        '4) The codec decodes the envelope, returning the result or '
        'throwing PlatformException for errors.',
      ),
      _divider(),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kAccentBlue.withOpacity(0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kAccentBlue.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Built-in codecs',
              style: _kSubTitleStyle.copyWith(color: _kAccentBlue),
            ),
            const SizedBox(height: 8),
            _bullet(
              'StandardMethodCodec - compact binary, supports Uint8List / '
              'Int32List / Int64List / Float64List, ideal default.',
            ),
            _bullet(
              'JSONMethodCodec - UTF-8 JSON text, human-readable, only the '
              'JSON-compatible value subset is permitted.',
            ),
          ],
        ),
      ),
      _divider(),
      Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          _chip('encodeMethodCall', _kAccentBlue),
          _chip('decodeMethodCall', _kAccentBlue),
          _chip('encodeSuccessEnvelope', _kAccentGreen),
          _chip('encodeErrorEnvelope', _kAccentRed),
          _chip('decodeEnvelope', _kAccentTeal),
        ],
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 2: Encode MethodCall (interactive)
// -----------------------------------------------------------------------------

class _EncoderPanel extends StatefulWidget {
  const _EncoderPanel();

  @override
  State<_EncoderPanel> createState() => _EncoderPanelState();
}

class _EncoderPanelState extends State<_EncoderPanel> {
  final TextEditingController _methodCtrl =
      TextEditingController(text: 'getBatteryLevel');
  final TextEditingController _argsCtrl =
      TextEditingController(text: '{"accuracy":"high","timeoutMs":5000}');

  String _codecChoice = 'Standard';

  MethodCodec get _codec => _codecChoice == 'Standard'
      ? const StandardMethodCodec()
      : const JSONMethodCodec();

  Object? _parseArgs(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty || trimmed == 'null') return null;
    try {
      return jsonDecode(trimmed);
    } catch (_) {
      // Treat as plain string.
      return trimmed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState2) {
        final method = _methodCtrl.text.trim().isEmpty
            ? 'unnamed'
            : _methodCtrl.text.trim();
        final args = _parseArgs(_argsCtrl.text);
        final call = MethodCall(method, args);

        ByteData? bytes;
        String? encodeErr;
        MethodCall? decoded;
        String? decodeErr;
        try {
          bytes = _codec.encodeMethodCall(call);
          try {
            decoded = _codec.decodeMethodCall(bytes);
          } catch (e) {
            decodeErr = e.toString();
          }
        } catch (e) {
          encodeErr = e.toString();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Standard'),
                  selected: _codecChoice == 'Standard',
                  onSelected: (v) {
                    if (v) {
                      setState(() => _codecChoice = 'Standard');
                      setState2(() {});
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('JSON'),
                  selected: _codecChoice == 'JSON',
                  onSelected: (v) {
                    if (v) {
                      setState(() => _codecChoice = 'JSON');
                      setState2(() {});
                    }
                  },
                ),
                const SizedBox(width: 12),
                _chip('codec: $_codecChoice', _kAccentBlue),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _methodCtrl,
              decoration: const InputDecoration(
                labelText: 'Method name',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (_) => setState2(() {}),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _argsCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Arguments (JSON literal, or "null")',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (_) => setState2(() {}),
            ),
            const SizedBox(height: 12),
            _kvRow('method', method),
            _kvRow('argsType', args.runtimeType.toString()),
            _kvRow('args', _safeArgsToString(args)),
            _divider(),
            if (encodeErr != null) ...[
              Text('Encode error', style: _kSubTitleStyle.copyWith(
                color: _kAccentRed,
              )),
              _codeBlock(encodeErr, accent: _kAccentRed),
            ] else ...[
              _kvRow('byteLength', '${_byteLength(bytes!)} bytes'),
              Text('Hex bytes', style: _kSubTitleStyle),
              _codeBlock(_hexDump(bytes), accent: _kAccentBlue),
              Text('ASCII view', style: _kSubTitleStyle),
              _codeBlock(_asciiDump(bytes), accent: _kAccentTeal),
              _divider(),
              if (decodeErr != null) ...[
                Text('Decode error', style: _kSubTitleStyle.copyWith(
                  color: _kAccentRed,
                )),
                _codeBlock(decodeErr, accent: _kAccentRed),
              ] else ...[
                Text('Decoded MethodCall',
                    style: _kSubTitleStyle.copyWith(color: _kAccentGreen)),
                _kvRow('method', decoded!.method),
                _kvRow('arguments', _safeArgsToString(decoded.arguments)),
                _kvRow('round-trip', decoded.method == method ? 'OK' : 'MISMATCH'),
              ],
            ],
          ],
        );
      },
    );
  }
}

Widget _section2EncodeMethodCall() {
  return _buildSection(
    title: '2. Encode a MethodCall (interactive)',
    subtitle:
        'Pick a codec, type a method name and JSON args; observe bytes and the round-tripped call.',
    accent: _kAccentBlue,
    children: const [
      _EncoderPanel(),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 3: StandardMethodCodec deep dive
// -----------------------------------------------------------------------------

Widget _section3Standard() {
  const codec = StandardMethodCodec();
  final results = <Widget>[];

  for (final s in _sampleCalls()) {
    final r = _tryEncode(codec, 'Standard', s.call);
    results.add(_divider());
    results.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'MethodCall("${s.call.method}", ${_safeArgsToString(s.call.arguments)})',
            style: _kSubTitleStyle,
          ),
        ),
        if (s.jsonCompatible) _chip('JSON-OK', _kAccentTeal)
        else _chip('Standard-only', _kAccentOrange),
      ],
    ));
    results.add(const SizedBox(height: 4));
    results.add(Text(s.purpose, style: _kSecondaryStyle));
    if (r.error != null) {
      results.add(_codeBlock('encode error: ${r.error}',
          accent: _kAccentRed));
    } else {
      results.add(_kvRow('byteLength', '${_byteLength(r.bytes!)} bytes'));
      results.add(Text('Hex', style: _kSecondaryStyle));
      results.add(_codeBlock(_hexDump(r.bytes!, maxBytes: 96),
          accent: _kAccentBlue));
      if (r.decoded != null) {
        results.add(_kvRow('decoded.method', r.decoded!.method));
        results.add(_kvRow(
          'decoded.arguments',
          _safeArgsToString(r.decoded!.arguments),
        ));
      } else {
        results.add(_codeBlock('decode error: ${r.decodeError}',
            accent: _kAccentRed));
      }
    }
  }

  return _buildSection(
    title: '3. StandardMethodCodec deep dive',
    subtitle:
        'Examples covering null, primitives, maps, lists, and Uint8List buffers.',
    accent: _kAccentTeal,
    children: [
      _paragraph(
        'StandardMethodCodec uses the StandardMessageCodec internally and is '
        'the default codec for new MethodChannels. It is binary, compact, and '
        'preserves typed-data buffers without a base64 round-trip.',
      ),
      ...results,
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 4: JSONMethodCodec deep dive + side-by-side comparison
// -----------------------------------------------------------------------------

Widget _section4Json() {
  const stdCodec = StandardMethodCodec();
  const jsonCodec = JSONMethodCodec();

  final widgets = <Widget>[];

  for (final s in _sampleCalls()) {
    final std = _tryEncode(stdCodec, 'Standard', s.call);
    _EncodeResult? json;
    if (s.jsonCompatible) {
      json = _tryEncode(jsonCodec, 'JSON', s.call);
    }

    widgets.add(_divider());
    widgets.add(Text(
      '${s.call.method}',
      style: _kSubTitleStyle,
    ));
    widgets.add(Text(s.purpose, style: _kSecondaryStyle));
    widgets.add(const SizedBox(height: 6));

    final stdLen =
        std.bytes != null ? '${_byteLength(std.bytes!)} bytes' : '—';
    final jsonLen = json?.bytes != null
        ? '${_byteLength(json!.bytes!)} bytes'
        : (json == null ? 'incompatible' : '—');

    widgets.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccentTeal.withOpacity(0.06),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kAccentTeal.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Standard',
                    style: _kSubTitleStyle.copyWith(color: _kAccentTeal)),
                _kvRow('size', stdLen),
                if (std.bytes != null)
                  Text(
                    _hexDump(std.bytes!, maxBytes: 64),
                    style: _kInlineMonoStyle.copyWith(fontSize: 11),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccentOrange.withOpacity(0.06),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kAccentOrange.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('JSON',
                    style: _kSubTitleStyle.copyWith(color: _kAccentOrange)),
                _kvRow('size', jsonLen),
                if (json?.bytes != null)
                  Text(
                    _asciiDump(json!.bytes!, maxBytes: 96),
                    style: _kInlineMonoStyle.copyWith(fontSize: 11),
                  )
                else if (json == null)
                  Text(
                    'Skipped: not JSON-compatible (binary buffer)',
                    style: _kInlineMonoStyle.copyWith(
                      color: _kAccentRed,
                      fontSize: 11,
                    ),
                  )
                else if (json.error != null)
                  Text(
                    'Error: ${json.error}',
                    style: _kInlineMonoStyle.copyWith(
                      color: _kAccentRed,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ));

    if (std.bytes != null && json?.bytes != null) {
      final stdBytes = _byteLength(std.bytes!);
      final jsonBytes = _byteLength(json!.bytes!);
      final ratio =
          jsonBytes == 0 ? 0.0 : (jsonBytes / stdBytes).toStringAsFixed(2);
      widgets.add(_kvRow('JSON / Standard', '${ratio}x'));
    }
  }

  return _buildSection(
    title: '4. JSONMethodCodec deep dive',
    subtitle: 'Side-by-side byte comparison vs StandardMethodCodec.',
    accent: _kAccentOrange,
    children: [
      _paragraph(
        'JSONMethodCodec is convenient for interop with platforms or services '
        'that already speak JSON, but it cannot transport raw binary buffers '
        '(Uint8List), Int32List/Int64List/Float64List, NaN, or non-finite '
        'doubles. Numbers are JSON numbers, so int and double both round-trip '
        'as num.',
      ),
      ...widgets,
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 5: Success envelope
// -----------------------------------------------------------------------------

Widget _section5SuccessEnvelope() {
  const stdCodec = StandardMethodCodec();
  const jsonCodec = JSONMethodCodec();

  final List<Object?> sampleResults = <Object?>[
    null,
    42,
    3.14159,
    'OK',
    <String, Object?>{'level': 0.85, 'charging': true, 'source': 'battery'},
    <Object?>['BLE', 'WIFI', 'NFC'],
  ];

  final widgets = <Widget>[];

  for (final r in sampleResults) {
    widgets.add(_divider());
    final label = r == null ? 'null' : '${r.runtimeType}: $r';
    widgets.add(Text(label, style: _kSubTitleStyle));

    // Standard
    try {
      final bytes = stdCodec.encodeSuccessEnvelope(r);
      final decoded = stdCodec.decodeEnvelope(bytes);
      widgets.add(_kvRow(
        'Standard',
        '${_byteLength(bytes)} B  -> ${decoded.runtimeType}: $decoded',
      ));
      widgets.add(_codeBlock(_hexDump(bytes, maxBytes: 96),
          accent: _kAccentTeal));
    } catch (e) {
      widgets.add(_codeBlock('Standard error: $e', accent: _kAccentRed));
    }

    // JSON (skip Uint8List etc.)
    try {
      final bytes = jsonCodec.encodeSuccessEnvelope(r);
      final decoded = jsonCodec.decodeEnvelope(bytes);
      widgets.add(_kvRow(
        'JSON',
        '${_byteLength(bytes)} B  -> ${decoded.runtimeType}: $decoded',
      ));
      widgets.add(_codeBlock(_asciiDump(bytes, maxBytes: 96),
          accent: _kAccentOrange));
    } catch (e) {
      widgets.add(_codeBlock('JSON error: $e', accent: _kAccentRed));
    }
  }

  return _buildSection(
    title: '5. Success envelopes',
    subtitle:
        'encodeSuccessEnvelope / decodeEnvelope across both codecs and many result types.',
    accent: _kAccentGreen,
    children: [
      _paragraph(
        'A success envelope wraps a single result value. Standard prefixes '
        'one byte (0x00) followed by the encoded result; JSON wraps the result '
        'as a single-element JSON array.',
      ),
      ...widgets,
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 6: Error envelope
// -----------------------------------------------------------------------------

class _ErrorCase {
  final String code;
  final String? message;
  final Object? details;
  const _ErrorCase(this.code, this.message, this.details);
}

Widget _section6ErrorEnvelope() {
  const stdCodec = StandardMethodCodec();
  const jsonCodec = JSONMethodCodec();

  final cases = <_ErrorCase>[
    const _ErrorCase('PERMISSION_DENIED', 'No camera access', <String, Object?>{
      'permission': 'camera',
      'systemMessage': 'User denied prompt',
      'attempt': 3,
    }),
    const _ErrorCase('UNAVAILABLE', 'Bluetooth not available', null),
    const _ErrorCase('IO_ERROR', null, <String, Object?>{'errno': 9}),
    const _ErrorCase('TIMEOUT', 'Request exceeded 5000ms', 5000),
  ];

  final widgets = <Widget>[];

  for (final c in cases) {
    widgets.add(_divider());
    widgets.add(Row(
      children: [
        const Icon(Icons.error_outline, color: _kAccentRed, size: 20),
        const SizedBox(width: 6),
        Expanded(
          child: Text(c.code, style: _kSubTitleStyle.copyWith(
            color: _kAccentRed,
          )),
        ),
      ],
    ));
    widgets.add(_kvRow('message', c.message ?? '(none)'));
    widgets.add(_kvRow('details', _safeArgsToString(c.details)));

    // Standard - encode and decode (which will throw)
    try {
      final bytes = stdCodec.encodeErrorEnvelope(
        code: c.code,
        message: c.message,
        details: c.details,
      );
      widgets.add(_kvRow(
        'Standard env size',
        '${_byteLength(bytes)} bytes',
      ));
      widgets.add(_codeBlock(_hexDump(bytes, maxBytes: 96),
          accent: _kAccentRed));
      try {
        final v = stdCodec.decodeEnvelope(bytes);
        widgets.add(_codeBlock(
          'unexpected: decodeEnvelope returned $v',
          accent: _kAccentOrange,
        ));
      } catch (e) {
        // Bridged native `PlatformException` is wrapped by d4rt in
        // `RuntimeD4rtException`, so the typed `on PlatformException`
        // filter does not match. Catch generically and display the
        // native `toString` (which includes code/message/details).
        widgets.add(Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: _kAccentRed.withOpacity(0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kAccentRed.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Caught error from decodeEnvelope',
                  style: _kSubTitleStyle.copyWith(color: _kAccentRed)),
              _codeBlock('$e', accent: _kAccentRed),
            ],
          ),
        ));
      }
    } catch (e) {
      widgets.add(_codeBlock('Standard envelope error: $e',
          accent: _kAccentRed));
    }

    // JSON
    if (c.details is! Uint8List) {
      try {
        final bytes = jsonCodec.encodeErrorEnvelope(
          code: c.code,
          message: c.message,
          details: c.details,
        );
        widgets.add(_kvRow(
          'JSON env size',
          '${_byteLength(bytes)} bytes',
        ));
        widgets.add(_codeBlock(_asciiDump(bytes, maxBytes: 96),
            accent: _kAccentOrange));
        try {
          final v = jsonCodec.decodeEnvelope(bytes);
          widgets.add(_codeBlock(
            'unexpected: decodeEnvelope returned $v',
            accent: _kAccentOrange,
          ));
        } catch (e) {
          // See comment above on the Standard branch — PlatformException
          // is wrapped by d4rt; catch generically and display via toString.
          widgets.add(Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: _kAccentOrange.withOpacity(0.06),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kAccentOrange.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Caught error from decodeEnvelope (JSON)',
                    style: _kSubTitleStyle.copyWith(color: _kAccentOrange)),
                _codeBlock('$e', accent: _kAccentOrange),
              ],
            ),
          ));
        }
      } catch (e) {
        widgets.add(_codeBlock('JSON envelope error: $e',
            accent: _kAccentRed));
      }
    }
  }

  return _buildSection(
    title: '6. Error envelopes',
    subtitle:
        'encodeErrorEnvelope and how decodeEnvelope translates errors into PlatformException.',
    accent: _kAccentRed,
    children: [
      _paragraph(
        'Error envelopes carry three fields: code (String, required), message '
        '(String, optional), and details (codec-encodable, optional). The '
        'envelope byte 0x01 marks an error and decodeEnvelope throws '
        'PlatformException when it encounters one.',
      ),
      ...widgets,
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 7: Wire format diagram
// -----------------------------------------------------------------------------

Widget _wireBox(String label, String hint, Color color, {double width = 80}) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.55), width: 1.4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hint,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: _kTextSecondary),
        ),
      ],
    ),
  );
}

Widget _wireRow(String title, List<Widget> boxes) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _kSubTitleStyle),
        const SizedBox(height: 6),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: boxes),
        ),
      ],
    ),
  );
}

Widget _section7WireFormat() {
  return _buildSection(
    title: '7. Wire-format diagrams',
    subtitle:
        'Bytes layouts for MethodCall, success envelope, and error envelope.',
    accent: _kAccentPurple,
    children: [
      _paragraph(
        'Both codecs share the same conceptual envelope (success vs. error '
        'distinguishing byte) but encode the actual payload very differently:',
      ),
      _wireRow('Standard MethodCall encoding', [
        _wireBox('TYPE', 'String tag', _kAccentBlue, width: 80),
        _wireBox('METHOD', 'utf-8 + len', _kAccentBlue, width: 100),
        _wireBox('TYPE', 'arg tag', _kAccentTeal, width: 80),
        _wireBox('ARGS', 'encoded value', _kAccentTeal, width: 110),
      ]),
      _wireRow('JSON MethodCall encoding', [
        _wireBox('{', 'JSON open', _kAccentOrange, width: 60),
        _wireBox('"method": "..."', 'method name', _kAccentOrange, width: 130),
        _wireBox('"args": ...', 'argument value', _kAccentOrange, width: 130),
        _wireBox('}', 'JSON close', _kAccentOrange, width: 60),
      ]),
      _divider(),
      _wireRow('Standard success envelope', [
        _wireBox('0x00', 'success tag', _kAccentGreen, width: 70),
        _wireBox('TYPE', 'result tag', _kAccentGreen, width: 80),
        _wireBox('RESULT', 'encoded result', _kAccentGreen, width: 110),
      ]),
      _wireRow('JSON success envelope', [
        _wireBox('[', 'JSON array', _kAccentGreen, width: 60),
        _wireBox('result', 'JSON value', _kAccentGreen, width: 90),
        _wireBox(']', 'close', _kAccentGreen, width: 60),
      ]),
      _divider(),
      _wireRow('Standard error envelope', [
        _wireBox('0x01', 'error tag', _kAccentRed, width: 70),
        _wireBox('CODE', 'String', _kAccentRed, width: 80),
        _wireBox('MESSAGE', 'String?', _kAccentRed, width: 100),
        _wireBox('DETAILS', 'value', _kAccentRed, width: 100),
      ]),
      _wireRow('JSON error envelope', [
        _wireBox('[', 'JSON array', _kAccentRed, width: 60),
        _wireBox('"code"', 'String', _kAccentRed, width: 80),
        _wireBox('"message"', 'String?', _kAccentRed, width: 100),
        _wireBox('details', 'value', _kAccentRed, width: 100),
        _wireBox(']', 'close', _kAccentRed, width: 60),
      ]),
      const SizedBox(height: 12),
      _paragraph(
        'For Standard, the leading byte 0x00 / 0x01 is what decodeEnvelope '
        'inspects first to decide success vs. error. For JSON, the array '
        'length tells it: 1 element = success, 3 elements = error.',
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 8: Comparison table
// -----------------------------------------------------------------------------

Widget _comparisonRow(String left, String mid, String right,
    {bool header = false}) {
  final style = header
      ? _kSubTitleStyle
      : _kBodyStyle;
  final cellPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
  final divider = const VerticalDivider(width: 1, color: _kBorderColor);
  return IntrinsicHeight(
    child: Row(
      children: [
        Expanded(flex: 2, child: Padding(padding: cellPadding, child: Text(left, style: style))),
        divider,
        Expanded(flex: 3, child: Padding(padding: cellPadding, child: Text(mid, style: style))),
        divider,
        Expanded(flex: 3, child: Padding(padding: cellPadding, child: Text(right, style: style))),
      ],
    ),
  );
}

Widget _section8Comparison() {
  return _buildSection(
    title: '8. Comparison: Standard vs JSON',
    subtitle: 'Pick the right codec for your platform plugin.',
    accent: _kAccentTeal,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: _kBorderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _kAccentTeal.withOpacity(0.08),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
              child: _comparisonRow('Aspect', 'Standard', 'JSON',
                  header: true),
            ),
            const Divider(height: 1, color: _kBorderColor),
            _comparisonRow('Format', 'Binary, length-prefixed',
                'UTF-8 JSON text'),
            const Divider(height: 1, color: _kBorderColor),
            _comparisonRow('Supported types',
                'null, bool, int, double, String, Uint8List, Int32List, Int64List, Float64List, List, Map',
                'null, bool, num, String, List, Map (no binary, no NaN/Infinity)'),
            const Divider(height: 1, color: _kBorderColor),
            _comparisonRow('Byte size', 'Compact, especially for binary',
                'Larger; quotes, commas, base10 numbers'),
            const Divider(height: 1, color: _kBorderColor),
            _comparisonRow('Performance',
                'Fast: no string parsing, direct typed-data',
                'Slower: jsonEncode/jsonDecode + UTF-8'),
            const Divider(height: 1, color: _kBorderColor),
            _comparisonRow('Debuggability',
                'Bytes; needs hex dump',
                'Plain text - readable in logs'),
            const Divider(height: 1, color: _kBorderColor),
            _comparisonRow('Use when',
                'You ship a Flutter plugin for iOS/Android and want the default; you transfer images/audio/buffers',
                'You bridge to a JS layer or REST/JSON gateway and want symmetry'),
            const Divider(height: 1, color: _kBorderColor),
            _comparisonRow('Avoid when',
                'You need human-readable logs over the wire',
                'You need to send binary blobs or NaN/Infinity'),
          ],
        ),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 9: Round-trip showcase (stepper)
// -----------------------------------------------------------------------------

class _RoundTripPanel extends StatefulWidget {
  const _RoundTripPanel();

  @override
  State<_RoundTripPanel> createState() => _RoundTripPanelState();
}

class _RoundTripPanelState extends State<_RoundTripPanel> {
  int _selected = 0;

  final List<MethodCall> _calls = const <MethodCall>[
    MethodCall('showSettings', null),
    MethodCall('shareText', <String, Object?>{
      'text': 'Hello',
      'subject': 'Hi',
    }),
    MethodCall('requestLocation', <String, Object?>{
      'accuracy': 'high',
      'timeoutMs': 5000,
    }),
    MethodCall('startScan', <Object?>['BLE', 'WIFI']),
  ];

  final List<Object?> _results = const <Object?>[
    null,
    true,
    <String, Object?>{
      'lat': 37.42,
      'lng': -122.08,
      'accuracy': 8.0,
    },
    <Object?>['device-1', 'device-2', 'device-3'],
  ];

  @override
  Widget build(BuildContext context) {
    final codec = const StandardMethodCodec();
    final call = _calls[_selected];
    final result = _results[_selected];

    final encodedCall = codec.encodeMethodCall(call);
    final decodedCall = codec.decodeMethodCall(encodedCall);
    final successEnv = codec.encodeSuccessEnvelope(result);
    final decodedSuccess = codec.decodeEnvelope(successEnv);

    final children = <Widget>[
      Wrap(
        spacing: 6,
        runSpacing: 6,
        children: List.generate(_calls.length, (i) {
          return ChoiceChip(
            label: Text(_calls[i].method),
            selected: _selected == i,
            onSelected: (v) {
              if (v) setState(() => _selected = i);
            },
          );
        }),
      ),
      const SizedBox(height: 12),
    ];

    Widget step(int n, String title, String detail, Color c, Widget body) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: c.withOpacity(0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: c,
                    child: Text(
                      '$n',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: _kSubTitleStyle.copyWith(color: c)),
                        Text(detail, style: _kSecondaryStyle),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              body,
            ],
          ),
        ),
      );
    }

    children.add(step(
      1,
      'Build call',
      'MethodCall(method, arguments) on Dart side',
      _kAccentBlue,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvRow('method', call.method),
          _kvRow('arguments', _safeArgsToString(call.arguments)),
        ],
      ),
    ));
    children.add(step(
      2,
      'Encode',
      'codec.encodeMethodCall(call) -> ByteData',
      _kAccentTeal,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvRow('byteLength', '${_byteLength(encodedCall)} bytes'),
          _codeBlock(_hexDump(encodedCall, maxBytes: 96),
              accent: _kAccentTeal),
        ],
      ),
    ));
    children.add(step(
      3,
      'Decode (host emulation)',
      'codec.decodeMethodCall(bytes) - host receives the call',
      _kAccentPurple,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvRow('decoded.method', decodedCall.method),
          _kvRow(
            'decoded.arguments',
            _safeArgsToString(decodedCall.arguments),
          ),
        ],
      ),
    ));
    children.add(step(
      4,
      'Encode success envelope',
      'host: codec.encodeSuccessEnvelope(result)',
      _kAccentGreen,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvRow('result', _safeArgsToString(result)),
          _kvRow('byteLength', '${_byteLength(successEnv)} bytes'),
          _codeBlock(_hexDump(successEnv, maxBytes: 96),
              accent: _kAccentGreen),
        ],
      ),
    ));
    children.add(step(
      5,
      'Decode envelope (Dart side)',
      'codec.decodeEnvelope(envelope) returns the result',
      _kAccentBlue,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvRow(
            'decoded',
            '${decodedSuccess?.runtimeType ?? 'Null'}: $decodedSuccess',
          ),
          _kvRow(
            'matchesOriginal',
            '${decodedSuccess?.toString() == result?.toString()}',
          ),
        ],
      ),
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

Widget _section9RoundTrip() {
  return _buildSection(
    title: '9. Round-trip showcase',
    subtitle:
        'Five-step stepper: build -> encode -> decode -> respond -> decode response.',
    accent: _kAccentBlue,
    children: const [
      _RoundTripPanel(),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 10: Error paths
// -----------------------------------------------------------------------------

Widget _section10ErrorPaths() {
  const stdCodec = StandardMethodCodec();
  const jsonCodec = JSONMethodCodec();

  String tryEncodeStd(Object? args) {
    try {
      final bytes =
          stdCodec.encodeMethodCall(MethodCall('test', args));
      return 'OK (${_byteLength(bytes)} bytes)';
    } catch (e) {
      return 'EX: $e';
    }
  }

  String tryEncodeJson(Object? args) {
    try {
      final bytes =
          jsonCodec.encodeMethodCall(MethodCall('test', args));
      return 'OK (${_byteLength(bytes)} bytes)';
    } catch (e) {
      return 'EX: $e';
    }
  }

  // Cyclic structure for JSON failure.
  final cyclic = <String, Object?>{};
  cyclic['self'] = cyclic;

  // A Function value - both codecs reject it.
  Object? funcArg = () => 1;

  // DateTime - not natively supported by either codec.
  final dt = DateTime(2024, 1, 1);

  // Nested map with double.nan - JSON fails on NaN.
  final nan = <String, Object?>{'x': double.nan};

  return _buildSection(
    title: '10. Error paths',
    subtitle: 'Unsupported types and structures, captured as exceptions.',
    accent: _kAccentRed,
    children: [
      _paragraph(
        'Codecs are strict about which Dart types they accept. Here are a few '
        'common failure modes; each row shows how StandardMethodCodec and '
        'JSONMethodCodec react to the same input.',
      ),
      _divider(),
      Text('Function value', style: _kSubTitleStyle),
      _kvRow('Standard', tryEncodeStd(funcArg)),
      _kvRow('JSON', tryEncodeJson(funcArg)),
      _divider(),
      Text('DateTime value', style: _kSubTitleStyle),
      _kvRow('Standard', tryEncodeStd(dt)),
      _kvRow('JSON', tryEncodeJson(dt)),
      _divider(),
      Text('NaN double inside a map', style: _kSubTitleStyle),
      _kvRow('Standard', tryEncodeStd(nan)),
      _kvRow('JSON', tryEncodeJson(nan)),
      _divider(),
      Text('Self-referential cyclic map', style: _kSubTitleStyle),
      _kvRow('Standard', tryEncodeStd(cyclic)),
      _kvRow('JSON', tryEncodeJson(cyclic)),
      _divider(),
      _paragraph(
        'Takeaway: catch encoding errors at the call site (not just at decode '
        'time). For Standard, NaN/Infinity round-trip fine for double values '
        'but will throw for typed-data variants. For JSON, NaN/Infinity are '
        'never legal.',
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 11: Recipe gallery
// -----------------------------------------------------------------------------

Widget _recipeCard({
  required String title,
  required String summary,
  required String code,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: _kSubTitleStyle.copyWith(color: accent)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(summary, style: _kSecondaryStyle),
        const SizedBox(height: 6),
        _codeBlock(code, accent: accent),
      ],
    ),
  );
}

Widget _section11Recipes() {
  return _buildSection(
    title: '11. Recipe gallery',
    subtitle: 'Common patterns you can paste and adapt.',
    accent: _kAccentPurple,
    children: [
      _recipeCard(
        title: 'Battery level via Standard',
        summary:
            'Most direct usage: a no-arg call returning a double, default codec.',
        code: '''const channel = MethodChannel('battery');
final double level = await channel.invokeMethod<double>('getBatteryLevel');
print('battery: \$level');''',
        accent: _kAccentBlue,
        icon: Icons.battery_full,
      ),
      _recipeCard(
        title: 'Settings via JSON',
        summary:
            'Use JSONMethodCodec when you bridge to a JS or HTTP layer.',
        code: '''const channel = MethodChannel(
  'settings',
  JSONMethodCodec(),
);
final result = await channel.invokeMethod<Map<String, Object?>>(
  'load',
  <String, Object?>{'profile': 'default'},
);''',
        accent: _kAccentOrange,
        icon: Icons.settings,
      ),
      _recipeCard(
        title: 'Image upload with Uint8List (Standard)',
        summary:
            'Send binary data without base64 round-trips. Standard only.',
        code: '''const channel = MethodChannel('upload');
final Uint8List bytes = await readImageBytes();
final receiptId = await channel.invokeMethod<String>(
  'uploadImage',
  bytes,
);''',
        accent: _kAccentTeal,
        icon: Icons.image,
      ),
      _recipeCard(
        title: 'Platform plugin handler skeleton',
        summary:
            'How a host-side handler reacts to encoded calls and returns envelopes.',
        code: '''const codec = StandardMethodCodec();

ByteData handle(ByteData input) {
  final call = codec.decodeMethodCall(input);
  switch (call.method) {
    case 'getBatteryLevel':
      return codec.encodeSuccessEnvelope(0.85);
    case 'requestLocation':
      return codec.encodeErrorEnvelope(
        code: 'PERMISSION_DENIED',
        message: 'No location access',
      );
    default:
      return codec.encodeErrorEnvelope(
        code: 'NOT_IMPLEMENTED',
        message: 'unknown method \${call.method}',
      );
  }
}''',
        accent: _kAccentPurple,
        icon: Icons.extension,
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Section 12: Reference table
// -----------------------------------------------------------------------------

Widget _refRow(List<String> cells, {bool header = false}) {
  final style = header
      ? _kSubTitleStyle.copyWith(fontSize: 14)
      : _kBodyStyle;
  return IntrinsicHeight(
    child: Row(
      children: [
        for (var i = 0; i < cells.length; i++) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 6),
              child: Text(cells[i], style: style),
            ),
          ),
          if (i != cells.length - 1)
            const VerticalDivider(width: 1, color: _kBorderColor),
        ],
      ],
    ),
  );
}

Widget _section12ReferenceTable() {
  return _buildSection(
    title: '12. Reference table',
    subtitle:
        'Pairing Dart codecs with their iOS / Android / Web counterparts.',
    accent: _kAccentTeal,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: _kBorderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _kAccentTeal.withOpacity(0.08),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
              child: _refRow(
                <String>['Dart codec', 'Supported value types', 'Envelope', 'Pair on host'],
                header: true,
              ),
            ),
            const Divider(height: 1, color: _kBorderColor),
            _refRow(<String>[
              'StandardMethodCodec',
              'null, bool, int, double, String, Uint8List, Int32List, Int64List, Float64List, List, Map',
              '0x00 | result  /  0x01 | code | message | details',
              'iOS: FlutterStandardMethodCodec / Android: StandardMethodCodec',
            ]),
            const Divider(height: 1, color: _kBorderColor),
            _refRow(<String>[
              'JSONMethodCodec',
              'null, bool, num, String, List, Map (no NaN, no buffers)',
              'JSON: [result]  /  [code, message, details]',
              'iOS: FlutterJSONMethodCodec / Android: JSONMethodCodec',
            ]),
            const Divider(height: 1, color: _kBorderColor),
            _refRow(<String>[
              'StandardMessageCodec',
              'Same as StandardMethodCodec but for BasicMessageChannel',
              'no envelope (raw value)',
              'iOS: FlutterStandardMessageCodec / Android: StandardMessageCodec',
            ]),
            const Divider(height: 1, color: _kBorderColor),
            _refRow(<String>[
              'BinaryCodec',
              'ByteData (raw bytes only)',
              'no envelope',
              'Used by both sides for raw byte channels',
            ]),
            const Divider(height: 1, color: _kBorderColor),
            _refRow(<String>[
              'StringCodec',
              'String (UTF-8)',
              'no envelope',
              'Used for String-only message channels',
            ]),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// Build entry
// =============================================================================

dynamic build(BuildContext context) {
  print('=== MethodCodec Deep Demo (Harness-Safe) ===');

  // Eagerly exercise every required codec API so the demo's correctness
  // is visible even before the user touches any interactive panel.
  const stdCodec = StandardMethodCodec();
  const jsonCodec = JSONMethodCodec();

  // Standard: encode/decode a method call.
  final stdCall = const MethodCall('boot', <String, Object?>{
    'cold': true,
    'attempt': 1,
  });
  final stdEnc = stdCodec.encodeMethodCall(stdCall);
  final stdDec = stdCodec.decodeMethodCall(stdEnc);
  print(
      'Standard encodeMethodCall -> ${_byteLength(stdEnc)} bytes; decode method=${stdDec.method}');

  final stdSucc = stdCodec.encodeSuccessEnvelope('ready');
  print(
      'Standard encodeSuccessEnvelope -> ${_byteLength(stdSucc)} bytes; decode=${stdCodec.decodeEnvelope(stdSucc)}');

  final stdErr = stdCodec.encodeErrorEnvelope(
    code: 'BOOT_FAIL',
    message: 'unable to start',
    details: <String, Object?>{'attempt': 1},
  );
  try {
    stdCodec.decodeEnvelope(stdErr);
  } catch (e) {
    // Native `PlatformException` thrown by the codec is wrapped by the
    // d4rt bridge in `RuntimeD4rtException`, so the typed `on
    // PlatformException catch` does not engage. Catch generically and
    // rely on the native `toString` (which includes code/message/details
    // in its formatted output).
    print('Standard decodeEnvelope (error) -> $e');
  }

  // JSON: encode/decode a method call.
  final jsonCall = const MethodCall('boot', <String, Object?>{
    'cold': true,
    'attempt': 1,
  });
  final jsonEnc = jsonCodec.encodeMethodCall(jsonCall);
  final jsonDec = jsonCodec.decodeMethodCall(jsonEnc);
  print(
      'JSON encodeMethodCall -> ${_byteLength(jsonEnc)} bytes; decode method=${jsonDec.method}');

  final jsonSucc = jsonCodec.encodeSuccessEnvelope('ready');
  print(
      'JSON encodeSuccessEnvelope -> ${_byteLength(jsonSucc)} bytes; decode=${jsonCodec.decodeEnvelope(jsonSucc)}');

  final jsonErrEnv = jsonCodec.encodeErrorEnvelope(
    code: 'BOOT_FAIL',
    message: 'unable to start',
    details: <String, Object?>{'attempt': 1},
  );
  try {
    jsonCodec.decodeEnvelope(jsonErrEnv);
  } catch (e) {
    // See note above on the StandardMethodCodec error block — bridged
    // PlatformException is wrapped by d4rt; catch generically.
    print('JSON decodeEnvelope (error) -> $e');
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MethodCodec Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccentBlue),
      scaffoldBackgroundColor: _kBgColor,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: _kBgColor,
      appBar: AppBar(
        title: const Text('MethodCodec Deep Demo'),
        backgroundColor: _kAccentBlue,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('MethodCodec', style: _kHeaderStyle),
              const SizedBox(height: 4),
              const Text(
                'Encoding and decoding platform-channel traffic between Dart and host.',
                style: _kSecondaryStyle,
              ),
              const SizedBox(height: 16),
              _section1Intro(),
              _section2EncodeMethodCall(),
              _section3Standard(),
              _section4Json(),
              _section5SuccessEnvelope(),
              _section6ErrorEnvelope(),
              _section7WireFormat(),
              _section8Comparison(),
              _section9RoundTrip(),
              _section10ErrorPaths(),
              _section11Recipes(),
              _section12ReferenceTable(),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kSurfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kBorderColor),
                ),
                child: const Text(
                  'End of demo. Every panel above was rendered using only '
                  'StandardMethodCodec and JSONMethodCodec, with all five '
                  'MethodCodec API methods exercised on real bytes.',
                  style: _kSecondaryStyle,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
