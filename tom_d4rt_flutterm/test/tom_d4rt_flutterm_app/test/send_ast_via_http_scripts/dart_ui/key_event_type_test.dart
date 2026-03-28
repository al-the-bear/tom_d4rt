// D4rt test script: Deep demo for KeyEventType from dart:ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _KeyEventTypeDeepDemoPage(),
  );
}

class _KeyEventTypeDeepDemoPage extends StatefulWidget {
  const _KeyEventTypeDeepDemoPage();

  @override
  State<_KeyEventTypeDeepDemoPage> createState() => _KeyEventTypeDeepDemoPageState();
}

class _KeyEventTypeDeepDemoPageState extends State<_KeyEventTypeDeepDemoPage>
    with SingleTickerProviderStateMixin {
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _notes = <String>[];
  final List<_PhaseEntry> _entries = <_PhaseEntry>[];

  ui.KeyEventType _selectedPhase = ui.KeyEventType.down;
  bool _synthesized = false;
  bool _showGrid = true;
  bool _showHex = true;
  bool _animateFlow = true;
  bool _lockPhysical = false;
  bool _lockLogical = false;
  double _pressDepth = 0.18;
  double _repeatRate = 9;
  double _holdTime = 420;
  double _physicalSeed = 34;
  double _logicalSeed = 88;
  int _themeIndex = 0;

  late final AnimationController _anim;

  final List<List<Color>> _themes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF3F1D38), const Color(0xFF7B2D5E), const Color(0xFFFB7185)],
    <Color>[const Color(0xFF0C4A6E), const Color(0xFF0369A1), const Color(0xFF22D3EE)],
  ];

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _emit('KeyEventType phase lab initialized.');
    _runProbes();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _emit(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _notes.insert(0, '[$stamp] $message');
    if (_notes.length > 40) {
      _notes.removeLast();
    }
  }

  String _phaseName(ui.KeyEventType t) {
    if (t == ui.KeyEventType.down) {
      return 'Down';
    }
    if (t == ui.KeyEventType.up) {
      return 'Up';
    }
    return 'Repeat';
  }

  Color _phaseColor(ui.KeyEventType t) {
    if (t == ui.KeyEventType.down) {
      return const Color(0xFF16A34A);
    }
    if (t == ui.KeyEventType.up) {
      return const Color(0xFFEA580C);
    }
    return const Color(0xFF2563EB);
  }

  int _physicalCode() {
    if (_lockPhysical) {
      return 0x70004;
    }
    return 40 + _physicalSeed.round();
  }

  int _logicalCode() {
    if (_lockLogical) {
      return 0x61;
    }
    return 90 + _logicalSeed.round();
  }

  String _fmt(int value) {
    if (_showHex) {
      return '0x${value.toRadixString(16).toUpperCase()}';
    }
    return value.toString();
  }

  String? _characterFor(ui.KeyEventType type) {
    if (type == ui.KeyEventType.up) {
      return null;
    }
    final int idx = (_logicalCode() % 26);
    return String.fromCharCode(97 + idx);
  }

  ui.KeyData _sampleKeyData(ui.KeyEventType type) {
    return ui.KeyData(
      timeStamp: Duration(milliseconds: _holdTime.round()),
      type: type,
      physical: _physicalCode(),
      logical: _logicalCode(),
      character: _characterFor(type),
      synthesized: _synthesized,
      deviceType: ui.KeyEventDeviceType.keyboard,
    );
  }

  void _append(ui.KeyEventType type) {
    final _PhaseEntry entry = _PhaseEntry(
      type: type,
      pressDepth: _pressDepth,
      repeatRate: _repeatRate,
      holdMs: _holdTime,
      physical: _physicalCode(),
      logical: _logicalCode(),
      character: _characterFor(type),
      synthesized: _synthesized,
    );
    _entries.insert(0, entry);
    if (_entries.length > 28) {
      _entries.removeLast();
    }
    _emit('Appended ${_phaseName(type)} event: phys ${_fmt(entry.physical)}, log ${_fmt(entry.logical)}.');
    setState(() {});
  }

  void _simulatePressCycle() {
    _append(ui.KeyEventType.down);
    final int repeats = (_repeatRate / 4).round().clamp(1, 6);
    for (int i = 0; i < repeats; i++) {
      _append(ui.KeyEventType.repeat);
    }
    _append(ui.KeyEventType.up);
    _emit('Synthetic press cycle generated (${repeats + 2} events).');
  }

  void _runProbes() {
    _passed.clear();
    _failed.clear();

    void probe(String name, bool value) {
      if (value) {
        _passed.add(name);
      } else {
        _failed.add(name);
      }
    }

    probe('values contains three phases', ui.KeyEventType.values.length == 3);
    probe('down index is 0', ui.KeyEventType.down.index == 0);
    probe('up index is 1', ui.KeyEventType.up.index == 1);
    probe('repeat index is 2', ui.KeyEventType.repeat.index == 2);
    probe('down and up are distinct', ui.KeyEventType.down != ui.KeyEventType.up);
    probe('repeat differs from down', ui.KeyEventType.repeat != ui.KeyEventType.down);
    probe('down label is Key Down', ui.KeyEventType.down.label == 'Key Down');
    probe('up label is Key Up', ui.KeyEventType.up.label == 'Key Up');
    probe('repeat label is Key Repeat', ui.KeyEventType.repeat.label == 'Key Repeat');
    probe('toString preserves enum token', ui.KeyEventType.repeat.toString().contains('repeat'));

    final ui.KeyData repeatData = _sampleKeyData(ui.KeyEventType.repeat);
    probe('KeyData can carry repeat phase', repeatData.type == ui.KeyEventType.repeat);
    probe('summary text can be generated', '${_passed.length + _failed.length} checks'.endsWith('checks'));

    setState(() {});
  }

  Widget _header() {
    final List<Color> colors = _themes[_themeIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: colors[1].withAlpha(94), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'KeyEventType Phase Laboratory',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'KeyEventType describes event phase transitions (down, repeat, up). '
            'This deep demo visualizes phase sequencing, repeat cadence behavior, '
            'and how phase values influence interpretation of key data in runtimes.',
            style: TextStyle(color: Colors.white, fontSize: 13.1, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withAlpha(22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withAlpha(90)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withAlpha(34),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _conceptCards() {
    Widget card(String title, String body, IconData icon, Color color) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withAlpha(90)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(body, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card('Down', 'Starts a key press lifecycle and indicates actuation.', Icons.arrow_downward,
              const Color(0xFF16A34A)),
          card('Repeat', 'Represents auto-repeat while key remains held.', Icons.repeat,
              const Color(0xFF2563EB)),
          card('Up', 'Signals release and closes the interaction cycle.', Icons.arrow_upward,
              const Color(0xFFEA580C)),
          card('Sequencing', 'Phase ordering drives input state machines.', Icons.timeline,
              const Color(0xFF7C3AED)),
        ],
      ),
    );
  }

  Widget _phaseSelector() {
    Widget chip(ui.KeyEventType t) {
      final bool selected = _selectedPhase == t;
      final Color color = _phaseColor(t);
      return ChoiceChip(
        selected: selected,
        label: Text(_phaseName(t)),
        selectedColor: color.withAlpha(70),
        onSelected: (_) {
          setState(() {
            _selectedPhase = t;
          });
          _emit('Selected phase changed to ${_phaseName(t)}.');
        },
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Phase controls and signal parameters', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: <Widget>[chip(ui.KeyEventType.down), chip(ui.KeyEventType.repeat), chip(ui.KeyEventType.up)]),
          const SizedBox(height: 8),
          Text('Press depth: ${_pressDepth.toStringAsFixed(2)}'),
          Slider(
            value: _pressDepth,
            min: 0,
            max: 1,
            divisions: 100,
            onChanged: (double v) => setState(() => _pressDepth = v),
          ),
          Text('Repeat rate: ${_repeatRate.toStringAsFixed(1)} Hz'),
          Slider(
            value: _repeatRate,
            min: 0,
            max: 30,
            divisions: 60,
            onChanged: (double v) => setState(() => _repeatRate = v),
          ),
          Text('Hold time: ${_holdTime.round()} ms'),
          Slider(
            value: _holdTime,
            min: 0,
            max: 1500,
            divisions: 150,
            onChanged: (double v) => setState(() => _holdTime = v),
          ),
          Text('Physical seed: ${_physicalSeed.round()}'),
          Slider(
            value: _physicalSeed,
            min: 0,
            max: 220,
            divisions: 220,
            onChanged: (double v) => setState(() => _physicalSeed = v),
          ),
          Text('Logical seed: ${_logicalSeed.round()}'),
          Slider(
            value: _logicalSeed,
            min: 0,
            max: 260,
            divisions: 260,
            onChanged: (double v) => setState(() => _logicalSeed = v),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(
                label: const Text('synthesized'),
                selected: _synthesized,
                onSelected: (bool v) => setState(() => _synthesized = v),
              ),
              FilterChip(
                label: const Text('show grid'),
                selected: _showGrid,
                onSelected: (bool v) => setState(() => _showGrid = v),
              ),
              FilterChip(
                label: const Text('show hex'),
                selected: _showHex,
                onSelected: (bool v) => setState(() => _showHex = v),
              ),
              FilterChip(
                label: const Text('animate flow'),
                selected: _animateFlow,
                onSelected: (bool v) {
                  setState(() => _animateFlow = v);
                  if (_animateFlow) {
                    _anim.repeat();
                  } else {
                    _anim.stop();
                  }
                },
              ),
              FilterChip(
                label: const Text('lock physical'),
                selected: _lockPhysical,
                onSelected: (bool v) => setState(() => _lockPhysical = v),
              ),
              FilterChip(
                label: const Text('lock logical'),
                selected: _lockLogical,
                onSelected: (bool v) => setState(() => _lockLogical = v),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => _append(_selectedPhase),
                icon: const Icon(Icons.add),
                label: const Text('Append Selected Phase'),
              ),
              OutlinedButton.icon(
                onPressed: _simulatePressCycle,
                icon: const Icon(Icons.play_arrow_outlined),
                label: const Text('Simulate Press Cycle'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _entries.clear();
                  _emit('Entry timeline cleared.');
                  setState(() {});
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Timeline'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _runProbes();
                  _emit('Probe suite executed.');
                },
                icon: const Icon(Icons.fact_check_outlined),
                label: const Text('Run Probes'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _themeIndex = (_themeIndex + 1) % _themes.length;
                  });
                },
                icon: const Icon(Icons.palette_outlined),
                label: const Text('Theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _phaseLanesPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Three-lane phase timeline', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 220,
            child: AnimatedBuilder(
              animation: _anim,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _PhaseLanePainter(
                    entries: _entries,
                    pulse: _animateFlow ? _anim.value : 0,
                    showGrid: _showGrid,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Green lane: down events, blue lane: repeat events, orange lane: up events. '
            'Phase clustering reveals hold/repeat behavior patterns.',
            style: TextStyle(fontSize: 12.1),
          ),
        ],
      ),
    );
  }

  Widget _repeatCadencePanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Repeat cadence analyzer', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 170,
            child: CustomPaint(
              painter: _CadencePainter(
                repeatRate: _repeatRate,
                holdMs: _holdTime,
                pulse: _animateFlow ? _anim.value : 0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Estimated repeat count for current hold time: ${(_repeatRate * (_holdTime / 1000)).round()}',
            style: const TextStyle(fontSize: 12.2),
          ),
        ],
      ),
    );
  }

  Widget _keyDataIntegrationPanel() {
    final ui.KeyData sample = _sampleKeyData(_selectedPhase);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('KeyData coupling by phase', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _kv('type', _phaseName(sample.type)),
              _kv('timeStamp', '${sample.timeStamp.inMilliseconds} ms'),
              _kv('physical', _fmt(sample.physical)),
              _kv('logical', _fmt(sample.logical)),
              _kv('character', sample.character ?? 'null'),
              _kv('synthesized', sample.synthesized ? 'true' : 'false'),
              _kv('deviceType', sample.deviceType.label),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Same key may produce different phase values across its lifecycle. '
            'Phase is essential for deriving transitions such as key start, hold-repeat, and release.',
            style: TextStyle(fontSize: 12.1),
          ),
        ],
      ),
    );
  }

  Widget _kv(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$key: $value', style: const TextStyle(fontSize: 12.1)),
    );
  }

  Widget _timelineListPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Phase event stream', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 220,
            child: _entries.isEmpty
                ? const Center(
                    child: Text(
                      'No phase entries yet. Append a phase or run a press cycle.',
                      style: TextStyle(fontSize: 12.3, color: Color(0xFF64748B)),
                    ),
                  )
                : ListView.builder(
                    itemCount: _entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _PhaseEntry e = _entries[index];
                      final Color color = _phaseColor(e.type);
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: color.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: color.withAlpha(95)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                              child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${_phaseName(e.type)} | depth ${e.pressDepth.toStringAsFixed(2)} | '
                                'repeat ${e.repeatRate.toStringAsFixed(1)}Hz | hold ${e.holdMs.round()}ms | '
                                'phys ${_fmt(e.physical)} | log ${_fmt(e.logical)} | char ${e.character ?? 'null'} | '
                                'syn ${e.synthesized}',
                                style: const TextStyle(fontSize: 12.1),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _phaseGuidancePanel() {
    final List<_GuideRow> rows = <_GuideRow>[
      _GuideRow('Down', 'Start actions, set key-active state', 'On first press edge', 'Debounce initial edge'),
      _GuideRow('Repeat', 'Continuous movement or text repeat', 'While key remains held', 'Throttle high rates'),
      _GuideRow('Up', 'Finalize actions and clear state', 'On release edge', 'Ensure cleanup paths'),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Phase usage matrix', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: const Color(0xFFE2E8F0)),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(0.9),
              1: FlexColumnWidth(1.4),
              2: FlexColumnWidth(1.1),
              3: FlexColumnWidth(1.1),
            },
            children: <TableRow>[
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFFF1F5F9)),
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8), child: Text('Phase', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Primary meaning', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Typical moment', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Implementation hint', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                ],
              ),
              ...rows.map((row) => row.toRow()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _probePanel() {
    Widget line(String text, bool ok) {
      final Color color = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(96)),
        ),
        child: Row(
          children: <Widget>[
            Icon(ok ? Icons.check_circle : Icons.cancel, color: color, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 12.2))),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Runtime probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_passed.length}, Failed: ${_failed.length}'),
          const SizedBox(height: 8),
          ..._passed.map((String s) => line(s, true)),
          ..._failed.map((String s) => line(s, false)),
        ],
      ),
    );
  }

  Widget _notesPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Interaction notes', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(_notes[index], style: const TextStyle(fontSize: 12)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: const Text(
        'KeyEventType summary: use down for initial activation, repeat for sustained actions, '
        'and up for release cleanup. Pair phase semantics with key identity fields to build '
        'robust input state machines for interpreter-driven Flutter runtime scenarios.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - KeyEventType'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _section(
            '1) Concept orientation',
            'Understand lifecycle semantics for down, repeat, and up phases.',
            Icons.menu_book,
            const Color(0xFF2563EB),
          ),
          _conceptCards(),
          _section(
            '2) Phase interaction lab',
            'Tune signal parameters and generate phase sequences.',
            Icons.tune,
            const Color(0xFF7C3AED),
          ),
          _phaseSelector(),
          _section(
            '3) Lifecycle timeline lanes',
            'Visualize phase distribution across a rolling stream.',
            Icons.timeline,
            const Color(0xFF0F766E),
          ),
          _phaseLanesPanel(),
          _section(
            '4) Repeat cadence analysis',
            'Inspect repeat frequency and hold-time interaction.',
            Icons.multiline_chart,
            const Color(0xFF0EA5E9),
          ),
          _repeatCadencePanel(),
          _section(
            '5) KeyData integration',
            'Observe phase impact in KeyData snapshots.',
            Icons.data_object,
            const Color(0xFFB45309),
          ),
          _keyDataIntegrationPanel(),
          _section(
            '6) Event stream',
            'Read chronological phase entries and event metadata.',
            Icons.list_alt,
            const Color(0xFFBE123C),
          ),
          _timelineListPanel(),
          _section(
            '7) Phase usage matrix',
            'Implementation-oriented guidance for each phase.',
            Icons.table_chart,
            const Color(0xFF334155),
          ),
          _phaseGuidancePanel(),
          _section(
            '8) Probe checks',
            'Validate enum stability and phase semantics in runtime.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _probePanel(),
          _section(
            '9) Notes and summary',
            'Operational trace and final practical recommendations.',
            Icons.notes,
            const Color(0xFF475569),
          ),
          _notesPanel(),
          _summaryPanel(),
        ],
      ),
    );
  }
}

