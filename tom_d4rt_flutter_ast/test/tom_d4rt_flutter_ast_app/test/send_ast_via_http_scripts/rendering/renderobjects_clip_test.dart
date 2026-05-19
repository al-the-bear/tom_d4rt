// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Custom path clippers used by the ClipPath demo section.
// These are pure-geometry CustomClipper<Path> subclasses with no animation.
// ---------------------------------------------------------------------------

class _StarClipper extends CustomClipper<Path> {
  const _StarClipper({this.points = 5});

  final int points;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double cx = size.width / 2.0;
    final double cy = size.height / 2.0;
    final double outerR = (size.width < size.height ? size.width : size.height) / 2.0;
    final double innerR = outerR * 0.45;
    final int total = points * 2;
    for (int i = 0; i < total; i++) {
      final double r = (i % 2 == 0) ? outerR : innerR;
      final double angle = (i * 3.141592653589793) / points - 3.141592653589793 / 2.0;
      final double x = cx + r * _cosFor(angle);
      final double y = cy + r * _sinFor(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  static double _cosFor(double a) {
    // Use Path-friendly maths: avoid import dart:math by using polynomial approx?
    // Simpler: rely on the runtime's cos via math library would be ideal, but
    // we keep the file free of extra imports. So we re-implement using the
    // identity that cos(a) == sin(a + pi/2). We'll compute via Taylor series
    // for stability in the small range we use.
    return _taylorCos(a);
  }

  static double _sinFor(double a) {
    return _taylorSin(a);
  }

  static double _taylorSin(double a) {
    // Reduce a to [-pi, pi].
    const double pi = 3.141592653589793;
    double x = a;
    while (x > pi) {
      x -= 2.0 * pi;
    }
    while (x < -pi) {
      x += 2.0 * pi;
    }
    final double x2 = x * x;
    final double x3 = x2 * x;
    final double x5 = x3 * x2;
    final double x7 = x5 * x2;
    final double x9 = x7 * x2;
    return x - x3 / 6.0 + x5 / 120.0 - x7 / 5040.0 + x9 / 362880.0;
  }

  static double _taylorCos(double a) {
    const double pi = 3.141592653589793;
    double x = a;
    while (x > pi) {
      x -= 2.0 * pi;
    }
    while (x < -pi) {
      x += 2.0 * pi;
    }
    final double x2 = x * x;
    final double x4 = x2 * x2;
    final double x6 = x4 * x2;
    final double x8 = x6 * x2;
    return 1.0 - x2 / 2.0 + x4 / 24.0 - x6 / 720.0 + x8 / 40320.0;
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) => oldClipper.points != points;
}

class _HexagonClipper extends CustomClipper<Path> {
  const _HexagonClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    final double quarterW = w / 4.0;
    path.moveTo(quarterW, 0.0);
    path.lineTo(w - quarterW, 0.0);
    path.lineTo(w, h / 2.0);
    path.lineTo(w - quarterW, h);
    path.lineTo(quarterW, h);
    path.lineTo(0.0, h / 2.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _HexagonClipper oldClipper) => false;
}

class _HeartClipper extends CustomClipper<Path> {
  const _HeartClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w / 2.0, h * 0.95);
    path.cubicTo(
      -w * 0.2, h * 0.55,
      w * 0.15, -h * 0.1,
      w / 2.0, h * 0.25,
    );
    path.cubicTo(
      w * 0.85, -h * 0.1,
      w * 1.2, h * 0.55,
      w / 2.0, h * 0.95,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _HeartClipper oldClipper) => false;
}

class _ChevronClipper extends CustomClipper<Path> {
  const _ChevronClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(0.0, 0.0);
    path.lineTo(w * 0.8, 0.0);
    path.lineTo(w, h / 2.0);
    path.lineTo(w * 0.8, h);
    path.lineTo(0.0, h);
    path.lineTo(w * 0.2, h / 2.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _ChevronClipper oldClipper) => false;
}

// ---------------------------------------------------------------------------
// Top-level palette / typography helpers (const-only).
// ---------------------------------------------------------------------------

class _Palette {
  static const Color background = Color(0xFFEAECEF);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color ink900 = Color(0xFF0D1117);
  static const Color ink800 = Color(0xFF1F2933);
  static const Color ink700 = Color(0xFF323F4B);
  static const Color ink600 = Color(0xFF52606D);
  static const Color ink500 = Color(0xFF7B8794);
  static const Color ink400 = Color(0xFF9AA5B1);
  static const Color ink300 = Color(0xFFCBD2D9);
  static const Color ink200 = Color(0xFFE4E7EB);
  static const Color ink100 = Color(0xFFF5F7FA);
  static const Color accentBlue = Color(0xFF1E88E5);
  static const Color accentTeal = Color(0xFF14B8A6);
  static const Color accentViolet = Color(0xFF7C3AED);
  static const Color accentPink = Color(0xFFE91E63);
  static const Color accentOrange = Color(0xFFFB923C);
  static const Color accentYellow = Color(0xFFFACC15);
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color codeBg = Color(0xFF0F172A);
  static const Color codeFg = Color(0xFFE2E8F0);
  static const Color codeKeyword = Color(0xFFF472B6);
  static const Color codeType = Color(0xFF38BDF8);
  static const Color codeString = Color(0xFFFBBF24);
  static const Color codeComment = Color(0xFF64748B);
}

// ---------------------------------------------------------------------------
// Build entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFEAECEF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(children: const <Widget>[
            _HeroCard(),
            SizedBox(height: 24),
            _AnatomyCard(),
            SizedBox(height: 24),
            _ClipRectSection(),
            SizedBox(height: 24),
            _ClipRRectSection(),
            SizedBox(height: 24),
            _ClipOvalSection(),
            SizedBox(height: 24),
            _ClipPathSection(),
            SizedBox(height: 24),
            _ClipBehaviorTableSection(),
            SizedBox(height: 24),
            _CompositingLayersSection(),
            SizedBox(height: 24),
            _HitTestingSection(),
            SizedBox(height: 24),
            _PitfallsSection(),
            SizedBox(height: 24),
            _CodeUsageSection(),
            SizedBox(height: 24),
            _FooterCard(),
          ]),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared building blocks.
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;
  EdgeInsets get padding => const EdgeInsets.all(20);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: _Palette.cardSurface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _Palette.ink200, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF0D1117).withValues(alpha: 0.06),
            blurRadius: 18.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.tagColor,
    required this.icon,
  });

  final String tag;
  final String title;
  final String subtitle;
  final Color tagColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            tagColor.withValues(alpha: 0.12),
            tagColor.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: tagColor.withValues(alpha: 0.30), width: 1.0),
      ),
      child: Row(children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tagColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: tagColor.withValues(alpha: 0.35),
                blurRadius: 12.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFFFFFFFF), size: 24.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: tagColor.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ]),
              const SizedBox(height: 6.0),
              Text(
                title,
                style: const TextStyle(
                  color: _Palette.ink900,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _Palette.ink600,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _Palette.ink600,
        fontSize: 12.0,
        height: 1.45,
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  const _LabelChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 10.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Hero card.
// ---------------------------------------------------------------------------

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 28, 26, 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0F172A),
            Color(0xFF1E293B),
            Color(0xFF312E81),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF312E81),
            blurRadius: 32.0,
            offset: Offset(0.0, 14.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E88E5).withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(
                  color: const Color(0xFF1E88E5).withValues(alpha: 0.55),
                  width: 1.0,
                ),
              ),
              child: const Text(
                'RENDERING · CLIP FAMILY',
                style: TextStyle(
                  color: Color(0xFF93C5FD),
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            const Text(
              'static visual snapshot',
              style: TextStyle(
                color: Color(0xFFCBD5F5),
                fontSize: 11.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
          const SizedBox(height: 22.0),
          const Text(
            'Clip RenderObjects',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'RenderClipRect · RenderClipRRect · RenderClipOval · RenderClipPath',
            style: TextStyle(
              color: Color(0xFFA5B4FC),
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 18.0),
          const Text(
            'Each clip is a RenderProxyBox that masks its child to a shape. '
            'They differ in geometry (axis-aligned rectangle, rounded rectangle, '
            'oval, or arbitrary Path) and in clipBehavior — the trade-off knob '
            'between speed and quality of the edge.',
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22.0),
          Row(children: <Widget>[
            _HeroStat(label: 'shape kinds', value: '4'),
            SizedBox(width: 12.0),
            _HeroStat(label: 'clip modes', value: '4'),
            SizedBox(width: 12.0),
            _HeroStat(label: 'extends', value: 'RenderProxyBox'),
          ]),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.10),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 9.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFFF8FAFC),
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Anatomy card.
// ---------------------------------------------------------------------------

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'ANATOMY',
            title: 'Pipeline of a clip RenderObject',
            subtitle: 'Parent → ClipLayer → child paint, gated by clipBehavior.',
            tagColor: _Palette.accentBlue,
            icon: Icons.account_tree_outlined,
          ),
          const SizedBox(height: 18.0),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFF5F7FA), Color(0xFFE4E7EB)],
              ),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: _Palette.ink200, width: 1.0),
            ),
            child: Column(children: const <Widget>[
              _AnatomyNode(
                label: 'RenderObject parent',
                detail: 'invokes child.paint(context, offset)',
                color: _Palette.ink700,
                icon: Icons.crop_free,
              ),
              _AnatomyArrow(),
              _AnatomyNode(
                label: 'pushClipRect / pushClipRRect / pushClipPath',
                detail: 'PaintingContext pushes a ClipLayer onto the layer tree',
                color: _Palette.accentViolet,
                icon: Icons.layers_outlined,
              ),
              _AnatomyArrow(),
              _AnatomyNode(
                label: 'Clip.* mode dispatch',
                detail: 'none → skip · hardEdge → clipRect · antiAlias → clipRect(AA)',
                color: _Palette.accentOrange,
                icon: Icons.tune,
              ),
              _AnatomyArrow(),
              _AnatomyNode(
                label: 'child.paint(...)',
                detail: 'masked output composited under the active clip',
                color: _Palette.accentTeal,
                icon: Icons.brush_outlined,
              ),
            ]),
          ),
          const SizedBox(height: 16.0),
          const _Caption(
            text:
                'All four clip RenderObjects extend RenderProxyBox: they have exactly one child, '
                'they delegate layout to that child, and they intercept paint to push a clip layer.',
          ),
        ],
      ),
    );
  }
}

