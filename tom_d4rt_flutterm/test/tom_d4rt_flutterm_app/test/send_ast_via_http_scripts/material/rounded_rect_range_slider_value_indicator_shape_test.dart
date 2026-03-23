// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundedRectRangeSliderValueIndicatorShape from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

Widget buildRangeSliderWithRoundedRectIndicator(
  String label,
  Color activeColor,
  Color indicatorColor,
  double startVal,
  double endVal,
  bool showLabels,
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
          'Range: ${startVal.toInt()} - ${endVal.toInt()} | Labels: $showLabels',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        SliderTheme(
          data: SliderThemeData(
            rangeValueIndicatorShape:
                RoundedRectRangeSliderValueIndicatorShape(),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            valueIndicatorColor: indicatorColor,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            trackHeight: 4,
            overlayColor: activeColor.withAlpha(40),
          ),
          child: RangeSlider(
            values: RangeValues(startVal, endVal),
            min: 0,
            max: 100,
            divisions: 20,
            labels: showLabels
                ? RangeLabels('${startVal.toInt()}', '${endVal.toInt()}')
                : null,
            onChanged: (RangeValues vals) {},
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Min: 0',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: indicatorColor.withAlpha(30),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${startVal.toInt()} - ${endVal.toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: indicatorColor,
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

Widget buildIndicatorColorVariations() {
  print('Building indicator color variations');
  List<String> colorNames = [
    'Deep Purple',
    'Teal',
    'Orange',
    'Pink',
    'Indigo',
    'Green',
  ];
  List<MaterialColor> indicatorColors = [
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
    Colors.green,
  ];
  List<double> startValues = [15.0, 25.0, 10.0, 35.0, 20.0, 40.0];
  List<double> endValues = [55.0, 70.0, 60.0, 80.0, 65.0, 90.0];

  List<Widget> sliders = [];
  int i = 0;
  for (i = 0; i < colorNames.length; i = i + 1) {
    sliders.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: indicatorColors[i].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: indicatorColors[i].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: indicatorColors[i],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  colorNames[i],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: indicatorColors[i].shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeValueIndicatorShape:
                    RoundedRectRangeSliderValueIndicatorShape(),
                activeTrackColor: indicatorColors[i],
                inactiveTrackColor: indicatorColors[i].withAlpha(50),
                rangeThumbShape:
                    RoundRangeSliderThumbShape(enabledThumbRadius: 8),
                valueIndicatorColor: indicatorColors[i],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                trackHeight: 3,
              ),
              child: RangeSlider(
                values: RangeValues(startValues[i], endValues[i]),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  '${startValues[i].toInt()}',
                  '${endValues[i].toInt()}',
                ),
                onChanged: (RangeValues vals) {},
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
          'Indicator Color Palette',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Rounded rectangle indicators in different colors',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sliders),
      ],
    ),
  );
}

