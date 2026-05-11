// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unnecessary_import, unused_element_parameter
// D4rt test script: Deep Demo - KeyedSubtree Widget
// Comprehensive demonstration of KeyedSubtree, its constructors, helpers,
// and its relationship with ValueKey, GlobalKey, ObjectKey, and UniqueKey.
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // DATA: DOSSIER ENTRIES
  // ==========================================================================
  // KeyedSubtree is a single-purpose widget that wraps a child with a Key
  // without otherwise touching the rendering, layout, or paint of the tree.
  // It is invaluable when Flutter's element reconciliation would otherwise
  // confuse two structurally identical subtrees.

  final dossierEntries = <Map<String, String>>[
    {
      'title': 'Identity in dynamic lists',
      'description':
          'When list items reorder, Flutter matches by position by default. '
          'Wrapping each in KeyedSubtree pins identity to the data, not the slot.',
    },
    {
      'title': 'Reorderable children',
      'description':
          'Drag-and-drop reorder widgets (ReorderableListView) require stable '
          'keys per row so animations and state attach to the moving cell.',
    },
    {
      'title': 'AnimatedSwitcher subtree swap',
      'description':
          'AnimatedSwitcher triggers a cross-fade when the child key differs. '
          'KeyedSubtree provides the boundary that AnimatedSwitcher detects.',
    },
    {
      'title': 'Preserving State across structural moves',
      'description':
          'Stateful children keep their State if their key remains the same. '
          'KeyedSubtree exposes that key without changing the child widget type.',
    },
    {
      'title': 'No render overhead',
      'description':
          'KeyedSubtree is a ProxyWidget — it inserts no extra RenderObject, '
          'no extra paint phase, only a stable element identity for its child.',
    },
  ];

  // ==========================================================================
  // DATA: ANATOMY OF THE CLASS
  // ==========================================================================

  final anatomyRows = <Map<String, String>>[
    {
      'member': 'KeyedSubtree({Key? key, required Widget child})',
      'kind': 'constructor',
      'role': 'Wrap a child with an explicit key, no other side effects.',
    },
    {
      'member': 'KeyedSubtree.wrap(Widget child, int childIndex)',
      'kind': 'factory',
      'role':
          'Convenience that attaches a ValueKey<int>(childIndex) when the '
          'child does not already carry one.',
    },
    {
      'member': 'KeyedSubtree.ensureUniqueKeysForList(List<Widget> items)',
      'kind': 'static',
      'role':
          'Iterate the list and wrap any items lacking a key, producing a '
          'list of widgets where every entry is identifiable.',
    },
    {
      'member': 'child',
      'kind': 'field',
      'role': 'The single wrapped child widget.',
    },
    {
      'member': 'key',
      'kind': 'inherited',
      'role':
          'The Key that this KeyedSubtree contributes to the element tree.',
    },
  ];

  // ==========================================================================
  // DATA: KEY TYPE TAXONOMY USED WITH KEYEDSUBTREE
  // ==========================================================================

  final keyTaxonomy = <Map<String, String>>[
    {
      'type': 'ValueKey<T>',
      'good_for': 'Stable scalar identity (id, name, hash).',
      'note': 'Equality based on the wrapped value.',
    },
    {
      'type': 'ObjectKey',
      'good_for': 'Identity tied to a specific Dart object reference.',
      'note': 'Equality based on object identical().',
    },
    {
      'type': 'UniqueKey',
      'good_for': 'Force fresh state on every rebuild.',
      'note': 'Never equal to anything else, including itself across builds.',
    },
    {
      'type': 'GlobalKey',
      'good_for': 'Cross-tree access to an Element or State.',
      'note': 'Heavyweight — only when you really need the handle.',
    },
    {
      'type': 'GlobalKey<T>',
      'good_for': 'Typed access to a specific State<T> instance.',
      'note': 'Provides `currentState` of the matching type.',
    },
  ];

  // ==========================================================================
  // SECTION 1 DATA: BASIC CONSTRUCTOR USES
  // ==========================================================================

  final basicValueKey = KeyedSubtree(
    key: const ValueKey<String>('alpha'),
    child: const _CellBadge(label: 'alpha', color: Color(0xFF1976D2)),
  );
  final basicObjectKey = KeyedSubtree(
    key: ObjectKey(const Object()),
    child: const _CellBadge(label: 'beta', color: Color(0xFF388E3C)),
  );
  final basicUniqueKey = KeyedSubtree(
    key: UniqueKey(),
    child: const _CellBadge(label: 'gamma', color: Color(0xFFE64A19)),
  );
  final basicGlobalKey = KeyedSubtree(
    key: GlobalKey(debugLabel: 'delta-handle'),
    child: const _CellBadge(label: 'delta', color: Color(0xFF7B1FA2)),
  );
  final basicNoKey = KeyedSubtree(
    child: const _CellBadge(label: 'no-key', color: Color(0xFF455A64)),
  );

  final basicSamples = <KeyedSubtree>[
    basicValueKey,
    basicObjectKey,
    basicUniqueKey,
    basicGlobalKey,
    basicNoKey,
  ];

  final basicSampleDescriptions = <String>[
    'ValueKey<String>("alpha") — stable identity by literal',
    'ObjectKey(Object()) — identity by object reference',
    'UniqueKey() — fresh identity on every build',
    'GlobalKey(debugLabel:"delta-handle") — addressable handle',
    'no key — identity inherited from position',
  ];

  // ==========================================================================
  // SECTION 3 DATA: LIVE REORDER COMPARISON
  // ==========================================================================
  // We present two parallel rows. The "naive" row has plain children with no
  // explicit key. The "keyed" row wraps each child in a KeyedSubtree using a
  // stable ValueKey derived from the data, not the index.
  //
  // The script then reorders both lists from [A,B,C,D,E] to [C,A,E,B,D].
  // In a real running app, only the keyed row preserves per-cell counter
  // state through the move. We visualize the configurations side-by-side.

  final initialOrder = <String>['A', 'B', 'C', 'D', 'E'];
  final reorderedOrder = <String>['C', 'A', 'E', 'B', 'D'];

  final cellPalette = <String, Color>{
    'A': const Color(0xFFE53935),
    'B': const Color(0xFFFB8C00),
    'C': const Color(0xFFFDD835),
    'D': const Color(0xFF43A047),
    'E': const Color(0xFF1E88E5),
  };

  // Naive children: no explicit key. Reordering will rebind state by slot.
  Widget naiveCellFor(String id) {
    return _CounterCell(
      label: id,
      color: cellPalette[id] ?? const Color(0xFF9E9E9E),
    );
  }

  // Keyed children: ValueKey on the data, wrapped in KeyedSubtree.
  Widget keyedCellFor(String id) {
    return KeyedSubtree(
      key: ValueKey<String>('counter-$id'),
      child: _CounterCell(
        label: id,
        color: cellPalette[id] ?? const Color(0xFF9E9E9E),
      ),
    );
  }

  final naiveInitial = initialOrder.map(naiveCellFor).toList();
  final naiveReordered = reorderedOrder.map(naiveCellFor).toList();
  final keyedInitial = initialOrder.map(keyedCellFor).toList();
  final keyedReordered = reorderedOrder.map(keyedCellFor).toList();

  // Identity drift report — what happens conceptually after the reorder.
  final identityReport = <Map<String, String>>[
    {
      'slot': 'slot 0',
      'before': 'A',
      'after': 'C',
      'naive_state': 'State of slot 0 (was A) now displays C — DRIFT',
      'keyed_state': 'State follows C to slot 0 — preserved',
    },
    {
      'slot': 'slot 1',
      'before': 'B',
      'after': 'A',
      'naive_state': 'State of slot 1 (was B) now displays A — DRIFT',
      'keyed_state': 'State of A moves to slot 1 — preserved',
    },
    {
      'slot': 'slot 2',
      'before': 'C',
      'after': 'E',
      'naive_state': 'State of slot 2 (was C) now displays E — DRIFT',
      'keyed_state': 'State of E moves to slot 2 — preserved',
    },
    {
      'slot': 'slot 3',
      'before': 'D',
      'after': 'B',
      'naive_state': 'State of slot 3 (was D) now displays B — DRIFT',
      'keyed_state': 'State of B moves to slot 3 — preserved',
    },
    {
      'slot': 'slot 4',
      'before': 'E',
      'after': 'D',
      'naive_state': 'State of slot 4 (was E) now displays D — DRIFT',
      'keyed_state': 'State of D moves to slot 4 — preserved',
    },
  ];

  // ==========================================================================
  // SECTION 4 DATA: ensureUniqueKeysForList SHOWCASE
  // ==========================================================================
  // Build a mixed list: some children already have keys, some do not.
  // After running ensureUniqueKeysForList, every entry should be a
  // KeyedSubtree carrying a key.

  final inputList = <Widget>[
    Container(
      key: const ValueKey<String>('preset-1'),
      width: 60.0,
      height: 24.0,
      color: const Color(0xFF1976D2),
    ),
    Container(width: 60.0, height: 24.0, color: const Color(0xFF388E3C)),
    Container(
      key: const ValueKey<String>('preset-3'),
      width: 60.0,
      height: 24.0,
      color: const Color(0xFFE64A19),
    ),
    Container(width: 60.0, height: 24.0, color: const Color(0xFFFBC02D)),
    Container(width: 60.0, height: 24.0, color: const Color(0xFF7B1FA2)),
  ];

  final ensuredList = KeyedSubtree.ensureUniqueKeysForList(inputList);

  final ensuredReport = <Map<String, String>>[];
  for (var i = 0; i < ensuredList.length; i++) {
    final original = inputList[i];
    final wrapped = ensuredList[i];
    ensuredReport.add({
      'index': i.toString(),
      'original_had_key': (original.key != null).toString(),
      'wrapped_key': wrapped.key?.toString() ?? '<none>',
    });
  }

  // ==========================================================================
  // SECTION 5 DATA: KeyedSubtree.wrap SHOWCASE
  // ==========================================================================
  // wrap is the index-based factory used inside ensureUniqueKeysForList.
  // It only attaches a ValueKey<int> when the child has no key already.

  final wrapSamples = <Widget>[];
  for (var i = 0; i < 6; i++) {
    final sample = KeyedSubtree.wrap(
      Container(
        width: 50.0,
        height: 26.0,
        color: Color.fromARGB(0xFF, 0x42 + (i * 24) % 0xC0, 0x85, 0xF4),
      ),
      i,
    );
    wrapSamples.add(sample);
  }

  final wrapReport = <Map<String, String>>[];
  for (var i = 0; i < wrapSamples.length; i++) {
    final w = wrapSamples[i];
    wrapReport.add({
      'index': i.toString(),
      'key': w.key?.toString() ?? '<none>',
      'note': 'wrap attached ValueKey<int>($i)',
    });
  }

  // ==========================================================================
  // SECTION 6 DATA: AnimatedSwitcher INTEGRATION
  // ==========================================================================
  // AnimatedSwitcher cross-fades only when its child key differs from the
  // previous one. KeyedSubtree is the canonical way to provide that key
  // around an otherwise identical child shape.

  final switcherFrames = <Map<String, dynamic>>[
    {
      'tick': 0,
      'key': 'frame-0',
      'color': const Color(0xFF1E88E5),
      'label': 'state 0',
      'transition': 'initial mount',
    },
    {
      'tick': 1,
      'key': 'frame-1',
      'color': const Color(0xFF43A047),
      'label': 'state 1',
      'transition': 'cross-fade triggered',
    },
    {
      'tick': 2,
      'key': 'frame-2',
      'color': const Color(0xFFFB8C00),
      'label': 'state 2',
      'transition': 'cross-fade triggered',
    },
    {
      'tick': 3,
      'key': 'frame-2',
      'color': const Color(0xFFFB8C00),
      'label': 'state 2 (same key)',
      'transition': 'no transition (key unchanged)',
    },
    {
      'tick': 4,
      'key': 'frame-3',
      'color': const Color(0xFFE53935),
      'label': 'state 3',
      'transition': 'cross-fade triggered',
    },
  ];

  // ==========================================================================
  // SECTION 7 DATA: KEYEDSUBTREE vs GLOBALKEY COMPARISON
  // ==========================================================================

  final globalKeyComparison = <Map<String, String>>[
    {
      'criterion': 'Cost',
      'keyedsubtree': 'Cheap — local key only',
      'globalkey': 'Expensive — registry lookup, app-wide identifier',
    },
    {
      'criterion': 'Lookup',
      'keyedsubtree': 'No lookup API',
      'globalkey': 'currentState / currentContext / currentWidget',
    },
    {
      'criterion': 'Scope',
      'keyedsubtree': 'Sibling-level identity within a parent',
      'globalkey': 'Global across the entire app',
    },
    {
      'criterion': 'Reparenting',
      'keyedsubtree': 'Limited to siblings under same parent',
      'globalkey': 'Survives reparenting anywhere in the app',
    },
    {
      'criterion': 'Multiplicity',
      'keyedsubtree': 'Many subtrees may share a parent — keys distinguish',
      'globalkey': 'Each GlobalKey must be used at most once at a time',
    },
    {
      'criterion': 'Typical use',
      'keyedsubtree': 'Lists, AnimatedSwitcher, reorderable rows',
      'globalkey': 'Forms, dialogs, scaffolding, imperative access',
    },
  ];

  // ==========================================================================
  // SECTION 8 DATA: RECIPE CARDS
  // ==========================================================================

  final recipeCards = <Map<String, String>>[
    {
      'title': 'Recipe 1 — Stable identity for ListView children',
      'body':
          'When building a list from a model collection, wrap each child in '
          'KeyedSubtree(key: ValueKey(item.id), child: ItemTile(item)). '
          'Reordering or filtering the source list now preserves per-item '
          'state, controllers, and AnimatedList transitions.',
    },
    {
      'title': 'Recipe 2 — Force a subtree to rebuild fresh',
      'body':
          'Wrap a subtree in KeyedSubtree(key: UniqueKey(), child: subtree). '
          'Each rebuild gives a brand new key, so all internal State objects '
          'are disposed and rebuilt from scratch. Useful for "reset" buttons.',
    },
    {
      'title': 'Recipe 3 — Drive AnimatedSwitcher transitions',
      'body':
          'Place KeyedSubtree(key: ValueKey(currentStep), child: PageX()) '
          'inside AnimatedSwitcher. The switcher only animates when the key '
          'changes, so identical pages do not flicker.',
    },
    {
      'title': 'Recipe 4 — Build a tab body that survives swap',
      'body':
          'For each tab, return KeyedSubtree(key: PageStorageKey(tabId), '
          'child: tabContent). Scroll positions and PageStorage entries are '
          'preserved across tab swaps because identity is now stable.',
    },
    {
      'title': 'Recipe 5 — Use ensureUniqueKeysForList for mixed inputs',
      'body':
          'When you must build children whose origins vary (some have keys, '
          'some do not), pipe them through KeyedSubtree.ensureUniqueKeysForList '
          'before handing them to a SliverList or Column.',
    },
    {
      'title': 'Recipe 6 — Avoid sibling collisions',
      'body':
          'If two sibling widgets accidentally share a ValueKey, Flutter will '
          'throw at runtime. KeyedSubtree.ensureUniqueKeysForList handles this '
          'for the no-key case; for explicit keys, prefer ValueKey<UserId>(id).',
    },
    {
      'title': 'Recipe 7 — KeyedSubtree.wrap inside generators',
      'body':
          'When mapping `for (var i = 0; i < n; i++) KeyedSubtree.wrap(child, i)` '
          'inside a generator, you get index-based identity for free without '
          'allocating extra ValueKey instances at the call site.',
    },
    {
      'title': 'Recipe 8 — Preserve State during conditional layout',
      'body':
          'If you swap a child between Row(children: [child]) and Column('
          'children: [child]) based on screen size, both shapes wrap child in '
          'KeyedSubtree(key: ValueKey("the-child")). State survives the swap.',
    },
  ];

  // ==========================================================================
  // SECTION 9 DATA: COMPARISON TABLE
  // ==========================================================================

  final comparisonTable = <Map<String, String>>[
    {
      'aspect': 'Adds RenderObject',
      'keyedsubtree': 'No',
      'valuekey_on_child': 'No',
      'globalkey': 'No',
    },
    {
      'aspect': 'Provides explicit key',
      'keyedsubtree': 'Yes — on the subtree boundary',
      'valuekey_on_child': 'Yes — on the child itself',
      'globalkey': 'Yes — globally unique handle',
    },
    {
      'aspect': 'Works on any Widget',
      'keyedsubtree': 'Yes (wraps any child)',
      'valuekey_on_child': 'Only where child constructor exposes key',
      'globalkey': 'Yes (wraps any child)',
    },
    {
      'aspect': 'Allows currentState access',
      'keyedsubtree': 'No',
      'valuekey_on_child': 'No',
      'globalkey': 'Yes',
    },
    {
      'aspect': 'Equality semantics',
      'keyedsubtree': 'Inherits the key it wraps',
      'valuekey_on_child': 'By value',
      'globalkey': 'By identity (instance)',
    },
    {
      'aspect': 'Construction cost',
      'keyedsubtree': 'Tiny — single field',
      'valuekey_on_child': 'Tiny',
      'globalkey': 'Allocates registry entry',
    },
    {
      'aspect': 'Risk of duplicate',
      'keyedsubtree': 'Low — explicit per use',
      'valuekey_on_child': 'Low when value is unique',
      'globalkey': 'High — duplicates throw',
    },
  ];

  // ==========================================================================
  // SECTION 10 DATA: GLOSSARY
  // ==========================================================================

  final glossaryTerms = <Map<String, String>>[
    {
      'term': 'Element',
      'definition':
          'The instantiation of a Widget in the tree. Identity in Flutter is '
          'really element identity. Keys are how the framework matches new '
          'widgets to existing elements during rebuild.',
    },
    {
      'term': 'Reconciliation',
      'definition':
          'The process Flutter runs each frame to update the element tree '
          'from the new widget tree. Children are matched by runtimeType '
          'plus key in the same position.',
    },
    {
      'term': 'Slot',
      'definition':
          'The position a child occupies under its parent. Without keys, '
          'identity is inferred from slot position.',
    },
    {
      'term': 'Key',
      'definition':
          'An identifier that survives across rebuilds and is used during '
          'reconciliation to decide whether a new widget reuses the existing '
          'element and its State.',
    },
    {
      'term': 'State preservation',
      'definition':
          'Keeping a State<T> instance attached to the same logical entity '
          'across rebuilds, instead of letting it be disposed and recreated.',
    },
    {
      'term': 'Identity drift',
      'definition':
          'When state intended for one entity ends up attached to a different '
          'entity because reconciliation matched by slot rather than identity.',
    },
    {
      'term': 'ProxyWidget',
      'definition':
          'A widget that holds a single child and contributes no RenderObject. '
          'KeyedSubtree fits this category: it influences identity only.',
    },
    {
      'term': 'PageStorage',
      'definition':
          'A mechanism for saving and restoring small bits of UI state '
          '(scroll positions, tab indices) keyed by PageStorageKey, which '
          'pairs naturally with KeyedSubtree wrappers.',
    },
    {
      'term': 'AnimatedSwitcher',
      'definition':
          'A widget that animates between children when the child key '
          'changes. KeyedSubtree is the canonical key carrier.',
    },
  ];

  // ==========================================================================
  // BUILD COMPREHENSIVE UI
  // ==========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ============================================================
              // HEADER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF283593), Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KeyedSubtree',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Deep Demo: Identity, Keys, and Reconciliation',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFFC5CAE9),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        'constructor • wrap • ensureUniqueKeysForList',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ============================================================
              // SECTION 1: DOSSIER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF7986CB),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. Dossier — What KeyedSubtree Solves',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    for (final entry in dossierEntries)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: const Color(0xFFC5CAE9),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF303F9F),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                entry['description'] ?? '',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 2: ANATOMY
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF64B5F6),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. Anatomy — Members and Helpers',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    for (final row in anatomyRows)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1976D2),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  row['kind'] ?? '',
                                  style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      row['member'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'monospace',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      row['role'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 11.0,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Key types you might pass to KeyedSubtree:',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    for (final entry in keyTaxonomy)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFBBDEFB),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: Text(
                                  entry['type'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${entry['good_for']} (${entry['note']})',
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 3: LIVE REORDER DEMO
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF81C784),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3. Live Demo — Reorder With and Without KeyedSubtree',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Each cell maintains its own counter. Reorder is from '
                      '[A,B,C,D,E] to [C,A,E,B,D].',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Naive row, before reorder
                    const Text(
                      'Without KeyedSubtree — initial order [A,B,C,D,E]',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: naiveInitial,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Without KeyedSubtree — after reorder [C,A,E,B,D]',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: naiveReordered,
                    ),
                    const SizedBox(height: 16.0),

                    // Keyed row, before reorder
                    const Text(
                      'With KeyedSubtree — initial order [A,B,C,D,E]',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: keyedInitial,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'With KeyedSubtree — after reorder [C,A,E,B,D]',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: keyedReordered,
                    ),

                    const SizedBox(height: 16.0),

                    // Identity report table
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Identity Drift Report',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          for (final entry in identityReport)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 60.0,
                                        child: Text(
                                          entry['slot'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${entry['before']} → ${entry['after']}',
                                        style: const TextStyle(
                                          fontSize: 11.0,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2.0),
                                  Container(
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFCDD2),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      'naive: ${entry['naive_state']}',
                                      style: const TextStyle(fontSize: 10.0),
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Container(
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC8E6C9),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      'keyed: ${entry['keyed_state']}',
                                      style: const TextStyle(fontSize: 10.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 4: ensureUniqueKeysForList SHOWCASE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFFFB74D),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '4. ensureUniqueKeysForList Showcase',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Mixed-input list — some children already carry keys, '
                      'some do not. After the helper, every entry is keyed.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Original input row:',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: inputList,
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'After ensureUniqueKeysForList:',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ensuredList,
                    ),
                    const SizedBox(height: 12.0),
                    for (final report in ensuredReport)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE0B2),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30.0,
                                child: Text(
                                  '#${report['index']}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100.0,
                                child: Text(
                                  'had key: ${report['original_had_key']}',
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'now: ${report['wrapped_key']}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'monospace',
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

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 5: KeyedSubtree.wrap SHOWCASE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E5F5),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFBA68C8),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '5. KeyedSubtree.wrap — Index-Based Wrapping',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'wrap(child, i) attaches ValueKey<int>(i) when the '
                      'child has no key. Useful inside loops.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: wrapSamples,
                    ),
                    const SizedBox(height: 12.0),
                    for (final report in wrapReport)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1BEE7),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30.0,
                                child: Text(
                                  '#${report['index']}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 160.0,
                                child: Text(
                                  report['key'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  report['note'] ?? '',
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 6: AnimatedSwitcher INTEGRATION
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F7FA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF4DD0E1),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '6. AnimatedSwitcher — Key-Driven Transitions',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006064),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'AnimatedSwitcher fires its transition only when the '
                      'child key changes. KeyedSubtree is the key-carrying '
                      'wrapper around an otherwise identical inner shape.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    for (final frame in switcherFrames)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB2EBF2),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60.0,
                                child: Text(
                                  'tick ${frame['tick']}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 28.0,
                                height: 28.0,
                                decoration: BoxDecoration(
                                  color: frame['color'] as Color,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              SizedBox(
                                width: 110.0,
                                child: Text(
                                  'key: ${frame['key']}',
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  frame['transition'] as String,
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 7: KEYEDSUBTREE vs GLOBALKEY
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFFFD54F),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '7. KeyedSubtree vs GlobalKey',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF57F17),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'When to reach for KeyedSubtree, and when only a '
                      'GlobalKey will do.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    // Header row
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE082),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 100.0,
                            child: Text(
                              'Criterion',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'KeyedSubtree',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'GlobalKey',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    for (final row in globalKeyComparison)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: Text(
                                  row['criterion'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  row['keyedsubtree'] ?? '',
                                  style: const TextStyle(fontSize: 10.0),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  row['globalkey'] ?? '',
                                  style: const TextStyle(fontSize: 10.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 8: RECIPE CARDS
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE4EC),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFF06292),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '8. Recipe Cards',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFAD1457),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    for (final recipe in recipeCards)
                      _buildRecipeCard(
                        recipe['title'] ?? '',
                        recipe['body'] ?? '',
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 9: COMPARISON TABLE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF9575CD),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '9. Comparison — KeyedSubtree vs ValueKey-on-Child vs '
                      'GlobalKey',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4527A0),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1C4E9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 110.0,
                            child: Text(
                              'Aspect',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'KeyedSubtree',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'ValueKey on child',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'GlobalKey',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    for (final row in comparisonTable)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 110.0,
                                child: Text(
                                  row['aspect'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  row['keyedsubtree'] ?? '',
                                  style: const TextStyle(fontSize: 9.5),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  row['valuekey_on_child'] ?? '',
                                  style: const TextStyle(fontSize: 9.5),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  row['globalkey'] ?? '',
                                  style: const TextStyle(fontSize: 9.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 10: GLOSSARY
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF90A4AE),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '10. Glossary',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF263238),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    for (final entry in glossaryTerms)
                      _buildGlossaryRow(
                        entry['term'] ?? '',
                        entry['definition'] ?? '',
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SECTION 11: COMPOSED FINAL WIDGET TREE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF303F9F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '11. Final Composed Widget Tree',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'A reorderable identity demo bound by KeyedSubtree, '
                      'plus a strip of the basic constructor variants.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFFBBDEFB),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Basic Constructor Strip',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: basicSamples,
                          ),
                          const SizedBox(height: 8.0),
                          for (var i = 0; i < basicSamples.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Text(
                                '• ${basicSampleDescriptions[i]} → key=${basicSamples[i].key}',
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reorderable Identity Demo (centerpiece)',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Naive row (no key):',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: initialOrder.map(naiveCellFor).toList(),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Keyed row (KeyedSubtree per cell):',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: initialOrder.map(keyedCellFor).toList(),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Reordered (keyed row keeps cell state):',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: reorderedOrder.map(keyedCellFor).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ============================================================
              // SUMMARY
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00695C), Color(0xFF00897B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _buildSummaryItem('Dossier — purpose and use cases'),
                    _buildSummaryItem('Anatomy — constructor and helpers'),
                    _buildSummaryItem('Live reorder identity demo'),
                    _buildSummaryItem('ensureUniqueKeysForList showcase'),
                    _buildSummaryItem('KeyedSubtree.wrap showcase'),
                    _buildSummaryItem('AnimatedSwitcher integration'),
                    _buildSummaryItem('GlobalKey comparison'),
                    _buildSummaryItem('Recipe cards (8)'),
                    _buildSummaryItem('Three-way comparison table'),
                    _buildSummaryItem('Glossary of 9 core terms'),
                    _buildSummaryItem('Final composed widget tree'),
                    const SizedBox(height: 12.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'KeyedSubtree: ',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'All Sections Rendered',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // FOOTER
              const Center(
                child: Text(
                  'Deep Demo • KeyedSubtree • Flutter Widgets',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPERS
// ============================================================================

Widget _buildRecipeCard(String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFF8BBD0), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFAD1457),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            body,
            style: const TextStyle(fontSize: 11.0, height: 1.4),
          ),
        ],
      ),
    ),
  );
}

Widget _buildGlossaryRow(String term, String definition) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            term,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF37474F),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            definition,
            style: const TextStyle(fontSize: 11.0, height: 1.4),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSummaryItem(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text(
            'OK',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SUPPORTING WIDGETS
// ============================================================================

class _CellBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _CellBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CounterCell extends StatefulWidget {
  final String label;
  final Color color;
  const _CounterCell({required this.label, required this.color, super.key});

  @override
  State<_CounterCell> createState() => _CounterCellState();
}

class _CounterCellState extends State<_CounterCell> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _count++),
      child: Container(
        width: 50.0,
        height: 56.0,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              'n=$_count',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 10.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
