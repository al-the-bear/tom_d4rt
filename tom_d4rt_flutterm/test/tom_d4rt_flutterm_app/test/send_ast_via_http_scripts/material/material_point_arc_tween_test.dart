// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialPointArcTween from material
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('=== MaterialPointArcTween Visual Demo ===');
  print('Demonstrating circular arc interpolation between two Offset points');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('MaterialPointArcTween Demo'),
        backgroundColor: Color(0xFF4A148C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Basic Arc Tween'),
            SizedBox(height: 8),
            _buildBasicArcTween(),
            SizedBox(height: 24),
            buildSectionHeader('Straight Line vs Arc Path'),
            SizedBox(height: 8),
            _buildLineVsArc(),
            SizedBox(height: 24),
            buildSectionHeader('Arc Directions'),
            SizedBox(height: 8),
            _buildArcDirections(),
            SizedBox(height: 24),
            buildSectionHeader('Arc Center & Radius'),
            SizedBox(height: 8),
            _buildCenterAndRadius(),
            SizedBox(height: 24),
            buildSectionHeader('Dotted Arc Trail (20 Samples)'),
            SizedBox(height: 8),
            _buildDottedArcTrail(),
            SizedBox(height: 24),
            buildSectionHeader('Short vs Long Arcs'),
            SizedBox(height: 8),
            _buildShortVsLongArcs(),
            SizedBox(height: 24),
            buildSectionHeader('Begin & End Angles'),
            SizedBox(height: 8),
            _buildBeginEndAngles(),
            SizedBox(height: 24),
            buildSectionHeader('Shorter Path Demonstration'),
            SizedBox(height: 8),
            _buildShorterPath(),
            SizedBox(height: 24),
            buildSectionHeader('Multiple Arc Configurations'),
            SizedBox(height: 8),
            _buildMultipleConfigurations(),
            SizedBox(height: 24),
            buildSectionHeader('Properties Summary'),
            SizedBox(height: 8),
            _buildSummary(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// -- Helper widgets --

Widget buildSectionHeader(String title) {
  print('Building section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Color(0xFF4A148C),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDot(double left, double top, Color color, double size) {
  return Positioned(
    left: left - size / 2,
    top: top - size / 2,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    ),
  );
}

Widget _buildLabeledDot(
  double left,
  double top,
  Color color,
  double size,
  String label,
) {
  return Positioned(
    left: left - size / 2,
    top: top - size / 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 9, color: color),
        ),
      ],
    ),
  );
}

Widget _buildCanvasBox(double width, double height, List<Widget> children) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      border: Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: children,
    ),
  );
}

// -- Section 1: Basic Arc Tween --

Widget _buildBasicArcTween() {
  print('Section 1: Basic arc tween from (20,20) to (220,220)');
  final MaterialPointArcTween arcTween = MaterialPointArcTween(
    begin: Offset(20, 20),
    end: Offset(220, 220),
  );

  // Sample at key t values
  final List<double> tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  final List<Color> dotColors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  List<Widget> dots = [];
  for (int i = 0; i < tValues.length; i++) {
    final double t = tValues[i];
    final Offset pt = arcTween.transform(t);
    print('  t=$t -> (${pt.dx.toStringAsFixed(1)}, ${pt.dy.toStringAsFixed(1)})');
    dots.add(_buildLabeledDot(pt.dx, pt.dy, dotColors[i], 14, 't=$t'));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Arc from Offset(20,20) to Offset(220,220)',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 8),
      _buildCanvasBox(260, 260, dots),
      SizedBox(height: 8),
      buildInfoCard('Begin', '${arcTween.begin}'),
      buildInfoCard('End', '${arcTween.end}'),
      buildInfoCard(
        'Note',
        'Points sampled at t=0, 0.25, 0.5, 0.75, 1.0 along a circular arc',
      ),
    ],
  );
}

// -- Section 2: Straight Line vs Arc Path --

