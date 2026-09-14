// ignore_for_file: avoid_print
// Deep demo: WrapAlignment
// Demonstrates the WrapAlignment enum — controls how children are
// positioned within a Wrap run along the main axis. Covers all six
// values with visual comparisons.
import 'package:flutter/material.dart';

// ─── palette: Deep Teal / Pale Teal ──────────────────────────────
const Color _waTeal = Color(0xFF004D40);
const Color _waPale = Color(0xFFE0F2F1);
const Color _waAccent = Color(0xFF00796B);
const Color _waDark = Color(0xFF1A1A1A);
const Color _waBlue = Color(0xFF1565C0);
const Color _waPurple = Color(0xFF6A1B9A);
const Color _waOrange = Color(0xFFE65100);
const Color _waRed = Color(0xFFC62828);
const Color _waYellow = Color(0xFFF9A825);
const Color _waPink = Color(0xFFAD1457);

// ─── text helpers ─────────────────────────────────────────────────
Widget _waTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _waTeal,
              letterSpacing: 0.3)),
    );

Widget _waSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _waAccent)),
    );

Widget _waBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _waCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _waDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFB2DFDB),
              height: 1.5)),
    );

Widget _waNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _waPale,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _waTeal.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _waTeal),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _waTeal, height: 1.4)),
          ),
        ],
      ),
    );

Widget _waDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _waTeal.withValues(alpha: 0.1)),
    );

Widget _waBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _waAccent, shape: BoxShape.circle),
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

Widget _waTag(String t, Color bg, [Color fg = Colors.white]) => Container(
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

Widget _waLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _waTeal,
        letterSpacing: 0.2));

// ─── block builder for alignment visuals ──────────────────────────
Widget _waBlock(double w, Color c, [String? label]) => Container(
      width: w,
      height: 32,
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c, width: 1.5),
      ),
      child: Center(
        child: Text(label ?? '${w.toInt()}',
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: 'monospace')),
      ),
    );

