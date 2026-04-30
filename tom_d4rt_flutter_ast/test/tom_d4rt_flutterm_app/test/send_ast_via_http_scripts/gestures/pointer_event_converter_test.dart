// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PointerEventConverter concepts from package:flutter/gestures.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== PointerEventConverter Visual Demo ===');
  debugPrint(
    'Demonstrating pointer event types and their visual representations',
  );
  debugPrint('Showing coordinate systems, pressure, and device types');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PointerEventConverter Demo'),
        backgroundColor: Color(0xFF6200EA),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Pointer Event Types'),
            SizedBox(height: 8),
            _buildPointerEventTypesGrid(),
            SizedBox(height: 24),
            _buildSectionHeader('Pointer Device Types'),
            SizedBox(height: 8),
            _buildDeviceTypesDisplay(),
            SizedBox(height: 24),
            _buildSectionHeader('Coordinate System Visualization'),
            SizedBox(height: 8),
            _buildCoordinateDisplay(),
            SizedBox(height: 24),
            _buildSectionHeader('Pressure Indicators'),
            SizedBox(height: 8),
            _buildPressureIndicators(),
            SizedBox(height: 24),
            _buildSectionHeader('Pointer Button States'),
            SizedBox(height: 8),
            _buildButtonStatesDisplay(),
            SizedBox(height: 24),
            _buildSectionHeader('Pointer Tracking Zones'),
            SizedBox(height: 8),
            _buildTrackingZones(),
            SizedBox(height: 24),
            _buildSectionHeader('Event Sequence Timeline'),
            SizedBox(height: 8),
            _buildEventSequenceTimeline(),
            SizedBox(height: 24),
            _buildSectionHeader('Hover vs Touch Events'),
            SizedBox(height: 8),
            _buildHoverVsTouchComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('Pointer Signal Events'),
            SizedBox(height: 8),
            _buildPointerSignalDisplay(),
            SizedBox(height: 24),
            _buildSectionHeader('Multi-Pointer Scenario'),
            SizedBox(height: 8),
            _buildMultiPointerDisplay(),
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
      color: Color(0xFF6200EA),
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

