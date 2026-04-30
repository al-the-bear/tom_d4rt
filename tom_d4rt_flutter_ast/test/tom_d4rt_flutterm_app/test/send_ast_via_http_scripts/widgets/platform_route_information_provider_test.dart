// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformRouteInformationProvider — Complete Deep Dive
///
/// Palette: Plum / Mauve (rich purple-violet spectrum)
/// Primary:   Color(0xFF7B1FA2) — Purple 700
/// Secondary: Color(0xFF9C27B0) — Purple 500
/// Accent:    Color(0xFFCE93D8) — Purple 200
/// Surface:   Color(0xFFF3E5F5) — Purple 50
/// Deep:      Color(0xFF4A148C) — Purple 900
/// Muted:     Color(0xFFE1BEE7) — Purple 100
/// Warm:      Color(0xFFAB47BC) — Purple 400
/// Highlight: Color(0xFFF8BBD0) — Pink 100
/// Light:     Color(0xFFFCE4EC) — Pink 50
/// Dark:      Color(0xFF6A1B9A) — Purple 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformRouteInformationProvider — Deep Dive        ██');
  print('██   Bridge between platform URLs and Flutter Router      ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const purple700 = Color(0xFF7B1FA2);
  const purple500 = Color(0xFF9C27B0);
  const purple200 = Color(0xFFCE93D8);
  const purple50 = Color(0xFFF3E5F5);
  const purple900 = Color(0xFF4A148C);
  const purple100 = Color(0xFFE1BEE7);
  const purple400 = Color(0xFFAB47BC);
  const pink100 = Color(0xFFF8BBD0);
  const pink50 = Color(0xFFFCE4EC);
  const purple800 = Color(0xFF6A1B9A);

  // ─── Section 2: What Is PlatformRouteInformationProvider? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformRouteInformationProvider?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PlatformRouteInformationProvider is the default bridge');
  print('  between the host platform and Flutter\'s Router widget.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  On the web, it reads and writes the browser URL.     │');
  print('  │  On mobile, it handles deep links and system back.    │');
  print('  │                                                       │');
  print('  │  Two-way sync:                                        │');
  print('  │  • Platform → Flutter: didPushRouteInformation()      │');
  print('  │  • Flutter → Platform: routerReportsNewRouteInfo()    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Class Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Class Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class PlatformRouteInformationProvider               │');
  print('  │      extends RouteInformationProvider                 │');
  print('  │      with WidgetsBindingObserver, ChangeNotifier {    │');
  print('  │                                                       │');
  print('  │    PlatformRouteInformationProvider({                 │');
  print('  │      required RouteInformation                        │');
  print('  │          initialRouteInformation,                     │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    RouteInformation get value;                        │');
  print('  │                                                       │');
  print('  │    void routerReportsNewRouteInformation(             │');
  print('  │      RouteInformation info, {                         │');
  print('  │      RouteInformationReportingType type,              │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    Future<bool> didPushRouteInformation(              │');
  print('  │      RouteInformation routeInformation);              │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: Inheritance Chain ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Inheritance Chain');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Object                                               │');
  print('  │    └─ ChangeNotifier (mixin)                          │');
  print('  │       └─ RouteInformationProvider (abstract)          │');
  print('  │          └─ PlatformRouteInformationProvider ◄── this │');
  print('  │             + WidgetsBindingObserver (mixin)          │');
  print('  │             + ChangeNotifier (mixin)                  │');
  print('  │                                                       │');
  print('  │  Three roles combined:                                │');
  print('  │  • RouteInformationProvider: notifies Router of       │');
  print('  │    route changes from the platform                    │');
  print('  │  • WidgetsBindingObserver: listens for system events  │');
  print('  │  • ChangeNotifier: notifies listeners of changes     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Router Integration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Router Integration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The Router widget uses this provider:                │');
  print('  │                                                       │');
  print('  │  Router(                                              │');
  print('  │    routeInformationProvider:                          │');
  print('  │      PlatformRouteInformationProvider(                │');
  print('  │        initialRouteInformation:                       │');
  print('  │          RouteInformation(uri: Uri.parse("/")),       │');
  print('  │      ),                                               │');
  print('  │    routeInformationParser: MyParser(),                │');
  print('  │    routerDelegate: MyDelegate(),                      │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  If no routeInformationProvider is given, Router      │');
  print('  │  creates one automatically using the initial route    │');
  print('  │  from WidgetsBinding.                                 │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: Two-Way Sync Mechanism ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Two-Way Sync Mechanism');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PLATFORM → FLUTTER                                   │');
  print('  │  ──────────────────                                   │');
  print('  │  Browser URL change / deep link / system back         │');
  print('  │    → WidgetsBindingObserver.didPushRouteInformation() │');
  print('  │    → Updates internal _value                          │');
  print('  │    → Calls notifyListeners()                          │');
  print('  │    → Router picks up change via its listener          │');
  print('  │    → Router calls routeInformationParser.parse(info)  │');
  print('  │    → RouterDelegate.setNewRoutePath(config)           │');
  print('  │                                                       │');
  print('  │  FLUTTER → PLATFORM                                   │');
  print('  │  ──────────────────                                   │');
  print('  │  Router state changes (app navigation)                │');
  print('  │    → routerReportsNewRouteInformation(info, type)     │');
  print('  │    → Compares with _valueInEngine (dedup)             │');
  print('  │    → SystemNavigator.routeInformationUpdated(...)     │');
  print('  │      - type.navigate → push (new history entry)       │');
  print('  │      - type.neglect → replace (no history entry)      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: RouteInformationReportingType ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: RouteInformationReportingType');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  enum RouteInformationReportingType {                 │');
  print('  │    none,     // Do not report to engine                │');
  print('  │    neglect,  // Replace current history entry          │');
  print('  │    navigate, // Push new history entry (default)       │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  • navigate: User navigated to a new page → push      │');
  print('  │    Browser gets a new history entry, back button works │');
  print('  │                                                       │');
  print('  │  • neglect: State update without navigation → replace  │');
  print('  │    URL updates but no new history entry               │');
  print('  │    Example: scroll position in URL, tab change        │');
  print('  │                                                       │');
  print('  │  • none: Internal state only, no engine communication │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Deduplication Logic ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Deduplication Logic');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The provider avoids redundant platform updates:      │');
  print('  │                                                       │');
  print('  │  routerReportsNewRouteInformation(newInfo, type) {    │');
  print('  │    final isSameRoute = _equals(                       │');
  print('  │      _valueInEngine.uri,                              │');
  print('  │      newInfo.uri,                                     │');
  print('  │    );                                                 │');
  print('  │    if (isSameRoute) return; // skip duplicate          │');
  print('  │                                                       │');
  print('  │    _value = newInfo;                                  │');
  print('  │    _valueInEngine = newInfo;                          │');
  print('  │    SystemNavigator.routeInformationUpdated(...);      │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  URI equality checks: path, fragment, and all query   │');
  print('  │  parameters must match for routes to be "equal".      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Listener Registration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Automatic Listener Registration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  addListener() and removeListener() are overridden:   │');
  print('  │                                                       │');
  print('  │  void addListener(VoidCallback listener) {            │');
  print('  │    if (!hasListeners) {                               │');
  print('  │      WidgetsBinding.instance                          │');
  print('  │        .addObserver(this);  // start listening        │');
  print('  │    }                                                  │');
  print('  │    super.addListener(listener);                       │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  void removeListener(VoidCallback listener) {         │');
  print('  │    super.removeListener(listener);                    │');
  print('  │    if (!hasListeners) {                               │');
  print('  │      WidgetsBinding.instance                          │');
  print('  │        .removeObserver(this);  // stop listening      │');
  print('  │    }                                                  │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  The provider only registers itself as a binding      │');
  print('  │  observer while someone is actually listening.        │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Common Use Cases ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Common Use Cases');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  1. Web Browser URL Sync                              │');
  print('  │     User types URL → didPushRouteInformation → Router │');
  print('  │     App navigates → routerReports... → URL updates    │');
  print('  │                                                       │');
  print('  │  2. Deep Linking on Mobile                            │');
  print('  │     OS sends deep link URI → didPushRouteInformation  │');
  print('  │     App navigates to corresponding page               │');
  print('  │                                                       │');
  print('  │  3. System Back Button                                │');
  print('  │     Android back → WidgetsBindingObserver callback    │');
  print('  │     Provider notifies Router → delegate pops          │');
  print('  │                                                       │');
  print('  │  4. Custom Initial Route                              │');
  print('  │     Provide specific initialRouteInformation to       │');
  print('  │     start the app at a particular page                │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: RouteInformation Object ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: RouteInformation Object');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class RouteInformation {                             │');
  print('  │    RouteInformation({                                 │');
  print('  │      String? location,  // deprecated, use uri        │');
  print('  │      Uri? uri,         // the route URI               │');
  print('  │      Object? state,    // arbitrary state object      │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    Uri get uri;                                       │');
  print('  │    Object? get state;                                 │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  Examples:                                            │');
  print('  │  RouteInformation(uri: Uri.parse("/home"))            │');
  print('  │  RouteInformation(uri: Uri.parse("/user/42?tab=bio"))│');
  print('  │  RouteInformation(uri: Uri.parse("/"), state: {...})  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Platform Differences ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Platform Differences');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────┬────────────────────────────┐');
  print('  │  Platform                 │ Behavior                   │');
  print('  ├──────────────────────────┼────────────────────────────┤');
  print('  │  Web                      │ Full URL/history sync      │');
  print('  │  Android                  │ Deep links + back button   │');
  print('  │  iOS                      │ Deep links + Universal Links│');
  print('  │  macOS                    │ Limited (no URL bar)       │');
  print('  │  Windows                  │ Limited (no URL bar)       │');
  print('  │  Linux                    │ Limited (no URL bar)       │');
  print('  └──────────────────────────┴────────────────────────────┘');
  print('');
  print('  On web, "navigate" creates a new browser history entry.');
  print('  On mobile, "navigate" has no visible effect but maintains');
  print('  the internal state for deep link restoration.');
  print('');

  // ─── Section 13: Relationship with GoRouter ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Relationship with GoRouter');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  GoRouter (go_router package) builds on this:         │');
  print('  │                                                       │');
  print('  │  GoRouter(                                            │');
  print('  │    routes: [...],                                     │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  Internally creates:                                  │');
  print('  │  • GoRouteInformationProvider (extends this class)    │');
  print('  │  • GoRouteInformationParser                           │');
  print('  │  • GoRouterDelegate                                   │');
  print('  │                                                       │');
  print('  │  MaterialApp.router(                                  │');
  print('  │    routerConfig: goRouter,  // sets up everything     │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  Under the hood, PlatformRouteInformationProvider     │');
  print('  │  is the foundation that both flutter/go_router use.   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Simulated route history for the demo
  final routeHistory = <Map<String, String>>[
    {'uri': '/', 'type': 'initial', 'source': 'App start'},
    {'uri': '/home', 'type': 'navigate', 'source': 'User tap'},
    {'uri': '/products', 'type': 'navigate', 'source': 'User tap'},
    {'uri': '/products?sort=price', 'type': 'neglect', 'source': 'Filter change'},
    {'uri': '/products/42', 'type': 'navigate', 'source': 'User tap'},
    {'uri': '/products/42#reviews', 'type': 'neglect', 'source': 'Tab switch'},
    {'uri': '/checkout', 'type': 'navigate', 'source': 'User tap'},
  ];

  final demo = Scaffold(
    backgroundColor: pink50,
    appBar: AppBar(
      title: const Text(
        'PlatformRouteInformationProvider — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
      backgroundColor: purple900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Simulated browser URL bar ──
          Text(
            'Simulated Browser URL Bar',
            style: TextStyle(
              color: purple900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: purple200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.lock, color: Color(0xFF43A047), size: 16),
                const SizedBox(width: 6),
                Text(
                  'myapp.com',
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '/checkout',
                  style: TextStyle(
                    color: purple900,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(Icons.refresh, color: Color(0xFF757575), size: 18),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Two-way sync diagram ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [purple900, purple800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Two-Way Route Synchronization',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                // Platform → Flutter
                _buildSyncRow(
                  direction: 'Platform → Flutter',
                  steps: [
                    'Browser URL / Deep link',
                    'didPushRouteInformation()',
                    'notifyListeners()',
                    'Router rebuilds',
                  ],
                  arrowColor: purple200,
                  dotColor: pink100,
                ),
                const SizedBox(height: 16),
                // Flutter → Platform
                _buildSyncRow(
                  direction: 'Flutter → Platform',
                  steps: [
                    'App navigates',
                    'routerReportsNewRouteInfo()',
                    'SystemNavigator.routeInformationUpdated',
                    'Browser URL / Engine state',
                  ],
                  arrowColor: purple400,
                  dotColor: purple200,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Route history timeline ──
          Text(
            'Route Navigation History',
            style: TextStyle(
              color: purple900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Showing navigate (push) vs neglect (replace) behavior',
            style: TextStyle(color: purple800, fontSize: 12),
          ),
          const SizedBox(height: 8),
          ...routeHistory.asMap().entries.map((entry) {
            final idx = entry.key;
            final route = entry.value;
            final isNavigate = route['type'] == 'navigate' || route['type'] == 'initial';
            final typeColor = isNavigate ? purple700 : Color(0xFFE65100);
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline connector
                  SizedBox(
                    width: 30,
                    child: Column(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: typeColor.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(color: typeColor, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              '$idx',
                              style: TextStyle(
                                color: typeColor,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        if (idx < routeHistory.length - 1)
                          Container(
                            width: 2,
                            height: 20,
                            color: purple100,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: typeColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  route['uri']!,
                                  style: TextStyle(
                                    color: purple900,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                Text(
                                  route['source']!,
                                  style: TextStyle(
                                    color: purple700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: typeColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              route['type']!,
                              style: TextStyle(
                                color: typeColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // ── Reporting type comparison ──
          Text(
            'RouteInformationReportingType',
            style: TextStyle(
              color: purple900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          ...[
            {
              'type': 'navigate',
              'icon': Icons.add_circle_outline,
              'desc': 'Push new history entry. User can go back.',
              'example': 'Tapping a product link',
              'browser': 'New entry in browser history',
              'color': purple700,
            },
            {
              'type': 'neglect',
              'icon': Icons.refresh,
              'desc': 'Replace current entry. No new history.',
              'example': 'Changing sort filter, switching tab',
              'browser': 'URL updates, history stays same',
              'color': Color(0xFFE65100),
            },
            {
              'type': 'none',
              'icon': Icons.block,
              'desc': 'No platform communication at all.',
              'example': 'Internal state tracking only',
              'browser': 'URL does not change',
              'color': Color(0xFF757575),
            },
          ].map((item) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: (item['color'] as Color).withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['type'] as String,
                          style: TextStyle(
                            color: item['color'] as Color,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['desc'] as String,
                          style: TextStyle(
                            color: purple900,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Example: ${item["example"]}',
                          style: TextStyle(
                            color: purple700,
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          'Browser: ${item["browser"]}',
                          style: TextStyle(
                            color: purple400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          // ── Platform differences card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: purple50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: purple100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Behavior',
                  style: TextStyle(
                    color: purple900,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'platform': 'Web', 'icon': Icons.language, 'detail': 'Full URL + history sync'},
                  {'platform': 'Android', 'icon': Icons.phone_android, 'detail': 'Deep links + back button'},
                  {'platform': 'iOS', 'icon': Icons.phone_iphone, 'detail': 'Universal Links + deep links'},
                  {'platform': 'macOS', 'icon': Icons.laptop_mac, 'detail': 'Limited — no visible URL'},
                  {'platform': 'Windows', 'icon': Icons.desktop_windows, 'detail': 'Limited — no visible URL'},
                  {'platform': 'Linux', 'icon': Icons.computer, 'detail': 'Limited — no visible URL'},
                ].map((p) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(p['icon'] as IconData, color: purple700, size: 16),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            p['platform'] as String,
                            style: TextStyle(
                              color: purple900,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            p['detail'] as String,
                            style: TextStyle(
                              color: purple800,
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

  print('  Live widget built: PlatformRouteInformationProvider demo');
  print('  • Simulated browser URL bar with current route');
  print('  • Two-way sync architecture diagram');
  print('  • Route history timeline (7 entries, navigate vs neglect)');
  print('  • 3 reporting type cards with examples');
  print('  • Platform behavior matrix (6 platforms)');
  print('');

  // ─── Section 15: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. Default bridge between platform and Router        │');
  print('  │  2. Two-way sync: platform→Flutter, Flutter→platform  │');
  print('  │  3. Extends RouteInformationProvider + WidgetsBinding │');
  print('  │  4. navigate = push, neglect = replace, none = silent│');
  print('  │  5. Deduplicates identical URIs (path+query+fragment) │');
  print('  │  6. Auto-registers/unregisters as binding observer    │');
  print('  │  7. Foundation for GoRouter, auto_route, etc.         │');
  print('  │  8. RouteInformation carries URI + optional state     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Purple 900 ${purple900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Purple 800 ${purple800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Purple 700 ${purple700.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Purple 500 ${purple500.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Purple 400 ${purple400.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Purple 200 ${purple200.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Purple 100 ${purple100.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Pink 100   ${pink100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Purple 50  ${purple50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Pink 50    ${pink50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformRouteInformationProvider — Demo Complete      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}

Widget _buildSyncRow({
  required String direction,
  required List<String> steps,
  required Color arrowColor,
  required Color dotColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        direction,
        style: TextStyle(
          color: arrowColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 6),
      ...steps.asMap().entries.map((entry) {
        final i = entry.key;
        final text = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ),
              if (i < steps.length - 1)
                Icon(Icons.arrow_forward, color: arrowColor, size: 12),
            ],
          ),
        );
      }),
    ],
  );
}
