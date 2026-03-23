// ignore_for_file: avoid_print
// D4rt test script: Tests SliderTrackShape - base class for slider track painting
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

Widget buildSubsectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    margin: EdgeInsets.only(bottom: 6, top: 12),
    decoration: BoxDecoration(
      color: Colors.teal.shade100,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.teal.shade300),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade800,
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

Widget buildDescriptionBox(String title, String content) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
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
            Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
        ),
      ],
    ),
  );
}

Widget buildSliderWithTrackShape(
  String label,
  SliderTrackShape trackShape,
  Color activeColor,
  Color inactiveColor,
  Color thumbColor,
  double trackHeight,
  double initialValue,
) {
  print('Building slider with track shape: $label');
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
          'Track Height: ${trackHeight.toInt()}px',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            trackShape: trackShape,
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
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
            Text('0', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            Text(
              'Value: ${initialValue.toInt()}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: activeColor),
            ),
            Text('100', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          ],
        ),
      ],
    ),
  );
}

Widget buildTrackHeightShowcase() {
  print('Building track height showcase');
  List<double> heights = [2.0, 4.0, 6.0, 8.0, 12.0, 16.0, 20.0, 24.0];
  List<double> values = [20.0, 35.0, 50.0, 65.0, 80.0, 45.0, 60.0, 75.0];
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
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
                  'Track Height Configuration',
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
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: heights[i] * 0.7 + 4),
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

  return Column(children: items);
}

Widget buildActiveInactiveColorDemo() {
  print('Building active/inactive color demo');
  
  List<Map<String, dynamic>> colorCombinations = [
    {
      'name': 'Blue Active - Grey Inactive',
      'active': Colors.blue,
      'inactive': Colors.grey.shade300,
      'value': 40.0,
    },
    {
      'name': 'Green Active - Light Green Inactive',
      'active': Colors.green,
      'inactive': Colors.green.shade100,
      'value': 60.0,
    },
    {
      'name': 'Purple Active - Pink Inactive',
      'active': Colors.purple,
      'inactive': Colors.pink.shade100,
      'value': 55.0,
    },
    {
      'name': 'Orange Active - Yellow Inactive',
      'active': Colors.orange,
      'inactive': Colors.yellow.shade100,
      'value': 75.0,
    },
    {
      'name': 'Teal Active - Cyan Inactive',
      'active': Colors.teal,
      'inactive': Colors.cyan.shade100,
      'value': 35.0,
    },
    {
      'name': 'Indigo Active - Blue Inactive',
      'active': Colors.indigo,
      'inactive': Colors.blue.shade100,
      'value': 50.0,
    },
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < colorCombinations.length; i = i + 1) {
    var combo = colorCombinations[i];
    Color activeCol = combo['active'] as Color;
    Color inactiveCol = combo['inactive'] as Color;
    double val = combo['value'] as double;
    String name = combo['name'] as String;
    
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(30),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: activeCol,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 6),
                Text('Active', style: TextStyle(fontSize: 12)),
                SizedBox(width: 16),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: inactiveCol,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(width: 6),
                Text('Inactive', style: TextStyle(fontSize: 12)),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: activeCol,
                inactiveTrackColor: inactiveCol,
                thumbColor: activeCol,
                trackHeight: 6,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: val,
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

  return Column(children: items);
}

Widget buildRoundedVsRectangularComparison() {
  print('Building rounded vs rectangular comparison');
  
  List<double> values = [30.0, 50.0, 70.0];
  List<MaterialColor> colors = [Colors.blue, Colors.green, Colors.orange];
  List<double> trackHeights = [4.0, 8.0, 12.0];
  
  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < values.length; i = i + 1) {
    items.add(
      Container(
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
              'Track Height: ${trackHeights[i].toInt()}px',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('RoundedRectSliderTrackShape:', style: TextStyle(fontSize: 13)),
            SizedBox(height: 6),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: colors[i],
                inactiveTrackColor: colors[i].withAlpha(80),
                thumbColor: colors[i].shade800,
                trackHeight: trackHeights[i],
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: values[i],
                min: 0,
                max: 100,
                onChanged: (double v) {},
              ),
            ),
            SizedBox(height: 12),
            Text('RectangularSliderTrackShape:', style: TextStyle(fontSize: 13)),
            SizedBox(height: 6),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RectangularSliderTrackShape(),
                activeTrackColor: colors[i],
                inactiveTrackColor: colors[i].withAlpha(80),
                thumbColor: colors[i].shade800,
                trackHeight: trackHeights[i],
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
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

  return Column(children: items);
}

