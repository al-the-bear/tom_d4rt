// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DrawerButton concepts from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DrawerButton Visual Demo ===');
  debugPrint('Demonstrating drawer buttons in AppBars, standalone, styling, and scaffold integration');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DrawerButton Demo'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Standard DrawerButton'),
            SizedBox(height: 8),
            _buildStandardDrawerButton(),
            SizedBox(height: 24),
            _buildSectionHeader('DrawerButton in AppBar Context'),
            SizedBox(height: 8),
            _buildDrawerButtonInAppBar(),
            SizedBox(height: 24),
            _buildSectionHeader('DrawerButton vs EndDrawerButton'),
            SizedBox(height: 8),
            _buildDrawerVsEndDrawer(),
            SizedBox(height: 24),
            _buildSectionHeader('Button Style Variations'),
            SizedBox(height: 8),
            _buildButtonStyleVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Tap Area Sizes'),
            SizedBox(height: 8),
            _buildTapAreaSizes(),
            SizedBox(height: 24),
            _buildSectionHeader('Tooltip Configurations'),
            SizedBox(height: 8),
            _buildTooltipConfigurations(),
            SizedBox(height: 24),
            _buildSectionHeader('Themed DrawerButtons'),
            SizedBox(height: 8),
            _buildThemedDrawerButtons(),
            SizedBox(height: 24),
            _buildSectionHeader('Scaffold Integration Layout'),
            SizedBox(height: 8),
            _buildScaffoldIntegration(),
            SizedBox(height: 24),
            _buildSectionHeader('Button State Visualization'),
            SizedBox(height: 8),
            _buildButtonStateVisualization(),
            SizedBox(height: 24),
            _buildSectionHeader('DrawerButton Properties'),
            SizedBox(height: 8),
            _buildPropertiesTable(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  debugPrint('Building section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(color: Color(0xFF00695C), borderRadius: BorderRadius.circular(8)),
    child: Text(title, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.bold)),
  );
}

Widget _buildStandardDrawerButton() {
  debugPrint('Building standard drawer button');
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Container(
        width: 80, height: 80,
        decoration: BoxDecoration(color: Color(0xFFFFFFFF), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 8, offset: Offset(0, 2))]),
        child: Center(child: Icon(Icons.menu, size: 32, color: Color(0xFF00695C))),
      ),
      SizedBox(width: 20),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DrawerButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF00695C))),
          SizedBox(height: 6),
          Text('An IconButton that opens the Scaffold drawer. Automatically added by Scaffold when a Drawer is present.', style: TextStyle(fontSize: 13, color: Color(0xFF616161))),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(6)),
            child: Text('Scaffold.of(context).openDrawer()', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF00695C))),
          ),
        ],
      )),
    ]),
  );
}

Widget _buildDrawerButtonInAppBar() {
  debugPrint('Building drawer button in app bar context');
  List<Map<String, dynamic>> appBarStyles = [
    {'label': 'Default AppBar', 'bg': Color(0xFF00695C), 'fg': Color(0xFFFFFFFF), 'elev': 4.0},
    {'label': 'SliverAppBar', 'bg': Color(0xFF004D40), 'fg': Color(0xFFFFFFFF), 'elev': 0.0},
    {'label': 'Transparent', 'bg': Color(0x00000000), 'fg': Color(0xFF263238), 'elev': 0.0},
    {'label': 'Surface Color', 'bg': Color(0xFFFAFAFA), 'fg': Color(0xFF263238), 'elev': 2.0},
  ];
  return Column(
    children: appBarStyles.map((style) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 56,
        decoration: BoxDecoration(
          color: style['bg'] as Color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [(style['elev'] as double) > 0 ? BoxShadow(color: Color(0x33000000), blurRadius: style['elev'] as double, offset: Offset(0, 1)) : BoxShadow(color: Color(0x00000000))],
          border: (style['bg'] as Color) == Color(0x00000000) ? Border.all(color: Color(0xFFE0E0E0)) : null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Icon(Icons.menu, color: style['fg'] as Color, size: 24),
          SizedBox(width: 16),
          Expanded(child: Text(style['label'] as String, style: TextStyle(color: style['fg'] as Color, fontSize: 16, fontWeight: FontWeight.w500))),
          Icon(Icons.more_vert, color: style['fg'] as Color, size: 24),
        ]),
      );
    }).toList(),
  );
}

