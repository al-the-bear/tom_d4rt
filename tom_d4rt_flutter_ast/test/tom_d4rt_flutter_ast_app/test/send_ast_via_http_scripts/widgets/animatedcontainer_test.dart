// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep-demo test script: AnimatedContainer Morphology Lab
// =====================================================================
// AnimatedContainer and its sibling implicit-animation widgets are the
// gentle introduction to motion in Flutter. Each one observes a single
// property (or composite decoration) and quietly drives an interpolation
// between successive build outputs. The `duration` field defines how
// long that interpolation should take and `curve` defines its shape. As
// soon as a parent widget rebuilds with new values, the animated widget
// crossfades / lerps from the previous frame to the new one — no
// AnimationController, no Tween wiring, no ticker management.
//
// Constructor (Flutter SDK):
//   AnimatedContainer({
//     Key? key,
//     AlignmentGeometry? alignment,
//     EdgeInsetsGeometry? padding,
//     Color? color,
//     Decoration? decoration,
//     Decoration? foregroundDecoration,
//     double? width,
//     double? height,
//     BoxConstraints? constraints,
//     EdgeInsetsGeometry? margin,
//     Matrix4? transform,
//     AlignmentGeometry? transformAlignment,
//     Widget? child,
//     Clip clipBehavior = Clip.none,
//     Curve curve = Curves.linear,
//     required Duration duration,
//     VoidCallback? onEnd,
//   });
//
// Sister implicit-animation widgets covered in this demo:
//   * AnimatedPadding         — eases EdgeInsetsGeometry changes.
//   * AnimatedAlign           — eases AlignmentGeometry changes.
//   * AnimatedPositioned      — eases Stack-positioning changes.
//   * AnimatedDefaultTextStyle — eases TextStyle for descendant Text.
//   * AnimatedTheme           — eases an entire ThemeData swap.
//
// This deep demo turns each of these widgets into a *morphology lab*.
// The trick: every Animated* widget is given `duration: Duration.zero`
// so that it renders its *target* state instantly with no actual
// interpolation. By laying out a row of widgets, each fed a slightly
// different parameter value, we storyboard the morph "as if" we were
// scrubbing through a real animation timeline. The reader sees the
// shape change frame-by-frame without ever needing a Ticker.
// =====================================================================
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

// ---------------------------------------------------------------------
// Palette helpers. Each section owns a unique tonal family so the lab
// reads at a glance. All colors are hand-picked from Material ramps.
// ---------------------------------------------------------------------

const Color _heroDeep = Color(0xFF004D40); // teal 900
const Color _heroMid = Color(0xFF00796B); // teal 700
const Color _heroSoft = Color(0xFFB2DFDB); // teal 100

const Color _overviewBg = Color(0xFFE0F2F1); // teal 50
const Color _overviewBorder = Color(0xFF80CBC4); // teal 200
const Color _overviewText = Color(0xFF004D40);

// Section 1 — AnimatedContainer primitives (blue)
const Color _s1Bg = Color(0xFFE3F2FD);
const Color _s1Tint = Color(0xFF90CAF9);
const Color _s1Mid = Color(0xFF1E88E5);
const Color _s1Deep = Color(0xFF0D47A1);

// Section 2 — Color morph (purple)
const Color _s2Bg = Color(0xFFF3E5F5);
const Color _s2Tint = Color(0xFFCE93D8);
const Color _s2Mid = Color(0xFFAB47BC);
const Color _s2Deep = Color(0xFF6A1B9A);

// Section 3 — Size morph (orange)
const Color _s3Bg = Color(0xFFFFF3E0);
const Color _s3Tint = Color(0xFFFFCC80);
const Color _s3Mid = Color(0xFFFB8C00);
const Color _s3Deep = Color(0xFFE65100);

// Section 4 — Padding morph (green)
const Color _s4Bg = Color(0xFFE8F5E9);
const Color _s4Tint = Color(0xFFA5D6A7);
const Color _s4Mid = Color(0xFF43A047);
const Color _s4Deep = Color(0xFF1B5E20);

// Section 5 — BorderRadius morph (pink)
const Color _s5Bg = Color(0xFFFCE4EC);
const Color _s5Tint = Color(0xFFF48FB1);
const Color _s5Mid = Color(0xFFEC407A);
const Color _s5Deep = Color(0xFFAD1457);

// Section 6 — Shape & border morph (deep purple)
const Color _s6Bg = Color(0xFFEDE7F6);
const Color _s6Tint = Color(0xFFB39DDB);
const Color _s6Mid = Color(0xFF7E57C2);
const Color _s6Deep = Color(0xFF4527A0);

// Section 7 — Decoration composition (amber)
const Color _s7Bg = Color(0xFFFFF8E1);
const Color _s7Tint = Color(0xFFFFE082);
const Color _s7Mid = Color(0xFFFFB300);
const Color _s7Deep = Color(0xFFFF6F00);

// Section 8 — AnimatedPadding (cyan)
const Color _s8Bg = Color(0xFFE0F7FA);
const Color _s8Tint = Color(0xFF80DEEA);
const Color _s8Mid = Color(0xFF00ACC1);
const Color _s8Deep = Color(0xFF006064);

// Section 9 — AnimatedAlign (lime)
const Color _s9Bg = Color(0xFFF9FBE7);
const Color _s9Tint = Color(0xFFE6EE9C);
const Color _s9Mid = Color(0xFFC0CA33);
const Color _s9Deep = Color(0xFF827717);

// Section 10 — AnimatedPositioned (red)
const Color _s10Bg = Color(0xFFFFEBEE);
const Color _s10Tint = Color(0xFFEF9A9A);
const Color _s10Mid = Color(0xFFE53935);
const Color _s10Deep = Color(0xFFB71C1C);

