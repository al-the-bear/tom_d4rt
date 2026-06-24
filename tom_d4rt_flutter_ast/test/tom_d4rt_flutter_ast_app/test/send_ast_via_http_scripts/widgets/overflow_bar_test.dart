import 'package:flutter/material.dart';

const _bg = Color(0xFFF4F8FD);
const _ink = Color(0xFF17384D);
const _blue = Color(0xFF2A6AA1);
const _jade = Color(0xFF2F866E);
const _amber = Color(0xFFAD7C33);
const _rose = Color(0xFF9D5C74);
const _indigo = Color(0xFF615AB2);

dynamic build(BuildContext context) {
  return const _OverflowBarDeepDemoApp();
}

class _OverflowBarDeepDemoApp extends StatelessWidget {
  const _OverflowBarDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _OverflowBarDeepDemoPage(),
    );
  }
}

class _OverflowBarDeepDemoPage extends StatefulWidget {
  const _OverflowBarDeepDemoPage();

  @override
  State<_OverflowBarDeepDemoPage> createState() => _OverflowBarDeepDemoPageState();
}

class _OverflowBarDeepDemoPageState extends State<_OverflowBarDeepDemoPage> {
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
              const Text('OverflowBar Deep Demo'),
              Text(
                'adaptive action rows | overflow alignment | direction-aware command bars',
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
                title: 'Overflow Mechanics Studio',
                subtitle:
                    'Stress OverflowBar with width pressure and tune spacing, overflowSpacing, alignments, and direction handling.',
                child: _MechanicsScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _jade,
                title: 'Alignment Matrix Lab',
                subtitle:
                    'Visual matrix compares overflowAlignment and overflowDirection combinations under identical action sets.',
                child: _AlignmentScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Dialog Action Composer',
                subtitle:
                    'Model dialog action areas and observe how OverflowBar keeps actions usable in narrow and wide containers.',
                child: _DialogScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Directionality Workshop',
                subtitle:
                    'Compare LTR and RTL action flows with different alignments to inspect visual order and overflow behavior.',
                child: _DirectionalityScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _indigo,
                title: 'Practical Command Console',
                subtitle:
                    'Three module-grade command bars use OverflowBar as the responsive action orchestration layer.',
                child: _PracticalScene(compact: _compact, guides: _guides, notes: _notes),
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
          colors: [Color(0xFF17384E), Color(0xFF296AA0), Color(0xFF2F856E), Color(0xFF635BB1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OverflowBar Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
          ),
          const SizedBox(height: 6),
          const Text(
            'OverflowBar arranges children in a horizontal row until space is insufficient, then stacks them vertically '
            'with configurable spacing and overflow alignment. It is ideal for action groups that must remain readable and tappable.',
            style: TextStyle(color: Color(0xFFDDEDF8), height: 1.35),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact scenes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                  value: guides,
                  onChanged: onGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                  value: notes,
                  onChanged: onNotesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Instruction notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
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

class _MechanicsScene extends StatefulWidget {
  const _MechanicsScene({required this.compact, required this.guides, required this.notes, required this.zoom});

  final bool compact;
  final bool guides;
  final bool notes;
  final double zoom;

  @override
  State<_MechanicsScene> createState() => _MechanicsSceneState();
}

class _MechanicsSceneState extends State<_MechanicsScene> {
  double _barWidth = 720;
  double _spacing = 8;
  double _overflowSpacing = 8;
  int _mainAlign = 0;
  int _overflowAlign = 0;
  int _overflowDir = 0;
  bool _rtl = false;
  bool _longLabels = true;
  final List<String> _events = <String>[];

  static const _mainAlignValues = [
    MainAxisAlignment.start,
    MainAxisAlignment.center,
    MainAxisAlignment.end,
    MainAxisAlignment.spaceBetween,
    MainAxisAlignment.spaceAround,
    MainAxisAlignment.spaceEvenly,
  ];

  static const _mainAlignLabels = [
    'start',
    'center',
    'end',
    'spaceBetween',
    'spaceAround',
    'spaceEvenly',
  ];

  static const _overflowAlignValues = [
    OverflowBarAlignment.start,
    OverflowBarAlignment.center,
    OverflowBarAlignment.end,
  ];

  static const _overflowAlignLabels = ['start', 'center', 'end'];

  static const _overflowDirValues = [VerticalDirection.down, VerticalDirection.up];
  static const _overflowDirLabels = ['down', 'up'];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1020.0 : 1220.0;
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
                      const Text('Mechanics controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Action area width: ${_barWidth.toStringAsFixed(0)}'),
                      Slider(
                        value: _barWidth,
                        min: 220,
                        max: 980,
                        divisions: 38,
                        onChanged: (v) => setState(() => _barWidth = v),
                        onChangeEnd: (v) => _push('bar width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('spacing: ${_spacing.toStringAsFixed(1)}'),
                      Slider(
                        value: _spacing,
                        min: 0,
                        max: 28,
                        divisions: 28,
                        onChanged: (v) => setState(() => _spacing = v),
                        onChangeEnd: (v) => _push('spacing=${v.toStringAsFixed(1)}'),
                      ),
                      Text('overflowSpacing: ${_overflowSpacing.toStringAsFixed(1)}'),
                      Slider(
                        value: _overflowSpacing,
                        min: 0,
                        max: 36,
                        divisions: 36,
                        onChanged: (v) => setState(() => _overflowSpacing = v),
                        onChangeEnd: (v) => _push('overflowSpacing=${v.toStringAsFixed(1)}'),
                      ),
                      _EnumDropdown<int>(
                        label: 'alignment',
                        value: _mainAlign,
                        values: const [0, 1, 2, 3, 4, 5],
                        labelBuilder: (v) => _mainAlignLabels[v],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _mainAlign = v);
                            _push('alignment=${_mainAlignLabels[v]}');
                          }
                        },
                      ),
                      const SizedBox(height: 6),
                      _EnumDropdown<int>(
                        label: 'overflowAlignment',
                        value: _overflowAlign,
                        values: const [0, 1, 2],
                        labelBuilder: (v) => _overflowAlignLabels[v],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _overflowAlign = v);
                            _push('overflowAlignment=${_overflowAlignLabels[v]}');
                          }
                        },
                      ),
                      const SizedBox(height: 6),
                      _EnumDropdown<int>(
                        label: 'overflowDirection',
                        value: _overflowDir,
                        values: const [0, 1],
                        labelBuilder: (v) => _overflowDirLabels[v],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _overflowDir = v);
                            _push('overflowDirection=${_overflowDirLabels[v]}');
                          }
                        },
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _rtl,
                        onChanged: (v) {
                          setState(() => _rtl = v);
                          _push('textDirection=${v ? 'rtl' : 'ltr'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Internal RTL'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _longLabels,
                        onChanged: (v) {
                          setState(() => _longLabels = v);
                          _push('long labels=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Long button labels'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      _FactTable(rows: [
                        _FactRow('mainAxisAlignment', _mainAlignLabels[_mainAlign]),
                        _FactRow('overflowAlignment', _overflowAlignLabels[_overflowAlign]),
                        _FactRow('overflowDirection', _overflowDirLabels[_overflowDir]),
                        _FactRow('textDirection', _rtl ? 'rtl' : 'ltr'),
                        _FactRow('width', _barWidth.toStringAsFixed(0)),
                      ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'OverflowBar keeps action groups usable by switching to a stacked flow when width is constrained.',
                            'overflowAlignment controls where stacked children anchor in overflow mode.',
                            'overflowDirection determines whether stacked children grow downward or upward after wrapping.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Mechanics timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
              child: Transform.scale(
                scale: widget.zoom,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Action pressure preview', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: _barWidth,
                            constraints: const BoxConstraints(minHeight: 280),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _blue.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: _blue.withValues(alpha: 0.28), width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Release Orchestration Actions', style: TextStyle(fontWeight: FontWeight.w800)),
                                const SizedBox(height: 6),
                                const Text(
                                  'Resize the action zone and tune overflow settings to see exactly when and how OverflowBar transitions.',
                                  style: TextStyle(height: 1.35),
                                ),
                                const Spacer(),
                                Directionality(
                                  textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
                                  child: OverflowBar(
                                    spacing: _spacing,
                                    alignment: _mainAlignValues[_mainAlign],
                                    overflowSpacing: _overflowSpacing,
                                    overflowAlignment: _overflowAlignValues[_overflowAlign],
                                    overflowDirection: _overflowDirValues[_overflowDir],
                                    textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
                                    children: [
                                      _ActionButton(
                                        tone: _blue,
                                        label: _longLabels ? 'Run preflight checks' : 'Preflight',
                                        onTap: () => _push('preflight tapped'),
                                      ),
                                      _ActionButton(
                                        tone: _jade,
                                        label: _longLabels ? 'Validate schema map' : 'Validate',
                                        onTap: () => _push('validate tapped'),
                                      ),
                                      _ActionButton(
                                        tone: _amber,
                                        label: _longLabels ? 'Promote canary wave' : 'Promote',
                                        onTap: () => _push('promote tapped'),
                                      ),
                                      _ActionButton(
                                        tone: _rose,
                                        label: _longLabels ? 'Rollback deployment' : 'Rollback',
                                        onTap: () => _push('rollback tapped'),
                                      ),
                                      _ActionButton(
                                        tone: _indigo,
                                        label: _longLabels ? 'Publish release notes' : 'Publish',
                                        onTap: () => _push('publish tapped'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
      _trim(_events, 42);
    });
  }
}

class _AlignmentScene extends StatefulWidget {
  const _AlignmentScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_AlignmentScene> createState() => _AlignmentSceneState();
}

class _AlignmentSceneState extends State<_AlignmentScene> {
  double _laneWidth = 320;
  double _spacing = 6;
  double _overflowSpacing = 8;
  bool _longLabels = true;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1060.0 : 1260.0;
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
                      const Text('Alignment matrix controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Probe width: ${_laneWidth.toStringAsFixed(0)}'),
                      Slider(
                        value: _laneWidth,
                        min: 220,
                        max: 520,
                        divisions: 15,
                        onChanged: (v) => setState(() => _laneWidth = v),
                        onChangeEnd: (v) => _push('probe width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('spacing: ${_spacing.toStringAsFixed(1)}'),
                      Slider(
                        value: _spacing,
                        min: 0,
                        max: 20,
                        divisions: 20,
                        onChanged: (v) => setState(() => _spacing = v),
                        onChangeEnd: (v) => _push('spacing=${v.toStringAsFixed(1)}'),
                      ),
                      Text('overflowSpacing: ${_overflowSpacing.toStringAsFixed(1)}'),
                      Slider(
                        value: _overflowSpacing,
                        min: 0,
                        max: 24,
                        divisions: 24,
                        onChanged: (v) => setState(() => _overflowSpacing = v),
                        onChangeEnd: (v) => _push('overflowSpacing=${v.toStringAsFixed(1)}'),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _longLabels,
                        onChanged: (v) {
                          setState(() => _longLabels = v);
                          _push('long labels=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Long action labels'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _jade,
                          lines: const [
                            'This matrix holds inputs constant and only changes overflow alignment and direction.',
                            'Use it to teach teammates how stacked actions anchor under pressure.',
                            'Probe width + label length strongly influence when overflow mode activates.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Alignment matrix timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _EventLog(lines: _events)),
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
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.14,
                  children: [
                    _AlignmentProbe(
                      tone: _jade,
                      title: 'start + down',
                      width: _laneWidth,
                      spacing: _spacing,
                      overflowSpacing: _overflowSpacing,
                      overflowAlignment: OverflowBarAlignment.start,
                      overflowDirection: VerticalDirection.down,
                      longLabels: _longLabels,
                      onEvent: (e) => _push('start/down: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _amber,
                      title: 'center + down',
                      width: _laneWidth,
                      spacing: _spacing,
                      overflowSpacing: _overflowSpacing,
                      overflowAlignment: OverflowBarAlignment.center,
                      overflowDirection: VerticalDirection.down,
                      longLabels: _longLabels,
                      onEvent: (e) => _push('center/down: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _rose,
                      title: 'end + down',
                      width: _laneWidth,
                      spacing: _spacing,
                      overflowSpacing: _overflowSpacing,
                      overflowAlignment: OverflowBarAlignment.end,
                      overflowDirection: VerticalDirection.down,
                      longLabels: _longLabels,
                      onEvent: (e) => _push('end/down: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _indigo,
                      title: 'center + up',
                      width: _laneWidth,
                      spacing: _spacing,
                      overflowSpacing: _overflowSpacing,
                      overflowAlignment: OverflowBarAlignment.center,
                      overflowDirection: VerticalDirection.up,
                      longLabels: _longLabels,
                      onEvent: (e) => _push('center/up: $e'),
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
      _trim(_events, 52);
    });
  }
}

class _AlignmentProbe extends StatelessWidget {
  const _AlignmentProbe({
    required this.tone,
    required this.title,
    required this.width,
    required this.spacing,
    required this.overflowSpacing,
    required this.overflowAlignment,
    required this.overflowDirection,
    required this.longLabels,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final double width;
  final double spacing;
  final double overflowSpacing;
  final OverflowBarAlignment overflowAlignment;
  final VerticalDirection overflowDirection;
  final bool longLabels;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('width=${width.toStringAsFixed(0)} | ${overflowAlignment.name} | ${overflowDirection.name}', style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Container(
                width: width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: OverflowBar(
                  spacing: spacing,
                  overflowSpacing: overflowSpacing,
                  alignment: MainAxisAlignment.start,
                  overflowAlignment: overflowAlignment,
                  overflowDirection: overflowDirection,
                  children: [
                    _ProbeAction(label: longLabels ? 'Preflight scan' : 'Scan', tone: tone, onTap: () => onEvent('scan')),
                    _ProbeAction(label: longLabels ? 'Policy verify' : 'Verify', tone: tone, onTap: () => onEvent('verify')),
                    _ProbeAction(label: longLabels ? 'Canary release' : 'Canary', tone: tone, onTap: () => onEvent('canary')),
                    _ProbeAction(label: longLabels ? 'Global publish' : 'Publish', tone: tone, onTap: () => onEvent('publish')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogScene extends StatefulWidget {
  const _DialogScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_DialogScene> createState() => _DialogSceneState();
}

class _DialogSceneState extends State<_DialogScene> {
  double _dialogWidth = 360;
  bool _includeExtra = true;
  bool _longLabels = true;
  int _overflowAlign = 0;
  final List<String> _events = <String>[];

  static const _overflowAlignValues = [
    OverflowBarAlignment.start,
    OverflowBarAlignment.center,
    OverflowBarAlignment.end,
  ];

  static const _overflowAlignLabels = ['start', 'center', 'end'];

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
                      const Text('Dialog action controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Dialog width: ${_dialogWidth.toStringAsFixed(0)}'),
                      Slider(
                        value: _dialogWidth,
                        min: 220,
                        max: 620,
                        divisions: 20,
                        onChanged: (v) => setState(() => _dialogWidth = v),
                        onChangeEnd: (v) => _push('dialog width=${v.toStringAsFixed(0)}'),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _includeExtra,
                        onChanged: (v) {
                          setState(() => _includeExtra = v);
                          _push('extra action=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Include extra action'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _longLabels,
                        onChanged: (v) {
                          setState(() => _longLabels = v);
                          _push('long labels=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Long labels'),
                      ),
                      ),
                      _EnumDropdown<int>(
                        label: 'overflowAlignment',
                        value: _overflowAlign,
                        values: const [0, 1, 2],
                        labelBuilder: (v) => _overflowAlignLabels[v],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _overflowAlign = v);
                            _push('overflowAlignment=${_overflowAlignLabels[v]}');
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _FactTable(rows: [
                        _FactRow('dialog width', _dialogWidth.toStringAsFixed(0)),
                        _FactRow('extra action', _includeExtra.toString()),
                        _FactRow('overflowAlignment', _overflowAlignLabels[_overflowAlign]),
                      ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'Dialog actions are a classic OverflowBar use case in Flutter.',
                            'When width shrinks, actions stack and remain tappable without clipping.',
                            'overflowAlignment should be chosen to match product action hierarchy and reading flow.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Dialog timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
                child: Column(
                  children: [
                    Expanded(
                      child: _DialogMock(
                        tone: _amber,
                        width: _dialogWidth,
                        title: 'Deploy Confirmation',
                        message:
                            'This action publishes a canary wave to three regions. Validate policy gates and rollback plan before continuing.',
                        overflowAlignment: _overflowAlignValues[_overflowAlign],
                        longLabels: _longLabels,
                        includeExtra: _includeExtra,
                        onEvent: (e) => _push('deploy dialog: $e'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _DialogMock(
                        tone: _rose,
                        width: _dialogWidth,
                        title: 'Incident Action Plan',
                        message:
                            'Multiple operators are reviewing remediation options. Select a safe intervention path and document owner approvals.',
                        overflowAlignment: _overflowAlignValues[_overflowAlign],
                        longLabels: _longLabels,
                        includeExtra: _includeExtra,
                        onEvent: (e) => _push('incident dialog: $e'),
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
      _trim(_events, 46);
    });
  }
}

class _DialogMock extends StatelessWidget {
  const _DialogMock({
    required this.tone,
    required this.width,
    required this.title,
    required this.message,
    required this.overflowAlignment,
    required this.longLabels,
    required this.includeExtra,
    required this.onEvent,
  });

  final Color tone;
  final double width;
  final String title;
  final String message;
  final OverflowBarAlignment overflowAlignment;
  final bool longLabels;
  final bool includeExtra;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tone.withValues(alpha: 0.3), width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(message, style: const TextStyle(height: 1.35)),
            const Spacer(),
            OverflowBar(
              spacing: 8,
              overflowSpacing: 10,
              alignment: MainAxisAlignment.end,
              overflowAlignment: overflowAlignment,
              overflowDirection: VerticalDirection.down,
              children: [
                _ActionButton(
                  tone: tone,
                  label: longLabels ? 'Cancel operation' : 'Cancel',
                  onTap: () => onEvent('cancel'),
                ),
                _ActionButton(
                  tone: _amber,
                  label: longLabels ? 'View policy diff' : 'Policy',
                  onTap: () => onEvent('policy'),
                ),
                _ActionButton(
                  tone: _jade,
                  label: longLabels ? 'Proceed with plan' : 'Proceed',
                  onTap: () => onEvent('proceed'),
                ),
                if (includeExtra)
                  _ActionButton(
                    tone: _rose,
                    label: longLabels ? 'Escalate owner review' : 'Escalate',
                    onTap: () => onEvent('escalate'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionalityScene extends StatefulWidget {
  const _DirectionalityScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_DirectionalityScene> createState() => _DirectionalitySceneState();
}

class _DirectionalitySceneState extends State<_DirectionalityScene> {
  double _panelWidth = 300;
  bool _longLabels = true;
  int _mainAlign = 0;
  final List<String> _events = <String>[];

  static const _alignValues = [
    MainAxisAlignment.start,
    MainAxisAlignment.center,
    MainAxisAlignment.end,
  ];

  static const _alignLabels = ['start', 'center', 'end'];

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
                      const Text('Directionality controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Panel width: ${_panelWidth.toStringAsFixed(0)}'),
                      Slider(
                        value: _panelWidth,
                        min: 220,
                        max: 520,
                        divisions: 15,
                        onChanged: (v) => setState(() => _panelWidth = v),
                        onChangeEnd: (v) => _push('panel width=${v.toStringAsFixed(0)}'),
                      ),
                      _EnumDropdown<int>(
                        label: 'alignment',
                        value: _mainAlign,
                        values: const [0, 1, 2],
                        labelBuilder: (v) => _alignLabels[v],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _mainAlign = v);
                            _push('alignment=${_alignLabels[v]}');
                          }
                        },
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _longLabels,
                        onChanged: (v) {
                          setState(() => _longLabels = v);
                          _push('long labels=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Long labels'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'OverflowBar can be given an explicit textDirection when mirrored language support is needed.',
                            'In RTL, action order and overflow anchoring should be intentionally validated with real labels.',
                            'Keep semantic importance clear when switching between LTR and RTL command bars.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Directionality timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
                child: Row(
                  children: [
                    Expanded(
                      child: _DirectionPanel(
                        tone: _rose,
                        title: 'LTR Panel',
                        width: _panelWidth,
                        textDirection: TextDirection.ltr,
                        alignment: _alignValues[_mainAlign],
                        longLabels: _longLabels,
                        onEvent: (e) => _push('ltr: $e'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DirectionPanel(
                        tone: _indigo,
                        title: 'RTL Panel',
                        width: _panelWidth,
                        textDirection: TextDirection.rtl,
                        alignment: _alignValues[_mainAlign],
                        longLabels: _longLabels,
                        onEvent: (e) => _push('rtl: $e'),
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
      _trim(_events, 52);
    });
  }
}

class _DirectionPanel extends StatelessWidget {
  const _DirectionPanel({
    required this.tone,
    required this.title,
    required this.width,
    required this.textDirection,
    required this.alignment,
    required this.longLabels,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final double width;
  final TextDirection textDirection;
  final MainAxisAlignment alignment;
  final bool longLabels;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          Text('textDirection=${textDirection.name}', style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Directionality(
                textDirection: textDirection,
                child: Container(
                  width: width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tone.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: OverflowBar(
                    spacing: 8,
                    alignment: alignment,
                    overflowSpacing: 10,
                    overflowAlignment: OverflowBarAlignment.end,
                    overflowDirection: VerticalDirection.down,
                    textDirection: textDirection,
                    children: [
                      _ProbeAction(label: longLabels ? 'Check status' : 'Status', tone: tone, onTap: () => onEvent('status')), 
                      _ProbeAction(label: longLabels ? 'Apply fix' : 'Fix', tone: tone, onTap: () => onEvent('fix')), 
                      _ProbeAction(label: longLabels ? 'Publish note' : 'Note', tone: tone, onTap: () => onEvent('note')), 
                      _ProbeAction(label: longLabels ? 'Close issue' : 'Close', tone: tone, onTap: () => onEvent('close')), 
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
    final sceneHeight = widget.compact ? 1260.0 : 1460.0;
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
                              tone: _blue,
                              title: 'Dashboard Module',
                              subtitle: 'Metrics command bar with prioritized overflow-safe actions.',
                              revision: _revision,
                              onEvent: (e) => _push('dashboard: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _jade,
                              title: 'Operations Module',
                              subtitle: 'Runbook controls optimized for varying pane widths.',
                              revision: _revision,
                              onEvent: (e) => _push('operations: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _indigo,
                              title: 'Release Module',
                              subtitle: 'Ship pipeline controls with stable action discoverability.',
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
                          'OverflowBar is ideal when primary actions should remain grouped while adapting to unknown container widths.',
                          'Pair action priority with consistent labels so stacked overflow still communicates hierarchy.',
                          'In operational UIs, overflow-safe command bars reduce accidental truncation and preserve reliability.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _FactTable(rows: [
                      _FactRow('revision', '$_revision'),
                      _FactRow('timeline entries', '${_events.length}'),
                      _FactRow('clock', _clock()),
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
  double _width = 340;
  bool _longLabels = true;
  int _overflowAlign = 0;

  static const _overflowAlignValues = [
    OverflowBarAlignment.start,
    OverflowBarAlignment.center,
    OverflowBarAlignment.end,
  ];

  static const _overflowAlignLabels = ['start', 'center', 'end'];

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
            value: _width,
            min: 220,
            max: 520,
            divisions: 15,
            onChanged: (v) => setState(() => _width = v),
            onChangeEnd: (v) => widget.onEvent('${widget.title}: width=${v.toStringAsFixed(0)}'),
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                  value: _longLabels,
                  onChanged: (v) {
                    setState(() => _longLabels = v);
                    widget.onEvent('${widget.title}: longLabels=$v');
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Long labels', style: TextStyle(fontSize: 12)),
                ),
                ),
              ),
              SizedBox(
                width: 130,
                child: _EnumDropdown<int>(
                  label: '',
                  value: _overflowAlign,
                  values: const [0, 1, 2],
                  labelBuilder: (v) => _overflowAlignLabels[v],
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => _overflowAlign = v);
                      widget.onEvent('${widget.title}: overflowAlign=${_overflowAlignLabels[v]}');
                    }
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                width: _width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.tone.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Command Bar', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    OverflowBar(
                      spacing: 8,
                      overflowSpacing: 10,
                      alignment: MainAxisAlignment.start,
                      overflowAlignment: _overflowAlignValues[_overflowAlign],
                      overflowDirection: VerticalDirection.down,
                      children: [
                        _ProbeAction(
                          label: _longLabels ? 'Sync telemetry' : 'Sync',
                          tone: widget.tone,
                          onTap: () => widget.onEvent('${widget.title}: sync'),
                        ),
                        _ProbeAction(
                          label: _longLabels ? 'Validate policy' : 'Validate',
                          tone: widget.tone,
                          onTap: () => widget.onEvent('${widget.title}: validate'),
                        ),
                        _ProbeAction(
                          label: _longLabels ? 'Promote wave' : 'Promote',
                          tone: widget.tone,
                          onTap: () => widget.onEvent('${widget.title}: promote'),
                        ),
                        _ProbeAction(
                          label: _longLabels ? 'Publish outcome' : 'Publish',
                          tone: widget.tone,
                          onTap: () => widget.onEvent('${widget.title}: publish'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        children: [
                          _MiniLine(tone: widget.tone, text: 'Action density remains controlled while width changes.'),
                          _MiniLine(tone: widget.tone, text: 'Overflow alignment reflects module semantics and command priority.'),
                          _MiniLine(tone: widget.tone, text: 'Buttons stay accessible without manual line-break logic.'),
                        ],
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
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.tone, required this.label, required this.onTap});

  final Color tone;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: tone.withValues(alpha: 0.15),
        foregroundColor: tone,
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}

class _ProbeAction extends StatelessWidget {
  const _ProbeAction({required this.label, required this.tone, required this.onTap});

  final String label;
  final Color tone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}

class _MiniLine extends StatelessWidget {
  const _MiniLine({required this.tone, required this.text});

  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.26)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
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

class _FactRow {
  const _FactRow(this.label, this.value);

  final String label;
  final String value;
}

class _FactTable extends StatelessWidget {
  const _FactTable({required this.rows});

  final List<_FactRow> rows;

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
                    SizedBox(width: 158, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
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
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.95), borderRadius: BorderRadius.circular(10)),
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
        if (label.isNotEmpty) SizedBox(width: 130, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
        Expanded(
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            items: values
                .map((v) => DropdownMenuItem<T>(value: v, child: Text(labelBuilder(v))))
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

class _RecapCard extends StatelessWidget {
  const _RecapCard();

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
          Text('Recap: OverflowBar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'OverflowBar is a robust action-group layout primitive. It keeps command sets coherent across widths by switching from a row '
            'to a stacked flow with controllable alignment and spacing, making it ideal for dialogs, toolbars, and operational control strips.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

void _trim(List<String> events, int limit) {
  if (events.length > limit) {
    events.removeRange(limit, events.length);
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
