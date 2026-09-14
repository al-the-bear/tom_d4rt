// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt deep-demo test script: FadeTransition Reel Gallery
// =====================================================================
// FadeTransition is the explicit, controller-driven cousin of
// AnimatedOpacity and the Opacity widget. While AnimatedOpacity performs
// an implicit setState->lerp->repaint dance and the Opacity widget bakes
// a static double, FadeTransition takes a raw Animation<double> and
// rebuilds its child whenever that animation ticks. Because the
// `opacity` parameter is an Animation<double>, you decide where the
// value comes from — a real AnimationController, a CurvedAnimation, a
// Tween chain, or — as used throughout this static-snapshot demo — an
// AlwaysStoppedAnimation<double> that pins a single frame of the fade.
//
// Constructor (Flutter SDK):
//   FadeTransition({
//     Key? key,
//     required Animation<double> opacity,
//     bool alwaysIncludeSemantics = false,
//     Widget? child,
//   });
//
// Sister widget for slivers:
//   SliverFadeTransition({
//     Key? key,
//     required Animation<double> opacity,
//     bool alwaysIncludeSemantics = false,
//     Widget? sliver,
//   });
//
// This deep demo paints an "Opacity Fade Flipbook" by sweeping the
// opacity stops {0.0, 0.25, 0.5, 0.75, 1.0} and arranging them into
// timeline strips, fade-in / fade-out narratives, layering experiments,
// a SliverFadeTransition in a bounded CustomScrollView, recipe cards,
// comparison tables against AnimatedOpacity & Opacity, and a glossary.
// =====================================================================
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Palette helpers — each section owns a unique tonal family so the
// flipbook reads at a glance. All colors are hand-picked from Material's
// 50/100/300/500/700/900 ramps to give plenty of contrast on white.
// ---------------------------------------------------------------------

const Color _heroDeep = Color(0xFF1A237E); // indigo 900
const Color _heroMid = Color(0xFF3949AB); // indigo 600
const Color _heroSoft = Color(0xFFC5CAE9); // indigo 100

const Color _overviewBg = Color(0xFFE8EAF6); // indigo 50
const Color _overviewBorder = Color(0xFF9FA8DA); // indigo 200
const Color _overviewText = Color(0xFF1A237E);

// Section 1 — Basics (teal)
const Color _s1Bg = Color(0xFFE0F2F1);
const Color _s1Tint = Color(0xFF80CBC4);
const Color _s1Mid = Color(0xFF26A69A);
const Color _s1Deep = Color(0xFF00695C);

// Section 2 — Timeline strip (deep purple)
const Color _s2Bg = Color(0xFFEDE7F6);
const Color _s2Tint = Color(0xFFB39DDB);
const Color _s2Mid = Color(0xFF7E57C2);
const Color _s2Deep = Color(0xFF4527A0);

// Section 3 — Fade-in narrative (green)
const Color _s3Bg = Color(0xFFE8F5E9);
const Color _s3Tint = Color(0xFFA5D6A7);
const Color _s3Mid = Color(0xFF66BB6A);
const Color _s3Deep = Color(0xFF2E7D32);

// Section 4 — Fade-out narrative (red)
const Color _s4Bg = Color(0xFFFFEBEE);
const Color _s4Tint = Color(0xFFEF9A9A);
const Color _s4Mid = Color(0xFFEF5350);
const Color _s4Deep = Color(0xFFC62828);

// Section 5 — alwaysIncludeSemantics (amber)
const Color _s5Bg = Color(0xFFFFF8E1);
const Color _s5Tint = Color(0xFFFFE082);
const Color _s5Mid = Color(0xFFFFCA28);
const Color _s5Deep = Color(0xFFFF8F00);

// Section 6 — Comparison table (blue grey)
const Color _s6Bg = Color(0xFFECEFF1);
const Color _s6Tint = Color(0xFFB0BEC5);
const Color _s6Mid = Color(0xFF607D8B);
const Color _s6Deep = Color(0xFF263238);

// Section 7 — SliverFadeTransition (cyan)
const Color _s7Bg = Color(0xFFE0F7FA);
const Color _s7Tint = Color(0xFF80DEEA);
const Color _s7Mid = Color(0xFF26C6DA);
const Color _s7Deep = Color(0xFF00838F);