// Section 11 — AnimatedDefaultTextStyle (indigo)
const Color _s11Bg = Color(0xFFE8EAF6);
const Color _s11Tint = Color(0xFF9FA8DA);
const Color _s11Mid = Color(0xFF3949AB);
const Color _s11Deep = Color(0xFF1A237E);

// Section 12 — AnimatedTheme (brown)
const Color _s12Bg = Color(0xFFEFEBE9);
const Color _s12Tint = Color(0xFFBCAAA4);
const Color _s12Mid = Color(0xFF8D6E63);
const Color _s12Deep = Color(0xFF4E342E);

// Comparison table palette (blue grey)
const Color _tableBg = Color(0xFFECEFF1);
const Color _tableTint = Color(0xFFB0BEC5);
const Color _tableMid = Color(0xFF607D8B);
const Color _tableDeep = Color(0xFF263238);

// Glossary palette (deep orange)
const Color _glossBg = Color(0xFFFBE9E7);
const Color _glossTint = Color(0xFFFFAB91);
const Color _glossDeep = Color(0xFFBF360C);

// Epilogue palette (matches hero family)
const Color _epilogueDeep = Color(0xFF00251A);
const Color _epilogueMid = Color(0xFF004D40);
const Color _epilogueSoft = Color(0xFFB2DFDB);

// ---------------------------------------------------------------------
// Tiny visual helpers — all top-level functions, no widget subclasses.
// ---------------------------------------------------------------------

Widget _sectionBanner({
  required int index,
  required String title,
  required String subtitle,
  required Color deep,
  required Color mid,
  required Color soft,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 28.0, bottom: 12.0),
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[deep, mid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: deep.withOpacity(0.18),
          blurRadius: 12.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: soft,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: TextStyle(
              color: deep,
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'SECTION $index: $title',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: soft,
                  fontSize: 12.5,
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

Widget _bullet(String text, Color dotColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.only(top: 6.0, right: 10.0),
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _sectionBody({
  required Color bg,
  required Color border,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: border),
    ),
    child: child,
  );
}

Widget _recipeCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accent,
  required Color background,
  required String code,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 14.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(9.0),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFFB2DFDB),
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow({
  required String widget,
  required String drives,
  required String useFor,
  required String avoidWhen,
  required Color rowColor,
  bool bold = false,
}) {
  final TextStyle base = TextStyle(
    fontSize: 11.5,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    color: bold ? Colors.white : const Color(0xFF263238),
  );
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: rowColor,
      border: const Border(
        bottom: BorderSide(color: Color(0xFFCFD8DC), width: 0.6),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(flex: 3, child: Text(widget, style: base)),
        Expanded(flex: 3, child: Text(drives, style: base)),
        Expanded(flex: 4, child: Text(useFor, style: base)),
        Expanded(flex: 4, child: Text(avoidWhen, style: base)),
      ],
    ),
  );
}

