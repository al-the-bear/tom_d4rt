// ignore_for_file: avoid_print
// D4rt deep demo: OrderedTraversalPolicy — focus traversal policy respecting FocusTraversalOrder
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Juniper / Spruce ──────────────────────────────────────
  const deepJuniper = Color(0xFF1B5E20);
  const juniper = Color(0xFF2E7D32);
  const spruce = Color(0xFF388E3C);
  const softJuniper = Color(0xFF43A047);
  const lightSpruce = Color(0xFFA5D6A7);
  const paleJuniper = Color(0xFFE8F5E9);
  const whiteSpruce = Color(0xFFF1F8F2);
  const darkForest = Color(0xFF0D2B10);
  const accentBrown = Color(0xFF4E342E);
  const accentIndigo = Color(0xFF283593);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkForest)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkForest)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('OrderedTraversalPolicy deep demo executing');
  print('=' * 60);

  print('\n--- What is OrderedTraversalPolicy ---');
  print('A FocusTraversalPolicy that respects FocusTraversalOrder');
  print('Constructor: OrderedTraversalPolicy({secondary, requestFocusCallback})');
  print('Extends FocusTraversalPolicy');
  print('Mixes in DirectionalFocusTraversalPolicyMixin');

  print('\n--- sortDescendants algorithm ---');
  print('1. Sort ALL nodes by secondary policy (default: ReadingOrder)');
  print('2. Split into ordered (have FocusTraversalOrder) and unordered');
  print('3. Stable mergeSort ordered by FocusOrder.compareTo()');
  print('4. Return: ordered first, then unordered');

  print('\n--- Related widgets ---');
  print('FocusTraversalGroup — defines policy scope');
  print('FocusTraversalOrder — assigns FocusOrder to a node');
  print('NumericFocusOrder — concrete order using double');
  print('LexicalFocusOrder — concrete order using String');

  print('\n--- Other policies ---');
  print('WidgetOrderTraversalPolicy — widget creation order');
  print('ReadingOrderTraversalPolicy — LTR/RTL reading order');

  print('\n${'=' * 60}');
  print('OrderedTraversalPolicy deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepJuniper, juniper, spruce],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sort, size: 28, color: lightSpruce),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OrderedTraversalPolicy',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('The only FocusTraversalPolicy that respects '
                  'FocusTraversalOrder widgets — sorts focus nodes by '
                  'their assigned FocusOrder, with a secondary policy '
                  'for unordered nodes',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('FocusTraversalPolicy', juniper, Colors.white),
                tag('sortDescendants()', softJuniper, darkForest),
                tag('secondary', lightSpruce, darkForest),
                tag('FocusTraversalOrder', paleJuniper, darkForest),
              ]),
            ],
          ),
        ),

        // ── 2. What is OrderedTraversalPolicy ────────────────────────
        sectionBanner('1 \u00b7 What Is OrderedTraversalPolicy',
            'The policy that brings explicit focus ordering to life',
            deepJuniper, Colors.white),
        noteBox(
          'OrderedTraversalPolicy extends FocusTraversalPolicy and mixes '
          'in DirectionalFocusTraversalPolicyMixin. It is the only '
          'built-in policy that reads FocusTraversalOrder widgets from '
          'the tree and sorts focus nodes by their assigned FocusOrder '
          '(NumericFocusOrder, LexicalFocusOrder, or custom). Nodes '
          'without a FocusTraversalOrder ancestor are sorted by a '
          'configurable secondary policy.',
          juniper,
          whiteSpruce,
        ),
        dataRow('Type',
            'class OrderedTraversalPolicy extends FocusTraversalPolicy '
            'with DirectionalFocusTraversalPolicyMixin',
            juniper),
        dataRow('Constructor',
            'OrderedTraversalPolicy({this.secondary, super.requestFocusCallback})',
            deepJuniper),
        dataRow('secondary',
            'FocusTraversalPolicy? — defaults to ReadingOrderTraversalPolicy',
            spruce),
        dataRow('Key method', 'sortDescendants()', softJuniper),
        dataRow('Defined in', 'widgets/focus_traversal.dart line 1882', darkForest),
        const SizedBox(height: 14),

        // ── 3. Class hierarchy ───────────────────────────────────────
        sectionBanner('2 \u00b7 The Policy Hierarchy',
            'Focus traversal policies in Flutter',
            juniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('FocusTraversalPolicy (abstract)', deepJuniper, true),
                ('\u2514\u2500 WidgetOrderTraversalPolicy', spruce, false),
                ('\u2514\u2500 ReadingOrderTraversalPolicy', softJuniper, false),
                ('\u2514\u2500 OrderedTraversalPolicy', juniper, true),
                ('DirectionalFocusTraversalPolicyMixin', accentIndigo, false),
                ('  (mixed into OrderedTraversalPolicy)', accentIndigo, false),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: level.$3
                        ? level.$2.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: level.$2, width: 2)),
                  ),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          fontWeight:
                              level.$3 ? FontWeight.bold : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. sortDescendants algorithm ─────────────────────────────
        sectionBanner('3 \u00b7 The sortDescendants() Algorithm',
            'Four-step sorting process',
            spruce, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSpruce),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 4; i++)
                ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: [juniper, spruce, deepJuniper, softJuniper][i]
                          .withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: [juniper, spruce, deepJuniper, softJuniper][i]),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: [juniper, spruce, deepJuniper, softJuniper][i],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text([
                                'Sort ALL by secondary',
                                'Split into ordered + unordered',
                                'Stable mergeSort ordered',
                                'Return: ordered then unordered',
                              ][i],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: [
                                        juniper,
                                        spruce,
                                        deepJuniper,
                                        softJuniper
                                      ][i])),
                              Text([
                                'Sort entire list of focus nodes using the '
                                'secondary policy (default: ReadingOrder). '
                                'This establishes a baseline order.',
                                'Walk the secondary-sorted list. Each node '
                                'that has a FocusTraversalOrder ancestor goes '
                                'into "ordered". Others go to "unordered".',
                                'Stable mergeSort on the ordered list using '
                                'FocusOrder.compareTo(). Stable sort preserves '
                                'secondary order for equal FocusOrder values.',
                                'Concatenate: ordered nodes first, then '
                                'unordered nodes. Tab visits ordered nodes in '
                                'FocusOrder, then unordered in secondary order.',
                              ][i],
                                  style: TextStyle(
                                      fontSize: 11, color: darkForest)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < 3)
                    Center(
                      child: Icon(Icons.arrow_downward,
                          size: 14, color: lightSpruce),
                    ),
                ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. FocusTraversalGroup usage ─────────────────────────────
        sectionBanner('4 \u00b7 Setting Up With FocusTraversalGroup',
            'How to activate OrderedTraversalPolicy',
            deepJuniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepJuniper.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepJuniper.withValues(alpha: 0.3)),
            ),
            child: Text(
                'FocusTraversalGroup(\n'
                '  policy: OrderedTraversalPolicy(\n'
                '    secondary:\n'
                '      ReadingOrderTraversalPolicy(),\n'
                '  ),\n'
                '  child: Column(\n'
                '    children: [\n'
                '      FocusTraversalOrder(\n'
                '        order: NumericFocusOrder(2.0),\n'
                '        child: TextField(/*...*/),\n'
                '      ),\n'
                '      FocusTraversalOrder(\n'
                '        order: NumericFocusOrder(1.0),\n'
                '        child: TextField(/*...*/),\n'
                '      ),\n'
                '      TextField(/*unordered*/),\n'
                '    ],\n'
                '  ),\n'
                ')',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepJuniper)),
          ),
        ),
        noteBox(
          'The third TextField has no FocusTraversalOrder, so it goes '
          'to the unordered group. Tab order becomes: NumericFocusOrder(1), '
          'NumericFocusOrder(2), then unordered.',
          deepJuniper,
          paleJuniper,
        ),
        const SizedBox(height: 14),

        // ── 6. Live demo: ordered vs unordered ───────────────────────
        sectionBanner('5 \u00b7 Live Demo: Ordered vs Unordered Nodes',
            'How ordered nodes come first, then unordered',
            juniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSpruce),
          ),
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: softJuniper.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: softJuniper),
                  ),
                  child: Text(
                      'Tab order: Ordered(1) \u2192 Ordered(2) \u2192 Ordered(3) '
                      '\u2192 Unordered A \u2192 Unordered B',
                      style: TextStyle(
                          fontSize: 10, color: darkForest)),
                ),
                const SizedBox(height: 8),
                // Unordered A placed visually first
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: accentBrown.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(
                            color: accentBrown, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: accentBrown,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('no order',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 28,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentBrown,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2),
                            ),
                            child: const Text('Unordered A (tab 4th)',
                                style: TextStyle(fontSize: 9)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Ordered 3
                FocusTraversalOrder(
                  order: const NumericFocusOrder(3.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: spruce.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border(
                          left: BorderSide(
                              color: spruce, width: 3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: spruce,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('3.0',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 28,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: spruce,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2),
                              ),
                              child: const Text('Ordered 3 (tab 3rd)',
                                  style: TextStyle(fontSize: 9)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Ordered 1
                FocusTraversalOrder(
                  order: const NumericFocusOrder(1.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: deepJuniper.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border(
                          left: BorderSide(
                              color: deepJuniper, width: 3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: deepJuniper,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('1.0',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 28,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: deepJuniper,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2),
                              ),
                              child: const Text('Ordered 1 (tab 1st)',
                                  style: TextStyle(fontSize: 9)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Unordered B
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: accentBrown.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(
                            color: accentBrown, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: accentBrown,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('no order',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 28,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentBrown,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2),
                            ),
                            child: const Text('Unordered B (tab 5th)',
                                style: TextStyle(fontSize: 9)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Ordered 2
                FocusTraversalOrder(
                  order: const NumericFocusOrder(2.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: juniper.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border(
                          left: BorderSide(
                              color: juniper, width: 3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: juniper,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('2.0',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 28,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: juniper,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2),
                              ),
                              child: const Text('Ordered 2 (tab 2nd)',
                                  style: TextStyle(fontSize: 9)),
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
        ),
        noteBox(
          'Visual order: Unordered A, Ordered(3), Ordered(1), Unordered B, '
          'Ordered(2). Tab order: Ordered(1), Ordered(2), Ordered(3), '
          'Unordered A, Unordered B. Ordered first by FocusOrder, then '
          'unordered by secondary (reading order).',
          juniper,
          paleJuniper,
        ),
        const SizedBox(height: 14),

        // ── 7. Secondary policy configuration ────────────────────────
        sectionBanner('6 \u00b7 Configuring the Secondary Policy',
            'What happens to unordered nodes',
            spruce, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final sec in [
                ('ReadingOrderTraversalPolicy (default)',
                    'Unordered nodes sorted in reading order (LTR/RTL). '
                    'Most intuitive for standard layouts.',
                    Icons.menu_book, juniper),
                ('WidgetOrderTraversalPolicy',
                    'Unordered nodes sorted by widget tree creation order. '
                    'Useful when visual layout differs from source order.',
                    Icons.reorder, spruce),
                ('Another OrderedTraversalPolicy',
                    'Even nested ordering is possible — though rarely needed.',
                    Icons.sort, accentIndigo),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sec.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: sec.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(sec.$3, size: 18, color: sec.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sec.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: sec.$4)),
                            Text(sec.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkForest)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Policy comparison ─────────────────────────────────────
        sectionBanner('7 \u00b7 All Three Policies Compared',
            'Choosing the right traversal policy',
            deepJuniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepJuniper),
                children: [
                  for (final h in ['Policy', 'Sort Method', 'Honors Order?'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('WidgetOrder', 'Widget creation order', 'No', spruce),
                ('ReadingOrder', 'Visual LTR/RTL position', 'No', softJuniper),
                ('Ordered', 'FocusOrder + secondary', 'Yes', juniper),
              ])
                TableRow(
                  decoration: row.$1 == 'Ordered'
                      ? BoxDecoration(
                          color: juniper.withValues(alpha: 0.06))
                      : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('${row.$1}TraversalPolicy',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              fontWeight: row.$1 == 'Ordered'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: row.$4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkForest)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: row.$3 == 'Yes'
                                  ? accentIndigo
                                  : accentBrown)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. DirectionalFocusTraversalPolicyMixin ──────────────────
        sectionBanner('8 \u00b7 Directional Focus Support',
            'Arrow key navigation mixed into OrderedTraversalPolicy',
            juniper, Colors.white),
        noteBox(
          'OrderedTraversalPolicy mixes in '
          'DirectionalFocusTraversalPolicyMixin, which adds support for '
          'arrow key navigation (up/down/left/right). This mixin uses '
          'the physical position of focus nodes on screen to determine '
          'which node to move to when arrow keys are pressed. This is '
          'independent of Tab traversal order.',
          juniper,
          whiteSpruce,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: juniper.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: juniper),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.tab, size: 20, color: juniper),
                      const SizedBox(height: 4),
                      Text('Tab / Shift+Tab',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: juniper)),
                      const SizedBox(height: 4),
                      Text('Uses FocusOrder\nsequence from\nsortDescendants',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkForest)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentIndigo.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentIndigo),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_forward, size: 20,
                          color: accentIndigo),
                      const SizedBox(height: 4),
                      Text('Arrow Keys',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentIndigo)),
                      const SizedBox(height: 4),
                      Text('Uses physical\nposition from\nDirectionalMixin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkForest)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Stable sort behavior ─────────────────────────────────
        sectionBanner('9 \u00b7 Stable Sort Behavior',
            'Why order is preserved for equal FocusOrder values',
            spruce, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noteBox(
                'mergeSort is a stable sort. When two nodes have the same '
                'FocusOrder value (compareTo returns 0), their relative '
                'order from the secondary sort is preserved. This means '
                'within the same priority, nodes appear in reading/widget '
                'order.',
                spruce,
                paleJuniper,
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: spruce.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: spruce.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'Input (after secondary sort):\n'
                    '  A(order=2), B(order=1), C(order=2)\n'
                    '\n'
                    'After stable mergeSort by FocusOrder:\n'
                    '  B(order=1), A(order=2), C(order=2)\n'
                    '\n'
                    'A stays before C because A came first\n'
                    'in the secondary sort (stable).',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: darkForest)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Nested groups ────────────────────────────────────────
        sectionBanner('10 \u00b7 Nested FocusTraversalGroups',
            'How groups create independent ordering scopes',
            deepJuniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepJuniper.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: deepJuniper),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Outer Group (OrderedTraversalPolicy)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: deepJuniper)),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: juniper.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: juniper),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Inner Group A (own policy)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: juniper)),
                          Text('Nodes sorted within this scope',
                              style: TextStyle(
                                  fontSize: 10, color: darkForest)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: spruce.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: spruce),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Inner Group B (own policy)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: spruce)),
                          Text('Independent ordering scope',
                              style: TextStyle(
                                  fontSize: 10, color: darkForest)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              noteBox(
                'Each FocusTraversalGroup creates an independent ordering '
                'scope. Tab traverses all nodes in Group A (in its policy '
                'order), then all nodes in Group B. The outer group\u0027s '
                'FocusOrder determines which group comes first.',
                deepJuniper,
                paleJuniper,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. requestFocusCallback ─────────────────────────────────
        sectionBanner('11 \u00b7 requestFocusCallback',
            'Customizing how focus is requested',
            juniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: juniper.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: juniper.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'OrderedTraversalPolicy(\n'
                    '  requestFocusCallback:\n'
                    '      (node, {alignmentPolicy,\n'
                    '       curve, duration}) {\n'
                    '    node.requestFocus();\n'
                    '    // Custom scroll behavior,\n'
                    '    // analytics, logging, etc.\n'
                    '  },\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: juniper)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'The requestFocusCallback parameter lets you customize '
                'what happens when focus moves to a node. By default it '
                'calls node.requestFocus() with Scrollable.ensureVisible. '
                'You can add animations, logging, or custom scroll behavior.',
                juniper,
                paleJuniper,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Live demo: form with mixed ordering ──────────────────
        sectionBanner('12 \u00b7 Live Demo: Form With Mixed Ordering',
            'Real-world form using numeric focus orders',
            spruce, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSpruce),
          ),
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Column(
              children: [
                for (final field in [
                  ('Name', 1.0, Icons.person, deepJuniper),
                  ('Email', 2.0, Icons.email, juniper),
                  ('Phone', 3.0, Icons.phone, spruce),
                  ('Address', 4.0, Icons.home, softJuniper),
                  ('City', 5.0, Icons.location_city, accentBrown),
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: FocusTraversalOrder(
                      order: NumericFocusOrder(field.$2),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: field.$4,
                              borderRadius:
                                  BorderRadius.circular(4),
                            ),
                            child: Text('${field.$2.toInt()}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 6),
                          Icon(field.$3, size: 16,
                              color: field.$4),
                          const SizedBox(width: 6),
                          Expanded(
                            child: SizedBox(
                              height: 34,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: field.$1,
                                  labelStyle: TextStyle(
                                      fontSize: 11, color: field.$4),
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: field.$4, width: 2),
                                  ),
                                ),
                                style: TextStyle(
                                    fontSize: 12, color: darkForest),
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
        ),
        const SizedBox(height: 14),

        // ── 14. Performance notes ────────────────────────────────────
        sectionBanner('13 \u00b7 Performance Characteristics',
            'Cost and efficiency', deepJuniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Sort cost', 'O(n log n) mergeSort on ordered nodes',
                    Icons.sort, juniper),
                ('Secondary sort', 'O(n log n) on all nodes before split',
                    Icons.low_priority, spruce),
                ('Ancestor lookup', 'FocusTraversalOrder.of() walks ancestors '
                    'once per node',
                    Icons.search, deepJuniper),
                ('Memory', 'Two temporary lists (ordered + unordered)',
                    Icons.memory, accentBrown),
                ('Per-frame', 'Only runs when Tab is pressed, not every frame',
                    Icons.timer, accentIndigo),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: perf.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: perf.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(perf.$3, size: 16, color: perf.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${perf.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: perf.$4)),
                            TextSpan(
                                text: perf.$2,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: darkForest)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Common patterns ──────────────────────────────────────
        sectionBanner('14 \u00b7 Common Patterns',
            'Real-world usage scenarios',
            juniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSpruce,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pattern in [
                ('Multi-step form', 'Name(1) \u2192 Email(2) \u2192 Password(3) '
                    '\u2192 Submit(4). Skip decorative elements.',
                    Icons.assignment, juniper),
                ('Toolbar ordering', 'Primary actions first, secondary actions '
                    'last. Unordered items fall to the end.',
                    Icons.build, spruce),
                ('Dashboard panels', 'Important panels get low order numbers. '
                    'Less important ones are unordered.',
                    Icons.dashboard, deepJuniper),
                ('Settings page', 'Critical settings first (1-3), advanced '
                    'settings unordered at the bottom.',
                    Icons.settings, softJuniper),
                ('Grid layout', 'Override column-by-column reading order. '
                    'Force row-by-row traversal with numeric orders.',
                    Icons.grid_view, accentIndigo),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: pattern.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: pattern.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(pattern.$3, size: 18,
                          color: pattern.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pattern.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: pattern.$4)),
                            Text(pattern.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkForest)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepJuniper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepJuniper, juniper],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'The ONLY policy that respects FocusTraversalOrder widgets',
                'sortDescendants: secondary sort, split, stable mergeSort, concat',
                'Ordered nodes come first, unordered nodes follow',
                'Secondary policy defaults to ReadingOrderTraversalPolicy',
                'Stable sort preserves secondary order for equal FocusOrder',
                'Mixes in DirectionalFocusTraversalPolicyMixin for arrow keys',
                'FocusTraversalGroup creates independent ordering scopes',
                'requestFocusCallback customizes focus transition behavior',
                'Works with NumericFocusOrder and LexicalFocusOrder (not mixed)',
                'Only runs on Tab press — no per-frame overhead',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightSpruce,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
