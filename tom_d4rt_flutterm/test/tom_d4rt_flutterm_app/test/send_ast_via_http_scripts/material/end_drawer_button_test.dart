// ignore_for_file: avoid_print
// D4rt test script: Tests EndDrawerButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== EndDrawerButton Visual Demo ===');
  print('Demonstrating EndDrawerButton widget in various Scaffold contexts');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('EndDrawerButton Demo'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('EndDrawerButton in AppBar Context'),
            SizedBox(height: 8),
            _buildAppBarContext(),
            SizedBox(height: 24),
            buildSectionHeader('EndDrawerButton vs DrawerButton Comparison'),
            SizedBox(height: 8),
            _buildDrawerButtonComparison(),
            SizedBox(height: 24),
            buildSectionHeader('EndDrawerButton Styling Variants'),
            SizedBox(height: 8),
            _buildStylingVariants(),
            SizedBox(height: 24),
            buildSectionHeader('Scaffold with EndDrawer Layout'),
            SizedBox(height: 8),
            _buildScaffoldEndDrawerLayout(),
            SizedBox(height: 24),
            buildSectionHeader('Icon and Tooltip Configuration'),
            SizedBox(height: 8),
            _buildIconTooltipConfig(),
            SizedBox(height: 24),
            buildSectionHeader('Themed EndDrawerButton Contexts'),
            SizedBox(height: 8),
            _buildThemedContexts(),
            SizedBox(height: 24),
            buildSectionHeader('EndDrawerButton Placement Guide'),
            SizedBox(height: 8),
            _buildPlacementGuide(),
            SizedBox(height: 24),
            buildSectionHeader('EndDrawerButton Properties Reference'),
            SizedBox(height: 8),
            _buildPropertiesReference(),
            SizedBox(height: 24),
            buildSectionHeader('EndDrawerButton Behavior Flow'),
            SizedBox(height: 8),
            _buildBehaviorFlow(),
            SizedBox(height: 24),
            buildSectionHeader('Visual Size Comparison'),
            SizedBox(height: 8),
            _buildSizeComparison(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
    child: Row(children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(width: 8),
      Expanded(child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey.shade700))),
    ]),
  );
}

Widget _buildAppBarContext() {
  print('Building AppBar context with EndDrawerButton');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AppBar with EndDrawerButton (actions area)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 12),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Color(0xFF1565C0),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 24),
              SizedBox(width: 16),
              Expanded(
                child: Text('My Application',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.menu_open, color: Color(0xFFFFFFFF), size: 24),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.arrow_back, color: Color(0xFF1565C0), size: 16),
            SizedBox(width: 4),
            Text('Leading (DrawerButton)', style: TextStyle(fontSize: 11, color: Color(0xFF1565C0))),
            Expanded(child: SizedBox()),
            Text('Actions (EndDrawerButton)', style: TextStyle(fontSize: 11, color: Color(0xFF1565C0))),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward, color: Color(0xFF1565C0), size: 16),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Position:', 'AppBar actions list (trailing end)'),
        buildInfoCard('Purpose:', 'Opens the end drawer (Scaffold.endDrawer)'),
        buildInfoCard('Auto-added:', 'When Scaffold has an endDrawer and no custom actions'),
      ],
    ),
  );
}

