// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Adaptation from material
// Demonstrates how Adaptation<T> works with ThemeData to adapt widgets per platform
import 'package:flutter/material.dart';

// Helper to build a section header
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

// Helper to build a platform card showing adaptation concept
Widget buildPlatformCard(
  String platformName,
  Color primaryColor,
  Color accentColor,
  IconData platformIcon,
  String description,
  TargetPlatform platform,
) {
  return Card(
    elevation: 4,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: primaryColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(platformIcon, color: primaryColor, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  platformName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          SizedBox(height: 12),
          // Simulated switch appearance per platform
          Row(
            children: [
              Text('Switch style: ', style: TextStyle(fontSize: 14)),
              Container(
                width: 50,
                height: 28,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(
                    platform == TargetPlatform.iOS ? 14 : 8,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 24,
                    height: 24,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: platform == TargetPlatform.iOS
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      borderRadius: platform == TargetPlatform.iOS
                          ? null
                          : BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Simulated slider appearance per platform
          Row(
            children: [
              Text('Slider style: ', style: TextStyle(fontSize: 14)),
              Expanded(
                child: SizedBox(
                  height: 20,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: platform == TargetPlatform.iOS ? 2 : 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: platform == TargetPlatform.iOS ? 2 : 4,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        child: Container(
                          width: platform == TargetPlatform.iOS ? 28 : 20,
                          height: platform == TargetPlatform.iOS ? 28 : 20,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: platform == TargetPlatform.iOS
                                    ? 4
                                    : 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Helper to build a themed container for different platforms
Widget buildThemedContainer(
  String label,
  Color bgColor,
  Color textColor,
  double borderRadius,
  double elevation,
) {
  return Card(
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

// Helper to build a navigation style demo per platform
Widget buildNavigationDemo(
  String platformName,
  Color bgColor,
  Color selectedColor,
  Color unselectedColor,
  bool useLabels,
  double iconSize,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$platformName Navigation',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNavItem(
                Icons.home,
                'Home',
                selectedColor,
                true,
                useLabels,
                iconSize,
              ),
              buildNavItem(
                Icons.search,
                'Search',
                unselectedColor,
                false,
                useLabels,
                iconSize,
              ),
              buildNavItem(
                Icons.favorite,
                'Favorites',
                unselectedColor,
                false,
                useLabels,
                iconSize,
              ),
              buildNavItem(
                Icons.person,
                'Profile',
                unselectedColor,
                false,
                useLabels,
                iconSize,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildNavItem(
  IconData icon,
  String label,
  Color color,
  bool isSelected,
  bool showLabel,
  double iconSize,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color, size: iconSize),
      if (showLabel)
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
    ],
  );
}

// Helper to build a button style demo for a platform
Widget buildButtonStyleDemo(
  String platformName,
  Color buttonColor,
  double borderRadius,
  double elevation,
  EdgeInsets padding,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$platformName Button Styles',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: padding,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: buttonColor.withAlpha(80),
                    blurRadius: elevation * 2,
                    offset: Offset(0, elevation),
                  ),
                ],
              ),
              child: Text(
                'Primary',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: padding,
              decoration: BoxDecoration(
                border: Border.all(color: buttonColor, width: 2),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Text(
                'Secondary',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: padding,
              child: Text(
                'Text',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper to build typography adaptation demo
Widget buildTypographyDemo(
  String platformName,
  String fontFamily,
  double baseSize,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$platformName Typography ($fontFamily)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Headline',
          style: TextStyle(fontSize: baseSize * 2, fontWeight: FontWeight.bold),
        ),
        Text(
          'Title text style',
          style: TextStyle(
            fontSize: baseSize * 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Body text for $platformName platform',
          style: TextStyle(fontSize: baseSize),
        ),
        Text(
          'Caption text smaller size',
          style: TextStyle(
            fontSize: baseSize * 0.8,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

// Helper for dialog adaptation demo
Widget buildDialogDemo(
  String platformName,
  Color titleColor,
  double borderRadius,
  bool showDivider,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          child: Text(
            '$platformName Dialog',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
        ),
        if (showDivider) Divider(height: 1),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'This shows how a dialog looks on $platformName. '
            'Different platforms have different dialog styles, '
            'corner radii, and button placements.',
            style: TextStyle(fontSize: 14),
          ),
        ),
        if (showDivider) Divider(height: 1),
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: titleColor,
                  borderRadius: BorderRadius.circular(borderRadius / 2),
                ),
                child: Text('Confirm', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper to build checkbox adaptation demo
Widget buildCheckboxDemo(
  String platformName,
  Color checkColor,
  double size,
  double borderRadius,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Text(
          '$platformName checkboxes: ',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 8),
        // Checked
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: checkColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Icon(Icons.check, color: Colors.white, size: size * 0.7),
        ),
        SizedBox(width: 8),
        // Unchecked
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        SizedBox(width: 8),
        // Indeterminate
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: checkColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Icon(Icons.remove, color: Colors.white, size: size * 0.7),
        ),
      ],
    ),
  );
}

// Helper to build a color row
Widget buildColorRow(String label, List<Color> colors) {
  return Row(
    children: [
      SizedBox(
        width: 70,
        child: Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      ...colors.map(
        (c) => Expanded(
          child: Container(
            height: 30,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== Adaptation Test Script ===');
  debugPrint(
    'Testing Adaptation<T> concept with ThemeData for platform-specific styling',
  );

  // Get current platform info
  TargetPlatform currentPlatform = Theme.of(context).platform;
  debugPrint('Current platform: $currentPlatform');

  // Create ThemeData for different platforms
  ThemeData androidTheme = ThemeData(
    platform: TargetPlatform.android,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
  );
  debugPrint('Created Android theme with green seed color');

  ThemeData iosTheme = ThemeData(
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );
  debugPrint('Created iOS theme with blue seed color');

  ThemeData windowsTheme = ThemeData(
    platform: TargetPlatform.windows,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
    useMaterial3: true,
  );
  debugPrint('Created Windows theme with purple seed color');

  ThemeData macosTheme = ThemeData(
    platform: TargetPlatform.macOS,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    useMaterial3: true,
  );
  debugPrint('Created macOS theme with orange seed color');

  ThemeData linuxTheme = ThemeData(
    platform: TargetPlatform.linux,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
  );
  debugPrint('Created Linux theme with teal seed color');

  debugPrint('Building visual adaptation demonstrations...');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adaptation<T> Demo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Platform-specific widget styling through ThemeData adaptation',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              SizedBox(height: 4),
              Text(
                'Current platform: $currentPlatform',
                style: TextStyle(fontSize: 14, color: Colors.white60),
              ),
            ],
          ),
        ),

        // Section 1: Platform Cards
        buildSectionHeader('1. Platform Switch & Slider Adaptations'),
        buildPlatformCard(
          'Android (Material)',
          Colors.green.shade700,
          Colors.green.shade400,
          Icons.android,
          'Material Design with rounded rectangles, ripple effects, and green accent.',
          TargetPlatform.android,
        ),
        buildPlatformCard(
          'iOS (Cupertino)',
          Colors.blue.shade700,
          Colors.blue.shade400,
          Icons.apple,
          'Cupertino style with circular toggles, smooth transitions, and blue accent.',
          TargetPlatform.iOS,
        ),
        buildPlatformCard(
          'Windows (Fluent)',
          Colors.purple.shade700,
          Colors.purple.shade400,
          Icons.desktop_windows,
          'Fluent Design with sharp corners, acrylic effects, and purple accent.',
          TargetPlatform.windows,
        ),
        buildPlatformCard(
          'macOS (Aqua)',
          Colors.orange.shade700,
          Colors.orange.shade400,
          Icons.laptop_mac,
          'macOS Aqua style with pill shapes, subtle shadows, and orange accent.',
          TargetPlatform.macOS,
        ),
        buildPlatformCard(
          'Linux (GTK-inspired)',
          Colors.teal.shade700,
          Colors.teal.shade400,
          Icons.computer,
          'GTK-inspired look with clean lines, flat style, and teal accent.',
          TargetPlatform.linux,
        ),

        // Section 2: Themed Containers
        buildSectionHeader('2. Themed Containers Per Platform'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildThemedContainer(
                'Android\nMaterial',
                Colors.green.shade100,
                Colors.green.shade800,
                12,
                4,
              ),
              SizedBox(width: 8),
              buildThemedContainer(
                'iOS\nCupertino',
                Colors.blue.shade100,
                Colors.blue.shade800,
                16,
                2,
              ),
              SizedBox(width: 8),
              buildThemedContainer(
                'Windows\nFluent',
                Colors.purple.shade100,
                Colors.purple.shade800,
                4,
                6,
              ),
              SizedBox(width: 8),
              buildThemedContainer(
                'macOS\nAqua',
                Colors.orange.shade100,
                Colors.orange.shade800,
                20,
                3,
              ),
              SizedBox(width: 8),
              buildThemedContainer(
                'Linux\nGTK',
                Colors.teal.shade100,
                Colors.teal.shade800,
                8,
                1,
              ),
            ],
          ),
        ),

        // Section 3: Navigation Adaptation
        buildSectionHeader('3. Navigation Bar Adaptation'),
        buildNavigationDemo(
          'Android',
          Colors.white,
          Colors.green.shade700,
          Colors.grey.shade500,
          true,
          24,
        ),
        buildNavigationDemo(
          'iOS',
          Colors.grey.shade100,
          Colors.blue.shade700,
          Colors.grey.shade400,
          true,
          28,
        ),
        buildNavigationDemo(
          'Windows',
          Colors.grey.shade200,
          Colors.purple.shade700,
          Colors.grey.shade600,
          false,
          22,
        ),
        buildNavigationDemo(
          'macOS',
          Colors.white,
          Colors.orange.shade700,
          Colors.grey.shade500,
          true,
          20,
        ),

        // Section 4: Button Style Adaptation
        buildSectionHeader('4. Button Style Adaptation'),
        buildButtonStyleDemo(
          'Android',
          Colors.green.shade700,
          20,
          2,
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        buildButtonStyleDemo(
          'iOS',
          Colors.blue.shade700,
          8,
          0,
          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        buildButtonStyleDemo(
          'Windows',
          Colors.purple.shade700,
          4,
          1,
          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        buildButtonStyleDemo(
          'macOS',
          Colors.orange.shade700,
          6,
          1,
          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        ),
        buildButtonStyleDemo(
          'Linux',
          Colors.teal.shade700,
          4,
          0,
          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Section 5: Typography Adaptation
        buildSectionHeader('5. Typography Adaptation'),
        buildTypographyDemo('Android', 'Roboto', 14),
        buildTypographyDemo('iOS', 'SF Pro', 15),
        buildTypographyDemo('Windows', 'Segoe UI', 14),
        buildTypographyDemo('macOS', 'SF Pro', 13),

        // Section 6: Dialog Adaptation
        buildSectionHeader('6. Dialog Adaptation'),
        buildDialogDemo('Android', Colors.green.shade700, 28, false),
        SizedBox(height: 12),
        buildDialogDemo('iOS', Colors.blue.shade700, 14, true),
        SizedBox(height: 12),
        buildDialogDemo('Windows', Colors.purple.shade700, 4, true),

        // Section 7: Checkbox Adaptation
        buildSectionHeader('7. Checkbox / Selection Adaptation'),
        buildCheckboxDemo('Android', Colors.green.shade700, 24, 4),
        buildCheckboxDemo('iOS', Colors.blue.shade700, 22, 11),
        buildCheckboxDemo('Windows', Colors.purple.shade700, 20, 2),
        buildCheckboxDemo('macOS', Colors.orange.shade700, 18, 4),
        buildCheckboxDemo('Linux', Colors.teal.shade700, 22, 3),

        // Section 8: Theme wrapping with actual Theme widget
        buildSectionHeader('8. Theme Widget Wrapping Demo'),
        Theme(
          data: androidTheme,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.android, color: Colors.green),
              title: Text('Android Themed ListTile'),
              subtitle: Text('Using ThemeData with TargetPlatform.android'),
              trailing: Switch(value: true, onChanged: (v) {}),
            ),
          ),
        ),
        Theme(
          data: iosTheme,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.apple, color: Colors.blue),
              title: Text('iOS Themed ListTile'),
              subtitle: Text('Using ThemeData with TargetPlatform.iOS'),
              trailing: Switch(value: false, onChanged: (v) {}),
            ),
          ),
        ),
        Theme(
          data: windowsTheme,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.desktop_windows, color: Colors.purple),
              title: Text('Windows Themed ListTile'),
              subtitle: Text('Using ThemeData with TargetPlatform.windows'),
              trailing: Switch(value: true, onChanged: (v) {}),
            ),
          ),
        ),
        Theme(
          data: macosTheme,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.laptop_mac, color: Colors.orange),
              title: Text('macOS Themed ListTile'),
              subtitle: Text('Using ThemeData with TargetPlatform.macOS'),
              trailing: Switch(value: false, onChanged: (v) {}),
            ),
          ),
        ),
        Theme(
          data: linuxTheme,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.computer, color: Colors.teal),
              title: Text('Linux Themed ListTile'),
              subtitle: Text('Using ThemeData with TargetPlatform.linux'),
              trailing: Switch(value: true, onChanged: (v) {}),
            ),
          ),
        ),

        // Section 9: Color adaptation grid
        buildSectionHeader('9. Color Adaptation Across Platforms'),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              buildColorRow('Primary', [
                Colors.green,
                Colors.blue,
                Colors.purple,
                Colors.orange,
                Colors.teal,
              ]),
              SizedBox(height: 8),
              buildColorRow('Secondary', [
                Colors.lightGreen,
                Colors.lightBlue,
                Colors.deepPurple,
                Colors.deepOrange,
                Colors.cyan,
              ]),
              SizedBox(height: 8),
              buildColorRow('Surface', [
                Colors.green.shade50,
                Colors.blue.shade50,
                Colors.purple.shade50,
                Colors.orange.shade50,
                Colors.teal.shade50,
              ]),
              SizedBox(height: 8),
              buildColorRow('Error', [
                Colors.red,
                Colors.red.shade700,
                Colors.red.shade400,
                Colors.red.shade600,
                Colors.red.shade800,
              ]),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Android',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  Text(
                    'iOS',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  Text(
                    'Windows',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  Text(
                    'macOS',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  Text(
                    'Linux',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of Adaptation Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
