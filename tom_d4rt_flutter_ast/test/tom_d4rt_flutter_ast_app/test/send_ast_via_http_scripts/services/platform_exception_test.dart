// ignore_for_file: avoid_print
// D4rt test script: Tests PlatformException from package:flutter/services.dart
// Deep Demo: Visual demonstration of PlatformException - the channel-side
// platform error envelope surfaced to Dart code via MethodChannel.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('PlatformException Deep Demo executing');

  // ============================================================
  // Diagnostic Palette
  // ============================================================
  final Color paletteOrange = Colors.deepOrange.shade700;
  final Color paletteRed = Colors.red.shade700;
  final Color paletteAmber = Colors.amber.shade700;
  final Color paletteSlate = Colors.blueGrey.shade800;
  final Color paletteInk = Colors.grey.shade900;

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteOrange, paletteRed, Colors.red.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: paletteRed.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: paletteOrange.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
      border: Border.all(color: paletteAmber, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, size: 56.0, color: Colors.white),
            SizedBox(width: 12.0),
            Icon(Icons.cable_rounded, size: 56.0, color: Colors.white70),
            SizedBox(width: 12.0),
            Icon(Icons.bug_report_rounded, size: 56.0, color: Colors.white),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'PlatformException',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'package:flutter/services.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.amberAccent,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Channel-side platform errors surfaced as Dart exceptions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'implements Exception',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy Diagram - labelled fields
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteOrange, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: paletteOrange.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_rounded, color: paletteOrange, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Anatomy of PlatformException',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: paletteOrange,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: paletteInk,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'PlatformException(\n'
            '  required String code,\n'
            '  String? message,\n'
            '  dynamic details,\n'
            '  String? stacktrace,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.amberAccent,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _buildFieldRow(
          'code',
          'String (required)',
          'Machine-readable identifier (PERMISSION_DENIED, NETWORK)',
          Icons.qr_code_2_rounded,
          paletteRed,
        ),
        SizedBox(height: 8.0),
        _buildFieldRow(
          'message',
          'String?',
          'Human-readable description suitable for logs',
          Icons.message_rounded,
          paletteOrange,
        ),
        SizedBox(height: 8.0),
        _buildFieldRow(
          'details',
          'dynamic',
          'Standard-codec compatible payload (Map, List, num, String, bool)',
          Icons.inventory_2_rounded,
          paletteAmber,
        ),
        SizedBox(height: 8.0),
        _buildFieldRow(
          'stacktrace',
          'String?',
          'Native-side stack trace text (NOT a Dart StackTrace)',
          Icons.layers_rounded,
          paletteSlate,
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: Six PlatformException instance cards
  // ============================================================
  print('=== Section 3: Instance Cards ===');

  final ex1 = PlatformException(
    code: 'PERMISSION_DENIED',
    message: 'Camera permission required',
    details: null,
  );
  print('ex1.toString(): $ex1');

  final ex2 = PlatformException(
    code: 'NOT_AVAILABLE',
    message: 'Bluetooth disabled',
  );
  print('ex2.toString(): $ex2');

  final ex3 = PlatformException(
    code: 'INVALID_ARGUMENT',
    details: {'expected': 'int', 'got': 'String'},
  );
  print('ex3.toString(): $ex3');

  final ex4 = PlatformException(
    code: 'NETWORK',
    message: 'Timeout',
    details: {'durationMs': 5000},
  );
  print('ex4.toString(): $ex4');

  final ex5 = PlatformException(code: 'UNKNOWN');
  print('ex5.toString(): $ex5');

  final ex6 = PlatformException(
    code: 'OS_ERROR',
    message: 'errno=13',
    stacktrace: '#0 NativePlugin.cpp:147',
  );
  print('ex6.toString(): $ex6');

  final instanceCards = <Widget>[
    _buildExceptionCard(
      ex1,
      'Permission Denied',
      Icons.no_photography_rounded,
      paletteRed,
      'User refused camera permission at runtime',
    ),
    _buildExceptionCard(
      ex2,
      'Feature Unavailable',
      Icons.bluetooth_disabled_rounded,
      paletteOrange,
      'Hardware or capability not currently usable',
    ),
    _buildExceptionCard(
      ex3,
      'Invalid Argument',
      Icons.report_problem_rounded,
      paletteAmber,
      'Caller passed unsupported value into the channel',
    ),
    _buildExceptionCard(
      ex4,
      'Network Failure',
      Icons.cloud_off_rounded,
      Colors.deepOrange.shade400,
      'Channel call timed out — details carries the budget',
    ),
    _buildExceptionCard(
      ex5,
      'Unknown',
      Icons.help_outline_rounded,
      paletteSlate,
      'Only the required code; message/details/stacktrace are null',
    ),
    _buildExceptionCard(
      ex6,
      'OS Error',
      Icons.terminal_rounded,
      Colors.red.shade900,
      'Errno style failure with native stack pointer',
    ),
  ];
  print('Created ${instanceCards.length} instance cards');

  // ============================================================
  // SECTION 4: When-it-happens scenarios (4 cards)
  // ============================================================
  print('=== Section 4: When-it-happens Scenarios ===');

  final scenarioCards = <Widget>[
    _buildScenarioCard(
      'Camera Permission Denied',
      Icons.camera_alt_rounded,
      paletteRed,
      'channel.invokeMethod("openCamera")',
      'PERMISSION_DENIED',
      'User dismissed the OS prompt. The native plugin '
          'returns result.error("PERMISSION_DENIED", ..., null) which '
          'crosses the channel as a PlatformException.',
    ),
    _buildScenarioCard(
      'File IO Failure',
      Icons.folder_off_rounded,
      paletteOrange,
      'channel.invokeMethod("readFile", path)',
      'IO_ERROR',
      'The native side caught an OSError while reading. '
          'The errno is shipped through details and the C++ stack '
          'string lands in stacktrace.',
    ),
    _buildScenarioCard(
      'GPS Unavailable',
      Icons.gps_off_rounded,
      paletteAmber,
      'channel.invokeMethod("getLocation")',
      'NOT_AVAILABLE',
      'Location services are off or the device has no GPS '
          'fix. The native plugin reports the failure as a code with no '
          'native stack since this is expected.',
    ),
    _buildScenarioCard(
      'Bluetooth Off',
      Icons.bluetooth_disabled_rounded,
      paletteSlate,
      'channel.invokeMethod("scanDevices")',
      'BT_DISABLED',
      'The Bluetooth adapter is disabled. The plugin '
          'returns a structured error envelope with a hint to '
          'prompt the user to enable BT.',
    ),
  ];
  print('Created ${scenarioCards.length} scenario cards');

  // ============================================================
  // SECTION 5: Try/catch Pattern Code Block
  // ============================================================
  print('=== Section 5: Try/Catch Pattern ===');

  final tryCatchCode = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteInk, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteOrange, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code_rounded, color: paletteAmber, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Idiomatic try/catch around invokeMethod',
              style: TextStyle(
                color: paletteAmber,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildSourceLine('// 1. Define a typed channel.', Colors.greenAccent),
        _buildSourceLine(
          "const channel = MethodChannel('com.example/sensors');",
          Colors.cyanAccent,
        ),
        SizedBox(height: 8.0),
        _buildSourceLine(
          '// 2. Wrap every invocation in try/catch.',
          Colors.greenAccent,
        ),
        _buildSourceLine('try {', Colors.white),
        _buildSourceLine(
          "  final r = await channel.invokeMethod<double>('readTemp');",
          Colors.cyanAccent,
        ),
        _buildSourceLine('  return r ?? 0.0;', Colors.cyanAccent),
        _buildSourceLine(
          '} on PlatformException catch (e) {',
          Colors.orangeAccent,
        ),
        _buildSourceLine('  // 3. Branch on e.code.', Colors.greenAccent),
        _buildSourceLine('  if (e.code == "PERMISSION_DENIED") {', Colors.white),
        _buildSourceLine('    showPermissionBanner();', Colors.cyanAccent),
        _buildSourceLine('  } else if (e.code == "NOT_AVAILABLE") {', Colors.white),
        _buildSourceLine('    showSensorMissingDialog();', Colors.cyanAccent),
        _buildSourceLine('  } else {', Colors.white),
        _buildSourceLine(
          '    log("Channel error \${e.code}: \${e.message}");',
          Colors.cyanAccent,
        ),
        _buildSourceLine('  }', Colors.white),
        _buildSourceLine('  return null;', Colors.cyanAccent),
        _buildSourceLine(
          '} on MissingPluginException {',
          Colors.orangeAccent,
        ),
        _buildSourceLine(
          '  // 4. Plugin not registered on this platform.',
          Colors.greenAccent,
        ),
        _buildSourceLine('  return null;', Colors.cyanAccent),
        _buildSourceLine('}', Colors.white),
      ],
    ),
  );
  print('Created try/catch code block');

  // ============================================================
  // SECTION 6: Comparison vs sibling exception types
  // ============================================================
  print('=== Section 6: Comparison Table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteAmber, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: paletteAmber.withValues(alpha: 0.2),
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
            Icon(Icons.compare_arrows_rounded, color: paletteRed, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'PlatformException vs Friends',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: paletteRed,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: paletteOrange.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildHeader('Type', 140.0),
              _buildHeader('Source', 120.0),
              _buildHeader('Carries', 110.0),
              _buildHeader('Catch?', 90.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildCompareRow(
          'PlatformException',
          'channel error envelope',
          'code/message/details/stacktrace',
          'on PlatformException',
          paletteRed,
        ),
        _buildCompareRow(
          'MissingPluginException',
          'no platform handler',
          'message only',
          'on MissingPluginException',
          paletteOrange,
        ),
        _buildCompareRow(
          'FormatException',
          'parser/codec',
          'message + source + offset',
          'on FormatException',
          paletteAmber,
        ),
        _buildCompareRow(
          'Exception (generic)',
          'anything thrown',
          'just an object',
          'on Exception',
          paletteSlate,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: paletteInk,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Order matters: catch the most specific first.\n'
            'try { ... }\n'
            'on PlatformException catch (e) { /* channel */ }\n'
            'on MissingPluginException catch (e) { /* missing */ }\n'
            'on FormatException catch (e) { /* parse */ }\n'
            'on Exception catch (e) { /* other */ }',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amberAccent,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created comparison table');

  // ============================================================
  // SECTION 7: UI fallback mock - settings page with banner
  // ============================================================
  print('=== Section 7: UI Fallback Mock ===');

  final permissionEx = PlatformException(
    code: 'PERMISSION_DENIED',
    message: 'Camera access blocked by user',
    details: {'permission': 'camera', 'canRetry': true},
  );
  print('Settings page banner driven by: $permissionEx');

  final settingsMock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteSlate, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: paletteSlate.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mock app bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [paletteSlate, Colors.blueGrey.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22.0),
              SizedBox(width: 12.0),
              Text(
                'Camera Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        // Permission denied banner
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [paletteRed, paletteOrange],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border(
              bottom: BorderSide(color: paletteRed.withValues(alpha: 0.6)),
            ),
            boxShadow: [
              BoxShadow(
                color: paletteRed.withValues(alpha: 0.35),
                blurRadius: 8.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lock_rounded, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permission required',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      permissionEx.message ?? 'Permission missing',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'code: ${permissionEx.code}',
                        style: TextStyle(
                          color: Colors.amberAccent,
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'OPEN',
                  style: TextStyle(
                    color: paletteRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Settings rows
        _buildSettingsRow(
          Icons.photo_camera_rounded,
          'Camera access',
          'Blocked',
          paletteRed,
          true,
        ),
        _buildSettingsRow(
          Icons.mic_rounded,
          'Microphone access',
          'Allowed',
          Colors.green.shade700,
          false,
        ),
        _buildSettingsRow(
          Icons.location_on_rounded,
          'Location access',
          'Allowed',
          Colors.green.shade700,
          false,
        ),
        _buildSettingsRow(
          Icons.contacts_rounded,
          'Contacts access',
          'Ask each time',
          paletteAmber,
          false,
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          color: Colors.white,
          child: Text(
            'Banner state computed from PlatformException.code == '
            '"PERMISSION_DENIED". The button reroutes to system settings.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
  print('Created settings page mock');

  // ============================================================
  // SECTION 8: Error envelope encoding
  // ============================================================
  print('=== Section 8: Error Envelope Encoding ===');

  final envelopeSection = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteOrange, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: paletteOrange.withValues(alpha: 0.25),
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
            Icon(Icons.swap_horiz_rounded, color: paletteOrange, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Error Envelope Round-Trip',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: paletteOrange,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildPipelineStep(
          '1',
          'Native plugin reports failure',
          'result.error("NETWORK", "Timeout", {"durationMs": 5000})',
          Icons.phonelink_rounded,
          paletteRed,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          '2',
          'MethodCodec.encodeErrorEnvelope',
          'StandardMethodCodec writes [code, message, details, stacktrace] '
              'into a ByteData blob.',
          Icons.compress_rounded,
          paletteOrange,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          '3',
          'Bytes cross the platform channel',
          '~32 bytes of binary envelope shipped over the embedder bridge.',
          Icons.swap_calls_rounded,
          paletteAmber,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          '4',
          'MethodCodec.decodeEnvelope',
          'Dart side recognises an error envelope and reconstructs '
              'PlatformException(code: ..., message: ..., details: ...).',
          Icons.unarchive_rounded,
          Colors.deepOrange.shade400,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          '5',
          'invokeMethod future completes with error',
          'await throws PlatformException — caller catches via on '
              'PlatformException.',
          Icons.error_outline_rounded,
          paletteRed,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: paletteInk,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSourceLine(
                '// Manual encode/decode round trip for tests:',
                Colors.greenAccent,
              ),
              _buildSourceLine(
                "const codec = StandardMethodCodec();",
                Colors.cyanAccent,
              ),
              _buildSourceLine(
                "final ByteData blob = codec.encodeErrorEnvelope(",
                Colors.cyanAccent,
              ),
              _buildSourceLine(
                "  code: 'NETWORK',",
                Colors.orangeAccent,
              ),
              _buildSourceLine(
                "  message: 'Timeout',",
                Colors.orangeAccent,
              ),
              _buildSourceLine(
                "  details: {'durationMs': 5000},",
                Colors.orangeAccent,
              ),
              _buildSourceLine(');', Colors.cyanAccent),
              _buildSourceLine(
                '// Decoding throws PlatformException:',
                Colors.greenAccent,
              ),
              _buildSourceLine(
                'try { codec.decodeEnvelope(blob); }',
                Colors.cyanAccent,
              ),
              _buildSourceLine(
                'on PlatformException catch (e) { print(e); }',
                Colors.cyanAccent,
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created envelope encoding section');

  // ============================================================
  // SECTION 9: Footgun Cards (5 entries)
  // ============================================================
  print('=== Section 9: Footgun Cards ===');

  final footguns = <Widget>[
    _buildFootgun(
      'Always provide code',
      'code is required and machine-readable. Don\'t leave it as '
          '"ERROR" or duplicate the message — branches read it.',
      Icons.qr_code_2_rounded,
      paletteRed,
    ),
    _buildFootgun(
      'details must be Standard-codec compatible',
      'Maps, Lists, num, bool, String, Uint8List etc. Custom Dart '
          'classes will not survive the binary envelope.',
      Icons.inventory_2_rounded,
      paletteOrange,
    ),
    _buildFootgun(
      'stacktrace is a String, not a Dart StackTrace',
      'It comes from the platform side as plain text. You cannot '
          'pass it to Error.throwWithStackTrace as-is.',
      Icons.layers_rounded,
      paletteAmber,
    ),
    _buildFootgun(
      'Equality is reference-based',
      'Two PlatformException instances with identical fields '
          'compare unequal. Compare by code (and message) explicitly.',
      Icons.compare_arrows_rounded,
      Colors.deepOrange.shade400,
    ),
    _buildFootgun(
      'Don\'t localise message at the source',
      'message is for developers and logs. Localise UI strings '
          'from code in the Dart layer — never bake locale into the '
          'native plugin.',
      Icons.translate_rounded,
      paletteSlate,
    ),
  ];
  print('Created ${footguns.length} footgun cards');

  // ============================================================
  // SECTION 10: Recap Card
  // ============================================================
  print('=== Section 10: Recap ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteRed, paletteOrange, Colors.amber.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: paletteRed.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: paletteOrange.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
      border: Border.all(color: Colors.white, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 28.0,
            ),
            SizedBox(width: 12.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecapPoint(
          'PlatformException is the Dart-side representation of a '
              'platform channel error envelope.',
        ),
        _buildRecapPoint(
          'It implements Exception and is thrown from invokeMethod when '
              'the native plugin returns an error.',
        ),
        _buildRecapPoint(
          'Four fields: code (required), message, details (Standard-codec), '
              'stacktrace (platform text).',
        ),
        _buildRecapPoint(
          'toString format is "PlatformException(code, message, details, '
              'stacktrace)".',
        ),
        _buildRecapPoint(
          'Always catch with "on PlatformException" before more generic '
              'handlers and branch on e.code.',
        ),
        _buildRecapPoint(
          'Pair with MissingPluginException, FormatException, and a '
              'generic Exception fallback for full coverage.',
        ),
      ],
    ),
  );
  print('Created recap card');

  print('PlatformException Deep Demo completed successfully');

  // ============================================================
  // Final Layout: Scaffold -> SingleChildScrollView -> Column
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          _sectionHeader('1. Anatomy', Icons.account_tree_rounded, paletteOrange),
          anatomyDiagram,
          SizedBox(height: 28.0),
          _sectionHeader(
            '2. Six Real Instances',
            Icons.list_alt_rounded,
            paletteRed,
          ),
          ...instanceCards,
          SizedBox(height: 28.0),
          _sectionHeader(
            '3. When It Happens',
            Icons.event_available_rounded,
            paletteAmber,
          ),
          ...scenarioCards,
          SizedBox(height: 28.0),
          _sectionHeader(
            '4. Try / Catch Pattern',
            Icons.code_rounded,
            paletteSlate,
          ),
          tryCatchCode,
          SizedBox(height: 28.0),
          _sectionHeader(
            '5. Comparison vs Friends',
            Icons.compare_arrows_rounded,
            paletteRed,
          ),
          comparisonTable,
          SizedBox(height: 28.0),
          _sectionHeader(
            '6. UI Fallback Mock',
            Icons.dvr_rounded,
            paletteOrange,
          ),
          settingsMock,
          SizedBox(height: 28.0),
          _sectionHeader(
            '7. Envelope Encoding',
            Icons.swap_horiz_rounded,
            Colors.deepOrange.shade400,
          ),
          envelopeSection,
          SizedBox(height: 28.0),
          _sectionHeader(
            '8. Footguns',
            Icons.warning_amber_rounded,
            paletteRed,
          ),
          ...footguns,
          SizedBox(height: 28.0),
          _sectionHeader(
            '9. Recap',
            Icons.menu_book_rounded,
            paletteAmber,
          ),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helper: Section header
// ============================================================
Widget _sectionHeader(String label, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #92, P5(a)):
      // Drop borderRadius — non-uniform Border (only `left` side coloured,
      // other sides BorderSide.none) cannot coexist with borderRadius.
      // Flutter asserts "A borderRadius can only be given on borders with
      // uniform colors." The heavy left accent bar carries the visual
      // identity of the section header; a square corner is acceptable.
      color: color.withValues(alpha: 0.1),
      border: Border(
        left: BorderSide(color: color, width: 5.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Anatomy field row
// ============================================================
Widget _buildFieldRow(
  String name,
  String type,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    type,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: color,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: PlatformException instance card
// ============================================================
Widget _buildExceptionCard(
  PlatformException e,
  String label,
  IconData icon,
  Color color,
  String narrative,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'code: ${e.code}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildKeyValue('code', e.code, color),
              _buildKeyValue('message', '${e.message}', color),
              _buildKeyValue('details', '${e.details}', color),
              _buildKeyValue('stacktrace', '${e.stacktrace}', color),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.terminal_rounded, color: Colors.amberAccent, size: 16.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  e.toString(),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.amberAccent,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          narrative,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: key/value line for an exception card
// ============================================================
Widget _buildKeyValue(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            '$key:',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Scenario card (when-it-happens)
// ============================================================
Widget _buildScenarioCard(
  String title,
  IconData icon,
  Color color,
  String invocation,
  String code,
  String narrative,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
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
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: Colors.white, size: 24.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                code,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            invocation,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          narrative,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: code source line
// ============================================================
Widget _buildSourceLine(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.45,
      ),
    ),
  );
}

// ============================================================
// Helper: Comparison table header
// ============================================================
Widget _buildHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.deepOrange.shade900,
      ),
    ),
  );
}

// ============================================================
// Helper: Comparison table data row
// ============================================================
Widget _buildCompareRow(
  String type,
  String source,
  String carries,
  String catchClause,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: color.withValues(alpha: 0.3), width: 1.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 120.0,
          child: Text(
            source,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            carries,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Text(
            catchClause,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Settings row in the UI mock
// ============================================================
Widget _buildSettingsRow(
  IconData icon,
  String label,
  String status,
  Color statusColor,
  bool highlight,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: highlight ? statusColor.withValues(alpha: 0.08) : Colors.white,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: statusColor, size: 22.0),
        SizedBox(width: 14.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey.shade900,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: statusColor.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Pipeline step
// ============================================================
Widget _buildPipelineStep(
  String number,
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    margin: EdgeInsets.symmetric(vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
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

// ============================================================
// Helper: Pipeline arrow between steps
// ============================================================
Widget _buildPipelineArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Center(
      child: Icon(
        Icons.arrow_downward_rounded,
        color: Colors.deepOrange.shade400,
        size: 22.0,
      ),
    ),
  );
}

// ============================================================
// Helper: Footgun card
// ============================================================
Widget _buildFootgun(
  String title,
  String body,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.05),
          color.withValues(alpha: 0.15),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #92, P5(a)):
      // Drop borderRadius — `left` BorderSide differs from the other three
      // sides (full-strength `color` vs `color@0.3`), making the Border
      // non-uniform. Flutter asserts "A borderRadius can only be given on
      // borders with uniform colors." The heavy left accent identifies the
      // footgun card; the diagonal gradient and shadow remain, so a square
      // corner is acceptable.
      border: Border(
        left: BorderSide(color: color, width: 5.0),
        top: BorderSide(color: color.withValues(alpha: 0.3), width: 1.0),
        right: BorderSide(color: color.withValues(alpha: 0.3), width: 1.0),
        bottom: BorderSide(color: color.withValues(alpha: 0.3), width: 1.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 26.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: color,
                    size: 16.0,
                  ),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Recap bullet point
// ============================================================
Widget _buildRecapPoint(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 18.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
