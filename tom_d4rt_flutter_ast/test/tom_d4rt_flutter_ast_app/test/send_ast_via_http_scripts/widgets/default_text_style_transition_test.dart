// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =====================================================================
// DefaultTextStyleTransition Deep Demo
// ---------------------------------------------------------------------
// DefaultTextStyleTransition is the explicit, animation-driven cousin of
// AnimatedDefaultTextStyle. Both ultimately install a DefaultTextStyle in
// the widget tree so descendant Text widgets that do not specify their
// own style can pick up the inherited TextStyle. The difference is in
// how the value is updated:
//
//   * AnimatedDefaultTextStyle is an implicitly-animated widget. You
//     change the target style argument by calling setState; Flutter
//     interpolates from the previous value to the new value over the
//     given duration / curve. You do not own a controller; the widget
//     does it for you.
//
//   * DefaultTextStyleTransition is an explicitly-animated widget. You
//     own the AnimationController. You also own the TextStyleTween (or
//     any Animation<TextStyle>) and pass that animation in. The widget
//     subscribes to it and rebuilds the underlying DefaultTextStyle on
//     every tick.
//
// Constructor (Flutter SDK):
//   DefaultTextStyleTransition({
//     Key? key,
//     required Animation<TextStyle> style,
//     required Widget child,
//     TextAlign? textAlign,
//     bool softWrap = true,
//     TextOverflow overflow = TextOverflow.clip,
//     int? maxLines,
//   });
//
// Internally it is an AnimatedWidget that, every time the animation
// notifies, returns a DefaultTextStyle whose `style` is animation.value.
// Descendant Text widgets without an explicit style inherit it.
//
// Inheritance diagram:
//
//   DefaultTextStyleTransition (animation: tween.animate(controller))
//     └── child: SomeContainerOrLayout(
//                   ├── Text('headline')   <-- inherits animated style
//                   ├── Text('body line 1')
//                   └── Text('caption')
//                )
//
// Important contracts:
//
//   1. The Tween used to drive the style must produce TextStyle values.
//      Flutter ships TextStyleTween for exactly this. It uses
//      TextStyle.lerp under the hood, which interpolates per-field.
//
//   2. TextStyle.lerp interpolates color, fontSize, letterSpacing,
//      wordSpacing, height, decorationThickness, etc. by linear
//      interpolation. FontWeight is interpolated stepwise — w400 to
//      w800 will not produce w500 mid-flight, it will snap from one
//      defined weight to another. FontStyle (italic/normal) is also
//      stepwise.
//
//   3. Children must rely on inheritance. If a Text widget passes its
//      own `style:` it will not pick up the animated DefaultTextStyle.
//      Use Text.rich + TextSpan with no style, or plain Text(...) for
//      maximum visual impact.
//
//   4. softWrap, overflow, textAlign and maxLines are NOT animated.
//      They are passed straight through to DefaultTextStyle once.
//
//   5. Like every AnimatedWidget, the demo MUST own an
//      AnimationController. Forgetting to dispose it leaks the ticker.
//      Every State below disposes its controller(s) in dispose().
//
// This file is a hand-authored deep demo with twelve sections plus a
// reference table. Every section has its own State class with its own
// AnimationController. No section reuses another section's controller —
// each is independent so you can read top-to-bottom without keeping
// global state in mind.
// =====================================================================

