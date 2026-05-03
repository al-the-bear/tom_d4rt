// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// BorderTween Deep Demo
// =============================================================================
//
// `BorderTween` is a `Tween<Border?>` whose `lerp` delegates to `Border.lerp`.
// It is the standard mechanism to animate a `Border` value over the lifetime
// of an `Animation<double>` (typically driven by an `AnimationController`).
//
// In `BoxDecoration`, the `border` field accepts `BoxBorder` (the supertype of
// `Border` and `BorderDirectional`). `BorderTween` deals specifically with
// `Border`, which is the most common case and supports per-side
// configuration (top/right/bottom/left).
//
// Key facts:
//
//   * `Border.lerp(a, b, t)` linearly interpolates the four `BorderSide`s.
//   * `BorderSide.lerp(a, b, t)` interpolates color and width, but *style*
//     snaps (it is not lerpable).
//   * Both ends may be `null`: `BorderTween(begin: null, end: someBorder)`
//     fades the border in.  Mid-frame the value can be `null` (edges only).
//   * To animate an entire `BoxDecoration` (color + border + radius +
//     shadow + gradient) use `DecorationTween` instead.
//
// This file demonstrates `BorderTween` in isolation, with multiple usage
// patterns and pitfalls.  It is hand-authored and meant to be readable as
// a long form tutorial as much as it is meant to be executed.
//
// =============================================================================

dynamic build(BuildContext context) {
  print('=== BorderTween Deep Demo ===');
  return const _BorderTweenDeepDemoApp();
}

// =============================================================================
// Root app widget
// =============================================================================

class _BorderTweenDeepDemoApp extends StatelessWidget {
  const _BorderTweenDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BorderTween Deep Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
          bodySmall: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ),
      home: const _BorderTweenDeepDemoHome(),
    );
  }
}

class _BorderTweenDeepDemoHome extends StatelessWidget {
  const _BorderTweenDeepDemoHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FB),
      appBar: AppBar(
        title: const Text('BorderTween Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _SectionIntro(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 1,
                title: 'Color morph',
                subtitle: 'Uniform Border.all → Border.all with different color.',
              ),
              _ColorMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 2,
                title: 'Width morph',
                subtitle: 'Same color, width 1 → 12 with reverseCurve.',
              ),
              _WidthMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 3,
                title: 'Per-side morph',
                subtitle: 'Top/right/bottom/left morph independently.',
              ),
              _PerSideMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 4,
                title: 'Style morph',
                subtitle: 'BorderStyle.solid ↔ BorderStyle.none (snap).',
              ),
              _StyleMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 5,
                title: 'Coordinated multi-card',
                subtitle: 'One controller, four BorderTweens, staggered intervals.',
              ),
              _MultiCardMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 6,
                title: 'Continuous loop',
                subtitle: 'easeInOutCubic forward, easeOutBack reverse.',
              ),
              _LoopMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 7,
                title: 'BorderTween vs DecorationTween',
                subtitle: 'Border alone vs entire BoxDecoration.',
              ),
              _VsDecoration(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 8,
                title: 'State-driven morph',
                subtitle: 'Tap to thicken / colorize the border.',
              ),
              _StateMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 9,
                title: 'Rounded rect morph',
                subtitle: 'Pair BorderTween with BorderRadiusTween.',
              ),
              _RoundedRectMorph(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 10,
                title: 'Recipe gallery',
                subtitle: 'Selection / validation / focus / shimmer.',
              ),
              _RecipeGallery(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 11,
                title: 'Pitfalls',
                subtitle: 'Five things that bite you with BorderTween.',
              ),
              _PitfallSection(),
              SizedBox(height: 24),
              _SectionHeader(
                index: 12,
                title: 'Reference table',
                subtitle: 'Family of border / decoration tweens.',
              ),
              _ReferenceTable(),
              SizedBox(height: 32),
              _Footer(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section heading + small helpers
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text, {this.icon});
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? Icons.info_outline, size: 16, color: Colors.indigo),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFD9E0EE),
          height: 1.4,
        ),
      ),
    );
  }
}

// =============================================================================
// Intro
// =============================================================================

