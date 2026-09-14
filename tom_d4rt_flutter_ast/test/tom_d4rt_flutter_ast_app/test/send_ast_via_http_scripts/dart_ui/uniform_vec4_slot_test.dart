// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: UniformVec4Slot (dart:ui fragment shader uniform slot).
// Conceptual exploration of vec4 uniforms in Flutter fragment programs.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette: deep ocean / phosphor mix. Distinct from siblings.
// ---------------------------------------------------------------------------
const Color kBg = Color(0xFF071A26);
const Color kSurface = Color(0xFF0F2A3D);
const Color kSurfaceAlt = Color(0xFF143752);
const Color kInk = Color(0xFFE6F4FB);
const Color kInkDim = Color(0xFF8FB4C8);
const Color kAccentX = Color(0xFFF26B6B); // r / x — coral
const Color kAccentY = Color(0xFF6BD18A); // g / y — mint
const Color kAccentZ = Color(0xFF6BA8F2); // b / z — sky
const Color kAccentW = Color(0xFFE0C46B); // a / w — amber
const Color kPhosphor = Color(0xFF7BFFC1);

// ---------------------------------------------------------------------------
// Holder for a labelled vec4 sample.
// ---------------------------------------------------------------------------
class _Vec4Sample {
  const _Vec4Sample(this.label, this.x, this.y, this.z, this.w, this.note);
  final String label;
  final double x;
  final double y;
  final double z;
  final double w;
  final String note;

  String get formatted =>
      'vec4(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}, '
      '${z.toStringAsFixed(2)}, ${w.toStringAsFixed(2)})';

  Color get asColor => Color.fromRGBO(
        (x * 255).clamp(0, 255).round(),
        (y * 255).clamp(0, 255).round(),
        (z * 255).clamp(0, 255).round(),
        w.clamp(0.0, 1.0),
      );
}

class _SlotKind {
  const _SlotKind(this.name, this.glsl, this.floats, this.bytes, this.use);
  final String name;
  final String glsl;
  final int floats;
  final int bytes;
  final String use;
}

