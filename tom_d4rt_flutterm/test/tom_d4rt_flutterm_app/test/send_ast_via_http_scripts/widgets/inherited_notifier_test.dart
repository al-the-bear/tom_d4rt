import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const _cInk = Color(0xFF15354F);
const _cBlue = Color(0xFF2F739D);
const _cTeal = Color(0xFF2F8D79);
const _cAmber = Color(0xFFBD8A45);
const _cRose = Color(0xFF995D78);
const _cViolet = Color(0xFF605DA9);
const _cOlive = Color(0xFF747C43);

dynamic build(BuildContext context) {
  return const _InheritedNotifierStudioApp();
}

class _InheritedNotifierStudioApp extends StatelessWidget {
  const _InheritedNotifierStudioApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cBlue),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _InheritedNotifierStudioPage(),
    );
  }
}

class _InheritedNotifierStudioPage extends StatefulWidget {
  const _InheritedNotifierStudioPage();

  @override
  State<_InheritedNotifierStudioPage> createState() => _InheritedNotifierStudioPageState();
}

class _InheritedNotifierStudioPageState extends State<_InheritedNotifierStudioPage> {
  late final SignalHub _hub;

  bool _compact = false;
  bool _showGrid = true;
  bool _showLabels = true;
  bool _rtl = false;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _hub = SignalHub(label: 'main-hub', seed: 12);
  }

  @override
  void dispose() {
    _hub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      showLabels: _showLabels,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      scale: _scale,
    );

    return SignalScope(
      notifier: _hub,
      child: Directionality(
        textDirection: config.textDirection,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _cInk,
            foregroundColor: Colors.white,
            toolbarHeight: 86,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('InheritedNotifier Deep Demo'),
                const SizedBox(height: 2),
                _HubTopStatus(),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TopControlDeck(
                  compact: _compact,
                  showGrid: _showGrid,
                  showLabels: _showLabels,
                  rtl: _rtl,
                  scale: _scale,
                  onCompactChanged: (v) => setState(() => _compact = v),
                  onShowGridChanged: (v) => setState(() => _showGrid = v),
                  onShowLabelsChanged: (v) => setState(() => _showLabels = v),
                  onRtlChanged: (v) => setState(() => _rtl = v),
                  onScaleChanged: (v) => setState(() => _scale = v),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 1,
                  accent: _cBlue,
                  title: 'What InheritedNotifier Is For',
                  subtitle:
                      'InheritedNotifier combines InheritedWidget dependency tracking with Listenable updates. Dependents rebuild when the notifier emits changes.',
                  child: _ConceptScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 2,
                  accent: _cTeal,
                  title: 'Dependency and Rebuild Propagation',
                  subtitle:
                      'Shows dependent, read-once, and static widgets side by side to visualize who rebuilds when the notifier changes.',
                  child: _PropagationScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 3,
                  accent: _cAmber,
                  title: 'Signal Channels and Interaction Grid',
                  subtitle:
                      'Interactive channel controls demonstrate inherited signal distribution across multiple visual consumers and control widgets.',
                  child: _ChannelGridScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 4,
                  accent: _cRose,
                  title: 'Notifier Swap Semantics',
                  subtitle:
                      'Switches between two notifier instances to illustrate how replacing the notifier changes the inherited source for all dependents.',
                  child: _NotifierSwapScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 5,
                  accent: _cViolet,
                  title: 'Background Updates and Hidden Views',
                  subtitle:
                      'IndexedStack + InheritedNotifier composition showing hidden views still receiving inherited updates while remaining mounted.',
                  child: _BackgroundViewsScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 6,
                  accent: _cOlive,
                  title: 'Practical Multi-Panel Workspace',
                  subtitle:
                      'A realistic operations workspace with inherited shared state for metrics, tasks, timeline, and logs across persistent views.',
                  child: _PracticalWorkspaceScene(config: config),
                ),
                const SizedBox(height: 12),
                const _RecapPanel(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignalHub extends ChangeNotifier {
  SignalHub({required this.label, required int seed}) : _rnd = math.Random(seed) {
    _timer = Timer.periodic(const Duration(milliseconds: 650), (_) => _tick());
  }

  final String label;
  final math.Random _rnd;
  late final Timer _timer;

  int activeView = 0;
  bool alertsEnabled = true;
  bool paused = false;
  double threshold = 0.58;
  int heartbeat = 0;
  String operatorNote = 'Monitor inherited signal behavior';

  final Map<String, double> channels = <String, double>{
    'cpu': 41,
    'memory': 63,
    'queue': 27,
    'latency': 138,
  };

  final List<String> history = <String>[];

  void setActiveView(int index) {
    activeView = index;
    _record('activeView -> $index');
    notifyListeners();
  }

  void setThreshold(double value) {
    threshold = value;
    _record('threshold -> ${value.toStringAsFixed(2)}');
    notifyListeners();
  }

  void setAlerts(bool value) {
    alertsEnabled = value;
    _record('alertsEnabled -> $value');
    notifyListeners();
  }

  void setPaused(bool value) {
    paused = value;
    _record('paused -> $value');
    notifyListeners();
  }

  void setOperatorNote(String value) {
    operatorNote = value;
    _record('operatorNote updated (${value.length} chars)');
    notifyListeners();
  }

  void nudgeChannel(String key, double delta) {
    final current = channels[key] ?? 0;
    channels[key] = (current + delta).clamp(0, 220).toDouble();
    _record('channel[$key] -> ${channels[key]!.toStringAsFixed(1)}');
    notifyListeners();
  }

  void randomizeChannels() {
    channels.updateAll((key, value) => (8 + _rnd.nextDouble() * 180));
    _record('randomize channels');
    notifyListeners();
  }

  void _tick() {
    if (paused) {
      return;
    }
    heartbeat += 1;
    channels['cpu'] = (channels['cpu']! + (_rnd.nextDouble() * 14 - 7)).clamp(0, 100).toDouble();
    channels['memory'] = (channels['memory']! + (_rnd.nextDouble() * 10 - 5)).clamp(0, 100).toDouble();
    channels['queue'] = (channels['queue']! + (_rnd.nextDouble() * 12 - 6)).clamp(0, 100).toDouble();
    channels['latency'] = (channels['latency']! + (_rnd.nextDouble() * 20 - 10)).clamp(60, 220).toDouble();
    if (heartbeat % 6 == 0) {
      _record('tick heartbeat=$heartbeat');
    }
    notifyListeners();
  }

  void _record(String event) {
    history.insert(0, '${_clock()} | $label | $event');
    if (history.length > 44) {
      history.removeRange(44, history.length);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class SignalScope extends InheritedNotifier<SignalHub> {
  const SignalScope({super.key, required super.notifier, required super.child});

  static SignalHub watch(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SignalScope>();
    if (scope == null || scope.notifier == null) {
      throw FlutterError('SignalScope.watch called with no SignalScope in context.');
    }
    return scope.notifier!;
  }

  static SignalHub read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<SignalScope>();
    if (scope == null || scope.notifier == null) {
      throw FlutterError('SignalScope.read called with no SignalScope in context.');
    }
    return scope.notifier!;
  }
}

class _DemoConfig {
  const _DemoConfig({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.textDirection,
    required this.scale,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final TextDirection textDirection;
  final double scale;
}

class _HubTopStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    return Text(
      'hub=${hub.label} | beat=${hub.heartbeat} | alerts=${hub.alertsEnabled} | view=${hub.activeView}',
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}

class _TopControlDeck extends StatelessWidget {
  const _TopControlDeck({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onShowLabelsChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onShowLabelsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173A55), Color(0xFF2B6D83), Color(0xFF5A5CA4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'InheritedNotifier Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const SizedBox(height: 6),
            const Text(
              'InheritedNotifier propagates a Listenable through the widget tree. Widgets that depend via context rebuild when notifier events occur, making it a clean shared-state bridge for medium-granularity app surfaces.',
              style: TextStyle(color: Color(0xFFE5EEF9), height: 1.35),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showGrid,
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showLabels,
                    onChanged: onShowLabelsChanged,
                    title: const Text('Labels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Global scale: ${scale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            Slider(
              value: scale,
              min: 0.75,
              max: 1.4,
              divisions: 13,
              label: scale.toStringAsFixed(2),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.35),
              onChanged: onScaleChanged,
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'dependency tracking'),
                _DeckTag(label: 'notifier propagation'),
                _DeckTag(label: 'rebuild semantics'),
                _DeckTag(label: 'notifier swapping'),
                _DeckTag(label: 'practical workspace state'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeckTag extends StatelessWidget {
  const _DeckTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 6)),
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
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF304454), height: 1.34)),
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

class _ConceptScene extends StatelessWidget {
  const _ConceptScene({required this.config});

  final _DemoConfig config;

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);

    return SizedBox(
      height: config.compact ? 560 : 650,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Concept map', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: config.compact ? 2 : 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.18,
                        children: const [
                          _ConceptTile(
                            title: 'Inherited base',
                            note: 'Widgets call dependOnInheritedWidgetOfExactType through a helper method to become rebuild dependents.',
                            color: _cBlue,
                          ),
                          _ConceptTile(
                            title: 'Notifier source',
                            note: 'The provided ChangeNotifier emits events via notifyListeners, driving inherited updates.',
                            color: _cTeal,
                          ),
                          _ConceptTile(
                            title: 'Scope access',
                            note: 'Use watch methods for reactive rebuilds and read methods for non-reactive snapshots.',
                            color: _cAmber,
                          ),
                          _ConceptTile(
                            title: 'Use case',
                            note: 'Great for medium-sized shared app state where most descendants should react to notifier changes.',
                            color: _cRose,
                          ),
                          _ConceptTile(
                            title: 'Tradeoff',
                            note: 'All dependents rebuild on each notifier event, so split notifiers by concern when needed.',
                            color: _cViolet,
                          ),
                          _ConceptTile(
                            title: 'Interpreter focus',
                            note: 'This demo emphasizes visual propagation and runtime interaction rather than assertion-heavy API checks.',
                            color: _cOlive,
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
            child: _BackdropPanel(
              showGrid: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Live inherited snapshot', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _InfoRow(label: 'label', value: hub.label),
                    _InfoRow(label: 'heartbeat', value: '${hub.heartbeat}'),
                    _InfoRow(label: 'activeView', value: '${hub.activeView}'),
                    _InfoRow(label: 'threshold', value: hub.threshold.toStringAsFixed(2)),
                    _InfoRow(label: 'alertsEnabled', value: '${hub.alertsEnabled}'),
                    const SizedBox(height: 8),
                    const _ReadVsWatchBox(),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quick guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletText(text: 'If widget must update on notifier changes, use watch/depend APIs.'),
                            _BulletText(text: 'If widget only triggers actions, use read/get APIs.'),
                            _BulletText(text: 'Keep notifier focused; split if too many unrelated signals are emitted.'),
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
}

class _ReadVsWatchBox extends StatefulWidget {
  const _ReadVsWatchBox();

  @override
  State<_ReadVsWatchBox> createState() => _ReadVsWatchBoxState();
}

class _ReadVsWatchBoxState extends State<_ReadVsWatchBox> {
  String _snapshot = 'tap refresh';

  @override
  Widget build(BuildContext context) {
    final watched = SignalScope.watch(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: _softBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('watch vs read', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text('watch value heartbeat=${watched.heartbeat}', style: const TextStyle(fontSize: 12)),
          Text('read snapshot: $_snapshot', style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () {
                    final hub = SignalScope.read(context);
                    setState(() => _snapshot = 'beat=${hub.heartbeat}, threshold=${hub.threshold.toStringAsFixed(2)}');
                  },
                  child: const Text('Refresh read snapshot'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConceptTile extends StatelessWidget {
  const _ConceptTile({required this.title, required this.note, required this.color});

  final String title;
  final String note;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(child: Text(note, style: const TextStyle(fontSize: 12, height: 1.3))),
        ],
      ),
    );
  }
}

class _PropagationScene extends StatelessWidget {
  const _PropagationScene({required this.config});

  final _DemoConfig config;

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);

    return SizedBox(
      height: config.compact ? 620 : 740,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Emit notifier events', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => hub.nudgeChannel('cpu', 5),
                            child: const Text('cpu +5'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => hub.nudgeChannel('memory', -4),
                            child: const Text('memory -4'),
                          ),
                          FilledButton.tonal(
                            onPressed: hub.randomizeChannels,
                            child: const Text('randomize'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => hub.setAlerts(!hub.alertsEnabled),
                            child: Text('alerts ${hub.alertsEnabled ? 'off' : 'on'}'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _LabeledSlider(
                        label: 'Threshold',
                        value: hub.threshold,
                        min: 0.1,
                        max: 0.95,
                        onChanged: hub.setThreshold,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expected behavior', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletText(text: 'Dependent cards below rebuild whenever notifier emits.'),
                            _BulletText(text: 'Read-once card keeps old snapshot until manually refreshed.'),
                            _BulletText(text: 'Static card ignores inherited updates completely.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      _HistoryList(lines: hub.history.take(12).toList(growable: false)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          Expanded(child: _DependentProbeCard(title: 'Dependent A', tone: _cBlue)),
                          SizedBox(width: 8),
                          Expanded(child: _DependentProbeCard(title: 'Dependent B', tone: _cTeal)),
                          SizedBox(width: 8),
                          Expanded(child: _ReadOnceProbeCard(title: 'Read Once', tone: _cAmber)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _StaticProbeCard(title: 'Static Panel', tone: _cViolet)),
                          SizedBox(width: 8),
                          Expanded(child: _DependentProbeCard(title: 'Dependent C', tone: _cRose)),
                          SizedBox(width: 8),
                          Expanded(child: _DependentProbeCard(title: 'Dependent D', tone: _cOlive)),
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

class _DependentProbeCard extends StatelessWidget {
  const _DependentProbeCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return _BuildCounterShell(
      title: title,
      tone: tone,
      modeLabel: 'watch()',
      builder: (context, builds) {
        final hub = SignalScope.watch(context);
        final cpu = hub.channels['cpu'] ?? 0;
        final mem = hub.channels['memory'] ?? 0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('beat: ${hub.heartbeat}', style: const TextStyle(fontSize: 12)),
            Text('cpu: ${cpu.toStringAsFixed(1)}', style: const TextStyle(fontSize: 12)),
            Text('memory: ${mem.toStringAsFixed(1)}', style: const TextStyle(fontSize: 12)),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: (cpu / 100).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: tone,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ReadOnceProbeCard extends StatefulWidget {
  const _ReadOnceProbeCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  State<_ReadOnceProbeCard> createState() => _ReadOnceProbeCardState();
}

class _ReadOnceProbeCardState extends State<_ReadOnceProbeCard> {
  String _snapshot = 'tap refresh';

  @override
  Widget build(BuildContext context) {
    return _BuildCounterShell(
      title: widget.title,
      tone: widget.tone,
      modeLabel: 'read()',
      builder: (context, builds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('snapshot: $_snapshot', style: const TextStyle(fontSize: 12, height: 1.3)),
            const Spacer(),
            FilledButton.tonal(
              onPressed: () {
                final hub = SignalScope.read(context);
                setState(() => _snapshot = 'beat=${hub.heartbeat}, latency=${hub.channels['latency']!.toStringAsFixed(1)}');
              },
              child: const Text('Refresh snapshot'),
            ),
          ],
        );
      },
    );
  }
}

class _StaticProbeCard extends StatelessWidget {
  const _StaticProbeCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return _BuildCounterShell(
      title: title,
      tone: tone,
      modeLabel: 'static',
      builder: (context, builds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('No inherited dependency.', style: TextStyle(fontSize: 12)),
            const Text('Only parent setState rebuilds this card.', style: TextStyle(fontSize: 12)),
            const Spacer(),
            const Icon(Icons.do_not_disturb_alt_rounded, size: 28),
          ],
        );
      },
    );
  }
}

class _BuildCounterShell extends StatefulWidget {
  const _BuildCounterShell({
    required this.title,
    required this.tone,
    required this.modeLabel,
    required this.builder,
  });

  final String title;
  final Color tone;
  final String modeLabel;
  final Widget Function(BuildContext context, int builds) builder;

  @override
  State<_BuildCounterShell> createState() => _BuildCounterShellState();
}

class _BuildCounterShellState extends State<_BuildCounterShell> {
  int _builds = 0;

  @override
  Widget build(BuildContext context) {
    _builds += 1;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(widget.modeLabel, style: TextStyle(color: widget.tone.withValues(alpha: 0.85), fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Expanded(child: widget.builder(context, _builds)),
        ],
      ),
    );
  }
}

class _ChannelGridScene extends StatefulWidget {
  const _ChannelGridScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ChannelGridScene> createState() => _ChannelGridSceneState();
}

class _ChannelGridSceneState extends State<_ChannelGridScene> {
  String _selected = 'cpu';
  bool _dense = false;
  bool _bars = true;

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    final config = widget.config;
    final keys = hub.channels.keys.toList(growable: false);

    return SizedBox(
      height: config.compact ? 650 : 770,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Channel control board', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: keys
                          .map(
                            (key) => ChoiceChip(
                              selected: _selected == key,
                              label: Text(key),
                              onSelected: (_) => setState(() => _selected = key),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () => hub.nudgeChannel(_selected, 6),
                            child: const Text('+ pulse'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () => hub.nudgeChannel(_selected, -6),
                            child: const Text('- pulse'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _dense,
                      onChanged: (v) => setState(() => _dense = v),
                      title: const Text('Dense tile mode'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _bars,
                      onChanged: (v) => setState(() => _bars = v),
                      title: const Text('Show progress bars'),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Interpretation', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _BulletText(text: 'All watch widgets rebuild when any notifier event occurs.'),
                          _BulletText(text: 'Use separate notifiers if channels need isolated rebuild domains.'),
                          _BulletText(text: 'Keep notifier updates meaningful to avoid rebuild noise.'),
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
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: keys.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _dense ? 2 : 1,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: _dense ? 1.35 : 2.8,
                  ),
                  itemBuilder: (context, index) {
                    final key = keys[index];
                    final value = hub.channels[key] ?? 0;
                    return _ChannelTile(
                      title: key,
                      value: value,
                      focused: _selected == key,
                      showBar: _bars,
                      tone: _channelColor(index),
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

  Color _channelColor(int index) {
    const palette = [_cBlue, _cTeal, _cAmber, _cRose];
    return palette[index % palette.length];
  }
}

class _ChannelTile extends StatelessWidget {
  const _ChannelTile({
    required this.title,
    required this.value,
    required this.focused,
    required this.showBar,
    required this.tone,
  });

  final String title;
  final double value;
  final bool focused;
  final bool showBar;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final percent = (value / (title == 'latency' ? 220 : 100)).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: focused ? 0.17 : 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: focused ? 0.55 : 0.28), width: focused ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 16))),
              Text(value.toStringAsFixed(1), style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 8),
          if (showBar)
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: tone.withValues(alpha: 0.2)),
              ),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: percent,
                child: Container(
                  decoration: BoxDecoration(color: tone, borderRadius: BorderRadius.circular(999)),
                ),
              ),
            ),
          const Spacer(),
          Text(
            focused ? 'focused signal channel' : 'shared inherited channel',
            style: TextStyle(fontSize: 12, color: tone.withValues(alpha: 0.82)),
          ),
        ],
      ),
    );
  }
}

class _NotifierSwapScene extends StatefulWidget {
  const _NotifierSwapScene({required this.config});

  final _DemoConfig config;

  @override
  State<_NotifierSwapScene> createState() => _NotifierSwapSceneState();
}

class _NotifierSwapSceneState extends State<_NotifierSwapScene> {
  late final SignalHub _alpha;
  late final SignalHub _beta;
  bool _useBeta = false;

  @override
  void initState() {
    super.initState();
    _alpha = SignalHub(label: 'alpha', seed: 91);
    _beta = SignalHub(label: 'beta', seed: 13);
  }

  @override
  void dispose() {
    _alpha.dispose();
    _beta.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final active = _useBeta ? _beta : _alpha;
    final inactive = _useBeta ? _alpha : _beta;

    return SizedBox(
      height: config.compact ? 660 : 780,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Swap controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _useBeta,
                        onChanged: (v) => setState(() => _useBeta = v),
                        title: Text('Use ${_useBeta ? 'beta' : 'alpha'} as active scope'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => active.nudgeChannel('cpu', 8),
                              child: const Text('Active cpu +8'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => inactive.nudgeChannel('cpu', 8),
                              child: const Text('Inactive cpu +8'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => active.randomizeChannels(),
                              child: const Text('Randomize active'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => inactive.randomizeChannels(),
                              child: const Text('Randomize inactive'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Live values', style: TextStyle(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 6),
                            _InfoRow(label: 'active hub', value: active.label),
                            _InfoRow(label: 'active cpu', value: active.channels['cpu']!.toStringAsFixed(1)),
                            _InfoRow(label: 'inactive hub', value: inactive.label),
                            _InfoRow(label: 'inactive cpu', value: inactive.channels['cpu']!.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: SignalScope(
              notifier: active,
              child: _BackdropPanel(
                showGrid: config.showGrid,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Scoped dependents (active notifier only)', style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: _DependentProbeCard(title: 'Scoped A', tone: _cBlue)),
                            SizedBox(width: 8),
                            Expanded(child: _DependentProbeCard(title: 'Scoped B', tone: _cTeal)),
                            SizedBox(width: 8),
                            Expanded(child: _DependentProbeCard(title: 'Scoped C', tone: _cRose)),
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
    );
  }
}

class _BackgroundViewsScene extends StatefulWidget {
  const _BackgroundViewsScene({required this.config});

  final _DemoConfig config;

  @override
  State<_BackgroundViewsScene> createState() => _BackgroundViewsSceneState();
}

class _BackgroundViewsSceneState extends State<_BackgroundViewsScene> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 680 : 800,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hidden view behavior', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 0, label: Text('Overview')),
                        ButtonSegment(value: 1, label: Text('Graphs')),
                        ButtonSegment(value: 2, label: Text('Alerts')),
                      ],
                      selected: {_index},
                      onSelectionChanged: (v) => setState(() => _index = v.first),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: hub.paused,
                      onChanged: hub.setPaused,
                      title: const Text('Pause inherited ticker'),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Current inherited values', style: TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          _InfoRow(label: 'heartbeat', value: '${hub.heartbeat}'),
                          _InfoRow(label: 'cpu', value: hub.channels['cpu']!.toStringAsFixed(1)),
                          _InfoRow(label: 'memory', value: hub.channels['memory']!.toStringAsFixed(1)),
                          _InfoRow(label: 'queue', value: hub.channels['queue']!.toStringAsFixed(1)),
                          _InfoRow(label: 'latency', value: hub.channels['latency']!.toStringAsFixed(1)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Switch between tabs. Even hidden tabs stay mounted in IndexedStack and keep observing inherited notifier updates.',
                      style: TextStyle(fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IndexedStack(
                  index: _index,
                  children: const [
                    _BackgroundTab(title: 'Overview', tone: _cBlue),
                    _BackgroundTab(title: 'Graphs', tone: _cTeal),
                    _BackgroundTab(title: 'Alerts', tone: _cViolet),
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

class _BackgroundTab extends StatefulWidget {
  const _BackgroundTab({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  State<_BackgroundTab> createState() => _BackgroundTabState();
}

class _BackgroundTabState extends State<_BackgroundTab> {
  int _observedBuilds = 0;
  final List<int> _beats = <int>[];

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    _observedBuilds += 1;
    _beats.insert(0, hub.heartbeat);
    if (_beats.length > 22) {
      _beats.removeRange(22, _beats.length);
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.tone.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 18)),
              ),
              Text('build $_observedBuilds', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Text('latest heartbeat: ${hub.heartbeat}', style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: widget.tone.withValues(alpha: 0.22)),
              ),
              child: ListView.builder(
                itemCount: _beats.length,
                itemBuilder: (context, index) {
                  return Text('beat ${_beats[index]}', style: const TextStyle(fontSize: 12, fontFamily: 'monospace'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticalWorkspaceScene extends StatefulWidget {
  const _PracticalWorkspaceScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalWorkspaceScene> createState() => _PracticalWorkspaceSceneState();
}

class _PracticalWorkspaceSceneState extends State<_PracticalWorkspaceScene> {
  int _index = 0;
  bool _compactRail = false;
  bool _highContrast = false;
  bool _showMeta = true;

  final List<String> _events = <String>[];

  late final List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _views = [
      _SharedMetricsView(onEvent: _event),
      _SharedTasksView(onEvent: _event),
      _SharedTimelineView(onEvent: _event),
      _SharedLogsView(onEvent: _event),
    ];
  }

  void _event(String line) {
    setState(() {
      _events.insert(0, '${_clock()} | $line');
      if (_events.length > 30) {
        _events.removeRange(30, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final hub = SignalScope.watch(context);
    final labels = ['Metrics', 'Tasks', 'Timeline', 'Logs'];

    return SizedBox(
      height: config.compact ? 850 : 1020,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        labels.length,
                        (i) => ChoiceChip(
                          selected: _index == i,
                          label: Text(labels[i]),
                          onSelected: (_) {
                            setState(() => _index = i);
                            hub.setActiveView(i);
                            _event('workspace -> ${labels[i]}');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _compactRail,
                          label: const Text('Compact rail'),
                          onSelected: (v) => setState(() => _compactRail = v),
                        ),
                        FilterChip(
                          selected: _highContrast,
                          label: const Text('High contrast'),
                          onSelected: (v) => setState(() => _highContrast = v),
                        ),
                        FilterChip(
                          selected: _showMeta,
                          label: const Text('Show metadata strip'),
                          onSelected: (v) => setState(() => _showMeta = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _highContrast ? const Color(0xFF1D2831) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD8E2EE)),
                        ),
                        child: Column(
                          children: [
                            _workspaceTop(_highContrast),
                            Expanded(
                              child: Row(
                                children: [
                                  _workspaceRail(_compactRail, _highContrast, labels),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        if (_showMeta) _workspaceMeta(_highContrast, labels[_index]),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: IndexedStack(index: _index, children: _views),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _workspaceFooter(_highContrast, hub.heartbeat),
                          ],
                        ),
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
            child: _EventPanel(title: 'Workspace event log', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _workspaceTop(bool highContrast) {
    final fg = highContrast ? Colors.white : _cInk;
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _cOlive.withValues(alpha: highContrast ? 0.22 : 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.dashboard_customize_rounded, color: _cOlive),
          const SizedBox(width: 8),
          Text('Inherited Workspace', style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          Text('shared hub across all views', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _workspaceRail(bool compact, bool highContrast, List<String> labels) {
    final fg = highContrast ? Colors.white : _cInk;
    return Container(
      width: compact ? 72 : 108,
      decoration: BoxDecoration(
        color: highContrast ? const Color(0xFF24313A) : const Color(0xFFF8FBFF),
        border: const Border(right: BorderSide(color: Color(0xFFD8E2EE))),
      ),
      child: ListView.builder(
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final selected = _index == index;
          return InkWell(
            onTap: () {
              setState(() => _index = index);
              SignalScope.read(context).setActiveView(index);
              _event('rail -> ${labels[index]}');
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              decoration: BoxDecoration(
                color: selected ? _cOlive.withValues(alpha: 0.24) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: selected ? _cOlive.withValues(alpha: 0.45) : Colors.transparent),
              ),
              child: Column(
                children: [
                  Icon(_workspaceIcons[index], color: selected ? _cOlive : fg.withValues(alpha: 0.8), size: compact ? 18 : 20),
                  if (!compact) ...[
                    const SizedBox(height: 3),
                    Text(labels[index], style: TextStyle(color: fg, fontSize: 10), textAlign: TextAlign.center),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _workspaceMeta(bool highContrast, String activeLabel) {
    final fg = highContrast ? Colors.white : _cInk;
    final hub = SignalScope.watch(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: highContrast ? const Color(0xFF22313E) : const Color(0xFFEAF2FA),
        border: const Border(bottom: BorderSide(color: Color(0xFFD8E2EE))),
      ),
      child: Row(
        children: [
          Text('active: $activeLabel', style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('threshold ${hub.threshold.toStringAsFixed(2)} | beat ${hub.heartbeat}', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _workspaceFooter(bool highContrast, int heartbeat) {
    final fg = highContrast ? Colors.white : _cInk;
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: highContrast ? const Color(0xFF22313E) : const Color(0xFFF8FAFD),
        border: const Border(top: BorderSide(color: Color(0xFFD8E2EE))),
      ),
      child: Row(
        children: [
          Text('Inherited footer', style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12)),
          const Spacer(),
          Text('heartbeat $heartbeat', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }
}

const _workspaceIcons = <IconData>[
  Icons.dashboard_rounded,
  Icons.task_alt_rounded,
  Icons.timeline_rounded,
  Icons.receipt_long_rounded,
];

class _SharedMetricsView extends StatefulWidget {
  const _SharedMetricsView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_SharedMetricsView> createState() => _SharedMetricsViewState();
}

class _SharedMetricsViewState extends State<_SharedMetricsView> {
  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cBlue.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cBlue.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Metrics View', style: TextStyle(color: _cBlue, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          _LabeledSlider(
            label: 'Threshold',
            value: hub.threshold,
            min: 0.1,
            max: 0.95,
            onChanged: (v) {
              hub.setThreshold(v);
              widget.onEvent('threshold changed in Metrics view');
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _MetricBox(title: 'cpu', value: hub.channels['cpu']!.toStringAsFixed(1), tone: _cBlue)),
                const SizedBox(width: 8),
                Expanded(child: _MetricBox(title: 'memory', value: hub.channels['memory']!.toStringAsFixed(1), tone: _cTeal)),
                const SizedBox(width: 8),
                Expanded(child: _MetricBox(title: 'queue', value: hub.channels['queue']!.toStringAsFixed(1), tone: _cAmber)),
                const SizedBox(width: 8),
                Expanded(child: _MetricBox(title: 'latency', value: hub.channels['latency']!.toStringAsFixed(1), tone: _cRose)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SharedTasksView extends StatefulWidget {
  const _SharedTasksView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_SharedTasksView> createState() => _SharedTasksViewState();
}

class _SharedTasksViewState extends State<_SharedTasksView> {
  final List<_Task> _tasks = List<_Task>.generate(10, (i) => _Task('Task ${i + 1}', i.isEven && i % 3 == 0));

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    final done = _tasks.where((t) => t.done).length;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cTeal.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cTeal.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tasks View ($done/${_tasks.length})', style: const TextStyle(color: _cTeal, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 6),
          Text('alertsEnabled = ${hub.alertsEnabled}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final t = _tasks[index];
                return CheckboxListTile(
                  value: t.done,
                  onChanged: (v) {
                    setState(() => t.done = v ?? false);
                    widget.onEvent('task ${t.name} toggled');
                    if (!hub.alertsEnabled && !t.done) {
                      hub.setAlerts(true);
                      widget.onEvent('alerts auto-enabled from Tasks view');
                    }
                  },
                  title: Text(t.name),
                  subtitle: Text(t.done ? 'done' : 'pending'),
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Task {
  _Task(this.name, this.done);

  final String name;
  bool done;
}

class _SharedTimelineView extends StatefulWidget {
  const _SharedTimelineView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_SharedTimelineView> createState() => _SharedTimelineViewState();
}

class _SharedTimelineViewState extends State<_SharedTimelineView> {
  double _progress = 0.34;
  bool _milestones = true;

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cAmber.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cAmber.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timeline View', style: TextStyle(color: _cAmber, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 6),
          Text('heartbeat ${hub.heartbeat}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 8),
          _LabeledSlider(
            label: 'Program progress',
            value: _progress,
            min: 0,
            max: 1,
            onChanged: (v) {
              setState(() => _progress = v);
              widget.onEvent('timeline progress ${(v * 100).toStringAsFixed(1)}%');
            },
          ),
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: _milestones,
            onChanged: (v) {
              setState(() => _milestones = v);
              widget.onEvent('timeline milestones $v');
            },
            title: const Text('Show milestones'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _TimelinePainter(progress: _progress, milestones: _milestones),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  const _TimelinePainter({required this.progress, required this.milestones});

  final double progress;
  final bool milestones;

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..color = const Color(0xFFC7D7E6)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = _cAmber
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final y = size.height * 0.52;
    canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), base);
    canvas.drawLine(Offset(20, y), Offset(20 + (size.width - 40) * progress, y), fill);

    if (milestones) {
      for (int i = 0; i <= 4; i++) {
        final x = 20 + ((size.width - 40) * (i / 4));
        canvas.drawCircle(Offset(x, y), 6, Paint()..color = i / 4 <= progress ? _cAmber : const Color(0xFF9FB0C2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.milestones != milestones;
  }
}

class _SharedLogsView extends StatefulWidget {
  const _SharedLogsView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_SharedLogsView> createState() => _SharedLogsViewState();
}

class _SharedLogsViewState extends State<_SharedLogsView> {
  final List<String> _lines = List<String>.generate(24, (i) => 'boot log ${i + 1}: module ${1 + (i % 5)} init ok');
  late final ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hub = SignalScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cRose.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cRose.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Logs View', style: TextStyle(color: _cRose, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 6),
          Text('activeView in hub = ${hub.activeView}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton.tonal(
                onPressed: () {
                  setState(() => _lines.add('event ${_lines.length + 1} @ ${_clock()}')); 
                  widget.onEvent('log appended');
                },
                child: const Text('Append log'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  if (_lines.isNotEmpty) {
                    setState(() => _lines.removeLast());
                    widget.onEvent('log removed');
                  }
                },
                child: const Text('Remove last'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2732),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                controller: _scroll,
                itemCount: _lines.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      _lines[index],
                      style: TextStyle(
                        color: index.isEven ? const Color(0xFFB7CBDB) : const Color(0xFF8EB9DE),
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  const _MetricBox({required this.title, required this.value, required this.tone});

  final String title;
  final String value;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.26)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 18)),
        ],
      ),
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E2EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notifier history', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (lines.isEmpty)
            const Text('No events yet.', style: TextStyle(color: Color(0xFF5F7488)))
          else
            ...lines.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(line, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _BackdropPanel extends StatelessWidget {
  const _BackdropPanel({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD7E2EE)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FCFF), Color(0xFFEDF3FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid) const CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x11000000);
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

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _EventPanel extends StatelessWidget {
  const _EventPanel({required this.title, required this.events});

  final String title;
  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E2EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No interactions yet.', style: TextStyle(color: Color(0xFF607489)))
          else
            ...events.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(line, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF3C5E78)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.34))),
        ],
      ),
    );
  }
}

BoxDecoration _softBox() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF16344E), borderRadius: BorderRadius.circular(14)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: InheritedNotifier', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'InheritedNotifier is a practical bridge for reactive shared state in widget trees. Dependents rebuild through inherited dependency tracking whenever the notifier emits, enabling structured, visual state propagation with predictable scope boundaries.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.36),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
