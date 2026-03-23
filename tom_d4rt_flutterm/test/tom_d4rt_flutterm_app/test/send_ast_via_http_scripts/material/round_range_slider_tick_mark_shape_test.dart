// ignore_for_file: avoid_print
// D4rt test script: Tests RoundRangeSliderTickMarkShape from material
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

Widget buildRangeSliderWithDivisions(
  String label,
  Color activeColor,
  int divisions,
  double startVal,
  double endVal,
) {
  print('Building RangeSlider with divisions: $label, divisions=$divisions');
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
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: activeColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$divisions divisions',
                style: TextStyle(
                  fontSize: 12,
                  color: activeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Range: ${startVal.toInt()} - ${endVal.toInt()}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            rangeTickMarkShape: RoundRangeSliderTickMarkShape(),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: activeColor.withAlpha(100),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            trackHeight: 6,
          ),
          child: RangeSlider(
            values: RangeValues(startVal, endVal),
            min: 0,
            max: 100,
            divisions: divisions,
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: activeColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Tick marks: ${divisions + 1}',
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

Widget buildRangeSliderWithTickMarkRadius(
  String label,
  Color activeColor,
  double tickMarkRadius,
  double startVal,
  double endVal,
) {
  print('Building RangeSlider with tick mark radius: $tickMarkRadius');
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
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: activeColor.withAlpha(50),
                shape: BoxShape.circle,
                border: Border.all(color: activeColor, width: 2),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'r=${tickMarkRadius.toStringAsFixed(1)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            rangeTickMarkShape: RoundRangeSliderTickMarkShape(
              tickMarkRadius: tickMarkRadius,
            ),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: activeColor.withAlpha(120),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            trackHeight: 8,
          ),
          child: RangeSlider(
            values: RangeValues(startVal, endVal),
            min: 0,
            max: 100,
            divisions: 10,
            labels: RangeLabels('${startVal.toInt()}', '${endVal.toInt()}'),
            onChanged: (RangeValues vals) {},
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Tick Mark Radius: ${tickMarkRadius.toStringAsFixed(1)} logical pixels',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildActiveInactiveColorDemo() {
  print('Building active/inactive tick color demo');
  List<Map<String, dynamic>> colorConfigs = [
    {
      'label': 'Classic Contrast',
      'activeColor': Colors.indigo,
      'activeTick': Colors.white,
      'inactiveTick': Colors.indigo.shade200,
    },
    {
      'label': 'Bold Active',
      'activeColor': Colors.orange,
      'activeTick': Colors.orange.shade900,
      'inactiveTick': Colors.orange.shade100,
    },
    {
      'label': 'Subtle Ticks',
      'activeColor': Colors.teal,
      'activeTick': Colors.teal.shade100,
      'inactiveTick': Colors.teal.shade50,
    },
    {
      'label': 'High Visibility',
      'activeColor': Colors.pink,
      'activeTick': Colors.yellow,
      'inactiveTick': Colors.pink.shade200,
    },
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < colorConfigs.length; i = i + 1) {
    Map<String, dynamic> cfg = colorConfigs[i];
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: (cfg['activeColor'] as Color).withAlpha(100)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  cfg['label'] as String,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: cfg['activeTick'] as Color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
                Text(
                  'Active',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                SizedBox(width: 8),
                Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: cfg['inactiveTick'] as Color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
                Text(
                  'Inactive',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                rangeTickMarkShape: RoundRangeSliderTickMarkShape(),
                activeTrackColor: cfg['activeColor'] as Color,
                inactiveTrackColor: (cfg['activeColor'] as Color).withAlpha(60),
                activeTickMarkColor: cfg['activeTick'] as Color,
                inactiveTickMarkColor: cfg['inactiveTick'] as Color,
                rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 9),
                trackHeight: 6,
              ),
              child: RangeSlider(
                values: RangeValues(30, 70),
                min: 0,
                max: 100,
                divisions: 10,
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active/Inactive Tick Mark Colors',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different color configurations for tick marks',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        Column(children: items),
      ],
    ),
  );
}

