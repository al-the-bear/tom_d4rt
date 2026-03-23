// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundedRectSliderTrackShape from material
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

Widget buildBasicSliderWithRoundedTrack(
  String label,
  Color activeColor,
  Color thumbColor,
  double initialValue,
  double trackHeight,
) {
  print('Building basic slider with rounded track: $label');
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
          'Track Height: ${trackHeight.toInt()}px | Active: $activeColor',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RoundedRectSliderTrackShape(),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: thumbColor,
            trackHeight: trackHeight,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: activeColor.withAlpha(30),
          ),
          child: Slider(
            value: initialValue,
            min: 0,
            max: 100,
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

Widget buildTrackHeightVariations() {
  print('Building track height variations');
  List<double> heights = [2.0, 4.0, 8.0, 12.0, 16.0, 24.0];
  List<double> values = [25.0, 40.0, 55.0, 70.0, 85.0, 50.0];
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < heights.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors[i].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors[i].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors[i].shade700,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${heights[i].toInt()}px',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Track Height ${heights[i].toInt()}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colors[i].shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: colors[i],
                inactiveTrackColor: colors[i].withAlpha(50),
                thumbColor: colors[i].shade800,
                trackHeight: heights[i],
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: heights[i] * 0.8 + 4,
                ),
                overlayColor: colors[i].withAlpha(25),
              ),
              child: Slider(
                value: values[i],
                min: 0,
                max: 100,
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
          'Track Height Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Demonstrating different trackHeight values with RoundedRectSliderTrackShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildActiveInactiveColorGrid() {
  print('Building active/inactive color grid');
  List<String> colorNames = [
    'Blue Theme',
    'Red Theme',
    'Green Theme',
    'Purple Theme',
    'Orange Theme',
    'Teal Theme',
  ];
  List<MaterialColor> activeColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];
  List<int> inactiveAlphas = [40, 60, 30, 50, 70, 45];
  List<double> sliderValues = [65.0, 35.0, 80.0, 50.0, 25.0, 55.0];

  List<Widget> colorCards = [];
  int c = 0;
  for (c = 0; c < colorNames.length; c = c + 1) {
    colorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: activeColors[c].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: activeColors[c],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: activeColors[c].withAlpha(inactiveAlphas[c]),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: activeColors[c].shade300),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  colorNames[c],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Alpha: ${inactiveAlphas[c]}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: activeColors[c],
                inactiveTrackColor: activeColors[c].withAlpha(inactiveAlphas[c]),
                thumbColor: activeColors[c].shade700,
                trackHeight: 6,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: sliderValues[c],
                min: 0,
                max: 100,
                onChanged: (double v) {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active',
                  style: TextStyle(fontSize: 10, color: activeColors[c]),
                ),
                Text(
                  '${sliderValues[c].toInt()}%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: activeColors[c].shade700,
                  ),
                ),
                Text(
                  'Inactive',
                  style: TextStyle(
                    fontSize: 10,
                    color: activeColors[c].withAlpha(inactiveAlphas[c] + 100),
                  ),
                ),
              ],
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
          'Active/Inactive Color Combinations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different activeTrackColor and inactiveTrackColor pairings',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorCards),
      ],
    ),
  );
}

