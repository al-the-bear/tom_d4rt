// D4rt test script: Tests PaddleRangeSliderValueIndicatorShape from material
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

Widget buildPaddleRangeSlider(
  String label,
  Color activeColor,
  double startVal,
  double endVal,
) {
  print('Building paddle range slider: $label');
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
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Container(
                width: 56,
                height: 64,
                child: CustomPaint(
                  painter: _PaddleShapePainter(Colors.indigo),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Paddle Shape',
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
          'Handle',
          'Long stem that points down to the thumb position',
          Colors.indigo.shade100,
        ),
        _buildAnatomyRow(
          'Paddle Head',
          'Rounded rectangular top area containing the value',
          Colors.indigo.shade200,
        ),
        _buildAnatomyRow(
          'Text Label',
          'Centered text showing the current slider value',
          Colors.indigo.shade300,
        ),
        _buildAnatomyRow(
          'Shadow',
          'Elevation shadow for depth perception',
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

Widget buildMultipleSlidersDemo() {
  print('Building multiple sliders demo');
  List<String> labels = [
    'Budget Range',
    'Duration Selection',
    'Quantity Range',
    'Score Filter',
  ];
  List<MaterialColor> colors = [
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.purple,
  ];
  List<double> startValues = [15.0, 30.0, 5.0, 60.0];
  List<double> endValues = [45.0, 80.0, 35.0, 95.0];

  List<Widget> sliders = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    sliders.add(
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
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: colors[i],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors[i].shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeValueIndicatorShape:
                    PaddleRangeSliderValueIndicatorShape(),
                activeTrackColor: colors[i],
                inactiveTrackColor: colors[i].withAlpha(50),
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
                valueIndicatorColor: colors[i],
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
          'Multiple Range Sliders with Paddle Indicators',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Various use cases with consistent paddle styling',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sliders),
      ],
    ),
  );
}

Widget buildColorCustomization() {
  print('Building color customization demo');
  List<MaterialColor> indicatorColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.pink,
    Colors.cyan,
  ];
  List<String> colorNames = [
    'Red',
    'Green',
    'Blue',
    'Amber',
    'Pink',
    'Cyan',
  ];

  List<Widget> colorCards = [];
  int c = 0;
  for (c = 0; c < indicatorColors.length; c = c + 1) {
    colorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: indicatorColors[c].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: indicatorColors[c].shade200),
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
                    color: indicatorColors[c],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${colorNames[c]} Paddle',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: indicatorColors[c].shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeValueIndicatorShape:
                    PaddleRangeSliderValueIndicatorShape(),
                activeTrackColor: indicatorColors[c],
                inactiveTrackColor: indicatorColors[c].withAlpha(40),
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 7,
                ),
                valueIndicatorColor: indicatorColors[c],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                trackHeight: 3,
              ),
              child: RangeSlider(
                values: RangeValues(20.0 + c * 5, 60.0 + c * 5),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  '${(20 + c * 5)}',
                  '${(60 + c * 5)}',
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
          'Color Customization',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'valueIndicatorColor controls paddle background color',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorCards),
      ],
    ),
  );
}

Widget buildTextStyleDemo() {
  print('Building text style demo');
  List<TextStyle> textStyles = [
    TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.normal),
    TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    TextStyle(color: Colors.yellow, fontSize: 14, fontWeight: FontWeight.w600),
    TextStyle(color: Colors.black, fontSize: 11, fontStyle: FontStyle.italic),
  ];
  List<String> styleDescriptions = [
    'Small Regular',
    'Medium Bold',
    'Large Yellow',
    'Italic Black Text',
  ];
  List<MaterialColor> bgColors = [
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.amber,
  ];

  List<Widget> styleCards = [];
  int s = 0;
  for (s = 0; s < textStyles.length; s = s + 1) {
    styleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColors[s].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: bgColors[s].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              styleDescriptions[s],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: bgColors[s].shade800,
              ),
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeValueIndicatorShape:
                    PaddleRangeSliderValueIndicatorShape(),
                activeTrackColor: bgColors[s],
                inactiveTrackColor: bgColors[s].withAlpha(50),
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
                valueIndicatorColor: bgColors[s],
                valueIndicatorTextStyle: textStyles[s],
                trackHeight: 3,
              ),
              child: RangeSlider(
                values: RangeValues(25.0, 75.0),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels('25', '75'),
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
          'Text Style Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'valueIndicatorTextStyle controls label appearance',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: styleCards),
      ],
    ),
  );
}