Widget _buildDrawerVsEndDrawer() {
  debugPrint('Building drawer vs end drawer comparison');
  return Row(children: [
    Expanded(child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFF00695C), width: 2)),
      child: Column(children: [
        Icon(Icons.menu, size: 36, color: Color(0xFF00695C)),
        SizedBox(height: 8),
        Text('DrawerButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF00695C))),
        SizedBox(height: 4),
        Text('Opens leading drawer\n(left on LTR)', style: TextStyle(fontSize: 11, color: Color(0xFF616161)), textAlign: TextAlign.center),
        SizedBox(height: 8),
        Container(
          height: 60, width: double.infinity,
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(6)),
          child: Row(children: [
            Container(width: 30, decoration: BoxDecoration(color: Color(0xFF00695C).withValues(alpha: 0.3), borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)))),
            Expanded(child: Center(child: Text('Content', style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))))),
          ]),
        ),
        SizedBox(height: 6),
        Row(children: [
          Icon(Icons.arrow_back, size: 14, color: Color(0xFF00695C)),
          SizedBox(width: 4),
          Text('Left side', style: TextStyle(fontSize: 10, color: Color(0xFF00695C), fontWeight: FontWeight.bold)),
        ]),
      ]),
    )),
    SizedBox(width: 12),
    Expanded(child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFFF3E5F5), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFF7B1FA2), width: 2)),
      child: Column(children: [
        Icon(Icons.menu_open, size: 36, color: Color(0xFF7B1FA2)),
        SizedBox(height: 8),
        Text('EndDrawerButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF7B1FA2))),
        SizedBox(height: 4),
        Text('Opens trailing drawer\n(right on LTR)', style: TextStyle(fontSize: 11, color: Color(0xFF616161)), textAlign: TextAlign.center),
        SizedBox(height: 8),
        Container(
          height: 60, width: double.infinity,
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(6)),
          child: Row(children: [
            Expanded(child: Center(child: Text('Content', style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))))),
            Container(width: 30, decoration: BoxDecoration(color: Color(0xFF7B1FA2).withValues(alpha: 0.3), borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)))),
          ]),
        ),
        SizedBox(height: 6),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text('Right side', style: TextStyle(fontSize: 10, color: Color(0xFF7B1FA2), fontWeight: FontWeight.bold)),
          SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 14, color: Color(0xFF7B1FA2)),
        ]),
      ]),
    )),
  ]);
}

Widget _buildButtonStyleVariations() {
  debugPrint('Building button style variations');
  List<Map<String, dynamic>> styles = [
    {'label': 'Default', 'bg': Color(0x00000000), 'fg': Color(0xFF455A64), 'border': false, 'shape': BoxShape.rectangle, 'radius': 20.0},
    {'label': 'Filled', 'bg': Color(0xFF00695C), 'fg': Color(0xFFFFFFFF), 'border': false, 'shape': BoxShape.circle, 'radius': 0.0},
    {'label': 'Filled Tonal', 'bg': Color(0xFFB2DFDB), 'fg': Color(0xFF00695C), 'border': false, 'shape': BoxShape.circle, 'radius': 0.0},
    {'label': 'Outlined', 'bg': Color(0x00000000), 'fg': Color(0xFF00695C), 'border': true, 'shape': BoxShape.circle, 'radius': 0.0},
    {'label': 'Elevated', 'bg': Color(0xFFFFFFFF), 'fg': Color(0xFF455A64), 'border': false, 'shape': BoxShape.circle, 'radius': 0.0},
    {'label': 'Text', 'bg': Color(0x00000000), 'fg': Color(0xFF00695C), 'border': false, 'shape': BoxShape.rectangle, 'radius': 8.0},
  ];
  return Wrap(
    spacing: 12, runSpacing: 12,
    children: styles.map((s) {
      bool isCircle = s['shape'] == BoxShape.circle;
      return Column(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: s['bg'] as Color,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(s['radius'] as double),
            border: (s['border'] as bool) ? Border.all(color: s['fg'] as Color, width: 1.5) : null,
            boxShadow: s['label'] == 'Elevated' ? [BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 2))] : [],
          ),
          child: Center(child: Icon(Icons.menu, color: s['fg'] as Color, size: 22)),
        ),
        SizedBox(height: 6),
        Text(s['label'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ]);
    }).toList(),
  );
}

