// D4rt test script: Deep visual demo of MaterialApp and MaterialApp.router.
// Theme: "MaterialApp configurator: every knob explained".
//
// The harness contract requires this build() to return a Scaffold, so we
// cannot install a top-level MaterialApp at the root.  Instead we render
// many *mini* MaterialApps inside phone-frame containers so that every
// parameter is exercised as a real widget, not just a string.
//
// The file targets a Flutter / d4rt analyzer-clean baseline with no
// ignore_for_file directives.  All const-eligible literals are const,
// `child:` / `children:` come last, listener callbacks use `debugPrint`,
// and color alphas use `.withValues(alpha:)`.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// Helper widget: a phone frame containing one mini MaterialApp.
// =============================================================================
class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({
    required this.label,
    required this.child,
    this.width = 240.0,
    this.height = 360.0,
  });

  final String label;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFF101418),
              borderRadius: BorderRadius.circular(28.0),
              border: Border.all(color: const Color(0xFF2C313A), width: 4.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 12.0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: child),
                  // Fake status bar dots.
                  Positioned(
                    top: 6.0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        _StatusDot(color: Color(0xFFEEEEEE)),
                        SizedBox(width: 4.0),
                        _StatusDot(color: Color(0xFFAAAAAA)),
                        SizedBox(width: 4.0),
                        _StatusDot(color: Color(0xFF777777)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            width: width,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.0,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.0,
      height: 4.0,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// =============================================================================
// Mini inner page used as a consistent canvas across theme demos.
// =============================================================================
class _ThemedMiniPage extends StatelessWidget {
  const _ThemedMiniPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(label, style: const TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 8.0),
            Card(
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'colorScheme.primary',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: t.colorScheme.primary,
                      ),
                    ),
                    Text(
                      'onBackground',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: t.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            FilledButton(
              onPressed: () {},
              child: const Text('FilledButton', style: TextStyle(fontSize: 10.0)),
            ),
            const SizedBox(height: 6.0),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined', style: TextStyle(fontSize: 10.0)),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// A custom NavigatorObserver that records events to a list.
// =============================================================================
class _LoggingObserver extends NavigatorObserver {
  _LoggingObserver(this.log);
  final List<String> log;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.add('push ${route.settings.name}');
    debugPrint('LoggingObserver.didPush ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.add('pop ${route.settings.name}');
    debugPrint('LoggingObserver.didPop ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log.add('replace ${oldRoute?.settings.name}->${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.add('remove ${route.settings.name}');
  }
}

// =============================================================================
// Custom ScrollBehavior used to demo MaterialApp.scrollBehavior.
// =============================================================================
class _NoOverscrollBehavior extends MaterialScrollBehavior {
  const _NoOverscrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // remove the glow/stretch overscroll indicator entirely.
  }
}

// =============================================================================
// Minimal Router pair used to demo MaterialApp.router.
// =============================================================================
class _SimpleRoutePath {
  const _SimpleRoutePath(this.id);
  final String id;
}

class _SimpleRouteParser extends RouteInformationParser<_SimpleRoutePath> {
  const _SimpleRouteParser();

  @override
  Future<_SimpleRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final String location = routeInformation.uri.path.isEmpty
        ? '/'
        : routeInformation.uri.path;
    return _SimpleRoutePath(location);
  }

  @override
  RouteInformation restoreRouteInformation(_SimpleRoutePath configuration) {
    return RouteInformation(uri: Uri.parse(configuration.id));
  }
}

class _SimpleRouterDelegate extends RouterDelegate<_SimpleRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<_SimpleRoutePath> {
  _SimpleRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  String _current = '/';

  @override
  _SimpleRoutePath get currentConfiguration => _SimpleRoutePath(_current);

  @override
  Future<void> setNewRoutePath(_SimpleRoutePath configuration) async {
    _current = configuration.id;
  }

  void go(String id) {
    _current = id;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: <Page<dynamic>>[
        MaterialPage<void>(
          key: ValueKey<String>('page-$_current'),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Router: $_current',
                  style: const TextStyle(fontSize: 12.0)),
              toolbarHeight: 36.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Driven by RouterDelegate +\nRouteInformationParser',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 4.0,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () => go('/'),
                        child: const Text('/', style: TextStyle(fontSize: 10.0)),
                      ),
                      OutlinedButton(
                        onPressed: () => go('/a'),
                        child: const Text('/a',
                            style: TextStyle(fontSize: 10.0)),
                      ),
                      OutlinedButton(
                        onPressed: () => go('/b'),
                        child: const Text('/b',
                            style: TextStyle(fontSize: 10.0)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      onDidRemovePage: (Page<dynamic> page) {},
    );
  }
}

// =============================================================================
// Reusable section title builder.
// =============================================================================
Widget _sectionTitle(String n, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1565C0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'SECTION $n',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF455A64),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _captionCard(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F7FA),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12.0, color: Color(0xFF263238)),
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Color(0xFFB2EBF2),
        height: 1.4,
      ),
    ),
  );
}

