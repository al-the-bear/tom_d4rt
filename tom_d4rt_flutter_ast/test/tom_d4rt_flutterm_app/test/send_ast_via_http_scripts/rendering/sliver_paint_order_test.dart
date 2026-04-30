// ignore_for_file: avoid_print
// Deep demo: SliverPaintOrder
// Demonstrates the SliverPaintOrder enum that controls which sliver
// paints on top when slivers overlap in a viewport — firstIsTop vs center.
import 'package:flutter/material.dart';

// ─── palette: Teal / Mint Cream ───────────────────────────────────
const Color _poTeal = Color(0xFF00695C);
const Color _poMint = Color(0xFFE0F2F1);
const Color _poAccent = Color(0xFF26A69A);
const Color _poOnTeal = Colors.white;
const Color _poWarn = Color(0xFFFF6D00);
const Color _poDark = Color(0xFF212121);

// ─── text helpers ─────────────────────────────────────────────────
Widget _poTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _poTeal,
              letterSpacing: 0.3)),
    );

Widget _poSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _poAccent)),
    );

Widget _poBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _poCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _poDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFB2FF59),
              height: 1.5)),
    );

Widget _poNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _poMint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _poTeal.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _poTeal),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _poTeal, height: 1.4)),
          ),
        ],
      ),
    );

Widget _poDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _poTeal.withValues(alpha: 0.12)),
    );

Widget _poBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _poAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _poTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _poLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _poTeal,
        letterSpacing: 0.2));

Widget _poSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── visual building blocks ───────────────────────────────────────

/// A colored sliver-like strip used in stacking diagrams.
Widget _poSliverStrip(
    String label, Color bg, Color fg, double topOffset, double height,
    {double opacity = 1.0}) {
  return Positioned(
    top: topOffset,
    left: 0,
    right: 0,
    height: height,
    child: Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: fg.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: fg)),
        ),
      ),
    ),
  );
}

