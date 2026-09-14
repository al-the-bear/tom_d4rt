// Deep visual demo for Flutter foundation's CachingIterable<T>.
// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";

// =============================================================================
// CachingIterable<T> Deep Demo
// =============================================================================
//
// CachingIterable<T> lives in package:flutter/foundation and is a small but
// surprisingly important utility used inside the Flutter framework whenever an
// iterable must be traversed multiple times but its underlying iterator can
// only be walked once. The most famous consumer is the sliver protocol, where
// children are produced lazily and the framework wants to be able to ask
// "how many children are there?", "give me child #5", and "iterate all
// children" without re-running the (possibly expensive) generator on every
// call.
//
// The class is conceptually simple:
//
//   1. It wraps an Iterator<T>.
//   2. The first time you ask for an element at index N, it walks the
//      underlying iterator forward, caching every value it sees into an
//      internal List<T>.
//   3. Subsequent accesses for any index <= the high-water mark return the
//      cached value with O(1) cost.
//   4. Once the underlying iterator is exhausted, the cache is "frozen" and
//      no further forward walking is necessary.
//
// In other words: it converts a one-shot iterator into a re-entrant, lazily
// materialized iterable. This is what you reach for when you want the
// memoization behavior of a List<T> but you do not want to pay the up-front
// cost of materializing every element.
//
// This file is a deep visual reference. It renders eight unique sections that
// together explain the anatomy, lifecycle, performance heuristics, pitfalls,
// and API surface of CachingIterable. It is intentionally static — no state
// transitions, no async work, no animations — so it can be safely serialized,
// snapshotted, and re-rendered by the tom_d4rt_flutter_ast test harness.
//
// The file does construct a real CachingIterable<int> in one helper so that
// the .toList() result can be displayed inside a Text widget; this exercises
// the import of package:flutter/foundation and verifies that the class is in
// scope.
// =============================================================================

// -----------------------------------------------------------------------------
// Helper: produce a real CachingIterable<int> and render its eager .toList().
// -----------------------------------------------------------------------------
List<int> _buildCachedData() {
  final Iterator<int> source = <int>[1, 2, 3, 4, 5, 8, 13, 21, 34, 55].iterator;
  final CachingIterable<int> cache = CachingIterable<int>(source);
  // First pass — walks the underlying iterator, fills the cache.
  final List<int> first = cache.toList();
  // Second pass — pure cache hit; the iterator is not touched.
  final List<int> second = cache.toList();
  // Both lists are identical in content; we just return the materialized one.
  return <int>[...first, ...second];
}

String _buildCachedDataLabel() {
  final List<int> data = _buildCachedData();
  return "cached.toList() x2 -> ${data.join(", ")}";
}