Widget buildShowLabelsComparison() {
  print('Building show labels comparison');
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
          'Label Display Modes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Comparing sliders with and without value labels',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'With Labels (divisions: 10)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  rangeValueIndicatorShape:
                      RoundedRectRangeSliderValueIndicatorShape(),
                  activeTrackColor: Colors.teal,
                  inactiveTrackColor: Colors.teal.withAlpha(50),
                  rangeThumbShape:
                      RoundRangeSliderThumbShape(enabledThumbRadius: 10),
                  valueIndicatorColor: Colors.teal.shade700,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  trackHeight: 4,
                ),
                child: RangeSlider(
                  values: RangeValues(20.0, 80.0),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  labels: RangeLabels('20', '80'),
                  onChanged: (RangeValues vals) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Without Labels (continuous)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  rangeValueIndicatorShape:
                      RoundedRectRangeSliderValueIndicatorShape(),
                  activeTrackColor: Colors.grey.shade600,
                  inactiveTrackColor: Colors.grey.shade300,
                  rangeThumbShape:
                      RoundRangeSliderThumbShape(enabledThumbRadius: 10),
                  valueIndicatorColor: Colors.grey.shade700,
                  trackHeight: 4,
                ),
                child: RangeSlider(
                  values: RangeValues(30.0, 70.0),
                  min: 0,
                  max: 100,
                  onChanged: (RangeValues vals) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'With Fine Divisions (divisions: 50)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  rangeValueIndicatorShape:
                      RoundedRectRangeSliderValueIndicatorShape(),
                  activeTrackColor: Colors.amber.shade700,
                  inactiveTrackColor: Colors.amber.shade200,
                  rangeThumbShape:
                      RoundRangeSliderThumbShape(enabledThumbRadius: 10),
                  valueIndicatorColor: Colors.amber.shade800,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  trackHeight: 4,
                ),
                child: RangeSlider(
                  values: RangeValues(25.0, 75.0),
                  min: 0,
                  max: 100,
                  divisions: 50,
                  labels: RangeLabels('25', '75'),
                  onChanged: (RangeValues vals) {},
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSliderThemeConfigurations() {
  print('Building slider theme configurations');
  List<String> configNames = [
    'Default Style',
    'Compact',
    'Bold',
    'Minimal',
    'Accent',
    'Muted',
  ];
  List<MaterialColor> configColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.grey,
    Colors.deepOrange,
    Colors.blueGrey,
  ];
  List<double> configTrackHeights = [4.0, 2.0, 8.0, 1.0, 6.0, 3.0];
  List<double> configThumbRadii = [10.0, 6.0, 14.0, 4.0, 12.0, 8.0];
  List<double> configStartVals = [20.0, 15.0, 25.0, 30.0, 10.0, 35.0];
  List<double> configEndVals = [60.0, 55.0, 80.0, 70.0, 75.0, 65.0];

  List<Widget> configCards = [];
  int c = 0;
  for (c = 0; c < configNames.length; c = c + 1) {
    configCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: configColors[c].shade200),
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
                    color: configColors[c],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  configNames[c],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Track: ${configTrackHeights[c].toInt()}px | Thumb: ${configThumbRadii[c].toInt()}px',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeValueIndicatorShape:
                    RoundedRectRangeSliderValueIndicatorShape(),
                activeTrackColor: configColors[c],
                inactiveTrackColor: configColors[c].withAlpha(50),
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: configThumbRadii[c],
                ),
                valueIndicatorColor: configColors[c],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                trackHeight: configTrackHeights[c],
                overlayColor: configColors[c].withAlpha(30),
              ),
              child: RangeSlider(
                values: RangeValues(configStartVals[c], configEndVals[c]),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  '${configStartVals[c].toInt()}',
                  '${configEndVals[c].toInt()}',
                ),
                onChanged: (RangeValues vals) {},
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
          'SliderTheme Configurations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different theme settings with RoundedRectRangeSliderValueIndicatorShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: configCards),
      ],
    ),
  );
}

Widget buildDisplayModeShowcase() {
  print('Building display mode showcase');
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
          'Display Mode Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'ShowValueIndicator settings for range sliders',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        buildDisplayModeCard(
          'On Drag',
          'Value indicators visible when dragging',
          ShowValueIndicator.onDrag,
          Colors.purple,
          15.0,
          65.0,
        ),
        SizedBox(height: 12),
        buildDisplayModeCard(
          'On Change Only',
          'Indicators appear only while dragging',
          ShowValueIndicator.onlyForContinuous,
          Colors.blue,
          20.0,
          70.0,
        ),
        SizedBox(height: 12),
        buildDisplayModeCard(
          'Discrete Only',
          'For discrete sliders with divisions',
          ShowValueIndicator.onlyForDiscrete,
          Colors.green,
          25.0,
          75.0,
        ),
        SizedBox(height: 12),
        buildDisplayModeCard(
          'Never Show',
          'Value indicators hidden',
          ShowValueIndicator.never,
          Colors.grey,
          30.0,
          80.0,
        ),
      ],
    ),
  );
}

Widget buildDisplayModeCard(
  String title,
  String subtitle,
  ShowValueIndicator showMode,
  MaterialColor color,
  double startVal,
  double endVal,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.visibility, size: 18, color: color.shade700),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            rangeValueIndicatorShape:
                RoundedRectRangeSliderValueIndicatorShape(),
            showValueIndicator: showMode,
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(50),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 9),
            valueIndicatorColor: color.shade700,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
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
      ],
    ),
  );
}

