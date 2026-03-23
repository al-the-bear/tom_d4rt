// ignore_for_file: avoid_print
// D4rt test script: Tests RoundRangeSliderThumbShape from material
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

Widget buildBasicRangeSlider(
  String label,
  Color activeColor,
  double startVal,
  double endVal,
  double thumbRadius,
) {
  print('Building basic range slider: $label');
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
          'Thumb Radius: ${thumbRadius.toStringAsFixed(1)}',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            rangeThumbShape: RoundRangeSliderThumbShape(
              enabledThumbRadius: thumbRadius,
            ),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            overlayColor: activeColor.withAlpha(40),
            trackHeight: 4,
          ),
          child: RangeSlider(
            values: RangeValues(startVal, endVal),
            min: 0,
            max: 100,
            onChanged: (RangeValues vals) {},
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
              '100',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildThumbRadiusComparison() {
  print('Building thumb radius comparison');
  List<double> radii = [6.0, 10.0, 14.0, 18.0, 22.0];
  List<MaterialColor> radiiColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];
  List<double> startVals = [15.0, 20.0, 25.0, 30.0, 35.0];
  List<double> endVals = [45.0, 55.0, 65.0, 75.0, 85.0];

  List<Widget> sliderItems = [];
  int i = 0;
  for (i = 0; i < radii.length; i = i + 1) {
    sliderItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: radiiColors[i].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: radiiColors[i].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: radii[i] * 2,
                  height: radii[i] * 2,
                  decoration: BoxDecoration(
                    color: radiiColors[i],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Radius: ${radii[i].toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: radiiColors[i].shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: radii[i],
                ),
                activeTrackColor: radiiColors[i],
                inactiveTrackColor: radiiColors[i].withAlpha(50),
                overlayColor: radiiColors[i].withAlpha(30),
                trackHeight: 4,
              ),
              child: RangeSlider(
                values: RangeValues(startVals[i], endVals[i]),
                min: 0,
                max: 100,
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
          'Enabled Thumb Radius Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different enabledThumbRadius values for RoundRangeSliderThumbShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sliderItems),
      ],
    ),
  );
}

Widget buildDisabledThumbRadiusDemo() {
  print('Building disabled thumb radius demo');
  List<double> enabledRadii = [12.0, 12.0, 12.0];
  List<double> disabledRadii = [6.0, 8.0, 10.0];
  List<String> descriptions = [
    'Large reduction (12 -> 6)',
    'Medium reduction (12 -> 8)',
    'Small reduction (12 -> 10)',
  ];

  List<Widget> demoItems = [];
  int d = 0;
  for (d = 0; d < enabledRadii.length; d = d + 1) {
    demoItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
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
                Icon(Icons.radio_button_checked, color: Colors.grey.shade600),
                SizedBox(width: 8),
                Text(
                  descriptions[d],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'Enabled: ${enabledRadii[d]}, Disabled: ${disabledRadii[d]}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: enabledRadii[d],
                  disabledThumbRadius: disabledRadii[d],
                ),
                activeTrackColor: Colors.grey.shade400,
                inactiveTrackColor: Colors.grey.shade300,
                disabledActiveTrackColor: Colors.grey.shade400,
                disabledInactiveTrackColor: Colors.grey.shade300,
                trackHeight: 4,
              ),
              child: RangeSlider(
                values: RangeValues(25.0, 75.0),
                min: 0,
                max: 100,
                onChanged: null,
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
          'Disabled Thumb Radius',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Thumb size when the slider is disabled (onChanged: null)',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: demoItems),
      ],
    ),
  );
}

