// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialRectCenterArcTween from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== MaterialRectCenterArcTween Visual Demo ===');
  print(
    'Demonstrating center-arc rect interpolation for Material hero animations',
  );
  print(
    'Unlike MaterialRectArcTween (corners follow arcs), '
    'here only the CENTER follows a circular arc while size interpolates linearly.',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('MaterialRectCenterArcTween Demo'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Basic MaterialRectCenterArcTween'),
            SizedBox(height: 8),
            _buildBasicCenterArcTween(),
            SizedBox(height: 24),
            _buildSectionHeader('2. Three-Way Comparison'),
            SizedBox(height: 8),
            _buildThreeWayComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('3. The centerArc Property'),
            SizedBox(height: 8),
            _buildCenterArcProperty(),
            SizedBox(height: 24),
            _buildSectionHeader('4. Same-Size Rects (Pure Arc Translation)'),
            SizedBox(height: 8),
            _buildSameSizeArcTranslation(),
            SizedBox(height: 24),
            _buildSectionHeader('5. Different-Size Rects (Arc + Scaling)'),
            SizedBox(height: 8),
            _buildDifferentSizeArcScaling(),
            SizedBox(height: 24),
            _buildSectionHeader('6. Center Path vs Corners Path'),
            SizedBox(height: 8),
            _buildCenterVsCornersPath(),
            SizedBox(height: 24),
            _buildSectionHeader('7. Hero-Like Expansion'),
            SizedBox(height: 8),
            _buildHeroExpansion(),
            SizedBox(height: 24),
            _buildSectionHeader('8. Fine-Grained Sampling (16 Steps)'),
            SizedBox(height: 8),
            _buildFineGrainedSampling(),
            SizedBox(height: 24),
            _buildSectionHeader('9. Edge Cases'),
            SizedBox(height: 8),
            _buildEdgeCases(),
            SizedBox(height: 24),
            _buildSectionHeader('10. Summary & Variant Comparison'),
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
  print('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF00695C),
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
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xFF004D40),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF00695C)),
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
    width: r.width.clamp(2.0, 400.0),
    height: r.height.clamp(2.0, 400.0),
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

// Small dot positioned at an Offset
Widget _buildDot(Offset pt, Color color, {double size = 8.0}) {
  return Positioned(
    left: pt.dx - size / 2,
    top: pt.dy - size / 2,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    ),
  );
}

// Samples a MaterialPointArcTween and returns small circle Positioned widgets
List<Widget> _buildArcDots(MaterialPointArcTween arc, Color color, int count) {
  List<Widget> dots = [];
  for (int i = 0; i <= count; i++) {
    final double t = i / count;
    final Offset pt = arc.lerp(t);
    dots.add(_buildDot(pt, color));
  }
  return dots;
}

String _fmtRect(Rect r) {
  return 'L:${r.left.toStringAsFixed(1)} T:${r.top.toStringAsFixed(1)} '
      'W:${r.width.toStringAsFixed(1)} H:${r.height.toStringAsFixed(1)}';
}

String _fmtOffset(Offset o) {
  return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
}

// ---------------------------------------------------------------------------
// 1. Basic MaterialRectCenterArcTween
// ---------------------------------------------------------------------------

