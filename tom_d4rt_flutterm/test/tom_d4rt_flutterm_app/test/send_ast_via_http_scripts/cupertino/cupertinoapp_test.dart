// D4rt test script: Tests CupertinoApp from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoApp test executing');

  // ========== CUPERTINOAPP ==========
  print('--- CupertinoApp Tests ---');

  // Test basic CupertinoApp
  final basicApp = CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Basic App')),
      child: Center(child: Text('Hello Cupertino')),
    ),
  );
  print('Basic CupertinoApp created');

  // Test CupertinoApp with title
  final titledApp = CupertinoApp(
    title: 'My Cupertino App',
    home: Center(child: Text('App with title')),
  );
  print('CupertinoApp with title created');

  // Test CupertinoApp with theme
  final themedApp = CupertinoApp(
    theme: CupertinoThemeData(
      primaryColor: CupertinoColors.systemBlue,
      brightness: Brightness.light,
    ),
    home: Center(child: Text('Themed app')),
  );
  print('CupertinoApp with theme created');

  // Test CupertinoApp with dark theme
  final darkApp = CupertinoApp(
    theme: CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.systemIndigo,
    ),
    home: Center(child: Text('Dark app')),
  );
  print('CupertinoApp with dark theme created');

  // Test CupertinoApp with color
  final coloredApp = CupertinoApp(
    color: CupertinoColors.systemOrange,
    home: Center(child: Text('Colored app')),
  );
  print('CupertinoApp with color created');

  // Test CupertinoApp with localizationsDelegates
  final localizedApp = CupertinoApp(
    localizationsDelegates: [DefaultCupertinoLocalizations.delegate],
    home: Center(child: Text('Localized app')),
  );
  print('CupertinoApp with localizationsDelegates created');

  // Test CupertinoApp with supportedLocales
  final multiLocaleApp = CupertinoApp(
    supportedLocales: [Locale('en', 'US'), Locale('es', 'ES')],
    home: Center(child: Text('Multi-locale app')),
  );
  print('CupertinoApp with supportedLocales created');

  // Test CupertinoApp with debugShowCheckedModeBanner
  final noBannerApp = CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: Center(child: Text('No debug banner')),
  );
  print('CupertinoApp with debugShowCheckedModeBanner=false created');

  // Test CupertinoApp with showPerformanceOverlay
  final perfOverlayApp = CupertinoApp(
    showPerformanceOverlay: false,
    home: Center(child: Text('Performance overlay app')),
  );
  print('CupertinoApp with showPerformanceOverlay created');

  // Test CupertinoApp with showSemanticsDebugger
  final semanticsApp = CupertinoApp(
    showSemanticsDebugger: false,
    home: Center(child: Text('Semantics debugger app')),
  );
  print('CupertinoApp with showSemanticsDebugger created');

  // Test CupertinoApp with routes
  final routedApp = CupertinoApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Center(child: Text('Home')),
      '/second': (context) => Center(child: Text('Second')),
    },
  );
  print('CupertinoApp with routes created');

  // Test CupertinoApp with onGenerateRoute
  final generatedRouteApp = CupertinoApp(
    onGenerateRoute: (settings) {
      return CupertinoPageRoute(
        builder: (context) =>
            Center(child: Text('Generated route: ${settings.name}')),
      );
    },
    initialRoute: '/generated',
  );
  print('CupertinoApp with onGenerateRoute created');

  // Test CupertinoApp with onUnknownRoute
  final unknownRouteApp = CupertinoApp(
    onUnknownRoute: (settings) {
      return CupertinoPageRoute(
        builder: (context) => Center(child: Text('Unknown route')),
      );
    },
    home: Center(child: Text('App with unknown route handler')),
  );
  print('CupertinoApp with onUnknownRoute created');

  // Test CupertinoApp with navigatorKey
  final navigatorKeyApp = CupertinoApp(
    navigatorKey: GlobalKey<NavigatorState>(),
    home: Center(child: Text('App with navigator key')),
  );
  print('CupertinoApp with navigatorKey created');

  // Test CupertinoApp with navigatorObservers
  final observedApp = CupertinoApp(
    navigatorObservers: [],
    home: Center(child: Text('App with observers')),
  );
  print('CupertinoApp with navigatorObservers created');

  // Test CupertinoApp with builder
  final builderApp = CupertinoApp(
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(1.2)),
        child: child!,
      );
    },
    home: Center(child: Text('App with builder')),
  );
  print('CupertinoApp with builder created');

  // Test CupertinoApp with scrollBehavior
  final scrollApp = CupertinoApp(
    scrollBehavior: CupertinoScrollBehavior(),
    home: Center(child: Text('App with scroll behavior')),
  );
  print('CupertinoApp with scrollBehavior created');

  // Test CupertinoApp.router
  // Note: CupertinoApp.router requires RouterConfig
  print('CupertinoApp.router concept noted (requires RouterConfig)');

  print('CupertinoApp test completed');

  // Return a simple widget for rendering
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemBlue,
    ),
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CupertinoApp Test'),
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoApp Test Results',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Tests executed:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('• Basic CupertinoApp'),
              Text('• With title'),
              Text('• With light/dark theme'),
              Text('• With color'),
              Text('• With localization'),
              Text('• With routes'),
              Text('• With navigatorKey'),
              Text('• With builder'),
              Text('• With scrollBehavior'),
              SizedBox(height: 24.0),
              Text(
                'All CupertinoApp tests passed!',
                style: TextStyle(color: CupertinoColors.systemGreen),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