class _PhaseEntry {
  const _PhaseEntry({
    required this.type,
    required this.pressDepth,
    required this.repeatRate,
    required this.holdMs,
    required this.physical,
    required this.logical,
    required this.character,
    required this.synthesized,
  });

  final ui.KeyEventType type;
  final double pressDepth;
  final double repeatRate;
  final double holdMs;
  final int physical;
  final int logical;
  final String? character;
  final bool synthesized;
}

class _GuideRow {
  const _GuideRow(this.phase, this.primary, this.moment, this.hint);

  final String phase;
  final String primary;
  final String moment;
  final String hint;

  TableRow toRow() {
    Widget cell(String text) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(text, style: const TextStyle(fontSize: 12)),
      );
    }

    return TableRow(
      children: <Widget>[
        cell(phase),
        cell(primary),
        cell(moment),
        cell(hint),
      ],
    );
  }
}

class _PhaseLanePainter extends CustomPainter {
  const _PhaseLanePainter({
    required this.entries,
    required this.pulse,
    required this.showGrid,
  });

  final List<_PhaseEntry> entries;
  final double pulse;
  final bool showGrid;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(26);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)), bg);

    if (showGrid) {
      final Paint gp = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double step = 18;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
      }
    }

    final double laneTop = size.height * 0.22;
    final double laneMid = size.height * 0.5;
    final double laneBottom = size.height * 0.78;

    final Paint lane = Paint()
      ..color = const Color(0xFF64748B)
      ..strokeWidth = 1.8;
    canvas.drawLine(Offset(10, laneTop), Offset(size.width - 10, laneTop), lane);
    canvas.drawLine(Offset(10, laneMid), Offset(size.width - 10, laneMid), lane);
    canvas.drawLine(Offset(10, laneBottom), Offset(size.width - 10, laneBottom), lane);

    void label(String text, double y) {
      final TextPainter tp = TextPainter(
        text: TextSpan(text: text, style: const TextStyle(fontSize: 10.5, color: Color(0xFF0F172A))),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(10, y - 18));
    }

    label('Down', laneTop);
    label('Repeat', laneMid);
    label('Up', laneBottom);

    final int count = entries.length > 24 ? 24 : entries.length;
    for (int i = 0; i < count; i++) {
      final _PhaseEntry e = entries[i];
      final double x = size.width - 14 - i * ((size.width - 30) / 24);
      double y;
      Color color;
      if (e.type == ui.KeyEventType.down) {
        y = laneTop;
        color = const Color(0xFF16A34A);
      } else if (e.type == ui.KeyEventType.repeat) {
        y = laneMid;
        color = const Color(0xFF2563EB);
      } else {
        y = laneBottom;
        color = const Color(0xFFEA580C);
      }
      canvas.drawCircle(Offset(x, y), 5 + e.pressDepth * 3, Paint()..color = color);
    }

    final Offset p = Offset(14 + pulse * (size.width - 28), laneMid);
    canvas.drawCircle(p, 5, Paint()..color = const Color(0xFF0EA5E9));
  }

  @override
  bool shouldRepaint(covariant _PhaseLanePainter oldDelegate) {
    return oldDelegate.entries != entries || oldDelegate.pulse != pulse || oldDelegate.showGrid != showGrid;
  }
}

