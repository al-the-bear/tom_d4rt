import 'package:flutter/material.dart';

const Color _primary = Color(0xFF004D40);
const Color _accent = Color(0xFFFF8A80);
const Color _bg = Color(0xFF0B1317);
const Color _panel = Color(0xFF13232B);
const Color _panel2 = Color(0xFF1E323D);
const Color _txt = Color(0xFFB6CCD6);
const Color _ok = Color(0xFF66BB6A);
const Color _warn = Color(0xFFFFB74D);
const Color _err = Color(0xFFEF5350);
const Color _info = Color(0xFF4FC3F7);

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
    home: const _SliverChildDelegateDemo(),
  );
}

class _SliverChildDelegateDemo extends StatefulWidget {
  const _SliverChildDelegateDemo();

  @override
  State<_SliverChildDelegateDemo> createState() => _SliverChildDelegateDemoState();
}

class _SliverChildDelegateDemoState extends State<_SliverChildDelegateDemo>
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
          'SliverChildDelegate',
          style: TextStyle(color: _accent, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _accent,
          labelColor: _accent,
          unselectedLabelColor: _txt,
          tabs: const [
            Tab(text: 'Concept'),
            Tab(text: 'Delegate Lab'),
            Tab(text: 'Advanced API'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptTab(),
          _DelegateLabTab(),
          _AdvancedApiTab(),
        ],
      ),
    );
  }
}

class _ConceptTab extends StatefulWidget {
  const _ConceptTab();

  @override
  State<_ConceptTab> createState() => _ConceptTabState();
}

class _ConceptTabState extends State<_ConceptTab>
    with AutomaticKeepAliveClientMixin {
  int _index = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final selected = _concepts[_index];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Role In Sliver Rendering'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('SliverChildDelegate is the strategy object that tells sliver lists/grids what children exist.'),
                _Bullet('SliverList and SliverGrid ask the delegate for widgets by index as scrolling exposes new ranges.'),
                _Bullet('Delegate behavior directly influences caching, semantics, repaint boundaries, and rebuild cost.'),
                _Bullet('Two common concrete delegates are SliverChildBuilderDelegate and SliverChildListDelegate.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Delegate Comparison'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List<Widget>.generate(_concepts.length, (i) {
                    final active = i == _index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = i;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? _accent.withValues(alpha: 0.18) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: active ? _accent : _panel2),
                        ),
                        child: Text(
                          _concepts[i].title,
                          style: TextStyle(
                            color: active ? _accent : _txt,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _conceptCard(selected),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Where It Appears'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _MapRow(left: 'SliverList', right: 'delegate: SliverChildDelegate'),
                _MapRow(left: 'SliverGrid', right: 'delegate: SliverChildDelegate'),
                _MapRow(left: 'ListView.custom', right: 'childrenDelegate: SliverChildDelegate'),
                _MapRow(left: 'GridView.custom', right: 'childrenDelegate: SliverChildDelegate'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Visual Lifecycle'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _StepRow(step: '1', title: 'Viewport asks for index range', desc: 'RenderSliver requests widgets near visible scroll window.'),
                _Arrow(),
                _StepRow(step: '2', title: 'Delegate build(index)', desc: 'Builder/list delegate provides child widget for each required index.'),
                _Arrow(),
                _StepRow(step: '3', title: 'Layout completed', desc: 'didFinishLayout can observe first/last visible index.'),
                _Arrow(),
                _StepRow(step: '4', title: 'Rebuild decision', desc: 'shouldRebuild controls whether previous delegate output can be reused.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Minimal Usage Snippet'),
          const SizedBox(height: 8),
          _panelBox(
            child: _code(
              'CustomScrollView(\n'
              '  slivers: [\n'
              '    SliverList(\n'
              '      delegate: SliverChildBuilderDelegate(\n'
              '        (context, index) => ItemTile(index: index),\n'
              '        childCount: items.length,\n'
              '      ),\n'
              '    ),\n'
              '  ],\n'
              ')',
            ),
          ),
        ],
      ),
    );
  }
}

