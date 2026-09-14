// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: TapAndPanGestureRecognizer — Harbor Tide Edition
//
// This file is intentionally a long, hand-authored visual catalogue for the
// `TapAndPanGestureRecognizer` Flutter class. It is rendered through the d4rt
// Flutter AST runner and therefore obeys the runner's strict rules:
//
//   * Single dynamic build(BuildContext) entry point.
//   * No StatefulWidget, no setState, no animation controllers, no Future/await.
//   * Index-based for loops only over bridged collection structures.
//   * Color.withValues(alpha:) for transparency adjustments.
//   * child / children declared LAST in widget constructor calls.
//   * Risky constructors (gesture recognizers in particular) are wrapped in
//     try/catch with a graceful fallback string for the UI section.
//
// Theme: "harbor tide" — a palette of weather-beaten teals, oxidised brass,
// rope-fibre cream and twilight indigo, evoking a working dockside at the
// edge of evening. Each section presents a different facet of the recognizer
// so the reader can browse the API surface visually rather than spelunking
// the framework source.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndPanGestureRecognizer harbor-tide demo: starting');

  // ---------------------------------------------------------------------------
  // PALETTE: "Harbor Tide"
  // ---------------------------------------------------------------------------
  //
  // The palette is organised into a tide chart of shades. Each entry is a
  // (label, color, role) triple that we render later as both swatch tiles and
  // tabular references so the user can navigate by name or by hue.
  final Color tideDeep = Color(0xFF0B2A33);
  final Color tideMid = Color(0xFF134E5E);
  final Color tideShoal = Color(0xFF2E8B8B);
  final Color tideShallow = Color(0xFF6FB6B6);
  final Color tideFoam = Color(0xFFE6F0EE);
  final Color brassDark = Color(0xFF6B4F1D);
  final Color brassWarm = Color(0xFFB8893A);
  final Color brassLight = Color(0xFFE5C56A);
  final Color ropeCream = Color(0xFFF3E9C9);
  final Color hempTan = Color(0xFFD9B27C);
  final Color twilightIndigo = Color(0xFF1A1F4A);
  final Color twilightPlum = Color(0xFF3A2A5A);
  final Color sunsetCoral = Color(0xFFE07A5F);
  final Color sunsetRose = Color(0xFFF2C0AD);
  final Color slateLow = Color(0xFF2A2F3A);
  final Color slateHigh = Color(0xFF6E7785);
  final Color signalRed = Color(0xFFB23A3A);
  final Color signalGreen = Color(0xFF4F8A5C);
  final Color signalAmber = Color(0xFFD9A23B);
  final Color paperInk = Color(0xFF1B1E22);

  // ---------------------------------------------------------------------------
  // CORE RECOGNIZER PROBE
  // ---------------------------------------------------------------------------
  //
  // The bridged constructor is wrapped because in some test runs the
  // recognizer cannot be instantiated (missing arena bridges, etc.). We still
  // want the UI to render a "graceful failure" panel rather than abort.
  String coreLine1 = 'recognizer = <not constructed>';
  String coreLine2 = 'onTapDown = <unset>';
  String coreLine3 = 'onTapUp = <unset>';
  String coreLine4 = 'onDragStart = <unset>';
  String coreLine5 = 'onDragUpdate = <unset>';
  String coreLine6 = 'onDragEnd = <unset>';
  String coreLine7 = 'dispose() = pending';
  bool constructed = false;
  try {
    final recognizer = TapAndPanGestureRecognizer();
    constructed = true;
    coreLine1 = 'recognizer = ${recognizer.runtimeType}';
    coreLine2 = 'onTapDown = ${recognizer.onTapDown == null ? "null" : "set"}';
    coreLine3 = 'onTapUp = ${recognizer.onTapUp == null ? "null" : "set"}';
    coreLine4 =
        'onDragStart = ${recognizer.onDragStart == null ? "null" : "set"}';
    coreLine5 =
        'onDragUpdate = ${recognizer.onDragUpdate == null ? "null" : "set"}';
    coreLine6 = 'onDragEnd = ${recognizer.onDragEnd == null ? "null" : "set"}';
    int tapTally = 0;
    recognizer.onTapUp = (TapDragUpDetails details) {
      tapTally++;
      print('  tap completed: tally=$tapTally');
    };
    recognizer.onDragUpdate = (TapDragUpdateDetails details) {
      print('  drag update: delta=${details.delta}');
    };
    recognizer.onDragEnd = (TapDragEndDetails details) {
      print('  drag end: velocity=${details.velocity}');
    };
    coreLine3 = 'onTapUp = bound (TapDragUpDetails -> int)';
    coreLine5 = 'onDragUpdate = bound (TapDragUpdateDetails -> void)';
    coreLine6 = 'onDragEnd = bound (TapDragEndDetails -> void)';
    recognizer.dispose();
    coreLine7 = 'dispose() = ok';
    print('Recognizer probed and disposed cleanly.');
  } catch (e) {
    coreLine7 = 'dispose() = skipped (${e.runtimeType})';
    print('Recognizer probe failed: $e');
  }

  // ---------------------------------------------------------------------------
  // SECTION HELPERS
  // ---------------------------------------------------------------------------
  //
  // We bundle a few small builders here as nested closures so the body of
  // build() reads almost like a print catalogue: every section is a single
  // expression. Helpers use only bridged widgets and obey "children last".
  Widget palettePill(String label, Color swatch, Color textColor) {
    return Container(
      margin: EdgeInsets.only(right: 6, bottom: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: swatch,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: textColor.withValues(alpha: 0.2), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget sectionHeader(String index, String title, String subtitle,
      Color accent, Color paper) {
    return Container(
      margin: EdgeInsets.only(top: 18, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accent.withValues(alpha: 0.85), accent.withValues(alpha: 0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: paper, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: paper.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              index,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: paper,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: paper.withValues(alpha: 0.75),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget kvRow(String key, String value, Color keyColor, Color valColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              key,
              style: TextStyle(
                color: keyColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valColor,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bullet(String body, Color dotColor, Color textColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              body,
              style: TextStyle(
                color: textColor,
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget codeBlock(String body, Color bg, Color fg, Color borderColor) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        body,
        style: TextStyle(
          color: fg,
          fontSize: 10.5,
          fontFamily: 'monospace',
          height: 1.4,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 01: HERO PANEL
  // ---------------------------------------------------------------------------
  final Widget heroPanel = Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tideDeep, tideMid, twilightIndigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassWarm.withValues(alpha: 0.6), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: brassWarm,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'HARBOR TIDE',
                style: TextStyle(
                  color: tideDeep,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'edition 1 / dock-side',
              style: TextStyle(
                color: ropeCream.withValues(alpha: 0.7),
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'TapAndPanGestureRecognizer',
          style: TextStyle(
            color: ropeCream,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'a recognizer that watches a single pointer for either a tap or a',
          style: TextStyle(
            color: tideShallow,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        Text(
          'free pan in any direction, then dispatches details payloads tuned',
          style: TextStyle(
            color: tideShallow,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        Text(
          'for combined tap + drag interactions.',
          style: TextStyle(
            color: tideShallow,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            palettePill('package', tideShoal, tideDeep),
            palettePill('flutter/gestures', brassWarm, tideDeep),
            palettePill(
                'omni-directional', sunsetCoral.withValues(alpha: 0.85), tideDeep),
            palettePill('tap | pan', ropeCream, tideDeep),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'construction status: ${constructed ? "ok" : "fallback"}',
          style: TextStyle(
            color: constructed ? signalGreen : signalRed,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 02: PALETTE GRID
  // ---------------------------------------------------------------------------
  //
  // We generate the palette grid via index-based loops over locally-built
  // List<List<dynamic>> entries. This stays inside the d4rt rules.
  final List<List<dynamic>> paletteEntries = [
    ['tideDeep', tideDeep, 'deep harbor water at dusk', ropeCream],
    ['tideMid', tideMid, 'mid-channel reflection', ropeCream],
    ['tideShoal', tideShoal, 'shoal-line teal', tideDeep],
    ['tideShallow', tideShallow, 'shallow water foam', tideDeep],
    ['tideFoam', tideFoam, 'crested foam highlight', tideDeep],
    ['brassDark', brassDark, 'tarnished port-lamp brass', ropeCream],
    ['brassWarm', brassWarm, 'lantern brass warm', tideDeep],
    ['brassLight', brassLight, 'polished cleat highlight', tideDeep],
    ['ropeCream', ropeCream, 'manila rope cream', tideDeep],
    ['hempTan', hempTan, 'hemp fibre tan', tideDeep],
    ['twilightIndigo', twilightIndigo, 'sky just past sunset', ropeCream],
    ['twilightPlum', twilightPlum, 'plum dusk overlay', ropeCream],
    ['sunsetCoral', sunsetCoral, 'last warm sun on hull', tideDeep],
    ['sunsetRose', sunsetRose, 'pale sunset rose', tideDeep],
    ['slateLow', slateLow, 'pier-board slate low', ropeCream],
    ['slateHigh', slateHigh, 'pier-board slate high', tideDeep],
    ['signalRed', signalRed, 'port-side hazard signal', ropeCream],
    ['signalGreen', signalGreen, 'starboard navigation', ropeCream],
    ['signalAmber', signalAmber, 'caution amber', tideDeep],
    ['paperInk', paperInk, 'log-book ink', ropeCream],
  ];

  final List<Widget> paletteSwatches = [];
  for (var i = 0; i < paletteEntries.length; i++) {
    final entry = paletteEntries[i];
    final String label = entry[0] as String;
    final Color color = entry[1] as Color;
    final String description = entry[2] as String;
    final Color textColor = entry[3] as Color;
    paletteSwatches.add(
      Container(
        width: 230,
        margin: EdgeInsets.only(right: 8, bottom: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: textColor.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  '#${color.value.toRadixString(16).padLeft(8, "0").substring(2)}',
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.7),
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: textColor.withValues(alpha: 0.85),
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                _miniBar(0.2, textColor),
                SizedBox(width: 3),
                _miniBar(0.45, textColor),
                SizedBox(width: 3),
                _miniBar(0.7, textColor),
                SizedBox(width: 3),
                _miniBar(0.95, textColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget paletteSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tideFoam,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tideShallow.withValues(alpha: 0.45), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Harbor Tide palette — twenty named anchors used across the layout',
          style: TextStyle(
            color: tideDeep,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8),
        Wrap(children: paletteSwatches),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 03: API SURFACE TABLE
  // ---------------------------------------------------------------------------
  final List<List<String>> apiRows = [
    ['onTapDown', 'GestureTapDragDownCallback?', 'fired when first contact lands and arena commits'],
    ['onTapUp', 'GestureTapDragUpCallback?', 'fired when contact lifts having stayed below slop'],
    ['onTapCancel', 'GestureCancelCallback?', 'fired when arena revokes after onTapDown'],
    ['onDragStart', 'GestureTapDragStartCallback?', 'first movement that exceeds the slop threshold'],
    ['onDragUpdate', 'GestureTapDragUpdateCallback?', 'every pointer move during an active drag'],
    ['onDragEnd', 'GestureTapDragEndCallback?', 'pointer up with computed pan velocity'],
    ['consecutiveTapCount', 'int', 'tally of successive taps within tap-slop window'],
    ['eagerVictoryOnDrag', 'bool', 'if true, claim arena as soon as drag begins'],
    ['supportedDevices', 'Set<PointerDeviceKind>?', 'limits which input devices are accepted'],
    ['debugOwner', 'Object?', 'object reported in diagnostics to identify owner'],
    ['acceptGesture', 'void Function(int pointer)', 'called by arena when this recognizer wins'],
    ['rejectGesture', 'void Function(int pointer)', 'called by arena when another recognizer wins'],
    ['didExceedSlopTolerance', '@protected bool', 'true once movement crossed the slop ring'],
    ['dispose', 'void Function()', 'releases pointer subscription and arena entry'],
  ];

  final List<Widget> apiTableRows = [];
  for (var i = 0; i < apiRows.length; i++) {
    final row = apiRows[i];
    final bool stripe = (i % 2) == 0;
    apiTableRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        color: stripe ? tideFoam : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 165,
              child: Text(
                row[0],
                style: TextStyle(
                  color: tideDeep,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 235,
              child: Text(
                row[1],
                style: TextStyle(
                  color: brassDark,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[2],
                style: TextStyle(
                  color: slateLow,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget apiSurfaceSection = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tideShoal.withValues(alpha: 0.5), width: 1),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: tideDeep,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 165,
                child: Text(
                  'member',
                  style: TextStyle(
                    color: brassLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              SizedBox(
                width: 235,
                child: Text(
                  'signature',
                  style: TextStyle(
                    color: brassLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'description',
                  style: TextStyle(
                    color: brassLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: apiTableRows,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 04: PROBED RECOGNIZER STATE
  // ---------------------------------------------------------------------------
  final Widget probedStateSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: twilightIndigo,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: brassWarm.withValues(alpha: 0.6), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'live probe — what the recognizer reported during this build()',
          style: TextStyle(
            color: ropeCream,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8),
        kvRow('runtime', coreLine1, brassLight, tideFoam),
        kvRow('onTapDown', coreLine2, brassLight, tideFoam),
        kvRow('onTapUp', coreLine3, brassLight, tideFoam),
        kvRow('onDragStart', coreLine4, brassLight, tideFoam),
        kvRow('onDragUpdate', coreLine5, brassLight, tideFoam),
        kvRow('onDragEnd', coreLine6, brassLight, tideFoam),
        kvRow('dispose', coreLine7, brassLight, tideFoam),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: tideDeep,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: (constructed ? signalGreen : signalRed)
                  .withValues(alpha: 0.7),
              width: 1,
            ),
          ),
          child: Text(
            constructed
                ? 'ok — recognizer was built, callbacks were assigned, then disposed'
                : 'fallback — bridged constructor unavailable in this run; UI still rendered',
            style: TextStyle(
              color: constructed ? signalGreen : sunsetCoral,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 05: LIFECYCLE FLOW
  // ---------------------------------------------------------------------------
  final List<List<String>> lifecycleSteps = [
    ['01', 'pointer down', 'addPointer(event) registers the pointer with arena'],
    ['02', 'arena entry', 'GestureArenaEntry created; recognizer is candidate'],
    ['03', 'tap-down callback', 'onTapDown(details) fires after small acceptance window'],
    ['04', 'movement watch', 'tracker compares each move to slop tolerance'],
    ['05', 'inside slop', 'still a tap candidate — onTapUp possible if pointer lifts'],
    ['06', 'exceeds slop', 'transition to drag; onDragStart(details) fires'],
    ['07', 'arena resolution', 'eagerVictoryOnDrag forces immediate claim'],
    ['08', 'drag updates', 'onDragUpdate(details) emitted on every pointer move'],
    ['09', 'pointer up', 'either onTapUp (no drag) or onDragEnd (had drag)'],
    ['10', 'cancel path', 'onTapCancel if arena revokes after onTapDown'],
    ['11', 'disposal', 'dispose() unregisters arena entry and clears callbacks'],
  ];

  final List<Widget> lifecycleNodes = [];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final bool isLast = i == lifecycleSteps.length - 1;
    final Color stepBg = i.isEven ? tideShoal : tideMid;
    lifecycleNodes.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: stepBg,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: brassWarm.withValues(alpha: 0.7), width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  step[0],
                  style: TextStyle(
                    color: ropeCream,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 22,
                  color: brassWarm.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    step[1],
                    style: TextStyle(
                      color: tideDeep,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    step[2],
                    style: TextStyle(
                      color: slateLow,
                      fontSize: 11,
                      height: 1.35,
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

  final Widget lifecycleSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: ropeCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: brassWarm, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: lifecycleNodes,
    ),
  );

  // ---------------------------------------------------------------------------
  // 06: TIMING DIAGRAM (ASCII)
  // ---------------------------------------------------------------------------
  final String timingAscii =
      'time ───────────────────────────────────────────────────────────────►\n'
      '         t0       t1        t2          t3         t4        t5\n'
      '         |        |         |           |          |         |\n'
      ' down ───●        |         |           |          |         |\n'
      '          \\\\       |         |           |          |         |\n'
      '   move    \\\\──────●         |           |          |         |\n'
      '            \\\\      \\\\         |           |          |         |\n'
      '   slop?    inside  outside →●           |          |         |\n'
      '                              \\\\          |          |         |\n'
      '   drag?                       start ────●          |         |\n'
      '                                          \\\\          |         |\n'
      '   updt   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ●──────────●         |\n'
      '                                                       \\\\        |\n'
      '   up                                                    end ──●\n'
      '                                                                \n'
      ' tap path:  down ─ inside ─ inside ─ up ──► onTapUp(details)\n'
      ' pan path:  down ─ inside ─ outside ──► dragStart ─ updates ─ end';

  final Widget timingDiagramSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: paperInk,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: brassWarm.withValues(alpha: 0.6), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'pointer-event timing diagram (ascii)',
          style: TextStyle(
            color: brassLight,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8),
        Text(
          timingAscii,
          style: TextStyle(
            color: tideShallow,
            fontSize: 10,
            fontFamily: 'monospace',
            height: 1.35,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 07: COMPARISON CARDS
  // ---------------------------------------------------------------------------
  final List<List<String>> compareTopics = [
    ['arena posture', 'eagerly claims on drag', 'eagerly claims on drag', 'standard tap arbitration'],
    ['drag direction', 'free 2D pan', 'horizontal axis only', 'n/a'],
    ['tap details', 'TapDragUpDetails', 'TapDragUpDetails', 'TapUpDetails'],
    ['drag details', 'TapDragUpdateDetails', 'TapDragUpdateDetails', 'n/a'],
    ['use cases', 'maps, canvases', 'sliders, dismiss tiles', 'buttons, list rows'],
    ['cancel cause', 'arena loss / out of slop after up', 'same', 'arena loss after down'],
  ];

  final List<Widget> compareRows = [];
  compareRows.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: tideDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              'topic',
              style: TextStyle(
                color: brassLight,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'TapAndPan',
              style: TextStyle(
                color: brassLight,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'TapAndHorizontalDrag',
              style: TextStyle(
                color: brassLight,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Tap',
              style: TextStyle(
                color: brassLight,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (var i = 0; i < compareTopics.length; i++) {
    final topic = compareTopics[i];
    final bool stripe = (i % 2) == 0;
    compareRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        color: stripe ? tideFoam : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(
                topic[0],
                style: TextStyle(
                  color: brassDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
            Expanded(
              child: Text(
                topic[1],
                style: TextStyle(
                  color: tideDeep,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ),
            Expanded(
              child: Text(
                topic[2],
                style: TextStyle(
                  color: tideDeep,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ),
            Expanded(
              child: Text(
                topic[3],
                style: TextStyle(
                  color: tideDeep,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget comparisonSection = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tideShoal.withValues(alpha: 0.5), width: 1),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: compareRows,
    ),
  );

  // ---------------------------------------------------------------------------
  // 08: POINTER-EVENT TIMELINE
  // ---------------------------------------------------------------------------
  final List<List<String>> pointerEvents = [
    ['t=0ms', 'PointerDownEvent', '(p=14.0,q=22.0)', 'pressure=1.0'],
    ['t=8ms', 'arena.add()', 'pointer=42', 'recognizer=pan'],
    ['t=14ms', 'onTapDown', 'TapDragDownDetails', 'localPosition=(14,22)'],
    ['t=24ms', 'PointerMoveEvent', 'delta=(0.4,0.0)', 'still inside slop'],
    ['t=34ms', 'PointerMoveEvent', 'delta=(1.2,0.6)', 'still inside slop'],
    ['t=44ms', 'PointerMoveEvent', 'delta=(4.5,2.1)', 'just inside slop'],
    ['t=54ms', 'PointerMoveEvent', 'delta=(7.8,4.0)', 'OUTSIDE slop'],
    ['t=55ms', 'onDragStart', 'TapDragStartDetails', 'arena claim'],
    ['t=66ms', 'onDragUpdate', 'delta=(3.0,1.4)', 'velocity tracker fed'],
    ['t=78ms', 'onDragUpdate', 'delta=(2.0,0.9)', 'velocity tracker fed'],
    ['t=92ms', 'onDragUpdate', 'delta=(1.4,0.6)', 'velocity tracker fed'],
    ['t=110ms', 'PointerUpEvent', '(p=44.6,q=37.5)', 'pointer lifted'],
    ['t=111ms', 'onDragEnd', 'TapDragEndDetails', 'velocity≈(180,90) px/s'],
    ['t=120ms', 'arena.exit()', 'cleanup', 'recognizer ready for next'],
  ];

  final List<Widget> timelineRows = [];
  for (var i = 0; i < pointerEvents.length; i++) {
    final ev = pointerEvents[i];
    Color rowAccent;
    if (ev[1].contains('Tap')) {
      rowAccent = sunsetCoral;
    } else if (ev[1].contains('Drag')) {
      rowAccent = tideShoal;
    } else if (ev[1].contains('Pointer')) {
      rowAccent = brassWarm;
    } else {
      rowAccent = slateHigh;
    }
    timelineRows.add(
      Container(
        margin: EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: tideFoam,
          borderRadius: BorderRadius.circular(6),
          border: Border(
            left: BorderSide(color: rowAccent, width: 4),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 70,
              child: Text(
                ev[0],
                style: TextStyle(
                  color: brassDark,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 165,
              child: Text(
                ev[1],
                style: TextStyle(
                  color: tideDeep,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 175,
              child: Text(
                ev[2],
                style: TextStyle(
                  color: slateLow,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                ev[3],
                style: TextStyle(
                  color: slateLow,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget pointerTimelineSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tideShoal.withValues(alpha: 0.4), width: 1),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: timelineRows,
    ),
  );

  // ---------------------------------------------------------------------------
  // 09: CALLBACK SIGNATURE GALLERY
  // ---------------------------------------------------------------------------
  final List<List<String>> callbackSignatures = [
    [
      'onTapDown',
      'void Function(TapDragDownDetails details)',
      'fields: globalPosition, localPosition, kind, consecutiveTapCount',
    ],
    [
      'onTapUp',
      'void Function(TapDragUpDetails details)',
      'fields: globalPosition, localPosition, kind, consecutiveTapCount',
    ],
    [
      'onTapCancel',
      'void Function()',
      'no payload — recognizer is letting go before commit',
    ],
    [
      'onDragStart',
      'void Function(TapDragStartDetails details)',
      'fields: sourceTimeStamp, globalPosition, localPosition, consecutiveTapCount',
    ],
    [
      'onDragUpdate',
      'void Function(TapDragUpdateDetails details)',
      'fields: globalPosition, localPosition, delta, primaryDelta, sourceTimeStamp',
    ],
    [
      'onDragEnd',
      'void Function(TapDragEndDetails details)',
      'fields: velocity, primaryVelocity, consecutiveTapCount',
    ],
  ];

  final List<Widget> callbackTiles = [];
  for (var i = 0; i < callbackSignatures.length; i++) {
    final sig = callbackSignatures[i];
    callbackTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: twilightPlum,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(color: brassLight, width: 4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: brassLight,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'callback',
                    style: TextStyle(
                      color: tideDeep,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  sig[0],
                  style: TextStyle(
                    color: ropeCream,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              sig[1],
              style: TextStyle(
                color: tideShallow,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 4),
            Text(
              sig[2],
              style: TextStyle(
                color: ropeCream.withValues(alpha: 0.75),
                fontSize: 10.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget callbackGallerySection = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: callbackTiles,
  );

  // ---------------------------------------------------------------------------
  // 10: SCENARIO NARRATIVES
  // ---------------------------------------------------------------------------
  final List<List<String>> scenarios = [
    [
      'drag-to-reveal',
      'a list-tile that exposes hidden actions when the user pans sideways',
      'down → tap-down → outside slop → drag-start → drag-updates → drag-end',
      'use eagerVictoryOnDrag=true so the parent ListView does not steal the drag',
    ],
    [
      'tap-to-confirm',
      'a primary action button that expects a tap but tolerates jitter',
      'down → tap-down → inside slop the whole time → up → tap-up',
      'consecutiveTapCount can drive double-tap variants (count==2)',
    ],
    [
      'map-pan',
      'a scrollable, scalable map widget that should follow the finger',
      'down → tap-down → outside slop → drag-start → many drag-updates → drag-end',
      'velocity in TapDragEndDetails feeds an inertia animation',
    ],
    [
      'sketch-canvas',
      'free-hand drawing — every move emits a stroke vertex',
      'down → tap-down → outside slop → drag-start → drag-updates each frame → drag-end',
      'feed delta into a path; tap-only path can place a dot',
    ],
    [
      'photo-pan-and-mark',
      'an image preview where tap places a marker, drag pans the image',
      'two paths share the same recognizer — branches at slop crossing',
      'pin model toggled in onTapUp; image transform driven by drag deltas',
    ],
    [
      'card-shuffle',
      'cards re-orderable by drag; tap selects',
      'tap path sets active card; drag path enters re-order mode',
      'use consecutiveTapCount to detect double-tap-to-flip',
    ],
    [
      'colour-picker',
      'tap chooses a swatch, drag fine-tunes the hue',
      'tap path commits a swatch; drag path updates a hue dial',
      'eagerVictoryOnDrag=true keeps a horizontal carousel from stealing',
    ],
    [
      'volume-knob',
      'tap mutes, drag changes level',
      'tap path toggles mute; drag path updates level continuously',
      'pair with HapticFeedback.selectionClick on each step crossing',
    ],
  ];

  final List<Widget> scenarioCards = [];
  for (var i = 0; i < scenarios.length; i++) {
    final s = scenarios[i];
    scenarioCards.add(
      Container(
        width: 360,
        margin: EdgeInsets.only(right: 10, bottom: 10),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: tideFoam,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tideShoal, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: tideShoal,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'scenario ${(i + 1).toString().padLeft(2, "0")}',
                    style: TextStyle(
                      color: tideFoam,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    s[0],
                    style: TextStyle(
                      color: tideDeep,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              s[1],
              style: TextStyle(
                color: slateLow,
                fontSize: 11,
                height: 1.35,
              ),
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: tideDeep,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                s[2],
                style: TextStyle(
                  color: brassLight,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              'tip:',
              style: TextStyle(
                color: brassDark,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              s[3],
              style: TextStyle(
                color: brassDark,
                fontSize: 10,
                fontStyle: FontStyle.italic,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget scenarioSection = Wrap(children: scenarioCards);

  // ---------------------------------------------------------------------------
  // 11: PITFALLS PANEL
  // ---------------------------------------------------------------------------
  final List<List<String>> pitfalls = [
    [
      'arena starvation',
      'wrapping in a Scrollable without eagerVictoryOnDrag',
      'set eagerVictoryOnDrag=true so drags claim before the scroll view',
    ],
    [
      'tap-vs-drag jitter',
      'noisy touchpads emit moves below slop and accidentally exit it',
      'consider a small pre-acceptance window or larger slop for that device',
    ],
    [
      'double-fire',
      'binding both onTapDown and onTapUp can confuse counts if logic is shared',
      'keep mutation in one callback; use the other for instrumentation only',
    ],
    [
      'leaked recognizer',
      'forgetting to dispose() leaves arena entries dangling',
      'always dispose() in a parent owner that cleans up explicitly',
    ],
    [
      'wrong details',
      'reading TapUpDetails on TapDragUp paths',
      'TapAndPanGestureRecognizer uses TapDrag*Details, not Tap*Details',
    ],
    [
      'ignored kind',
      'forgetting that supportedDevices can be null = "all"',
      'limit to PointerDeviceKind.touch / mouse / stylus when intent is clear',
    ],
    [
      'velocity surprise',
      'TapDragEndDetails velocity assumes tracker had enough samples',
      'short flicks can yield wild velocities — clamp on consumer side',
    ],
    [
      'consecutive tap drift',
      'consecutiveTapCount resets if pointer travels far between taps',
      'do not assume monotonic increase across separate gestures',
    ],
  ];

  final List<Widget> pitfallTiles = [];
  for (var i = 0; i < pitfalls.length; i++) {
    final p = pitfalls[i];
    pitfallTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.alphaBlend(
            signalRed.withValues(alpha: 0.06),
            ropeCream,
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(color: signalRed, width: 4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: signalRed,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'pitfall',
                    style: TextStyle(
                      color: ropeCream,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  p[0],
                  style: TextStyle(
                    color: paperInk,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              p[1],
              style: TextStyle(
                color: slateLow,
                fontSize: 11,
                height: 1.35,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'mitigation: ${p[2]}',
              style: TextStyle(
                color: signalGreen,
                fontSize: 10.5,
                fontStyle: FontStyle.italic,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget pitfallsSection = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: pitfallTiles,
  );

  // ---------------------------------------------------------------------------
  // 12: GAUGES (snapshot animations)
  // ---------------------------------------------------------------------------
  //
  // Each gauge uses AlwaysStoppedAnimation<double> for a tasteful frozen
  // snapshot. The values represent dimensionless ratios from a synthetic run.
  final List<List<dynamic>> gauges = [
    ['acceptance latency', 0.18, 'fraction of slop window used before claim'],
    ['drag commitment', 0.62, 'how decisive the slop crossing was'],
    ['tap stability', 0.85, 'inverse of jitter while pointer was down'],
    ['velocity confidence', 0.74, 'sample count vs. tracker minimum'],
    ['arena pressure', 0.41, 'competitor recognizers vying simultaneously'],
    ['cancel risk', 0.12, 'history of revocations during similar runs'],
    ['frame budget', 0.55, 'estimated cost of update callback per frame'],
    ['battery cost', 0.28, 'pointer-stream wake-up frequency'],
  ];

  final List<Widget> gaugeTiles = [];
  for (var i = 0; i < gauges.length; i++) {
    final g = gauges[i];
    final String label = g[0] as String;
    final double value = g[1] as double;
    final String desc = g[2] as String;
    gaugeTiles.add(
      Container(
        width: 245,
        margin: EdgeInsets.only(right: 10, bottom: 10),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: twilightIndigo,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: brassWarm.withValues(alpha: 0.4), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: brassLight,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
            SizedBox(height: 6),
            Stack(
              children: [
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: tideDeep,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor:
                      AlwaysStoppedAnimation<double>(value).value.clamp(0.0, 1.0),
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [tideShoal, brassLight],
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Text(
                  '${(value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: tideFoam,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    desc,
                    style: TextStyle(
                      color: tideShallow,
                      fontSize: 9.5,
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget gaugesSection = Wrap(children: gaugeTiles);

  // ---------------------------------------------------------------------------
  // 13: SAMPLE CODE BLOCKS
  // ---------------------------------------------------------------------------
  final String sampleCode1 = '''final r = TapAndPanGestureRecognizer()
  ..onTapDown = (TapDragDownDetails d) {
      print('tap-down at \${d.localPosition}');
    }
  ..onTapUp = (TapDragUpDetails d) {
      print('tap-up #\${d.consecutiveTapCount}');
    }
  ..onDragStart = (TapDragStartDetails d) {
      print('drag started');
    }
  ..onDragUpdate = (TapDragUpdateDetails d) {
      print('delta \${d.delta}');
    }
  ..onDragEnd = (TapDragEndDetails d) {
      print('end velocity \${d.velocity}');
    };''';

  final String sampleCode2 = '''class TapAndPanRow extends StatelessWidget {
  const TapAndPanRow({super.key});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapAndPanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                TapAndPanGestureRecognizer>(
          () => TapAndPanGestureRecognizer(),
          (TapAndPanGestureRecognizer r) {
            r
              ..onTapUp = (_) => print('tap')
              ..onDragUpdate = (d) => print(d.delta);
          },
        ),
      },
      child: const Text('tap or drag me'),
    );
  }
}''';

  final String sampleCode3 = '''// disposing in a stateful owner
@override
void dispose() {
  recognizer.dispose();
  super.dispose();
}

// best practice: only the owner that constructs disposes.
// passing a recognizer down a tree without ownership tends to leak.''';

  final String sampleCode4 = '''// reading TapDragUpdateDetails
recognizer.onDragUpdate = (TapDragUpdateDetails d) {
  final Offset delta = d.delta;
  final Offset global = d.globalPosition;
  final Offset local = d.localPosition;
  final double primary = d.primaryDelta ?? 0.0;
  final Duration? ts = d.sourceTimeStamp;
  // do something with the deltas (mutate a model, repaint, etc.)
};''';

  final String sampleCode5 = '''// reading TapDragEndDetails
recognizer.onDragEnd = (TapDragEndDetails d) {
  final Velocity v = d.velocity;
  final double? primary = d.primaryVelocity;
  final int taps = d.consecutiveTapCount;
  // hand v to a SpringSimulation, animate inertia
};''';

  final Widget sampleCodeSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'sample 01 — wiring callbacks via cascade',
        style: TextStyle(
          color: tideDeep,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
      codeBlock(sampleCode1, paperInk, brassLight, brassWarm),
      SizedBox(height: 6),
      Text(
        'sample 02 — installing in RawGestureDetector',
        style: TextStyle(
          color: tideDeep,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
      codeBlock(sampleCode2, paperInk, brassLight, brassWarm),
      SizedBox(height: 6),
      Text(
        'sample 03 — disposal contract',
        style: TextStyle(
          color: tideDeep,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
      codeBlock(sampleCode3, paperInk, brassLight, brassWarm),
      SizedBox(height: 6),
      Text(
        'sample 04 — TapDragUpdateDetails fields',
        style: TextStyle(
          color: tideDeep,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
      codeBlock(sampleCode4, paperInk, brassLight, brassWarm),
      SizedBox(height: 6),
      Text(
        'sample 05 — TapDragEndDetails fields',
        style: TextStyle(
          color: tideDeep,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
      codeBlock(sampleCode5, paperInk, brassLight, brassWarm),
    ],
  );

  // ---------------------------------------------------------------------------
  // 14: GLOSSARY
  // ---------------------------------------------------------------------------
  final List<List<String>> glossary = [
    ['arena', 'gesture recognizer competition manager — picks one winner per pointer'],
    ['claim', 'recognizer asserts ownership of pointer; others get rejectGesture'],
    ['slop', 'distance threshold below which movement does not count as a drag'],
    ['kind', 'PointerDeviceKind: touch, mouse, stylus, trackpad, invertedStylus'],
    ['delta', 'change in position since last move event'],
    ['primary axis', 'the dominant axis a recognizer cares about (n/a for 2D pan)'],
    ['velocity', 'estimated px/s at end of drag, computed from a tracker'],
    ['eager victory', 'claiming the arena as soon as drag begins, preempting parents'],
    ['consecutive tap count', 'count of taps within tap-slop time window'],
    ['debug owner', 'object name shown in diagnostics for a recognizer'],
    ['tap-slop', 'temporal + spatial budget within which a tap remains "intact"'],
    ['pointer down', 'first contact event for a finger / mouse-button press'],
    ['pointer move', 'subsequent move event while contact persists'],
    ['pointer up', 'release of contact'],
    ['pointer cancel', 'OS revokes pointer (e.g. system gesture takes over)'],
    ['details object', 'immutable bundle of fields describing a callback moment'],
    ['supported devices', 'optional set restricting which kinds may trigger'],
    ['accept gesture', 'arena callback awarding a pointer to this recognizer'],
    ['reject gesture', 'arena callback denying a pointer to this recognizer'],
    ['reset state', 'recognizer wipes per-pointer bookkeeping when arena exits'],
  ];

  final List<Widget> glossaryRows = [];
  for (var i = 0; i < glossary.length; i++) {
    final g = glossary[i];
    glossaryRows.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 165,
              child: Text(
                g[0],
                style: TextStyle(
                  color: brassDark,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                g[1],
                style: TextStyle(
                  color: paperInk,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget glossarySection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: ropeCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: brassWarm.withValues(alpha: 0.5), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: glossaryRows,
    ),
  );

  // ---------------------------------------------------------------------------
  // 15: BULLETED HIGHLIGHTS
  // ---------------------------------------------------------------------------
  final List<Widget> highlightBullets = [
    bullet(
      'a single recognizer that gates between tap and free 2D drag, used by '
          'the framework as a foundation for combined-interaction widgets',
      tideShoal,
      paperInk,
    ),
    bullet(
      'callbacks come in three families: tap-* (TapDragUpDetails, TapDragDownDetails), '
          'drag-* (TapDragStartDetails, TapDragUpdateDetails, TapDragEndDetails), '
          'and a parameterless onTapCancel',
      tideShoal,
      paperInk,
    ),
    bullet(
      'consecutiveTapCount lets you build double / triple tap variants on top '
          'without writing an additional recognizer',
      tideShoal,
      paperInk,
    ),
    bullet(
      'eagerVictoryOnDrag controls arbitration: when true, the moment the '
          'pointer leaves slop, the recognizer claims the arena',
      tideShoal,
      paperInk,
    ),
    bullet(
      'sibling: TapAndHorizontalDragGestureRecognizer constrains drag to the '
          'horizontal axis; semantics otherwise mirror this class',
      tideShoal,
      paperInk,
    ),
    bullet(
      'always pair construction with explicit dispose(); leaked recognizers '
          'pin pointer routes and risk arena starvation',
      tideShoal,
      paperInk,
    ),
    bullet(
      'PointerDeviceKind filtering through supportedDevices is recommended '
          'when the gesture only makes sense for some inputs',
      tideShoal,
      paperInk,
    ),
    bullet(
      'velocity is supplied at end-of-drag — feed it directly into a Spring '
          'simulation for natural inertia',
      tideShoal,
      paperInk,
    ),
  ];

  final Widget highlightsSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tideFoam,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tideShoal, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: highlightBullets,
    ),
  );

  // ---------------------------------------------------------------------------
  // 16: ANATOMY OF DETAILS PAYLOADS
  // ---------------------------------------------------------------------------
  final List<List<String>> detailFields = [
    ['TapDragDownDetails.globalPosition', 'Offset', 'where the pointer landed in window coords'],
    ['TapDragDownDetails.localPosition', 'Offset', 'where it landed relative to the receiving render box'],
    ['TapDragDownDetails.kind', 'PointerDeviceKind?', 'touch / mouse / stylus / trackpad'],
    ['TapDragDownDetails.consecutiveTapCount', 'int', 'how many taps in a row are forming this gesture'],
    ['TapDragUpDetails.globalPosition', 'Offset', 'where the pointer lifted in window coords'],
    ['TapDragUpDetails.localPosition', 'Offset', 'where it lifted in local coords'],
    ['TapDragUpDetails.kind', 'PointerDeviceKind?', 'identifying which input lifted'],
    ['TapDragUpDetails.consecutiveTapCount', 'int', 'count at the moment of lift'],
    ['TapDragStartDetails.sourceTimeStamp', 'Duration?', 'engine timestamp when drag started'],
    ['TapDragStartDetails.globalPosition', 'Offset', 'global position at drag start'],
    ['TapDragStartDetails.localPosition', 'Offset', 'local position at drag start'],
    ['TapDragStartDetails.consecutiveTapCount', 'int', 'tap count carried into the drag'],
    ['TapDragUpdateDetails.delta', 'Offset', 'movement since the previous update'],
    ['TapDragUpdateDetails.primaryDelta', 'double?', 'main-axis component (null in 2D)'],
    ['TapDragUpdateDetails.globalPosition', 'Offset', 'current global position'],
    ['TapDragUpdateDetails.localPosition', 'Offset', 'current local position'],
    ['TapDragUpdateDetails.sourceTimeStamp', 'Duration?', 'engine timestamp for this move'],
    ['TapDragEndDetails.velocity', 'Velocity', 'estimated end velocity in px/s'],
    ['TapDragEndDetails.primaryVelocity', 'double?', 'main-axis component (null in 2D)'],
    ['TapDragEndDetails.consecutiveTapCount', 'int', 'tap count carried into the end'],
  ];

  final List<Widget> detailRows = [];
  for (var i = 0; i < detailFields.length; i++) {
    final df = detailFields[i];
    final bool stripe = i.isEven;
    detailRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        color: stripe ? tideFoam : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 280,
              child: Text(
                df[0],
                style: TextStyle(
                  color: tideDeep,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 145,
              child: Text(
                df[1],
                style: TextStyle(
                  color: brassDark,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                df[2],
                style: TextStyle(
                  color: slateLow,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget detailsSection = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tideShoal.withValues(alpha: 0.5), width: 1),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: detailRows,
    ),
  );

  // ---------------------------------------------------------------------------
  // 17: STATE-MACHINE DIAGRAM (ascii)
  // ---------------------------------------------------------------------------
  final String stateMachineAscii =
      '          ┌─────────────────────────────────────────────────────────┐\n'
      '          │                       ready                            │\n'
      '          └────────────────┬───────────────────────────────────────┘\n'
      '                           │ pointer-down\n'
      '                           ▼\n'
      '          ┌─────────────────────────────────────────────────────────┐\n'
      '          │            possibleTap (within slop)                   │\n'
      '          └─────────┬───────────────────────────────────┬─────────┘\n'
      '                    │ pointer-up                       │ moves out of slop\n'
      '                    ▼                                  ▼\n'
      '          ┌─────────────────┐                 ┌─────────────────────┐\n'
      '          │     tap-up      │                 │   dragging (eager)  │\n'
      '          │  onTapUp(d)     │                 │  onDragStart(d)     │\n'
      '          └────────┬────────┘                 └────────┬────────────┘\n'
      '                   │                                   │ moves\n'
      '                   ▼                                   ▼\n'
      '          ┌─────────────────┐                 ┌─────────────────────┐\n'
      '          │      reset      │                 │ onDragUpdate(d) ... │\n'
      '          └─────────────────┘                 └────────┬────────────┘\n'
      '                                                       │ pointer-up\n'
      '                                                       ▼\n'
      '                                              ┌─────────────────────┐\n'
      '                                              │  onDragEnd(d)       │\n'
      '                                              └────────┬────────────┘\n'
      '                                                       │\n'
      '                                                       ▼\n'
      '                                              ┌─────────────────────┐\n'
      '                                              │       reset         │\n'
      '                                              └─────────────────────┘';

  final Widget stateMachineSection = Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: paperInk,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: brassWarm.withValues(alpha: 0.6), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'high-level state machine',
          style: TextStyle(
            color: brassLight,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8),
        Text(
          stateMachineAscii,
          style: TextStyle(
            color: tideShallow,
            fontSize: 9.5,
            fontFamily: 'monospace',
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 18: QUICK-REFERENCE CHIPS
  // ---------------------------------------------------------------------------
  final List<List<dynamic>> chips = [
    ['package:flutter/gestures.dart', tideShoal, ropeCream],
    ['extends BaseTapAndDragGestureRecognizer', brassWarm, paperInk],
    ['indirectly OneSequenceGestureRecognizer', brassDark, ropeCream],
    ['indirectly GestureRecognizer', tideMid, ropeCream],
    ['stable since Flutter 3.13+', signalGreen, ropeCream],
    ['used by SelectableText.dragStartBehavior', sunsetCoral, paperInk],
    ['drives default text-selection drag', sunsetCoral.withValues(alpha: 0.85), paperInk],
    ['supports up to triple-tap counts', signalAmber, paperInk],
    ['no rotation, no scale (use ScaleGestureRecognizer)', slateHigh, ropeCream],
    ['eagerVictoryOnDrag default = false', tideMid, ropeCream],
    ['supportedDevices default = null (all)', tideShoal, ropeCream],
    ['debugOwner shown in DevTools', brassWarm, paperInk],
  ];

  final List<Widget> chipWidgets = [];
  for (var i = 0; i < chips.length; i++) {
    final c = chips[i];
    final String text = c[0] as String;
    final Color bg = c[1] as Color;
    final Color fg = c[2] as Color;
    chipWidgets.add(
      Container(
        margin: EdgeInsets.only(right: 6, bottom: 6),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: fg.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: fg,
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  final Widget chipsSection = Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: tideFoam,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tideShoal.withValues(alpha: 0.45), width: 1),
    ),
    child: Wrap(children: chipWidgets),
  );

  // ---------------------------------------------------------------------------
  // 19: NAUTICAL FOOTER (decorative)
  // ---------------------------------------------------------------------------
  final List<Widget> tideRows = [];
  for (var i = 0; i < 6; i++) {
    final double t = (i + 1) / 6.0;
    tideRows.add(
      Container(
        margin: EdgeInsets.only(bottom: 3),
        height: 6,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tideDeep.withValues(alpha: 1.0 - 0.1 * i),
              tideShoal.withValues(alpha: 0.9 - 0.1 * i),
              tideShallow.withValues(alpha: 0.8 - 0.1 * i),
              tideFoam.withValues(alpha: 0.85 - 0.1 * i),
            ],
            stops: [
              0.0,
              AlwaysStoppedAnimation<double>(0.4 - 0.05 * t).value
                  .clamp(0.0, 0.5),
              AlwaysStoppedAnimation<double>(0.7 - 0.05 * t).value
                  .clamp(0.5, 0.95),
              1.0,
            ],
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  final Widget footerSection = Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [twilightIndigo, tideDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassWarm, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'end of harbor-tide catalogue',
          style: TextStyle(
            color: brassLight,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'TapAndPanGestureRecognizer — sandboxed under d4rt',
          style: TextStyle(
            color: ropeCream.withValues(alpha: 0.8),
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: tideRows,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: signalGreen,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'starboard — clear sea ahead',
              style: TextStyle(
                color: ropeCream,
                fontSize: 11,
              ),
            ),
            SizedBox(width: 18),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: signalRed,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'port — caution; arena starvation possible',
              style: TextStyle(
                color: ropeCream,
                fontSize: 11,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'a tap is a hello, a drag is a story; this recognizer is the harbour\'s '
              'patient ear, listening for either with no preference.',
          style: TextStyle(
            color: tideShallow,
            fontSize: 11,
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // ASSEMBLY
  // ---------------------------------------------------------------------------
  final List<Widget> body = [
    heroPanel,
    sectionHeader('01', 'palette', 'twenty named anchor swatches', tideMid, ropeCream),
    paletteSection,
    sectionHeader('02', 'api surface', 'principal members and their signatures',
        twilightPlum, ropeCream),
    apiSurfaceSection,
    sectionHeader('03', 'live probe',
        'what we actually observed when constructing the recognizer',
        tideShoal, tideDeep),
    probedStateSection,
    sectionHeader('04', 'lifecycle flow',
        'sequence from pointer-down to disposal', brassWarm, tideDeep),
    lifecycleSection,
    sectionHeader('05', 'timing diagram',
        'time-aligned ascii view of tap vs pan paths', paperInk, ropeCream),
    timingDiagramSection,
    sectionHeader('06', 'comparison',
        'how this recognizer differs from neighbours', sunsetCoral, tideDeep),
    comparisonSection,
    sectionHeader('07', 'pointer-event timeline',
        'a synthetic 120ms gesture, frame by frame', tideShoal, tideDeep),
    pointerTimelineSection,
    sectionHeader('08', 'callback gallery',
        'each callback signature in isolation', twilightIndigo, ropeCream),
    callbackGallerySection,
    sectionHeader('09', 'scenarios',
        'eight practical use-cases with branch behaviour', tideMid, ropeCream),
    scenarioSection,
    sectionHeader('10', 'pitfalls',
        'common mistakes and how to avoid them', signalRed, ropeCream),
    pitfallsSection,
    sectionHeader('11', 'snapshot gauges',
        'frozen synthetic metrics from a sample run', twilightPlum, ropeCream),
    gaugesSection,
    sectionHeader('12', 'sample code',
        'paste-ready snippets for typical wirings', tideDeep, brassLight),
    sampleCodeSection,
    sectionHeader('13', 'glossary',
        'terms used throughout this catalogue', brassWarm, tideDeep),
    glossarySection,
    sectionHeader('14', 'highlights',
        'the eight things to remember', tideShoal, tideDeep),
    highlightsSection,
    sectionHeader('15', 'details payloads',
        'every field on every TapDrag*Details type', twilightIndigo, ropeCream),
    detailsSection,
    sectionHeader('16', 'state machine',
        'high-level states and transitions', paperInk, brassLight),
    stateMachineSection,
    sectionHeader('17', 'quick-reference chips',
        'one-liner facts for the road', tideMid, ropeCream),
    chipsSection,
    sectionHeader('18', 'sign-off', 'closing the harbour log', twilightIndigo,
        brassLight),
    footerSection,
  ];

  print('TapAndPanGestureRecognizer harbor-tide demo: build complete');

  return Scaffold(
    backgroundColor: tideFoam,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: body,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Top-level helper: a tiny coloured bar for palette previews. Kept top-level
// (not nested) for readability and to demonstrate that helper top-levels are
// permitted by the rules.
// ---------------------------------------------------------------------------
Widget _miniBar(double t, Color base) {
  return Container(
    width: 18,
    height: 4,
    decoration: BoxDecoration(
      color: base.withValues(alpha: t),
      borderRadius: BorderRadius.circular(2),
    ),
  );
}
