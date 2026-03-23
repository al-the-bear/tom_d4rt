// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderFractionallySizedOverflowBox via FractionallySizedBox
// Tests fractional sizing, overflow, alignment, and comparison with SizedBox
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderFractionallySizedOverflowBox Deep Demo ===');
  print('FractionallySizedBox sizes child as a fraction of parent constraints');

  // Color palette for visual sections
  List<Color> sectionColors = [
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
    Colors.pink,
  ];

  // Width factors to demonstrate
  List<double> widthFactors = [0.25, 0.5, 0.75, 1.0, 1.5];
  print('Width factors to demo: $widthFactors');

  // Height factors to demonstrate
  List<double> heightFactors = [0.2, 0.4, 0.6, 0.8, 1.0, 1.2];
  print('Height factors to demo: $heightFactors');

  // Alignment values to demonstrate
  List<Alignment> alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];
  print('Alignment values count: ${alignments.length}');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        _buildHeader(),

        SizedBox(height: 16),

        // Section 1: Width factor variations
        _buildSectionTitle('1. Width Factor Variations', sectionColors[0]),
        _buildWidthFactorSection(widthFactors, sectionColors[0]),

        SizedBox(height: 24),

        // Section 2: Height factor variations
        _buildSectionTitle('2. Height Factor Variations', sectionColors[1]),
        _buildHeightFactorSection(heightFactors, sectionColors[1]),

        SizedBox(height: 24),

        // Section 3: Alignment variations
        _buildSectionTitle('3. Alignment Variations', sectionColors[2]),
        _buildAlignmentSection(alignments, sectionColors[2]),

        SizedBox(height: 24),

        // Section 4: Combined width and height factors
        _buildSectionTitle(
          '4. Combined Width + Height Factors',
          sectionColors[3],
        ),
        _buildCombinedFactorsSection(sectionColors[3]),

        SizedBox(height: 24),

        // Section 5: Null factor behavior
        _buildSectionTitle('5. Null Factor Behavior', sectionColors[4]),
        _buildNullFactorSection(sectionColors[4]),

        SizedBox(height: 24),

        // Section 6: As Expanded alternative in Row/Column
        _buildSectionTitle(
          '6. FractionallySizedBox in Row/Column',
          sectionColors[5],
        ),
        _buildRowColumnSection(sectionColors[5]),

        SizedBox(height: 24),

        // Section 7: Overflow with factor > 1.0
        _buildSectionTitle('7. Overflow (factor > 1.0)', sectionColors[6]),
        _buildOverflowSection(sectionColors[6]),

        SizedBox(height: 24),

        // Section 8: Comparison with SizedBox variants
        _buildSectionTitle(
          '8. Comparison: SizedBox.expand / SizedBox.shrink',
          sectionColors[7],
        ),
        _buildComparisonSection(sectionColors[7]),

        SizedBox(height: 24),

        // Section 9: Nested FractionallySizedBox
        _buildSectionTitle('9. Nested FractionallySizedBox', sectionColors[8]),
        _buildNestedSection(sectionColors[8]),

        SizedBox(height: 24),

        // Section 10: Practical use cases
        _buildSectionTitle('10. Practical Use Cases', sectionColors[9]),
        _buildPracticalSection(sectionColors[9]),

        SizedBox(height: 32),
      ],
    ),
  );
}

