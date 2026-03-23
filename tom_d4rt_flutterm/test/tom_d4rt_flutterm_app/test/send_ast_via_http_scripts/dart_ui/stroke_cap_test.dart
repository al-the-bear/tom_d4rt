// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for StrokeCap from dart:ui
//
// StrokeCap defines how the ends of lines are drawn when using Paint.
// Three values exist:
//   - StrokeCap.butt   — flat edge exactly at the end point
//   - StrokeCap.round  — semicircular cap extending past the end
//   - StrokeCap.square — square cap extending past the end by half stroke width
//
// Since the d4rt interpreter does not support class definitions, this file
// uses Container decorations, BoxDecoration, and BorderRadius to visually
// simulate the three cap styles, while also configuring real Paint objects
// and printing their strokeCap property for verification.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Paint configuration demonstration — verify StrokeCap values
  // ---------------------------------------------------------------------------
  final Paint paintButt = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..strokeCap = StrokeCap.butt
    ..color = const Color(0xFF000000);

  final Paint paintRound = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..strokeCap = StrokeCap.round
    ..color = const Color(0xFF000000);

  final Paint paintSquare = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..strokeCap = StrokeCap.square
    ..color = const Color(0xFF000000);

  print('=== StrokeCap Deep Demo ===');
  print('paintButt.strokeCap   = ${paintButt.strokeCap}');
  print('paintRound.strokeCap  = ${paintRound.strokeCap}');
  print('paintSquare.strokeCap = ${paintSquare.strokeCap}');
  print('');

  // Verify enum identity
  print(
    'StrokeCap.butt   == StrokeCap.butt   : ${StrokeCap.butt == StrokeCap.butt}',
  );
  print(
    'StrokeCap.round  == StrokeCap.round  : ${StrokeCap.round == StrokeCap.round}',
  );
  print(
    'StrokeCap.square == StrokeCap.square : ${StrokeCap.square == StrokeCap.square}',
  );
  print(
    'StrokeCap.butt   == StrokeCap.round  : ${StrokeCap.butt == StrokeCap.round}',
  );
  print(
    'StrokeCap.butt   == StrokeCap.square : ${StrokeCap.butt == StrokeCap.square}',
  );
  print(
    'StrokeCap.round  == StrokeCap.square : ${StrokeCap.round == StrokeCap.square}',
  );
  print('');

  // Verify index values
  print('StrokeCap.butt.index   = ${StrokeCap.butt.index}');
  print('StrokeCap.round.index  = ${StrokeCap.round.index}');
  print('StrokeCap.square.index = ${StrokeCap.square.index}');
  print('');

  // Verify values list
  print('StrokeCap.values.length = ${StrokeCap.values.length}');
  for (int i = 0; i < StrokeCap.values.length; i++) {
    print('  StrokeCap.values[$i] = ${StrokeCap.values[i]}');
  }
  print('');

  // Verify name property
  print('StrokeCap.butt.name   = ${StrokeCap.butt.name}');
  print('StrokeCap.round.name  = ${StrokeCap.round.name}');
  print('StrokeCap.square.name = ${StrokeCap.square.name}');
  print('');

  // Paint reassignment checks
  final Paint reassignPaint = Paint()..strokeCap = StrokeCap.butt;
  print('Initial strokeCap: ${reassignPaint.strokeCap}');
  reassignPaint.strokeCap = StrokeCap.round;
  print('After set to round: ${reassignPaint.strokeCap}');
  reassignPaint.strokeCap = StrokeCap.square;
  print('After set to square: ${reassignPaint.strokeCap}');
  reassignPaint.strokeCap = StrokeCap.butt;
  print('After set back to butt: ${reassignPaint.strokeCap}');
  print('');

  // Stroke width interaction
  final List<double> widths = [1.0, 2.0, 4.0, 8.0, 12.0, 20.0];
  for (final w in widths) {
    final Paint p = Paint()
      ..strokeWidth = w
      ..strokeCap = StrokeCap.round;
    print('strokeWidth=$w, strokeCap=${p.strokeCap}');
  }
  print('');

  // Default paint strokeCap
  final Paint defaultPaint = Paint();
  print('Default Paint strokeCap: ${defaultPaint.strokeCap}');
  print('Default is butt: ${defaultPaint.strokeCap == StrokeCap.butt}');
  print('');

  // toString representations
  print('StrokeCap.butt.toString()   = ${StrokeCap.butt.toString()}');
  print('StrokeCap.round.toString()  = ${StrokeCap.round.toString()}');
  print('StrokeCap.square.toString() = ${StrokeCap.square.toString()}');
  print('');

  // ---------------------------------------------------------------------------
  // Color palette
  // ---------------------------------------------------------------------------
  const Color buttColor = Color(0xFFE53935);
  const Color roundColor = Color(0xFF43A047);
  const Color squareColor = Color(0xFF1E88E5);
  const Color bgLight = Color(0xFFF5F5F5);
  const Color textDark = Color(0xFF212121);
  const Color headerBg = Color(0xFF37474F);

  // ---------------------------------------------------------------------------
  // Helper-style inline builders
  // ---------------------------------------------------------------------------

  // Builds a thick "line" container simulating a stroke cap style.
  Widget buildCapLine(
    String label,
    Color color,
    double height,
    double width,
    BorderRadius radius, {
    double extraWidth = 0.0,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width + extraWidth,
          height: height,
          decoration: BoxDecoration(color: color, borderRadius: radius),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: textDark)),
      ],
    );
  }

  // Builds a section card
  Widget buildSection(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: headerBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }

  // Info box for description text
  Widget buildInfoBox(String text, Color accentColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        border: Border(left: BorderSide(color: accentColor, width: 4)),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, height: 1.5, color: textDark),
      ),
    );
  }

  // Labeled value row
  Widget buildKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, color: textDark),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 1 — Overview of all three StrokeCap values
  // ---------------------------------------------------------------------------
  final Widget section1 = buildSection('1. StrokeCap Overview', [
    buildInfoBox(
      'StrokeCap is an enum in dart:ui that controls how the ends of '
      'stroked lines are rendered. It has exactly three values.',
      Colors.blueGrey,
    ),
    const Divider(),
    // Butt
    Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: buttColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: buttColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 14, height: 14, color: buttColor),
              const SizedBox(width: 8),
              const Text(
                'StrokeCap.butt',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Flat edge exactly at the start/end point of the line. '
            'No extension beyond the endpoint. This is the default '
            'strokeCap value for a new Paint object.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 4),
          buildKeyValue('Index:', '${StrokeCap.butt.index}'),
          buildKeyValue('Name:', StrokeCap.butt.name),
          buildKeyValue('Is default:', 'Yes'),
        ],
      ),
    ),
    // Round
    Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: roundColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: roundColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: roundColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'StrokeCap.round',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Semicircular extension past the end point. The radius of '
            'the semicircle is half the stroke width, so the line extends '
            'by strokeWidth/2 beyond each endpoint.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 4),
          buildKeyValue('Index:', '${StrokeCap.round.index}'),
          buildKeyValue('Name:', StrokeCap.round.name),
          buildKeyValue('Is default:', 'No'),
        ],
      ),
    ),
    // Square
    Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: squareColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: squareColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 14, height: 14, color: squareColor),
              const SizedBox(width: 8),
              const Text(
                'StrokeCap.square',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Square extension past the end point. Extends by half the '
            'stroke width beyond each endpoint, forming a rectangle. '
            'Similar to butt but with extra length.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 4),
          buildKeyValue('Index:', '${StrokeCap.square.index}'),
          buildKeyValue('Name:', StrokeCap.square.name),
          buildKeyValue('Is default:', 'No'),
        ],
      ),
    ),
  ]);

  // ---------------------------------------------------------------------------
  // SECTION 2 — Visual simulation with thick "lines"
  // ---------------------------------------------------------------------------
  final double lineThickness = 20.0;
  final double lineWidth = 180.0;

  final Widget section2 = buildSection('2. Visual Cap Simulation', [
    buildInfoBox(
      'Thick containers simulate stroked lines. Butt = sharp rectangle, '
      'Round = pill shape with rounded ends, Square = wider rectangle '
      'extending past the guide marks.',
      Colors.deepPurple,
    ),
    const SizedBox(height: 8),
    // Guide markers
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 2, height: 40, color: Colors.grey),
        SizedBox(width: lineWidth - 4),
        Container(width: 2, height: 40, color: Colors.grey),
      ],
    ),
    const Center(
      child: Text(
        '↑ Endpoint markers ↑',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      ),
    ),
    const SizedBox(height: 12),
    // Butt cap line
    Center(
      child: buildCapLine(
        'StrokeCap.butt — ends exactly at markers',
        buttColor,
        lineThickness,
        lineWidth,
        BorderRadius.zero,
      ),
    ),
    const SizedBox(height: 16),
    // Round cap line
    Center(
      child: buildCapLine(
        'StrokeCap.round — semicircle past markers',
        roundColor,
        lineThickness,
        lineWidth,
        BorderRadius.circular(lineThickness / 2),
      ),
    ),
    const SizedBox(height: 16),
    // Square cap line — extra width simulates extension
    Center(
      child: buildCapLine(
        'StrokeCap.square — extends past markers',
        squareColor,
        lineThickness,
        lineWidth,
        BorderRadius.zero,
        extraWidth: lineThickness,
      ),
    ),
    const SizedBox(height: 10),
    buildInfoBox(
      'Notice: The round cap (green) has rounded ends, while the '
      'square cap (blue) is the same as butt but wider — it extends '
      'by half the stroke width on each side.',
      Colors.orange,
    ),
  ]);

  // ---------------------------------------------------------------------------
  // SECTION 3 — StrokeCap with different stroke widths
  // ---------------------------------------------------------------------------
  final List<double> demoWidths = [6.0, 10.0, 16.0, 24.0, 36.0];

  List<Widget> widthRows = [];
  for (final w in demoWidths) {
    print('Building width demo row: strokeWidth=$w');
    widthRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stroke width: ${w.toInt()}px',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Butt
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: w,
                      decoration: const BoxDecoration(color: buttColor),
                    ),
                    const SizedBox(height: 2),
                    const Text('butt', style: TextStyle(fontSize: 10)),
                  ],
                ),
                // Round
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: w,
                      decoration: BoxDecoration(
                        color: roundColor,
                        borderRadius: BorderRadius.circular(w / 2),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text('round', style: TextStyle(fontSize: 10)),
                  ],
                ),
                // Square (extra width)
                Column(
                  children: [
                    Container(
                      width: 100 + w,
                      height: w,
                      decoration: const BoxDecoration(color: squareColor),
                    ),
                    const SizedBox(height: 2),
                    const Text('square', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget section3 = buildSection('3. Stroke Width Variations', [
    buildInfoBox(
      'As stroke width increases, the difference between cap styles '
      'becomes more pronounced. Round caps form larger semicircles, '
      'and square caps extend further beyond endpoints.',
      Colors.teal,
    ),
    ...widthRows,
  ]);

  // ---------------------------------------------------------------------------
  // SECTION 4 — Paint configuration demonstration
  // ---------------------------------------------------------------------------
  final List<Map<String, dynamic>> paintConfigs = [
    {
      'label': 'Thin butt stroke',
      'width': 1.0,
      'cap': StrokeCap.butt,
      'color': buttColor,
    },
    {
      'label': 'Medium round stroke',
      'width': 4.0,
      'cap': StrokeCap.round,
      'color': roundColor,
    },
    {
      'label': 'Thick square stroke',
      'width': 8.0,
      'cap': StrokeCap.square,
      'color': squareColor,
    },
    {
      'label': 'Extra thick round',
      'width': 16.0,
      'cap': StrokeCap.round,
      'color': const Color(0xFF8E24AA),
    },
    {
      'label': 'Hairline butt',
      'width': 0.5,
      'cap': StrokeCap.butt,
      'color': const Color(0xFF6D4C41),
    },
  ];

  List<Widget> paintConfigWidgets = [];
  for (final config in paintConfigs) {
    final Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (config['width'] as double)
      ..strokeCap = config['cap'] as StrokeCap
      ..color = config['color'] as Color;

    print(
      'Paint config: ${config['label']} — '
      'strokeWidth=${p.strokeWidth}, '
      'strokeCap=${p.strokeCap}, '
      'style=${p.style}',
    );

    paintConfigWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgLight,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: (config['color'] as Color).withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: config['color'] as Color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    config['label'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'strokeWidth: ${p.strokeWidth}  |  '
                    'strokeCap: ${p.strokeCap}  |  '
                    'style: ${p.style}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section4 = buildSection('4. Paint Configuration', [
    buildInfoBox(
      'Paint objects can be configured with strokeCap to control how '
      'line endings appear. The default strokeCap is StrokeCap.butt. '
      'Below are various Paint configurations with their properties.',
      Colors.indigo,
    ),
    ...paintConfigWidgets,
    const SizedBox(height: 10),
    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Paint Property Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 6),
          buildKeyValue('Default strokeCap:', '${Paint().strokeCap}'),
          buildKeyValue('Butt index:', '${StrokeCap.butt.index}'),
          buildKeyValue('Round index:', '${StrokeCap.round.index}'),
          buildKeyValue('Square index:', '${StrokeCap.square.index}'),
          buildKeyValue('Total values:', '${StrokeCap.values.length}'),
        ],
      ),
    ),
  ]);

  // ---------------------------------------------------------------------------
  // SECTION 5 — Practical use cases
  // ---------------------------------------------------------------------------
  final Widget section5 = buildSection('5. Practical Use Cases', [
    buildInfoBox(
      'Each StrokeCap style suits different visual requirements. '
      'Choosing the right cap improves the aesthetics and clarity '
      'of drawn elements.',
      Colors.brown,
    ),
    // Butt use cases
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: buttColor.withValues(alpha: 0.05),
        border: Border.all(color: buttColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 40, height: 6, color: buttColor),
              const SizedBox(width: 8),
              const Text(
                'Butt Cap Use Cases',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Grid lines and axis marks: precise alignment with tick marks\n'
            'Technical diagrams: exact start/end positions matter\n'
            'Dashed patterns: clean segment boundaries\n'
            'Rulers and measurement indicators\n'
            'Chart borders and data plot frames',
            style: TextStyle(fontSize: 12, height: 1.6),
          ),
        ],
      ),
    ),
    // Round use cases
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: roundColor.withValues(alpha: 0.05),
        border: Border.all(color: roundColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: roundColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Round Cap Use Cases',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Freehand drawing apps: smooth, natural line endings\n'
            'Progress bars with rounded ends\n'
            'Signature capture: organic pen-like feel\n'
            'Circular gauges and arc indicators\n'
            'Connectors in flowcharts for soft appearance',
            style: TextStyle(fontSize: 12, height: 1.6),
          ),
        ],
      ),
    ),
    // Square use cases
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: squareColor.withValues(alpha: 0.05),
        border: Border.all(color: squareColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 44, height: 6, color: squareColor),
              const SizedBox(width: 8),
              const Text(
                'Square Cap Use Cases',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Thick border highlights: extended visual weight\n'
            'Bracket-style annotations in documents\n'
            'Timeline markers with visual emphasis\n'
            'Selection indicators that slightly overshoot\n'
            'Cross-hatch patterns where overlap is desired',
            style: TextStyle(fontSize: 12, height: 1.6),
          ),
        ],
      ),
    ),
    // Visual comparison of use case styles
    const SizedBox(height: 6),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Dashed line with butt (precise segments)
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 12, height: 4, color: buttColor),
                const SizedBox(width: 4),
                Container(width: 12, height: 4, color: buttColor),
                const SizedBox(width: 4),
                Container(width: 12, height: 4, color: buttColor),
                const SizedBox(width: 4),
                Container(width: 12, height: 4, color: buttColor),
              ],
            ),
            const SizedBox(height: 4),
            const Text('Dashed (butt)', style: TextStyle(fontSize: 10)),
          ],
        ),
        // Progress bar with round cap
        Column(
          children: [
            Container(
              width: 60,
              height: 8,
              decoration: BoxDecoration(
                color: roundColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 4),
            const Text('Progress (round)', style: TextStyle(fontSize: 10)),
          ],
        ),
        // Extended bracket with square cap
        Column(
          children: [
            Container(width: 56, height: 6, color: squareColor),
            const SizedBox(height: 4),
            const Text('Bracket (square)', style: TextStyle(fontSize: 10)),
          ],
        ),
      ],
    ),
  ]);

  // ---------------------------------------------------------------------------
  // SECTION 6 — Comparison grid
  // ---------------------------------------------------------------------------
  final List<double> gridWidths = [4.0, 8.0, 14.0, 22.0, 32.0];

  List<Widget> gridRows = [];
  // Header row
  gridRows.add(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: headerBg.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              'Width',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Butt',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: buttColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Round',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: roundColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Square',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: squareColor,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (final gw in gridWidths) {
    print('Grid row: width=${gw.toInt()}');
    gridRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                '${gw.toInt()}px',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 70,
                  height: gw,
                  decoration: const BoxDecoration(color: buttColor),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 70,
                  height: gw,
                  decoration: BoxDecoration(
                    color: roundColor,
                    borderRadius: BorderRadius.circular(gw / 2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 70 + gw,
                  height: gw,
                  decoration: const BoxDecoration(color: squareColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section6 = buildSection('6. Comparison Grid', [
    buildInfoBox(
      'Side-by-side comparison of all three StrokeCap values at '
      'different stroke widths. As width increases, the round cap\'s '
      'semicircle and the square cap\'s extension become clearly visible.',
      Colors.deepOrange,
    ),
    ...gridRows,
    const SizedBox(height: 12),
    // Legend
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Legend',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(width: 20, height: 10, color: buttColor),
              const SizedBox(width: 6),
              const Text(
                'Butt: exact length, sharp edges',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 20,
                height: 10,
                decoration: BoxDecoration(
                  color: roundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Round: rounded ends, same base length',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 24, height: 10, color: squareColor),
              const SizedBox(width: 6),
              const Text(
                'Square: extended length, sharp edges',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    ),
  ]);

  // ---------------------------------------------------------------------------
  // SECTION 7 — Enum behavior and edge cases
  // ---------------------------------------------------------------------------
  print('=== StrokeCap Enum Behavior ===');
  print('Iterating StrokeCap.values:');
  for (final cap in StrokeCap.values) {
    print('  $cap  index=${cap.index}  name=${cap.name}');
  }
  print('');

  // StrokeCap in a conditional check
  final StrokeCap testCap = StrokeCap.round;
  if (testCap == StrokeCap.butt) {
    print('testCap is butt');
  } else if (testCap == StrokeCap.round) {
    print('testCap is round');
  } else if (testCap == StrokeCap.square) {
    print('testCap is square');
  }
  print('');

  // Storing caps in a list
  final List<StrokeCap> capList = [
    StrokeCap.butt,
    StrokeCap.round,
    StrokeCap.square,
  ];
  print('capList: $capList');
  print(
    'capList.contains(StrokeCap.round): ${capList.contains(StrokeCap.round)}',
  );
  print(
    'capList.indexOf(StrokeCap.square): ${capList.indexOf(StrokeCap.square)}',
  );
  print('');

  // Map keyed by StrokeCap
  final Map<StrokeCap, String> capDescriptions = {
    StrokeCap.butt: 'Flat end at endpoint',
    StrokeCap.round: 'Semicircular extension',
    StrokeCap.square: 'Rectangular extension',
  };
  for (final entry in capDescriptions.entries) {
    print('${entry.key}: ${entry.value}');
  }
  print('');

  final Widget section7 = buildSection('7. Enum Behavior & Edge Cases', [
    buildInfoBox(
      'StrokeCap behaves like a standard Dart enum. It supports '
      'iteration, indexing, naming, equality checks, and can be used '
      'as map keys or list elements.',
      Colors.cyan,
    ),
    buildKeyValue('values.length:', '${StrokeCap.values.length}'),
    buildKeyValue('butt == butt:', '${StrokeCap.butt == StrokeCap.butt}'),
    buildKeyValue('butt == round:', '${StrokeCap.butt == StrokeCap.round}'),
    buildKeyValue('round == square:', '${StrokeCap.round == StrokeCap.square}'),
    const Divider(),
    const Text(
      'Enum Values Table',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
    const SizedBox(height: 6),
    // Value table
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: headerBg.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Value',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    'Index',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          // butt row
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text('StrokeCap.butt', style: TextStyle(fontSize: 11)),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${StrokeCap.butt.index}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                Expanded(
                  child: Text(
                    StrokeCap.butt.name,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Flat end, no extension',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          // round row
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgLight,
              border: Border(
                top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'StrokeCap.round',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${StrokeCap.round.index}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                Expanded(
                  child: Text(
                    StrokeCap.round.name,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Semicircular past endpoint',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          // square row
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'StrokeCap.square',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${StrokeCap.square.index}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                Expanded(
                  child: Text(
                    StrokeCap.square.name,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Rectangular past endpoint',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);

  // ---------------------------------------------------------------------------
  // SECTION 8 — Vertical line cap comparison
  // ---------------------------------------------------------------------------
  final Widget section8 = buildSection('8. Vertical Line Cap Comparison', [
    buildInfoBox(
      'StrokeCap applies to lines in any orientation. Here the same '
      'three cap styles are shown on vertical lines, highlighting how '
      'round caps add semicircles at top and bottom.',
      Colors.pink,
    ),
    const SizedBox(height: 8),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Butt vertical
        Column(
          children: [
            Container(
              width: 14,
              height: 100,
              decoration: const BoxDecoration(color: buttColor),
            ),
            const SizedBox(height: 6),
            const Text('butt', style: TextStyle(fontSize: 11)),
          ],
        ),
        // Round vertical
        Column(
          children: [
            Container(
              width: 14,
              height: 100,
              decoration: BoxDecoration(
                color: roundColor,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            const SizedBox(height: 6),
            const Text('round', style: TextStyle(fontSize: 11)),
          ],
        ),
        // Square vertical (extra height)
        Column(
          children: [
            Container(
              width: 14,
              height: 114,
              decoration: const BoxDecoration(color: squareColor),
            ),
            const SizedBox(height: 6),
            const Text('square', style: TextStyle(fontSize: 11)),
          ],
        ),
        // Thicker set — Butt vertical thick
        Column(
          children: [
            Container(
              width: 24,
              height: 100,
              decoration: const BoxDecoration(color: buttColor),
            ),
            const SizedBox(height: 6),
            const Text('butt 24', style: TextStyle(fontSize: 11)),
          ],
        ),
        // Round vertical thick
        Column(
          children: [
            Container(
              width: 24,
              height: 100,
              decoration: BoxDecoration(
                color: roundColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 6),
            const Text('round 24', style: TextStyle(fontSize: 11)),
          ],
        ),
        // Square vertical thick
        Column(
          children: [
            Container(
              width: 24,
              height: 124,
              decoration: const BoxDecoration(color: squareColor),
            ),
            const SizedBox(height: 6),
            const Text('square 24', style: TextStyle(fontSize: 11)),
          ],
        ),
      ],
    ),
    const SizedBox(height: 12),
    buildInfoBox(
      'The square cap line is taller than butt by exactly the stroke '
      'width (half on each end). The round cap has the same visual '
      'extension but with semicircular ends.',
      Colors.blueGrey,
    ),
  ]);

  // ---------------------------------------------------------------------------
  // Final summary prints
  // ---------------------------------------------------------------------------
  print('=== Final Summary ===');
  print('StrokeCap.butt   — Default. No extension. Precise endpoints.');
  print('StrokeCap.round  — Semicircle. Extends by strokeWidth/2.');
  print('StrokeCap.square — Rectangle. Extends by strokeWidth/2.');
  print(
    'All three share the same base line length; round and square add extra.',
  );
  print('');
  print('Total StrokeCap values: ${StrokeCap.values.length}');
  print('All values: ${StrokeCap.values}');
  print('=== StrokeCap Deep Demo Complete ===');

  // ---------------------------------------------------------------------------
  // Build the widget tree
  // ---------------------------------------------------------------------------
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF37474F), Color(0xFF546E7A)],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Column(
            children: [
              Text(
                'StrokeCap Deep Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'dart:ui — Line ending styles for Paint strokes',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        const SizedBox(height: 24),
      ],
    ),
  );
}