// -----------------------------------------------------------------------------
// Top-level build entry point.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "CachingIterable Deep Demo",
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF3F1FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _HeroHeaderSection(),
            const SizedBox(height: 32),
            const _LazyVsEagerSection(),
            const SizedBox(height: 32),
            const _CacheLifecycleSection(),
            const SizedBox(height: 32),
            const _PassComparisonSection(),
            const SizedBox(height: 32),
            const _UseCasesSection(),
            const SizedBox(height: 32),
            const _PitfallsSection(),
            const SizedBox(height: 32),
            const _ApiSurfaceSection(),
            const SizedBox(height: 32),
            const _PerformanceHeuristicsSection(),
            const SizedBox(height: 32),
            _LiveSampleSection(label: _buildCachedDataLabel()),
            const SizedBox(height: 32),
            const _FooterSection(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Hero Header
// =============================================================================
// Sets the stage. A bold gradient banner introduces the class, the package it
// lives in, and the single sentence summary "lazy iteration cache". The
// header doubles as a navigation anchor: every subsequent section is colour
// coded to a sibling tile that appears in the header strip.
// =============================================================================
class _HeroHeaderSection extends StatelessWidget {
  const _HeroHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF4527A0),
            const Color(0xFF7E57C2),
            const Color(0xFFAB47BC).withValues(alpha: 0.92),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF311B92).withValues(alpha: 0.32),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: const Text(
                  "package:flutter/foundation.dart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: const Text(
                  "stable since Flutter 1.0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "CachingIterable<T>",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Lazy iteration cache anatomy",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "An Iterable<T> facade that wraps a one-shot Iterator<T>, walks it "
            "on demand, and memoizes every element it has seen so that any "
            "number of subsequent traversals are pure cache lookups.",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 15,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _heroChip(Colors.deepPurple.shade100, "lazy"),
              _heroChip(Colors.purple.shade100, "memoized"),
              _heroChip(Colors.indigo.shade100, "iterator-once"),
              _heroChip(Colors.pink.shade100, "sliver-friendly"),
              _heroChip(Colors.blue.shade100, "no-async"),
              _heroChip(Colors.teal.shade100, "framework-internal"),
              _heroChip(Colors.amber.shade100, "O(n) one-shot fill"),
              _heroChip(Colors.green.shade100, "O(1) cached read"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroChip(Color background, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF311B92),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Lazy vs Eager
// =============================================================================
// Side-by-side comparison of three modes for working with a one-shot iterator.
// Each mode is rendered as a column with a header, a code preview, and a
// behaviour blurb. The middle column (CachingIterable) is highlighted to
// show that it is the recommended pattern when both laziness and repeated
// traversal are required.
// =============================================================================
class _LazyVsEagerSection extends StatelessWidget {
  const _LazyVsEagerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.white,
            const Color(0xFFEDE7F6).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD1C4E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "02",
            title: "Lazy vs Eager",
            subtitle: "Three ways to traverse a one-shot iterator twice.",
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _modeColumn(
                  color: const Color(0xFFFFE0B2),
                  border: const Color(0xFFFFB74D),
                  title: "Eager List",
                  code: "final list = iterator.toList();",
                  behaviour: <String>[
                    "Walks the iterator immediately.",
                    "All elements live in memory up front.",
                    "Re-traversal is free, but the first call may be slow.",
                    "Best when you know you will traverse many times.",
                  ],
                  highlight: false,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _modeColumn(
                  color: const Color(0xFFD1C4E9),
                  border: const Color(0xFF7E57C2),
                  title: "CachingIterable",
                  code: "final cached = CachingIterable<T>(it);",
                  behaviour: <String>[
                    "Walks the iterator on demand.",
                    "Caches each element the first time it is seen.",
                    "Re-traversal is free; partial walks pay only for new ground.",
                    "Best when you might re-traverse and might not.",
                  ],
                  highlight: true,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _modeColumn(
                  color: const Color(0xFFB2DFDB),
                  border: const Color(0xFF26A69A),
                  title: "Raw Iterator",
                  code: "while (iterator.moveNext()) {...}",
                  behaviour: <String>[
                    "Single-use; cannot be reset.",
                    "Zero memory overhead beyond the cursor.",
                    "Second traversal throws StateError.",
                    "Best when you genuinely only need one pass.",
                  ],
                  highlight: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFB39DDB)),
            ),
            child: const Text(
              "CachingIterable sits between the eager List and the raw Iterator: "
              "it gives you the re-entrancy of the former without giving up the "
              "laziness of the latter. The price is a single internal List<T> "
              "buffer plus one boolean to remember whether the underlying "
              "iterator is exhausted.",
              style: TextStyle(
                color: Color(0xFF311B92),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeColumn({
    required Color color,
    required Color border,
    required String title,
    required String code,
    required List<String> behaviour,
    required bool highlight,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: border,
          width: highlight ? 2.4 : 1.0,
        ),
        boxShadow: highlight
            ? <BoxShadow>[
                BoxShadow(
                  color: border.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF311B92),
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: highlight ? 0.4 : 0.0,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1033),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFFE1BEE7),
                fontFamily: "monospace",
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...behaviour.map(_bullet),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "-  ",
            style: TextStyle(
              color: Color(0xFF311B92),
              fontWeight: FontWeight.w800,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF311B92),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Cache Lifecycle
// =============================================================================
// Visualizes the three states a CachingIterable can be in:
//   - PRISTINE: no element has been requested yet.
//   - WARMING: some prefix of the underlying iterator has been cached.
//   - SEALED:  the underlying iterator has been fully exhausted.
// Each state is rendered as a circular badge connected by horizontal arrows.
// =============================================================================
class _CacheLifecycleSection extends StatelessWidget {
  const _CacheLifecycleSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFE0F7FA),
            const Color(0xFFB2EBF2).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF80DEEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "03",
            title: "Cache Lifecycle",
            subtitle: "PRISTINE -> WARMING -> SEALED",
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _stateBadge(
                color: const Color(0xFF26C6DA),
                title: "PRISTINE",
                blurb: "Cache empty. Underlying iterator untouched.",
              ),
              const _LifecycleArrow(),
              _stateBadge(
                color: const Color(0xFF7E57C2),
                title: "WARMING",
                blurb: "Cache holds prefix [0..k). Iterator at position k.",
              ),
              const _LifecycleArrow(),
              _stateBadge(
                color: const Color(0xFFEC407A),
                title: "SEALED",
                blurb: "Iterator exhausted. Cache is the full sequence.",
              ),
            ],
          ),
          const SizedBox(height: 24),
          _detailBlock(
            title: "Transition: PRISTINE -> WARMING",
            detail: "Triggered by any first access - elementAt, first, length, "
                "iterator, toList, fold, where, etc. The first element pulled "
                "from the underlying iterator is appended to the internal "
                "buffer.",
            color: const Color(0xFF26C6DA),
          ),
          const SizedBox(height: 12),
          _detailBlock(
            title: "Transition: WARMING -> SEALED",
            detail: "Triggered when the underlying iterator returns false from "
                "moveNext. The internal hasMoreElements flag is set to false "
                "and from then on the cache is treated as the canonical list.",
            color: const Color(0xFF7E57C2),
          ),
          const SizedBox(height: 12),
          _detailBlock(
            title: "Note: there is no PRUNE state",
            detail: "CachingIterable never shrinks its internal buffer. Once "
                "an element has been cached it is retained for the lifetime of "
                "the CachingIterable. If you need bounded memory, wrap a "
                "windowed iterator instead.",
            color: const Color(0xFFEC407A),
          ),
        ],
      ),
    );
  }

  Widget _stateBadge({
    required Color color,
    required String title,
    required String blurb,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.28),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Center(
                child: Text(
                  title.substring(0, 1),
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              blurb,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF263238),
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailBlock({
    required String title,
    required String detail,
    required Color color,
  }) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #12, P5(a)):
    // Original used `Border(left: width: 4 + others: alpha: 0.18) +
    // borderRadius`, which the bridge rejects ("A borderRadius can only be
    // given on borders with uniform colors."). Re-express the left-accent
    // stripe as a sibling Container in a Row; the content card now uses a
    // uniform Border.all so it remains compatible with borderRadius.
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 4,
              color: color,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: color.withValues(alpha: 0.18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail,
                      style: const TextStyle(
                        color: Color(0xFF37474F),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LifecycleArrow extends StatelessWidget {
  const _LifecycleArrow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Center(
        child: Text(
          "->",
          style: TextStyle(
            color: const Color(0xFF455A64),
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Pass Comparison Table
// =============================================================================
// A tabulated "first pass vs subsequent pass" comparison. The mock data
// demonstrates that the underlying iterator is only walked once: the second
// pass has zero "moveNext" calls but the same number of element reads.
// =============================================================================
class _PassComparisonSection extends StatelessWidget {
  const _PassComparisonSection();

  @override
  Widget build(BuildContext context) {
    final List<_PassRow> rows = <_PassRow>[
      _PassRow("elementAt(0)", "moveNext + cache write", "cache read", "1", "0"),
      _PassRow("elementAt(1)", "moveNext + cache write", "cache read", "1", "0"),
      _PassRow("elementAt(2)", "moveNext + cache write", "cache read", "1", "0"),
      _PassRow("elementAt(3)", "moveNext + cache write", "cache read", "1", "0"),
      _PassRow("elementAt(4)", "moveNext + cache write", "cache read", "1", "0"),
      _PassRow("length", "fully drain iterator", "cache.length", "n - 5", "0"),
      _PassRow("toList()", "drain + copy cache", "copy cache", "0", "0"),
      _PassRow("first", "cache read", "cache read", "0", "0"),
      _PassRow("last", "drain iterator", "cache read", "0", "0"),
      _PassRow("isEmpty", "moveNext once", "cache read", "0", "0"),
      _PassRow("contains(x)", "scan until found", "scan cache only", "0..n", "0"),
      _PassRow("where(f).toList()", "scan + filter + cache", "scan cache", "0", "0"),
      _PassRow("map(f).toList()", "scan + map + cache", "scan cache + map", "0", "0"),
      _PassRow("fold(seed, op)", "scan + fold + cache", "scan cache + fold", "0", "0"),
      _PassRow("any(f)", "scan until true", "scan cache until true", "0..n", "0"),
      _PassRow("every(f)", "scan until false", "scan cache until false", "0..n", "0"),
      _PassRow("take(k).toList()", "moveNext k times", "cache read k times", "k", "0"),
      _PassRow("skip(k).toList()", "moveNext k + drain", "cache read", "0", "0"),
      _PassRow("reduce(op)", "scan + reduce", "scan cache + reduce", "0", "0"),
      _PassRow("join(\",\")", "scan + concat", "scan cache + concat", "0", "0"),
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFFFF3E0),
            const Color(0xFFFFE0B2).withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFB74D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "04",
            title: "First Pass vs Subsequent Pass",
            subtitle: "Where does the time go on each call?",
          ),
          const SizedBox(height: 20),
          _header(),
          ...rows.map(_row),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFCC80)),
            ),
            child: const Text(
              "Reading: the moveNext column shows how many times the underlying "
              "Iterator<T>.moveNext is called on each pass. Notice that on the "
              "second pass it is always zero - the cache is authoritative once "
              "the iterator has been drained for that index.",
              style: TextStyle(
                color: Color(0xFFE65100),
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE65100),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              "Call",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "First pass behaviour",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "Subsequent pass behaviour",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "moveNext 1st",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "moveNext 2nd",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(_PassRow row) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFFFE0B2)),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row.call,
              style: const TextStyle(
                color: Color(0xFFBF360C),
                fontSize: 12,
                fontFamily: "monospace",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              row.first,
              style: const TextStyle(
                color: Color(0xFF37474F),
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              row.second,
              style: const TextStyle(
                color: Color(0xFF37474F),
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.first1,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF6D4C41),
                fontSize: 12,
                fontFamily: "monospace",
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.second2,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF6D4C41),
                fontSize: 12,
                fontFamily: "monospace",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PassRow {
  final String call;
  final String first;
  final String second;
  final String first1;
  final String second2;
  const _PassRow(this.call, this.first, this.second, this.first1, this.second2);
}

// =============================================================================
// SECTION 5 — Use Cases
// =============================================================================
// Five canonical use cases of CachingIterable, each rendered as a card with a
// title, a "where you see it" attribution, and a short paragraph.
// =============================================================================
class _UseCasesSection extends StatelessWidget {
  const _UseCasesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFE8F5E9),
            const Color(0xFFC8E6C9).withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF81C784)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "05",
            title: "Use Cases",
            subtitle: "Where the framework actually uses CachingIterable.",
          ),
          const SizedBox(height: 20),
          _useCaseCard(
            color: const Color(0xFF66BB6A),
            title: "Lazy Slivers",
            seenIn: "package:flutter/widgets/sliver.dart",
            blurb: "SliverChildBuilderDelegate computes its children lazily, "
                "but the sliver protocol asks for child count and a specific "
                "index repeatedly. Wrapping the builder output in a "
                "CachingIterable lets the framework hit the cache for warm "
                "indexes while still deferring work for cold ones.",
          ),
          const SizedBox(height: 10),
          _useCaseCard(
            color: const Color(0xFF42A5F5),
            title: "Animated Builders",
            seenIn: "third-party animated list libraries",
            blurb: "Animated lists frequently re-iterate their child set to "
                "compute insertion / removal diffs. CachingIterable lets the "
                "diff phase re-walk the iterable without re-running the "
                "expensive build closure.",
          ),
          const SizedBox(height: 10),
          _useCaseCard(
            color: const Color(0xFFAB47BC),
            title: "Computed Properties",
            seenIn: "diagnostics, debug labels, semantics",
            blurb: "Diagnostic strings often want to ask how many children "
                "there are and to show the first three. A CachingIterable "
                "answers both questions in O(1) after the first call without "
                "forcing a full traversal.",
          ),
          const SizedBox(height: 10),
          _useCaseCard(
            color: const Color(0xFFFFA726),
            title: "Streaming Tests",
            seenIn: "package:flutter_test",
            blurb: "Test harnesses sometimes need to inspect the same lazily "
                "generated event stream multiple times. Wrapping the stream "
                "snapshot iterator in a CachingIterable preserves the lazy "
                "property while making the inspection re-entrant.",
          ),
          const SizedBox(height: 10),
          _useCaseCard(
            color: const Color(0xFFEC407A),
            title: "Generator Memoization",
            seenIn: "user code, dart:core sync* generators",
            blurb: "Any sync* generator returns a one-shot Iterable whose "
                "iterator can only be walked once. Wrapping it in a "
                "CachingIterable turns the generator into a reusable, lazy, "
                "memoized sequence - a poor person's lazy List.",
          ),
        ],
      ),
    );
  }

  Widget _useCaseCard({
    required Color color,
    required String title,
    required String seenIn,
    required String blurb,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.6)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "(seen in: $seenIn)",
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            blurb,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Pitfalls
// =============================================================================
// Six pitfalls every CachingIterable user should know about. Includes the
// famous forEach vs map vs where subtlety: forEach walks the iterator
// eagerly, map and where remain lazy.
// =============================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFFFEBEE),
            const Color(0xFFFFCDD2).withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE57373)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "06",
            title: "Pitfalls",
            subtitle: "Sharp edges to avoid when caching iterators.",
          ),
          const SizedBox(height: 20),
          _pitfallCard(
            level: "high",
            title: "Underlying iterator must not be shared",
            blurb: "If you pass an iterator to CachingIterable and then walk "
                "it elsewhere, the cache will see a gap. The iterator is "
                "expected to be owned exclusively by the CachingIterable.",
          ),
          const SizedBox(height: 10),
          _pitfallCard(
            level: "high",
            title: "forEach vs map vs where",
            blurb: "forEach is eager: it walks the iterator immediately and "
                "fills the cache to the end. map and where return new lazy "
                "iterables that only walk the source as their results are "
                "consumed. If you call forEach, expect a full drain.",
          ),
          const SizedBox(height: 10),
          _pitfallCard(
            level: "medium",
            title: "length always drains the iterator",
            blurb: "Calling .length on a CachingIterable forces the iterator "
                "to be fully consumed (because length cannot be computed "
                "without knowing the end). Avoid it in hot paths if you only "
                "care about a prefix.",
          ),
          const SizedBox(height: 10),
          _pitfallCard(
            level: "medium",
            title: "No element eviction",
            blurb: "CachingIterable keeps every element it has ever seen. "
                "If your sequence is huge and you only need a small window, "
                "use a windowed wrapper instead.",
          ),
          const SizedBox(height: 10),
          _pitfallCard(
            level: "low",
            title: "Not thread-safe",
            blurb: "CachingIterable is not designed for concurrent access. "
                "In Dart this is rarely an issue because each isolate is "
                "single-threaded, but if you cross isolate boundaries you "
                "need to serialize access yourself.",
          ),
          const SizedBox(height: 10),
          _pitfallCard(
            level: "low",
            title: "No identity guarantee across passes",
            blurb: "The CachingIterable returns the same cached object on "
                "every read. If your iterator produces mutable values, "
                "callers may observe each other mutations.",
          ),
        ],
      ),
    );
  }

  Widget _pitfallCard({
    required String level,
    required String title,
    required String blurb,
  }) {
    final Color color;
    final String label;
    switch (level) {
      case "high":
        color = const Color(0xFFD32F2F);
        label = "HIGH";
        break;
      case "medium":
        color = const Color(0xFFF57C00);
        label = "MEDIUM";
        break;
      default:
        color = const Color(0xFF455A64);
        label = "LOW";
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  blurb,
                  style: const TextStyle(
                    color: Color(0xFF263238),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — API Surface
// =============================================================================
// A tabulated reference of every public member of CachingIterable. Rows are
// ordered: constructor, inherited iterator getter, then overridden methods
// (elementAt, length, contains, skip, take), then specialty overrides.
// =============================================================================
class _ApiSurfaceSection extends StatelessWidget {
  const _ApiSurfaceSection();

  @override
  Widget build(BuildContext context) {
    final List<_ApiRow> rows = <_ApiRow>[
      _ApiRow(
        kind: "ctor",
        signature: "CachingIterable<T>(Iterator<T> source)",
        notes: "Wraps the given source. The iterator is expected to be owned "
            "exclusively by the new CachingIterable.",
      ),
      _ApiRow(
        kind: "getter",
        signature: "Iterator<T> get iterator",
        notes: "Returns a new iterator that walks the cache and continues "
            "into the underlying iterator past the cache high-water mark.",
      ),
      _ApiRow(
        kind: "override",
        signature: "T elementAt(int index)",
        notes: "Walks the underlying iterator until index is reached, "
            "caching all intermediate elements. Subsequent calls for the "
            "same index are O(1).",
      ),
      _ApiRow(
        kind: "override",
        signature: "int get length",
        notes: "Drains the underlying iterator to completion. Cached for "
            "subsequent reads.",
      ),
      _ApiRow(
        kind: "override",
        signature: "bool contains(Object? element)",
        notes: "Linearly scans until element is found or the iterator is "
            "exhausted. May leave the iterator in a partially-drained state.",
      ),
      _ApiRow(
        kind: "override",
        signature: "Iterable<T> skip(int count)",
        notes: "Returns a lazy view that skips the first count elements. "
            "Does not force the iterator to advance past count.",
      ),
      _ApiRow(
        kind: "override",
        signature: "Iterable<T> take(int count)",
        notes: "Returns a lazy view that yields at most count elements. "
            "Only advances the underlying iterator as needed.",
      ),
      _ApiRow(
        kind: "inherited",
        signature: "Iterable<R> map<R>(R Function(T) f)",
        notes: "Lazy. Walks the source as the result is consumed.",
      ),
      _ApiRow(
        kind: "inherited",
        signature: "Iterable<T> where(bool Function(T) test)",
        notes: "Lazy. Walks the source as the result is consumed.",
      ),
      _ApiRow(
        kind: "inherited",
        signature: "void forEach(void Function(T) action)",
        notes: "Eager. Drains the source to the end.",
      ),
      _ApiRow(
        kind: "inherited",
        signature: "List<T> toList({bool growable = true})",
        notes: "Eager. Drains the source and copies the cache.",
      ),
      _ApiRow(
        kind: "inherited",
        signature: "Set<T> toSet()",
        notes: "Eager. Drains and de-duplicates.",
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFE1F5FE),
            const Color(0xFFB3E5FC).withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF4FC3F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "07",
            title: "API Surface",
            subtitle: "Constructors, overrides, and inherited members.",
          ),
          const SizedBox(height: 20),
          _apiHeader(),
          ...rows.map(_apiRow),
        ],
      ),
    );
  }

  Widget _apiHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0277BD),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              "Kind",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "Signature",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "Notes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiRow(_ApiRow row) {
    final Color kindColor;
    switch (row.kind) {
      case "ctor":
        kindColor = const Color(0xFF1976D2);
        break;
      case "getter":
        kindColor = const Color(0xFF00897B);
        break;
      case "override":
        kindColor = const Color(0xFFD81B60);
        break;
      default:
        kindColor = const Color(0xFF455A64);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFB3E5FC)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: kindColor.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: kindColor.withValues(alpha: 0.5)),
              ),
              child: Text(
                row.kind,
                style: TextStyle(
                  color: kindColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              row.signature,
              style: const TextStyle(
                color: Color(0xFF0D47A1),
                fontSize: 12,
                fontFamily: "monospace",
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              row.notes,
              style: const TextStyle(
                color: Color(0xFF37474F),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiRow {
  final String kind;
  final String signature;
  final String notes;
  const _ApiRow({
    required this.kind,
    required this.signature,
    required this.notes,
  });
}

// =============================================================================
// SECTION 8 — Performance Heuristics
// =============================================================================
// A small table mapping common scenarios to a recommendation: "use it",
// "avoid it", or "prefer X". The recommendations are derived from the cost
// model implied by the pass-comparison table earlier.
// =============================================================================
class _PerformanceHeuristicsSection extends StatelessWidget {
  const _PerformanceHeuristicsSection();

  @override
  Widget build(BuildContext context) {
    final List<_HeuristicRow> rows = <_HeuristicRow>[
      _HeuristicRow(
        scenario: "Cheap generator, traversed once",
        verdict: "avoid",
        rationale: "Use the iterator directly; CachingIterable adds overhead "
            "with no benefit.",
      ),
      _HeuristicRow(
        scenario: "Cheap generator, traversed many times",
        verdict: "prefer List",
        rationale: "Up-front .toList() is simpler and has the same asymptotic "
            "behaviour.",
      ),
      _HeuristicRow(
        scenario: "Expensive generator, traversed once",
        verdict: "avoid",
        rationale: "Skip the cache - there is no second pass to benefit.",
      ),
      _HeuristicRow(
        scenario: "Expensive generator, may be traversed many times",
        verdict: "use it",
        rationale: "The canonical use case. The first pass pays the cost; "
            "subsequent passes are O(n) cache scans.",
      ),
      _HeuristicRow(
        scenario: "Expensive generator, partial traversal",
        verdict: "use it",
        rationale: "You only pay for the prefix you actually walk, and that "
            "prefix is reused next time.",
      ),
      _HeuristicRow(
        scenario: "Very long generator, bounded window",
        verdict: "avoid",
        rationale: "CachingIterable keeps every element forever. Use a "
            "windowed wrapper.",
      ),
      _HeuristicRow(
        scenario: "Generator producing mutable values",
        verdict: "use with care",
        rationale: "Cached values are shared across passes. Treat them as "
            "immutable.",
      ),
      _HeuristicRow(
        scenario: "Generator that throws",
        verdict: "use with care",
        rationale: "Once an exception is thrown the cache may be partially "
            "filled. Subsequent passes will replay the same exception at the "
            "same index.",
      ),
      _HeuristicRow(
        scenario: "Length needed up front",
        verdict: "prefer List",
        rationale: ".length forces a full drain anyway; use a List<T> for "
            "clarity.",
      ),
      _HeuristicRow(
        scenario: "Constant-time random access needed",
        verdict: "prefer List",
        rationale: "CachingIterable elementAt is amortized O(1) but the "
            "first call to a cold index is O(index).",
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFF3E5F5),
            const Color(0xFFE1BEE7).withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFBA68C8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "08",
            title: "Performance Heuristics",
            subtitle: "When to reach for it, when to reach past it.",
          ),
          const SizedBox(height: 20),
          _heuristicHeader(),
          ...rows.map(_heuristicRow),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCE93D8)),
            ),
            child: const Text(
              "Rule of thumb: if you find yourself reaching for CachingIterable, "
              "ask whether a plain List<T> would be cheaper. The answer is yes "
              "more often than you might expect - caching is only worth it "
              "when partial traversal is genuinely common.",
              style: TextStyle(
                color: Color(0xFF6A1B9A),
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heuristicHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF6A1B9A),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              "Scenario",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Verdict",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "Rationale",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heuristicRow(_HeuristicRow row) {
    final Color verdictColor;
    switch (row.verdict) {
      case "use it":
        verdictColor = const Color(0xFF2E7D32);
        break;
      case "avoid":
        verdictColor = const Color(0xFFC62828);
        break;
      case "prefer List":
        verdictColor = const Color(0xFF1565C0);
        break;
      default:
        verdictColor = const Color(0xFFEF6C00);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE1BEE7)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              row.scenario,
              style: const TextStyle(
                color: Color(0xFF4A148C),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: verdictColor.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: verdictColor),
              ),
              child: Text(
                row.verdict,
                style: TextStyle(
                  color: verdictColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              row.rationale,
              style: const TextStyle(
                color: Color(0xFF37474F),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeuristicRow {
  final String scenario;
  final String verdict;
  final String rationale;
  const _HeuristicRow({
    required this.scenario,
    required this.verdict,
    required this.rationale,
  });
}

// =============================================================================
// SECTION 9 — Live Sample
// =============================================================================
// Renders the actual result of constructing a real CachingIterable<int> and
// calling .toList() on it twice. The label string is computed at build time
// and passed in via the constructor - this is the only place where the
// foundation import is exercised at runtime.
// =============================================================================
class _LiveSampleSection extends StatelessWidget {
  const _LiveSampleSection({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFF1F8E9),
            const Color(0xFFDCEDC8).withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFAED581)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: "09",
            title: "Live Sample",
            subtitle: "Real CachingIterable<int> double-toList output.",
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1B5E20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFC5E1A5),
                fontFamily: "monospace",
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "The string above is computed by calling toList() on the same "
            "CachingIterable<int> instance twice. The two halves are "
            "concatenated, which is why you see the sequence repeated. The "
            "underlying iterator was walked exactly once.",
            style: TextStyle(
              color: Color(0xFF33691E),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 — Footer
// =============================================================================
// Final colophon: file purpose, intended audience, related symbols, and a
// reminder that this file is documentation, not a runtime test.
// =============================================================================
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF263238),
            const Color(0xFF37474F).withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Colophon",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "File:           test/.../foundation/caching_iterable_test.dart",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontFamily: "monospace",
              fontSize: 12,
              height: 1.6,
            ),
          ),
          Text(
            "Subject:        Flutter foundation CachingIterable<T>",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontFamily: "monospace",
              fontSize: 12,
              height: 1.6,
            ),
          ),
          Text(
            "Audience:       framework developers, sliver authors, AST harness",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontFamily: "monospace",
              fontSize: 12,
              height: 1.6,
            ),
          ),
          Text(
            "Related:        SliverChildBuilderDelegate, Iterable.cast, sync*",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontFamily: "monospace",
              fontSize: 12,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "This file is a documentation artifact, not a runtime test. It is "
            "consumed by the tom_d4rt_flutter_ast harness, which parses it, "
            "extracts its AST, and re-renders it via D4rt to verify that the "
            "interpreter can faithfully reproduce the original widget tree.",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 12,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF7E57C2).withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              "end of file",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Shared widget: section title with number, title, and subtitle.
// =============================================================================
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
  });
  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF311B92),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF311B92),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF5E35B1),
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// APPENDIX A — Glossary
// =============================================================================
// A flat string-to-string glossary of every term used in the sections above.
// Included as static data so the AST harness can verify that long Map
// literals round-trip correctly.
// =============================================================================
const Map<String, String> _glossary = <String, String>{
  "Iterator":
      "A single-walk cursor over a sequence. Defined by the abstract class "
          "Iterator<T> in dart:core. Provides moveNext() and current.",
  "Iterable":
      "A re-entrant source of iterators. Defined by the abstract class "
          "Iterable<T> in dart:core. Calling .iterator may return a fresh "
          "iterator on every call.",
  "Lazy":
      "A computation that is deferred until its result is consumed. "
          "Opposite of eager.",
  "Eager":
      "A computation that runs immediately, regardless of whether its "
          "result is consumed. Opposite of lazy.",
  "Memoization":
      "Caching the result of a function so that repeated calls with the "
          "same input do not recompute.",
  "Generator":
      "A function that produces values one at a time, typically via "
          "Dart sync* or async* syntax.",
  "Sliver":
      "A scrollable region in Flutter. Slivers compute their child set "
          "lazily and ask for child N and child count repeatedly.",
  "Cache":
      "A storage area for previously-computed results, used to avoid "
          "recomputation. CachingIterable cache is an internal List<T>.",
  "High-water mark":
      "The largest index that has ever been requested from a cache. "
          "CachingIterable underlying iterator is advanced to exactly the "
          "high-water mark.",
  "Drain":
      "To advance an iterator until moveNext returns false. After draining, "
          "the iterator yields no more elements.",
  "Pristine":
      "The state of a CachingIterable that has never had an element "
          "requested from it.",
  "Warming":
      "The state of a CachingIterable whose underlying iterator has been "
          "partially walked.",
  "Sealed":
      "The state of a CachingIterable whose underlying iterator has been "
          "fully drained. The cache is now authoritative.",
  "Re-entrant":
      "A property of a sequence that allows it to be traversed any number "
          "of times. Iterables are re-entrant; iterators are not.",
  "Amortized":
      "An average-case cost over many operations. CachingIterable "
          "elementAt is amortized O(1) because the up-front cost of filling "
          "the cache is spread over future reads.",
};