class _CadencePainter extends CustomPainter {
  const _CadencePainter({
    required this.repeatRate,
    required this.holdMs,
    required this.pulse,
  });

  final double repeatRate;
  final double holdMs;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(18);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)), bg);

    final Paint axis = Paint()
      ..color = const Color(0xFF64748B)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(20, size.height - 24), Offset(size.width - 12, size.height - 24), axis);
    canvas.drawLine(Offset(20, size.height - 24), const Offset(20, 12), axis);

    final int samples = 24;
    final double span = size.width - 44;
    final double repeats = repeatRate * (holdMs / 1000);
    for (int i = 0; i <= samples; i++) {
      final double x = 22 + i * (span / samples);
      final double t = i / samples;
      final double y = (size.height - 26) - (t * repeats / 30).clamp(0, 1) * (size.height - 48);
      canvas.drawCircle(Offset(x, y), 2.4, Paint()..color = const Color(0xFF2563EB));
      if (i > 0) {
        final double px = 22 + (i - 1) * (span / samples);
        final double pt = (i - 1) / samples;
        final double py = (size.height - 26) - (pt * repeats / 30).clamp(0, 1) * (size.height - 48);
        canvas.drawLine(Offset(px, py), Offset(x, y), Paint()..color = const Color(0xFF2563EB));
      }
    }

    final Offset pulseDot = Offset(22 + span * pulse, size.height - 24 - (size.height - 50) * (pulse * repeats / 30).clamp(0, 1));
    canvas.drawCircle(pulseDot, 5, Paint()..color = const Color(0xFF22D3EE));

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'repeatRate ${repeatRate.toStringAsFixed(1)}Hz, hold ${holdMs.round()}ms',
        style: const TextStyle(fontSize: 11.5, color: Color(0xFF0F172A)),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    tp.paint(canvas, const Offset(8, 6));
  }

  @override
  bool shouldRepaint(covariant _CadencePainter oldDelegate) {
    return oldDelegate.repeatRate != repeatRate || oldDelegate.holdMs != holdMs || oldDelegate.pulse != pulse;
  }
}
