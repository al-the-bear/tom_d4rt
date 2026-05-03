// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =====================================================================
// AlignTransition Deep Demo
// ---------------------------------------------------------------------
// AlignTransition is the explicit cousin of AnimatedAlign. Where
// AnimatedAlign performs an implicit setState->lerp->repaint dance,
// AlignTransition takes a raw Animation<AlignmentGeometry> and
// reactively rebuilds whenever that animation ticks. This separation of
// concerns means YOU own the AnimationController, the curve, the tween,
// the lifecycle (forward/reverse/repeat/stop) — and AlignTransition is
// only responsible for plugging the latest alignment value into a plain
// Align widget.
//
// Constructor signature (Flutter SDK):
//   AlignTransition({
//     Key? key,
//     required Animation<AlignmentGeometry> alignment,
//     required Widget child,
//     double? widthFactor,
//     double? heightFactor,
//   });
//
// Internally it is a thin AnimatedWidget that calls Align(
//   alignment: alignment.value, widthFactor: widthFactor,
//   heightFactor: heightFactor, child: child).
//
// This demo exercises real AnimationControllers, real Tweens (both the
// generic Tween<AlignmentGeometry> and the specialised
// AlignmentGeometryTween / AlignmentTween / AlignmentDirectionalTween),
// CurvedAnimation wrappers, TweenSequence keyframes, and several
// realistic UI patterns (orbit, drop, reveal, multi-child coordination,
// recipe gallery). Every section below is hand-authored with its own
// state class and lifecycle.
// =====================================================================

dynamic build(BuildContext context) {
  print('=== AlignTransition Deep Demo ===');
  print('Sections: 12 (intro, orbit, drop, directional, chained, vs');
  print('AnimatedAlign, curve gallery, reveal, coordinated, math,');
  print('recipes, reference table).');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AlignTransition Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF6750A4),
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F3FA),
      appBar: AppBar(
        title: const Text('AlignTransition — Deep Demo'),
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SectionHeader(
                index: 1,
                title: 'Intro — what AlignTransition does',
                subtitle:
                    'Animation<AlignmentGeometry> + child = an Align that '
                    'moves smoothly within its parent.',
              ),
              const _IntroSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 2,
                title: 'Continuous orbit',
                subtitle:
                    'Repeating AnimationController + TweenSequence drives '
                    'a planet around the four corners forever.',
              ),
              const _OrbitDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 3,
                title: 'Drop & settle',
                subtitle:
                    'Curves.bounceOut over an AlignmentTween from '
                    'topCenter to bottomCenter — tap to replay.',
              ),
              const _DropSettleDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 4,
                title: 'Directional alignments (RTL aware)',
                subtitle:
                    'AlignmentDirectional.topStart/topEnd auto-mirror '
                    'when Directionality flips to RTL.',
              ),
              const _DirectionalDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 5,
                title: 'Chained transitions (TweenSequence)',
                subtitle:
                    'Five keyframes welded together with weights — '
                    'one controller, one continuous path.',
              ),
              const _ChainDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 6,
                title: 'AlignTransition vs AnimatedAlign',
                subtitle:
                    'Same visual goal, two philosophies: explicit '
                    'controller vs implicit setState.',
              ),
              const _VsAnimatedAlignDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 7,
                title: 'Custom curve gallery',
                subtitle:
                    'Six AlignTransitions, six curves, ONE shared '
                    'controller — see how curves reshape time.',
              ),
              const _CurveGalleryDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 8,
                title: 'Hero-like reveal (off-canvas to center)',
                subtitle:
                    'Alignment(-2.5, 0) lives outside parent bounds; '
                    'OverflowBox lets us animate in from offscreen.',
              ),
              const _RevealDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 9,
                title: 'Coordinated multi-child',
                subtitle:
                    'Four AlignTransitions, one AnimationController. '
                    'Forward gathers, reverse scatters.',
              ),
              const _CoordinatedDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 10,
                title: 'AlignmentGeometry math (lerp slider)',
                subtitle:
                    'AlignmentGeometry.lerp(a, b, t) with a manual t '
                    'slider — see the formula in action.',
              ),
              const _MathDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 11,
                title: 'Recipe gallery (real UI patterns)',
                subtitle:
                    'Menu reveal, snackbar drop, toast slide, loader '
                    'pulse — all powered by AlignTransition.',
              ),
              const _RecipeGallery(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 12,
                title: 'Reference table',
                subtitle:
                    'Properties, comparisons to AnimatedAlign and '
                    'PositionedTransition, and gotchas.',
              ),
              const _ReferenceTable(),
              const SizedBox(height: 32),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'End of AlignTransition deep demo.',
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF6750A4),
                    ),
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

