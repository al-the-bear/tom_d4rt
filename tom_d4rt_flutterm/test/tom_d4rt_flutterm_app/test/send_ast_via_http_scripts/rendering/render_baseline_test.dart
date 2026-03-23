// Deep demo: Baseline widget (RenderBaseline)
// Baseline positions its child according to the child's baseline offset.
// It takes a baseline value (double) and a baselineType (TextBaseline).

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderBaseline Deep Demo ===');
  print('Baseline positions child so its baseline sits at a given offset.');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 16.0),

        // Section 1: Different baseline values
        _buildSectionTitle('1. Baseline with Different Offset Values'),
        _buildBaselineOffsetDemo(context),
        SizedBox(height: 24.0),

        // Section 2: Alphabetic vs Ideographic
        _buildSectionTitle('2. Alphabetic vs Ideographic BaselineType'),
        _buildBaselineTypeComparison(context),
        SizedBox(height: 24.0),

        // Section 3: Aligning different font sizes
        _buildSectionTitle('3. Aligning Different Font Sizes on Same Line'),
        _buildFontSizeAlignment(context),
        SizedBox(height: 24.0),

        // Section 4: Aligning text with icons
        _buildSectionTitle('4. Aligning Text with Icons'),
        _buildTextIconAlignment(context),
        SizedBox(height: 24.0),

        // Section 5: Mixed content alignment
        _buildSectionTitle('5. Mixed Content Baseline Alignment'),
        _buildMixedContentAlignment(context),
        SizedBox(height: 24.0),

        // Section 6: Baseline in Row cross-axis
        _buildSectionTitle('6. Baseline with Row CrossAxisAlignment'),
        _buildRowCrossAxisDemo(context),
        SizedBox(height: 24.0),

        // Section 7: Visual baseline reference lines
        _buildSectionTitle('7. Visual Baseline Reference Lines'),
        _buildReferenceLineDemo(context),
        SizedBox(height: 24.0),

        // Section 8: Stacked baselines
        _buildSectionTitle('8. Stacked Baseline Offsets'),
        _buildStackedBaselines(context),
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// Header with gradient styling
Widget _buildHeader() {
  print('[Header] Building gradient header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderBaseline Deep Demo',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Baseline positions its child so that the child\'s baseline '
          'is placed at a specified distance from the top of the Baseline widget.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xCCFFFFFF),
          ),
        ),
      ],
    ),
  );
}

// Section title with gradient underline
Widget _buildSectionTitle(String title) {
  print('[Section] $title');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          height: 3.0,
          width: 200.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0x001565C0)],
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ],
    ),
  );
}

// Label for sub-items
Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 16.0, bottom: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        color: Color(0xFF757575),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// Section 1: Different baseline offset values
Widget _buildBaselineOffsetDemo(BuildContext context) {
  print('[Demo 1] Building baseline offset demo with values 0-100');
  List<double> offsets = [0.0, 20.0, 40.0, 60.0, 80.0, 100.0];

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Each cell shows text positioned at a different baseline offset. '
          'Higher values push the text baseline further from the top.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 140.0,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildOffsetItems(offsets),
          ),
        ),
        SizedBox(height: 8.0),
        // Show offset labels underneath
        Row(
          children: offsets.map((offset) {
            print('  - Offset cell: $offset');
            return Expanded(
              child: Center(
                child: Text(
                  'baseline: ${offset.toInt()}',
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF9E9E9E)),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

List<Widget> _buildOffsetItems(List<double> offsets) {
  return offsets.map((offset) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
          ),
        ),
        child: Baseline(
          baseline: offset,
          baselineType: TextBaseline.alphabetic,
          child: Text(
            'Ag',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
        ),
      ),
    );
  }).toList();
}

