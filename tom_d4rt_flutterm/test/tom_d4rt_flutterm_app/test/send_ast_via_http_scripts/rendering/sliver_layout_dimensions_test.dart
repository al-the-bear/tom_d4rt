// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SLIVER LAYOUT DIMENSIONS — Deep Demo
// ============================================================================
//
// SliverLayoutDimensions is a compact data class that bundles the four
// key metrics a sliver receives during layout:
//
//   • scrollOffset          – how far the sliver has been scrolled past its
//                              start edge (in logical pixels).
//   • precedingScrollExtent – total scroll extent of all slivers before this
//                              one.
//   • viewportMainAxisExtent– the viewport's visible size along the scroll
//                              axis.
//   • crossAxisExtent       – the viewport's size along the perpendicular
//                              axis.
//
// This class exists primarily for SliverLayoutBuilder: a sliver that calls
// a builder callback whenever layout changes, passing a
// SliverLayoutDimensions so builders can make layout decisions (e.g.
// choosing how many grid columns to use) without touching RenderSliver.
//
// SliverLayoutDimensions implements operator== and hashCode, enabling
// SliverLayoutBuilder to skip rebuilds when dimensions haven't changed.
//
// Color theme : Amber Gold (#FF8F00) / Cream (#FFF8E1)
// Helper prefix: _ld
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _ldGold = Color(0xFFFF8F00);
const Color _ldCream = Color(0xFFFFF8E1);
const Color _ldDarkAmber = Color(0xFFE65100);
const Color _ldPaleGold = Color(0xFFFFF3E0);
const Color _ldCharcoal = Color(0xFF263238);
const Color _ldIndigo = Color(0xFF283593);
const Color _ldTeal = Color(0xFF00695C);
const Color _ldCrimson = Color(0xFFC62828);
const Color _ldPurple = Color(0xFF6A1B9A);
const Color _ldGreen = Color(0xFF2E7D32);
const Color _ldBrown = Color(0xFF4E342E);
const Color _ldSlate = Color(0xFF546E7A);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _ldSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [_ldGold, _ldDarkAmber]),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(subtitle,
                style:
                    const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
          ),
      ],
    ),
  );
}

Widget _ldExplain(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    color: _ldPaleGold,
    child: Text(text,
        style: const TextStyle(
            fontSize: 13, height: 1.55, color: _ldCharcoal)),
  );
}

Widget _ldPill(String label, Color bg, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(12)),
    child: Text(label,
        style: TextStyle(
            color: textColor, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _ldCard(String title, Widget child,
    {Color borderColor = _ldGold}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: borderColor, width: 1.4),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: borderColor.withValues(alpha: 0.08),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Text(title,
              style: TextStyle(
                  color: borderColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
          child: child,
        ),
      ],
    ),
  );
}

Widget _ldCode(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFD4D4D4),
            height: 1.5)),
  );
}

Widget _ldKv(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(key,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _ldCharcoal)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12, color: valueColor ?? _ldSlate)),
        ),
      ],
    ),
  );
}

Widget _ldDivider() {
  return Container(
    height: 1,
    color: _ldCream,
    margin: const EdgeInsets.symmetric(vertical: 6),
  );
}

Widget _ldInlineText(String text) {
  return Text(text,
      style: const TextStyle(fontSize: 12, height: 1.5, color: _ldCharcoal));
}

// ============================================================================
// Build — main entry point
// ============================================================================