Widget buildSliderThemeWithTickMarks() {
  print('Building SliderTheme with tick marks showcase');
  List<Map<String, dynamic>> themeConfigs = [
    {
      'name': 'Material Default',
      'trackHeight': 4.0,
      'thumbRadius': 10.0,
      'color': Colors.blue,
      'startVal': 20.0,
      'endVal': 60.0,
    },
    {
      'name': 'Thick Track',
      'trackHeight': 10.0,
      'thumbRadius': 12.0,
      'color': Colors.purple,
      'startVal': 30.0,
      'endVal': 80.0,
    },
    {
      'name': 'Minimal Style',
      'trackHeight': 2.0,
      'thumbRadius': 6.0,
      'color': Colors.grey,
      'startVal': 10.0,
      'endVal': 50.0,
    },
    {
      'name': 'Bold Accent',
      'trackHeight': 8.0,
      'thumbRadius': 14.0,
      'color': Colors.red,
      'startVal': 40.0,
      'endVal': 90.0,
    },
    {
      'name': 'Compact',
      'trackHeight': 3.0,
      'thumbRadius': 7.0,
      'color': Colors.green,
      'startVal': 25.0,
      'endVal': 75.0,
    },
  ];

  List<Widget> themeCards = [];
  int t = 0;
  for (t = 0; t < themeConfigs.length; t = t + 1) {
    Map<String, dynamic> cfg = themeConfigs[t];
    Color themeColor = cfg['color'] as Color;
    themeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: themeColor.withAlpha(80)),
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
                    color: themeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  cfg['name'] as String,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Track: ${(cfg['trackHeight'] as double).toInt()}px',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                rangeTickMarkShape: RoundRangeSliderTickMarkShape(),
                activeTrackColor: themeColor,
                inactiveTrackColor: themeColor.withAlpha(50),
                activeTickMarkColor: Colors.white,
                inactiveTickMarkColor: themeColor.withAlpha(100),
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: cfg['thumbRadius'] as double,
                ),
                trackHeight: cfg['trackHeight'] as double,
              ),
              child: RangeSlider(
                values: RangeValues(
                  cfg['startVal'] as double,
                  cfg['endVal'] as double,
                ),
                min: 0,
                max: 100,
                divisions: 10,
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SliderTheme with Tick Marks',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Various SliderThemeData configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: themeCards),
      ],
    ),
  );
}

Widget buildTickMarkShapeComparison() {
  print('Building tick mark shape comparison');
  List<Map<String, dynamic>> shapeInfos = [
    {
      'name': 'RoundRangeSliderTickMarkShape',
      'description': 'Circular tick marks for RangeSlider',
      'icon': Icons.circle,
      'color': Colors.indigo,
    },
    {
      'name': 'RoundSliderTickMarkShape',
      'description': 'Circular tick marks for single Slider',
      'icon': Icons.circle_outlined,
      'color': Colors.teal,
    },
    {
      'name': 'Custom Tick Mark Shape',
      'description': 'User-defined shape via SliderTickMarkShape',
      'icon': Icons.star,
      'color': Colors.orange,
    },
    {
      'name': 'No Tick Marks',
      'description': 'Hidden when divisions is null or 0',
      'icon': Icons.remove,
      'color': Colors.grey,
    },
  ];

  List<Widget> comparisonItems = [];
  int s = 0;
  for (s = 0; s < shapeInfos.length; s = s + 1) {
    Map<String, dynamic> info = shapeInfos[s];
    Color itemColor = info['color'] as Color;
    comparisonItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: itemColor.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: itemColor.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: itemColor.withAlpha(40),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                info['icon'] as IconData,
                color: itemColor,
                size: 28,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info['name'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: itemColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    info['description'] as String,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: itemColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${s + 1}',
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
          'Tick Mark Shape Types',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Comparison of different tick mark shape options',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: comparisonItems),
      ],
    ),
  );
}

Widget buildTickMarkAnatomy() {
  print('Building tick mark anatomy');
  List<Map<String, dynamic>> anatomyParts = [
    {
      'part': 'Center Point',
      'description': 'Position aligned with division mark on track',
      'color': Colors.indigo.shade100,
    },
    {
      'part': 'Radius',
      'description': 'Controls the size of the circular tick mark',
      'color': Colors.indigo.shade200,
    },
    {
      'part': 'Active Color',
      'description': 'Fill color when inside the selected range',
      'color': Colors.indigo.shade300,
    },
    {
      'part': 'Inactive Color',
      'description': 'Fill color when outside the selected range',
      'color': Colors.indigo.shade400,
    },
  ];

  List<Widget> anatomyRows = [];
  int a = 0;
  for (a = 0; a < anatomyParts.length; a = a + 1) {
    Map<String, dynamic> part = anatomyParts[a];
    anatomyRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (part['color'] as Color).withAlpha(30),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (part['color'] as Color).withAlpha(80)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: part['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    part['part'] as String,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    part['description'] as String,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
          'Tick Mark Anatomy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade200,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade200,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.indigo, width: 2),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.indigo, width: 2),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade200,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 6,
                width: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.shade100,
                      Colors.indigo,
                      Colors.indigo,
                      Colors.indigo.shade100,
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Round Tick Marks on Track',
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
        Column(children: anatomyRows),
      ],
    ),
  );
}

