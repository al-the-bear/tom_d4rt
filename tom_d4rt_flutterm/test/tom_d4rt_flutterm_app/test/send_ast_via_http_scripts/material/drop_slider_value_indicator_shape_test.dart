// D4rt test script: Tests DropSliderValueIndicatorShape from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
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

Widget buildSliderWithDropIndicator(
  String label,
  Color activeColor,
  Color thumbColor,
  double initialValue,
  bool showLabel,
) {
  print('Building slider with drop indicator: $label');
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
            valueIndicatorShape: DropSliderValueIndicatorShape(),
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

Widget buildRangeSliderWithDropIndicator(
  String label,
  Color activeColor,
  double startVal,
  double endVal,
) {
  print('Building range slider with drop indicator: $label');
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
            rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
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
    'Drop Shape',
    'Paddle Shape',
    'Rectangular Shape',
    'Round Shape',
  ];
  List<MaterialColor> shapeColors = [
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.pink,
  ];
  List<IconData> shapeIcons = [
    Icons.water_drop,
    Icons.sports_tennis,
    Icons.rectangle,
    Icons.circle,
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
    Colors.blue,
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
                valueIndicatorShape: DropSliderValueIndicatorShape(),
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
          'Each using DropSliderValueIndicatorShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: themeCards),
      ],
    ),
  );
}

Widget buildDropIndicatorAnatomy() {
  print('Building drop indicator anatomy');
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
          'Drop Indicator Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Container(
                width: 48,
                height: 56,
                child: CustomPaint(
                  painter: _DropShapePainter(Colors.deepPurple),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Drop Shape',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildAnatomyRow(
          'Body',
          'Rounded top portion containing the value text',
          Colors.deepPurple.shade100,
        ),
        _buildAnatomyRow(
          'Point',
          'Tapered bottom pointing to the thumb position',
          Colors.deepPurple.shade200,
        ),
        _buildAnatomyRow(
          'Text',
          'Centered label showing current slider value',
          Colors.deepPurple.shade300,
        ),
        _buildAnatomyRow(
          'Shadow',
          'Subtle elevation shadow for depth',
          Colors.deepPurple.shade400,
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
    'Deep Purple',
    'Teal',
    'Orange',
    'Pink',
    'Indigo',
    'Cyan',
    'Lime',
    'Brown',
  ];
  List<Color> colors = [
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.lime,
    Colors.brown,
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
                  valueIndicatorShape: DropSliderValueIndicatorShape(),
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
          'Drop Indicator Color Showcase',
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
    'DropSliderValueIndicatorShape()',
    'Color - indicator background color',
    'TextStyle - text inside the indicator',
    'ShowValueIndicator enum value',
    'double - height of the track',
    'SliderComponentShape - thumb appearance',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.deepPurple.shade50 : Colors.white;
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
                  color: Colors.deepPurple.shade800,
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
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'SliderThemeData Properties for Drop Indicator',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DropSliderValueIndicatorShape deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DropSliderValueIndicatorShape Demo'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'DropSliderValueIndicatorShape'),
            buildInfoCard(
              'Purpose',
              'A slider value indicator with a drop/teardrop shape',
            ),
            buildInfoCard('Used In', 'SliderThemeData.valueIndicatorShape'),
            buildInfoCard(
              'Appearance',
              'Rounded top with pointed bottom aiming at thumb',
            ),

            buildSectionHeader('2. Basic Drop Indicator Sliders'),
            buildSliderWithDropIndicator(
              'Purple Drop Slider',
              Colors.deepPurple,
              Colors.deepPurple.shade300,
              65.0,
              true,
            ),
            buildSliderWithDropIndicator(
              'Teal Drop Slider',
              Colors.teal,
              Colors.teal.shade300,
              40.0,
              true,
            ),
            buildSliderWithDropIndicator(
              'Orange Drop Slider',
              Colors.orange.shade700,
              Colors.orange,
              80.0,
              true,
            ),

            buildSectionHeader('3. Range Sliders'),
            buildRangeSliderWithDropIndicator(
              'Price Range',
              Colors.deepPurple,
              20.0,
              70.0,
            ),
            buildRangeSliderWithDropIndicator(
              'Temperature Range',
              Colors.red,
              30.0,
              85.0,
            ),
            buildRangeSliderWithDropIndicator(
              'Age Range',
              Colors.blue,
              10.0,
              50.0,
            ),

            buildSectionHeader('4. Shape Comparison'),
            buildIndicatorShapeComparison(),

            buildSectionHeader('5. Drop Indicator Anatomy'),
            buildDropIndicatorAnatomy(),

            buildSectionHeader('6. Theme Variations'),
            buildSliderThemeGrid(),

            buildSectionHeader('7. Color Showcase'),
            buildSliderColorShowcase(),

            buildSectionHeader('8. Configuration Properties'),
            buildSliderProperties(),

            buildSectionHeader('9. Usage Tips'),
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
              'valueIndicatorColor controls the drop background',
            ),
            buildInfoCard(
              'Tip 4',
              'Combine with custom thumbShape for consistent styling',
            ),
            buildInfoCard(
              'Tip 5',
              'Set showValueIndicator to control when it appears',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('DropSliderValueIndicatorShape deep demo completed');
  return result;
}

class _DropShapePainter extends CustomPainter {
  Color color;
  _DropShapePainter(this.color);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    double cx = size.width / 2;
    double radius = size.width / 2.5;

    canvas.drawCircle(Offset(cx, radius), radius, paint);

    Path path = Path();
    path.moveTo(cx - radius * 0.6, radius + radius * 0.4);
    path.lineTo(cx, size.height);
    path.lineTo(cx + radius * 0.6, radius + radius * 0.4);
    path.close();
    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(_DropShapePainter oldDelegate) {
    return false;
  }
}