Widget _buildTapAreaSizes() {
  debugPrint('Building tap area sizes');
  List<Map<String, dynamic>> sizes = [
    {'tapSize': 36.0, 'iconSize': 20.0, 'label': '36dp', 'compliant': false},
    {'tapSize': 40.0, 'iconSize': 22.0, 'label': '40dp', 'compliant': false},
    {'tapSize': 48.0, 'iconSize': 24.0, 'label': '48dp (min)', 'compliant': true},
    {'tapSize': 56.0, 'iconSize': 28.0, 'label': '56dp', 'compliant': true},
    {'tapSize': 64.0, 'iconSize': 32.0, 'label': '64dp', 'compliant': true},
  ];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: sizes.map((s) {
      double tapSize = s['tapSize'] as double;
      bool compliant = s['compliant'] as bool;
      return Column(children: [
        Container(
          width: tapSize, height: tapSize,
          decoration: BoxDecoration(
            color: compliant ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: compliant ? Color(0xFF4CAF50) : Color(0xFFF44336), width: 2),
          ),
          child: Center(child: Icon(Icons.menu, size: s['iconSize'] as double, color: compliant ? Color(0xFF2E7D32) : Color(0xFFC62828))),
        ),
        SizedBox(height: 6),
        Text(s['label'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: compliant ? Color(0xFF2E7D32) : Color(0xFFC62828))),
        Icon(compliant ? Icons.check_circle : Icons.cancel, size: 14, color: compliant ? Color(0xFF4CAF50) : Color(0xFFF44336)),
      ]);
    }).toList(),
  );
}

Widget _buildTooltipConfigurations() {
  debugPrint('Building tooltip configurations');
  List<Map<String, dynamic>> tooltips = [
    {'text': 'Open navigation menu', 'pos': 'Below', 'delay': '500ms', 'icon': Icons.menu},
    {'text': 'Open end drawer', 'pos': 'Below', 'delay': '500ms', 'icon': Icons.menu_open},
    {'text': 'Custom tooltip text', 'pos': 'Above', 'delay': '300ms', 'icon': Icons.menu},
    {'text': 'No tooltip (empty)', 'pos': 'None', 'delay': '-', 'icon': Icons.menu},
  ];
  return Column(
    children: tooltips.map((t) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFE0E0E0))),
        child: Row(children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(8)),
            child: Center(child: Icon(t['icon'] as IconData, color: Color(0xFF00695C), size: 22)),
          ),
          SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: Color(0xFF37474F), borderRadius: BorderRadius.circular(4)),
                child: Text(t['text'] as String, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11)),
              ),
              SizedBox(height: 4),
              Row(children: [
                _buildChip('Position: ${t['pos']}', Color(0xFF00695C)),
                SizedBox(width: 6),
                _buildChip('Delay: ${t['delay']}', Color(0xFF455A64)),
              ]),
            ],
          )),
        ]),
      );
    }).toList(),
  );
}

Widget _buildChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
    child: Text(label, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold)),
  );
}

Widget _buildThemedDrawerButtons() {
  debugPrint('Building themed drawer buttons');
  List<Map<String, dynamic>> themes = [
    {'name': 'Material Default', 'primary': Color(0xFF6200EA), 'surface': Color(0xFFF5F5F5), 'onSurface': Color(0xFF212121)},
    {'name': 'Ocean', 'primary': Color(0xFF006064), 'surface': Color(0xFFE0F7FA), 'onSurface': Color(0xFF004D40)},
    {'name': 'Sunset', 'primary': Color(0xFFBF360C), 'surface': Color(0xFFFBE9E7), 'onSurface': Color(0xFF870000)},
    {'name': 'Forest', 'primary': Color(0xFF1B5E20), 'surface': Color(0xFFE8F5E9), 'onSurface': Color(0xFF003300)},
    {'name': 'Dark', 'primary': Color(0xFFBB86FC), 'surface': Color(0xFF1E1E1E), 'onSurface': Color(0xFFE0E0E0)},
    {'name': 'High Contrast', 'primary': Color(0xFF000000), 'surface': Color(0xFFFFFFFF), 'onSurface': Color(0xFF000000)},
  ];
  return Wrap(
    spacing: 8, runSpacing: 8,
    children: themes.map((t) {
      return Container(
        width: 110,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: t['surface'] as Color, borderRadius: BorderRadius.circular(10), border: Border.all(color: (t['primary'] as Color).withValues(alpha: 0.4))),
        child: Column(children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: (t['primary'] as Color).withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Center(child: Icon(Icons.menu, color: t['onSurface'] as Color, size: 22)),
          ),
          SizedBox(height: 8),
          Text(t['name'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: t['onSurface'] as Color), textAlign: TextAlign.center),
        ]),
      );
    }).toList(),
  );
}

