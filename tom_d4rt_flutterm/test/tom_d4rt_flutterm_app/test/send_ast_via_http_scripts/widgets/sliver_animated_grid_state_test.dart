import 'package:flutter/material.dart';

const Color _p = Color(0xFF1A237E);
const Color _a = Color(0xFFFFAB40);
const Color _bg = Color(0xFF0A0E18);
const Color _card = Color(0xFF182237);
const Color _card2 = Color(0xFF23314A);
const Color _text = Color(0xFFB5C4DE);
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
        surface: _card,
      ),
    ),
    home: const _SliverAnimatedGridStateDemo(),
  );
}

class _SliverAnimatedGridStateDemo extends StatefulWidget {
  const _SliverAnimatedGridStateDemo();

  @override
  State<_SliverAnimatedGridStateDemo> createState() =>
      _SliverAnimatedGridStateDemoState();
}

class _SliverAnimatedGridStateDemoState extends State<_SliverAnimatedGridStateDemo>
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
          'SliverAnimatedGridState',
          style: TextStyle(color: _a, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _a,
          labelColor: _a,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'State API'),
            Tab(text: 'Animation Lab'),
            Tab(text: 'Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _StateApiTab(),
          _AnimationLabTab(),
          _PatternsTab(),
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final method = _methods[_selected];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('What This State Class Controls'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Backs SliverAnimatedGrid and owns insertion/removal transition bookkeeping.'),
                _Bullet('Provides imperative methods for mutating grid structure with animations.'),
                _Bullet('Usually accessed through GlobalKey<SliverAnimatedGridState> or SliverAnimatedGrid.of(context).'),
                _Bullet('Works inside CustomScrollView as a sliver, unlike AnimatedGrid in box layout.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Method Reference'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List<Widget>.generate(_methods.length, (index) {
                    final selected = index == _selected;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: selected ? _a.withValues(alpha: 0.18) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: selected ? _a : _card2),
                        ),
                        child: Text(
                          _methods[index].name,
                          style: TextStyle(
                            color: selected ? _a : _text,
                            fontSize: 11,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _methodCard(method),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Lifecycle Diagram'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: const [
                _FlowRow(step: '1', title: 'insertItem(index)', desc: 'State marks incoming item and creates forward animation.'),
                _Arrow(),
                _FlowRow(step: '2', title: 'itemBuilder(context, index, animation)', desc: 'Widget gets Animated value from 0→1.'),
                _Arrow(),
                _FlowRow(step: '3', title: 'removeItem(index, builder)', desc: 'State removes entry and runs reverse animation via builder.'),
                _Arrow(),
                _FlowRow(step: '4', title: 'removeAllItems(builder)', desc: 'Repeats removal choreography for every remaining index.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Code Contract'),
          const SizedBox(height: 8),
          _box(
            child: _code(
              'final key = GlobalKey<SliverAnimatedGridState>();\n\n'
              'SliverAnimatedGrid(\n'
              '  key: key,\n'
              '  gridDelegate: ...,\n'
              '  initialItemCount: items.length,\n'
              '  itemBuilder: (context, index, animation) => ...\n'
              ')\n\n'
              'key.currentState?.insertItem(0);\n'
              'key.currentState?.removeItem(index, (context, animation) => ...);',
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimationLabTab extends StatefulWidget {
  const _AnimationLabTab();

  @override
  State<_AnimationLabTab> createState() => _AnimationLabTabState();
}

class _AnimationLabTabState extends State<_AnimationLabTab>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<SliverAnimatedGridState> _gridKey =
      GlobalKey<SliverAnimatedGridState>();
  final List<_GridEntry> _items = <_GridEntry>[];
  final List<String> _events = <String>[];
  int _nextId = 1;
  int _colorCursor = 0;
  bool _twoCols = true;

  final List<Color> _palette = const [
    Color(0xFF26C6DA),
    Color(0xFFFF7043),
    Color(0xFF9CCC65),
    Color(0xFFFFCA28),
    Color(0xFFAB47BC),
    Color(0xFF42A5F5),
    Color(0xFFFF8A65),
    Color(0xFF7E57C2),
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 8; i++) {
      _items.add(_makeEntry());
    }
  }

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
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverAnimatedGrid(
                  key: _gridKey,
                  initialItemCount: _items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _twoCols ? 2 : 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: _twoCols ? 1.2 : 1,
                  ),
                  itemBuilder: (context, index, animation) {
                    final item = _items[index];
                    return _animatedTile(item, animation);
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: _eventPanel(),
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
        color: _card,
        border: Border(bottom: BorderSide(color: _card2.withValues(alpha: 0.8))),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _action('Insert start', _ok, _insertAtStart),
          _action('Insert middle', _info, _insertAtMiddle),
          _action('Insert end', _a, _insertAtEnd),
          _action('Remove first', _warn, _removeFirst),
          _action('Remove last', _err, _removeLast),
          _action('Remove middle', _warn, _removeMiddle),
          _action('Bulk +3', _ok, _insertThreeAtTop),
          _action('Clear all', _err, _clearAll),
          _action(_twoCols ? 'Switch 3 columns' : 'Switch 2 columns', _info, () {
            setState(() {
              _twoCols = !_twoCols;
            });
            _log('gridDelegate → ${_twoCols ? 2 : 3} columns');
          }),
        ],
      ),
    );
  }

  Widget _eventPanel() {
    return _box(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _pill('Items: ${_items.length}', _a),
              const SizedBox(width: 8),
              _pill('Next id: $_nextId', _info),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _events.clear();
                  });
                },
                child: const Text('Clear log'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _card2),
            ),
            child: _events.isEmpty
                ? const Center(
                    child: Text(
                      'No events yet. Use controls above to mutate the grid.',
                      style: TextStyle(color: _text, fontSize: 11),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _events[index],
                          style: const TextStyle(
                            color: _a,
                            fontFamily: 'monospace',
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _animatedTile(_GridEntry item, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeInCubic,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [item.color.withValues(alpha: 0.85), item.color.withValues(alpha: 0.45)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: item.color),
            boxShadow: [
              BoxShadow(
                color: item.color.withValues(alpha: 0.22),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              final index = _items.indexWhere((entry) => entry.id == item.id);
              if (index >= 0) {
                _removeAt(index, reason: 'tap-remove');
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _chip('#${item.id}', Colors.white),
                      const Spacer(),
                      Icon(Icons.grid_view_rounded, size: 14, color: Colors.white.withValues(alpha: 0.8)),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap tile to remove with reverse animation',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.82), fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _removedTile(_GridEntry item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: FadeTransition(
        opacity: animation,
        child: Container(
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: item.color.withValues(alpha: 0.7)),
          ),
          child: Center(
            child: Text(
              'Removing #${item.id}',
              style: TextStyle(
                color: item.color,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _action(String label, Color color, VoidCallback onPressed) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.2),
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: 0.8)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  _GridEntry _makeEntry() {
    final id = _nextId;
    _nextId += 1;
    final color = _palette[_colorCursor % _palette.length];
    _colorCursor += 1;
    return _GridEntry(id: id, title: 'Card $id', color: color);
  }

  void _log(String message) {
    final time = TimeOfDay.now().format(context);
    setState(() {
      _events.insert(0, '$time | $message');
      if (_events.length > 30) {
        _events.removeLast();
      }
    });
  }

  void _insertAtStart() {
    final item = _makeEntry();
    setState(() {
      _items.insert(0, item);
    });
    _gridKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 320));
    _log('insertItem(0) -> #${item.id}');
  }

  void _insertAtMiddle() {
    final item = _makeEntry();
    final index = (_items.length / 2).floor();
    setState(() {
      _items.insert(index, item);
    });
    _gridKey.currentState?.insertItem(index, duration: const Duration(milliseconds: 320));
    _log('insertItem($index) -> #${item.id}');
  }

  void _insertAtEnd() {
    final item = _makeEntry();
    final index = _items.length;
    setState(() {
      _items.add(item);
    });
    _gridKey.currentState?.insertItem(index, duration: const Duration(milliseconds: 320));
    _log('insertItem($index) -> #${item.id}');
  }

  void _insertThreeAtTop() {
    for (var i = 0; i < 3; i++) {
      final item = _makeEntry();
      setState(() {
        _items.insert(i, item);
      });
      _gridKey.currentState?.insertItem(i, duration: const Duration(milliseconds: 260));
    }
    _log('bulk insert 3 items at top (0..2)');
  }

  void _removeFirst() {
    if (_items.isEmpty) {
      _log('remove first skipped (empty)');
      return;
    }
    _removeAt(0, reason: 'remove first');
  }

  void _removeLast() {
    if (_items.isEmpty) {
      _log('remove last skipped (empty)');
      return;
    }
    _removeAt(_items.length - 1, reason: 'remove last');
  }

  void _removeMiddle() {
    if (_items.isEmpty) {
      _log('remove middle skipped (empty)');
      return;
    }
    final index = (_items.length / 2).floor();
    _removeAt(index, reason: 'remove middle');
  }

  void _removeAt(int index, {required String reason}) {
    final removed = _items.removeAt(index);
    _gridKey.currentState?.removeItem(
      index,
      (context, animation) => _removedTile(removed, animation),
      duration: const Duration(milliseconds: 320),
    );
    setState(() {});
    _log('$reason -> removeItem($index) #${removed.id}');
  }

  void _clearAll() {
    if (_items.isEmpty) {
      _log('removeAllItems skipped (already empty)');
      return;
    }
    final removed = List<_GridEntry>.from(_items);
    _items.clear();
    _gridKey.currentState?.removeAllItems(
      (context, animation) {
        final item = removed.isEmpty ? _GridEntry(id: 0, title: 'Removed', color: _err) : removed.removeLast();
        return _removedTile(item, animation);
      },
      duration: const Duration(milliseconds: 280),
    );
    setState(() {});
    _log('removeAllItems(builder)');
  }
}

class _PatternsTab extends StatefulWidget {
  const _PatternsTab();

  @override
  State<_PatternsTab> createState() => _PatternsTabState();
}

class _PatternsTabState extends State<_PatternsTab>
    with AutomaticKeepAliveClientMixin {
  bool _showOfPattern = true;
  bool _useGlobalKey = true;

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
          _title('Access Patterns'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _switchCard(
                        title: 'GlobalKey Access',
                        subtitle: 'Direct state handle from parent owner.',
                        value: _useGlobalKey,
                        onChanged: (v) {
                          setState(() {
                            _useGlobalKey = v;
                          });
                        },
                        color: _a,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _switchCard(
                        title: 'of(context) Access',
                        subtitle: 'Resolve nearest ancestor state from subtree.',
                        value: _showOfPattern,
                        onChanged: (v) {
                          setState(() {
                            _showOfPattern = v;
                          });
                        },
                        color: _info,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _code(_useGlobalKey ? _globalKeyCode : _ofCode),
                if (_showOfPattern) ...[
                  const SizedBox(height: 8),
                  _code(_maybeOfCode),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Method Selection Guide'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _DecisionRow(
                  question: 'Need to add one tile at a specific index?',
                  answer: 'Use insertItem(index).',
                  color: _ok,
                ),
                _DecisionRow(
                  question: 'Need to remove one item with custom outgoing UI?',
                  answer: 'Use removeItem(index, builder).',
                  color: _warn,
                ),
                _DecisionRow(
                  question: 'Need to reset whole grid with animation?',
                  answer: 'Use removeAllItems(builder).',
                  color: _err,
                ),
                _DecisionRow(
                  question: 'Need to discover state from deep child context?',
                  answer: 'Use SliverAnimatedGrid.maybeOf(context) for safe lookup.',
                  color: _info,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Interpreter-Focused Notes'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('This demo validates runtime interaction of sliver state mutations under interpreter execution.'),
                _Bullet('Visual confirmation is emphasized: each state call produces observable animated transitions.'),
                _Bullet('No heavy assertions are required because underlying Flutter behavior is trusted; integration behavior is what we verify.'),
                _Bullet('GlobalKey and context lookup patterns are both shown so script authors can choose stable access strategies.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _card2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
              Switch(
                value: value,
                activeTrackColor: color,
                onChanged: onChanged,
              ),
            ],
          ),
          Text(
            subtitle,
            style: const TextStyle(color: _text, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  const _DecisionRow({
    required this.question,
    required this.answer,
    required this.color,
  });

  final String question;
  final String answer;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.rule, size: 14, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  answer,
                  style: const TextStyle(color: _text, fontSize: 10),
                ),
              ],
            ),
          ),
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
            decoration: const BoxDecoration(color: _a, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _text, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowRow extends StatelessWidget {
  const _FlowRow({required this.step, required this.title, required this.desc});

  final String step;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _card2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _a.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: _a),
            ),
            alignment: Alignment.center,
            child: Text(step, style: const TextStyle(color: _a, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: _a, fontSize: 11, fontWeight: FontWeight.w700)),
                Text(desc, style: const TextStyle(color: _text, fontSize: 10)),
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
      child: Icon(Icons.arrow_downward_rounded, size: 14, color: _text),
    );
  }
}

class _MethodSpec {
  const _MethodSpec(this.name, this.signature, this.desc, this.color, this.notes);

  final String name;
  final String signature;
  final String desc;
  final Color color;
  final List<String> notes;
}

class _GridEntry {
  const _GridEntry({required this.id, required this.title, required this.color});

  final int id;
  final String title;
  final Color color;
}

const List<_MethodSpec> _methods = [
  _MethodSpec(
    'insertItem',
    'insertItem(int index, {Duration duration = const Duration(milliseconds: 300)})',
    'Animate one new tile into the sliver grid at the requested index.',
    _ok,
    [
      'Shifted indices update automatically for following items.',
      'itemBuilder receives forward animation for the inserted index.',
    ],
  ),
  _MethodSpec(
    'removeItem',
    'removeItem(int index, AnimatedRemovedItemBuilder builder, {Duration duration = ...})',
    'Remove one tile and let builder produce outgoing transition UI.',
    _warn,
    [
      'You must keep removed model data to paint outgoing widget.',
      'Builder runs while animation reverses from 1 to 0.',
    ],
  ),
  _MethodSpec(
    'removeAllItems',
    'removeAllItems(AnimatedRemovedItemBuilder builder, {Duration duration = ...})',
    'Clear entire grid with batched outgoing animations.',
    _err,
    [
      'Useful when reloading from scratch.',
      'Keep a copy of old list when drawing removed tiles.',
    ],
  ),
  _MethodSpec(
    'of / maybeOf',
    'SliverAnimatedGrid.of(context) / maybeOf(context)',
    'Resolve nearest SliverAnimatedGridState from a build context.',
    _info,
    [
      'Use maybeOf for nullable lookup in optional subtrees.',
      'Use GlobalKey when state ownership belongs to parent coordinator.',
    ],
  ),
];

Widget _methodCard(_MethodSpec method) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: method.color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: method.color.withValues(alpha: 0.65)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          method.name,
          style: TextStyle(color: method.color, fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(method.desc, style: const TextStyle(color: _text, fontSize: 11)),
        const SizedBox(height: 8),
        _code(method.signature),
        const SizedBox(height: 8),
        ...method.notes.map(
          (note) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.fiber_manual_record, size: 8, color: method.color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(note, style: const TextStyle(color: _text, fontSize: 10)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _a, fontWeight: FontWeight.w700, fontSize: 14),
  );
}

Widget _box({required Widget child}) {
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
      style: const TextStyle(
        color: _a,
        fontFamily: 'monospace',
        fontSize: 10,
      ),
    ),
  );
}

const String _globalKeyCode =
    'final gridKey = GlobalKey<SliverAnimatedGridState>();\n'
    '...\n'
    'gridKey.currentState?.insertItem(0);\n'
    'gridKey.currentState?.removeItem(index, builder);';

const String _ofCode =
    'void addFromChild(BuildContext context) {\n'
    '  final state = SliverAnimatedGrid.of(context);\n'
    '  state.insertItem(0);\n'
    '}';

const String _maybeOfCode =
    'void tryRemove(BuildContext context) {\n'
    '  final state = SliverAnimatedGrid.maybeOf(context);\n'
    '  state?.removeItem(index, builder);\n'
    '}';
