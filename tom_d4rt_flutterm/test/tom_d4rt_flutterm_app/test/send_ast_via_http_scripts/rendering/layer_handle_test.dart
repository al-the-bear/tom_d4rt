// D4rt test script: Tests LayerHandle from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LayerHandle test executing');

  // ========== Basic LayerHandle creation ==========
  print('--- Basic LayerHandle ---');
  final handle1 = LayerHandle<ContainerLayer>();
  print('  created: ${handle1.runtimeType}');
  print('  layer: ${handle1.layer}');

  // ========== LayerHandle with different layer types ==========
  print('--- Different layer types ---');
  final containerHandle = LayerHandle<ContainerLayer>();
  print('  ContainerLayer handle: ${containerHandle.runtimeType}');
  
  final offsetHandle = LayerHandle<OffsetLayer>();
  print('  OffsetLayer handle: ${offsetHandle.runtimeType}');
  
  final transformHandle = LayerHandle<TransformLayer>();
  print('  TransformLayer handle: ${transformHandle.runtimeType}');
  
  final opacityHandle = LayerHandle<OpacityLayer>();
  print('  OpacityLayer handle: ${opacityHandle.runtimeType}');

  // ========== Setting layer on handle ==========
  print('--- Setting layer on handle ---');
  final containerLayer = ContainerLayer();
  final handleWithLayer = LayerHandle<ContainerLayer>();
  handleWithLayer.layer = containerLayer;
  print('  handle.layer set: ${handleWithLayer.layer != null}');
  print('  layer runtimeType: ${handleWithLayer.layer?.runtimeType}');

  // ========== OffsetLayer handle ==========
  print('--- OffsetLayer handle ---');
  final offsetLayer = OffsetLayer(offset: Offset(10.0, 20.0));
  final offsetLayerHandle = LayerHandle<OffsetLayer>();
  offsetLayerHandle.layer = offsetLayer;
  print('  offset layer set');
  print('  offset: ${offsetLayerHandle.layer?.offset}');

  // ========== TransformLayer handle ==========
  print('--- TransformLayer handle ---');
  final transformLayer = TransformLayer(transform: Matrix4.identity());
  final transformLayerHandle = LayerHandle<TransformLayer>();
  transformLayerHandle.layer = transformLayer;
  print('  transform layer set');
  print('  transform: ${transformLayerHandle.layer?.transform}');

  // ========== OpacityLayer handle ==========
  print('--- OpacityLayer handle ---');
  final opacityLayer = OpacityLayer(alpha: 128);
  final opacityLayerHandle = LayerHandle<OpacityLayer>();
  opacityLayerHandle.layer = opacityLayer;
  print('  opacity layer set');
  print('  alpha: ${opacityLayerHandle.layer?.alpha}');

  // ========== Clearing layer handle ==========
  print('--- Clearing layer handle ---');
  final clearHandle = LayerHandle<ContainerLayer>();
  clearHandle.layer = ContainerLayer();
  print('  before clear: ${clearHandle.layer != null}');
  clearHandle.layer = null;
  print('  after clear: ${clearHandle.layer}');

  // ========== Multiple handles to same layer type ==========
  print('--- Multiple handles ---');
  final multiHandle1 = LayerHandle<OffsetLayer>();
  final multiHandle2 = LayerHandle<OffsetLayer>();
  final multiHandle3 = LayerHandle<OffsetLayer>();
  multiHandle1.layer = OffsetLayer(offset: Offset(0.0, 0.0));
  multiHandle2.layer = OffsetLayer(offset: Offset(10.0, 10.0));
  multiHandle3.layer = OffsetLayer(offset: Offset(20.0, 20.0));
  print('  handle1 offset: ${multiHandle1.layer?.offset}');
  print('  handle2 offset: ${multiHandle2.layer?.offset}');
  print('  handle3 offset: ${multiHandle3.layer?.offset}');

  // ========== LayerHandle lifecycle ==========
  print('--- LayerHandle lifecycle ---');
  final lifecycleHandle = LayerHandle<ContainerLayer>();
  print('  initial layer: ${lifecycleHandle.layer}');
  lifecycleHandle.layer = ContainerLayer();
  print('  after assignment: ${lifecycleHandle.layer != null}');
  final previousLayer = lifecycleHandle.layer;
  lifecycleHandle.layer = ContainerLayer();
  print('  after reassignment: different layer');

  print('LayerHandle test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('LayerHandle Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Basic handle: ${handle1.runtimeType}'),
          Text('Initial layer: null'),
          SizedBox(height: 8.0),
          Text('Layer types:'),
          Text('  - ContainerLayer'),
          Text('  - OffsetLayer'),
          Text('  - TransformLayer'),
          Text('  - OpacityLayer'),
          SizedBox(height: 8.0),
          Text('Handle with layer: ${handleWithLayer.layer != null}'),
          Text('Offset layer offset: ${offsetLayerHandle.layer?.offset}'),
          Text('Opacity layer alpha: ${opacityLayerHandle.layer?.alpha}'),
        ],
      ),
    ),
  );
}
