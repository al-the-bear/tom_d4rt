import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return const _UndoTextIntentDeepDemo();
}

const Color _kMidnight = Color(0xFF111827);
const Color _kBackdrop = Color(0xFFF8FAFC);
const Color _kSignal = Color(0xFFBAE6FD);

class _UndoTextIntentDeepDemo extends StatefulWidget {
  const _UndoTextIntentDeepDemo();

  @override
  State<_UndoTextIntentDeepDemo> createState() => _UndoTextIntentDeepDemoState();
}

class _UndoTextIntentDeepDemoState extends State<_UndoTextIntentDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackdrop,
      appBar: AppBar(
        backgroundColor: _kMidnight,
        foregroundColor: Colors.white,
        title: const Text('UndoTextIntent Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kSignal,
          tabs: const [
            Tab(text: 'Intent Atlas'),
            Tab(text: 'Dispatch Lab'),
            Tab(text: 'Shortcut Surface'),
            Tab(text: 'Cause Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _IntentAtlasPanel(),
          _DispatchLabPanel(),
          _ShortcutSurfacePanel(),
          _CauseAnalyticsPanel(),
        ],
      ),
    );
  }
}

class _IntentAtlasPanel extends StatelessWidget {
  const _IntentAtlasPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HeroCard(
          title: 'UndoTextIntent Purpose',
          body:
              'UndoTextIntent represents an undo command request in Flutter action '
              'routing. It carries SelectionChangedCause metadata so the handler can '
              'understand where the request originated.',
        ),
        SizedBox(height: 12),
        _IntentCard(
          title: 'Core characteristics',
          color: Color(0xFF166534),
          bullets: [
            'Intent subclass used by Actions/Shortcuts system.',
            'Usually dispatched from keyboard shortcut maps.',
            'Contains a cause value for source semantics.',
            'Handled by action that manipulates undo timeline.',
          ],
        ),
        _IntentCard(
          title: 'Typical dispatch paths',
          color: Color(0xFF1D4ED8),
          bullets: [
            'Ctrl/Cmd+Z keyboard shortcut in editor scope.',
            'Toolbar button invoking invokeAction with intent.',
            'Command palette selecting Undo command.',
            'Programmatic replay of user-edit events.',
          ],
        ),
        _IntentCard(
          title: 'Design notes',
          color: Color(0xFF9A3412),
          bullets: [
            'Intent is command request, not command execution.',
            'Action determines whether request can be fulfilled.',
            'Metadata can feed telemetry and behavior adaptation.',
            'Scope matters: focused Actions context resolves handler.',
          ],
        ),
        SizedBox(height: 12),
        _CauseReferenceCard(),
      ],
    );
  }
}

class _CauseReferenceCard extends StatelessWidget {
  const _CauseReferenceCard();

  @override
  Widget build(BuildContext context) {
    final causes = SelectionChangedCause.values;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SelectionChangedCause Reference', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (final cause in causes)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• ${cause.name}'),
              ),
          ],
        ),
      ),
    );
  }
}

class _DispatchLabPanel extends StatefulWidget {
  const _DispatchLabPanel();

  @override
  State<_DispatchLabPanel> createState() => _DispatchLabPanelState();
}

class _DispatchLabPanelState extends State<_DispatchLabPanel> {
  final List<String> _history = ['draft'];
  int _pointer = 0;
  SelectionChangedCause _cause = SelectionChangedCause.keyboard;
  final List<String> _events = ['Dispatch lab initialized'];

  bool get _canUndo => _pointer > 0;
  bool get _canRedo => _pointer < _history.length - 1;

  void _log(String line) {
    _events.add(line);
    if (_events.length > 30) {
      _events.removeAt(0);
    }
  }

  void _commit() {
    setState(() {
      if (_pointer < _history.length - 1) {
        _history.removeRange(_pointer + 1, _history.length);
      }
      final next = '${_history[_pointer]}*';
      _history.add(next);
      _pointer = _history.length - 1;
      _log('commit -> depth ${_history.length}, pointer $_pointer');
    });
  }

  void _dispatchUndoIntent() {
    final action = _UndoDemoAction();
    final intent = UndoTextIntent(_cause);
    final accepted = action.invoke(intent);
    setState(() {
      if (_canUndo) {
        _pointer--;
        _log('UndoTextIntent(${_cause.name}) accepted=$accepted -> pointer $_pointer');
      } else {
        _log('UndoTextIntent(${_cause.name}) ignored (no undo available)');
      }
    });
  }

