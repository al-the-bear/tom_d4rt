import 'package:flutter/material.dart';

const Color _bg = Color(0xFF101017);
const Color _card = Color(0xFF1F2130);
const Color _card2 = Color(0xFF2D3044);
const Color _text = Color(0xFFD9DFF8);
const Color _cyan = Color(0xFF66E3FF);
const Color _lime = Color(0xFFB7F171);
const Color _amber = Color(0xFFFFC971);
const Color _rose = Color(0xFFFF8FA3);
const Color _violet = Color(0xFFCFA6FF);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _cyan,
        secondary: _amber,
        surface: _card,
      ),
    ),
    home: const _SlottedRenderObjectElementDemo(),
  );
}

class _SlottedRenderObjectElementDemo extends StatefulWidget {
  const _SlottedRenderObjectElementDemo();

  @override
  State<_SlottedRenderObjectElementDemo> createState() =>
      _SlottedRenderObjectElementDemoState();
}

class _SlottedRenderObjectElementDemoState extends State<_SlottedRenderObjectElementDemo>
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
        backgroundColor: _card,
        title: const Text(
          'SlottedRenderObjectElement Deep Demo',
          style: TextStyle(color: _amber, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _amber,
          labelColor: _amber,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Lifecycle'),
            Tab(text: 'Keyed Diff'),
            Tab(text: 'Diagnostics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _LifecycleTab(),
          _KeyedDiffTab(),
          _DiagnosticsTab(),
        ],
      ),
    );
  }
}

class _LifecycleTab extends StatefulWidget {
  const _LifecycleTab();

  @override
  State<_LifecycleTab> createState() => _LifecycleTabState();
}

