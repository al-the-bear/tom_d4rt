import 'package:flutter/material.dart';

const Color _bg = Color(0xFF0D1220);
const Color _panel = Color(0xFF18243A);
const Color _panel2 = Color(0xFF243552);
const Color _text = Color(0xFFD5E4FF);
const Color _aqua = Color(0xFF77E6D4);
const Color _indigo = Color(0xFF8FA7FF);
const Color _sun = Color(0xFFFFD27A);
const Color _rose = Color(0xFFFF9AB0);
const Color _lime = Color(0xFFBDEB7D);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _aqua,
        secondary: _sun,
        surface: _panel,
      ),
    ),
    home: const _StaticSelectionContainerDelegateDemo(),
  );
}

class _StaticSelectionContainerDelegateDemo extends StatefulWidget {
  const _StaticSelectionContainerDelegateDemo();

  @override
  State<_StaticSelectionContainerDelegateDemo> createState() =>
      _StaticSelectionContainerDelegateDemoState();
}

class _StaticSelectionContainerDelegateDemoState
    extends State<_StaticSelectionContainerDelegateDemo>
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
          'StaticSelectionContainerDelegate Deep Demo',
          style: TextStyle(color: _sun, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _sun,
          labelColor: _sun,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Contract'),
            Tab(text: 'Selection Lab'),
            Tab(text: 'Event Routing'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ContractTab(),
          _SelectionLabTab(),
          _EventRoutingTab(),
        ],
      ),
    );
  }
}

class _ContractTab extends StatefulWidget {
  const _ContractTab();

  @override
  State<_ContractTab> createState() => _ContractTabState();
}