// Section 2: Alphabetic vs Ideographic comparison
Widget _buildBaselineTypeComparison(BuildContext context) {
  print('[Demo 2] Comparing TextBaseline.alphabetic vs TextBaseline.ideographic');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alphabetic baseline aligns to the bottom of Latin characters. '
          'Ideographic baseline aligns to the bottom of ideographic characters.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        // Alphabetic row
        _buildLabel('TextBaseline.alphabetic (baseline: 50)'),
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Baseline(
                baseline: 50.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('Hello', style: TextStyle(fontSize: 16.0)),
              ),
              Baseline(
                baseline: 50.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('World', style: TextStyle(fontSize: 24.0)),
              ),
              Baseline(
                baseline: 50.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('Ag', style: TextStyle(fontSize: 32.0)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Ideographic row
        _buildLabel('TextBaseline.ideographic (baseline: 50)'),
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Baseline(
                baseline: 50.0,
                baselineType: TextBaseline.ideographic,
                child: Text('Hello', style: TextStyle(fontSize: 16.0)),
              ),
              Baseline(
                baseline: 50.0,
                baselineType: TextBaseline.ideographic,
                child: Text('World', style: TextStyle(fontSize: 24.0)),
              ),
              Baseline(
                baseline: 50.0,
                baselineType: TextBaseline.ideographic,
                child: Text('Ag', style: TextStyle(fontSize: 32.0)),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Notice how alphabetic and ideographic baselines differ slightly '
          'for the same text content and baseline offset.',
          style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

// Section 3: Different font size alignment
Widget _buildFontSizeAlignment(BuildContext context) {
  print('[Demo 3] Aligning different font sizes on the same baseline');

  double sharedBaseline = 60.0;
  List<double> fontSizes = [10.0, 14.0, 18.0, 24.0, 32.0, 40.0];

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All text shares the same baseline offset ($sharedBaseline). '
          'Despite different font sizes, they align on a common baseline.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              // Baseline reference line
              Positioned(
                top: sharedBaseline,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: 1.0,
                  color: Color(0xFFE53935),
                ),
              ),
              // Text items aligned to baseline
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: fontSizes.map((size) {
                  print('  - Font size: $size at baseline $sharedBaseline');
                  return Baseline(
                    baseline: sharedBaseline,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      'Ag',
                      style: TextStyle(
                        fontSize: size,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(width: 16.0, height: 2.0, color: Color(0xFFE53935)),
            SizedBox(width: 4.0),
            Text(
              'Red line = shared baseline at offset $sharedBaseline',
              style: TextStyle(fontSize: 10.0, color: Color(0xFFE53935)),
            ),
          ],
        ),
      ],
    ),
  );
}

// Section 4: Text with icon alignment
Widget _buildTextIconAlignment(BuildContext context) {
  print('[Demo 4] Aligning text with icons using Baseline');

  double iconBaseline = 40.0;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Baseline can align icons and text to the same visual line. '
          'Each icon and text shares baseline offset $iconBaseline.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        // Row with aligned icons and text
        Container(
          height: 70.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Baseline(
                baseline: iconBaseline,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.star, size: 16.0, color: Color(0xFFFFA000)),
              ),
              SizedBox(width: 4.0),
              Baseline(
                baseline: iconBaseline,
                baselineType: TextBaseline.alphabetic,
                child: Text('Star', style: TextStyle(fontSize: 14.0)),
              ),
              SizedBox(width: 16.0),
              Baseline(
                baseline: iconBaseline,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.favorite, size: 24.0, color: Color(0xFFE53935)),
              ),
              SizedBox(width: 4.0),
              Baseline(
                baseline: iconBaseline,
                baselineType: TextBaseline.alphabetic,
                child: Text('Heart', style: TextStyle(fontSize: 20.0)),
              ),
              SizedBox(width: 16.0),
              Baseline(
                baseline: iconBaseline,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.bolt, size: 32.0, color: Color(0xFFFF6F00)),
              ),
              SizedBox(width: 4.0),
              Baseline(
                baseline: iconBaseline,
                baselineType: TextBaseline.alphabetic,
                child: Text('Bolt', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Second row: different baseline for comparison
        _buildLabel('Same items without Baseline (default alignment)'),
        Container(
          height: 70.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 16.0, color: Color(0xFFFFA000)),
              SizedBox(width: 4.0),
              Text('Star', style: TextStyle(fontSize: 14.0)),
              SizedBox(width: 16.0),
              Icon(Icons.favorite, size: 24.0, color: Color(0xFFE53935)),
              SizedBox(width: 4.0),
              Text('Heart', style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 16.0),
              Icon(Icons.bolt, size: 32.0, color: Color(0xFFFF6F00)),
              SizedBox(width: 4.0),
              Text('Bolt', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Compare: top row uses Baseline alignment, bottom uses center alignment.',
          style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

// Section 5: Mixed content alignment
Widget _buildMixedContentAlignment(BuildContext context) {
  print('[Demo 5] Mixed content aligned to common baseline');

  double mixedBaseline = 55.0;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Text, Icon, and Container widgets aligned to a common baseline of $mixedBaseline. '
          'Even non-text widgets can participate using Baseline.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 100.0,
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFCE93D8)),
          ),
          child: Stack(
            children: [
              // Reference line
              Positioned(
                top: mixedBaseline,
                left: 0.0,
                right: 0.0,
                child: Container(height: 1.0, color: Color(0xFF7B1FA2)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text widget
                  Baseline(
                    baseline: mixedBaseline,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      'Text',
                      style: TextStyle(fontSize: 22.0, color: Color(0xFF4A148C)),
                    ),
                  ),
                  // Icon widget
                  Baseline(
                    baseline: mixedBaseline,
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.check_circle, size: 28.0, color: Color(0xFF7B1FA2)),
                  ),
                  // Container (colored box)
                  Baseline(
                    baseline: mixedBaseline,
                    baselineType: TextBaseline.alphabetic,
                    child: Container(
                      width: 40.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFAB47BC),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  // Another text with different size
                  Baseline(
                    baseline: mixedBaseline,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      'Mix',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                  ),
                  // Small icon
                  Baseline(
                    baseline: mixedBaseline,
                    baselineType: TextBaseline.alphabetic,
                    child: Icon(Icons.diamond, size: 18.0, color: Color(0xFF8E24AA)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(width: 16.0, height: 2.0, color: Color(0xFF7B1FA2)),
            SizedBox(width: 4.0),
            Text(
              'Purple line = common baseline at $mixedBaseline',
              style: TextStyle(fontSize: 10.0, color: Color(0xFF7B1FA2)),
            ),
          ],
        ),
      ],
    ),
  );
}

// Section 6: Baseline with Row CrossAxisAlignment
Widget _buildRowCrossAxisDemo(BuildContext context) {
  print('[Demo 6] Baseline interacting with Row CrossAxisAlignment');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Row supports CrossAxisAlignment.baseline which uses child baselines '
          'directly. Compare with manual Baseline widgets.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        // Row with CrossAxisAlignment.baseline
        _buildLabel('Row with CrossAxisAlignment.baseline'),
        Container(
          height: 70.0,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Color(0xFFE0F7FA),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Small', style: TextStyle(fontSize: 12.0, color: Color(0xFF00695C))),
              SizedBox(width: 12.0),
              Text('Medium', style: TextStyle(fontSize: 20.0, color: Color(0xFF00695C))),
              SizedBox(width: 12.0),
              Text('Large', style: TextStyle(fontSize: 32.0, color: Color(0xFF00695C))),
              SizedBox(width: 12.0),
              Text('XL', style: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Manual Baseline equivalent
        _buildLabel('Manual Baseline widgets (baseline: 55)'),
        Container(
          height: 70.0,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Color(0xFFB2DFDB),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Baseline(
                baseline: 55.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('Small', style: TextStyle(fontSize: 12.0, color: Color(0xFF004D40))),
              ),
              SizedBox(width: 12.0),
              Baseline(
                baseline: 55.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('Medium', style: TextStyle(fontSize: 20.0, color: Color(0xFF004D40))),
              ),
              SizedBox(width: 12.0),
              Baseline(
                baseline: 55.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('Large', style: TextStyle(fontSize: 32.0, color: Color(0xFF004D40))),
              ),
              SizedBox(width: 12.0),
              Baseline(
                baseline: 55.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('XL', style: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Without baseline alignment for comparison
        _buildLabel('Row with CrossAxisAlignment.start (no baseline)'),
        Container(
          height: 70.0,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFECB3),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Small', style: TextStyle(fontSize: 12.0, color: Color(0xFFE65100))),
              SizedBox(width: 12.0),
              Text('Medium', style: TextStyle(fontSize: 20.0, color: Color(0xFFE65100))),
              SizedBox(width: 12.0),
              Text('Large', style: TextStyle(fontSize: 32.0, color: Color(0xFFE65100))),
              SizedBox(width: 12.0),
              Text('XL', style: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold, color: Color(0xFFE65100))),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Top: Row.baseline aligns automatically. Middle: manual Baseline produces same effect. '
          'Bottom: start alignment shows misaligned text.',
          style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

// Section 7: Visual baseline reference lines
Widget _buildReferenceLineDemo(BuildContext context) {
  print('[Demo 7] Visual baseline reference lines');

  List<double> referenceLines = [20.0, 40.0, 60.0, 80.0];
  List<Color> lineColors = [
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
  ];

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colored lines mark baseline offsets. Text at each offset aligns to its line.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 120.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              // Reference lines
              ..._buildReferenceLines(referenceLines, lineColors),
              // Text at each baseline
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Baseline(
                    baseline: 20.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Line 20',
                        style: TextStyle(fontSize: 14.0, color: Color(0xFFE53935), fontWeight: FontWeight.bold)),
                  ),
                  Baseline(
                    baseline: 40.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Line 40',
                        style: TextStyle(fontSize: 14.0, color: Color(0xFFFB8C00), fontWeight: FontWeight.bold)),
                  ),
                  Baseline(
                    baseline: 60.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Line 60',
                        style: TextStyle(fontSize: 14.0, color: Color(0xFF43A047), fontWeight: FontWeight.bold)),
                  ),
                  Baseline(
                    baseline: 80.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Line 80',
                        style: TextStyle(fontSize: 14.0, color: Color(0xFF1E88E5), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        // Legend
        Wrap(
          spacing: 16.0,
          children: [
            _buildLegendItem(Color(0xFFE53935), 'Baseline 20'),
            _buildLegendItem(Color(0xFFFB8C00), 'Baseline 40'),
            _buildLegendItem(Color(0xFF43A047), 'Baseline 60'),
            _buildLegendItem(Color(0xFF1E88E5), 'Baseline 80'),
          ],
        ),
        SizedBox(height: 12.0),
        // Multi-baseline per line
        _buildLabel('Multiple texts sharing same baseline reference line'),
        Container(
          height: 80.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFFE082)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 50.0,
                left: 0.0,
                right: 0.0,
                child: Container(height: 2.0, color: Color(0xFFFF6F00)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Baseline(
                    baseline: 50.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Tiny', style: TextStyle(fontSize: 10.0, color: Color(0xFFE65100))),
                  ),
                  Baseline(
                    baseline: 50.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Normal', style: TextStyle(fontSize: 16.0, color: Color(0xFFE65100))),
                  ),
                  Baseline(
                    baseline: 50.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Big', style: TextStyle(fontSize: 26.0, color: Color(0xFFE65100))),
                  ),
                  Baseline(
                    baseline: 50.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text('Huge', style: TextStyle(fontSize: 36.0, color: Color(0xFFE65100))),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Orange line at offset 50 - all text baselines sit on this line regardless of font size.',
          style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

List<Widget> _buildReferenceLines(List<double> offsets, List<Color> colors) {
  List<Widget> lines = [];
  for (int i = 0; i < offsets.length; i++) {
    print('  - Reference line at offset ${offsets[i]}');
    lines.add(
      Positioned(
        top: offsets[i],
        left: 0.0,
        right: 0.0,
        child: Container(
          height: 1.0,
          color: colors[i].withOpacity(0.5),
        ),
      ),
    );
  }
  return lines;
}

Widget _buildLegendItem(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 12.0, height: 3.0, color: color),
      SizedBox(width: 4.0),
      Text(label, style: TextStyle(fontSize: 10.0, color: color)),
    ],
  );
}

// Section 8: Stacked baseline offsets
Widget _buildStackedBaselines(BuildContext context) {
  print('[Demo 8] Stacked baseline offsets in vertical layout');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple rows, each with Baseline at incrementing offsets, creating '
          'a staircase pattern of aligned text.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 12.0),
        // Staircase pattern
        ..._buildStaircaseRows(),
        SizedBox(height: 16.0),
        // Decorative baseline grid
        _buildLabel('Baseline grid: 3x3 with alternating offsets'),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFB39DDB)),
          ),
          child: Column(
            children: [
              _buildGridRow(30.0, ['Alpha', 'Beta', 'Gamma'], Color(0xFF4527A0)),
              SizedBox(height: 4.0),
              _buildGridRow(25.0, ['Delta', 'Epsilon', 'Zeta'], Color(0xFF6A1B9A)),
              SizedBox(height: 4.0),
              _buildGridRow(35.0, ['Eta', 'Theta', 'Iota'], Color(0xFF283593)),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        // Summary card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '- Baseline positions a child so its text baseline sits at a given offset\n'
                '- Works with TextBaseline.alphabetic and TextBaseline.ideographic\n'
                '- Essential for aligning mixed-size text on a common line\n'
                '- Can align non-text widgets (icons, containers) as well\n'
                '- Row supports CrossAxisAlignment.baseline for automatic alignment\n'
                '- Combine with Stack for visual baseline reference guides',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xCCFFFFFF),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildStaircaseRows() {
  List<Widget> rows = [];
  List<String> labels = ['Step One', 'Step Two', 'Step Three', 'Step Four', 'Step Five'];
  List<double> offsets = [10.0, 20.0, 30.0, 40.0, 50.0];
  List<Color> colors = [
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFFFDD835),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
  ];

  for (int i = 0; i < labels.length; i++) {
    print('  - Staircase step: ${labels[i]} at offset ${offsets[i]}');
    rows.add(
      Container(
        height: 60.0,
        margin: EdgeInsets.only(bottom: 2.0),
        decoration: BoxDecoration(
          color: colors[i].withOpacity(0.1),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: offsets[i],
              left: 0.0,
              right: 0.0,
              child: Container(height: 1.0, color: colors[i].withOpacity(0.4)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 8.0),
                Baseline(
                  baseline: offsets[i],
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: colors[i],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Baseline(
                  baseline: offsets[i],
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '(baseline: ${offsets[i].toInt()})',
                    style: TextStyle(fontSize: 11.0, color: colors[i].withOpacity(0.7)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  return rows;
}

Widget _buildGridRow(double baseline, List<String> labels, Color color) {
  print('  - Grid row at baseline $baseline: $labels');
  return Container(
    height: 50.0,
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: labels.map((label) {
        return Expanded(
          child: Center(
            child: Baseline(
              baseline: baseline,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
