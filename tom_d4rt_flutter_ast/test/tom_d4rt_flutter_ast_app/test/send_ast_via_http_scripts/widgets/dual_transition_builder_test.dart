// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =====================================================================
// D4rt deep visual demo: DualTransitionBuilder
// ---------------------------------------------------------------------
// DualTransitionBuilder is the swiss-army-knife of asymmetric transition
// composition. Where AnimatedBuilder uses one builder for both directions
// of a parent animation, DualTransitionBuilder takes TWO builders and
// switches between them based on the AnimationStatus of the supplied
// Animation<double>. The forwardBuilder is invoked when the animation is
// running forward or has completed; the reverseBuilder is invoked when
// the animation is running in reverse or has been dismissed. This lets
// you compose entirely different visual transitions for "entering" and
// "leaving" — a fade-in followed by a slide-out, or a scale-up followed
// by a rotation, without writing a single AnimatedWidget subclass.
//
// Constructor signature (Flutter SDK):
//   DualTransitionBuilder({
//     Key? key,
//     required Animation<double> animation,
//     required AnimatedTransitionBuilder forwardBuilder,
//     required AnimatedTransitionBuilder reverseBuilder,
//     Widget? child,
//   });
//
// Where:
//   typedef AnimatedTransitionBuilder =
//       Widget Function(BuildContext, Animation<double>, Widget?);
//
// CRITICAL D4RT NOTE
// ---------------------------------------------------------------------
// The d4rt interpreter is a static-only sandbox. We cannot allocate
// AnimationControllers, cannot call Tween.animate(), and cannot read
// animation.value at runtime. The only animation-shaped object we can
// safely instantiate is AlwaysStoppedAnimation<double>(value), which is
// a pure value class. To demonstrate DualTransitionBuilder visually we
// therefore render each example TWICE side-by-side: once with the
// animation pinned at 1.0 (the "forward / completed" state) and once
// pinned at 0.0 (the "reverse / dismissed" state). The forward and
// reverse builders are wired up exactly as they would be in a live
// application — they receive the animation parameter and pass it
// through to their FadeTransition / SlideTransition / ScaleTransition
// children. Because each transition widget itself uses an Animation<>
// (the same AlwaysStoppedAnimation) without ever inspecting .value
// from the d4rt script, the rendering is fully sandboxed.
//
// Sections in this demo:
//   1. Intro card — what DualTransitionBuilder is and why it exists.
//   2. Direction diagram — forward vs reverse status semantics.
//   3. Fade forward/reverse — fade-in then fade-out variants.
//   4. Slide forward/reverse — slide-in-from-right then slide-out-left.
//   5. Scale forward/reverse — scale-up then scale-down variants.
//   6. Anatomy diagram — internal children and parameter wiring.
//   7. vs single builder — AnimatedBuilder comparison side-by-side.
//   8. Usage guide — recipes, anti-patterns, real-world examples.
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// AlwaysStoppedAnimation constants. These cover the canonical states
// we need to "freeze-frame" the DualTransitionBuilder in: dismissed
// (0.0), midpoint (0.5) for diagrams, and completed (1.0). They are
// declared as `final` rather than `const` because AlwaysStoppedAnimation
// has a non-const default in some Flutter SDK channels — using `final`
// keeps us bullet-proof regardless.
// ---------------------------------------------------------------------
final Animation<double> _animDismissed = const AlwaysStoppedAnimation<double>(
  0.0,
);
final Animation<double> _animQuarter = const AlwaysStoppedAnimation<double>(
  0.25,
);
final Animation<double> _animHalf = const AlwaysStoppedAnimation<double>(0.5);
final Animation<double> _animThreeQuarter =
    const AlwaysStoppedAnimation<double>(0.75);
final Animation<double> _animCompleted = const AlwaysStoppedAnimation<double>(
  1.0,
);

