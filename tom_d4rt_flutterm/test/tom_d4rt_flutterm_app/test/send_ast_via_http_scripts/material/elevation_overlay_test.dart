// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ElevationOverlay from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  debugPrint('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

Widget _buildInfoCard(String label, String value) {
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
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(width: 8),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        ),
      ],
    ),
  );
}

Widget _buildElevationCard(double elevation, Color surfaceColor, Color tintColor, String label) {
  Color tintedColor = ElevationOverlay.applySurfaceTint(surfaceColor, tintColor, elevation);
  debugPrint('Elevation $elevation: tinted color applied');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: tintedColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: elevation,
                offset: Offset(0, elevation / 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '${elevation.toInt()}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade800)),
              SizedBox(height: 2),
              Text('elevation: $elevation dp',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 14, height: 14,
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text('base', style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 12, color: Colors.grey.shade400),
                  SizedBox(width: 8),
                  Container(
                    width: 14, height: 14,
                    decoration: BoxDecoration(
                      color: tintedColor,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text('tinted', style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDarkThemeElevation() {
  debugPrint('Building dark theme elevation cards');
  Color darkSurface = Color(0xFF121212);
  Color tintColor = Colors.purple.shade200;

  List<double> elevations = [0, 1, 2, 3, 4, 6, 8, 12, 16, 24];
  List<String> labels = [
    'Flat surface', 'Default elevation', 'Card/raised button',
    'Snackbar', 'App bar', 'FAB / Snackbar resting',
    'Bottom sheet / Menu', 'Floating action button',
    'Nav drawer / Modal bottom sheet', 'Dialog',
  ];

  List<Widget> cards = [];
  for (int i = 0; i < elevations.length; i = i + 1) {
    cards.add(_buildElevationCard(elevations[i], darkSurface, tintColor, labels[i]));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade700),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dark_mode, color: Colors.purple.shade200, size: 24),
            SizedBox(width: 8),
            Text('Dark Theme Elevation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple.shade200)),
          ],
        ),
        SizedBox(height: 4),
        Text('Surface tint applied with ElevationOverlay.applySurfaceTint',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        SizedBox(height: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards),
      ],
    ),
  );
}

Widget _buildLightThemeElevation() {
  debugPrint('Building light theme elevation cards');
  Color lightSurface = Color(0xFFFAFAFA);
  Color tintColor = Colors.blue.shade600;

  List<double> elevations = [0, 1, 2, 3, 4, 6, 8, 12, 16, 24];
  List<String> labels = [
    'Flat surface', 'Default elevation', 'Card/raised button',
    'Snackbar', 'App bar', 'FAB / Snackbar resting',
    'Bottom sheet / Menu', 'Floating action button',
    'Nav drawer / Modal bottom sheet', 'Dialog',
  ];

  List<Widget> cards = [];
  for (int i = 0; i < elevations.length; i = i + 1) {
    cards.add(_buildElevationCard(elevations[i], lightSurface, tintColor, labels[i]));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.light_mode, color: Colors.blue.shade600, size: 24),
            SizedBox(width: 8),
            Text('Light Theme Elevation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
          ],
        ),
        SizedBox(height: 4),
        Text('Surface tint applied with ElevationOverlay.applySurfaceTint',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        SizedBox(height: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards),
      ],
    ),
  );
}

Widget _buildColorTintComparison() {
  debugPrint('Building color tint comparison');
  Color baseSurface = Color(0xFF1E1E1E);
  List<String> tintNames = ['Purple', 'Blue', 'Green', 'Orange', 'Red', 'Teal'];
  List<Color> tintColors = [
    Colors.purple.shade200, Colors.blue.shade200, Colors.green.shade200,
    Colors.orange.shade200, Colors.red.shade200, Colors.teal.shade200,
  ];

  double targetElevation = 8.0;
  List<Widget> rows = [];
  for (int i = 0; i < tintNames.length; i = i + 1) {
    Color tinted = ElevationOverlay.applySurfaceTint(baseSurface, tintColors[i], targetElevation);
    rows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: tinted,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 18, height: 18,
              decoration: BoxDecoration(
                color: tintColors[i],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
            SizedBox(width: 10),
            Text(tintNames[i],
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
            SizedBox(width: 8),
            Text('tint at elevation $targetElevation',
              style: TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF121212),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade700),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Different Tint Colors at Elevation 8',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 4),
        Text('Same surface, different surfaceTintColor values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        SizedBox(height: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
      ],
    ),
  );
}

