import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (stateless-safe global state)
// ---------------------------------------------------------------------------

final ValueNotifier<int> _currentFocus = ValueNotifier<int>(-1);
final ValueNotifier<bool> _node1Focused = ValueNotifier<bool>(false);
final ValueNotifier<bool> _node2Focused = ValueNotifier<bool>(false);
final ValueNotifier<bool> _node3Focused = ValueNotifier<bool>(false);
final ValueNotifier<bool> _node4Focused = ValueNotifier<bool>(false);
final ValueNotifier<List<String>> _eventLog = ValueNotifier<List<String>>([]);

final FocusNode _focusNode1 = FocusNode(debugLabel: 'Node-1');
final FocusNode _focusNode2 = FocusNode(debugLabel: 'Node-2');
final FocusNode _focusNode3 = FocusNode(debugLabel: 'Node-3');
final FocusNode _focusNode4 = FocusNode(debugLabel: 'Node-4');

final FocusNode _shortcutNode1 = FocusNode(debugLabel: 'Shortcut-F1');
final FocusNode _shortcutNode2 = FocusNode(debugLabel: 'Shortcut-F2');
final FocusNode _shortcutNode3 = FocusNode(debugLabel: 'Shortcut-F3');

void _addEvent(String msg) {
  final now = DateTime.now();
  final ts =
      '${now.hour.toString().padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}:'
      '${now.second.toString().padLeft(2, '0')}';
  final updated = List<String>.from(_eventLog.value)..insert(0, '[$ts] $msg');
  if (updated.length > 20) updated.removeLast();
  _eventLog.value = updated;
}

