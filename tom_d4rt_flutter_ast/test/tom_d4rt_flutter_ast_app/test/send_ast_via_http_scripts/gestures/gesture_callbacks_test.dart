// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt deep-demo: Gesture Callback Atlas
// A hand-authored visual field guide to the GestureDetector callback family.
// Covers the full tap chain, double-tap, long-press chain, vertical / horizontal
// drag chains, pan chain, and the anatomy of every *Details record used by the
// callbacks. All callback bodies are no-ops -- the page is a static
// illustration of the gesture lifecycle, suitable for analyzer-free D4rt.

import 'package:flutter/material.dart';

// ============================================================================
// PALETTE CONSTANTS
// ----------------------------------------------------------------------------
// Each section in the atlas owns a distinct accent palette. Holding them as
// top-level constants keeps the gradients consistent and the section helpers
// short.
// ============================================================================

const Color _kInkDeep = Color(0xFF101422);
const Color _kInkMid = Color(0xFF1B2238);
const Color _kInkSoft = Color(0xFF252D49);
const Color _kPaperWarm = Color(0xFFFCF6EC);
const Color _kPaperCool = Color(0xFFEAF2FA);
const Color _kAccentTap = Color(0xFFFF6B6B);
const Color _kAccentTapAlt = Color(0xFFFFA07A);
const Color _kAccentDouble = Color(0xFFFFB142);
const Color _kAccentDoubleAlt = Color(0xFFFFD56A);
const Color _kAccentLong = Color(0xFF8E44AD);
const Color _kAccentLongAlt = Color(0xFFB47BD9);
const Color _kAccentVDrag = Color(0xFF1ABC9C);
const Color _kAccentVDragAlt = Color(0xFF7FE3CE);
const Color _kAccentHDrag = Color(0xFF3498DB);
const Color _kAccentHDragAlt = Color(0xFF85C5EE);
const Color _kAccentPan = Color(0xFFE74C3C);
const Color _kAccentPanAlt = Color(0xFFFF8B7A);
const Color _kAccentDetails = Color(0xFF34495E);
const Color _kAccentDetailsAlt = Color(0xFF7B8FA2);
const Color _kAccentKind = Color(0xFF2ECC71);
const Color _kAccentKindAlt = Color(0xFF8DECB6);
const Color _kAccentRecipe = Color(0xFFE67E22);
const Color _kAccentRecipeAlt = Color(0xFFFFB680);
const Color _kAccentGloss = Color(0xFF16A085);
const Color _kAccentGlossAlt = Color(0xFF74D7BD);

// ============================================================================
// BUILD ENTRY
// ============================================================================