Widget _buildLineVsArc() {
  print('Section 2: Straight line vs arc path comparison');
  final Offset start = Offset(20, 180);
  final Offset finish = Offset(220, 20);

  final Tween<Offset> linearTween = Tween<Offset>(begin: start, end: finish);
  final MaterialPointArcTween arcTween = MaterialPointArcTween(
    begin: start,
    end: finish,
  );

  final int steps = 30;
  List<Widget> children = [];

  // Linear path dots (blue)
  for (int i = 0; i <= steps; i++) {
    final double t = i / steps;
    final Offset pt = linearTween.transform(t);
    children.add(_buildDot(pt.dx, pt.dy, Colors.blue.shade400, 6));
  }

  // Arc path dots (red)
  for (int i = 0; i <= steps; i++) {
    final double t = i / steps;
    final Offset pt = arcTween.transform(t);
    children.add(_buildDot(pt.dx, pt.dy, Colors.red.shade600, 6));
  }

  // Start and end markers
  children.add(_buildLabeledDot(start.dx, start.dy, Colors.green, 14, 'Start'));
  children.add(
    _buildLabeledDot(finish.dx, finish.dy, Colors.purple, 14, 'End'),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6),
          Text('Straight line (Tween<Offset>)'),
          SizedBox(width: 16),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6),
          Text('Arc (MaterialPointArcTween)'),
        ],
      ),
      SizedBox(height: 8),
      _buildCanvasBox(260, 220, children),
      SizedBox(height: 8),
      buildInfoCard(
        'Comparison',
        'The blue dots follow a straight diagonal line while red dots '
            'curve along a circular arc — the Material Design hero path.',
      ),
    ],
  );
}

// -- Section 3: Arc Directions --

Widget _buildArcDirections() {
  print('Section 3: Various arc directions');

  final List<Map<String, dynamic>> configs = [
    {
      'label': 'Top-left to Bottom-right',
      'begin': Offset(20, 20),
      'end': Offset(130, 130),
      'color': Colors.red,
    },
    {
      'label': 'Top-right to Bottom-left',
      'begin': Offset(130, 20),
      'end': Offset(20, 130),
      'color': Colors.blue,
    },
    {
      'label': 'Vertical (top to bottom)',
      'begin': Offset(75, 10),
      'end': Offset(75, 140),
      'color': Colors.green,
    },
    {
      'label': 'Horizontal (left to right)',
      'begin': Offset(10, 75),
      'end': Offset(140, 75),
      'color': Colors.orange,
    },
  ];

  List<Widget> cards = [];
  for (int ci = 0; ci < configs.length; ci++) {
    final Map<String, dynamic> cfg = configs[ci];
    final String lbl = cfg['label'] as String;
    final Offset b = cfg['begin'] as Offset;
    final Offset e = cfg['end'] as Offset;
    final Color c = cfg['color'] as Color;

    final MaterialPointArcTween tween = MaterialPointArcTween(
      begin: b,
      end: e,
    );

    List<Widget> dots = [];
    for (int i = 0; i <= 20; i++) {
      final double t = i / 20;
      final Offset pt = tween.transform(t);
      dots.add(_buildDot(pt.dx, pt.dy, c, 5));
    }
    dots.add(_buildDot(b.dx, b.dy, Colors.black, 10));
    dots.add(_buildDot(e.dx, e.dy, Colors.black, 10));

    print('  Direction: $lbl');
    cards.add(
      Column(
        children: [
          Text(
            lbl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          _buildCanvasBox(155, 155, dots),
        ],
      ),
    );
  }

  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: cards,
  );
}

// -- Section 4: Arc Center & Radius --

Widget _buildCenterAndRadius() {
  print('Section 4: Center and radius properties');

  final MaterialPointArcTween tween1 = MaterialPointArcTween(
    begin: Offset(30, 30),
    end: Offset(200, 180),
  );

  final MaterialPointArcTween tween2 = MaterialPointArcTween(
    begin: Offset(50, 150),
    end: Offset(200, 50),
  );

  final MaterialPointArcTween tween3 = MaterialPointArcTween(
    begin: Offset(20, 100),
    end: Offset(220, 100),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'MaterialPointArcTween computes center, radius, and angles from begin/end:',
        style: TextStyle(fontSize: 13),
      ),
      SizedBox(height: 8),
      _tweenInfoCard('Diagonal Arc', tween1),
      _tweenInfoCard('Upward Arc', tween2),
      _tweenInfoCard('Horizontal Arc', tween3),
    ],
  );
}