/// A z-index indicator badge.
Widget _poZBadge(String z, Color c) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text('z=$z',
          style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontFamily: 'monospace')),
    );

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _poBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_poTeal, Color(0xFF00897B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.layers, size: 48, color: _poMint),
          const SizedBox(height: 10),
          const Text('SliverPaintOrder',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Controls sliver stacking order during painting',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _poTag('rendering', _poAccent),
              _poTag('enum', _poWarn),
              _poTag('painting order', _poDark),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is SliverPaintOrder? ────────────────────────────────
List<Widget> _poWhatIs() => [
      _poTitle('§2  What Is SliverPaintOrder?'),
      _poBody(
          'SliverPaintOrder is an enum with two values that determines the '
          'z-ordering of slivers when the Viewport paints them. When two '
          'slivers visually overlap (due to overscroll, pinned headers, '
          'or SliverOverlapAbsorber), this enum decides which one renders '
          'on top.'),
      _poCode(
          'enum SliverPaintOrder {\n'
          '  /// The first sliver in the list is painted on top.\n'
          '  firstIsTop,\n'
          '\n'
          '  /// The sliver nearest the center is painted on top.\n'
          '  center,\n'
          '}'),
      _poBody(
          'By default, Viewport uses firstIsTop. This means the sliver '
          'added first (e.g., a SliverAppBar) paints over slivers that come '
          'after it. The center value is used in specialized layouts where '
          'the center sliver should dominate the visual stacking.'),
      _poNote(
          'SliverPaintOrder was introduced to give developers control over '
          'z-ordering without resorting to manual painting tricks.'),
    ];

// ─── §3 The two enum values ──────────────────────────────────────
List<Widget> _poEnumValues() => [
      _poDivider(),
      _poTitle('§3  The Two Enum Values'),
      _poSubtitle('firstIsTop'),
      _poBody(
          'Paints slivers in reverse child order — the first sliver in the '
          'viewport child list is painted last (and therefore appears on top). '
          'Think of it like a Stack where the first widget is on top.'),
      _poBullet('Use case',
          'SliverAppBar pinned over a SliverList — the app bar must paint above'),
      _poBullet('Default', 'This is the default for standard Viewport'),
      _poSubtitle('center'),
      _poBody(
          'Paints slivers outward from the center sliver. The center sliver '
          'paints last (on top). Slivers before the center paint in order; '
          'slivers after the center paint in reverse order. The center sliver '
          'has the highest z-index.'),
      _poBullet('Use case',
          'Bidirectional scroll with a center-anchored divider that stays on top'),
      _poBullet('Viewport property',
          'Set via Viewport.paintOrder or Viewport.center'),
      _poSubtitle('Visual comparison'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _poMint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _poLabel('firstIsTop'),
                  const SizedBox(height: 6),
                  _poOrderColumn([
                    _poOrderItem('Sliver A', 'z=2 (top)', _poTeal),
                    _poOrderItem('Sliver B', 'z=1', _poAccent),
                    _poOrderItem('Sliver C', 'z=0', Colors.grey),
                  ]),
                ],
              ),
            ),
            Container(width: 1, height: 100, color: _poTeal.withValues(alpha: 0.2)),
            Expanded(
              child: Column(
                children: [
                  _poLabel('center (B = center)'),
                  const SizedBox(height: 6),
                  _poOrderColumn([
                    _poOrderItem('Sliver A', 'z=0', Colors.grey),
                    _poOrderItem('Sliver B', 'z=2 (top)', _poTeal),
                    _poOrderItem('Sliver C', 'z=1', _poAccent),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

Widget _poOrderColumn(List<Widget> children) => Column(children: children);

Widget _poOrderItem(String name, String z, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(name,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          ),
          Text(z,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: c,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );

// ─── §4 firstIsTop stacking diagram ─────────────────────────────
List<Widget> _poFirstIsTopDiagram() => [
      _poDivider(),
      _poTitle('§4  Visual: firstIsTop Stacking'),
      _poBody(
          'Below, three slivers overlap vertically. With firstIsTop, the '
          'first sliver (App Bar) covers the second (List), which covers '
          'the third (Footer).'),
      Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _poTeal.withValues(alpha: 0.2)),
        ),
        child: Stack(
          children: [
            // Bottom layer: footer sliver
            _poSliverStrip('Sliver C — Footer',
                Colors.grey.shade300, Colors.grey.shade700, 100, 80,
                opacity: 0.8),
            // Middle layer: list sliver
            _poSliverStrip('Sliver B — List Content',
                _poAccent.withValues(alpha: 0.3), _poAccent, 50, 100,
                opacity: 0.9),
            // Top layer: app bar sliver
            _poSliverStrip('Sliver A — App Bar (TOP)',
                _poTeal, _poOnTeal, 10, 70),
            // z-index badges
            Positioned(
              top: 12,
              right: 8,
              child: _poZBadge('2', _poTeal),
            ),
            Positioned(
              top: 52,
              right: 8,
              child: _poZBadge('1', _poAccent),
            ),
            Positioned(
              top: 102,
              right: 8,
              child: _poZBadge('0', Colors.grey),
            ),
          ],
        ),
      ),
      _poSmall('Overlap regions show the top sliver covering those beneath'),
      _poBody(
          'The paint order is C → B → A (last painted = on top). So the '
          'first sliver (A) is painted last and appears above everything.'),
      _poCode(
          '// Default behavior:\n'
          'Viewport(\n'
          '  sliverPaintOrder: SliverPaintOrder.firstIsTop, // default\n'
          '  children: [\n'
          '    SliverAppBar(pinned: true),  // ← paints on top\n'
          '    SliverList(...),\n'
          '    SliverToBoxAdapter(...),\n'
          '  ],\n'
          ')'),
    ];

// ─── §5 center stacking diagram ─────────────────────────────────
List<Widget> _poCenterDiagram() => [
      _poDivider(),
      _poTitle('§5  Visual: center Stacking'),
      _poBody(
          'With center paint order, the center sliver has highest z-index. '
          'Slivers before it paint below; slivers after it also paint below.'),
      Container(
        width: double.infinity,
        height: 220,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _poTeal.withValues(alpha: 0.2)),
        ),
        child: Stack(
          children: [
            // Bottom layer: first sliver (before center)
            _poSliverStrip('Sliver A — Before Center',
                Colors.grey.shade300, Colors.grey.shade700, 10, 70,
                opacity: 0.7),
            // Middle-bottom: after-center sliver
            _poSliverStrip('Sliver C — After Center',
                _poAccent.withValues(alpha: 0.3), _poAccent, 130, 70,
                opacity: 0.8),
            // Top layer: CENTER sliver
            _poSliverStrip('Sliver B — CENTER (TOP)',
                _poTeal, _poOnTeal, 60, 90),
            // z-badges
            Positioned(
              top: 12,
              right: 8,
              child: _poZBadge('0', Colors.grey),
            ),
            Positioned(
              top: 62,
              right: 8,
              child: _poZBadge('2', _poTeal),
            ),
            Positioned(
              top: 132,
              right: 8,
              child: _poZBadge('1', _poAccent),
            ),
            // Arrows showing paint outward from center
            Positioned(
              top: 48,
              left: 14,
              child: Column(
                children: [
                  const Icon(Icons.arrow_upward, size: 14, color: _poWarn),
                  const SizedBox(height: 68),
                  const Icon(Icons.arrow_downward, size: 14, color: _poWarn),
                ],
              ),
            ),
          ],
        ),
      ),
      _poSmall('The center sliver dominates — it paints last, covering overlap areas'),
      _poBody(
          'Paint order: A (first, lowest z), then C (after center), then B '
          '(center, highest z). The center sliver always wins visually.'),
    ];

// ─── §6 How Viewport uses paintOrder ─────────────────────────────
List<Widget> _poViewportUsage() => [
      _poDivider(),
      _poTitle('§6  How Viewport Uses paintOrder'),
      _poBody(
          'The Viewport render object reads its paintOrder property during '
          'paint. It builds a paint sequence that determines the order in '
          'which each child sliver is painted.'),
      _poCode(
          'class RenderViewport extends RenderViewportBase {\n'
          '  SliverPaintOrder get paintOrder => _paintOrder;\n'
          '  SliverPaintOrder _paintOrder;\n'
          '\n'
          '  @override\n'
          '  void paint(PaintingContext context, Offset offset) {\n'
          '    // Build ordered list based on paintOrder\n'
          '    if (paintOrder == SliverPaintOrder.firstIsTop) {\n'
          '      // Paint in reverse: last child first, first child last\n'
          '      _paintInReverseChildOrder(context, offset);\n'
          '    } else {\n'
          '      // Paint outward from center\n'
          '      _paintFromCenter(context, offset);\n'
          '    }\n'
          '  }\n'
          '}'),
      _poSubtitle('Paint sequence comparison'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _poMint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _poLabel('Given slivers: [App, Header, List, Footer]'),
            const SizedBox(height: 10),
            _poSequenceRow('firstIsTop paint order:',
                ['Footer', 'List', 'Header', 'App'],
                'App on top'),
            const SizedBox(height: 8),
            _poSequenceRow('center (Header=center):',
                ['App', 'Footer', 'List', 'Header'],
                'Header on top'),
          ],
        ),
      ),
      _poNote(
          'Hit testing also respects paint order — the topmost painted '
          'sliver receives touch events first when slivers overlap.'),
    ];