class _AnatomyNode extends StatelessWidget {
  const _AnatomyNode({
    required this.label,
    required this.detail,
    required this.color,
    required this.icon,
  });

  final String label;
  final String detail;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.10),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Row(children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, size: 20.0, color: color),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                detail,
                style: const TextStyle(
                  color: _Palette.ink600,
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _AnatomyArrow extends StatelessWidget {
  const _AnatomyArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(children: <Widget>[
        const SizedBox(width: 16.0),
        Container(width: 2.0, height: 20.0, color: _Palette.ink300),
        const SizedBox(width: 6.0),
        const Icon(Icons.arrow_downward, size: 14.0, color: _Palette.ink400),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. ClipRect section.
// ---------------------------------------------------------------------------

class _ClipRectSection extends StatelessWidget {
  const _ClipRectSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'RENDERCLIPRECT',
            title: 'Rectangular masking',
            subtitle: 'Anything outside the box bounds is discarded before paint.',
            tagColor: _Palette.accentTeal,
            icon: Icons.crop_square,
          ),
          const SizedBox(height: 18.0),
          Row(children: const <Widget>[
            _ClipRectDemo(
              size: 120.0,
              color: Color(0xFF14B8A6),
              shiftX: -30.0,
              shiftY: -20.0,
              label: 'overflow NW',
            ),
            SizedBox(width: 12.0),
            _ClipRectDemo(
              size: 120.0,
              color: Color(0xFF1E88E5),
              shiftX: 25.0,
              shiftY: 0.0,
              label: 'overflow E',
            ),
            SizedBox(width: 12.0),
            _ClipRectDemo(
              size: 120.0,
              color: Color(0xFF7C3AED),
              shiftX: 0.0,
              shiftY: 30.0,
              label: 'overflow S',
            ),
          ]),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: _Palette.ink100,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: _Palette.ink200, width: 1.0),
            ),
            child: Row(children: const <Widget>[
              Icon(Icons.info_outline, size: 18.0, color: _Palette.accentTeal),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'ClipRect uses the child\'s paintBounds as the clip rectangle unless a clipper is supplied. '
                  'It is the cheapest of the family — no path construction, just an aligned rect.',
                  style: TextStyle(
                    color: _Palette.ink700,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ClipRectDemo extends StatelessWidget {
  const _ClipRectDemo({
    required this.size,
    required this.color,
    required this.shiftX,
    required this.shiftY,
    required this.label,
  });

  final double size;
  final Color color;
  final double shiftX;
  final double shiftY;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: <Widget>[
        ClipRect(
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: _Palette.ink100,
              border: Border.all(color: _Palette.ink300, width: 1.0),
            ),
            child: Stack(clipBehavior: Clip.none, children: <Widget>[
              Positioned(
                left: shiftX,
                top: shiftY,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        color,
                        color.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.crop_square,
                      color: Color(0xFFFFFFFF), size: 28.0),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            color: _Palette.ink700,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. ClipRRect section.
// ---------------------------------------------------------------------------

class _ClipRRectSection extends StatelessWidget {
  const _ClipRRectSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'RENDERCLIPRRECT',
            title: 'Rounded rectangle masking',
            subtitle: 'Borrow the curve table from ClipRect; anti-alias the corners.',
            tagColor: _Palette.accentViolet,
            icon: Icons.rounded_corner,
          ),
          const SizedBox(height: 18.0),
          Row(children: const <Widget>[
            _ClipRRectTile(radius: 4.0, label: 'r = 4'),
            SizedBox(width: 10.0),
            _ClipRRectTile(radius: 12.0, label: 'r = 12'),
            SizedBox(width: 10.0),
            _ClipRRectTile(radius: 24.0, label: 'r = 24'),
            SizedBox(width: 10.0),
            _ClipRRectTile(radius: 60.0, label: 'pill'),
          ]),
          const SizedBox(height: 18.0),
          const Text(
            'clipBehavior comparison',
            style: TextStyle(
              color: _Palette.ink800,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(children: const <Widget>[
            _BehaviorCard(
              title: 'hardEdge',
              detail: 'aliased pixels along curve. Cheapest. Looks "jaggy".',
              color: _Palette.accentOrange,
              behavior: Clip.hardEdge,
            ),
            SizedBox(width: 10.0),
            _BehaviorCard(
              title: 'antiAlias',
              detail: 'smooth curves via coverage. Default for ClipRRect.',
              color: _Palette.accentBlue,
              behavior: Clip.antiAlias,
            ),
            SizedBox(width: 10.0),
            _BehaviorCard(
              title: 'antiAliasWithSaveLayer',
              detail: 'extra offscreen buffer. Only when blending requires it.',
              color: _Palette.accentPink,
              behavior: Clip.antiAliasWithSaveLayer,
            ),
          ]),
          const SizedBox(height: 14.0),
          const _Caption(
            text:
                'Asymmetric corners are first-class — BorderRadius.only(topLeft: 8, topRight: 16, '
                'bottomLeft: 4, bottomRight: 24) passes straight through to the RRect geometry.',
          ),
        ],
      ),
    );
  }
}

class _ClipRRectTile extends StatelessWidget {
  const _ClipRRectTile({required this.radius, required this.label});

  final double radius;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 90.0,
            height: 90.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFF7C3AED),
                  Color(0xFFE91E63),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              radius.toStringAsFixed(0),
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            color: _Palette.ink700,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}

class _BehaviorCard extends StatelessWidget {
  const _BehaviorCard({
    required this.title,
    required this.detail,
    required this.color,
    required this.behavior,
  });

  final String title;
  final String detail;
  final Color color;
  final Clip behavior;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              color.withValues(alpha: 0.15),
              color.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.40), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              _LabelChip(label: title, color: color),
              const SizedBox(width: 6.0),
              Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ]),
            const SizedBox(height: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              clipBehavior: behavior,
              child: Container(
                height: 56.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      color,
                      color.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              detail,
              style: const TextStyle(
                color: _Palette.ink700,
                fontSize: 11.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. ClipOval section.
// ---------------------------------------------------------------------------

class _ClipOvalSection extends StatelessWidget {
  const _ClipOvalSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'RENDERCLIPOVAL',
            title: 'Elliptical masking',
            subtitle: 'Inscribed ellipse of the child\'s paintBounds; circle when square.',
            tagColor: _Palette.accentPink,
            icon: Icons.circle_outlined,
          ),
          const SizedBox(height: 18.0),
          Row(children: const <Widget>[
            _ClipOvalTile(width: 70.0, height: 70.0, label: '1 : 1'),
            SizedBox(width: 8.0),
            _ClipOvalTile(width: 80.0, height: 70.0, label: '8 : 7'),
            SizedBox(width: 8.0),
            _ClipOvalTile(width: 90.0, height: 60.0, label: '3 : 2'),
            SizedBox(width: 8.0),
            _ClipOvalTile(width: 100.0, height: 55.0, label: '2 : 1'),
            SizedBox(width: 8.0),
            _ClipOvalTile(width: 110.0, height: 45.0, label: '5 : 2'),
          ]),
          const SizedBox(height: 18.0),
          const Text(
            'Avatar use-case',
            style: TextStyle(
              color: _Palette.ink800,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(children: const <Widget>[
            _AvatarPreview(color: Color(0xFF1E88E5), letter: 'A'),
            SizedBox(width: 10.0),
            _AvatarPreview(color: Color(0xFF14B8A6), letter: 'B'),
            SizedBox(width: 10.0),
            _AvatarPreview(color: Color(0xFFFB923C), letter: 'C'),
            SizedBox(width: 10.0),
            _AvatarPreview(color: Color(0xFF7C3AED), letter: 'D'),
            SizedBox(width: 10.0),
            _AvatarPreview(color: Color(0xFFEF4444), letter: 'E'),
          ]),
          const SizedBox(height: 14.0),
          const _Caption(
            text:
                'ClipOval matches the rect axes: a 100x60 child becomes a 100x60 ellipse. '
                'For perfect circles, ensure your child has a 1:1 aspect ratio.',
          ),
        ],
      ),
    );
  }
}

class _ClipOvalTile extends StatelessWidget {
  const _ClipOvalTile({
    required this.width,
    required this.height,
    required this.label,
  });

  final double width;
  final double height;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: <Widget>[
        ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFE91E63),
                  Color(0xFFFB923C),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: _Palette.ink700,
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}

class _AvatarPreview extends StatelessWidget {
  const _AvatarPreview({required this.color, required this.letter});

  final Color color;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: <Widget>[
        ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 64.0,
            height: 64.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  color,
                  color.withValues(alpha: 0.55),
                ],
              ),
            ),
            child: Text(
              letter,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 26.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'user_$letter',
          style: const TextStyle(
            color: _Palette.ink600,
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. ClipPath section.
// ---------------------------------------------------------------------------

class _ClipPathSection extends StatelessWidget {
  const _ClipPathSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'RENDERCLIPPATH',
            title: 'Arbitrary Path masking',
            subtitle: 'You supply a CustomClipper<Path>; the engine pushes a ClipPathLayer.',
            tagColor: _Palette.accentOrange,
            icon: Icons.format_shapes,
          ),
          const SizedBox(height: 18.0),
          Row(children: const <Widget>[
            _ClipPathTile(
              clipper: _StarClipper(points: 5),
              gradient: <Color>[Color(0xFFFACC15), Color(0xFFFB923C)],
              label: '5-point star',
            ),
            SizedBox(width: 12.0),
            _ClipPathTile(
              clipper: _HeartClipper(),
              gradient: <Color>[Color(0xFFE91E63), Color(0xFFEF4444)],
              label: 'heart',
            ),
            SizedBox(width: 12.0),
            _ClipPathTile(
              clipper: _HexagonClipper(),
              gradient: <Color>[Color(0xFF14B8A6), Color(0xFF1E88E5)],
              label: 'hexagon',
            ),
          ]),
          const SizedBox(height: 16.0),
          Row(children: const <Widget>[
            _ClipPathTile(
              clipper: _ChevronClipper(),
              gradient: <Color>[Color(0xFF7C3AED), Color(0xFFE91E63)],
              label: 'chevron',
            ),
            SizedBox(width: 12.0),
            _ClipPathTile(
              clipper: _StarClipper(points: 7),
              gradient: <Color>[Color(0xFF1E88E5), Color(0xFF7C3AED)],
              label: '7-point star',
            ),
            SizedBox(width: 12.0),
            _ClipPathTile(
              clipper: _StarClipper(points: 12),
              gradient: <Color>[Color(0xFF22C55E), Color(0xFF14B8A6)],
              label: '12-point gear',
            ),
          ]),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFFFFBEB),
                  Color(0xFFFEF3C7),
                ],
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0xFFFACC15).withValues(alpha: 0.45),
                width: 1.0,
              ),
            ),
            child: Row(children: const <Widget>[
              Icon(Icons.warning_amber_rounded,
                  color: Color(0xFFD97706), size: 20.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'ClipPath rebuilds its Path whenever shouldReclip returns true. '
                  'Cache the clipper instance via const where possible; avoid creating new clippers per build.',
                  style: TextStyle(
                    color: Color(0xFF92400E),
                    fontSize: 12.5,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ClipPathTile extends StatelessWidget {
  const _ClipPathTile({
    required this.clipper,
    required this.gradient,
    required this.label,
  });

  final CustomClipper<Path> clipper;
  final List<Color> gradient;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: <Widget>[
        ClipPath(
          clipper: clipper,
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 96.0,
            height: 96.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            color: _Palette.ink700,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// 7. clipBehavior comparison table.
// ---------------------------------------------------------------------------

class _ClipBehaviorTableSection extends StatelessWidget {
  const _ClipBehaviorTableSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'CLIPBEHAVIOR',
            title: 'Performance table',
            subtitle: 'Five properties × four modes; pick the cheapest that still looks right.',
            tagColor: _Palette.accentBlue,
            icon: Icons.table_chart_outlined,
          ),
          const SizedBox(height: 18.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: _Palette.ink200, width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(children: const <Widget>[
              _TableHeaderRow(),
              _TableDivider(),
              _TableRow(
                label: 'cost',
                values: <String>['none', 'low', 'medium', 'high'],
                colors: <Color>[
                  _Palette.accentGreen,
                  _Palette.accentGreen,
                  _Palette.accentYellow,
                  _Palette.accentRed,
                ],
              ),
              _TableDivider(),
              _TableRow(
                label: 'edge AA',
                values: <String>['—', 'no', 'yes', 'yes'],
                colors: <Color>[
                  _Palette.ink400,
                  _Palette.accentRed,
                  _Palette.accentGreen,
                  _Palette.accentGreen,
                ],
              ),
              _TableDivider(),
              _TableRow(
                label: 'extra layer',
                values: <String>['no', 'no', 'no', 'yes'],
                colors: <Color>[
                  _Palette.accentGreen,
                  _Palette.accentGreen,
                  _Palette.accentGreen,
                  _Palette.accentRed,
                ],
              ),
              _TableDivider(),
              _TableRow(
                label: 'saveLayer',
                values: <String>['no', 'no', 'no', 'yes'],
                colors: <Color>[
                  _Palette.accentGreen,
                  _Palette.accentGreen,
                  _Palette.accentGreen,
                  _Palette.accentRed,
                ],
              ),
              _TableDivider(),
              _TableRow(
                label: 'typical use',
                values: <String>[
                  'debug only',
                  'tight rects',
                  'rounded',
                  'blend modes',
                ],
                colors: <Color>[
                  _Palette.ink500,
                  _Palette.accentBlue,
                  _Palette.accentTeal,
                  _Palette.accentViolet,
                ],
              ),
            ]),
          ),
          const SizedBox(height: 14.0),
          const _Caption(
            text:
                'Clip.none short-circuits the entire push: no layer, no clip rect, no work. '
                'It exists mainly so widgets like Stack can opt out of clipping their painted children.',
          ),
        ],
      ),
    );
  }
}

class _TableHeaderRow extends StatelessWidget {
  const _TableHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFF5F7FA),
            Color(0xFFE4E7EB),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(children: const <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(
            'PROPERTY',
            style: TextStyle(
              color: _Palette.ink700,
              fontSize: 10.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        _TableHeaderCell(label: 'none'),
        _TableHeaderCell(label: 'hardEdge'),
        _TableHeaderCell(label: 'antiAlias'),
        _TableHeaderCell(label: 'AA+save'),
      ]),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: _Palette.ink700,
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _TableDivider extends StatelessWidget {
  const _TableDivider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1.0, color: _Palette.ink200);
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.label,
    required this.values,
    required this.colors,
  });

  final String label;
  final List<String> values;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(
            label,
            style: const TextStyle(
              color: _Palette.ink800,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _TableValueCell(value: values[0], color: colors[0]),
        _TableValueCell(value: values[1], color: colors[1]),
        _TableValueCell(value: values[2], color: colors[2]),
        _TableValueCell(value: values[3], color: colors[3]),
      ]),
    );
  }
}

