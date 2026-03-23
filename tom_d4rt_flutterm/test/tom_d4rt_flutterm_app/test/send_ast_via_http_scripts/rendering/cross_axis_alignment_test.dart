// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive demo for CrossAxisAlignment from rendering
//
// CrossAxisAlignment controls how children are positioned in the cross axis
// of a Flex layout (Row or Column):
//   - start: children at the start
//   - end: children at the end
//   - center: children centered
//   - stretch: children stretch to fill cross axis
//   - baseline: children aligned to text baseline
//
// This demo shows:
//   1. All CrossAxisAlignment values in Row context
//   2. All CrossAxisAlignment values in Column context
//   3. Baseline alignment with different font sizes
//   4. Interactive comparison of alignment modes
//   5. Visual representation of cross-axis behavior
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kIndigo50 = Color(0xFFE8EAF6);
const _kIndigo100 = Color(0xFFC5CAE9);
const _kIndigo200 = Color(0xFF9FA8DA);
const _kIndigo300 = Color(0xFF7986CB);
const _kIndigo400 = Color(0xFF5C6BC0);
const _kIndigo500 = Color(0xFF3F51B5);
const _kIndigo600 = Color(0xFF3949AB);
const _kIndigo700 = Color(0xFF303F9F);
const _kIndigo800 = Color(0xFF283593);
const _kIndigo900 = Color(0xFF1A237E);

const _kAmber100 = Color(0xFFFFECB3);
const _kAmber300 = Color(0xFFFFD54F);
const _kAmber400 = Color(0xFFFFCA28);
const _kAmber500 = Color(0xFFFFC107);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section header
Widget _buildSectionHeader(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16, top: 8),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kIndigo100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kIndigo800, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _kIndigo900,
          ),
        ),
      ],
    ),
  );
}

/// Builds an alignment label badge
Widget _buildAlignmentLabel(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
    ),
  );
}

/// Builds a sample child box for Row demos
Widget _buildRowChildBox(int index, double height, Color color) {
  return Container(
    width: 50,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '${index + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
  );
}

/// Builds a sample child box for Column demos
Widget _buildColumnChildBox(int index, double width, Color color) {
  return Container(
    width: width,
    height: 40,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '${index + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

/// Builds an info card
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _kIndigo600, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kIndigo900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kIndigo700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a Row alignment demo with given CrossAxisAlignment
Widget _buildRowAlignmentDemo(
  String title,
  CrossAxisAlignment alignment,
  Color accentColor,
) {
  final heights = [60.0, 40.0, 80.0, 50.0];
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildAlignmentLabel(title, accentColor),
            const Spacer(),
            Text(
              alignment.toString().split('.').last,
              style: TextStyle(
                fontSize: 12,
                color: accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: _kIndigo50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kIndigo200, width: 2),
          ),
          child: Row(
            crossAxisAlignment: alignment,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (i) {
              final colors = [
                _kIndigo400,
                _kIndigo500,
                _kIndigo600,
                _kIndigo700,
              ];
              return _buildRowChildBox(i, heights[i], colors[i]);
            }),
          ),
        ),
      ],
    ),
  );
}