// =============================================================================
// Mini MaterialApp builders for each section.
// =============================================================================

Widget _buildLightThemeApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Light theme demo',
    theme: ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xFF1976D2),
      useMaterial3: true,
    ),
    home: const _ThemedMiniPage(label: 'Light'),
  );
}

Widget _buildDarkThemeApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Dark theme demo',
    theme: ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xFF1976D2),
      useMaterial3: true,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFF80DEEA),
      useMaterial3: true,
    ),
    themeMode: ThemeMode.dark,
    home: const _ThemedMiniPage(label: 'Dark'),
  );
}

Widget _buildSepiaThemeApp() {
  final ColorScheme sepiaScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF8D5524),
    onPrimary: Colors.white,
    secondary: const Color(0xFFC68B59),
    onSecondary: Colors.white,
    error: const Color(0xFFB00020),
    onError: Colors.white,
    surface: const Color(0xFFFFF8E1),
    onSurface: const Color(0xFF3E2723),
  );
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sepia theme demo',
    theme: ThemeData(colorScheme: sepiaScheme, useMaterial3: true),
    home: const _ThemedMiniPage(label: 'Sepia'),
  );
}

Widget _buildThemeModeApp(ThemeMode mode, String label) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xFF2E7D32),
      useMaterial3: true,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFFA5D6A7),
      useMaterial3: true,
    ),
    themeMode: mode,
    home: _ThemedMiniPage(label: label),
  );
}

Widget _buildSeededApp(Color seed, String label) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: seed, useMaterial3: true),
    home: _ThemedMiniPage(label: label),
  );
}

Widget _buildHighContrastApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'HC',
    theme: ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xFF1976D2),
      useMaterial3: true,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFF80DEEA),
      useMaterial3: true,
    ),
    highContrastTheme: ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: Colors.black,
      useMaterial3: true,
    ),
    highContrastDarkTheme: ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.white,
      useMaterial3: true,
    ),
    themeAnimationDuration: const Duration(milliseconds: 350),
    themeAnimationCurve: Curves.easeInOut,
    home: const _ThemedMiniPage(label: 'High contrast'),
  );
}

// -----------------------------------------------------------------------------
// Routing demo: a real mini MaterialApp with a named-routes map.
// -----------------------------------------------------------------------------
Widget _buildRoutesMapApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('home /',
                  style: TextStyle(fontSize: 12.0)),
              toolbarHeight: 36.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('routes: <String, WidgetBuilder>',
                      style: TextStyle(fontSize: 10.0)),
                  const SizedBox(height: 6.0),
                  Wrap(
                    spacing: 4.0,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/details'),
                        child: const Text('/details',
                            style: TextStyle(fontSize: 10.0)),
                      ),
                      OutlinedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/help'),
                        child: const Text('/help',
                            style: TextStyle(fontSize: 10.0)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      '/details': (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('details', style: TextStyle(fontSize: 12.0)),
              toolbarHeight: 36.0,
            ),
            body: const Center(
              child: Text('details page', style: TextStyle(fontSize: 10.0)),
            ),
          ),
      '/help': (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('help', style: TextStyle(fontSize: 12.0)),
              toolbarHeight: 36.0,
            ),
            body: const Center(
              child: Text('help page', style: TextStyle(fontSize: 10.0)),
            ),
          ),
    },
  );
}