dynamic build(BuildContext context) {
  print('Gesture Callback Atlas: build() entered.');

  // --------------------------------------------------------------------------
  // SECTION 0: NO-OP CALLBACK FAMILY (TYPE-CHECK + SHAPE-CHECK)
  // --------------------------------------------------------------------------
  // Every callback in the GestureDetector surface gets a no-op stub. The stubs
  // are wired into a real GestureDetector below so the analyzer confirms each
  // signature is correct -- without ever firing a real gesture event.

  void onTapNoop() {}
  void onTapDownNoop(TapDownDetails d) {}
  void onTapUpNoop(TapUpDetails d) {}
  void onTapCancelNoop() {}
  void onSecondaryTapNoop() {}
  void onSecondaryTapDownNoop(TapDownDetails d) {}
  void onSecondaryTapUpNoop(TapUpDetails d) {}
  void onSecondaryTapCancelNoop() {}
  void onDoubleTapNoop() {}
  void onDoubleTapDownNoop(TapDownDetails d) {}
  void onDoubleTapCancelNoop() {}
  void onLongPressNoop() {}
  void onLongPressStartNoop(LongPressStartDetails d) {}
  void onLongPressMoveUpdateNoop(LongPressMoveUpdateDetails d) {}
  void onLongPressUpNoop() {}
  void onLongPressEndNoop(LongPressEndDetails d) {}
  void onVerticalDragDownNoop(DragDownDetails d) {}
  void onVerticalDragStartNoop(DragStartDetails d) {}
  void onVerticalDragUpdateNoop(DragUpdateDetails d) {}
  void onVerticalDragEndNoop(DragEndDetails d) {}
  void onVerticalDragCancelNoop() {}
  void onHorizontalDragDownNoop(DragDownDetails d) {}
  void onHorizontalDragStartNoop(DragStartDetails d) {}
  void onHorizontalDragUpdateNoop(DragUpdateDetails d) {}
  void onHorizontalDragEndNoop(DragEndDetails d) {}
  void onHorizontalDragCancelNoop() {}
  void onPanDownNoop(DragDownDetails d) {}
  void onPanStartNoop(DragStartDetails d) {}
  void onPanUpdateNoop(DragUpdateDetails d) {}
  void onPanEndNoop(DragEndDetails d) {}
  void onPanCancelNoop() {}

  // A "kitchen sink" detector to prove every callback name compiles. Pan and
  // scale cannot coexist on the same detector; we keep panel widgets in their
  // own sections.
  final Widget sinkDetectorTap = GestureDetector(
    onTap: onTapNoop,
    onTapDown: onTapDownNoop,
    onTapUp: onTapUpNoop,
    onTapCancel: onTapCancelNoop,
    onSecondaryTap: onSecondaryTapNoop,
    onSecondaryTapDown: onSecondaryTapDownNoop,
    onSecondaryTapUp: onSecondaryTapUpNoop,
    onSecondaryTapCancel: onSecondaryTapCancelNoop,
    onDoubleTap: onDoubleTapNoop,
    onDoubleTapDown: onDoubleTapDownNoop,
    onDoubleTapCancel: onDoubleTapCancelNoop,
    onLongPress: onLongPressNoop,
    onLongPressStart: onLongPressStartNoop,
    onLongPressMoveUpdate: onLongPressMoveUpdateNoop,
    onLongPressUp: onLongPressUpNoop,
    onLongPressEnd: onLongPressEndNoop,
    child: const SizedBox.shrink(),
  );

  final Widget sinkDetectorVDrag = GestureDetector(
    onVerticalDragDown: onVerticalDragDownNoop,
    onVerticalDragStart: onVerticalDragStartNoop,
    onVerticalDragUpdate: onVerticalDragUpdateNoop,
    onVerticalDragEnd: onVerticalDragEndNoop,
    onVerticalDragCancel: onVerticalDragCancelNoop,
    child: const SizedBox.shrink(),
  );

  final Widget sinkDetectorHDrag = GestureDetector(
    onHorizontalDragDown: onHorizontalDragDownNoop,
    onHorizontalDragStart: onHorizontalDragStartNoop,
    onHorizontalDragUpdate: onHorizontalDragUpdateNoop,
    onHorizontalDragEnd: onHorizontalDragEndNoop,
    onHorizontalDragCancel: onHorizontalDragCancelNoop,
    child: const SizedBox.shrink(),
  );

  final Widget sinkDetectorPan = GestureDetector(
    onPanDown: onPanDownNoop,
    onPanStart: onPanStartNoop,
    onPanUpdate: onPanUpdateNoop,
    onPanEnd: onPanEndNoop,
    onPanCancel: onPanCancelNoop,
    child: const SizedBox.shrink(),
  );

  print('Gesture Callback Atlas: kitchen-sink detectors instantiated.');
  print('  tap detector hash    : ${sinkDetectorTap.hashCode}');
  print('  vDrag detector hash  : ${sinkDetectorVDrag.hashCode}');
  print('  hDrag detector hash  : ${sinkDetectorHDrag.hashCode}');
  print('  pan detector hash    : ${sinkDetectorPan.hashCode}');

  // --------------------------------------------------------------------------
  // Build the visual atlas. Everything below is pure layout -- no state, no
  // animation controllers, no async. Each section is a top-level helper.
  // --------------------------------------------------------------------------

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Gesture Callback Atlas',
    theme: ThemeData(
      primaryColor: _kInkDeep,
      scaffoldBackgroundColor: _kPaperWarm,
      fontFamily: 'sans-serif',
    ),
    home: Scaffold(
      backgroundColor: _kPaperWarm,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _heroHeader(),
            _conceptOverview(),
            _sectionTapBasics(),
            _sectionTapChain(),
            _sectionDoubleTap(),
            _sectionLongPress(),
            _sectionVerticalDrag(),
            _sectionHorizontalDrag(),
            _sectionPan(),
            _sectionDragDetailsAnatomy(),
            _sectionPointerDeviceKind(),
            _sectionRecipeCards(),
            _sectionComparisonTable(),
            _sectionGlossary(),
            _epilogue(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO HEADER
// ============================================================================

Widget _heroHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 56.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kInkDeep, _kInkMid, _kInkSoft],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _kAccentTap.withOpacity(0.18),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: _kAccentTap.withOpacity(0.6)),
          ),
          child: const Text(
            'D4RT  •  GESTURE FIELD GUIDE  •  v1',
            style: TextStyle(
              color: _kAccentTapAlt,
              fontSize: 11.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          'Gesture Callback Atlas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 44.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A pointer-lifecycle field guide for taps, drags, and long-presses.',
          style: TextStyle(
            color: Color(0xFFB7C0DA),
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 28.0),
        Row(
          children: <Widget>[
            _heroChip('30+ callbacks'),
            const SizedBox(width: 10.0),
            _heroChip('6 lifecycles'),
            const SizedBox(width: 10.0),
            _heroChip('4 details records'),
            const SizedBox(width: 10.0),
            _heroChip('analyzer-free'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.white.withOpacity(0.18)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ============================================================================
// CONCEPT OVERVIEW
// ============================================================================

Widget _conceptOverview() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
    color: _kPaperWarm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _kicker('THE BIG PICTURE', _kAccentTap),
        const SizedBox(height: 8.0),
        const Text(
          'Three lifecycles, one pointer',
          style: TextStyle(
            color: _kInkDeep,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A GestureDetector observes pointer streams and folds them into '
          'three lifecycles: discrete (tap/double-tap), held (long-press), '
          'and continuous (drag/pan). Each lifecycle ends in either a '
          'success callback or a cancel callback. The atlas walks them in order.',
          style: TextStyle(
            color: _kInkMid,
            fontSize: 16.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 28.0),
        Row(
          children: <Widget>[
            Expanded(child: _overviewPill('Discrete', 'onTap', _kAccentTap)),
            const SizedBox(width: 12.0),
            Expanded(child: _overviewPill('Held', 'onLongPress', _kAccentLong)),
            const SizedBox(width: 12.0),
            Expanded(child: _overviewPill('Continuous', 'onPanUpdate', _kAccentPan)),
          ],
        ),
      ],
    ),
  );
}

Widget _overviewPill(String title, String callback, Color accent) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withOpacity(0.4), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.12),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          callback,
          style: const TextStyle(
            color: _kInkDeep,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SHARED HELPERS: SECTION BANNERS, KICKERS, RECIPE CARDS
// ============================================================================

Widget _sectionBanner(
  int number,
  String title,
  String subtitle,
  Color accent,
  Color accentAlt,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 36.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[accent, accentAlt],
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 2.0),
          ),
          alignment: Alignment.center,
          child: Text(
            number.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'SECTION $number',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 11.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
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

Widget _kicker(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10.5,
        letterSpacing: 1.8,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget _bodyText(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInkMid,
        fontSize: 15.0,
        height: 1.55,
      ),
    ),
  );
}

Widget _codeBlock(String code, Color accent) {
  return Container(
    margin: const EdgeInsets.only(top: 16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kInkDeep,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
    ),
    width: double.infinity,
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFE4ECF7),
        fontSize: 13.0,
        height: 1.55,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _calloutRow(IconData icon, String text, Color accent) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 18.0, color: accent),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _kInkMid,
              fontSize: 14.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Timeline bar: a horizontal track of named pointer-lifecycle events.
// Each event is rendered as a colored chip; consecutive chips are joined by
// arrow stems to suggest the temporal flow.
// ----------------------------------------------------------------------------

Widget _timeline(List<String> events, Color accent, {String? cancelBranch}) {
  final List<Widget> nodes = <Widget>[];
  for (int i = 0; i < events.length; i++) {
    nodes.add(_timelineNode(events[i], accent, i));
    if (i < events.length - 1) {
      nodes.add(_timelineArrow(accent));
    }
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: nodes,
        ),
      ),
      if (cancelBranch != null) ...<Widget>[
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            const SizedBox(width: 24.0),
            Container(
              width: 2.0,
              height: 24.0,
              color: Colors.redAccent.withOpacity(0.6),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
              ),
              child: Text(
                'cancel branch  →  $cancelBranch',
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ],
    ],
  );
}

