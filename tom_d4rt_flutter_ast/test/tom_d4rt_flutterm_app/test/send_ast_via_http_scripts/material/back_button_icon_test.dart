// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BackButtonIcon from material
// Shows back button icons in various contexts, themes, sizes, and color configurations
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.brown.shade700,
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

// Helper to build a simulated app bar with back button
Widget buildAppBarWithBack(
  String title,
  Color backgroundColor,
  Color iconColor,
  IconData backIcon, {
  double elevation = 4,
  double iconSize = 24,
  List<IconData> actions = const [],
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withAlpha(20),
              ),
              child: Icon(backIcon, color: iconColor, size: iconSize),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: iconColor,
                ),
              ),
            ),
            ...actions.map(
              (a) => Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(a, color: iconColor, size: iconSize),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper to build a back icon in a circle
Widget buildCircledBackIcon(
  IconData icon,
  Color iconColor,
  Color bgColor,
  double size,
  String label,
) {
  return Container(
    margin: EdgeInsets.all(6),
    child: Column(
      children: [
        Container(
          width: size + 20,
          height: size + 20,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: bgColor.withAlpha(80),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: size),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// Helper to build a size comparison row
Widget buildSizeRow(IconData icon, String label, Color color) {
  List<double> sizes = [14, 18, 22, 26, 30, 36, 42, 48];
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: sizes.map((s) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: s, color: color),
                SizedBox(height: 4),
                Text(
                  '${s.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Helper to build a color swatch row for an icon
Widget buildColorSwatchRow(IconData icon, String label, List<Color> colors) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: colors.map((c) {
            return Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: c.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: c.withAlpha(60)),
              ),
              child: Icon(icon, color: c, size: 24),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Helper to build a platform icon comparison
Widget buildPlatformComparison(
  String platform,
  IconData icon,
  Color color,
  String description,
) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Icon: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Icon(icon, size: 14, color: color),
                    Text(
                      icon == Icons.arrow_back
                          ? '  arrow_back'
                          : '  arrow_back_ios',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper to build an icon in different container shapes
Widget buildContainerShape(
  IconData icon,
  Color iconColor,
  Color bgColor,
  String label,
  BoxShape shape,
  double borderRadius,
) {
  return Container(
    margin: EdgeInsets.all(4),
    child: Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: bgColor,
            shape: shape,
            borderRadius: shape == BoxShape.rectangle
                ? BorderRadius.circular(borderRadius)
                : null,
          ),
          child: Center(child: Icon(icon, color: iconColor, size: 24)),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// Helper to build icon with opacity
Widget buildOpacityRow(IconData icon, Color color) {
  List<double> opacities = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opacity levels',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: opacities.map((o) {
            return Column(
              children: [
                Opacity(
                  opacity: o,
                  child: Icon(icon, size: 28, color: color),
                ),
                SizedBox(height: 4),
                Text(
                  '${(o * 100).toInt()}%',
                  style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Helper to build disabled vs enabled comparison
Widget buildEnabledDisabledRow(
  IconData icon,
  Color enabledColor,
  String label,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(width: 16),
        Text(
          'Enabled:',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabledColor.withAlpha(20),
          ),
          child: Icon(icon, color: enabledColor, size: 24),
        ),
        SizedBox(width: 24),
        Text(
          'Disabled:',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: Icon(icon, color: Colors.grey.shade300, size: 24),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== BackButtonIcon Test Script ===');
  debugPrint(
    'Testing BackButtonIcon in various contexts, themes, sizes, and colors',
  );

  TargetPlatform platform = Theme.of(context).platform;
  debugPrint('Current platform: $platform');

  // Determine which back icon this platform uses
  IconData platformBackIcon =
      (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS)
      ? Icons.arrow_back_ios
      : Icons.arrow_back;
  debugPrint(
    'Platform back icon: ${platformBackIcon == Icons.arrow_back ? "arrow_back" : "arrow_back_ios"}',
  );

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
              colors: [Colors.brown.shade700, Colors.brown.shade400],
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
                  Icon(Icons.arrow_back, size: 36, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    'BackButtonIcon',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Platform-adaptive back navigation icon display',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Platform Comparison
        buildSectionHeader('1. Platform-Specific Back Icons'),
        buildPlatformComparison(
          'Android / Material',
          Icons.arrow_back,
          Colors.green.shade700,
          'Uses arrow_back (left-pointing arrow). Material Design standard.',
        ),
        buildPlatformComparison(
          'iOS / Cupertino',
          Icons.arrow_back_ios,
          Colors.blue.shade700,
          'Uses arrow_back_ios (chevron). Apple Human Interface Guidelines.',
        ),
        buildPlatformComparison(
          'macOS',
          Icons.arrow_back_ios,
          Colors.orange.shade700,
          'Same as iOS - chevron style for macOS apps.',
        ),
        buildPlatformComparison(
          'Windows / Linux',
          Icons.arrow_back,
          Colors.purple.shade700,
          'Uses arrow_back like Android for desktop platforms.',
        ),

        // Section 2: All Back Icon Variants
        buildSectionHeader('2. Back Icon Variants'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildCircledBackIcon(
                Icons.arrow_back,
                Colors.white,
                Colors.blue.shade700,
                28,
                'arrow_back',
              ),
              buildCircledBackIcon(
                Icons.arrow_back_ios,
                Colors.white,
                Colors.green.shade700,
                28,
                'back_ios',
              ),
              buildCircledBackIcon(
                Icons.arrow_back_ios_new,
                Colors.white,
                Colors.orange.shade700,
                28,
                'ios_new',
              ),
              buildCircledBackIcon(
                Icons.chevron_left,
                Colors.white,
                Colors.purple.shade700,
                28,
                'chevron_left',
              ),
              buildCircledBackIcon(
                Icons.west,
                Colors.white,
                Colors.red.shade700,
                28,
                'west',
              ),
              buildCircledBackIcon(
                Icons.keyboard_backspace,
                Colors.white,
                Colors.teal.shade700,
                28,
                'backspace',
              ),
              buildCircledBackIcon(
                Icons.navigate_before,
                Colors.white,
                Colors.pink.shade700,
                28,
                'nav_before',
              ),
              buildCircledBackIcon(
                Icons.undo,
                Colors.white,
                Colors.brown.shade700,
                28,
                'undo',
              ),
            ],
          ),
        ),

        // Section 3: Sizes
        buildSectionHeader('3. Size Comparisons'),
        buildSizeRow(
          Icons.arrow_back,
          'arrow_back sizes',
          Colors.blue.shade700,
        ),
        buildSizeRow(
          Icons.arrow_back_ios,
          'arrow_back_ios sizes',
          Colors.green.shade700,
        ),
        buildSizeRow(
          Icons.chevron_left,
          'chevron_left sizes',
          Colors.purple.shade700,
        ),

        // Section 4: Color Variations
        buildSectionHeader('4. Color Variations'),
        buildColorSwatchRow(Icons.arrow_back, 'arrow_back colors', [
          Colors.red,
          Colors.orange,
          Colors.amber,
          Colors.green,
          Colors.teal,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
        ]),
        buildColorSwatchRow(Icons.arrow_back_ios, 'arrow_back_ios colors', [
          Colors.red,
          Colors.orange,
          Colors.amber,
          Colors.green,
          Colors.teal,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
        ]),

        // Section 5: In App Bar Contexts
        buildSectionHeader('5. In App Bar Contexts'),
        buildAppBarWithBack(
          'Material App Bar',
          Colors.blue,
          Colors.white,
          Icons.arrow_back,
          actions: [Icons.share, Icons.more_vert],
        ),
        buildAppBarWithBack(
          'iOS Style Bar',
          Colors.white,
          Colors.blue.shade700,
          Icons.arrow_back_ios,
          elevation: 0.5,
        ),
        buildAppBarWithBack(
          'Surface Bar',
          Colors.grey.shade100,
          Colors.black87,
          Icons.arrow_back,
          elevation: 1,
        ),
        buildAppBarWithBack(
          'Dark Bar',
          Colors.grey.shade900,
          Colors.white,
          Icons.arrow_back,
        ),
        buildAppBarWithBack(
          'Colored Bar',
          Colors.deepPurple,
          Colors.white,
          Icons.arrow_back,
          actions: [Icons.search, Icons.favorite],
        ),
        buildAppBarWithBack(
          'Transparent Bar',
          Colors.transparent,
          Colors.black87,
          Icons.arrow_back,
          elevation: 0,
        ),

        // Section 6: Container Shapes
        buildSectionHeader('6. Container Shape Styles'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildContainerShape(
              Icons.arrow_back,
              Colors.white,
              Colors.blue,
              'Circle',
              BoxShape.circle,
              0,
            ),
            buildContainerShape(
              Icons.arrow_back,
              Colors.blue,
              Colors.blue.shade50,
              'Rounded 8',
              BoxShape.rectangle,
              8,
            ),
            buildContainerShape(
              Icons.arrow_back,
              Colors.blue,
              Colors.blue.shade50,
              'Rounded 4',
              BoxShape.rectangle,
              4,
            ),
            buildContainerShape(
              Icons.arrow_back,
              Colors.blue,
              Colors.blue.shade50,
              'Square',
              BoxShape.rectangle,
              0,
            ),
            buildContainerShape(
              Icons.arrow_back,
              Colors.blue,
              Colors.blue.shade50,
              'Pill',
              BoxShape.rectangle,
              24,
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildContainerShape(
              Icons.arrow_back_ios,
              Colors.white,
              Colors.green,
              'Circle',
              BoxShape.circle,
              0,
            ),
            buildContainerShape(
              Icons.arrow_back_ios,
              Colors.green,
              Colors.green.shade50,
              'Rounded 8',
              BoxShape.rectangle,
              8,
            ),
            buildContainerShape(
              Icons.arrow_back_ios,
              Colors.green,
              Colors.green.shade50,
              'Rounded 4',
              BoxShape.rectangle,
              4,
            ),
            buildContainerShape(
              Icons.arrow_back_ios,
              Colors.green,
              Colors.green.shade50,
              'Square',
              BoxShape.rectangle,
              0,
            ),
            buildContainerShape(
              Icons.arrow_back_ios,
              Colors.green,
              Colors.green.shade50,
              'Pill',
              BoxShape.rectangle,
              24,
            ),
          ],
        ),

        // Section 7: Opacity
        buildSectionHeader('7. Opacity Levels'),
        buildOpacityRow(Icons.arrow_back, Colors.blue.shade700),
        buildOpacityRow(Icons.arrow_back_ios, Colors.green.shade700),

        // Section 8: Enabled vs Disabled
        buildSectionHeader('8. Enabled vs Disabled States'),
        buildEnabledDisabledRow(
          Icons.arrow_back,
          Colors.blue.shade700,
          'Material',
        ),
        buildEnabledDisabledRow(
          Icons.arrow_back_ios,
          Colors.green.shade700,
          'iOS',
        ),
        buildEnabledDisabledRow(
          Icons.chevron_left,
          Colors.purple.shade700,
          'Chevron',
        ),
        buildEnabledDisabledRow(Icons.west, Colors.red.shade700, 'West'),

        // Section 9: Dark vs Light Backgrounds
        buildSectionHeader('9. Dark vs Light Backgrounds'),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      'Light BG',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    Icon(Icons.arrow_back, size: 32, color: Colors.black87),
                    SizedBox(height: 8),
                    Icon(Icons.arrow_back_ios, size: 32, color: Colors.black87),
                    SizedBox(height: 8),
                    Icon(Icons.chevron_left, size: 32, color: Colors.black87),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Dark BG',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Icon(Icons.arrow_back, size: 32, color: Colors.white),
                    SizedBox(height: 8),
                    Icon(Icons.arrow_back_ios, size: 32, color: Colors.white),
                    SizedBox(height: 8),
                    Icon(Icons.chevron_left, size: 32, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of BackButtonIcon Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
