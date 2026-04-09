// ignore_for_file: avoid_print
// D4rt deep demo: LexicalFocusOrder — string-based focus traversal ordering
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Gold / Saffron palette ─────────────────────────────────────────
  final deepGold = const Color(0xFF8D6E00);
  final warmSaffron = const Color(0xFFD4A017);
  final goldenrod = const Color(0xFFDAA520);
  final marigold = const Color(0xFFEAA221);
  final sunflower = const Color(0xFFF4C430);
  final buttercup = const Color(0xFFF9D949);
  final champagne = const Color(0xFFF7E7A1);
  final wheat = const Color(0xFFF5DEB3);
  final canaryLight = const Color(0xFFFFF9C4);
  final amberGlow = const Color(0xFFFFD54F);

  // ── helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: 0.3)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: fg.withValues(alpha: 0.75),
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: border, height: 1.5)),
    );
  }

  Widget infoCard(String label, String value, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Text(value,
              style: TextStyle(
                  fontSize: 11,
                  color: accent.withValues(alpha: 0.8),
                  fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
    );
  }

  Widget dataRow(String key, String val, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
            child: Text(key,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.8),
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black12),
          ),
        ),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(fontSize: 8, color: Colors.black54)),
      ],
    );
  }

  Widget orderChip(String order, int rank, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: fg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text('$rank',
                style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
          const SizedBox(width: 6),
          Text('"$order"',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: fg,
                  fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget comparisonRow(String left, String op, String right, String result, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text('"$left"',
                style: TextStyle(
                    fontSize: 11,
                    color: accent,
                    fontFamily: 'monospace')),
          ),
          SizedBox(
            width: 30,
            child: Text(op,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accent)),
          ),
          SizedBox(
            width: 80,
            child: Text('"$right"',
                style: TextStyle(
                    fontSize: 11,
                    color: accent,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            child: Text('→ $result',
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }

  Widget hierarchyRow(String indent, String name, Color accent, bool highlight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: highlight ? accent.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: highlight ? Border.all(color: accent.withValues(alpha: 0.3)) : null,
      ),
      child: Text('$indent$name',
          style: TextStyle(
              fontSize: 11,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              color: highlight ? accent : accent.withValues(alpha: 0.7),
              fontFamily: 'monospace')),
    );
  }

  Widget metricTile(String label, String value, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: fg)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 9, color: fg.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  // ── data ───────────────────────────────────────────────────────────
  print('LexicalFocusOrder deep demo executing');
  print('=' * 60);

  // Section 3 — basic creation
  final orderA = LexicalFocusOrder('a');
  final orderB = LexicalFocusOrder('b');
  final orderC = LexicalFocusOrder('c');
  final orderZ = LexicalFocusOrder('z');
  print('\n--- Basic creation ---');
  print('orderA.order: ${orderA.order}');
  print('orderB.order: ${orderB.order}');
  print('orderC.order: ${orderC.order}');
  print('orderZ.order: ${orderZ.order}');

  // Section 4 — string ordering
  final orderAbc = LexicalFocusOrder('abc');
  final orderAbd = LexicalFocusOrder('abd');
  final orderXyz = LexicalFocusOrder('xyz');
  print('\n--- String ordering ---');
  print('orderAbc.order: ${orderAbc.order}');
  print('orderAbd.order: ${orderAbd.order}');
  print('orderXyz.order: ${orderXyz.order}');

  // Section 5 — numerical strings
  final num1 = LexicalFocusOrder('1');
  final num2 = LexicalFocusOrder('2');
  final num10 = LexicalFocusOrder('10');
  final num9 = LexicalFocusOrder('9');
  print('\n--- Numerical strings ---');
  print('num1.order: ${num1.order}');
  print('num2.order: ${num2.order}');
  print('num10.order: ${num10.order}');
  print('num9.order: ${num9.order}');
  print('Lexical: "10" < "2" < "9" (string comparison)');

  // Section 6 — empty string
  final empty = LexicalFocusOrder('');
  print('\n--- Empty string ---');
  print('empty.order: "${empty.order}"');
  print('Empty string sorts before everything');

  // Section 7 — special characters
  final underscore = LexicalFocusOrder('_item');
  final tilde = LexicalFocusOrder('~item');
  final space = LexicalFocusOrder(' item');
  final excl = LexicalFocusOrder('!item');
  print('\n--- Special characters ---');
  print('underscore: ${underscore.order}');
  print('tilde: ${tilde.order}');
  print('space: "${space.order}"');
  print('exclamation: ${excl.order}');

  // Section 8 — comparison behavior
  print('\n--- Comparison ---');
  print('Is FocusOrder: true');

  // Section 9 — inheritance
  print('\n--- Inheritance ---');
  print('LexicalFocusOrder extends FocusOrder');
  print('FocusOrder extends Diagnosticable');

  // Section 10 — FocusTraversalOrder
  print('\n--- FocusTraversalOrder widget ---');
  print('Wraps child with a focus order');
  print('Used with OrderedTraversalPolicy');

  // Section 11 — sorting
  final items = ['banana', 'apple', 'cherry', 'date', 'elderberry'];
  final sorted = List.of(items)..sort();
  print('\n--- Sorting simulation ---');
  print('Original: $items');
  print('Sorted: $sorted');

  // Section 12 — case sensitivity
  final lower = LexicalFocusOrder('apple');
  final upper = LexicalFocusOrder('Apple');
  final mixed = LexicalFocusOrder('aPPLE');
  print('\n--- Case sensitivity ---');
  print('lower: ${lower.order}');
  print('upper: ${upper.order}');
  print('mixed: ${mixed.order}');
  print('Uppercase letters sort before lowercase in ASCII');

  // Section 13 — unicode
  final umlaut = LexicalFocusOrder('\u00FC'); // ü
  final sharp = LexicalFocusOrder('\u00DF'); // ß
  print('\n--- Unicode ---');
  print('umlaut: ${umlaut.order}');
  print('sharp-s: ${sharp.order}');

  // Section 14 — real-world patterns
  print('\n--- Real-world patterns ---');
  print('Menu items: "01-file", "02-edit", "03-view"');
  print('Form fields: "a-name", "b-email", "c-phone"');
  print('Tabs: "tab-01", "tab-02", "tab-03"');

  // Section 15 — vs NumericFocusOrder
  final numeric1 = NumericFocusOrder(1);
  final numeric10 = NumericFocusOrder(10);
  final numeric2 = NumericFocusOrder(2);
  print('\n--- Vs NumericFocusOrder ---');
  print('Numeric 1: ${numeric1.order}');
  print('Numeric 10: ${numeric10.order}');
  print('Numeric 2: ${numeric2.order}');
  print('Numeric sorts: 1 < 2 < 10');
  print('Lexical sorts: "1" < "10" < "2"');

  print('\n${'=' * 60}');
  print('LexicalFocusOrder deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        sectionBanner(
          '1 · LexicalFocusOrder Showcase',
          'String-based focus traversal ordering for widgets',
          deepGold,
          Colors.white,
        ),

        // ── 2. Concept overview ──────────────────────────────────────
        sectionBanner('2 · Concept Overview',
            'Understanding lexical focus ordering', goldenrod, Colors.white),
        noteBox(
          'LexicalFocusOrder defines focus traversal order using string '
          'comparison. When widgets are wrapped with FocusTraversalOrder '
          'and an OrderedTraversalPolicy, the focus moves between them '
          'in lexicographic (dictionary) order of their order strings.',
          deepGold,
          canaryLight,
        ),
        noteBox(
          'Lexical ordering follows standard string comparison rules: '
          'character by character, using Unicode code points. This means '
          '"a" < "b", "abc" < "abd", and "10" < "2" (since "1" < "2" '
          'at the first character).',
          goldenrod,
          wheat,
        ),
        infoCard('Class', 'LexicalFocusOrder', deepGold),
        infoCard('Parent', 'FocusOrder', warmSaffron),
        infoCard('Property', 'String order', goldenrod),
        infoCard('Comparison', 'String.compareTo()', marigold),
        infoCard('Package', 'flutter/widgets.dart', sunflower),
        const SizedBox(height: 14),

        // ── 3. Basic creation ────────────────────────────────────────
        sectionBanner('3 · Basic Creation',
            'Creating LexicalFocusOrder instances', warmSaffron, Colors.white),
        noteBox(
          'Create a LexicalFocusOrder by passing a string that determines '
          'its position in the traversal order. Single characters provide '
          'simple A-Z ordering.',
          deepGold,
          canaryLight,
        ),
        dataRow('orderA.order', '"${orderA.order}"', deepGold),
        dataRow('orderB.order', '"${orderB.order}"', warmSaffron),
        dataRow('orderC.order', '"${orderC.order}"', goldenrod),
        dataRow('orderZ.order', '"${orderZ.order}"', marigold),
        dataRow('runtimeType', '${orderA.runtimeType}', sunflower),
        const SizedBox(height: 8),
        Wrap(children: [
          orderChip('a', 1, canaryLight, deepGold),
          orderChip('b', 2, wheat, warmSaffron),
          orderChip('c', 3, canaryLight, goldenrod),
          orderChip('z', 26, wheat, marigold),
        ]),
        const SizedBox(height: 14),

        // ── 4. String order panel ────────────────────────────────────
        sectionBanner('4 · Multi-Character Ordering',
            'How longer strings compare', marigold, Colors.white),
        noteBox(
          'Multi-character strings are compared character by character. '
          'The first differing character determines the order. If one '
          'string is a prefix of another, the shorter string sorts first.',
          deepGold,
          canaryLight,
        ),
        dataRow('orderAbc', '"${orderAbc.order}"', deepGold),
        dataRow('orderAbd', '"${orderAbd.order}"', warmSaffron),
        dataRow('orderXyz', '"${orderXyz.order}"', goldenrod),
        const SizedBox(height: 8),
        comparisonRow('abc', '<', 'abd', 'c < d at position 2', deepGold),
        comparisonRow('abc', '<', 'xyz', 'a < x at position 0', warmSaffron),
        comparisonRow('a', '<', 'abc', 'prefix sorts first', goldenrod),
        comparisonRow('abd', '<', 'xyz', 'a < x at position 0', marigold),
        const SizedBox(height: 8),
        Wrap(children: [
          orderChip('abc', 1, canaryLight, deepGold),
          orderChip('abd', 2, wheat, warmSaffron),
          orderChip('xyz', 3, canaryLight, goldenrod),
        ]),
        const SizedBox(height: 14),

        // ── 5. Numerical strings ─────────────────────────────────────
        sectionBanner('5 · Numerical String Gotcha',
            'Why "10" sorts before "2"', sunflower, deepGold),
        noteBox(
          'Lexical ordering does NOT understand numbers. The string "10" '
          'sorts before "2" because "1" < "2" at the first character. '
          'If you need numeric ordering, use NumericFocusOrder instead '
          'or zero-pad your numbers ("01", "02", "10").',
          deepGold,
          canaryLight,
        ),
        dataRow('num1.order', '"${num1.order}"', deepGold),
        dataRow('num2.order', '"${num2.order}"', warmSaffron),
        dataRow('num9.order', '"${num9.order}"', goldenrod),
        dataRow('num10.order', '"${num10.order}"', marigold),
        const SizedBox(height: 8),
        Text('Lexical sort: "1" < "10" < "2" < "9"',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: deepGold)),
        const SizedBox(height: 4),
        Text('Numeric sort: 1 < 2 < 9 < 10',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: warmSaffron)),
        const SizedBox(height: 8),
        Wrap(children: [
          orderChip('1', 1, canaryLight, deepGold),
          orderChip('10', 2, wheat, warmSaffron),
          orderChip('2', 3, canaryLight, goldenrod),
          orderChip('9', 4, wheat, marigold),
        ]),
        noteBox(
          'Zero-padding fix: "01" < "02" < "09" < "10" — this restores '
          'numeric ordering within lexical comparison. Use this pattern '
          'when you need numbered ordering with LexicalFocusOrder.',
          sunflower,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 6. Empty string behavior ─────────────────────────────────
        sectionBanner('6 · Empty String Behavior',
            'The lowest possible order value', deepGold, Colors.white),
        noteBox(
          'An empty string sorts before all non-empty strings in lexical '
          'comparison. This makes LexicalFocusOrder("") the first item '
          'in any traversal order.',
          deepGold,
          canaryLight,
        ),
        dataRow('empty.order', '"${empty.order}" (empty)', deepGold),
        dataRow('Length', '${empty.order.length}', warmSaffron),
        const SizedBox(height: 8),
        comparisonRow('', '<', 'a', 'Empty < any char', deepGold),
        comparisonRow('', '<', '!', 'Empty < punctuation', warmSaffron),
        comparisonRow('', '<', ' ', 'Empty < space', goldenrod),
        noteBox(
          'Edge case: Empty string is valid but rarely useful in practice. '
          'Most focus orders use descriptive labels or coded positions.',
          marigold,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 7. Special characters ────────────────────────────────────
        sectionBanner('7 · Special Character Ordering',
            'Punctuation and symbols in order strings', goldenrod, Colors.white),
        noteBox(
          'Special characters sort by their Unicode code point. Common '
          'order: space (32) < ! (33) < 0-9 (48-57) < A-Z (65-90) < '
          'a-z (97-122) < ~ (126). This affects ordering when using '
          'prefixes with special characters.',
          deepGold,
          canaryLight,
        ),
        dataRow('underscore "_item"', underscore.order, deepGold),
        dataRow('tilde "~item"', tilde.order, warmSaffron),
        dataRow('space " item"', '"${space.order}"', goldenrod),
        dataRow('exclamation "!item"', excl.order, marigold),
        const SizedBox(height: 8),
        Wrap(children: [
          orderChip(' item', 1, canaryLight, deepGold),
          orderChip('!item', 2, wheat, warmSaffron),
          orderChip('_item', 3, canaryLight, goldenrod),
          orderChip('~item', 4, wheat, marigold),
        ]),
        noteBox(
          'ASCII order for common prefixes: space < ! < # < 0-9 < '
          'A-Z < _ < a-z < ~. Use this knowledge to create predictable '
          'ordering with prefix conventions.',
          sunflower,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 8. Comparison behavior ───────────────────────────────────
        sectionBanner('8 · doCompare Internals',
            'How comparison works under the hood', buttercup, deepGold),
        noteBox(
          'LexicalFocusOrder.doCompare() uses Dart\'s String.compareTo() '
          'method. It returns negative if this < other, zero if equal, '
          'and positive if this > other. The comparison is ordinal '
          '(Unicode code point based), not locale-aware.',
          deepGold,
          canaryLight,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepGold.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepGold.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comparison Rules',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepGold)),
              const SizedBox(height: 8),
              dataRow('Method', 'doCompare(FocusOrder other)', deepGold),
              dataRow('Casts to', 'LexicalFocusOrder', warmSaffron),
              dataRow('Delegates to', 'order.compareTo(other.order)', goldenrod),
              dataRow('Return', 'int (neg/zero/pos)', marigold),
              const SizedBox(height: 6),
              dataRow('Locale-aware', 'No (ordinal only)', sunflower),
              dataRow('Case-sensitive', 'Yes (A ≠ a)', buttercup),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Inheritance panel ─────────────────────────────────────
        sectionBanner('9 · Inheritance Hierarchy',
            'FocusOrder class family', warmSaffron, Colors.white),
        noteBox(
          'LexicalFocusOrder is one of two built-in FocusOrder subclasses. '
          'FocusOrder is abstract and defines the comparison contract. '
          'Custom subclasses can implement domain-specific ordering.',
          deepGold,
          canaryLight,
        ),
        hierarchyRow('', 'Diagnosticable', deepGold, false),
        hierarchyRow('  └─ ', 'FocusOrder (abstract)', warmSaffron, false),
        hierarchyRow('      ├─ ', 'LexicalFocusOrder', deepGold, true),
        hierarchyRow('      └─ ', 'NumericFocusOrder', goldenrod, false),
        const SizedBox(height: 8),
        dataRow('Is FocusOrder', 'true', deepGold),
        dataRow('Is Diagnosticable', 'true (from FocusOrder)', warmSaffron),
        noteBox(
          'FocusOrder provides compareTo() which delegates to doCompare(). '
          'The Comparable interface ensures orders can be sorted with '
          'standard Dart sorting algorithms.',
          marigold,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 10. FocusTraversalOrder widget ───────────────────────────
        sectionBanner('10 · FocusTraversalOrder Widget',
            'Assigning order to widget subtrees', goldenrod, Colors.white),
        noteBox(
          'FocusTraversalOrder is an InheritedWidget that assigns a '
          'FocusOrder to its subtree. Combined with OrderedTraversalPolicy, '
          'it controls the tab order of focusable widgets.',
          deepGold,
          canaryLight,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: goldenrod.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: goldenrod.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Usage Pattern',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepGold)),
              const SizedBox(height: 8),
              dataRow('1. Set policy', 'FocusTraversalGroup(policy: …)', deepGold),
              dataRow('2. Wrap children', 'FocusTraversalOrder(order: …)', warmSaffron),
              dataRow('3. Set order', 'LexicalFocusOrder("a")', goldenrod),
              dataRow('4. Tab traversal', 'Follows assigned order', marigold),
            ],
          ),
        ),
        noteBox(
          'Without FocusTraversalOrder, the default traversal follows '
          'the reading direction (left-to-right, top-to-bottom). Explicit '
          'ordering overrides this spatial heuristic.',
          sunflower,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 11. Sorting demo ─────────────────────────────────────────
        sectionBanner('11 · Sorting Demonstration',
            'Visualizing lexical sort order', marigold, Colors.white),
        noteBox(
          'Here is a set of strings sorted lexically, demonstrating '
          'how LexicalFocusOrder would sequence focus traversal through '
          'widgets labeled with these strings.',
          deepGold,
          canaryLight,
        ),
        ...sorted.asMap().entries.map((entry) {
          final colors = [deepGold, warmSaffron, goldenrod, marigold, sunflower];
          return orderChip(entry.value, entry.key + 1,
              entry.key.isEven ? canaryLight : wheat,
              colors[entry.key % colors.length]);
        }),
        const SizedBox(height: 8),
        dataRow('Original', items.join(', '), deepGold),
        dataRow('Sorted', sorted.join(', '), warmSaffron),
        noteBox(
          'The sorted order matches how Tab would move focus: apple → '
          'banana → cherry → date → elderberry. Each widget gets '
          'LexicalFocusOrder with the corresponding string.',
          goldenrod,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 12. Case sensitivity ─────────────────────────────────────
        sectionBanner('12 · Case Sensitivity',
            'Uppercase vs lowercase ordering', sunflower, deepGold),
        noteBox(
          'String comparison is case-sensitive. Uppercase letters (A-Z, '
          'code points 65-90) sort before lowercase (a-z, 97-122). '
          '"Apple" < "apple" because "A" (65) < "a" (97).',
          deepGold,
          canaryLight,
        ),
        dataRow('lower', '"${lower.order}"', deepGold),
        dataRow('upper', '"${upper.order}"', warmSaffron),
        dataRow('mixed', '"${mixed.order}"', goldenrod),
        const SizedBox(height: 8),
        comparisonRow('Apple', '<', 'aPPLE', '"A" < "a"', deepGold),
        comparisonRow('aPPLE', '<', 'apple', '"P" < "p"', warmSaffron),
        comparisonRow('Apple', '<', 'apple', '"A" < "a"', goldenrod),
        noteBox(
          'To avoid case confusion, use all-lowercase or all-uppercase '
          'order strings consistently. If mixing cases, remember that '
          'uppercase sorts "higher" (earlier) than lowercase.',
          marigold,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 13. Unicode patterns ─────────────────────────────────────
        sectionBanner('13 · Unicode Character Behavior',
            'International characters in order strings', buttercup, deepGold),
        noteBox(
          'LexicalFocusOrder uses ordinal (code-point) comparison, not '
          'locale-sensitive collation. Characters like ü (252), ß (223), '
          'and accented letters sort by their Unicode code point, which '
          'may not match cultural expectations.',
          deepGold,
          canaryLight,
        ),
        dataRow('ü code point', '252 (\\u00FC)', deepGold),
        dataRow('ß code point', '223 (\\u00DF)', warmSaffron),
        dataRow('z code point', '122', goldenrod),
        const SizedBox(height: 8),
        comparisonRow('z', '<', '\u00DF', '122 < 223', deepGold),
        comparisonRow('\u00DF', '<', '\u00FC', '223 < 252', warmSaffron),
        noteBox(
          'For internationalized applications, consider creating a custom '
          'FocusOrder subclass that uses Dart\'s intl package for '
          'locale-aware string collation.',
          goldenrod,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 14. Real-world patterns ──────────────────────────────────
        sectionBanner('14 · Real-World Usage Patterns',
            'Practical ordering strategies', deepGold, Colors.white),
        noteBox(
          'In practice, LexicalFocusOrder strings are chosen for clarity '
          'and predictability. Common patterns include alphabetic labels, '
          'zero-padded numbers, and hierarchical prefixes.',
          deepGold,
          canaryLight,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: warmSaffron.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: warmSaffron.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Menu Bar Pattern',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepGold)),
              const SizedBox(height: 6),
              dataRow('"01-file"', 'File menu', deepGold),
              dataRow('"02-edit"', 'Edit menu', warmSaffron),
              dataRow('"03-view"', 'View menu', goldenrod),
              dataRow('"04-help"', 'Help menu', marigold),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: goldenrod.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: goldenrod.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Form Fields Pattern',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepGold)),
              const SizedBox(height: 6),
              dataRow('"a-name"', 'Name field first', deepGold),
              dataRow('"b-email"', 'Email field second', warmSaffron),
              dataRow('"c-phone"', 'Phone field third', goldenrod),
              dataRow('"d-address"', 'Address field fourth', marigold),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Vs NumericFocusOrder ─────────────────────────────────
        sectionBanner('15 · Lexical vs Numeric Ordering',
            'Comparing the two built-in FocusOrder types', warmSaffron, Colors.white),
        noteBox(
          'NumericFocusOrder uses double values for ordering: 1.0 < 2.0 < '
          '10.0. LexicalFocusOrder uses string comparison: "1" < "10" < "2". '
          'Choose based on whether your ordering is naturally numeric '
          'or alphabetic.',
          deepGold,
          canaryLight,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepGold.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepGold.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Head-to-Head',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepGold)),
              const SizedBox(height: 8),
              dataRow('NumericFocusOrder(1)', '${numeric1.order}', deepGold),
              dataRow('NumericFocusOrder(2)', '${numeric2.order}', warmSaffron),
              dataRow('NumericFocusOrder(10)', '${numeric10.order}', goldenrod),
              dataRow('Numeric sort', '1 → 2 → 10', marigold),
              const SizedBox(height: 6),
              dataRow('LexicalFocusOrder("1")', '"${num1.order}"', deepGold),
              dataRow('LexicalFocusOrder("2")', '"${num2.order}"', warmSaffron),
              dataRow('LexicalFocusOrder("10")', '"${num10.order}"', goldenrod),
              dataRow('Lexical sort', '"1" → "10" → "2"', sunflower),
            ],
          ),
        ),
        const SizedBox(height: 8),
        noteBox(
          'Use NumericFocusOrder when items are naturally numbered (tabs, '
          'list items). Use LexicalFocusOrder when items have meaningful '
          'string labels (menu names, categories, form fields).',
          buttercup,
          wheat,
        ),
        const SizedBox(height: 14),

        // ── 16. Summary dashboard ────────────────────────────────────
        sectionBanner('16 · Summary Dashboard',
            'LexicalFocusOrder metrics and patterns', deepGold, Colors.white),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            metricTile('Single-char', '4', canaryLight, deepGold),
            metricTile('Multi-char', '3', wheat, warmSaffron),
            metricTile('Numeric str', '4', canaryLight, goldenrod),
            metricTile('Special', '4', wheat, marigold),
            metricTile('Case tests', '3', canaryLight, sunflower),
            metricTile('Unicode', '2', wheat, buttercup),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          children: [
            tag('LexicalFocusOrder', deepGold, Colors.white),
            tag('FocusOrder', warmSaffron, Colors.white),
            tag('String comparison', goldenrod, Colors.white),
            tag('FocusTraversalOrder', marigold, Colors.white),
            tag('OrderedTraversalPolicy', sunflower, deepGold),
            tag('NumericFocusOrder', buttercup, deepGold),
            tag('Unicode ordinal', champagne, deepGold),
            tag('Case-sensitive', amberGlow, deepGold),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: canaryLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepGold.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gold / Saffron Palette',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: deepGold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  colorSwatch('deepGold', deepGold),
                  colorSwatch('saffron', warmSaffron),
                  colorSwatch('goldenrod', goldenrod),
                  colorSwatch('marigold', marigold),
                  colorSwatch('sunflower', sunflower),
                  colorSwatch('buttercup', buttercup),
                  colorSwatch('champagne', champagne),
                  colorSwatch('wheat', wheat),
                  colorSwatch('canary', canaryLight),
                  colorSwatch('amber', amberGlow),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
