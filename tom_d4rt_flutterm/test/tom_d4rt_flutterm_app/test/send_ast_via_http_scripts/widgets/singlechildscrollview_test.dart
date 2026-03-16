// D4rt test script: Tests SingleChildScrollView widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SingleChildScrollView test executing');

  // Test basic SingleChildScrollView
  final basicScrollView = Container(
    height: 100.0,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 50.0, color: Colors.red),
          Container(height: 50.0, color: Colors.green),
          Container(height: 50.0, color: Colors.blue),
          Container(height: 50.0, color: Colors.yellow),
        ],
      ),
    ),
  );
  print('Basic SingleChildScrollView created');

  // Test SingleChildScrollView with padding
  final paddedScrollView = Container(
    height: 100.0,
    color: Colors.grey.shade200,
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(height: 40.0, color: Colors.purple),
          Container(height: 40.0, color: Colors.orange),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with padding created');

  // Test SingleChildScrollView with horizontal scroll
  final horizontalScrollView = Container(
    height: 60.0,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(width: 100.0, color: Colors.red),
          Container(width: 100.0, color: Colors.green),
          Container(width: 100.0, color: Colors.blue),
          Container(width: 100.0, color: Colors.yellow),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with horizontal scrollDirection created');

  // Test SingleChildScrollView with reverse
  final reverseScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Container(
            height: 30.0,
            color: Colors.teal,
            child: Center(child: Text('First')),
          ),
          Container(
            height: 30.0,
            color: Colors.cyan,
            child: Center(child: Text('Second')),
          ),
          Container(
            height: 30.0,
            color: Colors.indigo,
            child: Center(child: Text('Third')),
          ),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with reverse=true created');

  // Test SingleChildScrollView with physics
  final physicsScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(height: 40.0, color: Colors.pink),
          Container(height: 40.0, color: Colors.lime),
          Container(height: 40.0, color: Colors.amber),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with BouncingScrollPhysics created');

  // Test SingleChildScrollView with ClampingScrollPhysics
  final clampingScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(height: 40.0, color: Colors.brown),
          Container(height: 40.0, color: Colors.grey),
          Container(height: 40.0, color: Colors.blueGrey),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with ClampingScrollPhysics created');

  // Test SingleChildScrollView with primary
  final primaryScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      primary: false,
      child: Column(
        children: [
          Container(height: 50.0, color: Colors.deepOrange),
          Container(height: 50.0, color: Colors.deepPurple),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with primary=false created');

  print('SingleChildScrollView test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Basic ScrollView:', style: TextStyle(fontWeight: FontWeight.bold)),
      basicScrollView,
      SizedBox(height: 8.0),
      Text('With padding:', style: TextStyle(fontWeight: FontWeight.bold)),
      paddedScrollView,
      SizedBox(height: 8.0),
      Text('Horizontal:', style: TextStyle(fontWeight: FontWeight.bold)),
      horizontalScrollView,
      SizedBox(height: 8.0),
      Text('Reverse:', style: TextStyle(fontWeight: FontWeight.bold)),
      reverseScrollView,
    ],
  );
}
