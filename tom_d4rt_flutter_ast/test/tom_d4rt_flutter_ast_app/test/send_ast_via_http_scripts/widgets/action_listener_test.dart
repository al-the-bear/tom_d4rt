// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =====================================================================
// ActionListener — Deep Demo
// =====================================================================
//
// `ActionListener` is a small but very useful Flutter widget that
// subscribes to an `Action`'s notifications. An `Action` is the unit
// of "thing the user wants to do" in Flutter's intent/action system,
// and it can change in two interesting ways:
//
//  1. Its enabled state can flip (isEnabled getter changes).
//  2. It can be invoked (someone called `invokeAction`).
//
// Both are surfaced via the `Action.notifyActionListeners()` mechanism.
// `ActionListener` is the widget-shaped way to subscribe to that.
//
// This file demonstrates ActionListener in many flavors:
//
//  - Tap-to-invoke + log
//  - Keyboard shortcut + listener
//  - Multiple listeners on one action
//  - Lifecycle add/remove
//  - Enabled/disabled visualization
//  - Undo/redo coordinator
//  - Telemetry pattern
//  - SnackBar pattern
//  - Recipe gallery
//  - Reference table
//
// All sections are crafted to actually use `ActionListener` widgets
// wrapping real `Action` instances.
// =====================================================================

// ---------------------------------------------------------------------
// Section A: Intent + Action definitions used across the demo.
// ---------------------------------------------------------------------

/// Intent fired when the user wants to greet someone.
class _GreetIntent extends Intent {
  const _GreetIntent(this.name);
  final String name;
}

/// Intent fired when the user wants to "save" something.
class _SaveIntent extends Intent {
  const _SaveIntent();
}

/// Intent fired for a generic broadcast (multiple listeners).
class _BroadcastIntent extends Intent {
  const _BroadcastIntent(this.payload);
  final String payload;
}

/// Intent fired for telemetry-tracked operations.
class _TelemetryIntent extends Intent {
  const _TelemetryIntent(this.eventName);
  final String eventName;
}

/// Intent for snackbar demo.
class _SnackIntent extends Intent {
  const _SnackIntent(this.message);
  final String message;
}

/// Intent for undo.
class _UndoIntent extends Intent {
  const _UndoIntent();
}

/// Intent for redo.
class _RedoIntent extends Intent {
  const _RedoIntent();
}

// ---------------------------------------------------------------------
// Section B: Action implementations.
//
// Each Action increments an internal counter and uses the
// notifyActionListeners() mechanism so attached ActionListener widgets
// receive callbacks.
// ---------------------------------------------------------------------

/// A counting greet action — increments a counter when invoked.
class _GreetAction extends Action<_GreetIntent> {
  int invocationCount = 0;
  String lastName = '';

  @override
  Object? invoke(_GreetIntent intent) {
    invocationCount++;
    lastName = intent.name;
    notifyActionListeners();
    return 'greeted ${intent.name} ($invocationCount)';
  }
}

/// A save action that records a timestamp on each invocation.
class _SaveAction extends Action<_SaveIntent> {
  int saveCount = 0;
  DateTime? lastSavedAt;

  @override
  Object? invoke(_SaveIntent intent) {
    saveCount++;
    lastSavedAt = DateTime.now();
    notifyActionListeners();
    return null;
  }
}

/// A broadcast action used to demonstrate multiple listeners.
class _BroadcastAction extends Action<_BroadcastIntent> {
  String latestPayload = '';
  int broadcasts = 0;

  @override
  Object? invoke(_BroadcastIntent intent) {
    broadcasts++;
    latestPayload = intent.payload;
    notifyActionListeners();
    return null;
  }
}

/// A toggleable action — its `isEnabled` can flip.
class _ToggleableAction extends Action<_GreetIntent> {
  bool _enabled = true;
  int invocationCount = 0;
  int stateChanges = 0;

  @override
  bool isEnabled(_GreetIntent intent) => _enabled;

  void setEnabled(bool value) {
    if (_enabled == value) return;
    _enabled = value;
    stateChanges++;
    // Tell listeners that our enabled state changed.
    notifyActionListeners();
  }

  @override
  Object? invoke(_GreetIntent intent) {
    invocationCount++;
    notifyActionListeners();
    return null;
  }
}

/// Telemetry-aware action that increments a per-event counter.
class _TelemetryAction extends Action<_TelemetryIntent> {
  final Map<String, int> counts = <String, int>{};
  String lastEvent = '';

  @override
  Object? invoke(_TelemetryIntent intent) {
    counts[intent.eventName] = (counts[intent.eventName] ?? 0) + 1;
    lastEvent = intent.eventName;
    notifyActionListeners();
    return null;
  }
}

