// D4rt test script: Tests rendering layer classes and PaintingContext
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering layers test executing');

  // Note: Most Layer classes are internal to the rendering pipeline.
  // Testing them directly is limited, but we can demonstrate concepts.

  // ========== LAYER CONCEPTS ==========
  print('--- Layer Architecture Info ---');
  print('Layer is the base class for all compositing layers');
  print('ContainerLayer is a layer that can have child layers');
  print('OffsetLayer is a layer that applies an offset transform');
  print('PictureLayer holds a ui.Picture for painting');
  print('TextureLayer displays external textures');
  print('ClipRectLayer clips child layers to a rectangle');
  print('ClipRRectLayer clips child layers to a rounded rectangle');
  print('ClipPathLayer clips child layers to a path');
  print('OpacityLayer applies opacity to child layers');
  print('ShaderMaskLayer applies a shader mask to child layers');
  print('BackdropFilterLayer applies a backdrop filter');

  // ========== OFFSET LAYER ==========
  print('--- OffsetLayer Tests ---');

  final offsetLayer = OffsetLayer();
  print('OffsetLayer created');

  // Set offset
  offsetLayer.offset = Offset(10.0, 20.0);
  print('OffsetLayer offset: ${offsetLayer.offset}');

  // ========== CLIP RECT LAYER ==========
  print('--- ClipRectLayer Tests ---');

  final clipRectLayer = ClipRectLayer(
    clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
  );
  print('ClipRectLayer clipRect: ${clipRectLayer.clipRect}');

  // Test clipBehavior
  final hardEdgeClip = ClipRectLayer(
    clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    clipBehavior: Clip.hardEdge,
  );
  print(
    'ClipRectLayer with hardEdge: clipBehavior=${hardEdgeClip.clipBehavior}',
  );

  final antiAliasClip = ClipRectLayer(
    clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    clipBehavior: Clip.antiAlias,
  );
  print(
    'ClipRectLayer with antiAlias: clipBehavior=${antiAliasClip.clipBehavior}',
  );

  // ========== CLIP RRECT LAYER ==========
  print('--- ClipRRectLayer Tests ---');

  final clipRRectLayer = ClipRRectLayer(
    clipRRect: RRect.fromRectAndRadius(
      Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
      Radius.circular(10.0),
    ),
  );
  print('ClipRRectLayer created with rounded rect');

  // ========== CLIP PATH LAYER ==========
  print('--- ClipPathLayer Tests ---');

  final path = Path()
    ..moveTo(50.0, 0.0)
    ..lineTo(100.0, 40.0)
    ..lineTo(80.0, 100.0)
    ..lineTo(20.0, 100.0)
    ..lineTo(0.0, 40.0)
    ..close();

  final clipPathLayer = ClipPathLayer(clipPath: path);
  print('ClipPathLayer created with pentagon path');

  // ========== OPACITY LAYER ==========
  print('--- OpacityLayer Tests ---');

  final opacityLayer = OpacityLayer(alpha: 128);
  print('OpacityLayer alpha: ${opacityLayer.alpha}');

  final fullOpacity = OpacityLayer(alpha: 255);
  print('Full opacity: alpha=${fullOpacity.alpha}');

  final halfOpacity = OpacityLayer(alpha: 128);
  print('Half opacity: alpha=${halfOpacity.alpha}');

  final quarterOpacity = OpacityLayer(alpha: 64);
  print('Quarter opacity: alpha=${quarterOpacity.alpha}');

  // Test with offset
  final opacityWithOffset = OpacityLayer(
    alpha: 200,
    offset: Offset(10.0, 10.0),
  );
  print('OpacityLayer with offset: offset=${opacityWithOffset.offset}');

  // ========== TRANSFORM LAYER ==========
  print('--- TransformLayer Tests ---');

  final transformLayer = TransformLayer(
    transform: Matrix4.identity()
      ..translate(50.0, 50.0)
      ..rotateZ(0.785),
  );
  print('TransformLayer created with rotation transform');

  // ========== LEADER LAYER & FOLLOWER LAYER ==========
  print('--- LeaderLayer / FollowerLayer Tests ---');

  final layerLink = LayerLink();
  print('LayerLink created');

  final leaderLayer = LeaderLayer(
    link: layerLink,
    offset: Offset(10.0, 20.0),
  );
  print('LeaderLayer created with offset: ${leaderLayer.offset}');

  final followerLayer = FollowerLayer(
    link: layerLink,
    unlinkedOffset: Offset(5.0, 5.0),
    showWhenUnlinked: false,
  );
  print('FollowerLayer created, showWhenUnlinked: ${followerLayer.showWhenUnlinked}');
  print('FollowerLayer unlinkedOffset: ${followerLayer.unlinkedOffset}');

  // ========== BACKDROP FILTER LAYER ==========
  print('--- BackdropFilterLayer Tests ---');

  final backdropFilterLayer = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  );
  print('BackdropFilterLayer created with blur filter');

  // Test with blend mode
  final backdropWithBlend = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    blendMode: BlendMode.srcOver,
  );
  print('BackdropFilterLayer with blendMode: ${backdropWithBlend.blendMode}');

  // ========== COLOR FILTER LAYER ==========
  print('--- ColorFilterLayer Tests ---');

  final colorFilterLayer = ColorFilterLayer(
    colorFilter: ColorFilter.mode(Color(0x80FF0000), BlendMode.srcOver),
  );
  print('ColorFilterLayer created with red tint');

  final grayscaleFilter = ColorFilterLayer(
    colorFilter: ColorFilter.matrix([
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ]),
  );
  print('ColorFilterLayer with grayscale matrix');

  // ========== IMAGE FILTER LAYER ==========
  print('--- ImageFilterLayer Tests ---');

  final imageFilterLayer = ImageFilterLayer(
    imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
  );
  print('ImageFilterLayer with blur');

  // ========== SHADER MASK LAYER ==========
  print('--- ShaderMaskLayer Tests ---');

  final gradient = LinearGradient(
    colors: [Color(0xFF000000), Color(0x00000000)],
  );
  final shaderMaskLayer = ShaderMaskLayer(
    shader: gradient.createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 100.0)),
    maskRect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    blendMode: BlendMode.dstIn,
  );
  print('ShaderMaskLayer created with gradient mask');

  print('Rendering layers test completed');

  // Return a visual representation demonstrating layer effects
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Layer Architecture Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Opacity Layers:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(1.0),
                  child: Center(
                    child: Text(
                      '100%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(0.75),
                  child: Center(
                    child: Text(
                      '75%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(0.5),
                  child: Center(
                    child: Text(
                      '50%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(0.25),
                  child: Center(
                    child: Text(
                      '25%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Clip Layers:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Column(
                  children: [
                    ClipRect(
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        color: Color(0xFFE53935),
                        child: Center(
                          child: Text(
                            'ClipRect',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text('Rect', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        color: Color(0xFF4CAF50),
                        child: Center(
                          child: Text(
                            'ClipRRect',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text('RRect', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        color: Color(0xFF2196F3),
                        child: Center(
                          child: Text(
                            'ClipOval',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text('Oval', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Physical Model (Elevation):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('1dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('4dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('8dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 16.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('16dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Transform Layer:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Transform.rotate(
                  angle: 0.0,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        '0°',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Transform.rotate(
                  angle: 0.262,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        '15°',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Transform.rotate(
                  angle: 0.785,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        '45°',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Transform.scale(
                  scale: 0.8,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFF9C27B0),
                    child: Center(
                      child: Text(
                        '0.8x',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
