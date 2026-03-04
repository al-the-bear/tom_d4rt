// D4rt test script: Tests dart:ui enums - Clip, PathFillType, PathOperation,
// StrokeCap, StrokeJoin, PaintingStyle, BlendMode, TileMode, VertexMode,
// PointMode, ImageByteFormat, PixelFormat, Brightness, AppLifecycleState,
// PointerDeviceKind, PointerSignalKind
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui enums test executing');

  // ========== Clip ==========
  print('--- Clip Tests ---');
  print('Clip.none: ${Clip.none}');
  print('Clip.hardEdge: ${Clip.hardEdge}');
  print('Clip.antiAlias: ${Clip.antiAlias}');
  print('Clip.antiAliasWithSaveLayer: ${Clip.antiAliasWithSaveLayer}');
  print('Clip.values: ${Clip.values}');

  // ========== PathFillType ==========
  print('--- PathFillType Tests ---');
  print('PathFillType.nonZero: ${PathFillType.nonZero}');
  print('PathFillType.evenOdd: ${PathFillType.evenOdd}');

  // ========== PathOperation ==========
  print('--- PathOperation Tests ---');
  print('PathOperation.difference: ${PathOperation.difference}');
  print('PathOperation.intersect: ${PathOperation.intersect}');
  print('PathOperation.union: ${PathOperation.union}');
  print('PathOperation.xor: ${PathOperation.xor}');
  print('PathOperation.reverseDifference: ${PathOperation.reverseDifference}');

  // ========== StrokeCap ==========
  print('--- StrokeCap Tests ---');
  print('StrokeCap.butt: ${StrokeCap.butt}');
  print('StrokeCap.round: ${StrokeCap.round}');
  print('StrokeCap.square: ${StrokeCap.square}');

  // ========== StrokeJoin ==========
  print('--- StrokeJoin Tests ---');
  print('StrokeJoin.miter: ${StrokeJoin.miter}');
  print('StrokeJoin.round: ${StrokeJoin.round}');
  print('StrokeJoin.bevel: ${StrokeJoin.bevel}');

  // ========== PaintingStyle ==========
  print('--- PaintingStyle Tests ---');
  print('PaintingStyle.fill: ${PaintingStyle.fill}');
  print('PaintingStyle.stroke: ${PaintingStyle.stroke}');

  // ========== BlendMode ==========
  print('--- BlendMode Tests ---');
  print('BlendMode.clear: ${BlendMode.clear}');
  print('BlendMode.src: ${BlendMode.src}');
  print('BlendMode.dst: ${BlendMode.dst}');
  print('BlendMode.srcOver: ${BlendMode.srcOver}');
  print('BlendMode.dstOver: ${BlendMode.dstOver}');
  print('BlendMode.srcIn: ${BlendMode.srcIn}');
  print('BlendMode.multiply: ${BlendMode.multiply}');
  print('BlendMode.screen: ${BlendMode.screen}');
  print('BlendMode.overlay: ${BlendMode.overlay}');
  print('BlendMode.values: ${BlendMode.values.length} values');

  // ========== TileMode ==========
  print('--- TileMode Tests ---');
  print('TileMode.clamp: ${TileMode.clamp}');
  print('TileMode.repeated: ${TileMode.repeated}');
  print('TileMode.mirror: ${TileMode.mirror}');
  print('TileMode.decal: ${TileMode.decal}');

  // ========== VertexMode ==========
  print('--- VertexMode Tests ---');
  print('VertexMode.triangles: ${VertexMode.triangles}');
  print('VertexMode.triangleStrip: ${VertexMode.triangleStrip}');
  print('VertexMode.triangleFan: ${VertexMode.triangleFan}');

  // ========== PointMode ==========
  print('--- PointMode Tests ---');
  print('PointMode.points: ${PointMode.points}');
  print('PointMode.lines: ${PointMode.lines}');
  print('PointMode.polygon: ${PointMode.polygon}');

  // ========== ImageByteFormat ==========
  print('--- ImageByteFormat Tests ---');
  print('ImageByteFormat.rawRgba: ${ImageByteFormat.rawRgba}');
  print('ImageByteFormat.rawStraightRgba: ${ImageByteFormat.rawStraightRgba}');
  print('ImageByteFormat.rawUnmodified: ${ImageByteFormat.rawUnmodified}');
  print('ImageByteFormat.png: ${ImageByteFormat.png}');

  // ========== PixelFormat ==========
  print('--- PixelFormat Tests ---');
  print('PixelFormat.rgba8888: ${PixelFormat.rgba8888}');
  print('PixelFormat.bgra8888: ${PixelFormat.bgra8888}');

  // ========== Brightness ==========
  print('--- Brightness Tests ---');
  print('Brightness.dark: ${Brightness.dark}');
  print('Brightness.light: ${Brightness.light}');

  // ========== AppLifecycleState ==========
  print('--- AppLifecycleState Tests ---');
  print('AppLifecycleState.detached: ${AppLifecycleState.detached}');
  print('AppLifecycleState.resumed: ${AppLifecycleState.resumed}');
  print('AppLifecycleState.inactive: ${AppLifecycleState.inactive}');
  print('AppLifecycleState.hidden: ${AppLifecycleState.hidden}');
  print('AppLifecycleState.paused: ${AppLifecycleState.paused}');
  print('AppLifecycleState.values: ${AppLifecycleState.values}');

  // ========== PointerDeviceKind ==========
  print('--- PointerDeviceKind Tests ---');
  print('PointerDeviceKind.touch: ${PointerDeviceKind.touch}');
  print('PointerDeviceKind.mouse: ${PointerDeviceKind.mouse}');
  print('PointerDeviceKind.stylus: ${PointerDeviceKind.stylus}');
  print(
    'PointerDeviceKind.invertedStylus: ${PointerDeviceKind.invertedStylus}',
  );
  print('PointerDeviceKind.trackpad: ${PointerDeviceKind.trackpad}');
  print('PointerDeviceKind.unknown: ${PointerDeviceKind.unknown}');

  // ========== PointerSignalKind ==========
  print('--- PointerSignalKind Tests ---');
  print('PointerSignalKind.none: ${PointerSignalKind.none}');
  print('PointerSignalKind.scroll: ${PointerSignalKind.scroll}');
  print(
    'PointerSignalKind.scrollInertiaCancel: ${PointerSignalKind.scrollInertiaCancel}',
  );
  print('PointerSignalKind.scale: ${PointerSignalKind.scale}');
  print('PointerSignalKind.unknown: ${PointerSignalKind.unknown}');

  // ========== Locale ==========
  print('--- Locale Tests ---');
  final locale1 = Locale('en', 'US');
  print('Locale: ${locale1.languageCode}_${locale1.countryCode}');
  final locale2 = Locale('de');
  print('Locale de: ${locale2.languageCode}');
  final locale3 = Locale.fromSubtags(
    languageCode: 'zh',
    scriptCode: 'Hans',
    countryCode: 'CN',
  );
  print('Locale zh_Hans_CN: ${locale3}');

  print('All dart:ui enum tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'dart:ui Enums Test',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('BlendMode values: ${BlendMode.values.length}'),
            Text('Brightness: ${Brightness.light}'),
            Text('Locale: ${locale1}'),
          ],
        ),
      ),
    ),
  );
}
