import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DefaultTextStyleTransitionDemoApp();
}

class _DefaultTextStyleTransitionDemoApp extends StatelessWidget {
  const _DefaultTextStyleTransitionDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0C6178)),
        useMaterial3: true,
      ),
      home: const _DefaultTextStyleTransitionDemoPage(),
    );
  }
}

class _DefaultTextStyleTransitionDemoPage extends StatefulWidget {
  const _DefaultTextStyleTransitionDemoPage();

  @override
  State<_DefaultTextStyleTransitionDemoPage> createState() => _DefaultTextStyleTransitionDemoPageState();
}

class _DefaultTextStyleTransitionDemoPageState extends State<_DefaultTextStyleTransitionDemoPage>
    with TickerProviderStateMixin {
  late final AnimationController _heroController;
  late final AnimationController _brandController;
  late final AnimationController _nestedOuterController;
  late final AnimationController _nestedInnerController;
  late final AnimationController _overflowController;

  late final Animation<TextStyle> _heroStyle;
  late final Animation<TextStyle> _brandStyle;
  late final Animation<TextStyle> _nestedOuterStyle;
  late final Animation<TextStyle> _nestedInnerStyle;
  late final Animation<TextStyle> _overflowStyle;

  bool _isAnimating = true;
  double _speedFactor = 1.0;

  @override
  void initState() {
    super.initState();

    _heroController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600));
    _brandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3400));
    _nestedOuterController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2800));
    _nestedInnerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1700));
    _overflowController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));

    _heroStyle = TextStyleTween(
      begin: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w300,
        color: Color(0xFF1E3A5F),
        letterSpacing: 0.0,
      ),
      end: const TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0C6178),
        letterSpacing: 0.9,
      ),
    ).animate(CurvedAnimation(parent: _heroController, curve: Curves.easeInOutCubic));

    _brandStyle = TextStyleTween(
      begin: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Color(0xFF5C3F72),
        height: 1.45,
      ),
      end: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: Color(0xFFE16B4E),
        height: 1.2,
      ),
    ).animate(CurvedAnimation(parent: _brandController, curve: Curves.easeInOut));

    _nestedOuterStyle = TextStyleTween(
      begin: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF2B6A64),
        height: 1.35,
      ),
      end: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0E6478),
        height: 1.15,
      ),
    ).animate(CurvedAnimation(parent: _nestedOuterController, curve: Curves.easeInOutSine));

    _nestedInnerStyle = TextStyleTween(
      begin: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Color(0xFF7A5A3F),
      ),
      end: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Color(0xFF6C5AA2),
      ),
    ).animate(CurvedAnimation(parent: _nestedInnerController, curve: Curves.elasticInOut));

    _overflowStyle = TextStyleTween(
      begin: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF384A56),
        height: 1.45,
      ),
      end: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0C6178),
        height: 1.05,
      ),
    ).animate(CurvedAnimation(parent: _overflowController, curve: Curves.easeInOutCubic));

    _startAllAnimations();
  }

  void _startAllAnimations() {
    _heroController.repeat(reverse: true);
    _brandController.repeat(reverse: true);
    _nestedOuterController.repeat(reverse: true);
    _nestedInnerController.repeat(reverse: true);
    _overflowController.repeat(reverse: true);
    _isAnimating = true;
  }

  void _stopAllAnimations() {
    _heroController.stop();
    _brandController.stop();
    _nestedOuterController.stop();
    _nestedInnerController.stop();
    _overflowController.stop();
    _isAnimating = false;
  }

  void _applySpeed(double factor) {
    setState(() {
      _speedFactor = factor;
      _heroController.duration = Duration(milliseconds: (2600 / factor).round());
      _brandController.duration = Duration(milliseconds: (3400 / factor).round());
      _nestedOuterController.duration = Duration(milliseconds: (2800 / factor).round());
      _nestedInnerController.duration = Duration(milliseconds: (1700 / factor).round());
      _overflowController.duration = Duration(milliseconds: (2200 / factor).round());

      if (_isAnimating) {
        _startAllAnimations();
      }
    });
  }

  @override
  void dispose() {
    _heroController.dispose();
    _brandController.dispose();
    _nestedOuterController.dispose();
    _nestedInnerController.dispose();
    _overflowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cOcean = Color(0xFF0C6178);
    const cCoral = Color(0xFFE16B4E);
    const cForest = Color(0xFF2B6A64);
    const cViolet = Color(0xFF6C5AA2);
    const cSlate = Color(0xFF324652);
    const cSand = Color(0xFFF6F3EB);

    return Scaffold(
      backgroundColor: cSand,
      appBar: AppBar(
        backgroundColor: cOcean,
        foregroundColor: Colors.white,
        toolbarHeight: 74,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DefaultTextStyleTransition Deep Demo'),
            SizedBox(height: 2),
            Text(
              'Animated default typography for descendant text widgets',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroBanner(
              heroStyle: _heroStyle,
              brandStyle: _brandStyle,
              isAnimating: _isAnimating,
              speedFactor: _speedFactor,
              onToggle: () {
                setState(() {
                  if (_isAnimating) {
                    _stopAllAnimations();
                  } else {
                    _startAllAnimations();
                  }
                });
              },
              onSpeedChanged: _applySpeed,
            ),
            const SizedBox(height: 14),
            const _ScenePanel(
              index: 1,
              title: 'Concept and API Surface',
              subtitle:
                  'DefaultTextStyleTransition is an AnimatedWidget that rebuilds DefaultTextStyle from Animation<TextStyle>.',
              accent: cOcean,
              child: _ConceptScene(),
            ),
            const SizedBox(height: 12),
            _ScenePanel(
              index: 2,
              title: 'Core Transition Lab',
              subtitle:
                  'Explicit TextStyle tween drives a full typography morph across title, body, and callout descendants.',
              accent: cCoral,
              child: _CoreTransitionScene(style: _heroStyle),
            ),
            const SizedBox(height: 12),
            _ScenePanel(
              index: 3,
              title: 'Descendant Propagation and Inheritance',
              subtitle:
                  'One DefaultTextStyleTransition animates multiple descendants with local style overrides layered intentionally.',
              accent: cForest,
              child: _PropagationScene(style: _brandStyle),
            ),
            const SizedBox(height: 12),
            _ScenePanel(
              index: 4,
              title: 'Nested Transitions',
              subtitle:
                  'Outer and inner transitions animate at different rhythms to demonstrate hierarchical typography timelines.',
              accent: cViolet,
              child: _NestedTransitionScene(
                outerStyle: _nestedOuterStyle,
                innerStyle: _nestedInnerStyle,
              ),
            ),
            const SizedBox(height: 12),
            _ScenePanel(
              index: 5,
              title: 'maxLines, overflow, and textAlign Behavior',
              subtitle:
                  'Transitioning styles under width constraints reveals how overflow and line limits interact with animated text metrics.',
              accent: cSlate,
              child: _OverflowScene(style: _overflowStyle),
            ),
            const SizedBox(height: 12),
            _ScenePanel(
              index: 6,
              title: 'Practical Module Architecture',
              subtitle:
                  'Feature cards share reusable text widgets while each module applies its own explicit style transition animation.',
              accent: const Color(0xFF7A5A3B),
              child: _ArchitectureScene(
                heroStyle: _heroStyle,
                brandStyle: _brandStyle,
                overflowStyle: _overflowStyle,
              ),
            ),
            const SizedBox(height: 16),
            const _RecapCard(),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.heroStyle,
    required this.brandStyle,
    required this.isAnimating,
    required this.speedFactor,
    required this.onToggle,
    required this.onSpeedChanged,
  });

  final Animation<TextStyle> heroStyle;
  final Animation<TextStyle> brandStyle;
  final bool isAnimating;
  final double speedFactor;
  final VoidCallback onToggle;
  final ValueChanged<double> onSpeedChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0C6178),
            Color(0xFF31859A),
            Color(0xFF6C5AA2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyleTransition(
            style: heroStyle,
            child: const Text('DefaultTextStyleTransition'),
          ),
          const SizedBox(height: 8),
          DefaultTextStyleTransition(
            style: brandStyle,
            child: const Text(
              'Animate inherited typography explicitly with Animation<TextStyle>.\n'
              'Ideal when style changes are synchronized with controllers, timelines, or choreography.',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              FilledButton.icon(
                onPressed: onToggle,
                icon: Icon(isAnimating ? Icons.pause : Icons.play_arrow),
                label: Text(isAnimating ? 'Pause' : 'Resume'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Speed: ${speedFactor.toStringAsFixed(2)}x',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    Slider(
                      value: speedFactor,
                      min: 0.5,
                      max: 2.0,
                      divisions: 6,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withValues(alpha: 0.3),
                      onChanged: onSpeedChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _HeroTag(label: 'AnimatedWidget'),
              _HeroTag(label: 'Animation<TextStyle>'),
              _HeroTag(label: 'Inherited text style'),
              _HeroTag(label: 'Explicit controller timing'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.28)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$index',
                  style: TextStyle(color: accent, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.8)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'DefaultTextStyleTransition is best when you already have an animation timeline and want text style changes to follow it exactly.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _ConceptCard(
              title: 'Input model',
              accent: Color(0xFF0C6178),
              body:
                  'Takes Animation<TextStyle> style and wraps descendants with a DefaultTextStyle built from style.value each frame.',
            ),
            _ConceptCard(
              title: 'When to use',
              accent: Color(0xFFE16B4E),
              body:
                  'Use when synchronizing text style with shared controllers, chained curves, or scene choreography.',
            ),
            _ConceptCard(
              title: 'Related widget',
              accent: Color(0xFF2B6A64),
              body:
                  'AnimatedDefaultTextStyle is simpler for implicit one-off changes, but offers less timeline control.',
            ),
            _ConceptCard(
              title: 'Key properties',
              accent: Color(0xFF6C5AA2),
              body: 'You can also set textAlign, softWrap, overflow, and maxLines on the transitioned default style.',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F7FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFBCD2DD)),
          ),
          child: const SelectableText(
            'DefaultTextStyleTransition(\n'
            '  style: textStyleAnimation,\n'
            '  maxLines: 2,\n'
            '  overflow: TextOverflow.ellipsis,\n'
            '  child: Column(\n'
            '    children: [Text("Title"), Text("Body")],\n'
            '  ),\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard({required this.title, required this.accent, required this.body});

  final String title;
  final Color accent;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 298,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.27)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 6),
            Text(body, style: const TextStyle(fontSize: 11.7, height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _CoreTransitionScene extends StatelessWidget {
  const _CoreTransitionScene({required this.style});

  final Animation<TextStyle> style;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyleTransition(
      style: style,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5F1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFF2C2B4)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Live Typography Morph'),
            SizedBox(height: 6),
            Text('Every descendant Text in this block inherits animated style values frame by frame.'),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text('Headline slot')),
                Expanded(child: Text('Metric slot')),
                Expanded(child: Text('Status slot')),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Use explicit transition control when animation timing must align with route transitions, chart updates, or staged narrative reveals.',
            ),
          ],
        ),
      ),
    );
  }
}

