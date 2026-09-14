// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PopNavigatorRouterDelegateMixin — Complete Deep Dive
///
/// Palette: Terracotta / Clay (warm earth reds and browns)
/// Primary:   Color(0xFFBF360C) — Deep Orange 900
/// Secondary: Color(0xFFD84315) — Deep Orange 800
/// Accent:    Color(0xFFFF7043) — Deep Orange 400
/// Surface:   Color(0xFFFBE9E7) — Deep Orange 50
/// Deep:      Color(0xFF870000) — custom dark red
/// Muted:     Color(0xFFFFAB91) — Deep Orange 200
/// Warm:      Color(0xFFE64A19) — Deep Orange 700
/// Highlight: Color(0xFFFFCCBC) — Deep Orange 100
/// Light:     Color(0xFFFFF3E0) — Orange 50
/// Dark:      Color(0xFF4E342E) — Brown 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PopNavigatorRouterDelegateMixin — Deep Dive         ██');
  print('██   Wire your RouterDelegate pop to Navigator            ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const deepOrange900 = Color(0xFFBF360C);
  const deepOrange800 = Color(0xFFD84315);
  const deepOrange400 = Color(0xFFFF7043);
  const deepOrange50 = Color(0xFFFBE9E7);
  const darkRed = Color(0xFF870000);
  const deepOrange200 = Color(0xFFFFAB91);
  const deepOrange700 = Color(0xFFE64A19);
  const deepOrange100 = Color(0xFFFFCCBC);
  const orange50 = Color(0xFFFFF3E0);
  const brown800 = Color(0xFF4E342E);

  // ─── Section 2: What Is PopNavigatorRouterDelegateMixin? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PopNavigatorRouterDelegateMixin?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  A mixin on RouterDelegate<T> that connects the system');
  print('  back button to the Navigator widget your delegate builds.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Problem it solves:                                   │');
  print('  │                                                       │');
  print('  │  When you implement a custom RouterDelegate, the      │');
  print('  │  Router widget calls your delegate\'s popRoute()      │');
  print('  │  when the user presses the system back button.        │');
  print('  │                                                       │');
  print('  │  But your RouterDelegate builds a Navigator inside    │');
  print('  │  its build() method — and that Navigator has its own  │');
  print('  │  stack of routes. popRoute() needs to call            │');
  print('  │  Navigator.maybePop() on that specific Navigator.     │');
  print('  │                                                       │');
  print('  │  This mixin provides exactly that wiring:             │');
  print('  │  popRoute() → navigatorKey.currentState.maybePop()   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Mixin Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Mixin Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  mixin PopNavigatorRouterDelegateMixin<T>             │');
  print('  │      on RouterDelegate<T> {                           │');
  print('  │                                                       │');
  print('  │    /// The key used for retrieving the current        │');
  print('  │    /// navigator.                                     │');
  print('  │    GlobalKey<NavigatorState>? get navigatorKey;       │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    Future<bool> popRoute() {                          │');
  print('  │      final NavigatorState? navigator =                │');
  print('  │          navigatorKey?.currentState;                  │');
  print('  │      if (navigator == null) {                         │');
  print('  │        return SynchronousFuture<bool>(false);         │');
  print('  │      }                                                │');
  print('  │      return navigator.maybePop();                     │');
  print('  │    }                                                  │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Just 2 members: a getter for the key, and popRoute().');
  print('');

  // ─── Section 4: The navigatorKey Contract ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: The navigatorKey Contract');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  You MUST use the same GlobalKey<NavigatorState>      │');
  print('  │  in both places:                                      │');
  print('  │                                                       │');
  print('  │  1. Return it from the navigatorKey getter:           │');
  print('  │     GlobalKey<NavigatorState>? get navigatorKey =>     │');
  print('  │         _navigatorKey;                                │');
  print('  │                                                       │');
  print('  │  2. Pass it to the Navigator you build:               │');
  print('  │     Widget build(BuildContext context) {               │');
  print('  │       return Navigator(                               │');
  print('  │         key: _navigatorKey,  // ← same key!          │');
  print('  │         pages: [...],                                 │');
  print('  │         onPopPage: ...,                               │');
  print('  │       );                                              │');
  print('  │     }                                                 │');
  print('  │                                                       │');
  print('  │  If the keys don\'t match, popRoute() will get null   │');
  print('  │  from navigatorKey.currentState and return false      │');
  print('  │  — the back button won\'t work.                       │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Router + Delegate Architecture ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Router + Delegate Architecture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Router<T>                                            │');
  print('  │  ├─ routeInformationProvider                          │');
  print('  │  │   (receives URLs from platform)                    │');
  print('  │  ├─ routeInformationParser                            │');
  print('  │  │   (converts RouteInformation → T)                  │');
  print('  │  ├─ routerDelegate                                    │');
  print('  │  │   ├─ setNewRoutePath(T) — sets new route           │');
  print('  │  │   ├─ currentConfiguration — reports current route  │');
  print('  │  │   ├─ build(context) — builds the Navigator         │');
  print('  │  │   └─ popRoute() ← THE MIXIN OVERRIDES THIS        │');
  print('  │  │       └─ navigatorKey.currentState.maybePop()      │');
  print('  │  └─ backButtonDispatcher                              │');
  print('  │      (listens to system back button)                  │');
  print('  │      └─ calls routerDelegate.popRoute()               │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: maybePop vs pop ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Navigator.maybePop() vs Navigator.pop()');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The mixin uses maybePop(), not pop(). Why?           │');
  print('  │                                                       │');
  print('  │  Navigator.pop():                                     │');
  print('  │    Always pops. If you\'re on the last route, you get │');
  print('  │    either an error or a blank screen.                │');
  print('  │                                                       │');
  print('  │  Navigator.maybePop():                                │');
  print('  │    Asks the current route: "Can I pop you?"           │');
  print('  │    → Route.willPop() is called                        │');
  print('  │    → Returns true if popped, false if not             │');
  print('  │    → If false, nothing happens (safe)                 │');
  print('  │                                                       │');
  print('  │  This is important because:                           │');
  print('  │    • Routes with unsaved changes can block the pop    │');
  print('  │    • The last route should NOT be popped (app closes) │');
  print('  │    • maybePop() returns false → Router tells system   │');
  print('  │      the app didn\'t handle back → system handles it  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Custom RouterDelegate Example ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Custom RouterDelegate Example');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class MyRouterDelegate                               │');
  print('  │      extends RouterDelegate<MyRoutePath>              │');
  print('  │      with ChangeNotifier,                             │');
  print('  │           PopNavigatorRouterDelegateMixin<MyRoutePath>│');
  print('  │  {                                                    │');
  print('  │    final _navigatorKey =                              │');
  print('  │        GlobalKey<NavigatorState>();                    │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    GlobalKey<NavigatorState>? get navigatorKey =>      │');
  print('  │        _navigatorKey;                                 │');
  print('  │                                                       │');
  print('  │    List<Page<dynamic>> _pages = [                     │');
  print('  │      MaterialPage(child: HomeScreen()),               │');
  print('  │    ];                                                 │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    Widget build(BuildContext context) {                │');
  print('  │      return Navigator(                                │');
  print('  │        key: _navigatorKey, // ← same key!            │');
  print('  │        pages: List.of(_pages),                        │');
  print('  │        onPopPage: (route, result) {                   │');
  print('  │          if (!route.didPop(result)) return false;     │');
  print('  │          _pages.removeLast();                         │');
  print('  │          notifyListeners();                            │');
  print('  │          return true;                                 │');
  print('  │        },                                             │');
  print('  │      );                                               │');
  print('  │    }                                                  │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    Future<void> setNewRoutePath(MyRoutePath path) {   │');
  print('  │      // Handle incoming route                         │');
  print('  │      _pages = [MaterialPage(child: path.screen)];    │');
  print('  │      notifyListeners();                                │');
  print('  │      return SynchronousFuture(null);                  │');
  print('  │    }                                                  │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Back Button by Platform ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Back Button Behavior by Platform');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Platform             │ Back Button Mechanism         │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Android              │ System back button / gesture  │');
  print('  │                       │ → popRoute() called           │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  iOS                  │ Edge swipe gesture            │');
  print('  │                       │ → handled by CupertinoRoute  │');
  print('  │                       │   (not via popRoute)          │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Web                  │ Browser back button           │');
  print('  │                       │ → popRoute() via              │');
  print('  │                       │   PlatformRouteInformation    │');
  print('  │                       │   Provider                    │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  macOS / Windows      │ No system back (rare)         │');
  print('  │  / Linux              │ App provides its own back     │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 9: With vs Without the Mixin ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: With vs Without the Mixin');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  WITHOUT the mixin:                                   │');
  print('  │  ─────────────────                                    │');
  print('  │  popRoute() returns SynchronousFuture(false)          │');
  print('  │  → Back button does nothing                           │');
  print('  │  → User is stuck (cannot navigate back)              │');
  print('  │  → OR you must manually implement popRoute()          │');
  print('  │                                                       │');
  print('  │  WITH the mixin:                                      │');
  print('  │  ────────────────                                     │');
  print('  │  popRoute() → navigatorKey.currentState.maybePop()   │');
  print('  │  → Navigator pops top route (if allowed)              │');
  print('  │  → Back button works correctly                        │');
  print('  │  → No extra code needed                               │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Comparison with Popular Routers ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Comparison with Popular Routers');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Approach             │ Uses PopNavigator Mixin?      │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Custom RouterDelegate│ Yes — you should use it       │');
  print('  │  GoRouter             │ No — has its own popRoute     │');
  print('  │  AutoRoute            │ No — manages internally       │');
  print('  │  Beamer / Routemaster │ Varies — some use it         │');
  print('  │  Navigator 1.0        │ N/A — no RouterDelegate       │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');
  print('  The mixin is primarily for custom RouterDelegate');
  print('  implementations. Third-party routers solve this');
  print('  internally.');
  print('');

  // ─── Section 11: Common Mistakes ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Common Mistakes');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  1. Different keys for getter and Navigator           │');
  print('  │     → navigatorKey returns key A, Navigator uses B   │');
  print('  │     → popRoute() gets null, back button broken       │');
  print('  │                                                       │');
  print('  │  2. Creating a new key on every build                 │');
  print('  │     → GlobalKey<NavigatorState>() in build() method  │');
  print('  │     → Navigator rebuilt from scratch each time        │');
  print('  │     → Route state lost, back button broken            │');
  print('  │                                                       │');
  print('  │  3. Missing ChangeNotifier mixin                     │');
  print('  │     → RouterDelegate requires notifyListeners()      │');
  print('  │     → Without ChangeNotifier, Router never rebuilds  │');
  print('  │                                                       │');
  print('  │  4. Using pop() instead of relying on mixin           │');
  print('  │     → Overriding popRoute() with direct pop()        │');
  print('  │     → Skips willPop check, unsafe on last route      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildRouteCard({
    required String name,
    required int index,
    required bool isCurrent,
    required Color bg,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isCurrent ? bg : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCurrent ? bg : deepOrange200,
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCurrent ? Colors.white.withValues(alpha: 0.3) : deepOrange200.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$index',
                style: TextStyle(
                  color: isCurrent ? Colors.white : deepOrange900,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isCurrent ? Colors.white : brown800,
                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          if (isCurrent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'TOP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }

  final demo = Scaffold(
    backgroundColor: orange50,
    appBar: AppBar(
      title: const Text(
        'PopNavigatorRouterDelegateMixin — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: darkRed,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Architecture diagram ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [darkRed, deepOrange900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Router ← Delegate ← Mixin Architecture',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'label': 'System Back Button', 'detail': 'Platform sends back event', 'arrow': true},
                  {'label': 'BackButtonDispatcher', 'detail': 'Listens to system back', 'arrow': true},
                  {'label': 'Router.popRoute()', 'detail': 'Delegates to routerDelegate', 'arrow': true},
                  {'label': 'PopNavigatorRouterDelegateMixin', 'detail': 'popRoute() → navigatorKey.maybePop()', 'arrow': true},
                  {'label': 'Navigator.maybePop()', 'detail': 'Pops top route if allowed', 'arrow': false},
                ].asMap().entries.map((entry) {
                  final i = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: deepOrange400.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['label'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                item['detail'] as String,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (item['arrow'] as bool)
                          Icon(Icons.arrow_downward, color: deepOrange400, size: 14),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Navigator route stack ──
          Text(
            'Simulated Route Stack',
            style: TextStyle(
              color: darkRed,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Back button pops the top route via the mixin',
            style: TextStyle(color: deepOrange800, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: deepOrange100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.layers, color: deepOrange900, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Navigator Stack (3 pages)',
                      style: TextStyle(
                        color: brown800,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                buildRouteCard(name: '/settings/theme', index: 3, isCurrent: true, bg: deepOrange700),
                buildRouteCard(name: '/settings', index: 2, isCurrent: false, bg: deepOrange700),
                buildRouteCard(name: '/ (Home)', index: 1, isCurrent: false, bg: deepOrange700),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: deepOrange50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: deepOrange900, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: brown800, fontSize: 12),
                            children: [
                              const TextSpan(text: 'Back pressed → '),
                              TextSpan(
                                text: 'popRoute()',
                                style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'monospace', color: deepOrange900),
                              ),
                              const TextSpan(text: ' → '),
                              TextSpan(
                                text: 'maybePop()',
                                style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'monospace', color: deepOrange900),
                              ),
                              const TextSpan(text: ' → pops /settings/theme'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Key contract ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: deepOrange50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: deepOrange100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.vpn_key, color: deepOrange900, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'The navigatorKey Contract',
                      style: TextStyle(
                        color: darkRed,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...[
                  {'check': true, 'text': 'Same key in getter AND Navigator widget'},
                  {'check': true, 'text': 'Key created as a field (not in build)'},
                  {'check': true, 'text': 'popRoute() finds Navigator via key'},
                  {'check': false, 'text': 'Different keys → back button broken'},
                  {'check': false, 'text': 'New key per build → state lost'},
                ].map((item) {
                  final ok = item['check'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          ok ? Icons.check_circle : Icons.cancel,
                          color: ok ? Color(0xFF43A047) : Color(0xFFE53935),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item['text'] as String,
                            style: TextStyle(
                              color: brown800,
                              fontSize: 12,
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

          const SizedBox(height: 14),

          // ── maybePop vs pop ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: deepOrange200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'maybePop() vs pop()',
                  style: TextStyle(
                    color: darkRed,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFA5D6A7)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'maybePop()',
                              style: TextStyle(
                                color: Color(0xFF2E7D32),
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Checks willPop\nRespects guards\nSafe on last route\nReturns false if blocked',
                              style: TextStyle(
                                color: Color(0xFF1B5E20),
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFEF9A9A)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'pop()',
                              style: TextStyle(
                                color: Color(0xFFC62828),
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Always pops\nSkips guards\nErrors on last route\nNo return value',
                              style: TextStyle(
                                color: Color(0xFFB71C1C),
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Platform comparison ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: deepOrange200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Back Button by Platform',
                  style: TextStyle(
                    color: darkRed,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'platform': 'Android', 'mechanism': 'System back → popRoute()', 'icon': Icons.phone_android, 'uses': true},
                  {'platform': 'Web', 'mechanism': 'Browser back → popRoute()', 'icon': Icons.language, 'uses': true},
                  {'platform': 'iOS', 'mechanism': 'Edge swipe (CupertinoRoute)', 'icon': Icons.phone_iphone, 'uses': false},
                  {'platform': 'macOS', 'mechanism': 'App-provided back button', 'icon': Icons.laptop_mac, 'uses': false},
                  {'platform': 'Windows', 'mechanism': 'App-provided back button', 'icon': Icons.desktop_windows, 'uses': false},
                ].map((p) {
                  final uses = p['uses'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(p['icon'] as IconData, color: uses ? deepOrange900 : Color(0xFF9E9E9E), size: 16),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 65,
                          child: Text(
                            p['platform'] as String,
                            style: TextStyle(
                              color: uses ? brown800 : Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        if (uses)
                          Container(
                            width: 6, height: 6,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(color: Color(0xFF43A047), shape: BoxShape.circle),
                          ),
                        Expanded(
                          child: Text(
                            p['mechanism'] as String,
                            style: TextStyle(
                              color: uses ? deepOrange800 : Color(0xFF9E9E9E),
                              fontSize: 12,
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

  print('  Live widget built: PopNavigatorRouterDelegateMixin demo');
  print('  • 5-step architecture flow (system back → maybePop)');
  print('  • Route stack visualization (3 pages)');
  print('  • navigatorKey contract checklist (5 items)');
  print('  • maybePop vs pop comparison panel');
  print('  • Platform back button comparison (5 platforms)');
  print('');

  // ─── Section 13: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. Mixin on RouterDelegate<T>                       │');
  print('  │  2. Provides popRoute() → navigatorKey.maybePop()   │');
  print('  │  3. navigatorKey must match the Navigator you build  │');
  print('  │  4. Uses maybePop (safe) not pop (unsafe)            │');
  print('  │  5. Essential for custom RouterDelegate + Navigator  │');
  print('  │  6. Not needed with GoRouter, AutoRoute, etc.        │');
  print('  │  7. Requires ChangeNotifier for Router rebuilds      │');
  print('  │  8. Key on Android (back button) and Web (browser)   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Dark Red     ${darkRed.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  DeepOr 900   ${deepOrange900.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  DeepOr 800   ${deepOrange800.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  DeepOr 700   ${deepOrange700.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  DeepOr 400   ${deepOrange400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  DeepOr 200   ${deepOrange200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  DeepOr 100   ${deepOrange100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  DeepOr 50    ${deepOrange50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Orange 50    ${orange50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  │  Brown 800    ${brown800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PopNavigatorRouterDelegateMixin — Demo Complete       ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
