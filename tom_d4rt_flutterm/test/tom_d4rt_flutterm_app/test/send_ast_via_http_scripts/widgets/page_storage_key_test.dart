// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PageStorageKey<T> — Deep Demonstration
///
/// Palette: Slate / Steel (cool grays with blue undertones)
/// Primary:   Color(0xFF475569) — Slate 600
/// Secondary: Color(0xFF64748B) — Slate 500
/// Accent:    Color(0xFF94A3B8) — Slate 400
/// Surface:   Color(0xFFF1F5F9) — Slate 100
/// Deep:      Color(0xFF1E293B) — Slate 800
/// Muted:     Color(0xFFCBD5E1) — Slate 300
/// Warm:      Color(0xFF78909C) — Blue Grey 400
/// Highlight: Color(0xFF546E7A) — Blue Grey 600
/// Light:     Color(0xFFE2E8F0) — Slate 200
/// Dark:      Color(0xFF334155) — Slate 700

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PageStorageKey<T> — Complete Deep Dive              ██');
  print('██   Marker key for widget state persistence             ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const slate600 = Color(0xFF475569);
  const slate500 = Color(0xFF64748B);
  const slate400 = Color(0xFF94A3B8);
  const slate100 = Color(0xFFF1F5F9);
  const slate800 = Color(0xFF1E293B);
  const slate300 = Color(0xFFCBD5E1);
  const blueGrey400 = Color(0xFF78909C);
  const blueGrey600 = Color(0xFF546E7A);
  const slate200 = Color(0xFFE2E8F0);
  const slate700 = Color(0xFF334155);

  // ─── Section 2: What Is PageStorageKey? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PageStorageKey<T>?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PageStorageKey<T> is a specialized key type that tells');
  print('  the Flutter framework to persist and restore widget');
  print('  state through a storage bucket mechanism.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Purpose: Allow scrollable widgets to remember      │');
  print('  │  their scroll position across rebuilds and          │');
  print('  │  navigation transitions.                            │');
  print('  │                                                     │');
  print('  │  Mechanism: The framework builds a composite key    │');
  print('  │  path from all PageStorageKey ancestors in the      │');
  print('  │  widget tree, then stores/retrieves data in a      │');
  print('  │  PageStorageBucket keyed by that path.              │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');
  print('  When you give a ListView a PageStorageKey, its scroll');
  print('  position survives even if the widget is removed from');
  print('  the tree and later re-inserted (e.g. tab switching).');
  print('');

  // ─── Section 3: Inheritance Chain ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Inheritance Chain');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('             ┌───────────┐');
  print('             │    Key    │  Abstract base');
  print('             └─────┬─────┘');
  print('                   │');
  print('             ┌─────┴─────┐');
  print('             │ ValueKey  │  Compares by value');
  print('             │   <T>     │  using == operator');
  print('             └─────┬─────┘');
  print('                   │');
  print('       ┌───────────┴────────────┐');
  print('       │   PageStorageKey<T>    │  Marker subclass');
  print('       │                        │  (no new behavior)');
  print('       └────────────────────────┘');
  print('');
  print('  PageStorageKey extends ValueKey<T> — it adds no new');
  print('  fields or methods. It is purely a type marker.');
  print('');
  print('  The framework checks `key is PageStorageKey` to decide');
  print('  whether to include a widget\'s key in the storage path.');
  print('');

  // Demonstrate the inheritance at runtime
  const stringKey = PageStorageKey<String>('myList');
  const intKey = PageStorageKey<int>(42);
  const nullableKey = PageStorageKey<String?>('optional');

  print('  Runtime verification:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  stringKey.value             = ${stringKey.value}');
  print('  │  stringKey is ValueKey       = true');
  print('  │  stringKey is PageStorageKey = true');
  print('  │  intKey.value                = ${intKey.value}');
  print('  │  nullableKey.value           = ${nullableKey.value}');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: Constructor and Type Parameter ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Constructor & Type Parameter');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The constructor signature:');
  print('');
  print('    const PageStorageKey(T value)');
  print('');
  print('  Since it extends ValueKey<T>, the generic type T');
  print('  determines how equality comparisons work.');
  print('');

  // Type parameter variations
  const keyA = PageStorageKey<String>('scrollList');
  const keyB = PageStorageKey<String>('scrollList');
  const keyC = PageStorageKey<String>('otherList');
  const keyInt = PageStorageKey<int>(1);
  const keyEnum = PageStorageKey<Axis>(Axis.vertical);

  print('  Type parameter examples:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  String:  PageStorageKey("scrollList")           │');
  print('  │  int:     PageStorageKey(1)                      │');
  print('  │  Enum:    PageStorageKey(Axis.vertical)          │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Equality semantics (from ValueKey):');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  keyA == keyB              = ${keyA == keyB}');
  print('  │  keyA == keyC              = ${keyA == keyC}');
  print('  │  keyA == keyInt            = ${keyA == keyInt}');
  print('  │  keyEnum.value             = ${keyEnum.value}');
  print('  │  keyA.hashCode == keyB.hashCode = ${keyA.hashCode == keyB.hashCode}');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Note: Two PageStorageKeys with the same value AND');
  print('  same type parameter are equal, even if created');
  print('  separately. This is the ValueKey contract.');
  print('');

  // ─── Section 5: PageStorage Bucket System ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: PageStorage Bucket System');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The persistence mechanism has three cooperating pieces:');
  print('');
  print('  ┌──────────────────┐');
  print('  │  PageStorageKey   │  Marker on a widget');
  print('  └────────┬─────────┘');
  print('           │ collected by');
  print('  ┌────────┴─────────┐');
  print('  │  PageStorage      │  InheritedWidget that provides');
  print('  │  (widget)         │  a PageStorageBucket');
  print('  └────────┬─────────┘');
  print('           │ delegates to');
  print('  ┌────────┴────────────────────┐');
  print('  │  PageStorageBucket           │  Actual key-value store');
  print('  │  (Map<Object, dynamic>)      │');
  print('  └──────────────────────────────┘');
  print('');
  print('  How it works:');
  print('  1. A scrollable widget checks if it has a');
  print('     PageStorageKey in its key property.');
  print('  2. If yes, it looks up the tree for a PageStorage');
  print('     ancestor (provided by the Navigator, or by');
  print('     Scaffold, or manually inserted).');
  print('  3. The PageStorage walks down from itself to the');
  print('     requesting widget, collecting all intermediate');
  print('     PageStorageKeys to form a composite path.');
  print('  4. This composite list of keys becomes the storage');
  print('     identifier in the PageStorageBucket map.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Storage Path Example:                              │');
  print('  │                                                     │');
  print('  │  Navigator (PageStorage with bucket)                │');
  print('  │    └─ Scaffold                                      │');
  print('  │        └─ TabBarView                                │');
  print('  │            └─ Tab key=PSK("tab_0")                  │');
  print('  │                └─ ListView key=PSK("myList")        │');
  print('  │                                                     │');
  print('  │  Stored as: ["tab_0", "myList"] → scroll offset     │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: Composite Key Path Building ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Composite Key Path Building');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PageStorage.of(context) walks ancestors to find the');
  print('  nearest PageStorageBucket. Then readState/writeState');
  print('  build a list of PageStorageKeys between the bucket');
  print('  owner and the requesting widget.');
  print('');
  print('  Key path construction:');
  print('');
  print('  ┌────────────────────────────────────────────────────┐');
  print('  │  Widget Tree (simplified):                         │');
  print('  │                                                    │');
  print('  │  PageStorage ← bucket lives here                   │');
  print('  │    │                                               │');
  print('  │    ├── Widget (no PSK) ← ignored                   │');
  print('  │    │                                               │');
  print('  │    ├── Widget key=PSK("section_A") ← included      │');
  print('  │    │    │                                          │');
  print('  │    │    └── Widget (no PSK) ← ignored              │');
  print('  │    │         │                                     │');
  print('  │    │         └── ListView key=PSK("list_1")        │');
  print('  │    │                        ↑ requesting context   │');
  print('  │    │                                               │');
  print('  │  Key path = ["section_A", "list_1"]                │');
  print('  └────────────────────────────────────────────────────┘');
  print('');
  print('  Only ancestors with PageStorageKey contribute to the');
  print('  composite path. Regular keys, ValueKeys without the');
  print('  PageStorageKey subtype, and GlobalKeys are ignored.');
  print('');
  print('  This means you can nest PageStorageKeys to create');
  print('  unique scoped storage addresses:');
  print('');
  print('  Tab 0, List A → ["tab_0", "listA"] → offset 523.4');
  print('  Tab 0, List B → ["tab_0", "listB"] → offset 0.0');
  print('  Tab 1, List A → ["tab_1", "listA"] → offset 1200.7');
  print('');

  // ─── Section 7: What Gets Stored by Default ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: What Gets Stored by Default');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Several built-in widgets automatically use');
  print('  PageStorage when they detect a PageStorageKey:');
  print('');
  print('  ┌────────────────────┬──────────────────────────────┐');
  print('  │  Widget            │  What Is Stored              │');
  print('  ├────────────────────┼──────────────────────────────┤');
  print('  │  ListView          │  Scroll offset (pixels)      │');
  print('  │  GridView          │  Scroll offset (pixels)      │');
  print('  │  SingleChildScroll │  Scroll offset (pixels)      │');
  print('  │  PageView          │  Current page (double)       │');
  print('  │  TabBarView        │  (uses implicit PSKs)        │');
  print('  │  ExpansionTile     │  Expanded state (bool)       │');
  print('  │  NestedScrollView  │  Inner/outer offsets         │');
  print('  └────────────────────┴──────────────────────────────┘');
  print('');
  print('  The storage read/write calls happen in the scroll');
  print('  controller\'s saveScrollOffset / restoreScrollOffset');
  print('  methods. This is automatic when a PSK is present.');
  print('');
  print('  Without a PageStorageKey:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • ScrollController creates fresh position       │');
  print('  │  • Scroll offset starts at initialScrollOffset   │');
  print('  │  • State lost when widget leaves tree             │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  With a PageStorageKey:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • ScrollController checks bucket on attach      │');
  print('  │  • Restores previous offset if found             │');
  print('  │  • Saves offset on every scroll notification     │');
  print('  │  • Survives widget removal and re-insertion      │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Automatic PSK Assignment ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Automatic PageStorageKey Assignment');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Some framework widgets automatically assign');
  print('  PageStorageKeys to their children:');
  print('');
  print('  ┌────────────────────────────────────────────────────┐');
  print('  │  TabBarView:                                       │');
  print('  │    Each tab child gets PSK<int>(tabIndex)          │');
  print('  │    This is why tab scroll positions persist        │');
  print('  │    without you adding keys manually.               │');
  print('  │                                                    │');
  print('  │  BottomNavigationBar + IndexedStack:               │');
  print('  │    Navigator wrapping each route page provides     │');
  print('  │    its own PageStorage automatically.              │');
  print('  │                                                    │');
  print('  │  SliverList / SliverGrid:                          │');
  print('  │    The sliver delegates may assign PSKs when       │');
  print('  │    keepAlive is enabled via                        │');
  print('  │    AutomaticKeepAliveClientMixin.                  │');
  print('  └────────────────────────────────────────────────────┘');
  print('');
  print('  TabBarView source excerpt (conceptual):');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  children[i] = KeyedSubtree(                     │');
  print('  │    key: PageStorageKey<int>(i),                   │');
  print('  │    child: widget.children[i],                     │');
  print('  │  );                                               │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Manual Usage Pattern ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Manual Usage Patterns');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Pattern 1: Named list in fixed layout');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  ListView(                                        │');
  print('  │    key: const PageStorageKey<String>("inbox"),     │');
  print('  │    children: [...],                               │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  Result: scroll position saved under ["inbox"]    │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pattern 2: Index-based in a builder');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  for (int i = 0; i < 3; i++)                      │');
  print('  │    ListView.builder(                              │');
  print('  │      key: PageStorageKey<int>(i),                 │');
  print('  │      itemBuilder: (context, index) => ...,        │');
  print('  │    )                                              │');
  print('  │                                                   │');
  print('  │  Result: each list has independent storage        │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pattern 3: Enum-based for categorical content');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  enum Section { news, trending, favorites }       │');
  print('  │                                                   │');
  print('  │  ListView(                                        │');
  print('  │    key: PageStorageKey<Section>(Section.news),     │');
  print('  │    ...                                            │');
  print('  │  )                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pattern 4: Nested scoping (multiple levels)');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Container(                                       │');
  print('  │    key: const PageStorageKey("section_A"),         │');
  print('  │    child: Column(children: [                      │');
  print('  │      ListView(                                    │');
  print('  │        key: const PageStorageKey("list"),          │');
  print('  │        ...                                        │');
  print('  │      ),                                           │');
  print('  │    ]),                                            │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  Storage path: ["section_A", "list"]              │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Key Comparison Matrix ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Key Comparison Matrix');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌─────────────────┬────────────┬────────────┬────────────┬──────────────┐');
  print('  │  Feature         │ ValueKey   │ PSK        │ ObjectKey  │ GlobalKey    │');
  print('  ├─────────────────┼────────────┼────────────┼────────────┼──────────────┤');
  print('  │  Equality        │ by value   │ by value   │ by ident.  │ by identity  │');
  print('  │  Const-able      │ yes        │ yes        │ no*        │ no           │');
  print('  │  State persist   │ no         │ YES        │ no         │ state ref    │');
  print('  │  Tree-unique     │ same level │ same level │ same level │ globally     │');
  print('  │  Common use      │ diff lists │ scroll pos │ non-const  │ access state │');
  print('  │  Performance     │ no cost    │ no cost    │ no cost    │ registry     │');
  print('  └─────────────────┴────────────┴────────────┴────────────┴──────────────┘');
  print('');
  print('  * ObjectKey can be const if the identity object is const');
  print('');
  print('  Key insight: PageStorageKey\'s only behavioral');
  print('  difference from ValueKey is the TYPE CHECK that');
  print('  PageStorage performs. There is zero runtime cost.');
  print('');

  // ─── Section 11: Identity and Collision ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Identity and Key Collision');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Since PageStorageKey uses ValueKey equality, two');
  print('  widgets at the same tree level with the same PSK');
  print('  value will collide:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Column(children: [                               │');
  print('  │    ListView(key: PageStorageKey("list")),   ─┐    │');
  print('  │    ListView(key: PageStorageKey("list")),   ─┘    │');
  print('  │  ])       ↑ COLLISION: same key, same level       │');
  print('  │                                                   │');
  print('  │  Framework will throw a duplicate key error.      │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  For storage, collisions at different tree levels');
  print('  are fine because the composite path differs:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Tab 0 (PSK(0)):                                  │');
  print('  │    └─ ListView(key: PSK("list"))                  │');
  print('  │       Storage: [0, "list"]                        │');
  print('  │                                                   │');
  print('  │  Tab 1 (PSK(1)):                                  │');
  print('  │    └─ ListView(key: PSK("list"))                  │');
  print('  │       Storage: [1, "list"]                        │');
  print('  │                                                   │');
  print('  │  ✓ No collision — different composite paths       │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // Runtime collision demonstration
  print('  Runtime identity verification:');
  const dup1 = PageStorageKey<String>('shared');
  const dup2 = PageStorageKey<String>('shared');
  const unique1 = PageStorageKey<String>('unique_a');

  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  PSK("shared") == PSK("shared") = ${dup1 == dup2}');
  print('  │  PSK("shared") == PSK("unique") = ${dup1 == unique1}');
  print('  │  identical(const,const)          = ${identical(dup1, dup2)}');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Lifetime and Bucket Scope ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Lifetime & Bucket Scope');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The PageStorageBucket lives as long as the');
  print('  PageStorage widget that owns it:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Scope Hierarchy:                                 │');
  print('  │                                                   │');
  print('  │  MaterialApp                                      │');
  print('  │    └─ Navigator                                   │');
  print('  │        └─ Route (each has its own PageStorage)    │');
  print('  │            └─ Widgets with PSKs                   │');
  print('  │                                                   │');
  print('  │  When you push a new route:                       │');
  print('  │  • Old route\'s PageStorage stays alive (behind)  │');
  print('  │  • New route gets fresh PageStorage               │');
  print('  │                                                   │');
  print('  │  When you pop:                                    │');
  print('  │  • Popped route\'s PageStorage is disposed        │');
  print('  │  • Its bucket and all stored data is GC\'d        │');
  print('  │  • Returned-to route still has its data           │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Implication: PSK-based storage is per-route, not');
  print('  global. If you need cross-route persistence, use');
  print('  a state management solution instead.');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Route A → push Route B → pop to Route A         │');
  print('  │                                                   │');
  print('  │  Route A scroll offset: ✓ preserved               │');
  print('  │  Route B scroll offset: ✗ gone after pop          │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 13: Explicit Read/Write API ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Explicit Read/Write API');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  You can manually read and write to a PageStorage');
  print('  bucket for custom state persistence:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Writing custom data:                             │');
  print('  │                                                   │');
  print('  │  PageStorage.of(context).writeState(              │');
  print('  │    context,                                       │');
  print('  │    myCustomValue,                                 │');
  print('  │  );                                               │');
  print('  │                                                   │');
  print('  │  Reading custom data:                             │');
  print('  │                                                   │');
  print('  │  final value = PageStorage.of(context)            │');
  print('  │      .readState(context);                         │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  The writeState/readState methods use the context');
  print('  to build the composite key path automatically.');
  print('  The widget calling these MUST have a PageStorageKey.');
  print('');
  print('  You can also use the bucket directly:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  final bucket = PageStorage.of(context);          │');
  print('  │                                                   │');
  print('  │  // Write with explicit identifier                │');
  print('  │  bucket.writeState(context, {"expanded": true});  │');
  print('  │                                                   │');
  print('  │  // Read returns dynamic (cast needed)            │');
  print('  │  final state = bucket.readState(context)          │');
  print('  │      as Map<String, bool>?;                       │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Common Pitfalls ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Common Pitfalls');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Pitfall 1: PSK on the wrong widget');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  ✗ Wrong — PSK on the container, not the list:   │');
  print('  │                                                   │');
  print('  │  Container(                                       │');
  print('  │    key: PageStorageKey("myList"),                  │');
  print('  │    child: ListView(...)  // no key → no storage   │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  ✓ Correct — PSK on the scrollable:              │');
  print('  │                                                   │');
  print('  │  ListView(                                        │');
  print('  │    key: PageStorageKey("myList"),                  │');
  print('  │    ...                                            │');
  print('  │  )                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pitfall 2: Dynamic key values');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  ✗ Avoid — value changes every rebuild:          │');
  print('  │                                                   │');
  print('  │  PageStorageKey(DateTime.now().toString())         │');
  print('  │                                                   │');
  print('  │  ✓ Use stable identifiers:                       │');
  print('  │                                                   │');
  print('  │  PageStorageKey(item.id)                          │');
  print('  │  const PageStorageKey("settings_list")            │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pitfall 3: Using PSK with explicit controller');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  When you provide a ScrollController with a      │');
  print('  │  non-zero initialScrollOffset, it may conflict   │');
  print('  │  with the bucket\'s stored value.                │');
  print('  │                                                   │');
  print('  │  The restored value from PageStorage takes        │');
  print('  │  precedence over initialScrollOffset.             │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pitfall 4: No PageStorage ancestor');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Without a PageStorage ancestor in the tree,      │');
  print('  │  the PSK has no effect — there is no bucket to   │');
  print('  │  store data in. MaterialApp / Navigator provides  │');
  print('  │  one by default, so this is rarely an issue.      │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 15: Performance and Memory ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Performance & Memory');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Cost analysis:');
  print('');
  print('  ┌────────────────────┬──────────────────────────────┐');
  print('  │  Aspect            │  Impact                      │');
  print('  ├────────────────────┼──────────────────────────────┤');
  print('  │  Key allocation    │  Zero (const constructor)    │');
  print('  │  Equality check    │  O(1) — ValueKey.==          │');
  print('  │  Path building     │  O(depth) — tree walk        │');
  print('  │  Storage write     │  O(1) — map insertion        │');
  print('  │  Storage read      │  O(depth) — path build + O(1)│');
  print('  │  Memory per entry  │  ~one map entry per widget   │');
  print('  │  Bucket cleanup    │  Automatic on widget dispose │');
  print('  └────────────────────┴──────────────────────────────┘');
  print('');
  print('  The overhead is negligible for normal usage. Even');
  print('  with hundreds of stored scroll positions, the total');
  print('  memory is minimal (just double values in a map).');
  print('');
  print('  The tree walk to build the composite key path runs');
  print('  only during save/restore, not on every frame.');
  print('');

  // ─── Section 16: PSK vs GlobalKey for State ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 16: PSK vs GlobalKey for State Preservation');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Both can preserve state, but through different');
  print('  mechanisms:');
  print('');
  print('  PageStorageKey:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Stores specific values (scroll offset)        │');
  print('  │  • Widget can be fully disposed and recreated     │');
  print('  │  • Data persists in bucket as long as bucket lives│');
  print('  │  • Lightweight — no global registry               │');
  print('  │  • Const-constructible                            │');
  print('  │  • Only preserves what widgets explicitly save    │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  GlobalKey:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Preserves the entire State object              │');
  print('  │  • Widget element is reparented, not recreated    │');
  print('  │  • All state fields survive (not just scroll)     │');
  print('  │  • Expensive — global registry + uniqueness check │');
  print('  │  • Cannot be const                                │');
  print('  │  • Must be truly unique across entire tree        │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Decision guide:');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Need to preserve scroll position only?  → PSK     │');
  print('  │  Need to preserve full widget state?     → GK      │');
  print('  │  Widget moves between parents?           → GK      │');
  print('  │  Just tab switching scroll memory?       → PSK     │');
  print('  │  Need to access state from elsewhere?    → GK      │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 17: Live Interactive Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 17: Live Interactive Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Build a tabbed interface where each tab has a scrollable
  // list with PageStorageKey, demonstrating persistence
  final storageWidget = DefaultTabController(
    length: 3,
    child: Scaffold(
      backgroundColor: slate100,
      appBar: AppBar(
        title: const Text(
          'PageStorageKey Demo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        backgroundColor: slate800,
        bottom: TabBar(
          indicatorColor: slate300,
          labelColor: Colors.white,
          unselectedLabelColor: slate400,
          tabs: const [
            Tab(icon: Icon(Icons.inbox), text: 'Inbox'),
            Tab(icon: Icon(Icons.star), text: 'Starred'),
            Tab(icon: Icon(Icons.archive), text: 'Archive'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 0: ListView with PageStorageKey
          ListView.builder(
            key: const PageStorageKey<String>('inbox_list'),
            itemCount: 50,
            itemBuilder: (context, index) {
              final shade = slate500.withValues(
                alpha: 0.1 + (index % 5) * 0.15,
              );
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: slate300.withValues(alpha: 0.5),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: shade,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  title: Text(
                    'Inbox Item ${index + 1}',
                    style: TextStyle(
                      color: slate700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Scroll position persists via PSK("inbox_list")',
                    style: TextStyle(
                      color: slate400,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: slate400,
                  ),
                ),
              );
            },
          ),

          // Tab 1: GridView with PageStorageKey
          GridView.builder(
            key: const PageStorageKey<String>('starred_grid'),
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 60,
            itemBuilder: (context, index) {
              final hue = (index * 12.0) % 360;
              final color = HSVColor.fromAHSV(1.0, hue, 0.15, 0.95).toColor();
              return Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: blueGrey400.withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: blueGrey600,
                        size: 20,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '★ ${index + 1}',
                        style: TextStyle(
                          color: slate700,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Tab 2: Nested lists with scoped PSKs
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                color: slate200,
                child: Row(
                  children: [
                    Icon(Icons.archive, color: slate600, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Two independent scrollable sections',
                      style: TextStyle(
                        color: slate600,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  key: const PageStorageKey<String>('archive_top'),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: slate200.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Archive top #${index + 1}  (PSK: "archive_top")',
                        style: TextStyle(
                          color: slate600,
                          fontSize: 13,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 1,
                color: slate300,
              ),
              Expanded(
                child: ListView.builder(
                  key: const PageStorageKey<String>('archive_bottom'),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: blueGrey400.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Archive bottom #${index + 1}  (PSK: "archive_bottom")',
                        style: TextStyle(
                          color: blueGrey600,
                          fontSize: 13,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: 3-tab layout');
  print('  • Tab Inbox:   ListView with PSK("inbox_list")');
  print('  • Tab Starred:  GridView with PSK("starred_grid")');
  print('  • Tab Archive: Two ListViews with separate PSKs');
  print('');
  print('  Each tab remembers its scroll position when you');
  print('  switch away and come back. The framework handles');
  print('  all persistence automatically via TabBarView\'s');
  print('  implicit PageStorageKey<int> assignments.');
  print('');

  // ─── Section 18: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 18: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PageStorageKey<T> is a pure type-marker subclass of');
  print('  ValueKey<T>. It adds no behavior — its power comes');
  print('  from the `is PageStorageKey` type check that the');
  print('  framework\'s PageStorage system uses to decide which');
  print('  widgets participate in state persistence.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                     │');
  print('  │                                                     │');
  print('  │  1. Extends ValueKey — equality by value            │');
  print('  │  2. Type marker — no new fields or methods          │');
  print('  │  3. Composite paths via ancestor chain              │');
  print('  │  4. Automatic for scrollables (save/restore)        │');
  print('  │  5. TabBarView assigns PSK<int> automatically       │');
  print('  │  6. Per-route scope — dies when route pops          │');
  print('  │  7. Zero runtime overhead (const, no registry)      │');
  print('  │  8. Use for scroll persistence, not full state      │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Slate 800  ${slate800.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep backgrounds');
  print('  │  Slate 700  ${slate700.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary text');
  print('  │  Slate 600  ${slate600.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary text');
  print('  │  Slate 500  ${slate500.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted elements');
  print('  │  Slate 400  ${slate400.toARGB32().toRadixString(16).padLeft(8, "0")}  Subtle accents');
  print('  │  Slate 300  ${slate300.toARGB32().toRadixString(16).padLeft(8, "0")}  Borders');
  print('  │  Slate 200  ${slate200.toARGB32().toRadixString(16).padLeft(8, "0")}  Light surfaces');
  print('  │  Slate 100  ${slate100.toARGB32().toRadixString(16).padLeft(8, "0")}  Backgrounds');
  print('  │  BlueGrey4  ${blueGrey400.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm accents');
  print('  │  BlueGrey6  ${blueGrey600.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PageStorageKey<T> — Demonstration Complete            ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return storageWidget;
}