Widget buildDivisionsShowcase() {
  print('Building divisions showcase');
  List<int> divisionCounts = [4, 8, 10, 20, 50];
  List<Color> showcaseColors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  List<Widget> divisionSliders = [];
  int d = 0;
  for (d = 0; d < divisionCounts.length; d = d + 1) {
    int divisions = divisionCounts[d];
    Color sliderColor = showcaseColors[d];
    divisionSliders.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 60,
              child: Text(
                '$divisions div',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: sliderColor,
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  rangeTickMarkShape: RoundRangeSliderTickMarkShape(),
                  activeTrackColor: sliderColor,
                  inactiveTrackColor: sliderColor.withAlpha(40),
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: sliderColor.withAlpha(80),
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  trackHeight: 5,
                ),
                child: RangeSlider(
                  values: RangeValues(20, 80),
                  min: 0,
                  max: 100,
                  divisions: divisions,
                  onChanged: (RangeValues vals) {},
                ),
              ),
            ),
            Container(
              width: 50,
              child: Text(
                '${divisions + 1} marks',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
          'Divisions Showcase',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Tick marks appear at each division point',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: divisionSliders),
      ],
    ),
  );
}

Widget buildTickMarkRadiusComparison() {
  print('Building tick mark radius comparison');
  List<double> radiusValues = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0];

  List<Widget> radiusItems = [];
  int r = 0;
  for (r = 0; r < radiusValues.length; r = r + 1) {
    double radius = radiusValues[r];
    radiusItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.indigo.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.withAlpha(30)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 50,
              child: Text(
                '${radius.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  rangeTickMarkShape: RoundRangeSliderTickMarkShape(
                    tickMarkRadius: radius,
                  ),
                  activeTrackColor: Colors.indigo,
                  inactiveTrackColor: Colors.indigo.withAlpha(40),
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: Colors.indigo.withAlpha(100),
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  trackHeight: 6,
                ),
                child: RangeSlider(
                  values: RangeValues(30, 70),
                  min: 0,
                  max: 100,
                  divisions: 10,
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
          'Tick Mark Radius Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'tickMarkRadius parameter controls tick size',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: radiusItems),
      ],
    ),
  );
}

Widget buildSliderThemeProperties() {
  print('Building slider theme properties');
  List<String> propNames = [
    'rangeTickMarkShape',
    'activeTickMarkColor',
    'inactiveTickMarkColor',
    'tickMarkRadius',
    'divisions',
    'activeTrackColor',
    'inactiveTrackColor',
  ];
  List<String> propDescriptions = [
    'RoundRangeSliderTickMarkShape()',
    'Color for ticks inside selected range',
    'Color for ticks outside selected range',
    'Constructor param - tick size in logical pixels',
    'RangeSlider param - number of discrete intervals',
    'Track color inside selected range',
    'Track color outside selected range',
  ];

  List<Widget> propRows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color rowBg = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    propRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: rowBg,
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'SliderThemeData Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: propRows),
      ],
    ),
  );
}

Widget buildUsageTipsSection() {
  print('Building usage tips');
  List<Map<String, String>> tips = [
    {
      'title': 'Tip 1',
      'content': 'Set divisions on RangeSlider to enable tick marks',
    },
    {
      'title': 'Tip 2',
      'content': 'Larger tickMarkRadius values make ticks more visible',
    },
    {
      'title': 'Tip 3',
      'content': 'Contrast activeTickMarkColor with track for visibility',
    },
    {
      'title': 'Tip 4',
      'content': 'Use trackHeight >= tickMarkRadius * 2 for best appearance',
    },
    {
      'title': 'Tip 5',
      'content': 'More divisions means more tick marks and smaller intervals',
    },
    {
      'title': 'Tip 6',
      'content': 'Combine with RoundRangeSliderThumbShape for consistency',
    },
  ];

  List<Widget> tipCards = [];
  int t = 0;
  for (t = 0; t < tips.length; t = t + 1) {
    tipCards.add(
      buildInfoCard(tips[t]['title'] as String, tips[t]['content'] as String),
    );
  }

  return Column(children: tipCards);
}

