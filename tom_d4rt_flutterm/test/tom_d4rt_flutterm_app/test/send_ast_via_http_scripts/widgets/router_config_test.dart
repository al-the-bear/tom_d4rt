// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — RouterConfig
///
/// `RouterConfig<T>` is the configuration object that binds the four pillars of
/// Flutter's declarative Router together:
///   1. RouteInformationProvider — supplies the current route (URL / deep-link)
///   2. `RouteInformationParser<T>` — converts RouteInformation into app state T
///   3. `RouterDelegate<T>` — builds the Navigator (or widget tree) from state T
///   4. BackButtonDispatcher — handles Android back button / browser back
///
/// By bundling these into a single object, RouterConfig lets you pass a
/// complete routing configuration to MaterialApp.router without exposing
/// each piece individually.
///
/// Sections
/// ─────────
/// 1. What is RouterConfig?
/// 2. The four pillars explained
/// 3. RouterConfig vs Navigator push/pop
/// 4. Live: declarative routing demo
/// 5. Route parsing flow visualisation
/// 6. BackButtonDispatcher explained
/// 7. Common patterns
/// 8. Best practices

// ─── palette ───────────────────────────────────────────────
const _kRose     = Color(0xFFE91E63);
const _kRoseLt   = Color(0xFFFCE4EC);
const _kRoseDk   = Color(0xFF880E4F);
const _kBluGry   = Color(0xFF546E7A);
const _kBluGryLt = Color(0xFFCFD8DC);
const _kBluGryDk = Color(0xFF263238);
const _kSurface  = Color(0xFFFAFAFD);
const _kDivider  = Color(0xFFE0E0E0);
const _kTextDark = Color(0xFF212121);
const _kTextMuted = Color(0xFF757575);

// ─── 1. Overview ───────────────────────────────────────────
const _kOverview = 'RouterConfig bundles the four pieces needed for declarative '
    'routing into one immutable object. You pass it to MaterialApp.router() or '
    'CupertinoApp.router() to activate the Router widget. The Router then '
    'coordinates navigation, deep-linking, and browser URL synchronisation '
    'through the objects in the config — without you managing a Navigator stack.';

// ─── 2. Pillar data ────────────────────────────────────────
class _Pillar {
  const _Pillar(this.name, this.role, this.key, this.detail);
  final String name;
  final String role;
  final String key;
  final String detail;
}

const _kPillars = <_Pillar>[
  _Pillar(
    'RouteInformationProvider',
    'Source of truth for the current route',
    'routeInformationProvider',
    'Typically PlatformRouteInformationProvider, which reads the URL from '
    'the engine and reports changes (forward, back, deep-link). On mobile, '
    'it bootstraps from the initial route; on web, it mirrors the address bar.',
  ),
  _Pillar(
    'RouteInformationParser<T>',
    'Converts URL ↔ app configuration T',
    'routeInformationParser',
    'parseRouteInformation(RouteInformation) → Future<T> converts an incoming '
    'URL into your typed route state. restoreRouteInformation(T) → '
    'RouteInformation does the reverse for browser URL updates.',
  ),
  _Pillar(
    'RouterDelegate<T>',
    'Builds the widget tree from configuration T',
    'routerDelegate',
    'Extends RouterDelegate<T> and implements build(). When currentConfiguration '
    'is set, it rebuilds. It owns the Navigator and manages pages. Also handles '
    'setNewRoutePath() for incoming parsed routes.',
  ),
  _Pillar(
    'BackButtonDispatcher',
    'Handles system back button',
    'backButtonDispatcher',
    'RootBackButtonDispatcher listens to SystemNavigator.pop. '
    'ChildBackButtonDispatcher lets nested Routers handle back in priority '
    'order. On web, this also intercepts browser back navigation.',
  ),
];

// ─── 3. Comparison ─────────────────────────────────────────
class _CompRow {
  const _CompRow(this.feature, this.router, this.navigator);
  final String feature;
  final String router;
  final String navigator;
}

