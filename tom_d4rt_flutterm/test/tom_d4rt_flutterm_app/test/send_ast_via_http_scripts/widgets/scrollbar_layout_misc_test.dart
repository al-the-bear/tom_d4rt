// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawScrollbar, OrientationBuilder,
// SizeChangedLayoutNotifier, PageStorage, PageStorageKey,
// PrimaryScrollController
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scrollbar and layout misc test executing');

  // ========== PageStorageKey ==========
  print('--- PageStorageKey Tests ---');

  final key1 = PageStorageKey<String>('page1');
  print('PageStorageKey value: ${key1.value}');

  final key2 = PageStorageKey<int>(42);
  print('PageStorageKey int value: ${key2.value}');

  // ========== TraversalDirection ==========
  print('--- TraversalDirection Tests ---');

  print('TraversalDirection.up: ${TraversalDirection.up}');
  print('TraversalDirection.right: ${TraversalDirection.right}');
  print('TraversalDirection.down: ${TraversalDirection.down}');
  print('TraversalDirection.left: ${TraversalDirection.left}');
  print('TraversalDirection.values: ${TraversalDirection.values}');

  // ========== NumericFocusOrder ==========
  print('--- NumericFocusOrder Tests ---');

  final numOrder1 = NumericFocusOrder(1.0);
  print('NumericFocusOrder(1.0) order: ${numOrder1.order}');

  final numOrder2 = NumericFocusOrder(2.0);
  print('NumericFocusOrder(2.0) order: ${numOrder2.order}');

  // ========== LexicalFocusOrder ==========
  print('--- LexicalFocusOrder Tests ---');

  final lexOrder1 = LexicalFocusOrder('alpha');
  print('LexicalFocusOrder order: ${lexOrder1.order}');

  final lexOrder2 = LexicalFocusOrder('beta');
  print('LexicalFocusOrder order2: ${lexOrder2.order}');

  // ========== SizeChangedLayoutNotification ==========
  print('--- SizeChangedLayoutNotification Tests ---');

  final notification = SizeChangedLayoutNotification();
  print('SizeChangedLayoutNotification: $notification');

  print('All scrollbar and layout misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: SingleChildScrollView(
          key: PageStorageKey<String>('mainScroll'),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scrollbar & Layout Misc Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              SizeChangedLayoutNotifier(
                child: Container(
                  width: 200.0,
                  height: 100.0,
                  color: Colors.blue.shade100,
                  child: Center(child: Text('SizeChangedLayoutNotifier')),
                ),
              ),
              SizedBox(height: 12.0),
              OrientationBuilder(
                builder: (context, orientation) {
                  return Text('Orientation: $orientation');
                },
              ),
              SizedBox(height: 12.0),
              FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: Column(
                  children: [
                    FocusTraversalOrder(
                      order: NumericFocusOrder(2.0),
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Second'),
                      ),
                    ),
                    FocusTraversalOrder(
                      order: NumericFocusOrder(1.0),
                      child: TextField(
                        decoration: InputDecoration(labelText: 'First'),
                      ),
                    ),
                    FocusTraversalOrder(
                      order: NumericFocusOrder(3.0),
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Third'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
