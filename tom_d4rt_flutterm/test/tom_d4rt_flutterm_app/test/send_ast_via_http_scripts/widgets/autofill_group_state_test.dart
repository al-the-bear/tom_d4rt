import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _Palette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Harbor Teal',
    shell: Color(0xFF132028),
    canvas: Color(0xFFF1F9FC),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF1D2D36),
    muted: Color(0xFF6E8592),
    accentA: Color(0xFF1877F2),
    accentB: Color(0xFF13A37B),
    accentC: Color(0xFFE08A00),
  ),
  _Palette(
    name: 'Pine Quartz',
    shell: Color(0xFF1A241B),
    canvas: Color(0xFFF3FAF3),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF253128),
    muted: Color(0xFF748574),
    accentA: Color(0xFF2F7E42),
    accentB: Color(0xFF1E9C88),
    accentC: Color(0xFFC7892F),
  ),
  _Palette(
    name: 'Graphite Rose',
    shell: Color(0xFF221A29),
    canvas: Color(0xFFF9F4FB),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF30243A),
    muted: Color(0xFF887898),
    accentA: Color(0xFF7356E5),
    accentB: Color(0xFFB94186),
    accentC: Color(0xFF2CA497),
  ),
];

enum _Stage {
  observatory,
  matrix,
  registry,
  disposeTheater,
  diagnostics,
  compendium,
}

enum _Density {
  sparse,
  normal,
  dense,
}

enum _LaneLayout {
  stacked,
  split,
}

class _TraceLine {
  final DateTime at;
  final String source;
  final String message;
  final Color tone;

  const _TraceLine({
    required this.at,
    required this.source,
    required this.message,
    required this.tone,
  });
}

class _ProbeSnapshot {
  final String laneId;
  final bool hasState;
  final bool mounted;
  final bool maybeMatchesOf;
  final int clientCount;
  final String firstClientId;
  final bool lookupMissingClient;
  final List<String> clientIds;

  const _ProbeSnapshot({
    required this.laneId,
    required this.hasState,
    required this.mounted,
    required this.maybeMatchesOf,
    required this.clientCount,
    required this.firstClientId,
    required this.lookupMissingClient,
    required this.clientIds,
  });

  String get signature {
    return '$laneId|$hasState|$mounted|$maybeMatchesOf|$clientCount|$firstClientId|'
        '$lookupMissingClient|${clientIds.join(',')}';
  }
}

const _quickTips = <String>[
  'AutofillGroupState is available only below an AutofillGroup in the widget tree.',
  'Use AutofillGroup.maybeOf(context) in custom probe widgets to avoid exceptions.',
  'Use AutofillGroup.of(context) only when the group is guaranteed to exist.',
  'autofillClients exposes currently attached clients for this autofill scope.',
  'onDisposeAction controls commit or cancel behavior when the group disposes.',
  'finishAutofillContext(shouldSave: true) can force save behavior from UI actions.',
  'Client count can change as form fields are mounted, removed, or rebuilt.',
  'Diagnostics lanes are useful for interpreter integration and visual verification.',
];

dynamic build(BuildContext context) {
  return const _AutofillGroupStateDeepDemo();
}

class _AutofillGroupStateDeepDemo extends StatefulWidget {
  const _AutofillGroupStateDeepDemo();

  @override
  State<_AutofillGroupStateDeepDemo> createState() => _AutofillGroupStateDeepDemoState();
}

class _AutofillGroupStateDeepDemoState extends State<_AutofillGroupStateDeepDemo> {
  _Stage _stage = _Stage.observatory;
  _Density _density = _Density.normal;
  int _paletteIndex = 0;

  bool _showTips = true;
  bool _showInspectorRail = true;
  bool _showTimeline = true;
  bool _showMetrics = true;
  bool _verbose = false;

  AutofillContextAction _disposeActionA = AutofillContextAction.commit;
  AutofillContextAction _disposeActionB = AutofillContextAction.cancel;

