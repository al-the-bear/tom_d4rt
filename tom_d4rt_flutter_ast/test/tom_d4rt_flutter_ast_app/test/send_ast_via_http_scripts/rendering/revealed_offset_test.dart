// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// REVEALED OFFSET — Deep Demo
// ============================================================================
//
// RevealedOffset is a small, immutable data class in Flutter's
// rendering layer. It is the return value of
// RenderAbstractViewport.getOffsetToReveal(), which calculates:
//
//   1. offset — the scroll offset needed to bring a target into view
//   2. rect   — the Rect the target will occupy after scrolling
//
// This is the mechanism behind Scrollable.ensureVisible() — the
// function that scrolls a viewport to make a specific widget visible.
//
// RevealedOffset is simple but essential for understanding how
// Flutter computes scroll-to-item positions.
//
// Color theme : Forest (#228B22) / Moss (#8A9A5B)
// Helper prefix: _ro
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _roForest = Color(0xFF228B22);
const Color _roMoss = Color(0xFF8A9A5B);
const Color _roLightForest = Color(0xFF4CAF50);
const Color _roDarkForest = Color(0xFF145A14);
const Color _roCream = Color(0xFFF9F6F0);
const Color _roBark = Color(0xFF5D4037);
const Color _roGold = Color(0xFFD4A017);
const Color _roSky = Color(0xFF5B9BD5);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _roSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_roForest, _roDarkForest],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _roInfoCard(String heading, String body, {IconData? icon}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _roMoss.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 2),
            child: Icon(icon, color: _roForest, size: 22),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  color: _roDarkForest,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _roBark,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _roCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1A2F1A),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _roLightForest,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.6,
      ),
    ),
  );
}

Widget _roDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    height: 1,
    color: _roMoss.withValues(alpha: 0.3),
  );
}

Widget _roBadge(String label, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: What Is RevealedOffset?
// ---------------------------------------------------------------------------

Widget _roSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '1. What Is RevealedOffset?',
        subtitle: 'A data class holding scroll destination info',
      ),
      const SizedBox(height: 12),
      _roInfoCard(
        'Definition',
        'RevealedOffset is an immutable class with exactly two fields:\n\n'
            '• offset (double) — The scroll pixel position that would '
            'bring the target into the viewport\n'
            '• rect (Rect) — The rectangle describing where the target '
            'will appear in the viewport after scrolling to that offset',
        icon: Icons.data_object,
      ),
      const SizedBox(height: 8),
      _roCodeBlock(
        '// RevealedOffset (simplified):\n'
        'class RevealedOffset {\n'
        '  const RevealedOffset({\n'
        '    required this.offset,\n'
        '    required this.rect,\n'
        '  });\n'
        '\n'
        '  final double offset;  // scroll position target\n'
        '  final Rect rect;      // where the item will be\n'
        '}',
      ),
      const SizedBox(height: 8),
      // Visual: the two fields
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _roCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _roMoss.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _roForest.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _roForest.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.swap_vert, color: _roForest, size: 24),
                    SizedBox(height: 6),
                    Text(
                      'offset',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _roDarkForest,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Where to scroll to\n(pixels from origin)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: _roBark),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _roSky.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _roSky.withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.crop_square, color: _roSky, size: 24),
                    SizedBox(height: 6),
                    Text(
                      'rect',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _roSky,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Where item lands\n(viewport-relative)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: _roBark),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Where RevealedOffset Comes From
// ---------------------------------------------------------------------------

