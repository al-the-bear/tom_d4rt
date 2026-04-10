import 'package:flutter/material.dart';

const Color _p = Color(0xFF4527A0);
const Color _a = Color(0xFFA7FFEB);
const Color _bg = Color(0xFF0C0F16);
const Color _panel = Color(0xFF1A1F2D);
const Color _panel2 = Color(0xFF242B3C);
const Color _txt = Color(0xFFB4C0D4);
const Color _ok = Color(0xFF66BB6A);
const Color _warn = Color(0xFFFFCA28);
const Color _err = Color(0xFFEF5350);
const Color _info = Color(0xFF4FC3F7);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _p,
        secondary: _a,
        surface: _panel,
      ),
    ),
    home: const _SliverReorderableListStateDemo(),
  );
}

class _SliverReorderableListStateDemo extends StatefulWidget {
  const _SliverReorderableListStateDemo();

  @override
  State<_SliverReorderableListStateDemo> createState() =>
      _SliverReorderableListStateDemoState();
}

class _SliverReorderableListStateDemoState
    extends State<_SliverReorderableListStateDemo>
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
          'SliverReorderableListState',
          style: TextStyle(
            color: _a,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _a,
          labelColor: _a,
          unselectedLabelColor: _txt,
          tabs: const [
            Tab(text: 'State API'),
            Tab(text: 'Drag Lab'),
            Tab(text: 'Auto Scroll'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _StateApiTab(),
          _DragLabTab(),
          _AutoScrollTab(),
        ],
      ),
    );
  }
}

class _StateApiTab extends StatefulWidget {
  const _StateApiTab();

  @override
  State<_StateApiTab> createState() => _StateApiTabState();
}

