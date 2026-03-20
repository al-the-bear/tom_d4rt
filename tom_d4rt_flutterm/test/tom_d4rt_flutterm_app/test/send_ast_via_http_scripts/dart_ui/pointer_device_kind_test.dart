// D4rt test script: Deep Demo for PointerDeviceKind from dart:ui
// PointerDeviceKind identifies the type of input device generating pointer events
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// GLOBAL HELPER FUNCTIONS (declared before build)
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade600, Colors.orange.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const Icon(Icons.touch_app, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        const Text(
          'PointerDeviceKind',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Input Device Types from dart:ui',
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
        ),
        const SizedBox(height: 4),
        Text(
          'Identifying the source of pointer events',
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
            letterSpacing: 1.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionCard(
  String title,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points
                .map(
                  (point) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDeviceKindCard(
  PointerDeviceKind kind,
  IconData icon,
  Color color,
  String description,
  List<String> characteristics,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PointerDeviceKind.${kind.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Index: ${kind.index}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Description
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 14, color: color),
                        const SizedBox(width: 6),
                        Text(
                          'Characteristics',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...characteristics.map(
                      (c) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: color, fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                c,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDeviceComparisonGrid() {
  final devices = [
    (PointerDeviceKind.touch, Icons.touch_app, Colors.blue, 'Touch'),
    (PointerDeviceKind.mouse, Icons.mouse, Colors.green, 'Mouse'),
    (PointerDeviceKind.stylus, Icons.edit, Colors.purple, 'Stylus'),
    (PointerDeviceKind.invertedStylus, Icons.edit_off, Colors.pink, 'Inverted'),
    (PointerDeviceKind.trackpad, Icons.laptop, Colors.orange, 'Trackpad'),
    (PointerDeviceKind.unknown, Icons.help_outline, Colors.grey, 'Unknown'),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Reference',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'All device kinds at a glance',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: devices
              .map(
                (d) => Container(
                  width: 90,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: d.$3.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: d.$3.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(d.$2, color: d.$3, size: 28),
                      const SizedBox(height: 8),
                      Text(
                        d.$4,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: d.$3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '[${d.$1.index}]',
                        style: TextStyle(
                          fontSize: 9,
                          color: d.$3.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildPlatformSupportGrid() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Support',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Device',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Mobile',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Desktop',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Web',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Foldable',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _buildPlatformRow('Touch', true, false, true, true),
            _buildPlatformRow('Mouse', false, true, true, false),
            _buildPlatformRow('Stylus', true, true, true, true),
            _buildPlatformRow('Trackpad', false, true, true, false),
            _buildPlatformRow('Unknown', true, true, true, true),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 14, color: Colors.green),
            const SizedBox(width: 4),
            Text(
              'Available',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.remove_circle_outline,
              size: 14,
              color: Colors.grey.shade400,
            ),
            const SizedBox(width: 4),
            Text(
              'Rare/Limited',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

TableRow _buildPlatformRow(
  String device,
  bool mobile,
  bool desktop,
  bool web,
  bool foldable,
) {
  Widget indicator(bool available) => Center(
    child: Icon(
      available ? Icons.check_circle : Icons.remove_circle_outline,
      size: 16,
      color: available ? Colors.green : Colors.grey.shade400,
    ),
  );

  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(device, style: const TextStyle(fontSize: 11)),
      ),
      Padding(padding: const EdgeInsets.all(8), child: indicator(mobile)),
      Padding(padding: const EdgeInsets.all(8), child: indicator(desktop)),
      Padding(padding: const EdgeInsets.all(8), child: indicator(web)),
      Padding(padding: const EdgeInsets.all(8), child: indicator(foldable)),
    ],
  );
}

Widget _buildCodeExamples() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Usage Patterns',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildCodeBlock('Device-Specific Handling', '''switch (event.kind) {
  case PointerDeviceKind.touch:
    handleTouchInput(event);
    break;
  case PointerDeviceKind.mouse:
    showHoverEffects(event);
    break;
  case PointerDeviceKind.stylus:
    enablePressureSensitivity(event);
    break;
  default:
    handleGenericInput(event);
}'''),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Check for Precision Input',
          '''bool isPrecisionInput(PointerDeviceKind kind) {
  return kind == PointerDeviceKind.mouse ||
         kind == PointerDeviceKind.stylus ||
         kind == PointerDeviceKind.trackpad;
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Touch vs Pointer Detection',
          '''bool requiresLargeHitTarget(PointerEvent event) {
  // Touch input needs larger targets
  return event.kind == PointerDeviceKind.touch;
}''',
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String title, String code) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: Colors.lightGreenAccent,
          ),
        ),
      ),
    ],
  );
}

Widget _buildUseCasesSection() {
  final useCases = [
    (
      Icons.smartphone,
      Colors.blue,
      'Mobile Touch',
      'Large hit targets, swipe gestures',
    ),
    (
      Icons.mouse,
      Colors.green,
      'Desktop Mouse',
      'Hover states, precise clicking',
    ),
    (
      Icons.edit,
      Colors.purple,
      'Drawing/Writing',
      'Pressure sensitivity, tilt detection',
    ),
    (
      Icons.laptop,
      Colors.orange,
      'Trackpad Gestures',
      'Multi-finger scrolling, pinch zoom',
    ),
    (
      Icons.accessibility,
      Colors.teal,
      'Accessibility',
      'Adapt UI to input capabilities',
    ),
    (Icons.games, Colors.pink, 'Gaming', 'Different controls per input type'),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Common Use Cases',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...useCases.map(
          (uc) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: uc.$2.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(uc.$1, color: uc.$2, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        uc.$3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        uc.$4,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryStats() {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade400, Colors.orange.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Total', '${PointerDeviceKind.values.length}'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('First', PointerDeviceKind.values.first.name),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Last', PointerDeviceKind.values.last.name),
      ],
    ),
  );
}

Widget _buildStatItem(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8)),
      ),
    ],
  );
}

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'PointerDeviceKind Deep Demo Complete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Demonstrating ${PointerDeviceKind.values.length} input device types',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== PointerDeviceKind Deep Demo ===');

  // Log all values
  print('PointerDeviceKind identifies the type of input device');
  print('All values: ${PointerDeviceKind.values}');
  print('Count: ${PointerDeviceKind.values.length}');

  for (final k in PointerDeviceKind.values) {
    print('${k.name}: index=${k.index}');
  }

  print('\n--- Device Kind Descriptions ---');
  print('touch: Touchscreen finger input');
  print('mouse: Mouse pointer device');
  print('stylus: Stylus pen input');
  print('invertedStylus: Eraser end of stylus');
  print('trackpad: Trackpad gestures');
  print('unknown: Unknown input device');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 16),

              // Section 1: Overview
              _buildSectionCard(
                'PointerDeviceKind Overview',
                Icons.touch_app,
                Colors.deepOrange,
                [
                  'Identifies the type of pointing device',
                  'Used in PointerEvent to determine input source',
                  'Enables device-specific input handling',
                  'Critical for cross-platform UX optimization',
                ],
              ),
              const SizedBox(height: 16),

              // Quick reference grid
              _buildSectionHeader('QUICK REFERENCE'),
              _buildDeviceComparisonGrid(),
              const SizedBox(height: 16),

              // Summary stats
              _buildSummaryStats(),
              const SizedBox(height: 16),

              // All device kinds
              _buildSectionHeader('DEVICE KIND DETAILS'),

              _buildDeviceKindCard(
                PointerDeviceKind.touch,
                Icons.touch_app,
                Colors.blue,
                'Direct finger touch on a touchscreen. The most common input on mobile devices. Touch events lack hover capability and have lower precision than mouse/stylus.',
                [
                  'No hover detection - only down/move/up',
                  'Lower precision - use larger hit targets',
                  'Multi-touch capable (multiple pointers)',
                  'Primary input on iOS and Android',
                ],
              ),

              _buildDeviceKindCard(
                PointerDeviceKind.mouse,
                Icons.mouse,
                Colors.green,
                'Traditional mouse or similar pointing device. Provides precise cursor control with hover capability. Primary input on desktop platforms.',
                [
                  'Supports hover events (no press required)',
                  'High precision cursor positioning',
                  'Single pointer (buttons add modifiers)',
                  'Standard on Windows/macOS/Linux',
                ],
              ),

              _buildDeviceKindCard(
                PointerDeviceKind.stylus,
                Icons.edit,
                Colors.purple,
                'Active stylus or pen input. Typically pressure-sensitive with tilt detection. Used for drawing, writing, and precise input tasks.',
                [
                  'Pressure sensitivity (force detection)',
                  'Tilt angle detection on supported devices',
                  'Very high precision input',
                  'Common on tablets and drawing devices',
                ],
              ),

              _buildDeviceKindCard(
                PointerDeviceKind.invertedStylus,
                Icons.edit_off,
                Colors.pink,
                'The eraser end of a stylus. Automatically switches tools when flip the stylus to use the eraser end.',
                [
                  'Typically used for erasing',
                  'May have different pressure curve',
                  'App should switch to erase tool',
                  'Not all styluses support this',
                ],
              ),

              _buildDeviceKindCard(
                PointerDeviceKind.trackpad,
                Icons.laptop,
                Colors.orange,
                'Trackpad or touchpad input, typically found on laptops. Supports multi-finger gestures for scrolling, zooming, and navigation.',
                [
                  'Multi-finger gesture support',
                  'Pan and zoom gestures',
                  'Hover detection on some devices',
                  'Common on laptops and Magic Trackpad',
                ],
              ),

              _buildDeviceKindCard(
                PointerDeviceKind.unknown,
                Icons.help_outline,
                Colors.grey,
                'Input from an unknown or unrecognized device type. Handle gracefully as a fallback for future device types or unusual hardware.',
                [
                  'Fallback for unrecognized hardware',
                  'Treat as generic pointer input',
                  'May occur with specialized devices',
                  'Always handle in switch statements',
                ],
              ),

              const SizedBox(height: 16),

              // Platform support
              _buildSectionHeader('PLATFORM SUPPORT'),
              _buildPlatformSupportGrid(),
              const SizedBox(height: 16),

              // Use cases
              _buildSectionHeader('USE CASES'),
              _buildUseCasesSection(),
              const SizedBox(height: 16),

              // Code examples
              _buildSectionHeader('CODE EXAMPLES'),
              _buildCodeExamples(),
              const SizedBox(height: 16),

              // Footer
              _buildFooter(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
