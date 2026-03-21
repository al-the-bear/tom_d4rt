// D4rt test script: Tests MaterialRectArcTween from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== MaterialRectArcTween Visual Demo ===');
  debugPrint(
    'Demonstrating arc-based rect interpolation for Material hero animations',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('MaterialRectArcTween Demo'),
        backgroundColor: Color(0xFF5C6BC0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic MaterialRectArcTween'),
            SizedBox(height: 8),
            _buildBasicArcTween(),
            SizedBox(height: 24),
            _buildSectionHeader('2. Linear vs Arc Comparison'),
            SizedBox(height: 8),
            _buildLinearVsArcComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('3. Arc Properties (beginArc / endArc)'),
            SizedBox(height: 8),
            _buildArcProperties(),
            SizedBox(height: 24),
            _buildSectionHeader('4. Different Rect Configurations'),
            SizedBox(height: 8),
            _buildDifferentConfigurations(),
            SizedBox(height: 24),
            _buildSectionHeader('5. Hero-Like Expansion'),
            SizedBox(height: 8),
            _buildHeroExpansion(),
            SizedBox(height: 24),
            _buildSectionHeader('6. Fine-Grained Sampling (12 Steps)'),
            SizedBox(height: 8),
            _buildFineGrainedSampling(),
            SizedBox(height: 24),
            _buildSectionHeader('7. Corner Arc Paths'),
            SizedBox(height: 8),
            _buildCornerArcPaths(),
            SizedBox(height: 24),
            _buildSectionHeader('8. Same-Size Rects (Translation Arc)'),
            SizedBox(height: 8),
            _buildSameSizeTranslation(),
            SizedBox(height: 24),
            _buildSectionHeader('9. Edge Cases'),
            SizedBox(height: 8),
            _buildEdgeCases(),
            SizedBox(height: 24),
            _buildSectionHeader('10. Summary'),
            SizedBox(height: 8),
            _buildSummary(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _buildSectionHeader(String title) {
  debugPrint('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF5C6BC0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.only(bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xFF4A148C),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF311B92)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRectLabel(String text, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 6),
      Text(text, style: TextStyle(fontSize: 12, color: Color(0xFF37474F))),
    ],
  );
}

// Builds a positioned, semi-transparent container for a sampled rect
Widget _buildRectBox(Rect r, Color color, {String label = ''}) {
  return Positioned(
    left: r.left,
    top: r.top,
    width: r.width,
    height: r.height,
    child: Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: label.isNotEmpty
          ? Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 9, color: color),
                textAlign: TextAlign.center,
              ),
            )
          : SizedBox.shrink(),
    ),
  );
}

String _fmtRect(Rect r) {
  return 'L:${r.left.toStringAsFixed(1)} T:${r.top.toStringAsFixed(1)} '
      'W:${r.width.toStringAsFixed(1)} H:${r.height.toStringAsFixed(1)}';
}

// ---------------------------------------------------------------------------
// 1. Basic MaterialRectArcTween
// ---------------------------------------------------------------------------

Widget _buildBasicArcTween() {
  debugPrint('Building basic arc tween section');

  final Rect begin = Rect.fromLTWH(10, 10, 60, 60);
  final Rect end = Rect.fromLTWH(120, 100, 180, 140);

  final MaterialRectArcTween arcTween = MaterialRectArcTween(
    begin: begin,
    end: end,
  );

  final List<double> tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  final List<Color> colors = [
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFEF6C00),
    Color(0xFFC62828),
    Color(0xFF6A1B9A),
  ];

  List<Widget> stackChildren = [];
  List<Widget> infoChildren = [];

  for (int i = 0; i < tValues.length; i++) {
    final double t = tValues[i];
    final Rect sampled = arcTween.lerp(t);
    debugPrint('  t=$t -> ${_fmtRect(sampled)}');
    stackChildren.add(_buildRectBox(sampled, colors[i], label: 't=$t'));
    infoChildren.add(
      _buildInfoCard('t=${t.toStringAsFixed(2)}', _fmtRect(sampled)),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Arc tween from small rect (top-left) to large rect (center).',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          _buildRectLabel('t=0.0', colors[0]),
          SizedBox(width: 12),
          _buildRectLabel('t=0.25', colors[1]),
          SizedBox(width: 12),
          _buildRectLabel('t=0.5', colors[2]),
        ],
      ),
      SizedBox(height: 4),
      Row(
        children: [
          _buildRectLabel('t=0.75', colors[3]),
          SizedBox(width: 12),
          _buildRectLabel('t=1.0', colors[4]),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: stackChildren),
      ),
      SizedBox(height: 8),
      ...infoChildren,
    ],
  );
}

