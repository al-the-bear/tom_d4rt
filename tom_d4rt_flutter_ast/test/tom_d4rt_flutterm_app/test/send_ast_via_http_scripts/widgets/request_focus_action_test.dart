// D4rt deep demo: RequestFocusAction — the built-in Action<RequestFocusIntent>
// that calls FocusNode.requestFocus() when a RequestFocusIntent is invoked via
// the Actions/Intents pipeline. Demonstrates programmatic focus management,
// keyboard shortcuts wired to Shortcuts widget, FocusNode lifecycle,
// custom Action subclasses, and comparisons with alternative focus APIs.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Top-level ValueNotifiers (permitted in stateless d4rt demo) ─────────────
final ValueNotifier<String> _focusedNodeId = ValueNotifier<String>('none');
final ValueNotifier<bool> _conditionMet = ValueNotifier<bool>(true);
final ValueNotifier<String> _lastAction = ValueNotifier<String>('—');

// ─── Shared FocusNodes (top-level so they survive rebuilds) ──────────────────
final FocusNode _node1 = FocusNode(debugLabel: 'Node-1');
final FocusNode _node2 = FocusNode(debugLabel: 'Node-2');
final FocusNode _node3 = FocusNode(debugLabel: 'Node-3');
final FocusNode _node4 = FocusNode(debugLabel: 'Node-4');
final FocusNode _node5 = FocusNode(debugLabel: 'Node-5');

// ─── Colors for each node card ───────────────────────────────────────────────
const List<Color> _nodeColors = <Color>[
  Color(0xFF1565C0),
  Color(0xFF6A1B9A),
  Color(0xFF00695C),
  Color(0xFFAD1457),
  Color(0xFFE65100),
];

const List<String> _nodeLabels = <String>[
  'Node-1',
  'Node-2',
  'Node-3',
  'Node-4',
  'Node-5',
];

// ─────────────────────────────────────────────────────────────────────────────
//  Entry point required by the D4rt harness
// ─────────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return const _RequestFocusActionDemoApp();
}

