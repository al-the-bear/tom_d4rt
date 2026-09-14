// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of MissingPluginException from
// package:flutter/services.dart. Constructs several instances and presents
// them as data; never invokes platform channels at runtime.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('MissingPluginException Deep Demo executing');

  // ============================================================
  // Construct exception instances (data only, no channel calls)
  // ============================================================
  final ex1 = MissingPluginException(
    'No implementation found for method vibrate on channel flutter.haptic',
  );
  final ex2 = MissingPluginException(
    'No implementation found for method getBatteryLevel on channel battery_plus',
  );
  final ex3 = MissingPluginException(
    'No implementation found for method launchUrl on channel url_launcher',
  );
  final ex4 = MissingPluginException(
    'No implementation found for method scan on channel mobile_scanner',
  );
  final ex5 = MissingPluginException('Channel unregistered for foo_channel');
  final ex6 = MissingPluginException();

  print('ex1.message = ${ex1.message}');
  print('ex2.message = ${ex2.message}');
  print('ex3.message = ${ex3.message}');
  print('ex4.message = ${ex4.message}');
  print('ex5.message = ${ex5.message}');
  print('ex6.message = ${ex6.message}');
  print('ex1.toString = ${ex1.toString()}');
  print('ex6.toString = ${ex6.toString()}');

  final allExamples = <Map<String, dynamic>>[
    {
      'instance': ex1,
      'label': 'Haptic feedback',
      'icon': Icons.vibration,
      'tone': Colors.deepOrange,
    },
    {
      'instance': ex2,
      'label': 'Battery level',
      'icon': Icons.battery_alert,
      'tone': Colors.orange,
    },
    {
      'instance': ex3,
      'label': 'URL launcher',
      'icon': Icons.link_off,
      'tone': Colors.red,
    },
    {
      'instance': ex4,
      'label': 'Mobile scanner',
      'icon': Icons.qr_code_scanner,
      'tone': Colors.deepOrange,
    },
    {
      'instance': ex5,
      'label': 'Custom channel',
      'icon': Icons.cable,
      'tone': Colors.amber,
    },
    {
      'instance': ex6,
      'label': 'No message variant',
      'icon': Icons.help_outline,
      'tone': Colors.brown,
    },
  ];

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');
  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepOrange.shade700,
          Colors.red.shade800,
          Colors.orange.shade900,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.30),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 2.0,
            ),
          ),
          child: Icon(
            Icons.extension_off,
            size: 56.0,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MissingPluginException',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'package:flutter/services.dart',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'monospace',
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'Thrown when no platform handler is registered',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.amber.shade100,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy box (single field + toString sample)
  // ============================================================
  print('=== Section 2: Anatomy ===');
  final anatomyBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.red.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.18),
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
            Icon(Icons.bug_report, color: Colors.deepOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of the exception',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildField('message', 'String?', 'The diagnostic text (nullable)'),
        SizedBox(height: 8.0),
        _buildField(
          'MissingPluginException([String? message])',
          'constructor',
          'Single positional optional argument',
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// toString output',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                ex1.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.orange.shade300,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                ex6.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.amber.shade200,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: 6 instances rendered as cards with toString output
  // ============================================================
  print('=== Section 3: Six instances ===');
  final instanceCards = <Widget>[];
  for (var i = 0; i < allExamples.length; i = i + 1) {
    final example = allExamples[i];
    final instance = example['instance'] as MissingPluginException;
    final tone = example['tone'] as Color;
    final label = example['label'] as String;
    final icon = example['icon'] as IconData;
    final msg = instance.message;
    final dump = instance.toString();
    print('Card[$i] ${label} -> $dump');

    instanceCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tone.withValues(alpha: 0.10),
              tone.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: tone.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: tone.withValues(alpha: 0.25),
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
                    color: tone.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(icon, color: tone, size: 22.0),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Instance #${i + 1}: $label',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: tone,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: tone.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    msg == null ? 'message: null' : 'message: set',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: tone,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                dump,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Colors.orange.shade200,
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'message field: ${msg ?? "<null>"}',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: When it happens (4 scenarios)
  // ============================================================
  print('=== Section 4: When it happens ===');
  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Test environment',
      'icon': Icons.science,
      'detail':
          'Unit/widget tests run on the host VM where plugins have no native impl.',
      'color': Colors.blue,
    },
    {
      'title': 'Platform without plugin',
      'icon': Icons.devices_other,
      'detail':
          'Plugin only ships Android/iOS but app runs on web/macOS/Linux/Windows.',
      'color': Colors.purple,
    },
    {
      'title': 'Before plugin registration',
      'icon': Icons.access_time,
      'detail':
          'Channel called before WidgetsFlutterBinding.ensureInitialized() ran.',
      'color': Colors.teal,
    },
    {
      'title': 'Asset-only test',
      'icon': Icons.image_not_supported,
      'detail':
          'Tests that exercise only Dart UI but a code path tries platform calls.',
      'color': Colors.indigo,
    },
  ];

  final scenarioCards = <Widget>[];
  for (var i = 0; i < scenarios.length; i = i + 1) {
    final s = scenarios[i];
    final color = s['color'] as Color;
    scenarioCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.20),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: color, width: 5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22.0,
              backgroundColor: color.withValues(alpha: 0.25),
              child: Icon(s['icon'] as IconData, color: color, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ${s['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    s['detail'] as String,
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
      ),
    );
  }

  // ============================================================
  // SECTION 5: Catch pattern (code block + UI fallback mock)
  // ============================================================
  print('=== Section 5: Catch pattern ===');
  final catchPattern = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shield, color: Colors.green.shade700, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Graceful try / catch fallback',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          'try {\n'
          '  await SystemChannels.platform.invokeMethod(\'foo\');\n'
          '} on MissingPluginException catch (e) {\n'
          '  // Fallback: feature not available\n'
          '  showFallbackUi(e.message);\n'
          '} catch (e) {\n'
          '  // Other errors: log + report\n'
          '  reportError(e);\n'
          '}',
          Colors.cyan.shade300,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade50, Colors.lightGreen.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade300, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.20),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28.0),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fallback UI rendered',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      'Feature gracefully disabled. App continues.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison table
  // ============================================================
  print('=== Section 6: Comparison ===');
  final comparisonRows = <Map<String, dynamic>>[
    {
      'name': 'MissingPluginException',
      'package': 'services.dart',
      'when': 'No platform handler',
      'color': Colors.deepOrange,
    },
    {
      'name': 'PlatformException',
      'package': 'services.dart',
      'when': 'Native side threw',
      'color': Colors.red,
    },
    {
      'name': 'FormatException',
      'package': 'dart:core',
      'when': 'Bad input format',
      'color': Colors.purple,
    },
    {
      'name': 'Exception',
      'package': 'dart:core',
      'when': 'Generic base type',
      'color': Colors.blueGrey,
    },
  ];

  final comparisonHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade100,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    child: Row(
      children: [
        _buildHeaderCell('Type', 160.0),
        _buildHeaderCell('Package', 110.0),
        _buildHeaderCell('When', 150.0),
      ],
    ),
  );

  final comparisonDataRows = <Widget>[];
  for (final row in comparisonRows) {
    final color = row['color'] as Color;
    comparisonDataRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            _buildDataCell(row['name'] as String, 160.0, color),
            _buildDataCell(row['package'] as String, 110.0, Colors.black54),
            _buildDataCell(row['when'] as String, 150.0, Colors.black87),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        comparisonHeader,
        ...comparisonDataRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Real-world mock (settings page with vibrate toggle)
  // ============================================================
  print('=== Section 7: Real-world mock ===');
  final settingsMock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade50, Colors.grey.shade200],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.settings, color: Colors.blueGrey.shade700),
            SizedBox(width: 8.0),
            Text(
              'Settings (mock)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(
                Icons.vibration,
                color: Colors.blueGrey.shade700,
                size: 28.0,
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vibrate device',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Buzz the device on important events',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 46.0,
                height: 26.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(2.0),
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.shade100, Colors.orange.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade400, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade900),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Not supported on this platform '
                  '(MissingPluginException caught).',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.amber.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            ex1.toString(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.orange.shade200,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: MethodChannel basics (code block)
  // ============================================================
  print('=== Section 8: MethodChannel basics ===');
  final methodChannelBasics = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
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
            Icon(Icons.terminal, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'MethodChannel basics',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// 1. Declare a channel\n'
          'const channel = MethodChannel(\'foo\');\n'
          '\n'
          '// 2. Invoke a method\n'
          'final result = await channel.invokeMethod(\'bar\');\n'
          '//                          ^^^^^^^^^^^^\n'
          '// MissingPluginException fires here when no\n'
          '// handler is registered on the platform side.',
          Colors.green.shade300,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Internally: BinaryMessenger.send returns null\n'
          '// when no handler is found. The channel codec\n'
          '// then translates that into a MissingPluginException.',
          Colors.amber.shade200,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');
  final footguns = <Map<String, dynamic>>[
    {
      'icon': Icons.warning,
      'title': 'message can be null',
      'detail':
          'Always null-check before substituting message into UI strings.',
    },
    {
      'icon': Icons.error_outline,
      'title': 'Wrong channel name in message',
      'detail':
          'Engine messages sometimes show the codec channel, not the failing one.',
    },
    {
      'icon': Icons.merge_type,
      'title': 'Background isolates',
      'detail':
          'Plugin handlers are typically not registered on background isolates.',
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Confusion with PlatformException',
      'detail':
          'PlatformException = native threw; MissingPluginException = no handler at all.',
    },
  ];

  final footgunCards = <Widget>[];
  for (var i = 0; i < footguns.length; i = i + 1) {
    final f = footguns[i];
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.deepOrange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.15),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(f['icon'] as IconData, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ${f['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Colors.red.shade900,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    f['detail'] as String,
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
      ),
    );
  }

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');
  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepOrange.shade400,
          Colors.red.shade500,
          Colors.orange.shade700,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.40),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecapLine('Single field: message (String?)'),
        _buildRecapLine('Constructor: MissingPluginException([msg])'),
        _buildRecapLine('Thrown by BinaryMessenger.send when no handler'),
        _buildRecapLine('Common in tests, web, missing native impls'),
        _buildRecapLine('Catch with: on MissingPluginException catch (e)'),
        _buildRecapLine('Distinct from PlatformException (native threw)'),
        _buildRecapLine('Always render a graceful fallback UI'),
      ],
    ),
  );

  print('MissingPluginException Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.orange.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 22.0),
          _sectionHeader('1. Title banner', Icons.flag, Colors.deepOrange),
          Text(
            'Orange/red diagnostic palette announces the exception type.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 18.0),
          _sectionHeader('2. Anatomy', Icons.account_tree, Colors.deepOrange),
          anatomyBox,
          SizedBox(height: 18.0),
          _sectionHeader(
            '3. Six constructed instances',
            Icons.list_alt,
            Colors.red,
          ),
          ...instanceCards,
          SizedBox(height: 18.0),
          _sectionHeader('4. When it happens', Icons.event, Colors.indigo),
          ...scenarioCards,
          SizedBox(height: 18.0),
          _sectionHeader(
            '5. Catch pattern',
            Icons.shield,
            Colors.green,
          ),
          catchPattern,
          SizedBox(height: 18.0),
          _sectionHeader(
            '6. Comparison',
            Icons.compare_arrows,
            Colors.purple,
          ),
          comparisonTable,
          SizedBox(height: 18.0),
          _sectionHeader(
            '7. Real-world mock',
            Icons.phone_iphone,
            Colors.blueGrey,
          ),
          settingsMock,
          SizedBox(height: 18.0),
          _sectionHeader(
            '8. MethodChannel basics',
            Icons.terminal,
            Colors.teal,
          ),
          methodChannelBasics,
          SizedBox(height: 18.0),
          _sectionHeader(
            '9. Footguns',
            Icons.warning_amber,
            Colors.red,
          ),
          ...footgunCards,
          SizedBox(height: 18.0),
          _sectionHeader('10. Recap', Icons.summarize, Colors.deepOrange),
          recap,
          SizedBox(height: 24.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.deepOrange.shade300),
            ),
            child: Text(
              'Demo built ${allExamples.length} instances; '
              'first toString: ${ex1.toString()}',
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Colors.deepOrange.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// Helper widgets
// ============================================================

Widget _sectionHeader(String text, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
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

Widget _buildField(String name, String type, String description) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade100,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.deepOrange.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.deepOrange.shade900,
      ),
    ),
  );
}

Widget _buildDataCell(String text, double width, Color color) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 11.5,
        color: color,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}

Widget _buildRecapLine(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