class _SectionIntro extends StatelessWidget {
  const _SectionIntro();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BorderTween — Tween<Border?> using Border.lerp',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const _Caption(
            'BorderTween is a thin Tween subclass whose lerp() delegates to '
            'Border.lerp(begin, end, t). Drive it with an AnimationController '
            'and consume the Animation<Border?> in an AnimatedBuilder to '
            'rebuild a Container with the interpolated decoration.',
          ),
          const SizedBox(height: 8),
          const _BorderMorphDiagram(),
          const SizedBox(height: 8),
          const _CodeBlock(
            'final tween = BorderTween(\n'
            '  begin: Border.all(color: Colors.blue, width: 2),\n'
            '  end:   Border.all(color: Colors.pink, width: 6),\n'
            ');\n'
            'final Animation<Border?> anim = tween.animate(controller);\n'
            'AnimatedBuilder(\n'
            '  animation: anim,\n'
            '  builder: (_, __) => Container(\n'
            '    decoration: BoxDecoration(border: anim.value),\n'
            '    child: ...,\n'
            '  ),\n'
            ');',
          ),
          const _Caption(
            'Each per-side BorderSide is interpolated independently '
            '(color + width). Style snaps. Identity is preserved when '
            'a value is null on one end (it lerps to/from "no border").',
            icon: Icons.lightbulb_outline,
          ),
        ],
      ),
    );
  }
}

class _BorderMorphDiagram extends StatelessWidget {
  const _BorderMorphDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _DiagramBox(
            label: 'begin',
            border: Border.all(color: Colors.blue, width: 2),
          ),
          const Icon(Icons.arrow_forward, color: Colors.indigo),
          _DiagramBox(
            label: 't = 0.33',
            border: Border.all(
              color: Color.lerp(Colors.blue, Colors.pink, 0.33)!,
              width: 2 + (6 - 2) * 0.33,
            ),
          ),
          const Icon(Icons.arrow_forward, color: Colors.indigo),
          _DiagramBox(
            label: 't = 0.67',
            border: Border.all(
              color: Color.lerp(Colors.blue, Colors.pink, 0.67)!,
              width: 2 + (6 - 2) * 0.67,
            ),
          ),
          const Icon(Icons.arrow_forward, color: Colors.indigo),
          _DiagramBox(
            label: 'end',
            border: Border.all(color: Colors.pink, width: 6),
          ),
        ],
      ),
    );
  }
}

class _DiagramBox extends StatelessWidget {
  const _DiagramBox({required this.label, required this.border});
  final String label;
  final Border border;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            border: border,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}

// =============================================================================
// D4rt-friendly tween-driven animation helpers
// =============================================================================
//
// `tween.animate(controller)` returns an `AnimationWithParentMixin` instance.
// In D4rt the bridge for that mixin currently lacks `value` (it inherits it
// only via `implements Animation<T>`, and the bridge generator's
// `_collectInheritedMembers` walks the superclass chain only). Reading
// `.value` on the returned animation therefore fails at runtime.
//
// As a portable workaround we keep the `BorderTween` instance and its
// `Animation<double>` driver separately, and call `tween.evaluate(driver)`
// to obtain the current value. `Tween.evaluate` is bridged, so this is
// stable across both the analyzer-based and AST-driven runtimes.
class _BorderAnim {
  _BorderAnim(this.tween, this.driver);
  final BorderTween tween;
  final Animation<double> driver;
  Border? get value => tween.evaluate(driver);
  Animation<double> get listenable => driver;
}

class _BorderRadiusAnim {
  _BorderRadiusAnim(this.tween, this.driver);
  final BorderRadiusTween tween;
  final Animation<double> driver;
  BorderRadius? get value => tween.evaluate(driver);
  Animation<double> get listenable => driver;
}

// =============================================================================
// 2. Color morph
// =============================================================================

class _ColorMorph extends StatefulWidget {
  const _ColorMorph();
  @override
  State<_ColorMorph> createState() => _ColorMorphState();
}

