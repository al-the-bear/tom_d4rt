// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for PointerChange from dart:ui
// PointerChange describes the type of change in pointer state
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
        colors: [Colors.deepOrange.shade700, Colors.orange.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.3),
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
          'PointerChange',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pointer State Changes from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '10 distinct pointer change types',
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

Widget _buildOverviewCard() {
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
            color: Colors.deepOrange.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.deepOrange, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'PointerChange Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
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
            children: [
              _buildBulletPoint('Describes what changed about a pointer event'),
              _buildBulletPoint('Used in PointerData for low-level access'),
              _buildBulletPoint('Covers entire pointer lifecycle'),
              _buildBulletPoint('Includes pan/zoom gesture recognition'),
              _buildBulletPoint('Essential for custom gesture handling'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildChangeCard(
  PointerChange change,
  IconData icon,
  Color color,
  String description,
  List<String> traits,
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
                      'PointerChange.${change.name}',
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
                        'Index: ${change.index}',
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
        // Content
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
                        Icon(Icons.lightbulb_outline, size: 14, color: color),
                        const SizedBox(width: 6),
                        Text(
                          'Key Traits',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...traits.map(
                      (t) => Padding(
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
                                t,
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

Widget _buildQuickRefGrid() {
  final items = [
    (PointerChange.cancel, Icons.cancel, Colors.red, 'Cancel'),
    (PointerChange.add, Icons.add_circle, Colors.green, 'Add'),
    (PointerChange.remove, Icons.remove_circle, Colors.grey, 'Remove'),
    (PointerChange.hover, Icons.mouse, Colors.blue, 'Hover'),
    (PointerChange.down, Icons.arrow_downward, Colors.indigo, 'Down'),
    (PointerChange.move, Icons.open_with, Colors.purple, 'Move'),
    (PointerChange.up, Icons.arrow_upward, Colors.teal, 'Up'),
    (PointerChange.panZoomStart, Icons.pan_tool, Colors.orange, 'PanZoom'),
    (PointerChange.panZoomUpdate, Icons.refresh, Colors.amber, 'Update'),
    (PointerChange.panZoomEnd, Icons.stop_circle, Colors.brown, 'End'),
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
          'All 10 Change Types',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Quick reference for PointerChange values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items
              .map(
                (item) => Container(
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item.$3.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: item.$3.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(item.$2, color: item.$3, size: 24),
                      const SizedBox(height: 6),
                      Text(
                        item.$4,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: item.$3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '[${item.$1.index}]',
                        style: TextStyle(
                          fontSize: 8,
                          color: item.$3.withValues(alpha: 0.7),
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

Widget _buildLifecycleVisualization() {
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
          'Pointer Lifecycle',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Typical sequence of pointer changes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 24),
        _buildLifecycleRow('Pointer detected', 'add', Colors.green, true),
        _buildLifecycleRow('Moving over surface', 'hover', Colors.blue, true),
        _buildLifecycleRow('Finger/button down', 'down', Colors.indigo, true),
        _buildLifecycleRow('Dragging', 'move', Colors.purple, true),
        _buildLifecycleRow('Finger/button up', 'up', Colors.teal, true),
        _buildLifecycleRow('Pointer leaves', 'remove', Colors.grey, false),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'The add event fires when a pointer is detected. For touch, '
            'this happens when the finger first approaches the surface.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleRow(
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
          width: 140,
          child: Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
          ),
        ),
        Container(
          width: 10,
          height: 10,
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

Widget _buildPanZoomVisualization() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade800, Colors.amber.shade600],
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
            Icon(Icons.pan_tool_alt, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              'Pan/Zoom Gesture Sequence',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _buildPanZoomStep(
                '1',
                'panZoomStart',
                'Gesture begins (2+ fingers)',
              ),
              const SizedBox(height: 8),
              _buildPanZoomStep('2', 'panZoomUpdate', 'Continuous updates'),
              const SizedBox(height: 8),
              _buildPanZoomStep('3', 'panZoomEnd', 'All fingers lifted'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Note: panZoom changes are typically used with trackpads '
          'that support multi-finger pan and zoom gestures.',
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    ),
  );
}

Widget _buildPanZoomStep(String num, String event, String desc) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          num,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Text(
            desc,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    ],
  );
}

Widget _buildCategoriesSection() {
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
          'Grouped by Purpose',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildCategory('Lifecycle Events', Colors.green, [
          'add',
          'remove',
          'cancel',
        ], 'Control pointer entry/exit'),
        const SizedBox(height: 12),
        _buildCategory('Interaction Events', Colors.blue, [
          'hover',
          'down',
          'move',
          'up',
        ], 'Standard pointer interactions'),
        const SizedBox(height: 12),
        _buildCategory('Pan/Zoom Events', Colors.orange, [
          'panZoomStart',
          'panZoomUpdate',
          'panZoomEnd',
        ], 'Multi-finger trackpad gestures'),
      ],
    ),
  );
}

Widget _buildCategory(
  String title,
  Color color,
  List<String> events,
  String desc,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: events
              .map(
                (e) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
      ],
    ),
  );
}

Widget _buildCodeExample() {
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
          'Code Examples',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Low-level PointerData access',
          '''void handlePointerData(PointerData data) {
  switch (data.change) {
    case PointerChange.add:
      onPointerAdded(data);
      break;
    case PointerChange.down:
      onPointerDown(data);
      break;
    case PointerChange.move:
      onPointerMove(data);
      break;
    case PointerChange.up:
      onPointerUp(data);
      break;
    case PointerChange.remove:
      onPointerRemoved(data);
      break;
    default:
      // Handle other cases
      break;
  }
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Handle pan/zoom gestures',
          '''void handlePanZoom(PointerData data) {
  if (data.change == PointerChange.panZoomStart) {
    startPanZoom(data);
  } else if (data.change == PointerChange.panZoomUpdate) {
    updatePanZoom(data.panX, data.panY, data.scale);
  } else if (data.change == PointerChange.panZoomEnd) {
    endPanZoom();
  }
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

Widget _buildUseCases() {
  final cases = [
    (
      Icons.gesture,
      Colors.blue,
      'Custom Gesture Recognition',
      'Build gesture recognizers from raw pointer data',
    ),
    (
      Icons.map,
      Colors.green,
      'Interactive Maps',
      'Pan, zoom, and navigate maps with trackpad',
    ),
    (
      Icons.image,
      Colors.purple,
      'Image Editors',
      'Draw, paint, and transform with pointer tracking',
    ),
    (
      Icons.games,
      Colors.orange,
      'Game Input',
      'Precise pointer tracking for game controls',
    ),
    (
      Icons.draw,
      Colors.pink,
      'Canvas Applications',
      'Freeform drawing with pressure sensitivity',
    ),
    (
      Icons.touch_app,
      Colors.teal,
      'Accessibility',
      'Custom pointer handling for assistive tech',
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
          'Use Cases',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...cases.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: c.$2.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(c.$1, color: c.$2, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.$3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        c.$4,
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

Widget _buildComparisonTable() {
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
          'Touch vs Mouse Events',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          border: TableBorder.all(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Change',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Touch',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Mouse',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ],
            ),
            _buildTableRow('add', 'Finger near', 'Cursor enters'),
            _buildTableRow('hover', 'N/A', 'Moving (no btn)'),
            _buildTableRow('down', 'Finger down', 'Button press'),
            _buildTableRow('move', 'Finger drag', 'Drag'),
            _buildTableRow('up', 'Finger up', 'Button release'),
            _buildTableRow('remove', 'Finger far', 'Cursor leaves'),
          ],
        ),
      ],
    ),
  );
}

TableRow _buildTableRow(String change, String touch, String mouse) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          change,
          style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          touch,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          mouse,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ),
    ],
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
        _buildStatItem('Total', '${PointerChange.values.length}'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('First', PointerChange.values.first.name),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Last', PointerChange.values.last.name),
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
          fontSize: 14,
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
          'PointerChange Deep Demo Complete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Demonstrating ${PointerChange.values.length} pointer change types',
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
  print('=== PointerChange Deep Demo ===');

  // Log all values
  print('PointerChange describes changes in pointer state');
  print('All values: ${PointerChange.values}');
  print('Count: ${PointerChange.values.length}');

  for (final c in PointerChange.values) {
    print('${c.name}: index=${c.index}');
  }

  print('\n--- Lifecycle Events ---');
  print('add: Pointer detected (finger approaches/mouse enters)');
  print('remove: Pointer leaves (finger far/mouse exits)');
  print('cancel: Pointer tracking canceled');

  print('\n--- Interaction Events ---');
  print('hover: Moving without button (mouse only)');
  print('down: Button/finger pressed');
  print('move: Dragging with button/finger');
  print('up: Button/finger released');

  print('\n--- Pan/Zoom Events ---');
  print('panZoomStart: Multi-finger gesture begins');
  print('panZoomUpdate: Gesture ongoing');
  print('panZoomEnd: All fingers lifted');

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

              // Overview
              _buildOverviewCard(),
              const SizedBox(height: 16),

              // Quick reference grid
              _buildSectionHeader('QUICK REFERENCE'),
              _buildQuickRefGrid(),
              const SizedBox(height: 16),

              // Summary stats
              _buildSummaryStats(),
              const SizedBox(height: 16),

              // All change types
              _buildSectionHeader('CHANGE TYPES'),

              _buildChangeCard(
                PointerChange.cancel,
                Icons.cancel_outlined,
                Colors.red,
                'The tracking of a pointer was canceled. This happens when the system decides to stop tracking the pointer, such as when the application goes to the background.',
                [
                  'System-initiated cancellation',
                  'Pointer tracking stopped',
                  'May occur during context switches',
                  'Clean up any in-progress gestures',
                ],
              ),

              _buildChangeCard(
                PointerChange.add,
                Icons.add_circle_outline,
                Colors.green,
                'A pointer was added to the system. For touch, this occurs when a finger approaches the surface. For mouse, when the cursor enters the application window.',
                [
                  'First event for new pointer',
                  'Initializes pointer tracking',
                  'Contains initial position',
                  'Assign pointer ID for tracking',
                ],
              ),

              _buildChangeCard(
                PointerChange.remove,
                Icons.remove_circle_outline,
                Colors.grey,
                'A pointer was removed from the system. For touch, when a finger moves away from the surface. For mouse, when the cursor exits the window.',
                [
                  'Final event for pointer',
                  'Clean up tracking data',
                  'Pointer ID no longer valid',
                  'Cancel any active gestures',
                ],
              ),

              _buildChangeCard(
                PointerChange.hover,
                Icons.mouse,
                Colors.blue,
                'The pointer moved while not pressing any buttons. This only occurs for mouse/stylus pointers; touch pointers go directly from add to down.',
                [
                  'Mouse-only event (no touch)',
                  'No buttons pressed',
                  'Used for hover effects',
                  'Cursor position updates',
                ],
              ),

              _buildChangeCard(
                PointerChange.down,
                Icons.arrow_downward,
                Colors.indigo,
                'A pointer button was pressed (mouse) or a contact was established (touch). This begins an active interaction.',
                [
                  'Start of active interaction',
                  'Touch contact or button press',
                  'Position is contact point',
                  'Begin gesture recognition',
                ],
              ),

              _buildChangeCard(
                PointerChange.move,
                Icons.open_with,
                Colors.purple,
                'The pointer moved while pressing button(s) or while in contact. Used for dragging, drawing, and other continuous interactions.',
                [
                  'Continuous position updates',
                  'Button/contact still active',
                  'Used for drag gestures',
                  'High-frequency events',
                ],
              ),

              _buildChangeCard(
                PointerChange.up,
                Icons.arrow_upward,
                Colors.teal,
                'A pointer button was released (mouse) or contact was lost (touch). This ends the active interaction phase.',
                [
                  'End of active interaction',
                  'Button released or finger lifted',
                  'Finalize gestures here',
                  'May trigger tap/click events',
                ],
              ),

              _buildChangeCard(
                PointerChange.panZoomStart,
                Icons.pan_tool,
                Colors.orange,
                'A pan/zoom gesture has started. This occurs with two or more fingers on a trackpad, signaling the beginning of a complex gesture.',
                [
                  'Multi-finger gesture begins',
                  'Trackpad-specific event',
                  'Initialize pan/zoom state',
                  'Prepare for scale/rotation',
                ],
              ),

              _buildChangeCard(
                PointerChange.panZoomUpdate,
                Icons.refresh,
                Colors.amber,
                'The pan/zoom gesture is ongoing with new position/scale values. This provides continuous updates until the gesture ends.',
                [
                  'Continuous gesture updates',
                  'Contains pan delta and scale',
                  'May include rotation data',
                  'Apply transforms incrementally',
                ],
              ),

              _buildChangeCard(
                PointerChange.panZoomEnd,
                Icons.stop_circle_outlined,
                Colors.brown,
                'The pan/zoom gesture has ended. All fingers have been lifted from the trackpad. Finalize any transformations.',
                [
                  'Gesture complete',
                  'All fingers lifted',
                  'Finalize transformations',
                  'Reset gesture state',
                ],
              ),

              const SizedBox(height: 16),

              // Lifecycle visualization
              _buildSectionHeader('POINTER LIFECYCLE'),
              _buildLifecycleVisualization(),
              const SizedBox(height: 16),

              // Pan/Zoom visualization
              _buildSectionHeader('PAN/ZOOM SEQUENCE'),
              _buildPanZoomVisualization(),
              const SizedBox(height: 16),

              // Categories
              _buildSectionHeader('GROUPED BY PURPOSE'),
              _buildCategoriesSection(),
              const SizedBox(height: 16),

              // Comparison table
              _buildSectionHeader('TOUCH VS MOUSE'),
              _buildComparisonTable(),
              const SizedBox(height: 16),

              // Use cases
              _buildSectionHeader('USE CASES'),
              _buildUseCases(),
              const SizedBox(height: 16),

              // Code examples
              _buildSectionHeader('CODE EXAMPLES'),
              _buildCodeExample(),
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
