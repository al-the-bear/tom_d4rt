// D4rt test script: Deep demo for KeyEventDeviceType from dart:ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _KeyEventDeviceTypeDeepDemoPage(),
  );
}

class _KeyEventDeviceTypeDeepDemoPage extends StatefulWidget {
  const _KeyEventDeviceTypeDeepDemoPage();

  @override
  State<_KeyEventDeviceTypeDeepDemoPage> createState() => _KeyEventDeviceTypeDeepDemoPageState();
}

class _KeyEventDeviceTypeDeepDemoPageState extends State<_KeyEventDeviceTypeDeepDemoPage>
    with SingleTickerProviderStateMixin {
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _notes = <String>[];
  final List<_SignalEntry> _signals = <_SignalEntry>[];

  int _activeDeviceIndex = 0;
  ui.KeyEventType _phase = ui.KeyEventType.down;
  bool _synthesized = false;
  bool _showGrid = true;
  bool _showHex = true;
  bool _animateFlow = true;
  double _signalStrength = 0.72;
  double _latencyMs = 18;
  double _repeatRate = 8;
  double _codeSeed = 44;
  int _themeIndex = 0;

  late final AnimationController _pulse;

  final List<List<Color>> _themes = <List<Color>>[
    <Color>[const Color(0xFF0B132B), const Color(0xFF1C2541), const Color(0xFF5BC0BE)],
    <Color>[const Color(0xFF312E81), const Color(0xFF4F46E5), const Color(0xFF22D3EE)],
    <Color>[const Color(0xFF064E3B), const Color(0xFF047857), const Color(0xFF34D399)],
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
    _emitNote('KeyEventDeviceType deep demo initialized.');
    _runProbes();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _emitNote(String text) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _notes.insert(0, '[$stamp] $text');
    if (_notes.length > 36) {
      _notes.removeLast();
    }
  }

  ui.KeyEventDeviceType _activeDevice() {
    return ui.KeyEventDeviceType.values[_activeDeviceIndex];
  }

  String _deviceName(ui.KeyEventDeviceType device) {
    if (device == ui.KeyEventDeviceType.keyboard) {
      return 'Keyboard';
    }
    if (device == ui.KeyEventDeviceType.directionalPad) {
      return 'Directional Pad';
    }
    if (device == ui.KeyEventDeviceType.gamepad) {
      return 'Gamepad';
    }
    if (device == ui.KeyEventDeviceType.joystick) {
      return 'Joystick';
    }
    return 'HDMI';
  }

  IconData _deviceIcon(ui.KeyEventDeviceType device) {
    if (device == ui.KeyEventDeviceType.keyboard) {
      return Icons.keyboard;
    }
    if (device == ui.KeyEventDeviceType.directionalPad) {
      return Icons.gamepad;
    }
    if (device == ui.KeyEventDeviceType.gamepad) {
      return Icons.sports_esports;
    }
    if (device == ui.KeyEventDeviceType.joystick) {
      return Icons.control_camera;
    }
    return Icons.tv;
  }

  Color _deviceColor(ui.KeyEventDeviceType device) {
    if (device == ui.KeyEventDeviceType.keyboard) {
      return const Color(0xFF2563EB);
    }
    if (device == ui.KeyEventDeviceType.directionalPad) {
      return const Color(0xFF7C3AED);
    }
    if (device == ui.KeyEventDeviceType.gamepad) {
      return const Color(0xFF0F766E);
    }
    if (device == ui.KeyEventDeviceType.joystick) {
      return const Color(0xFFEA580C);
    }
    return const Color(0xFF334155);
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

  String _formatCode(int value) {
    if (_showHex) {
      return '0x${value.toRadixString(16).toUpperCase()}';
    }
    return value.toString();
  }

  int _physicalCode() {
    final int base = 8 + _activeDeviceIndex * 32;
    return base + _codeSeed.round();
  }

  int _logicalCode() {
    final int base = 80 + _activeDeviceIndex * 120;
    return base + (_codeSeed * 2).round();
  }

  String? _character() {
    final ui.KeyEventDeviceType d = _activeDevice();
    if (d == ui.KeyEventDeviceType.keyboard && _phase != ui.KeyEventType.up) {
      final int charIndex = (_codeSeed.round() % 26);
      return String.fromCharCode(97 + charIndex);
    }
    return null;
  }

  ui.KeyData _sampleData() {
    return ui.KeyData(
      timeStamp: Duration(milliseconds: _latencyMs.round()),
      type: _phase,
      physical: _physicalCode(),
      logical: _logicalCode(),
      character: _character(),
      synthesized: _synthesized,
      deviceType: _activeDevice(),
    );
  }

  void _appendSignal() {
    final ui.KeyEventDeviceType d = _activeDevice();
    final ui.KeyData sample = _sampleData();
    final _SignalEntry entry = _SignalEntry(
      device: d,
      phase: _phase,
      strength: _signalStrength,
      latencyMs: _latencyMs,
      repeatRate: _repeatRate,
      physical: sample.physical,
      logical: sample.logical,
      character: sample.character,
      synthesized: _synthesized,
    );
    _signals.insert(0, entry);
    if (_signals.length > 24) {
      _signals.removeLast();
    }
    _emitNote(
      'Signal appended: ${_deviceName(d)} ${_phaseName(_phase)} '
      'phys ${_formatCode(sample.physical)} log ${_formatCode(sample.logical)}.',
    );
    setState(() {});
  }

  void _runProbes() {
    _passed.clear();
    _failed.clear();

    void probe(String label, bool ok) {
      if (ok) {
        _passed.add(label);
      } else {
        _failed.add(label);
      }
    }

    probe('values contains exactly five device categories', ui.KeyEventDeviceType.values.length == 5);
    probe('keyboard index is stable at 0', ui.KeyEventDeviceType.keyboard.index == 0);
    probe('directionalPad index is stable at 1', ui.KeyEventDeviceType.directionalPad.index == 1);
    probe('gamepad index is stable at 2', ui.KeyEventDeviceType.gamepad.index == 2);
    probe('joystick index is stable at 3', ui.KeyEventDeviceType.joystick.index == 3);
    probe('hdmi index is stable at 4', ui.KeyEventDeviceType.hdmi.index == 4);

    final ui.KeyData defaultDevice = ui.KeyData(
      timeStamp: Duration.zero,
      type: ui.KeyEventType.down,
      physical: 1,
      logical: 1,
      character: null,
      synthesized: false,
    );
    probe('KeyData default deviceType resolves to keyboard',
        defaultDevice.deviceType == ui.KeyEventDeviceType.keyboard);

    final ui.KeyData joystickData = ui.KeyData(
      timeStamp: const Duration(milliseconds: 1),
      type: ui.KeyEventType.repeat,
      physical: 2,
      logical: 3,
      character: null,
      synthesized: true,
      deviceType: ui.KeyEventDeviceType.joystick,
    );
    probe('KeyData preserves explicitly selected deviceType',
        joystickData.deviceType == ui.KeyEventDeviceType.joystick);

    probe('enum toString includes value name',
        ui.KeyEventDeviceType.gamepad.toString().contains('gamepad'));
    probe('summary string can be formed', '${_passed.length + _failed.length} checks'.endsWith('checks'));

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
          BoxShadow(color: colors[1].withAlpha(92), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'KeyEventDeviceType Studio',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'KeyEventDeviceType classifies where a key event originated (keyboard, d-pad, '
            'gamepad, joystick, or HDMI). This deep demo explores visual distinctions, '
            'signal behavior, and KeyData integration patterns for each source.',
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

  Widget _conceptOverview() {
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
          card('Source taxonomy', 'Distinguishes input origin families for robust handlers.',
              Icons.category, const Color(0xFF1D4ED8)),
          card('Routing logic', 'Device class can map signals to mode-specific commands.',
              Icons.route, const Color(0xFF0F766E)),
          card('Diagnostics', 'Useful for telemetry and interoperability debugging.',
              Icons.analytics, const Color(0xFF7C3AED)),
          card('Interpreter tests', 'Validates enum transfer across bridge boundaries.',
              Icons.integration_instructions, const Color(0xFFB45309)),
        ],
      ),
    );
  }

  Widget _deviceGallery() {
    final List<ui.KeyEventDeviceType> values = ui.KeyEventDeviceType.values;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List<Widget>.generate(values.length, (int i) {
          final ui.KeyEventDeviceType d = values[i];
          final Color color = _deviceColor(d);
          final bool selected = _activeDeviceIndex == i;
          return GestureDetector(
            onTap: () {
              setState(() {
                _activeDeviceIndex = i;
              });
              _emitNote('Active device changed to ${_deviceName(d)}.');
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 186,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: selected
                      ? <Color>[color.withAlpha(235), color.withAlpha(160)]
                      : <Color>[color.withAlpha(120), color.withAlpha(65)],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: selected ? Colors.white : color.withAlpha(90), width: selected ? 2.2 : 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: color.withAlpha(90), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(_deviceIcon(d), color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    _deviceName(d),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14.5),
                  ),
                  const SizedBox(height: 4),
                  Text('enum index ${d.index}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(selected ? 'Selected profile' : 'Tap to activate',
                      style: const TextStyle(color: Colors.white, fontSize: 11.4)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _controlPanel() {
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
          const Text('Signal controls', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          DropdownButton<ui.KeyEventType>(
            value: _phase,
            isExpanded: true,
            onChanged: (ui.KeyEventType? value) {
              if (value != null) {
                setState(() {
                  _phase = value;
                });
                _emitNote('Phase changed to ${_phaseName(value)}.');
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
          const SizedBox(height: 8),
          Text('Signal strength: ${_signalStrength.toStringAsFixed(2)}'),
          Slider(
            value: _signalStrength,
            min: 0,
            max: 1,
            divisions: 100,
            onChanged: (double value) => setState(() => _signalStrength = value),
          ),
          Text('Latency: ${_latencyMs.round()} ms'),
          Slider(
            value: _latencyMs,
            min: 1,
            max: 180,
            divisions: 179,
            onChanged: (double value) => setState(() => _latencyMs = value),
          ),
          Text('Repeat rate: ${_repeatRate.toStringAsFixed(1)} Hz'),
          Slider(
            value: _repeatRate,
            min: 0,
            max: 30,
            divisions: 60,
            onChanged: (double value) => setState(() => _repeatRate = value),
          ),
          Text('Code seed: ${_codeSeed.round()}'),
          Slider(
            value: _codeSeed,
            min: 0,
            max: 220,
            divisions: 220,
            onChanged: (double value) => setState(() => _codeSeed = value),
          ),
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
                label: const Text('show grid'),
                selected: _showGrid,
                onSelected: (bool value) => setState(() => _showGrid = value),
              ),
              FilterChip(
                label: const Text('show hex codes'),
                selected: _showHex,
                onSelected: (bool value) => setState(() => _showHex = value),
              ),
              FilterChip(
                label: const Text('animate flow'),
                selected: _animateFlow,
                onSelected: (bool value) {
                  setState(() => _animateFlow = value);
                  if (_animateFlow) {
                    _pulse.repeat();
                  } else {
                    _pulse.stop();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _appendSignal,
                icon: const Icon(Icons.add),
                label: const Text('Append Signal'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _signals.clear();
                  _emitNote('Signal stream cleared.');
                  setState(() {});
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Clear Stream'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _runProbes();
                  _emitNote('Probe suite executed.');
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

  Widget _sampleKeyDataPanel() {
    final ui.KeyData sample = _sampleData();
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
          const Text('KeyData integration preview', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _chip('deviceType', _deviceName(sample.deviceType)),
              _chip('type', _phaseName(sample.type)),
              _chip('physical', _formatCode(sample.physical)),
              _chip('logical', _formatCode(sample.logical)),
              _chip('character', sample.character ?? 'null'),
              _chip('synthesized', sample.synthesized ? 'true' : 'false'),
              _chip('timestamp', '${sample.timeStamp.inMilliseconds} ms'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Use deviceType together with phase and key codes to build context-aware input '
            'routing in interpreter-based runtimes.',
            style: TextStyle(fontSize: 12.2),
          ),
        ],
      ),
    );
  }

  Widget _chip(String key, String value) {
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

  Widget _matrixPanel() {
    final List<_MatrixRow> rows = <_MatrixRow>[
      _MatrixRow('Keyboard', 'Text entry, shortcuts', 'High', 'Stable matrix codes', 'Desktop, laptop'),
      _MatrixRow('Directional Pad', 'Menu navigation', 'Medium', 'Directional focus movement', 'TV remotes'),
      _MatrixRow('Gamepad', 'Action controls', 'High', 'Button semantics vary per vendor', 'Consoles, Android TV'),
      _MatrixRow('Joystick', 'Axis-centric controls', 'Medium', 'Often mapped to repeat events', 'Arcade setups'),
      _MatrixRow('HDMI', 'External transport', 'Low', 'Dependent on intermediary devices', 'Set-top chains'),
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
          const Text('Device compatibility matrix', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: const Color(0xFFE2E8F0)),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.1),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(0.7),
              3: FlexColumnWidth(1.2),
              4: FlexColumnWidth(1.1),
            },
            children: <TableRow>[
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFFF1F5F9)),
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8), child: Text('Device', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Typical use', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Noise', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Notes', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Platform fit', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                ],
              ),
              ...rows.map((row) => row.toRow()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _routingCanvas() {
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
          const Text('Signal routing canvas', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 210,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _RoutingPainter(
                    activeDevice: _activeDevice(),
                    showGrid: _showGrid,
                    pulse: _animateFlow ? _pulse.value : 0,
                    phase: _phase,
                    strength: _signalStrength,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Visualization meaning: active device emits into normalization stage, then gets '
            'routed to app actions based on device class and phase.',
            style: const TextStyle(fontSize: 12.1),
          ),
        ],
      ),
    );
  }

  Widget _streamPanel() {
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
          const Text('Signal event stream', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 210,
            child: _signals.isEmpty
                ? const Center(
                    child: Text(
                      'No signals yet. Append one from the control panel.',
                      style: TextStyle(fontSize: 12.3, color: Color(0xFF64748B)),
                    ),
                  )
                : ListView.builder(
                    itemCount: _signals.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _SignalEntry e = _signals[index];
                      final Color color = _deviceColor(e.device);
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
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${_deviceName(e.device)} ${_phaseName(e.phase)} | '
                                'strength ${e.strength.toStringAsFixed(2)} | '
                                'lat ${e.latencyMs.round()}ms | '
                                'phys ${_formatCode(e.physical)} | log ${_formatCode(e.logical)} | '
                                'char ${e.character ?? 'null'} | syn ${e.synthesized}',
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

  Widget _probePanel() {
    Widget probeLine(String text, bool ok) {
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
          ..._passed.map((String s) => probeLine(s, true)),
          ..._failed.map((String s) => probeLine(s, false)),
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
        'KeyEventDeviceType guidance: treat the enum as a source classifier for key semantics, '
        'not as key identity itself. Use it with KeyData fields (phase, physical, logical, '
        'character, synthesized) to tailor handling for keyboard typing, controller navigation, '
        'joystick interaction, and HDMI-transmitted input channels.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - KeyEventDeviceType'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _section(
            '1) Concept overview',
            'What device classification contributes to key handling.',
            Icons.menu_book,
            const Color(0xFF2563EB),
          ),
          _conceptOverview(),
          _section(
            '2) Device gallery',
            'Explore and activate each enum category visually.',
            Icons.widgets,
            const Color(0xFF7C3AED),
          ),
          _deviceGallery(),
          _section(
            '3) Signal controls',
            'Configure event profile and runtime toggles.',
            Icons.tune,
            const Color(0xFF0F766E),
          ),
          _controlPanel(),
          _section(
            '4) KeyData integration',
            'Observe generated KeyData fields for active device.',
            Icons.data_object,
            const Color(0xFFB45309),
          ),
          _sampleKeyDataPanel(),
          _section(
            '5) Compatibility matrix',
            'Compare practical behavior by device class.',
            Icons.table_chart,
            const Color(0xFF334155),
          ),
          _matrixPanel(),
          _section(
            '6) Routing canvas',
            'Visualize active signal flow through input stages.',
            Icons.hub,
            const Color(0xFF0369A1),
          ),
          _routingCanvas(),
          _section(
            '7) Event stream',
            'Track generated signal samples over time.',
            Icons.timeline,
            const Color(0xFFBE123C),
          ),
          _streamPanel(),
          _section(
            '8) Probe checks',
            'Verify enum stability and KeyData device propagation.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _probePanel(),
          _section(
            '9) Notes and summary',
            'Operational trace and practical usage recommendations.',
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

class _SignalEntry {
  const _SignalEntry({
    required this.device,
    required this.phase,
    required this.strength,
    required this.latencyMs,
    required this.repeatRate,
    required this.physical,
    required this.logical,
    required this.character,
    required this.synthesized,
  });

  final ui.KeyEventDeviceType device;
  final ui.KeyEventType phase;
  final double strength;
  final double latencyMs;
  final double repeatRate;
  final int physical;
  final int logical;
  final String? character;
  final bool synthesized;
}

class _MatrixRow {
  const _MatrixRow(this.device, this.useCase, this.noise, this.notes, this.platform);

  final String device;
  final String useCase;
  final String noise;
  final String notes;
  final String platform;

  TableRow toRow() {
    Widget cell(String text) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(text, style: const TextStyle(fontSize: 12)),
      );
    }

    return TableRow(
      children: <Widget>[
        cell(device),
        cell(useCase),
        cell(noise),
        cell(notes),
        cell(platform),
      ],
    );
  }
}

class _RoutingPainter extends CustomPainter {
  const _RoutingPainter({
    required this.activeDevice,
    required this.showGrid,
    required this.pulse,
    required this.phase,
    required this.strength,
  });

  final ui.KeyEventDeviceType activeDevice;
  final bool showGrid;
  final double pulse;
  final ui.KeyEventType phase;
  final double strength;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(26);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    if (showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double step = 16;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    final Offset source = Offset(size.width * 0.15, size.height * 0.5);
    final Offset normalize = Offset(size.width * 0.45, size.height * 0.5);
    final Offset route = Offset(size.width * 0.75, size.height * 0.5);

    final Paint link = Paint()
      ..color = const Color(0xFF64748B)
      ..strokeWidth = 2.4;
    canvas.drawLine(source, normalize, link);
    canvas.drawLine(normalize, route, link);

    Color colorFor(ui.KeyEventDeviceType d) {
      if (d == ui.KeyEventDeviceType.keyboard) {
        return const Color(0xFF2563EB);
      }
      if (d == ui.KeyEventDeviceType.directionalPad) {
        return const Color(0xFF7C3AED);
      }
      if (d == ui.KeyEventDeviceType.gamepad) {
        return const Color(0xFF0F766E);
      }
      if (d == ui.KeyEventDeviceType.joystick) {
        return const Color(0xFFEA580C);
      }
      return const Color(0xFF334155);
    }

    void node(Offset p, String text, Color color) {
      canvas.drawCircle(p, 18, Paint()..color = color);
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black87, fontSize: 10.5),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      t.paint(canvas, Offset(p.dx - t.width / 2, p.dy + 22));
    }

    node(source, 'Source', colorFor(activeDevice));
    node(normalize, 'Normalize', const Color(0xFF818CF8));
    node(route, 'Action', const Color(0xFF16A34A));

    final Offset p1 = Offset.lerp(source, normalize, pulse) ?? source;
    final Offset p2 = Offset.lerp(normalize, route, pulse) ?? normalize;
    canvas.drawCircle(p1, 5 + strength * 3, Paint()..color = const Color(0xFF0EA5E9));
    canvas.drawCircle(p2, 5 + strength * 3, Paint()..color = const Color(0xFF22C55E));

    final String phaseName = phase == ui.KeyEventType.down
        ? 'down'
        : phase == ui.KeyEventType.up
            ? 'up'
            : 'repeat';
    final TextPainter legend = TextPainter(
      text: TextSpan(
        text: 'phase: $phaseName  strength: ${strength.toStringAsFixed(2)}',
        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 12.1),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legend.paint(canvas, const Offset(8, 8));
  }

  @override
  bool shouldRepaint(covariant _RoutingPainter oldDelegate) {
    return oldDelegate.activeDevice != activeDevice ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.pulse != pulse ||
        oldDelegate.phase != phase ||
        oldDelegate.strength != strength;
  }
}