  void _dispatchRedoIntent() {
    setState(() {
      if (_canRedo) {
        _pointer++;
        _log('Redo path invoked -> pointer $_pointer');
      } else {
        _log('Redo path ignored (no redo available)');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = _history[_pointer];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeroCard(
          title: 'Intent Dispatch Lab',
          body:
              'Dispatch UndoTextIntent instances with different causes and inspect '
              'how action routing pairs with undo availability state.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final cause in SelectionChangedCause.values)
                      ChoiceChip(
                        label: Text(cause.name),
                        selected: _cause == cause,
                        onSelected: (_) => setState(() => _cause = cause),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: _commit, child: const Text('Commit Edit')),
                    OutlinedButton(onPressed: _dispatchUndoIntent, child: const Text('Dispatch UndoTextIntent')),
                    OutlinedButton(onPressed: _dispatchRedoIntent, child: const Text('Dispatch Redo Path')),
                  ],
                ),
                const SizedBox(height: 8),
                Text('canUndo: $_canUndo | canRedo: $_canRedo | pointer: $_pointer'),
                Text('current value: $current'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFECFEFF),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('History Ladder', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (var i = 0; i < _history.length; i++)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: i == _pointer ? const Color(0xFFBFDBFE) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF93C5FD)),
                    ),
                    child: Text('[$i] ${_history[i]}'),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dispatch Timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $event'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ShortcutSurfacePanel extends StatefulWidget {
  const _ShortcutSurfacePanel();

  @override
  State<_ShortcutSurfacePanel> createState() => _ShortcutSurfacePanelState();
}

class _ShortcutSurfacePanelState extends State<_ShortcutSurfacePanel> {
  final FocusNode _focus = FocusNode();
  final List<String> _events = ['Shortcut surface initialized'];

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _add(String text) {
    setState(() {
      _events.add(text);
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeroCard(
          title: 'Shortcut Surface',
          body:
              'This panel maps keyboard shortcuts to UndoTextIntent and demonstrates '
              'parity with toolbar dispatch through the same action channel.',
        ),
        const SizedBox(height: 12),
        Shortcuts(
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.keyZ, control: true): UndoTextIntent(SelectionChangedCause.keyboard),
          },
          child: Actions(
            actions: {
              UndoTextIntent: CallbackAction<UndoTextIntent>(
                onInvoke: (intent) {
                  _add('Shortcut dispatched UndoTextIntent cause=${intent.cause.name}');
                  return null;
                },
              ),
            },
            child: Focus(
              focusNode: _focus,
              autofocus: true,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Active Shortcut Region', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      const Text('Press Ctrl+Z while this region is focused.'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          FilledButton(
                            onPressed: () {
                              Actions.invoke(context, const UndoTextIntent(SelectionChangedCause.keyboard));
                              _add('Toolbar button invoked UndoTextIntent keyboard');
                            },
                            child: const Text('Toolbar Undo'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {
                              _focus.requestFocus();
                              _add('focus requested for shortcut region');
                            },
                            child: const Text('Refocus Surface'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Shortcut/Event Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final e in _events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $e'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CauseAnalyticsPanel extends StatefulWidget {
  const _CauseAnalyticsPanel();

  @override
  State<_CauseAnalyticsPanel> createState() => _CauseAnalyticsPanelState();
}

class _CauseAnalyticsPanelState extends State<_CauseAnalyticsPanel> {
  final Map<SelectionChangedCause, int> _counts = {
    for (final c in SelectionChangedCause.values) c: 0,
  };

  void _record(SelectionChangedCause cause) {
    setState(() {
      _counts[cause] = (_counts[cause] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeroCard(
          title: 'Cause Analytics',
          body:
              'Track which causes are producing UndoTextIntent dispatches to verify '
              'expected command origins and detect unusual routing patterns.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final cause in SelectionChangedCause.values)
                  FilledButton.tonal(
                    onPressed: () => _record(cause),
                    child: Text('Dispatch ${cause.name}'),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cause Frequency Table', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final cause in SelectionChangedCause.values)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(cause.name)),
                        Text('${_counts[cause]} dispatches'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
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

class _IntentCard extends StatelessWidget {
  const _IntentCard({required this.title, required this.color, required this.bullets});

  final String title;
  final Color color;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: color)),
              const SizedBox(height: 6),
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

class _UndoDemoAction extends Action<UndoTextIntent> {
  _UndoDemoAction();

  @override
  Object? invoke(UndoTextIntent intent) {
    return intent.cause;
  }
}
