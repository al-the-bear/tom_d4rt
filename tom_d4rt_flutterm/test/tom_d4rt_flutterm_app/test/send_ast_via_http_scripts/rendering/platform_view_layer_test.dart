// D4rt test script: Tests PlatformViewLayer from rendering
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewLayer test executing');

  // ========== Basic PlatformViewLayer creation ==========
  print('--- Basic PlatformViewLayer ---');
  final layer1 = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 1,
  );
  print('  created: ${layer1.runtimeType}');
  print('  rect: ${layer1.rect}');
  print('  viewId: ${layer1.viewId}');

  // ========== Different rect configurations ==========
  print('--- Different rect configurations ---');
  final layer2 = PlatformViewLayer(
    rect: Rect.fromLTRB(10.0, 20.0, 110.0, 220.0),
    viewId: 2,
  );
  print('  rect fromLTRB: ${layer2.rect}');
  print('  width: ${layer2.rect.width}');
  print('  height: ${layer2.rect.height}');

  final layer3 = PlatformViewLayer(
    rect: Rect.fromCenter(
      center: Offset(50.0, 50.0),
      width: 80.0,
      height: 60.0,
    ),
    viewId: 3,
  );
  print('  rect fromCenter: ${layer3.rect}');
  print('  center: ${layer3.rect.center}');

  // ========== Zero-sized rect ==========
  print('--- Zero-sized rect ---');
  final layerZero = PlatformViewLayer(rect: Rect.zero, viewId: 4);
  print('  rect.isEmpty: ${layerZero.rect.isEmpty}');
  print('  rect: ${layerZero.rect}');

  // ========== Large viewId ==========
  print('--- Large viewId ---');
  final layerLarge = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
    viewId: 999999,
  );
  print('  viewId: ${layerLarge.viewId}');

  // ========== Layer properties ==========
  print('--- Layer properties ---');
  print('  layer1.parent: ${layer1.parent}');
  print('  layer1.nextSibling: ${layer1.nextSibling}');
  print('  layer1.previousSibling: ${layer1.previousSibling}');
  print('  layer1.firstChild: ${layer1.firstChild}');
  print('  layer1.lastChild: ${layer1.lastChild}');
  print('  layer1.attached: ${layer1.attached}');
  print(
    '  layer1.debugSubtreeNeedsAddToScene: ${layer1.debugSubtreeNeedsAddToScene}',
  );

  // ========== ContainerLayer as parent ==========
  print('--- ContainerLayer as parent ---');
  final container = ContainerLayer();
  container.append(layer1);
  print('  layer1.parent != null after append: ${layer1.parent != null}');
  print('  container.firstChild: ${container.firstChild}');
  print('  container.lastChild: ${container.lastChild}');

  // ========== Multiple layers in container ==========
  print('--- Multiple layers in container ---');
  final container2 = ContainerLayer();
  final pvLayer1 = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 10,
  );
  final pvLayer2 = PlatformViewLayer(
    rect: Rect.fromLTWH(100.0, 0.0, 100.0, 100.0),
    viewId: 11,
  );
  final pvLayer3 = PlatformViewLayer(
    rect: Rect.fromLTWH(200.0, 0.0, 100.0, 100.0),
    viewId: 12,
  );
  container2.append(pvLayer1);
  container2.append(pvLayer2);
  container2.append(pvLayer3);
  print(
    '  pvLayer1.nextSibling == pvLayer2: ${pvLayer1.nextSibling == pvLayer2}',
  );
  print(
    '  pvLayer2.previousSibling == pvLayer1: ${pvLayer2.previousSibling == pvLayer1}',
  );
  print(
    '  pvLayer3.previousSibling == pvLayer2: ${pvLayer3.previousSibling == pvLayer2}',
  );

  // ========== Remove from parent ==========
  print('--- Remove from parent ---');
  pvLayer2.remove();
  print('  After remove pvLayer2:');
  print(
    '  pvLayer1.nextSibling == pvLayer3: ${pvLayer1.nextSibling == pvLayer3}',
  );
  print(
    '  pvLayer3.previousSibling == pvLayer1: ${pvLayer3.previousSibling == pvLayer1}',
  );
  print('  pvLayer2.parent: ${pvLayer2.parent}');

  // ========== Equality and hashCode ==========
  print('--- Equality and hashCode ---');
  final layerA = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 100,
  );
  final layerB = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 100,
  );
  print('  layerA == layerA: ${layerA == layerA}');
  print('  layerA == layerB: ${layerA == layerB}');
  print('  layerA.hashCode: ${layerA.hashCode}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  layer1.toString(): ${layer1.toString()}');

  print('PlatformViewLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PlatformViewLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic layer rect: ${layer1.rect}'),
          Text('Basic layer viewId: ${layer1.viewId}'),
          Text('FromCenter rect: ${layer3.rect}'),
          Text('Large viewId: ${layerLarge.viewId}'),
          Text('Container hierarchy verified'),
          Text('Layer removal verified'),
        ],
      ),
    ),
  );
}
