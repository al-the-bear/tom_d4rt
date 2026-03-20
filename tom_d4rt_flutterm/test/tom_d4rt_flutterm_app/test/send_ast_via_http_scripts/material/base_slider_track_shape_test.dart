// D4rt test script: Tests BaseSliderTrackShape and slider track visuals from material
import 'package:flutter/material.dart';

// Helper to build a section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey.shade800,
      ),
    ),
  );
}

// Helper to build a description label
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper to build a slider demo card
Widget buildSliderCard({
  required String label,
  required double value,
  required Color activeTrackColor,
  required Color inactiveTrackColor,
  required Color thumbColor,
  double trackHeight = 4.0,
  SliderTrackShape? trackShape,
  double min = 0.0,
  double max = 1.0,
  int? divisions,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Text(
            'Value: ${value.toStringAsFixed(2)} | Track height: ${trackHeight.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: thumbColor,
            trackHeight: trackHeight,
            trackShape: trackShape ?? RoundedRectSliderTrackShape(),
            overlayColor: activeTrackColor.withAlpha(50),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: (v) {},
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

// Helper to build a thin colored bar representing a track visually
Widget buildTrackVisualization({
  required Color activeColor,
  required Color inactiveColor,
  required double fraction,
  double height = 8,
  String label = '',
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: Row(
            children: [
              Expanded(
                flex: (fraction * 100).round(),
                child: Container(height: height, color: activeColor),
              ),
              Expanded(
                flex: ((1.0 - fraction) * 100).round(),
                child: Container(height: height, color: inactiveColor),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper to build a colored info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80), width: 1),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: color.withAlpha(200)),
          ),
        ),
      ],
    ),
  );
}

// Helper to build a group of side-by-side track previews
Widget buildTrackComparisonRow(List<Map<String, dynamic>> tracks) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: tracks.map((t) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Text(
                  t['label'] as String,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Container(
                    height: (t['height'] as double?) ?? 6.0,
                    color: t['color'] as Color,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}

// Build a range slider demo card
Widget buildRangeSliderCard({
  required String label,
  required double startValue,
  required double endValue,
  required Color activeTrackColor,
  required Color inactiveTrackColor,
  double trackHeight = 4.0,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Text(
            'Range: ${startValue.toStringAsFixed(2)} - ${endValue.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            trackHeight: trackHeight,
            trackShape: RoundedRectSliderTrackShape(),
            rangeTrackShape: RoundedRectRangeSliderTrackShape(),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 8),
            overlayColor: activeTrackColor.withAlpha(50),
          ),
          child: RangeSlider(
            values: RangeValues(startValue, endValue),
            min: 0.0,
            max: 1.0,
            onChanged: (v) {},
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

// Build a slider with custom divisions display
Widget buildDivisionSliderCard({
  required String label,
  required double value,
  required int divisions,
  required Color color,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$divisions divisions',
                  style: TextStyle(fontSize: 11, color: color),
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(50),
            thumbColor: color,
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: color.withAlpha(80),
            trackHeight: 6,
          ),
          child: Slider(
            value: value,
            divisions: divisions,
            onChanged: (v) {},
          ),
        ),
        SizedBox(height: 4),
      ],
    ),
  );
}

