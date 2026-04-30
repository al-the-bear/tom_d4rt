// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for OffsetBase from dart:ui
//
// OffsetBase is an abstract class that serves as the base for both Offset
// and Size classes. It provides common functionality for 2D coordinate/dimension
// handling including comparison operators and infinity checks.
//
// Key characteristics:
//   - Abstract base class (cannot be instantiated directly)
//   - Base for Offset (coordinates) and Size (dimensions)
//   - Comparison operators: >, >=, <, <= (compares both components)
//   - isInfinite: true if either component is infinite
//   - isFinite: true if both components are finite
//
// This demo visually demonstrates OffsetBase behavior through its
// concrete subclasses Offset and Size.

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
        colors: [const Color(0xFF00695C), const Color(0xFF00897B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF00695C).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.architecture, size: 48, color: Colors.white),
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
            color: const Color(0xFF00897B).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF00897B), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
      ],
    ),
  );
}

Widget _buildClassHierarchy() {
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
            Icon(Icons.account_tree, color: const Color(0xFF00897B)),
            const SizedBox(width: 8),
            const Text(
              'Class Hierarchy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Visual tree
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // OffsetBase (abstract)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00695C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'OffsetBase (abstract)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CustomPaint(painter: _TreeLinePainter()),
                          ),
                          const SizedBox(width: 8),
                          _buildClassBox(
                            'Offset',
                            Icons.gps_fixed,
                            'Position (dx, dy)',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CustomPaint(
                              painter: _TreeLinePainter(isLast: true),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildClassBox(
                            'Size',
                            Icons.crop_square,
                            'Dimensions (width, height)',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TreeLinePainter extends CustomPainter {
  final bool isLast;
  _TreeLinePainter({this.isLast = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00695C)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Vertical line
    if (!isLast) {
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        paint,
      );
    } else {
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height / 2),
        paint,
      );
    }

    // Horizontal line
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildClassBox(String name, IconData icon, String description) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFF00897B), width: 2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF00897B)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildComparisonCard(
  String title,
  List<Map<String, dynamic>> comparisons,
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
            Icon(Icons.compare_arrows, color: const Color(0xFF00897B)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...comparisons.map((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(
                  width: 90,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    c['expr'] as String,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  (c['result'] as bool) ? Icons.check_circle : Icons.cancel,
                  size: 18,
                  color: (c['result'] as bool)
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFE53935),
                ),
                const SizedBox(width: 8),
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

Widget _buildVisualOffsetComparison() {
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
            Icon(Icons.grid_on, color: const Color(0xFF00897B)),
            const SizedBox(width: 8),
            const Text(
              'Offset Comparison Visual',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: CustomPaint(
            size: const Size(double.infinity, 200),
            painter: _OffsetComparisonPainter(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('o1 (5, 5)', const Color(0xFF1565C0)),
            const SizedBox(width: 16),
            _buildLegendItem('o2 (10, 10)', const Color(0xFF4CAF50)),
            const SizedBox(width: 16),
            _buildLegendItem('o3 (5, 15)', const Color(0xFFFF9800)),
          ],
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'o1 < o2 is true (both dx and dy are smaller)',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

class _OffsetComparisonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Grid
    paint.color = Colors.grey.withAlpha(60);
    for (var i = 0; i <= 20; i++) {
      final x = (size.width / 20) * i;
      final y = (size.height / 20) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Axes
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);

    // Points
    final scale = size.width / 20;

    // o1 (5, 5) - blue
    _drawPoint(canvas, Offset(5 * scale, 5 * scale), const Color(0xFF1565C0));

    // o2 (10, 10) - green
    _drawPoint(canvas, Offset(10 * scale, 10 * scale), const Color(0xFF4CAF50));

    // o3 (5, 15) - orange
    _drawPoint(canvas, Offset(5 * scale, 15 * scale), const Color(0xFFFF9800));

    // Comparison arrows
    paint.color = const Color(0xFF1565C0).withAlpha(100);
    paint.strokeWidth = 2;
    canvas.drawLine(
      Offset(5 * scale, 5 * scale),
      Offset(10 * scale, 10 * scale),
      paint,
    );
  }

  void _drawPoint(Canvas canvas, Offset position, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, 8, paint);

    paint
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, 4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildLegendItem(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 11)),
    ],
  );
}

Widget _buildVisualSizeComparison() {
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
            Icon(Icons.aspect_ratio, color: const Color(0xFF00897B)),
            const SizedBox(width: 8),
            const Text(
              'Size Comparison Visual',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSizeBox('s1', const Size(50, 30), const Color(0xFF1565C0)),
            const SizedBox(width: 20),
            _buildSizeBox('s2', const Size(100, 60), const Color(0xFF4CAF50)),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              's1 < s2 is true (both width and height are smaller)',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSizeBox(String label, Size size, Color color) {
  return Column(
    children: [
      Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: color.withAlpha(100),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        '${size.width.toInt()}×${size.height.toInt()}',
        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
      ),
    ],
  );
}

Widget _buildInfinityCard() {
  final tests = [
    {'val': 'Offset(1, 2)', 'isFinite': true, 'isInfinite': false},
    {'val': 'Offset.infinite', 'isFinite': false, 'isInfinite': true},
    {'val': 'Offset(∞, 2)', 'isFinite': false, 'isInfinite': true},
    {'val': 'Size(10, 20)', 'isFinite': true, 'isInfinite': false},
    {'val': 'Size.infinite', 'isFinite': false, 'isInfinite': true},
    {'val': 'Size(∞, 20)', 'isFinite': false, 'isInfinite': true},
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
            Icon(Icons.all_inclusive, color: const Color(0xFF00897B)),
            const SizedBox(width: 8),
            const Text(
              'Infinite Values',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'isInfinite: true if EITHER component is ∞',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        Text(
          'isFinite: true if BOTH components are finite',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(4),
              ),
              children: [
                _buildTableHeader('Value'),
                _buildTableHeader('isFinite'),
                _buildTableHeader('isInfinite'),
              ],
            ),
            ...tests.map((t) {
              return TableRow(
                children: [
                  _buildTableCell(t['val'] as String),
                  _buildTableCellBool(t['isFinite'] as bool),
                  _buildTableCellBool(t['isInfinite'] as bool),
                ],
              );
            }),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTableHeader(String text) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
    ),
  );
}

Widget _buildTableCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
    ),
  );
}

