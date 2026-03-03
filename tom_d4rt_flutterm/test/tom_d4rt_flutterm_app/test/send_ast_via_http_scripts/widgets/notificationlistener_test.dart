// D4rt test script: Tests NotificationListener from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NotificationListener test executing');

  // Variation 1: NotificationListener<ScrollNotification> with ListView
  final widget1 = NotificationListener<ScrollNotification>(
    onNotification: (notification) {
      print('scroll notification');
      return false;
    },
    child: ListView(
      children: [
        Container(height: 100, color: Colors.blue),
        Container(height: 100, color: Colors.red),
        Container(height: 100, color: Colors.green),
      ],
    ),
  );
  print('NotificationListener<ScrollNotification>(ListView) created');

  // Variation 2: NotificationListener<ScrollStartNotification>
  final widget2 = NotificationListener<ScrollStartNotification>(
    onNotification: (notification) {
      print('scroll start notification');
      return false;
    },
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    ),
  );
  print('NotificationListener<ScrollStartNotification> created');

  // Variation 3: NotificationListener<ScrollEndNotification>
  final widget3 = NotificationListener<ScrollEndNotification>(
    onNotification: (notification) {
      print('scroll end notification');
      return true;
    },
    child: ListView(
      children: [
        Container(
          height: 80,
          color: Colors.orange,
          child: Center(child: Text('Orange')),
        ),
        Container(
          height: 80,
          color: Colors.purple,
          child: Center(child: Text('Purple')),
        ),
        Container(
          height: 80,
          color: Colors.teal,
          child: Center(child: Text('Teal')),
        ),
        Container(
          height: 80,
          color: Colors.amber,
          child: Center(child: Text('Amber')),
        ),
      ],
    ),
  );
  print('NotificationListener<ScrollEndNotification>(return true) created');

  // Variation 4: Nested NotificationListeners
  final widget4 = NotificationListener<ScrollNotification>(
    onNotification: (notification) {
      print('outer scroll notification');
      return false;
    },
    child: NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        print('inner scroll update notification');
        return false;
      },
      child: ListView(
        children: [
          Container(
            height: 120,
            color: Colors.cyan,
            child: Center(child: Text('Nested Listener 1')),
          ),
          Container(
            height: 120,
            color: Colors.lime,
            child: Center(child: Text('Nested Listener 2')),
          ),
          Container(
            height: 120,
            color: Colors.pink,
            child: Center(child: Text('Nested Listener 3')),
          ),
        ],
      ),
    ),
  );
  print('NotificationListener(nested inner+outer) created');

  print('NotificationListener test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      Expanded(child: widget2),
      Expanded(child: widget3),
      Expanded(child: widget4),
    ],
  );
}
