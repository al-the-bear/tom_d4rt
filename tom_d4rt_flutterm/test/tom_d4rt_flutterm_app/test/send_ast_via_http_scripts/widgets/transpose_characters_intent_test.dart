import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TransposeCharactersIntentDeepDemo();
}

const Color _kPrimary = Color(0xFF004D40);
const Color _kAccent = Color(0xFFFF8A65);
const Color _kSurface = Color(0xFFE0F2F1);
const Color _kPanel = Colors.white;

class _TransposeCharactersIntentDeepDemo extends StatefulWidget {
  const _TransposeCharactersIntentDeepDemo();

  @override
  State<_TransposeCharactersIntentDeepDemo> createState() =>
      _TransposeCharactersIntentDeepDemoState();
}

class _TransposeCharactersIntentDeepDemoState
    extends State<_TransposeCharactersIntentDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: const Text('TransposeCharactersIntent Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Intent Model'),
            Tab(text: 'Transpose Lab'),
            Tab(text: 'Shortcut Routing'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _IntentModelTab(),
          _TransposeLabTab(),
          _ShortcutRoutingTab(),
        ],
      ),
    );
  }
}

class _IntentModelTab extends StatelessWidget {
  const _IntentModelTab();

  @override
  Widget build(BuildContext context) {
    const intent = TransposeCharactersIntent();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          title: 'Intent Semantics',
          body:
              'TransposeCharactersIntent represents a command to swap adjacent '
              'characters around the caret. The intent declares what to do; '
              'its action decides how to mutate text and selection state.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Intent Snapshot', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('runtimeType: ${intent.runtimeType}'),
                Text('description: $intent'),
                const SizedBox(height: 8),
                const Text(
                  'Typical trigger: Ctrl+T in desktop text editing contexts.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _ConceptCard(
          title: 'Behavior summary',
          bullets: [
            'Swaps nearby characters when a legal pair exists.',
            'Can adjust cursor position to keep editing flow natural.',
            'Often no-op when text is too short or selection is ranged.',
            'Integrates with undo stack as one atomic edit.',
          ],
          color: Color(0xFF00695C),
        ),
        const _ConceptCard(
          title: 'Action-system perspective',
          bullets: [
            'Intent is declarative and testable as command metadata.',
            'Action encapsulates mutation logic and precondition checks.',
            'Shortcuts map keyboard activators to intents.',
            'Focusable context decides which action implementation is active.',
          ],
          color: Color(0xFF1565C0),
        ),
      ],
    );
  }
}

class _TransposeLabTab extends StatefulWidget {
  const _TransposeLabTab();

  @override
  State<_TransposeLabTab> createState() => _TransposeLabTabState();
}

class _TransposeLabTabState extends State<_TransposeLabTab> {
  final TextEditingController _controller = TextEditingController(
    text: 'transposition example',
  );
  int _cursor = 5;
  bool _treatEndAsLastPair = true;
  bool _ignoreIfSelectionRange = true;
  final List<String> _history = ['Lab initialized'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _append(String event) {
    setState(() {
      _history.add(event);
      if (_history.length > 30) {
        _history.removeAt(0);
      }
    });
  }

  void _runTranspose() {
    final source = _controller.text;
    final result = _transpose(
      text: source,
      cursor: _cursor,
      treatEndAsLastPair: _treatEndAsLastPair,
      ignoreIfSelectionRange: _ignoreIfSelectionRange,
    );
    setState(() {
      _controller.text = result.text;
      _cursor = result.cursor;
    });
    _append('transpose => "${result.text}" at cursor ${result.cursor}');
  }

  @override
  Widget build(BuildContext context) {
    final preview = _insertCaret(_controller.text, _cursor);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          title: 'Interactive Transpose Lab',
          body:
              'Adjust cursor and policy toggles, then execute transpose to see '
              'how character swaps and caret movement behave under different rules.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Editable text',
                  ),
                ),
                const SizedBox(height: 10),
                Text('Cursor index: $_cursor'),
                Slider(
                  value: _cursor.toDouble(),
                  min: 0,
                  max: _controller.text.length.toDouble().clamp(0, 200),
                  divisions: _controller.text.isEmpty ? 1 : _controller.text.length,
                  onChanged: (value) => setState(() => _cursor = value.round()),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('end uses last pair'),
                      selected: _treatEndAsLastPair,
                      onSelected: (value) => setState(() => _treatEndAsLastPair = value),
                    ),
                    FilterChip(
                      label: const Text('ignore range selections'),
                      selected: _ignoreIfSelectionRange,
                      onSelected: (value) => setState(() => _ignoreIfSelectionRange = value),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: _runTranspose, child: const Text('Apply Ctrl+T')), 
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _controller.text = 'transposition example';
                          _cursor = 5;
                        });
                        _append('reset lab input');
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Preview', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFE8F5E9),
                  ),
                  child: Text(preview, style: const TextStyle(fontFamily: 'monospace')),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('History', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final line in _history)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $line'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ShortcutRoutingTab extends StatefulWidget {
  const _ShortcutRoutingTab();

  @override
  State<_ShortcutRoutingTab> createState() => _ShortcutRoutingTabState();
}