// ---------------------------------------------------------------------------
// 2. Linear vs Arc Comparison
// ---------------------------------------------------------------------------

Widget _buildLinearVsArcComparison() {
  debugPrint('Building linear vs arc comparison');

  final Rect begin = Rect.fromLTWH(10, 10, 50, 50);
  final Rect end = Rect.fromLTWH(200, 150, 100, 80);

  final RectTween linearTween = RectTween(begin: begin, end: end);
  final MaterialRectArcTween arcTween = MaterialRectArcTween(
    begin: begin,
    end: end,
  );

  List<Widget> linearRects = [];
  List<Widget> arcRects = [];

  final int steps = 8;
  for (int i = 0; i <= steps; i++) {
    final double t = i / steps;
    final Rect? linR = linearTween.lerp(t);
    final Rect arcR = arcTween.lerp(t);
    if (linR != null) {
      linearRects.add(_buildRectBox(linR, Color(0xFF1565C0)));
    }
    arcRects.add(_buildRectBox(arcR, Color(0xFFC62828)));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Blue = linear RectTween, Red = MaterialRectArcTween',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 4),
      Row(
        children: [
          _buildRectLabel('Linear (RectTween)', Color(0xFF1565C0)),
          SizedBox(width: 16),
          _buildRectLabel('Arc (Material)', Color(0xFFC62828)),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: [...linearRects, ...arcRects]),
      ),
      SizedBox(height: 6),
      _buildInfoCard(
        'Observation',
        'Linear path moves in a straight line; arc path curves outward '
            'producing the characteristic Material hero animation trajectory.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 3. Arc Properties (beginArc / endArc)
// ---------------------------------------------------------------------------

Widget _buildArcProperties() {
  debugPrint('Building arc properties section');

  final Rect begin = Rect.fromLTWH(20, 20, 60, 60);
  final Rect end = Rect.fromLTWH(160, 120, 140, 100);

  final MaterialRectArcTween arcTween = MaterialRectArcTween(
    begin: begin,
    end: end,
  );

  final MaterialPointArcTween? beginArc = arcTween.beginArc;
  final MaterialPointArcTween? endArc = arcTween.endArc;

  debugPrint('  beginArc.begin = ${beginArc?.begin}');
  debugPrint('  beginArc.end   = ${beginArc?.end}');
  debugPrint('  endArc.begin   = ${endArc?.begin}');
  debugPrint('  endArc.end     = ${endArc?.end}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'MaterialRectArcTween exposes two MaterialPointArcTween arcs - '
        'one for the top-left corner and one for the bottom-right corner.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'beginArc (top-left corner)',
        'From ${beginArc?.begin} to ${beginArc?.end}',
      ),
      _buildInfoCard(
        'endArc (bottom-right corner)',
        'From ${endArc?.begin} to ${endArc?.end}',
      ),
      _buildInfoCard('begin rect', _fmtRect(begin)),
      _buildInfoCard('end rect', _fmtRect(end)),
      SizedBox(height: 8),
      // Visualize the two corner arcs
      Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFFCC80)),
        ),
        child: Stack(
          children: [
            // Begin rect outline
            _buildRectBox(begin, Color(0xFF1565C0), label: 'begin'),
            // End rect outline
            _buildRectBox(end, Color(0xFF2E7D32), label: 'end'),
            // Sample beginArc points (top-left corner path)
            if (beginArc != null)
              ..._buildPointDots(beginArc, Color(0xFFE65100), 10),
            // Sample endArc points (bottom-right corner path)
            if (endArc != null)
              ..._buildPointDots(endArc, Color(0xFF6A1B9A), 10),
          ],
        ),
      ),
      SizedBox(height: 4),
      Row(
        children: [
          _buildRectLabel('Top-left arc', Color(0xFFE65100)),
          SizedBox(width: 12),
          _buildRectLabel('Bottom-right arc', Color(0xFF6A1B9A)),
        ],
      ),
    ],
  );
}

