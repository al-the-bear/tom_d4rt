import 'package:flutter/material.dart';

const _seedNavy = Color(0xFF1E4E75);
const _seedAmber = Color(0xFFC47C35);
const _seedTeal = Color(0xFF287D73);
const _seedRose = Color(0xFF93456B);
const _seedIndigo = Color(0xFF5752A0);
const _seedOlive = Color(0xFF6E6A2B);

dynamic build(BuildContext context) {
  return const _DualTransitionBuilderDeepDemoApp();
}

class _DualTransitionBuilderDeepDemoApp extends StatelessWidget {
  const _DualTransitionBuilderDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _seedNavy),
      ),
      home: const _DualTransitionBuilderDemoPage(),
    );
  }
}

class _DualTransitionBuilderDemoPage extends StatefulWidget {
  const _DualTransitionBuilderDemoPage();

  @override
  State<_DualTransitionBuilderDemoPage> createState() => _DualTransitionBuilderDemoPageState();
}

class _DualTransitionBuilderDemoPageState extends State<_DualTransitionBuilderDemoPage> {
  bool _rtl = false;
  bool _compact = false;
  bool _showGrid = true;
  bool _autoPulse = false;

  double _forwardDurationMs = 760;
  double _reverseDurationMs = 520;

  _CurveChoice _forwardCurve = _CurveChoice.easeOutCubic;
  _CurveChoice _reverseCurve = _CurveChoice.easeInCubic;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      autoPulse: _autoPulse,
      forwardDurationMs: _forwardDurationMs,
      reverseDurationMs: _reverseDurationMs,
      forwardCurve: _forwardCurve.curve,
      reverseCurve: _reverseCurve.curve,
    );

    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: _seedNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 78,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DualTransitionBuilder Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl ? 'Ambient direction: RTL' : 'Ambient direction: LTR',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroControlDeck(
                rtl: _rtl,
                compact: _compact,
                showGrid: _showGrid,
                autoPulse: _autoPulse,
                forwardDurationMs: _forwardDurationMs,
                reverseDurationMs: _reverseDurationMs,
                forwardCurve: _forwardCurve,
                reverseCurve: _reverseCurve,
                onRtlChanged: (value) => setState(() => _rtl = value),
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onAutoPulseChanged: (value) => setState(() => _autoPulse = value),
                onForwardDurationChanged: (value) => setState(() => _forwardDurationMs = value),
                onReverseDurationChanged: (value) => setState(() => _reverseDurationMs = value),
                onForwardCurveChanged: (value) => setState(() => _forwardCurve = value),
                onReverseCurveChanged: (value) => setState(() => _reverseCurve = value),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 1,
                accent: _seedNavy,
                title: 'Concept Scene and Shape Guarantee',
                subtitle:
                    'DualTransitionBuilder nests forward and reverse transitions so descendants keep their state even while transition direction changes.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 2,
                accent: _seedAmber,
                title: 'Enter / Exit Telemetry',
                subtitle:
                    'Inspect parent, forward, and reverse animation values while manually driving the controller.',
                child: _EnterExitTelemetryScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 3,
                accent: _seedTeal,
                title: 'Interruption Latching Lab',
                subtitle:
                    'Shows the implementation detail where interrupted transitions keep the previous effective direction for continuity.',
                child: _InterruptionLabScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 4,
                accent: _seedRose,
                title: 'State Retention Comparison',
                subtitle:
                    'Compares a DualTransitionBuilder-hosted stateful child with a regular conditional child that gets rebuilt and loses state.',
                child: _StateRetentionScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 5,
                accent: _seedIndigo,
                title: 'Builder Composition Studio',
                subtitle:
                    'Swap forward and reverse transition recipes independently to compose intentional entry and exit motion language.',
                child: _BuilderCompositionScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 6,
                accent: _seedOlive,
                title: 'Practical Pattern: Master / Detail Panel',
                subtitle:
                    'A realistic split panel where details appear and disappear with asymmetric transitions while list selection state persists.',
                child: _PracticalPatternScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoConfig {
  const _DemoConfig({
    required this.compact,
    required this.showGrid,
    required this.autoPulse,
    required this.forwardDurationMs,
    required this.reverseDurationMs,
    required this.forwardCurve,
    required this.reverseCurve,
  });

  final bool compact;
  final bool showGrid;
  final bool autoPulse;
  final double forwardDurationMs;
  final double reverseDurationMs;
  final Curve forwardCurve;
  final Curve reverseCurve;
}

enum _CurveChoice {
  linear('Linear', Curves.linear),
  easeOutCubic('Ease Out Cubic', Curves.easeOutCubic),
  easeInCubic('Ease In Cubic', Curves.easeInCubic),
  easeInOut('Ease In Out', Curves.easeInOut),
  fastOutSlowIn('Fast Out Slow In', Curves.fastOutSlowIn),
  easeOutBack('Ease Out Back', Curves.easeOutBack);

  const _CurveChoice(this.label, this.curve);

  final String label;
  final Curve curve;
}

class _HeroControlDeck extends StatelessWidget {
  const _HeroControlDeck({
    required this.rtl,
    required this.compact,
    required this.showGrid,
    required this.autoPulse,
    required this.forwardDurationMs,
    required this.reverseDurationMs,
    required this.forwardCurve,
    required this.reverseCurve,
    required this.onRtlChanged,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onAutoPulseChanged,
    required this.onForwardDurationChanged,
    required this.onReverseDurationChanged,
    required this.onForwardCurveChanged,
    required this.onReverseCurveChanged,
  });

  final bool rtl;
  final bool compact;
  final bool showGrid;
  final bool autoPulse;
  final double forwardDurationMs;
  final double reverseDurationMs;
  final _CurveChoice forwardCurve;
  final _CurveChoice reverseCurve;

  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onAutoPulseChanged;
  final ValueChanged<double> onForwardDurationChanged;
  final ValueChanged<double> onReverseDurationChanged;
  final ValueChanged<_CurveChoice> onForwardCurveChanged;
  final ValueChanged<_CurveChoice> onReverseCurveChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E4E75), Color(0xFF426A87), Color(0xFF704E67)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Motion Direction Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tune timing and curves globally, then inspect scene-level telemetry to understand how DualTransitionBuilder separates enter and exit semantics.',
            style: TextStyle(color: Color(0xFFF4F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGrid,
                  onChanged: onShowGridChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: autoPulse,
                  onChanged: onAutoPulseChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Auto pulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Forward duration: ${forwardDurationMs.toStringAsFixed(0)} ms',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: forwardDurationMs,
            min: 150,
            max: 1800,
            divisions: 33,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onForwardDurationChanged,
          ),
          Text(
            'Reverse duration: ${reverseDurationMs.toStringAsFixed(0)} ms',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: reverseDurationMs,
            min: 120,
            max: 1800,
            divisions: 28,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onReverseDurationChanged,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _CurveDropdown(
                  title: 'Forward curve',
                  value: forwardCurve,
                  onChanged: onForwardCurveChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CurveDropdown(
                  title: 'Reverse curve',
                  value: reverseCurve,
                  onChanged: onReverseCurveChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroTag(label: 'DualTransitionBuilder(animation, forwardBuilder, reverseBuilder)'),
              _HeroTag(label: 'forwardBuilder receives kAlwaysCompleteAnimation during reverse phase'),
              _HeroTag(label: 'reverseBuilder receives kAlwaysDismissedAnimation during forward phase'),
              _HeroTag(label: 'Interrupted transitions keep effective direction for continuity'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurveDropdown extends StatelessWidget {
  const _CurveDropdown({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final _CurveChoice value;
  final ValueChanged<_CurveChoice> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        ),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<_CurveChoice>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF395B77),
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: _CurveChoice.values
                  .map(
                    (choice) => DropdownMenuItem<_CurveChoice>(
                      value: choice,
                      child: Text(choice.label, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (selected) {
                if (selected != null) {
                  onChanged(selected);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  child: Text(
                    '$index',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      const SizedBox(height: 3),
                      Text(subtitle, style: const TextStyle(height: 1.4, color: Color(0xFF2F3B45))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
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
        const Text(
          'What makes DualTransitionBuilder special?',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            _LegendDot(color: _seedNavy, label: 'Forward builder animates appearance'),
            _LegendDot(color: _seedRose, label: 'Reverse builder animates disappearance'),
            _LegendDot(color: _seedTeal, label: 'Child remains nested and stateful'),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDE5EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FeatureBullet(text: 'During forward status, forwardBuilder receives the live animation.'),
              _FeatureBullet(text: 'During forward status, reverseBuilder receives kAlwaysDismissedAnimation.'),
              _FeatureBullet(text: 'During reverse status, reverseBuilder receives ReverseAnimation(parent).'),
              _FeatureBullet(text: 'During reverse status, forwardBuilder receives kAlwaysCompleteAnimation.'),
              _FeatureBullet(text: 'If direction flips mid-flight, effective direction can stay latched.'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _ConceptLoopPreview(),
      ],
    );
  }
}

class _ConceptLoopPreview extends StatefulWidget {
  const _ConceptLoopPreview();

  @override
  State<_ConceptLoopPreview> createState() => _ConceptLoopPreviewState();
}

class _ConceptLoopPreviewState extends State<_ConceptLoopPreview> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400), reverseDuration: const Duration(milliseconds: 760));
    _pulse();
  }

  Future<void> _pulse() async {
    while (mounted) {
      await _controller.forward();
      await Future<void>.delayed(const Duration(milliseconds: 220));
      await _controller.reverse();
      await Future<void>.delayed(const Duration(milliseconds: 240));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9E2EC)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 140,
              child: _GlassStage(
                showGrid: true,
                child: Center(
                  child: DualTransitionBuilder(
                    animation: CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic),
                    forwardBuilder: (context, animation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    reverseBuilder: (context, animation, child) {
                      return FadeTransition(
                        opacity: Tween<double>(begin: 1, end: 0).animate(animation),
                        child: ScaleTransition(scale: Tween<double>(begin: 1, end: 0.84).animate(animation), child: child),
                      );
                    },
                    child: const _TransitionCard(label: 'Nested Child', subtitle: 'State is retained.'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Parent value: ${_controller.value.toStringAsFixed(3)}', style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text('Parent status: ${_controller.status.name}'),
                    const SizedBox(height: 8),
                    const Text(
                      'Notice the child remains in the nested transition tree while animation direction changes. This avoids subtree replacement churn.',
                      style: TextStyle(height: 1.4, color: Color(0xFF425466)),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EnterExitTelemetryScene extends StatefulWidget {
  const _EnterExitTelemetryScene({required this.config});

  final _DemoConfig config;

  @override
  State<_EnterExitTelemetryScene> createState() => _EnterExitTelemetrySceneState();
}

class _EnterExitTelemetrySceneState extends State<_EnterExitTelemetryScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  Animation<double>? _forwardProbe;
  Animation<double>? _reverseProbe;

  double _forwardValue = 0;
  double _reverseValue = 0;

  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _forwardDuration,
      reverseDuration: _reverseDuration,
    );
    _controller.addStatusListener(_onStatusChanged);
    if (widget.config.autoPulse) {
      _startAutoPulse();
    }
  }

  Duration get _forwardDuration => Duration(milliseconds: widget.config.forwardDurationMs.round());
  Duration get _reverseDuration => Duration(milliseconds: widget.config.reverseDurationMs.round());

  void _onStatusChanged(AnimationStatus status) {
    _addEvent('Parent status -> ${status.name}');
  }

  @override
  void didUpdateWidget(covariant _EnterExitTelemetryScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = _forwardDuration;
    _controller.reverseDuration = _reverseDuration;
    if (widget.config.autoPulse && !oldWidget.config.autoPulse) {
      _startAutoPulse();
    }
  }

  Future<void> _startAutoPulse() async {
    while (mounted && widget.config.autoPulse) {
      await _controller.forward();
      if (!mounted || !widget.config.autoPulse) {
        break;
      }
      await Future<void>.delayed(const Duration(milliseconds: 180));
      if (!mounted || !widget.config.autoPulse) {
        break;
      }
      await _controller.reverse();
      await Future<void>.delayed(const Duration(milliseconds: 220));
    }
  }

  void _bindForward(Animation<double> animation) {
    if (identical(_forwardProbe, animation)) {
      return;
    }
    _forwardProbe?.removeListener(_onForwardTick);
    _forwardProbe = animation;
    _forwardProbe?.addListener(_onForwardTick);
    _forwardValue = animation.value;
  }

  void _bindReverse(Animation<double> animation) {
    if (identical(_reverseProbe, animation)) {
      return;
    }
    _reverseProbe?.removeListener(_onReverseTick);
    _reverseProbe = animation;
    _reverseProbe?.addListener(_onReverseTick);
    _reverseValue = animation.value;
  }

  void _onForwardTick() {
    if (!mounted || _forwardProbe == null) {
      return;
    }
    setState(() {
      _forwardValue = _forwardProbe!.value;
    });
  }

  void _onReverseTick() {
    if (!mounted || _reverseProbe == null) {
      return;
    }
    setState(() {
      _reverseValue = _reverseProbe!.value;
    });
  }

  void _addEvent(String text) {
    if (!mounted) {
      return;
    }
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} - $text');
      if (_events.length > 9) {
        _events.removeRange(9, _events.length);
      }
    });
  }

  String _statusInterpretation() {
    final status = _controller.status;
    if (status == AnimationStatus.forward && _reverseValue < 0.001) {
      return 'Forward phase: forwardBuilder has live animation; reverseBuilder is parked at dismissed.';
    }
    if (status == AnimationStatus.reverse && _forwardValue > 0.999) {
      return 'Reverse phase: forwardBuilder is parked at complete; reverseBuilder drives disappearance.';
    }
    if (status == AnimationStatus.completed) {
      return 'Completed: child is fully visible; forward is complete and reverse is dismissed.';
    }
    if (status == AnimationStatus.dismissed) {
      return 'Dismissed: child is fully hidden; reverse path reached terminal state.';
    }
    return 'Transition in progress.';
  }

  @override
  void dispose() {
    _forwardProbe?.removeListener(_onForwardTick);
    _reverseProbe?.removeListener(_onReverseTick);
    _controller
      ..removeStatusListener(_onStatusChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: widget.config.forwardCurve,
      reverseCurve: widget.config.reverseCurve,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: 'Show', color: _seedNavy, onPressed: () {
              _addEvent('Command: forward()');
              _controller.forward();
            }),
            _ActionButton(label: 'Hide', color: _seedRose, onPressed: () {
              _addEvent('Command: reverse()');
              _controller.reverse();
            }),
            _ActionButton(label: 'Toggle', color: _seedTeal, onPressed: () {
              if (_controller.status == AnimationStatus.dismissed || _controller.status == AnimationStatus.reverse) {
                _addEvent('Command: toggle -> forward()');
                _controller.forward();
              } else {
                _addEvent('Command: toggle -> reverse()');
                _controller.reverse();
              }
            }),
            _ActionButton(label: 'Stop', color: _seedAmber, onPressed: () {
              _addEvent('Command: stop()');
              _controller.stop();
            }),
            _ActionButton(label: 'Snap 0', color: Colors.blueGrey, onPressed: () {
              _addEvent('Command: value = 0.0');
              _controller.value = 0;
            }),
            _ActionButton(label: 'Snap 1', color: Colors.blueGrey, onPressed: () {
              _addEvent('Command: value = 1.0');
              _controller.value = 1;
            }),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 170 : 220,
          child: _GlassStage(
            showGrid: widget.config.showGrid,
            child: Center(
              child: DualTransitionBuilder(
                animation: animation,
                forwardBuilder: (context, builderAnimation, child) {
                  _bindForward(builderAnimation);
                  return _TransitionShell(
                    label: 'Forward layer',
                    color: _seedNavy,
                    animation: builderAnimation,
                    child: FadeTransition(
                      opacity: builderAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(begin: const Offset(0, 0.22), end: Offset.zero).animate(builderAnimation),
                        child: child,
                      ),
                    ),
                  );
                },
                reverseBuilder: (context, builderAnimation, child) {
                  _bindReverse(builderAnimation);
                  return _TransitionShell(
                    label: 'Reverse layer',
                    color: _seedRose,
                    animation: builderAnimation,
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 1, end: 0).animate(builderAnimation),
                      child: ScaleTransition(scale: Tween<double>(begin: 1, end: 0.84).animate(builderAnimation), child: child),
                    ),
                  );
                },
                child: const _TransitionCard(label: 'Telemetry Child', subtitle: 'Observe value channels below.'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _MetricBar(
                        label: 'Parent value',
                        value: _controller.value,
                        color: _seedTeal,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _MetricBar(
                        label: 'Forward builder value',
                        value: _forwardValue,
                        color: _seedNavy,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _MetricBar(
                        label: 'Reverse builder value',
                        value: _reverseValue,
                        color: _seedRose,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Parent status: ${_controller.status.name} | ${_statusInterpretation()}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        _EventLog(events: _events),
      ],
    );
  }
}

class _InterruptionLabScene extends StatefulWidget {
  const _InterruptionLabScene({required this.config});

  final _DemoConfig config;

  @override
  State<_InterruptionLabScene> createState() => _InterruptionLabSceneState();
}

class _InterruptionLabSceneState extends State<_InterruptionLabScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  Animation<double>? _forwardProbe;
  Animation<double>? _reverseProbe;
  double _forwardValue = 0;
  double _reverseValue = 0;

  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _forwardDuration,
      reverseDuration: _reverseDuration,
    )..addStatusListener(_onStatusChanged);
  }

  Duration get _forwardDuration => Duration(milliseconds: widget.config.forwardDurationMs.round());
  Duration get _reverseDuration => Duration(milliseconds: widget.config.reverseDurationMs.round());

  @override
  void didUpdateWidget(covariant _InterruptionLabScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = _forwardDuration;
    _controller.reverseDuration = _reverseDuration;
  }

  void _onStatusChanged(AnimationStatus status) {
    _log('Parent status -> ${status.name}');
  }

  void _bindForward(Animation<double> animation) {
    if (identical(_forwardProbe, animation)) {
      return;
    }
    _forwardProbe?.removeListener(_onForwardTick);
    _forwardProbe = animation;
    _forwardProbe?.addListener(_onForwardTick);
    _forwardValue = animation.value;
  }

  void _bindReverse(Animation<double> animation) {
    if (identical(_reverseProbe, animation)) {
      return;
    }
    _reverseProbe?.removeListener(_onReverseTick);
    _reverseProbe = animation;
    _reverseProbe?.addListener(_onReverseTick);
    _reverseValue = animation.value;
  }

  void _onForwardTick() {
    if (!mounted || _forwardProbe == null) {
      return;
    }
    setState(() {
      _forwardValue = _forwardProbe!.value;
    });
  }

  void _onReverseTick() {
    if (!mounted || _reverseProbe == null) {
      return;
    }
    setState(() {
      _reverseValue = _reverseProbe!.value;
    });
  }

  void _log(String message) {
    if (!mounted) {
      return;
    }
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} - $message');
      if (_events.length > 10) {
        _events.removeRange(10, _events.length);
      }
    });
  }

  Future<void> _runForwardInterruptSequence() async {
    _controller.value = 0;
    unawaited(_controller.forward());
    while (mounted && _controller.value < 0.4) {
      await Future<void>.delayed(const Duration(milliseconds: 12));
    }
    if (!mounted) {
      return;
    }
    _log('Interrupt at ${_controller.value.toStringAsFixed(2)} -> reverse()');
    _controller.reverse();
  }

  Future<void> _runReverseInterruptSequence() async {
    _controller.value = 1;
    unawaited(_controller.reverse());
    while (mounted && _controller.value > 0.6) {
      await Future<void>.delayed(const Duration(milliseconds: 12));
    }
    if (!mounted) {
      return;
    }
    _log('Interrupt at ${_controller.value.toStringAsFixed(2)} -> forward()');
    _controller.forward();
  }

  String _interpretation() {
    if (_controller.status == AnimationStatus.reverse && _reverseValue < 0.001) {
      return 'Latched to forward behavior: reverseBuilder remained dismissed during reverse command.';
    }
    if (_controller.status == AnimationStatus.forward && _forwardValue > 0.999 && _reverseValue > 0.001) {
      return 'Latched to reverse behavior: forwardBuilder stayed complete while parent moved forward.';
    }
    return 'Observe value channels while triggering scripted interruptions.';
  }

  @override
  void dispose() {
    _forwardProbe?.removeListener(_onForwardTick);
    _reverseProbe?.removeListener(_onReverseTick);
    _controller
      ..removeStatusListener(_onStatusChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: widget.config.forwardCurve,
      reverseCurve: widget.config.reverseCurve,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'Script A (Forward -> Reverse)',
              color: _seedTeal,
              onPressed: () => unawaited(_runForwardInterruptSequence()),
            ),
            _ActionButton(
              label: 'Script B (Reverse -> Forward)',
              color: _seedIndigo,
              onPressed: () => unawaited(_runReverseInterruptSequence()),
            ),
            _ActionButton(
              label: 'Simple Forward',
              color: _seedNavy,
              onPressed: () {
                _log('Manual forward()');
                _controller.forward();
              },
            ),
            _ActionButton(
              label: 'Simple Reverse',
              color: _seedRose,
              onPressed: () {
                _log('Manual reverse()');
                _controller.reverse();
              },
            ),
            _ActionButton(
              label: 'Reset to 0',
              color: Colors.blueGrey,
              onPressed: () {
                _log('Set value = 0.0');
                _controller.value = 0;
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 165 : 215,
          child: _GlassStage(
            showGrid: widget.config.showGrid,
            child: Center(
              child: DualTransitionBuilder(
                animation: animation,
                forwardBuilder: (context, builderAnimation, child) {
                  _bindForward(builderAnimation);
                  return _TransitionShell(
                    label: 'Forward shell',
                    color: _seedTeal,
                    animation: builderAnimation,
                    child: FadeTransition(
                      opacity: builderAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(begin: const Offset(-0.18, 0), end: Offset.zero).animate(builderAnimation),
                        child: child,
                      ),
                    ),
                  );
                },
                reverseBuilder: (context, builderAnimation, child) {
                  _bindReverse(builderAnimation);
                  return _TransitionShell(
                    label: 'Reverse shell',
                    color: _seedIndigo,
                    animation: builderAnimation,
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 1, end: 0).animate(builderAnimation),
                      child: RotationTransition(turns: Tween<double>(begin: 0, end: -0.04).animate(builderAnimation), child: child),
                    ),
                  );
                },
                child: const _TransitionCard(label: 'Interruption Target', subtitle: 'Watch shell values for latching.'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Row(
              children: [
                Expanded(
                  child: _MetricBar(label: 'Parent', value: _controller.value, color: _seedAmber),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _MetricBar(label: 'Forward shell', value: _forwardValue, color: _seedTeal),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _MetricBar(label: 'Reverse shell', value: _reverseValue, color: _seedIndigo),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          _interpretation(),
          style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1C3448)),
        ),
        const SizedBox(height: 8),
        _EventLog(events: _events),
      ],
    );
  }
}

class _StateRetentionScene extends StatefulWidget {
  const _StateRetentionScene({required this.config});

  final _DemoConfig config;

  @override
  State<_StateRetentionScene> createState() => _StateRetentionSceneState();
}

class _StateRetentionSceneState extends State<_StateRetentionScene> with TickerProviderStateMixin {
  late final AnimationController _dualController;
  late final AnimationController _plainController;

  final GlobalKey<_MemoPadState> _dualPadKey = GlobalKey<_MemoPadState>();

  bool _dualVisible = true;
  bool _plainVisible = true;

  int _plainRebuildEpoch = 0;
  String _snapshot = 'No snapshot yet.';

  @override
  void initState() {
    super.initState();
    _dualController = AnimationController(vsync: this, value: 1, duration: _forwardDuration, reverseDuration: _reverseDuration);
    _plainController = AnimationController(vsync: this, value: 1, duration: _forwardDuration, reverseDuration: _reverseDuration);
  }

  Duration get _forwardDuration => Duration(milliseconds: widget.config.forwardDurationMs.round());
  Duration get _reverseDuration => Duration(milliseconds: widget.config.reverseDurationMs.round());

  @override
  void didUpdateWidget(covariant _StateRetentionScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    _dualController.duration = _forwardDuration;
    _dualController.reverseDuration = _reverseDuration;
    _plainController.duration = _forwardDuration;
    _plainController.reverseDuration = _reverseDuration;
  }

  void _toggleDualVisibility() {
    if (_dualVisible) {
      _dualController.reverse();
    } else {
      _dualController.forward();
    }
    setState(() {
      _dualVisible = !_dualVisible;
    });
  }

  void _togglePlainVisibility() {
    if (_plainVisible) {
      _plainController.reverse();
    } else {
      _plainController.forward();
    }
    setState(() {
      _plainVisible = !_plainVisible;
      if (_plainVisible) {
        _plainRebuildEpoch += 1;
      }
    });
  }

  void _captureSnapshot() {
    final dualState = _dualPadKey.currentState;
    final dualText = dualState?.currentText ?? '';
    final dualCount = dualState?.counter ?? 0;
    setState(() {
      _snapshot = 'Dual pad -> count $dualCount, text "$dualText". Plain pad usually resets after re-appear.';
    });
  }

  @override
  void dispose() {
    _dualController.dispose();
    _plainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dualAnimation = CurvedAnimation(parent: _dualController, curve: widget.config.forwardCurve, reverseCurve: widget.config.reverseCurve);
    final plainAnimation = CurvedAnimation(parent: _plainController, curve: widget.config.forwardCurve, reverseCurve: widget.config.reverseCurve);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: _dualVisible ? 'Hide Dual Pad' : 'Show Dual Pad', color: _seedRose, onPressed: _toggleDualVisibility),
            _ActionButton(label: _plainVisible ? 'Hide Plain Pad' : 'Show Plain Pad', color: _seedAmber, onPressed: _togglePlainVisibility),
            _ActionButton(label: 'Capture Snapshot', color: _seedNavy, onPressed: _captureSnapshot),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('DualTransitionBuilder host', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: widget.config.compact ? 250 : 290,
                    child: _GlassStage(
                      showGrid: widget.config.showGrid,
                      child: Center(
                        child: DualTransitionBuilder(
                          animation: dualAnimation,
                          forwardBuilder: (context, animation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          reverseBuilder: (context, animation, child) {
                            return SizeTransition(
                              sizeFactor: Tween<double>(begin: 1, end: 0).animate(animation),
                              axisAlignment: -1,
                              child: child,
                            );
                          },
                          child: _MemoPad(
                            key: _dualPadKey,
                            title: 'Dual Pad (state should survive hide/show)',
                            accent: _seedRose,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Regular conditional host', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: widget.config.compact ? 250 : 290,
                    child: _GlassStage(
                      showGrid: widget.config.showGrid,
                      child: Center(
                        child: FadeTransition(
                          opacity: plainAnimation,
                          child: _plainVisible
                              ? _MemoPad(
                                  key: ValueKey<int>(_plainRebuildEpoch),
                                  title: 'Plain Pad (state usually resets)',
                                  accent: _seedAmber,
                                )
                              : const _HiddenPlaceholder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF7FBFF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDCE8F4)),
          ),
          child: Text(_snapshot, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

class _MemoPad extends StatefulWidget {
  const _MemoPad({
    super.key,
    required this.title,
    required this.accent,
  });

  final String title;
  final Color accent;

  @override
  State<_MemoPad> createState() => _MemoPadState();
}

class _MemoPadState extends State<_MemoPad> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 0;

  int get counter => _counter;
  String get currentText => _controller.text;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.accent.withValues(alpha: 0.45), width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(color: widget.accent, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Type text to test retention',
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => setState(() => _counter += 1),
                child: const Text('+1'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Counter: $_counter', style: const TextStyle(fontWeight: FontWeight.w700)),
          Text('Text length: ${_controller.text.length}', style: const TextStyle(color: Color(0xFF4E5F70))),
        ],
      ),
    );
  }
}

class _HiddenPlaceholder extends StatelessWidget {
  const _HiddenPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD4DDE8)),
      ),
      child: const Center(
        child: Text('Child removed from tree', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF657587))),
      ),
    );
  }
}

class _BuilderCompositionScene extends StatefulWidget {
  const _BuilderCompositionScene({required this.config});

  final _DemoConfig config;

  @override
  State<_BuilderCompositionScene> createState() => _BuilderCompositionSceneState();
}

enum _ForwardRecipe {
  fadeSlide('Fade + Slide Up'),
  popZoom('Pop Zoom'),
  wipeIn('Wipe In');

  const _ForwardRecipe(this.label);
  final String label;
}

enum _ReverseRecipe {
  shrinkFade('Shrink + Fade'),
  driftAway('Drift Away'),
  clipOut('Clip Out');

  const _ReverseRecipe(this.label);
  final String label;
}

class _BuilderCompositionSceneState extends State<_BuilderCompositionScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  _ForwardRecipe _forwardRecipe = _ForwardRecipe.fadeSlide;
  _ReverseRecipe _reverseRecipe = _ReverseRecipe.shrinkFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: 1, duration: _forwardDuration, reverseDuration: _reverseDuration);
  }

  Duration get _forwardDuration => Duration(milliseconds: widget.config.forwardDurationMs.round());
  Duration get _reverseDuration => Duration(milliseconds: widget.config.reverseDurationMs.round());

  @override
  void didUpdateWidget(covariant _BuilderCompositionScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = _forwardDuration;
    _controller.reverseDuration = _reverseDuration;
  }

  Widget _buildForward(Animation<double> animation, Widget child) {
    switch (_forwardRecipe) {
      case _ForwardRecipe.fadeSlide:
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(animation), child: child),
        );
      case _ForwardRecipe.popZoom:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.76, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      case _ForwardRecipe.wipeIn:
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: animation.value,
            child: child,
          ),
        );
    }
  }

  Widget _buildReverse(Animation<double> animation, Widget child) {
    switch (_reverseRecipe) {
      case _ReverseRecipe.shrinkFade:
        return FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(animation),
          child: ScaleTransition(scale: Tween<double>(begin: 1, end: 0.84).animate(animation), child: child),
        );
      case _ReverseRecipe.driftAway:
        return FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset.zero, end: const Offset(0.16, -0.08)).animate(animation),
            child: child,
          ),
        );
      case _ReverseRecipe.clipOut:
        return ClipRect(
          child: Align(
            alignment: Alignment.centerRight,
            widthFactor: 1 - animation.value,
            child: child,
          ),
        );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: widget.config.forwardCurve,
      reverseCurve: widget.config.reverseCurve,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _RecipeDropdown<_ForwardRecipe>(
                title: 'Forward recipe',
                value: _forwardRecipe,
                values: _ForwardRecipe.values,
                labelOf: (value) => value.label,
                onChanged: (value) => setState(() => _forwardRecipe = value),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _RecipeDropdown<_ReverseRecipe>(
                title: 'Reverse recipe',
                value: _reverseRecipe,
                values: _ReverseRecipe.values,
                labelOf: (value) => value.label,
                onChanged: (value) => setState(() => _reverseRecipe = value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: 'Show', color: _seedIndigo, onPressed: () => _controller.forward()),
            _ActionButton(label: 'Hide', color: _seedRose, onPressed: () => _controller.reverse()),
            _ActionButton(label: 'Toggle', color: _seedTeal, onPressed: () {
              if (_controller.status == AnimationStatus.dismissed || _controller.status == AnimationStatus.reverse) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            }),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 170 : 220,
          child: _GlassStage(
            showGrid: widget.config.showGrid,
            child: Center(
              child: DualTransitionBuilder(
                animation: animation,
                forwardBuilder: (context, builderAnimation, child) => _buildForward(builderAnimation, child!),
                reverseBuilder: (context, builderAnimation, child) => _buildReverse(builderAnimation, child!),
                child: _TransitionCard(
                  label: '${_forwardRecipe.label} / ${_reverseRecipe.label}',
                  subtitle: 'Compose asymmetry intentionally.',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RecipeDropdown<T> extends StatelessWidget {
  const _RecipeDropdown({
    required this.title,
    required this.value,
    required this.values,
    required this.labelOf,
    required this.onChanged,
  });

  final String title;
  final T value;
  final List<T> values;
  final String Function(T value) labelOf;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          initialValue: value,
          decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
          items: values
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(labelOf(item)),
                ),
              )
              .toList(),
          onChanged: (selected) {
            if (selected != null) {
              onChanged(selected);
            }
          },
        ),
      ],
    );
  }
}

