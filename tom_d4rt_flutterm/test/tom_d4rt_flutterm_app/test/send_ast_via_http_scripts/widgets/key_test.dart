// ignore_for_file: avoid_print
// D4rt test script: Tests Key, GlobalKey, ValueKey, UniqueKey, ObjectKey from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Key test executing');

  // Test ValueKey with different types
  final stringKey = ValueKey<String>('my-key');
  print('ValueKey<String> created: $stringKey');

  final intKey = ValueKey<int>(42);
  print('ValueKey<int> created: $intKey');

  final doubleKey = ValueKey<double>(3.14);
  print('ValueKey<double> created: $doubleKey');

  final boolKey = ValueKey<bool>(true);
  print('ValueKey<bool> created: $boolKey');

  // Test ValueKey equality
  final sameKey = ValueKey<String>('my-key');
  print('ValueKey equality: ${stringKey == sameKey}'); // true

  final differentKey = ValueKey<String>('other-key');
  print('Different ValueKey equality: ${stringKey == differentKey}'); // false

  // Test UniqueKey
  final unique1 = UniqueKey();
  final unique2 = UniqueKey();
  print('UniqueKey 1: $unique1');
  print('UniqueKey 2: $unique2');
  print('UniqueKey equality: ${unique1 == unique2}'); // false

  // Test ObjectKey
  final obj = {'id': 1, 'name': 'Test'};
  final objectKey = ObjectKey(obj);
  print('ObjectKey created: $objectKey');

  final sameObj = obj;
  final sameObjectKey = ObjectKey(sameObj);
  print(
    'Same object ObjectKey equality: ${objectKey == sameObjectKey}',
  ); // true

  final differentObj = {'id': 1, 'name': 'Test'}; // different instance
  final differentObjectKey = ObjectKey(differentObj);
  print(
    'Different object ObjectKey equality: ${objectKey == differentObjectKey}',
  ); // false

  // Test GlobalKey
  final globalKey = GlobalKey();
  print('Basic GlobalKey created: $globalKey');

  // Test GlobalKey<State>
  final stateKey = GlobalKey<State>();
  print('GlobalKey<State> created');

  // Test GlobalKey with debugLabel
  final labeledKey = GlobalKey(debugLabel: 'MyGlobalKey');
  print('GlobalKey with debugLabel created');

  // Test GlobalKey properties and methods
  print('GlobalKey.currentContext - gets BuildContext');
  print('GlobalKey.currentWidget - gets Widget');
  print('GlobalKey.currentState - gets State');

  // Test GlobalKey<FormState> for forms
  final formKey = GlobalKey<FormState>();
  print('GlobalKey<FormState> created for form validation');

  // Test GlobalKey<ScaffoldState> for scaffold
  final scaffoldKey = GlobalKey<ScaffoldState>();
  print('GlobalKey<ScaffoldState> created for scaffold access');

  // Test GlobalKey<NavigatorState> for navigation
  final navigatorKey = GlobalKey<NavigatorState>();
  print('GlobalKey<NavigatorState> created for navigation');

  // Test GlobalObjectKey
  final globalObjKey = GlobalObjectKey(obj);
  print('GlobalObjectKey created: $globalObjKey');

  // Test widgets with keys
  final keyedContainer = Container(
    key: ValueKey('container-key'),
    color: Colors.blue,
    height: 50.0,
    child: Center(child: Text('Keyed Container')),
  );
  print('Container with ValueKey created');

  final keyedText = Text('Keyed Text', key: ValueKey('text-key'));
  print('Text with ValueKey created');

  // Test key usage in lists
  final listItems = List.generate(5, (index) {
    return Container(
      key: ValueKey('item-$index'),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 2.0),
      color: Colors.primaries[index % Colors.primaries.length].shade200,
      child: Text('Item $index with key'),
    );
  });
  print('List of 5 keyed items created');

  // Test GlobalKey for finding widget after build
  final findableKey = GlobalKey();
  final findableWidget = Container(
    key: findableKey,
    height: 60.0,
    color: Colors.orange.shade200,
    child: Center(child: Text('Findable Widget')),
  );
  print('Widget with GlobalKey created for finding');

  // Show accessing via GlobalKey
  // After build: findableKey.currentContext, findableKey.currentWidget

  // Test keys in ReorderableListView scenario
  print('Keys are essential for ReorderableListView items');

  // Test keys in AnimatedList scenario
  print('Keys help AnimatedList track items during animations');

  // Test Key base class
  print('Key is abstract base for all keys');

  // Test LocalKey subclasses
  print('LocalKey subclasses: ValueKey, ObjectKey, UniqueKey');

  // Test PageStorageKey for scroll position persistence
  final pageStorageKey = PageStorageKey<String>('scroll-position');
  print('PageStorageKey created: $pageStorageKey');

  // Test usage in ListView for scroll persistence
  final scrollPersistence = ListView(
    key: PageStorageKey('my-list'),
    children: [
      Container(height: 100, color: Colors.red.shade100),
      Container(height: 100, color: Colors.green.shade100),
      Container(height: 100, color: Colors.blue.shade100),
    ],
  );
  print('ListView with PageStorageKey for scroll persistence created');

  // Test form with GlobalKey
  final formWithKey = Form(
    key: formKey,
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) => value!.isEmpty ? 'Required' : null,
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          child: Text('Validate'),
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              print('Form is valid');
            } else {
              print('Form is invalid');
            }
          },
        ),
      ],
    ),
  );
  print('Form with GlobalKey<FormState> created');

  print('Key test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Key Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'ValueKey Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        keyedContainer,
        SizedBox(height: 8.0),

        Text(
          'GlobalKey Example:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        findableWidget,
        SizedBox(height: 16.0),

        Text(
          'Keyed List Items:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...listItems,
        SizedBox(height: 16.0),

        Text(
          'Form with GlobalKey:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        formWithKey,
        SizedBox(height: 16.0),

        Text('Key Types:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ValueKey<T> - equality by value'),
        Text('• UniqueKey - always unique'),
        Text('• ObjectKey - equality by identity'),
        Text('• GlobalKey - access widget/state'),
        Text('• GlobalObjectKey - global + identity'),
        Text('• PageStorageKey - scroll persistence'),
      ],
    ),
  );
}
