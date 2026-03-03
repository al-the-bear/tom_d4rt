// D4rt test script: Tests D4rtFlowDelegate proxy with Flow widget
// Phase 4: Proxy class generation for abstract delegates (GEN-083)
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('D4rtFlowDelegate proxy test executing');

  // ========== BASIC FLOW DELEGATE ==========
  print('--- D4rtFlowDelegate Basic ---');

  // Create a FlowDelegate that paints children in a horizontal row
  final horizontalDelegate = D4rtFlowDelegate(
    onPaintChildren: (FlowPaintingContext context) {
      var xOffset = 0.0;
      for (var i = 0; i < context.childCount; i = i + 1) {
        context.paintChild(i, transform: Matrix4.translationValues(xOffset, 0, 0));
        xOffset = xOffset + 70.0;
      }
    },
    onShouldRepaint: (FlowDelegate oldDelegate) => false,
  );
  print('D4rtFlowDelegate created: ${horizontalDelegate.runtimeType}');
  print('  is FlowDelegate: ${horizontalDelegate is FlowDelegate}');

  // Use in Flow widget
  final widget1 = Flow(
    delegate: horizontalDelegate,
    children: [
      Container(width: 60.0, height: 60.0, color: Colors.red),
      Container(width: 60.0, height: 60.0, color: Colors.green),
      Container(width: 60.0, height: 60.0, color: Colors.blue),
    ],
  );
  print('Flow with horizontal delegate and 3 children created');

  // ========== VERTICAL FLOW ==========
  print('--- Vertical Flow ---');

  final verticalDelegate = D4rtFlowDelegate(
    onPaintChildren: (FlowPaintingContext context) {
      var yOffset = 0.0;
      for (var i = 0; i < context.childCount; i = i + 1) {
        context.paintChild(i, transform: Matrix4.translationValues(0, yOffset, 0));
        yOffset = yOffset + 50.0;
      }
    },
    onShouldRepaint: (FlowDelegate oldDelegate) => false,
  );
  print('Vertical flow delegate created');

  final widget2 = Flow(
    delegate: verticalDelegate,
    children: [
      Container(width: 40.0, height: 40.0, color: Colors.orange),
      Container(width: 40.0, height: 40.0, color: Colors.purple),
      Container(width: 40.0, height: 40.0, color: Colors.teal),
      Container(width: 40.0, height: 40.0, color: Colors.amber),
    ],
  );
  print('Flow with vertical delegate and 4 children created');

  // ========== GRID-LIKE FLOW ==========
  print('--- Grid-like Flow ---');

  final gridDelegate = D4rtFlowDelegate(
    onPaintChildren: (FlowPaintingContext context) {
      final columns = 3;
      final cellSize = 55.0;
      for (var i = 0; i < context.childCount; i = i + 1) {
        final col = i % columns;
        final row = i ~/ columns;
        context.paintChild(
          i,
          transform: Matrix4.translationValues(
            col * cellSize,
            row * cellSize,
            0,
          ),
        );
      }
    },
    onShouldRepaint: (FlowDelegate oldDelegate) => false,
  );
  print('Grid-like flow delegate (3 columns) created');

  final gridChildren = <Widget>[];
  final gridColors = [
    Colors.red, Colors.green, Colors.blue,
    Colors.orange, Colors.purple, Colors.teal,
    Colors.amber, Colors.indigo, Colors.pink,
  ];
  for (var i = 0; i < gridColors.length; i = i + 1) {
    gridChildren.add(
      Container(width: 50.0, height: 50.0, color: gridColors[i]),
    );
  }

  final widget3 = Flow(
    delegate: gridDelegate,
    children: gridChildren,
  );
  print('Flow with grid delegate and ${gridColors.length} children created');

  // ========== DYNAMIC REPAINT ==========
  print('--- shouldRepaint Logic ---');

  final dynamicDelegate = D4rtFlowDelegate(
    onPaintChildren: (FlowPaintingContext context) {
      for (var i = 0; i < context.childCount; i = i + 1) {
        context.paintChild(
          i,
          transform: Matrix4.translationValues(i * 65.0, 0, 0),
        );
      }
    },
    onShouldRepaint: (FlowDelegate oldDelegate) => true,
  );
  print('Dynamic delegate (always repaints) created');

  final widget4 = Flow(
    delegate: dynamicDelegate,
    children: [
      Container(width: 60.0, height: 60.0, color: Colors.cyan),
      Container(width: 60.0, height: 60.0, color: Colors.lime),
    ],
  );
  print('Flow with dynamic delegate created');

  // ========== FLOW WITH KEY ==========
  print('--- Flow with Key ---');

  final widget5 = Flow(
    key: ValueKey('proxy-flow-1'),
    delegate: horizontalDelegate,
    children: [
      Container(width: 50.0, height: 50.0, color: Colors.deepOrange),
      Container(width: 50.0, height: 50.0, color: Colors.deepPurple),
    ],
  );
  print('Flow with ValueKey created');

  // ========== EMPTY FLOW ==========
  print('--- Empty Flow ---');

  final emptyDelegate = D4rtFlowDelegate(
    onPaintChildren: (FlowPaintingContext context) {
      // No children to paint
      print('Empty delegate paintChildren called, childCount: ${context.childCount}');
    },
    onShouldRepaint: (FlowDelegate oldDelegate) => false,
  );
  final widget6 = Flow(delegate: emptyDelegate, children: []);
  print('Flow with empty delegate and no children created');

  print('D4rtFlowDelegate proxy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('D4rtFlowDelegate Proxy Tests'),
      SizedBox(height: 8.0),
      SizedBox(
        width: 250.0,
        height: 70.0,
        child: widget1,
      ),
      SizedBox(height: 8.0),
      SizedBox(
        width: 250.0,
        height: 210.0,
        child: widget2,
      ),
      SizedBox(height: 8.0),
      SizedBox(
        width: 180.0,
        height: 180.0,
        child: widget3,
      ),
      SizedBox(height: 8.0),
      SizedBox(
        width: 200.0,
        height: 70.0,
        child: widget4,
      ),
    ],
  );
}
