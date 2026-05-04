// ignore_for_file: avoid_print
// D4rt test script: Tests MethodCodec from services
// Deep Demo: Visual demonstration of MethodCodec — the abstract codec used by
// MethodChannel to serialise method-call envelopes, success envelopes, and
// error envelopes for platform-channel communication.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('MethodCodec Deep Demo executing');

  // Palette: slate / amber / teal
  const slate = Color(0xFF334155);
  const slateDark = Color(0xFF1E293B);
  const slateLight = Color(0xFF64748B);
  const amber = Color(0xFFF59E0B);
  const amberLight = Color(0xFFFCD34D);
  const amberDeep = Color(0xFFB45309);
  const teal = Color(0xFF0D9488);
  const tealLight = Color(0xFF5EEAD4);
  const tealDeep = Color(0xFF134E4A);

  final std = StandardMethodCodec();
  final json = JSONMethodCodec();
  print('StandardMethodCodec: ${std.runtimeType}');
  print('JSONMethodCodec: ${json.runtimeType}');

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDark, slate, teal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: slateDark.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz, size: 48.0, color: amberLight),
            SizedBox(width: 12.0),
            Icon(Icons.code, size: 56.0, color: Colors.white),
            SizedBox(width: 12.0),
            Icon(Icons.cable, size: 48.0, color: tealLight),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'MethodCodec',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Abstract envelope codec for MethodChannel',
          style: TextStyle(fontSize: 15.0, color: amberLight),
        ),
        SizedBox(height: 4.0),
        Text(
          'package:flutter/services.dart',
          style: TextStyle(
            fontSize: 12.0,
            color: tealLight,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'StandardMethodCodec  |  JSONMethodCodec',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy Diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate.withValues(alpha: 0.08), teal.withValues(alpha: 0.10)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slateLight.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slate.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Envelope Anatomy',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: slateDark,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnatomyNode(
              'MethodCall',
              'method: String\nargs: dynamic',
              Icons.call,
              amber,
              amberDeep,
            ),
            _buildArrowLabel('encodeMethodCall', amber),
            _buildAnatomyNode(
              'ByteData',
              'binary buffer\nlengthInBytes',
              Icons.memory,
              teal,
              tealDeep,
            ),
            _buildArrowLabel('platform', teal),
            _buildAnatomyNode(
              'Wire',
              'engine ▶ host\n(channel)',
              Icons.cable,
              slate,
              slateDark,
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: slateDark,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Three envelope kinds:\n'
            '//   1. method-call        — encodeMethodCall(MethodCall)\n'
            '//   2. success-envelope   — encodeSuccessEnvelope(result)\n'
            '//   3. error-envelope     — encodeErrorEnvelope(code, msg, det)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: amberLight,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: StandardMethodCodec vs JSONMethodCodec table
  // ============================================================
  print('=== Section 3: Codec Comparison Table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slateLight.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slate.withValues(alpha: 0.10),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Codec Comparison',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: slateDark,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [slateDark, slate],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Aspect', 110.0),
              _buildHeaderCell('Standard', 110.0),
              _buildHeaderCell('JSON', 110.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildCompareRow(
          'Default',
          'yes (default)',
          'opt-in',
          amber,
          slateLight,
        ),
        _buildCompareRow(
          'Encoding',
          'binary tagged',
          'utf-8 text',
          teal,
          slateLight,
        ),
        _buildCompareRow(
          'Byte size',
          'compact',
          'larger (text)',
          teal,
          amber,
        ),
        _buildCompareRow(
          'Performance',
          'fast',
          'slower',
          teal,
          amber,
        ),
        _buildCompareRow(
          'Numbers',
          'int / double',
          'num (double)',
          teal,
          slateLight,
        ),
        _buildCompareRow(
          'Lists / Maps',
          'any keys',
          'string keys',
          teal,
          amber,
        ),
        _buildCompareRow(
          'Uint8List',
          'native',
          'as List<int>',
          teal,
          amber,
        ),
        _buildCompareRow(
          'Readability',
          'opaque',
          'human-readable',
          slateLight,
          teal,
        ),
        _buildCompareRow(
          'Use case',
          'platform IO',
          'web / debug',
          slateLight,
          slateLight,
        ),
      ],
    ),
  );
  print('Created comparison table');

  // ============================================================
  // SECTION 4: Five envelope encode/decode cards
  // ============================================================
  print('=== Section 4: Method-Call Envelope Cards ===');

  final callExamples = <Map<String, dynamic>>[
    {
      'label': "MethodCall('greet', 'Hello')",
      'method': 'greet',
      'args': 'Hello',
      'icon': Icons.waving_hand,
    },
    {
      'label': "MethodCall('add', [1, 2])",
      'method': 'add',
      'args': [1, 2],
      'icon': Icons.add,
    },
    {
      'label': "MethodCall('config', {'key': 'value'})",
      'method': 'config',
      'args': {'key': 'value'},
      'icon': Icons.settings,
    },
    {
      'label': "MethodCall('noArgs', null)",
      'method': 'noArgs',
      'args': null,
      'icon': Icons.do_not_disturb,
    },
    {
      'label': "MethodCall('list', [1, 'a', true, null])",
      'method': 'list',
      'args': [1, 'a', true, null],
      'icon': Icons.list_alt,
    },
  ];

  final envelopeCards = <Widget>[];
  for (final ex in callExamples) {
    final method = ex['method'] as String;
    final args = ex['args'];
    final call = MethodCall(method, args);

    final stdEncoded = std.encodeMethodCall(call);
    final stdLen = stdEncoded.lengthInBytes;
    final stdDecoded = std.decodeMethodCall(stdEncoded);

    final jsonEncoded = json.encodeMethodCall(call);
    final jsonLen = jsonEncoded.lengthInBytes;
    final jsonDecoded = json.decodeMethodCall(jsonEncoded);

    print(
      'Encoded ${ex['label']}: std=${stdLen}B json=${jsonLen}B '
      'roundtrip-method=${stdDecoded.method}',
    );

    envelopeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, slate.withValues(alpha: 0.04)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: amber.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: amber.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    ex['icon'] as IconData,
                    color: amberDeep,
                    size: 22.0,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    ex['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: slateDark,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildByteBox(
                    'Standard',
                    stdLen,
                    teal,
                    tealDeep,
                    stdDecoded.method,
                    '${stdDecoded.arguments}',
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _buildByteBox(
                    'JSON',
                    jsonLen,
                    amber,
                    amberDeep,
                    jsonDecoded.method,
                    '${jsonDecoded.arguments}',
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            _buildBytesBar(stdLen, jsonLen, teal, amber),
          ],
        ),
      ),
    );
  }
  print('Created ${envelopeCards.length} envelope cards');

  // ============================================================
  // SECTION 5: Success Envelope Showcase
  // ============================================================
  print('=== Section 5: Success Envelope Showcase ===');

  final successResults = <Map<String, dynamic>>[
    {'label': '42', 'value': 42, 'icon': Icons.numbers},
    {'label': "'OK'", 'value': 'OK', 'icon': Icons.check_circle},
    {'label': '[1, 2, 3]', 'value': [1, 2, 3], 'icon': Icons.list},
    {
      'label': "{'ok': true}",
      'value': {'ok': true},
      'icon': Icons.thumb_up,
    },
  ];

  final successCards = <Widget>[];
  for (final s in successResults) {
    final v = s['value'];
    final stdBytes = std.encodeSuccessEnvelope(v);
    final jsonBytes = json.encodeSuccessEnvelope(v);
    final stdRound = std.decodeEnvelope(stdBytes);
    final jsonRound = json.decodeEnvelope(jsonBytes);
    print(
      'success ${s['label']}: std=${stdBytes.lengthInBytes}B '
      'json=${jsonBytes.lengthInBytes}B round=$stdRound',
    );

    successCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              teal.withValues(alpha: 0.12),
              teal.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: teal.withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: teal.withValues(alpha: 0.20),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(s['icon'] as IconData, size: 22.0, color: tealDeep),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    s['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: tealDeep,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildKeyValue('std bytes', '${stdBytes.lengthInBytes} B', teal),
            _buildKeyValue('json bytes', '${jsonBytes.lengthInBytes} B', amber),
            _buildKeyValue('std round', '$stdRound', slate),
            _buildKeyValue('json round', '$jsonRound', slate),
          ],
        ),
      ),
    );
  }
  print('Created ${successCards.length} success-envelope cards');

  // ============================================================
  // SECTION 6: Error Envelope Showcase
  // ============================================================
  print('=== Section 6: Error Envelope Showcase ===');

  final errorTriples = <Map<String, dynamic>>[
    {
      'code': 'ERR_NOT_FOUND',
      'message': 'Resource missing',
      'details': 'path=/foo',
    },
    {
      'code': 'ERR_AUTH',
      'message': 'Token expired',
      'details': null,
    },
    {
      'code': 'ERR_NETWORK',
      'message': null,
      'details': {'retry': 3},
    },
    {
      'code': 'ERR_INTERNAL',
      'message': 'Boom',
      'details': [1, 2, 3],
    },
  ];

  final errorCards = <Widget>[];
  for (final e in errorTriples) {
    final code = e['code'] as String;
    final message = e['message'] as String?;
    final details = e['details'];

    final stdEnv = std.encodeErrorEnvelope(
      code: code,
      message: message,
      details: details,
    );
    final jsonEnv = json.encodeErrorEnvelope(
      code: code,
      message: message,
      details: details,
    );

    String thrownTypeStd = 'PlatformException';
    String thrownCodeStd = code;
    try {
      std.decodeEnvelope(stdEnv);
      thrownTypeStd = 'NONE';
    } on PlatformException catch (pe) {
      thrownCodeStd = pe.code;
      thrownTypeStd = 'PlatformException';
    }
    String thrownTypeJson = 'PlatformException';
    String thrownCodeJson = code;
    try {
      json.decodeEnvelope(jsonEnv);
      thrownTypeJson = 'NONE';
    } on PlatformException catch (pe) {
      thrownCodeJson = pe.code;
      thrownTypeJson = 'PlatformException';
    }

    print(
      'error $code: std=${stdEnv.lengthInBytes}B json=${jsonEnv.lengthInBytes}B '
      'threw=$thrownTypeStd/$thrownTypeJson',
    );

    errorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFEE2E2).withValues(alpha: 0.6),
              amber.withValues(alpha: 0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Color(0xFFB91C1C).withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFB91C1C).withValues(alpha: 0.15),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Color(0xFFB91C1C),
                  size: 22.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Color(0xFFB91C1C),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            _buildKeyValue('message', message ?? '<null>', slate),
            _buildKeyValue('details', '$details', slate),
            SizedBox(height: 6.0),
            Row(
              children: [
                Expanded(
                  child: _buildByteBox(
                    'Standard',
                    stdEnv.lengthInBytes,
                    teal,
                    tealDeep,
                    'throws',
                    '$thrownTypeStd($thrownCodeStd)',
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _buildByteBox(
                    'JSON',
                    jsonEnv.lengthInBytes,
                    amber,
                    amberDeep,
                    'throws',
                    '$thrownTypeJson($thrownCodeJson)',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${errorCards.length} error-envelope cards');

  // ============================================================
  // SECTION 7: MethodChannel Integration Code Block
  // ============================================================
  print('=== Section 7: MethodChannel Integration ===');

  final integrationBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDark, Color(0xFF0F172A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: slateDark.withValues(alpha: 0.40),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: tealLight, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'MethodChannel.invokeMethod (uses MethodCodec)',
              style: TextStyle(
                color: tealLight,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          "// 1. App calls invokeMethod\n"
          "const channel = MethodChannel('battery', StandardMethodCodec());\n"
          "final level = await channel.invokeMethod<int>('getBatteryLevel');\n",
          tealLight,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          "// 2. Internally, MethodChannel does:\n"
          "final ByteData encoded = codec.encodeMethodCall(\n"
          "  MethodCall('getBatteryLevel', null),\n"
          ");\n"
          "final ByteData? reply = await binaryMessenger.send(name, encoded);\n"
          "if (reply == null) throw MissingPluginException();\n"
          "return codec.decodeEnvelope(reply); // throws PlatformException",
          amberLight,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          "// 3. Replacing the codec:\n"
          "const channel = MethodChannel('debug', JSONMethodCodec());",
          Colors.white,
        ),
      ],
    ),
  );
  print('Created MethodChannel integration block');

  // ============================================================
  // SECTION 8: BinaryMessenger Boundary Diagram
  // ============================================================
  print('=== Section 8: BinaryMessenger Boundary ===');

  final boundaryDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [teal.withValues(alpha: 0.08), amber.withValues(alpha: 0.10)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealDeep.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: teal.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'BinaryMessenger Boundary',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: slateDark,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBoundaryColumn(
              'Dart side',
              [
                'invokeMethod(name, args)',
                'codec.encodeMethodCall',
                'binaryMessenger.send',
              ],
              Icons.flutter_dash,
              teal,
              tealDeep,
            ),
            Column(
              children: [
                Icon(Icons.arrow_forward, color: amber, size: 28.0),
                SizedBox(height: 18.0),
                Icon(Icons.arrow_back, color: tealDeep, size: 28.0),
              ],
            ),
            _buildBoundaryColumn(
              'Engine',
              [
                'platform channel',
                '(opaque ByteData)',
                'routes by name',
              ],
              Icons.memory,
              slate,
              slateDark,
            ),
            Column(
              children: [
                Icon(Icons.arrow_forward, color: amber, size: 28.0),
                SizedBox(height: 18.0),
                Icon(Icons.arrow_back, color: tealDeep, size: 28.0),
              ],
            ),
            _buildBoundaryColumn(
              'Platform',
              [
                'host handler',
                'codec.decodeMethodCall',
                'codec.encodeSuccessEnvelope',
              ],
              Icons.phone_iphone,
              amber,
              amberDeep,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: slateDark,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Both sides must agree on the codec.\n'
            '// The MethodCodec is the contract — the wire only carries ByteData.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: amberLight,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created boundary diagram');

  // ============================================================
  // SECTION 9: Custom-codec Sketch
  // ============================================================
  print('=== Section 9: Custom Codec Sketch ===');

  final customCodecSketch = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDark, Color(0xFF020617)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.build_circle, color: amberLight, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Custom MethodCodec skeleton (sketch only)',
              style: TextStyle(
                color: amberLight,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          'class CompactMethodCodec implements MethodCodec {\n'
          '  const CompactMethodCodec();\n'
          '\n'
          '  @override\n'
          '  ByteData encodeMethodCall(MethodCall call) {\n'
          '    // 1. write method name as utf-8\n'
          '    // 2. write tagged argument(s)\n'
          '    // 3. return ByteData view of buffer\n'
          '    throw UnimplementedError();\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  MethodCall decodeMethodCall(ByteData? bytes) {\n'
          '    // parse name + args back into MethodCall\n'
          '    throw UnimplementedError();\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  ByteData encodeSuccessEnvelope(dynamic result) =>\n'
          '      throw UnimplementedError();\n'
          '\n'
          '  @override\n'
          '  ByteData encodeErrorEnvelope({\n'
          '    required String code,\n'
          '    String? message,\n'
          '    dynamic details,\n'
          '  }) => throw UnimplementedError();\n'
          '\n'
          '  @override\n'
          '  dynamic decodeEnvelope(ByteData envelope) {\n'
          '    // distinguish success vs error frame, then\n'
          '    //   throw PlatformException(code:..., message:..., details:...)\n'
          '    throw UnimplementedError();\n'
          '  }\n'
          '}',
          Color(0xFFE2E8F0),
        ),
      ],
    ),
  );
  print('Created custom codec sketch');

  // ============================================================
  // SECTION 10: Footgun Cards
  // ============================================================
  print('=== Section 10: Footgun Cards ===');

  final footguns = <Map<String, String>>[
    {
      'title': 'Standard ≠ any Dart object',
      'body':
          'StandardMethodCodec only encodes a curated type list: null, bool, '
              'int, double, String, Uint8List, Int32List, Int64List, '
              'Float32List, Float64List, List, Map. Custom classes throw.',
    },
    {
      'title': 'JSON: null vs missing',
      'body':
          'JSON cannot distinguish a key whose value is null from a missing '
              'key after round-trip. Use StandardMethodCodec when the '
              'distinction matters.',
    },
    {
      'title': 'JSON requires String keys',
      'body':
          'Nested Map<dynamic,dynamic> with non-String keys is a runtime '
              'error in JSONMethodCodec. StandardMethodCodec accepts any '
              'allowed key type.',
    },
    {
      'title': 'PlatformException details type-erased',
      'body':
          'PlatformException.details is typed dynamic. After codec '
              'round-trip, custom payloads come back as Map/List/primitives — '
              'not your original Dart class.',
    },
    {
      'title': 'ByteData length ≠ wire size',
      'body':
          'ByteData.lengthInBytes is the buffer size on the Dart heap. '
              'Engine framing, channel overhead and platform encoding can '
              'change the on-wire byte count.',
    },
  ];

  final footgunCards = <Widget>[];
  for (var i = 0; i < footguns.length; i++) {
    final f = footguns[i];
    footgunCards.add(_buildFootgunCard(i + 1, f['title']!, f['body']!));
  }
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap Card
  // ============================================================
  print('=== Section 11: Recap Card ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, teal, amberDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: amberLight, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecapBullet(
          'MethodCodec',
          'abstract — three envelope kinds: method-call, '
              'success, error.',
        ),
        _buildRecapBullet(
          'StandardMethodCodec()',
          'binary, compact, default for MethodChannel.',
        ),
        _buildRecapBullet(
          'JSONMethodCodec()',
          'utf-8 JSON, human-readable, debug-friendly.',
        ),
        _buildRecapBullet(
          'decodeEnvelope',
          'throws PlatformException on error frames.',
        ),
        _buildRecapBullet(
          'BinaryMessenger',
          'transport — codec is the contract, ByteData is the wire.',
        ),
      ],
    ),
  );
  print('Created recap card');

  print('MethodCodec Deep Demo completed successfully');

  // ============================================================
  // Compose final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF1F5F9),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          _buildSectionHeader('1. Title Banner', Icons.title, slateDark),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: slateLight.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: Text(
              'MethodCodec is the abstract base for serialising '
              'MethodChannel envelopes. Two concrete codecs ship with '
              'Flutter: StandardMethodCodec (binary, default) and '
              'JSONMethodCodec (text). Both expose a `const` constructor.',
              style: TextStyle(fontSize: 13.0, color: slate, height: 1.4),
            ),
          ),
          SizedBox(height: 28.0),
          _buildSectionHeader('2. Anatomy', Icons.account_tree, slateDark),
          anatomyDiagram,
          SizedBox(height: 28.0),
          _buildSectionHeader(
            '3. Standard vs JSON Codec',
            Icons.compare_arrows,
            slateDark,
          ),
          comparisonTable,
          SizedBox(height: 28.0),
          _buildSectionHeader(
            '4. Method-Call Envelopes',
            Icons.outgoing_mail,
            slateDark,
          ),
          ...envelopeCards,
          SizedBox(height: 28.0),
          _buildSectionHeader(
            '5. Success Envelopes',
            Icons.check_circle,
            slateDark,
          ),
          Wrap(alignment: WrapAlignment.center, children: successCards),
          SizedBox(height: 28.0),
          _buildSectionHeader('6. Error Envelopes', Icons.warning, slateDark),
          ...errorCards,
          SizedBox(height: 28.0),
          _buildSectionHeader(
            '7. MethodChannel Integration',
            Icons.integration_instructions,
            slateDark,
          ),
          integrationBlock,
          SizedBox(height: 28.0),
          _buildSectionHeader(
            '8. BinaryMessenger Boundary',
            Icons.compare,
            slateDark,
          ),
          boundaryDiagram,
          SizedBox(height: 28.0),
          _buildSectionHeader(
            '9. Custom Codec Sketch',
            Icons.build,
            slateDark,
          ),
          customCodecSketch,
          SizedBox(height: 28.0),
          _buildSectionHeader('10. Footguns', Icons.dangerous, slateDark),
          ...footgunCards,
          SizedBox(height: 28.0),
          _buildSectionHeader('11. Recap', Icons.bookmark, slateDark),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// =====================================================================
