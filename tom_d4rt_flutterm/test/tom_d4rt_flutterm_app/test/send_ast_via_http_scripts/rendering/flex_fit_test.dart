// D4rt test script: Comprehensive demo for FlexFit from rendering
//
// FlexFit is an enum that controls how a child in a Flex widget (Row/Column)
// participates in flexible space allocation.
//
// Values:
//   - tight: Child MUST fill all allocated space (Expanded behavior)
//   - loose: Child CAN be smaller than allocated space (Flexible default)
//
// This demo shows:
//   1. Visual comparison of tight vs loose fit
//   2. How FlexFit affects layout with Flexible widget
//   3. Difference between Expanded and Flexible
//   4. Real-world use cases for each fit type
//   5. Combining multiple flex children with different fits
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kEmerald100 = Color(0xFFD1FAE5);
const _kEmerald300 = Color(0xFF6EE7B7);
const _kEmerald400 = Color(0xFF34D399);
const _kEmerald500 = Color(0xFF10B981);
const _kEmerald600 = Color(0xFF059669);
const _kEmerald700 = Color(0xFF047857);
const _kEmerald800 = Color(0xFF065F46);

const _kViolet400 = Color(0xFFA78BFA);
const _kViolet500 = Color(0xFF8B5CF6);
const _kViolet600 = Color(0xFF7C3AED);

const _kSlate600 = Color(0xFF475569);
const _kSlate700 = Color(0xFF334155);
const _kSlate800 = Color(0xFF1E293B);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section header
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kEmerald700, _kEmerald500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kEmerald700.withAlpha(80),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a card with content
Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  final color = accentColor ?? _kEmerald500;
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

/// Builds the main header
Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kEmerald800, _kEmerald600, _kEmerald400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kEmerald800.withAlpha(100),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.view_column, color: Colors.white, size: 48),
        const SizedBox(height: 12),
        const Text(
          'FlexFit',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Control flexible space allocation',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBadge('tight', Icons.unfold_more),
            const SizedBox(width: 12),
            _buildStatBadge('loose', Icons.unfold_less),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStatBadge(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(40),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

/// Builds a flex fit enum value display
Widget _buildEnumValueRow(
  FlexFit value,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'FlexFit.${value.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'index: ${value.index}',
                      style: TextStyle(
                        fontSize: 10,
                        color: color,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: color.withAlpha(180)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds code snippet display
Widget _buildCodeSnippet(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFF9CDCFE),
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}

/// Builds a visual demo showing tight vs loose
Widget _buildFlexDemo(String title, FlexFit fit, Color color) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
          color: _kSlate600.withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kSlate600.withAlpha(60)),
        ),
        child: Row(
          children: [
            // Fixed child
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: _kSlate700,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                ),
              ),
              child: const Center(
                child: Text(
                  'Fixed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Flexible child with specified fit
            Flexible(
              fit: fit,
              child: Container(
                // For tight: fills space; for loose: only takes needed space
                height: double.infinity,
                decoration: BoxDecoration(color: color),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      fit == FlexFit.tight ? 'Fills Space' : 'Content',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'FlexFit.${fit.name}',
          style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: color),
        ),
      ),
    ],
  );
}

/// Builds a visual comparison of multiple flex children
Widget _buildMultipleFlexComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Same flex factors, different fits:',
        style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate800),
      ),
      const SizedBox(height: 12),
      // All tight
      _buildComparisonRow(
        'All tight',
        [FlexFit.tight, FlexFit.tight, FlexFit.tight],
        [_kEmerald500, _kEmerald400, _kEmerald300],
      ),
      const SizedBox(height: 12),
      // All loose
      _buildComparisonRow(
        'All loose',
        [FlexFit.loose, FlexFit.loose, FlexFit.loose],
        [_kViolet500, _kViolet400, _kViolet600],
      ),
      const SizedBox(height: 12),
      // Mixed
      _buildComparisonRow(
        'Mixed fits',
        [FlexFit.tight, FlexFit.loose, FlexFit.tight],
        [_kEmerald500, _kViolet500, _kEmerald500],
      ),
    ],
  );
}

