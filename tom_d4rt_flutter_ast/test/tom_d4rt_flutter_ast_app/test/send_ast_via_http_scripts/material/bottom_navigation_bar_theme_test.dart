// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BottomNavigationBarTheme from material
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
        color: Colors.deepPurple.shade800,
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

// Helper to build info box
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

// Helper to wrap a BottomNavigationBar in a theme
Widget buildThemedNavBar({
  required String title,
  required String description,
  required BottomNavigationBarThemeData themeData,
  int currentIndex = 0,
  List<BottomNavigationBarItem>? items,
}) {
  List<BottomNavigationBarItem> navItems = items ?? [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

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
              color: Colors.deepPurple.shade700,
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
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BottomNavigationBarTheme(
            data: themeData,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              items: navItems,
              onTap: (i) {},
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    ),
  );
}

// Helper to show nested theme example
Widget buildNestedThemeDemo({
  required String title,
  required String description,
  required BottomNavigationBarThemeData outerTheme,
  required BottomNavigationBarThemeData innerTheme,
  int outerIndex = 0,
  int innerIndex = 2,
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
              color: Colors.deepPurple.shade700,
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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Outer Theme',
              style: TextStyle(fontSize: 11, color: Colors.deepPurple),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BottomNavigationBarTheme(
            data: outerTheme,
            child: BottomNavigationBar(
              currentIndex: outerIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
                BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
              ],
              onTap: (i) {},
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Inner Theme (overrides outer)',
              style: TextStyle(fontSize: 11, color: Colors.orange.shade700),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BottomNavigationBarTheme(
            data: innerTheme,
            child: BottomNavigationBar(
              currentIndex: innerIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
                BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
              ],
              onTap: (i) {},
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    ),
  );
}

// Helper: theme property row
Widget buildThemePropertyRow(String property, String outerVal, String innerVal) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(property, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(outerVal, style: TextStyle(fontSize: 11, color: Colors.deepPurple)),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(innerVal, style: TextStyle(fontSize: 11, color: Colors.orange.shade700)),
          ),
        ),
      ],
    ),
  );
}