/// SnackBar-driving action.
class _SnackAction extends Action<_SnackIntent> {
  String lastMessage = '';
  int invocationCount = 0;

  @override
  Object? invoke(_SnackIntent intent) {
    invocationCount++;
    lastMessage = intent.message;
    notifyActionListeners();
    return null;
  }
}

/// Undo action with a stack.
class _UndoAction extends Action<_UndoIntent> {
  final List<String> stack;
  final List<String> redoStack;
  String? lastUndo;
  int invocationCount = 0;

  _UndoAction(this.stack, this.redoStack);

  @override
  bool isEnabled(_UndoIntent intent) => stack.isNotEmpty;

  @override
  Object? invoke(_UndoIntent intent) {
    if (stack.isEmpty) return null;
    invocationCount++;
    final item = stack.removeLast();
    redoStack.add(item);
    lastUndo = item;
    notifyActionListeners();
    return null;
  }
}

/// Redo action with a stack.
class _RedoAction extends Action<_RedoIntent> {
  final List<String> stack;
  final List<String> redoStack;
  String? lastRedo;
  int invocationCount = 0;

  _RedoAction(this.stack, this.redoStack);

  @override
  bool isEnabled(_RedoIntent intent) => redoStack.isNotEmpty;

  @override
  Object? invoke(_RedoIntent intent) {
    if (redoStack.isEmpty) return null;
    invocationCount++;
    final item = redoStack.removeLast();
    stack.add(item);
    lastRedo = item;
    notifyActionListeners();
    return null;
  }
}