Widget _buildPointerEventTypesGrid() {
  debugPrint('Building pointer event types grid');
  List<Map<String, dynamic>> eventTypes = [
    {
      'name': 'PointerDown',
      'icon': Icons.arrow_downward,
      'color': Color(0xFF4CAF50),
      'desc': 'Contact begins',
    },
    {
      'name': 'PointerMove',
      'icon': Icons.open_with,
      'color': Color(0xFF2196F3),
      'desc': 'Contact moves',
    },
    {
      'name': 'PointerUp',
      'icon': Icons.arrow_upward,
      'color': Color(0xFFFF9800),
      'desc': 'Contact ends',
    },
    {
      'name': 'PointerCancel',
      'icon': Icons.cancel,
      'color': Color(0xFFF44336),
      'desc': 'Contact cancelled',
    },
    {
      'name': 'PointerHover',
      'icon': Icons.near_me,
      'color': Color(0xFF9C27B0),
      'desc': 'Hover without contact',
    },
    {
      'name': 'PointerEnter',
      'icon': Icons.login,
      'color': Color(0xFF00BCD4),
      'desc': 'Enters target area',
    },
    {
      'name': 'PointerExit',
      'icon': Icons.logout,
      'color': Color(0xFF795548),
      'desc': 'Exits target area',
    },
    {
      'name': 'PointerScroll',
      'icon': Icons.swap_vert,
      'color': Color(0xFF607D8B),
      'desc': 'Scroll signal',
    },
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: eventTypes.map((et) {
      return Container(
        width: 170,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: et['color'] as Color, width: 2),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(et['icon'] as IconData, color: et['color'] as Color, size: 36),
            SizedBox(height: 8),
            Text(
              et['name'] as String,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              et['desc'] as String,
              style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildDeviceTypesDisplay() {
  debugPrint('Building device types display');
  List<Map<String, dynamic>> devices = [
    {'name': 'Touch', 'icon': Icons.touch_app, 'color': Color(0xFF4CAF50)},
    {'name': 'Mouse', 'icon': Icons.mouse, 'color': Color(0xFF2196F3)},
    {'name': 'Stylus', 'icon': Icons.edit, 'color': Color(0xFFFF9800)},
    {'name': 'Inv.Stylus', 'icon': Icons.edit_off, 'color': Color(0xFFF44336)},
    {'name': 'Trackpad', 'icon': Icons.laptop, 'color': Color(0xFF9C27B0)},
    {
      'name': 'Unknown',
      'icon': Icons.device_unknown,
      'color': Color(0xFF607D8B),
    },
  ];
  return Row(
    children: devices.map((d) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [d['color'] as Color, Color(0xFFFFFFFF)],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              Icon(d['icon'] as IconData, size: 28, color: Color(0xFFFFFFFF)),
              SizedBox(height: 6),
              Text(
                d['name'] as String,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildCoordinateDisplay() {
  debugPrint('Building coordinate display');
  List<Map<String, String>> coords = [
    {'label': 'Physical X', 'value': '412.5'},
    {'label': 'Physical Y', 'value': '678.3'},
    {'label': 'Logical X', 'value': '137.5'},
    {'label': 'Logical Y', 'value': '226.1'},
    {'label': 'Local X', 'value': '45.0'},
    {'label': 'Local Y', 'value': '32.0'},
  ];
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.grid_on, color: Color(0xFF00E676), size: 20),
            SizedBox(width: 8),
            Text(
              'Coordinate Spaces',
              style: TextStyle(
                color: Color(0xFF00E676),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: coords.map((c) {
            return Container(
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF16213E),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF0F3460)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['label']!,
                    style: TextStyle(color: Color(0xFF90CAF9), fontSize: 11),
                  ),
                  SizedBox(height: 4),
                  Text(
                    c['value']!,
                    style: TextStyle(
                      color: Color(0xFF00E676),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF0F3460), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 50,
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: Color(0x330F3460)),
              ),
              Positioned(
                left: 100,
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: Color(0x330F3460)),
              ),
              Positioned(
                left: 150,
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: Color(0x330F3460)),
              ),
              Positioned(
                left: 200,
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: Color(0x330F3460)),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(height: 1, color: Color(0x330F3460)),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Container(height: 1, color: Color(0x330F3460)),
              ),
              Positioned(
                left: 130,
                top: 70,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF1744),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color(0x66FF1744), blurRadius: 8),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 66,
                child: Text(
                  '(137.5, 226.1)',
                  style: TextStyle(
                    color: Color(0xFFFF1744),
                    fontSize: 11,
                    fontFamily: 'monospace',
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

Widget _buildPressureIndicators() {
  debugPrint('Building pressure indicators');
  List<double> pressureLevels = [0.0, 0.15, 0.3, 0.5, 0.7, 0.85, 1.0];
  return Column(
    children: [
      Row(
        children: pressureLevels.map((p) {
          int alpha = (p * 255).toInt();
          if (alpha < 30) alpha = 30;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 80 + (p * 60),
              decoration: BoxDecoration(
                color: Color.fromARGB(alpha, 244, 67, 54),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFF44336)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app, color: Color(0xFFFFFFFF), size: 20),
                    SizedBox(height: 4),
                    Text(
                      '${(p * 100).toInt()}%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFFCC80)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFFFF9800)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Pressure ranges from 0.0 (no pressure) to 1.0 (max). Not all devices report pressure. Touch typically does, mouse does not.',
                style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Row(
        children: [
          _buildPressureCard('Stylus Pressure', 0.65, Color(0xFF9C27B0)),
          SizedBox(width: 8),
          _buildPressureCard('Stylus Tilt', 0.3, Color(0xFF00BCD4)),
          SizedBox(width: 8),
          _buildPressureCard('Touch Size', 0.45, Color(0xFF4CAF50)),
        ],
      ),
    ],
  );
}

Widget _buildPressureCard(String label, double value, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: value,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${(value * 100).toInt()}%',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget _buildButtonStatesDisplay() {
  debugPrint('Building button states display');
  List<Map<String, dynamic>> buttons = [
    {
      'name': 'Primary (Left)',
      'value': '0x01',
      'color': Color(0xFF4CAF50),
      'active': true,
    },
    {
      'name': 'Secondary (Right)',
      'value': '0x02',
      'color': Color(0xFF2196F3),
      'active': false,
    },
    {
      'name': 'Tertiary (Middle)',
      'value': '0x04',
      'color': Color(0xFFFF9800),
      'active': true,
    },
    {
      'name': 'Back',
      'value': '0x08',
      'color': Color(0xFF9C27B0),
      'active': false,
    },
    {
      'name': 'Forward',
      'value': '0x10',
      'color': Color(0xFFF44336),
      'active': false,
    },
    {
      'name': 'Stylus Primary',
      'value': '0x20',
      'color': Color(0xFF00BCD4),
      'active': true,
    },
  ];
  return Column(
    children: buttons.map((b) {
      bool active = b['active'] as bool;
      return Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? (b['color'] as Color).withValues(alpha: 0.1)
              : Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? b['color'] as Color : Color(0xFFBDBDBD),
            width: active ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: active ? b['color'] as Color : Color(0xFFBDBDBD),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                b['name'] as String,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                b['value'] as String,
                style: TextStyle(
                  color: Color(0xFF00E676),
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              active ? 'PRESSED' : 'RELEASED',
              style: TextStyle(
                color: active ? b['color'] as Color : Color(0xFF9E9E9E),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildTrackingZones() {
  debugPrint('Building tracking zones');
  return Container(
    height: 250,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 20,
          top: 20,
          child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0x334CAF50),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF4CAF50), width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.touch_app, color: Color(0xFF4CAF50)),
                  Text(
                    'Hit Test Zone A',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 190,
          top: 30,
          child: Container(
            width: 130,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0x332196F3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF2196F3), width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.near_me, color: Color(0xFF2196F3)),
                  Text(
                    'Hover Zone',
                    style: TextStyle(
                      color: Color(0xFF2196F3),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 40,
          top: 140,
          child: Container(
            width: 200,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0x33FF9800),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFFF9800), width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.open_with, color: Color(0xFFFF9800)),
                  Text(
                    'Drag Zone',
                    style: TextStyle(
                      color: Color(0xFFFF9800),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 50,
          top: 50,
          child: _buildPointerDot(Color(0xFFFF1744)),
        ),
        Positioned(
          left: 70,
          top: 55,
          child: _buildPointerDot(Color(0xFFFF5252)),
        ),
        Positioned(
          left: 95,
          top: 58,
          child: _buildPointerDot(Color(0xFFFF8A80)),
        ),
        Positioned(
          left: 120,
          top: 62,
          child: _buildPointerDot(Color(0xFFFFCDD2)),
        ),
        Positioned(
          right: 20,
          top: 130,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0x339C27B0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF9C27B0), width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.swap_vert, color: Color(0xFF9C27B0)),
                  Text(
                    'Scroll Zone',
                    style: TextStyle(
                      color: Color(0xFF9C27B0),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPointerDot(Color color) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 4),
      ],
    ),
  );
}

Widget _buildEventSequenceTimeline() {
  debugPrint('Building event sequence timeline');
  List<Map<String, dynamic>> events = [
    {'event': 'PointerEnter', 'time': '0ms', 'color': Color(0xFF00BCD4)},
    {'event': 'PointerHover', 'time': '16ms', 'color': Color(0xFF9C27B0)},
    {'event': 'PointerDown', 'time': '150ms', 'color': Color(0xFF4CAF50)},
    {'event': 'PointerMove', 'time': '166ms', 'color': Color(0xFF2196F3)},
    {'event': 'PointerMove', 'time': '182ms', 'color': Color(0xFF2196F3)},
    {'event': 'PointerMove', 'time': '198ms', 'color': Color(0xFF2196F3)},
    {'event': 'PointerUp', 'time': '350ms', 'color': Color(0xFFFF9800)},
    {'event': 'PointerHover', 'time': '366ms', 'color': Color(0xFF9C27B0)},
    {'event': 'PointerExit', 'time': '500ms', 'color': Color(0xFF795548)},
  ];
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: events.asMap().entries.map((entry) {
        int idx = entry.key;
        Map<String, dynamic> e = entry.value;
        bool isLast = idx == events.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: e['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Container(width: 2, height: 30, color: Color(0xFFBDBDBD)),
              ],
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 50,
              child: Text(
                e['time'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF757575),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: (e['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: e['color'] as Color),
              ),
              child: Text(
                e['event'] as String,
                style: TextStyle(
                  color: e['color'] as Color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    ),
  );
}

Widget _buildHoverVsTouchComparison() {
  debugPrint('Building hover vs touch comparison');
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF4CAF50), width: 2),
          ),
          child: Column(
            children: [
              Icon(Icons.touch_app, color: Color(0xFF4CAF50), size: 40),
              SizedBox(height: 8),
              Text(
                'Touch Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 12),
              _buildFeatureRow('Has pressure', true),
              _buildFeatureRow('Has size', true),
              _buildFeatureRow('Has hover', false),
              _buildFeatureRow('Down required', true),
              _buildFeatureRow('Multi-touch', true),
              _buildFeatureRow('Buttons', false),
            ],
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF2196F3), width: 2),
          ),
          child: Column(
            children: [
              Icon(Icons.mouse, color: Color(0xFF2196F3), size: 40),
              SizedBox(height: 8),
              Text(
                'Mouse Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1565C0),
                ),
              ),
              SizedBox(height: 12),
              _buildFeatureRow('Has pressure', false),
              _buildFeatureRow('Has size', false),
              _buildFeatureRow('Has hover', true),
              _buildFeatureRow('Down required', false),
              _buildFeatureRow('Multi-touch', false),
              _buildFeatureRow('Buttons', true),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildFeatureRow(String label, bool supported) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          supported ? Icons.check_circle : Icons.cancel,
          color: supported ? Color(0xFF4CAF50) : Color(0xFFE0E0E0),
          size: 16,
        ),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _buildPointerSignalDisplay() {
  debugPrint('Building pointer signal display');
  return Column(
    children: [
      _buildSignalCard(
        'PointerScrollEvent',
        'Scroll wheel or trackpad scroll gesture',
        Icons.swap_vert,
        Color(0xFF2196F3),
        [
          'scrollDelta: Offset(0.0, -53.0)',
          'device: mouse',
          'position: (200.0, 300.0)',
        ],
      ),
      SizedBox(height: 8),
      _buildSignalCard(
        'PointerScaleEvent',
        'Trackpad pinch-to-zoom gesture',
        Icons.zoom_in,
        Color(0xFF4CAF50),
        ['scale: 1.05', 'device: trackpad', 'position: (200.0, 300.0)'],
      ),
      SizedBox(height: 8),
      _buildSignalCard(
        'PointerPanZoomStart',
        'Trackpad pan/zoom gesture begins',
        Icons.pan_tool,
        Color(0xFFFF9800),
        ['device: trackpad', 'position: (200.0, 300.0)'],
      ),
    ],
  );
}

Widget _buildSignalCard(
  String title,
  String desc,
  IconData icon,
  Color color,
  List<String> props,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
              ),
              SizedBox(height: 8),
              ...props.map(
                (p) => Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    p,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF546E7A),
                    ),
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

Widget _buildMultiPointerDisplay() {
  debugPrint('Building multi-pointer display');
  List<Map<String, dynamic>> pointers = [
    {
      'id': 1,
      'x': 50.0,
      'y': 60.0,
      'color': Color(0xFFF44336),
      'device': 'Touch',
    },
    {
      'id': 2,
      'x': 150.0,
      'y': 80.0,
      'color': Color(0xFF4CAF50),
      'device': 'Touch',
    },
    {
      'id': 3,
      'x': 250.0,
      'y': 45.0,
      'color': Color(0xFF2196F3),
      'device': 'Touch',
    },
    {
      'id': 4,
      'x': 100.0,
      'y': 130.0,
      'color': Color(0xFFFF9800),
      'device': 'Mouse',
    },
  ];
  return Column(
    children: [
      Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF263238),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: pointers.map((p) {
            return Positioned(
              left: (p['x'] as double),
              top: (p['y'] as double),
              child: Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: (p['color'] as Color).withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: p['color'] as Color, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${p['id']}',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${p['device']}',
                    style: TextStyle(color: p['color'] as Color, fontSize: 9),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: pointers.map((p) {
          return Container(
            width: 160,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: p['color'] as Color),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: p['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${p['id']}',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Pointer ${p['id']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  'Device: ${p['device']}',
                  style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
                ),
                Text(
                  'Position: (${p['x']}, ${p['y']})',
                  style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ],
  );
}
