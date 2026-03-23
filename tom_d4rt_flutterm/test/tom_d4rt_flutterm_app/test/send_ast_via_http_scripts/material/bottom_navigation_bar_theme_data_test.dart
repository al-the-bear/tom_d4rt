// ignore_for_file: avoid_print
// D4rt test script: Tests BottomNavigationBarThemeData from material
import 'package:flutter/material.dart';

// Helper to build a section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade800,
      ),
    ),
  );
}

// Helper to build description text
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

// Helper to build an info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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

// Helper to build a bottom navigation bar demo card
Widget buildNavBarDemo({
  required String title,
  required String description,
  required BottomNavigationBarType type,
  required Color backgroundColor,
  required Color selectedItemColor,
  required Color unselectedItemColor,
  double selectedFontSize = 14.0,
  double unselectedFontSize = 12.0,
  double iconSize = 24.0,
  bool showUnselectedLabels = true,
  bool showSelectedLabels = true,
  int currentIndex = 0,
  double elevation = 8.0,
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
          padding: EdgeInsets.fromLTRB(16, 12, 16, 2),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.indigo.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              _buildMiniChip('Type', type == BottomNavigationBarType.fixed ? 'fixed' : 'shifting', Colors.blue),
              _buildMiniChip('Icon Size', iconSize.toStringAsFixed(0), Colors.green),
              _buildMiniChip('Sel Font', selectedFontSize.toStringAsFixed(0), Colors.orange),
              _buildMiniChip('Elevation', elevation.toStringAsFixed(0), Colors.purple),
            ],
          ),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BottomNavigationBar(
            type: type,
            backgroundColor: backgroundColor,
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            selectedFontSize: selectedFontSize,
            unselectedFontSize: unselectedFontSize,
            iconSize: iconSize,
            showUnselectedLabels: showUnselectedLabels,
            showSelectedLabels: showSelectedLabels,
            currentIndex: currentIndex,
            elevation: elevation,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (i) {},
          ),
        ),
        SizedBox(height: 12),
      ],
    ),
  );
}

// Mini chip for property display
Widget _buildMiniChip(String key, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Text(
      '$key: $value',
      style: TextStyle(fontSize: 10, color: color),
    ),
  );
}

// Helper to build theme data property card
Widget buildThemeDataCard({
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
      border: Border.all(color: accentColor.withAlpha(50)),
      boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 4, offset: Offset(0, 2)),
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
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    entry.key,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey.shade700),
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