Widget _buildTableCellBool(bool value) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Icon(
      value ? Icons.check : Icons.close,
      size: 16,
      color: value ? const Color(0xFF4CAF50) : const Color(0xFFE53935),
    ),
  );
}

Widget _buildOperatorsCard() {
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
            Icon(Icons.calculate, color: const Color(0xFF00897B)),
            const SizedBox(width: 8),
            const Text(
              'Comparison Operators',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildOperatorRow(
          '<',
          'a.dx < b.dx && a.dy < b.dy',
          'Both components less',
        ),
        _buildOperatorRow(
          '<=',
          'a.dx <= b.dx && a.dy <= b.dy',
          'Both components less or equal',
        ),
        _buildOperatorRow(
          '>',
          'a.dx > b.dx && a.dy > b.dy',
          'Both components greater',
        ),
        _buildOperatorRow(
          '>=',
          'a.dx >= b.dx && a.dy >= b.dy',
          'Both components greater or equal',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFE0B2)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info, size: 16, color: Color(0xFFF57C00)),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Note: These operators require BOTH components to satisfy the condition, not just one.',
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

Widget _buildOperatorRow(String op, String logic, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFF00897B),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              op,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                logic,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCasesCard() {
  final useCases = [
    {
      'icon': Icons.touch_app,
      'title': 'Hit Testing',
      'desc': 'Use Offset comparisons to check if tap is within bounds',
    },
    {
      'icon': Icons.fit_screen,
      'title': 'Layout Constraints',
      'desc': 'Use Size comparisons to validate min/max constraints',
    },
    {
      'icon': Icons.grid_view,
      'title': 'Grid Positioning',
      'desc': 'Compare Offsets to determine relative positions',
    },
    {
      'icon': Icons.aspect_ratio,
      'title': 'Responsive Layout',
      'desc': 'Check if Size fits within available space',
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
            Icon(Icons.apps, color: const Color(0xFF00897B)),
            const SizedBox(width: 8),
            const Text(
              'Common Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...useCases.map((uc) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    uc['icon'] as IconData,
                    size: 20,
                    color: const Color(0xFF00897B),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        uc['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        uc['desc'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
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

dynamic build(BuildContext context) {
  print('=== OffsetBase Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- OffsetBase Overview ---');
  print('OffsetBase: Abstract base class for Offset and Size');
  print('Provides comparison operators and infinity checks');
  print('Cannot be instantiated directly');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: INHERITANCE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Type Hierarchy ---');
  final offset = const Offset(10.0, 20.0);
  final size = const Size(100.0, 50.0);
  print('Offset is OffsetBase: true');
  print('Size is OffsetBase: true');
  print('Offset dx: ${offset.dx}, dy: ${offset.dy}');
  print('Size width: ${size.width}, height: ${size.height}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: COMPARISON OPERATORS (Offset)
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Offset Comparison Operators ---');

  final o1 = const Offset(5.0, 5.0);
  final o2 = const Offset(10.0, 10.0);
  final o3 = const Offset(5.0, 15.0);

  print('o1 = Offset(5, 5)');
  print('o2 = Offset(10, 10)');
  print('o3 = Offset(5, 15)');

  print('\no1 < o2: ${o1 < o2}'); // true - both dx and dy are smaller
  print('o1 <= o2: ${o1 <= o2}'); // true
  print('o2 > o1: ${o2 > o1}'); // true - both dx and dy are larger
  print('o2 >= o1: ${o2 >= o1}'); // true

  // Mixed comparison
  print('\no1 < o3: ${o1 < o3}'); // false - dx equal, only dy smaller
  print('o3 > o1: ${o3 > o1}'); // false - dx equal, only dy larger

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISON OPERATORS (Size)
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Size Comparison Operators ---');

  final s1 = const Size(50.0, 30.0);
  final s2 = const Size(100.0, 60.0);
  final s3 = const Size(50.0, 80.0);

  print('s1 = Size(50, 30)');
  print('s2 = Size(100, 60)');
  print('s3 = Size(50, 80)');

  print('\ns1 < s2: ${s1 < s2}'); // true - both smaller
  print('s2 > s1: ${s2 > s1}'); // true - both larger
  print('s1 < s3: ${s1 < s3}'); // false - width equal
  print('s3 > s1: ${s3 > s1}'); // false - width equal

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: INFINITY CHECKS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Infinity Checks ---');

  final finiteOffset = const Offset(1.0, 2.0);
  final infiniteOffset = Offset.infinite;

  print('Finite offset ($finiteOffset):');
  print('  isInfinite: ${finiteOffset.isInfinite}');
  print('  isFinite: ${finiteOffset.isFinite}');

  print('\nInfinite offset (Offset.infinite):');
  print('  isInfinite: ${infiniteOffset.isInfinite}');
  print('  isFinite: ${infiniteOffset.isFinite}');

  // Partial infinity
  final partialInfinite = const Offset(double.infinity, 10.0);
  print('\nPartial infinite (∞, 10):');
  print('  isInfinite: ${partialInfinite.isInfinite}');
  print('  isFinite: ${partialInfinite.isFinite}');

  // Size infinity
  final finiteSize = const Size(10.0, 20.0);
  final infiniteSize = Size.infinite;

  print('\nFinite size ($finiteSize):');
  print('  isInfinite: ${finiteSize.isInfinite}');
  print('  isFinite: ${finiteSize.isFinite}');

  print('\nInfinite size (Size.infinite):');
  print('  isInfinite: ${infiniteSize.isInfinite}');
  print('  isFinite: ${infiniteSize.isFinite}');

  print('\n=== OffsetBase Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  // Prepare comparison data
  final offsetComparisons = <Map<String, dynamic>>[
    {
      'expr': 'o1 < o2',
      'result': o1 < o2,
      'desc': '(5,5) vs (10,10) - both smaller',
    },
    {
      'expr': 'o1 <= o2',
      'result': o1 <= o2,
      'desc': '(5,5) vs (10,10) - both ≤',
    },
    {
      'expr': 'o2 > o1',
      'result': o2 > o1,
      'desc': '(10,10) vs (5,5) - both larger',
    },
    {
      'expr': 'o2 >= o1',
      'result': o2 >= o1,
      'desc': '(10,10) vs (5,5) - both ≥',
    },
    {
      'expr': 'o1 < o3',
      'result': o1 < o3,
      'desc': '(5,5) vs (5,15) - dx equal!',
    },
    {
      'expr': 'o3 > o1',
      'result': o3 > o1,
      'desc': '(5,15) vs (5,5) - dx equal!',
    },
  ];

  final sizeComparisons = <Map<String, dynamic>>[
    {
      'expr': 's1 < s2',
      'result': s1 < s2,
      'desc': '50×30 vs 100×60 - both smaller',
    },
    {
      'expr': 's2 > s1',
      'result': s2 > s1,
      'desc': '100×60 vs 50×30 - both larger',
    },
    {
      'expr': 's1 < s3',
      'result': s1 < s3,
      'desc': '50×30 vs 50×80 - width equal!',
    },
    {
      'expr': 's3 > s1',
      'result': s3 > s1,
      'desc': '50×80 vs 50×30 - width equal!',
    },
  ];

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('OffsetBase', 'Abstract Base for Offset and Size'),
        const SizedBox(height: 20),

        // Class hierarchy
        _buildSectionTitle('Type Hierarchy', Icons.account_tree),
        _buildClassHierarchy(),
        const SizedBox(height: 20),

        // Operators
        _buildSectionTitle('Comparison Operators', Icons.compare_arrows),
        _buildOperatorsCard(),
        const SizedBox(height: 20),

        // Offset comparisons
        _buildSectionTitle('Offset Comparisons', Icons.gps_fixed),
        _buildComparisonCard('Offset Comparison Results', offsetComparisons),
        const SizedBox(height: 16),
        _buildVisualOffsetComparison(),
        const SizedBox(height: 20),

        // Size comparisons
        _buildSectionTitle('Size Comparisons', Icons.aspect_ratio),
        _buildComparisonCard('Size Comparison Results', sizeComparisons),
        const SizedBox(height: 16),
        _buildVisualSizeComparison(),
        const SizedBox(height: 20),

        // Infinity
        _buildSectionTitle('Infinity Handling', Icons.all_inclusive),
        _buildInfinityCard(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.apps),
        _buildUseCasesCard(),
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
                  color: Color(0xFF00695C),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• OffsetBase is abstract base for Offset and Size\n'
                '• Comparison operators check BOTH components\n'
                '• Offset(5,5) < Offset(10,10) is true\n'
                '• Offset(5,5) < Offset(5,15) is FALSE (dx equal)\n'
                '• isInfinite: true if ANY component is infinite\n'
                '• isFinite: true only if BOTH are finite',
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
