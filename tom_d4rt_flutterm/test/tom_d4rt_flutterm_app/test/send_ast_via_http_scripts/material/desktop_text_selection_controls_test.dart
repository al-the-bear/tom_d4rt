// D4rt test script: Tests DesktopTextSelectionControls from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DesktopTextSelectionControls Visual Demo ===');
  debugPrint(
    'Demonstrating desktop text selection toolbar styles, handles, and configurations',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DesktopTextSelectionControls Demo'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Toolbar Button Styles'),
            SizedBox(height: 8),
            _buildToolbarButtonStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Selection Handles'),
            SizedBox(height: 8),
            _buildSelectionHandles(),
            SizedBox(height: 24),
            _buildSectionHeader('Toolbar Configurations'),
            SizedBox(height: 8),
            _buildToolbarConfigurations(),
            SizedBox(height: 24),
            _buildSectionHeader('Platform Comparison'),
            SizedBox(height: 8),
            _buildPlatformComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('Selection States'),
            SizedBox(height: 8),
            _buildSelectionStates(),
            SizedBox(height: 24),
            _buildSectionHeader('Themed Toolbars'),
            SizedBox(height: 8),
            _buildThemedToolbars(),
            SizedBox(height: 24),
            _buildSectionHeader('Action Button Labels'),
            SizedBox(height: 8),
            _buildActionButtonLabels(),
            SizedBox(height: 24),
            _buildSectionHeader('Anchor Positions'),
            SizedBox(height: 8),
            _buildAnchorPositions(),
            SizedBox(height: 24),
            _buildSectionHeader('Keyboard Shortcuts'),
            SizedBox(height: 8),
            _buildKeyboardShortcuts(),
            SizedBox(height: 24),
            _buildSectionHeader('Accessibility Features'),
            SizedBox(height: 8),
            _buildAccessibilityFeatures(),
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
      color: Color(0xFF1565C0),
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

Widget _buildToolbarButtonStyles() {
  debugPrint('Building toolbar button styles');
  return Column(
    children: [
      _buildToolbarVariant('Icon + Text Buttons', [
        _buildToolbarButton(Icons.content_cut, 'Cut', Color(0xFF1565C0)),
        _buildToolbarButton(Icons.content_copy, 'Copy', Color(0xFF1565C0)),
        _buildToolbarButton(Icons.content_paste, 'Paste', Color(0xFF1565C0)),
        _buildToolbarButton(Icons.select_all, 'Select All', Color(0xFF1565C0)),
      ]),
      SizedBox(height: 8),
      _buildToolbarVariant('Text-Only Buttons', [
        _buildTextButton('Cut', Color(0xFF2E7D32)),
        _buildTextButton('Copy', Color(0xFF2E7D32)),
        _buildTextButton('Paste', Color(0xFF2E7D32)),
        _buildTextButton('Select All', Color(0xFF2E7D32)),
      ]),
      SizedBox(height: 8),
      _buildToolbarVariant('Icon-Only Buttons', [
        _buildIconButton(Icons.content_cut, Color(0xFFFF6F00)),
        _buildIconButton(Icons.content_copy, Color(0xFFFF6F00)),
        _buildIconButton(Icons.content_paste, Color(0xFFFF6F00)),
        _buildIconButton(Icons.select_all, Color(0xFFFF6F00)),
      ]),
    ],
  );
}

Widget _buildToolbarVariant(String label, List<Widget> buttons) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0xFF757575),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: buttons),
        ),
      ],
    ),
  );
}

Widget _buildToolbarButton(IconData icon, String label, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    ),
  );
}

Widget _buildTextButton(String label, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Text(
      label,
      style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500),
    ),
  );
}

Widget _buildIconButton(IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
    child: Icon(icon, size: 20, color: color),
  );
}