Widget buildPressedElevationDemo() {
  print('Building pressed elevation demo');
  List<double> elevations = [0.0, 4.0, 8.0, 12.0];
  List<MaterialColor> elevColors = [
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
  ];

  List<Widget> elevItems = [];
  int e = 0;
  for (e = 0; e < elevations.length; e = e + 1) {
    elevItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: elevColors[e].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: elevColors[e].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.touch_app,
                  color: elevColors[e].shade700,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Pressed Elevation: ${elevations[e].toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: elevColors[e].shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 12.0,
                  pressedElevation: elevations[e],
                ),
                activeTrackColor: elevColors[e],
                inactiveTrackColor: elevColors[e].withAlpha(50),
                overlayColor: elevColors[e].withAlpha(40),
                trackHeight: 4,
              ),
              child: RangeSlider(
                values: RangeValues(20.0, 80.0),
                min: 0,
                max: 100,
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Press and hold thumb to see elevation effect',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
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
          'Pressed Elevation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Shadow elevation when thumb is pressed',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: elevItems),
      ],
    ),
  );
}

Widget buildElevationDemo() {
  print('Building elevation demo');
  List<double> elevVals = [0.0, 2.0, 4.0, 6.0];
  List<MaterialColor> baseColors = [
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
  ];

  List<Widget> elevWidgets = [];
  int ev = 0;
  for (ev = 0; ev < elevVals.length; ev = ev + 1) {
    elevWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: baseColors[ev].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: baseColors[ev].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.layers,
                  color: baseColors[ev].shade700,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Elevation: ${elevVals[ev].toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: baseColors[ev].shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 12.0,
                  elevation: elevVals[ev],
                ),
                activeTrackColor: baseColors[ev],
                inactiveTrackColor: baseColors[ev].withAlpha(50),
                overlayColor: baseColors[ev].withAlpha(40),
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
          'Default Elevation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Resting shadow elevation of the thumb',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: elevWidgets),
      ],
    ),
  );
}

Widget buildOverlayColorDemo() {
  print('Building overlay color demo');
  List<String> overlayNames = [
    'Red Overlay',
    'Green Overlay',
    'Blue Overlay',
    'Yellow Overlay',
    'Purple Overlay',
  ];
  List<Color> overlayColors = [
    Colors.red.withAlpha(80),
    Colors.green.withAlpha(80),
    Colors.blue.withAlpha(80),
    Colors.yellow.withAlpha(120),
    Colors.purple.withAlpha(80),
  ];
  List<MaterialColor> trackColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.purple,
  ];

  List<Widget> overlayItems = [];
  int o = 0;
  for (o = 0; o < overlayNames.length; o = o + 1) {
    overlayItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: trackColors[o].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: trackColors[o].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: overlayColors[o],
                    shape: BoxShape.circle,
                    border: Border.all(color: trackColors[o], width: 2),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  overlayNames[o],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: trackColors[o].shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 12.0,
                ),
                activeTrackColor: trackColors[o],
                inactiveTrackColor: trackColors[o].withAlpha(50),
                overlayColor: overlayColors[o],
                trackHeight: 4,
              ),
              child: RangeSlider(
                values: RangeValues(25.0, 75.0),
                min: 0,
                max: 100,
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Press thumb to see overlay effect',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
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
          'Overlay Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Color of the circular overlay shown when pressing thumb',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: overlayItems),
      ],
    ),
  );
}

Widget buildColorThemeShowcase() {
  print('Building color theme showcase');
  List<String> themeNames = [
    'Ocean Blue',
    'Forest Green',
    'Sunset Orange',
    'Royal Purple',
    'Cherry Red',
    'Midnight Indigo',
    'Golden Amber',
    'Steel Teal',
  ];
  List<MaterialColor> themeColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.indigo,
    Colors.amber,
    Colors.teal,
  ];
  List<double> startVals = [10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0, 45.0];
  List<double> endVals = [50.0, 55.0, 60.0, 65.0, 70.0, 75.0, 80.0, 85.0];

  List<Widget> themeItems = [];
  int t = 0;
  for (t = 0; t < themeNames.length; t = t + 1) {
    themeItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: themeColors[t],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      themeNames[t],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 8.0,
                  ),
                  activeTrackColor: themeColors[t],
                  inactiveTrackColor: themeColors[t].withAlpha(40),
                  overlayColor: themeColors[t].withAlpha(30),
                  trackHeight: 3,
                ),
                child: RangeSlider(
                  values: RangeValues(startVals[t], endVals[t]),
                  min: 0,
                  max: 100,
                  onChanged: (RangeValues vals) {},
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
          'Color Theme Showcase',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RangeSlider with round thumbs in various color themes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: themeItems),
      ],
    ),
  );
}