// Build a selected vs unselected comparison
Widget buildSelectionComparison({
  required String title,
  required Color selectedColor,
  required Color unselectedColor,
  required double selectedIconSize,
  required double unselectedIconSize,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Selected', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  SizedBox(height: 8),
                  Icon(Icons.home, color: selectedColor, size: selectedIconSize),
                  SizedBox(height: 4),
                  Text('Home', style: TextStyle(fontSize: 12, color: selectedColor, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Container(width: 1, height: 60, color: Colors.grey.shade200),
            Expanded(
              child: Column(
                children: [
                  Text('Unselected', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  SizedBox(height: 8),
                  Icon(Icons.search, color: unselectedColor, size: unselectedIconSize),
                  SizedBox(height: 4),
                  Text('Search', style: TextStyle(fontSize: 12, color: unselectedColor)),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== BottomNavigationBarThemeData Deep Demo ===');
  debugPrint('Demonstrating BottomNavigationBar visual variations');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade700, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BottomNavigationBar Theme Data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Visual variations: types, colors, icon sizes, label styles',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Theme Data Properties
        buildSectionTitle('1. BottomNavigationBarThemeData Properties'),
        buildDescription('All configurable properties of the theme data'),

        buildThemeDataCard(
          title: 'Available Properties',
          properties: {
            'backgroundColor': 'Background color of the bar',
            'elevation': 'Shadow elevation',
            'selectedIconTheme': 'IconThemeData for selected icon',
            'unselectedIconTheme': 'IconThemeData for unselected icon',
            'selectedItemColor': 'Color of selected item',
            'unselectedItemColor': 'Color of unselected item',
            'selectedLabelStyle': 'TextStyle for selected label',
            'unselectedLabelStyle': 'TextStyle for unselected label',
            'showSelectedLabels': 'Show/hide selected labels',
            'showUnselectedLabels': 'Show/hide unselected labels',
            'type': 'fixed or shifting',
            'enableFeedback': 'Haptic feedback on tap',
          },
          accentColor: Colors.indigo,
        ),

        // Section 2: Fixed Type Variations
        buildSectionTitle('2. Fixed Type Navigation Bars'),
        buildDescription('BottomNavigationBarType.fixed - all items visible equally'),

        buildNavBarDemo(
          title: 'Fixed - Default Light',
          description: 'White background, blue selected, grey unselected',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
        ),
        buildNavBarDemo(
          title: 'Fixed - Dark Theme',
          description: 'Dark background with light icons',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade900,
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.grey.shade500,
          currentIndex: 1,
        ),
        buildNavBarDemo(
          title: 'Fixed - Colorful',
          description: 'Indigo background with warm selection color',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.indigo,
          selectedItemColor: Colors.amberAccent,
          unselectedItemColor: Colors.indigo.shade200,
          currentIndex: 2,
        ),
        buildNavBarDemo(
          title: 'Fixed - Teal Theme',
          description: 'Teal colored bar with white highlights',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal.shade700,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.teal.shade200,
          currentIndex: 3,
        ),

        // Section 3: Shifting Type Variations
        buildSectionTitle('3. Shifting Type Navigation Bars'),
        buildDescription('BottomNavigationBarType.shifting - selected item expands'),

        buildNavBarDemo(
          title: 'Shifting - Blue/White',
          description: 'Shifting with blue background',
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: 0,
        ),
        buildNavBarDemo(
          title: 'Shifting - Red/Light',
          description: 'Shifting with red background',
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.red.shade600,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.red.shade100,
          currentIndex: 1,
        ),
        buildNavBarDemo(
          title: 'Shifting - Green',
          description: 'Shifting with green background',
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.green.shade700,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.green.shade200,
          currentIndex: 2,
        ),

        // Section 4: Icon Size Variations
        buildSectionTitle('4. Icon Size Variations'),
        buildDescription('Different icon sizes for the navigation items'),

        buildNavBarDemo(
          title: 'Small Icons (18px)',
          description: 'Compact appearance',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          iconSize: 18,
          currentIndex: 0,
        ),
        buildNavBarDemo(
          title: 'Default Icons (24px)',
          description: 'Standard icon size',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          iconSize: 24,
          currentIndex: 1,
        ),
        buildNavBarDemo(
          title: 'Large Icons (32px)',
          description: 'Larger, more prominent icons',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          iconSize: 32,
          currentIndex: 2,
        ),

        // Section 5: Font Size Variations
        buildSectionTitle('5. Label Font Size Variations'),
        buildDescription('Different selected and unselected font sizes'),

        buildNavBarDemo(
          title: 'Small Labels (10/8)',
          description: 'Small selected and unselected labels',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10,
          unselectedFontSize: 8,
          currentIndex: 0,
        ),
        buildNavBarDemo(
          title: 'Default Labels (14/12)',
          description: 'Standard label sizes',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          currentIndex: 1,
        ),
        buildNavBarDemo(
          title: 'Large Labels (18/14)',
          description: 'Larger label sizes for emphasis',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 18,
          unselectedFontSize: 14,
          currentIndex: 2,
        ),

        // Section 6: Label Visibility
        buildSectionTitle('6. Label Visibility Options'),
        buildDescription('Show/hide labels for selected and unselected items'),

        buildNavBarDemo(
          title: 'All Labels Visible',
          description: 'Both selected and unselected labels shown',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: 0,
        ),
        buildNavBarDemo(
          title: 'Selected Labels Only',
          description: 'Only selected item label shown',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: 1,
        ),
        buildNavBarDemo(
          title: 'No Labels',
          description: 'All labels hidden, icons only',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 2,
        ),

        // Section 7: Selected vs Unselected Comparison
        buildSectionTitle('7. Selected vs Unselected Comparison'),
        buildDescription('Side-by-side comparison of selected and unselected states'),

        buildSelectionComparison(
          title: 'Blue / Grey',
          selectedColor: Colors.blue,
          unselectedColor: Colors.grey,
          selectedIconSize: 28,
          unselectedIconSize: 24,
        ),
        buildSelectionComparison(
          title: 'Red / Light Grey',
          selectedColor: Colors.red,
          unselectedColor: Colors.grey.shade400,
          selectedIconSize: 30,
          unselectedIconSize: 22,
        ),
        buildSelectionComparison(
          title: 'Deep Purple / Brown',
          selectedColor: Colors.deepPurple,
          unselectedColor: Colors.brown.shade300,
          selectedIconSize: 32,
          unselectedIconSize: 24,
        ),

        // Section 8: Different Index Selected
        buildSectionTitle('8. Different Selected Index'),
        buildDescription('Same bar with different items selected'),

        buildNavBarDemo(
          title: 'First Item Selected (index 0)',
          description: 'Home is active',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey.shade50,
          selectedItemColor: Colors.blueGrey.shade800,
          unselectedItemColor: Colors.blueGrey.shade300,
          currentIndex: 0,
        ),
        buildNavBarDemo(
          title: 'Second Item Selected (index 1)',
          description: 'Search is active',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey.shade50,
          selectedItemColor: Colors.blueGrey.shade800,
          unselectedItemColor: Colors.blueGrey.shade300,
          currentIndex: 1,
        ),
        buildNavBarDemo(
          title: 'Third Item Selected (index 2)',
          description: 'Favorites is active',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey.shade50,
          selectedItemColor: Colors.blueGrey.shade800,
          unselectedItemColor: Colors.blueGrey.shade300,
          currentIndex: 2,
        ),
        buildNavBarDemo(
          title: 'Fourth Item Selected (index 3)',
          description: 'Profile is active',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey.shade50,
          selectedItemColor: Colors.blueGrey.shade800,
          unselectedItemColor: Colors.blueGrey.shade300,
          currentIndex: 3,
        ),

        // Section 9: Elevation Differences
        buildSectionTitle('9. Elevation Variations'),
        buildDescription('Visual impact of elevation on the navigation bar'),

        buildNavBarDemo(
          title: 'Elevation 0 (Flat)',
          description: 'No shadow at all',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lime.shade50,
          selectedItemColor: Colors.lime.shade900,
          unselectedItemColor: Colors.lime.shade400,
          elevation: 0,
          currentIndex: 0,
        ),
        buildNavBarDemo(
          title: 'Elevation 8 (Default)',
          description: 'Standard shadow level',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lime.shade50,
          selectedItemColor: Colors.lime.shade900,
          unselectedItemColor: Colors.lime.shade400,
          elevation: 8,
          currentIndex: 1,
        ),
        buildNavBarDemo(
          title: 'Elevation 16 (High)',
          description: 'Prominent shadow',
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lime.shade50,
          selectedItemColor: Colors.lime.shade900,
          unselectedItemColor: Colors.lime.shade400,
          elevation: 16,
          currentIndex: 2,
        ),

        // Section 10: Summary
        buildSectionTitle('10. Summary'),
        buildInfoBox(
          'BottomNavigationBarThemeData controls all visual aspects of BottomNavigationBar.',
          Colors.indigo,
        ),
        buildInfoBox(
          'Fixed type shows all items equally; shifting type emphasizes the selected item.',
          Colors.blue,
        ),
        buildInfoBox(
          'Icon sizes, font sizes, and colors can be independently controlled for selected and unselected states.',
          Colors.green,
        ),
        buildInfoBox(
          'Label visibility can be toggled independently for selected and unselected items.',
          Colors.orange,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
