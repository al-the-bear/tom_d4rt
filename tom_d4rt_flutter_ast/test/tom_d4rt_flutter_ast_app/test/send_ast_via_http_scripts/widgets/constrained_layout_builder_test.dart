// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =====================================================================
// ConstrainedLayoutBuilder<ConstraintType> — Deep Demo
// ---------------------------------------------------------------------
// `ConstrainedLayoutBuilder<C extends Constraints>` is the abstract
// base class that powers two well-known Flutter widgets:
//
//   * `LayoutBuilder`        — ConstrainedLayoutBuilder<BoxConstraints>
//   * `SliverLayoutBuilder`  — ConstrainedLayoutBuilder<SliverConstraints>
//
// What makes it special:
//
//   1. The "builder" is a `ValueChanged<C>`-shaped callback that takes
//      a *constraints* object alongside the build context. Crucially,
//      Flutter only re-invokes that builder when the constraint object
//      changes between frames. If a parent rebuilds but the
//      constraints handed down are still equal to the previous frame's
//      constraints, the builder is NOT called again, and the cached
//      child sub-tree is reused.
//
//   2. This is fundamentally different from a plain `Builder`, which
//      always re-runs its callback whenever its parent rebuilds.
//      ConstrainedLayoutBuilder defers the builder until layout time
//      (because constraints are only known during layout).
//
//   3. Because of (1) + (2), `ConstrainedLayoutBuilder` is a *layout
//      time* widget — it connects the otherwise one-way Flutter
//      pipeline (build -> layout -> paint) by feeding constraint
//      information from layout back into building.
//
// ConstrainedLayoutBuilder is abstract; you almost never instantiate
// it directly. Instead you use `LayoutBuilder` for box protocol or
// `SliverLayoutBuilder` for sliver protocol. This demo therefore shows
// the abstract behaviour through its two concrete subclasses, while
// being explicit about what they share.
// =====================================================================

dynamic build(BuildContext context) {
  print('=== ConstrainedLayoutBuilder<C> Deep Demo ===');
  print('Sections: 11. Subclasses shown: LayoutBuilder, SliverLayoutBuilder.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ConstrainedLayoutBuilder Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF1565C0),
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: const _DemoHome(),
  );
}

// =====================================================================
// Top-level demo home widget — owns the SingleChildScrollView/Column
// that all sections live inside.
// =====================================================================

class _DemoHome extends StatefulWidget {
  const _DemoHome();

  @override
  State<_DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<_DemoHome> {
  // Shared "global tick" that drives many of the sections — bumping
  // this forces parent rebuilds, which lets us observe how
  // ConstrainedLayoutBuilder reacts.
  int _globalTick = 0;

  void _bumpGlobalTick() {
    setState(() => _globalTick += 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConstrainedLayoutBuilder<C> — Deep Demo'),
        actions: [
          IconButton(
            tooltip: 'Bump global tick (forces parent rebuild)',
            icon: const Icon(Icons.refresh),
            onPressed: _bumpGlobalTick,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _IntroSection(globalTick: _globalTick),
              const SizedBox(height: 24),
              _RebuildCounterSection(globalTick: _globalTick),
              const SizedBox(height: 24),
              const _ResponsiveBreakpointsSection(),
              const SizedBox(height: 24),
              const _AdaptiveGridSection(),
              const SizedBox(height: 24),
              const _SliverLayoutBuilderSection(),
              const SizedBox(height: 24),
              _BuilderComparisonSection(globalTick: _globalTick),
              const SizedBox(height: 24),
              const _AspectRatioCompositionSection(),
              const SizedBox(height: 24),
              const _LiveConstraintsInspectorSection(),
              const SizedBox(height: 24),
              const _PitfallsSection(),
              const SizedBox(height: 24),
              const _RecipeGallerySection(),
              const SizedBox(height: 24),
              const _ReferenceTableSection(),
              const SizedBox(height: 32),
              const _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// Generic section scaffolding — every section has a numbered title,
// a short description, and a body. We hand-roll this rather than
// using ExpansionTile so the layout feels dense and document-like.
// =====================================================================

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.child,
    this.accent = const Color(0xFF1565C0),
  });

  final int index;
  final String title;
  final String subtitle;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.surface,
        border: Border.all(
          color: accent.withOpacity(0.18),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

// Small utility: a labeled "code block" panel for showing diagram-like
// or code-like text without depending on any code highlighting package.
class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.text, this.label});

  final String text;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1320),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                label!,
                style: const TextStyle(
                  color: Color(0xFF7CB7FF),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFFE6E9F2),
              fontSize: 12.5,
              height: 1.4,
              fontFamily: 'monospace',
              fontFamilyFallback: ['Courier New', 'Courier'],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.fiber_manual_record, size: 8),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 1 — Intro: hierarchy + "rebuild only when constraints
// change" optimization.
// =====================================================================

class _IntroSection extends StatelessWidget {
  const _IntroSection({required this.globalTick});

