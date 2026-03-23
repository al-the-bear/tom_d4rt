// ignore_for_file: avoid_print
// D4rt test script: Tests Router concepts — RouterDelegate, RouteInformationParser, RouteInformationProvider from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Router test executing');

  // Router requires RouterDelegate and RouteInformationParser
  // Both are abstract classes and cannot be subclassed in D4rt
  print('RouterDelegate is abstract - cannot subclass in D4rt');
  print('RouteInformationParser is abstract - cannot subclass in D4rt');
  print('RouteInformationProvider is abstract - cannot subclass in D4rt');

  // Router widget is bridged but requires abstract delegate implementations
  print('Router widget requires concrete RouterDelegate implementation');

  // Test RouteInformation
  final routeInfo1 = RouteInformation(uri: Uri.parse('/home'));
  print('RouteInformation(uri: /home) created');
  print('RouteInformation uri: ${routeInfo1.uri}');

  final routeInfo2 = RouteInformation(uri: Uri.parse('/detail/42'));
  print('RouteInformation(uri: /detail/42) created');
  print('RouteInformation uri: ${routeInfo2.uri}');

  final routeInfo3 = RouteInformation(uri: Uri.parse('/settings?theme=dark'));
  print('RouteInformation(uri: /settings?theme=dark) created');
  print('RouteInformation uri: ${routeInfo3.uri}');

  // Test PlatformRouteInformationProvider
  final platformProvider = PlatformRouteInformationProvider(
    initialRouteInformation: RouteInformation(uri: Uri.parse('/initial')),
  );
  print('PlatformRouteInformationProvider created');
  print(
    'PlatformRouteInformationProvider runtimeType: ${platformProvider.runtimeType}',
  );

  // Since we can't create a full Router, demonstrate MaterialApp.router concept
  // MaterialApp.router is the typical way to use Router
  print('MaterialApp.router is the typical usage pattern for Router');
  print('It requires routerDelegate and routeInformationParser');

  // NavigatorObserver can be used with Router
  final observer = NavigatorObserver();
  print('NavigatorObserver created for Router context');
  print('NavigatorObserver runtimeType: ${observer.runtimeType}');

  // BackButtonDispatcher for Router
  final backDispatcher = RootBackButtonDispatcher();
  print('RootBackButtonDispatcher for Router created');

  // Show conceptual info
  final infoWidget = Container(
    padding: EdgeInsets.all(16.0),
    color: Colors.grey,
    width: 300.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Router API (Navigator 2.0):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text('Required components:'),
        Text('  - RouterDelegate (abstract)'),
        Text('  - RouteInformationParser (abstract)'),
        Text('  - RouteInformationProvider'),
        Text('  - BackButtonDispatcher'),
        SizedBox(height: 8.0),
        Text('D4rt limitation:'),
        Text('  Cannot subclass abstract delegates'),
        Text('  Use MaterialApp named routes instead'),
        SizedBox(height: 8.0),
        Text('Bridged types verified:'),
        Text('  RouteInformation: ${routeInfo1.runtimeType}'),
        Text('  RootBackButtonDispatcher: ${backDispatcher.runtimeType}'),
        Text('  NavigatorObserver: ${observer.runtimeType}'),
      ],
    ),
  );

  // Fallback: demonstrate traditional routing as alternative
  final traditionalRouting = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (ctx) => Scaffold(
        appBar: AppBar(title: Text('Router Test - Home')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Traditional routing (alternative to Router API)'),
              SizedBox(height: 8.0),
              ElevatedButton(
                child: Text('Navigate'),
                onPressed: () => print('Would navigate to /detail'),
              ),
            ],
          ),
        ),
      ),
      '/detail': (ctx) => Scaffold(
        appBar: AppBar(title: Text('Detail')),
        body: Center(child: Text('Detail page')),
      ),
    },
    navigatorObservers: [observer],
  );
  print('MaterialApp with traditional routes created as fallback');

  print('Router test completed');
  return traditionalRouting;
}
