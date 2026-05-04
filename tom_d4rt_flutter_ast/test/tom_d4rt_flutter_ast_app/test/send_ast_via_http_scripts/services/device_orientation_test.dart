// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt deep visual demo: DeviceOrientation enum from package:flutter/services.dart
//
// DeviceOrientation enumerates the four cardinal screen orientations a Flutter
// app can be presented in on mobile platforms. It is most commonly consumed
// through SystemChrome.setPreferredOrientations(...) to lock or unlock layouts,
// and indirectly through MediaQuery.orientationOf(...) and OrientationBuilder
// when laying out content. The enum has exactly four values:
//
//   * portraitUp     - The "natural" upright phone orientation. Status bar at top.
//   * landscapeLeft  - Device rotated 90 degrees counter-clockwise. Top edge points left.
//   * landscapeRight - Device rotated 90 degrees clockwise. Top edge points right.
//   * portraitDown   - Device upside-down. Rare on phones, common on some tablets.
//
// This script renders a curated visual encyclopedia for each orientation:
// hero header, anatomy of the enum, four mocked device frames at the correct
// rotation, a compass rose, a status-bar layout matrix, recipe cards for the
// most common API calls, and a list of pitfalls (tablets, foldables, web, desktop).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('DeviceOrientation Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  // Anchors the visual narrative. The hero card uses two stacked gradients
  // (a deep teal-to-indigo body and a thin highlight bar) so the screenshot
  // stays distinct from any other test in the suite.
  print('=== Section 1: Hero header ===');

  final hero = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF003B46), Color(0xFF07575B), Color(0xFF66A5AD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.45),
          blurRadius: 28.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 18.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Colors.white24, Colors.white10],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 14.0,
                offset: const Offset(0.0, 6.0),
              ),
            ],
          ),
          child: const Icon(Icons.screen_rotation, size: 64.0, color: Colors.white),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'DeviceOrientation',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'package:flutter/services.dart',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white70,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Colors.white30, Colors.white12],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            '${DeviceOrientation.values.length} orientations - 4 cardinal screen rotations',
            style: const TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Enum signature anatomy
  // ============================================================
  // We dissect the signature of the enum so the reader sees the exact identifiers
  // they will type. Each value is paired with its index, the rotation in degrees
  // it logically represents and a short caption describing when to use it.
  print('=== Section 2: Enum signature anatomy ===');

  final anatomy = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.cyanAccent.shade400, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'enum DeviceOrientation',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16.0,
                color: Colors.cyanAccent.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (final DeviceOrientation o in DeviceOrientation.values)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 28.0,
                  child: Text(
                    '${o.index}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.amberAccent.shade200,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'DeviceOrientation.${o.name}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  _humanRotation(o),
                  style: TextStyle(
                    color: Colors.greenAccent.shade400,
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'first = ${DeviceOrientation.values.first.name}    '
            'last  = ${DeviceOrientation.values.last.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3-6: Per-value device-frame mocks
  // ============================================================
  // For each DeviceOrientation we render a stylised phone frame already rotated
  // to match the orientation. The CustomPainter draws a notch, a status-bar
  // and an app stage with a sample home screen. The whole frame uses a
  // RotationTransition driven by AlwaysStoppedAnimation<double>(turns) so we
  // get the visual rotation without any animation ticker.
  print('=== Section 3-6: Device frame mocks per orientation ===');

  final List<_OrientationSpec> specs = <_OrientationSpec>[
    _OrientationSpec(
      orientation: DeviceOrientation.portraitUp,
      title: 'PORTRAIT UP',
      caption: 'Natural upright. The default for nearly every phone app.',
      turns: 0.0,
      accent: Colors.indigo,
      icon: Icons.stay_current_portrait,
    ),
    _OrientationSpec(
      orientation: DeviceOrientation.landscapeLeft,
      title: 'LANDSCAPE LEFT',
      caption: 'Top of device points to the left. Common for video players.',
      turns: -0.25,
      accent: Colors.deepOrange,
      icon: Icons.stay_current_landscape,
    ),
    _OrientationSpec(
      orientation: DeviceOrientation.portraitDown,
      title: 'PORTRAIT DOWN',
      caption: 'Upside-down. Rare on phones, more common on tablets in docks.',
      turns: 0.5,
      accent: Colors.purple,
      icon: Icons.swap_vert,
    ),
    _OrientationSpec(
      orientation: DeviceOrientation.landscapeRight,
      title: 'LANDSCAPE RIGHT',
      caption: 'Top points right. Mirror of landscapeLeft, picked by sensor side.',
      turns: 0.25,
      accent: Colors.teal,
      icon: Icons.screen_lock_landscape,
    ),
  ];

  final List<Widget> frameCards = <Widget>[];
  for (final _OrientationSpec spec in specs) {
    print(
      'Rendering frame for DeviceOrientation.${spec.orientation.name} '
      'turns=${spec.turns}',
    );
    frameCards.add(_buildOrientationCard(spec));
  }

  // ============================================================
  // SECTION 7: Compass rose
  // ============================================================
  // A compass-style rose painted with CustomPainter aligns the four orientations
  // around a circle so the reader can see how each enum value maps to a
  // cardinal direction relative to the device's "up" vector.
  print('=== Section 7: Compass rose ===');

  final compass = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Text(
          'Orientation Compass',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          width: 260.0,
          height: 260.0,
          child: CustomPaint(
            painter: _CompassPainter(),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Each label points in the direction the top of the device faces.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Status-bar layout matrix
  // ============================================================
  // For each orientation we mock the system status bar, the app body and the
  // home indicator. The matrix highlights which edges become "top" / "bottom"
  // for layout purposes - especially important when reasoning about SafeArea.
  print('=== Section 8: Status-bar layout matrix ===');

  final statusBarMatrix = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'System Bars per Orientation',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Status bar edge moves with the device. SafeArea reads viewPadding '
          'from MediaQuery and DOES adapt; raw Padding does NOT.',
          style: TextStyle(fontSize: 12.0, color: Colors.deepOrange.shade700),
        ),
        const SizedBox(height: 14.0),
        for (final _OrientationSpec s in specs) _buildBarRow(s),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Recipe list (SystemChrome.setPreferredOrientations)
  // ============================================================
  // The vast majority of real-world contact with this enum is via
  // SystemChrome.setPreferredOrientations(List<DeviceOrientation>). We provide
  // five copy-paste recipes covering the most common locks people reach for.
  print('=== Section 9: Recipes ===');

  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Lock to portrait only',
      subtitle: 'Most form-heavy apps want this.',
      code:
          'await SystemChrome.setPreferredOrientations(<DeviceOrientation>[\n'
          '  DeviceOrientation.portraitUp,\n'
          ']);',
      tint: Colors.indigo,
    ),
    _Recipe(
      title: 'Allow both landscape sides',
      subtitle: 'Video player rotates with the user.',
      code:
          'await SystemChrome.setPreferredOrientations(<DeviceOrientation>[\n'
          '  DeviceOrientation.landscapeLeft,\n'
          '  DeviceOrientation.landscapeRight,\n'
          ']);',
      tint: Colors.deepOrange,
    ),
    _Recipe(
      title: 'Allow everything (sensor)',
      subtitle: 'Pass an empty list to opt back in to all four.',
      code:
          'await SystemChrome.setPreferredOrientations(\n'
          '  const <DeviceOrientation>[],\n'
          ');',
      tint: Colors.teal,
    ),
    _Recipe(
      title: 'Detect orientation in build',
      subtitle: 'Use MediaQuery, not the enum directly.',
      code:
          'final Orientation o = MediaQuery.orientationOf(context);\n'
          'final bool isPortrait = o == Orientation.portrait;',
      tint: Colors.purple,
    ),
    _Recipe(
      title: 'Reset before page leave',
      subtitle: 'Always undo locks in dispose / route pop.',
      code:
          '@override\n'
          'void dispose() {\n'
          '  SystemChrome.setPreferredOrientations(\n'
          '    DeviceOrientation.values,\n'
          '  );\n'
          '  super.dispose();\n'
          '}',
      tint: Colors.green,
    ),
  ];

  final List<Widget> recipeCards = <Widget>[
    for (final _Recipe r in recipes) _buildRecipeCard(r),
  ];

  // ============================================================
  // SECTION 10: Pitfalls
  // ============================================================
  // A bullet-list of footguns - tablets, foldables, web, desktop, accessibility.
  print('=== Section 10: Pitfalls ===');

  final List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      icon: Icons.tablet_mac,
      title: 'Tablets do not honor portraitUp-only locks the same way',
      detail:
          'On many Android tablets the "natural" orientation is landscape. '
          'A portraitUp lock can result in a device that is physically held in '
          'landscape but rendered upside-down inside a portrait box.',
      tint: Colors.deepPurple,
    ),
    _Pitfall(
      icon: Icons.web,
      title: 'Web ignores SystemChrome.setPreferredOrientations',
      detail:
          'On Flutter web the call is a no-op. Use the Screen Orientation API '
          'via package:web/dart:js_interop or accept that the browser decides.',
      tint: Colors.blue,
    ),
    _Pitfall(
      icon: Icons.desktop_windows,
      title: 'Desktop platforms have no orientation',
      detail:
          'Windows, macOS and Linux always behave like landscape. Avoid '
          'orientation-driven branching in shared code.',
      tint: Colors.brown,
    ),
    _Pitfall(
      icon: Icons.accessibility_new,
      title: 'Accessibility users may force rotation locks at the OS level',
      detail:
          'Even if your app says "all four are fine", the OS-level rotation '
          'lock wins. Always test with rotation lock ON.',
      tint: Colors.pink,
    ),
    _Pitfall(
      icon: Icons.devices_other,
      title: 'Foldables can change orientation on unfold',
      detail:
          'Going from folded portrait to unfolded landscape happens without '
          'user rotation. Listen to MediaQuery, do not cache orientation.',
      tint: Colors.orange,
    ),
    _Pitfall(
      icon: Icons.swap_horizontal_circle,
      title: 'landscapeLeft vs landscapeRight is not arbitrary',
      detail:
          'Camera apps tie the chosen value to the physical sensor, so picking '
          'the wrong one gives mirrored or upside-down preview frames.',
      tint: Colors.red,
    ),
  ];

  final pitfallList = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls and platform quirks',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (final _Pitfall p in pitfalls) _buildPitfallTile(p),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: ASCII footer
  // ============================================================
  // A monospace ASCII art footer keeps the visual narrative anchored at the
  // bottom and gives screenshot viewers a clear "end of demo" signal.
  print('=== Section 11: ASCII footer ===');

  const String asciiArt = '''
  +---------------------------------------------+
  |   DeviceOrientation - 4 cardinal screens    |
  |                                             |
  |        portraitUp        ^                  |
  |                          |                  |
  |   landscapeLeft  <-------+------->  landscapeRight
  |                          |                  |
  |                          v                  |
  |        portraitDown                         |
  |                                             |
  |   SystemChrome.setPreferredOrientations()   |
  +---------------------------------------------+
''';

  final footer = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.grey.shade900, Colors.black87],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Text(
          asciiArt,
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.greenAccent.shade400,
            fontSize: 11.0,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'End of DeviceOrientation deep demo - rendered without animation.',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('DeviceOrientation Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DeviceOrientation Demo',
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              const _SectionHeader(
                index: '2',
                title: 'Enum Anatomy',
                subtitle:
                    'Four constants, four indexes, four logical rotations.',
              ),
              anatomy,
              const SizedBox(height: 16.0),
              const _SectionHeader(
                index: '3',
                title: 'Device Frames',
                subtitle:
                    'Each orientation is mocked at its real rotation - '
                    'rendered with AlwaysStoppedAnimation, no ticker required.',
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: frameCards,
              ),
              const SizedBox(height: 16.0),
              const _SectionHeader(
                index: '4',
                title: 'Compass Rose',
                subtitle:
                    'Cardinal mapping painted by a CustomPainter.',
              ),
              compass,
              const _SectionHeader(
                index: '5',
                title: 'Status Bar Layout Matrix',
                subtitle:
                    'How the system bars rearrange themselves per orientation.',
              ),
              statusBarMatrix,
              const _SectionHeader(
                index: '6',
                title: 'Recipes',
                subtitle:
                    'Five copy-paste-ready SystemChrome calls.',
              ),
              ...recipeCards,
              const _SectionHeader(
                index: '7',
                title: 'Pitfalls',
                subtitle:
                    'What breaks on tablets, web, desktop and foldables.',
              ),
              pitfallList,
              const _SectionHeader(
                index: '8',
                title: 'ASCII Footer',
                subtitle: 'For terminals that render this script too.',
              ),
              footer,
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Helper records / value types
// ----------------------------------------------------------------------------

class _OrientationSpec {
  const _OrientationSpec({
    required this.orientation,
    required this.title,
    required this.caption,
    required this.turns,
    required this.accent,
    required this.icon,
  });

  final DeviceOrientation orientation;
  final String title;
  final String caption;
  final double turns; // in turns; multiplied by 2pi internally
  final Color accent;
  final IconData icon;
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.subtitle,
    required this.code,
    required this.tint,
  });

  final String title;
  final String subtitle;
  final String code;
  final Color tint;
}

