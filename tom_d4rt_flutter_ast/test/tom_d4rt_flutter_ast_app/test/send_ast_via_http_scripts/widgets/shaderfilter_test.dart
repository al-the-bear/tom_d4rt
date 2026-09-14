// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroSection(),
              SizedBox(height: 28.0),
              _AnatomySection(),
              SizedBox(height: 28.0),
              _GradientTextGallerySection(),
              SizedBox(height: 28.0),
              _BlendModeComparisonSection(),
              SizedBox(height: 28.0),
              _FadeEdgeSection(),
              SizedBox(height: 28.0),
              _ColorFilterPipelineSection(),
              SizedBox(height: 28.0),
              _BackdropFilterSection(),
              SizedBox(height: 28.0),
              _ImageFilterComposeSection(),
              SizedBox(height: 28.0),
              _PitfallsSection(),
              SizedBox(height: 28.0),
              _CodeBlockSection(),
              SizedBox(height: 28.0),
              _UseCasesSection(),
              SizedBox(height: 28.0),
              _FooterSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION HEADER CARD
// =====================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String index;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        gradient: LinearGradient(
          colors: <Color>[
            accent.withValues(alpha: 0.22),
            const Color(0xFF1A1D27).withValues(alpha: 0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.35),
            blurRadius: 22.0,
            spreadRadius: -4.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 52.0,
            height: 52.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              gradient: LinearGradient(
                colors: <Color>[
                  accent,
                  accent.withValues(alpha: 0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withValues(alpha: 0.6),
                  blurRadius: 16.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Text(
              index,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F1117),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFF2F4FA),
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: const Color(0xFFB4BACB).withValues(alpha: 0.95),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 1 — HERO
// =====================================================================

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(26.0, 30.0, 26.0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFF1B0E2E),
            Color(0xFF120B26),
            Color(0xFF0B1430),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF7873F5).withValues(alpha: 0.55),
          width: 1.4,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFFFF6EC4).withValues(alpha: 0.25),
            blurRadius: 40.0,
            spreadRadius: -8.0,
            offset: const Offset(0.0, 12.0),
          ),
          BoxShadow(
            color: const Color(0xFF7873F5).withValues(alpha: 0.18),
            blurRadius: 60.0,
            spreadRadius: -12.0,
            offset: const Offset(0.0, 18.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFFFF6EC4), Color(0xFF7873F5)],
              ),
            ),
            child: const Text(
              'flutter / widgets / paint',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F1117),
                letterSpacing: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 18.0),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: <Color>[
                  Color(0xFFFF6EC4),
                  Color(0xFFFFB86C),
                  Color(0xFF7873F5),
                  Color(0xFF4FC3F7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: const Text(
              'ShaderMask',
              style: TextStyle(
                fontSize: 64.0,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -2.0,
                height: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Painting with gradients on widgets',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE2E5F1),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'A visual deep-dive into ShaderMask, BackdropFilter, '
            'ColorFiltered, and ImageFilter.compose — the layered paint '
            'primitives that turn ordinary widgets into hero compositions.',
            style: TextStyle(
              fontSize: 14.5,
              color: const Color(0xFFB4BACB).withValues(alpha: 0.95),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22.0),
          Row(
            children: const <Widget>[
              _HeroBadge(
                label: 'shaderCallback',
                color: Color(0xFFFF6EC4),
              ),
              SizedBox(width: 10.0),
              _HeroBadge(
                label: 'BlendMode',
                color: Color(0xFF7873F5),
              ),
              SizedBox(width: 10.0),
              _HeroBadge(
                label: 'ImageFilter',
                color: Color(0xFF4FC3F7),
              ),
              SizedBox(width: 10.0),
              _HeroBadge(
                label: 'ColorMatrix',
                color: Color(0xFFFFB86C),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color.withValues(alpha: 0.14),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.4,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 2 — ANATOMY
// =====================================================================

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '02',
          title: 'Anatomy of a ShaderMask',
          subtitle:
              'A widget that paints its child through a shader, controlled by a callback and a blend mode.',
          accent: Color(0xFFFF6EC4),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 22.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF161A24), Color(0xFF11141C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _AnatomyDiagram(),
              SizedBox(height: 22.0),
              _AnatomyRow(
                label: 'shaderCallback',
                signature: '(Rect bounds) => Shader',
                description:
                    'Receives the bounds of the child and returns a Shader '
                    '(usually built from a Gradient via createShader).',
                accent: Color(0xFFFF6EC4),
              ),
              SizedBox(height: 14.0),
              _AnatomyRow(
                label: 'blendMode',
                signature: 'BlendMode = BlendMode.modulate',
                description:
                    'How the shader is composited with the child. srcIn '
                    'turns the child into a mask filled by the shader.',
                accent: Color(0xFF7873F5),
              ),
              SizedBox(height: 14.0),
              _AnatomyRow(
                label: 'child',
                signature: 'Widget',
                description:
                    'The widget whose pixels are painted under the shader. '
                    'Anything paint-friendly works — Text, Icon, Image.',
                accent: Color(0xFF4FC3F7),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1F1430), Color(0xFF101526)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF7873F5).withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const _DiagramNode(
                label: 'child',
                color: Color(0xFF4FC3F7),
                icon: Icons.image,
              ),
              const Icon(Icons.arrow_forward_rounded,
                  color: Color(0xFF8A91A6), size: 22.0),
              const _DiagramNode(
                label: 'shader',
                color: Color(0xFFFF6EC4),
                icon: Icons.gradient,
              ),
              const Icon(Icons.arrow_forward_rounded,
                  color: Color(0xFF8A91A6), size: 22.0),
              const _DiagramNode(
                label: 'blend',
                color: Color(0xFF7873F5),
                icon: Icons.layers,
              ),
              const Icon(Icons.arrow_forward_rounded,
                  color: Color(0xFF8A91A6), size: 22.0),
              const _DiagramNode(
                label: 'painted',
                color: Color(0xFFFFB86C),
                icon: Icons.check_circle,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xFF0B0F18).withValues(alpha: 0.7),
              border: Border.all(
                color: const Color(0xFF2C313F),
                width: 1.0,
              ),
            ),
            child: const Text(
              'pixel(x, y) = blend(shader(x, y), child(x, y))',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFFB4BACB),
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagramNode extends StatelessWidget {
  const _DiagramNode({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 48.0,
          height: 48.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[
                color,
                color.withValues(alpha: 0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.55),
                blurRadius: 14.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF0F1117), size: 24.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE2E5F1),
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.label,
    required this.signature,
    required this.description,
    required this.accent,
  });

  final String label;
  final String signature;
  final String description;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xFF0F1320).withValues(alpha: 0.8),
        border: Border(
          left: BorderSide(color: accent, width: 3.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: accent,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 10.0),
              Container(
                padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: const Color(0xFF1A1F2E),
                ),
                child: Text(
                  signature,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFFB4BACB),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13.0,
              color: Color(0xFFD2D6E3),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 3 — GRADIENT TEXT GALLERY
// =====================================================================

class _GradientTextGallerySection extends StatelessWidget {
  const _GradientTextGallerySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '03',
          title: 'Gradient Text Gallery',
          subtitle:
              'Six gradients applied to large headings using BlendMode.srcIn.',
          accent: Color(0xFF7873F5),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 26.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF11141C), Color(0xFF161A24)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _gradientTextEntry(
                label: 'linear',
                text: 'AURORA',
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFF00F5A0),
                    Color(0xFF00D9F5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(height: 18.0),
              _gradientTextEntry(
                label: 'radial',
                text: 'NEBULA',
                gradient: const RadialGradient(
                  colors: <Color>[
                    Color(0xFFFFB86C),
                    Color(0xFFFF6EC4),
                    Color(0xFF7873F5),
                  ],
                  center: Alignment.center,
                  radius: 0.9,
                ),
              ),
              const SizedBox(height: 18.0),
              _gradientTextEntry(
                label: 'sweep',
                text: 'PRISM',
                gradient: const SweepGradient(
                  colors: <Color>[
                    Color(0xFFFF6EC4),
                    Color(0xFFFFB86C),
                    Color(0xFF00F5A0),
                    Color(0xFF00D9F5),
                    Color(0xFF7873F5),
                    Color(0xFFFF6EC4),
                  ],
                  center: Alignment.center,
                ),
              ),
              const SizedBox(height: 18.0),
              _gradientTextEntry(
                label: 'rainbow',
                text: 'SPECTRUM',
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFFFF3B30),
                    Color(0xFFFF9500),
                    Color(0xFFFFCC00),
                    Color(0xFF34C759),
                    Color(0xFF007AFF),
                    Color(0xFF5856D6),
                    Color(0xFFAF52DE),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              _gradientTextEntry(
                label: 'sunset',
                text: 'HORIZON',
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFFFF512F),
                    Color(0xFFDD2476),
                    Color(0xFF7873F5),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              const SizedBox(height: 18.0),
              _gradientTextEntry(
                label: 'ice',
                text: 'GLACIER',
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFFE0FBFC),
                    Color(0xFF9DD5E8),
                    Color(0xFF4FC3F7),
                    Color(0xFF1A6F9C),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _gradientTextEntry({
    required String label,
    required String text,
    required Gradient gradient,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 76.0,
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xFF1A1F2E),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFFB4BACB),
              fontFamily: 'monospace',
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: ShaderMask(
            shaderCallback: (Rect bounds) => gradient.createShader(bounds),
            blendMode: BlendMode.srcIn,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.0,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 4 — BLENDMODE COMPARISON
// =====================================================================

class _BlendModeComparisonSection extends StatelessWidget {
  const _BlendModeComparisonSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '04',
          title: 'BlendMode Comparison',
          subtitle:
              'A single icon under a ShaderMask with four different blend modes.',
          accent: Color(0xFF4FC3F7),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF161A24), Color(0xFF11141C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Expanded(
                child: _BlendModeTile(
                  label: 'srcIn',
                  description:
                      'Child becomes a mask; only pixels under the shader are kept.',
                  blendMode: BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: _BlendModeTile(
                  label: 'srcATop',
                  description:
                      'Shader is drawn on top of the child within the child shape.',
                  blendMode: BlendMode.srcATop,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: _BlendModeTile(
                  label: 'modulate',
                  description:
                      'Multiplies shader color with child color — darkens.',
                  blendMode: BlendMode.modulate,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: _BlendModeTile(
                  label: 'dstATop',
                  description:
                      'Child is composited over shader within shader region.',
                  blendMode: BlendMode.dstATop,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BlendModeTile extends StatelessWidget {
  const _BlendModeTile({
    required this.label,
    required this.description,
    required this.blendMode,
  });

  final String label;
  final String description;
  final BlendMode blendMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 14.0, 12.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1F2433), Color(0xFF161A28)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: const Color(0xFF2C313F), width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 88.0,
            height: 88.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xFF0B0F18),
              border: Border.all(
                color: const Color(0xFF2C313F),
                width: 1.0,
              ),
            ),
            child: ShaderMask(
              shaderCallback: (Rect bounds) => const LinearGradient(
                colors: <Color>[
                  Color(0xFFFF6EC4),
                  Color(0xFF7873F5),
                ],
              ).createShader(bounds),
              blendMode: blendMode,
              child: const Icon(
                Icons.star_rounded,
                size: 72.0,
                color: Color(0xFFFFB86C),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: const Color(0xFF4FC3F7).withValues(alpha: 0.18),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF4FC3F7),
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFFB4BACB),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 5 — FADE EDGE
// =====================================================================

class _FadeEdgeSection extends StatelessWidget {
  const _FadeEdgeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '05',
          title: 'Fade-edge ListView',
          subtitle:
              'A horizontal strip that fades into transparency on the right.',
          accent: Color(0xFFFFB86C),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 22.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF11141C), Color(0xFF161A24)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Right-edge fade with BlendMode.dstIn',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE2E5F1),
                ),
              ),
              const SizedBox(height: 10.0),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: <double>[0.0, 0.7, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: SizedBox(
                  height: 88.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _FadeTile(color: Color(0xFFFF6EC4), label: '01'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF7873F5), label: '02'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF4FC3F7), label: '03'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFFFFB86C), label: '04'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF00F5A0), label: '05'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFFFF512F), label: '06'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF7873F5), label: '07'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              const Text(
                'Both-edge fade with stops [0, 0.1, 0.9, 1]',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE2E5F1),
                ),
              ),
              const SizedBox(height: 10.0),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: <double>[0.0, 0.12, 0.88, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: SizedBox(
                  height: 88.0,
                  child: Row(
                    children: <Widget>[
                      _FadeTile(color: Color(0xFFFF6EC4), label: 'A'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF7873F5), label: 'B'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF4FC3F7), label: 'C'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFFFFB86C), label: 'D'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF00F5A0), label: 'E'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFFFF512F), label: 'F'),
                      SizedBox(width: 12.0),
                      _FadeTile(color: Color(0xFF7873F5), label: 'G'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FadeTile extends StatelessWidget {
  const _FadeTile({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.0,
      height: 88.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        gradient: LinearGradient(
          colors: <Color>[
            color,
            color.withValues(alpha: 0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 14.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w900,
          color: Color(0xFF0F1117),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 6 — COLOR FILTER PIPELINE
// =====================================================================

class _ColorFilterPipelineSection extends StatelessWidget {
  const _ColorFilterPipelineSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '06',
          title: 'Color Filter Pipeline',
          subtitle:
              'ColorFiltered + ColorFilter.matrix — per-pixel color transforms via a 4x5 matrix.',
          accent: Color(0xFF00F5A0),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF11141C), Color(0xFF161A24)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'ColorFiltered applies a ColorFilter to every pixel of its '
                'child. Unlike ShaderMask (which uses a shader and blend), '
                'a matrix filter is a deterministic per-pixel multiplication.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Color(0xFFB4BACB),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 18.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _ColorMatrixTile(
                      label: 'grayscale',
                      matrix: const <double>[
                        0.2126, 0.7152, 0.0722, 0.0, 0.0,
                        0.2126, 0.7152, 0.0722, 0.0, 0.0,
                        0.2126, 0.7152, 0.0722, 0.0, 0.0,
                        0.0, 0.0, 0.0, 1.0, 0.0,
                      ],
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFFFF6EC4),
                          Color(0xFFFFB86C),
                          Color(0xFF4FC3F7),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: _ColorMatrixTile(
                      label: 'sepia',
                      matrix: const <double>[
                        0.393, 0.769, 0.189, 0.0, 0.0,
                        0.349, 0.686, 0.168, 0.0, 0.0,
                        0.272, 0.534, 0.131, 0.0, 0.0,
                        0.0, 0.0, 0.0, 1.0, 0.0,
                      ],
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFFFF6EC4),
                          Color(0xFFFFB86C),
                          Color(0xFF4FC3F7),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: _ColorMatrixTile(
                      label: 'invert',
                      matrix: const <double>[
                        -1.0, 0.0, 0.0, 0.0, 255.0,
                        0.0, -1.0, 0.0, 0.0, 255.0,
                        0.0, 0.0, -1.0, 0.0, 255.0,
                        0.0, 0.0, 0.0, 1.0, 0.0,
                      ],
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFFFF6EC4),
                          Color(0xFFFFB86C),
                          Color(0xFF4FC3F7),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: _ColorMatrixTile(
                      label: 'sat-boost',
                      matrix: const <double>[
                        1.5, -0.2, -0.2, 0.0, 0.0,
                        -0.2, 1.5, -0.2, 0.0, 0.0,
                        -0.2, -0.2, 1.5, 0.0, 0.0,
                        0.0, 0.0, 0.0, 1.0, 0.0,
                      ],
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFFFF6EC4),
                          Color(0xFFFFB86C),
                          Color(0xFF4FC3F7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              Container(
                padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFF0B0F18),
                  border: Border.all(
                    color: const Color(0xFF2C313F),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'r\' = m00*r + m01*g + m02*b + m03*a + m04\n'
                  'g\' = m10*r + m11*g + m12*b + m13*a + m14\n'
                  'b\' = m20*r + m21*g + m22*b + m23*a + m24\n'
                  'a\' = m30*r + m31*g + m32*b + m33*a + m34',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFFB4BACB),
                    fontFamily: 'monospace',
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColorMatrixTile extends StatelessWidget {
  const _ColorMatrixTile({
    required this.label,
    required this.matrix,
    required this.gradient,
  });

  final String label;
  final List<double> matrix;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ColorFiltered(
          colorFilter: ColorFilter.matrix(matrix),
          child: Container(
            height: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              gradient: gradient,
            ),
            child: const Center(
              child: Icon(
                Icons.brightness_5_rounded,
                size: 56.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: const Color(0xFF00F5A0).withValues(alpha: 0.15),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF00F5A0),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 7 — BACKDROP FILTER
// =====================================================================

class _BackdropFilterSection extends StatelessWidget {
  const _BackdropFilterSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '07',
          title: 'BackdropFilter — Frosted Glass',
          subtitle:
              'A live ImageFilter.blur applied to whatever is painted behind the child.',
          accent: Color(0xFFE0FBFC),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 22.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF11141C), Color(0xFF161A24)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _FrostedCard(
                sigma: 6.0,
                title: 'Light blur (sigma 6)',
                subtitle: 'Glass card hovering above a colorful base.',
              ),
              SizedBox(height: 18.0),
              _FrostedCard(
                sigma: 18.0,
                title: 'Heavy blur (sigma 18)',
                subtitle:
                    'Deep frosted effect — background is reduced to color fields.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FrostedCard extends StatelessWidget {
  const _FrostedCard({
    required this.sigma,
    required this.title,
    required this.subtitle,
  });

  final double sigma;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: SizedBox(
        height: 180.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFFFF6EC4),
                    Color(0xFFFFB86C),
                    Color(0xFF7873F5),
                    Color(0xFF4FC3F7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned.fill(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30.0,
                    top: 30.0,
                    child: Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFCC00)
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40.0,
                    top: 50.0,
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF34C759)
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120.0,
                    bottom: 20.0,
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFF3B30)
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 280.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(
                      sigmaX: sigma,
                      sigmaY: sigma,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(
                          16.0, 14.0, 16.0, 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white.withValues(alpha: 0.18),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.35),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white.withValues(alpha: 0.9),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 8 — IMAGE FILTER COMPOSE
// =====================================================================

class _ImageFilterComposeSection extends StatelessWidget {
  const _ImageFilterComposeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '08',
          title: 'ImageFilter.compose — Pipelines',
          subtitle:
              'Chain filters: blur → matrix → erode. Each stage is composed as outer(inner(x)).',
          accent: Color(0xFFFFB86C),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF11141C), Color(0xFF161A24)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _ComposeStage(
                index: '1',
                label: 'ImageFilter.blur',
                description:
                    'sigmaX: 6, sigmaY: 6 — gaussian smoothing of input pixels.',
                color: Color(0xFFFF6EC4),
              ),
              _ComposeArrow(),
              _ComposeStage(
                index: '2',
                label: 'ImageFilter.matrix',
                description:
                    'Float64List 4x4 — apply a 2D transform (scale, rotate, skew).',
                color: Color(0xFF7873F5),
              ),
              _ComposeArrow(),
              _ComposeStage(
                index: '3',
                label: 'ImageFilter.erode',
                description:
                    'radiusX, radiusY — shrink bright regions by morphology.',
                color: Color(0xFF4FC3F7),
              ),
              _ComposeArrow(),
              _ComposeStage(
                index: '=',
                label: 'ImageFilter.compose(outer, inner)',
                description:
                    'Final pipeline. Applied in BackdropFilter or ImageFiltered.',
                color: Color(0xFFFFB86C),
              ),
              SizedBox(height: 14.0),
              _ComposeCallout(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ComposeStage extends StatelessWidget {
  const _ComposeStage({
    required this.index,
    required this.label,
    required this.description,
    required this.color,
  });

  final String index;
  final String label;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.15),
            const Color(0xFF1A1F2E),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(
          color: color.withValues(alpha: 0.55),
          width: 1.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Text(
              index,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F1117),
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: color,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFFB4BACB),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComposeArrow extends StatelessWidget {
  const _ComposeArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
      child: Center(
        child: Container(
          width: 26.0,
          height: 26.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1A1F2E),
            border: Border.all(
              color: const Color(0xFF2C313F),
              width: 1.0,
            ),
          ),
          child: const Icon(
            Icons.arrow_downward_rounded,
            size: 16.0,
            color: Color(0xFF8A91A6),
          ),
        ),
      ),
    );
  }
}

class _ComposeCallout extends StatelessWidget {
  const _ComposeCallout();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF0B0F18),
        border: Border.all(
          color: const Color(0xFFFFB86C).withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: const Text(
        'final pipeline = ImageFilter.compose(\n'
        '  outer: ImageFilter.erode(radiusX: 1, radiusY: 1),\n'
        '  inner: ImageFilter.compose(\n'
        '    outer: ImageFilter.matrix(transform4),\n'
        '    inner: ImageFilter.blur(sigmaX: 6, sigmaY: 6),\n'
        '  ),\n'
        ');',
        style: TextStyle(
          fontSize: 12.0,
          color: Color(0xFFFFB86C),
          fontFamily: 'monospace',
          height: 1.5,
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 9 — PITFALLS
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '09',
          title: 'Pitfalls & Gotchas',
          subtitle:
              'Five subtle issues that bite when working with shaders and filters.',
          accent: Color(0xFFFF512F),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF1E1218), Color(0xFF120D14)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFFFF512F).withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _PitfallRow(
                index: '1',
                title: 'saveLayer cost',
                description:
                    'ShaderMask, ColorFiltered and BackdropFilter each force '
                    'a saveLayer in the rasterizer. Layers allocate offscreen '
                    'buffers and burn fillrate; budget them per frame.',
              ),
              SizedBox(height: 12.0),
              _PitfallRow(
                index: '2',
                title: 'srcIn vs srcOver semantics',
                description:
                    'srcIn keeps only pixels where the child is opaque, '
                    'masked by the shader. srcOver draws the shader on top, '
                    'which often looks wrong for gradient text.',
              ),
              SizedBox(height: 12.0),
              _PitfallRow(
                index: '3',
                title: 'Anti-aliasing edges',
                description:
                    'A heavy blur near a sharp edge looks blocky if the '
                    'filter quality is set to FilterQuality.none. Prefer '
                    'medium or high quality for visible blurs.',
              ),
              SizedBox(height: 12.0),
              _PitfallRow(
                index: '4',
                title: 'Gradient bounds vs child bounds',
                description:
                    'shaderCallback receives the bounds of the rendered '
                    'child, not the parent. Off-by-one bugs appear when a '
                    'gradient is centered on the wrong rectangle.',
              ),
              SizedBox(height: 12.0),
              _PitfallRow(
                index: '5',
                title: 'BackdropFilter performance traps',
                description:
                    'BackdropFilter samples every pixel behind it. On low-end '
                    'devices, a full-screen frosted glass at 60 FPS can drop '
                    'frames. Cache static blurs into images when possible.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PitfallRow extends StatelessWidget {
  const _PitfallRow({
    required this.index,
    required this.title,
    required this.description,
  });

  final String index;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
            ),
          ),
          child: Text(
            index,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFFB4A8),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFFD2D6E3),
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 10 — CODE BLOCK
// =====================================================================

class _CodeBlockSection extends StatelessWidget {
  const _CodeBlockSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '10',
          title: 'Reference Snippet',
          subtitle:
              'A compact gradient-text recipe — copy-paste ready.',
          accent: Color(0xFF4FC3F7),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF0B1018), Color(0xFF080C14)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFF1F2A3D),
              width: 1.0,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFF4FC3F7).withValues(alpha: 0.18),
                blurRadius: 20.0,
                spreadRadius: -4.0,
                offset: const Offset(0.0, 8.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFF6157),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFBD2E),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF28C840),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  const Text(
                    'gradient_text.dart',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF8A91A6),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const _CodeLine(
                tokens: <_Token>[
                  _Token('ShaderMask', _TokenKind.keyword),
                  _Token('(', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                indent: 2,
                tokens: <_Token>[
                  _Token('shaderCallback', _TokenKind.field),
                  _Token(': ', _TokenKind.punct),
                  _Token('(', _TokenKind.punct),
                  _Token('Rect', _TokenKind.type),
                  _Token(' bounds', _TokenKind.ident),
                  _Token(') => ', _TokenKind.punct),
                  _Token('const', _TokenKind.keyword),
                  _Token(' ', _TokenKind.ident),
                  _Token('LinearGradient', _TokenKind.type),
                  _Token('(', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                indent: 4,
                tokens: <_Token>[
                  _Token('colors', _TokenKind.field),
                  _Token(': [', _TokenKind.punct),
                  _Token('Color', _TokenKind.type),
                  _Token('(', _TokenKind.punct),
                  _Token('0xFFFF6EC4', _TokenKind.number),
                  _Token('), ', _TokenKind.punct),
                  _Token('Color', _TokenKind.type),
                  _Token('(', _TokenKind.punct),
                  _Token('0xFF7873F5', _TokenKind.number),
                  _Token(')],', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                indent: 2,
                tokens: <_Token>[
                  _Token(').createShader(bounds),', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                indent: 2,
                tokens: <_Token>[
                  _Token('blendMode', _TokenKind.field),
                  _Token(': ', _TokenKind.punct),
                  _Token('BlendMode', _TokenKind.type),
                  _Token('.srcIn,', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                indent: 2,
                tokens: <_Token>[
                  _Token('child', _TokenKind.field),
                  _Token(': ', _TokenKind.punct),
                  _Token('const', _TokenKind.keyword),
                  _Token(' ', _TokenKind.ident),
                  _Token('Text', _TokenKind.type),
                  _Token('(', _TokenKind.punct),
                  _Token("'Glow'", _TokenKind.string),
                  _Token(',', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                indent: 4,
                tokens: <_Token>[
                  _Token('style', _TokenKind.field),
                  _Token(': ', _TokenKind.punct),
                  _Token('TextStyle', _TokenKind.type),
                  _Token('(fontSize: ', _TokenKind.punct),
                  _Token('64', _TokenKind.number),
                  _Token(', fontWeight: ', _TokenKind.punct),
                  _Token('FontWeight', _TokenKind.type),
                  _Token('.w900),', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                indent: 2,
                tokens: <_Token>[
                  _Token('),', _TokenKind.punct),
                ],
              ),
              const _CodeLine(
                tokens: <_Token>[
                  _Token(')', _TokenKind.punct),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _TokenKind { keyword, type, field, ident, string, number, punct, comment }

class _Token {
  const _Token(this.text, this.kind);
  final String text;
  final _TokenKind kind;
}

class _CodeLine extends StatelessWidget {
  const _CodeLine({this.indent = 0, required this.tokens});

  final int indent;
  final List<_Token> tokens;

  Color _color(_TokenKind kind) {
    switch (kind) {
      case _TokenKind.keyword:
        return const Color(0xFFFF6EC4);
      case _TokenKind.type:
        return const Color(0xFF4FC3F7);
      case _TokenKind.field:
        return const Color(0xFF00F5A0);
      case _TokenKind.string:
        return const Color(0xFFFFB86C);
      case _TokenKind.number:
        return const Color(0xFFFFCC00);
      case _TokenKind.comment:
        return const Color(0xFF6E7691);
      case _TokenKind.ident:
        return const Color(0xFFE2E5F1);
      case _TokenKind.punct:
        return const Color(0xFFB4BACB);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(indent * 8.0, 1.0, 0.0, 1.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12.5,
            fontFamily: 'monospace',
            height: 1.55,
          ),
          children: <InlineSpan>[
            for (final _Token t in tokens)
              TextSpan(
                text: t.text,
                style: TextStyle(color: _color(t.kind)),
              ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 11 — USE CASES
// =====================================================================

class _UseCasesSection extends StatelessWidget {
  const _UseCasesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '11',
          title: 'Real-World Use Cases',
          subtitle:
              'Four production patterns that lean on ShaderMask and friends.',
          accent: Color(0xFF00F5A0),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: const <Widget>[
            Expanded(
              child: _UseCaseCard(
                icon: Icons.title_rounded,
                title: 'Heroic titles',
                body:
                    'Use ShaderMask + srcIn to fill big display text with a brand gradient.',
                accent: Color(0xFFFF6EC4),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _UseCaseCard(
                icon: Icons.view_carousel_rounded,
                title: 'Edge-fade lists',
                body:
                    'Mask horizontal carousels with a transparent fall-off so scrolling feels infinite.',
                accent: Color(0xFFFFB86C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: const <Widget>[
            Expanded(
              child: _UseCaseCard(
                icon: Icons.hourglass_top_rounded,
                title: 'Ghost loaders',
                body:
                    'Shimmer skeletons are ShaderMask animations across a placeholder block.',
                accent: Color(0xFF7873F5),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _UseCaseCard(
                icon: Icons.border_outer_rounded,
                title: 'Gradient outlines',
                body:
                    'Apply a gradient to a stroked path — for cards, avatars, status rings.',
                accent: Color(0xFF4FC3F7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: LinearGradient(
          colors: <Color>[
            accent.withValues(alpha: 0.16),
            const Color(0xFF11141C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: accent.withValues(alpha: 0.45),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: <Color>[
                  accent,
                  accent.withValues(alpha: 0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              icon,
              size: 22.0,
              color: const Color(0xFF0F1117),
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFFD2D6E3),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 12 — FOOTER
// =====================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF11141C), Color(0xFF161A24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF2C313F),
          width: 1.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38.0,
            height: 38.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: <Color>[Color(0xFFFF6EC4), Color(0xFF7873F5)],
              ),
            ),
            child: const Icon(
              Icons.gradient_rounded,
              size: 20.0,
              color: Color(0xFF0F1117),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'ShaderMask Visual Deep Demo',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE2E5F1),
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  'Hand-authored static snapshot — flutter widgets + dart:ui',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF8A91A6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xFF1A1F2E),
              border: Border.all(
                color: const Color(0xFF2C313F),
                width: 1.0,
              ),
            ),
            child: const Text(
              'v1.0 · poster',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFB4BACB),
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