/// Show a wrap-alignment visual with blocks in a track.
Widget _waTrack(String label, List<double> widths, List<Color> colors,
    MainAxisAlignment align, Color accent) {
  // Convert MainAxisAlignment to name for display
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.08),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accent)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: align,
            children: [
              for (int i = 0; i < widths.length; i++) ...[
                if (i > 0 &&
                    align != MainAxisAlignment.spaceBetween &&
                    align != MainAxisAlignment.spaceAround &&
                    align != MainAxisAlignment.spaceEvenly)
                  const SizedBox(width: 4),
                _waBlock(widths[i], colors[i % colors.length]),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _waBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_waTeal, Color(0xFF00796B)],
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
          const Icon(Icons.wrap_text, size: 48, color: _waPale),
          const SizedBox(height: 10),
          const Text('WrapAlignment',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text(
              'Controls how children are positioned within each run of a Wrap',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _waTag('rendering', _waAccent),
              _waTag('Wrap', _waBlue),
              _waTag('alignment', _waPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _waWhatIs() => [
      _waTitle('§2  What Is WrapAlignment?'),
      _waBody(
          'WrapAlignment is an enum that controls how children are '
          'positioned along the main axis within each run of a Wrap '
          'widget. A "run" is a single row (horizontal Wrap) or column '
          '(vertical Wrap) of children before wrapping occurs.'),
      _waCode(
          'enum WrapAlignment {\n'
          '  start,        // Pack children to the start\n'
          '  end,          // Pack children to the end\n'
          '  center,       // Center children in the run\n'
          '  spaceBetween, // Even space between children\n'
          '  spaceAround,  // Half-space on edges, full between\n'
          '  spaceEvenly,  // Equal space everywhere\n'
          '}'),
      _waBody(
          'Wrap uses WrapAlignment for its alignment property (main axis) '
          'and its runAlignment property (cross axis between runs). '
          'This demo focuses on the main-axis alignment behavior.'),
    ];

// ─── §3 All six values ───────────────────────────────────────────
List<Widget> _waAllValues() => [
      _waDivider(),
      _waTitle('§3  All Six Values'),
      _waBody(
          'Each value distributes free space differently along the '
          'main axis. The colored blocks represent children of '
          'varying widths:'),
      _waTrack('WrapAlignment.start',
          [60, 40, 50],
          [_waTeal, _waBlue, _waPurple],
          MainAxisAlignment.start, _waTeal),
      _waTrack('WrapAlignment.end',
          [60, 40, 50],
          [_waTeal, _waBlue, _waPurple],
          MainAxisAlignment.end, _waOrange),
      _waTrack('WrapAlignment.center',
          [60, 40, 50],
          [_waTeal, _waBlue, _waPurple],
          MainAxisAlignment.center, _waAccent),
      _waTrack('WrapAlignment.spaceBetween',
          [60, 40, 50],
          [_waTeal, _waBlue, _waPurple],
          MainAxisAlignment.spaceBetween, _waRed),
      _waTrack('WrapAlignment.spaceAround',
          [60, 40, 50],
          [_waTeal, _waBlue, _waPurple],
          MainAxisAlignment.spaceAround, _waPink),
      _waTrack('WrapAlignment.spaceEvenly',
          [60, 40, 50],
          [_waTeal, _waBlue, _waPurple],
          MainAxisAlignment.spaceEvenly, _waYellow),
    ];

// ─── §4 start ────────────────────────────────────────────────────
List<Widget> _waStart() => [
      _waDivider(),
      _waTitle('§4  WrapAlignment.start'),
      _waBody(
          'Children are packed toward the start of the main axis '
          '(left for LTR horizontal, top for vertical). All free space '
          'appears at the end. This is the default value.'),
      _waCode(
          'Wrap(\n'
          '  alignment: WrapAlignment.start,  // default\n'
          '  children: [...],\n'
          ')'),
      _waSubtitle('Visual layout'),
      _waAlignDiagram('start', [
        _WaItem(60, _waTeal),
        _WaItem(40, _waBlue),
        _WaItem(70, _waPurple),
      ], _waTeal),
      _waBullet('Use case', 'Tag lists, chip groups, form labels'),
      _waBullet('Free space', 'All trailing (right side in LTR)'),
      _waBullet('Default', 'Yes — Wrap uses start if not specified'),
    ];

// ─── §5 end ──────────────────────────────────────────────────────
List<Widget> _waEnd() => [
      _waDivider(),
      _waTitle('§5  WrapAlignment.end'),
      _waBody(
          'Children are packed toward the end of the main axis '
          '(right for LTR horizontal). All free space appears at the '
          'start. Useful for right-aligned tag groups.'),
      _waCode(
          'Wrap(\n'
          '  alignment: WrapAlignment.end,\n'
          '  children: [...],\n'
          ')'),
      _waSubtitle('Visual layout'),
      _waAlignDiagram('end', [
        _WaItem(60, _waTeal),
        _WaItem(40, _waBlue),
        _WaItem(70, _waPurple),
      ], _waOrange),
      _waBullet('Use case', 'Right-aligned actions, trailing badges'),
      _waBullet('Free space', 'All leading (left side in LTR)'),
    ];

// ─── §6 center ───────────────────────────────────────────────────
List<Widget> _waCenter() => [
      _waDivider(),
      _waTitle('§6  WrapAlignment.center'),
      _waBody(
          'Children are centered in the run. Free space is split '
          'equally between the start and end edges.'),
      _waCode(
          'Wrap(\n'
          '  alignment: WrapAlignment.center,\n'
          '  children: [...],\n'
          ')'),
      _waSubtitle('Visual layout'),
      _waAlignDiagram('center', [
        _WaItem(60, _waTeal),
        _WaItem(40, _waBlue),
        _WaItem(70, _waPurple),
      ], _waAccent),
      _waBullet('Use case',
          'Centered tag clouds, centered action buttons'),
      _waBullet('Free space', 'Equal on both sides'),
    ];

// ─── §7 spaceBetween ─────────────────────────────────────────────
List<Widget> _waSpaceBetween() => [
      _waDivider(),
      _waTitle('§7  WrapAlignment.spaceBetween'),
      _waBody(
          'Free space is distributed evenly between children. The first '
          'child touches the start edge, the last touches the end edge. '
          'No space on the outer edges.'),
      _waCode(
          'Wrap(\n'
          '  alignment: WrapAlignment.spaceBetween,\n'
          '  children: [...],\n'
          ')'),
      _waSubtitle('Visual layout'),
      _waAlignDiagram('spaceBetween', [
        _WaItem(60, _waTeal),
        _WaItem(40, _waBlue),
        _WaItem(70, _waPurple),
      ], _waRed),
      _waBullet('Use case',
          'Navigation items, evenly distributed content'),
      _waBullet('Free space', 'Only between items, not on edges'),
      _waBullet('Single child', 'Behaves like start (no gaps to distribute)'),
    ];

// ─── §8 spaceAround ──────────────────────────────────────────────
List<Widget> _waSpaceAround() => [
      _waDivider(),
      _waTitle('§8  WrapAlignment.spaceAround'),
      _waBody(
          'Each child gets equal space on both sides. This means the '
          'gap between two adjacent children is twice the gap at the '
          'edges.'),
      _waCode(
          'Wrap(\n'
          '  alignment: WrapAlignment.spaceAround,\n'
          '  children: [...],\n'
          ')'),
      _waSubtitle('Visual layout'),
      _waAlignDiagram('spaceAround', [
        _WaItem(60, _waTeal),
        _WaItem(40, _waBlue),
        _WaItem(70, _waPurple),
      ], _waPink),
      _waBullet('Use case', 'Card grids, evenly padded items'),
      _waBullet('Edge gap', 'Half the inter-item gap'),
      _waBullet('Between gap', 'Equal between each pair'),
    ];

// ─── §9 spaceEvenly ──────────────────────────────────────────────
List<Widget> _waSpaceEvenly() => [
      _waDivider(),
      _waTitle('§9  WrapAlignment.spaceEvenly'),
      _waBody(
          'Free space is distributed so that the gaps between children '
          'and the gaps at the edges are all equal. The most uniform '
          'distribution of space.'),
      _waCode(
          'Wrap(\n'
          '  alignment: WrapAlignment.spaceEvenly,\n'
          '  children: [...],\n'
          ')'),
      _waSubtitle('Visual layout'),
      _waAlignDiagram('spaceEvenly', [
        _WaItem(60, _waTeal),
        _WaItem(40, _waBlue),
        _WaItem(70, _waPurple),
      ], _waYellow),
      _waBullet('Use case',
          'Toolbar icons, navigation dots, evenly spaced elements'),
      _waBullet('All gaps', 'Identical — edges and between'),
    ];

// ─── §10 Space distribution comparison ───────────────────────────
List<Widget> _waComparison() => [
      _waDivider(),
      _waTitle('§10  Space Distribution Comparison'),
      _waBody(
          'Here is a visual comparison of how the three space-* values '
          'distribute free space differently:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _waPale,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _waLabel('Gap distribution pattern'),
            const SizedBox(height: 10),
            _waGapRow('spaceBetween', [0, 1, 1, 0], _waRed),
            _waGapRow('spaceAround', [1, 2, 2, 1], _waPink),
            _waGapRow('spaceEvenly', [1, 1, 1, 1], _waYellow),
          ],
        ),
      ),
      _waNote(
          'The numbers represent relative gap proportions. '
          'spaceBetween: edges=0, between=equal; '
          'spaceAround: edges=half, between=full; '
          'spaceEvenly: all gaps equal.'),
    ];

Widget _waGapRow(String label, List<int> gaps, Color c) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: c)),
        const SizedBox(height: 4),
        Row(
          children: [
            // Left edge gap
            _waGapUnit(gaps[0], c),
            // Block 1
            _waBlock(44, c, 'A'),
            // Gap between 1&2
            _waGapUnit(gaps[1], c),
            // Block 2
            _waBlock(44, c, 'B'),
            // Gap between 2&3
            _waGapUnit(gaps[2], c),
            // Block 3
            _waBlock(44, c, 'C'),
            // Right edge gap
            _waGapUnit(gaps[3], c),
          ],
        ),
      ],
    ),
  );
}