Widget buildSliderThemeConfiguration() {
  print('Building slider theme configuration showcase');
  List<String> themeNames = [
    'Default Track',
    'Thick Track',
    'Thin Track',
    'High Contrast',
    'Soft Colors',
    'Dark Mode',
  ];
  List<MaterialColor> primaryColors = [
    Colors.blue,
    Colors.indigo,
    Colors.cyan,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.blueGrey,
  ];
  List<double> trackHeights = [4.0, 12.0, 2.0, 8.0, 6.0, 5.0];
  List<double> thumbRadii = [10.0, 16.0, 6.0, 12.0, 9.0, 11.0];
  List<double> values = [50.0, 75.0, 30.0, 90.0, 45.0, 60.0];
  List<bool> isDarkThemes = [false, false, false, false, false, true];

  List<Widget> themeWidgets = [];
  int t = 0;
  for (t = 0; t < themeNames.length; t = t + 1) {
    Color bgColor = isDarkThemes[t] ? Colors.grey.shade900 : Colors.white;
    Color textColor = isDarkThemes[t] ? Colors.white : Colors.black;
    Color subTextColor = isDarkThemes[t] ? Colors.grey.shade400 : Colors.grey.shade600;
    Color borderColor = isDarkThemes[t] ? Colors.grey.shade700 : Colors.grey.shade300;

    themeWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.tune,
                  color: primaryColors[t],
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  themeNames[t],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: primaryColors[t].withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Height: ${trackHeights[t].toInt()}px',
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColors[t],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: primaryColors[t],
                inactiveTrackColor: primaryColors[t].withAlpha(isDarkThemes[t] ? 80 : 50),
                thumbColor: primaryColors[t],
                trackHeight: trackHeights[t],
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: thumbRadii[t],
                ),
                overlayColor: primaryColors[t].withAlpha(20),
                valueIndicatorColor: primaryColors[t],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              child: Slider(
                value: values[t],
                min: 0,
                max: 100,
                divisions: 10,
                label: '${values[t].toInt()}',
                onChanged: (double v) {},
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Text(
                  'Thumb: ${thumbRadii[t].toInt()}px',
                  style: TextStyle(fontSize: 10, color: subTextColor),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Value: ${values[t].toInt()}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: primaryColors[t],
                  ),
                ),
              ],
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
          'SliderTheme Configuration Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Complete theme configurations using RoundedRectSliderTrackShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: themeWidgets),
      ],
    ),
  );
}

Widget buildRoundedEndsVisualization() {
  print('Building rounded ends visualization');
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
          'Rounded Ends Characteristic',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The default RoundedRectSliderTrackShape has rounded caps',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.horizontal_rule,
                      color: Colors.blue.shade700,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rounded Track',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Default shape with soft ends',
                      style: TextStyle(fontSize: 11, color: Colors.blue.shade600),
                      textAlign: TextAlign.center,
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
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green.shade700,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Thumb Centered',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Thumb aligns on track edge',
                      style: TextStyle(fontSize: 11, color: Colors.green.shade600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'Visual Example',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: Colors.indigo,
                  inactiveTrackColor: Colors.indigo.withAlpha(50),
                  thumbColor: Colors.indigo.shade800,
                  trackHeight: 16,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14),
                ),
                child: Slider(
                  value: 50.0,
                  min: 0,
                  max: 100,
                  onChanged: (double v) {},
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Notice the rounded caps at both ends of the track',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTrackShapeComparison() {
  print('Building track shape comparison');
  List<String> shapeNames = [
    'RoundedRectSliderTrackShape (Default)',
    'RectangularSliderTrackShape',
  ];
  List<IconData> shapeIcons = [
    Icons.rounded_corner,
    Icons.rectangle_outlined,
  ];
  List<MaterialColor> shapeColors = [
    Colors.indigo,
    Colors.orange,
  ];

  List<Widget> comparisonItems = [];
  int s = 0;
  for (s = 0; s < shapeNames.length; s = s + 1) {
    SliderTrackShape trackShape;
    if (s == 0) {
      trackShape = RoundedRectSliderTrackShape();
    } else {
      trackShape = RectangularSliderTrackShape();
    }

    comparisonItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: shapeColors[s].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: shapeColors[s].shade200),
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
                    color: shapeColors[s].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    shapeIcons[s],
                    color: shapeColors[s].shade700,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shapeNames[s],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: shapeColors[s].shade800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        s == 0 ? 'Rounded end caps' : 'Flat rectangular ends',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                trackShape: trackShape,
                activeTrackColor: shapeColors[s],
                inactiveTrackColor: shapeColors[s].withAlpha(50),
                thumbColor: shapeColors[s].shade700,
                trackHeight: 10,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
              ),
              child: Slider(
                value: 60.0,
                min: 0,
                max: 100,
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
          'Track Shape Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Comparing RoundedRectSliderTrackShape with other track shapes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: comparisonItems),
      ],
    ),
  );
}