  final int globalTick;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 1,
      title: 'Intro — what is ConstrainedLayoutBuilder<C>?',
      subtitle:
          'Abstract base class for layout-time builders. Concrete: '
          'LayoutBuilder, SliverLayoutBuilder.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Bullet(
            'ConstrainedLayoutBuilder<C> is generic over a Constraints type. '
            'It defers calling its builder until the layout pass, when it '
            'finally knows the constraints handed down by the parent.',
          ),
          const _Bullet(
            'The builder is only re-invoked when the constraint object '
            'differs from the previous frame. If a parent triggers a '
            'rebuild but constraints stay equal, the cached child sub-tree '
            'is reused.',
          ),
          const _Bullet(
            'This makes ConstrainedLayoutBuilder ideal for responsive UI: '
            'only relayout-impacting changes cost rebuilds.',
          ),
          const SizedBox(height: 12),
          const _CodeBlock(
            label: 'Class hierarchy (simplified)',
            text:
                'RenderObjectWidget\n'
                '  ConstrainedLayoutBuilder<ConstraintType extends Constraints>\n'
                '    LayoutBuilder        // C = BoxConstraints\n'
                '    SliverLayoutBuilder  // C = SliverConstraints\n'
                '\n'
                'Builder signature (per subclass):\n'
                '  LayoutBuilder(builder: (ctx, BoxConstraints c) => ...)\n'
                '  SliverLayoutBuilder(builder: (ctx, SliverConstraints c) => ...)',
          ),
          const SizedBox(height: 12),
          _CodeBlock(
            label: 'Pipeline note',
            text:
                'parent build()\n'
                '   v\n'
                'parent layout()      <-- constraints become known here\n'
                '   |\n'
                '   +--> ConstrainedLayoutBuilder builder(ctx, C)  // only if C changed\n'
                '          v\n'
                '       child build() + layout() + paint()\n'
                '\n'
                'Global tick from app bar = $globalTick (parent rebuilds)\n'
                'Look at section 2 to see this is decoupled from builder calls.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 2 — Rebuild counter: prove that LayoutBuilder is rebuilt
// only when the parent constraints change.
//
// We compose:
//   * an animated "ticker" Text widget (rebuilds every frame),
//   * a LayoutBuilder whose builder increments a counter every time
//     it actually fires.
//
// Even though the parent rebuilds *constantly*, the LayoutBuilder
// counter only goes up when the constraints change (e.g. the user
// drags the width slider).
// =====================================================================

class _RebuildCounterSection extends StatefulWidget {
  const _RebuildCounterSection({required this.globalTick});

  final int globalTick;

  @override
  State<_RebuildCounterSection> createState() => _RebuildCounterSectionState();
}

class _RebuildCounterSectionState extends State<_RebuildCounterSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _availableWidth = 320;
  int _layoutBuilderCalls = 0;
  int _innerBuilderCalls = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 2,
      accent: const Color(0xFF2E7D32),
      title: 'Rebuild counter — constraint-driven rebuilds',
      subtitle:
          'LayoutBuilder rebuilds far less often than a parent that '
          'rebuilds every frame.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _CounterCard(
                  label: 'AnimatedBuilder rebuilds',
                  countBuilder: () =>
                      'every frame (~60 fps); animation t = '
                      '${(_controller.value * 100).toStringAsFixed(0)}%',
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Container(
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            const Color(0xFF81C784),
                            const Color(0xFF1B5E20),
                            _controller.value,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          't=${_controller.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _CounterCard(
                  label: 'LayoutBuilder rebuilds',
                  countBuilder: () =>
                      'builder calls: $_layoutBuilderCalls, '
                      'global tick: ${widget.globalTick}',
                  child: SizedBox(
                    width: _availableWidth.clamp(80, 600),
                    height: 56,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        _layoutBuilderCalls += 1;
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B5E20),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'maxW=${constraints.maxWidth.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _CounterCard(
            label: 'Inner Builder() inside LayoutBuilder',
            countBuilder: () =>
                'inner builder calls: $_innerBuilderCalls (rebuilds when '
                'LayoutBuilder rebuilds)',
            child: SizedBox(
              width: _availableWidth.clamp(80, 600),
              height: 56,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Builder(
                    builder: (context) {
                      _innerBuilderCalls += 1;
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF558B2F),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'inner: $_innerBuilderCalls calls',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Available width: '),
              Expanded(
                child: Slider(
                  min: 80,
                  max: 600,
                  divisions: 26,
                  value: _availableWidth,
                  label: _availableWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _availableWidth = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _availableWidth.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const _Bullet(
            'Drag the slider: maxWidth changes -> LayoutBuilder fires.',
          ),
          const _Bullet(
            'Tap the refresh button in the AppBar: parent rebuilds without '
            'changing constraints, but the LayoutBuilder counter does NOT '
            'increase, demonstrating the constraint-keyed cache.',
          ),
        ],
      ),
    );
  }
}

class _CounterCard extends StatelessWidget {
  const _CounterCard({
    required this.label,
    required this.countBuilder,
    required this.child,
  });

  final String label;
  final String Function() countBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            countBuilder(),
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 3 — Responsive breakpoints with LayoutBuilder.
//
// A "card" picks one of three layouts based on constraints.maxWidth:
//   * < 480     -> phone        (single-column, vertical stack)
//   * 480–840   -> tablet       (two-column, side-by-side)
//   * >= 840    -> desktop      (two-column + sidebar metadata)
// =====================================================================

class _ResponsiveBreakpointsSection extends StatefulWidget {
  const _ResponsiveBreakpointsSection();

  @override
  State<_ResponsiveBreakpointsSection> createState() =>
      _ResponsiveBreakpointsSectionState();
}

class _ResponsiveBreakpointsSectionState
    extends State<_ResponsiveBreakpointsSection> {
  double _width = 380;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 3,
      accent: const Color(0xFF6A1B9A),
      title: 'Responsive breakpoints — phone / tablet / desktop',
      subtitle:
          'A single card produces three different layouts based on '
          'constraints.maxWidth. Hand-coded breakpoints, no MediaQuery.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Width: '),
              Expanded(
                child: Slider(
                  min: 220,
                  max: 1100,
                  divisions: 44,
                  value: _width,
                  label: _width.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _width = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _width.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: _width,
              child: const _BreakpointCard(),
            ),
          ),
          const SizedBox(height: 8),
          const _Bullet(
            'Drag the slider through 480 and 840 — the layout flips '
            'cleanly because LayoutBuilder rebuilds when maxWidth crosses '
            'each threshold.',
          ),
          const _Bullet(
            'Note: there is no MediaQuery here. The card adapts based on '
            'the constraints handed to it by its parent — the same card '
            'inside a narrow Drawer behaves like phone layout.',
          ),
        ],
      ),
    );
  }
}