Widget _poSequenceRow(String label, List<String> order, String note) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _poTeal)),
        const SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < order.length; i++) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: i == order.length - 1 ? _poTeal : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: _poTeal.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Column(
                    children: [
                      Text('${i + 1}',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: i == order.length - 1
                                  ? Colors.white
                                  : _poTeal)),
                      Text(order[i],
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: i == order.length - 1
                                  ? Colors.white
                                  : Colors.black87)),
                    ],
                  ),
                ),
                if (i < order.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child:
                        Icon(Icons.arrow_forward, size: 12, color: _poAccent),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 2),
        _poSmall('→ $note'),
      ],
    );

// ─── §7 Overlap scenarios ────────────────────────────────────────
List<Widget> _poOverlapScenarios() => [
      _poDivider(),
      _poTitle('§7  When Paint Order Matters'),
      _poBody(
          'Paint order only matters when slivers visually overlap. Here are '
          'the common scenarios where overlap occurs:'),
      _poSubtitle('1. Pinned SliverAppBar'),
      _poBody(
          'A pinned SliverAppBar stays fixed at the top while list content '
          'scrolls beneath it. The app bar must paint on top.'),
      _poScenarioBox(
        'SliverAppBar (pinned)',
        'SliverList scrolls under',
        _poTeal,
        _poAccent.withValues(alpha: 0.4),
      ),
      _poSubtitle('2. SliverPersistentHeader'),
      _poBody(
          'Persistent headers pin or float at specific scroll offsets, '
          'overlapping adjacent sliver content.'),
      _poScenarioBox(
        'SliverPersistentHeader',
        'Adjacent sliver content',
        _poTeal,
        Colors.grey.shade300,
      ),
      _poSubtitle('3. Overscroll effects'),
      _poBody(
          'On platforms with bounce-back physics, overscroll can cause '
          'slivers to visually overlap at the edges.'),
      _poScenarioBox(
        'Bounced sliver A',
        'Stationary sliver B',
        _poWarn,
        Colors.grey.shade300,
      ),
      _poSubtitle('4. Custom overlap layouts'),
      _poBody(
          'Some custom layouts intentionally overlap slivers for visual '
          'effects like parallax or layered cards.'),
    ];

