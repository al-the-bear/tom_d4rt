// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests GridView widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GridView test executing');

  // Test basic GridView.count
  final countGridView = Container(
    height: 150.0,
    child: GridView.count(
      crossAxisCount: 3,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
        Container(color: Colors.orange),
      ],
    ),
  );
  print('GridView.count with crossAxisCount=3 created');

  // Test GridView.count with spacing
  final spacedGridView = Container(
    height: 150.0,
    child: GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
      ],
    ),
  );
  print('GridView.count with spacing created');

  // Test GridView.count with childAspectRatio
  final aspectGridView = Container(
    height: 100.0,
    child: GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2.0,
      children: [
        Container(color: Colors.teal),
        Container(color: Colors.cyan),
        Container(color: Colors.indigo),
      ],
    ),
  );
  print('GridView.count with childAspectRatio=2.0 created');

  // Test GridView.extent
  final extentGridView = Container(
    height: 150.0,
    child: GridView.extent(
      maxCrossAxisExtent: 80.0,
      children: [
        Container(color: Colors.pink),
        Container(color: Colors.lime),
        Container(color: Colors.amber),
        Container(color: Colors.brown),
      ],
    ),
  );
  print('GridView.extent with maxCrossAxisExtent=80 created');

  // Test GridView.builder
  final builderGridView = Container(
    height: 150.0,
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text('$index', style: TextStyle(color: Colors.white)),
          ),
        );
      },
    ),
  );
  print('GridView.builder with itemCount=9 created');

  // Test GridView with padding
  final paddedGridView = Container(
    height: 120.0,
    color: Colors.grey.shade200,
    child: GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      children: [
        Container(color: Colors.red),
        Container(color: Colors.blue),
      ],
    ),
  );
  print('GridView with padding created');

  // Test GridView with scrollDirection horizontal
  final horizontalGridView = Container(
    height: 100.0,
    child: GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.horizontal,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
        Container(color: Colors.orange),
      ],
    ),
  );
  print('GridView with horizontal scrollDirection created');

  print('GridView test completed');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridView.count (3 cols):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        countGridView,
        SizedBox(height: 8.0),
        Text(
          'GridView with spacing:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        spacedGridView,
        SizedBox(height: 8.0),
        Text('GridView.extent:', style: TextStyle(fontWeight: FontWeight.bold)),
        extentGridView,
        SizedBox(height: 8.0),
        Text(
          'GridView.builder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        builderGridView,
      ],
    ),
  );
}
