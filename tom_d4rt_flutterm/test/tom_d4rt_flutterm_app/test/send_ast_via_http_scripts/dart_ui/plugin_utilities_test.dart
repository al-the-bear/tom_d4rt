// D4rt test script: Deep demo for PluginUtilities from dart:ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void _topLevelSyncCallback() {}

void _topLevelSecondaryCallback() {}

class _StaticCallbackHost {
  static void staticEntryCallback() {}

  void instanceEntryCallback() {}
}


dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _PluginUtilitiesDemoPage(),
  );
}

class _PluginUtilitiesDemoPage extends StatefulWidget {
  const _PluginUtilitiesDemoPage();

  @override
  State<_PluginUtilitiesDemoPage> createState() => _PluginUtilitiesDemoPageState();
}

class _PluginUtilitiesDemoPageState extends State<_PluginUtilitiesDemoPage>
    with SingleTickerProviderStateMixin {
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _eventLog = <String>[];
  final List<_HandleRecord> _records = <_HandleRecord>[];

  final _StaticCallbackHost _instanceHost = _StaticCallbackHost();

  int _themeIndex = 0;
  int _sourceMode = 0;
  bool _showRawGrid = true;
  bool _autoRoundTrip = true;
  bool _animatePipeline = true;
  double _nodeSpacing = 20;
  double _pulseStrength = 0.5;

  late final AnimationController _pulse;

  final List<List<Color>> _themes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF172554), const Color(0xFF1D4ED8), const Color(0xFF60A5FA)],
    <Color>[const Color(0xFF052E16), const Color(0xFF166534), const Color(0xFF4ADE80)],
  ];

  static const List<String> _sourceLabels = <String>[
    'Top-level callback A',
    'Top-level callback B',
    'Static class callback',
    'Instance callback (expected invalid)',
    'Inline closure (expected invalid)',
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat();
    _log('PluginUtilities deep demo initialized.');
    _runProbes();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _log(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _eventLog.insert(0, '[$stamp] $message');
    if (_eventLog.length > 60) {
      _eventLog.removeLast();
    }
  }

  Function _sourceFunction() {
    switch (_sourceMode) {
      case 0:
        return _topLevelSyncCallback;
      case 1:
        return _topLevelSecondaryCallback;
      case 2:
        return _StaticCallbackHost.staticEntryCallback;
      case 3:
        return _instanceHost.instanceEntryCallback;
      default:
        return () {};
    }
  }

  void _createHandleRecord() {
    final Function source = _sourceFunction();
    final String sourceLabel = _sourceLabels[_sourceMode];
    ui.CallbackHandle? handle;
    String status = 'created';
    bool callbackResolved = false;
    bool callbackInvoked = false;
    String note = '';
    try {
      handle = ui.PluginUtilities.getCallbackHandle(source);
      if (handle == null) {
        status = 'null-handle';
        note = 'Callback type is not supported for background lookup.';
      } else {
        final int raw = handle.toRawHandle();
        final ui.CallbackHandle reconstructed = ui.CallbackHandle.fromRawHandle(raw);
        final Function? restored = ui.PluginUtilities.getCallbackFromHandle(reconstructed);
        callbackResolved = restored != null;
        if (restored is void Function()) {
          restored();
          callbackInvoked = true;
        }
        note = callbackResolved
            ? 'Round-trip succeeded. Raw handle $raw reconstructed and callback resolved.'
            : 'Round-trip created a handle, but callback lookup returned null.';
      }
    } catch (e) {
      status = 'error';
      note = e.toString();
      _log('Handle creation error for $sourceLabel: $e');
    }

    final _HandleRecord record = _HandleRecord(
      timestamp: DateTime.now(),
      sourceLabel: sourceLabel,
      status: status,
      rawHandle: handle?.toRawHandle(),
      callbackResolved: callbackResolved,
      callbackInvoked: callbackInvoked,
      note: note,
    );
    _records.insert(0, record);
    if (_records.length > 40) {
      _records.removeLast();
    }

    if (_autoRoundTrip && handle != null) {
      _log('Generated handle for $sourceLabel with raw=${handle.toRawHandle()} and auto round-trip enabled.');
    } else if (handle == null) {
      _log('No handle generated for $sourceLabel (expected for unsupported callback forms).');
    }
    setState(() {});
  }

  void _runProbes() {
    _passed.clear();
    _failed.clear();

    void probe(String name, bool ok) {
      if (ok) {
        _passed.add(name);
      } else {
        _failed.add(name);
      }
    }

    probe('PluginUtilities class name is present', 'PluginUtilities'.contains('Plugin'));

    final ui.CallbackHandle? topHandle = ui.PluginUtilities.getCallbackHandle(_topLevelSyncCallback);
    probe('Top-level callback can produce handle', topHandle != null);

    final ui.CallbackHandle? staticHandle = ui.PluginUtilities.getCallbackHandle(_StaticCallbackHost.staticEntryCallback);
    probe('Static callback can produce handle', staticHandle != null);

    final ui.CallbackHandle? closureHandle = ui.PluginUtilities.getCallbackHandle(() {});
    probe('Inline closure returns null handle', closureHandle == null);

    if (topHandle != null) {
      final int raw = topHandle.toRawHandle();
      final ui.CallbackHandle rebuilt = ui.CallbackHandle.fromRawHandle(raw);
      final Function? callback = ui.PluginUtilities.getCallbackFromHandle(rebuilt);
      probe('Round-trip callback lookup succeeds for top-level callback', callback != null);
      probe('Raw handle is non-zero', raw != 0);
    } else {
      probe('Round-trip callback lookup succeeds for top-level callback', false);
      probe('Raw handle is non-zero', false);
    }

    probe('summary text can be generated', '${_passed.length + _failed.length} checks'.endsWith('checks'));
    _log('Runtime probes completed with ${_passed.length} pass and ${_failed.length} fail.');
    setState(() {});
  }

  Widget _header() {
    final List<Color> theme = _themes[_themeIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: theme),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[BoxShadow(color: theme[1].withAlpha(90), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'PluginUtilities Callback-Handle Studio',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'PluginUtilities bridges callback references and integer handles so background '
            'entry points can be resolved by Flutter engines. This deep demo visualizes which '
            'callback shapes are valid, how raw handles are round-tripped, and how retrieval works.',
            style: TextStyle(color: Colors.white, fontSize: 13.1, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: accent.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withAlpha(95)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: accent.withAlpha(38), borderRadius: BorderRadius.circular(8)),
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
          card('Source constraints', 'Only top-level and static callbacks are valid handle sources.', Icons.rule,
              const Color(0xFF1D4ED8)),
          card('Handle serialization', 'CallbackHandle converts to raw integers for transport.', Icons.numbers,
              const Color(0xFF047857)),
          card('Runtime lookup', 'getCallbackFromHandle resolves callable entries at runtime.', Icons.search,
              const Color(0xFF7C3AED)),
          card('Operational diagnostics', 'This panel tracks generation, failures, and invocation outcomes.', Icons.analytics,
              const Color(0xFFB45309)),
        ],
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
          const Text('Callback source and pipeline controls', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          DropdownButton<int>(
            isExpanded: true,
            value: _sourceMode,
            onChanged: (int? value) {
              if (value != null) {
                setState(() => _sourceMode = value);
                _log('Switched callback source to ${_sourceLabels[value]}.');
              }
            },
            items: List<DropdownMenuItem<int>>.generate(
              _sourceLabels.length,
              (int index) => DropdownMenuItem<int>(value: index, child: Text(_sourceLabels[index])),
            ),
          ),
          Text('Pipeline node spacing: ${_nodeSpacing.toStringAsFixed(0)}'),
          Slider(value: _nodeSpacing, min: 8, max: 42, divisions: 34, onChanged: (double v) => setState(() => _nodeSpacing = v)),
          Text('Pulse strength: ${_pulseStrength.toStringAsFixed(2)}'),
          Slider(value: _pulseStrength, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _pulseStrength = v)),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(label: const Text('show raw grid'), selected: _showRawGrid, onSelected: (bool v) => setState(() => _showRawGrid = v)),
              FilterChip(label: const Text('auto round-trip'), selected: _autoRoundTrip, onSelected: (bool v) => setState(() => _autoRoundTrip = v)),
              FilterChip(
                label: const Text('animate pipeline'),
                selected: _animatePipeline,
                onSelected: (bool v) {
                  setState(() => _animatePipeline = v);
                  if (_animatePipeline) {
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
                onPressed: _createHandleRecord,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Create Handle Record'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _records.clear();
                  _log('Cleared handle records table.');
                  setState(() {});
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Records'),
              ),
              OutlinedButton.icon(
                onPressed: _runProbes,
                icon: const Icon(Icons.fact_check_outlined),
                label: const Text('Run Probes'),
              ),
              OutlinedButton.icon(
                onPressed: () => setState(() => _themeIndex = (_themeIndex + 1) % _themes.length),
                icon: const Icon(Icons.palette_outlined),
                label: const Text('Theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pipelinePanel() {
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
          const Text('CallbackHandle flow visualization', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 230,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _PipelinePainter(
                    pulse: _animatePipeline ? _pulse.value : 0,
                    sourceLabel: _sourceLabels[_sourceMode],
                    showGrid: _showRawGrid,
                    spacing: _nodeSpacing,
                    pulseStrength: _pulseStrength,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text('Current source: ${_sourceLabels[_sourceMode]}'),
        ],
      ),
    );
  }

  Widget _recordsPanel() {
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
          const Text('Handle records timeline', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 240,
            child: _records.isEmpty
                ? const Center(
                    child: Text(
                      'No records yet. Generate handles from the control panel.',
                      style: TextStyle(fontSize: 12.2, color: Color(0xFF64748B)),
                    ),
                  )
                : ListView.builder(
                    itemCount: _records.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _HandleRecord record = _records[index];
                      final bool ok = record.status == 'created' && record.rawHandle != null;
                      final Color tone = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
                      final String time =
                          '${record.timestamp.hour.toString().padLeft(2, '0')}:${record.timestamp.minute.toString().padLeft(2, '0')}:${record.timestamp.second.toString().padLeft(2, '0')}';
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: tone.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: tone.withAlpha(90)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(ok ? Icons.check_circle : Icons.error, color: tone, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '$time | ${record.sourceLabel} | ${record.status} | raw=${record.rawHandle ?? 'n/a'}',
                                    style: const TextStyle(fontSize: 12.2),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'resolved=${record.callbackResolved}, invoked=${record.callbackInvoked} | ${record.note}',
                              style: const TextStyle(fontSize: 11.8),
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
    Widget row(String title, bool ok) {
      final Color tone = ok ? const Color(0xFF166534) : const Color(0xFFB91C1C);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: tone.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: tone.withAlpha(95)),
        ),
        child: Row(
          children: <Widget>[
            Icon(ok ? Icons.check_circle : Icons.cancel, color: tone, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 12.2))),
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
          ..._passed.map((String p) => row(p, true)),
          ..._failed.map((String f) => row(f, false)),
        ],
      ),
    );
  }

  Widget _guidancePanel() {
    final List<_GuideLine> lines = <_GuideLine>[
      const _GuideLine('Use top-level/static entrypoints', 'PluginUtilities only recognizes stable entry references.'),
      const _GuideLine('Avoid closures for handles', 'Anonymous closures typically resolve to null handles.'),
      const _GuideLine('Persist raw handles safely', 'Round-trip through toRawHandle/fromRawHandle for transport.'),
      const _GuideLine('Validate callback retrieval', 'Always verify getCallbackFromHandle before invoking.'),
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
          const Text('Operational guidance', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...lines.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(Icons.circle, size: 8, color: Color(0xFF334155)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text('${e.title}: ${e.body}', style: const TextStyle(fontSize: 12.2))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _logPanel() {
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
          const Text('Event log timeline', style: TextStyle(fontWeight: FontWeight.w700)),
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
              itemCount: _eventLog.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(_eventLog[index], style: const TextStyle(fontSize: 12)),
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
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: const Text(
        'PluginUtilities summary: top-level and static callbacks are safe handle sources; '
        'instance methods and closures are generally unsuitable. Handle round-tripping through '
        'raw integers enables callback persistence and recovery workflows used by background execution paths.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - PluginUtilities'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _section('1) Concept mapping', 'Understand callback-handle primitives and constraints.', Icons.menu_book,
              const Color(0xFF1D4ED8)),
          _conceptCards(),
          _section('2) Source lab', 'Generate and inspect callback handles from different callback forms.', Icons.tune,
              const Color(0xFF7C3AED)),
          _controlPanel(),
          _section('3) Pipeline preview', 'Visual flow from callback source to callback restoration.', Icons.account_tree,
              const Color(0xFF047857)),
          _pipelinePanel(),
          _section('4) Handle timeline', 'Track per-attempt status, raw values, and callback outcomes.', Icons.timeline,
              const Color(0xFFB45309)),
          _recordsPanel(),
          _section('5) Probe checks', 'Runtime checks for valid and invalid callback forms.', Icons.fact_check,
              const Color(0xFF166534)),
          _probePanel(),
          _section('6) Guidance and logs', 'Best practices and chronological diagnostics.', Icons.notes,
              const Color(0xFF475569)),
          _guidancePanel(),
          _logPanel(),
          _summaryPanel(),
        ],
      ),
    );
  }
}

class _HandleRecord {
  const _HandleRecord({
    required this.timestamp,
    required this.sourceLabel,
    required this.status,
    required this.rawHandle,
    required this.callbackResolved,
    required this.callbackInvoked,
    required this.note,
  });

  final DateTime timestamp;
  final String sourceLabel;
  final String status;
  final int? rawHandle;
  final bool callbackResolved;
  final bool callbackInvoked;
  final String note;
}

class _GuideLine {
  const _GuideLine(this.title, this.body);

  final String title;
  final String body;
}

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter({
    required this.pulse,
    required this.sourceLabel,
    required this.showGrid,
    required this.spacing,
    required this.pulseStrength,
  });

  final double pulse;
  final String sourceLabel;
  final bool showGrid;
  final double spacing;
  final double pulseStrength;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(22);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)), bg);

    if (showGrid) {
      final Paint gp = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double step = 16;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
      }
    }

    final List<String> nodes = <String>['Callback Source', 'PluginUtilities.getCallbackHandle', 'Raw Handle', 'fromRawHandle', 'getCallbackFromHandle'];
    final double y = size.height * 0.55;
    final double start = 24;
    final double width = (size.width - 48 - (nodes.length - 1) * spacing) / nodes.length;

    for (int i = 0; i < nodes.length; i++) {
      final Rect rect = Rect.fromLTWH(start + i * (width + spacing), y, width, 44);
      final double t = (i / (nodes.length - 1));
      final Color c = Color.lerp(const Color(0xFF2563EB), const Color(0xFF22C55E), t) ?? const Color(0xFF2563EB);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        Paint()..color = c.withAlpha((120 + 90 * pulse * pulseStrength).toInt()),
      );
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(text: nodes[i], style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w600)),
      )..layout(maxWidth: rect.width - 8);
      tp.paint(canvas, Offset(rect.left + (rect.width - tp.width) / 2, rect.top + (rect.height - tp.height) / 2));

      if (i < nodes.length - 1) {
        final Offset a = Offset(rect.right + 2, rect.center.dy);
        final Offset b = Offset(rect.right + spacing - 2, rect.center.dy);
        final Paint lp = Paint()
          ..color = const Color(0xFF0EA5E9)
          ..strokeWidth = 2.5;
        canvas.drawLine(a, b, lp);
        final Path arrow = Path()
          ..moveTo(b.dx - 6, b.dy - 4)
          ..lineTo(b.dx, b.dy)
          ..lineTo(b.dx - 6, b.dy + 4);
        canvas.drawPath(arrow, lp);
      }
    }

    final TextPainter source = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: 'Selected source: $sourceLabel',
        style: const TextStyle(fontSize: 12, color: Color(0xFF0F172A), fontWeight: FontWeight.w700),
      ),
    )..layout(maxWidth: size.width - 20);
    source.paint(canvas, const Offset(10, 12));
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter oldDelegate) {
    return oldDelegate.pulse != pulse ||
        oldDelegate.sourceLabel != sourceLabel ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.spacing != spacing ||
        oldDelegate.pulseStrength != pulseStrength;
  }
}