Widget buildSliderUseCases() {
  print('Building slider use cases');
  List<String> useCaseNames = [
    'Volume Control',
    'Brightness',
    'Progress Bar',
    'Rating Selector',
    'Price Range',
    'Timeline Scrubber',
  ];
  List<IconData> useCaseIcons = [
    Icons.volume_up,
    Icons.brightness_6,
    Icons.hourglass_bottom,
    Icons.star_rate,
    Icons.attach_money,
    Icons.timeline,
  ];
  List<MaterialColor> useCaseColors = [
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.orange,
    Colors.teal,
    Colors.purple,
  ];
  List<double> useCaseValues = [75.0, 50.0, 65.0, 80.0, 45.0, 30.0];
  List<double> useCaseTrackHeights = [4.0, 6.0, 8.0, 5.0, 4.0, 6.0];

  List<Widget> useCaseCards = [];
  int u = 0;
  for (u = 0; u < useCaseNames.length; u = u + 1) {
    useCaseCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: useCaseColors[u].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: useCaseColors[u].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    useCaseIcons[u],
                    color: useCaseColors[u].shade700,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  useCaseNames[u],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  '${useCaseValues[u].toInt()}%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: useCaseColors[u],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: useCaseColors[u],
                inactiveTrackColor: useCaseColors[u].withAlpha(40),
                thumbColor: useCaseColors[u].shade600,
                trackHeight: useCaseTrackHeights[u],
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayColor: useCaseColors[u].withAlpha(20),
              ),
              child: Slider(
                value: useCaseValues[u],
                min: 0,
                max: 100,
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
          'Common Use Cases',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RoundedRectSliderTrackShape in typical UI scenarios',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: useCaseCards),
      ],
    ),
  );
}

Widget buildThumbCompatibility() {
  print('Building thumb compatibility showcase');
  List<String> thumbNames = [
    'Round Thumb (Default)',
    'Small Thumb',
    'Large Thumb',
    'Overlay Effect',
  ];
  List<double> thumbRadii = [10.0, 6.0, 16.0, 12.0];
  List<MaterialColor> thumbColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
  ];
  List<double> trackHeightsForThumbs = [4.0, 2.0, 8.0, 5.0];
  List<double> valuesForThumbs = [50.0, 70.0, 40.0, 60.0];

  List<Widget> thumbCards = [];
  int th = 0;
  for (th = 0; th < thumbNames.length; th = th + 1) {
    thumbCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: thumbColors[th].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: thumbColors[th].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: thumbRadii[th] * 2 + 8,
                  height: thumbRadii[th] * 2 + 8,
                  decoration: BoxDecoration(
                    color: thumbColors[th],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thumbNames[th],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: thumbColors[th].shade800,
                      ),
                    ),
                    Text(
                      'Radius: ${thumbRadii[th].toInt()}px',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: thumbColors[th],
                inactiveTrackColor: thumbColors[th].withAlpha(50),
                thumbColor: thumbColors[th].shade700,
                trackHeight: trackHeightsForThumbs[th],
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: thumbRadii[th],
                ),
                overlayColor: thumbColors[th].withAlpha(30),
                overlayShape: RoundSliderOverlayShape(overlayRadius: thumbRadii[th] * 2),
              ),
              child: Slider(
                value: valuesForThumbs[th],
                min: 0,
                max: 100,
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
          'Thumb Shape Compatibility',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RoundedRectSliderTrackShape works with various thumb sizes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: thumbCards),
      ],
    ),
  );
}

