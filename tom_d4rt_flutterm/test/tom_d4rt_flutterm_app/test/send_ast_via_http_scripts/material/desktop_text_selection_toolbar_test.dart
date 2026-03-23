// ignore_for_file: avoid_print
// D4rt test script: Tests DesktopTextSelectionToolbar from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DesktopTextSelectionToolbar Visual Demo ===');
  debugPrint(
    'Demonstrating desktop toolbar layouts, button variations, and styling',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DesktopTextSelectionToolbar Demo'),
        backgroundColor: Color(0xFF283593),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Default Desktop Toolbar'),
            SizedBox(height: 8),
            _buildDefaultToolbar(),
            SizedBox(height: 24),
            _buildSectionHeader('Button Variations'),
            SizedBox(height: 8),
            _buildButtonVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Button Set Configurations'),
            SizedBox(height: 8),
            _buildButtonSetConfigs(),
            SizedBox(height: 24),
            _buildSectionHeader('Anchor Position Demo'),
            SizedBox(height: 8),
            _buildAnchorPositionDemo(),
            SizedBox(height: 24),
            _buildSectionHeader('Color Schemes'),
            SizedBox(height: 8),
            _buildColorSchemes(),
            SizedBox(height: 24),
            _buildSectionHeader('Size Variations'),
            SizedBox(height: 8),
            _buildSizeVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Elevation & Shadow Styles'),
            SizedBox(height: 8),
            _buildElevationStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Border Radius Variations'),
            SizedBox(height: 8),
            _buildBorderRadiusVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Custom Button Styles'),
            SizedBox(height: 8),
            _buildCustomButtonStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Overflow Toolbars'),
            SizedBox(height: 8),
            _buildOverflowToolbars(),
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
    decoration: BoxDecoration(
      color: Color(0xFF283593),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildDefaultToolbar() {
  debugPrint('Building default toolbar');
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Desktop toolbars use a vertical column layout with text buttons:',
          style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
        ),
        SizedBox(height: 16),
        Center(
          child: Container(
            width: 180,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(color: Color(0xFFE0E0E0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDesktopToolbarItem('Cut', Icons.content_cut, false),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildDesktopToolbarItem('Copy', Icons.content_copy, false),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildDesktopToolbarItem('Paste', Icons.content_paste, false),
                Container(height: 1, color: Color(0xFFE0E0E0)),
                _buildDesktopToolbarItem('Select All', Icons.select_all, false),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF283593), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Desktop toolbars display vertically. Each action is a full-width text button with optional shortcuts displayed on the right.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF283593)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDesktopToolbarItem(String label, IconData icon, bool highlighted) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: highlighted ? Color(0xFFE8EAF6) : Color(0x00000000),
    child: Row(
      children: [
        Icon(icon, size: 16, color: Color(0xFF424242)),
        SizedBox(width: 10),
        Expanded(child: Text(label, style: TextStyle(fontSize: 13))),
      ],
    ),
  );
}

Widget _buildButtonVariations() {
  debugPrint('Building button variations');
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: _buildButtonVarColumn('With Icons', [
          _buildVarButton(Icons.content_cut, 'Cut', 'Ctrl+X', true),
          _buildVarButton(Icons.content_copy, 'Copy', 'Ctrl+C', true),
          _buildVarButton(Icons.content_paste, 'Paste', 'Ctrl+V', true),
        ]),
      ),
      SizedBox(width: 12),
      Expanded(
        child: _buildButtonVarColumn('With Shortcuts', [
          _buildVarButton(null, 'Cut', 'Ctrl+X', false),
          _buildVarButton(null, 'Copy', 'Ctrl+C', false),
          _buildVarButton(null, 'Paste', 'Ctrl+V', false),
        ]),
      ),
      SizedBox(width: 12),
      Expanded(
        child: _buildButtonVarColumn('With Dividers', [
          _buildVarButton(Icons.content_cut, 'Cut', '', true),
          Container(
            height: 1,
            color: Color(0xFFE0E0E0),
            margin: EdgeInsets.symmetric(horizontal: 8),
          ),
          _buildVarButton(Icons.content_copy, 'Copy', '', true),
          Container(
            height: 1,
            color: Color(0xFFE0E0E0),
            margin: EdgeInsets.symmetric(horizontal: 8),
          ),
          _buildVarButton(Icons.content_paste, 'Paste', '', true),
        ]),
      ),
    ],
  );
}

