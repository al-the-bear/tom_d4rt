// D4rt test script: Tests RenderClipRect, RenderClipRRect, RenderClipOval, RenderClipPath
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects clip test executing');

  // ========== RENDER CLIP RECT ==========
  print('--- RenderClipRect Tests ---');

  final clipRect = RenderClipRect();
  print('RenderClipRect() created: ${clipRect.runtimeType}');
  print('  clipBehavior: ${clipRect.clipBehavior}');

  final clipRectHardEdge = RenderClipRect(clipBehavior: Clip.hardEdge);
  print(
    'RenderClipRect(hardEdge) clipBehavior: ${clipRectHardEdge.clipBehavior}',
  );

  final clipRectAntiAlias = RenderClipRect(clipBehavior: Clip.antiAlias);
  print(
    'RenderClipRect(antiAlias) clipBehavior: ${clipRectAntiAlias.clipBehavior}',
  );

  final clipRectAntiAliasLayer = RenderClipRect(
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
  print(
    'RenderClipRect(antiAliasWithSaveLayer) clipBehavior: ${clipRectAntiAliasLayer.clipBehavior}',
  );

  // Modify clipBehavior
  clipRect.clipBehavior = Clip.hardEdge;
  print('After setting clipBehavior: ${clipRect.clipBehavior}');

  // ========== RENDER CLIP RRECT ==========
  print('--- RenderClipRRect Tests ---');

  final clipRRect = RenderClipRRect();
  print('RenderClipRRect() created: ${clipRRect.runtimeType}');
  print('  clipBehavior: ${clipRRect.clipBehavior}');
  print('  borderRadius: ${clipRRect.borderRadius}');

  final clipRRectWithRadius = RenderClipRRect(
    borderRadius: BorderRadius.circular(12.0),
  );
  print(
    'RenderClipRRect(radius=12) borderRadius: ${clipRRectWithRadius.borderRadius}',
  );

  final clipRRectCustom = RenderClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(4.0),
      bottomRight: Radius.circular(24.0),
    ),
  );
  print(
    'RenderClipRRect(custom corners) borderRadius: ${clipRRectCustom.borderRadius}',
  );

  // Modify borderRadius
  clipRRect.borderRadius = BorderRadius.circular(20.0);
  print('After setting borderRadius: ${clipRRect.borderRadius}');

  // ========== RENDER CLIP OVAL ==========
  print('--- RenderClipOval Tests ---');

  final clipOval = RenderClipOval();
  print('RenderClipOval() created: ${clipOval.runtimeType}');
  print('  clipBehavior: ${clipOval.clipBehavior}');

  final clipOvalAntiAlias = RenderClipOval(clipBehavior: Clip.antiAlias);
  print(
    'RenderClipOval(antiAlias) clipBehavior: ${clipOvalAntiAlias.clipBehavior}',
  );

  // ========== RENDER CLIP PATH ==========
  print('--- RenderClipPath Tests ---');

  final clipPath = RenderClipPath();
  print('RenderClipPath() created: ${clipPath.runtimeType}');
  print('  clipBehavior: ${clipPath.clipBehavior}');

  final clipPathAntiAlias = RenderClipPath(clipBehavior: Clip.antiAlias);
  print(
    'RenderClipPath(antiAlias) clipBehavior: ${clipPathAntiAlias.clipBehavior}',
  );

  // RenderClipPath accepts a CustomClipper<Path> via the clipper parameter
  // Cannot easily test custom clippers here without a render tree
  print('Note: CustomClipper<Path> requires render tree to function');

  // ========== CLIP BEHAVIOR ENUM ==========
  print('--- Clip enum values ---');
  print('Clip.none: ${Clip.none}');
  print('Clip.hardEdge: ${Clip.hardEdge}');
  print('Clip.antiAlias: ${Clip.antiAlias}');
  print('Clip.antiAliasWithSaveLayer: ${Clip.antiAliasWithSaveLayer}');

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects clip test completed');
  return Container(child: Text('RenderObjects clip test passed'));
}
