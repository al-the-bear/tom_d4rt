// ignore_for_file: avoid_print
// D4rt test script: Tests DrawerButtonIcon concepts from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DrawerButtonIcon Visual Demo ===');
  debugPrint(
    'Demonstrating hamburger menu icon variations, sizes, colors, and animation states',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DrawerButtonIcon Demo'),
        backgroundColor: Color(0xFF455A64),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Standard Hamburger Icon'),
            SizedBox(height: 8),
            _buildStandardIcon(),
            SizedBox(height: 24),
            _buildSectionHeader('Icon Size Variations'),
            SizedBox(height: 8),
            _buildSizeVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Color Variations'),
            SizedBox(height: 8),
            _buildColorVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Icon with Backgrounds'),
            SizedBox(height: 8),
            _buildIconWithBackgrounds(),
            SizedBox(height: 24),
            _buildSectionHeader('Animation Progress States'),
            SizedBox(height: 8),
            _buildAnimationProgressStates(),
            SizedBox(height: 24),
            _buildSectionHeader('Line Weight Variations'),
            SizedBox(height: 8),
            _buildLineWeightVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Icon in Different Containers'),
            SizedBox(height: 8),
            _buildIconInContainers(),
            SizedBox(height: 24),
            _buildSectionHeader('Hamburger to Arrow Morphing'),
            SizedBox(height: 8),
            _buildHamburgerToArrow(),
            SizedBox(height: 24),
            _buildSectionHeader('Platform Style Comparison'),
            SizedBox(height: 8),
            _buildPlatformStyleComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('Accessibility & Touch Target'),
            SizedBox(height: 8),
            _buildAccessibilityDisplay(),
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
      color: Color(0xFF455A64),
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

Widget _buildStandardIcon() {
  debugPrint('Building standard hamburger icon');
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: _buildHamburgerLines(24.0, 2.0, Color(0xFF455A64), 6.0),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DrawerButtonIcon',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 6),
              Text(
                'The standard three-line hamburger menu icon used to trigger the opening of a navigation drawer.',
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Icon(Icons.menu)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFF283593),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHamburgerLines(
  double width,
  double lineHeight,
  Color color,
  double spacing,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: width,
        height: lineHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(lineHeight / 2),
        ),
      ),
      SizedBox(height: spacing),
      Container(
        width: width,
        height: lineHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(lineHeight / 2),
        ),
      ),
      SizedBox(height: spacing),
      Container(
        width: width,
        height: lineHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(lineHeight / 2),
        ),
      ),
    ],
  );
}