dynamic build(BuildContext context) {
  print('=== DefaultTextStyleTransition Deep Demo ===');
  print('Sections: 12 (intro, color morph, size morph, weight morph,');
  print('multi-property morph, reverse loop, coordinated children,');
  print('vs AnimatedDefaultTextStyle, hero-like coordinated, recipe');
  print('gallery, pitfalls, reference table).');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DefaultTextStyleTransition Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF1E88E5),
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      appBar: AppBar(
        title: const Text('DefaultTextStyleTransition — Deep Demo'),
        backgroundColor: const Color(0xFF1E88E5),
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
                title: 'Intro — what DefaultTextStyleTransition does',
                subtitle:
                    'Animation<TextStyle> + child = a DefaultTextStyle '
                    'that smoothly morphs as descendant Text widgets '
                    'inherit it.',
              ),
              const _IntroSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 2,
                title: 'Color morph — blue to orange',
                subtitle:
                    'TextStyleTween with only the color field changing. '
                    'A paragraph of inherited Text rows shifts hue in '
                    'lockstep.',
              ),
              const _ColorMorphDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 3,
                title: 'Size morph — fontSize 14 to 32',
                subtitle:
                    'Curves.easeInOut over a TextStyleTween. Three Text '
                    'rows demonstrate consistent inheritance during the '
                    'animation.',
              ),
              const _SizeMorphDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 4,
                title: 'Weight morph — w300 to w800 (stepwise)',
                subtitle:
                    'TextStyle.lerp interpolates FontWeight by snapping '
                    'between the nearest defined weights. The slider '
                    'reveals the discrete steps.',
              ),
              const _WeightMorphDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 5,
                title: 'Multi-property morph — color + size + spacing + style',
                subtitle:
                    'Four properties interpolate simultaneously across '
                    'a 4 second cycle: color, fontSize, letterSpacing, '
                    'fontStyle.',
              ),
              const _MultiPropertyMorphDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 6,
                title: 'Reverse loop — perpetual oscillation',
                subtitle:
                    'controller.repeat(reverse: true) creates an endless '
                    'breathing effect. Pause/resume on demand.',
              ),
              const _ReverseLoopDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 7,
                title: 'Coordinated children — heading, body, caption',
                subtitle:
                    'A single DefaultTextStyleTransition wraps a Column. '
                    'All inherited Text widgets share the animated '
                    'baseline.',
              ),
              const _CoordinatedChildrenDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 8,
                title: 'AnimatedDefaultTextStyle vs DefaultTextStyleTransition',
                subtitle:
                    'Left: setState retargeting. Right: controller-driven '
                    'animation. Same visual language, different control '
                    'flow.',
              ),
              const _ComparisonDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 9,
                title: 'Hero-like coordinated transition',
                subtitle:
                    'Two cards share a single CurvedAnimation. Distinct '
                    'TextStyleTweens animate identically because the '
                    'driver is the same.',
              ),
              const _HeroCoordinatedDemo(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 10,
                title: 'Recipe gallery',
                subtitle:
                    'Header pulse, hover-glow caption, attention error '
                    'label, brand-color sweep — four production-ready '
                    'patterns.',
              ),
              const _RecipeGallery(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 11,
                title: 'Pitfalls and gotchas',
                subtitle:
                    'Five traps that bite first-time users of '
                    'DefaultTextStyleTransition.',
              ),
              const _PitfallsSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                index: 12,
                title: 'Reference table',
                subtitle:
                    'Quick lookup for the eight types most often paired '
                    'with DefaultTextStyleTransition.',
              ),
              const _ReferenceTable(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// Shared section header used by every demo block above.
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
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF1E88E5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              index.toString(),
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
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF101418),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF55606A),
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

// A tiny boxed card used to wrap each demo so the visual rhythm of the
// page is consistent.
class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.child, this.color});

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// A small key-value caption used inside cards to display animation
// progress, current values, etc.
class _Caption extends StatelessWidget {
  const _Caption({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6E7780),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF20262C),
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 1 — Intro
// ---------------------------------------------------------------------
// Static introduction. Shows a fixed DefaultTextStyleTransition that is
// permanently halfway through its animation, plus an annotated diagram
// of how style inheritance flows down the tree.
// =====================================================================
class _IntroSection extends StatefulWidget {
  const _IntroSection();

  @override
  State<_IntroSection> createState() => _IntroSectionState();
}

class _IntroSectionState extends State<_IntroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 16,
        color: Color(0xFF263238),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      end: const TextStyle(
        fontSize: 18,
        color: Color(0xFF1E88E5),
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    // Run a quick forward+reverse loop just so the intro shows life.
    _controller.repeat(reverse: true);
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'A live preview',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF20262C),
            ),
          ),
          const SizedBox(height: 8),
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('All three of these Text widgets inherit the'),
                  Text('animated DefaultTextStyle that is being driven'),
                  Text('above them. Notice they morph in lockstep.'),
                ],
              ),
            ),
          ),
          const Divider(height: 24),
          const Text(
            'How inheritance flows',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF20262C),
            ),
          ),
          const SizedBox(height: 8),
          const _InheritanceDiagram(),
          const SizedBox(height: 12),
          const Text(
            'Take-away: the animation lives in this State class. The '
            'widget tree merely advertises the latest TextStyle to '
            'descendants who choose not to override it.',
            style: TextStyle(fontSize: 12, color: Color(0xFF55606A)),
          ),
        ],
      ),
    );
  }
}

