// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollbarThemeData from material
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

Widget buildDescriptionBox(String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.teal.shade900),
    ),
  );
}

Widget buildOverviewSection() {
  print('Building overview section for ScrollbarThemeData');
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
            Icon(Icons.swap_vert, color: Colors.teal, size: 28),
            SizedBox(width: 12),
            Text(
              'ScrollbarThemeData',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildDescriptionBox(
          'ScrollbarThemeData defines the visual properties for Scrollbar widgets. '
          'It controls thickness, colors, radius, visibility options, and interactive '
          'behavior for consistent scrollbar styling across the application.',
        ),
        SizedBox(height: 12),
        buildInfoCard('Widget', 'Scrollbar'),
        buildInfoCard('Theme Wrapper', 'ScrollbarTheme'),
        buildInfoCard('Purpose', 'Consistent scrollbar styling'),
        buildInfoCard('Usage', 'ThemeData.scrollbarTheme or ScrollbarTheme'),
      ],
    ),
  );
}

List<Widget> buildListItems(int count, MaterialColor color, String prefix) {
  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < count; i = i + 1) {
    items.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              '$prefix Item ${i + 1}',
              style: TextStyle(fontSize: 14, color: color.shade800),
            ),
          ],
        ),
      ),
    );
  }
  return items;
}

