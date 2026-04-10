import 'package:flutter/material.dart';

const Color _bg = Color(0xFF081422);
const Color _panel = Color(0xFF13253A);
const Color _panel2 = Color(0xFF1B3550);
const Color _ink = Color(0xFFD7E9FF);
const Color _primary = Color(0xFF7AD3FF);
const Color _accent = Color(0xFFFFD166);
const Color _ok = Color(0xFF7DDE92);
const Color _warn = Color(0xFFFFB86B);
const Color _err = Color(0xFFFF6B6B);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _primary,
        secondary: _accent,
        surface: _panel,
      ),
    ),
    home: const _SlottedMultiChildRenderObjectWidgetDemo(),
  );
}

class _SlottedMultiChildRenderObjectWidgetDemo extends StatefulWidget {
  const _SlottedMultiChildRenderObjectWidgetDemo();

  @override
  State<_SlottedMultiChildRenderObjectWidgetDemo> createState() =>
      _SlottedMultiChildRenderObjectWidgetDemoState();
}

class _SlottedMultiChildRenderObjectWidgetDemoState
    extends State<_SlottedMultiChildRenderObjectWidgetDemo>
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
        backgroundColor: _panel,
        title: const Text(
          'SlottedMultiChildRenderObjectWidget Deep Demo',
          style: TextStyle(color: _accent, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _accent,
          labelColor: _accent,
          unselectedLabelColor: _ink,
          tabs: const [
            Tab(text: 'Contract'),
            Tab(text: 'Slot Lab'),
            Tab(text: 'Render Sync'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ContractExplorerTab(),
          _SlotLayoutLabTab(),
          _RenderSyncTab(),
        ],
      ),
    );
  }
}

class _ContractExplorerTab extends StatefulWidget {
  const _ContractExplorerTab();

  @override
  State<_ContractExplorerTab> createState() => _ContractExplorerTabState();
}

