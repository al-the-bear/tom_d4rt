// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo - HitTestBehavior (Flutter rendering)
// ---------------------------------------------------------------------------
// HitTestBehavior is a small enum exported from package:flutter/rendering.dart
// (and re-exported from material.dart via widgets.dart) that controls how a
// RenderProxyBoxWithHitTestBehavior decides whether a pointer event "lands"
// on it. Most users encounter it through:
//
//   - GestureDetector(behavior: HitTestBehavior.X, child: ...)
//   - Listener(behavior: HitTestBehavior.X, child: ...)
//   - MouseRegion(opaque: bool ...)   (similar concept, different switch)
//
// The three values:
//   - HitTestBehavior.deferToChild  : the box only considers itself "hit" if
//                                     one of its descendants reports a hit.
//                                     Empty space inside the box does NOTHING.
//                                     This is the DEFAULT for most detectors.
//   - HitTestBehavior.opaque        : the box reports a hit anywhere inside
//                                     its painted bounds AND consumes the
//                                     event so siblings BELOW in the stack
//                                     never see it.
//   - HitTestBehavior.translucent   : the box reports a hit anywhere inside
//                                     its painted bounds BUT also lets the
//                                     event keep walking the tree, so
//                                     siblings BELOW can still react.
//
// This file is a hand-authored, harness-safe demo. It does NOT call runApp()
// or main(); it only exposes a build(BuildContext) that returns a MaterialApp.
// Each section uses a StatefulBuilder so the local tap log is reactive without
// needing a top-level Stateful widget.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== HitTestBehavior Deep Demo ===');
  for (final v in HitTestBehavior.values) {
    print('  enum value ${v.index}: ${v.name}');
  }

  // ---------------------------------------------------------------------------
  // Helpers shared across sections. They are defined here as closures so the
  // demo file stays self-contained (no top-level helper widgets needed).
  // ---------------------------------------------------------------------------

  String stamp() {
    final now = DateTime.now();
    final m = now.minute.toString().padLeft(2, '0');
    final s = now.second.toString().padLeft(2, '0');
    final ms = now.millisecond.toString().padLeft(3, '0');
    return '$m:$s.$ms';
  }

  Widget logPanel(List<String> entries, Color background, Color accent) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 110, maxHeight: 220),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      child: entries.isEmpty
          ? Text(
              '(no taps yet - tap the zones above)',
              style: TextStyle(
                color: accent.withOpacity(0.7),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            )
          : ListView(
              shrinkWrap: true,
              reverse: true,
              children: [
                for (final line in entries.reversed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.5),
                    child: Text(
                      line,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: accent,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  // Per-section state - each section gets its own log list and ValueNotifier
  // so cross-section interactions don't pollute one another.
  final s2DeferLog = <String>[];
  final s2OpaqueLog = <String>[];
  final s2TranslucentLog = <String>[];

  final s3DeferLog = <String>[];

  final s4OpaqueLog = <String>[];

  final s5TranslucentLog = <String>[];

  final s6BgLog = <String>[];
  final s6OverlayDeferLog = <String>[];
  final s6OverlayOpaqueLog = <String>[];
  final s6OverlayTranslucentLog = <String>[];
  HitTestBehavior s6Behavior = HitTestBehavior.deferToChild;

  bool s7Wrapped = false;
  final s7Log = <String>[];

  bool s8ScrollerLog = false;
  final s8ScrollerEntries = <String>[];
  int s8EdgeSwipeCount = 0;

  bool s9Blocking = false;
  final s9Log = <String>[];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'HitTestBehavior Deep Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: Scaffold(
      backgroundColor: const Color(0xFFEEF1F8),
      appBar: AppBar(
        title: const Text('HitTestBehavior - Deep Demo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===============================================================
              // SECTION 1 - HERO INTRO CARD
              // ---------------------------------------------------------------
              // Sets the scene: what hit testing is in Flutter, why an enum
              // controls it, and what the three values mean. Sized to feel
              // weighty so the page looks "alive" before the reader scrolls.
              // ===============================================================
              Card(
                color: const Color(0xFF1A237E),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.touch_app,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'enum HitTestBehavior',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'How should this widget participate in hit testing?',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 18),
                      _heroValueRow(
                        token: '.deferToChild',
                        title: 'Only hits where a child is hit',
                        body:
                            'Empty space inside the widget does nothing. This '
                            'is the default for GestureDetector when a child '
                            'is provided.',
                        accent: const Color(0xFF80DEEA),
                      ),
                      const SizedBox(height: 10),
                      _heroValueRow(
                        token: '.opaque',
                        title: 'Hit anywhere, blocks below',
                        body:
                            'The bounds count as a single solid hit target. '
                            'Sibling detectors painted underneath will not '
                            'see the event.',
                        accent: const Color(0xFFFFAB91),
                      ),
                      const SizedBox(height: 10),
                      _heroValueRow(
                        token: '.translucent',
                        title: 'Hit anywhere, lets it through',
                        body:
                            'Same hit area as opaque, but the event also '
                            'continues to widgets stacked behind, so they '
                            'can react too.',
                        accent: const Color(0xFFCE93D8),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.18),
                          ),
                        ),
                        child: const Text(
                          'Mental model: Flutter walks the render tree from '
                          'the leaf nearest the pointer back up to the root. '
                          'Each detector decides whether to be part of the '
                          'hit-test result. opaque/translucent both ADD '
                          'themselves; the difference is whether the walk '
                          'continues past their painting bounds to siblings.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 2 - THREE-WAY COMPARISON
              // ---------------------------------------------------------------
              // The same Stack layout repeated three times: a small painted
              // child sits inside a larger transparent detector. The user can
              // tap on:
              //   (a) the painted child (always logged)
              //   (b) the empty bounds around the child
              //   (c) outside the detector entirely
              // The three columns show how each behavior responds to (b).
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF1A237E),
                title: '2. Same layout, three behaviors',
                subtitle:
                    'Tap the small dot, tap the empty area around it, and '
                    'tap outside the detector. Compare which taps each '
                    'column logs.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _BehaviorColumn(
                                  title: '.deferToChild',
                                  background: const Color(0xFFE0F7FA),
                                  accent: const Color(0xFF00838F),
                                  detector: GestureDetector(
                                    behavior: HitTestBehavior.deferToChild,
                                    onTapDown: (d) => setState(() {
                                      s2DeferLog.add(
                                        '${stamp()}  bounds tap (will not '
                                        'fire if outside child)',
                                      );
                                    }),
                                    child: _DetectorBox(
                                      hint: 'Defer',
                                      accent: const Color(0xFF00838F),
                                      onChildTap: () => setState(() {
                                        s2DeferLog.add(
                                          '${stamp()}  CHILD tap',
                                        );
                                      }),
                                    ),
                                  ),
                                  log: s2DeferLog,
                                  onClear: () => setState(s2DeferLog.clear),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _BehaviorColumn(
                                  title: '.opaque',
                                  background: const Color(0xFFFFF3E0),
                                  accent: const Color(0xFFE65100),
                                  detector: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTapDown: (d) => setState(() {
                                      s2OpaqueLog.add(
                                        '${stamp()}  ANY tap inside bounds',
                                      );
                                    }),
                                    child: _DetectorBox(
                                      hint: 'Opaque',
                                      accent: const Color(0xFFE65100),
                                      onChildTap: () => setState(() {
                                        s2OpaqueLog.add(
                                          '${stamp()}  CHILD tap (also '
                                          'logged by parent above)',
                                        );
                                      }),
                                    ),
                                  ),
                                  log: s2OpaqueLog,
                                  onClear: () => setState(s2OpaqueLog.clear),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _BehaviorColumn(
                                  title: '.translucent',
                                  background: const Color(0xFFF3E5F5),
                                  accent: const Color(0xFF6A1B9A),
                                  detector: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTapDown: (d) => setState(() {
                                      s2TranslucentLog.add(
                                        '${stamp()}  ANY tap inside bounds',
                                      );
                                    }),
                                    child: _DetectorBox(
                                      hint: 'Trans',
                                      accent: const Color(0xFF6A1B9A),
                                      onChildTap: () => setState(() {
                                        s2TranslucentLog.add(
                                          '${stamp()}  CHILD tap',
                                        );
                                      }),
                                    ),
                                  ),
                                  log: s2TranslucentLog,
                                  onClear: () =>
                                      setState(s2TranslucentLog.clear),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8EAF6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Reading the columns: with .deferToChild only '
                              'tapping the small painted child fires the '
                              "outer onTapDown. With .opaque the entire box "
                              'is tappable and the event STOPS there. With '
                              '.translucent the box is also fully tappable, '
                              'but stacked siblings (see Section 6) still '
                              'see the event.',
                              style: TextStyle(fontSize: 12, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 3 - .deferToChild zoom
              // ---------------------------------------------------------------
              // A larger interactive area where only the painted child is
              // hittable. Demonstrates the most common surprise: "my tap
              // inside the SizedBox did nothing!".
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF00838F),
                title: '3. .deferToChild in detail',
                subtitle:
                    'Only descendants that themselves report a hit count. '
                    'Empty space is invisible to the detector.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    color: const Color(0xFFE0F7FA),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GestureDetector(behavior: HitTestBehavior.'
                            'deferToChild)',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00838F),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.deferToChild,
                            onTapDown: (d) => setState(() {
                              s3DeferLog.add(
                                '${stamp()}  outer fired (because a CHILD '
                                'was hit at ${d.localPosition.dx.toStringAsFixed(0)},'
                                '${d.localPosition.dy.toStringAsFixed(0)})',
                              );
                            }),
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF00838F),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 30,
                                    top: 30,
                                    child: GestureDetector(
                                      onTap: () => setState(() {
                                        s3DeferLog.add(
                                          '${stamp()}  inner blue '
                                          'circle tapped',
                                        );
                                      }),
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF0288D1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.adjust,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 40,
                                    bottom: 30,
                                    child: GestureDetector(
                                      onTap: () => setState(() {
                                        s3DeferLog.add(
                                          '${stamp()}  inner orange '
                                          'square tapped',
                                        );
                                      }),
                                      child: Container(
                                        width: 70,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEF6C00),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'tap',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 6),
                                        child: Text(
                                          'tap empty space here -> nothing '
                                          'happens',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF00838F),
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          logPanel(
                            s3DeferLog,
                            const Color(0xFFB2EBF2),
                            const Color(0xFF006064),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => setState(s3DeferLog.clear),
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear log'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 4 - .opaque zoom
              // ---------------------------------------------------------------
              // Same shape as section 3 but the outer detector is .opaque.
              // Now ANY tap inside its bounds is the outer's tap. The inner
              // detectors are still hit when their actual area is touched
              // (Flutter delivers the deepest hit first), but tapping empty
              // bounds also fires.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFFE65100),
                title: '4. .opaque in detail',
                subtitle:
                    'Bounds become a single hit target. Use this when you '
                    'want a panel that swallows clicks (e.g. modal scrims).',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    color: const Color(0xFFFFF3E0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GestureDetector(behavior: HitTestBehavior.opaque)',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE65100),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapDown: (d) => setState(() {
                              s4OpaqueLog.add(
                                '${stamp()}  outer fired at '
                                '${d.localPosition.dx.toStringAsFixed(0)},'
                                '${d.localPosition.dy.toStringAsFixed(0)}',
                              );
                            }),
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFE65100),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 30,
                                    top: 30,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD84315),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.block,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 6),
                                        child: Text(
                                          'tap anywhere -> outer always fires',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFFE65100),
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          logPanel(
                            s4OpaqueLog,
                            const Color(0xFFFFE0B2),
                            const Color(0xFFBF360C),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => setState(s4OpaqueLog.clear),
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear log'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 5 - .translucent zoom
              // ---------------------------------------------------------------
              // .translucent looks identical to .opaque from the user's
              // perspective UNTIL we put another detector behind it. Section
              // 6 is where translucent really shines; here we just confirm
              // that the bounds are tappable like opaque.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF6A1B9A),
                title: '5. .translucent in detail',
                subtitle:
                    'Same hit area as opaque, but the event continues to '
                    'siblings stacked behind. Section 6 makes that '
                    'observable.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    color: const Color(0xFFF3E5F5),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GestureDetector(behavior: HitTestBehavior.'
                            'translucent)',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6A1B9A),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTapDown: (d) => setState(() {
                              s5TranslucentLog.add(
                                '${stamp()}  fired at '
                                '${d.localPosition.dx.toStringAsFixed(0)},'
                                '${d.localPosition.dy.toStringAsFixed(0)}',
                              );
                            }),
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF6A1B9A),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'translucent zone\n(no paint, but tappable)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF6A1B9A),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          logPanel(
                            s5TranslucentLog,
                            const Color(0xFFE1BEE7),
                            const Color(0xFF4A148C),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () =>
                                  setState(s5TranslucentLog.clear),
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear log'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 6 - LAYERED DETECTORS
              // ---------------------------------------------------------------
              // The big reveal: a Stack with a background detector painted
              // first and an OVERLAY detector painted second. The user picks
              // the overlay's behavior with a SegmentedButton; the log shows
              // exactly which detectors fire.
              //
              // - deferToChild: overlay only fires where its child paints,
              //                 background sees taps in empty space
              //                 (children are painted ON TOP, so over-child
              //                 taps still go to the overlay child).
              // - opaque:       overlay swallows all taps in its bounds,
              //                 background never fires inside those bounds.
              // - translucent:  overlay AND background both fire for taps
                  //             inside the overlay bounds.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF1565C0),
                title: '6. Layered detectors - which one wins?',
                subtitle:
                    'Same tap, different outcomes depending on the overlay '
                    'behavior. Watch the two log panels at the bottom.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  List<String> overlayLogFor(HitTestBehavior b) {
                    switch (b) {
                      case HitTestBehavior.deferToChild:
                        return s6OverlayDeferLog;
                      case HitTestBehavior.opaque:
                        return s6OverlayOpaqueLog;
                      case HitTestBehavior.translucent:
                        return s6OverlayTranslucentLog;
                    }
                  }

                  final activeOverlayLog = overlayLogFor(s6Behavior);

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final b in HitTestBehavior.values)
                                ChoiceChip(
                                  label: Text('.${b.name}'),
                                  selected: s6Behavior == b,
                                  onSelected: (_) =>
                                      setState(() => s6Behavior = b),
                                ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                // Background detector - always present, shows
                                // as a hatched panel.
                                Positioned.fill(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTapDown: (d) => setState(() {
                                      s6BgLog.add(
                                        '${stamp()}  BG hit at '
                                        '${d.localPosition.dx.toStringAsFixed(0)},'
                                        '${d.localPosition.dy.toStringAsFixed(0)}',
                                      );
                                    }),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE3F2FD),
                                        border: Border.all(
                                          color: const Color(0xFF1565C0),
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.bottomLeft,
                                      padding: const EdgeInsets.all(8),
                                      child: const Text(
                                        'BACKGROUND (opaque)',
                                        style: TextStyle(
                                          color: Color(0xFF0D47A1),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Overlay detector with chosen behavior.
                                Positioned(
                                  left: 60,
                                  top: 30,
                                  right: 60,
                                  bottom: 60,
                                  child: GestureDetector(
                                    behavior: s6Behavior,
                                    onTapDown: (d) => setState(() {
                                      activeOverlayLog.add(
                                        '${stamp()}  OV hit at '
                                        '${d.localPosition.dx.toStringAsFixed(0)},'
                                        '${d.localPosition.dy.toStringAsFixed(0)}',
                                      );
                                    }),
                                    child: Stack(
                                      children: [
                                        // Overlay's painted child - tappable
                                        // even with deferToChild.
                                        Positioned(
                                          left: 12,
                                          top: 12,
                                          child: Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color:
                                                  const Color(0xFFFFB74D),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'child',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (s6Behavior !=
                                            HitTestBehavior.deferToChild)
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: s6Behavior ==
                                                        HitTestBehavior
                                                            .opaque
                                                    ? const Color(0x33E65100)
                                                    : const Color(
                                                        0x336A1B9A,
                                                      ),
                                                border: Border.all(
                                                  color: s6Behavior ==
                                                          HitTestBehavior
                                                              .opaque
                                                      ? const Color(
                                                          0xFFE65100,
                                                        )
                                                      : const Color(
                                                          0xFF6A1B9A,
                                                        ),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              alignment:
                                                  Alignment.bottomRight,
                                              padding:
                                                  const EdgeInsets.all(6),
                                              child: Text(
                                                'OVERLAY (.${s6Behavior.name})',
                                                style: TextStyle(
                                                  color: s6Behavior ==
                                                          HitTestBehavior
                                                              .opaque
                                                      ? const Color(
                                                          0xFFBF360C,
                                                        )
                                                      : const Color(
                                                          0xFF4A148C,
                                                        ),
                                                  fontSize: 11,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          )
                                        else
                                          const Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 6,
                                            child: Center(
                                              child: Text(
                                                'OVERLAY (.deferToChild) - '
                                                'only its child is hittable',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xFF00838F),
                                                  fontStyle:
                                                      FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'OVERLAY log',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    logPanel(
                                      activeOverlayLog,
                                      const Color(0xFFFFF3E0),
                                      const Color(0xFFE65100),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'BACKGROUND log',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    logPanel(
                                      s6BgLog,
                                      const Color(0xFFE3F2FD),
                                      const Color(0xFF0D47A1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => setState(() {
                                s6BgLog.clear();
                                activeOverlayLog.clear();
                              }),
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear both'),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8EAF6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Try this: with .opaque, tap inside the '
                              'overlay - only OVERLAY logs. Switch to '
                              '.translucent and tap the same place - now '
                              'BOTH logs receive the tap. With '
                              '.deferToChild, only the small "child" '
                              'rectangle is hittable; everywhere else the '
                              'background takes the tap.',
                              style: TextStyle(fontSize: 12, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 7 - EMPTY CONTAINER QUIRK
              // ---------------------------------------------------------------
              // A surprising rule: an empty Container with no `color` and no
              // `decoration` participates in NO hit tests. Wrapping with a
              // GestureDetector that uses .deferToChild also won't help -
              // there is no child to hit. The fix is .opaque (or
              // .translucent), or to give the Container a color.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF2E7D32),
                title: '7. Empty Container quirk',
                subtitle:
                    'A bare Container has no paint and is invisible to hit '
                    'testing. Toggle the wrap to see how .opaque fixes it.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  Widget zone() {
                    final inner = Container(
                      width: double.infinity,
                      height: 80,
                      // No color, no decoration: invisible to hit testing.
                      alignment: Alignment.center,
                      child: const Text(
                        'bare Container - try tapping me',
                        style: TextStyle(color: Color(0xFF1B5E20)),
                      ),
                    );

                    if (s7Wrapped) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() {
                          s7Log.add(
                            '${stamp()}  tap caught (wrapped, .opaque)',
                          );
                        }),
                        child: inner,
                      );
                    } else {
                      return GestureDetector(
                        // .deferToChild + no real child paint = no hits.
                        behavior: HitTestBehavior.deferToChild,
                        onTap: () => setState(() {
                          s7Log.add(
                            '${stamp()}  tap caught (this should NOT '
                            'happen)',
                          );
                        }),
                        child: inner,
                      );
                    }
                  }

                  return Card(
                    color: const Color(0xFFE8F5E9),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Wrap with .opaque',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 12),
                              Switch(
                                value: s7Wrapped,
                                onChanged: (v) =>
                                    setState(() => s7Wrapped = v),
                              ),
                              const SizedBox(width: 6),
                              Text(s7Wrapped ? '(opaque)' : '(deferToChild)'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF2E7D32),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: zone(),
                          ),
                          const SizedBox(height: 12),
                          logPanel(
                            s7Log,
                            const Color(0xFFC8E6C9),
                            const Color(0xFF1B5E20),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => setState(s7Log.clear),
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear log'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA5D6A7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Tip: if you ever say "my Container does '
                              'nothing when I tap it", the answer is '
                              'almost always to add a color or wrap it '
                              'with HitTestBehavior.opaque.',
                              style: TextStyle(fontSize: 12, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 8 - REAL-WORLD: EDGE-SWIPE OVER A SCROLL VIEW
              // ---------------------------------------------------------------
              // A common pattern: you want a hit zone on the edge of the
              // screen for a swipe-to-back gesture, but the underlying
              // ListView must still scroll. .translucent gives both.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF455A64),
                title: '8. Real world: edge-swipe over a list',
                subtitle:
                    '.translucent lets the overlay record taps without '
                    'blocking the underlying ListView from scrolling.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 220,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: NotificationListener<
                                      ScrollNotification>(
                                    onNotification: (n) {
                                      if (n is ScrollUpdateNotification &&
                                          !s8ScrollerLog) {
                                        s8ScrollerLog = true;
                                        setState(() {
                                          s8ScrollerEntries.add(
                                            '${stamp()}  list scrolled',
                                          );
                                        });
                                        Future.delayed(
                                          const Duration(milliseconds: 250),
                                          () {
                                            s8ScrollerLog = false;
                                          },
                                        );
                                      }
                                      return false;
                                    },
                                    child: ListView.separated(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: 30,
                                      separatorBuilder: (_, _) =>
                                          const Divider(height: 1),
                                      itemBuilder: (_, i) => ListTile(
                                        dense: true,
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              const Color(0xFF455A64),
                                          child: Text(
                                            '${i + 1}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        title: Text('Item #${i + 1}'),
                                        subtitle: Text(
                                          'list row - scrolling still '
                                          'works through the edge zone',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Edge-swipe zone using .translucent: it
                                // records the tap but does NOT block the
                                // underlying ListView from scrolling.
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  width: 28,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTapDown: (_) => setState(() {
                                      s8EdgeSwipeCount += 1;
                                      s8ScrollerEntries.add(
                                        '${stamp()}  edge zone tapped '
                                        '(#$s8EdgeSwipeCount) - list '
                                        'still scrollable',
                                      );
                                    }),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            const Color(0xFF455A64)
                                                .withOpacity(0.35),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          logPanel(
                            s8ScrollerEntries,
                            const Color(0xFFCFD8DC),
                            const Color(0xFF263238),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () =>
                                  setState(s8ScrollerEntries.clear),
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear log'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 9 - REAL-WORLD: SCREEN BLOCKER OVERLAY
              // ---------------------------------------------------------------
              // The other end of the spectrum: a "blocking" overlay that
              // disables interaction with the page below. .opaque is the
              // correct behavior for a busy/loading scrim, modal background,
              // or "tap outside to dismiss" pattern.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF8E0000),
                title: '9. Real world: blocker / loading scrim',
                subtitle:
                    '.opaque builds a wall: events to the page below are '
                    'cancelled while the overlay is mounted.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Show blocker',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 12),
                              Switch(
                                value: s9Blocking,
                                onChanged: (v) =>
                                    setState(() => s9Blocking = v),
                                activeColor: const Color(0xFF8E0000),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => setState(() {
                                      s9Log.add(
                                        '${stamp()}  PAGE tapped',
                                      );
                                    }),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEBEE),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color(0xFF8E0000),
                                          width: 1,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'PAGE\n(tap me - works only when '
                                        'blocker is off)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF8E0000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (s9Blocking)
                                  Positioned.fill(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => setState(() {
                                        s9Log.add(
                                          '${stamp()}  BLOCKER caught '
                                          'tap (page did NOT see it)',
                                        );
                                      }),
                                      child: Container(
                                        color: Colors.black54,
                                        alignment: Alignment.center,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              'Blocking overlay '
                                              '(.opaque)',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          logPanel(
                            s9Log,
                            const Color(0xFFFFCDD2),
                            const Color(0xFF8E0000),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => setState(s9Log.clear),
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear log'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFCDD2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'The blocker uses .opaque so any tap is '
                              'absorbed before reaching the page. If you '
                              "swap it for .translucent, you'd see BOTH "
                              'logs fire at once - useful for analytics '
                              'taps, dangerous for "are you sure?" dialogs.',
                              style: TextStyle(fontSize: 12, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 10 - CUSTOM RenderBox.hitTestSelf NOTE
              // ---------------------------------------------------------------
              // The enum exists because the underlying RenderBox method
              // hitTestSelf returns true/false. HitTestBehavior is a
              // user-friendly switch over that primitive. This section is
              // annotation-only (no widget) for advanced readers.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF4527A0),
                title: '10. Under the hood: hitTestSelf',
                subtitle:
                    'For the curious - what HitTestBehavior maps to in the '
                    'rendering layer.',
              ),
              const SizedBox(height: 12),
              Card(
                color: const Color(0xFFEDE7F6),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RenderProxyBoxWithHitTestBehavior is the base '
                        'class behind GestureDetector and Listener. Its '
                        'hitTest method is roughly:',
                        style: TextStyle(fontSize: 13, height: 1.45),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF311B92),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'bool hitTest(BoxHitTestResult result, '
                          '{required Offset position}) {\n'
                          '  bool hitTarget = false;\n'
                          '  if (size.contains(position)) {\n'
                          '    hitTarget = hitTestChildren(result, '
                          'position: position) || hitTestSelf(position);\n'
                          '    if (hitTarget || behavior == HitTestBehavior.'
                          'translucent) {\n'
                          '      result.add(BoxHitTestEntry(this, position));\n'
                          '    }\n'
                          '  }\n'
                          '  return hitTarget;\n'
                          '}\n\n'
                          'bool hitTestSelf(Offset position) =>\n'
                          '    behavior == HitTestBehavior.opaque;',
                          style: TextStyle(
                            color: Color(0xFFD1C4E9),
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Reading that:\n'
                        '  - .opaque  -> hitTestSelf returns true, so the '
                        'box is always a hit target inside its bounds and '
                        'the walk stops here.\n'
                        '  - .deferToChild -> hitTestSelf returns false, so '
                        'the box is only a hit target if a child reported a '
                        'hit (the || is short-circuited by the child).\n'
                        '  - .translucent -> hitTestSelf returns false too '
                        'BUT the explicit translucent branch still adds '
                        'the box to the result, so we participate without '
                        'consuming.',
                        style: TextStyle(fontSize: 13, height: 1.45),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 11 - DECISION GUIDE
              // ---------------------------------------------------------------
              // Practical "which one should I pick" card. Lists common
              // scenarios and the right choice for each, plus the most
              // frequent mistakes seen in code review.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF00695C),
                title: '11. Decision guide',
                subtitle:
                    'Pick the behavior that matches your intent, not the '
                    'one that "happens to work".',
              ),
              const SizedBox(height: 12),
              Card(
                color: const Color(0xFFE0F2F1),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _DecisionRow(
                        scenario: 'Wrapping an icon button so only the icon '
                            'itself responds',
                        choice: '.deferToChild',
                        reason: 'The user expects to tap the visible icon, '
                            'not the empty padding around it.',
                      ),
                      Divider(),
                      _DecisionRow(
                        scenario: 'Modal scrim, loading overlay, tap-out-to-'
                            'dismiss background',
                        choice: '.opaque',
                        reason: 'You want to absolutely block events from '
                            'reaching the page beneath.',
                      ),
                      Divider(),
                      _DecisionRow(
                        scenario: 'Edge-swipe / drag handle on top of a '
                            'scrolling list',
                        choice: '.translucent',
                        reason: 'You need to record gestures yourself but '
                            'not interfere with the underlying scrollable.',
                      ),
                      Divider(),
                      _DecisionRow(
                        scenario: 'Whole-card click target where the card '
                            'has empty padding',
                        choice: '.opaque',
                        reason: 'The default deferToChild would ignore taps '
                            'on the padding.',
                      ),
                      Divider(),
                      _DecisionRow(
                        scenario: 'Visualisation overlay that should not '
                            'steal taps from a chart below',
                        choice: '.translucent',
                        reason: 'Track pointer movements while letting the '
                            'chart still receive selection events.',
                      ),
                      Divider(),
                      _DecisionRow(
                        scenario: 'Animated decoration drawn on top of '
                            'normal content',
                        choice: '.deferToChild (or IgnorePointer)',
                        reason: 'Decoration should never receive events. '
                            'IgnorePointer is even cleaner: it removes the '
                            'subtree from hit testing entirely.',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 12 - COMMON MISTAKES
              // ---------------------------------------------------------------
              // Failure modes that are surprisingly hard to debug if you do
              // not know about HitTestBehavior. Each entry is keyed by the
              // SYMPTOM the developer sees, not the root cause.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFFAD1457),
                title: '12. Common mistakes',
                subtitle:
                    'Symptom-first checklist for debugging "my tap does '
                    'nothing" bugs.',
              ),
              const SizedBox(height: 12),
              Card(
                color: const Color(0xFFFCE4EC),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _MistakeRow(
                        symptom: 'My GestureDetector wraps an empty SizedBox '
                            'and nothing happens.',
                        cause: 'Default .deferToChild has no child paint to '
                            'defer to.',
                        fix: 'Use behavior: HitTestBehavior.opaque, or give '
                            'the child a color so it has hit-test bounds.',
                      ),
                      Divider(),
                      _MistakeRow(
                        symptom: 'My loading scrim lets the user double-'
                            'submit a form.',
                        cause: '.translucent (or no detector at all) does '
                            'not block events.',
                        fix: 'Use .opaque on the scrim, or wrap the form '
                            'with AbsorbPointer/IgnorePointer.',
                      ),
                      Divider(),
                      _MistakeRow(
                        symptom: 'My swipe handle works, but the list below '
                            'no longer scrolls.',
                        cause: '.opaque on the handle is consuming all '
                            'pointer events.',
                        fix: 'Switch to .translucent so the list still '
                            'sees the drag.',
                      ),
                      Divider(),
                      _MistakeRow(
                        symptom: 'My onTap fires on the parent but also on '
                            'a sibling I did not expect.',
                        cause: '.translucent lets the event continue.',
                        fix: 'Use .opaque if only the topmost detector '
                            'should fire.',
                      ),
                      Divider(),
                      _MistakeRow(
                        symptom: 'IgnorePointer fixed it but now I cannot '
                            'tap children either.',
                        cause: 'IgnorePointer removes the entire subtree '
                            'from hit testing.',
                        fix: 'Use HitTestBehavior on individual detectors '
                            'instead, or AbsorbPointer for "consume but '
                            'do not let through".',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 13 - REFERENCE TABLE
              // ---------------------------------------------------------------
              // Compact, glanceable summary of the three values: hit-target
              // bounds, propagation, default contexts.
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF263238),
                title: '13. Reference table',
                subtitle: 'All three values at a glance.',
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.1),
                      1: FlexColumnWidth(1.4),
                      2: FlexColumnWidth(1.4),
                      3: FlexColumnWidth(1.6),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey.shade300),
                    ),
                    children: const [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xFF263238),
                        ),
                        children: [
                          _Th('Value'),
                          _Th('Hit area'),
                          _Th('Propagation'),
                          _Th('Typical use'),
                        ],
                      ),
                      TableRow(
                        children: [
                          _Td('.deferToChild'),
                          _Td('Wherever a child reports a hit'),
                          _Td('No propagation past the child'),
                          _Td('Default for GestureDetector with a '
                              'visible child'),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                        ),
                        children: [
                          _Td('.opaque'),
                          _Td('Entire bounds'),
                          _Td('Stops at this box'),
                          _Td('Modal scrims, full-card buttons, blockers'),
                        ],
                      ),
                      TableRow(
                        children: [
                          _Td('.translucent'),
                          _Td('Entire bounds'),
                          _Td('Continues to siblings BELOW in the stack'),
                          _Td('Edge swipe, analytics overlays, debug huds'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 14 - RELATED WIDGETS
              // ---------------------------------------------------------------
              // HitTestBehavior is one of three "block / let through" tools.
              // The others, IgnorePointer and AbsorbPointer, are different
              // axes of the same problem: should the subtree appear in
              // hit-test results at all?
              // ===============================================================
              _SectionHeader(
                accent: const Color(0xFF424242),
                title: '14. Related: IgnorePointer & AbsorbPointer',
                subtitle:
                    'When HitTestBehavior is the wrong knob, one of these '
                    'is usually the right one.',
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'IgnorePointer(child: ...)',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Removes the entire subtree from hit testing. '
                        'Pointer events flow THROUGH the subtree as if it '
                        "weren't there. Use for purely decorative "
                        'overlays.',
                        style: TextStyle(fontSize: 13, height: 1.45),
                      ),
                      Divider(height: 24),
                      Text(
                        'AbsorbPointer(child: ...)',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'The subtree appears in hit testing AND consumes '
                        'every event, but its own descendants do NOT '
                        'receive events. Equivalent to wrapping with a '
                        '.opaque GestureDetector that does nothing.',
                        style: TextStyle(fontSize: 13, height: 1.45),
                      ),
                      Divider(height: 24),
                      Text(
                        'HitTestBehavior',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Operates at the Listener / GestureDetector level. '
                        'It controls whether THIS detector reports a hit '
                        'and whether siblings BELOW it can also hit. '
                        'Children of the detector are unaffected.',
                        style: TextStyle(fontSize: 13, height: 1.45),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===============================================================
              // SECTION 15 - WRAP UP / CHEAT-SHEET
              // ---------------------------------------------------------------
              // A small footer card with the one-line takeaway for each
              // value, intended to be the last thing on the page.
              // ===============================================================
              Card(
                color: const Color(0xFF1A237E),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'One-line cheat sheet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '.deferToChild = "I am only here for my child."',
                        style: TextStyle(color: Colors.white, height: 1.5),
                      ),
                      Text(
                        '.opaque       = "I take this tap and nothing '
                        'else gets it."',
                        style: TextStyle(color: Colors.white, height: 1.5),
                      ),
                      Text(
                        '.translucent  = "I take this tap AND let it '
                        'continue."',
                        style: TextStyle(color: Colors.white, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero card helper - one row per enum value with a colored token chip.
// ---------------------------------------------------------------------------
Widget _heroValueRow({
  required String token,
  required String title,
  required String body,
  required Color accent,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.18),
          border: Border.all(color: accent),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          token,
          style: TextStyle(
            color: accent,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              body,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section header used between cards.
// ---------------------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 44,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF455A64),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// One column of the three-way comparison in section 2.
// ---------------------------------------------------------------------------
class _BehaviorColumn extends StatelessWidget {
  const _BehaviorColumn({
    required this.title,
    required this.background,
    required this.accent,
    required this.detector,
    required this.log,
    required this.onClear,
  });

  final String title;
  final Color background;
  final Color accent;
  final Widget detector;
  final List<String> log;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              color: accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(height: 110, child: detector),
          const SizedBox(height: 6),
          Container(
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 110),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: accent.withOpacity(0.3)),
            ),
            child: log.isEmpty
                ? Text(
                    '(no taps)',
                    style: TextStyle(
                      fontSize: 10,
                      color: accent.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    reverse: true,
                    children: [
                      for (final l in log.reversed)
                        Text(
                          l,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: accent,
                          ),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 24),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: onClear,
              child: Text(
                'clear',
                style: TextStyle(fontSize: 11, color: accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// The transparent-bounds box used inside a detector. The small painted child
// is the only thing visible, and is itself tappable; the surrounding area
// is invisible until the parent detector decides to be opaque/translucent.
// ---------------------------------------------------------------------------
class _DetectorBox extends StatelessWidget {
  const _DetectorBox({
    required this.hint,
    required this.accent,
    required this.onChildTap,
  });

  final String hint;
  final Color accent;
  final VoidCallback onChildTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: accent,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 6,
            top: 6,
            child: Text(
              hint,
              style: TextStyle(
                fontSize: 10,
                color: accent.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: onChildTap,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.adjust,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Decision card row.
// ---------------------------------------------------------------------------
class _DecisionRow extends StatelessWidget {
  const _DecisionRow({
    required this.scenario,
    required this.choice,
    required this.reason,
  });

  final String scenario;
  final String choice;
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              scenario,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF00695C).withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF00695C)),
              ),
              child: Text(
                choice,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF00695C),
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              reason,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mistake card row.
// ---------------------------------------------------------------------------
class _MistakeRow extends StatelessWidget {
  const _MistakeRow({
    required this.symptom,
    required this.cause,
    required this.fix,
  });

  final String symptom;
  final String cause;
  final String fix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Symptom: $symptom',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFFAD1457),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Cause: $cause',
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 2),
          Text(
            'Fix: $fix',
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Color(0xFF1B5E20),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tiny table-cell helpers for section 13.
// ---------------------------------------------------------------------------
class _Th extends StatelessWidget {
  const _Th(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Td extends StatelessWidget {
  const _Td(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, height: 1.4),
      ),
    );
  }
}
