// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliderComponentShape base class from material
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

Widget buildConceptCard(String title, String description, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
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

Widget buildSliderWithThumbShape(
  String label,
  Color activeColor,
  Color thumbColor,
  double initialValue,
  double thumbRadius,
) {
  print('Building slider with thumb shape: $label');
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
          'Thumb Radius: $thumbRadius',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbRadius),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: thumbColor,
            trackHeight: 4,
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

Widget buildSliderWithOverlayShape(
  String label,
  Color activeColor,
  Color overlayColor,
  double overlayRadius,
  double value,
) {
  print('Building slider with overlay shape: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: activeColor.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: overlayColor.withAlpha(60),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Overlay: ${overlayRadius.toInt()}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: overlayColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: RoundSliderOverlayShape(overlayRadius: overlayRadius),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: activeColor,
            overlayColor: overlayColor.withAlpha(80),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            onChanged: (double val) {},
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.touch_app, size: 16, color: Colors.grey.shade600),
            SizedBox(width: 6),
            Text(
              'Press and hold to see the overlay effect',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSliderWithValueIndicator(
  String label,
  Color activeColor,
  SliderComponentShape indicatorShape,
  String shapeName,
  double value,
) {
  print('Building slider with value indicator: $label');
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
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: activeColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                shapeName,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: activeColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            valueIndicatorShape: indicatorShape,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: activeColor,
            valueIndicatorColor: activeColor,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${value.toInt()}',
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildComponentMethodCard(String method, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            method,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildShapeTypeCard(String shapeName, String description, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shapeName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
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

Widget buildSliderComparisonCard(
  String title,
  double thumbRadius1,
  double thumbRadius2,
  double thumbRadius3,
  Color color,
) {
  print('Building slider comparison: $title');
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
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Small (${thumbRadius1.toInt()})',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 6),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbRadius1),
                      activeTrackColor: color,
                      inactiveTrackColor: color.withAlpha(60),
                      thumbColor: color,
                      trackHeight: 3,
                    ),
                    child: Slider(
                      value: 50,
                      min: 0,
                      max: 100,
                      onChanged: (double val) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Medium (${thumbRadius2.toInt()})',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 6),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbRadius2),
                      activeTrackColor: color,
                      inactiveTrackColor: color.withAlpha(60),
                      thumbColor: color,
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: 50,
                      min: 0,
                      max: 100,
                      onChanged: (double val) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Large (${thumbRadius3.toInt()})',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 6),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbRadius3),
                      activeTrackColor: color,
                      inactiveTrackColor: color.withAlpha(60),
                      thumbColor: color,
                      trackHeight: 5,
                    ),
                    child: Slider(
                      value: 50,
                      min: 0,
                      max: 100,
                      onChanged: (double val) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildValueIndicatorComparisonSection() {
  print('Building value indicator comparison section');
  List<Map<String, dynamic>> indicators = [
    {
      'name': 'Drop Shape',
      'shape': DropSliderValueIndicatorShape(),
      'color': Colors.deepPurple,
      'value': 25.0,
    },
    {
      'name': 'Paddle Shape',
      'shape': PaddleSliderValueIndicatorShape(),
      'color': Colors.teal,
      'value': 50.0,
    },
    {
      'name': 'Rectangular Shape',
      'shape': RectangularSliderValueIndicatorShape(),
      'color': Colors.orange,
      'value': 75.0,
    },
  ];

  List<Widget> widgets = [];
  int i = 0;
  for (i = 0; i < indicators.length; i = i + 1) {
    Map<String, dynamic> indicator = indicators[i];
    widgets.add(
      buildSliderWithValueIndicator(
        indicator['name'] as String,
        indicator['color'] as Color,
        indicator['shape'] as SliderComponentShape,
        indicator['name'] as String,
        indicator['value'] as double,
      ),
    );
  }
  return Column(children: widgets);
}

Widget buildOverlayComparisonSection() {
  print('Building overlay comparison section');
  List<Map<String, dynamic>> overlays = [
    {
      'label': 'Small Overlay (16)',
      'color': Colors.blue,
      'overlayColor': Colors.blue,
      'radius': 16.0,
      'value': 30.0,
    },
    {
      'label': 'Medium Overlay (24)',
      'color': Colors.green,
      'overlayColor': Colors.green,
      'radius': 24.0,
      'value': 50.0,
    },
    {
      'label': 'Large Overlay (32)',
      'color': Colors.purple,
      'overlayColor': Colors.purple,
      'radius': 32.0,
      'value': 70.0,
    },
  ];

  List<Widget> widgets = [];
  int i = 0;
  for (i = 0; i < overlays.length; i = i + 1) {
    Map<String, dynamic> overlay = overlays[i];
    widgets.add(
      buildSliderWithOverlayShape(
        overlay['label'] as String,
        overlay['color'] as Color,
        overlay['overlayColor'] as Color,
        overlay['radius'] as double,
        overlay['value'] as double,
      ),
    );
  }
  return Column(children: widgets);
}

Widget buildPaintMethodSection() {
  print('Building paint method section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: Colors.blueGrey.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'paint() Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'The paint method is called to render the slider component on the canvas. '
          'It receives context details through PaintingContext and offset parameters.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildComponentMethodCard(
          'PaintingContext',
          'Provides the Canvas for drawing operations',
          Colors.blue,
        ),
        buildComponentMethodCard(
          'Offset center',
          'The center position where the component should be painted',
          Colors.green,
        ),
        buildComponentMethodCard(
          'Animation activationAnimation',
          'Animation progress for active state transitions',
          Colors.orange,
        ),
        buildComponentMethodCard(
          'Animation enableAnimation',
          'Animation progress for enable/disable transitions',
          Colors.purple,
        ),
        buildComponentMethodCard(
          'TextPainter labelPainter',
          'Text painter for rendering value labels',
          Colors.red,
        ),
        buildComponentMethodCard(
          'RenderBox parentBox',
          'Reference to the slider RenderBox for size calculations',
          Colors.teal,
        ),
      ],
    ),
  );
}

Widget buildGetPreferredSizeSection() {
  print('Building getPreferredSize section');
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
            Icon(Icons.aspect_ratio, color: Colors.amber.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'getPreferredSize() Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Returns the preferred size of the component shape. This determines '
          'how much space the slider allocates for the component.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.height, color: Colors.amber.shade600, size: 28),
                    SizedBox(height: 6),
                    Text(
                      'Height',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade700,
                      ),
                    ),
                    Text(
                      'Vertical space',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.swap_horiz, color: Colors.amber.shade600, size: 28),
                    SizedBox(height: 6),
                    Text(
                      'Width',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade700,
                      ),
                    ),
                    Text(
                      'Horizontal space',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        buildInfoCard('Return Type', 'Size - width and height dimensions'),
        buildInfoCard('Parameters', 'isEnabled: bool, isDiscrete: bool'),
      ],
    ),
  );
}

Widget buildThumbShapesSection() {
  print('Building thumb shapes section');
  return Column(
    children: [
      buildShapeTypeCard(
        'RoundSliderThumbShape',
        'Default circular thumb with configurable radius, elevation and pressed elevation',
        Icons.circle,
        Colors.blue,
      ),
      buildShapeTypeCard(
        'Custom Thumb Shapes',
        'Extend SliderComponentShape to create custom thumb designs like squares, icons, or images',
        Icons.design_services,
        Colors.purple,
      ),
      SizedBox(height: 12),
      buildSliderComparisonCard(
        'Thumb Size Comparison',
        6.0,
        12.0,
        18.0,
        Colors.indigo,
      ),
    ],
  );
}

Widget buildRoundSliderThumbShapeSection() {
  print('Building RoundSliderThumbShape section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'RoundSliderThumbShape',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'The default thumb shape for a Slider. A circle with configurable size, '
          'elevation, and pressed elevation to provide material design feedback.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14),
        buildInfoCard('enabledThumbRadius', 'Radius when slider is enabled (default: 10.0)'),
        buildInfoCard('disabledThumbRadius', 'Radius when slider is disabled'),
        buildInfoCard('elevation', 'Shadow elevation for the thumb (default: 1.0)'),
        buildInfoCard('pressedElevation', 'Elevation when pressed (default: 6.0)'),
        SizedBox(height: 12),
        buildSliderWithThumbShape(
          'Standard Round Thumb',
          Colors.blue,
          Colors.blue,
          50.0,
          10.0,
        ),
        buildSliderWithThumbShape(
          'Large Round Thumb',
          Colors.green,
          Colors.green,
          70.0,
          16.0,
        ),
      ],
    ),
  );
}