class _PracticalPatternScene extends StatefulWidget {
  const _PracticalPatternScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalPatternScene> createState() => _PracticalPatternSceneState();
}

class _PracticalPatternSceneState extends State<_PracticalPatternScene> with TickerProviderStateMixin {
  late final AnimationController _detailController;

  final List<_MailThread> _threads = const [
    _MailThread('Operations Digest', 'Deployment lane green across all regions.'),
    _MailThread('Product Design', 'Updated animation rationale and state diagrams.'),
    _MailThread('QA Signal', 'Interruption edge-case covered in manual matrix.'),
    _MailThread('Support Escalation', 'Need temporary workaround for slow startup.'),
    _MailThread('Security Note', 'Rotate staging tokens before Friday.'),
  ];

  int _selectedIndex = 0;
  bool _detailVisible = true;

  @override
  void initState() {
    super.initState();
    _detailController = AnimationController(vsync: this, value: 1, duration: _forwardDuration, reverseDuration: _reverseDuration);
  }

  Duration get _forwardDuration => Duration(milliseconds: widget.config.forwardDurationMs.round());
  Duration get _reverseDuration => Duration(milliseconds: widget.config.reverseDurationMs.round());

  @override
  void didUpdateWidget(covariant _PracticalPatternScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    _detailController.duration = _forwardDuration;
    _detailController.reverseDuration = _reverseDuration;
  }