dynamic build(BuildContext context) {
  print('=== SliverLayoutDimensions Deep Demo START ===');

  final Widget demo = Container(
    color: _ldCream,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Title banner
          _buildTitleBanner(),

          // 2. What is SliverLayoutDimensions
          _ldSectionHeader('1  What Is SliverLayoutDimensions?',
              subtitle: 'A snapshot of four key sliver layout metrics'),
          _buildWhatIs(),

          // 3. The four properties
          _ldSectionHeader('2  The Four Properties',
              subtitle: 'Visual breakdown of each dimension'),
          _buildFourProperties(),

          // 4. Relationship to SliverConstraints
          _ldSectionHeader('3  Relationship to SliverConstraints',
              subtitle: 'What SliverLayoutDimensions extracts and why'),
          _buildConstraintsRelation(),

          // 5. scrollOffset visual
          _ldSectionHeader('4  scrollOffset in Action',
              subtitle: 'How scrollOffset changes as the user scrolls'),
          _buildScrollOffset(),

          // 6. precedingScrollExtent
          _ldSectionHeader('5  precedingScrollExtent',
              subtitle: 'Cumulative extent of all preceding slivers'),
          _buildPrecedingExtent(),

          // 7. viewportMainAxisExtent
          _ldSectionHeader('6  viewportMainAxisExtent',
              subtitle: 'The visible viewport size along the scroll axis'),
          _buildViewportExtent(),

          // 8. crossAxisExtent
          _ldSectionHeader('7  crossAxisExtent',
              subtitle: 'The viewport width perpendicular to scrolling'),
          _buildCrossAxisExtent(),

          // 9. SliverLayoutBuilder
          _ldSectionHeader('8  SliverLayoutBuilder Integration',
              subtitle: 'The primary consumer of SliverLayoutDimensions'),
          _buildLayoutBuilder(),

          // 10. Equality & caching
          _ldSectionHeader('9  Equality & Caching',
              subtitle: 'How == enables efficient rebuild skipping'),
          _buildEquality(),

          // 11. Practical examples
          _ldSectionHeader('10  Practical Examples',
              subtitle: 'Adaptive grid and parallax header'),
          _buildPracticalExamples(),

          // 12. Summary
          _buildSummary(),

          const SizedBox(height: 30),
        ],
      ),
    ),
  );

  print('=== SliverLayoutDimensions Deep Demo END ===');
  return demo;
}

// ============================================================================
// Section Builders
// ============================================================================

// -------------- 1. Title Banner ------------------------------------------

Widget _buildTitleBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_ldGold, Color(0xFFF57F17)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.straighten,
                  color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Text('SliverLayoutDimensions',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'rendering library  •  immutable data class',
            style: TextStyle(color: Color(0xDDFFFFFF), fontSize: 13),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Bundles the four essential sliver layout metrics — '
          'scrollOffset, precedingScrollExtent, viewportMainAxisExtent, '
          'and crossAxisExtent — into a single value-equality object used '
          'by SliverLayoutBuilder to make responsive layout decisions.',
          style: TextStyle(
              color: Color(0xCCFFFFFF), fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );
}

// -------------- 2. What Is -----------------------------------------------

Widget _buildWhatIs() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'When a SliverLayoutBuilder is laid out, it receives '
        'SliverConstraints from the viewport.  Rather than exposing the '
        'full constraints object to the builder callback (which would '
        'include internal details like cacheOrigin and '
        'remainingCacheExtent), the framework extracts four user-facing '
        'metrics into a SliverLayoutDimensions.\n\n'
        'This data class is:\n'
        '  • Immutable: all fields are final\n'
        '  • Value-equal: two instances with the same values are ==\n'
        '  • Lightweight: constructor takes all four values positionally\n\n'
        'SliverLayoutDimensions does not come from constraints directly '
        'at the Dart API level — it is created by _RenderSliverLayoutBuilder '
        'inside the performLayout method.',
      ),
      _ldCard('Class Definition', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldKv('Package', 'flutter/rendering.dart'),
          _ldKv('Type', 'Immutable data class'),
          _ldKv('Implements', 'operator==, hashCode'),
          _ldDivider(),
          _ldKv('scrollOffset', 'double'),
          _ldKv('precedingScrollExtent', 'double'),
          _ldKv('viewportMainAxisExtent', 'double'),
          _ldKv('crossAxisExtent', 'double'),
        ],
      )),
      _ldCode(
        'class SliverLayoutDimensions {\n'
        '  const SliverLayoutDimensions({\n'
        '    required this.scrollOffset,\n'
        '    required this.precedingScrollExtent,\n'
        '    required this.viewportMainAxisExtent,\n'
        '    required this.crossAxisExtent,\n'
        '  });\n\n'
        '  final double scrollOffset;\n'
        '  final double precedingScrollExtent;\n'
        '  final double viewportMainAxisExtent;\n'
        '  final double crossAxisExtent;\n\n'
        '  @override\n'
        '  bool operator ==(Object other) {\n'
        '    if (identical(this, other)) return true;\n'
        '    return other is SliverLayoutDimensions\n'
        '        && other.scrollOffset == scrollOffset\n'
        '        && other.precedingScrollExtent == precedingScrollExtent\n'
        '        && other.viewportMainAxisExtent == viewportMainAxisExtent\n'
        '        && other.crossAxisExtent == crossAxisExtent;\n'
        '  }\n\n'
        '  @override\n'
        '  int get hashCode => Object.hash(\n'
        '    scrollOffset, precedingScrollExtent,\n'
        '    viewportMainAxisExtent, crossAxisExtent,\n'
        '  );\n'
        '}',
      ),
    ],
  );
}

// -------------- 3. The Four Properties -----------------------------------

