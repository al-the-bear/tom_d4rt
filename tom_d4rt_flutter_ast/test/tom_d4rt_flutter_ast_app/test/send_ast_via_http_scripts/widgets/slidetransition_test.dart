// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - SlideTransition Flipbook
// A hand-authored visual tour through SlideTransition: Offset semantics,
// frame-by-frame slide paths, curved interpolation snapshots, TextDirection
// effects, transformHitTests, nested compositions, and real-world recipes.
import 'package:flutter/material.dart';

// ============================================================================
// HELPER: COLORED CHIP CARD
// ============================================================================
Widget _chip(String label, Color bg, {Color fg = Colors.white, double w = 220.0, double h = 56.0}) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 4.0, offset: Offset(0.0, 2.0)),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13.0),
      textAlign: TextAlign.center,
    ),
  );
}

// ============================================================================
// HELPER: HERO HEADER
// ============================================================================
Widget _heroHeader() {
  return Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1A237E), Color(0xFF311B92), Color(0xFF4A148C)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(color: Colors.black54, blurRadius: 12.0, offset: Offset(0.0, 6.0)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SLIDE TRANSITION FLIPBOOK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'A deep visual tour of position-driven motion',
          style: TextStyle(color: Color(0xFFE1BEE7), fontSize: 14.0, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 16.0),
        Text(
          'SlideTransition translates a child by an Offset that is interpreted in '
          'fractions of the child\'s own size. An Offset(1.0, 0.0) shifts the widget '
          'one full width to the right; Offset(0.0, -0.5) lifts it half its height up. '
          'This flipbook captures motion as a sequence of stopped frames — no '
          'controllers, no ticks, just a procession of snapshots.',
          style: TextStyle(color: Colors.white70, fontSize: 13.0, height: 1.5),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: SECTION BANNER
// ============================================================================
Widget _sectionBanner(int n, String title, List<Color> gradient) {
  return Container(
    margin: EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 8.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: gradient, begin: Alignment.centerLeft, end: Alignment.centerRight),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            n.toString(),
            style: TextStyle(color: gradient.first, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold, letterSpacing: 1.0),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: SECTION CARD WRAPPER
// ============================================================================
Widget _card(Color bg, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.black12, width: 1.0),
    ),
    child: child,
  );
}

// ============================================================================
// HELPER: FRAME LABEL
// ============================================================================
Widget _frameLabel(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.bold),
    ),
  );
}

// ============================================================================
// HELPER: TIMELINE FRAME — fixed bounding box so the slide is visible
// ============================================================================
Widget _timelineFrame(Offset offset, String label, Color color) {
  return Container(
    width: 96.0,
    height: 96.0,
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      border: Border.all(color: Colors.black26, width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    clipBehavior: Clip.hardEdge,
    child: Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: SlideTransition(
              position: AlwaysStoppedAnimation<Offset>(offset),
              child: Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 4.0,
          top: 4.0,
          child: _frameLabel(label, Colors.black87),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: RECIPE CARD
// ============================================================================
Widget _recipeCard(String title, String description, Color accent, Widget preview) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 12.0),
          child: preview,
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: COMPARISON ROW
// ============================================================================
Widget _comparisonRow(String label, String a, String b, Color c) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
    ),
    child: Row(
      children: [
        SizedBox(width: 140.0, child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0))),
        Expanded(child: Text(a, style: TextStyle(fontSize: 12.0, color: c))),
        Expanded(child: Text(b, style: TextStyle(fontSize: 12.0, color: Colors.black87))),
      ],
    ),
  );
}

// ============================================================================
// HELPER: GLOSSARY ENTRY
// ============================================================================
Widget _glossary(String term, String definition, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(6.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(term, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: color)),
        SizedBox(height: 3.0),
        Text(definition, style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4)),
      ],
    ),
  );
}

