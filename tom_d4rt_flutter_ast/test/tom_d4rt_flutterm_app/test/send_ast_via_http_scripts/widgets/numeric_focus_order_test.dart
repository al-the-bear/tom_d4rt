// ignore_for_file: avoid_print
// D4rt deep demo: NumericFocusOrder — assigns numeric traversal priority to focus nodes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Fawn / Wheat ──────────────────────────────────────────
  const deepFawn = Color(0xFF5D4037);
  const fawn = Color(0xFF8D6E63);
  const warmFawn = Color(0xFFA1887F);
  const wheat = Color(0xFFD7CCC8);
  const lightWheat = Color(0xFFEFEBE9);
  const paleWheat = Color(0xFFFFF8F0);
  const creamWheat = Color(0xFFFFFBF5);
  const darkBark = Color(0xFF3E2723);
  const accentOlive = Color(0xFF558B2F);
  const accentSlate = Color(0xFF37474F);

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
          style: TextStyle(fontSize: 13, color: darkBark)),
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
                style: TextStyle(fontSize: 13, color: darkBark)),
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
  print('NumericFocusOrder deep demo executing');
  print('=' * 60);

  print('\n--- What is NumericFocusOrder ---');
  print('A FocusOrder subclass that uses a double value for ordering');
  print('Constructor: const NumericFocusOrder(this.order)');
  print('Lower numeric values are traversed first');
  print('Used with FocusTraversalOrder widget + OrderedTraversalPolicy');

  print('\n--- Class definition ---');
  print('class NumericFocusOrder extends FocusOrder {');
  print('  const NumericFocusOrder(this.order);');
  print('  final double order;');
  print('  int doCompare(NumericFocusOrder other)');
  print('      => order.compareTo(other.order);');
  print('}');

  print('\n--- FocusOrder base ---');
  print('abstract class FocusOrder with Diagnosticable {');
  print('  const FocusOrder();');
  print('  int compareTo(FocusOrder other) {');
  print('    assert(runtimeType == other.runtimeType);');
  print('    return doCompare(covariant other);');
  print('  }');
  print('}');

  print('\n--- Key constraints ---');
  print('Cannot mix NumericFocusOrder with LexicalFocusOrder');
  print('RuntimeType assertion in FocusOrder.compareTo()');
  print('Must use OrderedTraversalPolicy for orders to take effect');

  print('\n${'=' * 60}');
  print('NumericFocusOrder deep demo completed');

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
              colors: [deepFawn, fawn, warmFawn],
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
                  Icon(Icons.format_list_numbered, size: 28,
                      color: wheat),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NumericFocusOrder',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('A FocusOrder subclass that assigns numeric priority '
                  'to focus traversal — lower values are visited first '
                  'when Tab navigates through widgets',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('FocusOrder', fawn, Colors.white),
                tag('double order', warmFawn, darkBark),
                tag('doCompare()', wheat, darkBark),
                tag('OrderedTraversalPolicy', lightWheat, darkBark),
              ]),
            ],
          ),
        ),

        // ── 2. What is NumericFocusOrder ─────────────────────────────
        sectionBanner('1 \u00b7 What Is NumericFocusOrder',
            'A concrete FocusOrder using doubles for priority',
            deepFawn, Colors.white),
        noteBox(
          'NumericFocusOrder extends FocusOrder and assigns a double '
          'value to its order property. When used with '
          'OrderedTraversalPolicy and FocusTraversalOrder, it controls '
          'the Tab-key order of focus nodes. Lower values are visited '
          'first. It\u0027s a const class — the order is immutable after '
          'creation.',
          fawn,
          creamWheat,
        ),
        dataRow('Type', 'class NumericFocusOrder extends FocusOrder', fawn),
        dataRow('Constructor', 'const NumericFocusOrder(this.order)', deepFawn),
        dataRow('Property', 'final double order', warmFawn),
        dataRow('Ordering rule', 'Lower values traversed first', accentOlive),
        dataRow('Defined in', 'widgets/focus_traversal.dart', darkBark),
        dataRow('Line in SDK', '1787', accentSlate),
        const SizedBox(height: 14),

        // ── 3. Class hierarchy ───────────────────────────────────────
        sectionBanner('2 \u00b7 The FocusOrder Hierarchy',
            'Where NumericFocusOrder fits in the tree',
            fawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('FocusOrder (abstract, with Diagnosticable)', deepFawn, true),
                ('\u2514\u2500 NumericFocusOrder (double)', fawn, true),
                ('\u2514\u2500 LexicalFocusOrder (String)', warmFawn, false),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: level.$3
                        ? level.$2.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: level.$3
                        ? Border.all(color: level.$2)
                        : Border.all(
                            color: level.$2.withValues(alpha: 0.3)),
                  ),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight:
                              level.$3 ? FontWeight.bold : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        noteBox(
          'FocusOrder provides compareTo() which asserts same runtimeType '
          'then delegates to doCompare(). This means NumericFocusOrder and '
          'LexicalFocusOrder cannot be mixed in the same traversal group — '
          'it triggers a runtime assertion failure.',
          deepFawn,
          lightWheat,
        ),
        const SizedBox(height: 14),

        // ── 4. doCompare() method ────────────────────────────────────
        sectionBanner('3 \u00b7 The doCompare() Method',
            'Implementation detail of numeric comparison',
            warmFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepFawn.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepFawn.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// SDK source code:\n'
                    '@override\n'
                    'int doCompare(NumericFocusOrder other) {\n'
                    '  return order.compareTo(other.order);\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepFawn)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'doCompare uses double.compareTo which returns negative '
                'if order < other.order, zero if equal, positive if greater. '
                'This means 1.0 traverses before 2.0, and 0.5 before 1.0. '
                'You can use decimals for fine-grained ordering.',
                fawn,
                creamWheat,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Required widget setup ─────────────────────────────────
        sectionBanner('4 \u00b7 Required Widget Setup',
            'The three pieces needed for ordered traversal',
            deepFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                ('1. FocusTraversalGroup',
                    'FocusTraversalGroup(\n'
                    '  policy: OrderedTraversalPolicy(),\n'
                    '  child: ...\n'
                    ')',
                    'Wraps a region of focus nodes and sets the policy.',
                    fawn),
                ('2. FocusTraversalOrder',
                    'FocusTraversalOrder(\n'
                    '  order: NumericFocusOrder(1.0),\n'
                    '  child: myWidget,\n'
                    ')',
                    'Assigns a numeric order to an individual focusable widget.',
                    deepFawn),
                ('3. The focusable widget',
                    'TextField(...)\n'
                    'ElevatedButton(...)\n'
                    'Focus(child: ...)',
                    'The actual widget that receives focus. Must be focusable.',
                    warmFawn),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: step.$4)),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(step.$2,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: darkBark)),
                      ),
                      const SizedBox(height: 4),
                      Text(step.$3,
                          style: TextStyle(
                              fontSize: 11, color: darkBark)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Live demo: ordered traversal ──────────────────────────
        sectionBanner('5 \u00b7 Live Demo: Ordered Traversal',
            'Tab traversal in numeric order instead of visual order',
            fawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: wheat),
          ),
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentOlive.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accentOlive),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.tab, size: 16, color: accentOlive),
                      const SizedBox(width: 6),
                      Text('Tab order: 3 \u2192 1 \u2192 4 \u2192 2 (by numeric order)',
                          style: TextStyle(
                              fontSize: 10, color: darkBark)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                for (final item in [
                  (3.0, 'Visual first (order 3.0)', warmFawn),
                  (1.0, 'Visual second (order 1.0)', fawn),
                  (4.0, 'Visual third (order 4.0)', accentSlate),
                  (2.0, 'Visual fourth (order 2.0)', deepFawn),
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: FocusTraversalOrder(
                      order: NumericFocusOrder(item.$1),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: item.$3.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border(
                              left: BorderSide(
                                  color: item.$3, width: 3)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 22,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: item.$3,
                                borderRadius:
                                    BorderRadius.circular(4),
                              ),
                              child: Text('${item.$1.toInt()}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(item.$2,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: darkBark)),
                            ),
                            SizedBox(
                              width: 80,
                              height: 28,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: item.$3,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 2),
                                ),
                                child: Text('Focus me',
                                    style: const TextStyle(
                                        fontSize: 9)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                noteBox(
                  'Despite visual layout order 3-1-4-2, Tab traverses '
                  '1.0 \u2192 2.0 \u2192 3.0 \u2192 4.0 (ascending numeric order). '
                  'The OrderedTraversalPolicy sorts by FocusOrder.',
                  fawn,
                  creamWheat,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Decimal ordering ──────────────────────────────────────
        sectionBanner('6 \u00b7 Decimal Ordering',
            'Fine-grained control with fractional values',
            warmFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final frac in [
                (0.5, 'First in traversal', accentOlive),
                (1.0, 'Second', fawn),
                (1.5, 'Squeezed between 1.0 and 2.0', warmFawn),
                (2.0, 'Fourth', deepFawn),
                (10.0, 'Last — gaps let you insert later', accentSlate),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: frac.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: frac.$3, width: 2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: frac.$3,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('${frac.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace')),
                      ),
                      const SizedBox(width: 8),
                      Text(frac.$2,
                          style: TextStyle(
                              fontSize: 12, color: darkBark)),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              noteBox(
                'Using decimals like 0.5, 1.5 lets you insert items '
                'between existing orders without renumbering. Leaving gaps '
                '(1, 2, 10) provides room for future insertions.',
                warmFawn,
                lightWheat,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Cannot mix with LexicalFocusOrder ─────────────────────
        sectionBanner('7 \u00b7 Cannot Mix With LexicalFocusOrder',
            'The runtimeType assertion constraint',
            deepFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFC62828).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFC62828)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, size: 20,
                        color: const Color(0xFFC62828)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                          'FocusOrder.compareTo() asserts:\n'
                          'assert(runtimeType == other.runtimeType)\n\n'
                          'Mixing NumericFocusOrder and LexicalFocusOrder\n'
                          'in the same group crashes at runtime.',
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: const Color(0xFFC62828))),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepFawn.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepFawn.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// This would CRASH:\n'
                    'FocusTraversalOrder(\n'
                    '  order: NumericFocusOrder(1.0),\n'
                    '  child: fieldA,\n'
                    ')\n'
                    'FocusTraversalOrder(\n'
                    '  order: LexicalFocusOrder("a"),\n'
                    '  child: fieldB, // ASSERTION ERROR\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepFawn)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. LexicalFocusOrder comparison ──────────────────────────
        sectionBanner('8 \u00b7 Numeric vs Lexical FocusOrder',
            'Choosing between the two concrete FocusOrder types',
            fawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: fawn.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: fawn, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.format_list_numbered, size: 24,
                          color: fawn),
                      const SizedBox(height: 4),
                      Text('NumericFocusOrder',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: fawn)),
                      const SizedBox(height: 6),
                      Text('double value\n1.0, 2.0, 3.5\n\n'
                          'Simple numeric\ncomparison.\n\n'
                          'Best for numbered\nsequences.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkBark)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentSlate.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentSlate, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.sort_by_alpha, size: 24,
                          color: accentSlate),
                      const SizedBox(height: 4),
                      Text('LexicalFocusOrder',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentSlate)),
                      const SizedBox(height: 6),
                      Text('String value\n"a", "b", "c"\n\n'
                          'String.compareTo\nfor ordering.\n\n'
                          'Best for alpha\nsequences.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkBark)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Live demo: form field ordering ───────────────────────
        sectionBanner('9 \u00b7 Live Demo: Form Field Ordering',
            'Reordering text fields with NumericFocusOrder',
            deepFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: wheat),
          ),
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentOlive.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accentOlive),
                  ),
                  child: Text(
                      'Visual order: Email, Phone, Name, Zip\n'
                      'Tab order: Name(1) \u2192 Email(2) \u2192 Phone(3) \u2192 Zip(4)',
                      style: TextStyle(
                          fontSize: 10, color: darkBark)),
                ),
                const SizedBox(height: 8),
                for (final field in [
                  ('Email', 2.0, Icons.email, fawn),
                  ('Phone', 3.0, Icons.phone, warmFawn),
                  ('Name', 1.0, Icons.person, deepFawn),
                  ('Zip Code', 4.0, Icons.location_on, accentSlate),
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
                          const SizedBox(width: 8),
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
                                      fontSize: 11,
                                      color: field.$4),
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: field.$4
                                            .withValues(alpha: 0.3)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: field.$4, width: 2),
                                  ),
                                ),
                                style: TextStyle(
                                    fontSize: 12, color: darkBark),
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

        // ── 11. Without OrderedTraversalPolicy ───────────────────────
        sectionBanner('10 \u00b7 Without OrderedTraversalPolicy',
            'What happens when focus orders are ignored',
            warmFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final policy in [
                ('WidgetOrderTraversalPolicy',
                    'Traverses in widget tree creation order (the default). '
                    'Ignores FocusTraversalOrder completely.',
                    Icons.reorder, fawn),
                ('ReadingOrderTraversalPolicy',
                    'Traverses in reading order (LTR or RTL based on locale). '
                    'Also ignores FocusTraversalOrder.',
                    Icons.menu_book, warmFawn),
                ('OrderedTraversalPolicy',
                    'The ONLY policy that respects FocusTraversalOrder. '
                    'Sorts ordered nodes first, then unordered via secondary.',
                    Icons.format_list_numbered, deepFawn),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: policy.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: policy.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(policy.$3, size: 20, color: policy.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(policy.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: policy.$4)),
                            Text(policy.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkBark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        noteBox(
          'Using NumericFocusOrder without OrderedTraversalPolicy has '
          'no effect. The default ReadingOrderTraversalPolicy simply ignores '
          'the FocusTraversalOrder widget entirely.',
          warmFawn,
          lightWheat,
        ),
        const SizedBox(height: 14),

        // ── 12. Secondary policy behavior ────────────────────────────
        sectionBanner('11 \u00b7 Secondary Policy',
            'How OrderedTraversalPolicy handles unordered nodes',
            deepFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 4; i++)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: [fawn, deepFawn, warmFawn, accentOlive][i]
                        .withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: [fawn, deepFawn, warmFawn, accentOlive][i]),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: [fawn, deepFawn, warmFawn, accentOlive][i],
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text([
                          'Sort ALL nodes by secondary policy (default: ReadingOrder)',
                          'Split into ordered (have FocusTraversalOrder) and unordered',
                          'Stable-sort the ordered list by FocusOrder.compareTo()',
                          'Result: ordered nodes first, then unordered nodes',
                        ][i],
                            style: TextStyle(
                                fontSize: 11, color: darkBark)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Performance notes ────────────────────────────────────
        sectionBanner('12 \u00b7 Performance Characteristics',
            'Cost and efficiency considerations',
            fawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Object size', 'Single double field — 8 bytes + overhead',
                    Icons.memory, fawn),
                ('Comparison', 'O(1) double.compareTo — trivial cost',
                    Icons.speed, deepFawn),
                ('Sort', 'Stable mergeSort on ordered nodes — O(n log n)',
                    Icons.sort, warmFawn),
                ('Ancestor lookup', 'FocusTraversalOrder.of() walks ancestors — '
                    'cached per frame',
                    Icons.search, accentSlate),
                ('Const', 'Fully const — zero allocation overhead',
                    Icons.eco, accentOlive),
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
                          text: TextSpan(
                            children: [
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
                                      color: darkBark)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Common patterns ──────────────────────────────────────
        sectionBanner('13 \u00b7 Common Patterns',
            'Real-world usage scenarios',
            warmFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pattern in [
                ('Login form', 'Username(1) \u2192 Password(2) \u2192 Submit(3)',
                    Icons.login, fawn),
                ('Address form', 'Name(1) \u2192 Street(2) \u2192 City(3) '
                    '\u2192 State(4) \u2192 Zip(5)',
                    Icons.home, deepFawn),
                ('Toolbar', 'Bold(1) \u2192 Italic(2) \u2192 Underline(3)',
                    Icons.format_bold, warmFawn),
                ('Dialog', 'Input(1) \u2192 Cancel(2) \u2192 Confirm(3)',
                    Icons.check_box, accentOlive),
                ('Grid skip', 'Header(1) \u2192 Cell(5) — skip decoration '
                    'elements between',
                    Icons.grid_on, accentSlate),
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
                      Icon(pattern.$3, size: 18, color: pattern.$4),
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
                                    fontSize: 11, color: darkBark)),
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

        // ── 15. Equality and identity ────────────────────────────────
        sectionBanner('14 \u00b7 Equality and Identity',
            'How NumericFocusOrder instances compare',
            deepFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleWheat,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('operator ==',
                  'Not overridden — identity-based. Two NumericFocusOrder(1.0) are NOT ==.',
                  fawn),
              const SizedBox(height: 4),
              dataRow('compareTo',
                  'Compares .order values. Two NumericFocusOrder(1.0) compare as equal (returns 0).',
                  deepFawn),
              const SizedBox(height: 4),
              dataRow('const',
                  'const NumericFocusOrder(1.0) — identical instances thanks to const canonicalization.',
                  warmFawn),
              const SizedBox(height: 8),
              noteBox(
                'With const, identical order values produce the same instance. '
                'Without const, two NumericFocusOrder(1.0) are different objects '
                'but compare as equal via compareTo.',
                deepFawn,
                lightWheat,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepFawn, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepFawn, fawn],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends FocusOrder — uses double value for traversal priority',
                'Lower numeric values are traversed first when Tab is pressed',
                'Const constructor: const NumericFocusOrder(this.order)',
                'doCompare() delegates to double.compareTo()',
                'Requires FocusTraversalOrder + OrderedTraversalPolicy setup',
                'Cannot mix with LexicalFocusOrder (runtimeType assertion)',
                'Decimals enable fine-grained ordering (0.5, 1.5, 2.5)',
                'Stable sort preserves relative order for equal values',
                'Zero overhead — const, single double field, O(1) compare',
                'Best for forms, dialogs, toolbars, and keyboard navigation',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: wheat,
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
