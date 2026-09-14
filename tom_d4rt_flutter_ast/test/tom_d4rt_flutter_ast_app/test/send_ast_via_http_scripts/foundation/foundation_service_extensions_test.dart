// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: FoundationServiceExtensions enum from
// package:flutter/foundation.dart. Each enum value (reassemble, exit,
// connectedVmServiceUri, activeDevToolsServerAddress, platformOverride,
// brightnessOverride) gets a distinct visual treatment showing the
// foundation-layer debug toggle it provides via the Dart VM service
// extension protocol.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Static animation controllers used purely as data placeholders.
  // FoundationServiceExtensions is not animated, so all motion is
  // expressed via AlwaysStoppedAnimation<double> + Duration.zero to
  // satisfy the static-motion constraint.
  // ============================================================
  final Animation<double> headerPulse = AlwaysStoppedAnimation<double>(0.85);
  final Animation<double> sectionFade = AlwaysStoppedAnimation<double>(1.0);
  final Animation<double> chipOpacity = AlwaysStoppedAnimation<double>(0.92);
  final Animation<double> ringSweep = AlwaysStoppedAnimation<double>(0.6);
  final Animation<double> footerGlow = AlwaysStoppedAnimation<double>(0.7);
  final Duration zeroDuration = Duration.zero;

  // ============================================================
  // SECTION 1: Hero header with gradient + shadow
  // ============================================================
  final Widget heroHeader = Container(
    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF311B92).withValues(alpha: 0.45),
          blurRadius: 28.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
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
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent.withValues(alpha: 0.35),
                    Colors.deepPurpleAccent.withValues(alpha: 0.35),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.6),
                    blurRadius: 18.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.developer_mode,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: headerPulse.value,
                    child: Text(
                      'FoundationServiceExtensions',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      color: Colors.cyanAccent.shade100,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '6 VM service extension names exposed by the foundation '
                    'binding for DevTools, IDE tooling, and ext.flutter.* '
                    'callers over the Dart VM service protocol.',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Row(
          children: [
            _buildHeroChip('enum', Icons.label_important_outline,
                Colors.cyanAccent),
            SizedBox(width: 8.0),
            _buildHeroChip('foundation', Icons.foundation, Colors.amberAccent),
            SizedBox(width: 8.0),
            _buildHeroChip(
                'ext.flutter.*', Icons.cable, Colors.lightGreenAccent),
            SizedBox(width: 8.0),
            _buildHeroChip('DevTools', Icons.bug_report, Colors.pinkAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a foundation VM service extension
  // ============================================================
  final Widget anatomySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade50,
          Colors.blue.shade50,
          Colors.cyan.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
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
            Icon(Icons.architecture,
                color: Colors.indigo.shade700, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Anatomy of a Foundation Service Extension',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeLine(
                  '// Registered in BindingBase.initServiceExtensions',
                  Colors.grey.shade400),
              _buildCodeLine('registerServiceExtension(',
                  Colors.lightBlueAccent.shade100),
              _buildCodeLine(
                  '  name: FoundationServiceExtensions.reassemble.name,',
                  Colors.amberAccent.shade100),
              _buildCodeLine('  callback: (Map<String, String> args) async {',
                  Colors.greenAccent.shade100),
              _buildCodeLine('    await reassembleApplication();',
                  Colors.white),
              _buildCodeLine('    return <String, dynamic>{};', Colors.white),
              _buildCodeLine('  },', Colors.greenAccent.shade100),
              _buildCodeLine(');', Colors.lightBlueAccent.shade100),
              SizedBox(height: 8.0),
              _buildCodeLine(
                  '// Invoked by tooling as: ext.flutter.reassemble',
                  Colors.grey.shade400),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _buildAnatomyPill(
                'name', '.name suffix on enum value', Colors.indigo),
            _buildAnatomyPill(
                'prefix', 'ext.flutter.<name>', Colors.deepPurple),
            _buildAnatomyPill('args', 'Map<String,String>', Colors.teal),
            _buildAnatomyPill(
                'result', 'Map<String,dynamic>', Colors.deepOrange),
            _buildAnatomyPill('async', 'Future<Map<...>>', Colors.pink),
            _buildAnatomyPill('VM', 'Dart VM service', Colors.green),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (one card per enum value)
  // ============================================================
  final List<_ExtensionMeta> extensionMetas = <_ExtensionMeta>[
    _ExtensionMeta(
      value: FoundationServiceExtensions.reassemble,
      title: 'reassemble',
      subtitle: 'Trigger a full app reassembly',
      icon: Icons.refresh,
      gradient: <Color>[
        Color(0xFFFF6F00),
        Color(0xFFFF8F00),
        Color(0xFFFFB300),
      ],
      tagline: 'Hot reload\u2019s engine room',
      action: 'CALL',
      summary:
          'Causes the entire application to rebuild. This is the service '
          'extension that hot reload calls after delivering new sources to '
          'force every State, RenderObject, and binding to reassemble.',
      bullets: <String>[
        'Forwarded to BindingBase.reassembleApplication()',
        'Each binding reacts in its reassemble() override',
        'Used by `flutter run` after a hot reload',
        'Side effect: visible flicker as widgets rebuild',
      ],
      example: 'await ext.flutter.reassemble();',
    ),
    _ExtensionMeta(
      value: FoundationServiceExtensions.exit,
      title: 'exit',
      subtitle: 'Terminate the running Flutter application',
      icon: Icons.power_settings_new,
      gradient: <Color>[
        Color(0xFFB71C1C),
        Color(0xFFD32F2F),
        Color(0xFFE57373),
      ],
      tagline: 'Hard stop',
      action: 'CALL',
      summary:
          'When invoked the framework asks the platform to exit the process. '
          'Tooling uses this to cleanly stop a debug session without '
          'leaving an orphaned VM around.',
      bullets: <String>[
        'Maps onto SystemNavigator.pop() / process exit on supported targets',
        'Final shutdown hook for IDEs and DevTools',
        'No payload \u2014 it is a one-shot action',
        'Cannot be undone; the isolate is gone afterwards',
      ],
      example: 'await ext.flutter.exit();',
    ),
    _ExtensionMeta(
      value: FoundationServiceExtensions.connectedVmServiceUri,
      title: 'connectedVmServiceUri',
      subtitle: 'Read or write the connected VM service URI',
      icon: Icons.link,
      gradient: <Color>[
        Color(0xFF1565C0),
        Color(0xFF1976D2),
        Color(0xFF42A5F5),
      ],
      tagline: 'Self-reported VM endpoint',
      action: 'GET / SET',
      summary:
          'Stores the URI that the running app believes is its connected '
          'VM service. DevTools reads it back to know where the isolate '
          'lives; tooling can also write a corrected value.',
      bullets: <String>[
        'Backed by the top-level [connectedVmServiceUri] field',
        'String value, e.g. ws://127.0.0.1:51234/abc=/ws',
        'Useful when the embedder cannot guess the URI itself',
        'Round-trips through {value: <uri>} args',
      ],
      example: 'final uri = await ext.flutter.connectedVmServiceUri();',
    ),
    _ExtensionMeta(
      value: FoundationServiceExtensions.activeDevToolsServerAddress,
      title: 'activeDevToolsServerAddress',
      subtitle: 'Address of the DevTools server in use',
      icon: Icons.public,
      gradient: <Color>[
        Color(0xFF00695C),
        Color(0xFF00796B),
        Color(0xFF26A69A),
      ],
      tagline: 'Where DevTools lives',
      action: 'GET / SET',
      summary:
          'Holds the hostname:port of the DevTools server the running app '
          'should associate itself with. Lets multiple debugger frontends '
          'share the same Flutter session without colliding.',
      bullets: <String>[
        'Backed by [activeDevToolsServerAddress] in foundation/_platform',
        'Used to render the \u201cOpen DevTools\u201d link in IDEs',
        'Tools may write it on attach to advertise themselves',
        'Empty value means \u201cno DevTools yet\u201d',
      ],
      example:
          'await ext.flutter.activeDevToolsServerAddress(value: "127.0.0.1:9100");',
    ),
    _ExtensionMeta(
      value: FoundationServiceExtensions.platformOverride,
      title: 'platformOverride',
      subtitle: 'Override defaultTargetPlatform at runtime',
      icon: Icons.devices_other,
      gradient: <Color>[
        Color(0xFF4527A0),
        Color(0xFF6A1B9A),
        Color(0xFF8E24AA),
      ],
      tagline: 'Pretend to be another OS',
      action: 'GET / SET',
      summary:
          'Drives debugDefaultTargetPlatformOverride. Useful for previewing '
          'iOS Cupertino UI on a desktop, or rendering Android material '
          'specifics inside a macOS sandbox.',
      bullets: <String>[
        'Accepted values: android, fuchsia, iOS, linux, macOS, windows',
        'null clears the override and restores autodetection',
        'Tooling persists this choice across hot restarts',
        'Rebuilds the tree because Theme reacts to the change',
      ],
      example: 'await ext.flutter.platformOverride(value: "iOS");',
    ),
    _ExtensionMeta(
      value: FoundationServiceExtensions.brightnessOverride,
      title: 'brightnessOverride',
      subtitle: 'Override platform Brightness at runtime',
      icon: Icons.brightness_6,
      gradient: <Color>[
        Color(0xFF263238),
        Color(0xFF37474F),
        Color(0xFFB0BEC5),
      ],
      tagline: 'Force light or dark mode',
      action: 'GET / SET',
      summary:
          'Drives debugBrightnessOverride. Lets a tool toggle the apparent '
          'platform brightness without rebooting the device, exercising '
          'every theme branch in seconds.',
      bullets: <String>[
        'Accepted values: light, dark, or null',
        'MediaQuery.platformBrightnessOf returns the override',
        'Round-trips through {value: <brightness>} args',
        'Themes that follow MediaQuery flip immediately',
      ],
      example: 'await ext.flutter.brightnessOverride(value: "dark");',
    ),
  ];

  final List<Widget> extensionCards = <Widget>[];
  for (int i = 0; i < extensionMetas.length; i++) {
    extensionCards.add(_buildExtensionCard(
      extensionMetas[i],
      sectionFade.value,
      i,
    ));
    if (i < extensionMetas.length - 1) {
      extensionCards.add(SizedBox(height: 14.0));
    }
  }

  // ============================================================
  // SECTION 4: DevTools recipes for foundation extensions
  // ============================================================
  final Widget recipesSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade50,
          Colors.purple.shade50,
          Colors.pink.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
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
            Icon(Icons.menu_book,
                color: Colors.deepPurple.shade700, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'DevTools Recipes',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecipeRow(
          number: '1',
          color: Colors.deepOrange,
          icon: Icons.refresh,
          title: 'Trigger reassemble after editing assets',
          description:
              'Call ext.flutter.reassemble to rebuild the tree without '
              'shipping new code, which is handy after editing JSON or '
              'localisation files.',
        ),
        _buildRecipeRow(
          number: '2',
          color: Colors.red,
          icon: Icons.power_settings_new,
          title: 'Cleanly tear down a session',
          description:
              'Bind ext.flutter.exit to your IDE\u2019s stop button so the '
              'isolate exits via the framework instead of a SIGKILL.',
        ),
        _buildRecipeRow(
          number: '3',
          color: Colors.blue,
          icon: Icons.link,
          title: 'Discover the VM service URI',
          description:
              'Fetch ext.flutter.connectedVmServiceUri to advertise the '
              'isolate to logging dashboards or remote debuggers.',
        ),
        _buildRecipeRow(
          number: '4',
          color: Colors.teal,
          icon: Icons.public,
          title: 'Pin DevTools to a specific server',
          description:
              'Write ext.flutter.activeDevToolsServerAddress when the user '
              'opens DevTools so the running app knows where to point '
              '\u201cOpen DevTools\u201d shortcuts.',
        ),
        _buildRecipeRow(
          number: '5',
          color: Colors.deepPurple,
          icon: Icons.devices_other,
          title: 'Demo iOS visuals from Android tooling',
          description:
              'Set ext.flutter.platformOverride to "iOS" to preview '
              'Cupertino styling without leaving the desktop simulator.',
        ),
        _buildRecipeRow(
          number: '6',
          color: Colors.blueGrey,
          icon: Icons.brightness_6,
          title: 'Snapshot light vs dark in CI',
          description:
              'Toggle ext.flutter.brightnessOverride between "light" and '
              '"dark" to capture both theme variants of every screen.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Common pitfalls + escape hatches
  // ============================================================
  final Widget pitfallsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.shade50,
          Colors.orange.shade50,
          Colors.red.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.2),
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
            Icon(Icons.warning_amber_rounded,
                color: Colors.orange.shade800, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Common Pitfalls',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildPitfall(
          icon: Icons.bolt,
          color: Colors.deepOrange,
          title: 'Calling reassemble in production',
          body:
              'These extensions are only registered in debug/profile builds. '
              'Release builds drop them entirely \u2014 do not gate user '
              'features on them.',
        ),
        _buildPitfall(
          icon: Icons.lock_clock,
          color: Colors.red,
          title: 'Calling exit synchronously',
          body:
              'ext.flutter.exit returns a Future. Awaiting it after the '
              'isolate is gone deadlocks tooling. Fire-and-forget instead.',
        ),
        _buildPitfall(
          icon: Icons.cable,
          color: Colors.indigo,
          title: 'Stale connectedVmServiceUri',
          body:
              'The URI changes after each hot restart. Tooling that caches '
              'it without re-reading on attach will speak to a dead VM.',
        ),
        _buildPitfall(
          icon: Icons.public_off,
          color: Colors.teal,
          title: 'Empty activeDevToolsServerAddress',
          body:
              'Until DevTools attaches, the value is the empty string \u2014 '
              'never null. Treat empty as \u201cnot connected\u201d.',
        ),
        _buildPitfall(
          icon: Icons.smartphone,
          color: Colors.deepPurple,
          title: 'platformOverride breaks plugin code paths',
          body:
              'Plugins that branch on Platform.isIOS still see the real OS. '
              'Override only affects framework defaultTargetPlatform.',
        ),
        _buildPitfall(
          icon: Icons.brightness_high,
          color: Colors.blueGrey,
          title: 'brightnessOverride fights MediaQuery',
          body:
              'If a widget reads dart:ui PlatformDispatcher directly it '
              'bypasses the override. Always go through MediaQuery.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison with sibling ServiceExtensions enums
  // ============================================================
  final Widget comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.teal.shade50,
          Colors.green.shade50,
          Colors.lime.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
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
                color: Colors.teal.shade700, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Sibling ServiceExtensions Enums',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withValues(alpha: 0.15),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildCompareHeader(),
              _buildCompareRow(
                'FoundationServiceExtensions',
                'flutter/foundation',
                '6',
                'reassemble, exit, platformOverride',
                Colors.indigo,
              ),
              _buildCompareRow(
                'WidgetsServiceExtensions',
                'flutter/widgets',
                '4',
                'debugDumpApp, profileWidgetBuilds',
                Colors.deepPurple,
              ),
              _buildCompareRow(
                'WidgetInspectorServiceExtensions',
                'flutter/widgets',
                '15+',
                'inspector, structuredErrors',
                Colors.pink,
              ),
              _buildCompareRow(
                'RenderingServiceExtensions',
                'flutter/rendering',
                '8',
                'debugPaint, debugDumpRenderTree',
                Colors.deepOrange,
              ),
              _buildCompareRow(
                'SchedulerServiceExtensions',
                'flutter/scheduler',
                '1',
                'timeDilation',
                Colors.teal,
              ),
              _buildCompareRow(
                'ServicesServiceExtensions',
                'flutter/services',
                '1',
                'evict (asset cache)',
                Colors.green,
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade300, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  size: 18.0, color: Colors.teal.shade800),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Foundation owns the cross-cutting toggles (reassemble, '
                  'exit, VM URI, platform/brightness). Other layers register '
                  'their own enums for layer-specific concerns.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.teal.shade900,
                    height: 1.35,
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
  // SECTION 7: Quick reference table of every enum value
  // ============================================================
  final List<TableRow> referenceRows = <TableRow>[
    _buildReferenceHeaderRow(),
  ];
  for (int i = 0; i < FoundationServiceExtensions.values.length; i++) {
    final FoundationServiceExtensions v = FoundationServiceExtensions.values[i];
    final _ExtensionMeta meta = extensionMetas.firstWhere(
      (_ExtensionMeta m) => m.value == v,
      orElse: () => extensionMetas[0],
    );
    referenceRows.add(_buildReferenceRow(
      index: i,
      enumValue: v,
      meta: meta,
    ));
  }

  final Widget quickReference = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blueGrey.shade50,
          Colors.cyan.shade50,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
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
            Icon(Icons.menu_open,
                color: Colors.blueGrey.shade700, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(40.0),
            1: FlexColumnWidth(2.6),
            2: FlexColumnWidth(1.0),
            3: FlexColumnWidth(2.4),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.symmetric(
            inside: BorderSide(
              color: Colors.blueGrey.shade200,
              width: 0.6,
            ),
          ),
          children: referenceRows,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Lifecycle / state diagram
  // ============================================================
  final Widget lifecycleSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.lightBlue.shade50,
          Colors.indigo.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.lightBlue.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.lightBlue.withValues(alpha: 0.2),
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
            Icon(Icons.timeline,
                color: Colors.lightBlue.shade800, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Lifecycle of a Service Extension Call',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildLifecycleStep(
          step: 1,
          color: Colors.indigo,
          icon: Icons.computer,
          title: 'Tooling sends ext.flutter.<name>',
          detail:
              'DevTools or an IDE issues a JSON-RPC call over the VM service '
              'protocol with the enum value\u2019s .name as method.',
        ),
        _buildLifecycleStep(
          step: 2,
          color: Colors.blue,
          icon: Icons.dns,
          title: 'VM service routes to the isolate',
          detail:
              'The Dart VM looks up the registered handler for that name and '
              'forwards the call into the running isolate.',
        ),
        _buildLifecycleStep(
          step: 3,
          color: Colors.teal,
          icon: Icons.bolt,
          title: 'Foundation handler runs',
          detail:
              'BindingBase.initServiceExtensions matches on '
              'FoundationServiceExtensions.<name> and invokes the framework '
              'callback (reassemble, exit, override flags, etc.).',
        ),
        _buildLifecycleStep(
          step: 4,
          color: Colors.deepPurple,
          icon: Icons.refresh,
          title: 'State mutation propagates',
          detail:
              'Side effects (markNeedsBuild, setState in bindings) cause the '
              'tree to rebuild. Get/set extensions also persist the new '
              'value into the foundation library globals.',
        ),
        _buildLifecycleStep(
          step: 5,
          color: Colors.pink,
          icon: Icons.check_circle,
          title: 'Result returned',
          detail:
              'The handler completes with a Map<String, dynamic> body, which '
              'travels back to the caller as the JSON-RPC result.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII art footer
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D1117),
          Color(0xFF161B22),
          Color(0xFF1F2937),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyanAccent.withValues(alpha: 0.22 * footerGlow.value),
          blurRadius: 22.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'foundation://service-extensions',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          '  +-------------------------------------------------------+\n'
          '  |          FoundationServiceExtensions (enum)           |\n'
          '  +-------------------------------------------------------+\n'
          '  | reassemble                  -> ext.flutter.reassemble |\n'
          '  | exit                        -> ext.flutter.exit       |\n'
          '  | connectedVmServiceUri       -> get/set VM URI         |\n'
          '  | activeDevToolsServerAddress -> get/set DevTools host  |\n'
          '  | platformOverride            -> get/set TargetPlatform |\n'
          '  | brightnessOverride          -> get/set Brightness     |\n'
          '  +-------------------------------------------------------+\n'
          '          ^                                       ^        \n'
          '          |  registered in BindingBase.init...    |        \n'
          '          |  invoked over Dart VM service rpc     |        \n'
          '          |                                       |        \n'
          '       DevTools / IDE  <----- JSON-RPC ----->  Isolate     \n',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.cyanAccent.shade100,
            fontSize: 11.0,
            height: 1.25,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.greenAccent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: Colors.greenAccent.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: Text(
            '\$ dart devtools --vm-service-uri \$VM_URI',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.greenAccent,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Compose final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FoundationServiceExtensions Deep Demo',
    home: Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              heroHeader,
              _buildSectionTitle(
                  '1. Anatomy', Icons.architecture, Colors.indigo),
              anatomySection,
              _buildSectionTitle('2. Per-Value Extension Cards',
                  Icons.view_module, Colors.deepPurple),
              ...extensionCards,
              SizedBox(height: 8.0),
              _buildSectionTitle(
                  '3. DevTools Recipes', Icons.menu_book, Colors.deepPurple),
              recipesSection,
              _buildSectionTitle(
                  '4. Pitfalls', Icons.warning_amber_rounded, Colors.orange),
              pitfallsSection,
              _buildSectionTitle('5. Sibling ServiceExtensions Enums',
                  Icons.compare_arrows, Colors.teal),
              comparisonSection,
              _buildSectionTitle(
                  '6. Lifecycle', Icons.timeline, Colors.lightBlue),
              lifecycleSection,
              _buildSectionTitle(
                  '7. Quick Reference', Icons.menu_open, Colors.blueGrey),
              quickReference,
              _buildSectionTitle(
                  '8. Wire Format', Icons.terminal, Colors.green),
              asciiFooter,
            ],
          ),
        ),
      ),
    ),
  );
}

// ================================================================
// Helper data class describing a single enum value
// ================================================================
class _ExtensionMeta {
  _ExtensionMeta({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.tagline,
    required this.action,
    required this.summary,
    required this.bullets,
    required this.example,
  });

  final FoundationServiceExtensions value;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String tagline;
  final String action;
  final String summary;
  final List<String> bullets;
  final String example;
}

// ================================================================
// Section title strip with icon + accent bar
// ================================================================
Widget _buildSectionTitle(String label, IconData icon, MaterialColor color) {
  return Container(
    margin: EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 6.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.shade100.withValues(alpha: 0.85),
          color.shade50,
          Colors.white,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: color.shade400, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, size: 20.0, color: color.shade800),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Hero chip used in header strip
// ================================================================
Widget _buildHeroChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: color),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Code line in dark anatomy block
// ================================================================
Widget _buildCodeLine(String line, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      line,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: color,
        height: 1.35,
      ),
    ),
  );
}