const _kComparison = <_CompRow>[
  _CompRow('Navigation model', 'Declarative (state → pages)', 'Imperative (push/pop)'),
  _CompRow('URL sync (web)', 'Automatic via Parser', 'Manual or none'),
  _CompRow('Deep-link support', 'Built-in', 'Must be added separately'),
  _CompRow('State management', 'App state drives routes', 'Navigator stack IS state'),
  _CompRow('Back button', 'BackButtonDispatcher', 'Navigator.pop / WillPopScope'),
  _CompRow('Testability', 'Unit-test Parser + Delegate', 'Widget-test Navigator'),
  _CompRow('Setup complexity', 'Higher — 4 objects', 'Lower — just push/pop'),
];

// ─── 6. BackButton info ────────────────────────────────────
const _kBackButtonRows = <String, String>{
  'RootBackButtonDispatcher':
      'The default. Binds to WidgetsBindingObserver.didPopRoute(). Only one '
      'root dispatcher should exist per app. It delegates to callbacks in '
      'last-registered-first order.',
  'ChildBackButtonDispatcher':
      'Created by nested Routers. The parent dispatcher delegates to children '
      'first. If a child handles the back event (returns true), the parent '
      'does nothing. This creates a priority chain for nested navigation.',
};

// ─── 7. Common patterns ────────────────────────────────────
class _Pattern {
  const _Pattern(this.title, this.code, this.desc);
  final String title;
  final String code;
  final String desc;
}

const _kPatterns = <_Pattern>[
  _Pattern(
    'MaterialApp.router() shorthand',
    'MaterialApp.router(\n  routerConfig: myRouterConfig,\n)',
    'The simplest way to plug in declarative routing. The app reads all '
    'four components from the config automatically.',
  ),
  _Pattern(
    'Custom RouteInformationParser',
    'class MyParser extends RouteInformationParser<MyRoute> {\n'
    '  @override\n'
    '  Future<MyRoute> parseRouteInformation(\n'
    '      RouteInformation info) async {\n'
    '    final uri = info.uri;\n'
    '    if (uri.pathSegments.isEmpty) return MyRoute.home;\n'
    '    return MyRoute.fromPath(uri.path);\n'
    '  }\n'
    '}',
    'Parse the incoming URL into a typed route enum or class. This is where '
    'path segments, query parameters, and fragments are decoded.',
  ),
  _Pattern(
    'RouterDelegate with Pages',
    'class MyDelegate extends RouterDelegate<MyRoute>\n'
    '    with ChangeNotifier, PopNavigatorRouterDelegateMixin {\n'
    '  @override\n'
    '  Widget build(BuildContext context) {\n'
    '    return Navigator(\n'
    '      key: navigatorKey,\n'
    '      pages: _buildPages(),\n'
    '      onPopPage: _onPopPage,\n'
    '    );\n'
    '  }\n'
    '}',
    'The delegate owns the page stack and rebuilds the Navigator whenever '
    'the configuration changes. PopNavigatorRouterDelegateMixin provides '
    'the navigatorKey and popRoute() implementation.',
  ),
];

// ─── 8. Best practices ─────────────────────────────────────
class _Practice {
  const _Practice(this.tip, this.detail);
  final String tip;
  final String detail;
}

