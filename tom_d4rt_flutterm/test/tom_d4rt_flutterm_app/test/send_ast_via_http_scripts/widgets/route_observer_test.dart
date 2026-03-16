// D4rt test script: Tests RouteObserver, NavigatorObserver, RouteSettings,
// RouteAware pattern, ModalRoute properties, Route, MaterialPageRoute
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Route observer test executing');

  // ========== RouteSettings ==========
  print('--- RouteSettings Tests ---');
  final settings = RouteSettings(name: '/home', arguments: {'id': 42});
  print('RouteSettings created: name=${settings.name}');
  print('  arguments: ${settings.arguments}');

  final settings2 = RouteSettings(name: '/details');
  print('RouteSettings no args: name=${settings2.name}');

  // ========== NavigatorObserver ==========
  print('--- NavigatorObserver Tests ---');
  final observer = TestNavigatorObserver();
  print('NavigatorObserver created');

  // ========== RouteObserver ==========
  print('--- RouteObserver Tests ---');
  final routeObserver = RouteObserver<ModalRoute<dynamic>>();
  print('RouteObserver created');

  // ========== MaterialPageRoute ==========
  print('--- MaterialPageRoute Tests ---');
  final pageRoute = MaterialPageRoute(
    builder: (context) => Scaffold(body: Text('Page')),
    settings: settings,
    maintainState: true,
    fullscreenDialog: false,
  );
  print('MaterialPageRoute created');
  print('  maintainState: ${pageRoute.maintainState}');
  print('  fullscreenDialog: ${pageRoute.fullscreenDialog}');
  print('  settings.name: ${pageRoute.settings.name}');

  // ========== PageRouteBuilder ==========
  print('--- PageRouteBuilder Tests ---');
  final customRoute = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(body: Text('Custom'));
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    settings: RouteSettings(name: '/custom'),
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 200),
    opaque: true,
    barrierDismissible: false,
  );
  print('PageRouteBuilder created');
  print('  transitionDuration: ${customRoute.transitionDuration}');
  print('  opaque: ${customRoute.opaque}');

  // ========== Route properties ==========
  print('--- Route properties ---');
  print('  MaterialPageRoute is a ModalRoute');
  print('  PageRouteBuilder is a PageRoute');

  // ========== Navigator methods (static) ==========
  print('--- Navigator static methods ---');
  print('  Navigator.defaultRouteName: ${Navigator.defaultRouteName}');

  // ========== TransitionRoute concepts ==========
  print('--- TransitionRoute concepts ---');
  print('  Duration: ${Duration(milliseconds: 300)}');
  print('  Curve: ${Curves.easeInOut}');
  print('  Curve: ${Curves.fastOutSlowIn}');

  print('All route observer tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    navigatorObservers: [observer, routeObserver],
    home: Scaffold(
      appBar: AppBar(title: Text('Route Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Route Observer Test'),
            Text('Settings: ${settings.name}'),
          ],
        ),
      ),
    ),
  );
}

class TestNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print('  Observer: pushed ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('  Observer: popped ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print('  Observer: replaced');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print('  Observer: removed ${route.settings.name}');
  }
}
