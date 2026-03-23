// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Navigator widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Navigator test executing');

  // Test Navigator.of to check context access
  try {
    final navigator = Navigator.of(context);
    print('Navigator.of(context) accessed successfully');
    print('Navigator canPop: ${navigator.canPop()}');
  } catch (e) {
    print('Navigator.of(context) - expected in test: $e');
  }

  // Test Navigator with routes using Builder for context
  final navigatorTest = MaterialApp(
    home: Builder(
      builder: (innerContext) {
        return Scaffold(
          appBar: AppBar(title: Text('Navigator Test')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('Push Named Route'),
                  onPressed: () {
                    print('Would push named route /second');
                    // Navigator.pushNamed(innerContext, '/second');
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Push MaterialPageRoute'),
                  onPressed: () {
                    print('Would push MaterialPageRoute');
                    // Navigator.push(innerContext, MaterialPageRoute(
                    //   builder: (_) => SecondPage(),
                    // ));
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Push Replacement'),
                  onPressed: () {
                    print('Would pushReplacement');
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Pop'),
                  onPressed: () {
                    print('Would pop');
                    // Navigator.pop(innerContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
    routes: {
      '/second': (context) => Scaffold(
        appBar: AppBar(title: Text('Second Page')),
        body: Center(child: Text('Second Page Content')),
      ),
      '/third': (context) => Scaffold(
        appBar: AppBar(title: Text('Third Page')),
        body: Center(child: Text('Third Page Content')),
      ),
    },
  );
  print('Navigator with named routes created');

  // Test creating route settings
  final routeSettings = RouteSettings(
    name: '/test-route',
    arguments: {'id': 123, 'name': 'Test'},
  );
  print(
    'RouteSettings created: name=${routeSettings.name}, arguments=${routeSettings.arguments}',
  );

  // Test MaterialPageRoute
  final materialRoute = MaterialPageRoute(
    builder: (context) => Scaffold(body: Center(child: Text('Route Content'))),
    settings: RouteSettings(name: '/material-route'),
    maintainState: true,
    fullscreenDialog: false,
  );
  print('MaterialPageRoute created with settings=/material-route: $materialRoute');

  // Test MaterialPageRoute as fullscreen dialog
  final dialogRoute = MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: Text('Dialog Route')),
      body: Center(child: Text('Fullscreen Dialog')),
    ),
    fullscreenDialog: true,
  );
  print('MaterialPageRoute with fullscreenDialog=true created: $dialogRoute');

  // Test PageRouteBuilder
  final customRoute = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(body: Center(child: Text('Custom Route')));
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 200),
    settings: RouteSettings(name: '/custom'),
  );
  print('PageRouteBuilder with FadeTransition created: $customRoute');

  // Test NavigatorObserver
  final observer = NavigatorObserver();
  print('NavigatorObserver created: $observer');

  // Test Navigator widget with onGenerateRoute
  final generatedRoutes = Navigator(
    pages: const <Page<dynamic>>[],
    transitionDelegate: DefaultTransitionDelegate<dynamic>(),
    routeTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    routeDirectionalTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    onGenerateRoute: (settings) {
      print('onGenerateRoute called for: ${settings.name}');
      if (settings.name == '/') {
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Home'))),
        );
      }
      if (settings.name == '/details') {
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Details: ${args?['id']}'))),
        );
      }
      return null;
    },
    onUnknownRoute: (settings) {
      print('onUnknownRoute called for: ${settings.name}');
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text('404'))),
      );
    },
    initialRoute: '/',
  );
  print('Navigator with onGenerateRoute and onUnknownRoute created: $generatedRoutes');

  // Test Navigator with observers
  final withObservers = Navigator(
    pages: const <Page<dynamic>>[],
    transitionDelegate: DefaultTransitionDelegate<dynamic>(),
    routeTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    routeDirectionalTraversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    observers: [NavigatorObserver()],
    onGenerateRoute: (settings) =>
        MaterialPageRoute(builder: (_) => Center(child: Text('Observed'))),
    initialRoute: '/',
  );
  print('Navigator with observers list created: $withObservers');

  // Test popUntil predicate concept
  bool popUntilPredicate(Route route) {
    return route.settings.name == '/home';
  }

  print('PopUntil predicate function created: $popUntilPredicate');

  // Test canPop concept
  print('Navigator.canPop checks if there is more than one route');

  // Test maybePop concept
  print('Navigator.maybePop pops if possible, returns true if popped');

  // Test pushAndRemoveUntil concept
  print(
    'Navigator.pushAndRemoveUntil pushes and removes routes until predicate',
  );

  // Test popAndPushNamed concept
  print('Navigator.popAndPushNamed pops current and pushes named route');

  // Test restorableState methods
  print('Navigator.restorablePush for state restoration');
  print('Navigator.restorablePushNamed for restorable named routes');

  print('Navigator test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Navigator Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            'Navigator API Tests:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text('• Navigator.of(context) - access navigator'),
          Text('• Navigator.push - push route'),
          Text('• Navigator.pushNamed - push named route'),
          Text('• Navigator.pop - pop route'),
          Text('• Navigator.pushReplacement - replace current'),
          Text('• Navigator.pushAndRemoveUntil - push and clear stack'),
          Text('• Navigator.popUntil - pop until predicate'),
          Text('• Navigator.canPop - check if can pop'),
          Text('• Navigator.maybePop - pop if possible'),
          SizedBox(height: 16.0),
          Text(
            'Route Types:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text('• MaterialPageRoute - standard page route'),
          Text('• PageRouteBuilder - custom transitions'),
          Text('• RouteSettings - route configuration'),
          SizedBox(height: 16.0),
          SizedBox(height: 400.0, child: navigatorTest),
        ],
      ),
    ),
  );
}
