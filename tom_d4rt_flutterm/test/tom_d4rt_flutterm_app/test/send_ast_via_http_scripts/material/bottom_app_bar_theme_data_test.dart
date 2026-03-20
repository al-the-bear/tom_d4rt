// D4rt test script: Tests BottomAppBarThemeData from material
import 'package:flutter/material.dart';

// Helper to build section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.brown.shade800,
      ),
    ),
  );
}

// Helper to build description
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper to build a property display chip
Widget buildPropertyChip(String label, String value, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 4),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text('$label: $value', style: TextStyle(fontSize: 11, color: color)),
  );
}

// Helper to build a bottom app bar demo
Widget buildBottomAppBarDemo({
  required String title,
  required String description,
  required Color barColor,
  required double elevation,
  NotchedShape? shape,
  double notchMargin = 4.0,
  EdgeInsetsGeometry? padding,
  required Widget child,
  bool showFab = false,
  Color fabColor = Colors.pink,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.brown.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            children: [
              buildPropertyChip(
                'Elevation',
                elevation.toString(),
                Colors.orange,
              ),
              buildPropertyChip(
                'Shape',
                shape != null ? 'Notched' : 'None',
                Colors.purple,
              ),
              buildPropertyChip(
                'Notch Margin',
                notchMargin.toString(),
                Colors.teal,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: showFab ? 80 : 64,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BottomAppBar(
                  color: barColor,
                  elevation: elevation,
                  shape: shape,
                  notchMargin: notchMargin,
                  padding: padding,
                  child: child,
                ),
              ),
              if (showFab)
                Positioned(
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: fabColor,
                    mini: true,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// Helper to build a theme data property card
Widget buildThemeDataPropertyCard({
  required String title,
  required Map<String, String> properties,
  required Color accentColor,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(60)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 4,
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
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...properties.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// Helper to build an info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
      ],
    ),
  );
}

// Helper for icon row inside bottom app bar
Widget buildIconRow(List<IconData> icons, Color iconColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: icons.map((icon) {
      return IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: () {},
        iconSize: 22,
      );
    }).toList(),
  );
}

