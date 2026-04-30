// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Vertices from dart:ui
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui vertices test executing');

  // ========== VERTICES ==========
  print('--- Vertices Tests ---');

  // Basic triangle
  final triangle = Vertices(VertexMode.triangles, [
    Offset(0.0, 0.0),
    Offset(100.0, 0.0),
    Offset(50.0, 100.0),
  ]);
  print('Vertices triangle created');
  print('  runtimeType: ${triangle.runtimeType}');

  // Triangle with colors
  final coloredTriangle = Vertices(
    VertexMode.triangles,
    [Offset(0.0, 0.0), Offset(200.0, 0.0), Offset(100.0, 200.0)],
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
  );
  print('Colored vertices triangle created');
  print('  runtimeType: ${coloredTriangle.runtimeType}');

  // Triangle strip
  final strip = Vertices(VertexMode.triangleStrip, [
    Offset(0.0, 0.0),
    Offset(50.0, 100.0),
    Offset(100.0, 0.0),
    Offset(150.0, 100.0),
  ]);
  print('Vertices triangleStrip created');
  print('  runtimeType: ${strip.runtimeType}');

  // Triangle fan
  final fan = Vertices(VertexMode.triangleFan, [
    Offset(100.0, 100.0), // center
    Offset(100.0, 0.0),
    Offset(200.0, 100.0),
    Offset(100.0, 200.0),
    Offset(0.0, 100.0),
  ]);
  print('Vertices triangleFan created');
  print('  runtimeType: ${fan.runtimeType}');

  // Vertices with texture coordinates
  final textured = Vertices(
    VertexMode.triangles,
    [Offset(0.0, 0.0), Offset(100.0, 0.0), Offset(50.0, 100.0)],
    textureCoordinates: [Offset(0.0, 0.0), Offset(1.0, 0.0), Offset(0.5, 1.0)],
  );
  print('Textured vertices created');
  print('  runtimeType: ${textured.runtimeType}');

  // Vertices with indices
  final indexed = Vertices(
    VertexMode.triangles,
    [
      Offset(0.0, 0.0), // 0
      Offset(100.0, 0.0), // 1
      Offset(100.0, 100.0), // 2
      Offset(0.0, 100.0), // 3
    ],
    indices: [0, 1, 2, 0, 2, 3], // Two triangles forming a quad
  );
  print('Indexed vertices (quad from 2 triangles) created');
  print('  runtimeType: ${indexed.runtimeType}');

  // Vertices with all parameters
  final fullVertices = Vertices(
    VertexMode.triangles,
    [Offset(0.0, 0.0), Offset(100.0, 0.0), Offset(50.0, 80.0)],
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
    textureCoordinates: [Offset(0.0, 0.0), Offset(1.0, 0.0), Offset(0.5, 1.0)],
    indices: [0, 1, 2],
  );
  print('Full vertices with all params created');
  print('  runtimeType: ${fullVertices.runtimeType}');

  // ========== VERTEXMODE ==========
  print('--- VertexMode Tests ---');

  for (final mode in VertexMode.values) {
    print('  VertexMode.$mode: index=${mode.index}');
  }

  // ========== RETURN WIDGET ==========
  print('dart:ui vertices test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Vertices Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• Vertices - vertex mesh for drawing'),
          Text('• VertexMode - triangle/strip/fan'),
          SizedBox(height: 16.0),

          Text('Vertex Modes:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF1F8E9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• triangles - each 3 vertices = 1 triangle'),
                Text('• triangleStrip - reuses previous 2 vertices'),
                Text('• triangleFan - reuses first + previous vertex'),
                SizedBox(height: 8.0),
                Text('Optional parameters:'),
                Text('  colors - per-vertex colors'),
                Text('  textureCoordinates - UV mapping'),
                Text('  indices - index buffer for reuse'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