  void _toggleDetail() {
    setState(() {
      _detailVisible = !_detailVisible;
    });
    if (_detailVisible) {
      _detailController.forward();
    } else {
      _detailController.reverse();
    }
  }

  @override
  void dispose() {
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _threads[_selectedIndex];
    final detailAnimation = CurvedAnimation(
      parent: _detailController,
      curve: widget.config.forwardCurve,
      reverseCurve: widget.config.reverseCurve,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _detailVisible ? 'Hide Detail Panel' : 'Show Detail Panel',
              color: _seedOlive,
              onPressed: _toggleDetail,
            ),
            _ActionButton(
              label: 'Next Thread',
              color: _seedNavy,
              onPressed: () {
                setState(() {
                  _selectedIndex = (_selectedIndex + 1) % _threads.length;
                  _detailVisible = true;
                });
                _detailController.forward();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.config.compact ? 250 : 315,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FAFD),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFDCE6F1)),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: _threads.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final thread = _threads[index];
                      final selectedRow = index == _selectedIndex;
                      return ListTile(
                        selected: selectedRow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        selectedTileColor: const Color(0xFFDCEBF8),
                        tileColor: Colors.white,
                        title: Text(thread.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text(thread.preview, maxLines: 1, overflow: TextOverflow.ellipsis),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                            _detailVisible = true;
                          });
                          _detailController.forward();
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GlassStage(
                  showGrid: widget.config.showGrid,
                  child: Center(
                    child: DualTransitionBuilder(
                      animation: detailAnimation,
                      forwardBuilder: (context, animation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(begin: const Offset(0.12, 0), end: Offset.zero).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      reverseBuilder: (context, animation, child) {
                        return FadeTransition(
                          opacity: Tween<double>(begin: 1, end: 0).animate(animation),
                          child: ScaleTransition(scale: Tween<double>(begin: 1, end: 0.92).animate(animation), child: child),
                        );
                      },
                      child: _ThreadDetailCard(thread: selected),
                    ),
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

class _MailThread {
  const _MailThread(this.title, this.preview);

  final String title;
  final String preview;
}

class _ThreadDetailCard extends StatelessWidget {
  const _ThreadDetailCard({required this.thread});

  final _MailThread thread;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(thread.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          Text(thread.preview, style: const TextStyle(height: 1.4)),
          const SizedBox(height: 10),
          const Text(
            'Why DualTransitionBuilder here?',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Detail panel enters with a lateral reveal and exits with compacting fade, while list selection and any local detail state remain stable.',
            style: TextStyle(height: 1.4, color: Color(0xFF46596A)),
          ),
        ],
      ),
    );
  }
}

class _TransitionShell extends StatelessWidget {
  const _TransitionShell({
    required this.label,
    required this.color,
    required this.animation,
    required this.child,
  });