Widget _timelineNode(String label, Color accent, int idx) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'STEP ${idx + 1}',
          style: TextStyle(
            color: accent,
            fontSize: 9.0,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3.0),
        Text(
          label,
          style: const TextStyle(
            color: _kInkDeep,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _timelineArrow(Color accent) {
  return Container(
    width: 30.0,
    height: 2.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.55),
      borderRadius: BorderRadius.circular(1.0),
    ),
  );
}

// ----------------------------------------------------------------------------
// Hit zone card: a faux interactive surface annotated with the lifecycle name.
// Uses AlwaysStoppedAnimation<double> snapshots to render dotted highlight
// rings without a controller.
// ----------------------------------------------------------------------------

Widget _hitZone(String label, Color accent, IconData icon) {
  // Snapshot animation value (no controller; static frame).
  final AlwaysStoppedAnimation<double> glow = const AlwaysStoppedAnimation<double>(0.7);
  return Container(
    height: 140.0,
    decoration: BoxDecoration(
      color: accent.withOpacity(0.08),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: accent.withOpacity(glow.value),
        width: 2.0,
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 36.0, color: accent),
        const SizedBox(height: 10.0),
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Recipe card: a labeled scenario with a primary callback and a short story.
// ----------------------------------------------------------------------------

Widget _recipeCard(
  String title,
  String callbacks,
  String story,
  Color accent,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.only(bottom: 14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withOpacity(0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.10),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: accent.withOpacity(0.14),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: accent, size: 24.0),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _kInkDeep,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                callbacks,
                style: TextStyle(
                  color: accent,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                story,
                style: const TextStyle(
                  color: _kInkMid,
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1: GESTUREDETECTOR BASICS
// ============================================================================

Widget _sectionTapBasics() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        1,
        'GestureDetector basics',
        'A widget without paint, only listeners — wrap a child to hear the pointer.',
        _kAccentTap,
        _kAccentTapAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperWarm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('WHAT IT IS', _kAccentTap),
            _bodyText(
              'GestureDetector is a non-rendering widget. It sits in the tree '
              'as a transparent intercept, forwards low-level PointerEvents to '
              'GestureArenas, and surfaces them as semantic callbacks like '
              'onTap. If you do not assign a callback, that gesture is simply '
              'ignored.',
            ),
            _codeBlock(
              'GestureDetector(\n'
              '  onTap: () { /* primary discrete tap */ },\n'
              '  onTapDown: (TapDownDetails d) { /* finger touched */ },\n'
              '  onTapUp: (TapUpDetails d) { /* finger lifted, win */ },\n'
              '  onTapCancel: () { /* arena lost, no tap */ },\n'
              '  child: ...,\n'
              ')',
              _kAccentTap,
            ),
            const SizedBox(height: 24.0),
            _kicker('HIT ZONES', _kAccentTap),
            const SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Expanded(child: _hitZone('TAP', _kAccentTap, Icons.touch_app)),
                const SizedBox(width: 12.0),
                Expanded(child: _hitZone('LONG-PRESS', _kAccentLong, Icons.timelapse)),
                const SizedBox(width: 12.0),
                Expanded(child: _hitZone('DRAG', _kAccentVDrag, Icons.swap_horiz)),
              ],
            ),
            const SizedBox(height: 20.0),
            _calloutRow(
              Icons.info_outline,
              'A GestureDetector reports zero size when its child is null. '
              'Always wrap a paintable child or it cannot be hit.',
              _kAccentTap,
            ),
            _calloutRow(
              Icons.bolt_outlined,
              'Behavior is determined by HitTestBehavior; default opaque means '
              'the detector consumes hits within its bounds.',
              _kAccentTap,
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 2: FULL TAP CHAIN
// ============================================================================

Widget _sectionTapChain() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        2,
        'The full tap chain',
        'onTapDown → onTapUp → onTap, with onTapCancel as the failure branch.',
        _kAccentTapAlt,
        _kAccentTap,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperWarm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('LIFECYCLE', _kAccentTap),
            _bodyText(
              'A "tap" is not a single moment; it is a contract between the '
              'finger touching the screen, the gesture arena, and the lift. '
              'The success arc fires three callbacks. A scroll or sibling '
              'recognizer winning the arena triggers onTapCancel instead.',
            ),
            const SizedBox(height: 18.0),
            _timeline(
              const <String>['onTapDown', 'onTapUp', 'onTap'],
              _kAccentTap,
              cancelBranch: 'onTapCancel',
            ),
            const SizedBox(height: 24.0),
            _codeBlock(
              '// onTapDown fires once a candidate pointer arrives.\n'
              'onTapDown: (TapDownDetails d) {\n'
              '  // d.globalPosition, d.localPosition, d.kind\n'
              '}\n\n'
              '// onTapUp fires when the pointer lifts AND the arena was won.\n'
              'onTapUp: (TapUpDetails d) {\n'
              '  // d.globalPosition, d.localPosition, d.kind\n'
              '}\n\n'
              '// onTap is the "done" callback. Fires after onTapUp.\n'
              'onTap: () { /* commit the action */ }\n\n'
              '// onTapCancel replaces onTapUp/onTap when arena is lost.\n'
              'onTapCancel: () { /* unhighlight, abort */ }',
              _kAccentTap,
            ),
            const SizedBox(height: 24.0),
            _kicker('SECONDARY TAP', _kAccentTapAlt),
            _bodyText(
              'GestureDetector mirrors the primary chain with an entire '
              'secondary chain for right-clicks and equivalents: '
              'onSecondaryTapDown, onSecondaryTapUp, onSecondaryTap, '
              'onSecondaryTapCancel. Same shape, different button.',
            ),
            const SizedBox(height: 18.0),
            _timeline(
              const <String>[
                'onSecondaryTapDown',
                'onSecondaryTapUp',
                'onSecondaryTap',
              ],
              _kAccentTapAlt,
              cancelBranch: 'onSecondaryTapCancel',
            ),
            const SizedBox(height: 24.0),
            _calloutRow(
              Icons.warning_amber_outlined,
              'Never put visual feedback in onTap alone — by the time it fires, '
              'the touch is already over. Use onTapDown for press-state.',
              _kAccentTap,
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 3: DOUBLE TAP
// ============================================================================

Widget _sectionDoubleTap() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        3,
        'Double tap',
        'Two taps within kDoubleTapTimeout — a tiny FSM with its own cancel branch.',
        _kAccentDouble,
        _kAccentDoubleAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperWarm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('LIFECYCLE', _kAccentDouble),
            _bodyText(
              'A double-tap is two single-tap candidates seen within a small '
              'temporal window. onDoubleTapDown fires when the second tap '
              'begins; onDoubleTap fires when it succeeds; onDoubleTapCancel '
              'fires when the second tap loses the arena.',
            ),
            const SizedBox(height: 18.0),
            _timeline(
              const <String>['onDoubleTapDown', 'onDoubleTap'],
              _kAccentDouble,
              cancelBranch: 'onDoubleTapCancel',
            ),
            const SizedBox(height: 24.0),
            _codeBlock(
              'onDoubleTapDown: (TapDownDetails d) {\n'
              '  // second tap candidate has landed\n'
              '}\n\n'
              'onDoubleTap: () {\n'
              '  // success: zoom toggle, like-photo, etc.\n'
              '}\n\n'
              'onDoubleTapCancel: () {\n'
              '  // second tap did not resolve into a double-tap\n'
              '}',
              _kAccentDouble,
            ),
            const SizedBox(height: 24.0),
            _kicker('STATE DIAGRAM', _kAccentDoubleAlt),
            const SizedBox(height: 12.0),
            _doubleTapStateDiagram(),
          ],
        ),
      ),
    ],
  );
}

