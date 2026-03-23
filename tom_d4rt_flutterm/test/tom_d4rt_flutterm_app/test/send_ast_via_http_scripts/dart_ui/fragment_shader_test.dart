// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for FragmentShader from dart:ui
// FragmentShader is an executable instance created from FragmentProgram
// It holds uniform values and can be assigned to Paint.shader
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FragmentShader Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ABOUT FRAGMENT SHADER
  // ═══════════════════════════════════════════════════════════════════════════

  // FragmentShader extends Shader, so it can be used with Paint.shader
  print('FragmentShader extends Shader');
  print('Created via program.fragmentShader()');
  print('Holds uniform values for GPU execution');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: SETTING UNIFORMS
  // ═══════════════════════════════════════════════════════════════════════════

  print('setFloat(index, value):');
  print('  index 0: first float uniform');
  print('  vec2 uses indices 0,1');
  print('  vec3 uses indices 0,1,2');
  print('  vec4 uses indices 0,1,2,3');
  print('  mat2 uses indices 0..3');

  print('setImageSampler(index, image):');
  print('  Binds a texture for sampling in the shader');
  print('  Separate index space from float uniforms');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMBINED WITH PAINT
  // ═══════════════════════════════════════════════════════════════════════════

  print('Usage with Paint:');
  print('  final paint = Paint()..shader = fragmentShader;');
  print('  canvas.drawRect(rect, paint);');
  print('  // GPU runs fragment shader for every pixel in rect');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DISPOSE
  // ═══════════════════════════════════════════════════════════════════════════

  print('FragmentShader.dispose() releases GPU resources');
  print('Call when shader is no longer needed');
  print('Cannot use shader after dispose');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: SHADER TYPES HIERARCHY
  // ═══════════════════════════════════════════════════════════════════════════

  print('Shader hierarchy:');
  print('  Shader (abstract)');
  print('    ├─ Gradient');
  print('    └─ FragmentShader');

  print('FragmentShader demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final uniformSlots = <_UniformSlot>[
    _UniformSlot(0, 'iTime', 'float', 'Animation time in seconds'),
    _UniformSlot(1, 'iResolution.x', 'float', 'Canvas width in pixels'),
    _UniformSlot(2, 'iResolution.y', 'float', 'Canvas height in pixels'),
    _UniformSlot(3, 'iMouse.x', 'float', 'Mouse/touch X position'),
    _UniformSlot(4, 'iMouse.y', 'float', 'Mouse/touch Y position'),
    _UniformSlot(5, 'iColor.r', 'float', 'Color red component'),
    _UniformSlot(6, 'iColor.g', 'float', 'Color green component'),
    _UniformSlot(7, 'iColor.b', 'float', 'Color blue component'),
    _UniformSlot(8, 'iColor.a', 'float', 'Color alpha component'),
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
                    colors: [Color(0xFF4A148C), Color(0xFFAB47BC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.auto_awesome_mosaic,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'FragmentShader',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Executable shader instance with uniform values for GPU rendering',
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
                        _headerChip('extends Shader'),
                        SizedBox(width: 6),
                        _headerChip('setFloat'),
                        SizedBox(width: 6),
                        _headerChip('dispose'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 1: API Methods ──
              _sectionTitle('1. API METHODS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _methodCard(
                      'setFloat(index, value)',
                      'Sets a float uniform',
                      'void',
                      Color(0xFF4A148C),
                    ),
                    _methodCard(
                      'setImageSampler(index, image)',
                      'Binds a texture sampler',
                      'void',
                      Color(0xFF1565C0),
                    ),
                    _methodCard(
                      'dispose()',
                      'Releases GPU resources',
                      'void',
                      Color(0xFFC62828),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Inherited from Shader: can be assigned to Paint.shader for drawing operations.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Uniform Slots ──
              _sectionTitle('2. UNIFORM SLOT MAPPING'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    ...uniformSlots.map((s) => _uniformSlotRow(s)),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EAF6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Slots are indexed by GLSL declaration order. '
                        'vec2 = 2 floats, vec3 = 3 floats, vec4 = 4 floats, mat2 = 4 floats.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 3: Usage Pattern ──
              _sectionTitle('3. USAGE PATTERN'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _stepRow(
                      1,
                      'Load program',
                      'final prog = await FragmentProgram.fromAsset(key)',
                      Color(0xFF4A148C),
                    ),
                    _stepArrow(),
                    _stepRow(
                      2,
                      'Create shader',
                      'final shader = prog.fragmentShader()',
                      Color(0xFF1565C0),
                    ),
                    _stepArrow(),
                    _stepRow(
                      3,
                      'Set uniforms',
                      'shader.setFloat(0, time); shader.setFloat(1, w)',
                      Color(0xFF2E7D32),
                    ),
                    _stepArrow(),
                    _stepRow(
                      4,
                      'Assign to paint',
                      'final paint = Paint()..shader = shader',
                      Color(0xFFE65100),
                    ),
                    _stepArrow(),
                    _stepRow(
                      5,
                      'Draw on canvas',
                      'canvas.drawRect(rect, paint)',
                      Color(0xFFC62828),
                    ),
                    _stepArrow(),
                    _stepRow(
                      6,
                      'Dispose',
                      'shader.dispose() // when no longer needed',
                      Color(0xFF455A64),
                    ),
                  ],
                ),
              ),

              // ── Section 4: Shader Class Hierarchy ──
              _sectionTitle('4. SHADER CLASS HIERARCHY'),
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
                      'Shader (abstract)',
                      0,
                      Color(0xFF455A64),
                      true,
                    ),
                    _hierarchyNode('Gradient', 1, Color(0xFF2E7D32), false),
                    _hierarchyNode(
                      '→ linear / radial / sweep',
                      2,
                      Color(0xFF66BB6A),
                      false,
                    ),
                    _hierarchyNode(
                      'FragmentShader',
                      1,
                      Color(0xFF4A148C),
                      false,
                    ),
                    _hierarchyNode(
                      '→ from FragmentProgram',
                      2,
                      Color(0xFFAB47BC),
                      false,
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Both Gradient and FragmentShader extend Shader, meaning '
                        'either can be assigned to Paint.shader. Gradient is built-in, '
                        'FragmentShader requires custom GLSL.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Memory Model ──
              _sectionTitle('5. MEMORY & LIFECYCLE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _lifecycleRow(
                      'Create',
                      'program.fragmentShader()',
                      'Allocates GPU uniform buffer',
                      Icons.add_circle,
                      Color(0xFF2E7D32),
                    ),
                    _lifecycleRow(
                      'Configure',
                      'shader.setFloat / setImageSampler',
                      'Writes to uniform buffer',
                      Icons.settings,
                      Color(0xFF1565C0),
                    ),
                    _lifecycleRow(
                      'Use',
                      'paint.shader = shader; canvas.draw*',
                      'GPU reads uniforms during draw',
                      Icons.brush,
                      Color(0xFFE65100),
                    ),
                    _lifecycleRow(
                      'Dispose',
                      'shader.dispose()',
                      'Frees GPU uniform buffer',
                      Icons.delete,
                      Color(0xFFC62828),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _stateChip('Active', Color(0xFF2E7D32)),
                        Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
                        _stateChip('In use', Color(0xFF1565C0)),
                        Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
                        _stateChip('Disposed', Color(0xFFC62828)),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 6: Per-Frame Update ──
              _sectionTitle('6. PER-FRAME ANIMATION PATTERN'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _codeBlock([
                  'class ShaderPainter extends CustomPainter {',
                  '  final FragmentShader shader;',
                  '  final double time;',
                  '',
                  '  ShaderPainter(this.shader, this.time);',
                  '',
                  '  @override',
                  '  void paint(Canvas canvas, Size size) {',
                  '    shader.setFloat(0, time);',
                  '    shader.setFloat(1, size.width);',
                  '    shader.setFloat(2, size.height);',
                  '',
                  '    final paint = Paint()..shader = shader;',
                  '    canvas.drawRect(',
                  '      Offset.zero & size, paint);',
                  '  }',
                  '',
                  '  @override',
                  '  bool shouldRepaint(covariant old) => true;',
                  '}',
                ]),
              ),

              // ── Section 7: GLSL Type → Float Slots ──
              _sectionTitle('7. GLSL TYPE → FLOAT SLOTS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _typeSlotRow('float', 1, Color(0xFF4A148C)),
                    _typeSlotRow('vec2', 2, Color(0xFF1565C0)),
                    _typeSlotRow('vec3', 3, Color(0xFF2E7D32)),
                    _typeSlotRow('vec4', 4, Color(0xFFE65100)),
                    _typeSlotRow('mat2', 4, Color(0xFFC62828)),
                    _typeSlotRow('mat3', 9, Color(0xFF00695C)),
                    _typeSlotRow('mat4', 16, Color(0xFF455A64)),
                    SizedBox(height: 8),
                    Text(
                      'sampler2D uses setImageSampler (separate index space)',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
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

class _UniformSlot {
  final int index;
  final String name;
  final String type;
  final String desc;
  _UniformSlot(this.index, this.name, this.type, this.desc);
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

Widget _methodCard(String sig, String desc, String returns, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sig,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '→ $returns',
            style: TextStyle(fontSize: 9, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _uniformSlotRow(_UniformSlot s) {
  final colors = [
    Color(0xFF4A148C),
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFE65100),
    Color(0xFF6A1B9A),
    Color(0xFFC62828),
    Color(0xFF00695C),
    Color(0xFF880E4F),
    Color(0xFF455A64),
  ];
  final color = colors[s.index % colors.length];
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '${s.index}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(
            s.name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(s.type, style: TextStyle(fontSize: 9, color: color)),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            s.desc,
            style: TextStyle(fontSize: 9, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _stepRow(int n, String label, String code, Color color) {
  return Row(
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$n',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
            Text(
              code,
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

Widget _stepArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 10),
    child: Icon(Icons.arrow_downward, size: 12, color: Colors.grey[300]),
  );
}

Widget _hierarchyNode(String name, int indent, Color color, bool isBase) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 20.0, top: 3, bottom: 3),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isBase ? color : color.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontWeight: isBase ? FontWeight.bold : FontWeight.w500,
            fontSize: 11,
            fontStyle: isBase ? FontStyle.italic : FontStyle.normal,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleRow(
  String phase,
  String api,
  String desc,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(
            phase,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(api, style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
              Text(
                desc,
                style: TextStyle(fontSize: 9, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _stateChip(String label, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
        color: Color(0xFFCE93D8),
        height: 1.4,
      ),
    ),
  );
}

Widget _typeSlotRow(String type, int slots, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: List.generate(
              slots.clamp(0, 16),
              (i) => Container(
                width: 14,
                height: 14,
                margin: EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    '$i',
                    style: TextStyle(
                      fontSize: 7,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          '$slots slot${slots == 1 ? '' : 's'}',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}