// =============================================================================
// APPENDIX B — Frequently Asked Questions
// =============================================================================
// Static list of (question, answer) tuples that mirror the most common
// questions from the Flutter Discord and Stack Overflow.
// =============================================================================
const List<_FaqEntry> _faq = <_FaqEntry>[
  _FaqEntry(
    "Can I reset a CachingIterable?",
    "No. There is no public reset method. Construct a new CachingIterable "
        "with a fresh iterator if you need a clean cache.",
  ),
  _FaqEntry(
    "Is CachingIterable a List?",
    "No. It is an Iterable. It does not support indexed assignment, length "
        "setting, or any of the mutating List methods.",
  ),
  _FaqEntry(
    "Is CachingIterable thread-safe?",
    "No. Like most Dart collections, it is not designed for concurrent "
        "access. Since Dart is single-threaded per isolate, this is rarely "
        "an issue.",
  ),
  _FaqEntry(
    "What happens if the underlying iterator throws?",
    "The exception propagates to the caller. The cache will contain "
        "whatever was successfully cached before the throw. Subsequent reads "
        "of cached indexes work normally; subsequent reads of post-throw "
        "indexes will re-throw.",
  ),
  _FaqEntry(
    "Is there a memory limit on the cache?",
    "No. The cache grows monotonically. If you need bounded memory, wrap "
        "with a windowed iterable.",
  ),
  _FaqEntry(
    "Does CachingIterable preserve element identity?",
    "Yes. Each element is cached by reference, so callers across passes "
        "see the same instance.",
  ),
  _FaqEntry(
    "Can I subclass CachingIterable?",
    "Technically yes, but it is not designed as an extension point. Prefer "
        "composition.",
  ),
  _FaqEntry(
    "Why not use Iterable.toList() instead?",
    "toList eagerly walks the iterator. CachingIterable defers the walk "
        "until the cache is queried.",
  ),
  _FaqEntry(
    "Why not use sync*?",
    "A sync* generator returns a fresh Iterable but its iterator can "
        "still only be walked once. CachingIterable converts that one-shot "
        "iterator into a re-entrant iterable.",
  ),
  _FaqEntry(
    "How is this different from a Stream?",
    "Streams are asynchronous. CachingIterable is synchronous. The two "
        "do not interoperate directly.",
  ),
  _FaqEntry(
    "Does CachingIterable hash equal?",
    "It uses Object default hash and equality (identity). Wrap with "
        "IterableEquality if you need value equality.",
  ),
  _FaqEntry(
    "Is CachingIterable serializable?",
    "Only as much as its element type is. The cache itself is not "
        "exposed; serialize via .toList() then deserialize as a List.",
  ),
];

