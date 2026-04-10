import 'package:flutter/material.dart';

const Color _cPrimary = Color(0xFF263238);
const Color _cAccent = Color(0xFF80DEEA);
const Color _cBg = Color(0xFF0E1114);
const Color _cPanel = Color(0xFF1A2128);
const Color _cPanel2 = Color(0xFF24303A);
const Color _cText = Color(0xFFB8C6D0);
const Color _cGreen = Color(0xFF66BB6A);
const Color _cWarn = Color(0xFFFFCA28);
const Color _cDanger = Color(0xFFEF5350);
const Color _cInfo = Color(0xFF4FC3F7);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _cBg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _cPrimary,
        secondary: _cAccent,
        surface: _cPanel,
      ),
    ),
    home: const _SliverMultiBoxAdaptorElementDemo(),
  );
}

class _SliverMultiBoxAdaptorElementDemo extends StatefulWidget {
  const _SliverMultiBoxAdaptorElementDemo();

  @override
  State<_SliverMultiBoxAdaptorElementDemo> createState() =>
      _SliverMultiBoxAdaptorElementDemoState();
}

class _SliverMultiBoxAdaptorElementDemoState
    extends State<_SliverMultiBoxAdaptorElementDemo>
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
        backgroundColor: _cPanel,
        title: const Text(
          'SliverMultiBoxAdaptorElement',
          style: TextStyle(
            color: _cAccent,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _cAccent,
          labelColor: _cAccent,
          unselectedLabelColor: _cText,
          tabs: const [
            Tab(text: 'Architecture'),
            Tab(text: 'Rebuild Flow'),
            Tab(text: 'Child Manager'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ArchitectureTab(),
          _RebuildFlowTab(),
          _ChildManagerTab(),
        ],
      ),
    );
  }
}

class _ArchitectureTab extends StatefulWidget {
  const _ArchitectureTab();

  @override
  State<_ArchitectureTab> createState() => _ArchitectureTabState();
}

