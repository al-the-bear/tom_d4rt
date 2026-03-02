// D4rt test script: Tests ClipRect, ClipOval, ClipPath, ClipRRect from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Clipping widgets test executing');

  // Test ClipRect with child Container
  final clipRect = ClipRect(
    child: Container(width: 100, height: 100, color: Colors.blue),
  );
  print('ClipRect with child Container created');

  // Test ClipOval with child Container
  final clipOval = ClipOval(
    child: Container(width: 100, height: 100, color: Colors.green),
  );
  print('ClipOval with child Container created');

  // Test ClipPath with clipper null and child
  final clipPath = ClipPath(
    clipper: null,
    child: Container(width: 100, height: 100, color: Colors.red),
  );
  print('ClipPath with clipper: null created');

  // Test ClipRRect with default border radius
  final clipRRect = ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Container(width: 100, height: 100, color: Colors.orange),
  );
  print('ClipRRect with borderRadius created');

  // Test ClipRect with Clip.hardEdge
  final clipRectHard = ClipRect(
    clipBehavior: Clip.hardEdge,
    child: Container(width: 80, height: 80, color: Colors.purple),
  );
  print('ClipRect with Clip.hardEdge created');

  // Test ClipRect with Clip.antiAlias
  final clipRectAA = ClipRect(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 80, height: 80, color: Colors.teal),
  );
  print('ClipRect with Clip.antiAlias created');

  // Test ClipRect with Clip.antiAliasWithSaveLayer
  final clipRectAASL = ClipRect(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(width: 80, height: 80, color: Colors.amber),
  );
  print('ClipRect with Clip.antiAliasWithSaveLayer created');

  // Test ClipOval with Clip.antiAlias
  final clipOvalAA = ClipOval(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 60, height: 60, color: Colors.indigo),
  );
  print('ClipOval with Clip.antiAlias created');

  print('Clipping widgets test completed');
  return Column(children: [
    clipRect,
    clipOval,
    clipPath,
    clipRRect,
    clipRectHard,
    clipRectAA,
    clipRectAASL,
    clipOvalAA,
  ]);
}