class _ContractTabState extends State<_ContractTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _ContractTopic topic = _topics[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Delegate Intent'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('StaticSelectionContainerDelegate models selection behavior for static/non-editable content containers.'),
                _Bullet('It centralizes how child selectable regions are interpreted for highlight and handle placement.'),
                _Bullet('Useful when content selection should be consistent across a composite read-only layout.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Contract Topics'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_topics.length, (int index) {
                    final bool active = index == _selected;
                    final _ContractTopic item = _topics[index];
                    return GestureDetector(
                      onTap: () => setState(() => _selected = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? item.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: active ? item.color : _panel2),
                        ),
                        child: Text(
                          item.label,
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
                const SizedBox(height: 10),
                _topicCard(topic),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Delegate Responsibilities Map'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: const [
                _MapRow('Selection Geometry', 'Resolve selected range bounds across static child regions.', _aqua),
                _MapRow('Highlight Policy', 'Apply consistent visual selection treatment.', _indigo),
                _MapRow('Handle Strategy', 'Choose anchor points and orientation in fixed layouts.', _sun),
                _MapRow('Event Arbitration', 'Interpret drag/tap and dispatch selection updates.', _rose),
                _MapRow('Cross-Region Merge', 'Combine contiguous ranges from sibling regions.', _lime),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Pseudo API Sketch'),
          const SizedBox(height: 8),
          _box(
            child: _code(
              'class StaticSelectionContainerDelegate {\n'
              '  SelectionGeometry getSelectionGeometry();\n'
              '  SelectionResult handleSelectWord(Offset globalPosition);\n'
              '  SelectionResult handleSelectAll();\n'
              '  SelectionResult handleDragSelection(Offset start, Offset current);\n'
              '  void paintHighlight(Canvas canvas, SelectionRange range);\n'
              '}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _topicCard(_ContractTopic topic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: topic.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: topic.color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(topic.summary, style: const TextStyle(color: _text, fontSize: 11)),
          const SizedBox(height: 8),
          ...topic.points.map(
            (String p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chevron_right_rounded, color: topic.color, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(p, style: const TextStyle(color: _text, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionLabTab extends StatefulWidget {
  const _SelectionLabTab();

  @override
  State<_SelectionLabTab> createState() => _SelectionLabTabState();
}

class _SelectionLabTabState extends State<_SelectionLabTab>
    with AutomaticKeepAliveClientMixin {
  int _start = 4;
  int _end = 16;
  bool _showHandles = true;
  bool _mergeAcrossBlocks = true;
  bool _denseMode = false;

  static const String _content =
      'Static selection delegates are useful for rich read-only surfaces where selection still matters for copy, inspect, and assistive workflows.';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int s = _start < _end ? _start : _end;
    final int e = _start < _end ? _end : _start;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Selection Geometry Lab'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selection start index', style: TextStyle(color: _text, fontSize: 11)),
                Slider(
                  min: 0,
                  max: (_content.length - 1).toDouble(),
                  value: _start.toDouble(),
                  activeColor: _aqua,
                  onChanged: (double v) => setState(() => _start = v.round()),
                ),
                const Text('Selection end index', style: TextStyle(color: _text, fontSize: 11)),
                Slider(
                  min: 0,
                  max: (_content.length - 1).toDouble(),
                  value: _end.toDouble(),
                  activeColor: _sun,
                  onChanged: (double v) => setState(() => _end = v.round()),
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _showHandles,
                  activeThumbColor: _indigo,
                  title: const Text('Show selection handles', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool v) => setState(() => _showHandles = v),
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _mergeAcrossBlocks,
                  activeThumbColor: _rose,
                  title: const Text('Merge across static blocks', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool v) => setState(() => _mergeAcrossBlocks = v),
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _denseMode,
                  activeThumbColor: _lime,
                  title: const Text('Dense layout mode', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool v) => setState(() => _denseMode = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Static Text Selection Preview'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(_denseMode ? 8 : 12),
              decoration: BoxDecoration(
                color: _panel2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _aqua.withValues(alpha: 0.85)),
              ),
              child: _highlightedText(_content, s, e),
            ),
          ),
          const SizedBox(height: 14),
          _title('Selection Geometry Snapshot'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                _metric('start', s.toString(), _aqua),
                _metric('end', e.toString(), _sun),
                _metric('length', (e - s).toString(), _indigo),
                _metric('handles', _showHandles ? 'visible' : 'hidden', _rose),
                _metric('cross-block merge', _mergeAcrossBlocks ? 'enabled' : 'disabled', _lime),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (_showHandles) ...[
            _title('Handle Anchors'),
            const SizedBox(height: 8),
            _box(
              child: Row(
                children: [
                  Expanded(child: _anchorBox('Start Handle', _aqua, s)),
                  const SizedBox(width: 8),
                  Expanded(child: _anchorBox('End Handle', _sun, e)),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],
          _title('Lab Notes'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Static delegates often optimize for deterministic geometry in non-editable surfaces.'),
                _Bullet('Cross-block merge behavior is essential when users drag across multiple logical chunks.'),
                _Bullet('Selection handles may be hidden for passive selection contexts (copy-only actions).'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightedText(String text, int start, int end) {
    final String left = text.substring(0, start);
    final String mid = text.substring(start, end);
    final String right = text.substring(end);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: left, style: const TextStyle(color: _text, fontSize: 12)),
          TextSpan(
            text: mid,
            style: TextStyle(
              color: _bg,
              backgroundColor: _mergeAcrossBlocks ? _aqua : _indigo,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: right, style: const TextStyle(color: _text, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _metric(String name, String value, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(name, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700))),
          Text(value, style: TextStyle(color: color, fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget _anchorBox(String label, Color color, int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          const SizedBox(height: 4),
          Text('char index: $index', style: const TextStyle(color: _text, fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class _EventRoutingTab extends StatefulWidget {
  const _EventRoutingTab();

  @override
  State<_EventRoutingTab> createState() => _EventRoutingTabState();
}

class _EventRoutingTabState extends State<_EventRoutingTab>
    with AutomaticKeepAliveClientMixin {
  int _phase = 0;
  bool _gestureInput = true;
  bool _keyboardInput = true;
  bool _semanticInput = true;
  final List<String> _timeline = <String>['Routing simulator initialized.'];

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
          _title('Selection Event Routing'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _phase = (_phase + 1) % 5);
                          _push('advance phase -> $_phase');
                        },
                        icon: const Icon(Icons.skip_next_rounded, size: 16),
                        label: const Text('Advance Phase'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _phase = 0;
                            _timeline.clear();
                            _timeline.add('Routing simulator reset.');
                          });
                        },
                        icon: const Icon(Icons.restart_alt_rounded, size: 16),
                        label: const Text('Reset'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _switch('Gesture routing', _gestureInput, _aqua, (bool v) {
                  setState(() => _gestureInput = v);
                  _push('gesture routing -> $v');
                }),
                _switch('Keyboard routing', _keyboardInput, _indigo, (bool v) {
                  setState(() => _keyboardInput = v);
                  _push('keyboard routing -> $v');
                }),
                _switch('Semantic routing', _semanticInput, _lime, (bool v) {
                  setState(() => _semanticInput = v);
                  _push('semantic routing -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Routing Board'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                _routeNode(0, 'Receive Event', 'Pointer/key/semantic signal arrives at selection container.', _aqua),
                const _Arrow(),
                _routeNode(1, 'Hit Region Resolve', 'Determine target static region and local offset.', _indigo),
                const _Arrow(),
                _routeNode(2, 'Delegate Arbitration', 'Delegate chooses select-word, drag, or extend strategy.', _sun),
                const _Arrow(),
                _routeNode(3, 'Geometry Update', 'Selection geometry/anchors recomputed and merged.', _rose),
                const _Arrow(),
                _routeNode(4, 'Paint + Notify', 'Highlight repainted and listeners notified.', _lime),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Input Channel Status'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                _channel('gesture', _gestureInput, _aqua),
                _channel('keyboard', _keyboardInput, _indigo),
                _channel('semantic', _semanticInput, _lime),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Timeline'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _timeline.length,
                itemBuilder: (BuildContext context, int index) {
                  final String row = _timeline[_timeline.length - 1 - index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: _panel,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(row, style: const TextStyle(color: _sun, fontFamily: 'monospace', fontSize: 10)),
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

  Widget _routeNode(int index, String title, String desc, Color color) {
    final bool active = index <= _phase;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.16) : _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? color.withValues(alpha: 0.85) : _panel2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: active ? color : _text, fontWeight: FontWeight.w700, fontSize: 11)),
          const SizedBox(height: 3),
          Text(desc, style: const TextStyle(color: _text, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _channel(String name, bool enabled, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: enabled ? color.withValues(alpha: 0.14) : _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: enabled ? color.withValues(alpha: 0.85) : _panel2),
      ),
      child: Row(
        children: [
          Expanded(child: Text(name, style: TextStyle(color: enabled ? color : _text, fontSize: 11, fontWeight: FontWeight.w700))),
          Text(enabled ? 'active' : 'disabled', style: TextStyle(color: enabled ? color : _text, fontSize: 10)),
        ],
      ),
    );
  }

  void _push(String msg) {
    final String t = TimeOfDay.now().format(context);
    setState(() {
      _timeline.add('$t | $msg');
      if (_timeline.length > 45) {
        _timeline.removeAt(0);
      }
    });
  }
}

class _ContractTopic {
  const _ContractTopic({
    required this.label,
    required this.summary,
    required this.points,
    required this.color,
  });

  final String label;
  final String summary;
  final List<String> points;
  final Color color;
}

const List<_ContractTopic> _topics = [
  _ContractTopic(
    label: 'geometry',
    summary: 'Resolve and expose current selection geometry in static presentation contexts.',
    points: [
      'Coordinates should remain stable across repaint-only frames.',
      'Handle transforms from local regions to container coordinates.',
    ],
    color: _aqua,
  ),
  _ContractTopic(
    label: 'merge',
    summary: 'Combine selection fragments from multiple child regions when needed.',
    points: [
      'Useful for article-like surfaces with many static text blocks.',
      'Must maintain deterministic range ordering.',
    ],
    color: _indigo,
  ),
  _ContractTopic(
    label: 'handles',
    summary: 'Decide where selection handles should anchor in static content.',
    points: [
      'May clamp to nearest selectable glyph boundary.',
      'Can be disabled for simplified copy-only UX.',
    ],
    color: _sun,
  ),
  _ContractTopic(
    label: 'events',
    summary: 'Interpret gesture, keyboard, and semantic commands into selection updates.',
    points: [
      'Arbitrates between select-word, extend, and clear actions.',
      'Supports accessibility-driven selection requests.',
    ],
    color: _rose,
  ),
  _ContractTopic(
    label: 'paint',
    summary: 'Render visual highlights and trigger updates for observers.',
    points: [
      'Highlight style should match product contrast and accessibility goals.',
      'Selection visuals must remain synchronized with geometry state.',
    ],
    color: _lime,
  ),
];

class _MapRow extends StatelessWidget {
  const _MapRow(this.left, this.right, this.color);

  final String left;
  final String right;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 126,
            child: Text(left, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
          Expanded(child: Text(right, style: const TextStyle(color: _text, fontSize: 10))),
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
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(color: _sun, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
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
      child: Icon(Icons.south_rounded, size: 14, color: _text),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _sun, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _box({required Widget child}) {
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
      style: const TextStyle(color: _aqua, fontSize: 10, fontFamily: 'monospace'),
    ),
  );
}