Widget _buildDrawerButtonComparison() {
  print('Building DrawerButton vs EndDrawerButton comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFCC80)),
    ),
    child: Column(
      children: [
        Text('DrawerButton vs EndDrawerButton',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF4CAF50), width: 2),
                ),
                child: Column(
                  children: [
                    Icon(Icons.menu, size: 40, color: Color(0xFF4CAF50)),
                    SizedBox(height: 8),
                    Text('DrawerButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(height: 4),
                    Text('Opens LEFT drawer', style: TextStyle(fontSize: 11, color: Color(0xFF666666))),
                    SizedBox(height: 4),
                    Text('Leading position', style: TextStyle(fontSize: 11, color: Color(0xFF666666))),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('Scaffold.drawer', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              children: [
                Icon(Icons.compare_arrows, color: Color(0xFF757575), size: 24),
                SizedBox(height: 4),
                Text('vs', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2196F3).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF2196F3), width: 2),
                ),
                child: Column(
                  children: [
                    Icon(Icons.menu_open, size: 40, color: Color(0xFF2196F3)),
                    SizedBox(height: 8),
                    Text('EndDrawerButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(height: 4),
                    Text('Opens RIGHT drawer', style: TextStyle(fontSize: 11, color: Color(0xFF666666))),
                    SizedBox(height: 4),
                    Text('Actions position', style: TextStyle(fontSize: 11, color: Color(0xFF666666))),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF2196F3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('Scaffold.endDrawer', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Key Difference:', 'DrawerButton targets Scaffold.drawer, EndDrawerButton targets Scaffold.endDrawer'),
      ],
    ),
  );
}

Widget _buildStylingVariants() {
  print('Building styling variants');
  List<Widget> variants = [];

  variants.add(_buildVariantRow(
    Icons.menu_open, 'Default EndDrawerButton', 'Standard material icon button style',
    Color(0xFFF5F5F5), Color(0xFFE0E0E0), Color(0xFF424242), Color(0xFF424242),
    'DEFAULT', Color(0xFF9E9E9E),
  ));
  variants.add(_buildVariantRow(
    Icons.menu_open, 'Blue Themed', 'Matches blue AppBar theme',
    Color(0xFFE3F2FD), Color(0xFF90CAF9), Color(0xFF1565C0), Color(0xFF42A5F5),
    'BLUE', Color(0xFF1565C0),
  ));
  variants.add(_buildVariantRow(
    Icons.menu_open, 'Dark Theme', 'For dark-themed applications',
    Color(0xFF212121), Color(0xFF424242), Color(0xFFE0E0E0), Color(0xFF9E9E9E),
    'DARK', Color(0xFF616161),
  ));
  variants.add(_buildVariantRow(
    Icons.menu_open, 'Pink Accent', 'Custom accent color theme',
    Color(0xFFFCE4EC), Color(0xFFF48FB1), Color(0xFFE91E63), Color(0xFFF06292),
    'ACCENT', Color(0xFFE91E63),
  ));

  return Column(children: variants);
}

Widget _buildVariantRow(IconData icon, String title, String subtitle,
    Color bgColor, Color borderColor, Color textColor, Color subColor,
    String badge, Color badgeColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: borderColor),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: textColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: textColor),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textColor)),
              Text(subtitle, style: TextStyle(fontSize: 11, color: subColor)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(badge, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

Widget _buildScaffoldEndDrawerLayout() {
  print('Building Scaffold endDrawer layout diagram');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scaffold Layout with EndDrawer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 12),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD), width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF1565C0),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(6)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 16),
                          SizedBox(width: 8),
                          Expanded(child: Text('AppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11))),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(Icons.menu_open, color: Color(0xFFFFFFFF), size: 12),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Color(0xFFFAFAFA),
                        child: Center(
                          child: Text('Body Content', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 2, color: Color(0xFFE0E0E0)),
              Container(
                width: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF283593),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: Color(0xFFFFFFFF), size: 20),
                    SizedBox(height: 4),
                    Text('End', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10)),
                    Text('Drawer', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10)),
                    SizedBox(height: 8),
                    Icon(Icons.arrow_back, color: Color(0xFF90CAF9), size: 14),
                    Text('slides in', style: TextStyle(color: Color(0xFF90CAF9), fontSize: 8)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('EndDrawer:', 'Slides in from the RIGHT side of the screen'),
        buildInfoCard('Trigger:', 'EndDrawerButton or Scaffold.of(context).openEndDrawer()'),
      ],
    ),
  );
}

