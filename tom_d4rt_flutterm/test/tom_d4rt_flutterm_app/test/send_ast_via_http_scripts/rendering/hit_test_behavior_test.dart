// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive demo for HitTestBehavior from rendering
//
// HitTestBehavior is an enum that controls how a render object participates
// in hit testing (determining which widget receives pointer events like taps).
//
// Values:
//   - deferToChild: Only receives events if a child is hit
//   - opaque: Receives events even when hit within transparent areas
//   - translucent: Both this target and targets below receive events
//
// This demo shows:
//   1. Visual comparison of all three behaviors
//   2. How each behavior affects tap detection
//   3. Overlapping widget scenarios
//   4. GestureDetector behavior property usage
//   5. Stack-based hit testing examples
//   6. Practical use cases for each behavior
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS – Pink / Teal theme
// ═══════════════════════════════════════════════════════════════════════════

const _kPink50 = Color(0xFFFDF2F8);
const _kPink200 = Color(0xFFFBCFE8);
const _kPink400 = Color(0xFFF472B6);
const _kPink500 = Color(0xFFEC4899);
const _kPink600 = Color(0xFFDB2777);
const _kPink700 = Color(0xFFBE185D);
const _kPink800 = Color(0xFF9D174D);

const _kTeal400 = Color(0xFF2DD4BF);
const _kTeal500 = Color(0xFF14B8A6);
const _kTeal600 = Color(0xFF0D9488);

const _kSlate50 = Color(0xFFF8FAFC);
const _kSlate100 = Color(0xFFF1F5F9);
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
        colors: [_kPink800, _kPink600],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kPink800.withAlpha(80),
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

/// Builds a behavior card showing enum value details
Widget _buildBehaviorCard(
  HitTestBehavior behavior,
  String description,
  IconData icon,
  Color accentColor,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(8),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: accentColor.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HitTestBehavior.${behavior.name}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kSlate800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'index: ${behavior.index}',
                style: TextStyle(
                  fontSize: 11,
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a visual hit test zone diagram
Widget _buildHitTestZone(
  String label,
  HitTestBehavior behavior,
  Color zoneColor,
) {
  final String hitBadge;
  final Color badgeColor;
  switch (behavior) {
    case HitTestBehavior.deferToChild:
      hitBadge = 'Child only';
      badgeColor = _kTeal500;
    case HitTestBehavior.opaque:
      hitBadge = 'Whole area';
      badgeColor = _kPink500;
    case HitTestBehavior.translucent:
      hitBadge = 'Pass-through';
      badgeColor = Color(0xFF8B5CF6);
  }

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kSlate50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: zoneColor.withAlpha(80)),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _kSlate800,
          ),
        ),
        const SizedBox(height: 8),
        // Visual zone
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: zoneColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: zoneColor.withAlpha(60), width: 2),
          ),
          child: Stack(
            children: [
              // Tap region labels
              Positioned(
                top: 8,
                left: 8,
                child: Text(
                  'Parent area',
                  style: TextStyle(fontSize: 10, color: _kSlate600),
                ),
              ),
              // Child widget in center
              Center(
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: zoneColor.withAlpha(60),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: zoneColor),
                  ),
                  child: Center(
                    child: Text(
                      'Child',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: zoneColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Hit indicators
              if (behavior == HitTestBehavior.opaque ||
                  behavior == HitTestBehavior.translucent)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, size: 14, color: zoneColor),
                      Text(
                        ' hits parent',
                        style: TextStyle(fontSize: 9, color: zoneColor),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            hitBadge,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: badgeColor,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a tap layer for stack visualization
Widget _buildTapLayer(String label, Color color, bool isHittable) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    margin: const EdgeInsets.only(bottom: 4),
    decoration: BoxDecoration(
      color: isHittable ? color.withAlpha(40) : color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isHittable ? color : color.withAlpha(40),
        width: isHittable ? 2 : 1,
      ),
    ),
    child: Row(
      children: [
        Icon(
          isHittable ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: isHittable ? color : _kSlate600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isHittable ? FontWeight.bold : FontWeight.normal,
              color: isHittable ? color : _kSlate600,
            ),
          ),
        ),
        Text(
          isHittable ? 'RECEIVES TAP' : 'ignored',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isHittable ? color : _kSlate600,
          ),
        ),
      ],
    ),
  );
}