class _FaqEntry {
  final String question;
  final String answer;
  const _FaqEntry(this.question, this.answer);
}

// =============================================================================
// APPENDIX C — Cost Model (textual)
// =============================================================================
// A textual cost model expressed as a list of (operation, big-O, notes)
// records. This is referenced by the heuristics section and exists as a
// standalone artifact so the AST harness can verify long literal lists.
// =============================================================================
const List<_CostRow> _costModel = <_CostRow>[
  _CostRow("ctor", "O(1)", "Stores the iterator, allocates an empty cache."),
  _CostRow("first read of elementAt(k)", "O(k)", "Walks iterator k+1 times."),
  _CostRow("subsequent read of elementAt(k)", "O(1)", "Indexes the cache."),
  _CostRow("first read of length", "O(n)", "Drains the iterator fully."),
  _CostRow("subsequent read of length", "O(1)", "Returns cached length."),
  _CostRow("first iteration", "O(n)", "Walks and caches every element."),
  _CostRow("subsequent iteration", "O(n)", "Walks the cache; no iterator work."),
  _CostRow("first contains(x)", "O(n) worst", "Linear scan until found."),
  _CostRow("subsequent contains(x)", "O(n) worst", "Linear scan of cache."),
  _CostRow("first toList()", "O(n)", "Drain plus copy."),
  _CostRow("subsequent toList()", "O(n)", "Copy of cache."),
  _CostRow("take(k).toList() first", "O(k)", "Walks k elements."),
  _CostRow("take(k).toList() later", "O(k)", "Indexes k cache slots."),
  _CostRow("skip(k).toList() first", "O(n)", "Drains the whole iterator."),
  _CostRow("skip(k).toList() later", "O(n - k)", "Reads the tail of the cache."),
];