class _DelegateLabTab extends StatefulWidget {
  const _DelegateLabTab();

  @override
  State<_DelegateLabTab> createState() => _DelegateLabTabState();
}

class _DelegateLabTabState extends State<_DelegateLabTab>
    with AutomaticKeepAliveClientMixin {
  bool _useBuilder = true;
  bool _addKeepAlive = true;
  bool _addRepaint = true;
  bool _addSemantics = true;
  bool _enableFindIndexCallback = true;
  final ScrollController _scrollController = ScrollController();

  final List<_RowModel> _rows = List<_RowModel>.generate(
    20,
    (i) => _RowModel(
      id: i + 1,
      label: 'Row ${i + 1}',
      color: _seedColors[i % _seedColors.length],
      subtitle: 'Delegate sample item ${i + 1}',
    ),
  );

  final List<String> _events = <String>[];
  int _nextId = 21;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _controlBar(),
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: _statsPanel(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverList(delegate: _buildDelegate()),
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

  SliverChildDelegate _buildDelegate() {
    if (_useBuilder) {
      return SliverChildBuilderDelegate(
        (context, index) {
          if (index >= _rows.length) {
            return null;
          }
          final row = _rows[index];
          return _rowTile(row, index, mode: 'builder');
        },
        childCount: _rows.length,
        addAutomaticKeepAlives: _addKeepAlive,
        addRepaintBoundaries: _addRepaint,
        addSemanticIndexes: _addSemantics,
        findChildIndexCallback: _enableFindIndexCallback
            ? (key) {
                if (key is ValueKey<int>) {
                  final rowIndex = _rows.indexWhere((row) => row.id == key.value);
                  return rowIndex >= 0 ? rowIndex : null;
                }
                return null;
              }
            : null,
      );
    }
    final children = _rows
        .asMap()
        .entries
        .map((entry) => _rowTile(entry.value, entry.key, mode: 'list'))
        .toList(growable: false);
    return SliverChildListDelegate(
      children,
      addAutomaticKeepAlives: _addKeepAlive,
      addRepaintBoundaries: _addRepaint,
      addSemanticIndexes: _addSemantics,
    );
  }

  Widget _controlBar() {
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
          _action(
            _useBuilder ? 'Using BuilderDelegate' : 'Using ListDelegate',
            _info,
            () {
              setState(() {
                _useBuilder = !_useBuilder;
              });
              _log(_useBuilder
                  ? 'Switched to SliverChildBuilderDelegate'
                  : 'Switched to SliverChildListDelegate');
            },
          ),
          _action('Add row', _ok, _addRow),
          _action('Remove first', _warn, _removeFirst),
          _action('Shuffle top 5', _accent, _shuffleTopFive),
          _action('Scroll top', _info, _scrollToTop),
          _action('Scroll bottom', _warn, _scrollToBottom),
          _action(
            _addKeepAlive ? 'KeepAlive: ON' : 'KeepAlive: OFF',
            _ok,
            () {
              setState(() {
                _addKeepAlive = !_addKeepAlive;
              });
              _log('addAutomaticKeepAlives = $_addKeepAlive');
            },
          ),
          _action(
            _addRepaint ? 'RepaintBoundary: ON' : 'RepaintBoundary: OFF',
            _info,
            () {
              setState(() {
                _addRepaint = !_addRepaint;
              });
              _log('addRepaintBoundaries = $_addRepaint');
            },
          ),
          _action(
            _addSemantics ? 'SemanticIndexes: ON' : 'SemanticIndexes: OFF',
            _warn,
            () {
              setState(() {
                _addSemantics = !_addSemantics;
              });
              _log('addSemanticIndexes = $_addSemantics');
            },
          ),
          _action(
            _enableFindIndexCallback ? 'findChildIndex: ON' : 'findChildIndex: OFF',
            _accent,
            () {
              setState(() {
                _enableFindIndexCallback = !_enableFindIndexCallback;
              });
              _log('findChildIndexCallback = $_enableFindIndexCallback');
            },
          ),
        ],
      ),
    );
  }

  Widget _statsPanel() {
    return _panelBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _pill('rows: ${_rows.length}', _accent),
              const SizedBox(width: 8),
              _pill(_useBuilder ? 'builder mode' : 'list mode', _info),
              const SizedBox(width: 8),
              _pill(_enableFindIndexCallback ? 'key lookup active' : 'key lookup disabled', _warn),
            ],
          ),
          const SizedBox(height: 10),
          _code(_configSource()),
        ],
      ),
    );
  }

  Widget _eventLog() {
    return _panelBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Delegate Event Log',
                style: TextStyle(color: _accent, fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _events.clear();
                  });
                },
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _panel2),
            ),
            child: _events.isEmpty
                ? const Center(
                    child: Text(
                      'No events yet. Trigger delegate mutations using controls above.',
                      style: TextStyle(color: _txt, fontSize: 11),
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
                          color: _panel,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _events[index],
                          style: const TextStyle(
                            color: _accent,
                            fontSize: 10,
                            fontFamily: 'monospace',
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

  Widget _rowTile(_RowModel row, int index, {required String mode}) {
    return _RememberingRowTile(
      key: ValueKey<int>(row.id),
      row: row,
      index: index,
      mode: mode,
    );
  }

  Widget _action(String label, Color color, VoidCallback onTap) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.2),
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: 0.85)),
      ),
      onPressed: onTap,
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _pill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _addRow() {
    setState(() {
      final color = _seedColors[_rows.length % _seedColors.length];
      _rows.insert(
        0,
        _RowModel(
          id: _nextId,
          label: 'Row $_nextId',
          color: color,
          subtitle: 'Inserted item #$_nextId',
        ),
      );
      _nextId += 1;
    });
    _log('insert model at index 0');
  }

  void _removeFirst() {
    if (_rows.isEmpty) {
      _log('remove skipped: no rows');
      return;
    }
    final removed = _rows.removeAt(0);
    setState(() {});
    _log('remove index 0 -> id ${removed.id}');
  }

  void _shuffleTopFive() {
    if (_rows.length < 5) {
      _log('shuffle skipped: requires at least 5 rows');
      return;
    }
    setState(() {
      final temp = _rows.sublist(0, 5).reversed.toList();
      _rows.setAll(0, temp);
    });
    _log('reordered top 5 items (tests key->index mapping)');
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 340),
      curve: Curves.easeOutCubic,
    );
    _log('scroll -> top');
  }

  void _scrollToBottom() {
    final max = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      max,
      duration: const Duration(milliseconds: 340),
      curve: Curves.easeOutCubic,
    );
    _log('scroll -> bottom');
  }

  void _log(String message) {
    final t = TimeOfDay.now().format(context);
    setState(() {
      _events.insert(0, '$t | $message');
      if (_events.length > 28) {
        _events.removeLast();
      }
    });
  }

  String _configSource() {
    final delegateType = _useBuilder
        ? 'SliverChildBuilderDelegate'
        : 'SliverChildListDelegate';
    return '$delegateType(\n'
        '  addAutomaticKeepAlives: $_addKeepAlive,\n'
        '  addRepaintBoundaries: $_addRepaint,\n'
        '  addSemanticIndexes: $_addSemantics,\n'
        '${_useBuilder ? '  findChildIndexCallback: ${_enableFindIndexCallback ? 'enabled' : 'disabled'},\n' : ''}'
        ')';
  }
}

