// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for GestureSettings from dart:ui
// GestureSettings configures physical gesture parameters like touch slop
// (the minimum distance a pointer must move before being recognized as a gesture)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== GestureSettings Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CONSTRUCTORS & BASIC PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  // Default constructor with physicalTouchSlop
  final settings1 = ui.GestureSettings(physicalTouchSlop: 18.0);
  print(
    'GestureSettings(18.0): physicalTouchSlop=${settings1.physicalTouchSlop}',
  );

  // Constructor with null (platform default)
  final settingsNull = ui.GestureSettings();
  print(
    'GestureSettings(): physicalTouchSlop=${settingsNull.physicalTouchSlop}',
  );

  // Different touch slop values
  final settingsFine = ui.GestureSettings(physicalTouchSlop: 8.0);
  final settingsCoarse = ui.GestureSettings(physicalTouchSlop: 36.0);
  final settingsMedium = ui.GestureSettings(physicalTouchSlop: 18.0);
  print('Fine: ${settingsFine.physicalTouchSlop}');
  print('Medium: ${settingsMedium.physicalTouchSlop}');
  print('Coarse: ${settingsCoarse.physicalTouchSlop}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: copyWith
  // ═══════════════════════════════════════════════════════════════════════════

  final original = ui.GestureSettings(physicalTouchSlop: 18.0);
  final copied = original.copyWith(physicalTouchSlop: 24.0);
  print('Original: ${original.physicalTouchSlop}');
  print('Copied with 24: ${copied.physicalTouchSlop}');

  // copyWith preserving original value
  final copiedSame = original.copyWith();
  print('Copied same: ${copiedSame.physicalTouchSlop}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: EQUALITY & HASHCODE
  // ═══════════════════════════════════════════════════════════════════════════

  final a = ui.GestureSettings(physicalTouchSlop: 18.0);
  final b = ui.GestureSettings(physicalTouchSlop: 18.0);
  final c = ui.GestureSettings(physicalTouchSlop: 24.0);

  print('a == b (same slop): ${a == b}');
  print('a == c (diff slop): ${a == c}');
  print('a.hashCode == b.hashCode: ${a.hashCode == b.hashCode}');
  print('toString: $a');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: VISUAL DEMO — TOUCH SLOP COMPARISON
  // Shows what different touch slop values look like as physical distances
  // ═══════════════════════════════════════════════════════════════════════════

  // Helper to build a touch slop visualization
  Widget buildSlopCard(String label, double slopValue, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                // Visual circle representing touch slop radius
                Container(
                  width: slopValue * 2,
                  height: slopValue * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.3),
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('physicalTouchSlop: $slopValue px'),
                      Text(
                        'Diameter: ${slopValue * 2} px',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Text(
                        'Must move ${slopValue}px to start gesture',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Visual bar showing the slop distance
            Container(
              height: 4,
              width: slopValue * 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: VISUAL — DEVICE TYPE SCENARIOS
  // Different devices use different gesture settings
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildDeviceScenario(
    String device,
    IconData icon,
    double slop,
    Color color,
    String desc,
  ) {
    final gs = ui.GestureSettings(physicalTouchSlop: slop);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(8),
        color: color.withValues(alpha: 0.05),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'Touch slop: ${gs.physicalTouchSlop} px',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  desc,
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
          ),
          // Small visual indicator of slop size
          Container(
            width: slop,
            height: slop,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.3),
              border: Border.all(color: color, width: 1),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: VISUAL — copyWith DEMONSTRATION
  // Shows how copyWith creates modified settings
  // ═══════════════════════════════════════════════════════════════════════════

  final baseSettings = ui.GestureSettings(physicalTouchSlop: 18.0);
  final variants = <String, ui.GestureSettings>{
    'Base (18px)': baseSettings,
    'Fine (8px)': baseSettings.copyWith(physicalTouchSlop: 8.0),
    'Large (32px)': baseSettings.copyWith(physicalTouchSlop: 32.0),
    'Extra Large (48px)': baseSettings.copyWith(physicalTouchSlop: 48.0),
  };

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: VISUAL — EQUALITY MATRIX
  // ═══════════════════════════════════════════════════════════════════════════

  final settingsA = ui.GestureSettings(physicalTouchSlop: 18.0);
  final settingsB = ui.GestureSettings(physicalTouchSlop: 18.0);
  final settingsC = ui.GestureSettings(physicalTouchSlop: 24.0);
  final settingsD = ui.GestureSettings();

  final eqPairs = <List<dynamic>>[
    ['A(18)', 'B(18)', settingsA == settingsB],
    ['A(18)', 'C(24)', settingsA == settingsC],
    ['A(18)', 'D(null)', settingsA == settingsD],
    ['C(24)', 'D(null)', settingsC == settingsD],
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: VISUAL — GESTURE THRESHOLD VISUALIZATION
  // Shows concentric rings for different slop thresholds
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildThresholdViz() {
    final thresholds = [48.0, 36.0, 24.0, 18.0, 8.0];
    final colors = [
      Colors.red.withValues(alpha: 0.15),
      Colors.orange.withValues(alpha: 0.2),
      Colors.yellow.withValues(alpha: 0.25),
      Colors.green.withValues(alpha: 0.3),
      Colors.blue.withValues(alpha: 0.4),
    ];

    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < thresholds.length; i++)
            Container(
              width: thresholds[i] * 2.2,
              height: thresholds[i] * 2.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[i],
                border: Border.all(
                  color: colors[i].withValues(alpha: 1.0),
                  width: 1,
                ),
              ),
            ),
          // Center touch point
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: VISUAL — MEDIA QUERY GESTURE SETTINGS
  // In real Flutter, GestureSettings comes from MediaQuery
  // ═══════════════════════════════════════════════════════════════════════════

  final mediaQuerySettings = MediaQuery.maybeGestureSettingsOf(context);
  print('MediaQuery gesture settings: $mediaQuerySettings');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD VISUAL OUTPUT
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.touch_app, color: Colors.white, size: 36),
              SizedBox(height: 8),
              Text(
                'GestureSettings Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Touch slop & gesture configuration',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Section: Touch Slop Sizes
        Text(
          'Touch Slop Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        buildSlopCard('Fine (Stylus)', 8.0, Colors.blue),
        buildSlopCard('Standard (Finger)', 18.0, Colors.green),
        buildSlopCard('Coarse (Accessibility)', 36.0, Colors.orange),
        buildSlopCard('Extra Large', 48.0, Colors.red),
        SizedBox(height: 16),

        // Section: Device Scenarios
        Text(
          'Device-Specific Settings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        buildDeviceScenario(
          'Phone (Touch)',
          Icons.phone_android,
          18.0,
          Colors.blue,
          'Standard finger touch slop',
        ),
        buildDeviceScenario(
          'Tablet (Stylus)',
          Icons.tablet,
          8.0,
          Colors.purple,
          'Precise stylus input, lower slop',
        ),
        buildDeviceScenario(
          'Desktop (Mouse)',
          Icons.desktop_windows,
          2.0,
          Colors.teal,
          'Mouse pointer, very low slop',
        ),
        buildDeviceScenario(
          'Accessibility',
          Icons.accessibility,
          36.0,
          Colors.orange,
          'Larger slop for motor impairment',
        ),
        SizedBox(height: 16),

        // Section: Threshold Visualization
        Text(
          'Nested Threshold Visualization',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Concentric circles show different slop thresholds',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        SizedBox(height: 8),
        Center(child: buildThresholdViz()),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendDot(Colors.blue, '8px'),
            SizedBox(width: 8),
            _legendDot(Colors.green, '18px'),
            SizedBox(width: 8),
            _legendDot(Colors.yellow[700]!, '24px'),
            SizedBox(width: 8),
            _legendDot(Colors.orange, '36px'),
            SizedBox(width: 8),
            _legendDot(Colors.red, '48px'),
          ],
        ),
        SizedBox(height: 16),

        // Section: copyWith Variants
        Text(
          'copyWith Variants',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...variants.entries.map((e) {
          final slop = e.value.physicalTouchSlop ?? 0;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Text(e.key, style: TextStyle(fontWeight: FontWeight.w500)),
                Spacer(),
                Container(
                  width: slop.toDouble() * 1.5,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${e.value.physicalTouchSlop}px',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }),
        SizedBox(height: 16),

        // Section: Equality Matrix
        Text(
          'Equality Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                for (final pair in eqPairs)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${pair[0]} == ${pair[1]}',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (pair[2] as bool)
                                ? Colors.green[100]
                                : Colors.red[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${pair[2]}',
                            style: TextStyle(
                              color: (pair[2] as bool)
                                  ? Colors.green[800]
                                  : Colors.red[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Section: MediaQuery context
        Text(
          'MediaQuery GestureSettings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('From MediaQuery.gestureSettingsOf(context):'),
              SizedBox(height: 4),
              Text(
                '$mediaQuerySettings',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Section: GestureSettings toString
        Text(
          'toString Output',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GestureSettings(18.0): ${ui.GestureSettings(physicalTouchSlop: 18.0)}',
                style: TextStyle(
                  color: Colors.green[300],
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
              Text(
                'GestureSettings(null): ${ui.GestureSettings()}',
                style: TextStyle(
                  color: Colors.green[300],
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
              Text(
                'GestureSettings(8.0): ${ui.GestureSettings(physicalTouchSlop: 8.0)}',
                style: TextStyle(
                  color: Colors.green[300],
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
      SizedBox(width: 3),
      Text(label, style: TextStyle(fontSize: 10)),
    ],
  );
}
