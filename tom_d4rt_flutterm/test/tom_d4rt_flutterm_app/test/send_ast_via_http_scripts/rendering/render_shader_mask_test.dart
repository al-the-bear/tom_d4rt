// ignore_for_file: avoid_print
// Deep demo: RenderShaderMask — Shader Painting Studio
// Demonstrates how ShaderMask applies gradient shaders to child widgets
// using different BlendModes. Covers gradient text, edge fading, blend
// mode comparison, custom shader patterns, and layered composition.
import 'dart:math';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette definitions — each palette gives the demo a distinct personality
// ---------------------------------------------------------------------------
class _Pal {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color onSurface;
  final Color accent;
  final Color muted;
  final String name;
  const _Pal(this.name, this.primary, this.secondary, this.surface,
      this.onSurface, this.accent, this.muted);
}

const _palettes = <_Pal>[
  _Pal('Purple / Gold', Color(0xFF4A148C), Color(0xFFF9A825),
      Color(0xFFF3E5F5), Color(0xFF311B92), Color(0xFFD500F9), Color(0xFF9575CD)),
  _Pal('Cyan / Magenta', Color(0xFF006064), Color(0xFFAD1457),
      Color(0xFFE0F7FA), Color(0xFF004D40), Color(0xFF00E5FF), Color(0xFF80DEEA)),
  _Pal('Charcoal / Green', Color(0xFF263238), Color(0xFF76FF03),
      Color(0xFFECEFF1), Color(0xFF37474F), Color(0xFF00E676), Color(0xFF90A4AE)),
];

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _ShaderPaintingStudio();
}

class _ShaderPaintingStudio extends StatefulWidget {
  const _ShaderPaintingStudio();
  @override
  State<_ShaderPaintingStudio> createState() => _ShaderPaintingStudioState();
}

class _ShaderPaintingStudioState extends State<_ShaderPaintingStudio> {
  int _scenario = 0;
  int _palette = 0;
  bool _verbose = false;

  static const _scenarioTitles = <String>[
    '1 · Gradient Text',
    '2 · Blend Modes',
    '3 · Edge Fading',
    '4 · Shader Patterns',
    '5 · Layered Composition',
    '6 · Verification & Guide',
  ];

  _Pal get _p => _palettes[_palette];

  void _log(String msg) {
    if (_verbose) print('[ShaderStudio] $msg');
  }

