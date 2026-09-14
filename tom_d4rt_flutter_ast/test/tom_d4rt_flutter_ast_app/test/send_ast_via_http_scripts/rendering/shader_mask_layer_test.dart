// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SHADER MASK LAYER — Deep Demo
// ============================================================================
//
// ShaderMaskLayer is a compositing layer that applies a shader-based mask
// to its child layers during the compositing phase of rendering.  At the
// lower rendering layer, ShaderMaskLayer sits in the layer tree alongside
// OpacityLayer, ClipPathLayer, etc.  However, most developers interact
// with it through the higher-level ShaderMask widget.
//
// How it works:
//   1. The layer takes a Shader (linear gradient, radial gradient, sweep
//      gradient, or image shader) and a BlendMode.
//   2. During compositing, the engine renders the child layers into an
//      offscreen buffer, then composites the result with the mask shader
//      using the specified blend mode.
//   3. The blend mode controls how the shader and child pixels combine:
//      - BlendMode.dstIn  — keeps child pixels only where the shader
//        is opaque (the classic "fade to transparent" effect)
//      - BlendMode.srcIn  — paints the shader colour only where the
//        child is opaque (colour tinting)
//      - BlendMode.modulate — multiplies child and shader colours
//
// This demo focuses on the ShaderMask widget (which creates a
// ShaderMaskLayer under the hood) and demonstrates various gradient
// types, blend modes, and practical visual effects.
//
// Color theme : Steel (#455A64) / Ice (#B0BEC5)
// Helper prefix: _sm
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _smSteel = Color(0xFF455A64);
const Color _smIce = Color(0xFFB0BEC5);
const Color _smDarkSteel = Color(0xFF263238);
const Color _smLightIce = Color(0xFFECEFF1);
const Color _smIvory = Color(0xFFFAFAFA);
const Color _smCharcoal = Color(0xFF212121);
const Color _smTeal = Color(0xFF00897B);
const Color _smAmber = Color(0xFFFF8F00);
const Color _smCoral = Color(0xFFE53935);
const Color _smSky = Color(0xFF1565C0);
const Color _smGold = Color(0xFFFFD600);
const Color _smPlum = Color(0xFF7B1FA2);
const Color _smEmerald = Color(0xFF2E7D32);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _smSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_smSteel, _smDarkSteel],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
            ),
          ),
      ],
    ),
  );
}

Widget _smInfoCard(String text, {Color borderColor = _smSteel}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _smIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: borderColor, width: 4)),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, color: _smCharcoal, height: 1.5),
    ),
  );
}

Widget _smCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFF80CBC4),
        height: 1.5,
      ),
    ),
  );
}

Widget _smDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 1,
    color: _smIce.withValues(alpha: 0.5),
  );
}

Widget _smBadge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

