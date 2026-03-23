// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RefreshIndicator from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicator test executing');

  // Variation 1: Basic RefreshIndicator
  final widget1 = RefreshIndicator(
    onRefresh: () async {
      print('refreshing');
    },
    child: ListView(
      children: [
        Container(
          height: 100,
          color: Colors.blue,
          child: Center(child: Text('Item 1')),
        ),
        Container(
          height: 100,
          color: Colors.red,
          child: Center(child: Text('Item 2')),
        ),
      ],
    ),
  );
  print('RefreshIndicator(basic) created');

  // Variation 2: RefreshIndicator with custom color
  final widget2 = RefreshIndicator(
    onRefresh: () async {
      print('refreshing green');
    },
    color: Colors.green,
    child: ListView(
      children: [
        Container(
          height: 80,
          color: Colors.green.shade100,
          child: Center(child: Text('Green 1')),
        ),
        Container(
          height: 80,
          color: Colors.green.shade200,
          child: Center(child: Text('Green 2')),
        ),
        Container(
          height: 80,
          color: Colors.green.shade300,
          child: Center(child: Text('Green 3')),
        ),
      ],
    ),
  );
  print('RefreshIndicator(color: green) created');

  // Variation 3: RefreshIndicator with background color and displacement
  final widget3 = RefreshIndicator(
    onRefresh: () async {
      print('refreshing displaced');
    },
    backgroundColor: Colors.white,
    displacement: 60.0,
    child: ListView(
      children: [
        Container(
          height: 90,
          color: Colors.orange.shade100,
          child: Center(child: Text('Displaced 1')),
        ),
        Container(
          height: 90,
          color: Colors.orange.shade200,
          child: Center(child: Text('Displaced 2')),
        ),
      ],
    ),
  );
  print('RefreshIndicator(backgroundColor: white, displacement: 60.0) created');

  // Variation 4: RefreshIndicator with strokeWidth
  final widget4 = RefreshIndicator(
    onRefresh: () async {
      print('refreshing thick');
    },
    strokeWidth: 3.0,
    child: ListView(
      children: [
        Container(
          height: 100,
          color: Colors.purple.shade100,
          child: Center(child: Text('Thick 1')),
        ),
        Container(
          height: 100,
          color: Colors.purple.shade200,
          child: Center(child: Text('Thick 2')),
        ),
      ],
    ),
  );
  print('RefreshIndicator(strokeWidth: 3.0) created');

  // Variation 5: RefreshIndicator with all custom properties
  final widget5 = RefreshIndicator(
    onRefresh: () async {
      print('refreshing full custom');
    },
    color: Colors.white,
    backgroundColor: Colors.blue,
    displacement: 40.0,
    strokeWidth: 2.5,
    child: ListView(
      children: [
        Container(
          height: 70,
          color: Colors.cyan.shade100,
          child: Center(child: Text('Custom 1')),
        ),
        Container(
          height: 70,
          color: Colors.cyan.shade200,
          child: Center(child: Text('Custom 2')),
        ),
        Container(
          height: 70,
          color: Colors.cyan.shade300,
          child: Center(child: Text('Custom 3')),
        ),
      ],
    ),
  );
  print('RefreshIndicator(all custom properties) created');

  print('RefreshIndicator test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      Expanded(child: widget2),
      Expanded(child: widget3),
      Expanded(child: widget4),
      Expanded(child: widget5),
    ],
  );
}
