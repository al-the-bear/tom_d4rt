// D4rt Deep Demo: BackdropFilterEngineLayer - Scene Composition Blur Effects
// This demo comprehensively explores BackdropFilterEngineLayer which provides
// efficient backdrop blur and filter effects in Flutter's scene composition system.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );
  print(
    '                 BACKDROPFILTERENGINELAYER DEEP DEMO                       ',
  );
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: BackdropFilterEngineLayer Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 1: Fundamentals');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('BackdropFilterEngineLayer is a compositing layer that:');
  print('- Applies ImageFilter effects to backdrop content');
  print('- Created via SceneBuilder.pushBackdropFilter()');
  print('- Used for blur effects behind UI elements');
  print('- Part of Flutter\'s low-level rendering system');
  print('');
  print('Key characteristics:');
  print('- Extends EngineLayer base class');
  print('- Applied to content BEHIND the layer, not in front');
  print('- Supports various ImageFilter types');
  print('- GPU-accelerated for performance');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 2: Creating BackdropFilterEngineLayer
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 2: Creating BackdropFilterEngineLayer');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );

  final builder1 = ui.SceneBuilder();
  print('Created SceneBuilder instance');

  // Create a blur filter
  final blurFilter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  print('Created blur filter with sigma 5.0x5.0');

  // Push backdrop filter - returns BackdropFilterEngineLayer
  final layer1 = builder1.pushBackdropFilter(blurFilter);
  print('');
  print('pushBackdropFilter() result:');
  print('  Type: ${layer1.runtimeType}');
  print('  Is EngineLayer: ${layer1 is ui.EngineLayer}');

  builder1.pop();
  final scene1 = builder1.build();
  scene1.dispose();

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 3: Different Blur Configurations
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 3: Blur Configurations');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );

  void testBlurConfig(
    String name,
    double sigmaX,
    double sigmaY,
    ui.TileMode tileMode,
  ) {
    final builder = ui.SceneBuilder();
    final filter = ui.ImageFilter.blur(
      sigmaX: sigmaX,
      sigmaY: sigmaY,
      tileMode: tileMode,
    );
    final layer = builder.pushBackdropFilter(filter);
    print('$name: sigmaX=$sigmaX, sigmaY=$sigmaY, tileMode=${tileMode.name}');
    print('  → Layer type: ${layer.runtimeType}');
    builder.pop();
    builder.build().dispose();
  }

  print('Testing various blur configurations:');
  testBlurConfig('Light blur', 2.0, 2.0, ui.TileMode.clamp);
  testBlurConfig('Medium blur', 8.0, 8.0, ui.TileMode.clamp);
  testBlurConfig('Heavy blur', 20.0, 20.0, ui.TileMode.clamp);
  testBlurConfig('Horizontal only', 10.0, 0.0, ui.TileMode.clamp);
  testBlurConfig('Vertical only', 0.0, 10.0, ui.TileMode.clamp);
  testBlurConfig('Asymmetric', 15.0, 5.0, ui.TileMode.clamp);
  testBlurConfig('With repeat', 5.0, 5.0, ui.TileMode.repeated);
  testBlurConfig('With mirror', 5.0, 5.0, ui.TileMode.mirror);
  testBlurConfig('With decal', 5.0, 5.0, ui.TileMode.decal);

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 4: BlendMode with Backdrop Filter
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 4: BlendMode Options');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );

  final blendModes = [
    BlendMode.srcOver,
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
    BlendMode.darken,
    BlendMode.lighten,
    BlendMode.colorDodge,
    BlendMode.colorBurn,
  ];

  print('Testing backdrop filter with different blend modes:');
  for (final mode in blendModes) {
    final builder = ui.SceneBuilder();
    final filter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
    final layer = builder.pushBackdropFilter(filter, blendMode: mode);
    print('  BlendMode.${mode.name} → ${layer.runtimeType}');
    builder.pop();
    builder.build().dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 5: Layer Hierarchy with Backdrop Filter
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 5: Layer Hierarchy');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('BackdropFilterEngineLayer in scene tree:');
  print('');

  final builder2 = ui.SceneBuilder();

  // Push transform layer
  final transformLayer = builder2.pushTransform(Matrix4.identity().storage);
  print('Pushed TransformEngineLayer: ${transformLayer.runtimeType}');

  // Push offset layer
  final offsetLayer = builder2.pushOffset(10.0, 10.0);
  print('  Pushed OffsetEngineLayer: ${offsetLayer.runtimeType}');

  // Push backdrop filter layer
  final backdropLayer = builder2.pushBackdropFilter(
    ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
  );
  print('    Pushed BackdropFilterEngineLayer: ${backdropLayer.runtimeType}');

  // Push opacity layer inside backdrop
  final opacityLayer = builder2.pushOpacity(200);
  print('      Pushed OpacityEngineLayer: ${opacityLayer.runtimeType}');

  builder2.pop(); // opacity
  builder2.pop(); // backdrop
  builder2.pop(); // offset
  builder2.pop(); // transform

  final scene2 = builder2.build();
  print('');
  print('Scene hierarchy built with nested layers');
  scene2.dispose();

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 6: Matrix Filter Alternative
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 6: Matrix Filter');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('BackdropFilter can also use matrix-based filters:');
  print('');

  // Identity matrix (no change)
  final identityMatrix = Float64List.fromList([
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  final matrixFilter = ui.ColorFilter.matrix(identityMatrix);
  print('Matrix filter (identity): $matrixFilter');

  // Grayscale conversion matrix
  final grayscaleMatrix = Float64List.fromList([
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  final grayscaleFilter = ui.ColorFilter.matrix(grayscaleMatrix);
  print('Grayscale matrix filter: Created');

  // Note: ColorFilter can be composed with blur
  final composedFilter = ui.ImageFilter.compose(
    outer: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
    inner: ui.ColorFilter.mode(Colors.blue.withOpacity(0.3), BlendMode.overlay),
  );
  print('Composed filter (blur + color): Created');

  // Test in SceneBuilder
  final builder3 = ui.SceneBuilder();
  final composedLayer = builder3.pushBackdropFilter(composedFilter);
  print('pushBackdropFilter with composed: ${composedLayer.runtimeType}');
  builder3.pop();
  builder3.build().dispose();

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: OldLayer Reuse Pattern
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 7: Layer Reuse (oldLayer)');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('BackdropFilterEngineLayer supports reuse via oldLayer parameter:');
  print('');

  // First frame
  final builderA = ui.SceneBuilder();
  final filterA = ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  final layerA = builderA.pushBackdropFilter(filterA);
  print('Frame 1: Created new layer → ${layerA.runtimeType}');
  builderA.pop();
  builderA.build().dispose();

  // Second frame - reuse layer
  final builderB = ui.SceneBuilder();
  final filterB = ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  final layerB = builderB.pushBackdropFilter(filterB, oldLayer: layerA);
  print('Frame 2: Reused layer → ${layerB.runtimeType}');
  print('  Same instance: ${identical(layerA, layerB)}');
  builderB.pop();
  builderB.build().dispose();

  print('');
  print('Benefits of oldLayer reuse:');
  print('  • Reduces layer allocation');
  print('  • Improves frame performance');
  print('  • Maintains render cache');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 8: Performance');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('BackdropFilterEngineLayer performance tips:');
  print('');
  print('GPU Cost:');
  print('  • Backdrop filter is expensive (full screen read)');
  print('  • Cost increases with blur sigma');
  print('  • Multiple overlapping filters compound cost');
  print('');
  print('Optimization strategies:');
  print('  • Minimize blur radius (sigma)');
  print('  • Use RepaintBoundary to isolate regions');
  print('  • Avoid animating blur sigma');
  print('  • Prefer pre-blurred images for static content');
  print('  • Use cacheExtent wisely');
  print('');
  print('Blur sigma performance tiers:');
  print('┌─────────────┬────────────────┬──────────────┐');
  print('│   Sigma     │   Quality      │    Cost      │');
  print('├─────────────┼────────────────┼──────────────┤');
  print('│   1-5       │   Subtle       │    Low       │');
  print('│   5-15      │   Medium       │    Medium    │');
  print('│   15-30     │   Heavy        │    High      │');
  print('│   30+       │   Extreme      │    Very High │');
  print('└─────────────┴────────────────┴──────────────┘');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: Comparison with BackdropFilter Widget
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 9: Widget vs Engine Layer');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('BackdropFilter widget vs BackdropFilterEngineLayer:');
  print('');
  print('BackdropFilter Widget (high-level):');
  print('  • Easy to use in widget tree');
  print('  • Automatically manages layer');
  print('  • Includes clip bounds');
  print('  • Handles layer caching');
  print('');
  print('BackdropFilterEngineLayer (low-level):');
  print('  • Direct scene graph control');
  print('  • Used by custom RenderObjects');
  print('  • Manual layer lifecycle');
  print('  • Maximum flexibility');
  print('');
  print('Widget implementation (simplified):');
  print('''
  // BackdropFilter creates BackdropFilterEngineLayer internally
  BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      color: Colors.white.withOpacity(0.5),
      child: Text('Frosted glass effect'),
    ),
  )
  ''');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Real-World Use Cases
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 10: Use Cases');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Common backdrop filter applications:');
  print('');
  print('1. iOS-style Frosted Glass:');
  print('   • Navigation bars');
  print('   • Tab bars');
  print('   • Modal sheets');
  print('');
  print('2. Dialog/Modal Backgrounds:');
  print('   • Blur content behind dialogs');
  print('   • Focus user attention');
  print('   • Privacy blur');
  print('');
  print('3. Image Overlays:');
  print('   • Text readability on images');
  print('   • Card overlays');
  print('   • Hero image headers');
  print('');
  print('4. Depth Effects:');
  print('   • Tilt-shift photography');
  print('   • Focus indicators');
  print('   • Z-depth simulation');

  print(
    '\n═══════════════════════════════════════════════════════════════════════════',
  );
  print(
    '              BACKDROPFILTERENGINELAYER DEEP DEMO COMPLETE                 ',
  );
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );

  // ═══════════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION UI
  // ═══════════════════════════════════════════════════════════════════════════════
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade600, Colors.blue.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.blur_on, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'BackdropFilterEngineLayer',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'GPU-Accelerated Backdrop Blur',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Blur Effect Showcase
          Text(
            'Blur Effect Demonstration',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          // Background with blur overlays
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/800/400?blur=0'),
                fit: BoxFit.cover,
                onError: (_, __) {},
              ),
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.orange, Colors.pink],
              ),
            ),
            child: Stack(
              children: [
                // Frosted glass card
                Positioned(
                  left: 16,
                  top: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Frosted Glass',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'sigma: 10.0',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Medium blur circle
                Positioned(
                  right: 60,
                  top: 30,
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'σ=20',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Light blur bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Text(
                          'Light blur navigation bar (sigma: 5)',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Blur Sigma Comparison
          Text(
            'Blur Sigma Comparison',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Row(
            children: [
              _buildBlurCard('No Blur', 0, Colors.grey),
              SizedBox(width: 8),
              _buildBlurCard('σ = 3', 3, Colors.lightBlue),
              SizedBox(width: 8),
              _buildBlurCard('σ = 10', 10, Colors.blue),
              SizedBox(width: 8),
              _buildBlurCard('σ = 25', 25, Colors.indigo),
            ],
          ),

          SizedBox(height: 24),

          // Performance Guide
          Text(
            'Performance Guide',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
              ],
            ),
            child: Column(
              children: [
                _buildPerfRow(
                  'Sigma 1-5',
                  'Subtle',
                  '🟢 Low GPU cost',
                  Colors.green,
                ),
                Divider(),
                _buildPerfRow(
                  'Sigma 5-15',
                  'Medium',
                  '🟡 Moderate cost',
                  Colors.orange,
                ),
                Divider(),
                _buildPerfRow(
                  'Sigma 15-30',
                  'Heavy',
                  '🟠 High cost',
                  Colors.deepOrange,
                ),
                Divider(),
                _buildPerfRow(
                  'Sigma 30+',
                  'Extreme',
                  '🔴 Very high cost',
                  Colors.red,
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Layer Hierarchy
          Text(
            'Scene Layer Hierarchy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLayerNode('SceneBuilder', Icons.layers, 0),
                _buildLayerNode('TransformEngineLayer', Icons.transform, 1),
                _buildLayerNode('OffsetEngineLayer', Icons.open_with, 2),
                _buildLayerNode('BackdropFilterEngineLayer', Icons.blur_on, 3),
                _buildLayerNode('OpacityEngineLayer', Icons.opacity, 4),
                _buildLayerNode('PictureLayer (content)', Icons.image, 5),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Use Cases
          Text(
            'Common Use Cases',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildUseCaseChip('Frosted Glass UI', Icons.blur_circular),
              _buildUseCaseChip('Modal Dialogs', Icons.web_asset),
              _buildUseCaseChip('Navigation Bars', Icons.navigation),
              _buildUseCaseChip('Image Overlays', Icons.photo_filter),
              _buildUseCaseChip('Privacy Blur', Icons.visibility_off),
              _buildUseCaseChip('Depth Effects', Icons.layers),
            ],
          ),

          SizedBox(height: 32),

          // Footer
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🌫️ BackdropFilterEngineLayer Deep Demo',
                style: TextStyle(
                  color: Colors.cyan.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBlurCard(String label, double sigma, Color color) {
  return Expanded(
    child: Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade300, Colors.purple.shade300],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: sigma > 0
            ? BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : Container(
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
      ),
    ),
  );
}

Widget _buildPerfRow(String sigma, String quality, String cost, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(sigma, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(child: Text(quality)),
        Expanded(child: Text(cost, style: TextStyle(fontSize: 12))),
      ],
    ),
  );
}

Widget _buildLayerNode(String name, IconData icon, int depth) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, top: 8, bottom: 8),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.cyan.shade600),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            fontWeight: depth == 3 ? FontWeight.bold : FontWeight.normal,
            color: depth == 3 ? Colors.cyan.shade800 : Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.cyan.shade600),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.cyan.shade800),
        ),
      ],
    ),
  );
}