Widget _buildSizeVariations() {
  debugPrint('Building size variations');
  List<Map<String, dynamic>> sizes = [
    {'label': '16dp', 'size': 16.0, 'lineH': 1.5, 'spacing': 3.0},
    {'label': '20dp', 'size': 20.0, 'lineH': 2.0, 'spacing': 4.0},
    {'label': '24dp (default)', 'size': 24.0, 'lineH': 2.0, 'spacing': 5.0},
    {'label': '30dp', 'size': 30.0, 'lineH': 2.5, 'spacing': 6.0},
    {'label': '36dp', 'size': 36.0, 'lineH': 3.0, 'spacing': 7.0},
    {'label': '48dp', 'size': 48.0, 'lineH': 3.5, 'spacing': 10.0},
  ];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: sizes.map((s) {
      return Column(
        children: [
          Container(
            width: (s['size'] as double) + 30,
            height: (s['size'] as double) + 30,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFE0E0E0)),
            ),
            child: Center(
              child: _buildHamburgerLines(
                s['size'] as double,
                s['lineH'] as double,
                Color(0xFF455A64),
                s['spacing'] as double,
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            s['label'] as String,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }).toList(),
  );
}

Widget _buildColorVariations() {
  debugPrint('Building color variations');
  List<Map<String, dynamic>> colors = [
    {'label': 'Default', 'color': Color(0xFF455A64), 'bg': Color(0xFFFFFFFF)},
    {'label': 'Primary', 'color': Color(0xFF1565C0), 'bg': Color(0xFFE3F2FD)},
    {'label': 'Success', 'color': Color(0xFF2E7D32), 'bg': Color(0xFFE8F5E9)},
    {'label': 'Warning', 'color': Color(0xFFFF6F00), 'bg': Color(0xFFFFF3E0)},
    {'label': 'Error', 'color': Color(0xFFC62828), 'bg': Color(0xFFFFEBEE)},
    {
      'label': 'White on Dark',
      'color': Color(0xFFFFFFFF),
      'bg': Color(0xFF263238),
    },
    {'label': 'Purple', 'color': Color(0xFF6A1B9A), 'bg': Color(0xFFF3E5F5)},
    {'label': 'Teal', 'color': Color(0xFF00695C), 'bg': Color(0xFFE0F2F1)},
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: colors.map((c) {
      return Container(
        width: 90,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: c['bg'] as Color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (c['color'] as Color).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            _buildHamburgerLines(22.0, 2.0, c['color'] as Color, 5.0),
            SizedBox(height: 8),
            Text(
              c['label'] as String,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: c['color'] as Color,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildIconWithBackgrounds() {
  debugPrint('Building icon with backgrounds');
  List<Map<String, dynamic>> bgStyles = [
    {
      'label': 'Circle',
      'shape': BoxShape.circle,
      'radius': 0.0,
      'color': Color(0xFF455A64),
    },
    {
      'label': 'Rounded Rect',
      'shape': BoxShape.rectangle,
      'radius': 8.0,
      'color': Color(0xFF1565C0),
    },
    {
      'label': 'Pill',
      'shape': BoxShape.rectangle,
      'radius': 24.0,
      'color': Color(0xFF2E7D32),
    },
    {
      'label': 'Square',
      'shape': BoxShape.rectangle,
      'radius': 0.0,
      'color': Color(0xFFFF6F00),
    },
    {
      'label': 'Outlined Circle',
      'shape': BoxShape.circle,
      'radius': 0.0,
      'color': Color(0xFF6A1B9A),
    },
  ];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: bgStyles.map((bs) {
      bool isOutlined = bs['label'] == 'Outlined Circle';
      bool isCircle = bs['shape'] == BoxShape.circle;
      return Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isOutlined
                  ? Color(0x00000000)
                  : (bs['color'] as Color).withValues(alpha: 0.15),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircle
                  ? null
                  : BorderRadius.circular(bs['radius'] as double),
              border: isOutlined
                  ? Border.all(color: bs['color'] as Color, width: 2)
                  : null,
            ),
            child: Center(
              child: Icon(Icons.menu, color: bs['color'] as Color, size: 24),
            ),
          ),
          SizedBox(height: 6),
          Text(
            bs['label'] as String,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }).toList(),
  );
}

Widget _buildAnimationProgressStates() {
  debugPrint('Building animation progress states');
  List<Map<String, dynamic>> states = [
    {'label': '0% (Menu)', 'progress': 0.0, 'icon': Icons.menu},
    {'label': '25%', 'progress': 0.25, 'icon': Icons.menu},
    {'label': '50%', 'progress': 0.50, 'icon': Icons.menu_open},
    {'label': '75%', 'progress': 0.75, 'icon': Icons.arrow_back},
    {'label': '100% (Arrow)', 'progress': 1.0, 'icon': Icons.arrow_back},
  ];
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: states.map((s) {
            double progress = s['progress'] as double;
            return Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color(0x22000000), blurRadius: 4),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      s['icon'] as IconData,
                      color: Color(0xFF455A64),
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  s['label'] as String,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(fontSize: 8, color: Color(0xFF607D8B)),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 25,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFF607D8B)),
                ),
              ),
              Expanded(
                flex: 25,
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFF90A4AE)),
                ),
              ),
              Expanded(
                flex: 25,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFB0BEC5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Menu',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF455A64),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Arrow Back',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFFB0BEC5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLineWeightVariations() {
  debugPrint('Building line weight variations');
  List<Map<String, double>> weights = [
    {'weight': 1.0},
    {'weight': 1.5},
    {'weight': 2.0},
    {'weight': 2.5},
    {'weight': 3.0},
    {'weight': 4.0},
  ];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: weights.map((w) {
      double lw = w['weight']!;
      return Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFE0E0E0)),
            ),
            child: Center(
              child: _buildHamburgerLines(
                26.0,
                lw,
                Color(0xFF455A64),
                7.0 - lw,
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            '${lw}dp',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }).toList(),
  );
}