// ---------------------------------------------------------------------------
// Build entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('=== UniformVec4Slot visual demo ===');
  print('Type token reference: ${ui.UniformVec4Slot}');

  // Reflective probe: the slot cannot normally be instantiated by users.
  String slotProbeStatus;
  try {
    final Type t = ui.UniformVec4Slot;
    slotProbeStatus = 'type token resolved -> $t';
  } catch (e) {
    slotProbeStatus = 'type token unavailable: $e';
  }
  print('probe: $slotProbeStatus');

  // Build the canonical sample list.
  final List<_Vec4Sample> rgbaSamples = <_Vec4Sample>[
    _Vec4Sample('opaque red', 1.0, 0.0, 0.0, 1.0, 'pure RGBA red'),
    _Vec4Sample('cyan glow', 0.30, 0.95, 0.95, 1.0, 'team accent'),
    _Vec4Sample('amber 50%', 0.95, 0.65, 0.10, 0.5, 'half alpha'),
    _Vec4Sample('violet ink', 0.55, 0.25, 0.85, 1.0, 'shader tint'),
    _Vec4Sample('mint mid', 0.40, 0.85, 0.55, 0.8, 'fade tint'),
    _Vec4Sample('rose dim', 0.85, 0.45, 0.55, 0.6, 'soft mask'),
    _Vec4Sample('null vec', 0.0, 0.0, 0.0, 0.0, 'cleared slot'),
    _Vec4Sample('full white', 1.0, 1.0, 1.0, 1.0, 'identity color'),
    _Vec4Sample('grey panel', 0.45, 0.45, 0.45, 1.0, 'bg fill'),
    _Vec4Sample('navy deep', 0.05, 0.10, 0.30, 1.0, 'background'),
    _Vec4Sample('forest soft', 0.15, 0.55, 0.30, 0.9, 'organic tone'),
    _Vec4Sample('sun flare', 1.0, 0.85, 0.15, 0.95, 'bloom seed'),
    _Vec4Sample('ice cool', 0.70, 0.92, 1.0, 0.9, 'specular hint'),
    _Vec4Sample('coal hot', 0.10, 0.05, 0.05, 1.0, 'occluded zone'),
    _Vec4Sample('pearl', 0.92, 0.90, 0.85, 0.85, 'highlight'),
    _Vec4Sample('mauve', 0.55, 0.45, 0.65, 0.75, 'transition band'),
  ];

  final List<_Vec4Sample> homogeneousSamples = <_Vec4Sample>[
    _Vec4Sample('point origin', 0.0, 0.0, 0.0, 1.0, 'world space origin'),
    _Vec4Sample('point on x', 3.0, 0.0, 0.0, 1.0, '3 units along x'),
    _Vec4Sample('point on y', 0.0, 2.5, 0.0, 1.0, '2.5 units along y'),
    _Vec4Sample('point on z', 0.0, 0.0, -4.0, 1.0, 'into the screen'),
    _Vec4Sample('direction +x', 1.0, 0.0, 0.0, 0.0, 'unit vector'),
    _Vec4Sample('direction +y', 0.0, 1.0, 0.0, 0.0, 'unit vector'),
    _Vec4Sample('mixed', 0.5, 0.5, -1.0, 1.0, 'general point'),
    _Vec4Sample('scaled w', 2.0, 4.0, 6.0, 2.0, 'before perspective divide'),
  ];

  final List<_SlotKind> slotFamily = <_SlotKind>[
    _SlotKind('UniformFloatSlot', 'float', 1, 4, 'scalar (time, opacity)'),
    _SlotKind('UniformVec2Slot', 'vec2', 2, 8, 'resolution, uv center'),
    _SlotKind('UniformVec3Slot', 'vec3', 3, 12, 'rgb tint, world axis'),
    _SlotKind('UniformVec4Slot', 'vec4', 4, 16, 'rgba color, rect, quat'),
  ];

  // Diagnostics output.
  print('rgba sample count: ${rgbaSamples.length}');
  print('homogeneous sample count: ${homogeneousSamples.length}');
  print('slot family entries: ${slotFamily.length}');
  for (int i = 0; i < rgbaSamples.length; i++) {
    final _Vec4Sample s = rgbaSamples[i];
    print(' rgba[$i] ${s.label} -> ${s.formatted}');
  }

  return Scaffold(
    backgroundColor: kBg,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHero(),
            const SizedBox(height: 22),
            _buildComponentDecomposition(),
            const SizedBox(height: 22),
            _buildRgbaGrid(rgbaSamples),
            const SizedBox(height: 22),
            _buildHomogeneousPanel(homogeneousSamples),
            const SizedBox(height: 22),
            _buildFlutterUsesPanel(),
            const SizedBox(height: 22),
            _buildSlotFamilyTable(slotFamily),
            const SizedBox(height: 22),
            _buildShaderSourceCard(),
            const SizedBox(height: 22),
            _buildHypotheticalShaderOutput(),
            const SizedBox(height: 22),
            _buildVecComparisonTable(),
            const SizedBox(height: 22),
            _buildEdgeCases(),
            const SizedBox(height: 22),
            _buildSwizzlePanel(),
            const SizedBox(height: 22),
            _buildBytePackPanel(),
            const SizedBox(height: 22),
            _buildBlendModeHints(),
            const SizedBox(height: 22),
            _buildPipelineFlowPanel(),
            const SizedBox(height: 22),
            _buildQuaternionPanel(),
            const SizedBox(height: 22),
            _buildPerformanceTipsPanel(),
            const SizedBox(height: 22),
            _buildAlphaLadder(),
            const SizedBox(height: 22),
            _buildColorMatrixPanel(),
            const SizedBox(height: 22),
            _buildGlossaryPanel(),
            const SizedBox(height: 22),
            _buildFooter(slotProbeStatus),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero header.
// ---------------------------------------------------------------------------
Widget _buildHero() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0E2A40), Color(0xFF1B4663)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kPhosphor.withValues(alpha: 0.35), width: 1.2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: kPhosphor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPhosphor.withValues(alpha: 0.6)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'v4',
                style: TextStyle(
                  color: kPhosphor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'UniformVec4Slot',
                    style: TextStyle(
                      color: kInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'vec4 in fragment shaders — four floats per uniform',
                    style: TextStyle(color: kInkDim, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'A vec4 packs four 32-bit floats into one shader uniform. '
          'It is the work-horse slot for RGBA color, homogeneous coordinates, '
          'rectangle bounds, and quaternions inside Flutter fragment programs.',
          style: TextStyle(color: kInk, fontSize: 13.5, height: 1.45),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Per-component decomposition (x, y, z, w swatches).
// ---------------------------------------------------------------------------
Widget _buildComponentDecomposition() {
  final List<List<Object>> rows = <List<Object>>[
    <Object>['x', 'r', 'red',   kAccentX, 'channel 0 — first float'],
    <Object>['y', 'g', 'green', kAccentY, 'channel 1 — second float'],
    <Object>['z', 'b', 'blue',  kAccentZ, 'channel 2 — third float'],
    <Object>['w', 'a', 'alpha', kAccentW, 'channel 3 — fourth float'],
  ];
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final List<Object> r = rows[i];
    tiles.add(_componentSwatch(
      r[0] as String,
      r[1] as String,
      r[2] as String,
      r[3] as Color,
      r[4] as String,
    ));
    if (i != rows.length - 1) tiles.add(const SizedBox(height: 10));
  }
  return _section(
    title: 'Anatomy of a vec4',
    subtitle: 'Each component is a 32-bit float (IEEE 754 single).',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: tiles,
    ),
  );
}

Widget _componentSwatch(
    String comp, String alias, String role, Color color, String note) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.45)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            comp,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '.$comp',
                    style: const TextStyle(
                      color: kInk,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '/ .$alias',
                    style: TextStyle(
                      color: kInkDim,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('— $role',
                      style: const TextStyle(color: kInk, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Text(note, style: const TextStyle(color: kInkDim, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 4x4 grid of RGBA samples rendered as solid color cells.
// ---------------------------------------------------------------------------
Widget _buildRgbaGrid(List<_Vec4Sample> samples) {
  final List<Widget> rowChildren = <Widget>[];
  const int cols = 4;
  for (int r = 0; r < 4; r++) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < cols; c++) {
      final int idx = r * cols + c;
      if (idx >= samples.length) {
        cells.add(const Expanded(child: SizedBox.shrink()));
      } else {
        cells.add(Expanded(child: _rgbaCell(samples[idx])));
      }
      if (c != cols - 1) cells.add(const SizedBox(width: 8));
    }
    rowChildren.add(Row(children: cells));
    if (r != 3) rowChildren.add(const SizedBox(height: 8));
  }
  return _section(
    title: 'vec4 as RGBA color',
    subtitle:
        'Mapping (r, g, b, a) ∈ [0, 1]^4 to display colors. Alpha controls blend.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rowChildren,
    ),
  );
}

Widget _rgbaCell(_Vec4Sample s) {
  return Container(
    height: 96,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: s.asColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.black.withValues(alpha: 0.25)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          s.label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        Text(
          s.formatted,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Homogeneous coordinates explainer.
// ---------------------------------------------------------------------------
Widget _buildHomogeneousPanel(List<_Vec4Sample> samples) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    final _Vec4Sample s = samples[i];
    final bool isPoint = s.w != 0.0;
    rows.add(
      Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: kSurfaceAlt,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPoint
                ? kAccentY.withValues(alpha: 0.4)
                : kAccentZ.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: (isPoint ? kAccentY : kAccentZ).withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isPoint ? 'POINT' : 'DIR  ',
                style: TextStyle(
                  color: isPoint ? kAccentY : kAccentZ,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                s.formatted,
                style: const TextStyle(
                  color: kInk,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Text(s.note,
                style: const TextStyle(color: kInkDim, fontSize: 11)),
          ],
        ),
      ),
    );
  }
  return _section(
    title: 'vec4 as homogeneous coordinate',
    subtitle:
        'w=1 marks a point (translatable); w=0 marks a direction (immune to translation).',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

// ---------------------------------------------------------------------------
// Where vec4s show up in Flutter beyond shaders.
// ---------------------------------------------------------------------------
Widget _buildFlutterUsesPanel() {
  final List<List<String>> rows = <List<String>>[
    <String>['Color (ARGB)',
      '32-bit color packs (a, r, g, b) bytes — vec4 normalized to [0,1].'],
    <String>['Matrix4 row',
      'Each row of a 4x4 transform matrix is conceptually a vec4.'],
    <String>['Rect',
      'Left/Top/Right/Bottom rectangle data fits one vec4.'],
    <String>['Quaternion',
      'Rotation quaternions store (x, y, z, w) with w as the scalar part.'],
    <String>['Padding/Insets',
      'EdgeInsets.fromLTRB packs four scalars — same shape as vec4.'],
    <String>['Tween pair',
      'Pack a 2D from-to range into one vec4(fromX, fromY, toX, toY).'],
  ];
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    children.add(_useRow(rows[i][0], rows[i][1]));
  }
  return _section(
    title: 'Where vec4 shows up in Flutter',
    subtitle: 'Even outside shaders, four-float bundles are everywhere.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _useRow(String head, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 120,
          child: Text(
            head,
            style: const TextStyle(
              color: kPhosphor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            body,
            style: const TextStyle(color: kInk, fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Slot family table (Float / Vec2 / Vec3 / Vec4).
// ---------------------------------------------------------------------------
Widget _buildSlotFamilyTable(List<_SlotKind> family) {
  final List<Widget> rows = <Widget>[
    _slotHeader(),
    const SizedBox(height: 6),
  ];
  for (int i = 0; i < family.length; i++) {
    rows.add(_slotRow(family[i], i == family.length - 1));
  }
  return _section(
    title: 'UniformSlot family',
    subtitle: 'All four sit under the abstract Uniform*Slot hierarchy.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _slotHeader() {
  TextStyle s = const TextStyle(
    color: kInkDim,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    letterSpacing: 0.6,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Row(
      children: <Widget>[
        Expanded(flex: 4, child: Text('SLOT', style: s)),
        Expanded(flex: 2, child: Text('GLSL', style: s)),
        Expanded(flex: 2, child: Text('FLOATS', style: s)),
        Expanded(flex: 2, child: Text('BYTES', style: s)),
        Expanded(flex: 5, child: Text('TYPICAL USE', style: s)),
      ],
    ),
  );
}

Widget _slotRow(_SlotKind k, bool highlight) {
  final Color tint = highlight ? kPhosphor : kInkDim;
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: highlight ? kPhosphor.withValues(alpha: 0.08) : kSurfaceAlt,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: highlight
            ? kPhosphor.withValues(alpha: 0.55)
            : Colors.transparent,
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            k.name,
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            k.glsl,
            style: const TextStyle(
              color: kInk,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text('${k.floats}',
              style: const TextStyle(color: kInk, fontSize: 12)),
        ),
        Expanded(
          flex: 2,
          child: Text('${k.bytes}',
              style: const TextStyle(color: kInk, fontSize: 12)),
        ),
        Expanded(
          flex: 5,
          child: Text(
            k.use,
            style: const TextStyle(color: kInkDim, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Mock GLSL shader source code card.
// ---------------------------------------------------------------------------
Widget _buildShaderSourceCard() {
  const String src = '#version 460 core\n'
      '\n'
      '// Hypothetical fragment shader using a vec4 uniform.\n'
      'uniform vec2 uResolution;     // UniformVec2Slot\n'
      'uniform float uTime;          // UniformFloatSlot\n'
      'uniform vec4 uTint;           // <-- UniformVec4Slot (rgba)\n'
      'uniform vec4 uBounds;         // <-- UniformVec4Slot (LTRB)\n'
      '\n'
      'out vec4 fragColor;\n'
      '\n'
      'void main() {\n'
      '  vec2 uv = gl_FragCoord.xy / uResolution;\n'
      '  vec3 base = vec3(uv, abs(sin(uTime)));\n'
      '  // Mix the slot-supplied tint into the procedural color.\n'
      '  vec3 mixed = mix(base, uTint.rgb, uTint.a);\n'
      '  fragColor = vec4(mixed, 1.0);\n'
      '}\n';
  return _section(
    title: 'Mock fragment shader source',
    subtitle: 'Two vec4 uniforms — one tint, one bounding rect.',
    body: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF051018),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kPhosphor.withValues(alpha: 0.3)),
      ),
      child: const Text(
        src,
        style: TextStyle(
          color: kPhosphor,
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.45,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// "Visualise what a shader would emit" — drawn here using LinearGradient.
// ---------------------------------------------------------------------------
Widget _buildHypotheticalShaderOutput() {
  final List<List<Object>> bands = <List<Object>>[
    <Object>['uTint = vec4(1, 0.5, 0.2, 1)',
      const <Color>[Color(0xFFFF8030), Color(0xFFFFB57A)]],
    <Object>['uTint = vec4(0.2, 0.6, 1.0, 1)',
      const <Color>[Color(0xFF3399FF), Color(0xFF99CCFF)]],
    <Object>['uTint = vec4(0.4, 0.95, 0.55, 1)',
      const <Color>[Color(0xFF66F28C), Color(0xFFB3F8C6)]],
    <Object>['uTint = vec4(0.85, 0.25, 0.85, 1)',
      const <Color>[Color(0xFFD940D9), Color(0xFFEC8FEC)]],
  ];
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < bands.length; i++) {
    final List<Object> b = bands[i];
    children.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              b[0] as String,
              style: const TextStyle(
                color: kInkDim,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: b[1] as List<Color>),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return _section(
    title: 'Hypothetical shader output',
    subtitle:
        'These bands stand in for what the mock shader would render given each tint.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

// ---------------------------------------------------------------------------
// vec2 / vec3 / vec4 comparison.
// ---------------------------------------------------------------------------
Widget _buildVecComparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['vec2', '2 floats',
      'UV coords, screen-space pairs, viewport size'],
    <String>['vec3', '3 floats',
      'RGB color (no alpha), 3D position, surface normal'],
    <String>['vec4', '4 floats',
      'RGBA color, homogeneous point, rectangle, quaternion'],
  ];
  final List<Widget> body = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    body.add(_compareRow(rows[i][0], rows[i][1], rows[i][2]));
  }
  return _section(
    title: 'vec2 vs vec3 vs vec4',
    subtitle: 'Pick the smallest slot that fits — bandwidth matters.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: body,
    ),
  );
}

Widget _compareRow(String name, String size, String use) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Text(name,
              style: const TextStyle(
                color: kAccentX,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 13,
              )),
        ),
        SizedBox(
          width: 80,
          child: Text(size,
              style: const TextStyle(color: kInkDim, fontSize: 12)),
        ),
        Expanded(
          child: Text(use,
              style: const TextStyle(color: kInk, fontSize: 12, height: 1.35)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Edge cases.
// ---------------------------------------------------------------------------
Widget _buildEdgeCases() {
  final List<List<String>> rows = <List<String>>[
    <String>['vec4(0, 0, 0, 0)',
      'Fully transparent black; cleared color buffer.'],
    <String>['vec4(1, 1, 1, 1)',
      'Opaque white; identity tint for multiplicative blends.'],
    <String>['vec4(0, 0, 0, 1)',
      'Opaque black; common shadow color.'],
    <String>['vec4(NaN, …)',
      'Undefined behavior in most GPUs; produces black or garbage pixels.'],
    <String>['vec4(Inf, …)',
      'Saturates to max representable; alpha-blended pipelines clip to 1.'],
    <String>['vec4 outside [0,1]',
      'HDR territory — needs a high precision pipeline (vec4 16f / 32f).'],
  ];
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    children.add(_edgeCaseRow(rows[i][0], rows[i][1]));
  }
  return _section(
    title: 'Edge cases',
    subtitle: 'Special values worth knowing about.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _edgeCaseRow(String code, String note) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kAccentW.withValues(alpha: 0.3)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(code,
            style: const TextStyle(
              color: kAccentW,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 4),
        Text(note,
            style: const TextStyle(
                color: kInk, fontSize: 12, height: 1.35)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Swizzling cheat-sheet.
// ---------------------------------------------------------------------------
Widget _buildSwizzlePanel() {
  final List<List<String>> rows = <List<String>>[
    <String>['v.xy', 'vec2(v.x, v.y)'],
    <String>['v.rgb', 'vec3(v.r, v.g, v.b)'],
    <String>['v.wzyx', 'vec4 reversed'],
    <String>['v.xxxx', 'vec4 broadcasting x'],
    <String>['v.bgra', 'vec4 swap (Apple-style ordering)'],
    <String>['v.argb', 'vec4 with alpha-first ordering'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    kids.add(_swizzleRow(rows[i][0], rows[i][1]));
  }
  return _section(
    title: 'Swizzling primer',
    subtitle: 'GLSL lets you re-order or broadcast vec4 components inline.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _swizzleRow(String left, String right) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 90,
          child: Text(
            left,
            style: const TextStyle(
              color: kPhosphor,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Text('=>',
            style: TextStyle(color: kInkDim, fontSize: 11)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            right,
            style: const TextStyle(
              color: kInk,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer.
// ---------------------------------------------------------------------------
Widget _buildFooter(String probeStatus) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kInkDim.withValues(alpha: 0.25)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Notes',
          style: TextStyle(
            color: kPhosphor,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'UniformVec4Slot is internal to Flutter\'s fragment program runtime; '
          'user code cannot construct slot instances directly. They are obtained '
          'from a compiled FragmentProgram and bound by index when calling '
          'shader.setFloat (4 calls per vec4).',
          style: TextStyle(color: kInk, fontSize: 12, height: 1.45),
        ),
        const SizedBox(height: 8),
        Text(
          'probe: $probeStatus',
          style: const TextStyle(
            color: kInkDim,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Byte packing visualisation: how a vec4 lives in memory.
// ---------------------------------------------------------------------------
Widget _buildBytePackPanel() {
  // 16 bytes total — visualised as 4 groups of 4.
  final List<List<Object>> groups = <List<Object>>[
    <Object>['x / r', kAccentX, '0..3', 'float32 little-endian'],
    <Object>['y / g', kAccentY, '4..7', 'float32 little-endian'],
    <Object>['z / b', kAccentZ, '8..11', 'float32 little-endian'],
    <Object>['w / a', kAccentW, '12..15', 'float32 little-endian'],
  ];
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < groups.length; i++) {
    final List<Object> g = groups[i];
    cells.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: i == groups.length - 1 ? 0 : 6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (g[1] as Color).withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: g[1] as Color, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(g[0] as String,
                  style: TextStyle(
                    color: g[1] as Color,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  )),
              const SizedBox(height: 4),
              Text(
                'bytes ${g[2]}',
                style: const TextStyle(
                  color: kInk,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
              Text(
                g[3] as String,
                style: const TextStyle(color: kInkDim, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return _section(
    title: 'Memory layout (16 bytes)',
    subtitle:
        'GLSL std140 places a vec4 on a 16-byte boundary; struct padding follows suit.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(children: cells),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: kSurfaceAlt,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'A Float32List of length 4 maps directly to one vec4 uniform — '
            'no padding, no shuffling, contiguous.',
            style: TextStyle(color: kInk, fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// BlendMode hints: where the alpha channel of a vec4 matters.
// ---------------------------------------------------------------------------
Widget _buildBlendModeHints() {
  final List<List<String>> rows = <List<String>>[
    <String>['srcOver',
      'C_out = C_src.rgb * C_src.a + C_dst.rgb * (1 - C_src.a)'],
    <String>['multiply',
      'C_out = C_src.rgb * C_dst.rgb (alpha still drives blend weight)'],
    <String>['plus',
      'C_out = C_src.rgb + C_dst.rgb (HDR-friendly, alpha additive)'],
    <String>['screen',
      'C_out = 1 - (1 - C_src.rgb) * (1 - C_dst.rgb), alpha modulates'],
    <String>['modulate',
      'C_out = C_src.rgba * C_dst.rgba (component-wise multiply)'],
    <String>['xor',
      'Symmetric difference of source and dest masks via alpha.'],
  ];
  final List<Widget> body = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    body.add(_blendRow(rows[i][0], rows[i][1]));
  }
  return _section(
    title: 'BlendMode hints — w (alpha) at work',
    subtitle:
        'Compositors read vec4(rgba) per-pixel; alpha determines participation.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: body,
    ),
  );
}

Widget _blendRow(String name, String formula) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 90,
          child: Text(name,
              style: const TextStyle(
                color: kAccentZ,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              )),
        ),
        Expanded(
          child: Text(
            formula,
            style: const TextStyle(
              color: kInk,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Pipeline flow: from .frag file to GPU.
// ---------------------------------------------------------------------------
Widget _buildPipelineFlowPanel() {
  final List<List<String>> steps = <List<String>>[
    <String>['1', 'shader.frag',
      'Author writes GLSL with `uniform vec4 myParam;`.'],
    <String>['2', 'pubspec.yaml',
      'Register shader under `flutter: shaders:` so it ships with the app.'],
    <String>['3', 'FragmentProgram.fromAsset',
      'Compile-on-load returns a FragmentProgram instance.'],
    <String>['4', 'program.fragmentShader()',
      'Allocate a FragmentShader bound to its UniformSlots.'],
    <String>['5', 'shader.setFloat(i, v)',
      'Set each component of the vec4 in slot order — 4 calls per vec4.'],
    <String>['6', 'Paint..shader = shader',
      'Hand the configured shader to the canvas paint.'],
    <String>['7', 'canvas.drawRect(..)',
      'Engine schedules the draw; Skia/Impeller dispatches to GPU.'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < steps.length; i++) {
    kids.add(_pipelineRow(steps[i][0], steps[i][1], steps[i][2]));
  }
  return _section(
    title: 'Pipeline: .frag to GPU',
    subtitle:
        'How a vec4 uniform travels from authored source to a fragment evaluation.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _pipelineRow(String num, String head, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kPhosphor.withValues(alpha: 0.18)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kPhosphor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(num,
              style: const TextStyle(
                color: kPhosphor,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              )),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(head,
                  style: const TextStyle(
                    color: kInk,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  )),
              const SizedBox(height: 3),
              Text(desc,
                  style: const TextStyle(
                      color: kInkDim, fontSize: 11.5, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Quaternion side-bar: vec4 in rotation math.
// ---------------------------------------------------------------------------
Widget _buildQuaternionPanel() {
  final List<List<String>> rows = <List<String>>[
    <String>['identity', 'vec4(0, 0, 0, 1)',
      'No rotation — neutral element.'],
    <String>['90deg around y',
      'vec4(0, 0.7071, 0, 0.7071)', 'Quarter turn about Y axis.'],
    <String>['180deg around z', 'vec4(0, 0, 1, 0)',
      'Half turn about Z axis (w drops to 0).'],
    <String>['random tilt',
      'vec4(0.27, 0.13, 0.05, 0.95)', 'Small mixed rotation.'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    kids.add(_quatRow(rows[i][0], rows[i][1], rows[i][2]));
  }
  return _section(
    title: 'vec4 as quaternion',
    subtitle: 'Rotation quaternions: (x, y, z, w) where w is the scalar part.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _quatRow(String name, String value, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: kAccentY.withValues(alpha: 0.25)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 130,
              child: Text(name,
                  style: const TextStyle(
                    color: kAccentY,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  )),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: kInk,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(desc,
            style: const TextStyle(
                color: kInkDim, fontSize: 11.5, height: 1.4)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Performance tips.
// ---------------------------------------------------------------------------
Widget _buildPerformanceTipsPanel() {
  final List<List<String>> tips = <List<String>>[
    <String>['Pack tightly',
      'Combine related scalars into one vec4 to cut uniform-binding overhead.'],
    <String>['Avoid setFloat in hot loops',
      'Set uniforms once per frame, not per draw call.'],
    <String>['Mind alignment',
      'std140 aligns vec4 to 16 bytes; padding can surprise mixed-size structs.'],
    <String>['Prefer half precision when safe',
      'Color tints rarely need full 32-bit floats — Impeller may down-convert.'],
    <String>['Watch driver caps',
      'Max uniform vectors per shader varies; consult GL_MAX_FRAGMENT_UNIFORM_VECTORS.'],
    <String>['Cache the shader',
      'FragmentShader allocation is non-trivial; reuse instances per paint type.'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < tips.length; i++) {
    kids.add(_tipRow(tips[i][0], tips[i][1]));
  }
  return _section(
    title: 'Performance tips',
    subtitle: 'Practical guidance when wiring up vec4 uniforms.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _tipRow(String head, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: kAccentX.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 3, right: 8),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: kAccentX,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(head,
                  style: const TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  )),
              const SizedBox(height: 3),
              Text(body,
                  style: const TextStyle(
                      color: kInkDim, fontSize: 11.5, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Alpha ladder: vec4 with sweeping w channel against a checkerboard.
// ---------------------------------------------------------------------------
Widget _buildAlphaLadder() {
  final List<double> alphas = <double>[
    0.0, 0.1, 0.25, 0.4, 0.55, 0.7, 0.85, 1.0
  ];
  final List<Widget> rungs = <Widget>[];
  for (int i = 0; i < alphas.length; i++) {
    final double a = alphas[i];
    rungs.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 110,
              child: Text(
                'vec4(0.95, 0.45, 0.25, ${a.toStringAsFixed(2)})',
                style: const TextStyle(
                  color: kInk,
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: <Color>[
                      const Color(0xFFF26B40).withValues(alpha: a),
                      const Color(0xFFF7B26A).withValues(alpha: a),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return _section(
    title: 'Alpha (w) ladder',
    subtitle: 'Same RGB, increasing w — observe coverage rise from 0 to 1.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rungs,
    ),
  );
}

// ---------------------------------------------------------------------------
// Color matrix interpretation: a 4x4 matrix is four vec4 rows.
// ---------------------------------------------------------------------------
Widget _buildColorMatrixPanel() {
  final List<List<String>> rows = <List<String>>[
    <String>['row 0', 'vec4(rR, rG, rB, rA)', 'red output mix'],
    <String>['row 1', 'vec4(gR, gG, gB, gA)', 'green output mix'],
    <String>['row 2', 'vec4(bR, bG, bB, bA)', 'blue output mix'],
    <String>['row 3', 'vec4(aR, aG, aB, aA)', 'alpha output mix'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    kids.add(_matrixRow(rows[i][0], rows[i][1], rows[i][2]));
  }
  return _section(
    title: 'ColorFilter.matrix as four vec4 rows',
    subtitle:
        'A ColorFilter.matrix is a 4x5 matrix; each row corresponds to one vec4 plus offset.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _matrixRow(String name, String body, String role) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Text(name,
              style: const TextStyle(
                color: kAccentZ,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 12,
              )),
        ),
        Expanded(
          flex: 4,
          child: Text(body,
              style: const TextStyle(
                color: kInk,
                fontFamily: 'monospace',
                fontSize: 11.5,
              )),
        ),
        Expanded(
          flex: 3,
          child: Text(role,
              style: const TextStyle(color: kInkDim, fontSize: 11)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Glossary.
// ---------------------------------------------------------------------------
Widget _buildGlossaryPanel() {
  final List<List<String>> entries = <List<String>>[
    <String>['Uniform',
      'Per-draw constant available to every fragment in a shader pass.'],
    <String>['Slot',
      'Typed binding point that the engine uses to map a Dart value to a uniform.'],
    <String>['vec4',
      'GLSL/SkSL four-float vector — the type behind UniformVec4Slot.'],
    <String>['Swizzle',
      'Component re-ordering syntax (.xyzw / .rgba / .stpq).'],
    <String>['Homogeneous',
      'Coordinate system where points use w=1 and directions use w=0.'],
    <String>['std140',
      'GLSL uniform-buffer layout rule that aligns vec4 to 16 bytes.'],
    <String>['Quaternion',
      'A vec4 used to represent 3D rotations without gimbal lock.'],
    <String>['Premultiplied',
      'Color encoding where rgb is pre-scaled by alpha for cheaper blending.'],
  ];
  final List<Widget> kids = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    kids.add(_glossaryRow(entries[i][0], entries[i][1]));
  }
  return _section(
    title: 'Glossary',
    subtitle: 'Quick reference for terms used above.',
    body: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: kids,
    ),
  );
}

Widget _glossaryRow(String term, String def) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: kSurfaceAlt,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(term,
              style: const TextStyle(
                color: kPhosphor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              )),
        ),
        Expanded(
          child: Text(def,
              style: const TextStyle(
                  color: kInk, fontSize: 11.5, height: 1.4)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Generic section wrapper.
// ---------------------------------------------------------------------------
Widget _section({
  required String title,
  required String subtitle,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kInkDim.withValues(alpha: 0.18)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: kInk,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: kInkDim, fontSize: 12, height: 1.35),
        ),
        const SizedBox(height: 12),
        body,
      ],
    ),
  );
}