class _ShortcutRoutingTabState extends State<_ShortcutRoutingTab> {
  bool _editorFocused = true;
  bool _shortcutLayerEnabled = true;
  bool _hasConflict = false;
  final List<String> _log = ['Routing initialized'];

  void _append(String event) {
    setState(() {
      _log.add(event);
      if (_log.length > 28) {
        _log.removeAt(0);
      }
    });
  }

  void _simulateCtrlT() {
    final result = _resolveShortcut(
      editorFocused: _editorFocused,
      shortcutLayerEnabled: _shortcutLayerEnabled,
      hasConflict: _hasConflict,
    );
    _append('Ctrl+T => ${result.route} (${result.explanation})');
  }

  @override
  Widget build(BuildContext context) {
    final status = _resolveShortcut(
      editorFocused: _editorFocused,
      shortcutLayerEnabled: _shortcutLayerEnabled,
      hasConflict: _hasConflict,
    );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          title: 'Shortcut Routing Simulator',
          body:
              'This view models how Ctrl+T can route through shortcut layers, '
              'focus scopes, and conflict handlers before TransposeCharactersIntent '
              'is invoked.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('editor focused'),
                      selected: _editorFocused,
                      onSelected: (value) => setState(() => _editorFocused = value),
                    ),
                    FilterChip(
                      label: const Text('shortcut layer enabled'),
                      selected: _shortcutLayerEnabled,
                      onSelected: (value) => setState(() => _shortcutLayerEnabled = value),
                    ),
                    FilterChip(
                      label: const Text('conflicting mapping'),
                      selected: _hasConflict,
                      onSelected: (value) => setState(() => _hasConflict = value),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _simulateCtrlT,
                  child: const Text('Simulate Ctrl+T'),
                ),
                const SizedBox(height: 8),
                Text('Route: ${status.route}', style: const TextStyle(fontWeight: FontWeight.w700)),
                Text(status.explanation),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Routing Notes', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const Text('• Focus scope must expose action for TransposeCharactersIntent.'),
                const Text('• Shortcut registries may override or swallow Ctrl+T.'),
                const Text('• Platform defaults can differ in browser-hosted contexts.'),
                const Text('• Always provide fallback edit commands when shortcut is unavailable.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Event Log', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final line in _log)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $line'),
                  ),
              ],
            ),
          ),
        ),
      ],
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
      color: _kPanel,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard({required this.title, required this.bullets, required this.color});

  final String title;
  final List<String> bullets;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: _kPanel,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 8),
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $bullet'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransposeOutcome {
  const _TransposeOutcome({required this.text, required this.cursor});

  final String text;
  final int cursor;
}

_TransposeOutcome _transpose({
  required String text,
  required int cursor,
  required bool treatEndAsLastPair,
  required bool ignoreIfSelectionRange,
}) {
  if (text.length < 2) {
    return _TransposeOutcome(text: text, cursor: cursor.clamp(0, text.length));
  }

  final clampedCursor = cursor.clamp(0, text.length);

  if (ignoreIfSelectionRange) {
    // The demo models a collapsed selection only path for clarity.
  }

  int left;
  int right;
  if (clampedCursor == 0) {
    left = 0;
    right = 1;
  } else if (clampedCursor >= text.length) {
    if (!treatEndAsLastPair) {
      return _TransposeOutcome(text: text, cursor: clampedCursor);
    }
    left = text.length - 2;
    right = text.length - 1;
  } else {
    left = clampedCursor - 1;
    right = clampedCursor;
  }

  final chars = text.split('');
  final temp = chars[left];
  chars[left] = chars[right];
  chars[right] = temp;

  final nextCursor = (right + 1).clamp(0, chars.length);
  return _TransposeOutcome(text: chars.join(), cursor: nextCursor);
}

String _insertCaret(String text, int cursor) {
  final c = cursor.clamp(0, text.length);
  return '${text.substring(0, c)}|${text.substring(c)}';
}

class _ShortcutRoute {
  const _ShortcutRoute({required this.route, required this.explanation});

  final String route;
  final String explanation;
}

_ShortcutRoute _resolveShortcut({
  required bool editorFocused,
  required bool shortcutLayerEnabled,
  required bool hasConflict,
}) {
  if (!shortcutLayerEnabled) {
    return const _ShortcutRoute(
      route: 'unhandled',
      explanation: 'Shortcut layer disabled, Ctrl+T does not dispatch intent.',
    );
  }
  if (!editorFocused) {
    return const _ShortcutRoute(
      route: 'ignored by focus',
      explanation: 'Focused node is outside editor action scope.',
    );
  }
  if (hasConflict) {
    return const _ShortcutRoute(
      route: 'conflict override',
      explanation: 'Another handler captured Ctrl+T before transpose action.',
    );
  }
  return const _ShortcutRoute(
    route: 'transpose action',
    explanation: 'Intent reached bound action and executes character transpose.',
  );
}