Widget _buildHeader() {
  print('Building header gradient banner');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.indigo, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      children: [
        Text(
          'FractionallySizedBox',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'RenderFractionallySizedOverflowBox Deep Demo',
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        SizedBox(height: 8),
        Text(
          'Sizes child to a fraction of parent constraints',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, Color color) {
  print('Section: $title');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
    ),
  );
}

Widget _buildWidthFactorSection(List<double> factors, Color color) {
  print('Building width factor section with ${factors.length} factors');
  List<Widget> children = [];

  for (int i = 0; i < factors.length; i++) {
    double factor = factors[i];
    print('  widthFactor: $factor');
    children.add(_buildLabel('widthFactor: $factor'));
    children.add(
      Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.shade100,
        ),
        child: FractionallySizedBox(
          widthFactor: factor,
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.3 + (i * 0.14)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${(factor * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    children.add(SizedBox(height: 6));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: children,
  );
}

Widget _buildHeightFactorSection(List<double> factors, Color color) {
  print('Building height factor section with ${factors.length} factors');
  List<Widget> rowChildren = [];

  for (int i = 0; i < factors.length; i++) {
    double factor = factors[i];
    print('  heightFactor: $factor');
    rowChildren.add(
      Expanded(
        child: Column(
          children: [
            Text(
              '${factor}x',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.shade50,
              ),
              child: FractionallySizedBox(
                heightFactor: factor,
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.4 + (i * 0.1)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${(factor * 100).toInt()}%',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (i < factors.length - 1) {
      rowChildren.add(SizedBox(width: 4));
    }
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: rowChildren,
    ),
  );
}

Widget _buildAlignmentSection(List<Alignment> alignments, Color color) {
  print('Building alignment section with ${alignments.length} alignments');
  List<String> alignmentNames = [
    'topLeft',
    'topCenter',
    'topRight',
    'centerLeft',
    'center',
    'centerRight',
    'bottomLeft',
    'bottomCenter',
    'bottomRight',
  ];

  List<Widget> rows = [];
  for (int row = 0; row < 3; row++) {
    List<Widget> cells = [];
    for (int col = 0; col < 3; col++) {
      int idx = row * 3 + col;
      Alignment alignment = alignments[idx];
      String name = alignmentNames[idx];
      print('  alignment: $name');
      cells.add(
        Expanded(
          child: Container(
            height: 100,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.shade50,
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  alignment: alignment,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  left: 0,
                  right: 0,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    rows.add(Row(children: cells));
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(children: rows),
  );
}

Widget _buildCombinedFactorsSection(Color color) {
  print('Building combined factors section');
  List<List<double>> combos = [
    [0.3, 0.3],
    [0.5, 0.5],
    [0.8, 0.4],
    [0.4, 0.8],
    [1.0, 0.5],
    [0.5, 1.0],
  ];

  List<Widget> children = [];
  for (int i = 0; i < combos.length; i++) {
    double wf = combos[i][0];
    double hf = combos[i][1];
    print('  combined: w=$wf h=$hf');
    children.add(
      Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.shade50,
        ),
        child: Stack(
          children: [
            FractionallySizedBox(
              widthFactor: wf,
              heightFactor: hf,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.5 + (i * 0.08)),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: color, width: 2),
                ),
                child: Center(
                  child: Text(
                    'w:${(wf * 100).toInt()}% h:${(hf * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: children);
}

Widget _buildNullFactorSection(Color color) {
  print('Building null factor behavior section');
  print('  widthFactor only (heightFactor null) -> child uses parent height');
  print('  heightFactor only (widthFactor null) -> child uses parent width');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(
          'widthFactor: 0.6, heightFactor: null (fills parent height)',
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'width 60%, height fills parent',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabel(
          'widthFactor: null, heightFactor: 0.5 (fills parent width)',
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: FractionallySizedBox(
            heightFactor: 0.5,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'width fills parent, height 50%',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Both null -> child fills entire parent'),
        Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'both null -> fills parent entirely',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRowColumnSection(Color color) {
  print('Building Row/Column integration section');
  print('  FractionallySizedBox does not work directly in Row/Column flex');
  print('  Must be wrapped or used within constrained parents');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('Column with Flexible + FractionallySizedBox children'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Flex 1, w:90% h:80%',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Flex 2, w:70% h:90%',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  heightFactor: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Flex 1, w:50% h:70%',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Row with Flexible + FractionallySizedBox children'),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  heightFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'R',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  heightFactor: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'B',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverflowSection(Color color) {
  print('Building overflow section');
  print('  factor > 1.0 causes child to overflow parent bounds');
  print(
    '  This is the "overflow box" part of RenderFractionallySizedOverflowBox',
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('widthFactor: 1.5 (150% of parent width, overflows)'),
        Container(
          height: 60,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade300, width: 2),
            borderRadius: BorderRadius.circular(4),
            color: Colors.red.shade50,
          ),
          child: FractionallySizedBox(
            widthFactor: 1.5,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color, width: 1),
              ),
              child: Center(
                child: Text(
                  '150% width - overflows!',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('heightFactor: 1.3 (130% of parent height, overflows)'),
        Container(
          height: 60,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade300, width: 2),
            borderRadius: BorderRadius.circular(4),
            color: Colors.red.shade50,
          ),
          child: FractionallySizedBox(
            heightFactor: 1.3,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color, width: 1),
              ),
              child: Center(
                child: Text(
                  '130% height - overflows!',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Both factors > 1.0: widthFactor: 1.2, heightFactor: 1.4'),
        Container(
          height: 60,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade300, width: 2),
            borderRadius: BorderRadius.circular(4),
            color: Colors.red.shade50,
          ),
          child: FractionallySizedBox(
            widthFactor: 1.2,
            heightFactor: 1.4,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color, width: 1),
              ),
              child: Center(
                child: Text(
                  '120% x 140% - both overflow!',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildLabel('Clipped overflow: Clip.hardEdge on parent'),
        Container(
          height: 60,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange.shade300, width: 2),
            borderRadius: BorderRadius.circular(4),
            color: Colors.orange.shade50,
          ),
          child: FractionallySizedBox(
            widthFactor: 1.5,
            heightFactor: 1.3,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'Clipped at parent boundary',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonSection(Color color) {
  print('Building comparison section: FractionallySizedBox vs SizedBox');
  print('  SizedBox.expand fills all available space');
  print('  SizedBox.shrink takes zero space');
  print('  FractionallySizedBox(1.0) is similar to SizedBox.expand');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(
          'FractionallySizedBox(widthFactor: 1.0, heightFactor: 1.0)',
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Container(
              color: color.withOpacity(0.4),
              child: Center(
                child: Text(
                  'FractionallySizedBox 100%x100%',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildLabel('SizedBox.expand equivalent'),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: SizedBox.expand(
            child: Container(
              color: color.withOpacity(0.6),
              child: Center(
                child: Text(
                  'SizedBox.expand',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildLabel('SizedBox.shrink (takes zero space)'),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: Align(
            alignment: Alignment.center,
            child: SizedBox.shrink(
              child: Container(
                color: Colors.red,
                child: Text('Invisible (zero size)'),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildLabel('FractionallySizedBox(0.0) ~ SizedBox.shrink'),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: FractionallySizedBox(
            widthFactor: 0.0,
            heightFactor: 0.0,
            child: Container(
              color: Colors.red,
              child: Text('Invisible (0% factor)'),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildLabel('Side by side: 25% / 50% / 75% / expand'),
        Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.grey.shade100,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.25,
                    heightFactor: 0.25,
                    child: Container(color: Colors.blue.shade400),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.grey.shade100,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: Container(color: Colors.green.shade400),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.grey.shade100,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.75,
                    heightFactor: 0.75,
                    child: Container(color: Colors.orange.shade400),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.grey.shade100,
                  ),
                  child: SizedBox.expand(
                    child: Container(color: Colors.red.shade400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildNestedSection(Color color) {
  print('Building nested FractionallySizedBox section');
  print('  Each nested level compounds the fraction');
  print('  0.8 * 0.8 = 0.64, 0.8^3 = 0.512, etc.');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('Nested: 80% of 80% of 80% (compounding fractions)'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade50,
          ),
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.8,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                border: Border.all(color: color.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 2,
                    left: 4,
                    child: Text(
                      '80%',
                      style: TextStyle(fontSize: 10, color: color),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.25),
                        border: Border.all(color: color.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 2,
                            left: 4,
                            child: Text(
                              '64%',
                              style: TextStyle(fontSize: 10, color: color),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            heightFactor: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.4),
                                border: Border.all(
                                  color: color.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 2,
                                    left: 4,
                                    child: Text(
                                      '51.2%',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 0.8,
                                    heightFactor: 0.8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.6),
                                        border: Border.all(
                                          color: color.withOpacity(0.7),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '41%',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPracticalSection(Color color) {
  print('Building practical use cases section');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Use case 1: Responsive card width
        _buildLabel('Use case: Responsive card (70% width, centered)'),
        Container(
          height: 100,
          color: Colors.grey.shade100,
          child: FractionallySizedBox(
            widthFactor: 0.7,
            alignment: Alignment.center,
            child: Card(
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Responsive Card',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Always 70% of parent width',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Use case 2: Progress bar
        _buildLabel('Use case: Custom progress bar (65% filled)'),
        Container(
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.65,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  '65%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Use case 3: Image placeholder with aspect hints
        _buildLabel('Use case: Centered image placeholder (50% x 80%)'),
        Container(
          height: 120,
          color: Colors.grey.shade100,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.8,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blueGrey.shade300, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 32, color: Colors.blueGrey),
                  SizedBox(height: 4),
                  Text(
                    '50% x 80%',
                    style: TextStyle(fontSize: 11, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Use case 4: Multiple progress indicators
        _buildLabel('Use case: Multiple metric bars'),
        _buildMetricBar('CPU Usage', 0.82, Colors.red),
        SizedBox(height: 6),
        _buildMetricBar('Memory', 0.45, Colors.blue),
        SizedBox(height: 6),
        _buildMetricBar('Disk', 0.67, Colors.orange),
        SizedBox(height: 6),
        _buildMetricBar('Network', 0.23, Colors.green),
        SizedBox(height: 16),

        // Use case 5: Decorative background element
        _buildLabel('Use case: Decorative centered background circle'),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  heightFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo.withOpacity(0.15),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Content over decorative circle',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Summary footer
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FractionallySizedBox Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 8),
              Text(
                '- widthFactor / heightFactor: fraction of parent size (0.0 to any)',
              ),
              Text('- null factor: child matches parent in that dimension'),
              Text('- factor > 1.0: child overflows parent bounds'),
              Text('- alignment: positions child within (or beyond) parent'),
              Text('- Underlying render: RenderFractionallySizedOverflowBox'),
              Text('- Use in Flexible/Expanded for Row/Column layouts'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMetricBar(String label, double fraction, Color barColor) {
  print('  Metric bar: $label at ${(fraction * 100).toInt()}%');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Text(
              '${(fraction * 100).toInt()}%',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        SizedBox(height: 3),
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            widthFactor: fraction,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