  double _laneHeight = 400;
  double _timelineHeight = 260;
  int _dynamicFieldBase = 2;
  final int _maxDynamicFields = 6;

  int _snapshotEvents = 0;
  int _selectionEvents = 0;

  final List<_TraceLine> _timeline = <_TraceLine>[];
  final Map<String, _ProbeSnapshot> _snapshots = <String, _ProbeSnapshot>{};

  static const _stageTitles = <String>[
    '1 State Observatory',
    '2 Group Matrix',
    '3 Client Registry Lab',
    '4 Dispose Action Theater',
    '5 Diagnostics Deck',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  int get _effectiveDynamicBase {
    switch (_density) {
      case _Density.sparse:
        return (_dynamicFieldBase * 0.7).round().clamp(1, _maxDynamicFields);
      case _Density.normal:
        return _dynamicFieldBase;
      case _Density.dense:
        return (_dynamicFieldBase * 1.5).round().clamp(1, _maxDynamicFields);
    }
  }

  @override
  void initState() {
    super.initState();
    _pushTrace('system', 'AutofillGroupState observatory initialized.', _p.accentA);
  }

  void _pushTrace(String source, String message, Color tone) {
    final row = _TraceLine(at: DateTime.now(), source: source, message: message, tone: tone);
    setState(() {
      _timeline.insert(0, row);
      if (_timeline.length > 60) {
        _timeline.removeRange(60, _timeline.length);
      }
    });
    if (_verbose) {
      debugPrint('[AutofillGroupState][$source] $message');
    }
  }

  void _onProbeSnapshot(_ProbeSnapshot snapshot) {
    final previous = _snapshots[snapshot.laneId];
    if (previous != null && previous.signature == snapshot.signature) {
      return;
    }
    setState(() {
      _snapshots[snapshot.laneId] = snapshot;
      _snapshotEvents += 1;
    });
    _pushTrace(
      snapshot.laneId,
      'state hasState=${snapshot.hasState}, clients=${snapshot.clientCount}, mounted=${snapshot.mounted}',
      _p.accentB,
    );
  }

  void _onFinishAction(String laneId, bool shouldSave) {
    setState(() => _selectionEvents += 1);
    _pushTrace(
      laneId,
      'finishAutofillContext(shouldSave: $shouldSave)',
      shouldSave ? _p.accentA : _p.accentC,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.canvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(child: _body()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_p.shell, _p.accentA.withValues(alpha: 0.87)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.contacts_rounded, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AutofillGroupState Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'State + Client Registry',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'AutofillGroupState exposes scope-level autofill client information. '
            'This demo visualizes maybeOf/of access, client registry dynamics, '
            'and onDisposeAction behavior in form-rich, instructive layouts.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.94),
              fontSize: 12.3,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: _p.accentA.withValues(alpha: 0.07),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageTitles.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Density', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          _densityChip('Sparse', _Density.sparse),
          _densityChip('Normal', _Density.normal),
          _densityChip('Dense', _Density.dense),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    return ChoiceChip(
      selected: _stage.index == index,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(
        color: _stage.index == index ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _stage = _Stage.values[index]),
    );
  }

  Widget _densityChip(String label, _Density value) {
    return ChoiceChip(
      selected: _density == value,
      selectedColor: _p.accentB,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _density == value ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _density = value),
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () => setState(() => _paletteIndex = index),
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _body() {
    switch (_stage) {
      case _Stage.observatory:
        return _observatoryStage();
      case _Stage.matrix:
        return _matrixStage();
      case _Stage.registry:
        return _registryStage();
      case _Stage.disposeTheater:
        return _disposeTheaterStage();
      case _Stage.diagnostics:
        return _diagnosticsStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _observatoryStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('State Observatory'),
          const SizedBox(height: 8),
          Text(
            'Observatory lane combines AutofillGroup with a live probe widget '
            'that inspects AutofillGroupState via maybeOf/of and client registry getters.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Global Controls',
            subtitle: 'Adjust lane dimensions, dynamic field baseline, and diagnostics toggles.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'lane height',
                  value: _laneHeight,
                  min: 300,
                  max: 620,
                  divisions: 32,
                  color: _p.accentA,
                  onChanged: (v) => setState(() => _laneHeight = v),
                ),
                _slider(
                  label: 'dynamic fields base',
                  value: _dynamicFieldBase.toDouble(),
                  min: 1,
                  max: _maxDynamicFields.toDouble(),
                  divisions: _maxDynamicFields - 1,
                  color: _p.accentB,
                  onChanged: (v) => setState(() => _dynamicFieldBase = v.round()),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('show tips', _showTips, (v) => _showTips = v),
                    _toggleChip('inspector rail', _showInspectorRail, (v) => _showInspectorRail = v),
                    _toggleChip('show timeline', _showTimeline, (v) => _showTimeline = v),
                    _toggleChip('show metrics', _showMetrics, (v) => _showMetrics = v),
                    _toggleChip('verbose logs', _verbose, (v) => _verbose = v),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Observatory Lane',
            subtitle: 'Single canonical lane with embedded AutofillGroupState probe.',
            tint: _p.accentA.withValues(alpha: 0.04),
            child: SizedBox(
              height: _laneHeight,
              child: _AutofillLane(
                laneId: 'observatory',
                title: 'Observatory Form',
                subtitle: 'Type in fields and observe client registry updates in real-time.',
                palette: _p,
                onDisposeAction: _disposeActionA,
                initialDynamicFields: _effectiveDynamicBase,
                layout: _LaneLayout.split,
                showInspectorRail: _showInspectorRail,
                showTips: _showTips,
                onSnapshot: _onProbeSnapshot,
                onTrace: _pushTrace,
                onFinishAction: _onFinishAction,
              ),
            ),
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _metricsPanel(),
          ],
        ],
      ),
    );
  }

  Widget _matrixStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Group Matrix'),
          const SizedBox(height: 8),
          Text(
            'Matrix compares lanes using different onDisposeAction values. '
            'Each lane reports state snapshots and client counts independently.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Commit Lane',
                  subtitle: 'onDisposeAction: commit',
                  tint: _p.accentA.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillLane(
                      laneId: 'matrix-commit',
                      title: 'Commit profile',
                      subtitle: 'Disposal defaults to committing autofill context.',
                      palette: _p,
                      onDisposeAction: AutofillContextAction.commit,
                      initialDynamicFields: _effectiveDynamicBase,
                      layout: _LaneLayout.stacked,
                      showInspectorRail: _showInspectorRail,
                      showTips: _showTips,
                      onSnapshot: _onProbeSnapshot,
                      onTrace: _pushTrace,
                      onFinishAction: _onFinishAction,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Cancel Lane',
                  subtitle: 'onDisposeAction: cancel',
                  tint: _p.accentC.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillLane(
                      laneId: 'matrix-cancel',
                      title: 'Cancel profile',
                      subtitle: 'Disposal defaults to canceling autofill context.',
                      palette: _p,
                      onDisposeAction: AutofillContextAction.cancel,
                      initialDynamicFields: _effectiveDynamicBase,
                      layout: _LaneLayout.stacked,
                      showInspectorRail: _showInspectorRail,
                      showTips: _showTips,
                      onSnapshot: _onProbeSnapshot,
                      onTrace: _pushTrace,
                      onFinishAction: _onFinishAction,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _registryStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Client Registry Lab'),
          const SizedBox(height: 8),
          Text(
            'Registry lab focuses on autofillClients dynamics by adding/removing '
            'optional fields and inspecting live client IDs from AutofillGroupState.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Registry Lane',
            subtitle: 'Manipulate dynamic field count and inspect client list changes.',
            tint: _p.accentB.withValues(alpha: 0.04),
            child: SizedBox(
              height: _laneHeight + 40,
              child: _AutofillLane(
                laneId: 'registry',
                title: 'Registry form',
                subtitle: 'Use + / - to change optional address fields and observe snapshots.',
                palette: _p,
                onDisposeAction: _disposeActionA,
                initialDynamicFields: _effectiveDynamicBase,
                layout: _LaneLayout.split,
                showInspectorRail: true,
                showTips: _showTips,
                onSnapshot: _onProbeSnapshot,
                onTrace: _pushTrace,
                onFinishAction: _onFinishAction,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Registry Notes',
            subtitle: 'How to reason about AutofillGroupState.autofillClients.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _bullet('Client registry updates when autofill-capable fields mount or unmount.'),
                _bullet('Dynamic forms should verify client count after structural updates.'),
                _bullet('Client IDs are framework-generated; treat them as diagnostic identifiers.'),
                _bullet('maybeOf is safer for optional probes in reusable widgets.'),
                _bullet('getAutofillClient is useful for diagnostics and scope checks.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _disposeTheaterStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Dispose Action Theater'),
          const SizedBox(height: 8),
          Text(
            'Theater stage combines configurable onDisposeAction with explicit '
            'finishAutofillContext actions to visualize commit/cancel intent.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Action Controls',
            subtitle: 'Set per-lane default dispose action.',
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              children: <Widget>[
                _actionSelector(
                  label: 'Lane A action',
                  current: _disposeActionA,
                  onChanged: (v) => setState(() => _disposeActionA = v),
                ),
                _actionSelector(
                  label: 'Lane B action',
                  current: _disposeActionB,
                  onChanged: (v) => setState(() => _disposeActionB = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Theater Lane A',
                  subtitle: 'Configurable action + manual commit/cancel triggers.',
                  tint: _p.accentA.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillLane(
                      laneId: 'theater-a',
                      title: 'Theater A',
                      subtitle: 'Use bottom controls to call finishAutofillContext.',
                      palette: _p,
                      onDisposeAction: _disposeActionA,
                      initialDynamicFields: _effectiveDynamicBase,
                      layout: _LaneLayout.stacked,
                      showInspectorRail: _showInspectorRail,
                      showTips: _showTips,
                      onSnapshot: _onProbeSnapshot,
                      onTrace: _pushTrace,
                      onFinishAction: _onFinishAction,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Theater Lane B',
                  subtitle: 'Independent lane for action comparison.',
                  tint: _p.accentB.withValues(alpha: 0.03),
                  child: SizedBox(
                    height: _laneHeight,
                    child: _AutofillLane(
                      laneId: 'theater-b',
                      title: 'Theater B',
                      subtitle: 'Compare behavior with alternate default action.',
                      palette: _p,
                      onDisposeAction: _disposeActionB,
                      initialDynamicFields: _effectiveDynamicBase,
                      layout: _LaneLayout.stacked,
                      showInspectorRail: _showInspectorRail,
                      showTips: _showTips,
                      onSnapshot: _onProbeSnapshot,
                      onTrace: _pushTrace,
                      onFinishAction: _onFinishAction,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _diagnosticsStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Diagnostics Deck'),
          const SizedBox(height: 8),
          Text(
            'Diagnostics deck aggregates snapshots and trace lines from all lanes, '
            'providing a practical visual checkpoint for interpreter integration.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Timeline Controls',
            subtitle: 'Adjust timeline viewport and add manual markers.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'timeline height',
                  value: _timelineHeight,
                  min: 180,
                  max: 460,
                  divisions: 28,
                  color: _p.accentC,
                  onChanged: (v) => setState(() => _timelineHeight = v),
                ),
                Row(
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: () => setState(_timeline.clear),
                      icon: const Icon(Icons.delete_sweep_outlined),
                      label: const Text('Clear timeline'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () => _pushTrace('manual', 'Manual marker inserted.', _p.accentC),
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Add marker'),
                    ),
                    const Spacer(),
                    if (_showMetrics) _chip('rows', '${_timeline.length}', _p.accentC),
                  ],
                ),
              ],
            ),
          ),
          if (_showTimeline) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Event Timeline',
              subtitle: 'Live records from probe snapshots and action buttons.',
              tint: _p.accentA.withValues(alpha: 0.04),
              child: SizedBox(
                height: _timelineHeight,
                child: _timeline.isEmpty
                    ? Center(
                        child: Text(
                          'Timeline empty. Interact with lanes to capture events.',
                          style: TextStyle(color: _p.muted, fontSize: 11.6),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _timeline.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final event = _timeline[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: event.tone.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: event.tone.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _chip('src', event.source, event.tone),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    event.message,
                                    style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.34),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _clock(event.at),
                                  style: TextStyle(
                                    color: _p.muted,
                                    fontSize: 10.1,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          _panel(
            title: 'Snapshot Table',
            subtitle: 'Current state probe values by lane.',
            child: _snapshots.isEmpty
                ? Text('No snapshots yet.', style: TextStyle(color: _p.muted, fontSize: 11.5))
                : Column(
                    children: _snapshots.entries
                        .map(
                          (entry) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _p.muted.withValues(alpha: 0.22)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    entry.key,
                                    style: TextStyle(
                                      color: _p.accentA,
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10.8,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'state=${entry.value.hasState}, clients=${entry.value.clientCount}, '
                                    'mounted=${entry.value.mounted}, maybe==of=${entry.value.maybeMatchesOf}',
                                    style: TextStyle(color: _p.ink, fontSize: 11.2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _compendiumStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'AutofillGroupState Matrix',
            subtitle: 'What AutofillGroupState provides and where to use it.',
            child: Column(
              children: <Widget>[
                _matrix('Scope', 'State object for AutofillGroup scope in widget tree.'),
                _matrix('Access methods', 'AutofillGroup.maybeOf(context) and AutofillGroup.of(context).'),
                _matrix('Client registry', 'autofillClients getter returns iterable of attached clients.'),
                _matrix('Client lookup', 'getAutofillClient(String id) resolves scoped client by identifier.'),
                _matrix('Lifecycle', 'mounted indicates active state lifecycle status.'),
                _matrix('Dispose policy', 'AutofillGroup.onDisposeAction controls commit/cancel behavior.'),
                _matrix('Manual finish', 'TextInput.finishAutofillContext can force save/cancel intent.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Quick Tips',
            subtitle: 'Field-tested practices for stable autofill demos.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _quickTips.map(_bullet).toList(),
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Integration recommendations for interpreter checks.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do probe state inside AutofillGroup subtree',
                  detail: 'Outside scope, maybeOf returns null and of throws.',
                ),
                _doDont(
                  good: true,
                  title: 'Do track client count when forms are dynamic',
                  detail: 'Optional fields can alter autofill client registry unexpectedly.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont assume static client IDs across rebuilds',
                  detail: 'Treat IDs as diagnostics, not persistent business identifiers.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont skip user-facing visual guidance',
                  detail: 'Autofill interactions need explicit labels and hints in demos.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common AutofillGroupState questions.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When should I call maybeOf versus of?',
                  a: 'Use maybeOf for optional access in reusable widgets; use of only when scope is guaranteed.',
                ),
                _qa(
                  q: 'What does autofillClients represent?',
                  a: 'The currently attached autofill-capable clients inside the active group scope.',
                ),
                _qa(
                  q: 'How can I visualize dispose behavior?',
                  a: 'Compare lanes with different onDisposeAction values and trigger finishAutofillContext actions.',
                ),
                _qa(
                  q: 'How do I test dynamic forms?',
                  a: 'Add/remove fields and validate probe snapshot changes for client count and IDs.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo acceptance criteria for this component.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Observatory stage with live maybeOf/of and client registry probe.'),
                _check('Matrix stage comparing commit and cancel disposal profiles.'),
                _check('Registry stage showing dynamic field-driven client changes.'),
                _check('Dispose theater with manual finishAutofillContext controls.'),
                _check('Diagnostics deck with timeline and snapshot table.'),
                _check('Compendium with matrix, tips, do/dont, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _notice(
            'AutofillGroupState is the runtime inspection anchor for autofill scopes. '
            'This demo emphasizes visual state observability and interaction-driven '
            'verification instead of API-level assertion tests.',
          ),
        ],
      ),
    );
  }

  Widget _actionSelector({
    required String label,
    required AutofillContextAction current,
    required ValueChanged<AutofillContextAction> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.6)),
        const SizedBox(width: 8),
        DropdownButton<AutofillContextAction>(
          value: current,
          items: AutofillContextAction.values
              .map(
                (action) => DropdownMenuItem<AutofillContextAction>(
                  value: action,
                  child: Text(action.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
              _pushTrace('policy', '$label -> ${value.name}', _p.accentA);
            }
          },
        ),
      ],
    );
  }

  Widget _metricsPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Snapshot and action event counters across lanes.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _chip('snapshots', '$_snapshotEvents', _p.accentA),
          _chip('actions', '$_selectionEvents', _p.accentB),
          _chip('tracked lanes', '${_snapshots.length}', _p.accentC),
          _chip('dynamic base', '$_effectiveDynamicBase', _p.accentA),
        ],
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _p.accentA.withValues(alpha: 0.18),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accentA,
      label: Text(label),
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _slider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 190,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _p.ink, fontSize: 12),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(color: _p.accentA, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: _p.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? _p.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.3)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontFamily: 'monospace',
          fontSize: 10.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _matrix(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 190,
            child: Text(
              key,
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 11.1,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33))),
        ],
      ),
    );
  }

  Widget _doDont({required bool good, required String title, required String detail}) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.3, height: 1.33)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.34)),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _p.accentA),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.9, height: 1.32))),
        ],
      ),
    );
  }

  Widget _notice(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.accentC.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.accentC.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.info_outline, color: _p.accentC, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12, height: 1.34))),
        ],
      ),
    );
  }

  String _clock(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final s = t.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.shell.withValues(alpha: 0.06),
      child: Row(
        children: <Widget>[
          Text(_stageTitles[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _AutofillLane extends StatefulWidget {
  const _AutofillLane({
    required this.laneId,
    required this.title,
    required this.subtitle,
    required this.palette,
    required this.onDisposeAction,
    required this.initialDynamicFields,
    required this.layout,
    required this.showInspectorRail,
    required this.showTips,
    required this.onSnapshot,
    required this.onTrace,
    required this.onFinishAction,
  });

  final String laneId;
  final String title;
  final String subtitle;
  final _Palette palette;
  final AutofillContextAction onDisposeAction;
  final int initialDynamicFields;
  final _LaneLayout layout;
  final bool showInspectorRail;
  final bool showTips;
  final ValueChanged<_ProbeSnapshot> onSnapshot;
  final void Function(String source, String message, Color tone) onTrace;
  final void Function(String laneId, bool shouldSave) onFinishAction;

  @override
  State<_AutofillLane> createState() => _AutofillLaneState();
}

class _AutofillLaneState extends State<_AutofillLane> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _street = TextEditingController();
  final _city = TextEditingController();
  final _postal = TextEditingController();

  late int _dynamicCount;
  late List<TextEditingController> _extraControllers;

  @override
  void initState() {
    super.initState();
    _dynamicCount = widget.initialDynamicFields;
    _extraControllers = List<TextEditingController>.generate(
      _dynamicCount,
      (index) => TextEditingController(),
    );
  }

  @override
  void didUpdateWidget(covariant _AutofillLane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDynamicFields != oldWidget.initialDynamicFields) {
      _setDynamicCount(widget.initialDynamicFields);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _street.dispose();
    _city.dispose();
    _postal.dispose();
    for (final c in _extraControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _setDynamicCount(int target) {
    final next = target.clamp(1, 6);
    if (next == _dynamicCount) {
      return;
    }
    if (next > _dynamicCount) {
      final add = next - _dynamicCount;
      _extraControllers.addAll(List<TextEditingController>.generate(add, (_) => TextEditingController()));
    } else {
      for (var i = _dynamicCount - 1; i >= next; i--) {
        _extraControllers[i].dispose();
      }
      _extraControllers = _extraControllers.take(next).toList();
    }
    setState(() => _dynamicCount = next);
    widget.onTrace(widget.laneId, 'dynamic fields -> $_dynamicCount', widget.palette.accentB);
  }

  void _finish(bool shouldSave) {
    TextInput.finishAutofillContext(shouldSave: shouldSave);
    widget.onFinishAction(widget.laneId, shouldSave);
  }

  @override
  Widget build(BuildContext context) {
    final laneBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _laneHeader(),
        const SizedBox(height: 8),
        Expanded(
          child: AutofillGroup(
            onDisposeAction: widget.onDisposeAction,
            child: Builder(
              builder: (context) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _formFields(),
                            const SizedBox(height: 10),
                            _dynamicControls(),
                            const SizedBox(height: 10),
                            _actionButtons(),
                            const SizedBox(height: 10),
                            _AutofillStateProbe(
                              laneId: widget.laneId,
                              palette: widget.palette,
                              onSnapshot: widget.onSnapshot,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.showInspectorRail) ...<Widget>[
                      const SizedBox(width: 10),
                      SizedBox(width: widget.layout == _LaneLayout.split ? 220 : 170, child: _inspectorRail()),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: laneBody,
      ),
    );
  }

  Widget _laneHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.6)),
              const SizedBox(height: 2),
              Text(widget.subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 11.1)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: widget.palette.accentA.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'dispose: ${widget.onDisposeAction.name}',
            style: TextStyle(
              color: widget.palette.ink,
              fontFamily: 'monospace',
              fontSize: 10.1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _formFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _field(
            controller: _name,
            label: 'Full name',
            hints: const <String>[AutofillHints.name],
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 8),
          _field(
            controller: _email,
            label: 'Email',
            hints: const <String>[AutofillHints.email],
            icon: Icons.alternate_email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          _field(
            controller: _phone,
            label: 'Phone',
            hints: const <String>[AutofillHints.telephoneNumber],
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 8),
          _field(
            controller: _street,
            label: 'Street address',
            hints: const <String>[AutofillHints.streetAddressLine1],
            icon: Icons.home_outlined,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _field(
                  controller: _city,
                  label: 'City',
                  hints: const <String>[AutofillHints.addressCity],
                  icon: Icons.location_city_outlined,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _field(
                  controller: _postal,
                  label: 'Postal code',
                  hints: const <String>[AutofillHints.postalCode],
                  icon: Icons.markunread_mailbox_outlined,
                ),
              ),
            ],
          ),
          for (var i = 0; i < _extraControllers.length; i++) ...<Widget>[
            const SizedBox(height: 8),
            _field(
              controller: _extraControllers[i],
              label: 'Address line ${i + 2}',
              hints: const <String>[AutofillHints.streetAddressLine2],
              icon: Icons.short_text,
            ),
          ],
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required List<String> hints,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      autofillHints: hints,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: widget.palette.accentA),
        filled: true,
        fillColor: widget.palette.canvas,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _dynamicControls() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.palette.accentB.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Text('Dynamic optional fields', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 11.3)),
          const Spacer(),
          IconButton(
            onPressed: _dynamicCount > 1 ? () => _setDynamicCount(_dynamicCount - 1) : null,
            icon: const Icon(Icons.remove_circle_outline),
            tooltip: 'Remove optional field',
          ),
          Text('$_dynamicCount', style: TextStyle(color: widget.palette.ink, fontFamily: 'monospace', fontSize: 12)),
          IconButton(
            onPressed: _dynamicCount < 6 ? () => _setDynamicCount(_dynamicCount + 1) : null,
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add optional field',
          ),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        FilledButton.icon(
          onPressed: () => _finish(true),
          icon: const Icon(Icons.save_outlined, size: 16),
          label: const Text('finishAutofillContext save'),
        ),
        OutlinedButton.icon(
          onPressed: () => _finish(false),
          icon: const Icon(Icons.cancel_outlined, size: 16),
          label: const Text('finishAutofillContext cancel'),
        ),
      ],
    );
  }

  Widget _inspectorRail() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.palette.accentA.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Inspector', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 8),
          _railLine('lane', widget.laneId),
          _railLine('action', widget.onDisposeAction.name),
          _railLine('dynamic', '$_dynamicCount'),
          _railLine('layout', widget.layout.name),
          const SizedBox(height: 8),
          if (widget.showTips)
            Text(
              'Tip: Add or remove optional fields and watch client count in the probe card.',
              style: TextStyle(color: widget.palette.muted, fontSize: 10.5, height: 1.33),
            ),
        ],
      ),
    );
  }

  Widget _railLine(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 62,
            child: Text(
              key,
              style: TextStyle(
                color: widget.palette.muted,
                fontFamily: 'monospace',
                fontSize: 10,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: widget.palette.ink, fontSize: 10.2))),
        ],
      ),
    );
  }
}

