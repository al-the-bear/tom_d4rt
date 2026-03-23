// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ListView widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListView test executing');

  // Test basic ListView with children
  final basicListView = Container(
    height: 120.0,
    child: ListView(
      children: [
        Container(
          height: 40.0,
          color: Colors.red,
          child: Center(child: Text('Item 1')),
        ),
        Container(
          height: 40.0,
          color: Colors.green,
          child: Center(child: Text('Item 2')),
        ),
        Container(
          height: 40.0,
          color: Colors.blue,
          child: Center(child: Text('Item 3')),
        ),
        Container(
          height: 40.0,
          color: Colors.orange,
          child: Center(child: Text('Item 4')),
        ),
      ],
    ),
  );
  print('Basic ListView with children created');

  // Test ListView with padding
  final paddedListView = Container(
    height: 100.0,
    child: ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        Container(
          height: 30.0,
          color: Colors.purple,
          child: Center(child: Text('Padded')),
        ),
        Container(
          height: 30.0,
          color: Colors.teal,
          child: Center(child: Text('List')),
        ),
      ],
    ),
  );
  print('ListView with padding created');

  // Test ListView with horizontal scroll
  final horizontalListView = Container(
    height: 60.0,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(width: 80.0, color: Colors.red),
        Container(width: 80.0, color: Colors.green),
        Container(width: 80.0, color: Colors.blue),
        Container(width: 80.0, color: Colors.yellow),
      ],
    ),
  );
  print('ListView with horizontal scrollDirection created');

  // Test ListView.builder
  final builderListView = Container(
    height: 100.0,
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          height: 30.0,
          color: index.isEven ? Colors.grey.shade300 : Colors.grey.shade100,
          child: Center(child: Text('Builder Item $index')),
        );
      },
    ),
  );
  print('ListView.builder with itemCount=5 created');

  // Test ListView.separated
  final separatedListView = Container(
    height: 120.0,
    child: ListView.separated(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          height: 25.0,
          color: Colors.blue.shade100,
          child: Center(child: Text('Separated $index')),
        );
      },
      separatorBuilder: (context, index) {
        return Container(height: 2.0, color: Colors.blue);
      },
    ),
  );
  print('ListView.separated created');

  // Test ListView with reverse
  final reverseListView = Container(
    height: 80.0,
    child: ListView(
      reverse: true,
      children: [
        Container(
          height: 25.0,
          color: Colors.red,
          child: Center(child: Text('First')),
        ),
        Container(
          height: 25.0,
          color: Colors.green,
          child: Center(child: Text('Second')),
        ),
        Container(
          height: 25.0,
          color: Colors.blue,
          child: Center(child: Text('Third')),
        ),
      ],
    ),
  );
  print('ListView with reverse=true created');

  // Test ListView with physics
  final physicsListView = Container(
    height: 80.0,
    child: ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          height: 30.0,
          color: Colors.amber,
          child: Center(child: Text('Bouncing')),
        ),
        Container(
          height: 30.0,
          color: Colors.pink,
          child: Center(child: Text('Physics')),
        ),
      ],
    ),
  );
  print('ListView with BouncingScrollPhysics created');

  print('ListView test completed');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Basic ListView:', style: TextStyle(fontWeight: FontWeight.bold)),
        basicListView,
        SizedBox(height: 8.0),
        Text('Padded ListView:', style: TextStyle(fontWeight: FontWeight.bold)),
        paddedListView,
        SizedBox(height: 8.0),
        Text(
          'Horizontal ListView:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        horizontalListView,
        SizedBox(height: 8.0),
        Text(
          'ListView.builder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        builderListView,
        SizedBox(height: 8.0),
        Text(
          'ListView.separated:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        separatedListView,
      ],
    ),
  );
}
