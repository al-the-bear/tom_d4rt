// ignore_for_file: avoid_print
// D4rt deep demo: ListWheelChildDelegate — abstract base for list wheel child management
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Plum / Mulberry ───────────────────────────────────────
  const deepPlum = Color(0xFF4A235A);
  const richMulberry = Color(0xFF6C3483);
  const orchidPurple = Color(0xFF8E44AD);
  const wisteriaSoft = Color(0xFFAF7AC5);
  const lavenderBloom = Color(0xFFD2B4DE);
  const lilacMist = Color(0xFFE8DAEF);
  const paleFrost = Color(0xFFF4ECF7);
  const creamWhite = Color(0xFFFAF0FA);
  const honeyAmber = Color(0xFFE67E22);

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
      child: Text(text, style: TextStyle(fontSize: 13, color: deepPlum)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 185,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepPlum)),
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

  Widget apiCard(String methodName, String returnType, String description,
      Color cardBg, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(methodName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: accent,
                      fontFamily: 'monospace')),
              const SizedBox(width: 8),
              Text('→ $returnType',
                  style: TextStyle(fontSize: 11, color: accent.withValues(alpha: 0.7))),
            ],
          ),
          const SizedBox(height: 4),
          Text(description,
              style: TextStyle(fontSize: 12, color: deepPlum)),
        ],
      ),
    );
  }

  Widget delegateComparisonCell(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: bg,
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('ListWheelChildDelegate deep demo executing');
  print('=' * 60);

  // Section 1 — abstract contract
  print('\n--- What is ListWheelChildDelegate ---');
  print('Abstract base class for supplying children to ListWheelViewport');
  print('Cannot be instantiated directly');
  print('Defines the contract: build, estimatedChildCount, trueIndexOf, shouldRebuild');

  // Section 2 — three concrete implementations
  print('\n--- Three concrete implementations ---');
  final listDel = ListWheelChildListDelegate(
    children: [Text('A'), Text('B'), Text('C'), Text('D'), Text('E')],
  );
  final builderDel = ListWheelChildBuilderDelegate(
    builder: (ctx, i) => i >= 0 && i < 8 ? Text('Built $i') : null,
    childCount: 8,
  );
  final loopingDel = ListWheelChildLoopingListDelegate(
    children: [Text('X'), Text('Y'), Text('Z')],
  );
  print('ListDelegate: ${listDel.runtimeType}');
  print('BuilderDelegate: ${builderDel.runtimeType}');
  print('LoopingDelegate: ${loopingDel.runtimeType}');

  // Section 3 — estimatedChildCount across implementations
  print('\n--- estimatedChildCount ---');
  print('List: ${listDel.estimatedChildCount}');
  print('Builder: ${builderDel.estimatedChildCount}');
  print('Looping: ${loopingDel.estimatedChildCount}');

  // Section 4 — trueIndexOf comparison
  print('\n--- trueIndexOf comparison ---');
  print('List trueIndexOf(2): ${listDel.trueIndexOf(2)}');
  print('Builder trueIndexOf(2): ${builderDel.trueIndexOf(2)}');
  print('Looping trueIndexOf(5): ${loopingDel.trueIndexOf(5)}');
  print('Looping maps 5 → ${loopingDel.trueIndexOf(5)} (wraps around 3 items)');

  // Section 5 — build method
  print('\n--- build method ---');
  print('List build(0): ${listDel.build(context, 0)}');
  print('Builder build(0): ${builderDel.build(context, 0)}');
  print('Builder build(10): ${builderDel.build(context, 10)}');
  print('Looping build(0): ${loopingDel.build(context, 0)}');
  print('Looping build(5): ${loopingDel.build(context, 5)}');

  // Section 6 — shouldRebuild
  print('\n--- shouldRebuild ---');
  final listDel2 = ListWheelChildListDelegate(
    children: [Text('A'), Text('B'), Text('C'), Text('D'), Text('E')],
  );
  print('List shouldRebuild(same data): ${listDel.shouldRebuild(listDel2)}');
  print('Builder shouldRebuild: ${builderDel.shouldRebuild(builderDel)}');

  // Section 7 — polymorphism
  print('\n--- Polymorphic usage ---');
  final List<ListWheelChildDelegate> delegates = [listDel, builderDel, loopingDel];
  for (final d in delegates) {
    print('  ${d.runtimeType}: estimated=${d.estimatedChildCount}');
  }

  // Section 8 — inheritance
  print('\n--- Inheritance chain ---');
  print('Object');
  print('  └─ ListWheelChildDelegate (abstract)');
  print('       ├─ ListWheelChildBuilderDelegate');
  print('       ├─ ListWheelChildListDelegate');
  print('       └─ ListWheelChildLoopingListDelegate');

  // Section 9 — use with ListWheelScrollView
  print('\n--- Integration with ListWheelScrollView ---');
  print('ListWheelScrollView(children: [...]) uses ListWheelChildListDelegate');
  print('ListWheelScrollView.useDelegate(childDelegate: ...) takes any delegate');

  // Section 10 — looping details
  print('\n--- Looping delegate details ---');
  for (int i = -3; i <= 6; i++) {
    print('  looping.trueIndexOf($i): ${loopingDel.trueIndexOf(i)}');
  }

  // Section 11 — bounded vs unbounded
  print('\n--- Bounded vs unbounded ---');
  final unbounded = ListWheelChildBuilderDelegate(
    builder: (ctx, i) => Text('$i'),
  );
  print('Unbounded estimatedChildCount: ${unbounded.estimatedChildCount}');

  // Section 12 — delegate lifecycle
  print('\n--- Delegate lifecycle ---');
  print('1. Delegate provided to ListWheelScrollView');
  print('2. ListWheelElement calls build(context, index)');
  print('3. shouldRebuild checked when delegate changes');
  print('4. estimatedChildCount used for scroll range calculation');

  // Section 13 — when to use which
  print('\n--- When to use which delegate ---');
  print('List: small fixed sets (< 20 items)');
  print('Builder: large/dynamic sets or lazy loading');
  print('Looping: circular choices (clock, spinner)');

  // Section 14 — summary
  print('\n${'=' * 60}');
  print('ListWheelChildDelegate deep demo completed');

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
              colors: [deepPlum, richMulberry, orchidPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ListWheelChildDelegate',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Abstract base for supplying children to cylindrical wheel viewports',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9), fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Abstract', orchidPurple, Colors.white),
                tag('ListWheelScrollView', wisteriaSoft, deepPlum),
                tag('Child Management', lavenderBloom, deepPlum),
                tag('3 Implementations', lilacMist, deepPlum),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 · What Is ListWheelChildDelegate',
            'Abstract contract for wheel child management',
            deepPlum, Colors.white),
        noteBox(
          'ListWheelChildDelegate is the abstract base class that defines '
          'how children are supplied to ListWheelViewport (the render object '
          'behind ListWheelScrollView). It cannot be instantiated directly. '
          'Flutter provides three concrete implementations: '
          'ListWheelChildListDelegate (eager), '
          'ListWheelChildBuilderDelegate (lazy), and '
          'ListWheelChildLoopingListDelegate (infinite).',
          deepPlum,
          paleFrost,
        ),
        dataRow('Type', 'abstract class', richMulberry),
        dataRow('Package', 'package:flutter/widgets.dart', orchidPurple),
        dataRow('Used by', 'ListWheelViewport, ListWheelScrollView', wisteriaSoft),
        const SizedBox(height: 14),

        // ── 3. API contract ──────────────────────────────────────────
        sectionBanner('2 · API Contract — Four Core Methods',
            'Every implementation must satisfy these',
            richMulberry, Colors.white),
        apiCard(
          'build(context, index)',
          'Widget?',
          'Returns the child widget at the given index, or null if no '
          'child exists at that index. Called by ListWheelElement as '
          'items scroll into the visible region.',
          paleFrost,
          deepPlum,
        ),
        apiCard(
          'estimatedChildCount',
          'int?',
          'Returns the estimated total number of children, or null for '
          'infinite/unknown. Used by the viewport to calculate scroll extent.',
          creamWhite,
          richMulberry,
        ),
        apiCard(
          'trueIndexOf(index)',
          'int',
          'Maps a wheel index to the true child index. Identity for '
          'non-looping delegates. For looping delegates, wraps around '
          'the source list length.',
          paleFrost,
          orchidPurple,
        ),
        apiCard(
          'shouldRebuild(oldDelegate)',
          'bool',
          'Returns true if the children should be rebuilt when the '
          'delegate changes. List delegates compare references; '
          'builder delegates always return true.',
          creamWhite,
          wisteriaSoft,
        ),
        const SizedBox(height: 14),

        // ── 4. Three implementations ─────────────────────────────────
        sectionBanner('3 · Three Concrete Implementations',
            'Each serves a different use case',
            orchidPurple, Colors.white),
        // List delegate
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: orchidPurple.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.list, size: 18, color: deepPlum),
                const SizedBox(width: 8),
                Text('ListWheelChildListDelegate',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: deepPlum)),
              ]),
              const SizedBox(height: 6),
              Text('Holds all children in a pre-built list. Best for small '
                  'fixed datasets where all items are known upfront.',
                  style: TextStyle(fontSize: 12, color: deepPlum)),
              const SizedBox(height: 6),
              dataRow('estimatedChildCount', '${listDel.estimatedChildCount}', richMulberry),
              dataRow('Pattern', 'Eager, finite', orchidPurple),
            ],
          ),
        ),
        // Builder delegate
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: richMulberry.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.build, size: 18, color: richMulberry),
                const SizedBox(width: 8),
                Text('ListWheelChildBuilderDelegate',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: richMulberry)),
              ]),
              const SizedBox(height: 6),
              Text('Lazily builds children via callback. Best for large or '
                  'dynamic datasets. Can also be unbounded (infinite).',
                  style: TextStyle(fontSize: 12, color: deepPlum)),
              const SizedBox(height: 6),
              dataRow('estimatedChildCount', '${builderDel.estimatedChildCount}', richMulberry),
              dataRow('Pattern', 'Lazy, bounded or unbounded', orchidPurple),
            ],
          ),
        ),
        // Looping delegate
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: wisteriaSoft.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.loop, size: 18, color: wisteriaSoft),
                const SizedBox(width: 8),
                Text('ListWheelChildLoopingListDelegate',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: wisteriaSoft)),
              ]),
              const SizedBox(height: 6),
              Text('Wraps a finite list into an infinite loop. The wheel '
                  'repeats items cyclically. Great for circular selectors.',
                  style: TextStyle(fontSize: 12, color: deepPlum)),
              const SizedBox(height: 6),
              dataRow('estimatedChildCount', '${loopingDel.estimatedChildCount}', richMulberry),
              dataRow('Pattern', 'Infinite, cyclic', orchidPurple),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. estimatedChildCount comparison ────────────────────────
        sectionBanner('4 · estimatedChildCount Across Implementations',
            'How each delegate reports its size',
            wisteriaSoft, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepPlum),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Delegate',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Count',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Meaning',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  delegateComparisonCell('ListDelegate', creamWhite, deepPlum),
                  delegateComparisonCell('${listDel.estimatedChildCount}', creamWhite, deepPlum),
                  delegateComparisonCell('Exact count', creamWhite, deepPlum),
                ],
              ),
              TableRow(
                children: [
                  delegateComparisonCell('BuilderDelegate', paleFrost, deepPlum),
                  delegateComparisonCell('${builderDel.estimatedChildCount}', paleFrost, deepPlum),
                  delegateComparisonCell('Via childCount', paleFrost, deepPlum),
                ],
              ),
              TableRow(
                children: [
                  delegateComparisonCell('LoopingDelegate', creamWhite, deepPlum),
                  delegateComparisonCell('${loopingDel.estimatedChildCount}', creamWhite, deepPlum),
                  delegateComparisonCell('null = infinite', creamWhite, deepPlum),
                ],
              ),
              TableRow(
                children: [
                  delegateComparisonCell('Builder (no count)', paleFrost, deepPlum),
                  delegateComparisonCell('${unbounded.estimatedChildCount}', paleFrost, deepPlum),
                  delegateComparisonCell('null = unbounded', paleFrost, deepPlum),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. trueIndexOf deep dive ─────────────────────────────────
        sectionBanner('5 · trueIndexOf — Index Mapping',
            'How each delegate maps wheel indices to child indices',
            deepPlum, Colors.white),
        noteBox(
          'trueIndexOf(index) converts the raw wheel index into the true '
          'child position. For List and Builder delegates, it is the identity '
          'function (returns the input). For Looping delegates, it applies '
          'modulo arithmetic to wrap indices into the source list range.',
          deepPlum,
          paleFrost,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text('Wheel idx',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: deepPlum)),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text('List',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: richMulberry)),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text('Builder',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: orchidPurple)),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text('Looping',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: wisteriaSoft)),
                  ),
                ],
              ),
              const Divider(),
              for (final idx in [-3, -1, 0, 1, 2, 3, 4, 5, 6])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text('$idx',
                            style: TextStyle(fontSize: 12, color: deepPlum)),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('${listDel.trueIndexOf(idx)}',
                            style: TextStyle(fontSize: 12, color: richMulberry)),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('${builderDel.trueIndexOf(idx)}',
                            style: TextStyle(fontSize: 12, color: orchidPurple)),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('${loopingDel.trueIndexOf(idx)}',
                            style: TextStyle(
                                fontSize: 12,
                                color: wisteriaSoft,
                                fontWeight: loopingDel.trueIndexOf(idx) != idx
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. shouldRebuild comparison ──────────────────────────────
        sectionBanner('6 · shouldRebuild Behavior',
            'When the framework re-requests children', richMulberry, Colors.white),
        noteBox(
          'shouldRebuild is called when the delegate is replaced (e.g., '
          'during a rebuild). If it returns true, all children are rebuilt. '
          'ListDelegate returns true when the children list is a different '
          'object. BuilderDelegate always returns true (closures are not '
          'comparable). LoopingDelegate also compares the children list.',
          richMulberry,
          lilacMist,
        ),
        dataRow('ListDelegate', '${listDel.shouldRebuild(listDel2)}', deepPlum),
        dataRow('BuilderDelegate', '${builderDel.shouldRebuild(builderDel)}', richMulberry),
        const SizedBox(height: 14),

        // ── 8. Polymorphic usage ─────────────────────────────────────
        sectionBanner('7 · Polymorphic Usage',
            'Using delegates through the base type', orchidPurple, Colors.white),
        noteBox(
          'Code can accept ListWheelChildDelegate as a parameter type and '
          'work with any concrete implementation. This is useful for '
          'factory methods, dependency injection, or building reusable '
          'wheel picker components.',
          orchidPurple,
          paleFrost,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All delegates used polymorphically:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: deepPlum)),
              const SizedBox(height: 8),
              for (final d in delegates)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Icon(
                        d is ListWheelChildLoopingListDelegate
                            ? Icons.loop
                            : d is ListWheelChildBuilderDelegate
                                ? Icons.build
                                : Icons.list,
                        size: 16,
                        color: orchidPurple,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                            '${d.runtimeType}: estimated=${d.estimatedChildCount}',
                            style: TextStyle(fontSize: 12, color: deepPlum)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Live wheels — side by side ────────────────────────────
        sectionBanner('8 · Live Wheel Comparison',
            'Same data, different delegate types',
            deepPlum, Colors.white),
        // List delegate wheel
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ListDelegate (5 items)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: deepPlum)),
              const SizedBox(height: 6),
              SizedBox(
                height: 140,
                child: ListWheelScrollView(
                  itemExtent: 36,
                  diameterRatio: 1.8,
                  physics: const FixedExtentScrollPhysics(),
                  children: [
                    for (final item in ['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon'])
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: lilacMist,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(item,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: deepPlum)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Builder delegate wheel
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BuilderDelegate (8 items, lazy)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: richMulberry)),
              const SizedBox(height: 6),
              SizedBox(
                height: 140,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 36,
                  diameterRatio: 1.8,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (ctx, i) {
                      if (i < 0 || i >= 8) return null;
                      final names = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Rest'];
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: i < 5
                              ? lavenderBloom.withValues(alpha: 0.5)
                              : wisteriaSoft.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(names[i],
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: deepPlum)),
                      );
                    },
                    childCount: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Looping delegate wheel
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('LoopingDelegate (3 items, infinite)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: wisteriaSoft)),
              const SizedBox(height: 6),
              SizedBox(
                height: 140,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 36,
                  diameterRatio: 1.8,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: [
                      for (final item in ['Rock', 'Paper', 'Scissors'])
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: orchidPurple.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(item,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: deepPlum)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Inheritance hierarchy ────────────────────────────────
        sectionBanner('9 · Inheritance Hierarchy',
            'Class relationships', orchidPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                'Object',
                '  └─ ListWheelChildDelegate  ★ (abstract)',
                '       ├─ ListWheelChildBuilderDelegate',
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
                          color: line.contains('★') ? deepPlum : richMulberry)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Integration flow ─────────────────────────────────────
        sectionBanner('10 · Integration Flow',
            'How the delegate connects to the scroll view pipeline',
            deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final step in [
                '1. You create a ListWheelScrollView',
                '2. Framework creates ListWheelViewport (render widget)',
                '3. Viewport creates ListWheelElement (element)',
                '4. Element implements ListWheelChildManager',
                '5. Element calls delegate.build(ctx, index)',
                '6. Built widgets become children of the viewport',
                '7. On scroll, element requests new indices',
                '8. Old off-screen children are recycled',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_forward, size: 14, color: orchidPurple),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(step,
                            style: TextStyle(fontSize: 12, color: deepPlum)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Decision guide ───────────────────────────────────────
        sectionBanner('11 · Which Delegate Should I Use?',
            'Decision guide for choosing the right implementation',
            richMulberry, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final entry in [
                ('< 20 fixed items', 'ListWheelChildListDelegate', Icons.list),
                ('Many items / lazy', 'ListWheelChildBuilderDelegate', Icons.build),
                ('Infinite / circular', 'ListWheelChildLoopingListDelegate', Icons.loop),
                ('Dynamic server data', 'ListWheelChildBuilderDelegate', Icons.cloud),
                ('Clock hours (1-12)', 'ListWheelChildLoopingListDelegate', Icons.access_time),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(entry.$3, size: 18, color: orchidPurple),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 140,
                        child: Text(entry.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepPlum)),
                      ),
                      Expanded(
                        child: Text(entry.$2,
                            style: TextStyle(
                                fontSize: 11,
                                color: richMulberry,
                                fontFamily: 'monospace')),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Delegate lifecycle ───────────────────────────────────
        sectionBanner('12 · Delegate Lifecycle',
            'When delegate methods are called',
            wisteriaSoft, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: lilacMist,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final phase in [
                ('Mount', 'build() called for initial visible indices'),
                ('Scroll', 'build() called for new visible indices, old recycled'),
                ('Update', 'shouldRebuild() checked; if true, children rebuilt'),
                ('Unmount', 'All children disposed'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: deepPlum,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(phase.$1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(phase.$2,
                            style: TextStyle(fontSize: 12, color: deepPlum)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Bounded vs unbounded ─────────────────────────────────
        sectionBanner('13 · Bounded vs Unbounded',
            'Finite lists vs infinite scroll',
            orchidPurple, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: deepPlum,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('BOUNDED',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                        const SizedBox(height: 6),
                        Text('estimatedChildCount != null',
                            style: TextStyle(fontSize: 11, color: deepPlum)),
                        Text('Scroll has start/end',
                            style: TextStyle(fontSize: 11, color: richMulberry)),
                        Text('build returns null at edges',
                            style: TextStyle(fontSize: 11, color: orchidPurple)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: honeyAmber,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('UNBOUNDED',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                        const SizedBox(height: 6),
                        Text('estimatedChildCount == null',
                            style: TextStyle(fontSize: 11, color: deepPlum)),
                        Text('Scroll in both directions',
                            style: TextStyle(fontSize: 11, color: richMulberry)),
                        Text('build never returns null',
                            style: TextStyle(fontSize: 11, color: orchidPurple)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Real-world selector ──────────────────────────────────
        sectionBanner('14 · Real-World: Planet Selector',
            'Using ListDelegate for a small fixed set',
            deepPlum, Colors.white),
        Container(
          height: 170,
          decoration: BoxDecoration(
            color: paleFrost,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: orchidPurple.withValues(alpha: 0.3)),
          ),
          child: ListWheelScrollView(
            itemExtent: 44,
            diameterRatio: 1.6,
            physics: const FixedExtentScrollPhysics(),
            children: [
              for (final planet in [
                ('\u{1F30D}', 'Earth'),
                ('\u{2642}', 'Mars'),
                ('\u{1F315}', 'Jupiter'),
                ('\u{1FA90}', 'Saturn'),
                ('\u{2609}', 'Venus'),
                ('\u{1F310}', 'Neptune'),
                ('\u{1F31F}', 'Uranus'),
                ('\u{263F}', 'Mercury'),
              ])
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [lilacMist, lavenderBloom.withValues(alpha: 0.4)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('${planet.$1}  ${planet.$2}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: deepPlum)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary dashboard ────────────────────────────────────
        sectionBanner('15 · Summary',
            'Key takeaways', deepPlum, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepPlum, richMulberry],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Abstract base: cannot instantiate directly',
                'Defines build(), estimatedChildCount, trueIndexOf(), shouldRebuild()',
                'Three implementations: List, Builder, Looping',
                'List: eager, small fixed sets',
                'Builder: lazy, large/dynamic/infinite sets',
                'Looping: cyclic infinite repetition',
                'trueIndexOf: identity for List/Builder, modulo for Looping',
                'shouldRebuild: list-compare vs always-true',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: honeyAmber,
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