// Top-level helpers
// =====================================================================

Widget _buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 4.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomyNode(
  String title,
  String body,
  IconData icon,
  Color color,
  Color deep,
) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: deep, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: deep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: deep,
          ),
        ),
      ],
    ),
  );
}

Widget _buildArrowLabel(String label, Color color) {
  return Column(
    children: [
      Icon(Icons.arrow_forward, color: color, size: 22.0),
      SizedBox(height: 2.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 8.0,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildCompareRow(
  String label,
  String stdVal,
  String jsonVal,
  Color stdColor,
  Color jsonColor,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            stdVal,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: stdColor,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            jsonVal,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: jsonColor,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildByteBox(
  String label,
  int bytes,
  Color color,
  Color deep,
  String roundLabel,
  String roundValue,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              '$bytes B',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: deep,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          '$roundLabel: $roundValue',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: deep,
          ),
        ),
      ],
    ),
  );
}

Widget _buildBytesBar(int stdLen, int jsonLen, Color stdColor, Color jsonColor) {
  final maxLen = stdLen > jsonLen ? stdLen : jsonLen;
  final stdRatio = maxLen == 0 ? 0.0 : stdLen / maxLen;
  final jsonRatio = maxLen == 0 ? 0.0 : jsonLen / maxLen;
  return Column(
    children: [
      Row(
        children: [
          SizedBox(
            width: 60.0,
            child: Text(
              'std',
              style: TextStyle(
                fontSize: 10.0,
                color: stdColor,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 10.0,
              decoration: BoxDecoration(
                color: Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: stdRatio,
                child: Container(
                  decoration: BoxDecoration(
                    color: stdColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 4.0),
      Row(
        children: [
          SizedBox(
            width: 60.0,
            child: Text(
              'json',
              style: TextStyle(
                fontSize: 10.0,
                color: jsonColor,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 10.0,
              decoration: BoxDecoration(
                color: Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: jsonRatio,
                child: Container(
                  decoration: BoxDecoration(
                    color: jsonColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildKeyValue(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBoundaryColumn(
  String title,
  List<String> bullets,
  IconData icon,
  Color color,
  Color deep,
) {
  return Container(
    width: 120.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: deep, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: deep,
          ),
        ),
        SizedBox(height: 8.0),
        for (final b in bullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              '· $b',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.0,
                fontFamily: 'monospace',
                color: deep,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Color(0xFF334155),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildFootgunCard(int index, String title, String body) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFFBEB),
          Color(0xFFFEF3C7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFB45309), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB45309).withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: Color(0xFFB45309),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$index',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF78350F),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF78350F),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecapBullet(String head, String tail) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: Color(0xFFFCD34D), size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 13.0, color: Colors.white),
              children: [
                TextSpan(
                  text: '$head — ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                TextSpan(text: tail),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