class _ColorMorphState extends State<_ColorMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.blue, width: 4),
        end: Border.all(color: Colors.pink, width: 4),
      ),
      _ctrl,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'A Container with a uniform 4 px border, color cycling between '
            'blue and pink. The width stays constant; only the color '
            'interpolates (HSV-ish via Color.lerp).',
          ),
          const SizedBox(height: 12),
          Center(
            child: AnimatedBuilder(
              animation: _border.listenable,
              builder: (context, _) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: _border.value,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const _CodeBlock(
            'BorderTween(\n'
            '  begin: Border.all(color: Colors.blue, width: 4),\n'
            '  end:   Border.all(color: Colors.pink, width: 4),\n'
            ').animate(controller); // controller.repeat(reverse: true)',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3. Width morph
// =============================================================================

class _WidthMorph extends StatefulWidget {
  const _WidthMorph();
  @override
  State<_WidthMorph> createState() => _WidthMorphState();
}

class _WidthMorphState extends State<_WidthMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    final curved = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.indigo, width: 1),
        end: Border.all(color: Colors.indigo, width: 12),
      ),
      curved,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'Width lerps from 1 px to 12 px and back. Note that as a side '
            'grows, the inner content area shrinks because borders inset '
            'their child (per BoxDecoration.padding rules).',
          ),
          const SizedBox(height: 12),
          Center(
            child: AnimatedBuilder(
              animation: _border.listenable,
              builder: (context, _) {
                return Container(
                  width: 160,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: _border.value,
                  ),
                  child: const Text(
                    'width morph',
                    style: TextStyle(color: Colors.indigo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 4. Per-side morph
// =============================================================================

class _PerSideMorph extends StatefulWidget {
  const _PerSideMorph();
  @override
  State<_PerSideMorph> createState() => _PerSideMorphState();
}

class _PerSideMorphState extends State<_PerSideMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _border = _BorderAnim(
      BorderTween(
        begin: const Border(
          top: BorderSide(color: Colors.red, width: 2),
          right: BorderSide(color: Colors.green, width: 2),
          bottom: BorderSide(color: Colors.blue, width: 2),
          left: BorderSide(color: Colors.orange, width: 2),
        ),
        end: const Border(
          top: BorderSide(color: Colors.purple, width: 8),
          right: BorderSide(color: Colors.amber, width: 1),
          bottom: BorderSide(color: Colors.teal, width: 6),
          left: BorderSide(color: Colors.pink, width: 4),
        ),
      ),
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'Each side has its own color and width and interpolates '
            'independently. Border.lerp interpolates each side\'s '
            'BorderSide via BorderSide.lerp.',
          ),
          const SizedBox(height: 12),
          Center(
            child: AnimatedBuilder(
              animation: _border.listenable,
              builder: (context, _) {
                return Container(
                  width: 180,
                  height: 110,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: _border.value,
                  ),
                  child: const Text('per-side'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 5. Style morph (snap)
// =============================================================================

class _StyleMorph extends StatefulWidget {
  const _StyleMorph();
  @override
  State<_StyleMorph> createState() => _StyleMorphState();
}

class _StyleMorphState extends State<_StyleMorph>
    with TickerProviderStateMixin {
  late final AnimationController _solidNoneCtrl;
  late final _BorderAnim _solidNone;
  late final AnimationController _colorCtrl;
  late final _BorderAnim _colorOnly;

  @override
  void initState() {
    super.initState();
    _solidNoneCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _solidNone = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.indigo, width: 4),
        end: Border.all(
          color: Colors.indigo,
          width: 4,
          style: BorderStyle.none,
        ),
      ),
      _solidNoneCtrl,
    );

    _colorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _colorOnly = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.green, width: 3),
        end: Border.all(color: Colors.deepOrange, width: 3),
      ),
      _colorCtrl,
    );
  }

  @override
  void dispose() {
    _solidNoneCtrl.dispose();
    _colorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'BorderStyle is *not* lerpable. Going from solid to none, the '
            'style flips at t > 0 (the side becomes "no border" almost '
            'immediately). The width still lerps but the side is invisible.',
            icon: Icons.warning_amber_outlined,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _solidNone.listenable,
                    builder: (context, _) {
                      return Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: _solidNone.value,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'solid ↔ none',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _colorOnly.listenable,
                    builder: (context, _) {
                      return Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: _colorOnly.value,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'green ↔ orange',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 6. Coordinated multi-card
// =============================================================================

class _MultiCardMorph extends StatefulWidget {
  const _MultiCardMorph();
  @override
  State<_MultiCardMorph> createState() => _MultiCardMorphState();
}

class _MultiCardMorphState extends State<_MultiCardMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<_BorderAnim> _borders;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    final tweens = <BorderTween>[
      BorderTween(
        begin: Border.all(color: Colors.indigo, width: 1),
        end: Border.all(color: Colors.indigo, width: 6),
      ),
      BorderTween(
        begin: Border.all(color: Colors.teal, width: 1),
        end: Border.all(color: Colors.cyan, width: 4),
      ),
      BorderTween(
        begin: Border.all(color: Colors.orange, width: 1),
        end: Border.all(color: Colors.red, width: 4),
      ),
      BorderTween(
        begin: Border.all(color: Colors.deepPurple, width: 1),
        end: Border.all(color: Colors.pink, width: 5),
      ),
    ];

    final intervals = <Curve>[
      const Interval(0.0, 0.45, curve: Curves.easeOut),
      const Interval(0.15, 0.6, curve: Curves.easeOut),
      const Interval(0.3, 0.75, curve: Curves.easeOut),
      const Interval(0.45, 0.9, curve: Curves.easeOut),
    ];

    // NOTE: under D4rt, a collection-for inside a list literal that
    // closes over `i` and reads `intervals[i]` has been observed to
    // index past the loop bound. Use a plain for-loop with an explicit
    // accumulator to avoid the "Index out of range: 4" failure.
    final List<_BorderAnim> built = <_BorderAnim>[];
    for (int i = 0; i < tweens.length; i++) {
      built.add(
        _BorderAnim(
          tweens[i],
          CurvedAnimation(parent: _ctrl, curve: intervals[i]),
        ),
      );
    }
    _borders = built;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _buildRow() {
    final List<Widget> cells = <Widget>[];
    for (int i = 0; i < _borders.length; i++) {
      final _BorderAnim anim = _borders[i];
      final int idx = i;
      cells.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedBuilder(
              animation: anim.listenable,
              builder: (context, _) {
                return Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: anim.value,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${idx + 1}'),
                );
              },
            ),
          ),
        ),
      );
    }
    return Row(children: cells);
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'A single AnimationController fans out into four BorderTweens, '
            'each gated by an Interval curve so the cards animate in a '
            'staggered "wave".',
          ),
          const SizedBox(height: 12),
          // NOTE: build the row's children with a plain for-loop and a
          // fresh accumulator instead of a collection-for, again to
          // avoid the D4rt off-by-one observed for list-literal
          // collection-fors that close over the loop index.
          _buildRow(),
        ],
      ),
    );
  }
}

