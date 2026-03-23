// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundedRectSliderValueIndicatorShape from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
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

Widget buildSliderWithRoundedRectIndicator(
  String label,
  Color activeColor,
  Color thumbColor,
  double initialValue,
  bool showLabel,
) {
  print('Building slider with rounded rect indicator: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Active: $activeColor',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            valueIndicatorShape: RoundedRectSliderValueIndicatorShape(),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: thumbColor,
            valueIndicatorColor: activeColor,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: initialValue,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${initialValue.toInt()}',
            onChanged: (double val) {},
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
            Text(
              'Value: ${initialValue.toInt()}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: activeColor,
              ),
            ),
            Text(
              '100',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildRangeSliderWithRoundedRectIndicator(
  String label,
  Color activeColor,
  double startVal,
  double endVal,
) {
  print('Building range slider with rounded rect indicator: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Range: ${startVal.toInt()} - ${endVal.toInt()}',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            rangeValueIndicatorShape:
                RectangularRangeSliderValueIndicatorShape(),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            valueIndicatorColor: activeColor,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            trackHeight: 4,
          ),
          child: RangeSlider(
            values: RangeValues(startVal, endVal),
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels('${startVal.toInt()}', '${endVal.toInt()}'),
            onChanged: (RangeValues vals) {},
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Min: 0',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: activeColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${startVal.toInt()} - ${endVal.toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: activeColor,
                ),
              ),
            ),
            Text(
              'Max: 100',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildIndicatorShapeComparison() {
  print('Building indicator shape comparison');
  List<String> shapeNames = [
    'Rounded Rectangle',
    'Paddle Shape',
    'Drop Shape',
    'Rectangular Shape',
  ];
  List<MaterialColor> shapeColors = [
    Colors.indigo,
    Colors.teal,
    Colors.deepPurple,
    Colors.orange,
  ];
  List<IconData> shapeIcons = [
    Icons.rounded_corner,
    Icons.sports_tennis,
    Icons.water_drop,
    Icons.rectangle,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < shapeNames.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: shapeColors[i].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: shapeColors[i].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: shapeColors[i].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                shapeIcons[i],
                color: shapeColors[i].shade700,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shapeNames[i],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: shapeColors[i].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Value indicator variant ${i + 1}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: shapeColors[i].shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(i + 1) * 25}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Value Indicator Shape Types',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different shapes available for slider value indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildSliderThemeGrid() {
  print('Building slider theme grid');
  List<String> themeLabels = [
    'Default',
    'Compact',
    'Bold',
    'Minimal',
    'Accent',
    'Muted',
  ];
  List<MaterialColor> themeActiveColors = [
    Colors.indigo,
    Colors.green,
    Colors.red,
    Colors.grey,
    Colors.amber,
    Colors.blueGrey,
  ];
  List<double> themeTrackHeights = [4.0, 2.0, 8.0, 1.0, 6.0, 3.0];
  List<double> themeThumbRadii = [10.0, 6.0, 14.0, 4.0, 12.0, 8.0];
  List<double> themeValues = [50.0, 30.0, 75.0, 40.0, 60.0, 20.0];

  List<Widget> themeCards = [];
  int t = 0;
  for (t = 0; t < themeLabels.length; t = t + 1) {
    themeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: themeActiveColors[t].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: themeActiveColors[t],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  themeLabels[t],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Track: ${themeTrackHeights[t].toInt()}px',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: RoundedRectSliderValueIndicatorShape(),
                activeTrackColor: themeActiveColors[t],
                inactiveTrackColor: themeActiveColors[t].withAlpha(50),
                thumbColor: themeActiveColors[t],
                valueIndicatorColor: themeActiveColors[t],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                trackHeight: themeTrackHeights[t],
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: themeThumbRadii[t],
                ),
              ),
              child: Slider(
                value: themeValues[t],
                min: 0,
                max: 100,
                divisions: 10,
                label: '${themeValues[t].toInt()}',
                onChanged: (double v) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
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
          'Slider Theme Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Each using RoundedRectSliderValueIndicatorShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: themeCards),
      ],
    ),
  );
}