Widget _buildIconInContainers() {
  debugPrint('Building icon in different containers');
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: _buildContainerDemo(
          'AppBar',
          Color(0xFF455A64),
          Color(0xFFFFFFFF),
          true,
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: _buildContainerDemo(
          'BottomNav',
          Color(0xFFF5F5F5),
          Color(0xFF455A64),
          false,
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: _buildContainerDemo(
          'FloatingButton',
          Color(0xFF1565C0),
          Color(0xFFFFFFFF),
          true,
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: _buildContainerDemo(
          'Card',
          Color(0xFFFFFFFF),
          Color(0xFF455A64),
          false,
        ),
      ),
    ],
  );
}

Widget _buildContainerDemo(String label, Color bg, Color fg, bool elevated) {
  return Container(
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: elevated ? null : Border.all(color: Color(0xFFE0E0E0)),
      boxShadow: elevated
          ? [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ]
          : [],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.menu, color: fg, size: 24),
        ),
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: fg.withValues(alpha: 0.1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildHamburgerToArrow() {
  debugPrint('Building hamburger to arrow morphing');
  List<Map<String, dynamic>> steps = [
    {'label': 'Closed', 'icon': Icons.menu, 'desc': 'Three horizontal lines'},
    {
      'label': 'Opening',
      'icon': Icons.menu_open,
      'desc': 'Lines start rotating',
    },
    {
      'label': 'Midway',
      'icon': Icons.menu_open,
      'desc': 'Top and bottom rotate 45 degrees',
    },
    {
      'label': 'Almost',
      'icon': Icons.arrow_back,
      'desc': 'Lines form arrow shape',
    },
    {'label': 'Open', 'icon': Icons.arrow_back, 'desc': 'Full back arrow'},
  ];
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: steps.asMap().entries.map((entry) {
        int idx = entry.key;
        Map<String, dynamic> s = entry.value;
        return Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  s['icon'] as IconData,
                  color: Color(0xFFECEFF1),
                  size: 22,
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              s['label'] as String,
              style: TextStyle(
                color: Color(0xFFB0BEC5),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            SizedBox(
              width: 55,
              child: Text(
                s['desc'] as String,
                style: TextStyle(color: Color(0xFF78909C), fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ),
            if (idx < steps.length - 1) ...[
              SizedBox(height: 4),
              Icon(Icons.arrow_forward, size: 10, color: Color(0xFF546E7A)),
            ],
          ],
        );
      }).toList(),
    ),
  );
}

Widget _buildPlatformStyleComparison() {
  debugPrint('Building platform style comparison');
  List<Map<String, dynamic>> platforms = [
    {
      'platform': 'Material 2',
      'icon': Icons.menu,
      'color': Color(0xFF455A64),
      'desc': 'Standard 3-line icon',
    },
    {
      'platform': 'Material 3',
      'icon': Icons.menu,
      'color': Color(0xFF6200EA),
      'desc': 'Tinted, rounded corners',
    },
    {
      'platform': 'iOS',
      'icon': Icons.arrow_back_ios_new,
      'color': Color(0xFF007AFF),
      'desc': 'Back chevron preferred',
    },
    {
      'platform': 'Windows',
      'icon': Icons.menu,
      'color': Color(0xFF0078D4),
      'desc': 'Hamburger or nav bar',
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
            Icon(p['icon'] as IconData, color: p['color'] as Color, size: 32),
            SizedBox(height: 8),
            Text(
              p['platform'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: p['color'] as Color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              p['desc'] as String,
              style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildAccessibilityDisplay() {
  debugPrint('Building accessibility display');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFF44336),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(Icons.menu, size: 24, color: Color(0xFF455A64)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color(0xFFF44336),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '48',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minimum Touch Target: 48x48dp',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'The DrawerButtonIcon should always have sufficient touch area even when the visual icon is smaller.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildAccessRow(
          'Semantic label',
          'Open navigation menu',
          Icons.record_voice_over,
        ),
        SizedBox(height: 6),
        _buildAccessRow(
          'Focus visible',
          'Keyboard focus ring displayed',
          Icons.center_focus_strong,
        ),
        SizedBox(height: 6),
        _buildAccessRow(
          'Tooltip',
          'Open navigation drawer',
          Icons.info_outline,
        ),
        SizedBox(height: 6),
        _buildAccessRow(
          'Contrast ratio',
          '4.5:1 minimum (WCAG AA)',
          Icons.contrast,
        ),
      ],
    ),
  );
}

Widget _buildAccessRow(String label, String value, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 18, color: Color(0xFF455A64)),
      SizedBox(width: 8),
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          value,
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ),
    ],
  );
}
