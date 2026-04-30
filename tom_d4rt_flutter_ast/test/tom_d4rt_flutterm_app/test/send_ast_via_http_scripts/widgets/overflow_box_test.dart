import 'package:flutter/material.dart';

const _bg = Color(0xFFF5F8FD);
const _ink = Color(0xFF17384E);
const _blue = Color(0xFF2A6BA1);
const _jade = Color(0xFF2F856E);
const _amber = Color(0xFFAD7C34);
const _rose = Color(0xFF9D5D73);
const _indigo = Color(0xFF635BB2);

dynamic build(BuildContext context) {
  return const _OverflowBoxDeepDemoApp();
}

class _OverflowBoxDeepDemoApp extends StatelessWidget {
  const _OverflowBoxDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _OverflowBoxDeepDemoPage(),
    );
  }
}

class _OverflowBoxDeepDemoPage extends StatefulWidget {
  const _OverflowBoxDeepDemoPage();

  @override
  State<_OverflowBoxDeepDemoPage> createState() => _OverflowBoxDeepDemoPageState();
}

class _OverflowBoxDeepDemoPageState extends State<_OverflowBoxDeepDemoPage> {
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
              const Text('OverflowBox Deep Demo'),
              Text(
                'constraint override patterns | intentional overflow composition',
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
                title: 'Constraint Fundamentals Studio',
                subtitle:
                    'Tune parent and child bounds while OverflowBox overrides min/max constraints and alignment behavior in real time.',
                child: _FundamentalsScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _jade,
                title: 'Alignment and Fit Matrix',
                subtitle:
                    'Compare alignment anchors and fit policies under identical parent bounds to understand where overflow content is painted.',
                child: _AlignmentMatrixScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Constraint Negotiation Lab',
                subtitle:
                    'Side-by-side lanes show clipped and unclipped overflow behavior plus interaction markers for boundary reasoning.',
                child: _NegotiationScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Interaction and Annotation Workshop',
                subtitle:
                    'Oversized cards with annotation overlays demonstrate practical monitoring of intended bounds versus painted bounds.',
                child: _AnnotationScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _indigo,
                title: 'Practical Layout Console',
                subtitle:
                    'Three module-style shells use OverflowBox for badges, callouts, and command clusters that intentionally exceed parent geometry.',
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
          colors: [Color(0xFF18384E), Color(0xFF2A6AA2), Color(0xFF2F846E), Color(0xFF635AB1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OverflowBox Control Deck', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text(
            'OverflowBox allows a child to receive constraints different from its parent. '
            'It is a precision tool for deliberate visual overflow, edge callouts, and cross-boundary composition patterns.',
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

class _SceneShell extends StatelessWidget {
  const _SceneShell({required this.index, required this.tone, required this.title, required this.subtitle, required this.child});

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
  double _parentW = 360;
  double _parentH = 260;
  double _childW = 520;
  double _childH = 180;
  double? _minW = 0;
  double? _maxW = 640;
  double? _minH = 0;
  double? _maxH = 300;
  int _alignment = 4;
  bool _showBounds = true;
  final List<String> _events = <String>[];

  static const _alignments = <AlignmentGeometry>[
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  static const _alignmentLabels = <String>[
    'topLeft',
    'topCenter',
    'topRight',
    'centerLeft',
    'center',
    'centerRight',
    'bottomLeft',
    'bottomCenter',
    'bottomRight',
  ];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1050.0 : 1260.0;
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
                      const Text('Fundamentals controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Parent width: ${_parentW.toStringAsFixed(0)}'),
                      Slider(
                        value: _parentW,
                        min: 220,
                        max: 760,
                        divisions: 27,
                        onChanged: (v) => setState(() => _parentW = v),
                        onChangeEnd: (v) => _push('parent width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Parent height: ${_parentH.toStringAsFixed(0)}'),
                      Slider(
                        value: _parentH,
                        min: 180,
                        max: 520,
                        divisions: 17,
                        onChanged: (v) => setState(() => _parentH = v),
                        onChangeEnd: (v) => _push('parent height=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Child width intent: ${_childW.toStringAsFixed(0)}'),
                      Slider(
                        value: _childW,
                        min: 120,
                        max: 900,
                        divisions: 39,
                        onChanged: (v) => setState(() => _childW = v),
                        onChangeEnd: (v) => _push('child width intent=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Child height intent: ${_childH.toStringAsFixed(0)}'),
                      Slider(
                        value: _childH,
                        min: 80,
                        max: 500,
                        divisions: 21,
                        onChanged: (v) => setState(() => _childH = v),
                        onChangeEnd: (v) => _push('child height intent=${v.toStringAsFixed(0)}'),
                      ),
                      const SizedBox(height: 6),
                      _EnumDropdown<int>(
                        label: 'alignment',
                        value: _alignment,
                        values: const [0, 1, 2, 3, 4, 5, 6, 7, 8],
                        labelBuilder: (v) => _alignmentLabels[v],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _alignment = v);
                            _push('alignment=${_alignmentLabels[v]}');
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _NullableSlider(
                        label: 'minWidth',
                        value: _minW,
                        min: 0,
                        max: 700,
                        onChanged: (v) => setState(() => _minW = v),
                        onToggleNull: (isNull) => setState(() => _minW = isNull ? null : 0),
                        onChangeEnd: (v) => _push('minWidth=${v?.toStringAsFixed(0) ?? 'null'}'),
                      ),
                      _NullableSlider(
                        label: 'maxWidth',
                        value: _maxW,
                        min: 120,
                        max: 900,
                        onChanged: (v) => setState(() => _maxW = v),
                        onToggleNull: (isNull) => setState(() => _maxW = isNull ? null : 640),
                        onChangeEnd: (v) => _push('maxWidth=${v?.toStringAsFixed(0) ?? 'null'}'),
                      ),
                      _NullableSlider(
                        label: 'minHeight',
                        value: _minH,
                        min: 0,
                        max: 500,
                        onChanged: (v) => setState(() => _minH = v),
                        onToggleNull: (isNull) => setState(() => _minH = isNull ? null : 0),
                        onChangeEnd: (v) => _push('minHeight=${v?.toStringAsFixed(0) ?? 'null'}'),
                      ),
                      _NullableSlider(
                        label: 'maxHeight',
                        value: _maxH,
                        min: 80,
                        max: 600,
                        onChanged: (v) => setState(() => _maxH = v),
                        onToggleNull: (isNull) => setState(() => _maxH = isNull ? null : 300),
                        onChangeEnd: (v) => _push('maxHeight=${v?.toStringAsFixed(0) ?? 'null'}'),
                      ),
                      SwitchListTile(
                        value: _showBounds,
                        onChanged: (v) => setState(() => _showBounds = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show boundary overlays'),
                      ),
                      const SizedBox(height: 8),
                      _FactTable(rows: [
                        _FactRow('parent', '${_parentW.toStringAsFixed(0)} x ${_parentH.toStringAsFixed(0)}'),
                        _FactRow('child intent', '${_childW.toStringAsFixed(0)} x ${_childH.toStringAsFixed(0)}'),
                        _FactRow('min / max width', '${_minW?.toStringAsFixed(0) ?? 'null'} / ${_maxW?.toStringAsFixed(0) ?? 'null'}'),
                        _FactRow('min / max height', '${_minH?.toStringAsFixed(0) ?? 'null'} / ${_maxH?.toStringAsFixed(0) ?? 'null'}'),
                        _FactRow('alignment', _alignmentLabels[_alignment]),
                      ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'OverflowBox lets child constraints differ from parent constraints; painted size can exceed parent size.',
                            'Alignment decides where oversized content anchors within the parent paint region.',
                            'Use min/max overrides carefully: they can expand beyond local bounds and affect visual hierarchy.',
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
                      const Text('Overflow preview canvas', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: _parentW,
                            height: _parentH,
                            decoration: BoxDecoration(
                              color: _blue.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _blue.withValues(alpha: 0.28), width: 2),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (_showBounds)
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: _BoundsPainter(),
                                    ),
                                  ),
                                OverflowBox(
                                  alignment: _alignments[_alignment],
                                  minWidth: _minW,
                                  maxWidth: _maxW,
                                  minHeight: _minH,
                                  maxHeight: _maxH,
                                  child: Container(
                                    width: _childW,
                                    height: _childH,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          _blue.withValues(alpha: 0.85),
                                          _jade.withValues(alpha: 0.85),
                                          _amber.withValues(alpha: 0.85),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Overflow Child', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                                          const SizedBox(height: 6),
                                          const Text(
                                            'This child is intentionally larger than parent bounds. '
                                            'Use controls to inspect alignment and constraint overrides.',
                                            style: TextStyle(color: Colors.white, height: 1.35),
                                          ),
                                          const Spacer(),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: [
                                              _EventPill(label: 'Mark', onTap: () => _push('mark action')), 
                                              _EventPill(label: 'Inspect', onTap: () => _push('inspect action')), 
                                              _EventPill(label: 'Freeze', onTap: () => _push('freeze action')), 
                                            ],
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
      _trim(_events, 48);
    });
  }
}

class _AlignmentMatrixScene extends StatefulWidget {
  const _AlignmentMatrixScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_AlignmentMatrixScene> createState() => _AlignmentMatrixSceneState();
}

class _AlignmentMatrixSceneState extends State<_AlignmentMatrixScene> {
  double _parentW = 280;
  double _parentH = 220;
  double _childW = 420;
  double _childH = 220;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1120.0 : 1320.0;
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
                      const Text('Matrix controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Parent width: ${_parentW.toStringAsFixed(0)}'),
                      Slider(
                        value: _parentW,
                        min: 200,
                        max: 480,
                        divisions: 14,
                        onChanged: (v) => setState(() => _parentW = v),
                        onChangeEnd: (v) => _push('parent width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Parent height: ${_parentH.toStringAsFixed(0)}'),
                      Slider(
                        value: _parentH,
                        min: 160,
                        max: 360,
                        divisions: 10,
                        onChanged: (v) => setState(() => _parentH = v),
                        onChangeEnd: (v) => _push('parent height=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Child width: ${_childW.toStringAsFixed(0)}'),
                      Slider(
                        value: _childW,
                        min: 220,
                        max: 620,
                        divisions: 20,
                        onChanged: (v) => setState(() => _childW = v),
                        onChangeEnd: (v) => _push('child width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Child height: ${_childH.toStringAsFixed(0)}'),
                      Slider(
                        value: _childH,
                        min: 120,
                        max: 380,
                        divisions: 13,
                        onChanged: (v) => setState(() => _childH = v),
                        onChangeEnd: (v) => _push('child height=${v.toStringAsFixed(0)}'),
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _jade,
                          lines: const [
                            'This matrix isolates alignment as the variable, so anchor shifts are easier to compare.',
                            'Parent bounds remain fixed while child intent changes, making overflow direction easy to inspect.',
                            'Observe where paint escapes each parent box and how that changes interaction expectations.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Matrix timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.95,
                  children: [
                    _AlignmentProbe(
                      tone: _jade,
                      title: 'topLeft',
                      alignment: Alignment.topLeft,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('topLeft: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _amber,
                      title: 'topCenter',
                      alignment: Alignment.topCenter,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('topCenter: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _rose,
                      title: 'topRight',
                      alignment: Alignment.topRight,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('topRight: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _blue,
                      title: 'centerLeft',
                      alignment: Alignment.centerLeft,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('centerLeft: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _indigo,
                      title: 'center',
                      alignment: Alignment.center,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('center: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _jade,
                      title: 'centerRight',
                      alignment: Alignment.centerRight,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('centerRight: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _amber,
                      title: 'bottomLeft',
                      alignment: Alignment.bottomLeft,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('bottomLeft: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _rose,
                      title: 'bottomCenter',
                      alignment: Alignment.bottomCenter,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('bottomCenter: $e'),
                    ),
                    _AlignmentProbe(
                      tone: _indigo,
                      title: 'bottomRight',
                      alignment: Alignment.bottomRight,
                      parentW: _parentW,
                      parentH: _parentH,
                      childW: _childW,
                      childH: _childH,
                      onEvent: (e) => _push('bottomRight: $e'),
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
      _trim(_events, 54);
    });
  }
}

class _AlignmentProbe extends StatelessWidget {
  const _AlignmentProbe({
    required this.tone,
    required this.title,
    required this.alignment,
    required this.parentW,
    required this.parentH,
    required this.childW,
    required this.childH,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final AlignmentGeometry alignment;
  final double parentW;
  final double parentH;
  final double childW;
  final double childH;
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
          const Text('alignment probe', style: TextStyle(fontSize: 11)),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Container(
                width: parentW,
                height: parentH,
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tone.withValues(alpha: 0.35)),
                ),
                child: OverflowBox(
                  alignment: alignment,
                  minWidth: 0,
                  maxWidth: childW,
                  minHeight: 0,
                  maxHeight: childH,
                  child: GestureDetector(
                    onTap: () => onEvent('probe tapped'),
                    child: Container(
                      width: childW,
                      height: childH,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [tone.withValues(alpha: 0.9), tone.withValues(alpha: 0.6)]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text('Overflow Child', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
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
}

class _NegotiationScene extends StatefulWidget {
  const _NegotiationScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_NegotiationScene> createState() => _NegotiationSceneState();
}

class _NegotiationSceneState extends State<_NegotiationScene> {
  double _laneWidth = 320;
  double _laneHeight = 220;
  double _childWidth = 520;
  bool _clipLeft = false;
  bool _clipRight = true;
  bool _showGuide = true;
  final List<String> _events = <String>[];

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
                      const Text('Negotiation controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Lane width: ${_laneWidth.toStringAsFixed(0)}'),
                      Slider(
                        value: _laneWidth,
                        min: 220,
                        max: 520,
                        divisions: 15,
                        onChanged: (v) => setState(() => _laneWidth = v),
                        onChangeEnd: (v) => _push('lane width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Lane height: ${_laneHeight.toStringAsFixed(0)}'),
                      Slider(
                        value: _laneHeight,
                        min: 160,
                        max: 360,
                        divisions: 10,
                        onChanged: (v) => setState(() => _laneHeight = v),
                        onChangeEnd: (v) => _push('lane height=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Child width: ${_childWidth.toStringAsFixed(0)}'),
                      Slider(
                        value: _childWidth,
                        min: 220,
                        max: 740,
                        divisions: 26,
                        onChanged: (v) => setState(() => _childWidth = v),
                        onChangeEnd: (v) => _push('child width=${v.toStringAsFixed(0)}'),
                      ),
                      SwitchListTile(
                        value: _clipLeft,
                        onChanged: (v) {
                          setState(() => _clipLeft = v);
                          _push('left lane clip=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Clip left lane'),
                      ),
                      SwitchListTile(
                        value: _clipRight,
                        onChanged: (v) {
                          setState(() => _clipRight = v);
                          _push('right lane clip=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Clip right lane'),
                      ),
                      SwitchListTile(
                        value: _showGuide,
                        onChanged: (v) => setState(() => _showGuide = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show annotation guides'),
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'OverflowBox changes child constraints, but clipping is still controlled by ancestor paint behavior.',
                            'A clipped parent can hide overflow even when child constraints allow larger size.',
                            'Compare both lanes to reason about final paint output and interaction zones.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Negotiation timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
                child: Row(
                  children: [
                    Expanded(
                      child: _NegotiationLane(
                        tone: _amber,
                        title: 'Lane A (left anchor)',
                        laneWidth: _laneWidth,
                        laneHeight: _laneHeight,
                        childWidth: _childWidth,
                        alignment: Alignment.centerLeft,
                        clip: _clipLeft,
                        showGuide: _showGuide,
                        onEvent: (e) => _push('lane A: $e'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _NegotiationLane(
                        tone: _rose,
                        title: 'Lane B (right anchor)',
                        laneWidth: _laneWidth,
                        laneHeight: _laneHeight,
                        childWidth: _childWidth,
                        alignment: Alignment.centerRight,
                        clip: _clipRight,
                        showGuide: _showGuide,
                        onEvent: (e) => _push('lane B: $e'),
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

class _NegotiationLane extends StatelessWidget {
  const _NegotiationLane({
    required this.tone,
    required this.title,
    required this.laneWidth,
    required this.laneHeight,
    required this.childWidth,
    required this.alignment,
    required this.clip,
    required this.showGuide,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final double laneWidth;
  final double laneHeight;
  final double childWidth;
  final AlignmentGeometry alignment;
  final bool clip;
  final bool showGuide;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: laneWidth,
      height: laneHeight,
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.35), width: 2),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGuide)
            Positioned.fill(
              child: CustomPaint(painter: _BoundsPainter()),
            ),
          OverflowBox(
            alignment: alignment,
            minWidth: 0,
            maxWidth: childWidth,
            minHeight: 0,
            maxHeight: laneHeight + 80,
            child: GestureDetector(
              onTap: () => onEvent('oversized child tapped'),
              child: Container(
                width: childWidth,
                height: laneHeight - 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [tone.withValues(alpha: 0.9), tone.withValues(alpha: 0.65)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text('Overflow child', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (clip) {
      content = ClipRect(child: content);
    }

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
          Text('clip=${clip ? 'on' : 'off'}', style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 8),
          Expanded(child: Center(child: content)),
        ],
      ),
    );
  }
}

class _AnnotationScene extends StatefulWidget {
  const _AnnotationScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_AnnotationScene> createState() => _AnnotationSceneState();
}

class _AnnotationSceneState extends State<_AnnotationScene> {
  double _canvasW = 760;
  double _canvasH = 300;
  bool _showOverlay = true;
  bool _showLabels = true;
  final List<String> _events = <String>[];

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
                      const Text('Annotation controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Canvas width: ${_canvasW.toStringAsFixed(0)}'),
                      Slider(
                        value: _canvasW,
                        min: 320,
                        max: 980,
                        divisions: 33,
                        onChanged: (v) => setState(() => _canvasW = v),
                        onChangeEnd: (v) => _push('canvas width=${v.toStringAsFixed(0)}'),
                      ),
                      Text('Canvas height: ${_canvasH.toStringAsFixed(0)}'),
                      Slider(
                        value: _canvasH,
                        min: 200,
                        max: 520,
                        divisions: 16,
                        onChanged: (v) => setState(() => _canvasH = v),
                        onChangeEnd: (v) => _push('canvas height=${v.toStringAsFixed(0)}'),
                      ),
                      SwitchListTile(
                        value: _showOverlay,
                        onChanged: (v) => setState(() => _showOverlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show boundary overlay'),
                      ),
                      SwitchListTile(
                        value: _showLabels,
                        onChanged: (v) => setState(() => _showLabels = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show annotation labels'),
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'Annotation overlays help teams reason about intended parent bounds versus painted overflow regions.',
                            'Use this during UI reviews to prevent accidental clipping in composed layouts.',
                            'Interactive markers validate that overflow content can still receive gestures where expected.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Annotation timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
                    width: _canvasW,
                    height: _canvasH,
                    decoration: BoxDecoration(
                      color: _rose.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _rose.withValues(alpha: 0.32), width: 2),
                    ),
                    child: Stack(
                      children: [
                        if (_showOverlay)
                          Positioned.fill(
                            child: CustomPaint(painter: _BoundsPainter()),
                          ),
                        Positioned.fill(
                          child: Center(
                            child: OverflowBox(
                              alignment: Alignment.center,
                              minWidth: 0,
                              maxWidth: _canvasW + 220,
                              minHeight: 0,
                              maxHeight: _canvasH + 140,
                              child: Container(
                                width: _canvasW + 180,
                                height: _canvasH - 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    _rose.withValues(alpha: 0.88),
                                    _indigo.withValues(alpha: 0.86),
                                  ]),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 16,
                                      top: 14,
                                      child: Text(
                                        'Oversized Annotation Canvas',
                                        style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontWeight: FontWeight.w800, fontSize: 18),
                                      ),
                                    ),
                                    if (_showLabels) ...[
                                      Positioned(
                                        left: 22,
                                        top: 54,
                                        child: _LabelTag(text: 'painted outside parent', tone: _amber),
                                      ),
                                      Positioned(
                                        right: 18,
                                        bottom: 20,
                                        child: _LabelTag(text: 'gesture target zone', tone: _jade),
                                      ),
                                      Positioned(
                                        right: 40,
                                        top: 70,
                                        child: _LabelTag(text: 'overflow corridor', tone: _blue),
                                      ),
                                    ],
                                    Positioned(
                                      left: 20,
                                      bottom: 18,
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          _ProbeAction(label: 'Mark anchor', tone: _amber, onTap: () => _push('mark anchor')), 
                                          _ProbeAction(label: 'Trace bounds', tone: _jade, onTap: () => _push('trace bounds')), 
                                          _ProbeAction(label: 'Tag issue', tone: _blue, onTap: () => _push('tag issue')), 
                                        ],
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
      _trim(_events, 44);
    });
  }
}

class _LabelTag extends StatelessWidget {
  const _LabelTag({required this.text, required this.tone});

  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
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
    final sceneHeight = widget.compact ? 1240.0 : 1460.0;
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
                              title: 'Dashboard Shell',
                              subtitle: 'Overflow badges and KPI ribbons extend beyond cards intentionally.',
                              revision: _revision,
                              onEvent: (e) => _push('dashboard: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _jade,
                              title: 'Operations Shell',
                              subtitle: 'Runbook callouts exceed tile bounds while preserving signal prominence.',
                              revision: _revision,
                              onEvent: (e) => _push('operations: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _indigo,
                              title: 'Release Shell',
                              subtitle: 'Command clusters project outside parent tiles to maintain urgency hierarchy.',
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
                          'OverflowBox should be used intentionally, with clear reasons for visual overflow and explicit documentation.',
                          'Pair overflow visuals with clipping policy decisions so future refactors do not hide critical content.',
                          'In product UIs, overflow can improve emphasis for alerts, badges, and quick action controls.',
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
  const _PracticalModule({required this.tone, required this.title, required this.subtitle, required this.revision, required this.onEvent});

  final Color tone;
  final String title;
  final String subtitle;
  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalModule> createState() => _PracticalModuleState();
}

class _PracticalModuleState extends State<_PracticalModule> {
  double _tileW = 280;
  double _tileH = 210;
  double _overflowW = 360;
  int _anchor = 4;

  static const _anchors = <AlignmentGeometry>[
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  static const _anchorLabels = <String>[
    'topLeft',
    'topCenter',
    'topRight',
    'centerLeft',
    'center',
    'centerRight',
    'bottomLeft',
    'bottomCenter',
    'bottomRight',
  ];

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
            value: _tileW,
            min: 220,
            max: 420,
            divisions: 10,
            onChanged: (v) => setState(() => _tileW = v),
            onChangeEnd: (v) => widget.onEvent('${widget.title}: tile width=${v.toStringAsFixed(0)}'),
          ),
          Slider(
            value: _tileH,
            min: 160,
            max: 320,
            divisions: 8,
            onChanged: (v) => setState(() => _tileH = v),
            onChangeEnd: (v) => widget.onEvent('${widget.title}: tile height=${v.toStringAsFixed(0)}'),
          ),
          Slider(
            value: _overflowW,
            min: 240,
            max: 520,
            divisions: 14,
            onChanged: (v) => setState(() => _overflowW = v),
            onChangeEnd: (v) => widget.onEvent('${widget.title}: overflow width=${v.toStringAsFixed(0)}'),
          ),
          _EnumDropdown<int>(
            label: 'anchor',
            value: _anchor,
            values: const [0, 1, 2, 3, 4, 5, 6, 7, 8],
            labelBuilder: (v) => _anchorLabels[v],
            onChanged: (v) {
              if (v != null) {
                setState(() => _anchor = v);
                widget.onEvent('${widget.title}: anchor=${_anchorLabels[v]}');
              }
            },
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Center(
              child: Container(
                width: _tileW,
                height: _tileH,
                decoration: BoxDecoration(
                  color: widget.tone.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: widget.tone.withValues(alpha: 0.3)),
                ),
                child: OverflowBox(
                  alignment: _anchors[_anchor],
                  minWidth: 0,
                  maxWidth: _overflowW,
                  minHeight: 0,
                  maxHeight: _tileH + 90,
                  child: Container(
                    width: _overflowW,
                    height: _tileH - 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [widget.tone.withValues(alpha: 0.9), widget.tone.withValues(alpha: 0.65)]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Overflow callout', style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          const Text('Module priority ribbon exceeds tile bounds for emphasis.', style: TextStyle(color: Colors.white, fontSize: 12)),
                          const Spacer(),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              _ProbeAction(label: 'Inspect', tone: _amber, onTap: () => widget.onEvent('${widget.title}: inspect')), 
                              _ProbeAction(label: 'Escalate', tone: _rose, onTap: () => widget.onEvent('${widget.title}: escalate')), 
                            ],
                          ),
                        ],
                      ),
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
}

class _BoundsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = const Color(0x14000000)
      ..strokeWidth = 1;
    const step = 18.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final border = Paint()
      ..color = const Color(0x66354E62)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(Offset.zero & size, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EventPill extends StatelessWidget {
  const _EventPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
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
                    SizedBox(width: 165, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
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

class _NullableSlider extends StatelessWidget {
  const _NullableSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onToggleNull,
    required this.onChangeEnd,
  });

  final String label;
  final double? value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final ValueChanged<bool> onToggleNull;
  final ValueChanged<double?> onChangeEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('$label: ${value?.toStringAsFixed(0) ?? 'null'}')),
            Switch(
              value: value == null,
              onChanged: onToggleNull,
            ),
            const Text('null'),
          ],
        ),
        Slider(
          value: value ?? min,
          min: min,
          max: max,
          divisions: 20,
          onChanged: value == null ? null : onChanged,
          onChangeEnd: value == null ? null : (v) => onChangeEnd(v),
        ),
      ],
    );
  }
}

class _EnumDropdown<T> extends StatelessWidget {
  const _EnumDropdown({required this.label, required this.value, required this.values, required this.labelBuilder, required this.onChanged});

  final String label;
  final T value;
  final List<T> values;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 130, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
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
          Text('Recap: OverflowBox', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'OverflowBox is a constraint-override widget for deliberate visual overflow. '
            'Used with care, it unlocks expressive UI patterns such as callouts, ribbons, badges, and cross-boundary command clusters '
            'while preserving layout intent through explicit alignment and clipping decisions.',
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
