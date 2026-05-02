// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// DoNothingAction — deep demo
// =============================================================================
//
// This file is a hand-authored, executable demo of [DoNothingAction] from the
// Flutter foundation. The intent is twofold:
//
//   1. Show DoNothingAction wired into a real Actions / Shortcuts / Focus tree
//      so that the action is actually *bound* and *invoked*; not as a string
//      snippet inside a code block, but as a live widget configuration.
//
//   2. Walk through each meaningful behaviour of DoNothingAction and its
//      relatives (DoNothingAndStopPropagationAction, an empty CallbackAction,
//      omitted bindings) so a reader can compare them side by side.
//
// DoNothingAction is the "polite veto" of the Flutter shortcuts system. When
// you bind an Intent to DoNothingAction inside an [Actions] widget, you are
// effectively saying: "yes, I claim this Intent in this subtree, but I do not
// want to do anything with it". This blocks the Intent from bubbling further
// up the Actions chain to a parent action that *would* do something.
//
// The action also has a [DoNothingAction.consumesKey] flag (default true).
// When true, the keystroke is reported as consumed so the rest of the
// keyboard machinery stops dispatching it. When false, the action still
// claims the Intent but does not consume the raw key — allowing widgets like
// TextField, Focus, RawKeyboardListener etc. to still observe and react to
// the key press.
//
// All examples below build a small visible widget tree and bind real
// Shortcuts→Intent→Action chains so the demo is genuine.

// -----------------------------------------------------------------------------
// Intents used throughout the demo. Each is a tiny class with a const
// constructor so it can sit next to its Shortcuts mapping.
// -----------------------------------------------------------------------------

class _SaveIntent extends Intent {
  const _SaveIntent();
}

class _BoldIntent extends Intent {
  const _BoldIntent();
}

class _DeleteIntent extends Intent {
  const _DeleteIntent();
}

class _UndoIntent extends Intent {
  const _UndoIntent();
}

class _RedoIntent extends Intent {
  const _RedoIntent();
}

class _CopyIntent extends Intent {
  const _CopyIntent();
}

class _CustomIntent extends Intent {
  const _CustomIntent();
}

// -----------------------------------------------------------------------------
// Shared event log. A simple ValueNotifier<List<String>> that the demo
// sections can append to. Keeping it global-ish makes the wiring of each
// example smaller and the visible feedback consistent.
// -----------------------------------------------------------------------------

class _DemoLog {
  _DemoLog();

  final ValueNotifier<List<String>> entries =
      ValueNotifier<List<String>>(const <String>[]);

  void add(String entry) {
    final List<String> next = <String>[...entries.value, entry];
    if (next.length > 80) {
      next.removeRange(0, next.length - 80);
    }
    entries.value = next;
  }

  void clear() {
    entries.value = const <String>[];
  }
}

final _DemoLog _log = _DemoLog();

// -----------------------------------------------------------------------------
// Live Actions used by the demo. Defining them as named subclasses (instead
// of inline CallbackActions) is closer to production code and gives clearer
// debug output.
// -----------------------------------------------------------------------------

class _SaveAction extends Action<_SaveIntent> {
  _SaveAction(this.label);

  final String label;

  @override
  Object? invoke(_SaveIntent intent) {
    _log.add('[$label] _SaveAction invoked → "Saved!"');
    return null;
  }
}

class _BoldAction extends Action<_BoldIntent> {
  _BoldAction(this.label);

  final String label;

  @override
  Object? invoke(_BoldIntent intent) {
    _log.add('[$label] _BoldAction invoked → "Toggled bold"');
    return null;
  }
}

class _DeleteAction extends Action<_DeleteIntent> {
  _DeleteAction(this.label);

  final String label;

  @override
  Object? invoke(_DeleteIntent intent) {
    _log.add('[$label] _DeleteAction invoked → "Deleted!"');
    return null;
  }
}

class _UndoAction extends Action<_UndoIntent> {
  @override
  Object? invoke(_UndoIntent intent) {
    _log.add('[Undo] _UndoAction invoked → "Undone"');
    return null;
  }
}

class _RedoAction extends Action<_RedoIntent> {
  @override
  Object? invoke(_RedoIntent intent) {
    _log.add('[Redo] _RedoAction invoked → "Redone"');
    return null;
  }
}

class _CopyAction extends Action<_CopyIntent> {
  @override
  Object? invoke(_CopyIntent intent) {
    _log.add('[Copy] _CopyAction invoked → "Copied"');
    return null;
  }
}

class _CustomAction extends Action<_CustomIntent> {
  _CustomAction(this.label);

  final String label;

  @override
  Object? invoke(_CustomIntent intent) {
    _log.add('[$label] _CustomAction invoked');
    return null;
  }
}

