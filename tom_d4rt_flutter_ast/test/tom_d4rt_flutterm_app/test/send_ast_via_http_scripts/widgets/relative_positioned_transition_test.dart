import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level mutable state (ValueNotifier — stateless widget pattern)
// ---------------------------------------------------------------------------

final ValueNotifier<double> _sliderT = ValueNotifier<double>(0.0);
final ValueNotifier<int> _presetIndex = ValueNotifier<int>(0);
final ValueNotifier<Curve> _selectedCurve = ValueNotifier<Curve>(Curves.linear);
final ValueNotifier<bool> _animTrigger = ValueNotifier<bool>(false);

// ---------------------------------------------------------------------------
// Preset Rect pairs  (absolute pixel rects within a 280×280 stack)
// Each entry has a label, begin Rect, and end Rect.
// ---------------------------------------------------------------------------

const double _stackSide = 280.0;

const List<Map<String, dynamic>> _presets = <Map<String, dynamic>>[
  <String, dynamic>{
    'label': 'Corner to Corner',
    'begin': Rect.fromLTWH(4, 4, 80, 80),
    'end': Rect.fromLTWH(196, 196, 80, 80),
  },
  <String, dynamic>{
    'label': 'Center Expansion',
    'begin': Rect.fromLTWH(110, 110, 60, 60),
    'end': Rect.fromLTWH(4, 4, 272, 272),
  },
  <String, dynamic>{
    'label': 'Horizontal Slide',
    'begin': Rect.fromLTWH(4, 100, 80, 80),
    'end': Rect.fromLTWH(196, 100, 80, 80),
  },
  <String, dynamic>{
    'label': 'Vertical Slide',
    'begin': Rect.fromLTWH(100, 4, 80, 80),
    'end': Rect.fromLTWH(100, 196, 80, 80),
  },
  <String, dynamic>{
    'label': 'Diagonal Stretch',
    'begin': Rect.fromLTWH(4, 4, 120, 60),
    'end': Rect.fromLTWH(80, 120, 196, 156),
  },
];

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0)),
    ),
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RelativePositionedTransition Deep Demo'),
          backgroundColor: const Color(0xFF5C6BC0),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.amberAccent,
            tabs: <Widget>[
              Tab(text: 'Intro'),
              Tab(text: 'Playground'),
              Tab(text: 'Presets'),
              Tab(text: 'TweenBuilder'),
              Tab(text: 'Curves'),
              Tab(text: 'Multi'),
              Tab(text: 'Compare'),
              Tab(text: 'Diagram'),
              Tab(text: 'API'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _SliderPlaygroundTab(),
            _PresetsTab(),
            _TweenBuilderTab(),
            _CurvesTab(),
            _MultiChildTab(),
            _ComparisonTab(),
            _DiagramTab(),
            _ApiCheatSheetTab(),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

Widget _sectionTitle(String text) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3949AB),
        ),
      ),
    );

Widget _infoCard(String title, String body, {Color? accent}) => Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(color: accent ?? const Color(0xFF5C6BC0), width: 4),
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 6),
            Text(body,
                style: const TextStyle(fontSize: 13, height: 1.5)),
          ],
        ),
      ),
    );

Widget _codeBlock(String code) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: SelectableText(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFF80CBC4),
          height: 1.6,
        ),
      ),
    );

// ---------------------------------------------------------------------------
// Interpolation helper: lerp a Rect at t between begin and end
// ---------------------------------------------------------------------------

Rect _lerpRect(Rect begin, Rect end, double t) {
  return Rect.lerp(begin, end, t)!;
}

// ---------------------------------------------------------------------------
// Tab 1 — Hero Banner
// ---------------------------------------------------------------------------

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        // Hero gradient banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF3F51B5), Color(0xFF9C27B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'RelativePositionedTransition',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Animate a Stack child between two Rect positions (relative to a stack size)',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _chipBadge('AnimatedWidget'),
                  _chipBadge('Animation<Rect?>'),
                  _chipBadge('RectTween'),
                  _chipBadge('Stack'),
                  _chipBadge('Positioned'),
                ],
              ),
            ],
          ),
        ),

        _sectionTitle('What is RelativePositionedTransition?'),
        _infoCard(
          'Core Concept',
          'RelativePositionedTransition extends AnimatedWidget and wraps a '
              'Positioned widget inside a Stack. It takes an Animation<Rect?> '
              'and a Size. Each animation frame, it configures a Positioned '
              'widget using the current Rect interpreted RELATIVE to the given '
              'Size — converting the Rect into left/top/right/bottom values '
              'that the Positioned widget uses.',
          accent: const Color(0xFF5C6BC0),
        ),
        _infoCard(
          'Constructor Signature',
          'RelativePositionedTransition({\n'
              '  Key? key,\n'
              '  required Animation<Rect?> rect,\n'
              '  required Size size,\n'
              '  required Widget child,\n'
              '})\n\n'
              'The rect animation provides Rect values. The size parameter '
              'is the overall size of the Stack parent. Internally, the widget '
              'derives Positioned left/top/right/bottom from:\n'
              '  left   = rect.left\n'
              '  top    = rect.top\n'
              '  right  = size.width  - rect.right\n'
              '  bottom = size.height - rect.bottom',
          accent: const Color(0xFF7986CB),
        ),

        _sectionTitle('Rect Coordinate Model'),
        _infoCard(
          'Rect vs RelativeRect',
          'Despite its name, RelativePositionedTransition uses Animation<Rect?> '
              '— not RelativeRect. The Rect holds absolute coordinates '
              'within the coordinate space defined by the Size parameter. '
              'The "relative" in the name refers to the fact that the '
              'Positioned values are derived relative to the given size, not '
              'that it uses the RelativeRect type.',
          accent: const Color(0xFF26A69A),
        ),
        _infoCard(
          'Rect.fromLTWH(left, top, width, height)',
          'A Rect stores its position as (left, top) and size as '
              '(width, height). For a 300×300 stack:\n\n'
              '  Rect.fromLTWH(0, 0, 100, 100)   → top-left, 100×100\n'
              '  Rect.fromLTWH(200, 200, 100, 100) → bottom-right, 100×100\n'
              '  Rect.fromLTWH(0, 0, 300, 300)   → fills entire stack',
          accent: const Color(0xFFEF5350),
        ),
        _infoCard(
          'How it differs from SlideTransition',
          'SlideTransition uses fractional offsets relative to the widget\'s '
              'own size — great for "fly in from off-screen" effects. '
              'RelativePositionedTransition uses an absolute Rect and a stack '
              'Size, so it can simultaneously change position AND dimensions '
              'of the child widget in one smooth animation.',
          accent: const Color(0xFFFF7043),
        ),

        _sectionTitle('Class Hierarchy'),
        _codeBlock(
          'Object\n'
          ' └─ Widget\n'
          '     └─ StatelessWidget (abstract)\n'
          '         └─ AnimatedWidget   ← listens to Animation<Rect?>\n'
          '             └─ RelativePositionedTransition\n\n'
          '// Internal build logic:\n'
          'Positioned.fromRect(rect: rect.value ?? Rect.zero, child: child)',
        ),

        _sectionTitle('Quick Usage Pattern'),
        _codeBlock(
          'final AnimationController ctrl = AnimationController(\n'
          '  vsync: this, duration: const Duration(seconds: 2));\n\n'
          'final Animation<Rect?> rectAnim = RectTween(\n'
          '  begin: const Rect.fromLTWH(0, 0, 100, 100),\n'
          '  end:   const Rect.fromLTWH(200, 200, 100, 100),\n'
          ').animate(CurvedAnimation(\n'
          '  parent: ctrl, curve: Curves.easeInOut));\n\n'
          'Stack(\n'
          '  children: [\n'
          '    RelativePositionedTransition(\n'
          '      rect: rectAnim,\n'
          '      size: const Size(300, 300), // matches Stack size\n'
          '      child: const FlutterLogo(),\n'
          '    ),\n'
          '  ],\n'
          ')',
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _chipBadge(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(40),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white38),
        ),
        child: Text(label,
            style: const TextStyle(color: Colors.white, fontSize: 12)),
      );
}