Widget buildPaintMethodDemo() {
  print('Building paint method demonstration');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: Colors.amber.shade700, size: 22),
            SizedBox(width: 8),
            Text(
              'Paint Method Visualization',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'The paint method receives context including parentBox, offset, and track bounds. '
          'It draws the active portion (left of thumb) and inactive portion (right of thumb).',
          style: TextStyle(fontSize: 13, color: Colors.amber.shade800),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('Active Track | Thumb | Inactive Track',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.red.shade200,
                  thumbColor: Colors.amber,
                  trackHeight: 10,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14),
                ),
                child: Slider(
                  value: 50,
                  min: 0,
                  max: 100,
                  onChanged: (double v) {},
                ),
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Active', style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Thumb', style: TextStyle(color: Colors.black, fontSize: 11)),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Inactive', style: TextStyle(fontSize: 11)),
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

Widget buildGetPreferredRectDemo() {
  print('Building getPreferredRect demonstration');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop_square, color: Colors.purple.shade700, size: 22),
            SizedBox(width: 8),
            Text(
              'getPreferredRect Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Returns the track bounds as a Rect. Takes parentBox offset and sliderTheme. '
          'Used by the slider to determine where to position the thumb and overlay.',
          style: TextStyle(fontSize: 13, color: Colors.purple.shade800),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Rect(', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  Text('left', style: TextStyle(color: Colors.blue, fontFamily: 'monospace', fontSize: 12)),
                  Text(', ', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  Text('top', style: TextStyle(color: Colors.green, fontFamily: 'monospace', fontSize: 12)),
                  Text(', ', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  Text('right', style: TextStyle(color: Colors.orange, fontFamily: 'monospace', fontSize: 12)),
                  Text(', ', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  Text('bottom', style: TextStyle(color: Colors.red, fontFamily: 'monospace', fontSize: 12)),
                  Text(')', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                ],
              ),
              SizedBox(height: 12),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: Colors.purple,
                  inactiveTrackColor: Colors.purple.withAlpha(60),
                  thumbColor: Colors.purple.shade800,
                  trackHeight: 8,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                ),
                child: Slider(
                  value: 65,
                  min: 0,
                  max: 100,
                  onChanged: (double v) {},
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCustomTrackShapeExample() {
  print('Building custom track shape example');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.extension, color: Colors.cyan.shade700, size: 22),
            SizedBox(width: 8),
            Text(
              'SliderTrackShape as Base Class',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'SliderTrackShape is an abstract base class. Extend it to create custom track shapes. '
          'Override paint() to define appearance and getPreferredRect() to define bounds.',
          style: TextStyle(fontSize: 13, color: Colors.cyan.shade800),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Built-in implementations:', 
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('RoundedRectSliderTrackShape', 
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('RectangularSliderTrackShape', 
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
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

Widget buildThemeIntegrationDemo() {
  print('Building theme integration demo');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SliderThemeData Integration',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Set trackShape in SliderThemeData to use different track shapes.',
                style: TextStyle(fontSize: 13, color: Colors.deepPurple.shade700),
              ),
              SizedBox(height: 14),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: Colors.deepPurple,
                  inactiveTrackColor: Colors.deepPurple.withAlpha(60),
                  thumbColor: Colors.deepPurple.shade700,
                  trackHeight: 6,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayColor: Colors.deepPurple.withAlpha(30),
                  valueIndicatorColor: Colors.deepPurple,
                  valueIndicatorTextStyle: TextStyle(color: Colors.white, fontSize: 14),
                ),
                child: Slider(
                  value: 55,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '55',
                  onChanged: (double v) {},
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDisabledSliderDemo() {
  print('Building disabled slider demo');
  
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
        Text(
          'Disabled State Styling',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          'Track shapes handle disabled state appearance through theme colors.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Text('Enabled:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RoundedRectSliderTrackShape(),
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.blue.withAlpha(60),
            thumbColor: Colors.blue,
            trackHeight: 6,
          ),
          child: Slider(
            value: 60,
            min: 0,
            max: 100,
            onChanged: (double v) {},
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text('Disabled:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RoundedRectSliderTrackShape(),
            disabledActiveTrackColor: Colors.grey.shade400,
            disabledInactiveTrackColor: Colors.grey.shade200,
            disabledThumbColor: Colors.grey.shade500,
            trackHeight: 6,
          ),
          child: Slider(
            value: 60,
            min: 0,
            max: 100,
            onChanged: null,
          ),
        ),
      ],
    ),
  );
}

Widget buildSecondaryTrackDemo() {
  print('Building secondary track demo');
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.lightBlue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.lightBlue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Secondary Track Value',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          'Sliders can display a secondary track to show buffered content.',
          style: TextStyle(fontSize: 13, color: Colors.lightBlue.shade700),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RoundedRectSliderTrackShape(),
            activeTrackColor: Colors.lightBlue,
            inactiveTrackColor: Colors.lightBlue.withAlpha(30),
            secondaryActiveTrackColor: Colors.lightBlue.shade200,
            thumbColor: Colors.lightBlue.shade700,
            trackHeight: 6,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: 40,
            secondaryTrackValue: 70,
            min: 0,
            max: 100,
            onChanged: (double v) {},
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('Primary: 40%', style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('Secondary: 70%', style: TextStyle(fontSize: 11)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildTrackShapeOverviewSection() {
  print('Building SliderTrackShape overview section');
  
  return Column(
    children: [
      buildDescriptionBox(
        'SliderTrackShape Overview',
        'SliderTrackShape is the abstract base class for painting the horizontal line '
        'on which the slider thumb moves. It defines two key methods: paint() for rendering '
        'the track and getPreferredRect() for calculating track bounds. The framework provides '
        'two concrete implementations: RoundedRectSliderTrackShape and RectangularSliderTrackShape.',
      ),
      buildInfoCard('Type', 'abstract class SliderTrackShape'),
      buildInfoCard('Package', 'flutter/material.dart'),
      buildInfoCard('Key Methods', 'paint(), getPreferredRect()'),
      buildInfoCard('Implementations', 'RoundedRect, Rectangular'),
    ],
  );
}

dynamic build(BuildContext context) {
  print('SliderTrackShape Demo - Building widget tree');
  print('Testing SliderTrackShape - base class for slider track painting');
  print('This includes RoundedRectSliderTrackShape and RectangularSliderTrackShape');
  
  var roundedTrackShape = RoundedRectSliderTrackShape();
  var rectangularTrackShape = RectangularSliderTrackShape();
  
  print('Created track shape instances');
  print('RoundedRectSliderTrackShape type: ${roundedTrackShape.runtimeType}');
  print('RectangularSliderTrackShape type: ${rectangularTrackShape.runtimeType}');
  
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SliderTrackShape Demo',
    theme: ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.grey.shade50,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('SliderTrackShape Demo'),
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. SliderTrackShape Overview'),
            buildTrackShapeOverviewSection(),
            
            buildSectionHeader('2. Paint Method'),
            buildPaintMethodDemo(),
            
            buildSectionHeader('3. getPreferredRect Method'),
            buildGetPreferredRectDemo(),
            
            buildSectionHeader('4. RoundedRectSliderTrackShape'),
            buildSubsectionHeader('Basic Usage'),
            buildSliderWithTrackShape(
              'Rounded Rectangle Track',
              RoundedRectSliderTrackShape(),
              Colors.blue,
              Colors.blue.withAlpha(60),
              Colors.blue.shade800,
              6,
              45,
            ),
            buildSliderWithTrackShape(
              'Thick Rounded Track',
              RoundedRectSliderTrackShape(),
              Colors.green,
              Colors.green.withAlpha(60),
              Colors.green.shade800,
              12,
              65,
            ),
            buildSliderWithTrackShape(
              'Thin Rounded Track',
              RoundedRectSliderTrackShape(),
              Colors.orange,
              Colors.orange.withAlpha(60),
              Colors.orange.shade800,
              3,
              30,
            ),
            
            buildSectionHeader('5. RectangularSliderTrackShape'),
            buildSubsectionHeader('Basic Usage'),
            buildSliderWithTrackShape(
              'Rectangular Track',
              RectangularSliderTrackShape(),
              Colors.purple,
              Colors.purple.withAlpha(60),
              Colors.purple.shade800,
              6,
              55,
            ),
            buildSliderWithTrackShape(
              'Thick Rectangular Track',
              RectangularSliderTrackShape(),
              Colors.teal,
              Colors.teal.withAlpha(60),
              Colors.teal.shade800,
              12,
              70,
            ),
            buildSliderWithTrackShape(
              'Thin Rectangular Track',
              RectangularSliderTrackShape(),
              Colors.pink,
              Colors.pink.withAlpha(60),
              Colors.pink.shade800,
              3,
              40,
            ),
            
            buildSectionHeader('6. Track Height Configurations'),
            buildTrackHeightShowcase(),
            
            buildSectionHeader('7. Active/Inactive Track Colors'),
            buildActiveInactiveColorDemo(),
            
            buildSubsectionHeader('Shape Comparison'),
            buildRoundedVsRectangularComparison(),
            
            buildSubsectionHeader('Custom Track Shape Extensibility'),
            buildCustomTrackShapeExample(),
            
            buildSubsectionHeader('Theme Integration'),
            buildThemeIntegrationDemo(),
            
            buildSubsectionHeader('Disabled State'),
            buildDisabledSliderDemo(),
            
            buildSubsectionHeader('Secondary Track'),
            buildSecondaryTrackDemo(),
            
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade300),
              ),
              child: Column(
                children: [
                  Text(
                    'SliderTrackShape Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'SliderTrackShape provides the foundation for customizing slider tracks. '
                    'Use RoundedRectSliderTrackShape for soft edges or RectangularSliderTrackShape '
                    'for sharp corners. Configure track height and colors via SliderThemeData.',
                    style: TextStyle(fontSize: 13, color: Colors.teal.shade900),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );
}
