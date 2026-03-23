// ignore_for_file: avoid_print
// D4rt test script: Tests PlatformAdaptiveIcons from material
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

Widget buildSubsectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    margin: EdgeInsets.only(bottom: 6, top: 12),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
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

Widget buildAdaptiveIconDisplay(
  String label,
  IconData adaptiveIcon,
  String description,
  Color iconColor,
) {
  print('Displaying adaptive icon: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: iconColor.withAlpha(60)),
          ),
          child: Center(
            child: Icon(adaptiveIcon, size: 32, color: iconColor),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'adaptive',
            style: TextStyle(
              fontSize: 11,
              color: Colors.indigo.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildIconComparisonCard(
  String iconName,
  IconData adaptiveIcon,
  IconData materialIcon,
  IconData cupertinoIcon,
) {
  print('Building comparison card for: $iconName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade100,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          iconName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  children: [
                    Icon(adaptiveIcon, size: 32, color: Colors.purple.shade700),
                    SizedBox(height: 8),
                    Text(
                      'Adaptive',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Auto-detect',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.purple.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Icon(materialIcon, size: 32, color: Colors.green.shade700),
                    SizedBox(height: 8),
                    Text(
                      'Material',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Android',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Icon(cupertinoIcon, size: 32, color: Colors.blue.shade700),
                    SizedBox(height: 8),
                    Text(
                      'Cupertino',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'iOS',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue.shade400,
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
  );
}

Widget buildSizedIconRow(IconData icon, String label, Color color) {
  List<double> sizes = [12, 16, 20, 24, 28, 32, 40, 48];
  List<Widget> iconWidgets = [];
  int i = 0;
  for (i = 0; i < sizes.length; i = i + 1) {
    double size = sizes[i];
    iconWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Container(
              width: size + 16,
              height: size + 16,
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withAlpha(50)),
              ),
              child: Center(
                child: Icon(icon, size: size, color: color),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${size.toInt()}',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
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
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: iconWidgets),
        ),
      ],
    ),
  );
}

Widget buildColoredIconGrid(IconData icon, String label) {
  List<Color> colors = [
    Colors.red.shade600,
    Colors.pink.shade600,
    Colors.purple.shade600,
    Colors.deepPurple.shade600,
    Colors.indigo.shade600,
    Colors.blue.shade600,
    Colors.cyan.shade600,
    Colors.teal.shade600,
    Colors.green.shade600,
    Colors.lime.shade700,
    Colors.amber.shade700,
    Colors.orange.shade600,
  ];
  List<Widget> colorItems = [];
  int i = 0;
  for (i = 0; i < colors.length; i = i + 1) {
    Color currentColor = colors[i];
    colorItems.add(
      Container(
        margin: EdgeInsets.all(4),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: currentColor.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: currentColor.withAlpha(80)),
        ),
        child: Center(
          child: Icon(icon, size: 26, color: currentColor),
        ),
      ),
    );
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          children: colorItems,
        ),
      ],
    ),
  );
}

Widget buildThemedIconCard(
  IconData icon,
  String themeName,
  Color primaryColor,
  Color backgroundColor,
  Color textColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withAlpha(40),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(30),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(icon, size: 36, color: primaryColor),
          ),
        ),
        SizedBox(height: 10),
        Text(
          themeName,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}