Widget _buildFourProperties() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'Each property represents a specific measurement from the sliver '
        'layout pass.  Together they tell you everything needed to make '
        'responsive decisions: how much has been scrolled, how much space '
        'came before, and how big the visible area is.',
      ),
      _ldCard('Property 1: scrollOffset', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldPropertyVisual(
            'scrollOffset',
            'Distance this sliver has been scrolled past its leading edge',
            Icons.swap_vert,
            _ldGold,
          ),
          _ldDivider(),
          _ldKv('Range', '0.0 .. total sliver extent'),
          _ldKv('At start', '0.0 (sliver leading edge visible)'),
          _ldKv('While scrolling', 'Increases as sliver scrolls off screen'),
          _ldKv('Fully scrolled past', 'Equal to full scroll extent'),
        ],
      )),
      _ldCard('Property 2: precedingScrollExtent', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldPropertyVisual(
            'precedingScrollExtent',
            'Sum of all scroll extents of slivers before this one',
            Icons.vertical_align_top,
            _ldIndigo,
          ),
          _ldDivider(),
          _ldKv('First sliver', '0.0'),
          _ldKv('Second sliver', 'First sliver scroll extent'),
          _ldKv('Third sliver', 'First + second sliver scroll extents'),
          _ldKv('Usage', 'Calculate absolute scroll position'),
        ],
      )),
      _ldCard('Property 3: viewportMainAxisExtent', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldPropertyVisual(
            'viewportMainAxisExtent',
            'Visible size of the viewport along the scroll axis',
            Icons.crop_free,
            _ldTeal,
          ),
          _ldDivider(),
          _ldKv('Vertical scroll', 'Viewport height'),
          _ldKv('Horizontal scroll', 'Viewport width'),
          _ldKv('Constant?', 'Usually — unless viewport resizes'),
          _ldKv('Usage', 'Page-based layout, reveal animations'),
        ],
      )),
      _ldCard('Property 4: crossAxisExtent', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldPropertyVisual(
            'crossAxisExtent',
            'Viewport size perpendicular to the scroll axis',
            Icons.width_normal,
            _ldCrimson,
          ),
          _ldDivider(),
          _ldKv('Vertical scroll', 'Viewport width'),
          _ldKv('Horizontal scroll', 'Viewport height'),
          _ldKv('Constant?', 'Usually — unless viewport resizes'),
          _ldKv('Usage', 'Adaptive column count, responsive grids'),
        ],
      )),
    ],
  );
}

Widget _ldPropertyVisual(
    String name, String description, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 22, color: color),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
            Text(description,
                style: const TextStyle(fontSize: 11, color: _ldSlate)),
          ],
        ),
      ),
    ],
  );
}

// -------------- 4. Constraints Relation ----------------------------------

Widget _buildConstraintsRelation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'SliverConstraints contains many fields — overlap, precedingScrollExtent, '
        'cacheOrigin, remainingCacheExtent, remainingPaintExtent, and more.  '
        'SliverLayoutDimensions extracts only the four that matter for '
        'high-level layout decisions.\n\n'
        'The extraction happens inside _RenderSliverLayoutBuilder.performLayout '
        'which reads the four values from constraints and constructs a '
        'SliverLayoutDimensions.',
      ),
      _ldCard('SliverConstraints → SliverLayoutDimensions', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldMappingRow('constraints.scrollOffset', 'scrollOffset',
              _ldGold, true),
          _ldMappingRow('constraints.precedingScrollExtent',
              'precedingScrollExtent', _ldIndigo, true),
          _ldMappingRow('constraints.viewportMainAxisExtent',
              'viewportMainAxisExtent', _ldTeal, true),
          _ldMappingRow('constraints.crossAxisExtent', 'crossAxisExtent',
              _ldCrimson, true),
          _ldDivider(),
          _ldMappingRow('constraints.axisDirection', '(not included)',
              _ldSlate, false),
          _ldMappingRow('constraints.growthDirection', '(not included)',
              _ldSlate, false),
          _ldMappingRow('constraints.cacheOrigin', '(not included)',
              _ldSlate, false),
          _ldMappingRow('constraints.remainingPaintExtent', '(not included)',
              _ldSlate, false),
          _ldMappingRow('constraints.remainingCacheExtent', '(not included)',
              _ldSlate, false),
          _ldMappingRow('constraints.overlap', '(not included)',
              _ldSlate, false),
        ],
      )),
      _ldCode(
        '// Inside _RenderSliverLayoutBuilder.performLayout():\n\n'
        'final SliverLayoutDimensions dimensions = SliverLayoutDimensions(\n'
        '  scrollOffset: constraints.scrollOffset,\n'
        '  precedingScrollExtent: constraints.precedingScrollExtent,\n'
        '  viewportMainAxisExtent: constraints.viewportMainAxisExtent,\n'
        '  crossAxisExtent: constraints.crossAxisExtent,\n'
        ');\n\n'
        '// If dimensions != _lastDimensions, call the builder again.\n'
        '// Otherwise, skip rebuild.',
      ),
    ],
  );
}