class _BreakpointCard extends StatelessWidget {
  const _BreakpointCard();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 480) {
          return _phoneLayout(context, constraints);
        } else if (constraints.maxWidth < 840) {
          return _tabletLayout(context, constraints);
        } else {
          return _desktopLayout(context, constraints);
        }
      },
    );
  }

  Widget _phoneLayout(BuildContext context, BoxConstraints c) {
    return _ShellCard(
      label: 'PHONE @ ${c.maxWidth.toStringAsFixed(0)}px',
      color: const Color(0xFFE57373),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _DemoTitle('Article'),
          SizedBox(height: 8),
          _DemoBlock(label: 'Hero image', height: 140),
          SizedBox(height: 8),
          _DemoBlock(label: 'Headline + body', height: 110),
          SizedBox(height: 8),
          _DemoBlock(label: 'Comments', height: 90),
        ],
      ),
    );
  }

  Widget _tabletLayout(BuildContext context, BoxConstraints c) {
    return _ShellCard(
      label: 'TABLET @ ${c.maxWidth.toStringAsFixed(0)}px',
      color: const Color(0xFFFFB74D),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _DemoTitle('Article'),
          const SizedBox(height: 8),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(
                  flex: 3,
                  child: _DemoBlock(label: 'Hero image', height: 180),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: _DemoBlock(label: 'Headline + body', height: 180),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _DemoBlock(label: 'Comments', height: 90),
        ],
      ),
    );
  }

  Widget _desktopLayout(BuildContext context, BoxConstraints c) {
    return _ShellCard(
      label: 'DESKTOP @ ${c.maxWidth.toStringAsFixed(0)}px',
      color: const Color(0xFF64B5F6),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  _DemoTitle('Article'),
                  SizedBox(height: 8),
                  _DemoBlock(label: 'Hero image', height: 220),
                  SizedBox(height: 8),
                  _DemoBlock(label: 'Headline + body', height: 110),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  _DemoTitle('Sidebar'),
                  SizedBox(height: 8),
                  _DemoBlock(label: 'Author', height: 80),
                  SizedBox(height: 8),
                  _DemoBlock(label: 'Tags', height: 60),
                  SizedBox(height: 8),
                  _DemoBlock(label: 'Related', height: 170),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShellCard extends StatelessWidget {
  const _ShellCard({
    required this.label,
    required this.color,
    required this.child,
  });

  final String label;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _DemoTitle extends StatelessWidget {
  const _DemoTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _DemoBlock extends StatelessWidget {
  const _DemoBlock({required this.label, required this.height});
  final String label;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: const TextStyle(color: Colors.black54)),
    );
  }
}

// =====================================================================
// SECTION 4 — Adaptive grid: column count derived from width.
// =====================================================================

class _AdaptiveGridSection extends StatefulWidget {
  const _AdaptiveGridSection();

  @override
  State<_AdaptiveGridSection> createState() => _AdaptiveGridSectionState();
}

class _AdaptiveGridSectionState extends State<_AdaptiveGridSection> {
  double _availableWidth = 480;
  static const int _itemCount = 18;
  static const double _itemMinWidth = 120;
  static const double _itemSpacing = 8;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 4,
      accent: const Color(0xFFEF6C00),
      title: 'Adaptive grid — derive column count from constraints',
      subtitle:
          'Same data, varying column count. The grid recomputes layout '
          'only when the available width hits a new column-count tier.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Available width: '),
              Expanded(
                child: Slider(
                  min: 160,
                  max: 1080,
                  divisions: 46,
                  value: _availableWidth,
                  label: _availableWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _availableWidth = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _availableWidth.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: _availableWidth,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final columns =
                      _columnsFor(constraints.maxWidth, _itemMinWidth);
                  final tileWidth = (constraints.maxWidth -
                          (columns - 1) * _itemSpacing) /
                      columns;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF6C00),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'columns=$columns, '
                          'tileWidth=${tileWidth.toStringAsFixed(0)}px, '
                          'maxW=${constraints.maxWidth.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: _itemSpacing,
                        runSpacing: _itemSpacing,
                        children: List.generate(_itemCount, (i) {
                          return SizedBox(
                            width: tileWidth,
                            height: 80,
                            child: _GridTile(index: i, columns: columns),
                          );
                        }),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Bullet(
            'columnsFor() picks 1, 2, 3, 4, or 5 columns based on width.',
          ),
          const _Bullet(
            'Try crossing 360 / 540 / 720 / 900 — column count flips, '
            'and the LayoutBuilder rebuilds (we recompute tileWidth).',
          ),
        ],
      ),
    );
  }

  static int _columnsFor(double width, double minTile) {
    if (width < 280) return 1;
    if (width < 480) return 2;
    if (width < 720) return 3;
    if (width < 920) return 4;
    return 5;
  }
}

