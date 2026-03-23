// ignore_for_file: avoid_print
// D4rt test script: Tests RoundedRectRangeSliderTrackShape from material
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

Widget buildRoundedRectRangeSlider(
  String label,
  Color activeColor,
  Color inactiveColor,
  double trackHeight,
  double startVal,
  double endVal,
) {
  print('Building rounded rect range slider: $label');
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
        SizedBox(height: 16),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: RoundedRectRangeSliderTrackShape(),
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: activeColor.withAlpha(40),
            trackHeight: trackHeight,
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
                color: activeColor.withAlpha(25),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Range: ${startVal.toInt()} - ${endVal.toInt()}',
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

Widget buildTrackHeightVariations() {
  print('Building track height variations');
  List<double> heights = [2.0, 4.0, 6.0, 8.0, 12.0, 16.0];
  List<String> heightLabels = [
    'Thin Track (2px)',
    'Default Track (4px)',
    'Medium Track (6px)',
    'Thick Track (8px)',
    'Bold Track (12px)',
    'Extra Bold Track (16px)',
  ];
  List<MaterialColor> heightColors = [
    Colors.lightBlue,
    Colors.indigo,
    Colors.purple,
    Colors.deepOrange,
    Colors.teal,
    Colors.pink,
  ];
  List<double> startValues = [10.0, 20.0, 15.0, 25.0, 30.0, 35.0];
  List<double> endValues = [40.0, 60.0, 55.0, 70.0, 75.0, 80.0];

  List<Widget> sliders = [];
  int h = 0;
  for (h = 0; h < heights.length; h = h + 1) {
    sliders.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: heightColors[h].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: heightColors[h].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: heights[h],
                  decoration: BoxDecoration(
                    color: heightColors[h].shade400,
                    borderRadius: BorderRadius.circular(heights[h] / 2),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  heightLabels[h],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: heightColors[h].shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: RoundedRectRangeSliderTrackShape(),
                activeTrackColor: heightColors[h].shade600,
                inactiveTrackColor: heightColors[h].shade200,
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8 + heights[h] / 4,
                ),
                overlayColor: heightColors[h].withAlpha(30),
                trackHeight: heights[h],
              ),
              child: RangeSlider(
                values: RangeValues(startValues[h], endValues[h]),
                min: 0,
                max: 100,
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Range: ${startValues[h].toInt()} - ${endValues[h].toInt()}',
              style: TextStyle(fontSize: 11, color: heightColors[h].shade600),
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
          'RoundedRectRangeSliderTrackShape with different track heights',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sliders),
      ],
    ),
  );
}

Widget buildActiveInactiveColors() {
  print('Building active/inactive color variations');
  List<String> colorSchemes = [
    'Blue Theme',
    'Green Theme',
    'Orange Theme',
    'Purple Theme',
    'Red Theme',
    'Teal Theme',
  ];
  List<MaterialColor> activeColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];
  List<MaterialColor> inactiveColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];
  List<double> startVals = [15.0, 25.0, 10.0, 20.0, 30.0, 35.0];
  List<double> endVals = [50.0, 65.0, 45.0, 60.0, 70.0, 80.0];

  List<Widget> colorCards = [];
  int c = 0;
  for (c = 0; c < colorSchemes.length; c = c + 1) {
    colorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
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
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: activeColors[c].shade600,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: inactiveColors[c].shade200,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  colorSchemes[c],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: activeColors[c].shade800,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Active / Inactive',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: RoundedRectRangeSliderTrackShape(),
                activeTrackColor: activeColors[c].shade600,
                inactiveTrackColor: inactiveColors[c].shade200,
                rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
                overlayColor: activeColors[c].withAlpha(35),
                trackHeight: 6.0,
              ),
              child: RangeSlider(
                values: RangeValues(startVals[c], endVals[c]),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels('${startVals[c].toInt()}', '${endVals[c].toInt()}'),
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active: shade600',
                  style: TextStyle(fontSize: 10, color: activeColors[c].shade600),
                ),
                Text(
                  '${startVals[c].toInt()} - ${endVals[c].toInt()}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: activeColors[c].shade700,
                  ),
                ),
                Text(
                  'Inactive: shade200',
                  style: TextStyle(fontSize: 10, color: inactiveColors[c].shade400),
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
          'Active & Inactive Color Combinations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different color schemes for active and inactive track portions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorCards),
      ],
    ),
  );
}