Widget _ldMappingRow(String from, String to, Color color, bool included) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: included ? color : _ldSlate.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(from,
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: included ? _ldCharcoal : _ldSlate)),
        ),
        Icon(
          included ? Icons.arrow_forward : Icons.close,
          size: 14,
          color: included ? color : _ldSlate.withValues(alpha: 0.4),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(to,
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: included ? color : _ldSlate,
                  fontWeight:
                      included ? FontWeight.bold : FontWeight.normal)),
        ),
      ],
    ),
  );
}

// -------------- 5. scrollOffset ------------------------------------------

Widget _buildScrollOffset() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'scrollOffset tells this sliver how far it has been scrolled past '
        'its leading edge.  When scrollOffset is 0, the sliver is flush '
        'with the top of the visible area (or just appearing).  As the '
        'user scrolls, scrollOffset increases.  For a 300px-tall sliver, '
        'scrollOffset ranges from 0 to 300.',
      ),
      _ldCard('scrollOffset Timeline', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldScrollState('Sliver just appears', 0, _ldGreen, 300),
          _ldScrollState('Scrolled a little', 50, _ldGold, 300),
          _ldScrollState('Half scrolled', 150, _ldDarkAmber, 300),
          _ldScrollState('Almost gone', 280, _ldCrimson, 300),
          _ldScrollState('Fully scrolled past', 300, _ldBrown, 300),
        ],
      )),
      // Visual: viewport with sliver sliding up
      _ldCard('Visual: Scrolling a 300px Sliver', Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldScrollViewport(0, 'offset = 0'),
          const SizedBox(width: 8),
          _ldScrollViewport(100, 'offset = 100'),
          const SizedBox(width: 8),
          _ldScrollViewport(200, 'offset = 200'),
          const SizedBox(width: 8),
          _ldScrollViewport(300, 'offset = 300'),
        ],
      )),
    ],
  );
}

Widget _ldScrollState(
    String label, double offset, Color color, double total) {
  final fraction = (offset / total).clamp(0.0, 1.0);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _ldPill('${offset.toInt()}', color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label,
                  style:
                      const TextStyle(fontSize: 11, color: _ldCharcoal)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: _ldCream,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fraction,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _ldScrollViewport(double offset, String label) {
  // Display a small viewport (120px tall) showing a 300px sliver
  // shifted by offset.
  final sliverTop = -offset * 0.4; // scale factor for display
  return Expanded(
    child: Column(
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: _ldSlate)),
        const SizedBox(height: 4),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: _ldCharcoal, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: sliverTop,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _ldGold.withValues(alpha: 0.3),
                        _ldDarkAmber.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('SLIVER',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _ldDarkAmber)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// -------------- 6. precedingScrollExtent ----------------------------------

Widget _buildPrecedingExtent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'precedingScrollExtent is the sum of the scroll extents of all '
        'slivers that came before the current one in the viewport.  It is '
        'useful for calculating the absolute scroll position of content '
        'in this sliver within the overall scroll view.\n\n'
        'For the first sliver it is 0.  For the second sliver it equals '
        'the first sliver scroll extent.  And so on.',
      ),
      _ldCard('Cumulative Extent — 4 Slivers', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldPrecedingSliverRow('Sliver A', 200, 0, _ldGold),
          _ldPrecedingSliverRow('Sliver B', 150, 200, _ldIndigo),
          _ldPrecedingSliverRow('Sliver C', 300, 350, _ldTeal),
          _ldPrecedingSliverRow('Sliver D', 250, 650, _ldCrimson),
          _ldDivider(),
          _ldKv('Total scroll extent', '200 + 150 + 300 + 250 = 900'),
        ],
      )),
      // Visual: stacked bar showing cumulative extents
      _ldCard('Stacked Extent Diagram', Column(
        children: [
          _ldStackedBar([
            _BarSegment('A', 200, _ldGold),
            _BarSegment('B', 150, _ldIndigo),
            _BarSegment('C', 300, _ldTeal),
            _BarSegment('D', 250, _ldCrimson),
          ]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('0',
                  style: TextStyle(fontSize: 9, color: _ldSlate)),
              const Text('200',
                  style: TextStyle(fontSize: 9, color: _ldSlate)),
              const Text('350',
                  style: TextStyle(fontSize: 9, color: _ldSlate)),
              const Text('650',
                  style: TextStyle(fontSize: 9, color: _ldSlate)),
              const Text('900',
                  style: TextStyle(fontSize: 9, color: _ldSlate)),
            ],
          ),
          const SizedBox(height: 4),
          _ldInlineText(
            'Each tick mark shows the precedingScrollExtent for the '
            'sliver starting at that position.',
          ),
        ],
      )),
      _ldCode(
        '// When Sliver C is laid out:\n'
        '// constraints.precedingScrollExtent = 200 + 150 = 350\n'
        '// dimensions.precedingScrollExtent = 350\n'
        '//\n'
        '// Absolute position of item at localOffset 40 inside C:\n'
        '// absolutePos = 350 + 40 = 390',
      ),
    ],
  );
}

