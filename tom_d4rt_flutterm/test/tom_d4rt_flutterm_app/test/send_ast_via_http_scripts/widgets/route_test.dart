// D4rt test script: Tests Route, RouteSettings, NavigatorObserver from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Route test executing');

  // Route, ModalRoute, PageRoute, PopupRoute are abstract — cannot instantiate
  print('Route is abstract - cannot instantiate directly');
  print('ModalRoute is abstract - cannot instantiate directly');
  print('PageRoute is abstract - cannot instantiate directly');
  print('PopupRoute is abstract - cannot instantiate directly');

  // Test RouteSettings
  final settings1 = RouteSettings(name: '/test');
  print('RouteSettings(name: /test) created');
  print('RouteSettings name: ${settings1.name}');
  print('RouteSettings arguments: ${settings1.arguments}');

  // Test RouteSettings with arguments
  final settings2 = RouteSettings(
    name: '/detail',
    arguments: {'id': 42, 'title': 'Hello'},
  );
  print(
    'RouteSettings(name: /detail, arguments: {id: 42, title: Hello}) created',
  );
  print('RouteSettings name: ${settings2.name}');
  print('RouteSettings arguments: ${settings2.arguments}');

  // Test RouteSettings with null name
  final settings3 = RouteSettings(arguments: 'simple-string');
  print('RouteSettings(arguments: simple-string) created');
  print('RouteSettings name: ${settings3.name}');
  print('RouteSettings arguments: ${settings3.arguments}');

  // Test NavigatorObserver
  final observer = NavigatorObserver();
  print('NavigatorObserver created');
  print('NavigatorObserver runtimeType: ${observer.runtimeType}');

  // Test MaterialPageRoute (concrete subclass of PageRoute)
  final route1 = MaterialPageRoute(
    builder: (ctx) => Scaffold(
      appBar: AppBar(title: Text('Route Page')),
      body: Center(child: Text('Route content')),
    ),
    settings: RouteSettings(name: '/route-page'),
  );
  print('MaterialPageRoute created with settings /route-page');

  // Test MaterialPageRoute with fullscreenDialog
  final route2 = MaterialPageRoute(
    builder: (ctx) => Scaffold(
      appBar: AppBar(title: Text('Dialog Route')),
      body: Center(child: Text('Fullscreen dialog')),
    ),
    fullscreenDialog: true,
  );
  print('MaterialPageRoute(fullscreenDialog: true) created');

  // Test NavigatorObserver in a MaterialApp
  final observerInstance = NavigatorObserver();
  final appWithObserver = MaterialApp(
    navigatorObservers: [observerInstance],
    home: Scaffold(
      appBar: AppBar(title: Text('Route Test')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Route/RouteSettings/NavigatorObserver tests'),
            SizedBox(height: 8.0),
            Text('RouteSettings: ${settings1.name}'),
            Text(
              'RouteSettings: ${settings2.name} args=${settings2.arguments}',
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              child: Text('Push MaterialPageRoute'),
              onPressed: () {
                print('Would push MaterialPageRoute');
              },
            ),
          ],
        ),
      ),
    ),
  );
  print('MaterialApp with NavigatorObserver created');

  print('Route test completed');
  return appWithObserver;
}
