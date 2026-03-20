// D4rt test script: Tests BaseRangeSliderTrackShape from material
// Shows range sliders with different track shapes, active/inactive colors, range selections
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.red.shade700,
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

// Helper to build a labeled range slider
Widget buildLabeledRangeSlider(
  String label,
  RangeValues values,
  Color activeColor,
  Color inactiveColor, {
  double min = 0,
  double max = 100,
  int divisions = 10,
  String? prefix,
  String? suffix,
}) {
  String startLabel = prefix != null
      ? '$prefix${values.start.toInt()}'
      : '${values.start.toInt()}';
  String endLabel = suffix != null
      ? '${values.end.toInt()}$suffix'
      : '${values.end.toInt()}';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: activeColor.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$startLabel - $endLabel',
                style: TextStyle(
                  fontSize: 12,
                  color: activeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
            thumbColor: activeColor,
            overlayColor: activeColor.withAlpha(30),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            rangeTrackShape: RoundedRectRangeSliderTrackShape(),
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: divisions,
            labels: RangeLabels(startLabel, endLabel),
            onChanged: (v) {},
          ),
        ),
      ],
    ),
  );
}

// Helper to build a track shape visualization
Widget buildTrackVisualization(
  String label,
  Color activeColor,
  Color inactiveColor,
  Color thumbColor,
  double trackHeight,
  double thumbRadius,
  double startPercent,
  double endPercent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Text(
          'Track: ${trackHeight.toInt()}px  |  Thumb: ${thumbRadius.toInt()}px radius  |  Range: ${(startPercent * 100).toInt()}% - ${(endPercent * 100).toInt()}%',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: thumbRadius * 2 + 8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Full track (inactive)
              Container(
                height: trackHeight,
                decoration: BoxDecoration(
                  color: inactiveColor,
                  borderRadius: BorderRadius.circular(trackHeight / 2),
                ),
              ),
              // Active track
              Positioned(
                left: 0,
                right: 0,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: endPercent,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerRight,
                    widthFactor: 1 - (startPercent / endPercent),
                    child: Container(
                      height: trackHeight,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(trackHeight / 2),
                      ),
                    ),
                  ),
                ),
              ),
              // Start thumb
              Positioned(
                left: 0,
                right: 0,
                child: FractionallySizedBox(
                  alignment: Alignment(startPercent * 2 - 1, 0),
                  widthFactor: 0,
                  child: Container(
                    width: thumbRadius * 2,
                    height: thumbRadius * 2,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: thumbColor.withAlpha(60),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // End thumb
              Positioned(
                left: 0,
                right: 0,
                child: FractionallySizedBox(
                  alignment: Alignment(endPercent * 2 - 1, 0),
                  widthFactor: 0,
                  child: Container(
                    width: thumbRadius * 2,
                    height: thumbRadius * 2,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: thumbColor.withAlpha(60),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
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

// Helper to build a color-themed range slider card
Widget buildThemedRangeSliderCard(
  String title,
  String description,
  Color primaryColor,
  RangeValues values,
) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: primaryColor,
              inactiveTrackColor: primaryColor.withAlpha(40),
              thumbColor: primaryColor,
              overlayColor: primaryColor.withAlpha(30),
              rangeThumbShape: RoundRangeSliderThumbShape(
                enabledThumbRadius: 10,
              ),
              rangeTrackShape: RoundedRectRangeSliderTrackShape(),
              showValueIndicator: ShowValueIndicator.onDrag,
            ),
            child: RangeSlider(
              values: values,
              min: 0,
              max: 100,
              divisions: 20,
              labels: RangeLabels(
                '${values.start.toInt()}',
                '${values.end.toInt()}',
              ),
              onChanged: (v) {},
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min: ${values.start.toInt()}',
                style: TextStyle(fontSize: 12, color: primaryColor),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Range: ${(values.end - values.start).toInt()}',
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                'Max: ${values.end.toInt()}',
                style: TextStyle(fontSize: 12, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Helper to build a property comparison row
Widget buildPropertyCompare(
  String property,
  List<String> values,
  List<Color> colors,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            property,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        ...List.generate(values.length, (i) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: colors[i].withAlpha(20),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  values[i],
                  style: TextStyle(fontSize: 11, color: colors[i]),
                ),
              ),
            ),
          );
        }),
      ],
    ),
  );
}