Widget _tweenInfoCard(String name, MaterialPointArcTween tw) {
  Offset? center = tw.center;
  double? radius = tw.radius;
  double? beginAngle = tw.beginAngle;
  double? endAngle = tw.endAngle;

  String centerStr =
      center != null
          ? '(${center.dx.toStringAsFixed(1)}, ${center.dy.toStringAsFixed(1)})'
          : 'null';
  String radiusStr = radius != null ? radius.toStringAsFixed(2) : 'null';
  String beginAngleStr =
      beginAngle != null
          ? '${beginAngle.toStringAsFixed(3)} rad (${(beginAngle * 180 / math.pi).toStringAsFixed(1)}deg)'
          : 'null';
  String endAngleStr =
      endAngle != null
          ? '${endAngle.toStringAsFixed(3)} rad (${(endAngle * 180 / math.pi).toStringAsFixed(1)}deg)'
          : 'null';

  print('  $name: center=$centerStr, radius=$radiusStr');
  print('    beginAngle=$beginAngleStr, endAngle=$endAngleStr');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 6),
        _propertyRow('Begin', '${tw.begin}'),
        _propertyRow('End', '${tw.end}'),
        _propertyRow('Center', centerStr),
        _propertyRow('Radius', radiusStr),
        _propertyRow('Begin Angle', beginAngleStr),
        _propertyRow('End Angle', endAngleStr),
      ],
    ),
  );
}

Widget _propertyRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}

// -- Section 5: Dotted Arc Trail (20 samples) --

Widget _buildDottedArcTrail() {
  print('Section 5: Dotted arc trail with 20 sample points');
  final MaterialPointArcTween arcTween = MaterialPointArcTween(
    begin: Offset(30, 200),
    end: Offset(270, 30),
  );

  final int sampleCount = 20;
  List<Widget> dots = [];
  for (int i = 0; i <= sampleCount; i++) {
    final double t = i / sampleCount;
    final Offset pt = arcTween.transform(t);
    // Gradient from deep purple to amber along the arc
    final double ratio = i / sampleCount;
    final int r = (128 + (ratio * 127)).round();
    final int g = (0 + (ratio * 191)).round();
    final int b2 = (128 - (ratio * 128)).round();
    final Color dotColor = Color.fromARGB(255, r, g, b2);
    dots.add(_buildDot(pt.dx, pt.dy, dotColor, 10));
    if (i % 5 == 0) {
      print(
        '  Sample $i: t=${t.toStringAsFixed(2)} -> '
        '(${pt.dx.toStringAsFixed(1)}, ${pt.dy.toStringAsFixed(1)})',
      );
    }
  }

  // Mark start and end with larger circles
  final Offset startPt = arcTween.transform(0);
  final Offset endPt = arcTween.transform(1);
  dots.add(
    _buildLabeledDot(startPt.dx, startPt.dy, Colors.green.shade800, 16, 'BEGIN'),
  );
  dots.add(
    _buildLabeledDot(endPt.dx, endPt.dy, Colors.red.shade800, 16, 'END'),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '21 points sampled from t=0.0 to t=1.0 shown as colored trail:',
        style: TextStyle(fontSize: 13),
      ),
      SizedBox(height: 8),
      _buildCanvasBox(310, 240, dots),
      SizedBox(height: 8),
      buildInfoCard(
        'Trail',
        'Each dot represents one sample along the arc. Color shifts '
            'from purple to amber as t progresses from 0 to 1.',
      ),
    ],
  );
}

// -- Section 6: Short vs Long Arcs --

