// D4rt test script: Tests RoundSliderOverlayShape from material
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

Widget buildBasicSliderWithOverlay(
  String label,
  Color activeColor,
  Color overlayColor,
  double initialValue,
) {
  print('Building basic slider with overlay: $label');
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
          'Press to see overlay effect',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
            overlayColor: overlayColor,
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: activeColor,
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: activeColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Value: ${initialValue.toInt()}',
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

Widget buildOverlayRadiusVariation(
  String label,
  double overlayRadius,
  Color color,
  double value,
) {
  print('Building overlay radius variation: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(100)),
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
                color: color.withAlpha(40),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: overlayRadius.clamp(8.0, 32.0),
                  height: overlayRadius.clamp(8.0, 32.0),
                  decoration: BoxDecoration(
                    color: color.withAlpha(80),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'overlayRadius: ${overlayRadius.toInt()}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: RoundSliderOverlayShape(overlayRadius: overlayRadius),
            overlayColor: color.withAlpha(60),
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(50),
            thumbColor: color,
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            onChanged: (double v) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildOverlayColorConfig(
  String label,
  Color overlayColor,
  Color thumbColor,
  int alphaValue,
  double value,
) {
  print('Building overlay color config: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
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
                color: overlayColor.withAlpha(alphaValue),
                shape: BoxShape.circle,
                border: Border.all(color: thumbColor, width: 2),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Alpha: $alphaValue',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: thumbColor.withAlpha(20),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${value.toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: thumbColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: RoundSliderOverlayShape(overlayRadius: 22),
            overlayColor: overlayColor.withAlpha(alphaValue),
            activeTrackColor: thumbColor,
            inactiveTrackColor: thumbColor.withAlpha(50),
            thumbColor: thumbColor,
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            onChanged: (double v) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildSliderThemeWithOverlay(
  String themeName,
  Color primaryColor,
  double overlayRadius,
  double thumbRadius,
  double trackHeight,
  double value,
) {
  print('Building slider theme with overlay: $themeName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: primaryColor.withAlpha(10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: primaryColor.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: primaryColor, size: 20),
            SizedBox(width: 8),
            Text(
              themeName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: primaryColor.withAlpha(220),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'R:${overlayRadius.toInt()} T:${thumbRadius.toInt()} H:${trackHeight.toInt()}',
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: RoundSliderOverlayShape(overlayRadius: overlayRadius),
            overlayColor: primaryColor.withAlpha(50),
            activeTrackColor: primaryColor,
            inactiveTrackColor: primaryColor.withAlpha(40),
            thumbColor: primaryColor,
            trackHeight: trackHeight,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbRadius),
            valueIndicatorColor: primaryColor,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
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
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Overlay: ${overlayRadius.toInt()}px',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            Text(
              'Thumb: ${thumbRadius.toInt()}px',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            Text(
              'Track: ${trackHeight.toInt()}px',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildOverlayAnimationConcept() {
  print('Building overlay animation concept');
  List<String> stateNames = [
    'Idle State',
    'Hover State',
    'Pressed State',
    'Dragging State',
    'Released State',
  ];
  List<String> stateDescriptions = [
    'No overlay visible - thumb at rest',
    'Subtle overlay appears on mouse hover (desktop)',
    'Full overlay radius when thumb is pressed down',
    'Overlay follows thumb during drag operation',
    'Overlay fades out when interaction ends',
  ];
  List<IconData> stateIcons = [
    Icons.radio_button_unchecked,
    Icons.adjust,
    Icons.circle,
    Icons.motion_photos_on,
    Icons.blur_on,
  ];
  List<Color> stateColors = [
    Colors.grey,
    Colors.blue.shade300,
    Colors.indigo,
    Colors.purple,
    Colors.indigo.shade200,
  ];

  List<Widget> stateCards = [];
  int i = 0;
  for (i = 0; i < stateNames.length; i = i + 1) {
    stateCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: stateColors[i].withAlpha(15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: stateColors[i].withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: stateColors[i].withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                stateIcons[i],
                color: stateColors[i],
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stateNames[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: stateColors[i],
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    stateDescriptions[i],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: stateColors[i], width: 2),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: stateColors[i],
                  ),
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
        Row(
          children: [
            Icon(Icons.animation, color: Colors.indigo, size: 22),
            SizedBox(width: 8),
            Text(
              'Overlay Animation States',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'The round overlay animates through these states during interaction',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stateCards),
      ],
    ),
  );
}

Widget buildOverlaySizeComparison() {
  print('Building overlay size comparison');
  List<String> sizeLabels = ['Tiny', 'Small', 'Medium', 'Large', 'Extra Large'];
  List<double> overlayRadii = [12.0, 18.0, 24.0, 32.0, 40.0];
  List<double> thumbRadii = [4.0, 6.0, 8.0, 10.0, 12.0];
  List<Color> sizeColors = [
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];
  List<double> values = [20.0, 40.0, 60.0, 80.0, 50.0];

  List<Widget> sizeSliders = [];
  int s = 0;
  for (s = 0; s < sizeLabels.length; s = s + 1) {
    sizeSliders.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: sizeColors[s].withAlpha(10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: sizeColors[s].withAlpha(50)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: overlayRadii[s].clamp(12.0, 36.0),
                  height: overlayRadii[s].clamp(12.0, 36.0),
                  decoration: BoxDecoration(
                    color: sizeColors[s].withAlpha(50),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: thumbRadii[s] * 2,
                      height: thumbRadii[s] * 2,
                      decoration: BoxDecoration(
                        color: sizeColors[s],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sizeLabels[s],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: sizeColors[s],
                        ),
                      ),
                      Text(
                        'Overlay: ${overlayRadii[s].toInt()}px | Thumb: ${thumbRadii[s].toInt()}px',
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
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                overlayShape: RoundSliderOverlayShape(
                  overlayRadius: overlayRadii[s],
                ),
                overlayColor: sizeColors[s].withAlpha(50),
                activeTrackColor: sizeColors[s],
                inactiveTrackColor: sizeColors[s].withAlpha(40),
                thumbColor: sizeColors[s],
                trackHeight: 3,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: thumbRadii[s],
                ),
              ),
              child: Slider(
                value: values[s],
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
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.indigo, size: 22),
            SizedBox(width: 8),
            Text(
              'Overlay Size Comparison',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Different overlay radius values for various use cases',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sizeSliders),
      ],
    ),
  );
}

Widget buildOverlayProperties() {
  print('Building overlay properties');
  List<String> propNames = [
    'overlayShape',
    'overlayColor',
    'overlayRadius',
    'thumbColor',
    'thumbShape',
    'activeTrackColor',
  ];
  List<String> propDescriptions = [
    'RoundSliderOverlayShape() - circular overlay around thumb',
    'Color with alpha - semi-transparent overlay background',
    'double - radius of the overlay circle in pixels',
    'Color - the color of the thumb itself',
    'RoundSliderThumbShape - shape of the draggable thumb',
    'Color - the track color before the thumb position',
  ];
  List<IconData> propIcons = [
    Icons.blur_circular,
    Icons.color_lens,
    Icons.radio_button_unchecked,
    Icons.circle,
    Icons.lens,
    Icons.linear_scale,
  ];

  List<Widget> propRows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color rowColor = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    propRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: rowColor,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(propIcons[p], size: 18, color: Colors.indigo.shade400),
            SizedBox(width: 10),
            Container(
              width: 120,
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
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, color: Colors.indigo.shade700, size: 20),
              SizedBox(width: 8),
              Text(
                'SliderThemeData Properties',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
        ),
        Column(children: propRows),
      ],
    ),
  );
}

Widget buildColorfulOverlayGrid() {
  print('Building colorful overlay grid');
  List<String> colorLabels = [
    'Indigo',
    'Purple',
    'Pink',
    'Red',
    'Orange',
    'Amber',
    'Green',
    'Teal',
  ];
  List<Color> colors = [
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.amber.shade700,
    Colors.green,
    Colors.teal,
  ];
  List<double> sliderValues = [25.0, 50.0, 75.0, 60.0, 40.0, 80.0, 35.0, 65.0];

  List<Widget> colorSliders = [];
  int c = 0;
  for (c = 0; c < colorLabels.length; c = c + 1) {
    colorSliders.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
              width: 70,
              child: Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: colors[c],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      colorLabels[c],
                      style: TextStyle(
                        fontSize: 11,
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
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                  overlayColor: colors[c].withAlpha(60),
                  activeTrackColor: colors[c],
                  inactiveTrackColor: colors[c].withAlpha(40),
                  thumbColor: colors[c],
                  trackHeight: 3,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
                ),
                child: Slider(
                  value: sliderValues[c],
                  min: 0,
                  max: 100,
                  onChanged: (double v) {},
                ),
              ),
            ),
            Container(
              width: 28,
              child: Text(
                '${sliderValues[c].toInt()}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colors[c],
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
        Row(
          children: [
            Icon(Icons.color_lens, color: Colors.indigo, size: 22),
            SizedBox(width: 8),
            Text(
              'Overlay Color Showcase',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Press each slider to see the overlay color',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorSliders),
      ],
    ),
  );
}

Widget buildOverlayAnatomySection() {
  print('Building overlay anatomy section');
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
          'Round Overlay Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withAlpha(40),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(40),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Overlay + Thumb',
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
        _buildAnatomyDetail(
          'Overlay Circle',
          'Semi-transparent circle shown during press/focus',
          Colors.indigo.shade100,
        ),
        _buildAnatomyDetail(
          'Thumb',
          'Solid circle at center - the draggable element',
          Colors.indigo.shade200,
        ),
        _buildAnatomyDetail(
          'Overlay Radius',
          'Distance from thumb center to overlay edge',
          Colors.indigo.shade300,
        ),
        _buildAnatomyDetail(
          'Alpha Channel',
          'Transparency level for the overlay color',
          Colors.indigo.shade400,
        ),
      ],
    ),
  );
}

Widget _buildAnatomyDetail(String part, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
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

Widget buildAccessibilitySection() {
  print('Building accessibility section');
  List<String> accessibilityTips = [
    'Larger overlay radius improves touch target on mobile',
    'High contrast overlay helps users see focus state',
    'Overlay provides visual feedback for screen reader focus',
    'Consistent overlay sizing aids motor-impaired users',
    'Sufficient alpha ensures visibility on all backgrounds',
  ];

  List<Widget> tipCards = [];
  int t = 0;
  for (t = 0; t < accessibilityTips.length; t = t + 1) {
    tipCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Row(
          children: [
            Icon(
              Icons.accessibility_new,
              size: 18,
              color: Colors.blue.shade600,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                accessibilityTips[t],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
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
        Row(
          children: [
            Icon(Icons.accessibility, color: Colors.blue.shade700, size: 22),
            SizedBox(width: 8),
            Text(
              'Accessibility Considerations',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: tipCards),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('RoundSliderOverlayShape deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('RoundSliderOverlayShape Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RoundSliderOverlayShape'),
            buildInfoCard(
              'Purpose',
              'Circular overlay shown when slider thumb is pressed or focused',
            ),
            buildInfoCard('Used In', 'SliderThemeData.overlayShape'),
            buildInfoCard(
              'Appearance',
              'Semi-transparent circle centered on the thumb',
            ),
            buildInfoCard(
              'Constructor',
              'RoundSliderOverlayShape(overlayRadius: double)',
            ),

            buildSectionHeader('2. Basic Sliders with Overlay'),
            buildBasicSliderWithOverlay(
              'Indigo Overlay',
              Colors.indigo,
              Colors.indigo.withAlpha(80),
              55.0,
            ),
            buildBasicSliderWithOverlay(
              'Teal Overlay',
              Colors.teal,
              Colors.teal.withAlpha(80),
              35.0,
            ),
            buildBasicSliderWithOverlay(
              'Orange Overlay',
              Colors.orange.shade700,
              Colors.orange.withAlpha(80),
              75.0,
            ),

            buildSectionHeader('3. Overlay Radius Variations'),
            buildOverlayRadiusVariation(
              'Minimal Overlay',
              12.0,
              Colors.purple,
              30.0,
            ),
            buildOverlayRadiusVariation(
              'Standard Overlay',
              24.0,
              Colors.blue,
              50.0,
            ),
            buildOverlayRadiusVariation(
              'Large Overlay',
              36.0,
              Colors.green,
              70.0,
            ),
            buildOverlayRadiusVariation(
              'Extra Large Overlay',
              48.0,
              Colors.red,
              45.0,
            ),

            buildSectionHeader('4. Overlay Color Configurations'),
            buildOverlayColorConfig(
              'Light Alpha (30)',
              Colors.indigo,
              Colors.indigo,
              30,
              40.0,
            ),
            buildOverlayColorConfig(
              'Medium Alpha (60)',
              Colors.purple,
              Colors.purple,
              60,
              55.0,
            ),
            buildOverlayColorConfig(
              'Standard Alpha (80)',
              Colors.teal,
              Colors.teal,
              80,
              70.0,
            ),
            buildOverlayColorConfig(
              'High Alpha (120)',
              Colors.orange,
              Colors.orange,
              120,
              25.0,
            ),

            buildSectionHeader('5. SliderTheme with Overlay'),
            buildSliderThemeWithOverlay(
              'Compact Theme',
              Colors.cyan,
              16.0,
              6.0,
              2.0,
              35.0,
            ),
            buildSliderThemeWithOverlay(
              'Standard Theme',
              Colors.indigo,
              24.0,
              10.0,
              4.0,
              50.0,
            ),
            buildSliderThemeWithOverlay(
              'Bold Theme',
              Colors.deepOrange,
              32.0,
              14.0,
              6.0,
              65.0,
            ),
            buildSliderThemeWithOverlay(
              'Touch Friendly Theme',
              Colors.green,
              40.0,
              12.0,
              5.0,
              80.0,
            ),

            buildSectionHeader('6. Overlay Animation Concept'),
            buildOverlayAnimationConcept(),

            buildSectionHeader('7. Different Overlay Sizes'),
            buildOverlaySizeComparison(),

            buildSectionHeader('8. Overlay Anatomy'),
            buildOverlayAnatomySection(),

            buildSectionHeader('9. Colorful Overlay Grid'),
            buildColorfulOverlayGrid(),

            buildSectionHeader('10. Configuration Properties'),
            buildOverlayProperties(),

            buildSectionHeader('11. Accessibility'),
            buildAccessibilitySection(),

            buildSectionHeader('12. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Set overlayShape in SliderThemeData for custom overlay',
            ),
            buildInfoCard(
              'Tip 2',
              'Use alpha values between 40-80 for best visibility',
            ),
            buildInfoCard(
              'Tip 3',
              'Match overlayColor to activeTrackColor for consistency',
            ),
            buildInfoCard(
              'Tip 4',
              'Larger overlayRadius improves touch accessibility',
            ),
            buildInfoCard(
              'Tip 5',
              'Overlay appears automatically on press and focus',
            ),
            buildInfoCard(
              'Tip 6',
              'Combine with matching thumbShape for unified look',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RoundSliderOverlayShape deep demo completed');
  return result;
}