class _InheritanceDiagram extends StatelessWidget {
  const _InheritanceDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E7EE)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'DefaultTextStyleTransition(style: animation)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF1E88E5),
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, top: 4),
            child: Text(
              '└── DefaultTextStyle(style: animation.value)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF20262C),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28, top: 4),
            child: Text(
              '└── child: <your subtree>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF20262C),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 44, top: 4),
            child: Text(
              '├── Text(...)        <-- inherits',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 44, top: 4),
            child: Text(
              '├── Text(...)        <-- inherits',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 44, top: 4),
            child: Text(
              '└── Text(..., style: TextStyle(...))   <-- DOES NOT inherit',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFC62828),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 2 — Color morph
// ---------------------------------------------------------------------
// Pure color animation. Begin: blue. End: orange. The fontSize and
// fontWeight do not change so we can isolate the color interpolation.
// A play button toggles the controller forward/reverse, and a slider
// allows you to scrub the controller manually.
// =====================================================================
class _ColorMorphDemo extends StatefulWidget {
  const _ColorMorphDemo();

  @override
  State<_ColorMorphDemo> createState() => _ColorMorphDemoState();
}

class _ColorMorphDemoState extends State<_ColorMorphDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 16,
        color: Color(0xFF1976D2),
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      end: const TextStyle(
        fontSize: 16,
        color: Color(0xFFEF6C00),
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    ).animate(_controller);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _playing = !_playing;
      if (_playing) {
        if (_controller.value >= 1.0) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing'),
                Text('elit. Sed do eiusmod tempor incididunt ut labore'),
                Text('et dolore magna aliqua. Ut enim ad minim veniam,'),
                Text('quis nostrud exercitation ullamco laboris nisi.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              FilledButton.icon(
                onPressed: _togglePlay,
                icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                label: Text(_playing ? 'Pause' : 'Play'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Slider(
                  value: _controller.value,
                  onChanged: (double v) {
                    setState(() {
                      _playing = false;
                      _controller.stop();
                      _controller.value = v;
                    });
                  },
                ),
              ),
            ],
          ),
          _Caption(label: 't', value: _controller.value.toStringAsFixed(3)),
          _Caption(
            label: 'current.color',
            value: '0x${(_styleAnimation.value.color?.value ?? 0)
                .toRadixString(16).padLeft(8, '0')}',
          ),
          const _Caption(
            label: 'tween',
            value: 'TextStyleTween(blue → orange)',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 3 — Size morph
// ---------------------------------------------------------------------
// Animates fontSize from 14 to 32 with Curves.easeInOut. Three rows of
// inherited Text show how the entire paragraph block expands /
// contracts simultaneously.
// =====================================================================
class _SizeMorphDemo extends StatefulWidget {
  const _SizeMorphDemo();

  @override
  State<_SizeMorphDemo> createState() => _SizeMorphDemoState();
}

class _SizeMorphDemoState extends State<_SizeMorphDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;
  late final CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 14,
        color: Color(0xFF20262C),
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
      end: const TextStyle(
        fontSize: 32,
        color: Color(0xFF20262C),
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    ).animate(_curve);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Heading-ish first line'),
                  SizedBox(height: 4),
                  Text('Body-ish second line'),
                  SizedBox(height: 4),
                  Text('Caption-ish third line'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => _controller.forward(from: 0),
                icon: const Icon(Icons.zoom_out_map),
                label: const Text('14 → 32'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _controller.reverse(from: 1),
                icon: const Icon(Icons.zoom_in_map),
                label: const Text('32 → 14'),
              ),
            ],
          ),
          _Caption(
            label: 'fontSize',
            value: _styleAnimation.value.fontSize?.toStringAsFixed(2) ?? '?',
          ),
          _Caption(label: 'curve', value: 'Curves.easeInOut'),
          _Caption(label: 't', value: _controller.value.toStringAsFixed(3)),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 4 — Weight morph (stepwise)
// ---------------------------------------------------------------------
// FontWeight is interpolated stepwise. We animate from w300 to w800 and
// expose the slider so you can SEE the discrete steps. Below the live
// preview we render a chart with all nine FontWeight values to make the
// stepping visually obvious.
// =====================================================================
class _WeightMorphDemo extends StatefulWidget {
  const _WeightMorphDemo();

  @override
  State<_WeightMorphDemo> createState() => _WeightMorphDemoState();
}

class _WeightMorphDemoState extends State<_WeightMorphDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 22,
        color: Color(0xFF20262C),
        fontWeight: FontWeight.w300,
      ),
      end: const TextStyle(
        fontSize: 22,
        color: Color(0xFF20262C),
        fontWeight: FontWeight.w800,
      ),
    ).animate(_controller);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FontWeight current =
        _styleAnimation.value.fontWeight ?? FontWeight.w400;
    final int weightValue = current.value;

    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Text(
              'The brown fox is feeling heavy today.',
            ),
          ),
          const SizedBox(height: 12),
          Slider(
            value: _controller.value,
            onChanged: (double v) {
              setState(() {
                _controller.stop();
                _controller.value = v;
              });
            },
          ),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => _controller.forward(from: 0),
                icon: const Icon(Icons.east),
                label: const Text('forward'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _controller.reverse(from: 1),
                icon: const Icon(Icons.west),
                label: const Text('reverse'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () =>
                    _controller.repeat(reverse: true, period:
                        const Duration(milliseconds: 2500)),
                icon: const Icon(Icons.loop),
                label: const Text('loop'),
              ),
            ],
          ),
          _Caption(label: 'current.weight', value: 'w$weightValue'),
          _Caption(label: 't', value: _controller.value.toStringAsFixed(3)),
          const SizedBox(height: 8),
          const Divider(height: 16),
          const Text(
            'All nine FontWeight values — observe the discrete steps:',
            style: TextStyle(fontSize: 12, color: Color(0xFF55606A)),
          ),
          const SizedBox(height: 8),
          _WeightLadder(currentWeight: current),
        ],
      ),
    );
  }
}

