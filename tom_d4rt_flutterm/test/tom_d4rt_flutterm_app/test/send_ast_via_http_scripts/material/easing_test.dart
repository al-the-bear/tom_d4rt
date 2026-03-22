// D4rt test script: Tests Easing from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  debugPrint('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
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

Widget _buildInfoCard(String label, String value) {
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

Widget _buildCurveVisualization(
  String name,
  Curve curve,
  Color color,
  String description,
) {
  debugPrint('Building curve visualization: $name');

  List<Widget> dots = [];
  for (int i = 0; i <= 20; i = i + 1) {
    double t = i / 20.0;
    double val = curve.transform(t);
    double xPos = t * 240;
    double yPos = (1.0 - val) * 80;
    dots.add(
      Positioned(
        left: xPos + 20,
        top: yPos + 10,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }

  List<Widget> lineSegments = [];
  for (int i = 0; i < 20; i = i + 1) {
    double t1 = i / 20.0;
    double t2 = (i + 1) / 20.0;
    double val1 = curve.transform(t1);
    double val2 = curve.transform(t2);
    double x1 = t1 * 240 + 24;
    double x2 = t2 * 240 + 24;
    double y1 = (1.0 - val1) * 80 + 14;
    double y2 = (1.0 - val2) * 80 + 14;
    double segWidth = x2 - x1;
    double segHeight = y2 - y1;
    double absHeight = segHeight;
    if (absHeight < 0) {
      absHeight = -absHeight;
    }
    if (absHeight < 1) {
      absHeight = 1;
    }
    lineSegments.add(
      Positioned(
        left: x1,
        top: (y1 < y2) ? y1 : y2,
        child: Container(
          width: segWidth + 1,
          height: absHeight + 1,
          color: color.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  List<Widget> stackChildren = [];
  // Background grid
  stackChildren.add(
    Positioned(
      left: 20,
      top: 10,
      child: Container(
        width: 244,
        height: 84,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade50,
        ),
      ),
    ),
  );
  // Horizontal midline
  stackChildren.add(
    Positioned(
      left: 20,
      top: 50,
      child: Container(width: 244, height: 1, color: Colors.grey.shade200),
    ),
  );
  // Vertical midline
  stackChildren.add(
    Positioned(
      left: 142,
      top: 10,
      child: Container(width: 1, height: 84, color: Colors.grey.shade200),
    ),
  );
  for (int s = 0; s < lineSegments.length; s = s + 1) {
    stackChildren.add(lineSegments[s]);
  }
  for (int d = 0; d < dots.length; d = d + 1) {
    stackChildren.add(dots[d]);
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 280,
          height: 100,
          child: Stack(children: stackChildren),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              '0.0',
              style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
            ),
            SizedBox(width: 100),
            Text(
              't',
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(width: 100),
            Text(
              '1.0',
              style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStandardEasings() {
  debugPrint('Building standard easings');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildCurveVisualization(
        'Easing.standard',
        Easing.standard,
        Colors.blue.shade600,
        'Default easing for most transitions - starts slow, speeds up, then slows down',
      ),
      _buildCurveVisualization(
        'Easing.standardAccelerate',
        Easing.standardAccelerate,
        Colors.blue.shade400,
        'Elements leaving the screen - starts slow then accelerates',
      ),
      _buildCurveVisualization(
        'Easing.standardDecelerate',
        Easing.standardDecelerate,
        Colors.blue.shade800,
        'Elements entering the screen - starts fast then decelerates',
      ),
    ],
  );
}

Widget _buildEmphasizedEasings() {
  debugPrint('Building emphasized easings');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildCurveVisualization(
        'Curves.easeInOutCubicEmphasized',
        Curves.easeInOutCubicEmphasized,
        Colors.purple.shade600,
        'More dramatic version of standard - stronger deceleration at end',
      ),
      _buildCurveVisualization(
        'Curves.easeInCubic',
        Curves.easeInCubic,
        Colors.purple.shade400,
        'Dramatic exit - elements leave with strong acceleration',
      ),
      _buildCurveVisualization(
        'Curves.easeOutCubic',
        Curves.easeOutCubic,
        Colors.purple.shade800,
        'Dramatic entry - elements arrive with strong deceleration',
      ),
    ],
  );
}

Widget _buildLegacyEasings() {
  debugPrint('Building legacy easings');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildCurveVisualization(
        'Easing.legacy',
        Easing.legacy,
        Colors.orange.shade600,
        'Material Design 2 standard curve - cubic bezier(0.4, 0.0, 0.2, 1.0)',
      ),
      _buildCurveVisualization(
        'Easing.legacyAccelerate',
        Easing.legacyAccelerate,
        Colors.orange.shade400,
        'Material Design 2 accelerate - cubic bezier(0.4, 0.0, 1.0, 1.0)',
      ),
      _buildCurveVisualization(
        'Easing.legacyDecelerate',
        Easing.legacyDecelerate,
        Colors.orange.shade800,
        'Material Design 2 decelerate - cubic bezier(0.0, 0.0, 0.2, 1.0)',
      ),
    ],
  );
}

Widget _buildLinearEasing() {
  debugPrint('Building linear easing');
  return _buildCurveVisualization(
    'Easing.linear',
    Easing.linear,
    Colors.grey.shade600,
    'Constant speed - no acceleration or deceleration. Useful for color fades.',
  );
}

Widget _buildSampleValuesTable(String name, Curve curve, Color headerColor) {
  debugPrint('Building sample values for: $name');
  List<double> timePoints = [
    0.0,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0,
  ];

  List<Widget> headerRow = [
    Container(
      width: 60,
      height: 30,
      alignment: Alignment.center,
      color: headerColor,
      child: Text(
        't',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    Container(
      width: 80,
      height: 30,
      alignment: Alignment.center,
      color: headerColor,
      child: Text(
        'value',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    Container(
      width: 80,
      height: 30,
      alignment: Alignment.center,
      color: headerColor,
      child: Text(
        '% done',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ];

  List<Widget> rows = [];
  rows.add(Row(children: headerRow));

  for (int i = 0; i < timePoints.length; i = i + 1) {
    double t = timePoints[i];
    double val = curve.transform(t);
    int pctDone = (val * 100).toInt();
    Color rowBg = (i % 2 == 0) ? Colors.grey.shade50 : Colors.white;
    rows.add(
      Row(
        children: [
          Container(
            width: 60,
            height: 26,
            alignment: Alignment.center,
            color: rowBg,
            child: Text('$t', style: TextStyle(fontSize: 10)),
          ),
          Container(
            width: 80,
            height: 26,
            alignment: Alignment.center,
            color: rowBg,
            child: Text(val.toStringAsFixed(3), style: TextStyle(fontSize: 10)),
          ),
          Container(
            width: 80,
            height: 26,
            alignment: Alignment.center,
            color: rowBg,
            child: Text('$pctDone%', style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: headerColor,
            ),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildComparisonGrid() {
  debugPrint('Building comparison grid');
  List<String> names = [
    'standard',
    'standardAccelerate',
    'standardDecelerate',
    'easeInOutCubicEmphasized',
    'easeInCubic',
    'easeOutCubic',
    'linear',
    'legacy',
    'legacyAccelerate',
    'legacyDecelerate',
  ];
  List<Curve> curves = [
    Easing.standard,
    Easing.standardAccelerate,
    Easing.standardDecelerate,
    Curves.easeInOutCubicEmphasized,
    Curves.easeInCubic,
    Curves.easeOutCubic,
    Easing.linear,
    Easing.legacy,
    Easing.legacyAccelerate,
    Easing.legacyDecelerate,
  ];
  List<Color> colors = [
    Colors.blue.shade600,
    Colors.blue.shade400,
    Colors.blue.shade800,
    Colors.purple.shade600,
    Colors.purple.shade400,
    Colors.purple.shade800,
    Colors.grey.shade600,
    Colors.orange.shade600,
    Colors.orange.shade400,
    Colors.orange.shade800,
  ];
  List<String> families = [
    'Standard',
    'Standard',
    'Standard',
    'Emphasized',
    'Emphasized',
    'Emphasized',
    'Linear',
    'Legacy',
    'Legacy',
    'Legacy',
  ];

  List<Widget> items = [];
  for (int i = 0; i < names.length; i = i + 1) {
    double midVal = curves[i].transform(0.5);
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors[i].withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: colors[i],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 140,
              child: Text(
                names[i],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 55,
              child: Text(
                families[i],
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'mid: ${midVal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 10, color: colors[i]),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Easing Curves Overview',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Mid-point value shows how much progress at t=0.5',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: items),
      ],
    ),
  );
}

Widget _buildMotionBars() {
  debugPrint('Building motion bars');
  List<String> names = [
    'standard',
    'easeInOutCubicEmphasized',
    'linear',
    'legacy',
  ];
  List<Curve> curves = [
    Easing.standard,
    Curves.easeInOutCubicEmphasized,
    Easing.linear,
    Easing.legacy,
  ];
  List<Color> colors = [
    Colors.blue.shade600,
    Colors.purple.shade600,
    Colors.grey.shade600,
    Colors.orange.shade600,
  ];

  List<Widget> bars = [];
  for (int ci = 0; ci < names.length; ci = ci + 1) {
    List<Widget> segments = [];
    for (int s = 0; s < 10; s = s + 1) {
      double t = s / 10.0;
      double val = curves[ci].transform(t);
      double nextVal = curves[ci].transform((s + 1) / 10.0);
      double diff = nextVal - val;
      if (diff < 0) {
        diff = -diff;
      }
      double opacity = 0.2 + (diff * 4.0);
      if (opacity > 1.0) {
        opacity = 1.0;
      }
      segments.add(
        Expanded(
          child: Container(
            height: 24,
            margin: EdgeInsets.symmetric(horizontal: 1),
            color: colors[ci].withValues(alpha: opacity),
          ),
        ),
      );
    }
    bars.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              names[ci],
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: colors[ci],
              ),
            ),
            SizedBox(height: 2),
            Row(children: segments),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'slow',
                  style: TextStyle(fontSize: 8, color: Colors.grey.shade500),
                ),
                Text(
                  'fast',
                  style: TextStyle(fontSize: 8, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Motion Speed Visualization',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Brighter segments = faster motion at that time point',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: bars),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('Easing deep demo test executing');
  debugPrint('=== Easing Visual Demo ===');
  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Easing Deep Demo'),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Standard Easing Curves'),
            _buildStandardEasings(),
            SizedBox(height: 16),
            _buildSectionHeader('2. Emphasized Easing Curves'),
            _buildEmphasizedEasings(),
            SizedBox(height: 16),
            _buildSectionHeader('3. Linear Easing'),
            _buildLinearEasing(),
            SizedBox(height: 16),
            _buildSectionHeader('4. Legacy Easing Curves'),
            _buildLegacyEasings(),
            SizedBox(height: 16),
            _buildSectionHeader('5. Motion Speed Visualization'),
            _buildMotionBars(),
            SizedBox(height: 16),
            _buildSectionHeader('6. All Curves Overview'),
            _buildComparisonGrid(),
            SizedBox(height: 16),
            _buildSectionHeader('7. Sample Values: Standard'),
            _buildSampleValuesTable(
              'Easing.standard',
              Easing.standard,
              Colors.blue.shade600,
            ),
            SizedBox(height: 8),
            _buildSampleValuesTable(
              'Curves.easeInOutCubicEmphasized',
              Curves.easeInOutCubicEmphasized,
              Colors.purple.shade600,
            ),
            SizedBox(height: 8),
            _buildSampleValuesTable(
              'Easing.linear',
              Easing.linear,
              Colors.grey.shade600,
            ),
            SizedBox(height: 8),
            _buildSampleValuesTable(
              'Easing.legacy',
              Easing.legacy,
              Colors.orange.shade600,
            ),
            SizedBox(height: 32),
            _buildInfoCard('Class', 'Easing'),
            _buildInfoCard('Package', 'package:flutter/material.dart'),
            _buildInfoCard(
              'Purpose',
              'Material Design 3 easing curve constants',
            ),
            _buildInfoCard(
              'Families',
              'Standard (3), Emphasized (3), Linear (1), Legacy (3)',
            ),
            _buildInfoCard('Total Constants', '10 easing curves'),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
  print('Easing deep demo completed');
  return result;
}
