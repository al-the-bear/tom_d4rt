// D4rt test script: Tests PlatformAdaptiveIcons from material
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

Widget buildIconShowcase(
  String label,
  IconData materialIcon,
  IconData cupertinoIcon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Icon(materialIcon, size: 28, color: Colors.green.shade700),
              SizedBox(height: 4),
              Text(
                'Android',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Icon(cupertinoIcon, size: 28, color: Colors.blue.shade700),
              SizedBox(height: 4),
              Text(
                'iOS',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPlatformAdaptiveIcon(
  String label,
  IconData androidIcon,
  IconData iosIcon,
  Color iconColor,
  double iconSize,
) {
  print('Building platform adaptive icon: $label');
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(androidIcon, size: iconSize, color: iconColor),
          ),
        ),
        SizedBox(width: 12),
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
                'Adapts icon based on platform',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(iosIcon, size: iconSize, color: Colors.blue.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildIconComparisonRow(
  String name,
  IconData androidIcon,
  IconData iosIcon,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(androidIcon, size: 24, color: Colors.green.shade800),
                SizedBox(width: 8),
                Text(
                  'Material',
                  style: TextStyle(fontSize: 11, color: Colors.green.shade700),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iosIcon, size: 24, color: Colors.blue.shade800),
                SizedBox(width: 8),
                Text(
                  'Cupertino',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildThemedAdaptiveIcon(
  String label,
  IconData icon,
  Color backgroundColor,
  Color foregroundColor,
  double size,
) {
  return Container(
    width: 80,
    margin: EdgeInsets.all(6),
    child: Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withAlpha(100),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(icon, size: size, color: foregroundColor),
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget buildSizedIconPreview(IconData icon, double size, String label) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Column(
      children: [
        Container(
          width: size + 20,
          height: size + 20,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Icon(icon, size: size, color: Colors.indigo.shade700),
          ),
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

Widget buildInteractiveIconShowcase(
  String title,
  IconData primaryIcon,
  IconData secondaryIcon,
  String description,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.shade100,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(primaryIcon, size: 32, color: Colors.indigo.shade700),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
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
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                secondaryIcon,
                size: 24,
                color: Colors.purple.shade700,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildPlatformDetectionConcept(
  String platform,
  List<Map<String, dynamic>> icons,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: platform == 'Android' ? Colors.green.shade50 : Colors.blue.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: platform == 'Android'
            ? Colors.green.shade300
            : Colors.blue.shade300,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              platform == 'Android' ? Icons.android : Icons.apple,
              size: 24,
              color: platform == 'Android'
                  ? Colors.green.shade700
                  : Colors.grey.shade700,
            ),
            SizedBox(width: 8),
            Text(
              '$platform Platform',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: platform == 'Android'
                    ? Colors.green.shade800
                    : Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: icons.map((iconData) {
            IconData iconValue = iconData['icon'] as IconData;
            String labelValue = iconData['label'] as String;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(iconValue, size: 20),
                  SizedBox(width: 6),
                  Text(labelValue, style: TextStyle(fontSize: 12)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PlatformAdaptiveIcons deep demo test executing');
  print('Testing platform-adaptive icons across iOS and Android');

  return Scaffold(
    appBar: AppBar(
      title: Text('PlatformAdaptiveIcons Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Overview
          buildSectionHeader('1. Platform-Adaptive Icons Overview'),
          buildInfoCard(
            'Concept',
            'Icons that automatically adapt to platform conventions',
          ),
          buildInfoCard(
            'Android',
            'Uses Material Design icons with sharp, geometric shapes',
          ),
          buildInfoCard(
            'iOS',
            'Uses Cupertino-style icons with rounded, softer appearance',
          ),
          buildInfoCard(
            'Benefit',
            'Consistent UX across platforms without manual switching',
          ),
          buildInfoCard(
            'Implementation',
            'Uses Theme.of(context).platform for detection',
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.amber.shade700),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Platform-adaptive icons improve user familiarity and perceived quality',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Section 2: Arrow Icons
          buildSectionHeader('2. Arrow Icons (Back, Forward)'),
          buildPlatformAdaptiveIcon(
            'Back Arrow',
            Icons.arrow_back,
            Icons.arrow_back_ios,
            Colors.indigo,
            28,
          ),
          buildPlatformAdaptiveIcon(
            'Forward Arrow',
            Icons.arrow_forward,
            Icons.arrow_forward_ios,
            Colors.teal,
            28,
          ),
          buildPlatformAdaptiveIcon(
            'Back Navigation',
            Icons.arrow_back_rounded,
            Icons.chevron_left,
            Colors.purple,
            28,
          ),
          buildPlatformAdaptiveIcon(
            'Forward Navigation',
            Icons.arrow_forward_rounded,
            Icons.chevron_right,
            Colors.orange,
            28,
          ),
          buildInfoCard(
            'Design Note',
            'Android uses full arrows, iOS uses chevrons',
          ),

          // Section 3: Share Icon Adaptation
          buildSectionHeader('3. Share Icon Adaptation'),
          buildPlatformAdaptiveIcon(
            'Share Action',
            Icons.share,
            Icons.ios_share,
            Colors.blue,
            28,
          ),
          buildPlatformAdaptiveIcon(
            'Share Outlined',
            Icons.share_outlined,
            Icons.ios_share_outlined,
            Colors.cyan,
            28,
          ),
          buildIconShowcase('Share Primary', Icons.share, Icons.ios_share),
          buildIconShowcase(
            'Share Alt',
            Icons.share_outlined,
            Icons.ios_share_outlined,
          ),
          buildInfoCard(
            'Android Share',
            'Three connected dots forming a share network',
          ),
          buildInfoCard(
            'iOS Share',
            'Box with upward arrow representing export',
          ),

          // Section 4: More Icon Adaptation
          buildSectionHeader('4. More Icon (Vertical/Horizontal Dots)'),
          buildPlatformAdaptiveIcon(
            'More Options (Vertical)',
            Icons.more_vert,
            Icons.more_horiz,
            Colors.grey.shade700,
            28,
          ),
          buildPlatformAdaptiveIcon(
            'More Options (Horizontal)',
            Icons.more_horiz,
            Icons.more_horiz_rounded,
            Colors.blueGrey,
            28,
          ),
          buildIconShowcase('More Vertical', Icons.more_vert, Icons.more_horiz),
          buildIconShowcase(
            'More Rounded',
            Icons.more_vert_rounded,
            Icons.more_horiz_rounded,
          ),
          Container(
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
                  'Platform Conventions:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.android, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Android: Vertical three-dot menu'),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.apple, color: Colors.grey.shade700),
                    SizedBox(width: 8),
                    Text('iOS: Horizontal ellipsis'),
                  ],
                ),
              ],
            ),
          ),

          // Section 5: Flip Camera Icon
          buildSectionHeader('5. Flip Camera Icon'),
          buildPlatformAdaptiveIcon(
            'Camera Flip',
            Icons.flip_camera_android,
            Icons.flip_camera_ios,
            Colors.deepPurple,
            28,
          ),
          buildPlatformAdaptiveIcon(
            'Camera Front',
            Icons.camera_front,
            Icons.camera_front_outlined,
            Colors.pink,
            28,
          ),
          buildPlatformAdaptiveIcon(
            'Camera Switch',
            Icons.cameraswitch,
            Icons.cameraswitch_outlined,
            Colors.amber.shade700,
            28,
          ),
          buildIconShowcase(
            'Flip Camera',
            Icons.flip_camera_android,
            Icons.flip_camera_ios,
          ),
          buildInfoCard(
            'Usage',
            'Common in camera apps for selfie/rear camera switching',
          ),

          // Section 6: Icon Comparison Grid
          buildSectionHeader('6. Icon Comparison Grid'),
          buildIconComparisonRow(
            'Back',
            Icons.arrow_back,
            Icons.arrow_back_ios,
          ),
          buildIconComparisonRow(
            'Forward',
            Icons.arrow_forward,
            Icons.arrow_forward_ios,
          ),
          buildIconComparisonRow('Share', Icons.share, Icons.ios_share),
          buildIconComparisonRow('More', Icons.more_vert, Icons.more_horiz),
          buildIconComparisonRow(
            'Flip',
            Icons.flip_camera_android,
            Icons.flip_camera_ios,
          ),
          buildIconComparisonRow(
            'Settings',
            Icons.settings,
            Icons.settings_outlined,
          ),
          buildIconComparisonRow('Search', Icons.search, Icons.search_outlined),
          buildIconComparisonRow('Home', Icons.home, Icons.home_outlined),
          buildInfoCard(
            'Legend',
            'Left: Material (Android) / Right: Cupertino (iOS)',
          ),

          // Section 7: Themed Adaptive Icons
          buildSectionHeader('7. Themed Adaptive Icons'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                buildThemedAdaptiveIcon(
                  'Primary',
                  Icons.home,
                  Colors.blue.shade600,
                  Colors.white,
                  28,
                ),
                buildThemedAdaptiveIcon(
                  'Success',
                  Icons.check_circle,
                  Colors.green.shade600,
                  Colors.white,
                  28,
                ),
                buildThemedAdaptiveIcon(
                  'Warning',
                  Icons.warning,
                  Colors.orange.shade600,
                  Colors.white,
                  28,
                ),
                buildThemedAdaptiveIcon(
                  'Error',
                  Icons.error,
                  Colors.red.shade600,
                  Colors.white,
                  28,
                ),
                buildThemedAdaptiveIcon(
                  'Info',
                  Icons.info,
                  Colors.cyan.shade600,
                  Colors.white,
                  28,
                ),
                buildThemedAdaptiveIcon(
                  'Neutral',
                  Icons.help,
                  Colors.grey.shade600,
                  Colors.white,
                  28,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                buildThemedAdaptiveIcon(
                  'Dark',
                  Icons.dark_mode,
                  Colors.grey.shade800,
                  Colors.white,
                  28,
                ),
                buildThemedAdaptiveIcon(
                  'Light',
                  Icons.light_mode,
                  Colors.amber.shade400,
                  Colors.white,
                  28,
                ),
                buildThemedAdaptiveIcon(
                  'Auto',
                  Icons.brightness_auto,
                  Colors.purple.shade400,
                  Colors.white,
                  28,
                ),
              ],
            ),
          ),

          // Section 8: Sized Adaptive Icons
          buildSectionHeader('8. Sized Adaptive Icons'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSizedIconPreview(Icons.share, 16, '16px'),
                buildSizedIconPreview(Icons.share, 24, '24px'),
                buildSizedIconPreview(Icons.share, 32, '32px'),
                buildSizedIconPreview(Icons.share, 48, '48px'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSizedIconPreview(Icons.arrow_back, 16, '16px'),
                buildSizedIconPreview(Icons.arrow_back, 24, '24px'),
                buildSizedIconPreview(Icons.arrow_back, 32, '32px'),
                buildSizedIconPreview(Icons.arrow_back, 48, '48px'),
              ],
            ),
          ),
          buildInfoCard(
            'Size Guidelines',
            'Use 24px for standard UI, 48px for touch targets',
          ),
          buildInfoCard(
            'Accessibility',
            'Minimum touch target should be 48x48 logical pixels',
          ),

          // Section 9: Interactive Icon Showcase
          buildSectionHeader('9. Interactive Icon Showcase'),
          buildInteractiveIconShowcase(
            'Navigation Back',
            Icons.arrow_back,
            Icons.arrow_back_ios,
            'Contextual back navigation adapts to platform',
          ),
          buildInteractiveIconShowcase(
            'Share Content',
            Icons.share,
            Icons.ios_share,
            'Share icon follows platform-specific design language',
          ),
          buildInteractiveIconShowcase(
            'Options Menu',
            Icons.more_vert,
            Icons.more_horiz,
            'Menu icon orientation varies by platform convention',
          ),
          buildInteractiveIconShowcase(
            'Camera Toggle',
            Icons.flip_camera_android,
            Icons.flip_camera_ios,
            'Camera flip icon matches platform camera UI patterns',
          ),

          // Section 10: Platform Detection Concept
          buildSectionHeader('10. Platform Detection Concept'),
          buildInfoCard('Detection Method', 'Theme.of(context).platform'),
          buildInfoCard(
            'Platforms',
            'TargetPlatform.android, TargetPlatform.iOS, etc.',
          ),
          buildPlatformDetectionConcept('Android', [
            {'icon': Icons.arrow_back, 'label': 'Back'},
            {'icon': Icons.share, 'label': 'Share'},
            {'icon': Icons.more_vert, 'label': 'More'},
            {'icon': Icons.flip_camera_android, 'label': 'Flip'},
          ]),
          buildPlatformDetectionConcept('iOS', [
            {'icon': Icons.arrow_back_ios, 'label': 'Back'},
            {'icon': Icons.ios_share, 'label': 'Share'},
            {'icon': Icons.more_horiz, 'label': 'More'},
            {'icon': Icons.flip_camera_ios, 'label': 'Flip'},
          ]),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Implementation Pattern',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.indigo.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Icon get backIcon {\n'
                    '  switch (Theme.of(context).platform) {\n'
                    '    case TargetPlatform.iOS:\n'
                    '    case TargetPlatform.macOS:\n'
                    '      return Icons.arrow_back_ios;\n'
                    '    default:\n'
                    '      return Icons.arrow_back;\n'
                    '  }\n'
                    '}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.green.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Summary section
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade600, Colors.purple.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PlatformAdaptiveIcons Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Automatic platform-based icon selection',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Consistent with platform design guidelines',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Improved user familiarity and experience',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Easy integration via Theme.of(context).platform',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    ),
  );
}
