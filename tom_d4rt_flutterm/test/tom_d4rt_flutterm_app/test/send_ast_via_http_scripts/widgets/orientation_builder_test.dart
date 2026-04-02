import 'package:flutter/material.dart';

const _bg = Color(0xFFF2F7FC);
const _ink = Color(0xFF16364C);
const _ocean = Color(0xFF2669A5);
const _jade = Color(0xFF2D846D);
const _amber = Color(0xFFAA7A33);
const _rose = Color(0xFF9A5A72);
const _indigo = Color(0xFF5E59B0);

dynamic build(BuildContext context) {
  return const _OrientationBuilderDeepDemoApp();
}

class _OrientationBuilderDeepDemoApp extends StatelessWidget {
  const _OrientationBuilderDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _ocean),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _OrientationBuilderDeepDemoPage(),
    );
  }
}

class _OrientationBuilderDeepDemoPage extends StatefulWidget {
  const _OrientationBuilderDeepDemoPage();

  @override
  State<_OrientationBuilderDeepDemoPage> createState() => _OrientationBuilderDeepDemoPageState();
}

class _OrientationBuilderDeepDemoPageState extends State<_OrientationBuilderDeepDemoPage> {
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
          toolbarHeight: 96,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('OrientationBuilder Deep Demo'),
              Text(
                'constraint-aware orientation adaptation | responsive composition patterns',
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
              _GlobalControls(
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
              _SceneCard(
                index: 1,
                tone: _ocean,
                title: 'Orientation Fundamentals Studio',
                subtitle:
                    'Manipulate width and height constraints and inspect how OrientationBuilder switches between portrait and landscape compositions.',
                child: _FundamentalsScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                tone: _jade,
                title: 'Adaptive Layout Engine',
                subtitle:
                    'Build orientation-aware shell structures that pivot between rail-based and bottom-bar-based information architecture.',
                child: _AdaptiveShellScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                tone: _amber,
                title: 'Multi-Viewport Interaction Lab',
                subtitle:
                    'Compare several independent OrientationBuilder canvases with distinct aspect ratios and interaction signals.',
                child: _ViewportLabScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                tone: _rose,
                title: 'Content Reflow Workshop',
                subtitle:
                    'Media strips, text grids, and utility cards reflow with orientation so teams can observe practical responsive composition decisions.',
                child: _ReflowScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                tone: _indigo,
                title: 'Practical Product Console',
                subtitle:
                    'Three production-style modules illustrate differentiated OrientationBuilder strategies with instructional diagnostics.',
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

class _GlobalControls extends StatelessWidget {
  const _GlobalControls({
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
          colors: [Color(0xFF18384E), Color(0xFF2A6AA2), Color(0xFF2E846E), Color(0xFF5F59AE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OrientationBuilder Control Deck', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text(
            'OrientationBuilder chooses a layout based on incoming constraints. '
            'Unlike direct MediaQuery checks, this allows localized orientation adaptation per region or sub-tree.',
            style: TextStyle(color: Color(0xFFDDEDF8), height: 1.35),
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
          Text('Scene zoom: ${zoom.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: zoom,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onZoomChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 7))],
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
  double _width = 320;
  double _height = 560;
  bool _dense = false;
  bool _showDiagnostics = true;
  int _palette = 0;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 980.0 : 1180.0;
    return SizedBox(
      height: sceneHeight,
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
                      const Text('Fundamental controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Viewport width: ${_width.toStringAsFixed(0)}'),
                      Slider(
                        value: _width,
                        min: 220,
                        max: 760,
                        divisions: 27,
                        onChanged: (v) => setState(() => _width = v),
                        onChangeEnd: (v) => _push('width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Viewport height: ${_height.toStringAsFixed(0)}'),
                      Slider(
                        value: _height,
                        min: 220,
                        max: 760,
                        divisions: 27,
                        onChanged: (v) => setState(() => _height = v),
                        onChangeEnd: (v) => _push('height=${v.toStringAsFixed(0)}'),
                      ),
                      SwitchListTile(
                        value: _dense,
                        onChanged: (v) {
                          setState(() => _dense = v);
                          _push('dense mode=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Dense card composition'),
                      ),
                      SwitchListTile(
                        value: _showDiagnostics,
                        onChanged: (v) => setState(() => _showDiagnostics = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show diagnostics panel'),
                      ),
                      _EnumDropdown<int>(
                        label: 'Color palette',
                        value: _palette,
                        values: const [0, 1, 2, 3],
                        labelBuilder: (v) {
                          switch (v) {
                            case 0:
                              return 'Ocean';
                            case 1:
                              return 'Jade';
                            case 2:
                              return 'Amber';
                            default:
                              return 'Indigo';
                          }
                        },
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _palette = v);
                            _push('palette=$v');
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      if (_showDiagnostics)
                        _FactTable(rows: [
                          _Fact('orientation', _width > _height ? 'landscape' : 'portrait'),
                          _Fact('width', _width.toStringAsFixed(0)),
                          _Fact('height', _height.toStringAsFixed(0)),
                          _Fact('ratio', (_width / _height).toStringAsFixed(2)),
                          _Fact('dense cards', _dense.toString()),
                        ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _ocean,
                          lines: const [
                            'OrientationBuilder computes orientation from local constraints, not global device orientation alone.',
                            'This allows one region to be landscape while another remains portrait-like depending on layout bounds.',
                            'Use this for card grids, side-by-side panels, and context-sensitive information density changes.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Fundamentals timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 190, child: _EventLog(lines: _events)),
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
                      const Text('Constraint-driven preview', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: _width,
                            height: _height,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: _activeTone(_palette).withValues(alpha: 0.32), width: 2),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 6)),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: OrientationBuilder(
                                builder: (context, orientation) {
                                  return _OrientationPreview(
                                    tone: _activeTone(_palette),
                                    orientation: orientation,
                                    dense: _dense,
                                    onEvent: _push,
                                  );
                                },
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
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 45);
    });
  }
}

class _OrientationPreview extends StatelessWidget {
  const _OrientationPreview({
    required this.tone,
    required this.orientation,
    required this.dense,
    required this.onEvent,
  });

  final Color tone;
  final Orientation orientation;
  final bool dense;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    if (orientation == Orientation.landscape) {
      return Row(
        children: [
          Expanded(
            child: Container(
              color: tone.withValues(alpha: 0.12),
              child: Column(
                children: [
                  _DemoHeader(
                    tone: tone,
                    title: 'Landscape Lane',
                    subtitle: 'Wide structure with side metrics and horizontal emphasis.',
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        _SignalCard(tone: tone, title: 'Throughput', details: 'Orientation switched to landscape; showing broad KPI rows.'),
                        _SignalCard(tone: tone, title: 'Pipeline', details: 'Secondary lane remains visible due to additional width.'),
                        _SignalCard(tone: tone, title: 'Warnings', details: 'Action chips align in one row with horizontal space surplus.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: dense ? 140 : 180,
            color: tone.withValues(alpha: 0.19),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Control Rail', style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                _ActionPill(label: 'Refresh', tone: tone, onTap: () => onEvent('landscape refresh tapped')),
                _ActionPill(label: 'Stabilize', tone: tone, onTap: () => onEvent('landscape stabilize tapped')),
                _ActionPill(label: 'Annotate', tone: tone, onTap: () => onEvent('landscape annotate tapped')),
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        _DemoHeader(
          tone: tone,
          title: 'Portrait Stack',
          subtitle: 'Vertical narrative flow with compact card hierarchy.',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              _SignalCard(tone: tone, title: 'Overview', details: 'In portrait, content prioritizes sequential scanning over side-by-side density.'),
              _SignalCard(tone: tone, title: 'Observability', details: 'Cards become taller and maintain readability with narrower width.'),
              _SignalCard(tone: tone, title: 'Action Queue', details: 'Primary actions move to bottom row for thumb-friendly access.'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ActionPill(label: 'Refresh', tone: tone, onTap: () => onEvent('portrait refresh tapped')),
                  _ActionPill(label: 'Stabilize', tone: tone, onTap: () => onEvent('portrait stabilize tapped')),
                  _ActionPill(label: 'Annotate', tone: tone, onTap: () => onEvent('portrait annotate tapped')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AdaptiveShellScene extends StatefulWidget {
  const _AdaptiveShellScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_AdaptiveShellScene> createState() => _AdaptiveShellSceneState();
}

class _AdaptiveShellSceneState extends State<_AdaptiveShellScene> {
  double _width = 640;
  double _height = 360;
  bool _alerts = true;
  int _section = 0;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 990.0 : 1210.0;
    return SizedBox(
      height: sceneHeight,
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
                      const Text('Adaptive shell controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Shell width: ${_width.toStringAsFixed(0)}'),
                      Slider(
                        value: _width,
                        min: 260,
                        max: 880,
                        divisions: 31,
                        onChanged: (v) => setState(() => _width = v),
                        onChangeEnd: (v) => _push('shell width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Shell height: ${_height.toStringAsFixed(0)}'),
                      Slider(
                        value: _height,
                        min: 260,
                        max: 720,
                        divisions: 23,
                        onChanged: (v) => setState(() => _height = v),
                        onChangeEnd: (v) => _push('shell height=${v.toStringAsFixed(0)}'),
                      ),
                      SwitchListTile(
                        value: _alerts,
                        onChanged: (v) {
                          setState(() => _alerts = v);
                          _push('critical alerts=${v ? 'visible' : 'hidden'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show critical alerts'),
                      ),
                      _EnumDropdown<int>(
                        label: 'Focus section',
                        value: _section,
                        values: const [0, 1, 2],
                        labelBuilder: (v) {
                          if (v == 0) return 'Overview';
                          if (v == 1) return 'Signals';
                          return 'Actions';
                        },
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _section = v);
                            _push('section=$v');
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _FactTable(rows: [
                        _Fact('orientation', _width > _height ? 'landscape shell' : 'portrait shell'),
                        _Fact('alerts', _alerts.toString()),
                        _Fact('section index', '$_section'),
                      ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _jade,
                          lines: const [
                            'Use OrientationBuilder for region-specific shell adaptation when full app rotation is not the only trigger.',
                            'Landscape often supports side rail + persistent context panes, while portrait benefits from stacked navigation.',
                            'Keeping section state external to builder helps preserve logical continuity during orientation swaps.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Adaptive shell timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 190, child: _EventLog(lines: _events)),
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
                child: Center(
                  child: Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _jade.withValues(alpha: 0.33), width: 2),
                    ),
                    child: OrientationBuilder(
                      builder: (context, orientation) {
                        if (orientation == Orientation.landscape) {
                          return Row(
                            children: [
                              Container(
                                width: 150,
                                color: _jade.withValues(alpha: 0.14),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Rail', style: TextStyle(fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 8),
                                    _RailTile(label: 'Overview', selected: _section == 0, onTap: () {
                                      setState(() => _section = 0);
                                      _push('landscape rail overview');
                                    }),
                                    _RailTile(label: 'Signals', selected: _section == 1, onTap: () {
                                      setState(() => _section = 1);
                                      _push('landscape rail signals');
                                    }),
                                    _RailTile(label: 'Actions', selected: _section == 2, onTap: () {
                                      setState(() => _section = 2);
                                      _push('landscape rail actions');
                                    }),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: _SectionCanvas(section: _section, alerts: _alerts, tone: _jade, orientation: orientation),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Expanded(child: _SectionCanvas(section: _section, alerts: _alerts, tone: _jade, orientation: orientation)),
                            Container(
                              height: 62,
                              decoration: BoxDecoration(
                                color: _jade.withValues(alpha: 0.15),
                                border: Border(top: BorderSide(color: _jade.withValues(alpha: 0.35))),
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: _BottomNav(label: 'Overview', selected: _section == 0, onTap: () {
                                    setState(() => _section = 0);
                                    _push('portrait nav overview');
                                  })),
                                  Expanded(child: _BottomNav(label: 'Signals', selected: _section == 1, onTap: () {
                                    setState(() => _section = 1);
                                    _push('portrait nav signals');
                                  })),
                                  Expanded(child: _BottomNav(label: 'Actions', selected: _section == 2, onTap: () {
                                    setState(() => _section = 2);
                                    _push('portrait nav actions');
                                  })),
                                ],
                              ),
                            ),
                          ],
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

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 48);
    });
  }
}

class _SectionCanvas extends StatelessWidget {
  const _SectionCanvas({
    required this.section,
    required this.alerts,
    required this.tone,
    required this.orientation,
  });

  final int section;
  final bool alerts;
  final Color tone;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    final label = section == 0 ? 'Overview' : section == 1 ? 'Signals' : 'Actions';
    return Container(
      color: tone.withValues(alpha: 0.06),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label Canvas', style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 17)),
          const SizedBox(height: 4),
          Text('Orientation: ${orientation.name}', style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          if (alerts)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: const Text('Critical alert: downstream queue latency exceeded threshold.'),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.count(
              crossAxisCount: orientation == Orientation.landscape ? 3 : 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: orientation == Orientation.landscape ? 1.35 : 1.1,
              children: [
                _StatCard(title: 'Requests', value: '28.4k', tone: tone),
                _StatCard(title: 'Success', value: '99.2%', tone: tone),
                _StatCard(title: 'Latency', value: '132ms', tone: tone),
                _StatCard(title: 'Incidents', value: '2', tone: tone),
                _StatCard(title: 'Deployments', value: '14', tone: tone),
                _StatCard(title: 'Saturation', value: '63%', tone: tone),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewportLabScene extends StatefulWidget {
  const _ViewportLabScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_ViewportLabScene> createState() => _ViewportLabSceneState();
}

class _ViewportLabSceneState extends State<_ViewportLabScene> {
  final List<String> _events = <String>[];
  bool _diagnostics = true;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1020.0 : 1240.0;
    return SizedBox(
      height: sceneHeight,
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
                    const Text('Viewport lab controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      value: _diagnostics,
                      onChanged: (v) => setState(() => _diagnostics = v),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Show lab diagnostics'),
                    ),
                    if (_diagnostics)
                      _FactTable(rows: const [
                        _Fact('canvas A', 'portrait-biased'),
                        _Fact('canvas B', 'landscape-biased'),
                        _Fact('canvas C', 'square-adaptive'),
                      ]),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _amber,
                        lines: const [
                          'Each OrientationBuilder instance responds only to its own constraints and parent sizing.',
                          'In component libraries, this enables reusable widgets that adapt correctly in varied host layouts.',
                          'Testing multiple canvases side by side helps identify inconsistent orientation thresholds.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Lab timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _EventLog(lines: _events)),
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
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _ViewportProbe(
                              tone: _ocean,
                              title: 'Canvas A',
                              initialWidth: 300,
                              initialHeight: 520,
                              onEvent: (e) => _push('A: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ViewportProbe(
                              tone: _jade,
                              title: 'Canvas B',
                              initialWidth: 520,
                              initialHeight: 300,
                              onEvent: (e) => _push('B: $e'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _ViewportProbe(
                        tone: _amber,
                        title: 'Canvas C',
                        initialWidth: 440,
                        initialHeight: 440,
                        onEvent: (e) => _push('C: $e'),
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
      _trim(_events, 55);
    });
  }
}

class _ViewportProbe extends StatefulWidget {
  const _ViewportProbe({
    required this.tone,
    required this.title,
    required this.initialWidth,
    required this.initialHeight,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final double initialWidth;
  final double initialHeight;
  final ValueChanged<String> onEvent;

  @override
  State<_ViewportProbe> createState() => _ViewportProbeState();
}

class _ViewportProbeState extends State<_ViewportProbe> {
  late double _w = widget.initialWidth;
  late double _h = widget.initialHeight;

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
          Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800)),
          Text('w=${_w.toStringAsFixed(0)} h=${_h.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12)),
          Slider(
            value: _w,
            min: 220,
            max: 620,
            divisions: 20,
            onChanged: (v) => setState(() => _w = v),
            onChangeEnd: (v) => widget.onEvent('width=${v.toStringAsFixed(0)}'),
          ),
          Slider(
            value: _h,
            min: 220,
            max: 620,
            divisions: 20,
            onChanged: (v) => setState(() => _h = v),
            onChangeEnd: (v) => widget.onEvent('height=${v.toStringAsFixed(0)}'),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: _w.clamp(220, 500),
                height: _h.clamp(220, 500),
                decoration: BoxDecoration(
                  color: widget.tone.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    return orientation == Orientation.landscape
                        ? Row(
                            children: [
                              Expanded(child: _ProbeBlock(tone: widget.tone, label: 'Pane 1', text: 'Landscape split section A')), 
                              Expanded(child: _ProbeBlock(tone: widget.tone, label: 'Pane 2', text: 'Landscape split section B')), 
                            ],
                          )
                        : Column(
                            children: [
                              Expanded(child: _ProbeBlock(tone: widget.tone, label: 'Pane 1', text: 'Portrait vertical section A')), 
                              Expanded(child: _ProbeBlock(tone: widget.tone, label: 'Pane 2', text: 'Portrait vertical section B')), 
                            ],
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

class _ProbeBlock extends StatelessWidget {
  const _ProbeBlock({required this.tone, required this.label, required this.text});

  final Color tone;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class _ReflowScene extends StatefulWidget {
  const _ReflowScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_ReflowScene> createState() => _ReflowSceneState();
}

class _ReflowSceneState extends State<_ReflowScene> {
  double _width = 500;
  double _height = 500;
  bool _media = true;
  bool _annotations = true;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 980.0 : 1160.0;
    return SizedBox(
      height: sceneHeight,
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
                      const Text('Reflow controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Canvas width: ${_width.toStringAsFixed(0)}'),
                      Slider(
                        value: _width,
                        min: 260,
                        max: 760,
                        divisions: 25,
                        onChanged: (v) => setState(() => _width = v),
                        onChangeEnd: (v) => _push('canvas width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Canvas height: ${_height.toStringAsFixed(0)}'),
                      Slider(
                        value: _height,
                        min: 260,
                        max: 760,
                        divisions: 25,
                        onChanged: (v) => setState(() => _height = v),
                        onChangeEnd: (v) => _push('canvas height=${v.toStringAsFixed(0)}'),
                      ),
                      SwitchListTile(
                        value: _media,
                        onChanged: (v) {
                          setState(() => _media = v);
                          _push('media blocks=${v ? 'shown' : 'hidden'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show media strip'),
                      ),
                      SwitchListTile(
                        value: _annotations,
                        onChanged: (v) => setState(() => _annotations = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show annotations'),
                      ),
                      const SizedBox(height: 8),
                      if (_annotations)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'OrientationBuilder can switch not only item counts, but also semantic reading order and group density.',
                            'When using media strips, decide whether to preserve chronology or prioritize visibility in narrower contexts.',
                            'Keep typographic line lengths legible after orientation shifts by adjusting column widths.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Reflow timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 180, child: _EventLog(lines: _events)),
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
                child: Center(
                  child: Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _rose.withValues(alpha: 0.32), width: 2),
                    ),
                    child: OrientationBuilder(
                      builder: (context, orientation) {
                        final columns = orientation == Orientation.landscape ? 3 : 2;
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              color: _rose.withValues(alpha: 0.12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Reflow Canvas (${orientation.name})',
                                      style: TextStyle(color: _rose, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Text('$columns columns', style: const TextStyle(fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                            if (_media)
                              SizedBox(
                                height: orientation == Orientation.landscape ? 96 : 140,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(10),
                                  children: [
                                    _MediaTile(tone: _rose, title: 'Telemetry'),
                                    _MediaTile(tone: _ocean, title: 'Alarms'),
                                    _MediaTile(tone: _jade, title: 'Backlog'),
                                    _MediaTile(tone: _amber, title: 'Incidents'),
                                    _MediaTile(tone: _indigo, title: 'Recovery'),
                                  ],
                                ),
                              ),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: columns,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                padding: const EdgeInsets.all(10),
                                childAspectRatio: orientation == Orientation.landscape ? 1.25 : 0.95,
                                children: const [
                                  _ReflowCard(title: 'Dispatch Queue', body: 'Queue depth and scheduling heat map.'),
                                  _ReflowCard(title: 'Edge Nodes', body: 'Region-by-region worker stability.'),
                                  _ReflowCard(title: 'Traffic Split', body: 'Canary and baseline ratio indicators.'),
                                  _ReflowCard(title: 'Budget Guard', body: 'Spend thresholds and drift watch.'),
                                  _ReflowCard(title: 'Failure Domains', body: 'Dependency impact surfaces.'),
                                  _ReflowCard(title: 'Recovery Kit', body: 'Action playbooks and safe rollbacks.'),
                                ],
                              ),
                            ),
                          ],
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

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 46);
    });
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
  int _revision = 1;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1220.0 : 1440.0;
    return SizedBox(
      height: sceneHeight,
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
                              _trim(_events, 64);
                            });
                          },
                          child: const Text('Capture snapshot'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _events.clear()),
                          child: const Text('Clear timeline'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PracticalModule(
                              tone: _ocean,
                              title: 'Dashboard Shell',
                              subtitle: 'KPI focus and orientation-aware analytics surface.',
                              revision: _revision,
                              onEvent: (e) => _push('dashboard: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _jade,
                              title: 'Operations Shell',
                              subtitle: 'Runbook-first adaptation between stacked and split flow.',
                              revision: _revision,
                              onEvent: (e) => _push('operations: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _indigo,
                              title: 'Release Shell',
                              subtitle: 'Checklist and rollout monitor with orientation pivots.',
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
                        tone: _indigo,
                        lines: const [
                          'OrientationBuilder can be scoped at module level so each product panel adapts independently.',
                          'Preserve user intent during orientation changes by keeping key state above the builder boundary.',
                          'Use diagnostics to verify that layout shifts improve clarity instead of just rearranging widgets.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _FactTable(rows: [
                      _Fact('revision', '$_revision'),
                      _Fact('event count', '${_events.length}'),
                      _Fact('clock', _clock()),
                    ]),
                    const SizedBox(height: 8),
                    const Text('Practical timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _EventLog(lines: _events)),
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
      _trim(_events, 64);
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
  double _w = 330;
  double _h = 500;
  bool _dense = false;

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
          Slider(
            value: _w,
            min: 240,
            max: 480,
            divisions: 12,
            onChanged: (v) => setState(() => _w = v),
            onChangeEnd: (v) => widget.onEvent('${widget.title}: width=${v.toStringAsFixed(0)}'),
          ),
          Slider(
            value: _h,
            min: 280,
            max: 620,
            divisions: 17,
            onChanged: (v) => setState(() => _h = v),
            onChangeEnd: (v) => widget.onEvent('${widget.title}: height=${v.toStringAsFixed(0)}'),
          ),
          SwitchListTile(
            value: _dense,
            onChanged: (v) {
              setState(() => _dense = v);
              widget.onEvent('${widget.title}: dense=$v');
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Dense mode', style: TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: _w,
                height: _h,
                decoration: BoxDecoration(
                  color: widget.tone.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    if (orientation == Orientation.landscape) {
                      return Row(
                        children: [
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.all(8),
                              children: [
                                _MiniModuleCard(tone: widget.tone, title: 'Primary lane', text: 'Wide lane summary and controls.'),
                                _MiniModuleCard(tone: widget.tone, title: 'Queue lane', text: 'Secondary queue with horizontal support.'),
                                _MiniModuleCard(tone: widget.tone, title: 'Audit lane', text: 'Audit panel remains visible in landscape.'),
                              ],
                            ),
                          ),
                          Container(
                            width: _dense ? 106 : 132,
                            color: widget.tone.withValues(alpha: 0.14),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                _ActionPill(label: 'Sync', tone: widget.tone, onTap: () => widget.onEvent('${widget.title}: sync')), 
                                _ActionPill(label: 'Review', tone: widget.tone, onTap: () => widget.onEvent('${widget.title}: review')), 
                                _ActionPill(label: 'Ship', tone: widget.tone, onTap: () => widget.onEvent('${widget.title}: ship')), 
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        _MiniModuleCard(tone: widget.tone, title: 'Top stack', text: 'Portrait flow starts with summary context.'),
                        _MiniModuleCard(tone: widget.tone, title: 'Middle stack', text: 'Operations details move to sequential cards.'),
                        _MiniModuleCard(tone: widget.tone, title: 'Bottom stack', text: 'Actions remain at lower section for quick reach.'),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _ActionPill(label: 'Sync', tone: widget.tone, onTap: () => widget.onEvent('${widget.title}: sync')), 
                            _ActionPill(label: 'Review', tone: widget.tone, onTap: () => widget.onEvent('${widget.title}: review')), 
                            _ActionPill(label: 'Ship', tone: widget.tone, onTap: () => widget.onEvent('${widget.title}: ship')), 
                          ],
                        ),
                      ],
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

class _DemoHeader extends StatelessWidget {
  const _DemoHeader({required this.tone, required this.title, required this.subtitle});

  final Color tone;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, height: 1.3)),
        ],
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({required this.tone, required this.title, required this.details});

  final Color tone;
  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(details, style: const TextStyle(height: 1.3)),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.label, required this.tone, required this.onTap});

  final String label;
  final Color tone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: tone.withValues(alpha: 0.35)),
          ),
          child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 12)),
        ),
      ),
    );
  }
}

class _RailTile extends StatelessWidget {
  const _RailTile({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: TextStyle(fontWeight: FontWeight.w700, color: selected ? _jade : const Color(0xFF365568))),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: selected ? _jade : const Color(0xFF4C6676),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value, required this.tone});

  final String title;
  final String value;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 12)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
        ],
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  const _MediaTile({required this.tone, required this.title});

  final Color tone;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Center(child: Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800))),
    );
  }
}

class _ReflowCard extends StatelessWidget {
  const _ReflowCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _rose.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: _rose, fontWeight: FontWeight.w800, fontSize: 13)),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 12, height: 1.3)),
        ],
      ),
    );
  }
}

class _MiniModuleCard extends StatelessWidget {
  const _MiniModuleCard({required this.tone, required this.title, required this.text});

  final Color tone;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(fontSize: 11, height: 1.3)),
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

class _Fact {
  const _Fact(this.label, this.value);

  final String label;
  final String value;
}

class _FactTable extends StatelessWidget {
  const _FactTable({required this.rows});

  final List<_Fact> rows;

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
                    SizedBox(width: 160, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
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

class _EventLog extends StatelessWidget {
  const _EventLog({required this.lines});

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

class _EnumDropdown<T> extends StatelessWidget {
  const _EnumDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> values;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
        Expanded(
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            items: values
                .map(
                  (v) => DropdownMenuItem<T>(
                    value: v,
                    child: Text(labelBuilder(v)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
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
          Text('Recap: OrientationBuilder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'OrientationBuilder is a localized responsiveness tool: it reacts to incoming layout constraints and allows each widget region '
            'to adapt its structure independently. This makes it ideal for reusable components, nested dashboards, and context-aware UI design.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

Color _activeTone(int palette) {
  switch (palette) {
    case 0:
      return _ocean;
    case 1:
      return _jade;
    case 2:
      return _amber;
    default:
      return _indigo;
  }
}

void _trim(List<String> events, int limit) {
  if (events.length > limit) {
    events.removeRange(limit, events.length);
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