Widget _buildComparisonRow(
  String label,
  List<FlexFit> fits,
  List<Color> colors,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, color: _kSlate700)),
      const SizedBox(height: 4),
      Container(
        height: 50,
        decoration: BoxDecoration(
          color: _kSlate600.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kSlate600.withAlpha(40)),
        ),
        child: Row(
          children: List.generate(fits.length, (i) {
            return Flexible(
              fit: fits[i],
              child: Container(
                height: double.infinity,
                margin: EdgeInsets.only(left: i > 0 ? 2 : 0),
                decoration: BoxDecoration(
                  color: colors[i],
                  borderRadius: BorderRadius.horizontal(
                    left: i == 0 ? const Radius.circular(7) : Radius.zero,
                    right: i == fits.length - 1
                        ? const Radius.circular(7)
                        : Radius.zero,
                  ),
                ),
                child: Center(
                  child: Text(
                    fits[i].name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ],
  );
}

/// Builds the Expanded vs Flexible comparison
Widget _buildExpandedVsFlexible() {
  return Column(
    children: [
      // Expanded (tight)
      _buildWidgetComparison(
        'Expanded',
        'FlexFit.tight',
        'Always fills available space',
        _kEmerald500,
        Icons.unfold_more,
        FlexFit.tight,
      ),
      const SizedBox(height: 12),
      // Flexible (loose)
      _buildWidgetComparison(
        'Flexible (default)',
        'FlexFit.loose',
        'Takes only what content needs',
        _kViolet500,
        Icons.unfold_less,
        FlexFit.loose,
      ),
    ],
  );
}

Widget _buildWidgetComparison(
  String widgetName,
  String fitType,
  String description,
  Color color,
  IconData icon,
  FlexFit fit,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widgetName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 16,
                  ),
                ),
                Text(
                  fitType,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: color.withAlpha(180),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: _kSlate700),
        ),
        const SizedBox(height: 12),
        // Visual demo
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: _kSlate600.withAlpha(20),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Flexible(
                fit: fit,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Center(
                    child: Text(
                      'Content',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
}

/// Builds use case examples
Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
  Widget demo,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50)),
      boxShadow: [BoxShadow(color: color.withAlpha(20), blurRadius: 8)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: _kSlate700),
        ),
        const SizedBox(height: 12),
        demo,
      ],
    ),
  );
}

