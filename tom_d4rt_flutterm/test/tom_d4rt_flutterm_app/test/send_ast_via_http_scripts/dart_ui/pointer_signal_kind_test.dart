// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for PointerSignalKind from dart:ui
// PointerSignalKind identifies the type of signal from pointer devices
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
        colors: [Colors.indigo.shade600, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const Icon(Icons.swipe_vertical, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        const Text(
          'PointerSignalKind',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pointer Signal Types from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Scroll, zoom, and rotation signals',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
          ),
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
            color: Colors.indigo,
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
          color: Colors.black.withValues(alpha: 0.05),
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
            color: color.withValues(alpha: 0.1),
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

Widget _buildSignalKindCard(
  PointerSignalKind kind,
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
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
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
              colors: [color, color.withValues(alpha: 0.8)],
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
                  color: Colors.white.withValues(alpha: 0.2),
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
                      'PointerSignalKind.${kind.name}',
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
                        color: Colors.white.withValues(alpha: 0.2),
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
                  color: color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.1)),
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

Widget _buildSignalComparisonGrid() {
  final signals = [
    (PointerSignalKind.none, Icons.block, Colors.grey, 'None'),
    (PointerSignalKind.scroll, Icons.swap_vert, Colors.blue, 'Scroll'),
    (
      PointerSignalKind.scrollInertiaCancel,
      Icons.stop,
      Colors.orange,
      'Cancel',
    ),
    (PointerSignalKind.scale, Icons.zoom_in, Colors.purple, 'Scale'),
    // Note: Unknown may not be available in all Flutter versions
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
          'All signal kinds at a glance',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: signals
              .map(
                (s) => Container(
                  width: 85,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: s.$3.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: s.$3.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(s.$2, color: s.$3, size: 28),
                      const SizedBox(height: 8),
                      Text(
                        s.$4,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: s.$3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '[${s.$1.index}]',
                        style: TextStyle(
                          fontSize: 9,
                          color: s.$3.withValues(alpha: 0.7),
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

Widget _buildScrollVisualization() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scroll Signal Flow',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Typical scroll event sequence with inertia',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 24),
        // Timeline visualization
        Row(
          children: [
            const SizedBox(width: 8),
            Text(
              'Time →',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade600, Colors.grey.shade800],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Events
        _buildScrollEventRow('User scrolls', 'scroll', Colors.blue, true),
        _buildScrollEventRow('Continued', 'scroll', Colors.blue, true),
        _buildScrollEventRow('User lifts finger', 'scroll', Colors.blue, true),
        _buildScrollEventRow(
          'Inertia begins',
          'scroll',
          Colors.blue.shade300,
          true,
        ),
        _buildScrollEventRow(
          'Inertia continues',
          'scroll',
          Colors.blue.shade200,
          true,
        ),
        _buildScrollEventRow(
          'User taps to stop',
          'scrollInertiaCancel',
          Colors.orange,
          false,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'scrollInertiaCancel is sent when the user interrupts ongoing '
            'momentum scrolling, typically by touching the screen again.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ),
      ],
    ),
  );
}

Widget _buildScrollEventRow(
  String label,
  String event,
  Color color,
  bool hasArrow,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
          ),
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            event,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        if (hasArrow) ...[
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade600),
        ],
      ],
    ),
  );
}

Widget _buildScaleVisualization() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade800, Colors.purple.shade600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.pinch, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              'Trackpad Scale Gesture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: 160,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400, width: 2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pinch gesture indicators
                Positioned(
                  left: 40,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade400,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade400,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 16, color: Colors.grey),
                    SizedBox(width: 40),
                    Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Two-finger pinch on trackpad generates scale signals. '
            'Common on macOS for zooming in maps, images, and documents.',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ),
      ],
    ),
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
        _buildCodeBlock('Handle Scroll Signals', '''Listener(
  onPointerSignal: (event) {
    if (event is PointerScrollEvent) {
      // Handle scroll
      final dy = event.scrollDelta.dy;
      scrollBy(dy);
    }
  },
  child: MyScrollableContent(),
)'''),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Check Signal Kind',
          '''void handleSignal(PointerSignalEvent event) {
  switch (event.signalKind) {
    case PointerSignalKind.scroll:
      handleScroll(event);
      break;
    case PointerSignalKind.scale:
      handleZoom(event);
      break;
    case PointerSignalKind.scrollInertiaCancel:
      stopInertiaScroll();
      break;
    default:
      // Handle none or unknown
      break;
  }
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Scale Signal Handling',
          '''if (event.signalKind == PointerSignalKind.scale) {
  final scaleEvent = event as PointerScaleEvent;
  final scaleFactor = scaleEvent.scale;
  applyZoom(scaleFactor);
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
      Icons.article,
      Colors.blue,
      'Document Scrolling',
      'Mouse wheel and trackpad scroll in lists and documents',
    ),
    (
      Icons.map,
      Colors.green,
      'Map Zooming',
      'Pinch-to-zoom on maps using scale signals',
    ),
    (
      Icons.image,
      Colors.purple,
      'Image Viewer',
      'Zoom and pan images with trackpad gestures',
    ),
    (
      Icons.web,
      Colors.orange,
      'Web Content',
      'Smooth scrolling with momentum in web views',
    ),
    (
      Icons.table_chart,
      Colors.teal,
      'Data Tables',
      'Horizontal and vertical scroll in large tables',
    ),
    (
      Icons.edit_document,
      Colors.pink,
      'Canvas Apps',
      'Zoom and pan in drawing/design applications',
    ),
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
                    color: uc.$2.withValues(alpha: 0.1),
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

