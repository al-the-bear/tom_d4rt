import 'package:flutter/material.dart';

const Color _bg = Color(0xFF141414);
const Color _panel = Color(0xFF222222);
const Color _panel2 = Color(0xFF323232);
const Color _text = Color(0xFFE6E6E6);
const Color _yellow = Color(0xFFFFD54F);
const Color _green = Color(0xFF81C784);
const Color _blue = Color(0xFF64B5F6);
const Color _orange = Color(0xFFFFB74D);
const Color _red = Color(0xFFE57373);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _yellow,
        secondary: _green,
        surface: _panel,
      ),
    ),
    home: const _StatelessElementDeepDemo(),
  );
}

class _StatelessElementDeepDemo extends StatefulWidget {
  const _StatelessElementDeepDemo();

  @override
  State<_StatelessElementDeepDemo> createState() => _StatelessElementDeepDemoState();
}

class _StatelessElementDeepDemoState extends State<_StatelessElementDeepDemo>
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
          'StatelessElement Deep Demo',
          style: TextStyle(color: _yellow, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _yellow,
          labelColor: _yellow,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Lifecycle'),
            Tab(text: 'Rebuild Lab'),
            Tab(text: 'Guidance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _LifecycleTab(),
          _RebuildLabTab(),
          _GuidanceTab(),
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
  final List<String> _events = <String>['Initialized lifecycle explorer.'];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _LifecyclePhase info = _phases[_phase];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('StatelessElement Purpose'),
          const SizedBox(height: 8),
          _panelBox(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('StatelessElement is the runtime element used for StatelessWidget instances.'),
                _Bullet('It holds widget configuration and calls build() when marked dirty.'),
                _Bullet('It does not own mutable local state like StatefulElement does.'),
                _Bullet('It still participates fully in element lifecycle, dependencies, and updates.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Lifecycle Phases'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_phases.length, (int index) {
                    final bool active = index == _phase;
                    final _LifecyclePhase p = _phases[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() => _phase = index);
                        _push('phase -> ${p.name}');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? p.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: active ? p.color : _panel2),
                        ),
                        child: Text(
                          p.name,
                          style: TextStyle(
                            color: active ? p.color : _text,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _phaseCard(info),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Pipeline Board'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                _pipelineNode(0, 'mount', 'Element inserted into tree with initial widget configuration.', _blue),
                const _Arrow(),
                _pipelineNode(1, 'build', 'StatelessWidget.build executes and returns child widget subtree.', _green),
                const _Arrow(),
                _pipelineNode(2, 'update', 'Parent supplies new widget instance with same runtimeType/key.', _yellow),
                const _Arrow(),
                _pipelineNode(3, 'dependency change', 'InheritedWidget changes can re-trigger build.', _orange),
                const _Arrow(),
                _pipelineNode(4, 'deactivate/unmount', 'Element is removed when subtree no longer retained.', _red),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Event Timeline'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                color: _bg,
                border: Border.all(color: _panel2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _events.length,
                itemBuilder: (BuildContext context, int index) {
                  final String row = _events[_events.length - 1 - index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: _panel,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(row, style: const TextStyle(color: _yellow, fontFamily: 'monospace', fontSize: 10)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _phaseCard(_LifecyclePhase p) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: p.color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: p.color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(p.summary, style: const TextStyle(color: _text, fontSize: 11)),
          const SizedBox(height: 8),
          ...p.notes.map(
            (String n) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chevron_right_rounded, color: p.color, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(n, style: const TextStyle(color: _text, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pipelineNode(int index, String title, String desc, Color color) {
    final bool active = index <= _phase;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.15) : _panel2,
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

  void _push(String message) {
    final String t = TimeOfDay.now().format(context);
    setState(() {
      _events.add('$t | $message');
      if (_events.length > 45) {
        _events.removeAt(0);
      }
    });
  }
}

class _RebuildLabTab extends StatefulWidget {
  const _RebuildLabTab();

  @override
  State<_RebuildLabTab> createState() => _RebuildLabTabState();
}

class _RebuildLabTabState extends State<_RebuildLabTab>
    with AutomaticKeepAliveClientMixin {
  int _counter = 0;
  int _themeTone = 0;
  bool _showInheritedDependency = true;
  bool _showParentDrivenRebuild = true;
  final List<String> _log = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color tone = [
      _blue,
      _green,
      _orange,
      _yellow,
    ][_themeTone % 4];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Rebuild Trigger Lab'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _counter++);
                          _append('parent state updated: counter=$_counter');
                        },
                        icon: const Icon(Icons.add_rounded, size: 16),
                        label: const Text('Parent Update'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _themeTone++);
                          _append('inherited-like theme tone changed: ${_themeTone % 4}');
                        },
                        icon: const Icon(Icons.palette_rounded, size: 16),
                        label: const Text('Change Tone'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _showParentDrivenRebuild,
                  activeThumbColor: _green,
                  title: const Text('Show parent-driven rebuild sample', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool v) {
                    setState(() => _showParentDrivenRebuild = v);
                    _append('toggle parent sample -> $v');
                  },
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _showInheritedDependency,
                  activeThumbColor: _orange,
                  title: const Text('Show inherited dependency sample', style: TextStyle(color: _text, fontSize: 11)),
                  onChanged: (bool v) {
                    setState(() => _showInheritedDependency = v);
                    _append('toggle inherited sample -> $v');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Visual Rebuild Samples'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                if (_showParentDrivenRebuild)
                  _demoCard(
                    title: 'Parent-driven StatelessWidget rebuild',
                    color: _green,
                    child: _ParentDrivenStatelessSample(counter: _counter),
                  ),
                if (_showInheritedDependency)
                  _demoCard(
                    title: 'Inherited-like dependency rebuild',
                    color: _orange,
                    child: _ToneDependentStatelessSample(counter: _counter, tone: tone),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Build Cost Insight'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('StatelessElement rebuilds are cheap when build methods are lightweight and compositional.'),
                _Bullet('Frequent parent updates can still be expensive if child subtree is overly dense.'),
                _Bullet('Use const constructors, split widgets, and memoized values where practical.'),
                _Bullet('Inherited dependencies should be scoped narrowly to avoid unnecessary rebuild spread.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Log'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: _bg,
                border: Border.all(color: _panel2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _log.isEmpty
                  ? const Center(child: Text('No events yet.', style: TextStyle(color: _text, fontSize: 11)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _log.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String row = _log[_log.length - 1 - index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _panel,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(row, style: const TextStyle(color: _blue, fontFamily: 'monospace', fontSize: 10)),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _demoCard({required String title, required Color color, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  void _append(String msg) {
    final String t = TimeOfDay.now().format(context);
    setState(() {
      _log.add('$t | $msg');
      if (_log.length > 45) {
        _log.removeAt(0);
      }
    });
  }
}

class _ParentDrivenStatelessSample extends StatelessWidget {
  const _ParentDrivenStatelessSample({required this.counter});

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.widgets_rounded, color: _green),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Parent passed counter=$counter. StatelessElement updates widget reference and rebuilds this view.',
            style: const TextStyle(color: _text, fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class _ToneDependentStatelessSample extends StatelessWidget {
  const _ToneDependentStatelessSample({required this.counter, required this.tone});

  final int counter;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.9)),
      ),
      child: Text(
        'Inherited-like tone change plus counter=$counter triggers stateless rebuild with new visual context.',
        style: const TextStyle(color: _text, fontSize: 11),
      ),
    );
  }
}

class _GuidanceTab extends StatefulWidget {
  const _GuidanceTab();

  @override
  State<_GuidanceTab> createState() => _GuidanceTabState();
}

class _GuidanceTabState extends State<_GuidanceTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _GuidanceCard card = _guidance[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('When To Use StatelessElement-backed Widgets'),
          const SizedBox(height: 8),
          _panelBox(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_guidance.length, (int index) {
                final bool active = index == _selected;
                final _GuidanceCard g = _guidance[index];
                return GestureDetector(
                  onTap: () => setState(() => _selected = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? g.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? g.color : _panel2),
                    ),
                    child: Text(
                      g.title,
                      style: TextStyle(
                        color: active ? g.color : _text,
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
          _panelBox(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: card.color.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: card.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(card.title, style: TextStyle(color: card.color, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(card.summary, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  ...card.points.map(
                    (String p) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_rounded, color: card.color, size: 14),
                          const SizedBox(width: 5),
                          Expanded(child: Text(p, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Stateless vs Stateful Quick Comparison'),
          const SizedBox(height: 8),
          _panelBox(
            child: const Column(
              children: [
                _CompareRow('Local mutable state', 'No', 'Yes', _red),
                _CompareRow('Element type', 'StatelessElement', 'StatefulElement', _blue),
                _CompareRow('Typical use', 'Presentational/compositional', 'Interactive local state owner', _green),
                _CompareRow('Build trigger source', 'Parent/inherited changes', 'Parent/inherited + setState', _orange),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Best Practices'),
          const SizedBox(height: 8),
          _panelBox(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Keep build methods deterministic and side-effect free.'),
                _Bullet('Use smaller stateless widgets to isolate rebuild boundaries.'),
                _Bullet('Prefer immutable constructor fields and const usage where possible.'),
                _Bullet('Elevate state ownership to parents when shared across siblings.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecyclePhase {
  const _LifecyclePhase({
    required this.name,
    required this.summary,
    required this.notes,
    required this.color,
  });

  final String name;
  final String summary;
  final List<String> notes;
  final Color color;
}

class _GuidanceCard {
  const _GuidanceCard({
    required this.title,
    required this.summary,
    required this.points,
    required this.color,
  });

  final String title;
  final String summary;
  final List<String> points;
  final Color color;
}

const List<_LifecyclePhase> _phases = [
  _LifecyclePhase(
    name: 'mount',
    summary: 'Element is created and mounted with its initial StatelessWidget config.',
    notes: [
      'Runtime links widget -> element in the tree.',
      'Initial build returns first child subtree.',
    ],
    color: _blue,
  ),
  _LifecyclePhase(
    name: 'build',
    summary: 'build() computes descendants from immutable configuration and inherited context.',
    notes: [
      'Should avoid side effects and preserve pure mapping style.',
      'Can depend on inherited widgets from context.',
    ],
    color: _green,
  ),
  _LifecyclePhase(
    name: 'update',
    summary: 'Parent provides a new StatelessWidget instance; element swaps config and rebuilds.',
    notes: [
      'Happens when parent rebuilds same slot with same key/type.',
      'No separate State object lifecycle involved.',
    ],
    color: _yellow,
  ),
  _LifecyclePhase(
    name: 'dependency',
    summary: 'Inherited dependency changes mark element dirty and trigger rebuild.',
    notes: [
      'Theme, media query, localization are common triggers.',
      'Dependency scope design influences rebuild fan-out.',
    ],
    color: _orange,
  ),
  _LifecyclePhase(
    name: 'unmount',
    summary: 'Element leaves tree; resources owned in widget tree path are released.',
    notes: [
      'Stateless element itself has minimal teardown concerns.',
      'Child subtree deactivation/unmount still occurs as usual.',
    ],
    color: _red,
  ),
];

const List<_GuidanceCard> _guidance = [
  _GuidanceCard(
    title: 'Use Stateless',
    summary: 'Choose stateless widgets when output is a pure function of inputs and context.',
    points: [
      'Great for reusable UI atoms and composition shells.',
      'Works well with external state managers feeding immutable props.',
      'Keeps lifecycle simpler and predictable.',
    ],
    color: _green,
  ),
  _GuidanceCard(
    title: 'Avoid Misuse',
    summary: 'Do not force local mutable behavior into stateless widgets.',
    points: [
      'Avoid hidden mutable singletons for per-widget ephemeral state.',
      'Avoid side effects during build to emulate lifecycle hooks.',
      'Prefer StatefulWidget when local state transition is intrinsic.',
    ],
    color: _red,
  ),
  _GuidanceCard(
    title: 'Performance',
    summary: 'Stateless trees can still be expensive; structure matters.',
    points: [
      'Break large build methods into dedicated child widgets.',
      'Use const constructors and const widgets where possible.',
      'Keep inherited dependencies tightly scoped.',
    ],
    color: _blue,
  ),
];

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
            decoration: const BoxDecoration(color: _yellow, shape: BoxShape.circle),
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

class _CompareRow extends StatelessWidget {
  const _CompareRow(this.aspect, this.stateless, this.stateful, this.color);

  final String aspect;
  final String stateless;
  final String stateful;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(aspect, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
          Expanded(child: Text(stateless, style: const TextStyle(color: _text, fontSize: 10))),
          const SizedBox(width: 8),
          Expanded(child: Text(stateful, style: const TextStyle(color: _text, fontSize: 10))),
        ],
      ),
    );
  }
}

Widget _title(String value) {
  return Text(
    value,
    style: const TextStyle(color: _yellow, fontSize: 14, fontWeight: FontWeight.w700),
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