Widget buildSizeVariationsDemo() {
  print('Building size variations demo');
  List<double> thumbRadii = [6.0, 8.0, 10.0, 14.0];
  List<double> trackHeights = [2.0, 3.0, 4.0, 6.0];
  List<String> sizeLabels = ['Compact', 'Standard', 'Medium', 'Large'];
  List<MaterialColor> sizeColors = [
    Colors.grey,
    Colors.blue,
    Colors.teal,
    Colors.deepOrange,
  ];

  List<Widget> sizeCards = [];
  int sz = 0;
  for (sz = 0; sz < sizeLabels.length; sz = sz + 1) {
    sizeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: sizeColors[sz].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: sizeColors[sz].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sizeLabels[sz],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: sizeColors[sz].shade800,
                  ),
                ),
                Text(
                  'Thumb: ${thumbRadii[sz].toInt()}px, Track: ${trackHeights[sz].toInt()}px',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeValueIndicatorShape:
                    PaddleRangeSliderValueIndicatorShape(),
                activeTrackColor: sizeColors[sz],
                inactiveTrackColor: sizeColors[sz].withAlpha(50),
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: thumbRadii[sz],
                ),
                valueIndicatorColor: sizeColors[sz],
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                trackHeight: trackHeights[sz],
              ),
              child: RangeSlider(
                values: RangeValues(20.0, 80.0),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels('20', '80'),
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
          'Size Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different thumb and track sizes with paddle indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sizeCards),
      ],
    ),
  );
}

Widget buildShapeComparison() {
  print('Building shape comparison');
  List<String> shapeNames = [
    'Paddle Shape',
    'Rectangular Shape',
    'Drop Shape',
    'Rounded Rect Shape',
  ];
  List<IconData> shapeIcons = [
    Icons.sports_tennis,
    Icons.rectangle_outlined,
    Icons.water_drop,
    Icons.rounded_corner,
  ];
  List<MaterialColor> shapeColors = [
    Colors.indigo,
    Colors.teal,
    Colors.deepPurple,
    Colors.orange,
  ];
  List<String> descriptions = [
    'Paddle-shaped with long stem pointing to thumb',
    'Simple rectangular box above the thumb',
    'Teardrop/drop shape with pointed bottom',
    'Rectangular with rounded corners',
  ];

  List<Widget> comparisonCards = [];
  int sh = 0;
  for (sh = 0; sh < shapeNames.length; sh = sh + 1) {
    comparisonCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: shapeColors[sh].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: shapeColors[sh].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: shapeColors[sh].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                shapeIcons[sh],
                color: shapeColors[sh].shade700,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
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
                    descriptions[sh],
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
          'Shape Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Available rangeValueIndicatorShape options',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: comparisonCards),
      ],
    ),
  );
}

Widget buildInteractiveDemo() {
  print('Building interactive demo section');
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
          'Interactive Range Sliders',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Paddle indicators appear when dragging thumbs',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        _buildInteractiveSliderCard(
          'Price Filter',
          Colors.green,
          10.0,
          90.0,
          '\$',
        ),
        _buildInteractiveSliderCard(
          'Distance Range',
          Colors.blue,
          5.0,
          50.0,
          'km',
        ),
        _buildInteractiveSliderCard(
          'Rating Range',
          Colors.amber,
          30.0,
          100.0,
          '%',
        ),
      ],
    ),
  );
}

