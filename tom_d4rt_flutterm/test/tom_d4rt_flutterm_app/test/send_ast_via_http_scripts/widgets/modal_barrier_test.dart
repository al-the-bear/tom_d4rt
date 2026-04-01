import 'package:flutter/material.dart';

const _bg = Color(0xFFF3F7FC);
const _ink = Color(0xFF17384F);
const _blue = Color(0xFF2C6798);
const _teal = Color(0xFF2F8271);
const _amber = Color(0xFFAE7A32);
const _rose = Color(0xFF9B5E74);
const _violet = Color(0xFF685DB2);

dynamic build(BuildContext context) {
  return const _ModalBarrierDeepDemoApp();
}

class _ModalBarrierDeepDemoApp extends StatelessWidget {
  const _ModalBarrierDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _ModalBarrierDeepDemoPage(),
    );
  }
}

class _ModalBarrierDeepDemoPage extends StatefulWidget {
  const _ModalBarrierDeepDemoPage();

  @override
  State<_ModalBarrierDeepDemoPage> createState() => _ModalBarrierDeepDemoPageState();
}

class _ModalBarrierDeepDemoPageState extends State<_ModalBarrierDeepDemoPage> {
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
              const Text('ModalBarrier Deep Demo'),
              Text(
                'interaction blocking | dismiss flows | safety overlays for critical operations',
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
                title: 'Barrier Fundamentals Theater',
                subtitle:
                    'Directly tune ModalBarrier color, dismissibility, and semantics while observing blocked interactions and dismiss callbacks.',
                child: _FundamentalsScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _teal,
                title: 'Interaction Blocking Lab',
                subtitle:
                    'Parallel use-cases showing how barriers with different dismiss behaviors impact taps on controls below the barrier layer.',
                child: _BlockingLabScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Workflow Gate Stage',
                subtitle:
                    'Modal workflow simulation where a barrier protects route-critical steps and controls progression through staged operations.',
                child: _WorkflowStageScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Barrier Control Matrix',
                subtitle:
                    'Grid of lane-specific barriers with unique tones, opacity profiles, and dismiss rules to compare behavior quickly.',
                child: _MatrixScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Command Console',
                subtitle:
                    'Production-style modules with temporary safety lock barriers for processing, validation, and confirmation phases.',
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
          colors: [Color(0xFF18374D), Color(0xFF296A9D), Color(0xFF36816F), Color(0xFF685CB2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ModalBarrier Control Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'ModalBarrier creates an interaction shield above content. It is commonly used to enforce modal focus, '
            'prevent accidental taps during processing, and stage controlled dismiss behavior.',
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
  bool _showBarrier = false;
  bool _dismissible = true;
  bool _showDialogCard = true;
  String _semanticsLabel = 'Dismiss modal barrier';
  double _opacity = 0.56;
  Color _tone = _blue;
  int _underTap = 0;
  int _barrierTap = 0;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 920.0 : 1080.0;
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
                        value: _showBarrier,
                        onChanged: (v) => setState(() => _showBarrier = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show barrier'),
                      ),
                      SwitchListTile(
                        value: _dismissible,
                        onChanged: (v) => setState(() => _dismissible = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Barrier dismissible'),
                      ),
                      SwitchListTile(
                        value: _showDialogCard,
                        onChanged: (v) => setState(() => _showDialogCard = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show modal card on top'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: TextEditingController(text: _semanticsLabel),
                        decoration: const InputDecoration(labelText: 'Semantics label', border: OutlineInputBorder()),
                        onSubmitted: (v) => setState(() => _semanticsLabel = v.trim().isEmpty ? _semanticsLabel : v.trim()),
                      ),
                      const SizedBox(height: 8),
                      _MiniSlider(
                        label: 'Opacity',
                        value: _opacity,
                        min: 0.1,
                        max: 0.92,
                        onChanged: (v) => setState(() => _opacity = v),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Color>(
                        initialValue: _tone,
                        decoration: const InputDecoration(labelText: 'Barrier tone', border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(value: _blue, child: Text('Blue')),
                          DropdownMenuItem(value: _teal, child: Text('Teal')),
                          DropdownMenuItem(value: _amber, child: Text('Amber')),
                          DropdownMenuItem(value: _rose, child: Text('Rose')),
                          DropdownMenuItem(value: _violet, child: Text('Violet')),
                        ],
                        onChanged: (v) => setState(() => _tone = v ?? _tone),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('barrier visible', _showBarrier ? 'yes' : 'no'),
                          _DataRowItem('dismissible', _dismissible ? 'true' : 'false'),
                          _DataRowItem('under-surface taps', '$_underTap'),
                          _DataRowItem('barrier dismiss taps', '$_barrierTap'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'ModalBarrier sits above content and blocks interactions beneath it.',
                            'Use dismissible=false for strict flows where users must complete an operation first.',
                            'Semantics labels are important so assistive technologies can describe the barrier action context.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Fundamentals event log', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 210, child: _LogCard(lines: _events)),
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
                child: Transform.scale(
                  scale: widget.zoom,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Positioned.fill(child: _ToneBackdrop(tone: _blue, label: 'Underlying interactive surface')),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _ActionTile(
                              tone: _blue,
                              title: 'Queue Control',
                              subtitle: 'Tap target behind barrier',
                              onPressed: () {
                                setState(() {
                                  _underTap += 1;
                                  _events.insert(0, '${_clock()} | queue control tapped');
                                  _trim(_events, 36);
                                });
                              },
                            ),
                            _ActionTile(
                              tone: _teal,
                              title: 'Bridge Reset',
                              subtitle: 'Another background action',
                              onPressed: () {
                                setState(() {
                                  _underTap += 1;
                                  _events.insert(0, '${_clock()} | bridge reset tapped');
                                  _trim(_events, 36);
                                });
                              },
                            ),
                            _ActionTile(
                              tone: _amber,
                              title: 'Publish Stage',
                              subtitle: 'Pipeline handoff command',
                              onPressed: () {
                                setState(() {
                                  _underTap += 1;
                                  _events.insert(0, '${_clock()} | publish stage tapped');
                                  _trim(_events, 36);
                                });
                              },
                            ),
                            _ActionTile(
                              tone: _rose,
                              title: 'Alert Routing',
                              subtitle: 'Incident line action',
                              onPressed: () {
                                setState(() {
                                  _underTap += 1;
                                  _events.insert(0, '${_clock()} | alert routing tapped');
                                  _trim(_events, 36);
                                });
                              },
                            ),
                            _ActionTile(
                              tone: _violet,
                              title: 'Session Commit',
                              subtitle: 'Finalize context snapshot',
                              onPressed: () {
                                setState(() {
                                  _underTap += 1;
                                  _events.insert(0, '${_clock()} | session commit tapped');
                                  _trim(_events, 36);
                                });
                              },
                            ),
                            _ActionTile(
                              tone: _teal,
                              title: 'Fallback Retry',
                              subtitle: 'Recovery branch action',
                              onPressed: () {
                                setState(() {
                                  _underTap += 1;
                                  _events.insert(0, '${_clock()} | fallback retry tapped');
                                  _trim(_events, 36);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      if (_showBarrier)
                        Positioned.fill(
                          child: ModalBarrier(
                            color: _tone.withValues(alpha: _opacity),
                            dismissible: _dismissible,
                            semanticsLabel: _semanticsLabel,
                            onDismiss: _dismissible
                                ? () {
                                    setState(() {
                                      _barrierTap += 1;
                                      _showBarrier = false;
                                      _events.insert(0, '${_clock()} | barrier dismissed by tap');
                                      _trim(_events, 36);
                                    });
                                  }
                                : null,
                          ),
                        ),
                      if (_showBarrier && _showDialogCard)
                        Center(
                          child: Container(
                            width: 360,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: _tone.withValues(alpha: 0.42), width: 2),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 18, offset: const Offset(0, 10)),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Modal Focus Card', style: TextStyle(color: _tone, fontWeight: FontWeight.w800, fontSize: 18)),
                                const SizedBox(height: 6),
                                const Text(
                                  'This card represents a focused modal task. The barrier prevents accidental interaction with the background.',
                                  style: TextStyle(height: 1.35),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FilledButton.tonal(
                                        onPressed: _dismissible
                                            ? () {
                                                setState(() {
                                                  _showBarrier = false;
                                                  _events.insert(0, '${_clock()} | card action dismissed barrier');
                                                  _trim(_events, 36);
                                                });
                                              }
                                            : null,
                                        child: const Text('Complete'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: FilledButton.tonal(
                                        onPressed: () {
                                          setState(() {
                                            _events.insert(0, '${_clock()} | secondary card action executed');
                                            _trim(_events, 36);
                                          });
                                        },
                                        child: const Text('Secondary'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.tone, required this.title, required this.subtitle, required this.onPressed});

  final Color tone;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 258,
      height: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.34)),
        boxShadow: [
          BoxShadow(color: tone.withValues(alpha: 0.14), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12)),
          const Spacer(),
          FilledButton.tonal(onPressed: onPressed, child: const Text('Trigger')), 
        ],
      ),
    );
  }
}

class _BlockingLabScene extends StatefulWidget {
  const _BlockingLabScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_BlockingLabScene> createState() => _BlockingLabSceneState();
}

class _BlockingLabSceneState extends State<_BlockingLabScene> {
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 920.0 : 1100.0;
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
                    const Text('Blocking lab notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text(
                      'Each lane below has background controls and a separately configured barrier. '
                      'Compare whether taps below are blocked and how dismiss callbacks behave.',
                      style: TextStyle(height: 1.35),
                    ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _teal,
                        lines: const [
                          'Use non-dismissible barriers for must-complete flows, such as payment authorization or destructive confirmation.',
                          'Use dismissible barriers for lightweight interruption patterns where cancellation should be easy.',
                          'Give each barrier a distinct visual tone in complex UIs so users understand which context is currently modal.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Lab event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
                child: Column(
                  children: [
                    Expanded(
                      child: _BarrierCase(
                        tone: _teal,
                        title: 'Dismissible Lane',
                        subtitle: 'Barrier can be tapped away to re-enable controls.',
                        initialDismissible: true,
                        onEvent: (e) => _push(e),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _BarrierCase(
                        tone: _amber,
                        title: 'Strict Lane',
                        subtitle: 'Barrier enforces completion of top action.',
                        initialDismissible: false,
                        onEvent: (e) => _push(e),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _BarrierCase(
                        tone: _rose,
                        title: 'Soft Lock Lane',
                        subtitle: 'Dismissible with lower opacity and softer tone.',
                        initialDismissible: true,
                        onEvent: (e) => _push(e),
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

class _BarrierCase extends StatefulWidget {
  const _BarrierCase({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.initialDismissible,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final bool initialDismissible;
  final ValueChanged<String> onEvent;

  @override
  State<_BarrierCase> createState() => _BarrierCaseState();
}

class _BarrierCaseState extends State<_BarrierCase> {
  bool _barrierVisible = false;
  late bool _dismissible;
  double _opacity = 0.52;
  int _backgroundTap = 0;
  int _dismissTap = 0;

  @override
  void initState() {
    super.initState();
    _dismissible = widget.initialDismissible;
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
              _ToneChip(tone: widget.tone, label: _dismissible ? 'dismissible' : 'strict'),
            ],
          ),
          const SizedBox(height: 3),
          Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: _barrierVisible,
                  onChanged: (v) {
                    setState(() => _barrierVisible = v);
                    widget.onEvent('${widget.title}: barrier visible=$v');
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Barrier', style: TextStyle(fontSize: 12)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: _dismissible,
                  onChanged: (v) {
                    setState(() => _dismissible = v);
                    widget.onEvent('${widget.title}: dismissible=$v');
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dismissible', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
          _MiniSlider(
            label: 'Opacity',
            value: _opacity,
            min: 0.2,
            max: 0.9,
            onChanged: (v) => setState(() => _opacity = v),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: _ToneBackdrop(tone: widget.tone, label: '${widget.title} surface')),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton.tonal(
                          onPressed: () {
                            setState(() => _backgroundTap += 1);
                            widget.onEvent('${widget.title}: background left tapped');
                          },
                          child: const Text('Left action'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton.tonal(
                          onPressed: () {
                            setState(() => _backgroundTap += 1);
                            widget.onEvent('${widget.title}: background right tapped');
                          },
                          child: const Text('Right action'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_barrierVisible)
                  Positioned.fill(
                    child: ModalBarrier(
                      color: widget.tone.withValues(alpha: _opacity),
                      dismissible: _dismissible,
                      semanticsLabel: '${widget.title} dismiss barrier',
                      onDismiss: _dismissible
                          ? () {
                              setState(() {
                                _dismissTap += 1;
                                _barrierVisible = false;
                              });
                              widget.onEvent('${widget.title}: barrier dismissed by tap');
                            }
                          : null,
                    ),
                  ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
                    ),
                    child: Text(
                      'under taps: $_backgroundTap | dismiss taps: $_dismissTap',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                    ),
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

class _WorkflowStageScene extends StatefulWidget {
  const _WorkflowStageScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_WorkflowStageScene> createState() => _WorkflowStageSceneState();
}

class _WorkflowStageSceneState extends State<_WorkflowStageScene> {
  bool _barrierVisible = false;
  bool _dismissible = false;
  int _step = 0;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 960.0 : 1140.0;
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
                      const Text('Workflow gate controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _barrierVisible,
                        onChanged: (v) => setState(() => _barrierVisible = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable workflow barrier'),
                      ),
                      SwitchListTile(
                        value: _dismissible,
                        onChanged: (v) => setState(() => _dismissible = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Allow tap dismiss'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _step = (_step + 1).clamp(0, 3));
                              _push('moved to step $_step');
                            },
                            child: const Text('Next step'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() => _step = (_step - 1).clamp(0, 3));
                              _push('moved to step $_step');
                            },
                            child: const Text('Previous step'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() {
                                _step = 0;
                                _barrierVisible = false;
                              });
                              _push('workflow reset');
                            },
                            child: const Text('Reset flow'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('workflow step', '$_step / 3'),
                          _DataRowItem('barrier visible', _barrierVisible ? 'yes' : 'no'),
                          _DataRowItem('dismissible', _dismissible ? 'true' : 'false'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'Workflow gates are common when an operation must not be interrupted between critical steps.',
                            'Use a clear status card above the barrier to explain why interaction is currently blocked.',
                            'Non-dismissible barriers are safer for data integrity; dismissible barriers are better for optional confirmations.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Workflow event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 210, child: _LogCard(lines: _events)),
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
                    Positioned.fill(child: _ToneBackdrop(tone: _amber, label: 'Workflow board')),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _WorkflowTile(
                                    tone: _blue,
                                    title: 'Prepare input',
                                    active: _step == 0,
                                    onPressed: () => _push('Prepare input tapped'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _WorkflowTile(
                                    tone: _teal,
                                    title: 'Validate config',
                                    active: _step == 1,
                                    onPressed: () => _push('Validate config tapped'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _WorkflowTile(
                                    tone: _rose,
                                    title: 'Apply lock',
                                    active: _step == 2,
                                    onPressed: () => _push('Apply lock tapped'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _WorkflowTile(
                                    tone: _violet,
                                    title: 'Commit result',
                                    active: _step == 3,
                                    onPressed: () => _push('Commit result tapped'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_barrierVisible)
                      Positioned.fill(
                        child: ModalBarrier(
                          color: _amber.withValues(alpha: 0.62),
                          dismissible: _dismissible,
                          semanticsLabel: 'Workflow lock barrier',
                          onDismiss: _dismissible
                              ? () {
                                  setState(() => _barrierVisible = false);
                                  _push('workflow barrier dismissed by tap');
                                }
                              : null,
                        ),
                      ),
                    if (_barrierVisible)
                      Center(
                        child: Container(
                          width: 370,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: _amber.withValues(alpha: 0.42), width: 2),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Workflow Gate Active', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: _amber)),
                              const SizedBox(height: 6),
                              Text('Current step: $_step. Background actions are blocked until flow rules are satisfied.'),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton.tonal(
                                      onPressed: () {
                                        setState(() {
                                          if (_step < 3) {
                                            _step += 1;
                                          } else {
                                            _barrierVisible = false;
                                          }
                                        });
                                        _push('gate progression button tapped');
                                      },
                                      child: Text(_step < 3 ? 'Advance step' : 'Finish'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: FilledButton.tonal(
                                      onPressed: _dismissible
                                          ? () {
                                              setState(() => _barrierVisible = false);
                                              _push('gate cancelled from card');
                                            }
                                          : null,
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
      _trim(_events, 44);
    });
  }
}

class _WorkflowTile extends StatelessWidget {
  const _WorkflowTile({required this.tone, required this.title, required this.active, required this.onPressed});

  final Color tone;
  final String title;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: active ? tone.withValues(alpha: 0.20) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: active ? 0.8 : 0.32), width: active ? 2 : 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Tap to emit a workflow event; barrier state controls whether this can be reached.'),
          const Spacer(),
          FilledButton.tonal(onPressed: onPressed, child: const Text('Trigger tile action')),
        ],
      ),
    );
  }
}

class _MatrixScene extends StatefulWidget {
  const _MatrixScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_MatrixScene> createState() => _MatrixSceneState();
}

class _MatrixSceneState extends State<_MatrixScene> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Matrix guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text(
                      'Each matrix card has independent barrier controls. This helps compare tones, opacity, and dismiss behavior in one view.',
                      style: TextStyle(height: 1.35),
                    ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _rose,
                        lines: const [
                          'Barrier color should align with context severity or modality level.',
                          'High opacity can reinforce strict modal state, but use carefully to preserve readability of top-level cards.',
                          'In dashboards, consider lane-specific barriers so users can continue work outside the locked lane.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Matrix event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.05,
                  children: [
                    _MatrixCell(
                      tone: _blue,
                      title: 'Blue Lane',
                      defaultDismissible: true,
                      defaultOpacity: 0.52,
                      onEvent: (e) => _push(e),
                    ),
                    _MatrixCell(
                      tone: _teal,
                      title: 'Teal Lane',
                      defaultDismissible: false,
                      defaultOpacity: 0.58,
                      onEvent: (e) => _push(e),
                    ),
                    _MatrixCell(
                      tone: _amber,
                      title: 'Amber Lane',
                      defaultDismissible: true,
                      defaultOpacity: 0.46,
                      onEvent: (e) => _push(e),
                    ),
                    _MatrixCell(
                      tone: _violet,
                      title: 'Violet Lane',
                      defaultDismissible: false,
                      defaultOpacity: 0.62,
                      onEvent: (e) => _push(e),
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

class _MatrixCell extends StatefulWidget {
  const _MatrixCell({
    required this.tone,
    required this.title,
    required this.defaultDismissible,
    required this.defaultOpacity,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final bool defaultDismissible;
  final double defaultOpacity;
  final ValueChanged<String> onEvent;

  @override
  State<_MatrixCell> createState() => _MatrixCellState();
}

class _MatrixCellState extends State<_MatrixCell> {
  bool _showBarrier = false;
  late bool _dismissible;
  late double _opacity;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _dismissible = widget.defaultDismissible;
    _opacity = widget.defaultOpacity;
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
      child: Stack(
        children: [
          Positioned.fill(child: _ToneBackdrop(tone: widget.tone, label: widget.title)),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
                    _ToneChip(tone: widget.tone, label: _dismissible ? 'dismiss' : 'strict'),
                  ],
                ),
                const SizedBox(height: 6),
                SwitchListTile(
                  value: _showBarrier,
                  onChanged: (v) {
                    setState(() => _showBarrier = v);
                    widget.onEvent('${widget.title}: barrier visible=$v');
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Barrier', style: TextStyle(fontSize: 12)),
                ),
                SwitchListTile(
                  value: _dismissible,
                  onChanged: (v) {
                    setState(() => _dismissible = v);
                    widget.onEvent('${widget.title}: dismissible=$v');
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dismissible', style: TextStyle(fontSize: 12)),
                ),
                _MiniSlider(
                  label: 'Opacity',
                  value: _opacity,
                  min: 0.2,
                  max: 0.9,
                  onChanged: (v) => setState(() => _opacity = v),
                ),
                const SizedBox(height: 6),
                FilledButton.tonal(
                  onPressed: () {
                    setState(() => _tapCount += 1);
                    widget.onEvent('${widget.title}: background action tapped');
                  },
                  child: const Text('Background action'),
                ),
                const SizedBox(height: 4),
                Text('background taps: $_tapCount', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
              ],
            ),
          ),
          if (_showBarrier)
            Positioned.fill(
              child: ModalBarrier(
                color: widget.tone.withValues(alpha: _opacity),
                dismissible: _dismissible,
                semanticsLabel: '${widget.title} barrier',
                onDismiss: _dismissible
                    ? () {
                        setState(() => _showBarrier = false);
                        widget.onEvent('${widget.title}: barrier dismissed by tap');
                      }
                    : null,
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
  final List<String> _events = <String>[];
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1160.0 : 1360.0;
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
                              _trim(_events, 60);
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
                              title: 'Queue Orchestrator',
                              subtitle: 'Lock queue commands while synchronization runs.',
                              revision: _revision,
                              onEvent: (e) => _push('queue: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _teal,
                              title: 'Bridge Diagnostics',
                              subtitle: 'Prevent state mutation during bridge verification.',
                              revision: _revision,
                              onEvent: (e) => _push('bridge: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _violet,
                              title: 'Release Controller',
                              subtitle: 'Guard release actions until policy checks complete.',
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
                          'Use ModalBarrier for short-lived safety locks while critical operations run.',
                          'Always provide visible context above the barrier so users understand what is happening.',
                          'Choose dismissibility based on risk: high-risk operations usually require strict non-dismissible mode.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _DataTableCard(
                      rows: [
                        _DataRowItem('module revision', '$_revision'),
                        _DataRowItem('events tracked', '${_events.length}'),
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
      _trim(_events, 60);
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
  bool _barrier = false;
  bool _dismissible = false;
  double _opacity = 0.58;
  int _actionCount = 0;
  int _dismissCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: _ToneBackdrop(tone: widget.tone, label: widget.title)),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
                    _ToneChip(tone: widget.tone, label: _dismissible ? 'dismissible' : 'strict'),
                  ],
                ),
                const SizedBox(height: 3),
                Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                SwitchListTile(
                  value: _barrier,
                  onChanged: (v) {
                    setState(() => _barrier = v);
                    widget.onEvent('${widget.title}: barrier=$v');
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Barrier enabled', style: TextStyle(fontSize: 12)),
                ),
                SwitchListTile(
                  value: _dismissible,
                  onChanged: (v) {
                    setState(() => _dismissible = v);
                    widget.onEvent('${widget.title}: dismissible=$v');
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Allow dismiss tap', style: TextStyle(fontSize: 12)),
                ),
                _MiniSlider(
                  label: 'Opacity',
                  value: _opacity,
                  min: 0.2,
                  max: 0.9,
                  onChanged: (v) => setState(() => _opacity = v),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonal(
                        onPressed: () {
                          setState(() => _actionCount += 1);
                          widget.onEvent('${widget.title}: primary action');
                        },
                        child: const Text('Primary'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.tonal(
                        onPressed: () {
                          setState(() => _actionCount += 1);
                          widget.onEvent('${widget.title}: secondary action');
                        },
                        child: const Text('Secondary'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.tone.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'rev ${widget.revision} | actions $_actionCount | dismisses $_dismissCount',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          if (_barrier)
            Positioned.fill(
              child: ModalBarrier(
                color: widget.tone.withValues(alpha: _opacity),
                dismissible: _dismissible,
                semanticsLabel: '${widget.title} lock barrier',
                onDismiss: _dismissible
                    ? () {
                        setState(() {
                          _dismissCount += 1;
                          _barrier = false;
                        });
                        widget.onEvent('${widget.title}: barrier dismissed by tap');
                      }
                    : null,
              ),
            ),
          if (_barrier)
            Center(
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: widget.tone.withValues(alpha: 0.42), width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Safety Lock Active', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    const Text('Module commands are paused while this lock is active.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () {
                        setState(() => _barrier = false);
                        widget.onEvent('${widget.title}: lock released from card');
                      },
                      child: const Text('Release lock'),
                    ),
                  ],
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

class _ToneBackdrop extends StatelessWidget {
  const _ToneBackdrop({required this.tone, required this.label});

  final Color tone;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tone.withValues(alpha: 0.14), Colors.white, tone.withValues(alpha: 0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
        ),
      ),
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
                    SizedBox(width: 138, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
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

class _MiniSlider extends StatelessWidget {
  const _MiniSlider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 72, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
      ],
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
          Text('Recap: ModalBarrier', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'ModalBarrier is a foundational tool for modal interaction discipline in Flutter. '
            'It blocks background actions, supports configurable dismiss behavior, and helps enforce clear, safe workflow boundaries in complex interfaces.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

void _trim(List<String> data, int limit) {
  if (data.length > limit) {
    data.removeRange(limit, data.length);
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
