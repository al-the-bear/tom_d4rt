// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — StatefulElement
///
/// StatefulElement is the Element subclass created by StatefulWidget. When
/// the framework inflates a StatefulWidget, it calls createElement() which
/// returns a StatefulElement. The StatefulElement in turn calls
/// createState() on the widget to obtain the State object, then manages
/// the lifecycle: mount, build, didUpdateWidget, deactivate, unmount.
///
/// Sections
/// ─────────
/// 1. What is StatefulElement?
/// 2. Lifecycle phases: createElement → mount → build → update → unmount
/// 3. Relationship between Widget, Element, State, RenderObject
/// 4. Live: lifecycle event tracker
/// 5. Live: rebuild counter and State persistence
/// 6. didUpdateWidget vs reassemble vs didChangeDependencies
/// 7. Best practices

// ─── palette ───────────────────────────────────────────────
const _kIndigo     = Color(0xFF3F51B5);
const _kIndigoLight = Color(0xFFC5CAE9);
const _kIndigoDark = Color(0xFF1A237E);
const _kGreen      = Color(0xFF4CAF50);
const _kGreenLight = Color(0xFFE8F5E9);
const _kGreenDark  = Color(0xFF1B5E20);
const _kSurface    = Color(0xFFFBFBFD);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── theory content ────────────────────────────────────────
const _kOverview = 'StatefulElement is the bridge between a StatefulWidget and '
    'its State object. When Flutter creates the widget tree, every StatefulWidget '
    'produces a StatefulElement via createElement(). The element owns the State '
    'object for the widget\'s entire mounted lifetime. Even when a parent rebuilds '
    'and provides a new StatefulWidget instance, the same StatefulElement (and '
    'State) persists — receiving didUpdateWidget instead of being recreated. This '
    'is why State survives across rebuilds.';

class _Phase {
  const _Phase(this.name, this.when, this.what);
  final String name;
  final String when;
  final String what;
}

const _kPhases = <_Phase>[
  _Phase('createElement()',
      'Framework inflates the StatefulWidget for the first time.',
      'StatefulWidget.createElement() returns a new StatefulElement. '
      'This element is not yet mounted — it has no parent or slot.'),
  _Phase('createState()',
      'StatefulElement constructor or first mount.',
      'The element calls widget.createState() to obtain the State object. '
      'State._element is set to this element, and State._widget to the widget.'),
  _Phase('mount(parent, slot)',
      'Element is inserted into the element tree.',
      'The element acquires its parent, slot, and depth. It calls '
      'State.initState() and then State.didChangeDependencies(). '
      'After that, the first build() happens.'),
  _Phase('build()',
      'Every time setState() is called or the parent rebuilds.',
      'StatefulElement calls State.build(context) to produce the child '
      'widget subtree. The element then updates its child elements via '
      'updateChild().'),
  _Phase('update(newWidget)',
      'Parent rebuilds and provides a new widget of the same runtimeType.',
      'The element keeps the same State but calls '
      'State.didUpdateWidget(oldWidget). This is how configuration '
      'changes (e.g., new parameters) flow to the State without losing it.'),
  _Phase('didChangeDependencies()',
      'An InheritedWidget ancestor changes.',
      'Called when an InheritedWidget this element depends on changes. '
      'The element marks itself as dirty, triggering a rebuild.'),
  _Phase('deactivate()',
      'Element is removed from the tree (may be reinserted).',
      'State.deactivate() is called. The element is in a transient state — '
      'if it is reinserted before the frame ends, it avoids unmounting.'),
  _Phase('unmount()',
      'Element is permanently removed.',
      'State.dispose() is called. All references are cleared. The State '
      'object must not call setState() after dispose().'),
];

class _Relationship {
  const _Relationship(this.layer, this.lives, this.role);
  final String layer;
  final String lives;
  final String role;
}

const _kRelationships = <_Relationship>[
  _Relationship('StatefulWidget', 'Immutable, recreated on rebuild',
      'Configuration. Describes what the UI should look like. '
      'Creates the Element and State.'),
  _Relationship('StatefulElement', 'Persists across rebuilds',
      'Manager. Owns the State. Compares old and new widgets. '
      'Decides whether to update or replace.'),
  _Relationship('State', 'Persists across rebuilds (owned by Element)',
      'Mutable state + build logic. Holds data that changes over time '
      'and produces the child widget subtree.'),
  _Relationship('RenderObject', 'Persists across rebuilds',
      'Layout and paint. Handles hit testing, sizing, and rendering '
      'to the screen. Managed by RenderObjectElement subclasses.'),
];