Widget buildScrollbarInListView() {
  print('Building scrollbar in ListView with theme');
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
          'Scrollbar with ListView',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Basic scrollbar wrapping a scrollable ListView',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(Colors.teal.shade600),
              trackColor: WidgetStateProperty.all(Colors.teal.shade100),
              thickness: WidgetStateProperty.all(8.0),
              radius: Radius.circular(4),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                padding: EdgeInsets.all(4),
                children: buildListItems(15, Colors.teal, 'Basic'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildThicknessVariation(String label, double thickness, MaterialColor color) {
  print('Building thickness variation: $label');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${thickness.toInt()}px',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(color.shade600),
              trackColor: WidgetStateProperty.all(color.shade100),
              thickness: WidgetStateProperty.all(thickness),
              radius: Radius.circular(thickness / 2),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                padding: EdgeInsets.all(4),
                children: buildListItems(12, color, 'Thick'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildThicknessVariationsSection() {
  print('Building thickness variations section');
  return Column(
    children: [
      buildThicknessVariation('Thin (4px)', 4.0, Colors.blue),
      buildThicknessVariation('Medium (8px)', 8.0, Colors.green),
      buildThicknessVariation('Thick (12px)', 12.0, Colors.orange),
      buildThicknessVariation('Extra Thick (16px)', 16.0, Colors.purple),
    ],
  );
}

Widget buildThumbVisibilityDemo(String label, bool alwaysVisible, MaterialColor color) {
  print('Building thumb visibility demo: $label');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: alwaysVisible ? Colors.green.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    alwaysVisible ? Icons.visibility : Icons.visibility_off,
                    size: 14,
                    color: alwaysVisible ? Colors.green.shade700 : Colors.grey.shade600,
                  ),
                  SizedBox(width: 4),
                  Text(
                    alwaysVisible ? 'Visible' : 'Auto-hide',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: alwaysVisible ? Colors.green.shade700 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(color.shade600),
              trackColor: WidgetStateProperty.all(color.shade100),
              thickness: WidgetStateProperty.all(8.0),
              thumbVisibility: WidgetStateProperty.all(alwaysVisible),
            ),
            child: Scrollbar(
              thumbVisibility: alwaysVisible,
              child: ListView(
                padding: EdgeInsets.all(4),
                children: buildListItems(10, color, 'Vis'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildThumbVisibilitySection() {
  print('Building thumb visibility section');
  return Column(
    children: [
      buildThumbVisibilityDemo('Always Visible', true, Colors.indigo),
      buildThumbVisibilityDemo('Auto-hide on Idle', false, Colors.cyan),
    ],
  );
}

Widget buildRadiusVariation(String label, Radius radius, MaterialColor color) {
  print('Building radius variation: $label');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'r=${radius.x.toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(color.shade600),
              trackColor: WidgetStateProperty.all(color.shade100),
              thickness: WidgetStateProperty.all(10.0),
              radius: radius,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              radius: radius,
              child: ListView(
                padding: EdgeInsets.all(4),
                children: buildListItems(10, color, 'Rad'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildRadiusVariationsSection() {
  print('Building radius variations section');
  return Column(
    children: [
      buildRadiusVariation('No Radius (Square)', Radius.zero, Colors.red),
      buildRadiusVariation('Small Radius (4px)', Radius.circular(4), Colors.amber),
      buildRadiusVariation('Medium Radius (8px)', Radius.circular(8), Colors.lime),
      buildRadiusVariation('Full Rounded (16px)', Radius.circular(16), Colors.pink),
    ],
  );
}

Widget buildTrackVisibilityDemo(String label, bool showTrack, MaterialColor color) {
  print('Building track visibility demo: $label');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: showTrack ? Colors.blue.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    showTrack ? Icons.visibility : Icons.visibility_off,
                    size: 14,
                    color: showTrack ? Colors.blue.shade700 : Colors.grey.shade600,
                  ),
                  SizedBox(width: 4),
                  Text(
                    showTrack ? 'Track ON' : 'Track OFF',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: showTrack ? Colors.blue.shade700 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(color.shade600),
              trackColor: WidgetStateProperty.all(
                showTrack ? color.shade200 : Colors.transparent,
              ),
              trackBorderColor: WidgetStateProperty.all(
                showTrack ? color.shade400 : Colors.transparent,
              ),
              thickness: WidgetStateProperty.all(8.0),
              trackVisibility: WidgetStateProperty.all(showTrack),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              trackVisibility: showTrack,
              child: ListView(
                padding: EdgeInsets.all(4),
                children: buildListItems(12, color, 'Track'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTrackVisibilitySection() {
  print('Building track visibility section');
  return Column(
    children: [
      buildTrackVisibilityDemo('Track Visible', true, Colors.deepPurple),
      buildTrackVisibilityDemo('Track Hidden', false, Colors.brown),
    ],
  );
}

Widget buildInteractivePropertyDemo(String label, bool interactive, MaterialColor color) {
  print('Building interactive property demo: $label');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: interactive ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    interactive ? Icons.touch_app : Icons.block,
                    size: 14,
                    color: interactive ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                  SizedBox(width: 4),
                  Text(
                    interactive ? 'Draggable' : 'View Only',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: interactive ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          interactive
              ? 'User can drag the scrollbar thumb to scroll'
              : 'Scrollbar is display-only, no drag interaction',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(color.shade600),
              trackColor: WidgetStateProperty.all(color.shade100),
              thickness: WidgetStateProperty.all(10.0),
              interactive: interactive,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              interactive: interactive,
              child: ListView(
                padding: EdgeInsets.all(4),
                children: buildListItems(15, color, 'Int'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildInteractivePropertySection() {
  print('Building interactive property section');
  return Column(
    children: [
      buildInteractivePropertyDemo('Interactive Scrollbar', true, Colors.teal),
      buildInteractivePropertyDemo('Non-Interactive Scrollbar', false, Colors.grey),
    ],
  );
}

Widget buildColorConfigDemo(
  String label,
  Color thumbColor,
  Color trackColor,
  Color trackBorderColor,
  MaterialColor displayColor,
) {
  print('Building color configuration demo: $label');
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
        SizedBox(height: 8),
        Row(
          children: [
            _buildColorSwatch('Thumb', thumbColor),
            SizedBox(width: 8),
            _buildColorSwatch('Track', trackColor),
            SizedBox(width: 8),
            _buildColorSwatch('Border', trackBorderColor),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(thumbColor),
              trackColor: WidgetStateProperty.all(trackColor),
              trackBorderColor: WidgetStateProperty.all(trackBorderColor),
              thickness: WidgetStateProperty.all(10.0),
              trackVisibility: WidgetStateProperty.all(true),
              radius: Radius.circular(5),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              child: ListView(
                padding: EdgeInsets.all(4),
                children: buildListItems(12, displayColor, 'Color'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildColorSwatch(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade400),
        ),
      ),
      SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
      ),
    ],
  );
}

Widget buildColorConfigurationsSection() {
  print('Building color configurations section');
  return Column(
    children: [
      buildColorConfigDemo(
        'Ocean Theme',
        Colors.blue.shade700,
        Colors.blue.shade100,
        Colors.blue.shade300,
        Colors.blue,
      ),
      buildColorConfigDemo(
        'Forest Theme',
        Colors.green.shade700,
        Colors.green.shade100,
        Colors.green.shade300,
        Colors.green,
      ),
      buildColorConfigDemo(
        'Sunset Theme',
        Colors.deepOrange.shade700,
        Colors.orange.shade100,
        Colors.orange.shade300,
        Colors.orange,
      ),
      buildColorConfigDemo(
        'Night Theme',
        Colors.indigo.shade800,
        Colors.grey.shade800,
        Colors.indigo.shade600,
        Colors.blueGrey,
      ),
      buildColorConfigDemo(
        'Rose Theme',
        Colors.pink.shade600,
        Colors.pink.shade50,
        Colors.pink.shade200,
        Colors.pink,
      ),
    ],
  );
}

Widget buildScrollbarPropertiesGrid() {
  print('Building scrollbar properties grid');
  List<String> propNames = [
    'thickness',
    'thumbColor',
    'trackColor',
    'trackBorderColor',
    'radius',
    'thumbVisibility',
    'trackVisibility',
    'interactive',
    'crossAxisMargin',
    'mainAxisMargin',
  ];
  List<String> propDescriptions = [
    'Width/height of the scrollbar thumb',
    'Color of the scrollbar thumb',
    'Color of the scrollbar track background',
    'Color of the track border',
    'Corner radius of the thumb',
    'Whether thumb is always visible',
    'Whether track is visible',
    'Whether thumb is draggable',
    'Margin perpendicular to scroll',
    'Margin along scroll direction',
  ];
  List<IconData> propIcons = [
    Icons.height,
    Icons.color_lens,
    Icons.view_agenda,
    Icons.border_all,
    Icons.rounded_corner,
    Icons.visibility,
    Icons.dehaze,
    Icons.touch_app,
    Icons.swap_horiz,
    Icons.swap_vert,
  ];
  List<MaterialColor> propColors = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.cyan,
    Colors.red,
    Colors.indigo,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < propNames.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: propColors[i].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: propColors[i].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: propColors[i].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                propIcons[i],
                color: propColors[i].shade700,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propNames[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: propColors[i].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    propDescriptions[i],
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
          'ScrollbarThemeData Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'All configurable properties for scrollbar theming',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildCrossAxisMarginDemo() {
  print('Building cross axis margin demo');
  List<double> margins = [0.0, 4.0, 8.0, 16.0];
  List<MaterialColor> colors = [Colors.red, Colors.green, Colors.blue, Colors.purple];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < margins.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cross Axis Margin: ${margins[i].toInt()}px',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors[i].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${margins[i].toInt()}px',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: colors[i].shade700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(colors[i].shade600),
                  trackColor: WidgetStateProperty.all(colors[i].shade100),
                  thickness: WidgetStateProperty.all(8.0),
                  crossAxisMargin: margins[i],
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    padding: EdgeInsets.all(4),
                    children: buildListItems(8, colors[i], 'M'),
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
          'Cross Axis Margin Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Space between scrollbar and container edge',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildMainAxisMarginDemo() {
  print('Building main axis margin demo');
  List<double> margins = [0.0, 8.0, 16.0, 32.0];
  List<MaterialColor> colors = [Colors.orange, Colors.cyan, Colors.indigo, Colors.lime];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < margins.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Main Axis Margin: ${margins[i].toInt()}px',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors[i].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${margins[i].toInt()}px',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: colors[i].shade700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(colors[i].shade600),
                  trackColor: WidgetStateProperty.all(colors[i].shade100),
                  thickness: WidgetStateProperty.all(8.0),
                  mainAxisMargin: margins[i],
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    padding: EdgeInsets.all(4),
                    children: buildListItems(8, colors[i], 'MA'),
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
          'Main Axis Margin Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Space at top and bottom of the scrollbar',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildMinThumbLengthDemo() {
  print('Building min thumb length demo');
  List<double> minLengths = [18.0, 36.0, 60.0, 100.0];
  List<MaterialColor> colors = [Colors.pink, Colors.teal, Colors.amber, Colors.deepPurple];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < minLengths.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Min Thumb Length: ${minLengths[i].toInt()}px',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors[i].shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${minLengths[i].toInt()}px',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: colors[i].shade700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(colors[i].shade600),
                  trackColor: WidgetStateProperty.all(colors[i].shade100),
                  thickness: WidgetStateProperty.all(8.0),
                  minThumbLength: minLengths[i],
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    padding: EdgeInsets.all(4),
                    children: buildListItems(50, colors[i], 'TL'),
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
          'Minimum Thumb Length',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Prevents thumb from becoming too small for interaction',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildHorizontalScrollbarDemo() {
  print('Building horizontal scrollbar demo');
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
          'Horizontal Scrollbar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'ScrollbarThemeData applies to both vertical and horizontal scrollbars',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(Colors.deepOrange.shade600),
              trackColor: WidgetStateProperty.all(Colors.orange.shade100),
              thickness: WidgetStateProperty.all(8.0),
              radius: Radius.circular(4),
              trackVisibility: WidgetStateProperty.all(true),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildHorizontalItems(20),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildHorizontalItems(int count) {
  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < count; i = i + 1) {
    items.add(
      Container(
        width: 80,
        height: 60,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Center(
          child: Text(
            'H${i + 1}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
        ),
      ),
    );
  }
  return items;
}

Widget buildNestedScrollbarsDemo() {
  print('Building nested scrollbars demo');
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
          'Nested Scrollbar Themes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Different themes for nested scroll regions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(Colors.purple.shade600),
              trackColor: WidgetStateProperty.all(Colors.purple.shade100),
              thickness: WidgetStateProperty.all(10.0),
              radius: Radius.circular(5),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Outer List Header',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                        thumbColor: WidgetStateProperty.all(Colors.cyan.shade600),
                        trackColor: WidgetStateProperty.all(Colors.cyan.shade100),
                        thickness: WidgetStateProperty.all(6.0),
                        radius: Radius.circular(3),
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView(
                          padding: EdgeInsets.all(4),
                          children: buildListItems(10, Colors.cyan, 'Inner'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Outer List Footer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget testWidget() {
  print('Building ScrollbarThemeData deep demo');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ScrollbarThemeData Demo'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildOverviewSection(),

            buildSectionHeader('2. Scrollbar in ListView'),
            buildScrollbarInListView(),

            buildSectionHeader('3. Thickness Variations'),
            buildThicknessVariationsSection(),

            buildSectionHeader('4. Thumb Visibility'),
            buildThumbVisibilitySection(),

            buildSectionHeader('5. Radius Variations'),
            buildRadiusVariationsSection(),

            buildSectionHeader('6. Track Visibility'),
            buildTrackVisibilitySection(),

            buildSectionHeader('7. Interactive Property'),
            buildInteractivePropertySection(),

            buildSectionHeader('8. Color Configurations'),
            buildColorConfigurationsSection(),

            buildSectionHeader('9. Cross Axis Margin'),
            buildCrossAxisMarginDemo(),

            buildSectionHeader('10. Main Axis Margin'),
            buildMainAxisMarginDemo(),

            buildSectionHeader('11. Minimum Thumb Length'),
            buildMinThumbLengthDemo(),

            buildSectionHeader('12. Horizontal Scrollbar'),
            buildHorizontalScrollbarDemo(),

            buildSectionHeader('13. Nested Scrollbars'),
            buildNestedScrollbarsDemo(),

            buildSectionHeader('14. All Properties'),
            buildScrollbarPropertiesGrid(),

            buildSectionHeader('15. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Use ScrollbarTheme to apply consistent styling',
            ),
            buildInfoCard(
              'Tip 2',
              'Set thumbVisibility to always show the scrollbar',
            ),
            buildInfoCard(
              'Tip 3',
              'Use WidgetStateProperty for state-based colors',
            ),
            buildInfoCard(
              'Tip 4',
              'Adjust thickness based on platform conventions',
            ),
            buildInfoCard(
              'Tip 5',
              'Consider trackVisibility for clearer scroll indication',
            ),
            buildInfoCard(
              'Tip 6',
              'Set interactive: false for view-only scrollbars',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('ScrollbarThemeData deep demo completed');
  return result;
}