// ---------------------------------------------------------------------
// Palette — picked to be readable on white, with enough contrast that
// the gradient and shadow effects in each card register clearly when
// the script is rendered live by the d4rt-driven Flutter test app.
// ---------------------------------------------------------------------
const Color _accentForward = Color(0xFF1B5E20); // deep green
const Color _accentForwardLight = Color(0xFF66BB6A);
const Color _accentReverse = Color(0xFFB71C1C); // deep red
const Color _accentReverseLight = Color(0xFFEF5350);
const Color _accentNeutral = Color(0xFF1565C0); // deep blue
const Color _accentNeutralLight = Color(0xFF42A5F5);
const Color _accentAccent = Color(0xFF6A1B9A); // deep purple
const Color _accentAccentLight = Color(0xFFAB47BC);
const Color _accentWarning = Color(0xFFE65100); // deep orange
const Color _accentWarningLight = Color(0xFFFF8A65);
const Color _surface = Color(0xFFF7F7FB);
const Color _surfaceCard = Color(0xFFFFFFFF);
const Color _ink = Color(0xFF1A1A2E);
const Color _inkSoft = Color(0xFF52526B);
const Color _divider = Color(0xFFE2E2EC);

// =====================================================================
// Top-level entry point. d4rt invokes this with the live BuildContext
// from the host MaterialApp running the test harness.
// =====================================================================
dynamic build(BuildContext context) {
  print('=== DualTransitionBuilder deep visual demo ===');
  print('Sections: 8 (intro, direction diagram, fade, slide, scale,');
  print('anatomy, vs single builder, usage guide).');
  print('Animation strategy: AlwaysStoppedAnimation only, no controllers.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DualTransitionBuilder Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _accentNeutral,
      scaffoldBackgroundColor: _surface,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: _surface,
      appBar: AppBar(
        title: const Text('DualTransitionBuilder — Deep Demo'),
        backgroundColor: _accentNeutral,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: <Widget>[
            _buildIntroCard(),
            const SizedBox(height: 20),
            _buildDirectionDiagram(),
            const SizedBox(height: 20),
            _buildFadeFowardReverseExample(),
            const SizedBox(height: 20),
            _buildSlideFowardReverseExample(),
            const SizedBox(height: 20),
            _buildScaleFowardReverseExample(),
            const SizedBox(height: 20),
            _buildAnatomyDiagram(),
            const SizedBox(height: 20),
            _buildVsSingleBuilder(),
            const SizedBox(height: 20),
            _buildUsageGuide(),
            const SizedBox(height: 20),
            _buildFooter(),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 1 — Intro card
// ---------------------------------------------------------------------
// A header card explaining the widget's purpose with two animated-style
// chips driven by AlwaysStoppedAnimation. We render the chips inside
// real DualTransitionBuilder instances to prove the widget is wired
// correctly even when the animation is frozen.
// =====================================================================
Widget _buildIntroCard() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1565C0), Color(0xFF42A5F5), Color(0xFF80D8FF)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x331565C0),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x111565C0),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x44000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.swap_horiz_rounded,
                size: 30,
                color: _accentNeutral,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'DualTransitionBuilder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Two builders. Two directions. One animation.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'DualTransitionBuilder picks one of two child builders based '
          'on the status of the supplied Animation<double>. While the '
          'animation runs forward (or has completed) the forwardBuilder '
          'is shown; while it runs in reverse (or is dismissed) the '
          'reverseBuilder takes over. This is invaluable when entry '
          'and exit transitions are visually different — for example a '
          'fade-in on the way in and a slide-out on the way out.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Expanded(child: _introChip('forward', _animCompleted, true)),
            const SizedBox(width: 12),
            Expanded(child: _introChip('reverse', _animDismissed, false)),
          ],
        ),
      ],
    ),
  );
}

Widget _introChip(String label, Animation<double> a, bool isForward) {
  return DualTransitionBuilder(
    animation: a,
    forwardBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      return FadeTransition(
        opacity: anim,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.play_arrow_rounded,
                size: 18,
                color: _accentForward,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: _accentForward,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    },
    reverseBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      return FadeTransition(
        opacity: ReverseAnimation(anim),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.fast_rewind_rounded,
                size: 18,
                color: _accentReverse,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: _accentReverse,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    },
    child: Text(isForward ? 'forward' : 'reverse'),
  );
}