Widget buildIndicatorShapeAnatomy() {
  print('Building indicator shape anatomy');
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
          'Rounded Rect Indicator Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Components of the value indicator shape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomPaint(
                  painter: _RoundedRectIndicatorPainter(Colors.teal),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '50',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAnatomyItem('Shape', 'Rounded rectangle', Icons.crop_square),
                  SizedBox(height: 8),
                  buildAnatomyItem('Corners', 'Rounded edges', Icons.rounded_corner),
                  SizedBox(height: 8),
                  buildAnatomyItem('Text', 'Centered value', Icons.text_fields),
                  SizedBox(height: 8),
                  buildAnatomyItem('Pointer', 'Bottom arrow', Icons.arrow_downward),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildAnatomyItem(String label, String value, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 16, color: Colors.teal.shade600),
      SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    ],
  );
}

Widget buildTextStyleVariations() {
  print('Building text style variations');
  List<String> styleNames = [
    'Default',
    'Bold Large',
    'Light Small',
    'Italic',
  ];
  List<TextStyle> textStyles = [
    TextStyle(color: Colors.white, fontSize: 12),
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300),
    TextStyle(color: Colors.white, fontSize: 13, fontStyle: FontStyle.italic),
  ];
  List<MaterialColor> styleColors = [
    Colors.indigo,
    Colors.deepPurple,
    Colors.cyan,
    Colors.pink,
  ];

  List<Widget> styleCards = [];
  int s = 0;
  for (s = 0; s < styleNames.length; s = s + 1) {
    styleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: styleColors[s].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: styleColors[s].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              styleNames[s],
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: styleColors[s].shade800,
              ),
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeValueIndicatorShape:
                    RoundedRectRangeSliderValueIndicatorShape(),
                activeTrackColor: styleColors[s],
                inactiveTrackColor: styleColors[s].withAlpha(50),
                rangeThumbShape:
                    RoundRangeSliderThumbShape(enabledThumbRadius: 9),
                valueIndicatorColor: styleColors[s],
                valueIndicatorTextStyle: textStyles[s],
                trackHeight: 4,
              ),
              child: RangeSlider(
                values: RangeValues(20.0 + s * 5, 70.0 + s * 5),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  '${(20 + s * 5).toInt()}',
                  '${(70 + s * 5).toInt()}',
                ),
                onChanged: (RangeValues vals) {},
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
          'Indicator Text Styles',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Custom valueIndicatorTextStyle configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: styleCards),
      ],
    ),
  );
}

Widget buildUseCaseExamples() {
  print('Building use case examples');
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
          'Practical applications of RangeSlider with rounded rect indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        buildUseCaseCard(
          'Price Range Filter',
          '\$50 - \$250',
          Icons.attach_money,
          Colors.green,
          50.0,
          250.0,
          0.0,
          500.0,
        ),
        SizedBox(height: 12),
        buildUseCaseCard(
          'Age Range Selector',
          '25 - 65 years',
          Icons.person,
          Colors.blue,
          25.0,
          65.0,
          18.0,
          100.0,
        ),
        SizedBox(height: 12),
        buildUseCaseCard(
          'Temperature Range',
          '18C - 28C',
          Icons.thermostat,
          Colors.orange,
          18.0,
          28.0,
          0.0,
          50.0,
        ),
        SizedBox(height: 12),
        buildUseCaseCard(
          'Time Range',
          '9:00 - 17:00',
          Icons.access_time,
          Colors.purple,
          9.0,
          17.0,
          0.0,
          24.0,
        ),
      ],
    ),
  );
}

Widget buildUseCaseCard(
  String title,
  String rangeText,
  IconData icon,
  MaterialColor color,
  double startVal,
  double endVal,
  double minVal,
  double maxVal,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color.shade700),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                rangeText,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            rangeValueIndicatorShape:
                RoundedRectRangeSliderValueIndicatorShape(),
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(50),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 9),
            valueIndicatorColor: color.shade700,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            trackHeight: 4,
          ),
          child: RangeSlider(
            values: RangeValues(startVal, endVal),
            min: minVal,
            max: maxVal,
            divisions: ((maxVal - minVal) / 5).toInt(),
            labels: RangeLabels(
              '${startVal.toInt()}',
              '${endVal.toInt()}',
            ),
            onChanged: (RangeValues vals) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonWithOtherShapes() {
  print('Building comparison with other shapes');
  List<String> shapeNames = [
    'Rounded Rect (this demo)',
    'Paddle Shape',
    'Rectangle Shape',
  ];
  List<IconData> shapeIcons = [
    Icons.rounded_corner,
    Icons.sports_tennis,
    Icons.rectangle,
  ];
  List<MaterialColor> shapeColors = [
    Colors.teal,
    Colors.deepPurple,
    Colors.orange,
  ];

  List<Widget> shapeItems = [];
  int sh = 0;
  for (sh = 0; sh < shapeNames.length; sh = sh + 1) {
    shapeItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: shapeColors[sh].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: shapeColors[sh].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: shapeColors[sh].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                shapeIcons[sh],
                color: shapeColors[sh].shade700,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shapeNames[sh],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: shapeColors[sh].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Range value indicator shape option',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: shapeColors[sh],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                sh == 0 ? 'Current' : 'Alt',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
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
          'Range Indicator Shape Options',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Alternative shapes for rangeValueIndicatorShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: shapeItems),
      ],
    ),
  );
}