Widget buildSliderThemeConfiguration() {
  print('Building SliderTheme configuration examples');
  List<String> configNames = [
    'Default Configuration',
    'Compact Style',
    'Bold Accent',
    'Minimal Design',
    'High Contrast',
    'Soft Touch',
  ];
  List<MaterialColor> configColors = [
    Colors.indigo,
    Colors.cyan,
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.grey,
    Colors.pink,
  ];
  List<double> configTrackHeights = [4.0, 2.0, 10.0, 3.0, 6.0, 5.0];
  List<double> configThumbRadii = [10.0, 6.0, 14.0, 5.0, 12.0, 9.0];
  List<double> configOverlayRadii = [20.0, 12.0, 28.0, 10.0, 24.0, 18.0];
  List<double> startRanges = [20.0, 15.0, 25.0, 30.0, 10.0, 35.0];
  List<double> endRanges = [55.0, 45.0, 70.0, 60.0, 50.0, 75.0];

  List<Widget> configCards = [];
  int i = 0;
  for (i = 0; i < configNames.length; i = i + 1) {
    configCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: configColors[i].shade300),
          boxShadow: [
            BoxShadow(
              color: configColors[i].withAlpha(20),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
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
                    color: configColors[i].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: configColors[i].shade700,
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
                        configNames[i],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: configColors[i].shade800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Track: ${configTrackHeights[i].toInt()}px | Thumb: ${configThumbRadii[i].toInt()}px',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: RoundedRectRangeSliderTrackShape(),
                activeTrackColor: configColors[i].shade600,
                inactiveTrackColor: configColors[i].shade200,
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: configThumbRadii[i],
                ),
                overlayColor: configColors[i].withAlpha(40),
                overlayShape: RoundSliderOverlayShape(
                  overlayRadius: configOverlayRadii[i],
                ),
                trackHeight: configTrackHeights[i],
                valueIndicatorColor: configColors[i].shade700,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: RangeSlider(
                values: RangeValues(startRanges[i], endRanges[i]),
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels('${startRanges[i].toInt()}', '${endRanges[i].toInt()}'),
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Track Height',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                    ),
                    Text(
                      '${configTrackHeights[i].toInt()} px',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: configColors[i].shade700,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Thumb Radius',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                    ),
                    Text(
                      '${configThumbRadii[i].toInt()} px',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: configColors[i].shade700,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Overlay Radius',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                    ),
                    Text(
                      '${configOverlayRadii[i].toInt()} px',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: configColors[i].shade700,
                      ),
                    ),
                  ],
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
          'SliderTheme Configuration Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Complete SliderThemeData configurations with RoundedRectRangeSliderTrackShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: configCards),
      ],
    ),
  );
}