class _CostRow {
  final String op;
  final String bigO;
  final String notes;
  const _CostRow(this.op, this.bigO, this.notes);
}

// =============================================================================
// APPENDIX D — Internal Notes
// =============================================================================
// These notes describe implementation details of the Flutter framework
// CachingIterable. They are paraphrased from the framework source code as of
// the time of writing and are kept here for AST-harness coverage; the actual
// implementation may evolve.
// =============================================================================
const List<String> _internalNotes = <String>[
  "CachingIterable extends IterableBase<T> rather than Iterable<T> directly.",
  "The internal cache is a growable List<T> initialized to the empty list.",
  "A separate Iterator<T> field holds the source iterator.",
  "A bool field hasMoreElements tracks whether the source has been drained.",
  "When iterator is accessed, a custom Iterator<T> implementation is returned.",
  "That custom iterator walks the cache first, then transparently switches to "
      "the source iterator past the high-water mark.",
  "When the source moveNext returns false, hasMoreElements is set to false.",
  "From then on, iterator returns a plain Iterator<T> over the cache "
      "internal list.",
  "elementAt(int index) is overridden to ensure cache[index] exists before "
      "reading it; if not, the source iterator is advanced.",
  "length is overridden to ensure full drain before returning cache.length.",
  "contains(Object? element) is overridden to scan the cache first and then "
      "continue scanning the source iterator if not found.",
  "skip(int count) and take(int count) defer to the parent class but operate "
      "over the cached iterator.",
  "There is no toList override; the inherited implementation walks the "
      "(cached) iterator and copies the result.",
  "There is no toSet override; the inherited implementation deduplicates "
      "while walking.",
  "There is no equality override; two CachingIterables are not equal unless "
      "they are the same object.",
  "There is no hashCode override.",
  "There is no Diagnostic mixin.",
  "The class is not sealed and not immutable.",
  "The class is documented as a lazy iterable that caches its elements.",
];