const _kBestPractices = <_Practice>[
  _Practice(
    'Keep your route type simple',
    'Use an enum with optional parameters, or a small immutable class. '
    'Complex route types make the parser and delegate harder to test and '
    'reason about.',
  ),
  _Practice(
    'Test parser and delegate in isolation',
    'Parser: supply RouteInformation, assert the parsed route. '
    'Delegate: set currentConfiguration, call build(), assert the page stack. '
    'No widget test needed for the core logic.',
  ),
  _Practice(
    'Don\'t mix imperative and declarative',
    'Once you use RouterConfig, avoid calling Navigator.push/pop directly. '
    'Instead, update your app state and let the delegate rebuild. Mixing '
    'both leads to state desync.',
  ),
  _Practice(
    'Handle unknown routes in the parser',
    'If parseRouteInformation receives an unrecognised URL, return a '
    'well-known "not found" route rather than throwing. This keeps the '
    'Router stable when users type random URLs.',
  ),
  _Practice(
    'Provide restoreRouteInformation',
    'This method converts your typed route back to RouteInformation. '
    'Without it, the browser URL bar won\'t update to reflect the current '
    'page — breaking bookmarking and sharing on web.',
  ),
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kRoseDk, _kBluGryDk]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kRose, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('RouterConfig deep visual demo');
  print('─' * 48);
  print('Sections: overview, four pillars, comparison, live routing,');
  print('flow visualisation, back button, patterns, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kRose, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RouterConfig'),
        backgroundColor: _kRoseDk,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _LiveRoutingPage(), _FlowPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kRoseDk,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.route_outlined), label: 'Routing'),
          BottomNavigationBarItem(icon: Icon(Icons.schema_outlined), label: 'Flow'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1 ──
        _sectionHeader('1 · What Is RouterConfig?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('CLASS SIGNATURE'),
              SizedBox(height: 8),
              _mono('class RouterConfig<T> {'),
              _mono('  const RouterConfig({'),
              _mono('    required this.routeInformationProvider,'),
              _mono('    required this.routeInformationParser,'),
              _mono('    required this.routerDelegate,'),
              _mono('    this.backButtonDispatcher,'),
              _mono('  });'),
              _mono('}'),
              SizedBox(height: 8),
              _bullet('Generic type T is your route configuration type.'),
              _bullet('All four are supplied to the Router widget internally.'),
              _bullet('backButtonDispatcher defaults to RootBackButtonDispatcher.'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 2 ──
        _sectionHeader('2 · The Four Pillars', Icons.account_tree_outlined),
        SizedBox(height: 8),
        ..._kPillars.asMap().entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                        color: _kRose.withOpacity(0.15), shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Text('${e.key + 1}',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: _kRoseDk)),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.value.name,
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _kRoseDk)),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              color: _kBluGryLt, borderRadius: BorderRadius.circular(4)),
                          child: Text(e.value.key,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 10,
                                  color: _kBluGryDk, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(e.value.role,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: _kBluGry)),
              SizedBox(height: 4),
              Text(e.value.detail,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3 ──
        _sectionHeader('3 · RouterConfig vs Navigator', Icons.compare_arrows),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('COMPARISON TABLE'),
              SizedBox(height: 8),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1.4),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                border: TableBorder.all(color: _kDivider, width: 0.5),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: _kRoseLt),
                    children: ['Feature', 'Router / Config', 'Navigator'].map((h) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(h, style: TextStyle(fontWeight: FontWeight.w700,
                          fontSize: 10.5, color: _kRoseDk)),
                    )).toList(),
                  ),
                  ..._kComparison.map((r) => TableRow(
                    children: [r.feature, r.router, r.navigator].map((c) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(c, style: TextStyle(fontSize: 10.5, color: _kTextDark)),
                    )).toList(),
                  )),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 6 ──
        _sectionHeader('6 · BackButtonDispatcher', Icons.arrow_back),
        SizedBox(height: 8),
        ..._kBackButtonRows.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: _kBluGryLt, borderRadius: BorderRadius.circular(5)),
                child: Text(e.key,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        fontSize: 12, color: _kBluGryDk)),
              ),
              SizedBox(height: 6),
              Text(e.value,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 7 ──
        _sectionHeader('7 · Common Patterns', Icons.pattern),
        SizedBox(height: 8),
        ..._kPatterns.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _kRoseDk)),
              SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _kDivider),
                ),
                child: _mono(p.code),
              ),
              SizedBox(height: 6),
              Text(p.desc,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 8 ──
        _sectionHeader('8 · Best Practices', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kBestPractices.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kRose, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(p.tip,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,
                            color: _kRoseDk)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(p.detail,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Live declarative routing simulation
// ═══════════════════════════════════════════════════════════

/// Simple enum-based route for demonstration.
enum _DemoRoute { home, products, productDetail, settings, notFound }

class _LiveRoutingPage extends StatefulWidget {
  @override
  State<_LiveRoutingPage> createState() => _LiveRoutingPageState();
}

class _LiveRoutingPageState extends State<_LiveRoutingPage> {
  _DemoRoute _currentRoute = _DemoRoute.home;
  int? _selectedProductId;
  final List<String> _navigationLog = [];

  void _navigate(_DemoRoute route, {int? productId}) {
    final previous = _currentRoute;
    setState(() {
      _currentRoute = route;
      _selectedProductId = productId;
      _navigationLog.insert(0,
          '${_currentRoute.name}${productId != null ? '/$productId' : ''} (from ${previous.name})');
      if (_navigationLog.length > 20) _navigationLog.removeLast();
    });
    print('[Router] navigate → ${route.name}${productId != null ? '/$productId' : ''}');
  }

  /// Simulates what we'd return from restoreRouteInformation
  String get _simulatedUrl {
    switch (_currentRoute) {
      case _DemoRoute.home: return '/';
      case _DemoRoute.products: return '/products';
      case _DemoRoute.productDetail: return '/products/$_selectedProductId';
      case _DemoRoute.settings: return '/settings';
      case _DemoRoute.notFound: return '/404';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // URL bar simulation
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: _kBluGryDk,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SIMULATED ROUTER STATE',
                  style: TextStyle(color: Colors.white54, fontSize: 10,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lock_outline, color: Colors.white54, size: 14),
                    SizedBox(width: 8),
                    Text('myapp.com$_simulatedUrl',
                        style: TextStyle(fontFamily: 'monospace', fontSize: 13,
                            color: _kRose, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kRose.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                      child: Text(_currentRoute.name,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10,
                              color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Navigation buttons
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          color: _kBluGryDk.withOpacity(0.85),
          child: Wrap(
            spacing: 6, runSpacing: 4,
            children: [
              _navButton('/ Home', _DemoRoute.home),
              _navButton('/products', _DemoRoute.products),
              _navButton('/products/1', _DemoRoute.productDetail, productId: 1),
              _navButton('/products/42', _DemoRoute.productDetail, productId: 42),
              _navButton('/settings', _DemoRoute.settings),
              _navButton('/xyz (404)', _DemoRoute.notFound),
            ],
          ),
        ),
        // Page content
        Expanded(
          child: Row(
            children: [
              // Active page
              Expanded(
                flex: 3,
                child: _buildCurrentPage(),
              ),
              // Navigation log
              Container(
                width: 1, color: _kDivider),
              Expanded(
                flex: 2,
                child: Container(
                  color: Color(0xFFF5F5F5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        color: _kBluGryLt,
                        child: Text('NAVIGATION LOG',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                                color: _kBluGryDk, letterSpacing: 0.5)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          itemCount: _navigationLog.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${i + 1}.',
                                      style: TextStyle(fontFamily: 'monospace', fontSize: 9,
                                          color: _kTextMuted)),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(_navigationLog[i],
                                        style: TextStyle(fontFamily: 'monospace', fontSize: 9.5,
                                            color: _kTextDark, height: 1.3)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _navButton(String label, _DemoRoute route, {int? productId}) {
    final isActive = _currentRoute == route &&
        (productId == null || productId == _selectedProductId);
    return GestureDetector(
      onTap: () => _navigate(route, productId: productId),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? _kRose.withOpacity(0.3) : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isActive ? _kRose : Colors.white24),
        ),
        child: Text(label,
            style: TextStyle(fontFamily: 'monospace', fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.white70)),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentRoute) {
      case _DemoRoute.home:
        return _routePage(Icons.home, 'Home', 'Welcome! This is the root page.',
            _kRose.withOpacity(0.08));
      case _DemoRoute.products:
        return _routePage(Icons.shopping_bag, 'Products', 'Browse all products.\n'
            'Tap a product button above to navigate.',
            _kBluGry.withOpacity(0.06));
      case _DemoRoute.productDetail:
        return _routePage(Icons.inventory_2, 'Product #$_selectedProductId',
            'Detail page for product $_selectedProductId.\n'
            'The parser extracts the ID from the path segment.',
            _kRose.withOpacity(0.05));
      case _DemoRoute.settings:
        return _routePage(Icons.settings, 'Settings', 'App settings page.\n'
            'A simple leaf route with no parameters.',
            _kBluGry.withOpacity(0.04));
      case _DemoRoute.notFound:
        return _routePage(Icons.error_outline, '404 Not Found',
            'Unknown route! The parser returned notFound.\n'
            'A good parser always handles unknown paths gracefully.',
            Colors.red.withOpacity(0.06));
    }
  }

  Widget _routePage(IconData icon, String title, String desc, Color bg) {
    return Container(
      color: bg,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: _kRoseDk.withOpacity(0.6)),
          SizedBox(height: 12),
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _kRoseDk)),
          SizedBox(height: 8),
          Text(desc, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4)),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kBluGryLt, borderRadius: BorderRadius.circular(6)),
            child: Text('URL: $_simulatedUrl',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: _kBluGryDk)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Route parsing flow visualisation
// ═══════════════════════════════════════════════════════════
class _FlowPage extends StatefulWidget {
  @override
  State<_FlowPage> createState() => _FlowPageState();
}

class _FlowPageState extends State<_FlowPage> {
  int _activeStage = 0;

  static const _stages = <_FlowStage>[
    _FlowStage(
      'Platform Event',
      'A URL change arrives — deep-link, browser navigation, or initial launch.',
      Icons.language,
    ),
    _FlowStage(
      'RouteInformationProvider',
      'PlatformRouteInformationProvider wraps the URL into a RouteInformation '
      'object and notifies the Router.',
      Icons.input,
    ),
    _FlowStage(
      'RouteInformationParser',
      'parseRouteInformation(info) converts the RouteInformation into your '
      'typed route configuration T asynchronously.',
      Icons.transform,
    ),
    _FlowStage(
      'RouterDelegate',
      'setNewRoutePath(T) receives the parsed configuration. The delegate '
      'updates its internal state and calls notifyListeners().',
      Icons.build_circle_outlined,
    ),
    _FlowStage(
      'Navigator Rebuild',
      'The delegate\'s build() method returns a new Navigator with an updated '
      'pages list. Flutter diffs the pages and transitions to the new screen.',
      Icons.widgets_outlined,
    ),
    _FlowStage(
      'URL Update (reverse)',
      'When the delegate\'s currentConfiguration changes, the Router calls '
      'restoreRouteInformation(T) on the parser, then passes the result back '
      'to the provider to update the browser URL.',
      Icons.sync_alt,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          color: _kRoseDk,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ROUTE PARSING FLOW',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('Tap each stage to see how a URL travels through the Router system.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5, height: 1.3)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _stages.length,
            itemBuilder: (context, i) {
              final stage = _stages[i];
              final isActive = i == _activeStage;
              final isPast = i < _activeStage;
              return GestureDetector(
                onTap: () => setState(() => _activeStage = i),
                child: Column(
                  children: [
                    // Connector line
                    if (i > 0)
                      Container(
                        width: 2, height: 24,
                        color: isPast ? _kRose : _kDivider,
                      ),
                    // Stage card
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.all(isActive ? 16 : 12),
                      decoration: BoxDecoration(
                        color: isActive ? _kRoseLt : Colors.white,
                        borderRadius: BorderRadius.circular(isActive ? 14 : 10),
                        border: Border.all(
                          color: isActive ? _kRose : (isPast ? _kRose.withOpacity(0.3) : _kDivider),
                          width: isActive ? 2 : 1,
                        ),
                        boxShadow: isActive ? [
                          BoxShadow(color: _kRose.withOpacity(0.15), blurRadius: 12, offset: Offset(0, 4)),
                        ] : [],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: isActive ? _kRose : (isPast ? _kRose.withOpacity(0.2) : _kBluGryLt),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: isPast && !isActive
                                ? Icon(Icons.check, color: _kRose, size: 20)
                                : Icon(stage.icon, color: isActive ? Colors.white : _kBluGry, size: 20),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('${i + 1}. ',
                                        style: TextStyle(fontWeight: FontWeight.w800,
                                            fontSize: 13, color: isActive ? _kRoseDk : _kTextMuted)),
                                    Expanded(
                                      child: Text(stage.title,
                                          style: TextStyle(fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: isActive ? _kRoseDk : _kTextDark)),
                                    ),
                                  ],
                                ),
                                if (isActive) ...[
                                  SizedBox(height: 6),
                                  Text(stage.description,
                                      style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.4)),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Stage navigation
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: _kBluGryLt,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: _activeStage > 0
                    ? () => setState(() => _activeStage--)
                    : null,
                icon: Icon(Icons.arrow_back, size: 16),
                label: Text('Previous'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: _kBluGry, foregroundColor: Colors.white),
              ),
              Text('Stage ${_activeStage + 1} of ${_stages.length}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: _kBluGryDk)),
              ElevatedButton.icon(
                onPressed: _activeStage < _stages.length - 1
                    ? () => setState(() => _activeStage++)
                    : null,
                icon: Icon(Icons.arrow_forward, size: 16),
                label: Text('Next'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: _kRoseDk, foregroundColor: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlowStage {
  const _FlowStage(this.title, this.description, this.icon);
  final String title;
  final String description;
  final IconData icon;
}