// Helper: color swatch display
Widget buildColorSwatch(String label, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 8),
    child: Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 9, color: Colors.grey.shade700)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== BottomNavigationBarTheme Deep Demo ===');
  debugPrint('Demonstrating BottomNavigationBarTheme inheritance and wrapping');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BottomNavigationBarTheme Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Theme wrapping, inheritance, and override patterns',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Basic Theme Wrapping
        buildSectionTitle('1. Basic Theme Wrapping'),
        buildDescription('BottomNavigationBarTheme wrapping bars with different themes'),

        buildThemedNavBar(
          title: 'Blue Ocean Theme',
          description: 'Deep blue background with white selection',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.blue.shade800,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blue.shade200,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
          ),
          currentIndex: 0,
        ),
        buildThemedNavBar(
          title: 'Sunset Theme',
          description: 'Orange-red gradient feel with warm colors',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.deepOrange,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.orange.shade100,
            type: BottomNavigationBarType.fixed,
            elevation: 4,
          ),
          currentIndex: 1,
        ),
        buildThemedNavBar(
          title: 'Forest Theme',
          description: 'Green tones with natural feel',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.green.shade800,
            selectedItemColor: Colors.lightGreenAccent,
            unselectedItemColor: Colors.green.shade300,
            type: BottomNavigationBarType.fixed,
            elevation: 6,
          ),
          currentIndex: 2,
        ),
        buildThemedNavBar(
          title: 'Midnight Theme',
          description: 'Dark with cyan accent highlights',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade900,
            selectedItemColor: Colors.cyanAccent,
            unselectedItemColor: Colors.grey.shade600,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
          ),
          currentIndex: 3,
        ),

        // Section 2: Shifting Type Themes
        buildSectionTitle('2. Shifting Type Themes'),
        buildDescription('Themes applied with shifting navigation bar type'),

        buildThemedNavBar(
          title: 'Shifting Purple',
          description: 'Purple theme with shifting animation effect',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.purple,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.purple.shade100,
            type: BottomNavigationBarType.shifting,
            elevation: 8,
          ),
          currentIndex: 0,
        ),
        buildThemedNavBar(
          title: 'Shifting Teal',
          description: 'Teal shifting nav bar',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.teal.shade700,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.teal.shade200,
            type: BottomNavigationBarType.shifting,
            elevation: 6,
          ),
          currentIndex: 2,
        ),

        // Section 3: Nested Theme Inheritance
        buildSectionTitle('3. Nested Theme Inheritance'),
        buildDescription('Inner themes override outer themes, demonstrating cascading'),

        buildNestedThemeDemo(
          title: 'Purple Outer -> Orange Inner',
          description: 'The inner theme completely overrides the outer theme',
          outerTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.deepPurple,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.deepPurple.shade200,
            type: BottomNavigationBarType.fixed,
          ),
          innerTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.orange,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.orange.shade200,
            type: BottomNavigationBarType.fixed,
          ),
          outerIndex: 0,
          innerIndex: 1,
        ),

        // Property comparison table
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Property Comparison',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    child: Text('Outer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Inner', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              buildThemePropertyRow('backgroundColor', 'deepPurple', 'orange'),
              buildThemePropertyRow('selectedColor', 'white', 'white'),
              buildThemePropertyRow('unselectedColor', 'purple.200', 'orange.200'),
              buildThemePropertyRow('type', 'fixed', 'fixed'),
            ],
          ),
        ),

        buildNestedThemeDemo(
          title: 'Blue Outer -> Red Inner',
          description: 'Color contrast showing distinct theme application',
          outerTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.yellowAccent,
            unselectedItemColor: Colors.blue.shade100,
            type: BottomNavigationBarType.fixed,
          ),
          innerTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.red,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.red.shade100,
            type: BottomNavigationBarType.fixed,
          ),
          outerIndex: 1,
          innerIndex: 0,
        ),

        buildNestedThemeDemo(
          title: 'Light Outer -> Dark Inner',
          description: 'Switching from light to dark theme',
          outerTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade100,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
          innerTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade900,
            selectedItemColor: Colors.cyanAccent,
            unselectedItemColor: Colors.grey.shade500,
            type: BottomNavigationBarType.fixed,
          ),
          outerIndex: 2,
          innerIndex: 1,
        ),

        // Section 4: Icon Theme Customization
        buildSectionTitle('4. Icon Theme via BottomNavigationBarTheme'),
        buildDescription('Using selectedIconTheme and unselectedIconTheme'),

        buildThemedNavBar(
          title: 'Large Selected Icons',
          description: 'Selected icons larger than unselected',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: IconThemeData(size: 30, color: Colors.indigo),
            unselectedIconTheme: IconThemeData(size: 20, color: Colors.grey),
            type: BottomNavigationBarType.fixed,
          ),
          currentIndex: 0,
        ),
        buildThemedNavBar(
          title: 'Opaque Selected / Transparent Unselected',
          description: 'Using opacity on icon theme',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.blueGrey.shade800,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            selectedIconTheme: IconThemeData(size: 26, opacity: 1.0, color: Colors.white),
            unselectedIconTheme: IconThemeData(size: 22, opacity: 0.5, color: Colors.white),
            type: BottomNavigationBarType.fixed,
          ),
          currentIndex: 2,
        ),

        // Section 5: Label Style Customization
        buildSectionTitle('5. Label Style Customization'),
        buildDescription('Custom TextStyle for selected and unselected labels'),

        buildThemedNavBar(
          title: 'Bold Selected Labels',
          description: 'Selected label gets bold weight and different size',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            type: BottomNavigationBarType.fixed,
          ),
          currentIndex: 1,
        ),
        buildThemedNavBar(
          title: 'Italic Unselected Labels',
          description: 'Unselected labels use italic style',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.amber.shade50,
            selectedItemColor: Colors.brown.shade800,
            unselectedItemColor: Colors.brown.shade300,
            selectedLabelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
            type: BottomNavigationBarType.fixed,
          ),
          currentIndex: 3,
        ),

        // Section 6: Color Palette Display
        buildSectionTitle('6. Theme Color Palettes'),
        buildDescription('Color swatches used across different themes'),

        Container(
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
              Text(
                'Ocean Theme Palette',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Wrap(
                children: [
                  buildColorSwatch('BG', Colors.blue.shade800),
                  buildColorSwatch('Selected', Colors.white),
                  buildColorSwatch('Unselected', Colors.blue.shade200),
                  buildColorSwatch('Accent', Colors.cyanAccent),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Sunset Theme Palette',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Wrap(
                children: [
                  buildColorSwatch('BG', Colors.deepOrange),
                  buildColorSwatch('Selected', Colors.yellow),
                  buildColorSwatch('Unselected', Colors.orange.shade100),
                  buildColorSwatch('Accent', Colors.red),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Midnight Theme Palette',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Wrap(
                children: [
                  buildColorSwatch('BG', Colors.grey.shade900),
                  buildColorSwatch('Selected', Colors.cyanAccent),
                  buildColorSwatch('Unselected', Colors.grey.shade600),
                  buildColorSwatch('Accent', Colors.tealAccent),
                ],
              ),
            ],
          ),
        ),

        // Section 7: Using with full Theme widget
        buildSectionTitle('7. Full Theme Widget Integration'),
        buildDescription('BottomNavigationBarTheme within Theme widget context'),

        Container(
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
                  'Theme-integrated NavBar',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  'Using Theme widget with bottomNavigationBarTheme',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Theme(
                  data: ThemeData(
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: Colors.pink.shade700,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.pink.shade200,
                      type: BottomNavigationBarType.fixed,
                      elevation: 12,
                    ),
                  ),
                  child: BottomNavigationBar(
                    currentIndex: 1,
                    items: [
                      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                      BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
                      BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
                      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
                    ],
                    onTap: (i) {},
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),

        // Section 8: Different Item Sets
        buildSectionTitle('8. Different Navigation Item Sets'),
        buildDescription('Same theme applied to different icon/label combinations'),

        buildThemedNavBar(
          title: 'Social Media Icons',
          description: 'Feed, Messages, Notifications, Profile',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.blue.shade600,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blue.shade200,
            type: BottomNavigationBarType.fixed,
          ),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Me'),
          ],
          currentIndex: 0,
        ),
        buildThemedNavBar(
          title: 'E-commerce Icons',
          description: 'Shop, Cart, Orders, Account',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.amber,
            selectedItemColor: Colors.brown.shade900,
            unselectedItemColor: Colors.brown.shade400,
            type: BottomNavigationBarType.fixed,
          ),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
          currentIndex: 1,
        ),
        buildThemedNavBar(
          title: 'Music Player Icons',
          description: 'Library, Search, Now Playing, Playlists',
          themeData: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade900,
            selectedItemColor: Colors.greenAccent,
            unselectedItemColor: Colors.grey.shade500,
            type: BottomNavigationBarType.fixed,
          ),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: 'Playing'),
            BottomNavigationBarItem(icon: Icon(Icons.queue_music), label: 'Playlists'),
          ],
          currentIndex: 2,
        ),

        // Section 9: Summary
        buildSectionTitle('9. Summary'),
        buildInfoBox(
          'BottomNavigationBarTheme is an InheritedWidget that provides '
          'BottomNavigationBarThemeData to all BottomNavigationBar descendants.',
          Colors.deepPurple,
        ),
        buildInfoBox(
          'Inner BottomNavigationBarTheme widgets override outer ones, '
          'allowing nested theme customization.',
          Colors.blue,
        ),
        buildInfoBox(
          'Theme data includes backgroundColor, selectedItemColor, unselectedItemColor, '
          'iconTheme, labelStyle, type, elevation, and more.',
          Colors.green,
        ),
        buildInfoBox(
          'BottomNavigationBarTheme can also be applied via the Theme widget using '
          'ThemeData.bottomNavigationBarTheme.',
          Colors.orange,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