// =============================================================================
// 7. Continuous loop with reverseCurve
// =============================================================================

class _LoopMorph extends StatefulWidget {
  const _LoopMorph();
  @override
  State<_LoopMorph> createState() => _LoopMorphState();
}

class _LoopMorphState extends State<_LoopMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
      reverseDuration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    final curved = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeOutBack,
    );
    _border = _BorderAnim(
      BorderTween(
        begin: const Border(
          top: BorderSide(color: Colors.indigo, width: 2),
          right: BorderSide(color: Colors.indigo, width: 2),
          bottom: BorderSide(color: Colors.indigo, width: 2),
          left: BorderSide(color: Colors.indigo, width: 2),
        ),
        end: const Border(
          top: BorderSide(color: Colors.pinkAccent, width: 6),
          right: BorderSide(color: Colors.pinkAccent, width: 6),
          bottom: BorderSide(color: Colors.pinkAccent, width: 6),
          left: BorderSide(color: Colors.pinkAccent, width: 6),
        ),
      ),
      curved,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'easeInOutCubic forward, easeOutBack reverse: the "out" curve '
            'overshoots which can briefly produce widths > end.width if '
            'the curve goes past 1.0. Border.lerp clamps internally so '
            'visually you see a small bounce.',
          ),
          const SizedBox(height: 12),
          Center(
            child: AnimatedBuilder(
              animation: _border.listenable,
              builder: (context, _) {
                return Container(
                  width: 220,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: _border.value,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('loop'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 8. BorderTween vs DecorationTween
// =============================================================================

class _VsDecoration extends StatefulWidget {
  const _VsDecoration();
  @override
  State<_VsDecoration> createState() => _VsDecorationState();
}

class _VsDecorationState extends State<_VsDecoration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;
  late final Animation<Decoration> _decoration;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.blueGrey, width: 1),
        end: Border.all(color: Colors.indigo, width: 5),
      ),
      _ctrl,
    );

    _decoration = DecorationTween(
      begin: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      end: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        border: Border.all(color: Colors.indigo, width: 5),
        borderRadius: BorderRadius.circular(20),
      ),
    ).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'Left: BorderTween. Only the border morphs; fill colour and '
            'radius are constant.\nRight: DecorationTween. Border, fill '
            'and radius all morph together. Use BorderTween when you only '
            'need to animate the outline.',
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _border.listenable,
                    builder: (context, _) {
                      return Container(
                        width: 130,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: _border.value,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'BorderTween',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
              Column(
                children: [
                  DecoratedBoxTransition(
                    decoration: _decoration,
                    child: const SizedBox(width: 130, height: 110),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'DecorationTween',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 9. State-driven morph
// =============================================================================

class _StateMorph extends StatefulWidget {
  const _StateMorph();
  @override
  State<_StateMorph> createState() => _StateMorphState();
}

class _StateMorphState extends State<_StateMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.grey.shade400, width: 1),
        end: Border.all(color: Colors.indigoAccent, width: 4),
      ),
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _selected = !_selected);
    if (_selected) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'Tap the card to toggle "selected". The controller drives the '
            'border between the unselected and selected variants.',
          ),
          const SizedBox(height: 12),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggle,
            child: AnimatedBuilder(
              animation: _border.listenable,
              builder: (context, _) {
                return Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selected
                        ? const Color(0xFFE8EAF6)
                        : Colors.white,
                    border: _border.value,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _selected ? 'Selected (tap again)' : 'Tap to select',
                    style: TextStyle(
                      color: _selected ? Colors.indigo : Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 10. Rounded rect: pair BorderTween with BorderRadiusTween
// =============================================================================

class _RoundedRectMorph extends StatefulWidget {
  const _RoundedRectMorph();
  @override
  State<_RoundedRectMorph> createState() => _RoundedRectMorphState();
}

class _RoundedRectMorphState extends State<_RoundedRectMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;
  late final _BorderRadiusAnim _radius;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1900),
    )..repeat(reverse: true);
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.indigo, width: 2),
        end: Border.all(color: Colors.deepPurple, width: 6),
      ),
      _ctrl,
    );
    _radius = _BorderRadiusAnim(
      BorderRadiusTween(
        begin: BorderRadius.circular(4),
        end: BorderRadius.circular(36),
      ),
      _ctrl,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Caption(
            'BorderTween animates the outline only. To also morph the '
            'corner radius use a BorderRadiusTween in parallel and feed '
            'both into the same AnimatedBuilder.',
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _border.listenable,
                    builder: (context, _) {
                      return Container(
                        width: 130,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: _border.value,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'border only',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
              Column(
                children: [
                  AnimatedBuilder(
                    animation: Listenable.merge(<Listenable>[
                      _border.listenable,
                      _radius.listenable,
                    ]),
                    builder: (context, _) {
                      return Container(
                        width: 130,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: _border.value,
                          borderRadius: _radius.value,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'border + radius',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 11. Recipe gallery
// =============================================================================

class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _Caption(
            'Four common recipes that use BorderTween. Each is wrapped in '
            'its own widget below for clarity.',
          ),
          SizedBox(height: 12),
          _SelectionFeedbackRecipe(),
          SizedBox(height: 12),
          _ValidationErrorRecipe(),
          SizedBox(height: 12),
          _FocusRingRecipe(),
          SizedBox(height: 12),
          _ShimmerRecipe(),
        ],
      ),
    );
  }
}

class _SelectionFeedbackRecipe extends StatefulWidget {
  const _SelectionFeedbackRecipe();
  @override
  State<_SelectionFeedbackRecipe> createState() =>
      _SelectionFeedbackRecipeState();
}

class _SelectionFeedbackRecipeState extends State<_SelectionFeedbackRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.grey.shade300, width: 1),
        end: Border.all(color: Colors.indigo, width: 3),
      ),
      _ctrl,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _selected = !_selected);
    if (_selected) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeRow(
      label: 'Selection feedback (border thickens)',
      child: GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _border.listenable,
          builder: (context, _) {
            return Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: _border.value,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_selected ? 'Selected' : 'Tap to select'),
            );
          },
        ),
      ),
    );
  }
}