// =====================================================================
// Shared UI helpers
// =====================================================================

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
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 12, top: 2),
            decoration: const BoxDecoration(
              color: Color(0xFF6750A4),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D1B20),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF49454F),
                    height: 1.35,
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

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          height: 1.4,
          color: Color(0xFF49454F),
        ),
      ),
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
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B2E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFE6E1F5),
          height: 1.45,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label, {this.color = const Color(0xFF6750A4)});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// =====================================================================
// Section 1 — Intro
// =====================================================================

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'AlignTransition is an AnimatedWidget — it listens to an '
            'Animation<AlignmentGeometry> and rebuilds an Align widget '
            'on every tick. The animation drives the alignment, the '
            'alignment drives the position of the child in its parent.',
            style: TextStyle(fontSize: 13.5, height: 1.45),
          ),
          const SizedBox(height: 12),
          Row(
            children: const <Widget>[
              _Pill('explicit controller'),
              SizedBox(width: 8),
              _Pill('AlignmentGeometry', color: Color(0xFF7D5260)),
              SizedBox(width: 8),
              _Pill('AnimatedWidget', color: Color(0xFF386641)),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'The alignment grid (a 3x3 sample of the continuous space):',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF49454F),
            ),
          ),
          const SizedBox(height: 8),
          const _AlignmentGrid(),
          const _CodeBlock(
            'AlignTransition(\n'
            '  alignment: animation, // Animation<AlignmentGeometry>\n'
            '  widthFactor: null,    // optional\n'
            '  heightFactor: null,   // optional\n'
            '  child: child,\n'
            ');',
          ),
          const _Caption(
            'Compared to AnimatedAlign which uses ImplicitlyAnimatedWidget '
            'and a Curve+Duration pair, AlignTransition is a thinner shim '
            'that delegates EVERYTHING about timing to the caller.',
          ),
        ],
      ),
    );
  }
}

class _AlignmentGrid extends StatelessWidget {
  const _AlignmentGrid();