Widget _roSection2Origin() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '2. Where RevealedOffset Comes From',
        subtitle: 'getOffsetToReveal() → RevealedOffset',
      ),
      const SizedBox(height: 12),
      _roInfoCard(
        'The Source',
        'RevealedOffset is returned by '
            'RenderAbstractViewport.getOffsetToReveal(). This method '
            'takes a target RenderObject and an alignment value (0.0 to '
            '1.0) and computes where the viewport should scroll.',
        icon: Icons.source,
      ),
      const SizedBox(height: 8),
      _roCodeBlock(
        '// How getOffsetToReveal works:\n'
        'RevealedOffset getOffsetToReveal(\n'
        '  RenderObject target,\n'
        '  double alignment, {\n'
        '  Rect? rect,       // sub-area of target\n'
        '}) {\n'
        '  // Calculate current position of target\n'
        '  // Compute scroll offset to bring it to alignment\n'
        '  // Return RevealedOffset(offset: ..., rect: ...)\n'
        '}',
      ),
      const SizedBox(height: 8),
      // Flow: ensureVisible → getOffsetToReveal → RevealedOffset → scroll
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2F1A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text(
              'ensureVisible Call Chain',
              style: TextStyle(
                color: _roGold,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            _roFlowBox('Scrollable.ensureVisible(context)', _roLightForest),
            _roFlowArrow(),
            _roFlowBox('RenderAbstractViewport.of(renderObject)', _roMoss),
            _roFlowArrow(),
            _roFlowBox('viewport.getOffsetToReveal(target, alignment)', _roSky),
            _roFlowArrow(),
            _roFlowBox('→ RevealedOffset(offset: 840.0, rect: Rect(...))', _roGold),
            _roFlowArrow(),
            _roFlowBox('ScrollPosition.animateTo(revealed.offset)', _roLightForest),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _roFlowBox(String text, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _roFlowArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Icon(Icons.arrow_downward, color: _roMoss, size: 16),
  );
}

// ---------------------------------------------------------------------------
// Section 3: The alignment Parameter
// ---------------------------------------------------------------------------

Widget _roSection3Alignment() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '3. The alignment Parameter',
        subtitle: 'How alignment affects the revealed position',
      ),
      const SizedBox(height: 12),
      _roInfoCard(
        'Alignment: 0.0 to 1.0',
        'The alignment parameter controls where in the viewport the '
            'target should appear after scrolling:\n\n'
            '• 0.0 — target at the leading edge (top/left)\n'
            '• 0.5 — target centered in the viewport\n'
            '• 1.0 — target at the trailing edge (bottom/right)\n\n'
            'This directly affects both the offset and rect in the '
            'returned RevealedOffset.',
        icon: Icons.align_vertical_center,
      ),
      const SizedBox(height: 8),
      // Visual: 3 alignment positions
      _roAlignmentVisual('alignment: 0.0', 'Target at top', 0.0),
      const SizedBox(height: 6),
      _roAlignmentVisual('alignment: 0.5', 'Target centered', 0.5),
      const SizedBox(height: 6),
      _roAlignmentVisual('alignment: 1.0', 'Target at bottom', 1.0),
      const SizedBox(height: 8),
      _roCodeBlock(
        '// Different alignments produce different offsets:\n'
        '// Assume viewport height = 600, item height = 60\n'
        '// Item is at position 1500 in the scroll content\n'
        '\n'
        'alignment: 0.0 → offset: 1500.0\n'
        '  // rect: Rect(0, 0, width, 60)\n'
        '  // Item at very top of viewport\n'
        '\n'
        'alignment: 0.5 → offset: 1230.0\n'
        '  // rect: Rect(0, 270, width, 60)\n'
        '  // Item centered: (600 - 60) / 2 = 270\n'
        '\n'
        'alignment: 1.0 → offset: 960.0\n'
        '  // rect: Rect(0, 540, width, 60)\n'
        '  // Item at bottom: 600 - 60 = 540',
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _roAlignmentVisual(String label, String desc, double alignment) {
  const double viewportH = 140.0;
  const double itemH = 24.0;
  final double itemTop = alignment * (viewportH - itemH);

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _roMoss.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        // Viewport visualization
        SizedBox(
          width: 80,
          height: viewportH,
          child: Stack(
            children: [
              // Viewport outline
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _roForest, width: 2),
                  borderRadius: BorderRadius.circular(4),
                  color: _roForest.withValues(alpha: 0.05),
                ),
              ),
              // Target item
              Positioned(
                top: itemTop,
                left: 4,
                right: 4,
                child: Container(
                  height: itemH,
                  decoration: BoxDecoration(
                    color: _roGold,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      'target',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Edge labels
              const Positioned(
                top: 2,
                right: 2,
                child: Text(
                  'top',
                  style: TextStyle(fontSize: 8, color: _roMoss),
                ),
              ),
              const Positioned(
                bottom: 2,
                right: 2,
                child: Text(
                  'bottom',
                  style: TextStyle(fontSize: 8, color: _roMoss),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // Label
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: _roDarkForest,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(fontSize: 12, color: _roBark),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Practical Usage — ensureVisible
// ---------------------------------------------------------------------------

Widget _roSection4EnsureVisible() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '4. Practical Usage — ensureVisible',
        subtitle: 'How apps use RevealedOffset through ensureVisible',
      ),
      const SizedBox(height: 12),
      _roInfoCard(
        'The Common Pattern',
        'Most developers never create a RevealedOffset directly. They '
            'call Scrollable.ensureVisible(), which internally calls '
            'getOffsetToReveal() and uses the returned RevealedOffset '
            'to animate the scroll position.',
        icon: Icons.lightbulb_outline,
      ),
      const SizedBox(height: 8),
      _roCodeBlock(
        '// The most common way to trigger RevealedOffset:\n'
        'await Scrollable.ensureVisible(\n'
        '  context,                      // BuildContext of target\n'
        '  alignment: 0.5,              // center target in view\n'
        '  duration: Duration(ms: 300), // animate\n'
        '  curve: Curves.easeInOut,\n'
        ');\n'
        '\n'
        '// Internally, Flutter does:\n'
        '// 1. Find the viewport ancestor\n'
        '// 2. Call viewport.getOffsetToReveal(target, 0.5)\n'
        '// 3. Get RevealedOffset(offset: X, rect: Y)\n'
        '// 4. Animate scrollPosition to X',
      ),
      const SizedBox(height: 8),
      // Typical use-cases
      _roUseCaseItem(
        'Scroll to Item in ListView',
        'Using GlobalKey to get context, then ensureVisible',
        Icons.list,
      ),
      _roUseCaseItem(
        'Form Validation Errors',
        'Scroll to the first field with an error',
        Icons.error_outline,
      ),
      _roUseCaseItem(
        'Focus Management',
        'When a TextField gains focus, ensure it\'s visible above the keyboard',
        Icons.keyboard,
      ),
      _roUseCaseItem(
        'Deep Links',
        'App opened with a deep link to a specific section',
        Icons.link,
      ),
      _roUseCaseItem(
        'Search Results',
        'Scroll to the first matching item in a list',
        Icons.search,
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _roUseCaseItem(String title, String desc, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _roForest.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: _roForest.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _roForest, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: _roDarkForest,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(fontSize: 11.5, color: _roBark),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Nested Viewports
// ---------------------------------------------------------------------------

Widget _roSection5Nested() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '5. Nested Viewports',
        subtitle: 'RevealedOffset with nested scroll views',
      ),
      const SizedBox(height: 12),
      _roInfoCard(
        'Viewport Chains',
        'When viewports are nested (e.g., a horizontal ListView inside '
            'a vertical ListView), ensureVisible walks up the viewport '
            'chain. Each viewport returns its own RevealedOffset, and '
            'the final scroll position is the composition of all offsets '
            'in the chain.',
        icon: Icons.layers,
      ),
      const SizedBox(height: 8),
      // Nested viewport visual
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _roCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _roForest.withValues(alpha: 0.3), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Outer Viewport (vertical)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: _roForest,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: _roMoss.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text('Item A', style: TextStyle(color: _roBark, fontSize: 11)),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _roSky.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _roSky.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Inner Viewport (horizontal)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: _roSky,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _roNestedItem('B1', _roMoss),
                      const SizedBox(width: 4),
                      _roNestedItem('B2', _roMoss),
                      const SizedBox(width: 4),
                      _roNestedItem('B3', _roGold),
                      const SizedBox(width: 4),
                      _roNestedItem('B4', _roMoss),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: _roMoss.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text('Item C', style: TextStyle(color: _roBark, fontSize: 11)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _roInfoCard(
        'Revealing B3',
        'To reveal B3 the system computes two RevealedOffsets:\n\n'
            '1. Inner viewport: scroll horizontally to show B3\n'
            '   → RevealedOffset(offset: 120.0, rect: ...)\n\n'
            '2. Outer viewport: scroll vertically to show inner row\n'
            '   → RevealedOffset(offset: 200.0, rect: ...)\n\n'
            'Both scroll positions are animated.',
        icon: Icons.unfold_more,
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _roNestedItem(String label, Color color) {
  return Expanded(
    child: Container(
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: Edge Cases
// ---------------------------------------------------------------------------

Widget _roSection6EdgeCases() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '6. Edge Cases',
        subtitle: 'What RevealedOffset handles gracefully',
      ),
      const SizedBox(height: 12),
      _roEdgeCaseCard(
        'Already Visible',
        'If the target is already fully visible, getOffsetToReveal '
            'still returns a RevealedOffset. The offset will be the '
            'current scroll position (no movement needed).',
        Icons.check_circle,
        _roForest,
      ),
      _roEdgeCaseCard(
        'Partially Visible',
        'If the target is only partially in view, the offset is '
            'adjusted to fully reveal it. The rect shows its final '
            'position after the scroll.',
        Icons.vertical_align_center,
        _roSky,
      ),
      _roEdgeCaseCard(
        'Off Screen',
        'If the target is far off-screen, the offset may be a large '
            'value. The scroll animation covers the full distance.',
        Icons.open_in_new,
        _roGold,
      ),
      _roEdgeCaseCard(
        'Item Larger Than Viewport',
        'If the target is taller/wider than the viewport, alignment '
            'controls which edge is visible. With alignment 0.0, the '
            'leading edge is shown; with 1.0, the trailing edge.',
        Icons.aspect_ratio,
        _roBark,
      ),
      _roEdgeCaseCard(
        'Sub-Rect',
        'You can pass a rect parameter to getOffsetToReveal to reveal '
            'only a sub-area of the target (useful for large items where '
            'you want to show a specific part).',
        Icons.crop,
        const Color(0xFF8E44AD),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _roEdgeCaseCard(String title, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(fontSize: 12, color: _roBark, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Visual Demo — Scroll to Reveal
// ---------------------------------------------------------------------------

Widget _roSection7VisualDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '7. Visual Demo — Scroll to Reveal',
        subtitle: 'Interactive illustration of RevealedOffset',
      ),
      const SizedBox(height: 12),
      _roInfoCard(
        'Scrollable List Demo',
        'Below is a list where each item represents a position in a '
            'scrollable container. The highlighted item represents the '
            '"target" that ensureVisible would scroll to. The viewport '
            'surrounds the visible portion.',
        icon: Icons.visibility,
      ),
      const SizedBox(height: 8),
      // Simulated scrollable list
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _roForest, width: 2),
        ),
        child: Column(
          children: [
            // "Above viewport" items (greyed out)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '↑ scrolled past',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'offset: 0–400',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: Colors.grey.shade400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ...['Item 0', 'Item 1', 'Item 2', 'Item 3'].map(
                    (name) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Viewport area
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _roForest.withValues(alpha: 0.05),
                border: Border.symmetric(
                  horizontal: BorderSide(color: _roForest.withValues(alpha: 0.3), width: 2),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roBadge('VIEWPORT', _roForest),
                      const Text(
                        'offset: 400–700',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: _roDarkForest,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _roListItem('Item 4', false),
                  _roListItem('Item 5', false),
                  _roListItem('Item 6 ← TARGET', true),
                ],
              ),
            ),
            // Below viewport
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  ...['Item 7', 'Item 8', 'Item 9'].map(
                    (name) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '↓ below viewport',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'offset: 700–1000',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: Colors.grey.shade400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      // RevealedOffset result
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2F1A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'getOffsetToReveal(item6, 0.5) →',
              style: TextStyle(
                color: _roGold,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'RevealedOffset(\n'
              '  offset: 470.0,  // scroll to 470px\n'
              '  rect: Rect.fromLTWH(0, 120, 360, 60),\n'
              '  // Item 6 centered at y=120 in 300px viewport\n'
              ')',
              style: TextStyle(
                color: _roLightForest,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget _roListItem(String text, bool isTarget) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 2),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    decoration: BoxDecoration(
      color: isTarget ? _roGold.withValues(alpha: 0.15) : Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: isTarget ? _roGold : _roMoss.withValues(alpha: 0.2),
        width: isTarget ? 2 : 1,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isTarget ? _roGold : _roBark,
        fontSize: 12,
        fontWeight: isTarget ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Summary
// ---------------------------------------------------------------------------

Widget _roSection8Summary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _roSectionHeader(
        '8. Summary',
        subtitle: 'RevealedOffset at a glance',
      ),
      const SizedBox(height: 12),
      // Compact summary
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _roCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _roMoss.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            _roSummaryRow('Type', 'Immutable data class'),
            _roSummaryRow('Fields', 'offset (double) + rect (Rect)'),
            _roSummaryRow('Created by', 'RenderAbstractViewport.getOffsetToReveal()'),
            _roSummaryRow('Used by', 'Scrollable.ensureVisible()'),
            _roSummaryRow('Controls', 'Where to scroll and where target lands'),
            _roSummaryRow('alignment', '0.0=top, 0.5=center, 1.0=bottom'),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _roInfoCard(
        'Why Understanding RevealedOffset Matters',
        'RevealedOffset is a small class, but it represents a key '
            'concept: the scroll system\'s ability to compute exactly '
            'where to scroll and where the target will end up. This is '
            'the foundation of all "scroll to item" functionality in '
            'Flutter.',
        icon: Icons.school,
      ),
      const SizedBox(height: 8),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_roForest, _roDarkForest],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: _roLightForest, size: 22),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'RevealedOffset answers the question: "Where should I '
                    'scroll, and where will the item be when I get there?"',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

Widget _roSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: _roDarkForest,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: _roBark),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MAIN BUILD ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('=== RevealedOffset Deep Demo ===');
  print('RevealedOffset holds the scroll destination and target rect.');
  print('It is returned by getOffsetToReveal() and used by ensureVisible().');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF2F5ED),
      appBarTheme: const AppBarTheme(
        backgroundColor: _roForest,
        foregroundColor: Colors.white,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RevealedOffset'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'rendering',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_roDarkForest, _roForest, _roMoss],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RevealedOffset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'A data class that tells the scroll system exactly '
                        'where to scroll and where the revealed item will '
                        'appear in the viewport.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _roBadge('data class', _roMoss),
                      const SizedBox(width: 8),
                      _roBadge('immutable', _roDarkForest),
                      const SizedBox(width: 8),
                      _roBadge('scroll system', _roGold),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _roSection1Overview(),
            _roDivider(),
            _roSection2Origin(),
            _roDivider(),
            _roSection3Alignment(),
            _roDivider(),
            _roSection4EnsureVisible(),
            _roDivider(),
            _roSection5Nested(),
            _roDivider(),
            _roSection6EdgeCases(),
            _roDivider(),
            _roSection7VisualDemo(),
            _roDivider(),
            _roSection8Summary(),
          ],
        ),
      ),
    ),
  );
}
