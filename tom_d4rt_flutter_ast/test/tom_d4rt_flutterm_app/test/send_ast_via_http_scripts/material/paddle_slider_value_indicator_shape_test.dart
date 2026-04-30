// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PaddleSliderValueIndicatorShape from material
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

Widget buildSliderWithPaddleIndicator(
  String label,
  Color activeColor,
  Color thumbColor,
  double initialValue,
  bool showLabel,
) {
  print('Building slider with paddle indicator: $label');
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
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
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
            label: showLabel ? '${initialValue.toInt()}' : null,
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

Widget buildPaddleAppearanceDemo() {
  print('Building paddle appearance demo');
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
          'Paddle Indicator Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.sports_tennis, color: Colors.teal, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Paddle Shape',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Extended oval',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.expand, color: Colors.orange, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Pointer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Points to value',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.text_fields, color: Colors.purple, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Label Area',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Shows value',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey.shade600),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Paddle shape extends above thumb with pointed bottom',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMultiplePaddleSliders() {
  print('Building multiple paddle sliders');
  List<String> sliderLabels = [
    'Volume Control',
    'Brightness Level',
    'Zoom Factor',
    'Speed Setting',
    'Quality Level',
  ];
  List<MaterialColor> sliderColors = [
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.red,
    Colors.purple,
  ];
  List<double> sliderValues = [65.0, 80.0, 35.0, 50.0, 90.0];
  List<IconData> sliderIcons = [
    Icons.volume_up,
    Icons.brightness_6,
    Icons.zoom_in,
    Icons.speed,
    Icons.high_quality,
  ];

  List<Widget> sliderItems = [];
  int s = 0;
  for (s = 0; s < sliderLabels.length; s = s + 1) {
    sliderItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: sliderColors[s].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(sliderIcons[s], color: sliderColors[s], size: 20),
                SizedBox(width: 8),
                Text(
                  sliderLabels[s],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: sliderColors[s].shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${sliderValues[s].toInt()}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: sliderColors[s].shade700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                activeTrackColor: sliderColors[s],
                inactiveTrackColor: sliderColors[s].withAlpha(50),
                thumbColor: sliderColors[s],
                valueIndicatorColor: sliderColors[s],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                trackHeight: 4,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: Slider(
                value: sliderValues[s],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${sliderValues[s].toInt()}',
                onChanged: (double val) {},
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
          'Multiple Paddle Sliders',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Various settings using paddle value indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sliderItems),
      ],
    ),
  );
}

Widget buildColorThemingSection() {
  print('Building color theming section');
  List<String> themeNames = [
    'Ocean Theme',
    'Forest Theme',
    'Sunset Theme',
    'Night Theme',
    'Rose Theme',
    'Mint Theme',
  ];
  List<MaterialColor> primaryColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.indigo,
    Colors.pink,
    Colors.teal,
  ];
  List<double> themeValues = [70.0, 45.0, 85.0, 30.0, 60.0, 55.0];

  List<Widget> themeCards = [];
  int t = 0;
  for (t = 0; t < themeNames.length; t = t + 1) {
    themeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColors[t].shade50, primaryColors[t].shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: primaryColors[t],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  themeNames[t],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColors[t].shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                activeTrackColor: primaryColors[t],
                inactiveTrackColor: primaryColors[t].withAlpha(80),
                thumbColor: primaryColors[t].shade700,
                valueIndicatorColor: primaryColors[t].shade700,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                trackHeight: 5,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
              ),
              child: Slider(
                value: themeValues[t],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${themeValues[t].toInt()}',
                onChanged: (double val) {},
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
          'Color Theming',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Paddle indicators in various color themes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: themeCards),
      ],
    ),
  );
}