// Section 8 — Layering (pink)
const Color _s8Bg = Color(0xFFFCE4EC);
const Color _s8Tint = Color(0xFFF48FB1);
const Color _s8Mid = Color(0xFFEC407A);
const Color _s8Deep = Color(0xFFAD1457);

// Section 9 — Recipes (lime)
const Color _s9Bg = Color(0xFFF9FBE7);
const Color _s9Tint = Color(0xFFE6EE9C);
const Color _s9Mid = Color(0xFFCDDC39);
const Color _s9Deep = Color(0xFF827717);

// Section 10 — Glossary (brown)
const Color _s10Bg = Color(0xFFEFEBE9);
const Color _s10Tint = Color(0xFFBCAAA4);
const Color _s10Mid = Color(0xFF8D6E63);
const Color _s10Deep = Color(0xFF4E342E);

// Epilogue (deep purple, matches hero family)
const Color _epilogueDeep = Color(0xFF311B92);
const Color _epilogueMid = Color(0xFF5E35B1);
const Color _epilogueSoft = Color(0xFFD1C4E9);

// ---------------------------------------------------------------------
// Tiny visual helpers. Top-level functions only — no StatefulWidget,
// no StatelessWidget subclass, no controllers. Each helper returns a
// plain Widget tree that can be inlined anywhere in the section column.
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

