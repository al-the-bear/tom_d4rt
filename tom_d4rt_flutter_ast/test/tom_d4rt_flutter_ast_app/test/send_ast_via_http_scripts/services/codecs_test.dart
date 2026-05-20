// D4rt test script: Deep visual demo of platform-channel codecs.
//
// Theme: "The platform-channel codec lab" — visualizing how Dart values
// become bytes on the wire and come back. Demonstrates:
//   - StandardMessageCodec round-trips (with hexdump per value)
//   - JSONMessageCodec round-trips and byte-size trade-offs
//   - StringCodec UTF-8 byte breakdown
//   - BinaryCodec ByteData passthrough
//   - StandardMethodCodec / JSONMethodCodec envelopes
//   - Simulated platform-channel exchange (method call -> faux native -> reply)
//   - Codec selection cheat-sheet
//
// Built for the analyzer-free AST corpus, executed by the d4rt interpreter.
// Note: `Uint8List` / `ByteData` come transitively through
// `package:flutter/services.dart` (which re-exports `dart:typed_data`).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Uint8List _bytesOf(ByteData? bd) {
  if (bd == null) return Uint8List(0);
  return bd.buffer.asUint8List(bd.offsetInBytes, bd.lengthInBytes);
}

String _hex2(int b) {
  final s = b.toRadixString(16);
  return s.length == 1 ? '0$s' : s;
}

String _hexString(Uint8List bytes, {int? limit}) {
  final n = (limit != null && limit < bytes.length) ? limit : bytes.length;
  final sb = StringBuffer();
  for (var i = 0; i < n; i++) {
    if (i > 0) sb.write(' ');
    sb.write(_hex2(bytes[i]));
  }
  if (n < bytes.length) {
    sb.write(' …');
  }
  return sb.toString();
}

String _asciiPreview(Uint8List bytes, {int? limit}) {
  final n = (limit != null && limit < bytes.length) ? limit : bytes.length;
  final sb = StringBuffer();
  for (var i = 0; i < n; i++) {
    final b = bytes[i];
    if (b >= 0x20 && b < 0x7f) {
      sb.writeCharCode(b);
    } else {
      sb.write('.');
    }
  }
  return sb.toString();
}

// Pure-Dart UTF-8 encoder, sufficient for the demo strings (no surrogate fixups
// — d4rt scripts keep the surface API small).
Uint8List _utf8Encode(String s) {
  final out = <int>[];
  for (var i = 0; i < s.length; i++) {
    var code = s.codeUnitAt(i);
    // Combine surrogate pair into a single codepoint.
    if (code >= 0xD800 && code <= 0xDBFF && i + 1 < s.length) {
      final next = s.codeUnitAt(i + 1);
      if (next >= 0xDC00 && next <= 0xDFFF) {
        code = 0x10000 + ((code - 0xD800) << 10) + (next - 0xDC00);
        i++;
      }
    }
    if (code < 0x80) {
      out.add(code);
    } else if (code < 0x800) {
      out.add(0xC0 | (code >> 6));
      out.add(0x80 | (code & 0x3F));
    } else if (code < 0x10000) {
      out.add(0xE0 | (code >> 12));
      out.add(0x80 | ((code >> 6) & 0x3F));
      out.add(0x80 | (code & 0x3F));
    } else {
      out.add(0xF0 | (code >> 18));
      out.add(0x80 | ((code >> 12) & 0x3F));
      out.add(0x80 | ((code >> 6) & 0x3F));
      out.add(0x80 | (code & 0x3F));
    }
  }
  return Uint8List.fromList(out);
}

// Classify a UTF-8 leading byte into a codepoint-range label.
String _utf8RangeLabel(int leadByte) {
  if (leadByte < 0x80) return 'ASCII';
  if (leadByte < 0xC0) return 'cont';
  if (leadByte < 0xE0) return '2-byte';
  if (leadByte < 0xF0) return '3-byte';
  return '4-byte';
}

Color _utf8RangeColor(String label) {
  switch (label) {
    case 'ASCII':
      return const Color(0xFF1976D2);
    case '2-byte':
      return const Color(0xFF388E3C);
    case '3-byte':
      return const Color(0xFFF57C00);
    case '4-byte':
      return const Color(0xFFC2185B);
    default:
      return const Color(0xFF616161);
  }
}