class _AdvancedApiTab extends StatefulWidget {
  const _AdvancedApiTab();

  @override
  State<_AdvancedApiTab> createState() => _AdvancedApiTabState();
}

class _AdvancedApiTabState extends State<_AdvancedApiTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedApi = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final api = _apiSpecs[_selectedApi];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Abstract API Surface'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List<Widget>.generate(_apiSpecs.length, (index) {
                    final active = index == _selectedApi;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedApi = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? api.color.withValues(alpha: 0.15) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: active ? api.color : _panel2),
                        ),
                        child: Text(
                          _apiSpecs[index].name,
                          style: TextStyle(
                            color: active ? api.color : _txt,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _apiCard(api),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Custom Delegate Skeleton'),
          const SizedBox(height: 8),
          _panelBox(
            child: _code(
              'class FeedDelegate extends SliverChildDelegate {\n'
              '  const FeedDelegate(this.items);\n'
              '  final List<Item> items;\n\n'
              '  @override\n'
              '  Widget? build(BuildContext context, int index) {\n'
              '    if (index >= items.length) return null;\n'
              '    return FeedRow(item: items[index]);\n'
              '  }\n\n'
              '  @override\n'
              '  int? get estimatedChildCount => items.length;\n\n'
              '  @override\n'
              '  bool shouldRebuild(covariant FeedDelegate oldDelegate) {\n'
              '    return oldDelegate.items != items;\n'
              '  }\n'
              '}',
            ),
          ),
          const SizedBox(height: 14),
          _title('Practical Guidance'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Builder delegate is usually preferred for large/virtualized lists because it lazily constructs visible items.'),
                _Bullet('List delegate is straightforward when child set is small and explicit widgets are already available.'),
                _Bullet('Keep findChildIndexCallback aligned with stable keys when reordering is expected to avoid state loss.'),
                _Bullet('Tune keep-alive and repaint boundaries for workload characteristics, not by default assumptions.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiCard(_ApiSpec api) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: api.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: api.color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            api.signature,
            style: TextStyle(
              color: api.color,
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(api.description, style: const TextStyle(color: _txt, fontSize: 11)),
          const SizedBox(height: 6),
          ...api.notes.map(
            (n) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chevron_right, size: 14, color: api.color),
                  Expanded(
                    child: Text(n, style: const TextStyle(color: _txt, fontSize: 10)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RememberingRowTile extends StatefulWidget {
  const _RememberingRowTile({
    super.key,
    required this.row,
    required this.index,
    required this.mode,
  });

  final _RowModel row;
  final int index;
  final String mode;

  @override
  State<_RememberingRowTile> createState() => _RememberingRowTileState();
}

class _RememberingRowTileState extends State<_RememberingRowTile> {
  bool _starred = false;
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    final row = widget.row;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: row.color.withValues(alpha: 0.75)),
      ),
      child: ListTile(
        key: ValueKey<int>(row.id),
        leading: CircleAvatar(
          backgroundColor: row.color.withValues(alpha: 0.2),
          foregroundColor: row.color,
          child: Text('${row.id}', style: const TextStyle(fontSize: 10)),
        ),
        title: Text(
          row.label,
          style: TextStyle(color: row.color, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${row.subtitle} • index ${widget.index} • ${widget.mode}',
          style: const TextStyle(color: _txt, fontSize: 10),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$_tapCount', style: const TextStyle(color: _txt, fontSize: 10)),
            IconButton(
              icon: Icon(_starred ? Icons.star : Icons.star_border, color: _accent),
              onPressed: () {
                setState(() {
                  _starred = !_starred;
                  _tapCount += 1;
                });
              },
            ),
          ],
        ),
        onTap: () {
          setState(() {
            _tapCount += 1;
          });
        },
      ),
    );
  }
}

class _MapRow extends StatelessWidget {
  const _MapRow({required this.left, required this.right});

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              left,
              style: const TextStyle(color: _accent, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(right, style: const TextStyle(color: _txt, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

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
        border: Border.all(color: _primary.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.16),
              shape: BoxShape.circle,
              border: Border.all(color: _accent),
            ),
            alignment: Alignment.center,
            child: Text(step, style: const TextStyle(color: _accent, fontWeight: FontWeight.w700, fontSize: 10)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: _accent, fontSize: 11, fontWeight: FontWeight.w700)),
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
            decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _txt, fontSize: 11))),
        ],
      ),
    );
  }
}

