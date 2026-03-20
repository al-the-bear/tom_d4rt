// D4rt test script: Tests core Material widget classes from material
import 'package:flutter/material.dart';

// Helper for section header
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

// Helper for class info card
Widget buildClassInfoCard(String className, String description, Color color, IconData icon, List<String> properties) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(className, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)),
                  Text(description, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: properties.map((p) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(p, style: TextStyle(fontSize: 10, color: color)),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Helper for Material widget elevation demo
Widget buildMaterialElevationDemo(double elevation, Color color, MaterialType type, String label) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Material(
            elevation: elevation,
            color: color,
            type: type,
            borderRadius: type == MaterialType.card ? BorderRadius.circular(8) : null,
            child: SizedBox(
              height: 60,
              child: Center(
                child: Text('${elevation.toInt()}',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
    ),
  );
}

// Helper for Material type showcase
Widget buildMaterialTypeShowcase(String typeName, MaterialType type, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(typeName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Material(
            type: type,
            elevation: 3,
            color: color,
            borderRadius: type == MaterialType.card ? BorderRadius.circular(8) : null,
            child: Container(
              height: 50,
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text('Material($typeName)', style: TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper for Scaffold region visualization
Widget buildScaffoldRegion(String label, Color color, double height, IconData icon) {
  return Container(
    height: height,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 6),
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    ),
  );
}

// Helper for InkWell visual effect
Widget buildInkWellVisual(String label, Color splashColor, Color highlightColor,
    Color hoverColor, double borderRadius, Color backgroundColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    child: Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: splashColor,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Spacer(),
              Container(
                width: 16, height: 16,
                decoration: BoxDecoration(color: splashColor, borderRadius: BorderRadius.circular(4)),
              ),
              SizedBox(width: 4),
              Container(
                width: 16, height: 16,
                decoration: BoxDecoration(color: highlightColor, borderRadius: BorderRadius.circular(4)),
              ),
              SizedBox(width: 4),
              Text('r:${borderRadius.toInt()}', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ),
    ),
  );
}

// Helper for color scheme demo
Widget buildColorSchemeDemo(String name, Color primary, Color secondary, Color surface, Color background) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(4)),
                child: Center(child: Text('primary', style: TextStyle(fontSize: 9, color: Colors.white))),
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(color: secondary, borderRadius: BorderRadius.circular(4)),
                child: Center(child: Text('secondary', style: TextStyle(fontSize: 9, color: Colors.white))),
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(4)),
                child: Center(child: Text('surface', style: TextStyle(fontSize: 9, color: Colors.grey))),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper for hierarchy visualization
Widget buildHierarchyRow(int depth, String label, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
    padding: EdgeInsets.only(left: depth * 20.0, top: 6, bottom: 6, right: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(4),
      border: Border(left: BorderSide(color: color, width: 2)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== Core Material Classes Visual Test ===');
  debugPrint('Demonstrating MaterialApp, Scaffold, Material, InkWell');

  debugPrint('Testing Material widget properties');
  debugPrint('Testing Scaffold regions');
  debugPrint('Testing InkWell splash effects');
  debugPrint('Testing MaterialApp theme configuration');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Core Material Classes Demo'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Class Overview
            buildSectionHeader('Core Material Classes', Icons.widgets, Colors.blue.shade800),
            buildClassInfoCard('MaterialApp', 'Root widget providing Material Design', Colors.blue,
                Icons.apps, ['theme', 'darkTheme', 'home', 'routes', 'debugShowCheckedModeBanner']),
            buildClassInfoCard('Scaffold', 'Visual layout structure for Material pages', Colors.green,
                Icons.dashboard, ['appBar', 'body', 'drawer', 'floatingActionButton', 'bottomNavigationBar']),
            buildClassInfoCard('Material', 'Base widget for Material Design surfaces', Colors.orange,
                Icons.layers, ['elevation', 'color', 'type', 'borderRadius', 'shadowColor']),
            buildClassInfoCard('InkWell', 'Rectangular area responding to touch with ripple', Colors.purple,
                Icons.touch_app, ['splashColor', 'highlightColor', 'hoverColor', 'borderRadius', 'onTap']),

            // Section 2: Material Widget - Elevation
            buildSectionHeader('Material Elevation', Icons.layers, Colors.orange),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Material surfaces cast shadows based on their elevation',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  buildMaterialElevationDemo(0, Colors.blue, MaterialType.card, 'e:0'),
                  buildMaterialElevationDemo(2, Colors.blue, MaterialType.card, 'e:2'),
                  buildMaterialElevationDemo(4, Colors.blue, MaterialType.card, 'e:4'),
                  buildMaterialElevationDemo(8, Colors.blue, MaterialType.card, 'e:8'),
                  buildMaterialElevationDemo(16, Colors.blue, MaterialType.card, 'e:16'),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  buildMaterialElevationDemo(0, Colors.green, MaterialType.card, 'green'),
                  buildMaterialElevationDemo(4, Colors.orange, MaterialType.card, 'orange'),
                  buildMaterialElevationDemo(8, Colors.purple, MaterialType.card, 'purple'),
                  buildMaterialElevationDemo(12, Colors.red, MaterialType.card, 'red'),
                  buildMaterialElevationDemo(20, Colors.teal, MaterialType.card, 'teal'),
                ],
              ),
            ),

            // Section 3: Material Types
            buildSectionHeader('Material Types', Icons.category, Colors.teal),
            buildMaterialTypeShowcase('card', MaterialType.card, Colors.blue),
            buildMaterialTypeShowcase('canvas', MaterialType.canvas, Colors.green),
            buildMaterialTypeShowcase('circle', MaterialType.circle, Colors.orange),
            buildMaterialTypeShowcase('button', MaterialType.button, Colors.purple),
            buildMaterialTypeShowcase('transparency', MaterialType.transparency, Colors.grey),

            // Section 4: Scaffold Layout Regions
            buildSectionHeader('Scaffold Structure', Icons.dashboard, Colors.green),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Scaffold provides a standard layout with named regions',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildScaffoldRegion('AppBar', Colors.blue, 45, Icons.horizontal_rule),
            buildScaffoldRegion('Body (main content)', Colors.green, 120, Icons.article),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.fromLTRB(8, 2, 2, 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.orange, width: 1.5),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu, color: Colors.orange, size: 16),
                          Text('Drawer', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.green.shade200, width: 1),
                    ),
                    child: Center(child: Text('Body Content Area', style: TextStyle(fontSize: 11, color: Colors.grey))),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.fromLTRB(2, 2, 8, 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.purple, width: 1.5),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_open, color: Colors.purple, size: 16),
                          Text('End Drawer', style: TextStyle(color: Colors.purple, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            buildScaffoldRegion('BottomNavigationBar', Colors.indigo, 45, Icons.navigation),
            Container(
              margin: EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 1.5),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.red, size: 18),
                          Text('FAB', style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section 5: InkWell Splash Configurations
            buildSectionHeader('InkWell Splash Effects', Icons.touch_app, Colors.purple),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'InkWell creates ripple effects on touch with customizable colors and shapes',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildInkWellVisual('Blue splash on white', Colors.blue.withValues(alpha: 0.3),
                Colors.blue.withValues(alpha: 0.1), Colors.blue.withValues(alpha: 0.05), 8, Colors.white),
            buildInkWellVisual('Green splash on mint', Colors.green.withValues(alpha: 0.4),
                Colors.green.withValues(alpha: 0.15), Colors.green.withValues(alpha: 0.05), 8, Colors.green.shade50),
            buildInkWellVisual('Red splash on pink', Colors.red.withValues(alpha: 0.3),
                Colors.red.withValues(alpha: 0.1), Colors.red.withValues(alpha: 0.05), 8, Colors.red.shade50),
            buildInkWellVisual('Purple splash, high radius', Colors.purple.withValues(alpha: 0.3),
                Colors.purple.withValues(alpha: 0.1), Colors.purple.withValues(alpha: 0.05), 20, Colors.purple.shade50),
            buildInkWellVisual('Orange splash, no radius', Colors.orange.withValues(alpha: 0.4),
                Colors.orange.withValues(alpha: 0.15), Colors.orange.withValues(alpha: 0.05), 0, Colors.orange.shade50),
            buildInkWellVisual('Teal splash on grey', Colors.teal.withValues(alpha: 0.3),
                Colors.teal.withValues(alpha: 0.1), Colors.teal.withValues(alpha: 0.05), 12, Colors.grey.shade100),

            // Section 6: MaterialApp Theme Colors
            buildSectionHeader('MaterialApp Themes', Icons.palette, Colors.indigo),
            buildColorSchemeDemo('Blue Theme', Colors.blue, Colors.blueAccent, Colors.white, Colors.blue.shade50),
            buildColorSchemeDemo('Green Theme', Colors.green, Colors.greenAccent, Colors.white, Colors.green.shade50),
            buildColorSchemeDemo('Purple Theme', Colors.purple, Colors.purpleAccent, Colors.white, Colors.purple.shade50),
            buildColorSchemeDemo('Dark Theme', Colors.grey.shade800, Colors.tealAccent, Colors.grey.shade900, Colors.grey.shade800),
            buildColorSchemeDemo('Warm Theme', Colors.deepOrange, Colors.amber, Colors.white, Colors.orange.shade50),
            buildColorSchemeDemo('Cool Theme', Colors.cyan, Colors.lightBlue, Colors.white, Colors.cyan.shade50),

            // Section 7: Widget Hierarchy
            buildSectionHeader('Widget Hierarchy', Icons.account_tree, Colors.brown),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Typical nesting of core Material classes in a widget tree',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildHierarchyRow(0, 'MaterialApp', Colors.blue, Icons.apps),
            buildHierarchyRow(1, 'Theme', Colors.purple, Icons.palette),
            buildHierarchyRow(2, 'Scaffold', Colors.green, Icons.dashboard),
            buildHierarchyRow(3, 'AppBar', Colors.blue.shade600, Icons.horizontal_rule),
            buildHierarchyRow(3, 'Body: Material', Colors.orange, Icons.layers),
            buildHierarchyRow(4, 'InkWell', Colors.red, Icons.touch_app),
            buildHierarchyRow(5, 'Container', Colors.teal, Icons.crop_square),
            buildHierarchyRow(6, 'Text/Icon', Colors.grey, Icons.text_fields),
            buildHierarchyRow(3, 'FloatingActionButton', Colors.pink, Icons.add_circle),
            buildHierarchyRow(3, 'BottomNavigationBar', Colors.indigo, Icons.navigation),

            // Section 8: Surface Tint and Color Overlay
            buildSectionHeader('Surface Colors', Icons.format_paint, Colors.cyan),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Surface tinting at different elevations', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('Level 0', style: TextStyle(fontSize: 10))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('Level 1', style: TextStyle(fontSize: 10))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('Level 2', style: TextStyle(fontSize: 10))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('Level 3', style: TextStyle(fontSize: 10, color: Colors.white))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('Level 4', style: TextStyle(fontSize: 10, color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.green.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Classes Demonstrated:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(label: Text('MaterialApp', style: TextStyle(fontSize: 10)), backgroundColor: Colors.blue.shade100),
                      Chip(label: Text('Scaffold', style: TextStyle(fontSize: 10)), backgroundColor: Colors.green.shade100),
                      Chip(label: Text('Material', style: TextStyle(fontSize: 10)), backgroundColor: Colors.orange.shade100),
                      Chip(label: Text('InkWell', style: TextStyle(fontSize: 10)), backgroundColor: Colors.purple.shade100),
                      Chip(label: Text('Theme', style: TextStyle(fontSize: 10)), backgroundColor: Colors.indigo.shade100),
                      Chip(label: Text('ColorScheme', style: TextStyle(fontSize: 10)), backgroundColor: Colors.cyan.shade100),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
