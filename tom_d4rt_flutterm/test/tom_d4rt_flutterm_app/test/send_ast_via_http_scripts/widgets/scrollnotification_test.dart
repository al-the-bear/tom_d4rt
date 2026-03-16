// D4rt test script: Tests ScrollNotification concepts from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollNotification test executing');

  // ScrollNotification is abstract; concrete subclasses are
  // ScrollStartNotification, ScrollUpdateNotification, ScrollEndNotification,
  // OverscrollNotification, UserScrollNotification
  print('ScrollNotification is abstract');
  print(
    'Concrete: ScrollStartNotification, ScrollUpdateNotification, ScrollEndNotification',
  );
  print('Also: OverscrollNotification, UserScrollNotification');

  // Test NotificationListener<ScrollNotification> wrapping ListView
  final scrollListener1 = NotificationListener<ScrollNotification>(
    onNotification: (notification) {
      print('ScrollNotification type: ${notification.runtimeType}');
      print('ScrollNotification depth: ${notification.depth}');
      return false;
    },
    child: SizedBox(
      height: 120.0,
      child: ListView(
        children: [
          Container(
            height: 50.0,
            color: Colors.blue,
            child: Center(child: Text('Item 1')),
          ),
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(child: Text('Item 2')),
          ),
          Container(
            height: 50.0,
            color: Colors.orange,
            child: Center(child: Text('Item 3')),
          ),
          Container(
            height: 50.0,
            color: Colors.red,
            child: Center(child: Text('Item 4')),
          ),
          Container(
            height: 50.0,
            color: Colors.purple,
            child: Center(child: Text('Item 5')),
          ),
        ],
      ),
    ),
  );
  print('NotificationListener<ScrollNotification> wrapping ListView created');

  // Test NotificationListener<ScrollStartNotification>
  final scrollListener2 = NotificationListener<ScrollStartNotification>(
    onNotification: (notification) {
      print('Scroll started');
      return false;
    },
    child: SizedBox(
      height: 100.0,
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) =>
            ListTile(title: Text('Builder item $index')),
      ),
    ),
  );
  print('NotificationListener<ScrollStartNotification> created');

  // Test NotificationListener<ScrollEndNotification>
  final scrollListener3 = NotificationListener<ScrollEndNotification>(
    onNotification: (notification) {
      print('Scroll ended');
      return true;
    },
    child: SizedBox(
      height: 100.0,
      child: ListView(
        children: List.generate(10, (i) {
          return Container(
            height: 40.0,
            color: Colors.primaries[i % Colors.primaries.length],
            child: Center(
              child: Text('End $i', style: TextStyle(color: Colors.white)),
            ),
          );
        }),
      ),
    ),
  );
  print('NotificationListener<ScrollEndNotification> created');

  // Test NotificationListener<ScrollUpdateNotification>
  final scrollListener4 = NotificationListener<ScrollUpdateNotification>(
    onNotification: (notification) {
      print('Scroll update: ${notification.scrollDelta}');
      return false;
    },
    child: SizedBox(
      height: 100.0,
      child: ListView(
        children: List.generate(8, (i) {
          return Container(
            height: 45.0,
            margin: EdgeInsets.all(2.0),
            color: Colors.teal,
            child: Center(child: Text('Update $i')),
          );
        }),
      ),
    ),
  );
  print('NotificationListener<ScrollUpdateNotification> created');

  // LayoutChangedNotification is a base class for layout change notifications
  print('LayoutChangedNotification is abstract base for layout notifications');
  print('SizeChangedLayoutNotification is a concrete subclass');

  // Test SizeChangedLayoutNotifier
  final sizeNotifier = SizeChangedLayoutNotifier(
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.amber,
      child: Center(child: Text('Size notifier')),
    ),
  );
  print('SizeChangedLayoutNotifier created');

  print('ScrollNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollNotification Tests'),
      SizedBox(height: 8.0),
      scrollListener1,
      SizedBox(height: 8.0),
      scrollListener2,
      SizedBox(height: 8.0),
      scrollListener3,
      SizedBox(height: 8.0),
      scrollListener4,
      SizedBox(height: 8.0),
      sizeNotifier,
    ],
  );
}
