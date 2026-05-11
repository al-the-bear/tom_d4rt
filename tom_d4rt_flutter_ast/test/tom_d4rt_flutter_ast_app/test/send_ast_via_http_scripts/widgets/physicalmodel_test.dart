// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// PhysicalModel — Deep Visual Demo
//
// `PhysicalModel` is the low-level widget that gives a chunk of UI an actual
// physical presence: it paints a flat-colored surface, clips its child to a
// shape (rectangle, circle, or a more elaborate radius), and — most
// importantly — draws an `elevation`-driven shadow underneath it.
//
// Almost every visually "raised" surface in Flutter ultimately bottoms out
// in a PhysicalModel:
//
//   Material   → uses PhysicalModel / PhysicalShape internally to paint
//                its elevation overlay and shadow.
//   Card       → wraps Material, which wraps PhysicalModel.
//   AppBar     → its elevation pixel is realized by a Material/PhysicalModel.
//   FAB        → again, Material on top of a PhysicalShape.
//
// Reaching for `PhysicalModel` directly is what you do when you want the
// shadow + clip + color of a Material surface, without the InkWell ripple,
// the M3 surface-tint overlay, the InkResponse target, or the implicit
// theming. It is the bare physical surface, nothing more.
//
// `PhysicalShape` is the same idea, but instead of a `BoxShape` + optional
// border radius, it takes any `CustomClipper<Path>`. That makes it the
// preferred building block for things like:
//   - bottom-app-bar notches that the FAB cuts out of,
//   - capsule pills with non-circular curvature,
//   - silhouettes with bumps, scallops, dog-ears, or torn paper edges.
//
// This file renders a static, hand-authored visual essay that walks through
// every aspect of these two widgets: anatomy, elevation steps, shape
// variants, recipes, comparisons with Material and Container+BoxShadow,
// a glossary, and a recap.
//
// All widgets are stateless. The whole tree is one big composition, which
// makes it directly replayable by an AST interpreter.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF0F172A);
const Color _kInkSoft = Color(0xFF334155);
const Color _kInkMute = Color(0xFF64748B);
const Color _kInkFaint = Color(0xFF94A3B8);

const Color _kPaper = Color(0xFFF8FAFC);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kWarm = Color(0xFFFFF7ED);
const Color _kCool = Color(0xFFF0F9FF);

const Color _kAccent = Color(0xFF6D28D9); // violet 700
const Color _kAccentSoft = Color(0xFFEDE9FE); // violet 100
const Color _kAccentAlt = Color(0xFF0EA5E9); // sky 500

const Color _kGood = Color(0xFF059669);
const Color _kGoodSoft = Color(0xFFD1FAE5);
const Color _kBad = Color(0xFFDC2626);
const Color _kBadSoft = Color(0xFFFEE2E2);
const Color _kWarn = Color(0xFFD97706);
const Color _kWarnSoft = Color(0xFFFEF3C7);
const Color _kInfo = Color(0xFF2563EB);
const Color _kInfoSoft = Color(0xFFDBEAFE);

const Color _kRule = Color(0xFFE2E8F0);
const Color _kRuleSoft = Color(0xFFF1F5F9);

const Color _kCodeBg = Color(0xFF0B1021);
const Color _kCodeFg = Color(0xFFE2E8F0);
const Color _kCodeCaption = Color(0xFF94A3B8);
const Color _kCodeKeyword = Color(0xFFC084FC);
const Color _kCodeString = Color(0xFFFCA5A5);
const Color _kCodeNumber = Color(0xFFFBBF24);

const String _kMono = 'monospace';

// ---------------------------------------------------------------------------
// Top-level entry. Required signature for the AST runner.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PhysicalModel — Deep Visual Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
      textTheme: const TextTheme(),
    ),
    home: const Scaffold(
      backgroundColor: _kPaper,
      body: _DemoBody(),
    ),
  );
}

class _DemoBody extends StatelessWidget {
  const _DemoBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _HeroBannerSection(),
          SizedBox(height: 36),
          _DossierSection(),
          SizedBox(height: 36),
          _AnatomySection(),
          SizedBox(height: 36),
          _ConstructorReferenceSection(),
          SizedBox(height: 36),
          _ElevationGridSection(),
          SizedBox(height: 36),
          _BoxShapeSection(),
          SizedBox(height: 36),
          _BorderRadiusSection(),
          SizedBox(height: 36),
          _ClipBehaviorSection(),
          SizedBox(height: 36),
          _ShadowColorSection(),
          SizedBox(height: 36),
          _RecipeCardStackSection(),
          SizedBox(height: 36),
          _RecipeCoinMedallionSection(),
          SizedBox(height: 36),
          _RecipePillowSection(),
          SizedBox(height: 36),
          _RecipeBusinessCardSection(),
          SizedBox(height: 36),
          _RecipeLayeredReceiptsSection(),
          SizedBox(height: 36),
          _RecipeSlipPagesSection(),
          SizedBox(height: 36),
          _RecipeFloorPlanSection(),
          SizedBox(height: 36),
          _PhysicalShapeSection(),
          SizedBox(height: 36),
          _ComparisonMaterialSection(),
          SizedBox(height: 36),
          _ComparisonContainerSection(),
          SizedBox(height: 36),
          _GlossarySection(),
          SizedBox(height: 36),
          _RecapSection(),
          SizedBox(height: 32),
          _FooterSection(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared building blocks
// ---------------------------------------------------------------------------

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
    this.eyebrowColor = _kAccent,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;
  final Color eyebrowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kRule),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: eyebrowColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: eyebrowColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              eyebrow.toUpperCase(),
              style: TextStyle(
                color: eyebrowColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: _kInk,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: _kInkMute,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, {required this.color, this.bold = false});
  final String text;
  final Color color;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text, {this.tone = _kInkSoft, this.dotColor});
  final String text;
  final Color tone;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 7, right: 10),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dotColor ?? tone,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: tone, fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonoBlock extends StatelessWidget {
  const _MonoBlock(this.code, {this.caption});
  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCodeBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1F2A44)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kCodeBg.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (caption != null) ...<Widget>[
            Text(
              caption!,
              style: const TextStyle(
                color: _kCodeCaption,
                fontSize: 11,
                fontFamily: _kMono,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 8),
          ],
          SelectableText(
            code,
            style: const TextStyle(
              color: _kCodeFg,
              fontSize: 12.5,
              fontFamily: _kMono,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(
    this.text, {
    this.color = _kInkMute,
    this.size = 12,
    this.bold = false,
  });
  final String text;
  final Color color;
  final double size;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine({this.color = _kRule, this.height = 1});
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: height, color: color);
  }
}