Widget _buildIconTooltipConfig() {
  print('Building icon and tooltip configuration');
  List<Widget> configs = [];

  configs.add(_buildConfigRow(Icons.menu_open, 'Default Icon', 'Icons.menu_open', Color(0xFF424242), 'Open navigation menu'));
  configs.add(_buildConfigRow(Icons.settings, 'Settings Drawer', 'Icons.settings', Color(0xFF1565C0), 'Open settings'));
  configs.add(_buildConfigRow(Icons.filter_list, 'Filter Drawer', 'Icons.filter_list', Color(0xFF00897B), 'Open filters'));
  configs.add(_buildConfigRow(Icons.notifications, 'Notification Drawer', 'Icons.notifications', Color(0xFFE65100), 'View notifications'));
  configs.add(_buildConfigRow(Icons.chat, 'Chat Panel', 'Icons.chat', Color(0xFF6A1B9A), 'Open chat panel'));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Custom Icon & Tooltip Examples',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 12),
        Column(children: configs),
        SizedBox(height: 8),
        buildInfoCard('Note:', 'EndDrawerButton can use custom child widget via IconButton style'),
      ],
    ),
  );
}

Widget _buildConfigRow(IconData icon, String label, String iconName, Color color, String tooltip) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(iconName, style: TextStyle(fontSize: 11, color: Color(0xFF757575), fontFamily: 'monospace')),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(tooltip, style: TextStyle(fontSize: 9, color: Color(0xFF616161))),
        ),
      ],
    ),
  );
}

Widget _buildThemedContexts() {
  print('Building themed contexts');
  List<Widget> themes = [];

  themes.add(_buildThemePreview(
    'Light Theme', Color(0xFF1976D2), Color(0xFFFAFAFA),
    Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFF000000),
    'White icon on blue AppBar', 'Standard material light theme',
  ));

  themes.add(_buildThemePreview(
    'Dark Theme', Color(0xFF212121), Color(0xFF303030),
    Color(0xFFE0E0E0), Color(0xFFBB86FC), Color(0xFFE0E0E0),
    'Purple accent on dark surface', 'Material dark theme variant',
  ));

  themes.add(_buildThemePreview(
    'High Contrast', Color(0xFF000000), Color(0xFFFFFFFF),
    Color(0xFFFFFF00), Color(0xFFFFFF00), Color(0xFF000000),
    'Yellow icon on black background', 'Accessibility-focused high contrast',
  ));

  return Column(children: themes);
}

Widget _buildThemePreview(String themeName, Color barColor, Color bodyColor,
    Color barTextColor, Color iconColor, Color bodyTextColor,
    String desc1, String desc2) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFBDBDBD), width: 2),
    ),
    child: Column(
      children: [
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Text(themeName, style: TextStyle(color: barTextColor, fontSize: 14, fontWeight: FontWeight.bold)),
              Expanded(child: SizedBox()),
              Icon(Icons.menu_open, color: iconColor, size: 22),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bodyColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(desc1, style: TextStyle(fontSize: 12, color: bodyTextColor)),
              Text(desc2, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlacementGuide() {
  print('Building placement guide');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('EndDrawerButton Placement in Widget Tree',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        _buildTreeNode('Scaffold', 0, Color(0xFF1B5E20)),
        _buildTreeNode('appBar: AppBar', 1, Color(0xFF2E7D32)),
        _buildTreeNode('leading: DrawerButton()', 2, Color(0xFF388E3C)),
        _buildTreeNode('actions: [EndDrawerButton()]', 2, Color(0xFF43A047)),
        _buildTreeNode('drawer: Drawer(...)', 1, Color(0xFF4CAF50)),
        _buildTreeNode('endDrawer: Drawer(...)', 1, Color(0xFF66BB6A)),
        _buildTreeNode('body: ...', 1, Color(0xFF81C784)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFC8E6C9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF2E7D32), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'EndDrawerButton calls Scaffold.of(context).openEndDrawer()',
                  style: TextStyle(fontSize: 12, color: Color(0xFF1B5E20)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeNode(String label, int indent, Color color) {
  String prefix = '';
  int i = 0;
  for (i = 0; i < indent; i = i + 1) {
    prefix = prefix + '    ';
  }
  if (indent > 0) {
    prefix = prefix + '\u2514\u2500 ';
  }
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Text(prefix, style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFF757575))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color),
          ),
          child: Text(label, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color)),
        ),
      ],
    ),
  );
}