// ================================================================
// Pill describing one anatomy property
// ================================================================
Widget _buildAnatomyPill(String label, String value, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.shade100,
          color.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color.shade800,
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Card for a single FoundationServiceExtensions value
// ================================================================
Widget _buildExtensionCard(
    _ExtensionMeta meta, double fadeValue, int index) {
  final List<Widget> bulletWidgets = <Widget>[];
  for (final String bullet in meta.bullets) {
    bulletWidgets.add(
      Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.chevron_right,
                size: 16.0, color: meta.gradient[1]),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                bullet,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Opacity(
    opacity: fadeValue,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: meta.gradient[1].withValues(alpha: 0.32),
            blurRadius: 18.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 8.0),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner
          Container(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: meta.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.45),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(meta.icon, color: Colors.white, size: 30.0),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              '#${index + 1}  index ${meta.value.index}',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'monospace',
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              meta.action,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'monospace',
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        meta.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        meta.subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 12.5,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          'ext.flutter.${meta.value.name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bolt,
                        size: 16.0, color: meta.gradient[1]),
                    SizedBox(width: 6.0),
                    Text(
                      meta.tagline,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: meta.gradient[1],
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  meta.summary,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade800,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 10.0),
                ...bulletWidgets,
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.terminal,
                          size: 14.0, color: Colors.greenAccent),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          meta.example,
                          style: TextStyle(
                            color: Colors.greenAccent.shade100,
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                          ),
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
    ),
  );
}

