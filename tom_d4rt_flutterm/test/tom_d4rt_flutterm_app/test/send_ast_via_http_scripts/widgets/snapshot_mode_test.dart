import 'package:flutter/material.dart';

const Color _bg = Color(0xFF0A1520);
const Color _panelColor = Color(0xFF132735);
const Color _panel2Color = Color(0xFF1D3A4E);
const Color _text = Color(0xFFD6EBFF);
const Color _teal = Color(0xFF58E1C1);
const Color _gold = Color(0xFFFFD166);
const Color _orange = Color(0xFFFF9966);
const Color _red = Color(0xFFFF6D6D);
const Color _blue = Color(0xFF7FB3FF);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _teal,
        secondary: _gold,
        surface: _panelColor,
      ),
    ),
    home: const _SnapshotModeDemo(),
  );
}

class _SnapshotModeDemo extends StatefulWidget {
  const _SnapshotModeDemo();

  @override
  State<_SnapshotModeDemo> createState() => _SnapshotModeDemoState();
}

class _SnapshotModeDemoState extends State<_SnapshotModeDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _panelColor,
        title: const Text(
          'SnapshotMode Deep Demo',
          style: TextStyle(color: _gold, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _gold,
          labelColor: _gold,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Mode Atlas'),
            Tab(text: 'Compositing Lab'),
            Tab(text: 'Decision Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ModeAtlasTab(),
          _CompositingLabTab(),
          _DecisionGuideTab(),
        ],
      ),
    );
  }
}

class _ModeAtlasTab extends StatefulWidget {
  const _ModeAtlasTab();

  @override
  State<_ModeAtlasTab> createState() => _ModeAtlasTabState();
}