Widget _buildPropertiesReference() {
  print('Building properties reference');
  List<Widget> rows = [];
  rows.add(_buildPropertyRow('style', 'ButtonStyle', 'Custom button styling', Color(0xFF1565C0)));
  rows.add(_buildPropertyRow('onPressed', 'VoidCallback', 'Override default open behavior', Color(0xFF00897B)));
  rows.add(_buildPropertyRow('child', 'Widget', 'Custom child widget (icon)', Color(0xFFE65100)));
  rows.add(_buildPropertyRow('tooltip', 'String', 'Accessibility tooltip text', Color(0xFF6A1B9A)));
  rows.add(_buildPropertyRow('splashRadius', 'double', 'Splash effect radius', Color(0xFFC62828)));
  rows.add(_buildPropertyRow('padding', 'EdgeInsetsGeometry', 'Button hit area padding', Color(0xFF283593)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: Text('Property', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(flex: 2, child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(flex: 3, child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          ],
        ),
        Divider(color: Color(0xFFBDBDBD)),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildPropertyRow(String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
    ),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: color, fontWeight: FontWeight.bold))),
        Expanded(flex: 2, child: Text(type, style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF616161)))),
        Expanded(flex: 3, child: Text(desc, style: TextStyle(fontSize: 11, color: Color(0xFF757575)))),
      ],
    ),
  );
}

Widget _buildBehaviorFlow() {
  print('Building behavior flow');
  List<Widget> steps = [];

  steps.add(_buildFlowStep('1', 'User taps EndDrawerButton', Icons.touch_app, Color(0xFF1565C0)));
  steps.add(_buildFlowArrow());
  steps.add(_buildFlowStep('2', 'Scaffold.of(context).openEndDrawer()', Icons.code, Color(0xFF00897B)));
  steps.add(_buildFlowArrow());
  steps.add(_buildFlowStep('3', 'ScaffoldState begins animation', Icons.animation, Color(0xFFE65100)));
  steps.add(_buildFlowArrow());
  steps.add(_buildFlowStep('4', 'EndDrawer slides in from right', Icons.arrow_back, Color(0xFF6A1B9A)));
  steps.add(_buildFlowArrow());
  steps.add(_buildFlowStep('5', 'Barrier/scrim appears behind drawer', Icons.layers, Color(0xFFC62828)));
  steps.add(_buildFlowArrow());
  steps.add(_buildFlowStep('6', 'onEndDrawerChanged callback fired', Icons.notifications_active, Color(0xFF283593)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(children: steps),
  );
}

Widget _buildFlowStep(String number, String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Row(
      children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(child: Text(number, style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 14))),
        ),
        SizedBox(width: 12),
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Expanded(child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
      ],
    ),
  );
}

Widget _buildFlowArrow() {
  return Container(
    height: 24,
    child: Center(child: Icon(Icons.arrow_downward, color: Color(0xFF9E9E9E), size: 18)),
  );
}

Widget _buildSizeComparison() {
  print('Building size comparison');
  List<Widget> sizes = [];
  sizes.add(_buildSizeBox('Small (36)', 36, Color(0xFF4CAF50)));
  sizes.add(SizedBox(height: 8));
  sizes.add(_buildSizeBox('Medium (40)', 40, Color(0xFF2196F3)));
  sizes.add(SizedBox(height: 8));
  sizes.add(_buildSizeBox('Standard (48)', 48, Color(0xFFFF9800)));
  sizes.add(SizedBox(height: 8));
  sizes.add(_buildSizeBox('Large (56)', 56, Color(0xFFF44336)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Button Touch Target Sizes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 12),
        Column(children: sizes),
        SizedBox(height: 12),
        buildInfoCard('Minimum recommended:', '48x48 for accessibility compliance'),
      ],
    ),
  );
}

Widget _buildSizeBox(String label, double size, Color color) {
  return Row(
    children: [
      Container(
        width: size, height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(size / 4),
          border: Border.all(color: color, width: 2),
        ),
        child: Center(child: Icon(Icons.menu_open, color: color, size: size * 0.5)),
      ),
      SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text('${size.toInt()}x${size.toInt()} logical pixels', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
        ],
      ),
    ],
  );
}