class _TableValueCell extends StatelessWidget {
  const _TableValueCell({required this.value, required this.color});

  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.40), width: 1.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. Compositing layers section.
// ---------------------------------------------------------------------------

class _CompositingLayersSection extends StatelessWidget {
  const _CompositingLayersSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'COMPOSITING',
            title: 'Layers added by a clip',
            subtitle: 'Most clips push a single ClipLayer. saveLayer adds an offscreen buffer.',
            tagColor: _Palette.accentViolet,
            icon: Icons.layers,
          ),
          const SizedBox(height: 18.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFEDE9FE),
                  Color(0xFFFCE7F3),
                ],
              ),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.30),
                width: 1.0,
              ),
            ),
            child: Column(children: const <Widget>[
              _LayerStackRow(
                title: 'Clip.hardEdge / antiAlias',
                layers: <String>['ClipLayer', 'child paint'],
                color: _Palette.accentBlue,
              ),
              SizedBox(height: 14.0),
              _LayerStackRow(
                title: 'Clip.antiAliasWithSaveLayer',
                layers: <String>[
                  'ClipLayer',
                  'OffsetLayer (saveLayer)',
                  'child paint',
                  'compositeFrom (restore)',
                ],
                color: _Palette.accentPink,
              ),
            ]),
          ),
          const SizedBox(height: 14.0),
          Row(children: const <Widget>[
            Expanded(
              child: _Bullet(
                color: _Palette.accentBlue,
                title: 'When AA is enough',
                body:
                    'antiAlias smooths edges by modulating coverage in the destination. '
                    'No new buffer; cheap on every backend.',
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _Bullet(
                color: _Palette.accentPink,
                title: 'When saveLayer is required',
                body:
                    'Needed if the child uses blendModes (e.g. multiply) or opacity '
                    'that must be premultiplied before the clip. Expensive on mobile GPUs.',
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _LayerStackRow extends StatelessWidget {
  const _LayerStackRow({
    required this.title,
    required this.layers,
    required this.color,
  });

  final String title;
  final List<String> layers;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          _LabelChip(label: title, color: color),
        ]),
        const SizedBox(height: 8.0),
        Row(children: _layerWidgets(layers, color)),
      ],
    );
  }

  List<Widget> _layerWidgets(List<String> layers, Color color) {
    final List<Widget> out = <Widget>[];
    for (int i = 0; i < layers.length; i++) {
      out.add(_LayerPill(text: layers[i], color: color));
      if (i < layers.length - 1) {
        out.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.chevron_right, size: 16.0, color: _Palette.ink400),
        ));
      }
    }
    return out;
  }
}