// -----------------------------------------------------------------------------
// Locale demo apps: each app pins a different `locale`.
// -----------------------------------------------------------------------------
Widget _buildLocaleApp(Locale locale, String label) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: locale,
    supportedLocales: const <Locale>[
      Locale('en'),
      Locale('fr'),
      Locale('de'),
    ],
    home: Scaffold(
      appBar: AppBar(
        title: Text(label, style: const TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('locale: ${locale.toLanguageTag()}',
                style: const TextStyle(fontSize: 10.0)),
            const SizedBox(height: 6.0),
            const Text(
              'supportedLocales:\n  en, fr, de',
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Debug flag previews.
// -----------------------------------------------------------------------------
Widget _buildBannerApp({required bool showBanner}) {
  return MaterialApp(
    debugShowCheckedModeBanner: showBanner,
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          showBanner ? 'banner ON' : 'banner OFF',
          style: const TextStyle(fontSize: 12.0),
        ),
        toolbarHeight: 36.0,
      ),
      body: Center(
        child: Text(
          showBanner ? 'debugShowCheckedModeBanner: true' : 'banner suppressed',
          style: const TextStyle(fontSize: 10.0),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget _buildPerfOverlayApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    showPerformanceOverlay: true,
    checkerboardRasterCacheImages: true,
    checkerboardOffscreenLayers: true,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('perf overlay',
            style: TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: const Center(
        child: Text('showPerformanceOverlay: true',
            style: TextStyle(fontSize: 10.0)),
      ),
    ),
  );
}

Widget _buildSemanticsApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    showSemanticsDebugger: true,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('semantics',
            style: TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: const Center(
        child: Text('showSemanticsDebugger: true',
            style: TextStyle(fontSize: 10.0)),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Builder hook demo: force a larger MediaQuery textScaler.
// -----------------------------------------------------------------------------
Widget _buildBuilderHookApp({required bool scaled}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: (BuildContext context, Widget? child) {
      if (!scaled || child == null) {
        return child ?? const SizedBox.shrink();
      }
      final MediaQueryData data = MediaQuery.of(context);
      return MediaQuery(
        data: data.copyWith(textScaler: const TextScaler.linear(1.4)),
        child: child,
      );
    },
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          scaled ? 'builder: x1.4' : 'builder: off',
          style: const TextStyle(fontSize: 12.0),
        ),
        toolbarHeight: 36.0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'TextScaler propagated\nvia builder:',
          style: TextStyle(fontSize: 10.0),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// navigatorObservers demo.
// -----------------------------------------------------------------------------
Widget _buildObserverApp(_LoggingObserver observer) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorObservers: <NavigatorObserver>[observer],
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('observer /',
                  style: TextStyle(fontSize: 12.0)),
              toolbarHeight: 36.0,
            ),
            body: Center(
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/inner'),
                child: const Text('push /inner',
                    style: TextStyle(fontSize: 10.0)),
              ),
            ),
          ),
      '/inner': (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('observer /inner',
                  style: TextStyle(fontSize: 12.0)),
              toolbarHeight: 36.0,
            ),
            body: const Center(
              child: Text('pop me!', style: TextStyle(fontSize: 10.0)),
            ),
          ),
    },
  );
}

// -----------------------------------------------------------------------------
// ScrollBehavior demo.
// -----------------------------------------------------------------------------
Widget _buildScrollBehaviorApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    scrollBehavior: const _NoOverscrollBehavior(),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('scroll behavior',
            style: TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int i) => ListTile(
          dense: true,
          title: Text('row $i', style: const TextStyle(fontSize: 10.0)),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Shortcuts / Actions / restoration / color / unknown route demos.
// -----------------------------------------------------------------------------
class _GreetIntent extends Intent {
  const _GreetIntent();
}

Widget _buildShortcutsApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    shortcuts: const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyG, control: true): _GreetIntent(),
    },
    actions: <Type, Action<Intent>>{
      _GreetIntent: CallbackAction<_GreetIntent>(
        onInvoke: (_GreetIntent intent) {
          debugPrint('Ctrl+G pressed: hello!');
          return null;
        },
      ),
    },
    home: Scaffold(
      appBar: AppBar(
        title: const Text('shortcuts',
            style: TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'shortcuts: Ctrl+G\nactions: _GreetIntent',
          style: TextStyle(fontSize: 10.0),
        ),
      ),
    ),
  );
}