Widget _buildInteractiveSliderCard(
  String label,
  MaterialColor color,
  double start,
  double end,
  String unit,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${start.toInt()}$unit - ${end.toInt()}$unit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SliderTheme(
          data: SliderThemeData(
            rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(50),
            rangeThumbShape: RoundRangeSliderThumbShape(
              enabledThumbRadius: 9,
            ),
            overlayColor: color.withAlpha(30),
            valueIndicatorColor: color,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            trackHeight: 4,
          ),
          child: RangeSlider(
            values: RangeValues(start, end),
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels('${start.toInt()}$unit', '${end.toInt()}$unit'),
            onChanged: (RangeValues vals) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildSummaryGrid() {
  print('Building summary grid');
  List<String> summaryLabels = [
    'Class',
    'Package',
    'Purpose',
    'Use Case',
    'Property',
    'Style',
  ];
  List<String> summaryValues = [
    'PaddleRangeSliderValueIndicatorShape',
    'flutter/material.dart',
    'Paddle-shaped value indicators for RangeSlider',
    'rangeValueIndicatorShape in SliderThemeData',
    'valueIndicatorColor for background',
    'valueIndicatorTextStyle for label text',
  ];
  List<IconData> summaryIcons = [
    Icons.class_outlined,
    Icons.inventory_2_outlined,
    Icons.info_outline,
    Icons.touch_app_outlined,
    Icons.color_lens_outlined,
    Icons.text_format,
  ];

  List<Widget> gridItems = [];
  int g = 0;
  for (g = 0; g < summaryLabels.length; g = g + 1) {
    gridItems.add(
      Container(
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
                Icon(
                  summaryIcons[g],
                  size: 18,
                  color: Colors.indigo.shade700,
                ),
                SizedBox(width: 6),
                Text(
                  summaryLabels[g],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              summaryValues[g],
              style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
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
          'Summary',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Key information about PaddleRangeSliderValueIndicatorShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2.2,
          physics: NeverScrollableScrollPhysics(),
          children: gridItems,
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PaddleRangeSliderValueIndicatorShape deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PaddleRangeSliderValueIndicatorShape Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'PaddleRangeSliderValueIndicatorShape'),
            buildInfoCard(
              'Purpose',
              'A paddle-shaped value indicator for RangeSlider widgets',
            ),
            buildInfoCard(
              'Used In',
              'SliderThemeData.rangeValueIndicatorShape',
            ),
            buildInfoCard(
              'Appearance',
              'Elongated paddle with stem pointing to thumb position',
            ),

            buildSectionHeader('2. RangeSlider with Paddle Indicators'),
            buildPaddleRangeSlider(
              'Default Paddle Range Slider',
              Colors.indigo,
              25.0,
              75.0,
            ),
            buildPaddleRangeSlider(
              'Teal Paddle Range Slider',
              Colors.teal,
              15.0,
              60.0,
            ),
            buildPaddleRangeSlider(
              'Deep Orange Paddle Slider',
              Colors.deepOrange,
              30.0,
              85.0,
            ),

            buildSectionHeader('3. Paddle Indicator Appearance'),
            buildPaddleAppearanceDemo(),

            buildSectionHeader('4. Multiple Sliders with Paddle Shape'),
            buildMultipleSlidersDemo(),

            buildSectionHeader('5. Color Customization'),
            buildColorCustomization(),

            buildSectionHeader('6. Text Style in Paddle'),
            buildTextStyleDemo(),

            buildSectionHeader('7. Paddle Size Variations'),
            buildSizeVariationsDemo(),

            buildSectionHeader('8. Comparison with Other Shapes'),
            buildShapeComparison(),

            buildSectionHeader('9. Interactive Range Sliders'),
            buildInteractiveDemo(),

            buildSectionHeader('10. Summary Grid'),
            buildSummaryGrid(),

            buildSectionHeader('11. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Set rangeValueIndicatorShape in SliderThemeData',
            ),
            buildInfoCard(
              'Tip 2',
              'Use divisions for discrete steps and label display',
            ),
            buildInfoCard(
              'Tip 3',
              'valueIndicatorColor sets paddle background color',
            ),
            buildInfoCard(
              'Tip 4',
              'Pair with RoundRangeSliderThumbShape for consistency',
            ),
            buildInfoCard(
              'Tip 5',
              'Set showValueIndicator to control visibility',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('PaddleRangeSliderValueIndicatorShape deep demo completed');
  return result;
}

class _PaddleShapePainter extends CustomPainter {
  Color color;
  _PaddleShapePainter(this.color);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    double cx = size.width / 2;
    double paddleWidth = size.width * 0.9;
    double paddleHeight = size.height * 0.45;
    double stemWidth = 6.0;

    RRect paddleRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, paddleHeight / 2),
        width: paddleWidth,
        height: paddleHeight,
      ),
      Radius.circular(8),
    );
    canvas.drawRRect(paddleRect, paint);

    Path stemPath = Path();
    stemPath.moveTo(cx - stemWidth / 2, paddleHeight * 0.8);
    stemPath.lineTo(cx, size.height);
    stemPath.lineTo(cx + stemWidth / 2, paddleHeight * 0.8);
    stemPath.close();
    canvas.drawPath(stemPath, paint);
  }

  bool shouldRepaint(_PaddleShapePainter oldDelegate) {
    return false;
  }
}
