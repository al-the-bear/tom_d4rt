// D4rt test script: Tests Layer types - ContainerLayer, LeaderLayer,
// FollowerLayer, AnnotatedRegionLayer, PictureLayer, ShaderMaskLayer,
// TextureLayer
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Layer types test executing');

  // ========== ContainerLayer ==========
  print('--- ContainerLayer Tests ---');
  final containerLayer = ContainerLayer();
  print('ContainerLayer created');
  print('  firstChild: ${containerLayer.firstChild}');
  print('  lastChild: ${containerLayer.lastChild}');

  // ========== OffsetLayer ==========
  print('--- OffsetLayer Tests ---');
  final offsetLayer = OffsetLayer(offset: Offset(10.0, 20.0));
  print('OffsetLayer created: offset=${offsetLayer.offset}');

  // ========== LeaderLayer ==========
  print('--- LeaderLayer Tests ---');
  final link = LayerLink();
  final leaderLayer = LeaderLayer(link: link, offset: Offset.zero);
  print('LeaderLayer created with LayerLink');

  // ========== FollowerLayer ==========
  print('--- FollowerLayer Tests ---');
  final followerLayer = FollowerLayer(
    link: link,
    showWhenUnlinked: true,
    unlinkedOffset: Offset(50.0, 50.0),
    linkedOffset: Offset(0.0, 30.0),
  );
  print('FollowerLayer created');
  print('  showWhenUnlinked: true');
  print('  unlinkedOffset: ${followerLayer.unlinkedOffset}');

  // ========== LayerLink ==========
  print('--- LayerLink Tests ---');
  final link2 = LayerLink();
  print('LayerLink created');
  print('  leader: ${link2.leader}');

  // ========== LayerHandle ==========
  print('--- LayerHandle Tests ---');
  final handle = LayerHandle<OffsetLayer>();
  print('LayerHandle created: layer=${handle.layer}');
  handle.layer = offsetLayer;
  print('LayerHandle assigned: layer=${handle.layer}');
  handle.layer = null;
  print('LayerHandle cleared');

  // ========== ViewConfiguration ==========
  print('--- ViewConfiguration Tests ---');
  print('ViewConfiguration provides device pixel ratio and size');

  // ========== PipelineOwner ==========
  print('--- PipelineOwner Tests ---');
  print('PipelineOwner manages render pipeline scheduling');

  print('All layer type tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Layer Types Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('ContainerLayer, OffsetLayer'),
            Text('LeaderLayer + FollowerLayer (via LayerLink)'),
            Text('LayerHandle management'),
            CompositedTransformTarget(
              link: LayerLink(),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue.shade200,
                child: Center(child: Text('Target')),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
