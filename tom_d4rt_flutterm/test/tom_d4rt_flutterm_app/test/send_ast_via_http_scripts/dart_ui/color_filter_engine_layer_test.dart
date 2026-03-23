// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for ColorFilterEngineLayer from dart:ui
// ColorFilterEngineLayer is a retained handle to a color filter layer in the scene
// Created by SceneBuilder.pushColorFilter(), used for repainting optimization
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ColorFilterEngineLayer Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TYPE REFERENCE
  // ═══════════════════════════════════════════════════════════════════════════
  // ColorFilterEngineLayer is abstract — obtained from SceneBuilder
  // It extends EngineLayer which is also abstract

  print('ColorFilterEngineLayer type: ${ui.ColorFilterEngineLayer}');
  print('EngineLayer type: ${ui.EngineLayer}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: SceneBuilder INTEGRATION
  // ═══════════════════════════════════════════════════════════════════════════

  final builder = ui.SceneBuilder();
  print('SceneBuilder created: $builder');

  // Push a color filter layer
  final colorFilter = ui.ColorFilter.mode(Color(0xFF4CAF50), BlendMode.srcATop);
  final layer = builder.pushColorFilter(colorFilter);
  print('pushColorFilter returned: ${layer.runtimeType}');

  // Pop and build
  builder.pop();
  final scene = builder.build();
  print('Scene built: ${scene.runtimeType}');
  scene.dispose();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: RETAINED LAYER REUSE (oldLayer parameter)
  // ═══════════════════════════════════════════════════════════════════════════

  // Second build reusing retained layer
  final builder2 = ui.SceneBuilder();
  final layer2 = builder2.pushColorFilter(colorFilter, oldLayer: layer);
  print('Reused oldLayer: ${layer2.runtimeType}');
  builder2.pop();
  final scene2 = builder2.build();
  scene2.dispose();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DIFFERENT COLOR FILTERS
  // ═══════════════════════════════════════════════════════════════════════════

  final filters = <String, ui.ColorFilter>{
    'mode(green)': ui.ColorFilter.mode(Color(0xFF4CAF50), BlendMode.srcATop),
    'mode(red)': ui.ColorFilter.mode(Color(0xFFF44336), BlendMode.srcATop),
    'mode(blue)': ui.ColorFilter.mode(Color(0xFF2196F3), BlendMode.modulate),
    'srgbToLinear': ui.ColorFilter.srgbToLinearGamma(),
    'linearToSrgb': ui.ColorFilter.linearToSrgbGamma(),
  };
  for (final entry in filters.entries) {
    final b = ui.SceneBuilder();
    final l = b.pushColorFilter(entry.value);
    print('Filter ${entry.key}: layer=${l.runtimeType}');
    b.pop();
    b.build().dispose();
  }

  print('ColorFilterEngineLayer demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

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
                    colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.filter, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'ColorFilterEngineLayer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Retained color filter scene layer',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Class Hierarchy ──
              _sectionTitle('1. CLASS HIERARCHY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _hierarchyLevel(
                      0,
                      'EngineLayer',
                      'Abstract base for all retained layers',
                      Color(0xFF455A64),
                    ),
                    _hierarchyArrow(),
                    _hierarchyLevel(
                      1,
                      'ColorFilterEngineLayer',
                      'Retained handle for pushColorFilter',
                      Color(0xFF1B5E20),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F8E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'No public constructor. Obtained from SceneBuilder.pushColorFilter().',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF33691E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 2: Creation Pipeline ──
              _sectionTitle('2. CREATION PIPELINE'),
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
                      'Create ColorFilter',
                      'ColorFilter.mode(color, blendMode)',
                      Icons.color_lens,
                      Color(0xFF1565C0),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      2,
                      'Create SceneBuilder',
                      'SceneBuilder()',
                      Icons.build,
                      Color(0xFF6A1B9A),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      3,
                      'pushColorFilter',
                      'builder.pushColorFilter(filter) → layer',
                      Icons.layers,
                      Color(0xFF1B5E20),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      4,
                      'Add children & pop',
                      'Add content inside the filter layer',
                      Icons.add,
                      Color(0xFFE65100),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      5,
                      'Build scene',
                      'builder.build() → Scene',
                      Icons.check_circle,
                      Color(0xFF00695C),
                    ),
                  ],
                ),
              ),

              // ── Demo 3: Layer Reuse (oldLayer) ──
              _sectionTitle('3. RETAINED LAYER REUSE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildPhaseBox('Frame N', Color(0xFF1565C0)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.grey),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE65100)),
                          ),
                          child: Text(
                            'Save layer ref',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFE65100),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.grey),
                        SizedBox(width: 8),
                        _buildPhaseBox('Frame N+1', Color(0xFF2E7D32)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'pushColorFilter(filter, oldLayer: prevLayer)',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Reusing oldLayer enables the engine to skip rebuilding '
                            'unchanged parts of the scene tree.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 4: Color Filter Types ──
              _sectionTitle('4. COLOR FILTER TYPES'),
              ...filters.entries.map((entry) {
                return _filterRow(entry.key, _filterColor(entry.key));
              }),

              // ── Demo 5: Visual Color Filter Effect ──
              _sectionTitle('5. VISUAL FILTER EFFECTS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _filterDemo('Original', null),
                    _filterDemo('Green', Color(0xFF4CAF50)),
                    _filterDemo('Red', Color(0xFFF44336)),
                    _filterDemo('Blue', Color(0xFF2196F3)),
                  ],
                ),
              ),

              // ── Demo 6: Sibling Engine Layers ──
              _sectionTitle('6. SIBLING ENGINE LAYERS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _siblingRow(
                      'ColorFilterEngineLayer',
                      Icons.filter,
                      Color(0xFF1B5E20),
                      true,
                    ),
                    _siblingRow(
                      'OffsetEngineLayer',
                      Icons.open_with,
                      Color(0xFF1565C0),
                      false,
                    ),
                    _siblingRow(
                      'OpacityEngineLayer',
                      Icons.opacity,
                      Color(0xFF6A1B9A),
                      false,
                    ),
                    _siblingRow(
                      'TransformEngineLayer',
                      Icons.transform,
                      Color(0xFFE65100),
                      false,
                    ),
                    _siblingRow(
                      'ShaderMaskEngineLayer',
                      Icons.gradient,
                      Color(0xFF00695C),
                      false,
                    ),
                    _siblingRow(
                      'ImageFilterEngineLayer',
                      Icons.filter_hdr,
                      Color(0xFFC62828),
                      false,
                    ),
                  ],
                ),
              ),

              // ── Demo 7: Performance Benefits ──
              _sectionTitle('7. PERFORMANCE BENEFITS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _benefitRow(
                      Icons.speed,
                      'Scene tree caching',
                      'Engine reuses unchanged subtrees',
                      Color(0xFF1B5E20),
                    ),
                    Divider(height: 16),
                    _benefitRow(
                      Icons.memory,
                      'Reduced allocation',
                      'GPU resources shared across frames',
                      Color(0xFF1565C0),
                    ),
                    Divider(height: 16),
                    _benefitRow(
                      Icons.flash_on,
                      'Faster compositing',
                      'Incremental scene updates only',
                      Color(0xFFE65100),
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

Widget _hierarchyLevel(int depth, String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 24.0),
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Center(
              child: Icon(Icons.code, size: 14, color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  desc,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _hierarchyArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 36),
    child: Icon(Icons.arrow_downward, color: Colors.grey[400], size: 20),
  );
}