class _LayerPill extends StatelessWidget {
  const _LayerPill({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.40), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({
    required this.color,
    required this.title,
    required this.body,
  });

  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.30), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 8.0),
          Text(
            body,
            style: const TextStyle(
              color: _Palette.ink700,
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. Hit testing section.
// ---------------------------------------------------------------------------

class _HitTestingSection extends StatelessWidget {
  const _HitTestingSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'HIT TESTING',
            title: 'What counts as "inside" a clip',
            subtitle:
                'hitTest only proceeds if the position falls within the clip shape.',
            tagColor: _Palette.accentGreen,
            icon: Icons.touch_app_outlined,
          ),
          const SizedBox(height: 18.0),
          Row(children: <Widget>[
            const _HitTestDiagram(),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  _HitRow(label: 'P₁', color: _Palette.accentGreen,
                      detail: 'inside the ClipOval ellipse — child sees the tap.'),
                  SizedBox(height: 10.0),
                  _HitRow(label: 'P₂', color: _Palette.accentRed,
                      detail: 'inside the bounding rect, outside the oval — '
                          'rejected by hitTestSelf.'),
                  SizedBox(height: 10.0),
                  _HitRow(label: 'P₃', color: _Palette.accentRed,
                      detail: 'completely outside the bounds — never reaches '
                          'the clip RenderObject at all.'),
                  SizedBox(height: 16.0),
                  Text(
                    'RenderClipOval / RenderClipPath override hitTest to first '
                    'check the geometry; only matches dispatch to children.',
                    style: TextStyle(
                      color: _Palette.ink700,
                      fontSize: 12.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _HitTestDiagram extends StatelessWidget {
  const _HitTestDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 180.0,
      decoration: BoxDecoration(
        color: _Palette.ink100,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _Palette.ink200, width: 1.0),
      ),
      child: Stack(children: <Widget>[
        Positioned(
          left: 30.0,
          top: 30.0,
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    const Color(0xFF22C55E).withValues(alpha: 0.30),
                    const Color(0xFF14B8A6).withValues(alpha: 0.18),
                  ],
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ),
        const Positioned(
          left: 80.0,
          top: 80.0,
          child: _CrosshairDot(color: _Palette.accentGreen, label: 'P₁'),
        ),
        const Positioned(
          left: 38.0,
          top: 38.0,
          child: _CrosshairDot(color: _Palette.accentRed, label: 'P₂'),
        ),
        const Positioned(
          left: 6.0,
          top: 6.0,
          child: _CrosshairDot(color: _Palette.accentRed, label: 'P₃'),
        ),
      ]),
    );
  }
}

class _CrosshairDot extends StatelessWidget {
  const _CrosshairDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFFFFFFF), width: 2.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 4.0,
            ),
          ],
        ),
      ),
      const SizedBox(width: 4.0),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ]);
  }
}