// Vertical track height comparison widget
Widget buildTrackHeightComparison() {
  List<double> heights = [2, 4, 8, 12, 16, 24];
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track Height Comparison',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade700,
          ),
        ),
        SizedBox(height: 12),
        ...heights.map((h) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    '${h.toStringAsFixed(0)}px',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: h,
                      activeTrackColor: Colors.indigo,
                      inactiveTrackColor: Colors.indigo.withAlpha(40),
                      thumbColor: Colors.indigo,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                    ),
                    child: Slider(
                      value: 0.6,
                      onChanged: (v) {},
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== BaseSliderTrackShape Deep Demo ===');
  debugPrint('Demonstrating slider track shapes, colors, heights, and configurations');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade700, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Slider Track Shape Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Exploring BaseSliderTrackShape, RoundedRectSliderTrackShape, and track configurations',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Basic Track Colors
        buildSectionTitle('1. Basic Track Color Variations'),
        buildDescription('Different active and inactive track color combinations'),

        buildSliderCard(
          label: 'Blue Active / Grey Inactive',
          value: 0.7,
          activeTrackColor: Colors.blue,
          inactiveTrackColor: Colors.grey.shade300,
          thumbColor: Colors.blue.shade700,
        ),
        buildSliderCard(
          label: 'Red Active / Pink Inactive',
          value: 0.4,
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.red.shade100,
          thumbColor: Colors.red.shade800,
        ),
        buildSliderCard(
          label: 'Green Active / Light Green Inactive',
          value: 0.85,
          activeTrackColor: Colors.green,
          inactiveTrackColor: Colors.green.shade100,
          thumbColor: Colors.green.shade800,
        ),
        buildSliderCard(
          label: 'Orange Active / Amber Inactive',
          value: 0.55,
          activeTrackColor: Colors.orange,
          inactiveTrackColor: Colors.amber.shade100,
          thumbColor: Colors.deepOrange,
        ),
        buildSliderCard(
          label: 'Purple Active / Lavender Inactive',
          value: 0.3,
          activeTrackColor: Colors.purple,
          inactiveTrackColor: Colors.purple.shade50,
          thumbColor: Colors.purple.shade800,
        ),

        // Section 2: Track Height Variations
        buildSectionTitle('2. Track Height Variations'),
        buildDescription('Same slider with different track heights from 2px to 24px'),
        buildTrackHeightComparison(),

        // Section 3: Thumb Position Extremes
        buildSectionTitle('3. Thumb Position Extremes'),
        buildDescription('Slider values at various positions (0%, 25%, 50%, 75%, 100%)'),

        buildSliderCard(
          label: 'Position: 0% (minimum)',
          value: 0.0,
          activeTrackColor: Colors.teal,
          inactiveTrackColor: Colors.teal.shade100,
          thumbColor: Colors.teal,
          trackHeight: 6,
        ),
        buildSliderCard(
          label: 'Position: 25%',
          value: 0.25,
          activeTrackColor: Colors.teal,
          inactiveTrackColor: Colors.teal.shade100,
          thumbColor: Colors.teal,
          trackHeight: 6,
        ),
        buildSliderCard(
          label: 'Position: 50% (midpoint)',
          value: 0.5,
          activeTrackColor: Colors.teal,
          inactiveTrackColor: Colors.teal.shade100,
          thumbColor: Colors.teal,
          trackHeight: 6,
        ),
        buildSliderCard(
          label: 'Position: 75%',
          value: 0.75,
          activeTrackColor: Colors.teal,
          inactiveTrackColor: Colors.teal.shade100,
          thumbColor: Colors.teal,
          trackHeight: 6,
        ),
        buildSliderCard(
          label: 'Position: 100% (maximum)',
          value: 1.0,
          activeTrackColor: Colors.teal,
          inactiveTrackColor: Colors.teal.shade100,
          thumbColor: Colors.teal,
          trackHeight: 6,
        ),

        // Section 4: Track Visualizations
        buildSectionTitle('4. Track Color Visualizations'),
        buildDescription('Side-by-side track color representations without slider interactivity'),

        buildTrackVisualization(
          activeColor: Colors.blue,
          inactiveColor: Colors.blue.shade100,
          fraction: 0.6,
          height: 10,
          label: 'Blue track at 60%',
        ),
        buildTrackVisualization(
          activeColor: Colors.deepOrange,
          inactiveColor: Colors.orange.shade100,
          fraction: 0.3,
          height: 10,
          label: 'Deep Orange track at 30%',
        ),
        buildTrackVisualization(
          activeColor: Colors.green.shade700,
          inactiveColor: Colors.lightGreen.shade100,
          fraction: 0.9,
          height: 10,
          label: 'Green track at 90%',
        ),
        buildTrackVisualization(
          activeColor: Colors.purple,
          inactiveColor: Colors.purple.shade50,
          fraction: 0.15,
          height: 10,
          label: 'Purple track at 15%',
        ),

        // Section 5: Track height side-by-side comparison
        buildSectionTitle('5. Track Height Preview Boxes'),
        buildTrackComparisonRow([
          {'label': '2px', 'height': 2.0, 'color': Colors.red},
          {'label': '6px', 'height': 6.0, 'color': Colors.green},
          {'label': '12px', 'height': 12.0, 'color': Colors.blue},
          {'label': '20px', 'height': 20.0, 'color': Colors.orange},
        ]),

        // Section 6: RoundedRectSliderTrackShape specifics
        buildSectionTitle('6. RoundedRectSliderTrackShape'),
        buildDescription('The default track shape with rounded ends'),

        buildSliderCard(
          label: 'Rounded Rect - Thin (2px)',
          value: 0.5,
          activeTrackColor: Colors.cyan.shade600,
          inactiveTrackColor: Colors.cyan.shade100,
          thumbColor: Colors.cyan.shade800,
          trackHeight: 2,
          trackShape: RoundedRectSliderTrackShape(),
        ),
        buildSliderCard(
          label: 'Rounded Rect - Medium (8px)',
          value: 0.65,
          activeTrackColor: Colors.cyan.shade600,
          inactiveTrackColor: Colors.cyan.shade100,
          thumbColor: Colors.cyan.shade800,
          trackHeight: 8,
          trackShape: RoundedRectSliderTrackShape(),
        ),
        buildSliderCard(
          label: 'Rounded Rect - Thick (16px)',
          value: 0.35,
          activeTrackColor: Colors.cyan.shade600,
          inactiveTrackColor: Colors.cyan.shade100,
          thumbColor: Colors.cyan.shade800,
          trackHeight: 16,
          trackShape: RoundedRectSliderTrackShape(),
        ),

        // Info box
        buildInfoBox(
          'RoundedRectSliderTrackShape paints a rounded rectangle track. '
          'The track height and active/inactive colors are controlled via SliderThemeData.',
          Colors.cyan,
        ),

        // Section 7: Discrete sliders with divisions
        buildSectionTitle('7. Discrete Sliders with Divisions'),
        buildDescription('Tick marks appear on the track when divisions are set'),

        buildDivisionSliderCard(
          label: '5 divisions',
          value: 0.6,
          divisions: 5,
          color: Colors.deepPurple,
        ),
        buildDivisionSliderCard(
          label: '10 divisions',
          value: 0.3,
          divisions: 10,
          color: Colors.teal,
        ),
        buildDivisionSliderCard(
          label: '20 divisions',
          value: 0.75,
          divisions: 20,
          color: Colors.amber.shade700,
        ),
        buildDivisionSliderCard(
          label: '50 divisions',
          value: 0.5,
          divisions: 50,
          color: Colors.pink,
        ),

        // Section 8: Range Sliders
        buildSectionTitle('8. Range Slider Track Shapes'),
        buildDescription('RangeSlider uses RoundedRectRangeSliderTrackShape by default'),

        buildRangeSliderCard(
          label: 'Narrow Range (0.3 - 0.5)',
          startValue: 0.3,
          endValue: 0.5,
          activeTrackColor: Colors.blue.shade600,
          inactiveTrackColor: Colors.blue.shade100,
          trackHeight: 6,
        ),
        buildRangeSliderCard(
          label: 'Wide Range (0.1 - 0.9)',
          startValue: 0.1,
          endValue: 0.9,
          activeTrackColor: Colors.green.shade600,
          inactiveTrackColor: Colors.green.shade100,
          trackHeight: 6,
        ),
        buildRangeSliderCard(
          label: 'Left-biased Range (0.0 - 0.3)',
          startValue: 0.0,
          endValue: 0.3,
          activeTrackColor: Colors.orange.shade600,
          inactiveTrackColor: Colors.orange.shade100,
          trackHeight: 8,
        ),
        buildRangeSliderCard(
          label: 'Right-biased Range (0.7 - 1.0)',
          startValue: 0.7,
          endValue: 1.0,
          activeTrackColor: Colors.red.shade600,
          inactiveTrackColor: Colors.red.shade100,
          trackHeight: 8,
        ),

        // Section 9: Dark theme tracks
        buildSectionTitle('9. Dark Theme Track Styling'),
        buildDescription('Sliders styled for dark backgrounds'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.cyanAccent,
                  inactiveTrackColor: Colors.grey.shade700,
                  thumbColor: Colors.cyanAccent,
                  trackHeight: 4,
                ),
                child: Slider(value: 0.6, onChanged: (v) {}),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.pinkAccent,
                  inactiveTrackColor: Colors.grey.shade700,
                  thumbColor: Colors.pinkAccent,
                  trackHeight: 6,
                ),
                child: Slider(value: 0.4, onChanged: (v) {}),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.greenAccent,
                  inactiveTrackColor: Colors.grey.shade700,
                  thumbColor: Colors.greenAccent,
                  trackHeight: 8,
                ),
                child: Slider(value: 0.8, onChanged: (v) {}),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.amberAccent,
                  inactiveTrackColor: Colors.grey.shade700,
                  thumbColor: Colors.amberAccent,
                  trackHeight: 10,
                ),
                child: Slider(value: 0.5, onChanged: (v) {}),
              ),
            ],
          ),
        ),

        // Section 10: Summary info
        buildSectionTitle('10. Track Shape Summary'),
        buildInfoBox(
          'BaseSliderTrackShape is the abstract base for track shapes. '
          'RoundedRectSliderTrackShape and RoundedRectRangeSliderTrackShape are the built-in implementations.',
          Colors.indigo,
        ),
        buildInfoBox(
          'Track height is controlled via SliderThemeData.trackHeight. '
          'Active and inactive track colors can be set independently.',
          Colors.green,
        ),
        buildInfoBox(
          'For discrete sliders, tick marks appear on the track at division points. '
          'Tick mark colors are also set via SliderThemeData.',
          Colors.orange,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
