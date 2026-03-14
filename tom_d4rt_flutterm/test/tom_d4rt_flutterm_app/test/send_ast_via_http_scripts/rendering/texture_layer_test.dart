// D4rt test script: Tests TextureLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextureLayer test executing');

  // ========== TextureLayer Basic Creation ==========
  print('--- TextureLayer Basic Creation ---');
  final textureLayer = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 1,
  );
  print('  created: ${textureLayer.runtimeType}');
  print('  rect: ${textureLayer.rect}');
  print('  textureId: ${textureLayer.textureId}');
  print('  freeze: ${textureLayer.freeze}');
  print('  filterQuality: ${textureLayer.filterQuality}');

  // ========== TextureLayer with Different Rects ==========
  print('--- TextureLayer with Different Rects ---');
  final smallRect = TextureLayer(
    rect: Rect.fromLTWH(10.0, 20.0, 50.0, 50.0),
    textureId: 2,
  );
  print('  small rect: ${smallRect.rect}');
  print('  textureId: ${smallRect.textureId}');

  final largeRect = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 500.0, 300.0),
    textureId: 3,
  );
  print('  large rect: ${largeRect.rect}');
  print('  width: ${largeRect.rect.width}');
  print('  height: ${largeRect.rect.height}');

  // ========== TextureLayer with Freeze Option ==========
  print('--- TextureLayer with Freeze ---');
  final frozenTexture = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 200.0, 200.0),
    textureId: 4,
    freeze: true,
  );
  print('  freeze: ${frozenTexture.freeze}');

  final unfrozenTexture = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 200.0, 200.0),
    textureId: 5,
    freeze: false,
  );
  print('  unfrozen: ${unfrozenTexture.freeze}');

  // ========== TextureLayer with FilterQuality ==========
  print('--- TextureLayer with FilterQuality ---');
  final lowQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 6,
    filterQuality: FilterQuality.low,
  );
  print('  low quality: ${lowQuality.filterQuality}');

  final mediumQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 7,
    filterQuality: FilterQuality.medium,
  );
  print('  medium quality: ${mediumQuality.filterQuality}');

  final highQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 8,
    filterQuality: FilterQuality.high,
  );
  print('  high quality: ${highQuality.filterQuality}');

  final noneQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 9,
    filterQuality: FilterQuality.none,
  );
  print('  none quality: ${noneQuality.filterQuality}');

  // ========== TextureLayer Properties Modification ==========
  print('--- TextureLayer Properties Modification ---');
  final mutableLayer = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 10,
  );
  print('  initial rect: ${mutableLayer.rect}');
  mutableLayer.rect = Rect.fromLTWH(50.0, 50.0, 150.0, 150.0);
  print('  modified rect: ${mutableLayer.rect}');

  mutableLayer.textureId = 99;
  print('  modified textureId: ${mutableLayer.textureId}');

  mutableLayer.freeze = true;
  print('  modified freeze: ${mutableLayer.freeze}');

  mutableLayer.filterQuality = FilterQuality.high;
  print('  modified filterQuality: ${mutableLayer.filterQuality}');

  // ========== TextureLayer Layer Hierarchy ==========
  print('--- TextureLayer Layer Hierarchy ---');
  print('  parent: ${textureLayer.parent}');
  print('  nextSibling: ${textureLayer.nextSibling}');
  print('  previousSibling: ${textureLayer.previousSibling}');
  print('  alwaysNeedsAddToScene: ${textureLayer.alwaysNeedsAddToScene}');
  print('  debugCreator: ${textureLayer.debugCreator}');

  print('TextureLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('TextureLayer Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('TextureLayer: ${textureLayer.runtimeType}'),
          Text('Rect: ${textureLayer.rect}'),
          Text('TextureId: ${textureLayer.textureId}'),
          Text('Freeze: ${textureLayer.freeze}'),
          Text('FilterQuality values tested: none, low, medium, high'),
          Text('Properties modifiable: rect, textureId, freeze'),
        ],
      ),
    ),
  );
}