Widget _buildShortVsLongArcs() {
  print('Section 6: Short arcs (close points) vs long arcs (far apart)');

  // Short arc: points that are very close together
  final MaterialPointArcTween shortArc = MaterialPointArcTween(
    begin: Offset(80, 80),
    end: Offset(95, 85),
  );

  // Medium arc
  final MaterialPointArcTween mediumArc = MaterialPointArcTween(
    begin: Offset(30, 100),
    end: Offset(130, 30),
  );

  // Long arc: points far apart
  final MaterialPointArcTween longArc = MaterialPointArcTween(
    begin: Offset(10, 10),
    end: Offset(270, 200),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _arcVisualization('Short Arc (15px apart)', shortArc, 180, 170, Colors.teal),
      SizedBox(height: 16),
      _arcVisualization('Medium Arc (130px apart)', mediumArc, 180, 140, Colors.indigo),
      SizedBox(height: 16),
      _arcVisualization('Long Arc (350px apart)', longArc, 300, 230, Colors.deepOrange),
      SizedBox(height: 8),
      buildInfoCard(
        'Observation',
        'The radius scales proportionally with the distance between '
            'begin and end points. Short arcs have tight curvature.',
      ),
    ],
  );
}

Widget _arcVisualization(
  String label,
  MaterialPointArcTween tw,
  double w,
  double h,
  Color c,
) {
  List<Widget> dots = [];
  for (int i = 0; i <= 25; i++) {
    final double t = i / 25;
    final Offset pt = tw.transform(t);
    dots.add(_buildDot(pt.dx, pt.dy, c, 5));
  }
  final Offset b = tw.transform(0);
  final Offset e = tw.transform(1);
  dots.add(_buildDot(b.dx, b.dy, Colors.black, 10));
  dots.add(_buildDot(e.dx, e.dy, Colors.black, 10));

  double? radius = tw.radius;
  String radiusStr = radius != null ? radius.toStringAsFixed(1) : 'null';
  print('  $label: radius=$radiusStr');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 4),
      _buildCanvasBox(w, h, dots),
      SizedBox(height: 4),
      Text(
        'Radius: $radiusStr',
        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
      ),
    ],
  );
}

// -- Section 7: Begin & End Angles --

Widget _buildBeginEndAngles() {
  print('Section 7: Begin and end angles visualization');

  final List<Map<String, dynamic>> tweenDefs = [
    {'begin': Offset(30, 120), 'end': Offset(180, 20), 'label': 'Arc A'},
    {'begin': Offset(20, 20), 'end': Offset(170, 150), 'label': 'Arc B'},
    {
      'begin': Offset(100, 10),
      'end': Offset(100, 160),
      'label': 'Arc C (vertical)',
    },
  ];

  List<Widget> items = [];
  for (int idx = 0; idx < tweenDefs.length; idx++) {
    final Map<String, dynamic> def = tweenDefs[idx];
    final Offset b = def['begin'] as Offset;
    final Offset e = def['end'] as Offset;
    final String label = def['label'] as String;

    final MaterialPointArcTween tw = MaterialPointArcTween(begin: b, end: e);
    double? beginAngle = tw.beginAngle;
    double? endAngle = tw.endAngle;

    String beginDeg =
        beginAngle != null
            ? '${(beginAngle * 180 / math.pi).toStringAsFixed(1)}deg'
            : 'N/A';
    String endDeg =
        endAngle != null
            ? '${(endAngle * 180 / math.pi).toStringAsFixed(1)}deg'
            : 'N/A';

    print('  $label: beginAngle=$beginDeg, endAngle=$endDeg');

    // Build dot trail
    List<Widget> dots = [];
    for (int i = 0; i <= 20; i++) {
      final double t = i / 20;
      final Offset pt = tw.transform(t);
      dots.add(_buildDot(pt.dx, pt.dy, Colors.deepPurple.shade300, 5));
    }
    dots.add(
      _buildLabeledDot(b.dx, b.dy, Colors.green.shade700, 12, beginDeg),
    );
    dots.add(
      _buildLabeledDot(e.dx, e.dy, Colors.red.shade700, 12, endDeg),
    );

    // Show center if available
    Offset? center = tw.center;
    if (center != null) {
      dots.add(_buildDot(center.dx, center.dy, Colors.amber.shade700, 8));
      dots.add(
        Positioned(
          left: center.dx + 6,
          top: center.dy - 6,
          child: Text(
            'C',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade900,
            ),
          ),
        ),
      );
    }

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label  |  begin: $beginDeg  |  end: $endDeg',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            _buildCanvasBox(210, 180, dots),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4),
          Text('Begin (angle label)', style: TextStyle(fontSize: 12)),
          SizedBox(width: 12),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4),
          Text('End (angle label)', style: TextStyle(fontSize: 12)),
          SizedBox(width: 12),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.amber.shade700,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4),
          Text('Center (C)', style: TextStyle(fontSize: 12)),
        ],
      ),
      SizedBox(height: 8),
      ...items,
    ],
  );
}

