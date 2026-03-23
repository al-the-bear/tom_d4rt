// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RectangularSliderValueIndicatorShape from material
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

Widget buildSliderWithRectIndicator(
  String label,
  Color activeColor,
  Color thumbColor,
  double initialValue,
  bool showLabel,
) {
  print('Building slider with rectangular indicator: $label');
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
            valueIndicatorShape: RectangularSliderValueIndicatorShape(),
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

Widget buildRangeSliderWithRectIndicator(
  String label,
  Color activeColor,
  double startVal,
  double endVal,
) {
  print('Building range slider with rectangular indicator: $label');
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
    'Rectangular Shape',
    'Paddle Shape',
    'Drop Shape',
    'Round Shape',
  ];
  List<MaterialColor> shapeColors = [
    Colors.indigo,
    Colors.teal,
    Colors.deepPurple,
    Colors.pink,
  ];
  List<IconData> shapeIcons = [
    Icons.rectangle,
    Icons.sports_tennis,
    Icons.water_drop,
    Icons.circle,
  ];
  List<String> shapeDescriptions = [
    'Simple rectangular tooltip above thumb',
    'Paddle with rounded top and pointed bottom',
    'Teardrop pointing to thumb position',
    'Circular indicator centered on thumb',
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
                    shapeDescriptions[i],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: shapeColors[i].shade700,
                borderRadius: BorderRadius.circular(4),
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
          'Rectangular is the simplest and most compact shape',
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
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
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
                valueIndicatorShape: RectangularSliderValueIndicatorShape(),
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
          'Each using RectangularSliderValueIndicatorShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: themeCards),
      ],
    ),
  );
}

Widget buildRectangularIndicatorAnatomy() {
  print('Building rectangular indicator anatomy');
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
          'Rectangular Indicator Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Container(
                width: 64,
                height: 32,
                child: CustomPaint(
                  painter: _RectShapePainter(Colors.indigo),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Rectangular Shape',
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
          'Simple rectangular container for value text',
          Colors.indigo.shade100,
        ),
        _buildAnatomyRow(
          'Corners',
          'Slightly rounded corners for softer appearance',
          Colors.indigo.shade200,
        ),
        _buildAnatomyRow(
          'Text',
          'Centered label showing current slider value',
          Colors.indigo.shade300,
        ),
        _buildAnatomyRow(
          'Arrow',
          'Small triangular pointer toward the thumb',
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
            borderRadius: BorderRadius.circular(4),
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
  List<MaterialColor> colors = [
    Colors.indigo,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
  ];
  List<String> colorNames = [
    'Indigo',
    'Red',
    'Green',
    'Orange',
    'Purple',
    'Teal',
    'Pink',
    'Cyan',
  ];
  List<double> colorValues = [70.0, 45.0, 60.0, 35.0, 80.0, 25.0, 55.0, 90.0];

  List<Widget> colorItems = [];
  int c = 0;
  for (c = 0; c < colors.length; c = c + 1) {
    colorItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors[c].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors[c].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: colors[c],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Text(
              colorNames[c],
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colors[c].shade800,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  valueIndicatorShape:
                      RectangularSliderValueIndicatorShape(),
                  activeTrackColor: colors[c],
                  inactiveTrackColor: colors[c].withAlpha(50),
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
                  value: colorValues[c],
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${colorValues[c].toInt()}',
                  onChanged: (double v) {},
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 36,
              alignment: Alignment.center,
              child: Text(
                '${colorValues[c].toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colors[c].shade700,
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
          'Color Showcase',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Rectangular indicators in various Material colors',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorItems),
      ],
    ),
  );
}

Widget buildSliderProperties() {
  print('Building slider properties display');
  List<String> propertyNames = [
    'valueIndicatorShape',
    'valueIndicatorColor',
    'valueIndicatorTextStyle',
    'showValueIndicator',
    'thumbColor',
    'trackHeight',
  ];
  List<String> propertyValues = [
    'RectangularSliderValueIndicatorShape()',
    'Colors.indigo',
    'TextStyle(color: white, fontSize: 14)',
    'ShowValueIndicator.always',
    'Colors.indigo',
    '4.0',
  ];
  List<String> propertyDescriptions = [
    'The shape class for the value indicator',
    'Background color of the rectangular indicator',
    'Text styling for the value label',
    'When to display the value indicator',
    'Color of the slider thumb',
    'Height of the slider track',
  ];

  List<Widget> propertyCards = [];
  int p = 0;
  for (p = 0; p < propertyNames.length; p = p + 1) {
    propertyCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code, size: 16, color: Colors.indigo.shade600),
                SizedBox(width: 8),
                Text(
                  propertyNames[p],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                propertyValues[p],
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              propertyDescriptions[p],
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
          'Configuration Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Key SliderThemeData properties for rectangular indicator',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: propertyCards),
      ],
    ),
  );
}