// Helper to build a use case example
Widget buildUseCaseExample(
  String title,
  String unitLabel,
  IconData icon,
  Color color,
  RangeValues values,
  double min,
  double max,
  int divisions,
  String startLabel,
  String endLabel,
) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                unitLabel,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
            ],
          ),
          SizedBox(height: 12),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              inactiveTrackColor: color.withAlpha(40),
              thumbColor: color,
              overlayColor: color.withAlpha(30),
              rangeThumbShape: RoundRangeSliderThumbShape(
                enabledThumbRadius: 10,
              ),
              rangeTrackShape: RoundedRectRangeSliderTrackShape(),
            ),
            child: RangeSlider(
              values: values,
              min: min,
              max: max,
              divisions: divisions,
              labels: RangeLabels(startLabel, endLabel),
              onChanged: (v) {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withAlpha(15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: color.withAlpha(40)),
                ),
                child: Text(
                  startLabel,
                  style: TextStyle(
                    fontSize: 13,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                'to',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withAlpha(15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: color.withAlpha(40)),
                ),
                child: Text(
                  endLabel,
                  style: TextStyle(
                    fontSize: 13,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Helper to build a track height comparison
Widget buildTrackHeightRow(
  String label,
  double height,
  Color active,
  Color inactive,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              color: inactive,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  color: active,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${height.toInt()}px',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== BaseRangeSliderTrackShape Test Script ===');
  debugPrint('Testing range sliders with different track shapes and configurations');
  debugPrint('Demonstrates RangeSlider with custom SliderThemeData');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade700, Colors.pink.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RangeSlider Track Shapes',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'BaseRangeSliderTrackShape with various configurations',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Basic Range Sliders
        buildSectionHeader('1. Basic Range Sliders'),
        buildLabeledRangeSlider(
          'Default Range',
          RangeValues(20, 80),
          Colors.blue,
          Colors.blue.shade100,
        ),
        buildLabeledRangeSlider(
          'Narrow Range',
          RangeValues(40, 60),
          Colors.green.shade700,
          Colors.green.shade100,
        ),
        buildLabeledRangeSlider(
          'Wide Range',
          RangeValues(5, 95),
          Colors.orange.shade700,
          Colors.orange.shade100,
        ),
        buildLabeledRangeSlider(
          'Left Biased',
          RangeValues(10, 30),
          Colors.purple.shade700,
          Colors.purple.shade100,
        ),
        buildLabeledRangeSlider(
          'Right Biased',
          RangeValues(70, 90),
          Colors.red.shade700,
          Colors.red.shade100,
        ),
        buildLabeledRangeSlider(
          'Full Range',
          RangeValues(0, 100),
          Colors.teal.shade700,
          Colors.teal.shade100,
        ),
        buildLabeledRangeSlider(
          'Minimum',
          RangeValues(50, 50),
          Colors.brown.shade700,
          Colors.brown.shade100,
        ),

        // Section 2: Color Themed Cards
        buildSectionHeader('2. Color-Themed Range Sliders'),
        buildThemedRangeSliderCard(
          'Blue Ocean',
          'Primary blue theme',
          Colors.blue.shade700,
          RangeValues(15, 75),
        ),
        buildThemedRangeSliderCard(
          'Forest Green',
          'Nature-inspired green',
          Colors.green.shade700,
          RangeValues(30, 80),
        ),
        buildThemedRangeSliderCard(
          'Sunset Orange',
          'Warm orange tones',
          Colors.orange.shade700,
          RangeValues(20, 60),
        ),
        buildThemedRangeSliderCard(
          'Royal Purple',
          'Deep purple elegance',
          Colors.purple.shade700,
          RangeValues(10, 50),
        ),
        buildThemedRangeSliderCard(
          'Cherry Red',
          'Bold red statement',
          Colors.red.shade700,
          RangeValues(25, 90),
        ),

        // Section 3: Track Shape Visualization
        buildSectionHeader('3. Track Shape Visualizations'),
        buildTrackVisualization(
          'Thin track, small thumbs',
          Colors.blue,
          Colors.blue.shade100,
          Colors.blue,
          2,
          8,
          0.2,
          0.8,
        ),
        buildTrackVisualization(
          'Medium track, medium thumbs',
          Colors.green,
          Colors.green.shade100,
          Colors.green,
          4,
          10,
          0.3,
          0.7,
        ),
        buildTrackVisualization(
          'Thick track, large thumbs',
          Colors.orange,
          Colors.orange.shade100,
          Colors.orange,
          8,
          14,
          0.15,
          0.85,
        ),
        buildTrackVisualization(
          'Extra thick track',
          Colors.purple,
          Colors.purple.shade100,
          Colors.purple,
          12,
          12,
          0.25,
          0.75,
        ),

        // Section 4: Track Height Comparison
        buildSectionHeader('4. Track Height Comparison'),
        buildTrackHeightRow('1px', 1, Colors.blue, Colors.blue.shade100),
        buildTrackHeightRow('2px', 2, Colors.blue, Colors.blue.shade100),
        buildTrackHeightRow('4px', 4, Colors.blue, Colors.blue.shade100),
        buildTrackHeightRow('6px', 6, Colors.blue, Colors.blue.shade100),
        buildTrackHeightRow('8px', 8, Colors.blue, Colors.blue.shade100),
        buildTrackHeightRow('12px', 12, Colors.blue, Colors.blue.shade100),
        buildTrackHeightRow('16px', 16, Colors.blue, Colors.blue.shade100),
        buildTrackHeightRow('24px', 24, Colors.blue, Colors.blue.shade100),

        // Section 5: Use Case Examples
        buildSectionHeader('5. Real-World Use Cases'),
        buildUseCaseExample(
          'Price Range',
          'USD',
          Icons.attach_money,
          Colors.green.shade700,
          RangeValues(200, 800),
          0,
          1000,
          20,
          '\$200',
          '\$800',
        ),
        buildUseCaseExample(
          'Age Range',
          'years',
          Icons.people,
          Colors.blue.shade700,
          RangeValues(18, 65),
          0,
          100,
          100,
          '18 yrs',
          '65 yrs',
        ),
        buildUseCaseExample(
          'Temperature',
          '°C',
          Icons.thermostat,
          Colors.orange.shade700,
          RangeValues(18, 26),
          10,
          35,
          25,
          '18°C',
          '26°C',
        ),
        buildUseCaseExample(
          'Distance',
          'km',
          Icons.straighten,
          Colors.purple.shade700,
          RangeValues(5, 25),
          0,
          50,
          50,
          '5 km',
          '25 km',
        ),
        buildUseCaseExample(
          'Weight',
          'kg',
          Icons.fitness_center,
          Colors.red.shade700,
          RangeValues(60, 90),
          30,
          150,
          24,
          '60 kg',
          '90 kg',
        ),

        // Section 6: Active vs Inactive Colors
        buildSectionHeader('6. Active/Inactive Color Combinations'),
        buildLabeledRangeSlider(
          'Blue / Light Blue',
          RangeValues(20, 70),
          Colors.blue.shade700,
          Colors.blue.shade100,
        ),
        buildLabeledRangeSlider(
          'Green / Light Green',
          RangeValues(30, 80),
          Colors.green.shade700,
          Colors.green.shade100,
        ),
        buildLabeledRangeSlider(
          'Red / Pink',
          RangeValues(10, 50),
          Colors.red.shade700,
          Colors.pink.shade100,
        ),
        buildLabeledRangeSlider(
          'Purple / Lavender',
          RangeValues(25, 75),
          Colors.purple.shade700,
          Colors.purple.shade50,
        ),
        buildLabeledRangeSlider(
          'Orange / Cream',
          RangeValues(15, 85),
          Colors.orange.shade700,
          Colors.orange.shade50,
        ),
        buildLabeledRangeSlider(
          'Dark / Grey',
          RangeValues(40, 60),
          Colors.grey.shade800,
          Colors.grey.shade200,
        ),

        // Section 7: Property Comparison Table
        buildSectionHeader('7. Slider Property Comparison'),
        buildPropertyCompare(
          'Track Height',
          ['2px', '4px', '6px', '8px'],
          [Colors.blue, Colors.green, Colors.orange, Colors.red],
        ),
        buildPropertyCompare(
          'Thumb Radius',
          ['8px', '10px', '12px', '14px'],
          [Colors.blue, Colors.green, Colors.orange, Colors.red],
        ),
        buildPropertyCompare(
          'Divisions',
          ['5', '10', '20', '50'],
          [Colors.blue, Colors.green, Colors.orange, Colors.red],
        ),
        buildPropertyCompare(
          'Overlap',
          ['None', 'Min', 'No limit', 'Custom'],
          [Colors.blue, Colors.green, Colors.orange, Colors.red],
        ),

        // Section 8: Multiple Sliders Combined
        buildSectionHeader('8. Combined Filter Panel'),
        Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(),
                buildLabeledRangeSlider(
                  'Price Range',
                  RangeValues(100, 500),
                  Colors.green.shade700,
                  Colors.green.shade100,
                  min: 0,
                  max: 1000,
                  divisions: 20,
                  prefix: '\$',
                ),
                buildLabeledRangeSlider(
                  'Rating',
                  RangeValues(3, 5),
                  Colors.amber.shade700,
                  Colors.amber.shade100,
                  min: 0,
                  max: 5,
                  divisions: 50,
                  suffix: ' stars',
                ),
                buildLabeledRangeSlider(
                  'Distance',
                  RangeValues(1, 10),
                  Colors.blue.shade700,
                  Colors.blue.shade100,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  suffix: ' km',
                ),
                buildLabeledRangeSlider(
                  'Year',
                  RangeValues(2020, 2024),
                  Colors.purple.shade700,
                  Colors.purple.shade100,
                  min: 2000,
                  max: 2025,
                  divisions: 25,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: Text('Reset')),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Apply Filters'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of BaseRangeSliderTrackShape Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
