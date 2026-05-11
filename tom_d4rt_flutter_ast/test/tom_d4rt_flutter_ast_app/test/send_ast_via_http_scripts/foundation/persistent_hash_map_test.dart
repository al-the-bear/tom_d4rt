// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_declarations, unused_element_parameter
// D4rt test script: Deep Demo - PersistentHashMap<K extends Object, V> from package:flutter/foundation.dart
// Hand-crafted visual dossier of Flutter's immutable persistent hash-trie map:
//   - empty constructor
//   - put(key, value) returns a NEW PersistentHashMap (copy-on-write semantics)
//   - [] operator for lookup, returns null when absent
//   - structural sharing (unchanged sub-trees are reused)
//   - immutability (the receiver is never mutated)
//   - equality semantics (instances are distinct identity-wise even when contents match)
//
// This script renders an extensive, multi-section visual essay that demonstrates
// how PersistentHashMap is used internally by Flutter (think element rebuild caches)
// and how its functional API makes "time-traveling" through versions trivial.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // SETUP - Construct a series of PersistentHashMap snapshots that the
  // remainder of the demo will reference. We capture every intermediate
  // version so we can visually render the *history* of the map as well as
  // its terminal state.
  // ==========================================================================

  // The canonical starting point: the empty persistent map. Note the
  // constructor is `const`, so this is a compile-time constant: every empty
  // PersistentHashMap in your program is the same singleton.
  final PersistentHashMap<String, int> v0 = const PersistentHashMap<String,
      int>.empty();

  // SECTION 3 timeline: ten sequential puts. Each `put` returns a brand-new
  // PersistentHashMap; the previous version remains valid and unmutated.
  final PersistentHashMap<String, int> v1 = v0.put('alpha', 1);
  final PersistentHashMap<String, int> v2 = v1.put('beta', 2);
  final PersistentHashMap<String, int> v3 = v2.put('gamma', 3);
  final PersistentHashMap<String, int> v4 = v3.put('delta', 4);
  final PersistentHashMap<String, int> v5 = v4.put('epsilon', 5);
  final PersistentHashMap<String, int> v6 = v5.put('zeta', 6);
  final PersistentHashMap<String, int> v7 = v6.put('eta', 7);
  final PersistentHashMap<String, int> v8 = v7.put('theta', 8);
  final PersistentHashMap<String, int> v9 = v8.put('iota', 9);
  final PersistentHashMap<String, int> v10 = v9.put('kappa', 10);

  // Capture the timeline as a list of (label, snapshot) pairs so the UI
  // can iterate over them cleanly.
  final List<_TimelineFrame<String, int>> timeline = <_TimelineFrame<String,
      int>>[
    _TimelineFrame<String, int>('v0  (empty)', v0, '— start —', null),
    _TimelineFrame<String, int>('v1  (after +alpha)', v1, 'alpha', 1),
    _TimelineFrame<String, int>('v2  (after +beta)', v2, 'beta', 2),
    _TimelineFrame<String, int>('v3  (after +gamma)', v3, 'gamma', 3),
    _TimelineFrame<String, int>('v4  (after +delta)', v4, 'delta', 4),
    _TimelineFrame<String, int>('v5  (after +epsilon)', v5, 'epsilon', 5),
    _TimelineFrame<String, int>('v6  (after +zeta)', v6, 'zeta', 6),
    _TimelineFrame<String, int>('v7  (after +eta)', v7, 'eta', 7),
    _TimelineFrame<String, int>('v8  (after +theta)', v8, 'theta', 8),
    _TimelineFrame<String, int>('v9  (after +iota)', v9, 'iota', 9),
    _TimelineFrame<String, int>('v10 (after +kappa)', v10, 'kappa', 10),
  ];

  // SECTION 4: A "branch and merge" demonstration. Two sibling derivations
  // share v3 as their common ancestor; each then diverges with different
  // puts. This shows how persistent data structures naturally model
  // version-control-like topologies without ever copying full state.
  final PersistentHashMap<String, int> baseForBranch = v3;
  final PersistentHashMap<String, int> branchLeftA =
      baseForBranch.put('left_a', 100);
  final PersistentHashMap<String, int> branchLeftB =
      branchLeftA.put('left_b', 101);
  final PersistentHashMap<String, int> branchRightA =
      baseForBranch.put('right_a', 200);
  final PersistentHashMap<String, int> branchRightB =
      branchRightA.put('right_b', 201);

  // SECTION 5: Lookup gallery. The same map is queried with present and
  // missing keys, including the awkward edge cases (empty string keys,
  // case-sensitivity).
  final PersistentHashMap<String, int> lookupTarget = v10;
  final List<_LookupProbe> lookupProbes = <_LookupProbe>[
    _LookupProbe('alpha', lookupTarget['alpha']),
    _LookupProbe('beta', lookupTarget['beta']),
    _LookupProbe('gamma', lookupTarget['gamma']),
    _LookupProbe('Alpha (different case)', lookupTarget['Alpha']),
    _LookupProbe('kappa', lookupTarget['kappa']),
    _LookupProbe('omicron (absent)', lookupTarget['omicron']),
    _LookupProbe('"" (empty key, absent)', lookupTarget['']),
    _LookupProbe('lambda (absent)', lookupTarget['lambda']),
  ];

  // SECTION 6: Equality. We deliberately build two maps with the SAME logical
  // contents but via different insertion paths, then check identity and
  // hashCode.
  final PersistentHashMap<String, int> pathA = const PersistentHashMap<String,
          int>.empty()
      .put('x', 1)
      .put('y', 2)
      .put('z', 3);
  final PersistentHashMap<String, int> pathB = const PersistentHashMap<String,
          int>.empty()
      .put('z', 3)
      .put('y', 2)
      .put('x', 1);
  final bool identicalAB = identical(pathA, pathB);
  final bool operatorEqAB = pathA == pathB;
  final int hashA = pathA.hashCode;
  final int hashB = pathB.hashCode;

  // SECTION 7: A simulated "element cache" use case — a build phase that
  // accumulates render-cache entries per widget key.
  PersistentHashMap<String, int> elementCache =
      const PersistentHashMap<String, int>.empty();
  final List<String> renderedKeys = <String>[
    'AppBar',
    'BodyColumn',
    'BodyColumn.child[0]',
    'BodyColumn.child[1]',
    'BodyColumn.child[2]',
    'FooterBar',
  ];
  final List<_CacheStep> cacheSteps = <_CacheStep>[];
  int stamp = 1000;
  for (final String key in renderedKeys) {
    final PersistentHashMap<String, int> before = elementCache;
    elementCache = elementCache.put(key, stamp);
    cacheSteps.add(_CacheStep(key, stamp, before, elementCache));
    stamp++;
  }

  // ==========================================================================
  // VISUAL TREE
  // ==========================================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('PersistentHashMap — Deep Visual Dossier'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    backgroundColor: const Color(0xFFF5F6FA),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ===================================================================
          // SECTION 1 - DOSSIER
          // ===================================================================
          _SectionHeader(
            index: 1,
            title: 'Dossier',
            subtitle:
                'What PersistentHashMap is, and why it exists in Flutter.',
            color: Colors.indigo,
          ),
          _DossierCard(),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 2 - ANATOMY
          // ===================================================================
          _SectionHeader(
            index: 2,
            title: 'Anatomy',
            subtitle:
                'The constructor, the put() method, and the [] operator.',
            color: Colors.teal,
          ),
          _AnatomyCard(),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 3 - SEQUENTIAL PUT TIMELINE
          // ===================================================================
          _SectionHeader(
            index: 3,
            title: 'Sequential put — the timeline',
            subtitle:
                'Ten put() calls. Each returns a new instance. The previous '
                'instances remain valid, frozen, and queryable.',
            color: Colors.deepPurple,
          ),
          ...timeline.map((_TimelineFrame<String, int> frame) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _TimelineFrameCard(frame: frame),
            );
          }),
          const SizedBox(height: 8),
          _TimelineFooterLegend(),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 4 - BRANCH & MERGE
          // ===================================================================
          _SectionHeader(
            index: 4,
            title: 'Branch & merge — the version tree',
            subtitle:
                'Two sibling derivations from a common ancestor coexist '
                'simultaneously. Each is independent and immutable.',
            color: Colors.orange,
          ),
          _BranchDiagram(
            base: baseForBranch,
            leftA: branchLeftA,
            leftB: branchLeftB,
            rightA: branchRightA,
            rightB: branchRightB,
          ),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 5 - LOOKUP GALLERY
          // ===================================================================
          _SectionHeader(
            index: 5,
            title: 'Lookup gallery — present, missing, null',
            subtitle:
                'The [] operator returns V? — null when the key is absent. '
                'Keys are matched by ==, so case matters for Strings.',
            color: Colors.blue,
          ),
          _LookupGallery(probes: lookupProbes, target: lookupTarget),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 6 - EQUALITY
          // ===================================================================
          _SectionHeader(
            index: 6,
            title: 'Equality & hashCode',
            subtitle:
                'Two maps with the same logical contents — built via '
                'different insertion paths. Compare identity and ==.',
            color: Colors.pink,
          ),
          _EqualityCard(
            pathA: pathA,
            pathB: pathB,
            identical: identicalAB,
            operatorEq: operatorEqAB,
            hashA: hashA,
            hashB: hashB,
          ),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 7 - USE CASE
          // ===================================================================
          _SectionHeader(
            index: 7,
            title: 'Use-case: element/build cache',
            subtitle:
                'Flutter\'s internal patterns use PersistentHashMap so that '
                'caches survive rebuilds with structural sharing.',
            color: Colors.green,
          ),
          ...cacheSteps.map((_CacheStep step) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CacheStepCard(step: step),
            );
          }),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 8 - RECIPE CARDS
          // ===================================================================
          _SectionHeader(
            index: 8,
            title: 'Recipe cards',
            subtitle: 'Common patterns you will reach for in real code.',
            color: Colors.brown,
          ),
          _RecipeGrid(),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 9 - COMPARISON TABLE
          // ===================================================================
          _SectionHeader(
            index: 9,
            title: 'PersistentHashMap vs. friends',
            subtitle:
                'How it compares to Map, Map.unmodifiable, and LinkedHashMap.',
            color: Colors.cyan,
          ),
          _ComparisonTable(),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 10 - GLOSSARY
          // ===================================================================
          _SectionHeader(
            index: 10,
            title: 'Glossary',
            subtitle: 'Words you will see in this corner of Flutter.',
            color: Colors.blueGrey,
          ),
          _GlossaryList(),
          const SizedBox(height: 24),

          // ===================================================================
          // SECTION 11 - FINAL COMPOSED WIDGET TREE
          // ===================================================================
          _SectionHeader(
            index: 11,
            title: 'Final composed snapshot',
            subtitle:
                'Putting it all together — terminal state of v10 with full '
                'render of every entry, plus the four branch tips.',
            color: Colors.red,
          ),
          _FinalSnapshotCard(
            terminal: v10,
            branchTips: <String, PersistentHashMap<String, int>>{
              'left-tip  (branchLeftB)': branchLeftB,
              'right-tip (branchRightB)': branchRightB,
              'pathA': pathA,
              'pathB': pathB,
              'elementCache (final)': elementCache,
            },
          ),
          const SizedBox(height: 32),
          _Footer(),
        ],
      ),
    ),
  );
}

