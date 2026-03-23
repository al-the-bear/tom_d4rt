// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialApp widget from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialApp test executing');

  // Test basic MaterialApp
  final basicApp = MaterialApp(
    home: Scaffold(body: Center(child: Text('Basic MaterialApp'))),
  );
  print('Basic MaterialApp with home created');

  // Test MaterialApp with title
  final withTitle = MaterialApp(
    title: 'My App Title',
    home: Scaffold(body: Center(child: Text('With Title'))),
  );
  print('MaterialApp with title created');

  // Test MaterialApp with theme
  final withTheme = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
    home: Scaffold(body: Center(child: Text('With Theme'))),
  );
  print('MaterialApp with light theme created');

  // Test MaterialApp with darkTheme
  final withDarkTheme = MaterialApp(
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.dark,
    home: Scaffold(body: Center(child: Text('With Dark Theme'))),
  );
  print('MaterialApp with dark theme created');

  // Test MaterialApp with themeMode
  print('ThemeMode.system - follows system setting');
  print('ThemeMode.light - always light theme');
  print('ThemeMode.dark - always dark theme');

  // Test MaterialApp with routes
  final withRoutes = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Scaffold(body: Center(child: Text('Home'))),
      '/second': (context) => Scaffold(body: Center(child: Text('Second'))),
      '/third': (context) => Scaffold(body: Center(child: Text('Third'))),
    },
  );
  print('MaterialApp with named routes created');

  // Test MaterialApp with onGenerateRoute
  final withGenerateRoute = MaterialApp(
    onGenerateRoute: (settings) {
      print('onGenerateRoute for: ${settings.name}');
      if (settings.name == '/details') {
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text('Details: ${args?["id"]}'))),
        );
      }
      return MaterialPageRoute(
        builder: (context) => Scaffold(body: Center(child: Text('Unknown'))),
      );
    },
    initialRoute: '/',
  );
  print('MaterialApp with onGenerateRoute created');

  // Test MaterialApp with onUnknownRoute
  final withUnknownRoute = MaterialApp(
    onUnknownRoute: (settings) {
      print('Unknown route: ${settings.name}');
      return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text('404 - Not Found'))),
      );
    },
    home: Scaffold(body: Center(child: Text('Home'))),
  );
  print('MaterialApp with onUnknownRoute created');

  // Test MaterialApp with navigatorKey
  final navigatorKey = GlobalKey<NavigatorState>();
  final withNavKey = MaterialApp(
    navigatorKey: navigatorKey,
    home: Scaffold(body: Center(child: Text('With Navigator Key'))),
  );
  print('MaterialApp with navigatorKey created');

  // Test MaterialApp with navigatorObservers
  final withObservers = MaterialApp(
    navigatorObservers: [NavigatorObserver()],
    home: Scaffold(body: Center(child: Text('With Observers'))),
  );
  print('MaterialApp with navigatorObservers created');

  // Test MaterialApp with debugShowCheckedModeBanner
  final noBanner = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: Center(child: Text('No Debug Banner'))),
  );
  print('MaterialApp with debugShowCheckedModeBanner=false created');

  // Test MaterialApp with locale
  final withLocale = MaterialApp(
    locale: Locale('en', 'US'),
    home: Scaffold(body: Center(child: Text('English US'))),
  );
  print('MaterialApp with locale=en_US created');

  // Test MaterialApp with localizationsDelegates
  print('MaterialApp.localizationsDelegates for internationalization');

  // Test MaterialApp with supportedLocales
  final withSupportedLocales = MaterialApp(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('es', 'ES'),
      Locale('de', 'DE'),
    ],
    home: Scaffold(body: Center(child: Text('Multi-locale'))),
  );
  print('MaterialApp with supportedLocales created');

  // Test MaterialApp with builder
  final withBuilder = MaterialApp(
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
        child: child!,
      );
    },
    home: Scaffold(body: Center(child: Text('With Builder'))),
  );
  print('MaterialApp with builder created');

  // Test MaterialApp with scrollBehavior
  final withScrollBehavior = MaterialApp(
    scrollBehavior: MaterialScrollBehavior(),
    home: Scaffold(body: Center(child: Text('Custom Scroll'))),
  );
  print('MaterialApp with scrollBehavior created');

  // Test MaterialApp with shortcuts
  print('MaterialApp.shortcuts for keyboard shortcuts');

  // Test MaterialApp with actions
  print('MaterialApp.actions for action intents');

  // Test MaterialApp with restorationScopeId
  final withRestoration = MaterialApp(
    restorationScopeId: 'root',
    home: Scaffold(body: Center(child: Text('With Restoration'))),
  );
  print('MaterialApp with restorationScopeId created');

  // Test MaterialApp.router
  print('MaterialApp.router for Router-based navigation');

  // Test showAboutDialog
  print('showAboutDialog() for about dialog');

  // Test showDatePicker
  print('showDatePicker() for date selection');

  // Test showTimePicker
  print('showTimePicker() for time selection');

  // Test showModalBottomSheet
  print('showModalBottomSheet() for bottom sheets');

  // Test showDialog
  print('showDialog() for dialogs');

  print('MaterialApp test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialApp Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Theme Support:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• theme - light theme'),
        Text('• darkTheme - dark theme'),
        Text('• themeMode - system/light/dark'),
        Text('• highContrastTheme - accessibility'),
        SizedBox(height: 16.0),

        Text('Navigation:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• home - initial widget'),
        Text('• initialRoute - initial route name'),
        Text('• routes - named route map'),
        Text('• onGenerateRoute - dynamic routes'),
        Text('• onUnknownRoute - 404 handler'),
        Text('• navigatorKey - external nav access'),
        Text('• navigatorObservers - route observers'),
        SizedBox(height: 16.0),

        Text('Localization:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• locale - current locale'),
        Text('• localizationsDelegates - l10n delegates'),
        Text('• supportedLocales - available locales'),
        Text('• localeListResolutionCallback'),
        Text('• localeResolutionCallback'),
        SizedBox(height: 16.0),

        Text('Configuration:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• title - app title'),
        Text('• color - app color'),
        Text('• debugShowCheckedModeBanner - debug banner'),
        Text('• showPerformanceOverlay - performance'),
        Text('• showSemanticsDebugger - semantics'),
        Text('• builder - widget wrapper'),
        Text('• scrollBehavior - scroll physics'),
        SizedBox(height: 16.0),

        Text(
          'Embedded App Demo:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 200.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: basicApp,
        ),
      ],
    ),
  );
}