// =============================================================================
// APPENDIX E — Worked Example: Sliver Children
// =============================================================================
// A long worked example showing exactly how SliverChildBuilderDelegate would
// have used CachingIterable historically. The example is purely textual and
// is included in the AST file to give the harness a large block of literal
// text to verify.
// =============================================================================
const String _workedExampleSliver = ""
    "Consider a SliverChildBuilderDelegate whose IndexedWidgetBuilder is "
    "expensive - say, it parses JSON and constructs a complex card widget. "
    "Without caching, the sliver protocol combined queries (childCount, "
    "build(index), build(index), childExtent, etc.) would re-invoke the "
    "builder many times for the same index. With a CachingIterable wrapping "
    "the builder output, each index is parsed exactly once and reused for "
    "every subsequent query. The first scroll into a region pays the parse "
    "cost; every subsequent measurement is a cache hit.\n\n"
    "The cache also enables a subtler optimization: when the user scrolls "
    "back to a previously-rendered region, the cache still holds the parsed "
    "widget descriptions, so the sliver protocol does not need to re-run "
    "the builder.\n\n"
    "Crucially, this does not bypass the framework child element recycling. "
    "The cache holds descriptors, not Element objects. The Element tree is "
    "still managed by the sliver itself, and the cache only memoizes the "
    "intermediate description data.";