Widget _buildSelectionHandles() {
  debugPrint('Building selection handles');
  List<Map<String, dynamic>> handles = [
    {
      'label': 'Left Handle',
      'icon': Icons.arrow_left,
      'color': Color(0xFF1565C0),
      'desc': 'Start of selection',
    },
    {
      'label': 'Right Handle',
      'icon': Icons.arrow_right,
      'color': Color(0xFF1565C0),
      'desc': 'End of selection',
    },
    {
      'label': 'Collapsed Handle',
      'icon': Icons.fiber_manual_record,
      'color': Color(0xFF1565C0),
      'desc': 'Cursor position',
    },
  ];
  return Column(
    children: [
      Row(
        children: handles.map((h) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF1565C0)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: h['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      h['icon'] as IconData,
                      color: Color(0xFFFFFFFF),
                      size: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    h['label'] as String,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  Text(
                    h['desc'] as String,
                    style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Desktop vs Mobile Handles',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildHandleComparison(
                    'Desktop',
                    'Hidden or minimal',
                    Color(0xFF1565C0),
                    Icons.desktop_windows,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildHandleComparison(
                    'Mobile',
                    'Teardrop/circle',
                    Color(0xFF4CAF50),
                    Icons.phone_android,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildHandleComparison(
  String platform,
  String style,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(height: 6),
        Text(
          platform,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          style,
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildToolbarConfigurations() {
  debugPrint('Building toolbar configurations');
  List<Map<String, dynamic>> configs = [
    {
      'label': 'Full Toolbar',
      'actions': ['Cut', 'Copy', 'Paste', 'Select All'],
      'color': Color(0xFF1565C0),
    },
    {
      'label': 'Read-Only',
      'actions': ['Copy', 'Select All'],
      'color': Color(0xFF2E7D32),
    },
    {
      'label': 'Empty Clipboard',
      'actions': ['Cut', 'Copy', 'Select All'],
      'color': Color(0xFFFF6F00),
    },
    {
      'label': 'No Selection',
      'actions': ['Paste', 'Select All'],
      'color': Color(0xFF9C27B0),
    },
    {
      'label': 'Custom Actions',
      'actions': ['Cut', 'Copy', 'Paste', 'Share', 'Translate'],
      'color': Color(0xFFF44336),
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
                children: (c['actions'] as List<String>).map((a) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (c['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: c['color'] as Color),
                    ),
                    child: Text(
                      a,
                      style: TextStyle(
                        fontSize: 11,
                        color: c['color'] as Color,
                        fontWeight: FontWeight.w500,
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

Widget _buildPlatformComparison() {
  debugPrint('Building platform comparison');
  List<Map<String, dynamic>> platforms = [
    {
      'platform': 'Windows',
      'icon': Icons.desktop_windows,
      'style': 'Floating bar, sharp corners',
      'color': Color(0xFF0078D4),
    },
    {
      'platform': 'macOS',
      'icon': Icons.laptop_mac,
      'style': 'Native menu, rounded corners',
      'color': Color(0xFF333333),
    },
    {
      'platform': 'Linux',
      'icon': Icons.computer,
      'style': 'Floating bar, theme-dependent',
      'color': Color(0xFFDD4814),
    },
    {
      'platform': 'ChromeOS',
      'icon': Icons.chrome_reader_mode,
      'style': 'Material Design style',
      'color': Color(0xFF4285F4),
    },
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: platforms.map((p) {
      return Container(
        width: 170,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: p['color'] as Color, width: 2),
        ),
        child: Column(
          children: [
            Icon(p['icon'] as IconData, size: 36, color: p['color'] as Color),
            SizedBox(height: 8),
            Text(
              p['platform'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: p['color'] as Color,
              ),
            ),
            SizedBox(height: 6),
            Text(
              p['style'] as String,
              style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 36,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Cut',
                    style: TextStyle(fontSize: 10, color: p['color'] as Color),
                  ),
                  Container(
                    width: 1,
                    height: 18,
                    color: Color(0xFFE0E0E0),
                    margin: EdgeInsets.symmetric(horizontal: 6),
                  ),
                  Text(
                    'Copy',
                    style: TextStyle(fontSize: 10, color: p['color'] as Color),
                  ),
                  Container(
                    width: 1,
                    height: 18,
                    color: Color(0xFFE0E0E0),
                    margin: EdgeInsets.symmetric(horizontal: 6),
                  ),
                  Text(
                    'Paste',
                    style: TextStyle(fontSize: 10, color: p['color'] as Color),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildSelectionStates() {
  debugPrint('Building selection states');
  List<Map<String, dynamic>> states = [
    {
      'label': 'No Selection',
      'text': 'Hello World',
      'selStart': -1,
      'selEnd': -1,
      'color': Color(0xFF9E9E9E),
    },
    {
      'label': 'Cursor Only',
      'text': 'Hello|World',
      'selStart': 5,
      'selEnd': 5,
      'color': Color(0xFF1565C0),
    },
    {
      'label': 'Word Selected',
      'text': 'Hello [World]',
      'selStart': 6,
      'selEnd': 11,
      'color': Color(0xFF4CAF50),
    },
    {
      'label': 'All Selected',
      'text': '[Hello World]',
      'selStart': 0,
      'selEnd': 11,
      'color': Color(0xFFFF9800),
    },
    {
      'label': 'Multi-line',
      'text': 'Line 1\\n[Line 2]\\nLine 3',
      'selStart': 7,
      'selEnd': 13,
      'color': Color(0xFF9C27B0),
    },
  ];
  return Column(
    children: states.map((s) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: s['color'] as Color),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: s['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 110,
              child: Text(
                s['label'] as String,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  s['text'] as String,
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${s['selStart']}:${s['selEnd']}',
                style: TextStyle(
                  color: Color(0xFF00E676),
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildThemedToolbars() {
  debugPrint('Building themed toolbars');
  List<Map<String, dynamic>> themes = [
    {
      'name': 'Default Blue',
      'bg': Color(0xFFFFFFFF),
      'fg': Color(0xFF1565C0),
      'border': Color(0xFF1565C0),
    },
    {
      'name': 'Dark Mode',
      'bg': Color(0xFF263238),
      'fg': Color(0xFFB0BEC5),
      'border': Color(0xFF546E7A),
    },
    {
      'name': 'High Contrast',
      'bg': Color(0xFF000000),
      'fg': Color(0xFFFFFF00),
      'border': Color(0xFFFFFF00),
    },
    {
      'name': 'Warm Theme',
      'bg': Color(0xFFFFF3E0),
      'fg': Color(0xFFBF360C),
      'border': Color(0xFFFF6F00),
    },
    {
      'name': 'Cool Theme',
      'bg': Color(0xFFE0F7FA),
      'fg': Color(0xFF006064),
      'border': Color(0xFF00ACC1),
    },
  ];
  return Column(
    children: themes.map((t) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: t['bg'] as Color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: t['border'] as Color, width: 2),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 110,
              child: Text(
                t['name'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: t['fg'] as Color,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cut',
                    style: TextStyle(color: t['fg'] as Color, fontSize: 12),
                  ),
                  Container(
                    width: 1,
                    height: 16,
                    color: t['border'] as Color,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Text(
                    'Copy',
                    style: TextStyle(color: t['fg'] as Color, fontSize: 12),
                  ),
                  Container(
                    width: 1,
                    height: 16,
                    color: t['border'] as Color,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Text(
                    'Paste',
                    style: TextStyle(color: t['fg'] as Color, fontSize: 12),
                  ),
                  Container(
                    width: 1,
                    height: 16,
                    color: t['border'] as Color,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Text(
                    'Select All',
                    style: TextStyle(color: t['fg'] as Color, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildActionButtonLabels() {
  debugPrint('Building action button labels');
  List<Map<String, dynamic>> actions = [
    {
      'action': 'Cut',
      'shortcut': 'Ctrl+X',
      'icon': Icons.content_cut,
      'desc': 'Remove and copy to clipboard',
    },
    {
      'action': 'Copy',
      'shortcut': 'Ctrl+C',
      'icon': Icons.content_copy,
      'desc': 'Copy to clipboard',
    },
    {
      'action': 'Paste',
      'shortcut': 'Ctrl+V',
      'icon': Icons.content_paste,
      'desc': 'Insert from clipboard',
    },
    {
      'action': 'Select All',
      'shortcut': 'Ctrl+A',
      'icon': Icons.select_all,
      'desc': 'Select all content',
    },
    {
      'action': 'Share',
      'shortcut': '-',
      'icon': Icons.share,
      'desc': 'Share selected text',
    },
    {
      'action': 'Search Web',
      'shortcut': '-',
      'icon': Icons.search,
      'desc': 'Search selected text online',
    },
  ];
  return Column(
    children: actions.map((a) {
      return Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Icon(a['icon'] as IconData, size: 20, color: Color(0xFF1565C0)),
            SizedBox(width: 10),
            SizedBox(
              width: 80,
              child: Text(
                a['action'] as String,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                a['shortcut'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF546E7A),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                a['desc'] as String,
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildAnchorPositions() {
  debugPrint('Building anchor positions');
  return Container(
    height: 280,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 50,
          top: 30,
          child: _buildMiniToolbar('Above Left', Color(0xFF1565C0)),
        ),
        Positioned(
          right: 50,
          top: 30,
          child: _buildMiniToolbar('Above Right', Color(0xFF4CAF50)),
        ),
        Positioned(
          left: 30,
          top: 100,
          child: Container(
            width: 300,
            height: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF1565C0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected text region here',
                  style: TextStyle(fontSize: 14),
                ),
                Container(
                  height: 2,
                  width: 200,
                  color: Color(0xFF1565C0).withValues(alpha: 0.3),
                  margin: EdgeInsets.only(top: 4),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 50,
          bottom: 50,
          child: _buildMiniToolbar('Below Left', Color(0xFFFF9800)),
        ),
        Positioned(
          right: 50,
          bottom: 50,
          child: _buildMiniToolbar('Below Right', Color(0xFF9C27B0)),
        ),
        Positioned(
          left: 340,
          top: 100,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xFFFF9800)),
            ),
            child: Text(
              'Toolbar position adapts\nto available space',
              style: TextStyle(fontSize: 10, color: Color(0xFFE65100)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniToolbar(String label, Color color) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color),
      boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.content_cut, size: 12, color: color),
            SizedBox(width: 4),
            Icon(Icons.content_copy, size: 12, color: color),
            SizedBox(width: 4),
            Icon(Icons.content_paste, size: 12, color: color),
          ],
        ),
      ],
    ),
  );
}

Widget _buildKeyboardShortcuts() {
  debugPrint('Building keyboard shortcuts');
  List<Map<String, String>> shortcuts = [
    {'keys': 'Ctrl + X', 'action': 'Cut selected text', 'mac': 'Cmd + X'},
    {'keys': 'Ctrl + C', 'action': 'Copy selected text', 'mac': 'Cmd + C'},
    {'keys': 'Ctrl + V', 'action': 'Paste from clipboard', 'mac': 'Cmd + V'},
    {'keys': 'Ctrl + A', 'action': 'Select all text', 'mac': 'Cmd + A'},
    {'keys': 'Ctrl + Z', 'action': 'Undo last action', 'mac': 'Cmd + Z'},
    {
      'keys': 'Ctrl + Shift + Z',
      'action': 'Redo last undo',
      'mac': 'Cmd + Shift + Z',
    },
    {
      'keys': 'Shift + Arrow',
      'action': 'Extend selection',
      'mac': 'Shift + Arrow',
    },
    {
      'keys': 'Ctrl + Shift + Arrow',
      'action': 'Select word',
      'mac': 'Opt + Shift + Arrow',
    },
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Windows/Linux',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'macOS',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Action',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...shortcuts.asMap().entries.map((entry) {
          bool alt = entry.key % 2 == 0;
          Map<String, String> s = entry.value;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: alt ? Color(0xFFF5F5F5) : Color(0xFFFFFFFF),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: _buildKeyBadge(s['keys']!)),
                Expanded(flex: 3, child: _buildKeyBadge(s['mac']!)),
                Expanded(
                  flex: 4,
                  child: Text(s['action']!, style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _buildKeyBadge(String keys) {
  return Text(
    keys,
    style: TextStyle(
      fontFamily: 'monospace',
      fontSize: 11,
      color: Color(0xFF37474F),
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _buildAccessibilityFeatures() {
  debugPrint('Building accessibility features');
  List<Map<String, dynamic>> features = [
    {
      'feature': 'Screen Reader Labels',
      'desc': 'All toolbar buttons have semantic labels',
      'icon': Icons.record_voice_over,
      'color': Color(0xFF1565C0),
    },
    {
      'feature': 'High Contrast',
      'desc': 'Sufficient color contrast for all elements',
      'icon': Icons.contrast,
      'color': Color(0xFF4CAF50),
    },
    {
      'feature': 'Keyboard Navigation',
      'desc': 'Full keyboard access to all actions',
      'icon': Icons.keyboard,
      'color': Color(0xFFFF9800),
    },
    {
      'feature': 'Focus Indicators',
      'desc': 'Visible focus rings on interactive elements',
      'icon': Icons.center_focus_strong,
      'color': Color(0xFF9C27B0),
    },
    {
      'feature': 'Large Touch Targets',
      'desc': 'Minimum 48dp for all interactive areas',
      'icon': Icons.touch_app,
      'color': Color(0xFFF44336),
    },
    {
      'feature': 'Tooltip Support',
      'desc': 'Descriptive tooltips on hover and long press',
      'icon': Icons.info_outline,
      'color': Color(0xFF00BCD4),
    },
  ];
  return Column(
    children: features.map((f) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (f['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                f['icon'] as IconData,
                color: f['color'] as Color,
                size: 24,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['feature'] as String,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(height: 2),
                  Text(
                    f['desc'] as String,
                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
            Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20),
          ],
        ),
      );
    }).toList(),
  );
}