  final String label;
  final Color color;
  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.5),
      ),
      child: Stack(
        children: [
          Padding(padding: const EdgeInsets.all(8), child: child),
          Positioned(
            top: 6,
            right: 8,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: color.withValues(alpha: 0.35)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    return Text(
                      '$label ${animation.value.toStringAsFixed(2)}',
                      style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransitionCard extends StatelessWidget {
  const _TransitionCard({
    required this.label,
    required this.subtitle,
  });

  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD8E2EC)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Color(0xFF4C5E70), height: 1.35)),
        ],
      ),
    );
  }
}

class _GlassStage extends StatelessWidget {
  const _GlassStage({
    required this.showGrid,
    required this.child,
  });

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF7FBFF), Color(0xFFEAF2F8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD4E0EB)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid)
            CustomPaint(
              painter: _GridPainter(),
            ),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const step = 22.0;
    final paint = Paint()..color = const Color(0x11000000);

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MetricBar extends StatelessWidget {
  const _MetricBar({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD8E3EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: clamped,
            minHeight: 8,
            borderRadius: BorderRadius.circular(999),
            color: color,
            backgroundColor: color.withValues(alpha: 0.18),
          ),
          const SizedBox(height: 4),
          Text(clamped.toStringAsFixed(3), style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _FeatureBullet extends StatelessWidget {
  const _FeatureBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF36536D)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE6F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent events', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events yet.', style: TextStyle(color: Color(0xFF617386)))
          else
            ...events.map((event) => Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(event, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                )),
        ],
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
        color: const Color(0xFF10273C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: DualTransitionBuilder in practice',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use it when enter and exit transitions must differ but subtree identity should remain stable. The telemetry scenes above expose how builder animations are reassigned across status phases and why interruption latching exists.',
            style: TextStyle(color: Color(0xFFD9E5F1), height: 1.4),
          ),
        ],
      ),
    );
  }
}

void unawaited(Future<void> future) {}