Widget _buildElevationStaircase() {
  debugPrint('Building elevation staircase');
  Color surface = Color(0xFF1E1E2E);
  Color tint = Colors.indigo.shade200;
  List<double> steps = [0, 2, 4, 6, 8, 12, 16, 24];

  List<Widget> stairWidgets = [];
  for (int i = 0; i < steps.length; i = i + 1) {
    Color tinted = ElevationOverlay.applySurfaceTint(surface, tint, steps[i]);
    double width = 40.0 + (i * 25.0);
    stairWidgets.add(
      Container(
        width: width,
        height: 32,
        margin: EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: tinted,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
        alignment: Alignment.center,
        child: Text('${steps[i].toInt()}',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF0E0E1A),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade800),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Elevation Staircase',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo.shade200)),
        SizedBox(height: 4),
        Text('Wider and lighter bars represent higher elevation',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        SizedBox(height: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: stairWidgets),
      ],
    ),
  );
}

Widget _buildMaterialCards() {
  debugPrint('Building material cards at different elevations');
  Color surface = Color(0xFF1A1A2E);
  Color tint = Colors.deepPurple.shade200;
  List<double> elevations = [0, 1, 3, 6, 8, 12];
  List<String> descriptions = [
    'No elevation - flat',
    'Subtle rise - low emphasis',
    'Card level - standard content',
    'Sheet level - overlays',
    'Prominent - actions',
    'High - dialogs and popups',
  ];

  List<Widget> cards = [];
  for (int i = 0; i < elevations.length; i = i + 1) {
    Color tinted = ElevationOverlay.applySurfaceTint(surface, tint, elevations[i]);
    cards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tinted,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: elevations[i] * 1.5,
              offset: Offset(0, elevations[i] / 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Elevation ${elevations[i].toInt()}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                Expanded(child: SizedBox()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('dp: ${elevations[i].toInt()}',
                    style: TextStyle(fontSize: 10, color: Colors.white70)),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(descriptions[i],
              style: TextStyle(fontSize: 12, color: Colors.white60)),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF0D0D1F),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade800),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Material Cards at Different Elevations',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade200)),
        SizedBox(height: 4),
        Text('Cards show shadow + tint at increasing elevations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        SizedBox(height: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: cards),
      ],
    ),
  );
}

Widget _buildNullTintBehavior() {
  debugPrint('Building null tint behavior');
  Color surface = Color(0xFF2A2A2A);
  Color tintedWithNull = ElevationOverlay.applySurfaceTint(surface, Color(0x00000000), 8.0);
  Color tintedWithColor = ElevationOverlay.applySurfaceTint(surface, Colors.cyan.shade200, 8.0);

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade700),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tint Color Behavior',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: tintedWithNull,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade600),
                ),
                alignment: Alignment.center,
                child: Text('Transparent tint', style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: tintedWithColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.cyan.shade400),
                ),
                alignment: Alignment.center,
                child: Text('Cyan tint', style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text('With transparent tint, surface remains unchanged. With a color tint, surface is tinted.',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
      ],
    ),
  );
}

Widget _buildPropertiesSummary() {
  debugPrint('Building properties summary');
  List<String> methods = ['applySurfaceTint'];
  List<String> methodDescs = ['Applies a surface tint color to a surface color based on the given elevation'];
  List<String> params = ['surfaceColor: Color, surfaceTintColor: Color, elevation: double'];

  List<Widget> items = [];
  for (int i = 0; i < methods.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(methods[i],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueGrey.shade800)),
            SizedBox(height: 4),
            Text(methodDescs[i],
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            SizedBox(height: 4),
            Text('Params: ${params[i]}',
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey.shade500)),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}

dynamic build(BuildContext context) {
  print('ElevationOverlay deep demo test executing');
  debugPrint('=== ElevationOverlay Visual Demo ===');
  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ElevationOverlay Deep Demo'),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Dark Theme Elevation'),
            _buildDarkThemeElevation(),
            SizedBox(height: 16),
            _buildSectionHeader('2. Light Theme Elevation'),
            _buildLightThemeElevation(),
            SizedBox(height: 16),
            _buildSectionHeader('3. Different Tint Colors'),
            _buildColorTintComparison(),
            SizedBox(height: 16),
            _buildSectionHeader('4. Elevation Staircase'),
            _buildElevationStaircase(),
            SizedBox(height: 16),
            _buildSectionHeader('5. Material Cards'),
            _buildMaterialCards(),
            SizedBox(height: 16),
            _buildSectionHeader('6. Tint Behavior'),
            _buildNullTintBehavior(),
            SizedBox(height: 16),
            _buildSectionHeader('7. API Reference'),
            _buildPropertiesSummary(),
            SizedBox(height: 32),
            _buildInfoCard('Class', 'ElevationOverlay'),
            _buildInfoCard('Package', 'package:flutter/material.dart'),
            _buildInfoCard('Purpose', 'Applies surface tint to material surfaces based on elevation'),
            _buildInfoCard('Key Method', 'applySurfaceTint(surfaceColor, tintColor, elevation)'),
            _buildInfoCard('Usage', 'Material 3 tonal elevation system for dark and light themes'),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
  print('ElevationOverlay deep demo completed');
  return result;
}