class _AutofillStateProbe extends StatefulWidget {
  const _AutofillStateProbe({
    required this.laneId,
    required this.palette,
    required this.onSnapshot,
  });

  final String laneId;
  final _Palette palette;
  final ValueChanged<_ProbeSnapshot> onSnapshot;

  @override
  State<_AutofillStateProbe> createState() => _AutofillStateProbeState();
}

class _AutofillStateProbeState extends State<_AutofillStateProbe> {
  String _lastSignature = '';

  @override
  Widget build(BuildContext context) {
    final viaMaybe = AutofillGroup.maybeOf(context);
    final viaOf = viaMaybe == null ? null : AutofillGroup.of(context);
    final hasState = viaMaybe != null;
    final mounted = viaMaybe?.mounted ?? false;
    final maybeMatchesOf = hasState ? identical(viaMaybe, viaOf) : false;
    final clients = viaMaybe?.autofillClients.toList() ?? <dynamic>[];
    final ids = clients.map(_clientIdOf).toList();
    final firstId = ids.isEmpty ? '-' : ids.first;
    final missingLookup = viaMaybe?.getAutofillClient('non-existent-client') != null;

    final snapshot = _ProbeSnapshot(
      laneId: widget.laneId,
      hasState: hasState,
      mounted: mounted,
      maybeMatchesOf: maybeMatchesOf,
      clientCount: clients.length,
      firstClientId: firstId,
      lookupMissingClient: missingLookup,
      clientIds: ids,
    );

    if (_lastSignature != snapshot.signature) {
      _lastSignature = snapshot.signature;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onSnapshot(snapshot);
        }
      });
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: widget.palette.accentC.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: widget.palette.accentC.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('AutofillGroupState Probe', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 11.8)),
          const SizedBox(height: 6),
          _probeLine('has state', '$hasState'),
          _probeLine('mounted', '$mounted'),
          _probeLine('maybe == of', '$maybeMatchesOf'),
          _probeLine('client count', '${clients.length}'),
          _probeLine('first client id', firstId),
          _probeLine('lookup missing id', '$missingLookup'),
          const SizedBox(height: 6),
          Text(
            ids.isEmpty ? 'client ids: (none)' : 'client ids: ${ids.join(', ')}',
            style: TextStyle(color: widget.palette.muted, fontSize: 10.2, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _probeLine(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 96,
            child: Text(
              key,
              style: TextStyle(
                color: widget.palette.ink,
                fontFamily: 'monospace',
                fontSize: 10.1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: widget.palette.ink, fontSize: 10.4))),
        ],
      ),
    );
  }

  String _clientIdOf(dynamic client) {
    try {
      final id = client.autofillId;
      return id == null ? 'null' : id.toString();
    } catch (_) {
      return client.runtimeType.toString();
    }
  }
}
