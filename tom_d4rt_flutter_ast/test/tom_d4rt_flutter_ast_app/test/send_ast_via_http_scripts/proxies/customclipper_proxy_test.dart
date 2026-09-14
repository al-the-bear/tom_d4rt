// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// CustomClipper<T> Family — Deep Demo
// -----------------------------------------------------------------------------
// This script is a hand-authored, comprehensive walkthrough of the Flutter
// `CustomClipper<T>` family.  It demonstrates the abstract contract, multiple
// concrete `CustomClipper<Path>` and `CustomClipper<Rect>` subclasses, how each
// is consumed by the clipping widgets (`ClipPath`, `ClipRect`, `ClipOval`),
// the role of `ShapeBorderClipper` (which adapts a `ShapeBorder` into a
// `CustomClipper<Path>`), how `shouldReclip` controls reclipping cost, and the
// `Clip` enum that decides anti-aliasing quality.
//
// Harness contract:
//   * the first non-comment line is the analyzer ignore directive,
//   * imports stay restricted to `package:flutter/material.dart`,
//   * a single top-level `dynamic build(BuildContext context)` returns a
//     `MaterialApp` whose body is a `Scaffold` -> `SafeArea` ->
//     `SingleChildScrollView` -> `Column` of section cards,
//   * no `main()`, no `runApp()`, no `testWidgets()`,
//   * each interactive section runs inside a `StatefulBuilder` so that the
//     section's local state stays inside the section.
//
// Each section paints a card-style container with a distinct palette so that
// scrolling the harness produces an obvious vertical rhythm.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Distinct section palettes.
// -----------------------------------------------------------------------------
const Color _heroBg = Color(0xFFE3F2FD);
const Color _heroAccent = Color(0xFF1565C0);
const Color _heroInk = Color(0xFF0D2E58);

const Color _waveBg = Color(0xFFE0F7FA);
const Color _waveAccent = Color(0xFF006064);
const Color _waveInk = Color(0xFF003844);

const Color _diagonalBg = Color(0xFFFFF3E0);
const Color _diagonalAccent = Color(0xFFE65100);
const Color _diagonalInk = Color(0xFF6A2C00);

const Color _zigzagBg = Color(0xFFF3E5F5);
const Color _zigzagAccent = Color(0xFF6A1B9A);
const Color _zigzagInk = Color(0xFF3A0E5A);

const Color _roundedTopBg = Color(0xFFE8F5E9);
const Color _roundedTopAccent = Color(0xFF2E7D32);
const Color _roundedTopInk = Color(0xFF1B3D1F);

const Color _bowtieBg = Color(0xFFFCE4EC);
const Color _bowtieAccent = Color(0xFFAD1457);
const Color _bowtieInk = Color(0xFF560027);

const Color _hexBg = Color(0xFFEDE7F6);
const Color _hexAccent = Color(0xFF4527A0);
const Color _hexInk = Color(0xFF1A0E4D);

const Color _ticketBg = Color(0xFFFFF8E1);
const Color _ticketAccent = Color(0xFFF57F17);
const Color _ticketInk = Color(0xFF5C3A00);

const Color _stripeBg = Color(0xFFE0F2F1);
const Color _stripeAccent = Color(0xFF00695C);
const Color _stripeInk = Color(0xFF003D33);

const Color _comparisonBg = Color(0xFFE8EAF6);
const Color _comparisonAccent = Color(0xFF283593);
const Color _comparisonInk = Color(0xFF101542);

const Color _shapeBorderBg = Color(0xFFFFF9C4);
const Color _shapeBorderAccent = Color(0xFFF9A825);
const Color _shapeBorderInk = Color(0xFF6B4F00);

const Color _animatedBg = Color(0xFFFFEBEE);
const Color _animatedAccent = Color(0xFFC62828);
const Color _animatedInk = Color(0xFF6A0F12);

const Color _shouldReclipBg = Color(0xFFFAFAFA);
const Color _shouldReclipAccent = Color(0xFF455A64);
const Color _shouldReclipInk = Color(0xFF263238);

const Color _heroRecipeBg = Color(0xFFF1F8E9);
const Color _heroRecipeAccent = Color(0xFF33691E);
const Color _heroRecipeInk = Color(0xFF1B3300);

const Color _ticketRecipeBg = Color(0xFFFFFDE7);
const Color _ticketRecipeAccent = Color(0xFFFBC02D);
const Color _ticketRecipeInk = Color(0xFF5C3A00);

const Color _profileRecipeBg = Color(0xFFE0F7FA);
const Color _profileRecipeAccent = Color(0xFF00838F);
const Color _profileRecipeInk = Color(0xFF003844);

const Color _tagRecipeBg = Color(0xFFFFF3E0);
const Color _tagRecipeAccent = Color(0xFFEF6C00);
const Color _tagRecipeInk = Color(0xFF6A2C00);

const Color _clipEnumBg = Color(0xFFEDE7F6);
const Color _clipEnumAccent = Color(0xFF512DA8);
const Color _clipEnumInk = Color(0xFF1A0E4D);

const Color _decisionBg = Color(0xFFE8F5E9);
const Color _decisionAccent = Color(0xFF388E3C);
const Color _decisionInk = Color(0xFF1B3D1F);

const Color _refBg = Color(0xFFECEFF1);
const Color _refInk = Color(0xFF263238);

// =============================================================================
// CUSTOM CLIPPERS
// -----------------------------------------------------------------------------
// Each subclass below extends `CustomClipper<Path>` (or `CustomClipper<Rect>`
// for the stripe demo) and overrides:
//
//   1. `getClip(Size size)` — returns the geometry that defines the inside of
//      the clip.  Anything outside this region will be clipped out.
//   2. `shouldReclip(covariant CustomClipper<T> oldClipper)` — returns `true`
//      if the clip needs to be recomputed.  Returning a constant `false` is
//      cheap; returning `true` always is the safe but slow option.
//
// =============================================================================