class _WeightLadder extends StatelessWidget {
  const _WeightLadder({required this.currentWeight});

  final FontWeight currentWeight;

  @override
  Widget build(BuildContext context) {
    const List<FontWeight> ladder = <FontWeight>[
      FontWeight.w100,
      FontWeight.w200,
      FontWeight.w300,
      FontWeight.w400,
      FontWeight.w500,
      FontWeight.w600,
      FontWeight.w700,
      FontWeight.w800,
      FontWeight.w900,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ladder.map((FontWeight w) {
        final bool isActive = w == currentWeight;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 48,
                child: Text(
                  'w${w.value}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: Color(0xFF6E7780),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Sample text',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: w,
                    color: isActive
                        ? const Color(0xFF1E88E5)
                        : const Color(0xFF20262C),
                  ),
                ),
              ),
              if (isActive)
                const Icon(Icons.arrow_left, color: Color(0xFF1E88E5)),
            ],
          ),
        );
      }).toList(growable: false),
    );
  }
}

// =====================================================================
// Section 5 — Multi-property morph
// ---------------------------------------------------------------------
// Animates color + fontSize + letterSpacing + fontStyle in a single
// 4-second cycle so you can see how all properties interpolate at once.
// =====================================================================
class _MultiPropertyMorphDemo extends StatefulWidget {
  const _MultiPropertyMorphDemo();

  @override
  State<_MultiPropertyMorphDemo> createState() =>
      _MultiPropertyMorphDemoState();
}

class _MultiPropertyMorphDemoState extends State<_MultiPropertyMorphDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;
  late final CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 14,
        color: Color(0xFF263238),
        letterSpacing: 0.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      end: const TextStyle(
        fontSize: 24,
        color: Color(0xFF6A1B9A),
        letterSpacing: 2.4,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    ).animate(_curve);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle s = _styleAnimation.value;
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('All four properties move together.'),
                  SizedBox(height: 6),
                  Text('Color, size, letterSpacing, italic.'),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => _controller.forward(from: 0),
                icon: const Icon(Icons.play_arrow),
                label: const Text('play'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _controller.reverse(from: 1),
                icon: const Icon(Icons.replay),
                label: const Text('reverse'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _controller
                    .repeat(reverse: true, period: const Duration(seconds: 4)),
                icon: const Icon(Icons.loop),
                label: const Text('loop'),
              ),
            ],
          ),
          _Caption(
            label: 'fontSize',
            value: s.fontSize?.toStringAsFixed(2) ?? '?',
          ),
          _Caption(
            label: 'color',
            value: '0x${(s.color?.value ?? 0).toRadixString(16)
                .padLeft(8, '0')}',
          ),
          _Caption(
            label: 'letterSpacing',
            value: s.letterSpacing?.toStringAsFixed(3) ?? '?',
          ),
          _Caption(
            label: 'fontStyle',
            value: s.fontStyle?.toString() ?? 'normal',
          ),
          _Caption(label: 't', value: _controller.value.toStringAsFixed(3)),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 6 — Reverse loop
// ---------------------------------------------------------------------
// controller.repeat(reverse: true) creates a perpetual oscillation. A
// pause/resume button shows you can interrupt without losing position.
// =====================================================================
class _ReverseLoopDemo extends StatefulWidget {
  const _ReverseLoopDemo();

  @override
  State<_ReverseLoopDemo> createState() => _ReverseLoopDemoState();
}