Widget buildDisabledStateExample() {
  print('Building disabled state example');
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
          'Enabled vs Disabled State',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Track appearance changes based on slider state',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Enabled Slider',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.green.withAlpha(50),
                  thumbColor: Colors.green.shade700,
                  trackHeight: 6,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                ),
                child: Slider(
                  value: 60.0,
                  min: 0,
                  max: 100,
                  onChanged: (double v) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.block,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Disabled Slider',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  disabledActiveTrackColor: Colors.grey.shade400,
                  disabledInactiveTrackColor: Colors.grey.shade200,
                  disabledThumbColor: Colors.grey.shade400,
                  trackHeight: 6,
                  thumbShape: RoundSliderThumbShape(disabledThumbRadius: 8),
                ),
                child: Slider(
                  value: 60.0,
                  min: 0,
                  max: 100,
                  onChanged: null,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSecondaryTrackExample() {
  print('Building secondary track example');
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
          'Secondary Track Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Using secondaryActiveTrackColor for buffering indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.play_circle_filled,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Media Player Progress',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: Colors.blue,
                  secondaryActiveTrackColor: Colors.blue.shade300,
                  inactiveTrackColor: Colors.blue.withAlpha(30),
                  thumbColor: Colors.blue.shade700,
                  trackHeight: 5,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                ),
                child: Slider(
                  value: 35.0,
                  secondaryTrackValue: 70.0,
                  min: 0,
                  max: 100,
                  onChanged: (double v) {},
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Played',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Buffered',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(30),
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Remaining',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTrackProperties() {
  print('Building track properties documentation');
  List<String> propNames = [
    'trackShape',
    'trackHeight',
    'activeTrackColor',
    'inactiveTrackColor',
    'secondaryActiveTrackColor',
    'disabledActiveTrackColor',
    'disabledInactiveTrackColor',
  ];
  List<String> propDescriptions = [
    'RoundedRectSliderTrackShape() - The track shape with rounded ends',
    'double value - Height of the track in logical pixels',
    'Color - The color of the track between min and current value',
    'Color - The color of the track between current and max value',
    'Color - For buffered content (media players)',
    'Color - Active track color when slider is disabled',
    'Color - Inactive track color when slider is disabled',
  ];
  List<IconData> propIcons = [
    Icons.shape_line,
    Icons.height,
    Icons.format_color_fill,
    Icons.format_color_reset,
    Icons.slow_motion_video,
    Icons.do_not_disturb_on,
    Icons.do_not_disturb_off,
  ];

  List<Widget> propItems = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    propItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                propIcons[p],
                color: Colors.indigo.shade700,
                size: 18,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propNames[p],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    propDescriptions[p],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
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
          'Track Configuration Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'SliderThemeData properties related to track appearance',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: propItems),
      ],
    ),
  );
}

Widget main() {
  print('Starting RoundedRectSliderTrackShape deep demo');

  Widget result = MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('RoundedRectSliderTrackShape Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RoundedRectSliderTrackShape',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The default Slider track shape with rounded end caps. This creates a pill-shaped track that is visually appealing and commonly used in Material Design sliders.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),

            buildSectionHeader('1. Basic Slider with Rounded Track'),
            buildBasicSliderWithRoundedTrack(
              'Default Rounded Track',
              Colors.blue,
              Colors.blue.shade700,
              50.0,
              4.0,
            ),
            buildBasicSliderWithRoundedTrack(
              'Purple Variant',
              Colors.purple,
              Colors.purple.shade700,
              65.0,
              4.0,
            ),
            buildBasicSliderWithRoundedTrack(
              'Teal Compact',
              Colors.teal,
              Colors.teal.shade700,
              35.0,
              2.0,
            ),

            buildSectionHeader('2. Track Heights'),
            buildTrackHeightVariations(),

            buildSectionHeader('3. Active/Inactive Colors'),
            buildActiveInactiveColorGrid(),

            buildSectionHeader('4. SliderTheme Configuration'),
            buildSliderThemeConfiguration(),

            buildSectionHeader('5. Rounded Ends Visualization'),
            buildRoundedEndsVisualization(),

            buildSectionHeader('6. Track Shape Comparison'),
            buildTrackShapeComparison(),

            buildSectionHeader('7. Common Use Cases'),
            buildSliderUseCases(),

            buildSectionHeader('8. Thumb Compatibility'),
            buildThumbCompatibility(),

            buildSectionHeader('9. Disabled State'),
            buildDisabledStateExample(),

            buildSectionHeader('10. Secondary Track'),
            buildSecondaryTrackExample(),

            buildSectionHeader('11. Configuration Properties'),
            buildTrackProperties(),

            buildSectionHeader('12. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'RoundedRectSliderTrackShape is the default trackShape in SliderThemeData',
            ),
            buildInfoCard(
              'Tip 2',
              'Use trackHeight to control the visual thickness of the track',
            ),
            buildInfoCard(
              'Tip 3',
              'Combine activeTrackColor and inactiveTrackColor for visual contrast',
            ),
            buildInfoCard(
              'Tip 4',
              'Match thumbShape radius with trackHeight for balanced proportions',
            ),
            buildInfoCard(
              'Tip 5',
              'Use secondaryTrackValue for buffering indicators in media players',
            ),
            buildInfoCard(
              'Tip 6',
              'Set disabledActiveTrackColor for proper disabled state appearance',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RoundedRectSliderTrackShape deep demo completed');
  return result;
}
