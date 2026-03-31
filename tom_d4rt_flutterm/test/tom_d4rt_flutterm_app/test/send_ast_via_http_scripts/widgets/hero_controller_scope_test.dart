import 'package:flutter/material.dart';

const _cInk = Color(0xFF123D66);
const _cAmber = Color(0xFFC6863E);
const _cMint = Color(0xFF2F8578);
const _cRose = Color(0xFF90506F);
const _cViolet = Color(0xFF5D5AA8);
const _cOlive = Color(0xFF6A7035);

dynamic build(BuildContext context) {
  return const _HeroControllerScopeDeepDemoApp();
}

class _HeroControllerScopeDeepDemoApp extends StatelessWidget {
  const _HeroControllerScopeDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cInk),
        scaffoldBackgroundColor: const Color(0xFFF3F6FA),
      ),
      home: const _HeroScopeLabPage(),
    );
  }
}

class _HeroScopeLabPage extends StatefulWidget {
  const _HeroScopeLabPage();

  @override
  State<_HeroScopeLabPage> createState() => _HeroScopeLabPageState();
}

class _HeroScopeLabPageState extends State<_HeroScopeLabPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _rtl = false;
  _TweenStyle _globalTween = _TweenStyle.materialArc;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      globalTween: _globalTween,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cInk,
          foregroundColor: Colors.white,
          toolbarHeight: 82,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('HeroControllerScope Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Global tween style: ${config.globalTween.label}',
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
                compact: _compact,
                showGrid: _showGrid,
                rtl: _rtl,
                tween: _globalTween,
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onRtlChanged: (value) => setState(() => _rtl = value),
                onTweenChanged: (value) => setState(() => _globalTween = value),
              ),
              const SizedBox(height: 12),
              const _SceneCard(
                index: 1,
                accent: _cInk,
                title: 'What HeroControllerScope Does',
                subtitle:
                    'HeroControllerScope hosts a HeroController that navigators below can pick up. It also provides a scope boundary and supports HeroControllerScope.none to block inherited controllers.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _cAmber,
                title: 'Scope Introspection: of / maybeOf / none',
                subtitle:
                    'Inspects controller lookup behavior with normal scope and HeroControllerScope.none boundary using controlled builder contexts.',
                child: _ScopeIntrospectionScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _cMint,
                title: 'Single Navigator with Scoped Controller',
                subtitle:
                    'A focused hero flow under an explicit HeroControllerScope, with tween style and in-flight behavior controls.',
                child: _SingleScopedNavigatorScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _cRose,
                title: 'Boundary Isolation with HeroControllerScope.none',
                subtitle:
                    'Side-by-side flows: one inherits a scoped controller, one is blocked by HeroControllerScope.none to demonstrate scope isolation.',
                child: _ScopeBoundaryScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _cViolet,
                title: 'Parallel Navigators Best Practice',
                subtitle:
                    'Shows the recommended pattern: each sibling navigator gets its own HeroController instance instead of sharing one in parallel.',
                child: _ParallelNavigatorScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _cOlive,
                title: 'Practical Workspace Composition',
                subtitle:
                    'Applies HeroControllerScope to a realistic dashboard containing multiple embedded flows, logs, and mode toggles.',
                child: _PracticalWorkspaceScene(config: config),
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
    required this.textDirection,
    required this.globalTween,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final _TweenStyle globalTween;
}

enum _TweenStyle {
  materialArc('Material arc'),
  linear('Linear rect'),
  softCurve('Soft curved');

  const _TweenStyle(this.label);
  final String label;
}