Widget buildRoundedRectIndicatorAnatomy() {
  print('Building rounded rect indicator anatomy');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rounded Rectangle Indicator Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Container(
                width: 64,
                height: 40,
                child: CustomPaint(
                  painter: _RoundedRectShapePainter(Colors.indigo),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Rounded Rectangle Shape',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildAnatomyRow(
          'Body',
          'Rectangular container with rounded corners for the value',
          Colors.indigo.shade100,
        ),
        _buildAnatomyRow(
          'Corner Radius',
          'Smooth rounded edges giving a pill-like appearance',
          Colors.indigo.shade200,
        ),
        _buildAnatomyRow(
          'Text',
          'Centered label showing current slider value',
          Colors.indigo.shade300,
        ),
        _buildAnatomyRow(
          'Arrow',
          'Small triangular pointer towards the thumb position',
          Colors.indigo.shade400,
        ),
      ],
    ),
  );
}

Widget _buildAnatomyRow(String part, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                part,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSliderColorShowcase() {
  print('Building slider color showcase');
  List<String> colorNames = [
    'Indigo',
    'Teal',
    'Red',
    'Green',
    'Blue',
    'Amber',
    'Purple',
    'Cyan',
  ];
  List<Color> colors = [
    Colors.indigo,
    Colors.teal,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber.shade700,
    Colors.purple,
    Colors.cyan,
  ];
  List<double> values = [65.0, 45.0, 80.0, 30.0, 55.0, 70.0, 25.0, 90.0];

  List<Widget> sliderItems = [];
  int c = 0;
  for (c = 0; c < colorNames.length; c = c + 1) {
    sliderItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
              width: 80,
              child: Text(
                colorNames[c],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  valueIndicatorShape: RoundedRectSliderValueIndicatorShape(),
                  activeTrackColor: colors[c],
                  inactiveTrackColor: colors[c].withAlpha(40),
                  thumbColor: colors[c],
                  valueIndicatorColor: colors[c],
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                  trackHeight: 3,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
                ),
                child: Slider(
                  value: values[c],
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${values[c].toInt()}',
                  onChanged: (double v) {},
                ),
              ),
            ),
            Container(
              width: 30,
              child: Text(
                '${values[c].toInt()}',
                style: TextStyle(
                  fontSize: 11,
                  color: colors[c],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rounded Rect Indicator Color Showcase',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Column(children: sliderItems),
      ],
    ),
  );
}

Widget buildSliderProperties() {
  print('Building slider properties');
  List<String> propNames = [
    'valueIndicatorShape',
    'valueIndicatorColor',
    'valueIndicatorTextStyle',
    'showValueIndicator',
    'trackHeight',
    'thumbShape',
  ];
  List<String> propVals = [
    'RoundedRectSliderValueIndicatorShape()',
    'Color - indicator background color',
    'TextStyle - text inside the indicator',
    'ShowValueIndicator enum value',
    'double - height of the track',
    'SliderComponentShape - thumb appearance',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                propVals[p],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'SliderThemeData Properties for Rounded Rect Indicator',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

Widget buildComparisonWithOtherShapes() {
  print('Building comparison with other shapes');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rounded Rect vs Other Indicator Shapes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _buildComparisonItem(
          'Rounded Rect',
          'Clean pill-shaped tooltip with rounded corners',
          RoundedRectSliderValueIndicatorShape(),
          Colors.indigo,
          55.0,
        ),
        SizedBox(height: 8),
        _buildComparisonItem(
          'Paddle',
          'Traditional paddle-shaped indicator with stem',
          PaddleSliderValueIndicatorShape(),
          Colors.teal,
          65.0,
        ),
        SizedBox(height: 8),
        _buildComparisonItem(
          'Drop',
          'Teardrop shape pointing down to thumb',
          DropSliderValueIndicatorShape(),
          Colors.deepPurple,
          75.0,
        ),
        SizedBox(height: 8),
        _buildComparisonItem(
          'Rectangular',
          'Simple rectangle with sharp corners',
          RectangularSliderValueIndicatorShape(),
          Colors.orange,
          45.0,
        ),
      ],
    ),
  );
}