Widget _buildBasicCenterArcTween() {
  print('Building basic center-arc tween section');

  final Rect begin = Rect.fromLTWH(10, 10, 60, 60);
  final Rect end = Rect.fromLTWH(140, 120, 160, 120);

  final MaterialRectCenterArcTween centerArcTween = MaterialRectCenterArcTween(
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
    final Rect sampled = centerArcTween.lerp(t);
    print('  t=$t -> ${_fmtRect(sampled)}');
    stackChildren.add(_buildRectBox(sampled, colors[i], label: 't=$t'));
    infoChildren.add(
      _buildInfoCard('t=${t.toStringAsFixed(2)}', _fmtRect(sampled)),
    );
  }

  // Also show center path dots
  final MaterialPointArcTween? cArc = centerArcTween.centerArc;
  if (cArc != null) {
    for (int i = 0; i <= 20; i++) {
      final double t = i / 20;
      final Offset pt = cArc.lerp(t);
      stackChildren.add(_buildDot(pt, Color(0xFFFF6F00), size: 5.0));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Center-arc tween from a small rect to a larger rect. '
        'Orange dots show the path the rect center follows (a circular arc).',
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
          SizedBox(width: 12),
          _buildRectLabel('Center arc', Color(0xFFFF6F00)),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 280,
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
// 2. Three-Way Comparison: CenterArc vs CornerArc vs Linear
// ---------------------------------------------------------------------------

Widget _buildThreeWayComparison() {
  print('Building three-way comparison');

  final Rect begin = Rect.fromLTWH(10, 10, 50, 50);
  final Rect end = Rect.fromLTWH(220, 160, 90, 70);

  final RectTween linearTween = RectTween(begin: begin, end: end);
  final MaterialRectArcTween cornerArcTween = MaterialRectArcTween(
    begin: begin,
    end: end,
  );
  final MaterialRectCenterArcTween centerArcTween = MaterialRectCenterArcTween(
    begin: begin,
    end: end,
  );

  List<Widget> linearRects = [];
  List<Widget> cornerArcRects = [];
  List<Widget> centerArcRects = [];

  final int steps = 8;
  for (int i = 0; i <= steps; i++) {
    final double t = i / steps;

    // Linear
    final Rect? linR = linearTween.lerp(t);
    if (linR != null) {
      linearRects.add(_buildRectBox(linR, Color(0xFF1565C0)));
    }

    // Corner-arc
    final Rect cornerR = cornerArcTween.lerp(t);
    cornerArcRects.add(_buildRectBox(cornerR, Color(0xFFC62828)));

    // Center-arc
    final Rect centerR = centerArcTween.lerp(t);
    centerArcRects.add(_buildRectBox(centerR, Color(0xFF2E7D32)));
  }

  // Also trace the center paths
  List<Widget> linearCenterDots = [];
  List<Widget> cornerArcCenterDots = [];
  List<Widget> centerArcCenterDots = [];

  for (int i = 0; i <= 30; i++) {
    final double t = i / 30;

    final Rect? linR = linearTween.lerp(t);
    if (linR != null) {
      linearCenterDots.add(
        _buildDot(linR.center, Color(0xFF1565C0), size: 4.0),
      );
    }

    final Rect cornerR = cornerArcTween.lerp(t);
    cornerArcCenterDots.add(
      _buildDot(cornerR.center, Color(0xFFC62828), size: 4.0),
    );

    final Rect centerR = centerArcTween.lerp(t);
    centerArcCenterDots.add(
      _buildDot(centerR.center, Color(0xFF2E7D32), size: 4.0),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Three rect tween variants compared side-by-side:',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          _buildRectLabel('Linear (RectTween)', Color(0xFF1565C0)),
          SizedBox(width: 8),
          _buildRectLabel('Corner-Arc', Color(0xFFC62828)),
          SizedBox(width: 8),
          _buildRectLabel('Center-Arc', Color(0xFF2E7D32)),
        ],
      ),
      SizedBox(height: 8),
      // Rects overlay
      Text(
        'Rects at 9 sample points:',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 4),
      Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(
          children: [...linearRects, ...cornerArcRects, ...centerArcRects],
        ),
      ),
      SizedBox(height: 12),
      // Center path dots overlay
      Text(
        'Center paths (dots trace the center of each rect):',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 4),
      Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(
          children: [
            // begin/end markers
            _buildRectBox(begin, Color(0xFF455A64), label: 'begin'),
            _buildRectBox(end, Color(0xFF455A64), label: 'end'),
            ...linearCenterDots,
            ...cornerArcCenterDots,
            ...centerArcCenterDots,
          ],
        ),
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'Linear',
        'Center moves in a straight line from begin center to end center.',
      ),
      _buildInfoCard(
        'MaterialRectArcTween',
        'Corners follow independent arcs. Center path is derived from '
            'corner positions (not a pure arc).',
      ),
      _buildInfoCard(
        'MaterialRectCenterArcTween',
        'Center explicitly follows a circular arc. Size interpolates '
            'linearly. This produces a clean, predictable arc for the center.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 3. The centerArc Property
// ---------------------------------------------------------------------------

Widget _buildCenterArcProperty() {
  print('Building centerArc property section');

  final Rect begin = Rect.fromLTWH(20, 20, 60, 60);
  final Rect end = Rect.fromLTWH(180, 140, 120, 80);

  final MaterialRectCenterArcTween tween = MaterialRectCenterArcTween(
    begin: begin,
    end: end,
  );

  final MaterialPointArcTween? cArc = tween.centerArc;

  final Offset beginCenter = begin.center;
  final Offset endCenter = end.center;

  print('  begin center: $beginCenter');
  print('  end center:   $endCenter');
  if (cArc != null) {
    print('  centerArc.begin: ${cArc.begin}');
    print('  centerArc.end:   ${cArc.end}');
  }

  List<Widget> arcDots = [];
  if (cArc != null) {
    arcDots = _buildArcDots(cArc, Color(0xFFFF6F00), 24);
  }

  // Also sample the tween at several t values and show center crosshairs
  List<Widget> centerMarkers = [];
  List<Widget> rectSamples = [];
  for (int i = 0; i <= 8; i++) {
    final double t = i / 8;
    final Rect r = tween.lerp(t);
    rectSamples.add(
      _buildRectBox(r, Color(0xFF00897B).withValues(alpha: 0.6)),
    );
    // Mark center with a small bright dot
    centerMarkers.add(_buildDot(r.center, Color(0xFFD50000), size: 6.0));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'MaterialRectCenterArcTween exposes a centerArc property '
        '(MaterialPointArcTween) that defines the arc the center follows.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      _buildInfoCard('begin center', _fmtOffset(beginCenter)),
      _buildInfoCard('end center', _fmtOffset(endCenter)),
      if (cArc != null) ...[
        _buildInfoCard('centerArc.begin', _fmtOffset(cArc.begin!)),
        _buildInfoCard('centerArc.end', _fmtOffset(cArc.end!)),
      ],
      SizedBox(height: 8),
      Row(
        children: [
          _buildRectLabel('Center arc path', Color(0xFFFF6F00)),
          SizedBox(width: 12),
          _buildRectLabel('Center position', Color(0xFFD50000)),
          SizedBox(width: 12),
          _buildRectLabel('Rect samples', Color(0xFF00897B)),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFFCC80)),
        ),
        child: Stack(
          children: [
            _buildRectBox(begin, Color(0xFF1565C0), label: 'begin'),
            _buildRectBox(end, Color(0xFF2E7D32), label: 'end'),
            ...rectSamples,
            ...arcDots,
            ...centerMarkers,
          ],
        ),
      ),
      SizedBox(height: 6),
      _buildInfoCard(
        'Key insight',
        'The orange arc dots and red center dots overlap, confirming '
            'the center of the rect precisely follows the MaterialPointArcTween arc.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 4. Same-Size Rects (Pure Arc Translation)
// ---------------------------------------------------------------------------

Widget _buildSameSizeArcTranslation() {
  print('Building same-size arc translation');

  final Rect beginR = Rect.fromLTWH(10, 130, 70, 50);
  final Rect endR = Rect.fromLTWH(230, 10, 70, 50);

  final MaterialRectCenterArcTween tw = MaterialRectCenterArcTween(
    begin: beginR,
    end: endR,
  );

  // Also build linear for comparison
  final RectTween linearTw = RectTween(begin: beginR, end: endR);

  List<Widget> arcItems = [];
  List<Widget> linearItems = [];

  for (int i = 0; i <= 10; i++) {
    final double t = i / 10;
    final Rect arcR = tw.lerp(t);
    final Rect? linR = linearTw.lerp(t);

    final int alpha = 80 + ((175 * t).round());
    arcItems.add(
      Positioned(
        left: arcR.left,
        top: arcR.top,
        width: arcR.width,
        height: arcR.height,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(alpha, 0, 105, 92),
            border: Border.all(color: Color(0xFF00695C), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
    print('  arc t=${t.toStringAsFixed(1)} -> ${_fmtRect(arcR)}');

    if (linR != null) {
      linearItems.add(
        Positioned(
          left: linR.left,
          top: linR.top,
          width: linR.width,
          height: linR.height,
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
        'Both rects are 70x50. Since size is identical, this is a pure arc '
        'translation - the rect center travels along a circular arc while '
        'dimensions stay constant.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 4),
      Row(
        children: [
          _buildRectLabel('Center-arc (filled)', Color(0xFF00695C)),
          SizedBox(width: 16),
          _buildRectLabel('Linear (outline)', Color(0xFFE65100)),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 210,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: [...linearItems, ...arcItems]),
      ),
      SizedBox(height: 6),
      _buildInfoCard('Begin', _fmtRect(beginR)),
      _buildInfoCard('End', _fmtRect(endR)),
      _buildInfoCard(
        'Observation',
        'With identical sizes, MaterialRectCenterArcTween produces a clean '
            'curved sweep, while the linear variant cuts straight across.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 5. Different-Size Rects (Arc + Scaling)
// ---------------------------------------------------------------------------

Widget _buildDifferentSizeArcScaling() {
  print('Building different-size arc scaling');

  // Three sub-demos: grow, shrink, aspect change
  List<_SizeConfig> configs = [
    _SizeConfig(
      'Growing (40x40 -> 160x120)',
      Rect.fromLTWH(20, 120, 40, 40),
      Rect.fromLTWH(140, 10, 160, 120),
      Color(0xFF1B5E20),
    ),
    _SizeConfig(
      'Shrinking (160x120 -> 40x40)',
      Rect.fromLTWH(10, 10, 160, 120),
      Rect.fromLTWH(240, 130, 40, 40),
      Color(0xFF880E4F),
    ),
    _SizeConfig(
      'Aspect Ratio Change (50x120 -> 200x40)',
      Rect.fromLTWH(10, 20, 50, 120),
      Rect.fromLTWH(100, 50, 200, 40),
      Color(0xFF4A148C),
    ),
  ];

  List<Widget> configWidgets = [];

  for (final cfg in configs) {
    final MaterialRectCenterArcTween tw = MaterialRectCenterArcTween(
      begin: cfg.begin,
      end: cfg.end,
    );

    List<Widget> rects = [];
    for (int i = 0; i <= 6; i++) {
      final double t = i / 6;
      final Rect r = tw.lerp(t);
      rects.add(_buildRectBox(r, cfg.color));
    }

    // Show center dots
    final MaterialPointArcTween? cArc = tw.centerArc;
    if (cArc != null) {
      for (int i = 0; i <= 16; i++) {
        final double t = i / 16;
        rects.add(_buildDot(cArc.lerp(t), Color(0xFFFF6F00), size: 4.0));
      }
    }

    print(
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
            height: 180,
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
        'When sizes differ the center follows the arc while width/height '
        'interpolate linearly. Orange dots trace the center arc.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      ...configWidgets,
      _buildInfoCard(
        'Size interpolation',
        'Width and height change linearly from begin to end values. '
            'Only the center position follows the arc path.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 6. Center Path vs Corners Path
// ---------------------------------------------------------------------------

Widget _buildCenterVsCornersPath() {
  print('Building center path vs corners path');

  final Rect begin = Rect.fromLTWH(15, 120, 60, 50);
  final Rect end = Rect.fromLTWH(200, 10, 100, 80);

  final MaterialRectCenterArcTween tw = MaterialRectCenterArcTween(
    begin: begin,
    end: end,
  );

  List<Widget> items = [];

  // Draw begin and end rects
  items.add(_buildRectBox(begin, Color(0xFF455A64), label: 'begin'));
  items.add(_buildRectBox(end, Color(0xFF455A64), label: 'end'));

  // Track center, top-left, top-right, bottom-left, bottom-right
  List<Offset> centerPath = [];
  List<Offset> topLeftPath = [];
  List<Offset> topRightPath = [];
  List<Offset> bottomLeftPath = [];
  List<Offset> bottomRightPath = [];

  for (int i = 0; i <= 24; i++) {
    final double t = i / 24;
    final Rect r = tw.lerp(t);
    centerPath.add(r.center);
    topLeftPath.add(r.topLeft);
    topRightPath.add(r.topRight);
    bottomLeftPath.add(r.bottomLeft);
    bottomRightPath.add(r.bottomRight);
  }

  // Draw center dots (orange, largest)
  for (final pt in centerPath) {
    items.add(_buildDot(pt, Color(0xFFFF6F00), size: 6.0));
  }

  // Draw corner dots (smaller, different colors)
  for (final pt in topLeftPath) {
    items.add(_buildDot(pt, Color(0xFF1565C0), size: 4.0));
  }
  for (final pt in topRightPath) {
    items.add(_buildDot(pt, Color(0xFF2E7D32), size: 4.0));
  }
  for (final pt in bottomLeftPath) {
    items.add(_buildDot(pt, Color(0xFFC62828), size: 4.0));
  }
  for (final pt in bottomRightPath) {
    items.add(_buildDot(pt, Color(0xFF6A1B9A), size: 4.0));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Center follows a clean circular arc. Corners are derived from '
        'center + linearly interpolated size, so they form offset copies '
        'of the center arc (not independent arcs).',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),
      Wrap(
        spacing: 12,
        runSpacing: 4,
        children: [
          _buildRectLabel('Center', Color(0xFFFF6F00)),
          _buildRectLabel('Top-Left', Color(0xFF1565C0)),
          _buildRectLabel('Top-Right', Color(0xFF2E7D32)),
          _buildRectLabel('Bottom-Left', Color(0xFFC62828)),
          _buildRectLabel('Bottom-Right', Color(0xFF6A1B9A)),
        ],
      ),
      SizedBox(height: 8),
      Container(
        height: 240,
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
        'Corner behavior',
        'Corners shift together with the center arc and spread apart '
            '(or contract) linearly as size changes. In MaterialRectArcTween, '
            'each corner follows its OWN independent arc instead.',
      ),
      _buildInfoCard(
        'Visual result',
        'Center-arc gives a more "rigid body" feel: the rect shape moves '
            'as a unit along the arc. Corner-arc allows the shape to deform '
            'more during transition.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 7. Hero-Like Expansion
// ---------------------------------------------------------------------------

Widget _buildHeroExpansion() {
  print('Building hero-like expansion');

  // Small icon rect -> large card rect
  final Rect iconRect = Rect.fromLTWH(20, 150, 48, 48);
  final Rect cardRect = Rect.fromLTWH(10, 5, 300, 180);

  final MaterialRectCenterArcTween heroTween = MaterialRectCenterArcTween(
    begin: iconRect,
    end: cardRect,
  );

  List<Widget> frames = [];
  List<double> tSteps = [0.0, 0.08, 0.16, 0.25, 0.35, 0.5, 0.65, 0.8, 0.9, 1.0];

  List<Color> gradient = [
    Color(0xFF004D40),
    Color(0xFF00695C),
    Color(0xFF00796B),
    Color(0xFF00897B),
    Color(0xFF009688),
    Color(0xFF26A69A),
    Color(0xFF4DB6AC),
    Color(0xFF80CBC4),
    Color(0xFFB2DFDB),
    Color(0xFFE0F2F1),
  ];

  for (int i = 0; i < tSteps.length; i++) {
    final Rect r = heroTween.lerp(tSteps[i]);
    frames.add(_buildRectBox(r, gradient[i], label: 't=${tSteps[i]}'));
    print('  hero t=${tSteps[i]} -> ${_fmtRect(r)}');
  }

  // Overlay the center arc path
  final MaterialPointArcTween? cArc = heroTween.centerArc;
  if (cArc != null) {
    for (int i = 0; i <= 30; i++) {
      final double t = i / 30;
      frames.add(_buildDot(cArc.lerp(t), Color(0xFFFF6F00), size: 5.0));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Simulates a hero transition: 48x48 icon to 300x180 card. '
        'The center follows a smooth arc while the rect expands linearly.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
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
        child: Stack(children: frames),
      ),
      SizedBox(height: 6),
      _buildInfoCard('Icon rect', _fmtRect(iconRect)),
      _buildInfoCard('Card rect', _fmtRect(cardRect)),
      _buildInfoCard(
        'Effect',
        'The icon slides along an arc toward the card position, expanding '
            'smoothly. The arc path creates natural Material motion.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 8. Fine-Grained Sampling (16 Steps)
// ---------------------------------------------------------------------------

Widget _buildFineGrainedSampling() {
  print('Building fine-grained sampling');

  final Rect begin = Rect.fromLTWH(10, 140, 50, 40);
  final Rect end = Rect.fromLTWH(220, 10, 90, 70);

  final MaterialRectCenterArcTween tw = MaterialRectCenterArcTween(
    begin: begin,
    end: end,
  );

  final int totalSteps = 16;
  List<Widget> stackItems = [];
  List<Widget> infoItems = [];

  for (int i = 0; i <= totalSteps; i++) {
    final double t = i / totalSteps;
    final Rect r = tw.lerp(t);
    // Color gradient: teal to deep purple across steps
    final int redVal = (128 * t).round();
    final int greenVal = (200 * (1 - t)).round();
    final int blueVal = (128 + (127 * t)).round();
    final Color c = Color.fromARGB(255, redVal, greenVal, blueVal);
    stackItems.add(_buildRectBox(r, c));
    infoItems.add(_buildInfoCard('t=${t.toStringAsFixed(3)}', _fmtRect(r)));
    print('  step $i: t=${t.toStringAsFixed(3)} -> ${_fmtRect(r)}');
  }

  // Add center arc trail
  final MaterialPointArcTween? cArc = tw.centerArc;
  if (cArc != null) {
    for (int i = 0; i <= 40; i++) {
      final double t = i / 40;
      stackItems.add(_buildDot(cArc.lerp(t), Color(0xFFFFD600), size: 3.0));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '17 samples (t=0 to t=1 in 1/16 increments). '
        'Color transitions from teal to purple. '
        'Yellow dots trace the center arc.',
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
// 9. Edge Cases
// ---------------------------------------------------------------------------

Widget _buildEdgeCases() {
  print('Building edge cases');

  // --- Identical rects ---
  final Rect sameRect = Rect.fromLTWH(50, 50, 80, 80);
  final MaterialRectCenterArcTween sameTween = MaterialRectCenterArcTween(
    begin: sameRect,
    end: sameRect,
  );
  final Rect sameMid = sameTween.lerp(0.5);

  // --- Very close rects ---
  final Rect nearBegin = Rect.fromLTWH(100, 100, 60, 60);
  final Rect nearEnd = Rect.fromLTWH(103, 98, 62, 61);
  final MaterialRectCenterArcTween nearTween = MaterialRectCenterArcTween(
    begin: nearBegin,
    end: nearEnd,
  );
  final Rect nearMid = nearTween.lerp(0.5);

  // --- Horizontal only movement ---
  final Rect horizBegin = Rect.fromLTWH(10, 60, 50, 50);
  final Rect horizEnd = Rect.fromLTWH(250, 60, 50, 50);
  final MaterialRectCenterArcTween horizTween = MaterialRectCenterArcTween(
    begin: horizBegin,
    end: horizEnd,
  );

  List<Widget> horizStack = [];
  for (int i = 0; i <= 8; i++) {
    final double t = i / 8;
    final Rect r = horizTween.lerp(t);
    horizStack.add(
      _buildRectBox(r, Color(0xFF0277BD), label: 't=${t.toStringAsFixed(2)}'),
    );
  }

  // --- Vertical only movement ---
  final Rect vertBegin = Rect.fromLTWH(130, 5, 50, 40);
  final Rect vertEnd = Rect.fromLTWH(130, 140, 50, 40);
  final MaterialRectCenterArcTween vertTween = MaterialRectCenterArcTween(
    begin: vertBegin,
    end: vertEnd,
  );

  List<Widget> vertStack = [];
  for (int i = 0; i <= 8; i++) {
    final double t = i / 8;
    final Rect r = vertTween.lerp(t);
    vertStack.add(
      _buildRectBox(r, Color(0xFF558B2F), label: 't=${t.toStringAsFixed(2)}'),
    );
  }

  // --- Zero-size begin ---
  final Rect zeroBegin = Rect.fromLTWH(150, 100, 0, 0);
  final Rect normalEnd = Rect.fromLTWH(50, 20, 120, 90);
  final MaterialRectCenterArcTween zeroTween = MaterialRectCenterArcTween(
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

  print(
    '  identical rect t=0.5 -> '
    '${_fmtRect(sameMid)}',
  );
  print(
    '  near rect t=0.5 -> '
    '${_fmtRect(nearMid)}',
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Exploring boundary conditions and special configurations.',
        style: TextStyle(fontSize: 13, color: Color(0xFF546E7A)),
      ),
      SizedBox(height: 8),

      // Identical rects
      Text(
        'Identical Rects:',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF37474F),
        ),
      ),
      SizedBox(height: 4),
      _buildInfoCard('begin = end', _fmtRect(sameRect)),
      _buildInfoCard(
        't=0.5 result',
        _fmtRect(sameMid),
      ),
      _buildInfoCard(
        'Observation',
        'When begin equals end, all t values return the same rect.',
      ),
      SizedBox(height: 12),

      // Very close rects
      Text(
        'Very Close Rects:',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF37474F),
        ),
      ),
      SizedBox(height: 4),
      _buildInfoCard('begin', _fmtRect(nearBegin)),
      _buildInfoCard('end', _fmtRect(nearEnd)),
      _buildInfoCard('t=0.5', _fmtRect(nearMid)),
      SizedBox(height: 12),

      // Horizontal only
      Text(
        'Horizontal-Only Movement (same Y):',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0277BD),
        ),
      ),
      SizedBox(height: 4),
      Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(children: horizStack),
      ),
      SizedBox(height: 4),
      _buildInfoCard(
        'Horizontal note',
        'With same Y position, the arc degenerates to a straight line, '
            'or shows minimal curvature depending on the diagonal offset.',
      ),
      SizedBox(height: 12),

      // Vertical only
      Text(
        'Vertical-Only Movement (same X):',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF558B2F),
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
        child: Stack(children: vertStack),
      ),
      SizedBox(height: 4),
      _buildInfoCard(
        'Vertical note',
        'With same X position, the center arc follows a vertical line '
            'or shows only minor horizontal deviation.',
      ),
      SizedBox(height: 12),

      // Zero-size begin
      Text(
        'Zero-Size Begin Rect (point to rect):',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4527A0),
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
      SizedBox(height: 4),
      _buildInfoCard(
        'Zero-size note',
        'Starting from a zero-size rect (a point), the rect expands along '
            'the arc path while growing linearly in size.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 10. Summary & Variant Comparison
// ---------------------------------------------------------------------------

Widget _buildSummary() {
  print('Building summary');

  List<Map<String, String>> summaryItems = [
    {'label': 'Class', 'value': 'MaterialRectCenterArcTween extends RectTween'},
    {
      'label': 'Purpose',
      'value':
          'Interpolates Rects where the center follows a circular arc, '
          'while size changes linearly. Used in Material hero animations.',
    },
    {
      'label': 'Key Property',
      'value':
          'centerArc (MaterialPointArcTween) - the arc path the center '
          'follows',
    },
    {
      'label': 'Size Behavior',
      'value':
          'Width and height interpolate linearly from begin to end values, '
          'independent of the arc path.',
    },
    {
      'label': 'vs RectTween',
      'value':
          'RectTween interpolates everything linearly. '
          'MaterialRectCenterArcTween adds arc curvature to the center path.',
    },
    {
      'label': 'vs MaterialRectArcTween',
      'value':
          'MaterialRectArcTween has CORNERS following independent arcs '
          '(via beginArc/endArc). MaterialRectCenterArcTween has the CENTER '
          'following a single arc. Center-arc gives a "rigid body" sweep, '
          'corner-arc allows shape deformation.',
    },
    {
      'label': 'Same-Size Rects',
      'value': 'Produces a pure arc-based translation (no size change).',
    },
    {
      'label': 'Edge Cases',
      'value':
          'Identical rects return the same rect for all t. Horizontal-only '
          'or vertical-only movement reduces or eliminates arc curvature.',
    },
    {
      'label': 'Sections Shown',
      'value':
          '10 sections covering basic usage, three-way comparison, '
          'centerArc property, same-size translation, size scaling, '
          'center vs corner paths, hero expansion, fine-grained sampling, '
          'edge cases, and this summary.',
    },
  ];

  // Build a mini comparison stack for the summary
  final Rect cmpBegin = Rect.fromLTWH(5, 90, 40, 35);
  final Rect cmpEnd = Rect.fromLTWH(240, 10, 60, 50);

  final RectTween linearTw = RectTween(begin: cmpBegin, end: cmpEnd);
  final MaterialRectArcTween cornerTw = MaterialRectArcTween(
    begin: cmpBegin,
    end: cmpEnd,
  );
  final MaterialRectCenterArcTween centerTw = MaterialRectCenterArcTween(
    begin: cmpBegin,
    end: cmpEnd,
  );

  List<Widget> cmpDots = [];
  for (int i = 0; i <= 30; i++) {
    final double t = i / 30;
    final Rect? linR = linearTw.lerp(t);
    final Rect cornerR = cornerTw.lerp(t);
    final Rect centerR = centerTw.lerp(t);
    if (linR != null) {
      cmpDots.add(_buildDot(linR.center, Color(0xFF1565C0), size: 5.0));
    }
    cmpDots.add(_buildDot(cornerR.center, Color(0xFFC62828), size: 5.0));
    cmpDots.add(_buildDot(centerR.center, Color(0xFF2E7D32), size: 5.0));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...summaryItems.map((item) {
        return _buildInfoCard(item['label']!, item['value']!);
      }),
      SizedBox(height: 12),
      Text(
        'Center path comparison (all three variants):',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 4),
      Row(
        children: [
          _buildRectLabel('Linear', Color(0xFF1565C0)),
          SizedBox(width: 12),
          _buildRectLabel('Corner-Arc', Color(0xFFC62828)),
          SizedBox(width: 12),
          _buildRectLabel('Center-Arc', Color(0xFF2E7D32)),
        ],
      ),
      SizedBox(height: 4),
      Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD)),
        ),
        child: Stack(
          children: [
            _buildRectBox(cmpBegin, Color(0xFF455A64), label: 'begin'),
            _buildRectBox(cmpEnd, Color(0xFF455A64), label: 'end'),
            ...cmpDots,
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFE0F2F1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFF80CBC4)),
        ),
        child: Text(
          'MaterialRectCenterArcTween provides a clean, predictable arc '
          'motion for the center of the rect, making it ideal for hero '
          'animations where the overall shape should sweep smoothly rather '
          'than deform. It is the default createRectTween used by Hero '
          'widgets in Flutter.',
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Color(0xFF004D40),
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Helper class for size configuration entries (Section 5)
// ---------------------------------------------------------------------------

class _SizeConfig {
  final String name;
  final Rect begin;
  final Rect end;
  final Color color;

  _SizeConfig(this.name, this.begin, this.end, this.color);
}
