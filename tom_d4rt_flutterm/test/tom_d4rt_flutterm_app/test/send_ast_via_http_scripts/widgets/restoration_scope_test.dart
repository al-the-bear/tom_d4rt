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
  print('RestorableNum created: ${restorableNum.value}');

  final restorableNumN = RestorableNumN<num>(0);
  print('RestorableNumN created: ${restorableNumN.value}');
  restorableNumN.value = 3.14;
  print('RestorableNumN updated: ${restorableNumN.value}');

  // ========== RestorableValue concepts ==========
  print('--- RestorableValue Concepts ---');
  final restInt = RestorableInt(10);
  print('RestorableInt initial: ${restInt.value}');
  restInt.value = 20;
  print('RestorableInt updated: ${restInt.value}');

  final restDouble = RestorableDouble(1.5);
  print('RestorableDouble initial: ${restDouble.value}');

  final restBool = RestorableBool(false);
  print('RestorableBool initial: ${restBool.value}');
  restBool.value = true;
  print('RestorableBool toggled: ${restBool.value}');

  final restString = RestorableString('hello');
  print('RestorableString initial: ${restString.value}');
  restString.value = 'world';
  print('RestorableString updated: ${restString.value}');

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
              Text('RestorableInt: 10 -> 20'),
              Text('RestorableBool: false -> true'),
            ],
          ),
        ),
      ),
    ),
  );
}