Widget _doubleTapStateDiagram() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _kAccentDouble.withOpacity(0.05),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kAccentDouble.withOpacity(0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _stateNode('IDLE', 'no pointer in flight', _kAccentDoubleAlt),
        _stateArrowDown('first pointer down'),
        _stateNode('TAP_1', 'awaiting first lift', _kAccentDouble),
        _stateArrowDown('first pointer up + arena win'),
        _stateNode('GAP', 'within kDoubleTapTimeout', _kAccentDouble),
        _stateArrowDown('second pointer down'),
        _stateNode('TAP_2', 'onDoubleTapDown fires', _kAccentDouble),
        _stateArrowDown('second pointer up'),
        _stateNode('DONE', 'onDoubleTap fires', _kAccentDoubleAlt),
      ],
    ),
  );
}

Widget _stateNode(String name, String hint, Color accent) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.6), width: 1.5),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12.0),
        Text(
          name,
          style: const TextStyle(
            color: _kInkDeep,
            fontSize: 14.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Text(
            hint,
            style: const TextStyle(
              color: _kInkMid,
              fontSize: 13.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _stateArrowDown(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 2.0,
          height: 26.0,
          color: _kAccentDouble.withOpacity(0.6),
        ),
        const SizedBox(width: 8.0),
        Icon(Icons.arrow_downward, size: 16.0, color: _kAccentDouble),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: _kInkMid,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4: LONG PRESS
// ============================================================================

Widget _sectionLongPress() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        4,
        'Long press chain',
        'Hold past kLongPressTimeout, then live-track movement and the lift.',
        _kAccentLong,
        _kAccentLongAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperCool,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('LIFECYCLE', _kAccentLong),
            _bodyText(
              'A long-press is a tap that did not lift in time. Once the timer '
              'fires, the gesture is held: the user can drag (move-update) and '
              'eventually release (up + end). The chain is the most ornate in '
              'the GestureDetector surface.',
            ),
            const SizedBox(height: 18.0),
            _timeline(
              const <String>[
                'onLongPressStart',
                'onLongPress',
                'onLongPressMoveUpdate',
                'onLongPressUp',
                'onLongPressEnd',
              ],
              _kAccentLong,
            ),
            const SizedBox(height: 24.0),
            _codeBlock(
              'onLongPressStart: (LongPressStartDetails d) {\n'
              '  // d.globalPosition, d.localPosition\n'
              '}\n\n'
              'onLongPress: () {\n'
              '  // canonical "long pressed" moment\n'
              '}\n\n'
              'onLongPressMoveUpdate: (LongPressMoveUpdateDetails d) {\n'
              '  // d.offsetFromOrigin, d.localOffsetFromOrigin\n'
              '}\n\n'
              'onLongPressUp: () {\n'
              '  // finger lifted\n'
              '}\n\n'
              'onLongPressEnd: (LongPressEndDetails d) {\n'
              '  // d.velocity (rare but populated on swipe-release)\n'
              '}',
              _kAccentLong,
            ),
            const SizedBox(height: 24.0),
            _kicker('DETAILS RECORDS', _kAccentLongAlt),
            const SizedBox(height: 12.0),
            _detailsCard(
              'LongPressStartDetails',
              <List<String>>[
                <String>['globalPosition', 'Offset', 'Press in screen coords'],
                <String>['localPosition', 'Offset', 'Press in detector coords'],
              ],
              _kAccentLong,
            ),
            const SizedBox(height: 12.0),
            _detailsCard(
              'LongPressMoveUpdateDetails',
              <List<String>>[
                <String>['globalPosition', 'Offset', 'Current pointer position'],
                <String>['localPosition', 'Offset', 'In detector coords'],
                <String>['offsetFromOrigin', 'Offset', 'Delta from press start'],
                <String>['localOffsetFromOrigin', 'Offset', 'Local delta'],
              ],
              _kAccentLong,
            ),
            const SizedBox(height: 12.0),
            _detailsCard(
              'LongPressEndDetails',
              <List<String>>[
                <String>['globalPosition', 'Offset', 'Lift position'],
                <String>['localPosition', 'Offset', 'Lift in detector coords'],
                <String>['velocity', 'Velocity', 'Almost always Velocity.zero'],
              ],
              _kAccentLong,
            ),
          ],
        ),
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Details anatomy card: a small table mapping fields → type → meaning.
// ----------------------------------------------------------------------------

Widget _detailsCard(String name, List<List<String>> rows, Color accent) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.12),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              color: accent,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Column(
          children: rows
              .map((List<String> r) => _detailsRow(r[0], r[1], r[2], accent))
              .toList(),
        ),
      ],
    ),
  );
}