// =============================================================================
// APPENDIX F — Worked Example: Animated List Diff
// =============================================================================
const String _workedExampleAnimatedList = ""
    "Animated list libraries typically compute a diff between the old and "
    "new child sets to decide which children to animate in, out, or move. "
    "The diff algorithm walks both sets multiple times: once to build a "
    "hash table, once to find matches, and once to emit move/insert/remove "
    "operations.\n\n"
    "If the child sets are produced by lazy generators (for example, a "
    "filtered view over a large data source), running the generator three "
    "times multiplies the cost. Wrapping the generator iterator in a "
    "CachingIterable lets the diff walk the sequence three times while "
    "running the generator only once.\n\n"
    "Bonus: when the diff is complete and the library has decided which "
    "children to mount, it still has the CachingIterable around and can use "
    "it to drive the actual widget building phase, again without re-running "
    "the generator.";

// =============================================================================
// APPENDIX G — Worked Example: Diagnostics
// =============================================================================
const String _workedExampleDiagnostics = ""
    "The Flutter diagnostics system asks widgets to describe themselves for "
    "the inspector and the toString() output. A common pattern is to expose "
    "a children iterable that the diagnostics tooling may walk to compute a "
    "child count, render the first few children inline, and emit a tree "
    "summary.\n\n"
    "Lazy widgets like SliverChildBuilderDelegate cannot afford to fully "
    "materialize their children just because the diagnostics tooling asked. "
    "By exposing a CachingIterable, they can answer how many children there "
    "are (by draining the iterator once and caching) and show the first "
    "three (by reading the cache) without re-running the builder on each "
    "diagnostics request.\n\n"
    "When the inspector closes, the cache stays around. Subsequent inspector "
    "openings reuse the cache. This is a small but real ergonomic win for "
    "framework developers.";