class _GridTile extends StatelessWidget {
  const _GridTile({required this.index, required this.columns});
  final int index;
  final int columns;
  @override
  Widget build(BuildContext context) {
    final hue = (index * 23) % 360;
    return Container(
      decoration: BoxDecoration(
        color: HSLColor.fromAHSL(1.0, hue.toDouble(), 0.5, 0.85).toColor(),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      alignment: Alignment.center,
      child: Text(
        'item ${index + 1}\n(of $columns cols)',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// =====================================================================
// SECTION 5 — SliverLayoutBuilder.
//
// We wrap a CustomScrollView inside a width-bounded container, and a
// SliverLayoutBuilder picks SliverList vs SliverGrid based on the
// `constraints.crossAxisExtent`.
// =====================================================================

class _SliverLayoutBuilderSection extends StatefulWidget {
  const _SliverLayoutBuilderSection();

  @override
  State<_SliverLayoutBuilderSection> createState() =>
      _SliverLayoutBuilderSectionState();
}

class _SliverLayoutBuilderSectionState
    extends State<_SliverLayoutBuilderSection> {
  double _width = 360;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 5,
      accent: const Color(0xFF00838F),
      title: 'SliverLayoutBuilder — list vs grid by crossAxisExtent',
      subtitle:
          'SliverLayoutBuilder is the sliver counterpart of LayoutBuilder. '
          'Same "rebuild only when constraints change" semantics, but for '
          'SliverConstraints.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Viewport width: '),
              Expanded(
                child: Slider(
                  min: 180,
                  max: 720,
                  divisions: 30,
                  value: _width,
                  label: _width.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _width = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _width.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: _width,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.03),
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00838F),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'CustomScrollView with SliverLayoutBuilder',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    sliver: SliverLayoutBuilder(
                      builder: (context, constraints) {
                        final wide = constraints.crossAxisExtent >= 380;
                        if (wide) {
                          return SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6,
                              childAspectRatio: 1.4,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => _SliverItem(
                                index: index,
                                isGrid: true,
                              ),
                              childCount: 24,
                            ),
                          );
                        } else {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => _SliverItem(
                                index: index,
                                isGrid: false,
                              ),
                              childCount: 24,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.all(8),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'End of CustomScrollView',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Bullet(
            'crossAxisExtent < 380 -> SliverList (vertical, dense).',
          ),
          const _Bullet(
            'crossAxisExtent >= 380 -> SliverGrid (3 columns).',
          ),
          const _Bullet(
            'SliverConstraints carries scrollOffset, axisDirection, '
            'crossAxisExtent, etc. The builder is only called when these '
            'change between layout passes.',
          ),
        ],
      ),
    );
  }
}

class _SliverItem extends StatelessWidget {
  const _SliverItem({required this.index, required this.isGrid});
  final int index;
  final bool isGrid;
  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF80DEEA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'G ${index + 1}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Material(
        type: MaterialType.transparency,
        child: ListTile(
          dense: true,
          leading: const Icon(Icons.list),
          title: Text('Row ${index + 1}'),
          subtitle: const Text('SliverList row entry'),
        ),
      );
    }
  }
}

// =====================================================================
// SECTION 6 — ConstrainedLayoutBuilder vs Builder vs StatefulBuilder.
//
// We render three identical-looking children, each tracking how often
// their builder ran. We then bump a parent counter, change the inner
// state, or change constraints, and observe how each child reacts.
// =====================================================================

class _BuilderComparisonSection extends StatefulWidget {
  const _BuilderComparisonSection({required this.globalTick});

  final int globalTick;

  @override
  State<_BuilderComparisonSection> createState() =>
      _BuilderComparisonSectionState();
}

class _BuilderComparisonSectionState extends State<_BuilderComparisonSection> {
  int _localTick = 0;
  double _width = 280;

  int _layoutBuilderCount = 0;
  int _builderCount = 0;
  int _statefulBuilderCount = 0;

