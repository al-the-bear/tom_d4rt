// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for FragmentProgram from dart:ui
// FragmentProgram compiles and caches GLSL fragment shaders
// Used with FragmentShader to apply custom GPU effects
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FragmentProgram Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ABOUT FRAGMENT PROGRAM
  // ═══════════════════════════════════════════════════════════════════════════

  // FragmentProgram.fromAsset() loads a compiled shader from the app bundle
  // The shader must be pre-compiled using Flutter's shader compiler
  print('FragmentProgram.fromAsset(assetKey) → Future<FragmentProgram>');
  print('Loads compiled GLSL fragment shader from assets');
  print('Caches the compiled program for reuse');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: SHADER CREATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('Usage pattern:');
  print('  1. Compile .glsl → .spirv at build time (pubspec.yaml shaders:)');
  print(
    '  2. final program = await FragmentProgram.fromAsset("shaders/effect.frag")',
  );
  print('  3. final shader = program.fragmentShader()');
  print('  4. shader.setFloat(0, time)');
  print('  5. paint.shader = shader');
  print('  6. canvas.drawRect(rect, paint)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: UNIFORM SLOTS
  // ═══════════════════════════════════════════════════════════════════════════

  print('Uniform slots (set on FragmentShader):');
  print('  setFloat(index, value) — float uniform');
  print('  setImageSampler(index, image) — texture sampler');
  print('  Uniforms are indexed in declaration order from the GLSL source');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: GLSL REQUIREMENTS
  // ═══════════════════════════════════════════════════════════════════════════

  print('GLSL requirements:');
  print('  #version 460 core');
  print('  #include <flutter/runtime_effect.glsl>');
  print('  out vec4 fragColor;');
  print('  void main() { fragColor = ...; }');

  print('FragmentProgram demo complete');

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
                    colors: [Color(0xFF1A237E), Color(0xFF5C6BC0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.auto_awesome, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FragmentProgram',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Compiled GLSL fragment shader program for custom GPU effects',
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
                        _headerChip('GLSL'),
                        SizedBox(width: 6),
                        _headerChip('SPIR-V'),
                        SizedBox(width: 6),
                        _headerChip('GPU'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 1: API Overview ──
              _sectionTitle('1. API OVERVIEW'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _apiCard(
                      'FragmentProgram.fromAsset()',
                      'Loads compiled shader from bundle',
                      'Returns Future<FragmentProgram>',
                      Icons.download,
                      Color(0xFF1A237E),
                    ),
                    SizedBox(height: 8),
                    _apiCard(
                      'program.fragmentShader()',
                      'Creates executable shader instance',
                      'Returns FragmentShader',
                      Icons.play_arrow,
                      Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EAF6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'FragmentProgram is a compiled, cached representation. '
                        'Call fragmentShader() to get an instance you can configure with uniforms.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Build Pipeline ──
              _sectionTitle('2. SHADER BUILD PIPELINE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pipeStep(
                      1,
                      'Write GLSL',
                      'shaders/effect.frag',
                      Icons.code,
                      Color(0xFF1A237E),
                    ),
                    _arrow(),
                    _pipeStep(
                      2,
                      'Declare in pubspec',
                      'flutter: shaders: - shaders/effect.frag',
                      Icons.settings,
                      Color(0xFF558B2F),
                    ),
                    _arrow(),
                    _pipeStep(
                      3,
                      'Build compiles to SPIR-V',
                      'flutter build → .spirv bundle',
                      Icons.build,
                      Color(0xFFE65100),
                    ),
                    _arrow(),
                    _pipeStep(
                      4,
                      'Load at runtime',
                      'FragmentProgram.fromAsset("shaders/effect.frag")',
                      Icons.download,
                      Color(0xFF6A1B9A),
                    ),
                    _arrow(),
                    _pipeStep(
                      5,
                      'Create shader',
                      'program.fragmentShader()',
                      Icons.auto_awesome,
                      Color(0xFFC62828),
                    ),
                    _arrow(),
                    _pipeStep(
                      6,
                      'Set uniforms & paint',
                      'shader.setFloat(0, time); paint.shader = shader',
                      Icons.brush,
                      Color(0xFF00695C),
                    ),
                  ],
                ),
              ),

              // ── Section 3: GLSL Template ──
              _sectionTitle('3. GLSL SHADER TEMPLATE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _codeBlock([
                  '#version 460 core',
                  '',
                  '#include <flutter/runtime_effect.glsl>',
                  '',
                  '// Uniforms (indexed by declaration order)',
                  'uniform float iTime;',
                  'uniform vec2 iResolution;',
                  'uniform sampler2D iTexture;',
                  '',
                  'out vec4 fragColor;',
                  '',
                  'void main() {',
                  '  vec2 uv = FlutterFragCoord().xy / iResolution;',
                  '  vec3 col = texture(iTexture, uv).rgb;',
                  '  col *= 0.5 + 0.5 * sin(iTime);',
                  '  fragColor = vec4(col, 1.0);',
                  '}',
                ]),
              ),

              // ── Section 4: Uniform Slots ──
              _sectionTitle('4. UNIFORM SLOT MAPPING'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _uniformRow(
                      0,
                      'iTime',
                      'float',
                      'setFloat(0, time)',
                      Color(0xFF1A237E),
                    ),
                    _uniformRow(
                      1,
                      'iResolution.x',
                      'float',
                      'setFloat(1, width)',
                      Color(0xFF2E7D32),
                    ),
                    _uniformRow(
                      2,
                      'iResolution.y',
                      'float',
                      'setFloat(2, height)',
                      Color(0xFF2E7D32),
                    ),
                    _uniformRow(
                      3,
                      'iTexture',
                      'sampler',
                      'setImageSampler(0, img)',
                      Color(0xFFE65100),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'vec2 occupies 2 float slots. vec3 occupies 3. vec4 occupies 4. '
                        'Samplers use separate indexing via setImageSampler.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Common Shader Effects ──
              _sectionTitle('5. COMMON SHADER EFFECTS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _effectCard(
                      'Color Animation',
                      'Animate colors over time with sin(iTime)',
                      Icons.palette,
                      Color(0xFF1A237E),
                    ),
                    _effectCard(
                      'Gradient Distortion',
                      'Warp UV coordinates with math functions',
                      Icons.waves,
                      Color(0xFF2E7D32),
                    ),
                    _effectCard(
                      'Blur / Glow',
                      'Sample neighboring pixels and average',
                      Icons.blur_on,
                      Color(0xFF6A1B9A),
                    ),
                    _effectCard(
                      'Water Ripple',
                      'Polar coordinate UV distortion',
                      Icons.water,
                      Color(0xFF006064),
                    ),
                    _effectCard(
                      'Vignette',
                      'Darken edges based on distance from center',
                      Icons.vignette,
                      Color(0xFFBF360C),
                    ),
                    _effectCard(
                      'Chromatic Aberration',
                      'Offset RGB channels independently',
                      Icons.lens,
                      Color(0xFFC62828),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Relationship Diagram ──
              _sectionTitle('6. CLASS RELATIONSHIPS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _relBox(
                      'FragmentProgram',
                      'Compiled shader (cached)',
                      Color(0xFF1A237E),
                    ),
                    _relArrow('.fragmentShader()'),
                    _relBox(
                      'FragmentShader',
                      'Configured instance',
                      Color(0xFF2E7D32),
                    ),
                    _relArrow('paint.shader ='),
                    _relBox(
                      'Paint',
                      'Drawing configuration',
                      Color(0xFFE65100),
                    ),
                    _relArrow('canvas.drawRect(rect, paint)'),
                    _relBox('Canvas', 'Rendering surface', Color(0xFF6A1B9A)),
                  ],
                ),
              ),

              // ── Section 7: Caching Note ──
              _sectionTitle('7. CACHING & PERFORMANCE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _perfTip(
                      Icons.cached,
                      'FragmentProgram is automatically cached',
                      'Same asset key returns same compiled program',
                      Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 8),
                    _perfTip(
                      Icons.memory,
                      'Create FragmentShader per-frame',
                      'Shader instances are lightweight',
                      Color(0xFF1A237E),
                    ),
                    SizedBox(height: 8),
                    _perfTip(
                      Icons.speed,
                      'GPU-native execution',
                      'Runs on GPU hardware, massively parallel',
                      Color(0xFFE65100),
                    ),
                    SizedBox(height: 8),
                    _perfTip(
                      Icons.warning,
                      'Complex shaders impact performance',
                      'Profile on target devices',
                      Color(0xFFC62828),
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

Widget _headerChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _apiCard(
  String api,
  String desc,
  String returns,
  IconData icon,
  Color color,
) {
  return Row(
    children: [
      Icon(icon, size: 20, color: color),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              api,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
            Text(desc, style: TextStyle(fontSize: 10)),
            Text(
              returns,
              style: TextStyle(fontSize: 9, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _pipeStep(int n, String label, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$n',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
      SizedBox(width: 8),
      Icon(icon, size: 16, color: color),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 9,
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

Widget _arrow() {
  return Padding(
    padding: EdgeInsets.only(left: 11),
    child: Icon(Icons.arrow_downward, size: 12, color: Colors.grey[300]),
  );
}

Widget _codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF1A237E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      lines.join('\n'),
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFF90CAF9),
        height: 1.4,
      ),
    ),
  );
}

Widget _uniformRow(int idx, String name, String type, String api, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '$idx',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(type, style: TextStyle(fontSize: 9, color: color)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            api,
            style: TextStyle(
              fontSize: 9,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _effectCard(String name, String desc, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _relBox(String name, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: color,
            ),
          ),
        ),
        Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    ),
  );
}

Widget _relArrow(String label) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 16),
        Icon(Icons.arrow_downward, size: 12, color: Colors.grey[400]),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontFamily: 'monospace',
            color: Colors.grey[500],
          ),
        ),
      ],
    ),
  );
}

Widget _perfTip(IconData icon, String title, String desc, Color color) {
  return Row(
    children: [
      Icon(icon, size: 18, color: color),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
            Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}