// Samples a MaterialPointArcTween and returns small circle Positioned widgets
List<Widget> _buildPointDots(
  MaterialPointArcTween arc,
  Color color,
  int count,
) {
  List<Widget> dots = [];
  for (int i = 0; i <= count; i++) {
    final double t = i / count;
    final Offset pt = arc.lerp(t);
    dots.add(
      Positioned(
        left: pt.dx - 4,
        top: pt.dy - 4,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
  return dots;
}

// ---------------------------------------------------------------------------
// 4. Different Rect Configurations
// ---------------------------------------------------------------------------

Widget _buildDifferentConfigurations() {
  debugPrint('Building different configurations');

  // Shrinking: large -> small
  final Rect shrinkBegin = Rect.fromLTWH(10, 10, 150, 120);
  final Rect shrinkEnd = Rect.fromLTWH(80, 60, 50, 40);

  // Growing: small -> large
  final Rect growBegin = Rect.fromLTWH(130, 100, 30, 30);
  final Rect growEnd = Rect.fromLTWH(10, 10, 180, 140);

  // Moving horizontally: same size, slide right
  final Rect moveBegin = Rect.fromLTWH(10, 60, 60, 60);
  final Rect moveEnd = Rect.fromLTWH(220, 60, 60, 60);

  // Diagonal: top-left -> bottom-right
  final Rect diagBegin = Rect.fromLTWH(10, 10, 40, 40);
  final Rect diagEnd = Rect.fromLTWH(200, 140, 80, 80);

  List<_ConfigEntry> configs = [
    _ConfigEntry('Shrinking', shrinkBegin, shrinkEnd, Color(0xFF00838F)),
    _ConfigEntry('Growing', growBegin, growEnd, Color(0xFF4E342E)),
    _ConfigEntry('Horizontal Move', moveBegin, moveEnd, Color(0xFF1B5E20)),
    _ConfigEntry('Diagonal Expand', diagBegin, diagEnd, Color(0xFF880E4F)),
  ];

  List<Widget> configWidgets = [];

  for (final cfg in configs) {
    final MaterialRectArcTween tw = MaterialRectArcTween(
      begin: cfg.begin,
      end: cfg.end,
    );

    List<Widget> rects = [];
    for (int i = 0; i <= 6; i++) {
      final double t = i / 6;
      final Rect r = tw.lerp(t);
      rects.add(_buildRectBox(r, cfg.color));
    }

    debugPrint(
      '  ${cfg.name}: begin=${_fmtRect(cfg.begin)}, end=${_fmtRect(cfg.end)}',
    );

    configWidgets.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cfg.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cfg.color,
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFE0E0E0)),
            ),
            child: Stack(children: rects),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Four different start/end configurations showing arc paths.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      ...configWidgets,
    ],
  );
}

// ---------------------------------------------------------------------------
// 5. Hero-Like Expansion
// ---------------------------------------------------------------------------

Widget _buildHeroExpansion() {
  debugPrint('Building hero-like expansion');

  // Small icon-sized rect to a near-full-width rect
  final Rect iconRect = Rect.fromLTWH(20, 140, 48, 48);
  final Rect fullRect = Rect.fromLTWH(5, 5, 300, 180);

  final MaterialRectArcTween heroTween = MaterialRectArcTween(
    begin: iconRect,
    end: fullRect,
  );

  List<Widget> frames = [];
  List<double> tSteps = [0.0, 0.1, 0.2, 0.35, 0.5, 0.65, 0.8, 0.9, 1.0];

  List<Color> gradient = [
    Color(0xFF0D47A1),
    Color(0xFF1565C0),
    Color(0xFF1976D2),
    Color(0xFF1E88E5),
    Color(0xFF42A5F5),
    Color(0xFF64B5F6),
    Color(0xFF90CAF9),
    Color(0xFFBBDEFB),
    Color(0xFFE3F2FD),
  ];

  for (int i = 0; i < tSteps.length; i++) {
    final Rect r = heroTween.lerp(tSteps[i]);
    frames.add(_buildRectBox(r, gradient[i], label: 't=${tSteps[i]}'));
    debugPrint('  hero t=${tSteps[i]} -> ${_fmtRect(r)}');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Simulates a hero transition from a 48x48 icon to a 300x180 expanded card.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: frames),
      ),
      SizedBox(height: 6),
      _buildInfoCard('Begin', _fmtRect(iconRect)),
      _buildInfoCard('End', _fmtRect(fullRect)),
    ],
  );
}

// ---------------------------------------------------------------------------
// 6. Fine-Grained Sampling (12 Steps)
// ---------------------------------------------------------------------------

