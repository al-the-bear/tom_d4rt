// D4rt test script: Deep Visual Demo — RedoTextIntent / UndoTextIntent
// Demonstrates the undo/redo text-intent system: live TextField, history
// visualisation, keyboard-shortcut wiring, custom actions, diagrams, and
// a comprehensive API cheat sheet.
import 'package:flutter/material.dart';

// ============================================================
// Top-level state (STATELESS design via ValueNotifiers)
// ============================================================

final ValueNotifier<String> _liveText =
    ValueNotifier<String>('Type here to see undo/redo in action…');

final ValueNotifier<List<String>> _history = ValueNotifier<List<String>>([
  '',
  'H',
  'He',
  'Hel',
  'Hell',
  'Hello',
  'Hello ',
  'Hello W',
  'Hello Wo',
  'Hello Wor',
  'Hello Worl',
  'Hello World',
]);

final ValueNotifier<int> _cursor = ValueNotifier<int>(11);

// ============================================================
// Entry point
// ============================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
      ),
    ),
    home: const _RedoTextIntentDemoRoot(),
  );
}

// ============================================================
// Root scaffold — 9 tabs
// ============================================================

class _RedoTextIntentDemoRoot extends StatelessWidget {
  const _RedoTextIntentDemoRoot();

  static const List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.info_outline), text: 'Hero'),
    Tab(icon: Icon(Icons.edit), text: 'Live Demo'),
    Tab(icon: Icon(Icons.history), text: 'History'),
    Tab(icon: Icon(Icons.keyboard), text: 'Shortcuts'),
    Tab(icon: Icon(Icons.tune), text: 'Custom'),
    Tab(icon: Icon(Icons.compare_arrows), text: 'Comparison'),
    Tab(icon: Icon(Icons.account_tree), text: 'Diagram'),
    Tab(icon: Icon(Icons.adjust), text: 'Cause'),
    Tab(icon: Icon(Icons.warning_amber_rounded), text: 'Pitfalls'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RedoTextIntent / UndoTextIntent — Deep Demo'),
          centerTitle: false,
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _LiveDemoTab(),
            _HistoryVisualisationTab(),
            _KeyboardShortcutTab(),
            _CustomActionsTab(),
            _IntentComparisonTab(),
            _DiagramTab(),
            _SelectionChangedCauseTab(),
            _PitfallsTab(),
          ],
        ),
        bottomNavigationBar: const _CheatSheetFooter(),
      ),
    );
  }
}

// ============================================================
// Shared helpers
// ============================================================

Widget _sectionHeader(BuildContext context, String title, IconData icon) {
  final cs = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: <Widget>[
        Icon(icon, color: cs.primary, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    ),
  );
}

Widget _monoBox(BuildContext context, String code) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cs.outlineVariant),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.55,
      ),
    ),
  );
}

Widget _infoCard(BuildContext context, String body, {Color? accent}) {
  final cs = Theme.of(context).colorScheme;
  final bg = accent?.withValues(alpha: 0.08) ?? cs.secondaryContainer.withValues(alpha: 0.45);
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: accent?.withValues(alpha: 0.3) ?? cs.outlineVariant,
      ),
    ),
    child: Text(body, style: Theme.of(context).textTheme.bodyMedium),
  );
}