class _ReverseLoopDemoState extends State<_ReverseLoopDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  bool _running = true;
  int _cycleCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 18,
        color: Color(0xFF00838F),
        fontWeight: FontWeight.w500,
      ),
      end: const TextStyle(
        fontSize: 22,
        color: Color(0xFFD81B60),
        fontWeight: FontWeight.w700,
      ),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.addStatusListener(_onStatus);
    _controller.repeat(reverse: true);
  }

  void _onStatus(AnimationStatus s) {
    if (s == AnimationStatus.completed || s == AnimationStatus.dismissed) {
      _cycleCount++;
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _running = !_running;
      if (_running) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Text(
                'Breathing… in and out, forever, until you press pause.',
              ),
            ),
          ),
          Row(
            children: <Widget>[
              FilledButton.icon(
                onPressed: _toggle,
                icon: Icon(_running ? Icons.pause : Icons.play_arrow),
                label: Text(_running ? 'Pause' : 'Resume'),
              ),
              const SizedBox(width: 12),
              Text(
                'cycles (incl. reverse halves): $_cycleCount',
                style: const TextStyle(fontSize: 12, color: Color(0xFF55606A)),
              ),
            ],
          ),
          _Caption(label: 'state', value: _running ? 'running' : 'paused'),
          _Caption(
            label: 'mode',
            value: 'controller.repeat(reverse: true)',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 7 — Coordinated children
// ---------------------------------------------------------------------
// Single DefaultTextStyleTransition wrapping a Column of headings, body,
// and caption. They all share the animated baseline. The key insight:
// you can set per-Text overrides for properties that don't animate (like
// FontWeight) while still inheriting the animated ones.
// =====================================================================
class _CoordinatedChildrenDemo extends StatefulWidget {
  const _CoordinatedChildrenDemo();

  @override
  State<_CoordinatedChildrenDemo> createState() =>
      _CoordinatedChildrenDemoState();
}

class _CoordinatedChildrenDemoState extends State<_CoordinatedChildrenDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 14,
        color: Color(0xFF455A64),
        height: 1.35,
        letterSpacing: 0.0,
      ),
      end: const TextStyle(
        fontSize: 18,
        color: Color(0xFF1E88E5),
        height: 1.45,
        letterSpacing: 0.6,
      ),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.addListener(() => setState(() {}));
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'A heading line — inherits everything',
                    // No explicit style. Pulls fontSize, color,
                    // letterSpacing, height all from the animation.
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'A body paragraph that wraps naturally and shares '
                    'the inherited TextStyle. softWrap and overflow are '
                    'taken from DefaultTextStyle (the animated one).',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'A caption — same inherited style',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => _controller.forward(from: 0),
                icon: const Icon(Icons.expand),
                label: const Text('expand'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _controller.reverse(from: 1),
                icon: const Icon(Icons.compress),
                label: const Text('contract'),
              ),
            ],
          ),
          _Caption(
            label: 'children',
            value: 'all 3 Text widgets share the animated baseline',
          ),
          _Caption(label: 't', value: _controller.value.toStringAsFixed(3)),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 8 — Comparison: AnimatedDefaultTextStyle vs
//                          DefaultTextStyleTransition
// ---------------------------------------------------------------------
// Two side-by-side cards. The left uses AnimatedDefaultTextStyle and a
// button that retargets the style with setState. The right uses
// DefaultTextStyleTransition driven by a controller. Same end result;
// different control flow.
// =====================================================================
class _ComparisonDemo extends StatefulWidget {
  const _ComparisonDemo();

  @override
  State<_ComparisonDemo> createState() => _ComparisonDemoState();
}

