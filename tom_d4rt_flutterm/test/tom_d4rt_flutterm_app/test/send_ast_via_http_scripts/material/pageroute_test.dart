// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialPageRoute, RouteSettings, MaterialPage from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialPageRoute/RouteSettings/MaterialPage test executing');

  // ========== ROUTESETTINGS ==========
  print('--- RouteSettings Tests ---');

  // Variation 1: Basic RouteSettings
  final settings1 = RouteSettings(name: '/home');
  print('RouteSettings(name: /home) created');
  print('  name: ${settings1.name}');

  // Variation 2: RouteSettings with arguments
  final settings2 = RouteSettings(name: '/detail', arguments: 'item-42');
  print('RouteSettings(name: /detail, arguments: item-42) created');
  print('  name: ${settings2.name}, arguments: ${settings2.arguments}');

  // Variation 3: RouteSettings with map arguments
  final settings3 = RouteSettings(
    name: '/user',
    arguments: {'id': 123, 'name': 'Alice'},
  );
  print('RouteSettings(name: /user, arguments: map) created');
  print('  arguments: ${settings3.arguments}');

  // Variation 4: RouteSettings with no name
  final settings4 = RouteSettings();
  print('RouteSettings() created');
  print('  name: ${settings4.name}');

  // ========== MATERIALPAGEROUTE ==========
  print('--- MaterialPageRoute Tests ---');

  // Variation 5: Basic MaterialPageRoute
  final route1 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Scaffold(
        appBar: AppBar(title: Text('Route Page')),
        body: Center(child: Text('Hello from route')),
      );
    },
  );
  print('MaterialPageRoute(builder) created');
  print('  runtimeType: ${route1.runtimeType}');

  // Variation 6: MaterialPageRoute with settings
  final route2 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Center(child: Text('Test'));
    },
    settings: RouteSettings(name: '/test'),
  );
  print('MaterialPageRoute(settings: /test) created');
  print('  settings.name: ${route2.settings.name}');

  // Variation 7: MaterialPageRoute with maintainState false
  final route3 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Center(child: Text('No state'));
    },
    maintainState: false,
  );
  print('MaterialPageRoute(maintainState: false) created');
  print('  maintainState: ${route3.maintainState}');

  // Variation 8: MaterialPageRoute with fullscreenDialog
  final route4 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Scaffold(
        appBar: AppBar(title: Text('Dialog Route')),
        body: Center(child: Text('Fullscreen dialog')),
      );
    },
    fullscreenDialog: true,
  );
  print('MaterialPageRoute(fullscreenDialog: true) created');
  print('  fullscreenDialog: ${route4.fullscreenDialog}');

  // Variation 9: MaterialPageRoute with settings and arguments
  final route5 = MaterialPageRoute(
    builder: (BuildContext ctx) {
      return Center(child: Text('Args route'));
    },
    settings: RouteSettings(name: '/args', arguments: [1, 2, 3]),
  );
  print('MaterialPageRoute(settings with arguments) created');
  print('  settings.arguments: ${route5.settings.arguments}');

  // ========== MATERIALPAGE ==========
  print('--- MaterialPage Tests ---');

  // Variation 10: Basic MaterialPage
  final page1 = MaterialPage(
    child: Scaffold(body: Center(child: Text('Material Page'))),
  );
  print('MaterialPage(child: Scaffold) created');
  print('  runtimeType: ${page1.runtimeType}');

  // Variation 11: MaterialPage with key
  final page2 = MaterialPage(
    key: ValueKey('home-page'),
    child: Center(child: Text('Keyed Page')),
  );
  print('MaterialPage(key: home-page) created');
  print('  key: ${page2.key}');

  // Variation 12: MaterialPage with name
  final page3 = MaterialPage(
    name: '/profile',
    child: Center(child: Text('Profile Page')),
  );
  print('MaterialPage(name: /profile) created');
  print('  name: ${page3.name}');

  // Variation 13: MaterialPage with arguments
  final page4 = MaterialPage(
    name: '/item',
    arguments: 'item-99',
    child: Center(child: Text('Item Page')),
  );
  print('MaterialPage(name: /item, arguments: item-99) created');
  print('  arguments: ${page4.arguments}');

  // Variation 14: MaterialPage with maintainState and fullscreenDialog
  final page5 = MaterialPage(
    maintainState: false,
    fullscreenDialog: true,
    child: Scaffold(
      appBar: AppBar(title: Text('FS Dialog Page')),
      body: Center(child: Text('Fullscreen')),
    ),
  );
  print('MaterialPage(maintainState: false, fullscreenDialog: true) created');

  print('MaterialPageRoute/RouteSettings/MaterialPage test completed');
  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialPageRoute tests completed',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('RouteSettings: 4 variations tested'),
        Text('MaterialPageRoute: 5 variations tested'),
        Text('MaterialPage: 5 variations tested'),
        SizedBox(height: 16),
        Text(
          'Note: Routes constructed and inspected without navigation.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}