class _TwoColumnTable extends StatelessWidget {
  const _TwoColumnTable({required this.rows, this.headers});
  final List<List<String>> rows;
  final List<String>? headers;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kRuleSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        children: <Widget>[
          if (headers != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                color: _kAccentSoft,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      headers![0],
                      style: const TextStyle(
                        color: _kAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      headers![1],
                      style: const TextStyle(
                        color: _kAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven ? _kCard : _kRuleSoft,
                border: Border(
                  top: i == 0
                      ? BorderSide.none
                      : const BorderSide(color: _kRule, width: 0.5),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      rows[i][0],
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: _kMono,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i][1],
                      style: const TextStyle(
                        color: _kInkSoft,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
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

class _Callout extends StatelessWidget {
  const _Callout({
    required this.tone,
    required this.title,
    required this.body,
    this.icon = '!',
  });

  final Color tone;
  final String title;
  final String body;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              icon,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: tone,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
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

// ---------------------------------------------------------------------------
// HERO BANNER
// ---------------------------------------------------------------------------

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 36, 32, 36),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
            Color(0xFF4C1D95),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.4),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Text(
                    'WIDGETS · PAINT · ELEVATION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'PhysicalModel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The flat color, the clip, the shadow — the bare physics of a surface.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const <Widget>[
                    _HeroTag('color'),
                    _HeroTag('elevation'),
                    _HeroTag('shape'),
                    _HeroTag('borderRadius'),
                    _HeroTag('clipBehavior'),
                    _HeroTag('shadowColor'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 10,
                    top: 40,
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(width: 90, height: 130),
                    ),
                  ),
                  Positioned(
                    left: 60,
                    top: 20,
                    child: PhysicalModel(
                      color: const Color(0xFFFEF3C7),
                      elevation: 10,
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(width: 90, height: 150),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 50,
                    child: PhysicalModel(
                      color: const Color(0xFFFBCFE8),
                      elevation: 18,
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(width: 90, height: 130),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 30,
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 24,
                      shape: BoxShape.circle,
                      child: const SizedBox(width: 64, height: 64),
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
}

class _HeroTag extends StatelessWidget {
  const _HeroTag(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: _kMono,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DOSSIER
// ---------------------------------------------------------------------------

class _DossierSection extends StatelessWidget {
  const _DossierSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Dossier',
      title: 'What PhysicalModel actually is',
      subtitle:
          'A render-tree primitive that paints a colored shape, clips children, '
          'and draws a Material-style shadow driven by elevation.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Bullet(
            'Defined in package:flutter/widgets.dart. No Material import '
            'required — it works in any Flutter app, including pure widgets-only setups.',
          ),
          const _Bullet(
            'Paints, in order: the elevation shadow, then a solid color fill, '
            'then its child clipped to the shape.',
          ),
          const _Bullet(
            'Owns three orthogonal knobs: shape (rect or circle), '
            'borderRadius (for the rect case), and clipBehavior (how the child '
            'is clipped to that shape).',
          ),
          const _Bullet(
            'Does NOT do: ripples, surface-tint overlays, theme integration, '
            'hover/focus highlights, or hit-testing magic. Those are Material\'s job.',
          ),
          const _Bullet(
            'Pair widget: PhysicalShape — same idea, but takes a CustomClipper<Path> '
            'instead of a shape+radius, allowing arbitrary silhouettes.',
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _DossierCard(
                  title: 'Use it when…',
                  tone: _kGood,
                  bullets: const <String>[
                    'You need a clipped, shadowed surface with no Material chrome.',
                    'You\'re below the Material layer (e.g. inside a custom paint pipeline).',
                    'You want predictable, theme-free elevation rendering.',
                    'You\'re building Card-like primitives in a design system.',
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _DossierCard(
                  title: 'Reach for Material instead when…',
                  tone: _kBad,
                  bullets: const <String>[
                    'You want InkWell ripple effects on tap.',
                    'You want M3 surfaceTint elevation overlays.',
                    'You want theme-driven default colors.',
                    'You\'re building an interactive button or chip.',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _Callout(
            tone: _kInfo,
            icon: 'i',
            title: 'Mental model',
            body:
                'PhysicalModel is a thin slab of material with a flat-painted top. '
                'Elevation lifts the slab away from the page; the shadow falls onto '
                'whatever is behind. clipBehavior decides whether the painted child '
                'inside the slab is hard-clipped, anti-aliased, or saved into a layer.',
          ),
        ],
      ),
    );
  }
}

class _DossierCard extends StatelessWidget {
  const _DossierCard({
    required this.title,
    required this.tone,
    required this.bullets,
  });
  final String title;
  final Color tone;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: tone,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          for (final String b in bullets) _Bullet(b, tone: _kInkSoft, dotColor: tone),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ANATOMY
// ---------------------------------------------------------------------------

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Anatomy',
      title: 'The six knobs of a PhysicalModel',
      subtitle:
          'Every PhysicalModel is a tuple: (color, elevation, shape, borderRadius, '
          'clipBehavior, shadowColor) + a child. Here is every knob, isolated.',
      eyebrowColor: _kAccentAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _AnatomyTile(
                  label: 'color',
                  description:
                      'The flat fill painted under the child. Required.',
                  preview: PhysicalModel(
                    color: const Color(0xFFFCD34D),
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: const SizedBox(width: 110, height: 64),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AnatomyTile(
                  label: 'elevation',
                  description:
                      'Logical z-depth in pixels. Drives the shadow softness and offset.',
                  preview: PhysicalModel(
                    color: Colors.white,
                    elevation: 14,
                    borderRadius: BorderRadius.circular(10),
                    child: const SizedBox(width: 110, height: 64),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AnatomyTile(
                  label: 'shape',
                  description:
                      'BoxShape.rectangle (default) or BoxShape.circle. '
                      'Circle ignores borderRadius.',
                  preview: PhysicalModel(
                    color: const Color(0xFFA7F3D0),
                    elevation: 6,
                    shape: BoxShape.circle,
                    child: const SizedBox(width: 72, height: 72),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _AnatomyTile(
                  label: 'borderRadius',
                  description:
                      'Per-corner radius for the rectangle shape. '
                      'Ignored when shape is BoxShape.circle.',
                  preview: PhysicalModel(
                    color: const Color(0xFFBFDBFE),
                    elevation: 4,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                    child: const SizedBox(width: 110, height: 64),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AnatomyTile(
                  label: 'clipBehavior',
                  description:
                      'How the child is clipped to the shape. Clip.none means '
                      'the child can overflow the surface.',
                  preview: PhysicalModel(
                    color: const Color(0xFFFBCFE8),
                    elevation: 4,
                    borderRadius: BorderRadius.circular(16),
                    clipBehavior: Clip.antiAlias,
                    child: const SizedBox(width: 110, height: 64),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AnatomyTile(
                  label: 'shadowColor',
                  description:
                      'Tints the cast shadow. Use sparingly — non-black shadows '
                      'are great for brand accents.',
                  preview: PhysicalModel(
                    color: Colors.white,
                    elevation: 10,
                    shadowColor: _kAccent,
                    borderRadius: BorderRadius.circular(10),
                    child: const SizedBox(width: 110, height: 64),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnatomyTile extends StatelessWidget {
  const _AnatomyTile({
    required this.label,
    required this.description,
    required this.preview,
  });
  final String label;
  final String description;
  final Widget preview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: _kRuleSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: _kAccent,
                fontSize: 12,
                fontFamily: _kMono,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 96,
            child: Center(child: preview),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CONSTRUCTOR REFERENCE
// ---------------------------------------------------------------------------

class _ConstructorReferenceSection extends StatelessWidget {
  const _ConstructorReferenceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Constructor',
      title: 'PhysicalModel({ ... })',
      subtitle:
          'The full constructor surface, with the default values that ship '
          'in package:flutter/widgets.dart.',
      eyebrowColor: _kInfo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _MonoBlock(
            'const PhysicalModel({\n'
                '  Key? key,\n'
                '  BoxShape shape = BoxShape.rectangle,\n'
                '  Clip clipBehavior = Clip.none,\n'
                '  BorderRadius? borderRadius,\n'
                '  double elevation = 0.0,\n'
                '  required Color color,\n'
                '  Color shadowColor = const Color(0xFF000000),\n'
                '  Widget? child,\n'
                '});',
            caption: 'lib/widgets/basic.dart',
          ),
          const SizedBox(height: 14),
          _TwoColumnTable(
            headers: const <String>['Field', 'Behavior'],
            rows: const <List<String>>[
              <String>[
                'shape',
                'BoxShape.rectangle (default) draws an optionally-rounded rect. '
                    'BoxShape.circle draws a perfect circle and ignores borderRadius.',
              ],
              <String>[
                'clipBehavior',
                'Clip.none (default): no clip layer at all. Children can paint '
                    'past the surface. Clip.hardEdge / antiAlias / antiAliasWithSaveLayer: '
                    'progressively more expensive, progressively smoother clip edges.',
              ],
              <String>[
                'borderRadius',
                'BorderRadius? for the rectangle shape. Must be null when shape is circle. '
                    'Null is treated as BorderRadius.zero.',
              ],
              <String>[
                'elevation',
                'Logical z-distance from the page. Must be ≥ 0. Drives shadow blur, '
                    'spread, and offset using Material elevation tables.',
              ],
              <String>[
                'color',
                'Required. The opaque fill painted under the child. Cannot be null. '
                    'For transparent surfaces, use a Container or a Material with type set.',
              ],
              <String>[
                'shadowColor',
                'Tint of the cast shadow. Defaults to opaque black (0xFF000000). '
                    'Alpha is multiplied with the elevation-derived opacity.',
              ],
              <String>[
                'child',
                'The painted content. Will be clipped to the shape when clipBehavior != Clip.none.',
              ],
            ],
          ),
          const SizedBox(height: 14),
          const _Callout(
            tone: _kWarn,
            icon: '!',
            title: 'Heads-up: color is required and must be opaque',
            body:
                'PhysicalModel does not paint a transparent surface. A semi-transparent '
                'color will assert at runtime in debug builds. If you need a translucent '
                'raised surface, layer a PhysicalModel under a Container with a translucent fill.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ELEVATION GRID
// ---------------------------------------------------------------------------

class _ElevationGridSection extends StatelessWidget {
  const _ElevationGridSection();

  static const List<double> _values = <double>[
    0, 1, 2, 4, 6, 8, 12, 16, 24,
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Elevation',
      title: 'The full Material elevation ladder',
      subtitle:
          'Each tile is a PhysicalModel with the same color, shape, and '
          'borderRadius — only the elevation changes. Read the shadow.',
      eyebrowColor: _kAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 20,
            runSpacing: 28,
            children: <Widget>[
              for (final double e in _values) _ElevationTile(elevation: e),
            ],
          ),
          const SizedBox(height: 20),
          const _Callout(
            tone: _kInfo,
            icon: 'i',
            title: 'How elevation maps to pixels',
            body:
                'Elevation is unitless in the API, but it lines up with the '
                'Material spec: 0 = flush, 1 = pressed card, 2 = card, 4 = AppBar, '
                '6 = FAB, 8 = bottom navigation, 12 = drawer, 16 = nav rail, '
                '24 = dialog. Higher = softer, more diffuse shadow.',
          ),
          const SizedBox(height: 16),
          _TwoColumnTable(
            headers: const <String>['Elevation', 'Typical role'],
            rows: const <List<String>>[
              <String>['0', 'Flush with the page. No shadow.'],
              <String>['1', 'Pressed-state card or a subtle hover lift.'],
              <String>['2', 'Resting card (Material 2 Card default).'],
              <String>['4', 'AppBar, snackbar, raised button.'],
              <String>['6', 'FAB at rest.'],
              <String>['8', 'Bottom navigation bar, FAB pressed.'],
              <String>['12', 'Side drawer at rest.'],
              <String>['16', 'Modal nav drawer, large bottom sheet.'],
              <String>['24', 'Dialog at rest, full-screen menu.'],
            ],
          ),
        ],
      ),
    );
  }
}

class _ElevationTile extends StatelessWidget {
  const _ElevationTile({required this.elevation});
  final double elevation;

  @override
  Widget build(BuildContext context) {
    // clampDouble (from package:flutter/foundation.dart) guarantees a sane
    // elevation value in case this widget is ever fed something exotic.
    final double safe = clampDouble(elevation, 0, 64);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 110,
          height: 110,
          alignment: Alignment.center,
          child: PhysicalModel(
            color: Colors.white,
            elevation: safe,
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 84,
              height: 60,
              child: Center(
                child: Text(
                  elevation.toStringAsFixed(0),
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        _Label('elevation: $elevation', size: 11.5, bold: true),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// BOX SHAPE
// ---------------------------------------------------------------------------

class _BoxShapeSection extends StatelessWidget {
  const _BoxShapeSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Shape',
      title: 'BoxShape.rectangle vs BoxShape.circle',
      subtitle:
          'PhysicalModel\'s shape field has two values. Rectangle accepts '
          'borderRadius; circle always paints a perfect circle.',
      eyebrowColor: _kGood,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _ShapeCompareTile(
                  caption: 'BoxShape.rectangle',
                  description:
                      'Sharp corners unless you pass borderRadius. '
                      'Default shape value.',
                  preview: PhysicalModel(
                    color: const Color(0xFFFCE7F3),
                    elevation: 8,
                    shape: BoxShape.rectangle,
                    child: const SizedBox(width: 130, height: 130),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _ShapeCompareTile(
                  caption: 'BoxShape.rectangle + radius',
                  description:
                      'Most cards live here: rectangle with rounded corners.',
                  preview: PhysicalModel(
                    color: const Color(0xFFDBEAFE),
                    elevation: 8,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(24),
                    child: const SizedBox(width: 130, height: 130),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _ShapeCompareTile(
                  caption: 'BoxShape.circle',
                  description:
                      'Always a perfect circle. borderRadius MUST be null.',
                  preview: PhysicalModel(
                    color: const Color(0xFFDCFCE7),
                    elevation: 8,
                    shape: BoxShape.circle,
                    child: const SizedBox(width: 130, height: 130),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _Callout(
            tone: _kBad,
            icon: 'x',
            title: 'Common assertion',
            body:
                'shape == BoxShape.circle && borderRadius != null trips an '
                'assertion in debug. If you want non-circular curvature, use '
                'BoxShape.rectangle with a large radius (e.g. half the width) '
                'or switch to PhysicalShape with a custom clipper.',
          ),
        ],
      ),
    );
  }
}

class _ShapeCompareTile extends StatelessWidget {
  const _ShapeCompareTile({
    required this.caption,
    required this.description,
    required this.preview,
  });
  final String caption;
  final String description;
  final Widget preview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: _kRuleSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            caption,
            style: const TextStyle(
              color: _kAccent,
              fontFamily: _kMono,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(height: 160, child: Center(child: preview)),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BORDER RADIUS
// ---------------------------------------------------------------------------

class _BorderRadiusSection extends StatelessWidget {
  const _BorderRadiusSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'BorderRadius',
      title: 'Every flavor of corner',
      subtitle:
          'BorderRadius is a BorderRadiusGeometry — you can build it from '
          'circular(), all(), only(), vertical(), horizontal(), or '
          'BorderRadius.elliptical for non-uniform curvature.',
      eyebrowColor: _kInfo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: <Widget>[
              _RadiusTile(
                label: 'zero',
                radius: BorderRadius.zero,
                color: const Color(0xFFFEE2E2),
              ),
              _RadiusTile(
                label: 'circular(4)',
                radius: BorderRadius.circular(4),
                color: const Color(0xFFFEF3C7),
              ),
              _RadiusTile(
                label: 'circular(12)',
                radius: BorderRadius.circular(12),
                color: const Color(0xFFDCFCE7),
              ),
              _RadiusTile(
                label: 'circular(24)',
                radius: BorderRadius.circular(24),
                color: const Color(0xFFCFFAFE),
              ),
              _RadiusTile(
                label: 'circular(36)',
                radius: BorderRadius.circular(36),
                color: const Color(0xFFDBEAFE),
              ),
              _RadiusTile(
                label: 'circular(64)',
                radius: BorderRadius.circular(64),
                color: const Color(0xFFEDE9FE),
              ),
              _RadiusTile(
                label: 'only(topLeft, bottomRight)',
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                color: const Color(0xFFFCE7F3),
              ),
              _RadiusTile(
                label: 'only(topRight, bottomLeft)',
                radius: const BorderRadius.only(
                  topRight: Radius.circular(36),
                  bottomLeft: Radius.circular(36),
                ),
                color: const Color(0xFFFFE4E6),
              ),
              _RadiusTile(
                label: 'vertical(top: 32)',
                radius: const BorderRadius.vertical(top: Radius.circular(32)),
                color: const Color(0xFFE0E7FF),
              ),
              _RadiusTile(
                label: 'vertical(bottom: 32)',
                radius: const BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
                color: const Color(0xFFFFF1F2),
              ),
              _RadiusTile(
                label: 'horizontal(left: 32)',
                radius: const BorderRadius.horizontal(
                  left: Radius.circular(32),
                ),
                color: const Color(0xFFECFDF5),
              ),
              _RadiusTile(
                label: 'horizontal(right: 32)',
                radius: const BorderRadius.horizontal(
                  right: Radius.circular(32),
                ),
                color: const Color(0xFFFFFBEB),
              ),
              _RadiusTile(
                label: 'elliptical(40, 16)',
                radius: const BorderRadius.all(Radius.elliptical(40, 16)),
                color: const Color(0xFFF1F5F9),
              ),
              _RadiusTile(
                label: 'mixed corners',
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(48),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(48),
                ),
                color: const Color(0xFFFFF7ED),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadiusTile extends StatelessWidget {
  const _RadiusTile({
    required this.label,
    required this.radius,
    required this.color,
  });
  final String label;
  final BorderRadius radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          PhysicalModel(
            color: color,
            elevation: 6,
            borderRadius: radius,
            child: const SizedBox(width: 170, height: 90),
          ),
          const SizedBox(height: 8),
          _Label(label, bold: true, size: 11.5),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CLIP BEHAVIOR
// ---------------------------------------------------------------------------

class _ClipBehaviorSection extends StatelessWidget {
  const _ClipBehaviorSection();

  static const List<MapEntry<String, Clip>> _clips = <MapEntry<String, Clip>>[
    MapEntry<String, Clip>('Clip.none', Clip.none),
    MapEntry<String, Clip>('Clip.hardEdge', Clip.hardEdge),
    MapEntry<String, Clip>('Clip.antiAlias', Clip.antiAlias),
    MapEntry<String, Clip>(
      'Clip.antiAliasWithSaveLayer',
      Clip.antiAliasWithSaveLayer,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'ClipBehavior',
      title: 'Four ways to clip the child',
      subtitle:
          'Each tile contains a child that overflows the rounded surface. '
          'Watch how clipBehavior decides whether the overflow is cropped, '
          'feathered, or layered.',
      eyebrowColor: _kAccentAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: <Widget>[
              for (final MapEntry<String, Clip> c in _clips)
                _ClipTile(label: c.key, clip: c.value),
            ],
          ),
          const SizedBox(height: 18),
          _TwoColumnTable(
            headers: const <String>['Value', 'Behavior'],
            rows: const <List<String>>[
              <String>[
                'Clip.none',
                'No clip layer is inserted. Painting is fastest, but the child '
                    'can draw outside the surface — useful when you know overflow '
                    'won\'t happen.',
              ],
              <String>[
                'Clip.hardEdge',
                'Inserts a clip with no anti-aliasing. Cheap; corners and curves '
                    'will look pixelated at this stage but compose fast.',
              ],
              <String>[
                'Clip.antiAlias',
                'Inserts an anti-aliased clip. Slightly more expensive, but '
                    'smooth corners. The Material default for most surfaces.',
              ],
              <String>[
                'Clip.antiAliasWithSaveLayer',
                'Anti-aliased clip wrapped in a saveLayer. Most expensive, '
                    'but necessary when blending modes on children must respect '
                    'the clip silhouette exactly.',
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ClipTile extends StatelessWidget {
  const _ClipTile({required this.label, required this.clip});
  final String label;
  final Clip clip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          PhysicalModel(
            color: const Color(0xFFF1F5F9),
            elevation: 6,
            clipBehavior: clip,
            borderRadius: BorderRadius.circular(36),
            child: SizedBox(
              width: 170,
              height: 100,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    left: -10,
                    top: -10,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: _kAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -16,
                    bottom: -16,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: _kAccentAlt,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      label.replaceFirst('Clip.', ''),
                      style: const TextStyle(
                        color: _kInk,
                        fontFamily: _kMono,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          _Label(label, bold: true, size: 11.5),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SHADOW COLOR
// ---------------------------------------------------------------------------

class _ShadowColorSection extends StatelessWidget {
  const _ShadowColorSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'ShadowColor',
      title: 'Tinting the cast shadow',
      subtitle:
          'Default is opaque black. Non-black shadows produce a tinted glow '
          'that reads as either branding or material-specific (warm wood vs cold steel).',
      eyebrowColor: _kAccent,
      child: Wrap(
        spacing: 20,
        runSpacing: 26,
        children: <Widget>[
          _ShadowSwatch(name: 'black (default)', shadow: Colors.black),
          _ShadowSwatch(name: 'violet 700', shadow: _kAccent),
          _ShadowSwatch(name: 'sky 500', shadow: _kAccentAlt),
          _ShadowSwatch(name: 'emerald 600', shadow: _kGood),
          _ShadowSwatch(name: 'amber 600', shadow: _kWarn),
          _ShadowSwatch(name: 'rose 600', shadow: _kBad),
          _ShadowSwatch(name: 'indigo 900', shadow: const Color(0xFF312E81)),
          _ShadowSwatch(name: 'slate 700', shadow: const Color(0xFF334155)),
        ],
      ),
    );
  }
}

class _ShadowSwatch extends StatelessWidget {
  const _ShadowSwatch({required this.name, required this.shadow});
  final String name;
  final Color shadow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PhysicalModel(
          color: Colors.white,
          elevation: 16,
          shadowColor: shadow,
          borderRadius: BorderRadius.circular(14),
          child: const SizedBox(width: 130, height: 88),
        ),
        const SizedBox(height: 8),
        _Label(name, bold: true, size: 11.5),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// RECIPE — CARD STACK
// ---------------------------------------------------------------------------

class _RecipeCardStackSection extends StatelessWidget {
  const _RecipeCardStackSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipe',
      title: 'A stack of cards with realistic depth',
      subtitle:
          'Three PhysicalModels at elevations 2, 6, 14 — staggered with '
          'Padding so the shadows visibly compound.',
      eyebrowColor: _kAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 360,
              height: 230,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 20,
                    top: 40,
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 2,
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(width: 280, height: 160),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 22,
                    child: PhysicalModel(
                      color: const Color(0xFFFFFBEB),
                      elevation: 6,
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(width: 280, height: 160),
                    ),
                  ),
                  Positioned(
                    left: 52,
                    top: 6,
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 14,
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        width: 280,
                        height: 160,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                'Top card',
                                style: TextStyle(
                                  color: _kInk,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'elevation: 14',
                                style: TextStyle(
                                  color: _kInkMute,
                                  fontFamily: _kMono,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Compounded shadows give the impression that '
                                'each card sits a little higher than the one below.',
                                style: TextStyle(
                                  color: _kInkSoft,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const _MonoBlock(
            'PhysicalModel(\n'
                '  color: Colors.white,\n'
                '  elevation: 14,\n'
                '  borderRadius: BorderRadius.circular(14),\n'
                '  child: ...content...,\n'
                ')',
            caption: 'Stack child pattern',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RECIPE — COIN / MEDALLION
// ---------------------------------------------------------------------------

class _RecipeCoinMedallionSection extends StatelessWidget {
  const _RecipeCoinMedallionSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipe',
      title: 'Coins and medallions',
      subtitle:
          'BoxShape.circle plus a high elevation gives the unmistakable look '
          'of a hovering coin. Tint the shadow to suggest metal type.',
      eyebrowColor: _kWarn,
      child: Wrap(
        spacing: 28,
        runSpacing: 28,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _Coin(
            label: 'Gold',
            face: const Color(0xFFFCD34D),
            shadow: const Color(0xFFB45309),
            value: '24',
          ),
          _Coin(
            label: 'Silver',
            face: const Color(0xFFE5E7EB),
            shadow: const Color(0xFF1F2937),
            value: '14',
          ),
          _Coin(
            label: 'Bronze',
            face: const Color(0xFFFBA74D),
            shadow: const Color(0xFF7C2D12),
            value: '6',
          ),
          _Coin(
            label: 'Platinum',
            face: const Color(0xFFCBD5E1),
            shadow: const Color(0xFF334155),
            value: '24',
          ),
          _Coin(
            label: 'Obsidian',
            face: const Color(0xFF1F2937),
            shadow: const Color(0xFF6D28D9),
            value: '24',
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _Coin extends StatelessWidget {
  const _Coin({
    required this.label,
    required this.face,
    required this.shadow,
    required this.value,
    this.textColor = _kInk,
  });
  final String label;
  final Color face;
  final Color shadow;
  final String value;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PhysicalModel(
          color: face,
          elevation: double.parse(value),
          shadowColor: shadow,
          shape: BoxShape.circle,
          child: SizedBox(
            width: 110,
            height: 110,
            child: Center(
              child: Text(
                label.substring(0, 1),
                style: TextStyle(
                  color: textColor,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  fontFamily: _kMono,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _Label(label, bold: true, size: 12),
        _Label('elev $value', size: 11, color: _kInkMute),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// RECIPE — PILLOW
// ---------------------------------------------------------------------------

class _RecipePillowSection extends StatelessWidget {
  const _RecipePillowSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipe',
      title: 'Soft pillow surfaces',
      subtitle:
          'Pair a low elevation with a generous BorderRadius and a tinted '
          'shadow color matching the surface for a soft "pillow" look.',
      eyebrowColor: _kInfo,
      child: Wrap(
        spacing: 22,
        runSpacing: 22,
        children: <Widget>[
          _Pillow(
            label: 'Lavender pillow',
            face: const Color(0xFFEDE9FE),
            shadow: const Color(0xFF7C3AED),
          ),
          _Pillow(
            label: 'Mint pillow',
            face: const Color(0xFFD1FAE5),
            shadow: const Color(0xFF059669),
          ),
          _Pillow(
            label: 'Apricot pillow',
            face: const Color(0xFFFFEDD5),
            shadow: const Color(0xFFD97706),
          ),
          _Pillow(
            label: 'Sky pillow',
            face: const Color(0xFFDBEAFE),
            shadow: const Color(0xFF2563EB),
          ),
          _Pillow(
            label: 'Rose pillow',
            face: const Color(0xFFFCE7F3),
            shadow: const Color(0xFFDB2777),
          ),
          _Pillow(
            label: 'Slate pillow',
            face: const Color(0xFFF1F5F9),
            shadow: const Color(0xFF334155),
          ),
        ],
      ),
    );
  }
}

class _Pillow extends StatelessWidget {
  const _Pillow({
    required this.label,
    required this.face,
    required this.shadow,
  });
  final String label;
  final Color face;
  final Color shadow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          PhysicalModel(
            color: face,
            elevation: 4,
            shadowColor: shadow,
            borderRadius: BorderRadius.circular(40),
            child: const SizedBox(width: 180, height: 110),
          ),
          const SizedBox(height: 8),
          _Label(label, bold: true, size: 11.5),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RECIPE — BUSINESS CARD
// ---------------------------------------------------------------------------

class _RecipeBusinessCardSection extends StatelessWidget {
  const _RecipeBusinessCardSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipe',
      title: 'A textured business card',
      subtitle:
          'Realistic resting elevation (≈ 4) on a 3.5×2 ratio. The interior '
          'uses standard Material text rather than additional PhysicalModels.',
      eyebrowColor: _kAccentAlt,
      child: Center(
        child: PhysicalModel(
          color: const Color(0xFF0F172A),
          elevation: 6,
          shadowColor: const Color(0xFF312E81),
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            width: 360,
            height: 220,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _kAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'P',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const Text(
                        'PhysicalModel · Co.',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 11,
                          fontFamily: _kMono,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Renée Eleva',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Principal Shadow Engineer',
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'renee@physical.dev',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontFamily: _kMono,
                        ),
                      ),
                      Text(
                        '+44 7700 900000',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontFamily: _kMono,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RECIPE — LAYERED RECEIPTS
// ---------------------------------------------------------------------------

class _RecipeLayeredReceiptsSection extends StatelessWidget {
  const _RecipeLayeredReceiptsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipe',
      title: 'Layered receipts',
      subtitle:
          'A short stack of paper-thin surfaces. Each receipt is its own '
          'PhysicalModel with elevation 1–3 — enough to suggest paper, not enough to feel heavy.',
      eyebrowColor: _kWarn,
      child: Center(
        child: SizedBox(
          width: 380,
          height: 260,
          child: Stack(
            children: <Widget>[
              _receipt(left: 30, top: 30, rotation: -math.pi / 48, elevation: 1.5),
              _receipt(left: 80, top: 50, rotation: math.pi / 72, elevation: 2),
              _receipt(left: 50, top: 80, rotation: -math.pi / 120, elevation: 3),
              _receipt(left: 100, top: 100, rotation: math.pi / 120, elevation: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receipt({
    required double left,
    required double top,
    required double rotation,
    required double elevation,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: rotation,
        child: PhysicalModel(
          color: const Color(0xFFFFFBEB),
          elevation: elevation,
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: 180,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 6,
                    color: const Color(0xFF92400E),
                  ),
                  const SizedBox(height: 6),
                  Container(width: 140, height: 4, color: _kRule),
                  const SizedBox(height: 4),
                  Container(width: 120, height: 4, color: _kRule),
                  const SizedBox(height: 4),
                  Container(width: 90, height: 4, color: _kRule),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(width: 30, height: 5, color: const Color(0xFF92400E)),
                      Container(width: 40, height: 5, color: const Color(0xFF92400E)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RECIPE — SLIP PAGES
// ---------------------------------------------------------------------------

class _RecipeSlipPagesSection extends StatelessWidget {
  const _RecipeSlipPagesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipe',
      title: 'Slip pages (a "deck" of pages)',
      subtitle:
          'Three pages slipping out of a folder, each elevated more than '
          'the one behind. The effect: a perfectly Material-correct depth ladder.',
      eyebrowColor: _kInfo,
      child: Center(
        child: SizedBox(
          width: 420,
          height: 260,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                child: PhysicalModel(
                  color: const Color(0xFFE2E8F0),
                  elevation: 1,
                  borderRadius: BorderRadius.circular(8),
                  child: const SizedBox(width: 280, height: 200),
                ),
              ),
              Positioned(
                left: 40,
                top: 20,
                child: PhysicalModel(
                  color: const Color(0xFFF8FAFC),
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: const SizedBox(width: 280, height: 200),
                ),
              ),
              Positioned(
                left: 80,
                top: 40,
                child: PhysicalModel(
                  color: Colors.white,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 280,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _kAccent,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(width: 240, height: 6, color: _kRule),
                          const SizedBox(height: 6),
                          Container(width: 200, height: 6, color: _kRule),
                          const SizedBox(height: 6),
                          Container(width: 220, height: 6, color: _kRule),
                          const SizedBox(height: 14),
                          Container(width: 100, height: 24, decoration: BoxDecoration(color: _kAccentSoft, borderRadius: BorderRadius.circular(6))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RECIPE — FLOOR PLAN TILES
// ---------------------------------------------------------------------------

class _RecipeFloorPlanSection extends StatelessWidget {
  const _RecipeFloorPlanSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipe',
      title: 'Floor-plan tiles',
      subtitle:
          'A simulated tile floor. Each cell is a low-elevation PhysicalModel — '
          'a tiny shadow seam makes the grid pop without drawing any borders.',
      eyebrowColor: _kGood,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: <Widget>[
              for (int row = 0; row < 4; row++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (int col = 0; col < 6; col++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: PhysicalModel(
                            color: _tileColor(row, col),
                            elevation: 2,
                            borderRadius: BorderRadius.circular(4),
                            shadowColor: const Color(0xFF000000),
                            child: const SizedBox(width: 48, height: 48),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _tileColor(int row, int col) {
    const List<Color> palette = <Color>[
      Color(0xFFFCD34D),
      Color(0xFFF87171),
      Color(0xFFA78BFA),
      Color(0xFF60A5FA),
      Color(0xFF34D399),
      Color(0xFFFBBF24),
    ];
    return palette[(row + col) % palette.length];
  }
}

// ---------------------------------------------------------------------------
// PHYSICAL SHAPE
// ---------------------------------------------------------------------------

class _PhysicalShapeSection extends StatelessWidget {
  const _PhysicalShapeSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'PhysicalShape',
      title: 'When BoxShape isn\'t enough',
      subtitle:
          'PhysicalShape takes a CustomClipper<Path> instead of a BoxShape, '
          'so the surface can be any silhouette you can describe with Path.',
      eyebrowColor: _kAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _MonoBlock(
            'const PhysicalShape({\n'
                '  Key? key,\n'
                '  required CustomClipper<Path> clipper,\n'
                '  Clip clipBehavior = Clip.none,\n'
                '  double elevation = 0.0,\n'
                '  required Color color,\n'
                '  Color shadowColor = const Color(0xFF000000),\n'
                '  Widget? child,\n'
                '});',
            caption: 'PhysicalShape signature',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: <Widget>[
              _ShapeDemo(
                label: 'Notch (BAB style)',
                clipper: const _NotchClipper(),
                color: const Color(0xFFEDE9FE),
              ),
              _ShapeDemo(
                label: 'Scallop',
                clipper: const _ScallopClipper(),
                color: const Color(0xFFFCE7F3),
              ),
              _ShapeDemo(
                label: 'Dog-ear',
                clipper: const _DogEarClipper(),
                color: const Color(0xFFFEF3C7),
              ),
              _ShapeDemo(
                label: 'Arrow tag',
                clipper: const _ArrowTagClipper(),
                color: const Color(0xFFDBEAFE),
              ),
              _ShapeDemo(
                label: 'Hex',
                clipper: const _HexClipper(),
                color: const Color(0xFFD1FAE5),
              ),
              _ShapeDemo(
                label: 'Wave',
                clipper: const _WaveClipper(),
                color: const Color(0xFFCFFAFE),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _Callout(
            tone: _kInfo,
            icon: 'i',
            title: 'Why PhysicalShape is special',
            body:
                'The shadow is computed from the same Path that clips the child. '
                'You don\'t get a rectangular shadow under a notched silhouette — '
                'you get a notched shadow. This is the only easy way to produce '
                'correctly-shaped shadows for non-rectangular surfaces.',
          ),
        ],
      ),
    );
  }
}

class _ShapeDemo extends StatelessWidget {
  const _ShapeDemo({
    required this.label,
    required this.clipper,
    required this.color,
  });
  final String label;
  final CustomClipper<Path> clipper;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          PhysicalShape(
            color: color,
            elevation: 10,
            clipper: clipper,
            child: const SizedBox(width: 180, height: 110),
          ),
          const SizedBox(height: 10),
          _Label(label, bold: true, size: 11.5),
        ],
      ),
    );
  }
}

class _NotchClipper extends CustomClipper<Path> {
  const _NotchClipper();
  @override
  Path getClip(Size size) {
    final Path path = Path();
    const double notchRadius = 28;
    final double cx = size.width / 2;
    path.moveTo(0, 14);
    path.quadraticBezierTo(0, 0, 14, 0);
    path.lineTo(cx - notchRadius - 6, 0);
    path.quadraticBezierTo(cx - notchRadius, 0, cx - notchRadius, 6);
    path.arcToPoint(
      Offset(cx + notchRadius, 6),
      radius: const Radius.circular(28),
      clockwise: false,
    );
    path.quadraticBezierTo(cx + notchRadius, 0, cx + notchRadius + 6, 0);
    path.lineTo(size.width - 14, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 14);
    path.lineTo(size.width, size.height - 14);
    path.quadraticBezierTo(size.width, size.height, size.width - 14, size.height);
    path.lineTo(14, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 14);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _ScallopClipper extends CustomClipper<Path> {
  const _ScallopClipper();
  @override
  Path getClip(Size size) {
    const int bumps = 6;
    final double bumpW = size.width / bumps;
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 12);
    for (int i = bumps; i > 0; i--) {
      final double cx = (i - 0.5) * bumpW;
      final double leftX = i * bumpW;
      path.arcToPoint(
        Offset(leftX - bumpW, size.height - 12),
        radius: Radius.circular(bumpW / 2),
        clockwise: false,
      );
    }
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _DogEarClipper extends CustomClipper<Path> {
  const _DogEarClipper();
  @override
  Path getClip(Size size) {
    const double ear = 26;
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - ear, 0);
    path.lineTo(size.width, ear);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _ArrowTagClipper extends CustomClipper<Path> {
  const _ArrowTagClipper();
  @override
  Path getClip(Size size) {
    const double tip = 22;
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - tip, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - tip, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _HexClipper extends CustomClipper<Path> {
  const _HexClipper();
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    final double inset = w * 0.18;
    final Path path = Path();
    path.moveTo(inset, 0);
    path.lineTo(w - inset, 0);
    path.lineTo(w, h / 2);
    path.lineTo(w - inset, h);
    path.lineTo(inset, h);
    path.lineTo(0, h / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _WaveClipper extends CustomClipper<Path> {
  const _WaveClipper();
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 18);
    // Build a small sine-like wave with two control points.
    final double midY = size.height - 18;
    final double w = size.width;
    path.cubicTo(
      w * 0.75, midY + 26,
      w * 0.25, midY - 26,
      0, midY,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ---------------------------------------------------------------------------
// COMPARISON — vs Material
// ---------------------------------------------------------------------------

class _ComparisonMaterialSection extends StatelessWidget {
  const _ComparisonMaterialSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Comparison',
      title: 'PhysicalModel vs Material',
      subtitle:
          'Both raise a surface. Material adds theme integration, surface tint, '
          'and ink reactions; PhysicalModel does only the physical part.',
      eyebrowColor: _kInfoSoft == _kInfoSoft ? _kInfo : _kInfo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _SideBySidePane(
                  title: 'PhysicalModel',
                  caption: 'Bare slab — no ripple, no theme',
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 8,
                    borderRadius: BorderRadius.circular(14),
                    child: const SizedBox(width: 220, height: 130),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _SideBySidePane(
                  title: 'Material',
                  caption: 'Slab + theme + tint + ink hooks',
                  child: Material(
                    color: Colors.white,
                    elevation: 8,
                    borderRadius: BorderRadius.circular(14),
                    child: const SizedBox(width: 220, height: 130),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _TwoColumnTable(
            headers: const <String>['Feature', 'Where each wins'],
            rows: const <List<String>>[
              <String>['Shadow', 'Both. Identical elevation math.'],
              <String>[
                'Surface tint (M3)',
                'Material only. PhysicalModel does not apply elevation overlays.',
              ],
              <String>[
                'InkWell ripple',
                'Material only. InkWell requires a Material ancestor.',
              ],
              <String>[
                'Theme defaults',
                'Material picks up colorScheme.surface; PhysicalModel needs an explicit color.',
              ],
              <String>[
                'Cost',
                'PhysicalModel is cheaper — fewer layers, no surface tint overlay.',
              ],
              <String>[
                'Use it for',
                'PhysicalModel: design-system primitives. Material: anything interactive.',
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _SideBySidePane extends StatelessWidget {
  const _SideBySidePane({
    required this.title,
    required this.caption,
    required this.child,
  });
  final String title;
  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: _kRuleSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _kInk,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            caption,
            style: const TextStyle(color: _kInkMute, fontSize: 12),
          ),
          const SizedBox(height: 14),
          SizedBox(height: 170, child: Center(child: child)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// COMPARISON — vs Container + BoxShadow
// ---------------------------------------------------------------------------

class _ComparisonContainerSection extends StatelessWidget {
  const _ComparisonContainerSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Comparison',
      title: 'PhysicalModel vs Container + BoxShadow',
      subtitle:
          'Container with a BoxShadow looks similar, but the shadow is an '
          'arbitrary drawing rather than an elevation primitive.',
      eyebrowColor: _kAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _SideBySidePane(
                  title: 'PhysicalModel(elevation: 12)',
                  caption: 'Elevation-driven; matches Material spec',
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 12,
                    borderRadius: BorderRadius.circular(14),
                    child: const SizedBox(width: 220, height: 130),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _SideBySidePane(
                  title: 'Container + BoxShadow',
                  caption: 'Manually authored shadow; full creative control',
                  child: Container(
                    width: 220,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 22,
                          spreadRadius: -4,
                          offset: const Offset(0, 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _TwoColumnTable(
            headers: const <String>['Aspect', 'PhysicalModel vs Container+BoxShadow'],
            rows: const <List<String>>[
              <String>[
                'Shadow source',
                'PhysicalModel uses the Material elevation math; Container uses BoxShadow you authored.',
              ],
              <String>[
                'Shape',
                'PhysicalModel clips its child to the shape and produces a matching shadow. '
                    'Container clips with a separate ClipRRect/ClipOval if needed.',
              ],
              <String>[
                'Consistency',
                'PhysicalModel is theme-friendly; BoxShadow needs to be tuned per design.',
              ],
              <String>[
                'Performance',
                'PhysicalModel is usually cheaper for many surfaces because the shadow is a '
                    'cached layer; many BoxShadows can be heavier.',
              ],
              <String>[
                'Flexibility',
                'BoxShadow can do colored, multi-layered, inset-style shadows. PhysicalModel only does one shadow.',
              ],
            ],
          ),
          const SizedBox(height: 12),
          const _Callout(
            tone: _kWarn,
            icon: '!',
            title: 'Rule of thumb',
            body:
                'If the surface participates in a Material elevation system, use PhysicalModel/Material. '
                'If you need creative, non-Material shadows (insets, glows, multi-layer), use Container + BoxShadow.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// GLOSSARY
// ---------------------------------------------------------------------------

class _GlossarySection extends StatelessWidget {
  const _GlossarySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Glossary',
      title: 'Terms used in this dossier',
      subtitle:
          'Every term that came up — defined once, in one place, so you can '
          'come back to this section if any vocabulary felt overloaded.',
      eyebrowColor: _kInfo,
      child: Column(
        children: const <Widget>[
          _GlossaryEntry(
            term: 'Elevation',
            body:
                'A unitless logical z-distance from the page. Drives the shadow '
                'blur radius, spread, and vertical offset. Must be ≥ 0.',
          ),
          _GlossaryEntry(
            term: 'Shadow',
            body:
                'A soft, downward-cast darker shape painted underneath the surface, '
                'computed from the elevation and the surface\'s clip silhouette.',
          ),
          _GlossaryEntry(
            term: 'Shape',
            body:
                'How the surface looks: BoxShape.rectangle (default) or BoxShape.circle. '
                'PhysicalShape extends this to arbitrary Paths via CustomClipper.',
          ),
          _GlossaryEntry(
            term: 'BorderRadius',
            body:
                'Per-corner curvature for the rectangle shape. BorderRadius.zero, '
                'circular(n), only(...), vertical(...), horizontal(...), or elliptical(...).',
          ),
          _GlossaryEntry(
            term: 'ClipBehavior',
            body:
                'Clip.none / hardEdge / antiAlias / antiAliasWithSaveLayer — '
                'increasing levels of quality, increasing layer cost.',
          ),
          _GlossaryEntry(
            term: 'PhysicalShape',
            body:
                'Sibling widget that takes a CustomClipper<Path> for arbitrary silhouettes. '
                'The cast shadow follows the same path used to clip the child.',
          ),
          _GlossaryEntry(
            term: 'CustomClipper',
            body:
                'Strategy object that returns a Path defining the surface silhouette. '
                'Implement getClip(Size) and shouldReclip(oldClipper).',
          ),
          _GlossaryEntry(
            term: 'Material',
            body:
                'Higher-level surface widget that wraps PhysicalModel and adds theme, '
                'surface tint, InkWell hooks, and animated elevation transitions.',
          ),
          _GlossaryEntry(
            term: 'AnimatedPhysicalModel',
            body:
                'Implicit-animation wrapper for PhysicalModel: changes to elevation, '
                'color, borderRadius, etc. interpolate over a Duration with a Curve.',
          ),
          _GlossaryEntry(
            term: 'BoxShadow',
            body:
                'A drawing primitive for Container.decoration — fully authored '
                '(blurRadius, spreadRadius, offset, color). Not bound to elevation tables.',
          ),
        ],
      ),
    );
  }
}

class _GlossaryEntry extends StatelessWidget {
  const _GlossaryEntry({required this.term, required this.body});
  final String term;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              term,
              style: const TextStyle(
                color: _kAccent,
                fontFamily: _kMono,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              body,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 13.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RECAP
// ---------------------------------------------------------------------------

class _RecapSection extends StatelessWidget {
  const _RecapSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recap',
      title: 'Everything you need to remember',
      subtitle:
          'The whole demo, distilled to a few load-bearing claims.',
      eyebrowColor: _kGood,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _RecapBullet(
            n: '01',
            text:
                'PhysicalModel is a surface primitive: color + elevation shadow + '
                'optional clip. It is the bare physics under Material and Card.',
          ),
          _RecapBullet(
            n: '02',
            text:
                'Six knobs to know: color (required, opaque), elevation (≥ 0), '
                'shape (rect/circle), borderRadius (rect only), clipBehavior, shadowColor.',
          ),
          _RecapBullet(
            n: '03',
            text:
                'The Material elevation ladder runs 0, 1, 2, 4, 6, 8, 12, 16, 24. '
                'Each step has a well-known semantic role.',
          ),
          _RecapBullet(
            n: '04',
            text:
                'BoxShape.circle ignores borderRadius and asserts if you pass one. '
                'Use BoxShape.rectangle with a large radius for capsules.',
          ),
          _RecapBullet(
            n: '05',
            text:
                'clipBehavior trades cost for smoothness: none < hardEdge < antiAlias '
                '< antiAliasWithSaveLayer.',
          ),
          _RecapBullet(
            n: '06',
            text:
                'shadowColor tints the shadow. Use sparingly — soft tints feel branded, '
                'loud tints feel artificial.',
          ),
          _RecapBullet(
            n: '07',
            text:
                'PhysicalShape unlocks arbitrary silhouettes via CustomClipper<Path> '
                'and casts a path-shaped shadow.',
          ),
          _RecapBullet(
            n: '08',
            text:
                'Prefer Material for anything interactive (ink ripple, surface tint). '
                'Prefer PhysicalModel for theme-free design-system primitives.',
          ),
          _RecapBullet(
            n: '09',
            text:
                'Container + BoxShadow gives more creative control (insets, multi-layer), '
                'but PhysicalModel matches the Material spec for free.',
          ),
          _RecapBullet(
            n: '10',
            text:
                'For animated elevation/shape/color transitions, reach for '
                'AnimatedPhysicalModel — it is the implicit-animation sibling.',
          ),
        ],
      ),
    );
  }
}

class _RecapBullet extends StatelessWidget {
  const _RecapBullet({required this.n, required this.text});
  final String n;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _kAccentSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              n,
              style: const TextStyle(
                color: _kAccent,
                fontFamily: _kMono,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                text,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'P',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'PhysicalModel · Deep Visual Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Hand-authored. Static. Replayable.',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ],
            ),
          ),
          const Text(
            'package:flutter/widgets.dart',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 11,
              fontFamily: _kMono,
            ),
          ),
        ],
      ),
    );
  }
}
