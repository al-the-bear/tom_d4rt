// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: ServicesServiceExtensions enum (package:flutter/services.dart)
// Renders an exhaustive single-screen catalogue of the Services VM service
// extensions that Flutter registers in ServicesBinding.initServiceExtensions.
// The enum currently exposes:
//   * profilePlatformChannels - bool toggle for platform-channel profiling
//   * evict                   - string setter that evicts an asset from the root bundle cache
// Every section uses static motion only (AlwaysStoppedAnimation, Duration.zero).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Reference data: each enum value with the metadata needed to draw a card,
  // a DevTools recipe, and a pitfall list.
  // ---------------------------------------------------------------------------
  final extensionRecords = <Map<String, Object>>[
    <String, Object>{
      'value': ServicesServiceExtensions.profilePlatformChannels,
      'title': 'profilePlatformChannels',
      'extName': 'ext.flutter.profilePlatformChannels',
      'kind': 'bool toggle',
      'icon': Icons.swap_horiz,
      'accent': Colors.indigo,
      'tagline': 'Trace every platform channel call',
      'summary':
          'Toggles debugProfilePlatformChannels. When enabled, Flutter '
          'periodically prints platform-channel statistics to the console '
          'and emits Timeline events that show the time between sending '
          'and receiving a message (encoding/decoding excluded).',
      'argType': 'enabled (bool)',
      'argSample': '"true" / "false"',
      'returns': 'String "true" or "false"',
      'devtoolsRecipe':
          'Performance > Advanced > "Trace platform channels" toggle.',
      'cliRecipe':
          'curl -s \'http://127.0.0.1:PORT/AUTH/ext.flutter.profilePlatformChannels?enabled=true\'',
      'whenToUse': const <String>[
        'Diagnosing slow MethodChannel round trips',
        'Auditing how many channel calls happen during a frame',
        'Looking for runaway plugins that chatter every tick',
      ],
      'pitfalls': const <String>[
        'Costly when left on - flushes printf to stdout each window.',
        'Encoding/decoding time is intentionally excluded.',
        'Only registered when assert() is enabled (debug profile).',
      ],
    },
    <String, Object>{
      'value': ServicesServiceExtensions.evict,
      'title': 'evict',
      'extName': 'ext.flutter.evict',
      'kind': 'String setter',
      'icon': Icons.delete_sweep_outlined,
      'accent': Colors.deepOrange,
      'tagline': 'Drop a cached asset and reload it',
      'summary':
          'Evicts an entry from rootBundle and clears the image cache so the '
          'next read forces a fresh fetch. The Flutter tool calls this during '
          'hot reload whenever an asset on disk changes (foo.png, fonts, '
          'bundled JSON, etc.).',
      'argType': 'value (String) - the asset key',
      'argSample': '"assets/images/logo.png"',
      'returns': 'Empty String getter, void setter',
      'devtoolsRecipe':
          'Hot reload while editing assets - the tool drives this for you.',
      'cliRecipe':
          'curl -s \'http://127.0.0.1:PORT/AUTH/ext.flutter.evict?value=assets/images/logo.png\'',
      'whenToUse': const <String>[
        'Forcing a cache miss for an asset that just changed on disk',
        'Custom dev tooling that swaps assets without a full restart',
        'Integration tests that need a clean image cache between runs',
      ],
      'pitfalls': const <String>[
        'Clears the entire image cache, not just the one asset.',
        'Wrong path = silent no-op (rootBundle keys are case sensitive).',
        'Always available, even when assertions are off.',
      ],
    },
  ];

  // Sanity probes - these expressions read the enum values so the analyzer
  // sees them as actually used (deep demos must "demonstrate" usage).
  final List<ServicesServiceExtensions> allValues =
      ServicesServiceExtensions.values;
  final ServicesServiceExtensions firstValue = allValues.first;
  final ServicesServiceExtensions lastValue = allValues.last;
  final String firstName = firstValue.name;
  final String lastName = lastValue.name;
  final int firstIndex = firstValue.index;
  final int lastIndex = lastValue.index;
  final int totalValues = allValues.length;
  final bool hasEvict = allValues.contains(ServicesServiceExtensions.evict);
  final bool hasProfile =
      allValues.contains(ServicesServiceExtensions.profilePlatformChannels);

  // Fake "progress" animations used only to color progress bars; static.
  final Animation<double> profileMeter = AlwaysStoppedAnimation<double>(0.78);
  final Animation<double> evictMeter = AlwaysStoppedAnimation<double>(0.42);
  final Animation<double> registrationMeter =
      AlwaysStoppedAnimation<double>(1.0);
  final Duration immediate = Duration.zero;

  // ---------------------------------------------------------------------------
  // SECTION 1 - hero header
  // ---------------------------------------------------------------------------
  final Widget heroHeader = Container(
    padding: EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0F172A),
          Color(0xFF1E3A8A),
          Color(0xFF7C3AED),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 28.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyanAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withValues(alpha: 0.5),
                    blurRadius: 14.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Icon(Icons.miscellaneous_services,
                  size: 36.0, color: Colors.indigo.shade900),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ServicesServiceExtensions',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/services.dart - VM service extension catalogue',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4), width: 1.0),
              ),
              child: Text(
                '$totalValues values',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('first: $firstName', Colors.cyanAccent),
            _heroChip('last: $lastName', Colors.amberAccent),
            _heroChip('idx[$firstIndex..$lastIndex]', Colors.pinkAccent),
            _heroChip(hasEvict ? 'evict OK' : 'evict missing',
                Colors.lightGreenAccent),
            _heroChip(
                hasProfile ? 'profile OK' : 'profile missing', Colors.tealAccent),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2 - Anatomy of a Flutter VM service extension
  // ---------------------------------------------------------------------------
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science_outlined,
                color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a service extension call',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17.0,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.indigo.shade100, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Column(
            children: [
              _anatomyRow(
                  '1.', 'Call site', 'DevTools / flutter tool / curl',
                  Icons.send_outlined, Colors.blue),
              _anatomyRow('2.', 'VM Service', 'JSON-RPC over HTTP',
                  Icons.dns_outlined, Colors.indigo),
              _anatomyRow(
                  '3.',
                  'ServicesBinding',
                  'registerBoolServiceExtension / registerStringServiceExtension',
                  Icons.settings_input_component,
                  Colors.deepPurple),
              _anatomyRow('4.', 'Getter / setter', 'Run on the UI isolate',
                  Icons.bolt_outlined, Colors.orange),
              _anatomyRow('5.', 'Side effect', 'Cache evict / debug flag flip',
                  Icons.flash_on_outlined, Colors.red),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade100,
                Colors.indigo.shade50,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Colors.indigo.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The enum value\'s `.name` is the literal extension key '
                  '("ext.flutter." prefix is added by the framework).',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3 - per-value cards (one big card per enum value)
  // ---------------------------------------------------------------------------
  final List<Widget> valueCards = <Widget>[];
  for (final record in extensionRecords) {
    final ServicesServiceExtensions value =
        record['value'] as ServicesServiceExtensions;
    final Color accent = record['accent'] as Color;
    final IconData icon = record['icon'] as IconData;
    final String title = record['title'] as String;
    final String extName = record['extName'] as String;
    final String kind = record['kind'] as String;
    final String tagline = record['tagline'] as String;
    final String summary = record['summary'] as String;
    final String argType = record['argType'] as String;
    final String argSample = record['argSample'] as String;
    final String returns = record['returns'] as String;
    final String devtoolsRecipe = record['devtoolsRecipe'] as String;
    final String cliRecipe = record['cliRecipe'] as String;
    final List<String> whenToUse = record['whenToUse'] as List<String>;
    final List<String> pitfalls = record['pitfalls'] as List<String>;
    final Animation<double> meter =
        value == ServicesServiceExtensions.profilePlatformChannels
            ? profileMeter
            : evictMeter;

    valueCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.06),
              accent.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
              color: accent.withValues(alpha: 0.55), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.32),
              blurRadius: 22.0,
              offset: Offset(0.0, 10.0),
            ),
            BoxShadow(
              color: accent.withValues(alpha: 0.12),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.85),
                    accent.withValues(alpha: 0.55),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.4),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 32.0, color: accent),
                  ),
                  SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.22),
                                borderRadius: BorderRadius.circular(999.0),
                                border: Border.all(
                                    color: Colors.white
                                        .withValues(alpha: 0.45),
                                    width: 1.0),
                              ),
                              child: Text(
                                'idx ${value.index}',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          tagline,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white.withValues(alpha: 0.92),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            extName,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Card body
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: accent.withValues(alpha: 0.3),
                                width: 1.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.description_outlined,
                                      color: accent, size: 16.0),
                                  SizedBox(width: 6.0),
                                  Text(
                                    'Summary',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                      color: accent,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                summary,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  height: 1.45,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _factTile('kind', kind, accent),
                            SizedBox(height: 6.0),
                            _factTile('arg', argType, accent),
                            SizedBox(height: 6.0),
                            _factTile('sample', argSample, accent),
                            SizedBox(height: 6.0),
                            _factTile('returns', returns, accent),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.0),
                  // Meter
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: accent.withValues(alpha: 0.3), width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.speed_outlined,
                                color: accent, size: 16.0),
                            SizedBox(width: 6.0),
                            Text(
                              'Typical activity (illustrative)',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: accent,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${(meter.value * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: accent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          height: 14.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: meter.value,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    accent.withValues(alpha: 0.85),
                                    accent.withValues(alpha: 0.55),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(7.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: accent.withValues(alpha: 0.4),
                                    blurRadius: 6.0,
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.0),
                  // Recipes
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _recipeBlock(
                          'DevTools',
                          devtoolsRecipe,
                          Icons.dashboard_customize_outlined,
                          accent,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: _recipeBlock(
                          'curl',
                          cliRecipe,
                          Icons.terminal,
                          accent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.0),
                  // When to use
                  _bulletList(
                    'When to use',
                    Icons.check_circle_outline,
                    Colors.green.shade700,
                    whenToUse,
                  ),
                  SizedBox(height: 10.0),
                  _bulletList(
                    'Pitfalls',
                    Icons.report_problem_outlined,
                    Colors.red.shade700,
                    pitfalls,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 4 - Registration matrix (matches binding.dart)
  // ---------------------------------------------------------------------------
  final Widget registrationMatrix = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.2),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.app_registration,
                color: Colors.teal.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Registration matrix - ServicesBinding.initServiceExtensions',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              _matrixHeader('value', 170.0),
              _matrixHeader('register*', 200.0),
              _matrixHeader('debug-only', 90.0),
              _matrixHeader('release-mode', 110.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _registrationRow(
          'profilePlatformChannels',
          'registerBoolServiceExtension',
          debugOnly: false,
          inReleaseMode: false,
          accent: Colors.indigo,
        ),
        _registrationRow(
          'evict',
          'registerStringServiceExtension',
          debugOnly: true,
          inReleaseMode: false,
          accent: Colors.deepOrange,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade200, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.amber.shade800, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'evict is wrapped in assert(() { ... }()) so it only '
                  'registers when assertions are enabled (debug builds). '
                  'profilePlatformChannels skips registration in release mode.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.teal.shade900,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5 - DevTools recipe panel
  // ---------------------------------------------------------------------------
  final Widget devtoolsRecipe = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF111827), Color(0xFF1F2937)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.developer_mode,
                color: Colors.cyanAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'DevTools / VM Service recipes',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16.0,
                color: Colors.cyanAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _terminalBlock(
          '# Inspect VM service URL\n'
          'flutter run -d chrome --observatory-port=9000\n'
          '# (look for "Debug service listening on ws://...")',
          Colors.lightGreenAccent,
        ),
        SizedBox(height: 10.0),
        _terminalBlock(
          '# Toggle platform-channel profiling on a running app\n'
          'curl -s "http://127.0.0.1:9000/AUTH/ext.flutter.profilePlatformChannels?enabled=true"\n'
          '# response: {"type":"_extensionType","method":"...","enabled":"true"}',
          Colors.amberAccent,
        ),
        SizedBox(height: 10.0),
        _terminalBlock(
          '# Force-evict an asset from rootBundle\n'
          'curl -s "http://127.0.0.1:9000/AUTH/ext.flutter.evict?value=assets/images/logo.png"\n'
          '# response: {"type":"_extensionType","method":"...","value":""}',
          Colors.lightBlueAccent,
        ),
        SizedBox(height: 10.0),
        _terminalBlock(
          '# Programmatic call from another isolate\n'
          'await developer.Service.getInfo();\n'
          'await developer.Service.controlWebServer(enable: true);',
          Colors.pinkAccent,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border:
                Border.all(color: Colors.cyanAccent.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates_outlined,
                  color: Colors.cyanAccent, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'DevTools knows the same enum values - they are exposed '
                  'verbatim as the wire-protocol method names.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6 - Pitfalls / "do not do this" panel
  // ---------------------------------------------------------------------------
  final Widget pitfallsPanel = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and gotchas',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallRow(
          Icons.dangerous_outlined,
          'Do not ship release builds with profilePlatformChannels enabled - '
          'it is gated by !kReleaseMode but the underlying flag is not.',
        ),
        _pitfallRow(
          Icons.cached_outlined,
          'evict() always nukes the entire image cache. Resetting is global, '
          'not asset-scoped.',
        ),
        _pitfallRow(
          Icons.lock_outline,
          'The VM service URL needs an auth token. curl commands without the '
          'token segment return 403 Forbidden.',
        ),
        _pitfallRow(
          Icons.bug_report_outlined,
          'evict registration is inside an assert lambda - in --release builds '
          'the extension is not present at all.',
        ),
        _pitfallRow(
          Icons.swap_calls_outlined,
          'Custom subclasses can override evict() to broadcast cache-clear '
          'events; super.evict() must still be called.',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7 - Side-by-side comparison
  // ---------------------------------------------------------------------------
  final Widget comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.yellow.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
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
            Icon(Icons.compare_arrows,
                color: Colors.amber.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'profilePlatformChannels vs. evict',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _compareColumn(
                    extensionRecords[0], registrationMeter)),
            SizedBox(width: 12.0),
            Container(
              width: 2.0,
              height: 320.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.amber.withValues(alpha: 0.0),
                    Colors.amber.withValues(alpha: 0.6),
                    Colors.amber.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
                child: _compareColumn(
                    extensionRecords[1], registrationMeter)),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8 - Quick reference card
  // ---------------------------------------------------------------------------
  final Widget quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flash_on, color: Colors.green.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _quickTile('Enum', 'ServicesServiceExtensions',
                Icons.list_alt_outlined, Colors.green),
            _quickTile('values.length', '$totalValues',
                Icons.format_list_numbered, Colors.teal),
            _quickTile('first', firstName, Icons.first_page, Colors.indigo),
            _quickTile('last', lastName, Icons.last_page, Colors.deepPurple),
            _quickTile('library', 'package:flutter/services.dart',
                Icons.book_outlined, Colors.brown),
            _quickTile('binding', 'ServicesBinding',
                Icons.settings_outlined, Colors.blueGrey),
            _quickTile('hot reload', 'uses evict',
                Icons.flash_auto_outlined, Colors.orange),
            _quickTile('profiling',
                'profilePlatformChannels', Icons.timeline, Colors.pink),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'One-liner: iterate the enum',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  color: Colors.green.shade900,
                ),
              ),
              SizedBox(height: 6.0),
              _terminalBlock(
                'for (final ext in ServicesServiceExtensions.values) {\n'
                '  print("ext.flutter.\${ext.name} -> idx \${ext.index}");\n'
                '}',
                Colors.lightGreenAccent,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9 - ASCII flow diagram footer
  // ---------------------------------------------------------------------------
  final Widget asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0B1021), Color(0xFF1A1F36)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.deepPurple.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_outlined,
                color: Colors.purpleAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Flow diagram',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.purpleAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '  +-------------------------+        +------------------------+\n'
          '  | DevTools / flutter tool | -----> |    Dart VM Service     |\n'
          '  +-------------------------+        +-----------+------------+\n'
          '                                                  |\n'
          '                                                  v\n'
          '                                +-----------------+----------------+\n'
          '                                |   ServicesBinding (UI isolate)   |\n'
          '                                +---+-----------------------+------+\n'
          '                                    |                       |\n'
          '                          ext.flutter.evict      ext.flutter.profilePlatformChannels\n'
          '                                    |                       |\n'
          '                                    v                       v\n'
          '                       rootBundle.evict(asset)   debugProfilePlatformChannels = bool\n'
          '                                    |                       |\n'
          '                                    v                       v\n'
          '                          image cache cleared        timeline events emitted\n',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent,
            height: 1.35,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
                color: Colors.deepPurple.shade200, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.verified_outlined,
                  color: Colors.purpleAccent, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Both arrows on the right correspond directly to entries '
                  'in the ServicesServiceExtensions enum.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Compose the page
  // ---------------------------------------------------------------------------
  final Widget body = SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        SizedBox(height: 18.0),
        _sectionHeader('1. Anatomy', Icons.science_outlined, Colors.indigo),
        anatomy,
        SizedBox(height: 18.0),
        _sectionHeader('2. Per-value cards',
            Icons.view_agenda_outlined, Colors.deepPurple),
        ...valueCards,
        SizedBox(height: 18.0),
        _sectionHeader(
            '3. Registration matrix', Icons.app_registration, Colors.teal),
        registrationMatrix,
        SizedBox(height: 18.0),
        _sectionHeader('4. DevTools recipes',
            Icons.developer_mode, Colors.cyan),
        devtoolsRecipe,
        SizedBox(height: 18.0),
        _sectionHeader('5. Pitfalls', Icons.warning_amber_rounded,
            Colors.red),
        pitfallsPanel,
        SizedBox(height: 18.0),
        _sectionHeader('6. Comparison', Icons.compare_arrows, Colors.amber),
        comparisonTable,
        SizedBox(height: 18.0),
        _sectionHeader('7. Quick reference', Icons.flash_on, Colors.green),
        quickReference,
        SizedBox(height: 18.0),
        _sectionHeader('8. Flow diagram',
            Icons.account_tree_outlined, Colors.deepPurple),
        asciiFooter,
        SizedBox(height: 24.0),
        Center(
          child: Text(
            'duration: $immediate (static demo)',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 24.0),
      ],
    ),
  );

  return MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFFF6F7FB),
      body: body,
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper widgets
// ---------------------------------------------------------------------------

Widget _heroChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0, top: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: color.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            height: 1.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.4),
                  color.withValues(alpha: 0.0),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
    String index, String title, String detail, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.85),
                color.withValues(alpha: 0.55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            index,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        SizedBox(
          width: 120.0,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            detail,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _factTile(String label, String value, Color accent) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.3), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeBlock(
    String label, String body, IconData icon, Color accent) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                color: accent,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade100,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _bulletList(
    String title, IconData icon, Color color, List<String> items) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        for (final item in items)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 12.0,
                      height: 1.4,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _matrixHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 11.0,
        color: Colors.teal.shade900,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _registrationRow(
  String name,
  String registrar, {
  required bool debugOnly,
  required bool inReleaseMode,
  required Color accent,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        SizedBox(
          width: 170.0,
          child: Row(
            children: [
              Container(
                width: 6.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200.0,
          child: Text(
            registrar,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        SizedBox(width: 90.0, child: _yesNo(debugOnly)),
        SizedBox(width: 110.0, child: _yesNo(inReleaseMode)),
      ],
    ),
  );
}

Widget _yesNo(bool value) {
  return Row(
    children: [
      Icon(
        value ? Icons.check_circle : Icons.cancel,
        color: value ? Colors.green : Colors.red.shade300,
        size: 18.0,
      ),
      SizedBox(width: 4.0),
      Text(
        value ? 'yes' : 'no',
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          color: value ? Colors.green.shade700 : Colors.red.shade400,
        ),
      ),
    ],
  );
}

Widget _terminalBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF111827),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
          color: Colors.white.withValues(alpha: 0.08), width: 1.0),
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

Widget _pitfallRow(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.red.shade700, size: 16.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _compareColumn(
    Map<String, Object> record, Animation<double> meter) {
  final Color accent = record['accent'] as Color;
  final IconData icon = record['icon'] as IconData;
  final String title = record['title'] as String;
  final String kind = record['kind'] as String;
  final String tagline = record['tagline'] as String;
  final String argType = record['argType'] as String;
  final String returns = record['returns'] as String;
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
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
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.85),
                    accent.withValues(alpha: 0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          tagline,
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 10.0),
        _miniRow('kind', kind, accent),
        _miniRow('arg', argType, accent),
        _miniRow('returns', returns, accent),
        SizedBox(height: 8.0),
        Container(
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: meter.value,
            child: Container(
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _miniRow(String label, String value, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _quickTile(String label, String value, IconData icon, Color color) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, size: 16.0, color: color),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                value,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