Widget buildTrackShapeComparison() {
  print('Building track shape comparison: rounded vs rectangular');

  List<Widget> comparisonCards = [];

  Container roundedCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.rounded_corner, color: Colors.indigo.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'Rounded Rectangle Track',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'RoundedRectRangeSliderTrackShape creates smooth, pill-shaped track segments',
          style: TextStyle(fontSize: 12, color: Colors.indigo.shade600),
        ),
        SizedBox(height: 14),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: RoundedRectRangeSliderTrackShape(),
            activeTrackColor: Colors.indigo.shade600,
            inactiveTrackColor: Colors.indigo.shade200,
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 12),
            overlayColor: Colors.indigo.withAlpha(35),
            trackHeight: 8.0,
          ),
          child: RangeSlider(
            values: RangeValues(25.0, 65.0),
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels('25', '65'),
            onChanged: (RangeValues vals) {},
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 40,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.indigo.shade600,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Rounded ends give a modern, smooth appearance',
              style: TextStyle(fontSize: 11, color: Colors.indigo.shade700),
            ),
          ],
        ),
      ],
    ),
  );
  comparisonCards.add(roundedCard);

  Container rectangularCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepOrange.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.rectangle, color: Colors.deepOrange.shade700, size: 24),
            SizedBox(width: 10),
            Text(
              'Rectangular Track',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'RectangularRangeSliderTrackShape creates sharp-edged track segments',
          style: TextStyle(fontSize: 12, color: Colors.deepOrange.shade600),
        ),
        SizedBox(height: 14),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: RectangularRangeSliderTrackShape(),
            activeTrackColor: Colors.deepOrange.shade600,
            inactiveTrackColor: Colors.deepOrange.shade200,
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 12),
            overlayColor: Colors.deepOrange.withAlpha(35),
            trackHeight: 8.0,
          ),
          child: RangeSlider(
            values: RangeValues(25.0, 65.0),
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels('25', '65'),
            onChanged: (RangeValues vals) {},
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 40,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade600,
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Sharp corners give a more angular, technical look',
              style: TextStyle(fontSize: 11, color: Colors.deepOrange.shade700),
            ),
          ],
        ),
      ],
    ),
  );
  comparisonCards.add(rectangularCard);

  List<Widget> sideBySideItems = [];
  int s = 0;
  for (s = 0; s < 3; s = s + 1) {
    double baseStart = 15.0 + (s * 10);
    double baseEnd = 55.0 + (s * 12);
    sideBySideItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Text(
              'Comparison Set ${s + 1}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Rounded:',
                  style: TextStyle(fontSize: 11, color: Colors.indigo.shade600),
                ),
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: RoundedRectRangeSliderTrackShape(),
                activeTrackColor: Colors.indigo.shade500,
                inactiveTrackColor: Colors.indigo.shade100,
                rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 8),
                trackHeight: 6.0,
              ),
              child: RangeSlider(
                values: RangeValues(baseStart, baseEnd),
                min: 0,
                max: 100,
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Rectangular:',
                  style: TextStyle(fontSize: 11, color: Colors.deepOrange.shade600),
                ),
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: RectangularRangeSliderTrackShape(),
                activeTrackColor: Colors.deepOrange.shade500,
                inactiveTrackColor: Colors.deepOrange.shade100,
                rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 8),
                trackHeight: 6.0,
              ),
              child: RangeSlider(
                values: RangeValues(baseStart, baseEnd),
                min: 0,
                max: 100,
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Range: ${baseStart.toInt()} - ${baseEnd.toInt()}',
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
          'Rounded vs Rectangular Track Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Visual comparison between RoundedRectRangeSliderTrackShape and RectangularRangeSliderTrackShape',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: comparisonCards),
        SizedBox(height: 12),
        Text(
          'Side-by-Side Comparisons',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        Column(children: sideBySideItems),
      ],
    ),
  );
}

Widget buildRangeSliderGallery() {
  print('Building range slider gallery');
  List<String> galleryLabels = [
    'Volume Range',
    'Price Filter',
    'Temperature Range',
    'Age Group',
    'Time Span',
    'Rating Range',
  ];
  List<MaterialColor> galleryColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.amber,
    Colors.purple,
    Colors.cyan,
  ];
  List<IconData> galleryIcons = [
    Icons.volume_up,
    Icons.attach_money,
    Icons.thermostat,
    Icons.people,
    Icons.access_time,
    Icons.star,
  ];
  List<double> galleryStartVals = [20.0, 100.0, 18.0, 25.0, 9.0, 3.0];
  List<double> galleryEndVals = [80.0, 500.0, 28.0, 65.0, 17.0, 8.0];
  List<double> galleryMins = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  List<double> galleryMaxs = [100.0, 1000.0, 50.0, 100.0, 24.0, 10.0];
  List<String> galleryUnits = ['%', '\$', '°C', 'years', 'hr', 'stars'];

  List<Widget> galleryItems = [];
  int g = 0;
  for (g = 0; g < galleryLabels.length; g = g + 1) {
    galleryItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: galleryColors[g].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: galleryColors[g].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: galleryColors[g].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    galleryIcons[g],
                    color: galleryColors[g].shade700,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      galleryLabels[g],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: galleryColors[g].shade800,
                      ),
                    ),
                    Text(
                      '${galleryStartVals[g].toInt()}${galleryUnits[g]} - ${galleryEndVals[g].toInt()}${galleryUnits[g]}',
                      style: TextStyle(
                        fontSize: 12,
                        color: galleryColors[g].shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: RoundedRectRangeSliderTrackShape(),
                activeTrackColor: galleryColors[g].shade500,
                inactiveTrackColor: galleryColors[g].shade200,
                rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 9),
                overlayColor: galleryColors[g].withAlpha(30),
                trackHeight: 5.0,
              ),
              child: RangeSlider(
                values: RangeValues(galleryStartVals[g], galleryEndVals[g]),
                min: galleryMins[g],
                max: galleryMaxs[g],
                onChanged: (RangeValues vals) {},
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${galleryMins[g].toInt()}${galleryUnits[g]}',
                  style: TextStyle(fontSize: 10, color: galleryColors[g].shade400),
                ),
                Text(
                  '${galleryMaxs[g].toInt()}${galleryUnits[g]}',
                  style: TextStyle(fontSize: 10, color: galleryColors[g].shade400),
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
          'Range Slider Use Case Gallery',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Real-world examples of RoundedRectRangeSliderTrackShape in different contexts',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: galleryItems),
      ],
    ),
  );
}