Widget _ldPrecedingSliverRow(
    String name, double extent, double preceding, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(4)),
          alignment: Alignment.center,
          child: Text(name.split(' ').last,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '$name: extent=$extent, precedingScrollExtent=$preceding',
            style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _ldCharcoal),
          ),
        ),
      ],
    ),
  );
}

class _BarSegment {
  final String label;
  final double value;
  final Color color;
  const _BarSegment(this.label, this.value, this.color);
}

Widget _ldStackedBar(List<_BarSegment> segments) {
  final total = segments.fold<double>(0, (sum, s) => sum + s.value);
  return Container(
    height: 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _ldCharcoal.withValues(alpha: 0.2)),
    ),
    clipBehavior: Clip.hardEdge,
    child: Row(
      children: segments.map((s) {
        return Expanded(
          flex: (s.value / total * 100).round(),
          child: Container(
            color: s.color.withValues(alpha: 0.3),
            alignment: Alignment.center,
            child: Text('${s.label}\n${s.value.toInt()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: s.color)),
          ),
        );
      }).toList(),
    ),
  );
}

// -------------- 7. viewportMainAxisExtent ---------------------------------

Widget _buildViewportExtent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'viewportMainAxisExtent is the visible size of the viewport along '
        'the scroll axis.  For a vertical list in a 400px-tall container, '
        'viewportMainAxisExtent = 400.  This is the same as '
        'constraints.viewportMainAxisExtent.\n\n'
        'This value is essential for page-based animations, parallax '
        'effects, and deciding how many items to show at once.',
      ),
      _ldCard('Viewport Size Scenarios', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldViewportScenario('Full-screen phone', 812, 'Main axis = 812',
              _ldGold),
          _ldViewportScenario(
              'Tablet landscape', 1024, 'Main axis = 1024', _ldIndigo),
          _ldViewportScenario(
              'Nested 300px', 300, 'Main axis = 300', _ldTeal),
          _ldViewportScenario(
              'Bottom sheet half', 406, 'Main axis = 406', _ldCrimson),
        ],
      )),
      // Visual: two viewports of different sizes
      _ldCard('Same Content, Different Viewports', Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('Small viewport',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _ldSlate)),
                const SizedBox(height: 4),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: _ldCrimson, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      _ldViewportItem('Item 1', _ldGold, 20),
                      _ldViewportItem('Item 2', _ldIndigo, 20),
                      _ldViewportItem('Item 3', _ldTeal, 20),
                      _ldViewportItem('Item 4', _ldCrimson, 20),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('extent = 80',
                      style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'monospace',
                          color: _ldCrimson)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                const Text('Large viewport',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _ldSlate)),
                const SizedBox(height: 4),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(color: _ldGreen, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      _ldViewportItem('Item 1', _ldGold, 20),
                      _ldViewportItem('Item 2', _ldIndigo, 20),
                      _ldViewportItem('Item 3', _ldTeal, 20),
                      _ldViewportItem('Item 4', _ldCrimson, 20),
                      _ldViewportItem('Item 5', _ldPurple, 20),
                      _ldViewportItem('Item 6', _ldBrown, 20),
                      Container(height: 20, color: Colors.white),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('extent = 140',
                      style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'monospace',
                          color: _ldGreen)),
                ),
              ],
            ),
          ),
        ],
      )),
    ],
  );
}

Widget _ldViewportScenario(
    String label, double size, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 22,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Text('${size.toInt()}px',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text('$label — $detail',
              style:
                  const TextStyle(fontSize: 11, color: _ldCharcoal)),
        ),
      ],
    ),
  );
}