class _Concept {
  const _Concept(this.title, this.description, this.color, this.points);

  final String title;
  final String description;
  final Color color;
  final List<String> points;
}

class _ApiSpec {
  const _ApiSpec(this.name, this.signature, this.description, this.color, this.notes);

  final String name;
  final String signature;
  final String description;
  final Color color;
  final List<String> notes;
}

class _RowModel {
  const _RowModel({required this.id, required this.label, required this.color, required this.subtitle});

  final int id;
  final String label;
  final Color color;
  final String subtitle;
}

Widget _conceptCard(_Concept concept) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: concept.color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: concept.color.withValues(alpha: 0.65)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          concept.description,
          style: const TextStyle(color: _txt, fontSize: 11),
        ),
        const SizedBox(height: 8),
        ...concept.points.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.fiber_manual_record, size: 8, color: concept.color),
                const SizedBox(width: 6),
                Expanded(child: Text(p, style: const TextStyle(color: _txt, fontSize: 10))),
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

Widget _code(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      text,
      style: const TextStyle(color: _accent, fontFamily: 'monospace', fontSize: 10),
    ),
  );
}

const List<_Concept> _concepts = [
  _Concept(
    'Builder Delegate',
    'Build children lazily on demand with an indexed callback.',
    _ok,
    [
      'Best for long or unbounded feeds because offscreen widgets are not created upfront.',
      'Supports childCount for finite lists and optional findChildIndexCallback for reorder safety.',
      'Pairs naturally with dynamic datasets where insertion/removal is frequent.',
    ],
  ),
  _Concept(
    'List Delegate',
    'Provide an explicit widget list as the child source.',
    _info,
    [
      'Simple and readable when child count is small and static.',
      'Useful when each item is prebuilt with custom composition.',
      'Still supports keep-alive/repaint/semantics flags.',
    ],
  ),
  _Concept(
    'Delegate Flags',
    'Control wrapper behavior around produced children.',
    _warn,
    [
      'addAutomaticKeepAlives wraps children with AutomaticKeepAlive when needed.',
      'addRepaintBoundaries can isolate expensive paints to improve scrolling smoothness.',
      'addSemanticIndexes contributes accessibility ordering for screen readers.',
    ],
  ),
];