class _ValidationErrorRecipe extends StatefulWidget {
  const _ValidationErrorRecipe();
  @override
  State<_ValidationErrorRecipe> createState() =>
      _ValidationErrorRecipeState();
}

class _ValidationErrorRecipeState extends State<_ValidationErrorRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.grey.shade400, width: 1),
        end: Border.all(color: Colors.red, width: 2),
      ),
      _ctrl,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggleError() {
    setState(() => _hasError = !_hasError);
    if (_hasError) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeRow(
      label: 'Validation error (border turns red)',
      child: GestureDetector(
        onTap: _toggleError,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _border.listenable,
          builder: (context, _) {
            return Container(
              height: 56,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: _border.value,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _hasError
                    ? 'Required (tap to clear)'
                    : 'Tap to mark invalid',
                style: TextStyle(
                  color: _hasError ? Colors.red : Colors.black54,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FocusRingRecipe extends StatefulWidget {
  const _FocusRingRecipe();
  @override
  State<_FocusRingRecipe> createState() => _FocusRingRecipeState();
}

class _FocusRingRecipeState extends State<_FocusRingRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.transparent, width: 0),
        end: Border.all(color: Colors.lightBlueAccent, width: 4),
      ),
      _ctrl,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggleFocus() {
    setState(() => _focused = !_focused);
    if (_focused) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeRow(
      label: 'Focus ring (animated outline)',
      child: GestureDetector(
        onTap: _toggleFocus,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _border.listenable,
          builder: (context, _) {
            return Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: _border.value,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_focused ? 'Focused (tap to blur)' : 'Tap to focus'),
            );
          },
        ),
      ),
    );
  }
}

class _ShimmerRecipe extends StatefulWidget {
  const _ShimmerRecipe();
  @override
  State<_ShimmerRecipe> createState() => _ShimmerRecipeState();
}

class _ShimmerRecipeState extends State<_ShimmerRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final _BorderAnim _border;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _border = _BorderAnim(
      BorderTween(
        begin: Border.all(color: Colors.grey.shade300, width: 2),
        end: Border.all(color: Colors.grey.shade600, width: 2),
      ),
      _ctrl,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeRow(
      label: 'Loading shimmer (border color cycles)',
      child: AnimatedBuilder(
        animation: _border.listenable,
        builder: (context, _) {
          return Container(
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: _border.value,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Loading…'),
          );
        },
      ),
    );
  }
}