Widget buildSliderThemeConfiguration() {
  print('Building slider theme configuration');
  List<String> propNames = [
    'rangeThumbShape',
    'enabledThumbRadius',
    'disabledThumbRadius',
    'elevation',
    'pressedElevation',
    'overlayColor',
    'activeTrackColor',
    'inactiveTrackColor',
    'trackHeight',
  ];
  List<String> propDescriptions = [
    'RoundRangeSliderThumbShape instance',
    'Radius when slider is enabled (default: 10.0)',
    'Radius when slider is disabled',
    'Shadow elevation at rest (default: 1.0)',
    'Shadow elevation when pressed (default: 6.0)',
    'Color of the circular overlay when pressed',
    'Color of the track between thumbs',
    'Color of the track outside thumbs',
    'Height of the slider track',
  ];

  List<Widget> propRows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bgColor = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    propRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bgColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
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
                propDescriptions[p],
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
    clipBehavior: Clip.hardEdge,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
          ),
          child: Text(
            'SliderTheme Configuration Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: propRows),
      ],
    ),
  );
}

Widget buildThumbAnatomyDisplay() {
  print('Building thumb anatomy display');
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
          'Round Thumb Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                child: CustomPaint(
                  painter: _RoundThumbPainter(Colors.indigo),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Round Thumb Shape',
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
          'Circle Body',
          'Main circular shape of the thumb',
          Colors.indigo.shade100,
        ),
        _buildAnatomyRow(
          'Shadow',
          'Elevation shadow beneath the thumb',
          Colors.indigo.shade200,
        ),
        _buildAnatomyRow(
          'Overlay',
          'Larger circle shown when pressed',
          Colors.indigo.shade300,
        ),
        _buildAnatomyRow(
          'Thumb Color',
          'Primary fill color of the thumb',
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

Widget buildCombinedFeaturesDemo() {
  print('Building combined features demo');
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
          'Combined Features Demo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RoundRangeSliderThumbShape with multiple customizations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.deepOrange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Large Elevated Thumbs',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Radius: 16, Elevation: 4, Pressed: 10',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 16.0,
                    elevation: 4.0,
                    pressedElevation: 10.0,
                  ),
                  activeTrackColor: Colors.deepOrange,
                  inactiveTrackColor: Colors.deepOrange.withAlpha(50),
                  overlayColor: Colors.deepOrange.withAlpha(50),
                  trackHeight: 6,
                ),
                child: RangeSlider(
                  values: RangeValues(20.0, 80.0),
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
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compact Flat Thumbs',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Radius: 6, Elevation: 0, Pressed: 2',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 6.0,
                    elevation: 0.0,
                    pressedElevation: 2.0,
                  ),
                  activeTrackColor: Colors.cyan,
                  inactiveTrackColor: Colors.cyan.withAlpha(50),
                  overlayColor: Colors.cyan.withAlpha(50),
                  trackHeight: 2,
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
            color: Colors.lime.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.lime.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Medium Subtle Thumbs',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.lime.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Radius: 10, Elevation: 2, Pressed: 6',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 10.0,
                    elevation: 2.0,
                    pressedElevation: 6.0,
                  ),
                  activeTrackColor: Colors.lime.shade600,
                  inactiveTrackColor: Colors.lime.withAlpha(50),
                  overlayColor: Colors.lime.withAlpha(50),
                  trackHeight: 4,
                ),
                child: RangeSlider(
                  values: RangeValues(15.0, 85.0),
                  min: 0,
                  max: 100,
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

Widget buildUseCasesSection() {
  print('Building use cases section');
  List<String> useCases = [
    'Price range filters in e-commerce apps',
    'Date or time range selection',
    'Audio frequency range adjustment',
    'Temperature range settings',
    'Distance or radius selection',
    'Budget planning with min/max values',
  ];
  List<IconData> useCaseIcons = [
    Icons.attach_money,
    Icons.date_range,
    Icons.equalizer,
    Icons.thermostat,
    Icons.straighten,
    Icons.account_balance_wallet,
  ];
  List<MaterialColor> useCaseColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.teal,
  ];

  List<Widget> useCaseItems = [];
  int u = 0;
  for (u = 0; u < useCases.length; u = u + 1) {
    useCaseItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: useCaseColors[u].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: useCaseColors[u].shade200),
        ),
        child: Row(
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
            Expanded(
              child: Text(
                useCases[u],
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
          'Typical scenarios for RangeSlider with round thumbs',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: useCaseItems),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('RoundRangeSliderThumbShape deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('RoundRangeSliderThumbShape Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RoundRangeSliderThumbShape'),
            buildInfoCard(
              'Purpose',
              'Provides round thumb shapes for RangeSlider widgets',
            ),
            buildInfoCard('Used In', 'SliderThemeData.rangeThumbShape'),
            buildInfoCard(
              'Key Feature',
              'Circular thumbs with customizable radius and elevation',
            ),

            buildSectionHeader('2. Basic RangeSlider with Round Thumbs'),
            buildBasicRangeSlider(
              'Indigo Theme',
              Colors.indigo,
              20.0,
              70.0,
              10.0,
            ),
            buildBasicRangeSlider(
              'Teal Theme',
              Colors.teal,
              30.0,
              80.0,
              12.0,
            ),
            buildBasicRangeSlider(
              'Pink Theme',
              Colors.pink,
              15.0,
              65.0,
              8.0,
            ),

            buildSectionHeader('3. Enabled Thumb Radius'),
            buildThumbRadiusComparison(),

            buildSectionHeader('4. Disabled Thumb Radius'),
            buildDisabledThumbRadiusDemo(),

            buildSectionHeader('5. Pressed Elevation'),
            buildPressedElevationDemo(),

            buildSectionHeader('6. Default Elevation'),
            buildElevationDemo(),

            buildSectionHeader('7. Overlay Color'),
            buildOverlayColorDemo(),

            buildSectionHeader('8. Color Themes'),
            buildColorThemeShowcase(),

            buildSectionHeader('9. SliderTheme Configuration'),
            buildSliderThemeConfiguration(),

            buildSectionHeader('10. Thumb Anatomy'),
            buildThumbAnatomyDisplay(),

            buildSectionHeader('11. Combined Features'),
            buildCombinedFeaturesDemo(),

            buildSectionHeader('12. Common Use Cases'),
            buildUseCasesSection(),

            buildSectionHeader('13. Implementation Tips'),
            buildInfoCard(
              'Tip 1',
              'Set rangeThumbShape in SliderThemeData for custom thumbs',
            ),
            buildInfoCard(
              'Tip 2',
              'Use smaller disabledThumbRadius for visual feedback',
            ),
            buildInfoCard(
              'Tip 3',
              'Higher pressedElevation improves interaction feedback',
            ),
            buildInfoCard(
              'Tip 4',
              'Match overlayColor with activeTrackColor for consistency',
            ),
            buildInfoCard(
              'Tip 5',
              'Adjust trackHeight to complement thumb size',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RoundRangeSliderThumbShape deep demo completed');
  return result;
}

class _RoundThumbPainter extends CustomPainter {
  Color color;
  _RoundThumbPainter(this.color);

  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 3;

    Paint shadowPaint = Paint();
    shadowPaint.color = Colors.black.withAlpha(40);
    shadowPaint.maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(centerX, centerY + 2), radius, shadowPaint);

    Paint overlayPaint = Paint();
    overlayPaint.color = color.withAlpha(40);
    canvas.drawCircle(Offset(centerX, centerY), radius * 1.6, overlayPaint);

    Paint thumbPaint = Paint();
    thumbPaint.color = color;
    thumbPaint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), radius, thumbPaint);

    Paint highlightPaint = Paint();
    highlightPaint.color = Colors.white.withAlpha(80);
    canvas.drawCircle(
      Offset(centerX - radius * 0.3, centerY - radius * 0.3),
      radius * 0.3,
      highlightPaint,
    );
  }

  bool shouldRepaint(_RoundThumbPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