// =============================================================================
// APPENDIX H — Implementation Sketch (textual)
// =============================================================================
// A textual rendering of what a CachingIterable source code looks like.
// This is paraphrased; the real source is in flutter/foundation/lib/src/
// foundation/collections.dart.
// =============================================================================
const String _implementationSketch = ""
    "class CachingIterable<E> extends IterableBase<E> {\n"
    "  CachingIterable(this._prefillIterator);\n"
    "\n"
    "  final Iterator<E> _prefillIterator;\n"
    "  final List<E> _results = <E>[];\n"
    "\n"
    "  @override\n"
    "  Iterator<E> get iterator => _LazyListIterator<E>(this);\n"
    "\n"
    "  @override\n"
    "  Iterable<E> map<E2>(E2 Function(E e) toElement) sync* {\n"
    "    for (final E original in this) {\n"
    "      yield toElement(original) as E;\n"
    "    }\n"
    "  }\n"
    "\n"
    "  @override\n"
    "  Iterable<E> where(bool Function(E element) test) sync* {\n"
    "    for (final E original in this) {\n"
    "      if (test(original)) {\n"
    "        yield original;\n"
    "      }\n"
    "    }\n"
    "  }\n"
    "\n"
    "  @override\n"
    "  int get length {\n"
    "    _precacheEntireList();\n"
    "    return _results.length;\n"
    "  }\n"
    "\n"
    "  @override\n"
    "  List<E> toList({bool growable = true}) {\n"
    "    _precacheEntireList();\n"
    "    return List<E>.from(_results, growable: growable);\n"
    "  }\n"
    "\n"
    "  void _precacheEntireList() {\n"
    "    while (_fillNext()) { }\n"
    "  }\n"
    "\n"
    "  bool _fillNext() {\n"
    "    if (!_prefillIterator.moveNext()) {\n"
    "      return false;\n"
    "    }\n"
    "    _results.add(_prefillIterator.current);\n"
    "    return true;\n"
    "  }\n"
    "}\n";

// =============================================================================
// APPENDIX I — Test Vectors
// =============================================================================
// A long list of (input, operation, expected) tuples that an exhaustive
// test suite for CachingIterable might use. Static, declarative.
// =============================================================================
const List<_TestVector> _testVectors = <_TestVector>[
  _TestVector("[]", "toList()", "[]"),
  _TestVector("[]", "length", "0"),
  _TestVector("[]", "isEmpty", "true"),
  _TestVector("[]", "isNotEmpty", "false"),
  _TestVector("[1]", "toList()", "[1]"),
  _TestVector("[1]", "first", "1"),
  _TestVector("[1]", "last", "1"),
  _TestVector("[1]", "length", "1"),
  _TestVector("[1,2,3]", "toList()", "[1,2,3]"),
  _TestVector("[1,2,3]", "first", "1"),
  _TestVector("[1,2,3]", "last", "3"),
  _TestVector("[1,2,3]", "length", "3"),
  _TestVector("[1,2,3]", "elementAt(0)", "1"),
  _TestVector("[1,2,3]", "elementAt(1)", "2"),
  _TestVector("[1,2,3]", "elementAt(2)", "3"),
  _TestVector("[1,2,3]", "skip(1).toList()", "[2,3]"),
  _TestVector("[1,2,3]", "take(2).toList()", "[1,2]"),
  _TestVector("[1,2,3]", "where(odd).toList()", "[1,3]"),
  _TestVector("[1,2,3]", "map(*2).toList()", "[2,4,6]"),
  _TestVector("[1,2,3]", "fold(0, +)", "6"),
  _TestVector("[1,2,3]", "reduce(+)", "6"),
  _TestVector("[1,2,3]", "any(>2)", "true"),
  _TestVector("[1,2,3]", "every(>0)", "true"),
  _TestVector("[1,2,3]", "every(>1)", "false"),
  _TestVector("[1,2,3]", "contains(2)", "true"),
  _TestVector("[1,2,3]", "contains(4)", "false"),
  _TestVector("[1,2,3]", "join(,)", "1,2,3"),
  _TestVector("[3,1,2]", "toSet()", "{3,1,2}"),
  _TestVector("[3,1,2,1,3]", "toSet()", "{3,1,2}"),
  _TestVector("[a,b,c]", "toList() x2", "[a,b,c] then [a,b,c]"),
  _TestVector("[a,b,c]", "length x2", "3 then 3"),
  _TestVector("[a,b,c]", "first x2", "a then a"),
];

class _TestVector {
  final String input;
  final String op;
  final String expected;
  const _TestVector(this.input, this.op, this.expected);
}

// =============================================================================
// APPENDIX J — Cross-references
// =============================================================================
// A small static map listing related symbols in the Flutter framework that
// either use CachingIterable, look like CachingIterable, or are commonly
// confused with it.
// =============================================================================
const Map<String, String> _crossReferences = <String, String>{
  "SliverChildBuilderDelegate":
      "Uses lazy iteration; conceptually similar to a cached iterable.",
  "SliverChildListDelegate":
      "Eagerly materialized counterpart to SliverChildBuilderDelegate.",
  "Iterable.cast":
      "Returns a typed wrapper; lazy like CachingIterable but does not cache.",
  "Iterable.toList":
      "Eager materialization; the antonym of CachingIterable.",
  "Stream.asBroadcastStream":
      "The asynchronous cousin of CachingIterable; converts a single-listener "
          "stream into one that can be listened to multiple times.",
  "StreamController.broadcast":
      "Another asynchronous broadcast primitive.",
  "ListView.builder":
      "User-facing wrapper around SliverChildBuilderDelegate.",
  "GridView.builder":
      "User-facing wrapper around SliverChildBuilderDelegate.",
  "Iterable.cycle (package:quiver)":
      "Infinite iterable; cannot be cached because it has no end.",
  "DiagnosticsNode.getChildren":
      "Returns a list of diagnostic children; sometimes returned lazily.",
};

// =============================================================================
// APPENDIX K — Closing Remarks
// =============================================================================
// A short, deliberately verbose closing note that explains why this file
// exists and what it does not attempt to be. Pure prose; no Dart constructs
// beyond a String literal.
// =============================================================================
const String _closingRemarks = ""
    "This file deliberately resists the temptation to be exhaustive. "
    "CachingIterable is a small class and a small idea; the goal of this "
    "document is to surface that idea clearly, with enough surrounding "
    "context that a reader who has never used the class can pick it up "
    "and reach for it correctly the next time they need a lazy, "
    "memoized, re-entrant sequence.\n\n"
    "If you find yourself disagreeing with any of the heuristics in section "
    "08, you are probably right. Heuristics are summaries of common cases, "
    "and your case may not be common. The framework source code is short "
    "and worth reading directly; it lives in:\n\n"
    "    flutter/packages/flutter/lib/src/foundation/collections.dart\n\n"
    "There is nothing magical there. Just an Iterator<T>, a List<T>, and a "
    "small lazy-list iterator class that knits them together.\n\n"
    "If you remember only one thing from this document, let it be this: "
    "CachingIterable is the right answer when both lazy and repeatable "
    "must hold simultaneously. Drop either constraint and there is a "
    "simpler tool that fits better.";
