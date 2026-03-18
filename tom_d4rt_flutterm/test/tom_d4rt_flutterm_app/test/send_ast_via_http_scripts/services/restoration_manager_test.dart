// D4rt test script: Tests RestorationManager from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorationManager test executing');

  // RestorationManager is accessed via ServicesBinding
  print('RestorationManager manages app state restoration');
  print('Accessed via: ServicesBinding.instance.restorationManager');

  // Explain restoration concept
  print('\nRestoration concept:');
  print('- App killed by OS (memory pressure)');
  print('- User returns to app');
  print('- State restored from saved data');
  print('- User sees same state as before');

  // RestorationManager responsibilities
  print('\nRestorationManager responsibilities:');
  print('- Communicates with platform');
  print('- Stores/retrieves restoration data');
  print('- Notifies widgets of restoration');
  print('- Manages restoration bucket hierarchy');

  // Using restoration in widgets
  print('\nUsing restoration:');
  print('class MyWidget extends StatefulWidget {');
  print('  final String? restorationId;');
  print('}');
  print('');
  print('class _MyWidgetState extends State<MyWidget>');
  print('    with RestorationMixin {');
  print('  final RestorableInt _counter = RestorableInt(0);');
  print('  ');
  print('  @override');
  print('  String? get restorationId => widget.restorationId;');
  print('  ');
  print('  @override');
  print('  void restoreState(...) {');
  print('    registerForRestoration(_counter, "counter");');
  print('  }');
  print('}');

  // Restorable types
  print('\nRestorable types:');
  print('- RestorableInt, RestorableDouble');
  print('- RestorableString, RestorableBool');
  print('- RestorableDateTime');
  print('- RestorableTextEditingController');
  print('- Custom via RestorableValue');

  print('\nRestorationManager test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorationManager Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('App state restoration'),
      Text('Saves state when app killed'),
      Text('Restores when user returns'),
      Text('Use: RestorationMixin'),
    ],
  );
}