  @override
  Widget build(BuildContext context) {
    final List<List<Alignment>> grid = <List<Alignment>>[
      <Alignment>[
        Alignment.topLeft,
        Alignment.topCenter,
        Alignment.topRight,
      ],
      <Alignment>[
        Alignment.centerLeft,
        Alignment.center,
        Alignment.centerRight,
      ],
      <Alignment>[
        Alignment.bottomLeft,
        Alignment.bottomCenter,
        Alignment.bottomRight,
      ],
    ];

    final List<List<String>> labels = <List<String>>[
      <String>['(-1,-1)', '(0,-1)', '(1,-1)'],
      <String>['(-1, 0)', '(0, 0)', '(1, 0)'],
      <String>['(-1, 1)', '(0, 1)', '(1, 1)'],
    ];

    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFFF1ECF7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7CDEC)),
      ),
      child: Stack(
        children: <Widget>[
          for (int row = 0; row < 3; row++)
            for (int col = 0; col < 3; col++)
              Align(
                alignment: grid[row][col],
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6750A4),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        labels[row][col],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF6750A4),
                          fontFamily: 'monospace',
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

// =====================================================================
// Section 2 — Continuous orbit
// =====================================================================

class _OrbitDemo extends StatefulWidget {
  const _OrbitDemo();

  @override
  State<_OrbitDemo> createState() => _OrbitDemoState();
}

class _OrbitDemoState extends State<_OrbitDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Four corners welded into one continuous loop. Each segment gets
    // an equal weight so the planet spends the same amount of time
    // travelling each side of the square.
    _alignment = TweenSequence<Alignment>(
      <TweenSequenceItem<Alignment>>[
        TweenSequenceItem<Alignment>(
          tween: AlignmentTween(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: AlignmentTween(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: AlignmentTween(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: AlignmentTween(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 260,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: <Color>[Color(0xFF1B0A3F), Color(0xFF050213)],
                center: Alignment.center,
                radius: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: <Widget>[
                ..._buildStars(),
                AlignTransition(
                  alignment: _alignment,
                  // Inline AnimatedBuilder instead of an AnimatedWidget
                  // subclass: d4rt's bridged AlignTransition constructor
                  // does not coerce InterpretedInstance(_Planet) back to a
                  // native Widget, so we use the closure-based builder API
                  // which the bridge handles cleanly.
                  child: Container(
                    width: 56,
                    height: 56,
                    margin: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: SweepGradient(
                        colors: <Color>[
                          Color(0xFFFFB000),
                          Color(0xFFFF6E40),
                          Color(0xFF6750A4),
                          Color(0xFF40C4FF),
                          Color(0xFFFFB000),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x80FFB000),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              // d4rt's bridge for the _AnimatedEvaluation that backs
              // `Tween.animate(...)` exposes the wrapped instance as
              // `AnimationWithParentMixin`, which doesn't carry the
              // `value` getter through the bridge. Use a static caption
              // instead of an AnimatedBuilder that reads `.value`.
              const Expanded(
                child: _Caption(
                  'live alignment.value = (animated)',
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  if (_controller.isAnimating) {
                    _controller.stop();
                  } else {
                    _controller.repeat();
                  }
                  setState(() {});
                },
                icon: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? _) {
                    return Icon(
                      _controller.isAnimating
                          ? Icons.pause
                          : Icons.play_arrow,
                    );
                  },
                ),
                label: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? _) {
                    return Text(
                      _controller.isAnimating ? 'Pause' : 'Resume',
                    );
                  },
                ),
              ),
            ],
          ),
          const _CodeBlock(
            'final controller = AnimationController(\n'
            '  vsync: this,\n'
            '  duration: const Duration(seconds: 6),\n'
            ')..repeat();\n'
            'final alignment = TweenSequence<AlignmentGeometry>([\n'
            '  TweenSequenceItem(\n'
            '    tween: AlignmentGeometryTween(\n'
            '      begin: Alignment.topLeft,\n'
            '      end: Alignment.topRight,\n'
            '    ),\n'
            '    weight: 1,\n'
            '  ),\n'
            '  // ... three more segments forming a square\n'
            ']).animate(controller);\n'
            'AlignTransition(alignment: alignment, child: planet);',
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStars() {
    const List<Offset> seeds = <Offset>[
      Offset(0.12, 0.18),
      Offset(0.34, 0.42),
      Offset(0.71, 0.21),
      Offset(0.85, 0.6),
      Offset(0.22, 0.78),
      Offset(0.58, 0.85),
      Offset(0.46, 0.12),
      Offset(0.93, 0.31),
      Offset(0.05, 0.55),
      Offset(0.66, 0.68),
    ];
    return <Widget>[
      for (final Offset s in seeds)
        Align(
          alignment: Alignment(s.dx * 2 - 1, s.dy * 2 - 1),
          child: Container(
            width: 2 + (s.dx * 3),
            height: 2 + (s.dx * 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5 + s.dy * 0.4),
              shape: BoxShape.circle,
            ),
          ),
        ),
    ];
  }
}

// =====================================================================
// Section 3 — Drop & settle
// =====================================================================

class _DropSettleDemo extends StatefulWidget {
  const _DropSettleDemo();

  @override
  State<_DropSettleDemo> createState() => _DropSettleDemoState();
}

class _DropSettleDemoState extends State<_DropSettleDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;
  int _replays = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _alignment = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replay() {
    setState(() => _replays++);
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFB39DDB)),
            ),
            child: AlignTransition(
              alignment: _alignment,
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6750A4),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x806750A4),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.water_drop,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _replay,
                icon: const Icon(Icons.replay),
                label: const Text('Replay drop'),
              ),
              const SizedBox(width: 12),
              Text(
                'Replays: $_replays',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF49454F),
                ),
              ),
            ],
          ),
          const _Caption(
            'Curves.bounceOut applied via CurvedAnimation. The drop hits '
            'the floor and bounces twice before settling. Try changing '
            'to Curves.bounceInOut or Curves.elasticOut to feel the '
            'difference.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 4 — Directional alignments
// =====================================================================

class _DirectionalDemo extends StatefulWidget {
  const _DirectionalDemo();

  @override
  State<_DirectionalDemo> createState() => _DirectionalDemoState();
}

class _DirectionalDemoState extends State<_DirectionalDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;
  TextDirection _direction = TextDirection.ltr;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _alignment = _AlignmentGeometryTween(
      begin: AlignmentDirectional.topStart,
      end: AlignmentDirectional.bottomEnd,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                'Direction:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('LTR'),
                selected: _direction == TextDirection.ltr,
                onSelected: (bool _) {
                  setState(() => _direction = TextDirection.ltr);
                },
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('RTL'),
                selected: _direction == TextDirection.rtl,
                onSelected: (bool _) {
                  setState(() => _direction = TextDirection.rtl);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Directionality(
            textDirection: _direction,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFCC80)),
              ),
              child: Stack(
                children: <Widget>[
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: _CornerLabel('start ↘'),
                    ),
                  ),
                  const Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: _CornerLabel('end ↖'),
                    ),
                  ),
                  AlignTransition(
                    alignment: _alignment,
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFB8C00),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.translate,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _Caption(
            'AlignmentDirectional resolves to a regular Alignment using '
            'the ambient Directionality. Toggle LTR/RTL above and watch '
            'the orange ball mirror its travel — no code change required.',
          ),
        ],
      ),
    );
  }
}