// ============================================================
// Tab 1 — Hero Banner
// ============================================================

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        // Hero gradient card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                cs.primary,
                cs.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.undo, color: cs.onPrimary, size: 36),
                  const SizedBox(width: 10),
                  Icon(Icons.redo, color: cs.onPrimary, size: 36),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'RedoTextIntent & UndoTextIntent',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Flutter\'s undo/redo system for text editing — powered by '
                'the Intent/Action architecture and baked directly into '
                'TextField via DefaultTextEditingShortcuts.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: cs.onPrimary.withValues(alpha: 0.9)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        _sectionHeader(context, 'What are these Intents?', Icons.lightbulb_outline),
        _infoCard(
          context,
          'UndoTextIntent — dispatched when the user presses Ctrl+Z (Windows/Linux) '
          'or Cmd+Z (macOS). It signals "please undo the most recent text change" '
          'on the currently focused editable widget.\n\n'
          'RedoTextIntent — dispatched when the user presses Ctrl+Y (Windows/Linux) '
          'or Cmd+Shift+Z (macOS). It signals "please redo the last undone change".',
        ),
        const SizedBox(height: 16),

        _sectionHeader(context, 'How the System Fits Together', Icons.account_tree),
        _infoCard(
          context,
          'Both intents extend Intent and carry a SelectionChangedCause '
          'parameter that explains why the selection changed (keyboard, tap, '
          'toolbar, etc.).\n\n'
          'They are handled by UndoTextAction and RedoTextAction respectively, '
          'which call TextEditingController.undo() and .redo() on the active '
          'text field.',
          accent: cs.tertiary,
        ),
        const SizedBox(height: 16),

        _sectionHeader(context, 'Class Hierarchy', Icons.schema),
        _monoBox(
          context,
          '''Object
 └─ Intent
     ├─ UndoTextIntent        // Ctrl+Z / Cmd+Z
     └─ RedoTextIntent        // Ctrl+Y / Cmd+Shift+Z

Object
 └─ Action<UndoTextIntent>
     └─ UndoTextAction        // calls controller.undo()

Object
 └─ Action<RedoTextIntent>
     └─ RedoTextAction        // calls controller.redo()''',
        ),
        const SizedBox(height: 16),

        _sectionHeader(context, 'Availability', Icons.info),
        _infoCard(
          context,
          'Both intents and their actions are registered globally by '
          'EditableText (the low-level widget behind TextField) via '
          'DefaultTextEditingActions. You do not need to wire anything '
          'manually inside a standard TextField — it just works.',
          accent: cs.primary,
        ),
        const SizedBox(height: 16),

        _sectionHeader(context, 'This Demo Covers', Icons.list),
        ...<String>[
          '1. Live TextField with manual Undo/Redo buttons',
          '2. Simulated history stack with timeline visualisation',
          '3. Keyboard shortcut wiring and intent dispatch explanation',
          '4. Custom CallbackAction that intercepts UndoTextIntent',
          '5. Intent comparison table across text-editing intents',
          '6. CustomPainter diagram of the dispatch pipeline',
          '7. SelectionChangedCause values and their meanings',
          '8. Common pitfalls and gotchas',
          '9. Full API cheat sheet in the app bar footer',
        ].map(
          (s) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.check_circle_outline,
                    size: 18, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(s,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ============================================================
// Tab 2 — Live Demo
// ============================================================

class _LiveDemoTab extends StatelessWidget {
  const _LiveDemoTab();

  // A GlobalKey so we can look up the EditableText context when invoking.
  static final GlobalKey<EditableTextState> _editKey =
      GlobalKey<EditableTextState>();

  static final TextEditingController _ctrl =
      TextEditingController(text: 'Hello World');

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _sectionHeader(context, 'Live TextField — Undo & Redo', Icons.edit),
        _infoCard(
          context,
          'Type in the field below. The "Undo" and "Redo" buttons invoke '
          'UndoTextIntent / RedoTextIntent programmatically against the '
          'TextField\'s EditableText context.',
        ),
        const SizedBox(height: 16),

        // The TextField itself
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Editable Field',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: cs.primary,
                        )),
                const SizedBox(height: 8),
                EditableText(
                  key: _editKey,
                  controller: _ctrl,
                  focusNode: FocusNode(),
                  style: Theme.of(context).textTheme.bodyLarge ??
                      const TextStyle(fontSize: 16),
                  cursorColor: cs.primary,
                  backgroundCursorColor: cs.surface,
                  onChanged: (v) => _liveText.value = v,
                ),
                const Divider(height: 24),
                // Undo / Redo buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FilledButton.icon(
                      onPressed: () {
                        final ctx = _editKey.currentContext;
                        if (ctx != null) {
                          Actions.invoke(
                            ctx,
                            const UndoTextIntent(
                              SelectionChangedCause.keyboard,
                            ),
                          );
                          _liveText.value = _ctrl.text;
                        }
                      },
                      icon: const Icon(Icons.undo),
                      label: const Text('Undo'),
                    ),
                    const SizedBox(width: 16),
                    FilledButton.icon(
                      onPressed: () {
                        final ctx = _editKey.currentContext;
                        if (ctx != null) {
                          Actions.invoke(
                            ctx,
                            const RedoTextIntent(
                              SelectionChangedCause.keyboard,
                            ),
                          );
                          _liveText.value = _ctrl.text;
                        }
                      },
                      icon: const Icon(Icons.redo),
                      label: const Text('Redo'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Live text display
        _sectionHeader(context, 'Current Controller Text', Icons.visibility),
        ValueListenableBuilder<String>(
          valueListenable: _liveText,
          builder: (_, val, ignored) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '"$val"',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: cs.onPrimaryContainer,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        _sectionHeader(
            context, 'How the Invocation Works', Icons.code),
        _monoBox(
          context,
          '''// Invoke undo programmatically:
Actions.invoke(
  context,           // must be inside the action's scope
  const UndoTextIntent(SelectionChangedCause.keyboard),
);

// Invoke redo programmatically:
Actions.invoke(
  context,
  const RedoTextIntent(SelectionChangedCause.keyboard),
);''',
        ),
        const SizedBox(height: 16),
        _infoCard(
          context,
          'Important: the context passed to Actions.invoke must be a '
          'descendant of the widget that registered UndoTextAction — '
          'usually the EditableText or TextField itself. Using an unrelated '
          'context will find no matching action and silently do nothing.',
          accent: cs.error,
        ),
        const SizedBox(height: 20),

        _sectionHeader(
            context, 'TextField (simpler) vs EditableText', Icons.compare),
        _monoBox(
          context,
          '''// With a plain TextField + focusNode key:
//   Press Ctrl+Z in the field → auto handled by DefaultTextEditingShortcuts
//   Press Ctrl+Y in the field → auto handled

// Programmatic equivalent via controller (no context needed):
controller.undo();   // same effect as UndoTextIntent
controller.redo();   // same effect as RedoTextIntent''',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ============================================================
// Tab 3 — History Visualisation
// ============================================================

class _HistoryVisualisationTab extends StatelessWidget {
  const _HistoryVisualisationTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _sectionHeader(
            context, 'Simulated History Stack', Icons.history),
        _infoCard(
          context,
          'The undo/redo system maintains two implicit stacks: past states '
          '(undo stack) and future states (redo stack). The cursor shows the '
          'current position. Use the buttons to walk through the simulated '
          'history below.',
        ),
        const SizedBox(height: 16),

        // History navigation buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: () {
                if (_cursor.value > 0) {
                  _cursor.value = _cursor.value - 1;
                }
              },
              icon: const Icon(Icons.undo),
              label: const Text('Step Undo'),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () {
                if (_cursor.value < _history.value.length - 1) {
                  _cursor.value = _cursor.value + 1;
                }
              },
              icon: const Icon(Icons.redo),
              label: const Text('Step Redo'),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                _cursor.value = _history.value.length - 1;
              },
              child: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Timeline card
        ValueListenableBuilder<int>(
          valueListenable: _cursor,
          builder: (ctx, cur, ignored) {
            return ValueListenableBuilder<List<String>>(
              valueListenable: _history,
              builder: (_, hist, ignored2) {
                return _HistoryTimeline(history: hist, cursor: cur);
              },
            );
          },
        ),
        const SizedBox(height: 20),

        // Current state display
        ValueListenableBuilder<int>(
          valueListenable: _cursor,
          builder: (_, cur, ignored) {
            final text = _history.value[cur];
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Current text at position $cur:',
                    style:
                        Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: cs.onPrimaryContainer,
                            ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    text.isEmpty ? '(empty)' : '"$text"',
                    style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: cs.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      _stackBadge(
                          context, 'Undo stack: $cur', cs.secondary),
                      const SizedBox(width: 8),
                      _stackBadge(
                        context,
                        'Redo stack: ${_history.value.length - 1 - cur}',
                        cs.tertiary,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Stack Semantics', Icons.layers),
        _infoCard(
          context,
          '• Undo pops from the undo stack → moves state back by one step.\n'
          '• Redo pops from the redo stack → moves state forward.\n'
          '• Typing new text clears the redo stack — future states are lost.\n'
          '• Flutter\'s UndoHistory widget manages this automatically for EditableText.',
          accent: cs.secondary,
        ),
        const SizedBox(height: 16),

        _sectionHeader(context, 'UndoHistory Widget', Icons.widgets),
        _monoBox(
          context,
          '''// Flutter exposes undo/redo history via:
class UndoHistory<T> extends StatefulWidget {
  const UndoHistory({
    required this.value,
    required this.onTriggered,
    required this.focusNode,
    required this.controller,
    required this.child,
    ...
  });
}

// EditableText registers its own UndoHistory internally.
// You rarely need to use UndoHistory directly.''',
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _stackBadge(BuildContext ctx, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// -------- History Timeline widget --------

class _HistoryTimeline extends StatelessWidget {
  const _HistoryTimeline({required this.history, required this.cursor});

  final List<String> history;
  final int cursor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'History Timeline',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: cs.primary,
                  ),
            ),
            const SizedBox(height: 14),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(history.length, (i) {
                  final isCurrent = i == cursor;
                  final isPast = i < cursor;
                  final label = history[i].isEmpty ? '∅' : history[i];
                  return Row(
                    children: <Widget>[
                      _TimelineNode(
                        label: label,
                        index: i,
                        isCurrent: isCurrent,
                        isPast: isPast,
                      ),
                      if (i < history.length - 1)
                        _TimelineArrow(
                          isPast: i < cursor,
                          isActive: i == cursor - 1,
                        ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                _Legend(color: cs.primary, label: 'Current'),
                const SizedBox(width: 12),
                _Legend(color: cs.secondary, label: 'Past (undo stack)'),
                const SizedBox(width: 12),
                _Legend(color: cs.outlineVariant, label: 'Future (redo stack)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({
    required this.label,
    required this.index,
    required this.isCurrent,
    required this.isPast,
  });

  final String label;
  final int index;
  final bool isCurrent;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = isCurrent
        ? cs.primary
        : isPast
            ? cs.secondary
            : cs.surfaceContainerHighest;
    final fg = isCurrent
        ? cs.onPrimary
        : isPast
            ? cs.onSecondary
            : cs.onSurfaceVariant;
    return Column(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            border: isCurrent
                ? Border.all(color: cs.onPrimary, width: 2.5)
                : null,
            boxShadow: isCurrent
                ? <BoxShadow>[
                    BoxShadow(
                      color: cs.primary.withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Text(
            '$index',
            style: TextStyle(
                color: fg, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        const SizedBox(height: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 52),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                color: isCurrent ? cs.primary : cs.outline),
          ),
        ),
      ],
    );
  }
}

class _TimelineArrow extends StatelessWidget {
  const _TimelineArrow({required this.isPast, required this.isActive});
  final bool isPast;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = isActive
        ? cs.primary
        : isPast
            ? cs.secondary.withValues(alpha: 0.5)
            : cs.outlineVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Icon(Icons.arrow_forward, size: 18, color: color),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label,
            style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

// ============================================================
// Tab 4 — Keyboard Shortcut Wiring
// ============================================================

class _KeyboardShortcutTab extends StatelessWidget {
  const _KeyboardShortcutTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _sectionHeader(
            context, 'DefaultTextEditingShortcuts', Icons.keyboard),
        _infoCard(
          context,
          'Flutter wraps every TextField (via EditableText) in a Shortcuts '
          'widget that maps physical key combinations to Intents. The '
          'mapping for undo/redo looks like this:',
        ),
        const SizedBox(height: 16),
        _monoBox(
          context,
          '''// From Flutter source (simplified):
// packages/flutter/lib/src/widgets/default_text_editing_shortcuts.dart

Map<ShortcutActivator, Intent> get _shortcuts => <ShortcutActivator, Intent>{
  // Undo
  const SingleActivator(LogicalKeyboardKey.keyZ,
      control: true):            // Ctrl+Z  (Linux/Windows)
    const UndoTextIntent(SelectionChangedCause.keyboard),
  const SingleActivator(LogicalKeyboardKey.keyZ,
      meta: true):               // Cmd+Z   (macOS)
    const UndoTextIntent(SelectionChangedCause.keyboard),

  // Redo
  const SingleActivator(LogicalKeyboardKey.keyZ,
      control: true, shift: true):  // Ctrl+Shift+Z
    const RedoTextIntent(SelectionChangedCause.keyboard),
  const SingleActivator(LogicalKeyboardKey.keyY,
      control: true):               // Ctrl+Y  (Windows/Linux)
    const RedoTextIntent(SelectionChangedCause.keyboard),
  const SingleActivator(LogicalKeyboardKey.keyZ,
      meta: true, shift: true):     // Cmd+Shift+Z  (macOS)
    const RedoTextIntent(SelectionChangedCause.keyboard),
};''',
        ),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Shortcut → Intent → Action', Icons.route),
        _infoCard(
          context,
          'The dispatch pipeline:\n'
          '1. User presses Ctrl+Z\n'
          '2. Shortcuts widget matches SingleActivator → creates UndoTextIntent\n'
          '3. Actions widget walks up the tree to find UndoTextAction\n'
          '4. UndoTextAction.invoke() calls controller.undo()\n'
          '5. EditableText rebuilds with the previous text',
          accent: cs.primary,
        ),
        const SizedBox(height: 16),

        _sectionHeader(context, 'Keyboard Shortcut Reference', Icons.table_chart),
        _ShortcutTable(),
        const SizedBox(height: 20),

        _sectionHeader(
            context, 'How to Override a Shortcut', Icons.build_circle),
        _monoBox(
          context,
          '''// Wrap your widget in a Shortcuts widget to override:
Shortcuts(
  shortcuts: <ShortcutActivator, Intent>{
    const SingleActivator(
      LogicalKeyboardKey.keyZ,
      control: true,
    ): const UndoTextIntent(SelectionChangedCause.keyboard),
  },
  child: Actions(
    actions: <Type, Action<Intent>>{
      UndoTextIntent: CallbackAction<UndoTextIntent>(
        onInvoke: (UndoTextIntent intent) {
          myCustomUndo();
          return null;
        },
      ),
    },
    child: myWidget,
  ),
)''',
        ),
        const SizedBox(height: 20),

        _sectionHeader(
            context, 'Intent Routing Clarification', Icons.help_outline),
        _infoCard(
          context,
          'The Shortcuts widget is responsible only for converting key events '
          'into Intents. The actual work is done by an Action, which is '
          'separate and looked up via the Actions.invoke() mechanism. '
          'This separation lets you remap shortcuts without changing actions, '
          'or swap actions without changing shortcuts.',
          accent: cs.tertiary,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _ShortcutTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const rows = <List<String>>[
      ['Ctrl+Z', 'Windows / Linux', 'UndoTextIntent'],
      ['Cmd+Z', 'macOS', 'UndoTextIntent'],
      ['Ctrl+Y', 'Windows / Linux', 'RedoTextIntent'],
      ['Ctrl+Shift+Z', 'Windows / Linux', 'RedoTextIntent'],
      ['Cmd+Shift+Z', 'macOS', 'RedoTextIntent'],
    ];
    return Card(
      elevation: 1,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            color: cs.primaryContainer,
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Key', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onPrimaryContainer))),
                Expanded(child: Text('Platform', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onPrimaryContainer))),
                Expanded(child: Text('Intent', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onPrimaryContainer))),
              ],
            ),
          ),
          ...rows.map((r) => Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: cs.outlineVariant)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(r[0],
                            style: const TextStyle(
                                fontFamily: 'monospace', fontSize: 12))),
                    Expanded(
                        child:
                            Text(r[1], style: Theme.of(context).textTheme.bodySmall)),
                    Expanded(
                        child: Text(r[2],
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: cs.primary))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ============================================================
// Tab 5 — Custom Undo/Redo Actions
// ============================================================

class _CustomActionsTab extends StatelessWidget {
  const _CustomActionsTab();

  static final ValueNotifier<List<Color>> _paletteNotifier =
      ValueNotifier<List<Color>>([
    const Color(0xFF6750A4),
    const Color(0xFF625B71),
    const Color(0xFF7D5260),
  ]);

  static final ValueNotifier<List<List<Color>>> _paletteUndo =
      ValueNotifier<List<List<Color>>>([]);

  static final ValueNotifier<List<List<Color>>> _paletteRedo =
      ValueNotifier<List<List<Color>>>([]);

  static const List<Color> _availableColors = <Color>[
    Color(0xFFE53935),
    Color(0xFF8E24AA),
    Color(0xFF1E88E5),
    Color(0xFF00897B),
    Color(0xFFFB8C00),
    Color(0xFF6D4C41),
    Color(0xFF546E7A),
    Color(0xFF43A047),
  ];

  void _addColor(Color c) {
    final prev = List<Color>.from(_paletteNotifier.value);
    _paletteUndo.value = [..._paletteUndo.value, prev];
    _paletteRedo.value = [];
    _paletteNotifier.value = [..._paletteNotifier.value, c];
  }

  void _undoPalette() {
    final stack = _paletteUndo.value;
    if (stack.isEmpty) return;
    final prev = stack.last;
    _paletteRedo.value = [
      ..._paletteRedo.value,
      List<Color>.from(_paletteNotifier.value),
    ];
    _paletteUndo.value = stack.sublist(0, stack.length - 1);
    _paletteNotifier.value = prev;
  }

  void _redoPalette() {
    final stack = _paletteRedo.value;
    if (stack.isEmpty) return;
    final next = stack.last;
    _paletteUndo.value = [
      ..._paletteUndo.value,
      List<Color>.from(_paletteNotifier.value),
    ];
    _paletteRedo.value = stack.sublist(0, stack.length - 1);
    _paletteNotifier.value = next;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Actions(
      actions: <Type, Action<Intent>>{
        UndoTextIntent: CallbackAction<UndoTextIntent>(
          onInvoke: (_) {
            _undoPalette();
            return null;
          },
        ),
        RedoTextIntent: CallbackAction<RedoTextIntent>(
          onInvoke: (_) {
            _redoPalette();
            return null;
          },
        ),
      },
      child: Builder(
        builder: (ctx) => ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            _sectionHeader(
                ctx, 'Custom UndoTextIntent Action', Icons.tune),
            _infoCard(
              ctx,
              'This tab wraps its content in an Actions widget that provides '
              'a CallbackAction<UndoTextIntent> and CallbackAction<RedoTextIntent>. '
              'Instead of undoing text, these actions manipulate a simulated '
              'colour palette — demonstrating that any widget can intercept '
              'the standard undo/redo intents.',
            ),
            const SizedBox(height: 16),

            _monoBox(
              ctx,
              '''Actions(
  actions: <Type, Action<Intent>>{
    UndoTextIntent: CallbackAction<UndoTextIntent>(
      onInvoke: (_) { myUndo(); return null; },
    ),
    RedoTextIntent: CallbackAction<RedoTextIntent>(
      onInvoke: (_) { myRedo(); return null; },
    ),
  },
  child: yourCustomWidget,
)''',
            ),
            const SizedBox(height: 20),

            _sectionHeader(ctx, 'Colour Palette Editor', Icons.palette),
            _infoCard(
              ctx,
              'Tap a colour to add it. Use Undo/Redo to walk back through '
              'changes.',
              accent: cs.tertiary,
            ),
            const SizedBox(height: 12),

            // Colour picker
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _availableColors.map((c) {
                return GestureDetector(
                  onTap: () => _addColor(c),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: c.withValues(alpha: 0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Undo/Redo buttons
            Row(
              children: <Widget>[
                ValueListenableBuilder<List<List<Color>>>(
                  valueListenable: _paletteUndo,
                  builder: (_, stack, ignored) => OutlinedButton.icon(
                    onPressed: stack.isEmpty ? null : _undoPalette,
                    icon: const Icon(Icons.undo),
                    label: Text('Undo (${stack.length})'),
                  ),
                ),
                const SizedBox(width: 12),
                ValueListenableBuilder<List<List<Color>>>(
                  valueListenable: _paletteRedo,
                  builder: (_, stack, ignored) => OutlinedButton.icon(
                    onPressed: stack.isEmpty ? null : _redoPalette,
                    icon: const Icon(Icons.redo),
                    label: Text('Redo (${stack.length})'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current palette display
            ValueListenableBuilder<List<Color>>(
              valueListenable: _paletteNotifier,
              builder: (_, palette, ignored) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Current Palette (${palette.length} colours)',
                          style:
                              Theme.of(ctx).textTheme.labelLarge?.copyWith(
                                    color: cs.primary,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        palette.isEmpty
                            ? const Text('(empty)')
                            : Row(
                                children: palette
                                    .map(
                                      (c) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: c,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            _sectionHeader(ctx, 'Intercept vs Replace', Icons.compare_arrows),
            _infoCard(
              ctx,
              'When you provide a custom Action for UndoTextIntent inside '
              'an Actions widget, it shadows the default UndoTextAction '
              'registered by EditableText — but only within the subtree. '
              'Widgets outside this Actions widget still use the default '
              'text undo behaviour.\n\n'
              'To also run the default action, call Actions.maybeInvoke() '
              'from your custom action after your logic.',
              accent: cs.secondary,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Tab 6 — Intent Comparison Table
// ============================================================

class _IntentComparisonTab extends StatelessWidget {
  const _IntentComparisonTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _sectionHeader(
            context, 'Text Editing Intent Comparison', Icons.compare_arrows),
        _infoCard(
          context,
          'Flutter defines many text-editing intents. Here is a reference '
          'table of the most commonly used ones.',
        ),
        const SizedBox(height: 16),
        _IntentTable(),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Intent Constructor Signatures', Icons.code),
        _monoBox(
          context,
          '''// Selection-cause intents (take SelectionChangedCause):
const UndoTextIntent(SelectionChangedCause cause);
const RedoTextIntent(SelectionChangedCause cause);

// Zero-arg intents:
const CopySelectionTextIntent.copy();
const CutSelectionTextIntent.cut();
const PasteTextIntent(SelectionChangedCause cause);
const SelectAllTextIntent(SelectionChangedCause cause);

// Delete intents:
const DeleteCharacterIntent({required bool forward});
const DeleteToNextWordBoundaryIntent({required bool forward});
const DeleteToLineBreakIntent({required bool forward});

// Navigation intents:
const ExtendSelectionByCharacterIntent({
  required bool forward,
  required bool collapseSelection,
});
const MoveSelectionToStartTextIntent(SelectionChangedCause cause);
const MoveSelectionToEndTextIntent(SelectionChangedCause cause);''',
        ),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Common Usage Patterns', Icons.tips_and_updates),
        _monoBox(
          context,
          '''// Programmatic copy:
Actions.invoke(context, const CopySelectionTextIntent.copy());

// Programmatic select-all:
Actions.invoke(context, const SelectAllTextIntent(
  SelectionChangedCause.keyboard,
));

// Programmatic undo:
Actions.invoke(context, const UndoTextIntent(
  SelectionChangedCause.keyboard,
));

// Programmatic delete character (forward = Delete key):
Actions.invoke(context, const DeleteCharacterIntent(forward: true));''',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _IntentTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const rows = <List<String>>[
      ['UndoTextIntent', 'Ctrl+Z / Cmd+Z', 'UndoTextAction', 'controller.undo()'],
      ['RedoTextIntent', 'Ctrl+Y / Cmd+Shift+Z', 'RedoTextAction', 'controller.redo()'],
      ['CopySelectionTextIntent', 'Ctrl+C / Cmd+C', 'CopySelectionAction', 'Copy selection'],
      ['CutSelectionTextIntent', 'Ctrl+X / Cmd+X', 'CutSelectionAction', 'Cut selection'],
      ['PasteTextIntent', 'Ctrl+V / Cmd+V', 'PasteTextAction', 'Paste clipboard'],
      ['SelectAllTextIntent', 'Ctrl+A / Cmd+A', 'SelectAllTextAction', 'Select all text'],
      ['DeleteCharacterIntent', 'Backspace / Delete', 'DeleteTextAction', 'Delete one char'],
    ];
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Container(
              color: cs.primaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  _cell(context, 'Intent', 170, bold: true, color: cs.onPrimaryContainer),
                  _cell(context, 'Default Shortcut', 170, bold: true, color: cs.onPrimaryContainer),
                  _cell(context, 'Action Class', 160, bold: true, color: cs.onPrimaryContainer),
                  _cell(context, 'Effect', 130, bold: true, color: cs.onPrimaryContainer),
                ],
              ),
            ),
            ...rows.asMap().entries.map((e) {
              final r = e.value;
              final bg = e.key.isEven
                  ? Colors.transparent
                  : cs.surfaceContainerHighest.withValues(alpha: 0.35);
              return Container(
                color: bg,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    _cell(context, r[0], 170,
                        mono: true, color: cs.primary),
                    _cell(context, r[1], 170),
                    _cell(context, r[2], 160,
                        mono: true, color: cs.tertiary),
                    _cell(context, r[3], 130),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _cell(BuildContext context, String text, double width,
      {bool bold = false, bool mono = false, Color? color}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: mono ? 'monospace' : null,
          fontSize: mono ? 11 : 12.5,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
      ),
    );
  }
}

// ============================================================
// Tab 7 — Diagram (CustomPainter)
// ============================================================

class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _sectionHeader(context, 'Intent Dispatch Pipeline', Icons.account_tree),
        _infoCard(
          context,
          'The diagram below shows the full path from a keyboard shortcut '
          'to TextEditingController.undo().',
        ),
        const SizedBox(height: 16),

        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 420,
              child: CustomPaint(
                painter: _PipelinePainter(cs),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Step-by-Step Breakdown', Icons.format_list_numbered),
        ..._PipelineStep.steps.asMap().entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 14,
                  backgroundColor: cs.primary,
                  child: Text(
                    '${e.key + 1}',
                    style: TextStyle(
                        color: cs.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        e.value.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        e.value.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Redo Pipeline (Mirror)', Icons.redo),
        _monoBox(
          context,
          '''Ctrl+Y / Cmd+Shift+Z
  → SingleActivator matches in DefaultTextEditingShortcuts
  → RedoTextIntent(SelectionChangedCause.keyboard) created
  → Actions.invoke() dispatched up widget tree
  → RedoTextAction.invoke(RedoTextIntent) found
  → TextEditingController.redo() called
  → EditableText rebuilds with next text state''',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _PipelineStep {
  const _PipelineStep(this.title, this.description);
  final String title;
  final String description;

  static const List<_PipelineStep> steps = <_PipelineStep>[
    _PipelineStep(
      'User presses Ctrl+Z',
      'The hardware key event enters Flutter\'s keyboard handling pipeline.',
    ),
    _PipelineStep(
      'DefaultTextEditingShortcuts',
      'A Shortcuts widget (inserted by EditableText) maps the key combination '
      'to UndoTextIntent via a SingleActivator.',
    ),
    _PipelineStep(
      'UndoTextIntent created',
      'The intent carries SelectionChangedCause.keyboard to explain '
      'the trigger source.',
    ),
    _PipelineStep(
      'Actions.invoke() dispatch',
      'Flutter walks up the widget tree to find an Action registered for '
      'UndoTextIntent.',
    ),
    _PipelineStep(
      'UndoTextAction found',
      'Registered by EditableText via DefaultTextEditingActions, this '
      'action handles the intent.',
    ),
    _PipelineStep(
      'TextEditingController.undo()',
      'The action calls undo() on the active controller, reverting to the '
      'previous TextEditingValue.',
    ),
  ];
}

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter(this.cs);
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    const boxes = <String>[
      'Ctrl+Z\n(keyboard)',
      'DefaultTextEditing\nShortcuts',
      'UndoTextIntent\n(+cause)',
      'Actions\n.invoke()',
      'UndoText\nAction',
      'controller\n.undo()',
    ];

    final boxW = (size.width - 40) / boxes.length;
    const boxH = 70.0;
    final startY = size.height / 2 - boxH / 2;

    final bgPaint = Paint()..color = cs.primaryContainer;
    final borderPaint = Paint()
      ..color = cs.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final arrowPaint = Paint()
      ..color = cs.primary
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < boxes.length; i++) {
      final x = 20.0 + i * boxW;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 4, startY, boxW - 12, boxH),
        const Radius.circular(10),
      );
      canvas.drawRRect(rect, bgPaint);
      canvas.drawRRect(rect, borderPaint);

      // Label
      final tp = TextPainter(
        text: TextSpan(
          text: boxes[i],
          style: TextStyle(
              color: cs.onPrimaryContainer, fontSize: 10, height: 1.4),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 20);
      tp.paint(
        canvas,
        Offset(x + 4 + (boxW - 12) / 2 - tp.width / 2,
            startY + boxH / 2 - tp.height / 2),
      );

      // Arrow
      if (i < boxes.length - 1) {
        final arrowX = x + boxW - 4;
        final midY = startY + boxH / 2;
        canvas.drawLine(
            Offset(arrowX, midY), Offset(arrowX + 8, midY), arrowPaint);
        // arrowhead
        final path = Path()
          ..moveTo(arrowX + 8, midY - 5)
          ..lineTo(arrowX + 14, midY)
          ..lineTo(arrowX + 8, midY + 5)
          ..close();
        canvas.drawPath(path, arrowPaint..style = PaintingStyle.fill);
        arrowPaint.style = PaintingStyle.stroke;
      }
    }

    // Label below diagram
    final labelTp = TextPainter(
      text: TextSpan(
        text: 'UndoTextIntent dispatch pipeline — Ctrl+Z → controller.undo()',
        style: TextStyle(
            color: cs.outline, fontSize: 11, fontStyle: FontStyle.italic),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 40);
    labelTp.paint(
      canvas,
      Offset(20, startY + boxH + 16),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================
// Tab 8 — SelectionChangedCause
// ============================================================

class _SelectionChangedCauseTab extends StatelessWidget {
  const _SelectionChangedCauseTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _sectionHeader(
            context, 'SelectionChangedCause', Icons.adjust),
        _infoCard(
          context,
          'Both UndoTextIntent and RedoTextIntent carry a '
          'SelectionChangedCause parameter. This enum value tells the '
          'text editing system why the selection (or undo/redo) was triggered, '
          'enabling it to behave correctly for different input modalities.',
        ),
        const SizedBox(height: 16),

        _monoBox(
          context,
          '''enum SelectionChangedCause {
  tap,          // Single tap/click
  doubleTap,    // Double-tap to select a word
  longPress,    // Long-press selection handle
  forcePress,   // Force-touch (iOS)
  keyboard,     // Physical or on-screen keyboard shortcut
  toolBar,      // Selection toolbar (Cut/Copy/Paste bar)
  drag,         // Selection drag handle moved
  scribble,     // iPadOS Scribble input
}''',
        ),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Cause Reference Table', Icons.table_rows),
        _CauseTable(),
        const SizedBox(height: 20),

        _sectionHeader(context, 'Why It Matters for Undo/Redo', Icons.help),
        _infoCard(
          context,
          'The cause parameter allows the action to decide how to handle '
          'post-undo selection behaviour. For example:\n\n'
          '• keyboard → the text field may scroll to reveal the cursor.\n'
          '• toolBar  → selection toolbar may be re-positioned.\n\n'
          'In practice, passing SelectionChangedCause.keyboard is the '
          'correct choice when triggering undo/redo programmatically, '
          'as it matches the default intent created by the shortcut system.',
          accent: cs.primary,
        ),
        const SizedBox(height: 16),

        _sectionHeader(context, 'Accessing the Cause in a Custom Action', Icons.code),
        _monoBox(
          context,
          '''class MyUndoAction extends Action<UndoTextIntent> {
  @override
  Object? invoke(UndoTextIntent intent) {
    final SelectionChangedCause cause = intent.cause;

    switch (cause) {
      case SelectionChangedCause.keyboard:
        // handle keyboard undo
        break;
      case SelectionChangedCause.toolBar:
        // handle toolbar undo (e.g. "Undo" in context menu)
        break;
      default:
        break;
    }
    return null;
  }
}''',
        ),
        const SizedBox(height: 20),

        _sectionHeader(
            context, 'Constructor Signatures', Icons.construction),
        _monoBox(
          context,
          '''// UndoTextIntent
const UndoTextIntent(this.cause);
final SelectionChangedCause cause;

// RedoTextIntent
const RedoTextIntent(this.cause);
final SelectionChangedCause cause;

// Example usages:
const UndoTextIntent(SelectionChangedCause.keyboard)
const UndoTextIntent(SelectionChangedCause.toolBar)
const RedoTextIntent(SelectionChangedCause.keyboard)''',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _CauseTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const rows = <List<String>>[
      ['keyboard', 'Physical/virtual key shortcut (Ctrl+Z etc.)', 'Undo/Redo via shortcut'],
      ['toolBar', 'Selection toolbar action (context menu)', '"Undo" button in text toolbar'],
      ['tap', 'Single tap repositions cursor', 'Rare for undo/redo'],
      ['doubleTap', 'Double-tap selects word', 'Rare for undo/redo'],
      ['longPress', 'Long-press starts selection', 'Rare for undo/redo'],
      ['forcePress', 'Force-touch (iOS only)', 'iOS-specific'],
      ['drag', 'Selection handle dragged', 'Rare for undo/redo'],
      ['scribble', 'iPadOS Scribble handwriting', 'iPad Scribble input'],
    ];
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Container(
              color: cs.secondaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  _causeCell(context, 'Value', 120, bold: true, color: cs.onSecondaryContainer),
                  _causeCell(context, 'Triggered By', 200, bold: true, color: cs.onSecondaryContainer),
                  _causeCell(context, 'Undo/Redo Context', 180, bold: true, color: cs.onSecondaryContainer),
                ],
              ),
            ),
            ...rows.asMap().entries.map((e) {
              final r = e.value;
              final bg = e.key.isEven
                  ? Colors.transparent
                  : cs.surfaceContainerHighest.withValues(alpha: 0.35);
              return Container(
                color: bg,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    _causeCell(context, r[0], 120,
                        mono: true, color: cs.secondary),
                    _causeCell(context, r[1], 200),
                    _causeCell(context, r[2], 180,
                        color: cs.onSurfaceVariant),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _causeCell(BuildContext context, String text, double width,
      {bool bold = false, bool mono = false, Color? color}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: mono ? 'monospace' : null,
          fontSize: mono ? 11 : 12.5,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
      ),
    );
  }
}

// ============================================================
// Tab 9 — Pitfalls
// ============================================================

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _sectionHeader(
            context, 'Common Pitfalls', Icons.warning_amber_rounded),

        _Pitfall(
          index: 1,
          title: 'Undo only works when the TextField has focus',
          body:
              'UndoTextAction and RedoTextAction check if the target '
              'EditableText is focused before doing anything. If the field '
              'does not have focus, the intent is silently ignored.\n\n'
              'Fix: call FocusNode.requestFocus() before invoking the intent.',
          code:
              '''// Ensure focus before manual invocation:
_myFocusNode.requestFocus();
WidgetsBinding.instance.addPostFrameCallback((_) {
  Actions.invoke(
    _editableKey.currentContext!,
    const UndoTextIntent(SelectionChangedCause.keyboard),
  );
});''',
          color: cs.error,
        ),

        _Pitfall(
          index: 2,
          title: 'The redo stack is cleared on new text input',
          body:
              'Typing any new character clears the redo stack. This matches '
              'the behaviour of virtually every text editor. Once the redo '
              'stack is empty, RedoTextIntent has no effect.\n\n'
              'You cannot "redo" after the user has typed new text.',
          code: '''// Bad assumption:
controller.undo();
controller.undo();
// User types a character  ← redo stack is GONE
controller.redo(); // no-op''',
          color: cs.error,
        ),

        _Pitfall(
          index: 3,
          title: 'Calling undo/redo outside an action context',
          body:
              'If you call controller.undo() directly (bypassing the intent '
              'system), the side effects handled by UndoTextAction (such as '
              'scrolling the cursor into view and notifying the undo history) '
              'may not fire.\n\n'
              'Prefer Actions.invoke() with UndoTextIntent when possible.',
          code: '''// Acceptable but lower-level:
controller.undo();   // works, but skips action side-effects

// Preferred:
Actions.invoke(ctx, const UndoTextIntent(
  SelectionChangedCause.keyboard,
));''',
          color: cs.tertiary,
        ),

        _Pitfall(
          index: 4,
          title: 'Context passed to Actions.invoke must be in scope',
          body:
              'The context must be a descendant of the widget tree that '
              'contains the action. Passing a context from outside the '
              'Actions/Shortcuts subtree means Actions.maybeInvoke returns '
              'null and nothing happens.',
          code: '''// Wrong — using a context from an unrelated widget:
Actions.invoke(scaffoldContext, const UndoTextIntent(...));

// Right — use the EditableText's own context:
Actions.invoke(_editKey.currentContext!, const UndoTextIntent(...));''',
          color: cs.error,
        ),

        _Pitfall(
          index: 5,
          title: 'Not disposing TextEditingController',
          body:
              'TextEditingController holds undo history in memory. Always '
              'dispose it when the stateful widget (or top-level owner) is '
              'removed from the tree to avoid memory leaks.',
          code: '''@override
void dispose() {
  _controller.dispose(); // clears undo history + listeners
  super.dispose();
}''',
          color: cs.secondary,
        ),

        _Pitfall(
          index: 6,
          title: 'Undo granularity depends on typing speed',
          body:
              'Flutter\'s UndoHistory coalesces rapid keystrokes into single '
              'undo states. Slow typing may create a state per character; '
              'fast typing creates larger batches. The granularity is not '
              'configurable via public API.',
          code: '''// No direct control over undo granularity.
// Use UndoHistoryController for programmatic manipulation:
final undoController = UndoHistoryController();
// Then pass it to TextField:
TextField(undoController: undoController)''',
          color: cs.tertiary,
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _Pitfall extends StatelessWidget {
  const _Pitfall({
    required this.index,
    required this.title,
    required this.body,
    required this.code,
    required this.color,
  });

  final int index;
  final String title;
  final String body;
  final String code;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withValues(alpha: 0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: color,
                    child: Text(
                      '$index',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(body, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              _monoBox(context, code),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// Bottom Cheat Sheet (persistent footer / app-bar extension)
// ============================================================

class _CheatSheetFooter extends StatelessWidget {
  const _CheatSheetFooter();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            _cheatItem(context, 'UndoTextIntent', 'Ctrl+Z / Cmd+Z'),
            _divider(),
            _cheatItem(context, 'RedoTextIntent', 'Ctrl+Y / Cmd+Shift+Z'),
            _divider(),
            _cheatItem(context, 'cause:', 'SelectionChangedCause.keyboard'),
            _divider(),
            _cheatItem(context, 'Action:', 'UndoTextAction / RedoTextAction'),
            _divider(),
            _cheatItem(context, 'Effect:', 'controller.undo() / .redo()'),
          ],
        ),
      ),
    );
  }

  Widget _cheatItem(BuildContext context, String key, String value) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '$key ',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: cs.primary,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text('|',
          style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14)),
    );
  }
}
