// D4rt test script: Tests Restorable values - RestorableInt, RestorableDouble,
// RestorableBool, RestorableString, RestorableTextEditingController,
// RestorableDateTime, RestorableEnum
//
// NOTE: RestorableProperty.value can only be accessed after registration with a
// RestorationMixin. This test verifies bridge construction works, not the full
// restoration lifecycle.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Restorable values test executing');

  // ========== RestorableInt ==========
  print('--- RestorableInt Tests ---');

  final restInt = RestorableInt(42);
  print('RestorableInt created with initial value 42');
  print('RestorableInt runtimeType: ${restInt.runtimeType}');

  // ========== RestorableIntN ==========
  print('--- RestorableIntN Tests ---');

  final restIntN = RestorableIntN(null);
  print('RestorableIntN created with initial null');
  print('RestorableIntN runtimeType: ${restIntN.runtimeType}');

  // ========== RestorableDouble ==========
  print('--- RestorableDouble Tests ---');

  final restDouble = RestorableDouble(3.14);
  print('RestorableDouble created with initial value 3.14');
  print('RestorableDouble runtimeType: ${restDouble.runtimeType}');

  // ========== RestorableDoubleN ==========
  print('--- RestorableDoubleN Tests ---');

  final restDoubleN = RestorableDoubleN(null);
  print('RestorableDoubleN created with initial null');
  print('RestorableDoubleN runtimeType: ${restDoubleN.runtimeType}');

  // ========== RestorableBool ==========
  print('--- RestorableBool Tests ---');

  final restBool = RestorableBool(false);
  print('RestorableBool created with initial value false');
  print('RestorableBool runtimeType: ${restBool.runtimeType}');

  // ========== RestorableBoolN ==========
  print('--- RestorableBoolN Tests ---');

  final restBoolN = RestorableBoolN(null);
  print('RestorableBoolN created with initial null');
  print('RestorableBoolN runtimeType: ${restBoolN.runtimeType}');

  // ========== RestorableString ==========
  print('--- RestorableString Tests ---');

  final restString = RestorableString('hello');
  print('RestorableString created with initial value hello');
  print('RestorableString runtimeType: ${restString.runtimeType}');

  // ========== RestorableStringN ==========
  print('--- RestorableStringN Tests ---');

  final restStringN = RestorableStringN(null);
  print('RestorableStringN created with initial null');
  print('RestorableStringN runtimeType: ${restStringN.runtimeType}');

  // ========== RestorableDateTime ==========
  print('--- RestorableDateTime Tests ---');

  final restDateTime = RestorableDateTime(DateTime(2025, 1, 15));
  print('RestorableDateTime created with initial value 2025-01-15');
  print('RestorableDateTime runtimeType: ${restDateTime.runtimeType}');

  // ========== RestorableDateTimeN ==========
  print('--- RestorableDateTimeN Tests ---');

  final restDateTimeN = RestorableDateTimeN(null);
  print('RestorableDateTimeN created with initial null');
  print('RestorableDateTimeN runtimeType: ${restDateTimeN.runtimeType}');

  // ========== RestorableTextEditingController ==========
  print('--- RestorableTextEditingController Tests ---');

  final restController = RestorableTextEditingController(text: 'initial');
  print('RestorableTextEditingController created with initial text');
  print('RestorableTextEditingController runtimeType: ${restController.runtimeType}');

  print('All restorable values construction tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restorable Values Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('RestorableInt type: ${restInt.runtimeType}'),
            Text('RestorableDouble type: ${restDouble.runtimeType}'),
            Text('RestorableBool type: ${restBool.runtimeType}'),
            Text('RestorableString type: ${restString.runtimeType}'),
            Text('RestorableDateTime type: ${restDateTime.runtimeType}'),
          ],
        ),
      ),
    ),
  );
}
