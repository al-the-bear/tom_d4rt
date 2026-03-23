// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Stack widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Stack test executing');

  // Test basic Stack with overlapping children
  final basicStack = Stack(
    children: [
      Container(width: 100.0, height: 100.0, color: Colors.blue),
      Container(width: 80.0, height: 80.0, color: Colors.green),
      Container(width: 60.0, height: 60.0, color: Colors.red),
    ],
  );
  print('Basic Stack with overlapping containers created');

  // Test Stack with alignment
  final alignedStack = Stack(
    alignment: Alignment.center,
    children: [
      Container(width: 120.0, height: 120.0, color: Colors.purple),
      Container(width: 80.0, height: 80.0, color: Colors.orange),
      Container(width: 40.0, height: 40.0, color: Colors.white),
    ],
  );
  print('Stack with alignment=center created');

  // Test Stack with fit
  final fitStack = Container(
    width: 150.0,
    height: 100.0,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.teal),
        Center(
          child: Text('Expanded', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
  print('Stack with fit=expand created');

  // Test Stack with clipBehavior
  final clippedStack = Container(
    width: 100.0,
    height: 100.0,
    child: Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(width: 100.0, height: 100.0, color: Colors.cyan),
        Positioned(
          left: 70.0,
          top: 70.0,
          child: Container(width: 60.0, height: 60.0, color: Colors.pink),
        ),
      ],
    ),
  );
  print('Stack with clipBehavior=hardEdge created');

  // Test Stack with textDirection
  final directedStack = Stack(
    textDirection: TextDirection.rtl,
    alignment: AlignmentDirectional.centerStart,
    children: [
      Container(width: 120.0, height: 60.0, color: Colors.amber),
      Container(width: 60.0, height: 40.0, color: Colors.brown),
    ],
  );
  print('Stack with textDirection=rtl created');

  // Test IndexedStack
  final indexedStack = IndexedStack(
    index: 1,
    children: [
      Container(
        width: 80.0,
        height: 80.0,
        color: Colors.red,
        child: Center(child: Text('0')),
      ),
      Container(
        width: 80.0,
        height: 80.0,
        color: Colors.green,
        child: Center(child: Text('1')),
      ),
      Container(
        width: 80.0,
        height: 80.0,
        color: Colors.blue,
        child: Center(child: Text('2')),
      ),
    ],
  );
  print('IndexedStack with index=1 created');

  print('Stack test completed');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        basicStack,
        SizedBox(height: 16.0),
        alignedStack,
        SizedBox(height: 16.0),
        fitStack,
        SizedBox(height: 16.0),
        clippedStack,
        SizedBox(height: 16.0),
        directedStack,
        SizedBox(height: 16.0),
        indexedStack,
      ],
    ),
  );
}
