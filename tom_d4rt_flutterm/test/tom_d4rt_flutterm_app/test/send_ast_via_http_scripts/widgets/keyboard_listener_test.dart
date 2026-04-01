import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kBg = Color(0xFF0F1722);
const _kSurface = Color(0xFF151F2D);
const _kSurfaceAlt = Color(0xFF1A2838);
const _kFrame = Color(0xFF30465F);
const _kText = Color(0xFFE8F2FF);
const _kMuted = Color(0xFF9DB2C7);
const _kCyan = Color(0xFF4AC6D9);
const _kMint = Color(0xFF51D69E);
const _kAmber = Color(0xFFF0B85A);
const _kRose = Color(0xFFE078A7);
const _kViolet = Color(0xFFA58AF1);

dynamic build(BuildContext context) {
  return const _KeyboardListenerDeepDemoApp();
}

class _KeyboardListenerDeepDemoApp extends StatelessWidget {
  const _KeyboardListenerDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _kCyan, brightness: Brightness.dark),
        scaffoldBackgroundColor: _kBg,
      ),
      home: const _KeyboardListenerDeepDemoPage(),
    );
  }
}

class _KeyboardListenerDeepDemoPage extends StatefulWidget {
  const _KeyboardListenerDeepDemoPage();

  @override
  State<_KeyboardListenerDeepDemoPage> createState() => _KeyboardListenerDeepDemoPageState();
}

class _KeyboardListenerDeepDemoPageState extends State<_KeyboardListenerDeepDemoPage> {
  bool _compact = false;
  bool _guide = true;
  bool _showTips = true;
  bool _rtl = false;
  double _intensity = 0.62;

  final List<String> _globalEvents = <String>[];

