// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliderTickMarkShape from material
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

Widget buildSliderWithTickMarks(
  String label,
  Color activeColor,
  int divisions,
  double initialValue,
  double tickMarkRadius,
) {
  print('Building slider with tick marks: $label, divisions: $divisions');
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
          'Divisions: $divisions, Tick Radius: $tickMarkRadius',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: tickMarkRadius),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: activeColor.withAlpha(120),
            thumbColor: activeColor,
            trackHeight: 4,
          ),
          child: Slider(
            value: initialValue,
            min: 0,
            max: 100,
            divisions: divisions,
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

Widget buildSliderWithCustomTickColors(
  String label,
  Color activeTickColor,
  Color inactiveTickColor,
  Color trackColor,
  int divisions,
  double value,
) {
  print('Building slider with custom tick colors: $label');
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
        Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: activeTickColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400),
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Active',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            SizedBox(width: 12),
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: inactiveTickColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400),
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Inactive',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
            activeTrackColor: trackColor,
            inactiveTrackColor: trackColor.withAlpha(60),
            activeTickMarkColor: activeTickColor,
            inactiveTickMarkColor: inactiveTickColor,
            thumbColor: trackColor,
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            divisions: divisions,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildTickMarkRadiusComparison() {
  print('Building tick mark radius comparison');
  List<double> radii = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0];
  List<MaterialColor> radiusColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  List<Widget> sliders = [];
  int i = 0;
  for (i = 0; i < radii.length; i = i + 1) {
    sliders.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 60,
              child: Text(
                'R: ${radii[i]}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: radiusColors[i].shade700,
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: radii[i]),
                  activeTrackColor: radiusColors[i],
                  inactiveTrackColor: radiusColors[i].withAlpha(60),
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: radiusColors[i].shade300,
                  thumbColor: radiusColors[i],
                  trackHeight: 4,
                ),
                child: Slider(
                  value: 50,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (double val) {},
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
          'Tick Mark Radius Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RoundSliderTickMarkShape with different tickMarkRadius values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sliders),
      ],
    ),
  );
}

Widget buildDivisionsInteractionDemo() {
  print('Building divisions interaction demo');
  List<int> divisionCounts = [4, 5, 10, 20, 25, 50];
  List<String> divisionLabels = [
    '4 divisions (quarters)',
    '5 divisions (fifths)',
    '10 divisions (tenths)',
    '20 divisions (5% steps)',
    '25 divisions (4% steps)',
    '50 divisions (2% steps)',
  ];

  List<Widget> items = [];
  int d = 0;
  for (d = 0; d < divisionCounts.length; d = d + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              divisionLabels[d],
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2.5),
                activeTrackColor: Colors.indigo,
                inactiveTrackColor: Colors.indigo.withAlpha(60),
                activeTickMarkColor: Colors.white,
                inactiveTickMarkColor: Colors.indigo.shade300,
                thumbColor: Colors.indigo,
                trackHeight: 4,
              ),
              child: Slider(
                value: 50,
                min: 0,
                max: 100,
                divisions: divisionCounts[d],
                onChanged: (double val) {},
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${divisionCounts[d] + 1} tick marks visible',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
          'Divisions Interaction',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Number of tick marks equals divisions + 1 (including endpoints)',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildActiveInactiveColorDemo() {
  print('Building active vs inactive color demo');
  List<String> colorSchemes = [
    'Blue/Grey',
    'Orange/Cream',
    'Green/Light Green',
    'Purple/Lavender',
    'Red/Pink',
    'Teal/Cyan',
  ];
  List<Color> activeColors = [
    Colors.white,
    Colors.orange.shade900,
    Colors.green.shade900,
    Colors.purple.shade900,
    Colors.red.shade900,
    Colors.teal.shade900,
  ];
  List<Color> inactiveColors = [
    Colors.grey.shade400,
    Colors.orange.shade200,
    Colors.green.shade200,
    Colors.purple.shade200,
    Colors.red.shade200,
    Colors.teal.shade200,
  ];
  List<MaterialColor> trackColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];
  List<double> sliderValues = [70.0, 40.0, 60.0, 30.0, 80.0, 50.0];

  List<Widget> schemes = [];
  int c = 0;
  for (c = 0; c < colorSchemes.length; c = c + 1) {
    schemes.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: trackColors[c].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: trackColors[c].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  colorSchemes[c],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: trackColors[c].shade800,
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: activeColors[c],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  'Active',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                SizedBox(width: 8),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: inactiveColors[c],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  'Inactive',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
                activeTrackColor: trackColors[c],
                inactiveTrackColor: trackColors[c].withAlpha(60),
                activeTickMarkColor: activeColors[c],
                inactiveTickMarkColor: inactiveColors[c],
                thumbColor: trackColors[c],
                trackHeight: 4,
              ),
              child: Slider(
                value: sliderValues[c],
                min: 0,
                max: 100,
                divisions: 10,
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
          'Active vs Inactive Tick Mark Colors',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Tick marks on the active side vs inactive side of the thumb',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: schemes),
      ],
    ),
  );
}

