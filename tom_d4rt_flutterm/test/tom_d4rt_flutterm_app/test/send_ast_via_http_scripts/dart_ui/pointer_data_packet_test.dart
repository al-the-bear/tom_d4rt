// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for PointerDataPacket from dart:ui
//
// PointerDataPacket is the raw pointer data container from the engine.
// It holds a list of PointerData objects representing touch/mouse events.
//
// PointerData fields:
//   - change: PointerChange (add, hover, down, move, up, remove, cancel)
//   - kind: PointerDeviceKind (touch, mouse, stylus, invertedStylus, trackpad, unknown)
//   - device: Device ID
//   - pointerIdentifier: Unique pointer ID
//   - physicalX, physicalY: Physical coordinates
//   - physicalDeltaX, physicalDeltaY: Delta since last event
//   - buttons: Bit mask of pressed buttons
//   - pressure: Pressure value (stylus/force touch)
//   - pressureMin, pressureMax: Pressure range
//   - distance: Distance (hover)
//   - distanceMax: Max distance
//   - size: Contact size
//   - radiusMajor, radiusMinor: Contact ellipse
//   - tilt: Tilt angle
//   - orientation: Stylus orientation
//
// This demo visually demonstrates pointer data concepts.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF00796B), const Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF00796B).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.touch_app, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF26A69A).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF00796B), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00796B),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPointerChangeDemo() {
  final changes = <Map<String, dynamic>>[
    {'change': ui.PointerChange.add, 'label': 'add', 'desc': 'Pointer enters'},
    {
      'change': ui.PointerChange.hover,
      'label': 'hover',
      'desc': 'Hovering (not pressed)',
    },
    {
      'change': ui.PointerChange.down,
      'label': 'down',
      'desc': 'Button pressed',
    },
    {
      'change': ui.PointerChange.move,
      'label': 'move',
      'desc': 'Moving while pressed',
    },
    {'change': ui.PointerChange.up, 'label': 'up', 'desc': 'Button released'},
    {
      'change': ui.PointerChange.remove,
      'label': 'remove',
      'desc': 'Pointer leaves',
    },
    {
      'change': ui.PointerChange.cancel,
      'label': 'cancel',
      'desc': 'Event cancelled',
    },
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_vert, color: const Color(0xFF00796B)),
            const SizedBox(width: 8),
            const Text(
              'PointerChange Values',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...changes.map((c) {
          final change = c['change'] as ui.PointerChange;
          final isActive =
              change == ui.PointerChange.down ||
              change == ui.PointerChange.move;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF00796B).withAlpha(50),
                    shape: BoxShape.circle,
                  ),
                  child: isActive
                      ? const Icon(Icons.check, size: 10, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 60,
                  child: Text(
                    c['label'] as String,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    c['desc'] as String,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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

Widget _buildDeviceKindDemo() {
  final kinds = <Map<String, dynamic>>[
    {
      'kind': ui.PointerDeviceKind.touch,
      'label': 'touch',
      'icon': Icons.fingerprint,
    },
    {'kind': ui.PointerDeviceKind.mouse, 'label': 'mouse', 'icon': Icons.mouse},
    {
      'kind': ui.PointerDeviceKind.stylus,
      'label': 'stylus',
      'icon': Icons.edit,
    },
    {
      'kind': ui.PointerDeviceKind.invertedStylus,
      'label': 'invertedStylus',
      'icon': Icons.clear,
    },
    {
      'kind': ui.PointerDeviceKind.trackpad,
      'label': 'trackpad',
      'icon': Icons.touch_app,
    },
    {
      'kind': ui.PointerDeviceKind.unknown,
      'label': 'unknown',
      'icon': Icons.help,
    },
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices, color: const Color(0xFF00796B)),
            const SizedBox(width: 8),
            const Text(
              'PointerDeviceKind',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: kinds.map((k) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    k['icon'] as IconData,
                    size: 16,
                    color: const Color(0xFF00796B),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    k['label'] as String,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildPointerDataFieldsCard() {
  final fields = <List<String>>[
    ['physicalX/Y', 'Screen position (physical pixels)'],
    ['physicalDeltaX/Y', 'Change since last event'],
    ['buttons', 'Bitmask of pressed buttons'],
    ['pressure', 'Contact pressure (0.0-1.0)'],
    ['radiusMajor/Minor', 'Contact ellipse radii'],
    ['tilt', 'Tilt angle (stylus)'],
    ['orientation', 'Stylus rotation'],
    ['distance', 'Hover distance from surface'],
    ['device', 'Device identifier'],
    ['pointerIdentifier', 'Unique pointer ID'],
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.data_object, color: const Color(0xFF00796B)),
            const SizedBox(width: 8),
            const Text(
              'PointerData Fields',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...fields.map((f) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF26A69A),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 95,
                  child: Text(
                    f[0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    f[1],
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
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

Widget _buildCoordinateVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.place, color: const Color(0xFF00796B)),
            const SizedBox(width: 8),
            const Text(
              'Physical Coordinates',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _CoordinatePainter(),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'physicalX: 250.0, physicalY: 180.0\nphysicalDeltaX: +5.0, physicalDeltaY: +3.0',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

class _CoordinatePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Grid
    final gridPaint = Paint()
      ..color = Colors.grey.withAlpha(30)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var y = 0.0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Axes
    final axisPaint = Paint()
      ..color = const Color(0xFF00796B)
      ..strokeWidth = 2;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), axisPaint);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), axisPaint);

    // Point with touch area
    const center = Offset(150, 70);
    final touchPaint = Paint()
      ..color = const Color(0xFF26A69A).withAlpha(60)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: 40, height: 30),
      touchPaint,
    );

    final pointPaint = Paint()
      ..color = const Color(0xFF00796B)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 8, pointPaint);

    // Delta arrow
    final arrowPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(center, const Offset(165, 80), arrowPaint);

    // Labels
    _drawLabel(canvas, 'X →', Offset(size.width - 25, 5));
    _drawLabel(canvas, 'Y ↓', Offset(5, size.height - 15));
    _drawLabel(canvas, 'position', const Offset(160, 55));
    _drawLabel(canvas, 'delta', const Offset(165, 85), Colors.orange);
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, [Color? color]) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? const Color(0xFF00796B),
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildPacketStructureDemo(List<ui.PointerData> data) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.inventory_2, color: const Color(0xFF00796B)),
            const SizedBox(width: 8),
            const Text(
              'Packet Structure',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Packet visualization
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PointerDataPacket',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 8),
              ...data.asMap().entries.map((e) {
                final idx = e.key;
                final pd = e.value;
                return Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFF26A69A),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00796B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            '$idx',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${pd.change.name}  (${pd.physicalX.toStringAsFixed(0)}, ${pd.physicalY.toStringAsFixed(0)})',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildGestureSequenceVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: const Color(0xFF00796B)),
            const SizedBox(width: 8),
            const Text(
              'Touch Sequence',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Timeline visualization
        Row(
          children: [
            _buildTimelineItem('add', Colors.blue, true),
            _buildTimelineConnector(),
            _buildTimelineItem('down', Colors.green, true),
            _buildTimelineConnector(),
            _buildTimelineItem('move', Colors.orange, false),
            _buildTimelineConnector(),
            _buildTimelineItem('up', Colors.red, true),
            _buildTimelineConnector(),
            _buildTimelineItem('remove', Colors.grey, true),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFE0B2)),
          ),
          child: Row(
            children: const [
              Icon(Icons.info, size: 16, color: Color(0xFFE65100)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'move events repeat while dragging',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineItem(String label, Color color, bool single) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(80),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: single
            ? null
            : const Icon(Icons.autorenew, size: 14, color: Colors.white),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

Widget _buildTimelineConnector() {
  return Container(
    width: 15,
    height: 2,
    margin: const EdgeInsets.only(bottom: 18),
    color: Colors.grey[300],
  );
}

Widget _buildPressureDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compress, color: const Color(0xFF00796B)),
            const SizedBox(width: 8),
            const Text(
              'Pressure & Size',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Pressure scale
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPressureCircle(0.2, 'Light'),
            _buildPressureCircle(0.5, 'Medium'),
            _buildPressureCircle(0.8, 'Hard'),
            _buildPressureCircle(1.0, 'Max'),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Pressure range: pressureMin to pressureMax',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _buildPressureCircle(double pressure, String label) {
  final size = 20.0 + (pressure * 25);
  return Column(
    children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Color.lerp(
            const Color(0xFF80CBC4),
            const Color(0xFF00796B),
            pressure,
          ),
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 9)),
      Text(
        '${(pressure * 100).toInt()}%',
        style: TextStyle(fontSize: 8, color: Colors.grey[500]),
      ),
    ],
  );
}

Widget _buildCodeSnippet(String code) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFFD4D4D4),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildPacketResultsCard(
  ui.PointerDataPacket packet1,
  ui.PointerDataPacket packet2,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: const Color(0xFF4CAF50)),
            const SizedBox(width: 8),
            const Text(
              'Packet Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResultRow('Packet type', '${packet1.runtimeType}', true),
        _buildResultRow(
          'Empty packet.data.length',
          '${packet1.data.length}',
          true,
        ),
        _buildResultRow(
          'Packet with events',
          '${packet2.data.length} events',
          true,
        ),
        _buildResultRow(
          'First event change',
          '${packet2.data[0].change.name}',
          true,
        ),
        _buildResultRow(
          'Second physicalX',
          '${packet2.data[1].physicalX}',
          true,
        ),
        _buildResultRow(
          'Third event change',
          '${packet2.data[2].change.name}',
          true,
        ),
      ],
    ),
  );
}

