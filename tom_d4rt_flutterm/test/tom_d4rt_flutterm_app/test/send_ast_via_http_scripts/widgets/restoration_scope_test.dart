// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RestorationScope, RootRestorationScope,
// RestorableNum, RestorableNumN, RestorableValue concepts
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorationScope test executing');

  // ========== RestorationScope ==========
  print('--- RestorationScope Tests ---');
  final restorationScope = RestorationScope(
    restorationId: 'test_scope',
    child: Text('Restoration content'),
  );
  print('RestorationScope created with id: test_scope');

  // ========== RootRestorationScope ==========
  print('--- RootRestorationScope Tests ---');
  final rootScope = RootRestorationScope(
    restorationId: 'root_scope',
    child: Text('Root content'),
  );
  print('RootRestorationScope created with id: root_scope');

  // ========== RestorableNum ==========
  print('--- RestorableNum Tests ---');
  final restorableNum = RestorableNum<num>(42);
  print('RestorableNum created with initial value 42');

  final restorableNumN = RestorableNumN<num>(0);
  print('RestorableNumN created with initial value 0');
  // Note: .value getter/setter requires isRegistered (via registerForRestoration)
  print('RestorableNumN initial value: 0');

  // ========== RestorableValue concepts ==========
  print('--- RestorableValue Concepts ---');
  final restInt = RestorableInt(10);
  print('RestorableInt created with value 10');

  final restDouble = RestorableDouble(1.5);
  print('RestorableDouble created with value 1.5');

  final restBool = RestorableBool(false);
  print('RestorableBool created with value false');

  final restString = RestorableString('hello');
  print('RestorableString created with value hello');

  print('All restoration scope tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    restorationScopeId: 'app_restoration',
    home: Scaffold(
      body: RestorationScope(
        restorationId: 'main_scope',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RestorationScope Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text('RestorationScope with id: main_scope'),
              Text('RestorableNum: 42'),
              Text('RestorableInt: 10'),
              Text('RestorableBool: false'),
            ],
          ),
        ),
      ),
    ),
  );
}