class _ComparisonDemoState extends State<_ComparisonDemo>
    with SingleTickerProviderStateMixin {
  // Right-hand side controller / animation.
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  // Left-hand side: implicit style toggling.
  bool _bigOnLeft = false;

  static const TextStyle _smallStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF20262C),
    fontWeight: FontWeight.w400,
  );
  static const TextStyle _bigStyle = TextStyle(
    fontSize: 22,
    color: Color(0xFFC2185B),
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _styleAnimation = TextStyleTween(begin: _smallStyle, end: _bigStyle)
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: _buildLeft()),
        const SizedBox(width: 12),
        Expanded(child: _buildRight()),
      ],
    );
  }

  Widget _buildLeft() {
    return _DemoCard(
      color: const Color(0xFFFFF3E0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'AnimatedDefaultTextStyle',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const Text(
            'setState(retarget)',
            style: TextStyle(fontSize: 11, color: Color(0xFF55606A)),
          ),
          const SizedBox(height: 8),
          AnimatedDefaultTextStyle(
            style: _bigOnLeft ? _bigStyle : _smallStyle,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: const Text('Implicitly animated text'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() => _bigOnLeft = !_bigOnLeft),
            child: Text(_bigOnLeft ? 'shrink' : 'enlarge'),
          ),
        ],
      ),
    );
  }

  Widget _buildRight() {
    return _DemoCard(
      color: const Color(0xFFE3F2FD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'DefaultTextStyleTransition',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const Text(
            'controller-driven',
            style: TextStyle(fontSize: 11, color: Color(0xFF55606A)),
          ),
          const SizedBox(height: 8),
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Text('Explicitly animated text'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (_controller.value < 0.5) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: Text(_controller.value < 0.5 ? 'enlarge' : 'shrink'),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 9 — Hero-like coordinated transition
// ---------------------------------------------------------------------
// Two separate DefaultTextStyleTransition widgets, each with its own
// TextStyleTween, BUT both fed by the same CurvedAnimation. Result: the
// style transitions are perfectly synced, even though the begin/end
// styles differ between cards.
// =====================================================================
class _HeroCoordinatedDemo extends StatefulWidget {
  const _HeroCoordinatedDemo();

  @override
  State<_HeroCoordinatedDemo> createState() =>
      _HeroCoordinatedDemoState();
}

class _HeroCoordinatedDemoState extends State<_HeroCoordinatedDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _shared;
  late final Animation<TextStyle> _leftAnim;
  late final Animation<TextStyle> _rightAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _shared = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _leftAnim = TextStyleTween(
      begin: const TextStyle(
        fontSize: 14,
        color: Color(0xFF20262C),
        fontWeight: FontWeight.w400,
      ),
      end: const TextStyle(
        fontSize: 22,
        color: Color(0xFF1B5E20),
        fontWeight: FontWeight.w700,
      ),
    ).animate(_shared);
    _rightAnim = TextStyleTween(
      begin: const TextStyle(
        fontSize: 14,
        color: Color(0xFF20262C),
        fontWeight: FontWeight.w400,
      ),
      end: const TextStyle(
        fontSize: 22,
        color: Color(0xFFB71C1C),
        fontWeight: FontWeight.w700,
      ),
    ).animate(_shared);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _shared.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DefaultTextStyleTransition(
                    style: _leftAnim,
                    child: const Text('Card A — green sweep'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DefaultTextStyleTransition(
                    style: _rightAnim,
                    child: const Text('Card B — red sweep'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              FilledButton.icon(
                onPressed: () => _controller.forward(from: 0),
                icon: const Icon(Icons.play_arrow),
                label: const Text('play in sync'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _controller.reverse(from: 1),
                icon: const Icon(Icons.replay),
                label: const Text('reverse'),
              ),
            ],
          ),
          _Caption(
            label: 'shared driver',
            value: 'CurvedAnimation(controller, easeInOutCubic)',
          ),
          _Caption(
            label: 'left tween',
            value: 'TextStyleTween(small grey → big green)',
          ),
          _Caption(
            label: 'right tween',
            value: 'TextStyleTween(small grey → big red)',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 10 — Recipe gallery
// ---------------------------------------------------------------------
// Four bite-sized recipes that are common in real apps:
//   * header pulse
//   * hover-glow caption
//   * attention-seeking error label
//   * brand-color sweep
// Each lives in its own State to keep concerns separated.
// =====================================================================
class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _HeaderPulseRecipe(),
        SizedBox(height: 12),
        _HoverGlowCaptionRecipe(),
        SizedBox(height: 12),
        _AttentionErrorLabelRecipe(),
        SizedBox(height: 12),
        _BrandColorSweepRecipe(),
      ],
    );
  }
}

class _HeaderPulseRecipe extends StatefulWidget {
  const _HeaderPulseRecipe();

  @override
  State<_HeaderPulseRecipe> createState() => _HeaderPulseRecipeState();
}

class _HeaderPulseRecipeState extends State<_HeaderPulseRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 22,
        color: Color(0xFF20262C),
        fontWeight: FontWeight.w700,
      ),
      end: const TextStyle(
        fontSize: 26,
        color: Color(0xFF1E88E5),
        fontWeight: FontWeight.w700,
      ),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'recipe.headerPulse',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF6E7780),
            ),
          ),
          const SizedBox(height: 4),
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Text('Welcome back!'),
          ),
        ],
      ),
    );
  }
}

class _HoverGlowCaptionRecipe extends StatefulWidget {
  const _HoverGlowCaptionRecipe();

  @override
  State<_HoverGlowCaptionRecipe> createState() =>
      _HoverGlowCaptionRecipeState();
}