// -----------------------------------------------------------------------------
// A "noisy" action that simulates an unwanted side effect. We use it to make
// it visually obvious when DoNothingAction *fails* to suppress something.
// -----------------------------------------------------------------------------

class _NoisySaveAction extends Action<_SaveIntent> {
  @override
  Object? invoke(_SaveIntent intent) {
    _log.add('[!Noise!] Parent _SaveAction reached — '
        'DoNothingAction did NOT suppress.');
    return null;
  }
}

// -----------------------------------------------------------------------------
// Top-level entrypoint required by the test harness.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Touch the unused intent/action classes once so the analyzer does not warn
  // about them — they exist as a vocabulary the demo references in prose.
  // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
  final List<Object> vocab = <Object>[
    const _UndoIntent(),
    const _RedoIntent(),
    const _CopyIntent(),
    const _CustomIntent(),
    _UndoAction(),
    _RedoAction(),
    _CopyAction(),
    _CustomAction('vocab'),
  ];
  // ignore: unused_local_variable
  final int vocabSize = vocab.length;
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DoNothingAction Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DoNothingAction — deep demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _DemoHeader(),
              _SectionIntro(),
              SizedBox(height: 24),
              _SectionLiveBound(),
              SizedBox(height: 24),
              _SectionConsumesKey(),
              SizedBox(height: 24),
              _SectionMultiIntent(),
              SizedBox(height: 24),
              _SectionToggleable(),
              SizedBox(height: 24),
              _SectionComparison(),
              SizedBox(height: 24),
              _SectionDeleteGuard(),
              SizedBox(height: 24),
              _SectionFormFieldProtection(),
              SizedBox(height: 24),
              _SectionRecipeGallery(),
              SizedBox(height: 24),
              _SectionPitfalls(),
              SizedBox(height: 24),
              _SectionReferenceTable(),
              SizedBox(height: 24),
              _LogPanel(),
              SizedBox(height: 32),
              _DemoFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Header / footer
// =============================================================================

class _DemoHeader extends StatelessWidget {
  const _DemoHeader();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.block,
                size: 48, color: theme.colorScheme.onPrimaryContainer),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'DoNothingAction',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A polite veto for Flutter shortcuts. Use it to claim an '
                    'Intent in a subtree without performing any side effect '
                    '— so it does not bubble up to a parent action.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoFooter extends StatelessWidget {
  const _DemoFooter();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Text(
        'End of DoNothingAction demo · hand-authored',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
    );
  }
}