class _ArchitectureTabState extends State<_ArchitectureTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedNode = 0;
  bool _replaceMovedChildren = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final node = _archNodes[_selectedNode];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Purpose and Responsibility'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Acts as the Element layer for slivers backed by a SliverChildDelegate.'),
                _Bullet('Bridges widget delegate output and RenderSliverMultiBoxAdaptor child lifecycle.'),
                _Bullet('Stores visible child Elements in an ordered sparse map keyed by index.'),
                _Bullet('Implements RenderSliverBoxChildManager APIs for createChild/removeChild and extent estimation.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Hierarchy Explorer'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_archNodes.length, (index) {
                    final active = index == _selectedNode;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedNode = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? node.color.withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: active ? node.color : _cPanel2,
                          ),
                        ),
                        child: Text(
                          _archNodes[index].title,
                          style: TextStyle(
                            color: active ? node.color : _cText,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _archCard(node),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Element to RenderObject Bridge'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              children: const [
                _StepRow(
                  step: '1',
                  title: 'createElement()',
                  desc: 'SliverMultiBoxAdaptorWidget creates SliverMultiBoxAdaptorElement.',
                ),
                _Arrow(),
                _StepRow(
                  step: '2',
                  title: 'performRebuild()',
                  desc: 'Element requests widgets from SliverChildDelegate for active indices.',
                ),
                _Arrow(),
                _StepRow(
                  step: '3',
                  title: 'createChild(index, after)',
                  desc: 'Render object asks manager for new child when viewport extends.',
                ),
                _Arrow(),
                _StepRow(
                  step: '4',
                  title: 'removeChild(renderBox)',
                  desc: 'Unused render boxes are detached and corresponding Elements are removed.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Constructor Behavior'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'replaceMovedChildren',
                        style: TextStyle(
                          color: _replaceMovedChildren ? _cWarn : _cText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Switch(
                      value: _replaceMovedChildren,
                      activeTrackColor: _cWarn,
                      onChanged: (v) => setState(() => _replaceMovedChildren = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _code(
                  'SliverMultiBoxAdaptorElement(\n'
                  '  widget,\n'
                  '  replaceMovedChildren: $_replaceMovedChildren,\n'
                  ')',
                ),
                const SizedBox(height: 8),
                Text(
                  _replaceMovedChildren
                      ? 'Enabled: moved children may receive temporary replacements to preserve old index position behavior (used by some sliver variants).'
                      : 'Disabled: moved children are tracked without replacement inflation, reducing extra element churn.',
                  style: const TextStyle(color: _cText, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _archCard(_ArchNode node) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: node.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: node.color.withValues(alpha: 0.65)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            node.subtitle,
            style: const TextStyle(color: _cText, fontSize: 11),
          ),
          const SizedBox(height: 8),
          ...node.points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: node.color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(p, style: const TextStyle(color: _cText, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RebuildFlowTab extends StatefulWidget {
  const _RebuildFlowTab();

  @override
  State<_RebuildFlowTab> createState() => _RebuildFlowTabState();
}

class _RebuildFlowTabState extends State<_RebuildFlowTab>
    with AutomaticKeepAliveClientMixin {
  int _visibleStart = 12;
  int _visibleLength = 8;
  bool _delegateShouldRebuild = false;
  bool _simulateReorder = false;
  final List<String> _log = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final visibleIndices = List<int>.generate(_visibleLength, (i) => _visibleStart + i);
    final simulatedMap = <int, String>{};

    for (final idx in visibleIndices) {
      simulatedMap[idx] = 'Element@$idx';
    }

    if (_simulateReorder) {
      final moved = _visibleStart + 2;
      final target = _visibleStart + 5;
      final existing = simulatedMap[moved];
      if (existing != null) {
        simulatedMap.remove(moved);
        simulatedMap[target] = '$existing (moved from $moved)';
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('performRebuild Simulation'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _metricLine('Visible start', '$_visibleStart', _cInfo),
                const SizedBox(height: 6),
                _metricLine('Visible length', '$_visibleLength', _cAccent),
                const SizedBox(height: 6),
                _metricLine(
                  'Delegate shouldRebuild',
                  _delegateShouldRebuild ? 'true' : 'false',
                  _delegateShouldRebuild ? _cWarn : _cGreen,
                ),
                const SizedBox(height: 10),
                _label('Adjust visible range:'),
                Slider(
                  value: _visibleStart.toDouble(),
                  min: 0,
                  max: 80,
                  divisions: 80,
                  activeColor: _cAccent,
                  onChanged: (v) => setState(() => _visibleStart = v.toInt()),
                ),
                _label('Adjust visible child count:'),
                Slider(
                  value: _visibleLength.toDouble(),
                  min: 3,
                  max: 15,
                  divisions: 12,
                  activeColor: _cAccent,
                  onChanged: (v) => setState(() => _visibleLength = v.toInt()),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _toggle(
                        title: 'delegate.shouldRebuild',
                        value: _delegateShouldRebuild,
                        color: _cWarn,
                        onChanged: (v) => setState(() => _delegateShouldRebuild = v),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _toggle(
                        title: 'simulate key reorder',
                        value: _simulateReorder,
                        color: _cInfo,
                        onChanged: (v) => setState(() => _simulateReorder = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _action('Run rebuild', _cGreen, () {
                      _pushLog('performRebuild() for [$_visibleStart..${_visibleStart + _visibleLength - 1}]');
                      if (_delegateShouldRebuild) {
                        _pushLog('delegate.shouldRebuild == true -> widget refresh path');
                      } else {
                        _pushLog('delegate.shouldRebuild == false -> retain child widgets where possible');
                      }
                      if (_simulateReorder) {
                        _pushLog('findIndexByKey handled moved child mapping');
                      }
                    }),
                    _action('Clear log', _cDanger, () {
                      setState(_log.clear);
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('_childElements SplayTreeMap View'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _code(
                  'final SplayTreeMap<int, Element?> _childElements = {\n'
                  '${simulatedMap.entries.map((e) => '  ${e.key}: ${e.value}').join(',\n')}\n'
                  '};',
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: simulatedMap.entries.map((entry) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: _cPanel2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _cPrimary.withValues(alpha: 0.7)),
                      ),
                      child: Text(
                        '${entry.key} -> ${entry.value}',
                        style: const TextStyle(
                          color: _cAccent,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    );
                  }).toList(growable: false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Rebuild Timeline'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _StepRow(
                  step: 'A',
                  title: 'Snapshot previous child map',
                  desc: 'Capture old indices to compare moved or removed children.',
                ),
                const _Arrow(),
                const _StepRow(
                  step: 'B',
                  title: 'Consult delegate',
                  desc: 'Run shouldRebuild + build(index) to refresh active range.',
                ),
                const _Arrow(),
                const _StepRow(
                  step: 'C',
                  title: 'Reconcile keyed moves',
                  desc: 'Use findIndexByKey to preserve state for reordered widgets.',
                ),
                const _Arrow(),
                const _StepRow(
                  step: 'D',
                  title: 'Sync render object children',
                  desc: 'Adopt new children, drop stale children, and update underflow state.',
                ),
                const SizedBox(height: 10),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _cBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _cPanel2),
                  ),
                  child: _log.isEmpty
                      ? const Center(
                          child: Text(
                            'No timeline events yet. Click Run rebuild.',
                            style: TextStyle(color: _cText, fontSize: 11),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _log.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: _cPanel,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _log[index],
                                style: const TextStyle(
                                  color: _cAccent,
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
          ),
        ],
      ),
    );
  }

  void _pushLog(String message) {
    final stamp = TimeOfDay.now().format(context);
    setState(() {
      _log.insert(0, '$stamp | $message');
      if (_log.length > 24) {
        _log.removeLast();
      }
    });
  }

  Widget _metricLine(String label, String value, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(label, style: const TextStyle(color: _cText, fontSize: 11)),
        ),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _toggle({
    required String title,
    required bool value,
    required Color color,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _cPanel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
          Switch(
            value: value,
            activeTrackColor: color,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ChildManagerTab extends StatefulWidget {
  const _ChildManagerTab();

  @override
  State<_ChildManagerTab> createState() => _ChildManagerTabState();
}

class _ChildManagerTabState extends State<_ChildManagerTab>
    with AutomaticKeepAliveClientMixin {
  int _count = 18;
  final int _firstIndex = 0;
  int _lastIndex = 6;
  bool _underflow = false;
  final List<String> _ops = <String>[];

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
          _title('RenderSliverBoxChildManager API Lab'),
          const SizedBox(height: 8),
          _panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rowMetric('childCount', '$_count', _cInfo),
                _rowMetric('firstIndex in layout', '$_firstIndex', _cAccent),
                _rowMetric('lastIndex in layout', '$_lastIndex', _cAccent),
                _rowMetric('didUnderflow', _underflow ? 'true' : 'false',
                    _underflow ? _cDanger : _cGreen),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _action('createChild(last+1)', _cGreen, () {
                      setState(() {
                        if (_lastIndex + 1 < _count) {
                          _lastIndex += 1;
                          _underflow = false;
                          _pushOp('createChild(index: $_lastIndex, after: $_lastIndex)');
                        } else {
                          _underflow = true;
                          _pushOp('createChild requested beyond childCount -> setDidUnderflow(true)');
                        }
                      });
                    }),
                    _action('removeChild(last)', _cWarn, () {
                      setState(() {
                        if (_lastIndex > _firstIndex) {
                          _pushOp('removeChild(index: $_lastIndex)');
                          _lastIndex -= 1;
                        }
                      });
                    }),
                    _action('estimateMaxScrollOffset', _cInfo, () {
                      final estimate = ((_count * 72) + 24).toDouble();
                      _pushOp('estimateMaxScrollOffset(...) -> ${estimate.toStringAsFixed(1)}');
                    }),
                    _action('didFinishLayout', _cAccent, () {
                      _pushOp('didFinishLayout(first: $_firstIndex, last: $_lastIndex)');
                    }),
                    _action('increase childCount', _cGreen, () {
                      setState(() {
                        _count += 3;
                        _underflow = false;
                      });
                      _pushOp('childCount updated to $_count');
                    }),
                    _action('decrease childCount', _cDanger, () {
                      setState(() {
                        _count = (_count - 3).clamp(3, 200);
                        if (_lastIndex >= _count) {
                          _lastIndex = _count - 1;
                        }
                        _underflow = false;
                      });
                      _pushOp('childCount updated to $_count');
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Visible Child Strip'),
          const SizedBox(height: 8),
          _panel(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _count,
                itemBuilder: (context, index) {
                  final visible = index >= _firstIndex && index <= _lastIndex;
                  return Container(
                    width: 96,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: visible ? _cInfo.withValues(alpha: 0.18) : _cPanel2,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: visible ? _cInfo : _cPrimary),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'index $index',
                          style: TextStyle(
                            color: visible ? _cInfo : _cText,
                            fontFamily: 'monospace',
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Icon(
                          visible ? Icons.visibility : Icons.visibility_off,
                          color: visible ? _cInfo : _cText,
                          size: 16,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Operation Trace'),
          const SizedBox(height: 8),
          _panel(
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: _cBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _cPanel2),
              ),
              child: _ops.isEmpty
                  ? const Center(
                      child: Text(
                        'No operations yet. Trigger actions above.',
                        style: TextStyle(color: _cText, fontSize: 11),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _ops.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _cPanel,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _ops[index],
                            style: const TextStyle(
                              color: _cAccent,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 14),
          _title('How To Use In Custom Slivers'),
          const SizedBox(height: 8),
          _panel(
            child: _code(
              'class MySliverWidget extends SliverMultiBoxAdaptorWidget {\n'
              '  const MySliverWidget({required super.delegate});\n\n'
              '  @override\n'
              '  RenderSliverMultiBoxAdaptor createRenderObject(BuildContext context) {\n'
              '    return RenderSliverList(childManager: context as RenderSliverBoxChildManager);\n'
              '  }\n'
              '}\n\n'
              '// Element side handled by SliverMultiBoxAdaptorElement\n'
              '// via createElement() in base class.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowMetric(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 160, child: Text(label, style: const TextStyle(color: _cText, fontSize: 11))),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  void _pushOp(String msg) {
    final t = TimeOfDay.now().format(context);
    setState(() {
      _ops.insert(0, '$t | $msg');
      if (_ops.length > 28) {
        _ops.removeLast();
      }
    });
  }
}

class _ArchNode {
  const _ArchNode({
    required this.title,
    required this.subtitle,
    required this.points,
    required this.color,
  });

  final String title;
  final String subtitle;
  final List<String> points;
  final Color color;
}

const List<_ArchNode> _archNodes = [
  _ArchNode(
    title: 'RenderObjectElement',
    subtitle: 'Base element lifecycle + render object attachment.',
    points: [
      'Owns mount/update/unmount flows.',
      'Connects widget config to render tree nodes.',
      'Provides parentData and slot update channel.',
    ],
    color: _cInfo,
  ),
  _ArchNode(
    title: 'RenderSliverBoxChildManager',
    subtitle: 'Contract consumed by RenderSliverMultiBoxAdaptor.',
    points: [
      'createChild(index, after)',
      'removeChild(renderBox)',
      'estimateMaxScrollOffset(...) and childCount',
    ],
    color: _cWarn,
  ),
  _ArchNode(
    title: '_childElements map',
    subtitle: 'Sparse ordered map from child index to Element.',
    points: [
      'Stored as SplayTreeMap<int, Element?>',
      'Allows efficient ordered traversal and range operations',
      'Keeps only active/nearby children alive',
    ],
    color: _cGreen,
  ),
  _ArchNode(
    title: 'Delegate bridge',
    subtitle: 'Delegates widget creation to SliverChildDelegate.',
    points: [
      'build(index) may return null when list ends',
      'findIndexByKey enables reorder state preservation',
      'shouldRebuild controls invalidation strategy',
    ],
    color: _cAccent,
  ),
];

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.step,
    required this.title,
    required this.desc,
  });

  final String step;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _cPanel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _cPrimary.withValues(alpha: 0.8)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _cAccent.withValues(alpha: 0.2),
              border: Border.all(color: _cAccent),
              shape: BoxShape.circle,
            ),
            child: Text(
              step,
              style: const TextStyle(
                color: _cAccent,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _cAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(desc, style: const TextStyle(color: _cText, fontSize: 10)),
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
      child: Icon(Icons.arrow_downward_rounded, size: 14, color: _cText),
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
            decoration: const BoxDecoration(color: _cAccent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _cText, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: _cAccent,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
}

Widget _panel({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _cPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _cPanel2),
    ),
    child: child,
  );
}

Widget _code(String value) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _cBg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _cPanel2),
    ),
    child: Text(
      value,
      style: const TextStyle(
        color: _cAccent,
        fontSize: 10,
        fontFamily: 'monospace',
      ),
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
  return Text(text, style: const TextStyle(color: _cText, fontSize: 11));
}
