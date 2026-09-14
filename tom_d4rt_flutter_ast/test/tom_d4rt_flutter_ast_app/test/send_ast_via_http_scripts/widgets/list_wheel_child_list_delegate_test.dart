// ignore_for_file: avoid_print
// D4rt deep demo: ListWheelChildListDelegate — explicit child list for wheel views
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Lime / Chartreuse ─────────────────────────────────────
  const deepLime = Color(0xFF2E7D32);
  const forestChartreuse = Color(0xFF388E3C);
  const vibrantGreen = Color(0xFF43A047);
  const springLeaf = Color(0xFF66BB6A);
  const mintGreen = Color(0xFF81C784);
  const paleClover = Color(0xFFA5D6A7);
  const dewDrop = Color(0xFFC8E6C9);
  const frostGreen = Color(0xFFE8F5E9);
  const warningOrange = Color(0xFFEF6C00);
  const accentYellow = Color(0xFFFDD835);

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
      child: Text(text, style: TextStyle(fontSize: 13, color: deepLime)),
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
                style: TextStyle(fontSize: 13, color: deepLime)),
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

  Widget colorChip(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: deepLime.withValues(alpha: 0.2)),
      ),
      child: Text(name,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color.computeLuminance() > 0.5 ? deepLime : Colors.white)),
    );
  }

  // ── Create delegates and gather data ───────────────────────────────
  print('ListWheelChildListDelegate deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is ListWheelChildListDelegate ---');
  print('Supplies children for ListWheelScrollView from a fixed list');
  print('All children are pre-built and held in memory');
  print('Simple and direct — best for small known item sets');

  // Section 2 — basic creation
  final basicChildren = <Widget>[
    Text('Apple'), Text('Banana'), Text('Cherry'),
    Text('Date'), Text('Elderberry'),
  ];
  final basicDelegate = ListWheelChildListDelegate(children: basicChildren);
  print('\n--- Basic creation ---');
  print('Created with ${basicChildren.length} children');
  print('runtimeType: ${basicDelegate.runtimeType}');
  print('children.length: ${basicDelegate.children.length}');

  // Section 3 — estimatedChildCount
  print('\n--- estimatedChildCount ---');
  print('estimatedChildCount: ${basicDelegate.estimatedChildCount}');
  print('Always equals children.length');

  // Section 4 — build method
  print('\n--- Build method ---');
  final built0 = basicDelegate.build(context, 0);
  final built2 = basicDelegate.build(context, 2);
  final builtNeg = basicDelegate.build(context, -1);
  final builtOver = basicDelegate.build(context, 10);
  print('build(0): $built0');
  print('build(2): $built2');
  print('build(-1): $builtNeg');
  print('build(10): $builtOver');

  // Section 5 — trueIndexOf
  print('\n--- trueIndexOf ---');
  print('trueIndexOf(0): ${basicDelegate.trueIndexOf(0)}');
  print('trueIndexOf(4): ${basicDelegate.trueIndexOf(4)}');
  print('Identity function for list delegates');

  // Section 6 — shouldRebuild
  final sameDelegate = ListWheelChildListDelegate(children: basicChildren);
  final diffDelegate = ListWheelChildListDelegate(
    children: [Text('X'), Text('Y')],
  );
  print('\n--- shouldRebuild ---');
  print('Same list ref: ${basicDelegate.shouldRebuild(sameDelegate)}');
  print('Different list: ${basicDelegate.shouldRebuild(diffDelegate)}');

  // Section 7 — empty delegate
  final emptyDelegate = ListWheelChildListDelegate(children: []);
  print('\n--- Empty delegate ---');
  print('estimatedChildCount: ${emptyDelegate.estimatedChildCount}');
  print('build(0): ${emptyDelegate.build(context, 0)}');

  // Section 8 — single child
  final singleDelegate = ListWheelChildListDelegate(
    children: [Text('Only One')],
  );
  print('\n--- Single child ---');
  print('estimatedChildCount: ${singleDelegate.estimatedChildCount}');
  print('build(0): ${singleDelegate.build(context, 0)}');

  // Section 9 — fruit wheel data
  final fruitItems = [
    ('\u{1F34E}', 'Red Apple', Colors.red),
    ('\u{1F34C}', 'Banana', accentYellow),
    ('\u{1F352}', 'Cherry', const Color(0xFFB71C1C)),
    ('\u{1F34A}', 'Orange', warningOrange),
    ('\u{1F347}', 'Grapes', const Color(0xFF7B1FA2)),
    ('\u{1F349}', 'Watermelon', vibrantGreen),
    ('\u{1F353}', 'Strawberry', const Color(0xFFE91E63)),
  ];
  print('\n--- Fruit wheel ---');
  for (final fruit in fruitItems) {
    print('  ${fruit.$1} ${fruit.$2}');
  }

  // Section 10 — color swatch data
  final swatches = [
    ('Crimson', const Color(0xFFDC143C)),
    ('Coral', const Color(0xFFFF7F50)),
    ('Gold', const Color(0xFFFFD700)),
    ('Spring', const Color(0xFF00FF7F)),
    ('Cyan', const Color(0xFF00FFFF)),
    ('Azure', const Color(0xFF007FFF)),
    ('Violet', const Color(0xFF7F00FF)),
    ('Magenta', const Color(0xFFFF00FF)),
  ];
  print('\n--- Color swatch wheel ---');
  for (final s in swatches) {
    print('  ${s.$1}: ${s.$2}');
  }

  // Section 11 — comparison with builder
  print('\n--- Vs BuilderDelegate ---');
  print('List: all children pre-built in memory');
  print('Builder: children created lazily on scroll');
  print('List: O(n) memory   Builder: O(visible) memory');

  // Section 12 — accessing children property
  print('\n--- Children property ---');
  print('Direct access: basicDelegate.children');
  print('Length: ${basicDelegate.children.length}');
  print('Is List<Widget>: true');

  // Section 13 — when to use
  print('\n--- When to use ListWheelChildListDelegate ---');
  print('Small fixed sets: colors, days, months');
  print('Items already built (from state or model)');
  print('When memory is not a concern');

  // Section 14 — integration
  print('\n--- Integration ---');
  print('ListWheelScrollView(children: [...]) creates this automatically');
  print('Or: ListWheelScrollView.useDelegate(childDelegate: ListWheelChildListDelegate(...))');

  // Section 15 — summary
  print('\n${'=' * 60}');
  print('ListWheelChildListDelegate deep demo completed');

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
              colors: [deepLime, forestChartreuse, vibrantGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ListWheelChildListDelegate',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Pre-built child list for cylindrical wheel scroll views',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9), fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Eager', vibrantGreen, Colors.white),
                tag('Fixed List', springLeaf, deepLime),
                tag('Simple', mintGreen, deepLime),
                tag('Small Sets', paleClover, deepLime),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is ListWheelChildListDelegate',
            'The simplest wheel delegate: a plain list of widgets',
            deepLime, Colors.white),
        noteBox(
          'ListWheelChildListDelegate is the simplest of the three '
          'ListWheelChildDelegate implementations. You give it an explicit '
          'list of Widget children and it supplies them to the wheel '
          'viewport. All children are held in memory simultaneously. This '
          'is what ListWheelScrollView uses internally when you provide '
          'the children parameter directly.',
          deepLime,
          frostGreen,
        ),
        dataRow('Extends', 'ListWheelChildDelegate', forestChartreuse),
        dataRow('Key property', 'children: List<Widget>', vibrantGreen),
        dataRow('Memory model', 'All children in memory', springLeaf),
        const SizedBox(height: 14),

        // ── 3. Basic creation ────────────────────────────────────────
        sectionBanner('2 \u00b7 Basic Creation',
            'Creating a delegate with an explicit child list',
            forestChartreuse, Colors.white),
        dataRow('children.length', '${basicDelegate.children.length}', deepLime),
        dataRow('estimatedChildCount', '${basicDelegate.estimatedChildCount}', forestChartreuse),
        dataRow('runtimeType', '${basicDelegate.runtimeType}', vibrantGreen),
        const SizedBox(height: 8),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: frostGreen,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: vibrantGreen.withValues(alpha: 0.3)),
          ),
          child: ListWheelScrollView(
            itemExtent: 38,
            diameterRatio: 1.8,
            physics: const FixedExtentScrollPhysics(),
            children: [
              for (final fruit in ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'])
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: dewDrop,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(fruit,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: deepLime)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Build method ──────────────────────────────────────────
        sectionBanner('3 \u00b7 Build Method — Index-Based Access',
            'Returns the widget at a given index, or null for out-of-range',
            vibrantGreen, Colors.white),
        noteBox(
          'build(context, index) returns the child from the children list '
          'at the given position. Indices outside [0, children.length) '
          'return null, signaling to the framework that the list has ended. '
          'The context parameter is available but the widget is already built.',
          vibrantGreen,
          frostGreen,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: dewDrop,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (final idx in [-1, 0, 1, 2, 3, 4, 5, 10])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text('build(ctx, $idx)',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepLime,
                                fontFamily: 'monospace')),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        idx >= 0 && idx < 5 ? Icons.check_circle : Icons.cancel,
                        size: 16,
                        color: idx >= 0 && idx < 5 ? vibrantGreen : warningOrange,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                            idx >= 0 && idx < 5
                                ? '${basicDelegate.build(context, idx)}'
                                : 'null (out of range)',
                            style: TextStyle(
                                fontSize: 12,
                                color: idx >= 0 && idx < 5
                                    ? deepLime
                                    : warningOrange)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. trueIndexOf ───────────────────────────────────────────
        sectionBanner('4 \u00b7 trueIndexOf — Identity Mapping',
            'Non-looping delegates return the index unchanged',
            springLeaf, deepLime),
        noteBox(
          'For ListWheelChildListDelegate, trueIndexOf(index) is always '
          'the identity function: it returns the same index. This is because '
          'items are not wrapped or repeated. The method exists to provide '
          'a consistent API with the looping variant.',
          springLeaf,
          frostGreen,
        ),
        dataRow('trueIndexOf(0)', '${basicDelegate.trueIndexOf(0)}', deepLime),
        dataRow('trueIndexOf(2)', '${basicDelegate.trueIndexOf(2)}', forestChartreuse),
        dataRow('trueIndexOf(4)', '${basicDelegate.trueIndexOf(4)}', vibrantGreen),
        dataRow('trueIndexOf(99)', '${basicDelegate.trueIndexOf(99)}', springLeaf),
        const SizedBox(height: 14),

        // ── 6. shouldRebuild ─────────────────────────────────────────
        sectionBanner('5 \u00b7 shouldRebuild Behavior',
            'Compares children list reference',
            deepLime, Colors.white),
        noteBox(
          'shouldRebuild(oldDelegate) compares the children list references. '
          'If the new delegate uses the same List object, it returns false '
          '(no rebuild needed). If a new List is passed (even with identical '
          'contents), it returns true. This is by identity, not by value.',
          deepLime,
          frostGreen,
        ),
        dataRow('Same list object', '${basicDelegate.shouldRebuild(sameDelegate)}', deepLime),
        dataRow('Different list', '${basicDelegate.shouldRebuild(diffDelegate)}', warningOrange),
        noteBox(
          'Tip: To avoid unnecessary rebuilds, keep the same List<Widget> '
          'object between build calls. If you reconstruct the list each '
          'time, shouldRebuild will always return true.',
          forestChartreuse,
          dewDrop,
        ),
        const SizedBox(height: 14),

        // ── 7. Empty delegate ────────────────────────────────────────
        sectionBanner('6 \u00b7 Edge Case: Empty Delegate',
            'What happens with zero children',
            forestChartreuse, Colors.white),
        dataRow('estimatedChildCount', '${emptyDelegate.estimatedChildCount}', deepLime),
        dataRow('build(0)', '${emptyDelegate.build(context, 0)}', warningOrange),
        noteBox(
          'An empty ListWheelChildListDelegate is valid but the wheel '
          'will show nothing. The viewport still renders its cylindrical '
          'shape but with no items. This can happen during loading states.',
          forestChartreuse,
          frostGreen,
        ),
        const SizedBox(height: 14),

        // ── 8. Single child ──────────────────────────────────────────
        sectionBanner('7 \u00b7 Edge Case: Single Child',
            'A wheel with just one item', vibrantGreen, Colors.white),
        dataRow('estimatedChildCount', '${singleDelegate.estimatedChildCount}', deepLime),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: frostGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListWheelScrollView(
            itemExtent: 42,
            diameterRatio: 2.0,
            physics: const FixedExtentScrollPhysics(),
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                  color: paleClover,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('The Lonely Item',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: deepLime)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Fruit picker with styling ─────────────────────────────
        sectionBanner('8 \u00b7 Styled Fruit Picker',
            'Each item with emoji and color coding',
            deepLime, Colors.white),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: frostGreen,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepLime.withValues(alpha: 0.2)),
          ),
          child: Stack(
            children: [
              ListWheelScrollView(
                itemExtent: 48,
                diameterRatio: 1.5,
                perspective: 0.003,
                physics: const FixedExtentScrollPhysics(),
                children: [
                  for (final fruit in fruitItems)
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: fruit.$3.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: fruit.$3.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(fruit.$1,
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 10),
                          Text(fruit.$2,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: deepLime)),
                        ],
                      ),
                    ),
                ],
              ),
              Center(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: vibrantGreen, width: 2),
                      bottom: BorderSide(color: vibrantGreen, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Color swatch wheel ───────────────────────────────────
        sectionBanner('9 \u00b7 Color Swatch Selector',
            'Pre-built color items in a wheel',
            springLeaf, deepLime),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (final s in swatches) colorChip(s.$1, s.$2),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: mintGreen.withValues(alpha: 0.4)),
          ),
          child: ListWheelScrollView(
            itemExtent: 44,
            diameterRatio: 1.6,
            physics: const FixedExtentScrollPhysics(),
            children: [
              for (final swatch in swatches)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        swatch.$2.withValues(alpha: 0.2),
                        swatch.$2.withValues(alpha: 0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: swatch.$2.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: swatch.$2,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(swatch.$1,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: deepLime)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Comparison with builder ──────────────────────────────
        sectionBanner('10 \u00b7 List vs Builder — Same Data',
            'Comparing approaches for the same 5 items',
            deepLime, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostGreen,
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
                decoration: BoxDecoration(color: deepLime),
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
                    child: Text('BuilderDelegate',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ],
              ),
              for (final row in [
                ('Setup', 'Pass widget list', 'Pass builder function'),
                ('Memory', 'All 5 in memory', 'Only visible ~3'),
                ('Rebuild', 'If list ref changes', 'Always'),
                ('Access', '.children property', 'No direct access'),
                ('Best for', '5 items', 'Would use for 50+'),
              ])
                TableRow(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(row.$1,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: deepLime))),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(row.$2,
                            style: TextStyle(fontSize: 11, color: deepLime))),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(row.$3,
                            style: TextStyle(fontSize: 11, color: deepLime))),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Children property access ─────────────────────────────
        sectionBanner('11 \u00b7 The children Property',
            'Direct access to the pre-built widget list',
            forestChartreuse, Colors.white),
        noteBox(
          'Unlike BuilderDelegate, ListWheelChildListDelegate exposes a '
          'children property giving direct access to the full widget list. '
          'This can be useful for introspection, testing, or passing the '
          'same list to another delegate.',
          forestChartreuse,
          frostGreen,
        ),
        dataRow('Type', 'List<Widget>', deepLime),
        dataRow('Length', '${basicDelegate.children.length}', forestChartreuse),
        dataRow('Mutable?', 'The list can be mutated externally', warningOrange),
        noteBox(
          'Warning: Mutating the children list after creating the delegate '
          'may cause unexpected behavior. Always create a new delegate if '
          'the children change.',
          warningOrange,
          const Color(0xFFFFF3E0),
        ),
        const SizedBox(height: 14),

        // ── 13. Implicit creation ────────────────────────────────────
        sectionBanner('12 \u00b7 Implicit Creation via ListWheelScrollView',
            'The convenience constructor creates this delegate for you',
            vibrantGreen, Colors.white),
        noteBox(
          'When you use ListWheelScrollView(children: [...]), Flutter '
          'internally wraps your children in a ListWheelChildListDelegate. '
          'You only need the explicit delegate when using '
          'ListWheelScrollView.useDelegate() and want polymorphic control.',
          vibrantGreen,
          frostGreen,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: dewDrop,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Equivalent code:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: deepLime)),
              const SizedBox(height: 8),
              Text('// Implicit (common)',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: forestChartreuse)),
              Text('ListWheelScrollView(children: [...])',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: deepLime)),
              const SizedBox(height: 6),
              Text('// Explicit (equivalent)',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: forestChartreuse)),
              Text('ListWheelScrollView.useDelegate(',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: deepLime)),
              Text('  childDelegate: ListWheelChildListDelegate(',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: deepLime)),
              Text('    children: [...]',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: deepLime)),
              Text('  ),',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: deepLime)),
              Text(')',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: deepLime)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Real-world: day-of-week selector ─────────────────────
        sectionBanner('13 \u00b7 Real-World: Day Selector',
            'Fixed 7-item list, perfect for ListDelegate',
            deepLime, Colors.white),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: frostGreen,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepLime.withValues(alpha: 0.2)),
          ),
          child: ListWheelScrollView(
            itemExtent: 44,
            diameterRatio: 1.5,
            perspective: 0.003,
            physics: const FixedExtentScrollPhysics(),
            children: [
              for (final day in [
                ('Mon', '\u{1F4BC}', 'Work'),
                ('Tue', '\u{1F4D6}', 'Study'),
                ('Wed', '\u{1F3CB}', 'Gym'),
                ('Thu', '\u{1F4BB}', 'Code'),
                ('Fri', '\u{1F389}', 'Social'),
                ('Sat', '\u{1F3A8}', 'Creative'),
                ('Sun', '\u{1F6CC}', 'Rest'),
              ])
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: dewDrop,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: deepLime,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(day.$1,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      Text(day.$2,
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Text(day.$3,
                          style: TextStyle(
                              fontSize: 14,
                              color: deepLime,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Inheritance hierarchy ────────────────────────────────
        sectionBanner('14 \u00b7 Inheritance Hierarchy',
            'Class relationships', springLeaf, deepLime),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                'Object',
                '  \u2514\u2500 ListWheelChildDelegate (abstract)',
                '       \u251c\u2500 ListWheelChildBuilderDelegate',
                '       \u251c\u2500 ListWheelChildListDelegate  \u2605',
                '       \u2514\u2500 ListWheelChildLoopingListDelegate',
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
                              ? deepLime
                              : forestChartreuse)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary dashboard ────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepLime, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepLime, forestChartreuse],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Simplest delegate: explicit list of pre-built widgets',
                'estimatedChildCount always equals children.length',
                'build() returns children[index] or null',
                'trueIndexOf is identity (no wrapping)',
                'shouldRebuild compares list references',
                'Created implicitly by ListWheelScrollView(children:)',
                'Best for small fixed datasets (< 20 items)',
                'Children property provides direct list access',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: accentYellow,
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
