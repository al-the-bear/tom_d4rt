// ignore_for_file: avoid_print
// D4rt test script: Comprehensive demo for GrowthDirection from rendering
//
// GrowthDirection is an enum that describes the direction in which a sliver's
// content grows relative to the scroll offset. It controls whether children
// are laid out from 0 towards positive infinity (forward) or from 0 towards
// negative infinity (reverse).
//
// Values:
//   - forward: Content grows in the positive scroll direction
//   - reverse: Content grows in the negative scroll direction
//
// This demo shows:
//   1. Visual explanation of forward vs reverse growth
//   2. How GrowthDirection interacts with AxisDirection
//   3. CustomScrollView with different growth directions
//   4. SliverList with forward and reverse ordering
//   5. Practical viewport geometry visualization
//   6. Real-world usage in scrollable layouts
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS – Cyan / Amber theme
// ═══════════════════════════════════════════════════════════════════════════

const _kCyan50 = Color(0xFFECFEFF);
const _kCyan100 = Color(0xFFCFFAFE);
const _kCyan200 = Color(0xFFA5F3FC);
const _kCyan300 = Color(0xFF67E8F9);
const _kCyan400 = Color(0xFF22D3EE);
const _kCyan500 = Color(0xFF06B6D4);
const _kCyan600 = Color(0xFF0891B2);
const _kCyan700 = Color(0xFF0E7490);
const _kCyan800 = Color(0xFF155E75);

const _kAmber300 = Color(0xFFFCD34D);
const _kAmber400 = Color(0xFFFBBF24);
const _kAmber500 = Color(0xFFF59E0B);
const _kAmber600 = Color(0xFFD97706);

const _kSlate50 = Color(0xFFF8FAFC);
const _kSlate100 = Color(0xFFF1F5F9);
const _kSlate600 = Color(0xFF475569);
const _kSlate700 = Color(0xFF334155);
const _kSlate800 = Color(0xFF1E293B);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section header with gradient
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCyan800, _kCyan600],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kCyan800.withAlpha(80),
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

/// Builds an info card with label and value
Widget _buildInfoCard(String label, String value, Color accentColor) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kSlate50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accentColor.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: accentColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kSlate800,
          ),
        ),
      ],
    ),
  );
}