class _HoverGlowCaptionRecipeState extends State<_HoverGlowCaptionRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 12,
        color: Color(0xFF6E7780),
        letterSpacing: 0.0,
      ),
      end: const TextStyle(
        fontSize: 13,
        color: Color(0xFF8E24AA),
        letterSpacing: 0.6,
      ),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setHover(bool h) {
    setState(() {
      _hovered = h;
      if (h) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: _DemoCard(
        color: _hovered
            ? const Color(0xFFF3E5F5)
            : const Color(0xFFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'recipe.hoverGlowCaption',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF6E7780),
              ),
            ),
            const SizedBox(height: 4),
            DefaultTextStyleTransition(
              style: _styleAnimation,
              child: const Text(
                'hover me to see the caption glow & tighten',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttentionErrorLabelRecipe extends StatefulWidget {
  const _AttentionErrorLabelRecipe();

  @override
  State<_AttentionErrorLabelRecipe> createState() =>
      _AttentionErrorLabelRecipeState();
}

class _AttentionErrorLabelRecipeState
    extends State<_AttentionErrorLabelRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;
  bool _on = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _styleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 13,
        color: Color(0xFF6E7780),
        fontWeight: FontWeight.w500,
      ),
      end: const TextStyle(
        fontSize: 15,
        color: Color(0xFFE53935),
        fontWeight: FontWeight.w800,
      ),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _on = !_on;
      if (_on) {
        _controller.forward(from: 0);
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'recipe.attentionErrorLabel',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF6E7780),
            ),
          ),
          const SizedBox(height: 4),
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Text('Form has unresolved errors'),
          ),
          const SizedBox(height: 6),
          ElevatedButton.icon(
            onPressed: _toggle,
            icon: Icon(_on ? Icons.cancel : Icons.error),
            label: Text(_on ? 'clear errors' : 'show errors'),
          ),
        ],
      ),
    );
  }
}

class _BrandColorSweepRecipe extends StatefulWidget {
  const _BrandColorSweepRecipe();

  @override
  State<_BrandColorSweepRecipe> createState() =>
      _BrandColorSweepRecipeState();
}

class _BrandColorSweepRecipeState extends State<_BrandColorSweepRecipe>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<TextStyle> _styleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _styleAnimation = TweenSequence<TextStyle>(<TweenSequenceItem<TextStyle>>[
      TweenSequenceItem<TextStyle>(
        tween: TextStyleTween(
          begin: const TextStyle(
            fontSize: 18,
            color: Color(0xFFE53935),
            fontWeight: FontWeight.w700,
          ),
          end: const TextStyle(
            fontSize: 18,
            color: Color(0xFFFB8C00),
            fontWeight: FontWeight.w700,
          ),
        ),
        weight: 1,
      ),
      TweenSequenceItem<TextStyle>(
        tween: TextStyleTween(
          begin: const TextStyle(
            fontSize: 18,
            color: Color(0xFFFB8C00),
            fontWeight: FontWeight.w700,
          ),
          end: const TextStyle(
            fontSize: 18,
            color: Color(0xFF43A047),
            fontWeight: FontWeight.w700,
          ),
        ),
        weight: 1,
      ),
      TweenSequenceItem<TextStyle>(
        tween: TextStyleTween(
          begin: const TextStyle(
            fontSize: 18,
            color: Color(0xFF43A047),
            fontWeight: FontWeight.w700,
          ),
          end: const TextStyle(
            fontSize: 18,
            color: Color(0xFF1E88E5),
            fontWeight: FontWeight.w700,
          ),
        ),
        weight: 1,
      ),
      TweenSequenceItem<TextStyle>(
        tween: TextStyleTween(
          begin: const TextStyle(
            fontSize: 18,
            color: Color(0xFF1E88E5),
            fontWeight: FontWeight.w700,
          ),
          end: const TextStyle(
            fontSize: 18,
            color: Color(0xFF8E24AA),
            fontWeight: FontWeight.w700,
          ),
        ),
        weight: 1,
      ),
      TweenSequenceItem<TextStyle>(
        tween: TextStyleTween(
          begin: const TextStyle(
            fontSize: 18,
            color: Color(0xFF8E24AA),
            fontWeight: FontWeight.w700,
          ),
          end: const TextStyle(
            fontSize: 18,
            color: Color(0xFFE53935),
            fontWeight: FontWeight.w700,
          ),
        ),
        weight: 1,
      ),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'recipe.brandColorSweep',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF6E7780),
            ),
          ),
          const SizedBox(height: 4),
          DefaultTextStyleTransition(
            style: _styleAnimation,
            child: const Text('Cycles through five brand hues forever'),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 11 — Pitfalls
// ---------------------------------------------------------------------
// Five common mistakes shown as numbered cards.
// =====================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _PitfallCard(
          number: 1,
          title: 'Children must rely on inheritance',
          body: 'If your child Text passes its own `style:` argument it '
              'will not pick up the animated DefaultTextStyle. Either '
              'omit style entirely, or use Text.rich with a TextSpan '
              'whose style is null.',
        ),
        SizedBox(height: 8),
        _PitfallCard(
          number: 2,
          title: 'Curves apply to the whole TextStyle, not per-field',
          body: 'TextStyleTween + Curves.easeInOut interpolates every '
              'field against the same t value. You cannot give fontSize '
              'one curve and color a different one without authoring '
              'multiple animations or using a custom Tween.',
        ),
        SizedBox(height: 8),
        _PitfallCard(
          number: 3,
          title: 'FontWeight (and FontStyle) are stepwise',
          body: 'TextStyle.lerp interpolates FontWeight by snapping to '
              'the nearest defined weight. Do not expect smooth '
              '"in-between" weights at half-progress.',
        ),
        SizedBox(height: 8),
        _PitfallCard(
          number: 4,
          title: 'softWrap, overflow, maxLines do NOT animate',
          body: 'Those parameters are passed straight to the underlying '
              'DefaultTextStyle once. If you need them to change you '
              'must rebuild a new DefaultTextStyleTransition with new '
              'values.',
        ),
        SizedBox(height: 8),
        _PitfallCard(
          number: 5,
          title: 'Wrapping each list item in its own transition is wasteful',
          body: 'If you have many rows that all animate together, wrap '
              'the parent ONCE. For finer control over rebuild scope, '
              'consider ListenableBuilder around the controller and '
              'build only the dependent subtree.',
        ),
      ],
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
    return _DemoCard(
      color: const Color(0xFFFFF8E1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF9A825),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF20262C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF55606A),
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
}