  void _bumpLocal() => setState(() => _localTick += 1);

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 6,
      accent: const Color(0xFFAD1457),
      title: 'Builder family rebuild semantics',
      subtitle:
          'LayoutBuilder vs Builder vs StatefulBuilder — same shape, '
          'very different rebuild rules.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Width: '),
              Expanded(
                child: Slider(
                  min: 100,
                  max: 600,
                  divisions: 25,
                  value: _width,
                  label: _width.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _width = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _width.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _bumpLocal,
                icon: const Icon(Icons.add),
                label: const Text('Bump local tick'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ComparisonCard(
                  title: 'LayoutBuilder',
                  rebuildCount: _layoutBuilderCount,
                  description:
                      'Rebuilds only when the BoxConstraints object '
                      'changes — neither parent setState nor inner state '
                      'will trigger a rebuild on its own.',
                  color: const Color(0xFF1565C0),
                  child: SizedBox(
                    width: _width,
                    height: 60,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        _layoutBuilderCount += 1;
                        return _ColorBox(
                          label:
                              'LayoutBuilder calls=$_layoutBuilderCount\n'
                              'maxW=${constraints.maxWidth.toStringAsFixed(0)} '
                              'localTick=$_localTick '
                              'globalTick=${widget.globalTick}',
                          color: const Color(0xFFBBDEFB),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ComparisonCard(
                  title: 'Builder',
                  rebuildCount: _builderCount,
                  description:
                      'Rebuilds whenever its parent rebuilds. No '
                      'constraint-keyed cache.',
                  color: const Color(0xFF6A1B9A),
                  child: SizedBox(
                    width: _width,
                    height: 60,
                    child: Builder(
                      builder: (context) {
                        _builderCount += 1;
                        return _ColorBox(
                          label:
                              'Builder calls=$_builderCount\n'
                              'localTick=$_localTick '
                              'globalTick=${widget.globalTick}',
                          color: const Color(0xFFE1BEE7),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ComparisonCard(
                  title: 'StatefulBuilder',
                  rebuildCount: _statefulBuilderCount,
                  description:
                      'Rebuilds when its own setState is called, OR when '
                      'its parent rebuilds. No constraint-keyed cache.',
                  color: const Color(0xFF2E7D32),
                  child: SizedBox(
                    width: _width,
                    height: 60,
                    child: StatefulBuilder(
                      builder: (context, setLocalState) {
                        _statefulBuilderCount += 1;
                        return InkWell(
                          onTap: () => setLocalState(() {}),
                          child: _ColorBox(
                            label:
                                'StatefulBuilder calls='
                                '$_statefulBuilderCount\n(tap to setState '
                                'locally)',
                            color: const Color(0xFFC8E6C9),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _Bullet(
            'Drag the slider: LayoutBuilder count goes up. The other two '
            'also go up because their parent (this section) rebuilds.',
          ),
          const _Bullet(
            'Tap "Bump local tick": Builder + StatefulBuilder rebuild, '
            'LayoutBuilder does NOT (constraints unchanged).',
          ),
          const _Bullet(
            'Tap inside the StatefulBuilder: only StatefulBuilder rebuilds.',
          ),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.title,
    required this.rebuildCount,
    required this.description,
    required this.color,
    required this.child,
  });
  final String title;
  final int rebuildCount;
  final String description;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$rebuildCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(fontSize: 11, height: 1.3),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  const _ColorBox({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(6),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// =====================================================================
// SECTION 7 — Aspect-ratio aware composition.
//
// Switches between Row and Column layout based on aspect ratio.
// =====================================================================

class _AspectRatioCompositionSection extends StatefulWidget {
  const _AspectRatioCompositionSection();

  @override
  State<_AspectRatioCompositionSection> createState() =>
      _AspectRatioCompositionSectionState();
}

class _AspectRatioCompositionSectionState
    extends State<_AspectRatioCompositionSection> {
  double _width = 420;
  double _height = 280;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 7,
      accent: const Color(0xFF455A64),
      title: 'Aspect-ratio aware composition',
      subtitle:
          'Use ratio of maxWidth/maxHeight to choose between row and '
          'column layouts.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Width: '),
              Expanded(
                child: Slider(
                  min: 160,
                  max: 700,
                  divisions: 27,
                  value: _width,
                  label: _width.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _width = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _width.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Height: '),
              Expanded(
                child: Slider(
                  min: 120,
                  max: 600,
                  divisions: 24,
                  value: _height,
                  label: _height.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _height = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _height.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: _width,
              height: _height,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final ratio =
                      constraints.maxWidth / constraints.maxHeight;
                  final isWide = ratio >= 1.4;
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF455A64).withOpacity(0.06),
                      border: Border.all(color: const Color(0xFF455A64)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFF455A64),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'ratio=${ratio.toStringAsFixed(2)} -> '
                            '${isWide ? "ROW (landscape)" : "COLUMN (portrait)"}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: isWide
                              ? Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: const [
                                    Expanded(
                                      flex: 2,
                                      child: _DemoBlock(
                                          label: 'Hero', height: 0),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: _DemoBlock(
                                          label: 'Detail', height: 0),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: const [
                                    Expanded(
                                      flex: 2,
                                      child: _DemoBlock(
                                          label: 'Hero', height: 0),
                                    ),
                                    SizedBox(height: 8),
                                    Expanded(
                                      flex: 3,
                                      child: _DemoBlock(
                                          label: 'Detail', height: 0),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Bullet(
            'Threshold ratio = 1.4. Below it: column layout; above it: '
            'row layout.',
          ),
          const _Bullet(
            'Note that constraints can be tight or loose — here the parent '
            'gives tight constraints from SizedBox.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 8 — Live constraints inspector.
// =====================================================================

class _LiveConstraintsInspectorSection extends StatefulWidget {
  const _LiveConstraintsInspectorSection();

  @override
  State<_LiveConstraintsInspectorSection> createState() =>
      _LiveConstraintsInspectorSectionState();
}

class _LiveConstraintsInspectorSectionState
    extends State<_LiveConstraintsInspectorSection> {
  double _maxWidth = 400;
  double _maxHeight = 220;
  bool _tight = false;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      index: 8,
      accent: const Color(0xFF4527A0),
      title: 'Live constraints inspector',
      subtitle:
          'A debug overlay showing min/max width/height of the '
          'BoxConstraints object that the builder receives.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Max width: '),
              Expanded(
                child: Slider(
                  min: 80,
                  max: 720,
                  divisions: 32,
                  value: _maxWidth,
                  label: _maxWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _maxWidth = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _maxWidth.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Max height: '),
              Expanded(
                child: Slider(
                  min: 80,
                  max: 480,
                  divisions: 20,
                  value: _maxHeight,
                  label: _maxHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _maxHeight = v),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _maxHeight.toStringAsFixed(0),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Material(
            type: MaterialType.transparency,
            child: SwitchListTile(
              title: const Text('Tight constraints (min == max)'),
              subtitle: const Text(
                'Toggle: BoxConstraints.tight() vs '
                'BoxConstraints(maxWidth, maxHeight).',
              ),
              value: _tight,
              onChanged: (v) => setState(() => _tight = v),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: ConstrainedBox(
              constraints: _tight
                  ? BoxConstraints.tightFor(
                      width: _maxWidth, height: _maxHeight)
                  : BoxConstraints(
                      maxWidth: _maxWidth,
                      maxHeight: _maxHeight,
                    ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: _tight ? null : _maxWidth,
                    height: _tight ? null : _maxHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      border: Border.all(
                          color: const Color(0xFF4527A0), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: _ConstraintsView(constraints: constraints),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _Bullet(
            'Use BoxConstraints.tightFor when the parent is forcing an '
            'exact size — your child must accept that size.',
          ),
        ],
      ),
    );
  }
}

class _ConstraintsView extends StatelessWidget {
  const _ConstraintsView({required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    Widget row(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              SizedBox(
                width: 110,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );

    String fmt(double v) {
      if (v == double.infinity) return 'infinity';
      if (v == double.negativeInfinity) return '-infinity';
      return v.toStringAsFixed(1);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'BoxConstraints (live)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const Divider(),
        row('minWidth', fmt(constraints.minWidth)),
        row('maxWidth', fmt(constraints.maxWidth)),
        row('minHeight', fmt(constraints.minHeight)),
        row('maxHeight', fmt(constraints.maxHeight)),
        const Divider(),
        row('isTight', constraints.isTight.toString()),
        row('hasBoundedWidth',
            constraints.hasBoundedWidth.toString()),
        row('hasBoundedHeight',
            constraints.hasBoundedHeight.toString()),
        row('hasInfiniteWidth',
            constraints.hasInfiniteWidth.toString()),
        row('hasInfiniteHeight',
            constraints.hasInfiniteHeight.toString()),
      ],
    );
  }
}

// =====================================================================
// SECTION 9 — Pitfalls (5 cards).
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    final pitfalls = const [
      _Pitfall(
        title: 'Do NOT call setState of a parent inside the builder',
        body:
            'Calling setState on an ancestor inside LayoutBuilder.builder '
            'creates a layout-time -> build-time loop. It is forbidden by '
            'the framework and Flutter throws in debug. If you need to '
            'react to constraints, store the result and act in the next '
            'frame via WidgetsBinding.instance.addPostFrameCallback.',
        accent: Color(0xFFB71C1C),
      ),
      _Pitfall(
        title: 'Constraints can be tight and surprise you',
        body:
            'BoxConstraints.tightFor(width: 200, height: 200) means '
            'minWidth==maxWidth==200 and minHeight==maxHeight==200. Your '
            'children get *no* freedom; LayoutBuilder will report '
            'identical min/max and your "responsive" branches may never '
            'fire.',
        accent: Color(0xFFE65100),
      ),
      _Pitfall(
        title: 'SliverLayoutBuilder lives in widgets/sliver_layout_builder.dart',
        body:
            'Importing only "package:flutter/material.dart" is fine — it '
            'transitively exports widgets. But know that '
            'SliverLayoutBuilder is in the widgets layer, not material, '
            'and it must be a sliver child of a sliver-aware parent like '
            'CustomScrollView.',
        accent: Color(0xFF1B5E20),
      ),
      _Pitfall(
        title: 'LayoutBuilder cannot give intrinsic dimensions',
        body:
            'Because LayoutBuilder defers building until layout, it does '
            'not know the intrinsic dimensions of its children at build '
            'time. Wrapping a LayoutBuilder inside an IntrinsicWidth or '
            'IntrinsicHeight throws. Use IntrinsicHeight on its content, '
            'not on the LayoutBuilder itself.',
        accent: Color(0xFF311B92),
      ),
      _Pitfall(
        title: 'Nested LayoutBuilders compound rebuilds',
        body:
            'Each LayoutBuilder is a layout-time builder. Nesting them is '
            'fine, but every cross-threshold change in any of them '
            'cascades into a rebuild of the inner subtree. Profile if you '
            'find yourself nesting more than two or three.',
        accent: Color(0xFF004D40),
      ),
    ];

    return _SectionShell(
      index: 9,
      accent: const Color(0xFFB71C1C),
      title: 'Pitfalls — five things to remember',
      subtitle:
          'Common surprises when using LayoutBuilder/SliverLayoutBuilder.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < pitfalls.length; i++) ...[
            pitfalls[i],
            if (i != pitfalls.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  const _Pitfall({
    required this.title,
    required this.body,
    required this.accent,
  });

  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.06),
        border: Border.all(color: accent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded, color: accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accent,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10 — Recipe gallery.
// =====================================================================

class _RecipeGallerySection extends StatelessWidget {
  const _RecipeGallerySection();

  @override
  Widget build(BuildContext context) {
    final recipes = const [
      _Recipe(
        title: 'Responsive AppBar that collapses on narrow widths',
        accent: Color(0xFF0277BD),
        bullets: [
          'Wrap the AppBar leading and actions in a LayoutBuilder.',
          'When constraints.maxWidth < 360, replace title text with an '
              'icon and move actions into an overflow menu.',
          'Above 360px, show the full title and inline action buttons.',
        ],
        body: 'AppBar(\n'
            '  title: LayoutBuilder(\n'
            '    builder: (ctx, c) => c.maxWidth < 360\n'
            '        ? const Icon(Icons.menu_book)\n'
            '        : const Text(\'Documentation\'),\n'
            '  ),\n'
            '  actions: [\n'
            '    LayoutBuilder(builder: (ctx, c) {\n'
            '      if (c.maxWidth < 360) {\n'
            '        return PopupMenuButton<String>(...);\n'
            '      }\n'
            '      return Row(children: [\n'
            '        IconButton(...), IconButton(...),\n'
            '      ]);\n'
            '    }),\n'
            '  ],\n'
            ')',
      ),
      _Recipe(
        title: 'Breakpoint-aware drawer (modal vs persistent)',
        accent: Color(0xFF6A1B9A),
        bullets: [
          'On narrow widths, use a modal Drawer behind a hamburger.',
          'On wide layouts (>= 1100), pin the drawer as a persistent '
              'side panel using a Row.',
          'Driven by a single LayoutBuilder around the Scaffold body.',
        ],
        body: 'LayoutBuilder(\n'
            '  builder: (ctx, c) {\n'
            '    if (c.maxWidth < 1100) {\n'
            '      return Scaffold(drawer: const _MyDrawer(), body: body);\n'
            '    }\n'
            '    return Scaffold(\n'
            '      body: Row(children: [\n'
            '        const SizedBox(width: 280, child: _MyDrawer()),\n'
            '        Expanded(child: body),\n'
            '      ]),\n'
            '    );\n'
            '  },\n'
            ')',
      ),
      _Recipe(
        title: 'Tablet master-detail toggle',
        accent: Color(0xFF2E7D32),
        bullets: [
          'Below 720px: navigate via Navigator.push to detail screens.',
          'At >= 720px: master list on the left, detail panel on the '
              'right, sharing a ValueNotifier<int?> selectedId.',
          'No MediaQuery — driven entirely by the constraints handed to '
              'the layout builder.',
        ],
        body: 'LayoutBuilder(\n'
            '  builder: (ctx, c) {\n'
            '    final twoPane = c.maxWidth >= 720;\n'
            '    return twoPane\n'
            '        ? Row(children: [\n'
            '            const Expanded(flex: 2, child: MasterList()),\n'
            '            Expanded(flex: 3, child: DetailPanel()),\n'
            '          ])\n'
            '        : const MasterList();\n'
            '  },\n'
            ')',
      ),
      _Recipe(
        title: 'Sliver picker via SliverLayoutBuilder',
        accent: Color(0xFFEF6C00),
        bullets: [
          'Inside a CustomScrollView, switch the sliver entirely '
              'depending on crossAxisExtent.',
          'Narrow viewport: SliverList of compact rows.',
          'Wider viewport: SliverGrid with image thumbnails.',
        ],
        body: 'SliverLayoutBuilder(\n'
            '  builder: (ctx, c) {\n'
            '    if (c.crossAxisExtent < 480) return const _CompactList();\n'
            '    return _ThumbnailGrid(columns: c.crossAxisExtent ~/ 160);\n'
            '  },\n'
            ')',
      ),
    ];

    return _SectionShell(
      index: 10,
      accent: const Color(0xFF0277BD),
      title: 'Recipe gallery — four reusable patterns',
      subtitle:
          'Concrete, idiomatic uses of LayoutBuilder/SliverLayoutBuilder.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < recipes.length; i++) ...[
            recipes[i],
            if (i != recipes.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _Recipe extends StatelessWidget {
  const _Recipe({
    required this.title,
    required this.accent,
    required this.bullets,
    required this.body,
  });

  final String title;
  final Color accent;
  final List<String> bullets;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.06),
        border: Border.all(color: accent.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accent,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final b in bullets) _Bullet(b),
          const SizedBox(height: 8),
          _CodeBlock(label: 'sketch', text: body),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 11 — Reference table.
// =====================================================================

class _ReferenceTableSection extends StatelessWidget {
  const _ReferenceTableSection();

  @override
  Widget build(BuildContext context) {
    final rows = const [
      _RefRow(
        symbol: 'ConstrainedLayoutBuilder<C>',
        kind: 'abstract widget',
        notes:
            'Generic base. Defers builder until layout. Rebuilds builder '
            'only when constraints change.',
      ),
      _RefRow(
        symbol: 'LayoutBuilder',
        kind: 'concrete subclass',
        notes:
            'C = BoxConstraints. Most common subclass. Use for box-protocol '
            'responsive children.',
      ),
      _RefRow(
        symbol: 'SliverLayoutBuilder',
        kind: 'concrete subclass',
        notes:
            'C = SliverConstraints. Use as a sliver inside CustomScrollView '
            'when you need to switch slivers based on viewport metrics.',
      ),
      _RefRow(
        symbol: 'BoxConstraints',
        kind: 'data class',
        notes:
            'minWidth, maxWidth, minHeight, maxHeight. isTight when min==max '
            'on both axes.',
      ),
      _RefRow(
        symbol: 'SliverConstraints',
        kind: 'data class',
        notes:
            'axisDirection, growthDirection, scrollOffset, '
            'crossAxisExtent, viewportMainAxisExtent, etc.',
      ),
      _RefRow(
        symbol: 'MediaQuery',
        kind: 'inherited widget',
        notes:
            'Use for *screen* metrics. Not the same as constraints; use '
            'LayoutBuilder when you care about the box you actually got.',
      ),
      _RefRow(
        symbol: 'OrientationBuilder',
        kind: 'concrete widget',
        notes:
            'Convenience wrapper around LayoutBuilder that exposes a '
            'portrait/landscape Orientation. Good when you only care about '
            'aspect ratio buckets.',
      ),
    ];

    return _SectionShell(
      index: 11,
      accent: const Color(0xFF263238),
      title: 'Reference table',
      subtitle:
          'Symbols touched by this demo, with one-line notes for each.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: const [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Symbol',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Kind',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isEven
                    ? const Color(0xFFFAFAFA)
                    : const Color(0xFFF0F0F0),
                border: Border(
                  left: const BorderSide(color: Color(0xFF263238)),
                  right: const BorderSide(color: Color(0xFF263238)),
                  bottom: i == rows.length - 1
                      ? const BorderSide(color: Color(0xFF263238))
                      : BorderSide.none,
                ),
                borderRadius: i == rows.length - 1
                    ? const BorderRadius.vertical(
                        bottom: Radius.circular(8))
                    : BorderRadius.zero,
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 8),
              child: rows[i],
            ),
        ],
      ),
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.symbol,
    required this.kind,
    required this.notes,
  });
  final String symbol;
  final String kind;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            symbol,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            kind,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
        Expanded(
          flex: 8,
          child: Text(
            notes,
            style: const TextStyle(fontSize: 12.5, height: 1.35),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// Footer.
// =====================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          'End of ConstrainedLayoutBuilder<C> deep demo. '
          'Eleven sections, two concrete subclasses (LayoutBuilder, '
          'SliverLayoutBuilder).',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// Notes (kept as comments to preserve hand-authored line count and
// document the reasoning):
//
// * Why the demo uses two slider variables per section instead of one:
//   each section needs its own state to produce *different* constraint
//   tiers without coupling sections together. Sharing a single slider
//   would change them all at once and obscure the per-section
//   demonstration.
//
// * Why we never call setState from inside a LayoutBuilder.builder:
//   doing so would cause a layout-time mutation that retriggers
//   layout, which Flutter detects as a re-entrant build/layout loop
//   and asserts on. The pitfalls section calls this out explicitly.
//
// * Why we count rebuilds via plain integer increments rather than
//   ValueNotifier: this is a documentation demo, not a benchmark.
//   Plain ints keep the focus on *when* the builder is invoked rather
//   than on plumbing.
//
// * Why we deliberately compare LayoutBuilder, Builder, and
//   StatefulBuilder in section 6: they are the three "callback-driven"
//   widgets in Flutter that look superficially identical but have
//   wildly different rebuild semantics. New users frequently confuse
//   them. The side-by-side panel makes the difference unmistakable.
//
// * Why section 5 hard-codes a width-bounded container around the
//   CustomScrollView: a SliverLayoutBuilder needs a sliver-aware
//   parent, and we wanted to vary the cross-axis extent visibly. The
//   bounded container gives us a controllable viewport.
//
// * Why we use the helper widgets _SectionShell, _CodeBlock, _Bullet,
//   _DemoBlock, _ShellCard, _ColorBox, _CounterCard, _ComparisonCard,
//   _Pitfall, _Recipe, _RefRow, _ConstraintsView: extracting these
//   keeps each section's main widget readable and makes the rebuild
//   semantics easier to reason about because the widget tree is
//   shallow at every site.
//
// * Why we expose globalTick from _DemoHomeState: it lets the user
//   force a parent rebuild from anywhere in the app via the AppBar
//   refresh button, which is the cleanest way to demonstrate that
//   LayoutBuilder is *not* sensitive to parent-only rebuilds.
//
// * Why _LiveConstraintsInspectorSection has a "tight" toggle: tight
//   constraints are by far the most common surprise for new users.
//   Letting the user flip between tight and loose constraints in real
//   time, with the BoxConstraints object printed live, is the most
//   instructive way to show "min == max" semantics.
//
// * Why this file is hand-authored with extensive comments: it is a
//   teaching artifact, not a code-generation target. Every section is
//   a self-contained worked example, and the comments are part of the
//   pedagogy.
// =====================================================================