Widget _buildFineGrainedSampling() {
  debugPrint('Building fine-grained sampling');

  final Rect begin = Rect.fromLTWH(15, 10, 50, 50);
  final Rect end = Rect.fromLTWH(200, 130, 100, 80);

  final MaterialRectArcTween tw = MaterialRectArcTween(begin: begin, end: end);

  final int totalSteps = 12;
  List<Widget> stackItems = [];
  List<Widget> infoItems = [];

  for (int i = 0; i <= totalSteps; i++) {
    final double t = i / totalSteps;
    final Rect r = tw.lerp(t);
    // Color fades from blue to red across the steps
    final int redVal = (255 * t).round();
    final int blueVal = (255 * (1 - t)).round();
    final Color c = Color.fromARGB(255, redVal, 60, blueVal);
    stackItems.add(_buildRectBox(r, c));
    infoItems.add(_buildInfoCard('t=${t.toStringAsFixed(3)}', _fmtRect(r)));
    debugPrint('  step $i: t=${t.toStringAsFixed(3)} -> ${_fmtRect(r)}');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '13 samples (t=0 to t=1 in 1/12 increments). '
        'Color transitions from blue to red.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      Container(
        height: 240,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: stackItems),
      ),
      SizedBox(height: 8),
      ...infoItems,
    ],
  );
}

// ---------------------------------------------------------------------------
// 7. Corner Arc Paths
// ---------------------------------------------------------------------------