Widget _buildScaffoldIntegration() {
  debugPrint('Building scaffold integration layout');
  return Container(
    height: 240,
    decoration: BoxDecoration(color: Color(0xFFECEFF1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFB0BEC5), width: 2)),
    child: Column(children: [
      Container(
        height: 40,
        decoration: BoxDecoration(color: Color(0xFF00695C), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(color: Color(0xFFFFFFFF).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
            child: Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 18),
          ),
          SizedBox(width: 12),
          Text('AppBar (with DrawerButton)', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12, fontWeight: FontWeight.bold)),
          Spacer(),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(color: Color(0xFFFFFFFF).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
            child: Icon(Icons.menu_open, color: Color(0xFFFFFFFF), size: 18),
          ),
        ]),
      ),
      Expanded(child: Row(children: [
        Container(
          width: 70,
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), border: Border(right: BorderSide(color: Color(0xFFE0E0E0)))),
          child: Column(children: [
            SizedBox(height: 8),
            Text('Drawer', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
            SizedBox(height: 8),
            _buildDrawerItem(Icons.home, 'Home'),
            _buildDrawerItem(Icons.settings, 'Settings'),
            _buildDrawerItem(Icons.info, 'About'),
          ]),
        ),
        Expanded(child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app, size: 28, color: Color(0xFFB0BEC5)),
              SizedBox(height: 8),
              Text('Body Content', style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
              SizedBox(height: 4),
              Text('Tap hamburger icon to open drawer', style: TextStyle(fontSize: 10, color: Color(0xFFB0BEC5))),
            ],
          ),
        )),
      ])),
    ]),
  );
}

Widget _buildDrawerItem(IconData icon, String label) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Row(children: [
      Icon(icon, size: 14, color: Color(0xFF616161)),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 9, color: Color(0xFF616161))),
    ]),
  );
}

Widget _buildButtonStateVisualization() {
  debugPrint('Building button state visualization');
  List<Map<String, dynamic>> states = [
    {'state': 'Normal', 'color': Color(0xFF455A64), 'bg': Color(0x00000000), 'overlay': Color(0x00000000)},
    {'state': 'Hovered', 'color': Color(0xFF455A64), 'bg': Color(0x14455A64), 'overlay': Color(0x0A000000)},
    {'state': 'Focused', 'color': Color(0xFF00695C), 'bg': Color(0x1400695C), 'overlay': Color(0x1400695C)},
    {'state': 'Pressed', 'color': Color(0xFF00695C), 'bg': Color(0x2800695C), 'overlay': Color(0x2800695C)},
    {'state': 'Disabled', 'color': Color(0xFFBDBDBD), 'bg': Color(0x00000000), 'overlay': Color(0x00000000)},
  ];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: states.map((s) {
      return Column(children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(
            color: s['bg'] as Color,
            shape: BoxShape.circle,
            border: s['state'] == 'Focused' ? Border.all(color: Color(0xFF00695C), width: 2) : null,
          ),
          child: Center(child: Icon(Icons.menu, color: s['color'] as Color, size: 22)),
        ),
        SizedBox(height: 6),
        Text(s['state'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ]);
    }).toList(),
  );
}

Widget _buildPropertiesTable() {
  debugPrint('Building properties table');
  List<Map<String, String>> props = [
    {'prop': 'style', 'type': 'ButtonStyle?', 'desc': 'Custom button styling'},
    {'prop': 'onPressed', 'type': 'VoidCallback?', 'desc': 'Override default open drawer action'},
    {'prop': 'icon', 'type': 'Widget?', 'desc': 'Custom icon widget (default Icons.menu)'},
    {'prop': 'tooltip', 'type': 'String?', 'desc': 'Accessibility tooltip text'},
    {'prop': 'iconSize', 'type': 'double?', 'desc': 'Size of the icon'},
    {'prop': 'padding', 'type': 'EdgeInsetsGeometry?', 'desc': 'Padding around the icon'},
    {'prop': 'constraints', 'type': 'BoxConstraints?', 'desc': 'Size constraints for button'},
    {'prop': 'splashRadius', 'type': 'double?', 'desc': 'Ripple splash radius (M2)'},
  ];
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFE0E0E0))),
    child: Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: Color(0xFF00695C), borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9))),
        child: Row(children: [
          Expanded(flex: 2, child: Text('Property', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Type', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11, fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text('Description', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11, fontWeight: FontWeight.bold))),
        ]),
      ),
      ...props.asMap().entries.map((entry) {
        int idx = entry.key;
        Map<String, String> p = entry.value;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: idx.isEven ? Color(0xFFFAFAFA) : Color(0xFFFFFFFF),
            border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
          ),
          child: Row(children: [
            Expanded(flex: 2, child: Text(p['prop']!, style: TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF00695C)))),
            Expanded(flex: 2, child: Text(p['type']!, style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF7B1FA2)))),
            Expanded(flex: 3, child: Text(p['desc']!, style: TextStyle(fontSize: 11, color: Color(0xFF616161)))),
          ]),
        );
      }),
    ]),
  );
}