Widget _poScenarioBox(
    String topLabel, String bottomLabel, Color topC, Color bottomC) {
  return Container(
    width: double.infinity,
    height: 80,
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 20,
          right: 20,
          top: 30,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: bottomC,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Center(
              child: Text(bottomLabel,
                  style: const TextStyle(
                      fontSize: 10, color: Colors.black54)),
            ),
          ),
        ),
        Positioned(
          left: 12,
          right: 12,
          top: 8,
          height: 44,
          child: Container(
            decoration: BoxDecoration(
              color: topC,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x30000000),
                    blurRadius: 4,
                    offset: Offset(0, 2)),
              ],
            ),
            child: Center(
              child: Text(topLabel,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── §8 Comparison table ─────────────────────────────────────────
List<Widget> _poComparisonTable() => [
      _poDivider(),
      _poTitle('§8  Comparison: firstIsTop vs center'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _poMint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _poCompRow('Property', 'firstIsTop', 'center', isHeader: true),
            _poCompRow('Top sliver', 'First child', 'Center child'),
            _poCompRow('Default?', 'Yes', 'No'),
            _poCompRow('Paint start', 'Last child', 'Edges'),
            _poCompRow('Paint end', 'First child', 'Center'),
            _poCompRow('Use case', 'Typical scroll', 'Bidirectional'),
            _poCompRow('Hit test top', 'First child wins', 'Center wins'),
            _poCompRow(
                'SliverAppBar', 'Natural (on top)', 'Depends on position'),
          ],
        ),
      ),
      _poBody(
          'For almost all applications, firstIsTop is the correct choice. '
          'The center value is primarily useful for bidirectional scrolling '
          'where a center anchor sliver should visually dominate.'),
    ];

Widget _poCompRow(String prop, String val1, String val2,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 11,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _poTeal : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(width: 90, child: Text(prop, style: style)),
        Expanded(child: Text(val1, style: style)),
        Expanded(child: Text(val2, style: style)),
      ],
    ),
  );
}