Widget buildApiReference() {
  print('Building API reference section');
  List<String> apiItems = [
    'RoundedRectRangeSliderTrackShape()',
    'getPreferredRect() - Returns the preferred bounds',
    'paint() - Paints the track on canvas',
    'Horizontal track layout support',
    'Integrates with SliderThemeData',
  ];

  List<Widget> apiWidgets = [];
  int a = 0;
  for (a = 0; a < apiItems.length; a = a + 1) {
    apiWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.blueGrey.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.code, color: Colors.blueGrey.shade600, size: 18),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                apiItems[a],
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'monospace',
                  color: Colors.blueGrey.shade800,
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
      border: Border.all(color: Colors.blueGrey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.blueGrey.shade700, size: 22),
            SizedBox(width: 10),
            Text(
              'API Reference',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: apiWidgets),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('RoundedRectRangeSliderTrackShape deep demo executing');

  print('Class: RoundedRectRangeSliderTrackShape');
  print('Package: material');
  print('Purpose: A RangeSlider track shape with rounded rectangle ends');

  print('Building sections...');

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text('RoundedRectRangeSliderTrackShape Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                Text(
                  'RoundedRectRangeSliderTrackShape',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'A RangeSlider track painter that uses rounded rectangles for smooth, modern track appearance.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Material Library',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'RangeSliderTrackShape',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildSectionHeader('RangeSlider with Rounded Track'),
          buildRoundedRectRangeSlider(
            'Default Rounded Track',
            Colors.indigo.shade600,
            Colors.indigo.shade200,
            4.0,
            20.0,
            70.0,
          ),
          buildRoundedRectRangeSlider(
            'Thick Rounded Track',
            Colors.teal.shade600,
            Colors.teal.shade200,
            10.0,
            30.0,
            80.0,
          ),
          buildRoundedRectRangeSlider(
            'Thin Rounded Track',
            Colors.amber.shade700,
            Colors.amber.shade200,
            2.0,
            15.0,
            55.0,
          ),
          buildSectionHeader('Track Height Variations'),
          buildTrackHeightVariations(),
          buildSectionHeader('Active & Inactive Colors'),
          buildActiveInactiveColors(),
          buildSectionHeader('SliderTheme Configuration'),
          buildSliderThemeConfiguration(),
          buildSectionHeader('Comparison with Rectangular Track'),
          buildTrackShapeComparison(),
          buildSectionHeader('Range Slider Gallery'),
          buildRangeSliderGallery(),
          buildSectionHeader('API Reference'),
          buildApiReference(),
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
                FlutterLogo(size: 32, style: FlutterLogoStyle.horizontal),
                SizedBox(height: 8),
                Text(
                  'RoundedRectRangeSliderTrackShape Demo Complete',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Part of the Flutter Material library deep demo series',
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