class _CornerLabel extends StatelessWidget {
  const _CornerLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFB8C00).withOpacity(0.18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFFB35900),
        ),
      ),
    );
  }
}

// =====================================================================
// Section 5 — Chained transitions
// =====================================================================

class _ChainDemo extends StatefulWidget {
  const _ChainDemo();

  @override
  State<_ChainDemo> createState() => _ChainDemoState();
}

class _ChainDemoState extends State<_ChainDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;

  static const List<AlignmentGeometry> _keyframes = <AlignmentGeometry>[
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.center,
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.center,
  ];

  static const List<double> _weights = <double>[1, 1.4, 0.8, 1.2, 1, 0.6];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    final List<TweenSequenceItem<AlignmentGeometry>> items =
        <TweenSequenceItem<AlignmentGeometry>>[];
    for (int i = 0; i < _keyframes.length - 1; i++) {
      items.add(
        TweenSequenceItem<AlignmentGeometry>(
          tween: _AlignmentGeometryTween(
            begin: _keyframes[i],
            end: _keyframes[i + 1],
          ).chain(CurveTween(curve: Curves.easeInOutCubic)),
          weight: _weights[i],
        ),
      );
    }

    _alignment = TweenSequence<AlignmentGeometry>(items).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 240,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF80DEEA)),
            ),
            child: Stack(
              children: <Widget>[
                ..._keyframes.asMap().entries.map(
                      (MapEntry<int, AlignmentGeometry> e) => Align(
                        alignment: e.value,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00838F).withOpacity(0.4),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF00838F),
                                width: 1.4,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${e.key}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF00838F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                AlignTransition(
                  alignment: _alignment,
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF00838F),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x6000838F),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.route,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (int i = 0; i < _keyframes.length; i++)
                _Pill(
                  '#$i ${_keyframes[i]}',
                  color: const Color(0xFF00838F),
                ),
            ],
          ),
          const _Caption(
            'Six keyframes, five segments. Each segment is its own '
            'AlignmentGeometryTween chained with a CurveTween. The '
            'weights skew how much wallclock time each leg gets — leg #1 '
            '(weight 1.4) is the longest, leg #5 (weight 0.6) is the '
            'shortest.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 6 — AlignTransition vs AnimatedAlign
// =====================================================================

class _VsAnimatedAlignDemo extends StatefulWidget {
  const _VsAnimatedAlignDemo();

  @override
  State<_VsAnimatedAlignDemo> createState() => _VsAnimatedAlignDemoState();
}

class _VsAnimatedAlignDemoState extends State<_VsAnimatedAlignDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<AlignmentGeometry> _alignment;

  Alignment _explicitTarget = Alignment.topLeft;
  Alignment _implicitTarget = Alignment.topLeft;

  static const List<Alignment> _cycle = <Alignment>[
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.bottomLeft,
    Alignment.center,
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _alignment = AlignmentTween(
      begin: _explicitTarget,
      end: _explicitTarget,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    setState(() {
      _index = (_index + 1) % _cycle.length;
      final Alignment newTarget = _cycle[_index];

      // Explicit side: rebuild the tween from current value to new
      // target, then forward(from: 0).
      _alignment = AlignmentTween(
        begin: _explicitTarget,
        end: newTarget,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _explicitTarget = newTarget;
      _controller.forward(from: 0);

      // Implicit side: just change state and AnimatedAlign handles it.
      _implicitTarget = newTarget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _LabeledStage(
                  title: 'AlignTransition',
                  subtitle: 'explicit',
                  color: const Color(0xFF6750A4),
                  child: AlignTransition(
                    alignment: _alignment,
                    child: const _MarkerBox(
                      label: 'explicit',
                      color: Color(0xFF6750A4),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LabeledStage(
                  title: 'AnimatedAlign',
                  subtitle: 'implicit',
                  color: const Color(0xFF386641),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    alignment: _implicitTarget,
                    child: const _MarkerBox(
                      label: 'implicit',
                      color: Color(0xFF386641),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _next,
                icon: const Icon(Icons.skip_next),
                label: const Text('Next alignment'),
              ),
              const SizedBox(width: 12),
              Text(
                'target: ${_cycle[_index]}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const _Caption(
            'Both squares end up in the same place after 700 ms. The '
            'difference is the path: AlignTransition gives YOU the '
            'controller (forward, reverse, pause, scrub), while '
            'AnimatedAlign quietly fires-and-forgets a controller per '
            'state change. Use AlignTransition when you need to '
            'orchestrate (chain other animations, sync to scroll, etc.).',
          ),
        ],
      ),
    );
  }
}

class _LabeledStage extends StatelessWidget {
  const _LabeledStage({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF49454F),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _MarkerBox extends StatelessWidget {
  const _MarkerBox({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.45),
            blurRadius: 8,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 9,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =====================================================================
// Section 7 — Custom curve gallery
// =====================================================================

class _CurveGalleryDemo extends StatefulWidget {
  const _CurveGalleryDemo();

  @override
  State<_CurveGalleryDemo> createState() => _CurveGalleryDemoState();
}

class _CurveGalleryDemoState extends State<_CurveGalleryDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const List<_CurveSpec> _specs = <_CurveSpec>[
    _CurveSpec('linear', Curves.linear, Color(0xFF1976D2)),
    _CurveSpec('easeIn', Curves.easeIn, Color(0xFF388E3C)),
    _CurveSpec('easeOut', Curves.easeOut, Color(0xFFF57C00)),
    _CurveSpec('bounceOut', Curves.bounceOut, Color(0xFFD81B60)),
    _CurveSpec('elasticIn', Curves.elasticIn, Color(0xFF7B1FA2)),
    _CurveSpec('decelerate', Curves.decelerate, Color(0xFF00838F)),
  ];

  late final List<Animation<AlignmentGeometry>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _animations = _specs
        .map(
          (_CurveSpec s) => AlignmentTween(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).animate(
            CurvedAnimation(parent: _controller, curve: s.curve),
          ),
        )
        .toList();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replay() {
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < _specs.length; i++) ...<Widget>[
            _CurveRow(
              spec: _specs[i],
              animation: _animations[i],
            ),
            if (i != _specs.length - 1) const SizedBox(height: 8),
          ],
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _replay,
                icon: const Icon(Icons.replay),
                label: const Text('Replay all'),
              ),
              const SizedBox(width: 10),
              // d4rt's bridge for AnimationController routes value reads
              // through AnimationWithParentMixin which doesn't expose
              // `value`. Fall back to a static label.
              const Text(
                't = (animated)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const _Caption(
            'All six rows share ONE AnimationController. The curve is '
            'applied per-row through CurvedAnimation, so each row '
            'reshapes the same t∈[0,1] differently. Pay attention to '
            'elasticIn — it deliberately overshoots backwards before '
            'launching forward.',
          ),
        ],
      ),
    );
  }
}

class _CurveSpec {
  const _CurveSpec(this.label, this.curve, this.color);

  final String label;
  final Curve curve;
  final Color color;
}

class _CurveRow extends StatelessWidget {
  const _CurveRow({required this.spec, required this.animation});

  final _CurveSpec spec;
  final Animation<AlignmentGeometry> animation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 84,
          child: Text(
            spec.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: spec.color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              color: spec.color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: spec.color.withOpacity(0.3)),
            ),
            child: AlignTransition(
              alignment: animation,
              child: Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: spec.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// Section 8 — Hero-like reveal
// =====================================================================

class _RevealDemo extends StatefulWidget {
  const _RevealDemo();

  @override
  State<_RevealDemo> createState() => _RevealDemoState();
}

class _RevealDemoState extends State<_RevealDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _alignment = AlignmentTween(
      begin: const Alignment(-2.5, 0.0),
      end: Alignment.center,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _revealed = !_revealed);
    if (_revealed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 220,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCE93D8)),
            ),
            child: OverflowBox(
              minWidth: 0,
              minHeight: 0,
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: AlignTransition(
                alignment: _alignment,
                child: Container(
                  width: 220,
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color(0xFF8E24AA),
                        Color(0xFF5E35B1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x668E24AA),
                        blurRadius: 20,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 36,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Reveal Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Slid in from x=-2.5',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _toggle,
                icon: Icon(_revealed ? Icons.arrow_back : Icons.arrow_forward),
                label: Text(_revealed ? 'Hide card' : 'Reveal card'),
              ),
            ],
          ),
          const _Caption(
            'Alignment(-2.5, 0) sits FAR outside the parent box. '
            'OverflowBox lets us paint outside our parent\'s width, so '
            'the card travels in from the left through the clipped '
            'window. easeOutBack gives a tiny overshoot for personality.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 9 — Coordinated multi-child
// =====================================================================

class _CoordinatedDemo extends StatefulWidget {
  const _CoordinatedDemo();

  @override
  State<_CoordinatedDemo> createState() => _CoordinatedDemoState();
}

class _CoordinatedDemoState extends State<_CoordinatedDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<AlignmentGeometry>> _alignments;

  static const List<_CornerSpec> _corners = <_CornerSpec>[
    _CornerSpec(Alignment.topLeft, Color(0xFFE53935), Icons.adjust),
    _CornerSpec(Alignment.topRight, Color(0xFF1E88E5), Icons.flag),
    _CornerSpec(Alignment.bottomLeft, Color(0xFF43A047), Icons.eco),
    _CornerSpec(Alignment.bottomRight, Color(0xFFFB8C00), Icons.bolt),
  ];

  bool _gathered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _alignments = _corners
        .map(
          (_CornerSpec c) => AlignmentTween(
            begin: c.start,
            end: Alignment.center,
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _gathered = !_gathered);
    if (_gathered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Stack(
              children: <Widget>[
                for (int i = 0; i < _corners.length; i++)
                  AlignTransition(
                    alignment: _alignments[i],
                    child: Container(
                      width: 56,
                      height: 56,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _corners[i].color,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: _corners[i].color.withOpacity(0.4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        _corners[i].icon,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _toggle,
                icon: Icon(_gathered ? Icons.call_split : Icons.center_focus_strong),
                label: Text(_gathered ? 'Scatter' : 'Gather'),
              ),
              const SizedBox(width: 10),
              // Static label — see comment in section 7 about
              // `_controller.value` and the d4rt bridge.
              const _Pill(
                'controller t=(animated)',
                color: Color(0xFF49454F),
              ),
            ],
          ),
          const _Caption(
            'One AnimationController, four AlignTransitions, four '
            'different start corners, ALL ending at Alignment.center. '
            'Reversing the controller scatters them back to where they '
            'came from — perfect for "select all" / "deselect" UI.',
          ),
        ],
      ),
    );
  }
}

class _CornerSpec {
  const _CornerSpec(this.start, this.color, this.icon);

  final Alignment start;
  final Color color;
  final IconData icon;
}

// =====================================================================
// Section 10 — AlignmentGeometry math (lerp slider)
// =====================================================================

class _MathDemo extends StatefulWidget {
  const _MathDemo();

  @override
  State<_MathDemo> createState() => _MathDemoState();
}

class _MathDemoState extends State<_MathDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _t = 0.0;

  static const Alignment _a = Alignment(-0.9, -0.6);
  static const Alignment _b = Alignment(0.85, 0.7);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );
    _controller.value = 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<AlignmentGeometry> _animFor(double t) {
    final AlignmentGeometry value =
        AlignmentGeometry.lerp(_a, _b, t) ?? _a;
    return AlwaysStoppedAnimation<AlignmentGeometry>(value);
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFA5D6A7)),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: _a,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0x3300C853),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'A',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF1B5E20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: _b,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0x3300C853),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'B',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF1B5E20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                AlignTransition(
                  alignment: _animFor(_t),
                  child: Container(
                    width: 38,
                    height: 38,
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x402E7D32),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.straighten,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              const Text(
                't = ',
                style: TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
              SizedBox(
                width: 56,
                child: Text(
                  _t.toStringAsFixed(2),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
              Expanded(
                child: Slider(
                  value: _t,
                  min: 0.0,
                  max: 1.0,
                  activeColor: const Color(0xFF2E7D32),
                  onChanged: (double v) => setState(() => _t = v),
                ),
              ),
            ],
          ),
          const _CodeBlock(
            'AlignmentGeometry.lerp(a, b, t)\n'
            '  // For two Alignment values:\n'
            '  // x = a.x + (b.x - a.x) * t\n'
            '  // y = a.y + (b.y - a.y) * t\n'
            '\n'
            '  // For mixed Alignment + AlignmentDirectional:\n'
            '  // returns _MixedAlignment which resolves later\n'
            '  // using Directionality.\n',
          ),
          _Caption(
            'A=$_a, B=$_b. The green dot is rendered by an '
            'AlignTransition wrapped around an AlwaysStoppedAnimation — '
            't is driven by you, not a controller. AlignTransition does '
            'not care; it just rebuilds when its animation notifies.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 11 — Recipe gallery
// =====================================================================

class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _MenuRevealRecipe(),
        SizedBox(height: 12),
        _SnackbarDropRecipe(),
        SizedBox(height: 12),
        _ToastSlideRecipe(),
        SizedBox(height: 12),
        _LoaderPulseRecipe(),
      ],
    );
  }
}

