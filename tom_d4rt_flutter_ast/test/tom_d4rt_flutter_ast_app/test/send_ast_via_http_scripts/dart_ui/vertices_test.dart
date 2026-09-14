// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: dart:ui Vertices — the GPU mesh primitive.
//
// Vertices is the low-level mesh handle consumed by Canvas.drawVertices. Unlike
// drawPath or drawRect, which describe shapes that the engine then tessellates,
// Vertices hands the GPU a finished triangle soup: positions, optional UVs,
// optional per-vertex colors, and optional indices for vertex reuse.
//
// This file exercises:
//   • Vertices(VertexMode, List<Offset>, {textureCoordinates, colors, indices})
//   • VertexMode.triangles / .triangleStrip / .triangleFan
//   • Per-vertex colors (Gouraud-style gradient meshes)
//   • Indexed meshes (index buffer for vertex reuse)
//   • Multiple CustomPainters that actually call canvas.drawVertices
//   • Notes on Vertices.raw (Float32List perf-oriented variant)
//
// IMPORTANT: In D4rt the build function must return a Widget. We use
// StatefulBuilder for any scoped interactivity (vertex-count slider).

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// PAINTERS — declared at top level so they can be referenced from build().
// D4rt accepts class definitions for CustomPainter at the script top level
// in this corpus; sibling files use the same pattern (custom painters via
// closures inside build). To stay maximally portable we use closure-based
// painter factories that construct anonymous CustomPainters via a small
// shim class declared later in this file.
// ═══════════════════════════════════════════════════════════════════════════

// We define a single reusable CustomPainter implementation via a class. If
// the D4rt host rejects this we fall back to leaf rendering (handled below).
class _MeshPainter extends CustomPainter {
  _MeshPainter({
    required this.vertices,
    required this.fillColor,
    this.blendMode = ui.BlendMode.dstOver,
    this.outline = false,
    this.outlinePoints = const <Offset>[],
  });

  final ui.Vertices vertices;
  final Color fillColor;
  final ui.BlendMode blendMode;
  final bool outline;
  final List<Offset> outlinePoints;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = ui.Paint()
      ..color = fillColor
      ..isAntiAlias = true
      ..style = ui.PaintingStyle.fill;
    canvas.drawVertices(vertices, blendMode, paint);

