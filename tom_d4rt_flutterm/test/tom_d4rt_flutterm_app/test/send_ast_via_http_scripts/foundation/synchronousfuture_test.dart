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
  int? syncResult;
  syncFuture.then((value) {
    syncResult = value;
  });
  print('SynchronousFuture result (synchronous): $syncResult');

  // Test SynchronousFuture with String
  final syncStringFuture = SynchronousFuture<String>('hello');
  String? syncStringResult;
  syncStringFuture.then((value) {
    syncStringResult = value;
  });
  print('SynchronousFuture<String> result: $syncStringResult');

  // Test SynchronousFuture with List
  final syncListFuture = SynchronousFuture<List<int>>([1, 2, 3]);
  List<int>? syncListResult;
  syncListFuture.then((value) {
    syncListResult = value;
  });
  print('SynchronousFuture<List<int>> result: $syncListResult');

  // Test SynchronousFuture with null
  final syncNullFuture = SynchronousFuture<String?>(null);
  String? syncNullResult = 'sentinel';
  syncNullFuture.then((value) {
    syncNullResult = value;
  });
  print('SynchronousFuture<String?>(null) result: $syncNullResult');

  // ========== FACTORY ==========
  print('--- Factory Tests ---');

  // Factory wraps a constructor callback
  final containerFactory = Factory<Container>(() {
    return Container(color: Colors.blue, width: 50.0, height: 50.0);
  });
  print('Factory<Container> created');
  print('Factory type: ${containerFactory.runtimeType}');

  // Call the factory
  final container1 = containerFactory.constructor();
  final container2 = containerFactory.constructor();
  print('Factory produced container1: ${container1.runtimeType}');
  print('Factory produced container2: ${container2.runtimeType}');
  print('Same instance: ${identical(container1, container2)}');

  // Factory with Text
  final textFactory = Factory<Text>(() {
    return Text('Factory-created text');
  });
  print('Factory<Text> created');
  final text = textFactory.constructor();
  print('Factory produced text: ${text.data}');

  print('All foundation misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Foundation Misc Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('SynchronousFuture<int>(42) → $syncResult'),
            SizedBox(height: 4.0),
            Text('SynchronousFuture<String>("hello") → $syncStringResult'),
            SizedBox(height: 4.0),
            Text('Factory produced: ${container1.runtimeType}'),
            SizedBox(height: 4.0),
            text,
          ],
        ),
      ),
    ),
  );
}
