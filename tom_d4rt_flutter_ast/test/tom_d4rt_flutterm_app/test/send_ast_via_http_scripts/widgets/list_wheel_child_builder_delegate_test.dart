// ignore_for_file: avoid_print
// D4rt deep demo: ListWheelChildBuilderDelegate — lazily building children for list wheels
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Ocean / Azure ─────────────────────────────────────────
  const deepOcean = Color(0xFF0A3D62);
  const midnightTide = Color(0xFF1B6CA1);
  const azureWave = Color(0xFF2E86C1);
  const skyAqua = Color(0xFF5DADE2);
  const foamCrest = Color(0xFF85C1E9);
  const seaMist = Color(0xFFAED6F1);
  const icyPearl = Color(0xFFD6EAF8);
  const lightSurge = Color(0xFFEBF5FB);
  const coralAccent = Color(0xFFE74C3C);
  const sandGold = Color(0xFFF39C12);

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
                  style: TextStyle(color: fg.withValues(alpha: 0.85), fontSize: 12)),
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
      child: Text(text, style: TextStyle(fontSize: 13, color: deepOcean)),
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
                style: TextStyle(fontSize: 13, color: deepOcean)),
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
      child:
          Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  Widget wheelItem(String label, Color bg, Color fg) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: fg.withValues(alpha: 0.25)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('ListWheelChildBuilderDelegate deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is ListWheelChildBuilderDelegate ---');
  print('A delegate that supplies children for ListWheelScrollView lazily');
  print('Children are built on-demand via a builder callback');
  print('Useful for large or infinite lists where pre-building is wasteful');

  // Section 2 — bounded builder
  print('\n--- Bounded builder ---');
  final boundedDelegate = ListWheelChildBuilderDelegate(
    builder: (ctx, index) {
      if (index < 0 || index >= 12) return null;
      return Text('Month ${index + 1}');
    },
    childCount: 12,
  );
  print('Created bounded delegate: childCount=${boundedDelegate.childCount}');
  print('estimatedChildCount: ${boundedDelegate.estimatedChildCount}');
  print('runtimeType: ${boundedDelegate.runtimeType}');

  // Section 3 — unbounded builder
  print('\n--- Unbounded builder ---');
  final unboundedDelegate = ListWheelChildBuilderDelegate(
    builder: (ctx, index) => Text('Item $index'),
  );
  print('Created unbounded delegate');
  print('childCount: ${unboundedDelegate.childCount}');
  print('estimatedChildCount: ${unboundedDelegate.estimatedChildCount}');

  // Section 4 — build method
  print('\n--- Build method ---');
  final child0 = boundedDelegate.build(context, 0);
  final child11 = boundedDelegate.build(context, 11);
  final childOver = boundedDelegate.build(context, 15);
  print('build(0): $child0');
  print('build(11): $child11');
  print('build(15): $childOver');
  print('Out-of-range returns null → framework stops requesting');

  // Section 5 — trueIndexOf
  print('\n--- trueIndexOf ---');
  print('trueIndexOf(0): ${boundedDelegate.trueIndexOf(0)}');
  print('trueIndexOf(5): ${boundedDelegate.trueIndexOf(5)}');
  print('For non-looping delegates, trueIndexOf returns the index as-is');

  // Section 6 — shouldRebuild
  print('\n--- shouldRebuild ---');
  final anotherDelegate = ListWheelChildBuilderDelegate(
    builder: (ctx, index) => Text('Item $index'),
    childCount: 12,
  );
  print('shouldRebuild: ${boundedDelegate.shouldRebuild(anotherDelegate)}');
  print('Always true — builder closures cannot be compared');

  // Section 7 — inheritance
  print('\n--- Inheritance ---');
  print('ListWheelChildBuilderDelegate extends ListWheelChildDelegate');
  print('Key API: build(), estimatedChildCount, trueIndexOf(), shouldRebuild()');

  // Section 8 — fruits wheel
  final fruits = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon',
  ];
  print('\n--- Fruit picker wheel (10 items) ---');
  for (int i = 0; i < fruits.length; i++) {
    print('  [$i] ${fruits[i]}');
  }

  // Section 9 — hour picker
  print('\n--- Hour picker (24 items) ---');
  print('Hours 0..23 built lazily, only visible items constructed');

  // Section 10 — color-coded items
  print('\n--- Color-coded score wheel ---');
  print('Scores 0-100: red < 40, gold 40-70, green > 70');

  // Section 11 — performance
  print('\n--- Performance notes ---');
  print('Builder delegate creates children on demand');
  print('Only visible region + offscreen buffer is materialized');
  print('Ideal for hundreds/thousands of items');

  // Section 12 — vs ListWheelChildListDelegate
  print('\n--- Vs ListWheelChildListDelegate ---');
  print('Builder: lazy, memory-efficient, good for large lists');
  print('List: eager, all children in memory, good for small lists');

  // Section 13 — null return contract
  print('\n--- Null return contract ---');
  print('When builder returns null, framework knows list has ended');
  print('childCount is a hint but null return is authoritative');

  // Section 14 — real-world patterns
  print('\n--- Real-world patterns ---');
  print('Date pickers, number selectors, font size choosers');
  print('Country/timezone pickers, emoji selectors');

  // Section 15 — ListWheelScrollView integration
  print('\n--- Integration with ListWheelScrollView ---');
  print('ListWheelScrollView.useDelegate(childDelegate: builderDelegate)');

  // Section 16 — summary
  print('\n${'=' * 60}');
  print('ListWheelChildBuilderDelegate deep demo completed');

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
              colors: [deepOcean, midnightTide, azureWave],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ListWheelChildBuilderDelegate',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Lazily builds children for cylindrical wheel scroll views',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9), fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('ListWheelScrollView', azureWave, Colors.white),
                tag('Lazy Builder', skyAqua, deepOcean),
                tag('On-Demand', foamCrest, deepOcean),
                tag('Performance', seaMist, deepOcean),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 · What Is ListWheelChildBuilderDelegate',
            'A delegate that lazily supplies children for ListWheelScrollView',
            deepOcean, Colors.white),
        noteBox(
          'ListWheelChildBuilderDelegate creates children on-demand using a '
          'builder callback. Unlike ListWheelChildListDelegate which holds '
          'all children in memory, this delegate only materializes items '
          'that are currently visible (plus a small off-screen buffer). '
          'This makes it ideal for large or conceptually infinite lists.',
          deepOcean,
          lightSurge,
        ),
        dataRow('Extends', 'ListWheelChildDelegate', midnightTide),
        dataRow('Key property', 'builder: NullableIndexedWidgetBuilder', azureWave),
        dataRow('Optional', 'childCount: int?', skyAqua),
        const SizedBox(height: 14),

        // ── 3. Bounded builder demo ──────────────────────────────────
        sectionBanner('2 · Bounded Builder — Month Picker',
            'Builder with childCount=12, returns null outside range',
            midnightTide, Colors.white),
        noteBox(
          'When childCount is specified, the framework knows the exact range. '
          'The builder should return null for indices outside [0, childCount). '
          'This bounded mode is used for pickers with known item counts.',
          midnightTide,
          icyPearl,
        ),
        dataRow('childCount', '${boundedDelegate.childCount}', deepOcean),
        dataRow('estimatedChildCount', '${boundedDelegate.estimatedChildCount}', midnightTide),
        dataRow('build(0)', '$child0', azureWave),
        dataRow('build(11)', '$child11', skyAqua),
        dataRow('build(15)', '$childOver', coralAccent),
        const SizedBox(height: 8),
        // Live month wheel
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: lightSurge,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: azureWave.withValues(alpha: 0.3)),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            diameterRatio: 1.8,
            perspective: 0.003,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (ctx, index) {
                if (index < 0 || index >= 12) return null;
                final months = [
                  'January', 'February', 'March', 'April',
                  'May', 'June', 'July', 'August',
                  'September', 'October', 'November', 'December',
                ];
                return wheelItem(months[index], icyPearl, deepOcean);
              },
              childCount: 12,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Unbounded builder ─────────────────────────────────────
        sectionBanner('3 · Unbounded Builder — Infinite Counter',
            'No childCount specified, theoretically infinite items',
            azureWave, Colors.white),
        noteBox(
          'Without childCount, the delegate is unbounded. The builder is called '
          'for any index and never returns null. The framework keeps requesting '
          'items as the user scrolls. This is useful for infinite scroll patterns '
          'like a never-ending number picker.',
          azureWave,
          icyPearl,
        ),
        dataRow('childCount', '${unboundedDelegate.childCount}', deepOcean),
        dataRow('estimatedChildCount', '${unboundedDelegate.estimatedChildCount}', midnightTide),
        const SizedBox(height: 8),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: lightSurge,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: skyAqua.withValues(alpha: 0.3)),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 36,
            diameterRatio: 2.0,
            perspective: 0.004,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (ctx, index) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: index.isEven ? icyPearl : seaMist,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('#$index',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: deepOcean)),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Build method details ──────────────────────────────────
        sectionBanner('4 · Build Method & Null Contract',
            'How the builder callback drives child creation',
            skyAqua, Colors.white),
        noteBox(
          'The build(context, index) method calls the builder callback. '
          'When the builder returns null, the framework interprets this as '
          '"no more children in this direction." For bounded delegates, '
          'the childCount is a hint; the null return is authoritative. '
          'The framework may probe indices beyond childCount.',
          skyAqua,
          lightSurge,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: icyPearl,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Build Contract:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: deepOcean)),
              const SizedBox(height: 6),
              dataRow('Valid index', 'Returns Widget', azureWave),
              dataRow('Out-of-range', 'Returns null', coralAccent),
              dataRow('Negative index', 'Returns null', coralAccent),
              dataRow('childCount set', 'Hint for optimization', sandGold),
              dataRow('childCount null', 'Infinite (never null)', midnightTide),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. trueIndexOf ───────────────────────────────────────────
        sectionBanner('5 · trueIndexOf — Index Mapping',
            'For non-looping delegates, returns index unchanged',
            foamCrest, deepOcean),
        noteBox(
          'trueIndexOf(index) maps a wheel index to the true child index. '
          'For ListWheelChildBuilderDelegate (non-looping), this is always '
          'the identity: trueIndexOf(n) == n. For looping delegates, this '
          'maps wrapped indices back to the source list position.',
          foamCrest,
          lightSurge,
        ),
        dataRow('trueIndexOf(0)', '${boundedDelegate.trueIndexOf(0)}', deepOcean),
        dataRow('trueIndexOf(5)', '${boundedDelegate.trueIndexOf(5)}', midnightTide),
        dataRow('trueIndexOf(11)', '${boundedDelegate.trueIndexOf(11)}', azureWave),
        dataRow('trueIndexOf(99)', '${boundedDelegate.trueIndexOf(99)}', skyAqua),
        const SizedBox(height: 14),

        // ── 7. shouldRebuild ─────────────────────────────────────────
        sectionBanner('6 · shouldRebuild Behavior',
            'Always returns true — builder closures are not comparable',
            midnightTide, Colors.white),
        noteBox(
          'shouldRebuild(oldDelegate) always returns true because Dart cannot '
          'compare function closures for equality. This means the framework '
          'will always rebuild children when a new delegate is provided. '
          'In practice, this is fine because the builder function is cheap.',
          midnightTide,
          icyPearl,
        ),
        dataRow('shouldRebuild(any)', '${boundedDelegate.shouldRebuild(anotherDelegate)}', deepOcean),
        dataRow('Reason', 'Cannot compare closures', azureWave),
        const SizedBox(height: 14),

        // ── 8. Fruit picker wheel ────────────────────────────────────
        sectionBanner('7 · Fruit Picker — Styled Builder Items',
            'Custom-styled items with emoji icons',
            deepOcean, Colors.white),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: lightSurge,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepOcean.withValues(alpha: 0.2)),
          ),
          child: Stack(
            children: [
              ListWheelScrollView.useDelegate(
                itemExtent: 46,
                diameterRatio: 1.6,
                perspective: 0.003,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (ctx, index) {
                    if (index < 0 || index >= fruits.length) return null;
                    final emojis = [
                      '\u{1F34E}', '\u{1F34C}', '\u{1F352}', '\u{1F351}', '\u{1F347}',
                      '\u{1F95D}', '\u{1F349}', '\u{1F348}', '\u{1F34A}', '\u{1F34B}',
                    ];
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            icyPearl,
                            seaMist.withValues(alpha: 0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('${emojis[index]}  ${fruits[index]}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: deepOcean)),
                    );
                  },
                  childCount: fruits.length,
                ),
              ),
              // Selection indicator
              Center(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: azureWave, width: 2),
                      bottom: BorderSide(color: azureWave, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Hour picker ───────────────────────────────────────────
        sectionBanner('8 · 24-Hour Picker — Large Bounded Builder',
            'All 24 hours lazily built with AM/PM labels',
            azureWave, Colors.white),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: icyPearl,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            diameterRatio: 2.0,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (ctx, index) {
                if (index < 0 || index >= 24) return null;
                final period = index < 12 ? 'AM' : 'PM';
                final hour12 = index == 0
                    ? 12
                    : (index > 12 ? index - 12 : index);
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    color: index < 12
                        ? seaMist.withValues(alpha: 0.5)
                        : foamCrest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$hour12:00',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: deepOcean)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: index < 12 ? sandGold : midnightTide,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(period,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
              childCount: 24,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Color-coded score wheel ──────────────────────────────
        sectionBanner('9 · Score Picker — Conditional Styling',
            'Colors change based on value: red < 40, gold 40-70, green > 70',
            skyAqua, Colors.white),
        noteBox(
          'The builder callback can apply conditional logic to style items '
          'differently based on their index or computed value. This demonstrates '
          'dynamic color coding within a wheel without separate delegates.',
          skyAqua,
          lightSurge,
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: lightSurge,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: skyAqua.withValues(alpha: 0.3)),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 38,
            diameterRatio: 1.8,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (ctx, index) {
                if (index < 0 || index > 100) return null;
                final score = index;
                Color scoreBg;
                Color scoreFg;
                String tier;
                if (score < 40) {
                  scoreBg = coralAccent.withValues(alpha: 0.15);
                  scoreFg = coralAccent;
                  tier = 'LOW';
                } else if (score <= 70) {
                  scoreBg = sandGold.withValues(alpha: 0.15);
                  scoreFg = sandGold;
                  tier = 'MID';
                } else {
                  scoreBg = const Color(0xFF27AE60).withValues(alpha: 0.15);
                  scoreFg = const Color(0xFF27AE60);
                  tier = 'HIGH';
                }
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  decoration: BoxDecoration(
                    color: scoreBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$score',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: scoreFg)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: scoreFg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(tier,
                            style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
              childCount: 101,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Performance notes ────────────────────────────────────
        sectionBanner('10 · Performance Characteristics',
            'Why builder delegates are memory-efficient',
            foamCrest, deepOcean),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: lightSurge,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.speed, size: 18, color: deepOcean),
                const SizedBox(width: 8),
                Text('Performance Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: deepOcean)),
              ]),
              const SizedBox(height: 10),
              dataRow('Lazy creation', 'Children built on scroll', deepOcean),
              dataRow('Memory', 'Only visible + buffer in memory', midnightTide),
              dataRow('Disposal', 'Off-screen children recycled', azureWave),
              dataRow('Best for', '> 20 items, or unbounded lists', skyAqua),
              const SizedBox(height: 8),
              noteBox(
                'Unlike ListWheelChildListDelegate which holds all Widget '
                'instances simultaneously, the builder delegate creates and '
                'disposes widgets as they scroll in and out of view. This is '
                'particularly important for ListWheelScrollView because the '
                'cylindrical viewport only shows ~5-8 items at any time.',
                midnightTide,
                icyPearl,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Vs ListWheelChildListDelegate ────────────────────────
        sectionBanner('11 · Builder vs List Delegate Comparison',
            'When to choose each approach',
            midnightTide, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: icyPearl,
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
                decoration: BoxDecoration(color: deepOcean),
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
                    child: Text('BuilderDelegate',
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
                ],
              ),
              TableRow(
                decoration: BoxDecoration(color: lightSurge),
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Creation',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Lazy (on demand)',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Eager (all upfront)',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Memory',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('O(visible)',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('O(total)',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(color: lightSurge),
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Infinite',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Yes (null childCount)',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('No (finite list)',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Best for',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Large / dynamic sets',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Small fixed sets',
                          style: TextStyle(fontSize: 11, color: deepOcean))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Null contract visual ─────────────────────────────────
        sectionBanner('12 · Null Return Contract',
            'How the framework uses null to detect list boundaries',
            azureWave, Colors.white),
        noteBox(
          'When the builder returns null for an index, the framework '
          'stops requesting children in that direction. This is the '
          'authoritative signal for list boundaries. childCount serves '
          'as an optimization hint, but the null return from the builder '
          'is what actually controls behavior.',
          azureWave,
          lightSurge,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: icyPearl,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (int i = -2; i <= 14; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text('index $i',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepOcean)),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        i >= 0 && i < 12 ? Icons.check_circle : Icons.cancel,
                        color: i >= 0 && i < 12 ? azureWave : coralAccent,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        i >= 0 && i < 12 ? 'Widget returned' : 'null → stop',
                        style: TextStyle(
                            fontSize: 12,
                            color: i >= 0 && i < 12
                                ? deepOcean
                                : coralAccent),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Real-world patterns ──────────────────────────────────
        sectionBanner('13 · Real-World Use Patterns',
            'Common scenarios where builder delegates shine',
            deepOcean, Colors.white),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final pattern in [
              'Date Picker',
              'Time Selector',
              'Font Size Wheel',
              'Country Picker',
              'Timezone Chooser',
              'Currency Selector',
              'Year Picker',
              'Temperature Control',
            ])
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: lightSurge,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: azureWave.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.settings, size: 14, color: midnightTide),
                    const SizedBox(width: 6),
                    Text(pattern,
                        style: TextStyle(fontSize: 12, color: deepOcean)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),

        // ── 15. Integration ──────────────────────────────────────────
        sectionBanner('14 · ListWheelScrollView Integration',
            'How the delegate plugs into the scroll view',
            skyAqua, Colors.white),
        noteBox(
          'Use ListWheelScrollView.useDelegate() to pass a builder delegate. '
          'The scroll view creates a ListWheelViewport internally, which '
          'creates a ListWheelElement that calls into the delegate\'s '
          'build() method as items scroll into view. The element acts as '
          'the ListWheelChildManager bridging delegate and render object.',
          skyAqua,
          lightSurge,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: icyPearl,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Widget Tree:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: deepOcean)),
              const SizedBox(height: 6),
              for (final line in [
                'ListWheelScrollView',
                '  └─ ListWheelViewport',
                '       └─ ListWheelElement (manages children)',
                '            └─ BuilderDelegate.build(ctx, index)',
                '                 └─ Your Widget (or null)',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: deepOcean)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Inheritance hierarchy ────────────────────────────────
        sectionBanner('15 · Inheritance Hierarchy',
            'Class relationships', foamCrest, deepOcean),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: lightSurge,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                'Object',
                '  └─ ListWheelChildDelegate (abstract)',
                '       ├─ ListWheelChildBuilderDelegate  ★',
                '       ├─ ListWheelChildListDelegate',
                '       └─ ListWheelChildLoopingListDelegate',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: line.contains('★')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: line.contains('★')
                              ? deepOcean
                              : midnightTide)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 17. Summary dashboard ────────────────────────────────────
        sectionBanner('16 · Summary',
            'Key takeaways', deepOcean, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepOcean, midnightTide],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Lazily builds children via builder callback',
                'Optional childCount bounds the list',
                'Null return signals list boundary',
                'trueIndexOf returns identity for non-looping',
                'shouldRebuild always returns true',
                'Ideal for large or infinite item sets',
                'Used with ListWheelScrollView.useDelegate()',
                'Memory-efficient: only visible items in memory',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('•  ',
                          style: TextStyle(
                              color: sandGold,
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