class _HitRow extends StatelessWidget {
  const _HitRow({
    required this.label,
    required this.color,
    required this.detail,
  });

  final String label;
  final Color color;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        width: 26.0,
        height: 26.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(width: 10.0),
      Expanded(
        child: Text(
          detail,
          style: const TextStyle(
            color: _Palette.ink700,
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
      ),
    ]);
  }
}

// ---------------------------------------------------------------------------
// 10. Pitfalls section.
// ---------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'PITFALLS',
            title: 'Five things that bite',
            subtitle: 'Common mistakes when reaching for a Clip RenderObject.',
            tagColor: _Palette.accentRed,
            icon: Icons.error_outline,
          ),
          const SizedBox(height: 16.0),
          Column(children: const <Widget>[
            _Pitfall(
              number: '1',
              title: 'ClipPath defeats the raster cache',
              detail:
                  'A custom Path forces re-rasterization on every frame the path '
                  'changes. Prefer ClipRRect or BoxDecoration shapes when possible.',
            ),
            SizedBox(height: 10.0),
            _Pitfall(
              number: '2',
              title: 'ClipRRect is faster than ClipPath for rounded buttons',
              detail:
                  'The engine has fast paths for axis-aligned rounded rectangles. '
                  'Don\'t reach for ClipPath just to round four corners.',
            ),
            SizedBox(height: 10.0),
            _Pitfall(
              number: '3',
              title: 'Clip.none doesn\'t actually clip',
              detail:
                  'Children paint freely outside the parent\'s box. Useful for '
                  'Stack overflow effects, dangerous when you expected masking.',
            ),
            SizedBox(height: 10.0),
            _Pitfall(
              number: '4',
              title: 'antiAliasWithSaveLayer is the most expensive mode',
              detail:
                  'Only use it when blend modes or grouped opacity require '
                  'an offscreen buffer. Default Clip.antiAlias is almost always sufficient.',
            ),
            SizedBox(height: 10.0),
            _Pitfall(
              number: '5',
              title: 'Clipping doesn\'t shrink the layout',
              detail:
                  'A clipped child still reports its full size to layout. '
                  'Wrap with SizedBox/ConstrainedBox if you also want to constrain dimensions.',
            ),
          ]),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  const _Pitfall({
    required this.number,
    required this.title,
    required this.detail,
  });

  final String number;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFFEF2F2),
            Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.25),
          width: 1.0,
        ),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFEF4444),
                Color(0xFFE91E63),
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFFEF4444).withValues(alpha: 0.30),
                blurRadius: 6.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
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
                  color: _Palette.ink900,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                detail,
                style: const TextStyle(
                  color: _Palette.ink700,
                  fontSize: 12.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// 11. Code usage section.
// ---------------------------------------------------------------------------

class _CodeUsageSection extends StatelessWidget {
  const _CodeUsageSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            tag: 'CODE',
            title: 'Usage cheat sheet',
            subtitle: 'Every Clip widget exposes the same clipBehavior knob.',
            tagColor: _Palette.ink800,
            icon: Icons.code,
          ),
          const SizedBox(height: 16.0),
          const _CodeBlock(lines: <_CodeLine>[
            _CodeLine.comment('// rectangular clip — axis-aligned'),
            _CodeLine.keyword('ClipRect', after: '('),
            _CodeLine.plain('  clipBehavior: ', extras: <_CodeSpan>[
              _CodeSpan('Clip.hardEdge', _Palette.codeType),
              _CodeSpan(',', _Palette.codeFg),
            ]),
            _CodeLine.plain('  child: ', extras: <_CodeSpan>[
              _CodeSpan('Container', _Palette.codeType),
              _CodeSpan('(...),', _Palette.codeFg),
            ]),
            _CodeLine.plain('),'),
            _CodeLine.blank(),
            _CodeLine.comment('// rounded rectangle clip — default antiAlias'),
            _CodeLine.keyword('ClipRRect', after: '('),
            _CodeLine.plain('  borderRadius: ', extras: <_CodeSpan>[
              _CodeSpan('BorderRadius', _Palette.codeType),
              _CodeSpan('.circular(', _Palette.codeFg),
              _CodeSpan('12.0', _Palette.codeString),
              _CodeSpan('),', _Palette.codeFg),
            ]),
            _CodeLine.plain('  clipBehavior: ', extras: <_CodeSpan>[
              _CodeSpan('Clip.antiAlias', _Palette.codeType),
              _CodeSpan(',', _Palette.codeFg),
            ]),
            _CodeLine.plain('  child: image,'),
            _CodeLine.plain('),'),
            _CodeLine.blank(),
            _CodeLine.comment('// oval / circle — inscribed ellipse'),
            _CodeLine.keyword('ClipOval', after: '('),
            _CodeLine.plain('  clipBehavior: ', extras: <_CodeSpan>[
              _CodeSpan('Clip.antiAlias', _Palette.codeType),
              _CodeSpan(',', _Palette.codeFg),
            ]),
            _CodeLine.plain('  child: avatar,'),
            _CodeLine.plain('),'),
            _CodeLine.blank(),
            _CodeLine.comment('// arbitrary path — supply a CustomClipper<Path>'),
            _CodeLine.keyword('ClipPath', after: '('),
            _CodeLine.plain('  clipper: ', extras: <_CodeSpan>[
              _CodeSpan('const ', _Palette.codeKeyword),
              _CodeSpan('StarClipper', _Palette.codeType),
              _CodeSpan('(),', _Palette.codeFg),
            ]),
            _CodeLine.plain('  clipBehavior: ', extras: <_CodeSpan>[
              _CodeSpan('Clip.antiAliasWithSaveLayer', _Palette.codeType),
              _CodeSpan(',', _Palette.codeFg),
            ]),
            _CodeLine.plain('  child: gradientBox,'),
            _CodeLine.plain('),'),
          ]),
        ],
      ),
    );
  }
}

