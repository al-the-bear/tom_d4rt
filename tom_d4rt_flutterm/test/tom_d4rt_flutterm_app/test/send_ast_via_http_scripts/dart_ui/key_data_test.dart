// D4rt test script: Deep demo for KeyData from dart:ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _KeyDataDeepDemoPage(),
  );
}

class _KeyDataDeepDemoPage extends StatefulWidget {
  const _KeyDataDeepDemoPage();

  @override
  State<_KeyDataDeepDemoPage> createState() => _KeyDataDeepDemoPageState();
}

class _KeyDataDeepDemoPageState extends State<_KeyDataDeepDemoPage>
    with SingleTickerProviderStateMixin {
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<ui.KeyData> _timeline = <ui.KeyData>[];
  final List<String> _notes = <String>[];

  ui.KeyEventType _type = ui.KeyEventType.down;
  ui.KeyEventDeviceType _deviceType = ui.KeyEventDeviceType.keyboard;
  bool _synthesized = false;
  bool _showHex = true;
  bool _animatePulse = true;
  bool _showGrid = true;

  double _timeMs = 140;
  double _physical = 0x04;
  double _logical = 0x61;
  String _character = 'a';
  int _palette = 0;

  late final AnimationController _pulse;

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0B132B), const Color(0xFF1C2541), const Color(0xFF5BC0BE)],
    <Color>[const Color(0xFF3F1D38), const Color(0xFF7B2D5E), const Color(0xFFF25F5C)],
    <Color>[const Color(0xFF0A4D3C), const Color(0xFF116149), const Color(0xFF42D392)],
  ];

  final List<_KeyPreset> _presets = const <_KeyPreset>[
    _KeyPreset(label: 'A Key', physical: 0x04, logical: 0x61, character: 'a'),
    _KeyPreset(label: 'Enter', physical: 0x28, logical: 0x0D, character: '\n'),
    _KeyPreset(label: 'Space', physical: 0x2C, logical: 0x20, character: ' '),
    _KeyPreset(label: 'Arrow Left', physical: 0x50, logical: 0x100000304, character: ''),
    _KeyPreset(label: 'Gamepad A', physical: 0x130, logical: 0x100002000, character: ''),
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    )..repeat();
    _runProbes();
    _emitEvent('Demo initialized with keyboard A key profile.');
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _emitEvent(String text) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _notes.insert(0, '[$stamp] $text');
    if (_notes.length > 30) {
      _notes.removeLast();
    }
  }

  ui.KeyData _currentKeyData() {
    return ui.KeyData(
      timeStamp: Duration(milliseconds: _timeMs.round()),
      type: _type,
      physical: _physical.round(),
      logical: _logical.round(),
      character: _character.isEmpty ? null : _character,
      synthesized: _synthesized,
      deviceType: _deviceType,
    );
  }

  String _formatCode(int value) {
    if (_showHex) {
      return '0x${value.toRadixString(16).toUpperCase()}';
    }
    return value.toString();
  }

  String _typeText(ui.KeyEventType type) {
    if (type == ui.KeyEventType.down) {
      return 'Down';
    }
    if (type == ui.KeyEventType.up) {
      return 'Up';
    }
    return 'Repeat';
  }

  String _deviceText(ui.KeyEventDeviceType d) {
    final String raw = d.toString();
    final int i = raw.lastIndexOf('.');
    return i == -1 ? raw : raw.substring(i + 1);
  }

  void _appendCurrentEvent() {
    final ui.KeyData data = _currentKeyData();
    _timeline.insert(0, data);
    if (_timeline.length > 20) {
      _timeline.removeLast();
    }
    _emitEvent(
      'Appended event ${_typeText(data.type)} ${_formatCode(data.physical)} -> ${_formatCode(data.logical)} (${_deviceText(data.deviceType)})',
    );
    setState(() {});
  }

  void _loadPreset(_KeyPreset p) {
    setState(() {
      _physical = p.physical.toDouble();
      _logical = p.logical.toDouble();
      _character = p.character;
      if (p.label.startsWith('Gamepad')) {
        _deviceType = ui.KeyEventDeviceType.gamepad;
      } else {
        _deviceType = ui.KeyEventDeviceType.keyboard;
      }
    });
    _emitEvent('Loaded preset ${p.label}.');
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

    final ui.KeyData base = _currentKeyData();
    probe('KeyData object is constructible', base.runtimeType == ui.KeyData);
    probe('timeStamp stores milliseconds', base.timeStamp == Duration(milliseconds: _timeMs.round()));
    probe('type stores selected enum', base.type == _type);
    probe('physical code stores selected value', base.physical == _physical.round());
    probe('logical code stores selected value', base.logical == _logical.round());
    probe('character can be null or single text', (_character.isEmpty && base.character == null) || base.character == _character);
    probe('synthesized flag stores selected value', base.synthesized == _synthesized);
    probe('deviceType stores selected device', base.deviceType == _deviceType);

    final ui.KeyData defaultDevice = ui.KeyData(
      timeStamp: Duration.zero,
      type: ui.KeyEventType.down,
      physical: 1,
      logical: 1,
      character: null,
      synthesized: false,
    );
    probe('deviceType default is keyboard', defaultDevice.deviceType == ui.KeyEventDeviceType.keyboard);

    final ui.KeyData gamepad = ui.KeyData(
      timeStamp: const Duration(milliseconds: 1),
      type: ui.KeyEventType.up,
      physical: 2,
      logical: 3,
      character: null,
      synthesized: true,
      deviceType: ui.KeyEventDeviceType.gamepad,
    );
    probe('custom deviceType gamepad is preserved', gamepad.deviceType == ui.KeyEventDeviceType.gamepad);
    probe('summary format can be generated', '${_passed.length + _failed.length} checks'.endsWith('checks'));

    setState(() {});
  }

  Widget _header() {
    final List<Color> c = _palettes[_palette];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: c),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: c[1].withAlpha(96), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('KeyData Input Observatory',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text(
            'KeyData captures a single hardware/software key event snapshot in dart:ui. '
            'This demo visualizes how timestamp, event type, key codes, character, '
            'synthesized origin, and device category are represented and interpreted.',
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
              color: accent.withAlpha(36),
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
                Text(subtitle, style: const TextStyle(fontSize: 12.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String title, String text, IconData icon, Color color) {
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
            Text(text, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _overviewStrip() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _pill('Data carrier', 'Represents one key event sample.', Icons.data_object,
              const Color(0xFF1D4ED8)),
          _pill('Interpreter bridge', 'Used to validate engine-event transfer.', Icons.route,
              const Color(0xFF0F766E)),
          _pill('Cross-device', 'Differentiates keyboard and gamepad sources.', Icons.sports_esports,
              const Color(0xFF7C3AED)),
          _pill('Input analysis', 'Supports debugging key code interpretation.', Icons.psychology,
              const Color(0xFFB45309)),
        ],
      ),
    );
  }

  Widget _controlsLab() {
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
          const Text('KeyData constructor lab', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presets
                .map(
                  (_KeyPreset p) => ActionChip(
                    label: Text(p.label),
                    onPressed: () => _loadPreset(p),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButton<ui.KeyEventType>(
                  isExpanded: true,
                  value: _type,
                  onChanged: (ui.KeyEventType? value) {
                    if (value != null) {
                      setState(() => _type = value);
                      _emitEvent('Event type switched to ${_typeText(value)}.');
                    }
                  },
                  items: const <DropdownMenuItem<ui.KeyEventType>>[
                    DropdownMenuItem<ui.KeyEventType>(
                      value: ui.KeyEventType.down,
                      child: Text('KeyEventType.down'),
                    ),
                    DropdownMenuItem<ui.KeyEventType>(
                      value: ui.KeyEventType.up,
                      child: Text('KeyEventType.up'),
                    ),
                    DropdownMenuItem<ui.KeyEventType>(
                      value: ui.KeyEventType.repeat,
                      child: Text('KeyEventType.repeat'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<ui.KeyEventDeviceType>(
                  isExpanded: true,
                  value: _deviceType,
                  onChanged: (ui.KeyEventDeviceType? value) {
                    if (value != null) {
                      setState(() => _deviceType = value);
                      _emitEvent('Device type switched to ${_deviceText(value)}.');
                    }
                  },
                  items: const <DropdownMenuItem<ui.KeyEventDeviceType>>[
                    DropdownMenuItem<ui.KeyEventDeviceType>(
                      value: ui.KeyEventDeviceType.keyboard,
                      child: Text('KeyEventDeviceType.keyboard'),
                    ),
                    DropdownMenuItem<ui.KeyEventDeviceType>(
                      value: ui.KeyEventDeviceType.gamepad,
                      child: Text('KeyEventDeviceType.gamepad'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('timeStamp (ms): ${_timeMs.round()}'),
          Slider(
            value: _timeMs,
            min: 0,
            max: 2000,
            divisions: 100,
            onChanged: (double value) => setState(() => _timeMs = value),
          ),
          Text('physical key code: ${_formatCode(_physical.round())}'),
          Slider(
            value: _physical,
            min: 0,
            max: 512,
            divisions: 128,
            onChanged: (double value) => setState(() => _physical = value),
          ),
          Text('logical key code: ${_formatCode(_logical.round())}'),
          Slider(
            value: _logical,
            min: 0,
            max: 0x300,
            divisions: 96,
            onChanged: (double value) => setState(() => _logical = value),
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 90,
                child: Text('character:'),
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: _character),
                  onChanged: (String value) {
                    setState(() {
                      _character = value.length > 1 ? value.substring(0, 1) : value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'single char or empty',
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(
                label: const Text('synthesized'),
                selected: _synthesized,
                onSelected: (bool value) => setState(() => _synthesized = value),
              ),
              FilterChip(
                label: const Text('show hex codes'),
                selected: _showHex,
                onSelected: (bool value) => setState(() => _showHex = value),
              ),
              FilterChip(
                label: const Text('animate pulse'),
                selected: _animatePulse,
                onSelected: (bool value) {
                  setState(() => _animatePulse = value);
                  if (_animatePulse) {
                    _pulse.repeat();
                  } else {
                    _pulse.stop();
                  }
                },
              ),
              FilterChip(
                label: const Text('grid overlay'),
                selected: _showGrid,
                onSelected: (bool value) => setState(() => _showGrid = value),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _appendCurrentEvent,
                icon: const Icon(Icons.add),
                label: const Text('Append Event'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _runProbes();
                  _emitEvent('Probe suite executed.');
                },
                icon: const Icon(Icons.fact_check_outlined),
                label: const Text('Run Probes'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _timeline.clear();
                  });
                  _emitEvent('Timeline cleared.');
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Timeline'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _palette = (_palette + 1) % _palettes.length;
                  });
                },
                icon: const Icon(Icons.palette_outlined),
                label: const Text('Palette'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _snapshotPanel() {
    final ui.KeyData d = _currentKeyData();
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
          const Text('Current KeyData snapshot', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 185,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _KeyDataPainter(
                    data: d,
                    showGrid: _showGrid,
                    pulse: _animatePulse ? _pulse.value : 0,
                    showHex: _showHex,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _kv('timeStamp', '${d.timeStamp.inMilliseconds} ms'),
              _kv('type', _typeText(d.type)),
              _kv('physical', _formatCode(d.physical)),
              _kv('logical', _formatCode(d.logical)),
              _kv('character', d.character ?? 'null'),
              _kv('synthesized', d.synthesized ? 'true' : 'false'),
              _kv('deviceType', _deviceText(d.deviceType)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text('$k: $v', style: const TextStyle(fontSize: 12.1)),
    );
  }

  Widget _mappingPanel() {
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
          const Text('Physical vs logical interpretation',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.2),
            },
            border: TableBorder.all(color: const Color(0xFFE2E8F0)),
            children: <TableRow>[
              _tableHeaderRow(),
              _mappingRow('Hardware position', _formatCode(_physical.round()), 'Keyboard matrix location',
                  'Physical stays stable across layouts'),
              _mappingRow('Semantic meaning', _formatCode(_logical.round()), 'Character intent',
                  'Logical can differ by active layout'),
              _mappingRow('Character payload', _character.isEmpty ? 'null' : _character, 'Text production',
                  'Optional for non-text control keys'),
              _mappingRow('Synthetic origin', _synthesized ? 'true' : 'false', 'Generated event',
                  'Used for framework-synthesized transitions'),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _tableHeaderRow() {
    const TextStyle h = TextStyle(fontWeight: FontWeight.w700, fontSize: 12.1);
    return const TableRow(
      decoration: BoxDecoration(color: Color(0xFFF1F5F9)),
      children: <Widget>[
        Padding(padding: EdgeInsets.all(8), child: Text('Aspect', style: h)),
        Padding(padding: EdgeInsets.all(8), child: Text('Current', style: h)),
        Padding(padding: EdgeInsets.all(8), child: Text('Meaning', style: h)),
        Padding(padding: EdgeInsets.all(8), child: Text('Guidance', style: h)),
      ],
    );
  }

  TableRow _mappingRow(String a, String b, String c, String d) {
    return TableRow(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(8), child: Text(a, style: const TextStyle(fontSize: 12))),
        Padding(padding: const EdgeInsets.all(8), child: Text(b, style: const TextStyle(fontSize: 12))),
        Padding(padding: const EdgeInsets.all(8), child: Text(c, style: const TextStyle(fontSize: 12))),
        Padding(padding: const EdgeInsets.all(8), child: Text(d, style: const TextStyle(fontSize: 12))),
      ],
    );
  }

  Widget _devicePanel() {
    final List<_DeviceCardData> cards = <_DeviceCardData>[
      _DeviceCardData(
        title: 'Keyboard',
        icon: Icons.keyboard,
        selected: _deviceType == ui.KeyEventDeviceType.keyboard,
        body: 'Best for text/navigation flows. Physical keys map to a keyboard matrix.',
        colors: const <Color>[Color(0xFF2563EB), Color(0xFF60A5FA)],
      ),
      _DeviceCardData(
        title: 'Gamepad',
        icon: Icons.sports_esports,
        selected: _deviceType == ui.KeyEventDeviceType.gamepad,
        body: 'Useful for console-style inputs where buttons map to semantic actions.',
        colors: const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)],
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: cards.map(_deviceCard).toList(),
      ),
    );
  }

  Widget _deviceCard(_DeviceCardData d) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: d.colors),
          borderRadius: BorderRadius.circular(10),
          border: d.selected ? Border.all(color: Colors.white, width: 2.3) : null,
          boxShadow: <BoxShadow>[
            BoxShadow(color: d.colors[0].withAlpha(100), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(d.icon, color: Colors.white),
            const SizedBox(height: 8),
            Text(d.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 6),
            Text(d.body, style: const TextStyle(color: Colors.white, fontSize: 12.1)),
            const SizedBox(height: 8),
            Text(
              d.selected ? 'Active profile' : 'Inactive profile',
              style: const TextStyle(color: Colors.white, fontSize: 11.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timelinePanel() {
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
          const Text('Event timeline', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 208,
            child: _timeline.isEmpty
                ? const Center(
                    child: Text(
                      'No events yet. Use "Append Event" to create a visual stream.',
                      style: TextStyle(fontSize: 12.2, color: Color(0xFF64748B)),
                    ),
                  )
                : ListView.builder(
                    itemCount: _timeline.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ui.KeyData d = _timeline[index];
                      final Color color = d.type == ui.KeyEventType.down
                          ? const Color(0xFF16A34A)
                          : d.type == ui.KeyEventType.up
                              ? const Color(0xFFEA580C)
                              : const Color(0xFF2563EB);
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: color.withAlpha(22),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: color.withAlpha(92)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${_typeText(d.type)} | phys ${_formatCode(d.physical)} | '
                                'log ${_formatCode(d.logical)} | char ${d.character ?? 'null'} | '
                                '${_deviceText(d.deviceType)} | t=${d.timeStamp.inMilliseconds}ms',
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

  Widget _probeLine(String text, bool ok) {
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

  Widget _probePanel() {
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
          ..._passed.map((String p) => _probeLine(p, true)),
          ..._failed.map((String f) => _probeLine(f, false)),
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
          const Text('Operational notes', style: TextStyle(fontWeight: FontWeight.w700)),
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
        'KeyData usage summary: use this class to inspect low-level key events by combining '
        'event phase (down/up/repeat), hardware location (physical), semantic meaning (logical), '
        'optional character text, event origin (synthesized), and device source. '
        'These dimensions are crucial for robust cross-device keyboard/gamepad interactions in interpreter-driven UI runtimes.',
        style: TextStyle(fontSize: 12.4, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - KeyData'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _section(
            '1) Concept orientation',
            'Why KeyData exists and what each field contributes.',
            Icons.menu_book,
            const Color(0xFF2563EB),
          ),
          _overviewStrip(),
          _section(
            '2) Constructor and interaction lab',
            'Build event snapshots and vary all KeyData inputs.',
            Icons.tune,
            const Color(0xFF7C3AED),
          ),
          _controlsLab(),
          _section(
            '3) Snapshot visualization',
            'Render current event fields as an explorable graphic.',
            Icons.dashboard,
            const Color(0xFF0F766E),
          ),
          _snapshotPanel(),
          _section(
            '4) Mapping guide',
            'Interpret physical vs logical identity and text output.',
            Icons.table_chart,
            const Color(0xFFB45309),
          ),
          _mappingPanel(),
          _section(
            '5) Device semantics',
            'Understand keyboard and gamepad event source context.',
            Icons.devices,
            const Color(0xFFBE123C),
          ),
          _devicePanel(),
          _section(
            '6) Event timeline',
            'Observe stream behavior as events accumulate.',
            Icons.timeline,
            const Color(0xFF0369A1),
          ),
          _timelinePanel(),
          _section(
            '7) Probe validation',
            'Verify expected KeyData semantics in this runtime.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _probePanel(),
          _section(
            '8) Event notes',
            'See chronological interactions and state transitions.',
            Icons.notes,
            const Color(0xFF334155),
          ),
          _notesPanel(),
          _section(
            '9) Final guidance',
            'When and how to use KeyData in interpreter integration tests.',
            Icons.info_outline,
            const Color(0xFF475569),
          ),
          _summaryPanel(),
        ],
      ),
    );
  }
}

class _KeyPreset {
  const _KeyPreset({
    required this.label,
    required this.physical,
    required this.logical,
    required this.character,
  });

  final String label;
  final int physical;
  final int logical;
  final String character;
}

class _DeviceCardData {
  const _DeviceCardData({
    required this.title,
    required this.icon,
    required this.selected,
    required this.body,
    required this.colors,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final String body;
  final List<Color> colors;
}

class _KeyDataPainter extends CustomPainter {
  const _KeyDataPainter({
    required this.data,
    required this.showGrid,
    required this.pulse,
    required this.showHex,
  });

  final ui.KeyData data;
  final bool showGrid;
  final double pulse;
  final bool showHex;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(28);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    if (showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double step = 18;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    final Offset left = Offset(size.width * 0.2, size.height * 0.5);
    final Offset mid = Offset(size.width * 0.5, size.height * 0.5);
    final Offset right = Offset(size.width * 0.8, size.height * 0.5);

    final Paint line = Paint()
      ..color = const Color(0xFF64748B)
      ..strokeWidth = 2.2;
    canvas.drawLine(left, mid, line);
    canvas.drawLine(mid, right, line);

    void drawNode(Offset p, String label, Color color) {
      canvas.drawCircle(p, 20, Paint()..color = color);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(fontSize: 10.5, color: Colors.black87),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(p.dx - tp.width / 2, p.dy + 24));
    }

    drawNode(left, 'Physical', const Color(0xFF38BDF8));
    drawNode(mid, 'KeyData', const Color(0xFF818CF8));
    drawNode(right, 'Logical', const Color(0xFF34D399));

    final String phys = showHex
        ? '0x${data.physical.toRadixString(16).toUpperCase()}'
        : '${data.physical}';
    final String log = showHex
        ? '0x${data.logical.toRadixString(16).toUpperCase()}'
        : '${data.logical}';

    final TextPainter info = TextPainter(
      text: TextSpan(
        text: 'Type ${data.type.toString().split('.').last}  |  phys $phys  |  log $log  |  '
            'char ${data.character ?? 'null'}  |  ${data.deviceType.toString().split('.').last}',
        style: const TextStyle(fontSize: 12.2, color: Color(0xFF0F172A)),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    info.paint(canvas, const Offset(8, 8));

    final Offset p = Offset.lerp(left, right, pulse) ?? left;
    canvas.drawCircle(p, 6, Paint()..color = const Color(0xFF0EA5E9));
  }

  @override
  bool shouldRepaint(covariant _KeyDataPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.pulse != pulse ||
        oldDelegate.showHex != showHex;
  }
}