Widget _buildPlatformNotes() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            Text(
              'Platform Considerations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildPlatformNote(
          'macOS',
          'Full support for scroll, scale, and scrollInertiaCancel',
        ),
        _buildPlatformNote(
          'Windows',
          'Scroll works; scale may not be available on all trackpads',
        ),
        _buildPlatformNote(
          'Linux',
          'Similar to Windows; depends on hardware/driver support',
        ),
        _buildPlatformNote(
          'Web',
          'Scroll works; scale varies by browser and input device',
        ),
        _buildPlatformNote(
          'Mobile',
          'Touch gestures typically handled differently (GestureDetector)',
        ),
      ],
    ),
  );
}

Widget _buildPlatformNote(String platform, String note) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            platform,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.amber.shade800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            note,
            style: TextStyle(fontSize: 12, color: Colors.amber.shade700),
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
        colors: [Colors.indigo.shade400, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Total', '${PointerSignalKind.values.length}'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('First', PointerSignalKind.values.first.name),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Last', PointerSignalKind.values.last.name),
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
        style: TextStyle(
          fontSize: 11,
          color: Colors.white.withValues(alpha: 0.8),
        ),
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
          'PointerSignalKind Deep Demo Complete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Demonstrating ${PointerSignalKind.values.length} signal types',
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
  print('=== PointerSignalKind Deep Demo ===');

  // Log all values
  print('PointerSignalKind identifies types of pointer signals');
  print('All values: ${PointerSignalKind.values}');
  print('Count: ${PointerSignalKind.values.length}');

  for (final s in PointerSignalKind.values) {
    print('${s.name}: index=${s.index}');
  }

  print('\n--- Signal Kind Descriptions ---');
  print('none: No signal (default)');
  print('scroll: Scroll wheel or trackpad scroll');
  print('scrollInertiaCancel: User stopped momentum scroll');
  print('scale: Trackpad pinch zoom gesture');

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
                'PointerSignalKind Overview',
                Icons.swipe_vertical,
                Colors.indigo,
                [
                  'Identifies the type of pointer signal event',
                  'Used with PointerSignalEvent for scroll/zoom',
                  'Essential for mouse wheel and trackpad handling',
                  'Enables smooth scrolling experiences',
                ],
              ),
              const SizedBox(height: 16),

              // Quick reference grid
              _buildSectionHeader('QUICK REFERENCE'),
              _buildSignalComparisonGrid(),
              const SizedBox(height: 16),

              // Summary stats
              _buildSummaryStats(),
              const SizedBox(height: 16),

              // All signal kinds
              _buildSectionHeader('SIGNAL KIND DETAILS'),

              _buildSignalKindCard(
                PointerSignalKind.none,
                Icons.block,
                Colors.grey,
                'Default signal kind indicating no specific signal type. Used as a fallback or when the signal type is not applicable to the current event.',
                [
                  'Default/placeholder value',
                  'Used when no signal is present',
                  'Handle as a no-op in most cases',
                  'Check for this in switch statements',
                ],
              ),

              _buildSignalKindCard(
                PointerSignalKind.scroll,
                Icons.swap_vert,
                Colors.blue,
                'Scroll events from mouse wheel rotation or trackpad two-finger scrolling. Contains deltaX and deltaY for scroll direction and magnitude.',
                [
                  'Mouse wheel rotation events',
                  'Trackpad two-finger scroll gestures',
                  'Contains scrollDelta.dx and scrollDelta.dy',
                  'Most common signal kind in apps',
                ],
              ),

              _buildSignalKindCard(
                PointerSignalKind.scrollInertiaCancel,
                Icons.stop_circle_outlined,
                Colors.orange,
                'Sent when the user interrupts ongoing momentum/inertia scrolling. This occurs when the user touches the surface again during a kinetic scroll.',
                [
                  'Interrupts momentum scrolling',
                  'User touched surface during scroll',
                  'Stop any ongoing scroll animation',
                  'Common on trackpads and touch',
                ],
              ),

              _buildSignalKindCard(
                PointerSignalKind.scale,
                Icons.zoom_in,
                Colors.purple,
                'Trackpad pinch-to-zoom gesture events. Contains a scale factor indicating zoom in (>1) or zoom out (<1). Common on macOS Magic Trackpad.',
                [
                  'Two-finger pinch gestures',
                  'scale > 1.0 means zoom in',
                  'scale < 1.0 means zoom out',
                  'Primarily on macOS/trackpad',
                ],
              ),

              const SizedBox(height: 16),

              // Visualizations
              _buildSectionHeader('SCROLL VISUALIZATION'),
              _buildScrollVisualization(),
              const SizedBox(height: 16),

              _buildSectionHeader('SCALE GESTURE'),
              _buildScaleVisualization(),
              const SizedBox(height: 16),

              // Use cases
              _buildSectionHeader('USE CASES'),
              _buildUseCasesSection(),
              const SizedBox(height: 16),

              // Code examples
              _buildSectionHeader('CODE EXAMPLES'),
              _buildCodeExamples(),
              const SizedBox(height: 16),

              // Platform notes
              _buildSectionHeader('PLATFORM NOTES'),
              _buildPlatformNotes(),
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