class _Pitfall {
  const _Pitfall({
    required this.icon,
    required this.title,
    required this.detail,
    required this.tint,
  });

  final IconData icon;
  final String title;
  final String detail;
  final Color tint;
}

// ----------------------------------------------------------------------------
// Builders
// ----------------------------------------------------------------------------

String _humanRotation(DeviceOrientation o) {
  switch (o) {
    case DeviceOrientation.portraitUp:
      return '// 0 deg - top edge UP';
    case DeviceOrientation.landscapeLeft:
      return '// 90 deg CCW - top edge LEFT';
    case DeviceOrientation.portraitDown:
      return '// 180 deg - top edge DOWN';
    case DeviceOrientation.landscapeRight:
      return '// 90 deg CW - top edge RIGHT';
  }
}

Widget _buildOrientationCard(_OrientationSpec spec) {
  // The frame itself is built upright, then the whole stack is rotated using
  // RotationTransition with an AlwaysStoppedAnimation so the visual rotation
  // exists but no ticker is required.
  final Animation<double> turns = AlwaysStoppedAnimation<double>(spec.turns);

  final Widget device = SizedBox(
    width: 150.0,
    height: 230.0,
    child: CustomPaint(
      painter: _DevicePainter(accent: spec.accent),
    ),
  );

  return Container(
    width: 280.0,
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          spec.accent.withValues(alpha: 0.10),
          spec.accent.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: spec.accent, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spec.accent.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(spec.icon, color: spec.accent, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                spec.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: spec.accent,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: spec.accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'idx ${spec.orientation.index}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: spec.accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: 240.0,
          height: 240.0,
          child: Center(
            child: RotationTransition(
              turns: turns,
              child: device,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: spec.accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'DeviceOrientation.${spec.orientation.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: spec.accent,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          spec.caption,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            color: spec.accent.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBarRow(_OrientationSpec spec) {
  // Mock the system bars by rendering three stacked bars: status bar (top),
  // app body (middle, large) and home indicator (bottom). For landscape
  // orientations we swap the ordering to highlight the change.
  final bool isLandscape =
      spec.orientation == DeviceOrientation.landscapeLeft ||
          spec.orientation == DeviceOrientation.landscapeRight;
  final bool isFlipped = spec.orientation == DeviceOrientation.portraitDown ||
      spec.orientation == DeviceOrientation.landscapeRight;

  final Widget statusBar = Container(
    height: 14.0,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Colors.black87, Colors.black54],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(
            '9:41',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 6.0),
          child: Icon(Icons.battery_full, color: Colors.white, size: 10.0),
        ),
      ],
    ),
  );

  final Widget appBody = Expanded(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            spec.accent.withValues(alpha: 0.20),
            spec.accent.withValues(alpha: 0.40),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
      alignment: Alignment.center,
      child: Text(
        isLandscape ? 'WIDE STAGE' : 'TALL STAGE',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: spec.accent.withValues(alpha: 0.95),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  final Widget homeBar = Container(
    height: 6.0,
    margin: const EdgeInsets.symmetric(horizontal: 30.0),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(3.0),
    ),
  );

  final List<Widget> stack = <Widget>[
    statusBar,
    const SizedBox(height: 4.0),
    appBody,
    const SizedBox(height: 4.0),
    homeBar,
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            spec.orientation.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: spec.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: isLandscape ? 80.0 : 130.0,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: spec.accent, width: 1.2),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: spec.accent.withValues(alpha: 0.18),
                  blurRadius: 6.0,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Column(
              children: isFlipped ? stack.reversed.toList() : stack,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipeCard(_Recipe r) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          r.tint.withValues(alpha: 0.08),
          r.tint.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: r.tint.withValues(alpha: 0.55), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: r.tint.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: r.tint.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.bolt, size: 16.0, color: r.tint),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                r.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: r.tint,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          r.subtitle,
          style: TextStyle(fontSize: 11.0, color: r.tint.withValues(alpha: 0.85)),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            r.code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade400,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallTile(_Pitfall p) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: p.tint.withValues(alpha: 0.4), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: p.tint.withValues(alpha: 0.14),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                p.tint.withValues(alpha: 0.15),
                p.tint.withValues(alpha: 0.35),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Icon(p.icon, color: p.tint, size: 20.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: p.tint,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                p.detail,
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

// ----------------------------------------------------------------------------
// Section header used between major regions of the layout.
// ----------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final String index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.white, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF003B46), Color(0xFF07575B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              index,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade700,
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

// ----------------------------------------------------------------------------
// Compass painter
// ----------------------------------------------------------------------------

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.shortestSide / 2 - 14.0;

    // Outer ring with a soft gradient via a Shader (approximated).
    final Paint outer = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.indigo.shade300;
    canvas.drawCircle(center, radius, outer);

    // Inner ring.
    final Paint inner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.indigo.shade200;
    canvas.drawCircle(center, radius - 18.0, inner);

    // Cardinal arms.
    final Paint arm = Paint()
      ..color = Colors.indigo.shade700
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      arm,
    );
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      arm,
    );

    // Diagonal hairlines.
    final Paint hair = Paint()
      ..color = Colors.indigo.shade200
      ..strokeWidth = 1.0;
    final double diag = radius * 0.7071;
    canvas.drawLine(
      Offset(center.dx - diag, center.dy - diag),
      Offset(center.dx + diag, center.dy + diag),
      hair,
    );
    canvas.drawLine(
      Offset(center.dx - diag, center.dy + diag),
      Offset(center.dx + diag, center.dy - diag),
      hair,
    );

    // Hub.
    final Paint hub = Paint()..color = Colors.indigo.shade700;
    canvas.drawCircle(center, 6.0, hub);

    // Labels at the four cardinal points.
    _drawLabel(canvas, center.translate(0, -radius - 4),
        'portraitUp', Colors.indigo.shade800,
        anchor: _LabelAnchor.bottom);
    _drawLabel(canvas, center.translate(0, radius + 4),
        'portraitDown', Colors.purple.shade800,
        anchor: _LabelAnchor.top);
    _drawLabel(canvas, center.translate(-radius - 4, 0),
        'landscapeLeft', Colors.deepOrange.shade800,
        anchor: _LabelAnchor.right);
    _drawLabel(canvas, center.translate(radius + 4, 0),
        'landscapeRight', Colors.teal.shade800,
        anchor: _LabelAnchor.left);
  }

  void _drawLabel(
    Canvas canvas,
    Offset pos,
    String text,
    Color color, {
    required _LabelAnchor anchor,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset offset;
    switch (anchor) {
      case _LabelAnchor.top:
        offset = Offset(pos.dx - tp.width / 2, pos.dy);
        break;
      case _LabelAnchor.bottom:
        offset = Offset(pos.dx - tp.width / 2, pos.dy - tp.height);
        break;
      case _LabelAnchor.left:
        offset = Offset(pos.dx, pos.dy - tp.height / 2);
        break;
      case _LabelAnchor.right:
        offset = Offset(pos.dx - tp.width, pos.dy - tp.height / 2);
        break;
    }
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum _LabelAnchor { top, bottom, left, right }

// ----------------------------------------------------------------------------
// Device frame painter
// ----------------------------------------------------------------------------

class _DevicePainter extends CustomPainter {
  const _DevicePainter({required this.accent});

  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    // Phone body.
    final RRect body = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      const Radius.circular(22.0),
    );
    final Paint bodyPaint = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[Color(0xFF1C1C1E), Color(0xFF3A3A3C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    canvas.drawRRect(body, bodyPaint);

    // Screen.
    final Rect screenRect = Rect.fromLTWH(
      6.0,
      14.0,
      size.width - 12.0,
      size.height - 28.0,
    );
    final RRect screen = RRect.fromRectAndRadius(
      screenRect,
      const Radius.circular(14.0),
    );
    final Paint screenPaint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.85),
          accent.withValues(alpha: 0.55),
          accent.withValues(alpha: 0.35),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(screenRect);
    canvas.drawRRect(screen, screenPaint);

    // Status bar strip.
    final Rect barRect = Rect.fromLTWH(
      screenRect.left + 6.0,
      screenRect.top + 4.0,
      screenRect.width - 12.0,
      8.0,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(barRect, const Radius.circular(2.0)),
      Paint()..color = Colors.white.withValues(alpha: 0.55),
    );

    // App content blocks (mock home tiles).
    final double tileTop = barRect.bottom + 10.0;
    final double tileSize = (screenRect.width - 24.0) / 3.0;
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final Rect tile = Rect.fromLTWH(
          screenRect.left + 6.0 + col * (tileSize + 2.0),
          tileTop + row * (tileSize + 2.0),
          tileSize,
          tileSize,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(tile, const Radius.circular(4.0)),
          Paint()..color = Colors.white.withValues(alpha: 0.30),
        );
      }
    }

    // Notch.
    final Rect notchRect = Rect.fromLTWH(
      size.width / 2 - 26.0,
      4.0,
      52.0,
      14.0,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(notchRect, const Radius.circular(8.0)),
      Paint()..color = Colors.black,
    );

    // Home indicator.
    final Rect homeRect = Rect.fromLTWH(
      size.width / 2 - 22.0,
      size.height - 10.0,
      44.0,
      4.0,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(homeRect, const Radius.circular(2.0)),
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );

    // "UP" arrow indicator at the top edge so the rotation reads at a glance.
    final Path arrow = Path()
      ..moveTo(size.width / 2, screenRect.top + 30.0)
      ..lineTo(size.width / 2 - 10.0, screenRect.top + 44.0)
      ..lineTo(size.width / 2 + 10.0, screenRect.top + 44.0)
      ..close();
    canvas.drawPath(
      arrow,
      Paint()..color = Colors.white.withValues(alpha: 0.95),
    );
  }

  @override
  bool shouldRepaint(covariant _DevicePainter oldDelegate) =>
      oldDelegate.accent != accent;
}