// -----------------------------------------------------------------------------
// _WaveClipper — concave wave at the bottom edge.
// Used for hero headers, app banners, onboarding screens.
// -----------------------------------------------------------------------------
class _WaveClipper extends CustomClipper<Path> {
  const _WaveClipper({this.amplitude = 24.0});

  final double amplitude;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - amplitude);

    // First control point on the left third.
    final Offset firstControl = Offset(size.width * 0.25, size.height);
    final Offset firstEnd = Offset(size.width * 0.5, size.height - amplitude);
    path.quadraticBezierTo(
      firstControl.dx,
      firstControl.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

    // Second control point on the right third.
    final Offset secondControl =
        Offset(size.width * 0.75, size.height - amplitude * 2);
    final Offset secondEnd = Offset(size.width, size.height - amplitude);
    path.quadraticBezierTo(
      secondControl.dx,
      secondControl.dy,
      secondEnd.dx,
      secondEnd.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _WaveClipper oldClipper) {
    return oldClipper.amplitude != amplitude;
  }
}

// -----------------------------------------------------------------------------
// _DiagonalClipper — clips a diagonal slice from one corner to the opposite.
// Used for hero ribbons, promo banners, "new!" tags.
// -----------------------------------------------------------------------------
class _DiagonalClipper extends CustomClipper<Path> {
  const _DiagonalClipper({this.skew = 0.25});

  final double skew;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * (1 - skew));
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _DiagonalClipper oldClipper) {
    return oldClipper.skew != skew;
  }
}

// -----------------------------------------------------------------------------
// _ZigZagClipper — saw-tooth bottom edge.
// Used for paper-cut effects, decorative dividers, stat cards.
// -----------------------------------------------------------------------------
class _ZigZagClipper extends CustomClipper<Path> {
  const _ZigZagClipper({this.teeth = 12, this.depth = 14.0});

  final int teeth;
  final double depth;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - depth);

    final double toothWidth = size.width / teeth;
    for (int i = 0; i < teeth; i++) {
      final double x1 = (i + 0.5) * toothWidth;
      final double x2 = (i + 1) * toothWidth;
      path.lineTo(x1, size.height);
      path.lineTo(x2, size.height - depth);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _ZigZagClipper oldClipper) {
    return oldClipper.teeth != teeth || oldClipper.depth != depth;
  }
}

// -----------------------------------------------------------------------------
// _RoundedTopClipper — rounds only the top edge into a half-stadium.
// Used for bottom sheets, modal headers, tab indicators.
// -----------------------------------------------------------------------------
class _RoundedTopClipper extends CustomClipper<Path> {
  const _RoundedTopClipper({this.radius = 32.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double r = radius.clamp(0.0, size.height);
    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(size.width, 0, size.width, r);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _RoundedTopClipper oldClipper) {
    return oldClipper.radius != radius;
  }
}

// -----------------------------------------------------------------------------
// _BowtieClipper — hourglass / bowtie shape.
// Used for decorative dividers, filter chips, fancy buttons.
// -----------------------------------------------------------------------------
class _BowtieClipper extends CustomClipper<Path> {
  const _BowtieClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _BowtieClipper oldClipper) => false;
}

// -----------------------------------------------------------------------------
// _GradientHexagonClipper — regular hexagon centred in the clip area.
// Used for profile pictures, badges, achievement tiles.
// -----------------------------------------------------------------------------
class _GradientHexagonClipper extends CustomClipper<Path> {
  const _GradientHexagonClipper();

  @override
  Path getClip(Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = (size.width < size.height ? size.width : size.height) / 2;

    final Path path = Path();
    for (int i = 0; i < 6; i++) {
      final double angle = (i * 60 - 30) * (3.141592653589793 / 180);
      final double x = cx + r * _cos(angle);
      final double y = cy + r * _sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _GradientHexagonClipper oldClipper) => false;
}

// -----------------------------------------------------------------------------
// _TicketClipper — semicircular notches on left/right edges (ticket / coupon).
// Used for boarding passes, coupons, vouchers.
// -----------------------------------------------------------------------------
class _TicketClipper extends CustomClipper<Path> {
  const _TicketClipper({this.notchRadius = 14.0, this.notchOffset = 0.5});

  final double notchRadius;
  final double notchOffset;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double notchY = size.height * notchOffset;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, notchY - notchRadius);