class _RecipeFrame extends StatelessWidget {
  const _RecipeFrame({
    required this.title,
    required this.description,
    required this.child,
    this.actions = const <Widget>[],
    this.accent = const Color(0xFF6750A4),
  });

  final String title;
  final String description;
  final Widget child;
  final List<Widget> actions;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 22,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF49454F),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          child,
          if (actions.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10),
            Row(children: actions),
          ],
        ],
      ),
    );
  }
}

// ---- Recipe: menu reveal ----

class _MenuRevealRecipe extends StatefulWidget {
  const _MenuRevealRecipe();

  @override
  State<_MenuRevealRecipe> createState() => _MenuRevealRecipeState();
}

class _MenuRevealRecipeState extends State<_MenuRevealRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _alignment = AlignmentTween(
      begin: const Alignment(-1.4, -1.0),
      end: Alignment.topLeft,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _open = !_open);
    _open ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeFrame(
      title: 'Menu reveal',
      description:
          'A side menu slides in from the upper-left when the user taps '
          'the burger. Off-canvas start position via Alignment(-1.4, -1).',
      accent: const Color(0xFF1976D2),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: _toggle,
          icon: Icon(_open ? Icons.menu_open : Icons.menu),
          label: Text(_open ? 'Close menu' : 'Open menu'),
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 180,
          child: Stack(
            children: <Widget>[
              Container(color: const Color(0xFFE3F2FD)),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Page content',
                  style: TextStyle(
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AlignTransition(
                alignment: _alignment,
                child: Container(
                  width: 130,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1976D2),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      _MenuItem(label: 'Home', icon: Icons.home),
                      _MenuItem(label: 'Profile', icon: Icons.person),
                      _MenuItem(label: 'Settings', icon: Icons.settings),
                    ],
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

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ---- Recipe: snackbar drop ----

class _SnackbarDropRecipe extends StatefulWidget {
  const _SnackbarDropRecipe();

  @override
  State<_SnackbarDropRecipe> createState() => _SnackbarDropRecipeState();
}

class _SnackbarDropRecipeState extends State<_SnackbarDropRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _alignment = AlignmentTween(
      begin: const Alignment(0.0, -1.6),
      end: const Alignment(0.0, -0.85),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _show() async {
    await _controller.forward();
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (mounted) await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeFrame(
      title: 'Snackbar drop',
      description:
          'A toast/snackbar drops from above the parent box, lands just '
          'below the top edge with a spring (easeOutBack), waits, then '
          'leaves the way it came.',
      accent: const Color(0xFFD81B60),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: _show,
          icon: const Icon(Icons.notifications_active),
          label: const Text('Drop snackbar'),
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 160,
          child: Stack(
            children: <Widget>[
              Container(color: const Color(0xFFFCE4EC)),
              AlignTransition(
                alignment: _alignment,
                child: Container(
                  width: 240,
                  height: 44,
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD81B60),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x66D81B60),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Saved successfully',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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

// ---- Recipe: toast slide ----

class _ToastSlideRecipe extends StatefulWidget {
  const _ToastSlideRecipe();

  @override
  State<_ToastSlideRecipe> createState() => _ToastSlideRecipeState();
}

class _ToastSlideRecipeState extends State<_ToastSlideRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _alignment = AlignmentTween(
      begin: const Alignment(1.6, 0.7),
      end: const Alignment(0.85, 0.7),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _show() async {
    await _controller.forward();
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (mounted) await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeFrame(
      title: 'Toast slide (bottom-right)',
      description:
          'A desktop-style toast slides in from the right edge to the '
          'bottom-right corner, pauses, then slides back off. Common in '
          'admin dashboards.',
      accent: const Color(0xFF00838F),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: _show,
          icon: const Icon(Icons.east),
          label: const Text('Slide toast'),
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 160,
          child: Stack(
            children: <Widget>[
              Container(color: const Color(0xFFE0F7FA)),
              AlignTransition(
                alignment: _alignment,
                child: Container(
                  width: 200,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00838F),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x6600838F),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.cloud_done, color: Colors.white),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sync complete',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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

// ---- Recipe: loader pulse ----

class _LoaderPulseRecipe extends StatefulWidget {
  const _LoaderPulseRecipe();

  @override
  State<_LoaderPulseRecipe> createState() => _LoaderPulseRecipeState();
}

class _LoaderPulseRecipeState extends State<_LoaderPulseRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _alignment = AlignmentTween(
      begin: const Alignment(-0.6, 0.0),
      end: const Alignment(0.6, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeFrame(
      title: 'Loader pulse',
      description:
          'A horizontal "ping pong" loader. The dot oscillates between '
          'two alignments forever via repeat(reverse: true). Great for '
          'indeterminate progress.',
      accent: const Color(0xFF7B1FA2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 80,
          child: Stack(
            children: <Widget>[
              Container(color: const Color(0xFFF3E5F5)),
              AlignTransition(
                alignment: _alignment,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7B1FA2),
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0x807B1FA2),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
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

// =====================================================================
// Section 12 — Reference table
// =====================================================================

class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'AlignTransition properties',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _RefTable(
            rows: const <_RefRow>[
              _RefRow(
                'alignment',
                'Animation<AlignmentGeometry>',
                'Required. The animation whose value drives the Align '
                    'widget on every tick.',
              ),
              _RefRow(
                'child',
                'Widget',
                'Required. The widget being aligned. Repaints whenever '
                    'alignment.value changes.',
              ),
              _RefRow(
                'widthFactor',
                'double?',
                'Optional. If non-null, the parent will size to '
                    'child.width * widthFactor instead of expanding.',
              ),
              _RefRow(
                'heightFactor',
                'double?',
                'Optional. If non-null, the parent will size to '
                    'child.height * heightFactor instead of expanding.',
              ),
              _RefRow(
                'key',
                'Key?',
                'Inherited from Widget. Useful when AlignTransitions '
                    'appear in lists and need stable identity.',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'AlignTransition vs AnimatedAlign vs PositionedTransition',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _RefTable(
            rows: const <_RefRow>[
              _RefRow(
                'AlignTransition',
                'Explicit (caller owns controller + curve)',
                'Choose when you need fine control: chaining, scrubbing, '
                    'pausing, syncing to scroll, replaying with a '
                    'different curve, or sharing a controller across '
                    'many children.',
              ),
              _RefRow(
                'AnimatedAlign',
                'Implicit (rebuild + duration + curve)',
                'Choose for simple "change state, animate to it" cases. '
                    'Less code, less control. Internally creates a '
                    'fresh controller per change.',
              ),
              _RefRow(
                'PositionedTransition',
                'Explicit, RelativeRectTween',
                'Use inside a Stack when you need to animate left/top/'
                    'right/bottom (a RelativeRect), not an alignment. '
                    'Different parameter space — Rect-based, not '
                    '-1..1 normalized.',
              ),
              _RefRow(
                'SlideTransition',
                'Explicit, Animation<Offset>',
                'Animates a child by a Tween<Offset> as a TRANSLATION '
                    '(in fractions of its own size). Use for slide-in/'
                    'slide-out without changing parent layout.',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Gotchas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const _BulletList(<String>[
            'AlignTransition does not clip. If your alignment goes '
                'outside [-1, 1] and your child sits beyond the parent '
                'bounds, you may need an OverflowBox (to allow it) or a '
                'ClipRect (to hide it).',
            'AlignmentGeometryTween (and AlignmentDirectionalTween) lerp '
                'using the geometry classes, so mixing Alignment and '
                'AlignmentDirectional in begin/end works but resolves '
                'against ambient Directionality.',
            'Always dispose your AnimationController in dispose(). '
                'AlignTransition does NOT own the controller — leaking '
                'it leaks ticks every frame.',
            'If you reassign the animation field of AlignTransition, '
                'the widget will detach from the old animation and '
                'attach to the new one in didUpdateWidget. Listeners '
                'are managed for you.',
            'For truly tiny static cases, Align is enough — '
                'AlignTransition only earns its keep when the alignment '
                'CHANGES over time.',
          ]),
        ],
      ),
    );
  }
}

class _RefRow {
  const _RefRow(this.name, this.type, this.description);

  final String name;
  final String type;
  final String description;
}

class _RefTable extends StatelessWidget {
  const _RefTable({required this.rows});

  final List<_RefRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0DCEC)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isEven
                    ? const Color(0xFFFAF7FE)
                    : Colors.white,
                border: i == rows.length - 1
                    ? null
                    : const Border(
                        bottom: BorderSide(color: Color(0xFFE0DCEC)),
                      ),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          rows[i].name,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6750A4),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          rows[i].type,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.5,
                            color: Color(0xFF7C7287),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i].description,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Color(0xFF1D1B20),
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

// =====================================================================
// Local non-nullable AlignmentGeometry tween. The Flutter SDK ships
// AlignmentGeometryTween as Tween<AlignmentGeometry?>, which is a poor
// fit for AlignTransition (it wants Animation<AlignmentGeometry>) and
// for TweenSequence<AlignmentGeometry>. This shim keeps the lerp
// semantics but tightens the generic parameter to the non-nullable
// AlignmentGeometry — works for Alignment, AlignmentDirectional, and
// the mixed _MixedAlignment that AlignmentGeometry.lerp returns when
// the two endpoints are of different concrete subtypes.
// =====================================================================
class _AlignmentGeometryTween extends Tween<AlignmentGeometry> {
  _AlignmentGeometryTween({
    required AlignmentGeometry begin,
    required AlignmentGeometry end,
  }) : super(begin: begin, end: end);

  @override
  AlignmentGeometry lerp(double t) {
    final AlignmentGeometry? lerped =
        AlignmentGeometry.lerp(begin, end, t);
    return lerped ?? begin ?? Alignment.center;
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList(this.items);

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final String item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 5, right: 8),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: 8,
                    color: Color(0xFF6750A4),
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: Color(0xFF1D1B20),
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