Widget _buildComparisonItem(
  String name,
  String description,
  SliderComponentShape shape,
  Color color,
  double value,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            valueIndicatorShape: shape,
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(40),
            thumbColor: color,
            valueIndicatorColor: color,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            trackHeight: 3,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${value.toInt()}',
            onChanged: (double v) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildUseCasesSection() {
  print('Building use cases section');
  List<String> useCaseNames = [
    'Volume Control',
    'Brightness Adjustment',
    'Zoom Level',
    'Progress Indicator',
    'Rating Selector',
    'Timer Duration',
  ];
  List<IconData> useCaseIcons = [
    Icons.volume_up,
    Icons.brightness_6,
    Icons.zoom_in,
    Icons.linear_scale,
    Icons.star,
    Icons.timer,
  ];
  List<MaterialColor> useCaseColors = [
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.red,
  ];
  List<double> useCaseValues = [70.0, 50.0, 35.0, 60.0, 80.0, 45.0];

  List<Widget> useCaseItems = [];
  int u = 0;
  for (u = 0; u < useCaseNames.length; u = u + 1) {
    useCaseItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: useCaseColors[u].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: useCaseColors[u].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  useCaseIcons[u],
                  color: useCaseColors[u].shade700,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  useCaseNames[u],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: useCaseColors[u].shade800,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  '${useCaseValues[u].toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: useCaseColors[u].shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: RoundedRectSliderValueIndicatorShape(),
                activeTrackColor: useCaseColors[u],
                inactiveTrackColor: useCaseColors[u].withAlpha(50),
                thumbColor: useCaseColors[u],
                valueIndicatorColor: useCaseColors[u].shade700,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                trackHeight: 4,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: Slider(
                value: useCaseValues[u],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${useCaseValues[u].toInt()}',
                onChanged: (double v) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common Use Cases',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RoundedRectSliderValueIndicatorShape in real scenarios',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: useCaseItems),
      ],
    ),
  );
}

Widget buildTextStyleVariations() {
  print('Building text style variations');
  List<String> styleNames = [
    'Small Text',
    'Large Text',
    'Bold Text',
    'Italic Style',
    'Colored Text',
    'Light Weight',
  ];
  List<TextStyle> textStyles = [
    TextStyle(color: Colors.white, fontSize: 10),
    TextStyle(color: Colors.white, fontSize: 16),
    TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
    TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.italic),
    TextStyle(color: Colors.yellow, fontSize: 12, fontWeight: FontWeight.bold),
    TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
  ];
  List<double> values = [25.0, 50.0, 75.0, 40.0, 60.0, 85.0];

  List<Widget> styleItems = [];
  int s = 0;
  for (s = 0; s < styleNames.length; s = s + 1) {
    styleItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 90,
              child: Text(
                styleNames[s],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  valueIndicatorShape: RoundedRectSliderValueIndicatorShape(),
                  activeTrackColor: Colors.indigo,
                  inactiveTrackColor: Colors.indigo.withAlpha(40),
                  thumbColor: Colors.indigo,
                  valueIndicatorColor: Colors.indigo,
                  valueIndicatorTextStyle: textStyles[s],
                  trackHeight: 3,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
                ),
                child: Slider(
                  value: values[s],
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${values[s].toInt()}',
                  onChanged: (double v) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Text Style Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different valueIndicatorTextStyle options',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: styleItems),
      ],
    ),
  );
}

