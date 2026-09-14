// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep-demo test script: Opacity Choreography Studio
// =====================================================================
// AnimatedOpacity is the implicit-animation cousin of FadeTransition and
// the plain Opacity widget. It takes a raw double in `opacity` and a
// `Duration` — Flutter internally builds a controller, tweens between
// the previous and current opacity over the duration, and rebuilds the
// child each tick. When `duration: Duration.zero` is supplied, the
// widget renders the target opacity immediately, which is exactly what
// this static-snapshot demo needs: every rendered frame is the final
// frame of an instantaneous fade.
//
// Constructor (Flutter SDK):
//   AnimatedOpacity({
//     Key? key,
//     required Widget? child,
//     required double opacity,
//     Curve curve = Curves.linear,
//     required Duration duration,
//     VoidCallback? onEnd,
//     bool alwaysIncludeSemantics = false,
//   });
//
// Sibling widgets covered in this demo:
//   - Opacity                — static alpha layer.
//   - FadeTransition         — explicit Animation<double>.
//   - SliverFadeTransition   — sliver-protocol fade.
//   - AnimatedCrossFade      — two-child opacity exchange.
//   - ShaderMask             — gradient alpha modulation.
//   - ImageFiltered          — pixel post-processing for frosted glass.
//
// This deep demo paints an "Opacity Choreography Studio" — a designer's
// workshop with phase strips, curve studies, ghost trails, frosted
// glass panels, comparison tables, and a closing glossary. Every visible
// fade is a static snapshot: AnimatedOpacity instances use
// Duration.zero, and FadeTransition instances use
// AlwaysStoppedAnimation<double>(t).
// =====================================================================
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// ---------------------------------------------------------------------
// Palette — a copper / teal / sand studio family. Each section claims a
// unique tonal ramp so the eye can navigate at a glance. Colours are
// hand-picked from Material's standard ramps (50/100/300/500/700/900)
// plus a few warm custom shades for hero / epilogue contrast.
// ---------------------------------------------------------------------

const Color _heroDeep = Color(0xFFBF360C); // deep orange 900
const Color _heroMid = Color(0xFFE64A19); // deep orange 700
const Color _heroSoft = Color(0xFFFFCCBC); // deep orange 100

const Color _overviewBg = Color(0xFFFBE9E7); // deep orange 50
const Color _overviewBorder = Color(0xFFFFAB91); // deep orange 200
const Color _overviewText = Color(0xFFBF360C);

// Section 1 — Opacity Primitives (teal)
const Color _s1Bg = Color(0xFFE0F2F1);
const Color _s1Tint = Color(0xFF80CBC4);
const Color _s1Mid = Color(0xFF26A69A);
const Color _s1Deep = Color(0xFF00695C);

// Section 2 — AnimatedOpacity Phase Strips (amber)
const Color _s2Bg = Color(0xFFFFF8E1);
const Color _s2Tint = Color(0xFFFFE082);
const Color _s2Mid = Color(0xFFFFB300);
const Color _s2Deep = Color(0xFFFF6F00);

// Section 3 — FadeTransition Reels (indigo)
const Color _s3Bg = Color(0xFFE8EAF6);
const Color _s3Tint = Color(0xFF9FA8DA);
const Color _s3Mid = Color(0xFF5C6BC0);
const Color _s3Deep = Color(0xFF283593);

// Section 4 — AnimatedCrossFade Comparisons (pink)
const Color _s4Bg = Color(0xFFFCE4EC);
const Color _s4Tint = Color(0xFFF48FB1);
const Color _s4Mid = Color(0xFFEC407A);
const Color _s4Deep = Color(0xFFAD1457);

// Section 5 — ShaderMask Gradients (purple)
const Color _s5Bg = Color(0xFFF3E5F5);
const Color _s5Tint = Color(0xFFCE93D8);
const Color _s5Mid = Color(0xFFAB47BC);
const Color _s5Deep = Color(0xFF6A1B9A);

// Section 6 — ImageFiltered Glass (cyan)
const Color _s6Bg = Color(0xFFE0F7FA);
const Color _s6Tint = Color(0xFF80DEEA);
const Color _s6Mid = Color(0xFF26C6DA);
const Color _s6Deep = Color(0xFF00838F);

// Section 7 — Stacked Translucency (green)
const Color _s7Bg = Color(0xFFE8F5E9);
const Color _s7Tint = Color(0xFFA5D6A7);
const Color _s7Mid = Color(0xFF66BB6A);
const Color _s7Deep = Color(0xFF2E7D32);

// Section 8 — Curve Studies (brown)
const Color _s8Bg = Color(0xFFEFEBE9);
const Color _s8Tint = Color(0xFFBCAAA4);
const Color _s8Mid = Color(0xFF8D6E63);
const Color _s8Deep = Color(0xFF4E342E);

// Section 9 — Ghost Trails (blue grey)
const Color _s9Bg = Color(0xFFECEFF1);
const Color _s9Tint = Color(0xFFB0BEC5);
const Color _s9Mid = Color(0xFF607D8B);
const Color _s9Deep = Color(0xFF263238);

// Section 10 — Layer Compositions (lime)
const Color _s10Bg = Color(0xFFF9FBE7);
const Color _s10Tint = Color(0xFFE6EE9C);
const Color _s10Mid = Color(0xFFCDDC39);
const Color _s10Deep = Color(0xFF827717);

// Section 11 — Comparison Table (slate)
const Color _s11Bg = Color(0xFFECEFF1);
const Color _s11Tint = Color(0xFF90A4AE);
const Color _s11Mid = Color(0xFF455A64);
const Color _s11Deep = Color(0xFF1C2A30);