/// Builds a growth direction arrow diagram
Widget _buildArrowDiagram(
  String label,
  GrowthDirection direction,
  Color color,
) {
  final isForward = direction == GrowthDirection.forward;
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        // Arrow visualization
        Row(
          children: [
            if (!isForward) Icon(Icons.arrow_back, color: color, size: 32),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isForward
                        ? [color.withAlpha(60), color]
                        : [color, color.withAlpha(60)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            if (isForward) Icon(Icons.arrow_forward, color: color, size: 32),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isForward ? 'Start (0)' : 'End',
              style: TextStyle(
                fontSize: 12,
                color: _kSlate600,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              isForward ? 'End (+∞)' : 'Start (0)',
              style: TextStyle(
                fontSize: 12,
                color: _kSlate600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          isForward
              ? 'Children laid out from index 0 →'
              : '← Children laid out from index 0',
          style: TextStyle(fontSize: 13, color: _kSlate700),
        ),
      ],
    ),
  );
}

/// Builds a comparison row between forward and reverse
Widget _buildComparisonPanel(
  String title,
  String forwardDesc,
  String reverseDesc,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(10),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _kSlate800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kCyan50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kCyan300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.arrow_forward, color: _kCyan600, size: 20),
                    const SizedBox(height: 4),
                    Text(
                      'Forward',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _kCyan700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      forwardDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: _kSlate600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAmber400),
                ),
                child: Column(
                  children: [
                    Icon(Icons.arrow_back, color: _kAmber600, size: 20),
                    const SizedBox(height: 4),
                    Text(
                      'Reverse',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _kAmber600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reverseDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: _kSlate600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Simulates a viewport cross-section with growth annotation
Widget _buildViewportDiagram(GrowthDirection direction) {
  final isForward = direction == GrowthDirection.forward;
  final mainColor = isForward ? _kCyan500 : _kAmber500;
  final label = isForward
      ? 'GrowthDirection.forward'
      : 'GrowthDirection.reverse';

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: mainColor.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: mainColor.withAlpha(30),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: mainColor,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Viewport visual
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: _kSlate600, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Top label
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _kSlate100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                child: Text(
                  isForward ? '↓ Scroll direction ↓' : '↑ Scroll direction ↑',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _kSlate700,
                  ),
                ),
              ),
              // Items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: List.generate(4, (i) {
                      final idx = isForward ? i : 3 - i;
                      final colors = [
                        _kCyan100,
                        _kCyan200,
                        _kCyan300,
                        _kCyan400,
                      ];
                      return Expanded(
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          decoration: BoxDecoration(
                            color: isForward
                                ? colors[i]
                                : _kAmber300.withAlpha(60 + idx * 50),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Sliver child $idx',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _kSlate800,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              // Bottom label
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _kSlate100,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(6),
                  ),
                ),
                child: Text(
                  isForward
                      ? 'Leading edge → Trailing'
                      : 'Trailing → Leading edge',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: _kSlate600),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds an AxisDirection + GrowthDirection mapping card
Widget _buildAxisDirectionCard(
  AxisDirection axisDir,
  GrowthDirection growth,
  String description,
) {
  final isForward = growth == GrowthDirection.forward;
  final color = isForward ? _kCyan600 : _kAmber600;
  final IconData arrowIcon;
  switch (axisDir) {
    case AxisDirection.up:
      arrowIcon = Icons.arrow_upward;
    case AxisDirection.down:
      arrowIcon = Icons.arrow_downward;
    case AxisDirection.left:
      arrowIcon = Icons.arrow_back;
    case AxisDirection.right:
      arrowIcon = Icons.arrow_forward;
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(arrowIcon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${axisDir.name} + ${growth.name}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kSlate800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kSlate600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a practical example card
Widget _buildPracticalExample(
  String title,
  String code,
  String explanation,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCyan200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCyan50,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Row(
            children: [
              Icon(icon, color: _kCyan700, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kCyan800,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kSlate800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  code,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                explanation,
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('GrowthDirection deep demo executing');

  // === Data exploration ===
  print('GrowthDirection values: ${GrowthDirection.values}');
  for (final v in GrowthDirection.values) {
    print('  ${v.name} (index=${v.index})');
  }

  // === applyGrowthDirectionToAxisDirection ===
  for (final ad in AxisDirection.values) {
    for (final gd in GrowthDirection.values) {
      final result = applyGrowthDirectionToAxisDirection(ad, gd);
      print('  applyGrowthDirection($ad, $gd) => $result');
    }
  }

  // === applyGrowthDirectionToScrollDirection ===
  for (final sd in ScrollDirection.values) {
    for (final gd in GrowthDirection.values) {
      final result = applyGrowthDirectionToScrollDirection(sd, gd);
      print('  applyGrowthDirectionToScroll($sd, $gd) => $result');
    }
  }

  print('GrowthDirection deep demo completed');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Title ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kCyan800, _kCyan500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kCyan800.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.swap_vert_circle, color: Colors.white, size: 48),
              const SizedBox(height: 12),
              const Text(
                'GrowthDirection',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Controls the direction slivers grow '
                'relative to the scroll offset',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoCard(
                    'VALUES',
                    '${GrowthDirection.values.length}',
                    _kAmber400,
                  ),
                  const SizedBox(width: 12),
                  _buildInfoCard('TYPE', 'enum', _kAmber400),
                  const SizedBox(width: 12),
                  _buildInfoCard('LIBRARY', 'rendering', _kAmber400),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 1: Forward vs Reverse ──────────────────────────
        _buildSectionHeader('Forward vs Reverse', Icons.compare_arrows),

        Text(
          'GrowthDirection has two values that describe how items are '
          'laid out relative to the scroll origin:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 16),

        _buildArrowDiagram(
          'GrowthDirection.forward',
          GrowthDirection.forward,
          _kCyan600,
        ),
        const SizedBox(height: 12),
        _buildArrowDiagram(
          'GrowthDirection.reverse',
          GrowthDirection.reverse,
          _kAmber500,
        ),

        const SizedBox(height: 24),

        // ─── Section 2: Enum Properties ─────────────────────────────
        _buildSectionHeader('Enum Properties', Icons.list_alt),

        ...GrowthDirection.values.map((gd) {
          final isForward = gd == GrowthDirection.forward;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isForward ? _kCyan300 : _kAmber400),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isForward ? _kCyan100 : Color(0xFFFEF3C7),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${gd.index}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isForward ? _kCyan700 : _kAmber600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GrowthDirection.${gd.name}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _kSlate800,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isForward
                            ? 'Content grows toward positive scroll offset'
                            : 'Content grows toward negative scroll offset',
                        style: TextStyle(fontSize: 12, color: _kSlate600),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isForward ? Icons.trending_flat : Icons.u_turn_left,
                  color: isForward ? _kCyan600 : _kAmber500,
                  size: 28,
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 24),

        // ─── Section 3: Viewport Visualization ──────────────────────
        _buildSectionHeader('Viewport Visualization', Icons.view_carousel),

        Text(
          'Inside a Viewport, slivers can grow in either direction from '
          'the center. The first set of slivers grows forward (down) and '
          'the second set grows reverse (up from center):',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildViewportDiagram(GrowthDirection.forward)),
            const SizedBox(width: 12),
            Expanded(child: _buildViewportDiagram(GrowthDirection.reverse)),
          ],
        ),

        const SizedBox(height: 24),

        // ─── Section 4: AxisDirection Mapping ───────────────────────
        _buildSectionHeader('AxisDirection Mapping', Icons.explore),

        Text(
          'applyGrowthDirectionToAxisDirection flips the axis direction '
          'when the growth direction is reverse:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        _buildAxisDirectionCard(
          AxisDirection.down,
          GrowthDirection.forward,
          'down + forward → down (normal vertical scroll)',
        ),
        _buildAxisDirectionCard(
          AxisDirection.down,
          GrowthDirection.reverse,
          'down + reverse → up (reverse vertical scroll)',
        ),
        _buildAxisDirectionCard(
          AxisDirection.right,
          GrowthDirection.forward,
          'right + forward → right (normal horizontal scroll)',
        ),
        _buildAxisDirectionCard(
          AxisDirection.right,
          GrowthDirection.reverse,
          'right + reverse → left (reverse horizontal scroll)',
        ),
        _buildAxisDirectionCard(
          AxisDirection.up,
          GrowthDirection.forward,
          'up + forward → up (scroll from bottom)',
        ),
        _buildAxisDirectionCard(
          AxisDirection.up,
          GrowthDirection.reverse,
          'up + reverse → down (flipped)',
        ),
        _buildAxisDirectionCard(
          AxisDirection.left,
          GrowthDirection.forward,
          'left + forward → left (RTL horizontal)',
        ),
        _buildAxisDirectionCard(
          AxisDirection.left,
          GrowthDirection.reverse,
          'left + reverse → right (flipped)',
        ),

        const SizedBox(height: 24),

        // ─── Section 5: ScrollDirection Mapping ─────────────────────
        _buildSectionHeader('ScrollDirection Interaction', Icons.swipe),

        Text(
          'applyGrowthDirectionToScrollDirection maps user scroll gestures '
          'based on growth direction:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        _buildComparisonPanel(
          'Forward scroll gesture',
          'forward → forward\nKeeps direction',
          'forward → reverse\nFlips direction',
        ),
        _buildComparisonPanel(
          'Reverse scroll gesture',
          'reverse → reverse\nKeeps direction',
          'reverse → forward\nFlips direction',
        ),
        _buildComparisonPanel(
          'Idle state',
          'idle → idle\nNo change',
          'idle → idle\nNo change',
        ),

        const SizedBox(height: 24),

        // ─── Section 6: CustomScrollView Example ────────────────────
        _buildSectionHeader('CustomScrollView Usage', Icons.view_list),

        Text(
          'CustomScrollView uses a center sliver key to control growth. '
          'Slivers before the center grow in reverse, slivers at/after '
          'the center grow forward:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        Container(
          height: 320,
          decoration: BoxDecoration(
            border: Border.all(color: _kCyan300, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            center: ValueKey('center-sliver'),
            slivers: [
              // Reverse growth slivers (above center)
              SliverList(
                key: const ValueKey('reverse-list'),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _kAmber300.withAlpha(80 + index * 30),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _kAmber400),
                    ),
                    child: Center(
                      child: Text(
                        '↑ Reverse item $index',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _kAmber600,
                        ),
                      ),
                    ),
                  ),
                  childCount: 5,
                ),
              ),
              // Center sliver – growth starts here
              SliverToBoxAdapter(
                key: const ValueKey('center-sliver'),
                child: Container(
                  height: 56,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [_kCyan600, _kCyan400]),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _kCyan600.withAlpha(60),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '★ CENTER SLIVER ★',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              // Forward growth slivers (below center)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _kCyan100.withAlpha(100 + index * 25),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _kCyan300),
                    ),
                    child: Center(
                      child: Text(
                        '↓ Forward item $index',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _kCyan700,
                        ),
                      ),
                    ),
                  ),
                  childCount: 8,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCyan50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kCyan200),
          ),
          child: Text(
            '↑ Scroll up to see reverse-growth items above the center. '
            'The center sliver is the dividing line between forward '
            'and reverse growth directions.',
            style: TextStyle(fontSize: 12, color: _kCyan800, height: 1.4),
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 7: Practical Examples ──────────────────────────
        _buildSectionHeader('Practical Examples', Icons.code),

        _buildPracticalExample(
          'Bidirectional Chat Scroll',
          'CustomScrollView(\n'
              '  center: _centerKey,\n'
              '  slivers: [\n'
              '    // Older messages (reverse)\n'
              '    SliverList(...),\n'
              '    // Newest message (center)\n'
              '    SliverToBoxAdapter(\n'
              '      key: _centerKey, ...),\n'
              '    // Future messages (forward)\n'
              '    SliverList(...),\n'
              '  ],\n'
              ')',
          'Chat apps use center key to anchor the newest message '
              'and load older messages in reverse growth direction.',
          Icons.chat,
        ),
        _buildPracticalExample(
          'Timeline with Past & Future',
          'CustomScrollView(\n'
              '  center: _todayKey,\n'
              '  slivers: [\n'
              '    SliverList(  // Past dates\n'
              '      // GrowthDirection.reverse\n'
              '    ),\n'
              '    SliverToBoxAdapter(\n'
              '      key: _todayKey,  // Today\n'
              '    ),\n'
              '    SliverList(  // Future dates\n'
              '      // GrowthDirection.forward\n'
              '    ),\n'
              '  ],\n'
              ')',
          'Timeline views center on "today" with past events '
              'growing in reverse and future events growing forward.',
          Icons.calendar_today,
        ),
        _buildPracticalExample(
          'Reverse Scroll (Bottom to Top)',
          'CustomScrollView(\n'
              '  reverse: true,\n'
              '  // This flips the GrowthDirection\n'
              '  // from forward to reverse\n'
              '  slivers: [\n'
              '    SliverList(...),\n'
              '  ],\n'
              ')',
          'Setting reverse: true on a scroll view internally '
              'reverses the growth direction so new items appear at the bottom.',
          Icons.vertical_align_bottom,
        ),

        const SizedBox(height: 24),

        // ─── Section 8: Key Relationships ───────────────────────────
        _buildSectionHeader('Key Relationships', Icons.hub),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kCyan200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GrowthDirection connects to:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _kSlate800,
                ),
              ),
              const SizedBox(height: 12),
              ...[
                (
                  'SliverConstraints',
                  'growthDirection property',
                  Icons.straighten,
                ),
                (
                  'Viewport',
                  'Assigns forward/reverse per sliver',
                  Icons.view_carousel,
                ),
                (
                  'CustomScrollView',
                  'center key divides growth',
                  Icons.view_list,
                ),
                (
                  'AxisDirection',
                  'Combined to determine visual direction',
                  Icons.explore,
                ),
                (
                  'ScrollDirection',
                  'Maps user gesture to logical scroll',
                  Icons.swipe,
                ),
                (
                  'RenderSliver',
                  'Uses growth in hit testing & painting',
                  Icons.layers,
                ),
              ].map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _kCyan100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(item.$3, color: _kCyan600, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${item.$1}: ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: _kSlate800,
                                ),
                              ),
                              TextSpan(
                                text: item.$2,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _kSlate600,
                                ),
                              ),
                            ],
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

        const SizedBox(height: 24),

        // ─── Section 9: Quick Reference ─────────────────────────────
        _buildSectionHeader('Quick Reference', Icons.bookmark),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kCyan50, _kSlate50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kCyan200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[
                (
                  'forward',
                  'Items grow 0 → +∞ (standard top-to-bottom)',
                  _kCyan600,
                ),
                (
                  'reverse',
                  'Items grow 0 → -∞ (bottom-to-top or right-to-left)',
                  _kAmber600,
                ),
              ].map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: item.$3,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${item.$1}: ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: _kSlate800,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              TextSpan(
                                text: item.$2,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _kSlate600,
                                ),
                              ),
                            ],
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

        const SizedBox(height: 32),
      ],
    ),
  );
}