Widget _ldViewportItem(String label, Color color, double height) {
  return Container(
    height: height,
    width: double.infinity,
    color: color.withValues(alpha: 0.15),
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
            fontSize: 8, fontWeight: FontWeight.w600, color: color)),
  );
}

// -------------- 8. crossAxisExtent ----------------------------------------

Widget _buildCrossAxisExtent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'crossAxisExtent is the viewport size perpendicular to the scroll '
        'direction.  In a vertical list this is the width.  In a horizontal '
        'list this is the height.\n\n'
        'This value is key for responsive grid layouts: you can compute '
        'the number of columns as (crossAxisExtent / desiredColumnWidth).'
        'toInt(), adapting from 2 columns on phones to 4+ on tablets.',
      ),
      _ldCard('Responsive Column Calculation', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldColumnCalcRow(320, 150, _ldCrimson),
          _ldColumnCalcRow(480, 150, _ldGold),
          _ldColumnCalcRow(768, 150, _ldIndigo),
          _ldColumnCalcRow(1024, 150, _ldTeal),
        ],
      )),
      // Visual: grids with different column counts
      _ldCard('Width 320 → 2 columns', _ldMiniGrid(2, _ldCrimson)),
      _ldCard('Width 768 → 5 columns', _ldMiniGrid(5, _ldIndigo)),
      _ldCard('Width 1024 → 6 columns', _ldMiniGrid(6, _ldTeal)),
      _ldCode(
        '// Adaptive column count from crossAxisExtent:\n'
        'SliverLayoutBuilder(\n'
        '  builder: (context, constraints) {\n'
        '    // constraints gives us SliverConstraints,\n'
        '    // but the callback in SliverLayoutBuilder\n'
        '    // wraps them as SliverLayoutDimensions.\n'
        '    final cols = (constraints.crossAxisExtent / 150).floor();\n'
        '    return SliverGrid(\n'
        '      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(\n'
        '        crossAxisCount: cols.clamp(1, 8),\n'
        '      ),\n'
        '      delegate: SliverChildBuilderDelegate(...),\n'
        '    );\n'
        '  },\n'
        ')',
      ),
    ],
  );
}

Widget _ldColumnCalcRow(double width, double colWidth, Color color) {
  final cols = (width / colWidth).floor();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        _ldPill('${width.toInt()}px', color),
        const SizedBox(width: 8),
        const Text('÷ 150 = ',
            style: TextStyle(fontSize: 11, color: _ldSlate)),
        _ldPill('$cols cols', color.withValues(alpha: 0.7)),
      ],
    ),
  );
}

Widget _ldMiniGrid(int cols, Color color) {
  return SizedBox(
    height: 50,
    child: Row(
      children: List.generate(cols, (i) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1 + (i % 2) * 0.08),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: color.withValues(alpha: 0.3), width: 0.5),
            ),
            alignment: Alignment.center,
            child: Text('$i',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ),
        );
      }),
    ),
  );
}

// -------------- 9. SliverLayoutBuilder ------------------------------------

Widget _buildLayoutBuilder() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'SliverLayoutBuilder is the primary consumer of '
        'SliverLayoutDimensions.  It is a sliver that rebuilds its child '
        'when layout dimensions change, similar to how LayoutBuilder  '
        'works for boxes but for the sliver coordinate system.\n\n'
        'The builder callback receives both a BuildContext and '
        'SliverConstraints.  Internally, '
        '_RenderSliverLayoutBuilder constructs a SliverLayoutDimensions '
        'from the constraints and compares it to the previous one.  If '
        'equal, the rebuild is skipped.',
      ),
      _ldCard('SliverLayoutBuilder Widget', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldKv('Widget type', 'SliverLayoutBuilder'),
          _ldKv('Builder signature',
              'Widget Function(BuildContext, SliverConstraints)'),
          _ldKv('Internal render', '_RenderSliverLayoutBuilder'),
          _ldKv('Rebuild trigger', 'SliverLayoutDimensions != previous'),
          _ldKv('Skips rebuild?', 'Yes, when dimensions unchanged'),
        ],
      )),
      _ldCode(
        'SliverLayoutBuilder(\n'
        '  builder: (BuildContext context, SliverConstraints constraints) {\n'
        '    // The render object internally creates:\n'
        '    // SliverLayoutDimensions(\n'
        '    //   scrollOffset: constraints.scrollOffset,\n'
        '    //   precedingScrollExtent: constraints.precedingScrollExtent,\n'
        '    //   viewportMainAxisExtent: constraints.viewportMainAxisExtent,\n'
        '    //   crossAxisExtent: constraints.crossAxisExtent,\n'
        '    // )\n'
        '    //\n'
        '    // And only calls this builder if dimensions changed.\n'
        '\n'
        '    if (constraints.crossAxisExtent > 600) {\n'
        '      return multiColumnSliver();\n'
        '    }\n'
        '    return singleColumnSliver();\n'
        '  },\n'
        ')',
      ),
      _ldCard('Lifecycle', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldLifecycleStep(1, 'Viewport lays out SliverLayoutBuilder', _ldGold),
          _ldLifecycleStep(2, 'RenderObject creates SliverLayoutDimensions',
              _ldIndigo),
          _ldLifecycleStep(3, 'Compares with previous dimensions', _ldTeal),
          _ldLifecycleStep(4, 'If !=: calls builder, gets new child widget',
              _ldCrimson),
          _ldLifecycleStep(5, 'If ==: skips builder, reuses previous child',
              _ldGreen),
          _ldLifecycleStep(6, 'Lays out child sliver with same constraints',
              _ldPurple),
        ],
      )),
    ],
  );
}