/// Builds the flex factor interaction demo
Widget _buildFlexFactorDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Flex factors with FlexFit.tight:',
        style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate800),
      ),
      const SizedBox(height: 12),
      // flex: 1, 2, 1
      _buildFactorRow([1, 2, 1], FlexFit.tight),
      const SizedBox(height: 8),
      // flex: 1, 1, 3
      _buildFactorRow([1, 1, 3], FlexFit.tight),
      const SizedBox(height: 12),
      const Text(
        'Flex factors with FlexFit.loose (same factors):',
        style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate800),
      ),
      const SizedBox(height: 12),
      _buildFactorRow([1, 2, 1], FlexFit.loose),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _kViolet500.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline, color: _kViolet500, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'With loose fit, children only take space they need, ignoring flex ratios',
                style: TextStyle(fontSize: 11, color: _kViolet600),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFactorRow(List<int> factors, FlexFit fit) {
  final colors = [_kEmerald400, _kEmerald500, _kEmerald600];
  return Container(
    height: 44,
    decoration: BoxDecoration(
      color: _kSlate600.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kSlate600.withAlpha(40)),
    ),
    child: Row(
      children: List.generate(factors.length, (i) {
        return Flexible(
          flex: factors[i],
          fit: fit,
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.only(left: i > 0 ? 2 : 0),
            decoration: BoxDecoration(
              color: colors[i],
              borderRadius: BorderRadius.horizontal(
                left: i == 0 ? const Radius.circular(7) : Radius.zero,
                right: i == factors.length - 1
                    ? const Radius.circular(7)
                    : Radius.zero,
              ),
            ),
            child: Center(
              child: Text(
                'flex: ${factors[i]}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}

/// Info card helper
Widget _buildInfoCard(String title, String content, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                content,
                style: TextStyle(fontSize: 12, color: color.withAlpha(180)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds practical examples
Widget _buildPracticalExamples() {
  return Column(
    children: [
      // Navigation bar example
      _buildUseCaseCard(
        'Navigation Bar',
        'Use tight fit for equal width buttons',
        Icons.menu,
        _kEmerald600,
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: _kEmerald100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: List.generate(4, (i) {
              final icons = [
                Icons.home,
                Icons.search,
                Icons.favorite,
                Icons.person,
              ];
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: i == 0 ? _kEmerald500 : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icons[i],
                    color: i == 0 ? Colors.white : _kEmerald600,
                    size: 20,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      // Chat input example
      _buildUseCaseCard(
        'Chat Input',
        'Use loose fit for send button, tight for text field',
        Icons.chat_bubble,
        _kViolet600,
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: _kViolet500.withAlpha(20),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Text(
                    'Type a message...',
                    style: TextStyle(color: _kSlate600, fontSize: 13),
                  ),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: _kViolet500,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ),
      // Tag chips example
      _buildUseCaseCard(
        'Tag Chips',
        'Use loose fit for content-sized chips',
        Icons.label,
        _kEmerald500,
        Wrap(
          spacing: 8,
          children: ['Flutter', 'Dart', 'UI', 'Layout'].map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _kEmerald100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _kEmerald300),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: _kEmerald700,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════════════');
  print('FlexFit Deep Demo');
  print('═══════════════════════════════════════════════════════════════');

  // Enumerate all values
  print('\nFlexFit values:');
  for (final value in FlexFit.values) {
    print('  FlexFit.${value.name} (index: ${value.index})');
  }

  print('\nBehavior comparison:');
  print('  tight: Child MUST fill all allocated space');
  print('  loose: Child CAN be smaller than allocated space');

  print('\nWidget equivalents:');
  print('  Expanded = Flexible(fit: FlexFit.tight)');
  print('  Flexible = Flexible(fit: FlexFit.loose) // default');

  print('\nFlexFit demo completed');
  print('═══════════════════════════════════════════════════════════════');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main header
        _buildMainHeader(),
        const SizedBox(height: 24),

        // Section 1: What is FlexFit
        _buildSectionHeader('What is FlexFit?', Icons.help_outline),
        _buildCard(
          'Overview',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FlexFit determines how a child of a Flexible widget should '
                'participate in filling available space within a Row or Column.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildCodeSnippet(
                'enum FlexFit {\n'
                '  tight,  // Must fill allocated space\n'
                '  loose,  // Can be smaller than allocated\n'
                '}',
              ),
            ],
          ),
        ),

        // Section 2: Enum Values
        _buildSectionHeader('Enum Values', Icons.list),
        _buildCard(
          'All FlexFit Values',
          Column(
            children: [
              _buildEnumValueRow(
                FlexFit.tight,
                'Child MUST fill all allocated space completely',
                Icons.unfold_more,
                _kEmerald500,
              ),
              const SizedBox(height: 12),
              _buildEnumValueRow(
                FlexFit.loose,
                'Child CAN be smaller than allocated space',
                Icons.unfold_less,
                _kViolet500,
              ),
            ],
          ),
        ),

        // Section 3: Visual Comparison
        _buildSectionHeader('Visual Comparison', Icons.compare),
        _buildCard(
          'tight vs loose',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFlexDemo('Tight Fit', FlexFit.tight, _kEmerald500),
              _buildFlexDemo('Loose Fit', FlexFit.loose, _kViolet500),
            ],
          ),
        ),

        // Section 4: Expanded vs Flexible
        _buildSectionHeader('Expanded vs Flexible', Icons.swap_horiz),
        _buildCard(
          'Widget Equivalents',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpandedVsFlexible(),
              const SizedBox(height: 16),
              _buildCodeSnippet(
                '// These are equivalent:\n'
                'Expanded(child: widget)\n'
                'Flexible(fit: FlexFit.tight, child: widget)\n\n'
                '// Default Flexible uses loose:\n'
                'Flexible(child: widget)  // FlexFit.loose',
              ),
            ],
          ),
        ),

        // Section 5: Multiple Flex Children
        _buildSectionHeader('Multiple Flex Children', Icons.view_column),
        _buildCard('Combining Different Fits', _buildMultipleFlexComparison()),

        // Section 6: Flex Factors
        _buildSectionHeader('With Flex Factors', Icons.tune),
        _buildCard('Flex Factor Interaction', _buildFlexFactorDemo()),

        // Section 7: Practical Examples
        _buildSectionHeader('Practical Examples', Icons.apps),
        _buildCard('Real-World Use Cases', _buildPracticalExamples()),

        // Section 8: Usage Guidelines
        _buildSectionHeader('Guidelines', Icons.rule),
        _buildCard(
          'When to Use Each Fit',
          Column(
            children: [
              _buildInfoCard(
                'Use tight when:',
                'You want children to equally divide space (nav bars, grids)',
                _kEmerald500,
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                'Use loose when:',
                'Children should size to content (tags, badges, icons)',
                _kViolet500,
              ),
            ],
          ),
        ),

        // Section 9: Code Examples
        _buildSectionHeader('Code Examples', Icons.code),
        _buildCard(
          'Common Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeSnippet(
                '// Equal width buttons in a row\n'
                'Row(\n'
                '  children: [\n'
                '    Expanded(child: Button1()),  // tight\n'
                '    Expanded(child: Button2()),  // tight\n'
                '    Expanded(child: Button3()),  // tight\n'
                '  ],\n'
                ')\n\n'
                '// Input with fixed-size button\n'
                'Row(\n'
                '  children: [\n'
                '    Expanded(child: TextField()),  // tight\n'
                '    IconButton(icon: sendIcon),    // natural size\n'
                '  ],\n'
                ')\n\n'
                '// Mixed fits for custom layouts\n'
                'Row(\n'
                '  children: [\n'
                '    Flexible(fit: FlexFit.loose, child: Icon()),\n'
                '    Expanded(child: Title()),  // tight\n'
                '    Flexible(fit: FlexFit.loose, child: Badge()),\n'
                '  ],\n'
                ')',
              ),
            ],
          ),
        ),

        // Footer
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kEmerald100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: _kEmerald700, size: 32),
              const SizedBox(height: 8),
              const Text(
                'FlexFit Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _kEmerald800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Control how flexible children fill space',
                style: TextStyle(fontSize: 12, color: _kEmerald600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}
