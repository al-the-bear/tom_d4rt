// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ChangeNotifier and ValueNotifier from foundation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ChangeNotifier test executing');

  // Test basic ChangeNotifier
  final changeNotifier = ChangeNotifier();
  print('Basic ChangeNotifier created');

  // Test adding listeners
  var listenerCallCount = 0;
  void listener() {
    listenerCallCount++;
    print('Listener called, count: $listenerCallCount');
  }

  changeNotifier.addListener(listener);
  print('Listener added to ChangeNotifier');

  // Note: notifyListeners is protected, so we can't call it directly on base class

  // Test ValueNotifier
  final intNotifier = ValueNotifier<int>(0);
  print('ValueNotifier<int> created with initial value: ${intNotifier.value}');

  // Test ValueNotifier value change
  intNotifier.value = 42;
  print('ValueNotifier value changed to: ${intNotifier.value}');

  // Test ValueNotifier listener
  var valueListenerCount = 0;
  intNotifier.addListener(() {
    valueListenerCount++;
    print(
      'ValueNotifier changed to ${intNotifier.value}, listener count: $valueListenerCount',
    );
  });
  print('Listener added to ValueNotifier');

  intNotifier.value = 100;
  print('ValueNotifier value changed again to: ${intNotifier.value}');

  // Test ValueNotifier with different types
  final stringNotifier = ValueNotifier<String>('Hello');
  print('ValueNotifier<String> created: ${stringNotifier.value}');
  stringNotifier.value = 'World';
  print('ValueNotifier<String> changed to: ${stringNotifier.value}');

  final boolNotifier = ValueNotifier<bool>(false);
  print('ValueNotifier<bool> created: ${boolNotifier.value}');
  boolNotifier.value = true;
  print('ValueNotifier<bool> changed to: ${boolNotifier.value}');

  final listNotifier = ValueNotifier<List<int>>([1, 2, 3]);
  print('ValueNotifier<List<int>> created: ${listNotifier.value}');
  listNotifier.value = [4, 5, 6];
  print('ValueNotifier<List<int>> changed to: ${listNotifier.value}');

  // Test ValueListenableBuilder
  final counter = ValueNotifier<int>(0);
  final valueListenableBuilder = ValueListenableBuilder<int>(
    valueListenable: counter,
    builder: (context, value, child) {
      print('ValueListenableBuilder rebuilding with value: $value');
      return Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blue.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $value', style: TextStyle(fontSize: 20.0)),
            if (child != null) child,
          ],
        ),
      );
    },
    child: Icon(Icons.star), // child doesn't rebuild
  );
  print('ValueListenableBuilder created');

  // Test AnimatedBuilder (similar pattern)
  print('AnimatedBuilder uses similar Listenable pattern');

  // Test ListenableBuilder
  final listenableBuilder = ListenableBuilder(
    listenable: counter,
    builder: (context, child) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.green.shade100,
        child: Text('ListenableBuilder: ${counter.value}'),
      );
    },
  );
  print('ListenableBuilder created');

  // Test removing listeners
  void removableListener() {
    print('Removable listener called');
  }

  counter.addListener(removableListener);
  print('Removable listener added');
  counter.removeListener(removableListener);
  print('Removable listener removed');

  // Test hasListeners
  print('ValueNotifier hasListeners: ${counter.hasListeners}');

  // Test dispose
  final disposableNotifier = ValueNotifier<int>(0);
  disposableNotifier.addListener(() {});
  print('Disposable notifier created with listener');
  // disposableNotifier.dispose(); // Would remove all listeners
  print('dispose() removes all listeners and marks as disposed');

  // Test Listenable.merge
  final notifier1 = ValueNotifier<int>(1);
  final notifier2 = ValueNotifier<String>('a');
  final merged = Listenable.merge([notifier1, notifier2]);
  merged.addListener(() {
    print('Merged listenable notified');
  });
  print('Listenable.merge created from 2 notifiers');

  // Test custom ChangeNotifier (concept)
  print('Custom ChangeNotifier example:');
  print('class Counter extends ChangeNotifier {');
  print('  int _count = 0;');
  print('  int get count => _count;');
  print('  void increment() { _count++; notifyListeners(); }');
  print('}');

  // Test ChangeNotifier properties
  print('ChangeNotifier.hasListeners - checks if any listeners');
  print('ChangeNotifier.notifyListeners() - notifies all listeners');
  print('ChangeNotifier.addListener(callback) - adds listener');
  print('ChangeNotifier.removeListener(callback) - removes listener');
  print('ChangeNotifier.dispose() - cleans up');

  // Test ProxyAnimation concept
  print('ProxyAnimation extends Animation and uses Listenable');

  // Demonstrate counter increment
  counter.value = 1;
  counter.value = 2;
  counter.value = 3;
  print('Counter incremented 3 times');

  print('ChangeNotifier test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ChangeNotifier Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'ValueListenableBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        valueListenableBuilder,
        SizedBox(height: 8.0),

        Text(
          'ListenableBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        listenableBuilder,
        SizedBox(height: 16.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Increment'),
              onPressed: () {
                counter.value++;
                print('Counter incremented to: ${counter.value}');
              },
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              child: Text('Reset'),
              onPressed: () {
                counter.value = 0;
                print('Counter reset to: ${counter.value}');
              },
            ),
          ],
        ),
        SizedBox(height: 24.0),

        Text('Key Concepts:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ChangeNotifier - base class for observable objects'),
        Text('• ValueNotifier<T> - single value with notifications'),
        Text('• ValueListenableBuilder - rebuilds on value change'),
        Text('• ListenableBuilder - general listenable builder'),
        Text('• Listenable.merge - combine multiple listenables'),
        SizedBox(height: 16.0),

        Text('Current Values:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('int: ${intNotifier.value}'),
        Text('string: ${stringNotifier.value}'),
        Text('bool: ${boolNotifier.value}'),
        Text('list: ${listNotifier.value}'),
      ],
    ),
  );
}