Widget _ldLifecycleStep(int number, String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text('$number',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(text,
                style: const TextStyle(fontSize: 12, color: _ldCharcoal)),
          ),
        ),
      ],
    ),
  );
}

// -------------- 10. Equality & Caching -----------------------------------

Widget _buildEquality() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'SliverLayoutDimensions overrides operator== and hashCode using '
        'all four fields.  Two instances are equal if and only if all four '
        'doubles match exactly.  This enables _RenderSliverLayoutBuilder '
        'to skip expensive builder rebuilds when the layout metrics have '
        'not changed.\n\n'
        'Note: Double equality means that even tiny floating-point '
        'differences will cause a rebuild.  In practice this is fine '
        'because the viewport produces the same values each frame unless '
        'the scroll position or viewport size actually changes.',
      ),
      _ldCard('Equality Examples', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldEqualityExample(
            'Same dimensions',
            '(0, 200, 600, 400) == (0, 200, 600, 400)',
            true,
            _ldGreen,
          ),
          _ldDivider(),
          _ldEqualityExample(
            'scrollOffset changed',
            '(0, 200, 600, 400) == (10, 200, 600, 400)',
            false,
            _ldCrimson,
          ),
          _ldDivider(),
          _ldEqualityExample(
            'crossAxisExtent changed (resize)',
            '(0, 200, 600, 400) == (0, 200, 600, 380)',
            false,
            _ldCrimson,
          ),
          _ldDivider(),
          _ldEqualityExample(
            'All same, different instances',
            'dims1 == dims2 → true (value equality)',
            true,
            _ldGreen,
          ),
        ],
      )),
      _ldCard('hashCode', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldInlineText(
            'hashCode uses Object.hash() with all four fields, ensuring '
            'that equal instances produce the same hash.  This makes '
            'SliverLayoutDimensions safe to use as Map keys or in Sets, '
            'though that is not its primary use case.',
          ),
        ],
      )),
    ],
  );
}

Widget _ldEqualityExample(
    String title, String code, bool areEqual, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(areEqual ? Icons.check_circle : Icons.cancel,
          size: 18, color: color),
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color)),
            Text(code,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: _ldSlate)),
          ],
        ),
      ),
    ],
  );
}

// -------------- 11. Practical Examples -----------------------------------

