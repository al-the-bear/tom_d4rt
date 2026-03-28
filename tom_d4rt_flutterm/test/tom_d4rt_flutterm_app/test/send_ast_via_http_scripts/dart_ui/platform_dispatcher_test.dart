// D4rt test script: Deep demo for PlatformDispatcher from dart:ui.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _PlatformDispatcherDemoPage(),
  );
}

class _PlatformDispatcherDemoPage extends StatefulWidget {
  const _PlatformDispatcherDemoPage();

  @override
  State<_PlatformDispatcherDemoPage> createState() => _PlatformDispatcherDemoPageState();
}

class _PlatformDispatcherDemoPageState extends State<_PlatformDispatcherDemoPage>
    with SingleTickerProviderStateMixin {
  final ui.PlatformDispatcher _dispatcher = ui.PlatformDispatcher.instance;

  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _eventLog = <String>[];
  final List<_DispatcherSnapshot> _timeline = <_DispatcherSnapshot>[];

  int _themeIndex = 0;
  bool _showGrid = true;
  bool _animateTopology = true;
  bool _showInsetsOverlay = true;
  bool _showAccessibilityFocus = true;
  double _nodeScale = 1.0;
  double _pulseStrength = 0.55;

  late final AnimationController _pulse;

  final List<List<Color>> _themes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF172554), const Color(0xFF1D4ED8), const Color(0xFF60A5FA)],
    <Color>[const Color(0xFF052E16), const Color(0xFF166534), const Color(0xFF4ADE80)],
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat();
    _log('PlatformDispatcher observatory initialized.');
    _captureSnapshot();
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
    if (_eventLog.length > 80) {
      _eventLog.removeLast();
    }
  }

  void _captureSnapshot() {
    final List<ui.FlutterView> views = _dispatcher.views.toList();
    final List<ui.Display> displays = _dispatcher.displays.toList();
    final ui.AccessibilityFeatures a = _dispatcher.accessibilityFeatures;

    final _DispatcherSnapshot snap = _DispatcherSnapshot(
      timestamp: DateTime.now(),
      viewCount: views.length,
      displayCount: displays.length,
      textScaleFactor: _dispatcher.textScaleFactor,
      platformBrightness: _dispatcher.platformBrightness.toString(),
      semanticsEnabled: _dispatcher.semanticsEnabled,
      alwaysUse24HourFormat: _dispatcher.alwaysUse24HourFormat,
      localeLabel: _dispatcher.locale.toString(),
      localesLabel: _dispatcher.locales.map((ui.Locale l) => l.toString()).join(', '),
      accessibilitySummary: _accessibilitySummary(a),
      implicitViewPresent: _dispatcher.implicitView != null,
      frameDataSummary: _frameDataSummary(views),
    );

    _timeline.insert(0, snap);
    if (_timeline.length > 45) {
      _timeline.removeLast();
    }

    _log(
      'Snapshot captured: ${snap.viewCount} views, ${snap.displayCount} displays, '
      'locale=${snap.localeLabel}, textScale=${snap.textScaleFactor.toStringAsFixed(2)}.',
    );
    setState(() {});
  }

  String _accessibilitySummary(ui.AccessibilityFeatures a) {
    final List<String> flags = <String>[];
    if (a.accessibleNavigation) flags.add('accessibleNavigation');
    if (a.boldText) flags.add('boldText');
    if (a.disableAnimations) flags.add('disableAnimations');
    if (a.highContrast) flags.add('highContrast');
    if (a.invertColors) flags.add('invertColors');
    if (a.onOffSwitchLabels) flags.add('onOffSwitchLabels');
    if (a.reduceMotion) flags.add('reduceMotion');
    return flags.isEmpty ? 'none' : flags.join(' | ');
  }

  String _frameDataSummary(List<ui.FlutterView> views) {
    if (views.isEmpty) {
      return 'no active FlutterView entries';
    }
    final ui.FlutterView v = views.first;
    return 'size=${v.physicalSize.width.toStringAsFixed(0)}x${v.physicalSize.height.toStringAsFixed(0)}, '
        'dpr=${v.devicePixelRatio.toStringAsFixed(2)}';
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

    probe('PlatformDispatcher singleton is stable', identical(_dispatcher, ui.PlatformDispatcher.instance));
    probe('views iterable is available', _dispatcher.views.runtimeType.toString().contains('Iterable'));
    probe('displays iterable is available', _dispatcher.displays.runtimeType.toString().contains('Iterable'));
    probe('locale language code exists', _dispatcher.locale.languageCode.isNotEmpty);
    probe('locales list is non-empty', _dispatcher.locales.isNotEmpty);
    probe('textScaleFactor is greater than zero', _dispatcher.textScaleFactor > 0);
    probe('semanticsEnabled is bool', _dispatcher.semanticsEnabled == true || _dispatcher.semanticsEnabled == false);
    probe('alwaysUse24HourFormat is bool',
        _dispatcher.alwaysUse24HourFormat == true || _dispatcher.alwaysUse24HourFormat == false);
    probe('platformBrightness string contains Brightness', _dispatcher.platformBrightness.toString().contains('Brightness'));
    probe('summary text can be formed', '${_passed.length + _failed.length} checks'.endsWith('checks'));

    _log('Runtime probes executed: ${_passed.length} pass, ${_failed.length} fail.');
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
            'PlatformDispatcher Runtime Observatory',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'PlatformDispatcher exposes global engine and platform state: views, displays, '
            'locale, accessibility, timing, and semantics. This deep demo visualizes how those '
            'signals can be inspected and monitored during interpreter execution.',
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
          card('Global engine context', 'Singleton access to app-wide platform integration.', Icons.public,
              const Color(0xFF1D4ED8)),
          card('View and display graph', 'Track view count, display count, geometry, and density.', Icons.dashboard_customize,
              const Color(0xFF047857)),
          card('Locale and semantics', 'Observe locale stacks, text scale, and semantics flags.', Icons.translate,
              const Color(0xFF7C3AED)),
          card('Operational telemetry', 'Capture snapshots over time and compare runtime drift.', Icons.timeline,
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
          const Text('Dispatcher controls and snapshot tools', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Node scale: ${_nodeScale.toStringAsFixed(2)}'),
          Slider(value: _nodeScale, min: 0.7, max: 1.6, divisions: 90, onChanged: (double v) => setState(() => _nodeScale = v)),
          Text('Pulse strength: ${_pulseStrength.toStringAsFixed(2)}'),
          Slider(value: _pulseStrength, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _pulseStrength = v)),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(label: const Text('show grid'), selected: _showGrid, onSelected: (bool v) => setState(() => _showGrid = v)),
              FilterChip(
                label: const Text('animate topology'),
                selected: _animateTopology,
                onSelected: (bool v) {
                  setState(() => _animateTopology = v);
                  if (_animateTopology) {
                    _pulse.repeat();
                  } else {
                    _pulse.stop();
                  }
                },
              ),
              FilterChip(
                  label: const Text('show insets overlay'),
                  selected: _showInsetsOverlay,
                  onSelected: (bool v) => setState(() => _showInsetsOverlay = v)),
              FilterChip(
                  label: const Text('focus accessibility'),
                  selected: _showAccessibilityFocus,
                  onSelected: (bool v) => setState(() => _showAccessibilityFocus = v)),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _captureSnapshot,
                icon: const Icon(Icons.camera_outlined),
                label: const Text('Capture Snapshot'),
              ),
              OutlinedButton.icon(
                onPressed: _runProbes,
                icon: const Icon(Icons.fact_check_outlined),
                label: const Text('Run Probes'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _timeline.clear();
                  _log('Cleared snapshot timeline.');
                  setState(() {});
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Timeline'),
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

  Widget _currentStatePanel() {
    final ui.AccessibilityFeatures a = _dispatcher.accessibilityFeatures;
    final List<_FactRow> rows = <_FactRow>[
      _FactRow('Views', '${_dispatcher.views.length} active view(s)'),
      _FactRow('Displays', '${_dispatcher.displays.length} display(s)'),
      _FactRow('Locale', _dispatcher.locale.toString()),
      _FactRow('Locales', _dispatcher.locales.map((ui.Locale l) => l.toString()).join(', ')),
      _FactRow('Text Scale', _dispatcher.textScaleFactor.toStringAsFixed(2)),
      _FactRow('Platform Brightness', _dispatcher.platformBrightness.toString()),
      _FactRow('Semantics Enabled', _dispatcher.semanticsEnabled.toString()),
      _FactRow('Always 24h', _dispatcher.alwaysUse24HourFormat.toString()),
      _FactRow('Accessibility Flags', _accessibilitySummary(a)),
      _FactRow('Implicit View', _dispatcher.implicitView == null ? 'null' : 'present'),
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
          const Text('Current dispatcher state', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...rows.map((e) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 160, child: Text(e.keyName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.2))),
                  Expanded(child: Text(e.value, style: const TextStyle(fontSize: 12.2))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _topologyPanel() {
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
          const Text('View/display topology visualization', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 230,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _TopologyPainter(
                    viewCount: _dispatcher.views.length,
                    displayCount: _dispatcher.displays.length,
                    pulse: _animateTopology ? _pulse.value : 0,
                    showGrid: _showGrid,
                    nodeScale: _nodeScale,
                    pulseStrength: _pulseStrength,
                    showInsetsOverlay: _showInsetsOverlay,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewsPanel() {
    final List<ui.FlutterView> views = _dispatcher.views.toList();
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
          const Text('FlutterView detail table', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          if (views.isEmpty)
            const Text('No views reported by PlatformDispatcher.', style: TextStyle(fontSize: 12.2, color: Color(0xFF64748B)))
          else
            ...views.asMap().entries.map((MapEntry<int, ui.FlutterView> entry) {
              final int i = entry.key;
              final ui.FlutterView view = entry.value;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('View #$i', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.4)),
                    const SizedBox(height: 4),
                    Text('id=${view.viewId} | size=${view.physicalSize.width.toStringAsFixed(0)}x${view.physicalSize.height.toStringAsFixed(0)}'),
                    Text('dpr=${view.devicePixelRatio.toStringAsFixed(2)} | display=${view.display.toString()}'),
                    Text('padding=${view.padding} | viewPadding=${view.viewPadding}'),
                    Text('viewInsets=${view.viewInsets} | systemGestureInsets=${view.systemGestureInsets}'),
                  ],
                ),
              );
            }),
        ],
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
          const Text('Snapshot timeline', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 240,
            child: _timeline.isEmpty
                ? const Center(
                    child: Text('No snapshots yet. Use Capture Snapshot to build history.',
                        style: TextStyle(fontSize: 12.2, color: Color(0xFF64748B))),
                  )
                : ListView.builder(
                    itemCount: _timeline.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _DispatcherSnapshot s = _timeline[index];
                      final String time =
                          '${s.timestamp.hour.toString().padLeft(2, '0')}:${s.timestamp.minute.toString().padLeft(2, '0')}:${s.timestamp.second.toString().padLeft(2, '0')}';
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('$time | views=${s.viewCount}, displays=${s.displayCount}, textScale=${s.textScaleFactor.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 12.2, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 3),
                            Text('locale=${s.localeLabel} | semantics=${s.semanticsEnabled} | 24h=${s.alwaysUse24HourFormat}',
                                style: const TextStyle(fontSize: 11.8)),
                            Text('brightness=${s.platformBrightness} | implicitView=${s.implicitViewPresent}',
                                style: const TextStyle(fontSize: 11.8)),
                            Text('accessibility=${s.accessibilitySummary}', style: const TextStyle(fontSize: 11.8)),
                            Text('frame=${s.frameDataSummary}', style: const TextStyle(fontSize: 11.8)),
                            if (_showAccessibilityFocus)
                              Text('locales=${s.localesLabel}', style: const TextStyle(fontSize: 11.8)),
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
          const Text('Event log', style: TextStyle(fontWeight: FontWeight.w700)),
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

  Widget _guidancePanel() {
    final List<_FactRow> tips = <_FactRow>[
      const _FactRow('Observe, do not assume', 'Read PlatformDispatcher values at runtime instead of hard-coding environment assumptions.'),
      const _FactRow('Capture drift over time', 'Snapshot timeline helps compare locale/text-scale/semantics changes across runs.'),
      const _FactRow('Treat views as dynamic', 'Multi-view environments can modify available FlutterView entries.'),
      const _FactRow('Bridge UI policy carefully', 'Use accessibility and 24-hour format signals to adapt UI behavior appropriately.'),
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
          ...tips.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Icon(Icons.circle, size: 8, color: Color(0xFF334155)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text('${e.keyName}: ${e.value}', style: const TextStyle(fontSize: 12.2))),
                  ],
                ),
              )),
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
        'PlatformDispatcher summary: this singleton is the central runtime surface for '
        'platform state and global view metadata. Production-ready interpreter flows can '
        'sample these signals, track snapshots, and adapt behavior without directly coupling '
        'to a specific device profile.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - PlatformDispatcher'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _section('1) Concept overview', 'Core responsibilities of PlatformDispatcher.', Icons.menu_book,
              const Color(0xFF1D4ED8)),
          _conceptCards(),
          _section('2) Control studio', 'Capture and compare platform snapshots.', Icons.tune,
              const Color(0xFF7C3AED)),
          _controlPanel(),
          _section('3) Current state', 'Inspect immediate global runtime values.', Icons.list_alt,
              const Color(0xFF047857)),
          _currentStatePanel(),
          _section('4) Topology map', 'Visualize active views and display relationships.', Icons.account_tree,
              const Color(0xFFB45309)),
          _topologyPanel(),
          _section('5) View details', 'Inspect FlutterView geometry and insets.', Icons.view_quilt,
              const Color(0xFF334155)),
          _viewsPanel(),
          _section('6) Snapshot timeline', 'Track runtime changes chronologically.', Icons.timeline,
              const Color(0xFF0EA5E9)),
          _timelinePanel(),
          _section('7) Probes and guidance', 'Validate behavior and apply best practices.', Icons.fact_check,
              const Color(0xFF166534)),
          _probePanel(),
          _guidancePanel(),
          _logPanel(),
          _summaryPanel(),
        ],
      ),
    );
  }
}

class _DispatcherSnapshot {
  const _DispatcherSnapshot({
    required this.timestamp,
    required this.viewCount,
    required this.displayCount,
    required this.textScaleFactor,
    required this.platformBrightness,
    required this.semanticsEnabled,
    required this.alwaysUse24HourFormat,
    required this.localeLabel,
    required this.localesLabel,
    required this.accessibilitySummary,
    required this.implicitViewPresent,
    required this.frameDataSummary,
  });

  final DateTime timestamp;
  final int viewCount;
  final int displayCount;
  final double textScaleFactor;
  final String platformBrightness;
  final bool semanticsEnabled;
  final bool alwaysUse24HourFormat;
  final String localeLabel;
  final String localesLabel;
  final String accessibilitySummary;
  final bool implicitViewPresent;
  final String frameDataSummary;
}

class _FactRow {
  const _FactRow(this.keyName, this.value);

  final String keyName;
  final String value;
}

class _TopologyPainter extends CustomPainter {
  const _TopologyPainter({
    required this.viewCount,
    required this.displayCount,
    required this.pulse,
    required this.showGrid,
    required this.nodeScale,
    required this.pulseStrength,
    required this.showInsetsOverlay,
  });

  final int viewCount;
  final int displayCount;
  final double pulse;
  final bool showGrid;
  final double nodeScale;
  final double pulseStrength;
  final bool showInsetsOverlay;

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

    final double nodeW = 120 * nodeScale;
    final double nodeH = 54 * nodeScale;
    final Rect root = Rect.fromCenter(center: Offset(size.width * 0.5, 46), width: nodeW, height: nodeH);
    final Rect displays = Rect.fromCenter(center: Offset(size.width * 0.25, 148), width: nodeW, height: nodeH);
    final Rect views = Rect.fromCenter(center: Offset(size.width * 0.75, 148), width: nodeW, height: nodeH);

    void drawNode(Rect r, String text, Color c) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(10)),
        Paint()..color = c.withAlpha((130 + 90 * pulse * pulseStrength).toInt()),
      );
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(text: text, style: const TextStyle(color: Colors.white, fontSize: 11.2, fontWeight: FontWeight.w700)),
      )..layout(maxWidth: r.width - 8);
      tp.paint(canvas, Offset(r.left + (r.width - tp.width) / 2, r.top + (r.height - tp.height) / 2));
    }

    drawNode(root, 'PlatformDispatcher', const Color(0xFF1D4ED8));
    drawNode(views, 'Views\n$viewCount', const Color(0xFF16A34A));

    // Re-draw displays with proper count label in a second call for clarity.
    drawNode(displays, 'Displays\n$displayCount', const Color(0xFF0EA5E9));

    final Paint link = Paint()
      ..color = const Color(0xFF334155)
      ..strokeWidth = 2.6;
    canvas.drawLine(root.bottomCenter, Offset(displays.center.dx, displays.top), link);
    canvas.drawLine(root.bottomCenter, Offset(views.center.dx, views.top), link);

    if (showInsetsOverlay) {
      final Rect overlay = Rect.fromLTWH(size.width * 0.58, size.height * 0.1, size.width * 0.36, size.height * 0.72);
      canvas.drawRRect(
        RRect.fromRectAndRadius(overlay, const Radius.circular(9)),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color(0xFFBE123C)
          ..strokeWidth = 2,
      );
      canvas.drawRect(
        Rect.fromLTWH(overlay.left + 8, overlay.top + 8, overlay.width - 16, overlay.height - 16),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color(0xFFFB7185)
          ..strokeWidth = 1.5,
      );
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: const TextSpan(
          text: 'Insets Overlay',
          style: TextStyle(color: Color(0xFFBE123C), fontSize: 10.8, fontWeight: FontWeight.w700),
        ),
      )..layout(maxWidth: overlay.width - 8);
      tp.paint(canvas, Offset(overlay.left + 6, overlay.top - 16));
    }

    final double arcRadius = 18 + 12 * math.sin(pulse * math.pi * 2).abs();
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - 22),
      arcRadius,
      Paint()..color = const Color(0xFF7C3AED).withAlpha(70),
    );
  }

  @override
  bool shouldRepaint(covariant _TopologyPainter oldDelegate) {
    return oldDelegate.viewCount != viewCount ||
        oldDelegate.displayCount != displayCount ||
        oldDelegate.pulse != pulse ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.nodeScale != nodeScale ||
        oldDelegate.pulseStrength != pulseStrength ||
        oldDelegate.showInsetsOverlay != showInsetsOverlay;
  }
}