Widget _pipelineStep(
  int step,
  String title,
  String desc,
  IconData icon,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      Icon(icon, color: color, size: 22),
    ],
  );
}

Widget _pipelineArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 14),
    child: Icon(Icons.arrow_downward, color: Colors.grey[400], size: 18),
  );
}

Widget _buildPhaseBox(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
    ),
  );
}

Color _filterColor(String name) {
  if (name.contains('green')) return Color(0xFF4CAF50);
  if (name.contains('red')) return Color(0xFFF44336);
  if (name.contains('blue')) return Color(0xFF2196F3);
  if (name.contains('srgb')) return Color(0xFF6A1B9A);
  return Color(0xFF455A64);
}

Widget _filterRow(String name, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 12),
        Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        Spacer(),
        Text(
          '→ ColorFilterEngineLayer',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _filterDemo(String label, Color? color) {
  return Column(
    children: [
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: color != null
                ? [color, color.withValues(alpha: 0.5)]
                : [Color(0xFF2196F3), Color(0xFFF44336)],
          ),
        ),
        child: Icon(
          Icons.image,
          color: Colors.white.withValues(alpha: 0.8),
          size: 28,
        ),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _siblingRow(String name, IconData icon, Color color, bool current) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: current ? color : color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: current ? Colors.white : color, size: 16),
        ),
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(
            fontWeight: current ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
            color: current ? color : Colors.grey[700],
          ),
        ),
        if (current) ...[
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'current',
              style: TextStyle(fontSize: 10, color: color),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _benefitRow(IconData icon, String title, String desc, Color color) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}