class _Callback {
  const _Callback(this.name, this.trigger, this.useCase);
  final String name;
  final String trigger;
  final String useCase;
}

const _kCallbacks = <_Callback>[
  _Callback('didUpdateWidget(oldWidget)',
      'Parent provides a new widget with new parameters.',
      'Compare old and new parameters. Restart animations, cancel '
      'subscriptions for changed values, recalculate derived state.'),
  _Callback('reassemble()',
      'Hot reload only.',
      'Called during development hot reload. Reinitializes state '
      'that depends on const values or code changes.'),
  _Callback('didChangeDependencies()',
      'An InheritedWidget dependency changes.',
      'Fetch new values from the inherited widget. Common with '
      'Theme.of(context), MediaQuery.of(context), or custom providers.'),
];

const _kPractices = <String, String>{
  'Never reference Element directly':
      'Application code should interact with State, not Element. '
      'The element is an internal framework implementation detail.',
  'State persists because Element persists':
      'When you understand that the Element (not the Widget) holds '
      'the State, it becomes clear why keys matter — they control '
      'element matching and thus State identity.',
  'Keys control Element reuse':
      'Without a Key, the framework matches elements by widget runtimeType '
      'and position. With a Key, matching uses type + key value. This lets '
      'you force new State creation or preserve State across reordering.',
  'Always call super in lifecycle methods':
      'initState, dispose, didUpdateWidget, and didChangeDependencies all '
      'have base-class logic. Forgetting super.initState() is a common bug.',
  'setState only after initState and before dispose':
      'Calling setState before initState finishes or after dispose throws. '
      'Guard async callbacks with a mounted check.',
};

// ─── shared helpers ────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kIndigoDark, _kGreenDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
          blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}



Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kIndigo, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('StatefulElement deep visual demo');
  print('─' * 48);
  print('Sections: overview, lifecycle, relationships, tracker,');
  print('rebuild counter, callbacks, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kIndigo, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StatefulElement'),
        backgroundColor: _kIndigoDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _LifecyclePage(), _RebuildPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kIndigoDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Lifecycle'),
          BottomNavigationBarItem(icon: Icon(Icons.refresh), label: 'Rebuild'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        _sectionHeader('1 · What Is StatefulElement?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),

        SizedBox(height: 12),
        _sectionHeader('2 · Lifecycle Phases', Icons.account_tree_outlined),
        SizedBox(height: 8),
        ..._kPhases.asMap().entries.map((e) {
          final i = e.key;
          final p = e.value;
          return _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 26, height: 26,
                      decoration: BoxDecoration(
                        color: _kIndigoLight,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text('${i + 1}',
                          style: TextStyle(fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: _kIndigoDark)),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: _kGreenLight,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(p.name,
                            style: TextStyle(fontFamily: 'monospace',
                                fontWeight: FontWeight.w700, fontSize: 12,
                                color: _kGreenDark)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(p.when,
                    style: TextStyle(fontStyle: FontStyle.italic,
                        fontSize: 11, color: _kIndigo)),
                SizedBox(height: 4),
                Text(p.what,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark,
                        height: 1.35)),
              ],
            ),
          );
        }),

        SizedBox(height: 12),
        _sectionHeader('3 · Widget – Element – State – RenderObject',
            Icons.layers_outlined),
        SizedBox(height: 8),
        ..._kRelationships.map((r) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kIndigoLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(r.layer,
                    style: TextStyle(fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, fontSize: 12,
                        color: _kIndigoDark)),
              ),
              SizedBox(height: 4),
              Text(r.lives,
                  style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic,
                      color: _kGreen)),
              SizedBox(height: 4),
              Text(r.role,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark,
                      height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),
        _sectionHeader('6 · Callback Comparison', Icons.compare),
        SizedBox(height: 8),
        ..._kCallbacks.map((c) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kGreenLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(c.name,
                    style: TextStyle(fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, fontSize: 12,
                        color: _kGreenDark)),
              ),
              SizedBox(height: 4),
              Text('Trigger: ${c.trigger}',
                  style: TextStyle(fontSize: 11, color: _kTextMuted)),
              SizedBox(height: 4),
              Text(c.useCase,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark,
                      height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),
        _sectionHeader('7 · Best Practices', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kPractices.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kGreen, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(e.key,
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 13, color: _kIndigoDark)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(e.value,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark,
                        height: 1.35)),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Lifecycle event tracker