Widget _buildResultRow(String label, String value, bool success) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.cancel,
          size: 14,
          color: success ? const Color(0xFF4CAF50) : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 11))),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== PointerDataPacket Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- PointerDataPacket Overview ---');
  print('Container for raw pointer events from the engine');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: EMPTY PACKET
  // ═══════════════════════════════════════════════════════════════════════════

  final packet1 = ui.PointerDataPacket();
  print('Empty packet: ${packet1.runtimeType}');
  print('data.length: ${packet1.data.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PACKET WITH DATA
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating PointerData events ---');
  final pd1 = ui.PointerData(change: ui.PointerChange.add);
  final pd2 = ui.PointerData(
    change: ui.PointerChange.down,
    physicalX: 100.0,
    physicalY: 200.0,
    pressure: 0.5,
    kind: ui.PointerDeviceKind.touch,
  );
  final pd3 = ui.PointerData(
    change: ui.PointerChange.move,
    physicalX: 110.0,
    physicalY: 210.0,
    physicalDeltaX: 10.0,
    physicalDeltaY: 10.0,
    pressure: 0.6,
    kind: ui.PointerDeviceKind.touch,
  );
  final pd4 = ui.PointerData(
    change: ui.PointerChange.up,
    physicalX: 110.0,
    physicalY: 210.0,
    kind: ui.PointerDeviceKind.touch,
  );
  final pd5 = ui.PointerData(change: ui.PointerChange.remove);

  final data = [pd1, pd2, pd3, pd4, pd5];
  final packet2 = ui.PointerDataPacket(data: data);
  print('Packet with ${packet2.data.length} events created');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: INSPECTING DATA
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Inspecting Packet Data ---');
  for (var i = 0; i < packet2.data.length; i++) {
    final pd = packet2.data[i];
    print('[$i] ${pd.change.name}: (${pd.physicalX}, ${pd.physicalY})');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: POINTER CHANGE ENUM
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- PointerChange values ---');
  for (final change in ui.PointerChange.values) {
    print('  ${change.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: DEVICE KIND ENUM
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- PointerDeviceKind values ---');
  for (final kind in ui.PointerDeviceKind.values) {
    print('  ${kind.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: DETAILED DATA FIELDS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- PointerData Fields (event 2) ---');
  print('change: ${pd2.change}');
  print('kind: ${pd2.kind}');
  print('physicalX: ${pd2.physicalX}');
  print('physicalY: ${pd2.physicalY}');
  print('pressure: ${pd2.pressure}');
  print('buttons: ${pd2.buttons}');
  print('device: ${pd2.device}');
  print('pointerIdentifier: ${pd2.pointerIdentifier}');

  print('\n=== PointerDataPacket Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('PointerDataPacket', 'Raw Pointer Events Container'),
        const SizedBox(height: 20),

        // Pointer change
        _buildSectionTitle('Change Types', Icons.swap_vert),
        _buildPointerChangeDemo(),
        const SizedBox(height: 20),

        // Device kind
        _buildSectionTitle('Device Types', Icons.devices),
        _buildDeviceKindDemo(),
        const SizedBox(height: 20),

        // Fields
        _buildSectionTitle('Data Fields', Icons.data_object),
        _buildPointerDataFieldsCard(),
        const SizedBox(height: 20),

        // Coordinates
        _buildSectionTitle('Coordinates', Icons.place),
        _buildCoordinateVisualization(),
        const SizedBox(height: 20),

        // Packet structure
        _buildSectionTitle('Packet Contents', Icons.inventory_2),
        _buildPacketStructureDemo(data),
        const SizedBox(height: 20),

        // Touch sequence
        _buildSectionTitle('Event Sequence', Icons.timeline),
        _buildGestureSequenceVisualization(),
        const SizedBox(height: 20),

        // Pressure
        _buildSectionTitle('Pressure', Icons.compress),
        _buildPressureDemo(),
        const SizedBox(height: 20),

        // Code example
        _buildSectionTitle('Code Example', Icons.code),
        _buildCodeSnippet(
          'final packet = PointerDataPacket(\n'
          '  data: [\n'
          '    PointerData(change: PointerChange.add),\n'
          '    PointerData(\n'
          '      change: PointerChange.down,\n'
          '      physicalX: 100.0,\n'
          '      physicalY: 200.0,\n'
          '      kind: PointerDeviceKind.touch,\n'
          '    ),\n'
          '    // ... more events\n'
          '  ],\n'
          ');',
        ),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildPacketResultsCard(packet1, packet2),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF00796B),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• PointerDataPacket holds a list of PointerData\n'
                '• PointerData contains raw touch/mouse/stylus events\n'
                '• Events flow: add → down → move* → up → remove\n'
                '• Coordinates in physical pixels (device dependent)\n'
                '• Includes pressure, tilt, and device info\n'
                '• Flutter translates these to gesture callbacks',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