// ─── §9 CustomScrollView and paintOrder ──────────────────────────
List<Widget> _poCustomScrollView() => [
      _poDivider(),
      _poTitle('§9  CustomScrollView and paintOrder'),
      _poBody(
          'CustomScrollView does not directly expose a paintOrder parameter '
          'because it uses the default firstIsTop. To use center paint order, '
          'you typically work with a raw Viewport or Scrollable+Viewport.'),
      _poCode(
          '// Using CustomScrollView (always firstIsTop):\n'
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverAppBar(pinned: true, title: Text("App")),\n'
          '    SliverList(\n'
          '      delegate: SliverChildListDelegate(items),\n'
          '    ),\n'
          '  ],\n'
          ')'),
      _poCode(
          '// For center paint order — use raw Viewport:\n'
          'Scrollable(\n'
          '  viewportBuilder: (context, offset) {\n'
          '    return Viewport(\n'
          '      offset: offset,\n'
          '      paintOrder: SliverPaintOrder.center,\n'
          '      center: centerKey,\n'
          '      slivers: [\n'
          '        SliverList(key: beforeKey, ...),\n'
          '        SliverList(key: centerKey, ...),\n'
          '        SliverList(key: afterKey, ...),\n'
          '      ],\n'
          '    );\n'
          '  },\n'
          ')'),
      _poNote(
          'The center sliver in a Viewport is the one whose scroll offset '
          'is zero. Slivers before it scroll in reverse; slivers after it '
          'scroll forward. Paint order center ensures this anchor sliver '
          'is always visible on top.'),
    ];

// ─── §10 Practical examples ─────────────────────────────────────
List<Widget> _poPractical() => [
      _poDivider(),
      _poTitle('§10  Practical Examples'),
      _poSubtitle('Example 1: Chat app with center divider'),
      _poBody(
          'In a chat app with bidirectional scroll, new messages load above '
          'and below. A center divider ("Today") should always be visible:'),
      Container(
        width: double.infinity,
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Older messages (above center)
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: const Center(
                  child: Text('Older messages ↑',
                      style: TextStyle(
                          fontSize: 11, color: Colors.black45)),
                ),
              ),
            ),
            // Center divider — "Today"
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: _poTeal,
              child: const Center(
                child: Text('— Today —',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
            // Newer messages (below center)
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                decoration: BoxDecoration(
                  color: _poAccent.withValues(alpha: 0.15),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
                child: const Center(
                  child: Text('Newer messages ↓',
                      style: TextStyle(
                          fontSize: 11, color: Colors.black45)),
                ),
              ),
            ),
          ],
        ),
      ),
      _poSmall(
          'With SliverPaintOrder.center, the "Today" divider always paints on top'),
      _poSubtitle('Example 2: Layered parallax effect'),
      _poBody(
          'A creative portfolio uses overlapping slivers for depth. The '
          'hero section should always be on top:'),
      Container(
        width: double.infinity,
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              right: 16,
              bottom: 10,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Background content',
                      style: TextStyle(fontSize: 10, color: Colors.black45)),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 40,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: _poAccent.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Mid-layer content',
                      style: TextStyle(fontSize: 10, color: Colors.white70)),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 10,
              height: 55,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_poTeal, Color(0xFF00897B)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x30000000),
                        blurRadius: 4,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: const Center(
                  child: Text('Hero section (top)',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
      _poSmall('firstIsTop: hero section painted last, appears on top'),
    ];

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _poSummary() => [
      _poDivider(),
      _poTitle('§11  Summary'),
      _poBody(
          'SliverPaintOrder provides a simple but essential control over how '
          'overlapping slivers are stacked during painting.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _poTeal.withValues(alpha: 0.08),
              _poMint,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _poTeal.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _poTeal)),
            const SizedBox(height: 10),
            _poSummaryPoint('firstIsTop',
                'First sliver paints on top — the standard default'),
            _poSummaryPoint('center',
                'Center sliver paints on top — for bidirectional layouts'),
            _poSummaryPoint('Overlap',
                'Only relevant when slivers overlap (pinned headers, overscroll)'),
            _poSummaryPoint('Hit testing',
                'Respects paint order — topmost painted sliver gets touches'),
            _poSummaryPoint('CustomScrollView',
                'Uses firstIsTop; center requires raw Viewport'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _poTeal,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of SliverPaintOrder Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _poSummaryPoint(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _poAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _poTeal)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _poBanner(),
        const SizedBox(height: 20),
        ..._poWhatIs(),
        ..._poEnumValues(),
        ..._poFirstIsTopDiagram(),
        ..._poCenterDiagram(),
        ..._poViewportUsage(),
        ..._poOverlapScenarios(),
        ..._poComparisonTable(),
        ..._poCustomScrollView(),
        ..._poPractical(),
        ..._poSummary(),
      ],
    ),
  );
}