// ═══════════════════════════════════════════════════════════
class _LifecyclePage extends StatefulWidget {
  @override
  State<_LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<_LifecyclePage> {
  bool _showChild = true;
  int _configVersion = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          color: _kIndigoDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('LIFECYCLE EVENT TRACKER',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('Toggle visibility to trigger mount/unmount. Change config '
                  'to trigger didUpdateWidget. Watch lifecycle events appear.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: [
                  _controlButton(
                    _showChild ? 'Remove child' : 'Add child',
                    _showChild ? Icons.visibility_off : Icons.visibility,
                    () => setState(() => _showChild = !_showChild),
                  ),
                  SizedBox(width: 8),
                  _controlButton(
                    'New config (v$_configVersion)',
                    Icons.settings,
                    () => setState(() => _configVersion++),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _showChild
              ? _TrackedChild(key: ValueKey('tracked'), version: _configVersion)
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.child_care, color: _kDivider, size: 48),
                      SizedBox(height: 8),
                      Text('Child removed — Element unmounted',
                          style: TextStyle(color: _kTextMuted, fontSize: 13)),
                      Text('State.dispose() was called',
                          style: TextStyle(fontSize: 11, color: _kTextMuted)),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _controlButton(String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: _kGreen.withOpacity(0.25),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kGreen),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: _kGreen, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(label,
                    style: TextStyle(color: Colors.white, fontSize: 11,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrackedChild extends StatefulWidget {
  const _TrackedChild({required super.key, required this.version});
  final int version;

  @override
  State<_TrackedChild> createState() => _TrackedChildState();
}

class _TrackedChildState extends State<_TrackedChild> {
  final _events = <_LifecycleEvent>[];
  int _buildCount = 0;

  void _log(String phase, String detail) {
    setState(() {
      _events.insert(0, _LifecycleEvent(phase: phase, detail: detail));
    });
  }

  @override
  void initState() {
    super.initState();
    _events.add(_LifecycleEvent(
        phase: 'initState', detail: 'State created. Version: ${widget.version}'));
  }

  @override
  void didUpdateWidget(covariant _TrackedChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    _log('didUpdateWidget',
        'Config changed: v${oldWidget.version} → v${widget.version}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _log('didChangeDependencies', 'Dependencies resolved');
  }

  @override
  void deactivate() {
    // Cannot call setState in deactivate, just print
    print('deactivate() called');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose() called — State destroyed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    // Add build event without setState (we're already in build)
    _events.insert(0, _LifecycleEvent(
        phase: 'build', detail: 'Build #$_buildCount'));

    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        // Stats bar
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kIndigoLight.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _miniStat('Builds', '$_buildCount'),
              _miniStat('Config', 'v${widget.version}'),
              _miniStat('Events', '${_events.length}'),
              _miniStat('State ID', '${hashCode % 10000}'),
            ],
          ),
        ),
        SizedBox(height: 8),
        // Event log
        ..._events.take(30).map((e) {
          final isInit = e.phase == 'initState';
          final isBuild = e.phase == 'build';
          final isUpdate = e.phase == 'didUpdateWidget';
          final isDeps = e.phase == 'didChangeDependencies';
          final color = isInit
              ? _kGreen
              : isBuild
                  ? _kIndigo
                  : isUpdate
                      ? _kGreen
                      : isDeps
                          ? Colors.orange
                          : _kTextMuted;
          final bgColor = isInit
              ? _kGreenLight
              : isBuild
                  ? _kIndigoLight.withOpacity(0.3)
                  : isUpdate
                      ? _kGreenLight
                      : isDeps
                          ? Colors.orange.shade50
                          : Colors.grey.shade100;
          return Container(
            margin: EdgeInsets.only(bottom: 3),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: color, shape: BoxShape.circle),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: Text(e.phase,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 10.5,
                          fontWeight: FontWeight.w700, color: color)),
                ),
                Expanded(
                  child: Text(e.detail,
                      style: TextStyle(fontSize: 10.5, color: _kTextDark)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _miniStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 9, color: _kTextMuted,
            fontWeight: FontWeight.w600)),
        Text(value, style: TextStyle(fontFamily: 'monospace', fontSize: 14,
            fontWeight: FontWeight.w800, color: _kIndigoDark)),
      ],
    );
  }
}

class _LifecycleEvent {
  _LifecycleEvent({required this.phase, required this.detail});
  final String phase;
  final String detail;
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Rebuild counter — State persistence demo
// ═══════════════════════════════════════════════════════════
class _RebuildPage extends StatefulWidget {
  @override
  State<_RebuildPage> createState() => _RebuildPageState();
}

class _RebuildPageState extends State<_RebuildPage> {
  int _parentRebuilds = 0;
  Color _childColor = _kGreen;
  bool _useKey = false;

  static const _kColorOptions = <Color>[
    Color(0xFF4CAF50), Color(0xFFFF9800), Color(0xFF2196F3),
    Color(0xFFE91E63), Color(0xFF9C27B0), Color(0xFF009688),
  ];

  void _triggerParentRebuild() {
    setState(() {
      _parentRebuilds++;
      _childColor = _kColorOptions[_parentRebuilds % _kColorOptions.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          color: _kIndigoDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('STATE PERSISTENCE ACROSS REBUILDS',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('The child keeps its counter even when the parent rebuilds. '
                  'Toggle "Use Key" to force a new Element (and new State).',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: [
                  _rebuildBadge('Parent rebuilds', '$_parentRebuilds'),
                  SizedBox(width: 8),
                  _rebuildBadge('Using key', _useKey ? 'YES' : 'no'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _triggerParentRebuild,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _kGreen.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _kGreen),
                        ),
                        alignment: Alignment.center,
                        child: Text('Rebuild parent',
                            style: TextStyle(color: Colors.white,
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _useKey = !_useKey),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _useKey
                              ? _kIndigo.withOpacity(0.3)
                              : Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _useKey ? _kIndigo : Colors.white24),
                        ),
                        alignment: Alignment.center,
                        child: Text('Toggle key: ${_useKey ? "ON" : "OFF"}',
                            style: TextStyle(color: Colors.white,
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: _CounterChild(
              key: _useKey ? ValueKey(_parentRebuilds) : null,
              accentColor: _childColor,
              parentVersion: _parentRebuilds,
            ),
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('HOW IT WORKS'),
              SizedBox(height: 6),
              _bullet('Without a key: same Element persists across parent rebuilds. '
                  'didUpdateWidget fires, but State (and its counter) remain.'),
              _bullet('With a key that changes: the framework creates a new Element '
                  'because the key differs. The old State is disposed, a new State '
                  'is created with counter back to 0.'),
              _bullet('This demonstrates the core role of StatefulElement — it '
                  'decides whether to reuse or replace the State.'),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _rebuildBadge(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.white54, fontSize: 9,
                fontWeight: FontWeight.w600)),
            Text(value, style: TextStyle(color: _kGreen,
                fontFamily: 'monospace', fontSize: 13,
                fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _CounterChild extends StatefulWidget {
  const _CounterChild({
    super.key,
    required this.accentColor,
    required this.parentVersion,
  });

  final Color accentColor;
  final int parentVersion;

  @override
  State<_CounterChild> createState() => _CounterChildState();
}

class _CounterChildState extends State<_CounterChild> {
  int _counter = 0;
  int _didUpdateCount = 0;

  @override
  void didUpdateWidget(covariant _CounterChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() => _didUpdateCount++);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.accentColor.withOpacity(0.5), width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06),
            blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Child Counter',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                  color: _kTextDark)),
          SizedBox(height: 12),
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color: widget.accentColor.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: widget.accentColor, width: 2),
            ),
            alignment: Alignment.center,
            child: Text('$_counter',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900,
                    color: widget.accentColor)),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() => _counter--),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.remove, color: widget.accentColor, size: 20),
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () => setState(() => _counter++),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.add, color: widget.accentColor, size: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kIndigoLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                _infoRow('State hashCode', '${hashCode % 10000}'),
                _infoRow('didUpdateWidget', '$_didUpdateCount'),
                _infoRow('Parent version', '${widget.parentVersion}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String l, String v) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(l, style: TextStyle(fontSize: 10, color: _kTextMuted)),
          Text(v, style: TextStyle(fontFamily: 'monospace', fontSize: 10,
              fontWeight: FontWeight.w700, color: _kIndigoDark)),
        ],
      ),
    );
  }
}