Widget _glossaryEntry({
  required String term,
  required String meaning,
  required Color accent,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              term,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          meaning,
          style: const TextStyle(fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

// AnimatedContainer snapshot tile — explicit target state, zero duration.
Widget _morphTile({
  required double width,
  required double height,
  required Color color,
  required double radius,
  required String label,
  IconData? icon,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      AnimatedContainer(
        duration: Duration.zero,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withOpacity(0.45),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: icon == null
            ? null
            : Icon(icon, color: Colors.white, size: 24.0),
      ),
      const SizedBox(height: 6.0),
      Text(
        label,
        style: const TextStyle(
          fontSize: 11.0,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

// Rotation helper used in the decoration-composition row — uses math.pi
// so the dart:math import is meaningful at runtime, not just decorative.
Matrix4 _gentleSpin(double t) {
  return Matrix4.rotationZ(math.pi * 0.05 * t);
}

// Interpolated radius helper based on dart:ui.lerpDouble — keeps both
// dart:math and dart:ui in actual use throughout the file.
double _lerpRadius(double a, double b, double t) {
  return ui.lerpDouble(a, b, t) ?? a;
}

// Frame used by morph rows — neutral grey backing so the morph reads.
Widget _frame({required Widget child, double height = 110.0}) {
  return Container(
    height: height,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    padding: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5),
      border: Border.all(color: const Color(0xFFE0E0E0)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    alignment: Alignment.center,
    child: child,
  );
}

// =====================================================================
// MAIN ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  print('=== AnimatedContainer Morphology Lab — Deep Demo ===');
  print('Sections: 12 (primitives, color morph, size morph,');
  print(' padding morph, borderRadius morph, shape & border,');
  print(' decoration composition, AnimatedPadding, AnimatedAlign,');
  print(' AnimatedPositioned, AnimatedDefaultTextStyle, AnimatedTheme).');

  // -------------------------------------------------------------------
  // Canonical morph stops. Each Animated* widget in this script reads a
  // single stop, rendered with `duration: Duration.zero` so the result
  // is the literal target value, no interpolation. By placing the stops
  // in a row, we storyboard the morph "as if" we were scrubbing through
  // a real animation — without ever owning a Ticker or a Controller.
  // -------------------------------------------------------------------

  final List<double> stops = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  print('Canonical morph stops: $stops');

  // -------------------------------------------------------------------
  // HERO HEADER BANNER
  // -------------------------------------------------------------------

  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    margin: const EdgeInsets.only(bottom: 16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_heroDeep, _heroMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _heroDeep.withOpacity(0.35),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: _heroSoft,
                borderRadius: BorderRadius.circular(14.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.auto_awesome_motion,
                color: _heroDeep,
                size: 32.0,
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'AnimatedContainer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Morphology Lab — a designer\'s exploration',
                    style: TextStyle(
                      color: _heroSoft,
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Text(
          'Twelve sections of implicit-animation snapshots. Each Animated* '
          'widget is fed `duration: Duration.zero` so we render the literal '
          'target state — then we line up rows of those targets to show the '
          'morph as a flipbook. No setState, no controllers, no tickers.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.92),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _chip('AnimatedContainer', _heroSoft, _heroDeep),
            _chip('AnimatedPadding', _heroSoft, _heroDeep),
            _chip('AnimatedAlign', _heroSoft, _heroDeep),
            _chip('AnimatedPositioned', _heroSoft, _heroDeep),
            _chip('AnimatedDefaultTextStyle', _heroSoft, _heroDeep),
            _chip('AnimatedTheme', _heroSoft, _heroDeep),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // OVERVIEW PANEL
  // -------------------------------------------------------------------

  final Widget overview = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _overviewBg,
      border: Border.all(color: _overviewBorder),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'How to read this lab',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _overviewText,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Each row is a row of *target frames*. Every tile is the same '
          'Animated* widget, but each one receives slightly different '
          'parameter values. Reading left-to-right is reading the morph '
          'forward in time; reading right-to-left is reading the reverse.',
          style: TextStyle(
            fontSize: 13.0,
            height: 1.5,
            color: _overviewText,
          ),
        ),
        const SizedBox(height: 8.0),
        _bullet('All Animated* widgets use `duration: Duration.zero`.',
            _overviewBorder),
        _bullet('Rendered output equals the target value exactly.',
            _overviewBorder),
        _bullet('No controllers, no tickers, no setState.',
            _overviewBorder),
        _bullet('The row-of-snapshots is the storytelling device.',
            _overviewBorder),
      ],
    ),
  );

  // ===================================================================
  // SECTION 1: ANIMATEDCONTAINER PRIMITIVES
  // ===================================================================

  final Widget section1Body = _sectionBody(
    bg: _s1Bg,
    border: _s1Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedContainer is the swiss-army-knife of implicit animation. '
          'Width, height, color, decoration, alignment, padding, margin, '
          'transform, constraints, foregroundDecoration — they are all '
          'lerped automatically when their values change.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _morphTile(
              width: 64.0,
              height: 64.0,
              color: _s1Tint,
              radius: 4.0,
              label: 'tile A',
              icon: Icons.crop_square,
            ),
            _morphTile(
              width: 72.0,
              height: 64.0,
              color: _s1Mid,
              radius: 10.0,
              label: 'tile B',
              icon: Icons.crop_din,
            ),
            _morphTile(
              width: 80.0,
              height: 80.0,
              color: _s1Deep,
              radius: 18.0,
              label: 'tile C',
              icon: Icons.crop_landscape,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _frame(
              child: AnimatedContainer(
                duration: Duration.zero,
                width: 70.0,
                height: 70.0,
                color: _s1Mid,
                alignment: Alignment.center,
                child: const Text(
                  'A',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _frame(
              child: AnimatedContainer(
                duration: Duration.zero,
                width: 80.0,
                height: 60.0,
                color: _s1Mid,
                alignment: Alignment.center,
                child: const Text(
                  'B',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _frame(
              child: AnimatedContainer(
                duration: Duration.zero,
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  color: _s1Deep,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'C',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _s1Tint),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Constructor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: _s1Deep,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'AnimatedContainer(\n'
                '  duration: Duration(milliseconds: 300),\n'
                '  curve: Curves.easeInOut,\n'
                '  width: 120, height: 120,\n'
                '  decoration: BoxDecoration(...),\n'
                '  padding: EdgeInsets.all(8),\n'
                '  margin: EdgeInsets.all(4),\n'
                '  alignment: Alignment.center,\n'
                '  transform: Matrix4.identity(),\n'
                '  child: ...\n'
                ')',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet('duration is required — it sets the lerp window.', _s1Mid),
        _bullet('curve shapes the lerp; defaults to Curves.linear.', _s1Mid),
        _bullet(
            'Setting duration: Duration.zero renders the target state instantly.',
            _s1Mid),
        _bullet(
            'AnimatedContainer cannot animate gradient stops it doesn\'t '
            'know about — for those, use a TweenAnimationBuilder.',
            _s1Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 2: COLOR MORPH
  // ===================================================================

  final List<Color> colorStops = <Color>[
    const Color(0xFFE1BEE7),
    const Color(0xFFCE93D8),
    const Color(0xFFBA68C8),
    const Color(0xFFAB47BC),
    const Color(0xFF8E24AA),
    const Color(0xFF6A1B9A),
  ];

  final Widget section2Body = _sectionBody(
    bg: _s2Bg,
    border: _s2Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'When you change `color` on an AnimatedContainer, Flutter lerps '
          'between the old color and the new one across `duration`. Here '
          'we storyboard six target colors — the strip reads as a smooth '
          'fade because the colors are themselves on a ramp.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < colorStops.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration.zero,
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: colorStops[i],
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: colorStops[i].withOpacity(0.5),
                              blurRadius: 6.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'step ${i + 1}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Color lerp is performed on the RGB channels independently with '
          'Color.lerp. Alpha is included so a fade-in via color works too.',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF424242)),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _s2Tint),
          ),
          child: const Text(
            'AnimatedContainer(\n'
            '  duration: Duration(milliseconds: 600),\n'
            '  curve: Curves.easeInOut,\n'
            '  color: _active ? Colors.purple : Colors.purpleAccent,\n'
            '  width: 70, height: 70,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet('Color and decoration.color are mutually exclusive — pick one.',
            _s2Mid),
        _bullet('Alpha is part of the lerp; fade-via-color works.', _s2Mid),
        _bullet('Use HSLColor.lerp manually when hue paths matter.', _s2Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 3: SIZE MORPH
  // ===================================================================

  final List<List<double>> sizeStops = <List<double>>[
    <double>[40.0, 40.0],
    <double>[60.0, 50.0],
    <double>[80.0, 60.0],
    <double>[100.0, 70.0],
    <double>[120.0, 80.0],
  ];

  final Widget section3Body = _sectionBody(
    bg: _s3Bg,
    border: _s3Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Width and height each lerp independently. Note how a non-square '
          'morph traces a diagonal path through (w, h) space — the widget '
          'goes from a small square to a wide letterbox without ever '
          'losing layout integrity.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 120.0,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                for (int i = 0; i < sizeStops.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration.zero,
                          width: sizeStops[i][0],
                          height: sizeStops[i][1],
                          decoration: BoxDecoration(
                            color: _s3Mid,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${sizeStops[i][0].toInt()}×'
                            '${sizeStops[i][1].toInt()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _s3Tint),
          ),
          child: const Text(
            'AnimatedContainer(\n'
            '  duration: Duration(milliseconds: 350),\n'
            '  width: _expanded ? 240 : 80,\n'
            '  height: _expanded ? 120 : 80,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet('width / height are NOT lerped if either side is null.',
            _s3Mid),
        _bullet('Constraints can produce the same effect with minimum sizes.',
            _s3Mid),
        _bullet('Parent constraints clamp the result — beware overflow.',
            _s3Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 4: PADDING MORPH
  // ===================================================================

  final List<EdgeInsets> paddingStops = <EdgeInsets>[
    const EdgeInsets.all(0.0),
    const EdgeInsets.all(6.0),
    const EdgeInsets.all(12.0),
    const EdgeInsets.all(18.0),
    const EdgeInsets.all(24.0),
  ];

  final Widget section4Body = _sectionBody(
    bg: _s4Bg,
    border: _s4Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedContainer also animates EdgeInsetsGeometry. Increasing '
          'padding pushes the child inward without changing the outer box '
          'unless the child wants to grow.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < paddingStops.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration.zero,
                        width: 90.0,
                        height: 90.0,
                        padding: paddingStops[i],
                        decoration: BoxDecoration(
                          color: _s4Tint,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _s4Deep,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'pad ${paddingStops[i].top.toInt()}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'For the same effect without an outer Container, prefer the '
          'dedicated AnimatedPadding (Section 8).',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF424242)),
        ),
        const SizedBox(height: 10.0),
        _bullet('EdgeInsets.lerp blends sides independently.', _s4Mid),
        _bullet('Padding does not change container size unless child grows.',
            _s4Mid),
        _bullet('LTR vs RTL padding uses EdgeInsetsDirectional.', _s4Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 5: BORDERRADIUS MORPH
  // ===================================================================

  final List<double> radiusStops = <double>[0.0, 8.0, 18.0, 32.0, 50.0];

  final Widget section5Body = _sectionBody(
    bg: _s5Bg,
    border: _s5Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'BorderRadius lerps each corner independently. The classic '
          '"square morphs into circle" gag is a single AnimatedContainer '
          'with a radius going from 0 to half the side length.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < radiusStops.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration.zero,
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: _s5Mid,
                          borderRadius:
                              BorderRadius.circular(radiusStops[i]),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'r=${radiusStops[i].toInt()}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration.zero,
              width: 70.0,
              height: 70.0,
              decoration: const BoxDecoration(
                color: _s5Deep,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(60.0),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration.zero,
              width: 70.0,
              height: 70.0,
              decoration: const BoxDecoration(
                color: _s5Deep,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(60.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration.zero,
              width: 70.0,
              height: 70.0,
              decoration: const BoxDecoration(
                color: _s5Deep,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet('Each corner is its own Radius — full independence.', _s5Mid),
        _bullet('Use BorderRadiusDirectional for RTL-aware corners.', _s5Mid),
        _bullet('Radius > half side rounds beyond — clipped by container.',
            _s5Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 6: SHAPE & BORDER MORPH
  // ===================================================================

  final Widget section6Body = _sectionBody(
    bg: _s6Bg,
    border: _s6Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Border width and color also lerp. Switching shape via '
          'BoxDecoration is supported because the underlying Decoration '
          'objects know how to interpolate themselves.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration.zero,
                        width: 72.0,
                        height: 72.0,
                        decoration: BoxDecoration(
                          color: _s6Bg,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: _s6Deep,
                            width: (i + 1).toDouble(),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${i + 1}px',
                          style: TextStyle(
                            color: _s6Deep,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'border ${i + 1}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration.zero,
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: _s6Mid,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.brightness_1,
                  color: Colors.white, size: 30.0),
            ),
            AnimatedContainer(
              duration: Duration.zero,
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: _s6Mid,
                borderRadius: BorderRadius.circular(18.0),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.square_rounded,
                  color: Colors.white, size: 30.0),
            ),
            AnimatedContainer(
              duration: Duration.zero,
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: _s6Mid,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.square, color: Colors.white, size: 30.0),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet('Border.lerp blends width and color sides.', _s6Mid),
        _bullet('BoxShape.circle and BoxShape.rectangle morph at the edge.',
            _s6Mid),
        _bullet('Need a custom path? Use a ShapeDecoration with a '
            'MorphableShapeBorder.', _s6Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 7: DECORATION COMPOSITION
  // ===================================================================

  final Widget section7Body = _sectionBody(
    bg: _s7Bg,
    border: _s7Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A BoxDecoration carries color, border, borderRadius, gradient, '
          'image and boxShadow. AnimatedContainer can lerp the lot. Below '
          'we step the gradient stops, then add layered shadows.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: AnimatedContainer(
                    duration: Duration.zero,
                    width: 76.0,
                    height: 76.0,
                    transform: _gentleSpin(i.toDouble()),
                    transformAlignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          _s7Tint,
                          Color.lerp(_s7Mid, _s7Deep, i / 4.0)!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(_lerpRadius(10.0, 22.0, i / 4.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _s7Deep.withOpacity(0.2 + i * 0.1),
                          blurRadius: 4.0 + i * 2.0,
                          offset: Offset(0, 2.0 + i * 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _s7Tint),
          ),
          child: const Text(
            'AnimatedContainer(\n'
            '  duration: Duration(milliseconds: 500),\n'
            '  decoration: BoxDecoration(\n'
            '    gradient: LinearGradient(colors: [...]),\n'
            '    boxShadow: [BoxShadow(...)],\n'
            '    borderRadius: BorderRadius.circular(r),\n'
            '  ),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet('Decoration.lerp returns null for incompatible decorations — '
            'wrap with the same Decoration subclass on both sides.', _s7Mid),
        _bullet('Gradient stops, colors and direction all lerp.', _s7Mid),
        _bullet('BoxShadow list lerps element-wise; pad shorter lists '
            'with transparent shadows.', _s7Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 8: ANIMATEDPADDING
  // ===================================================================

  final List<EdgeInsets> animatedPaddingStops = <EdgeInsets>[
    const EdgeInsets.all(0.0),
    const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
    const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
    const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
  ];

  final Widget section8Body = _sectionBody(
    bg: _s8Bg,
    border: _s8Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedPadding does what Padding does, only it lerps. It\'s '
          'lighter than AnimatedContainer when all you want to animate is '
          'spacing. Below: a button caption sliding outward as padding '
          'grows.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Column(
          children: <Widget>[
            for (int i = 0; i < animatedPaddingStops.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _s8Tint,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: AnimatedPadding(
                    duration: Duration.zero,
                    padding: animatedPaddingStops[i],
                    child: Container(
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: _s8Deep,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'padding ${animatedPaddingStops[i].horizontal.toInt()}'
                        ' × ${animatedPaddingStops[i].vertical.toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet('AnimatedPadding takes just `padding` + `duration`.', _s8Mid),
        _bullet('Useful for hover/focus reveal effects on cards.', _s8Mid),
        _bullet('No decoration — wrap with Container or DecoratedBox.',
            _s8Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 9: ANIMATEDALIGN
  // ===================================================================

  final List<Alignment> alignStops = <Alignment>[
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.center,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];

  final Widget section9Body = _sectionBody(
    bg: _s9Bg,
    border: _s9Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedAlign lerps an AlignmentGeometry. The child stays the '
          'same size but glides from one anchor to the next. Combine with '
          'AnimatedContainer for full repositioning.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < alignStops.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: _s9Bg,
                          border: Border.all(color: _s9Tint, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: AnimatedAlign(
                          duration: Duration.zero,
                          alignment: alignStops[i],
                          child: Container(
                            width: 26.0,
                            height: 26.0,
                            decoration: BoxDecoration(
                              color: _s9Deep,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        alignStops[i].toString().split('.').last,
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet('Alignment.lerp blends x and y separately.', _s9Mid),
        _bullet('AlignmentDirectional swaps left/right under RTL.', _s9Mid),
        _bullet('Pair with AnimatedSize for shrinking parents.', _s9Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 10: ANIMATEDPOSITIONED
  // ===================================================================

  final Widget section10Body = _sectionBody(
    bg: _s10Bg,
    border: _s10Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedPositioned lives inside a Stack and lerps its left / '
          'top / right / bottom / width / height edges. Below: five '
          'stacked frames, each showing the chip at a different offset.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 110.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: _s10Bg,
                          border: Border.all(color: _s10Tint, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          children: <Widget>[
                            AnimatedPositioned(
                              duration: Duration.zero,
                              left: i * 18.0,
                              top: i * 12.0,
                              width: 40.0,
                              height: 26.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _s10Deep,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'f${i + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'left ${i * 18}, top ${i * 12}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet('Must be a direct child of a Stack.', _s10Mid),
        _bullet('Null edges stay un-positioned (i.e. flexible).', _s10Mid),
        _bullet('Use AnimatedPositionedDirectional for RTL.', _s10Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 11: ANIMATEDDEFAULTTEXTSTYLE
  // ===================================================================

  final List<TextStyle> textStyleStops = <TextStyle>[
    const TextStyle(fontSize: 12.0, color: _s11Deep, fontWeight: FontWeight.w400),
    const TextStyle(fontSize: 14.0, color: _s11Mid, fontWeight: FontWeight.w500),
    const TextStyle(fontSize: 16.0, color: _s11Mid, fontWeight: FontWeight.w600),
    const TextStyle(fontSize: 18.0, color: _s11Deep, fontWeight: FontWeight.w700),
    const TextStyle(fontSize: 20.0, color: _s11Deep, fontWeight: FontWeight.w900),
  ];

  final Widget section11Body = _sectionBody(
    bg: _s11Bg,
    border: _s11Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedDefaultTextStyle lerps the TextStyle inherited by any '
          'descendant Text widget. Font size, color, weight, letterSpacing '
          '— all interpolate independently.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < textStyleStops.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: AnimatedDefaultTextStyle(
                  duration: Duration.zero,
                  style: textStyleStops[i],
                  child: Text(
                    'Step ${i + 1} — fs '
                    '${textStyleStops[i].fontSize?.toInt()}, '
                    'fw ${textStyleStops[i].fontWeight}',
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet('Inherits and overrides DefaultTextStyle.of(context).',
            _s11Mid),
        _bullet('fontWeight uses step interpolation, not float.', _s11Mid),
        _bullet('Pair with AnimatedTheme for site-wide changes.', _s11Mid),
      ],
    ),
  );

  // ===================================================================
  // SECTION 12: ANIMATEDTHEME
  // ===================================================================

  final List<ThemeData> themeStops = <ThemeData>[
    ThemeData(primaryColor: const Color(0xFFEFEBE9)),
    ThemeData(primaryColor: const Color(0xFFBCAAA4)),
    ThemeData(primaryColor: const Color(0xFF8D6E63)),
    ThemeData(primaryColor: const Color(0xFF6D4C41)),
    ThemeData(primaryColor: const Color(0xFF4E342E)),
  ];

  final Widget section12Body = _sectionBody(
    bg: _s12Bg,
    border: _s12Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedTheme lerps an entire ThemeData, including the color '
          'scheme. Children that read Theme.of(context) automatically '
          'update through the lerp.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < themeStops.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: AnimatedTheme(
                    duration: Duration.zero,
                    data: themeStops[i],
                    child: Builder(builder: (BuildContext innerCtx) {
                      final Color primary =
                          Theme.of(innerCtx).primaryColor;
                      return Column(
                        children: <Widget>[
                          Container(
                            width: 76.0,
                            height: 76.0,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.palette,
                              color: Colors.white,
                              size: 26.0,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'theme ${i + 1}',
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet('ThemeData.lerp blends color scheme, text theme, etc.',
            _s12Mid),
        _bullet('Useful for theme toggles, light/dark transitions.', _s12Mid),
        _bullet('Heavier than AnimatedDefaultTextStyle — scope it tightly.',
            _s12Mid),
      ],
    ),
  );

  // ===================================================================
  // RECIPE CARDS
  // ===================================================================

  final Widget recipeCards = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 14.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFFF59D)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Production Recipes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: Color(0xFFF57F17),
          ),
        ),
        const SizedBox(height: 10.0),
        _recipeCard(
          title: 'Expandable Card',
          subtitle: 'A tap toggles size, padding and shadow at once.',
          icon: Icons.unfold_more,
          accent: _s1Deep,
          background: _s1Bg,
          code: 'AnimatedContainer(\n'
              '  duration: Duration(milliseconds: 250),\n'
              '  curve: Curves.easeInOut,\n'
              '  width: _expanded ? 320 : 160,\n'
              '  height: _expanded ? 220 : 80,\n'
              '  padding: EdgeInsets.all(_expanded ? 24 : 12),\n'
              '  decoration: BoxDecoration(\n'
              '    color: Colors.white,\n'
              '    boxShadow: [BoxShadow(blurRadius: _expanded ? 12 : 4)],\n'
              '  ),\n'
              ')',
        ),
        _recipeCard(
          title: 'Color State Indicator',
          subtitle: 'A dot fades through the status palette.',
          icon: Icons.fiber_manual_record,
          accent: _s2Deep,
          background: _s2Bg,
          code: 'AnimatedContainer(\n'
              '  duration: Duration(milliseconds: 200),\n'
              '  width: 18, height: 18,\n'
              '  decoration: BoxDecoration(\n'
              '    color: _statusColor,\n'
              '    shape: BoxShape.circle,\n'
              '  ),\n'
              ')',
        ),
        _recipeCard(
          title: 'Floating Action Hero',
          subtitle: 'A pill-shaped button morphs into a circle.',
          icon: Icons.add_circle_outline,
          accent: _s5Deep,
          background: _s5Bg,
          code: 'AnimatedContainer(\n'
              '  duration: Duration(milliseconds: 400),\n'
              '  width: _collapsed ? 56 : 180,\n'
              '  height: 56,\n'
              '  decoration: BoxDecoration(\n'
              '    color: Colors.deepPurple,\n'
              '    borderRadius: BorderRadius.circular(28),\n'
              '  ),\n'
              ')',
        ),
        _recipeCard(
          title: 'Drawer Slider',
          subtitle: 'AnimatedPositioned slides a side panel.',
          icon: Icons.menu_open,
          accent: _s10Deep,
          background: _s10Bg,
          code: 'Stack(\n'
              '  children: [\n'
              '    AnimatedPositioned(\n'
              '      duration: Duration(milliseconds: 300),\n'
              '      left: _open ? 0 : -240,\n'
              '      top: 0, bottom: 0, width: 240,\n'
              '      child: DrawerPanel(),\n'
              '    ),\n'
              '  ],\n'
              ')',
        ),
        _recipeCard(
          title: 'Form Reveal',
          subtitle: 'AnimatedAlign drops a confirm row into view.',
          icon: Icons.south,
          accent: _s9Deep,
          background: _s9Bg,
          code: 'AnimatedAlign(\n'
              '  duration: Duration(milliseconds: 250),\n'
              '  alignment: _ready ? Alignment.bottomCenter : Alignment.topCenter,\n'
              '  child: ConfirmRow(),\n'
              ')',
        ),
        _recipeCard(
          title: 'Theme Toggle',
          subtitle: 'AnimatedTheme blends an entire light/dark swap.',
          icon: Icons.brightness_6,
          accent: _s12Deep,
          background: _s12Bg,
          code: 'AnimatedTheme(\n'
              '  duration: Duration(milliseconds: 350),\n'
              '  data: _dark ? darkTheme : lightTheme,\n'
              '  child: HomePage(),\n'
              ')',
        ),
      ],
    ),
  );

  // ===================================================================
  // COMPARISON TABLE
  // ===================================================================

  final Widget comparisonTable = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 18.0),
    decoration: BoxDecoration(
      color: _tableBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _tableTint),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _tableDeep,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: const Text(
            'AnimatedContainer vs AnimatedPositioned vs AnimatedAlign',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        _comparisonRow(
          widget: 'Widget',
          drives: 'What lerps',
          useFor: 'Use for',
          avoidWhen: 'Avoid when',
          rowColor: _tableMid,
          bold: true,
        ),
        _comparisonRow(
          widget: 'AnimatedContainer',
          drives: 'size, color, decoration, padding, margin, transform',
          useFor: 'Cards, badges, expandable tiles, status pills',
          avoidWhen: 'You only need one property — too heavyweight',
          rowColor: Colors.white,
        ),
        _comparisonRow(
          widget: 'AnimatedPadding',
          drives: 'EdgeInsetsGeometry',
          useFor: 'Hover/focus spacing, list reveal',
          avoidWhen: 'You need to change child size or color too',
          rowColor: const Color(0xFFF5F5F5),
        ),
        _comparisonRow(
          widget: 'AnimatedAlign',
          drives: 'AlignmentGeometry',
          useFor: 'Anchor changes inside a fixed parent',
          avoidWhen: 'You need absolute pixel positions',
          rowColor: Colors.white,
        ),
        _comparisonRow(
          widget: 'AnimatedPositioned',
          drives: 'left/top/right/bottom/width/height (in Stack)',
          useFor: 'Drawers, FAB orbiting, overlay anchors',
          avoidWhen: 'No Stack parent — invalid usage',
          rowColor: const Color(0xFFF5F5F5),
        ),
        _comparisonRow(
          widget: 'AnimatedDefaultTextStyle',
          drives: 'TextStyle for descendant Text',
          useFor: 'Headlines that "grow" on focus',
          avoidWhen: 'You need to change geometry too',
          rowColor: Colors.white,
        ),
        _comparisonRow(
          widget: 'AnimatedTheme',
          drives: 'Whole ThemeData',
          useFor: 'Light/dark toggle, brand color swap',
          avoidWhen: 'Single property change — overkill',
          rowColor: const Color(0xFFF5F5F5),
        ),
        _comparisonRow(
          widget: 'AnimatedSize',
          drives: 'Width and height to fit child',
          useFor: 'Containers that grow with content',
          avoidWhen: 'You need to drive size from outside',
          rowColor: Colors.white,
        ),
        _comparisonRow(
          widget: 'AnimatedOpacity',
          drives: 'opacity double',
          useFor: 'Fade-in toggles',
          avoidWhen: 'You also need to animate geometry',
          rowColor: const Color(0xFFF5F5F5),
        ),
        _comparisonRow(
          widget: 'TweenAnimationBuilder',
          drives: 'Arbitrary tween value',
          useFor: 'Custom interpolations / non-standard types',
          avoidWhen: 'A built-in Animated* already covers it',
          rowColor: Colors.white,
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Text(
            'Rule of thumb: reach for AnimatedContainer when the change is '
            'visually composite (size + color + radius), and reach for the '
            'single-purpose Animated* widgets when only one dimension '
            'changes — they\'re cheaper and more expressive.',
            style: TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
              color: _tableDeep,
            ),
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // GLOSSARY
  // ===================================================================

  final Widget glossary = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 18.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _glossBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _glossTint),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Glossary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: _glossDeep,
          ),
        ),
        const SizedBox(height: 10.0),
        _glossaryEntry(
          term: 'Implicit animation',
          meaning: 'A widget that drives its own interpolation from old '
              'parameter values to new ones whenever it rebuilds — no '
              'controller required.',
          accent: _s1Deep,
        ),
        _glossaryEntry(
          term: 'Duration.zero',
          meaning: 'A zero-length duration that makes Animated* widgets '
              'render the target state instantly. Used here to storyboard '
              'morphs without real time elapsing.',
          accent: _s2Deep,
        ),
        _glossaryEntry(
          term: 'Curve',
          meaning: 'A mapping from [0,1] to [0,1] that reshapes the lerp '
              'rate. Curves.linear is the default; Curves.easeInOut is the '
              'usual artistic choice.',
          accent: _s3Deep,
        ),
        _glossaryEntry(
          term: 'EdgeInsetsGeometry',
          meaning: 'The abstract base for EdgeInsets and '
              'EdgeInsetsDirectional. Both support .lerp.',
          accent: _s4Deep,
        ),
        _glossaryEntry(
          term: 'BoxDecoration',
          meaning: 'Composite decoration carrying color, borderRadius, '
              'border, gradient, image and boxShadow. Each leaf type knows '
              'how to lerp itself.',
          accent: _s5Deep,
        ),
        _glossaryEntry(
          term: 'AlignmentGeometry',
          meaning: 'Anchor expressed as an (x, y) pair in [-1, 1]. '
              'AnimatedAlign lerps these coordinates.',
          accent: _s6Deep,
        ),
        _glossaryEntry(
          term: 'Stack-positioning',
          meaning: 'The (left, top, right, bottom, width, height) tuple '
              'used by Positioned and AnimatedPositioned inside a Stack.',
          accent: _s7Deep,
        ),
        _glossaryEntry(
          term: 'ThemeData.lerp',
          meaning: 'Blends colors, text theme, icon theme and component '
              'themes between two ThemeData instances.',
          accent: _s8Deep,
        ),
        _glossaryEntry(
          term: 'TweenAnimationBuilder',
          meaning: 'Generic builder driving a Tween<T> from start to end '
              'over duration. Useful when a built-in Animated* widget '
              'does not cover your target type.',
          accent: _s9Deep,
        ),
        _glossaryEntry(
          term: 'onEnd callback',
          meaning: 'Called when an Animated* widget finishes its '
              'interpolation. Useful for chaining steps.',
          accent: _s10Deep,
        ),
      ],
    ),
  );

  // ===================================================================
  // EPILOGUE
  // ===================================================================

  final Widget epilogue = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 22.0, bottom: 24.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_epilogueDeep, _epilogueMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _epilogueDeep.withOpacity(0.35),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: _epilogueSoft,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.flag,
                color: _epilogueDeep,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'End of the Morphology Lab',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'AnimatedContainer is your "yes-and" widget. When you want a '
          'composite morph and you do not want to set up a controller, it '
          'is the right tool. When you only need one channel of change, '
          'reach for the single-purpose siblings — they are cheaper, '
          'clearer, and compose nicely with one another.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Takeaways',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '• Implicit animations need only `duration` to come alive.\n'
                '• Set duration: Duration.zero to render target frames.\n'
                '• Composite morph → AnimatedContainer.\n'
                '• Single channel → AnimatedPadding / Align / Positioned.\n'
                '• Text styling → AnimatedDefaultTextStyle.\n'
                '• Theme swap → AnimatedTheme.\n'
                '• When in doubt — TweenAnimationBuilder.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('AnimatedContainer deep-demo tree assembled. Returning MaterialApp.');

  // -------------------------------------------------------------------
  // FINAL RETURN — MaterialApp scaffold required by the harness.
  // -------------------------------------------------------------------

  return MaterialApp(
    title: 'AnimatedContainer Morphology Lab',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: _heroDeep,
      scaffoldBackgroundColor: const Color(0xFFFAFAFC),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _heroDeep,
        brightness: Brightness.light,
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        backgroundColor: _heroDeep,
        foregroundColor: Colors.white,
        elevation: 2.0,
        title: const Text(
          'AnimatedContainer — Deep Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              overview,
              _sectionBanner(
                index: 1,
                title: 'ANIMATEDCONTAINER PRIMITIVES',
                subtitle:
                    'The composite widget — size, color, decoration in one.',
                deep: _s1Deep,
                mid: _s1Mid,
                soft: _s1Bg,
              ),
              section1Body,
              _sectionBanner(
                index: 2,
                title: 'COLOR MORPH',
                subtitle: 'Storyboarding a smooth color ramp via six '
                    'snapshot tiles.',
                deep: _s2Deep,
                mid: _s2Mid,
                soft: _s2Bg,
              ),
              section2Body,
              _sectionBanner(
                index: 3,
                title: 'SIZE MORPH',
                subtitle: 'Width / height pairs walking a diagonal in '
                    '(w, h) space.',
                deep: _s3Deep,
                mid: _s3Mid,
                soft: _s3Bg,
              ),
              section3Body,
              _sectionBanner(
                index: 4,
                title: 'PADDING MORPH',
                subtitle: 'Pushing the child inward without moving the '
                    'outer box.',
                deep: _s4Deep,
                mid: _s4Mid,
                soft: _s4Bg,
              ),
              section4Body,
              _sectionBanner(
                index: 5,
                title: 'BORDERRADIUS MORPH',
                subtitle: 'Square turning to circle — and every corner '
                    'lerping by itself.',
                deep: _s5Deep,
                mid: _s5Mid,
                soft: _s5Bg,
              ),
              section5Body,
              _sectionBanner(
                index: 6,
                title: 'SHAPE & BORDER MORPH',
                subtitle: 'Border width, color, and BoxShape — all in '
                    'one fluid morph.',
                deep: _s6Deep,
                mid: _s6Mid,
                soft: _s6Bg,
              ),
              section6Body,
              _sectionBanner(
                index: 7,
                title: 'DECORATION COMPOSITION',
                subtitle: 'Gradients, shadows and radii moving together '
                    'as one BoxDecoration.',
                deep: _s7Deep,
                mid: _s7Mid,
                soft: _s7Bg,
              ),
              section7Body,
              _sectionBanner(
                index: 8,
                title: 'ANIMATEDPADDING',
                subtitle: 'The single-purpose padding lerper.',
                deep: _s8Deep,
                mid: _s8Mid,
                soft: _s8Bg,
              ),
              section8Body,
              _sectionBanner(
                index: 9,
                title: 'ANIMATEDALIGN',
                subtitle:
                    'Glide a child between anchors inside a fixed parent.',
                deep: _s9Deep,
                mid: _s9Mid,
                soft: _s9Bg,
              ),
              section9Body,
              _sectionBanner(
                index: 10,
                title: 'ANIMATEDPOSITIONED',
                subtitle: 'Lerp the (left, top, right, bottom) tuple in '
                    'a Stack.',
                deep: _s10Deep,
                mid: _s10Mid,
                soft: _s10Bg,
              ),
              section10Body,
              _sectionBanner(
                index: 11,
                title: 'ANIMATEDDEFAULTTEXTSTYLE',
                subtitle: 'Lerp the TextStyle inherited by descendant '
                    'Text widgets.',
                deep: _s11Deep,
                mid: _s11Mid,
                soft: _s11Bg,
              ),
              section11Body,
              _sectionBanner(
                index: 12,
                title: 'ANIMATEDTHEME',
                subtitle: 'Lerp an entire ThemeData — colors, text, '
                    'components in lockstep.',
                deep: _s12Deep,
                mid: _s12Mid,
                soft: _s12Bg,
              ),
              section12Body,
              recipeCards,
              comparisonTable,
              glossary,
              epilogue,
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// END OF SCRIPT — the lab above is fully static: every Animated* widget
// gets `duration: Duration.zero` and so renders its target value
// instantly, turning the entire flipbook into a row of explicit
// snapshots that read like a real-world animation timeline.
// =====================================================================
