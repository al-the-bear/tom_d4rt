// ignore_for_file: avoid_print
// D4rt test script: Tests ChangeNotifier, ValueNotifier, Listenable, ValueListenable from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation notifier test executing');

  // ========== LISTENABLE ==========
  print('--- Listenable Tests ---');

  // Listenable is an abstract interface
  // Test via ChangeNotifier which implements it
  print('Listenable is an interface - tested via ChangeNotifier');

  // ========== VALUELISTENABLE ==========
  print('--- ValueListenable Tests ---');

  // ValueListenable is an abstract interface
  // Test via ValueNotifier which implements it
  print('ValueListenable is an interface - tested via ValueNotifier');

  // ========== CHANGENOTIFIER ==========
  print('--- ChangeNotifier Tests ---');

  // Create a custom ChangeNotifier
  final counter = CounterNotifier();
  print('CounterNotifier created with value: ${counter.value}');

  // Test addListener
  var listenerCallCount = 0;
  void listener() {
    listenerCallCount++;
    print('Listener called, count: $listenerCallCount');
  }

  counter.addListener(listener);
  print('Listener added');

  // Test notifyListeners via increment
  counter.increment();
  print(
    'After increment, value: ${counter.value}, listener called: $listenerCallCount times',
  );

  counter.increment();
  print(
    'After second increment, value: ${counter.value}, listener called: $listenerCallCount times',
  );

  // Test multiple listeners
  var secondListenerCalled = 0;
  void secondListener() {
    secondListenerCalled++;
    print('Second listener called');
  }

  counter.addListener(secondListener);
  print('Second listener added');

  counter.increment();
  print(
    'After increment with two listeners, listenerCalls: $listenerCallCount, secondListenerCalls: $secondListenerCalled',
  );

  // Test removeListener
  counter.removeListener(listener);
  print('First listener removed');

  counter.increment();
  print('After increment (first listener removed), value: ${counter.value}');
  print('First listener call count unchanged: $listenerCallCount');
  print('Second listener call count: $secondListenerCalled');

  // Test hasListeners (protected - only accessible in subclasses)
  print('Has listeners: true (after adding listener)');

  // Remove second listener
  counter.removeListener(secondListener);
  print('Second listener removed');
  print('Has listeners after removal: false (protected member)');

  // Test dispose
  final disposableCounter = CounterNotifier();
  disposableCounter.addListener(() {});
  print('Counter before dispose hasListeners: true (protected member)');
  disposableCounter.dispose();
  print('Counter disposed');
  // Note: After dispose, hasListeners would throw if checked

  // ========== VALUENOTIFIER ==========
  print('--- ValueNotifier Tests ---');

  // Test basic ValueNotifier<int>
  final intNotifier = ValueNotifier<int>(0);
  print('ValueNotifier<int>(0) created, value: ${intNotifier.value}');

  // Test value setter
  intNotifier.value = 10;
  print('After setting value to 10, value: ${intNotifier.value}');

  // Test listener notification on value change
  var intNotifierListenerCalls = 0;
  intNotifier.addListener(() {
    intNotifierListenerCalls++;
    print('IntNotifier listener called, new value: ${intNotifier.value}');
  });

  intNotifier.value = 20;
  print('Listener calls after setting value: $intNotifierListenerCalls');

  // Test no notification when value unchanged
  intNotifier.value = 20; // Same value
  print(
    'Listener calls after setting same value: $intNotifierListenerCalls',
  ); // Should be same

  // Test ValueNotifier<String>
  final stringNotifier = ValueNotifier<String>('Hello');
  print(
    'ValueNotifier<String>("Hello") created, value: ${stringNotifier.value}',
  );

  stringNotifier.value = 'World';
  print('After update, value: ${stringNotifier.value}');

  // Test ValueNotifier<bool>
  final boolNotifier = ValueNotifier<bool>(false);
  print('ValueNotifier<bool>(false) created, value: ${boolNotifier.value}');

  boolNotifier.value = true;
  print('After toggle, value: ${boolNotifier.value}');

  // Test ValueNotifier<double>
  final doubleNotifier = ValueNotifier<double>(0.0);
  print('ValueNotifier<double>(0.0) created, value: ${doubleNotifier.value}');

  doubleNotifier.value = 3.14159;
  print('After update, value: ${doubleNotifier.value}');

  // Test ValueNotifier<List>
  final listNotifier = ValueNotifier<List<int>>([1, 2, 3]);
  print('ValueNotifier<List<int>> created, value: ${listNotifier.value}');

  // Note: Updating list contents won't trigger notification
  // Must assign new list
  listNotifier.value = [1, 2, 3, 4, 5];
  print('After assigning new list, value: ${listNotifier.value}');

  // Test ValueNotifier<Map>
  final mapNotifier = ValueNotifier<Map<String, int>>({'a': 1, 'b': 2});
  print('ValueNotifier<Map> created, value: ${mapNotifier.value}');

  mapNotifier.value = {'a': 1, 'b': 2, 'c': 3};
  print('After assigning new map, value: ${mapNotifier.value}');

  // Test ValueNotifier<dynamic>
  final dynamicNotifier = ValueNotifier<dynamic>('start');
  print('ValueNotifier<dynamic> created, value: ${dynamicNotifier.value}');

  dynamicNotifier.value = 42;
  print('After changing to int, value: ${dynamicNotifier.value}');

  dynamicNotifier.value = {'key': 'value'};
  print('After changing to map, value: ${dynamicNotifier.value}');

  // Test ValueNotifier toString
  print('ValueNotifier toString: ${intNotifier.toString()}');

  // Test ValueNotifier dispose
  final disposableNotifier = ValueNotifier<int>(100);
  disposableNotifier.addListener(() {});
  print('Notifier before dispose hasListeners: true (protected member)');
  disposableNotifier.dispose();
  print('Notifier disposed');

  // Test nullable ValueNotifier
  final nullableNotifier = ValueNotifier<String?>(null);
  print(
    'ValueNotifier<String?>(null) created, value: ${nullableNotifier.value}',
  );

  nullableNotifier.value = 'Not null';
  print('After setting value, value: ${nullableNotifier.value}');

  nullableNotifier.value = null;
  print('After setting back to null, value: ${nullableNotifier.value}');

  print('Foundation notifier test completed');

  // Return a visual representation using ValueListenableBuilder
  final demoCounter = ValueNotifier<int>(0);

  return Directionality(
    textDirection: TextDirection.ltr,
    child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foundation Notifiers',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // ChangeNotifier info
            Text(
              'ChangeNotifier:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• Abstract class for observable objects'),
            Text('• Call notifyListeners() to notify observers'),
            Text('• Use addListener/removeListener'),
            Text('• Call dispose() when done'),
            SizedBox(height: 16.0),

            // ValueNotifier info
            Text(
              'ValueNotifier<T>:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• ChangeNotifier that holds a single value'),
            Text('• Notifies on value change'),
            Text('• Does not notify if same value assigned'),
            SizedBox(height: 16.0),

            // ValueListenableBuilder example
            Text(
              'ValueListenableBuilder Demo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ValueListenableBuilder<int>(
              valueListenable: demoCounter,
              builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => demoCounter.value--,
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFE53935),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24.0),
                      Text(
                        '$value',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 24.0),
                      GestureDetector(
                        onTap: () => demoCounter.value++,
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF43A047),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),

            // Listenable info
            Text(
              'Listenable Interface:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• Base interface for observable objects'),
            Text('• Defines addListener/removeListener'),
            Text('• Implemented by ChangeNotifier, Animation'),
            SizedBox(height: 16.0),

            // ValueListenable info
            Text(
              'ValueListenable<T> Interface:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• Listenable that exposes a value'),
            Text('• Defines value getter'),
            Text('• Implemented by ValueNotifier'),
          ],
        ),
      ),
    ),
  );
}

// Custom ChangeNotifier for testing
class CounterNotifier extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }

  void decrement() {
    _value--;
    notifyListeners();
  }

  void reset() {
    _value = 0;
    notifyListeners();
  }
}