Widget buildRoundSliderOverlayShapeSection() {
  print('Building RoundSliderOverlayShape section');
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple.withAlpha(60),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade600,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'RoundSliderOverlayShape',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'The overlay appears around the thumb when pressed. It provides visual '
          'feedback following material design ripple effect patterns.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14),
        buildInfoCard('overlayRadius', 'Radius of the circular overlay (default: 24.0)'),
        SizedBox(height: 12),
        buildSliderWithOverlayShape(
          'Default Overlay',
          Colors.purple,
          Colors.purple,
          24.0,
          40.0,
        ),
        buildSliderWithOverlayShape(
          'Larger Overlay',
          Colors.deepPurple,
          Colors.deepPurple,
          36.0,
          60.0,
        ),
      ],
    ),
  );
}

Widget buildCustomImplementationsSection() {
  print('Building custom implementations section');
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
        Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.teal.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'Custom Implementations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Extend SliderComponentShape to create unique slider components. '
          'Override paint() and getPreferredSize() methods to customize appearance.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14),
        buildConceptCard(
          'Square Thumb',
          'Create a rectangular thumb by drawing a RRect in the paint method',
          Icons.square,
          Colors.orange,
        ),
        buildConceptCard(
          'Icon Thumb',
          'Draw icons or use TextPainter to render emoji/icons as the thumb',
          Icons.emoji_emotions,
          Colors.pink,
        ),
        buildConceptCard(
          'Gradient Thumb',
          'Apply gradient shaders to create colorful thumb shapes',
          Icons.gradient,
          Colors.cyan,
        ),
        buildConceptCard(
          'Animated Thumb',
          'Use animation values from paint parameters to animate thumb state',
          Icons.animation,
          Colors.indigo,
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Implementation Steps',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 10),
              buildStepItem(1, 'Extend SliderComponentShape class', Colors.teal),
              buildStepItem(2, 'Override getPreferredSize() to return size', Colors.teal),
              buildStepItem(3, 'Override paint() with custom drawing logic', Colors.teal),
              buildStepItem(4, 'Use in SliderThemeData thumbShape property', Colors.teal),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildStepItem(int number, String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildSliderComponentOverview() {
  print('Building slider component overview');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade600, Colors.indigo.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              'SliderComponentShape',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Base class for all slider shape components in Flutter Material design. '
          'Defines the fundamental interface for painting custom slider parts including '
          'thumbs, overlays, value indicators, and tick marks.',
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(230)),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Abstract Class',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                    SizedBox(height: 4),
                    Icon(Icons.account_tree, color: Colors.white, size: 20),
                  ],
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white.withAlpha(60)),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Material Package',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                    SizedBox(height: 4),
                    Icon(Icons.inventory_2, color: Colors.white, size: 20),
                  ],
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white.withAlpha(60)),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Extensible',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                    SizedBox(height: 4),
                    Icon(Icons.extension, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildComponentTypesGrid() {
  print('Building component types grid');
  List<Map<String, dynamic>> types = [
    {
      'name': 'Thumb',
      'desc': 'Draggable handle',
      'icon': Icons.radio_button_checked,
      'color': Colors.blue,
    },
    {
      'name': 'Overlay',
      'desc': 'Press feedback',
      'icon': Icons.blur_circular,
      'color': Colors.purple,
    },
    {
      'name': 'Value Indicator',
      'desc': 'Shows value',
      'icon': Icons.label,
      'color': Colors.green,
    },
    {
      'name': 'Tick Mark',
      'desc': 'Discrete steps',
      'icon': Icons.linear_scale,
      'color': Colors.orange,
    },
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < types.length; i = i + 1) {
    Map<String, dynamic> type = types[i];
    items.add(
      Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: (type['color'] as Color).withAlpha(20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: (type['color'] as Color).withAlpha(60)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              type['icon'] as IconData,
              color: type['color'] as Color,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              type['name'] as String,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              type['desc'] as String,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1.5,
    children: items,
  );
}

Widget buildValueIndicatorsSection() {
  print('Building value indicators section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.label_important, color: Colors.green.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'Value Indicators',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Value indicator shapes display the current slider value. They appear '
          'when the slider is being touched/dragged and provide visual feedback.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14),
        buildShapeTypeCard(
          'DropSliderValueIndicatorShape',
          'Teardrop-shaped indicator that drops from the thumb',
          Icons.water_drop,
          Colors.deepPurple,
        ),
        buildShapeTypeCard(
          'PaddleSliderValueIndicatorShape',
          'Paddle-shaped indicator extending from the thumb',
          Icons.sports_tennis,
          Colors.teal,
        ),
        buildShapeTypeCard(
          'RectangularSliderValueIndicatorShape',
          'Simple rectangular shape above the thumb',
          Icons.rectangle,
          Colors.orange,
        ),
      ],
    ),
  );
}

Widget buildOverlaysSection() {
  print('Building overlays section');
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
            Icon(Icons.blur_on, color: Colors.purple.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'Overlays',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Overlay shapes appear around the thumb when pressed or focused. They '
          'provide touch feedback similar to Material Design ripple effects.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14),
        buildInfoCard('Purpose', 'Shows interaction feedback when user touches the slider'),
        buildInfoCard('Default Shape', 'RoundSliderOverlayShape with 24.0 radius'),
        buildInfoCard('Color', 'Controlled by SliderThemeData.overlayColor'),
        buildInfoCard('Animation', 'Fades in/out based on touch state'),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('SliderComponentShape deep demo test executing');
  print('Class: SliderComponentShape');
  print('Package: material');
  print('Description: Base class for slider component painting');

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text(
        'SliderComponentShape Demo',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSliderComponentOverview(),

          buildSectionHeader('Component Types'),
          buildComponentTypesGrid(),

          buildSectionHeader('Paint Method'),
          buildPaintMethodSection(),

          buildSectionHeader('getPreferredSize Method'),
          buildGetPreferredSizeSection(),

          buildSectionHeader('Thumb Shapes'),
          buildThumbShapesSection(),

          buildSectionHeader('RoundSliderThumbShape'),
          buildRoundSliderThumbShapeSection(),

          buildSectionHeader('Value Indicators'),
          buildValueIndicatorsSection(),
          buildValueIndicatorComparisonSection(),

          buildSectionHeader('Overlays'),
          buildOverlaysSection(),
          buildOverlayComparisonSection(),

          buildSectionHeader('RoundSliderOverlayShape'),
          buildRoundSliderOverlayShapeSection(),

          buildSectionHeader('Custom Implementations'),
          buildCustomImplementationsSection(),

          SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade400, size: 32),
                SizedBox(height: 8),
                Text(
                  'SliderComponentShape Demo Complete',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'All component shapes and methods demonstrated',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}
