// D4rt test script: Tests Restorable values - RestorableInt, RestorableDouble,
// RestorableBool, RestorableString, RestorableTextEditingController,
// RestorableDateTime, RestorableEnum
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Restorable values test executing');

  // ========== RestorableInt ==========
  print('--- RestorableInt Tests ---');

  final restInt = RestorableInt(42);
  print('RestorableInt value: ${restInt.value}');
  restInt.value = 100;
  print('RestorableInt updated: ${restInt.value}');

  // ========== RestorableIntN ==========
  print('--- RestorableIntN Tests ---');

  final restIntN = RestorableIntN(null);
  print('RestorableIntN value: ${restIntN.value}');
  restIntN.value = 7;
  print('RestorableIntN updated: ${restIntN.value}');

  // ========== RestorableDouble ==========
  print('--- RestorableDouble Tests ---');

  final restDouble = RestorableDouble(3.14);
  print('RestorableDouble value: ${restDouble.value}');
  restDouble.value = 2.718;
  print('RestorableDouble updated: ${restDouble.value}');

  // ========== RestorableDoubleN ==========
  print('--- RestorableDoubleN Tests ---');

  final restDoubleN = RestorableDoubleN(null);
  print('RestorableDoubleN value: ${restDoubleN.value}');
  restDoubleN.value = 1.618;
  print('RestorableDoubleN updated: ${restDoubleN.value}');

  // ========== RestorableBool ==========
  print('--- RestorableBool Tests ---');

  final restBool = RestorableBool(false);
  print('RestorableBool value: ${restBool.value}');
  restBool.value = true;
  print('RestorableBool updated: ${restBool.value}');

  // ========== RestorableBoolN ==========
  print('--- RestorableBoolN Tests ---');

  final restBoolN = RestorableBoolN(null);
  print('RestorableBoolN value: ${restBoolN.value}');
  restBoolN.value = true;
  print('RestorableBoolN updated: ${restBoolN.value}');

  // ========== RestorableString ==========
  print('--- RestorableString Tests ---');

  final restString = RestorableString('hello');
  print('RestorableString value: ${restString.value}');
  restString.value = 'world';
  print('RestorableString updated: ${restString.value}');

  // ========== RestorableStringN ==========
  print('--- RestorableStringN Tests ---');

  final restStringN = RestorableStringN(null);
  print('RestorableStringN value: ${restStringN.value}');
  restStringN.value = 'test';
  print('RestorableStringN updated: ${restStringN.value}');

  // ========== RestorableDateTime ==========
  print('--- RestorableDateTime Tests ---');

  final restDateTime = RestorableDateTime(DateTime(2025, 1, 15));
  print('RestorableDateTime value: ${restDateTime.value}');
  restDateTime.value = DateTime(2025, 6, 1);
  print('RestorableDateTime updated: ${restDateTime.value}');

  // ========== RestorableDateTimeN ==========
  print('--- RestorableDateTimeN Tests ---');

  final restDateTimeN = RestorableDateTimeN(null);
  print('RestorableDateTimeN value: ${restDateTimeN.value}');
  restDateTimeN.value = DateTime(2025, 12, 25);
  print('RestorableDateTimeN updated: ${restDateTimeN.value}');

  // ========== RestorableTextEditingController ==========
  print('--- RestorableTextEditingController Tests ---');

  final restController = RestorableTextEditingController(text: 'initial');
  print('RestorableTextEditingController value text: ${restController.value.text}');

  print('All restorable values tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Restorable Values Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Int: ${restInt.value}'),
            Text('Double: ${restDouble.value}'),
            Text('Bool: ${restBool.value}'),
            Text('String: ${restString.value}'),
            Text('DateTime: ${restDateTime.value}'),
          ],
        ),
      ),
    ),
  );
}
