// D4rt test script: Deep Demo for EngineLayer from dart:ui
// EngineLayer is the abstract base class for all scene-graph engine layers
// returned by SceneBuilder methods (push*, addRetained)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== EngineLayer Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ABOUT ENGINE LAYER
  // ═══════════════════════════════════════════════════════════════════════════

  // EngineLayer is abstract — never directly constructed
  // It is returned by SceneBuilder.push* methods:
  //   pushOffset, pushTransform, pushClipRect, pushClipRRect,
  //   pushClipPath, pushOpacity, pushColorFilter, pushImageFilter,
  //   pushBackdropFilter, pushShaderMask
  print('EngineLayer is abstract base of all scene engine layers');
  print('Returned by SceneBuilder.push* methods');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CONCRETE SUBTYPES
  // ═══════════════════════════════════════════════════════════════════════════

  // Demonstrate the concrete subtypes
  final builder = ui.SceneBuilder();

  final offsetLayer = builder.pushOffset(10, 20);
  print('pushOffset → ${offsetLayer.runtimeType}');
  builder.pop();

  final opacityLayer = builder.pushOpacity(128);
  print('pushOpacity → ${opacityLayer.runtimeType}');
  builder.pop();

  final clipRectLayer = builder.pushClipRect(Rect.fromLTWH(0, 0, 200, 200));
  print('pushClipRect → ${clipRectLayer.runtimeType}');
  builder.pop();

  final clipRRectLayer = builder.pushClipRRect(
    RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, 200, 200), Radius.circular(16)),
  );
  print('pushClipRRect → ${clipRRectLayer.runtimeType}');
  builder.pop();

  final transformLayer = builder.pushTransform(Matrix4.identity().storage);
  print('pushTransform → ${transformLayer.runtimeType}');
  builder.pop();

  final colorFilterLayer = builder.pushColorFilter(
    ColorFilter.mode(Colors.red, BlendMode.colorBurn),
  );
  print('pushColorFilter → ${colorFilterLayer.runtimeType}');
  builder.pop();

  final imageFilterLayer = builder.pushImageFilter(
    ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  );
  print('pushImageFilter → ${imageFilterLayer.runtimeType}');
  builder.pop();

  final backdropFilterLayer = builder.pushBackdropFilter(
    ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  );
  print('pushBackdropFilter → ${backdropFilterLayer.runtimeType}');
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: DISPOSE
  // ═══════════════════════════════════════════════════════════════════════════

  // EngineLayer has a dispose() method for cleanup
  print('EngineLayer.dispose() releases native resources');
  print('Called when layer is no longer reused via oldLayer parameter');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: RETAINED RENDERING
  // ═══════════════════════════════════════════════════════════════════════════

  print('Retained rendering with oldLayer:');
  print('  1. First frame: layer = builder.pushOffset(x, y)');
  print(
    '  2. Next frame: newLayer = builder.pushOffset(x, y, oldLayer: layer)',
  );
  print('  3. Engine reuses GPU resources for unchanged subtree');
  print('  4. If no longer needed: layer.dispose()');

  // Demonstrate retained rendering
  final b1 = ui.SceneBuilder();
  final first = b1.pushOffset(0, 0);
  b1.pop();
  b1.build();

  final b2 = ui.SceneBuilder();
  final reused = b2.pushOffset(0, 0, oldLayer: first as ui.OffsetEngineLayer);
  b2.pop();
  b2.build();
  print('Layer reuse: first=$first, reused=$reused');

  print('EngineLayer demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final layerTypes = <_LayerType>[
    _LayerType(
      'OffsetEngineLayer',
      'pushOffset(dx, dy)',
      'Translates child content',
      Icons.open_with,
      Color(0xFF0D47A1),
    ),
    _LayerType(
      'TransformEngineLayer',
      'pushTransform(matrix4)',
      'Applies 4×4 matrix transform',
      Icons.transform,
      Color(0xFF2E7D32),
    ),
    _LayerType(
      'OpacityEngineLayer',
      'pushOpacity(alpha)',
      'Applies alpha transparency',
      Icons.opacity,
      Color(0xFF6A1B9A),
    ),
    _LayerType(
      'ClipRectEngineLayer',
      'pushClipRect(rect)',
      'Clips to a rectangle',
      Icons.crop_square,
      Color(0xFFBF360C),
    ),
    _LayerType(
      'ClipRRectEngineLayer',
      'pushClipRRect(rrect)',
      'Clips to a rounded rectangle',
      Icons.rounded_corner,
      Color(0xFF00695C),
    ),
    _LayerType(
      'ClipPathEngineLayer',
      'pushClipPath(path)',
      'Clips to an arbitrary path',
      Icons.gesture,
      Color(0xFF4E342E),
    ),
    _LayerType(
      'ColorFilterEngineLayer',
      'pushColorFilter(filter)',
      'Applies color filter to subtree',
      Icons.filter_vintage,
      Color(0xFFC62828),
    ),
    _LayerType(
      'ImageFilterEngineLayer',
      'pushImageFilter(filter)',
      'Applies image filter (blur etc)',
      Icons.blur_on,
      Color(0xFF1565C0),
    ),
    _LayerType(
      'BackdropFilterEngineLayer',
      'pushBackdropFilter(filter)',
      'Filters content behind layer',
      Icons.filter_hdr,
      Color(0xFF558B2F),
    ),
    _LayerType(
      'ShaderMaskEngineLayer',
      'pushShaderMask(shader)',
      'Applies shader mask gradient',
      Icons.gradient,
      Color(0xFF7B1FA2),
    ),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF263238), Color(0xFF546E7A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.layers, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'EngineLayer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Abstract base class for all SceneBuilder push layers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _headerChip('abstract'),
                        SizedBox(width: 6),
                        _headerChip('dispose()'),
                        SizedBox(width: 6),
                        _headerChip('oldLayer'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 1: Class Hierarchy ──
              _sectionTitle('1. TYPE HIERARCHY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _hierarchyNode(
                      'EngineLayer (abstract)',
                      0,
                      Color(0xFF263238),
                      true,
                    ),
                    ...layerTypes.map(
                      (lt) => _hierarchyNode(lt.name, 1, lt.color, false),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Layer Type Cards ──
              _sectionTitle('2. CONCRETE SUBTYPES (${layerTypes.length})'),
              ...layerTypes.map((lt) => _layerTypeCard(lt)),

              // ── Section 3: Retained Rendering Pipeline ──
              _sectionTitle('3. RETAINED RENDERING PIPELINE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pipelineStep(
                      1,
                      'Build Scene',
                      'layer = builder.pushOffset(dx, dy)',
                      Color(0xFF0D47A1),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      2,
                      'Store Reference',
                      'Save EngineLayer for next frame',
                      Color(0xFF2E7D32),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      3,
                      'Rebuild with oldLayer',
                      'builder.pushOffset(dx, dy, oldLayer: layer)',
                      Color(0xFFE65100),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      4,
                      'Engine Reuses GPU State',
                      'Unchanged subtree not re-rasterized',
                      Color(0xFF6A1B9A),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      5,
                      'Dispose when done',
                      'layer.dispose() releases native resources',
                      Color(0xFFC62828),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EAF6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Retained rendering dramatically reduces GPU work for '
                        'static subtrees. The engine skips re-rasterization when '
                        'an oldLayer is provided and the subtree has not changed.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 4: push/pop Pattern ──
              _sectionTitle('4. PUSH / POP PATTERN'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _codeBlock([
                      'final builder = SceneBuilder();',
                      '',
                      '// Push creates a layer scope',
                      'final layer = builder.pushOffset(10, 20);',
                      '  // Add children here',
                      '  builder.addPicture(Offset.zero, picture);',
                      '',
                      '// Pop closes the scope',
                      'builder.pop();',
                      '',
                      '// Build the scene',
                      'final scene = builder.build();',
                    ]),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        _tagChip('push', Color(0xFF0D47A1)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
                        SizedBox(width: 4),
                        _tagChip('children', Color(0xFF2E7D32)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
                        SizedBox(width: 4),
                        _tagChip('pop', Color(0xFFC62828)),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 5: Layer vs Widget ──
              _sectionTitle('5. ENGINE LAYERS vs RENDER LAYERS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.layers,
                              color: Color(0xFF0D47A1),
                              size: 24,
                            ),
                            SizedBox(height: 6),
                            Text(
                              'EngineLayer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'dart:ui level',
                              style: TextStyle(fontSize: 9),
                            ),
                            Text('Scene graph', style: TextStyle(fontSize: 9)),
                            Text(
                              'GPU compositing',
                              style: TextStyle(fontSize: 9),
                            ),
                            Text(
                              'Native resources',
                              style: TextStyle(fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        Icons.compare_arrows,
                        color: Colors.grey[400],
                        size: 18,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.account_tree,
                              color: Color(0xFFE65100),
                              size: 24,
                            ),
                            SizedBox(height: 6),
                            Text(
                              'RenderObject',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFFE65100),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Framework level',
                              style: TextStyle(fontSize: 9),
                            ),
                            Text('Layout tree', style: TextStyle(fontSize: 9)),
                            Text('Hit testing', style: TextStyle(fontSize: 9)),
                            Text(
                              'Creates layers',
                              style: TextStyle(fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── DATA CLASS ────────────────────────────────────────────────────────────

class _LayerType {
  final String name;
  final String api;
  final String desc;
  final IconData icon;
  final Color color;
  _LayerType(this.name, this.api, this.desc, this.icon, this.color);
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _headerChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(label, style: TextStyle(fontSize: 10, color: Colors.white)),
  );
}

Widget _hierarchyNode(String name, int indent, Color color, bool isBase) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 24.0, top: 3, bottom: 3),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isBase ? color : color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
        ),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontWeight: isBase ? FontWeight.bold : FontWeight.w500,
            fontSize: isBase ? 13 : 11,
            fontStyle: isBase ? FontStyle.italic : FontStyle.normal,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _layerTypeCard(_LayerType lt) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: lt.color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: lt.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(lt.icon, size: 18, color: lt.color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lt.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: lt.color,
                ),
              ),
              Text(
                lt.api,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Colors.grey[600],
                ),
              ),
              Text(
                lt.desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineStep(int step, String label, String detail, Color color) {
  return Row(
    children: [
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(
              detail,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _pipelineArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 11),
    child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[300]),
  );
}

Widget _codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      lines.join('\n'),
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFF80CBC4),
        height: 1.5,
      ),
    ),
  );
}

Widget _tagChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
    ),
  );
}