Widget buildStyledTooltipAreas() {
  print('Building styled tooltip areas');
  List<String> tooltipStyles = [
    'Standard',
    'Rounded',
    'Sharp',
    'Large Text',
    'Small Text',
    'High Contrast',
  ];
  List<Color> tooltipColors = [
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.purple,
    Colors.blueGrey,
    Colors.black,
  ];
  List<double> tooltipFontSizes = [14.0, 14.0, 14.0, 18.0, 10.0, 16.0];
  List<FontWeight> tooltipFontWeights = [
    FontWeight.normal,
    FontWeight.bold,
    FontWeight.w500,
    FontWeight.bold,
    FontWeight.normal,
    FontWeight.bold,
  ];
  List<double> tooltipValues = [50.0, 65.0, 35.0, 80.0, 25.0, 70.0];

  List<Widget> tooltipCards = [];
  int s = 0;
  for (s = 0; s < tooltipStyles.length; s = s + 1) {
    tooltipCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tooltipColors[s].withAlpha(100)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: tooltipColors[s],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tooltipStyles[s],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Font: ${tooltipFontSizes[s].toInt()}px',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: RectangularSliderValueIndicatorShape(),
                activeTrackColor: tooltipColors[s],
                inactiveTrackColor: tooltipColors[s].withAlpha(50),
                thumbColor: tooltipColors[s],
                valueIndicatorColor: tooltipColors[s],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: tooltipFontSizes[s],
                  fontWeight: tooltipFontWeights[s],
                ),
                trackHeight: 4,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: tooltipValues[s],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${tooltipValues[s].toInt()}',
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
          'Styled Tooltip Areas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different text styles in rectangular value indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: tooltipCards),
      ],
    ),
  );
}

Widget buildShowValueIndicatorModes() {
  print('Building showValueIndicator modes');
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
          'ShowValueIndicator Modes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Control when the rectangular indicator appears',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        _buildModeCard(
          'onDrag',
          'Indicator shown while dragging',
          ShowValueIndicator.onDrag,
          Colors.indigo,
          55.0,
        ),
        _buildModeCard(
          'onlyForDiscrete',
          'Only shown for sliders with divisions',
          ShowValueIndicator.onlyForDiscrete,
          Colors.green,
          40.0,
        ),
        _buildModeCard(
          'onlyForContinuous',
          'Only shown for continuous sliders',
          ShowValueIndicator.onlyForContinuous,
          Colors.orange,
          70.0,
        ),
        _buildModeCard(
          'never',
          'Indicator never displayed',
          ShowValueIndicator.never,
          Colors.grey,
          30.0,
        ),
      ],
    ),
  );
}