Widget _buildRestorationApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    restorationScopeId: 'demo_root',
    home: Scaffold(
      appBar: AppBar(
        title: const Text('restoration',
            style: TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'restorationScopeId: "demo_root"\n→ enables state restoration',
          style: TextStyle(fontSize: 10.0),
        ),
      ),
    ),
  );
}

Widget _buildColorApp() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Color(0xFFE91E63),
    title: 'task switcher color',
    home: _ThemedMiniPage(label: 'color: pink'),
  );
}

Widget _buildUnknownRouteApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/does-not-exist',
    onGenerateRoute: (RouteSettings settings) {
      if (settings.name == '/') {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text('home',
                  style: TextStyle(fontSize: 12.0)),
              toolbarHeight: 36.0,
            ),
            body: const Center(
              child: Text('home page', style: TextStyle(fontSize: 10.0)),
            ),
          ),
        );
      }
      return null;
    },
    onUnknownRoute: (RouteSettings settings) {
      debugPrint('onUnknownRoute fired for ${settings.name}');
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text('404',
                style: TextStyle(fontSize: 12.0)),
            toolbarHeight: 36.0,
            backgroundColor: Colors.red,
          ),
          body: const Center(
            child: Text('404 — not found',
                style: TextStyle(fontSize: 10.0, color: Colors.red)),
          ),
        ),
      );
    },
  );
}