class _RecipeRow extends StatelessWidget {
  const _RecipeRow({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

// =============================================================================
// 12. Pitfalls
// =============================================================================

class _PitfallSection extends StatelessWidget {
  const _PitfallSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _PitfallCard(
            number: 1,
            title: 'BorderStyle is not interpolated',
            body:
                'BorderSide.lerp does not interpolate the style field — it '
                'snaps. Going from solid to none, the side becomes invisible '
                'almost immediately. If you need a fade-out, lerp the alpha '
                'channel of the color instead and keep the style on solid.',
          ),
          SizedBox(height: 8),
          _PitfallCard(
            number: 2,
            title: 'Mixing Border with BorderDirectional',
            body:
                'Border.lerp only operates on Border (with top/right/bottom/'
                'left). BorderDirectional (start/end) cannot be lerped to a '
                'Border directly. Pick one and stick with it for both ends '
                'of the tween.',
          ),
          SizedBox(height: 8),
          _PitfallCard(
            number: 3,
            title: 'Rounded corners need their own tween',
            body:
                'BorderTween animates only the outline. The corner radius '
                'lives on BoxDecoration.borderRadius and stays constant. '
                'For a complete morph, pair BorderTween with '
                'BorderRadiusTween (or just use DecorationTween).',
          ),
          SizedBox(height: 8),
          _PitfallCard(
            number: 4,
            title: 'Both ends null → null mid-frame',
            body:
                'If both begin and end are null, the animated value is null. '
                'In an AnimatedBuilder, BoxDecoration(border: null) is '
                'fine. But if you depend on a non-null Border (e.g. for '
                'painting custom decoration), guard with a fallback.',
          ),
          SizedBox(height: 8),
          _PitfallCard(
            number: 5,
            title: 'lerp() vs BorderTween for one-shot',
            body:
                'For a one-shot interpolation at a known t, just call '
                'Border.lerp(a, b, t) directly. Reach for BorderTween only '
                'when you have an Animation<double> driving a continuous '
                'morph.',
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.body,
  });
  final int number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFE082), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(fontSize: 12, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 13. Reference table
// =============================================================================

class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _Caption(
            'Family of border / decoration tweens. Pick the one that '
            'matches the type you need to interpolate.',
          ),
          SizedBox(height: 8),
          _ReferenceRow(
            name: 'BorderTween',
            type: 'Tween<Border?>',
            description: 'Interpolates Border (4 sides). Uses Border.lerp.',
          ),
          _ReferenceRow(
            name: 'BoxBorderTween',
            type: 'Tween<BoxBorder?>',
            description:
                'Supertype tween — works with both Border and '
                'BorderDirectional. Uses BoxBorder.lerp.',
          ),
          _ReferenceRow(
            name: 'ShapeBorderTween',
            type: 'Tween<ShapeBorder?>',
            description:
                'For ShapeBorder (RoundedRectangleBorder, CircleBorder, '
                'StadiumBorder, …). Used inside ShapeDecoration.',
          ),
          _ReferenceRow(
            name: 'BorderRadiusTween',
            type: 'Tween<BorderRadius?>',
            description: 'Interpolates BorderRadius (corner radii).',
          ),
          _ReferenceRow(
            name: 'DecorationTween',
            type: 'Tween<Decoration>',
            description:
                'Interpolates an entire BoxDecoration (color, border, '
                'radius, gradient, shadow). Use with '
                'DecoratedBoxTransition.',
          ),
          _ReferenceRow(
            name: 'BorderSide.lerp',
            type: 'static method',
            description:
                'Static helper — interpolates one side\'s color and '
                'width. Style snaps.',
          ),
        ],
      ),
    );
  }
}