// -- Section 8: Shorter Path Demonstration --

Widget _buildShorterPath() {
  print('Section 8: The arc always takes the shorter path');

  // Two tweens with swapped begin/end to show the arc direction changes
  final MaterialPointArcTween forward = MaterialPointArcTween(
    begin: Offset(30, 30),
    end: Offset(200, 170),
  );
  final MaterialPointArcTween reverse = MaterialPointArcTween(
    begin: Offset(200, 170),
    end: Offset(30, 30),
  );

  List<Widget> children = [];

  // Forward arc (orange)
  for (int i = 0; i <= 30; i++) {
    final double t = i / 30;
    final Offset pt = forward.transform(t);
    children.add(_buildDot(pt.dx, pt.dy, Colors.orange, 5));
  }

  // Reverse arc (cyan)
  for (int i = 0; i <= 30; i++) {
    final double t = i / 30;
    final Offset pt = reverse.transform(t);
    children.add(_buildDot(pt.dx, pt.dy, Colors.cyan, 5));
  }

  children.add(_buildLabeledDot(30, 30, Colors.black, 12, 'A'));
  children.add(_buildLabeledDot(200, 170, Colors.black, 12, 'B'));

  // Also show same-begin/end tween (no arc)
  final MaterialPointArcTween samePoint = MaterialPointArcTween(
    begin: Offset(100, 100),
    end: Offset(100, 100),
  );
  final Offset samePt = samePoint.transform(0.5);
  print(
    '  Same-point tween at t=0.5: '
    '(${samePt.dx.toStringAsFixed(1)}, ${samePt.dy.toStringAsFixed(1)})',
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4),
          Text('A -> B (forward)', style: TextStyle(fontSize: 12)),
          SizedBox(width: 16),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4),
          Text('B -> A (reverse)', style: TextStyle(fontSize: 12)),
        ],
      ),
      SizedBox(height: 8),
      _buildCanvasBox(250, 210, children),
      SizedBox(height: 8),
      buildInfoCard(
        'Shorter Path',
        'Swapping begin and end reverses the arc direction. '
            'The arc always curves away from the diagonal, choosing '
            'the path determined by the Material Design spec.',
      ),
      buildInfoCard(
        'Same Point',
        'When begin == end, the tween returns that same point. '
            'At t=0.5: (${samePt.dx.toStringAsFixed(1)}, ${samePt.dy.toStringAsFixed(1)})',
      ),
    ],
  );
}

// -- Section 9: Multiple Arc Configurations --