Widget _smPropertyRow(String property, String value, IconData icon,
    {Color iconColor = _smSteel}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            property,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: _smCharcoal,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _smLightIce,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: _smDarkSteel),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _smGradientSample({
  required String label,
  required Shader Function(Rect bounds) shaderCallback,
  BlendMode blendMode = BlendMode.dstIn,
  String description = '',
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _smSteel.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _smSteel)),
        ),
        // Masked content
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: SizedBox(
            height: 120,
            child: ShaderMask(
              shaderCallback: shaderCallback,
              blendMode: blendMode,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_smSky, _smTeal, _smEmerald],
                  ),
                ),
                child: Center(
                  child: Text(
                    description.isNotEmpty ? description : label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Main entry
// ============================================================================

dynamic build(BuildContext context) {
  print('--- ShaderMaskLayer Deep Demo ---');
  print('Demonstrating shader-based compositing masks on child layers.');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ==================================================================
        // SECTION 0 — Title banner
        // ==================================================================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_smSteel, _smDarkSteel, Color(0xFF1B2631)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ShaderMaskLayer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Compositing layer that applies a shader mask\n'
                'to its child layers during rendering',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _smBadge('Compositing', _smIce),
                  const SizedBox(width: 8),
                  _smBadge('Shader', Colors.white),
                  const SizedBox(width: 8),
                  _smBadge('BlendMode', _smGold),
                ],
              ),
            ],
          ),
        ),

        // ==================================================================
        // SECTION 1 — Overview: What is ShaderMaskLayer?
        // ==================================================================
        _smSectionHeader('1. What is ShaderMaskLayer?',
            subtitle:
                'A compositing layer that masks child pixels with a shader'),

        const SizedBox(height: 10),
        _smInfoCard(
          'ShaderMaskLayer sits in the compositing layer tree and applies '
          'a mask to everything rendered by its child layers.  The mask '
          'is defined by a Shader object (typically a gradient) and a '
          'BlendMode that controls how the shader combines with the '
          'child pixels.\n\n'
          'In practice, you rarely create ShaderMaskLayer directly.  '
          'Instead, you use the ShaderMask widget, which pushes a '
          'ShaderMaskLayer into the layer tree through its '
          'RenderShaderMask render object.',
        ),

        // Layer tree diagram
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _smLightIce,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _smSteel, width: 2),
          ),
          child: Column(
            children: [
              const Text('Compositing Layer Tree',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _smDarkSteel)),
              const SizedBox(height: 14),
              _smPropertyRow('shader', 'The Shader to apply as mask',
                  Icons.gradient, iconColor: _smSky),
              _smPropertyRow('maskRect', 'Bounds for the shader callback',
                  Icons.crop, iconColor: _smTeal),
              _smPropertyRow('blendMode', 'How shader & child combine',
                  Icons.layers, iconColor: _smAmber),
              _smPropertyRow('child layers', 'Everything below in the tree',
                  Icons.account_tree, iconColor: _smPlum),
            ],
          ),
        ),

        _smCodeBlock(
          '// The ShaderMask widget creates a\n'
          '// ShaderMaskLayer under the hood:\n\n'
          'ShaderMask(\n'
          '  shaderCallback: (Rect bounds) {\n'
          '    return LinearGradient(\n'
          '      colors: [Colors.white, Colors.transparent],\n'
          '    ).createShader(bounds);\n'
          '  },\n'
          '  blendMode: BlendMode.dstIn,\n'
          '  child: Image.asset(\'photo.jpg\'),\n'
          ')',
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 2 — Linear Gradient Masks
        // ==================================================================
        _smSectionHeader('2. Linear Gradient Masks',
            subtitle: 'Fading content with directional gradients'),

        const SizedBox(height: 10),
        _smInfoCard(
          'The most common use of ShaderMask is applying a linear gradient '
          'to fade content.  A gradient from white (opaque) to transparent '
          'with BlendMode.dstIn creates the classic "fade to nothing" effect.\n\n'
          'Direction matters: top→bottom fades the bottom away, '
          'left→right fades the right edge, and diagonal gradients '
          'create corner fades.',
          borderColor: _smSky,
        ),

        // Top to bottom fade
        _smGradientSample(
          label: 'Top → Bottom Fade (dstIn)',
          description: 'Content fades\nat the bottom',
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.transparent],
              stops: [0.5, 1.0],
            ).createShader(bounds);
          },
        ),

        // Left to right fade
        _smGradientSample(
          label: 'Left → Right Fade (dstIn)',
          description: 'Fades rightward',
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white, Colors.transparent],
              stops: [0.4, 1.0],
            ).createShader(bounds);
          },
        ),

        // Both edges fade
        _smGradientSample(
          label: 'Both Edges Fade',
          description: 'Sharp center,\nfaded edges',
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
              stops: [0.0, 0.2, 0.8, 1.0],
            ).createShader(bounds);
          },
        ),

        // Diagonal fade
        _smGradientSample(
          label: 'Diagonal Fade (Top-Left → Bottom-Right)',
          description: 'Corner reveal',
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.transparent],
              stops: [0.3, 0.9],
            ).createShader(bounds);
          },
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 3 — Radial Gradient Masks
        // ==================================================================
        _smSectionHeader('3. Radial Gradient Masks',
            subtitle: 'Circular and spotlight effects'),

        const SizedBox(height: 10),
        _smInfoCard(
          'A RadialGradient shader creates circular mask effects.  '
          'Combined with dstIn, this produces a spotlight or vignette '
          'where content is visible in the center and fades radially.\n\n'
          'By adjusting the center, radius, and color stops, you can '
          'create porthole views, soft circular crops, or dramatic '
          'spotlight reveals.',
          borderColor: _smTeal,
        ),

        // Centered radial
        _smGradientSample(
          label: 'Centered Radial Mask',
          description: 'Spotlight',
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.center,
              radius: 0.7,
              colors: const [Colors.white, Colors.transparent],
              stops: const [0.4, 1.0],
            ).createShader(bounds);
          },
        ),

        // Off-center radial
        _smGradientSample(
          label: 'Off-Center Radial (Top-Right Focus)',
          description: 'Corner spotlight',
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.topRight,
              radius: 1.2,
              colors: const [Colors.white, Colors.transparent],
              stops: const [0.2, 0.8],
            ).createShader(bounds);
          },
        ),

        // Tight circle
        _smGradientSample(
          label: 'Tight Circle (Porthole Effect)',
          description: 'Peep hole',
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.center,
              radius: 0.35,
              colors: const [Colors.white, Colors.white, Colors.transparent],
              stops: const [0.0, 0.8, 1.0],
            ).createShader(bounds);
          },
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 4 — Sweep Gradient Masks
        // ==================================================================
        _smSectionHeader('4. Sweep Gradient Masks',
            subtitle: 'Angular / rotational effects'),

        const SizedBox(height: 10),
        _smInfoCard(
          'SweepGradient creates an angular gradient around a center point.  '
          'When used as a shader mask, this produces rotational wipe effects, '
          'pie-chart-style reveals, and clock-hand animations.\n\n'
          'The startAngle and endAngle control which portion of the '
          'circle is opaque vs transparent.',
          borderColor: _smAmber,
        ),

        // Full sweep
        _smGradientSample(
          label: 'Full Sweep Mask (clockwise fade)',
          description: 'Rotational\nfade',
          shaderCallback: (Rect bounds) {
            return const SweepGradient(
              center: Alignment.center,
              colors: [Colors.white, Colors.transparent],
              stops: [0.0, 1.0],
            ).createShader(bounds);
          },
        ),

        // Quarter sweep
        _smGradientSample(
          label: 'Quarter Reveal (top-right quadrant)',
          description: 'Partial\nreveal',
          shaderCallback: (Rect bounds) {
            return const SweepGradient(
              center: Alignment.center,
              startAngle: 0.0,
              endAngle: 1.5708,
              colors: [Colors.white, Colors.transparent],
            ).createShader(bounds);
          },
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 5 — Blend Modes
        // ==================================================================
        _smSectionHeader('5. Blend Mode Comparison',
            subtitle: 'dstIn vs srcIn vs modulate'),

        const SizedBox(height: 10),
        _smInfoCard(
          'BlendMode.dstIn — The most common mode for masking.  Keeps the '
          'destination (child) pixels only where the source (shader) is '
          'opaque.  White shader = fully visible, transparent = hidden.\n\n'
          'BlendMode.srcIn — Paints the shader colour where the child '
          'is opaque.  Useful for colour tinting images.\n\n'
          'BlendMode.modulate — Multiplies child and shader colours.  '
          'Produces a darkening/tinting effect.',
          borderColor: _smCoral,
        ),

        // dstIn
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _smSteel),
          ),
          child: Column(
            children: [
              const Text('BlendMode.dstIn — Transparency Mask',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _smDarkSteel)),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Colors.transparent],
                  ).createShader(bounds),
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _smSky,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('dstIn',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text('Child → transparent where shader is transparent',
                  style: TextStyle(fontSize: 10, color: _smCharcoal)),
            ],
          ),
        ),

        // srcIn
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _smSteel),
          ),
          child: Column(
            children: [
              const Text('BlendMode.srcIn — Colour Tinting',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _smDarkSteel)),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [_smCoral, _smAmber, _smGold],
                  ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _smDarkSteel,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('srcIn',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text('Shader colour replaces child colour',
                  style: TextStyle(fontSize: 10, color: _smCharcoal)),
            ],
          ),
        ),

        // modulate
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _smSteel),
          ),
          child: Column(
            children: [
              const Text('BlendMode.modulate — Colour Multiply',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _smDarkSteel)),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [_smPlum, _smTeal],
                  ).createShader(bounds),
                  blendMode: BlendMode.modulate,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _smIce,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('modulate',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text('Shader × child pixel-by-pixel multiplication',
                  style: TextStyle(fontSize: 10, color: _smCharcoal)),
            ],
          ),
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 6 — Text Gradient Effects
        // ==================================================================
        _smSectionHeader('6. Text Gradient Effects',
            subtitle: 'Using ShaderMask to create gradient text'),

        const SizedBox(height: 10),
        _smInfoCard(
          'One of the most popular uses of ShaderMask is applying gradient '
          'colours to text.  Since Text widgets paint in a single colour, '
          'wrapping them in a ShaderMask with BlendMode.srcIn lets the '
          'gradient shader replace the flat colour with a gradient.\n\n'
          'This works because srcIn paints the shader colour wherever '
          'the source (text) pixels are opaque.',
          borderColor: _smPlum,
        ),

        // Gradient text examples
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _smDarkSteel,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Example 1: warm gradient
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [_smCoral, _smAmber, _smGold],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Warm Gradient',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Example 2: cool gradient
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [_smSky, _smTeal, _smEmerald],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Cool Gradient',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Example 3: purple-gold
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [_smPlum, _smCoral, _smGold],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Diagonal Shimmer',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Example 4: radial text
              ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: const [_smGold, _smCoral],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Radial Text',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        _smCodeBlock(
          'ShaderMask(\n'
          '  shaderCallback: (bounds) => LinearGradient(\n'
          '    colors: [Colors.red, Colors.orange, Colors.yellow],\n'
          '  ).createShader(bounds),\n'
          '  blendMode: BlendMode.srcIn,  // key!\n'
          '  child: Text(\'Gradient Text\', style: TextStyle(\n'
          '    color: Colors.white,  // base colour (masked)\n'
          '    fontSize: 28,\n'
          '    fontWeight: FontWeight.bold,\n'
          '  )),\n'
          ')',
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 7 — Icon Gradient Effects
        // ==================================================================
        _smSectionHeader('7. Icon Gradient Effects',
            subtitle: 'Applying shader masks to icons'),

        const SizedBox(height: 10),
        _smInfoCard(
          'Just like text, icons can be wrapped in ShaderMask to apply '
          'gradient colours.  This is useful for creating visually rich '
          'icon sets without custom SVGs or image assets.',
          borderColor: _smEmerald,
        ),

        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _smGradientIcon(
                Icons.favorite,
                [_smCoral, _smAmber],
                'Favourite',
              ),
              _smGradientIcon(
                Icons.star,
                [_smGold, _smAmber],
                'Starred',
              ),
              _smGradientIcon(
                Icons.local_fire_department,
                [_smCoral, _smGold],
                'Trending',
              ),
              _smGradientIcon(
                Icons.eco,
                [_smTeal, _smEmerald],
                'Nature',
              ),
              _smGradientIcon(
                Icons.water_drop,
                [_smSky, _smTeal],
                'Water',
              ),
            ],
          ),
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 8 — Practical Fade Patterns
        // ==================================================================
        _smSectionHeader('8. Practical Fade Patterns',
            subtitle: 'Real-world uses: scroll fades, card reveals, overlays'),

        const SizedBox(height: 10),
        _smInfoCard(
          'Shader masks are commonly used for:\n\n'
          '  • Scroll list fades — Fade the top/bottom edges of a list\n'
          '  • Image overlays — Partial transparency on hero images\n'
          '  • Card reveals — Gradual text appearance as cards enter view\n'
          '  • Status indicators — Rainbow progress bars',
          borderColor: _smGold,
        ),

        // Scroll fade demo
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _smSteel),
          ),
          child: Column(
            children: [
              const Text('List with Top/Bottom Fade',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _smDarkSteel)),
              const SizedBox(height: 10),
              SizedBox(
                height: 160,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.08, 0.92, 1.0],
                  ).createShader(bounds),
                  blendMode: BlendMode.dstIn,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: List.generate(
                      12,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: i.isEven
                                ? _smLightIce
                                : _smSteel.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: _smSteel.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text('${i + 1}',
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: _smSteel)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('List Item ${i + 1}',
                                  style: const TextStyle(
                                      fontSize: 12, color: _smCharcoal)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Hero image with gradient overlay
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Base coloured image stand-in
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_smSky, _smTeal, _smDarkSteel],
                  ),
                ),
                child: Center(
                  child: Icon(Icons.landscape, color: Colors.white.withValues(alpha: 0.3), size: 80),
                ),
              ),
              // Gradient overlay for text readability
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                    stops: [0.0, 1.0],
                  ).createShader(bounds),
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    height: 80,
                    color: Colors.black,
                  ),
                ),
              ),
              // Text over gradient
              const Positioned(
                left: 16,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mountain Valley',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text('A common hero image pattern with gradient overlay',
                        style: TextStyle(
                            color: Color(0xCCFFFFFF), fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 9 — Layer Tree Internals
        // ==================================================================
        _smSectionHeader('9. Layer Tree Internals',
            subtitle:
                'How ShaderMaskLayer fits in the compositing pipeline'),

        const SizedBox(height: 10),
        _smInfoCard(
          'During the compositing phase, the rendering pipeline builds a '
          'tree of Layer objects.  ShaderMaskLayer inherits from '
          'ContainerLayer and overrides addToScene() to push the shader '
          'mask effect into the engine\'s scene builder:\n\n'
          '  builder.pushShaderMask(\n'
          '    shader,\n'
          '    maskRect,\n'
          '    blendMode,\n'
          '  );\n'
          '  addChildrenToScene(builder);\n'
          '  builder.pop();\n\n'
          'This means everything painted by child layers is rendered into '
          'a temporary surface, then the shader mask is applied as a '
          'post-processing step before compositing into the parent.',
        ),

        // Visual: pipeline flow
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _smLightIce,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _smSteel, width: 2),
          ),
          child: Column(
            children: [
              const Text('Compositing Pipeline',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _smDarkSteel)),
              const SizedBox(height: 14),
              _smPipelineStep('1', 'pushShaderMask(shader, rect, mode)',
                  _smSky, Icons.layers),
              _smPipelineArrow(),
              _smPipelineStep('2', 'Children render to offscreen buffer',
                  _smTeal, Icons.image),
              _smPipelineArrow(),
              _smPipelineStep('3', 'Apply shader × child with blendMode',
                  _smAmber, Icons.auto_fix_high),
              _smPipelineArrow(),
              _smPipelineStep('4', 'Composite result into parent layer',
                  _smEmerald, Icons.check_circle),
            ],
          ),
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 10 — Multi-Stop Gradient Masks
        // ==================================================================
        _smSectionHeader('10. Multi-Stop Gradient Masks',
            subtitle: 'Complex fade patterns with multiple stops'),

        const SizedBox(height: 10),
        _smInfoCard(
          'By using multiple colour stops in the gradient, you can create '
          'sophisticated masking patterns: windows of visibility, '
          'bands of transparency, and stepped fades.',
          borderColor: _smTeal,
        ),

        // Window mask
        _smGradientSample(
          label: 'Window Mask (visible band in center)',
          description: 'Stripe\nvisibility',
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.white,
                Colors.white,
                Colors.transparent,
              ],
              stops: [0.0, 0.3, 0.7, 1.0],
            ).createShader(bounds);
          },
        ),

        // Three-band mask
        _smGradientSample(
          label: 'Three-Band Horizontal Mask',
          description: 'Banded\nstripes',
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Colors.white,
                Colors.transparent,
                Colors.white,
                Colors.transparent,
                Colors.white,
              ],
              stops: [0.0, 0.25, 0.5, 0.75, 1.0],
            ).createShader(bounds);
          },
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 11 — Performance Considerations
        // ==================================================================
        _smSectionHeader('11. Performance Considerations',
            subtitle: 'GPU cost and when to use alternatives'),

        const SizedBox(height: 10),
        _smInfoCard(
          'ShaderMaskLayer introduces an offscreen compositing pass, '
          'which means:\n\n'
          '  • Extra GPU memory for the offscreen buffer\n'
          '  • An additional render pass to apply the blend\n'
          '  • Potentially large if the masked area covers the whole screen\n\n'
          'Guidelines:\n'
          '  • Prefer DecoratedBox with gradient for simple backgrounds\n'
          '  • Use ShaderMask only when you need pixel-level masking\n'
          '  • Avoid nesting multiple ShaderMask layers\n'
          '  • Use RepaintBoundary around frequently-changing masked content\n'
          '  • Profile with the "Performance Overlay" to check GPU usage',
          borderColor: _smCoral,
        ),

        // Performance comparison cards
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              const Text('Cost Comparison',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _smCharcoal)),
              const SizedBox(height: 14),
              _smCostRow('DecoratedBox gradient', 'Low',
                  _smEmerald, 1),
              _smCostRow('Simple ShaderMask', 'Medium',
                  _smAmber, 2),
              _smCostRow('Nested ShaderMask × 2', 'High',
                  _smCoral, 3),
              _smCostRow('Fullscreen + animation', 'Very High',
                  _smCoral, 4),
            ],
          ),
        ),

        _smDivider(),

        // ==================================================================
        // SECTION 12 — Summary
        // ==================================================================
        _smSectionHeader('12. Summary',
            subtitle: 'ShaderMaskLayer in the rendering pipeline'),

        const SizedBox(height: 10),
        _smInfoCard(
          'ShaderMaskLayer is a powerful compositing primitive that enables '
          'gradient fades, colour tinting, spotlight effects, and text '
          'gradients.  Key takeaways:\n\n'
          '  • Use ShaderMask widget → creates ShaderMaskLayer\n'
          '  • shaderCallback receives Rect → return a Shader\n'
          '  • BlendMode.dstIn for transparency masks\n'
          '  • BlendMode.srcIn for colour tinting\n'
          '  • Linear, Radial, Sweep gradients all work\n'
          '  • Multi-stop gradients for complex patterns\n'
          '  • Be mindful of GPU cost for large masked areas',
          borderColor: _smSteel,
        ),

        // Closing visual
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_smSteel, _smDarkSteel, Color(0xFF1B2631)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [_smGold, _smAmber, _smCoral],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Icon(Icons.gradient, size: 40),
              ),
              const SizedBox(height: 10),
              const Text(
                'Shader Masks: Pixel-Perfect Effects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'From subtle fades to dramatic reveals,\n'
                'ShaderMaskLayer brings GPU-powered masking to Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
      ],
    ),
  );
}

// ==========================================================================
// Additional helper widgets
// ==========================================================================

Widget _smGradientIcon(
    IconData icon, List<Color> gradientColors, String label) {
  return Column(
    children: [
      ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ).createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: Icon(icon, size: 36, color: Colors.white),
      ),
      const SizedBox(height: 4),
      Text(label,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _smCharcoal)),
    ],
  );
}

Widget _smPipelineStep(
    String number, String label, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(number,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label,
              style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
        ),
        Icon(icon, color: color, size: 20),
      ],
    ),
  );
}

Widget _smPipelineArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Icon(Icons.arrow_downward, color: _smSteel, size: 18),
  );
}

Widget _smCostRow(String label, String cost, Color color, int level) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label,
              style: const TextStyle(fontSize: 12, color: _smCharcoal)),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              ...List.generate(
                level,
                (_) => Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Container(
                    width: 18,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(cost,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: color)),
            ],
          ),
        ),
      ],
    ),
  );
}
