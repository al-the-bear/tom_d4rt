// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: RenderAnimatedOpacity / Opacity / SliverOpacity deep demo
import 'package:flutter/material.dart';

// =============================================================================
// RenderAnimatedOpacity & RenderSliverAnimatedOpacity — Deep Demo
// =============================================================================
//
// `RenderAnimatedOpacity` (and its sliver counterpart `RenderSliverAnimatedOpacity`)
// are the render objects backing the public `AnimatedOpacity` and
// `SliverAnimatedOpacity` widgets. They animate the alpha channel of their
// child between two `double` values in `[0.0, 1.0]` using a
// `Tween<double>` driven by an internal `AnimationController`.
//
// On every frame, the current opacity is read from the animation. When the
// value is exactly `1.0`, the render object skips compositing entirely and
// paints its child as-is. For any partial value (`> 0` and `< 1`), the engine
// allocates a `saveLayer`, paints the child into it, and then composes the
// layer with the configured alpha. At `0.0` the layer is skipped (the child
// is not painted at all, but the box still occupies layout space and still
// hit-tests by default).
//
// Because this demo is a static, single-frame render — there is no event
// loop available to drive an `AnimationController` here — we cannot animate
// in real-time. Instead, we lay out the *target frames* of the implicit
// animation as a fade-ladder: a series of `Opacity` widgets at fixed values
// `[0.0, 0.1, 0.2, ..., 1.0]`. Each cell in the ladder represents what
// `AnimatedOpacity` would render at that moment of the tween.
//
// Captions throughout this file make the connection explicit:
//
//   * "Frame 0 of fade-in"   — opacity 0.0
//   * "Frame 50% of fade"     — opacity 0.5
//   * "Frame final"           — opacity 1.0
//
// This way a reader sees the full visual gradient of the animation in one
// shot, plus the rendering implications of partial alpha (saveLayer cost,
// hit-testing semantics, image quality nuances).
// =============================================================================