Widget _buildModeCard(
  String modeName,
  String description,
  ShowValueIndicator mode,
  MaterialColor color,
  double value,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.shade700,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                modeName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SliderTheme(
          data: SliderThemeData(
            valueIndicatorShape: RectangularSliderValueIndicatorShape(),
            showValueIndicator: mode,
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(50),
            thumbColor: color,
            valueIndicatorColor: color,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            divisions: 10,
            label: '${value.toInt()}',
            onChanged: (double v) {},
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('Starting RectangularSliderValueIndicatorShape deep demo');
  print('Widget demonstrates rectangular tooltip style value indicators');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey.shade100,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RectangularSliderValueIndicatorShape Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RectangularSliderValueIndicatorShape'),
            buildInfoCard(
              'Purpose',
              'A slider value indicator with a rectangular tooltip shape',
            ),
            buildInfoCard('Used In', 'SliderThemeData.valueIndicatorShape'),
            buildInfoCard(
              'Appearance',
              'Simple rectangular box with arrow pointing to thumb',
            ),

            buildSectionHeader('2. Basic Rectangular Indicator Sliders'),
            buildSliderWithRectIndicator(
              'Indigo Rectangular Slider',
              Colors.indigo,
              Colors.indigo.shade300,
              65.0,
              true,
            ),
            buildSliderWithRectIndicator(
              'Teal Rectangular Slider',
              Colors.teal,
              Colors.teal.shade300,
              40.0,
              true,
            ),
            buildSliderWithRectIndicator(
              'Orange Rectangular Slider',
              Colors.orange.shade700,
              Colors.orange,
              80.0,
              true,
            ),

            buildSectionHeader('3. ShowValueIndicator Modes'),
            buildShowValueIndicatorModes(),

            buildSectionHeader('4. Range Sliders'),
            buildRangeSliderWithRectIndicator(
              'Price Range',
              Colors.indigo,
              20.0,
              70.0,
            ),
            buildRangeSliderWithRectIndicator(
              'Temperature Range',
              Colors.red,
              30.0,
              85.0,
            ),
            buildRangeSliderWithRectIndicator(
              'Age Range',
              Colors.blue,
              10.0,
              50.0,
            ),

            buildSectionHeader('5. Shape Comparison'),
            buildIndicatorShapeComparison(),

            buildSectionHeader('6. Rectangular Indicator Anatomy'),
            buildRectangularIndicatorAnatomy(),

            buildSectionHeader('7. Theme Variations'),
            buildSliderThemeGrid(),

            buildSectionHeader('8. Color Showcase'),
            buildSliderColorShowcase(),

            buildSectionHeader('9. Styled Tooltip Areas'),
            buildStyledTooltipAreas(),

            buildSectionHeader('10. Configuration Properties'),
            buildSliderProperties(),

            buildSectionHeader('11. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Set valueIndicatorShape to RectangularSliderValueIndicatorShape()',
            ),
            buildInfoCard(
              'Tip 2',
              'Use divisions for snapping and showing value labels',
            ),
            buildInfoCard(
              'Tip 3',
              'valueIndicatorColor controls the rectangular background',
            ),
            buildInfoCard(
              'Tip 4',
              'Rectangular shape is more compact than paddle or drop',
            ),
            buildInfoCard(
              'Tip 5',
              'Set showValueIndicator to control display behavior',
            ),
            buildInfoCard(
              'Tip 6',
              'Combine with consistent thumbShape for unified design',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RectangularSliderValueIndicatorShape deep demo completed');
  return result;
}

class _RectShapePainter extends CustomPainter {
  Color color;
  _RectShapePainter(this.color);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    double rectHeight = size.height * 0.7;
    double rectWidth = size.width;

    RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, rectWidth, rectHeight),
      Radius.circular(4),
    );
    canvas.drawRRect(rect, paint);

    Path arrow = Path();
    double cx = size.width / 2;
    arrow.moveTo(cx - 6, rectHeight);
    arrow.lineTo(cx, size.height);
    arrow.lineTo(cx + 6, rectHeight);
    arrow.close();
    canvas.drawPath(arrow, paint);
  }

  bool shouldRepaint(_RectShapePainter oldDelegate) {
    return false;
  }
}