/// Builds a code example card
Widget _buildCodeExample(
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
      border: Border.all(color: _kPink200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPink50,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Row(
            children: [
              Icon(icon, color: _kPink700, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kPink800,
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

/// Builds a comparison table row
Widget _buildComparisonRow(
  String scenario,
  String deferToChild,
  String opaque,
  String translucent,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kSlate100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              scenario,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _kSlate800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kTeal500.withAlpha(15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              deferToChild,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _kTeal600),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kPink500.withAlpha(15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              opaque,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _kPink600),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF8B5CF6).withAlpha(15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              translucent,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Color(0xFF7C3AED)),
            ),
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
  print('HitTestBehavior deep demo executing');

  // === Data exploration ===
  print('HitTestBehavior values:');
  for (final v in HitTestBehavior.values) {
    print('  ${v.name} (index=${v.index})');
  }

  print('HitTestBehavior deep demo completed');

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
              colors: [_kPink800, _kPink500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kPink800.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.touch_app, color: Colors.white, size: 48),
              const SizedBox(height: 12),
              const Text(
                'HitTestBehavior',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Controls how render objects participate '
                'in hit testing for pointer events',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 1: Three Behaviors ─────────────────────────────
        _buildSectionHeader('The Three Behaviors', Icons.category),

        _buildBehaviorCard(
          HitTestBehavior.deferToChild,
          'Only receives events if one of its children is hit. '
          'Tapping empty space around children does nothing. '
          'This is the default for most widgets.',
          Icons.child_care,
          _kTeal500,
        ),
        _buildBehaviorCard(
          HitTestBehavior.opaque,
          'Receives events on its entire area, even where no child exists. '
          'Prevents targets below from receiving events. '
          'Acts as a solid barrier to hit testing.',
          Icons.block,
          _kPink500,
        ),
        _buildBehaviorCard(
          HitTestBehavior.translucent,
          'Receives events on its entire area AND allows targets below '
          'to also receive the same events. Both the parent and '
          'widgets underneath get hit.',
          Icons.layers,
          Color(0xFF8B5CF6),
        ),

        const SizedBox(height: 24),

        // ─── Section 2: Visual Hit Zones ────────────────────────────
        _buildSectionHeader('Visual Hit Zones', Icons.grid_on),

        Text(
          'Each zone shows where taps are detected (parent area vs child):',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildHitTestZone(
                'deferToChild',
                HitTestBehavior.deferToChild,
                _kTeal500,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildHitTestZone(
                'opaque',
                HitTestBehavior.opaque,
                _kPink500,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildHitTestZone(
                'translucent',
                HitTestBehavior.translucent,
                Color(0xFF8B5CF6),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // ─── Section 3: Stack Hit Testing ───────────────────────────
        _buildSectionHeader('Stack Hit Testing', Icons.layers),

        Text(
          'When widgets overlap in a Stack, HitTestBehavior determines '
          'which layers receive tap events:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        // deferToChild scenario
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kTeal400),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'deferToChild — Tap on empty space',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kTeal600,
                ),
              ),
              const SizedBox(height: 8),
              _buildTapLayer('Top Layer (GestureDetector)', _kTeal500, false),
              _buildTapLayer('Middle Layer (Container)', _kTeal400, false),
              _buildTapLayer('Bottom Layer (InkWell)', _kTeal600, true),
              const SizedBox(height: 4),
              Text(
                'Only bottom layer hit because top has no child at tap point',
                style: TextStyle(fontSize: 11, color: _kSlate600),
              ),
            ],
          ),
        ),

        // opaque scenario
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPink400),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'opaque — Tap anywhere on layer',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kPink600,
                ),
              ),
              const SizedBox(height: 8),
              _buildTapLayer('Top Layer (behavior: opaque)', _kPink500, true),
              _buildTapLayer('Middle Layer (Container)', _kPink400, false),
              _buildTapLayer('Bottom Layer (InkWell)', _kPink600, false),
              const SizedBox(height: 4),
              Text(
                'Top layer captures all events; layers below never see them',
                style: TextStyle(fontSize: 11, color: _kSlate600),
              ),
            ],
          ),
        ),

        // translucent scenario
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFA78BFA)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'translucent — Tap passes through',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C3AED),
                ),
              ),
              const SizedBox(height: 8),
              _buildTapLayer(
                'Top Layer (behavior: translucent)',
                Color(0xFF8B5CF6),
                true,
              ),
              _buildTapLayer(
                'Middle Layer (Container)',
                Color(0xFFA78BFA),
                true,
              ),
              _buildTapLayer('Bottom Layer (InkWell)', Color(0xFF7C3AED), true),
              const SizedBox(height: 4),
              Text(
                'All layers receive the event; nothing is blocked',
                style: TextStyle(fontSize: 11, color: _kSlate600),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 4: Comparison Table ────────────────────────────
        _buildSectionHeader('Behavior Comparison', Icons.table_chart),

        // Header row
        _buildComparisonRow(
          'Scenario',
          'deferTo\nChild',
          'opaque',
          'trans\nlucent',
        ),
        _buildComparisonRow('Tap on child', '✅ Hit', '✅ Hit', '✅ Hit'),
        _buildComparisonRow('Tap empty area', '❌ Miss', '✅ Hit', '✅ Hit'),
        _buildComparisonRow('Below widgets', 'Can hit', 'Blocked', 'Can hit'),
        _buildComparisonRow('Default for', 'Container', 'InkWell', '—'),
        _buildComparisonRow(
          'Use case',
          'Precise\ntargets',
          'Full-area\nbuttons',
          'Overlay\ngestures',
        ),

        const SizedBox(height: 24),

        // ─── Section 5: GestureDetector Usage ───────────────────────
        _buildSectionHeader('GestureDetector Usage', Icons.code),

        _buildCodeExample(
          'Default (deferToChild)',
          'GestureDetector(\n'
              '  // behavior defaults to\n'
              '  // HitTestBehavior.deferToChild\n'
              '  onTap: () => print("tapped"),\n'
              '  child: Container(\n'
              '    width: 100, height: 100,\n'
              '    color: Colors.blue,\n'
              '  ),\n'
              ')',
          'Only the blue container area responds to taps. '
              'Empty space around it is ignored.',
          Icons.touch_app,
        ),
        _buildCodeExample(
          'Opaque — Full area taps',
          'GestureDetector(\n'
              '  behavior:\n'
              '    HitTestBehavior.opaque,\n'
              '  onTap: () => print("tapped"),\n'
              '  child: Container(\n'
              '    padding: EdgeInsets.all(40),\n'
              '    child: Text("Button"),\n'
              '  ),\n'
              ')',
          'The entire padded area receives taps, not just the Text. '
              'Useful for large touch targets with small visual elements.',
          Icons.crop_square,
        ),
        _buildCodeExample(
          'Translucent — Overlay gesture',
          'Stack(\n'
              '  children: [\n'
              '    ListView(...),\n'
              '    GestureDetector(\n'
              '      behavior:\n'
              '        HitTestBehavior.translucent,\n'
              '      onVerticalDragUpdate: ...,\n'
              '      // ListView also scrolls!\n'
              '    ),\n'
              '  ],\n'
              ')',
          'Both the overlay GestureDetector and the ListView below receive '
              'the drag events. Perfect for custom scroll indicators.',
          Icons.swipe_vertical,
        ),

        const SizedBox(height: 24),

        // ─── Section 6: Practical Scenarios ─────────────────────────
        _buildSectionHeader('Practical Scenarios', Icons.work),

        ...[
          (
            'Dismissible Overlays',
            'Use opaque on a full-screen GestureDetector behind a dialog '
                'to capture taps outside and dismiss it.',
            Icons.close_fullscreen,
            _kPink600,
          ),
          (
            'Custom Scroll Physics',
            'Use translucent on a gesture layer to track scroll velocity '
                'while still allowing the scroll view to function.',
            Icons.speed,
            _kTeal600,
          ),
          (
            'Precise Hit Targets',
            'Use deferToChild for navigation bars where only the actual '
                'icon/label should respond, not the surrounding padding.',
            Icons.gps_fixed,
            Color(0xFF7C3AED),
          ),
          (
            'Invisible Touch Areas',
            'Use opaque on transparent containers to create invisible '
                'touch zones for edge-swipe gestures.',
            Icons.visibility_off,
            _kPink500,
          ),
          (
            'Analytics Tracking Layer',
            'Use translucent on a full-screen overlay to record all '
                'touch positions without blocking any UI interactions.',
            Icons.analytics,
            _kTeal500,
          ),
        ].map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: item.$4.withAlpha(10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: item.$4.withAlpha(50)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: item.$4.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(item.$3, color: item.$4, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$1,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _kSlate800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.$2,
                        style: TextStyle(
                          fontSize: 12,
                          color: _kSlate600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 7: Quick Reference ─────────────────────────────
        _buildSectionHeader('Quick Reference', Icons.bookmark),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kPink50, _kSlate50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPink200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[
                (
                  'deferToChild',
                  'Only child receives events (default)',
                  _kTeal600,
                ),
                ('opaque', 'Entire area receives; blocks below', _kPink600),
                (
                  'translucent',
                  'Entire area receives; passes to below',
                  Color(0xFF7C3AED),
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