// ---------------------------------------------------------------------------
// Tab 2 — Slider Playground
// ---------------------------------------------------------------------------

class _SliderPlaygroundTab extends StatelessWidget {
  const _SliderPlaygroundTab();

  static const Rect _begin = Rect.fromLTWH(4, 4, 80, 80);
  static const Rect _end = Rect.fromLTWH(196, 196, 80, 80);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        _sectionTitle('Interactive Slider Playground'),
        _infoCard(
          'How this works',
          'Drag the slider to set t ∈ [0,1]. We use Rect.lerp(begin, end, t) '
              'to compute the current Rect at this t value. An '
              'AlwaysStoppedAnimation<Rect?> wraps the computed Rect and '
              'feeds it to RelativePositionedTransition, letting you '
              'scrub through the animation frame by frame.',
          accent: const Color(0xFF5C6BC0),
        ),
        const SizedBox(height: 8),

        ValueListenableBuilder<double>(
          valueListenable: _sliderT,
          builder: (BuildContext ctx, double t, Widget? _) {
            final Rect current = _lerpRect(_begin, _end, t);
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      const Text('t = 0', style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Slider(
                          value: t,
                          onChanged: (double v) => _sliderT.value = v,
                          activeColor: const Color(0xFF5C6BC0),
                        ),
                      ),
                      const Text('t = 1', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Text(
                  't = ${t.toStringAsFixed(3)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3949AB),
                      fontSize: 16),
                ),
                const SizedBox(height: 16),

                // Stack preview with ruler guides
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _StackPreviewFixed(currentRect: current),
                ),

                const SizedBox(height: 16),
                _LiveRectDisplay(rect: current),
              ],
            );
          },
        ),

        _sectionTitle('Ruler Guide Legend'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            children: <Widget>[
              _legendItem(Colors.red, 'Left edge'),
              _legendItem(Colors.green, 'Top edge'),
              _legendItem(Colors.blue, 'Right edge'),
              _legendItem(Colors.orange, 'Bottom edge'),
              _legendItem(const Color(0xFF5C6BC0), 'Child rect'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        _sectionTitle('Code: Slider Scrubbing Pattern'),
        _codeBlock(
          '// Compute current rect at t using Rect.lerp\n'
          'final Rect currentRect = Rect.lerp(\n'
          '  const Rect.fromLTWH(4, 4, 80, 80),\n'
          '  const Rect.fromLTWH(196, 196, 80, 80),\n'
          '  t,\n'
          ')!;\n\n'
          '// Wrap as animation\n'
          'AlwaysStoppedAnimation<Rect?>(currentRect)\n\n'
          '// Feed to widget\n'
          'RelativePositionedTransition(\n'
          '  rect: AlwaysStoppedAnimation<Rect?>(currentRect),\n'
          '  size: const Size(280, 280),\n'
          '  child: myChild,\n'
          ')',
        ),
      ],
    );
  }

  Widget _legendItem(Color color, String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 16, height: 4, color: color),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
}