class _PropagationScene extends StatelessWidget {
  const _PropagationScene({required this.style});

  final Animation<TextStyle> style;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyleTransition(
      style: style,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF2FBF8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC2E8DC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Propagation Matrix'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFBDE0D4)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inherited block A'),
                        SizedBox(height: 4),
                        Text('All fields animate as descendants.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFBDE0D4)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inherited block B'),
                        SizedBox(height: 4),
                        Text('Great for consistent section rhythm.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Local override sample:',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            const Text(
              'This line is inherited, while the badge below overrides only color and weight.',
            ),
            const SizedBox(height: 6),
            Text(
              'LOCAL BADGE OVERRIDE',
              style: DefaultTextStyle.of(context).style.copyWith(
                    color: const Color(0xFF0C6178),
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NestedTransitionScene extends StatelessWidget {
  const _NestedTransitionScene({
    required this.outerStyle,
    required this.innerStyle,
  });

  final Animation<TextStyle> outerStyle;
  final Animation<TextStyle> innerStyle;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyleTransition(
      style: outerStyle,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F2FC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD5CBEB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Outer Transition Layer'),
            const SizedBox(height: 6),
            const Text('This paragraph follows the outer timeline.'),
            const SizedBox(height: 10),
            DefaultTextStyleTransition(
              style: innerStyle,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD5CBEB)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Inner Transition Layer'),
                    SizedBox(height: 4),
                    Text(
                      'Inner animation has a faster controller and stronger style delta. '
                      'Nested transitions are useful for emphasizing selected words or values while keeping outer context animated.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverflowScene extends StatelessWidget {
  const _OverflowScene({required this.style});

  final Animation<TextStyle> style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Both cards use the same animated style but different overflow and maxLines parameters on DefaultTextStyleTransition.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 300,
              child: DefaultTextStyleTransition(
                style: style,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F7FA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFC8D4DB)),
                  ),
                  child: const Text(
                    'Ellipsis mode: this sentence is intentionally long so that line constraints and animated font size produce visible truncation behavior.',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: DefaultTextStyleTransition(
                style: style,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.fade,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F7FA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFC8D4DB)),
                  ),
                  child: const Text(
                    'Fade mode: centered multi-line copy under animated typography. Useful for cards where style changes should preserve composition constraints.',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ArchitectureScene extends StatelessWidget {
  const _ArchitectureScene({
    required this.heroStyle,
    required this.brandStyle,
    required this.overflowStyle,
  });

  final Animation<TextStyle> heroStyle;
  final Animation<TextStyle> brandStyle;
  final Animation<TextStyle> overflowStyle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _ModuleCard(
          title: 'Operations module',
          accent: const Color(0xFF0C6178),
          style: heroStyle,
          body:
              'Operations uses a higher-contrast style transition for status readability. Shared text widgets are unchanged.',
        ),
        _ModuleCard(
          title: 'Creative module',
          accent: const Color(0xFFE16B4E),
          style: brandStyle,
          body:
              'Creative uses expressive weight and color transitions to emphasize editorial checkpoints and narrative flow.',
        ),
        _ModuleCard(
          title: 'Research module',
          accent: const Color(0xFF2B6A64),
          style: overflowStyle,
          body:
              'Research keeps tighter bounds with overflow constraints while still transitioning text style over analysis phases.',
        ),
      ],
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.title,
    required this.accent,
    required this.style,
    required this.body,
  });

  final String title;
  final Color accent;
  final Animation<TextStyle> style;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DefaultTextStyleTransition(
        style: style,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent.withValues(alpha: 0.28)),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(height: 6),
              Text(body),
              const SizedBox(height: 8),
              const Text('Reusable descendants:'),
              const SizedBox(height: 4),
              const Text('• Headline text'),
              const Text('• Summary text'),
              const Text('• Status text'),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F3F8), Color(0xFFF7ECE3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFB9CBD8)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF314B5B)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DefaultTextStyleTransition animates inherited text style via Animation<TextStyle>.\n'
            '2) It is ideal for explicit controller-driven choreography.\n'
            '3) Descendant text widgets update together unless locally overridden.\n'
            '4) Nested transitions support multi-layer typography timelines.\n'
            '5) maxLines and overflow remain controllable during animated style changes.',
            style: TextStyle(fontSize: 12.4, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.5, height: 1.45));
  }
}