Widget _buildPracticalExamples() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ldExplain(
        'While SliverLayoutDimensions is primarily an internal class used '
        'by SliverLayoutBuilder, understanding it helps write better '
        'responsive sliver layouts.  Here are two patterns that rely on '
        'the dimensions changing.',
      ),
      _ldCard('Pattern 1: Adaptive Grid', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldInlineText(
            'Uses crossAxisExtent to compute column count. When the '
            'viewport width changes (rotation, split view), dimensions '
            'change, builder fires, and a new grid delegate is created.',
          ),
          const SizedBox(height: 8),
          // Three phone widths showing different grids
          Row(
            children: [
              _ldAdaptiveGridPreview(320, 2, _ldGold),
              const SizedBox(width: 6),
              _ldAdaptiveGridPreview(480, 3, _ldIndigo),
              const SizedBox(width: 6),
              _ldAdaptiveGridPreview(768, 5, _ldTeal),
            ],
          ),
        ],
      )),
      _ldCard('Pattern 2: Parallax Header', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldInlineText(
            'Uses scrollOffset and viewportMainAxisExtent to compute a '
            'parallax factor.  As the user scrolls, scrollOffset changes, '
            'dimensions change, and the builder re-computes the parallax '
            'offset.',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _ldParallaxPreview(0, 'Top', _ldGold),
              const SizedBox(width: 4),
              _ldParallaxPreview(50, 'Mid-scroll', _ldIndigo),
              const SizedBox(width: 4),
              _ldParallaxPreview(150, 'Deep scroll', _ldCrimson),
            ],
          ),
        ],
      )),
      _ldCode(
        '// Pattern 1: Adaptive Grid\n'
        'SliverLayoutBuilder(\n'
        '  builder: (context, constraints) {\n'
        '    final cols = (constraints.crossAxisExtent / 150)\n'
        '        .floor().clamp(1, 8);\n'
        '    return SliverGrid.count(\n'
        '      crossAxisCount: cols,\n'
        '      children: items,\n'
        '    );\n'
        '  },\n'
        ')\n\n'
        '// Pattern 2: Parallax Header\n'
        'SliverLayoutBuilder(\n'
        '  builder: (context, constraints) {\n'
        '    final parallax = constraints.scrollOffset * 0.5;\n'
        '    return SliverToBoxAdapter(\n'
        '      child: Transform.translate(\n'
        '        offset: Offset(0, parallax),\n'
        '        child: headerImage,\n'
        '      ),\n'
        '    );\n'
        '  },\n'
        ')',
      ),
      _ldCard('Pattern 3: Scroll-Aware Visibility', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ldInlineText(
            'Uses scrollOffset and precedingScrollExtent together to '
            'determine if this sliver is near the top of the viewport.  '
            'When scrollOffset < 100 and precedingScrollExtent is small, '
            'show an expanded header.  Otherwise collapse it.',
          ),
          const SizedBox(height: 8),
          _ldKv('Condition', 'scrollOffset < 100'),
          _ldKv('Action', 'Show expanded header'),
          _ldKv('Otherwise', 'Show collapsed header'),
          _ldDivider(),
          _ldKv('Condition', 'precedingScrollExtent > 500'),
          _ldKv('Action', 'Fade in "back to top" button'),
        ],
      )),
    ],
  );
}

Widget _ldAdaptiveGridPreview(double width, int cols, Color color) {
  return Expanded(
    child: Column(
      children: [
        Text('${width.toInt()}px → $cols cols',
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color)),
        const SizedBox(height: 4),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: List.generate(cols, (i) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        color: color.withValues(alpha: 0.1 + (i % 2) * 0.1),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(cols, (i) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        color: color.withValues(alpha: 0.15 + (i % 2) * 0.1),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ldParallaxPreview(double offset, String label, Color color) {
  return Expanded(
    child: Column(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color)),
        const SizedBox(height: 4),
        Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: -(offset * 0.3),
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  color: color.withValues(alpha: 0.15),
                  alignment: Alignment.center,
                  child: Icon(Icons.image, color: color, size: 20),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 30,
                  color: color.withValues(alpha: 0.05),
                  alignment: Alignment.center,
                  child: Text('content',
                      style: TextStyle(fontSize: 8, color: color)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// -------------- 12. Summary Card -----------------------------------------

Widget _buildSummary() {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_ldGold, Color(0xFFF57F17)],
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
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Summary',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 14),
        _ldSummaryPoint(
          'SliverLayoutDimensions bundles four key layout metrics: '
          'scrollOffset, precedingScrollExtent, viewportMainAxisExtent, '
          'and crossAxisExtent.'),
        _ldSummaryPoint(
          'It is an immutable data class with value equality via == '
          'and hashCode.'),
        _ldSummaryPoint(
          'Created from SliverConstraints inside '
          '_RenderSliverLayoutBuilder.performLayout.'),
        _ldSummaryPoint(
          'SliverLayoutBuilder compares successive dimensions and '
          'skips the builder callback when unchanged.'),
        _ldSummaryPoint(
          'scrollOffset tracks how far this sliver has been scrolled.'),
        _ldSummaryPoint(
          'precedingScrollExtent gives the cumulative extent of all '
          'prior slivers.'),
        _ldSummaryPoint(
          'viewportMainAxisExtent is the visible size along the scroll '
          'axis.'),
        _ldSummaryPoint(
          'crossAxisExtent enables responsive grids and adaptive '
          'column counts.'),
        _ldSummaryPoint(
          'Common patterns: adaptive grid (crossAxisExtent), parallax '
          'header (scrollOffset), scroll-aware visibility '
          '(precedingScrollExtent).'),
      ],
    ),
  );
}

Widget _ldSummaryPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.arrow_right, color: _ldCream, size: 16),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, height: 1.5)),
        ),
      ],
    ),
  );
}