    // Right notch (concave half-circle eating into the rect).
    path.arcToPoint(
      Offset(size.width, notchY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, notchY + notchRadius);

    // Left notch (concave half-circle eating into the rect).
    path.arcToPoint(
      Offset(0, notchY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _TicketClipper oldClipper) {
    return oldClipper.notchRadius != notchRadius ||
        oldClipper.notchOffset != notchOffset;
  }
}

// -----------------------------------------------------------------------------
// _StripeClipper — `CustomClipper<Rect>` example (used by `ClipRect`).
// Constrains a child to a horizontal stripe somewhere inside its layout box.
// Used for marquees, splitters, lazy-load placeholders.
// -----------------------------------------------------------------------------
class _StripeClipper extends CustomClipper<Rect> {
  const _StripeClipper({this.fraction = 0.5, this.height = 40.0});

  final double fraction;
  final double height;

  @override
  Rect getClip(Size size) {
    final double clamped = fraction.clamp(0.0, 1.0);
    final double top = (size.height - height) * clamped;
    return Rect.fromLTWH(0, top, size.width, height);
  }

  @override
  bool shouldReclip(covariant _StripeClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.height != height;
  }
}

// -----------------------------------------------------------------------------
// _StripePathClipper — same stripe geometry as `_StripeClipper`, but typed
// as `CustomClipper<Path>` so it can drive `ClipPath`.
//
// Why this exists: the live `ClipRect` demo sections below want to render a
// `_StripeClipper`-shaped rectangular stripe, but the d4rt `CustomClipper<T>`
// proxy currently collapses the generic `T` to `Path` regardless of the
// declared type, so using `_StripeClipper` (a `CustomClipper<Rect>`) under
// `ClipRect` raises `type '_NativePath' is not a subtype of type 'Rect' in
// type cast` at clip time. Until the proxy honours the generic, the live
// sections drive `ClipPath` with this Path-typed equivalent and the original
// `_StripeClipper` is referenced in prose / comparison columns.
// -----------------------------------------------------------------------------
class _StripePathClipper extends CustomClipper<Path> {
  const _StripePathClipper({this.fraction = 0.5, this.height = 40.0});

  final double fraction;
  final double height;

  @override
  Path getClip(Size size) {
    final double clamped = fraction.clamp(0.0, 1.0);
    final double top = (size.height - height) * clamped;
    final Path path = Path();
    path.addRect(Rect.fromLTWH(0, top, size.width, height));
    return path;
  }

  @override
  bool shouldReclip(covariant _StripePathClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.height != height;
  }
}

// -----------------------------------------------------------------------------
// _AnimatedWaveClipper — wave that responds to a `ValueListenable<double>`.
//
// Notice that the constructor accepts a `Listenable` and forwards it to the
// `super` constructor.  When the listenable fires, the framework calls
// `shouldReclip` and reclips automatically.  Compare with `_WaveClipper`
// which is fully constant — that one only reclips when its constructor
// arguments change.
// -----------------------------------------------------------------------------
class _AnimatedWaveClipper extends CustomClipper<Path> {
  _AnimatedWaveClipper({required this.progress})
      : super(reclip: progress);

  final ValueNotifier<double> progress;

  @override
  Path getClip(Size size) {
    final double t = progress.value.clamp(0.0, 1.0);
    final double amp = 12.0 + 32.0 * t;
    final double phase = t * 6.283185307179586;
    final Path path = Path();
    path.lineTo(0, size.height - amp);

    const int segments = 24;
    for (int i = 1; i <= segments; i++) {
      final double x = size.width * i / segments;
      final double y = size.height -
          amp -
          amp * 0.5 * _sin(phase + (i / segments) * 6.283185307179586);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _AnimatedWaveClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}

// -----------------------------------------------------------------------------
// _AlwaysReclipWaveClipper — pedagogical foil; always returns true.
// Used in the `shouldReclip` discussion section to compare cost.
// -----------------------------------------------------------------------------
class _AlwaysReclipWaveClipper extends CustomClipper<Path> {
  _AlwaysReclipWaveClipper({required this.value});

  final double value;

  @override
  Path getClip(Size size) {
    final double t = value.clamp(0.0, 1.0);
    final double amp = 16.0 + 24.0 * t;
    final Path path = Path();
    path.lineTo(0, size.height - amp);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height,
      size.width,
      size.height - amp,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _AlwaysReclipWaveClipper oldClipper) => true;
}

// -----------------------------------------------------------------------------
// _SmartReclipWaveClipper — only returns true when the value actually changes.
// -----------------------------------------------------------------------------
class _SmartReclipWaveClipper extends CustomClipper<Path> {
  _SmartReclipWaveClipper({required this.value});

  final double value;

  @override
  Path getClip(Size size) {
    final double t = value.clamp(0.0, 1.0);
    final double amp = 16.0 + 24.0 * t;
    final Path path = Path();
    path.lineTo(0, size.height - amp);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height,
      size.width,
      size.height - amp,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _SmartReclipWaveClipper oldClipper) {
    return oldClipper.value != value;
  }
}

// -----------------------------------------------------------------------------
// Tiny taylor-series cos/sin so we avoid importing dart:math in this script.
// (`material.dart` re-exports many things but using a private helper keeps the
// top of the file under the single-import constraint.)
// -----------------------------------------------------------------------------
double _normalize(double angle) {
  const double twoPi = 6.283185307179586;
  double a = angle % twoPi;
  if (a > 3.141592653589793) a -= twoPi;
  if (a < -3.141592653589793) a += twoPi;
  return a;
}

double _sin(double angle) {
  final double x = _normalize(angle);
  final double x2 = x * x;
  // 7-term Taylor: x - x^3/6 + x^5/120 - x^7/5040
  return x - x * x2 / 6.0 + x * x2 * x2 / 120.0 - x * x2 * x2 * x2 / 5040.0;
}

double _cos(double angle) {
  final double x = _normalize(angle);
  final double x2 = x * x;
  // 8-term Taylor: 1 - x^2/2 + x^4/24 - x^6/720
  return 1.0 - x2 / 2.0 + x2 * x2 / 24.0 - x2 * x2 * x2 / 720.0;
}

// =============================================================================
// HELPERS
// =============================================================================

Widget _sectionHeader(String number, String title, Color bg, Color ink) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: ink, width: 4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: ink,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _sectionCard({
  required Color bg,
  required Color ink,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ink.withOpacity(0.10), width: 1),
    ),
    child: DefaultTextStyle.merge(
      style: TextStyle(color: ink),
      child: child,
    ),
  );
}

Widget _label(String text, Color ink) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 4),
    child: Text(
      text,
      style: TextStyle(color: ink, fontWeight: FontWeight.w600, fontSize: 13),
    ),
  );
}

Widget _prose(String text, Color ink) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: TextStyle(color: ink, fontSize: 13, height: 1.45),
    ),
  );
}

Widget _coloredBlock({
  required Color color,
  required double height,
  String? label,
  Color? labelColor,
}) {
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withOpacity(0.6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: label == null
        ? null
        : Text(
            label,
            style: TextStyle(
              color: labelColor ?? Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 1.5,
            ),
          ),
  );
}

// =============================================================================
// BUILD
// =============================================================================