class _HeroControlDeck extends StatelessWidget {
  const _HeroControlDeck({
    required this.compact,
    required this.showGrid,
    required this.rtl,
    required this.tween,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onRtlChanged,
    required this.onTweenChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool rtl;
  final _TweenStyle tween;

  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<_TweenStyle> onTweenChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173F67), Color(0xFF2F5F7E), Color(0xFF6E4F69)],
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
              'Hero Scope Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
            ),
            const SizedBox(height: 6),
            const Text(
              'This lab focuses on controller scoping rather than only Hero visuals. Use the switches to alter layout context while each scenario demonstrates explicit scope boundaries and navigator ownership.',
              style: TextStyle(color: Color(0xFFE7F2FB), height: 1.42),
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
            _TweenStyleField(value: tween, onChanged: onTweenChanged),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'HeroControllerScope.of + maybeOf'),
                _DeckTag(label: 'HeroControllerScope.none boundaries'),
                _DeckTag(label: 'One controller per navigator pattern'),
                _DeckTag(label: 'Custom createRectTween comparison'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TweenStyleField extends StatelessWidget {
  const _TweenStyleField({required this.value, required this.onChanged});

  final _TweenStyle value;
  final ValueChanged<_TweenStyle> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Global Hero Rect Tween Style', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<_TweenStyle>(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: const Color(0xFF315E79),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: _TweenStyle.values
                  .map(
                    (entry) => DropdownMenuItem<_TweenStyle>(
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

class _SceneCard extends StatelessWidget {
  const _SceneCard({
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
        const Text('Key ideas', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'Hero animations are coordinated by HeroController. HeroControllerScope provides the controller to the nearest navigator subtree and can deliberately cut inheritance using HeroControllerScope.none.',
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
              _Bullet(text: 'HeroControllerScope.of(context) asserts if no scope exists.'),
              _Bullet(text: 'HeroControllerScope.maybeOf(context) returns null safely outside scope.'),
              _Bullet(text: 'HeroControllerScope.none blocks inherited controller propagation.'),
              _Bullet(text: 'A HeroController should attach to only one navigator at a time.'),
              _Bullet(text: 'Custom createRectTween can change flight motion style significantly.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScopeIntrospectionScene extends StatefulWidget {
  const _ScopeIntrospectionScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ScopeIntrospectionScene> createState() => _ScopeIntrospectionSceneState();
}

class _ScopeIntrospectionSceneState extends State<_ScopeIntrospectionScene> {
  late final HeroController _inspectionController;
  final List<String> _log = <String>[];

  @override
  void initState() {
    super.initState();
    _inspectionController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
    );
  }

  @override
  void dispose() {
    _inspectionController.dispose();
    super.dispose();
  }

  void _push(String message) {
    setState(() {
      _log.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_log.length > 14) {
        _log.removeRange(14, _log.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 300 : 370,
      child: Row(
        children: [
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: HeroControllerScope(
                controller: _inspectionController,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Inside explicit HeroControllerScope', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final HeroController? maybe = HeroControllerScope.maybeOf(context);
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: _panelBox(),
                            child: Text('maybeOf => ${maybe.runtimeType} #${maybe.hashCode}'),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          return _ActionButton(
                            label: 'Call HeroControllerScope.of',
                            color: _cAmber,
                            onPressed: () {
                              final HeroController controller = HeroControllerScope.of(context);
                              _push('inside scope: of() => ${controller.runtimeType} #${controller.hashCode}');
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      HeroControllerScope.none(
                        child: Builder(
                          builder: (context) {
                            final HeroController? maybe = HeroControllerScope.maybeOf(context);
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: _panelBox(color: const Color(0xFFFBEFF3), border: const Color(0xFFE8CAD6)),
                              child: Text('Inside HeroControllerScope.none => maybeOf: ${maybe == null ? 'null' : maybe.hashCode}'),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      HeroControllerScope.none(
                        child: Builder(
                          builder: (context) {
                            return _ActionButton(
                              label: 'Call of() inside none',
                              color: _cRose,
                              onPressed: () {
                                try {
                                  final HeroController controller = HeroControllerScope.of(context);
                                  _push('unexpected: of() inside none => ${controller.hashCode}');
                                } catch (error) {
                                  _push('inside none: of() threw ${error.runtimeType}');
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _EventLog(title: 'Scope lookup log', events: _log),
          ),
        ],
      ),
    );
  }
}

class _SingleScopedNavigatorScene extends StatefulWidget {
  const _SingleScopedNavigatorScene({required this.config});

  final _DemoConfig config;

  @override
  State<_SingleScopedNavigatorScene> createState() => _SingleScopedNavigatorSceneState();
}

class _SingleScopedNavigatorSceneState extends State<_SingleScopedNavigatorScene> {
  late final HeroController _materialController;
  late final HeroController _linearController;
  late final HeroController _softController;

  bool _heroMode = true;
  bool _useShuttle = false;
  bool _usePlaceholder = false;

  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _materialController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
    );
    _linearController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => RectTween(begin: begin, end: end),
    );
    _softController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => _SoftRectTween(begin: begin, end: end),
    );
  }

  @override
  void dispose() {
    _materialController.dispose();
    _linearController.dispose();
    _softController.dispose();
    super.dispose();
  }

  HeroController _selectController(_TweenStyle style) {
    switch (style) {
      case _TweenStyle.materialArc:
        return _materialController;
      case _TweenStyle.linear:
        return _linearController;
      case _TweenStyle.softCurve:
        return _softController;
    }
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 16) {
        _events.removeRange(16, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final HeroController controller = _selectController(config.globalTween);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('HeroMode enabled'),
              selected: _heroMode,
              onSelected: (value) => setState(() => _heroMode = value),
            ),
            FilterChip(
              label: const Text('Custom shuttle'),
              selected: _useShuttle,
              onSelected: (value) => setState(() => _useShuttle = value),
            ),
            FilterChip(
              label: const Text('Placeholder builder'),
              selected: _usePlaceholder,
              onSelected: (value) => setState(() => _usePlaceholder = value),
            ),
            _ActionButton(
              label: 'Clear log',
              color: _cMint,
              onPressed: () => setState(_events.clear),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Active tween style: ${config.globalTween.label}', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 350 : 430,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: HeroControllerScope(
                    controller: controller,
                    child: _HeroMiniFlow(
                      flowId: 'single',
                      title: 'Scoped Flow',
                      accent: _cMint,
                      compact: config.compact,
                      heroModeEnabled: _heroMode,
                      useShuttle: _useShuttle,
                      usePlaceholder: _usePlaceholder,
                      onEvent: _push,
                      items: _sampleItemsA,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'Single flow log', events: _events)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScopeBoundaryScene extends StatefulWidget {
  const _ScopeBoundaryScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ScopeBoundaryScene> createState() => _ScopeBoundarySceneState();
}

class _ScopeBoundarySceneState extends State<_ScopeBoundaryScene> {
  late final HeroController _leftController;
  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _leftController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
    );
  }

  @override
  void dispose() {
    _leftController.dispose();
    super.dispose();
  }

  void _push(String message) {
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
    final double stageHeight = config.compact ? 390 : 460;

    return SizedBox(
      height: stageHeight,
      child: Row(
        children: [
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: HeroControllerScope(
                controller: _leftController,
                child: _HeroMiniFlow(
                  flowId: 'boundary-left',
                  title: 'Left: inherited scope',
                  accent: _cRose,
                  compact: config.compact,
                  heroModeEnabled: true,
                  useShuttle: false,
                  usePlaceholder: true,
                  onEvent: (event) => _push('left | $event'),
                  items: _sampleItemsB,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: HeroControllerScope.none(
                child: _HeroMiniFlow(
                  flowId: 'boundary-right',
                  title: 'Right: scope blocked by none',
                  accent: const Color(0xFF8F8F8F),
                  compact: config.compact,
                  heroModeEnabled: true,
                  useShuttle: false,
                  usePlaceholder: true,
                  onEvent: (event) => _push('right | $event'),
                  items: _sampleItemsB,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _EventLog(title: 'Boundary comparison log', events: _events),
          ),
        ],
      ),
    );
  }
}

class _ParallelNavigatorScene extends StatefulWidget {
  const _ParallelNavigatorScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ParallelNavigatorScene> createState() => _ParallelNavigatorSceneState();
}

class _ParallelNavigatorSceneState extends State<_ParallelNavigatorScene> {
  late final HeroController _leftController;
  late final HeroController _rightController;
  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _leftController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
    );
    _rightController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => _SoftRectTween(begin: begin, end: end),
    );
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  void _push(String message) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: _panelBox(),
          child: const Text(
            'Both flows are visible at the same time. Each is given its own HeroController to avoid the parallel-scope assertion that occurs when one controller subscribes to multiple navigators.',
            style: TextStyle(height: 1.34),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 380 : 460,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: HeroControllerScope(
                    controller: _leftController,
                    child: _HeroMiniFlow(
                      flowId: 'parallel-left',
                      title: 'Left Navigator',
                      accent: _cViolet,
                      compact: config.compact,
                      heroModeEnabled: true,
                      useShuttle: false,
                      usePlaceholder: false,
                      onEvent: (event) => _push('left | $event'),
                      items: _sampleItemsC,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: HeroControllerScope(
                    controller: _rightController,
                    child: _HeroMiniFlow(
                      flowId: 'parallel-right',
                      title: 'Right Navigator',
                      accent: _cInk,
                      compact: config.compact,
                      heroModeEnabled: true,
                      useShuttle: true,
                      usePlaceholder: true,
                      onEvent: (event) => _push('right | $event'),
                      items: _sampleItemsC,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(title: 'Parallel flow log', events: _events)),
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
  late final HeroController _feedController;
  late final HeroController _boardController;
  int _selected = 0;
  bool _feedHeroMode = true;
  bool _boardHeroMode = true;
  final List<String> _events = <String>[];

  final List<_WorkspaceSection> _sections = const [
    _WorkspaceSection('Planning', 'Route transitions for planning cards with stable scope ownership.', _cInk),
    _WorkspaceSection('Review', 'Compare card flights between two independent navigator regions.', _cViolet),
    _WorkspaceSection('Release', 'Use placeholders to keep layout continuity during flights.', _cOlive),
    _WorkspaceSection('Ops', 'Boundaries with none help isolate route islands in dense shells.', _cRose),
  ];

  @override
  void initState() {
    super.initState();
    _feedController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => MaterialRectArcTween(begin: begin, end: end),
    );
    _boardController = HeroController(
      createRectTween: (Rect? begin, Rect? end) => _SoftRectTween(begin: begin, end: end),
    );
  }

  @override
  void dispose() {
    _feedController.dispose();
    _boardController.dispose();
    super.dispose();
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 20) {
        _events.removeRange(20, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final section = _sections[_selected];

    return SizedBox(
      height: config.compact ? 520 : 620,
      child: Row(
        children: [
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _sections.length,
                        (index) => ChoiceChip(
                          selected: _selected == index,
                          label: Text(_sections[index].title),
                          onSelected: (_) => setState(() => _selected = index),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: section.color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: section.color.withValues(alpha: 0.35)),
                      ),
                      child: Text(section.description, style: const TextStyle(fontWeight: FontWeight.w700, height: 1.34)),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          label: const Text('Feed HeroMode'),
                          selected: _feedHeroMode,
                          onSelected: (value) => setState(() => _feedHeroMode = value),
                        ),
                        FilterChip(
                          label: const Text('Board HeroMode'),
                          selected: _boardHeroMode,
                          onSelected: (value) => setState(() => _boardHeroMode = value),
                        ),
                        _ActionButton(
                          label: 'Clear',
                          color: section.color,
                          onPressed: () => setState(_events.clear),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: HeroControllerScope(
                              controller: _feedController,
                              child: _HeroMiniFlow(
                                flowId: 'workspace-feed',
                                title: 'Feed lane',
                                accent: section.color,
                                compact: config.compact,
                                heroModeEnabled: _feedHeroMode,
                                useShuttle: false,
                                usePlaceholder: true,
                                onEvent: (event) => _push('feed | $event'),
                                items: _sampleItemsA,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: HeroControllerScope(
                              controller: _boardController,
                              child: _HeroMiniFlow(
                                flowId: 'workspace-board',
                                title: 'Board lane',
                                accent: _cViolet,
                                compact: config.compact,
                                heroModeEnabled: _boardHeroMode,
                                useShuttle: true,
                                usePlaceholder: true,
                                onEvent: (event) => _push('board | $event'),
                                items: _sampleItemsC,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: _EventLog(title: 'Workspace log', events: _events)),
        ],
      ),
    );
  }
}

class _WorkspaceSection {
  const _WorkspaceSection(this.title, this.description, this.color);

  final String title;
  final String description;
  final Color color;
}

class _HeroMiniFlow extends StatefulWidget {
  const _HeroMiniFlow({
    required this.flowId,
    required this.title,
    required this.accent,
    required this.compact,
    required this.heroModeEnabled,
    required this.useShuttle,
    required this.usePlaceholder,
    required this.onEvent,
    required this.items,
  });

  final String flowId;
  final String title;
  final Color accent;
  final bool compact;
  final bool heroModeEnabled;
  final bool useShuttle;
  final bool usePlaceholder;
  final ValueChanged<String> onEvent;
  final List<_FlowItem> items;

  @override
  State<_HeroMiniFlow> createState() => _HeroMiniFlowState();
}

class _HeroMiniFlowState extends State<_HeroMiniFlow> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) {
              if (settings.name == '/detail' && settings.arguments is _FlowItem) {
                final _FlowItem item = settings.arguments! as _FlowItem;
                return _HeroDetailPage(
                  flowId: widget.flowId,
                  item: item,
                  accent: widget.accent,
                  compact: widget.compact,
                  useShuttle: widget.useShuttle,
                  usePlaceholder: widget.usePlaceholder,
                  onBack: () {
                    widget.onEvent('${widget.flowId}: pop detail ${item.title}');
                    _navigatorKey.currentState?.maybePop();
                  },
                );
              }
              return _HeroCatalogPage(
                flowId: widget.flowId,
                title: widget.title,
                accent: widget.accent,
                compact: widget.compact,
                heroModeEnabled: widget.heroModeEnabled,
                useShuttle: widget.useShuttle,
                usePlaceholder: widget.usePlaceholder,
                items: widget.items,
                onOpen: (item) {
                  widget.onEvent('${widget.flowId}: push detail ${item.title}');
                  _navigatorKey.currentState?.pushNamed('/detail', arguments: item);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _HeroCatalogPage extends StatelessWidget {
  const _HeroCatalogPage({
    required this.flowId,
    required this.title,
    required this.accent,
    required this.compact,
    required this.heroModeEnabled,
    required this.useShuttle,
    required this.usePlaceholder,
    required this.items,
    required this.onOpen,
  });

  final String flowId;
  final String title;
  final Color accent;
  final bool compact;
  final bool heroModeEnabled;
  final bool useShuttle;
  final bool usePlaceholder;
  final List<_FlowItem> items;
  final ValueChanged<_FlowItem> onOpen;

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: heroModeEnabled,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAFD),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accent.withValues(alpha: 0.34)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(
                      'HeroMode: ${heroModeEnabled ? 'enabled' : 'disabled'} | Shuttle: ${useShuttle ? 'custom' : 'default'} | Placeholder: ${usePlaceholder ? 'custom' : 'default'}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF5B6C7B)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: compact ? 2 : 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: compact ? 1.02 : 0.95,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return InkWell(
                      onTap: () => onOpen(item),
                      borderRadius: BorderRadius.circular(12),
                      child: Hero(
                        tag: '$flowId-${item.id}',
                        flightShuttleBuilder: useShuttle ? _heroShuttle : null,
                        placeholderBuilder: usePlaceholder ? _heroPlaceholder : null,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                item.color.withValues(alpha: 0.25),
                                item.color.withValues(alpha: 0.14),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: item.color.withValues(alpha: 0.4)),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(item.icon, color: item.color),
                              const SizedBox(height: 8),
                              Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  item.summary,
                                  style: const TextStyle(fontSize: 12, height: 1.32, color: Color(0xFF4F6070)),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text('Tap for detail', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
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

class _HeroDetailPage extends StatelessWidget {
  const _HeroDetailPage({
    required this.flowId,
    required this.item,
    required this.accent,
    required this.compact,
    required this.useShuttle,
    required this.usePlaceholder,
    required this.onBack,
  });

  final String flowId;
  final _FlowItem item;
  final Color accent;
  final bool compact;
  final bool useShuttle;
  final bool usePlaceholder;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final double panelHeight = compact ? 220 : 280;

    return Scaffold(
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
                Expanded(
                  child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Hero(
              tag: '$flowId-${item.id}',
              flightShuttleBuilder: useShuttle ? _heroShuttle : null,
              placeholderBuilder: usePlaceholder ? _heroPlaceholder : null,
              child: Container(
                width: double.infinity,
                height: panelHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [item.color.withValues(alpha: 0.3), item.color.withValues(alpha: 0.14)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: item.color.withValues(alpha: 0.45)),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(item.icon, color: item.color, size: 30),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('Detail View', style: TextStyle(fontWeight: FontWeight.w800, color: item.color, fontSize: 17)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(item.summary, style: const TextStyle(height: 1.4)),
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
                        child: Text(item.detail, style: const TextStyle(height: 1.4, color: Color(0xFF3E5060))),
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
                    title: 'Why use HeroControllerScope here?',
                    body:
                        'This flow runs in an embedded navigator. Explicit scoping ensures a predictable HeroController for this route island, independent from other sibling navigator regions.',
                  ),
                  const SizedBox(height: 8),
                  _InfoTile(
                    title: 'When to use HeroControllerScope.none',
                    body:
                        'Use none around subtrees that must not inherit a parent controller, especially when embedding parallel navigators or plugging route islands into reusable shells.',
                  ),
                  const SizedBox(height: 8),
                  _InfoTile(
                    title: 'createRectTween impact',
                    body:
                        'Switching tween style changes perceived motion. MaterialRectArcTween follows a curved path, while linear and custom variants produce noticeably different movement cues.',
                  ),
                ],
              ),
            ),
          ],
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

Widget _heroShuttle(
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
      final double scale = flightDirection == HeroFlightDirection.push ? (0.92 + 0.08 * t) : (1.0 - 0.08 * t);
      return Transform.scale(
        scale: scale,
        child: Opacity(opacity: 0.88 + 0.12 * t, child: toHero.child),
      );
    },
  );
}

Widget _heroPlaceholder(BuildContext context, Size heroSize, Widget child) {
  return Container(
    width: heroSize.width,
    height: heroSize.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFFEAF0F7),
      border: Border.all(color: const Color(0xFFCCD7E3), style: BorderStyle.solid),
    ),
    alignment: Alignment.center,
    child: const Text('Hero placeholder', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
  );
}

class _FlowItem {
  const _FlowItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.detail,
    required this.icon,
    required this.color,
  });

  final int id;
  final String title;
  final String summary;
  final String detail;
  final IconData icon;
  final Color color;
}

class _SoftRectTween extends RectTween {
  _SoftRectTween({required super.begin, required super.end});

  @override
  Rect? lerp(double t) {
    final double curved = Curves.easeInOutExpo.transform(t);
    return Rect.lerp(begin, end, curved);
  }
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

BoxDecoration _panelBox({Color color = const Color(0xFFF2F7FC), Color border = const Color(0xFFD6E2EE)}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: border),
  );
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

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
            'Recap: HeroControllerScope',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use HeroControllerScope to make controller ownership explicit for route islands. Reach for HeroControllerScope.none when embedding subtrees that must not inherit parent hero behavior, and assign distinct controllers to parallel navigators to avoid ownership conflicts.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.4),
          ),
        ],
      ),
    );
  }
}

const List<_FlowItem> _sampleItemsA = <_FlowItem>[
  _FlowItem(
    id: 1,
    title: 'Portfolio',
    summary: 'Summarize active initiatives in a compact card deck.',
    detail: 'Portfolio route highlights executive themes, pending milestones, and signal metrics while preserving stable hero anchors.',
    icon: Icons.account_tree,
    color: Color(0xFF2C6CA4),
  ),
  _FlowItem(
    id: 2,
    title: 'Milestones',
    summary: 'Timeline cards with dependency insights.',
    detail: 'Milestone route demonstrates transitioning from dense grids to roomy detail cards without losing visual continuity.',
    icon: Icons.flag,
    color: Color(0xFF3C8C78),
  ),
  _FlowItem(
    id: 3,
    title: 'Risks',
    summary: 'Surface blockers and mitigation plans.',
    detail: 'Risk route gives every item a consistent hero tag path so users can map list context to detail remediation quickly.',
    icon: Icons.warning_amber,
    color: Color(0xFFBD7C35),
  ),
  _FlowItem(
    id: 4,
    title: 'Budget',
    summary: 'Track cost lanes and trend deltas.',
    detail: 'Budget detail mixes explanatory panels and hero-backed summary cards for calmer navigation transitions.',
    icon: Icons.pie_chart,
    color: Color(0xFF6F60B0),
  ),
  _FlowItem(
    id: 5,
    title: 'Quality',
    summary: 'Monitor regression and release confidence.',
    detail: 'Quality detail emphasizes side-by-side diagnostics while preserving shared visual identity from list card to detail panel.',
    icon: Icons.rule_folder,
    color: Color(0xFF8E4E72),
  ),
  _FlowItem(
    id: 6,
    title: 'Operations',
    summary: 'Live operational health snapshots.',
    detail: 'Operations detail demonstrates how HeroControllerScope can keep route motion coherent inside embedded navigators.',
    icon: Icons.monitor_heart,
    color: Color(0xFF517545),
  ),
];

const List<_FlowItem> _sampleItemsB = <_FlowItem>[
  _FlowItem(
    id: 11,
    title: 'Alpha lane',
    summary: 'Early concept exploration route.',
    detail: 'Alpha detail compares how scope inheritance affects hero coordination in tightly embedded route islands.',
    icon: Icons.layers,
    color: Color(0xFF446EAA),
  ),
  _FlowItem(
    id: 12,
    title: 'Beta lane',
    summary: 'Validation route with scenario cards.',
    detail: 'Beta detail provides enough visual density to make transition style differences easy to observe.',
    icon: Icons.science,
    color: Color(0xFF5A8A7A),
  ),
  _FlowItem(
    id: 13,
    title: 'Gamma lane',
    summary: 'Handoff route for production prep.',
    detail: 'Gamma detail includes narrative guidance and stable hero anchors for predictable transitions.',
    icon: Icons.hub,
    color: Color(0xFF9D6A39),
  ),
  _FlowItem(
    id: 14,
    title: 'Delta lane',
    summary: 'Field operation route stream.',
    detail: 'Delta route is useful for checking whether blocked scope still keeps route UX clear without inherited hero controller.',
    icon: Icons.route,
    color: Color(0xFF7A66AF),
  ),
  _FlowItem(
    id: 15,
    title: 'Epsilon lane',
    summary: 'Refinement loop and notes.',
    detail: 'Epsilon route demonstrates placeholder behavior when source and destination cards are hidden during flight.',
    icon: Icons.draw,
    color: Color(0xFF8D4C69),
  ),
  _FlowItem(
    id: 16,
    title: 'Zeta lane',
    summary: 'Closure checklist and approvals.',
    detail: 'Zeta detail keeps key context panels in view while hero flights reinforce continuity from the originating lane.',
    icon: Icons.checklist,
    color: Color(0xFF67733E),
  ),
];

const List<_FlowItem> _sampleItemsC = <_FlowItem>[
  _FlowItem(
    id: 21,
    title: 'Backlog',
    summary: 'Ranked items and confidence markers.',
    detail: 'Backlog detail gives a strong baseline for comparing curved vs custom rect tweens in parallel navigators.',
    icon: Icons.view_stream,
    color: Color(0xFF2E69A1),
  ),
  _FlowItem(
    id: 22,
    title: 'Design',
    summary: 'Visual specs and interaction notes.',
    detail: 'Design detail emphasizes descriptive text regions to make flights and placeholder behavior noticeable.',
    icon: Icons.design_services,
    color: Color(0xFF3E8B79),
  ),
  _FlowItem(
    id: 23,
    title: 'Build',
    summary: 'Integration track and status signals.',
    detail: 'Build detail illustrates repeated push/pop transitions under one controller per navigator ownership.',
    icon: Icons.build_circle,
    color: Color(0xFFB97837),
  ),
  _FlowItem(
    id: 24,
    title: 'Test',
    summary: 'Quality checkpoints and traces.',
    detail: 'Test detail is ideal for rapidly repeating transitions and comparing style smoothness between siblings.',
    icon: Icons.fact_check,
    color: Color(0xFF6E63AF),
  ),
  _FlowItem(
    id: 25,
    title: 'Deploy',
    summary: 'Delivery path and rollout gates.',
    detail: 'Deploy detail keeps anchored visual motifs so route transitions preserve user orientation under heavy context switches.',
    icon: Icons.rocket_launch,
    color: Color(0xFF8D4E70),
  ),
  _FlowItem(
    id: 26,
    title: 'Observe',
    summary: 'Post-release telemetry and triage.',
    detail: 'Observe detail demonstrates how custom shuttle visuals can improve readability during multi-lane monitoring workflows.',
    icon: Icons.visibility,
    color: Color(0xFF67723D),
  ),
];