void _requestFocus(int index, FocusNode node, BuildContext context) {
  Actions.invoke(context, RequestFocusIntent(node));
  _currentFocus.value = index;
  _addEvent('RequestFocusIntent dispatched → Node-$index');
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  _focusNode1.addListener(() {
    _node1Focused.value = _focusNode1.hasFocus;
    if (_focusNode1.hasFocus) _addEvent('Node-1 gained focus (listener)');
  });
  _focusNode2.addListener(() {
    _node2Focused.value = _focusNode2.hasFocus;
    if (_focusNode2.hasFocus) _addEvent('Node-2 gained focus (listener)');
  });
  _focusNode3.addListener(() {
    _node3Focused.value = _focusNode3.hasFocus;
    if (_focusNode3.hasFocus) _addEvent('Node-3 gained focus (listener)');
  });
  _focusNode4.addListener(() {
    _node4Focused.value = _focusNode4.hasFocus;
    if (_focusNode4.hasFocus) _addEvent('Node-4 gained focus (listener)');
  });

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RequestFocusIntent — Deep Visual Demo'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: 'Hero'),
              Tab(text: 'Focus Graph'),
              Tab(text: 'Construction'),
              Tab(text: 'Invoke Path'),
              Tab(text: 'Shortcuts'),
              Tab(text: 'Default Action'),
              Tab(text: 'Comparison'),
              Tab(text: 'Listener'),
              Tab(text: 'Pitfalls & API'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _LiveFocusGraphTab(),
            _ConstructionTab(),
            _InvokePathTab(),
            _ShortcutBindingTab(),
            _DefaultActionWiringTab(),
            _ComparisonTab(),
            _FocusListenerTab(),
            _PitfallsAndApiTab(),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: cs.onPrimaryContainer,
        ),
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outline.withValues(alpha: 0.3)),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          height: 1.55,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text(body, style: const TextStyle(fontSize: 13, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1 — Hero Banner
// ---------------------------------------------------------------------------

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[cs.primaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: <Widget>[
                Icon(Icons.center_focus_strong, size: 64, color: cs.primary),
                const SizedBox(height: 12),
                Text(
                  'RequestFocusIntent',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: cs.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A data carrier for programmatic focus requests\nthrough the Actions/Intents pipeline',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: cs.onSecondaryContainer,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionHeader('What is RequestFocusIntent?'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Intent as a Data Carrier',
            body:
                'RequestFocusIntent extends Intent and carries a single piece '
                'of data: a FocusNode. It does NOT perform any action itself — '
                'instead it acts as a typed container that is dispatched through '
                'the Actions system. The paired RequestFocusAction reads the '
                'focusNode from the intent and calls node.requestFocus().',
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Why use an Intent instead of calling requestFocus() directly?',
            body:
                'Dispatching through Actions.invoke() keeps focus logic '
                'decoupled from widgets. Any ancestor can intercept or override '
                'the action, add side-effects, or conditionally block focus '
                'changes. Keyboard shortcuts can also trigger the same intent '
                'without referencing widgets directly.',
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'The Actions/Intents Pipeline',
            body:
                'Flutter ships a bi-directional pipeline:\n'
                '  Intent  — immutable data describing what should happen\n'
                '  Action  — handler that knows how to respond to an intent\n'
                '  Actions — widget that registers action handlers\n'
                '  Shortcuts — widget that maps key events to intents\n\n'
                'RequestFocusIntent slots into this pipeline at the Intent level.',
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Class Hierarchy',
            body:
                'Object\n'
                '  └─ Intent\n'
                '       └─ RequestFocusIntent\n\n'
                'RequestFocusAction extends Action<RequestFocusIntent>',
          ),
          const SizedBox(height: 12),
          _CodeBox(
            'class RequestFocusIntent extends Intent {\n'
            '  /// Creates an intent that requests focus on [focusNode].\n'
            '  const RequestFocusIntent(this.focusNode);\n\n'
            '  /// The [FocusNode] to be focused.\n'
            '  final FocusNode focusNode;\n'
            '}',
          ),
          const SizedBox(height: 24),
          const _SectionHeader('Key Properties at a Glance'),
          const SizedBox(height: 12),
          Table(
            border: TableBorder.all(
              color: cs.outline.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            children: const <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: Color(0x11000000)),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Member',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('focusNode'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('FocusNode'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('The node to receive focus.'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — Live Focus Graph
// ---------------------------------------------------------------------------

class _LiveFocusGraphTab extends StatelessWidget {
  const _LiveFocusGraphTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Live Focus Graph — 2×2 Node Grid'),
          const SizedBox(height: 8),
          Text(
            'Tap a "Request Focus" button to dispatch RequestFocusIntent '
            'for that node. The focused node glows with an indigo border.',
            style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          // 2x2 grid of focusable nodes
          Row(
            children: <Widget>[
              Expanded(
                child: _FocusNodeCard(
                  index: 1,
                  node: _focusNode1,
                  focused: _node1Focused,
                  onRequest: (ctx) => _requestFocus(1, _focusNode1, ctx),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FocusNodeCard(
                  index: 2,
                  node: _focusNode2,
                  focused: _node2Focused,
                  onRequest: (ctx) => _requestFocus(2, _focusNode2, ctx),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _FocusNodeCard(
                  index: 3,
                  node: _focusNode3,
                  focused: _node3Focused,
                  onRequest: (ctx) => _requestFocus(3, _focusNode3, ctx),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FocusNodeCard(
                  index: 4,
                  node: _focusNode4,
                  focused: _node4Focused,
                  onRequest: (ctx) => _requestFocus(4, _focusNode4, ctx),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Current Focus Indicator'),
          const SizedBox(height: 12),
          ValueListenableBuilder<int>(
            valueListenable: _currentFocus,
            builder: (context, idx, _) {
              final label = idx == -1 ? 'None' : 'Node-$idx';
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: idx == -1
                      ? cs.surfaceContainerHighest
                      : cs.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: idx == -1 ? cs.outline : cs.primary,
                    width: idx == -1 ? 1 : 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      idx == -1
                          ? Icons.radio_button_unchecked
                          : Icons.center_focus_strong,
                      color: idx == -1 ? cs.outline : cs.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Focus owner: $label',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: idx == -1 ? cs.onSurfaceVariant : cs.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Event Log'),
          const SizedBox(height: 8),
          ValueListenableBuilder<List<String>>(
            valueListenable: _eventLog,
            builder: (context, events, _) {
              if (events.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'No events yet — tap a node button above.',
                    style: TextStyle(
                      color: cs.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
              return Container(
                constraints: const BoxConstraints(maxHeight: 220),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: events.length,
                  itemBuilder: (context, i) => Text(
                    events[i],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FocusNodeCard extends StatelessWidget {
  const _FocusNodeCard({
    required this.index,
    required this.node,
    required this.focused,
    required this.onRequest,
  });

  final int index;
  final FocusNode node;
  final ValueNotifier<bool> focused;
  final void Function(BuildContext) onRequest;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<bool>(
      valueListenable: focused,
      builder: (ctx, isFocused, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isFocused ? cs.primaryContainer : cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFocused ? cs.primary : cs.outline,
              width: isFocused ? 2.5 : 1,
            ),
            boxShadow: isFocused
                ? <BoxShadow>[
                    BoxShadow(
                      color: cs.primary.withValues(alpha: 0.35),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: <Widget>[
              Icon(
                isFocused
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isFocused ? cs.primary : cs.outline,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                'Node-$index',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isFocused ? cs.primary : cs.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isFocused ? 'FOCUSED' : 'unfocused',
                style: TextStyle(
                  fontSize: 11,
                  color: isFocused ? cs.primary : cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 10),
              Focus(
                focusNode: node,
                child: ElevatedButton(
                  onPressed: () => onRequest(ctx),
                  child: Text('Request Focus $index'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3 — Construction
// ---------------------------------------------------------------------------

class _ConstructionTab extends StatelessWidget {
  const _ConstructionTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Constructing a RequestFocusIntent'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Constructor signature',
            body:
                'const RequestFocusIntent(FocusNode focusNode)\n\n'
                'Takes exactly one positional argument: the FocusNode that '
                'should receive focus when the intent is handled. The intent '
                'is immutable — the node reference is stored but never mutated.',
          ),
          const SizedBox(height: 16),
          const _SectionHeader('Monospace Reference'),
          const SizedBox(height: 12),
          _CodeBox(
            '// 1. Create or obtain a FocusNode\n'
            'final FocusNode myNode = FocusNode(debugLabel: \'email-field\');\n\n'
            '// 2. Construct the intent\n'
            'final intent = RequestFocusIntent(myNode);\n\n'
            '// 3. Access the carried node via the getter\n'
            'assert(intent.focusNode == myNode);\n\n'
            '// 4. Dispatch it — RequestFocusAction.invoke() does the work\n'
            'Actions.invoke(context, RequestFocusIntent(myNode));',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('The focusNode Getter'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'FocusNode get focusNode',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: cs.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Returns the FocusNode this intent wants to focus. '
                  'RequestFocusAction reads this property and calls '
                  'focusNode.requestFocus() inside its invoke() method. '
                  'The getter is read-only — intents are data objects, '
                  'not controllers.',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onTertiaryContainer,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Immutability Pattern'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Why intents are immutable',
            body:
                'Intent subclasses are conventionally immutable so they can '
                'be safely passed through the widget tree without defensive '
                'copying. RequestFocusIntent stores the FocusNode as a final '
                'field — the node itself is mutable (focus state changes), '
                'but the intent\'s reference to it is not.\n\n'
                'This also allows pre-built intent objects to be stored as '
                'constants (if the node is available at compile time) or '
                'created lazily per-dispatch call.',
          ),
          const SizedBox(height: 12),
          _CodeBox(
            '// Pattern A: pre-built\n'
            'final intent = RequestFocusIntent(emailNode);\n'
            'Actions.invoke(context, intent); // reusable\n\n'
            '// Pattern B: inline (most common)\n'
            'Actions.invoke(context, RequestFocusIntent(emailNode));\n\n'
            '// Pattern C: inside Shortcuts map\n'
            '<ShortcutActivator, Intent>{\n'
            '  LogicalKeyboardKey.f1: RequestFocusIntent(nameNode),\n'
            '  LogicalKeyboardKey.f2: RequestFocusIntent(emailNode),\n'
            '}',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Relationship to Intent Base Class'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Intent base class',
            body:
                'Intent is a simple marker base class. It adds no fields or '
                'methods — it exists to provide a type hierarchy for the '
                'Actions system to dispatch on. RequestFocusIntent carries '
                'data (focusNode) that its matched action (RequestFocusAction) '
                'needs. This is the standard Flutter pattern: Intent = data, '
                'Action = behavior.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 4 — Actions.invoke Pathway
// ---------------------------------------------------------------------------

class _InvokePathTab extends StatelessWidget {
  const _InvokePathTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Actions.invoke Pathway Diagram'),
          const SizedBox(height: 16),
          _DiagramStep(
            step: '1',
            label: 'Widget calls Actions.invoke()',
            detail:
                'Actions.invoke(context, RequestFocusIntent(myNode));\n'
                'This is the entry point. context provides the lookup scope.',
            color: cs.primaryContainer,
          ),
          _Arrow(),
          _DiagramStep(
            step: '2',
            label: 'Actions widget tree lookup',
            detail:
                'Flutter walks up the element tree from context, looking for '
                'an Actions widget that has a registered handler for '
                'RequestFocusIntent. MaterialApp provides one at the root.',
            color: cs.secondaryContainer,
          ),
          _Arrow(),
          _DiagramStep(
            step: '3',
            label: 'RequestFocusAction.isEnabled()',
            detail:
                'The matched action is asked if it is enabled. By default '
                'RequestFocusAction always returns true. If disabled, invoke '
                'is skipped and null is returned.',
            color: cs.tertiaryContainer,
          ),
          _Arrow(),
          _DiagramStep(
            step: '4',
            label: 'RequestFocusAction.invoke(intent)',
            detail:
                'The action receives the intent object. It reads\n'
                'intent.focusNode and calls focusNode.requestFocus().',
            color: cs.primaryContainer,
          ),
          _Arrow(),
          _DiagramStep(
            step: '5',
            label: 'FocusNode.requestFocus()',
            detail:
                'The FocusNode asks the FocusManager to give it focus. '
                'This triggers hasFocus change and notifies all listeners '
                'registered on the node.',
            color: cs.secondaryContainer,
          ),
          _Arrow(),
          _DiagramStep(
            step: '6',
            label: 'Focus listeners fire',
            detail:
                'Any addListener callbacks on the node are invoked, and '
                'dependent ValueNotifiers or setState calls update the UI '
                'to reflect the new focus owner.',
            color: cs.tertiaryContainer,
          ),
          const SizedBox(height: 24),
          const _SectionHeader('Code Walkthrough'),
          const SizedBox(height: 12),
          _CodeBox(
            '// What Actions.invoke does internally (simplified):\n'
            'Object? invoke(BuildContext context, Intent intent) {\n'
            '  // Walk up the tree to find a matching Actions widget\n'
            '  final Action<Intent>? action =\n'
            '    Actions.find<RequestFocusIntent>(context);\n\n'
            '  if (action == null || !action.isEnabled(intent)) return null;\n\n'
            '  // Delegate to the matched action\n'
            '  return action.invoke(intent);\n'
            '}\n\n'
            '// RequestFocusAction.invoke (Flutter source):\n'
            'Object? invoke(RequestFocusIntent intent) {\n'
            '  intent.focusNode.requestFocus();\n'
            '  return null;\n'
            '}',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('maybeInvoke vs invoke'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Choosing the right call site',
            body:
                'Actions.invoke()       — throws if no handler found\n'
                'Actions.maybeInvoke() — returns null if no handler found\n\n'
                'For focus requests in a MaterialApp tree, invoke() is safe '
                'because MaterialApp pre-registers RequestFocusAction. '
                'Use maybeInvoke() when targeting custom trees without '
                'guaranteed action registration.',
          ),
        ],
      ),
    );
  }
}

class _DiagramStep extends StatelessWidget {
  const _DiagramStep({
    required this.step,
    required this.label,
    required this.detail,
    required this.color,
  });
  final String step;
  final String label;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outline.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 16,
            backgroundColor: cs.primary,
            child: Text(
              step,
              style: TextStyle(
                color: cs.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.5,
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

class _Arrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Icon(Icons.arrow_downward, color: cs.primary, size: 24),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5 — Shortcut Binding
// ---------------------------------------------------------------------------

class _ShortcutBindingTab extends StatelessWidget {
  const _ShortcutBindingTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Shortcut Binding — F1 / F2 / F3'),
          const SizedBox(height: 8),
          Text(
            'Three cards are wrapped in a Shortcuts widget mapping '
            'F1, F2, and F3 to RequestFocusIntent for each card\'s node. '
            'Press the key (or tap the card button) to dispatch the intent.',
            style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              const SingleActivator(LogicalKeyboardKey.f1):
                  RequestFocusIntent(_shortcutNode1),
              const SingleActivator(LogicalKeyboardKey.f2):
                  RequestFocusIntent(_shortcutNode2),
              const SingleActivator(LogicalKeyboardKey.f3):
                  RequestFocusIntent(_shortcutNode3),
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _ShortcutCard(
                    keyLabel: 'F1',
                    label: 'Card A',
                    node: _shortcutNode1,
                    onTap: (ctx) {
                      Actions.invoke(ctx, RequestFocusIntent(_shortcutNode1));
                      _addEvent('F1 → RequestFocusIntent(shortcutNode1)');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ShortcutCard(
                    keyLabel: 'F2',
                    label: 'Card B',
                    node: _shortcutNode2,
                    onTap: (ctx) {
                      Actions.invoke(ctx, RequestFocusIntent(_shortcutNode2));
                      _addEvent('F2 → RequestFocusIntent(shortcutNode2)');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ShortcutCard(
                    keyLabel: 'F3',
                    label: 'Card C',
                    node: _shortcutNode3,
                    onTap: (ctx) {
                      Actions.invoke(ctx, RequestFocusIntent(_shortcutNode3));
                      _addEvent('F3 → RequestFocusIntent(shortcutNode3)');
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionHeader('How Shortcuts wires to RequestFocusIntent'),
          const SizedBox(height: 12),
          _CodeBox(
            'Shortcuts(\n'
            '  shortcuts: <ShortcutActivator, Intent>{\n'
            '    SingleActivator(LogicalKeyboardKey.f1):\n'
            '        RequestFocusIntent(nameNode),\n'
            '    SingleActivator(LogicalKeyboardKey.f2):\n'
            '        RequestFocusIntent(emailNode),\n'
            '    SingleActivator(LogicalKeyboardKey.f3):\n'
            '        RequestFocusIntent(phoneNode),\n'
            '  },\n'
            '  child: /* your subtree here */,\n'
            ')',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            title: 'How it works',
            body:
                'When the keyboard event fires, Shortcuts matches it against '
                'the activator map and produces the mapped Intent. That intent '
                'is then dispatched via Actions.invoke() up the tree — exactly '
                'as if you had called it manually. No extra wiring needed for '
                'focus; MaterialApp already registers RequestFocusAction.',
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'SingleActivator vs CharacterActivator',
            body:
                'SingleActivator(LogicalKeyboardKey.f1) matches F1 with no '
                'modifiers by default. Add shift/control/alt/meta for combos.\n\n'
                'CharacterActivator is for printable characters (e.g. \'?\') '
                'and is NOT suitable for function keys.',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Shortcut Lookup Order'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _LookupRow(index: 1, text: 'Innermost Shortcuts widget'),
                _LookupRow(index: 2, text: 'Next ancestor Shortcuts widget'),
                _LookupRow(index: 3, text: '... continues up the tree ...'),
                _LookupRow(
                  index: 4,
                  text: 'WidgetsApp / MaterialApp root Shortcuts',
                ),
                const SizedBox(height: 8),
                Text(
                  'First match wins. Outer shortcuts cannot override inner ones '
                  'for the same key.',
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
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

class _ShortcutCard extends StatelessWidget {
  const _ShortcutCard({
    required this.keyLabel,
    required this.label,
    required this.node,
    required this.onTap,
  });

  final String keyLabel;
  final String label;
  final FocusNode node;
  final void Function(BuildContext) onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                keyLabel,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Focus(
              focusNode: node,
              child: ElevatedButton(
                onPressed: () => onTap(context),
                child: const Text('Focus'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LookupRow extends StatelessWidget {
  const _LookupRow({required this.index, required this.text});
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 12,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6 — Default Action Wiring
// ---------------------------------------------------------------------------

class _DefaultActionWiringTab extends StatelessWidget {
  const _DefaultActionWiringTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Default Action Wiring in MaterialApp'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Where RequestFocusAction comes from',
            body:
                'MaterialApp → WidgetsApp → Actions widget (near the root).\n\n'
                'WidgetsApp registers a default set of action handlers, '
                'including RequestFocusAction. This means you do NOT need to '
                'add your own Actions widget just to handle '
                'RequestFocusIntent — it works out of the box in any '
                'MaterialApp or CupertinoApp tree.',
          ),
          const SizedBox(height: 16),
          const _SectionHeader('Simplified Widget Tree'),
          const SizedBox(height: 12),
          _TreeDiagram(
            nodes: const <_TreeNode>[
              _TreeNode(
                depth: 0,
                label: 'MaterialApp',
                note: 'your app root',
              ),
              _TreeNode(
                depth: 1,
                label: 'WidgetsApp',
                note: 'internal wrapping widget',
              ),
              _TreeNode(
                depth: 2,
                label: 'Actions',
                note: 'registers RequestFocusAction here',
                highlight: true,
              ),
              _TreeNode(
                depth: 3,
                label: 'Shortcuts',
                note: 'default key bindings',
              ),
              _TreeNode(depth: 4, label: 'Navigator', note: 'route management'),
              _TreeNode(
                depth: 5,
                label: 'Your Scaffold / Page',
                note: 'your widgets',
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Source Reference (Flutter SDK)'),
          const SizedBox(height: 12),
          _CodeBox(
            '// In WidgetsApp._buildWidgetApp() (simplified):\n'
            'Actions(\n'
            '  actions: <Type, Action<Intent>>{\n'
            '    // ... other defaults ...\n'
            '    RequestFocusIntent: RequestFocusAction(),\n'
            '    NextFocusIntent:    NextFocusAction(),\n'
            '    PreviousFocusIntent: PreviousFocusAction(),\n'
            '    // ... more ...\n'
            '  },\n'
            '  child: /* rest of the app */,\n'
            ')',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Overriding the Default Action'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Custom RequestFocusAction',
            body:
                'You can override the default action in any subtree by '
                'wrapping it in an Actions widget with your own handler. '
                'The inner Actions shadows the outer one for that intent type.',
          ),
          const SizedBox(height: 12),
          _CodeBox(
            'class LoggingFocusAction extends Action<RequestFocusIntent> {\n'
            '  @override\n'
            '  Object? invoke(RequestFocusIntent intent) {\n'
            '    debugPrint(\'Focusing: \${intent.focusNode.debugLabel}\');\n'
            '    intent.focusNode.requestFocus();\n'
            '    return null;\n'
            '  }\n'
            '}\n\n'
            '// In your widget tree:\n'
            'Actions(\n'
            '  actions: <Type, Action<Intent>>{\n'
            '    RequestFocusIntent: LoggingFocusAction(),\n'
            '  },\n'
            '  child: mySubtree,\n'
            ')',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Non-MaterialApp Trees'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'What if you are not using MaterialApp?',
            body:
                'In a bare Dart widget test or a custom app root that does not '
                'use WidgetsApp, no default action is registered. You must add '
                'your own Actions ancestor. See also Tab 9 (Pitfalls).',
          ),
        ],
      ),
    );
  }
}

class _TreeNode {
  const _TreeNode({
    required this.depth,
    required this.label,
    required this.note,
    this.highlight = false,
  });
  final int depth;
  final String label;
  final String note;
  final bool highlight;
}

class _TreeDiagram extends StatelessWidget {
  const _TreeDiagram({required this.nodes});
  final List<_TreeNode> nodes;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: nodes.map((n) {
          return Padding(
            padding: EdgeInsets.only(
              left: n.depth * 18.0,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: <Widget>[
                if (n.depth > 0) ...<Widget>[
                  Text(
                    '└─ ',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: cs.outline,
                    ),
                  ),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: n.highlight ? cs.primaryContainer : cs.surface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: n.highlight ? cs.primary : cs.outline,
                      width: n.highlight ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    n.label,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: n.highlight
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: n.highlight ? cs.primary : cs.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '// ${n.note}',
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 7 — Comparison with NextFocusIntent
// ---------------------------------------------------------------------------

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('RequestFocusIntent vs NextFocusIntent'),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(
              color: cs.outline.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.4),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: cs.primaryContainer),
                children: <Widget>[
                  const _TCell('Aspect', bold: true),
                  _TCell('RequestFocusIntent', bold: true),
                  _TCell('NextFocusIntent', bold: true),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Focus target'),
                  _TCell('Specific FocusNode (explicit)'),
                  _TCell('Next in traversal order (implicit)'),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Data carried'),
                  _TCell('FocusNode reference'),
                  _TCell('None (stateless)'),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Use case'),
                  _TCell('Jump to known field or widget'),
                  _TCell('Tab-like sequential navigation'),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Node required?'),
                  _TCell('Yes — you must own the node'),
                  _TCell('No — uses FocusTraversalPolicy'),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Default action'),
                  _TCell('RequestFocusAction'),
                  _TCell('NextFocusAction'),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Default shortcut'),
                  _TCell('None built-in'),
                  _TCell('Tab key (in WidgetsApp)'),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Bypasses traversal?'),
                  _TCell('Yes — goes directly to node'),
                  _TCell('No — follows policy order'),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  _TCell('Composable w/ Shortcuts?'),
                  _TCell('Yes (F1→node1, F2→node2 …)'),
                  _TCell('Yes (Tab is pre-wired)'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionHeader('Other Related Intents'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'PreviousFocusIntent',
            body:
                'Moves focus to the previous node in traversal order. '
                'Pre-wired to Shift+Tab. Like NextFocusIntent — no node '
                'data needed.',
          ),
          const SizedBox(height: 8),
          const _InfoCard(
            title: 'DirectionalFocusIntent',
            body:
                'Moves focus in a spatial direction (up/down/left/right). '
                'Carries a TraversalDirection. Useful for grid or D-pad '
                'navigation. Also pre-registered in WidgetsApp.',
          ),
          const SizedBox(height: 8),
          const _InfoCard(
            title: 'When to choose RequestFocusIntent',
            body:
                '• You know exactly which field/widget should receive focus.\n'
                '• You want keyboard shortcuts to jump to specific form fields.\n'
                '• You are building a wizard/stepper and need to advance to\n'
                '  a named node after a validation step.\n'
                '• You want focus behavior decoupled from the widget hierarchy.',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Side-by-side code'),
          const SizedBox(height: 12),
          _CodeBox(
            '// RequestFocusIntent — go to a specific node\n'
            'Actions.invoke(\n'
            '  context,\n'
            '  RequestFocusIntent(emailFocusNode),\n'
            ');\n\n'
            '// NextFocusIntent — go to whatever is "next"\n'
            'Actions.invoke(\n'
            '  context,\n'
            '  const NextFocusIntent(),\n'
            ');\n\n'
            '// PreviousFocusIntent — go to whatever is "previous"\n'
            'Actions.invoke(\n'
            '  context,\n'
            '  const PreviousFocusIntent(),\n'
            ');',
          ),
        ],
      ),
    );
  }
}

class _TCell extends StatelessWidget {
  const _TCell(this.text, {this.bold = false});
  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 8 — Focus Change Listener
// ---------------------------------------------------------------------------

class _FocusListenerTab extends StatelessWidget {
  const _FocusListenerTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('FocusNode.addListener Pattern'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'How focus change listeners work',
            body:
                'FocusNode extends ChangeNotifier. Every time the node\'s '
                'focus state changes (gains or loses focus), all registered '
                'listeners are called. You can check node.hasFocus inside '
                'the listener to determine the new state.\n\n'
                'This is how this demo updates ValueNotifier<bool> per node '
                'to drive the glowing card UI.',
          ),
          const SizedBox(height: 16),
          _CodeBox(
            'final ValueNotifier<bool> isFocused = ValueNotifier<bool>(false);\n'
            'final FocusNode node = FocusNode();\n\n'
            '// Register listener (e.g. in initState or top-level setup)\n'
            'node.addListener(() {\n'
            '  isFocused.value = node.hasFocus;\n'
            '});\n\n'
            '// Drive UI reactively\n'
            'ValueListenableBuilder<bool>(\n'
            '  valueListenable: isFocused,\n'
            '  builder: (context, focused, child) {\n'
            '    return AnimatedContainer(\n'
            '      duration: Duration(milliseconds: 200),\n'
            '      decoration: BoxDecoration(\n'
            '        border: Border.all(\n'
            '          color: focused ? Colors.indigo : Colors.grey,\n'
            '          width: focused ? 3 : 1,\n'
            '        ),\n'
            '      ),\n'
            '      child: child,\n'
            '    );\n'
            '  },\n'
            '  child: const TextField(),\n'
            ')',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Live Listener State Board'),
          const SizedBox(height: 12),
          Text(
            'Each card below shows the real-time focus state of a node, '
            'driven by ValueNotifier<bool> updated in addListener callbacks '
            'set up at build time.',
            style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          _ListenerStateCard(index: 1, focused: _node1Focused),
          const SizedBox(height: 8),
          _ListenerStateCard(index: 2, focused: _node2Focused),
          const SizedBox(height: 8),
          _ListenerStateCard(index: 3, focused: _node3Focused),
          const SizedBox(height: 8),
          _ListenerStateCard(index: 4, focused: _node4Focused),
          const SizedBox(height: 20),
          const _SectionHeader('Listener Lifecycle Rules'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Rules for safe listener management',
            body:
                '1. Add listeners AFTER node creation, before attach.\n'
                '2. Remove listeners with node.removeListener(cb) when done.\n'
                '3. In StatefulWidget use initState to add, dispose to remove.\n'
                '4. Do NOT add a listener inside build() — it re-registers '
                'on every rebuild causing duplicates.\n'
                '5. After node.dispose(), no listeners will fire — check '
                'node.isNotDisposed if accessing from async code.',
          ),
          const SizedBox(height: 12),
          _CodeBox(
            '// StatefulWidget safe pattern:\n'
            '@override\n'
            'void initState() {\n'
            '  super.initState();\n'
            '  _node.addListener(_onFocusChange);\n'
            '}\n\n'
            'void _onFocusChange() {\n'
            '  setState(() { _isFocused = _node.hasFocus; });\n'
            '}\n\n'
            '@override\n'
            'void dispose() {\n'
            '  _node.removeListener(_onFocusChange);\n'
            '  _node.dispose();\n'
            '  super.dispose();\n'
            '}',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('hasFocus vs hasPrimaryFocus'),
          const SizedBox(height: 12),
          Table(
            border: TableBorder.all(
              color: cs.outline.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            children: const <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: Color(0x11000000)),
                children: <Widget>[
                  _TCell('Property', bold: true),
                  _TCell('True when', bold: true),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _TCell('hasFocus'),
                  _TCell(
                    'Node or any descendant has primary focus.',
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _TCell('hasPrimaryFocus'),
                  _TCell(
                    'This exact node has primary focus (leaf).',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListenerStateCard extends StatelessWidget {
  const _ListenerStateCard({
    required this.index,
    required this.focused,
  });
  final int index;
  final ValueNotifier<bool> focused;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<bool>(
      valueListenable: focused,
      builder: (ctx, isFocused, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isFocused ? cs.primaryContainer : cs.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isFocused ? cs.primary : cs.outline,
              width: isFocused ? 2 : 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                isFocused ? Icons.lens : Icons.lens_outlined,
                color: isFocused ? cs.primary : cs.outline,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                'Node-$index listener:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                isFocused ? 'hasFocus = true' : 'hasFocus = false',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: isFocused ? cs.primary : cs.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Chip(
                label: Text(isFocused ? 'FOCUSED' : 'unfocused'),
                backgroundColor: isFocused
                    ? cs.primary
                    : cs.surfaceContainerHighest,
                labelStyle: TextStyle(
                  color: isFocused ? cs.onPrimary : cs.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 9 — Pitfalls & API Cheat Sheet
// ---------------------------------------------------------------------------

class _PitfallsAndApiTab extends StatelessWidget {
  const _PitfallsAndApiTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader('Common Pitfalls'),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 1,
            title: 'Passing a disposed FocusNode',
            problem:
                'If the widget that owns the FocusNode has been removed from '
                'the tree and disposed, calling requestFocus() on that node '
                'throws an assertion error in debug mode.',
            fix:
                'Guard with a mounted/disposed check, or keep FocusNodes in '
                'a scope that outlives the requesting widget. In stateful '
                'widgets, only dispatch RequestFocusIntent while mounted.',
            code:
                '// WRONG — node may be disposed\n'
                'Actions.invoke(context, RequestFocusIntent(oldNode));\n\n'
                '// BETTER — check before dispatching\n'
                'if (!oldNode.debugDisposed!) {\n'
                '  Actions.invoke(context, RequestFocusIntent(oldNode));\n'
                '}',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 2,
            title: 'Calling before the node is attached',
            problem:
                'A FocusNode must be attached to the widget tree (given to '
                'a Focus or FocusScope widget) before it can receive focus. '
                'Requesting focus during initState, before the first build, '
                'or from a widget that has not yet built its Focus child, '
                'silently does nothing or causes assertion failures.',
            fix:
                'Delay focus requests until after the first frame using '
                'WidgetsBinding.instance.addPostFrameCallback.',
            code:
                '// WRONG — too early, node not attached yet\n'
                '@override\n'
                'void initState() {\n'
                '  super.initState();\n'
                '  Actions.invoke(context, RequestFocusIntent(myNode)); // noop\n'
                '}\n\n'
                '// CORRECT — wait for first frame\n'
                '@override\n'
                'void initState() {\n'
                '  super.initState();\n'
                '  WidgetsBinding.instance.addPostFrameCallback((_) {\n'
                '    Actions.invoke(context, RequestFocusIntent(myNode));\n'
                '  });\n'
                '}',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 3,
            title: 'Using in non-MaterialApp trees',
            problem:
                'RequestFocusAction is only pre-registered inside '
                'WidgetsApp / MaterialApp / CupertinoApp. If you call '
                'Actions.invoke() for RequestFocusIntent in a plain '
                'widget test or custom root, no action is found and '
                'the call returns null (with invoke()) or asserts.',
            fix:
                'Wrap the test or custom subtree in an Actions widget '
                'that registers RequestFocusAction explicitly.',
            code:
                '// In widget tests or custom roots:\n'
                'Actions(\n'
                '  actions: <Type, Action<Intent>>{\n'
                '    RequestFocusIntent: RequestFocusAction(),\n'
                '  },\n'
                '  child: Builder(\n'
                '    builder: (context) {\n'
                '      // Now safe to invoke RequestFocusIntent\n'
                '      return myWidget;\n'
                '    },\n'
                '  ),\n'
                ')',
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 4,
            title: 'Adding listener inside build()',
            problem:
                'Calling node.addListener() in the build method registers '
                'a new listener on every rebuild, causing the callback to '
                'fire multiple times per focus change.',
            fix:
                'Add listeners only once: in StatefulWidget.initState(), '
                'or at top-level for global nodes (as this demo does).',
            code:
                '// WRONG — duplicates on every rebuild\n'
                '@override\n'
                'Widget build(BuildContext context) {\n'
                '  _node.addListener(_cb); // BAD\n'
                '  return ...\n'
                '}\n\n'
                '// CORRECT\n'
                '@override\n'
                'void initState() {\n'
                '  super.initState();\n'
                '  _node.addListener(_cb); // once\n'
                '}',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('API Cheat Sheet — RequestFocusIntent'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'RequestFocusIntent',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'class RequestFocusIntent extends Intent',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const Divider(height: 20),
                _ApiRow(name: 'Constructor', sig: 'RequestFocusIntent(FocusNode focusNode)'),
                _ApiRow(name: 'focusNode', sig: 'FocusNode get focusNode'),
                const Divider(height: 20),
                Text(
                  'Paired action: RequestFocusAction',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                _ApiRow(
                  name: 'invoke',
                  sig: 'Object? invoke(RequestFocusIntent intent)\n  → calls intent.focusNode.requestFocus()',
                ),
                _ApiRow(
                  name: 'isEnabled',
                  sig: 'bool isEnabled(RequestFocusIntent intent)\n  → always true by default',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Quick Reference — Dispatch Patterns'),
          const SizedBox(height: 12),
          _CodeBox(
            '// Direct dispatch\n'
            'Actions.invoke(context, RequestFocusIntent(node));\n\n'
            '// Safe dispatch (no throw if no handler)\n'
            'Actions.maybeInvoke(context, RequestFocusIntent(node));\n\n'
            '// Via Shortcuts map\n'
            '<ShortcutActivator, Intent>{\n'
            '  SingleActivator(LogicalKeyboardKey.f1): RequestFocusIntent(node1),\n'
            '}\n\n'
            '// Manual (bypasses Actions pipeline entirely)\n'
            'node.requestFocus();\n\n'
            '// Unfocus everything\n'
            'FocusScope.of(context).unfocus();',
          ),
          const SizedBox(height: 20),
          const _SectionHeader('Summary'),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'RequestFocusIntent in one paragraph',
            body:
                'RequestFocusIntent is a thin data-carrier Intent that bridges '
                'the decoupled Actions/Intents pipeline to Flutter\'s FocusManager. '
                'It carries a FocusNode, which its paired RequestFocusAction reads '
                'and passes to node.requestFocus(). MaterialApp pre-registers the '
                'action so any widget can dispatch the intent with '
                'Actions.invoke(context, RequestFocusIntent(myNode)) and the focus '
                'system handles the rest. Combine with Shortcuts to bind keyboard '
                'keys, or dispatch programmatically from buttons, validators, and '
                'wizards. Avoid calling before the node is attached, after it is '
                'disposed, or outside a WidgetsApp tree without registering '
                'RequestFocusAction manually.',
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.index,
    required this.title,
    required this.problem,
    required this.fix,
    required this.code,
  });
  final int index;
  final String title;
  final String problem;
  final String fix;
  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 14,
                  backgroundColor: cs.error,
                  child: Text(
                    '$index',
                    style: TextStyle(
                      color: cs.onError,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.warning_amber, color: cs.error, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      problem,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onErrorContainer,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_circle,
                    color: cs.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      fix,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onSecondaryContainer,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _CodeBox(code),
          ],
        ),
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.name, required this.sig});
  final String name;
  final String sig;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: cs.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              sig,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
