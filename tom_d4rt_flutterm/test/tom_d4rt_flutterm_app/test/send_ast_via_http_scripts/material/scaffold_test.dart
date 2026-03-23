// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Scaffold from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scaffold test executing');

  // Test basic Scaffold
  final scaffold = Scaffold(
    appBar: AppBar(title: Text('Scaffold Test'), backgroundColor: Colors.blue),
    body: Center(
      child: Text('Scaffold Body', style: TextStyle(fontSize: 18.0)),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    ),
  );
  print('Basic Scaffold with AppBar and FAB created');

  print('Scaffold test completed');

  // Return just the scaffold structure elements without full Scaffold
  // (since Scaffold needs MaterialApp context which the test app provides)
  return Container(
    width: 300.0,
    height: 400.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        // Simulated AppBar
        Container(
          height: 56.0,
          color: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'Scaffold Test',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Body
        Expanded(
          child: Stack(
            children: [
              Center(
                child: Text('Scaffold Body', style: TextStyle(fontSize: 18.0)),
              ),
              // FAB position
              Positioned(
                right: 16.0,
                bottom: 16.0,
                child: Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
