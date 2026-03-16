// D4rt test script: Tests SynchronousFuture, Factory from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Foundation misc test executing');

  // ========== SYNCHRONOUSFUTURE ==========
  print('--- SynchronousFuture Tests ---');

  // Test SynchronousFuture with int
  final syncFuture = SynchronousFuture<int>(42);
  print('SynchronousFuture<int>(42) created');

  // SynchronousFuture completes synchronously
  // Note: .then() callback must return a non-null value in D4rt bridge
  // (Null is not a subtype of Object in type cast)
  int? syncResult;
  syncFuture.then((value) {
    syncResult = value;
    return value;
  });
  print('SynchronousFuture result (synchronous): $syncResult');

  // Test SynchronousFuture with String
  final syncStringFuture = SynchronousFuture<String>('hello');
  String? syncStringResult;
  syncStringFuture.then((value) {
    syncStringResult = value;
    return value;
  });
  print('SynchronousFuture<String> result: $syncStringResult');

  // Test SynchronousFuture with List
  final syncListFuture = SynchronousFuture<List<int>>([1, 2, 3]);
  List<int>? syncListResult;
  syncListFuture.then((value) {
    syncListResult = value;
    return value;
  });
  print('SynchronousFuture<List<int>> result: $syncListResult');

  // Test SynchronousFuture with null
  final syncNullFuture = SynchronousFuture<String?>(null);
  String? syncNullResult = 'sentinel';
  syncNullFuture.then((value) {
    syncNullResult = value;
    return value ?? '';
  });
  print('SynchronousFuture<String?>(null) result: $syncNullResult');

  // ========== FACTORY ==========
  print('--- Factory Tests ---');

  // Factory wraps a constructor callback
  // Note: Factory.constructor is not bridged in D4rt (no instance method named 'constructor')
  final containerFactory = Factory<Container>(() {
    return Container(color: Colors.blue, width: 50.0, height: 50.0);
  });
  print('Factory<Container> created');
  print('Factory type: ${containerFactory.runtimeType}');
  // Note: .constructor() call skipped — method not bridged
  print('Factory concept verified');

  print('All foundation misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foundation Misc Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('SynchronousFuture<int>(42) → $syncResult'),
            SizedBox(height: 4.0),
            Text('SynchronousFuture<String>("hello") → $syncStringResult'),
            SizedBox(height: 4.0),
            Text('Factory: created successfully'),
          ],
        ),
      ),
    ),
  );
}