class _StateApiTabState extends State<_StateApiTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;
  bool _autoScroller = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final spec = _apiSpecs[_selected];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Role of State Object'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Owns active drag session, insertion index tracking, and overlay feedback during reorder.'),
                _Bullet('Coordinates with Scrollable and EdgeDraggingAutoScroller for boundary scrolling.'),
                _Bullet('Exposes cancelReorder and startItemDragReorder for imperative interaction control.'),
                _Bullet('Maintains item-state map used by handles and drag listeners in each row.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Method and Property Explorer'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List<Widget>.generate(_apiSpecs.length, (i) {
                    final active = i == _selected;
                    return GestureDetector(
                      onTap: () => setState(() => _selected = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? _apiSpecs[i].color.withValues(alpha: 0.18)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: active ? _apiSpecs[i].color : _panel2,
                          ),
                        ),
                        child: Text(
                          _apiSpecs[i].name,
                          style: TextStyle(
                            color: active ? _apiSpecs[i].color : _txt,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _apiCard(spec),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Drag Session State Machine'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _StepRow(
                  step: '1',
                  title: 'Idle',
                  desc: 'No active drag. Handles/listeners are armed.',
                ),
                _Arrow(),
                _StepRow(
                  step: '2',
                  title: 'startItemDragReorder',
                  desc: 'PointerDownEvent + recognizer create drag session and overlay proxy.',
                ),
                _Arrow(),
                _StepRow(
                  step: '3',
                  title: 'Tracking and insertion updates',
                  desc: 'State computes target index while list can auto-scroll near edges.',
                ),
                _Arrow(),
                _StepRow(
                  step: '4',
                  title: 'Drop or cancelReorder',
                  desc: 'onReorder is fired for drop; cancelReorder aborts and restores visual state.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Configuration Snapshot'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'EdgeDraggingAutoScroller enabled',
                        style: TextStyle(
                          color: _autoScroller ? _ok : _txt,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Switch(
                      value: _autoScroller,
                      activeTrackColor: _ok,
                      onChanged: (v) => setState(() => _autoScroller = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _code(
                  'SliverReorderableList(\n'
                  '  itemBuilder: ...,\n'
                  '  itemCount: items.length,\n'
                  '  onReorder: onReorder,\n'
                  '  autoScrollerVelocityScalar: ${_autoScroller ? '12.0 (active)' : '0.0 (disabled)'},\n'
                  ')',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiCard(_ApiSpec spec) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: spec.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: spec.color.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            spec.signature,
            style: TextStyle(
              color: spec.color,
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(spec.description, style: const TextStyle(color: _txt, fontSize: 11)),
          const SizedBox(height: 8),
          ...spec.notes.map(
            (n) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: spec.color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(n, style: const TextStyle(color: _txt, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DragLabTab extends StatefulWidget {
  const _DragLabTab();

  @override
  State<_DragLabTab> createState() => _DragLabTabState();
}

class _DragLabTabState extends State<_DragLabTab>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<SliverReorderableListState> _listKey =
      GlobalKey<SliverReorderableListState>();
  final List<_DragItem> _items = List<_DragItem>.generate(
    16,
    (i) => _DragItem(
      id: i + 1,
      title: 'Task ${i + 1}',
      color: _palette[i % _palette.length],
      note: 'Row ${i + 1} can be dragged.',
    ),
  );
  final List<String> _events = <String>[];
  bool _delayedHandle = false;
  bool _showHandles = true;
  bool _cancelRequested = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _toolbar(),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: _panelBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _pill('items: ${_items.length}', _a),
                            const SizedBox(width: 8),
                            _pill(
                              _delayedHandle
                                  ? 'DelayedDragStartListener'
                                  : 'DragStartListener',
                              _info,
                            ),
                            const SizedBox(width: 8),
                            _pill(_showHandles ? 'handles visible' : 'handles hidden', _warn),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Drag rows to reorder. You can switch between immediate and delayed drag listeners and cancel an active reorder session from state.',
                          style: TextStyle(color: _txt, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverReorderableList(
                key: _listKey,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final tile = _dragTile(item, index);
                  if (!_showHandles) {
                    return tile;
                  }
                  if (_delayedHandle) {
                    return ReorderableDelayedDragStartListener(
                      key: ValueKey<int>(item.id),
                      index: index,
                      child: tile,
                    );
                  }
                  return ReorderableDragStartListener(
                    key: ValueKey<int>(item.id),
                    index: index,
                    child: tile,
                  );
                },
                onReorderStart: (index) {
                  _push('onReorderStart(index: $index)');
                  setState(() => _cancelRequested = false);
                },
                onReorderEnd: (index) {
                  _push('onReorderEnd(index: $index)');
                },
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final moved = _items.removeAt(oldIndex);
                    _items.insert(newIndex, moved);
                  });
                  _push('onReorder(old: $oldIndex -> new: $newIndex, id: ${_items[newIndex].id})');
                },
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: _eventLog(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _panel,
        border: Border(bottom: BorderSide(color: _panel2)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _action('Toggle delayed start', _info, () {
            setState(() => _delayedHandle = !_delayedHandle);
            _push('drag listener mode: ${_delayedHandle ? 'delayed' : 'immediate'}');
          }),
          _action('Toggle handles', _warn, () {
            setState(() => _showHandles = !_showHandles);
            _push('handle visibility: $_showHandles');
          }),
          _action('Cancel reorder', _err, () {
            _listKey.currentState?.cancelReorder();
            setState(() => _cancelRequested = true);
            _push('cancelReorder() invoked');
          }),
          _action('Reverse top 5', _a, () {
            if (_items.length < 5) {
              return;
            }
            setState(() {
              final top = _items.sublist(0, 5).reversed.toList();
              _items.setAll(0, top);
            });
            _push('external reorder simulation: top 5 reversed');
          }),
          _action('Clear log', _err, () {
            setState(_events.clear);
          }),
        ],
      ),
    );
  }

  Widget _dragTile(_DragItem item, int index) {
    return Container(
      key: ValueKey<int>(item.id),
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: item.color.withValues(alpha: 0.8)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 14,
          backgroundColor: item.color.withValues(alpha: 0.25),
          foregroundColor: item.color,
          child: Text('${item.id}', style: const TextStyle(fontSize: 10)),
        ),
        title: Text(item.title,
            style: TextStyle(color: item.color, fontWeight: FontWeight.w700)),
        subtitle: Text(
          '${item.note} • index $index',
          style: const TextStyle(color: _txt, fontSize: 10),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_cancelRequested)
              const Icon(Icons.cancel, color: _err, size: 16)
            else
              const Icon(Icons.drag_handle, color: _txt, size: 16),
            const SizedBox(width: 6),
            Text(
              _delayedHandle ? 'hold' : 'drag',
              style: const TextStyle(color: _txt, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventLog() {
    return _panelBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Drag Event Timeline',
            style: TextStyle(color: _a, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _panel2),
            ),
            child: _events.isEmpty
                ? const Center(
                    child: Text('No drag events yet.', style: TextStyle(color: _txt, fontSize: 11)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: _panel,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _events[index],
                          style: const TextStyle(color: _a, fontSize: 10, fontFamily: 'monospace'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _push(String text) {
    final t = TimeOfDay.now().format(context);
    setState(() {
      _events.insert(0, '$t | $text');
      if (_events.length > 28) {
        _events.removeLast();
      }
    });
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Text(text,
          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}

class _AutoScrollTab extends StatefulWidget {
  const _AutoScrollTab();

  @override
  State<_AutoScrollTab> createState() => _AutoScrollTabState();
}

class _AutoScrollTabState extends State<_AutoScrollTab>
    with AutomaticKeepAliveClientMixin {
  double _velocityScalar = 10;
  double _edgeBand = 56;
  bool _dragNearTop = false;
  bool _dragNearBottom = false;
  final List<String> _simLog = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final topVelocity = _dragNearTop ? -_velocityScalar * 1.6 : 0.0;
    final bottomVelocity = _dragNearBottom ? _velocityScalar * 1.6 : 0.0;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('EdgeDraggingAutoScroller Model'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SliverReorderableListState wires EdgeDraggingAutoScroller to Scrollable.of(context). This helper computes velocity when drag proxy enters an edge band.',
                  style: TextStyle(color: _txt, fontSize: 11),
                ),
                const SizedBox(height: 10),
                _label('autoScrollerVelocityScalar: ${_velocityScalar.toStringAsFixed(1)}'),
                Slider(
                  value: _velocityScalar,
                  min: 0,
                  max: 30,
                  divisions: 30,
                  activeColor: _a,
                  onChanged: (v) => setState(() => _velocityScalar = v),
                ),
                _label('edge trigger band (px): ${_edgeBand.toStringAsFixed(0)}'),
                Slider(
                  value: _edgeBand,
                  min: 16,
                  max: 120,
                  divisions: 26,
                  activeColor: _a,
                  onChanged: (v) => setState(() => _edgeBand = v),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _toggleCard(
                        title: 'Drag near top edge',
                        value: _dragNearTop,
                        color: _info,
                        onChanged: (v) => setState(() => _dragNearTop = v),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _toggleCard(
                        title: 'Drag near bottom edge',
                        value: _dragNearBottom,
                        color: _warn,
                        onChanged: (v) => setState(() => _dragNearBottom = v),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Computed Auto-Scroll Velocity'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _metric('top velocity', topVelocity.toStringAsFixed(2), topVelocity == 0 ? _txt : _info),
                const SizedBox(height: 6),
                _metric('bottom velocity', bottomVelocity.toStringAsFixed(2),
                    bottomVelocity == 0 ? _txt : _warn),
                const SizedBox(height: 6),
                _metric(
                  'net velocity',
                  (topVelocity + bottomVelocity).toStringAsFixed(2),
                  (topVelocity + bottomVelocity) == 0 ? _txt : _ok,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _action('Simulate tick', _ok, () {
                      _pushSim(
                        'tick -> top=${topVelocity.toStringAsFixed(2)}, bottom=${bottomVelocity.toStringAsFixed(2)}, net=${(topVelocity + bottomVelocity).toStringAsFixed(2)}',
                      );
                    }),
                    _action('Stop edge drag', _err, () {
                      setState(() {
                        _dragNearTop = false;
                        _dragNearBottom = false;
                      });
                      _pushSim('auto scroller stop');
                    }),
                    _action('Clear log', _err, () {
                      setState(_simLog.clear);
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('didChangeDependencies and didUpdateWidget Effects'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _StepRow(
                  step: 'A',
                  title: 'didChangeDependencies',
                  desc: 'Obtains Scrollable.of(context) and rebuilds auto scroller when scrollable changes.',
                ),
                _Arrow(),
                _StepRow(
                  step: 'B',
                  title: 'didUpdateWidget',
                  desc: 'When velocity scalar changes, old scroller stops and a new one is configured.',
                ),
                _Arrow(),
                _StepRow(
                  step: 'C',
                  title: 'cancelReorder safety',
                  desc: 'When item count changes during drag, active reorder is canceled to prevent invalid state.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Simulation Timeline'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: _simLog.isEmpty
                  ? const Center(
                      child: Text('No simulation events yet.', style: TextStyle(color: _txt, fontSize: 11)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _simLog.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _panel,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _simLog[index],
                            style: const TextStyle(color: _a, fontSize: 10, fontFamily: 'monospace'),
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

  Widget _metric(String label, String value, Color color) {
    return Row(
      children: [
        SizedBox(width: 140, child: Text(label, style: const TextStyle(color: _txt, fontSize: 11))),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _toggleCard({
    required String title,
    required bool value,
    required Color color,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
          Switch(value: value, activeTrackColor: color, onChanged: onChanged),
        ],
      ),
    );
  }

  void _pushSim(String text) {
    final t = TimeOfDay.now().format(context);
    setState(() {
      _simLog.insert(0, '$t | $text');
      if (_simLog.length > 28) {
        _simLog.removeLast();
      }
    });
  }
}

class _ApiSpec {
  const _ApiSpec({
    required this.name,
    required this.signature,
    required this.description,
    required this.notes,
    required this.color,
  });

  final String name;
  final String signature;
  final String description;
  final List<String> notes;
  final Color color;
}

class _DragItem {
  const _DragItem({
    required this.id,
    required this.title,
    required this.color,
    required this.note,
  });

  final int id;
  final String title;
  final Color color;
  final String note;
}

const List<_ApiSpec> _apiSpecs = [
  _ApiSpec(
    name: 'startItemDragReorder',
    signature: 'startItemDragReorder({required int index, required PointerDownEvent event, required MultiDragGestureRecognizer recognizer})',
    description: 'Starts drag from state layer using pointer event and recognizer plumbing.',
    notes: [
      'Used by drag start listeners and handles.',
      'Creates drag proxy and tracks insertion index updates.',
    ],
    color: _info,
  ),
  _ApiSpec(
    name: 'cancelReorder',
    signature: 'void cancelReorder()',
    description: 'Aborts active drag and restores pre-drag list state visuals.',
    notes: [
      'Safe to call when no drag is active.',
      'Recommended before major external list mutations.',
    ],
    color: _err,
  ),
  _ApiSpec(
    name: '_items map',
    signature: 'Map<int, _ReorderableItemState> _items',
    description: 'Tracks child item states keyed by current index for drag orchestration.',
    notes: [
      'Supports insertion indicator computations.',
      'Updated as layout shifts during drag.',
    ],
    color: _warn,
  ),
  _ApiSpec(
    name: '_autoScroller',
    signature: 'EdgeDraggingAutoScroller _autoScroller',
    description: 'Scroll helper that drives viewport while dragging near edges.',
    notes: [
      'Configured with autoScrollerVelocityScalar.',
      'Lifecycle tied to Scrollable from dependencies.',
    ],
    color: _ok,
  ),
];

const List<Color> _palette = [
  Color(0xFF26A69A),
  Color(0xFF42A5F5),
  Color(0xFFFFA726),
  Color(0xFFAB47BC),
  Color(0xFF66BB6A),
  Color(0xFFEF5350),
];

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.title, required this.desc});

  final String step;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.withValues(alpha: 0.75)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _a.withValues(alpha: 0.2),
              border: Border.all(color: _a),
              shape: BoxShape.circle,
            ),
            child: Text(step,
                style: const TextStyle(color: _a, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: _a, fontSize: 11, fontWeight: FontWeight.w700)),
                Text(desc, style: const TextStyle(color: _txt, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward_rounded, size: 14, color: _txt),
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
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(color: _a, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _txt, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _a, fontSize: 14, fontWeight: FontWeight.w700),
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

Widget _code(String value) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      value,
      style: const TextStyle(color: _a, fontFamily: 'monospace', fontSize: 10),
    ),
  );
}

Widget _action(String label, Color color, VoidCallback onTap) {
  return FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: color.withValues(alpha: 0.18),
      foregroundColor: color,
      side: BorderSide(color: color.withValues(alpha: 0.8)),
    ),
    onPressed: onTap,
    child: Text(label, style: const TextStyle(fontSize: 11)),
  );
}

Widget _label(String text) {
  return Text(text, style: const TextStyle(color: _txt, fontSize: 11));
}