Widget build(BuildContext context) {
  print('RoundedRectRangeSliderValueIndicatorShape deep demo started');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RoundedRectRangeSliderValueIndicatorShape Demo'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RoundedRectRangeSliderValueIndicatorShape'),
            buildInfoCard(
              'Purpose',
              'Value indicator tooltip shape for RangeSlider widgets',
            ),
            buildInfoCard(
              'Used In',
              'SliderThemeData.rangeValueIndicatorShape',
            ),
            buildInfoCard(
              'Appearance',
              'Rounded rectangle with pointer at bottom',
            ),

            buildSectionHeader('2. Basic Range Sliders with Value Indicators'),
            buildRangeSliderWithRoundedRectIndicator(
              'Teal Range Slider',
              Colors.teal,
              Colors.teal.shade700,
              20.0,
              70.0,
              true,
            ),
            buildRangeSliderWithRoundedRectIndicator(
              'Purple Range Slider',
              Colors.deepPurple,
              Colors.deepPurple.shade700,
              15.0,
              85.0,
              true,
            ),
            buildRangeSliderWithRoundedRectIndicator(
              'Orange Range Slider',
              Colors.orange.shade700,
              Colors.orange.shade800,
              30.0,
              60.0,
              true,
            ),

            buildSectionHeader('3. Show Range Labels'),
            buildShowLabelsComparison(),

            buildSectionHeader('4. Indicator Colors'),
            buildIndicatorColorVariations(),

            buildSectionHeader('5. SliderTheme Configuration'),
            buildSliderThemeConfigurations(),

            buildSectionHeader('6. Display Modes'),
            buildDisplayModeShowcase(),

            buildSectionHeader('7. Indicator Anatomy'),
            buildIndicatorShapeAnatomy(),

            buildSectionHeader('8. Text Style Variations'),
            buildTextStyleVariations(),

            buildSectionHeader('9. Use Case Examples'),
            buildUseCaseExamples(),

            buildSectionHeader('10. Comparison with Other Shapes'),
            buildComparisonWithOtherShapes(),

            buildSectionHeader('11. Configuration Tips'),
            buildInfoCard(
              'Tip 1',
              'Set rangeValueIndicatorShape in SliderThemeData',
            ),
            buildInfoCard(
              'Tip 2',
              'Use divisions to enable value snapping and labels',
            ),
            buildInfoCard(
              'Tip 3',
              'valueIndicatorColor controls the indicator background',
            ),
            buildInfoCard(
              'Tip 4',
              'valueIndicatorTextStyle customizes the text appearance',
            ),
            buildInfoCard(
              'Tip 5',
              'showValueIndicator controls visibility behavior',
            ),
            buildInfoCard(
              'Tip 6',
              'Combine with RoundRangeSliderThumbShape for consistency',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RoundedRectRangeSliderValueIndicatorShape deep demo completed');
  return result;
}

class _RoundedRectIndicatorPainter extends CustomPainter {
  Color color;
  _RoundedRectIndicatorPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    double cx = size.width / 2;
    double cy = size.height / 2 - 10;
    double rectWidth = 50;
    double rectHeight = 30;
    double radius = 6;

    RRect rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: rectWidth, height: rectHeight),
      Radius.circular(radius),
    );
    canvas.drawRRect(rRect, paint);

    Path path = Path();
    path.moveTo(cx - 8, cy + rectHeight / 2);
    path.lineTo(cx, cy + rectHeight / 2 + 12);
    path.lineTo(cx + 8, cy + rectHeight / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RoundedRectIndicatorPainter oldDelegate) {
    return false;
  }
}