dynamic build(BuildContext context) {
  print('=== RenderAnimatedOpacity Deep Demo ===');
  print('Subject: RenderAnimatedOpacity, RenderSliverAnimatedOpacity');
  print('Public widgets: AnimatedOpacity, SliverAnimatedOpacity, Opacity, SliverOpacity');
  print('Static visualisation: 11-frame fade ladder, 0.0..1.0 in 0.1 steps');

  return MaterialApp(
    title: 'RenderAnimatedOpacity Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.deepPurple,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F1FA),
      appBar: AppBar(
        title: const Text('RenderAnimatedOpacity'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _section1HeroHeader(),
              const SizedBox(height: 24),
              _section2FadeLadder(),
              const SizedBox(height: 24),
              _section3BeforeAfterContrast(),
              const SizedBox(height: 24),
              _section4AlphaBlendVisualization(),
              const SizedBox(height: 24),
              _section5ApiReference(),
              const SizedBox(height: 24),
              _section6SliverOpacityDemo(),
              const SizedBox(height: 24),
              _section7PerformancePanel(),
              const SizedBox(height: 24),
              _section8ComparisonTable(),
              const SizedBox(height: 24),
              _section9Pitfalls(),
              const SizedBox(height: 24),
              _section10SeeAlso(),
              const SizedBox(height: 32),
              _footer(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 — Hero header
// ---------------------------------------------------------------------------
// Introduces the subject. `AnimatedOpacity` is the implicit-animation widget;
// `RenderAnimatedOpacity` is the render object that performs the per-frame
// compositing under the hood. Because the script runs as a static render,
// we frame the demo as a "snapshot of the animation's target frames."

Widget _section1HeroHeader() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade400,
          Colors.cyan.shade300,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withOpacity(0.35),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.opacity, size: 36, color: Colors.white),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RenderAnimatedOpacity',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Per-frame alpha compositing for AnimatedOpacity',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'How this demo works',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'AnimatedOpacity introduces an implicit animation between two '
                'opacity values. RenderAnimatedOpacity allocates a saveLayer '
                'and applies the current alpha on every frame.',
                style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
              ),
              SizedBox(height: 8),
              Text(
                'Because this script renders a single static frame, we cannot '
                'show the animation in motion. Instead, we lay out the target '
                'frames side-by-side as a fade-ladder of Opacity widgets.',
                style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _heroChip(Icons.animation, 'Implicit'),
            _heroChip(Icons.layers, 'saveLayer'),
            _heroChip(Icons.gradient, 'Tween<double>'),
            _heroChip(Icons.touch_app, 'Hit-test 0..1'),
            _heroChip(Icons.accessibility_new, 'Semantics'),
            _heroChip(Icons.view_agenda_outlined, 'Sliver variant'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.22),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white38, width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — Fade ladder
// ---------------------------------------------------------------------------
// The visual centerpiece. 11 cards, each wrapped in `Opacity(opacity: i/10)`
// for `i` in 0..10. Together they enumerate the target frames of an
// `AnimatedOpacity` fade-out (1.0 -> 0.0). Read left-to-right for fade-out,
// right-to-left for fade-in.

Widget _section2FadeLadder() {
  return _sectionShell(
    title: '2. Fade ladder — 11 frames of an implicit fade',
    accent: Colors.deepPurple,
    icon: Icons.linear_scale,
    description:
        'Each card below is wrapped in an Opacity widget at a fixed value. '
        'Treat this row as eleven snapshots of an AnimatedOpacity transition: '
        'the leftmost card is the final frame of a fade-out (alpha 0.0), the '
        'rightmost is the start (alpha 1.0). RenderAnimatedOpacity walks these '
        'values continuously while its controller advances.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ladderBackdrop(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List<Widget>.generate(11, (i) {
                final value = i / 10.0;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _ladderFrame(value, i),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 14),
        _ladderLegend(),
      ],
    ),
  );
}

Widget _ladderBackdrop({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEDE7F6), Color(0xFFFFF8E1)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.deepPurple.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

Widget _ladderFrame(double value, int index) {
  String captionFor(int i) {
    if (i == 0) return 'frame 0\nfade-in';
    if (i == 5) return 'frame 50%\n(midpoint)';
    if (i == 10) return 'frame final\nfade-in';
    return 'frame ${(value * 100).round()}%';
  }

  return Column(
    children: [
      Container(
        width: 78,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple.shade100),
        ),
        child: Center(
          child: Opacity(
            opacity: value,
            child: Container(
              width: 64,
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple.shade400,
                    Colors.indigo.shade300,
                    Colors.cyan.shade400,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.star, color: Colors.white, size: 28),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade700,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 4),
      SizedBox(
        width: 78,
        child: Text(
          captionFor(index),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.deepPurple.shade900,
            height: 1.2,
          ),
        ),
      ),
    ],
  );
}

Widget _ladderLegend() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.deepPurple.shade100),
    ),
    child: const Row(
      children: [
        Icon(Icons.lightbulb_outline, color: Colors.deepPurple, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Animation reads: left-to-right is a fade-out (1.0 -> 0.0). '
            'Right-to-left is a fade-in. Each cell is what RenderAnimatedOpacity '
            'paints on a single frame of the controller.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — Before / after contrast
// ---------------------------------------------------------------------------
// Two cards side by side: one fully visible (opacity 1.0), one fully
// transparent (opacity 0.0). The transparent card still occupies layout
// space and a placeholder rectangle reveals what is "there but invisible".

Widget _section3BeforeAfterContrast() {
  return _sectionShell(
    title: '3. Before / after — opacity 1.0 vs 0.0',
    accent: Colors.teal,
    icon: Icons.compare_arrows,
    description:
        'A side-by-side pair illustrates the boundary cases of the tween. '
        'The left card is fully opaque (alpha 255). The right card is fully '
        'transparent (alpha 0): RenderAnimatedOpacity skips painting its child '
        'entirely, but the box still consumes the same layout slot.',
    // C8: drop CrossAxisAlignment.stretch on this Row. The enclosing Column
    // sits inside a vertical SingleChildScrollView, so the Row's cross axis
    // (vertical) max is infinite — `stretch` would then pass tight infinite
    // height to each Expanded's child, which collides with _ContrastCard's
    // own `height: 220` ConstrainedBox.
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _ContrastCard(opacity: 1.0, label: 'opacity 1.0')),
        const SizedBox(width: 12),
        Expanded(child: _ContrastCard(opacity: 0.0, label: 'opacity 0.0')),
      ],
    ),
  );
}