Widget _detailsRow(String field, String type, String meaning, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFEAEDF2))),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            field,
            style: const TextStyle(
              color: _kInkDeep,
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Text(
            type,
            style: TextStyle(
              color: accent,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            meaning,
            style: const TextStyle(
              color: _kInkMid,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5: VERTICAL DRAG
// ============================================================================

Widget _sectionVerticalDrag() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        5,
        'Vertical drag chain',
        'down → start → update* → end, with cancel branching out of any step.',
        _kAccentVDrag,
        _kAccentVDragAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperWarm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('LIFECYCLE', _kAccentVDrag),
            _bodyText(
              'A vertical drag is the first axis-locked continuous gesture. '
              'It begins with a candidate (onVerticalDragDown), commits when '
              'the gesture arena resolves in its favour (onVerticalDragStart), '
              'streams positional updates (onVerticalDragUpdate), and ends with '
              'a release that may carry velocity (onVerticalDragEnd).',
            ),
            const SizedBox(height: 18.0),
            _timeline(
              const <String>[
                'onVerticalDragDown',
                'onVerticalDragStart',
                'onVerticalDragUpdate',
                'onVerticalDragEnd',
              ],
              _kAccentVDrag,
              cancelBranch: 'onVerticalDragCancel',
            ),
            const SizedBox(height: 24.0),
            _codeBlock(
              'onVerticalDragDown: (DragDownDetails d) {\n'
              '  // d.globalPosition, d.localPosition\n'
              '}\n\n'
              'onVerticalDragStart: (DragStartDetails d) {\n'
              '  // d.globalPosition, d.localPosition, d.kind, d.sourceTimeStamp\n'
              '}\n\n'
              'onVerticalDragUpdate: (DragUpdateDetails d) {\n'
              '  // d.delta — the per-frame movement vector\n'
              '  // d.primaryDelta — the locked-axis delta (dy here)\n'
              '}\n\n'
              'onVerticalDragEnd: (DragEndDetails d) {\n'
              '  // d.velocity, d.primaryVelocity (dy/s here)\n'
              '}\n\n'
              'onVerticalDragCancel: () { /* arena lost mid-drag */ }',
              _kAccentVDrag,
            ),
            const SizedBox(height: 24.0),
            _kicker('FINGER PATH', _kAccentVDragAlt),
            const SizedBox(height: 12.0),
            _fingerPathVertical(),
            const SizedBox(height: 20.0),
            _calloutRow(
              Icons.lock_outline,
              'A "vertical drag" is axis-locked: the recognizer ignores '
              'movements where dx dominates dy.',
              _kAccentVDrag,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _fingerPathVertical() {
  return Container(
    height: 220.0,
    decoration: BoxDecoration(
      color: _kAccentVDrag.withOpacity(0.06),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kAccentVDrag.withOpacity(0.25)),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: <Widget>[
        _pathLabel('start', _kAccentVDrag),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _pathDot(_kAccentVDrag),
              _pathDot(_kAccentVDrag.withOpacity(0.85)),
              _pathDot(_kAccentVDrag.withOpacity(0.7)),
              _pathDot(_kAccentVDrag.withOpacity(0.55)),
              Icon(Icons.arrow_downward, color: _kAccentVDrag, size: 22.0),
            ],
          ),
        ),
        _pathLabel('end', _kAccentVDragAlt),
      ],
    ),
  );
}

Widget _pathDot(Color color) {
  return Container(
    width: 14.0,
    height: 14.0,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

Widget _pathLabel(String text, Color color) {
  return RotatedBox(
    quarterTurns: 0,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 6: HORIZONTAL DRAG
// ============================================================================

Widget _sectionHorizontalDrag() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        6,
        'Horizontal drag chain',
        'The mirror of vertical drag, axis-locked to dx.',
        _kAccentHDrag,
        _kAccentHDragAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperCool,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('LIFECYCLE', _kAccentHDrag),
            _bodyText(
              'Identical shape to the vertical chain — the only difference is '
              'which axis the recognizer locks to. Horizontal drags are the '
              'currency of swipe-to-dismiss, carousels, and drawer reveals.',
            ),
            const SizedBox(height: 18.0),
            _timeline(
              const <String>[
                'onHorizontalDragDown',
                'onHorizontalDragStart',
                'onHorizontalDragUpdate',
                'onHorizontalDragEnd',
              ],
              _kAccentHDrag,
              cancelBranch: 'onHorizontalDragCancel',
            ),
            const SizedBox(height: 24.0),
            _codeBlock(
              'onHorizontalDragDown: (DragDownDetails d) {}\n'
              'onHorizontalDragStart: (DragStartDetails d) {}\n'
              'onHorizontalDragUpdate: (DragUpdateDetails d) {\n'
              '  // d.primaryDelta — dx for this chain\n'
              '}\n'
              'onHorizontalDragEnd: (DragEndDetails d) {\n'
              '  // d.primaryVelocity — dx/s\n'
              '}\n'
              'onHorizontalDragCancel: () {}',
              _kAccentHDrag,
            ),
            const SizedBox(height: 24.0),
            _kicker('FINGER PATH', _kAccentHDragAlt),
            const SizedBox(height: 12.0),
            _fingerPathHorizontal(),
            const SizedBox(height: 20.0),
            _calloutRow(
              Icons.swipe,
              'Common pairing: combine onHorizontalDragEnd.primaryVelocity '
              'with a threshold to decide between "swipe" and "scrub".',
              _kAccentHDrag,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _fingerPathHorizontal() {
  return Container(
    height: 110.0,
    decoration: BoxDecoration(
      color: _kAccentHDrag.withOpacity(0.06),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kAccentHDrag.withOpacity(0.25)),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _pathLabel('start', _kAccentHDrag),
            _pathDot(_kAccentHDrag),
            _pathDot(_kAccentHDrag.withOpacity(0.85)),
            _pathDot(_kAccentHDrag.withOpacity(0.7)),
            _pathDot(_kAccentHDrag.withOpacity(0.55)),
            Icon(Icons.arrow_forward, color: _kAccentHDrag, size: 22.0),
            _pathLabel('end', _kAccentHDragAlt),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7: PAN
// ============================================================================

Widget _sectionPan() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        7,
        'Pan chain',
        'Two axes at once — pan is what you reach for when both dx and dy matter.',
        _kAccentPan,
        _kAccentPanAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperWarm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('LIFECYCLE', _kAccentPan),
            _bodyText(
              'Pan is "drag with no axis lock". The same down/start/update/end/'
              'cancel quintet applies, but DragUpdateDetails.delta is now a '
              'true 2D vector, and primaryDelta is null because no single axis '
              'wins.',
            ),
            const SizedBox(height: 18.0),
            _timeline(
              const <String>[
                'onPanDown',
                'onPanStart',
                'onPanUpdate',
                'onPanEnd',
              ],
              _kAccentPan,
              cancelBranch: 'onPanCancel',
            ),
            const SizedBox(height: 24.0),
            _codeBlock(
              'onPanDown: (DragDownDetails d) {}\n'
              'onPanStart: (DragStartDetails d) {}\n'
              'onPanUpdate: (DragUpdateDetails d) {\n'
              '  // d.delta is Offset(dx, dy)\n'
              '  // d.primaryDelta is null — no axis lock\n'
              '}\n'
              'onPanEnd: (DragEndDetails d) {\n'
              '  // d.velocity has both components populated\n'
              '}\n'
              'onPanCancel: () {}',
              _kAccentPan,
            ),
            const SizedBox(height: 24.0),
            _kicker('FINGER PATH', _kAccentPanAlt),
            const SizedBox(height: 12.0),
            _fingerPathPan(),
            const SizedBox(height: 20.0),
            _calloutRow(
              Icons.error_outline,
              'Pan and scale callbacks cannot coexist on the same '
              'GestureDetector — scale is a superset of pan. Use one or the '
              'other.',
              _kAccentPan,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _fingerPathPan() {
  return Container(
    height: 220.0,
    decoration: BoxDecoration(
      color: _kAccentPan.withOpacity(0.06),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kAccentPan.withOpacity(0.25)),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 12.0,
          top: 14.0,
          child: _pathLabel('start', _kAccentPan),
        ),
        Positioned(
          right: 12.0,
          bottom: 14.0,
          child: _pathLabel('end', _kAccentPanAlt),
        ),
        Positioned(
          left: 80.0,
          top: 50.0,
          child: _pathDot(_kAccentPan),
        ),
        Positioned(
          left: 130.0,
          top: 80.0,
          child: _pathDot(_kAccentPan.withOpacity(0.85)),
        ),
        Positioned(
          left: 180.0,
          top: 110.0,
          child: _pathDot(_kAccentPan.withOpacity(0.7)),
        ),
        Positioned(
          left: 230.0,
          top: 140.0,
          child: _pathDot(_kAccentPan.withOpacity(0.55)),
        ),
        Positioned(
          right: 70.0,
          bottom: 50.0,
          child: Icon(
            Icons.arrow_outward,
            color: _kAccentPan,
            size: 26.0,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8: DRAG DETAILS ANATOMY
// ============================================================================

Widget _sectionDragDetailsAnatomy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        8,
        'Drag details record anatomy',
        'DragDownDetails, DragStartDetails, DragUpdateDetails, DragEndDetails — what each field carries.',
        _kAccentDetails,
        _kAccentDetailsAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperCool,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('WHY DETAILS?', _kAccentDetails),
            _bodyText(
              'Every drag callback receives a *Details record. Records are '
              'plain Dart classes — they bundle positional data so the '
              'callback signature stays a single argument. Memorize the four '
              'records below and most drag code becomes obvious.',
            ),
            const SizedBox(height: 20.0),
            _detailsCard(
              'DragDownDetails',
              const <List<String>>[
                <String>['globalPosition', 'Offset', 'Initial touch in screen coords'],
                <String>['localPosition', 'Offset', 'Initial touch in detector coords'],
              ],
              _kAccentDetails,
            ),
            const SizedBox(height: 12.0),
            _detailsCard(
              'DragStartDetails',
              const <List<String>>[
                <String>['globalPosition', 'Offset', 'Screen-space position when start fired'],
                <String>['localPosition', 'Offset', 'Local-space position when start fired'],
                <String>['kind', 'PointerDeviceKind?', 'touch / mouse / stylus / etc.'],
                <String>['sourceTimeStamp', 'Duration?', 'Timestamp of the raw pointer event'],
              ],
              _kAccentDetails,
            ),
            const SizedBox(height: 12.0),
            _detailsCard(
              'DragUpdateDetails',
              const <List<String>>[
                <String>['globalPosition', 'Offset', 'Current position (screen)'],
                <String>['localPosition', 'Offset', 'Current position (local)'],
                <String>['delta', 'Offset', 'Movement since previous update'],
                <String>['primaryDelta', 'double?', 'Locked-axis delta (null for pan)'],
                <String>['sourceTimeStamp', 'Duration?', 'Timestamp of the raw pointer event'],
              ],
              _kAccentDetails,
            ),
            const SizedBox(height: 12.0),
            _detailsCard(
              'DragEndDetails',
              const <List<String>>[
                <String>['velocity', 'Velocity', 'Per-axis pixel/second on release'],
                <String>['primaryVelocity', 'double?', 'Locked-axis velocity (null for pan)'],
                <String>['globalPosition', 'Offset', 'Lift-off position (screen)'],
                <String>['localPosition', 'Offset', 'Lift-off position (local)'],
              ],
              _kAccentDetails,
            ),
            const SizedBox(height: 20.0),
            _kicker('TAP DETAILS RECORDS', _kAccentDetailsAlt),
            const SizedBox(height: 12.0),
            _detailsCard(
              'TapDownDetails',
              const <List<String>>[
                <String>['globalPosition', 'Offset', 'Where the finger landed (screen)'],
                <String>['localPosition', 'Offset', 'Where the finger landed (local)'],
                <String>['kind', 'PointerDeviceKind?', 'Device type (see Section 9)'],
              ],
              _kAccentDetails,
            ),
            const SizedBox(height: 12.0),
            _detailsCard(
              'TapUpDetails',
              const <List<String>>[
                <String>['globalPosition', 'Offset', 'Where the finger lifted (screen)'],
                <String>['localPosition', 'Offset', 'Where the finger lifted (local)'],
                <String>['kind', 'PointerDeviceKind', 'Device type'],
              ],
              _kAccentDetails,
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 9: POINTER DEVICE KIND
// ============================================================================

Widget _sectionPointerDeviceKind() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        9,
        'PointerDeviceKind on tap-down',
        'Use TapDownDetails.kind to branch on touch / mouse / stylus / trackpad.',
        _kAccentKind,
        _kAccentKindAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperWarm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('THE ENUM', _kAccentKind),
            _bodyText(
              'TapDownDetails (and DragStartDetails) expose a kind field of '
              'type PointerDeviceKind. The same tap can mean very different '
              'things depending on the source device — secondary actions for '
              'mouse, hover-aware behavior for stylus, low-latency hints for '
              'trackpad.',
            ),
            const SizedBox(height: 20.0),
            _kindCard(
              'touch',
              'Finger on a touchscreen. The default on phones and tablets. '
              'No hover, broad contact area, expects forgiveness in hit-testing.',
              Icons.touch_app,
              _kAccentKind,
            ),
            const SizedBox(height: 10.0),
            _kindCard(
              'mouse',
              'A pointing device with buttons. Supports right-click via '
              'secondary tap callbacks. Hover is delivered via MouseRegion, '
              'not GestureDetector.',
              Icons.mouse,
              _kAccentKind,
            ),
            const SizedBox(height: 10.0),
            _kindCard(
              'stylus',
              'Pen/Apple Pencil/S-Pen. Pressure, tilt, and barrel buttons are '
              'available on lower-level PointerEvents, not surface callbacks.',
              Icons.draw,
              _kAccentKind,
            ),
            const SizedBox(height: 10.0),
            _kindCard(
              'invertedStylus',
              'Stylus eraser tip. Mostly used to switch to delete-style tools '
              'in drawing apps.',
              Icons.auto_fix_high,
              _kAccentKind,
            ),
            const SizedBox(height: 10.0),
            _kindCard(
              'trackpad',
              'A trackpad gesture treated as a high-level event (pan-scroll, '
              'zoom). On macOS this lights up onScale callbacks too.',
              Icons.swap_calls,
              _kAccentKind,
            ),
            const SizedBox(height: 10.0),
            _kindCard(
              'unknown',
              'A pointer device that Flutter cannot classify. Treat it as a '
              'touch for safety.',
              Icons.help_outline,
              _kAccentKind,
            ),
            const SizedBox(height: 20.0),
            _codeBlock(
              'onTapDown: (TapDownDetails d) {\n'
              '  switch (d.kind) {\n'
              '    case PointerDeviceKind.mouse:\n'
              '      // show hover cursor\n'
              '    case PointerDeviceKind.stylus:\n'
              '    case PointerDeviceKind.invertedStylus:\n'
              '      // suppress finger-friendly padding\n'
              '    case PointerDeviceKind.touch:\n'
              '    case PointerDeviceKind.trackpad:\n'
              '    case PointerDeviceKind.unknown:\n'
              '    default:\n'
              '      // touch defaults\n'
              '  }\n'
              '}',
              _kAccentKind,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _kindCard(String name, String hint, IconData icon, Color accent) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withOpacity(0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: accent, size: 26.0),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'PointerDeviceKind.$name',
                style: TextStyle(
                  color: accent,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                hint,
                style: const TextStyle(
                  color: _kInkMid,
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10: RECIPE CARDS
// ============================================================================

Widget _sectionRecipeCards() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        10,
        'Recipe cards',
        'Common UI patterns assembled from the callback families above.',
        _kAccentRecipe,
        _kAccentRecipeAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperCool,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _recipeCard(
              'Swipe to delete',
              'onHorizontalDragUpdate + onHorizontalDragEnd',
              'Use the delta to translate the row off-screen; use the '
              'primaryVelocity on end to decide between snap-back and commit.',
              _kAccentRecipe,
              Icons.delete_sweep,
            ),
            _recipeCard(
              'Double-tap to zoom',
              'onDoubleTap + onDoubleTapDown',
              'Capture the focal point from TapDownDetails.localPosition, then '
              'toggle a discrete zoom state — no animation controller needed '
              'in a stateless renderer, just publish the new scale.',
              _kAccentRecipe,
              Icons.zoom_in,
            ),
            _recipeCard(
              'Long-press context menu',
              'onLongPressStart + onLongPressEnd',
              'Open the menu at LongPressStartDetails.globalPosition; close it '
              'on onLongPressEnd, or earlier if a selection happens.',
              _kAccentRecipe,
              Icons.menu_open,
            ),
            _recipeCard(
              'Drag to reorder',
              'onLongPress + onLongPressMoveUpdate + onLongPressEnd',
              'Long-press picks up the row, move-update tracks the finger, '
              'end commits the new index. The full long-press chain shines.',
              _kAccentRecipe,
              Icons.unfold_more,
            ),
            _recipeCard(
              'Press-and-hold action button',
              'onTapDown + onTapUp + onTapCancel',
              'TapDown lights up the button, TapUp commits, TapCancel '
              'restores the resting state if the gesture arena is lost to a '
              'scroll.',
              _kAccentRecipe,
              Icons.power_settings_new,
            ),
            _recipeCard(
              'Two-axis sketch canvas',
              'onPanStart + onPanUpdate + onPanEnd',
              'Pan delivers Offset deltas with no axis lock — ideal for '
              'free-form drawing or whiteboard-style canvases.',
              _kAccentRecipe,
              Icons.brush,
            ),
            _recipeCard(
              'Right-click affordance',
              'onSecondaryTap + onSecondaryTapDown',
              'On desktop, mirror your primary action with a secondary chain. '
              'Use TapDownDetails.kind to branch on mouse vs. touch.',
              _kAccentRecipe,
              Icons.mouse,
            ),
            _recipeCard(
              'Vertical fling dismiss',
              'onVerticalDragEnd.primaryVelocity',
              'A modal sheet checks primaryVelocity against a threshold on '
              'end; above the threshold the sheet dismisses, below it the '
              'sheet snaps back. No live update logic required for the '
              'decision step.',
              _kAccentRecipe,
              Icons.expand_more,
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 11: COMPARISON TABLE
// ============================================================================

Widget _sectionComparisonTable() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        11,
        'Comparison table',
        'Side-by-side: vertical drag, horizontal drag, and pan.',
        _kAccentDetails,
        _kAccentDetailsAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperWarm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kicker('AT A GLANCE', _kAccentDetails),
            _bodyText(
              'The three continuous-gesture families share a lifecycle skeleton '
              'but differ in axis behavior and the shape of their delta/'
              'velocity values.',
            ),
            const SizedBox(height: 16.0),
            _comparisonTable(),
          ],
        ),
      ),
    ],
  );
}

Widget _comparisonTable() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kAccentDetails.withOpacity(0.35)),
    ),
    child: Column(
      children: <Widget>[
        _tableHeaderRow(<String>['Aspect', 'Vertical drag', 'Horizontal drag', 'Pan']),
        _tableRow(<String>[
          'Axis lock',
          'dy only',
          'dx only',
          'none',
        ]),
        _tableRow(<String>[
          'delta',
          'Offset(0, dy)',
          'Offset(dx, 0)',
          'Offset(dx, dy)',
        ]),
        _tableRow(<String>[
          'primaryDelta',
          'dy',
          'dx',
          'null',
        ]),
        _tableRow(<String>[
          'velocity components',
          'dy only',
          'dx only',
          'both',
        ]),
        _tableRow(<String>[
          'primaryVelocity',
          'dy/s',
          'dx/s',
          'null',
        ]),
        _tableRow(<String>[
          'Coexists with scale?',
          'no',
          'no',
          'no',
        ]),
        _tableRow(<String>[
          'Typical use',
          'pull-to-refresh',
          'swipe-to-dismiss',
          'sketch canvas',
        ]),
      ],
    ),
  );
}

Widget _tableHeaderRow(List<String> cells) {
  return Container(
    decoration: BoxDecoration(
      color: _kAccentDetails.withOpacity(0.10),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(14.0),
        topRight: Radius.circular(14.0),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    child: Row(
      children: cells
          .map(
            (String c) => Expanded(
              child: Text(
                c,
                style: const TextStyle(
                  color: _kAccentDetails,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}

Widget _tableRow(List<String> cells) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFEAEDF2))),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            cells[0],
            style: const TextStyle(
              color: _kInkDeep,
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            cells[1],
            style: const TextStyle(
              color: _kAccentVDrag,
              fontSize: 13.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            cells[2],
            style: const TextStyle(
              color: _kAccentHDrag,
              fontSize: 13.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            cells[3],
            style: const TextStyle(
              color: _kAccentPan,
              fontSize: 13.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12: GLOSSARY
// ============================================================================

Widget _sectionGlossary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionBanner(
        12,
        'Glossary',
        'A short field-guide of terms that recur throughout the gesture surface.',
        _kAccentGloss,
        _kAccentGlossAlt,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        color: _kPaperCool,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _glossaryTerm(
              'Gesture arena',
              'A per-pointer mediator where competing recognizers (tap, drag, '
              'scroll, ...) compete for ownership of the pointer. A winner '
              'fires its success callbacks; losers fire cancel callbacks.',
            ),
            _glossaryTerm(
              'Recognizer',
              'A reusable object that observes pointer events and emits high-'
              'level callbacks (e.g. TapGestureRecognizer, '
              'VerticalDragGestureRecognizer). GestureDetector creates these '
              'for you under the hood.',
            ),
            _glossaryTerm(
              'Axis lock',
              'A recognizer policy that rejects pointer motion where the '
              'secondary axis dominates. Vertical/Horizontal drags enforce '
              'this; pan does not.',
            ),
            _glossaryTerm(
              'Details record',
              'A small Dart class bundled into a gesture callback signature. '
              'Carries positional, kind, timestamp, and motion fields so '
              'callbacks stay one-argument.',
            ),
            _glossaryTerm(
              'Primary delta / velocity',
              'For axis-locked drags, the scalar component along the locked '
              'axis. Null for pan (no axis is "primary").',
            ),
            _glossaryTerm(
              'Hit test behavior',
              'How a GestureDetector responds to hits inside vs. outside its '
              'bounds. Opaque (default), translucent, and deferToChild are '
              'the three options.',
            ),
            _glossaryTerm(
              'kDoubleTapTimeout',
              'A framework constant — the maximum time between two taps that '
              'still count as a double-tap.',
            ),
            _glossaryTerm(
              'kLongPressTimeout',
              'A framework constant — the minimum hold duration before a tap '
              'is reinterpreted as a long-press.',
            ),
            _glossaryTerm(
              'Velocity vs. primaryVelocity',
              'Velocity is a Velocity record with pixelsPerSecond as an '
              'Offset; primaryVelocity is the scalar along the locked axis.',
            ),
            _glossaryTerm(
              'Cancel branch',
              'A short-circuit callback that fires when a recognizer loses '
              'the arena. Pair every "down" with a cancel mental model: '
              'something started — does it always finish? No, only sometimes.',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _glossaryTerm(String name, String definition) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kAccentGloss.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 6.0,
              decoration: const BoxDecoration(
                color: _kAccentGloss,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              name,
              style: const TextStyle(
                color: _kInkDeep,
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            definition,
            style: const TextStyle(
              color: _kInkMid,
              fontSize: 14.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE
// ============================================================================

Widget _epilogue() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 56.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kInkSoft, _kInkMid, _kInkDeep],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _kAccentRecipe.withOpacity(0.18),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: _kAccentRecipe.withOpacity(0.6)),
          ),
          child: const Text(
            'END OF ATLAS',
            style: TextStyle(
              color: _kAccentRecipeAlt,
              fontSize: 11.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 22.0),
        const Text(
          'You now hold the whole gesture surface.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Three lifecycles. Five details records. Twelve sections. '
          'A page you can return to whenever a gesture spec leaves you '
          'unsure which callback fires when, and what it carries with it.',
          style: TextStyle(
            color: Color(0xFFB7C0DA),
            fontSize: 16.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 28.0),
        Row(
          children: <Widget>[
            _heroChip('No state'),
            const SizedBox(width: 10.0),
            _heroChip('No async'),
            const SizedBox(width: 10.0),
            _heroChip('No setState'),
            const SizedBox(width: 10.0),
            _heroChip('Analyzer-clean'),
          ],
        ),
        const SizedBox(height: 28.0),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: const Text(
            'Tip — when in doubt, sketch the cancel branch first. If your '
            'gesture cannot fail gracefully, you do not yet have a gesture; '
            'you have a happy path.',
            style: TextStyle(
              color: Color(0xFFE7ECF7),
              fontSize: 14.5,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}