// =====================================================================
// Section 12 — Reference table
// ---------------------------------------------------------------------
// Quick lookup for the eight types most often paired with
// DefaultTextStyleTransition.
// =====================================================================
class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>[
        'DefaultTextStyleTransition',
        'AnimatedWidget that rebuilds DefaultTextStyle on each tick of '
            'an Animation<TextStyle>.',
      ],
      <String>[
        'DefaultTextStyle',
        'Inherited widget. Provides a default TextStyle to descendant '
            'Text widgets that omit their own style.',
      ],
      <String>[
        'AnimatedDefaultTextStyle',
        'Implicitly-animated counterpart. You change the style argument '
            'via setState, it interpolates internally.',
      ],
      <String>[
        'TextStyleTween',
        'Tween<TextStyle> using TextStyle.lerp. Most common driver.',
      ],
      <String>[
        'TextStyle',
        'Immutable description of font appearance. Fields lerp '
            'independently, except FontWeight / FontStyle which step.',
      ],
      <String>[
        'AnimationController',
        'Owns the t value and lifecycle. forward / reverse / repeat / '
            'stop / dispose.',
      ],
      <String>[
        'CurvedAnimation',
        'Wraps an Animation<double> and applies a Curve. Compose with '
            'TextStyleTween.animate(curvedAnimation).',
      ],
      <String>[
        'Tween',
        'Generic begin → end interpolator. TextStyleTween extends it '
            'with TextStyle.lerp built in.',
      ],
    ];

    return _DemoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            _ReferenceRow(
              type: rows[i][0],
              description: rows[i][1],
              isLast: i == rows.length - 1,
            ),
        ],
      ),
    );
  }
}

class _ReferenceRow extends StatelessWidget {
  const _ReferenceRow({
    required this.type,
    required this.description,
    required this.isLast,
  });

  final String type;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFE2E7EE)),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF1E88E5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF20262C),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// END OF FILE — DefaultTextStyleTransition Deep Demo
// ---------------------------------------------------------------------
// Recap of the twelve sections:
//   1. Intro              — what the widget does, inheritance diagram
//   2. Color morph        — pure color animation, blue → orange
//   3. Size morph         — fontSize 14 → 32, easeInOut
//   4. Weight morph       — w300 → w800, stepwise interpolation
//   5. Multi-property     — color + fontSize + letterSpacing + style
//   6. Reverse loop       — controller.repeat(reverse: true)
//   7. Coordinated kids   — heading + body + caption inherit together
//   8. vs AnimatedDTS     — implicit (setState) vs explicit (controller)
//   9. Hero coordinated   — two cards share one CurvedAnimation
//  10. Recipe gallery     — pulse, hover-glow, error label, sweep
//  11. Pitfalls           — five traps and how to avoid them
//  12. Reference table    — DefaultTextStyleTransition and friends
// ---------------------------------------------------------------------
// Every State above owns exactly the controllers and CurvedAnimations
// it needs and disposes them in dispose(). Nothing leaks. Nothing is
// shared across sections, so you can read top-to-bottom or skip into
// any section without surprises.
// =====================================================================
