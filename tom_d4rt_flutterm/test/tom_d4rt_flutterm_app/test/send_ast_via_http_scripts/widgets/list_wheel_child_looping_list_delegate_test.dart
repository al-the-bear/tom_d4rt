// ignore_for_file: avoid_print
// D4rt deep demo: ListWheelChildLoopingListDelegate — infinite looping wheel
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Sienna / Sandstone ────────────────────────────────────
  const deepSienna = Color(0xFF5D4037);
  const warmBrown = Color(0xFF6D4C41);
  const camelTan = Color(0xFF8D6E63);
  const sandstone = Color(0xFFA1887F);
  const oatmeal = Color(0xFFBCAAA4);
  const parchment = Color(0xFFD7CCC8);
  const cream = Color(0xFFEFEBE9);
  const ivory = Color(0xFFFAF6F3);
  const burntAmber = Color(0xFFE65100);
  const goldenrod = Color(0xFFFBC02D);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(
      String title, String subtitle, Color bg, Color fg) {
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
                  color: fg,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
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
      child: Text(text, style: TextStyle(fontSize: 13, color: deepSienna)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepSienna)),
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

  Widget indexCell(int index, String display, Color bg, Color fg) {
    return Container(
      width: 52,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$index', style: TextStyle(fontSize: 10, color: fg.withValues(alpha: 0.6))),
          Text(display, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: fg)),
        ],
      ),
    );
  }

  // ── Create delegates and gather data ───────────────────────────────
  print('ListWheelChildLoopingListDelegate deep demo executing');
  print('=' * 60);

  final seasons = <Widget>[
    Text('Spring'), Text('Summer'), Text('Autumn'), Text('Winter'),
  ];
  final loopingDelegate =
      ListWheelChildLoopingListDelegate(children: seasons);

  // Section 1 — what is it
  print('\n--- What is ListWheelChildLoopingListDelegate ---');
  print('A delegate that loops its children infinitely');
  print('Wraps indices using modulo arithmetic');
  print('Scrolls forever in both directions');

  // Section 2 — basic creation
  print('\n--- Basic creation ---');
  print('Created with ${seasons.length} children');
  print('runtimeType: ${loopingDelegate.runtimeType}');

  // Section 3 — estimatedChildCount
  print('\n--- estimatedChildCount ---');
  print('estimatedChildCount: ${loopingDelegate.estimatedChildCount}');
  print('Returns null — infinite items');

  // Section 4 — build with wrapping
  print('\n--- Build wrapping ---');
  for (final idx in [-4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8]) {
    final w = loopingDelegate.build(context, idx);
    print('  build($idx): $w');
  }

  // Section 5 — trueIndexOf
  print('\n--- trueIndexOf ---');
  for (final idx in [-4, -3, -1, 0, 1, 3, 4, 7, 8]) {
    print('  trueIndexOf($idx): ${loopingDelegate.trueIndexOf(idx)}');
  }

  // Section 6 — shouldRebuild
  final sameLooping =
      ListWheelChildLoopingListDelegate(children: seasons);
  final diffLooping = ListWheelChildLoopingListDelegate(
    children: [Text('A'), Text('B')],
  );
  print('\n--- shouldRebuild ---');
  print('Same list ref: ${loopingDelegate.shouldRebuild(sameLooping)}');
  print('Different list: ${loopingDelegate.shouldRebuild(diffLooping)}');

  // Section 7 — modulo math
  print('\n--- Modulo math (4 items) ---');
  for (var i = -8; i <= 8; i++) {
    final mapped = i % 4;
    print('  $i %% 4 = $mapped');
  }

  // Section 8 — clock data
  final hours = List.generate(12, (i) => '${i + 1}');
  print('\n--- Clock wheel ---');
  for (final h in hours) {
    print('  $h o\'clock');
  }

  // Section 9 — comparison
  print('\n--- Looping vs List delegate ---');
  print('Looping: estimatedChildCount = null (infinite)');
  print('List:    estimatedChildCount = children.length');
  print('Looping: build never returns null');
  print('List:    build returns null out of range');

  // Section 10 — summary
  print('\n${'=' * 60}');
  print('ListWheelChildLoopingListDelegate deep demo completed');

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
              colors: [deepSienna, warmBrown, camelTan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ListWheelChildLoopingListDelegate',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Infinite looping children for cylindrical wheel scroll views',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9), fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Looping', camelTan, Colors.white),
                tag('Infinite', sandstone, deepSienna),
                tag('Modulo', oatmeal, deepSienna),
                tag('Circular', parchment, deepSienna),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is ListWheelChildLoopingListDelegate',
            'Wraps a finite list into an infinite scrolling wheel',
            deepSienna, Colors.white),
        noteBox(
          'ListWheelChildLoopingListDelegate takes a fixed list of child '
          'widgets and makes them repeat infinitely. As the user scrolls '
          'past the last item, the first item appears again seamlessly. '
          'This is achieved through modulo arithmetic on the index — the '
          'build method uses index %% children.length to wrap around.',
          deepSienna,
          cream,
        ),
        dataRow('Extends', 'ListWheelChildDelegate', warmBrown),
        dataRow('Key behavior', 'Infinite wrapping via modulo', camelTan),
        dataRow('estimatedChildCount', 'null (infinite)', sandstone),
        const SizedBox(height: 14),

        // ── 3. Basic creation ────────────────────────────────────────
        sectionBanner('2 \u00b7 Basic Creation — Seasons',
            'Four items that loop forever', warmBrown, Colors.white),
        dataRow('children.length', '${seasons.length}', deepSienna),
        dataRow('estimatedChildCount', '${loopingDelegate.estimatedChildCount}', warmBrown),
        const SizedBox(height: 8),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: ivory,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: oatmeal),
          ),
          child: Stack(
            children: [
              ListWheelScrollView.useDelegate(
                itemExtent: 42,
                diameterRatio: 1.6,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: [
                    for (final season in [
                      ('\u{1F338}', 'Spring', const Color(0xFFE8F5E9)),
                      ('\u{2600}', 'Summer', const Color(0xFFFFF8E1)),
                      ('\u{1F342}', 'Autumn', const Color(0xFFFBE9E7)),
                      ('\u{2744}', 'Winter', const Color(0xFFE3F2FD)),
                    ])
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: season.$3,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: deepSienna.withValues(alpha: 0.15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(season.$1,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 10),
                            Text(season.$2,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: deepSienna)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: deepSienna, width: 2),
                      bottom: BorderSide(color: deepSienna, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        noteBox(
          'Scroll up or down — the seasons repeat endlessly!',
          goldenrod,
          const Color(0xFFFFF8E1),
        ),
        const SizedBox(height: 14),

        // ── 4. Build method with wrapping ────────────────────────────
        sectionBanner('3 \u00b7 Build Method — Never Returns Null',
            'Modulo arithmetic maps any index to a valid child',
            camelTan, Colors.white),
        noteBox(
          'Unlike the list delegate, the looping delegate\'s build() never '
          'returns null. For any integer index (positive, negative, huge), '
          'it computes index %% children.length to find the actual child. '
          'This is what creates the infinite scrolling effect.',
          camelTan,
          cream,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ivory,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 60, child: Text('Index',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: deepSienna))),
                  SizedBox(width: 80, child: Text('index %% 4',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: deepSienna))),
                  Expanded(child: Text('Result',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: deepSienna))),
                ],
              ),
              const Divider(),
              for (final idx in [-4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text('$idx',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: idx < 0 ? burntAmber : deepSienna))),
                      SizedBox(width: 80, child: Text('${idx % 4}',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: camelTan))),
                      Expanded(child: Text(
                          '${loopingDelegate.build(context, idx)}',
                          style: TextStyle(
                              fontSize: 12, color: deepSienna))),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. trueIndexOf deep dive ─────────────────────────────────
        sectionBanner('4 \u00b7 trueIndexOf — Unwrapping the True Position',
            'Maps any scroll index back to the actual child index',
            deepSienna, Colors.white),
        noteBox(
          'trueIndexOf uses modulo to map any index back to the range '
          '[0, children.length). This tells you which real child is being '
          'displayed at any scroll position. Essential for connecting the '
          'infinite scroll position to your data model.',
          deepSienna,
          cream,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ivory,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            children: [
              for (final idx in [-8, -7, -5, -4, -3, -1, 0, 1, 3, 4, 5, 7, 8])
                indexCell(
                  idx,
                  '${loopingDelegate.trueIndexOf(idx)}',
                  idx >= 0 && idx < 4 ? parchment : cream,
                  deepSienna,
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. shouldRebuild ─────────────────────────────────────────
        sectionBanner('5 \u00b7 shouldRebuild — Same as List Delegate',
            'Compares children list references',
            warmBrown, Colors.white),
        dataRow('Same list object', '${loopingDelegate.shouldRebuild(sameLooping)}', deepSienna),
        dataRow('Different list', '${loopingDelegate.shouldRebuild(diffLooping)}', burntAmber),
        noteBox(
          'shouldRebuild works identically to ListWheelChildListDelegate — '
          'it compares children list references. Same list object → false '
          '(no rebuild). Different list → true (rebuild needed).',
          warmBrown,
          cream,
        ),
        const SizedBox(height: 14),

        // ── 7. Modulo math table ─────────────────────────────────────
        sectionBanner('6 \u00b7 Modulo Arithmetic Visualized',
            'How indices wrap for 4 children',
            camelTan, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepSienna),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Scroll Index',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Real Index',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Season',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ],
              ),
              for (final i in [-4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7])
                TableRow(
                  decoration: BoxDecoration(
                    color: i >= 0 && i < 4
                        ? parchment
                        : ivory,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('$i',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              fontWeight: i >= 0 && i < 4
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: i < 0 ? burntAmber : deepSienna)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('${i % 4}',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: camelTan)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        ['Spring', 'Summer', 'Autumn', 'Winter'][i % 4],
                        style: TextStyle(fontSize: 12, color: deepSienna),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        noteBox(
          'Notice: indices 0\u20133 are the "home" range (highlighted). '
          'All other indices wrap into this range using modulo.',
          deepSienna,
          parchment,
        ),
        const SizedBox(height: 14),

        // ── 8. Clock selector ────────────────────────────────────────
        sectionBanner('7 \u00b7 Clock Hour Selector',
            'Classic circular selection — 12 hours looping forever',
            deepSienna, Colors.white),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: ivory,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: oatmeal),
          ),
          child: Stack(
            children: [
              ListWheelScrollView.useDelegate(
                itemExtent: 50,
                diameterRatio: 1.4,
                perspective: 0.003,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: [
                    for (var h = 1; h <= 12; h++)
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        decoration: BoxDecoration(
                          color: h <= 6
                              ? const Color(0xFFFFF8E1)
                              : const Color(0xFFE8EAF6),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: deepSienna.withValues(alpha: 0.15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              h <= 6 ? Icons.wb_sunny : Icons.nights_stay,
                              size: 20,
                              color: h <= 6 ? goldenrod : deepSienna,
                            ),
                            const SizedBox(width: 12),
                            Text('$h',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: deepSienna)),
                            const SizedBox(width: 6),
                            Text("o'clock",
                                style: TextStyle(
                                    fontSize: 13, color: camelTan)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: deepSienna, width: 2),
                      bottom: BorderSide(color: deepSienna, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Compass wheel ─────────────────────────────────────────
        sectionBanner('8 \u00b7 Compass Directions',
            'Four cardinal + four ordinal directions looping',
            warmBrown, Colors.white),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: ivory,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: sandstone.withValues(alpha: 0.5)),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 44,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
              children: [
                for (final dir in [
                  ('N', '\u2191', 'North', 0),
                  ('NE', '\u2197', 'Northeast', 45),
                  ('E', '\u2192', 'East', 90),
                  ('SE', '\u2198', 'Southeast', 135),
                  ('S', '\u2193', 'South', 180),
                  ('SW', '\u2199', 'Southwest', 225),
                  ('W', '\u2190', 'West', 270),
                  ('NW', '\u2196', 'Northwest', 315),
                ])
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: dir.$4 % 90 == 0 ? parchment : cream,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: deepSienna,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(dir.$1,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        const SizedBox(width: 8),
                        Text(dir.$2,
                            style: TextStyle(
                                fontSize: 18, color: deepSienna)),
                        const SizedBox(width: 8),
                        Text(dir.$3,
                            style: TextStyle(
                                fontSize: 14,
                                color: deepSienna,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        Text('${dir.$4}\u00b0',
                            style: TextStyle(
                                fontSize: 11, color: sandstone)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Comparison with list ─────────────────────────────────
        sectionBanner('9 \u00b7 Looping vs List Delegate',
            'Side-by-side comparison of behaviors',
            camelTan, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepSienna),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Aspect',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('ListDelegate',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('LoopingDelegate',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ],
              ),
              for (final row in [
                ('Scrolling', 'Stops at ends', 'Loops infinitely'),
                ('estimatedCount', 'children.length', 'null'),
                ('build(out)', 'Returns null', 'Wraps via %%'),
                ('trueIndexOf', 'Identity', 'index %% length'),
                ('shouldRebuild', 'List ref compare', 'List ref compare'),
                ('Use case', 'Fixed sets', 'Circular selectors'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: deepSienna)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(fontSize: 11, color: deepSienna)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(fontSize: 11, color: deepSienna)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Planet scale ─────────────────────────────────────────
        sectionBanner('10 \u00b7 Solar System Wheel',
            'Looping through planets endlessly',
            deepSienna, Colors.white),
        Container(
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF1A237E), const Color(0xFF0D47A1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 44,
            diameterRatio: 1.5,
            perspective: 0.003,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
              children: [
                for (final planet in [
                  ('\u263F', 'Mercury', const Color(0xFFBDBDBD)),
                  ('\u2640', 'Venus', const Color(0xFFFFCC80)),
                  ('\u2641', 'Earth', const Color(0xFF81C784)),
                  ('\u2642', 'Mars', const Color(0xFFEF5350)),
                  ('\u2643', 'Jupiter', const Color(0xFFFFB74D)),
                  ('\u2644', 'Saturn', const Color(0xFFFFE082)),
                  ('\u2645', 'Uranus', const Color(0xFF80DEEA)),
                  ('\u2646', 'Neptune', const Color(0xFF5C6BC0)),
                ])
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      color: planet.$3.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: planet.$3.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(planet.$1,
                            style: TextStyle(
                                fontSize: 20, color: planet.$3)),
                        const SizedBox(width: 12),
                        Text(planet.$2,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Real-world pattern ───────────────────────────────────
        sectionBanner('11 \u00b7 Real-world: Month-Year Picker',
            'Classic pattern: looping months with static year',
            warmBrown, Colors.white),
        noteBox(
          'Date/time pickers are the quintessential use case for the '
          'looping delegate. Months (12 items) and hours (12/24 items) '
          'naturally repeat. The user can scroll continuously without '
          'hitting an end, mimicking a physical rotating dial.',
          warmBrown,
          cream,
        ),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: ivory,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: oatmeal),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            diameterRatio: 1.8,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
              children: [
                for (final month in [
                  'January', 'February', 'March', 'April',
                  'May', 'June', 'July', 'August',
                  'September', 'October', 'November', 'December',
                ])
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      color: parchment,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(month,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: deepSienna)),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. When to use ──────────────────────────────────────────
        sectionBanner('12 \u00b7 When to Choose Looping',
            'Decision framework', deepSienna, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final scenario in [
                ('Hours (12/24)', '\u2713 Looping', true),
                ('Months (12)', '\u2713 Looping', true),
                ('Compass (8)', '\u2713 Looping', true),
                ('Seasons (4)', '\u2713 Looping', true),
                ('Countries (195)', '\u2717 Builder', false),
                ('One-time list', '\u2717 List', false),
                ('Dynamic items', '\u2717 Builder', false),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: scenario.$3
                              ? deepSienna
                              : sandstone,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          scenario.$3 ? '\u2713' : '\u2717',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 130,
                        child: Text(scenario.$1,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: deepSienna)),
                      ),
                      tag(scenario.$2,
                          scenario.$3 ? parchment : cream,
                          deepSienna),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Inheritance hierarchy ────────────────────────────────
        sectionBanner('13 \u00b7 Inheritance Hierarchy',
            'Class relationships', sandstone, deepSienna),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                'Object',
                '  \u2514\u2500 ListWheelChildDelegate (abstract)',
                '       \u251c\u2500 ListWheelChildBuilderDelegate',
                '       \u251c\u2500 ListWheelChildListDelegate',
                '       \u2514\u2500 ListWheelChildLoopingListDelegate  \u2605',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: line.contains('\u2605')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: line.contains('\u2605')
                              ? deepSienna
                              : warmBrown)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance notes ────────────────────────────────────
        sectionBanner('14 \u00b7 Performance Considerations',
            'Memory and rebuild behavior', warmBrown, Colors.white),
        noteBox(
          'Despite infinite scrolling, memory usage matches the list '
          'delegate — only the actual children list is stored. The modulo '
          'operation is O(1). The viewport only renders visible items plus '
          'a small buffer, regardless of the infinite range.',
          warmBrown,
          cream,
        ),
        dataRow('Memory', 'O(children.length)', deepSienna),
        dataRow('Build cost', 'O(1) per index', warmBrown),
        dataRow('Rendered items', '~5-7 visible', camelTan),
        dataRow('Scroll range', 'Unbounded (infinite)', burntAmber),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepSienna, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepSienna, warmBrown],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Loops a fixed child list infinitely via modulo',
                'estimatedChildCount returns null (infinite)',
                'build() never returns null — wraps any index',
                'trueIndexOf maps scroll index to real child index',
                'shouldRebuild compares list references (same as list)',
                'Perfect for clocks, compasses, months, seasons',
                'Memory footprint equals the original list size',
                'Mimics physical rotating dials and selectors',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: goldenrod,
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