class _ContractExplorerTabState extends State<_ContractExplorerTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedFacet = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _ContractFacet facet = _facets[_selectedFacet];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('What This Class Is For'),
          const SizedBox(height: 8),
          _panelBox(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BulletText(
                  'SlottedMultiChildRenderObjectWidget models render-object widgets with fixed named child positions (slots) instead of index-based children.',
                ),
                _BulletText(
                  'This is ideal when layout semantics depend on role (for example: leading/title/subtitle/trailing) rather than order alone.',
                ),
                _BulletText(
                  'Each slot can hold zero or one child, and slot identity remains stable across rebuilds to preserve state behavior.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Contract Facets'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_facets.length, (int index) {
                    final bool active = index == _selectedFacet;
                    final _ContractFacet item = _facets[index];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFacet = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? item.color.withValues(alpha: 0.2)
                              : Colors.transparent,
                          border: Border.all(color: active ? item.color : _panel2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: active ? item.color : _ink,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),
                _facetCard(facet),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Inheritance And Responsibilities'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _ContractRow(
                  left: 'Base Type',
                  right: 'RenderObjectWidget',
                  color: _primary,
                ),
                _ContractRow(
                  left: 'Element',
                  right: 'SlottedRenderObjectElement<SlotType, ChildType>',
                  color: _ok,
                ),
                _ContractRow(
                  left: 'Widget Duties',
                  right: 'Define slots and map each slot to an optional child widget.',
                  color: _accent,
                ),
                _ContractRow(
                  left: 'Render Duties',
                  right: 'Consume slot-child mapping and lay out each role correctly.',
                  color: _warn,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Typical Pattern'),
          const SizedBox(height: 8),
          _panelBox(
            child: _codeBlock(
              'enum CardSlot { icon, header, body, actions }\n\n'
              'class ExampleCard extends SlottedMultiChildRenderObjectWidget<CardSlot, RenderBox> {\n'
              '  const ExampleCard({super.key, this.icon, this.header, this.body, this.actions});\n\n'
              '  final Widget? icon;\n'
              '  final Widget? header;\n'
              '  final Widget? body;\n'
              '  final Widget? actions;\n\n'
              '  @override\n'
              '  Iterable<CardSlot> get slots => CardSlot.values;\n\n'
              '  @override\n'
              '  Widget? childForSlot(CardSlot slot) => switch (slot) {\n'
              '    CardSlot.icon => icon,\n'
              '    CardSlot.header => header,\n'
              '    CardSlot.body => body,\n'
              '    CardSlot.actions => actions,\n'
              '  };\n'
              '}',
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('When To Choose Slotted Widgets'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _BulletText('Choose slot-based design when each child has a semantic role and stable place in layout.'),
                _BulletText('Avoid slot-based design for variable-length homogeneous child lists; use MultiChildRenderObjectWidget for those.'),
                _BulletText('Use enums for slots for exhaustive, readable child mappings.'),
                _BulletText('Combine with keys when children may migrate across slots and need state preservation.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _facetCard(_ContractFacet facet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: facet.color.withValues(alpha: 0.11),
        border: Border.all(color: facet.color.withValues(alpha: 0.8)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            facet.summary,
            style: const TextStyle(color: _ink, fontSize: 11),
          ),
          const SizedBox(height: 8),
          ...facet.details.map(
            (String line) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_right_alt_rounded, size: 16, color: facet.color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(line, style: const TextStyle(color: _ink, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _LabSlot { leading, title, subtitle, trailing, footer }

class _SlotLayoutLabTab extends StatefulWidget {
  const _SlotLayoutLabTab();

  @override
  State<_SlotLayoutLabTab> createState() => _SlotLayoutLabTabState();
}

class _SlotLayoutLabTabState extends State<_SlotLayoutLabTab>
    with AutomaticKeepAliveClientMixin {
  bool _leading = true;
  bool _title = true;
  bool _subtitle = true;
  bool _trailing = true;
  bool _footer = false;
  bool _dense = false;
  bool _emphasizeTitle = false;
  double _corner = 14;
  final List<String> _log = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Map<_LabSlot, bool> active = <_LabSlot, bool>{
      _LabSlot.leading: _leading,
      _LabSlot.title: _title,
      _LabSlot.subtitle: _subtitle,
      _LabSlot.trailing: _trailing,
      _LabSlot.footer: _footer,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Live Slot Composition'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Toggle slot visibility to simulate childForSlot(slot) returning a widget or null for each slot.',
                  style: TextStyle(color: _ink, fontSize: 11),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _toggleChip('leading', _leading, _primary, () => _flip('leading')),
                    _toggleChip('title', _title, _accent, () => _flip('title')),
                    _toggleChip('subtitle', _subtitle, _ok, () => _flip('subtitle')),
                    _toggleChip('trailing', _trailing, _warn, () => _flip('trailing')),
                    _toggleChip('footer', _footer, _err, () => _flip('footer')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeThumbColor: _primary,
                        title: const Text('Dense mode', style: TextStyle(fontSize: 11, color: _ink)),
                        value: _dense,
                        onChanged: (bool value) {
                          setState(() => _dense = value);
                          _addLog('dense mode -> $value');
                        },
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeThumbColor: _accent,
                        title: const Text('Emphasize title', style: TextStyle(fontSize: 11, color: _ink)),
                        value: _emphasizeTitle,
                        onChanged: (bool value) {
                          setState(() => _emphasizeTitle = value);
                          _addLog('title emphasis -> $value');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Card corner radius', style: TextStyle(color: _ink, fontSize: 11)),
                Slider(
                  min: 6,
                  max: 30,
                  value: _corner,
                  activeColor: _accent,
                  onChanged: (double value) {
                    setState(() => _corner = value);
                  },
                  onChangeEnd: (double value) => _addLog('corner radius -> ${value.toStringAsFixed(0)}'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Visual Slot Preview'),
          const SizedBox(height: 8),
          _panelBox(
            child: _simulatedSlottedCard(
              active: active,
              dense: _dense,
              emphasizeTitle: _emphasizeTitle,
              corner: _corner,
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Slot Map Inspector'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: _LabSlot.values
                  .map(
                    (_LabSlot slot) => _slotInspectorRow(slot: slot, active: active[slot] ?? false),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Event Log'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: _bg,
                border: Border.all(color: _panel2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _log.isEmpty
                  ? const Center(
                      child: Text('No changes yet.', style: TextStyle(color: _ink, fontSize: 11)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _log.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _panel,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _log[index],
                            style: const TextStyle(color: _accent, fontFamily: 'monospace', fontSize: 10),
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

  Widget _simulatedSlottedCard({
    required Map<_LabSlot, bool> active,
    required bool dense,
    required bool emphasizeTitle,
    required double corner,
  }) {
    final double pad = dense ? 8 : 12;
    final TextStyle titleStyle = TextStyle(
      color: _ink,
      fontSize: emphasizeTitle ? 16 : 14,
      fontWeight: emphasizeTitle ? FontWeight.w700 : FontWeight.w600,
    );
    final TextStyle bodyStyle = TextStyle(
      color: _ink.withValues(alpha: 0.92),
      fontSize: dense ? 11 : 12,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: _panel2,
        borderRadius: BorderRadius.circular(corner),
        border: Border.all(color: _primary.withValues(alpha: 0.65)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (active[_LabSlot.leading] ?? false)
                Container(
                  width: dense ? 38 : 46,
                  height: dense ? 38 : 46,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _primary),
                  ),
                  child: const Icon(Icons.widgets_outlined, color: _primary),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (active[_LabSlot.title] ?? false)
                      Text('Slot: title', style: titleStyle)
                    else
                      _missingSlot('title'),
                    const SizedBox(height: 5),
                    if (active[_LabSlot.subtitle] ?? false)
                      Text(
                        'Slot: subtitle - helps explain role-based child arrangement in slotted widgets.',
                        style: bodyStyle,
                      )
                    else
                      _missingSlot('subtitle'),
                  ],
                ),
              ),
              if (active[_LabSlot.trailing] ?? false)
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(horizontal: dense ? 9 : 11, vertical: dense ? 7 : 8),
                  decoration: BoxDecoration(
                    color: _warn.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: _warn),
                  ),
                  child: Text(
                    'TRAILING',
                    style: TextStyle(
                      color: _warn,
                      fontSize: dense ? 9 : 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          if (active[_LabSlot.footer] ?? false) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _err.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _err.withValues(alpha: 0.7)),
              ),
              child: const Text(
                'Slot: footer - optional secondary area for metadata, warnings, or quick actions.',
                style: TextStyle(color: _ink, fontSize: 11),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _missingSlot(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _err.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _err.withValues(alpha: 0.8)),
      ),
      child: Text(
        'Slot "$name" is null',
        style: const TextStyle(color: _err, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: value ? color.withValues(alpha: 0.17) : Colors.transparent,
          border: Border.all(color: value ? color : _panel2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: value ? color : _ink,
            fontSize: 11,
            fontWeight: value ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _slotInspectorRow({required _LabSlot slot, required bool active}) {
    final Color color = switch (slot) {
      _LabSlot.leading => _primary,
      _LabSlot.title => _accent,
      _LabSlot.subtitle => _ok,
      _LabSlot.trailing => _warn,
      _LabSlot.footer => _err,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.14) : _bg,
        border: Border.all(color: active ? color.withValues(alpha: 0.8) : _panel2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              slot.name,
              style: TextStyle(
                color: active ? color : _ink,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ),
          Text(
            active ? 'childForSlot -> Widget' : 'childForSlot -> null',
            style: TextStyle(
              color: active ? color : _ink.withValues(alpha: 0.9),
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  void _flip(String slotName) {
    setState(() {
      switch (slotName) {
        case 'leading':
          _leading = !_leading;
        case 'title':
          _title = !_title;
        case 'subtitle':
          _subtitle = !_subtitle;
        case 'trailing':
          _trailing = !_trailing;
        case 'footer':
          _footer = !_footer;
      }
    });
    _addLog('toggle slot: $slotName');
  }

  void _addLog(String text) {
    final String now = TimeOfDay.now().format(context);
    setState(() {
      _log.insert(0, '$now | $text');
      if (_log.length > 28) {
        _log.removeLast();
      }
    });
  }
}

class _RenderSyncTab extends StatefulWidget {
  const _RenderSyncTab();

  @override
  State<_RenderSyncTab> createState() => _RenderSyncTabState();
}

class _RenderSyncTabState extends State<_RenderSyncTab>
    with AutomaticKeepAliveClientMixin {
  final List<_SyncEvent> _events = <_SyncEvent>[];
  double _phase = 0;
  bool _showKeys = true;
  bool _slotMove = false;

  @override
  void initState() {
    super.initState();
    _seedEvents();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Widget -> Element -> RenderObject Synchronization'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This timeline demonstrates how slot child changes propagate through the slotted element into render-object child assignment.',
                  style: TextStyle(color: _ink, fontSize: 11),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _enqueueMount,
                        icon: const Icon(Icons.rocket_launch_rounded, size: 16),
                        label: const Text('Mount cycle'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _enqueueUpdate,
                        icon: const Icon(Icons.autorenew_rounded, size: 16),
                        label: const Text('Update cycle'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _enqueueDetach,
                        icon: const Icon(Icons.link_off_rounded, size: 16),
                        label: const Text('Detach child'),
                        style: ElevatedButton.styleFrom(backgroundColor: _warn.withValues(alpha: 0.35)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _enqueueForget,
                        icon: const Icon(Icons.delete_sweep_rounded, size: 16),
                        label: const Text('forgetChild'),
                        style: ElevatedButton.styleFrom(backgroundColor: _err.withValues(alpha: 0.28)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeThumbColor: _ok,
                        value: _showKeys,
                        onChanged: (bool value) {
                          setState(() => _showKeys = value);
                          _events.insert(0, _SyncEvent('UI', 'show keyed migration markers: $value', _ok));
                        },
                        title: const Text('Show keyed migration hints', style: TextStyle(fontSize: 11, color: _ink)),
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeThumbColor: _accent,
                        value: _slotMove,
                        onChanged: (bool value) {
                          setState(() => _slotMove = value);
                          _events.insert(0, _SyncEvent('UI', 'simulate keyed slot move: $value', _accent));
                        },
                        title: const Text('Simulate slot move', style: TextStyle(fontSize: 11, color: _ink)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text('Timeline phase', style: TextStyle(color: _ink, fontSize: 11)),
                Slider(
                  min: 0,
                  max: 4,
                  divisions: 4,
                  value: _phase,
                  activeColor: _accent,
                  label: _phaseLabel(_phase.toInt()),
                  onChanged: (double value) {
                    setState(() => _phase = value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Pipeline Stage Board'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                _stageTile(
                  active: _phase >= 0,
                  title: '0. Widget snapshot',
                  subtitle: 'childForSlot map prepared from current widget fields.',
                  color: _primary,
                ),
                _stageTile(
                  active: _phase >= 1,
                  title: '1. Element diff',
                  subtitle: 'SlottedRenderObjectElement compares slot assignments and keys.',
                  color: _accent,
                ),
                _stageTile(
                  active: _phase >= 2,
                  title: '2. Child updates',
                  subtitle: _slotMove
                      ? 'Keyed child migrates to new slot while preserving state.'
                      : 'Children are updated in-place for unchanged slots.',
                  color: _ok,
                ),
                _stageTile(
                  active: _phase >= 3,
                  title: '3. Render wiring',
                  subtitle: 'Render object receives setChildForSlot style updates.',
                  color: _warn,
                ),
                _stageTile(
                  active: _phase >= 4,
                  title: '4. Layout + paint',
                  subtitle: 'Geometry and visual order reflect final slot occupancy.',
                  color: _err,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Operational Timeline'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: _events.isEmpty
                  ? const Center(child: Text('No events recorded.', style: TextStyle(color: _ink, fontSize: 11)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _events.length,
                      itemBuilder: (BuildContext context, int index) {
                        final _SyncEvent event = _events[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: event.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: event.color.withValues(alpha: 0.7)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 58,
                                child: Text(
                                  event.stage,
                                  style: TextStyle(
                                    color: event.color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  event.message,
                                  style: const TextStyle(color: _ink, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 14),
          _sectionTitle('Guidance'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BulletText(
                  _showKeys
                      ? 'Keyed children should be used when business state must survive slot movement.'
                      : 'Without keys, slot migration is interpreted as remove+insert, often resetting state.',
                ),
                _BulletText(
                  'Keep slot sets static. Adding or removing slot identifiers at runtime violates core assumptions of slotted elements.',
                ),
                _BulletText(
                  'Treat slot labels as semantic contracts between widget, element, and render object layers.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _phaseLabel(int phase) {
    return switch (phase) {
      0 => 'Widget',
      1 => 'Element diff',
      2 => 'Child update',
      3 => 'Render wiring',
      _ => 'Layout/paint',
    };
  }

  Widget _stageTile({
    required bool active,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.15) : _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? color.withValues(alpha: 0.85) : _panel2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: active ? color : _ink,
              fontSize: 11,
              fontWeight: active ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(color: _ink, fontSize: 10)),
        ],
      ),
    );
  }

  void _seedEvents() {
    _events
      ..clear()
      ..addAll(<_SyncEvent>[
        const _SyncEvent('INIT', 'Demo initialized. Ready to simulate slotted render pipeline.', _primary),
      ]);
  }

  void _enqueueMount() {
    setState(() {
      _events.insert(0, const _SyncEvent('WIDGET', 'build() produced slot map for 5 slots.', _primary));
      _events.insert(0, const _SyncEvent('ELEMENT', 'mount() inflated child elements for non-null slots.', _accent));
      _events.insert(0, const _SyncEvent('RENDER', 'renderObject.setChildForSlot called per active slot.', _warn));
      if (_showKeys) {
        _events.insert(0, const _SyncEvent('KEYS', 'Initial keyed index built for slot migration tracking.', _ok));
      }
    });
  }

  void _enqueueUpdate() {
    setState(() {
      _events.insert(0, const _SyncEvent('WIDGET', 'Widget configuration changed: title style and subtitle text.', _primary));
      _events.insert(0, const _SyncEvent('ELEMENT', 'updateChildren() diffed old/new slot bindings.', _accent));
      if (_slotMove) {
        _events.insert(0, const _SyncEvent('ELEMENT', 'Keyed child moved trailing -> footer without state reset.', _ok));
      }
      _events.insert(0, const _SyncEvent('RENDER', 'updateRenderObject propagated visual parameters.', _warn));
    });
  }

  void _enqueueDetach() {
    setState(() {
      _events.insert(0, const _SyncEvent('ELEMENT', 'childForSlot returned null for subtitle; detached child element.', _err));
      _events.insert(0, const _SyncEvent('RENDER', 'Render object cleared slot binding and marked layout dirty.', _warn));
    });
  }

  void _enqueueForget() {
    setState(() {
      _events.insert(0, const _SyncEvent('ELEMENT', 'forgetChild invoked during deactivation cascade.', _err));
      _events.insert(0, const _SyncEvent('RENDER', 'Associated slot child reference removed.', _warn));
    });
  }
}

class _ContractFacet {
  const _ContractFacet({
    required this.name,
    required this.summary,
    required this.details,
    required this.color,
  });

  final String name;
  final String summary;
  final List<String> details;
  final Color color;
}

class _SyncEvent {
  const _SyncEvent(this.stage, this.message, this.color);

  final String stage;
  final String message;
  final Color color;
}

const List<_ContractFacet> _facets = <_ContractFacet>[
  _ContractFacet(
    name: 'slots',
    summary: 'The slots getter declares the complete static slot universe for this widget.',
    details: <String>[
      'Use an enum to guarantee fixed identifiers and readable switch mapping.',
      'Order can matter for iteration/diagnostics but not for semantic role identity.',
      'Do not mutate slot set shape over widget lifetime.',
    ],
    color: _primary,
  ),
  _ContractFacet(
    name: 'childForSlot',
    summary: 'Maps each slot to a widget or null during build snapshots.',
    details: <String>[
      'Returning null means the slot is intentionally empty in this frame.',
      'Changes here drive element diff behavior and render child updates.',
      'Use concise switch expressions for maintainability.',
    ],
    color: _accent,
  ),
  _ContractFacet(
    name: 'element bridge',
    summary: 'SlottedRenderObjectElement connects slot maps to concrete element children.',
    details: <String>[
      'Performs diffing across frames and lifecycle transitions.',
      'Can preserve child state through key-based migration.',
      'Enforces slot consistency assumptions in debug flows.',
    ],
    color: _ok,
  ),
  _ContractFacet(
    name: 'render update',
    summary: 'Render object receives slot-child wiring and performs role-aware layout.',
    details: <String>[
      'Render layer decides geometry, paint order, and hit testing by slot role.',
      'Widget updateRenderObject pushes non-child configuration values.',
      'Keep slot semantics documented to avoid layout ambiguity.',
    ],
    color: _warn,
  ),
  _ContractFacet(
    name: 'keys & movement',
    summary: 'Keys support child identity preservation when widgets move across slots.',
    details: <String>[
      'Use LocalKey for stable role migration scenarios.',
      'Without keys, migration is often interpreted as remove/insert.',
      'Prefer explicit key strategy for complex adaptive layouts.',
    ],
    color: _err,
  ),
];

class _ContractRow extends StatelessWidget {
  const _ContractRow({required this.left, required this.right, required this.color});

  final String left;
  final String right;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              left,
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(right, style: const TextStyle(color: _ink, fontSize: 10))),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _ink, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _sectionTitle(String text) {
  return Text(
    text,
    style: const TextStyle(color: _accent, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _panelBox({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _panel2),
    ),
    child: child,
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      code,
      style: const TextStyle(color: _primary, fontSize: 10, fontFamily: 'monospace'),
    ),
  );
}