// ---------------------------------------------------------------------
// Section C: Top-level build()
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== ActionListener Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ActionListener Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ActionListener Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _IntroSection(),
              SizedBox(height: 24),
              _SectionDivider('1. Tap-to-invoke + ActionListener log'),
              _TapToInvokeSection(),
              SizedBox(height: 24),
              _SectionDivider('2. Keyboard shortcut + ActionListener'),
              _ShortcutSection(),
              SizedBox(height: 24),
              _SectionDivider('3. Multiple listeners on one Action'),
              _MultipleListenersSection(),
              SizedBox(height: 24),
              _SectionDivider('4. ActionListener lifecycle (add/remove)'),
              _LifecycleSection(),
              SizedBox(height: 24),
              _SectionDivider('5. Enabled/disabled state visualization'),
              _EnabledStateSection(),
              SizedBox(height: 24),
              _SectionDivider('6. Undo / Redo coordinator'),
              _UndoRedoSection(),
              SizedBox(height: 24),
              _SectionDivider('7. Telemetry collector pattern'),
              _TelemetrySection(),
              SizedBox(height: 24),
              _SectionDivider('8. SnackBar via ActionListener'),
              _SnackBarSection(),
              SizedBox(height: 24),
              _SectionDivider('9. Recipe gallery'),
              _RecipeGallery(),
              SizedBox(height: 24),
              _SectionDivider('10. Reference table'),
              _ReferenceTable(),
              SizedBox(height: 32),
              _FooterNote(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Reusable building blocks
// ---------------------------------------------------------------------

class _SectionDivider extends StatelessWidget {
  const _SectionDivider(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 6,
            height: 28,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: child,
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
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 6),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// =====================================================================
// 0. Intro section
// =====================================================================

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'What is ActionListener?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'ActionListener is a widget that subscribes to a specific '
            "Action's lifecycle notifications. When the underlying Action "
            'either changes its enabled state or is invoked, the listener '
            "fires `onAction(action)`. It's a tidy way to react to action "
            'events from elsewhere in your widget tree without manually '
            'wiring listeners in initState/dispose.',
          ),
          SizedBox(height: 12),
          Text('Why use it?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          _Bullet('Show a SnackBar after an action is invoked.'),
          _Bullet('Maintain a UI history (undo/redo, audit log).'),
          _Bullet('Telemetry: count how often actions fire.'),
          _Bullet('Reflect enabled/disabled state changes in the UI.'),
          _Bullet('Coordinate side-effects from multiple call sites '
              '(menu, button, keyboard) into a single observer.'),
          SizedBox(height: 12),
          Text('How is it different from calling Action.invoke directly?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text(
            'Calling invoke runs the action, but only at that call-site. '
            'ActionListener observes ALL invocations of the Action, '
            'no matter who triggered them — keyboard shortcut, button, '
            'menu, programmatic call. It also surfaces enabled-state '
            'changes which `invoke` does not.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 1. Tap-to-invoke + log
// =====================================================================

class _TapToInvokeSection extends StatefulWidget {
  const _TapToInvokeSection();

  @override
  State<_TapToInvokeSection> createState() => _TapToInvokeSectionState();
}

class _TapToInvokeSectionState extends State<_TapToInvokeSection> {
  late final _GreetAction _greet;
  final List<String> _log = <String>[];

  @override
  void initState() {
    super.initState();
    _greet = _GreetAction();
  }

  void _onActionFired(Action<Intent> action) {
    final greet = action as _GreetAction;
    final now = DateTime.now();
    final hh = now.hour.toString().padLeft(2, '0');
    final mm = now.minute.toString().padLeft(2, '0');
    final ss = now.second.toString().padLeft(2, '0');
    setState(() {
      _log.insert(
        0,
        '[$hh:$mm:$ss] greet -> ${greet.lastName} '
        '(#${greet.invocationCount})',
      );
      // Cap the log to keep the demo bounded.
      if (_log.length > 30) {
        _log.removeRange(30, _log.length);
      }
    });
    print('ActionListener fired: ${greet.invocationCount}');
  }

  void _invoke(String name) {
    _greet.invoke(_GreetIntent(name));
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Click any "Greet" button. Each invocation goes through the '
            'Action and notifies ActionListener, which appends a row.',
          ),
          const SizedBox(height: 12),
          ActionListener(
            action: _greet,
            listener: _onActionFired,
            child: Row(
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () => _invoke('Ada'),
                  icon: const Icon(Icons.waving_hand),
                  label: const Text('Greet Ada'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _invoke('Linus'),
                  icon: const Icon(Icons.waving_hand),
                  label: const Text('Greet Linus'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _invoke('Grace'),
                  icon: const Icon(Icons.waving_hand),
                  label: const Text('Greet Grace'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _log.isEmpty
                ? const Center(
                    child: Text('No invocations yet — click a button.'),
                  )
                : ListView.builder(
                    itemCount: _log.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          _log[index],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 6),
          Text(
            'Total invocations: ${_greet.invocationCount}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 2. Keyboard shortcut + ActionListener
// =====================================================================

class _ShortcutSection extends StatefulWidget {
  const _ShortcutSection();

  @override
  State<_ShortcutSection> createState() => _ShortcutSectionState();
}

class _ShortcutSectionState extends State<_ShortcutSection> {
  late final _SaveAction _save;
  final FocusNode _focus = FocusNode(debugLabel: 'shortcutSection');
  final List<String> _strokeLog = <String>[];
  int _localFireCount = 0;

  @override
  void initState() {
    super.initState();
    _save = _SaveAction();
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _onSave(Action<Intent> action) {
    final s = action as _SaveAction;
    setState(() {
      _localFireCount++;
      _strokeLog.insert(
        0,
        'Saved at ${_fmtTime(s.lastSavedAt)} (#${s.saveCount})',
      );
      if (_strokeLog.length > 8) {
        _strokeLog.removeRange(8, _strokeLog.length);
      }
    });
  }

  String _fmtTime(DateTime? dt) {
    if (dt == null) return '--:--:--';
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final isMac = Theme.of(context).platform == TargetPlatform.macOS;
    final saveShortcut = isMac
        ? const SingleActivator(LogicalKeyboardKey.keyS, meta: true)
        : const SingleActivator(LogicalKeyboardKey.keyS, control: true);

    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Press ${isMac ? 'Cmd+S' : 'Ctrl+S'} while the box below is '
            'focused. The keyboard route triggers the same Action, and '
            'an ActionListener records each fire.',
          ),
          const SizedBox(height: 8),
          Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              saveShortcut: const _SaveIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                _SaveIntent: _save,
              },
              child: ActionListener(
                action: _save,
                listener: _onSave,
                child: Focus(
                  focusNode: _focus,
                  autofocus: false,
                  child: GestureDetector(
                    onTap: () => _focus.requestFocus(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _focus.hasFocus
                            ? Colors.indigo.withOpacity(0.10)
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _focus.hasFocus
                              ? Colors.indigo
                              : Colors.grey.shade400,
                          width: _focus.hasFocus ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _focus.hasFocus
                                ? 'Focused — try ${isMac ? 'Cmd+S' : 'Ctrl+S'}'
                                : 'Click to focus, then press '
                                    '${isMac ? 'Cmd+S' : 'Ctrl+S'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              Chip(
                                label: Text('saves: ${_save.saveCount}'),
                                avatar: const Icon(Icons.save, size: 16),
                              ),
                              Chip(
                                label: Text(
                                  'last: ${_fmtTime(_save.lastSavedAt)}',
                                ),
                                avatar: const Icon(Icons.schedule, size: 16),
                              ),
                              Chip(
                                label: Text(
                                  'listener fires: $_localFireCount',
                                ),
                                avatar: const Icon(
                                  Icons.notifications_active,
                                  size: 16,
                                ),
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
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save (button)'),
                onPressed: () => _save.invoke(const _SaveIntent()),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.keyboard),
                label: const Text('Focus the keyboard area'),
                onPressed: () => _focus.requestFocus(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_strokeLog.isNotEmpty)
            ..._strokeLog.map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  s,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            )
          else
            const Text(
              'No saves yet.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }
}

// =====================================================================
// 3. Multiple listeners on one Action
// =====================================================================

class _MultipleListenersSection extends StatefulWidget {
  const _MultipleListenersSection();

  @override
  State<_MultipleListenersSection> createState() =>
      _MultipleListenersSectionState();
}

class _MultipleListenersSectionState extends State<_MultipleListenersSection> {
  late final _BroadcastAction _broadcast;
  int _redFires = 0;
  int _blueFires = 0;
  String _redLast = '';
  String _blueLast = '';

  @override
  void initState() {
    super.initState();
    _broadcast = _BroadcastAction();
  }

  void _onRed(Action<Intent> action) {
    final b = action as _BroadcastAction;
    setState(() {
      _redFires++;
      _redLast = b.latestPayload;
    });
  }

  void _onBlue(Action<Intent> action) {
    final b = action as _BroadcastAction;
    setState(() {
      _blueFires++;
      _blueLast = b.latestPayload;
    });
  }

  void _send(String payload) {
    _broadcast.invoke(_BroadcastIntent(payload));
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Two ActionListeners attached to the SAME Action. Each fire '
            'updates both consumers — they are not exclusive.',
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _send('hello'),
                child: const Text('Send "hello"'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _send('world'),
                child: const Text('Send "world"'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _send('!!!'),
                child: const Text('Send "!!!"'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: ActionListener(
                  action: _broadcast,
                  listener: _onRed,
                  child: _ColoredFireBox(
                    color: Colors.red.shade50,
                    border: Colors.red,
                    title: 'Red consumer',
                    fires: _redFires,
                    last: _redLast,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ActionListener(
                  action: _broadcast,
                  listener: _onBlue,
                  child: _ColoredFireBox(
                    color: Colors.blue.shade50,
                    border: Colors.blue,
                    title: 'Blue consumer',
                    fires: _blueFires,
                    last: _blueLast,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Total broadcasts: ${_broadcast.broadcasts}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ColoredFireBox extends StatelessWidget {
  const _ColoredFireBox({
    required this.color,
    required this.border,
    required this.title,
    required this.fires,
    required this.last,
  });
  final Color color;
  final Color border;
  final String title;
  final int fires;
  final String last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: border,
            ),
          ),
          const SizedBox(height: 6),
          Text('Fires: $fires'),
          Text('Last payload: ${last.isEmpty ? '—' : last}'),
        ],
      ),
    );
  }
}

// =====================================================================
// 4. Lifecycle (mount/unmount listener)
// =====================================================================

class _LifecycleSection extends StatefulWidget {
  const _LifecycleSection();

  @override
  State<_LifecycleSection> createState() => _LifecycleSectionState();
}

class _LifecycleSectionState extends State<_LifecycleSection> {
  late final _GreetAction _action;
  bool _listenerAEnabled = true;
  bool _listenerBEnabled = false;
  int _aFires = 0;
  int _bFires = 0;

  @override
  void initState() {
    super.initState();
    _action = _GreetAction();
  }

  void _onA(Action<Intent> action) {
    setState(() => _aFires++);
  }

  void _onB(Action<Intent> action) {
    setState(() => _bFires++);
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Toggle listener A or B on/off. While off, the listener is '
            'unmounted, so its onAction is no longer registered with '
            'the Action — it stops receiving events.',
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: SwitchListTile(
                  title: const Text('Listener A mounted'),
                  subtitle: Text('A fires: $_aFires'),
                  value: _listenerAEnabled,
                  onChanged: (v) =>
                      setState(() => _listenerAEnabled = v),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  title: const Text('Listener B mounted'),
                  subtitle: Text('B fires: $_bFires'),
                  value: _listenerBEnabled,
                  onChanged: (v) =>
                      setState(() => _listenerBEnabled = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _action.invoke(const _GreetIntent('lifecycle')),
            child: const Text('Invoke action'),
          ),
          const SizedBox(height: 12),
          if (_listenerAEnabled)
            ActionListener(
              action: _action,
              listener: _onA,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '(Listener A is currently subscribed)',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '(Listener A is NOT subscribed)',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          if (_listenerBEnabled)
            ActionListener(
              action: _action,
              listener: _onB,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '(Listener B is currently subscribed)',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '(Listener B is NOT subscribed)',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          const SizedBox(height: 8),
          Text('Action invocation count: ${_action.invocationCount}'),
        ],
      ),
    );
  }
}

// =====================================================================
// 5. Enabled/disabled state visualization
// =====================================================================

class _EnabledStateSection extends StatefulWidget {
  const _EnabledStateSection();

  @override
  State<_EnabledStateSection> createState() => _EnabledStateSectionState();
}

class _EnabledStateSectionState extends State<_EnabledStateSection> {
  late final _ToggleableAction _toggle;
  final List<String> _stateTransitions = <String>[];
  bool _wasEnabled = true;

  @override
  void initState() {
    super.initState();
    _toggle = _ToggleableAction();
  }

  void _onToggle(Action<Intent> action) {
    final t = action as _ToggleableAction;
    final nowEnabled = t.isEnabled(const _GreetIntent('x'));
    if (nowEnabled != _wasEnabled) {
      _stateTransitions.insert(
        0,
        'state: ${_wasEnabled ? "enabled" : "disabled"} '
        '→ ${nowEnabled ? "enabled" : "disabled"}',
      );
      _wasEnabled = nowEnabled;
    } else {
      _stateTransitions.insert(
        0,
        'invoked while ${nowEnabled ? "enabled" : "disabled"} '
        '(#${t.invocationCount})',
      );
    }
    if (_stateTransitions.length > 8) {
      _stateTransitions.removeRange(8, _stateTransitions.length);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final enabled = _toggle.isEnabled(const _GreetIntent('check'));
    return _CardShell(
      child: ActionListener(
        action: _toggle,
        listener: _onToggle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Toggle the action enabled/disabled. The ActionListener fires '
              'on every state change AND on invoke. We log each transition.',
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Switch(
                  value: enabled,
                  onChanged: (v) => _toggle.setEnabled(v),
                ),
                const SizedBox(width: 8),
                Text(
                  enabled ? 'ENABLED' : 'DISABLED',
                  style: TextStyle(
                    color: enabled ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: enabled
                      ? () =>
                          _toggle.invoke(const _GreetIntent('toggle-demo'))
                      : null,
                  child: const Text('Invoke'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('State changes: ${_toggle.stateChanges}'),
            Text('Invocations:   ${_toggle.invocationCount}'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: _stateTransitions.isEmpty
                  ? const Text('(no transitions yet)')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _stateTransitions
                          .map(
                            (t) => Text(
                              t,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 6. Undo / Redo coordinator
// =====================================================================

class _UndoRedoSection extends StatefulWidget {
  const _UndoRedoSection();

  @override
  State<_UndoRedoSection> createState() => _UndoRedoSectionState();
}

class _UndoRedoSectionState extends State<_UndoRedoSection> {
  final List<String> _stack = <String>[];
  final List<String> _redoStack = <String>[];
  late final _UndoAction _undo;
  late final _RedoAction _redo;
  final List<_HistoryChip> _history = <_HistoryChip>[];
  int _seq = 1;

  @override
  void initState() {
    super.initState();
    _undo = _UndoAction(_stack, _redoStack);
    _redo = _RedoAction(_stack, _redoStack);
  }

  void _push() {
    final v = 'edit#$_seq';
    _seq++;
    _stack.add(v);
    _redoStack.clear();
    setState(() {
      _history.add(_HistoryChip(label: v, kind: _HistoryKind.push));
    });
  }

  void _onUndo(Action<Intent> action) {
    final u = action as _UndoAction;
    if (u.lastUndo != null) {
      setState(() {
        _history.add(
          _HistoryChip(label: 'undo ${u.lastUndo}', kind: _HistoryKind.undo),
        );
      });
    } else {
      setState(() {});
    }
  }

  void _onRedo(Action<Intent> action) {
    final r = action as _RedoAction;
    if (r.lastRedo != null) {
      setState(() {
        _history.add(
          _HistoryChip(label: 'redo ${r.lastRedo}', kind: _HistoryKind.redo),
        );
      });
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Push edits and then undo/redo. Two ActionListeners watch the '
            'undo and redo Actions; they coordinate to build the visible '
            'history below as a horizontal Wrap of chips.',
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Push edit'),
                onPressed: _push,
              ),
              const SizedBox(width: 8),
              ActionListener(
                action: _undo,
                listener: _onUndo,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.undo),
                  label: const Text('Undo'),
                  onPressed: _undo.isEnabled(const _UndoIntent())
                      ? () => _undo.invoke(const _UndoIntent())
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              ActionListener(
                action: _redo,
                listener: _onRedo,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.redo),
                  label: const Text('Redo'),
                  onPressed: _redo.isEnabled(const _RedoIntent())
                      ? () => _redo.invoke(const _RedoIntent())
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Text('stack: ${_stack.length}, redo: ${_redoStack.length}'),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _history.isEmpty
                ? const Text('(no history)')
                : Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: _history
                        .map(
                          (h) => Chip(
                            label: Text(h.label),
                            backgroundColor: switch (h.kind) {
                              _HistoryKind.push => Colors.green.shade100,
                              _HistoryKind.undo => Colors.orange.shade100,
                              _HistoryKind.redo => Colors.blue.shade100,
                            },
                            avatar: Icon(
                              switch (h.kind) {
                                _HistoryKind.push => Icons.add,
                                _HistoryKind.undo => Icons.undo,
                                _HistoryKind.redo => Icons.redo,
                              },
                              size: 14,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

enum _HistoryKind { push, undo, redo }

class _HistoryChip {
  _HistoryChip({required this.label, required this.kind});
  final String label;
  final _HistoryKind kind;
}

// =====================================================================
// 7. Telemetry collector pattern
// =====================================================================

class _TelemetrySection extends StatefulWidget {
  const _TelemetrySection();

  @override
  State<_TelemetrySection> createState() => _TelemetrySectionState();
}

class _TelemetrySectionState extends State<_TelemetrySection> {
  late final _TelemetryAction _telemetry;
  int _totalFires = 0;

  @override
  void initState() {
    super.initState();
    _telemetry = _TelemetryAction();
  }

  void _onTelemetry(Action<Intent> action) {
    setState(() {
      _totalFires++;
    });
  }

  void _fire(String evt) {
    _telemetry.invoke(_TelemetryIntent(evt));
  }

  @override
  Widget build(BuildContext context) {
    final entries = _telemetry.counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maxCount = entries.isEmpty
        ? 1
        : entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return _CardShell(
      child: ActionListener(
        action: _telemetry,
        listener: _onTelemetry,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'A single ActionListener serves as a telemetry collector. '
              'Each invocation increments a per-event count; the chart '
              'below visualizes those counts as horizontal bars.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _fire('open_dialog'),
                  child: const Text('open_dialog'),
                ),
                ElevatedButton(
                  onPressed: () => _fire('close_dialog'),
                  child: const Text('close_dialog'),
                ),
                ElevatedButton(
                  onPressed: () => _fire('save_doc'),
                  child: const Text('save_doc'),
                ),
                ElevatedButton(
                  onPressed: () => _fire('export_pdf'),
                  child: const Text('export_pdf'),
                ),
                ElevatedButton(
                  onPressed: () => _fire('refresh'),
                  child: const Text('refresh'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Total fires: $_totalFires'),
            const SizedBox(height: 12),
            if (entries.isEmpty)
              const Text(
                '(no telemetry yet — click an event)',
                style: TextStyle(fontStyle: FontStyle.italic),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: entries
                    .map((e) => _BarRow(
                          label: e.key,
                          count: e.value,
                          maxCount: maxCount,
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  const _BarRow({
    required this.label,
    required this.count,
    required this.maxCount,
  });
  final String label;
  final int count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final ratio = maxCount == 0 ? 0.0 : count / maxCount;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: ratio.clamp(0.0, 1.0),
                  child: Container(
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text(
              '$count',
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 8. SnackBar pattern
// =====================================================================

class _SnackBarSection extends StatefulWidget {
  const _SnackBarSection();

  @override
  State<_SnackBarSection> createState() => _SnackBarSectionState();
}

class _SnackBarSectionState extends State<_SnackBarSection> {
  late final _SnackAction _snack;
  int _shown = 0;

  @override
  void initState() {
    super.initState();
    _snack = _SnackAction();
  }

  void _onSnack(Action<Intent> action) {
    final s = action as _SnackAction;
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(s.lastMessage),
          duration: const Duration(seconds: 1),
        ),
      );
    }
    setState(() {
      _shown++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: ActionListener(
        action: _snack,
        listener: _onSnack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Each button invokes the same Action with a different '
              'message. The ActionListener shows a SnackBar in response '
              'to every invocation.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Saved'),
                  onPressed: () =>
                      _snack.invoke(const _SnackIntent('Document saved')),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Deleted'),
                  onPressed: () =>
                      _snack.invoke(const _SnackIntent('Item deleted')),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('Shared'),
                  onPressed: () =>
                      _snack.invoke(const _SnackIntent('Link copied')),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.star),
                  label: const Text('Starred'),
                  onPressed: () =>
                      _snack.invoke(const _SnackIntent('Starred ★')),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('SnackBars shown: $_shown'),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 9. Recipe gallery
// =====================================================================

class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Four miniature working examples that combine the patterns '
            'shown above. Each is its own self-contained mini-demo.',
          ),
          SizedBox(height: 12),
          _RecipeCardSaveSnack(),
          SizedBox(height: 12),
          _RecipeCardShortcutAudit(),
          SizedBox(height: 12),
          _RecipeCardEnableObserver(),
          SizedBox(height: 12),
          _RecipeCardUndoRedoCoordinator(),
        ],
      ),
    );
  }
}

class _RecipeCardSaveSnack extends StatefulWidget {
  const _RecipeCardSaveSnack();

  @override
  State<_RecipeCardSaveSnack> createState() => _RecipeCardSaveSnackState();
}

class _RecipeCardSaveSnackState extends State<_RecipeCardSaveSnack> {
  late final _SaveAction _save;

  @override
  void initState() {
    super.initState();
    _save = _SaveAction();
  }

  void _onSave(Action<Intent> action) {
    final s = action as _SaveAction;
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.hideCurrentSnackBar();
    messenger?.showSnackBar(
      SnackBar(
        content: Text('Saved (#${s.saveCount})'),
        duration: const Duration(milliseconds: 800),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: ActionListener(
        action: _save,
        listener: _onSave,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recipe 1: Save action with ActionListener for SnackBar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _save.invoke(const _SaveIntent()),
                  child: const Text('Save'),
                ),
                const SizedBox(width: 8),
                Text('Saves: ${_save.saveCount}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeCardShortcutAudit extends StatefulWidget {
  const _RecipeCardShortcutAudit();

  @override
  State<_RecipeCardShortcutAudit> createState() =>
      _RecipeCardShortcutAuditState();
}

class _RecipeCardShortcutAuditState extends State<_RecipeCardShortcutAudit> {
  late final _GreetAction _greet;
  final FocusNode _node = FocusNode(debugLabel: 'recipeShortcut');
  final List<String> _audit = <String>[];

  @override
  void initState() {
    super.initState();
    _greet = _GreetAction();
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void _onGreet(Action<Intent> action) {
    final g = action as _GreetAction;
    setState(() {
      _audit.insert(0, 'audit: greet #${g.invocationCount} -> ${g.lastName}');
      if (_audit.length > 4) _audit.removeRange(4, _audit.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.keyG, control: true):
              _GreetIntent('keyboard'),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _GreetIntent: _greet,
          },
          child: ActionListener(
            action: _greet,
            listener: _onGreet,
            child: Focus(
              focusNode: _node,
              child: GestureDetector(
                onTap: () => _node.requestFocus(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Recipe 2: Shortcut audit log',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _node.hasFocus
                          ? 'Focused — press Ctrl+G or click "Greet"'
                          : 'Click here to focus, then press Ctrl+G',
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () =>
                              _greet.invoke(const _GreetIntent('button')),
                          child: const Text('Greet'),
                        ),
                        const SizedBox(width: 8),
                        Text('count: ${_greet.invocationCount}'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (_audit.isEmpty)
                      const Text('(audit log empty)')
                    else
                      ..._audit.map(
                        (l) => Text(
                          l,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RecipeCardEnableObserver extends StatefulWidget {
  const _RecipeCardEnableObserver();

  @override
  State<_RecipeCardEnableObserver> createState() =>
      _RecipeCardEnableObserverState();
}

class _RecipeCardEnableObserverState extends State<_RecipeCardEnableObserver> {
  late final _ToggleableAction _action;
  String _status = 'enabled';

  @override
  void initState() {
    super.initState();
    _action = _ToggleableAction();
  }

  void _onChange(Action<Intent> action) {
    final t = action as _ToggleableAction;
    setState(() {
      _status =
          t.isEnabled(const _GreetIntent('x')) ? 'enabled' : 'disabled';
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabled = _action.isEnabled(const _GreetIntent('x'));
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade400),
      ),
      child: ActionListener(
        action: _action,
        listener: _onChange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recipe 3: Action enable/disable observer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: <Widget>[
                Switch(
                  value: enabled,
                  onChanged: (v) => _action.setEnabled(v),
                ),
                const SizedBox(width: 8),
                Text(
                  'observed status: $_status',
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ],
            ),
            Text('state changes: ${_action.stateChanges}'),
          ],
        ),
      ),
    );
  }
}

class _RecipeCardUndoRedoCoordinator extends StatefulWidget {
  const _RecipeCardUndoRedoCoordinator();

  @override
  State<_RecipeCardUndoRedoCoordinator> createState() =>
      _RecipeCardUndoRedoCoordinatorState();
}

class _RecipeCardUndoRedoCoordinatorState
    extends State<_RecipeCardUndoRedoCoordinator> {
  final List<String> _stack = <String>[];
  final List<String> _redoStack = <String>[];
  late final _UndoAction _undo;
  late final _RedoAction _redo;
  String _lastEffect = '—';
  int _seq = 1;

  @override
  void initState() {
    super.initState();
    _undo = _UndoAction(_stack, _redoStack);
    _redo = _RedoAction(_stack, _redoStack);
  }

  void _onUndo(Action<Intent> action) {
    final u = action as _UndoAction;
    setState(() {
      _lastEffect = u.lastUndo == null
          ? 'undo (no-op)'
          : 'undo: ${u.lastUndo}';
    });
  }

  void _onRedo(Action<Intent> action) {
    final r = action as _RedoAction;
    setState(() {
      _lastEffect = r.lastRedo == null
          ? 'redo (no-op)'
          : 'redo: ${r.lastRedo}';
    });
  }

  void _push() {
    setState(() {
      _stack.add('e$_seq');
      _seq++;
      _redoStack.clear();
      _lastEffect = 'pushed e${_seq - 1}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Recipe 4: Undo/Redo coordinator',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: _push,
                child: const Text('Push edit'),
              ),
              const SizedBox(width: 8),
              ActionListener(
                action: _undo,
                listener: _onUndo,
                child: ElevatedButton(
                  onPressed: _undo.isEnabled(const _UndoIntent())
                      ? () => _undo.invoke(const _UndoIntent())
                      : null,
                  child: const Text('Undo'),
                ),
              ),
              const SizedBox(width: 8),
              ActionListener(
                action: _redo,
                listener: _onRedo,
                child: ElevatedButton(
                  onPressed: _redo.isEnabled(const _RedoIntent())
                      ? () => _redo.invoke(const _RedoIntent())
                      : null,
                  child: const Text('Redo'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('stack: ${_stack.join(', ')}'),
          Text('redo:  ${_redoStack.join(', ')}'),
          Text(
            'last effect: $_lastEffect',
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 10. Reference table
// =====================================================================

class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Related types in the Flutter Actions/Intents system:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
            },
            border: TableBorder.all(color: Colors.grey.shade400),
            children: const <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
                children: <Widget>[
                  _Cell('Type', bold: true),
                  _Cell('Description', bold: true),
                ],
              ),
              TableRow(children: <Widget>[
                _Cell('Intent'),
                _Cell(
                  'Marker class describing a desired operation. Carries '
                  'parameters as fields. Subclassed for each user '
                  '"intention".',
                ),
              ]),
              TableRow(children: <Widget>[
                _Cell('Action'),
                _Cell(
                  'Performs the work for an Intent. Defines invoke(), '
                  'isEnabled(), and notifies ActionListeners.',
                ),
              ]),
              TableRow(children: <Widget>[
                _Cell('Actions'),
                _Cell(
                  'InheritedWidget that maps Intent types to Action '
                  'instances for descendants.',
                ),
              ]),
              TableRow(children: <Widget>[
                _Cell('Shortcuts'),
                _Cell(
                  'InheritedWidget that maps key combinations to Intents. '
                  'Pairs with Actions for keyboard-driven dispatch.',
                ),
              ]),
              TableRow(children: <Widget>[
                _Cell('ActionListener'),
                _Cell(
                  'Subscribes to an Action; calls onAction whenever the '
                  'Action notifies listeners (invoke or state change).',
                ),
              ]),
              TableRow(children: <Widget>[
                _Cell('ActionDispatcher'),
                _Cell(
                  'Dispatches an Intent to an Action. Custom dispatchers '
                  'allow logging, filtering, or async coordination.',
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell(this.text, {this.bold = false});
  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'monospace',
          fontSize: 13,
        ),
      ),
    );
  }
}

// =====================================================================
// Footer
// =====================================================================

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tips',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          _Bullet(
              'Always call notifyActionListeners() in custom Action.invoke '
              'to wake up subscribers.'),
          _Bullet(
              'ActionListener auto-subscribes on mount and unsubscribes '
              'on dispose — that lifecycle is the whole point.'),
          _Bullet(
              'Multiple ActionListeners can listen to the same Action '
              'concurrently and independently.'),
          _Bullet(
              'Use ActionListener for cross-cutting concerns: telemetry, '
              'snackbars, audit logs, undo history, animations.'),
        ],
      ),
    );
  }
}