class _ModeAtlasTabState extends State<_ModeAtlasTab>
    with AutomaticKeepAliveClientMixin {
  SnapshotMode _mode = SnapshotMode.normal;
  bool _platformViewPresent = true;
  bool _includeVideoLayer = true;
  double _stability = 0.8;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _ModeSpec spec = _specFor(_mode);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('SnapshotMode In Practice'),
          const SizedBox(height: 8),
          _panel(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('SnapshotMode controls how snapshotting behaves when content includes platform-view or non-snapshot-friendly descendants.'),
                _Bullet('Use it to tune correctness vs permissiveness depending on your scene and runtime constraints.'),
                _Bullet('This tab compares all enum values with visualized outcomes and behavior hints.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Select SnapshotMode'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: SnapshotMode.values.map((SnapshotMode item) {
                    final bool active = item == _mode;
                    final _ModeSpec itemSpec = _specFor(item);
                    return GestureDetector(
                      onTap: () => setState(() => _mode = item),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? itemSpec.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: active ? itemSpec.color : _panel2Color),
                        ),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: active ? itemSpec.color : _text,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _platformViewPresent,
                  activeThumbColor: _orange,
                  title: const Text('Scene contains platform view', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) => setState(() => _platformViewPresent = value),
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _includeVideoLayer,
                  activeThumbColor: _blue,
                  title: const Text('Video layer present in stack', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool value) => setState(() => _includeVideoLayer = value),
                ),
                const SizedBox(height: 8),
                const Text('Layer stability assumption', style: TextStyle(color: _text, fontSize: 11)),
                Slider(
                  min: 0,
                  max: 1,
                  value: _stability,
                  activeColor: _gold,
                  label: _stability.toStringAsFixed(2),
                  onChanged: (double value) => setState(() => _stability = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Behavior Card'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: spec.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: spec.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(spec.title, style: TextStyle(color: spec.color, fontSize: 12, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(spec.summary, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  ...spec.notes.map(
                    (String note) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.chevron_right_rounded, size: 16, color: spec.color),
                          const SizedBox(width: 4),
                          Expanded(child: Text(note, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Visual Outcome Preview'),
          const SizedBox(height: 8),
          _panel(
            child: _snapshotScene(spec),
          ),
        ],
      ),
    );
  }

  Widget _snapshotScene(_ModeSpec spec) {
    final bool strictFailure = _platformViewPresent && _mode == SnapshotMode.normal;
    final bool fallbackPainting = _platformViewPresent && _mode == SnapshotMode.permissive;
    final bool forceIgnore = _platformViewPresent && _mode == SnapshotMode.forced;

    final Color statusColor = strictFailure
        ? _red
        : fallbackPainting
            ? _orange
            : _teal;

    final String status = strictFailure
        ? 'Snapshot rejected: platform view requires explicit handling in normal mode.'
        : fallbackPainting
            ? 'Snapshot partial: platform-view region painted directly (non-snapshotted).'
            : forceIgnore
                ? 'Snapshot forced: unsupported descendants are omitted from captured layer.'
                : 'Snapshot successful: all descendants are snapshot-compatible.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 240,
          decoration: BoxDecoration(
            color: _panel2Color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: spec.color.withValues(alpha: 0.8)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        spec.color.withValues(alpha: 0.1),
                        _blue.withValues(alpha: 0.08),
                        _panel2Color,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                top: 14,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _bg.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _panel2Color),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.filter_frames_rounded, color: spec.color, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Mode: ${_mode.name} | Stability: ${_stability.toStringAsFixed(2)}',
                          style: TextStyle(color: spec.color, fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 62,
                width: 116,
                height: 88,
                child: _sceneLayer('UI Layer', _teal, snapshotSafe: true),
              ),
              if (_includeVideoLayer)
                Positioned(
                  left: 144,
                  top: 62,
                  width: 116,
                  height: 88,
                  child: _sceneLayer('Video Layer', _blue, snapshotSafe: _mode != SnapshotMode.normal),
                ),
              if (_platformViewPresent)
                Positioned(
                  right: 18,
                  top: 62,
                  width: 116,
                  height: 88,
                  child: _sceneLayer(
                    'Platform View',
                    _orange,
                    snapshotSafe: _mode == SnapshotMode.permissive,
                    ignored: _mode == SnapshotMode.forced,
                    strictError: _mode == SnapshotMode.normal,
                  ),
                ),
              Positioned(
                left: 18,
                right: 18,
                bottom: 14,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusColor.withValues(alpha: 0.8)),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sceneLayer(
    String title,
    Color color, {
    required bool snapshotSafe,
    bool ignored = false,
    bool strictError = false,
  }) {
    final String verdict = strictError
        ? 'Error'
        : ignored
            ? 'Ignored'
            : snapshotSafe
                ? 'Captured'
                : 'Fallback';

    final Color verdictColor = strictError
        ? _red
        : ignored
            ? _gold
            : snapshotSafe
                ? _teal
                : _orange;

    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: verdictColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: verdictColor),
              ),
              child: Text(
                verdict,
                style: TextStyle(color: verdictColor, fontSize: 9, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ModeSpec _specFor(SnapshotMode mode) {
    return switch (mode) {
      SnapshotMode.permissive => const _ModeSpec(
          title: 'Permissive Mode',
          summary: 'Allows snapshot attempt and falls back for unsupported descendants.',
          notes: [
            'Good for mixed scenes where graceful degradation is acceptable.',
            'Platform view may paint in non-snapshot path while rest is captured.',
            'User experience remains responsive with partial fidelity.',
          ],
          color: _orange,
        ),
      SnapshotMode.normal => const _ModeSpec(
          title: 'Normal Mode (Default)',
          summary: 'Strict mode that requires all descendants to be snapshot-friendly.',
          notes: [
            'Useful when deterministic snapshot integrity is mandatory.',
            'Platform view incompatibility should fail fast for visibility.',
            'Best for high-trust capture pipelines and debug validation.',
          ],
          color: _teal,
        ),
      SnapshotMode.forced => const _ModeSpec(
          title: 'Forced Mode',
          summary: 'Forces snapshot path and ignores incompatible descendants.',
          notes: [
            'Can stabilize capture under constrained pipelines.',
            'May omit some visual components by design.',
            'Use when preserving snapshot continuity is more important than completeness.',
          ],
          color: _gold,
        ),
    };
  }
}

class _CompositingLabTab extends StatefulWidget {
  const _CompositingLabTab();

  @override
  State<_CompositingLabTab> createState() => _CompositingLabTabState();
}

class _CompositingLabTabState extends State<_CompositingLabTab>
    with AutomaticKeepAliveClientMixin {
  SnapshotMode _mode = SnapshotMode.normal;
  bool _webView = true;
  bool _mapView = false;
  bool _cameraView = false;
  bool _overlayEffects = true;
  final List<String> _timeline = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _timeline.add('Initialized compositing lab.');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<_LayerInfo> layers = <_LayerInfo>[
      const _LayerInfo('Background UI', true, _blue),
      if (_overlayEffects) const _LayerInfo('Shader Overlay', true, _teal),
      if (_webView) const _LayerInfo('WebView Platform Layer', false, _orange),
      if (_mapView) const _LayerInfo('Map Platform Layer', false, _gold),
      if (_cameraView) const _LayerInfo('Camera Platform Layer', false, _red),
      const _LayerInfo('HUD Controls', true, _teal),
    ];

    final int incompatibleCount = layers.where((l) => !l.snapshotFriendly).length;
    final _LabResult result = _resolveResult(mode: _mode, incompatible: incompatibleCount);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Compositing Scenario Lab'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: SnapshotMode.values.map((SnapshotMode value) {
                    final bool active = value == _mode;
                    final Color color = _specColor(value);
                    return GestureDetector(
                      onTap: () {
                        setState(() => _mode = value);
                        _push('mode -> ${value.name}');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: active ? color : _panel2Color),
                        ),
                        child: Text(
                          value.name,
                          style: TextStyle(
                            color: active ? color : _text,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                _switch('WebView layer', _webView, _orange, (bool v) {
                  setState(() => _webView = v);
                  _push('web view -> $v');
                }),
                _switch('Map layer', _mapView, _gold, (bool v) {
                  setState(() => _mapView = v);
                  _push('map view -> $v');
                }),
                _switch('Camera layer', _cameraView, _red, (bool v) {
                  setState(() => _cameraView = v);
                  _push('camera view -> $v');
                }),
                _switch('Overlay effects', _overlayEffects, _blue, (bool v) {
                  setState(() => _overlayEffects = v);
                  _push('overlay effects -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Layer Stack Display'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: layers
                  .map(
                    (_LayerInfo layer) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: layer.color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: layer.color.withValues(alpha: 0.85)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              layer.name,
                              style: TextStyle(color: layer.color, fontSize: 11, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            layer.snapshotFriendly ? 'snapshot-friendly' : 'platform-view',
                            style: TextStyle(
                              color: layer.snapshotFriendly ? _teal : _orange,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 14),
          _title('Result Evaluation'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: result.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: result.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.title, style: TextStyle(color: result.color, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 5),
                  Text(result.description, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  Text(
                    'Incompatible layers detected: $incompatibleCount',
                    style: TextStyle(color: result.color, fontSize: 10, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Timeline'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2Color),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _timeline.length,
                itemBuilder: (BuildContext context, int index) {
                  final String line = _timeline[_timeline.length - 1 - index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: _panelColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(line, style: const TextStyle(color: _gold, fontFamily: 'monospace', fontSize: 10)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _switch(String title, bool value, Color color, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: _text, fontSize: 11)),
      value: value,
      activeThumbColor: color,
      onChanged: onChanged,
    );
  }

  _LabResult _resolveResult({required SnapshotMode mode, required int incompatible}) {
    if (incompatible == 0) {
      return const _LabResult(
        title: 'Full snapshot success',
        description: 'All layers are snapshot-friendly, so every mode captures correctly.',
        color: _teal,
      );
    }
    return switch (mode) {
      SnapshotMode.normal => const _LabResult(
          title: 'Strict failure in normal mode',
          description: 'At least one incompatible layer prevents full snapshot capture.',
          color: _red,
        ),
      SnapshotMode.permissive => const _LabResult(
          title: 'Partial fallback in permissive mode',
          description: 'Snapshot continues while incompatible layers are rendered outside snapshot capture.',
          color: _orange,
        ),
      SnapshotMode.forced => const _LabResult(
          title: 'Forced capture with omissions',
          description: 'Snapshot continues and may ignore incompatible content entirely.',
          color: _gold,
        ),
    };
  }

  Color _specColor(SnapshotMode mode) {
    return switch (mode) {
      SnapshotMode.permissive => _orange,
      SnapshotMode.normal => _teal,
      SnapshotMode.forced => _gold,
    };
  }

  void _push(String event) {
    final String time = TimeOfDay.now().format(context);
    setState(() {
      _timeline.add('$time | $event');
      if (_timeline.length > 40) {
        _timeline.removeAt(0);
      }
    });
  }
}

class _DecisionGuideTab extends StatefulWidget {
  const _DecisionGuideTab();

  @override
  State<_DecisionGuideTab> createState() => _DecisionGuideTabState();
}

class _DecisionGuideTabState extends State<_DecisionGuideTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedScenario = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _Scenario scenario = _scenarios[_selectedScenario];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Mode Selection Guide'),
          const SizedBox(height: 8),
          _panel(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Choose mode based on tolerance for incomplete snapshots and platform-view behavior.'),
                _Bullet('This guide maps practical product scenarios to recommended SnapshotMode values.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Scenarios'),
          const SizedBox(height: 8),
          _panel(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_scenarios.length, (int index) {
                final bool active = index == _selectedScenario;
                final _Scenario item = _scenarios[index];
                return GestureDetector(
                  onTap: () => setState(() => _selectedScenario = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? item.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? item.color : _panel2Color),
                    ),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: active ? item.color : _text,
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),
          _title('Recommended Mode'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: scenario.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: scenario.color.withValues(alpha: 0.8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(scenario.name, style: TextStyle(color: scenario.color, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text('Recommended: ${scenario.mode.name}', style: TextStyle(color: scenario.color, fontSize: 11)),
                  const SizedBox(height: 6),
                  Text(scenario.why, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  ...scenario.tips.map(
                    (String t) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_rounded, size: 14, color: scenario.color),
                          const SizedBox(width: 5),
                          Expanded(child: Text(t, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Quick Comparison Table'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: const [
                _CompareRow('permissive', 'Graceful fallback', 'Possible partial fidelity', _orange),
                _CompareRow('normal', 'Strict correctness', 'Errors on incompatible content', _teal),
                _CompareRow('forced', 'Continuity first', 'May ignore unsupported layers', _gold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeSpec {
  const _ModeSpec({
    required this.title,
    required this.summary,
    required this.notes,
    required this.color,
  });

  final String title;
  final String summary;
  final List<String> notes;
  final Color color;
}

class _LayerInfo {
  const _LayerInfo(this.name, this.snapshotFriendly, this.color);

  final String name;
  final bool snapshotFriendly;
  final Color color;
}

class _LabResult {
  const _LabResult({required this.title, required this.description, required this.color});

  final String title;
  final String description;
  final Color color;
}

class _Scenario {
  const _Scenario({
    required this.name,
    required this.mode,
    required this.why,
    required this.tips,
    required this.color,
  });

  final String name;
  final SnapshotMode mode;
  final String why;
  final List<String> tips;
  final Color color;
}

const List<_Scenario> _scenarios = [
  _Scenario(
    name: 'Editor with embedded web docs',
    mode: SnapshotMode.permissive,
    why: 'Mixed content should remain usable even if some regions cannot be captured in a snapshot.',
    tips: [
      'Provide fallback rendering hints in debug logs.',
      'Keep high-priority UI controls outside platform-view overlap zones.',
    ],
    color: _orange,
  ),
  _Scenario(
    name: 'Regulated capture workflow',
    mode: SnapshotMode.normal,
    why: 'Strict failure is preferred so invalid snapshots are never silently accepted.',
    tips: [
      'Gate release checks on snapshot compatibility tests.',
      'Fail fast when platform views enter capture surfaces.',
    ],
    color: _teal,
  ),
  _Scenario(
    name: 'Realtime thumbnail stream',
    mode: SnapshotMode.forced,
    why: 'Continuous output is prioritized over perfect fidelity in every frame.',
    tips: [
      'Document ignored layers to avoid confusion for downstream consumers.',
      'Use overlays to indicate omitted regions when relevant.',
    ],
    color: _gold,
  ),
  _Scenario(
    name: 'Hybrid media dashboard',
    mode: SnapshotMode.permissive,
    why: 'Dashboards with map/video widgets often benefit from graceful snapshot fallback.',
    tips: [
      'Separate critical metrics into always-snapshot-safe zones.',
      'Use telemetry to monitor fallback frequency.',
    ],
    color: _blue,
  ),
];

class _CompareRow extends StatelessWidget {
  const _CompareRow(this.mode, this.strength, this.risk, this.color);

  final String mode;
  final String strength;
  final String risk;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(mode, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
          Expanded(child: Text(strength, style: const TextStyle(color: _text, fontSize: 10))),
          const SizedBox(width: 10),
          Expanded(child: Text(risk, style: const TextStyle(color: _text, fontSize: 10))),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: _gold, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _gold, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _panel({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _panelColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _panel2Color),
    ),
    child: child,
  );
}
