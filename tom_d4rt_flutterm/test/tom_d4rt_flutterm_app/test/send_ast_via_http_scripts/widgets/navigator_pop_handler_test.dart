import 'package:flutter/material.dart';

const _bg = Color(0xFFF3F7FC);
const _ink = Color(0xFF16374E);
const _blue = Color(0xFF2B679A);
const _teal = Color(0xFF2E8271);
const _amber = Color(0xFFAF7B34);
const _rose = Color(0xFF9D5F76);
const _violet = Color(0xFF685CB3);

dynamic build(BuildContext context) {
  return const _NavigatorPopHandlerDeepDemoApp();
}

class _NavigatorPopHandlerDeepDemoApp extends StatelessWidget {
  const _NavigatorPopHandlerDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _NavigatorPopHandlerDeepDemoPage(),
    );
  }
}

class _NavigatorPopHandlerDeepDemoPage extends StatefulWidget {
  const _NavigatorPopHandlerDeepDemoPage();

  @override
  State<_NavigatorPopHandlerDeepDemoPage> createState() => _NavigatorPopHandlerDeepDemoPageState();
}

class _NavigatorPopHandlerDeepDemoPageState extends State<_NavigatorPopHandlerDeepDemoPage> {
  bool _compact = false;
  bool _guides = true;
  bool _notes = true;
  bool _rtl = false;
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 94,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('NavigatorPopHandler Deep Demo'),
              Text(
                'nested navigator back handling | result channels | gated pop routing',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.86), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _GlobalDeck(
                compact: _compact,
                guides: _guides,
                notes: _notes,
                rtl: _rtl,
                zoom: _zoom,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuidesChanged: (v) => setState(() => _guides = v),
                onNotesChanged: (v) => setState(() => _notes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onZoomChanged: (v) => setState(() => _zoom = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _blue,
                title: 'Pop Fundamentals Studio',
                subtitle:
                    'Single nested navigator wrapped with NavigatorPopHandler and interactive controls for enabled, push, pop, and result logging.',
                child: _FundamentalsScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _teal,
                title: 'Handler Comparison Lab',
                subtitle:
                    'Two lanes run independent handlers and nested stacks to compare pop interception behavior and callback streams.',
                child: _ComparisonScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Result Channel Workshop',
                subtitle:
                    'Push pages that return different result payloads and inspect onPopWithResult logging in real time.',
                child: _ResultScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Workflow Guard Stage',
                subtitle:
                    'Flow-gated handler enablement illustrates controlled back behavior across critical multi-step operations.',
                child: _WorkflowScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Product Console',
                subtitle:
                    'Three realistic module headers and nested flows use NavigatorPopHandler as the route-aware pop coordination layer.',
                child: _PracticalScene(compact: _compact, guides: _guides, notes: _notes),
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

class _GlobalDeck extends StatelessWidget {
  const _GlobalDeck({
    required this.compact,
    required this.guides,
    required this.notes,
    required this.rtl,
    required this.zoom,
    required this.onCompactChanged,
    required this.onGuidesChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onZoomChanged,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool rtl;
  final double zoom;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuidesChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onZoomChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF18374D), Color(0xFF296A9D), Color(0xFF36816F), Color(0xFF675CB2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NavigatorPopHandler Control Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'NavigatorPopHandler helps coordinate back/pop behavior for nested navigators. '
            'It is especially useful when shell routes host internal navigation stacks that need custom pop routing.',
            style: TextStyle(color: Color(0xFFDCECF8), height: 1.35),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact scenes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: guides,
                  onChanged: onGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: notes,
                  onChanged: onNotesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Instruction notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text('Global scene zoom: ${zoom.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: zoom,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onZoomChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.32),
          ),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 7)),
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
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4F61), height: 1.34)),
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

class _MiniRoutePayload {
  const _MiniRoutePayload({required this.id, required this.description, required this.color});

  final String id;
  final String description;
  final Color color;

  @override
  String toString() => 'MiniRoutePayload(id: $id, description: $description)';
}

class _FlowPageData {
  const _FlowPageData({required this.index, required this.title, required this.tone});

  final int index;
  final String title;
  final Color tone;
}

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.compact, required this.guides, required this.notes, required this.zoom});

  final bool compact;
  final bool guides;
  final bool notes;
  final double zoom;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  bool _enabled = true;
  bool _useOnPop = true;
  bool _useOnPopWithResult = true;
  int _onPopCalls = 0;
  int _onPopWithResultCalls = 0;
  int _pushCount = 0;
  int _popCount = 0;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 940.0 : 1100.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fundamentals controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _enabled,
                        onChanged: (v) {
                          setState(() => _enabled = v);
                          _push('handler enabled=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('NavigatorPopHandler enabled'),
                      ),
                      SwitchListTile(
                        value: _useOnPop,
                        onChanged: (v) {
                          setState(() => _useOnPop = v);
                          _push('onPop callback active=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Use onPop callback'),
                      ),
                      SwitchListTile(
                        value: _useOnPopWithResult,
                        onChanged: (v) {
                          setState(() => _useOnPopWithResult = v);
                          _push('onPopWithResult callback active=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Use onPopWithResult callback'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: _pushRoute,
                            child: const Text('Push page'),
                          ),
                          FilledButton.tonal(
                            onPressed: _popRoute,
                            child: const Text('Pop page'),
                          ),
                          FilledButton.tonal(
                            onPressed: _popToRoot,
                            child: const Text('Pop to root'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('handler enabled', _enabled ? 'true' : 'false'),
                          _DataRowItem('push count', '$_pushCount'),
                          _DataRowItem('pop count', '$_popCount'),
                          _DataRowItem('onPop calls', '$_onPopCalls'),
                          _DataRowItem('onPopWithResult calls', '$_onPopWithResultCalls'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'Wrap nested navigators with NavigatorPopHandler when parent-level back handling must coordinate with inner stacks.',
                            'enabled toggles whether the handler is currently participating in pop handling.',
                            'Use onPopWithResult when popped routes return values that should be surfaced at the host level.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Fundamentals event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 190, child: _LogCard(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Transform.scale(
                scale: widget.zoom,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nested flow host', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _blue.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _blue.withValues(alpha: 0.24)),
                          ),
                          child: NavigatorPopHandler(
                            enabled: _enabled,
                            onPopWithResult: (result) {
                              if (_useOnPop) {
                                setState(() => _onPopCalls += 1);
                                _push('onPop-style signal (via onPopWithResult)');
                              }
                              if (_useOnPopWithResult) {
                                setState(() => _onPopWithResultCalls += 1);
                                _push('onPopWithResult: $result');
                              }
                            },
                            child: Navigator(
                              key: _navKey,
                              onGenerateRoute: (settings) {
                                final args = settings.arguments;
                                final data = args is _FlowPageData
                                    ? args
                                    : const _FlowPageData(index: 0, title: 'Root flow page', tone: _blue);
                                return MaterialPageRoute(
                                  settings: settings,
                                  builder: (context) {
                                    return _FlowCardPage(
                                      data: data,
                                      onPushNext: () {
                                        final next = _FlowPageData(
                                          index: data.index + 1,
                                          title: 'Flow page ${data.index + 1}',
                                          tone: _pickTone(data.index + 1),
                                        );
                                        _navKey.currentState?.pushNamed('/flow', arguments: next);
                                        setState(() => _pushCount += 1);
                                        _push('push from page ${data.index} -> ${data.index + 1}');
                                      },
                                      onPopWithText: () {
                                        _navKey.currentState?.pop('result-from-page-${data.index}');
                                        setState(() => _popCount += 1);
                                        _push('pop requested with result from page ${data.index}');
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushRoute() {
    final next = _FlowPageData(index: _pushCount + 1, title: 'Manual push ${_pushCount + 1}', tone: _pickTone(_pushCount + 1));
    _navKey.currentState?.pushNamed('/flow', arguments: next);
    setState(() => _pushCount += 1);
    _push('manual push ${next.index}');
  }

  Future<void> _popRoute() async {
    final result = await _navKey.currentState?.maybePop('manual-pop-${_popCount + 1}');
    if (result == true) {
      setState(() => _popCount += 1);
      _push('manual maybePop succeeded');
    } else {
      _push('manual maybePop ignored (already root)');
    }
  }

  void _popToRoot() {
    _navKey.currentState?.popUntil((route) => route.isFirst);
    _push('popUntil(root) invoked');
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 38);
    });
  }
}

class _FlowCardPage extends StatelessWidget {
  const _FlowCardPage({
    required this.data,
    required this.onPushNext,
    required this.onPopWithText,
  });

  final _FlowPageData data;
  final VoidCallback onPushNext;
  final VoidCallback onPopWithText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: data.tone.withValues(alpha: 0.08),
      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: data.tone.withValues(alpha: 0.32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: TextStyle(color: data.tone, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 6),
              Text('index: ${data.index}', style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text(
                'This nested page can push deeper pages and return results on pop. '
                'NavigatorPopHandler at the host level observes these pop events.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(onPressed: onPushNext, child: const Text('Push next page')),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.tonal(onPressed: onPopWithText, child: const Text('Pop with result')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComparisonScene extends StatefulWidget {
  const _ComparisonScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_ComparisonScene> createState() => _ComparisonSceneState();
}

class _ComparisonSceneState extends State<_ComparisonScene> {
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 940.0 : 1120.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Comparison notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text(
                      'The two lanes use the same nested flow but different handler enable defaults. '
                      'Compare callback logs while pushing and popping pages independently.',
                      style: TextStyle(height: 1.35),
                    ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _teal,
                        lines: const [
                          'Use lane comparison to validate that handler enable flags are wired to the intended host scope.',
                          'Independent keys per nested navigator prevent cross-talk between hosts.',
                          'When debugging back behavior, keep per-lane logs so callback ordering remains interpretable.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Comparison event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogCard(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _ComparisonLane(
                        tone: _teal,
                        title: 'Enabled Lane',
                        initialEnabled: true,
                        onEvent: (e) => _push('enabled lane: $e'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ComparisonLane(
                        tone: _amber,
                        title: 'Disabled Lane',
                        initialEnabled: false,
                        onEvent: (e) => _push('disabled lane: $e'),
                      ),
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

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 50);
    });
  }
}

class _ComparisonLane extends StatefulWidget {
  const _ComparisonLane({
    required this.tone,
    required this.title,
    required this.initialEnabled,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final bool initialEnabled;
  final ValueChanged<String> onEvent;

  @override
  State<_ComparisonLane> createState() => _ComparisonLaneState();
}

class _ComparisonLaneState extends State<_ComparisonLane> {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  late bool _enabled;
  int _popCalls = 0;
  int _resultCalls = 0;
  int _pushCount = 0;

  @override
  void initState() {
    super.initState();
    _enabled = widget.initialEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
              _ToneChip(tone: widget.tone, label: _enabled ? 'enabled' : 'disabled'),
            ],
          ),
          SwitchListTile(
            value: _enabled,
            onChanged: (v) {
              setState(() => _enabled = v);
              widget.onEvent('enabled=$v');
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Handler enabled', style: TextStyle(fontSize: 12)),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              FilledButton.tonal(
                onPressed: () {
                  _pushCount += 1;
                  _key.currentState?.pushNamed('/lane', arguments: _FlowPageData(index: _pushCount, title: 'Lane page $_pushCount', tone: widget.tone));
                  widget.onEvent('push page $_pushCount');
                },
                child: const Text('Push'),
              ),
              FilledButton.tonal(
                onPressed: () async {
                  final ok = await _key.currentState?.maybePop('lane-pop') ?? false;
                  widget.onEvent(ok ? 'maybePop success' : 'maybePop ignored');
                },
                child: const Text('Pop'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('onPop=$_popCalls | onPopWithResult=$_resultCalls', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.tone.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: NavigatorPopHandler(
                enabled: _enabled,
                onPopWithResult: (result) {
                  setState(() {
                    _popCalls += 1;
                    _resultCalls += 1;
                  });
                  widget.onEvent('onPopWithResult=$result');
                },
                child: Navigator(
                  key: _key,
                  onGenerateRoute: (settings) {
                    final data = settings.arguments is _FlowPageData
                        ? settings.arguments as _FlowPageData
                        : _FlowPageData(index: 0, title: '${widget.title} root', tone: widget.tone);
                    return MaterialPageRoute(
                      builder: (context) {
                        return _CompactFlowPage(
                          data: data,
                          onPush: () {
                            _pushCount += 1;
                            _key.currentState?.pushNamed('/lane', arguments: _FlowPageData(index: _pushCount, title: 'Lane page $_pushCount', tone: widget.tone));
                            widget.onEvent('push from inner page $_pushCount');
                          },
                          onPop: () {
                            _key.currentState?.pop('inner-pop-${data.index}');
                            widget.onEvent('inner pop ${data.index}');
                          },
                        );
                      },
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

class _CompactFlowPage extends StatelessWidget {
  const _CompactFlowPage({required this.data, required this.onPush, required this.onPop});

  final _FlowPageData data;
  final VoidCallback onPush;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: data.tone.withValues(alpha: 0.12),
      child: Center(
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: data.tone.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: TextStyle(color: data.tone, fontWeight: FontWeight.w800, fontSize: 12)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(child: FilledButton.tonal(onPressed: onPush, child: const Text('Push'))),
                  const SizedBox(width: 6),
                  Expanded(child: FilledButton.tonal(onPressed: onPop, child: const Text('Pop'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultScene extends StatefulWidget {
  const _ResultScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_ResultScene> createState() => _ResultSceneState();
}

class _ResultSceneState extends State<_ResultScene> {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  final List<String> _events = <String>[];
  bool _enabled = true;
  int _resultCalls = 0;
  dynamic _lastResult;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 950.0 : 1140.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Result controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _enabled,
                        onChanged: (v) {
                          setState(() => _enabled = v);
                          _push('handler enabled=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Handler enabled'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(onPressed: () => _pushPayloadPage(_resultTextPayload()), child: const Text('Push text payload page')),
                          FilledButton.tonal(onPressed: () => _pushPayloadPage(_resultNumberPayload()), child: const Text('Push number payload page')),
                          FilledButton.tonal(onPressed: () => _pushPayloadPage(_resultMapPayload()), child: const Text('Push map payload page')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('handler enabled', _enabled ? 'true' : 'false'),
                          _DataRowItem('result callbacks', '$_resultCalls'),
                          _DataRowItem('last result', _lastResult?.toString() ?? 'none'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'onPopWithResult is useful when nested flows return completion data to a hosting shell.',
                            'Result payloads can be primitive values or structured objects, depending on flow needs.',
                            'Keep result logging explicit during development to validate route and payload contracts.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Result event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _LogCard(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: _amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: NavigatorPopHandler(
                    enabled: _enabled,
                    onPopWithResult: (result) {
                      setState(() {
                        _resultCalls += 1;
                        _lastResult = result;
                      });
                      _push('onPopWithResult: $result');
                    },
                    child: Navigator(
                      key: _key,
                      onGenerateRoute: (settings) {
                        final payload = settings.arguments;
                        return MaterialPageRoute(
                          builder: (context) {
                            if (payload is _MiniRoutePayload) {
                              return _ResultPayloadPage(
                                payload: payload,
                                onPopWithPayload: () {
                                  _key.currentState?.pop(payload);
                                  _push('payload page popped ${payload.id}');
                                },
                              );
                            }
                            return _ResultRootPage(
                              onPushText: () => _pushPayloadPage(_resultTextPayload()),
                              onPushNumber: () => _pushPayloadPage(_resultNumberPayload()),
                              onPushMap: () => _pushPayloadPage(_resultMapPayload()),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushPayloadPage(_MiniRoutePayload payload) {
    _key.currentState?.pushNamed('/result', arguments: payload);
    _push('push payload page ${payload.id}');
  }

  _MiniRoutePayload _resultTextPayload() {
    return const _MiniRoutePayload(id: 'text', description: 'Returned textual result', color: _teal);
  }

  _MiniRoutePayload _resultNumberPayload() {
    return const _MiniRoutePayload(id: 'number', description: 'Returned numeric result', color: _blue);
  }

  _MiniRoutePayload _resultMapPayload() {
    return const _MiniRoutePayload(id: 'map', description: 'Returned map-like result', color: _rose);
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 42);
    });
  }
}

class _ResultRootPage extends StatelessWidget {
  const _ResultRootPage({required this.onPushText, required this.onPushNumber, required this.onPushMap});

  final VoidCallback onPushText;
  final VoidCallback onPushNumber;
  final VoidCallback onPushMap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 430,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _amber.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Result Root Page', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: _amber)),
              const SizedBox(height: 6),
              const Text('Push specialized payload pages and pop them to emit distinct results through onPopWithResult.'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonal(onPressed: onPushText, child: const Text('Text payload')), 
                  FilledButton.tonal(onPressed: onPushNumber, child: const Text('Number payload')), 
                  FilledButton.tonal(onPressed: onPushMap, child: const Text('Map payload')), 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultPayloadPage extends StatelessWidget {
  const _ResultPayloadPage({required this.payload, required this.onPopWithPayload});

  final _MiniRoutePayload payload;
  final VoidCallback onPopWithPayload;

  @override
  Widget build(BuildContext context) {
    final dynamic computedResult;
    if (payload.id == 'text') {
      computedResult = 'payload:${payload.id}:${payload.description}';
    } else if (payload.id == 'number') {
      computedResult = 42;
    } else {
      computedResult = <String, dynamic>{'id': payload.id, 'info': payload.description, 'ok': true};
    }

    return Material(
      color: payload.color.withValues(alpha: 0.08),
      child: Center(
        child: Container(
          width: 430,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: payload.color.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payload Page: ${payload.id}', style: TextStyle(fontWeight: FontWeight.w800, color: payload.color, fontSize: 18)),
              const SizedBox(height: 6),
              Text(payload.description),
              const SizedBox(height: 6),
              Text('computed result: $computedResult', style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: onPopWithPayload,
                      child: const Text('Pop with payload object'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () => Navigator.of(context).pop(computedResult),
                      child: const Text('Pop with computed result'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkflowScene extends StatefulWidget {
  const _WorkflowScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_WorkflowScene> createState() => _WorkflowSceneState();
}

class _WorkflowSceneState extends State<_WorkflowScene> {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  int _step = 0;
  bool _gateLocked = true;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1180.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Workflow controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _gateLocked,
                        onChanged: (v) {
                          setState(() => _gateLocked = v);
                          _push('gate locked=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Gate locked (disable pop handler)'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _step = (_step + 1).clamp(0, 3));
                              _push('step changed to $_step');
                            },
                            child: const Text('Next step'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              _key.currentState?.pushNamed('/wf', arguments: _FlowPageData(index: _step + 1, title: 'Workflow page ${_step + 1}', tone: _rose));
                              _push('workflow push at step $_step');
                            },
                            child: const Text('Push workflow page'),
                          ),
                          FilledButton.tonal(
                            onPressed: () async {
                              final ok = await _key.currentState?.maybePop('workflow-pop-step-$_step') ?? false;
                              _push(ok ? 'workflow maybePop success' : 'workflow maybePop ignored');
                            },
                            child: const Text('Pop workflow page'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('step', '$_step / 3'),
                          _DataRowItem('gate lock', _gateLocked ? 'locked' : 'open'),
                          _DataRowItem('handler enabled', (!_gateLocked).toString()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'Workflow stages can temporarily disable or enable pop handling based on process safety rules.',
                            'Tie handler enabled state to gate conditions to prevent accidental route exits at critical moments.',
                            'Provide clear visual feedback so users understand why back behavior changes across steps.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Workflow timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 220, child: _LogCard(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _rose.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: NavigatorPopHandler(
                          enabled: !_gateLocked,
                          onPopWithResult: (result) => _push('workflow onPopWithResult: $result'),
                          child: Navigator(
                            key: _key,
                            onGenerateRoute: (settings) {
                              final data = settings.arguments is _FlowPageData
                                  ? settings.arguments as _FlowPageData
                                  : const _FlowPageData(index: 0, title: 'Workflow root', tone: _rose);
                              return MaterialPageRoute(
                                builder: (context) {
                                  return _WorkflowPage(
                                    data: data,
                                    onPush: () {
                                      final next = _FlowPageData(index: data.index + 1, title: 'Workflow page ${data.index + 1}', tone: _rose);
                                      _key.currentState?.pushNamed('/wf', arguments: next);
                                      _push('inner push ${next.index}');
                                    },
                                    onPop: () {
                                      _key.currentState?.maybePop('wf-inner-pop-${data.index}');
                                      _push('inner maybePop ${data.index}');
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    if (_gateLocked)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _rose.withValues(alpha: 0.42),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Container(
                              width: 360,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _rose.withValues(alpha: 0.35), width: 2),
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Workflow Gate Locked', style: TextStyle(fontWeight: FontWeight.w800, color: _rose, fontSize: 18)),
                                  SizedBox(height: 6),
                                  Text(
                                    'Handler is disabled while the gate is locked. Unlock to allow host-level pop coordination for nested routes.',
                                    style: TextStyle(height: 1.35),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 48);
    });
  }
}

class _WorkflowPage extends StatelessWidget {
  const _WorkflowPage({required this.data, required this.onPush, required this.onPop});

  final _FlowPageData data;
  final VoidCallback onPush;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: data.tone.withValues(alpha: 0.08),
      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: data.tone.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: TextStyle(color: data.tone, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 6),
              Text('step index: ${data.index}'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: FilledButton.tonal(onPressed: onPush, child: const Text('Push next'))),
                  const SizedBox(width: 8),
                  Expanded(child: FilledButton.tonal(onPressed: onPop, child: const Text('Pop current'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  final List<String> _events = <String>[];
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1190.0 : 1390.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonal(
                          onPressed: () => setState(() => _revision += 1),
                          child: Text('Refresh modules ($_revision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _events.insert(0, '${_clock()} | snapshot captured');
                              _trim(_events, 62);
                            });
                          },
                          child: const Text('Capture snapshot'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _events.clear()),
                          child: const Text('Clear events'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PracticalModule(
                              tone: _blue,
                              title: 'Dashboard Shell',
                              subtitle: 'Nested metrics flow with host-level pop coordination.',
                              revision: _revision,
                              onEvent: (e) => _push('dashboard: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _teal,
                              title: 'Operations Shell',
                              subtitle: 'Task routes and pop-result logging in operational context.',
                              revision: _revision,
                              onEvent: (e) => _push('operations: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _violet,
                              title: 'Release Shell',
                              subtitle: 'Release checklist routes with controlled pop handling.',
                              revision: _revision,
                              onEvent: (e) => _push('release: $e'),
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
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Practical guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _violet,
                        lines: const [
                          'Use one handler per nested shell navigator so each module controls its own pop policy.',
                          'Route results from inner flows can power host-level status updates and telemetry.',
                          'During incidents, temporary handler disablement can lock route exits until confirmation conditions are met.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _DataTableCard(
                      rows: [
                        _DataRowItem('revision', '$_revision'),
                        _DataRowItem('event count', '${_events.length}'),
                        _DataRowItem('clock', _clock()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Practical event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogCard(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 62);
    });
  }
}

class _PracticalModule extends StatefulWidget {
  const _PracticalModule({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.revision,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalModule> createState() => _PracticalModuleState();
}

class _PracticalModuleState extends State<_PracticalModule> {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  bool _enabled = true;
  int _popCalls = 0;
  int _resultCalls = 0;
  int _pushIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
              _ToneChip(tone: widget.tone, label: 'rev ${widget.revision}'),
            ],
          ),
          const SizedBox(height: 3),
          Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
          SwitchListTile(
            value: _enabled,
            onChanged: (v) {
              setState(() => _enabled = v);
              widget.onEvent('${widget.title}: enabled=$v');
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Handler enabled', style: TextStyle(fontSize: 12)),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              FilledButton.tonal(
                onPressed: () {
                  _pushIndex += 1;
                  _key.currentState?.pushNamed('/module', arguments: _FlowPageData(index: _pushIndex, title: 'Module page $_pushIndex', tone: widget.tone));
                  widget.onEvent('${widget.title}: push $_pushIndex');
                },
                child: const Text('Push'),
              ),
              FilledButton.tonal(
                onPressed: () async {
                  final ok = await _key.currentState?.maybePop('module-pop-$_pushIndex') ?? false;
                  widget.onEvent('${widget.title}: maybePop ${ok ? 'ok' : 'ignored'}');
                },
                child: const Text('Pop'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('onPop=$_popCalls | onPopWithResult=$_resultCalls', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.tone.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: NavigatorPopHandler(
                enabled: _enabled,
                onPopWithResult: (result) {
                  setState(() {
                    _popCalls += 1;
                    _resultCalls += 1;
                  });
                  widget.onEvent('${widget.title}: onPopWithResult=$result');
                },
                child: Navigator(
                  key: _key,
                  onGenerateRoute: (settings) {
                    final data = settings.arguments is _FlowPageData
                        ? settings.arguments as _FlowPageData
                        : _FlowPageData(index: 0, title: '${widget.title} root', tone: widget.tone);
                    return MaterialPageRoute(
                      builder: (context) {
                        return _CompactFlowPage(
                          data: data,
                          onPush: () {
                            _pushIndex += 1;
                            _key.currentState?.pushNamed('/module', arguments: _FlowPageData(index: _pushIndex, title: 'Module page $_pushIndex', tone: widget.tone));
                            widget.onEvent('${widget.title}: inner push $_pushIndex');
                          },
                          onPop: () {
                            _key.currentState?.pop('module-inner-pop-${data.index}');
                            widget.onEvent('${widget.title}: inner pop ${data.index}');
                          },
                        );
                      },
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

class _PanelSurface extends StatelessWidget {
  const _PanelSurface({required this.guides, required this.child});

  final bool guides;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC6D7E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guides) const CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x13000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ToneChip extends StatelessWidget {
  const _ToneChip({required this.tone, required this.label});

  final Color tone;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }
}

class _DataRowItem {
  const _DataRowItem(this.label, this.value);

  final String label;
  final String value;
}

class _DataTableCard extends StatelessWidget {
  const _DataTableCard({required this.rows});

  final List<_DataRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD2E1EF)),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 156, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                    Expanded(child: Text(r.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.tone, required this.lines});

  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFBFE3FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFEAF6FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFDEEC)),
      ),
      child: lines.isEmpty
          ? const Text('No events yet.', style: TextStyle(color: Color(0xFF62798D)))
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                );
              },
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
        color: const Color(0xFF14374E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: NavigatorPopHandler', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'NavigatorPopHandler is a practical bridge between host routes and nested navigation stacks. '
            'It enables controlled pop coordination, result propagation, and safer workflow-aware back behavior in complex Flutter applications.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

Color _pickTone(int i) {
  switch (i % 5) {
    case 0:
      return _blue;
    case 1:
      return _teal;
    case 2:
      return _amber;
    case 3:
      return _rose;
    default:
      return _violet;
  }
}

void _trim(List<String> events, int limit) {
  if (events.length > limit) {
    events.removeRange(limit, events.length);
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
