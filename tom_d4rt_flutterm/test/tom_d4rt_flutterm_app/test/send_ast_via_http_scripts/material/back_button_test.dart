// ignore_for_file: avoid_print
// D4rt test script: Tests BackButton from material
// Demonstrates BackButton widget in app bars, standalone, with different styles
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.cyan.shade800,
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

// Helper to build a simulated app bar with BackButton
Widget buildAppBarWithBackButton(
  String title,
  Color backgroundColor,
  Color foregroundColor, {
  double elevation = 4,
  bool showBackButton = true,
  List<IconData> actions = const [],
  String? subtitle,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: subtitle != null ? 64 : 56,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (showBackButton) ...[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: BackButton(color: foregroundColor),
              ),
              SizedBox(width: 4),
            ] else
              SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: foregroundColor,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: foregroundColor.withAlpha(180),
                      ),
                    ),
                ],
              ),
            ),
            ...actions.map(
              (a) => Padding(
                padding: EdgeInsets.only(left: 4),
                child: IconButton(
                  icon: Icon(a, color: foregroundColor),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper to build a standalone back button with label
Widget buildStandaloneBackButton(
  String label,
  Color color,
  Color bgColor,
  double size, {
  String? tooltip,
  bool isEnabled = true,
}) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: size + 16,
            height: size + 16,
            decoration: BoxDecoration(
              color: isEnabled ? bgColor : Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: BackButton(color: isEnabled ? color : Colors.grey.shade400),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                if (tooltip != null)
                  Text(
                    'Tooltip: "$tooltip"',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                Text(
                  isEnabled ? 'Enabled' : 'Disabled',
                  style: TextStyle(
                    fontSize: 12,
                    color: isEnabled
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper to build a navigation flow visual
Widget buildNavigationFlow(List<Map<String, dynamic>> screens, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Navigation Flow',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(screens.length * 2 - 1, (index) {
              if (index.isOdd) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, size: 20, color: color),
                );
              }
              Map<String, dynamic> screen = screens[index ~/ 2];
              bool isFirst = index == 0;
              return Container(
                width: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withAlpha(80)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (!isFirst)
                          Icon(Icons.arrow_back, size: 14, color: color)
                        else
                          Icon(
                            Icons.menu,
                            size: 14,
                            color: Colors.grey.shade400,
                          ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            screen['title'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Icon(
                          screen['icon'] as IconData,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

// Helper to build a themed back button card
Widget buildThemedBackButton(
  ThemeData theme,
  String themeName,
  String description,
) {
  return Theme(
    data: theme,
    child: Builder(
      builder: (BuildContext ctx) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: BackButton(
                    color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        themeName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// Helper to build a back button with different icon styles
Widget buildBackButtonVariant(
  String label,
  IconData icon,
  Color color,
  Color bgColor,
  double iconSize,
  double containerSize,
  BoxDecoration decoration,
) {
  return Container(
    margin: EdgeInsets.all(4),
    child: Column(
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          decoration: decoration,
          child: Center(
            child: Icon(icon, color: color, size: iconSize),
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

// Helper to build a contextual back button scenario
Widget buildContextScenario(
  String scenarioTitle,
  String description,
  IconData backIcon,
  Color appBarColor,
  Color iconColor,
  String appBarTitle,
  List<Widget> contentWidgets,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 12),
          color: appBarColor,
          child: Row(
            children: [
              Icon(backIcon, color: iconColor, size: 22),
              SizedBox(width: 12),
              Text(
                appBarTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          color: Colors.grey.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scenarioTitle,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8),
              ...contentWidgets,
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== BackButton Test Script ===');
  debugPrint('Testing BackButton widget in various contexts');
  debugPrint(
    'BackButton is a material widget that shows a platform-aware back icon',
  );

  TargetPlatform platform = Theme.of(context).platform;
  debugPrint('Platform: $platform');

  ThemeData blueTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );
  ThemeData greenTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
  );
  ThemeData purpleTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
    useMaterial3: true,
  );
  ThemeData orangeTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    useMaterial3: true,
  );
  ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );

  debugPrint('Building BackButton demonstrations...');

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
              colors: [Colors.cyan.shade800, Colors.blue.shade600],
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
                  BackButton(color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'BackButton Demo',
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
                'Material BackButton in different contexts and themes',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: BackButton in App Bars
        buildSectionHeader('1. BackButton in App Bars'),
        buildAppBarWithBackButton(
          'Material Blue',
          Colors.blue,
          Colors.white,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildAppBarWithBackButton(
          'Deep Purple',
          Colors.deepPurple,
          Colors.white,
          actions: [Icons.share],
        ),
        buildAppBarWithBackButton(
          'Surface Light',
          Colors.white,
          Colors.black87,
          elevation: 1,
          actions: [Icons.settings],
        ),
        buildAppBarWithBackButton(
          'Dark',
          Colors.grey.shade900,
          Colors.white,
          actions: [Icons.edit],
        ),
        buildAppBarWithBackButton(
          'Teal',
          Colors.teal,
          Colors.white,
          subtitle: 'With subtitle',
        ),
        buildAppBarWithBackButton(
          'Orange',
          Colors.orange.shade800,
          Colors.white,
        ),
        buildAppBarWithBackButton(
          'No Back Button',
          Colors.blue,
          Colors.white,
          showBackButton: false,
          actions: [Icons.menu],
        ),

        // Section 2: Standalone Variants
        buildSectionHeader('2. Standalone BackButton Variants'),
        buildStandaloneBackButton(
          'Default Back Button',
          Colors.black87,
          Colors.grey.shade100,
          24,
        ),
        buildStandaloneBackButton(
          'Blue Back Button',
          Colors.blue.shade700,
          Colors.blue.shade50,
          24,
        ),
        buildStandaloneBackButton(
          'Large Back Button',
          Colors.green.shade700,
          Colors.green.shade50,
          32,
        ),
        buildStandaloneBackButton(
          'Small Back Button',
          Colors.purple.shade700,
          Colors.purple.shade50,
          20,
        ),
        buildStandaloneBackButton(
          'Disabled Back Button',
          Colors.grey,
          Colors.grey.shade200,
          24,
          isEnabled: false,
        ),
        buildStandaloneBackButton(
          'Custom Tooltip',
          Colors.orange.shade700,
          Colors.orange.shade50,
          24,
          tooltip: 'Go back',
        ),

        // Section 3: Themed BackButtons
        buildSectionHeader('3. Themed BackButton'),
        buildThemedBackButton(
          blueTheme,
          'Blue Theme',
          'BackButton follows theme primary color',
        ),
        buildThemedBackButton(
          greenTheme,
          'Green Theme',
          'Nature-inspired back navigation',
        ),
        buildThemedBackButton(
          purpleTheme,
          'Purple Theme',
          'Bold purple navigation',
        ),
        buildThemedBackButton(
          orangeTheme,
          'Orange Theme',
          'Warm navigation palette',
        ),
        buildThemedBackButton(
          darkTheme,
          'Dark Theme',
          'Dark mode back navigation',
        ),

        // Section 4: Navigation Flows
        buildSectionHeader('4. Navigation Flow Scenarios'),
        buildNavigationFlow([
          {'title': 'Home', 'icon': Icons.home},
          {'title': 'Products', 'icon': Icons.store},
          {'title': 'Product Detail', 'icon': Icons.info},
          {'title': 'Reviews', 'icon': Icons.star},
        ], Colors.blue.shade700),
        buildNavigationFlow([
          {'title': 'Settings', 'icon': Icons.settings},
          {'title': 'Account', 'icon': Icons.person},
          {'title': 'Security', 'icon': Icons.lock},
        ], Colors.green.shade700),
        buildNavigationFlow([
          {'title': 'Inbox', 'icon': Icons.inbox},
          {'title': 'Message', 'icon': Icons.email},
          {'title': 'Attachments', 'icon': Icons.attach_file},
        ], Colors.orange.shade700),

        // Section 5: Back Button Variant Styles
        buildSectionHeader('5. Visual Variant Styles'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildBackButtonVariant(
                'Filled Circle',
                Icons.arrow_back,
                Colors.white,
                Colors.blue,
                24,
                48,
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              ),
              buildBackButtonVariant(
                'Outlined Circle',
                Icons.arrow_back,
                Colors.blue,
                Colors.white,
                24,
                48,
                BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
              ),
              buildBackButtonVariant(
                'Rounded Square',
                Icons.arrow_back,
                Colors.green,
                Colors.green.shade50,
                24,
                48,
                BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
              ),
              buildBackButtonVariant(
                'Shadow',
                Icons.arrow_back,
                Colors.purple,
                Colors.white,
                24,
                48,
                BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withAlpha(60),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              buildBackButtonVariant(
                'Gradient',
                Icons.arrow_back,
                Colors.white,
                Colors.orange,
                24,
                48,
                BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
                  shape: BoxShape.circle,
                ),
              ),
              buildBackButtonVariant(
                'Flat',
                Icons.arrow_back,
                Colors.grey.shade700,
                Colors.transparent,
                24,
                48,
                BoxDecoration(),
              ),
            ],
          ),
        ),

        // Section 6: Context Scenarios
        buildSectionHeader('6. Context Scenarios'),
        buildContextScenario(
          'Detail Page',
          'User navigates to a detail view from a list',
          Icons.arrow_back,
          Colors.blue,
          Colors.white,
          'Product Details',
          [
            Container(
              height: 40,
              color: Colors.grey.shade100,
              child: Center(child: Text('Product content area')),
            ),
          ],
        ),
        buildContextScenario(
          'Modal / Full-Screen Dialog',
          'Close button instead of back arrow for dialogs',
          Icons.close,
          Colors.white,
          Colors.black87,
          'Edit Profile',
          [
            Container(
              height: 40,
              color: Colors.grey.shade100,
              child: Center(child: Text('Form fields area')),
            ),
          ],
        ),
        buildContextScenario(
          'Nested Navigation',
          'Deep navigation stack with back button',
          Icons.arrow_back,
          Colors.teal,
          Colors.white,
          'Settings > Security > 2FA',
          [
            Container(
              height: 40,
              color: Colors.grey.shade100,
              child: Center(child: Text('2FA settings')),
            ),
          ],
        ),

        // Section 7: BackButton with text label
        buildSectionHeader('7. BackButton with Text Label'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BackButton(color: Colors.blue.shade700),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BackButton(color: Colors.green.shade700),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BackButton(color: Colors.orange.shade700),
                    Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Section 8: Actual BackButton Widget
        buildSectionHeader('8. Live BackButton Widgets'),
        Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Actual BackButton widgets rendered:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    BackButton(color: Colors.blue),
                    SizedBox(width: 8),
                    BackButton(color: Colors.red),
                    SizedBox(width: 8),
                    BackButton(color: Colors.green),
                    SizedBox(width: 8),
                    BackButton(color: Colors.orange),
                    SizedBox(width: 8),
                    BackButton(color: Colors.purple),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'These are real BackButton widgets with color parameter.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of BackButton Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
