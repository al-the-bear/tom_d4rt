// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for StrokeJoin from dart:ui
//
// StrokeJoin defines how corners are drawn where two lines meet.
// Three values exist:
//   - StrokeJoin.miter — sharp pointed corner (extends to a point)
//   - StrokeJoin.round — rounded corner
//   - StrokeJoin.bevel — flat corner (cut off diagonally)
//
// This demo uses Container decorations to visually simulate corner styles,
// while configuring real Paint objects to verify the strokeJoin property.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== StrokeJoin Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: PAINT CONFIGURATION
  // ═══════════════════════════════════════════════════════════════════════════

  final Paint paintMiter = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8.0
    ..strokeJoin = StrokeJoin.miter
    ..color = const Color(0xFF1565C0);

  final Paint paintRound = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8.0
    ..strokeJoin = StrokeJoin.round
    ..color = const Color(0xFF2E7D32);

  final Paint paintBevel = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8.0
    ..strokeJoin = StrokeJoin.bevel
    ..color = const Color(0xFFC62828);

  print('Paint miter: strokeJoin=${paintMiter.strokeJoin}');
  print('Paint round: strokeJoin=${paintRound.strokeJoin}');
  print('Paint bevel: strokeJoin=${paintBevel.strokeJoin}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUM VALUES OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- StrokeJoin Enum Values ---');
  final allJoins = StrokeJoin.values;
  print('StrokeJoin.values: $allJoins');
  print('Count: ${allJoins.length}');

  for (final join in allJoins) {
    print('  ${join.name}: index=${join.index}, toString=${join.toString()}');
  }

  // Descriptions
  final joinDescriptions = <StrokeJoin, String>{
    StrokeJoin.miter: 'Sharp pointed corners (default)',
    StrokeJoin.round: 'Rounded corners',
    StrokeJoin.bevel: 'Flat cut-off corners',
  };

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: MITER JOIN VISUALS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Miter Join Visual Section ---');

  // Miter creates sharp pointed corners
  Widget buildMiterDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'StrokeJoin.miter — Sharp Pointed Corners',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Miter join extends the stroke edges until they meet at a point.',
        ),
        const SizedBox(height: 12),
        // Sharp corner rectangles
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1565C0), width: 6),
                // No border radius = sharp miter-like corners
              ),
              child: const Center(
                child: Text('90°', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1976D2), width: 4),
              ),
              child: const Center(
                child: Text('Sharp', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1E88E5), width: 8),
              ),
              child: const Center(
                child: Text('Thick', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Nested sharp corners
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF0D47A1), width: 5),
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1565C0), width: 3),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF42A5F5), width: 2),
              ),
              child: const Center(child: Text('Nested Miter')),
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ROUND JOIN VISUALS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Round Join Visual Section ---');

  Widget buildRoundDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'StrokeJoin.round — Rounded Corners',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Round join creates a circular arc at the corner.'),
        const SizedBox(height: 12),
        // Rounded corner rectangles
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF2E7D32), width: 6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('12px', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF388E3C), width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text('20px', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF43A047), width: 8),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: Text('Circle', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Pill shapes (fully rounded ends)
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1B5E20), width: 4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Center(child: Text('Pill Shape')),
        ),
        const SizedBox(height: 8),
        // Stadium shape
        Container(
          width: 150,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4CAF50), width: 5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(child: Text('Stadium')),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BEVEL JOIN VISUALS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Bevel Join Visual Section ---');

  Widget buildBevelDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'StrokeJoin.bevel — Beveled/Chamfered Corners',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Bevel join cuts off the corner with a straight line.'),
        const SizedBox(height: 12),
        // Chamfered appearance using clipping and decoration
        Row(
          children: [
            // Simulate chamfered corner with small radius
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFC62828), width: 6),
                borderRadius: BorderRadius.circular(4), // Small chamfer effect
              ),
              child: const Center(
                child: Text('4px', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD32F2F), width: 4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text('Bevel', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(width: 16),
            // Octagon-like appearance
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE53935), width: 5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('8px', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Wide beveled shape
        Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB71C1C), width: 5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(child: Text('Wide Bevel Effect')),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: COMPARISON GRID
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Comparison Grid ---');

  Widget buildComparisonGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Side-by-Side Comparison',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // Row headers
        Row(
          children: [
            const SizedBox(
              width: 60,
              child: Text(
                'Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Thin',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Medium',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Thick',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        // Miter row
        Row(
          children: [
            const SizedBox(
              width: 60,
              child: Text('Miter', style: TextStyle(color: Color(0xFF1565C0))),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1565C0),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1565C0),
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1565C0),
                      width: 8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Round row
        Row(
          children: [
            const SizedBox(
              width: 60,
              child: Text('Round', style: TextStyle(color: Color(0xFF2E7D32))),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF2E7D32),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF2E7D32),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF2E7D32),
                      width: 8,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Bevel row
        Row(
          children: [
            const SizedBox(
              width: 60,
              child: Text('Bevel', style: TextStyle(color: Color(0xFFC62828))),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC62828),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC62828),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC62828),
                      width: 8,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: STROKE WIDTHS WITH JOINS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Stroke Widths Section ---');

  Widget buildStrokeWidthSection() {
    final widths = [1.0, 2.0, 4.0, 6.0, 8.0, 10.0, 12.0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stroke Width Impact on Joins',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Wider strokes make join style more visible.'),
        const SizedBox(height: 12),
        ...widths.map((width) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    '${width.toInt()}px',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                // Miter
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1565C0),
                      width: width,
                    ),
                  ),
                ),
                // Round
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF2E7D32),
                      width: width,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Bevel
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC62828),
                      width: width,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: MITER LIMIT CONCEPT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Miter Limit Concept ---');

  // Paint also has strokeMiterLimit which limits how far miter can extend
  final Paint paintMiterLimited = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10.0
    ..strokeJoin = StrokeJoin.miter
    ..strokeMiterLimit = 2.0
    ..color = const Color(0xFF6A1B9A);

  print(
    'Paint with miterLimit: strokeMiterLimit=${paintMiterLimited.strokeMiterLimit}',
  );

  Widget buildMiterLimitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Miter Limit Concept',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'strokeMiterLimit controls how far a miter join can extend.',
        ),
        const Text(
          'If the miter would extend beyond the limit, it becomes a bevel.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Paint Configuration:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('  strokeJoin = StrokeJoin.miter'),
              const Text('  strokeMiterLimit = 2.0'),
              const SizedBox(height: 8),
              const Text('Sharp angles may exceed miter limit,'),
              const Text('causing fallback to bevel join.'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Visual showing potential miter limit scenario
        Row(
          children: [
            Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF6A1B9A),
                      width: 8,
                    ),
                  ),
                  child: const Center(child: Text('90°')),
                ),
                const SizedBox(height: 4),
                const Text('Within limit', style: TextStyle(fontSize: 10)),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Transform.rotate(
                  angle: 0.3,
                  child: Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF8E24AA),
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Center(child: Text('Acute')),
                  ),
                ),
                const SizedBox(height: 4),
                const Text('May exceed', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: PRACTICAL APPLICATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Practical Applications ---');

  Widget buildPracticalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Practical Applications',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        // Buttons with different corner styles
        const Text(
          'Button Styles:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Sharp corners (miter)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1565C0), width: 2),
              ),
              child: const Text(
                'Sharp',
                style: TextStyle(color: Color(0xFF1565C0)),
              ),
            ),
            const SizedBox(width: 12),
            // Rounded corners
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF2E7D32), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Rounded',
                style: TextStyle(color: Color(0xFF2E7D32)),
              ),
            ),
            const SizedBox(width: 12),
            // Subtle bevel
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFC62828), width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Beveled',
                style: TextStyle(color: Color(0xFFC62828)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Card styles
        const Text(
          'Card Styles:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(child: Text('Sharp Card')),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(child: Text('Round Card')),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Input fields
        const Text(
          'Input Field Styles:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sharp input...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rounded input...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pill input...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: CHART/GRAPH STYLES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Chart/Graph Join Styles ---');

  Widget buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chart Corner Styles',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('Different join styles for chart elements'),
        const SizedBox(height: 12),
        // Bar chart with different corner styles
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Sharp bars
            Column(
              children: [
                Container(
                  width: 30,
                  height: 100,
                  color: const Color(0xFF1565C0),
                ),
                const SizedBox(height: 4),
                const Text('M', style: TextStyle(fontSize: 10)),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                Container(
                  width: 30,
                  height: 70,
                  color: const Color(0xFF1976D2),
                ),
                const SizedBox(height: 4),
                const Text('T', style: TextStyle(fontSize: 10)),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                Container(
                  width: 30,
                  height: 90,
                  color: const Color(0xFF1E88E5),
                ),
                const SizedBox(height: 4),
                const Text('W', style: TextStyle(fontSize: 10)),
              ],
            ),
            const SizedBox(width: 20),
            // Rounded bars
            Column(
              children: [
                Container(
                  width: 30,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text('M', style: TextStyle(fontSize: 10)),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                Container(
                  width: 30,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF388E3C),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text('T', style: TextStyle(fontSize: 10)),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                Container(
                  width: 30,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFF43A047),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text('W', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(width: 12, height: 12, color: const Color(0xFF1565C0)),
            const SizedBox(width: 4),
            const Text('Sharp (Miter)', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 16),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 4),
            const Text('Rounded', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: ICON FRAMES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Icon Frame Styles ---');

  Widget buildIconFrameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Icon Frame Join Styles',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Sharp frame
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1565C0), width: 3),
              ),
              child: const Icon(Icons.star, color: Color(0xFF1565C0)),
            ),
            const SizedBox(width: 12),
            // Rounded frame
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF2E7D32), width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.favorite, color: Color(0xFF2E7D32)),
            ),
            const SizedBox(width: 12),
            // Circular frame
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFC62828), width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.person, color: Color(0xFFC62828)),
            ),
            const SizedBox(width: 12),
            // Subtle bevel
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF6A1B9A), width: 3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.settings, color: Color(0xFF6A1B9A)),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: ENUM OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Enum Operations ---');

  // Equality and identity
  final join1 = StrokeJoin.miter;
  final join2 = StrokeJoin.miter;
  final join3 = StrokeJoin.round;

  print('join1 == join2: ${join1 == join2}');
  print('identical(join1, join2): ${identical(join1, join2)}');
  print('join1 == join3: ${join1 == join3}');
  print('join1.hashCode: ${join1.hashCode}');
  print('join3.hashCode: ${join3.hashCode}');

  Widget buildEnumOpsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enum Operations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('miter == miter: ${join1 == join2}'),
              Text('identical(miter, miter): ${identical(join1, join2)}'),
              Text('miter == round: ${join1 == join3}'),
              const SizedBox(height: 8),
              Text('miter.hashCode: ${join1.hashCode}'),
              Text('round.hashCode: ${join3.hashCode}'),
              Text('bevel.hashCode: ${StrokeJoin.bevel.hashCode}'),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD VISUAL OUTPUT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Building Visual Output ---');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Text(
          'StrokeJoin Deep Demo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Demonstrates how corners are drawn where stroke lines meet.',
        ),
        const SizedBox(height: 16),

        // Enum overview card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'StrokeJoin Values',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),
                ...allJoins.map((join) {
                  final color = join == StrokeJoin.miter
                      ? const Color(0xFF1565C0)
                      : join == StrokeJoin.round
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFC62828);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(color: color, width: 3),
                            borderRadius: join == StrokeJoin.round
                                ? BorderRadius.circular(6)
                                : join == StrokeJoin.bevel
                                ? BorderRadius.circular(2)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          join.name,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            joinDescriptions[join] ?? '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Miter section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildMiterDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Round section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildRoundDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Bevel section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildBevelDemo(),
          ),
        ),
        const SizedBox(height: 16),

        // Comparison grid
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildComparisonGrid(),
          ),
        ),
        const SizedBox(height: 16),

        // Stroke width section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildStrokeWidthSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Miter limit concept
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildMiterLimitSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Practical applications
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildPracticalSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Chart section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildChartSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Icon frames
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildIconFrameSection(),
          ),
        ),
        const SizedBox(height: 16),

        // Enum operations
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: buildEnumOpsSection(),
          ),
        ),
        const SizedBox(height: 32),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• StrokeJoin.miter: Sharp pointed corners (default)'),
              Text('• StrokeJoin.round: Circular arc at corners'),
              Text('• StrokeJoin.bevel: Flat cut-off corners'),
              SizedBox(height: 8),
              Text('Set via Paint.strokeJoin property.'),
              Text('strokeMiterLimit controls miter extension.'),
            ],
          ),
        ),
      ],
    ),
  );
}
