// D4rt test script: Tests CloseButton from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1565C0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper to build a labeled demo card
Widget buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper: a simple info row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Color(0xFF616161),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF212121)),
          ),
        ),
      ],
    ),
  );
}

// Helper: colored background context
Widget buildColoredContext(Color bgColor, String label, Widget child) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        child,
      ],
    ),
  );
}

// Helper: build an AppBar simulation with CloseButton
Widget buildAppBarWithClose(String title, Color barColor) {
  return Container(
    height: 56,
    padding: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: barColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        CloseButton(),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        Icon(Icons.more_vert, color: Color(0xFFFFFFFF)),
      ],
    ),
  );
}

// Helper: build a dialog simulation with CloseButton
Widget buildDialogSimulation(String title, String content) {
  return Container(
    width: 300,
    padding: EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0x4D000000),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CloseButton(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            content,
            style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}

// Helper: build a card with close button in corner
Widget buildCardWithClose(String title, String body, Color accentColor) {
  return Container(
    width: 280,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 12, top: 2, bottom: 2, right: 0),
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              CloseButton(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            body,
            style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
          ),
        ),
      ],
    ),
  );
}

// Helper: build a comparison row
Widget buildButtonComparisonRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          CloseButton(),
          SizedBox(height: 4),
          Text('CloseButton', style: TextStyle(fontSize: 11)),
        ],
      ),
      Column(
        children: [
          BackButton(),
          SizedBox(height: 4),
          Text('BackButton', style: TextStyle(fontSize: 11)),
        ],
      ),
      Column(
        children: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              debugPrint('Custom IconButton close pressed');
            },
          ),
          SizedBox(height: 4),
          Text('IconButton(close)', style: TextStyle(fontSize: 11)),
        ],
      ),
      Column(
        children: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              debugPrint('Cancel button pressed');
            },
          ),
          SizedBox(height: 4),
          Text('IconButton(cancel)', style: TextStyle(fontSize: 11)),
        ],
      ),
    ],
  );
}

// Helper: themed CloseButton
Widget buildThemedCloseButton(Color iconColor, Color bgColor, String label) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Theme(
          data: ThemeData(
            iconTheme: IconThemeData(color: iconColor),
          ),
          child: CloseButton(),
        ),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
    ],
  );
}

// Helper: notification panel with close
Widget buildNotificationPanel(String message, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.only(left: 12, top: 4, bottom: 4, right: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: Color(0xFFFFFFFF), size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
          ),
        ),
        CloseButton(),
      ],
    ),
  );
}