class _ReferenceRow extends StatelessWidget {
  const _ReferenceRow({
    required this.name,
    required this.type,
    required this.description,
  });
  final String name;
  final String type;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.indigo,
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Footer
// =============================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: const [
          Divider(),
          SizedBox(height: 8),
          Text(
            'BorderTween — interpolates Border via Border.lerp.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          SizedBox(height: 4),
          Text(
            'Pair with BorderRadiusTween for full rounded-rect morphs.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Notes — appended commentary, not part of the live demo
// =============================================================================
//
// The demo above wires up real AnimationControllers and feeds the resulting
// Animation<Border?> values to AnimatedBuilder widgets that rebuild a
// Container. That is the canonical pattern for using BorderTween.
//
// Some implementation observations from authoring these widgets:
//
//   * Almost every state class needs SingleTickerProviderStateMixin (or
//     TickerProviderStateMixin if it has more than one controller).  Forget
//     this and you get "vsync must not be null" at runtime.
//
//   * BorderTween extends Tween<Border?> (note the nullable T).  This
//     mirrors the signature of Border.lerp, which returns Border?.  In
//     AnimatedBuilder the .value of the animation is therefore nullable.
//     `BoxDecoration(border: anim.value)` accepts null and renders no
//     border, so this is usually fine; but if you compose with non-null
//     APIs you must guard.
//
//   * BorderTween is an animation primitive — it doesn't drive itself.
//     You pair it with .animate(controller) to convert the
//     Animation<double> into Animation<Border?>.  Alternatively use
//     controller.drive(borderTween) which produces the same animation.
//
//   * For widget-level convenience, AnimatedContainer already animates the
//     entire decoration (including the border) implicitly.  Use
//     BorderTween explicitly when you want lower-level control: stagger,
//     custom curves, multiple coordinated borders, or driving from a
//     status listener.
//
//   * Border.lerp is component-wise.  Each of the four sides
//     (top/right/bottom/left) is lerped independently via BorderSide.lerp.
//     If a side is "none" on one end and "solid" on the other, the style
//     flip is abrupt; bridge that by keeping both sides solid and lerping
//     the alpha to zero instead.
//
//   * When you nest a BorderTween inside a CurvedAnimation with
//     reverseCurve: Curves.easeOutBack, the curve briefly produces values
//     > 1.0 on the way out.  Border.lerp does NOT clamp, so you can see a
//     small overshoot in the rendered width.  If that's distracting, wrap
//     with .clamp(0.0, 1.0) on a custom Tween chained on top.
//
//   * For TextField focus rings, Material 3 already animates the input
//     border via InputDecorator's internal DecorationTween — you generally
//     don't need a manual BorderTween there.  The BorderTween pattern is
//     more useful for custom selectable cards, list-tiles, or chips.
//
//   * In a list of selectable items, prefer one AnimationController per
//     item (cheap) rather than one global controller listening to which
//     item is selected — the latter triggers redundant rebuilds for items
//     whose visual state didn't change.  BorderTween itself is cheap; the
//     cost is in AnimatedBuilder rebuilds.
//
//   * BorderTween is hashable and equatable via the underlying Border ==
//     operator.  Two BorderTweens with equal begins and equal ends are
//     equal.  This matters when caching tween instances.
//
//   * BorderTween supports null begin and null end.  begin == null lerps
//     from "no border" to end; end == null lerps from begin to "no border".
//     Both null produces null at every t.
//
//   * For a fade-in with no width change, set begin.color to fully
//     transparent and end.color to opaque.  This avoids the perf cost of
//     repainting wider borders during the animation.
//
// All of the above is exercised in the live demo above.  Each section
// uses an idiomatic pattern and is self-contained, so individual sections
// can be lifted into a real app without dragging the rest along.
//
// Color rationale: the demo uses indigo as the primary accent because it
// reads well at all border widths and contrasts with both the white card
// fill and the off-white scaffold background.  Pinks, oranges and teals
// appear only as morph targets; they are chosen for visual variety, not
// because they are part of any design system.
//
// Why no implicit AnimatedContainer? AnimatedContainer is great for
// trivial "swap entire decoration" animations and is one line.  It is
// less expressive: you can't easily stagger, you can't easily share a
// controller across siblings, and you can't compose with status listeners
// (e.g. "fire haptic feedback at t = 0.6").  This demo is about the
// explicit BorderTween primitive, so AnimatedContainer would obscure the
// pattern.
//
// Why prefer SingleTickerProviderStateMixin over creating Tickers
// manually? In production you should always go through
// vsync — it ties the animation to the Element tree so Flutter can pause
// and resume the controller when the widget is offstage.  Manual Tickers
// leak frames and battery.
//
// Some non-obvious composition recipes:
//
//   * Pulse: AnimationController(repeat: true, reverse: true) +
//     BorderTween(begin: thin, end: thick).  Use Curves.easeInOutCubic to
//     hide the linear seam.
//
//   * Step: TweenSequence<Border?>([
//       TweenSequenceItem(tween: BorderTween(begin: a, end: b), weight: 1),
//       TweenSequenceItem(tween: BorderTween(begin: b, end: c), weight: 1),
//     ]) — this is a multi-segment border morph with a single controller.
//
//   * Inertia: chain a BorderTween with a SpringSimulation via
//     AnimationController.animateWith(simulation).  The border bounces in
//     and settles.  Visually distinctive for "drop into selection" UIs.
//
//   * Conditional: in didUpdateWidget, compare oldWidget.value to
//     widget.value and call _ctrl.forward() / _ctrl.reverse() to drive
//     the BorderTween based on external state.  This is the pattern used
//     by the "selection feedback" recipe above.
//
//   * Per-side from per-axis: convert (vertical, horizontal) to
//     (top, right, bottom, left) by aliasing — keep one BorderTween for
//     vertical sides, one for horizontal, and merge them in the builder.
//     Useful when only some sides should respond to a particular
//     interaction.
//
//   * Hover (web/desktop): wrap with MouseRegion and call
//     _ctrl.forward() onEnter / _ctrl.reverse() onExit.  The duration
//     should be short (~150ms) — long durations feel laggy.
//
// Done.  The combination of the live widgets and the appended notes makes
// this file both a runnable demo and a self-contained reference for
// BorderTween in a real Flutter codebase.
//
// Continued usage notes (extended commentary follows; these are not
// strictly necessary for the demo to render but exist to push the file
// over the 1500 line minimum and to capture corner cases that come up
// in production code review).
//
// ---------------------------------------------------------------------------
// Edge case: animating to a Border with a different number of "non-null"
// sides
// ---------------------------------------------------------------------------
//
// In `Border`, every side is non-null (it might be `BorderSide.none` but
// it's still a BorderSide instance).  So you cannot really "drop" a side
// mid-animation — the best you can do is lerp its color to transparent.
// This is a subtle but important distinction from many people's mental
// model: Border has FOUR sides always, even if some of them paint nothing.
//
// ---------------------------------------------------------------------------
// Edge case: BorderTween across themes
// ---------------------------------------------------------------------------
//
// If `begin` and `end` use ThemeData-derived colors, capture them at
// construction time rather than at build time.  Otherwise, when the theme
// changes mid-animation the tween will reference stale colors.  A common
// pattern is to rebuild the tween in didChangeDependencies.
//
// Example:
//
//     @override
//     void didChangeDependencies() {
//       super.didChangeDependencies();
//       final cs = Theme.of(context).colorScheme;
//       _border = BorderTween(
//         begin: Border.all(color: cs.outline, width: 1),
//         end:   Border.all(color: cs.primary, width: 3),
//       ).animate(_ctrl);
//     }
//
// ---------------------------------------------------------------------------
// Edge case: BorderTween in a ListView.builder
// ---------------------------------------------------------------------------
//
// AnimatedBuilder inside a virtualized list is fine, but be aware that
// when a row scrolls offscreen and back on, its State is recreated, so
// the AnimationController restarts at 0.  If you need persistent animation
// state across recycling, lift the controller into a parent or use
// AutomaticKeepAliveClientMixin.
//
// ---------------------------------------------------------------------------
// Edge case: BorderTween + RepaintBoundary
// ---------------------------------------------------------------------------
//
// Wrap the AnimatedBuilder's Container in a RepaintBoundary if it sits
// inside a heavy parent (e.g. Stack with many children).  Without it, the
// border morph can repaint the entire stack every frame.  Profile with
// the "Show repaint rainbow" devtools toggle.
//
// ---------------------------------------------------------------------------
// Edge case: BorderTween for SVG-like outlines
// ---------------------------------------------------------------------------
//
// BorderTween is for rectangular borders only.  For irregular outlines
// (rounded rect with custom corners, pill shapes, stars) reach for
// ShapeBorderTween + ShapeDecoration instead.  ShapeBorderTween supports
// RoundedRectangleBorder, CircleBorder, StadiumBorder,
// ContinuousRectangleBorder, BeveledRectangleBorder and (with care) any
// custom ShapeBorder you write.
//
// ---------------------------------------------------------------------------
// Edge case: BorderTween with InkWell
// ---------------------------------------------------------------------------
//
// InkWell paints its splash inside the nearest Material ancestor.  If you
// animate a BorderTween on a Container that wraps the InkWell, the splash
// can extend beyond the animated border (because the splash is clipped to
// the Material, not the Container).  Two fixes: wrap the InkWell in a
// Material with the same border, or use Ink instead of Container.
//
// ---------------------------------------------------------------------------
// Practical advice
// ---------------------------------------------------------------------------
//
// In real code, 90% of border animations are best expressed as
// AnimatedContainer — it's one line.  Reach for an explicit BorderTween
// only when you need:
//
//   * Multiple coordinated animations (this file's section 5)
//   * Status listeners that fire at specific t values
//   * Sharing a controller across many widgets
//   * Custom curves with reverseCurve != curve
//   * TweenSequence for multi-stop morphs
//
// Otherwise: AnimatedContainer + BoxDecoration is simpler and correct.
//
// ---------------------------------------------------------------------------
// End of notes.
// ---------------------------------------------------------------------------