class _ContrastCard extends StatelessWidget {
  final double opacity;
  final String label;
  const _ContrastCard({required this.opacity, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.teal.shade200,
          width: 1.5,
          style: BorderStyle.solid,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background placeholder — visible when opacity is 0.
          Padding(
            padding: const EdgeInsets.all(14),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.teal.shade100.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.teal.shade300,
                  width: 1,
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'placeholder\n(layout slot)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.teal,
                      fontStyle: FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Foreground content — wrapped in Opacity.
          Padding(
            padding: const EdgeInsets.all(14),
            child: Opacity(
              opacity: opacity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.teal.shade600, Colors.cyan.shade400],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome, color: Colors.white, size: 36),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      opacity == 0.0 ? 'invisible' : 'fully opaque',
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
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
}

// ---------------------------------------------------------------------------
// SECTION 4 — AlphaBlend visualization
// ---------------------------------------------------------------------------
// A `Stack` layers a colored background behind a partially transparent
// foreground. The three foreground opacities (0.25, 0.5, 0.75) make the
// alpha-blend math visible.

Widget _section4AlphaBlendVisualization() {
  return _sectionShell(
    title: '4. AlphaBlend visualization',
    accent: Colors.orange,
    icon: Icons.blur_on,
    description:
        'When a child is painted with partial alpha, the engine blends the '
        'layer pixels against whatever sits beneath. Below, the same warm '
        'gradient backdrop sits behind three foreground cards at 0.25, 0.50, '
        'and 0.75 opacity. The visible mix shifts from "mostly background" to '
        '"mostly foreground" as alpha rises.',
    child: Container(
      height: 240,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.shade300,
            Colors.deepOrange.shade400,
            Colors.red.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: _AlphaSample(opacity: 0.25)),
            const SizedBox(width: 12),
            Expanded(child: _AlphaSample(opacity: 0.50)),
            const SizedBox(width: 12),
            Expanded(child: _AlphaSample(opacity: 0.75)),
          ],
        ),
      ),
    ),
  );
}