Widget buildTextLabelStylingSection() {
  print('Building text label styling section');
  List<String> styleNames = [
    'Bold White',
    'Light Style',
    'Large Font',
    'Compact',
  ];
  List<double> fontSizes = [14.0, 12.0, 18.0, 10.0];
  List<FontWeight> fontWeights = [
    FontWeight.bold,
    FontWeight.w300,
    FontWeight.w600,
    FontWeight.w500,
  ];
  List<MaterialColor> styleColors = [
    Colors.deepPurple,
    Colors.cyan,
    Colors.deepOrange,
    Colors.blueGrey,
  ];
  List<double> styleValues = [50.0, 65.0, 40.0, 80.0];

  List<Widget> styleCards = [];
  int i = 0;
  for (i = 0; i < styleNames.length; i = i + 1) {
    styleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: styleColors[i].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: styleColors[i].shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    styleNames[i],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: styleColors[i].shade700,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Size: ${fontSizes[i].toInt()}px',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                activeTrackColor: styleColors[i],
                inactiveTrackColor: styleColors[i].withAlpha(50),
                thumbColor: styleColors[i],
                valueIndicatorColor: styleColors[i],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizes[i],
                  fontWeight: fontWeights[i],
                ),
                trackHeight: 4,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: Slider(
                value: styleValues[i],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${styleValues[i].toInt()}',
                onChanged: (double val) {},
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
          'Text Label Styling',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different text styles for value indicator labels',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: styleCards),
      ],
    ),
  );
}

Widget buildSizeVariationsSection() {
  print('Building size variations section');
  List<String> sizeNames = ['Mini', 'Small', 'Medium', 'Large', 'Extra Large'];
  List<double> trackHeights = [2.0, 3.0, 4.0, 6.0, 8.0];
  List<double> thumbRadii = [5.0, 7.0, 10.0, 13.0, 16.0];
  List<double> sizeValues = [25.0, 40.0, 55.0, 70.0, 85.0];
  List<MaterialColor> sizeColors = [
    Colors.grey,
    Colors.lightBlue,
    Colors.teal,
    Colors.indigo,
    Colors.deepPurple,
  ];

  List<Widget> sizeCards = [];
  int s = 0;
  for (s = 0; s < sizeNames.length; s = s + 1) {
    sizeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: sizeColors[s].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  sizeNames[s],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Track: ${trackHeights[s].toInt()}px, Thumb: ${thumbRadii[s].toInt()}px',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                activeTrackColor: sizeColors[s],
                inactiveTrackColor: sizeColors[s].withAlpha(50),
                thumbColor: sizeColors[s],
                valueIndicatorColor: sizeColors[s],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                trackHeight: trackHeights[s],
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: thumbRadii[s],
                ),
              ),
              child: Slider(
                value: sizeValues[s],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${sizeValues[s].toInt()}',
                onChanged: (double val) {},
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
          'Size Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different track heights and thumb sizes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sizeCards),
      ],
    ),
  );
}

Widget buildShapeComparisonSection() {
  print('Building shape comparison section');
  List<String> shapeNames = ['Paddle Shape', 'Drop Shape', 'Rectangular Shape'];
  List<String> shapeDescriptions = [
    'Extended oval with pointed bottom, classic slider look',
    'Teardrop shape pointing downward toward thumb',
    'Simple rectangle with rounded corners',
  ];
  List<MaterialColor> shapeColors = [
    Colors.teal,
    Colors.deepPurple,
    Colors.orange,
  ];
  List<IconData> shapeIcons = [
    Icons.sports_tennis,
    Icons.water_drop,
    Icons.rectangle,
  ];
  List<double> shapeValues = [60.0, 45.0, 75.0];

  List<Widget> shapeCards = [];
  int i = 0;
  for (i = 0; i < shapeNames.length; i = i + 1) {
    shapeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: shapeColors[i].shade300, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: shapeColors[i].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    shapeIcons[i],
                    color: shapeColors[i].shade700,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shapeNames[i],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: shapeColors[i].shade800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        shapeDescriptions[i],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                activeTrackColor: shapeColors[i],
                inactiveTrackColor: shapeColors[i].withAlpha(60),
                thumbColor: shapeColors[i],
                valueIndicatorColor: shapeColors[i],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                trackHeight: 5,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: shapeValues[i],
                min: 0,
                max: 100,
                divisions: 20,
                label: '${shapeValues[i].toInt()}',
                onChanged: (double val) {},
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
          'Shape Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Compare paddle vs drop vs rectangular indicator shapes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        Column(children: shapeCards),
      ],
    ),
  );
}