  void _pushGlobal(String text) {
    setState(() {
      _globalEvents.insert(0, '${_clock()} | $text');
      if (_globalEvents.length > 60) {
        _globalEvents.removeRange(60, _globalEvents.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final direction = _rtl ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: direction,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0C1522),
          foregroundColor: _kText,
          toolbarHeight: 84,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('KeyboardListener Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'visual keyboard labs | focus routes | onKeyEvent streams | interpreter interaction testing',
                style: TextStyle(color: _kMuted.withValues(alpha: 0.95), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ControlDeck(
                compact: _compact,
                guide: _guide,
                showTips: _showTips,
                rtl: _rtl,
                intensity: _intensity,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuideChanged: (v) => setState(() => _guide = v),
                onShowTipsChanged: (v) => setState(() => _showTips = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onIntensityChanged: (v) => setState(() => _intensity = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _kCyan,
                title: 'Focus Arena and Receiver Routing',
                subtitle:
                    'Multiple KeyboardListener zones with independent FocusNodes. Visual focus rings show exactly which listener receives key events.',
                child: _FocusArenaScene(
                  compact: _compact,
                  guide: _guide,
                  showTips: _showTips,
                  intensity: _intensity,
                  onEvent: _pushGlobal,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _kMint,
                title: 'Key Stream Analyzer',
                subtitle:
                    'Captures KeyDownEvent and KeyUpEvent metadata including logical key, physical key, repeat signals, and event timing deltas.',
                child: _KeyStreamAnalyzerScene(
                  compact: _compact,
                  guide: _guide,
                  showTips: _showTips,
                  onEvent: _pushGlobal,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _kAmber,
                title: 'Shortcut Console and Command Pads',
                subtitle:
                    'KeyboardListener-driven commands update visual systems: cursor movement, toggles, overlays, and mode switches.',
                child: _ShortcutConsoleScene(
                  compact: _compact,
                  guide: _guide,
                  showTips: _showTips,
                  onEvent: _pushGlobal,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _kRose,
                title: 'Nested Boundary and Propagation Lab',
                subtitle:
                    'Demonstrates nested listeners, focus handoff, and branch-local handling patterns in a layered keyboard interaction topology.',
                child: _BoundaryLabScene(
                  compact: _compact,
                  guide: _guide,
                  showTips: _showTips,
                  onEvent: _pushGlobal,
                ),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _kViolet,
                title: 'Practical Keyboard Workspace',
                subtitle:
                    'A realistic keyboard-first workspace where sections are controlled and navigated entirely via key events through KeyboardListener.',
                child: _PracticalWorkspaceScene(
                  compact: _compact,
                  guide: _guide,
                  showTips: _showTips,
                  intensity: _intensity,
                  onEvent: _pushGlobal,
                ),
              ),
              const SizedBox(height: 12),
              _GlobalEventPanel(events: _globalEvents),
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

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.guide,
    required this.showTips,
    required this.rtl,
    required this.intensity,
    required this.onCompactChanged,
    required this.onGuideChanged,
    required this.onShowTipsChanged,
    required this.onRtlChanged,
    required this.onIntensityChanged,
  });

  final bool compact;
  final bool guide;
  final bool showTips;
  final bool rtl;
  final double intensity;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuideChanged;
  final ValueChanged<bool> onShowTipsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onIntensityChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0E1C2C), Color(0xFF123149), Color(0xFF294364), Color(0xFF4A3A70)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF2E4D6B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Keyboard Interaction Command Deck',
            style: TextStyle(color: _kText, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'This demo focuses on KeyboardListener event routing and UI interaction behavior. '
            'Use Tab, arrows, letters, Enter, Space, and Escape in each scene to see targeted responses.',
            style: TextStyle(color: Color(0xFFCCE0F2), height: 1.35),
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
                  title: const Text('Compact scene heights', style: TextStyle(color: _kText, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: guide,
                  onChanged: onGuideChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide grid overlays', style: TextStyle(color: _kText, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: showTips,
                  onChanged: onShowTipsChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show key hints', style: TextStyle(color: _kText, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: _kText, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Visual intensity: ${intensity.toStringAsFixed(2)}',
            style: const TextStyle(color: _kText, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: intensity,
            min: 0.2,
            max: 1,
            divisions: 16,
            onChanged: onIntensityChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.28),
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
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kFrame),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 14, offset: const Offset(0, 8)),
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
                  foregroundColor: Colors.black,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w900)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontSize: 19, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: _kMuted, height: 1.34)),
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

class _FocusArenaScene extends StatefulWidget {
  const _FocusArenaScene({
    required this.compact,
    required this.guide,
    required this.showTips,
    required this.intensity,
    required this.onEvent,
  });

  final bool compact;
  final bool guide;
  final bool showTips;
  final double intensity;
  final ValueChanged<String> onEvent;

  @override
  State<_FocusArenaScene> createState() => _FocusArenaSceneState();
}

class _FocusArenaSceneState extends State<_FocusArenaScene> {
  final FocusNode _nodeA = FocusNode(debugLabel: 'focus-zone-A');
  final FocusNode _nodeB = FocusNode(debugLabel: 'focus-zone-B');
  final FocusNode _nodeC = FocusNode(debugLabel: 'focus-zone-C');

  int _active = 0;
  String _lastA = 'none';
  String _lastB = 'none';
  String _lastC = 'none';
  int _countA = 0;
  int _countB = 0;
  int _countC = 0;

  @override
  void dispose() {
    _nodeA.dispose();
    _nodeB.dispose();
    _nodeC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 640.0 : 760.0;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _DarkPanel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Focus routing controls', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              _nodeA.requestFocus();
                              setState(() => _active = 0);
                              widget.onEvent('focus requested -> Zone A');
                            },
                            child: const Text('Focus A'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              _nodeB.requestFocus();
                              setState(() => _active = 1);
                              widget.onEvent('focus requested -> Zone B');
                            },
                            child: const Text('Focus B'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              _nodeC.requestFocus();
                              setState(() => _active = 2);
                              widget.onEvent('focus requested -> Zone C');
                            },
                            child: const Text('Focus C'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _active = -1);
                        widget.onEvent('focus cleared from all zones');
                      },
                      child: const Text('Clear focus'),
                    ),
                    const SizedBox(height: 8),
                    _StatusTable(
                      rows: [
                        _StatusRow(name: 'Zone A', last: _lastA, count: _countA, focused: _active == 0, tone: _kCyan),
                        _StatusRow(name: 'Zone B', last: _lastB, count: _countB, focused: _active == 1, tone: _kMint),
                        _StatusRow(name: 'Zone C', last: _lastC, count: _countC, focused: _active == 2, tone: _kAmber),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.showTips)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _tipBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Try these keys', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _TipLine(text: 'Tab cycles focus naturally between controls.'),
                            _TipLine(text: 'Type letters to see zone-specific event capture.'),
                            _TipLine(text: 'Arrow keys and Enter produce distinct labels.'),
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
            child: _DarkPanel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _FocusZoneCard(
                        title: 'Zone A',
                        focusNode: _nodeA,
                        tone: _kCyan,
                        intensity: widget.intensity,
                        focused: _active == 0,
                        onKey: (event) {
                          final label = _labelFor(event);
                          setState(() {
                            _lastA = label;
                            _countA += 1;
                            _active = 0;
                          });
                          widget.onEvent('Zone A <- $label');
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FocusZoneCard(
                        title: 'Zone B',
                        focusNode: _nodeB,
                        tone: _kMint,
                        intensity: widget.intensity,
                        focused: _active == 1,
                        onKey: (event) {
                          final label = _labelFor(event);
                          setState(() {
                            _lastB = label;
                            _countB += 1;
                            _active = 1;
                          });
                          widget.onEvent('Zone B <- $label');
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FocusZoneCard(
                        title: 'Zone C',
                        focusNode: _nodeC,
                        tone: _kAmber,
                        intensity: widget.intensity,
                        focused: _active == 2,
                        onKey: (event) {
                          final label = _labelFor(event);
                          setState(() {
                            _lastC = label;
                            _countC += 1;
                            _active = 2;
                          });
                          widget.onEvent('Zone C <- $label');
                        },
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

  String _labelFor(KeyEvent event) {
    final kind = event is KeyDownEvent
        ? 'down'
        : event is KeyUpEvent
            ? 'up'
            : 'repeat';
    final key = event.logicalKey.keyLabel.isEmpty ? event.logicalKey.debugName ?? 'unknown' : event.logicalKey.keyLabel;
    return '$kind:$key';
  }
}

class _FocusZoneCard extends StatefulWidget {
  const _FocusZoneCard({
    required this.title,
    required this.focusNode,
    required this.tone,
    required this.intensity,
    required this.focused,
    required this.onKey,
  });

  final String title;
  final FocusNode focusNode;
  final Color tone;
  final double intensity;
  final bool focused;
  final ValueChanged<KeyEvent> onKey;

  @override
  State<_FocusZoneCard> createState() => _FocusZoneCardState();
}

class _FocusZoneCardState extends State<_FocusZoneCard> {
  final List<String> _local = <String>[];

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: widget.focusNode,
      onKeyEvent: (event) {
        widget.onKey(event);
        final label = event.logicalKey.keyLabel.isEmpty ? event.logicalKey.debugName ?? 'unknown' : event.logicalKey.keyLabel;
        final type = event is KeyDownEvent
            ? 'D'
            : event is KeyUpEvent
                ? 'U'
                : 'R';
        setState(() {
          _local.insert(0, '$type:$label');
          if (_local.length > 12) {
            _local.removeRange(12, _local.length);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kSurfaceAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.focused ? widget.tone : _kFrame,
            width: widget.focused ? 2.4 : 1.2,
          ),
          boxShadow: [
            if (widget.focused)
              BoxShadow(color: widget.tone.withValues(alpha: 0.35 * widget.intensity), blurRadius: 14, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              widget.focused ? 'Focused: receiving keys' : 'Idle: click or button-focus to activate',
              style: TextStyle(color: widget.focused ? _kText : _kMuted, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: widget.tone.withValues(alpha: 0.26)),
                ),
                child: _local.isEmpty
                    ? const Text('No key events yet.', style: TextStyle(color: _kMuted))
                    : Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: _local
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  color: widget.tone.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(color: widget.tone.withValues(alpha: 0.38)),
                                ),
                                child: Text(e, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700, fontSize: 11)),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyStreamAnalyzerScene extends StatefulWidget {
  const _KeyStreamAnalyzerScene({
    required this.compact,
    required this.guide,
    required this.showTips,
    required this.onEvent,
  });

  final bool compact;
  final bool guide;
  final bool showTips;
  final ValueChanged<String> onEvent;

  @override
  State<_KeyStreamAnalyzerScene> createState() => _KeyStreamAnalyzerSceneState();
}

class _KeyStreamAnalyzerSceneState extends State<_KeyStreamAnalyzerScene> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'key-stream-analyzer');
  final List<_KeyRecord> _records = <_KeyRecord>[];

  bool _captureDown = true;
  bool _captureUp = true;
  bool _captureRepeats = true;
  int _view = 0;

  DateTime? _previousStamp;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 720.0 : 860.0;
    final downCount = _records.where((r) => r.type == 'down').length;
    final upCount = _records.where((r) => r.type == 'up').length;
    final repeatCount = _records.where((r) => r.type == 'repeat').length;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _DarkPanel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Analyzer controls', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () {
                          _focusNode.requestFocus();
                          widget.onEvent('stream analyzer focus requested');
                        },
                        child: const Text('Focus analyzer input surface'),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Table')),
                          ButtonSegment(value: 1, label: Text('Heatmap')),
                          ButtonSegment(value: 2, label: Text('Timeline')),
                        ],
                        selected: {_view},
                        onSelectionChanged: (s) => setState(() => _view = s.first),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _captureDown,
                        onChanged: (v) => setState(() => _captureDown = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Capture KeyDownEvent', style: TextStyle(color: _kText)),
                      ),
                      SwitchListTile(
                        value: _captureUp,
                        onChanged: (v) => setState(() => _captureUp = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Capture KeyUpEvent', style: TextStyle(color: _kText)),
                      ),
                      SwitchListTile(
                        value: _captureRepeats,
                        onChanged: (v) => setState(() => _captureRepeats = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Capture repeat events', style: TextStyle(color: _kText)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: _MetricTile(label: 'down', value: '$downCount', tone: _kCyan)),
                          const SizedBox(width: 8),
                          Expanded(child: _MetricTile(label: 'up', value: '$upCount', tone: _kMint)),
                          const SizedBox(width: 8),
                          Expanded(child: _MetricTile(label: 'repeat', value: '$repeatCount', tone: _kAmber)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () {
                          setState(() => _records.clear());
                          widget.onEvent('stream analyzer records cleared');
                        },
                        child: const Text('Clear captured records'),
                      ),
                      const SizedBox(height: 8),
                      if (widget.showTips)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: _tipBox(),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Analyzer usage notes', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              _TipLine(text: 'logicalKey is semantic (for shortcuts).'),
                              _TipLine(text: 'physicalKey is hardware-location oriented.'),
                              _TipLine(text: 'delta measures spacing between events in milliseconds.'),
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
            child: KeyboardListener(
              focusNode: _focusNode,
              onKeyEvent: _onKey,
              child: _DarkPanel(
                guide: widget.guide,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: IndexedStack(
                    index: _view,
                    children: [
                      _RecordTable(records: _records),
                      _RecordHeatmap(records: _records),
                      _RecordTimeline(records: _records),
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

  void _onKey(KeyEvent event) {
    final type = event is KeyDownEvent
        ? 'down'
        : event is KeyUpEvent
            ? 'up'
            : 'repeat';

    if (type == 'down' && !_captureDown) {
      return;
    }
    if (type == 'up' && !_captureUp) {
      return;
    }
    if (type == 'repeat' && !_captureRepeats) {
      return;
    }

    final now = DateTime.now();
    final delta = _previousStamp == null ? 0 : now.difference(_previousStamp!).inMilliseconds;
    _previousStamp = now;

    final logical = event.logicalKey.keyLabel.isEmpty ? event.logicalKey.debugName ?? 'unknown' : event.logicalKey.keyLabel;
    final physical = event.physicalKey.debugName ?? 'unknown';

    setState(() {
      _records.insert(
        0,
        _KeyRecord(
          stamp: _clock(),
          type: type,
          logical: logical,
          physical: physical,
          deltaMs: delta,
          keyId: event.logicalKey.keyId,
        ),
      );
      if (_records.length > 120) {
        _records.removeRange(120, _records.length);
      }
    });

    widget.onEvent('stream:$type:$logical (${delta}ms)');
  }
}

class _KeyRecord {
  const _KeyRecord({
    required this.stamp,
    required this.type,
    required this.logical,
    required this.physical,
    required this.deltaMs,
    required this.keyId,
  });

  final String stamp;
  final String type;
  final String logical;
  final String physical;
  final int deltaMs;
  final int keyId;
}

class _RecordTable extends StatelessWidget {
  const _RecordTable({required this.records});

  final List<_KeyRecord> records;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const _EmptyState(text: 'No records captured yet. Focus this area and press keys.');
    }

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final r = records[index];
        final tone = r.type == 'down'
            ? _kCyan
            : r.type == 'up'
                ? _kMint
                : _kAmber;
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: tone.withValues(alpha: 0.42)),
          ),
          child: Row(
            children: [
              SizedBox(width: 72, child: Text(r.stamp, style: const TextStyle(color: _kMuted, fontFamily: 'monospace', fontSize: 11))),
              SizedBox(
                width: 62,
                child: Text(r.type, style: TextStyle(color: tone, fontWeight: FontWeight.w700)),
              ),
              Expanded(
                child: Text('logical: ${r.logical} | physical: ${r.physical}', style: const TextStyle(color: _kText, fontSize: 12)),
              ),
              SizedBox(width: 82, child: Text('${r.deltaMs} ms', style: const TextStyle(color: _kMuted))),
            ],
          ),
        );
      },
    );
  }
}

class _RecordHeatmap extends StatelessWidget {
  const _RecordHeatmap({required this.records});

  final List<_KeyRecord> records;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const _EmptyState(text: 'Heatmap appears after events are captured.');
    }

    final counts = <String, int>{};
    for (final r in records) {
      counts[r.logical] = (counts[r.logical] ?? 0) + 1;
    }
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.45,
      children: entries.map((entry) {
        final intensity = (entry.value / (entries.first.value == 0 ? 1 : entries.first.value)).clamp(0.0, 1.0);
        final tone = Color.lerp(_kSurfaceAlt, _kCyan, intensity)!;
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kCyan.withValues(alpha: 0.45 + (intensity * 0.4))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.key, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _kText, fontWeight: FontWeight.w800)),
              const Spacer(),
              Text('${entry.value} events', style: const TextStyle(color: _kMuted)),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: _kCyan.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                ),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: intensity,
                  child: Container(
                    decoration: BoxDecoration(color: _kCyan, borderRadius: BorderRadius.circular(999)),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _RecordTimeline extends StatelessWidget {
  const _RecordTimeline({required this.records});

  final List<_KeyRecord> records;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const _EmptyState(text: 'Timeline appears after events are captured.');
    }

    final sliced = records.take(40).toList().reversed.toList();
    return ListView.builder(
      itemCount: sliced.length,
      itemBuilder: (context, index) {
        final r = sliced[index];
        final tone = r.type == 'down'
            ? _kCyan
            : r.type == 'up'
                ? _kMint
                : _kAmber;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 68, child: Text(r.stamp, style: const TextStyle(color: _kMuted, fontFamily: 'monospace', fontSize: 11))),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kSurfaceAlt,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tone.withValues(alpha: 0.42)),
                ),
                child: Text(
                  '${r.type.toUpperCase()} ${r.logical} (${r.deltaMs} ms)\nphysical: ${r.physical}',
                  style: const TextStyle(color: _kText, height: 1.28),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShortcutConsoleScene extends StatefulWidget {
  const _ShortcutConsoleScene({
    required this.compact,
    required this.guide,
    required this.showTips,
    required this.onEvent,
  });

  final bool compact;
  final bool guide;
  final bool showTips;
  final ValueChanged<String> onEvent;

  @override
  State<_ShortcutConsoleScene> createState() => _ShortcutConsoleSceneState();
}

class _ShortcutConsoleSceneState extends State<_ShortcutConsoleScene> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'shortcut-console');

  int _x = 2;
  int _y = 2;
  bool _overlay = false;
  bool _pulse = false;
  int _mode = 0;
  final List<String> _commands = <String>[];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 740.0 : 870.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _DarkPanel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shortcut controls', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () {
                          _focusNode.requestFocus();
                          widget.onEvent('shortcut console focus requested');
                        },
                        child: const Text('Focus command surface'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => _execute('reset'),
                              child: const Text('Reset state'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => _execute('random'),
                              child: const Text('Randomize cursor'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _MetricTile(label: 'cursor', value: '($_x,$_y)', tone: _kCyan),
                      const SizedBox(height: 8),
                      _MetricTile(label: 'mode', value: '${_mode + 1}', tone: _kMint),
                      const SizedBox(height: 8),
                      _MetricTile(label: 'overlay', value: _overlay ? 'ON' : 'OFF', tone: _kAmber),
                      const SizedBox(height: 8),
                      if (widget.showTips)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: _tipBox(),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Key bindings', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              _TipLine(text: 'Arrow keys move cursor on 5x5 board.'),
                              _TipLine(text: 'Enter cycles mode panel.'),
                              _TipLine(text: 'Space toggles overlay.'),
                              _TipLine(text: 'P toggles pulse, R resets, X randomizes.'),
                              _TipLine(text: 'Escape clears command history.'),
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
            child: KeyboardListener(
              focusNode: _focusNode,
              onKeyEvent: _handle,
              child: _DarkPanel(
                guide: widget.guide,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: _CursorBoard(
                          x: _x,
                          y: _y,
                          pulse: _pulse,
                          overlay: _overlay,
                          mode: _mode,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        flex: 4,
                        child: _CommandHistory(commands: _commands),
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

  void _execute(String command) {
    setState(() {
      switch (command) {
        case 'reset':
          _x = 2;
          _y = 2;
          _overlay = false;
          _pulse = false;
          _mode = 0;
          break;
        case 'random':
          final random = math.Random(DateTime.now().millisecondsSinceEpoch);
          _x = random.nextInt(5);
          _y = random.nextInt(5);
          break;
      }
      _commands.insert(0, '${_clock()} | cmd:$command');
      if (_commands.length > 24) {
        _commands.removeRange(24, _commands.length);
      }
    });
    widget.onEvent('shortcut-command:$command');
  }

  void _handle(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    final key = event.logicalKey;
    bool handled = true;
    String action = '';

    if (key == LogicalKeyboardKey.arrowUp) {
      _y = (_y - 1).clamp(0, 4);
      action = 'move-up';
    } else if (key == LogicalKeyboardKey.arrowDown) {
      _y = (_y + 1).clamp(0, 4);
      action = 'move-down';
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      _x = (_x - 1).clamp(0, 4);
      action = 'move-left';
    } else if (key == LogicalKeyboardKey.arrowRight) {
      _x = (_x + 1).clamp(0, 4);
      action = 'move-right';
    } else if (key == LogicalKeyboardKey.enter) {
      _mode = (_mode + 1) % 3;
      action = 'cycle-mode';
    } else if (key == LogicalKeyboardKey.space) {
      _overlay = !_overlay;
      action = 'toggle-overlay';
    } else if (key == LogicalKeyboardKey.keyP) {
      _pulse = !_pulse;
      action = 'toggle-pulse';
    } else if (key == LogicalKeyboardKey.keyR) {
      _x = 2;
      _y = 2;
      _mode = 0;
      _overlay = false;
      _pulse = false;
      action = 'hard-reset';
    } else if (key == LogicalKeyboardKey.keyX) {
      final random = math.Random(DateTime.now().microsecondsSinceEpoch);
      _x = random.nextInt(5);
      _y = random.nextInt(5);
      action = 'randomize-cursor';
    } else if (key == LogicalKeyboardKey.escape) {
      _commands.clear();
      action = 'clear-history';
    } else {
      handled = false;
    }

    if (!handled) {
      return;
    }

    setState(() {
      _commands.insert(0, '${_clock()} | key:$action @ ($_x,$_y) mode:${_mode + 1}');
      if (_commands.length > 24) {
        _commands.removeRange(24, _commands.length);
      }
    });
    widget.onEvent('shortcut-key:$action');
  }
}

class _CursorBoard extends StatelessWidget {
  const _CursorBoard({
    required this.x,
    required this.y,
    required this.pulse,
    required this.overlay,
    required this.mode,
  });

  final int x;
  final int y;
  final bool pulse;
  final bool overlay;
  final int mode;

  @override
  Widget build(BuildContext context) {
    final tone = mode == 0
        ? _kCyan
        : mode == 1
            ? _kMint
            : _kAmber;
    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kFrame),
      ),
      child: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 25,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final cx = index % 5;
              final cy = index ~/ 5;
              final selected = cx == x && cy == y;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                decoration: BoxDecoration(
                  color: selected ? tone.withValues(alpha: 0.72) : _kSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: selected ? tone : _kFrame),
                  boxShadow: [
                    if (selected && pulse)
                      BoxShadow(color: tone.withValues(alpha: 0.45), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$cx,$cy',
                    style: TextStyle(color: selected ? Colors.black : _kMuted, fontWeight: FontWeight.w700),
                  ),
                ),
              );
            },
          ),
          if (overlay)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [tone.withValues(alpha: 0.20), Colors.transparent, tone.withValues(alpha: 0.16)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
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

class _CommandHistory extends StatelessWidget {
  const _CommandHistory({required this.commands});

  final List<String> commands;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kFrame),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Command History', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Expanded(
            child: commands.isEmpty
                ? const Text('No keyboard commands yet.', style: TextStyle(color: _kMuted))
                : ListView.builder(
                    itemCount: commands.length,
                    itemBuilder: (context, index) {
                      final line = commands[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(line, style: const TextStyle(color: _kText, fontFamily: 'monospace', fontSize: 11)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _BoundaryLabScene extends StatefulWidget {
  const _BoundaryLabScene({
    required this.compact,
    required this.guide,
    required this.showTips,
    required this.onEvent,
  });

  final bool compact;
  final bool guide;
  final bool showTips;
  final ValueChanged<String> onEvent;

  @override
  State<_BoundaryLabScene> createState() => _BoundaryLabSceneState();
}

class _BoundaryLabSceneState extends State<_BoundaryLabScene> {
  final FocusNode _outerNode = FocusNode(debugLabel: 'boundary-outer');
  final FocusNode _leftInnerNode = FocusNode(debugLabel: 'boundary-left-inner');
  final FocusNode _rightInnerNode = FocusNode(debugLabel: 'boundary-right-inner');

  String _outerLast = 'none';
  String _leftLast = 'none';
  String _rightLast = 'none';
  int _focusTarget = 0;

  @override
  void dispose() {
    _outerNode.dispose();
    _leftInnerNode.dispose();
    _rightInnerNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 710.0 : 850.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _DarkPanel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Boundary controls', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () {
                                _outerNode.requestFocus();
                                setState(() => _focusTarget = 0);
                                widget.onEvent('boundary focus -> outer');
                              },
                              child: const Text('Outer focus'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () {
                                _leftInnerNode.requestFocus();
                                setState(() => _focusTarget = 1);
                                widget.onEvent('boundary focus -> left inner');
                              },
                              child: const Text('Left inner focus'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () {
                                _rightInnerNode.requestFocus();
                                setState(() => _focusTarget = 2);
                                widget.onEvent('boundary focus -> right inner');
                              },
                              child: const Text('Right inner focus'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _MetricTile(label: 'Outer last', value: _outerLast, tone: _kCyan),
                      const SizedBox(height: 8),
                      _MetricTile(label: 'Left inner last', value: _leftLast, tone: _kRose),
                      const SizedBox(height: 8),
                      _MetricTile(label: 'Right inner last', value: _rightLast, tone: _kViolet),
                      const SizedBox(height: 8),
                      if (widget.showTips)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: _tipBox(),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Boundary behavior notes', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              _TipLine(text: 'Only the focused KeyboardListener receives key events.'),
                              _TipLine(text: 'Nested listeners do not receive events unless focused.'),
                              _TipLine(text: 'Use explicit FocusNode routing for predictable keyboard behavior.'),
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
            child: KeyboardListener(
              focusNode: _outerNode,
              onKeyEvent: (event) {
                if (event is KeyDownEvent) {
                  final label = _label(event);
                  setState(() {
                    _outerLast = label;
                    _focusTarget = 0;
                  });
                  widget.onEvent('boundary outer <- $label');
                }
              },
              child: _DarkPanel(
                guide: widget.guide,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: _NestedKeyboardZone(
                          title: 'Left Inner Zone',
                          focusNode: _leftInnerNode,
                          tone: _kRose,
                          focused: _focusTarget == 1,
                          onKeyLabel: (label) {
                            setState(() {
                              _leftLast = label;
                              _focusTarget = 1;
                            });
                            widget.onEvent('boundary left <- $label');
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _NestedKeyboardZone(
                          title: 'Right Inner Zone',
                          focusNode: _rightInnerNode,
                          tone: _kViolet,
                          focused: _focusTarget == 2,
                          onKeyLabel: (label) {
                            setState(() {
                              _rightLast = label;
                              _focusTarget = 2;
                            });
                            widget.onEvent('boundary right <- $label');
                          },
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

  String _label(KeyEvent event) {
    final key = event.logicalKey.keyLabel.isEmpty ? event.logicalKey.debugName ?? 'unknown' : event.logicalKey.keyLabel;
    return 'down:$key';
  }
}

class _NestedKeyboardZone extends StatefulWidget {
  const _NestedKeyboardZone({
    required this.title,
    required this.focusNode,
    required this.tone,
    required this.focused,
    required this.onKeyLabel,
  });

  final String title;
  final FocusNode focusNode;
  final Color tone;
  final bool focused;
  final ValueChanged<String> onKeyLabel;

  @override
  State<_NestedKeyboardZone> createState() => _NestedKeyboardZoneState();
}

class _NestedKeyboardZoneState extends State<_NestedKeyboardZone> {
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: widget.focusNode,
      onKeyEvent: (event) {
        if (event is! KeyDownEvent) {
          return;
        }
        final label = event.logicalKey.keyLabel.isEmpty ? event.logicalKey.debugName ?? 'unknown' : event.logicalKey.keyLabel;
        setState(() {
          _events.insert(0, label);
          if (_events.length > 16) {
            _events.removeRange(16, _events.length);
          }
        });
        widget.onKeyLabel(label);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kSurfaceAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.focused ? widget.tone : _kFrame, width: widget.focused ? 2.2 : 1.2),
          boxShadow: [
            if (widget.focused)
              BoxShadow(color: widget.tone.withValues(alpha: 0.32), blurRadius: 12, offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: widget.tone.withValues(alpha: 0.28)),
                ),
                child: _events.isEmpty
                    ? const Text('No local events', style: TextStyle(color: _kMuted))
                    : Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: _events
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: widget.tone.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(e, style: TextStyle(color: widget.tone, fontSize: 11, fontWeight: FontWeight.w700)),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticalWorkspaceScene extends StatefulWidget {
  const _PracticalWorkspaceScene({
    required this.compact,
    required this.guide,
    required this.showTips,
    required this.intensity,
    required this.onEvent,
  });

  final bool compact;
  final bool guide;
  final bool showTips;
  final double intensity;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalWorkspaceScene> createState() => _PracticalWorkspaceSceneState();
}

class _PracticalWorkspaceSceneState extends State<_PracticalWorkspaceScene> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'workspace-keyboard');

  int _activePanel = 0;
  bool _palette = false;
  bool _softGlow = true;
  bool _meta = true;
  int _cursor = 0;
  final List<String> _activity = <String>[];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 900.0 : 1080.0;
    final labels = const ['Dashboard', 'Inspector', 'Timeline', 'Console'];

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: KeyboardListener(
              focusNode: _focusNode,
              onKeyEvent: _onWorkspaceKey,
              child: _DarkPanel(
                guide: widget.guide,
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
                            selected: _activePanel == i,
                            label: Text(labels[i]),
                            onSelected: (_) {
                              setState(() => _activePanel = i);
                              widget.onEvent('workspace panel -> ${labels[i]}');
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
                            selected: _palette,
                            label: const Text('Command palette'),
                            onSelected: (v) => setState(() => _palette = v),
                          ),
                          FilterChip(
                            selected: _softGlow,
                            label: const Text('Soft glow'),
                            onSelected: (v) => setState(() => _softGlow = v),
                          ),
                          FilterChip(
                            selected: _meta,
                            label: const Text('Metadata row'),
                            onSelected: (v) => setState(() => _meta = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () {
                          _focusNode.requestFocus();
                          widget.onEvent('workspace focus requested');
                        },
                        child: const Text('Focus workspace keyboard layer'),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _kSurfaceAlt,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _kFrame),
                            boxShadow: [
                              if (_softGlow)
                                BoxShadow(color: _kViolet.withValues(alpha: 0.22 * widget.intensity), blurRadius: 14, offset: const Offset(0, 8)),
                            ],
                          ),
                          child: Column(
                            children: [
                              _workspaceTop(labels),
                              if (_meta) _workspaceMeta(),
                              Expanded(
                                child: IndexedStack(
                                  index: _activePanel,
                                  children: [
                                    _WorkspaceDashboard(cursor: _cursor),
                                    _WorkspaceInspector(cursor: _cursor),
                                    _WorkspaceTimeline(cursor: _cursor),
                                    _WorkspaceConsole(activity: _activity),
                                  ],
                                ),
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
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _DarkPanel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Workspace key map', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    if (widget.showTips)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _tipBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TipLine(text: '1-4: select workspace panel'),
                            _TipLine(text: 'P: toggle palette'),
                            _TipLine(text: 'G: toggle glow'),
                            _TipLine(text: 'M: toggle metadata strip'),
                            _TipLine(text: 'Arrow Left/Right: cursor movement'),
                            _TipLine(text: 'Enter: append activity marker'),
                            _TipLine(text: 'Backspace: remove last activity'),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8),
                    const Text('Recent activity', style: TextStyle(color: _kText, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(
                      child: _activity.isEmpty
                          ? const Text('No workspace activity yet.', style: TextStyle(color: _kMuted))
                          : ListView.builder(
                              itemCount: _activity.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(_activity[index], style: const TextStyle(color: _kText, fontFamily: 'monospace', fontSize: 11)),
                                );
                              },
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

  Widget _workspaceTop(List<String> labels) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _kViolet.withValues(alpha: 0.16),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(bottom: BorderSide(color: _kViolet.withValues(alpha: 0.35))),
      ),
      child: Row(
        children: [
          const Icon(Icons.keyboard_alt_rounded, color: _kViolet),
          const SizedBox(width: 8),
          const Text('Keyboard Workspace', style: TextStyle(color: _kText, fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          Text(labels[_activePanel], style: const TextStyle(color: _kText, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _workspaceMeta() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _kViolet.withValues(alpha: 0.10),
        border: Border(bottom: BorderSide(color: _kFrame.withValues(alpha: 0.85))),
      ),
      child: Row(
        children: [
          Text('cursor: $_cursor', style: const TextStyle(color: _kText, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('palette: ${_palette ? 'ON' : 'OFF'}', style: const TextStyle(color: _kMuted, fontSize: 12)),
        ],
      ),
    );
  }

  void _onWorkspaceKey(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }
    final key = event.logicalKey;
    String action = '';

    setState(() {
      if (key == LogicalKeyboardKey.digit1) {
        _activePanel = 0;
        action = 'panel-1';
      } else if (key == LogicalKeyboardKey.digit2) {
        _activePanel = 1;
        action = 'panel-2';
      } else if (key == LogicalKeyboardKey.digit3) {
        _activePanel = 2;
        action = 'panel-3';
      } else if (key == LogicalKeyboardKey.digit4) {
        _activePanel = 3;
        action = 'panel-4';
      } else if (key == LogicalKeyboardKey.keyP) {
        _palette = !_palette;
        action = 'toggle-palette';
      } else if (key == LogicalKeyboardKey.keyG) {
        _softGlow = !_softGlow;
        action = 'toggle-glow';
      } else if (key == LogicalKeyboardKey.keyM) {
        _meta = !_meta;
        action = 'toggle-meta';
      } else if (key == LogicalKeyboardKey.arrowLeft) {
        _cursor = (_cursor - 1).clamp(0, 9);
        action = 'cursor-left';
      } else if (key == LogicalKeyboardKey.arrowRight) {
        _cursor = (_cursor + 1).clamp(0, 9);
        action = 'cursor-right';
      } else if (key == LogicalKeyboardKey.enter) {
        _activity.insert(0, '${_clock()} | marker at cursor $_cursor panel $_activePanel');
        if (_activity.length > 30) {
          _activity.removeRange(30, _activity.length);
        }
        action = 'append-marker';
      } else if (key == LogicalKeyboardKey.backspace) {
        if (_activity.isNotEmpty) {
          _activity.removeAt(0);
        }
        action = 'remove-marker';
      }

      if (action.isNotEmpty) {
        _activity.insert(0, '${_clock()} | key:$action');
        if (_activity.length > 30) {
          _activity.removeRange(30, _activity.length);
        }
      }
    });

    if (action.isNotEmpty) {
      widget.onEvent('workspace:$action');
    }
  }
}

class _WorkspaceDashboard extends StatelessWidget {
  const _WorkspaceDashboard({required this.cursor});

  final int cursor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: _workspaceCard('Throughput', '${72 + cursor}%', _kCyan)),
          const SizedBox(width: 8),
          Expanded(child: _workspaceCard('Queue', '${18 + cursor}', _kMint)),
          const SizedBox(width: 8),
          Expanded(child: _workspaceCard('Latency', '${120 + (cursor * 4)}ms', _kAmber)),
        ],
      ),
    );
  }
}

class _WorkspaceInspector extends StatelessWidget {
  const _WorkspaceInspector({required this.cursor});

  final int cursor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.4,
        children: List<Widget>.generate(6, (i) {
          final active = i == cursor % 6;
          final tone = active ? _kRose : _kFrame;
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: tone),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Node ${i + 1}', style: TextStyle(color: active ? _kRose : _kMuted, fontWeight: FontWeight.w800)),
                const Spacer(),
                Text(active ? 'active cursor target' : 'standby', style: const TextStyle(color: _kMuted)),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _WorkspaceTimeline extends StatelessWidget {
  const _WorkspaceTimeline({required this.cursor});

  final int cursor;

  @override
  Widget build(BuildContext context) {
    final progress = (cursor / 9).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timeline Cursor', style: TextStyle(color: _kText, fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _WorkspaceTimelinePainter(progress: progress),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceConsole extends StatelessWidget {
  const _WorkspaceConsole({required this.activity});

  final List<String> activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF121A25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kFrame),
      ),
      child: activity.isEmpty
          ? const Text('No console lines yet.', style: TextStyle(color: _kMuted))
          : ListView.builder(
              itemCount: activity.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(activity[index], style: const TextStyle(color: _kText, fontFamily: 'monospace', fontSize: 11)),
                );
              },
            ),
    );
  }
}

class _WorkspaceTimelinePainter extends CustomPainter {
  const _WorkspaceTimelinePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * 0.55;
    final base = Paint()
      ..color = const Color(0xFF42566A)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final active = Paint()
      ..color = _kViolet
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(16, y), Offset(size.width - 16, y), base);
    canvas.drawLine(Offset(16, y), Offset(16 + ((size.width - 32) * progress), y), active);

    for (int i = 0; i <= 6; i++) {
      final x = 16 + ((size.width - 32) * (i / 6));
      final done = i / 6 <= progress;
      canvas.drawCircle(Offset(x, y), 6, Paint()..color = done ? _kViolet : const Color(0xFF5A6E81));
    }
  }

  @override
  bool shouldRepaint(covariant _WorkspaceTimelinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

Widget _workspaceCard(String title, String value, Color tone) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tone.withValues(alpha: 0.50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
        const Spacer(),
        Text(value, style: const TextStyle(color: _kText, fontWeight: FontWeight.w800, fontSize: 22)),
      ],
    ),
  );
}

class _GlobalEventPanel extends StatelessWidget {
  const _GlobalEventPanel({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kFrame),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Global Keyboard Event Feed', style: TextStyle(color: _kText, fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No global events yet.', style: TextStyle(color: _kMuted))
          else
            ...events
                .take(40)
                .map((line) => Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(line, style: const TextStyle(color: _kText, fontFamily: 'monospace', fontSize: 11)),
                    )),
        ],
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
        color: const Color(0xFF111A28),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF31465E)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: KeyboardListener', style: TextStyle(color: _kText, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'KeyboardListener is ideal when you need focused, low-level key event handling in a specific part of the widget tree. '
            'It relies on a FocusNode to receive events, making focus ownership explicit and testable. '
            'Use it for keyboard-first controls, game-style movement, editor-like interactions, and interpreter-driven command surfaces.',
            style: TextStyle(color: _kMuted, height: 1.36),
          ),
        ],
      ),
    );
  }
}

class _DarkPanel extends StatelessWidget {
  const _DarkPanel({required this.guide, required this.child});

  final bool guide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kFrame),
        gradient: const LinearGradient(
          colors: [Color(0xFF131E2D), Color(0xFF172637)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guide) const CustomPaint(painter: _GuidePainter()),
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
    final p = Paint()..color = const Color(0x12000000);
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

class _StatusRow {
  const _StatusRow({required this.name, required this.last, required this.count, required this.focused, required this.tone});

  final String name;
  final String last;
  final int count;
  final bool focused;
  final Color tone;
}

class _StatusTable extends StatelessWidget {
  const _StatusTable({required this.rows});

  final List<_StatusRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kFrame),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        r.name,
                        style: TextStyle(color: r.tone, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(child: Text('last: ${r.last}', style: const TextStyle(color: _kText, fontSize: 12))),
                    SizedBox(width: 72, child: Text('count: ${r.count}', style: const TextStyle(color: _kMuted, fontSize: 12))),
                    SizedBox(
                      width: 70,
                      child: Text(
                        r.focused ? 'focused' : 'idle',
                        style: TextStyle(color: r.focused ? r.tone : _kMuted, fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value, required this.tone});

  final String label;
  final String value;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 3),
          Text(value, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _kText, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _TipLine extends StatelessWidget {
  const _TipLine({required this.text});

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
            child: Icon(Icons.circle, size: 7, color: _kCyan),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _kMuted, height: 1.3))),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: const TextStyle(color: _kMuted, fontSize: 13), textAlign: TextAlign.center),
    );
  }
}

BoxDecoration _tipBox() {
  return BoxDecoration(
    color: _kSurfaceAlt,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: _kFrame),
  );
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