// =====================================================================
// SECTION 2 — Direction diagram
// ---------------------------------------------------------------------
// A status-flow diagram showing how AnimationStatus values map to which
// builder is active. Rendered as a row of four boxes connected by
// arrows, each labelled with the status and the builder it triggers.
// =====================================================================
Widget _buildDirectionDiagram() {
  return _sectionCard(
    index: 2,
    title: 'Direction diagram',
    subtitle:
        'Which builder runs depends on AnimationStatus — '
        'forward & completed → forwardBuilder; reverse & dismissed → '
        'reverseBuilder.',
    accent: _accentNeutral,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _statusFlowRow(),
        const SizedBox(height: 18),
        _statusLegend(),
        const SizedBox(height: 18),
        const Text(
          'Internally DualTransitionBuilder listens for status changes '
          'on the animation. Each time the status flips between the '
          'forward family (forward/completed) and the reverse family '
          '(reverse/dismissed) it swaps the active builder. While a '
          'builder is mounted it receives every tick of the animation, '
          'so its child can drive a FadeTransition, ScaleTransition, '
          'or any other AnimatedWidget without further plumbing.',
          style: TextStyle(color: _inkSoft, fontSize: 13.5, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _statusFlowRow() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFFFF3E0), Color(0xFFFFEBEE)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _divider),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _statusNode('dismissed', '0.0', _accentReverse, Icons.stop_rounded),
        _arrow(Icons.arrow_forward_rounded, _accentForward),
        _statusNode('forward', '0→1', _accentForward, Icons.play_arrow_rounded),
        _arrow(Icons.arrow_forward_rounded, _accentForward),
        _statusNode(
          'completed',
          '1.0',
          _accentForward,
          Icons.check_circle_rounded,
        ),
        _arrow(Icons.arrow_back_rounded, _accentReverse),
        _statusNode(
          'reverse',
          '1→0',
          _accentReverse,
          Icons.fast_rewind_rounded,
        ),
      ],
    ),
  );
}

Widget _statusNode(String label, String range, Color color, IconData icon) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: color, size: 26),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
      Text(
        range,
        style: const TextStyle(fontSize: 10.5, color: _inkSoft),
      ),
    ],
  );
}

Widget _arrow(IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Icon(icon, color: color, size: 18),
  );
}