Widget buildPaintMethodExplanation() {
  print('Building paint method explanation');
  List<String> paintSteps = [
    'Receives PaintingContext for canvas operations',
    'Gets center offset for tick mark position',
    'Uses parentBox for layout constraints',
    'Retrieves sliderTheme for styling info',
    'Checks enableAnimation for transition state',
    'Determines isEnabled for interaction state',
    'Applies textDirection for RTL support',
  ];
  List<IconData> stepIcons = [
    Icons.brush,
    Icons.location_on,
    Icons.view_module,
    Icons.palette,
    Icons.animation,
    Icons.toggle_on,
    Icons.format_textdirection_l_to_r,
  ];

  List<Widget> steps = [];
  int s = 0;
  for (s = 0; s < paintSteps.length; s = s + 1) {
    steps.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                stepIcons[s],
                color: Colors.indigo.shade700,
                size: 18,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                paintSteps[s],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.indigo.shade700,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${s + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
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
        Text(
          'paint() Method Parameters',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Core parameters used when painting each tick mark',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: steps),
      ],
    ),
  );
}

Widget buildGetPreferredSizeExplanation() {
  print('Building getPreferredSize explanation');
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
          'getPreferredSize() Method',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Purpose',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Returns the preferred size for each tick mark. Used by the slider to properly space tick marks along the track.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
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
                'Parameters',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'sliderTheme: SliderThemeData - provides styling context',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              Text(
                'isEnabled: bool - determines if slider is interactive',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Return Value',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Size - the width and height of the tick mark bounding box',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildRoundSliderTickMarkShapeDetails() {
  print('Building RoundSliderTickMarkShape details');
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.circle,
                color: Colors.indigo.shade700,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RoundSliderTickMarkShape',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Default implementation of SliderTickMarkShape',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Constructor Parameter',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'tickMarkRadius',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'double',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'The radius of the circular tick mark. Controls the visual size.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Features:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Paints circular tick marks at evenly spaced intervals',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Uses activeTickMarkColor for marks on active track portion',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Uses inactiveTickMarkColor for marks on inactive portion',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Supports animation when slider state changes',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSliderTickMarkOverview() {
  print('Building slider tick mark overview');
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
            Icon(
              Icons.linear_scale,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 12),
            Text(
              'SliderTickMarkShape',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Base class for painting tick marks on a slider track',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withAlpha(230),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Responsibilities:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- ',
                    style: TextStyle(color: Colors.amber, fontSize: 14),
                  ),
                  Expanded(
                    child: Text(
                      'Define tick mark visual appearance',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- ',
                    style: TextStyle(color: Colors.amber, fontSize: 14),
                  ),
                  Expanded(
                    child: Text(
                      'Specify preferred size for layout',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- ',
                    style: TextStyle(color: Colors.amber, fontSize: 14),
                  ),
                  Expanded(
                    child: Text(
                      'Paint tick marks at division positions',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- ',
                    style: TextStyle(color: Colors.amber, fontSize: 14),
                  ),
                  Expanded(
                    child: Text(
                      'Support active/inactive color differentiation',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Abstract Class',
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Material Components',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildNoTickMarksVsTickMarks() {
  print('Building no tick marks vs tick marks comparison');
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
          'With vs Without Tick Marks',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Without divisions (continuous)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.blue.withAlpha(60),
                  thumbColor: Colors.blue,
                  trackHeight: 4,
                ),
                child: Slider(
                  value: 50,
                  min: 0,
                  max: 100,
                  onChanged: (double val) {},
                ),
              ),
              SizedBox(height: 4),
              Text(
                'No tick marks - slider moves continuously',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'With divisions (discrete)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
                  activeTrackColor: Colors.indigo,
                  inactiveTrackColor: Colors.indigo.withAlpha(60),
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: Colors.indigo.shade300,
                  thumbColor: Colors.indigo,
                  trackHeight: 4,
                ),
                child: Slider(
                  value: 50,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (double val) {},
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Tick marks appear at each division point',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTickMarkTrackHeightRelation() {
  print('Building tick mark track height relation demo');
  List<double> trackHeights = [2.0, 4.0, 6.0, 8.0, 10.0];
  List<double> tickRadii = [1.5, 2.5, 3.5, 4.5, 5.5];

  List<Widget> heightItems = [];
  int h = 0;
  for (h = 0; h < trackHeights.length; h = h + 1) {
    heightItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Track: ${trackHeights[h].toInt()}px',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Tick: ${tickRadii[h]}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: tickRadii[h]),
                activeTrackColor: Colors.teal,
                inactiveTrackColor: Colors.teal.withAlpha(60),
                activeTickMarkColor: Colors.white,
                inactiveTickMarkColor: Colors.teal.shade300,
                thumbColor: Colors.teal,
                trackHeight: trackHeights[h],
              ),
              child: Slider(
                value: 50,
                min: 0,
                max: 100,
                divisions: 10,
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
          'Tick Mark vs Track Height',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Proportional sizing for visual harmony',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: heightItems),
      ],
    ),
  );
}

Widget buildSliderTickMarkShapeMethodsTable() {
  print('Building methods table');
  List<String> methodNames = [
    'paint()',
    'getPreferredSize()',
  ];
  List<String> methodReturns = [
    'void',
    'Size',
  ];
  List<String> methodDescriptions = [
    'Paints the tick mark on the canvas at the specified position',
    'Returns the size used for layout calculations',
  ];

  List<Widget> methodRows = [];
  int m = 0;
  for (m = 0; m < methodNames.length; m = m + 1) {
    methodRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: m == 0 ? Colors.blue.shade50 : Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: m == 0 ? Colors.blue.shade200 : Colors.green.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    methodNames[m],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: m == 0 ? Colors.blue.shade800 : Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    methodReturns[m],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                methodDescriptions[m],
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
          'SliderTickMarkShape Methods',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Abstract methods that subclasses must implement',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: methodRows),
      ],
    ),
  );
}

Widget buildDisabledSliderTickMarks() {
  print('Building disabled slider tick marks demo');
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
          'Enabled vs Disabled States',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
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
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Enabled',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
                  activeTrackColor: Colors.purple,
                  inactiveTrackColor: Colors.purple.withAlpha(60),
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: Colors.purple.shade300,
                  thumbColor: Colors.purple,
                  trackHeight: 4,
                ),
                child: Slider(
                  value: 60,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (double val) {},
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
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Disabled',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
                  disabledActiveTrackColor: Colors.grey.shade400,
                  disabledInactiveTrackColor: Colors.grey.shade300,
                  disabledActiveTickMarkColor: Colors.grey.shade200,
                  disabledInactiveTickMarkColor: Colors.grey.shade400,
                  disabledThumbColor: Colors.grey.shade400,
                  trackHeight: 4,
                ),
                child: Slider(
                  value: 60,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: null,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tick marks use disabled colors when onChanged is null',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('SliderTickMarkShape deep demo executing');
  print('Building comprehensive test for slider tick mark shapes');

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text('SliderTickMarkShape Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSliderTickMarkOverview(),
          buildSectionHeader('SliderTickMarkShape Overview'),
          buildInfoCard('Class Type', 'Abstract base class for tick mark painting'),
          buildInfoCard('Package', 'flutter/material.dart'),
          buildInfoCard('Purpose', 'Defines visual representation of slider tick marks'),
          buildInfoCard('Default Implementation', 'RoundSliderTickMarkShape'),
          buildSliderTickMarkShapeMethodsTable(),
          buildNoTickMarksVsTickMarks(),
          buildSectionHeader('paint() Method'),
          buildPaintMethodExplanation(),
          buildSliderWithTickMarks(
            'Paint Method in Action',
            Colors.indigo,
            10,
            50,
            3.0,
          ),
          buildSectionHeader('getPreferredSize() Method'),
          buildGetPreferredSizeExplanation(),
          buildInfoCard('Width Calculation', 'Based on tick mark radius'),
          buildInfoCard('Height Calculation', 'Based on tick mark radius'),
          buildInfoCard('Usage', 'Layout system uses this for proper spacing'),
          buildSectionHeader('RoundSliderTickMarkShape'),
          buildRoundSliderTickMarkShapeDetails(),
          buildSliderWithTickMarks(
            'Default Round Tick Marks',
            Colors.teal,
            10,
            40,
            2.5,
          ),
          buildSectionHeader('Tick Mark Radius'),
          buildTickMarkRadiusComparison(),
          buildInfoCard('Small Radius (1-2)', 'Subtle, minimalistic appearance'),
          buildInfoCard('Medium Radius (3-4)', 'Good visibility, standard look'),
          buildInfoCard('Large Radius (5-6)', 'Prominent, bold tick marks'),
          buildTickMarkTrackHeightRelation(),
          buildSectionHeader('Active vs Inactive Colors'),
          buildActiveInactiveColorDemo(),
          buildSliderWithCustomTickColors(
            'Custom Color Scheme',
            Colors.yellow,
            Colors.brown.shade300,
            Colors.brown,
            10,
            65,
          ),
          buildSliderWithCustomTickColors(
            'High Contrast Theme',
            Colors.black,
            Colors.grey.shade400,
            Colors.blueGrey,
            10,
            35,
          ),
          buildDisabledSliderTickMarks(),
          buildSectionHeader('Divisions Interaction'),
          buildDivisionsInteractionDemo(),
          buildInfoCard('Few Divisions (4-5)', 'Large steps, easy selection'),
          buildInfoCard('Medium Divisions (10-20)', 'Balanced precision'),
          buildInfoCard('Many Divisions (25-50)', 'Fine-grained control'),
          buildSliderWithTickMarks(
            'Many Divisions Example',
            Colors.deepOrange,
            50,
            75,
            1.5,
          ),
          SizedBox(height: 32),
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
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.indigo.shade700,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'SliderTickMarkShape provides the foundation for painting tick marks. '
                  'RoundSliderTickMarkShape is the default implementation, painting circular '
                  'marks at division intervals. Customize appearance through tickMarkRadius, '
                  'activeTickMarkColor, and inactiveTickMarkColor in SliderThemeData.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
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