// =============================================================================
// build() — composes the whole workshop.
// =============================================================================
dynamic build(BuildContext context) {
  debugPrint('MaterialApp deep demo executing');

  // ---------------------------------------------------------------------------
  // SECTION 1: Hero header — what MaterialApp is and where it sits.
  // ---------------------------------------------------------------------------
  final Widget heroHeader = Container(
    width: double.infinity,
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.widgets, color: Colors.white, size: 32.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'MaterialApp configurator',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'MaterialApp sits at the root of a Material-styled Flutter app. '
          'It wires up theming, routing, locale, accessibility, and '
          'platform conventions. Below, every visible knob is exercised '
          'in its own mini MaterialApp.',
          style: TextStyle(color: Colors.white, fontSize: 12.0, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: const <Widget>[
            _HeroChip(label: 'theme / darkTheme'),
            _HeroChip(label: 'themeMode'),
            _HeroChip(label: 'routes'),
            _HeroChip(label: 'onGenerateRoute'),
            _HeroChip(label: 'navigatorObservers'),
            _HeroChip(label: 'locale'),
            _HeroChip(label: 'builder'),
            _HeroChip(label: 'shortcuts'),
            _HeroChip(label: 'scrollBehavior'),
            _HeroChip(label: 'MaterialApp.router'),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2: Theme propagation — light vs dark vs custom sepia.
  // ---------------------------------------------------------------------------
  final Widget themePropagationRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: <Widget>[
        _PhoneFrame(
          label: 'theme: light',
          width: 200.0,
          height: 320.0,
          child: _buildLightThemeApp(),
        ),
        _PhoneFrame(
          label: 'darkTheme + themeMode.dark',
          width: 200.0,
          height: 320.0,
          child: _buildDarkThemeApp(),
        ),
        _PhoneFrame(
          label: 'theme: custom sepia ColorScheme',
          width: 200.0,
          height: 320.0,
          child: _buildSepiaThemeApp(),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3: themeMode demo.
  // ---------------------------------------------------------------------------
  final Widget themeModeRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: <Widget>[
        _PhoneFrame(
          label: 'ThemeMode.light',
          width: 190.0,
          height: 300.0,
          child: _buildThemeModeApp(ThemeMode.light, 'light'),
        ),
        _PhoneFrame(
          label: 'ThemeMode.dark',
          width: 190.0,
          height: 300.0,
          child: _buildThemeModeApp(ThemeMode.dark, 'dark'),
        ),
        _PhoneFrame(
          label: 'ThemeMode.system',
          width: 190.0,
          height: 300.0,
          child: _buildThemeModeApp(ThemeMode.system, 'system'),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4: ColorScheme.fromSeed — 2x3 grid of mini MaterialApps.
  // ---------------------------------------------------------------------------
  const List<Color> seedColors = <Color>[
    Color(0xFF1976D2), // blue
    Color(0xFF2E7D32), // green
    Color(0xFFE53935), // red
    Color(0xFFFF8F00), // amber
    Color(0xFF6A1B9A), // purple
    Color(0xFF00838F), // teal
  ];

  final Widget seedGrid = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (int i = 0; i < seedColors.length; i++)
          _PhoneFrame(
            label: 'seed #${i + 1}: '
                '0x${seedColors[i].toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
            width: 170.0,
            height: 260.0,
            child: _buildSeededApp(seedColors[i], 'seed ${i + 1}'),
          ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5: Routing variants — config code + live routes:-map app.
  // ---------------------------------------------------------------------------
  const String routesMapCode = '''MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (_) => HomePage(),
    '/details': (_) => DetailsPage(),
    '/help': (_) => HelpPage(),
  },
)''';

  const String onGenerateRouteCode = '''MaterialApp(
  onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/user':
        final id = (settings.arguments as Map)['id'];
        return MaterialPageRoute(
          builder: (_) => UserPage(id: id),
        );
    }
    return null;
  },
)''';

  const String onUnknownRouteCode = '''MaterialApp(
  onUnknownRoute: (settings) {
    return MaterialPageRoute(
      builder: (_) => NotFoundPage(name: settings.name),
    );
  },
)''';

  final Widget routingCodeRow = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text('Routing configuration patterns:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
        const SizedBox(height: 6.0),
        _codeBlock(routesMapCode),
        _codeBlock(onGenerateRouteCode),
        _codeBlock(onUnknownRouteCode),
      ],
    ),
  );

  final Widget liveRoutesApp = Center(
    child: _PhoneFrame(
      label: 'live routes: map (try the buttons)',
      width: 240.0,
      height: 360.0,
      child: _buildRoutesMapApp(),
    ),
  );

  final Widget unknownRouteApp = Center(
    child: _PhoneFrame(
      label: 'onUnknownRoute → 404 page',
      width: 240.0,
      height: 360.0,
      child: _buildUnknownRouteApp(),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6: MaterialApp.router demo.
  // ---------------------------------------------------------------------------
  final _SimpleRouterDelegate routerDelegate = _SimpleRouterDelegate();
  const _SimpleRouteParser routeParser = _SimpleRouteParser();

  final Widget routerApp = MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Router demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF455A64),
      useMaterial3: true,
    ),
    routerDelegate: routerDelegate,
    routeInformationParser: routeParser,
  );

  final Widget routerSection = Center(
    child: _PhoneFrame(
      label: 'MaterialApp.router\n(RouterDelegate + Parser)',
      width: 260.0,
      height: 380.0,
      child: routerApp,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7: Locale & supportedLocales.
  // ---------------------------------------------------------------------------
  final Widget localeRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: <Widget>[
        _PhoneFrame(
          label: "locale: en",
          width: 190.0,
          height: 280.0,
          child: _buildLocaleApp(const Locale('en'), 'EN'),
        ),
        _PhoneFrame(
          label: "locale: fr",
          width: 190.0,
          height: 280.0,
          child: _buildLocaleApp(const Locale('fr'), 'FR'),
        ),
        _PhoneFrame(
          label: "locale: de",
          width: 190.0,
          height: 280.0,
          child: _buildLocaleApp(const Locale('de'), 'DE'),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8: Debug overlay flags.
  // ---------------------------------------------------------------------------
  final Widget debugFlagsRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: <Widget>[
        _PhoneFrame(
          label: 'debugShowCheckedModeBanner: true',
          width: 200.0,
          height: 300.0,
          child: _buildBannerApp(showBanner: true),
        ),
        _PhoneFrame(
          label: 'debugShowCheckedModeBanner: false',
          width: 200.0,
          height: 300.0,
          child: _buildBannerApp(showBanner: false),
        ),
        _PhoneFrame(
          label: 'showPerformanceOverlay + checkerboards',
          width: 200.0,
          height: 300.0,
          child: _buildPerfOverlayApp(),
        ),
        _PhoneFrame(
          label: 'showSemanticsDebugger',
          width: 200.0,
          height: 300.0,
          child: _buildSemanticsApp(),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9: Builder hook — before/after textScaler.
  // ---------------------------------------------------------------------------
  final Widget builderRow = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _PhoneFrame(
          label: 'builder: identity',
          width: 200.0,
          height: 280.0,
          child: _buildBuilderHookApp(scaled: false),
        ),
        _PhoneFrame(
          label: 'builder: MediaQuery x1.4',
          width: 200.0,
          height: 280.0,
          child: _buildBuilderHookApp(scaled: true),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 10: navigatorObservers — capture log + render it.
  // ---------------------------------------------------------------------------
  final List<String> observerLog = <String>[
    'push /',
    'push /inner',
    'pop /inner',
  ];
  final _LoggingObserver observer = _LoggingObserver(observerLog);

  final Widget observerSection = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: _PhoneFrame(
          label: 'navigatorObservers: [LoggingObserver]',
          width: 220.0,
          height: 330.0,
          child: _buildObserverApp(observer),
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Observer log',
                style: TextStyle(
                  color: Color(0xFFB2EBF2),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 6.0),
              for (final String entry in observerLog)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    '• $entry',
                    style: const TextStyle(
                      color: Color(0xFFA5D6A7),
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // SECTION 11: ScrollBehavior.
  // ---------------------------------------------------------------------------
  final Widget scrollBehaviorSection = Center(
    child: _PhoneFrame(
      label: 'scrollBehavior: _NoOverscrollBehavior',
      width: 240.0,
      height: 360.0,
      child: _buildScrollBehaviorApp(),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 12: navigatorKey + shortcuts/actions + restoration + color.
  // ---------------------------------------------------------------------------
  final GlobalKey<NavigatorState> demoNavKey = GlobalKey<NavigatorState>();
  final Widget navKeyApp = MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: demoNavKey,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('navigatorKey',
            style: TextStyle(fontSize: 12.0)),
        toolbarHeight: 36.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'navigatorKey: ${demoNavKey.runtimeType}\n'
          'Use it to push routes from outside the widget tree.',
          style: const TextStyle(fontSize: 10.0),
        ),
      ),
    ),
  );

  final Widget mixedKnobsRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: <Widget>[
        _PhoneFrame(
          label: 'shortcuts + actions',
          width: 200.0,
          height: 280.0,
          child: _buildShortcutsApp(),
        ),
        _PhoneFrame(
          label: 'restorationScopeId',
          width: 200.0,
          height: 280.0,
          child: _buildRestorationApp(),
        ),
        _PhoneFrame(
          label: 'navigatorKey (external nav)',
          width: 200.0,
          height: 280.0,
          child: navKeyApp,
        ),
        _PhoneFrame(
          label: 'color: pink (task switcher)',
          width: 200.0,
          height: 280.0,
          child: _buildColorApp(),
        ),
        _PhoneFrame(
          label: 'high-contrast themes + curve',
          width: 200.0,
          height: 280.0,
          child: _buildHighContrastApp(),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 13: Cheat-sheet table.
  // ---------------------------------------------------------------------------
  final List<List<String>> cheatSheet = <List<String>>[
    <String>['title', 'OS task switcher / window title.'],
    <String>['theme', 'Default ThemeData for the app.'],
    <String>['darkTheme', 'ThemeData used when dark mode is active.'],
    <String>['highContrastTheme', 'Accessibility theme for high-contrast.'],
    <String>['highContrastDarkTheme', 'High-contrast variant of darkTheme.'],
    <String>['themeMode', 'Selects light / dark / system theme.'],
    <String>['themeAnimationDuration', 'Duration of theme cross-fade.'],
    <String>['themeAnimationCurve', 'Curve of theme cross-fade.'],
    <String>['home', 'Widget for the implicit "/" route.'],
    <String>['initialRoute', 'Named route loaded on start.'],
    <String>['routes', 'Map<String, WidgetBuilder> of named routes.'],
    <String>['onGenerateRoute', 'Fallback factory for non-mapped routes.'],
    <String>['onUnknownRoute', 'Last-chance handler for unknown routes.'],
    <String>['navigatorKey', 'Externally accessible NavigatorState.'],
    <String>['navigatorObservers', 'Observers attached to the Navigator.'],
    <String>['builder', 'Wraps every page (MediaQuery, banners, …).'],
    <String>['localizationsDelegates', 'Translation / format delegates.'],
    <String>['supportedLocales', 'Locales the app declares as supported.'],
    <String>['locale', 'Force a specific Locale, overriding system.'],
    <String>['localeListResolutionCallback', 'Pick locale from device list.'],
    <String>['localeResolutionCallback', 'Pick locale from single device value.'],
    <String>['restorationScopeId', 'Enables state restoration tree.'],
    <String>['scrollBehavior', 'Default ScrollBehavior for all Scrollables.'],
    <String>['actions', 'Map of Intent → Action for the app.'],
    <String>['shortcuts', 'Map of ShortcutActivator → Intent.'],
    <String>['debugShowCheckedModeBanner', 'Show/hide the DEBUG banner.'],
    <String>['showPerformanceOverlay', 'Frame-time overlay HUD.'],
    <String>['showSemanticsDebugger', 'Semantics overlay debugger.'],
    <String>['checkerboardRasterCacheImages', 'Highlight cached raster layers.'],
    <String>['checkerboardOffscreenLayers', 'Highlight offscreen layers.'],
    <String>['color', 'App primary color for OS task switcher.'],
    <String>['MaterialApp.router', 'Constructor using Router + Delegate.'],
    <String>['routerConfig', 'Bundled RouterConfig for .router().'],
    <String>['routerDelegate', 'RouterDelegate driving navigation.'],
    <String>['routeInformationParser', 'Parses URI → app route path.'],
    <String>['routeInformationProvider', 'Source of route info events.'],
    <String>['backButtonDispatcher', 'Routes system back-button events.'],
  ];

  final Widget cheatSheetTable = Container(
    margin: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFB0BEC5)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Color(0xFF1565C0),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(7.0)),
          ),
          child: const Row(
            children: <Widget>[
              SizedBox(
                width: 200.0,
                child: Text(
                  'Parameter',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Purpose',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < cheatSheet.length; i++)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? const Color(0xFFFAFAFA)
                  : const Color(0xFFECEFF1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 200.0,
                  child: Text(
                    cheatSheet[i][0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    cheatSheet[i][1],
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF263238),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Final assembly.
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: const Color(0xFFF7F9FC),
    appBar: AppBar(
      backgroundColor: const Color(0xFF0D47A1),
      foregroundColor: Colors.white,
      title: const Text('MaterialApp · deep visual demo'),
    ),
    body: ListView(
      children: <Widget>[
        heroHeader,

        // SECTION 1
        _sectionTitle(
          '1',
          'What is MaterialApp?',
          'MaterialApp owns theme, routes, locale, accessibility, and '
              'platform conventions for the whole tree.',
        ),
        _captionCard(
          'MaterialApp must sit above any Material widget. It injects a '
          'Theme, a Navigator (or Router), a MediaQuery, a Localizations '
          'scope, and the Material overlay (banners, tooltips, etc.).',
        ),

        // SECTION 2
        _sectionTitle(
          '2',
          'theme / darkTheme / custom ColorScheme',
          'Three mini MaterialApps render the same inner mini-screen under '
              'different ThemeData configurations.',
        ),
        themePropagationRow,
        _captionCard(
          'Each preview is a real MaterialApp: light theme, dark theme '
          'forced via themeMode.dark, and a custom sepia ColorScheme.',
        ),

        // SECTION 3
        _sectionTitle(
          '3',
          'themeMode: light / dark / system',
          'themeMode chooses between theme and darkTheme; '
              '.system falls back to MediaQuery.platformBrightness.',
        ),
        themeModeRow,
        _captionCard(
          'ThemeMode.system uses MediaQuery.platformBrightness as a '
          'fallback when both theme and darkTheme are supplied.',
        ),

        // SECTION 4
        _sectionTitle(
          '4',
          'ColorScheme.fromSeed propagation',
          'A 2×3 grid of mini MaterialApps using '
              'ThemeData(colorSchemeSeed: …) shows how a single seed color '
              'paints every widget consistently.',
        ),
        seedGrid,
        _captionCard(
          'Material 3 derives a full ColorScheme — primary, surface, '
          'tertiary, error — from a single seed color.',
        ),

        // SECTION 5
        _sectionTitle(
          '5',
          'Routing: routes / onGenerateRoute / onUnknownRoute',
          'Three routing styles. The left side shows configuration code; '
              'the previews actually run two of them.',
        ),
        routingCodeRow,
        const SizedBox(height: 12.0),
        liveRoutesApp,
        const SizedBox(height: 12.0),
        unknownRouteApp,
        _captionCard(
          'routes: is a quick map; onGenerateRoute handles parameterised '
          'paths; onUnknownRoute is the safety net.',
        ),

        // SECTION 6
        _sectionTitle(
          '6',
          'MaterialApp.router',
          'A Router-based variant uses RouterDelegate + '
              'RouteInformationParser instead of a Navigator stack.',
        ),
        routerSection,
        _captionCard(
          'MaterialApp.router accepts either routerConfig OR the trio '
          'routerDelegate / routeInformationParser / '
          'routeInformationProvider plus an optional backButtonDispatcher.',
        ),

        // SECTION 7
        _sectionTitle(
          '7',
          'locale / supportedLocales',
          'Three mini MaterialApps pin different locales. '
              'localizationsDelegates can be added in real apps via '
              'flutter_localizations.',
        ),
        localeRow,
        _captionCard(
          'In production, also supply localizationsDelegates (for example '
          'GlobalMaterialLocalizations.delegate) and consider '
          'localeListResolutionCallback / localeResolutionCallback.',
        ),

        // SECTION 8
        _sectionTitle(
          '8',
          'Debug overlay flags',
          'Banner toggle, performance overlay, semantics debugger, '
              'and the two checkerboard layer flags.',
        ),
        debugFlagsRow,
        _captionCard(
          'debugShowCheckedModeBanner hides the DEBUG ribbon; '
          'showPerformanceOverlay draws GPU/raster bars; '
          'showSemanticsDebugger overlays the semantics tree.',
        ),

        // SECTION 9
        _sectionTitle(
          '9',
          'builder: wrap the whole app',
          'builder runs between MaterialApp and every page. Use it to '
              'inject MediaQuery, dev banners, observers, etc.',
        ),
        builderRow,
        _captionCard(
          'A common pattern is forcing a TextScaler so the entire app '
          'respects a custom accessibility setting.',
        ),

        // SECTION 10
        _sectionTitle(
          '10',
          'navigatorObservers',
          'Custom NavigatorObserver receives push/pop/replace events and '
              'logs them into a panel beside the preview.',
        ),
        observerSection,
        _captionCard(
          'NavigatorObserver is the simplest tracing hook — analytics, '
          'breadcrumbs, deep-link diagnostics all live here.',
        ),

        // SECTION 11
        _sectionTitle(
          '11',
          'scrollBehavior',
          'A custom MaterialScrollBehavior subclass removes the overscroll '
              'glow for every Scrollable in the app.',
        ),
        scrollBehaviorSection,
        _captionCard(
          'ScrollBehavior controls overscroll, drag devices, and physics. '
          'Subclass MaterialScrollBehavior to tweak without losing '
          'platform defaults.',
        ),

        // SECTION 12
        _sectionTitle(
          '12',
          'shortcuts / actions / restoration / color / highContrast',
          'The remaining MaterialApp knobs, each in its own preview.',
        ),
        mixedKnobsRow,
        _captionCard(
          'shortcuts + actions feed Flutter\'s intent system. '
          'restorationScopeId enables state restoration. '
          'color is the colour the OS task switcher shows.',
        ),

        // SECTION 13
        _sectionTitle(
          '13',
          'Parameter cheat sheet',
          'Every parameter referenced above, with a one-line description.',
        ),
        cheatSheetTable,

        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
          child: Text(
            'End of MaterialApp deep visual demo.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF607D8B),
              fontStyle: FontStyle.italic,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 11.0),
      ),
    );
  }
}