// ============================================================================
// HELPER: ARROW ROW between frames
// ============================================================================
Widget _arrowRow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.arrow_forward, size: 16.0, color: Colors.black45),
        SizedBox(width: 6.0),
        Text('time advances', style: TextStyle(fontSize: 11.0, color: Colors.black45, fontStyle: FontStyle.italic)),
        SizedBox(width: 6.0),
        Icon(Icons.arrow_forward, size: 16.0, color: Colors.black45),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('SlideTransition Flipbook: building deep-demo');

  // ==========================================================================
  // SECTION 1: ORIGIN AND THE OFFSET COORDINATE SYSTEM
  // ==========================================================================
  // Palette: indigo / blue
  final s1Banner = _sectionBanner(1, 'ORIGIN AND OFFSET SEMANTICS', [Color(0xFF1A237E), Color(0xFF3949AB)]);

  final s1Origin = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 0.0)),
    child: _chip('Offset(0.0, 0.0) — at rest', Color(0xFF3949AB)),
  );
  final s1HalfRight = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.5, 0.0)),
    child: _chip('Offset(0.5, 0.0) — half width right', Color(0xFF1976D2)),
  );
  final s1FullRight = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(1.0, 0.0)),
    child: _chip('Offset(1.0, 0.0) — full width right', Color(0xFF0288D1)),
  );
  final s1HalfLeft = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(-0.5, 0.0)),
    child: _chip('Offset(-0.5, 0.0) — half width left', Color(0xFF00838F)),
  );
  final s1FullLeft = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(-1.0, 0.0)),
    child: _chip('Offset(-1.0, 0.0) — full width left', Color(0xFF00695C)),
  );

  final s1Card = _card(
    Color(0xFFE8EAF6),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Horizontal offsets — fractions of child width',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        SizedBox(height: 8.0),
        Text(
          'Offsets are NOT pixels. SlideTransition multiplies the Offset by the '
          'child\'s rendered Size to produce the actual translation. A widget that '
          'measures 220×56 will move 220px when given Offset(1.0, 0.0).',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s1Origin,
        SizedBox(height: 6.0),
        s1HalfRight,
        SizedBox(height: 6.0),
        s1FullRight,
        SizedBox(height: 6.0),
        s1HalfLeft,
        SizedBox(height: 6.0),
        s1FullLeft,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2: VERTICAL OFFSETS
  // ==========================================================================
  // Palette: pink / rose
  final s2Banner = _sectionBanner(2, 'VERTICAL DRIFT — Y AXIS', [Color(0xFF880E4F), Color(0xFFC2185B)]);

  final s2Up = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.0, -1.0)),
    child: _chip('Offset(0.0, -1.0) — fully above', Color(0xFFAD1457)),
  );
  final s2HalfUp = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.0, -0.5)),
    child: _chip('Offset(0.0, -0.5) — half height up', Color(0xFFC2185B)),
  );
  final s2Center = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 0.0)),
    child: _chip('Offset(0.0, 0.0) — neutral', Color(0xFFE91E63)),
  );
  final s2HalfDown = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 0.5)),
    child: _chip('Offset(0.0, 0.5) — half height down', Color(0xFFEC407A)),
  );
  final s2Down = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 1.0)),
    child: _chip('Offset(0.0, 1.0) — fully below', Color(0xFFF06292)),
  );

  final s2Card = _card(
    Color(0xFFFCE4EC),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vertical offsets — fractions of child height',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF880E4F))),
        SizedBox(height: 8.0),
        Text(
          'Negative Y rises (Flutter coordinates put +Y downward). '
          'Use vertical slides for toasts, banners, drawers entering from the top, '
          'or hero panels rising from the fold.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s2Up,
        SizedBox(height: 6.0),
        s2HalfUp,
        SizedBox(height: 6.0),
        s2Center,
        SizedBox(height: 6.0),
        s2HalfDown,
        SizedBox(height: 6.0),
        s2Down,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3: DIAGONAL OFFSETS
  // ==========================================================================
  // Palette: amber / orange
  final s3Banner = _sectionBanner(3, 'DIAGONAL VECTORS', [Color(0xFFE65100), Color(0xFFFFA000)]);

  final s3NW = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(-0.5, -0.5)),
    child: _chip('NW (-0.5, -0.5)', Color(0xFFE65100)),
  );
  final s3NE = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.5, -0.5)),
    child: _chip('NE (0.5, -0.5)', Color(0xFFEF6C00)),
  );
  final s3SW = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(-0.5, 0.5)),
    child: _chip('SW (-0.5, 0.5)', Color(0xFFF57C00)),
  );
  final s3SE = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.5, 0.5)),
    child: _chip('SE (0.5, 0.5)', Color(0xFFFB8C00)),
  );
  final s3Steep = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.25, 0.85)),
    child: _chip('Steep (0.25, 0.85)', Color(0xFFFFA000)),
  );

  final s3Card = _card(
    Color(0xFFFFF3E0),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Diagonals — two axes combined into a vector',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE65100))),
        SizedBox(height: 8.0),
        Text(
          'Each Offset is a 2D vector. The slide is a single straight-line motion '
          'from (0,0) toward the target Offset; angle and magnitude derive from x/y.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        Row(children: [Expanded(child: s3NW), SizedBox(width: 8.0), Expanded(child: s3NE)]),
        SizedBox(height: 6.0),
        Row(children: [Expanded(child: s3SW), SizedBox(width: 8.0), Expanded(child: s3SE)]),
        SizedBox(height: 6.0),
        s3Steep,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 4: TIMELINE — LEFT-TO-RIGHT SLIDE (LINEAR, 5 FRAMES)
  // ==========================================================================
  // Palette: teal / cyan
  final s4Banner = _sectionBanner(4, 'TIMELINE — LINEAR SLIDE-IN FROM LEFT', [Color(0xFF004D40), Color(0xFF00897B)]);

  final s4Timeline = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _timelineFrame(Offset(-1.0, 0.0), 't=0.00', Color(0xFF00695C)),
      _timelineFrame(Offset(-0.75, 0.0), 't=0.25', Color(0xFF00796B)),
      _timelineFrame(Offset(-0.5, 0.0), 't=0.50', Color(0xFF00897B)),
      _timelineFrame(Offset(-0.25, 0.0), 't=0.75', Color(0xFF009688)),
      _timelineFrame(Offset(0.0, 0.0), 't=1.00', Color(0xFF26A69A)),
    ],
  );

  final s4Card = _card(
    Color(0xFFE0F2F1),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Linear interpolation — equal spacing between frames',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
        SizedBox(height: 8.0),
        Text(
          'A linear Tween<Offset>(begin: Offset(-1,0), end: Offset(0,0)) sampled at '
          't = 0.0, 0.25, 0.5, 0.75, 1.0 produces evenly spaced offsets. '
          'In a live animation this is what Curves.linear delivers.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s4Timeline,
        _arrowRow(),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5: TIMELINE — EASE-OUT CURVE (SLOWS NEAR THE END)
  // ==========================================================================
  // Palette: deep purple
  final s5Banner = _sectionBanner(5, 'CURVED INTERPOLATION — EASE-OUT', [Color(0xFF311B92), Color(0xFF673AB7)]);

  // Curves.easeOut samples (precomputed): t=0 -> 0.0, 0.25 -> 0.41, 0.5 -> 0.72,
  // 0.75 -> 0.91, 1.0 -> 1.0 (approximate; visual purposes only).
  final s5Timeline = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _timelineFrame(Offset(-1.0, 0.0), 't=0.00', Color(0xFF311B92)),
      _timelineFrame(Offset(-0.59, 0.0), 't=0.25', Color(0xFF4527A0)),
      _timelineFrame(Offset(-0.28, 0.0), 't=0.50', Color(0xFF512DA8)),
      _timelineFrame(Offset(-0.09, 0.0), 't=0.75', Color(0xFF5E35B1)),
      _timelineFrame(Offset(0.0, 0.0), 't=1.00', Color(0xFF673AB7)),
    ],
  );

  final s5Card = _card(
    Color(0xFFEDE7F6),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Curves.easeOut — rapid start, decelerating finish',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF311B92))),
        SizedBox(height: 8.0),
        Text(
          'Ease-out covers most ground early then settles into its destination. '
          'Note the spacing between t=0.00→0.25 (~0.41 of the way) vs '
          't=0.75→1.00 (only ~0.09). This is the classic "exits fast, lands soft" '
          'feel used for content arriving on screen.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s5Timeline,
        _arrowRow(),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 6: TIMELINE — EASE-IN CURVE (ACCELERATES NEAR THE END)
  // ==========================================================================
  // Palette: red / coral
  final s6Banner = _sectionBanner(6, 'CURVED INTERPOLATION — EASE-IN', [Color(0xFFB71C1C), Color(0xFFE53935)]);

  // Curves.easeIn samples (precomputed approx): t=0 -> 0.0, 0.25 -> 0.09,
  // 0.5 -> 0.31, 0.75 -> 0.62, 1.0 -> 1.0
  final s6Timeline = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _timelineFrame(Offset(-1.0, 0.0), 't=0.00', Color(0xFFB71C1C)),
      _timelineFrame(Offset(-0.91, 0.0), 't=0.25', Color(0xFFC62828)),
      _timelineFrame(Offset(-0.69, 0.0), 't=0.50', Color(0xFFD32F2F)),
      _timelineFrame(Offset(-0.38, 0.0), 't=0.75', Color(0xFFE53935)),
      _timelineFrame(Offset(0.0, 0.0), 't=1.00', Color(0xFFEF5350)),
    ],
  );

  final s6Card = _card(
    Color(0xFFFFEBEE),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Curves.easeIn — gentle start, accelerating finish',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFB71C1C))),
        SizedBox(height: 8.0),
        Text(
          'Ease-in barely moves at first, then accelerates into its destination. '
          'Best for elements leaving the screen — they linger, then commit.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s6Timeline,
        _arrowRow(),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 7: TIMELINE — VERTICAL DROP (TOP-DOWN, EASE-OUT)
  // ==========================================================================
  // Palette: green
  final s7Banner = _sectionBanner(7, 'VERTICAL TIMELINE — DROP DOWN', [Color(0xFF1B5E20), Color(0xFF43A047)]);

  final s7Timeline = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _timelineFrame(Offset(0.0, -1.0), 't=0.00', Color(0xFF1B5E20)),
      _timelineFrame(Offset(0.0, -0.59), 't=0.25', Color(0xFF2E7D32)),
      _timelineFrame(Offset(0.0, -0.28), 't=0.50', Color(0xFF388E3C)),
      _timelineFrame(Offset(0.0, -0.09), 't=0.75', Color(0xFF43A047)),
      _timelineFrame(Offset(0.0, 0.0), 't=1.00', Color(0xFF66BB6A)),
    ],
  );

  final s7Card = _card(
    Color(0xFFE8F5E9),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top-of-screen drop with deceleration',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
        SizedBox(height: 8.0),
        Text(
          'Banners and snackbar-style notifications often drop from above. '
          'Begin Offset(0,-1) places the child fully out of view above its slot; '
          'end Offset(0,0) lands it in place.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s7Timeline,
        _arrowRow(),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 8: TIMELINE — BOTTOM SHEET RISE
  // ==========================================================================
  // Palette: brown / sepia
  final s8Banner = _sectionBanner(8, 'BOTTOM SHEET RISE', [Color(0xFF3E2723), Color(0xFF6D4C41)]);

  final s8Timeline = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _timelineFrame(Offset(0.0, 1.0), 't=0.00', Color(0xFF3E2723)),
      _timelineFrame(Offset(0.0, 0.59), 't=0.25', Color(0xFF4E342E)),
      _timelineFrame(Offset(0.0, 0.28), 't=0.50', Color(0xFF5D4037)),
      _timelineFrame(Offset(0.0, 0.09), 't=0.75', Color(0xFF6D4C41)),
      _timelineFrame(Offset(0.0, 0.0), 't=1.00', Color(0xFF8D6E63)),
    ],
  );

  final s8Card = _card(
    Color(0xFFEFEBE9),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Modal bottom sheet — rises from below',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3E2723))),
        SizedBox(height: 8.0),
        Text(
          'Modals usually enter from offscreen-bottom. Tween<Offset>(begin: '
          'Offset(0,1), end: Offset.zero) is the canonical bottom-sheet recipe.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s8Timeline,
        _arrowRow(),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 9: TEXT DIRECTION — LTR vs RTL
  // ==========================================================================
  // Palette: blue grey
  final s9Banner = _sectionBanner(9, 'TEXT DIRECTION EFFECTS', [Color(0xFF263238), Color(0xFF546E7A)]);

  final s9Ltr = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.5, 0.0)),
    textDirection: TextDirection.ltr,
    child: _chip('LTR + Offset(0.5, 0.0) → moves right', Color(0xFF455A64)),
  );
  final s9Rtl = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.5, 0.0)),
    textDirection: TextDirection.rtl,
    child: _chip('RTL + Offset(0.5, 0.0) → moves LEFT', Color(0xFF607D8B)),
  );
  final s9LtrNeg = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(-0.5, 0.0)),
    textDirection: TextDirection.ltr,
    child: _chip('LTR + Offset(-0.5, 0.0) → moves left', Color(0xFF78909C)),
  );
  final s9RtlNeg = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(-0.5, 0.0)),
    textDirection: TextDirection.rtl,
    child: _chip('RTL + Offset(-0.5, 0.0) → moves RIGHT', Color(0xFF90A4AE)),
  );

  final s9Card = _card(
    Color(0xFFECEFF1),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TextDirection mirrors the X axis under RTL',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF263238))),
        SizedBox(height: 8.0),
        Text(
          'When textDirection is RTL, the X component of the Offset is negated '
          'before translation. Vertical (Y) is unaffected. This keeps animations '
          'directionally correct in localized UIs without writing two versions.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s9Ltr,
        SizedBox(height: 6.0),
        s9Rtl,
        SizedBox(height: 6.0),
        s9LtrNeg,
        SizedBox(height: 6.0),
        s9RtlNeg,
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFCFD8DC),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Rule: Effective Offset.dx = (textDirection == RTL) ? -dx : dx',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: Color(0xFF263238)),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 10: COMPARISON — LTR vs RTL FOR THE SAME OFFSET
  // ==========================================================================
  final s10Banner = _sectionBanner(10, 'LTR vs RTL — SIDE-BY-SIDE COMPARISON', [Color(0xFF01579B), Color(0xFF0288D1)]);

  final s10Card = _card(
    Color(0xFFE1F5FE),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFF01579B),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
          ),
          child: Row(
            children: [
              SizedBox(width: 140.0, child: Text('Offset.dx', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
              Expanded(child: Text('LTR effect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
              Expanded(child: Text('RTL effect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
            ],
          ),
        ),
        _comparisonRow('1.0', 'one width right', 'one width LEFT', Color(0xFF0288D1)),
        _comparisonRow('0.5', 'half width right', 'half width LEFT', Color(0xFF0288D1)),
        _comparisonRow('0.0', 'no motion', 'no motion', Color(0xFF0288D1)),
        _comparisonRow('-0.5', 'half width left', 'half width RIGHT', Color(0xFF0288D1)),
        _comparisonRow('-1.0', 'one width left', 'one width RIGHT', Color(0xFF0288D1)),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 11: transformHitTests — TRUE vs FALSE
  // ==========================================================================
  final s11Banner = _sectionBanner(11, 'transformHitTests — POINTER LOCATION', [Color(0xFF1B5E20), Color(0xFF388E3C)]);

  final s11True = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.4, 0.0)),
    transformHitTests: true,
    child: _chip('transformHitTests: true (DEFAULT)', Color(0xFF2E7D32)),
  );
  final s11False = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.4, 0.0)),
    transformHitTests: false,
    child: _chip('transformHitTests: false', Color(0xFF558B2F)),
  );

  final s11Card = _card(
    Color(0xFFE8F5E9),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Where do taps register after the slide?',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
        SizedBox(height: 8.0),
        Text(
          'transformHitTests controls whether hit testing follows the visual '
          'translation. With true (default), tapping the visually-shifted child '
          'works as expected. With false, hit tests stay anchored to the '
          'pre-slide bounds — useful for stable interactive overlays.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s11True,
        SizedBox(height: 6.0),
        s11False,
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFC8E6C9),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Tip: leave transformHitTests true unless you have a specific reason '
            'to decouple pointer geometry from visual geometry.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF1B5E20), height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 12: NESTED SLIDETRANSITION — COMPOSING OFFSETS
  // ==========================================================================
  final s12Banner = _sectionBanner(12, 'NESTED COMPOSITIONS', [Color(0xFF4A148C), Color(0xFF7B1FA2)]);

  // Outer slides right 0.3, inner slides down 0.3 — child moves diagonally.
  final s12Composed = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.3, 0.0)),
    child: SlideTransition(
      position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 0.3)),
      child: _chip('Outer(0.3,0) ⊕ Inner(0,0.3)', Color(0xFF7B1FA2)),
    ),
  );

  // Outer slides up, inner slides left — combined NW motion.
  final s12NW = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.0, -0.25)),
    child: SlideTransition(
      position: AlwaysStoppedAnimation<Offset>(Offset(-0.25, 0.0)),
      child: _chip('Outer(0,-0.25) ⊕ Inner(-0.25,0)', Color(0xFF8E24AA)),
    ),
  );

  // Triple nest — three offsets stack.
  final s12Triple = SlideTransition(
    position: AlwaysStoppedAnimation<Offset>(Offset(0.1, 0.0)),
    child: SlideTransition(
      position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 0.1)),
      child: SlideTransition(
        position: AlwaysStoppedAnimation<Offset>(Offset(0.1, 0.1)),
        child: _chip('Triple-nest (0.1,0)→(0,0.1)→(0.1,0.1)', Color(0xFF9C27B0)),
      ),
    ),
  );

  final s12Card = _card(
    Color(0xFFF3E5F5),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Composing offsets through nested SlideTransitions',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A148C))),
        SizedBox(height: 8.0),
        Text(
          'Each enclosing SlideTransition multiplies its Offset by ITS OWN size '
          'and adds it to the layout. Wrapping enables independent x/y animations '
          'driven by separate sources without computing a combined vector.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 12.0),
        s12Composed,
        SizedBox(height: 6.0),
        s12NW,
        SizedBox(height: 6.0),
        s12Triple,
      ],
    ),
  );

  // ==========================================================================
  // SECTION 13: REAL-WORLD RECIPES
  // ==========================================================================
  final s13Banner = _sectionBanner(13, 'REAL-WORLD RECIPES', [Color(0xFF006064), Color(0xFF00ACC1)]);

  final recipeDrawer = _recipeCard(
    'Drawer entrance from the left',
    'Begin Offset(-1.0, 0.0), end Offset.zero. Use Curves.fastOutSlowIn for material '
    'spec. Combine with a FadeTransition for polish.',
    Color(0xFF00838F),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timelineFrame(Offset(-1.0, 0.0), 'start', Color(0xFF00838F)),
        _timelineFrame(Offset(-0.5, 0.0), 'mid', Color(0xFF0097A7)),
        _timelineFrame(Offset(0.0, 0.0), 'end', Color(0xFF00ACC1)),
      ],
    ),
  );

  final recipeSnackbar = _recipeCard(
    'Snackbar enter from the bottom',
    'Begin Offset(0, 1.0), end Offset.zero. Linear or easeOut. Pair with a '
    'short hold then reverse for natural dismissal.',
    Color(0xFF00897B),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timelineFrame(Offset(0.0, 1.0), 'start', Color(0xFF00695C)),
        _timelineFrame(Offset(0.0, 0.5), 'mid', Color(0xFF00796B)),
        _timelineFrame(Offset(0.0, 0.0), 'end', Color(0xFF00897B)),
      ],
    ),
  );

  final recipeBanner = _recipeCard(
    'Hint banner descending from the top',
    'Begin Offset(0, -1.0), end Offset.zero. Pair with a soft drop shadow to '
    'sell the "from above" perception.',
    Color(0xFF5D4037),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timelineFrame(Offset(0.0, -1.0), 'start', Color(0xFF4E342E)),
        _timelineFrame(Offset(0.0, -0.5), 'mid', Color(0xFF5D4037)),
        _timelineFrame(Offset(0.0, 0.0), 'end', Color(0xFF6D4C41)),
      ],
    ),
  );

  final recipeCarousel = _recipeCard(
    'Carousel slide — next item enters from the right',
    'Two simultaneous SlideTransitions: outgoing item from Offset.zero → '
    'Offset(-1,0), incoming item from Offset(1,0) → Offset.zero. Use the same '
    'curve for both for visual coherence.',
    Color(0xFF6A1B9A),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timelineFrame(Offset(1.0, 0.0), 'start', Color(0xFF6A1B9A)),
        _timelineFrame(Offset(0.5, 0.0), 'mid', Color(0xFF7B1FA2)),
        _timelineFrame(Offset(0.0, 0.0), 'end', Color(0xFF8E24AA)),
      ],
    ),
  );

  final recipeDismiss = _recipeCard(
    'Card swipe-dismiss to the right',
    'Begin Offset.zero, end Offset(1.5, 0.0) — overshoot the viewport so the '
    'card visibly leaves. easeIn for a definitive exit.',
    Color(0xFFD84315),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timelineFrame(Offset(0.0, 0.0), 'start', Color(0xFFD84315)),
        _timelineFrame(Offset(0.5, 0.0), 'mid', Color(0xFFE64A19)),
        _timelineFrame(Offset(1.0, 0.0), 'end', Color(0xFFF4511E)),
      ],
    ),
  );

  final recipeRtlDrawer = _recipeCard(
    'Drawer entrance — RTL locale',
    'Same Offset(-1.0, 0.0) source; textDirection: TextDirection.rtl flips the '
    'horizontal axis so the drawer enters from the visual right without changing '
    'your Offset.',
    Color(0xFF1565C0),
    SlideTransition(
      position: AlwaysStoppedAnimation<Offset>(Offset(-1.0, 0.0)),
      textDirection: TextDirection.rtl,
      child: _chip('RTL drawer at t=0', Color(0xFF1565C0), w: 200.0),
    ),
  );

  // ==========================================================================
  // SECTION 14: COMPARISON TABLE — SLIDETRANSITION vs ALTERNATIVES
  // ==========================================================================
  final s14Banner = _sectionBanner(14, 'COMPARING SLIDETRANSITION TO COUSINS', [Color(0xFF263238), Color(0xFF455A64)]);

  final s14Card = _card(
    Color(0xFFF5F5F5),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
          ),
          child: Row(
            children: [
              SizedBox(width: 140.0, child: Text('Widget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
              Expanded(child: Text('Driver', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
              Expanded(child: Text('Best for', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
            ],
          ),
        ),
        _comparisonRow('SlideTransition', 'Animation<Offset>', 'translation in child-fractions', Color(0xFF455A64)),
        _comparisonRow('FractionalTranslation', 'Offset (static)', 'no animation — just shift', Color(0xFF455A64)),
        _comparisonRow('Transform.translate', 'Offset (pixels)', 'absolute pixel offsets', Color(0xFF455A64)),
        _comparisonRow('PositionedTransition', 'Animation<RelRect>', 'inside Stack, full rect', Color(0xFF455A64)),
        _comparisonRow('AnimatedSlide', 'Offset target', 'implicit, simpler API', Color(0xFF455A64)),
        _comparisonRow('AlignTransition', 'Animation<AlignGeo>', 'alignment-anchored motion', Color(0xFF455A64)),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 15: GLOSSARY
  // ==========================================================================
  final s15Banner = _sectionBanner(15, 'GLOSSARY', [Color(0xFF37474F), Color(0xFF607D8B)]);

  final s15Card = _card(
    Color(0xFFFAFAFA),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _glossary(
          'Offset',
          'A 2D vector (dx, dy). In SlideTransition, dx and dy are fractions of '
          'the child\'s width and height respectively.',
          Color(0xFF1A237E),
        ),
        _glossary(
          'Animation<Offset>',
          'Any object with a .value of type Offset and listenable status. '
          'AlwaysStoppedAnimation, Tween.animate(), and CurvedAnimation chains '
          'all satisfy this interface.',
          Color(0xFF311B92),
        ),
        _glossary(
          'AlwaysStoppedAnimation<Offset>',
          'A constant-valued Animation<Offset> with status = dismissed. Perfect '
          'for static visual snapshots inside a flipbook.',
          Color(0xFF4A148C),
        ),
        _glossary(
          'Tween<Offset>',
          'A lerp between two Offsets. Calling .animate(curvedAnimation) '
          'produces an Animation<Offset> that smoothly interpolates begin → end.',
          Color(0xFF880E4F),
        ),
        _glossary(
          'TextDirection',
          'ltr or rtl. RTL negates the Offset\'s dx before applying. Vertical '
          'motion is never affected by TextDirection.',
          Color(0xFFB71C1C),
        ),
        _glossary(
          'transformHitTests',
          'Whether pointer events follow the visual translation. Default true. '
          'Set false for overlays that should remain tappable in their pre-slide '
          'bounds.',
          Color(0xFFE65100),
        ),
        _glossary(
          'Curves',
          'Functions mapping a linear t∈[0,1] to a non-linear t\'∈[0,1]. '
          'easeIn lingers then accelerates; easeOut accelerates then settles; '
          'linear is uniform.',
          Color(0xFF1B5E20),
        ),
        _glossary(
          'Frame',
          'A single rendered visual at a fixed point in time. This flipbook '
          'composes frames using AlwaysStoppedAnimation so no controller is '
          'required.',
          Color(0xFF263238),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 16: KEY POINTS SUMMARY
  // ==========================================================================
  final s16Banner = _sectionBanner(16, 'KEY POINTS', [Color(0xFF004D40), Color(0xFF00695C)]);

  final s16Card = _card(
    Color(0xFFE0F2F1),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Six things to remember', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40), fontSize: 14.0)),
        SizedBox(height: 8.0),
        Text('1. Offsets are fractions of the child\'s own size, not pixels.', style: TextStyle(fontSize: 12.5, height: 1.6)),
        Text('2. Offset(1.0, 0.0) = one full child-width right; (0,1) = one full height down.', style: TextStyle(fontSize: 12.5, height: 1.6)),
        Text('3. textDirection: TextDirection.rtl negates the horizontal axis only.', style: TextStyle(fontSize: 12.5, height: 1.6)),
        Text('4. transformHitTests defaults to true — pointer events follow the slide.', style: TextStyle(fontSize: 12.5, height: 1.6)),
        Text('5. Choose curves intentionally: easeOut for entrances, easeIn for exits.', style: TextStyle(fontSize: 12.5, height: 1.6)),
        Text('6. Nesting SlideTransitions composes offsets without manual math.', style: TextStyle(fontSize: 12.5, height: 1.6)),
      ],
    ),
  );

  // ==========================================================================
  // EPILOGUE
  // ==========================================================================
  final epilogue = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF311B92), Color(0xFF1A237E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EPILOGUE',
          style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
        SizedBox(height: 10.0),
        Text(
          'SlideTransition is the quiet workhorse of in-app motion. Behind '
          'every drawer, sheet, snackbar, carousel, hint banner, and dismissed '
          'card, an Animation<Offset> drives a translation in child-relative '
          'coordinates. This flipbook freezes the motion into snapshots so the '
          'geometry — origin, axis, sign, curve, direction — can be inspected '
          'one frame at a time.',
          style: TextStyle(color: Colors.white70, fontSize: 13.0, height: 1.6),
        ),
        SizedBox(height: 12.0),
        Text(
          'Master the Offset, and the rest is choreography.',
          style: TextStyle(color: Color(0xFFE1BEE7), fontSize: 13.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );

  print('SlideTransition Flipbook: assembled all 16 sections');

  return MaterialApp(
    title: 'Slide Transition Flipbook',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text('Slide Transition Flipbook'),
        backgroundColor: Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heroHeader(),
            s1Banner, s1Card,
            s2Banner, s2Card,
            s3Banner, s3Card,
            s4Banner, s4Card,
            s5Banner, s5Card,
            s6Banner, s6Card,
            s7Banner, s7Card,
            s8Banner, s8Card,
            s9Banner, s9Card,
            s10Banner, s10Card,
            s11Banner, s11Card,
            s12Banner, s12Card,
            s13Banner,
            recipeDrawer,
            recipeSnackbar,
            recipeBanner,
            recipeCarousel,
            recipeDismiss,
            recipeRtlDrawer,
            s14Banner, s14Card,
            s15Banner, s15Card,
            s16Banner, s16Card,
            epilogue,
            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}