/// Builds a Column alignment demo with given CrossAxisAlignment
Widget _buildColumnAlignmentDemo(
  String title,
  CrossAxisAlignment alignment,
  Color accentColor,
) {
  final widths = [120.0, 80.0, 160.0, 100.0];
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildAlignmentLabel(title, accentColor),
            const Spacer(),
            Text(
              alignment.toString().split('.').last,
              style: TextStyle(
                fontSize: 12,
                color: accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: _kIndigo50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kIndigo200, width: 2),
          ),
          child: Column(
            crossAxisAlignment: alignment,
            children: List.generate(4, (i) {
              final colors = [
                _kAmber300,
                _kAmber400,
                _kAmber500,
                const Color(0xFFFFB300),
              ];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: _buildColumnChildBox(i, widths[i], colors[i]),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

/// Builds the baseline alignment demo
Widget _buildBaselineDemo() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildAlignmentLabel('Baseline Alignment', _kIndigo600),
            const Spacer(),
            const Text(
              'Different font sizes aligned',
              style: TextStyle(fontSize: 11, color: _kIndigo500),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kIndigo50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kIndigo200, width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kIndigo200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Small',
                  style: TextStyle(fontSize: 12, color: _kIndigo900),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kIndigo300,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Medium',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kIndigo400,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Large',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kIndigo500,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'XL',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kAmber100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAmber300),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFFFF8F00), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Baseline alignment uses textBaseline to align text of different sizes along their baseline.',
                  style: TextStyle(fontSize: 12, color: Color(0xFFE65100)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a stretch comparison demo
Widget _buildStretchComparisonDemo() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
      boxShadow: [
        BoxShadow(
          color: _kIndigo100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAlignmentLabel('Stretch vs Center Comparison', _kIndigo700),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'STRETCH',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kIndigo600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: _kIndigo50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _kIndigo300, width: 2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 40,
                          color: _kIndigo400,
                          child: const Center(
                            child: Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          color: _kIndigo500,
                          child: const Center(
                            child: Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          color: _kIndigo600,
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'CENTER',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kIndigo600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: _kIndigo50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _kIndigo300, width: 2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _kAmber400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(child: Text('1')),
                        ),
                        Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _kAmber500,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(child: Text('2')),
                        ),
                        Container(
                          width: 40,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(child: Text('3')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Builds all values enumeration card
Widget _buildEnumerationCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All CrossAxisAlignment Values',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kIndigo900,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: CrossAxisAlignment.values.map((alignment) {
            final colors = [
              _kIndigo300,
              _kIndigo400,
              _kIndigo500,
              _kIndigo600,
              _kIndigo700,
            ];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: colors[alignment.index % colors.length],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${alignment.index}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: colors[alignment.index % colors.length],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    alignment.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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

/// Builds a visual axis diagram
Widget _buildAxisDiagram() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cross Axis in Row vs Column',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kIndigo900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'ROW',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _kIndigo600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: _kIndigo50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _kIndigo300),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          top: 45,
                          right: 8,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: _kIndigo500,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 40,
                          child: Icon(
                            Icons.arrow_forward,
                            color: _kIndigo500,
                            size: 16,
                          ),
                        ),
                        const Positioned(
                          right: 24,
                          top: 50,
                          child: Text(
                            'Main',
                            style: TextStyle(fontSize: 10, color: _kIndigo500),
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 8,
                          bottom: 8,
                          child: Container(
                            width: 2,
                            decoration: BoxDecoration(
                              color: _kAmber500,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 65,
                          top: 8,
                          child: Icon(
                            Icons.arrow_upward,
                            color: _kAmber500,
                            size: 16,
                          ),
                        ),
                        const Positioned(
                          left: 76,
                          top: 20,
                          child: Text(
                            'Cross',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFFB300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'COLUMN',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _kIndigo600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: _kIndigo50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _kIndigo300),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 70,
                          top: 8,
                          bottom: 8,
                          child: Container(
                            width: 2,
                            decoration: BoxDecoration(
                              color: _kIndigo500,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 65,
                          bottom: 8,
                          child: Icon(
                            Icons.arrow_downward,
                            color: _kIndigo500,
                            size: 16,
                          ),
                        ),
                        const Positioned(
                          left: 76,
                          bottom: 20,
                          child: Text(
                            'Main',
                            style: TextStyle(fontSize: 10, color: _kIndigo500),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 45,
                          right: 8,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: _kAmber500,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 40,
                          child: Icon(
                            Icons.arrow_forward,
                            color: _kAmber500,
                            size: 16,
                          ),
                        ),
                        const Positioned(
                          right: 24,
                          top: 50,
                          child: Text(
                            'Cross',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFFB300),
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
      ],
    ),
  );
}

/// Builds real-world use case examples
Widget _buildUseCaseExamples() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Real-World Use Cases',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kIndigo900,
          ),
        ),
        const SizedBox(height: 16),
        _buildUseCaseCard(
          'List Item with Avatar',
          CrossAxisAlignment.center,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: _kIndigo400,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'User Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'user@email.com',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildUseCaseCard(
          'Navigation Bar',
          CrossAxisAlignment.stretch,
          Container(
            height: 60,
            color: _kIndigo700,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: _kIndigo600,
                    child: const Center(
                      child: Icon(Icons.home, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: _kIndigo700,
                    child: const Center(
                      child: Icon(Icons.search, color: Colors.white70),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: _kIndigo700,
                    child: const Center(
                      child: Icon(Icons.settings, color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildUseCaseCard(
          'Form Labels',
          CrossAxisAlignment.start,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email Address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _kIndigo900,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _kIndigo50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kIndigo300),
                ),
                child: const Center(
                  child: Text(
                    'user@example.com',
                    style: TextStyle(color: _kIndigo600),
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

/// Helper for use case card
Widget _buildUseCaseCard(
  String title,
  CrossAxisAlignment alignment,
  Widget child,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kIndigo700,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _kIndigo200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                alignment.name,
                style: const TextStyle(fontSize: 10, color: _kIndigo800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('CrossAxisAlignment comprehensive demo executing');
  print('════════════════════════════════════════════════════════════════');

  // Log all values
  print('CrossAxisAlignment enum values:');
  for (final value in CrossAxisAlignment.values) {
    print('  [${value.index}] ${value.name}');
  }

  print('Total values: ${CrossAxisAlignment.values.length}');
  print('════════════════════════════════════════════════════════════════');

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kIndigo50, Colors.white, _kIndigo50],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kIndigo700, _kIndigo500],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kIndigo500.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.align_vertical_center,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CrossAxisAlignment',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Flex Layout Cross-Axis Positioning',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Introduction
          _buildInfoCard(
            'What is CrossAxisAlignment?',
            'CrossAxisAlignment determines how children are positioned along '
                'the cross axis in a Flex layout (perpendicular to the main axis). '
                'In a Row, the cross axis is vertical. In a Column, it\'s horizontal.',
            Icons.info_outline,
          ),

          // Axis diagram
          _buildSectionHeader('Understanding the Axes', Icons.swap_calls),
          _buildAxisDiagram(),

          // Enumeration
          _buildEnumerationCard(),

          // Row demos
          _buildSectionHeader('CrossAxisAlignment in Row', Icons.view_week),

          _buildRowAlignmentDemo(
            'Start',
            CrossAxisAlignment.start,
            _kIndigo500,
          ),
          _buildRowAlignmentDemo('End', CrossAxisAlignment.end, _kIndigo600),
          _buildRowAlignmentDemo(
            'Center',
            CrossAxisAlignment.center,
            _kIndigo700,
          ),
          _buildRowAlignmentDemo(
            'Stretch',
            CrossAxisAlignment.stretch,
            _kIndigo800,
          ),

          // Baseline demo
          _buildSectionHeader('Baseline Alignment', Icons.format_line_spacing),
          _buildBaselineDemo(),

          // Column demos
          _buildSectionHeader('CrossAxisAlignment in Column', Icons.view_day),

          _buildColumnAlignmentDemo(
            'Start',
            CrossAxisAlignment.start,
            _kAmber500,
          ),
          _buildColumnAlignmentDemo(
            'End',
            CrossAxisAlignment.end,
            const Color(0xFFFFB300),
          ),
          _buildColumnAlignmentDemo(
            'Center',
            CrossAxisAlignment.center,
            const Color(0xFFFF8F00),
          ),
          _buildColumnAlignmentDemo(
            'Stretch',
            CrossAxisAlignment.stretch,
            const Color(0xFFE65100),
          ),

          // Comparison
          _buildSectionHeader('Visual Comparison', Icons.compare),
          _buildStretchComparisonDemo(),

          // Use cases
          _buildSectionHeader('Real-World Examples', Icons.apps),
          _buildUseCaseExamples(),

          // Footer
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kIndigo100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: _kIndigo700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'CrossAxisAlignment demo complete! '
                    'Demonstrated all ${CrossAxisAlignment.values.length} alignment values.',
                    style: const TextStyle(color: _kIndigo800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