Widget _waGapUnit(int units, Color c) {
  if (units == 0) return const SizedBox.shrink();
  return Expanded(
    flex: units,
    child: Container(
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(3),
      ),
    ),
  );
}

// ─── alignment diagram ────────────────────────────────────────────
class _WaItem {
  final double width;
  final Color color;
  const _WaItem(this.width, this.color);
}

Widget _waAlignDiagram(String name, List<_WaItem> items, Color accent) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _waPale,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _waLabel('WrapAlignment.$name — 300px container'),
        const SizedBox(height: 10),
        Container(
          width: 300,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: accent.withValues(alpha: 0.2)),
          ),
          child: _waLayoutRow(name, items),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              width: 10,
              height: 3,
              color: accent.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 4),
            Text('free space',
                style: TextStyle(
                    fontSize: 9,
                    color: accent.withValues(alpha: 0.6))),
            const SizedBox(width: 12),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 4),
            Text('children',
                style: TextStyle(
                    fontSize: 9,
                    color: accent.withValues(alpha: 0.6))),
          ],
        ),
      ],
    ),
  );
}

Widget _waLayoutRow(String alignment, List<_WaItem> items) {
  MainAxisAlignment ma;
  switch (alignment) {
    case 'start':
      ma = MainAxisAlignment.start;
    case 'end':
      ma = MainAxisAlignment.end;
    case 'center':
      ma = MainAxisAlignment.center;
    case 'spaceBetween':
      ma = MainAxisAlignment.spaceBetween;
    case 'spaceAround':
      ma = MainAxisAlignment.spaceAround;
    case 'spaceEvenly':
      ma = MainAxisAlignment.spaceEvenly;
    default:
      ma = MainAxisAlignment.start;
  }

  return Padding(
    padding: const EdgeInsets.all(4),
    child: Row(
      mainAxisAlignment: ma,
      children: items
          .map((item) => Container(
                width: item.width,
                height: 38,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('${item.width.toInt()}',
                      style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace')),
                ),
              ))
          .toList(),
    ),
  );
}