// Helper for icon and text row
Widget buildIconTextRow(List<Map<String, dynamic>> items, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: items.map((item) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item['icon'] as IconData, color: color, size: 20),
          SizedBox(height: 2),
          Text(
            item['label'] as String,
            style: TextStyle(fontSize: 9, color: color),
          ),
        ],
      );
    }).toList(),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== BottomAppBarThemeData Deep Demo ===');
  debugPrint(
    'Demonstrating BottomAppBar configurations, colors, elevations, shapes',
  );

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown.shade700, Colors.brown.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BottomAppBar Theme Data Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Exploring BottomAppBarThemeData properties and visual configurations',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: ThemeData Properties
        buildSectionTitle('1. BottomAppBarThemeData Properties'),
        buildDescription(
          'Key configurable properties of BottomAppBarThemeData',
        ),

        buildThemeDataPropertyCard(
          title: 'Default Theme',
          properties: {
            'color': 'Surface color',
            'elevation': '8.0',
            'shape': 'null (no notch)',
            'height': 'null (default 80)',
            'surfaceTintColor': 'null',
            'shadowColor': 'null',
            'padding': 'null',
          },
          accentColor: Colors.blue,
        ),

        buildThemeDataPropertyCard(
          title: 'Custom Theme A',
          properties: {
            'color': 'Colors.indigo',
            'elevation': '12.0',
            'shape': 'CircularNotchedRectangle',
            'height': '64.0',
            'surfaceTintColor': 'Colors.indigoAccent',
            'shadowColor': 'Colors.indigo.shade900',
            'padding': 'EdgeInsets.all(8)',
          },
          accentColor: Colors.indigo,
        ),

        buildThemeDataPropertyCard(
          title: 'Custom Theme B',
          properties: {
            'color': 'Colors.teal.shade50',
            'elevation': '0.0',
            'shape': 'null (flat)',
            'height': '72.0',
            'surfaceTintColor': 'transparent',
            'shadowColor': 'transparent',
            'padding': 'EdgeInsets.symmetric(h:16)',
          },
          accentColor: Colors.teal,
        ),

        // Section 2: Color Variations
        buildSectionTitle('2. Color Variations'),
        buildDescription('BottomAppBar with different background colors'),

        buildBottomAppBarDemo(
          title: 'White Background',
          description: 'Clean white bottom bar with dark icons',
          barColor: Colors.white,
          elevation: 4,
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.favorite,
            Icons.person,
          ], Colors.grey.shade700),
        ),
        buildBottomAppBarDemo(
          title: 'Indigo Background',
          description: 'Vibrant indigo bar with white icons',
          barColor: Colors.indigo,
          elevation: 4,
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.favorite,
            Icons.person,
          ], Colors.white),
        ),
        buildBottomAppBarDemo(
          title: 'Amber Background',
          description: 'Warm amber bar with dark icons',
          barColor: Colors.amber,
          elevation: 4,
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.favorite,
            Icons.person,
          ], Colors.brown.shade800),
        ),
        buildBottomAppBarDemo(
          title: 'Dark Grey Background',
          description: 'Dark theme style bar',
          barColor: Colors.grey.shade900,
          elevation: 6,
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.favorite,
            Icons.person,
          ], Colors.white70),
        ),
        buildBottomAppBarDemo(
          title: 'Teal Background',
          description: 'Teal colored bar with light icons',
          barColor: Colors.teal,
          elevation: 4,
          child: buildIconRow([
            Icons.dashboard,
            Icons.analytics,
            Icons.settings,
            Icons.notifications,
          ], Colors.white),
        ),

        // Section 3: Elevation Variations
        buildSectionTitle('3. Elevation Variations'),
        buildDescription('Same BottomAppBar with different elevation levels'),

        buildBottomAppBarDemo(
          title: 'Elevation: 0 (Flat)',
          description: 'No shadow, flat appearance',
          barColor: Colors.blue.shade50,
          elevation: 0,
          child: buildIconRow([
            Icons.home,
            Icons.menu,
            Icons.search,
          ], Colors.blue.shade700),
        ),
        buildBottomAppBarDemo(
          title: 'Elevation: 4',
          description: 'Subtle shadow',
          barColor: Colors.blue.shade50,
          elevation: 4,
          child: buildIconRow([
            Icons.home,
            Icons.menu,
            Icons.search,
          ], Colors.blue.shade700),
        ),
        buildBottomAppBarDemo(
          title: 'Elevation: 8',
          description: 'Medium shadow (default)',
          barColor: Colors.blue.shade50,
          elevation: 8,
          child: buildIconRow([
            Icons.home,
            Icons.menu,
            Icons.search,
          ], Colors.blue.shade700),
        ),
        buildBottomAppBarDemo(
          title: 'Elevation: 16',
          description: 'Prominent shadow',
          barColor: Colors.blue.shade50,
          elevation: 16,
          child: buildIconRow([
            Icons.home,
            Icons.menu,
            Icons.search,
          ], Colors.blue.shade700),
        ),

        // Section 4: With Notch Shape
        buildSectionTitle('4. Notch Shape (CircularNotchedRectangle)'),
        buildDescription('BottomAppBar with FAB dock notch'),

        buildBottomAppBarDemo(
          title: 'Notched - Default Margin',
          description: 'CircularNotchedRectangle with 4px notch margin',
          barColor: Colors.deepPurple,
          elevation: 8,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          showFab: true,
          fabColor: Colors.pinkAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {},
              ),
              SizedBox(width: 48),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        buildBottomAppBarDemo(
          title: 'Notched - Large Margin (8px)',
          description: 'Wider gap around the FAB notch',
          barColor: Colors.green.shade700,
          elevation: 8,
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          showFab: true,
          fabColor: Colors.yellowAccent.shade700,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              SizedBox(width: 48),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        buildBottomAppBarDemo(
          title: 'No Notch Shape',
          description: 'BottomAppBar without any notch',
          barColor: Colors.orange.shade700,
          elevation: 8,
          showFab: true,
          fabColor: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              SizedBox(width: 48),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Section 5: Padding Variations
        buildSectionTitle('5. Padding Variations'),
        buildDescription('BottomAppBar with different internal padding'),

        buildBottomAppBarDemo(
          title: 'No Padding',
          description: 'Zero internal padding',
          barColor: Colors.grey.shade200,
          elevation: 2,
          padding: EdgeInsets.zero,
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.settings,
          ], Colors.grey.shade800),
        ),
        buildBottomAppBarDemo(
          title: 'Symmetric Horizontal Padding (24px)',
          description: 'Generous horizontal padding',
          barColor: Colors.grey.shade200,
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.settings,
          ], Colors.grey.shade800),
        ),
        buildBottomAppBarDemo(
          title: 'All-around Padding (16px)',
          description: 'Equal padding on all sides',
          barColor: Colors.grey.shade200,
          elevation: 2,
          padding: EdgeInsets.all(16),
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.settings,
          ], Colors.grey.shade800),
        ),

        // Section 6: Child Content Arrangements
        buildSectionTitle('6. Child Content Arrangements'),
        buildDescription('Different content layouts within BottomAppBar'),

        buildBottomAppBarDemo(
          title: 'Icons Only',
          description: 'Simple icon buttons layout',
          barColor: Colors.blueGrey,
          elevation: 4,
          child: buildIconRow([
            Icons.home,
            Icons.search,
            Icons.add_circle,
            Icons.notifications,
            Icons.person,
          ], Colors.white),
        ),
        buildBottomAppBarDemo(
          title: 'Icons with Labels',
          description: 'Icon and text combination layout',
          barColor: Colors.indigo.shade800,
          elevation: 4,
          child: buildIconTextRow([
            {'icon': Icons.home, 'label': 'Home'},
            {'icon': Icons.search, 'label': 'Search'},
            {'icon': Icons.add, 'label': 'Add'},
            {'icon': Icons.person, 'label': 'Profile'},
          ], Colors.white),
        ),
        buildBottomAppBarDemo(
          title: 'Mixed Content',
          description: 'Text and action combination',
          barColor: Colors.white,
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  '4 items selected',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),

        // Section 7: Theme Applied via Theme widget
        buildSectionTitle('7. BottomAppBarTheme in Action'),
        buildDescription(
          'BottomAppBarTheme inherited widget applying theme data',
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Theme-Applied BottomAppBar',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              Container(
                height: 64,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Theme(
                  data: ThemeData(
                    bottomAppBarTheme: BottomAppBarThemeData(
                      color: Colors.deepOrange,
                      elevation: 10,
                      shape: CircularNotchedRectangle(),
                    ),
                  ),
                  child: BottomAppBar(
                    child: buildIconRow([
                      Icons.home,
                      Icons.explore,
                      Icons.bookmark,
                      Icons.settings,
                    ], Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),

        // Section 8: Summary
        buildSectionTitle('8. Summary'),
        buildInfoBox(
          'BottomAppBarThemeData defines default visual properties for BottomAppBar widgets. '
          'It includes color, elevation, shape, height, surfaceTintColor, shadowColor, and padding.',
          Colors.brown,
        ),
        buildInfoBox(
          'The CircularNotchedRectangle shape creates a notch for a FloatingActionButton. '
          'The notchMargin controls the space between the FAB and the notch edge.',
          Colors.deepPurple,
        ),
        buildInfoBox(
          'BottomAppBarTheme is an InheritedWidget that provides BottomAppBarThemeData to descendants.',
          Colors.teal,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