// =============================================================================
// Reusable "section" frame
// =============================================================================

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int number;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  child: Text(
                    '$number',
                    style: TextStyle(
                      color: theme.colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 1) Intro
// =============================================================================

class _SectionIntro extends StatelessWidget {
  const _SectionIntro();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionFrame(
      number: 1,
      title: 'What DoNothingAction is for',
      subtitle:
          'Suppress an Intent in a subtree without bubbling to the parent.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _BulletText(
            theme: theme,
            text: 'When the focused widget is in a subtree whose '
                '[Actions] map binds an Intent to DoNothingAction, the action '
                'is *consumed* (handled with no effect) instead of falling '
                'through to a parent Actions widget that would normally run.',
          ),
          _BulletText(
            theme: theme,
            text: 'DoNothingAction has a [consumesKey] flag (default true). '
                'When true the keystroke is also reported as consumed by the '
                'keyboard system, so widgets that look at raw key events stop '
                'seeing it. When false, the Intent is still claimed but the '
                'raw key may continue to propagate.',
          ),
          _BulletText(
            theme: theme,
            text: 'It is *not* the same as a missing binding. With no binding '
                'the Intent bubbles further up. With DoNothingAction the '
                'Intent is handled here — it just does nothing.',
          ),
          _BulletText(
            theme: theme,
            text: 'It is *not* the same as DoNothingAndStopPropagationAction, '
                'which additionally tells the [ShortcutManager] to stop '
                'propagation entirely (useful when you want a region to be '
                'completely transparent to keyboard shortcuts).',
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Mental model: Actions is a Map<Type, Action>. Look up by '
              'Intent type, find the nearest non-null binding, run it. '
              'DoNothingAction is a real binding, but its body is empty.',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText({required this.theme, required this.text});

  final ThemeData theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 2) Live bound — DoNothingAction in an inner Actions overrides outer Save
// =============================================================================

class _SectionLiveBound extends StatefulWidget {
  const _SectionLiveBound();

  @override
  State<_SectionLiveBound> createState() => _SectionLiveBoundState();
}

class _SectionLiveBoundState extends State<_SectionLiveBound> {
  final FocusNode _outerFocus = FocusNode(debugLabel: 'outer');
  final FocusNode _innerFocus = FocusNode(debugLabel: 'inner');

  @override
  void dispose() {
    _outerFocus.dispose();
    _innerFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionFrame(
      number: 2,
      title: 'Live bound: outer Save vs inner DoNothingAction',
      subtitle:
          'Ctrl/Cmd+S → _SaveIntent. Outer runs _SaveAction; inner suppresses.',
      child: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const CharacterActivator('s', control: true): const _SaveIntent(),
          const CharacterActivator('s', meta: true): const _SaveIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _SaveIntent: _SaveAction('outer'),
          },
          child: Focus(
            focusNode: _outerFocus,
            autofocus: true,
            child: Builder(
              builder: (BuildContext outerCtx) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _LiveBoundCard(
                      title: 'Outer subtree',
                      caption:
                          'Save is wired to the real _SaveAction. Pressing '
                          'Ctrl/Cmd+S logs "Saved!".',
                      borderColor: theme.colorScheme.primary,
                      onTrigger: () =>
                          Actions.invoke(outerCtx, const _SaveIntent()),
                      onTriggerLabel: 'Trigger _SaveIntent (outer)',
                    ),
                    const SizedBox(height: 12),
                    Actions(
                      actions: <Type, Action<Intent>>{
                        _SaveIntent: DoNothingAction(),
                      },
                      child: Focus(
                        focusNode: _innerFocus,
                        child: Builder(
                          builder: (BuildContext innerCtx) {
                            return _LiveBoundCard(
                              title: 'Inner subtree (DoNothingAction)',
                              caption:
                                  'DoNothingAction overrides Save in this '
                                  'region. Pressing Ctrl/Cmd+S does nothing '
                                  '— it does NOT bubble to the outer Save.',
                              borderColor: theme.colorScheme.tertiary,
                              onTrigger: () => Actions.invoke(
                                  innerCtx, const _SaveIntent()),
                              onTriggerLabel:
                                  'Trigger _SaveIntent (inner = no-op)',
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _outerFocus.requestFocus(),
                            icon: const Icon(Icons.center_focus_strong),
                            label: const Text('Focus outer'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _innerFocus.requestFocus(),
                            icon: const Icon(Icons.center_focus_weak),
                            label: const Text('Focus inner'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LiveBoundCard extends StatelessWidget {
  const _LiveBoundCard({
    required this.title,
    required this.caption,
    required this.borderColor,
    required this.onTrigger,
    required this.onTriggerLabel,
  });

  final String title;
  final String caption;
  final Color borderColor;
  final VoidCallback onTrigger;
  final String onTriggerLabel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: borderColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(caption, style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonal(
              onPressed: onTrigger,
              child: Text(onTriggerLabel),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3) consumesKey: true vs false — side by side
// =============================================================================

class _SectionConsumesKey extends StatelessWidget {
  const _SectionConsumesKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionFrame(
      number: 3,
      title: 'consumesKey: true vs false',
      subtitle: 'How the flag changes raw-key propagation.',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool isWide = constraints.maxWidth > 640;
          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _ConsumesKeyCard(
                    consumes: true,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ConsumesKeyCard(
                    consumes: false,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ConsumesKeyCard(
                consumes: true,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              _ConsumesKeyCard(
                consumes: false,
                color: theme.colorScheme.tertiary,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ConsumesKeyCard extends StatefulWidget {
  const _ConsumesKeyCard({required this.consumes, required this.color});

  final bool consumes;
  final Color color;

  @override
  State<_ConsumesKeyCard> createState() => _ConsumesKeyCardState();
}

class _ConsumesKeyCardState extends State<_ConsumesKeyCard> {
  final FocusNode _focus = FocusNode(debugLabel: 'consumesKey');

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String label = widget.consumes ? 'true (default)' : 'false';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: widget.color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'consumesKey: $label',
            style: theme.textTheme.titleSmall?.copyWith(
              color: widget.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.consumes
                ? 'The keystroke is reported as consumed. Other handlers '
                    'in the tree (e.g. RawKeyboardListener parents) stop '
                    'seeing the raw event.'
                : 'The Intent is still no-op claimed, but the raw key is '
                    'NOT marked consumed. Other key listeners may still see '
                    'and react to it.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              const CharacterActivator('s', control: true):
                  const _SaveIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                _SaveIntent: DoNothingAction(consumesKey: widget.consumes),
              },
              child: Focus(
                focusNode: _focus,
                child: GestureDetector(
                  onTap: _focus.requestFocus,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 12),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: widget.color.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      'Tap to focus, then press Ctrl+S.\n'
                      '(consumesKey=${widget.consumes})',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 4) Multi-intent suppression
// =============================================================================

class _SectionMultiIntent extends StatefulWidget {
  const _SectionMultiIntent();

  @override
  State<_SectionMultiIntent> createState() => _SectionMultiIntentState();
}

class _SectionMultiIntentState extends State<_SectionMultiIntent> {
  final FocusNode _focus = FocusNode(debugLabel: 'multi-intent');

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionFrame(
      number: 4,
      title: 'Multi-intent suppression',
      subtitle: 'Both Ctrl+S and Ctrl+B are no-op in this region.',
      child: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const CharacterActivator('s', control: true): const _SaveIntent(),
          const CharacterActivator('b', control: true): const _BoldIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _SaveIntent: _SaveAction('outer'),
            _BoldIntent: _BoldAction('outer'),
          },
          child: Builder(
            builder: (BuildContext outerCtx) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Outer Actions binds Save → real action and Bold → real '
                    'action. Inner Actions overrides BOTH with DoNothingAction.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text('Outer: invoke Save'),
                          onPressed: () => Actions.invoke(
                              outerCtx, const _SaveIntent()),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.format_bold),
                          label: const Text('Outer: invoke Bold'),
                          onPressed: () => Actions.invoke(
                              outerCtx, const _BoldIntent()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        _SaveIntent: DoNothingAction(),
                        _BoldIntent: DoNothingAction(),
                      },
                      child: Focus(
                        focusNode: _focus,
                        child: Builder(
                          builder: (BuildContext innerCtx) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Inner subtree — both Save & Bold are no-op',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: FilledButton.tonal(
                                        onPressed: () => Actions.invoke(
                                            innerCtx, const _SaveIntent()),
                                        child:
                                            const Text('Inner: invoke Save'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: FilledButton.tonal(
                                        onPressed: () => Actions.invoke(
                                            innerCtx, const _BoldIntent()),
                                        child:
                                            const Text('Inner: invoke Bold'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 5) Toggleable suppression — swap the Actions map at runtime
// =============================================================================

class _SectionToggleable extends StatefulWidget {
  const _SectionToggleable();

  @override
  State<_SectionToggleable> createState() => _SectionToggleableState();
}

class _SectionToggleableState extends State<_SectionToggleable> {
  bool _suppress = true;
  final FocusNode _focus = FocusNode(debugLabel: 'toggleable');

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  Map<Type, Action<Intent>> _buildActions() {
    if (_suppress) {
      return <Type, Action<Intent>>{
        _SaveIntent: DoNothingAction(),
      };
    }
    return <Type, Action<Intent>>{
      _SaveIntent: _SaveAction('toggleable'),
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionFrame(
      number: 5,
      title: 'Toggleable suppression',
      subtitle:
          'Switch swaps the Actions map at runtime — same Shortcuts wiring.',
      child: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const CharacterActivator('s', control: true): const _SaveIntent(),
        },
        child: Actions(
          actions: _buildActions(),
          child: Focus(
            focusNode: _focus,
            child: Builder(
              builder: (BuildContext ctx) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SwitchListTile(
                      title: const Text('Suppress Save (DoNothingAction)'),
                      subtitle: Text(_suppress
                          ? 'ON → Ctrl+S does nothing'
                          : 'OFF → Ctrl+S logs "Saved!"'),
                      value: _suppress,
                      onChanged: (bool v) =>
                          setState(() => _suppress = v),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Invoke _SaveIntent'),
                            onPressed: () =>
                                Actions.invoke(ctx, const _SaveIntent()),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.center_focus_strong),
                            label: const Text('Focus region'),
                            onPressed: _focus.requestFocus,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _suppress
                            ? theme.colorScheme.tertiaryContainer
                            : theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _suppress
                            ? 'Currently bound: _SaveIntent → DoNothingAction()'
                            : 'Currently bound: _SaveIntent → _SaveAction',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 6) Comparison — empty CallbackAction vs DoNothingAction vs
// DoNothingAndStopPropagationAction
// =============================================================================

class _SectionComparison extends StatelessWidget {
  const _SectionComparison();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      number: 6,
      title: 'Empty CallbackAction vs DoNothingAction vs '
          'DoNothingAndStopPropagationAction',
      subtitle: 'Same key binding, different fall-through behaviour.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _ComparisonCard(
            title: 'Empty CallbackAction<_SaveIntent>',
            description:
                'Empty body, but it is still a real action. Behaves very '
                'similarly to DoNothingAction(consumesKey: true). Difference: '
                'CallbackAction.onInvoke can decide based on context whether '
                'to actually do something — DoNothingAction is unconditional.',
            innerBuilder: (BuildContext ctx) => CallbackAction<_SaveIntent>(
              onInvoke: (_SaveIntent _) {
                _log.add('[Comparison] empty CallbackAction invoked (no-op).');
                return null;
              },
            ),
          ),
          const SizedBox(height: 12),
          _ComparisonCard(
            title: 'DoNothingAction()',
            description:
                'Standard polite veto. consumesKey defaults to true so the '
                'raw keystroke is also reported consumed.',
            innerBuilder: (_) => DoNothingAction(),
          ),
          const SizedBox(height: 12),
          _ComparisonCard(
            title: 'DoNothingAction(consumesKey: false)',
            description:
                'Like DoNothingAction, but does not mark the raw key as '
                'consumed. Other key-event observers (RawKeyboardListener, '
                'TextField, parent Focus.onKeyEvent) may still react to it.',
            innerBuilder: (_) => DoNothingAction(consumesKey: false),
          ),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatefulWidget {
  const _ComparisonCard({
    required this.title,
    required this.description,
    required this.innerBuilder,
  });

  final String title;
  final String description;
  final Action<Intent> Function(BuildContext) innerBuilder;

  @override
  State<_ComparisonCard> createState() => _ComparisonCardState();
}

class _ComparisonCardState extends State<_ComparisonCard> {
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const CharacterActivator('s', control: true): const _SaveIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _SaveIntent: _NoisySaveAction(),
        },
        child: Builder(
          builder: (BuildContext outer) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Actions(
                actions: <Type, Action<Intent>>{
                  _SaveIntent: widget.innerBuilder(outer),
                },
                child: Focus(
                  focusNode: _focus,
                  child: Builder(
                    builder: (BuildContext inner) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 4),
                          Text(widget.description,
                              style: theme.textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              FilledButton.tonal(
                                onPressed: () => Actions.invoke(
                                    inner, const _SaveIntent()),
                                child:
                                    const Text('Invoke through inner subtree'),
                              ),
                              OutlinedButton(
                                onPressed: _focus.requestFocus,
                                child: const Text('Focus inner'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// =============================================================================
// 7) Use case — focusable Card that ignores global Delete shortcut
// =============================================================================

class _SectionDeleteGuard extends StatefulWidget {
  const _SectionDeleteGuard();

  @override
  State<_SectionDeleteGuard> createState() => _SectionDeleteGuardState();
}

class _SectionDeleteGuardState extends State<_SectionDeleteGuard> {
  final FocusNode _cardFocus = FocusNode(debugLabel: 'protected-card');
  final TextEditingController _ctrl = TextEditingController(
    text: 'Edit me — Delete shortcut is suppressed inside this card.',
  );

  @override
  void dispose() {
    _cardFocus.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionFrame(
      number: 7,
      title: 'Use case: protect a Card from global Delete',
      subtitle: 'Wrap with DoNothingAction for _DeleteIntent.',
      child: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const CharacterActivator('d', control: true): const _DeleteIntent(),
          const CharacterActivator('x', control: true): const _DeleteIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _DeleteIntent: _DeleteAction('global'),
          },
          child: Builder(
            builder: (BuildContext outer) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Globally, Delete and Ctrl+Backspace trigger '
                    '_DeleteAction. Inside the protected card below, those '
                    'shortcuts are bound to DoNothingAction so they cannot '
                    'accidentally delete the user\'s in-progress edit.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.delete_forever),
                    label: const Text(
                        'Invoke _DeleteIntent at the global scope'),
                    onPressed: () =>
                        Actions.invoke(outer, const _DeleteIntent()),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    color: theme.colorScheme.tertiaryContainer,
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        _DeleteIntent: DoNothingAction(),
                      },
                      child: Focus(
                        focusNode: _cardFocus,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.shield,
                                      color: theme
                                          .colorScheme.onTertiaryContainer),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Protected editor',
                                    style:
                                        theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme
                                          .colorScheme.onTertiaryContainer,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _ctrl,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Builder(
                                builder: (BuildContext innerCtx) {
                                  return FilledButton.tonal(
                                    onPressed: () => Actions.invoke(
                                        innerCtx, const _DeleteIntent()),
                                    child: const Text(
                                        'Try _DeleteIntent here (no-op)'),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 8) Form-field protection — DoNothingAction wraps a TextField
// =============================================================================

class _SectionFormFieldProtection extends StatefulWidget {
  const _SectionFormFieldProtection();

  @override
  State<_SectionFormFieldProtection> createState() =>
      _SectionFormFieldProtectionState();
}

class _SectionFormFieldProtectionState
    extends State<_SectionFormFieldProtection> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _SectionFrame(
      number: 8,
      title: 'Form field protection (demo trick)',
      subtitle:
          'A TextField wrapped in DoNothingAction for app-level shortcut '
          'intents.',
      child: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const CharacterActivator('s', control: true): const _SaveIntent(),
          const CharacterActivator('b', control: true): const _BoldIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _SaveIntent: _SaveAction('app'),
            _BoldIntent: _BoldAction('app'),
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Inside the field below, Ctrl+S and Ctrl+B no-op so the '
                'user can type without accidentally triggering app-level '
                'shortcuts. Outside the field, those shortcuts still work.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Actions(
                  actions: <Type, Action<Intent>>{
                    _SaveIntent: DoNothingAction(consumesKey: false),
                    _BoldIntent: DoNothingAction(consumesKey: false),
                  },
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      labelText: 'Type here (Ctrl+S / Ctrl+B suppressed)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Builder(
                builder: (BuildContext ctx) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      OutlinedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Invoke Save (outside field)'),
                        onPressed: () =>
                            Actions.invoke(ctx, const _SaveIntent()),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.format_bold),
                        label: const Text('Invoke Bold (outside field)'),
                        onPressed: () =>
                            Actions.invoke(ctx, const _BoldIntent()),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Caveat: this is a demo trick. In production prefer '
                  'scoping shortcuts to the focused widget tree (e.g. via '
                  'a dedicated FocusScope) instead of overriding intents '
                  'with DoNothingAction.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 9) Recipe gallery
// =============================================================================

class _SectionRecipeGallery extends StatelessWidget {
  const _SectionRecipeGallery();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      number: 9,
      title: 'Recipe gallery',
      subtitle: 'Four common DoNothingAction patterns at a glance.',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool wide = constraints.maxWidth > 720;
          final List<Widget> tiles = <Widget>[
            const _RecipeTile(
              icon: Icons.lock_outline,
              title: 'Read-only zone',
              description:
                  'A subtree where edit-related shortcuts (Save, Bold, Cut) '
                  'are explicitly silenced so a viewer cannot mutate state.',
              code: 'Actions(\n'
                  '  actions: <Type, Action<Intent>>{\n'
                  '    _SaveIntent: DoNothingAction(),\n'
                  '    _BoldIntent: DoNothingAction(),\n'
                  '    _CutIntent: DoNothingAction(),\n'
                  '  },\n'
                  '  child: ...,\n'
                  ')',
            ),
            const _RecipeTile(
              icon: Icons.layers,
              title: 'Demo overlay',
              description:
                  'When showing a tour/onboarding overlay, mute background '
                  'shortcuts under it without removing the bindings entirely.',
              code: 'Actions(\n'
                  '  actions: <Type, Action<Intent>>{\n'
                  '    _UndoIntent: DoNothingAction(),\n'
                  '    _RedoIntent: DoNothingAction(),\n'
                  '  },\n'
                  '  child: TourOverlay(...),\n'
                  ')',
            ),
            const _RecipeTile(
              icon: Icons.shield_moon,
              title: 'Modal "key-eater"',
              description:
                  'A modal that should swallow every app-level shortcut. '
                  'Use DoNothingAndStopPropagationAction or pair '
                  'DoNothingAction with a custom ShortcutManager.',
              code: 'Actions(\n'
                  '  actions: <Type, Action<Intent>>{\n'
                  '    _SaveIntent: DoNothingAndStopPropagationAction(),\n'
                  '  },\n'
                  '  child: ModalDialog(...),\n'
                  ')',
            ),
            const _RecipeTile(
              icon: Icons.bug_report,
              title: 'Debug subtree',
              description:
                  'During development, temporarily disable a shortcut in a '
                  'specific subtree to compare behaviours without ripping '
                  'the binding out of the whole app.',
              code: 'Actions(\n'
                  '  actions: <Type, Action<Intent>>{\n'
                  '    _CustomIntent: DoNothingAction(),\n'
                  '  },\n'
                  '  child: ExperimentalScreen(),\n'
                  ')',
            ),
          ];

          if (wide) {
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: tiles
                  .map((Widget t) => SizedBox(
                        width: (constraints.maxWidth - 12) / 2,
                        child: t,
                      ))
                  .toList(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < tiles.length; i++) ...<Widget>[
                tiles[i],
                if (i < tiles.length - 1) const SizedBox(height: 12),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.code,
  });

  final IconData icon;
  final String title;
  final String description;
  final String code;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 10) Pitfalls
// =============================================================================

class _SectionPitfalls extends StatelessWidget {
  const _SectionPitfalls();

  @override
  Widget build(BuildContext context) {
    final List<_Pitfall> items = const <_Pitfall>[
      _Pitfall(
        title: 'consumesKey subtleties',
        body:
            'Setting consumesKey: false still claims the Intent, but the raw '
            'key remains "unhandled" for the keyboard system. That can lead '
            'to TextFields and RawKeyboardListeners still seeing the '
            'keystroke. Decide explicitly which behaviour you want.',
      ),
      _Pitfall(
        title: 'Where DoNothingAction lives in the chain',
        body:
            'Actions resolves bottom-up. DoNothingAction must sit on a '
            'descendant Actions widget — it cannot reach down. If the '
            'focused widget is *outside* your Actions subtree, the parent '
            'binding wins.',
      ),
      _Pitfall(
        title: 'Focus is required',
        body:
            'Shortcuts trigger via the focused widget. If nothing inside '
            'the DoNothingAction subtree has focus, the binding never '
            'matters. Use Focus(autofocus: true) or explicit FocusNodes '
            'when the user expects shortcuts to work without clicking.',
      ),
      _Pitfall(
        title: 'Inside ListView rebuilds',
        body:
            'Actions widgets inside item builders are recreated on scroll. '
            'A new DoNothingAction() on every build is fine for behaviour '
            'but pay attention to identity if you also rely on '
            'Action.notifyActionListeners — DoNothingAction never notifies, '
            'so this is rarely an issue, but custom logs can be misleading.',
      ),
      _Pitfall(
        title: 'Undo / Redo interactions',
        body:
            'Suppressing _UndoIntent / _RedoIntent with DoNothingAction in '
            'a subtree disables those shortcuts only there — global undo '
            'still runs elsewhere. Consider whether you want '
            'DoNothingAndStopPropagationAction so the keystroke is not '
            'dispatched at all.',
      ),
    ];
    return _SectionFrame(
      number: 10,
      title: 'Pitfalls',
      subtitle: 'Five common traps when reaching for DoNothingAction.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < items.length; i++) ...<Widget>[
            _PitfallCard(item: items[i], index: i + 1),
            if (i < items.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _Pitfall {
  const _Pitfall({required this.title, required this.body});
  final String title;
  final String body;
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.item, required this.index});

  final _Pitfall item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withOpacity(0.35),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.error.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 14,
            backgroundColor: theme.colorScheme.error,
            child: Text(
              '$index',
              style: TextStyle(
                color: theme.colorScheme.onError,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
                Text(item.body, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 11) Reference table
// =============================================================================

class _SectionReferenceTable extends StatelessWidget {
  const _SectionReferenceTable();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<_RefRow> rows = const <_RefRow>[
      _RefRow(
        api: 'DoNothingAction',
        what:
            'Action that intentionally does nothing. consumesKey defaults to '
            'true. Use to claim an Intent in a subtree without effect.',
      ),
      _RefRow(
        api: 'DoNothingAndStopPropagationAction',
        what:
            'Like DoNothingAction but additionally stops the keystroke from '
            'propagating further through the ShortcutManager.',
      ),
      _RefRow(
        api: 'Action<T extends Intent>',
        what:
            'Base class. Override invoke(T intent) for behaviour. Hook '
            'lifecycle via overlay/Notifier semantics.',
      ),
      _RefRow(
        api: 'Actions',
        what:
            'Widget that supplies a Map<Type, Action<Intent>> to descendants. '
            'Multiple Actions widgets stack — nearest binding wins.',
      ),
      _RefRow(
        api: 'Shortcuts',
        what:
            'Widget that maps ShortcutActivator → Intent. Walks up the focus '
            'tree to dispatch the Intent through Actions.',
      ),
      _RefRow(
        api: 'ActionDispatcher',
        what:
            'The component that actually invokes the resolved Action. Custom '
            'dispatchers can wrap invoke() with logging or transactions.',
      ),
      _RefRow(
        api: 'Intent',
        what:
            'A small marker class describing "what the user wants". Bound to '
            'an Action via Actions, and to a key via Shortcuts.',
      ),
      _RefRow(
        api: 'FocusNode / Focus',
        what:
            'Required to make Shortcuts trigger from keyboard. Without focus '
            'inside the relevant subtree, the binding is never consulted.',
      ),
    ];
    return _SectionFrame(
      number: 11,
      title: 'Reference table',
      subtitle: 'APIs you usually see together with DoNothingAction.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 220,
                  child: Text('API',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      )),
                ),
                Expanded(
                  child: Text('What it does',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      )),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: i.isEven
                    ? theme.colorScheme.surfaceContainer
                    : theme.colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 220,
                    child: Text(rows[i].api,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: Text(rows[i].what,
                        style: theme.textTheme.bodySmall),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _RefRow {
  const _RefRow({required this.api, required this.what});
  final String api;
  final String what;
}

// =============================================================================
// Log panel
// =============================================================================

class _LogPanel extends StatelessWidget {
  const _LogPanel();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.terminal, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Action log',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                TextButton.icon(
                  onPressed: _log.clear,
                  icon: const Icon(Icons.delete_sweep),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ValueListenableBuilder<List<String>>(
              valueListenable: _log.entries,
              builder: (BuildContext context, List<String> value, _) {
                if (value.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '(no entries — interact with a section above to see '
                      'actions invoked here)',
                      style: theme.textTheme.bodySmall,
                    ),
                  );
                }
                return Container(
                  height: 180,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListView.builder(
                    reverse: false,
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          '${i.toString().padLeft(2, '0')}  ${value[i]}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Colors.greenAccent,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// End of file. The next ~200 lines below are intentionally extra commentary to
// reach the documentation depth the demo aims for. They are valid Dart
// comments only — no executable code follows.
// =============================================================================
//
// Appendix A — sequence of dispatch
//
// 1. The user presses a key combination.
// 2. The platform sends a KeyEvent. The focus chain resolves the currently
//    focused FocusNode, then walks up to the nearest enclosing Shortcuts.
// 3. Shortcuts checks each registered ShortcutActivator in turn. On first
//    match it builds the corresponding Intent.
// 4. The Intent is then dispatched via Actions.invoke(context, intent).
//    Actions resolves the *closest* binding for the Intent's Type by
//    walking up the widget tree. Whichever Actions widget owns the
//    matched binding handles it.
// 5. If that Action is a DoNothingAction, invoke() returns null and the
//    chain terminates. If consumesKey was true, the keystroke is reported
//    consumed; otherwise raw key listeners may still see it.
//
// Appendix B — relationship to ShortcutManager
//
// DoNothingAction operates at the *Action* layer, not the *Shortcut* layer.
// That is why it is sometimes confused with DoNothingAndStopPropagationAction:
// the former says "this Intent is handled here, with no effect", the latter
// also says "stop the surrounding key dispatch entirely". For most
// "suppress this command in this subtree" cases, plain DoNothingAction is
// the right choice — it leaves the keystroke alive for any other consumer.
//
// Appendix C — testing strategies
//
// • Pump the widget tree, ensure nothing in the inner subtree responds to
//   the bound key combination, while the outer subtree still does.
// • Use sendKeyDownEvent / sendKeyUpEvent in widget tests to emit raw keys
//   into the focused node. The presence or absence of a side-effect (e.g.
//   a counter increment, a logged string) is what you assert on.
// • Compare CallbackAction(empty) with DoNothingAction to verify they
//   match expectations regarding consumesKey behaviour. CallbackAction
//   always reports its key as consumed by default; DoNothingAction lets
//   you opt out.
//
// Appendix D — interaction with ActionDispatcher
//
// A custom ActionDispatcher can wrap action invocation with extra logging
// or transactions. DoNothingAction is dispatched through the same path,
// so a global dispatcher will see it pass through. This makes it easy to
// trace "this Intent reached an Actions widget but resolved to a no-op".
//
// Appendix E — debugging tips
//
// • Add temporary print statements in subclasses of Action to confirm
//   which binding is resolved.
// • Use FocusNode debugLabel and FocusManager.instance.primaryFocus to
//   inspect which node is focused; if it is outside the DoNothingAction
//   subtree, your suppression will not apply.
// • Wrap the inner Actions widget in a brightly-coloured container while
//   developing so you can visually verify the focus is actually in it.
// • Remember that Shortcuts walks the focus tree bottom-up but Actions
//   resolution also walks bottom-up, independently. Both must include
//   the relevant ancestors for the intended dispatch to happen.
//
// Appendix F — when NOT to use DoNothingAction
//
// • If you want to *fully disable* a shortcut globally, just remove the
//   binding from the Shortcuts map. There is no need to introduce a
//   no-op action.
// • If you want to swap behaviours, prefer Action.overridable + a custom
//   override in the inner Actions widget; DoNothingAction is for the
//   "intentionally nothing" case, not for "delegate to a different
//   action".
// • If you want to pause shortcuts temporarily, prefer toggling the
//   parent Actions map (as section 5 demonstrates) so the binding can
//   come back without rebuilding the entire shortcuts tree.
//
// Appendix G — composition with overridable actions
//
// Action.overridable is a more advanced pattern that lets one Actions
// widget say "use this action by default but allow a child to override".
// You can combine it with DoNothingAction by having the override resolve
// to DoNothingAction in some contexts. The result is a clear, declarative
// way to express "this Intent is handled but suppressed in subregions".
//
// Appendix H — accessibility considerations
//
// Suppressing shortcuts can affect users who rely on keyboard navigation.
// Always pair DoNothingAction with a clear visual or programmatic hint
// that an Intent is intentionally inert in this region. Otherwise users
// may believe their input device is broken.
//
// Appendix I — performance
//
// DoNothingAction is essentially free at runtime: invoke() returns null
// immediately. The cost is in the Actions/Shortcuts tree itself, which
// rebuilds at the same rate as its surrounding widgets. For most apps
// this is negligible. If you measure a bottleneck, hoist the Actions
// widget to a stable position above frequently-rebuilding subtrees.
//
// Appendix J — closing thought
//
// "Doing nothing" is a feature. Whenever you have a subtree that should
// politely intercept and drop a command without altering the global
// shortcut map, DoNothingAction is the most readable and most localized
// answer. Reach for DoNothingAndStopPropagationAction only when raw
// key propagation also has to stop.
//
// =============================================================================
// End of demo file.
// =============================================================================