// Section 12 — Glossary (sand)
const Color _s12Bg = Color(0xFFFFF3E0);
const Color _s12Tint = Color(0xFFFFCC80);
const Color _s12Mid = Color(0xFFFB8C00);
const Color _s12Deep = Color(0xFFE65100);

// Epilogue family (warm copper)
const Color _epilogueDeep = Color(0xFF3E2723);
const Color _epilogueMid = Color(0xFF6D4C41);
const Color _epilogueSoft = Color(0xFFD7CCC8);

// ---------------------------------------------------------------------
// Tiny visual helpers — top-level functions only. No StatefulWidget,
// no StatelessWidget subclass, no controllers, no setState.
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

Widget _codeBlock({
  required String code,
  required Color accent,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        height: 1.55,
        color: Color(0xFF263238),
      ),
    ),
  );
}

Widget _quoteCard({
  required String title,
  required String body,
  required Color accent,
  required Color background,
  required IconData icon,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 18.0),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          body,
          style: const TextStyle(
            fontSize: 12.5,
            height: 1.55,
            color: Color(0xFF424242),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Frozen-frame tile — an AnimatedOpacity locked to a target opacity
// with duration: Duration.zero so the rendered output matches the
// target value exactly. The tile reads like one frame in a flipbook.
// ---------------------------------------------------------------------

Widget _animTile({
  required double t,
  required Color base,
  required String label,
  IconData icon = Icons.brightness_1,
}) {
  return Container(
    width: 92.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 88.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: AnimatedOpacity(
            opacity: t,
            duration: Duration.zero,
            child: Container(
              width: 68.0,
              height: 68.0,
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 26.0),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          't = ${t.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10.5, color: Color(0xFF616161)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// FadeTransition-based frozen-frame tile — same idea but driven by
// AlwaysStoppedAnimation<double>(t) instead of AnimatedOpacity.
// ---------------------------------------------------------------------

Widget _fadeTile({
  required double t,
  required Color base,
  required String label,
  IconData icon = Icons.invert_colors,
}) {
  return Container(
    width: 92.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 88.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(t),
            child: Container(
              width: 68.0,
              height: 68.0,
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 26.0),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          't = ${t.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10.5, color: Color(0xFF616161)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Comparison-table row.
// ---------------------------------------------------------------------

Widget _comparisonRow({
  required String widget,
  required String inputType,
  required String control,
  required String rebuilds,
  required String when,
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
        Expanded(flex: 3, child: Text(inputType, style: base)),
        Expanded(flex: 3, child: Text(control, style: base)),
        Expanded(flex: 3, child: Text(rebuilds, style: base)),
        Expanded(flex: 4, child: Text(when, style: base)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Glossary entry.
// ---------------------------------------------------------------------

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

// ---------------------------------------------------------------------
// Card panel — used by many sections for individual demo cards.
// ---------------------------------------------------------------------

Widget _panelCard({
  required String title,
  required String caption,
  required IconData icon,
  required Color accent,
  required Color background,
  required Widget preview,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withOpacity(0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.08),
          blurRadius: 6.0,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(9.0),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 18.0),
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
                      fontSize: 14.5,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    caption,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        preview,
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Medallion — round icon disc used inside hero/section accents.
// ---------------------------------------------------------------------

Widget _medallion({
  required IconData icon,
  required Color background,
  required Color foreground,
  double size = 36.0,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: background,
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: foreground.withOpacity(0.15),
          blurRadius: 4.0,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Icon(icon, color: foreground, size: size * 0.55),
  );
}

// ---------------------------------------------------------------------
// CrossFade snapshot — chooses first/second based on the supplied
// CrossFadeState, mimicking a frozen frame of the implicit transition.
// ---------------------------------------------------------------------

Widget _crossFadeTile({
  required CrossFadeState state,
  required Color colorA,
  required Color colorB,
  required String labelA,
  required String labelB,
}) {
  return Container(
    width: 110.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 88.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: AnimatedCrossFade(
            duration: Duration.zero,
            crossFadeState: state,
            firstChild: Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: colorA,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text(
                labelA,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            secondChild: Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: colorB,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text(
                labelB,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          state == CrossFadeState.showFirst ? 'state: first' : 'state: second',
          style: const TextStyle(
            fontSize: 10.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// MAIN ENTRY POINT — Opacity Choreography Studio
// =====================================================================

dynamic build(BuildContext context) {
  print('=== Opacity Choreography Studio — Deep Demo ===');
  print('Sections: 12 (primitives, phase strips, fade reels,');
  print('  crossfade, shader masks, image filtered, stacked,');
  print('  curves, ghost trails, compositions, comparison, glossary).');

  // Canonical opacity stops used across many sections.
  const List<double> stops = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  print('Canonical opacity stops: $stops');

  // -------------------------------------------------------------------
  // HERO HEADER
  // -------------------------------------------------------------------

  final Widget hero = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_heroDeep, _heroMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _heroDeep.withOpacity(0.25),
          blurRadius: 16.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _heroSoft,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(Icons.opacity, color: _heroDeep, size: 28.0),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'Opacity\nChoreography Studio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'A workshop in translucency — AnimatedOpacity at every phase, '
          'FadeTransition reels, AnimatedCrossFade exchanges, ShaderMask '
          'gradients, frosted glass, ghost trails, and curve studies. All '
          'rendered from static snapshot animations: no controllers, no '
          'setState, no timers.',
          style: TextStyle(color: _heroSoft, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _chip('12 sections', Colors.white, _heroDeep),
            _chip('6 opacity stops', Colors.white, _heroDeep),
            _chip('Duration.zero snapshots', Colors.white, _heroDeep),
            _chip('static-only', Colors.white, _heroDeep),
            _chip('analyzer-clean', Colors.white, _heroDeep),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // CONCEPT OVERVIEW
  // -------------------------------------------------------------------

  final Widget overview = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 18.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _overviewBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _overviewBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _heroMid,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.menu_book,
                  color: Colors.white, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Concept Overview',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _overviewText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'AnimatedOpacity is the implicit fade. It takes a raw double and '
          'a Duration; Flutter constructs an internal controller and lerps '
          'between old and new opacity. With duration: Duration.zero, the '
          'widget renders the target opacity immediately — useful for '
          'tests, demos, and reactive UIs that already have their own '
          'animation source.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        Text(
          'You will meet, in order:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: _overviewText,
          ),
        ),
        const SizedBox(height: 6.0),
        _bullet('Section 1 — Opacity primitives side-by-side.', _heroMid),
        _bullet('Section 2 — AnimatedOpacity phase strips.', _heroMid),
        _bullet('Section 3 — FadeTransition reels.', _heroMid),
        _bullet('Section 4 — AnimatedCrossFade comparisons.', _heroMid),
        _bullet('Section 5 — ShaderMask alpha gradients.', _heroMid),
        _bullet('Section 6 — ImageFiltered frosted glass.', _heroMid),
        _bullet('Section 7 — Stacked translucent panels.', _heroMid),
        _bullet('Section 8 — Curve studies (linear vs eased).', _heroMid),
        _bullet('Section 9 — Ghost trails / motion residue.', _heroMid),
        _bullet('Section 10 — Layer compositions.', _heroMid),
        _bullet('Section 11 — Comparison table.', _heroMid),
        _bullet('Section 12 — Glossary + epilogue.', _heroMid),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 1 — OPACITY PRIMITIVES SIDE-BY-SIDE
  // Three widgets, same alpha. Opacity, AnimatedOpacity, FadeTransition.
  // -------------------------------------------------------------------

  final Widget section1Body = _sectionBody(
    bg: _s1Bg,
    border: _s1Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Flutter offers three first-class ways to render a partially '
          'transparent widget. They differ in API ergonomics but produce '
          'identical pixels for the same alpha value.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 92.0,
                    height: 92.0,
                    decoration: BoxDecoration(
                      color: _s1Mid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.layers,
                        color: Colors.white, size: 32.0),
                  ),
                ),
                const SizedBox(height: 6.0),
                _chip('Opacity', _s1Tint, _s1Deep),
              ],
            ),
            Column(
              children: <Widget>[
                AnimatedOpacity(
                  opacity: 0.5,
                  duration: Duration.zero,
                  child: Container(
                    width: 92.0,
                    height: 92.0,
                    decoration: BoxDecoration(
                      color: _s1Mid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.animation,
                        color: Colors.white, size: 32.0),
                  ),
                ),
                const SizedBox(height: 6.0),
                _chip('AnimatedOpacity', _s1Tint, _s1Deep),
              ],
            ),
            Column(
              children: <Widget>[
                FadeTransition(
                  opacity: const AlwaysStoppedAnimation<double>(0.5),
                  child: Container(
                    width: 92.0,
                    height: 92.0,
                    decoration: BoxDecoration(
                      color: _s1Mid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.tune,
                        color: Colors.white, size: 32.0),
                  ),
                ),
                const SizedBox(height: 6.0),
                _chip('FadeTransition', _s1Tint, _s1Deep),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          accent: _s1Mid,
          code: 'AnimatedOpacity(\n'
              '  opacity: 0.5,\n'
              '  duration: Duration.zero,\n'
              '  child: Container(...),\n'
              ')',
        ),
        const SizedBox(height: 10.0),
        _bullet('Opacity is the cheapest — no animation, no rebuild.',
            _s1Mid),
        _bullet('AnimatedOpacity is implicit — change `opacity` and the '
            'widget lerps automatically.', _s1Mid),
        _bullet('FadeTransition is explicit — bring your own Animation.',
            _s1Mid),
        _bullet('All three respect `alwaysIncludeSemantics`.', _s1Mid),
        _quoteCard(
          title: 'Designer\'s note',
          icon: Icons.lightbulb,
          accent: _s1Deep,
          background: Colors.white,
          body: 'When in doubt, reach for Opacity. Promote to AnimatedOpacity '
              'the moment a value changes, and promote again to '
              'FadeTransition when you need shared timing with sibling '
              'widgets.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 2 — ANIMATEDOPACITY PHASE STRIPS
  // The signature view: six tiles at t = 0.0, 0.2, 0.4, 0.6, 0.8, 1.0.
  // -------------------------------------------------------------------

  final Widget section2Body = _sectionBody(
    bg: _s2Bg,
    border: _s2Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The phase strip is the signature view of the studio: six '
          'AnimatedOpacity instances, each pinned to its own target '
          'opacity with duration: Duration.zero. Read left-to-right as a '
          'fade-in storyboard or right-to-left as a fade-out.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (final double t in stops)
                _animTile(
                  t: t,
                  base: _s2Deep,
                  label: t == 0.0
                      ? 'hidden'
                      : t == 1.0
                          ? 'solid'
                          : 'phase',
                  icon: Icons.brightness_5,
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Same six stops, this time fading text rather than a block. '
          'The child geometry is identical at every stop — only the alpha '
          'channel changes.',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF424242)),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final double t in stops)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 60.0,
                        child: Text(
                          't=${t.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AnimatedOpacity(
                          opacity: t,
                          duration: Duration.zero,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: _s2Mid,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'OPACITY CHOREOGRAPHY',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          accent: _s2Mid,
          code: 'for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0])\n'
              '  AnimatedOpacity(\n'
              '    opacity: t,\n'
              '    duration: Duration.zero,\n'
              '    child: ChildWidget(),\n'
              '  )',
        ),
        _quoteCard(
          title: 'Why six stops?',
          icon: Icons.format_list_numbered,
          accent: _s2Deep,
          background: Colors.white,
          body: 'Five stops (0.00, 0.25, 0.50, 0.75, 1.00) feel too coarse '
              'for fade studies. Six (0.0, 0.2, 0.4, 0.6, 0.8, 1.0) keep '
              'the math friendly while showing the early-fade shoulder '
              'between 0.2 and 0.4 — the perceptually critical zone.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 3 — FADETRANSITION REELS
  // Two reels: ascending and descending. Both driven by
  // AlwaysStoppedAnimation<double>.
  // -------------------------------------------------------------------

  final Widget section3Body = _sectionBody(
    bg: _s3Bg,
    border: _s3Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'FadeTransition is the explicit cousin: it takes an '
          'Animation<double> and rebuilds the child whenever that '
          'animation notifies. With AlwaysStoppedAnimation<double>(t) we '
          'pin a single frame — perfect for snapshot tests.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Reel A — Ascending (fade-in storyboard):',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: _s3Deep,
          ),
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (final double t in stops)
                _fadeTile(
                  t: t,
                  base: _s3Deep,
                  label: 'reel A',
                  icon: Icons.play_arrow,
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Reel B — Descending (fade-out storyboard):',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: _s3Deep,
          ),
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (final double t in stops.reversed)
                _fadeTile(
                  t: t,
                  base: _s3Mid,
                  label: 'reel B',
                  icon: Icons.stop,
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          accent: _s3Mid,
          code: 'FadeTransition(\n'
              '  opacity: AlwaysStoppedAnimation<double>(t),\n'
              '  child: ChildWidget(),\n'
              ')',
        ),
        _quoteCard(
          title: 'Reels vs strips',
          icon: Icons.movie,
          accent: _s3Deep,
          background: Colors.white,
          body: 'A "phase strip" pins values to specific points in a fade. '
              'A "reel" treats those same values as frames of a film. The '
              'visual difference is zero; the mental model is everything.',
        ),
      ],
    ),
  );

  print('Sections 1-3 built.');

  // -------------------------------------------------------------------
  // SECTION 4 — ANIMATEDCROSSFADE COMPARISONS
  // -------------------------------------------------------------------

  final Widget section4Body = _sectionBody(
    bg: _s4Bg,
    border: _s4Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedCrossFade swaps between two children using an opacity '
          'cross-fade plus an optional size transition. With '
          'duration: Duration.zero, it shows whichever child the '
          '`crossFadeState` selects with no transition at all.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _crossFadeTile(
              state: CrossFadeState.showFirst,
              colorA: _s4Mid,
              colorB: _s4Deep,
              labelA: 'first',
              labelB: 'second',
            ),
            _crossFadeTile(
              state: CrossFadeState.showSecond,
              colorA: _s4Mid,
              colorB: _s4Deep,
              labelA: 'first',
              labelB: 'second',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _crossFadeTile(
              state: CrossFadeState.showFirst,
              colorA: const Color(0xFFD81B60),
              colorB: const Color(0xFF8E24AA),
              labelA: 'login',
              labelB: 'logout',
            ),
            _crossFadeTile(
              state: CrossFadeState.showSecond,
              colorA: const Color(0xFFD81B60),
              colorB: const Color(0xFF8E24AA),
              labelA: 'login',
              labelB: 'logout',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          accent: _s4Mid,
          code: 'AnimatedCrossFade(\n'
              '  duration: Duration.zero,\n'
              '  crossFadeState: CrossFadeState.showFirst,\n'
              '  firstChild: WidgetA(),\n'
              '  secondChild: WidgetB(),\n'
              ')',
        ),
        _bullet('Two children must be supplied; both stay in the tree.',
            _s4Mid),
        _bullet('Use it for boolean state: signed-in vs signed-out, '
            'loading vs loaded, edit vs view.', _s4Mid),
        _bullet('The size transition can be tuned via sizeCurve.', _s4Mid),
        _quoteCard(
          title: 'CrossFade vs Opacity stack',
          icon: Icons.compare_arrows,
          accent: _s4Deep,
          background: Colors.white,
          body: 'A Stack of two Opacity widgets sums alpha; AnimatedCrossFade '
              'splits 1.0 between them. The visual feel is similar, but '
              'CrossFade also animates the bounding size — useful when the '
              'two children differ in dimensions.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 5 — SHADERMASK ALPHA GRADIENTS
  // -------------------------------------------------------------------

  final Widget section5Body = _sectionBody(
    bg: _s5Bg,
    border: _s5Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ShaderMask paints a shader (typically a LinearGradient) onto the '
          'child, modulating each pixel by the shader\'s alpha. By choosing '
          'a gradient from transparent to opaque white, the child fades '
          'spatially rather than temporally.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0x00FFFFFF),
                Color(0xFFFFFFFF),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: _s5Mid,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              'HORIZONTAL FADE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFFFFFFF),
                Color(0x00FFFFFF),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: _s5Deep,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              'VERTICAL FADE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const RadialGradient(
              center: Alignment.center,
              radius: 0.7,
              colors: <Color>[
                Color(0xFFFFFFFF),
                Color(0x00FFFFFF),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            width: double.infinity,
            height: 100.0,
            decoration: BoxDecoration(
              color: _s5Tint,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              'RADIAL VIGNETTE',
              style: TextStyle(
                color: Color(0xFF4A148C),
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          accent: _s5Mid,
          code: 'ShaderMask(\n'
              '  shaderCallback: (rect) => LinearGradient(\n'
              '    colors: [transparent, white],\n'
              '  ).createShader(rect),\n'
              '  blendMode: BlendMode.dstIn,\n'
              '  child: ChildWidget(),\n'
              ')',
        ),
        _quoteCard(
          title: 'Temporal vs spatial',
          icon: Icons.gradient,
          accent: _s5Deep,
          background: Colors.white,
          body: 'AnimatedOpacity fades the whole child in time. ShaderMask '
              'fades parts of the child in space. They compose: wrap a '
              'ShaderMask in an AnimatedOpacity to dissolve a gradient '
              'mask over time.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 6 — IMAGEFILTERED FROSTED GLASS
  // -------------------------------------------------------------------

  final Widget section6Body = _sectionBody(
    bg: _s6Bg,
    border: _s6Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ImageFiltered applies a Gaussian blur (or other ui.ImageFilter) '
          'to its child. Combined with a translucent overlay it becomes '
          'the iOS-style frosted-glass effect, also known as a backdrop '
          'blur.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0xFF00838F),
                Color(0xFF4DD0E1),
                Color(0xFFFFAB91),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Center(
                  child: Container(
                    width: 220.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.45),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'FROSTED GLASS PANEL',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (final double sigma in <double>[0.0, 2.0, 5.0])
              Column(
                children: <Widget>[
                  ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(
                      sigmaX: sigma,
                      sigmaY: sigma,
                    ),
                    child: Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: _s6Mid,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.blur_on,
                        color: Colors.white,
                        size: 36.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'sigma ${sigma.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          accent: _s6Mid,
          code: 'ImageFiltered(\n'
              '  imageFilter: ui.ImageFilter.blur(\n'
              '    sigmaX: 5.0, sigmaY: 5.0),\n'
              '  child: ChildWidget(),\n'
              ')',
        ),
        _quoteCard(
          title: 'Glass is layered translucency',
          icon: Icons.filter_drama,
          accent: _s6Deep,
          background: Colors.white,
          body: 'A frosted panel is just an ImageFiltered blur underneath a '
              'translucent white container. AnimatedOpacity sits on the '
              'top layer to fade the highlight while the blur stays put — '
              'the secret to a believable glass animation.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 7 — STACKED TRANSLUCENCY
  // -------------------------------------------------------------------

  final Widget section7Body = _sectionBody(
    bg: _s7Bg,
    border: _s7Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Three translucent panels stacked on top of one another. Each '
          'panel uses AnimatedOpacity with duration: Duration.zero so the '
          'rendered alpha matches the target exactly. The composited '
          'result demonstrates additive translucency.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 200.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 10.0,
                top: 10.0,
                child: AnimatedOpacity(
                  opacity: 0.7,
                  duration: Duration.zero,
                  child: Container(
                    width: 160.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: _s7Mid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Layer 1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70.0,
                top: 40.0,
                child: AnimatedOpacity(
                  opacity: 0.6,
                  duration: Duration.zero,
                  child: Container(
                    width: 160.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: _s7Deep,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Layer 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 130.0,
                top: 70.0,
                child: AnimatedOpacity(
                  opacity: 0.5,
                  duration: Duration.zero,
                  child: Container(
                    width: 160.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: _s7Tint,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Layer 3',
                      style: TextStyle(
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _panelCard(
          title: 'Nested AnimatedOpacity multiplies alpha',
          caption: 'opacity 0.5 × opacity 0.5 → effective 0.25',
          icon: Icons.layers,
          accent: _s7Deep,
          background: Colors.white,
          preview: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              AnimatedOpacity(
                opacity: 0.5,
                duration: Duration.zero,
                child: AnimatedOpacity(
                  opacity: 0.5,
                  duration: Duration.zero,
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: _s7Deep,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.layers,
                        color: Colors.white, size: 28.0),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: 0.25,
                duration: Duration.zero,
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: _s7Deep,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.equalizer,
                      color: Colors.white, size: 28.0),
                ),
              ),
            ],
          ),
        ),
        _bullet('Stack order matters: later children draw on top.', _s7Mid),
        _bullet('Each AnimatedOpacity composites with the layers beneath.',
            _s7Mid),
        _bullet('To compose 0.5 × 0.5, prefer a single Opacity(0.25) — '
            'fewer compositing layers.', _s7Mid),
        _quoteCard(
          title: 'Performance footnote',
          icon: Icons.speed,
          accent: _s7Deep,
          background: Colors.white,
          body: 'Every translucent layer adds a saveLayer call. On older '
              'devices, three stacked AnimatedOpacity widgets can drop the '
              'frame rate noticeably. When stacking matters more than '
              'animating, prefer the static Opacity widget.',
        ),
      ],
    ),
  );

  print('Sections 4-7 built.');

  // -------------------------------------------------------------------
  // SECTION 8 — CURVE STUDIES
  // Visualise how different Curve objects map a linear t to alpha.
  // Each row freezes one curve at the canonical six stops.
  // -------------------------------------------------------------------

  Widget curveRow(String name, Curve curve, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              for (final double t in stops)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Column(
                    children: <Widget>[
                      AnimatedOpacity(
                        // Clamp because non-monotone curves (bounceIn,
                        // elasticOut) return values outside [0.0, 1.0],
                        // which would violate AnimatedOpacity's assertion.
                        opacity: curve.transform(t).clamp(0.0, 1.0),
                        duration: Duration.zero,
                        child: Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        curve.transform(t).toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget section8Body = _sectionBody(
    bg: _s8Bg,
    border: _s8Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedOpacity also accepts a `curve` (default Curves.linear). '
          'For a static snapshot, the curve is applied to the input t to '
          'produce the rendered alpha. Each row below freezes one curve '
          'at the canonical six stops, showing how the same input t '
          'produces different alphas under different curves.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              curveRow('Curves.linear', Curves.linear, _s8Deep),
              curveRow('Curves.ease', Curves.ease, _s8Mid),
              curveRow('Curves.easeIn', Curves.easeIn, const Color(0xFF6D4C41)),
              curveRow('Curves.easeOut', Curves.easeOut, const Color(0xFF5D4037)),
              curveRow('Curves.easeInOut', Curves.easeInOut, _s8Deep),
              curveRow('Curves.decelerate', Curves.decelerate, _s8Mid),
              curveRow('Curves.bounceIn', Curves.bounceIn,
                  const Color(0xFFA1887F)),
              curveRow('Curves.elasticOut', Curves.elasticOut,
                  const Color(0xFF795548)),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          accent: _s8Mid,
          code: 'AnimatedOpacity(\n'
              '  opacity: t,\n'
              '  duration: Duration(milliseconds: 400),\n'
              '  curve: Curves.easeInOut,\n'
              '  child: ChildWidget(),\n'
              ')',
        ),
        _quoteCard(
          title: 'Curve choice is taste',
          icon: Icons.timeline,
          accent: _s8Deep,
          background: Colors.white,
          body: 'Curves.linear is honest but boring. Curves.ease and '
              'Curves.easeInOut are the default-choice workhorses. '
              'Curves.bounceIn or Curves.elasticOut feel playful but '
              'almost never belong on opacity — bouncing alpha looks '
              'broken. Stick to monotone curves for fades.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 9 — GHOST TRAILS
  // -------------------------------------------------------------------

  final Widget section9Body = _sectionBody(
    bg: _s9Bg,
    border: _s9Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A "ghost trail" is the visual residue left by a moving subject. '
          'We fake it by laying down several translucent copies of the same '
          'shape, each offset and each at a lower opacity than the next. '
          'AnimatedOpacity with Duration.zero pins every trail-frame to a '
          'specific alpha.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 110.0,
          child: Stack(
            children: <Widget>[
              for (int i = 0; i < 6; i++)
                Positioned(
                  left: i * 38.0,
                  top: 20.0,
                  child: AnimatedOpacity(
                    opacity: (i + 1) / 6.0,
                    duration: Duration.zero,
                    child: Container(
                      width: 52.0,
                      height: 52.0,
                      decoration: BoxDecoration(
                        color: _s9Deep,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Same idea, vertical trail with a colour shift:',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF424242)),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 220.0,
          child: Stack(
            children: <Widget>[
              for (int i = 0; i < 6; i++)
                Positioned(
                  left: 100.0,
                  top: i * 30.0,
                  child: AnimatedOpacity(
                    opacity: 1.0 - (i / 6.0),
                    duration: Duration.zero,
                    child: Container(
                      width: 80.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          _s9Mid,
                          _s9Tint,
                          i / 5.0,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          accent: _s9Mid,
          code: 'for (int i = 0; i < 6; i++)\n'
              '  Positioned(\n'
              '    left: i * 38.0,\n'
              '    child: AnimatedOpacity(\n'
              '      opacity: (i + 1) / 6.0,\n'
              '      duration: Duration.zero,\n'
              '      child: CircleAvatar(...),\n'
              '    ),\n'
              '  )',
        ),
        _quoteCard(
          title: 'Trails are storytelling',
          icon: Icons.auto_awesome_motion,
          accent: _s9Deep,
          background: Colors.white,
          body: 'A trail is not motion — it is the memory of motion. The '
              'eye reads the brightest frame as "now" and the dimmest as '
              '"a moment ago". Reverse the alpha ramp and your trail '
              'starts predicting the future instead of recording the past.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 10 — LAYER COMPOSITIONS
  // -------------------------------------------------------------------

  final Widget section10Body = _sectionBody(
    bg: _s10Bg,
    border: _s10Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Combinations of opacity primitives produce effects no single '
          'widget can. Here we compose ShaderMask with AnimatedOpacity, '
          'and ImageFiltered with FadeTransition.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        _panelCard(
          title: 'ShaderMask under AnimatedOpacity',
          caption: 'Spatial gradient fade modulated by a temporal alpha.',
          icon: Icons.brush,
          accent: _s10Deep,
          background: Colors.white,
          preview: AnimatedOpacity(
            opacity: 0.7,
            duration: Duration.zero,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0x00FFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                width: double.infinity,
                height: 70.0,
                decoration: BoxDecoration(
                  color: _s10Deep,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'SHADER + OPACITY',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        _panelCard(
          title: 'ImageFiltered + FadeTransition',
          caption: 'Blurred child rendered at half alpha.',
          icon: Icons.blur_circular,
          accent: _s10Deep,
          background: Colors.white,
          preview: FadeTransition(
            opacity: const AlwaysStoppedAnimation<double>(0.5),
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                width: double.infinity,
                height: 70.0,
                decoration: BoxDecoration(
                  color: _s10Mid,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'BLUR + FADE',
                  style: TextStyle(
                    color: Color(0xFF33691E),
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        _panelCard(
          title: 'Triple-stack with ColorFiltered',
          caption: 'Translucent layers with colour overlay.',
          icon: Icons.palette,
          accent: _s10Deep,
          background: Colors.white,
          preview: SizedBox(
            height: 110.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFB300),
                          Color(0xFFFB8C00),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: 0.4,
                    duration: Duration.zero,
                    child: Container(
                      color: _s10Deep,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: 0.6,
                    duration: Duration.zero,
                    child: const Center(
                      child: Text(
                        'COMPOSITION',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _quoteCard(
          title: 'Compose like a painter',
          icon: Icons.brush,
          accent: _s10Deep,
          background: Colors.white,
          body: 'Each translucency widget is a glaze. Layer them sparingly '
              'and your composition gains depth; layer them carelessly and '
              'the whole frame turns to mud. The eye prefers two glazes '
              'over five.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 11 — COMPARISON TABLE
  // -------------------------------------------------------------------

  final Widget section11Body = _sectionBody(
    bg: _s11Bg,
    border: _s11Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The four implicit / explicit / static / two-child fade '
          'primitives side-by-side, scored by input type, control source, '
          'rebuild behaviour, and the situations they handle best.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _s11Tint),
          ),
          child: Column(
            children: <Widget>[
              _comparisonRow(
                widget: 'Widget',
                inputType: 'Input',
                control: 'Controller',
                rebuilds: 'Rebuilds',
                when: 'When to use',
                rowColor: _s11Deep,
                bold: true,
              ),
              _comparisonRow(
                widget: 'Opacity',
                inputType: 'double',
                control: 'none',
                rebuilds: 'on prop change',
                when: 'Static alpha, no animation.',
                rowColor: Colors.white,
              ),
              _comparisonRow(
                widget: 'AnimatedOpacity',
                inputType: 'double + Duration',
                control: 'internal',
                rebuilds: 'each tick',
                when: 'Value-driven fades with implicit timing.',
                rowColor: const Color(0xFFF5F7F9),
              ),
              _comparisonRow(
                widget: 'FadeTransition',
                inputType: 'Animation<double>',
                control: 'caller-owned',
                rebuilds: 'each tick',
                when: 'Shared timing with sibling animations.',
                rowColor: Colors.white,
              ),
              _comparisonRow(
                widget: 'AnimatedCrossFade',
                inputType: '2 children + state',
                control: 'internal',
                rebuilds: 'each tick',
                when: 'Boolean state with two distinct layouts.',
                rowColor: const Color(0xFFF5F7F9),
              ),
              _comparisonRow(
                widget: 'ShaderMask',
                inputType: 'Shader',
                control: 'caller-owned',
                rebuilds: 'on prop change',
                when: 'Spatial gradient masking, not temporal fade.',
                rowColor: Colors.white,
              ),
              _comparisonRow(
                widget: 'ImageFiltered',
                inputType: 'ui.ImageFilter',
                control: 'caller-owned',
                rebuilds: 'on prop change',
                when: 'Blur / colour-shift / matrix post-process.',
                rowColor: const Color(0xFFF5F7F9),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _quoteCard(
          title: 'Pick by ownership',
          icon: Icons.account_tree,
          accent: _s11Deep,
          background: Colors.white,
          body: 'The question is rarely "what do I want to look like?" — it '
              'is "who owns the timing?" If the caller already has a '
              'controller, choose FadeTransition. If not, choose '
              'AnimatedOpacity. If there is no animation at all, choose '
              'Opacity. The visual result is the same.',
        ),
      ],
    ),
  );

  print('Sections 8-11 built.');

  // -------------------------------------------------------------------
  // SECTION 12 — GLOSSARY
  // -------------------------------------------------------------------

  final Widget section12Body = _sectionBody(
    bg: _s12Bg,
    border: _s12Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Closing reference for every term used in the studio.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        _glossaryEntry(
          term: 'AnimatedOpacity',
          meaning: 'Implicit animation widget. Takes a raw double `opacity` '
              'and a Duration; lerps between previous and current values '
              'using an internally managed controller.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'Opacity (widget)',
          meaning: 'Static alpha layer. No animation, no controller — just '
              'renders the child at a fixed opacity.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'FadeTransition',
          meaning: 'Explicit fade primitive. Wraps a child in an alpha layer '
              'driven by a caller-supplied Animation<double>.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'SliverFadeTransition',
          meaning: 'Sliver-protocol counterpart of FadeTransition. Wraps a '
              'sliver and fades it within the scrolling viewport.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'AnimatedCrossFade',
          meaning: 'Animates between two children using opacity and size. '
              'Selected by a CrossFadeState enum.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'ShaderMask',
          meaning: 'Applies a shader (commonly a LinearGradient) to its '
              'child, modulating each pixel by the shader\'s output — '
              'typically alpha. The basis of spatial fades.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'ImageFiltered',
          meaning: 'Post-processes the child with a ui.ImageFilter (blur, '
              'colour-shift, matrix). Composes with AnimatedOpacity to '
              'fade frosted-glass overlays.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'AlwaysStoppedAnimation<double>',
          meaning: 'An Animation<double> that holds a single static value. '
              'Useful for snapshot tests and for any FadeTransition whose '
              'opacity must not change.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'Duration.zero',
          meaning: 'A Duration of zero ticks. Passed to AnimatedOpacity, the '
              'widget renders the target opacity immediately with no '
              'transition — the workhorse of static demos.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'alwaysIncludeSemantics',
          meaning: 'Boolean flag. When true, the child remains in the '
              'semantics tree even at opacity 0.0 — critical for status '
              'messages that fade out but must still be announced.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'Composed alpha',
          meaning: 'When two translucent widgets are nested, the effective '
              'alpha is the product of their opacity values. Two 0.5 '
              'layers compose to 0.25.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'saveLayer',
          meaning: 'The compositing primitive each translucent widget '
              'allocates. Stacking many of them is the main performance '
              'cost of translucency-heavy UI.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'Phase strip',
          meaning: 'A row of frozen frames at evenly spaced opacity stops. '
              'The canonical introduction to a fade animation.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'Ghost trail',
          meaning: 'A motion-residue effect built by stacking several '
              'translucent copies of a shape at decreasing alpha.',
          accent: _s12Deep,
        ),
        _glossaryEntry(
          term: 'Frosted glass',
          meaning: 'The combination of ImageFiltered (Gaussian blur) and a '
              'translucent white container — iOS-style backdrop blur.',
          accent: _s12Deep,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // EPILOGUE
  // -------------------------------------------------------------------

  final Widget epilogue = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_epilogueDeep, _epilogueMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _medallion(
              icon: Icons.flag,
              background: Colors.white,
              foreground: _epilogueDeep,
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Epilogue',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Opacity is one of Flutter\'s gentlest tools — a single channel, '
          'one number from 0.0 to 1.0 — and yet the difference between a '
          'merely-functional UI and one that breathes is almost always '
          'measured in how its alpha channels move. AnimatedOpacity is '
          'the friendly default: pass a double, pass a duration, let the '
          'framework do the rest. Promote to FadeTransition when the '
          'timing must be shared, demote to Opacity when the value is '
          'fixed, and reach for ShaderMask or ImageFiltered when the '
          'effect must be spatial rather than temporal.',
          style: TextStyle(
            color: _epilogueSoft,
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Take-aways',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '• opacity is a double from 0.0 to 1.0.\n'
                '• Duration.zero pins the target alpha immediately.\n'
                '• curve maps the input t through a non-linear shape.\n'
                '• alwaysIncludeSemantics keeps invisible copy announceable.\n'
                '• Nested opacities multiply — be sparing with layers.\n'
                '• Static alpha → Opacity.\n'
                '• Implicit fade → AnimatedOpacity.\n'
                '• Controller-driven fade → FadeTransition.\n'
                '• Two-child swap → AnimatedCrossFade.\n'
                '• Spatial gradient → ShaderMask.\n'
                '• Frosted glass → ImageFiltered + translucent overlay.',
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

  print('Section 12 + epilogue built. Returning MaterialApp.');

  // -------------------------------------------------------------------
  // FINAL RETURN — MaterialApp scaffold required by the harness.
  // -------------------------------------------------------------------

  return MaterialApp(
    title: 'Opacity Choreography Studio',
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
          'Opacity Choreography — Deep Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              overview,
              _sectionBanner(
                index: 1,
                title: 'OPACITY PRIMITIVES',
                subtitle: 'Three first-class widgets, identical pixels.',
                deep: _s1Deep,
                mid: _s1Mid,
                soft: _s1Bg,
              ),
              section1Body,
              _sectionBanner(
                index: 2,
                title: 'ANIMATEDOPACITY PHASE STRIPS',
                subtitle: 'Six frozen frames per row — the signature view.',
                deep: _s2Deep,
                mid: _s2Mid,
                soft: _s2Bg,
              ),
              section2Body,
              _sectionBanner(
                index: 3,
                title: 'FADETRANSITION REELS',
                subtitle: 'Explicit-Animation cousin, frame by frame.',
                deep: _s3Deep,
                mid: _s3Mid,
                soft: _s3Bg,
              ),
              section3Body,
              _sectionBanner(
                index: 4,
                title: 'ANIMATEDCROSSFADE COMPARISONS',
                subtitle: 'Two children, one alpha-swap.',
                deep: _s4Deep,
                mid: _s4Mid,
                soft: _s4Bg,
              ),
              section4Body,
              _sectionBanner(
                index: 5,
                title: 'SHADERMASK GRADIENTS',
                subtitle: 'Spatial fade — alpha in space, not time.',
                deep: _s5Deep,
                mid: _s5Mid,
                soft: _s5Bg,
              ),
              section5Body,
              _sectionBanner(
                index: 6,
                title: 'IMAGEFILTERED GLASS',
                subtitle: 'Frosted backdrop blur with translucent overlay.',
                deep: _s6Deep,
                mid: _s6Mid,
                soft: _s6Bg,
              ),
              section6Body,
              _sectionBanner(
                index: 7,
                title: 'STACKED TRANSLUCENCY',
                subtitle: 'Three panels, additive alpha, one composite.',
                deep: _s7Deep,
                mid: _s7Mid,
                soft: _s7Bg,
              ),
              section7Body,
              _sectionBanner(
                index: 8,
                title: 'CURVE STUDIES',
                subtitle: 'Linear vs eased — same t, different alpha.',
                deep: _s8Deep,
                mid: _s8Mid,
                soft: _s8Bg,
              ),
              section8Body,
              _sectionBanner(
                index: 9,
                title: 'GHOST TRAILS',
                subtitle: 'The memory of motion in six translucent copies.',
                deep: _s9Deep,
                mid: _s9Mid,
                soft: _s9Bg,
              ),
              section9Body,
              _sectionBanner(
                index: 10,
                title: 'LAYER COMPOSITIONS',
                subtitle: 'ShaderMask × AnimatedOpacity × ImageFiltered.',
                deep: _s10Deep,
                mid: _s10Mid,
                soft: _s10Bg,
              ),
              section10Body,
              _sectionBanner(
                index: 11,
                title: 'COMPARISON TABLE',
                subtitle: 'All fade primitives, scored side-by-side.',
                deep: _s11Deep,
                mid: _s11Mid,
                soft: _s11Bg,
              ),
              section11Body,
              _sectionBanner(
                index: 12,
                title: 'GLOSSARY',
                subtitle: 'Closing reference for every term in the studio.',
                deep: _s12Deep,
                mid: _s12Mid,
                soft: _s12Bg,
              ),
              section12Body,
              epilogue,
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}