Widget _buildCornerArcPaths() {
  debugPrint('Building corner arc paths');

  final Rect begin = Rect.fromLTWH(20, 20, 70, 50);
  final Rect end = Rect.fromLTWH(180, 130, 120, 90);

  final MaterialRectArcTween tw = MaterialRectArcTween(begin: begin, end: end);

  final MaterialPointArcTween? topLeftArc = tw.beginArc;
  final MaterialPointArcTween? bottomRightArc = tw.endArc;

  // Sample the two corner paths
  List<Widget> items = [];

  // begin and end rects
  items.add(_buildRectBox(begin, Color(0xFF455A64), label: 'begin'));
  items.add(_buildRectBox(end, Color(0xFF455A64), label: 'end'));

  // Top-left corner dots (orange)
  if (topLeftArc != null) {
    items.addAll(_buildPointDots(topLeftArc, Color(0xFFFF6F00), 16));
  }

  // Bottom-right corner dots (purple)
  if (bottomRightArc != null) {
    items.addAll(_buildPointDots(bottomRightArc, Color(0xFF7B1FA2), 16));
  }

  // Also show intermediate rects at t=0.25 and t=0.75
  final Rect mid25 = tw.lerp(0.25);
  final Rect mid75 = tw.lerp(0.75);
  items.add(_buildRectBox(mid25, Color(0xFF00897B), label: 't=0.25'));
  items.add(_buildRectBox(mid75, Color(0xFFD81B60), label: 't=0.75'));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Orange dots = top-left corner arc path. '
        'Purple dots = bottom-right corner arc path. '
        'Each corner follows its own circular arc.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          _buildRectLabel('Top-Left Arc', Color(0xFFFF6F00)),
          SizedBox(width: 16),
          _buildRectLabel('Bottom-Right Arc', Color(0xFF7B1FA2)),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF9FBE7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFDCE775)),
        ),
        child: Stack(children: items),
      ),
      SizedBox(height: 6),
      _buildInfoCard(
        'Key insight',
        'The two corners sweep along independent circular arcs, which is '
            'what gives MaterialRectArcTween its characteristic curved motion.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 8. Same-Size Rects (Translation Arc)
// ---------------------------------------------------------------------------

Widget _buildSameSizeTranslation() {
  debugPrint('Building same-size translation arc');

  final Rect beginR = Rect.fromLTWH(10, 10, 80, 60);
  final Rect endR = Rect.fromLTWH(220, 140, 80, 60);

  final MaterialRectArcTween tw = MaterialRectArcTween(
    begin: beginR,
    end: endR,
  );

  List<Widget> items = [];
  for (int i = 0; i <= 10; i++) {
    final double t = i / 10;
    final Rect r = tw.lerp(t);
    final int alpha = 80 + ((175 * t).round());
    items.add(
      Positioned(
        left: r.left,
        top: r.top,
        width: r.width,
        height: r.height,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(alpha, 0, 137, 123),
            border: Border.all(color: Color(0xFF00897B), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
    debugPrint('  translation t=${t.toStringAsFixed(1)} -> ${_fmtRect(r)}');
  }

  // Also show the linear path for comparison
  final RectTween linTw = RectTween(begin: beginR, end: endR);
  for (int i = 0; i <= 10; i++) {
    final double t = i / 10;
    final Rect? r = linTw.lerp(t);
    if (r != null) {
      items.add(
        Positioned(
          left: r.left,
          top: r.top,
          width: r.width,
          height: r.height,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFE65100).withValues(alpha: 0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Both rects are 80x60. Only position changes, so the rect slides '
        'along an arc rather than a straight line.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 4),
      Row(
        children: [
          _buildRectLabel('Arc path (filled)', Color(0xFF00897B)),
          SizedBox(width: 16),
          _buildRectLabel('Linear path (outline)', Color(0xFFE65100)),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: items),
      ),
      SizedBox(height: 6),
      _buildInfoCard(
        'Size comparison',
        'begin: ${_fmtRect(beginR)} | end: ${_fmtRect(endR)} — identical dimensions',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 9. Edge Cases
// ---------------------------------------------------------------------------

Widget _buildEdgeCases() {
  debugPrint('Building edge cases');

  // Same position (no movement)
  final Rect sameRect = Rect.fromLTWH(50, 50, 80, 80);
  final MaterialRectArcTween sameTween = MaterialRectArcTween(
    begin: sameRect,
    end: sameRect,
  );
  final Rect sameMid = sameTween.lerp(0.5);

  // Zero-size begin rect
  final Rect zeroBegin = Rect.fromLTWH(100, 100, 0, 0);
  final Rect normalEnd = Rect.fromLTWH(50, 30, 120, 90);
  final MaterialRectArcTween zeroTween = MaterialRectArcTween(
    begin: zeroBegin,
    end: normalEnd,
  );

  List<Widget> zeroStack = [];
  for (int i = 0; i <= 6; i++) {
    final double t = i / 6;
    final Rect r = zeroTween.lerp(t);
    zeroStack.add(
      _buildRectBox(r, Color(0xFF4527A0), label: 't=${t.toStringAsFixed(2)}'),
    );
  }

  // Very small movement
  final Rect nearBegin = Rect.fromLTWH(100, 100, 60, 60);
  final Rect nearEnd = Rect.fromLTWH(105, 103, 62, 61);
  final MaterialRectArcTween nearTween = MaterialRectArcTween(
    begin: nearBegin,
    end: nearEnd,
  );
  final Rect nearMid = nearTween.lerp(0.5);

  debugPrint('  same rect t=0.5 -> ${_fmtRect(sameMid)}');
  debugPrint('  near rect t=0.5 -> ${_fmtRect(nearMid)}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Edge cases: identical rects, zero-size begin, tiny movement.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      _buildInfoCard('Same rect (t=0.5)', _fmtRect(sameMid)),
      _buildInfoCard('Near rects begin', _fmtRect(nearBegin)),
      _buildInfoCard('Near rects end', _fmtRect(nearEnd)),
      _buildInfoCard('Near rects (t=0.5)', _fmtRect(nearMid)),
      SizedBox(height: 8),
      Text(
        'Zero-size begin expanding to normal rect:',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF37474F),
        ),
      ),
      SizedBox(height: 4),
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: zeroStack),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 10. Summary
// ---------------------------------------------------------------------------

Widget _buildSummary() {
  debugPrint('Building summary');

  List<Map<String, String>> summaryItems = [
    {'label': 'Class', 'value': 'MaterialRectArcTween extends RectTween'},
    {
      'label': 'Purpose',
      'value':
          'Interpolates Rects along arc paths for Material hero '
          'animations',
    },
    {
      'label': 'Key Properties',
      'value': 'begin, end (Rect), beginArc, endArc (MaterialPointArcTween)',
    },
    {
      'label': 'Corner Behavior',
      'value':
          'Top-left and bottom-right corners each follow independent '
          'circular arcs',
    },
    {
      'label': 'vs RectTween',
      'value':
          'RectTween interpolates linearly; MaterialRectArcTween curves '
          'outward like Material Design motion',
    },
    {
      'label': 'Use Case',
      'value': 'Hero transitions, shared element animations, page transitions',
    },
    {
      'label': 'Same-size Rects',
      'value':
          'With equal-size begin/end, it becomes a pure arc-based '
          'translation',
    },
    {
      'label': 'Sections Shown',
      'value':
          '10 comprehensive sections covering basic usage, comparison, '
          'arc properties, configurations, hero expansion, fine sampling, '
          'corner arcs, translation, and edge cases',
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...summaryItems.map((item) {
        return _buildInfoCard(item['label']!, item['value']!);
      }),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFE8EAF6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFF9FA8DA)),
        ),
        child: Text(
          'MaterialRectArcTween is the foundation of Flutter\'s hero '
          'animations, producing smooth curved paths that follow Material '
          'Design motion principles.',
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Color(0xFF283593),
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Helper class for configuration entries (Section 4)
// ---------------------------------------------------------------------------

class _ConfigEntry {
  final String name;
  final Rect begin;
  final Rect end;
  final Color color;

  _ConfigEntry(this.name, this.begin, this.end, this.color);
}