const List<_ApiSpec> _apiSpecs = [
  _ApiSpec(
    'build',
    'Widget? build(BuildContext context, int index)',
    'Primary hook used by slivers to obtain child widgets by index.',
    _ok,
    [
      'Return null when index is out of range.',
      'Returned child can be cached and reused by render objects.',
    ],
  ),
  _ApiSpec(
    'estimatedChildCount',
    'int? get estimatedChildCount',
    'Allows viewport to estimate scroll extent and layout budget.',
    _info,
    [
      'Return null for unknown/unbounded counts.',
      'Should be accurate once build starts returning null.',
    ],
  ),
  _ApiSpec(
    'estimateMaxScrollOffset',
    'double? estimateMaxScrollOffset(...)',
    'Optional custom estimation when default extrapolation is insufficient.',
    _warn,
    [
      'Can improve scroll bar metrics for irregular child extents.',
      'Often unnecessary for regular item heights.',
    ],
  ),
  _ApiSpec(
    'didFinishLayout',
    'void didFinishLayout(int firstIndex, int lastIndex)',
    'Called after layout to report currently laid out child range.',
    _accent,
    [
      'Useful for analytics, prefetch, and visibility tracking.',
      'Avoid heavy work inside this callback.',
    ],
  ),
  _ApiSpec(
    'shouldRebuild',
    'bool shouldRebuild(covariant SliverChildDelegate oldDelegate)',
    'Determines whether a new delegate instance requires rebuilding children.',
    _err,
    [
      'Return true when data/config changed.',
      'Returning false can reduce rebuild churn.',
    ],
  ),
  _ApiSpec(
    'findIndexByKey',
    'int? findIndexByKey(Key key)',
    'Maps stable key to current index, preserving state across reorder.',
    _info,
    [
      'Important when list order changes but child keys remain stable.',
      'Builder delegate exposes this through findChildIndexCallback.',
    ],
  ),
];

const List<Color> _seedColors = [
  Color(0xFF4DB6AC),
  Color(0xFFFF8A65),
  Color(0xFF7986CB),
  Color(0xFFAED581),
  Color(0xFFFFD54F),
  Color(0xFFBA68C8),
  Color(0xFF4FC3F7),
  Color(0xFFFFB74D),
];