Widget buildInteractiveSlidersSection() {
  print('Building interactive sliders section');
  List<String> controlNames = [
    'Master Volume',
    'Bass Level',
    'Treble Level',
    'Balance',
    'Equalizer',
  ];
  List<IconData> controlIcons = [
    Icons.volume_up,
    Icons.graphic_eq,
    Icons.tune,
    Icons.balance,
    Icons.equalizer,
  ];
  List<MaterialColor> controlColors = [
    Colors.blue,
    Colors.deepPurple,
    Colors.amber,
    Colors.green,
    Colors.red,
  ];
  List<double> controlValues = [75.0, 50.0, 60.0, 50.0, 70.0];

  List<Widget> controlCards = [];
  int c = 0;
  for (c = 0; c < controlNames.length; c = c + 1) {
    controlCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: controlColors[c].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(controlIcons[c], color: controlColors[c], size: 20),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 80,
              child: Text(
                controlNames[c],
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  activeTrackColor: controlColors[c],
                  inactiveTrackColor: controlColors[c].withAlpha(40),
                  thumbColor: controlColors[c],
                  valueIndicatorColor: controlColors[c],
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  trackHeight: 3,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
                ),
                child: Slider(
                  value: controlValues[c],
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${controlValues[c].toInt()}',
                  onChanged: (double val) {},
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 40,
              alignment: Alignment.centerRight,
              child: Text(
                '${controlValues[c].toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: controlColors[c],
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
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.settings_input_component, color: Colors.grey.shade700),
            SizedBox(width: 8),
            Text(
              'Interactive Audio Controls',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Simulated audio mixer with paddle indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Column(children: controlCards),
        ),
      ],
    ),
  );
}

Widget buildUsageSummarySection() {
  print('Building usage summary section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Usage Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Class', 'PaddleSliderValueIndicatorShape'),
        buildInfoCard('Usage', 'SliderThemeData.valueIndicatorShape'),
        buildInfoCard('Shape', 'Extended oval with pointed bottom'),
        buildInfoCard('Best For', 'Clear value display on regular sliders'),
        buildInfoCard('Text Style', 'Controlled via valueIndicatorTextStyle'),
        buildInfoCard('Color', 'Controlled via valueIndicatorColor'),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Code Example',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'SliderTheme(\n'
                '  data: SliderThemeData(\n'
                '    valueIndicatorShape:\n'
                '      PaddleSliderValueIndicatorShape(),\n'
                '  ),\n'
                '  child: Slider(...),\n'
                ')',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 24),
                    SizedBox(height: 4),
                    Text('Pros', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      'Classic look\nClear labels\nFamiliar shape',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.info, color: Colors.orange, size: 24),
                    SizedBox(height: 4),
                    Text(
                      'Consider',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Needs space above\nLabel size matters\nTheme carefully',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('Building PaddleSliderValueIndicatorShape demo');

  return Scaffold(
    appBar: AppBar(
      title: Text('PaddleSliderValueIndicatorShape'),
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('1. Overview'),
          buildInfoCard('Class', 'PaddleSliderValueIndicatorShape'),
          buildInfoCard('Purpose', 'Paddle-shaped value indicator for Slider'),
          buildInfoCard('Location', 'package:flutter/material.dart'),
          buildInfoCard('Usage', 'Set in SliderThemeData.valueIndicatorShape'),
          buildInfoCard('Shape', 'Extended oval with pointed bottom'),

          buildSectionHeader('2. Basic Paddle Slider'),
          buildSliderWithPaddleIndicator(
            'Standard Paddle Indicator',
            Colors.teal,
            Colors.teal.shade700,
            50.0,
            true,
          ),

          buildSectionHeader('3. Paddle Appearance'),
          buildPaddleAppearanceDemo(),

          buildSectionHeader('4. Multiple Sliders'),
          buildMultiplePaddleSliders(),

          buildSectionHeader('5. Color Theming'),
          buildColorThemingSection(),

          buildSectionHeader('6. Text Label Styling'),
          buildTextLabelStylingSection(),

          buildSectionHeader('7. Size Variations'),
          buildSizeVariationsSection(),

          buildSectionHeader('8. Shape Comparison'),
          buildShapeComparisonSection(),

          buildSectionHeader('9. Interactive Sliders'),
          buildInteractiveSlidersSection(),

          buildSectionHeader('10. Usage Summary'),
          buildUsageSummarySection(),

          SizedBox(height: 32),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'PaddleSliderValueIndicatorShape Demo Complete',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}