dynamic build(BuildContext context) {
  debugPrint('=== platform-channel codec lab — deep demo ===');

  // --- shared codec instances ---
  const stdMessageCodec = StandardMessageCodec();
  const jsonMessageCodec = JSONMessageCodec();
  const stringCodec = StringCodec();
  const binaryCodec = BinaryCodec();
  const stdMethodCodec = StandardMethodCodec();
  const jsonMethodCodec = JSONMethodCodec();

  // =====================================================================
  // SECTION 1: Hero header — why codecs exist
  // =====================================================================
  debugPrint('--- SECTION 1: hero header ---');

  final hero = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF00838F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.cable, size: 40.0, color: Colors.white),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'The Platform-Channel Codec Lab',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'Platform channels carry messages between Dart and the host '
          'process. A codec is what turns a Dart value into a byte buffer '
          'on one side and back into a value on the other.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.92),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _PipelineNode(label: 'Dart value', icon: Icons.code),
              _PipelineArrow(label: 'encode'),
              _PipelineNode(label: 'bytes', icon: Icons.memory),
              _PipelineArrow(label: 'IPC'),
              _PipelineNode(label: 'bytes', icon: Icons.memory),
              _PipelineArrow(label: 'decode'),
              _PipelineNode(label: 'value', icon: Icons.check_circle),
            ],
          ),
        ),
      ],
    ),
  );

  // =====================================================================
  // SECTION 2: StandardMessageCodec round-trip table
  // =====================================================================
  debugPrint('--- SECTION 2: StandardMessageCodec round-trips ---');

  final stdInputs = <Map<String, dynamic>>[
    {'label': 'null', 'value': null},
    {'label': 'true', 'value': true},
    {'label': 'int 42', 'value': 42},
    {'label': 'double 3.14', 'value': 3.14},
    {'label': 'String "hello"', 'value': 'hello'},
    {
      'label': 'List [1,2,3]',
      'value': const <int>[1, 2, 3],
    },
    {
      'label': 'Map {a:1,b:2}',
      'value': const <String, int>{'a': 1, 'b': 2},
    },
    {
      'label': 'Uint8List 4B',
      'value': Uint8List.fromList(const [1, 2, 3, 4]),
    },
    {
      'label': 'nested map',
      'value': const <String, dynamic>{
        'name': 'cam',
        'opts': <String, dynamic>{'fps': 30, 'hdr': true},
        'tags': <String>['a', 'b'],
      },
    },
  ];

  final stdCards = <Widget>[];
  for (final entry in stdInputs) {
    final label = entry['label'] as String;
    final value = entry['value'];
    final bd = stdMessageCodec.encodeMessage(value);
    final bytes = _bytesOf(bd);
    final decoded = stdMessageCodec.decodeMessage(bd);
    debugPrint(
      '[std] $label -> ${bytes.length}B  ${_hexString(bytes, limit: 24)}',
    );
    stdCards.add(
      _RoundTripCard(
        title: label,
        valueText: '$value',
        bytes: bytes,
        decodedText: '$decoded',
        accent: const Color(0xFF1976D2),
      ),
    );
  }

  // =====================================================================
  // SECTION 3: JSONMessageCodec round-trips
  // =====================================================================
  debugPrint('--- SECTION 3: JSONMessageCodec round-trips ---');

  final jsonInputs = <Map<String, dynamic>>[
    {'label': 'null', 'value': null},
    {'label': 'true', 'value': true},
    {'label': 'int 42', 'value': 42},
    {'label': 'double 3.14', 'value': 3.14},
    {'label': 'String "hello"', 'value': 'hello'},
    {
      'label': 'List [1,2,3]',
      'value': const <int>[1, 2, 3],
    },
    {
      'label': 'Map {a:1,b:2}',
      'value': const <String, int>{'a': 1, 'b': 2},
    },
    {
      'label': 'nested map',
      'value': const <String, dynamic>{
        'name': 'cam',
        'opts': <String, dynamic>{'fps': 30, 'hdr': true},
        'tags': <String>['a', 'b'],
      },
    },
  ];

  final jsonCards = <Widget>[];
  final sizeCompareRows = <Widget>[];
  for (final entry in jsonInputs) {
    final label = entry['label'] as String;
    final value = entry['value'];
    final bd = jsonMessageCodec.encodeMessage(value);
    final bytes = _bytesOf(bd);
    final decoded = jsonMessageCodec.decodeMessage(bd);
    final jsonText = String.fromCharCodes(bytes);
    debugPrint('[json] $label -> ${bytes.length}B  $jsonText');
    jsonCards.add(
      _JsonCard(
        title: label,
        valueText: '$value',
        jsonText: jsonText,
        bytes: bytes,
        decodedText: '$decoded',
      ),
    );

    // Compute the standard-codec byte size for the same input for comparison.
    final stdBd = stdMessageCodec.encodeMessage(value);
    final stdBytes = _bytesOf(stdBd);
    sizeCompareRows.add(
      _SizeCompareRow(
        label: label,
        jsonBytes: bytes.length,
        stdBytes: stdBytes.length,
      ),
    );
  }

  // =====================================================================
  // SECTION 4: StringCodec — UTF-8 byte breakdown
  // =====================================================================
  debugPrint('--- SECTION 4: StringCodec UTF-8 breakdown ---');

  final utf8Samples = const <String>['Hello', 'Привет', '你好', '🎯🚀'];
  final utf8Cards = <Widget>[];
  for (final sample in utf8Samples) {
    final bd = stringCodec.encodeMessage(sample);
    final bytes = _bytesOf(bd);
    // StringCodec emits UTF-8 — both codecs should agree.
    final ourBytes = _utf8Encode(sample);
    final decoded = stringCodec.decodeMessage(bd);
    debugPrint(
      '[utf8] "$sample" sdk=${bytes.length}B local=${ourBytes.length}B '
      'hex=${_hexString(bytes, limit: 32)} decoded="$decoded"',
    );
    utf8Cards.add(
      _Utf8Card(sample: sample, bytes: bytes, decodedText: '$decoded'),
    );
  }

  // =====================================================================
  // SECTION 5: BinaryCodec passthrough
  // =====================================================================
  debugPrint('--- SECTION 5: BinaryCodec passthrough ---');

  final binaryInput = ByteData(16);
  for (var i = 0; i < 16; i++) {
    binaryInput.setUint8(i, (i * 17 + 3) & 0xFF);
  }
  final binaryEncoded = binaryCodec.encodeMessage(binaryInput);
  final binaryDecoded = binaryCodec.decodeMessage(binaryEncoded);
  final binaryInBytes = _bytesOf(binaryInput);
  final binaryEncBytes = _bytesOf(binaryEncoded);
  final binaryDecBytes = _bytesOf(binaryDecoded);
  debugPrint(
    '[binary] in=${binaryInBytes.length}B enc=${binaryEncBytes.length}B '
    'dec=${binaryDecBytes.length}B',
  );
  debugPrint('[binary] hex=${_hexString(binaryEncBytes)}');

  final binaryPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFFFB300), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.swap_horiz, color: Color(0xFFFF6F00)),
            SizedBox(width: 8.0),
            Text(
              'BinaryCodec — identity on ByteData',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Color(0xFF6D4C41),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'BinaryCodec.encodeMessage / decodeMessage return the same '
          'ByteData. The bytes never change shape — they only change owner.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF5D4037)),
        ),
        const SizedBox(height: 10.0),
        _HexPanel(bytes: binaryEncBytes, showAscii: true),
        const SizedBox(height: 6.0),
        Row(
          children: [
            _StatChip(
              label: 'in',
              value: '${binaryInBytes.length}B',
              color: const Color(0xFF6D4C41),
            ),
            const SizedBox(width: 6.0),
            _StatChip(
              label: 'encoded',
              value: '${binaryEncBytes.length}B',
              color: const Color(0xFFFF6F00),
            ),
            const SizedBox(width: 6.0),
            _StatChip(
              label: 'decoded',
              value: '${binaryDecBytes.length}B',
              color: const Color(0xFF558B2F),
            ),
          ],
        ),
      ],
    ),
  );

  // =====================================================================
  // SECTION 6: StandardMethodCodec — MethodCall envelope
  // =====================================================================
  debugPrint('--- SECTION 6: StandardMethodCodec envelope ---');

  const camCall = MethodCall('openCamera', <String, dynamic>{
    'mode': 'front',
    'fps': 30,
    'hdr': true,
  });
  final stdCallBd = stdMethodCodec.encodeMethodCall(camCall);
  final stdCallBytes = _bytesOf(stdCallBd);
  final stdCallRoundTrip = stdMethodCodec.decodeMethodCall(stdCallBd);
  debugPrint(
    '[std-method] openCamera ${stdCallBytes.length}B  '
    '${_hexString(stdCallBytes, limit: 32)}',
  );
  debugPrint(
    '[std-method] decoded: method=${stdCallRoundTrip.method} '
    'args=${stdCallRoundTrip.arguments}',
  );

  // Success envelope.
  final stdSuccessBd = stdMethodCodec.encodeSuccessEnvelope(<String, dynamic>{
    'sessionId': 'cam-001',
    'ready': true,
  });
  final stdSuccessBytes = _bytesOf(stdSuccessBd);
  final stdSuccessDecoded = stdMethodCodec.decodeEnvelope(stdSuccessBd);
  debugPrint(
    '[std-method] success envelope ${stdSuccessBytes.length}B  '
    '$stdSuccessDecoded',
  );

  // Error envelope.
  final stdErrorBd = stdMethodCodec.encodeErrorEnvelope(
    code: 'CAMERA_UNAVAILABLE',
    message: 'No camera matches the requested mode.',
    details: const <String, dynamic>{'requested': 'front'},
  );
  final stdErrorBytes = _bytesOf(stdErrorBd);
  String stdErrorOutcome;
  try {
    stdMethodCodec.decodeEnvelope(stdErrorBd);
    stdErrorOutcome = '(no exception — unexpected)';
  } on PlatformException catch (e) {
    stdErrorOutcome =
        'PlatformException(code=${e.code}, message=${e.message})';
  }
  debugPrint(
    '[std-method] error envelope ${stdErrorBytes.length}B -> $stdErrorOutcome',
  );

  final methodEnvelopePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFF3949AB), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'StandardMethodCodec — MethodCall envelope structure',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 8.0),
        _EnvelopeRow(
          label: 'method call',
          subtitle:
              "MethodCall('openCamera', {'mode':'front', 'fps':30, 'hdr':true})",
          bytes: stdCallBytes,
          accent: const Color(0xFF3949AB),
        ),
        const SizedBox(height: 8.0),
        _EnvelopeRow(
          label: 'success reply',
          subtitle: 'decoded: $stdSuccessDecoded',
          bytes: stdSuccessBytes,
          accent: const Color(0xFF2E7D32),
        ),
        const SizedBox(height: 8.0),
        _EnvelopeRow(
          label: 'error reply',
          subtitle: stdErrorOutcome,
          bytes: stdErrorBytes,
          accent: const Color(0xFFC62828),
        ),
      ],
    ),
  );

  // =====================================================================
  // SECTION 7: JSONMethodCodec — same call as JSON
  // =====================================================================
  debugPrint('--- SECTION 7: JSONMethodCodec envelope ---');

  final jsonCallBd = jsonMethodCodec.encodeMethodCall(camCall);
  final jsonCallBytes = _bytesOf(jsonCallBd);
  final jsonCallDecoded = jsonMethodCodec.decodeMethodCall(jsonCallBd);
  final jsonCallText = String.fromCharCodes(jsonCallBytes);
  debugPrint(
    '[json-method] openCamera ${jsonCallBytes.length}B  $jsonCallText',
  );
  debugPrint(
    '[json-method] decoded: method=${jsonCallDecoded.method} '
    'args=${jsonCallDecoded.arguments}',
  );

  final jsonSuccessBd = jsonMethodCodec.encodeSuccessEnvelope(
    const <String, dynamic>{'sessionId': 'cam-001', 'ready': true},
  );
  final jsonSuccessBytes = _bytesOf(jsonSuccessBd);
  final jsonSuccessDecoded = jsonMethodCodec.decodeEnvelope(jsonSuccessBd);
  debugPrint(
    '[json-method] success ${jsonSuccessBytes.length}B  $jsonSuccessDecoded',
  );

  final methodSideBySide = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: _MethodSidePanel(
          title: 'StandardMethodCodec',
          subtitle: 'binary, compact',
          bytes: stdCallBytes,
          accent: const Color(0xFF3949AB),
          extra: 'success ${stdSuccessBytes.length}B  '
              'error ${stdErrorBytes.length}B',
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: _MethodSidePanel(
          title: 'JSONMethodCodec',
          subtitle: 'utf-8 json, human-readable',
          bytes: jsonCallBytes,
          accent: const Color(0xFF00838F),
          extra: jsonCallText,
        ),
      ),
    ],
  );

  // =====================================================================
  // SECTION 8: Simulated message exchange
  // =====================================================================
  debugPrint('--- SECTION 8: simulated platform exchange ---');

  // Dart side encodes a method call.
  const exchangeCall = MethodCall('ping', <String, dynamic>{'n': 3});
  final outboundBd = stdMethodCodec.encodeMethodCall(exchangeCall);
  final outboundBytes = _bytesOf(outboundBd);

  // Faux native side: decode, fabricate a response, re-encode.
  final fauxNativeReplyBytes = _fauxNativeHandle(outboundBd);
  final inboundBd = ByteData.view(fauxNativeReplyBytes.buffer);
  final inboundBytes = _bytesOf(inboundBd);
  final replyValue = stdMethodCodec.decodeEnvelope(inboundBd);

  debugPrint(
    '[exchange] outbound ${outboundBytes.length}B '
    '${_hexString(outboundBytes, limit: 24)}',
  );
  debugPrint(
    '[exchange] inbound  ${inboundBytes.length}B '
    '${_hexString(inboundBytes, limit: 24)}',
  );
  debugPrint('[exchange] reply value=$replyValue');

  final exchangePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFF00838F), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Simulated channel round-trip: Dart → faux native → Dart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Color(0xFF006064),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _ExchangeBox(
                title: 'Dart',
                subtitle: "MethodCall('ping', {n:3})",
                accent: const Color(0xFF1976D2),
              ),
            ),
            const _ExchangeArrow(label: 'encode'),
            Expanded(
              child: _HexPanel(bytes: outboundBytes, showAscii: false),
            ),
            const _ExchangeArrow(label: 'IPC'),
            Expanded(
              child: _ExchangeBox(
                title: 'native',
                subtitle: 'pong x3',
                accent: const Color(0xFFC2185B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _ExchangeBox(
                title: 'Dart',
                subtitle: 'reply: $replyValue',
                accent: const Color(0xFF1976D2),
              ),
            ),
            const _ExchangeArrow(label: 'decode'),
            Expanded(
              child: _HexPanel(bytes: inboundBytes, showAscii: false),
            ),
            const _ExchangeArrow(label: 'IPC'),
            Expanded(
              child: _ExchangeBox(
                title: 'native',
                subtitle: 'encode reply',
                accent: const Color(0xFFC2185B),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // =====================================================================
  // SECTION 9: Codec selection cheat-sheet
  // =====================================================================
  debugPrint('--- SECTION 9: cheat-sheet ---');

  final cheatRows = const <_CheatRow>[
    _CheatRow(
      codec: 'StandardMessageCodec',
      carries: 'null, bool, int, double, String, list, map, Uint8List',
      efficiency: 'compact binary',
      useCase: 'general-purpose Dart↔native messages',
      accent: Color(0xFF1976D2),
    ),
    _CheatRow(
      codec: 'JSONMessageCodec',
      carries: 'JSON-compatible primitives, list, map',
      efficiency: 'verbose utf-8',
      useCase: 'debuggable, web-friendly channels',
      accent: Color(0xFF00838F),
    ),
    _CheatRow(
      codec: 'StringCodec',
      carries: 'String',
      efficiency: 'utf-8 only',
      useCase: 'string-only channels',
      accent: Color(0xFF6A1B9A),
    ),
    _CheatRow(
      codec: 'BinaryCodec',
      carries: 'ByteData (passthrough)',
      efficiency: 'identity',
      useCase: 'raw byte transport',
      accent: Color(0xFFF57C00),
    ),
    _CheatRow(
      codec: 'StandardMethodCodec',
      carries: 'MethodCall + success/error envelopes (binary)',
      efficiency: 'compact binary',
      useCase: 'most platform channels',
      accent: Color(0xFF2E7D32),
    ),
    _CheatRow(
      codec: 'JSONMethodCodec',
      carries: 'MethodCall + envelopes (JSON)',
      efficiency: 'verbose utf-8',
      useCase: 'web platform channels',
      accent: Color(0xFFC2185B),
    ),
  ];

  final cheatSheet = Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFF6A1B9A), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Codec selection cheat-sheet',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 10.0),
        Column(children: cheatRows.map(_buildCheatRow).toList()),
      ],
    ),
  );

  // UTF-8 legend.
  final utf8Legend = Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFB39DDB), width: 1.0),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 6.0,
      children: const [
        _LegendDot(label: 'ASCII (1B)', color: Color(0xFF1976D2)),
        _LegendDot(label: '2-byte', color: Color(0xFF388E3C)),
        _LegendDot(label: '3-byte', color: Color(0xFFF57C00)),
        _LegendDot(label: '4-byte', color: Color(0xFFC2185B)),
        _LegendDot(label: 'continuation', color: Color(0xFF616161)),
      ],
    ),
  );

  // =====================================================================
  // Final layout
  // =====================================================================
  debugPrint('=== codec lab demo: building final layout ===');

  return Scaffold(
    backgroundColor: const Color(0xFFFAFAFA),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            const SizedBox(height: 18.0),

            // SECTION 2
            const _SectionHeader(
              n: 2,
              title: 'StandardMessageCodec — round-trip table',
              blurb:
                  'Each input value is encoded to bytes and decoded back. '
                  'The hex column shows the actual wire format; the byte-count '
                  'chip tells you how much you pay per value.',
              accent: Color(0xFF1976D2),
            ),
            Column(children: stdCards),
            const SizedBox(height: 14.0),

            // SECTION 3
            const _SectionHeader(
              n: 3,
              title: 'JSONMessageCodec — same values, JSON wire',
              blurb:
                  'JSON cannot carry Uint8List directly, so that input is '
                  'omitted. The JSON form is more verbose but easier to '
                  'debug across language boundaries.',
              accent: Color(0xFF00838F),
            ),
            Column(children: jsonCards),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Byte-size trade-off: JSON vs Standard',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Column(children: sizeCompareRows),
                ],
              ),
            ),
            const SizedBox(height: 14.0),

            // SECTION 4
            const _SectionHeader(
              n: 4,
              title: 'StringCodec — UTF-8 byte breakdown',
              blurb:
                  'StringCodec maps a Dart String to its UTF-8 byte sequence. '
                  'Each byte is colored by codepoint range so you can see '
                  'why a Cyrillic, CJK, or emoji string is bigger than its '
                  'character count.',
              accent: Color(0xFF6A1B9A),
            ),
            utf8Legend,
            Column(children: utf8Cards),
            const SizedBox(height: 14.0),

            // SECTION 5
            const _SectionHeader(
              n: 5,
              title: 'BinaryCodec — ByteData passthrough',
              blurb:
                  'BinaryCodec performs no transformation. encodeMessage '
                  'returns its input and decodeMessage does the same — the '
                  'codec exists so platform channels can carry opaque '
                  'binary blobs.',
              accent: Color(0xFFF57C00),
            ),
            binaryPanel,
            const SizedBox(height: 14.0),

            // SECTION 6
            const _SectionHeader(
              n: 6,
              title: 'StandardMethodCodec — MethodCall envelopes',
              blurb:
                  'A method call is encoded as method name + arguments. '
                  'Replies use either a success envelope (single value) or '
                  'an error envelope that decodes back into a '
                  'PlatformException.',
              accent: Color(0xFF3949AB),
            ),
            methodEnvelopePanel,
            const SizedBox(height: 14.0),

            // SECTION 7
            const _SectionHeader(
              n: 7,
              title: 'JSONMethodCodec — side-by-side',
              blurb:
                  'Same MethodCall encoded both ways. The JSON wire is '
                  'larger but you can paste it into a logger and read it.',
              accent: Color(0xFF00838F),
            ),
            methodSideBySide,
            const SizedBox(height: 14.0),

            // SECTION 8
            const _SectionHeader(
              n: 8,
              title: 'Simulated channel exchange',
              blurb:
                  'A faux "native" function lives in this same file. It '
                  'decodes the outbound call, fabricates a response, and '
                  'encodes a reply. The Dart side then decodes the envelope.',
              accent: Color(0xFF00838F),
            ),
            exchangePanel,
            const SizedBox(height: 14.0),

            // SECTION 9
            const _SectionHeader(
              n: 9,
              title: 'Cheat-sheet — picking a codec',
              blurb:
                  'A quick reference for which codec to reach for. In '
                  'practice you almost always start with StandardMethodCodec.',
              accent: Color(0xFF6A1B9A),
            ),
            cheatSheet,

            const SizedBox(height: 18.0),
            Center(
              child: Text(
                'platform-channel codec lab — demo complete',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Faux "native" side for the simulated exchange
// ---------------------------------------------------------------------------

Uint8List _fauxNativeHandle(ByteData call) {
  const codec = StandardMethodCodec();
  final decoded = codec.decodeMethodCall(call);
  // The "native" peer responds based on the method name.
  if (decoded.method == 'ping') {
    final args = decoded.arguments;
    var n = 1;
    if (args is Map && args['n'] is int) {
      n = args['n'] as int;
    }
    final pongs = <String>[for (var i = 0; i < n; i++) 'pong'];
    final replyBd = codec.encodeSuccessEnvelope(<String, dynamic>{
      'echoed': decoded.method,
      'pongs': pongs,
    });
    return _bytesOf(replyBd);
  }
  final fallback = codec.encodeErrorEnvelope(
    code: 'UNKNOWN_METHOD',
    message: 'faux native does not know ${decoded.method}',
  );
  return _bytesOf(fallback);
}

// ---------------------------------------------------------------------------
// Cheat-row helper
// ---------------------------------------------------------------------------

Widget _buildCheatRow(_CheatRow r) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: r.accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: r.accent.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: r.accent,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r.codec,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: r.accent,
                ),
              ),
              Text(
                r.useCase,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            r.carries,
            style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFF424242),
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: r.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            r.efficiency,
            style: TextStyle(
              fontSize: 10.0,
              color: r.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Private support widgets
// ---------------------------------------------------------------------------

class _CheatRow {
  final String codec;
  final String carries;
  final String efficiency;
  final String useCase;
  final Color accent;

  const _CheatRow({
    required this.codec,
    required this.carries,
    required this.efficiency,
    required this.useCase,
    required this.accent,
  });
}

class _SectionHeader extends StatelessWidget {
  final int n;
  final String title;
  final String blurb;
  final Color accent;

  const _SectionHeader({
    required this.n,
    required this.title,
    required this.blurb,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: accent, width: 4.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$n',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            blurb,
            style: const TextStyle(fontSize: 12.0, color: Color(0xFF424242)),
          ),
        ],
      ),
    );
  }
}