class _LifecycleTabState extends State<_LifecycleTab>
    with AutomaticKeepAliveClientMixin {
  int _phase = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _PhaseDetail detail = _phaseDetails[_phase];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Role Of SlottedRenderObjectElement'),
          const SizedBox(height: 8),
          _panel(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DotLine('Bridges slot-based widget declarations to concrete Element children.'),
                _DotLine('Tracks slot -> Element mapping and optional key -> Element map for migration.'),
                _DotLine('Coordinates mount/update/forget lifecycle and render-object child wiring.'),
                _DotLine('Enforces slot-set invariants for reliable role-based layout behavior.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Lifecycle Timeline'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_phaseDetails.length, (int index) {
                    final bool active = index == _phase;
                    final _PhaseDetail info = _phaseDetails[index];
                    return GestureDetector(
                      onTap: () => setState(() => _phase = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? info.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: active ? info.color : _card2),
                        ),
                        child: Text(
                          info.short,
                          style: TextStyle(
                            color: active ? info.color : _text,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _phaseCard(detail),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Pipeline Visualization'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: [
                _pipelineNode(
                  index: 0,
                  name: 'Widget Snapshot',
                  desc: 'childForSlot() queried for each static slot.',
                  color: _cyan,
                ),
                _arrow(),
                _pipelineNode(
                  index: 1,
                  name: 'Element Diff',
                  desc: 'Old/new slot children are matched by key or slot identity.',
                  color: _violet,
                ),
                _arrow(),
                _pipelineNode(
                  index: 2,
                  name: 'Mount/Update Child',
                  desc: 'Element tree gets inflated, updated, or detached as needed.',
                  color: _lime,
                ),
                _arrow(),
                _pipelineNode(
                  index: 3,
                  name: 'Render Child Wiring',
                  desc: 'Slot assignments are pushed to render object child fields.',
                  color: _amber,
                ),
                _arrow(),
                _pipelineNode(
                  index: 4,
                  name: 'Layout/Paint',
                  desc: 'Render object computes geometry with final slot occupancy.',
                  color: _rose,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('API Hooks Reference'),
          const SizedBox(height: 8),
          _panel(
            child: _code(
              'class SlottedRenderObjectElement<SlotType, ChildType extends RenderObject>\n'
              '    extends RenderObjectElement {\n'
              '  @override\n'
              '  void mount(Element? parent, Object? newSlot) { ... }\n\n'
              '  @override\n'
              '  void update(covariant Widget newWidget) { ... }\n\n'
              '  @override\n'
              '  void forgetChild(Element child) { ... }\n\n'
              '  void _updateChildren() {\n'
              '    // slot diff + key migration logic\n'
              '  }\n'
              '}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _phaseCard(_PhaseDetail detail) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: detail.color.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: detail.color.withValues(alpha: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(detail.summary, style: const TextStyle(color: _text, fontSize: 11)),
          const SizedBox(height: 8),
          ...detail.points.map(
            (String e) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, size: 9, color: detail.color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(e, style: const TextStyle(color: _text, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pipelineNode({
    required int index,
    required String name,
    required String desc,
    required Color color,
  }) {
    final bool active = index <= _phase;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.16) : _card2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? color.withValues(alpha: 0.9) : _card2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: active ? color : _text,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(desc, style: const TextStyle(color: _text, fontSize: 10)),
        ],
      ),
    );
  }
}

enum _CardSlot { leading, title, subtitle, trailing }

class _KeyedDiffTab extends StatefulWidget {
  const _KeyedDiffTab();

  @override
  State<_KeyedDiffTab> createState() => _KeyedDiffTabState();
}

class _KeyedDiffTabState extends State<_KeyedDiffTab>
    with AutomaticKeepAliveClientMixin {
  bool _leading = true;
  bool _titleSlot = true;
  bool _subtitleSlot = true;
  bool _trailing = true;

  bool _keyA = true;
  bool _keyB = true;
  bool _moveTitleToSubtitle = false;

  final List<String> _events = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<_VisualChild> children = <_VisualChild>[
      if (_leading)
        _VisualChild(
          slot: _CardSlot.leading,
          keyName: _keyA ? 'k-leading' : null,
          label: 'Leading Icon',
          color: _cyan,
        ),
      if (_titleSlot)
        _VisualChild(
          slot: _moveTitleToSubtitle ? _CardSlot.subtitle : _CardSlot.title,
          keyName: _keyB ? 'k-title' : null,
          label: 'Primary Title',
          color: _amber,
        ),
      if (_subtitleSlot)
        _VisualChild(
          slot: _moveTitleToSubtitle ? _CardSlot.title : _CardSlot.subtitle,
          keyName: 'k-subtitle',
          label: 'Secondary Text',
          color: _lime,
        ),
      if (_trailing)
        _VisualChild(
          slot: _CardSlot.trailing,
          keyName: 'k-trailing',
          label: 'Action Chip',
          color: _rose,
        ),
    ];

    final Map<_CardSlot, _VisualChild> map = <_CardSlot, _VisualChild>{
      for (final _VisualChild child in children) child.slot: child,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Keyed Slot Diff Simulator'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Simulate updateChildren behavior with slot reassignment and optional keys.',
                  style: TextStyle(color: _text, fontSize: 11),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _chip('leading', _leading, _cyan, () => _toggleSlot('leading')),
                    _chip('title', _titleSlot, _amber, () => _toggleSlot('title')),
                    _chip('subtitle', _subtitleSlot, _lime, () => _toggleSlot('subtitle')),
                    _chip('trailing', _trailing, _rose, () => _toggleSlot('trailing')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Key on leading', style: TextStyle(fontSize: 11, color: _text)),
                        value: _keyA,
                        activeThumbColor: _cyan,
                        onChanged: (bool value) {
                          setState(() => _keyA = value);
                          _log('leading key -> $value');
                        },
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Key on title', style: TextStyle(fontSize: 11, color: _text)),
                        value: _keyB,
                        activeThumbColor: _amber,
                        onChanged: (bool value) {
                          setState(() => _keyB = value);
                          _log('title key -> $value');
                        },
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Move title child into subtitle slot', style: TextStyle(fontSize: 11, color: _text)),
                  value: _moveTitleToSubtitle,
                  activeThumbColor: _violet,
                  onChanged: (bool value) {
                    setState(() => _moveTitleToSubtitle = value);
                    _log('simulate slot migration title <-> subtitle: $value');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Visual Slot Board'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: [
                _slotCell(_CardSlot.leading, map[_CardSlot.leading]),
                const SizedBox(height: 6),
                _slotCell(_CardSlot.title, map[_CardSlot.title]),
                const SizedBox(height: 6),
                _slotCell(_CardSlot.subtitle, map[_CardSlot.subtitle]),
                const SizedBox(height: 6),
                _slotCell(_CardSlot.trailing, map[_CardSlot.trailing]),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Diff Explanation'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DotLine(
                  _moveTitleToSubtitle
                      ? 'Title child moved slots. With a key, the element can migrate and keep state.'
                      : 'Title child remains in place, so updateChildren performs in-slot update.',
                ),
                _DotLine(
                  _keyB
                      ? 'Keyed match path enabled for title element identity.'
                      : 'No key for title: slot swap can trigger remove + inflate semantics.',
                ),
                _DotLine(
                  _keyA
                      ? 'Leading child has stable key and survives reorder operations.'
                      : 'Leading child relies on slot-only identity.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Event Stream'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: _bg,
                border: Border.all(color: _card2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _events.isEmpty
                  ? const Center(child: Text('No changes yet.', style: TextStyle(color: _text, fontSize: 11)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _events.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _card,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _events[index],
                            style: const TextStyle(color: _amber, fontFamily: 'monospace', fontSize: 10),
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

  Widget _chip(String text, bool active, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: active ? color.withValues(alpha: 0.17) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: active ? color : _card2),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? color : _text,
            fontSize: 11,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _slotCell(_CardSlot slot, _VisualChild? child) {
    final Color slotColor = switch (slot) {
      _CardSlot.leading => _cyan,
      _CardSlot.title => _amber,
      _CardSlot.subtitle => _lime,
      _CardSlot.trailing => _rose,
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _card2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: slotColor.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: Text(
              slot.name,
              style: TextStyle(color: slotColor, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: child == null
                ? const Text(
                    'childForSlot -> null',
                    style: TextStyle(color: _text, fontSize: 10, fontFamily: 'monospace'),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.label, style: TextStyle(color: child.color, fontSize: 11, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(
                        child.keyName == null
                            ? 'key: none (slot identity only)'
                            : 'key: ${child.keyName} (migration-safe)',
                        style: const TextStyle(color: _text, fontSize: 10, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _toggleSlot(String name) {
    setState(() {
      switch (name) {
        case 'leading':
          _leading = !_leading;
        case 'title':
          _titleSlot = !_titleSlot;
        case 'subtitle':
          _subtitleSlot = !_subtitleSlot;
        case 'trailing':
          _trailing = !_trailing;
      }
    });
    _log('toggle slot: $name');
  }

  void _log(String message) {
    final String time = TimeOfDay.now().format(context);
    setState(() {
      _events.insert(0, '$time | $message');
      if (_events.length > 30) {
        _events.removeLast();
      }
    });
  }
}

class _DiagnosticsTab extends StatefulWidget {
  const _DiagnosticsTab();

  @override
  State<_DiagnosticsTab> createState() => _DiagnosticsTabState();
}

class _DiagnosticsTabState extends State<_DiagnosticsTab>
    with AutomaticKeepAliveClientMixin {
  bool _duplicateSlots = false;
  bool _dynamicSlots = false;
  bool _duplicateKeys = false;
  bool _slotNullUnexpectedly = false;
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<_IssueCard> issues = <_IssueCard>[
      _IssueCard(
        title: 'Duplicate slot identifiers',
        description: 'The static slots iterable must not contain the same slot twice.',
        impact: 'Diff logic becomes ambiguous and child wiring can be inconsistent.',
        fix: 'Use enum values and avoid runtime-generated slot collections.',
        severity: _rose,
        active: _duplicateSlots,
      ),
      _IssueCard(
        title: 'Changing slot set shape at runtime',
        description: 'Adding/removing slot identifiers across frames violates invariants.',
        impact: 'Element assertions and stale slot mappings become likely.',
        fix: 'Keep slot universe static; vary only child presence (null/non-null).',
        severity: _amber,
        active: _dynamicSlots,
      ),
      _IssueCard(
        title: 'Duplicate keys in slotted children',
        description: 'Two children sharing one key break keyed migration semantics.',
        impact: 'Incorrect state association and debug errors.',
        fix: 'Generate unique LocalKey values per logical child identity.',
        severity: _violet,
        active: _duplicateKeys,
      ),
      _IssueCard(
        title: 'Unexpected null for required role',
        description: 'A critical slot returns null when render logic expects a child.',
        impact: 'Layout gaps or fallback branches may trigger degraded visuals.',
        fix: 'Define role requirements and guard in widget API contract.',
        severity: _lime,
        active: _slotNullUnexpectedly,
      ),
    ];

    final _IssueCard focused = issues[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Diagnostics And Failure Modes'),
          const SizedBox(height: 8),
          _panel(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DotLine('SlottedRenderObjectElement carries strict assumptions to keep slot-role layout deterministic.'),
                _DotLine('This tab visualizes common mistakes and how to reason about corrections.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Toggle Failure Flags'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: [
                _flagRow('duplicate slots', _duplicateSlots, _rose, (bool v) => setState(() => _duplicateSlots = v)),
                _flagRow('dynamic slot set', _dynamicSlots, _amber, (bool v) => setState(() => _dynamicSlots = v)),
                _flagRow('duplicate keys', _duplicateKeys, _violet, (bool v) => setState(() => _duplicateKeys = v)),
                _flagRow('unexpected null', _slotNullUnexpectedly, _lime, (bool v) => setState(() => _slotNullUnexpectedly = v)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Issue Cards'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: List.generate(issues.length, (int index) {
                final _IssueCard issue = issues[index];
                final bool focusedCard = _selected == index;
                return GestureDetector(
                  onTap: () => setState(() => _selected = index),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 7),
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: focusedCard
                          ? issue.severity.withValues(alpha: 0.16)
                          : issue.active
                              ? issue.severity.withValues(alpha: 0.1)
                              : _card2,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: focusedCard
                            ? issue.severity.withValues(alpha: 0.95)
                            : issue.active
                                ? issue.severity.withValues(alpha: 0.7)
                                : _card2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          issue.active ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                          color: issue.active ? issue.severity : _lime,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            issue.title,
                            style: TextStyle(
                              color: issue.active ? issue.severity : _text,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          issue.active ? 'ACTIVE' : 'OK',
                          style: TextStyle(
                            color: issue.active ? issue.severity : _lime,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),
          _title('Focused Guidance'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: focused.severity.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: focused.severity.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(focused.title, style: TextStyle(color: focused.severity, fontSize: 12, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text('Description: ${focused.description}', style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 5),
                  Text('Impact: ${focused.impact}', style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 5),
                  Text('Fix: ${focused.fix}', style: const TextStyle(color: _text, fontSize: 11)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Debug Checklist'),
          const SizedBox(height: 8),
          _panel(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DotLine('Confirm slots iterable is static and unique.'),
                _DotLine('Inspect key uniqueness across all non-null children.'),
                _DotLine('Log childForSlot output for each slot during update().'),
                _DotLine('Check forgetChild paths to ensure slot map cleanup.'),
                _DotLine('Validate render object receives expected child assignment transitions.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flagRow(String label, bool value, Color color, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(color: _text, fontSize: 11)),
      value: value,
      activeThumbColor: color,
      onChanged: onChanged,
    );
  }
}

class _VisualChild {
  const _VisualChild({
    required this.slot,
    required this.keyName,
    required this.label,
    required this.color,
  });

  final _CardSlot slot;
  final String? keyName;
  final String label;
  final Color color;
}

class _IssueCard {
  const _IssueCard({
    required this.title,
    required this.description,
    required this.impact,
    required this.fix,
    required this.severity,
    required this.active,
  });

  final String title;
  final String description;
  final String impact;
  final String fix;
  final Color severity;
  final bool active;
}

class _PhaseDetail {
  const _PhaseDetail({
    required this.short,
    required this.summary,
    required this.points,
    required this.color,
  });

  final String short;
  final String summary;
  final List<String> points;
  final Color color;
}

const List<_PhaseDetail> _phaseDetails = [
  _PhaseDetail(
    short: 'mount',
    summary: 'Initial inflation: all non-null slot children are created and mapped.',
    points: [
      'Element collects widget slot map snapshot.',
      'Inflates child elements for each present slot.',
      'Initial keyed map can be prepared for migration support.',
    ],
    color: _cyan,
  ),
  _PhaseDetail(
    short: 'update',
    summary: 'Rebuild diff: old and new slot children are compared for updates/replacements.',
    points: [
      'Keyed matching is attempted where possible.',
      'Slot-based fallback handles non-keyed children.',
      'Children may be updated, detached, or inflated.',
    ],
    color: _violet,
  ),
  _PhaseDetail(
    short: 'forget',
    summary: 'Child disposal path removes stale references from slot bookkeeping maps.',
    points: [
      'Called when a child leaves the tree.',
      'Slot->child and key->child caches are cleaned.',
      'Prevents stale pointers across future updates.',
    ],
    color: _rose,
  ),
  _PhaseDetail(
    short: 'wire',
    summary: 'Render object child assignments are synchronized with current slot mapping.',
    points: [
      'Each slot update is propagated to render object state.',
      'Render object marks layout/paint as needed.',
      'Visual output reflects final role occupancy.',
    ],
    color: _amber,
  ),
  _PhaseDetail(
    short: 'steady',
    summary: 'Stable frame where slot identity and child state are consistent.',
    points: [
      'No unexpected slot shape changes.',
      'Keys preserve intended identity across role movement.',
      'Subsequent updates remain predictable.',
    ],
    color: _lime,
  ),
];

class _DotLine extends StatelessWidget {
  const _DotLine(this.text);

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
            decoration: const BoxDecoration(color: _amber, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _title(String value) {
  return Text(
    value,
    style: const TextStyle(color: _amber, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _panel({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _card,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _card2),
    ),
    child: child,
  );
}

Widget _code(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _card2),
    ),
    child: Text(
      text,
      style: const TextStyle(color: _cyan, fontSize: 10, fontFamily: 'monospace'),
    ),
  );
}

Widget _arrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Icon(Icons.south_rounded, size: 14, color: _text),
  );
}
