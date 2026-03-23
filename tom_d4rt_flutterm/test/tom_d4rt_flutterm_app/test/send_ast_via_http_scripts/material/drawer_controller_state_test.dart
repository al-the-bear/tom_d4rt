// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DrawerControllerState concepts from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DrawerControllerState Visual Demo ===');
  debugPrint(
    'Demonstrating drawer open/close states, animation, width, scrim, gestures, and callbacks',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DrawerControllerState Demo'),
        backgroundColor: Color(0xFF4A148C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Drawer Open/Close States'),
            SizedBox(height: 8),
            _buildOpenCloseStates(),
            SizedBox(height: 24),
            _buildSectionHeader('Animation Progress Visualization'),
            SizedBox(height: 8),
            _buildAnimationProgress(),
            SizedBox(height: 24),
            _buildSectionHeader('Width Configurations'),
            SizedBox(height: 8),
            _buildWidthConfigurations(),
            SizedBox(height: 24),
            _buildSectionHeader('Scrim / Barrier Settings'),
            SizedBox(height: 8),
            _buildScrimSettings(),
            SizedBox(height: 24),
            _buildSectionHeader('Edge Drag Width'),
            SizedBox(height: 8),
            _buildEdgeDragWidth(),
            SizedBox(height: 24),
            _buildSectionHeader('Gesture Detection Zones'),
            SizedBox(height: 8),
            _buildGestureDetectionZones(),
            SizedBox(height: 24),
            _buildSectionHeader('Drawer Direction'),
            SizedBox(height: 8),
            _buildDrawerDirection(),
            SizedBox(height: 24),
            _buildSectionHeader('Callback Timeline'),
            SizedBox(height: 8),
            _buildCallbackTimeline(),
            SizedBox(height: 24),
            _buildSectionHeader('State Transition Diagram'),
            SizedBox(height: 8),
            _buildStateTransitionDiagram(),
            SizedBox(height: 24),
            _buildSectionHeader('DrawerController Properties'),
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
    decoration: BoxDecoration(
      color: Color(0xFF4A148C),
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

Widget _buildOpenCloseStates() {
  debugPrint('Building open/close states');
  List<Map<String, dynamic>> states = [
    {
      'label': 'Fully Closed',
      'progress': 0.0,
      'drawerVisible': false,
      'scrimVisible': false,
    },
    {
      'label': 'Opening (25%)',
      'progress': 0.25,
      'drawerVisible': true,
      'scrimVisible': true,
    },
    {
      'label': 'Half Open (50%)',
      'progress': 0.50,
      'drawerVisible': true,
      'scrimVisible': true,
    },
    {
      'label': 'Almost Open (75%)',
      'progress': 0.75,
      'drawerVisible': true,
      'scrimVisible': true,
    },
    {
      'label': 'Fully Open (100%)',
      'progress': 1.0,
      'drawerVisible': true,
      'scrimVisible': true,
    },
  ];
  return Row(
    children: states.map((s) {
      double p = s['progress'] as double;
      double drawerWidth = 34.0 * p;
      bool scrim = s['scrimVisible'] as bool;
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: [
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Color(0xFFB0BEC5)),
                ),
                child: Stack(
                  children: [
                    if (scrim)
                      Positioned.fill(
                        child: Container(
                          color: Color(0xFF000000).withValues(alpha: 0.3 * p),
                        ),
                      ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: drawerWidth,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF6A1B9A),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    if (p == 0.0)
                      Center(
                        child: Icon(
                          Icons.lock_outline,
                          size: 14,
                          color: Color(0xFFB0BEC5),
                        ),
                      ),
                    if (p == 1.0)
                      Center(
                        child: Icon(
                          Icons.lock_open,
                          size: 14,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Text(
                s['label'] as String,
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildAnimationProgress() {
  debugPrint('Building animation progress');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Animation Value',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              '0.0 -> 1.0',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...List.generate(11, (i) {
          double v = i / 10.0;
          return Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  child: Text(
                    v.toStringAsFixed(1),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Color(0xFFE1BEE7),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: v == 0 ? 0.01 : v,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(
                            0xFF6A1B9A,
                          ).withValues(alpha: 0.4 + (v * 0.6)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 36,
                  child: Text(
                    '${(v * 100).toInt()}%',
                    style: TextStyle(fontSize: 10, color: Color(0xFF6A1B9A)),
                  ),
                ),
              ],
            ),
          );
        }),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Color(0xFF6A1B9A)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'DrawerController uses an AnimationController with duration of 250ms by default. The value property ranges from 0.0 (fully closed) to 1.0 (fully open).',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildWidthConfigurations() {
  debugPrint('Building width configurations');
  List<Map<String, dynamic>> widths = [
    {'label': 'Compact', 'width': 200.0, 'ratio': 0.5, 'desc': 'Narrow drawer'},
    {
      'label': 'Standard (304dp)',
      'width': 304.0,
      'ratio': 0.76,
      'desc': 'Material default',
    },
    {
      'label': 'Wide',
      'width': 360.0,
      'ratio': 0.9,
      'desc': 'Extra wide content',
    },
    {
      'label': 'Max (80%)',
      'width': 320.0,
      'ratio': 0.8,
      'desc': '80% of screen width',
    },
  ];
  return Column(
    children: widths.map((w) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  w['label'] as String,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(width: 6),
                Text(
                  '(${(w['width'] as double).toInt()}dp)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  FractionallySizedBox(
                    child: Container(
                      width: (w['ratio'] as double) * 300,
                      decoration: BoxDecoration(
                        color: Color(0xFF6A1B9A).withValues(alpha: 0.25),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Drawer',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF4A148C),
                            fontWeight: FontWeight.bold,
                          ),
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
    }).toList(),
  );
}

Widget _buildScrimSettings() {
  debugPrint('Building scrim settings');
  List<Map<String, dynamic>> scrimStyles = [
    {
      'label': 'No Scrim',
      'opacity': 0.0,
      'color': Color(0x00000000),
      'desc': 'Content fully visible behind drawer',
    },
    {
      'label': 'Light Scrim',
      'opacity': 0.25,
      'color': Color(0xFF000000),
      'desc': '25% black overlay',
    },
    {
      'label': 'Default Scrim',
      'opacity': 0.54,
      'color': Color(0xFF000000),
      'desc': '54% black (Material default)',
    },
    {
      'label': 'Dark Scrim',
      'opacity': 0.8,
      'color': Color(0xFF000000),
      'desc': '80% black overlay',
    },
    {
      'label': 'Colored Scrim',
      'opacity': 0.3,
      'color': Color(0xFF4A148C),
      'desc': 'Custom brand color overlay',
    },
  ];
  return Column(
    children: scrimStyles.map((s) {
      double opacity = s['opacity'] as double;
      Color col = s['color'] as Color;
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xFFECEFF1),
                        child: Center(
                          child: Text(
                            'Content area',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Container(color: col.withValues(alpha: opacity)),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 70,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                  boxShadow: [
                    BoxShadow(color: Color(0x33000000), blurRadius: 4),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Drawer',
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF4A148C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      s['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: opacity > 0.4
                            ? Color(0xFFFFFFFF)
                            : Color(0xFF263238),
                      ),
                    ),
                    Text(
                      s['desc'] as String,
                      style: TextStyle(
                        fontSize: 8,
                        color: opacity > 0.4
                            ? Color(0xFFE0E0E0)
                            : Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildEdgeDragWidth() {
  debugPrint('Building edge drag width');
  List<Map<String, dynamic>> dragWidths = [
    {'label': '20dp (narrow)', 'width': 20.0},
    {'label': '40dp (default)', 'width': 40.0},
    {'label': '60dp', 'width': 60.0},
    {'label': '100dp (wide)', 'width': 100.0},
    {'label': 'Full screen', 'width': 300.0},
  ];
  return Column(
    children: dragWidths.map((d) {
      double w = d['width'] as double;
      double normalizedW = (w / 300.0).clamp(0.0, 1.0);
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                d['label'] as String,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: normalizedW * 250,
                        decoration: BoxDecoration(
                          color: Color(0xFF7C4DFF).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                          border: Border(
                            right: BorderSide(
                              color: Color(0xFF7C4DFF),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.swipe_right,
                                size: 14,
                                color: Color(0xFF4A148C),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Drag zone',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF4A148C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildGestureDetectionZones() {
  debugPrint('Building gesture detection zones');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gesture Zones',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF7C4DFF).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'EDGE DRAG',
                        style: TextStyle(
                          color: Color(0xFFB388FF),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 42,
                top: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGestureLabel(
                      'Horizontal drag start',
                      Color(0xFFB388FF),
                    ),
                    SizedBox(height: 4),
                    _buildGestureLabel(
                      'Pan gesture detector',
                      Color(0xFF80CBC4),
                    ),
                    SizedBox(height: 4),
                    _buildGestureLabel(
                      'Velocity threshold: 365dp/s',
                      Color(0xFFFFAB91),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildGestureLabel('Tap scrim to close', Color(0xFFEF9A9A)),
                    SizedBox(height: 4),
                    _buildGestureLabel(
                      'Swipe left to close',
                      Color(0xFFCE93D8),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF4A148C),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'minFlingVelocity: 365.0 dp/s | maxFlingVelocity: 8000.0 dp/s',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9,
                        color: Color(0xFFE1BEE7),
                      ),
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

Widget _buildGestureLabel(String text, Color color) {
  return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 6),
      Text(text, style: TextStyle(color: color, fontSize: 10)),
    ],
  );
}

Widget _buildDrawerDirection() {
  debugPrint('Building drawer direction');
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF6A1B9A), width: 2),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_forward, color: Color(0xFF6A1B9A), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'LTR: Start',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF6A1B9A),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.chevron_right,
                          color: Color(0xFFFFFFFF),
                          size: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Body',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFBDBDBD),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Slides from left',
                style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFC62828), width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'LTR: End',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFFC62828),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_back, color: Color(0xFFC62828), size: 20),
                ],
              ),
              SizedBox(height: 12),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Body',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFBDBDBD),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFC62828),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.chevron_left,
                          color: Color(0xFFFFFFFF),
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Slides from right',
                style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildCallbackTimeline() {
  debugPrint('Building callback timeline');
  List<Map<String, dynamic>> callbacks = [
    {
      'label': 'onDrawerChanged(true)',
      'desc': 'Drawer starts opening',
      'icon': Icons.play_arrow,
      'color': Color(0xFF4CAF50),
    },
    {
      'label': 'Animation tick',
      'desc': 'Value: 0.0 -> 0.50',
      'icon': Icons.trending_up,
      'color': Color(0xFF2196F3),
    },
    {
      'label': 'Animation tick',
      'desc': 'Value: 0.50 -> 1.00',
      'icon': Icons.trending_up,
      'color': Color(0xFF2196F3),
    },
    {
      'label': 'StatusListener(completed)',
      'desc': 'Drawer fully open',
      'icon': Icons.check,
      'color': Color(0xFF6A1B9A),
    },
    {
      'label': 'User taps scrim',
      'desc': 'Close initiated',
      'icon': Icons.touch_app,
      'color': Color(0xFFFF6F00),
    },
    {
      'label': 'onDrawerChanged(false)',
      'desc': 'Drawer starts closing',
      'icon': Icons.stop,
      'color': Color(0xFFF44336),
    },
    {
      'label': 'Animation tick',
      'desc': 'Value: 1.00 -> 0.0',
      'icon': Icons.trending_down,
      'color': Color(0xFF2196F3),
    },
    {
      'label': 'StatusListener(dismissed)',
      'desc': 'Drawer fully closed',
      'icon': Icons.close,
      'color': Color(0xFF9E9E9E),
    },
  ];
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: callbacks.asMap().entries.map((entry) {
        int idx = entry.key;
        Map<String, dynamic> c = entry.value;
        bool isLast = idx == callbacks.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: c['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      c['icon'] as IconData,
                      size: 14,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                if (!isLast)
                  Container(width: 2, height: 24, color: Color(0xFFE0E0E0)),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: c['color'] as Color,
                    ),
                  ),
                  Text(
                    c['desc'] as String,
                    style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
                  ),
                  if (!isLast) SizedBox(height: 10),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    ),
  );
}

Widget _buildStateTransitionDiagram() {
  debugPrint('Building state transition diagram');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A237E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'DrawerControllerState Transitions',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStateBox('CLOSED', Color(0xFF9E9E9E), 'dismissed'),
            _buildArrow(Color(0xFF4CAF50), 'open()'),
            _buildStateBox('OPENING', Color(0xFF4CAF50), 'forward'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildArrow(Color(0xFFF44336), 'close()'),
            SizedBox(width: 40),
            _buildArrow(Color(0xFF2196F3), 'complete'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStateBox('CLOSING', Color(0xFFF44336), 'reverse'),
            _buildArrow(Color(0xFFFF6F00), 'fling/tap'),
            _buildStateBox('OPEN', Color(0xFF6A1B9A), 'completed'),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF283593),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFFFFEB3B)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Fling gestures with velocity > 365dp/s trigger immediate open or close, bypassing the normal animation curve.',
                  style: TextStyle(fontSize: 10, color: Color(0xFFB3E5FC)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateBox(String label, Color color, String status) {
  return Container(
    width: 80,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Text(
          status,
          style: TextStyle(
            color: color.withValues(alpha: 0.7),
            fontSize: 9,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildArrow(Color color, String label) {
  return Column(
    children: [
      Icon(Icons.arrow_forward, size: 18, color: color),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _buildPropertiesTable() {
  debugPrint('Building properties table');
  List<Map<String, String>> props = [
    {
      'prop': 'open()',
      'type': 'void',
      'desc': 'Opens the drawer with animation',
    },
    {
      'prop': 'close()',
      'type': 'void',
      'desc': 'Closes the drawer with animation',
    },
    {
      'prop': 'isDrawerOpen',
      'type': 'bool',
      'desc': 'Whether the drawer is currently open',
    },
    {
      'prop': 'animation',
      'type': 'Animation<double>',
      'desc': 'Current animation controller value',
    },
    {
      'prop': 'alignment',
      'type': 'DrawerAlignment',
      'desc': 'Start or end of the screen',
    },
    {
      'prop': 'drawerCallback',
      'type': 'DrawerCallback?',
      'desc': 'Called when drawer open state changes',
    },
    {
      'prop': 'dragStartBehavior',
      'type': 'DragStartBehavior',
      'desc': 'When drag gesture is recognized',
    },
    {
      'prop': 'scrimColor',
      'type': 'Color?',
      'desc': 'Color of the scrim overlay',
    },
    {
      'prop': 'edgeDragWidth',
      'type': 'double?',
      'desc': 'Width of edge drag detection area',
    },
    {
      'prop': 'enableOpenDragGesture',
      'type': 'bool',
      'desc': 'Whether edge drag opens the drawer',
    },
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF4A148C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Member',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Type',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Description',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...props.asMap().entries.map((entry) {
          int idx = entry.key;
          Map<String, String> p = entry.value;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: idx.isEven ? Color(0xFFFAFAFA) : Color(0xFFFFFFFF),
              border: Border(
                top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    p['prop']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    p['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Color(0xFF7B1FA2),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    p['desc']!,
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}