// ─── §11 Usage with Wrap ─────────────────────────────────────────
List<Widget> _waUsage() => [
      _waDivider(),
      _waTitle('§11  Usage With Wrap Widget'),
      _waBody(
          'WrapAlignment is used in two Wrap properties:'),
      _waBullet('alignment',
          'Main-axis alignment within each run (row/column)'),
      _waBullet('runAlignment',
          'Cross-axis alignment between runs'),
      _waCode(
          'Wrap(\n'
          '  // Main-axis: how children align within one row\n'
          '  alignment: WrapAlignment.center,\n'
          '\n'
          '  // Cross-axis: how rows align within the Wrap\n'
          '  runAlignment: WrapAlignment.spaceEvenly,\n'
          '\n'
          '  // Spacing between children in a run\n'
          '  spacing: 8.0,\n'
          '\n'
          '  // Spacing between runs\n'
          '  runSpacing: 12.0,\n'
          '\n'
          '  children: [\n'
          '    Chip(label: Text("Flutter")),\n'
          '    Chip(label: Text("Dart")),\n'
          '    Chip(label: Text("Widgets")),\n'
          '  ],\n'
          ')'),
      _waNote(
          'The spacing property adds fixed gaps between children, while '
          'WrapAlignment distributes any remaining free space. Both '
          'work together — spacing is added first, then alignment '
          'distributes leftover space.'),
    ];

// ─── §12 RTL behavior ────────────────────────────────────────────
List<Widget> _waRtl() => [
      _waDivider(),
      _waTitle('§12  RTL Behavior'),
      _waBody(
          'WrapAlignment respects text direction. In RTL layouts, '
          '"start" means the right edge:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _waPale,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _waLabel('LTR vs RTL with WrapAlignment.start'),
            const SizedBox(height: 10),
            _waRtlRow('LTR — start = left', MainAxisAlignment.start, false,
                _waTeal),
            const SizedBox(height: 8),
            _waRtlRow('RTL — start = right', MainAxisAlignment.end, true,
                _waOrange),
          ],
        ),
      ),
      _waCode(
          '// In RTL context:\n'
          '// WrapAlignment.start -> right edge\n'
          '// WrapAlignment.end   -> left edge\n'
          '// center, spaceBetween, etc. are symmetric'),
    ];

Widget _waRtlRow(
    String label, MainAxisAlignment align, bool isRtl, Color c) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: c)),
      const SizedBox(height: 4),
      Container(
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: c.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: align,
          children: [
            _waBlock(50, c, isRtl ? 'C' : 'A'),
            const SizedBox(width: 4),
            _waBlock(35, c, 'B'),
            const SizedBox(width: 4),
            _waBlock(45, c, isRtl ? 'A' : 'C'),
          ],
        ),
      ),
    ],
  );
}

// ─── §13 Summary ─────────────────────────────────────────────────
List<Widget> _waSummary() => [
      _waDivider(),
      _waTitle('§13  Summary'),
      _waBody(
          'WrapAlignment provides six strategies for distributing '
          'children within a Wrap run.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _waTeal.withValues(alpha: 0.07),
              _waPale,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _waTeal.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _waTeal)),
            const SizedBox(height: 10),
            _waSumPt('start',
                'Pack to start edge (default)'),
            _waSumPt('end',
                'Pack to end edge'),
            _waSumPt('center',
                'Center in run, equal space on both sides'),
            _waSumPt('spaceBetween',
                'Even space between items, none at edges'),
            _waSumPt('spaceAround',
                'Half-space at edges, full space between'),
            _waSumPt('spaceEvenly',
                'All gaps equal — edges and between'),
            _waSumPt('RTL-aware',
                'Start/end flip with text direction'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _waTeal,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of WrapAlignment Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _waSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _waAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _waTeal)),
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
        _waBanner(),
        const SizedBox(height: 20),
        ..._waWhatIs(),
        ..._waAllValues(),
        ..._waStart(),
        ..._waEnd(),
        ..._waCenter(),
        ..._waSpaceBetween(),
        ..._waSpaceAround(),
        ..._waSpaceEvenly(),
        ..._waComparison(),
        ..._waUsage(),
        ..._waRtl(),
        ..._waSummary(),
      ],
    ),
  );
}
