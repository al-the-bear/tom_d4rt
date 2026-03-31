import 'dart:async';

import 'package:flutter/material.dart';

const _cNavy = Color(0xFF133F67);
const _cAmber = Color(0xFFC8893E);
const _cTeal = Color(0xFF31897C);
const _cRose = Color(0xFF91506F);
const _cIndigo = Color(0xFF5C5AA9);
const _cOlive = Color(0xFF6C7136);

dynamic build(BuildContext context) {
  return const _HeroControllerDeepDemoApp();
}

class _HeroControllerDeepDemoApp extends StatelessWidget {
  const _HeroControllerDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cNavy),
        scaffoldBackgroundColor: const Color(0xFFF3F6FA),
      ),
      home: const _HeroControllerLabPage(),
    );
  }
}

class _HeroControllerLabPage extends StatefulWidget {
  const _HeroControllerLabPage();

  @override
  State<_HeroControllerLabPage> createState() => _HeroControllerLabPageState();
}

class _HeroControllerLabPageState extends State<_HeroControllerLabPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _rtl = false;
  _TweenFlavor _defaultFlavor = _TweenFlavor.materialArc;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      defaultFlavor: _defaultFlavor,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 84,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('HeroController Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Default controller tween: ${config.defaultFlavor.label}',
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
              _ControlDeck(
                compact: _compact,
                showGrid: _showGrid,
                rtl: _rtl,
                flavor: _defaultFlavor,
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onRtlChanged: (value) => setState(() => _rtl = value),
                onFlavorChanged: (value) => setState(() => _defaultFlavor = value),
              ),
              const SizedBox(height: 12),
              const _SceneShell(
                index: 1,
                accent: _cNavy,
                title: 'Controller Semantics and Responsibilities',
                subtitle:
                    'HeroController is a NavigatorObserver that discovers matching heroes during route changes and starts/diverts flights. It can customize bounds interpolation via createRectTween.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                accent: _cAmber,
                title: 'Observer Lifecycle Timeline',
                subtitle:
                    'Shows HeroController callbacks as route operations occur: didPush, didPop, didReplace, didChangeTop, and gesture hooks.',
                child: _ObserverTimelineScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                accent: _cTeal,
                title: 'Rect Tween Strategy Comparison',
                subtitle:
                    'Three controllers run identical hero flows with linear, Material arc, and elastic interpolation for side-by-side motion analysis.',
                child: _TweenComparisonScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                accent: _cRose,
                title: 'Flight Diversion Stress Lab',
                subtitle:
                    'Rapid redirection requests trigger in-flight diversion behavior, illustrating how HeroController retargets active flights.',
                child: _DiversionScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                accent: _cIndigo,
                title: 'Controller Hot-Swap Scene',
                subtitle:
                    'The same navigator flow is rebuilt with different HeroController instances to compare practical transition feel during development tuning.',
                child: _ControllerSwitchScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 6,
                accent: _cOlive,
                title: 'Practical Multi-Pane Workspace',
                subtitle:
                    'A realistic two-lane workspace where each embedded navigator owns a dedicated HeroController and produces operational logs.',
                child: _PracticalWorkspaceScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
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
    required this.textDirection,
    required this.defaultFlavor,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final _TweenFlavor defaultFlavor;
}

enum _TweenFlavor {
  linear('Linear RectTween'),
  materialArc('MaterialRectArcTween'),
  elastic('Elastic custom tween');

  const _TweenFlavor(this.label);
  final String label;
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.showGrid,
    required this.rtl,
    required this.flavor,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onRtlChanged,
    required this.onFlavorChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool rtl;
  final _TweenFlavor flavor;

  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<_TweenFlavor> onFlavorChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173E67), Color(0xFF2D607E), Color(0xFF724C68)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HeroController Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const SizedBox(height: 6),
            const Text(
              'Focus on controller behavior, not only hero widgets. Explore observer lifecycle, tween customization, and architectural ownership in embedded navigators.',
              style: TextStyle(color: Color(0xFFE7F1FA), height: 1.4),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact layout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: showGrid,
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            _TweenField(value: flavor, onChanged: onFlavorChanged),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'Observer lifecycle logs'),
                _DeckTag(label: 'createRectTween strategy lab'),
                _DeckTag(label: 'Flight diversion stress'),
                _DeckTag(label: 'Multi-navigator ownership'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TweenField extends StatelessWidget {
  const _TweenField({required this.value, required this.onChanged});

  final _TweenFlavor value;
  final ValueChanged<_TweenFlavor> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Default Controller Tween', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<_TweenFlavor>(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: const Color(0xFF315E79),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: _TweenFlavor.values
                  .map(
                    (entry) => DropdownMenuItem<_TweenFlavor>(
                      value: entry,
                      child: Text(entry.label, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (entry) {
                if (entry != null) {
                  onChanged(entry);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DeckTag extends StatelessWidget {
  const _DeckTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
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
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 3),
                      Text(subtitle, style: const TextStyle(height: 1.38, color: Color(0xFF2E3D49))),
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
        const Text('Why HeroController matters', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'HeroController collects heroes by tag from source and destination page routes, starts flights, and diverts active flights when route changes retarget the same tag. It is attached as a NavigatorObserver, typically by MaterialApp.',
          style: TextStyle(height: 1.42),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FBFE),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD7E3EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bullet(text: 'It listens to route state transitions through NavigatorObserver callbacks.'),
              _Bullet(text: 'createRectTween customizes hero bounds interpolation for all participating heroes lacking their own tween.'),
              _Bullet(text: 'It handles in-flight redirection when a tagged hero is retargeted before previous flight ends.'),
              _Bullet(text: 'Each navigator should own its own HeroController instance in parallel architectures.'),
              _Bullet(text: 'Use controller-focused logs to debug route transition behavior in complex shells.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ObserverTimelineScene extends StatefulWidget {
  const _ObserverTimelineScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ObserverTimelineScene> createState() => _ObserverTimelineSceneState();
}

class _ObserverTimelineSceneState extends State<_ObserverTimelineScene> {
  final GlobalKey<_FlowHostState> _leftKey = GlobalKey<_FlowHostState>();
  final GlobalKey<_FlowHostState> _rightKey = GlobalKey<_FlowHostState>();

  late final _LoggingHeroController _leftController;
  late final _LoggingHeroController _rightController;

  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _leftController = _LoggingHeroController(
      controllerId: 'A',
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
      onEvent: _record,
    );
    _rightController = _LoggingHeroController(
      controllerId: 'B',
      createRectTween: (Rect? begin, Rect? end) => RectTween(begin: begin, end: end),
      onEvent: _record,
    );
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  void _record(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 24) {
        _events.removeRange(24, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double height = config.compact ? 420 : 510;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: 'Left push', color: _cAmber, onPressed: () => _leftKey.currentState?.openByStep()),
            _ActionButton(label: 'Left pop', color: _cAmber, onPressed: () => _leftKey.currentState?.popOne()),
            _ActionButton(label: 'Right push', color: _cTeal, onPressed: () => _rightKey.currentState?.openByStep()),
            _ActionButton(label: 'Right replace', color: _cTeal, onPressed: () => _rightKey.currentState?.replaceTop()),
            _ActionButton(label: 'Clear log', color: _cNavy, onPressed: () => setState(_events.clear)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: height,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _leftKey,
                    title: 'Observer A',
                    accent: _cAmber,
                    controller: _leftController,
                    data: _setA,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _rightKey,
                    title: 'Observer B',
                    accent: _cTeal,
                    controller: _rightController,
                    data: _setB,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EventLog(title: 'Observer timeline', events: _events),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TweenComparisonScene extends StatefulWidget {
  const _TweenComparisonScene({required this.config});

  final _DemoConfig config;

  @override
  State<_TweenComparisonScene> createState() => _TweenComparisonSceneState();
}

class _TweenComparisonSceneState extends State<_TweenComparisonScene> {
  late final _LoggingHeroController _linear;
  late final _LoggingHeroController _arc;
  late final _LoggingHeroController _elastic;
  final GlobalKey<_FlowHostState> _linearKey = GlobalKey<_FlowHostState>();
  final GlobalKey<_FlowHostState> _arcKey = GlobalKey<_FlowHostState>();
  final GlobalKey<_FlowHostState> _elasticKey = GlobalKey<_FlowHostState>();
  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _linear = _LoggingHeroController(
      controllerId: 'Linear',
      createRectTween: (Rect? begin, Rect? end) => RectTween(begin: begin, end: end),
      onEvent: _record,
    );
    _arc = _LoggingHeroController(
      controllerId: 'Arc',
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
      onEvent: _record,
    );
    _elastic = _LoggingHeroController(
      controllerId: 'Elastic',
      createRectTween: (Rect? begin, Rect? end) => _ElasticRectTween(begin: begin, end: end),
      onEvent: _record,
    );
  }

  @override
  void dispose() {
    _linear.dispose();
    _arc.dispose();
    _elastic.dispose();
    super.dispose();
  }

  void _record(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 18) {
        _events.removeRange(18, _events.length);
      }
    });
  }

  void _syncPush() {
    _linearKey.currentState?.openByStep();
    _arcKey.currentState?.openByStep();
    _elasticKey.currentState?.openByStep();
  }

  void _syncPop() {
    _linearKey.currentState?.popOne();
    _arcKey.currentState?.popOne();
    _elasticKey.currentState?.popOne();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double paneHeight = config.compact ? 360 : 430;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: 'Sync push', color: _cTeal, onPressed: _syncPush),
            _ActionButton(label: 'Sync pop', color: _cTeal, onPressed: _syncPop),
            _ActionButton(label: 'Clear log', color: _cNavy, onPressed: () => setState(_events.clear)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: paneHeight,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _linearKey,
                    title: 'Linear',
                    accent: _cTeal,
                    controller: _linear,
                    data: _setC,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _arcKey,
                    title: 'Material Arc',
                    accent: _cIndigo,
                    controller: _arc,
                    data: _setC,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _elasticKey,
                    title: 'Elastic',
                    accent: _cRose,
                    controller: _elastic,
                    data: _setC,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _EventLog(title: 'Tween comparison log', events: _events),
      ],
    );
  }
}

class _DiversionScene extends StatefulWidget {
  const _DiversionScene({required this.config});

  final _DemoConfig config;

  @override
  State<_DiversionScene> createState() => _DiversionSceneState();
}

class _DiversionSceneState extends State<_DiversionScene> {
  final GlobalKey<_FlowHostState> _flowKey = GlobalKey<_FlowHostState>();
  late final _LoggingHeroController _controller;
  final List<String> _events = <String>[];
  Timer? _cycleTimer;
  bool _auto = false;

  @override
  void initState() {
    super.initState();
    _controller = _LoggingHeroController(
      controllerId: 'Diversion',
      createRectTween: (Rect? begin, Rect? end) => _ElasticRectTween(begin: begin, end: end),
      onEvent: _record,
    );
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _record(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 22) {
        _events.removeRange(22, _events.length);
      }
    });
  }

  Future<void> _burstRedirect() async {
    _record('manual burst start');
    _flowKey.currentState?.openByIndex(0);
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _flowKey.currentState?.replaceTop();
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _flowKey.currentState?.replaceTop();
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _flowKey.currentState?.replaceTop();
    _record('manual burst end');
  }

  void _toggleAuto() {
    if (_auto) {
      _cycleTimer?.cancel();
      setState(() => _auto = false);
      _record('auto diversion off');
      return;
    }
    setState(() => _auto = true);
    _record('auto diversion on');
    _cycleTimer = Timer.periodic(const Duration(milliseconds: 700), (_) {
      _flowKey.currentState?.openByStep();
      Future<void>.delayed(const Duration(milliseconds: 130), () {
        _flowKey.currentState?.replaceTop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double h = config.compact ? 370 : 450;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: 'Burst redirect', color: _cRose, onPressed: _burstRedirect),
            _ActionButton(label: _auto ? 'Stop auto' : 'Start auto', color: _cRose, onPressed: _toggleAuto),
            _ActionButton(label: 'Pop', color: _cRose, onPressed: () => _flowKey.currentState?.popOne()),
            _ActionButton(label: 'Clear', color: _cNavy, onPressed: () => setState(_events.clear)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: h,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _flowKey,
                    title: 'Diversion flow',
                    accent: _cRose,
                    controller: _controller,
                    data: _setD,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EventLog(title: 'Diversion log', events: _events),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControllerSwitchScene extends StatefulWidget {
  const _ControllerSwitchScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ControllerSwitchScene> createState() => _ControllerSwitchSceneState();
}

class _ControllerSwitchSceneState extends State<_ControllerSwitchScene> {
  final GlobalKey<_FlowHostState> _flowKey = GlobalKey<_FlowHostState>();
  late final _LoggingHeroController _linear;
  late final _LoggingHeroController _arc;
  late final _LoggingHeroController _elastic;
  _TweenFlavor _active = _TweenFlavor.materialArc;
  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _linear = _LoggingHeroController(
      controllerId: 'Switch-Linear',
      createRectTween: (Rect? begin, Rect? end) => RectTween(begin: begin, end: end),
      onEvent: _record,
    );
    _arc = _LoggingHeroController(
      controllerId: 'Switch-Arc',
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
      onEvent: _record,
    );
    _elastic = _LoggingHeroController(
      controllerId: 'Switch-Elastic',
      createRectTween: (Rect? begin, Rect? end) => _ElasticRectTween(begin: begin, end: end),
      onEvent: _record,
    );
  }

  @override
  void dispose() {
    _linear.dispose();
    _arc.dispose();
    _elastic.dispose();
    super.dispose();
  }

  _LoggingHeroController get _currentController {
    switch (_active) {
      case _TweenFlavor.linear:
        return _linear;
      case _TweenFlavor.materialArc:
        return _arc;
      case _TweenFlavor.elastic:
        return _elastic;
    }
  }

  void _record(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 18) {
        _events.removeRange(18, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double h = config.compact ? 360 : 430;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._TweenFlavor.values.map(
              (entry) => ChoiceChip(
                selected: _active == entry,
                label: Text(entry.label),
                onSelected: (_) {
                  setState(() => _active = entry);
                  _record('active controller -> ${entry.label}');
                },
              ),
            ),
            _ActionButton(label: 'Push', color: _cIndigo, onPressed: () => _flowKey.currentState?.openByStep()),
            _ActionButton(label: 'Pop', color: _cIndigo, onPressed: () => _flowKey.currentState?.popOne()),
            _ActionButton(label: 'Replace', color: _cIndigo, onPressed: () => _flowKey.currentState?.replaceTop()),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: h,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: ValueKey<_TweenFlavor>(_active),
                    title: 'Hot-swap flow (${_active.label})',
                    accent: _cIndigo,
                    controller: _currentController,
                    data: _setA,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EventLog(title: 'Controller switch log', events: _events),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PracticalWorkspaceScene extends StatefulWidget {
  const _PracticalWorkspaceScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalWorkspaceScene> createState() => _PracticalWorkspaceSceneState();
}

class _PracticalWorkspaceSceneState extends State<_PracticalWorkspaceScene> {
  final GlobalKey<_FlowHostState> _leftKey = GlobalKey<_FlowHostState>();
  final GlobalKey<_FlowHostState> _rightKey = GlobalKey<_FlowHostState>();

  late final _LoggingHeroController _leftController;
  late final _LoggingHeroController _rightController;
  final List<String> _events = <String>[];

  bool _leftEnabled = true;
  bool _rightEnabled = true;

  @override
  void initState() {
    super.initState();
    _leftController = _LoggingHeroController(
      controllerId: 'Workspace-Left',
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
      onEvent: _record,
    );
    _rightController = _LoggingHeroController(
      controllerId: 'Workspace-Right',
      createRectTween: (Rect? begin, Rect? end) => _ElasticRectTween(begin: begin, end: end),
      onEvent: _record,
    );
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  void _record(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 24) {
        _events.removeRange(24, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final double h = config.compact ? 460 : 560;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('Left HeroMode'),
              selected: _leftEnabled,
              onSelected: (value) => setState(() => _leftEnabled = value),
            ),
            FilterChip(
              label: const Text('Right HeroMode'),
              selected: _rightEnabled,
              onSelected: (value) => setState(() => _rightEnabled = value),
            ),
            _ActionButton(label: 'Left push', color: _cOlive, onPressed: () => _leftKey.currentState?.openByStep()),
            _ActionButton(label: 'Right push', color: _cOlive, onPressed: () => _rightKey.currentState?.openByStep()),
            _ActionButton(label: 'Clear', color: _cNavy, onPressed: () => setState(_events.clear)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: h,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _leftKey,
                    title: 'Release lane',
                    accent: _cOlive,
                    controller: _leftController,
                    data: _setB,
                    heroModeEnabled: _leftEnabled,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: _FlowHost(
                    key: _rightKey,
                    title: 'Operations lane',
                    accent: _cNavy,
                    controller: _rightController,
                    data: _setD,
                    heroModeEnabled: _rightEnabled,
                    useShuttle: true,
                    usePlaceholder: true,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EventLog(title: 'Workspace event log', events: _events),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlowHost extends StatefulWidget {
  const _FlowHost({
    super.key,
    required this.title,
    required this.accent,
    required this.controller,
    required this.data,
    this.heroModeEnabled = true,
    this.useShuttle = false,
    this.usePlaceholder = false,
  });

  final String title;
  final Color accent;
  final _LoggingHeroController controller;
  final List<_FlowCard> data;
  final bool heroModeEnabled;
  final bool useShuttle;
  final bool usePlaceholder;

  @override
  State<_FlowHost> createState() => _FlowHostState();
}

class _FlowHostState extends State<_FlowHost> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  int _step = 0;

  void openByStep() {
    final _FlowCard card = widget.data[_step % widget.data.length];
    _step += 1;
    _navKey.currentState?.pushNamed('/detail', arguments: card);
  }

  void openByIndex(int index) {
    final _FlowCard card = widget.data[index % widget.data.length];
    _navKey.currentState?.pushNamed('/detail', arguments: card);
  }

  void replaceTop() {
    final _FlowCard card = widget.data[_step % widget.data.length];
    _step += 1;
    _navKey.currentState?.pushReplacementNamed('/detail', arguments: card);
  }

  void popOne() {
    _navKey.currentState?.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Navigator(
        key: _navKey,
        observers: <NavigatorObserver>[widget.controller],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) {
              if (settings.name == '/detail' && settings.arguments is _FlowCard) {
                final _FlowCard card = settings.arguments! as _FlowCard;
                return _DetailPage(
                  title: widget.title,
                  card: card,
                  accent: widget.accent,
                  heroModeEnabled: widget.heroModeEnabled,
                  useShuttle: widget.useShuttle,
                  usePlaceholder: widget.usePlaceholder,
                  onBack: popOne,
                );
              }
              return _CatalogPage(
                title: widget.title,
                cards: widget.data,
                accent: widget.accent,
                heroModeEnabled: widget.heroModeEnabled,
                useShuttle: widget.useShuttle,
                usePlaceholder: widget.usePlaceholder,
                onOpen: (card) {
                  _navKey.currentState?.pushNamed('/detail', arguments: card);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _CatalogPage extends StatelessWidget {
  const _CatalogPage({
    required this.title,
    required this.cards,
    required this.accent,
    required this.heroModeEnabled,
    required this.useShuttle,
    required this.usePlaceholder,
    required this.onOpen,
  });

  final String title;
  final List<_FlowCard> cards;
  final Color accent;
  final bool heroModeEnabled;
  final bool useShuttle;
  final bool usePlaceholder;
  final ValueChanged<_FlowCard> onOpen;

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: heroModeEnabled,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FBFE),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(
                      'HeroMode ${heroModeEnabled ? 'enabled' : 'disabled'} | Shuttle ${useShuttle ? 'custom' : 'default'} | Placeholder ${usePlaceholder ? 'custom' : 'default'}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF56697A)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.05,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final _FlowCard card = cards[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => onOpen(card),
                      child: Hero(
                        tag: card.tag,
                        flightShuttleBuilder: useShuttle ? _demoShuttle : null,
                        placeholderBuilder: usePlaceholder ? _demoPlaceholder : null,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [card.color.withValues(alpha: 0.25), card.color.withValues(alpha: 0.12)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: card.color.withValues(alpha: 0.4)),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(card.icon, color: card.color),
                              const SizedBox(height: 8),
                              Text(card.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(card.summary, style: const TextStyle(fontSize: 12, height: 1.33, color: Color(0xFF4D5F6F))),
                              ),
                              const SizedBox(height: 4),
                              const Text('Open detail', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage({
    required this.title,
    required this.card,
    required this.accent,
    required this.heroModeEnabled,
    required this.useShuttle,
    required this.usePlaceholder,
    required this.onBack,
  });

  final String title;
  final _FlowCard card;
  final Color accent;
  final bool heroModeEnabled;
  final bool useShuttle;
  final bool usePlaceholder;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: heroModeEnabled,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FBFE),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _ActionButton(label: 'Back', color: accent, onPressed: onBack),
                  const SizedBox(width: 8),
                  Expanded(child: Text('$title / ${card.title}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18))),
                ],
              ),
              const SizedBox(height: 8),
              Hero(
                tag: card.tag,
                flightShuttleBuilder: useShuttle ? _demoShuttle : null,
                placeholderBuilder: usePlaceholder ? _demoPlaceholder : null,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [card.color.withValues(alpha: 0.3), card.color.withValues(alpha: 0.12)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: card.color.withValues(alpha: 0.45)),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(card.icon, color: card.color, size: 30),
                          const SizedBox(width: 8),
                          Expanded(child: Text(card.title, style: TextStyle(fontWeight: FontWeight.w800, color: card.color, fontSize: 17))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(card.summary, style: const TextStyle(height: 1.38)),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFD9E3EC)),
                          ),
                          child: Text(card.detail, style: const TextStyle(height: 1.4, color: Color(0xFF3E5060))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    _InfoTile(
                      title: 'Controller-level insight',
                      body:
                          'This transition is not managed by the Hero widget alone: HeroController pairs tags between routes and coordinates the overlay flight while route animations progress.',
                    ),
                    const SizedBox(height: 8),
                    _InfoTile(
                      title: 'Tween strategy effect',
                      body:
                          'If createRectTween differs across controllers, the same list/detail pair can feel dramatically different. Compare linear strictness, material arc natural pathing, and elastic expressive motion.',
                    ),
                    const SizedBox(height: 8),
                    _InfoTile(
                      title: 'Observer diagnostics',
                      body:
                          'When debugging missing flights, observer logs around didChangeTop and didReplace help confirm route state and transition timing from the controller perspective.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE5EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(height: 1.36, color: Color(0xFF4E6171))),
        ],
      ),
    );
  }
}

class _FlowCard {
  const _FlowCard({
    required this.tag,
    required this.title,
    required this.summary,
    required this.detail,
    required this.icon,
    required this.color,
  });

  final String tag;
  final String title;
  final String summary;
  final String detail;
  final IconData icon;
  final Color color;
}

class _LoggingHeroController extends HeroController {
  _LoggingHeroController({
    required this.controllerId,
    required this.onEvent,
    super.createRectTween,
  });

  final String controllerId;
  final ValueChanged<String> onEvent;

  String _name(Route<dynamic>? route) => route?.settings.name ?? '(unnamed)';

  void _log(String message) {
    onEvent('$controllerId | $message');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('didPush ${_name(route)} from ${_name(previousRoute)}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('didPop ${_name(route)} to ${_name(previousRoute)}');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log('didReplace ${_name(oldRoute)} -> ${_name(newRoute)}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    _log('didChangeTop ${_name(previousTopRoute)} -> ${_name(topRoute)}');
    super.didChangeTop(topRoute, previousTopRoute);
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('didStartUserGesture route=${_name(route)} prev=${_name(previousRoute)}');
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    _log('didStopUserGesture');
    super.didStopUserGesture();
  }
}

class _ElasticRectTween extends RectTween {
  _ElasticRectTween({required super.begin, required super.end});

  @override
  Rect? lerp(double t) {
    final double curved = Curves.easeOutBack.transform(t);
    return Rect.lerp(begin, end, curved);
  }
}

Widget _demoShuttle(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  final Hero toHero = toHeroContext.widget as Hero;
  return AnimatedBuilder(
    animation: animation,
    builder: (context, _) {
      final double t = Curves.easeInOutCubic.transform(animation.value);
      final double scale = flightDirection == HeroFlightDirection.push ? (0.9 + 0.1 * t) : (1.0 - 0.08 * t);
      return Transform.scale(
        scale: scale,
        child: Opacity(opacity: 0.88 + 0.12 * t, child: toHero.child),
      );
    },
  );
}

Widget _demoPlaceholder(BuildContext context, Size heroSize, Widget child) {
  return Container(
    width: heroSize.width,
    height: heroSize.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFFEAF0F7),
      border: Border.all(color: const Color(0xFFCCD7E3)),
    ),
    alignment: Alignment.center,
    child: const Text('Placeholder', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
  );
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9FCFF), Color(0xFFECF3F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD7E2ED)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid) CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double step = 22;
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.color, required this.onPressed});

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

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

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
  const _EventLog({required this.title, required this.events});

  final String title;
  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE6F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events captured yet.', style: TextStyle(color: Color(0xFF5D7082)))
          else
            ...events.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(entry, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF142F44),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: HeroController',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'HeroController is the orchestration center for hero flights at navigator level. Use it intentionally as an observer, customize createRectTween for motion language, and assign independent instances to parallel navigators for stable behavior in complex apps.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.4),
          ),
        ],
      ),
    );
  }
}

const List<_FlowCard> _setA = <_FlowCard>[
  _FlowCard(
    tag: 'a-portfolio',
    title: 'Portfolio',
    summary: 'Program overview tiles and executive context.',
    detail: 'Portfolio details combine strategic highlights and ongoing portfolio risks with transition continuity.',
    icon: Icons.account_tree,
    color: Color(0xFF2E6FA6),
  ),
  _FlowCard(
    tag: 'a-milestones',
    title: 'Milestones',
    summary: 'Milestone lane with completion trajectories.',
    detail: 'Milestone details stress layout transformations from compact cards to descriptive panes.',
    icon: Icons.flag,
    color: Color(0xFF3C8E7A),
  ),
  _FlowCard(
    tag: 'a-risks',
    title: 'Risks',
    summary: 'Blockers and mitigation decisions.',
    detail: 'Risk details provide text-heavy sections that make route shifts and animation feel differences easy to read.',
    icon: Icons.warning_amber,
    color: Color(0xFFBD7C35),
  ),
  _FlowCard(
    tag: 'a-budget',
    title: 'Budget',
    summary: 'Financial confidence and burn pattern.',
    detail: 'Budget details emphasize consistency between list origin and destination context to reduce user cognitive load.',
    icon: Icons.pie_chart,
    color: Color(0xFF7162B2),
  ),
  _FlowCard(
    tag: 'a-quality',
    title: 'Quality',
    summary: 'Regression watch and release confidence.',
    detail: 'Quality details focus on comparing multiple diagnostics with persistent hero anchors.',
    icon: Icons.rule_folder,
    color: Color(0xFF8D4F71),
  ),
  _FlowCard(
    tag: 'a-ops',
    title: 'Operations',
    summary: 'Live operational checkpoints.',
    detail: 'Operations details are useful for quickly repeating push/pop cycles while observing controller logs.',
    icon: Icons.monitor_heart,
    color: Color(0xFF537747),
  ),
];

const List<_FlowCard> _setB = <_FlowCard>[
  _FlowCard(
    tag: 'b-alpha',
    title: 'Alpha lane',
    summary: 'Early concept iteration stream.',
    detail: 'Alpha detail compares route operations under changing observer contexts.',
    icon: Icons.layers,
    color: Color(0xFF446EAA),
  ),
  _FlowCard(
    tag: 'b-beta',
    title: 'Beta lane',
    summary: 'Validation and review route.',
    detail: 'Beta detail contains rich sections to observe route-replace effects with hero continuity.',
    icon: Icons.science,
    color: Color(0xFF5A8A7A),
  ),
  _FlowCard(
    tag: 'b-gamma',
    title: 'Gamma lane',
    summary: 'Handoff and integration route.',
    detail: 'Gamma detail showcases transitions from concise cards to full operational context.',
    icon: Icons.hub,
    color: Color(0xFF9D6A39),
  ),
  _FlowCard(
    tag: 'b-delta',
    title: 'Delta lane',
    summary: 'Field operation route stream.',
    detail: 'Delta detail supports repeated pushes and pops to inspect didChangeTop ordering.',
    icon: Icons.route,
    color: Color(0xFF7A66AF),
  ),
  _FlowCard(
    tag: 'b-epsilon',
    title: 'Epsilon lane',
    summary: 'Refinement and closure prep.',
    detail: 'Epsilon detail gives clear before/after regions that reveal tween path differences.',
    icon: Icons.draw,
    color: Color(0xFF8D4C69),
  ),
  _FlowCard(
    tag: 'b-zeta',
    title: 'Zeta lane',
    summary: 'Approval and sign-off track.',
    detail: 'Zeta detail is excellent for replace-route drills with preserved hero tags.',
    icon: Icons.checklist,
    color: Color(0xFF67733E),
  ),
];

const List<_FlowCard> _setC = <_FlowCard>[
  _FlowCard(
    tag: 'c-backlog',
    title: 'Backlog',
    summary: 'Prioritized tactical queue.',
    detail: 'Backlog detail serves as baseline for direct linear motion comparison.',
    icon: Icons.view_stream,
    color: Color(0xFF2E69A1),
  ),
  _FlowCard(
    tag: 'c-design',
    title: 'Design',
    summary: 'Visual and interaction specifications.',
    detail: 'Design detail highlights curved flights as content stretches between list and detail.',
    icon: Icons.design_services,
    color: Color(0xFF3E8B79),
  ),
  _FlowCard(
    tag: 'c-build',
    title: 'Build',
    summary: 'Integration and assembly route.',
    detail: 'Build detail emphasizes pace changes in custom elastic transitions.',
    icon: Icons.build_circle,
    color: Color(0xFFB97837),
  ),
  _FlowCard(
    tag: 'c-test',
    title: 'Test',
    summary: 'Verification and confidence checks.',
    detail: 'Test detail is suited for repeated synchronized pushes across multiple controllers.',
    icon: Icons.fact_check,
    color: Color(0xFF6E63AF),
  ),
  _FlowCard(
    tag: 'c-deploy',
    title: 'Deploy',
    summary: 'Rollout planning and guardrails.',
    detail: 'Deploy detail keeps anchor identity clear while paths diverge by tween strategy.',
    icon: Icons.rocket_launch,
    color: Color(0xFF8D4E70),
  ),
  _FlowCard(
    tag: 'c-observe',
    title: 'Observe',
    summary: 'Telemetry and triage surface.',
    detail: 'Observe detail demonstrates route changes where perception of speed matters most.',
    icon: Icons.visibility,
    color: Color(0xFF67723D),
  ),
];

const List<_FlowCard> _setD = <_FlowCard>[
  _FlowCard(
    tag: 'd-radar',
    title: 'Radar',
    summary: 'Incoming issue radar with alert grouping.',
    detail: 'Radar detail is designed for fast retargeting under stress conditions.',
    icon: Icons.radar,
    color: Color(0xFF2F6DA2),
  ),
  _FlowCard(
    tag: 'd-trace',
    title: 'Trace',
    summary: 'Execution traces and sequence maps.',
    detail: 'Trace detail provides enough complexity to reveal diversion behavior mid-flight.',
    icon: Icons.timeline,
    color: Color(0xFF3E8A78),
  ),
  _FlowCard(
    tag: 'd-alert',
    title: 'Alert',
    summary: 'Priority escalations and handling.',
    detail: 'Alert detail demonstrates quick replace operations while preserving narrative continuity.',
    icon: Icons.notification_important,
    color: Color(0xFFB97837),
  ),
  _FlowCard(
    tag: 'd-pulse',
    title: 'Pulse',
    summary: 'Heartbeat metrics over time.',
    detail: 'Pulse detail helps compare bounce-like elastic transitions against default expectations.',
    icon: Icons.favorite,
    color: Color(0xFF6E63AF),
  ),
  _FlowCard(
    tag: 'd-queue',
    title: 'Queue',
    summary: 'Dispatch queue and assignment flow.',
    detail: 'Queue detail keeps route context stable while operations are retargeted rapidly.',
    icon: Icons.queue,
    color: Color(0xFF8D4E70),
  ),
  _FlowCard(
    tag: 'd-recover',
    title: 'Recover',
    summary: 'Remediation and rollback pathways.',
    detail: 'Recover detail is useful to study transition stability after repeated redirect bursts.',
    icon: Icons.restore,
    color: Color(0xFF66723D),
  ),
];
