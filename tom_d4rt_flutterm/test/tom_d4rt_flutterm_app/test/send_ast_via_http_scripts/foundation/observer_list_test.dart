// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ObserverList, HashedObserverList from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObserverList test executing');

  // ========== OBSERVERLIST ==========
  print('--- ObserverList Tests ---');

  // ObserverList allows duplicates (unlike Set) but iterates safely
  final observers = ObserverList<VoidCallback>();
  print('ObserverList created, isEmpty: ${observers.isEmpty}');

  int callCount = 0;
  void callback1() {
    callCount += 1;
  }

  void callback2() {
    callCount += 10;
  }

  void callback3() {
    callCount += 100;
  }

  // Add observers
  observers.add(callback1);
  observers.add(callback2);
  observers.add(callback3);
  print('Added 3 observers');
  print('ObserverList isEmpty: ${observers.isEmpty}');

  // Iterate and call all observers
  for (final observer in observers) {
    observer();
  }
  print('After calling all observers, callCount: $callCount');

  // Add duplicate
  observers.add(callback1);
  print('Added duplicate callback1');

  // Remove one instance of callback1
  final removed = observers.remove(callback1);
  print('Remove callback1: $removed');

  // Contains check
  print('Contains callback1: ${observers.contains(callback1)}');
  print('Contains callback2: ${observers.contains(callback2)}');

  // ========== HASHEDOBSERVERLIST ==========
  print('--- HashedObserverList Tests ---');

  // HashedObserverList prevents duplicates (uses a Set internally)
  final hashedObservers = HashedObserverList<VoidCallback>();
  print('HashedObserverList created, isEmpty: ${hashedObservers.isEmpty}');

  int hashedCount = 0;
  void hCallback1() {
    hashedCount += 1;
  }

  void hCallback2() {
    hashedCount += 10;
  }

  hashedObservers.add(hCallback1);
  hashedObservers.add(hCallback2);
  print('Added 2 hashed observers');
  print('HashedObserverList isEmpty: ${hashedObservers.isEmpty}');

  // Try adding duplicate
  hashedObservers.add(hCallback1);
  print('Added duplicate hCallback1 (should be ignored)');

  // Iterate and call
  for (final observer in hashedObservers) {
    observer();
  }
  print('After calling hashed observers, hashedCount: $hashedCount');

  // Contains check
  print('Hashed contains hCallback1: ${hashedObservers.contains(hCallback1)}');

  // Remove
  final hashedRemoved = hashedObservers.remove(hCallback1);
  print('Hashed remove hCallback1: $hashedRemoved');
  print(
    'Hashed contains hCallback1 after remove: ${hashedObservers.contains(hCallback1)}',
  );

  print('All ObserverList tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ObserverList Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('ObserverList callCount: $callCount'),
            SizedBox(height: 4.0),
            Text('HashedObserverList hashedCount: $hashedCount'),
          ],
        ),
      ),
    ),
  );
}