  @override
  Widget build(BuildContext context) {
    _log('build scenario=$_scenario palette=$_palette');
    return Scaffold(
      backgroundColor: _p.surface,
      body: Column(
        children: [
          _buildHeader(),
          _buildControlBoard(),
          Expanded(child: _buildScenario()),
          _buildFooter(),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Header
  // -----------------------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_p.primary, _p.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gradient, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Text('Shader Painting Studio',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'ShaderMask applies a shader (gradient) to its child widget via '
            'a BlendMode. The underlying RenderShaderMask composites a '
            'shader rectangle on top of the child layer. Explore gradient '
            'text, blend modes, edge fading, and layered composition.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Control Board
  // -----------------------------------------------------------------------
  Widget _buildControlBoard() {
    return Container(
      width: double.infinity,
      color: _p.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Scenario:', style: TextStyle(fontWeight: FontWeight.w600,
              color: _p.onSurface, fontSize: 13)),
          for (var i = 0; i < _scenarioTitles.length; i++)
            ChoiceChip(
              label: Text('${i + 1}',
                  style: TextStyle(
                      color: _scenario == i ? Colors.white : _p.onSurface,
                      fontSize: 12)),
              selected: _scenario == i,
              selectedColor: _p.primary,
              backgroundColor: _p.surface,
              onSelected: (_) =>
                  setState(() { _scenario = i; _log('scenario=$i'); }),
            ),
          const SizedBox(width: 14),
          Text('Palette:', style: TextStyle(fontWeight: FontWeight.w600,
              color: _p.onSurface, fontSize: 13)),
          for (var j = 0; j < _palettes.length; j++)
            GestureDetector(
              onTap: () =>
                  setState(() { _palette = j; _log('palette=$j'); }),
              child: Container(
                width: 22, height: 22,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: _palettes[j].primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _palette == j ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Verbose', style: TextStyle(fontSize: 12,
                color: _p.onSurface)),
            Switch(
                value: _verbose,
                activeTrackColor: _p.accent,
                onChanged: (v) => setState(() => _verbose = v)),
          ]),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Scenario dispatcher
  // -----------------------------------------------------------------------
  Widget _buildScenario() {
    switch (_scenario) {
      case 0: return _buildGradientText();
      case 1: return _buildBlendModeLab();
      case 2: return _buildEdgeFading();
      case 3: return _buildShaderPatterns();
      case 4: return _buildLayeredComposition();
      case 5: return _buildVerification();
      default: return const SizedBox.shrink();
    }
  }

  // =======================================================================
  // SCENARIO 1 — Gradient Text Showcase
  // =======================================================================
  Widget _buildGradientText() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Gradient Text Showcase'),
          const SizedBox(height: 6),
          Text(
            'ShaderMask with BlendMode.srcIn replaces the child\'s opaque '
            'pixels with the shader color. When applied to white text, the '
            'text becomes filled with the gradient. This is the most popular '
            'use of ShaderMask in production Flutter apps.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          _linearGradientText(),
          const SizedBox(height: 14),
          _radialGradientText(),
          const SizedBox(height: 14),
          _sweepGradientText(),
          const SizedBox(height: 14),
          _multiStopGradientText(),
          const SizedBox(height: 14),
          _gradientTextComparison(),
          const SizedBox(height: 20),
          _instructionBox(
            'Key insight: The shader replaces any opaque pixel in the child. '
            'Use white or fully opaque text as the child — the shader color '
            'will fill those pixels. If the child has transparency, the '
            'gradient will respect it. BlendMode.srcIn means "show source '
            '(shader) only where destination (child) is opaque."',
          ),
        ],
      ),
    );
  }

  Widget _linearGradientText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Linear Gradient', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: _p.primary)),
          const SizedBox(height: 4),
          Text('Left→right gradient across text. The most common pattern.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                _log('linear shader bounds=$bounds');
                return LinearGradient(
                  colors: [_p.primary, _p.secondary, _p.accent],
                ).createShader(bounds);
              },
              child: Text('Gradient Text',
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity, height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [_p.primary, _p.secondary, _p.accent]),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('primary', style: TextStyle(fontSize: 9,
                  fontFamily: 'monospace', color: _p.muted)),
              Text('secondary', style: TextStyle(fontSize: 9,
                  fontFamily: 'monospace', color: _p.muted)),
              Text('accent', style: TextStyle(fontSize: 9,
                  fontFamily: 'monospace', color: _p.muted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _radialGradientText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Radial Gradient', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Radiates from center outward. Creates a spotlight effect.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [_p.accent, _p.primary, _p.secondary],
                ).createShader(bounds);
              },
              child: Text('Radial',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_p.accent, _p.primary, _p.secondary],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sweepGradientText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sweep Gradient', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.accent)),
          const SizedBox(height: 4),
          Text('Rotates colors around a center point like a clock dial.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return SweepGradient(
                  colors: [_p.primary, _p.secondary, _p.accent, _p.primary],
                ).createShader(bounds);
              },
              child: Text('SWEEP',
                  style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 8,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [_p.primary, _p.secondary, _p.accent, _p.primary],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _multiStopGradientText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Multi-Stop Gradient', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Custom color stops create uneven gradient distribution.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [_p.primary, _p.primary, _p.accent,
                    _p.secondary, _p.secondary],
                  stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                ).createShader(bounds);
              },
              child: Text('Custom Stops',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          // Stop marker visualization
          Stack(
            children: [
              Container(
                width: double.infinity, height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [_p.primary, _p.primary, _p.accent,
                      _p.secondary, _p.secondary],
                    stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                  ),
                ),
              ),
              for (final stop in [0.0, 0.3, 0.5, 0.7, 1.0])
                Positioned(
                  left: stop * 280,
                  top: 0, bottom: 0,
                  child: Container(
                    width: 2, height: 24,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final s in ['0.0', '0.3', '0.5', '0.7', '1.0'])
                Text(s, style: TextStyle(fontSize: 9,
                    fontFamily: 'monospace', color: _p.muted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gradientTextComparison() {
    final types = <(String, Gradient)>[
      ('Horizontal', LinearGradient(
          colors: [_p.primary, _p.secondary])),
      ('Vertical', LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [_p.primary, _p.secondary])),
      ('Diagonal', LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [_p.primary, _p.accent, _p.secondary])),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Direction Comparison', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          for (var i = 0; i < types.length; i++) ...[
            Row(
              children: [
                SizedBox(width: 70, child: Text(types[i].$1,
                    style: TextStyle(fontSize: 11,
                        fontWeight: FontWeight.w600, color: _p.muted))),
                const SizedBox(width: 8),
                Expanded(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) =>
                        types[i].$2.createShader(bounds),
                    child: Text('Flutter',
                        style: TextStyle(fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
            if (i < types.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 2 — Blend Mode Laboratory
  // =======================================================================
  Widget _buildBlendModeLab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Blend Mode Laboratory'),
          const SizedBox(height: 6),
          Text(
            'The blendMode property controls how the shader composites with '
            'the child. Each mode produces a dramatically different result. '
            'srcIn is most common for gradient text, while dstIn is used '
            'for fade/mask effects.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          _blendModeGrid(),
          const SizedBox(height: 14),
          _blendModeExplanation(),
          const SizedBox(height: 14),
          _srcInVsDstIn(),
          const SizedBox(height: 14),
          _blendModeOnIcons(),
          const SizedBox(height: 20),
          _instructionBox(
            'BlendMode determines the formula for combining source (shader) '
            'and destination (child). srcIn: show shader where child is '
            'opaque. dstIn: show child where shader is opaque. srcATop: '
            'show shader on top of child, clipped to child. modulate: '
            'multiply colors together.',
          ),
        ],
      ),
    );
  }

  Widget _blendModeGrid() {
    final modes = <(BlendMode, String)>[
      (BlendMode.srcIn, 'srcIn'),
      (BlendMode.srcATop, 'srcATop'),
      (BlendMode.dstIn, 'dstIn'),
      (BlendMode.dstATop, 'dstATop'),
      (BlendMode.modulate, 'modulate'),
      (BlendMode.screen, 'screen'),
      (BlendMode.overlay, 'overlay'),
      (BlendMode.multiply, 'multiply'),
      (BlendMode.colorBurn, 'colorBurn'),
      (BlendMode.softLight, 'softLight'),
      (BlendMode.difference, 'difference'),
      (BlendMode.exclusion, 'exclusion'),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Blend Mode Grid', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Same gradient + icon, different blend modes.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final m in modes)
                SizedBox(
                  width: 85,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 85, height: 70,
                        decoration: BoxDecoration(
                          color: _p.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: _p.muted.withValues(alpha: 0.3)),
                        ),
                        child: Center(
                          child: ShaderMask(
                            blendMode: m.$1,
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [_p.primary, _p.secondary],
                              ).createShader(bounds);
                            },
                            child: Icon(Icons.star_rounded,
                                color: Colors.white, size: 44),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(m.$2, style: TextStyle(fontSize: 9,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                          color: _p.onSurface),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _blendModeExplanation() {
    final formulas = <(String, String, String)>[
      ('srcIn', 'src × dst.a', 'Show shader where child is opaque'),
      ('dstIn', 'dst × src.a', 'Show child where shader is opaque'),
      ('srcATop', 'src × dst.a + dst × (1-src.a)',
          'Shader on top, clipped to child'),
      ('modulate', 'src × dst', 'Multiply colors (darkens)'),
      ('screen', 'src + dst - src×dst', 'Lighten (opposite of multiply)'),
      ('overlay', 'mix of multiply/screen', 'Contrast-boosting composite'),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Blend Mode Formulas', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          for (var i = 0; i < formulas.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,
                  vertical: 6),
              color: i.isEven ? _p.surface : Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(formulas[i].$1, style: TextStyle(
                        fontFamily: 'monospace', fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _p.primary)),
                  ),
                  SizedBox(
                    width: 140,
                    child: Text(formulas[i].$2, style: TextStyle(
                        fontFamily: 'monospace', fontSize: 10,
                        color: _p.muted)),
                  ),
                  Expanded(
                    child: Text(formulas[i].$3, style: TextStyle(
                        fontSize: 11, color: _p.onSurface)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _srcInVsDstIn() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('srcIn vs dstIn', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('The two most important modes for ShaderMask.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: _p.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: _p.primary.withValues(alpha: 0.3)),
                      ),
                      child: Center(
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => LinearGradient(
                            colors: [_p.primary, _p.accent],
                          ).createShader(bounds),
                          child: Text('srcIn',
                              style: TextStyle(fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Gradient fills text',
                        style: TextStyle(fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _p.primary)),
                    Text('Child shape, shader color',
                        style: TextStyle(fontSize: 9, color: _p.muted)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: _p.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: _p.secondary.withValues(alpha: 0.3)),
                      ),
                      child: Center(
                        child: ShaderMask(
                          blendMode: BlendMode.dstIn,
                          shaderCallback: (Rect bounds) => LinearGradient(
                            colors: [Colors.white, Colors.transparent],
                          ).createShader(bounds),
                          child: Text('dstIn',
                              style: TextStyle(fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: _p.secondary)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Shader masks opacity',
                        style: TextStyle(fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _p.secondary)),
                    Text('Child color, shader opacity',
                        style: TextStyle(fontSize: 9, color: _p.muted)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _blendModeOnIcons() {
    final showcase = <(BlendMode, String, IconData)>[
      (BlendMode.srcIn, 'srcIn', Icons.favorite),
      (BlendMode.modulate, 'modulate', Icons.cloud),
      (BlendMode.screen, 'screen', Icons.flash_on),
      (BlendMode.overlay, 'overlay', Icons.spa),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Blend Modes on Icons', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Same gradient applied to different icons with different '
              'blend modes.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < showcase.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 8 : 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: _p.primary.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: _p.muted.withValues(alpha: 0.2)),
                          ),
                          child: Center(
                            child: ShaderMask(
                              blendMode: showcase[i].$1,
                              shaderCallback: (Rect bounds) =>
                                  LinearGradient(
                                    colors: [_p.primary, _p.secondary],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds),
                              child: Icon(showcase[i].$3,
                                  color: Colors.white, size: 38),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(showcase[i].$2, style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                            color: _p.onSurface)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 3 — Edge Fading Effects
  // =======================================================================
  Widget _buildEdgeFading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Edge Fading Effects'),
          const SizedBox(height: 6),
          Text(
            'ShaderMask with BlendMode.dstIn and a gradient from white '
            'to transparent creates a fade-out effect on the child. '
            'The opaque part of the gradient shows the child; the '
            'transparent part hides it. This is used for scroll fade '
            'edges, vignette effects, and soft masks.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          _bottomFade(),
          const SizedBox(height: 14),
          _topFade(),
          const SizedBox(height: 14),
          _horizontalFade(),
          const SizedBox(height: 14),
          _radialVignette(),
          const SizedBox(height: 14),
          _doubleFade(),
          const SizedBox(height: 20),
          _instructionBox(
            'For fading, always use BlendMode.dstIn (not srcIn). '
            'The gradient goes from Colors.white (fully opaque = show child) '
            'to Colors.transparent (fully transparent = hide child). '
            'The child keeps its own colors; the gradient only controls '
            'visibility.',
          ),
        ],
      ),
    );
  }

  Widget _bottomFade() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bottom Fade', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Content fades out at the bottom — ideal for scroll areas.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              _log('bottom fade bounds=$bounds');
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [Colors.white, Colors.white,
                  Colors.transparent],
                stops: const [0.0, 0.6, 1.0],
              ).createShader(bounds);
            },
            child: Container(
              height: 160,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 1; i <= 7; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Container(
                            width: 6, height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, color: _p.primary),
                          ),
                          const SizedBox(width: 8),
                          Text('List item number $i shows content here',
                              style: TextStyle(fontSize: 13,
                                  color: _p.onSurface)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topFade() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Fade', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Content fades out at the top — reverse scroll indicator.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [Colors.transparent, Colors.white,
                  Colors.white],
                stops: const [0.0, 0.4, 1.0],
              ).createShader(bounds);
            },
            child: Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 1; i <= 5; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Icon(Icons.chevron_right,
                              color: _p.secondary, size: 16),
                          const SizedBox(width: 4),
                          Text('Entry $i — gradually appears',
                              style: TextStyle(fontSize: 13,
                                  color: _p.onSurface)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizontalFade() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Horizontal Fade', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.accent)),
          const SizedBox(height: 4),
          Text('Content fades at both horizontal edges. Good for '
              'horizontal scroll areas or long text.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: const [Colors.transparent, Colors.white,
                  Colors.white, Colors.transparent],
                stops: const [0.0, 0.15, 0.85, 1.0],
              ).createShader(bounds);
            },
            child: Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var c in [_p.primary, _p.secondary, _p.accent,
                    Color(0xFF6A1B9A), Color(0xFFE65100),
                    _p.primary, _p.secondary])
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: c,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _radialVignette() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Radial Vignette', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('RadialGradient fading from center outward creates a '
              'vignette (darkened edges) or content mask.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.center,
                  radius: 0.7,
                  colors: const [Colors.white, Colors.white,
                    Colors.transparent],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(bounds);
              },
              child: Container(
                width: 200, height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomPaint(
                  painter: _CheckerboardPainter(
                    _p.primary.withValues(alpha: 0.3),
                    _p.secondary.withValues(alpha: 0.3),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.landscape,
                            color: _p.primary, size: 40),
                        Text('Vignette',
                            style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _p.onSurface)),
                      ],
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

  Widget _doubleFade() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Double Edge Fade (Top + Bottom)', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Four-stop gradient fades both edges of a vertical list.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [Colors.transparent, Colors.white,
                  Colors.white, Colors.transparent],
                stops: const [0.0, 0.15, 0.85, 1.0],
              ).createShader(bounds);
            },
            child: Container(
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 1; i <= 6; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: i.isOdd
                              ? _p.primary.withValues(alpha: 0.12)
                              : _p.secondary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _p.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'stops: [0.0, 0.15, 0.85, 1.0]\n'
              'colors: [transparent, white, white, transparent]',
              style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                  color: _p.muted),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 4 — Custom Shader Patterns
  // =======================================================================
  Widget _buildShaderPatterns() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Custom Shader Patterns'),
          const SizedBox(height: 6),
          Text(
            'Beyond simple linear gradients, ShaderMask supports any '
            'gradient type for creative visual effects: sweep gradients '
            'for arcs, radial for spotlight, sharp-stop for geometric '
            'masks, and diagonal for metallic sheen.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          _sweepProgressArc(),
          const SizedBox(height: 14),
          _spotlightGlow(),
          const SizedBox(height: 14),
          _metallicSheen(),
          const SizedBox(height: 14),
          _geometricMask(),
          const SizedBox(height: 14),
          _rainbowShader(),
          const SizedBox(height: 20),
          _instructionBox(
            'The shaderCallback receives the bounds of the ShaderMask '
            'widget. You can create any Gradient and call '
            'createShader(bounds) on it. The gradient coordinates are in '
            'the widget\'s local coordinate space.',
          ),
        ],
      ),
    );
  }

  Widget _sweepProgressArc() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sweep Gradient Progress Arc', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('SweepGradient with sharp stops creates a progress ring '
              'or clock-like arc effect.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var pct in [0.25, 0.5, 0.75])
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return SweepGradient(
                          startAngle: 0,
                          endAngle: 2 * pi,
                          colors: [_p.primary, _p.accent,
                            Colors.transparent, Colors.transparent],
                          stops: [0.0, pct, pct, 1.0],
                        ).createShader(bounds);
                      },
                      child: Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white, width: 8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('${(pct * 100).toInt()}%',
                        style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _p.primary)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _spotlightGlow() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Spotlight / Glow', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Tight radial gradient creates a spotlight that highlights '
              'the center and softly fades everything else.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: const Alignment(-0.2, -0.3),
                radius: 0.5,
                colors: [_p.accent.withValues(alpha: 0.9),
                  _p.primary.withValues(alpha: 0.4),
                  Colors.transparent],
                stops: const [0.0, 0.4, 1.0],
              ).createShader(bounds);
            },
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _p.onSurface,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.flare, color: Colors.white, size: 36),
                    const SizedBox(height: 4),
                    Text('Spotlight Effect',
                        style: TextStyle(color: Colors.white, fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metallicSheen() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Metallic Sheen', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.accent)),
          const SizedBox(height: 4),
          Text('Diagonal gradient with light-dark-light pattern creates '
              'a chrome or brushed-metal look.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _p.muted,
                    Colors.white,
                    _p.primary,
                    Colors.white,
                    _p.muted,
                  ],
                  stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                ).createShader(bounds);
              },
              child: Text('CHROME',
                  style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8),
          // Show the gradient strip
          Container(
            width: double.infinity, height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_p.muted, Colors.white, _p.primary,
                  Colors.white, _p.muted],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _geometricMask() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Geometric Mask', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Sharp color stops without smoothing create a hard '
              'geometric division — half visible, half hidden.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: const [Colors.white, Colors.white,
                            Colors.transparent, Colors.transparent],
                          stops: const [0.0, 0.5, 0.5, 1.0],
                        ).createShader(bounds);
                      },
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _p.primary,
                        ),
                        alignment: Alignment.center,
                        child: Text('Left Half',
                            style: TextStyle(color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Horizontal split',
                        style: TextStyle(fontSize: 10,
                            color: _p.muted)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: const [Colors.white, Colors.white,
                            Colors.transparent, Colors.transparent],
                          stops: const [0.0, 0.5, 0.5, 1.0],
                        ).createShader(bounds);
                      },
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _p.secondary,
                        ),
                        alignment: Alignment.center,
                        child: Text('Top Half',
                            style: TextStyle(color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Vertical split',
                        style: TextStyle(fontSize: 10,
                            color: _p.muted)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rainbowShader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rainbow Shader', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: Color(0xFFE91E63))),
          const SizedBox(height: 4),
          Text('Multi-color gradient with spectral colors for a '
              'rainbow effect on any widget.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: const [
                    Color(0xFFE91E63), // red-pink
                    Color(0xFFFF9800), // orange
                    Color(0xFFFFEB3B), // yellow
                    Color(0xFF4CAF50), // green
                    Color(0xFF2196F3), // blue
                    Color(0xFF9C27B0), // purple
                  ],
                ).createShader(bounds);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 32),
                  const SizedBox(width: 8),
                  Text('RAINBOW',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity, height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                colors: const [
                  Color(0xFFE91E63), Color(0xFFFF9800),
                  Color(0xFFFFEB3B), Color(0xFF4CAF50),
                  Color(0xFF2196F3), Color(0xFF9C27B0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 5 — Layered Composition
  // =======================================================================
  Widget _buildLayeredComposition() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Layered Composition'),
          const SizedBox(height: 6),
          Text(
            'Multiple ShaderMasks can be nested to compound effects. '
            'Each ShaderMask operates on the output of the one below it. '
            'The order matters: the outermost mask processes the combined '
            'output of all inner masks and content.',
            style: TextStyle(fontSize: 13, color: _p.onSurface),
          ),
          const SizedBox(height: 16),
          _nestedGradientFade(),
          const SizedBox(height: 14),
          _tripleLayer(),
          const SizedBox(height: 14),
          _colorTintOverlay(),
          const SizedBox(height: 14),
          _shaderMaskOnContainer(),
          const SizedBox(height: 14),
          _compositionOrder(),
          const SizedBox(height: 20),
          _instructionBox(
            'When nesting ShaderMasks, the inner mask processes first, '
            'then the outer mask processes the combined result. Think of '
            'it as layers in an image editor: each ShaderMask is a layer '
            'effect applied in stack order.',
          ),
        ],
      ),
    );
  }

  Widget _nestedGradientFade() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nested: Gradient Text + Fade', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Inner ShaderMask makes text gradient (srcIn). Outer '
              'ShaderMask fades it horizontally (dstIn).',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) => LinearGradient(
                colors: const [Colors.transparent, Colors.white,
                  Colors.white, Colors.transparent],
                stops: const [0.0, 0.2, 0.8, 1.0],
              ).createShader(bounds),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => LinearGradient(
                  colors: [_p.primary, _p.secondary, _p.accent],
                ).createShader(bounds),
                child: Text('Nested Shader',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _p.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Layer 1: srcIn gradient\n→ fills text with color',
                      style: TextStyle(fontSize: 10,
                          color: _p.primary)),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _p.secondary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Layer 2: dstIn fade\n→ fades edges to transparent',
                      style: TextStyle(fontSize: 10,
                          color: _p.secondary)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tripleLayer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Triple Layer Stack', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('Three ShaderMasks: gradient color → vignette → tint.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Center(
            child: ShaderMask(
              // Layer 3: color tint
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_p.accent.withValues(alpha: 0.2),
                  Colors.transparent],
              ).createShader(bounds),
              child: ShaderMask(
                // Layer 2: radial vignette
                blendMode: BlendMode.dstIn,
                shaderCallback: (Rect bounds) => RadialGradient(
                  radius: 0.8,
                  colors: const [Colors.white, Colors.white,
                    Colors.transparent],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(bounds),
                child: ShaderMask(
                  // Layer 1: horizontal gradient
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [_p.primary, _p.secondary],
                  ).createShader(bounds),
                  child: Container(
                    width: 180, height: 120,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.layers,
                            color: Colors.white, size: 36),
                        const SizedBox(height: 4),
                        Text('3 Layers',
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 1; i <= 3; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      color: [_p.primary, _p.muted, _p.accent][i - 1],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('$i', style: TextStyle(
                        color: Colors.white, fontSize: 11,
                        fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  Text(['srcIn: gradient fill',
                    'dstIn: radial vignette',
                    'srcATop: accent tint'][i - 1],
                      style: TextStyle(fontSize: 12,
                          color: _p.onSurface)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _colorTintOverlay() {
    final tints = <(String, Color)>[
      ('Warm', Color(0xFFFF8F00)),
      ('Cool', Color(0xFF0277BD)),
      ('Sepia', Color(0xFF795548)),
      ('Neon', Color(0xFF76FF03)),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Color Tint Overlays', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 4),
          Text('Using srcATop or modulate to apply a color wash over '
              'content. Similar to photo filters.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < tints.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 6 : 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcATop,
                          shaderCallback: (Rect bounds) =>
                              LinearGradient(
                                colors: [tints[i].$2.withValues(alpha: 0.5),
                                  tints[i].$2.withValues(alpha: 0.3)],
                              ).createShader(bounds),
                          child: Container(
                            height: 72,
                            decoration: BoxDecoration(
                              color: _p.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(Icons.photo,
                                  color: _p.onSurface, size: 28),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(tints[i].$1, style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600,
                            color: tints[i].$2)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shaderMaskOnContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ShaderMask on Rich Content', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.secondary)),
          const SizedBox(height: 4),
          Text('ShaderMask works on any child — not just text. '
              'Here it applies to a card with multiple child widgets.',
              style: TextStyle(fontSize: 12,
                  color: _p.onSurface.withValues(alpha: 0.7))),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_p.primary.withValues(alpha: 0.1),
                  _p.secondary.withValues(alpha: 0.3)],
              ).createShader(bounds);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _p.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: _p.muted.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: _p.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.palette,
                        color: _p.primary, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tinted Card',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 14, color: _p.onSurface)),
                        Text('The entire card has a gradient tint '
                            'applied via ShaderMask.',
                            style: TextStyle(fontSize: 12,
                                color: _p.muted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _compositionOrder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _p.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Composition Order Matters', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 8),
          Text('The rendering pipeline processes inside-out:',
              style: TextStyle(fontSize: 12, color: _p.onSurface)),
          const SizedBox(height: 8),
          for (var i = 0; i < 4; i++) ...[
            Row(
              children: [
                Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    color: _p.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text('${i + 1}', style: TextStyle(
                      color: Colors.white, fontSize: 11,
                      fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text([
                    'Child widget paints its content',
                    'Innermost ShaderMask applies its shader + blend mode',
                    'Next ShaderMask operates on the combined result',
                    'Outermost ShaderMask processes everything below it',
                  ][i], style: TextStyle(fontSize: 12,
                      color: _p.onSurface)),
                ),
              ],
            ),
            if (i < 3)
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Container(width: 2, height: 10,
                    color: _p.muted.withValues(alpha: 0.3)),
              ),
          ],
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'ShaderMask(outer,\n'
              '  ShaderMask(inner,\n'
              '    child: content)) // renders inside-out',
              style: TextStyle(fontSize: 10, fontFamily: 'monospace',
                  color: _p.muted),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // SCENARIO 6 — Verification & Guide
  // =======================================================================
  Widget _buildVerification() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification & Guide'),
          const SizedBox(height: 12),
          _shaderMaskApiReference(),
          const SizedBox(height: 16),
          _commonPatternsTable(),
          const SizedBox(height: 16),
          _verificationChecklist(),
          const SizedBox(height: 16),
          _faqSection(),
          const SizedBox(height: 16),
          _pitfalls(),
          const SizedBox(height: 16),
          _instructionBox(
            'RenderShaderMask is a single-child render object that creates '
            'a ShaderMaskLayer. The shaderCallback runs during paint to '
            'create the shader. It is called every time the widget\'s size '
            'changes. Keep shader creation lightweight — avoid expensive '
            'computations in shaderCallback.',
          ),
        ],
      ),
    );
  }

  Widget _shaderMaskApiReference() {
    final props = <(String, String, String)>[
      ('shaderCallback', 'ShaderCallback', 'Function that returns a '
          'Shader from bounds Rect'),
      ('blendMode', 'BlendMode', 'How shader composites with child'),
      ('child', 'Widget?', 'The widget to apply shader to'),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ShaderMask API', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: _p.primary)),
          const SizedBox(height: 10),
          for (var i = 0; i < props.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,
                  vertical: 6),
              color: i.isEven ? _p.surface : Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(props[i].$1, style: TextStyle(
                        fontFamily: 'monospace', fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _p.primary)),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(props[i].$2, style: TextStyle(
                        fontFamily: 'monospace', fontSize: 10,
                        color: _p.muted)),
                  ),
                  Expanded(
                    child: Text(props[i].$3, style: TextStyle(
                        fontSize: 11, color: _p.onSurface)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _commonPatternsTable() {
    final patterns = <(String, String, String)>[
      ('Gradient text', 'srcIn', 'LinearGradient → white text'),
      ('Edge fade (bottom)', 'dstIn', 'Linear top→bottom, white→transparent'),
      ('Edge fade (both)', 'dstIn', 'transparent→white→white→transparent'),
      ('Vignette', 'dstIn', 'Radial white center→transparent edge'),
      ('Color tint', 'srcATop', 'Solid or gradient color overlay'),
      ('Metallic sheen', 'srcIn', 'light→dark→light diagonal gradient'),
      ('Spotlight', 'srcATop', 'Radial with transparent outer'),
      ('Geometric mask', 'dstIn', 'Sharp stops at 0.5'),
    ];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _p.primary.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10)),
            ),
            child: Text('Common Patterns',
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 14, color: _p.primary)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12,
                vertical: 6),
            color: _p.onSurface.withValues(alpha: 0.03),
            child: Row(
              children: [
                SizedBox(width: 120,
                    child: Text('Pattern',
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 11, color: _p.muted))),
                SizedBox(width: 70,
                    child: Text('Mode',
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 11, color: _p.muted))),
                Expanded(child: Text('Gradient Setup',
                    style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 11, color: _p.muted))),
              ],
            ),
          ),
          for (var i = 0; i < patterns.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12,
                  vertical: 5),
              color: i.isEven ? Colors.transparent
                  : _p.onSurface.withValues(alpha: 0.02),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(patterns[i].$1, style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w600,
                        color: _p.onSurface)),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(patterns[i].$2, style: TextStyle(
                        fontSize: 10, fontFamily: 'monospace',
                        color: _p.primary)),
                  ),
                  Expanded(
                    child: Text(patterns[i].$3, style: TextStyle(
                        fontSize: 10, color: _p.muted)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _verificationChecklist() {
    final checks = <String>[
      'ShaderMask with srcIn fills opaque pixels with gradient',
      'ShaderMask with dstIn fades child using gradient opacity',
      'Linear gradient can go horizontal, vertical, or diagonal',
      'Radial gradient creates center-out spotlight/vignette',
      'Sweep gradient creates clock-like angular patterns',
      'Multi-stop gradients allow non-uniform color distribution',
      'Sharp stops (same position) create hard edges',
      'Nested ShaderMasks compound effects inside-out',
      'shaderCallback receives widget bounds as Rect',
      'ShaderMask works on any child widget, not just text',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Verification Checklist', style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14,
              color: Color(0xFF2E7D32))),
          const SizedBox(height: 10),
          for (final c in checks)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(Icons.check_circle,
                      color: Color(0xFF2E7D32), size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(c, style: TextStyle(
                      fontSize: 12, color: _p.onSurface))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _faqSection() {
    final faqs = <(String, String)>[
      ('Why does my gradient text look invisible?',
       'You probably used the wrong blend mode. For gradient text, use '
       'BlendMode.srcIn and make the text color white (fully opaque). '
       'srcIn shows the shader (gradient) only where the child (text) '
       'is opaque.'),
      ('What is the difference between ShaderMask and ColorFiltered?',
       'ShaderMask applies a full shader (gradient, pattern) using a '
       'configurable BlendMode. ColorFiltered applies a simple '
       'ColorFilter (matrix, mode, sRGB gamma) which is more limited '
       'but more efficient for simple color transformations.'),
      ('Does ShaderMask affect performance?',
       'ShaderMask creates a compositing layer (saveLayer internally). '
       'This is relatively expensive. Avoid using it on frequently '
       'animating widgets or in large lists. Cache the result if static.'),
      ('Can I animate the shader?',
       'Yes. Wrap ShaderMask in a StatefulWidget and rebuild with new '
       'gradient parameters. Use an AnimationController to smoothly '
       'transition gradient stops, colors, or the start/end alignment.'),
      ('Why does dstIn with a solid color show nothing?',
       'dstIn shows the child only where the shader is opaque. If the '
       'shader is all opaque (solid white), the child shows fully. '
       'If the shader has transparent areas, those parts of the child '
       'become invisible.'),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4,
            offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.help_outline, color: _p.primary, size: 18),
            const SizedBox(width: 6),
            Text('FAQ', style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 14, color: _p.primary)),
          ]),
          const SizedBox(height: 10),
          for (var i = 0; i < faqs.length; i++) ...[
            Text('Q: ${faqs[i].$1}',
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 12, color: _p.onSurface)),
            const SizedBox(height: 3),
            Text('A: ${faqs[i].$2}',
                style: TextStyle(fontSize: 12,
                    color: _p.onSurface.withValues(alpha: 0.8))),
            if (i < faqs.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _pitfalls() {
    final items = <(String, String, IconData)>[
      ('Performance', 'ShaderMask creates a saveLayer. Avoid in '
          'hot paths (scrolling lists, frequent animations).',
          Icons.speed),
      ('Blend mode mismatch', 'Using srcIn when you want fading, or '
          'dstIn when you want gradient fill. Test both.',
          Icons.swap_horiz),
      ('Transparent child', 'If child has transparent pixels, the '
          'gradient will not fill them with srcIn.',
          Icons.visibility_off),
      ('Shader resolution', 'shaderCallback receives bounds in logical '
          'pixels. For pixel-perfect shaders, consider devicePixelRatio.',
          Icons.photo_size_select_small),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFC62828).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: Color(0xFFC62828).withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.warning_amber, color: Color(0xFFC62828), size: 18),
            const SizedBox(width: 6),
            Text('Common Pitfalls', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14,
                color: Color(0xFFC62828))),
          ]),
          const SizedBox(height: 10),
          for (var i = 0; i < items.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(items[i].$3, color: Color(0xFFC62828), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items[i].$1, style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12,
                          color: _p.onSurface)),
                      Text(items[i].$2, style: TextStyle(
                          fontSize: 11,
                          color: _p.onSurface.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
            if (i < items.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Shared helpers
  // -----------------------------------------------------------------------
  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4, height: 20,
          decoration: BoxDecoration(
            color: _p.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold, color: _p.onSurface)),
      ],
    );
  }

  Widget _instructionBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _p.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 12,
                color: _p.onSurface, height: 1.4)),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Footer
  // -----------------------------------------------------------------------
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: _p.onSurface.withValues(alpha: 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_scenarioTitles[_scenario],
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                  color: _p.muted)),
          Text('Palette: ${_p.name}',
              style: TextStyle(fontSize: 11, color: _p.muted)),
          Text('RenderShaderMask',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace',
                  color: _p.muted)),
        ],
      ),
    );
  }
}

// =========================================================================
// Custom painter — checkerboard for vignette demo background
// =========================================================================
class _CheckerboardPainter extends CustomPainter {
  final Color colorA;
  final Color colorB;
  _CheckerboardPainter(this.colorA, this.colorB);

  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 20.0;
    final paintA = Paint()..color = colorA;
    final paintB = Paint()..color = colorB;
    for (var y = 0.0; y < size.height; y += cellSize) {
      for (var x = 0.0; x < size.width; x += cellSize) {
        final col = (x / cellSize).floor();
        final row = (y / cellSize).floor();
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          (col + row).isEven ? paintA : paintB,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