class _CodeSpan {
  const _CodeSpan(this.text, this.color);
  final String text;
  final Color color;
}

class _CodeLine {
  final int kind;
  final String text;
  final String after;
  final List<_CodeSpan> extras;

  static const int _kindBlank = 0;
  static const int _kindComment = 1;
  static const int _kindKeyword = 2;
  static const int _kindPlain = 3;

  // d4rt's interpreter does not propagate args (explicit or default)
  // through a redirecting `this._()` constructor — fields end up null
  // and the for-in loop in `_CodeRow._buildLineText` raised
  // "Value used in for-in loop must be an Iterable, but got null".
  // Avoid redirection by initialising fields directly in each
  // named constructor.
  const _CodeLine.blank()
      : kind = _kindBlank,
        text = '',
        after = '',
        extras = const <_CodeSpan>[];
  const _CodeLine.comment(this.text)
      : kind = _kindComment,
        after = '',
        extras = const <_CodeSpan>[];
  const _CodeLine.keyword(this.text, {this.after = ''})
      : kind = _kindKeyword,
        extras = const <_CodeSpan>[];
  const _CodeLine.plain(this.text, {this.extras = const <_CodeSpan>[]})
      : kind = _kindPlain,
        after = '';
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.lines});

  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0F172A),
            Color(0xFF1E293B),
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFF334155),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _renderLines(lines),
      ),
    );
  }

  List<Widget> _renderLines(List<_CodeLine> input) {
    final List<Widget> out = <Widget>[];
    for (int i = 0; i < input.length; i++) {
      out.add(_CodeRow(line: input[i], number: i + 1));
    }
    return out;
  }
}