// ================================================================
// One row inside the DevTools recipes section
// ================================================================
Widget _buildRecipeRow({
  required String number,
  required MaterialColor color,
  required IconData icon,
  required String title,
  required String description,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.shade300, color.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
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
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: color.shade100, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.12),
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
                    Icon(icon, size: 16.0, color: color.shade700),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: color.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Pitfall block
// ================================================================
Widget _buildPitfall({
  required IconData icon,
  required MaterialColor color,
  required String title,
  required String body,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: color.shade400, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.14),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color.shade700, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
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

// ================================================================
// Comparison header (sibling enums table)
// ================================================================
Widget _buildCompareHeader() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.teal.shade100,
          Colors.cyan.shade100,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            'Enum',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Colors.teal.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Library',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Colors.teal.shade900,
            ),
          ),
        ),
        SizedBox(
          width: 36.0,
          child: Text(
            '#',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Colors.teal.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Examples',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Colors.teal.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Comparison row (sibling enums table)
// ================================================================
Widget _buildCompareRow(String name, String library, String count,
    String examples, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: color.shade800,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            library,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        SizedBox(
          width: 36.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.shade100,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            examples,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Quick reference table header row
// ================================================================
TableRow _buildReferenceHeaderRow() {
  return TableRow(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blueGrey.shade200,
          Colors.cyan.shade100,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    children: <Widget>[
      _refHeaderCell('#'),
      _refHeaderCell('Enum value'),
      _refHeaderCell('Action'),
      _refHeaderCell('Effect'),
    ],
  );
}

// ================================================================
// Quick reference data row
// ================================================================
TableRow _buildReferenceRow({
  required int index,
  required FoundationServiceExtensions enumValue,
  required _ExtensionMeta meta,
}) {
  return TableRow(
    decoration: BoxDecoration(
      color: index.isEven
          ? Colors.white
          : Colors.blueGrey.shade50.withValues(alpha: 0.6),
    ),
    children: <Widget>[
      _refDataCell(
        Text(
          '$index',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      _refDataCell(
        Text(
          enumValue.name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: meta.gradient[1],
          ),
        ),
      ),
      _refDataCell(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: meta.gradient[1].withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            meta.action,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: meta.gradient[1],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      _refDataCell(
        Text(
          meta.tagline,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    ],
  );
}

// ================================================================
// Quick reference helpers
// ================================================================
Widget _refHeaderCell(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.blueGrey.shade900,
      ),
    ),
  );
}

Widget _refDataCell(Widget child) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: child,
  );
}

// ================================================================
// Lifecycle step widget
// ================================================================
Widget _buildLifecycleStep({
  required int step,
  required MaterialColor color,
  required IconData icon,
  required String title,
  required String detail,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          color.shade50,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.14),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.shade400, color.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.45),
                blurRadius: 8.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16.0, color: color.shade800),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: color.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 12.0,
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