// Helper: tab-like close button
Widget buildTabWithClose(String tabLabel, bool isActive) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: isActive ? Color(0xFFFFFFFF) : Color(0xFFE0E0E0),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      border: isActive
          ? Border(
              top: BorderSide(color: Color(0xFF1976D2), width: 2),
              left: BorderSide(color: Color(0xFFBDBDBD), width: 1),
              right: BorderSide(color: Color(0xFFBDBDBD), width: 1),
            )
          : Border.all(color: Color(0xFFBDBDBD), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tabLabel,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? Color(0xFF1976D2) : Color(0xFF757575),
          ),
        ),
        SizedBox(width: 4),
        SizedBox(
          width: 20,
          height: 20,
          child: CloseButton(),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CloseButton Deep Demo ===');
  debugPrint('Testing CloseButton in various contexts and configurations');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('CloseButton Deep Demo'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic CloseButton
            buildSectionHeader('1. Basic CloseButton'),
            buildDemoCard(
              'Default CloseButton',
              Center(child: CloseButton()),
            ),
            buildInfoRow('Widget', 'CloseButton()'),
            buildInfoRow('Behavior', 'Calls Navigator.maybePop by default'),
            buildInfoRow('Icon', 'Icons.close'),
            Text('Section 1: Basic CloseButton rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 2: CloseButton vs Other Buttons Comparison
            buildSectionHeader('2. Button Comparison'),
            buildDemoCard(
              'CloseButton vs BackButton vs IconButton',
              buildButtonComparisonRow(),
            ),
            buildInfoRow('CloseButton', 'Uses Icons.close, calls maybePop'),
            buildInfoRow('BackButton', 'Uses Icons.arrow_back, calls maybePop'),
            buildInfoRow('IconButton', 'Custom icon with custom callback'),
            Text('Section 2: Button comparison rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 3: CloseButton in AppBar
            buildSectionHeader('3. CloseButton in AppBars'),
            buildDemoCard(
              'Blue AppBar with CloseButton',
              buildAppBarWithClose('Settings', Color(0xFF1565C0)),
            ),
            SizedBox(height: 8),
            buildDemoCard(
              'Red AppBar with CloseButton',
              buildAppBarWithClose('Alert Details', Color(0xFFC62828)),
            ),
            SizedBox(height: 8),
            buildDemoCard(
              'Green AppBar with CloseButton',
              buildAppBarWithClose('Success Panel', Color(0xFF2E7D32)),
            ),
            SizedBox(height: 8),
            buildDemoCard(
              'Purple AppBar with CloseButton',
              buildAppBarWithClose('Profile', Color(0xFF6A1B9A)),
            ),
            SizedBox(height: 8),
            buildDemoCard(
              'Orange AppBar with CloseButton',
              buildAppBarWithClose('Notifications', Color(0xFFE65100)),
            ),
            Text('Section 3: AppBar variants rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 4: CloseButton in Dialogs
            buildSectionHeader('4. CloseButton in Dialog Simulations'),
            buildDemoCard(
              'Simple Dialog with Close',
              Center(
                child: buildDialogSimulation(
                  'Confirm Action',
                  'Are you sure you want to proceed? This action cannot be undone.',
                ),
              ),
            ),
            SizedBox(height: 8),
            buildDemoCard(
              'Info Dialog with Close',
              Center(
                child: buildDialogSimulation(
                  'Information',
                  'Your settings have been saved successfully. You can close this dialog.',
                ),
              ),
            ),
            Text('Section 4: Dialog simulations rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 5: CloseButton in Cards
            buildSectionHeader('5. CloseButton in Cards'),
            buildDemoCard(
              'Colored Cards with Close',
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  buildCardWithClose(
                    'Task Complete',
                    'The build process finished successfully.',
                    Color(0xFF4CAF50),
                  ),
                  buildCardWithClose(
                    'Warning',
                    'Memory usage is high. Consider optimizing.',
                    Color(0xFFF57C00),
                  ),
                  buildCardWithClose(
                    'Error Report',
                    'Failed to connect to the database.',
                    Color(0xFFD32F2F),
                  ),
                  buildCardWithClose(
                    'New Feature',
                    'Dark mode is now available in settings.',
                    Color(0xFF7B1FA2),
                  ),
                ],
              ),
            ),
            Text('Section 5: Cards with close buttons rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 6: Themed CloseButton
            buildSectionHeader('6. Themed CloseButton Variants'),
            buildDemoCard(
              'Custom Themed CloseButtons',
              Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  buildThemedCloseButton(
                    Color(0xFFFFFFFF),
                    Color(0xFFD32F2F),
                    'Red bg',
                  ),
                  buildThemedCloseButton(
                    Color(0xFFFFFFFF),
                    Color(0xFF1976D2),
                    'Blue bg',
                  ),
                  buildThemedCloseButton(
                    Color(0xFFFFFFFF),
                    Color(0xFF388E3C),
                    'Green bg',
                  ),
                  buildThemedCloseButton(
                    Color(0xFF212121),
                    Color(0xFFFFC107),
                    'Yellow bg',
                  ),
                  buildThemedCloseButton(
                    Color(0xFFFFFFFF),
                    Color(0xFF7B1FA2),
                    'Purple bg',
                  ),
                  buildThemedCloseButton(
                    Color(0xFFFFFFFF),
                    Color(0xFF00796B),
                    'Teal bg',
                  ),
                  buildThemedCloseButton(
                    Color(0xFF212121),
                    Color(0xFFE0E0E0),
                    'Grey bg',
                  ),
                  buildThemedCloseButton(
                    Color(0xFFFFFFFF),
                    Color(0xFF212121),
                    'Dark bg',
                  ),
                ],
              ),
            ),
            Text('Section 6: Themed close buttons rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 7: CloseButton in Notification Panels
            buildSectionHeader('7. Notification Panels with Close'),
            buildDemoCard(
              'Dismissible Notifications',
              Column(
                children: [
                  buildNotificationPanel(
                    'Build completed successfully',
                    Color(0xFF43A047),
                  ),
                  buildNotificationPanel(
                    'Warning: Disk space running low',
                    Color(0xFFF4511E),
                  ),
                  buildNotificationPanel(
                    'New update available: v2.5.0',
                    Color(0xFF1E88E5),
                  ),
                  buildNotificationPanel(
                    'Connection timeout - retrying...',
                    Color(0xFFFF8F00),
                  ),
                  buildNotificationPanel(
                    'Deployment to staging in progress',
                    Color(0xFF8E24AA),
                  ),
                ],
              ),
            ),
            Text('Section 7: Notification panels rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 8: CloseButton in Tab-like Context
            buildSectionHeader('8. CloseButton in Tabs'),
            buildDemoCard(
              'Tab Bar with Closeable Tabs',
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(left: 4, right: 4, top: 4),
                child: Row(
                  children: [
                    buildTabWithClose('main.dart', true),
                    SizedBox(width: 2),
                    buildTabWithClose('utils.dart', false),
                    SizedBox(width: 2),
                    buildTabWithClose('README.md', false),
                    SizedBox(width: 2),
                    buildTabWithClose('test.dart', false),
                  ],
                ),
              ),
            ),
            Text('Section 8: Tab close buttons rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 9: Size Variations
            buildSectionHeader('9. CloseButton Size Variations'),
            buildDemoCard(
              'Different Sizes via SizedBox',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CloseButton(),
                      ),
                      SizedBox(height: 4),
                      Text('24x24', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: CloseButton(),
                      ),
                      SizedBox(height: 4),
                      Text('32x32', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: CloseButton(),
                      ),
                      SizedBox(height: 4),
                      Text('48x48 (default)', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: CloseButton(),
                      ),
                      SizedBox(height: 4),
                      Text('64x64', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            Text('Section 9: Size variations rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 10: CloseButton on Different Backgrounds
            buildSectionHeader('10. CloseButton on Backgrounds'),
            buildDemoCard(
              'Different Background Colors',
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  buildColoredContext(Color(0xFF263238), 'Dark Grey', CloseButton()),
                  buildColoredContext(Color(0xFF0D47A1), 'Deep Blue', CloseButton()),
                  buildColoredContext(Color(0xFFB71C1C), 'Deep Red', CloseButton()),
                  buildColoredContext(Color(0xFF1B5E20), 'Deep Green', CloseButton()),
                  buildColoredContext(Color(0xFF4A148C), 'Deep Purple', CloseButton()),
                  buildColoredContext(Color(0xFF004D40), 'Deep Teal', CloseButton()),
                ],
              ),
            ),
            Text('Section 10: Background variations rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 11: CloseButton with Custom onPressed
            buildSectionHeader('11. CloseButton with Custom Actions'),
            buildDemoCard(
              'CloseButton with custom onPressed callbacks',
              Column(
                children: [
                  Row(
                    children: [
                      CloseButton(
                        onPressed: () {
                          debugPrint('Close: Saving state before closing');
                        },
                      ),
                      SizedBox(width: 8),
                      Text('Save and close'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CloseButton(
                        onPressed: () {
                          debugPrint('Close: Discarding changes');
                        },
                      ),
                      SizedBox(width: 8),
                      Text('Discard and close'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CloseButton(
                        onPressed: () {
                          debugPrint('Close: Prompting confirmation');
                        },
                      ),
                      SizedBox(width: 8),
                      Text('Confirm before closing'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CloseButton(
                        onPressed: () {
                          debugPrint('Close: Logging analytics event');
                        },
                      ),
                      SizedBox(width: 8),
                      Text('Log analytics and close'),
                    ],
                  ),
                ],
              ),
            ),
            Text('Section 11: Custom action close buttons rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 12: CloseButton in Complex Layouts
            buildSectionHeader('12. Complex Layout Integration'),
            buildDemoCard(
              'Sidebar Panel Simulation',
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFBDBDBD)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFF37474F),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 12, right: 2),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Explorer',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    iconTheme: IconThemeData(color: Color(0xFFB0BEC5)),
                                  ),
                                  child: CloseButton(),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Color(0xFF546E7A), height: 1),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('src/', style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 12)),
                                Text('  main.dart', style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 12)),
                                Text('  utils.dart', style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 12)),
                                Text('test/', style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 12)),
                                Text('  test.dart', style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Editor Area',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'The sidebar can be closed with the CloseButton in the top-right corner.',
                              style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text('Section 12: Complex layout rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'CloseButton Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'Basic default CloseButton'),
                  buildInfoRow('2', 'Comparison with BackButton and IconButton'),
                  buildInfoRow('3', 'CloseButton in colored AppBars'),
                  buildInfoRow('4', 'CloseButton in dialog headers'),
                  buildInfoRow('5', 'CloseButton in dismissible cards'),
                  buildInfoRow('6', 'Theme-colored close button variants'),
                  buildInfoRow('7', 'Notification panel dismissal'),
                  buildInfoRow('8', 'Tab close button simulation'),
                  buildInfoRow('9', 'Size variations'),
                  buildInfoRow('10', 'Different background contexts'),
                  buildInfoRow('11', 'Custom onPressed callbacks'),
                  buildInfoRow('12', 'Complex layout integration'),
                ],
              ),
            ),
            Text('=== CloseButton Deep Demo Complete ===', style: TextStyle(fontSize: 10, color: Colors.grey)),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