Widget buildIconUsageExample(
  String title,
  String description,
  IconData icon,
  Color accentColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accentColor.withAlpha(20), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: accentColor.withAlpha(80),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(icon, size: 30, color: Colors.white),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPlatformComparisonHeader() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, size: 18, color: Colors.purple.shade600),
              SizedBox(width: 4),
              Text(
                'Adaptive',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.purple.shade700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.android, size: 18, color: Colors.green.shade600),
              SizedBox(width: 4),
              Text(
                'Material',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apple, size: 18, color: Colors.grey.shade700),
              SizedBox(width: 4),
              Text(
                'Cupertino',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildQuickComparisonRow(
  IconData adaptiveIcon,
  IconData materialIcon,
  IconData cupertinoIcon,
  String name,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Center(
            child: Icon(adaptiveIcon, size: 24, color: Colors.purple.shade600),
          ),
        ),
        Expanded(
          child: Center(
            child: Icon(materialIcon, size: 24, color: Colors.green.shade600),
          ),
        ),
        Expanded(
          child: Center(
            child: Icon(cupertinoIcon, size: 24, color: Colors.blue.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget buildIconStateCard(
  IconData icon,
  String label,
  Color normalColor,
  Color disabledColor,
  Color activeColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: normalColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(icon, size: 26, color: normalColor),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Normal',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(icon, size: 26, color: disabledColor),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Disabled',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: activeColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(icon, size: 26, color: activeColor),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Active',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildIconButtonExample(
  IconData icon,
  String label,
  Color buttonColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        IconButton(
          icon: Icon(icon, color: buttonColor),
          onPressed: () {
            print('Icon button pressed: $label');
          },
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: buttonColor.withAlpha(20),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'IconButton',
            style: TextStyle(
              fontSize: 11,
              color: buttonColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSemanticIconExplanation(
  IconData icon,
  String iconClass,
  String androidBehavior,
  String iosBehavior,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 28, color: Colors.indigo.shade700),
            SizedBox(width: 12),
            Text(
              iconClass,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.android, size: 16, color: Colors.green.shade600),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                androidBehavior,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.apple, size: 16, color: Colors.grey.shade600),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                iosBehavior,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PlatformAdaptiveIcons deep demo test executing');
  print('Testing platform-adaptive icons: arrow_back, flip_camera, more, share');

  return Scaffold(
    appBar: AppBar(
      title: Text('Platform Adaptive Icons Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(Icons.adaptive.share),
          onPressed: () {
            print('Share action pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.adaptive.more),
          onPressed: () {
            print('More action pressed');
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Overview
          buildSectionHeader('1. Platform Adaptive Icons Overview'),
          buildInfoCard(
            'Purpose',
            'Icons that automatically adapt to platform design language',
          ),
          buildInfoCard(
            'Usage',
            'Access via Icons.adaptive.* (e.g., Icons.adaptive.share)',
          ),
          buildInfoCard(
            'Benefit',
            'Single codebase with native-feeling icons per platform',
          ),
          buildInfoCard(
            'Available',
            'arrow_back, flip_camera, more, share',
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber.shade700),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Icons.adaptive automatically selects the appropriate icon variant based on the current platform.',
                    style: TextStyle(fontSize: 13, color: Colors.amber.shade900),
                  ),
                ),
              ],
            ),
          ),

          // Section 2: Icons.adaptive.arrow_back
          buildSectionHeader('2. Icons.adaptive.arrow_back'),
          buildAdaptiveIconDisplay(
            'Adaptive Arrow Back',
            Icons.adaptive.arrow_back,
            'Navigational back arrow that adapts to platform conventions',
            Colors.indigo.shade700,
          ),
          buildIconComparisonCard(
            'Arrow Back Comparison',
            Icons.adaptive.arrow_back,
            Icons.arrow_back,
            CupertinoIcons.back,
          ),
          buildSemanticIconExplanation(
            Icons.adaptive.arrow_back,
            'Icons.adaptive.arrow_back',
            'Shows filled arrow pointing left (Material style)',
            'Shows chevron-style back indicator (Cupertino style)',
          ),
          buildSizedIconRow(
            Icons.adaptive.arrow_back,
            'Arrow Back Sizes',
            Colors.indigo.shade600,
          ),
          buildIconUsageExample(
            'Navigation Back Button',
            'Use in AppBar leading for back navigation across platforms',
            Icons.adaptive.arrow_back,
            Colors.indigo,
          ),
          buildIconStateCard(
            Icons.adaptive.arrow_back,
            'Arrow Back States',
            Colors.indigo.shade700,
            Colors.grey.shade400,
            Colors.indigo.shade400,
          ),

          // Section 3: Icons.adaptive.flip_camera
          buildSectionHeader('3. Icons.adaptive.flip_camera'),
          buildAdaptiveIconDisplay(
            'Adaptive Flip Camera',
            Icons.adaptive.flip_camera,
            'Camera toggle icon that adapts to platform camera UI patterns',
            Colors.deepPurple.shade700,
          ),
          buildIconComparisonCard(
            'Flip Camera Comparison',
            Icons.adaptive.flip_camera,
            Icons.flip_camera_android,
            Icons.flip_camera_ios,
          ),
          buildSemanticIconExplanation(
            Icons.adaptive.flip_camera,
            'Icons.adaptive.flip_camera',
            'Shows camera with circular arrows (flip_camera_android)',
            'Shows camera with dual arrows (flip_camera_ios)',
          ),
          buildSizedIconRow(
            Icons.adaptive.flip_camera,
            'Flip Camera Sizes',
            Colors.deepPurple.shade600,
          ),
          buildIconUsageExample(
            'Camera Switch Action',
            'Used in camera apps to toggle between front and rear cameras',
            Icons.adaptive.flip_camera,
            Colors.deepPurple,
          ),
          buildIconStateCard(
            Icons.adaptive.flip_camera,
            'Flip Camera States',
            Colors.deepPurple.shade700,
            Colors.grey.shade400,
            Colors.deepPurple.shade400,
          ),

          // Section 4: Icons.adaptive.more
          buildSectionHeader('4. Icons.adaptive.more'),
          buildAdaptiveIconDisplay(
            'Adaptive More Options',
            Icons.adaptive.more,
            'Context menu icon that reflects platform overflow patterns',
            Colors.teal.shade700,
          ),
          buildIconComparisonCard(
            'More Options Comparison',
            Icons.adaptive.more,
            Icons.more_vert,
            Icons.more_horiz,
          ),
          buildSemanticIconExplanation(
            Icons.adaptive.more,
            'Icons.adaptive.more',
            'Shows vertical three-dot menu (more_vert)',
            'Shows horizontal three-dot ellipsis (more_horiz)',
          ),
          buildSizedIconRow(
            Icons.adaptive.more,
            'More Icon Sizes',
            Colors.teal.shade600,
          ),
          buildIconUsageExample(
            'Overflow Menu Trigger',
            'Opens additional actions menu in AppBar or list items',
            Icons.adaptive.more,
            Colors.teal,
          ),
          buildIconStateCard(
            Icons.adaptive.more,
            'More Icon States',
            Colors.teal.shade700,
            Colors.grey.shade400,
            Colors.teal.shade400,
          ),

          // Section 5: Icons.adaptive.share
          buildSectionHeader('5. Icons.adaptive.share'),
          buildAdaptiveIconDisplay(
            'Adaptive Share',
            Icons.adaptive.share,
            'Share action icon that matches platform sharing conventions',
            Colors.blue.shade700,
          ),
          buildIconComparisonCard(
            'Share Icon Comparison',
            Icons.adaptive.share,
            Icons.share,
            CupertinoIcons.share,
          ),
          buildSemanticIconExplanation(
            Icons.adaptive.share,
            'Icons.adaptive.share',
            'Shows connected nodes/dots sharing metaphor (Material)',
            'Shows box with upward arrow export metaphor (Cupertino)',
          ),
          buildSizedIconRow(
            Icons.adaptive.share,
            'Share Icon Sizes',
            Colors.blue.shade600,
          ),
          buildIconUsageExample(
            'Share Content Action',
            'Initiates platform share sheet for content distribution',
            Icons.adaptive.share,
            Colors.blue,
          ),
          buildIconStateCard(
            Icons.adaptive.share,
            'Share Icon States',
            Colors.blue.shade700,
            Colors.grey.shade400,
            Colors.blue.shade400,
          ),

          // Section 6: All Adaptive Icons Comparison
          buildSectionHeader('6. All Adaptive Icons Side by Side'),
          buildPlatformComparisonHeader(),
          buildQuickComparisonRow(
            Icons.adaptive.arrow_back,
            Icons.arrow_back,
            CupertinoIcons.back,
            'Arrow Back',
          ),
          buildQuickComparisonRow(
            Icons.adaptive.flip_camera,
            Icons.flip_camera_android,
            Icons.flip_camera_ios,
            'Flip Camera',
          ),
          buildQuickComparisonRow(
            Icons.adaptive.more,
            Icons.more_vert,
            Icons.more_horiz,
            'More',
          ),
          buildQuickComparisonRow(
            Icons.adaptive.share,
            Icons.share,
            CupertinoIcons.share,
            'Share',
          ),
          buildInfoCard(
            'Platform Detection',
            'Uses Theme.of(context).platform internally',
          ),

          // Section 7: Icons at Different Sizes
          buildSectionHeader('7. Adaptive Icons at Different Sizes'),
          buildSubsectionHeader('Arrow Back Sizing'),
          buildSizedIconRow(
            Icons.adaptive.arrow_back,
            'Arrow Back: 12px to 48px',
            Colors.indigo.shade700,
          ),
          buildSubsectionHeader('Flip Camera Sizing'),
          buildSizedIconRow(
            Icons.adaptive.flip_camera,
            'Flip Camera: 12px to 48px',
            Colors.deepPurple.shade700,
          ),
          buildSubsectionHeader('More Icon Sizing'),
          buildSizedIconRow(
            Icons.adaptive.more,
            'More Icon: 12px to 48px',
            Colors.teal.shade700,
          ),
          buildSubsectionHeader('Share Icon Sizing'),
          buildSizedIconRow(
            Icons.adaptive.share,
            'Share Icon: 12px to 48px',
            Colors.blue.shade700,
          ),
          buildInfoCard(
            'Size Guidelines',
            'Use 24px for standard toolbar icons, 48px for touch targets',
          ),
          buildInfoCard(
            'Accessibility',
            'Minimum recommended touch area is 48x48 logical pixels',
          ),

          // Section 8: Icons with Colors
          buildSectionHeader('8. Adaptive Icons with Different Colors'),
          buildColoredIconGrid(
            Icons.adaptive.arrow_back,
            'Arrow Back Color Palette',
          ),
          buildColoredIconGrid(
            Icons.adaptive.flip_camera,
            'Flip Camera Color Palette',
          ),
          buildColoredIconGrid(
            Icons.adaptive.more,
            'More Icon Color Palette',
          ),
          buildColoredIconGrid(
            Icons.adaptive.share,
            'Share Icon Color Palette',
          ),

          // Section 9: Themed Icon Examples
          buildSectionHeader('9. Themed Adaptive Icons'),
          buildSubsectionHeader('Light Theme Variations'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                buildThemedIconCard(
                  Icons.adaptive.arrow_back,
                  'Primary',
                  Colors.blue.shade600,
                  Colors.white,
                  Colors.grey.shade800,
                ),
                buildThemedIconCard(
                  Icons.adaptive.flip_camera,
                  'Secondary',
                  Colors.purple.shade600,
                  Colors.white,
                  Colors.grey.shade800,
                ),
                buildThemedIconCard(
                  Icons.adaptive.more,
                  'Surface',
                  Colors.grey.shade700,
                  Colors.white,
                  Colors.grey.shade800,
                ),
                buildThemedIconCard(
                  Icons.adaptive.share,
                  'Accent',
                  Colors.teal.shade600,
                  Colors.white,
                  Colors.grey.shade800,
                ),
              ],
            ),
          ),
          buildSubsectionHeader('Dark Theme Variations'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                buildThemedIconCard(
                  Icons.adaptive.arrow_back,
                  'Primary',
                  Colors.blue.shade300,
                  Colors.grey.shade900,
                  Colors.white,
                ),
                buildThemedIconCard(
                  Icons.adaptive.flip_camera,
                  'Secondary',
                  Colors.purple.shade300,
                  Colors.grey.shade900,
                  Colors.white,
                ),
                buildThemedIconCard(
                  Icons.adaptive.more,
                  'Surface',
                  Colors.grey.shade400,
                  Colors.grey.shade900,
                  Colors.white,
                ),
                buildThemedIconCard(
                  Icons.adaptive.share,
                  'Accent',
                  Colors.teal.shade300,
                  Colors.grey.shade900,
                  Colors.white,
                ),
              ],
            ),
          ),
          buildSubsectionHeader('Brand Theme Variations'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                buildThemedIconCard(
                  Icons.adaptive.arrow_back,
                  'Indigo',
                  Colors.indigo.shade600,
                  Colors.indigo.shade50,
                  Colors.indigo.shade900,
                ),
                buildThemedIconCard(
                  Icons.adaptive.flip_camera,
                  'Amber',
                  Colors.amber.shade700,
                  Colors.amber.shade50,
                  Colors.amber.shade900,
                ),
                buildThemedIconCard(
                  Icons.adaptive.more,
                  'Cyan',
                  Colors.cyan.shade700,
                  Colors.cyan.shade50,
                  Colors.cyan.shade900,
                ),
                buildThemedIconCard(
                  Icons.adaptive.share,
                  'Pink',
                  Colors.pink.shade600,
                  Colors.pink.shade50,
                  Colors.pink.shade900,
                ),
              ],
            ),
          ),

          // Section 10: Icon Button Integration
          buildSectionHeader('10. Adaptive Icons in Buttons'),
          buildIconButtonExample(
            Icons.adaptive.arrow_back,
            'Navigate Back Button',
            Colors.indigo.shade700,
          ),
          buildIconButtonExample(
            Icons.adaptive.flip_camera,
            'Toggle Camera Button',
            Colors.deepPurple.shade700,
          ),
          buildIconButtonExample(
            Icons.adaptive.more,
            'More Options Button',
            Colors.teal.shade700,
          ),
          buildIconButtonExample(
            Icons.adaptive.share,
            'Share Content Button',
            Colors.blue.shade700,
          ),
          buildInfoCard(
            'Button Usage',
            'IconButton provides proper touch feedback and accessibility',
          ),

          // Section 11: Real-world Usage Scenarios
          buildSectionHeader('11. Real-World Usage Scenarios'),
          buildIconUsageExample(
            'App Bar Navigation',
            'Leading icon for standard back navigation pattern',
            Icons.adaptive.arrow_back,
            Colors.indigo,
          ),
          buildIconUsageExample(
            'Camera Application',
            'Front/rear camera toggle in photo and video apps',
            Icons.adaptive.flip_camera,
            Colors.deepPurple,
          ),
          buildIconUsageExample(
            'Overflow Actions',
            'Secondary actions menu in toolbars and list items',
            Icons.adaptive.more,
            Colors.teal,
          ),
          buildIconUsageExample(
            'Social Sharing',
            'Share sheets for content distribution across apps',
            Icons.adaptive.share,
            Colors.blue,
          ),

          // Summary Section
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade700, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.shade300,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Adaptive Icons Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.greenAccent, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Icons.adaptive.arrow_back - Platform-aware navigation',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.greenAccent, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Icons.adaptive.flip_camera - Platform-aware camera toggle',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.greenAccent, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Icons.adaptive.more - Platform-aware overflow menu',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.greenAccent, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Icons.adaptive.share - Platform-aware share action',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.white70, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Use Icons.adaptive.* for cross-platform consistency with native feel',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32),
        ],
      ),
    ),
  );
}