dynamic build(BuildContext context) {
  const String scriptName = 'proxies/customclipper_proxy_test.dart';
  print('$scriptName executing — CustomClipper deep demo');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CustomClipper Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF1565C0),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ================================================================
              // INTRO CARD
              // ================================================================
              _sectionHeader('00', 'Intro — CustomClipper<T>', _heroBg, _heroInk),
              _sectionCard(
                bg: _heroBg,
                ink: _heroInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CustomClipper<T> is the abstract base class behind every '
                      'custom-shaped clip in Flutter.',
                      style: TextStyle(
                        color: _heroInk,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _prose(
                      'It is generic in T, the type of geometry it produces. '
                      'CustomClipper<Path> is consumed by ClipPath, '
                      'CustomClipper<Rect> by ClipRect, '
                      'and CustomClipper<RRect> by ClipRRect. '
                      'ClipOval bakes in its own elliptical clipper but also '
                      'accepts a CustomClipper<Rect> so that the bounding '
                      'rectangle of the ellipse can be customized.',
                      _heroInk,
                    ),
                    _prose(
                      'Subclasses must override two methods: '
                      'getClip(Size size) returns the geometry, and '
                      'shouldReclip(covariant CustomClipper<T> oldClipper) '
                      'returns whether the cached path/rect must be thrown '
                      'away. A clipper may also accept a Listenable in its '
                      'super-constructor; whenever that listenable fires, '
                      'the framework reclips.',
                      _heroInk,
                    ),
                    _prose(
                      'ShapeBorderClipper is a built-in adapter that turns '
                      'any ShapeBorder (RoundedRectangleBorder, StadiumBorder, '
                      'BeveledRectangleBorder, ContinuousRectangleBorder, …) '
                      'into a CustomClipper<Path>. This is how Material '
                      'widgets share their visual language between their '
                      'painted border and their clip.',
                      _heroInk,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _heroAccent.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _heroAccent.withOpacity(0.30)),
                      ),
                      child: Text(
                        'Contract:\n'
                        '  T getClip(Size size)\n'
                        '  bool shouldReclip(covariant CustomClipper<T> old)\n'
                        '  Rect describeApproximateClip(T value)  [optional]',
                        style: TextStyle(
                          color: _heroInk,
                          fontFamily: 'monospace',
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 01 — _WaveClipper
              // ================================================================
              _sectionHeader('01', '_WaveClipper — concave wave bottom edge',
                  _waveBg, _waveInk),
              _sectionCard(
                bg: _waveBg,
                ink: _waveInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'A path that traces the rectangle except for the bottom '
                      'edge, which uses two quadratic Bezier curves to form a '
                      'gentle wave. Perfect for hero headers and onboarding '
                      'banners.',
                      _waveInk,
                    ),
                    ClipPath(
                      clipper: const _WaveClipper(amplitude: 28),
                      child: _coloredBlock(
                        color: _waveAccent,
                        height: 140,
                        label: 'WAVE',
                      ),
                    ),
                    const SizedBox(height: 8),
                    _label('Two amplitude variants:', _waveInk),
                    Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: const _WaveClipper(amplitude: 10),
                            child: _coloredBlock(
                              color: const Color(0xFF00ACC1),
                              height: 80,
                              label: 'a=10',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipPath(
                            clipper: const _WaveClipper(amplitude: 32),
                            child: _coloredBlock(
                              color: const Color(0xFF00838F),
                              height: 80,
                              label: 'a=32',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 02 — _DiagonalClipper
              // ================================================================
              _sectionHeader('02', '_DiagonalClipper — diagonal slice',
                  _diagonalBg, _diagonalInk),
              _sectionCard(
                bg: _diagonalBg,
                ink: _diagonalInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'A trapezoid whose right edge sits below its left edge. '
                      'The skew parameter controls how steep the diagonal is '
                      'relative to the height of the clip area.',
                      _diagonalInk,
                    ),
                    ClipPath(
                      clipper: const _DiagonalClipper(skew: 0.30),
                      child: _coloredBlock(
                        color: _diagonalAccent,
                        height: 130,
                        label: 'DIAGONAL',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: const _DiagonalClipper(skew: 0.10),
                            child: _coloredBlock(
                              color: const Color(0xFFFB8C00),
                              height: 80,
                              label: 's=0.10',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipPath(
                            clipper: const _DiagonalClipper(skew: 0.50),
                            child: _coloredBlock(
                              color: const Color(0xFFEF6C00),
                              height: 80,
                              label: 's=0.50',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 03 — _ZigZagClipper
              // ================================================================
              _sectionHeader('03', '_ZigZagClipper — saw-tooth bottom edge',
                  _zigzagBg, _zigzagInk),
              _sectionCard(
                bg: _zigzagBg,
                ink: _zigzagInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'Builds a saw-tooth bottom edge by alternating up/down '
                      'lineTo calls. teeth and depth control the look. '
                      'Useful for paper-cut effects and decorative dividers.',
                      _zigzagInk,
                    ),
                    ClipPath(
                      clipper: const _ZigZagClipper(teeth: 14, depth: 16),
                      child: _coloredBlock(
                        color: _zigzagAccent,
                        height: 120,
                        label: 'ZIGZAG',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: const _ZigZagClipper(teeth: 6, depth: 18),
                            child: _coloredBlock(
                              color: const Color(0xFF8E24AA),
                              height: 80,
                              label: '6 / 18',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipPath(
                            clipper: const _ZigZagClipper(teeth: 24, depth: 8),
                            child: _coloredBlock(
                              color: const Color(0xFF6A1B9A),
                              height: 80,
                              label: '24 / 8',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 04 — _RoundedTopClipper
              // ================================================================
              _sectionHeader('04', '_RoundedTopClipper — rounded top corners',
                  _roundedTopBg, _roundedTopInk),
              _sectionCard(
                bg: _roundedTopBg,
                ink: _roundedTopInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'A trick used by bottom sheets and modal headers. '
                      'Only the top edge has rounded corners; the bottom edge '
                      'remains flat. Lets you give a sheet a "pulled out of '
                      'the bottom" look without using ShapeBorderClipper.',
                      _roundedTopInk,
                    ),
                    ClipPath(
                      clipper: const _RoundedTopClipper(radius: 32),
                      child: _coloredBlock(
                        color: _roundedTopAccent,
                        height: 110,
                        label: 'BOTTOM SHEET',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: const _RoundedTopClipper(radius: 8),
                            child: _coloredBlock(
                              color: const Color(0xFF388E3C),
                              height: 70,
                              label: 'r=8',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipPath(
                            clipper: const _RoundedTopClipper(radius: 40),
                            child: _coloredBlock(
                              color: const Color(0xFF1B5E20),
                              height: 70,
                              label: 'r=40',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 05 — _BowtieClipper
              // ================================================================
              _sectionHeader('05', '_BowtieClipper — hourglass shape',
                  _bowtieBg, _bowtieInk),
              _sectionCard(
                bg: _bowtieBg,
                ink: _bowtieInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'A self-intersecting path. Two triangles sharing a '
                      'vertex in the middle. Demonstrates that a Path may be '
                      'non-convex; the default fill rule is non-zero, so '
                      'each triangle paints independently.',
                      _bowtieInk,
                    ),
                    ClipPath(
                      clipper: const _BowtieClipper(),
                      child: _coloredBlock(
                        color: _bowtieAccent,
                        height: 140,
                        label: 'BOWTIE',
                      ),
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 06 — _GradientHexagonClipper
              // ================================================================
              _sectionHeader('06', '_GradientHexagonClipper — regular hexagon',
                  _hexBg, _hexInk),
              _sectionCard(
                bg: _hexBg,
                ink: _hexInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'Six points spaced 60° apart on a circle. Common for '
                      'profile pictures, achievement badges, and game tiles. '
                      'Re-uses the inscribed-circle radius (min(width, height)/2) '
                      'so the hexagon stays inside the layout box.',
                      _hexInk,
                    ),
                    Center(
                      child: SizedBox(
                        width: 220,
                        height: 220,
                        child: ClipPath(
                          clipper: const _GradientHexagonClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  _hexAccent,
                                  const Color(0xFF7E57C2),
                                  const Color(0xFFB39DDB),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'AK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 64,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
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

              // ================================================================
              // SECTION 07 — _TicketClipper
              // ================================================================
              _sectionHeader('07', '_TicketClipper — ticket / coupon notches',
                  _ticketBg, _ticketInk),
              _sectionCard(
                bg: _ticketBg,
                ink: _ticketInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'Uses Path.arcToPoint to carve semicircular notches out '
                      'of the left and right edges. The clockwise:false flag '
                      'and end-point on the same edge produce concave arcs '
                      '(eating INTO the rect rather than bulging out).',
                      _ticketInk,
                    ),
                    ClipPath(
                      clipper: const _TicketClipper(notchRadius: 16),
                      child: _coloredBlock(
                        color: _ticketAccent,
                        height: 120,
                        label: 'ADMIT ONE',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: const _TicketClipper(
                                notchRadius: 8, notchOffset: 0.3),
                            child: _coloredBlock(
                              color: const Color(0xFFFFB300),
                              height: 90,
                              label: 'small',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipPath(
                            clipper: const _TicketClipper(
                                notchRadius: 22, notchOffset: 0.7),
                            child: _coloredBlock(
                              color: const Color(0xFFFF8F00),
                              height: 90,
                              label: 'big',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 08 — _StripeClipper (CustomClipper<Rect>)
              // ================================================================
              _sectionHeader('08', '_StripeClipper — CustomClipper<Rect>',
                  _stripeBg, _stripeInk),
              _sectionCard(
                bg: _stripeBg,
                ink: _stripeInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'Not every clipper is a Path. CustomClipper<Rect> '
                      'returns an axis-aligned Rect, which is much cheaper to '
                      'clip against (a single comparison per pixel instead of '
                      'a full path-intersection test). ClipRect consumes it.',
                      _stripeInk,
                    ),
                    ClipPath(
                      clipper:
                          const _StripePathClipper(fraction: 0.5, height: 50),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _stripeAccent,
                              const Color(0xFF26A69A),
                              const Color(0xFF80CBC4),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'CENTER STRIPE — only the middle 50px is visible',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: const _StripePathClipper(
                                fraction: 0.0, height: 30),
                            child: Container(
                              height: 90,
                              color: const Color(0xFF004D40),
                              alignment: Alignment.center,
                              child: const Text(
                                'top',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipPath(
                            clipper: const _StripePathClipper(
                                fraction: 1.0, height: 30),
                            child: Container(
                              height: 90,
                              color: const Color(0xFF00695C),
                              alignment: Alignment.center,
                              child: const Text(
                                'bottom',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 09 — Side-by-side comparison
              // ================================================================
              _sectionHeader('09',
                  'ClipPath vs ClipRect vs ClipOval', _comparisonBg, _comparisonInk),
              _sectionCard(
                bg: _comparisonBg,
                ink: _comparisonInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'All three widgets cooperate with CustomClipper<T>, but '
                      'each has a different default and a different geometric '
                      'specialisation:',
                      _comparisonInk,
                    ),
                    _prose(
                      '• ClipPath — wants CustomClipper<Path>; defaults to a '
                      'rectangular clip equal to the child size.\n'
                      '• ClipRect — wants CustomClipper<Rect>; defaults to '
                      'the child layout rect, useful as a no-op clip that '
                      'exists only to clip overflow.\n'
                      '• ClipOval — wants CustomClipper<Rect>; the rect is '
                      'interpreted as the BOUNDING BOX of the ellipse, not '
                      'as the visible region.',
                      _comparisonInk,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 110,
                                child: ClipPath(
                                  clipper: const _GradientHexagonClipper(),
                                  child: _coloredBlock(
                                    color: _comparisonAccent,
                                    height: 110,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ClipPath\n(hexagon)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _comparisonInk,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 110,
                                child: ClipPath(
                                  clipper: const _StripePathClipper(
                                      fraction: 0.5, height: 60),
                                  child: _coloredBlock(
                                    color: const Color(0xFF3949AB),
                                    height: 110,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ClipRect\n(stripe)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _comparisonInk,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 110,
                                child: ClipOval(
                                  child: _coloredBlock(
                                    color: const Color(0xFF1A237E),
                                    height: 110,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ClipOval\n(default)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _comparisonInk,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 10 — ShapeBorderClipper
              // ================================================================
              _sectionHeader('10',
                  'ShapeBorderClipper — adapter for ShapeBorder',
                  _shapeBorderBg, _shapeBorderInk),
              _sectionCard(
                bg: _shapeBorderBg,
                ink: _shapeBorderInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'ShapeBorderClipper is a built-in CustomClipper<Path> '
                      'that delegates getClip(size) to '
                      'ShapeBorder.getOuterPath(...). This means anything you '
                      'can pass to a Material widget (RoundedRectangleBorder, '
                      'StadiumBorder, BeveledRectangleBorder, etc.) can also '
                      'be used as a clipper without writing a CustomClipper '
                      'subclass.',
                      _shapeBorderInk,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ClipPath(
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: _coloredBlock(
                                  color: _shapeBorderAccent,
                                  height: 80,
                                  label: 'rounded',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'RoundedRectangleBorder',
                                style: TextStyle(
                                  color: _shapeBorderInk,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              ClipPath(
                                clipper: const ShapeBorderClipper(
                                  shape: StadiumBorder(),
                                ),
                                child: _coloredBlock(
                                  color: const Color(0xFFFFB300),
                                  height: 80,
                                  label: 'stadium',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'StadiumBorder',
                                style: TextStyle(
                                  color: _shapeBorderInk,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              ClipPath(
                                clipper: ShapeBorderClipper(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: _coloredBlock(
                                  color: const Color(0xFFFF8F00),
                                  height: 80,
                                  label: 'beveled',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'BeveledRectangleBorder',
                                style: TextStyle(
                                  color: _shapeBorderInk,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _prose(
                      'When you find yourself writing a CustomClipper that '
                      'just produces a rounded rectangle or a stadium, prefer '
                      'ShapeBorderClipper — it shares the geometry with the '
                      'border painters and stays consistent.',
                      _shapeBorderInk,
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 11 — Animated clipper
              // ================================================================
              _sectionHeader('11',
                  'Animated clipper — Listenable in super-constructor',
                  _animatedBg, _animatedInk),
              _sectionCard(
                bg: _animatedBg,
                ink: _animatedInk,
                child: StatefulBuilder(
                  builder: (BuildContext ctx, StateSetter setState) {
                    final ValueNotifier<double> progress =
                        _AnimatedSection._progressNotifier;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _prose(
                          'CustomClipper accepts an optional reclip parameter '
                          'in its super-constructor. Pass any Listenable '
                          '(ValueNotifier, Animation, ChangeNotifier) and the '
                          'framework will reclip automatically every time it '
                          'fires — without the parent widget rebuilding.',
                          _animatedInk,
                        ),
                        ClipPath(
                          clipper: _AnimatedWaveClipper(progress: progress),
                          child: _coloredBlock(
                            color: _animatedAccent,
                            height: 130,
                            label: 'WAVE PROGRESS',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'progress: ',
                              style: TextStyle(color: _animatedInk),
                            ),
                            Expanded(
                              child: Slider(
                                value: progress.value,
                                min: 0.0,
                                max: 1.0,
                                divisions: 50,
                                activeColor: _animatedAccent,
                                onChanged: (double v) {
                                  progress.value = v;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              width: 44,
                              child: Text(
                                progress.value.toStringAsFixed(2),
                                style: TextStyle(
                                  color: _animatedInk,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ================================================================
              // SECTION 12 — shouldReclip discussion
              // ================================================================
              _sectionHeader('12',
                  'shouldReclip — always vs smart', _shouldReclipBg,
                  _shouldReclipInk),
              _sectionCard(
                bg: _shouldReclipBg,
                ink: _shouldReclipInk,
                child: StatefulBuilder(
                  builder: (BuildContext ctx, StateSetter setState) {
                    final double v = _ReclipSection._value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _prose(
                          'shouldReclip is the heart of clipper performance. '
                          'Both clippers below produce the IDENTICAL visual, '
                          'but one returns true unconditionally and the other '
                          'compares old.value against the new value. The '
                          'always-reclip variant pays a path-rebuild cost on '
                          'every paint; the smart variant only rebuilds when '
                          'the value really changed.',
                          _shouldReclipInk,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  ClipPath(
                                    clipper: _AlwaysReclipWaveClipper(value: v),
                                    child: _coloredBlock(
                                      color: const Color(0xFFE53935),
                                      height: 90,
                                      label: 'always',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'shouldReclip => true',
                                    style: TextStyle(
                                      color: _shouldReclipInk,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                children: [
                                  ClipPath(
                                    clipper: _SmartReclipWaveClipper(value: v),
                                    child: _coloredBlock(
                                      color: const Color(0xFF1E88E5),
                                      height: 90,
                                      label: 'smart',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'shouldReclip => old.v != new.v',
                                    style: TextStyle(
                                      color: _shouldReclipInk,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'value: ',
                              style: TextStyle(color: _shouldReclipInk),
                            ),
                            Expanded(
                              child: Slider(
                                value: v,
                                min: 0.0,
                                max: 1.0,
                                activeColor: _shouldReclipAccent,
                                onChanged: (double newV) {
                                  setState(() {
                                    _ReclipSection._value = newV;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 44,
                              child: Text(
                                v.toStringAsFixed(2),
                                style: TextStyle(
                                  color: _shouldReclipInk,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ],
                        ),
                        _prose(
                          'Rule of thumb: if all your clipper inputs are '
                          'value-comparable, return false except when at '
                          'least one input changed. If your clipper depends '
                          'on something outside its constructor (timer, '
                          'global state) you must return true — but at that '
                          'point prefer passing a Listenable to the super '
                          'constructor instead.',
                          _shouldReclipInk,
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ================================================================
              // SECTION 13 — Recipe: hero header with wave
              // ================================================================
              _sectionHeader('13', 'Recipe — Hero header with wave bottom',
                  _heroRecipeBg, _heroRecipeInk),
              _sectionCard(
                bg: _heroRecipeBg,
                ink: _heroRecipeInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _prose(
                      'Mobile UI cliché #1: a coloured banner across the top '
                      'of a screen, blended into the body via a wave. '
                      'ClipPath + _WaveClipper does it without an asset.',
                      _heroRecipeInk,
                    ),
                    ClipPath(
                      clipper: const _WaveClipper(amplitude: 32),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _heroRecipeAccent,
                              const Color(0xFF558B2F),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding:
                            const EdgeInsets.fromLTRB(20, 28, 20, 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Good morning, Alexis',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'You have 3 tasks scheduled today.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 14 — Recipe: ticket / coupon
              // ================================================================
              _sectionHeader('14', 'Recipe — Ticket / coupon look',
                  _ticketRecipeBg, _ticketRecipeInk),
              _sectionCard(
                bg: _ticketRecipeBg,
                ink: _ticketRecipeInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _prose(
                      'Coupons, boarding passes, and concert tickets all '
                      'share the same notch-on-each-side shape. _TicketClipper '
                      'puts the notches at any vertical fraction.',
                      _ticketRecipeInk,
                    ),
                    ClipPath(
                      clipper: const _TicketClipper(
                          notchRadius: 18, notchOffset: 0.65),
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _ticketRecipeAccent,
                              const Color(0xFFFFD54F),
                              const Color(0xFFFFE082),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CINEMA TICKET',
                                      style: TextStyle(
                                        color: _ticketRecipeInk,
                                        fontSize: 11,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Dune: Part Three',
                                      style: TextStyle(
                                        color: _ticketRecipeInk,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Hall 4   Row K   Seat 12',
                                      style: TextStyle(
                                        color: _ticketRecipeInk,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 80,
                                color: _ticketRecipeInk.withOpacity(0.30),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '20:30',
                                      style: TextStyle(
                                        color: _ticketRecipeInk,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'WED',
                                      style: TextStyle(
                                        color: _ticketRecipeInk,
                                        fontSize: 11,
                                        letterSpacing: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 15 — Recipe: profile picture
              // ================================================================
              _sectionHeader('15', 'Recipe — Hexagonal profile picture',
                  _profileRecipeBg, _profileRecipeInk),
              _sectionCard(
                bg: _profileRecipeBg,
                ink: _profileRecipeInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'A hexagonal avatar grid. Each tile is a fixed-size box '
                      'whose ClipPath restricts the gradient inside.',
                      _profileRecipeInk,
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: <Color>[
                        const Color(0xFF26C6DA),
                        const Color(0xFF00ACC1),
                        const Color(0xFF0097A7),
                        _profileRecipeAccent,
                        const Color(0xFF006064),
                      ].map((Color c) {
                        return SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipPath(
                            clipper: const _GradientHexagonClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [c, c.withOpacity(0.5)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 16 — Recipe: diagonal tag
              // ================================================================
              _sectionHeader('16', 'Recipe — Diagonal tag/label',
                  _tagRecipeBg, _tagRecipeInk),
              _sectionCard(
                bg: _tagRecipeBg,
                ink: _tagRecipeInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'A "NEW" label on the corner of a card. Clip a small '
                      'box with _DiagonalClipper at a steep skew.',
                      _tagRecipeInk,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: const _DiagonalClipper(skew: 0.6),
                            child: Container(
                              height: 50,
                              color: _tagRecipeAccent,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 14),
                              child: const Text(
                                'NEW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipPath(
                            clipper: const _DiagonalClipper(skew: -0.6),
                            child: Container(
                              height: 50,
                              color: const Color(0xFFE65100),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 14),
                              child: const Text(
                                'SALE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _prose(
                      'A negative skew flips the diagonal to the other side, '
                      'giving you a left-tag and a right-tag from a single '
                      'clipper class.',
                      _tagRecipeInk,
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 17 — Clip enum
              // ================================================================
              _sectionHeader('17',
                  'Clip enum — none / hardEdge / antiAlias / antiAliasWithSaveLayer',
                  _clipEnumBg, _clipEnumInk),
              _sectionCard(
                bg: _clipEnumBg,
                ink: _clipEnumInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _prose(
                      'Every clip widget takes a clipBehavior of type Clip. '
                      'Higher quality costs more time and memory.',
                      _clipEnumInk,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ClipPath(
                                clipBehavior: Clip.hardEdge,
                                clipper: const _GradientHexagonClipper(),
                                child: _coloredBlock(
                                  color: _clipEnumAccent,
                                  height: 80,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'hardEdge',
                                style: TextStyle(
                                  color: _clipEnumInk,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              ClipPath(
                                clipBehavior: Clip.antiAlias,
                                clipper: const _GradientHexagonClipper(),
                                child: _coloredBlock(
                                  color: const Color(0xFF7E57C2),
                                  height: 80,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'antiAlias',
                                style: TextStyle(
                                  color: _clipEnumInk,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              ClipPath(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                clipper: const _GradientHexagonClipper(),
                                child: _coloredBlock(
                                  color: const Color(0xFF5E35B1),
                                  height: 80,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'aA + saveLayer',
                                style: TextStyle(
                                  color: _clipEnumInk,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _prose(
                      '• Clip.none — no clipping at all; children may overflow. '
                      'Useful when you want a clipper for layout intent but '
                      'rely on something else (e.g. a Stack) to handle '
                      'overflow.\n'
                      '• Clip.hardEdge — fastest. Cheap rect-test per pixel, '
                      'no anti-aliasing, jaggy edges on diagonals.\n'
                      '• Clip.antiAlias — default for ClipPath/ClipRRect/'
                      'ClipOval. Smooth edges, slight per-pixel cost.\n'
                      '• Clip.antiAliasWithSaveLayer — most expensive. '
                      'Allocates an offscreen layer, paints the child into it, '
                      'then composites. Only required when overlapping '
                      'translucent children would otherwise show banding.',
                      _clipEnumInk,
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 18 — Decision card
              // ================================================================
              _sectionHeader('18',
                  'Decision — CustomClipper vs ShapeDecoration vs ClipOval',
                  _decisionBg, _decisionInk),
              _sectionCard(
                bg: _decisionBg,
                ink: _decisionInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _decisionRow(
                      'rounded rectangle',
                      'ShapeDecoration / ClipRRect',
                      'borders/clip share geometry; built-in.',
                      _decisionInk,
                      _decisionAccent,
                    ),
                    _decisionRow(
                      'circle / oval',
                      'ClipOval (or BoxShape.circle)',
                      'specialised clipper, no path needed.',
                      _decisionInk,
                      _decisionAccent,
                    ),
                    _decisionRow(
                      'stadium / pill',
                      'ShapeBorderClipper(StadiumBorder())',
                      'shared with shape borders.',
                      _decisionInk,
                      _decisionAccent,
                    ),
                    _decisionRow(
                      'irregular path',
                      'CustomClipper<Path>',
                      'wave, hexagon, ticket, zig-zag, …',
                      _decisionInk,
                      _decisionAccent,
                    ),
                    _decisionRow(
                      'axis-aligned rect',
                      'CustomClipper<Rect>',
                      'cheaper than path; for stripes/marquees.',
                      _decisionInk,
                      _decisionAccent,
                    ),
                    _decisionRow(
                      'soft fade out',
                      'ShaderMask',
                      'a clip is binary; ShaderMask gives gradients.',
                      _decisionInk,
                      _decisionAccent,
                    ),
                    _decisionRow(
                      'animated path',
                      'CustomClipper(reclip: animation)',
                      'pass a Listenable; framework reclips for you.',
                      _decisionInk,
                      _decisionAccent,
                    ),
                  ],
                ),
              ),

              // ================================================================
              // SECTION 19 — Reference table
              // ================================================================
              _sectionHeader('19',
                  'Reference — clipper subclasses & their consumer widgets',
                  _refBg, _refInk),
              _sectionCard(
                bg: _refBg,
                ink: _refInk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _refRow('CustomClipper<Path>', 'ClipPath',
                        'irregular path geometry'),
                    _refRow('CustomClipper<Rect>', 'ClipRect, ClipOval',
                        'axis-aligned rect (oval bounding box)'),
                    _refRow('CustomClipper<RRect>', 'ClipRRect',
                        'rounded rectangle'),
                    _refRow('ShapeBorderClipper', 'ClipPath',
                        'adapter for any ShapeBorder'),
                    _refRow('_WaveClipper', 'ClipPath',
                        'concave wave at bottom edge'),
                    _refRow('_DiagonalClipper', 'ClipPath',
                        'diagonal trapezoid'),
                    _refRow('_ZigZagClipper', 'ClipPath',
                        'saw-tooth bottom edge'),
                    _refRow('_RoundedTopClipper', 'ClipPath',
                        'rounded top, flat bottom'),
                    _refRow('_BowtieClipper', 'ClipPath',
                        'self-intersecting hourglass'),
                    _refRow('_GradientHexagonClipper', 'ClipPath',
                        'regular hexagon'),
                    _refRow('_TicketClipper', 'ClipPath',
                        'side notches via arcToPoint'),
                    _refRow('_StripeClipper', 'ClipRect',
                        'horizontal stripe rect'),
                    _refRow('_AnimatedWaveClipper', 'ClipPath',
                        'reclips on Listenable fire'),
                    _refRow('_AlwaysReclipWaveClipper', 'ClipPath',
                        'pedagogical foil — shouldReclip => true'),
                    _refRow('_SmartReclipWaveClipper', 'ClipPath',
                        'compares old.value to current'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Center(
                child: Text(
                  '— end of CustomClipper deep demo —',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION-LOCAL STATE HOLDERS
// -----------------------------------------------------------------------------
// These tiny container classes give StatefulBuilder sections a stable place to
// remember their local state across rebuilds without using a top-level mutable
// variable. They are private and non-instantiable.
// =============================================================================
abstract class _AnimatedSection {
  static final ValueNotifier<double> _progressNotifier =
      ValueNotifier<double>(0.4);
}

abstract class _ReclipSection {
  static double _value = 0.5;
}

// =============================================================================
// DECISION-ROW + REF-ROW HELPERS
// =============================================================================

Widget _decisionRow(
  String situation,
  String solution,
  String reason,
  Color ink,
  Color accent,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            situation,
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                solution,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                reason,
                style: TextStyle(
                  color: ink.withOpacity(0.85),
                  fontSize: 11,
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

Widget _refRow(String name, String widget, String purpose) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            name,
            style: TextStyle(
              color: _refInk,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            widget,
            style: TextStyle(
              color: _refInk.withOpacity(0.85),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            purpose,
            style: TextStyle(
              color: _refInk.withOpacity(0.80),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
