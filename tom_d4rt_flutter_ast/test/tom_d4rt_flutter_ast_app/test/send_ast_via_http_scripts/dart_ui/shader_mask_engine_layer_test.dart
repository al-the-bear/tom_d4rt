// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: ShaderMaskEngineLayer (dart:ui)
//
// ShaderMaskEngineLayer is the engine-level handle returned by
// `SceneBuilder.pushShaderMask`. It represents the GPU compositing slot
// that combines a child sub-tree with a shader using a BlendMode and a
// mask rectangle. In application code we rarely touch the EngineLayer
// directly: we use the high-level `ShaderMask` widget, which wraps
// `RenderShaderMask`, which wraps `pushShaderMask`. This file demonstrates
// every Shader type that can drive that pipeline plus several BlendMode
// combinations side-by-side.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Shared data: gradient palettes, blend modes, demo content
  // ============================================================
  final List<Color> rainbow = [
    Colors.red.shade400,
    Colors.orange.shade400,
    Colors.yellow.shade400,
    Colors.green.shade400,
    Colors.blue.shade400,
    Colors.indigo.shade400,
    Colors.purple.shade400,
  ];

  final List<Color> sunset = [
    Color(0xFFFF512F),
    Color(0xFFDD2476),
    Color(0xFF7B2FF7),
    Color(0xFF2C5364),
  ];

  final List<Color> oceanic = [
    Color(0xFF0F2027),
    Color(0xFF203A43),
    Color(0xFF2C5364),
    Color(0xFF00C9FF),
  ];

  final List<Color> goldVein = [
    Color(0xFFB67B03),
    Color(0xFFFFD700),
    Color(0xFFFFF1AA),
    Color(0xFFB67B03),
  ];

  final List<Color> neon = [
    Color(0xFF12C2E9),
    Color(0xFFC471ED),
    Color(0xFFF64F59),
  ];

  // The recurring demonstration "child" of every ShaderMask. Using
  // a textured tile (white text on a colored grid) makes every
  // BlendMode visually distinguishable.
  Widget buildDemoChild({Color base = Colors.white}) {
    return Container(
      width: 140.0,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [base, base.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Text(
        'MASK ME',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 18.0,
          color: Colors.black87,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 1 — HERO HEADER
  // ============================================================
  final hero = Container(
    margin: EdgeInsets.only(bottom: 24.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF4B0082),
          Color(0xFF6A0DAD),
          Color(0xFFB565D8),
          Color(0xFFFF7AC6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF4B0082).withValues(alpha: 0.45),
          blurRadius: 32.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gradient, color: Colors.white, size: 44.0),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ShaderMaskEngineLayer',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  Text(
                    'dart:ui  •  pushShaderMask  •  ShaderMask widget',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Text(
            'The engine layer returned by SceneBuilder.pushShaderMask. It '
            'binds a ui.Shader (linear / radial / sweep / image gradient) to a '
            'rectangle and composites a child sub-tree using a BlendMode. The '
            'ShaderMask widget is the high-level API that drives this layer.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _heroChip('extends EngineLayer', Icons.layers),
            _heroChip('returned by pushShaderMask', Icons.brush),
            _heroChip('paired with sb.pop()', Icons.exit_to_app),
            _heroChip('reusable via oldLayer arg', Icons.recycling),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 — ANATOMY OF SHADER MASK COMPOSITING
  // ============================================================
  final anatomy = Container(
    margin: EdgeInsets.only(bottom: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.12),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.indigo.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of the Compositing Step',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _anatomyStage(
                index: 1,
                title: 'CHILD',
                subtitle: 'Source pixels',
                color: Colors.teal,
                icon: Icons.image_outlined,
                description:
                    'The widget sub-tree painted into the layer first. '
                    'These pixels become the destination of the BlendMode.',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
              child: Icon(Icons.east, color: Colors.indigo, size: 28.0),
            ),
            Expanded(
              child: _anatomyStage(
                index: 2,
                title: 'SHADER',
                subtitle: 'Gradient pixels',
                color: Colors.deepPurple,
                icon: Icons.gradient,
                description:
                    'A ui.Shader (linear, radial, sweep, or image gradient) '
                    'evaluated across the mask rectangle.',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
              child: Icon(Icons.east, color: Colors.indigo, size: 28.0),
            ),
            Expanded(
              child: _anatomyStage(
                index: 3,
                title: 'BLEND',
                subtitle: 'BlendMode op',
                color: Colors.orange,
                icon: Icons.merge_type,
                description:
                    'BlendMode chooses how shader pixels combine with the '
                    'previously painted child. Default is BlendMode.modulate.',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
              child: Icon(Icons.east, color: Colors.indigo, size: 28.0),
            ),
            Expanded(
              child: _anatomyStage(
                index: 4,
                title: 'OUTPUT',
                subtitle: 'Engine layer',
                color: Colors.pink,
                icon: Icons.layers,
                description:
                    'ShaderMaskEngineLayer is the GPU handle for the resulting '
                    'composited slot, which Flutter can keep across frames.',
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.25),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Text(
            'final ShaderMaskEngineLayer layer = sceneBuilder.pushShaderMask(\n'
            '    shader,                 // ui.Shader\n'
            '    maskRect,               // Rect (mask coordinate space)\n'
            '    BlendMode.modulate,     // BlendMode\n'
            '    oldLayer: previousLayer // optional layer recycling\n'
            ');\n'
            '// ... draw child subtree ...\n'
            'sceneBuilder.pop();',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyanAccent.shade100,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 — LINEAR GRADIENT SHADER ROW (multiple BlendModes)
  // ============================================================
  final linearShaderModes = <BlendMode>[
    BlendMode.modulate,
    BlendMode.srcIn,
    BlendMode.srcATop,
    BlendMode.dstOut,
    BlendMode.screen,
    BlendMode.overlay,
  ];

  final linearTiles = <Widget>[];
  for (final mode in linearShaderModes) {
    linearTiles.add(
      _shaderTile(
        modeLabel: _blendLabel(mode),
        color: Colors.deepPurple,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return ui.Gradient.linear(
              Offset(bounds.left, bounds.top),
              Offset(bounds.right, bounds.bottom),
              rainbow,
              null,
              ui.TileMode.clamp,
            );
          },
          blendMode: mode,
          child: buildDemoChild(),
        ),
      ),
    );
  }

  final linearSection = _shaderSection(
    title: 'Linear Gradient Shader',
    subtitle: 'ui.Gradient.linear(from, to, colors, [stops], [tileMode])',
    description:
        'A linear gradient evaluates colors along the line between two '
        'offsets. It is the most common shader passed to ShaderMask, '
        'typically used for fades and text-color washes.',
    accent: Colors.deepPurple,
    icon: Icons.linear_scale,
    tiles: linearTiles,
  );

  // ============================================================
  // SECTION 4 — RADIAL GRADIENT SHADER ROW (multiple BlendModes)
  // ============================================================
  final radialShaderModes = <BlendMode>[
    BlendMode.modulate,
    BlendMode.srcIn,
    BlendMode.srcOver,
    BlendMode.dstIn,
    BlendMode.colorDodge,
    BlendMode.multiply,
  ];

  final radialTiles = <Widget>[];
  for (final mode in radialShaderModes) {
    radialTiles.add(
      _shaderTile(
        modeLabel: _blendLabel(mode),
        color: Colors.teal,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return ui.Gradient.radial(
              bounds.center,
              bounds.shortestSide / 1.4,
              [Colors.white, ...sunset, Colors.black],
              null,
              ui.TileMode.clamp,
            );
          },
          blendMode: mode,
          child: buildDemoChild(),
        ),
      ),
    );
  }

  final radialSection = _shaderSection(
    title: 'Radial Gradient Shader',
    subtitle: 'ui.Gradient.radial(center, radius, colors, [stops], [tileMode])',
    description:
        'A radial gradient grows outward from a center point. With a '
        'BlendMode such as srcIn, the shader becomes the visible color of '
        'the masked region, producing spotlight-like effects.',
    accent: Colors.teal,
    icon: Icons.radio_button_checked,
    tiles: radialTiles,
  );

  // ============================================================
  // SECTION 5 — SWEEP GRADIENT SHADER ROW (multiple BlendModes)
  // ============================================================
  final sweepShaderModes = <BlendMode>[
    BlendMode.modulate,
    BlendMode.srcIn,
    BlendMode.srcATop,
    BlendMode.hardLight,
    BlendMode.softLight,
    BlendMode.difference,
  ];

  final sweepTiles = <Widget>[];
  for (final mode in sweepShaderModes) {
    sweepTiles.add(
      _shaderTile(
        modeLabel: _blendLabel(mode),
        color: Colors.amber,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return ui.Gradient.sweep(
              bounds.center,
              [...rainbow, rainbow.first],
              null,
              ui.TileMode.clamp,
              0.0,
              6.28318,
            );
          },
          blendMode: mode,
          child: buildDemoChild(),
        ),
      ),
    );
  }

  final sweepSection = _shaderSection(
    title: 'Sweep Gradient Shader',
    subtitle: 'ui.Gradient.sweep(center, colors, [stops], [tileMode], start, end)',
    description:
        'A sweep gradient rotates colors around a center point, useful '
        'for radial dials, color wheels, and rainbow ring decorations.',
    accent: Colors.amber.shade800,
    icon: Icons.refresh,
    tiles: sweepTiles,
  );

  // ============================================================
  // SECTION 6 — IMAGE-LIKE SHADER ROW (simulated via tiled gradients)
  // ============================================================
  // ui.ImageShader requires a ui.Image asset to instantiate. Inside this
  // synchronous demo we simulate the texture using a tiled gradient
  // shader (still a ui.Shader, still a valid input for ShaderMask). The
  // production form uses ui.ImageShader(image, tileX, tileY, matrix4).
  final imageShaderModes = <BlendMode>[
    BlendMode.modulate,
    BlendMode.srcIn,
    BlendMode.darken,
    BlendMode.lighten,
    BlendMode.screen,
    BlendMode.exclusion,
  ];

  final imageTiles = <Widget>[];
  for (final mode in imageShaderModes) {
    imageTiles.add(
      _shaderTile(
        modeLabel: _blendLabel(mode),
        color: Colors.brown,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            // Tiled linear gradient stands in for an ImageShader.
            return ui.Gradient.linear(
              Offset(bounds.left, bounds.top),
              Offset(bounds.left + 16.0, bounds.top + 16.0),
              [
                Colors.brown.shade900,
                goldVein[1],
                Colors.brown.shade700,
                goldVein[0],
              ],
              [0.0, 0.4, 0.6, 1.0],
              ui.TileMode.repeated,
            );
          },
          blendMode: mode,
          child: buildDemoChild(),
        ),
      ),
    );
  }

  final imageSection = _shaderSection(
    title: 'Image Shader (simulated via tiled gradient)',
    subtitle:
        'ui.ImageShader(image, TileMode.repeated, TileMode.repeated, matrix4)',
    description:
        'An ImageShader binds a ui.Image as a repeating texture. Below the '
        'tile is approximated with a tightly-spaced, repeated linear '
        'gradient — a valid ui.Shader and a stand-in that mimics the '
        'tiling behaviour without requiring an asset load.',
    accent: Colors.brown,
    icon: Icons.texture,
    tiles: imageTiles,
  );

  // ============================================================
  // SECTION 7 — BLENDMODE SHOWCASE GRID
  // ============================================================
  final blendModeShowcase = _blendModeShowcase(buildDemoChild, oceanic);

  // ============================================================
  // SECTION 8 — RECIPES
  // ============================================================
  final recipes = _recipesSection();

  // ============================================================
  // SECTION 9 — PITFALLS
  // ============================================================
  final pitfalls = _pitfallsSection();

  // ============================================================
  // SECTION 10 — PERFORMANCE NOTES
  // ============================================================
  final performance = _performanceSection();

  // ============================================================
  // SECTION 11 — QUICK REFERENCE CARD
  // ============================================================
  final quickReference = _quickReferenceSection();

  // ============================================================
  // SECTION 12 — ASCII FOOTER
  // ============================================================
  final asciiFooter = Container(
    margin: EdgeInsets.only(top: 28.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '╔══════════════════════════════════════════════════════════════════╗\n'
          '║   ShaderMaskEngineLayer  —  dart:ui  —  composited mask handle   ║\n'
          '╠══════════════════════════════════════════════════════════════════╣\n'
          '║  child  ─►  [ shader • mask rect • blend mode ]  ─►  layer       ║\n'
          '║                                                                  ║\n'
          '║  shaders: ui.Gradient.linear  /  .radial  /  .sweep              ║\n'
          '║           ui.ImageShader(image, tileX, tileY, matrix)            ║\n'
          '║                                                                  ║\n'
          '║  blend modes (most common with ShaderMask):                      ║\n'
          '║    modulate (default)  srcIn  srcATop  dstIn  dstOut             ║\n'
          '║    screen  overlay  colorDodge  hardLight  softLight             ║\n'
          '║                                                                  ║\n'
          '║  flow:  pushShaderMask(...)  →  paint child  →  pop()            ║\n'
          '║  reuse: pass oldLayer to keep GPU resources across frames        ║\n'
          '╚══════════════════════════════════════════════════════════════════╝',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.greenAccent.shade100,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'end of ShaderMaskEngineLayer demonstration',
              style: TextStyle(
                color: Colors.greenAccent.shade100,
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            anatomy,
            linearSection,
            radialSection,
            sweepSection,
            imageSection,
            blendModeShowcase,
            recipes,
            pitfalls,
            performance,
            quickReference,
            asciiFooter,
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// HELPER: hero chip
// ============================================================
Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.32),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: anatomy stage
// ============================================================
Widget _anatomyStage({
  required int index,
  required String title,
  required String subtitle,
  required Color color,
  required IconData icon,
  required String description,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$index',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(icon, color: color, size: 20.0),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: color,
            fontSize: 14.0,
            letterSpacing: 0.6,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 11.0,
            color: color.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: shader demo tile (one BlendMode preview)
// ============================================================
Widget _shaderTile({
  required String modeLabel,
  required Color color,
  required Widget child,
}) {
  return Container(
    width: 156.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            modeLabel,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        // Checkerboard background so transparency from BlendMode shows up.
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade200,
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
                Colors.grey.shade100,
              ],
              stops: [0.0, 0.5, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: child,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: shader section wrapper
// ============================================================
Widget _shaderSection({
  required String title,
  required String subtitle,
  required String description,
  required Color accent,
  required IconData icon,
  required List<Widget> tiles,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.16),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: accent, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black87,
            height: 1.45,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent.withValues(alpha: 0.05),
                accent.withValues(alpha: 0.12),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: tiles,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: BlendMode showcase
// ============================================================
Widget _blendModeShowcase(
  Widget Function({Color base}) buildDemoChild,
  List<Color> palette,
) {
  final modes = <_BlendModeSpec>[
    _BlendModeSpec(BlendMode.modulate, 'multiplies channels (default)'),
    _BlendModeSpec(BlendMode.srcIn, 'shader replaces child where opaque'),
    _BlendModeSpec(BlendMode.srcOut, 'shader where child is transparent'),
    _BlendModeSpec(BlendMode.srcATop, 'shader on top of child only'),
    _BlendModeSpec(BlendMode.dstIn, 'child kept where shader is opaque'),
    _BlendModeSpec(BlendMode.dstOut, 'child cut by shader opacity'),
    _BlendModeSpec(BlendMode.dstATop, 'child on top of shader only'),
    _BlendModeSpec(BlendMode.screen, 'inverse multiply, brightens'),
    _BlendModeSpec(BlendMode.overlay, 'screen + multiply combo'),
    _BlendModeSpec(BlendMode.darken, 'pick darker channel'),
    _BlendModeSpec(BlendMode.lighten, 'pick lighter channel'),
    _BlendModeSpec(BlendMode.colorDodge, 'brightens by shader'),
    _BlendModeSpec(BlendMode.colorBurn, 'darkens by shader'),
    _BlendModeSpec(BlendMode.hardLight, 'sharp screen/multiply'),
    _BlendModeSpec(BlendMode.softLight, 'soft screen/multiply'),
    _BlendModeSpec(BlendMode.difference, 'absolute channel diff'),
    _BlendModeSpec(BlendMode.exclusion, 'lower-contrast difference'),
    _BlendModeSpec(BlendMode.multiply, 'darken via product'),
  ];

  final tiles = <Widget>[];
  for (final spec in modes) {
    tiles.add(
      Container(
        width: 160.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              _blendLabel(spec.mode),
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 6.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: ShaderMask(
                shaderCallback: (Rect bounds) => ui.Gradient.linear(
                  Offset(bounds.left, bounds.top),
                  Offset(bounds.right, bounds.bottom),
                  palette,
                  null,
                  ui.TileMode.clamp,
                ),
                blendMode: spec.mode,
                child: buildDemoChild(),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              spec.note,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(bottom: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.12),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: Colors.cyan.shade800, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'BlendMode Showcase (oceanic palette)',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'The same child + same shader rendered with 18 BlendModes. Use '
          'this matrix to choose the right combinator for masking, '
          'tinting, or lighting work.',
          style: TextStyle(fontSize: 13.0, height: 1.4, color: Colors.black87),
        ),
        SizedBox(height: 14.0),
        Wrap(alignment: WrapAlignment.center, children: tiles),
      ],
    ),
  );
}

class _BlendModeSpec {
  const _BlendModeSpec(this.mode, this.note);
  final BlendMode mode;
  final String note;
}

// ============================================================
// HELPER: recipes section
// ============================================================
Widget _recipesSection() {
  final recipes = <_Recipe>[
    _Recipe(
      icon: Icons.fit_screen,
      title: 'Fade-out edge',
      summary:
          'Use a linear gradient from opaque to transparent with srcIn '
          'to fade the edge of any child (gallery thumbnails, headers).',
      code:
          'ShaderMask(\n'
          '  shaderCallback: (Rect bounds) =>\n'
          '    ui.Gradient.linear(\n'
          '      Offset(0, 0),\n'
          '      Offset(0, bounds.height),\n'
          '      const [Colors.white, Colors.transparent],\n'
          '    ),\n'
          '  blendMode: BlendMode.dstIn,\n'
          '  child: child,\n'
          ')',
      accent: Colors.deepPurple,
    ),
    _Recipe(
      icon: Icons.text_fields,
      title: 'Rainbow text',
      summary:
          'Wrap a Text widget in ShaderMask with srcIn so the gradient '
          'replaces the glyph fill while preserving anti-aliasing.',
      code:
          'ShaderMask(\n'
          '  shaderCallback: (b) =>\n'
          '    ui.Gradient.linear(\n'
          '      b.topLeft,\n'
          '      b.bottomRight,\n'
          '      rainbow,\n'
          '    ),\n'
          '  blendMode: BlendMode.srcIn,\n'
          '  child: const Text("HELLO"),\n'
          ')',
      accent: Colors.pink,
    ),
    _Recipe(
      icon: Icons.flash_on,
      title: 'Spotlight',
      summary:
          'A radial gradient with srcIn produces a circular spotlight '
          'effect — great for promo banners or "scanner" animations.',
      code:
          'ShaderMask(\n'
          '  shaderCallback: (b) =>\n'
          '    ui.Gradient.radial(\n'
          '      b.center,\n'
          '      b.shortestSide / 2,\n'
          '      const [Colors.white, Colors.transparent],\n'
          '    ),\n'
          '  blendMode: BlendMode.dstIn,\n'
          '  child: photo,\n'
          ')',
      accent: Colors.amber,
    ),
    _Recipe(
      icon: Icons.image,
      title: 'Tinted texture overlay',
      summary:
          'Use ui.ImageShader with BlendMode.modulate to multiply a tiled '
          'noise / pattern over a child for a textured surface.',
      code:
          'ShaderMask(\n'
          '  shaderCallback: (b) => ui.ImageShader(\n'
          '    pattern,\n'
          '    TileMode.repeated,\n'
          '    TileMode.repeated,\n'
          '    Matrix4.identity().storage,\n'
          '  ),\n'
          '  blendMode: BlendMode.modulate,\n'
          '  child: surface,\n'
          ')',
      accent: Colors.brown,
    ),
    _Recipe(
      icon: Icons.gradient,
      title: 'Conic ring',
      summary:
          'A sweep gradient + srcIn produces a colored ring around any '
          'masked region — used for progress indicators and avatar rings.',
      code:
          'ShaderMask(\n'
          '  shaderCallback: (b) =>\n'
          '    ui.Gradient.sweep(b.center, rainbow),\n'
          '  blendMode: BlendMode.srcIn,\n'
          '  child: ring,\n'
          ')',
      accent: Colors.teal,
    ),
    _Recipe(
      icon: Icons.brightness_5,
      title: 'Highlight sweep',
      summary:
          'Animate the start/end of a linear gradient over time to create '
          'a "shine" sweep across a glossy element.',
      code:
          'ShaderMask(\n'
          '  shaderCallback: (b) =>\n'
          '    ui.Gradient.linear(\n'
          '      Offset(b.left + dx, 0),\n'
          '      Offset(b.left + dx + 80, 0),\n'
          '      [c0, c1, c0],\n'
          '    ),\n'
          '  blendMode: BlendMode.screen,\n'
          '  child: surface,\n'
          ')',
      accent: Colors.orange,
    ),
  ];

  final cards = <Widget>[];
  for (final r in recipes) {
    cards.add(_recipeCard(r));
  }

  return Container(
    margin: EdgeInsets.only(bottom: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.green.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Six battle-tested patterns that turn ShaderMask + a ui.Shader '
          'into recognizable UI effects.',
          style: TextStyle(
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(alignment: WrapAlignment.start, children: cards),
      ],
    ),
  );
}

class _Recipe {
  const _Recipe({
    required this.icon,
    required this.title,
    required this.summary,
    required this.code,
    required this.accent,
  });
  final IconData icon;
  final String title;
  final String summary;
  final String code;
  final Color accent;
}

Widget _recipeCard(_Recipe r) {
  return Container(
    width: 320.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          r.accent.withValues(alpha: 0.06),
          r.accent.withValues(alpha: 0.16),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: r.accent.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: r.accent.withValues(alpha: 0.14),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(r.icon, color: r.accent, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                r.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: r.accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          r.summary,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            r.code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent.shade100,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: pitfalls section
// ============================================================
Widget _pitfallsSection() {
  final pitfalls = <_Pitfall>[
    _Pitfall(
      severity: 'gotcha',
      title: 'Default BlendMode is modulate, not srcIn',
      detail:
          'ShaderMask defaults to BlendMode.modulate. For most masking '
          'use-cases (replacing child with shader colors) you almost '
          'certainly want BlendMode.srcIn instead.',
      color: Colors.amber.shade700,
      icon: Icons.warning_amber,
    ),
    _Pitfall(
      severity: 'pitfall',
      title: 'shaderCallback bounds are the masked area, not screen',
      detail:
          'The Rect passed to shaderCallback is in the masked widget\'s '
          'local coordinate space. Building a gradient from absolute '
          'screen coordinates produces visually shifted colors.',
      color: Colors.orange.shade700,
      icon: Icons.gps_off,
    ),
    _Pitfall(
      severity: 'gotcha',
      title: 'Saves and restores a layer per frame',
      detail:
          'pushShaderMask creates an offscreen layer. Putting ShaderMask '
          'around very large or frequently-rebuilding sub-trees can be '
          'expensive — keep the masked area minimal.',
      color: Colors.red.shade700,
      icon: Icons.speed,
    ),
    _Pitfall(
      severity: 'pitfall',
      title: 'Anti-aliased edges with srcIn',
      detail:
          'srcIn keeps shader pixels weighted by the child\'s alpha. '
          'Glyph anti-aliasing therefore picks up the gradient color — '
          'usually wanted, but watch for muddied edges with sharp '
          'gradients.',
      color: Colors.deepPurple,
      icon: Icons.blur_on,
    ),
    _Pitfall(
      severity: 'gotcha',
      title: 'Nested ShaderMasks compound layers',
      detail:
          'Each ShaderMask adds another saveLayer. Nesting two or three '
          'is fine; nesting more layers per frame can cause noticeable '
          'jank on lower-end devices.',
      color: Colors.teal,
      icon: Icons.layers,
    ),
    _Pitfall(
      severity: 'pitfall',
      title: 'oldLayer reuse is owned by RenderObject',
      detail:
          'You only pass an oldLayer when calling pushShaderMask from a '
          'custom RenderObject; in widget code, ShaderMask handles layer '
          'recycling for you automatically.',
      color: Colors.indigo,
      icon: Icons.recycling,
    ),
  ];

  final cards = <Widget>[];
  for (final p in pitfalls) {
    cards.add(_pitfallCard(p));
  }

  return Container(
    margin: EdgeInsets.only(bottom: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and Gotchas',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(children: cards),
      ],
    ),
  );
}

class _Pitfall {
  const _Pitfall({
    required this.severity,
    required this.title,
    required this.detail,
    required this.color,
    required this.icon,
  });
  final String severity;
  final String title;
  final String detail;
  final Color color;
  final IconData icon;
}

Widget _pitfallCard(_Pitfall p) {
  return Container(
    width: 360.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: p.color.withValues(alpha: 0.6), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: p.color.withValues(alpha: 0.16),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: p.color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                p.severity.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(p.icon, color: p.color, size: 18.0),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          p.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
            color: p.color,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          p.detail,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: performance section
// ============================================================
Widget _performanceSection() {
  final notes = <_PerfNote>[
    _PerfNote(
      title: 'Engine layer caching',
      level: 'good',
      detail:
          'When the shader, mask rect, and BlendMode do not change between '
          'frames, the engine can reuse the existing ShaderMaskEngineLayer '
          'instead of allocating a new GPU resource. Build the shader '
          'lazily in shaderCallback to keep equality stable.',
    ),
    _PerfNote(
      title: 'saveLayer cost',
      level: 'caution',
      detail:
          'Internally, pushShaderMask issues a saveLayer with a paint that '
          'has the shader installed. saveLayer triggers an offscreen pass '
          'on the GPU and is one of the more expensive operations.',
    ),
    _PerfNote(
      title: 'Avoid full-screen masks',
      level: 'caution',
      detail:
          'A fullscreen ShaderMask forces the entire frame through an '
          'offscreen buffer. Restrict it to the smallest practical region '
          'or compose with ClipRect to limit the bounds.',
    ),
    _PerfNote(
      title: 'Animated gradients',
      level: 'caution',
      detail:
          'Animating only the gradient colors is usually fine, but '
          'recreating the shader every frame defeats engine-side caching. '
          'Prefer Matrix4 transformations on a stable shader.',
    ),
    _PerfNote(
      title: 'Use srcIn for tints',
      level: 'good',
      detail:
          'For pure tinting, BlendMode.srcIn lets the GPU short-circuit '
          'the destination color completely. It is typically faster than '
          'overlay/screen modes.',
    ),
    _PerfNote(
      title: 'Layer reuse oldLayer',
      level: 'good',
      detail:
          'Custom RenderObjects can pass an oldLayer to pushShaderMask. '
          'This recycles GPU buffers and avoids allocating a new engine '
          'layer per frame for the same masked region.',
    ),
  ];

  final cards = <Widget>[];
  for (final n in notes) {
    cards.add(_perfNoteCard(n));
  }

  return Container(
    margin: EdgeInsets.only(bottom: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.16),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.speed,
              color: Colors.blueGrey.shade800,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Performance Notes',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(children: cards),
      ],
    ),
  );
}

class _PerfNote {
  const _PerfNote({
    required this.title,
    required this.level,
    required this.detail,
  });
  final String title;
  final String level;
  final String detail;
}

Widget _perfNoteCard(_PerfNote n) {
  Color color;
  IconData icon;
  switch (n.level) {
    case 'good':
      color = Colors.green.shade700;
      icon = Icons.bolt;
      break;
    case 'caution':
      color = Colors.orange.shade700;
      icon = Icons.warning;
      break;
    default:
      color = Colors.blueGrey;
      icon = Icons.info;
  }

  return Container(
    width: 320.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.14),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                n.level.toUpperCase(),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 9.5,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          n.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
            color: color,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          n.detail,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: quick reference
// ============================================================
Widget _quickReferenceSection() {
  final rows = <List<String>>[
    ['Class', 'ShaderMaskEngineLayer'],
    ['Library', 'dart:ui'],
    ['Extends', 'EngineLayer'],
    ['Created via', 'SceneBuilder.pushShaderMask(shader, rect, blend, oldLayer)'],
    ['Closed via', 'SceneBuilder.pop()'],
    ['Widget API', 'ShaderMask(shaderCallback, blendMode, child)'],
    ['Render layer', 'RenderShaderMask'],
    ['Shaders', 'ui.Gradient.linear / radial / sweep / ui.ImageShader'],
    ['Default blend', 'BlendMode.modulate'],
    ['Common blend', 'srcIn for tint, dstIn for fade, modulate for multiply'],
    ['Reuse', 'oldLayer parameter recycles the GPU resource'],
    ['Cost', 'one saveLayer per masked region per frame'],
  ];

  final tableRows = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final isOdd = i.isOdd;
    tableRows.add(
      Container(
        decoration: BoxDecoration(
          color: isOdd ? Colors.grey.shade50 : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                rows[i][0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: Colors.indigo.shade700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                rows[i][1],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: tableRows),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: blend mode label (short, monospace-friendly)
// ============================================================
String _blendLabel(BlendMode mode) {
  return 'BlendMode.${mode.name}';
}