class _CodeRow extends StatelessWidget {
  const _CodeRow({required this.line, required this.number});

  final _CodeLine line;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SizedBox(
          width: 28.0,
          child: Text(
            number.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(child: _buildLineText()),
      ]),
    );
  }

  Widget _buildLineText() {
    if (line.kind == _CodeLine._kindBlank) {
      return const SizedBox(height: 14.0);
    }
    if (line.kind == _CodeLine._kindComment) {
      return Text(
        line.text,
        style: const TextStyle(
          color: _Palette.codeComment,
          fontSize: 12.0,
          fontFamily: 'monospace',
          fontStyle: FontStyle.italic,
        ),
      );
    }
    if (line.kind == _CodeLine._kindKeyword) {
      return RichText(
        text: TextSpan(children: <InlineSpan>[
          TextSpan(
            text: line.text,
            style: const TextStyle(
              color: _Palette.codeType,
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: line.after,
            style: const TextStyle(
              color: _Palette.codeFg,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ]),
      );
    }
    // plain.
    final List<InlineSpan> spans = <InlineSpan>[
      TextSpan(
        text: line.text,
        style: const TextStyle(
          color: _Palette.codeFg,
          fontSize: 12.5,
          fontFamily: 'monospace',
        ),
      ),
    ];
    for (final _CodeSpan span in line.extras) {
      spans.add(TextSpan(
        text: span.text,
        style: TextStyle(
          color: span.color,
          fontSize: 12.5,
          fontFamily: 'monospace',
          fontWeight: span.color == _Palette.codeKeyword
              ? FontWeight.w700
              : FontWeight.w400,
        ),
      ));
    }
    return RichText(text: TextSpan(children: spans));
  }
}

// ---------------------------------------------------------------------------
// 12. Footer.
// ---------------------------------------------------------------------------

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1E293B),
            Color(0xFF0F172A),
          ],
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF1E88E5), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Icon(Icons.layers_outlined,
              size: 20.0, color: Color(0xFFFFFFFF)),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Clip RenderObjects · visual deep demo',
                style: TextStyle(
                  color: Color(0xFFF8FAFC),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'package:flutter/rendering.dart · static snapshot',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E).withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(
              color: const Color(0xFF22C55E).withValues(alpha: 0.55),
              width: 1.0,
            ),
          ),
          child: const Text(
            'v 1.0.0',
            style: TextStyle(
              color: Color(0xFF86EFAC),
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ]),
    );
  }
}