Widget _buildButtonVarColumn(String title, List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
      boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFF616161),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        ...children,
      ],
    ),
  );
}

Widget _buildVarButton(
  IconData? icon,
  String label,
  String shortcut,
  bool hasIcon,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        if (hasIcon && icon != null) ...[
          Icon(icon, size: 14, color: Color(0xFF424242)),
          SizedBox(width: 8),
        ],
        Expanded(child: Text(label, style: TextStyle(fontSize: 12))),
        if (shortcut.isNotEmpty)
          Text(
            shortcut,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF9E9E9E),
              fontFamily: 'monospace',
            ),
          ),
      ],
    ),
  );
}

Widget _buildButtonSetConfigs() {
  debugPrint('Building button set configurations');
  List<Map<String, dynamic>> configs = [
    {
      'label': 'Editable Text',
      'buttons': ['Cut', 'Copy', 'Paste', 'Select All'],
      'color': Color(0xFF283593),
    },
    {
      'label': 'Read-Only Text',
      'buttons': ['Copy', 'Select All'],
      'color': Color(0xFF2E7D32),
    },
    {
      'label': 'Password Field',
      'buttons': ['Paste', 'Select All'],
      'color': Color(0xFFBF360C),
    },
    {
      'label': 'Rich Text',
      'buttons': ['Cut', 'Copy', 'Paste', 'Select All', 'Format'],
      'color': Color(0xFF6A1B9A),
    },
    {
      'label': 'Search Field',
      'buttons': ['Cut', 'Copy', 'Paste', 'Search'],
      'color': Color(0xFF00695C),
    },
    {
      'label': 'Custom Actions',
      'buttons': ['Copy', 'Translate', 'Share', 'Define'],
      'color': Color(0xFFC62828),
    },
  ];
  return Column(
    children: configs.map((c) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c['color'] as Color),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 110,
              child: Text(
                c['label'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: c['color'] as Color,
                ),
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: (c['buttons'] as List<String>).map((b) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (c['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      b,
                      style: TextStyle(
                        fontSize: 11,
                        color: c['color'] as Color,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildAnchorPositionDemo() {
  debugPrint('Building anchor position demo');
  return Container(
    height: 250,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 30,
          top: 20,
          child: _buildMiniVertToolbar('Top-Left', Color(0xFF283593)),
        ),
        Positioned(
          right: 30,
          top: 20,
          child: _buildMiniVertToolbar('Top-Right', Color(0xFF2E7D32)),
        ),
        Positioned(
          left: 80,
          top: 100,
          child: Container(
            width: 250,
            height: 50,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF283593)),
            ),
            child: Text(
              'Selected text content in field here',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
        Positioned(
          left: 30,
          bottom: 30,
          child: _buildMiniVertToolbar('Bottom-Left', Color(0xFFFF6F00)),
        ),
        Positioned(
          right: 30,
          bottom: 30,
          child: _buildMiniVertToolbar('Bottom-Right', Color(0xFF9C27B0)),
        ),
        Positioned(
          left: 340,
          top: 90,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Anchor adapts to\navailable screen\nspace',
              style: TextStyle(fontSize: 10, color: Color(0xFF283593)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniVertToolbar(String label, Color color) {
  return Container(
    width: 70,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color),
      boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(4),
          child: Text('Cut', style: TextStyle(fontSize: 9)),
        ),
        Container(height: 1, color: Color(0xFFE0E0E0)),
        Padding(
          padding: EdgeInsets.all(4),
          child: Text('Copy', style: TextStyle(fontSize: 9)),
        ),
        Container(height: 1, color: Color(0xFFE0E0E0)),
        Padding(
          padding: EdgeInsets.all(4),
          child: Text('Paste', style: TextStyle(fontSize: 9)),
        ),
      ],
    ),
  );
}

Widget _buildColorSchemes() {
  debugPrint('Building color schemes');
  List<Map<String, dynamic>> schemes = [
    {
      'name': 'Indigo',
      'bg': Color(0xFFFFFFFF),
      'hover': Color(0xFFE8EAF6),
      'text': Color(0xFF283593),
      'border': Color(0xFFC5CAE9),
    },
    {
      'name': 'Dark',
      'bg': Color(0xFF37474F),
      'hover': Color(0xFF455A64),
      'text': Color(0xFFECEFF1),
      'border': Color(0xFF546E7A),
    },
    {
      'name': 'Teal',
      'bg': Color(0xFFE0F2F1),
      'hover': Color(0xFFB2DFDB),
      'text': Color(0xFF00695C),
      'border': Color(0xFF80CBC4),
    },
    {
      'name': 'Amber',
      'bg': Color(0xFFFFF8E1),
      'hover': Color(0xFFFFECB3),
      'text': Color(0xFFFF6F00),
      'border': Color(0xFFFFD54F),
    },
    {
      'name': 'Rose',
      'bg': Color(0xFFFCE4EC),
      'hover': Color(0xFFF8BBD0),
      'text': Color(0xFFC62828),
      'border': Color(0xFFF48FB1),
    },
    {
      'name': 'Mono',
      'bg': Color(0xFFF5F5F5),
      'hover': Color(0xFFE0E0E0),
      'text': Color(0xFF212121),
      'border': Color(0xFFBDBDBD),
    },
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: schemes.map((s) {
      return Container(
        width: 170,
        decoration: BoxDecoration(
          color: s['bg'] as Color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: s['border'] as Color, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                s['name'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: s['text'] as Color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'Cut',
                style: TextStyle(fontSize: 12, color: s['text'] as Color),
              ),
            ),
            Container(height: 1, color: s['border'] as Color),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: s['hover'] as Color,
              child: Text(
                'Copy  (hovered)',
                style: TextStyle(
                  fontSize: 12,
                  color: s['text'] as Color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(height: 1, color: s['border'] as Color),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'Paste',
                style: TextStyle(fontSize: 12, color: s['text'] as Color),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildSizeVariations() {
  debugPrint('Building size variations');
  List<Map<String, dynamic>> sizes = [
    {
      'name': 'Compact',
      'padding': 4.0,
      'fontSize': 11.0,
      'iconSize': 14.0,
      'color': Color(0xFF283593),
    },
    {
      'name': 'Standard',
      'padding': 8.0,
      'fontSize': 13.0,
      'iconSize': 16.0,
      'color': Color(0xFF2E7D32),
    },
    {
      'name': 'Comfortable',
      'padding': 12.0,
      'fontSize': 14.0,
      'iconSize': 18.0,
      'color': Color(0xFFFF6F00),
    },
    {
      'name': 'Large',
      'padding': 16.0,
      'fontSize': 16.0,
      'iconSize': 22.0,
      'color': Color(0xFF6A1B9A),
    },
  ];
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: sizes.map((s) {
      double pad = s['padding'] as double;
      double fs = s['fontSize'] as double;
      double is_ = s['iconSize'] as double;
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: s['color'] as Color),
            boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: s['color'] as Color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                ),
                child: Text(
                  s['name'] as String,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(pad),
                child: Row(
                  children: [
                    Icon(
                      Icons.content_cut,
                      size: is_,
                      color: Color(0xFF424242),
                    ),
                    SizedBox(width: 6),
                    Text('Cut', style: TextStyle(fontSize: fs)),
                  ],
                ),
              ),
              Container(height: 1, color: Color(0xFFE0E0E0)),
              Container(
                padding: EdgeInsets.all(pad),
                child: Row(
                  children: [
                    Icon(
                      Icons.content_copy,
                      size: is_,
                      color: Color(0xFF424242),
                    ),
                    SizedBox(width: 6),
                    Text('Copy', style: TextStyle(fontSize: fs)),
                  ],
                ),
              ),
              Container(height: 1, color: Color(0xFFE0E0E0)),
              Container(
                padding: EdgeInsets.all(pad),
                child: Row(
                  children: [
                    Icon(
                      Icons.content_paste,
                      size: is_,
                      color: Color(0xFF424242),
                    ),
                    SizedBox(width: 6),
                    Text('Paste', style: TextStyle(fontSize: fs)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildElevationStyles() {
  debugPrint('Building elevation styles');
  List<Map<String, dynamic>> elevations = [
    {'label': 'Flat (0)', 'elevation': 0.0, 'color': Color(0xFF9E9E9E)},
    {'label': 'Subtle (2)', 'elevation': 2.0, 'color': Color(0xFF757575)},
    {'label': 'Default (4)', 'elevation': 4.0, 'color': Color(0xFF616161)},
    {'label': 'Raised (8)', 'elevation': 8.0, 'color': Color(0xFF424242)},
    {'label': 'Floating (16)', 'elevation': 16.0, 'color': Color(0xFF212121)},
  ];
  return Row(
    children: elevations.map((e) {
      double elev = e['elevation'] as double;
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: elev,
                offset: Offset(0, elev / 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                e['label'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: e['color'] as Color,
                ),
              ),
              SizedBox(height: 6),
              Text('Cut', style: TextStyle(fontSize: 10)),
              Container(
                height: 1,
                color: Color(0xFFEEEEEE),
                margin: EdgeInsets.symmetric(vertical: 2),
              ),
              Text('Copy', style: TextStyle(fontSize: 10)),
              Container(
                height: 1,
                color: Color(0xFFEEEEEE),
                margin: EdgeInsets.symmetric(vertical: 2),
              ),
              Text('Paste', style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildBorderRadiusVariations() {
  debugPrint('Building border radius variations');
  List<Map<String, dynamic>> radii = [
    {'label': 'Sharp (0)', 'radius': 0.0},
    {'label': 'Slight (4)', 'radius': 4.0},
    {'label': 'Medium (8)', 'radius': 8.0},
    {'label': 'Rounded (16)', 'radius': 16.0},
    {'label': 'Pill (24)', 'radius': 24.0},
  ];
  return Row(
    children: radii.map((r) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(r['radius'] as double),
            border: Border.all(color: Color(0xFF283593)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color(0xFF283593),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(r['radius'] as double),
                    topRight: Radius.circular(r['radius'] as double),
                  ),
                ),
                child: Text(
                  r['label'] as String,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  'Cut',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  'Copy',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  'Paste',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildCustomButtonStyles() {
  debugPrint('Building custom button styles');
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 6)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStyledButton('Cut', Color(0xFFE8EAF6), Color(0xFF283593)),
            SizedBox(width: 4),
            _buildStyledButton('Copy', Color(0xFFE8EAF6), Color(0xFF283593)),
            SizedBox(width: 4),
            _buildStyledButton('Paste', Color(0xFFE8EAF6), Color(0xFF283593)),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF37474F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStyledButton('Cut', Color(0xFF455A64), Color(0xFFECEFF1)),
            SizedBox(width: 4),
            _buildStyledButton('Copy', Color(0xFF455A64), Color(0xFFECEFF1)),
            SizedBox(width: 4),
            _buildStyledButton('Paste', Color(0xFF455A64), Color(0xFFECEFF1)),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChipButton('Cut', Icons.content_cut, Color(0xFF283593)),
            SizedBox(width: 4),
            _buildChipButton('Copy', Icons.content_copy, Color(0xFF283593)),
            SizedBox(width: 4),
            _buildChipButton('Paste', Icons.content_paste, Color(0xFF283593)),
          ],
        ),
      ),
    ],
  );
}

Widget _buildStyledButton(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );
}

Widget _buildChipButton(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverflowToolbars() {
  debugPrint('Building overflow toolbars');
  List<String> manyActions = [
    'Cut',
    'Copy',
    'Paste',
    'Select All',
    'Share',
    'Translate',
    'Define',
    'Search',
    'Format',
    'Comment',
  ];
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horizontal Scroll Overflow',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF757575),
              ),
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Color(0x22000000), blurRadius: 4),
                  ],
                ),
                child: Row(
                  children: manyActions.map((a) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(a, style: TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vertical Scroll Overflow',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF757575),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Container(
                width: 150,
                height: 180,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Color(0x22000000), blurRadius: 4),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: manyActions.asMap().entries.map((entry) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Text(
                              entry.value,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          if (entry.key < manyActions.length - 1)
                            Container(height: 1, color: Color(0xFFEEEEEE)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