Widget buildTrackSizeVariations() {
  print('Building track size variations');
  List<String> sizeNames = ['Thin', 'Normal', 'Medium', 'Thick', 'Extra Thick'];
  List<double> trackHeights = [1.0, 4.0, 6.0, 10.0, 16.0];
  List<double> thumbRadii = [4.0, 8.0, 10.0, 14.0, 18.0];
  List<double> values = [30.0, 50.0, 70.0, 40.0, 60.0];

  List<Widget> sizeItems = [];
  int z = 0;
  for (z = 0; z < sizeNames.length; z = z + 1) {
    sizeItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  sizeNames[z],
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Track: ${trackHeights[z]}px, Thumb: ${thumbRadii[z]}px',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: RoundedRectSliderValueIndicatorShape(),
                activeTrackColor: Colors.indigo,
                inactiveTrackColor: Colors.indigo.withAlpha(40),
                thumbColor: Colors.indigo,
                valueIndicatorColor: Colors.indigo,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                trackHeight: trackHeights[z],
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbRadii[z]),
              ),
              child: Slider(
                value: values[z],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${values[z].toInt()}',
                onChanged: (double v) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track and Thumb Size Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different combinations with RoundedRectSliderValueIndicatorShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sizeItems),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('RoundedRectSliderValueIndicatorShape deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('RoundedRectSliderValueIndicatorShape Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RoundedRectSliderValueIndicatorShape'),
            buildInfoCard(
              'Purpose',
              'A slider value indicator with a rounded rectangle tooltip shape',
            ),
            buildInfoCard('Used In', 'SliderThemeData.valueIndicatorShape'),
            buildInfoCard(
              'Appearance',
              'Pill-shaped indicator with smooth rounded corners',
            ),

            buildSectionHeader('2. Basic Rounded Rect Indicator Sliders'),
            buildSliderWithRoundedRectIndicator(
              'Indigo Rounded Rect Slider',
              Colors.indigo,
              Colors.indigo.shade300,
              65.0,
              true,
            ),
            buildSliderWithRoundedRectIndicator(
              'Teal Rounded Rect Slider',
              Colors.teal,
              Colors.teal.shade300,
              40.0,
              true,
            ),
            buildSliderWithRoundedRectIndicator(
              'Red Rounded Rect Slider',
              Colors.red.shade700,
              Colors.red,
              80.0,
              true,
            ),

            buildSectionHeader('3. Range Sliders'),
            buildRangeSliderWithRoundedRectIndicator(
              'Budget Range',
              Colors.indigo,
              20.0,
              70.0,
            ),
            buildRangeSliderWithRoundedRectIndicator(
              'Time Range',
              Colors.green,
              30.0,
              85.0,
            ),
            buildRangeSliderWithRoundedRectIndicator(
              'Size Filter',
              Colors.orange,
              10.0,
              50.0,
            ),

            buildSectionHeader('4. Shape Comparison'),
            buildIndicatorShapeComparison(),

            buildSectionHeader('5. Rounded Rect Indicator Anatomy'),
            buildRoundedRectIndicatorAnatomy(),

            buildSectionHeader('6. Theme Variations'),
            buildSliderThemeGrid(),

            buildSectionHeader('7. Color Showcase'),
            buildSliderColorShowcase(),

            buildSectionHeader('8. Comparison With Other Shapes'),
            buildComparisonWithOtherShapes(),

            buildSectionHeader('9. Common Use Cases'),
            buildUseCasesSection(),

            buildSectionHeader('10. Text Style Variations'),
            buildTextStyleVariations(),

            buildSectionHeader('11. Track and Thumb Sizes'),
            buildTrackSizeVariations(),

            buildSectionHeader('12. Configuration Properties'),
            buildSliderProperties(),

            buildSectionHeader('13. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Set valueIndicatorShape in SliderThemeData',
            ),
            buildInfoCard(
              'Tip 2',
              'Use divisions for snapping and showing labels',
            ),
            buildInfoCard(
              'Tip 3',
              'valueIndicatorColor controls the rounded rect background',
            ),
            buildInfoCard(
              'Tip 4',
              'The rounded rect shape is more modern and clean looking',
            ),
            buildInfoCard(
              'Tip 5',
              'Ideal for volume, brightness, and similar controls',
            ),
            buildInfoCard(
              'Tip 6',
              'Combine with matching thumbShape for visual consistency',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RoundedRectSliderValueIndicatorShape deep demo completed');
  return result;
}

class _RoundedRectShapePainter extends CustomPainter {
  Color color;
  _RoundedRectShapePainter(this.color);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    double rectHeight = size.height * 0.65;
    double cornerRadius = 8.0;

    RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, rectHeight),
      Radius.circular(cornerRadius),
    );
    canvas.drawRRect(rRect, paint);

    Path arrow = Path();
    double arrowWidth = 12.0;
    double centerX = size.width / 2;
    arrow.moveTo(centerX - arrowWidth / 2, rectHeight - 1);
    arrow.lineTo(centerX, size.height);
    arrow.lineTo(centerX + arrowWidth / 2, rectHeight - 1);
    arrow.close();
    canvas.drawPath(arrow, paint);
  }

  bool shouldRepaint(_RoundedRectShapePainter oldDelegate) {
    return false;
  }
}