// ══════════════════════════════════════════════════════════════════════════════
//  Root MaterialApp
// ══════════════════════════════════════════════════════════════════════════════
class _RequestFocusActionDemoApp extends StatelessWidget {
  const _RequestFocusActionDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RequestFocusAction Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const _DemoHome(),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  Home — 9-tab DefaultTabController
// ══════════════════════════════════════════════════════════════════════════════
class _DemoHome extends StatelessWidget {
  const _DemoHome();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          toolbarHeight: 80,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'RequestFocusAction',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(height: 3),
              Text(
                'Action<RequestFocusIntent> — focus via the Actions/Intents pipeline',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _DemoTabBar(),
          ),
        ),
        body: const SafeArea(
          top: false,
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              _HeroBannerTab(),
              _LiveDemoTab(),
              _ShortcutsTab(),
              _LifecycleTab(),
              _FocusTreeTab(),
              _InvokePatternTab(),
              _ConditionalFocusTab(),
              _FocusScopeVsManagerTab(),
              _ApiCheatSheetTab(),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  Tab bar
// ══════════════════════════════════════════════════════════════════════════════
class _DemoTabBar extends StatelessWidget {
  const _DemoTabBar();

  static const List<String> _titles = <String>[
    'Hero',
    'Live',
    'Keys',
    'Lifecycle',
    'Tree',
    'Invoke',
    'Conditional',
    'Scope',
    'API',
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: scheme.onPrimary,
      labelColor: scheme.onPrimary,
      unselectedLabelColor: scheme.onPrimary.withValues(alpha: 0.6),
      tabs: _titles
          .map((String t) => Tab(text: t, height: 44))
          .toList(),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 1 — Hero Banner
// ══════════════════════════════════════════════════════════════════════════════
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        // ── Banner card ────────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.primary,
                scheme.primaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.center_focus_strong, color: scheme.onPrimary, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'RequestFocusAction',
                      style: txt.headlineSmall?.copyWith(
                        color: scheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'class RequestFocusAction extends Action<RequestFocusIntent>',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: scheme.onPrimary.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'A built-in Flutter Action that handles RequestFocusIntent by '
                'calling FocusNode.requestFocus() on the node carried inside '
                'the intent. It bridges the declarative Actions/Intents pipeline '
                'to the imperative FocusNode API, so any part of the widget tree '
                'can shift focus without holding a direct reference to the target node.',
                style: TextStyle(
                  color: scheme.onPrimary.withValues(alpha: 0.88),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ── Pipeline diagram ───────────────────────────────────────────────
        Text('Actions / Intents Pipeline', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        const _PipelineDiagram(),

        const SizedBox(height: 24),

        // ── Key facts ─────────────────────────────────────────────────────
        Text('Key Facts', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        ...<_FactRow>[
          const _FactRow(icon: Icons.play_arrow, label: 'Trigger', value: 'Actions.invoke(context, RequestFocusIntent(node))'),
          const _FactRow(icon: Icons.settings_input_composite, label: 'Intent type', value: 'RequestFocusIntent(FocusNode node)'),
          const _FactRow(icon: Icons.architecture, label: 'Action type', value: 'Action<RequestFocusIntent>'),
          const _FactRow(icon: Icons.widgets, label: 'Registered by', value: 'Flutter framework (WidgetsApp / Actions widget)'),
          const _FactRow(icon: Icons.keyboard, label: 'Keyboard aware', value: 'Yes — wired via Shortcuts to LogicalKeySet'),
          const _FactRow(icon: Icons.code, label: 'Effect', value: 'Calls intent.focusNode.requestFocus()'),
        ],

        const SizedBox(height: 24),

        // ── When to use ───────────────────────────────────────────────────
        Text('When to Use', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _InfoCard(
          color: scheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem('You want focus changes to flow through the Actions/Intents layer so they can be intercepted or overridden.'),
              _BulletItem('You are wiring keyboard shortcuts to specific FocusNodes via a Shortcuts widget.'),
              _BulletItem('You want to keep widget code decoupled — the sender does not need to hold the FocusNode reference.'),
              _BulletItem('You are building an accessibility-first UI where every focus transition is auditable and testable.'),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ── Related classes ────────────────────────────────────────────────
        Text('Related Classes', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _Chip('RequestFocusIntent'),
            _Chip('FocusNode'),
            _Chip('FocusScope'),
            _Chip('Actions'),
            _Chip('Shortcuts'),
            _Chip('FocusableActionDetector'),
            _Chip('FocusScopeNode'),
            _Chip('FocusManager'),
            _Chip('FocusTraversalGroup'),
          ],
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  Pipeline diagram widget
// ══════════════════════════════════════════════════════════════════════════════
class _PipelineDiagram extends StatelessWidget {
  const _PipelineDiagram();

  static const List<_PipelineStep> _steps = <_PipelineStep>[
    _PipelineStep(icon: Icons.keyboard, label: 'User event\nor button tap', color: Color(0xFF1565C0)),
    _PipelineStep(icon: Icons.send, label: 'RequestFocusIntent\n(carries FocusNode)', color: Color(0xFF6A1B9A)),
    _PipelineStep(icon: Icons.search, label: 'Actions.invoke\nfinds handler', color: Color(0xFF00695C)),
    _PipelineStep(icon: Icons.flash_on, label: 'RequestFocusAction\n.invoke()', color: Color(0xFFAD1457)),
    _PipelineStep(icon: Icons.center_focus_strong, label: 'FocusNode\n.requestFocus()', color: Color(0xFFE65100)),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          for (int i = 0; i < _steps.length; i++) ...<Widget>[
            _PipelineStepWidget(step: _steps[i]),
            if (i < _steps.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.arrow_forward, size: 20, color: Color(0xFF757575)),
              ),
          ],
        ],
      ),
    );
  }
}

class _PipelineStep {
  final IconData icon;
  final String label;
  final Color color;
  const _PipelineStep({required this.icon, required this.label, required this.color});
}

class _PipelineStepWidget extends StatelessWidget {
  final _PipelineStep step;
  const _PipelineStepWidget({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: step.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: step.color.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(step.icon, color: step.color, size: 28),
          const SizedBox(height: 6),
          Text(
            step.label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: step.color, fontWeight: FontWeight.w600, height: 1.3),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 2 — Live Demo
// ══════════════════════════════════════════════════════════════════════════════
class _LiveDemoTab extends StatelessWidget {
  const _LiveDemoTab();

  List<FocusNode> get _nodes => <FocusNode>[_node1, _node2, _node3, _node4, _node5];

  void _invokeFocus(BuildContext context, int index) {
    Actions.invoke(context, RequestFocusIntent(_nodes[index]));
    _focusedNodeId.value = _nodeLabels[index];
    _lastAction.value = 'Actions.invoke → RequestFocusIntent(${_nodeLabels[index]})';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return Actions(
      actions: <Type, Action<Intent>>{
        RequestFocusIntent: RequestFocusAction(),
      },
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Text('Live Demo — 5 FocusNodes', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            'Tap a button to invoke RequestFocusAction via the Actions/Intents pipeline. '
            'The highlighted card shows which FocusNode is currently focused.',
            style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          // ── Focused node indicator ────────────────────────────────────
          ValueListenableBuilder<String>(
            valueListenable: _focusedNodeId,
            builder: (BuildContext ctx, String id, Widget? _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: id == 'none' ? scheme.surfaceContainerHighest : scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      id == 'none' ? Icons.radio_button_unchecked : Icons.center_focus_strong,
                      color: scheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      id == 'none' ? 'No node focused yet' : 'Focused: $id',
                      style: txt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // ── Node cards ────────────────────────────────────────────────
          for (int i = 0; i < _nodes.length; i++) ...<Widget>[
            _LiveNodeCard(
              index: i,
              node: _nodes[i],
              onFocusRequest: () => _invokeFocus(context, i),
            ),
            const SizedBox(height: 10),
          ],

          const SizedBox(height: 16),

          // ── Last action log ───────────────────────────────────────────
          ValueListenableBuilder<String>(
            valueListenable: _lastAction,
            builder: (BuildContext ctx, String action, Widget? _) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Last action invoked:',
                      style: TextStyle(
                        color: Colors.greenAccent.withValues(alpha: 0.7),
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      action,
                      style: const TextStyle(
                        color: Color(0xFFE0E0E0),
                        fontSize: 13,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // ── Quick-focus button row ─────────────────────────────────────
          Text('Quick Focus Buttons', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (int i = 0; i < _nodes.length; i++)
                ElevatedButton.icon(
                  onPressed: () => _invokeFocus(context, i),
                  icon: const Icon(Icons.center_focus_weak, size: 16),
                  label: Text('Focus ${i + 1}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _nodeColors[i],
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Live node card ───────────────────────────────────────────────────────────
class _LiveNodeCard extends StatelessWidget {
  final int index;
  final FocusNode node;
  final VoidCallback onFocusRequest;
  const _LiveNodeCard({required this.index, required this.node, required this.onFocusRequest});

  @override
  Widget build(BuildContext context) {
    final Color base = _nodeColors[index];
    return ValueListenableBuilder<String>(
      valueListenable: _focusedNodeId,
      builder: (BuildContext ctx, String focusedId, Widget? _) {
        final bool isFocused = focusedId == _nodeLabels[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isFocused ? base.withValues(alpha: 0.15) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isFocused ? base : base.withValues(alpha: 0.3),
              width: isFocused ? 2.5 : 1,
            ),
            boxShadow: isFocused
                ? <BoxShadow>[BoxShadow(color: base.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))]
                : const <BoxShadow>[],
          ),
          child: Row(
            children: <Widget>[
              // Node color circle
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: base,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: base.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 2)),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Label
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _nodeLabels[index],
                      style: TextStyle(fontWeight: FontWeight.w700, color: base, fontSize: 15),
                    ),
                    Text(
                      isFocused ? 'Currently focused' : 'Not focused',
                      style: TextStyle(
                        fontSize: 12,
                        color: isFocused ? base : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              // Focus ring indicator
              if (isFocused)
                Icon(Icons.radio_button_checked, color: base, size: 22),
              const SizedBox(width: 8),
              // Focus button
              ElevatedButton(
                onPressed: onFocusRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: base,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                ),
                child: const Text('Focus', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 3 — Via Shortcuts
// ══════════════════════════════════════════════════════════════════════════════
class _ShortcutsTab extends StatelessWidget {
  const _ShortcutsTab();

  List<FocusNode> get _nodes => <FocusNode>[_node1, _node2, _node3, _node4, _node5];

  static const List<LogicalKeyboardKey> _keys = <LogicalKeyboardKey>[
    LogicalKeyboardKey.f1,
    LogicalKeyboardKey.f2,
    LogicalKeyboardKey.f3,
    LogicalKeyboardKey.f4,
    LogicalKeyboardKey.f5,
  ];

  static const List<String> _keyLabels = <String>['F1', 'F2', 'F3', 'F4', 'F5'];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;

    // Build shortcuts map: LogicalKeySet → RequestFocusIntent
    final Map<ShortcutActivator, Intent> shortcutsMap = <ShortcutActivator, Intent>{
      for (int i = 0; i < _nodes.length; i++)
        SingleActivator(_keys[i]): RequestFocusIntent(_nodes[i]),
    };

    return Shortcuts(
      shortcuts: shortcutsMap,
      child: Actions(
        actions: <Type, Action<Intent>>{
          RequestFocusIntent: RequestFocusAction(),
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Text('Via Shortcuts Widget', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'A Shortcuts widget maps LogicalKeyboardKey (F1–F5) to '
              'RequestFocusIntent instances. Pressing the key on a physical '
              'keyboard invokes RequestFocusAction automatically.',
              style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.5),
            ),

            const SizedBox(height: 16),

            // ── Shortcut wire diagram ─────────────────────────────────
            _InfoCard(
              color: scheme.secondaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Wire-up pattern', style: txt.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  _MonoText(
                    'Shortcuts(\n'
                    '  shortcuts: {\n'
                    '    SingleActivator(LogicalKeyboardKey.f1):\n'
                    '        RequestFocusIntent(node1),\n'
                    '    SingleActivator(LogicalKeyboardKey.f2):\n'
                    '        RequestFocusIntent(node2),\n'
                    '    // ... F3–F5\n'
                    '  },\n'
                    '  child: Actions(\n'
                    '    actions: {\n'
                    '      RequestFocusIntent: RequestFocusAction(),\n'
                    '    },\n'
                    '    child: yourWidget,\n'
                    '  ),\n'
                    ')',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Keyboard shortcut cards ───────────────────────────────
            Text('Keyboard Shortcut Cards', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            for (int i = 0; i < _nodes.length; i++) ...<Widget>[
              _ShortcutCard(
                index: i,
                keyLabel: _keyLabels[i],
                node: _nodes[i],
              ),
              const SizedBox(height: 8),
            ],

            const SizedBox(height: 16),

            // ── How Shortcuts works ───────────────────────────────────
            Text('How Shortcuts Resolution Works', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _InfoCard(
              color: scheme.tertiaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _BulletItem('Shortcuts widget registers a ShortcutManager in the widget tree.'),
                  _BulletItem('On key event, ShortcutManager walks up the tree to find a matching ShortcutActivator.'),
                  _BulletItem('Matched Intent is dispatched via Actions.invoke(context, intent).'),
                  _BulletItem('Actions walks up the tree to find an Action<RequestFocusIntent> handler.'),
                  _BulletItem('RequestFocusAction.invoke() is called with the intent.'),
                  _BulletItem('FocusNode.requestFocus() is called on intent.focusNode.'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── SingleActivator vs LogicalKeySet ──────────────────────
            Text('SingleActivator vs LogicalKeySet', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _ComparisonRow(
              leftTitle: 'SingleActivator (preferred)',
              leftLines: const <String>[
                'SingleActivator(LogicalKeyboardKey.f1)',
                '→ Handles meta-key variations',
                '→ More precise, recommended in M3',
              ],
              rightTitle: 'LogicalKeySet (legacy)',
              rightLines: const <String>[
                'LogicalKeySet(LogicalKeyboardKey.f1)',
                '→ Older API, still works',
                '→ Less control over modifiers',
              ],
              leftColor: const Color(0xFF00695C),
              rightColor: const Color(0xFF6A1B9A),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shortcut card ─────────────────────────────────────────────────────────
class _ShortcutCard extends StatelessWidget {
  final int index;
  final String keyLabel;
  final FocusNode node;
  const _ShortcutCard({required this.index, required this.keyLabel, required this.node});

  @override
  Widget build(BuildContext context) {
    final Color base = _nodeColors[index];
    return ValueListenableBuilder<String>(
      valueListenable: _focusedNodeId,
      builder: (BuildContext ctx, String focusedId, Widget? _) {
        final bool isFocused = focusedId == _nodeLabels[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isFocused ? base.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isFocused ? base : base.withValues(alpha: 0.3), width: isFocused ? 2 : 1),
          ),
          child: Row(
            children: <Widget>[
              // Keyboard key badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: base.withValues(alpha: 0.4), blurRadius: 6, offset: const Offset(0, 2)),
                  ],
                ),
                child: Text(
                  keyLabel,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14, fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '→ RequestFocusIntent(${_nodeLabels[index]})',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: base, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      isFocused ? 'Active — this node is focused' : 'Press $keyLabel to focus',
                      style: TextStyle(fontSize: 11, color: isFocused ? base : Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
              if (isFocused) Icon(Icons.check_circle, color: base, size: 20),
            ],
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 4 — FocusNode Lifecycle
// ══════════════════════════════════════════════════════════════════════════════
class _LifecycleTab extends StatelessWidget {
  const _LifecycleTab();

  static const List<_LifecyclePhase> _phases = <_LifecyclePhase>[
    _LifecyclePhase(
      icon: Icons.add_circle_outline,
      title: '1. Create',
      code: 'final node = FocusNode(debugLabel: \'MyNode\');',
      description: 'FocusNode is instantiated. At this point it is detached — not part of any FocusScopeNode. No focus operations are valid yet.',
      color: Color(0xFF1565C0),
    ),
    _LifecyclePhase(
      icon: Icons.link,
      title: '2. Attach (mount)',
      code: 'Focus(focusNode: node, child: widget)',
      description: 'The Focus widget mounts and attaches the node to the nearest FocusScopeNode in the tree. The node is now a valid focus target.',
      color: Color(0xFF6A1B9A),
    ),
    _LifecyclePhase(
      icon: Icons.center_focus_strong,
      title: '3. RequestFocus',
      code: 'Actions.invoke(ctx, RequestFocusIntent(node));\n// or: node.requestFocus();',
      description: 'Focus is transferred to this node. hasFocus becomes true. FocusManager.instance.primaryFocus points here. onFocusChange callbacks fire.',
      color: Color(0xFF00695C),
    ),
    _LifecyclePhase(
      icon: Icons.remove_circle_outline,
      title: '4. Unfocus',
      code: 'node.unfocus();\n// or focus another node',
      description: 'Focus leaves this node. hasFocus becomes false. The node remains attached and can receive focus again.',
      color: Color(0xFFAD1457),
    ),
    _LifecyclePhase(
      icon: Icons.delete_outline,
      title: '5. Dispose',
      code: 'node.dispose(); // in State.dispose()',
      description: 'Must be called when the owning State is disposed. Removes the node from the focus tree and releases resources. Never call requestFocus after dispose.',
      color: Color(0xFFE65100),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text('FocusNode Lifecycle', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(
          'A FocusNode goes through five distinct phases. RequestFocusAction '
          'operates in the requestFocus phase (step 3).',
          style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 20),

        // ── Timeline ──────────────────────────────────────────────────
        for (int i = 0; i < _phases.length; i++) ...<Widget>[
          _LifecyclePhaseCard(phase: _phases[i], isLast: i == _phases.length - 1),
        ],

        const SizedBox(height: 20),

        // ── Lifecycle with RequestFocusAction highlighted ─────────────
        Text('RequestFocusAction in Context', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _InfoCard(
          color: scheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem('RequestFocusAction only works safely in phase 2–4 (node attached, not disposed).'),
              _BulletItem('If node is not attached, requestFocus() is a no-op.'),
              _BulletItem('If node is disposed, requestFocus() throws in debug mode.'),
              _BulletItem('Always create FocusNode in initState, dispose in dispose().'),
              _BulletItem('Top-level FocusNode (like this demo) are valid but never disposed — use only in demos.'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ── State properties ──────────────────────────────────────────
        Text('FocusNode State Properties', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _PropertiesTable(
          headers: const <String>['Property', 'Type', 'Description'],
          rows: const <List<String>>[
            ['hasFocus', 'bool', 'True if this node or a descendant has focus'],
            ['hasPrimaryFocus', 'bool', 'True if this exact node is the primary focus'],
            ['canRequestFocus', 'bool', 'Whether focus can be requested (e.g. not in read-only scope)'],
            ['skipTraversal', 'bool', 'Excluded from keyboard traversal if true'],
            ['debugLabel', 'String?', 'Human-readable label for debugging'],
            ['parent', 'FocusNode?', 'Parent node in the focus tree'],
            ['children', 'Iterable<FocusNode>', 'Direct child nodes'],
          ],
        ),
      ],
    );
  }
}

// ─── Lifecycle phase card ─────────────────────────────────────────────────
class _LifecyclePhase {
  final IconData icon;
  final String title;
  final String code;
  final String description;
  final Color color;
  const _LifecyclePhase({
    required this.icon,
    required this.title,
    required this.code,
    required this.description,
    required this.color,
  });
}

class _LifecyclePhaseCard extends StatelessWidget {
  final _LifecyclePhase phase;
  final bool isLast;
  const _LifecyclePhaseCard({required this.phase, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Timeline column
        Column(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: phase.color,
                shape: BoxShape.circle,
              ),
              child: Icon(phase.icon, color: Colors.white, size: 20),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 80,
                color: phase.color.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(phase.title, style: TextStyle(fontWeight: FontWeight.w700, color: phase.color, fontSize: 15)),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    phase.code,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFE0E0E0), height: 1.5),
                  ),
                ),
                const SizedBox(height: 6),
                Text(phase.description, style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.5)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 5 — Focus Tree Visualization (CustomPainter)
// ══════════════════════════════════════════════════════════════════════════════
class _FocusTreeTab extends StatelessWidget {
  const _FocusTreeTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text('Focus Tree Visualization', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(
          'The focus tree mirrors the widget tree. FocusScopeNode acts as a '
          'container; FocusNode leaves receive actual keyboard events. '
          'RequestFocusAction moves the primaryFocus pointer.',
          style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 20),

        // ── Custom painter ────────────────────────────────────────────
        ValueListenableBuilder<String>(
          valueListenable: _focusedNodeId,
          builder: (BuildContext ctx, String focusedId, Widget? _) {
            return Container(
              height: 420,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: scheme.outlineVariant),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomPaint(
                  painter: _FocusTreePainter(focusedNodeId: focusedId),
                  child: const SizedBox.expand(),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        // ── Legend ────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _LegendItem(color: const Color(0xFF1565C0), label: 'FocusScopeNode'),
            const SizedBox(width: 20),
            _LegendItem(color: const Color(0xFF00695C), label: 'FocusNode (inactive)'),
            const SizedBox(width: 20),
            _LegendItem(color: const Color(0xFFE65100), label: 'FocusNode (active)'),
          ],
        ),

        const SizedBox(height: 20),

        // ── Tree structure explanation ─────────────────────────────────
        Text('Tree Structure', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _InfoCard(
          color: scheme.surfaceContainerHigh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _MonoText(
                'FocusManager.rootScope (FocusScopeNode)\n'
                '  └─ App FocusScope (FocusScopeNode)\n'
                '       ├─ Node-1 (FocusNode)  ← F1\n'
                '       ├─ Node-2 (FocusNode)  ← F2\n'
                '       ├─ Node-3 (FocusNode)  ← F3\n'
                '       ├─ Node-4 (FocusNode)  ← F4\n'
                '       └─ Node-5 (FocusNode)  ← F5',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── FocusScopeNode vs FocusNode ───────────────────────────────
        Text('FocusScopeNode vs FocusNode', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _ComparisonRow(
          leftTitle: 'FocusScopeNode',
          leftLines: const <String>[
            'Container — groups FocusNodes',
            'Remembers last focused child',
            'Created by FocusScope widget',
            'Cannot receive keyboard events',
          ],
          rightTitle: 'FocusNode',
          rightLines: const <String>[
            'Leaf — actual focus target',
            'Receives keyboard events',
            'Created by Focus widget',
            'Target of RequestFocusIntent',
          ],
          leftColor: const Color(0xFF1565C0),
          rightColor: const Color(0xFF00695C),
        ),
      ],
    );
  }
}

// ─── Focus tree CustomPainter ─────────────────────────────────────────────
class _FocusTreePainter extends CustomPainter {
  final String focusedNodeId;
  const _FocusTreePainter({required this.focusedNodeId});

  static const List<String> _nodeNames = <String>['Node-1', 'Node-2', 'Node-3', 'Node-4', 'Node-5'];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final Paint scopePaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..style = PaintingStyle.fill;

    final Paint nodePaint = Paint()
      ..color = const Color(0xFF00695C)
      ..style = PaintingStyle.fill;

    final Paint activePaint = Paint()
      ..color = const Color(0xFFE65100)
      ..style = PaintingStyle.fill;

    final Paint glowPaint = Paint()
      ..color = const Color(0xFFE65100).withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final Paint textBgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    // ── Root scope node ───────────────────────────────────────────────
    final Offset rootPos = Offset(size.width / 2, 50);
    canvas.drawCircle(rootPos, 28, Paint()..color = const Color(0xFF1565C0).withValues(alpha: 0.15)..style = PaintingStyle.fill);
    canvas.drawCircle(rootPos, 28, scopePaint..style = PaintingStyle.stroke..strokeWidth = 2.5);
    _drawLabel(canvas, 'FocusScope\n(root)', rootPos, const Color(0xFF1565C0));

    // ── App scope node ─────────────────────────────────────────────────
    final Offset appScopePos = Offset(size.width / 2, 150);
    canvas.drawLine(rootPos + const Offset(0, 28), appScopePos - const Offset(0, 24), linePaint);
    canvas.drawCircle(appScopePos, 24, Paint()..color = const Color(0xFF1565C0).withValues(alpha: 0.1)..style = PaintingStyle.fill);
    canvas.drawCircle(appScopePos, 24, scopePaint..style = PaintingStyle.stroke..strokeWidth = 2);
    _drawLabel(canvas, 'App\nScope', appScopePos, const Color(0xFF1565C0));

    // ── Five leaf nodes ────────────────────────────────────────────────
    const double leafY = 300;
    final double spacing = size.width / 6;
    for (int i = 0; i < 5; i++) {
      final double x = spacing + i * spacing;
      final Offset leafPos = Offset(x, leafY);
      final bool isActive = focusedNodeId == _nodeNames[i];

      // Connection line
      canvas.drawLine(appScopePos, leafPos - Offset(0, isActive ? 22 : 20), linePaint);

      // Glow if active
      if (isActive) {
        canvas.drawCircle(leafPos, 28, glowPaint);
      }

      // Node circle
      final Paint fillPaint = Paint()
        ..color = isActive
            ? const Color(0xFFE65100).withValues(alpha: 0.15)
            : _nodeColors[i].withValues(alpha: 0.1)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(leafPos, isActive ? 22 : 20, fillPaint);
      final Paint borderPaint = isActive ? (activePaint..style = PaintingStyle.stroke..strokeWidth = 2.5) : (nodePaint..style = PaintingStyle.stroke..strokeWidth = 1.5);
      canvas.drawCircle(leafPos, isActive ? 22 : 20, borderPaint);

      // Active focus arrow
      if (isActive) {
        final Paint arrowPaint = Paint()
          ..color = const Color(0xFFE65100)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(x, leafY - 50),
          Offset(x, leafY - 26),
          arrowPaint,
        );
        // Arrow head
        canvas.drawLine(Offset(x, leafY - 26), Offset(x - 5, leafY - 34), arrowPaint);
        canvas.drawLine(Offset(x, leafY - 26), Offset(x + 5, leafY - 34), arrowPaint);
      }

      // Label
      _drawLabel(canvas, 'N-${i + 1}', leafPos, isActive ? const Color(0xFFE65100) : _nodeColors[i]);

      // Bottom label
      final TextPainter namePainter = TextPainter(
        text: TextSpan(
          text: _nodeNames[i],
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive ? const Color(0xFFE65100) : Colors.grey.shade600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      namePainter.layout();
      final Rect nameBg = Rect.fromCenter(
        center: Offset(x, leafY + 32),
        width: namePainter.width + 8,
        height: namePainter.height + 4,
      );
      canvas.drawRRect(RRect.fromRectAndRadius(nameBg, const Radius.circular(4)), textBgPaint);
      namePainter.paint(canvas, Offset(x - namePainter.width / 2, leafY + 30));
    }

    // ── "primaryFocus →" label ─────────────────────────────────────────
    if (focusedNodeId != 'none') {
      final int fi = _nodeNames.indexOf(focusedNodeId);
      if (fi >= 0) {
        final double fx = spacing + fi * spacing;
        final TextPainter pf = TextPainter(
          text: const TextSpan(
            text: 'primaryFocus',
            style: TextStyle(fontSize: 9, color: Color(0xFFE65100), fontWeight: FontWeight.w600, fontFamily: 'monospace'),
          ),
          textDirection: TextDirection.ltr,
        );
        pf.layout();
        pf.paint(canvas, Offset(fx - pf.width / 2, leafY - 68));
      }
    }
  }

  void _drawLabel(Canvas canvas, String text, Offset center, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w700, height: 1.3),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    tp.layout(maxWidth: 60);
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_FocusTreePainter oldDelegate) {
    return oldDelegate.focusedNodeId != focusedNodeId;
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 6 — Actions.invoke Pattern
// ══════════════════════════════════════════════════════════════════════════════
class _InvokePatternTab extends StatelessWidget {
  const _InvokePatternTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text('Actions.invoke Pattern', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(
          'Actions.invoke() is the public entry point for dispatching intents. '
          'It walks up the widget tree to find the nearest Actions ancestor '
          'that handles the given intent type.',
          style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 20),

        // ── Actions.invoke code ───────────────────────────────────────
        Text('Using Actions.invoke', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _CodeBlock(
          title: 'Via Actions.invoke (pipeline)',
          code: '''// 1. Declare the intent with the target node
final intent = RequestFocusIntent(myFocusNode);

// 2. Invoke via the Actions pipeline
//    → Actions walks up the tree to find a handler
//    → RequestFocusAction.invoke() is called
//    → FocusNode.requestFocus() is called
Actions.invoke(context, intent);

// 3. Or with null safety check:
final Object? result = Actions.maybeInvoke(context, intent);
if (result == null) {
  // No handler found in the tree
}''',
          accentColor: const Color(0xFF1565C0),
        ),

        const SizedBox(height: 16),

        // ── Direct call code ──────────────────────────────────────────
        Text('Direct FocusNode call (bypass pipeline)', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _CodeBlock(
          title: 'Direct (no pipeline)',
          code: '''// Direct API — no Actions/Intents involved
myFocusNode.requestFocus();

// With optional FocusHighlightMode:
myFocusNode.requestFocus(/* no params */);

// Via FocusScope:
FocusScope.of(context).requestFocus(myFocusNode);''',
          accentColor: const Color(0xFF6A1B9A),
        ),

        const SizedBox(height: 16),

        // ── Comparison table ──────────────────────────────────────────
        Text('Pipeline vs Direct — Comparison', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _PropertiesTable(
          headers: const <String>['Aspect', 'Actions.invoke', 'Direct .requestFocus'],
          rows: const <List<String>>[
            ['Interception', 'Yes — any ancestor can override Action', 'No — direct call'],
            ['Testability', 'High — mock Actions in tests', 'Moderate — need node ref'],
            ['Decoupling', 'Sender has no FocusNode ref needed', 'Requires direct reference'],
            ['Shortcut wiring', 'Yes — via Shortcuts widget', 'No'],
            ['Accessibility', 'Full pipeline audit', 'Limited'],
            ['Complexity', 'More setup required', 'Simpler, fewer lines'],
            ['Typical use', 'App-level focus routing', 'Widget-local focus logic'],
          ],
        ),

        const SizedBox(height: 16),

        // ── Actions.maybeInvoke ───────────────────────────────────────
        Text('Actions.maybeInvoke — Safe Invocation', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _InfoCard(
          color: scheme.tertiaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem('Actions.invoke throws if no handler is found.'),
              _BulletItem('Actions.maybeInvoke returns null instead of throwing.'),
              _BulletItem('Use maybeInvoke when the action handler is optional.'),
              _BulletItem('Use invoke when the action must be handled (assertion failure is desired).'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── isEnabled ─────────────────────────────────────────────────
        Text('Checking if Action is Enabled', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _CodeBlock(
          title: 'isEnabled check',
          code: '''// Check before invoking to avoid throwing
final bool enabled = Actions.find<RequestFocusIntent>(context)
    ?.isEnabled(RequestFocusIntent(node)) ?? false;

if (enabled) {
  Actions.invoke(context, RequestFocusIntent(node));
}''',
          accentColor: const Color(0xFF00695C),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 7 — Conditional Focus
// ══════════════════════════════════════════════════════════════════════════════
class _ConditionalFocusTab extends StatelessWidget {
  const _ConditionalFocusTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text('Conditional Focus Action', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(
          'A custom Action subclass can check a condition before delegating '
          'to requestFocus. This allows guard logic such as form validation '
          'checks, permission gates, or feature flags.',
          style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 20),

        // ── Custom action code ─────────────────────────────────────────
        Text('Custom ConditionalFocusAction', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _CodeBlock(
          title: 'ConditionalFocusAction',
          code: '''class ConditionalFocusAction
    extends Action<RequestFocusIntent> {
  final ValueNotifier<bool> condition;

  ConditionalFocusAction({required this.condition});

  @override
  Object? invoke(RequestFocusIntent intent) {
    // Guard: only focus if condition is met
    if (condition.value) {
      intent.focusNode.requestFocus();
      return true;
    }
    // Condition not met — do nothing (or show snackbar)
    return null;
  }

  @override
  bool isEnabled(RequestFocusIntent intent) {
    // Disable the action if condition is false
    return condition.value;
  }
}''',
          accentColor: const Color(0xFFAD1457),
        ),

        const SizedBox(height: 16),

        // ── Live condition toggle ──────────────────────────────────────
        Text('Live Demo — Condition Gate', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: _conditionMet,
          builder: (BuildContext ctx, bool condMet, Widget? _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: condMet
                        ? const Color(0xFF00695C).withValues(alpha: 0.1)
                        : const Color(0xFFAD1457).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: condMet ? const Color(0xFF00695C) : const Color(0xFFAD1457),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        condMet ? Icons.check_circle : Icons.cancel,
                        color: condMet ? const Color(0xFF00695C) : const Color(0xFFAD1457),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          condMet
                              ? 'Condition: VALID — focus requests will proceed'
                              : 'Condition: INVALID — focus requests will be blocked',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: condMet ? const Color(0xFF00695C) : const Color(0xFFAD1457),
                          ),
                        ),
                      ),
                      Switch(
                        value: condMet,
                        onChanged: (bool v) => _conditionMet.value = v,
                        activeThumbColor: const Color(0xFF00695C),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Actions(
                  actions: <Type, Action<Intent>>{
                    RequestFocusIntent: _ConditionalFocusActionImpl(condition: _conditionMet),
                  },
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      for (int i = 0; i < 3; i++)
                        Builder(
                          builder: (BuildContext bCtx) {
                            final List<FocusNode> nodes = <FocusNode>[_node1, _node2, _node3];
                            return ElevatedButton.icon(
                              onPressed: () {
                                final Object? result = Actions.maybeInvoke(
                                  bCtx,
                                  RequestFocusIntent(nodes[i]),
                                );
                                if (result == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Focus blocked — condition not met'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                } else {
                                  _focusedNodeId.value = _nodeLabels[i];
                                }
                              },
                              icon: const Icon(Icons.center_focus_weak, size: 16),
                              label: Text('Focus ${_nodeLabels[i]}'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: condMet ? _nodeColors[i] : Colors.grey,
                                foregroundColor: Colors.white,
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 20),

        // ── Use cases for conditional focus ───────────────────────────
        Text('Conditional Focus Use Cases', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _InfoCard(
          color: scheme.secondaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem('Form step validation: only allow focus on the next field if the current one is valid.'),
              _BulletItem('Permission gates: block focus on premium-only fields for free-tier users.'),
              _BulletItem('Disabled states: keep UI accessible but silently reject focus on disabled sections.'),
              _BulletItem('Tutorial flows: restrict focus to guide the user through a specific path.'),
              _BulletItem('Read-only modes: prevent editing focus while document is locked.'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── isEnabled vs invoke ───────────────────────────────────────
        Text('isEnabled vs invoke Guard', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _ComparisonRow(
          leftTitle: 'Override isEnabled',
          leftLines: const <String>[
            'Returns false when blocked',
            'Buttons auto-disable via',
            'Actions.isEnabled()',
            'Best for UI-driven disabling',
          ],
          rightTitle: 'Guard inside invoke',
          rightLines: const <String>[
            'invoke() is still called',
            'Manually skip requestFocus()',
            'Can show feedback (snackbar)',
            'Best for soft blocking',
          ],
          leftColor: const Color(0xFF1565C0),
          rightColor: const Color(0xFF6A1B9A),
        ),
      ],
    );
  }
}

// ─── Concrete ConditionalFocusAction for the demo ─────────────────────────
class _ConditionalFocusActionImpl extends Action<RequestFocusIntent> {
  final ValueNotifier<bool> condition;
  _ConditionalFocusActionImpl({required this.condition});

  @override
  Object? invoke(RequestFocusIntent intent) {
    if (condition.value) {
      intent.focusNode.requestFocus();
      return true;
    }
    return null;
  }

  @override
  bool isEnabled(RequestFocusIntent intent) => condition.value;
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 8 — FocusScope.of vs FocusManager
// ══════════════════════════════════════════════════════════════════════════════
class _FocusScopeVsManagerTab extends StatelessWidget {
  const _FocusScopeVsManagerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text('FocusScope.of vs FocusManager', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(
          'Flutter provides two high-level ways to navigate focus programmatically, '
          'in addition to the Actions/Intents approach via RequestFocusAction.',
          style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 20),

        // ── FocusScope.of ─────────────────────────────────────────────
        _ApiBlock(
          title: 'FocusScope.of(context)',
          color: const Color(0xFF1565C0),
          items: const <_ApiItem>[
            _ApiItem(
              method: '.requestFocus(node)',
              description: 'Request focus on a specific node within the scope. Equivalent to node.requestFocus() but goes through the scope.',
              code: 'FocusScope.of(context).requestFocus(myNode);',
            ),
            _ApiItem(
              method: '.nextFocus()',
              description: 'Move focus to the next focusable widget in traversal order.',
              code: 'FocusScope.of(context).nextFocus();',
            ),
            _ApiItem(
              method: '.previousFocus()',
              description: 'Move focus to the previous focusable widget.',
              code: 'FocusScope.of(context).previousFocus();',
            ),
            _ApiItem(
              method: '.unfocus()',
              description: 'Remove focus from all nodes in this scope.',
              code: 'FocusScope.of(context).unfocus();',
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ── FocusManager ──────────────────────────────────────────────
        _ApiBlock(
          title: 'FocusManager.instance',
          color: const Color(0xFF6A1B9A),
          items: const <_ApiItem>[
            _ApiItem(
              method: '.primaryFocus',
              description: 'The currently focused FocusNode. Null if nothing is focused.',
              code: 'final FocusNode? f = FocusManager.instance.primaryFocus;',
            ),
            _ApiItem(
              method: '.rootScope',
              description: 'The root FocusScopeNode. Top of the entire focus tree.',
              code: 'final FocusScopeNode root = FocusManager.instance.rootScope;',
            ),
            _ApiItem(
              method: '.highlightMode',
              description: 'Current highlight mode (touch vs traditional keyboard).',
              code: 'FocusManager.instance.highlightMode;',
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ── Three-way comparison ──────────────────────────────────────
        Text('Three-Way Focus API Comparison', style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _PropertiesTable(
          headers: const <String>['Method', 'Scope', 'Interception', 'Shortcut-able'],
          rows: const <List<String>>[
            ['Actions.invoke (RequestFocusAction)', 'Widget tree', 'Yes', 'Yes'],
            ['FocusScope.of.requestFocus(node)', 'Current scope', 'No', 'No'],
            ['node.requestFocus()', 'Node directly', 'No', 'No'],
            ['FocusScope.of.nextFocus()', 'Traversal order', 'No', 'Partial'],
            ['FocusManager.primaryFocus', 'Global read', 'N/A', 'No'],
          ],
        ),

        const SizedBox(height: 16),

        // ── Pitfalls panel ────────────────────────────────────────────
        Text('Pitfalls & Common Mistakes', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xFFAD1457))),
        const SizedBox(height: 8),
        _PitfallCard(
          index: 1,
          title: 'Focusing a disposed node',
          description: 'Calling requestFocus() after dispose() will throw an assertion in debug mode and silently fail in release.',
          fix: 'Always check: if (node.context != null) node.requestFocus();',
        ),
        const SizedBox(height: 8),
        _PitfallCard(
          index: 2,
          title: 'Focusing before attach',
          description: 'A FocusNode not yet mounted via a Focus widget cannot receive focus. requestFocus() is a no-op.',
          fix: 'Use addPostFrameCallback or ensure the widget is mounted first.',
        ),
        const SizedBox(height: 8),
        _PitfallCard(
          index: 3,
          title: 'No RequestFocusAction handler in tree',
          description: 'Actions.invoke() throws if no ancestor Actions widget provides a RequestFocusAction handler.',
          fix: 'Use Actions.maybeInvoke() or wrap with Actions(actions: {RequestFocusIntent: RequestFocusAction()}).',
        ),
        const SizedBox(height: 8),
        _PitfallCard(
          index: 4,
          title: 'Calling requestFocus in build()',
          description: 'Modifying focus state during build causes layout issues and assertion failures.',
          fix: 'Use addPostFrameCallback: WidgetsBinding.instance.addPostFrameCallback((_) => node.requestFocus());',
        ),
        const SizedBox(height: 8),
        _PitfallCard(
          index: 5,
          title: 'Order of operations with Shortcuts',
          description: 'Shortcuts must wrap Actions in the tree, not the other way around, for proper key event routing.',
          fix: 'Shortcuts → Actions → child (top to bottom in the widget tree).',
        ),
      ],
    );
  }
}

// ─── Pitfall card ─────────────────────────────────────────────────────────
class _PitfallCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String fix;
  const _PitfallCard({required this.index, required this.title, required this.description, required this.fix});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFAD1457).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(color: Color(0xFFAD1457), shape: BoxShape.circle),
                child: Center(
                  child: Text('$index', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFAD1457))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.5)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.check_circle_outline, color: Color(0xFF00695C), size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Fix: $fix',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF00695C), fontFamily: 'monospace', height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  TAB 9 — API Cheat Sheet
// ══════════════════════════════════════════════════════════════════════════════
class _ApiCheatSheetTab extends StatelessWidget {
  const _ApiCheatSheetTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme txt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text('API Cheat Sheet', style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(
          'Complete reference for RequestFocusAction, RequestFocusIntent, '
          'and the most commonly used FocusNode APIs.',
          style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 20),

        // ── RequestFocusAction ─────────────────────────────────────────
        _SectionHeader(title: 'RequestFocusAction', color: const Color(0xFF1565C0)),
        const SizedBox(height: 8),
        _CodeBlock(
          title: 'class RequestFocusAction',
          code: '''class RequestFocusAction extends Action<RequestFocusIntent> {
  // Default constructor — no parameters required
  RequestFocusAction();

  // Core method: called when intent is dispatched
  @override
  Object? invoke(RequestFocusIntent intent) {
    intent.focusNode.requestFocus();
    return null;
  }

  // isEnabled defaults to true unless overridden
}''',
          accentColor: const Color(0xFF1565C0),
        ),

        const SizedBox(height: 16),

        // ── RequestFocusIntent ─────────────────────────────────────────
        _SectionHeader(title: 'RequestFocusIntent', color: const Color(0xFF6A1B9A)),
        const SizedBox(height: 8),
        _CodeBlock(
          title: 'class RequestFocusIntent',
          code: '''class RequestFocusIntent extends Intent {
  // Constructor: carries the target FocusNode
  const RequestFocusIntent(this.focusNode);

  // The FocusNode to receive focus
  final FocusNode focusNode;
}

// Usage:
final intent = RequestFocusIntent(myNode);
Actions.invoke(context, intent);''',
          accentColor: const Color(0xFF6A1B9A),
        ),

        const SizedBox(height: 16),

        // ── FocusNode API ──────────────────────────────────────────────
        _SectionHeader(title: 'FocusNode Key APIs', color: const Color(0xFF00695C)),
        const SizedBox(height: 8),
        _PropertiesTable(
          headers: const <String>['Member', 'Signature', 'Description'],
          rows: const <List<String>>[
            ['constructor', 'FocusNode({String? debugLabel, bool skipTraversal, bool canRequestFocus})', 'Creates a new focus node.'],
            ['requestFocus()', 'void requestFocus()', 'Moves focus to this node.'],
            ['unfocus()', 'void unfocus({UnfocusDisposition disposition})', 'Removes focus from this node.'],
            ['nextFocus()', 'bool nextFocus()', 'Moves focus to the next node.'],
            ['previousFocus()', 'bool previousFocus()', 'Moves focus to the previous node.'],
            ['hasFocus', 'bool get hasFocus', 'True if this or a descendant has focus.'],
            ['hasPrimaryFocus', 'bool get hasPrimaryFocus', 'True if this is the primary focus.'],
            ['canRequestFocus', 'bool get canRequestFocus', 'Whether requestFocus can succeed.'],
            ['dispose()', 'void dispose()', 'Must be called to release resources.'],
            ['addListener()', 'void addListener(VoidCallback)', 'Listen for focus changes.'],
          ],
        ),

        const SizedBox(height: 16),

        // ── Actions API ────────────────────────────────────────────────
        _SectionHeader(title: 'Actions Widget & Static API', color: const Color(0xFFAD1457)),
        const SizedBox(height: 8),
        _PropertiesTable(
          headers: const <String>['Method', 'Returns', 'Description'],
          rows: const <List<String>>[
            ['Actions.invoke(ctx, intent)', 'Object?', 'Invoke the action; throws if no handler.'],
            ['Actions.maybeInvoke(ctx, intent)', 'Object?', 'Invoke; returns null if no handler.'],
            ['Actions.find<I>(ctx)', 'Action<I>?', 'Find handler action for intent type.'],
            ['Actions.isEnabled(ctx, intent)', 'bool', 'Check if action is enabled.'],
            ['Actions.handler<I>(ctx, intent)', 'Action<I>?', 'Get handler; null if not found.'],
          ],
        ),

        const SizedBox(height: 16),

        // ── Quick comparison ───────────────────────────────────────────
        _SectionHeader(title: 'RequestFocusAction vs Alternatives', color: const Color(0xFFE65100)),
        const SizedBox(height: 8),
        _PropertiesTable(
          headers: const <String>['API', 'Interception', 'Shortcuts', 'Traversal-aware'],
          rows: const <List<String>>[
            ['RequestFocusAction (via Actions)', 'Yes', 'Yes', 'No (direct node)'],
            ['FocusNode.requestFocus()', 'No', 'No', 'No'],
            ['FocusScope.of.nextFocus()', 'No', 'Partial', 'Yes'],
            ['FocusTraversalGroup', 'No', 'No', 'Yes (group scope)'],
          ],
        ),

        const SizedBox(height: 16),

        // ── Complete minimal example ───────────────────────────────────
        _SectionHeader(title: 'Complete Minimal Example', color: const Color(0xFF00695C)),
        const SizedBox(height: 8),
        _CodeBlock(
          title: 'Minimal RequestFocusAction wiring',
          code: '''class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late final FocusNode _nameNode;
  late final FocusNode _emailNode;

  @override
  void initState() {
    super.initState();
    _nameNode = FocusNode(debugLabel: 'Name');
    _emailNode = FocusNode(debugLabel: 'Email');
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.tab):
            RequestFocusIntent(_emailNode),
      },
      child: Actions(
        actions: {
          RequestFocusIntent: RequestFocusAction(),
        },
        child: Column(
          children: [
            Focus(focusNode: _nameNode, child: TextField()),
            Focus(focusNode: _emailNode, child: TextField()),
            ElevatedButton(
              onPressed: () => Actions.invoke(
                context,
                RequestFocusIntent(_emailNode),
              ),
              child: Text('Focus Email'),
            ),
          ],
        ),
      ),
    );
  }
}''',
          accentColor: const Color(0xFF00695C),
        ),

        const SizedBox(height: 24),

        // ── Footer ────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: <Widget>[
              Icon(Icons.center_focus_strong, color: scheme.primary, size: 32),
              const SizedBox(height: 8),
              Text(
                'RequestFocusAction Deep Demo',
                style: txt.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Part of the Tom D4rt Flutter Interpreter test suite.\n'
                'Demonstrates Actions/Intents focus pipeline — 9 tabs, stateless, M3.',
                style: txt.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  Shared helper widgets
// ══════════════════════════════════════════════════════════════════════════════

// ─── Info card ───────────────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final Color color;
  final Widget child;
  const _InfoCard({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: child,
    );
  }
}

// ─── Bullet item ──────────────────────────────────────────────────────────────
class _BulletItem extends StatelessWidget {
  final String text;
  const _BulletItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: SizedBox(
              width: 6,
              height: 6,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFF424242), shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, height: 1.5)),
          ),
        ],
      ),
    );
  }
}

// ─── Chip ─────────────────────────────────────────────────────────────────────
class _Chip extends StatelessWidget {
  final String label;
  const _Chip(this.label);

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: scheme.onPrimaryContainer, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// ─── Monospace text ───────────────────────────────────────────────────────────
class _MonoText extends StatelessWidget {
  final String text;
  const _MonoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.6, color: Color(0xFF1A1A2E)),
    );
  }
}

// ─── Fact row ─────────────────────────────────────────────────────────────────
class _FactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _FactRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: scheme.primary),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFF1A1A2E)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Comparison row ───────────────────────────────────────────────────────────
class _ComparisonRow extends StatelessWidget {
  final String leftTitle;
  final List<String> leftLines;
  final String rightTitle;
  final List<String> rightLines;
  final Color leftColor;
  final Color rightColor;
  const _ComparisonRow({
    required this.leftTitle,
    required this.leftLines,
    required this.rightTitle,
    required this.rightLines,
    required this.leftColor,
    required this.rightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _ComparisonCard(title: leftTitle, lines: leftLines, color: leftColor)),
        const SizedBox(width: 8),
        Expanded(child: _ComparisonCard(title: rightTitle, lines: rightLines, color: rightColor)),
      ],
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final String title;
  final List<String> lines;
  final Color color;
  const _ComparisonCard({required this.title, required this.lines, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 12)),
          const SizedBox(height: 6),
          for (final String line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line, style: const TextStyle(fontSize: 11, height: 1.4)),
            ),
        ],
      ),
    );
  }
}

// ─── Code block ──────────────────────────────────────────────────────────────
class _CodeBlock extends StatelessWidget {
  final String title;
  final String code;
  final Color accentColor;
  const _CodeBlock({required this.title, required this.code, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.code, size: 14, color: accentColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: accentColor)),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A2E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(11),
                bottomRight: Radius.circular(11),
              ),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFE0E0E0),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Properties table ─────────────────────────────────────────────────────────
class _PropertiesTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  const _PropertiesTable({required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Row(
              children: headers
                  .map((String h) => Expanded(
                        child: Text(h, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: scheme.onPrimaryContainer)),
                      ))
                  .toList(),
            ),
          ),
          // Data rows
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: i.isOdd ? scheme.surfaceContainerLowest : Colors.white,
                border: Border(top: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5))),
                borderRadius: i == rows.length - 1
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(9),
                        bottomRight: Radius.circular(9),
                      )
                    : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rows[i]
                    .map((String cell) => Expanded(
                          child: Text(
                            cell,
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: rows[i].indexOf(cell) == 0 ? 'monospace' : null,
                              height: 1.4,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Section header ───────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(width: 4, height: 20, color: color, margin: const EdgeInsets.only(right: 10)),
        Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }
}

// ─── Legend item ──────────────────────────────────────────────────────────────
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ─── Api block ────────────────────────────────────────────────────────────────
class _ApiBlock extends StatelessWidget {
  final String title;
  final Color color;
  final List<_ApiItem> items;
  const _ApiBlock({required this.title, required this.color, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
            ),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 14)),
          ),
          for (int i = 0; i < items.length; i++)
            _ApiItemWidget(item: items[i], color: color, isLast: i == items.length - 1),
        ],
      ),
    );
  }
}

class _ApiItem {
  final String method;
  final String description;
  final String code;
  const _ApiItem({required this.method, required this.description, required this.code});
}

class _ApiItemWidget extends StatelessWidget {
  final _ApiItem item;
  final Color color;
  final bool isLast;
  const _ApiItemWidget({required this.item, required this.color, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: color.withValues(alpha: 0.2)),
          bottom: isLast ? BorderSide.none : BorderSide.none,
        ),
        borderRadius: isLast
            ? const BorderRadius.only(bottomLeft: Radius.circular(11), bottomRight: Radius.circular(11))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.method, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600, fontSize: 12, color: color)),
          const SizedBox(height: 4),
          Text(item.description, style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.4)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item.code,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFE0E0E0), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