// =============================================================================
// HELPER TYPES
// =============================================================================

class _TimelineFrame<K extends Object, V> {
  final String label;
  final PersistentHashMap<K, V> snapshot;
  final String addedKey;
  final V? addedValue;
  const _TimelineFrame(
      this.label, this.snapshot, this.addedKey, this.addedValue);
}

class _LookupProbe {
  final String label;
  final int? result;
  const _LookupProbe(this.label, this.result);
}

class _CacheStep {
  final String key;
  final int stamp;
  final PersistentHashMap<String, int> before;
  final PersistentHashMap<String, int> after;
  const _CacheStep(this.key, this.stamp, this.before, this.after);
}

// =============================================================================
// REUSABLE WIDGETS
// =============================================================================

class _SectionHeader extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final MaterialColor color;
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.shade700,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
                    color: color.shade900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: color.shade700,
                    fontSize: 13,
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

class _DossierCard extends StatelessWidget {
  const _DossierCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(Colors.indigo),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'PersistentHashMap<K extends Object, V>',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'A persistent hash-trie map: every "modification" produces a NEW '
            'map; the original is never altered. Internally Flutter uses this '
            'to back fast O(log32 N) updates while keeping copy-on-write '
            'guarantees, so callers can hand maps around without worrying '
            'about concurrent mutation.',
          ),
          const SizedBox(height: 12),
          _BulletList(items: <String>[
            'Immutable: receiver is never modified by put().',
            'Structurally shared: unchanged subtrees are reused across versions.',
            'Cheap to fork: derive 1000 versions, pay only for the diffs.',
            'Generic: keys must extend Object (cannot be null), values are free.',
            'Constant-time empty(): the empty map is a const singleton.',
          ]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.lightbulb_outline,
                    size: 18, color: Colors.indigo),
                const SizedBox(width: 6),
                Expanded(
                  child: const Text(
                    'Think of it as "Git for Map<K,V>": every commit is a new '
                    'value, old commits are still queryable, and storage is '
                    'shared between commits.',
                    style: TextStyle(fontStyle: FontStyle.italic),
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

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(Colors.teal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _AnatomyRow(
            symbol: 'const PersistentHashMap<K, V>.empty()',
            description:
                'Compile-time constant constructor for the empty map. Every '
                'use site shares the same instance.',
          ),
          const Divider(),
          _AnatomyRow(
            symbol: 'PersistentHashMap<K, V> put(K key, V value)',
            description:
                'Returns a NEW PersistentHashMap with the entry added or '
                'replaced. The receiver is unchanged.',
          ),
          const Divider(),
          _AnatomyRow(
            symbol: 'V? operator [](Object? key)',
            description:
                'Returns the value associated with key, or null if the key is '
                'absent. The parameter is Object? because the map is happy to '
                'be queried with foreign types.',
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'NB: PersistentHashMap does NOT implement Map<K,V> — it has a '
              'deliberately tiny API to keep the persistent semantics '
              'unambiguous.',
              style: TextStyle(fontSize: 12, color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  final String symbol;
  final String description;
  const _AnatomyRow({required this.symbol, required this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.teal.shade900,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              symbol,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class _TimelineFrameCard extends StatelessWidget {
  final _TimelineFrame<String, int> frame;
  const _TimelineFrameCard({required this.frame});
  @override
  Widget build(BuildContext context) {
    // Reconstruct the visual entries by probing the snapshot for each key we
    // know was added by this point in the timeline. We can't iterate
    // PersistentHashMap directly (it has no public iterator), so we drive the
    // render from the timeline metadata.
    final List<String> knownKeys = <String>[
      'alpha',
      'beta',
      'gamma',
      'delta',
      'epsilon',
      'zeta',
      'eta',
      'theta',
      'iota',
      'kappa',
    ];
    final List<MapEntry<String, int>> presentEntries = <MapEntry<String, int>>[];
    for (final String k in knownKeys) {
      final int? v = frame.snapshot[k];
      if (v != null) {
        presentEntries.add(MapEntry<String, int>(k, v));
      }
    }
    final bool isEmpty = presentEntries.isEmpty;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(Colors.deepPurple),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  frame.label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.deepPurple.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${presentEntries.length} entr${presentEntries.length == 1 ? "y" : "ies"}',
                style: TextStyle(
                  color: Colors.deepPurple.shade400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                '∅  empty map',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.grey,
                ),
              ),
            )
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: presentEntries.map((MapEntry<String, int> e) {
                final bool isNew = e.key == frame.addedKey;
                return _EntryChip(
                  k: e.key,
                  v: e.value.toString(),
                  isNew: isNew,
                );
              }).toList(),
            ),
          if (frame.addedKey != '— start —') ...<Widget>[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.add, size: 14, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'put("${frame.addedKey}", ${frame.addedValue})',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EntryChip extends StatelessWidget {
  final String k;
  final String v;
  final bool isNew;
  final bool shared;
  const _EntryChip({
    required this.k,
    required this.v,
    this.isNew = false,
    this.shared = false,
  });
  @override
  Widget build(BuildContext context) {
    final Color bg = isNew
        ? Colors.green.shade600
        : (shared ? Colors.blueGrey.shade400 : Colors.deepPurple.shade400);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            k,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const Text(' → ', style: TextStyle(color: Colors.white70)),
          Text(
            v,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
          if (isNew) ...<Widget>[
            const SizedBox(width: 4),
            const Icon(Icons.fiber_new, size: 12, color: Colors.white),
          ],
          if (shared) ...<Widget>[
            const SizedBox(width: 4),
            const Icon(Icons.link, size: 12, color: Colors.white),
          ],
        ],
      ),
    );
  }
}

class _TimelineFooterLegend extends StatelessWidget {
  const _TimelineFooterLegend();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          const _EntryChip(k: 'foo', v: '1', isNew: true),
          const SizedBox(width: 6),
          const Text('= newly added in this frame'),
          const SizedBox(width: 16),
          const _EntryChip(k: 'foo', v: '1'),
          const SizedBox(width: 6),
          const Text('= structurally shared'),
        ],
      ),
    );
  }
}

class _BranchDiagram extends StatelessWidget {
  final PersistentHashMap<String, int> base;
  final PersistentHashMap<String, int> leftA;
  final PersistentHashMap<String, int> leftB;
  final PersistentHashMap<String, int> rightA;
  final PersistentHashMap<String, int> rightB;
  const _BranchDiagram({
    required this.base,
    required this.leftA,
    required this.leftB,
    required this.rightA,
    required this.rightB,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(Colors.orange),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _BranchNode(
            label: 'base (v3)',
            color: Colors.orange.shade700,
            entries: <String, int?>{
              'alpha': base['alpha'],
              'beta': base['beta'],
              'gamma': base['gamma'],
            },
          ),
          const _ArrowDown(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.subdirectory_arrow_left, color: Colors.orange),
              const Icon(Icons.subdirectory_arrow_right, color: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    _BranchNode(
                      label: 'leftA  (+left_a)',
                      color: Colors.deepOrange.shade400,
                      entries: <String, int?>{
                        'alpha': leftA['alpha'],
                        'beta': leftA['beta'],
                        'gamma': leftA['gamma'],
                        'left_a': leftA['left_a'],
                      },
                    ),
                    const _ArrowDown(),
                    _BranchNode(
                      label: 'leftB  (+left_b)',
                      color: Colors.deepOrange.shade700,
                      entries: <String, int?>{
                        'alpha': leftB['alpha'],
                        'beta': leftB['beta'],
                        'gamma': leftB['gamma'],
                        'left_a': leftB['left_a'],
                        'left_b': leftB['left_b'],
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: <Widget>[
                    _BranchNode(
                      label: 'rightA (+right_a)',
                      color: Colors.amber.shade700,
                      entries: <String, int?>{
                        'alpha': rightA['alpha'],
                        'beta': rightA['beta'],
                        'gamma': rightA['gamma'],
                        'right_a': rightA['right_a'],
                      },
                    ),
                    const _ArrowDown(),
                    _BranchNode(
                      label: 'rightB (+right_b)',
                      color: Colors.amber.shade900,
                      entries: <String, int?>{
                        'alpha': rightB['alpha'],
                        'beta': rightB['beta'],
                        'gamma': rightB['gamma'],
                        'right_a': rightB['right_a'],
                        'right_b': rightB['right_b'],
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.eco, color: Colors.green),
                const SizedBox(width: 6),
                Expanded(
                  child: const Text(
                    'Structural sharing: alpha/beta/gamma exist exactly once '
                    'in memory across all five maps. Branching is therefore '
                    'O(log32 N) rather than O(N).',
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

class _BranchNode extends StatelessWidget {
  final String label;
  final Color color;
  final Map<String, int?> entries;
  const _BranchNode({
    required this.label,
    required this.color,
    required this.entries,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          ...entries.entries.map((MapEntry<String, int?> e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: <Widget>[
                  Text(
                    e.key,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(' → '),
                  Text(
                    e.value?.toString() ?? 'null',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ArrowDown extends StatelessWidget {
  const _ArrowDown();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: <Widget>[
          Container(width: 2, height: 12, color: Colors.orange.shade400),
          Icon(Icons.arrow_drop_down, color: Colors.orange.shade400),
        ],
      ),
    );
  }
}

class _LookupGallery extends StatelessWidget {
  final List<_LookupProbe> probes;
  final PersistentHashMap<String, int> target;
  const _LookupGallery({required this.probes, required this.target});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Probing v10 (10 entries: alpha…kappa) with various keys',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...probes.map((_LookupProbe p) {
            final bool hit = p.result != null;
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: hit ? Colors.blue.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: hit ? Colors.blue.shade300 : Colors.red.shade200,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    hit ? Icons.check_circle : Icons.cancel,
                    color: hit ? Colors.blue : Colors.red,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'map["${p.label}"]',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: hit ? Colors.blue : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      hit ? '= ${p.result}' : '= null',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _EqualityCard extends StatelessWidget {
  final PersistentHashMap<String, int> pathA;
  final PersistentHashMap<String, int> pathB;
  final bool identical;
  final bool operatorEq;
  final int hashA;
  final int hashB;
  const _EqualityCard({
    required this.pathA,
    required this.pathB,
    required this.identical,
    required this.operatorEq,
    required this.hashA,
    required this.hashB,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(Colors.pink),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _EqualityColumn(
                  title: 'pathA: x→y→z',
                  map: pathA,
                  keys: const <String>['x', 'y', 'z'],
                  color: Colors.pink.shade400,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _EqualityColumn(
                  title: 'pathB: z→y→x',
                  map: pathB,
                  keys: const <String>['x', 'y', 'z'],
                  color: Colors.pinkAccent.shade400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _EqualityRow(
              label: 'identical(pathA, pathB)',
              value: identical.toString(),
              good: false),
          _EqualityRow(
              label: 'pathA == pathB',
              value: operatorEq.toString(),
              good: false),
          _EqualityRow(
              label: 'pathA.hashCode',
              value: hashA.toRadixString(16),
              good: true),
          _EqualityRow(
              label: 'pathB.hashCode',
              value: hashB.toRadixString(16),
              good: true),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'PersistentHashMap deliberately does NOT override == or '
              'hashCode for content-equality. Two maps with the same logical '
              'contents are still distinct objects. To compare contents you '
              'must walk both maps yourself.',
            ),
          ),
        ],
      ),
    );
  }
}

class _EqualityColumn extends StatelessWidget {
  final String title;
  final PersistentHashMap<String, int> map;
  final List<String> keys;
  final Color color;
  const _EqualityColumn({
    required this.title,
    required this.map,
    required this.keys,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          ...keys.map((String k) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                '$k → ${map[k]}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _EqualityRow extends StatelessWidget {
  final String label;
  final String value;
  final bool good;
  const _EqualityRow({
    required this.label,
    required this.value,
    required this.good,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: good ? Colors.green.shade100 : Colors.red.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: good ? Colors.green.shade900 : Colors.red.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CacheStepCard extends StatelessWidget {
  final _CacheStep step;
  const _CacheStepCard({required this.step});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(Colors.green),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.cached, size: 16, color: Colors.green),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'put("${step.key}", ${step.stamp})',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _CacheSlot(
                  title: 'before',
                  value: step.before[step.key]?.toString() ?? 'absent',
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.east),
              ),
              Expanded(
                child: _CacheSlot(
                  title: 'after',
                  value: step.after[step.key]?.toString() ?? 'absent',
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CacheSlot extends StatelessWidget {
  final String title;
  final String value;
  final MaterialColor color;
  const _CacheSlot({
    required this.title,
    required this.value,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeGrid extends StatelessWidget {
  const _RecipeGrid();
  static const List<List<String>> _recipes = <List<String>>[
    <String>[
      'Build an empty map',
      'final m = const PersistentHashMap<String,int>.empty();',
    ],
    <String>[
      'Insert one entry',
      'final m2 = m.put("foo", 1);',
    ],
    <String>[
      'Insert many in a chain',
      'final m3 = m.put("a",1).put("b",2).put("c",3);',
    ],
    <String>[
      'Lookup with default',
      'final v = m["foo"] ?? -1;',
    ],
    <String>[
      'Branch from a base',
      'final left = base.put("x", 9);\nfinal right = base.put("y", 10);',
    ],
    <String>[
      'Replace existing key',
      'final updated = m.put("foo", 999);',
    ],
    <String>[
      'Use as a frozen field',
      'class State { final PersistentHashMap<String,int> cache; ... }',
    ],
    <String>[
      'Snapshot for diffing',
      'final old = current;\ncurrent = current.put("k", v);\n// diff(old, current)',
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _recipes.map((List<String> r) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: _cardDecoration(Colors.brown),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.menu_book,
                      size: 16, color: Colors.brown),
                  const SizedBox(width: 6),
                  Text(
                    r[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.brown.shade900,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  r[1],
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();
  static const List<List<String>> _rows = <List<String>>[
    <String>['Mutable', 'No', 'Yes', 'No (throws)', 'Yes'],
    <String>['Returns new on update', 'Yes', 'No', 'N/A', 'No'],
    <String>['Structural sharing', 'Yes', 'No', 'No', 'No'],
    <String>['Implements Map<K,V>', 'No', 'Yes', 'Yes', 'Yes'],
    <String>['Preserves insertion order', 'No', 'Yes (LinkedHashMap)', 'Yes', 'Yes'],
    <String>['Constant empty constructor', 'Yes', 'Effectively', 'No', 'Effectively'],
    <String>['Suitable for caches across rebuilds', 'Yes', 'Risky', 'Read-only', 'Risky'],
    <String>['Iterable', 'No public iterator', 'Yes', 'Yes', 'Yes'],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(Colors.cyan),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.cyan.shade100),
          columns: const <DataColumn>[
            DataColumn(
                label: Text('Property',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('PersistentHashMap')),
            DataColumn(label: Text('Map<K,V>')),
            DataColumn(label: Text('Map.unmodifiable')),
            DataColumn(label: Text('LinkedHashMap')),
          ],
          rows: _rows.map((List<String> r) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(r[0],
                    style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(r[1])),
                DataCell(Text(r[2])),
                DataCell(Text(r[3])),
                DataCell(Text(r[4])),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _GlossaryList extends StatelessWidget {
  const _GlossaryList();
  static const List<List<String>> _terms = <List<String>>[
    <String>[
      'Persistent data structure',
      'A data structure that preserves previous versions of itself when modified.',
    ],
    <String>[
      'Structural sharing',
      'Two versions of a data structure pointing at the same sub-trees in memory.',
    ],
    <String>[
      'Hash trie',
      'A tree where the path to a node is determined by chunks of the key\'s hash.',
    ],
    <String>[
      'Copy-on-write',
      'A mutation strategy that copies only the affected nodes, not the whole structure.',
    ],
    <String>[
      'Immutability',
      'A guarantee that a value, once constructed, will never change.',
    ],
    <String>[
      'Functional update',
      'An update modeled as: oldValue → newValue, leaving oldValue intact.',
    ],
    <String>[
      'Singleton empty',
      'A const empty instance reused everywhere — zero allocation cost.',
    ],
    <String>[
      'Lookup',
      'Retrieving a value by key. PersistentHashMap exposes this via [].',
    ],
    <String>[
      'Branch',
      'A derived version that diverges from a common ancestor (like git branches).',
    ],
    <String>[
      'Version tree',
      'The DAG formed by all derived versions of a persistent structure.',
    ],
    <String>[
      'O(log32 N)',
      'Roughly the cost of put/lookup in this trie — practically near-constant.',
    ],
    <String>[
      'Element cache',
      'A Flutter idiom: a map keyed by element identity used during rebuilds.',
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(Colors.blueGrey),
      child: Column(
        children: _terms.map((List<String> t) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  t[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(t[1], style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FinalSnapshotCard extends StatelessWidget {
  final PersistentHashMap<String, int> terminal;
  final Map<String, PersistentHashMap<String, int>> branchTips;
  const _FinalSnapshotCard({
    required this.terminal,
    required this.branchTips,
  });
  @override
  Widget build(BuildContext context) {
    final List<String> probedKeys = <String>[
      'alpha',
      'beta',
      'gamma',
      'delta',
      'epsilon',
      'zeta',
      'eta',
      'theta',
      'iota',
      'kappa',
      'left_a',
      'left_b',
      'right_a',
      'right_b',
      'AppBar',
      'BodyColumn',
      'FooterBar',
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(Colors.red),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Terminal map: v10',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <String>[
              'alpha',
              'beta',
              'gamma',
              'delta',
              'epsilon',
              'zeta',
              'eta',
              'theta',
              'iota',
              'kappa'
            ].map((String k) {
              final int? v = terminal[k];
              return _EntryChip(k: k, v: v?.toString() ?? 'null');
            }).toList(),
          ),
          const Divider(height: 24),
          ...branchTips.entries.map(
              (MapEntry<String, PersistentHashMap<String, int>> tip) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tip.key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: probedKeys
                        .map((String k) {
                          final int? v = tip.value[k];
                          if (v == null) return null;
                          return _EntryChip(k: k, v: v.toString());
                        })
                        .whereType<Widget>()
                        .toList(),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.flag, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: const Text(
              'End of dossier — PersistentHashMap is small, frozen, fast, '
              'and shared. Reach for it whenever you need a Map that promises '
              'never to surprise you.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((String s) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.circle, size: 6, color: Colors.indigo),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(s)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

BoxDecoration _cardDecoration(MaterialColor color) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: color.shade200),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: color.shade100,
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