Widget _buildMultipleConfigurations() {
  print('Section 9: Multiple arc configurations overlaid');

  final List<Map<String, dynamic>> configs = [
    {
      'begin': Offset(20, 200),
      'end': Offset(200, 20),
      'color': Colors.red.shade400,
      'label': 'Bottom-left to Top-right',
    },
    {
      'begin': Offset(20, 20),
      'end': Offset(200, 200),
      'color': Colors.blue.shade400,
      'label': 'Top-left to Bottom-right',
    },
    {
      'begin': Offset(110, 10),
      'end': Offset(110, 210),
      'color': Colors.green.shade400,
      'label': 'Center-top to Center-bottom',
    },
    {
      'begin': Offset(10, 110),
      'end': Offset(210, 110),
      'color': Colors.amber.shade700,
      'label': 'Left to Right',
    },
  ];

  List<Widget> allDots = [];
  List<Widget> legendItems = [];

  for (int ci = 0; ci < configs.length; ci++) {
    final Map<String, dynamic> cfg = configs[ci];
    final Offset b = cfg['begin'] as Offset;
    final Offset e = cfg['end'] as Offset;
    final Color c = cfg['color'] as Color;
    final String lbl = cfg['label'] as String;

    final MaterialPointArcTween tw = MaterialPointArcTween(begin: b, end: e);

    for (int i = 0; i <= 30; i++) {
      final double t = i / 30;
      final Offset pt = tw.transform(t);
      allDots.add(_buildDot(pt.dx, pt.dy, c, 4));
    }
    allDots.add(_buildDot(b.dx, b.dy, c.withAlpha(200), 10));
    allDots.add(_buildDot(e.dx, e.dy, c.withAlpha(200), 10));

    print('  Config $ci: $lbl');
    legendItems.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6),
            Text(lbl, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(spacing: 16, runSpacing: 4, children: legendItems),
      SizedBox(height: 8),
      _buildCanvasBox(230, 230, allDots),
      SizedBox(height: 8),
      buildInfoCard(
        'Overlay',
        'Four different arc tweens drawn on the same canvas. '
            'Each arc curves away from the straight diagonal between '
            'its begin and end points.',
      ),
    ],
  );
}

// -- Section 10: Properties Summary --

Widget _buildSummary() {
  print('Section 10: Properties summary');

  final MaterialPointArcTween example = MaterialPointArcTween(
    begin: Offset(50, 50),
    end: Offset(250, 200),
  );

  Offset? center = example.center;
  double? radius = example.radius;
  double? beginAngle = example.beginAngle;
  double? endAngle = example.endAngle;

  String centerStr =
      center != null
          ? '(${center.dx.toStringAsFixed(2)}, ${center.dy.toStringAsFixed(2)})'
          : 'null';
  String radiusStr = radius != null ? radius.toStringAsFixed(2) : 'null';
  String beginAngleStr =
      beginAngle != null ? '${beginAngle.toStringAsFixed(4)} rad' : 'null';
  String endAngleStr =
      endAngle != null ? '${endAngle.toStringAsFixed(4)} rad' : 'null';

  print('  Summary tween: center=$centerStr, radius=$radiusStr');
  print('  beginAngle=$beginAngleStr, endAngle=$endAngleStr');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MaterialPointArcTween Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
            Divider(color: Colors.purple.shade200),
            SizedBox(height: 4),
            _propertyRow('Class', 'MaterialPointArcTween'),
            _propertyRow('Extends', 'Tween<Offset>'),
            _propertyRow('Purpose', 'Hero arc interpolation'),
            Divider(color: Colors.purple.shade100),
            _propertyRow('begin', '${example.begin}'),
            _propertyRow('end', '${example.end}'),
            _propertyRow('center', centerStr),
            _propertyRow('radius', radiusStr),
            _propertyRow('beginAngle', beginAngleStr),
            _propertyRow('endAngle', endAngleStr),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueGrey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Behaviors',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
            SizedBox(height: 8),
            _bulletPoint('lerp(t) returns an Offset along the circular arc'),
            _bulletPoint('At t=0 returns begin, at t=1 returns end'),
            _bulletPoint(
              'The arc curves perpendicular to the begin-end line',
            ),
            _bulletPoint('center and radius define the arc circle geometry'),
            _bulletPoint('beginAngle/endAngle are angles from the center'),
            _bulletPoint(
              'Used internally by Hero animations in Material Design',
            ),
            _bulletPoint(
              'Swapping begin/end reverses the arc curvature direction',
            ),
            _bulletPoint('When begin == end, lerp returns that same point'),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Usage Pattern',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'MaterialPointArcTween arcTween = MaterialPointArcTween(\n'
              '  begin: Offset(startX, startY),\n'
              '  end: Offset(endX, endY),\n'
              ');\n'
              'Offset midpoint = arcTween.lerp(0.5);',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _bulletPoint(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  *  ',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13))),
      ],
    ),
  );
}
