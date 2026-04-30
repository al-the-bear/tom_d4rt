// ignore_for_file: avoid_print
// D4rt deep demo: ObjectKey — a key that uses object identity (identical()) for equality
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Slate / Iron ──────────────────────────────────────────
  const deepSlate = Color(0xFF263238);
  const slate = Color(0xFF455A64);
  const iron = Color(0xFF607D8B);
  const softIron = Color(0xFF78909C);
  const lightSlate = Color(0xFFB0BEC5);
  const paleSlate = Color(0xFFECEFF1);
  const whiteIron = Color(0xFFF5F7F8);
  const darkSteel = Color(0xFF1A2327);
  const accentAmber = Color(0xFFFF8F00);
  const accentTeal = Color(0xFF00695C);

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
          style: TextStyle(fontSize: 13, color: darkSteel)),
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
                style: TextStyle(fontSize: 13, color: darkSteel)),
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
  print('ObjectKey deep demo executing');
  print('=' * 60);

  print('\n--- What is ObjectKey ---');
  print('A Key subclass that uses object identity for equality');
  print('Constructor: const ObjectKey(this.value)');
  print('value is Object? — can hold any object');
  print('Uses identical(a, b) not a == b');
  print('hashCode uses identityHashCode(value)');

  print('\n--- Class hierarchy ---');
  print('Key (abstract)');
  print('  LocalKey (abstract)');
  print('    ObjectKey (identity)');
  print('    ValueKey<T> (operator ==)');
  print('    UniqueKey (always unique)');
  print('  GlobalKey (global, state access)');

  print('\n--- ObjectKey vs ValueKey ---');
  final objA = Object();
  final objB = Object();
  print('ObjectKey(objA) == ObjectKey(objA): ${ObjectKey(objA) == ObjectKey(objA)}');
  print('ObjectKey(objA) == ObjectKey(objB): ${ObjectKey(objA) == ObjectKey(objB)}');
  print('ValueKey("x") == ValueKey("x"): ${const ValueKey("x") == const ValueKey("x")}');
  print('ValueKey(objA) == ValueKey(objB): ${ValueKey(objA) == ValueKey(objB)}');

  print('\n--- identical() semantics ---');
  print('identical checks reference equality (same memory address)');
  print('Two List([1,2]) are NOT identical even if contents match');
  print('One const object is identical to itself');

  print('\n${'=' * 60}');
  print('ObjectKey deep demo completed');

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
              colors: [deepSlate, slate, iron],
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
                  Icon(Icons.fingerprint, size: 28, color: lightSlate),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('ObjectKey',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('A key that uses object identity (identical()) for '
                  'equality instead of value equality (==) — perfect '
                  'for distinguishing widgets backed by the same data '
                  'type but different object instances',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('LocalKey', iron, Colors.white),
                tag('identical()', softIron, darkSteel),
                tag('identityHashCode', lightSlate, darkSteel),
                tag('const ObjectKey', paleSlate, darkSteel),
              ]),
            ],
          ),
        ),

        // ── 2. What is ObjectKey ─────────────────────────────────────
        sectionBanner('1 \u00b7 What Is ObjectKey',
            'Identity-based key for widget matching',
            deepSlate, Colors.white),
        noteBox(
          'ObjectKey is a LocalKey subclass that wraps an Object? value '
          'and compares using identical() instead of ==. This means two '
          'ObjectKeys are equal only if they hold the exact same object '
          'instance — not just objects with the same contents.',
          slate,
          whiteIron,
        ),
        dataRow('Type', 'class ObjectKey extends LocalKey', slate),
        dataRow('Constructor', 'const ObjectKey(this.value)', deepSlate),
        dataRow('Property', 'final Object? value', iron),
        dataRow('Equality', 'identical(other.value, value)', accentAmber),
        dataRow('hashCode', 'identityHashCode(value)', accentTeal),
        dataRow('Defined in', 'widgets/framework.dart line 89', darkSteel),
        const SizedBox(height: 14),

        // ── 3. Class definition ──────────────────────────────────────
        sectionBanner('2 \u00b7 Class Definition',
            'The SDK source code (simplified)',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepSlate.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepSlate.withValues(alpha: 0.3)),
            ),
            child: Text(
                'class ObjectKey extends LocalKey {\n'
                '  const ObjectKey(this.value);\n'
                '\n'
                '  final Object? value;\n'
                '\n'
                '  @override\n'
                '  bool operator ==(Object other) {\n'
                '    if (other.runtimeType !=\n'
                '        runtimeType) return false;\n'
                '    return other is ObjectKey &&\n'
                '        identical(other.value, value);\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  int get hashCode => Object.hash(\n'
                '      runtimeType,\n'
                '      identityHashCode(value));\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepSlate)),
          ),
        ),
        noteBox(
          'The key detail: identical() checks that both sides point to '
          'the exact same object in memory. identityHashCode() returns '
          'the default hash before any == override.',
          deepSlate,
          paleSlate,
        ),
        const SizedBox(height: 14),

        // ── 4. Key hierarchy ─────────────────────────────────────────
        sectionBanner('3 \u00b7 The Key Hierarchy',
            'All key types and their purposes',
            iron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Key (abstract)', 'Base class for all keys',
                    deepSlate, true),
                ('\u2514\u2500 LocalKey', 'Unique within parent only',
                    slate, false),
                ('    \u2514\u2500 ObjectKey', 'Identity-based (identical)',
                    iron, true),
                ('    \u2514\u2500 ValueKey<T>', 'Value-based (operator ==)',
                    softIron, false),
                ('    \u2514\u2500 UniqueKey',
                    'Always unique (never equal to another)', lightSlate, false),
                ('\u2514\u2500 GlobalKey', 'Globally unique, state access',
                    accentAmber, false),
                ('    \u2514\u2500 GlobalObjectKey', 'Global + identity',
                    accentTeal, false),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: level.$4
                        ? level.$3.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: level.$3, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(level.$1,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                fontWeight: level.$4
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: level.$3)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(level.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkSteel)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. identical() vs == ─────────────────────────────────────
        sectionBanner('4 \u00b7 identical() vs operator ==',
            'The fundamental difference that defines ObjectKey',
            deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: slate.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slate, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.fingerprint, size: 24,
                          color: slate),
                      const SizedBox(height: 4),
                      Text('identical()',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: slate)),
                      const SizedBox(height: 6),
                      Text('Same reference?\nSame pointer?\nSame instance?\n\n'
                          'ObjectKey uses\nthis approach.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkSteel)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentAmber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentAmber, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.compare, size: 24,
                          color: accentAmber),
                      const SizedBox(height: 4),
                      Text('operator ==',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: accentAmber)),
                      const SizedBox(height: 6),
                      Text('Same value?\nEqual contents?\nCustomizable.\n\n'
                          'ValueKey uses\nthis approach.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkSteel)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Identity examples table
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepSlate),
                children: [
                  for (final h in ['Expression', 'identical()', '=='])
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
                ('Same object ref', 'true', 'true'),
                ('Two equal strings', 'maybe*', 'true'),
                ('Two List([1,2])', 'false', 'false**'),
                ('Same const', 'true', 'true'),
                ('Two Object()', 'false', 'false'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10, color: darkSteel)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color:
                                  row.$2 == 'true' ? accentTeal : slate)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color:
                                  row.$3 == 'true' ? accentTeal : slate)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        noteBox(
          '*Dart may intern short strings, making identical() true. '
          '**List does not override ==, so it uses identical() by default.',
          iron,
          paleSlate,
        ),
        const SizedBox(height: 14),

        // ── 6. ObjectKey vs ValueKey ─────────────────────────────────
        sectionBanner('5 \u00b7 ObjectKey vs ValueKey',
            'Choosing the right key type',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final comparison in [
                ('ObjectKey', 'identical(a, b)',
                    'When objects don\u0027t override ==, or you need to '
                    'distinguish same-value instances.',
                    Icons.fingerprint, slate),
                ('ValueKey<T>', 'a == b',
                    'When the value\u0027s == operator correctly represents '
                    'identity (strings, ints, enum values).',
                    Icons.text_fields, accentAmber),
                ('UniqueKey', 'Never equal',
                    'When you need a key that never matches anything else. '
                    'Creates once, never reused.',
                    Icons.fiber_new, iron),
                ('GlobalKey', 'Globally unique',
                    'When you need cross-tree access to State or '
                    'BuildContext. Expensive — use sparingly.',
                    Icons.public, accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: comparison.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: comparison.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(comparison.$4, size: 20,
                          color: comparison.$5),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(comparison.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: comparison.$5)),
                                const SizedBox(width: 6),
                                Text('(${comparison.$2})',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'monospace',
                                        color: comparison.$5
                                            .withValues(alpha: 0.7))),
                              ],
                            ),
                            Text(comparison.$3,
                                style: TextStyle(
                                    fontSize: 11, color: darkSteel)),
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

        // ── 7. Live demo comparison ──────────────────────────────────
        sectionBanner('6 \u00b7 Live Demo: Identity vs Value Comparison',
            'Showing how ObjectKey and ValueKey differ in practice',
            iron, Colors.white),
        Builder(builder: (ctx) {
          final sameObj = Object();
          final diffObj = Object();
          final results = <(String, bool, Color)>[
            ('ObjectKey(sameObj) == ObjectKey(sameObj)',
                ObjectKey(sameObj) == ObjectKey(sameObj), accentTeal),
            ('ObjectKey(sameObj) == ObjectKey(diffObj)',
                ObjectKey(sameObj) == ObjectKey(diffObj), slate),
            ('ValueKey("hello") == ValueKey("hello")',
                const ValueKey('hello') == const ValueKey('hello'),
                accentTeal),
            ('ValueKey(42) == ValueKey(42)',
                const ValueKey(42) == const ValueKey(42), accentTeal),
            ('ObjectKey(42) == ObjectKey(42)',
                ObjectKey(42) == ObjectKey(42), accentTeal),
            ('ObjectKey(null) == ObjectKey(null)',
                const ObjectKey(null) == const ObjectKey(null), accentTeal),
          ];
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: whiteIron,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: lightSlate),
            ),
            child: Column(
              children: [
                for (final r in results)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: r.$3.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border(
                          left: BorderSide(color: r.$3, width: 2)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(r.$1,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: darkSteel)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: r.$2
                                ? accentTeal
                                : const Color(0xFFC62828),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(r.$2 ? 'true' : 'false',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 6),
                noteBox(
                  'ObjectKey(42) == ObjectKey(42) is true because Dart '
                  'interns small integers — identical(42, 42) is true. '
                  'ObjectKey(null) == ObjectKey(null) also true for the '
                  'same reason.',
                  iron,
                  paleSlate,
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 14),

        // ── 8. When to use ObjectKey ─────────────────────────────────
        sectionBanner('7 \u00b7 When To Use ObjectKey',
            'Practical scenarios where ObjectKey shines',
            deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('Model objects in lists',
                    'When list items are model instances without a stable '
                    'ID field. ObjectKey(item) ensures each widget maps '
                    'to its specific instance.',
                    Icons.list, slate),
                ('Multiple same-type items',
                    'Two Person("Alice") objects — ValueKey would match both. '
                    'ObjectKey distinguishes by reference.',
                    Icons.people, iron),
                ('Mutable objects',
                    'Objects whose fields change but identity stays the same. '
                    'ObjectKey stays stable even after mutations.',
                    Icons.edit, deepSlate),
                ('Complex objects without ==',
                    'Objects that don\u0027t override == and you don\u0027t want '
                    'to rely on default identity from Object.',
                    Icons.extension, softIron),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scenario.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(scenario.$3, size: 18,
                          color: scenario.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: scenario.$4)),
                            Text(scenario.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkSteel)),
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

        // ── 9. Live demo: list with ObjectKey ────────────────────────
        sectionBanner('8 \u00b7 Live Demo: List With ObjectKey',
            'Using ObjectKey to key widgets by object instance',
            slate, Colors.white),
        Builder(builder: (ctx) {
          final items = List.generate(6, (i) => Object());
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: whiteIron,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: lightSlate),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accentTeal),
                  ),
                  child: Text(
                      'Each item keyed by ObjectKey(item) — unique by instance',
                      style: TextStyle(
                          fontSize: 10, color: darkSteel)),
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < items.length; i++)
                  Container(
                    key: ObjectKey(items[i]),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: (i.isEven ? slate : iron)
                          .withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border(
                          left: BorderSide(
                              color: i.isEven ? slate : iron,
                              width: 2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 8,
                            color: i.isEven ? slate : iron),
                        const SizedBox(width: 8),
                        Text('Item $i',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: darkSteel)),
                        const Spacer(),
                        Text('hash: ${identityHashCode(items[i]).toRadixString(16)}',
                            style: TextStyle(
                                fontSize: 9,
                                fontFamily: 'monospace',
                                color: softIron)),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }),
        const SizedBox(height: 14),

        // ── 10. GlobalObjectKey ──────────────────────────────────────
        sectionBanner('9 \u00b7 GlobalObjectKey',
            'The global version of ObjectKey',
            iron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iron.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: iron.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'class GlobalObjectKey<T extends State>\n'
                    '    extends GlobalKey<T> {\n'
                    '  const GlobalObjectKey(this.value);\n'
                    '  final Object value;\n'
                    '\n'
                    '  // Uses identical() like ObjectKey\n'
                    '  // but is globally unique across\n'
                    '  // the entire widget tree.\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepSlate)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'GlobalObjectKey combines identity-based equality with '
                'global uniqueness. You can use it to access State or '
                'BuildContext of a widget from anywhere in the tree. '
                'Use sparingly — global keys are expensive.',
                iron,
                paleSlate,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Null value behavior ──────────────────────────────────
        sectionBanner('10 \u00b7 Null Value Behavior',
            'ObjectKey with null values',
            deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('ObjectKey(null)',
                  'Valid. value is Object? — null is allowed.',
                  slate),
              dataRow('Equality',
                  'ObjectKey(null) == ObjectKey(null) \u2192 true '
                  '(identical(null, null) is true)',
                  iron),
              dataRow('hashCode',
                  'identityHashCode(null) returns a consistent value',
                  deepSlate),
              const SizedBox(height: 8),
              noteBox(
                'ObjectKey(null) is a valid key. All ObjectKey(null) instances '
                'are equal to each other. This can be useful as a sentinel key, '
                'but be careful not to have multiple children with the same null key.',
                deepSlate,
                paleSlate,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. toString and debugging ───────────────────────────────
        sectionBanner('11 \u00b7 Debugging and toString()',
            'How ObjectKey appears in debug output',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final example in [
                ('ObjectKey(42)', ObjectKey(42).toString(), slate),
                ('ObjectKey("hello")', ObjectKey('hello').toString(), iron),
                ('ObjectKey(null)', const ObjectKey(null).toString(), deepSlate),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: example.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: example.$3, width: 2)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(example.$1,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: example.$3)),
                      ),
                      Text('\u2192 ${example.$2}',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: darkSteel)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Performance considerations ───────────────────────────
        sectionBanner('12 \u00b7 Performance Characteristics',
            'Cost and efficiency', iron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Equality check', 'O(1) — identical() is a pointer comparison',
                    Icons.speed, slate),
                ('hashCode', 'O(1) — identityHashCode is the default object hash',
                    Icons.tag, iron),
                ('Memory', 'Single reference field — minimal overhead',
                    Icons.memory, deepSlate),
                ('Const', 'const ObjectKey — zero allocation when const',
                    Icons.eco, accentTeal),
                ('vs ValueKey', 'ObjectKey is always O(1). ValueKey depends on the '
                    'value type\u0027s == operator.',
                    Icons.compare, accentAmber),
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
                                    color: darkSteel)),
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

        // ── 14. Common mistakes ──────────────────────────────────────
        sectionBanner('13 \u00b7 Common Mistakes',
            'Pitfalls to avoid with ObjectKey',
            deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final mistake in [
                ('Recreating objects in build()',
                    'ObjectKey(Object()) inside build() creates a new key every '
                    'rebuild — defeats the purpose. Store the object in state.',
                    Icons.warning, const Color(0xFFC62828)),
                ('Using ObjectKey for strings',
                    'ObjectKey("hello") may or may not match due to string '
                    'interning. For string keys, use ValueKey instead.',
                    Icons.warning, accentAmber),
                ('Duplicate ObjectKey in siblings',
                    'Two children with ObjectKey(sameObj) causes a duplicate '
                    'key error. Each sibling needs a unique key.',
                    Icons.warning, iron),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: mistake.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: mistake.$4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(mistake.$3, size: 18,
                          color: mistake.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mistake.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: mistake.$4)),
                            Text(mistake.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkSteel)),
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

        // ── 15. Practical code pattern ───────────────────────────────
        sectionBanner('14 \u00b7 Practical Usage Pattern',
            'A real-world ObjectKey example',
            slate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepSlate.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepSlate.withValues(alpha: 0.3)),
            ),
            child: Text(
                '// Model without stable ID:\n'
                'final tasks = [Task("Buy milk"),\n'
                '               Task("Buy milk")];\n'
                '\n'
                '// Won\u0027t work (both have same value):\n'
                '// ValueKey(task.title)\n'
                '\n'
                '// Works (different instances):\n'
                'for (final task in tasks)\n'
                '  ListTile(\n'
                '    key: ObjectKey(task),\n'
                '    title: Text(task.title),\n'
                '  )',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepSlate)),
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepSlate, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepSlate, slate],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'LocalKey subclass using identical() for equality',
                'Wraps Object? value — compares by reference, not content',
                'hashCode uses identityHashCode for consistent hashing',
                'Key hierarchy: Key > LocalKey > ObjectKey',
                'Differs from ValueKey (uses ==) and UniqueKey (always unique)',
                'Best for objects without stable ID or overridden ==',
                'GlobalObjectKey extends GlobalKey with identity semantics',
                'ObjectKey(null) is valid — all null keys are equal',
                'O(1) equality and hashCode — always fast',
                'Store objects in state — never create new ones in build()',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightSlate,
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