class _PipelineNode extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PipelineNode({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 22.0),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _PipelineArrow extends StatelessWidget {
  final String label;

  const _PipelineArrow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.east, color: Colors.white70, size: 18.0),
        Text(
          label,
          style: const TextStyle(fontSize: 9.0, color: Colors.white70),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontSize: 10.0,
              color: color.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundTripCard extends StatelessWidget {
  final String title;
  final String valueText;
  final Uint8List bytes;
  final String decodedText;
  final Color accent;

  const _RoundTripCard({
    required this.title,
    required this.valueText,
    required this.bytes,
    required this.decodedText,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  valueText,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF424242),
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _StatChip(
                      label: 'bytes',
                      value: '${bytes.length}',
                      color: accent,
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                _HexPanel(bytes: bytes, showAscii: false),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'decoded',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Color(0xFF616161),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  decodedText,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF1B5E20),
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _JsonCard extends StatelessWidget {
  final String title;
  final String valueText;
  final String jsonText;
  final Uint8List bytes;
  final String decodedText;

  const _JsonCard({
    required this.title,
    required this.valueText,
    required this.jsonText,
    required this.bytes,
    required this.decodedText,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF00838F);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: accent.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              const SizedBox(width: 10.0),
              _StatChip(
                label: 'bytes',
                value: '${bytes.length}',
                color: accent,
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            'in:  $valueText',
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF424242),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'json: $jsonText',
              style: const TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Color(0xFF004D40),
              ),
            ),
          ),
          Text(
            'out: $decodedText',
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF1B5E20),
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeCompareRow extends StatelessWidget {
  final String label;
  final int jsonBytes;
  final int stdBytes;

  const _SizeCompareRow({
    required this.label,
    required this.jsonBytes,
    required this.stdBytes,
  });

  @override
  Widget build(BuildContext context) {
    final maxLen = jsonBytes > stdBytes ? jsonBytes : stdBytes;
    final jsonFrac = maxLen == 0 ? 0.0 : jsonBytes / maxLen;
    final stdFrac = maxLen == 0 ? 0.0 : stdBytes / maxLen;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          SizedBox(
            width: 110.0,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11.0,
                color: Color(0xFF004D40),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BarRow(
                  caption: 'std',
                  fraction: stdFrac,
                  bytes: stdBytes,
                  color: const Color(0xFF1976D2),
                ),
                const SizedBox(height: 2.0),
                _BarRow(
                  caption: 'json',
                  fraction: jsonFrac,
                  bytes: jsonBytes,
                  color: const Color(0xFF00838F),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  final String caption;
  final double fraction;
  final int bytes;
  final Color color;

  const _BarRow({
    required this.caption,
    required this.fraction,
    required this.bytes,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 32.0,
          child: Text(
            caption,
            style: TextStyle(fontSize: 10.0, color: color),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 10.0,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                child: Container(
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6.0),
        SizedBox(
          width: 38.0,
          child: Text(
            '${bytes}B',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 10.0,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}

class _Utf8Card extends StatelessWidget {
  final String sample;
  final Uint8List bytes;
  final String decodedText;

  const _Utf8Card({
    required this.sample,
    required this.bytes,
    required this.decodedText,
  });

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];
    var i = 0;
    while (i < bytes.length) {
      final b = bytes[i];
      final lead = _utf8RangeLabel(b);
      var width = 1;
      if (lead == '2-byte') {
        width = 2;
      } else if (lead == '3-byte') {
        width = 3;
      } else if (lead == '4-byte') {
        width = 4;
      }
      final end = (i + width <= bytes.length) ? i + width : bytes.length;
      final group = bytes.sublist(i, end);
      final color = _utf8RangeColor(lead);
      chips.add(_Utf8Chip(group: group, label: lead, color: color));
      i = end;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFF6A1B9A).withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '"$sample"',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              const SizedBox(width: 10.0),
              _StatChip(
                label: 'chars',
                value: '${sample.runes.length}',
                color: const Color(0xFF6A1B9A),
              ),
              const SizedBox(width: 4.0),
              _StatChip(
                label: 'bytes',
                value: '${bytes.length}',
                color: const Color(0xFF6A1B9A),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Wrap(spacing: 4.0, runSpacing: 4.0, children: chips),
          const SizedBox(height: 6.0),
          Text(
            'decoded: "$decodedText"',
            style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFF1B5E20),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _Utf8Chip extends StatelessWidget {
  final Uint8List group;
  final String label;
  final Color color;

  const _Utf8Chip({
    required this.group,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final hex = group.map(_hex2).join(' ');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hex,
            style: TextStyle(
              fontSize: 11.0,
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.0,
              color: color.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _EnvelopeRow extends StatelessWidget {
  final String label;
  final String subtitle;
  final Uint8List bytes;
  final Color accent;

  const _EnvelopeRow({
    required this.label,
    required this.subtitle,
    required this.bytes,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              const SizedBox(width: 8.0),
              _StatChip(
                label: 'bytes',
                value: '${bytes.length}',
                color: accent,
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFF424242),
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4.0),
          _HexPanel(bytes: bytes, showAscii: true),
        ],
      ),
    );
  }
}

class _MethodSidePanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final Uint8List bytes;
  final Color accent;
  final String extra;

  const _MethodSidePanel({
    required this.title,
    required this.subtitle,
    required this.bytes,
    required this.accent,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accent,
              fontSize: 13.0,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
          ),
          const SizedBox(height: 6.0),
          _StatChip(
            label: 'bytes',
            value: '${bytes.length}',
            color: accent,
          ),
          const SizedBox(height: 6.0),
          _HexPanel(bytes: bytes, showAscii: true),
          const SizedBox(height: 6.0),
          Text(
            extra,
            style: const TextStyle(
              fontSize: 10.0,
              color: Color(0xFF424242),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ExchangeBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accent;

  const _ExchangeBox({
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accent, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: accent),
          ),
          const SizedBox(height: 2.0),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10.0,
              color: Color(0xFF424242),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ExchangeArrow extends StatelessWidget {
  final String label;

  const _ExchangeArrow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.east, size: 18.0, color: Color(0xFF455A64)),
          Text(
            label,
            style: const TextStyle(fontSize: 9.0, color: Color(0xFF455A64)),
          ),
        ],
      ),
    );
  }
}

class _HexPanel extends StatelessWidget {
  final Uint8List bytes;
  final bool showAscii;

  const _HexPanel({required this.bytes, required this.showAscii});

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];
    final maxBytes = 48;
    final shown = bytes.length > maxBytes ? maxBytes : bytes.length;
    for (var i = 0; i < shown; i++) {
      final b = bytes[i];
      final isAscii = b >= 0x20 && b < 0x7f;
      final color = isAscii
          ? const Color(0xFF1565C0)
          : const Color(0xFF455A64);
      chips.add(
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 2.0,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            _hex2(b),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    if (bytes.length > maxBytes) {
      chips.add(
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 2.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF9E9E9E).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '+${bytes.length - maxBytes}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF616161),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 3.0, runSpacing: 3.0, children: chips),
        if (showAscii && bytes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFECEFF1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                _asciiPreview(bytes, limit: 64),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Color(0xFF37474F),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