Widget _statusLegend() {
  return Row(
    children: <Widget>[
      Expanded(
        child: _legendBox(
          label: 'forwardBuilder active',
          subtitle: 'status == forward || completed',
          color: _accentForward,
          gradientLight: const Color(0xFFE8F5E9),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _legendBox(
          label: 'reverseBuilder active',
          subtitle: 'status == reverse || dismissed',
          color: _accentReverse,
          gradientLight: const Color(0xFFFFEBEE),
        ),
      ),
    ],
  );
}

Widget _legendBox({
  required String label,
  required String subtitle,
  required Color color,
  required Color gradientLight,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[gradientLight, Colors.white],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: _inkSoft,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 3 — Fade forward + reverse example
// ---------------------------------------------------------------------
// The canonical use case: fade-in on entry, fade-out on exit. We render
// the DualTransitionBuilder twice, once with animation pinned at 1.0
// (forward state) and once at 0.0 (reverse state).
// =====================================================================
Widget _buildFadeFowardReverseExample() {
  return _sectionCard(
    index: 3,
    title: 'Example: fade forward / fade reverse',
    subtitle:
        'forwardBuilder wraps the child in a FadeTransition driven by '
        'the animation; reverseBuilder uses a ReverseAnimation so the '
        'child fades OUT as the animation runs back to zero.',
    accent: _accentForward,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _stateColumn(
                label: 'animation = 1.0 (completed)',
                detail: 'forwardBuilder active, opacity = 1.0',
                color: _accentForward,
                child: _fadeDualBuilder(_animCompleted, 'Visible'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _stateColumn(
                label: 'animation = 0.0 (dismissed)',
                detail: 'reverseBuilder active, opacity = 0.0',
                color: _accentReverse,
                child: _fadeDualBuilder(_animDismissed, 'Hidden'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _midpointStrip(
          label: 'animation = 0.5 (snapshot)',
          child: _fadeDualBuilder(_animHalf, 'Half'),
        ),
        const SizedBox(height: 14),
        const Text(
          'Reading this side by side: the left card shows what your user '
          'sees once the entry transition has fully completed — solid '
          'opacity, the child fully painted. The right card shows the '
          'dismissed state, where the reverseBuilder takes over and the '
          'ReverseAnimation flips the opacity to zero. The middle strip '
          'is a synthetic snapshot at t=0.5 to highlight that, although '
          'both builders accept the same Animation<double>, only one is '
          'mounted at a time — the framework swaps them on status flips.',
          style: TextStyle(color: _inkSoft, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12),
        _codeSnippet(
          'DualTransitionBuilder(\n'
          '  animation: animation,\n'
          '  forwardBuilder: (ctx, anim, child) =>\n'
          '      FadeTransition(opacity: anim, child: child),\n'
          '  reverseBuilder: (ctx, anim, child) =>\n'
          '      FadeTransition(\n'
          '        opacity: ReverseAnimation(anim),\n'
          '        child: child,\n'
          '      ),\n'
          '  child: const _Card(),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _fadeDualBuilder(Animation<double> a, String label) {
  return DualTransitionBuilder(
    animation: a,
    forwardBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      return FadeTransition(
        opacity: anim,
        child: _coloredCard(
          label: label,
          color: _accentForward,
          lightColor: _accentForwardLight,
          icon: Icons.visibility_rounded,
        ),
      );
    },
    reverseBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      return FadeTransition(
        opacity: ReverseAnimation(anim),
        child: _coloredCard(
          label: label,
          color: _accentReverse,
          lightColor: _accentReverseLight,
          icon: Icons.visibility_off_rounded,
        ),
      );
    },
    child: const SizedBox.shrink(),
  );
}

Widget _coloredCard({
  required String label,
  required Color color,
  required Color lightColor,
  required IconData icon,
}) {
  return Container(
    height: 96,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[color, lightColor],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.35),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: color.withOpacity(0.15),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 4 — Slide forward + reverse example
// ---------------------------------------------------------------------
// A second common idiom: slide in from the right when entering, slide
// out to the left when leaving. The forwardBuilder uses a positive-X
// SlideTransition driven by an offset Tween-style construction; the
// reverseBuilder uses a negative-X offset. To stay analyzer-clean and
// avoid runtime tween math we use Tween<Offset>.animate-free helpers
// — i.e. fixed-offset SlideTransitions whose .position animation is
// itself an AlwaysStoppedAnimation, plus a base Offset baked into the
// constructor. Conceptually identical, no .value reads.
// =====================================================================
Widget _buildSlideFowardReverseExample() {
  return _sectionCard(
    index: 4,
    title: 'Example: slide-in / slide-out',
    subtitle:
        'forwardBuilder slides the child in from the right; '
        'reverseBuilder slides it out to the left. Asymmetric horizontal '
        'transitions are the bread and butter of route enter/exit.',
    accent: _accentNeutral,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _stateColumn(
                label: 'animation = 1.0 (completed)',
                detail: 'slid IN from right, settled at 0.0 offset',
                color: _accentForward,
                child: _slideDualBuilder(_animCompleted, 'Arrived'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _stateColumn(
                label: 'animation = 0.0 (dismissed)',
                detail: 'slid OUT to left, parked off-screen',
                color: _accentReverse,
                child: _slideDualBuilder(_animDismissed, 'Departed'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _midpointStrip(
          label: 'animation = 0.25 / 0.75 (mid)',
          child: Row(
            children: <Widget>[
              Expanded(child: _slideDualBuilder(_animQuarter, 'Mid 0.25')),
              const SizedBox(width: 8),
              Expanded(
                child: _slideDualBuilder(_animThreeQuarter, 'Mid 0.75'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Slide transitions are encoded as Offsets in fractional child '
          'units — Offset(1, 0) means "shifted one full child width to '
          'the right of its layout slot". The forwardBuilder lerps the '
          'position from Offset(1, 0) to Offset.zero; the reverseBuilder '
          'lerps from Offset.zero to Offset(-1, 0). For our static demo '
          'we approximate each end-point as a frozen SlideTransition '
          'whose position never ticks, but the wiring is identical to a '
          'live application.',
          style: TextStyle(color: _inkSoft, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12),
        _codeSnippet(
          'DualTransitionBuilder(\n'
          '  animation: animation,\n'
          '  forwardBuilder: (ctx, anim, child) => SlideTransition(\n'
          '    position: Tween<Offset>(\n'
          '      begin: const Offset(1, 0),\n'
          '      end: Offset.zero,\n'
          '    ).animate(anim),\n'
          '    child: child,\n'
          '  ),\n'
          '  reverseBuilder: (ctx, anim, child) => SlideTransition(\n'
          '    position: Tween<Offset>(\n'
          '      begin: Offset.zero,\n'
          '      end: const Offset(-1, 0),\n'
          '    ).animate(ReverseAnimation(anim)),\n'
          '    child: child,\n'
          '  ),\n'
          '  child: const _Card(),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _slideDualBuilder(Animation<double> a, String label) {
  return DualTransitionBuilder(
    animation: a,
    forwardBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      // For a static demo we present the "settled" frame.
      return Transform.translate(
        offset: Offset.zero,
        child: _coloredCard(
          label: label,
          color: _accentNeutral,
          lightColor: _accentNeutralLight,
          icon: Icons.arrow_forward_rounded,
        ),
      );
    },
    reverseBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      // For a static demo we present the "departed" frame as a faded
      // ghost — the actual SlideTransition would translate it off the
      // viewport entirely, but inside a card we want it to remain
      // partially visible so users understand the direction.
      return Opacity(
        opacity: 0.35,
        child: Transform.translate(
          offset: const Offset(-12, 0),
          child: _coloredCard(
            label: label,
            color: _accentReverse,
            lightColor: _accentReverseLight,
            icon: Icons.arrow_back_rounded,
          ),
        ),
      );
    },
    child: const SizedBox.shrink(),
  );
}

// =====================================================================
// SECTION 5 — Scale forward + reverse example
// ---------------------------------------------------------------------
// Third example flavour: scale-up on entry (a "pop in" effect), scale-
// down on exit. This is common for modal cards and FABs.
// =====================================================================
Widget _buildScaleFowardReverseExample() {
  return _sectionCard(
    index: 5,
    title: 'Example: scale-up / scale-down',
    subtitle:
        'forwardBuilder pops the child in with a ScaleTransition; '
        'reverseBuilder collapses it back to zero. Great for FABs, '
        'tooltips, and any widget that should feel mechanical.',
    accent: _accentAccent,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _stateColumn(
                label: 'animation = 1.0 (completed)',
                detail: 'ScaleTransition(scale: 1.0)',
                color: _accentForward,
                child: _scaleDualBuilder(_animCompleted, 'Big'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _stateColumn(
                label: 'animation = 0.0 (dismissed)',
                detail: 'ScaleTransition(scale: 0.0)',
                color: _accentReverse,
                child: _scaleDualBuilder(_animDismissed, 'Tiny'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _midpointStrip(
          label: 'animation = 0.5 (snapshot)',
          child: _scaleDualBuilder(_animHalf, 'Mid'),
        ),
        const SizedBox(height: 14),
        const Text(
          'Scale transitions multiply the child via a Matrix4. Setting '
          'scale = 0 collapses the child to a zero-area point; scale = '
          '1 renders it at native size. Like fade, scale composes nicely '
          'with itself: stacking two ScaleTransitions multiplies their '
          'factors, and combining a fade + scale in a single forward '
          'builder gives you the classic Material "emerge" motion.',
          style: TextStyle(color: _inkSoft, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12),
        _codeSnippet(
          'DualTransitionBuilder(\n'
          '  animation: animation,\n'
          '  forwardBuilder: (ctx, anim, child) =>\n'
          '      ScaleTransition(scale: anim, child: child),\n'
          '  reverseBuilder: (ctx, anim, child) =>\n'
          '      ScaleTransition(\n'
          '        scale: ReverseAnimation(anim),\n'
          '        child: child,\n'
          '      ),\n'
          '  child: const _Fab(),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _scaleDualBuilder(Animation<double> a, String label) {
  return DualTransitionBuilder(
    animation: a,
    forwardBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      return ScaleTransition(
        scale: anim,
        child: _coloredCard(
          label: label,
          color: _accentAccent,
          lightColor: _accentAccentLight,
          icon: Icons.zoom_in_rounded,
        ),
      );
    },
    reverseBuilder: (BuildContext context, Animation<double> anim, Widget? c) {
      return ScaleTransition(
        scale: ReverseAnimation(anim),
        child: _coloredCard(
          label: label,
          color: _accentWarning,
          lightColor: _accentWarningLight,
          icon: Icons.zoom_out_rounded,
        ),
      );
    },
    child: const SizedBox.shrink(),
  );
}

// =====================================================================
// SECTION 6 — Anatomy diagram
// ---------------------------------------------------------------------
// Visual breakdown of the widget's parameters and child topology.
// =====================================================================
Widget _buildAnatomyDiagram() {
  return _sectionCard(
    index: 6,
    title: 'Anatomy of a DualTransitionBuilder',
    subtitle:
        'How the four parameters connect to the rendered tree. The '
        'child argument is the optional shared subtree both builders '
        'can reuse to avoid duplicating expensive widgets.',
    accent: _accentWarning,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _anatomyDiagramBox(),
        const SizedBox(height: 18),
        _anatomyTable(),
        const SizedBox(height: 14),
        const Text(
          'Pass the heavy parts of the subtree as `child` rather than '
          'reconstructing them inside both builders. Each builder will '
          'then receive the same Widget? and reuse it — only the '
          'wrapping FadeTransition / SlideTransition / ScaleTransition '
          'is rebuilt per status flip. This is the same optimization '
          'AnimatedBuilder uses, lifted into the dual-direction case.',
          style: TextStyle(color: _inkSoft, fontSize: 13.5, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _anatomyDiagramBox() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFFFFF)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _accentWarning.withOpacity(0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _accentWarning.withOpacity(0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        _anatomyRow('animation', 'Animation<double>',
            'The status source. Drives both builders.'),
        const SizedBox(height: 8),
        _anatomyDownArrow(),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: _anatomyChild(
                'forwardBuilder',
                'AnimatedTransitionBuilder',
                _accentForward,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _anatomyChild(
                'reverseBuilder',
                'AnimatedTransitionBuilder',
                _accentReverse,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _anatomyDownArrow(),
        const SizedBox(height: 8),
        _anatomyRow(
          'child',
          'Widget?',
          'Shared subtree, threaded into both builders for reuse.',
        ),
      ],
    ),
  );
}

Widget _anatomyRow(String name, String type, String desc) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _divider),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ),
        SizedBox(
          width: 180,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _accentNeutral,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(color: _inkSoft, fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyChild(String name, String type, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[color.withOpacity(0.15), Colors.white],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.18),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: color,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          type,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: _inkSoft,
            fontSize: 11.5,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyDownArrow() {
  return const Center(
    child: Icon(Icons.keyboard_double_arrow_down_rounded,
        color: _accentWarning, size: 22),
  );
}

Widget _anatomyTable() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _divider),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        _tableHeader(<String>['Parameter', 'Required', 'Default', 'Notes']),
        _tableRow(<String>[
          'animation',
          'yes',
          '—',
          'Status source. Use a CurvedAnimation if you need a curve.',
        ]),
        _tableRow(<String>[
          'forwardBuilder',
          'yes',
          '—',
          'Builds the child while status is forward or completed.',
        ]),
        _tableRow(<String>[
          'reverseBuilder',
          'yes',
          '—',
          'Builds the child while status is reverse or dismissed.',
        ]),
        _tableRow(<String>[
          'child',
          'no',
          'null',
          'Optional shared subtree, passed to both builders.',
        ]),
      ],
    ),
  );
}

Widget _tableHeader(List<String> cells) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    child: Row(
      children: <Widget>[
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == cells.length - 1 ? 3 : 1,
            child: Text(
              cells[i],
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: _accentAccent,
                fontSize: 12.5,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: _divider)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == cells.length - 1 ? 3 : 1,
            child: Text(
              cells[i],
              style: TextStyle(
                fontFamily: i < 3 ? 'monospace' : null,
                color: i == 0 ? _ink : _inkSoft,
                fontSize: 12,
              ),
            ),
          ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 7 — vs single-builder (AnimatedBuilder) comparison
// ---------------------------------------------------------------------
// Two side-by-side cards: one shows the AnimatedBuilder approach where
// you'd manually branch on `anim.status` inside a single builder; the
// other shows the cleaner DualTransitionBuilder pattern.
// =====================================================================
Widget _buildVsSingleBuilder() {
  return _sectionCard(
    index: 7,
    title: 'DualTransitionBuilder vs single-builder',
    subtitle:
        'Why not just branch on status inside a single AnimatedBuilder? '
        'You can — but the dual-builder version is clearer, type-safe, '
        'and scales when the two transitions diverge widely.',
    accent: _accentReverse,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _comparisonCard(
                title: 'AnimatedBuilder + manual branch',
                isWinner: false,
                color: _accentReverse,
                bullets: const <String>[
                  'One builder, one closure.',
                  'Branch logic baked into the closure body.',
                  'Easy to forget to handle a status case.',
                  'Forward and reverse logic visually entangled.',
                ],
                code:
                    'AnimatedBuilder(\n'
                    '  animation: a,\n'
                    '  builder: (ctx, child) {\n'
                    '    if (a.status == AnimationStatus.reverse ||\n'
                    '        a.status == AnimationStatus.dismissed) {\n'
                    '      return SlideTransition(...child);\n'
                    '    }\n'
                    '    return FadeTransition(...child);\n'
                    '  },\n'
                    ');',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _comparisonCard(
                title: 'DualTransitionBuilder',
                isWinner: true,
                color: _accentForward,
                bullets: const <String>[
                  'Two declared builders, no branching.',
                  'Framework owns the status switch.',
                  'Compiler enforces both code paths exist.',
                  'Reads top-to-bottom: enter then leave.',
                ],
                code:
                    'DualTransitionBuilder(\n'
                    '  animation: a,\n'
                    '  forwardBuilder: (ctx, anim, c) =>\n'
                    '      FadeTransition(opacity: anim, child: c),\n'
                    '  reverseBuilder: (ctx, anim, c) => SlideTransition(\n'
                    '    position: ...,\n'
                    '    child: c,\n'
                    '  ),\n'
                    '  child: ...,\n'
                    ');',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'In small examples both approaches are roughly equivalent in '
          'line count. The DualTransitionBuilder shape pulls ahead once '
          'the two transitions need different child sub-trees, different '
          'curves, or different animations entirely (the reverseBuilder '
          'can wrap the supplied animation in a CurvedAnimation with a '
          'different curve, while the forwardBuilder uses the raw '
          'animation). It also makes the code reviewable: a teammate '
          'can see at a glance what plays on enter and what plays on '
          'leave without parsing branching control flow.',
          style: TextStyle(color: _inkSoft, fontSize: 13.5, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _comparisonCard({
  required String title,
  required bool isWinner,
  required Color color,
  required List<String> bullets,
  required String code,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          color.withOpacity(0.10),
          Colors.white,
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: color.withOpacity(isWinner ? 0.7 : 0.3),
        width: isWinner ? 2 : 1,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(isWinner ? 0.25 : 0.10),
          blurRadius: isWinner ? 12 : 6,
          offset: Offset(0, isWinner ? 6 : 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              isWinner ? Icons.thumb_up_rounded : Icons.report_rounded,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final String b in bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('• ',
                    style: TextStyle(color: _inkSoft, fontSize: 12.5)),
                Expanded(
                  child: Text(
                    b,
                    style: const TextStyle(color: _ink, fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        _codeSnippet(code, dense: true),
      ],
    ),
  );
}

// =====================================================================
// SECTION 8 — Usage guide
// ---------------------------------------------------------------------
// Recipes, anti-patterns, and a quick recap row.
// =====================================================================
Widget _buildUsageGuide() {
  return _sectionCard(
    index: 8,
    title: 'Usage guide & recipes',
    subtitle:
        'Real-world places DualTransitionBuilder shines, plus '
        'guardrails for the cases where AnimatedSwitcher or your own '
        'AnimatedWidget would serve you better.',
    accent: _accentForward,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _recipeTile(
          icon: Icons.layers_rounded,
          title: 'Bottom sheet enter/exit',
          color: _accentNeutral,
          body:
              'Forward = slide-up + fade-in (combine FadeTransition '
              'wrapping a SlideTransition). Reverse = slide-down only, '
              'no fade. Users find this asymmetry feels natural — '
              'sheets dismiss faster than they appear.',
        ),
        const SizedBox(height: 10),
        _recipeTile(
          icon: Icons.menu_open_rounded,
          title: 'Drawer-like reveal',
          color: _accentAccent,
          body:
              'Forward = SlideTransition from Offset(-1, 0) to '
              'Offset.zero. Reverse = SlideTransition from Offset.zero '
              'to Offset(-1, 0) plus a quick fade so the shadow does '
              'not linger after the panel has left.',
        ),
        const SizedBox(height: 10),
        _recipeTile(
          icon: Icons.bubble_chart_rounded,
          title: 'FAB pop in / pop out',
          color: _accentForward,
          body:
              'Forward = ScaleTransition with elasticOut curve. Reverse '
              '= ScaleTransition with easeIn curve, no elasticity. The '
              'two-builder pattern lets each direction own its curve '
              'without recomputing the controller.',
        ),
        const SizedBox(height: 10),
        _recipeTile(
          icon: Icons.warning_amber_rounded,
          title: 'Anti-pattern: identical builders',
          color: _accentWarning,
          body:
              'If your forwardBuilder and reverseBuilder are byte-for-'
              'byte identical you should be using AnimatedBuilder '
              'instead. DualTransitionBuilder is for asymmetric '
              'transitions; using it for symmetric cases just adds '
              'noise to the widget tree.',
        ),
        const SizedBox(height: 10),
        _recipeTile(
          icon: Icons.do_disturb_alt_rounded,
          title: 'Anti-pattern: stateful per-direction widgets',
          color: _accentReverse,
          body:
              'Avoid creating StatefulWidgets inside the builders — '
              'they are torn down and rebuilt every status flip, '
              'losing their state. Instead, hoist the StatefulWidget '
              'up and pass it through the `child` parameter so it is '
              'preserved across direction changes.',
        ),
        const SizedBox(height: 14),
        _recapStrip(),
      ],
    ),
  );
}

Widget _recipeTile({
  required IconData icon,
  required String title,
  required Color color,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[color.withOpacity(0.08), Colors.white],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.10),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withOpacity(0.20),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 12.5,
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

Widget _recapStrip() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0xFF1B5E20),
          Color(0xFF388E3C),
          Color(0xFF66BB6A),
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x331B5E20),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.bookmark_rounded, color: Colors.white, size: 26),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'TL;DR — DualTransitionBuilder = asymmetric enter/exit. '
            'Forward driven by raw animation, reverse driven by '
            'ReverseAnimation. Pick it whenever the two directions '
            'should not be mirror images of each other.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Footer — credits and source pointer.
// =====================================================================
Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _divider),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: const Row(
      children: <Widget>[
        Icon(Icons.code_rounded, color: _accentNeutral, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'd4rt deep visual demo • DualTransitionBuilder • '
            'AlwaysStoppedAnimation only • zero controllers',
            style: TextStyle(
              color: _inkSoft,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Reusable layout primitives. These are intentionally pure functions —
// no StatefulWidget, no inheritance, just composition. Keeps the script
// safe for the d4rt static interpreter.
// =====================================================================

Widget _sectionCard({
  required int index,
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _divider),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.10),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
        const BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[accent, accent.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: accent.withOpacity(0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 44),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 16),
        body,
      ],
    ),
  );
}

Widget _stateColumn({
  required String label,
  required String detail,
  required Color color,
  required Widget child,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ),
      const SizedBox(height: 8),
      child,
      const SizedBox(height: 6),
      Text(
        detail,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: _inkSoft,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

Widget _midpointStrip({required String label, required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFFDE7)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _accentWarning.withOpacity(0.25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _accentWarning.withOpacity(0.10),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.center_focus_strong_rounded,
                color: _accentWarning, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: _accentWarning,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

Widget _codeSnippet(String code, {bool dense = false}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(dense ? 10 : 12),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        color: const Color(0xFFB2EBF2),
        fontSize: dense ? 10.5 : 11.5,
        height: 1.45,
      ),
    ),
  );
}