Widget _fadeTile({
  required double t,
  required Color base,
  required String label,
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
              child: const Icon(
                Icons.brightness_1,
                color: Colors.white,
                size: 26.0,
              ),
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

Widget _recipeCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accent,
  required Color background,
  required List<String> steps,
  required Widget preview,
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
        preview,
        const SizedBox(height: 12.0),
        for (final String step in steps)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.check_circle, size: 14.0, color: accent),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    step,
                    style: const TextStyle(fontSize: 12.0, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _comparisonRow({
  required String widget,
  required String control,
  required String input,
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
        Expanded(flex: 3, child: Text(input, style: base)),
        Expanded(flex: 3, child: Text(control, style: base)),
        Expanded(flex: 3, child: Text(rebuilds, style: base)),
        Expanded(flex: 4, child: Text(when, style: base)),
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

Widget _sectionBody({required Color bg, required Color border, required Widget child}) {
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

// =====================================================================
// MAIN ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  print('=== FadeTransition Reel Gallery — Deep Demo ===');
  print('Sections: 10 (basics, timeline strip, fade-in narrative,');
  print(' fade-out narrative, alwaysIncludeSemantics, comparison,');
  print(' SliverFadeTransition, layering, recipes, glossary).');

  // -------------------------------------------------------------------
  // Pre-build the 5 canonical opacity stops as snapshot animations.
  // All FadeTransition.opacity values come from these — never from a
  // controller. This keeps the entire demo static and pure.
  // -------------------------------------------------------------------

  final Animation<double> opacity00 = const AlwaysStoppedAnimation<double>(0.0);
  final Animation<double> opacity25 = const AlwaysStoppedAnimation<double>(0.25);
  final Animation<double> opacity50 = const AlwaysStoppedAnimation<double>(0.5);
  final Animation<double> opacity75 = const AlwaysStoppedAnimation<double>(0.75);
  final Animation<double> opacity100 = const AlwaysStoppedAnimation<double>(1.0);

  print('Built five canonical opacity stops:');
  print('  0.00 — fully transparent (dismissed end)');
  print('  0.25 — barely visible ghost');
  print('  0.50 — half-strength wash');
  print('  0.75 — strong but not opaque');
  print('  1.00 — fully visible (completed end)');

  // -------------------------------------------------------------------
  // SECTION 1: BASICS — a single FadeTransition with a clearly labelled
  // child. We show three rendered variants side-by-side (0.0 / 0.5 / 1.0)
  // and a small code-style summary chip strip below each.
  // -------------------------------------------------------------------

  final Widget section1Body = _sectionBody(
    bg: _s1Bg,
    border: _s1Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'FadeTransition wraps any child widget and rebuilds it whenever '
          'the supplied Animation<double> ticks. The child keeps its own '
          'layout and intrinsic size — only its alpha channel is varied.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                FadeTransition(
                  opacity: opacity00,
                  child: Container(
                    width: 92.0,
                    height: 92.0,
                    decoration: BoxDecoration(
                      color: _s1Mid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.visibility_off,
                        color: Colors.white, size: 32.0),
                  ),
                ),
                const SizedBox(height: 6.0),
                _chip('opacity 0.0', _s1Tint, _s1Deep),
              ],
            ),
            Column(
              children: <Widget>[
                FadeTransition(
                  opacity: opacity50,
                  child: Container(
                    width: 92.0,
                    height: 92.0,
                    decoration: BoxDecoration(
                      color: _s1Mid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.preview,
                        color: Colors.white, size: 32.0),
                  ),
                ),
                const SizedBox(height: 6.0),
                _chip('opacity 0.5', _s1Tint, _s1Deep),
              ],
            ),
            Column(
              children: <Widget>[
                FadeTransition(
                  opacity: opacity100,
                  child: Container(
                    width: 92.0,
                    height: 92.0,
                    decoration: BoxDecoration(
                      color: _s1Mid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.visibility,
                        color: Colors.white, size: 32.0),
                  ),
                ),
                const SizedBox(height: 6.0),
                _chip('opacity 1.0', _s1Tint, _s1Deep),
              ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Constructor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: _s1Deep,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'FadeTransition(\n'
                '  opacity: Animation<double>,\n'
                '  alwaysIncludeSemantics: false,\n'
                '  child: Widget?\n'
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
        _bullet('opacity is an Animation<double>, NOT a raw double.', _s1Mid),
        _bullet('AlwaysStoppedAnimation<double>(t) pins a static frame.', _s1Mid),
        _bullet('child is rebuilt on every animation tick — keep it cheap.', _s1Mid),
        _bullet('alwaysIncludeSemantics keeps the subtree readable by '
            'assistive tech even when opacity == 0.0.', _s1Mid),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 2: TIMELINE STRIP — five canonical stops in a single row,
  // the spine of the entire demo. Each tile fades a square shape behind
  // its label, so visual contrast directly tracks t.
  // -------------------------------------------------------------------

  final Widget section2Body = _sectionBody(
    bg: _s2Bg,
    border: _s2Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'The opacity-stop strip sweeps t through 0.00, 0.25, 0.50, 0.75, '
          '1.00. Read it left-to-right as the storyboard of a forward fade-in '
          'or right-to-left as a fade-out.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _fadeTile(t: 0.0, base: _s2Deep, label: 'hidden'),
              _fadeTile(t: 0.25, base: _s2Deep, label: 'ghost'),
              _fadeTile(t: 0.5, base: _s2Deep, label: 'wash'),
              _fadeTile(t: 0.75, base: _s2Deep, label: 'strong'),
              _fadeTile(t: 1.0, base: _s2Deep, label: 'solid'),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Same five stops, this time fading a text label rather than a '
          'block — note how the child geometry is identical at every stop; '
          'only the alpha channel changes.',
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF424242)),
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
              for (final double t in <double>[0.0, 0.25, 0.5, 0.75, 1.0])
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FadeTransition(
                          opacity: AlwaysStoppedAnimation<double>(t),
                          child: const Text(
                            'The quick brown fox jumps over the lazy dog.',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: _s2Deep,
                              fontWeight: FontWeight.w600,
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
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _chip('5 stops', _s2Tint, _s2Deep),
            _chip('linear sweep', _s2Tint, _s2Deep),
            _chip('static snapshots', _s2Tint, _s2Deep),
            _chip('reads forward = fade-in', _s2Tint, _s2Deep),
            _chip('reads backward = fade-out', _s2Tint, _s2Deep),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 3: FADE-IN NARRATIVE — five stacked frames telling the
  // "splash → loaded" story. Each frame is a FadeTransition wrapping the
  // same Card layout so the eye locks onto the alpha change.
  // -------------------------------------------------------------------

  Widget frame(double t, String caption) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 44.0,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: _s3Mid,
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: Text(
              t.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _s3Tint),
              ),
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation<double>(t),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.cloud_done, color: _s3Deep, size: 22.0),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        caption,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section3Body = _sectionBody(
    bg: _s3Bg,
    border: _s3Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Story: a network call resolves and a "Sync complete" banner has '
          'to glide in. With FadeTransition you frame the storyboard at the '
          'five canonical stops and the eye fills in the in-betweens.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        frame(0.0, 'Sync complete'),
        frame(0.25, 'Sync complete'),
        frame(0.5, 'Sync complete'),
        frame(0.75, 'Sync complete'),
        frame(1.0, 'Sync complete'),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _s3Tint.withOpacity(0.45),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Tip: in a live app you would drive opacity from a '
            'CurvedAnimation(parent: controller, curve: Curves.easeIn) '
            'instead of a static AlwaysStoppedAnimation.',
            style: TextStyle(fontSize: 12.0, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 4: FADE-OUT NARRATIVE — the same five frames reversed,
  // telling a "hero card exit" story.
  // -------------------------------------------------------------------

  Widget exitFrame(double t, String caption) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 44.0,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: _s4Mid,
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: Text(
              t.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: FadeTransition(
              opacity: AlwaysStoppedAnimation<double>(t),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[_s4Deep, _s4Mid],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.rocket_launch,
                        color: Colors.white, size: 22.0),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        caption,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section4Body = _sectionBody(
    bg: _s4Bg,
    border: _s4Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Reverse storyboard: a hero card retreats from view. Reading the '
          'frames top-to-bottom decreases t from 1.0 to 0.0 — the card '
          'dissolves while keeping its layout slot reserved.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        exitFrame(1.0, 'Launching satellite uplink…'),
        exitFrame(0.75, 'Launching satellite uplink…'),
        exitFrame(0.5, 'Launching satellite uplink…'),
        exitFrame(0.25, 'Launching satellite uplink…'),
        exitFrame(0.0, 'Launching satellite uplink…'),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _s4Tint.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Critical detail: FadeTransition does NOT shrink its child when '
            't = 0.0 — the slot is still laid out. Pair it with SizeTransition '
            'or AnimatedSize if you also want the layout to collapse.',
            style: TextStyle(fontSize: 12.0, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 5: alwaysIncludeSemantics — show the flag's effect with two
  // side-by-side cards at opacity 0.0. Visually identical, semantically
  // different.
  // -------------------------------------------------------------------

  final Widget section5Body = _sectionBody(
    bg: _s5Bg,
    border: _s5Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'When opacity reaches 0.0, FadeTransition stops including its child '
          'in the semantics tree — assistive tech can no longer "see" it. '
          'Set alwaysIncludeSemantics: true to keep it announceable even '
          'while visually hidden.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _s5Tint),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'default (false)',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: _s5Deep,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 64.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      alignment: Alignment.center,
                      child: FadeTransition(
                        opacity: opacity00,
                        child: const Text(
                          'screen-reader silent',
                          style: TextStyle(
                            color: _s5Deep,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'hidden + dropped',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF616161)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _s5Mid, width: 1.4),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'alwaysIncludeSemantics: true',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: _s5Deep,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 64.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: _s5Mid),
                      ),
                      alignment: Alignment.center,
                      child: FadeTransition(
                        opacity: opacity00,
                        alwaysIncludeSemantics: true,
                        child: const Text(
                          'screen-reader hears me',
                          style: TextStyle(
                            color: _s5Deep,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'hidden + announced',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF616161)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _bullet(
          'Use true for status banners that briefly fade out but should still '
          'be readable by VoiceOver/TalkBack.',
          _s5Mid,
        ),
        _bullet(
          'Use false (default) when the hidden child is purely decorative — '
          'avoids dead-air noise from accessibility services.',
          _s5Mid,
        ),
        _bullet(
          'The flag does not affect rendering — only the semantics tree.',
          _s5Mid,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 6: COMPARISON TABLE — FadeTransition vs AnimatedOpacity vs
  // Opacity. Three rows + header. Uses _comparisonRow helper.
  // -------------------------------------------------------------------

  final Widget section6Body = _sectionBody(
    bg: _s6Bg,
    border: _s6Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Three Flutter widgets manipulate alpha. They look identical on '
          'screen but differ sharply in API surface and control model.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _s6Tint),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              _comparisonRow(
                widget: 'Widget',
                input: 'Input type',
                control: 'Who drives ticks',
                rebuilds: 'Rebuild cost',
                when: 'Use when…',
                rowColor: _s6Deep,
                bold: true,
              ),
              _comparisonRow(
                widget: 'FadeTransition',
                input: 'Animation<double>',
                control: 'Caller (controller / curved)',
                rebuilds: 'Per tick of supplied Animation',
                when: 'You already own an AnimationController.',
                rowColor: Colors.white,
              ),
              _comparisonRow(
                widget: 'AnimatedOpacity',
                input: 'double + Duration',
                control: 'Internal controller (implicit)',
                rebuilds: 'Per setState of parent',
                when: 'You want a one-liner fade between two states.',
                rowColor: const Color(0xFFF7F9FA),
              ),
              _comparisonRow(
                widget: 'Opacity',
                input: 'double (static)',
                control: 'No one — just renders',
                rebuilds: 'Only when parent rebuilds',
                when: 'You need a single, non-animating alpha value.',
                rowColor: Colors.white,
              ),
              _comparisonRow(
                widget: 'SliverFadeTransition',
                input: 'Animation<double> + sliver',
                control: 'Caller (same as FadeTransition)',
                rebuilds: 'Per tick, inside a CustomScrollView',
                when: 'You need to fade a sliver, not a box.',
                rowColor: const Color(0xFFF7F9FA),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  FadeTransition(
                    opacity: opacity50,
                    child: Container(
                      width: 90.0,
                      height: 56.0,
                      color: _s6Mid,
                      alignment: Alignment.center,
                      child: const Text(
                        'Fade\nTransition',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'opacity = AlwaysStoppedAnimation(0.5)',
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  AnimatedOpacity(
                    opacity: 0.5,
                    duration: const Duration(milliseconds: 0),
                    child: Container(
                      width: 90.0,
                      height: 56.0,
                      color: _s6Mid,
                      alignment: Alignment.center,
                      child: const Text(
                        'Animated\nOpacity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'opacity: 0.5, duration: 0ms',
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 90.0,
                      height: 56.0,
                      color: _s6Mid,
                      alignment: Alignment.center,
                      child: const Text(
                        'Opacity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'opacity: 0.5',
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'All three render the same pixels at t = 0.5 — but only '
          'FadeTransition lets you swap in a real, controller-backed '
          'Animation<double> later without rewriting the tree.',
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: _s6Deep,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 7: SliverFadeTransition — used inside a BOUNDED
  // CustomScrollView so layout is well-defined inside an outer scroll
  // view. We fade three SliverList children at distinct opacities.
  // -------------------------------------------------------------------

  Widget sliverItem(int n, double t, Color tint) {
    return Container(
      height: 56.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: Text(
              '$n',
              style: TextStyle(
                color: _s7Deep,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            'Sliver row $n   (opacity ${t.toStringAsFixed(2)})',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section7Body = _sectionBody(
    bg: _s7Bg,
    border: _s7Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'For sliver protocols you swap FadeTransition for '
          'SliverFadeTransition. Same Animation<double> input, but the '
          'wrapped subject must itself be a sliver.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 240.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _s7Tint),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Inside a bounded CustomScrollView',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _s7Deep,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
              SliverFadeTransition(
                opacity: opacity100,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    sliverItem(1, 1.0, _s7Deep),
                  ]),
                ),
              ),
              SliverFadeTransition(
                opacity: opacity75,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    sliverItem(2, 0.75, _s7Mid),
                  ]),
                ),
              ),
              SliverFadeTransition(
                opacity: opacity50,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    sliverItem(3, 0.5, _s7Mid),
                  ]),
                ),
              ),
              SliverFadeTransition(
                opacity: opacity25,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    sliverItem(4, 0.25, _s7Tint),
                  ]),
                ),
              ),
              SliverFadeTransition(
                opacity: opacity00,
                alwaysIncludeSemantics: true,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    sliverItem(5, 0.0, _s7Tint),
                  ]),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '↑ row 5 is invisible but still in the semantics tree '
                    '(alwaysIncludeSemantics: true)',
                    style: TextStyle(fontSize: 11.0, color: _s7Deep),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _bullet('SliverFadeTransition.sliver takes a sliver, not a box.', _s7Mid),
        _bullet('The host CustomScrollView must be bounded by the surrounding '
            'box (Container with height) when nested inside a scrolling '
            'parent — otherwise viewport sizing is undefined.', _s7Mid),
        _bullet('alwaysIncludeSemantics works identically for the sliver flavour.',
            _s7Mid),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 8: LAYERING — stacking FadeTransitions multiplies their
  // effective opacities (alpha_total = alpha_outer * alpha_inner). We
  // build a 3x3 grid of combinations.
  // -------------------------------------------------------------------

  Widget layerCell(double outer, double inner) {
    final double effective = outer * inner;
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _s8Tint),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 56.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: AlwaysStoppedAnimation<double>(outer),
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation<double>(inner),
                child: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: _s8Deep,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.layers,
                      color: Colors.white, size: 22.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            '${outer.toStringAsFixed(2)} × ${inner.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            '= ${effective.toStringAsFixed(3)}',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: _s8Deep,
            ),
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
        Text(
          'Wrapping a FadeTransition inside another multiplies their alpha '
          'values. This is occasionally useful (a "master" fade composing '
          'sub-fades) but often surprising — the inner widget can never be '
          'more opaque than the outer envelope.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(child: layerCell(0.25, 0.25)),
            Expanded(child: layerCell(0.25, 0.5)),
            Expanded(child: layerCell(0.25, 1.0)),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(child: layerCell(0.5, 0.25)),
            Expanded(child: layerCell(0.5, 0.5)),
            Expanded(child: layerCell(0.5, 1.0)),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(child: layerCell(1.0, 0.25)),
            Expanded(child: layerCell(1.0, 0.5)),
            Expanded(child: layerCell(1.0, 1.0)),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _s8Tint.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Rule of thumb: only stack fades intentionally. If you find '
            'yourself nesting four or five FadeTransitions, refactor to a '
            'single composed Animation<double> driven by one controller.',
            style: TextStyle(fontSize: 12.0, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 9: REAL-WORLD RECIPES — three production-grade patterns.
  // -------------------------------------------------------------------

  final Widget skeletonPreview = Container(
    height: 70.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _s9Tint),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: <Widget>[
        FadeTransition(
          opacity: opacity50,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: _s9Tint,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FadeTransition(
                opacity: opacity50,
                child: Container(
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: _s9Tint,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              FadeTransition(
                opacity: opacity25,
                child: Container(
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: _s9Tint,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget heroExitPreview = Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_s9Deep, _s9Mid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: FadeTransition(
      opacity: opacity75,
      child: Row(
        children: <Widget>[
          const Icon(Icons.workspaces, color: Colors.white, size: 28.0),
          const SizedBox(width: 10.0),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Workspace ready',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '7 files indexed',
                  style: TextStyle(color: Colors.white70, fontSize: 11.5),
                ),
              ],
            ),
          ),
          _chip('0.75', Colors.white, _s9Deep),
        ],
      ),
    ),
  );

  final Widget hintBannerPreview = Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _s9Tint.withOpacity(0.6),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: <Widget>[
        FadeTransition(
          opacity: opacity25,
          child: Icon(Icons.lightbulb, color: _s9Deep, size: 22.0),
        ),
        const SizedBox(width: 8.0),
        FadeTransition(
          opacity: opacity50,
          child: Text(
            'Tip: long-press to pin.',
            style: TextStyle(
              color: _s9Deep,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ),
        const Spacer(),
        FadeTransition(
          opacity: opacity75,
          child: Icon(Icons.chevron_right, color: _s9Deep, size: 22.0),
        ),
      ],
    ),
  );

  final Widget section9Body = _sectionBody(
    bg: _s9Bg,
    border: _s9Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Three patterns from production code where FadeTransition is the '
          'right tool — usually because the caller already owns an '
          'AnimationController for some other reason.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          title: 'Skeleton loader fade',
          subtitle: 'Pulse the placeholder while real data lands.',
          icon: Icons.hourglass_top,
          accent: _s9Deep,
          background: Colors.white,
          steps: <String>[
            'Run a repeating AnimationController(period: 1.2s).',
            'Wrap each shimmer block in a FadeTransition with a CurvedAnimation.',
            'When real data arrives, swap the children — the controller stops on its own.',
          ],
          preview: skeletonPreview,
        ),
        _recipeCard(
          title: 'Hero card exit',
          subtitle: 'Coordinate fade with a parent Hero animation.',
          icon: Icons.exit_to_app,
          accent: _s9Deep,
          background: Colors.white,
          steps: <String>[
            'Use the route\'s secondaryAnimation as the opacity.',
            'FadeTransition rebuilds child each tick — keep child cheap.',
            'Combine with SlideTransition for a polished page exit.',
          ],
          preview: heroExitPreview,
        ),
        _recipeCard(
          title: 'Hint banner shimmer',
          subtitle: 'Three nested fades create a built-in shimmer feel.',
          icon: Icons.tips_and_updates,
          accent: _s9Deep,
          background: Colors.white,
          steps: <String>[
            'Compose three FadeTransitions with offset opacity animations.',
            'Drive them from one controller with three CurvedAnimations.',
            'Set alwaysIncludeSemantics where copy must stay screen-reader visible.',
          ],
          preview: hintBannerPreview,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 10: GLOSSARY — closing reference of every term that appeared
  // in the demo.
  // -------------------------------------------------------------------

  final Widget section10Body = _sectionBody(
    bg: _s10Bg,
    border: _s10Tint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Pocket dictionary for every term used in this flipbook.',
          style: const TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        _glossaryEntry(
          term: 'Animation<double>',
          meaning: 'A Listenable that exposes a double `value` plus an '
              'AnimationStatus. FadeTransition reads `value` on every '
              'notifyListeners() tick.',
          accent: _s10Deep,
        ),
        _glossaryEntry(
          term: 'AlwaysStoppedAnimation<T>',
          meaning: 'Animation that never changes value and reports '
              'AnimationStatus.forward. Useful for testing, screenshots, '
              'and demos like this one.',
          accent: _s10Deep,
        ),
        _glossaryEntry(
          term: 'FadeTransition',
          meaning: 'AnimatedWidget that rebuilds its child wrapped in an '
              'Opacity layer whose alpha equals opacity.value.',
          accent: _s10Deep,
        ),
        _glossaryEntry(
          term: 'SliverFadeTransition',
          meaning: 'Sliver-protocol counterpart of FadeTransition. Wraps a '
              'sliver and fades it within the scrolling viewport.',
          accent: _s10Deep,
        ),
        _glossaryEntry(
          term: 'alwaysIncludeSemantics',
          meaning: 'Boolean flag. When true, the child remains in the '
              'semantics tree even at opacity 0.0 — critical for status '
              'messages that fade out but must still be announced.',
          accent: _s10Deep,
        ),
        _glossaryEntry(
          term: 'AnimatedOpacity',
          meaning: 'Implicit-animation cousin. Takes a raw double + '
              'Duration; manages an internal controller. Cheap to write, '
              'less flexible than FadeTransition.',
          accent: _s10Deep,
        ),
        _glossaryEntry(
          term: 'Opacity (widget)',
          meaning: 'Static alpha layer. No animation, no controller — just '
              'renders the child at a fixed opacity.',
          accent: _s10Deep,
        ),
        _glossaryEntry(
          term: 'Composed alpha',
          meaning: 'When two FadeTransitions are nested, the effective '
              'alpha is the product of their opacity values.',
          accent: _s10Deep,
        ),
      ],
    ),
  );

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
              child: const Icon(Icons.gradient,
                  color: _heroDeep, size: 28.0),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'FadeTransition\nReel Gallery',
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
          'A deep, analyzer-clean tour of FadeTransition, '
          'SliverFadeTransition, and the alphabet of widgets that share '
          'the alpha channel — rendered entirely from static snapshot '
          'animations.',
          style: TextStyle(color: _heroSoft, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _chip('10 sections', Colors.white, _heroDeep),
            _chip('5 opacity stops', Colors.white, _heroDeep),
            _chip('AlwaysStoppedAnimation only', Colors.white, _heroDeep),
            _chip('no controllers', Colors.white, _heroDeep),
            _chip('analyzer-clean', Colors.white, _heroDeep),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // CONCEPT OVERVIEW (under hero)
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
          'FadeTransition is the explicit fade primitive. It accepts an '
          'Animation<double> and rebuilds the wrapped child whenever that '
          'animation notifies. Because it takes a real Animation — not a '
          'plain double — it is the right pick when the caller already '
          'owns an AnimationController for some larger choreography.',
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
        _bullet('Section 1 — single-widget basics.', _heroMid),
        _bullet('Section 2 — the canonical 5-stop opacity strip.', _heroMid),
        _bullet('Section 3 — fade-in narrative storyboard.', _heroMid),
        _bullet('Section 4 — fade-out narrative storyboard.', _heroMid),
        _bullet('Section 5 — alwaysIncludeSemantics, side-by-side.', _heroMid),
        _bullet('Section 6 — comparison with AnimatedOpacity & Opacity.', _heroMid),
        _bullet('Section 7 — SliverFadeTransition in a bounded scrollview.',
            _heroMid),
        _bullet('Section 8 — nested fades and their multiplied alpha.',
            _heroMid),
        _bullet('Section 9 — production recipes (skeleton, hero, hint).',
            _heroMid),
        _bullet('Section 10 — closing glossary.', _heroMid),
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
            const Icon(Icons.flag, color: Colors.white, size: 24.0),
            const SizedBox(width: 10.0),
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
          'FadeTransition sits at the intersection of two Flutter axioms: '
          '"prefer composition over inheritance" and "explicit beats '
          'implicit when control matters." Whenever you find yourself '
          'fighting AnimatedOpacity\'s implicit timing — wishing you '
          'could share a controller, chain a tween, or curve only a '
          'segment of the fade — promote your code to FadeTransition. '
          'Whenever you need a static alpha, demote to plain Opacity. '
          'And whenever your subject is a sliver, choose the matching '
          'SliverFadeTransition so the layout protocol stays consistent.',
          style: TextStyle(color: _epilogueSoft, fontSize: 13.5, height: 1.55),
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
                '• opacity: Animation<double> — not a plain number.\n'
                '• AlwaysStoppedAnimation pins a frame for tests & demos.\n'
                '• alwaysIncludeSemantics keeps invisible copy announceable.\n'
                '• Nested fades multiply.\n'
                '• Slivers need SliverFadeTransition.\n'
                '• Static alpha → Opacity. Implicit fade → AnimatedOpacity.\n'
                '  Explicit controller-driven fade → FadeTransition.',
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

  print('FadeTransition deep-demo tree assembled. Returning MaterialApp.');

  // -------------------------------------------------------------------
  // FINAL RETURN — MaterialApp scaffold required by the harness.
  // -------------------------------------------------------------------

  return MaterialApp(
    title: 'FadeTransition Reel Gallery',
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
          'FadeTransition — Deep Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              overview,
              _sectionBanner(
                index: 1,
                title: 'FADETRANSITION BASICS',
                subtitle: 'A single widget, three opacity snapshots, '
                    'one constructor reference.',
                deep: _s1Deep,
                mid: _s1Mid,
                soft: _s1Bg,
              ),
              section1Body,
              _sectionBanner(
                index: 2,
                title: 'OPACITY TIMELINE STRIP',
                subtitle: 'Five canonical stops — the spine of every '
                    'fade narrative in this demo.',
                deep: _s2Deep,
                mid: _s2Mid,
                soft: _s2Bg,
              ),
              section2Body,
              _sectionBanner(
                index: 3,
                title: 'FADE-IN NARRATIVE',
                subtitle: 'Storyboarding a status banner appearing on '
                    'screen, frame by frame.',
                deep: _s3Deep,
                mid: _s3Mid,
                soft: _s3Bg,
              ),
              section3Body,
              _sectionBanner(
                index: 4,
                title: 'FADE-OUT NARRATIVE',
                subtitle: 'The same five stops in reverse — a hero card '
                    'retreating from view.',
                deep: _s4Deep,
                mid: _s4Mid,
                soft: _s4Bg,
              ),
              section4Body,
              _sectionBanner(
                index: 5,
                title: 'ALWAYS-INCLUDE-SEMANTICS',
                subtitle: 'The accessibility flag — invisible to eyes, '
                    'audible to screen readers.',
                deep: _s5Deep,
                mid: _s5Mid,
                soft: _s5Bg,
              ),
              section5Body,
              _sectionBanner(
                index: 6,
                title: 'COMPARISON: FADE / ANIMATED / OPACITY',
                subtitle: 'Same pixels, different APIs — pick by who '
                    'owns the controller.',
                deep: _s6Deep,
                mid: _s6Mid,
                soft: _s6Bg,
              ),
              section6Body,
              _sectionBanner(
                index: 7,
                title: 'SLIVER FADE TRANSITION',
                subtitle: 'Fading inside a CustomScrollView — same '
                    'opacity input, sliver subject.',
                deep: _s7Deep,
                mid: _s7Mid,
                soft: _s7Bg,
              ),
              section7Body,
              _sectionBanner(
                index: 8,
                title: 'LAYERED FADES',
                subtitle: 'Nesting FadeTransitions multiplies their '
                    'alpha. A 3×3 grid proves it.',
                deep: _s8Deep,
                mid: _s8Mid,
                soft: _s8Bg,
              ),
              section8Body,
              _sectionBanner(
                index: 9,
                title: 'PRODUCTION RECIPES',
                subtitle: 'Three real-world patterns where FadeTransition '
                    'is the right tool.',
                deep: _s9Deep,
                mid: _s9Mid,
                soft: _s9Bg,
              ),
              section9Body,
              _sectionBanner(
                index: 10,
                title: 'GLOSSARY',
                subtitle: 'Closing reference for every term in the '
                    'flipbook.',
                deep: _s10Deep,
                mid: _s10Mid,
                soft: _s10Bg,
              ),
              section10Body,
              epilogue,
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}