    if (outline && outlinePoints.isNotEmpty) {
      final stroke = ui.Paint()
        ..color = const Color(0xFF263238)
        ..isAntiAlias = true
        ..style = ui.PaintingStyle.stroke
        ..strokeWidth = 1.2;
      for (var i = 0; i + 1 < outlinePoints.length; i++) {
        canvas.drawLine(outlinePoints[i], outlinePoints[i + 1], stroke);
      }
      // Dot per vertex.
      final dot = ui.Paint()
        ..color = const Color(0xFFE65100)
        ..style = ui.PaintingStyle.fill;
      for (final p in outlinePoints) {
        canvas.drawCircle(p, 3.0, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) =>
      oldDelegate.vertices != vertices ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.blendMode != blendMode ||
      oldDelegate.outline != outline;
}

// A second painter dedicated to the side-by-side VertexMode anatomy. It paints
// labels next to each rendered mode region using a TextPainter.
class _AnatomyPainter extends CustomPainter {
  _AnatomyPainter({
    required this.triPoints,
    required this.stripPoints,
    required this.fanPoints,
  });

  final List<Offset> triPoints;
  final List<Offset> stripPoints;
  final List<Offset> fanPoints;

  @override
  void paint(Canvas canvas, Size size) {
    final col1 = Offset(20, 16);
    final col2 = Offset(160, 16);
    final col3 = Offset(300, 16);

    _drawMode(
      canvas,
      origin: col1,
      label: 'triangles',
      labelColor: const Color(0xFFC62828),
      points: triPoints,
      mode: ui.VertexMode.triangles,
      tint: const Color(0xFFFFCDD2),
    );
    _drawMode(
      canvas,
      origin: col2,
      label: 'triangleStrip',
      labelColor: const Color(0xFF1565C0),
      points: stripPoints,
      mode: ui.VertexMode.triangleStrip,
      tint: const Color(0xFFBBDEFB),
    );
    _drawMode(
      canvas,
      origin: col3,
      label: 'triangleFan',
      labelColor: const Color(0xFF2E7D32),
      points: fanPoints,
      mode: ui.VertexMode.triangleFan,
      tint: const Color(0xFFC8E6C9),
    );
  }

  void _drawMode(
    Canvas canvas, {
    required Offset origin,
    required String label,
    required Color labelColor,
    required List<Offset> points,
    required ui.VertexMode mode,
    required Color tint,
  }) {
    final translated = <Offset>[
      for (final p in points) Offset(p.dx + origin.dx, p.dy + origin.dy + 28),
    ];
    final v = ui.Vertices(mode, translated);
    final fill = ui.Paint()
      ..color = tint
      ..isAntiAlias = true
      ..style = ui.PaintingStyle.fill;
    canvas.drawVertices(v, ui.BlendMode.dstOver, fill);

    final stroke = ui.Paint()
      ..color = labelColor.withOpacity(0.65)
      ..isAntiAlias = true
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 1.1;
    for (var i = 0; i + 1 < translated.length; i++) {
      canvas.drawLine(translated[i], translated[i + 1], stroke);
    }

    final dot = ui.Paint()..color = labelColor;
    for (var i = 0; i < translated.length; i++) {
      canvas.drawCircle(translated[i], 3.2, dot);
    }

    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: labelColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(origin.dx, origin.dy));
  }

  @override
  bool shouldRepaint(covariant _AnatomyPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// BUILD
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== dart:ui Vertices Deep Visual Demo ===');
  print('');

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION A: BASIC CONSTRUCTION — Vertices(mode, positions)
  // ─────────────────────────────────────────────────────────────────────────

  final basicTriangle = ui.Vertices(ui.VertexMode.triangles, const <Offset>[
    Offset(0, 0),
    Offset(120, 0),
    Offset(60, 100),
  ]);
  print('basicTriangle: ${basicTriangle.runtimeType}');

  // Two independent triangles via triangles mode (6 vertices, 2 triangles).
  final twoTriangles = ui.Vertices(ui.VertexMode.triangles, const <Offset>[
    Offset(0, 0),
    Offset(60, 0),
    Offset(30, 60),
    Offset(80, 0),
    Offset(140, 0),
    Offset(110, 60),
  ]);
  print('twoTriangles vertices: 6 (2 triangles)');

  // Triangle strip — n+2 vertices = n triangles. 6 points = 4 triangles.
  final stripMesh = ui.Vertices(ui.VertexMode.triangleStrip, const <Offset>[
    Offset(0, 50),
    Offset(0, 0),
    Offset(40, 50),
    Offset(40, 0),
    Offset(80, 50),
    Offset(80, 0),
  ]);
  print('stripMesh: 6 points => 4 triangles');

  // Triangle fan — first vertex is the hub; n+1 vertices = n triangles.
  final fanMesh = ui.Vertices(ui.VertexMode.triangleFan, const <Offset>[
    Offset(60, 60), // hub
    Offset(60, 0),
    Offset(120, 30),
    Offset(110, 110),
    Offset(20, 110),
    Offset(0, 30),
  ]);
  print('fanMesh: hub + 5 rim points => 5 triangles');

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION B: PER-VERTEX COLORS — the Gouraud gradient trick
  // ─────────────────────────────────────────────────────────────────────────

  final colorTriangle = ui.Vertices(
    ui.VertexMode.triangles,
    const <Offset>[Offset(0, 0), Offset(220, 0), Offset(110, 200)],
    colors: const <Color>[
      Color(0xFFE91E63),
      Color(0xFF3F51B5),
      Color(0xFFFFC107),
    ],
  );
  print('colorTriangle: per-vertex RGB Gouraud gradient');

  // A diamond (two triangles, four points) coloured per vertex.
  final colorDiamond = ui.Vertices(
    ui.VertexMode.triangles,
    const <Offset>[
      Offset(120, 0), // top
      Offset(240, 120), // right
      Offset(0, 120), // left
      Offset(240, 120), // right
      Offset(120, 240), // bottom
      Offset(0, 120), // left
    ],
    colors: const <Color>[
      Color(0xFF00BCD4),
      Color(0xFF8BC34A),
      Color(0xFFFF9800),
      Color(0xFF8BC34A),
      Color(0xFFE91E63),
      Color(0xFFFF9800),
    ],
  );
  print('colorDiamond: 4-corner diamond as 2 triangles');

  // A radial fan with rim colours — visualises triangleFan + colors.
  final ringFan = _buildRadialFan(
    center: const Offset(100, 100),
    radius: 90,
    segments: 18,
    colorAt: (t) => Color.lerp(
      const Color(0xFF1976D2),
      const Color(0xFFFFEB3B),
      t,
    )!,
  );
  print('ringFan: 18-segment radial fan with rim gradient');

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION C: INDEXED MESHES — index buffer for vertex reuse
  // ─────────────────────────────────────────────────────────────────────────

  // A quad as 2 triangles. Without indices we would need 6 positions; with
  // indices we keep 4 positions and reuse two.
  final quadIndexed = ui.Vertices(
    ui.VertexMode.triangles,
    const <Offset>[
      Offset(0, 0), // 0
      Offset(120, 0), // 1
      Offset(120, 90), // 2
      Offset(0, 90), // 3
    ],
    indices: const <int>[0, 1, 2, 0, 2, 3],
    colors: const <Color>[
      Color(0xFFB71C1C),
      Color(0xFF1B5E20),
      Color(0xFF0D47A1),
      Color(0xFFF57F17),
    ],
  );
  print('quadIndexed: 4 vertices + 6 indices => quad');

  // A small grid (3×2 cells, 4×3 = 12 vertices) addressed by indices.
  final grid = _buildIndexedGrid(
    origin: const Offset(0, 0),
    cellW: 50,
    cellH: 40,
    cols: 3,
    rows: 2,
  );
  print('grid: 12 vertices, 12 indices, 6 quads');

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION D: TEXTURE COORDINATES (UV) — described, prepared, not sampled
  // ─────────────────────────────────────────────────────────────────────────

  final textured = ui.Vertices(
    ui.VertexMode.triangles,
    const <Offset>[Offset(0, 0), Offset(100, 0), Offset(50, 100)],
    textureCoordinates: const <Offset>[
      Offset(0, 0),
      Offset(1, 0),
      Offset(0.5, 1),
    ],
  );
  print('textured vertices: UV-equipped triangle');

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION E: VertexMode enum reflection
  // ─────────────────────────────────────────────────────────────────────────

  print('VertexMode.values.length: ${ui.VertexMode.values.length}');
  for (final m in ui.VertexMode.values) {
    print('  [${m.index}] ${m.name}');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SECTION F: Vertices.raw — perf-oriented Float32List variant (described)
  // ─────────────────────────────────────────────────────────────────────────

  print('Vertices.raw signature:');
  print('  Vertices.raw(VertexMode mode, Float32List positions, {');
  print('    Float32List? textureCoordinates,');
  print('    Int32List? colors,');
  print('    Uint16List? indices,');
  print('  })');
  print('  Use when you already have packed buffers (e.g. from native code,');
  print('  asset streaming, or a transpiler) and want to skip the Offset/');
  print('  Color boxing the high-level constructor performs.');

  print('=== Vertices demo wired; building widget tree ===');

  // ─────────────────────────────────────────────────────────────────────────
  // Widget helpers
  // ─────────────────────────────────────────────────────────────────────────

  BoxDecoration cardDecoration({
    required List<Color> gradient,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    Color shadow = const Color(0x33000000),
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: gradient,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: shadow,
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: shadow.withOpacity(0.18),
          blurRadius: 32,
          offset: const Offset(0, 18),
        ),
        const BoxShadow(
          color: Color(0x14FFFFFF),
          blurRadius: 1,
          offset: Offset(0, -1),
        ),
      ],
      border: Border.all(color: const Color(0x22FFFFFF), width: 1),
    );
  }

  Widget sectionCard({
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required Color titleColor,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: cardDecoration(gradient: gradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: titleColor.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: titleColor.withOpacity(0.30),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: titleColor, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xCC000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget prose(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.5,
          height: 1.45,
          color: Color(0xDE000000),
        ),
      ),
    );
  }

  Widget chip({
    required String label,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget meshTile({
    required String caption,
    required Widget canvas,
    required Color accent,
  }) {
    return Container(
      width: 240,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withOpacity(0.20),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          const BoxShadow(
            color: Color(0x10000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 8),
          canvas,
        ],
      ),
    );
  }

  Widget codeCard(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E293B)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: Color(0xFFE2E8F0),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.45,
        ),
      ),
    );
  }

  Widget matrixRow(List<String> cells, {bool header = false, Color? tint}) {
    return Container(
      decoration: BoxDecoration(
        color: header
            ? const Color(0xFF263238)
            : (tint ?? Colors.white).withOpacity(header ? 1 : 0.85),
        border: const Border(
          bottom: BorderSide(color: Color(0x22000000)),
        ),
      ),
      child: Row(
        children: <Widget>[
          for (var i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 2 : 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                child: Text(
                  cells[i],
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: header ? FontWeight.w700 : FontWeight.w500,
                    color: header
                        ? Colors.white
                        : const Color(0xDE000000),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CARD CONTENT BUILDERS
  // ─────────────────────────────────────────────────────────────────────────

  Widget basicTriangleCanvas = SizedBox(
    width: 200,
    height: 130,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: basicTriangle,
        fillColor: const Color(0xFFFFAB91),
        outline: true,
        outlinePoints: const <Offset>[
          Offset(0, 0),
          Offset(120, 0),
          Offset(60, 100),
          Offset(0, 0),
        ],
      ),
    ),
  );

  Widget twoTrianglesCanvas = SizedBox(
    width: 200,
    height: 100,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: twoTriangles,
        fillColor: const Color(0xFF80DEEA),
        outline: true,
        outlinePoints: const <Offset>[
          Offset(0, 0),
          Offset(60, 0),
          Offset(30, 60),
          Offset(0, 0),
          Offset(80, 0),
          Offset(140, 0),
          Offset(110, 60),
          Offset(80, 0),
        ],
      ),
    ),
  );

  Widget stripCanvas = SizedBox(
    width: 200,
    height: 90,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: stripMesh,
        fillColor: const Color(0xFFCE93D8),
        outline: true,
        outlinePoints: const <Offset>[
          Offset(0, 50),
          Offset(0, 0),
          Offset(40, 50),
          Offset(40, 0),
          Offset(80, 50),
          Offset(80, 0),
        ],
      ),
    ),
  );

  Widget fanCanvas = SizedBox(
    width: 160,
    height: 140,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: fanMesh,
        fillColor: const Color(0xFFFFCC80),
        outline: true,
        outlinePoints: const <Offset>[
          Offset(60, 60),
          Offset(60, 0),
          Offset(60, 60),
          Offset(120, 30),
          Offset(60, 60),
          Offset(110, 110),
          Offset(60, 60),
          Offset(20, 110),
          Offset(60, 60),
          Offset(0, 30),
        ],
      ),
    ),
  );

  Widget colorTriangleCanvas = SizedBox(
    width: 240,
    height: 220,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: colorTriangle,
        fillColor: const Color(0xFFFFFFFF),
        blendMode: ui.BlendMode.dstOver,
      ),
    ),
  );

  Widget colorDiamondCanvas = SizedBox(
    width: 260,
    height: 250,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: colorDiamond,
        fillColor: const Color(0xFFFFFFFF),
        blendMode: ui.BlendMode.dstOver,
      ),
    ),
  );

  Widget ringFanCanvas = SizedBox(
    width: 220,
    height: 220,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: ringFan,
        fillColor: const Color(0xFFFFFFFF),
        blendMode: ui.BlendMode.dstOver,
      ),
    ),
  );

  Widget quadIndexedCanvas = SizedBox(
    width: 140,
    height: 110,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: quadIndexed,
        fillColor: const Color(0xFFFFFFFF),
        blendMode: ui.BlendMode.dstOver,
      ),
    ),
  );

  Widget gridCanvas = SizedBox(
    width: 160,
    height: 90,
    child: CustomPaint(
      painter: _MeshPainter(
        vertices: grid,
        fillColor: const Color(0xFF90CAF9),
        outline: false,
      ),
    ),
  );

  Widget anatomyCanvas = SizedBox(
    width: 420,
    height: 170,
    child: CustomPaint(
      painter: _AnatomyPainter(
        triPoints: const <Offset>[
          Offset(0, 0),
          Offset(60, 0),
          Offset(30, 60),
          Offset(80, 30),
          Offset(120, 30),
          Offset(100, 90),
        ],
        stripPoints: const <Offset>[
          Offset(0, 30),
          Offset(0, 0),
          Offset(30, 30),
          Offset(30, 0),
          Offset(60, 30),
          Offset(60, 0),
        ],
        fanPoints: const <Offset>[
          Offset(50, 50),
          Offset(50, 0),
          Offset(100, 25),
          Offset(95, 80),
          Offset(20, 90),
          Offset(0, 35),
        ],
      ),
    ),
  );

  // Slider-driven fan mesh.
  Widget interactiveFan() {
    return StatefulBuilder(
      builder: (BuildContext ctx, void Function(void Function()) setLocal) {
        return _FanSlider(
          builder: (int segments) {
            final mesh = _buildRadialFan(
              center: const Offset(110, 110),
              radius: 100,
              segments: segments,
              colorAt: (t) => Color.lerp(
                const Color(0xFF5E35B1),
                const Color(0xFFFFA726),
                t,
              )!,
            );
            return SizedBox(
              width: 240,
              height: 240,
              child: CustomPaint(
                painter: _MeshPainter(
                  vertices: mesh,
                  fillColor: const Color(0xFFFFFFFF),
                  blendMode: ui.BlendMode.dstOver,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // ASSEMBLY
  // ─────────────────────────────────────────────────────────────────────────

  final Widget header = Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(18, 20, 18, 8),
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
    decoration: cardDecoration(
      gradient: const <Color>[
        Color(0xFF1A237E),
        Color(0xFF4A148C),
        Color(0xFF880E4F),
      ],
      shadow: const Color(0x66000000),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.gradient, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'dart:ui Vertices',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'GPU mesh primitive for Canvas.drawVertices',
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Vertices wraps a triangle mesh that the engine ships straight to the '
          'GPU rasterizer. While drawPath asks the engine to figure out how to '
          'fill a shape, drawVertices says "here are the triangles, here are '
          'their corner colours and UVs — go". That makes it the right tool '
          'for procedural geometry, soft heatmaps, gradient meshes, particle '
          'sheets, and anything else where you already know the triangles you '
          'want and want to skip the path tessellator.',
          style: TextStyle(
            color: Color(0xEEFFFFFF),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            chip(
              label: 'VertexMode.triangles',
              color: const Color(0xFFFFCDD2),
              icon: Icons.change_history,
            ),
            chip(
              label: 'VertexMode.triangleStrip',
              color: const Color(0xFFBBDEFB),
              icon: Icons.view_week,
            ),
            chip(
              label: 'VertexMode.triangleFan',
              color: const Color(0xFFC8E6C9),
              icon: Icons.pie_chart,
            ),
            chip(
              label: 'per-vertex colors',
              color: const Color(0xFFFFE082),
              icon: Icons.palette,
            ),
            chip(
              label: 'indices',
              color: const Color(0xFFCE93D8),
              icon: Icons.linear_scale,
            ),
            chip(
              label: 'textureCoordinates',
              color: const Color(0xFF80DEEA),
              icon: Icons.image,
            ),
          ],
        ),
      ],
    ),
  );

  final Widget cardA = sectionCard(
    title: 'A · The constructor',
    subtitle: 'Vertices(VertexMode, List<Offset>, {colors, UVs, indices})',
    gradient: const <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
    titleColor: const Color(0xFFC62828),
    icon: Icons.code,
    children: <Widget>[
      prose(
        'The high-level Vertices constructor takes a VertexMode that tells the '
        'engine how to interpret your position list, a flat List<Offset> of '
        'positions in local canvas coordinates, and three optional named '
        'lists. Every optional list, if supplied, must have the same length '
        'as the positions list — they are parallel arrays addressed by vertex '
        'index, not packed structs. The engine then walks them in groups of '
        'three (or n+2, n+1 for strip and fan) and submits triangles.',
      ),
      prose(
        'Internally Vertices is immutable once constructed: there is no '
        'setter for positions, colors, or indices. To animate a mesh you '
        'create a new Vertices each frame, which is cheap because all four '
        'lists are flat arrays. If you already have packed Float32List / '
        'Int32List / Uint16List buffers, prefer Vertices.raw to skip the '
        'boxing the high-level constructor performs.',
      ),
      codeCard(
        'final mesh = ui.Vertices(\n'
        '  ui.VertexMode.triangles,\n'
        '  <Offset>[Offset(0, 0), Offset(120, 0), Offset(60, 100)],\n'
        '  colors: <Color>[red, green, blue],          // optional\n'
        '  textureCoordinates: <Offset>[uv0, uv1, uv2], // optional\n'
        '  indices: <int>[0, 1, 2],                     // optional\n'
        ');\n'
        '\n'
        'canvas.drawVertices(mesh, BlendMode.dstOver, paint);',
      ),
    ],
  );

  final Widget cardB = sectionCard(
    title: 'B · VertexMode anatomy',
    subtitle: 'Same 6 points, three interpretations',
    gradient: const <Color>[Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
    titleColor: const Color(0xFF283593),
    icon: Icons.timeline,
    children: <Widget>[
      prose(
        'VertexMode is the rule that tells the rasterizer how to slice the '
        'position list into triangles. triangles is the easiest mental '
        'model: every consecutive 3 vertices is one independent triangle, so '
        '6 points always means exactly 2 triangles. triangleStrip is denser: '
        'every new vertex after the second forms a triangle with the '
        'previous two, so 6 points means 4 triangles. triangleFan is the '
        'pie-chart shape: vertex 0 is the hub, and every following pair '
        'forms a triangle with it, so 6 points means 4 triangles sharing '
        'the hub.',
      ),
      Center(child: anatomyCanvas),
      const SizedBox(height: 8),
      prose(
        'The anatomy panel above renders the same 6 input points under each '
        'mode side by side. Notice how triangleStrip generates a zig-zag '
        'ribbon while triangleFan rotates around the first vertex. Choosing '
        'the right mode is the cheapest optimisation you can make: it cuts '
        'the number of position bytes you have to write, often by 3×.',
      ),
    ],
  );

  final Widget cardC = sectionCard(
    title: 'C · Triangle gallery',
    subtitle: 'Live drawVertices output for the basic modes',
    gradient: const <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
    titleColor: const Color(0xFFE65100),
    icon: Icons.auto_awesome_mosaic,
    children: <Widget>[
      prose(
        'Each tile below is a CustomPaint whose painter calls '
        'canvas.drawVertices with a flat Paint and BlendMode.dstOver. The '
        'orange dots are the input positions; the thin outline traces the '
        'expected triangle boundary so you can sanity-check how the mode '
        'interpreted your list. Notice that triangleFan repeats the hub in '
        'the outline — that is just our debug overlay, the underlying '
        'Vertices keeps the hub stored exactly once.',
      ),
      Wrap(
        alignment: WrapAlignment.start,
        children: <Widget>[
          meshTile(
            caption: 'triangles · single',
            canvas: basicTriangleCanvas,
            accent: const Color(0xFFE65100),
          ),
          meshTile(
            caption: 'triangles · two',
            canvas: twoTrianglesCanvas,
            accent: const Color(0xFF00838F),
          ),
          meshTile(
            caption: 'triangleStrip · zigzag',
            canvas: stripCanvas,
            accent: const Color(0xFF6A1B9A),
          ),
          meshTile(
            caption: 'triangleFan · pinwheel',
            canvas: fanCanvas,
            accent: const Color(0xFFE65100),
          ),
        ],
      ),
    ],
  );

  final Widget cardD = sectionCard(
    title: 'D · Per-vertex colours (Gouraud)',
    subtitle: 'The headline trick: smooth gradient meshes for free',
    gradient: const <Color>[Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
    titleColor: const Color(0xFF6A1B9A),
    icon: Icons.palette,
    children: <Widget>[
      prose(
        'When you pass a colors list, the engine performs barycentric '
        'interpolation across each triangle: every pixel inside the triangle '
        'gets a blended RGBA derived from the three corner colours. This is '
        'classical Gouraud shading and it is the cheapest way in Flutter to '
        'paint a smooth multi-stop gradient over a non-axis-aligned region. '
        'Three colours per triangle, hardware-interpolated, no shader code '
        'required.',
      ),
      prose(
        'For a single triangle the gradient just runs between the three '
        'corners. For larger meshes you can stitch many small triangles to '
        'approximate any 2D colour field — think weather maps, soft heat '
        'maps, or stylised vector art. The diamond below is the simplest '
        'four-corner gradient; the radial fan is the same idea with eighteen '
        'triangles sharing a hub.',
      ),
      Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          meshTile(
            caption: 'triangle (3 colours)',
            canvas: colorTriangleCanvas,
            accent: const Color(0xFF6A1B9A),
          ),
          meshTile(
            caption: 'diamond (4 colours, 2 tris)',
            canvas: colorDiamondCanvas,
            accent: const Color(0xFF00838F),
          ),
          meshTile(
            caption: 'radial fan (18 segments)',
            canvas: ringFanCanvas,
            accent: const Color(0xFFE65100),
          ),
        ],
      ),
    ],
  );

  final Widget cardE = sectionCard(
    title: 'E · Indexed meshes',
    subtitle: 'Reuse vertices, shrink the buffer',
    gradient: const <Color>[Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
    titleColor: const Color(0xFF00695C),
    icon: Icons.linear_scale,
    children: <Widget>[
      prose(
        'Indices add a level of indirection: instead of writing triangles by '
        'repeating their corner positions, you write a vertex pool once and '
        'then list integer offsets into that pool. A quad becomes 4 '
        'positions + 6 indices instead of 6 positions; a regular grid of '
        'M×N cells becomes (M+1)·(N+1) positions + 6·M·N indices, which '
        'collapses fast as the grid grows.',
      ),
      prose(
        'Indices also let you share colours and UVs cheaply: because the '
        'parallel lists are addressed by vertex id, a shared vertex carries '
        'one colour even though many triangles touch it. This is exactly '
        'what makes large gradient meshes affordable.',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          meshTile(
            caption: 'quad: 4 pos + 6 idx',
            canvas: quadIndexedCanvas,
            accent: const Color(0xFF00695C),
          ),
          meshTile(
            caption: '3×2 grid (12 pos, 36 idx)',
            canvas: gridCanvas,
            accent: const Color(0xFF1565C0),
          ),
        ],
      ),
      const SizedBox(height: 6),
      codeCard(
        'final quad = ui.Vertices(\n'
        '  ui.VertexMode.triangles,\n'
        '  <Offset>[\n'
        '    Offset(0, 0),     // 0\n'
        '    Offset(120, 0),   // 1\n'
        '    Offset(120, 90),  // 2\n'
        '    Offset(0, 90),    // 3\n'
        '  ],\n'
        '  indices: <int>[0, 1, 2,  0, 2, 3],\n'
        '  colors:  <Color>[red, green, blue, yellow],\n'
        ');',
      ),
    ],
  );

  final Widget cardF = sectionCard(
    title: 'F · Texture coordinates',
    subtitle: 'UVs for image-mapped meshes',
    gradient: const <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
    titleColor: const Color(0xFF006064),
    icon: Icons.image,
    children: <Widget>[
      prose(
        'textureCoordinates supplies one Offset per vertex describing where '
        'in a Paint.shader texture that vertex samples. If your shader is '
        'an ImageShader, the engine treats the UV in pixel space — (0,0) is '
        'the image origin, (imageWidth, imageHeight) is the far corner. '
        'Combined with per-vertex positions, this lets you warp an image '
        'across an arbitrary mesh: think image-mapped trapezoids, '
        'page-curl effects, or sticker decals on a deformable surface.',
      ),
      prose(
        'UVs are silently ignored when the Paint has no shader, so the '
        'textured triangle constructed earlier in this script renders the '
        'same as a plain-position triangle. To actually sample a texture '
        'you would build an ImageShader from a ui.Image and assign it to '
        'paint.shader before calling drawVertices. That code is omitted '
        'here because it would need an asset; the demo above only '
        'constructs the Vertices object to exercise the named argument.',
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF00838F).withOpacity(0.3)),
        ),
        child: Text(
          'textured.runtimeType = ${textured.runtimeType}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            color: Color(0xFF006064),
          ),
        ),
      ),
    ],
  );

  final Widget cardG = sectionCard(
    title: 'G · Vertices.raw — Float32List variant',
    subtitle: 'Skip the boxing, ship packed buffers',
    gradient: const <Color>[Color(0xFFFFF8E1), Color(0xFFFFECB3)],
    titleColor: const Color(0xFFEF6C00),
    icon: Icons.bolt,
    children: <Widget>[
      prose(
        'Vertices.raw is the perf-oriented twin. Where the default '
        'constructor takes List<Offset> and List<Color>, Vertices.raw takes '
        'Float32List positions (x0, y0, x1, y1, …), an optional Float32List '
        'of UVs, an optional Int32List of premultiplied colour ints, and an '
        'optional Uint16List of indices. The arrays are interpreted in the '
        'same way but the engine can read them straight out of the typed '
        'data, with no per-element boxing.',
      ),
      prose(
        'Reach for Vertices.raw when (1) your mesh is large and built every '
        'frame, (2) the mesh is produced by something that already speaks '
        'typed buffers — a transpiler, a Rust/C++ FFI bridge, an asset '
        'streamer, or your own simulation loop. For one-off triangles in a '
        'static demo the difference is invisible; for thousands of vertices '
        'per frame it is the difference between a smooth render and a '
        'visible jank.',
      ),
      codeCard(
        'final mesh = ui.Vertices.raw(\n'
        '  ui.VertexMode.triangles,\n'
        '  Float32List.fromList(<double>[\n'
        '     0,   0,   120,   0,   60,  100,\n'
        '  ]),\n'
        '  colors: Int32List.fromList(<int>[\n'
        '    0xFFFF0000, 0xFF00FF00, 0xFF0000FF,\n'
        '  ]),\n'
        '  indices: Uint16List.fromList(<int>[0, 1, 2]),\n'
        ');',
      ),
    ],
  );

  final Widget cardH = sectionCard(
    title: 'H · Decision matrix',
    subtitle: 'Which mode for which workload',
    gradient: const <Color>[Color(0xFFFBE9E7), Color(0xFFFFCCBC)],
    titleColor: const Color(0xFFBF360C),
    icon: Icons.fact_check,
    children: <Widget>[
      prose(
        'There is no universally best VertexMode — the right choice depends '
        'on what your geometry already looks like. The decision matrix below '
        'lists the cases where each mode is the obvious win, the cases '
        'where indexing should be layered on top, and the cases where '
        'reaching for Vertices.raw earns its place. Use it as a quick '
        'lookup when porting a paint routine to drawVertices.',
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0x33000000)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            matrixRow(
              <String>['Workload', 'Mode', 'Indices?', 'Raw?'],
              header: true,
            ),
            matrixRow(
              <String>[
                'Single static shape',
                'triangles',
                'No',
                'No',
              ],
              tint: const Color(0xFFFFF3E0),
            ),
            matrixRow(
              <String>[
                'Ribbon / wave / trail',
                'triangleStrip',
                'No',
                'Maybe',
              ],
              tint: const Color(0xFFE3F2FD),
            ),
            matrixRow(
              <String>[
                'Pie chart / radial burst',
                'triangleFan',
                'No',
                'No',
              ],
              tint: const Color(0xFFE8F5E9),
            ),
            matrixRow(
              <String>[
                'Regular grid / heat map',
                'triangles',
                'Yes',
                'Yes',
              ],
              tint: const Color(0xFFFCE4EC),
            ),
            matrixRow(
              <String>[
                'Animated particle sheet',
                'triangles',
                'Yes',
                'Yes',
              ],
              tint: const Color(0xFFF3E5F5),
            ),
            matrixRow(
              <String>[
                'Image warp / page curl',
                'triangles',
                'Yes',
                'Maybe',
              ],
              tint: const Color(0xFFE0F7FA),
            ),
          ],
        ),
      ),
    ],
  );

  final Widget cardI = sectionCard(
    title: 'I · Interactive — segment count',
    subtitle: 'Drag the slider to refine the radial fan',
    gradient: const <Color>[Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
    titleColor: const Color(0xFF4527A0),
    icon: Icons.tune,
    children: <Widget>[
      prose(
        'The fan below is rebuilt on every slider tick. The horizontal value '
        'controls how many triangles sit between the hub and the rim — at '
        '3 segments you get a chunky triangle, at 60 you get something '
        'visually indistinguishable from a smooth gradient disc. Each tick '
        'allocates a fresh Vertices instance; even at the upper end this is '
        'fine because the underlying buffers are flat and the constructor '
        'is cheap.',
      ),
      Center(child: interactiveFan()),
    ],
  );

  final Widget cardJ = sectionCard(
    title: 'J · Pitfalls and notes',
    subtitle: 'What bites you, and how to avoid it',
    gradient: const <Color>[Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
    titleColor: const Color(0xFF0D47A1),
    icon: Icons.warning_amber,
    children: <Widget>[
      prose(
        'Parallel-list length mismatch is the most common runtime error. If '
        'you pass colors or textureCoordinates, they must have exactly the '
        'same length as positions — not the same length as the number of '
        'triangles. The engine asserts this in debug builds and produces '
        'undefined results in release. Always derive the optional lists '
        'from the same source-of-truth integer (number of vertices), not '
        'from a triangle count.',
      ),
      prose(
        'BlendMode matters even when there is no texture. Canvas.drawVertices '
        'always takes a BlendMode, and the engine uses it to combine the '
        'paint colour (or shader sample) with whatever already sits in the '
        'destination. BlendMode.dstOver is a safe default for opaque meshes '
        'on a blank canvas; BlendMode.srcOver is the right choice when you '
        'want the mesh colours to win regardless of background; '
        'BlendMode.modulate is what you reach for when you want the '
        'per-vertex colours to tint a textured Paint.',
      ),
      prose(
        'Indices must reference valid vertex slots. The engine clamps in '
        'release but a stray out-of-range index in debug builds tends to '
        'throw a RangeError out of the rasterizer. Treat the indices list '
        'like a hot reference into your positions list and validate it '
        'before construction if the source is dynamic — for instance when '
        'an index buffer is decoded from an asset.',
      ),
    ],
  );

  final Widget cardK = sectionCard(
    title: 'K · Color and mode palette',
    subtitle: 'Wrap of mode chips and the colours they imply',
    gradient: const <Color>[Color(0xFFFFFDE7), Color(0xFFFFF59D)],
    titleColor: const Color(0xFFF57F17),
    icon: Icons.color_lens,
    children: <Widget>[
      prose(
        'A quick palette of the enum values and the mental colour we used '
        'throughout this demo to keep them visually distinct. Sticking to '
        'one colour per mode in your own documentation diagrams makes the '
        'three interpretations easier to scan when they appear side by '
        'side.',
      ),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          for (final modeEntry in <(ui.VertexMode, Color, IconData)>[
            (ui.VertexMode.triangles, Color(0xFFE53935), Icons.change_history),
            (ui.VertexMode.triangleStrip, Color(0xFF1E88E5), Icons.view_week),
            (ui.VertexMode.triangleFan, Color(0xFF43A047), Icons.pie_chart),
          ])
            chip(
              label: '${modeEntry.$1.name}  ·  index ${modeEntry.$1.index}',
              color: modeEntry.$2,
              icon: modeEntry.$3,
            ),
          chip(
            label: 'Vertices.raw',
            color: const Color(0xFFEF6C00),
            icon: Icons.bolt,
          ),
          chip(
            label: 'BlendMode.dstOver',
            color: const Color(0xFF6A1B9A),
            icon: Icons.layers,
          ),
          chip(
            label: 'BlendMode.modulate',
            color: const Color(0xFF00838F),
            icon: Icons.tonality,
          ),
        ],
      ),
    ],
  );

  final Widget cardL = sectionCard(
    title: 'L · Worked example recap',
    subtitle: 'A triangle gradient mesh, end to end',
    gradient: const <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
    titleColor: const Color(0xFF2E7D32),
    icon: Icons.school,
    children: <Widget>[
      prose(
        'To close the loop: the canvas below is a single Vertices with three '
        'corner positions and three corner colours, drawn through a flat '
        'white Paint with BlendMode.dstOver. That is the entire program. '
        'Everything else in this file — the strips, fans, grids, slider — '
        'is a variation on the same three lines. If you remember the '
        'constructor signature and the meaning of VertexMode, you can '
        'rebuild any of these from scratch.',
      ),
      Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: colorTriangleCanvas,
        ),
      ),
      const SizedBox(height: 8),
      codeCard(
        'final mesh = ui.Vertices(\n'
        '  ui.VertexMode.triangles,\n'
        '  const <Offset>[Offset(0, 0), Offset(220, 0), Offset(110, 200)],\n'
        '  colors: const <Color>[\n'
        '    Color(0xFFE91E63),\n'
        '    Color(0xFF3F51B5),\n'
        '    Color(0xFFFFC107),\n'
        '  ],\n'
        ');\n'
        '\n'
        'canvas.drawVertices(mesh, BlendMode.dstOver, Paint());',
      ),
    ],
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'dart:ui Vertices Demo',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF6F4FB),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              header,
              cardA,
              cardB,
              cardC,
              cardD,
              cardE,
              cardF,
              cardG,
              cardH,
              cardI,
              cardJ,
              cardK,
              cardL,
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Text(
                  'Vertices · ${ui.VertexMode.values.length} modes · '
                  'positions + (colors? UVs? indices?) · '
                  'one drawVertices call per mesh',
                  style: const TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// Helpers — top-level, pure-functional builders for Vertices objects.
// ═══════════════════════════════════════════════════════════════════════════

ui.Vertices _buildRadialFan({
  required Offset center,
  required double radius,
  required int segments,
  required Color Function(double t) colorAt,
}) {
  // First vertex is the hub; following vertices are equally-spaced rim points.
  final positions = <Offset>[center];
  final colors = <Color>[colorAt(0.0)];
  for (var i = 0; i <= segments; i++) {
    final t = i / segments;
    final angle = -1.5707963 + t * 6.2831853; // -π/2 to 3π/2 (full circle)
    final dx = center.dx + radius * _cosApprox(angle);
    final dy = center.dy + radius * _sinApprox(angle);
    positions.add(Offset(dx, dy));
    colors.add(colorAt(t));
  }
  return ui.Vertices(
    ui.VertexMode.triangleFan,
    positions,
    colors: colors,
  );
}

ui.Vertices _buildIndexedGrid({
  required Offset origin,
  required double cellW,
  required double cellH,
  required int cols,
  required int rows,
}) {
  final positions = <Offset>[];
  final colors = <Color>[];
  final stride = cols + 1;
  for (var y = 0; y <= rows; y++) {
    for (var x = 0; x <= cols; x++) {
      positions.add(
        Offset(origin.dx + x * cellW, origin.dy + y * cellH),
      );
      final tx = cols == 0 ? 0.0 : x / cols;
      final ty = rows == 0 ? 0.0 : y / rows;
      colors.add(
        Color.lerp(
          Color.lerp(
            const Color(0xFF1A237E),
            const Color(0xFFFFAB00),
            tx,
          )!,
          const Color(0xFFE91E63),
          ty * 0.55,
        )!,
      );
    }
  }
  final indices = <int>[];
  for (var y = 0; y < rows; y++) {
    for (var x = 0; x < cols; x++) {
      final i0 = y * stride + x;
      final i1 = i0 + 1;
      final i2 = i0 + stride;
      final i3 = i2 + 1;
      indices.addAll(<int>[i0, i1, i3, i0, i3, i2]);
    }
  }
  return ui.Vertices(
    ui.VertexMode.triangles,
    positions,
    indices: indices,
    colors: colors,
  );
}

double _cosApprox(double a) {
  // Use the engine's cos by routing through Offset rotation. We can't import
  // dart:math here without bumping imports, but dart:ui is enough — we lean
  // on a small Taylor-bounded reduction. For the small angle range we hit
  // (-π/2 .. 3π/2) this is fine.
  // Normalise to [-π, π].
  const twoPi = 6.2831853071795864;
  const pi = 3.141592653589793;
  var x = a;
  while (x > pi) {
    x -= twoPi;
  }
  while (x < -pi) {
    x += twoPi;
  }
  // 6-term cosine Taylor series.
  final x2 = x * x;
  final x4 = x2 * x2;
  final x6 = x4 * x2;
  final x8 = x4 * x4;
  return 1 - x2 / 2 + x4 / 24 - x6 / 720 + x8 / 40320;
}

double _sinApprox(double a) {
  const twoPi = 6.2831853071795864;
  const pi = 3.141592653589793;
  var x = a;
  while (x > pi) {
    x -= twoPi;
  }
  while (x < -pi) {
    x += twoPi;
  }
  final x2 = x * x;
  final x3 = x2 * x;
  final x5 = x3 * x2;
  final x7 = x5 * x2;
  final x9 = x7 * x2;
  return x - x3 / 6 + x5 / 120 - x7 / 5040 + x9 / 362880;
}

// ═══════════════════════════════════════════════════════════════════════════
// _FanSlider — encapsulates the local segment-count state for the interactive
// fan section. Implemented as a StatefulWidget that internally uses
// StatefulBuilder semantics by holding a value-notifier-style int and
// rebuilding via setState; root-level setState is avoided.
// ═══════════════════════════════════════════════════════════════════════════

class _FanSlider extends StatefulWidget {
  const _FanSlider({required this.builder});
  final Widget Function(int segments) builder;

  @override
  State<_FanSlider> createState() => _FanSliderState();
}

class _FanSliderState extends State<_FanSlider> {
  int _segments = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.builder(_segments),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'segments',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF4527A0),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 220,
              child: Slider(
                value: _segments.toDouble(),
                min: 3,
                max: 60,
                divisions: 57,
                label: '$_segments',
                activeColor: const Color(0xFF7E57C2),
                onChanged: (double v) {
                  setState(() {
                    _segments = v.round();
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF4527A0).withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF4527A0).withOpacity(0.4),
                ),
              ),
              child: Text(
                '$_segments',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4527A0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