class _StackPreviewFixed extends StatelessWidget {
  const _StackPreviewFixed({required this.currentRect});
  final Rect currentRect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _stackSide,
      height: _stackSide,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3949AB), width: 2),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF5F5F5),
      ),
      child: Stack(
        children: <Widget>[
          // Left guide
          Positioned(
            left: currentRect.left,
            top: 0,
            bottom: 0,
            child: Container(width: 1, color: Colors.red.withAlpha(100)),
          ),
          // Top guide
          Positioned(
            top: currentRect.top,
            left: 0,
            right: 0,
            child: Container(height: 1, color: Colors.green.withAlpha(100)),
          ),
          // Right guide
          Positioned(
            left: currentRect.right,
            top: 0,
            bottom: 0,
            child: Container(width: 1, color: Colors.blue.withAlpha(100)),
          ),
          // Bottom guide
          Positioned(
            top: currentRect.bottom,
            left: 0,
            right: 0,
            child: Container(height: 1, color: Colors.orange.withAlpha(100)),
          ),
          // The animated child
          RelativePositionedTransition(
            rect: AlwaysStoppedAnimation<Rect?>(currentRect),
            size: const Size(_stackSide, _stackSide),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5C6BC0).withAlpha(200),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF1A237E), width: 2),
              ),
              child: const Center(
                child: Text(
                  'child',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveRectDisplay extends StatelessWidget {
  const _LiveRectDisplay({required this.rect});
  final Rect rect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: const Color(0xFF1A1A2E),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Live Rect',
                  style: TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
              const SizedBox(height: 8),
              Text(
                'left   = ${rect.left.toStringAsFixed(1)}\n'
                'top    = ${rect.top.toStringAsFixed(1)}\n'
                'right  = ${rect.right.toStringAsFixed(1)}\n'
                'bottom = ${rect.bottom.toStringAsFixed(1)}\n'
                'width  = ${rect.width.toStringAsFixed(1)}\n'
                'height = ${rect.height.toStringAsFixed(1)}',
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Color(0xFF80CBC4),
                    height: 1.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3 — Presets Showcase
// ---------------------------------------------------------------------------

class _PresetsTab extends StatelessWidget {
  const _PresetsTab();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _presetIndex,
      builder: (BuildContext ctx, int pIdx, Widget? _) {
        return ValueListenableBuilder<double>(
          valueListenable: _sliderT,
          builder: (BuildContext ctx2, double t, Widget? _) {
            final Rect beg = _presets[pIdx]['begin'] as Rect;
            final Rect end = _presets[pIdx]['end'] as Rect;
            final Rect current = _lerpRect(beg, end, t);

            return ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: <Widget>[
                _sectionTitle('Preset Rect Pairs'),
                _infoCard(
                  'Five motion patterns',
                  'Each preset uses a different begin→end Rect pair to produce '
                      'a distinct kind of motion. Select a preset chip, then '
                      'drag the slider to scrub through the animation.',
                  accent: const Color(0xFF5C6BC0),
                ),
                const SizedBox(height: 8),

                // Preset chips
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.generate(
                      _presets.length,
                      (int i) {
                        final bool selected = i == pIdx;
                        return GestureDetector(
                          onTap: () => _presetIndex.value = i,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFF5C6BC0)
                                  : const Color(0xFFE8EAF6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: const Color(0xFF5C6BC0), width: 1.5),
                            ),
                            child: Text(
                              _presets[i]['label'] as String,
                              style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xFF3949AB),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Scrub slider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      const Text('0.0', style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Slider(
                          value: t,
                          onChanged: (double v) => _sliderT.value = v,
                          activeColor: const Color(0xFF5C6BC0),
                        ),
                      ),
                      const Text('1.0', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),

                // Centered preview with fixed stack size
                Center(
                  child: _PresetPreview(
                      presetIdx: pIdx, t: t, currentRect: current),
                ),

                const SizedBox(height: 16),
                _sectionTitle('All Presets at a Glance'),
                ...List<Widget>.generate(_presets.length, (int i) {
                  final Rect b = _presets[i]['begin'] as Rect;
                  final Rect e = _presets[i]['end'] as Rect;
                  return _infoCard(
                    _presets[i]['label'] as String,
                    'begin: LTWH(${b.left.toInt()}, ${b.top.toInt()}, '
                        '${b.width.toInt()}, ${b.height.toInt()})\n'
                        'end:   LTWH(${e.left.toInt()}, ${e.top.toInt()}, '
                        '${e.width.toInt()}, ${e.height.toInt()})',
                    accent: const Color(0xFF7986CB),
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }
}

class _PresetPreview extends StatelessWidget {
  const _PresetPreview({
    required this.presetIdx,
    required this.t,
    required this.currentRect,
  });
  final int presetIdx;
  final double t;
  final Rect currentRect;

  @override
  Widget build(BuildContext context) {
    final Rect beginRect = _presets[presetIdx]['begin'] as Rect;
    final Rect endRect = _presets[presetIdx]['end'] as Rect;

    return Container(
      width: _stackSide,
      height: _stackSide,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3949AB), width: 2),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF3F4FF),
      ),
      child: Stack(
        children: <Widget>[
          // Begin ghost
          Positioned.fromRect(
            rect: beginRect,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo.withAlpha(60), width: 2),
                borderRadius: BorderRadius.circular(4),
                color: Colors.indigo.withAlpha(20),
              ),
              child: const Center(
                child: Text('begin',
                    style: TextStyle(color: Colors.indigo, fontSize: 10)),
              ),
            ),
          ),
          // End ghost
          Positioned.fromRect(
            rect: endRect,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.deepPurple.withAlpha(60), width: 2),
                borderRadius: BorderRadius.circular(4),
                color: Colors.deepPurple.withAlpha(20),
              ),
              child: const Center(
                child: Text('end',
                    style:
                        TextStyle(color: Colors.deepPurple, fontSize: 10)),
              ),
            ),
          ),
          // Animated child
          RelativePositionedTransition(
            rect: AlwaysStoppedAnimation<Rect?>(currentRect),
            size: const Size(_stackSide, _stackSide),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5C6BC0).withAlpha(220),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF3949AB).withAlpha(80),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  't=${t.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
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
// Tab 4 — TweenAnimationBuilder Driver
// ---------------------------------------------------------------------------

class _TweenBuilderTab extends StatelessWidget {
  const _TweenBuilderTab();

  static const Rect _begin = Rect.fromLTWH(4, 4, 80, 80);
  static const Rect _end = Rect.fromLTWH(196, 196, 80, 80);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        _sectionTitle('TweenAnimationBuilder<Rect?>'),
        _infoCard(
          'Stateless animation with TweenAnimationBuilder',
          'TweenAnimationBuilder runs a one-shot animation from begin to end '
              'whenever the target value changes. We toggle a ValueNotifier '
              'to swap begin/end, re-triggering the animation without a '
              'StatefulWidget or AnimationController.',
          accent: const Color(0xFF5C6BC0),
        ),

        _codeBlock(
          'TweenAnimationBuilder<Rect?>(\n'
          '  tween: RectTween(\n'
          '    begin: const Rect.fromLTWH(4, 4, 80, 80),\n'
          '    end:   const Rect.fromLTWH(196, 196, 80, 80),\n'
          '  ),\n'
          '  duration: const Duration(seconds: 2),\n'
          '  curve: Curves.easeInOut,\n'
          '  builder: (context, Rect? rect, child) {\n'
          '    return Stack(\n'
          '      children: [\n'
          '        RelativePositionedTransition(\n'
          '          rect: AlwaysStoppedAnimation<Rect?>(rect),\n'
          '          size: const Size(280, 280),\n'
          '          child: child!,\n'
          '        ),\n'
          '      ],\n'
          '    );\n'
          '  },\n'
          '  child: const FlutterLogo(),\n'
          ')',
        ),

        const SizedBox(height: 8),

        ValueListenableBuilder<bool>(
          valueListenable: _animTrigger,
          builder: (BuildContext ctx, bool trigger, Widget? _) {
            final Rect tweenEnd = trigger ? _end : _begin;
            final Rect tweenBegin = trigger ? _begin : _end;

            return Column(
              children: <Widget>[
                ValueListenableBuilder<Curve>(
                  valueListenable: _selectedCurve,
                  builder: (BuildContext c, Curve curve, Widget? _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TweenAnimationBuilder<Rect?>(
                        tween: RectTween(begin: tweenBegin, end: tweenEnd),
                        duration: const Duration(seconds: 2),
                        curve: curve,
                        builder: (BuildContext ctx2, Rect? rect,
                            Widget? child) {
                          return Container(
                            width: _stackSide,
                            height: _stackSide,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF3949AB), width: 2),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF5F5F5),
                            ),
                            child: Stack(
                              children: <Widget>[
                                RelativePositionedTransition(
                                  rect:
                                      AlwaysStoppedAnimation<Rect?>(rect),
                                  size: const Size(_stackSide, _stackSide),
                                  child: child!,
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xFF5C6BC0),
                                Color(0xFF9C27B0),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.widgets,
                                    color: Colors.white, size: 28),
                                SizedBox(height: 4),
                                Text('Tween',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _animTrigger.value = !_animTrigger.value,
                    icon: const Icon(Icons.play_arrow),
                    label:
                        Text(trigger ? 'Animate Back' : 'Animate Forward'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5C6BC0),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        _sectionTitle('Why TweenAnimationBuilder?'),
        _infoCard(
          'Fully stateless animation driving',
          'TweenAnimationBuilder animates from its current value to the new '
              'end whenever end changes. This avoids a StatefulWidget or '
              'AnimationController entirely. Perfect for presentation demos, '
              'onboarding flows, and data-driven UI transitions.',
          accent: const Color(0xFF26A69A),
        ),
        _infoCard(
          'AlwaysStoppedAnimation<Rect?> bridge',
          'RelativePositionedTransition needs an Animation<Rect?>. Inside '
              'TweenAnimationBuilder\'s builder we receive a plain Rect? '
              'value. We wrap it with AlwaysStoppedAnimation<Rect?> — a '
              'zero-cost wrapper that satisfies the type without any real '
              'animation machinery.',
          accent: const Color(0xFFFF7043),
        ),
        _infoCard(
          'RectTween',
          'RectTween extends Tween<Rect?> and lerps each of the four '
              'Rect components (left, top, right, bottom) independently. '
              'This produces smooth diagonal motion when begin and end '
              'rects have different positions and sizes.',
          accent: const Color(0xFF9C27B0),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5 — Curves Showcase
// ---------------------------------------------------------------------------

class _CurvesTab extends StatelessWidget {
  const _CurvesTab();

  static const List<Map<String, dynamic>> _curveItems =
      <Map<String, dynamic>>[
    <String, dynamic>{'label': 'linear', 'curve': Curves.linear},
    <String, dynamic>{'label': 'easeIn', 'curve': Curves.easeIn},
    <String, dynamic>{'label': 'easeOut', 'curve': Curves.easeOut},
    <String, dynamic>{'label': 'easeInOut', 'curve': Curves.easeInOut},
    <String, dynamic>{'label': 'bounceOut', 'curve': Curves.bounceOut},
    <String, dynamic>{'label': 'elasticOut', 'curve': Curves.elasticOut},
  ];

  static const Rect _begin = Rect.fromLTWH(4, 4, 80, 60);
  static const Rect _end = Rect.fromLTWH(196, 120, 80, 60);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        _sectionTitle('Curves Showcase'),
        _infoCard(
          'How curves affect the animation feel',
          'The same RectTween animated with different Curve instances '
              'produces dramatically different motion feels. Tap a curve '
              'chip to apply it, then press Animate.',
          accent: const Color(0xFF5C6BC0),
        ),

        // Curve chips
        ValueListenableBuilder<Curve>(
          valueListenable: _selectedCurve,
          builder: (BuildContext ctx, Curve selected, Widget? _) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _curveItems.map((Map<String, dynamic> item) {
                  final Curve c = item['curve'] as Curve;
                  final String label = item['label'] as String;
                  final bool isSelected = selected == c;
                  return GestureDetector(
                    onTap: () => _selectedCurve.value = c,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF5C6BC0)
                            : const Color(0xFFE8EAF6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF5C6BC0), width: 1.5),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF3949AB),
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),

        // Animation preview
        ValueListenableBuilder<bool>(
          valueListenable: _animTrigger,
          builder: (BuildContext ctx, bool trigger, Widget? _) {
            return ValueListenableBuilder<Curve>(
              valueListenable: _selectedCurve,
              builder: (BuildContext ctx2, Curve curve, Widget? _) {
                final Rect tweenEnd = trigger ? _end : _begin;
                final Rect tweenBegin = trigger ? _begin : _end;
                return Column(
                  children: <Widget>[
                    Center(
                      child: TweenAnimationBuilder<Rect?>(
                        tween: RectTween(begin: tweenBegin, end: tweenEnd),
                        duration: const Duration(milliseconds: 1500),
                        curve: curve,
                        builder: (BuildContext ctx3, Rect? rect,
                            Widget? child) {
                          return Container(
                            width: _stackSide,
                            height: _stackSide,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF3949AB), width: 2),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF5F5F5),
                            ),
                            child: Stack(
                              children: <Widget>[
                                RelativePositionedTransition(
                                  rect: AlwaysStoppedAnimation<Rect?>(rect),
                                  size: const Size(_stackSide, _stackSide),
                                  child: child!,
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF5C6BC0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.star,
                                color: Colors.white, size: 24),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _animTrigger.value = !_animTrigger.value,
                        icon: const Icon(Icons.play_circle),
                        label: Text(trigger ? 'Reverse' : 'Animate'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5C6BC0),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),

        _sectionTitle('Curve Descriptions'),
        _infoCard('linear',
            'Constant velocity. No easing. Mechanical, uniform feel.'),
        _infoCard('easeIn',
            'Starts slow, then accelerates. Ideal for exits — content leaves with momentum.'),
        _infoCard('easeOut',
            'Starts fast, decelerates to stop. Ideal for entrances — content arrives gently.'),
        _infoCard('easeInOut',
            'Slow start and end, fast middle. Most natural feel for most animations.'),
        _infoCard('bounceOut',
            'Overshoots the target then bounces back. Playful, energetic feel.'),
        _infoCard('elasticOut',
            'Spring-like overshoot with damping. Great for attention-grabbing, springy reveals.'),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6 — Multi-Child Animation
// ---------------------------------------------------------------------------

class _MultiChildTab extends StatelessWidget {
  const _MultiChildTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        _sectionTitle('Multi-Child Simultaneous Animation'),
        _infoCard(
          'Three children, simultaneous motion',
          'Three RelativePositionedTransition widgets animate in a Stack '
              'simultaneously. Each has a different begin→end Rect to produce '
              'a phase-offset visual effect. Drag the slider to scrub all '
              'three at once.',
          accent: const Color(0xFF5C6BC0),
        ),

        ValueListenableBuilder<double>(
          valueListenable: _sliderT,
          builder: (BuildContext ctx, double t, Widget? _) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      const Text('t=0', style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Slider(
                          value: t,
                          onChanged: (double v) => _sliderT.value = v,
                          activeColor: const Color(0xFF5C6BC0),
                        ),
                      ),
                      const Text('t=1', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Center(child: _MultiChildPreview(t: t)),
              ],
            );
          },
        ),

        _sectionTitle('Phase-Offset Rect Strategy'),
        _codeBlock(
          '// Child A: top-left → bottom-right corner\n'
          'final rA = Rect.lerp(\n'
          '  const Rect.fromLTWH(4, 4, 80, 80),\n'
          '  const Rect.fromLTWH(196, 196, 80, 80),\n'
          '  t,\n'
          ');\n\n'
          '// Child B: top-right → bottom-left (opposite diagonal)\n'
          'final rB = Rect.lerp(\n'
          '  const Rect.fromLTWH(196, 4, 80, 80),\n'
          '  const Rect.fromLTWH(4, 196, 80, 80),\n'
          '  t,\n'
          ');\n\n'
          '// Child C: center → full expansion\n'
          'final rC = Rect.lerp(\n'
          '  const Rect.fromLTWH(100, 100, 80, 80),\n'
          '  const Rect.fromLTWH(4, 4, 272, 272),\n'
          '  t,\n'
          ');\n\n'
          '// All three driven simultaneously in one Stack',
        ),

        _sectionTitle('Layering and Z-order'),
        _infoCard(
          'Stack z-order',
          'Children listed later in the Stack children array render on top. '
              'Child C (center expansion) is last so it draws over A and B, '
              'giving a layered depth feel as all three animate together.',
          accent: const Color(0xFF26A69A),
        ),
        _infoCard(
          'Phase offset vs. stagger',
          'True stagger delays each child\'s start time. Phase offset '
              'starts all children simultaneously but gives them different '
              'begin/end Rects — simpler stateless approach that avoids '
              'sequential timing logic.',
          accent: const Color(0xFFFF7043),
        ),
      ],
    );
  }
}

class _MultiChildPreview extends StatelessWidget {
  const _MultiChildPreview({required this.t});
  final double t;

  static const Rect _beginA = Rect.fromLTWH(4, 4, 80, 80);
  static const Rect _endA = Rect.fromLTWH(196, 196, 80, 80);
  static const Rect _beginB = Rect.fromLTWH(196, 4, 80, 80);
  static const Rect _endB = Rect.fromLTWH(4, 196, 80, 80);
  static const Rect _beginC = Rect.fromLTWH(100, 100, 80, 80);
  static const Rect _endC = Rect.fromLTWH(4, 4, 272, 272);

  @override
  Widget build(BuildContext context) {
    final Rect rA = _lerpRect(_beginA, _endA, t);
    final Rect rB = _lerpRect(_beginB, _endB, t);
    final Rect rC = _lerpRect(_beginC, _endC, t);

    return Container(
      width: _stackSide,
      height: _stackSide,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3949AB), width: 2),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF5F5F5),
      ),
      child: Stack(
        children: <Widget>[
          RelativePositionedTransition(
            rect: AlwaysStoppedAnimation<Rect?>(rA),
            size: const Size(_stackSide, _stackSide),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5C6BC0).withAlpha(200),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Text('A',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ),
          RelativePositionedTransition(
            rect: AlwaysStoppedAnimation<Rect?>(rB),
            size: const Size(_stackSide, _stackSide),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0).withAlpha(200),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Text('B',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ),
          RelativePositionedTransition(
            rect: AlwaysStoppedAnimation<Rect?>(rC),
            size: const Size(_stackSide, _stackSide),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF26A69A).withAlpha(160),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Text('C',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 7 — Comparison
// ---------------------------------------------------------------------------

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        _sectionTitle('Animation Widget Comparison'),
        _infoCard(
          'When to use which?',
          'Flutter provides several ways to animate position and size within '
              'a widget tree. Understanding the tradeoffs helps you pick '
              'the right tool for the job.',
          accent: const Color(0xFF5C6BC0),
        ),

        const SizedBox(height: 8),

        _comparisonCard(
          'RelativePositionedTransition',
          const Color(0xFF5C6BC0),
          icon: Icons.all_inclusive,
          pros: <String>[
            'Animates position AND size in one widget',
            'Driven by Animation<Rect?> — full controller support',
            'Works natively with RectTween',
            'Extends AnimatedWidget — efficient, minimal rebuilds',
            'Precise pixel placement via Rect coordinates',
          ],
          cons: <String>[
            'Requires a Stack parent',
            'size parameter must match the Stack\'s layout size',
            'Uses Rect (not RelativeRect) despite the name',
          ],
          useWhen: 'Both position AND size need to change during animation, '
              'or when driving from an AnimationController.',
        ),

        _comparisonCard(
          'AnimatedPositioned',
          const Color(0xFF26A69A),
          icon: Icons.animation,
          pros: <String>[
            'Simple API — set new left/top/width/height values',
            'Implicit animation — no controller needed',
            'Automatically interpolates when values change',
          ],
          cons: <String>[
            'Cannot attach to an external Animation object',
            'Less composable with animation curves and sequences',
            'Always animates to "current" values — no replay',
          ],
          useWhen: 'Simple cases where you just need a positioned child '
              'to slide when its state changes.',
        ),

        _comparisonCard(
          'PositionedTransition',
          const Color(0xFF9C27B0),
          icon: Icons.open_with,
          pros: <String>[
            'Uses RelativeRect — edge-distance model',
            'Driven by Animation<RelativeRect>',
            'Works with RelativeRectTween',
          ],
          cons: <String>[
            'RelativeRect model is less intuitive than Rect',
            'RelativeRect edge distances may be confusing',
          ],
          useWhen: 'When edge-distance semantics (fromLTRB) feel more '
              'natural than absolute Rect coordinates for your layout.',
        ),

        _comparisonCard(
          'SlideTransition',
          const Color(0xFFFF7043),
          icon: Icons.slideshow,
          pros: <String>[
            'Fractional offset — percentage of own widget size',
            'No Stack required',
            'Great for "fly in from off-screen" effects',
            'Composes with other transition widgets',
          ],
          cons: <String>[
            'Cannot change widget size during animation',
            'Offset is fraction of the widget\'s own size, not parent',
            'Cannot target specific pixel positions',
          ],
          useWhen: 'Sliding content in/out of view by fractions of its '
              'own size — page transitions, drawer reveals.',
        ),

        _sectionTitle('Decision Tree'),
        _codeBlock(
          'Need size AND position to change?\n'
          '  → RelativePositionedTransition (Rect model)\n\n'
          'Need edge-distance positioning with animation?\n'
          '  → PositionedTransition (RelativeRect model)\n\n'
          'Simple state-driven position change?\n'
          '  → AnimatedPositioned\n\n'
          'Fly content in from off-screen?\n'
          '  → SlideTransition (fractional offset)\n\n'
          'No Stack, transform-based translation?\n'
          '  → SlideTransition or Transform.translate',
        ),
      ],
    );
  }

  Widget _comparisonCard(
    String title,
    Color accent, {
    required IconData icon,
    required List<String> pros,
    required List<String> cons,
    required String useWhen,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border(left: BorderSide(color: accent, width: 5)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: accent, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: accent)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Pros:',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.green)),
            const SizedBox(height: 4),
            ...pros.map((String p) => _bulletRow('✓', p, Colors.green)),
            const SizedBox(height: 8),
            const Text('Cons:',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.red)),
            const SizedBox(height: 4),
            ...cons.map((String c) => _bulletRow('✗', c, Colors.red)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accent.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.lightbulb_outline, color: accent, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Use when: $useWhen',
                        style:
                            const TextStyle(fontSize: 12, height: 1.5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bulletRow(String bullet, String text, Color color) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(bullet,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            Expanded(
                child: Text(text,
                    style: const TextStyle(fontSize: 12, height: 1.5))),
          ],
        ),
      );
}

// ---------------------------------------------------------------------------
// Tab 8 — Rect Diagram (CustomPainter)
// ---------------------------------------------------------------------------

class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        _sectionTitle('Rect Coordinate Diagram'),
        _infoCard(
          'Understanding how Rect maps to Positioned',
          'RelativePositionedTransition converts the animated Rect into '
              'Positioned values relative to the given Stack Size:\n\n'
              '  left   = rect.left\n'
              '  top    = rect.top\n'
              '  right  = size.width  - rect.right\n'
              '  bottom = size.height - rect.bottom\n\n'
              'This means the Rect\'s right/bottom are distances from the '
              'LEFT and TOP, NOT from the right and bottom edges.',
          accent: const Color(0xFF5C6BC0),
        ),
        const SizedBox(height: 16),

        ValueListenableBuilder<double>(
          valueListenable: _sliderT,
          builder: (BuildContext ctx, double t, Widget? _) {
            final double childLeft = 20 + t * 80;
            final double childTop = 20 + t * 60;
            final double childRight = childLeft + 100 + t * 40;
            final double childBottom = childTop + 80 + t * 40;
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      const Text('Adjust:', style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Slider(
                          value: t,
                          onChanged: (double v) => _sliderT.value = v,
                          activeColor: const Color(0xFF5C6BC0),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: _stackSide + 40,
                    height: _stackSide + 40,
                    child: CustomPaint(
                      painter: _RectDiagramPainter(
                        stackSize: const Size(_stackSide, _stackSide),
                        childRect: Rect.fromLTRB(
                            childLeft, childTop, childRight, childBottom),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        _sectionTitle('Diagram Legend'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            children: <Widget>[
              _legendItem(const Color(0xFF3949AB), 'Stack parent'),
              _legendItem(const Color(0xFF5C6BC0), 'Child Rect'),
              _legendItem(Colors.red, 'rect.left'),
              _legendItem(Colors.green, 'rect.top'),
              _legendItem(Colors.blue, 'size.width - rect.right'),
              _legendItem(Colors.orange, 'size.height - rect.bottom'),
            ],
          ),
        ),

        const SizedBox(height: 16),
        _codeBlock(
          '// A Rect with LTWH(60, 40, 100, 80) in a 280×280 stack:\n'
          '//\n'
          '//   rect.left   = 60     → Positioned left   = 60\n'
          '//   rect.top    = 40     → Positioned top    = 40\n'
          '//   rect.right  = 160    → Positioned right  = 280-160 = 120\n'
          '//   rect.bottom = 120    → Positioned bottom = 280-120 = 160\n'
          '//\n'
          '// So the Positioned widget is:\n'
          '//   left=60, top=40, right=120, bottom=160\n'
          '//   child occupies 100×80 px at offset (60,40)',
        ),

        _sectionTitle('Key Fields'),
        _infoCard('rect.left', 'X coordinate of the left edge.'),
        _infoCard('rect.top', 'Y coordinate of the top edge.'),
        _infoCard('rect.right', 'X coordinate of the right edge (left + width).'),
        _infoCard('rect.bottom', 'Y coordinate of the bottom edge (top + height).'),
        _infoCard('rect.width', 'Horizontal size (right - left).'),
        _infoCard('rect.height', 'Vertical size (bottom - top).'),
        _infoCard('size (constructor param)',
            'The Size of the Stack parent — used to compute Positioned '
                'right and bottom values from rect.right and rect.bottom.'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: color.withAlpha(60),
                  border: Border.all(color: color, width: 2),
                  borderRadius: BorderRadius.circular(3))),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
}

class _RectDiagramPainter extends CustomPainter {
  const _RectDiagramPainter({
    required this.stackSize,
    required this.childRect,
  });
  final Size stackSize;
  final Rect childRect;

  @override
  void paint(Canvas canvas, Size size) {
    const double offsetX = 20;
    const double offsetY = 20;

    canvas.translate(offsetX, offsetY);

    final double sw = stackSize.width;
    final double sh = stackSize.height;

    // Parent background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, sw, sh),
      Paint()..color = const Color(0xFF3949AB).withAlpha(20),
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, sw, sh),
      Paint()
        ..color = const Color(0xFF3949AB)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Child rect fill
    canvas.drawRect(
      childRect,
      Paint()..color = const Color(0xFF5C6BC0).withAlpha(80),
    );
    canvas.drawRect(
      childRect,
      Paint()
        ..color = const Color(0xFF5C6BC0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // Left arrow (rect.left)
    _drawHArrow(canvas, 0, childRect.top + childRect.height / 2,
        childRect.left, childRect.top + childRect.height / 2, Colors.red);
    _drawText(canvas, 'L=${childRect.left.toInt()}',
        Offset(childRect.left / 2, childRect.top + childRect.height / 2 - 14),
        Colors.red);

    // Top arrow (rect.top)
    _drawVArrow(canvas, childRect.left + childRect.width / 2, 0,
        childRect.left + childRect.width / 2, childRect.top, Colors.green);
    _drawText(canvas, 'T=${childRect.top.toInt()}',
        Offset(childRect.left + childRect.width / 2 + 4, childRect.top / 2),
        Colors.green);

    // Right distance arrow (size.width - rect.right)
    final double rightDist = sw - childRect.right;
    if (rightDist > 4) {
      _drawHArrow(canvas, childRect.right, childRect.top + 20, sw,
          childRect.top + 20, Colors.blue);
      _drawText(
          canvas,
          'W-R=${rightDist.toInt()}',
          Offset(childRect.right + 2, childRect.top + 6),
          Colors.blue);
    }

    // Bottom distance arrow (size.height - rect.bottom)
    final double bottomDist = sh - childRect.bottom;
    if (bottomDist > 4) {
      _drawVArrow(canvas, childRect.left + 20, childRect.bottom,
          childRect.left + 20, sh, Colors.orange);
      _drawText(
          canvas,
          'H-B=${bottomDist.toInt()}',
          Offset(childRect.left + 24, childRect.bottom + 4),
          Colors.orange);
    }

    // "child" label
    _drawText(
      canvas,
      'child',
      Offset(
        childRect.left + (childRect.width - 28) / 2,
        childRect.top + (childRect.height - 14) / 2,
      ),
      const Color(0xFF1A237E),
      bold: true,
      size: 14,
    );

    // "Stack" label
    _drawText(canvas, 'Stack', const Offset(4, 4),
        const Color(0xFF3949AB));
  }

  void _drawHArrow(Canvas canvas, double x1, double y, double x2, double yEnd,
      Color color) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x1, y), Offset(x2, yEnd), p);
    // Arrowheads
    canvas.drawLine(Offset(x1, y), Offset(x1 + 6, y - 4), p);
    canvas.drawLine(Offset(x1, y), Offset(x1 + 6, y + 4), p);
    canvas.drawLine(Offset(x2, yEnd), Offset(x2 - 6, yEnd - 4), p);
    canvas.drawLine(Offset(x2, yEnd), Offset(x2 - 6, yEnd + 4), p);
  }

  void _drawVArrow(Canvas canvas, double x, double y1, double xEnd, double y2,
      Color color) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x, y1), Offset(xEnd, y2), p);
    canvas.drawLine(Offset(x, y1), Offset(x - 4, y1 + 6), p);
    canvas.drawLine(Offset(x, y1), Offset(x + 4, y1 + 6), p);
    canvas.drawLine(Offset(xEnd, y2), Offset(xEnd - 4, y2 - 6), p);
    canvas.drawLine(Offset(xEnd, y2), Offset(xEnd + 4, y2 - 6), p);
  }

  void _drawText(Canvas canvas, String text, Offset pos, Color color,
      {bool bold = false, double size = 11}) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(_RectDiagramPainter old) =>
      old.childRect != childRect || old.stackSize != stackSize;
}

// ---------------------------------------------------------------------------
// Tab 9 (index 8) — API Cheat Sheet + Use Cases
// ---------------------------------------------------------------------------

class _ApiCheatSheetTab extends StatelessWidget {
  const _ApiCheatSheetTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: <Widget>[
        _sectionTitle('API Cheat Sheet'),

        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Constructor Parameters',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF3949AB))),
                const SizedBox(height: 12),
                _paramRow('rect', 'Animation<Rect?>', 'required',
                    'Animation driving the child\'s position and size.'),
                _paramRow('size', 'Size', 'required',
                    'Size of the Stack parent. Used to compute '
                        'Positioned right = size.width - rect.right and '
                        'bottom = size.height - rect.bottom.'),
                _paramRow('child', 'Widget', 'required',
                    'The widget to position inside the Stack.'),
                _paramRow('key', 'Key?', 'optional', 'Widget key.'),
              ],
            ),
          ),
        ),

        _codeBlock(
          'RelativePositionedTransition(\n'
          '  rect: myAnimation,              // Animation<Rect?>\n'
          '  size: const Size(300, 300),     // Stack parent size\n'
          '  child: const FlutterLogo(),     // positioned widget\n'
          ')',
        ),

        _sectionTitle('RectTween'),
        _codeBlock(
          'class RectTween extends Tween<Rect?> {\n'
          '  RectTween({Rect? begin, Rect? end})\n\n'
          '  // Lerps each edge independently:\n'
          '  Rect? lerp(double t) {\n'
          '    if (begin == null && end == null) return null;\n'
          '    return Rect.lerp(begin, end, t);\n'
          '  }\n'
          '}\n\n'
          '// Usage:\n'
          'final anim = RectTween(\n'
          '  begin: const Rect.fromLTWH(0, 0, 80, 80),\n'
          '  end:   const Rect.fromLTWH(200, 200, 80, 80),\n'
          ').animate(controller);',
        ),

        _sectionTitle('Common Rect Factories'),
        _codeBlock(
          '// Position + size\n'
          'Rect.fromLTWH(left, top, width, height)\n\n'
          '// All four edges\n'
          'Rect.fromLTRB(left, top, right, bottom)\n\n'
          '// Center + size\n'
          'Rect.fromCenter(center: Offset(cx, cy), width: w, height: h)\n\n'
          '// Two corners\n'
          'Rect.fromPoints(Offset(x1,y1), Offset(x2,y2))\n\n'
          '// Full coverage (zero margins)\n'
          'Rect.fromLTWH(0, 0, stackWidth, stackHeight)\n\n'
          '// Zero size at origin\n'
          'Rect.zero',
        ),

        _sectionTitle('AlwaysStoppedAnimation Bridge'),
        _codeBlock(
          '// When you have a plain Rect? value and need Animation<Rect?>:\n'
          'final Rect? currentRect = Rect.lerp(begin, end, t);\n\n'
          'RelativePositionedTransition(\n'
          '  rect: AlwaysStoppedAnimation<Rect?>(currentRect),\n'
          '  size: stackSize,\n'
          '  child: myChild,\n'
          ')',
        ),

        _sectionTitle('Use Cases — 6 Mini Cards'),
        _useCaseCard(
          'Expanding Card',
          Icons.open_in_full,
          const Color(0xFF5C6BC0),
          'A card begins as a small Rect in one corner. On tap, its Rect '
              'expands to fill the parent Stack. '
              'RelativePositionedTransition smoothly interpolates from '
              'the small Rect to the full-size Rect.',
        ),
        _useCaseCard(
          'Sliding Panel',
          Icons.view_sidebar,
          const Color(0xFF26A69A),
          'A drawer panel starts with a Rect positioned off-screen to the '
              'right (rect.left ≥ stack.width). Animating its rect.left '
              'into view slides it in. Width stays constant while position '
              'changes.',
        ),
        _useCaseCard(
          'Hero Flight Preview',
          Icons.flight_takeoff,
          const Color(0xFF9C27B0),
          'Simulate hero-like transitions within a single screen by '
              'animating a widget from its source Rect (thumbnail) to '
              'its destination Rect (expanded view) inside the same Stack.',
        ),
        _useCaseCard(
          'Game Sprite Movement',
          Icons.sports_esports,
          const Color(0xFFEF5350),
          'Move a sprite from one position to another using RectTween. '
              'Multiple sprites animate simultaneously using independent '
              'animations referencing the same Stack size.',
        ),
        _useCaseCard(
          'Tooltip Anchor',
          Icons.info_outline,
          const Color(0xFFFF7043),
          'A tooltip starts with a zero-size Rect at the anchor point '
              'and expands to its content Rect. The combined position+size '
              'animation gives the tooltip a natural "pop" entrance effect.',
        ),
        _useCaseCard(
          'Picture-in-Picture Video',
          Icons.picture_in_picture,
          const Color(0xFF78909C),
          'A video player begins full-screen (Rect covers entire Stack). '
              'On minimize, it animates to a small PiP Rect in a corner. '
              'The user can tap different corners to change the PiP anchor.',
        ),

        _sectionTitle('Quick Reference'),
        _codeBlock(
          '// Import\n'
          'import \'package:flutter/material.dart\';\n\n'
          '// Widget\n'
          'RelativePositionedTransition  // extends AnimatedWidget\n\n'
          '// Animation type\n'
          'Animation<Rect?>\n\n'
          '// Tween type\n'
          'RectTween  // extends Tween<Rect?>\n\n'
          '// Value type\n'
          'Rect  // immutable; fromLTWH, fromLTRB, fromCenter, fromPoints\n\n'
          '// Stateless bridge\n'
          'AlwaysStoppedAnimation<Rect?>(myRect)\n\n'
          '// With LayoutBuilder (recommended)\n'
          'LayoutBuilder(builder: (ctx, constraints) {\n'
          '  return Stack(children: [\n'
          '    RelativePositionedTransition(\n'
          '      rect: animation,\n'
          '      size: constraints.biggest,  // matches Stack\n'
          '      child: myChild,\n'
          '    ),\n'
          '  ]);\n'
          '})',
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _paramRow(
    String name,
    String type,
    String modifier,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 52,
            child: Text(name,
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF5C6BC0))),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 100,
            child: Text(type,
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFF26A69A))),
          ),
          const SizedBox(width: 4),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(modifier,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF3949AB))),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(description,
                style: const TextStyle(fontSize: 12, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget _useCaseCard(
      String title, IconData icon, Color color, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: color)),
                  const SizedBox(height: 4),
                  Text(description,
                      style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
