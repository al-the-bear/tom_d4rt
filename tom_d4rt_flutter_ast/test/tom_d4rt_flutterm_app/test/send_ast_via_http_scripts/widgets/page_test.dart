// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Page<T> — Deep Demonstration
///
/// Palette: Copper / Bronze (warm metallic tones)
/// Primary:   Color(0xFFB87333) — Copper
/// Secondary: Color(0xFFCD7F32) — Bronze
/// Accent:    Color(0xFFD4A574) — Camel
/// Surface:   Color(0xFFFDF6EC) — Warm Cream
/// Deep:      Color(0xFF5C3317) — Dark Bronze
/// Muted:     Color(0xFFDEB887) — Burlywood
/// Warm:      Color(0xFFA0522D) — Sienna
/// Highlight: Color(0xFFE8C39E) — Light Copper
/// Light:     Color(0xFFFAEBD7) — Antique White
/// Dark:      Color(0xFF8B4513) — Saddle Brown

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   Page<T> — Complete Deep Dive                        ██');
  print('██   Abstract base for Navigator 2.0 declarative pages  ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const copper = Color(0xFFB87333);
  const bronze = Color(0xFFCD7F32);
  const camel = Color(0xFFD4A574);
  const warmCream = Color(0xFFFDF6EC);
  const darkBronze = Color(0xFF5C3317);
  const burlywood = Color(0xFFDEB887);
  const sienna = Color(0xFFA0522D);
  const lightCopper = Color(0xFFE8C39E);
  const antiqueWhite = Color(0xFFFAEBD7);
  const saddleBrown = Color(0xFF8B4513);

  // ─── Section 2: What Is Page<T>? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is Page<T>?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Page<T> is the abstract base class for declarative');
  print('  routing in Flutter\'s Navigator 2.0 API. It represents');
  print('  a configuration that describes a route and can produce');
  print('  an actual Route<T> via its createRoute() factory.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Purpose: Separate route CONFIGURATION from route   │');
  print('  │  INSTANTIATION. A Page describes "what" to show,    │');
  print('  │  while the Route handles "how" to show it.          │');
  print('  │                                                     │');
  print('  │  Think of Page as a declarative "recipe" and Route  │');
  print('  │  as the running "instance" that follows the recipe. │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');
  print('  The Navigator maintains a list of Pages. When you');
  print('  update that list, Navigator diffs old vs new pages');
  print('  to determine which routes to create, update, or');
  print('  remove — just like how the widget tree diffs widgets.');
  print('');

  // ─── Section 3: Inheritance Chain ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Inheritance Chain');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('             ┌────────────────┐');
  print('             │ RouteSettings  │  name + arguments');
  print('             └───────┬────────┘');
  print('                     │');
  print('              ┌──────┴──────┐');
  print('              │   Page<T>   │  + key, canPop,');
  print('              │  (abstract) │    onPopInvoked,');
  print('              │             │    restorationId,');
  print('              │             │    createRoute()');
  print('              └──────┬──────┘');
  print('                     │');
  print('          ┌──────────┼──────────┐');
  print('          │          │          │');
  print('   ┌──────┴─────┐ ┌─┴──────┐ ┌─┴───────────┐');
  print('   │ Material   │ │Cuper-  │ │ Custom      │');
  print('   │ Page<T>    │ │tinoPage│ │ Page<T>     │');
  print('   └────────────┘ └────────┘ └─────────────┘');
  print('');
  print('  Page<T> extends RouteSettings — so it inherits the');
  print('  standard name and arguments properties that Routes');
  print('  use for identification and data passing.');
  print('');
  print('  The type parameter T represents the return type of');
  print('  the route (what Navigator.pop(context, result)');
  print('  returns to the previous page).');
  print('');

  // ─── Section 4: Constructor Parameters ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Constructor Parameters');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  const Page({');
  print('    LocalKey?  key,            // identity for diffing');
  print('    String?    name,           // route name (from RouteSettings)');
  print('    Object?    arguments,      // route arguments');
  print('    String?    restorationId,  // state restoration');
  print('    bool       canPop = true,  // pop interception');
  print('    PopInvokedWithResultCallback<T>? onPopInvoked,');
  print('  })');
  print('');
  print('  Parameter details:');
  print('  ┌────────────────┬──────────────────────────────────┐');
  print('  │  key           │ LocalKey used by Navigator to    │');
  print('  │                │ match old and new pages during   │');
  print('  │                │ list diffing. Critical for       │');
  print('  │                │ canUpdate() comparisons.         │');
  print('  ├────────────────┼──────────────────────────────────┤');
  print('  │  name          │ Optional route name, used by     │');
  print('  │                │ Navigator.pushNamed and route    │');
  print('  │                │ observers.                       │');
  print('  ├────────────────┼──────────────────────────────────┤');
  print('  │  arguments     │ Arbitrary data passed through    │');
  print('  │                │ the route. Accessible via        │');
  print('  │                │ ModalRoute.of(context).settings. │');
  print('  ├────────────────┼──────────────────────────────────┤');
  print('  │  restorationId │ Unique id for state restoration. │');
  print('  │                │ Framework can recreate route     │');
  print('  │                │ after process death.             │');
  print('  ├────────────────┼──────────────────────────────────┤');
  print('  │  canPop        │ If false, system back gesture    │');
  print('  │                │ is intercepted. Default: true.   │');
  print('  ├────────────────┼──────────────────────────────────┤');
  print('  │  onPopInvoked  │ Callback when pop is attempted.  │');
  print('  │                │ Receives didPop bool and result. │');
  print('  └────────────────┴──────────────────────────────────┘');
  print('');

  // ─── Section 5: The canUpdate() Method ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: The canUpdate() Method');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  canUpdate() is the key diffing mechanism. It determines');
  print('  whether an existing route can be updated with new page');
  print('  configuration, or must be replaced entirely.');
  print('');
  print('  Source implementation:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  bool canUpdate(Page<dynamic> other) {           │');
  print('  │    return other.runtimeType == runtimeType        │');
  print('  │        && other.key == key;                       │');
  print('  │  }                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Two conditions must BOTH be true:');
  print('  1. Same runtimeType (not just "Page" but exact class)');
  print('  2. Same key value (using Key.== equality)');
  print('');
  print('  When canUpdate returns true:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • The existing Route is kept alive               │');
  print('  │  • Its settings are updated to the new Page       │');
  print('  │  • No transition animation plays                  │');
  print('  │  • State is preserved (form inputs, scroll, etc.) │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  When canUpdate returns false:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Old Route is removed (animated out)            │');
  print('  │  • New Route is created from the new Page         │');
  print('  │  • Full transition animation plays                │');
  print('  │  • All state is lost                              │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // Demonstrate canUpdate logic
  final pageA = MaterialPage<void>(
    key: const ValueKey('home'),
    child: const Text('Home'),
  );
  final pageB = MaterialPage<void>(
    key: const ValueKey('home'),
    child: const Text('Home Updated'),
  );
  final pageC = MaterialPage<void>(
    key: const ValueKey('settings'),
    child: const Text('Settings'),
  );

  print('  canUpdate examples:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  pageA(key=home) canUpdate pageB(key=home)       │');
  print('  │    = ${pageA.canUpdate(pageB)} (same type, same key)');
  print('  │                                                   │');
  print('  │  pageA(key=home) canUpdate pageC(key=settings)   │');
  print('  │    = ${pageA.canUpdate(pageC)} (same type, different key)');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: createRoute() — The Factory Method ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: createRoute() — The Factory Method');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  createRoute() is the single abstract method that');
  print('  subclasses must implement. It\'s called by Navigator');
  print('  when a new page needs to become a live route.');
  print('');
  print('  Signature:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Route<T> createRoute(BuildContext context);      │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Subclass implementations:');
  print('');
  print('  MaterialPage.createRoute():');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Returns a _PageBasedMaterialPageRoute that      │');
  print('  │  uses MaterialPageRoute-style transitions        │');
  print('  │  (slide from right on iOS, fade on Android).     │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  CupertinoPage.createRoute():');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Returns a _PageBasedCupertinoPageRoute with     │');
  print('  │  iOS-native slide transition and back gesture.   │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Custom Page.createRoute():');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  You can return any Route<T> subclass:           │');
  print('  │  • PageRouteBuilder for custom transitions       │');
  print('  │  • DialogRoute for dialog-style pages            │');
  print('  │  • ModalBottomSheetRoute for sheets              │');
  print('  │  • Your own Route subclass                       │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Navigator 2.0 Page Diffing Algorithm ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Navigator 2.0 Page Diffing Algorithm');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  When Navigator.pages is updated, the framework runs');
  print('  a diffing algorithm to reconcile old and new lists:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Step 1: Walk both lists simultaneously          │');
  print('  │                                                   │');
  print('  │  Old:  [A, B, C]                                  │');
  print('  │  New:  [A, B, D]                                  │');
  print('  │         ↑  ↑  ↑                                   │');
  print('  │  Step 2: For each position, call canUpdate()     │');
  print('  │                                                   │');
  print('  │  A.canUpdate(A) → true  → update route           │');
  print('  │  B.canUpdate(B) → true  → update route           │');
  print('  │  C.canUpdate(D) → false → remove C, create D     │');
  print('  │                                                   │');
  print('  │  Step 3: Handle remaining pages                  │');
  print('  │  • Extra old pages → remove routes               │');
  print('  │  • Extra new pages → create routes               │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  This is analogous to how Element.updateChild works');
  print('  for widgets, but at the route level.');
  print('');
  print('  Key implications:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Page order matters — it maps directly to the  │');
  print('  │    navigation stack (bottom to top)              │');
  print('  │  • Same key = update, different key = replace    │');
  print('  │  • No key = always create new (no matching)      │');
  print('  │  • Reordering pages reorders the route stack     │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: canPop and Pop Interception ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: canPop & Pop Interception');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The canPop property controls whether the system back');
  print('  gesture (Android back button, iOS swipe) can pop the');
  print('  route created by this page.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  canPop = true (default):                           │');
  print('  │  ┌──────────────────────────────────────────────┐   │');
  print('  │  │  System back gesture → pop succeeds          │   │');
  print('  │  │  Navigator.pop()    → pop succeeds           │   │');
  print('  │  │  onPopInvoked called with didPop = true      │   │');
  print('  │  └──────────────────────────────────────────────┘   │');
  print('  │                                                     │');
  print('  │  canPop = false:                                    │');
  print('  │  ┌──────────────────────────────────────────────┐   │');
  print('  │  │  System back gesture → intercepted (no pop)  │   │');
  print('  │  │  Navigator.pop()    → blocked (no pop)       │   │');
  print('  │  │  onPopInvoked called with didPop = false     │   │');
  print('  │  │  You decide what to do in the callback       │   │');
  print('  │  └──────────────────────────────────────────────┘   │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');
  print('  Common use cases for canPop = false:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • "Unsaved changes" confirmation dialog         │');
  print('  │  • Multi-step wizard (prevent accidental back)   │');
  print('  │  • Root page that should not be popped           │');
  print('  │  • Auth forms during required flow               │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: State Restoration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: State Restoration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The restorationId parameter enables state restoration');
  print('  — the ability to rebuild the navigation stack after');
  print('  the app process is killed and restarted by the OS.');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Without restorationId:                           │');
  print('  │  • App killed → restarted at home page            │');
  print('  │  • Deep navigation stack is lost                  │');
  print('  │  • User loses their place                         │');
  print('  │                                                   │');
  print('  │  With restorationId:                              │');
  print('  │  • App killed → route serialized to restoration   │');
  print('  │  • App restarted → route stack is rebuilt          │');
  print('  │  • User continues where they left off             │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Requirements for restoration to work:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  1. Page must have a restorationId               │');
  print('  │  2. Navigator must have a restorationScopeId     │');
  print('  │  3. MaterialApp must have a restorationScopeId   │');
  print('  │  4. Route arguments must be serializable          │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: MaterialPage vs CupertinoPage ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: MaterialPage vs CupertinoPage');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Flutter provides two concrete Page implementations:');
  print('');
  print('  ┌─────────────────┬──────────────────────────────────┐');
  print('  │  Feature         │  MaterialPage    │ CupertinoPage │');
  print('  ├─────────────────┼──────────────────┼───────────────┤');
  print('  │  Transition      │  Platform-aware  │ iOS slide     │');
  print('  │                  │  (fade/slide)    │ from right    │');
  print('  ├─────────────────┼──────────────────┼───────────────┤');
  print('  │  Back gesture    │  Platform-aware  │ Edge swipe    │');
  print('  ├─────────────────┼──────────────────┼───────────────┤');
  print('  │  fullscreenDialog│  yes (prop)      │ yes (prop)    │');
  print('  ├─────────────────┼──────────────────┼───────────────┤');
  print('  │  maintainState   │  yes (prop)      │ yes (prop)    │');
  print('  ├─────────────────┼──────────────────┼───────────────┤');
  print('  │  allowSnapshotting│ yes (prop)      │ yes (prop)    │');
  print('  ├─────────────────┼──────────────────┼───────────────┤');
  print('  │  Creates         │  Material route  │ Cupertino     │');
  print('  │                  │  (PageRoute)     │ route         │');
  print('  └─────────────────┴──────────────────┴───────────────┘');
  print('');
  print('  Both accept a child widget and wrap it in the');
  print('  appropriate platform-styled route.');
  print('');

  // ─── Section 11: Custom Page Implementation ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Custom Page Implementation Pattern');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  You can create custom Page subclasses for specialized');
  print('  transition behavior:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  class FadePage<T> extends Page<T> {              │');
  print('  │    final Widget child;                            │');
  print('  │    final Duration duration;                       │');
  print('  │                                                   │');
  print('  │    const FadePage({                               │');
  print('  │      required this.child,                         │');
  print('  │      this.duration = const Duration(ms: 300),     │');
  print('  │      super.key,                                   │');
  print('  │      super.name,                                  │');
  print('  │      super.restorationId,                         │');
  print('  │    });                                            │');
  print('  │                                                   │');
  print('  │    @override                                      │');
  print('  │    Route<T> createRoute(BuildContext context) {    │');
  print('  │      return PageRouteBuilder<T>(                  │');
  print('  │        settings: this,  // pass self as settings  │');
  print('  │        pageBuilder: (_, __, ___) => child,        │');
  print('  │        transitionsBuilder:                        │');
  print('  │          (_, anim, __, child) =>                  │');
  print('  │            FadeTransition(opacity: anim, child),  │');
  print('  │        transitionDuration: duration,              │');
  print('  │      );                                           │');
  print('  │    }                                              │');
  print('  │  }                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Critical: Always pass `settings: this` to the Route');
  print('  constructor. This links the Route back to its Page,');
  print('  enabling canUpdate, pop interception, and observers.');
  print('');

  // ─── Section 12: Imperative vs Declarative Comparison ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Imperative vs Declarative Navigation');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  IMPERATIVE (Navigator 1.0):                        │');
  print('  │  ┌──────────────────────────────────────────────┐   │');
  print('  │  │  Navigator.push(context, MaterialPageRoute(  │   │');
  print('  │  │    builder: (_) => DetailScreen(),            │   │');
  print('  │  │  ));                                          │   │');
  print('  │  │                                               │   │');
  print('  │  │  • Direct method calls                        │   │');
  print('  │  │  • Framework controls the stack internally    │   │');
  print('  │  │  • Hard to sync with app state                │   │');
  print('  │  │  • Deep links are complex                     │   │');
  print('  │  └──────────────────────────────────────────────┘   │');
  print('  │                                                     │');
  print('  │  DECLARATIVE (Navigator 2.0):                       │');
  print('  │  ┌──────────────────────────────────────────────┐   │');
  print('  │  │  Navigator(                                   │   │');
  print('  │  │    pages: [                                   │   │');
  print('  │  │      MaterialPage(child: HomeScreen()),       │   │');
  print('  │  │      if (showDetail)                          │   │');
  print('  │  │        MaterialPage(child: DetailScreen()),   │   │');
  print('  │  │    ],                                         │   │');
  print('  │  │    onDidRemovePage: (page) { ... },           │   │');
  print('  │  │  )                                            │   │');
  print('  │  │                                               │   │');
  print('  │  │  • State-driven stack                         │   │');
  print('  │  │  • UI = f(state) for navigation too           │   │');
  print('  │  │  • Deep links map to state naturally          │   │');
  print('  │  │  • Complex flows are more manageable          │   │');
  print('  │  └──────────────────────────────────────────────┘   │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 13: Page Key Strategies ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Page Key Strategies');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Choosing the right key for Pages is critical for');
  print('  correct diffing behavior:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Strategy: Value-based keys (recommended)         │');
  print('  │                                                   │');
  print('  │  MaterialPage(                                    │');
  print('  │    key: ValueKey("detail_\$itemId"),               │');
  print('  │    child: DetailScreen(id: itemId),               │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  Same ID → canUpdate = true → route updates       │');
  print('  │  Diff ID → canUpdate = false → route replaced     │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Strategy: No key (always creates new route)     │');
  print('  │                                                   │');
  print('  │  MaterialPage(                                    │');
  print('  │    child: SettingsScreen(),                       │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  null key → canUpdate checks runtimeType only    │');
  print('  │  (since null == null is true in Dart)             │');
  print('  │  Same page type at same position → updates        │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Strategy: UniqueKey (never reuses route)        │');
  print('  │                                                   │');
  print('  │  MaterialPage(                                    │');
  print('  │    key: UniqueKey(),                              │');
  print('  │    child: TransientScreen(),                      │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  Every rebuild creates new route (rarely wanted)  │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Router Integration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Router Integration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Page<T> is designed to work with the Router widget,');
  print('  which connects app state to the navigation stack:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  URL / Deep Link                                  │');
  print('  │    ↓                                              │');
  print('  │  RouteInformationParser                           │');
  print('  │    ↓ parse(RouteInformation)                      │');
  print('  │  App State (your model)                           │');
  print('  │    ↓                                              │');
  print('  │  RouterDelegate                                   │');
  print('  │    ↓ build() returns Navigator                    │');
  print('  │  Navigator(pages: [...])                          │');
  print('  │    ↓ diff pages vs routes                         │');
  print('  │  Route Stack (live routes)                        │');
  print('  │    ↓                                              │');
  print('  │  Screen Widgets                                   │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  The RouterDelegate converts app state into a list');
  print('  of Page objects. Navigator then diffs them into');
  print('  live routes. This is the full Nav 2.0 pipeline.');
  print('');

  // ─── Section 15: Page Lifecycle Sequence ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Page Lifecycle Sequence');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  1. Page created (declarative, in pages list)    │');
  print('  │     ↓                                             │');
  print('  │  2. Navigator calls canUpdate against old pages  │');
  print('  │     ↓                                             │');
  print('  │  3a. canUpdate=true → Route.didUpdateSettings()  │');
  print('  │      (route stays, settings updated)             │');
  print('  │     ↓                                             │');
  print('  │  3b. canUpdate=false → old route animates out,   │');
  print('  │      createRoute() called for new page           │');
  print('  │     ↓                                             │');
  print('  │  4. Route builds its content                     │');
  print('  │     ↓                                             │');
  print('  │  5. On page removal from list:                   │');
  print('  │     Navigator calls route.didPop() or            │');
  print('  │     route.didComplete()                          │');
  print('  │     ↓                                             │');
  print('  │  6. onDidRemovePage callback fires               │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Note: The Page object itself is immutable. When the');
  print('  "same" page is updated, a new Page instance is');
  print('  created — canUpdate determines if the underlying');
  print('  Route can be reused.');
  print('');

  // ─── Section 16: Common Patterns ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 16: Common Patterns');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Pattern 1: Simple stack with conditional page');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  pages: [                                         │');
  print('  │    MaterialPage(                                  │');
  print('  │      key: ValueKey("home"),                       │');
  print('  │      child: HomeScreen(),                         │');
  print('  │    ),                                             │');
  print('  │    if (selectedItem != null)                      │');
  print('  │      MaterialPage(                                │');
  print('  │        key: ValueKey("detail_\${selectedItem.id}"),│');
  print('  │        child: DetailScreen(item: selectedItem),   │');
  print('  │      ),                                           │');
  print('  │  ]                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pattern 2: Multi-step flow');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  pages: [                                         │');
  print('  │    MaterialPage(key: ValueKey("step1"), ...),     │');
  print('  │    if (step >= 2)                                 │');
  print('  │      MaterialPage(key: ValueKey("step2"), ...),   │');
  print('  │    if (step >= 3)                                 │');
  print('  │      MaterialPage(key: ValueKey("step3"), ...),   │');
  print('  │  ]                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pattern 3: Auth-gated navigation');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  pages: [                                         │');
  print('  │    if (!isLoggedIn)                               │');
  print('  │      MaterialPage(                                │');
  print('  │        key: ValueKey("login"),                    │');
  print('  │        child: LoginScreen(),                      │');
  print('  │      )                                            │');
  print('  │    else ...[                                      │');
  print('  │      MaterialPage(                                │');
  print('  │        key: ValueKey("home"),                     │');
  print('  │        child: HomeScreen(),                       │');
  print('  │      ),                                           │');
  print('  │      ...additionalPages,                          │');
  print('  │    ],                                             │');
  print('  │  ]                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 17: Live Interactive Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 17: Live Interactive Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Build a declarative navigation demo showing Page-based stack
  final pageItems = <Map<String, dynamic>>[
    {'title': 'Dashboard', 'icon': Icons.dashboard, 'color': copper},
    {'title': 'Projects', 'icon': Icons.folder, 'color': bronze},
    {'title': 'Messages', 'icon': Icons.message, 'color': sienna},
    {'title': 'Settings', 'icon': Icons.settings, 'color': saddleBrown},
  ];

  final pageDemo = Scaffold(
    backgroundColor: warmCream,
    appBar: AppBar(
      title: const Text(
        'Page<T> — Declarative Navigation',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: darkBronze,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  copper,
                  bronze,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: copper.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Navigator 2.0 Page Stack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pages describe routes declaratively.\n'
                  'The Navigator diffs them into live routes.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Simulated page stack visualization
          Text(
            'Simulated Page Stack',
            style: TextStyle(
              color: darkBronze,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),

          ...pageItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final itemColor = item['color'] as Color;
            final isTop = index == pageItems.length - 1;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isTop
                    ? itemColor.withValues(alpha: 0.15)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isTop
                      ? itemColor
                      : burlywood.withValues(alpha: 0.4),
                  width: isTop ? 2 : 1,
                ),
                boxShadow: isTop
                    ? [
                        BoxShadow(
                          color: itemColor.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: itemColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: itemColor,
                    size: 20,
                  ),
                ),
                title: Text(
                  item['title'] as String,
                  style: TextStyle(
                    color: darkBronze,
                    fontWeight: isTop ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  'Page(key: ValueKey("${item['title']}"))',
                  style: TextStyle(
                    color: sienna.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                trailing: isTop
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: itemColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'TOP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.layers,
                        color: camel,
                        size: 18,
                      ),
              ),
            );
          }),

          const SizedBox(height: 20),

          // canUpdate visualization
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: antiqueWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: lightCopper),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'canUpdate() Behavior',
                  style: TextStyle(
                    color: darkBronze,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'old': 'MaterialPage(key: "A")', 'new': 'MaterialPage(key: "A")', 'result': 'true  (update)'},
                  {'old': 'MaterialPage(key: "A")', 'new': 'MaterialPage(key: "B")', 'result': 'false (replace)'},
                  {'old': 'MaterialPage(key: "A")', 'new': 'CupertinoPage(key: "A")', 'result': 'false (diff type)'},
                  {'old': 'MaterialPage(key: null)', 'new': 'MaterialPage(key: null)', 'result': 'true  (null==null)'},
                ].map((comparison) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${comparison['old']} → ${comparison['new']}',
                            style: TextStyle(
                              color: saddleBrown,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (comparison['result'] as String).startsWith('true')
                                ? const Color(0xFF4CAF50).withValues(alpha: 0.15)
                                : const Color(0xFFE53935).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            comparison['result']!,
                            style: TextStyle(
                              color: (comparison['result'] as String).startsWith('true')
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFC62828),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Properties reference card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: burlywood.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Page Properties',
                  style: TextStyle(
                    color: darkBronze,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'prop': 'key', 'desc': 'Identity for page diffing'},
                  {'prop': 'name', 'desc': 'Route name for observers'},
                  {'prop': 'arguments', 'desc': 'Data passed to route'},
                  {'prop': 'restorationId', 'desc': 'State restoration ID'},
                  {'prop': 'canPop', 'desc': 'Allow system back gesture'},
                  {'prop': 'createRoute()', 'desc': 'Abstract route factory'},
                  {'prop': 'canUpdate()', 'desc': 'Diff identity check'},
                ].map((prop) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            prop['prop']!,
                            style: TextStyle(
                              color: copper,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            prop['desc']!,
                            style: TextStyle(
                              color: saddleBrown.withValues(alpha: 0.8),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: Declarative navigation demo');
  print('  • Page stack visualization with 4 layers');
  print('  • canUpdate() behavior comparison table');
  print('  • Properties reference card');
  print('');

  // ─── Section 18: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 18: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Page<T> is the declarative counterpart to Route<T>.');
  print('  It describes WHAT to show, while Route handles HOW.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                     │');
  print('  │                                                     │');
  print('  │  1. Extends RouteSettings (name + arguments)        │');
  print('  │  2. Abstract — must implement createRoute()         │');
  print('  │  3. canUpdate() drives page diffing (type + key)    │');
  print('  │  4. canPop controls system back gesture             │');
  print('  │  5. restorationId enables process-death recovery    │');
  print('  │  6. MaterialPage/CupertinoPage are built-in         │');
  print('  │  7. Pages list order = navigation stack order       │');
  print('  │  8. Key choice determines route reuse behavior      │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Copper       ${copper.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Bronze       ${bronze.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Camel        ${camel.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Warm Cream   ${warmCream.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Dark Bronze  ${darkBronze.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Burlywood    ${burlywood.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Sienna       ${sienna.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Light Copper ${lightCopper.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Antique Wht  ${antiqueWhite.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  │  Saddle Brown ${saddleBrown.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  Page<T> — Demonstration Complete                     ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return pageDemo;
}