Widget buildColoredRangeSliderGrid() {
  print('Building colored range slider grid');
  List<String> colorNames = [
    'Red',
    'Green',
    'Blue',
    'Amber',
    'Cyan',
    'Lime',
    'Pink',
    'Teal',
  ];
  List<Color> trackColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber.shade700,
    Colors.cyan,
    Colors.lime.shade700,
    Colors.pink,
    Colors.teal,
  ];
  List<double> startValues = [10, 25, 15, 30, 20, 35, 5, 40];
  List<double> endValues = [50, 75, 85, 70, 60, 90, 45, 80];

  List<Widget> gridItems = [];
  int c = 0;
  for (c = 0; c < colorNames.length; c = c + 1) {
    gridItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
              width: 60,
              child: Text(
                colorNames[c],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: trackColors[c],
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  rangeTickMarkShape: RoundRangeSliderTickMarkShape(),
                  activeTrackColor: trackColors[c],
                  inactiveTrackColor: trackColors[c].withAlpha(40),
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: trackColors[c].withAlpha(80),
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 7,
                  ),
                  trackHeight: 5,
                ),
                child: RangeSlider(
                  values: RangeValues(startValues[c], endValues[c]),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (RangeValues vals) {},
                ),
              ),
            ),
            Container(
              width: 50,
              child: Text(
                '${startValues[c].toInt()}-${endValues[c].toInt()}',
                style: TextStyle(
                  fontSize: 11,
                  color: trackColors[c],
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
          'Color Showcase',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Column(children: gridItems),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('RoundRangeSliderTickMarkShape deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('RoundRangeSliderTickMarkShape Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RoundRangeSliderTickMarkShape'),
            buildInfoCard(
              'Purpose',
              'Draws circular tick marks for RangeSlider divisions',
            ),
            buildInfoCard('Used In', 'SliderThemeData.rangeTickMarkShape'),
            buildInfoCard(
              'Key Property',
              'tickMarkRadius - controls tick mark size',
            ),

            buildSectionHeader('2. RangeSlider with Divisions'),
            buildRangeSliderWithDivisions(
              'Basic 10 Divisions',
              Colors.indigo,
              10,
              20.0,
              70.0,
            ),
            buildRangeSliderWithDivisions(
              'Fine 20 Divisions',
              Colors.teal,
              20,
              30.0,
              80.0,
            ),
            buildRangeSliderWithDivisions(
              'Coarse 5 Divisions',
              Colors.orange.shade700,
              5,
              40.0,
              80.0,
            ),

            buildSectionHeader('3. Tick Mark Radius'),
            buildRangeSliderWithTickMarkRadius(
              'Small Tick Marks',
              Colors.purple,
              1.5,
              20.0,
              60.0,
            ),
            buildRangeSliderWithTickMarkRadius(
              'Medium Tick Marks',
              Colors.cyan,
              3.0,
              25.0,
              75.0,
            ),
            buildRangeSliderWithTickMarkRadius(
              'Large Tick Marks',
              Colors.green,
              5.0,
              30.0,
              80.0,
            ),
            buildTickMarkRadiusComparison(),

            buildSectionHeader('4. Active/Inactive Colors'),
            buildActiveInactiveColorDemo(),

            buildSectionHeader('5. SliderTheme with Tick Marks'),
            buildSliderThemeWithTickMarks(),

            buildSectionHeader('6. Shape Comparison'),
            buildTickMarkShapeComparison(),

            buildSectionHeader('7. Tick Mark Anatomy'),
            buildTickMarkAnatomy(),

            buildSectionHeader('8. Divisions Showcase'),
            buildDivisionsShowcase(),

            buildSectionHeader('9. Color Showcase'),
            buildColoredRangeSliderGrid(),

            buildSectionHeader('10. Configuration Properties'),
            buildSliderThemeProperties(),

            buildSectionHeader('11. Usage Tips'),
            buildUsageTipsSection(),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RoundRangeSliderTickMarkShape deep demo completed');
  return result;
}