class _AlphaSample extends StatelessWidget {
  final double opacity;
  const _AlphaSample({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Opacity(
            opacity: opacity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.brightness_5,
                      color: Colors.deepOrange.shade700,
                      size: 32,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      opacity.toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.deepOrange.shade900,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'alpha ${(opacity * 100).round()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 — `AnimatedOpacity` API reference card
// ---------------------------------------------------------------------------
// One sub-card per parameter: `opacity`, `duration`, `curve`,
// `alwaysIncludeSemantics`. Each describes what RenderAnimatedOpacity does
// with the value.

Widget _section5ApiReference() {
  return _sectionShell(
    title: '5. AnimatedOpacity API reference',
    accent: Colors.indigo,
    icon: Icons.menu_book_outlined,
    description:
        'The four most consequential parameters of AnimatedOpacity, each '
        'unpacked with its render-object semantics.',
    child: Column(
      children: [
        _ApiCard(
          icon: Icons.opacity,
          color: Colors.indigo,
          name: 'opacity',
          type: 'double (0.0 - 1.0)',
          summary: 'Target alpha. Whenever this changes, the controller resets '
              'and tweens from the current animated value to the new target.',
          notes: const [
            'opacity == 1.0   -> child painted directly (no saveLayer, fast).',
            'opacity == 0.0   -> child not painted at all (skipped entirely).',
            'opacity in (0,1) -> saveLayer allocated, alpha applied.',
          ],
        ),
        const SizedBox(height: 12),
        _ApiCard(
          icon: Icons.timer_outlined,
          color: Colors.deepPurple,
          name: 'duration',
          type: 'Duration',
          summary: 'How long the implicit tween should take when opacity '
              'changes. Required: there is no default.',
          notes: const [
            'Typical values: 150ms (snappy), 300ms (default-feeling), 500ms (slow).',
            'Setting Duration.zero turns AnimatedOpacity into a plain Opacity.',
            'Each opacity change re-arms the controller from t=0.',
          ],
        ),
        const SizedBox(height: 12),
        _ApiCard(
          icon: Icons.show_chart,
          color: Colors.teal,
          name: 'curve',
          type: 'Curve (default Curves.linear)',
          summary: 'Maps the controller value (0..1) to the tween position. '
              'A non-linear curve makes the fade ease in or out.',
          notes: const [
            'Curves.easeIn      — slow start, fast finish.',
            'Curves.easeOut     — fast start, slow finish.',
            'Curves.easeInOut   — slow at both ends.',
            'Curves.fastOutSlowIn — Material standard motion curve.',
          ],
        ),
        const SizedBox(height: 12),
        _ApiCard(
          icon: Icons.accessibility_new,
          color: Colors.green,
          name: 'alwaysIncludeSemantics',
          type: 'bool (default false)',
          summary: 'When false, the child stops contributing to the semantics '
              'tree once opacity hits 0. When true, semantics remain live '
              'regardless of visual opacity.',
          notes: const [
            'Default false — invisible content is not announced by screen readers.',
            'Set true if the child must remain reachable by assistive tech '
            'even when alpha is 0 (rare).',
          ],
        ),
      ],
    ),
  );
}

class _ApiCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;
  final String type;
  final String summary;
  final List<String> notes;
  const _ApiCard({
    required this.icon,
    required this.color,
    required this.name,
    required this.type,
    required this.summary,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            summary,
            style: const TextStyle(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          ...notes.map((n) => Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.chevron_right, size: 16, color: color),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        n,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6 — `SliverOpacity` demo
// ---------------------------------------------------------------------------
// A `CustomScrollView` inside a fixed-height SizedBox shows two slivers:
// one wrapped in `SliverOpacity(opacity: 0.4)`, the sibling at full opacity.
// This contrasts sliver-level alpha against box-level alpha.

Widget _section6SliverOpacityDemo() {
  return _sectionShell(
    title: '6. SliverOpacity inside a CustomScrollView',
    accent: Colors.brown,
    icon: Icons.view_list,
    description:
        'SliverOpacity is the sliver-protocol companion to Opacity. It wraps '
        'a child sliver, paints into a saveLayer at the requested alpha, and '
        'composites the entire sliver geometry with that opacity. The list '
        'below shows two SliverList sections back-to-back: the first runs at '
        'opacity 0.4, the second at full opacity.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.brown.shade200),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverToBoxAdapter(
                    child: _sliverHeader(
                      'Faded sliver (opacity 0.4)',
                      Icons.opacity,
                      Colors.brown.shade400,
                    ),
                  ),
                ),
                SliverOpacity(
                  opacity: 0.4,
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => _sliverItem(
                        i,
                        Colors.brown,
                        'Faded item ${i + 1}',
                        Icons.local_cafe,
                      ),
                      childCount: 4,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverToBoxAdapter(
                    child: _sliverHeader(
                      'Full opacity sliver (1.0)',
                      Icons.brightness_high,
                      Colors.brown.shade700,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _sliverItem(
                      i,
                      Colors.brown,
                      'Solid item ${i + 1}',
                      Icons.coffee,
                    ),
                    childCount: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _miniNote(
          'Tip: SliverOpacity wraps the entire sliver geometry; the saveLayer '
          'covers the sliver paint extent. Box-level Opacity inside a sliver '
          'would only fade individual children — comparable visually but more '
          'expensive at scroll boundaries.',
          Colors.brown,
        ),
      ],
    ),
  );
}

Widget _sliverHeader(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

Widget _sliverItem(int index, MaterialColor base, String label, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: base.shade200),
        boxShadow: [
          BoxShadow(
            color: base.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: base.shade100,
            child: Icon(icon, size: 16, color: base.shade700),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 13)),
          ),
          Icon(Icons.chevron_right, color: base.shade400, size: 18),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — Performance panel
// ---------------------------------------------------------------------------
// Discusses saveLayer cost and recommends FadeTransition when an
// Animation<double> is already on hand.

Widget _section7PerformancePanel() {
  return _sectionShell(
    title: '7. Performance — the saveLayer story',
    accent: Colors.red,
    icon: Icons.speed,
    description:
        'RenderAnimatedOpacity is correct, ergonomic, and not free. Whenever '
        'opacity is in the open interval (0, 1) it allocates an offscreen '
        'layer, paints the child into it, and composites the layer with '
        'alpha. Knowing when to pay this cost — and when to avoid it — is '
        'the difference between buttery animations and frame drops.',
    child: Column(
      children: [
        _perfRow(
          icon: Icons.layers_outlined,
          color: Colors.red,
          title: 'saveLayer is allocated per frame',
          body: 'During an animation every frame in the open interval (0,1) '
              'forces a new offscreen surface. This is the dominant cost.',
        ),
        const SizedBox(height: 10),
        _perfRow(
          icon: Icons.timer_off_outlined,
          color: Colors.orange,
          title: 'Boundary frames are cheap',
          body: 'At opacity 0 the subtree is skipped entirely. At opacity 1 '
              'the layer is bypassed and the child paints directly. The '
              'expensive frames are the in-between ones.',
        ),
        const SizedBox(height: 10),
        _perfRow(
          icon: Icons.swap_horiz,
          color: Colors.teal,
          title: 'Prefer FadeTransition when you have an Animation<double>',
          body: 'AnimatedOpacity owns its controller. If you already drive '
              'an Animation<double> (e.g. from a Hero, a route transition, '
              'a parent AnimationController), FadeTransition reuses it and '
              'is otherwise identical at paint time.',
        ),
        const SizedBox(height: 10),
        _perfRow(
          icon: Icons.grid_on_outlined,
          color: Colors.deepPurple,
          title: 'Avoid wrapping huge subtrees',
          body: 'Place AnimatedOpacity as low in the tree as possible. The '
              'saveLayer is sized to the wrapped widget; smaller widget == '
              'smaller layer.',
        ),
        const SizedBox(height: 10),
        _perfRow(
          icon: Icons.image_outlined,
          color: Colors.indigo,
          title: 'For images, consider FadeInImage',
          body: 'FadeInImage handles the placeholder/cross-fade pattern '
              'without an explicit AnimatedOpacity in your tree.',
        ),
      ],
    ),
  );
}

Widget _perfRow({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — Comparison table
// ---------------------------------------------------------------------------
// Side-by-side decoded summary of `Opacity`, `AnimatedOpacity`, and
// `FadeTransition`.

Widget _section8ComparisonTable() {
  return _sectionShell(
    title: '8. Opacity vs AnimatedOpacity vs FadeTransition',
    accent: Colors.blueGrey,
    icon: Icons.table_chart,
    description:
        'Three primitives, three philosophies. Choose by which one already '
        'fits your data flow: a static value, an implicit animation, or an '
        'externally-driven Animation<double>.',
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blueGrey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _tableHeader(),
          const Divider(height: 1),
          _tableRow(
            'Opacity',
            'static double',
            'no',
            'Set value once and forget. No animation.',
            Colors.indigo,
            Icons.opacity,
          ),
          const Divider(height: 1),
          _tableRow(
            'AnimatedOpacity',
            'double + Duration',
            'implicit',
            'Owns its controller. Easiest API for state-driven fades.',
            Colors.deepPurple,
            Icons.animation,
          ),
          const Divider(height: 1),
          _tableRow(
            'FadeTransition',
            'Animation<double>',
            'external',
            'Reuses an existing animation. Best when many widgets share a '
                'controller.',
            Colors.teal,
            Icons.tune,
          ),
        ],
      ),
    ),
  );
}

Widget _tableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    color: Colors.blueGrey.shade50,
    child: const Row(
      children: [
        Expanded(flex: 3, child: Text('Widget', style: _tableHeaderStyle)),
        Expanded(flex: 3, child: Text('Input', style: _tableHeaderStyle)),
        Expanded(flex: 2, child: Text('Animation', style: _tableHeaderStyle)),
        Expanded(flex: 6, child: Text('When to use', style: _tableHeaderStyle)),
      ],
    ),
  );
}

const TextStyle _tableHeaderStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 12,
  color: Colors.blueGrey,
);

Widget _tableRow(
  String name,
  String input,
  String animation,
  String use,
  Color color,
  IconData icon,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            input,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            animation,
            style: const TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            use,
            style: const TextStyle(fontSize: 11, height: 1.3),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — Pitfalls
// ---------------------------------------------------------------------------
// Hit-testing at opacity 0, semantics exposure, image quality nuances.

Widget _section9Pitfalls() {
  return _sectionShell(
    title: '9. Pitfalls',
    accent: Colors.red,
    icon: Icons.warning_amber_rounded,
    description:
        'Things that surprise even seasoned Flutter developers when the '
        'animation hits its boundary frames.',
    child: Column(
      children: [
        _PitfallCard(
          icon: Icons.touch_app,
          color: Colors.red,
          title: 'Hit-testing still fires at opacity 0',
          body:
              'A widget at opacity 0 is invisible but still consumes pointer '
              'events. Tap targets fire, drags begin, etc. To turn off '
              'interaction, wrap the same subtree in IgnorePointer or use '
              'Visibility(maintainInteractivity: false).',
          example: 'IgnorePointer(\n'
              '  ignoring: opacity == 0.0,\n'
              '  child: AnimatedOpacity(\n'
              '    opacity: opacity,\n'
              '    duration: const Duration(milliseconds: 250),\n'
              '    child: const ActionButton(),\n'
              '  ),\n'
              ')',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          icon: Icons.accessibility_new,
          color: Colors.deepOrange,
          title: 'Semantics may still announce invisible content',
          body:
              'By default, AnimatedOpacity drops semantics when alpha hits 0. '
              'But if alwaysIncludeSemantics is true, screen readers will '
              'still announce hidden text. Use ExcludeSemantics or rely on '
              'the default to keep the invisible content silent.',
          example: 'AnimatedOpacity(\n'
              '  opacity: 0.0,\n'
              '  duration: kThemeAnimationDuration,\n'
              '  alwaysIncludeSemantics: false, // default — best practice\n'
              '  child: const Text(\'Hidden message\'),\n'
              ')',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          icon: Icons.high_quality,
          color: Colors.purple,
          title: 'Image-quality nuances when fading large bitmaps',
          body:
              'A saveLayer over a high-resolution bitmap can introduce subtle '
              'banding or dithering on low-end GPUs. For images, prefer '
              'FadeInImage which uses a more optimised cross-fade path.',
          example: 'FadeInImage(\n'
              '  placeholder: const AssetImage(\'assets/blur.png\'),\n'
              '  image: NetworkImage(url),\n'
              '  fadeInDuration: const Duration(milliseconds: 320),\n'
              ')',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          icon: Icons.layers,
          color: Colors.brown,
          title: 'Nested opacities multiply',
          body:
              'Two AnimatedOpacity widgets on the same subtree multiply their '
              'alpha. A 0.5 inside another 0.5 yields 0.25 final alpha — and '
              'two saveLayers, doubling the cost. Flatten when you can.',
          example: '// avoid:\n'
              'AnimatedOpacity(\n'
              '  opacity: 0.5,\n'
              '  child: AnimatedOpacity(\n'
              '    opacity: 0.5,\n'
              '    child: child, // ends up at 0.25 alpha, two saveLayers\n'
              '  ),\n'
              ')',
        ),
      ],
    ),
  );
}

class _PitfallCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String example;
  const _PitfallCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              example,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFFE0E0F0),
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
// SECTION 10 — See also
// ---------------------------------------------------------------------------
// Cross-references: AnimatedSwitcher, FadeTransition, FadeInImage,
// Visibility(maintainState: true).

Widget _section10SeeAlso() {
  return _sectionShell(
    title: '10. See also',
    accent: Colors.cyan,
    icon: Icons.link,
    description:
        'Adjacent APIs that intersect with the alpha-compositing space, '
        'each with a slightly different ergonomic sweet spot.',
    child: Column(
      children: [
        _SeeAlsoTile(
          icon: Icons.swap_horiz,
          color: Colors.teal,
          name: 'AnimatedSwitcher',
          summary:
              'Cross-fades between two children. Internally uses AnimatedOpacity '
              'on each child. Provides transitionBuilder for custom transitions.',
        ),
        const SizedBox(height: 10),
        _SeeAlsoTile(
          icon: Icons.tune,
          color: Colors.indigo,
          name: 'FadeTransition',
          summary:
              'Listens to an externally provided Animation<double>. Use when '
              'you already have a controller; one less widget owning state.',
        ),
        const SizedBox(height: 10),
        _SeeAlsoTile(
          icon: Icons.image_outlined,
          color: Colors.deepOrange,
          name: 'FadeInImage',
          summary:
              'Specialised fade-in for images, with a placeholder. Avoids the '
              'flicker that an AnimatedOpacity over an ImageProvider would show '
              'while the network image loads.',
        ),
        const SizedBox(height: 10),
        _SeeAlsoTile(
          icon: Icons.visibility,
          color: Colors.green,
          name: 'Visibility(maintainState: true)',
          summary:
              'When you want both a fade-out and a layout collapse. AnimatedOpacity '
              'never collapses layout — the box stays its full size at alpha 0.',
        ),
        const SizedBox(height: 10),
        _SeeAlsoTile(
          icon: Icons.layers_clear,
          color: Colors.purple,
          name: 'IgnorePointer / AbsorbPointer',
          summary:
              'Pair with AnimatedOpacity to disable interaction during fade-out. '
              'Without one of these, an "invisible" widget still receives taps.',
        ),
        const SizedBox(height: 10),
        _SeeAlsoTile(
          icon: Icons.view_agenda_outlined,
          color: Colors.brown,
          name: 'SliverAnimatedOpacity',
          summary:
              'Sliver-protocol equivalent of AnimatedOpacity. Backed by '
              'RenderSliverAnimatedOpacity, identical semantics applied to a '
              'whole sliver.',
        ),
      ],
    ),
  );
}

class _SeeAlsoTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;
  final String summary;
  const _SeeAlsoTile({
    required this.icon,
    required this.color,
    required this.name,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  summary,
                  style: const TextStyle(fontSize: 12, height: 1.4),
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
// Footer
// ---------------------------------------------------------------------------

Widget _footer() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade800, Colors.indigo.shade700],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withOpacity(0.25),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'RenderAnimatedOpacity — recap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Implicit fade between two opacity values. Boundary frames (0 and 1) '
          'are cheap; in-between frames allocate a saveLayer. Use FadeTransition '
          'when the animation source is external; use FadeInImage for images; '
          'pair with IgnorePointer when alpha-0 should also disable input.',
          style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared helpers — section shell, mini-note
// ---------------------------------------------------------------------------

Widget _sectionShell({
  required String title,
  required Color accent,
  required IconData icon,
  required String description,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: accent.withOpacity(0.18)),
      boxShadow: [
        BoxShadow(
          color: accent.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: accent, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

Widget _miniNote(String text, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.tips_and_updates_outlined, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, height: 1.45),
          ),
        ),
      ],
    ),
  );
}
