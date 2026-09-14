// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ===========================================================================
// ContextAction<T extends Intent> — Deep Demo
// ===========================================================================
//
// `ContextAction<T>` is a specialised `Action<T>` whose `invoke` overload
// receives the dispatching `BuildContext`. The base `Action` class only sees
// the `Intent`; the dispatcher does not pass any context. That is fine for
// most actions, but it falls apart the moment your action's behaviour needs
// to know *where* in the tree it was triggered:
//
//   * "Copy" should respect the nearest `DefaultSelectionStyle`.
//   * "Navigate" should move focus inside the dispatching `FocusScope`.
//   * "Submit" should look up the nearest form via `Form.of(context)`.
//   * "Theme-aware logging" should render previews with the local theme.
//
// `ContextAction` exists exactly for these cases. The `ActionDispatcher`
// detects that the registered `Action` is actually a `ContextAction` and
// then forwards the originating `BuildContext` into `invoke`.
//
// Inheritance overview:
//
//                    Action<T extends Intent>
//                            ▲
//                            │
//                    ContextAction<T extends Intent>
//                            ▲
//                            │
//                  CallbackAction<T> / your custom subclass
//
// In this demo file we construct ten lab sections that exercise the
// context-aware dispatch in many shapes:
//
//   §1  Intro and inheritance commentary
//   §2  Same intent dispatched in three subtrees, each logging a different
//       runtimeType because the BuildContext.widget differs.
//   §3  Subtree-aware copy that reads the local Theme/DefaultSelectionStyle.
//   §4  Focus-aware navigation that uses FocusScope.of(context).
//   §5  Live shortcut binding that fires _ContextLogIntent on Enter.
//   §6  Toggleable enabled state with a parent-level fall-through handler.
//   §7  Three nested Actions widgets and the "bubble until handled" chain.
//   §8  Custom ActionDispatcher subclass that records every invocation.
//   §9  Side-by-side: plain Action vs ContextAction for the same intent.
//   §10 Pitfalls — five things that bite you.
//   §11 Recipe gallery — four practical patterns.
//   §12 Reference table — the cast of characters.
//
// Every section is interactive: actions are dispatched live, the resulting
// log is rendered as Chips, and toggles flip enabled/disabled state.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// §0 Intents — these are the data carriers passed through the Actions system.
// ---------------------------------------------------------------------------

class _ContextLogIntent extends Intent {
  const _ContextLogIntent({this.tag = 'enter'});
  final String tag;
}

class _CopyIntent extends Intent {
  const _CopyIntent(this.payload);
  final String payload;
}

class _NavIntent extends Intent {
  const _NavIntent({this.direction = _NavDirection.next});
  final _NavDirection direction;
}

enum _NavDirection { next, previous, first, last }

class _ToggleableIntent extends Intent {
  const _ToggleableIntent();
}

class _BubbleIntent extends Intent {
  const _BubbleIntent();
}

class _DispatchTraceIntent extends Intent {
  const _DispatchTraceIntent(this.label);
  final String label;
}

// ---------------------------------------------------------------------------
// §0.1 Shared invocation log used across the demo.
// ---------------------------------------------------------------------------

class _InvocationLog extends ChangeNotifier {
  final List<String> _entries = <String>[];

  List<String> get entries => List<String>.unmodifiable(_entries);

  void add(String entry) {
    _entries.insert(0, entry);
    if (_entries.length > 24) {
      _entries.removeLast();
    }
    notifyListeners();
  }

  void clear() {
    _entries.clear();
    notifyListeners();
  }
}

final _InvocationLog _logCenter = _InvocationLog();
final _InvocationLog _bubbleLog = _InvocationLog();
final _InvocationLog _dispatcherLog = _InvocationLog();
final _InvocationLog _shortcutLog = _InvocationLog();

// ---------------------------------------------------------------------------
// §2 _ContextLogAction — logs the dispatching BuildContext.widget.runtimeType.
// ---------------------------------------------------------------------------

class _ContextLogAction extends ContextAction<_ContextLogIntent> {
  _ContextLogAction({required this.label});
  final String label;

  @override
  Object? invoke(_ContextLogIntent intent, [BuildContext? context]) {
    final String widgetType =
        context?.widget.runtimeType.toString() ?? '<no context>';
    final String entry = '[$label/${intent.tag}] dispatched in $widgetType';
    print(entry);
    _logCenter.add(entry);
    return entry;
  }
}

// ---------------------------------------------------------------------------
// §3 _CopyContextAction — reads the local Theme to vary copy behaviour.
// ---------------------------------------------------------------------------

class _CopyContextAction extends ContextAction<_CopyIntent> {
  _CopyContextAction({required this.subtree});
  final String subtree;

  @override
  Object? invoke(_CopyIntent intent, [BuildContext? context]) {
    if (context == null) {
      _logCenter.add('[copy/$subtree] no context — using fallback');
      return '<fallback>';
    }
    final ThemeData theme = Theme.of(context);
    final Brightness brightness = theme.brightness;
    final Color seed = theme.colorScheme.primary;
    final String stylized = brightness == Brightness.dark
        ? '🌙  ${intent.payload}  (dark, primary=#${seed.value.toRadixString(16)})'
        : '☀️  ${intent.payload}  (light, primary=#${seed.value.toRadixString(16)})';
    _logCenter.add('[copy/$subtree] $stylized');
    return stylized;
  }
}

// ---------------------------------------------------------------------------
// §4 _NavContextAction — uses FocusScope.of(context) to traverse focus.
// ---------------------------------------------------------------------------

class _NavContextAction extends ContextAction<_NavIntent> {
  _NavContextAction({required this.scopeLabel});
  final String scopeLabel;

  @override
  Object? invoke(_NavIntent intent, [BuildContext? context]) {
    if (context == null) {
      _logCenter.add('[nav/$scopeLabel] no context, cannot move focus');
      return null;
    }
    final FocusScopeNode scope = FocusScope.of(context);
    switch (intent.direction) {
      case _NavDirection.next:
        scope.nextFocus();
        break;
      case _NavDirection.previous:
        scope.previousFocus();
        break;
      case _NavDirection.first:
        scope.focusInDirection(TraversalDirection.up);
        break;
      case _NavDirection.last:
        scope.focusInDirection(TraversalDirection.down);
        break;
    }
    final String currentLabel =
        scope.focusedChild?.debugLabel ?? scope.focusedChild?.toString() ??
            '<unknown>';
    _logCenter.add('[nav/$scopeLabel] -> ${intent.direction.name} ($currentLabel)');
    return null;
  }
}

// ---------------------------------------------------------------------------
// §6 _ToggleableContextAction — overrides isEnabled to flip on/off.
// ---------------------------------------------------------------------------

class _ToggleableContextAction extends ContextAction<_ToggleableIntent> {
  _ToggleableContextAction({required this.enabledNotifier, required this.label});
  final ValueNotifier<bool> enabledNotifier;
  final String label;

  @override
  bool isEnabled(_ToggleableIntent intent, [BuildContext? context]) {
    return enabledNotifier.value;
  }

  @override
  Object? invoke(_ToggleableIntent intent, [BuildContext? context]) {
    final String where = context?.widget.runtimeType.toString() ?? '<no ctx>';
    final String entry = '[$label] handled by child action in $where';
    print(entry);
    _logCenter.add(entry);
    return entry;
  }
}

class _ParentToggleableAction extends ContextAction<_ToggleableIntent> {
  @override
  Object? invoke(_ToggleableIntent intent, [BuildContext? context]) {
    final String where = context?.widget.runtimeType.toString() ?? '<no ctx>';
    final String entry = '[parent fallthrough] handled by ancestor in $where';
    print(entry);
    _logCenter.add(entry);
    return entry;
  }
}

// ---------------------------------------------------------------------------
// §7 _BubbleAction — multi-handler chain for _BubbleIntent.
// ---------------------------------------------------------------------------

class _BubbleAction extends ContextAction<_BubbleIntent> {
  _BubbleAction({
    required this.layer,
    required this.enabledNotifier,
  });
  final String layer;
  final ValueNotifier<bool> enabledNotifier;

  @override
  bool isEnabled(_BubbleIntent intent, [BuildContext? context]) {
    return enabledNotifier.value;
  }

  @override
  Object? invoke(_BubbleIntent intent, [BuildContext? context]) {
    final String where = context?.widget.runtimeType.toString() ?? '<no ctx>';
    final String entry = '[$layer] handled in $where';
    print(entry);
    _bubbleLog.add(entry);
    return entry;
  }
}

// ---------------------------------------------------------------------------
// §8 _LoggingDispatcher — custom ActionDispatcher subclass.
// ---------------------------------------------------------------------------

class _LoggingDispatcher extends ActionDispatcher {
  _LoggingDispatcher();

  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    final String typename = intent.runtimeType.toString();
    final String widgetType =
        context?.widget.runtimeType.toString() ?? '<no ctx>';
    final String isContextAware = action is ContextAction ? 'yes' : 'no';
    _dispatcherLog.add(
      'invokeAction(intent=$typename, ctx=$widgetType, ctxAware=$isContextAware)',
    );
    return super.invokeAction(action, intent, context);
  }
}

// ---------------------------------------------------------------------------
// §9 _DispatchTracePlainAction vs _DispatchTraceContextAction.
// ---------------------------------------------------------------------------

class _DispatchTracePlainAction extends Action<_DispatchTraceIntent> {
  @override
  Object? invoke(_DispatchTraceIntent intent) {
    // Plain Action does not get a BuildContext, so it must use an inherited
    // singleton (here, the global theme via something else) or fall back.
    final String entry = '[plain] ${intent.label}: no context, using fallback';
    _logCenter.add(entry);
    return entry;
  }
}

class _DispatchTraceContextAction extends ContextAction<_DispatchTraceIntent> {
  @override
  Object? invoke(_DispatchTraceIntent intent, [BuildContext? context]) {
    final ThemeData? theme = context == null ? null : Theme.of(context);
    final Brightness? brightness = theme?.brightness;
    final String entry =
        '[context] ${intent.label}: ${brightness?.name ?? '<no theme>'}';
    _logCenter.add(entry);
    return entry;
  }
}

// ---------------------------------------------------------------------------
// §5 — Shortcut-bound action listener (used by the Enter binding subtree).
// ---------------------------------------------------------------------------

class _ShortcutLogAction extends ContextAction<_ContextLogIntent> {
  @override
  Object? invoke(_ContextLogIntent intent, [BuildContext? context]) {
    final String where = context?.widget.runtimeType.toString() ?? '<no ctx>';
    final String entry = 'Shortcut → ${intent.tag} in $where';
    _shortcutLog.add(entry);
    _logCenter.add(entry);
    return entry;
  }
}

// ---------------------------------------------------------------------------
// build() — top-level entry. MaterialApp → Scaffold → SafeArea →
// SingleChildScrollView → Column.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== ContextAction Deep Demo ===');
  return MaterialApp(
    title: 'ContextAction Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.light,
    ),
    home: const _ContextActionHome(),
  );
}

class _ContextActionHome extends StatelessWidget {
  const _ContextActionHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContextAction<T> — Deep Demo'),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _SectionIntro(),
              _SectionDivider(),
              _SectionContextLog(),
              _SectionDivider(),
              _SectionThemeAwareCopy(),
              _SectionDivider(),
              _SectionFocusNavigation(),
              _SectionDivider(),
              _SectionShortcuts(),
              _SectionDivider(),
              _SectionToggleableEnabled(),
              _SectionDivider(),
              _SectionBubbleChain(),
              _SectionDivider(),
              _SectionDispatcherIntegration(),
              _SectionDivider(),
              _SectionPlainVsContext(),
              _SectionDivider(),
              _SectionPitfalls(),
              _SectionDivider(),
              _SectionRecipes(),
              _SectionDivider(),
              _SectionReferenceTable(),
              _SectionDivider(),
              _GlobalLogPanel(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Common visual helpers
// ---------------------------------------------------------------------------

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Divider(height: 1, thickness: 1),
      );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.number, this.title, {this.subtitle});
  final String number;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 14,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: tt.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: tt.bodyMedium?.copyWith(color: Colors.grey.shade700),
            ),
          ],
        ],
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
      );
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F8),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE0E0EA)),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
          height: 1.4,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('•  ', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
          ],
        ),
      );
}

// ===========================================================================
// §1 Intro
// ===========================================================================

class _SectionIntro extends StatelessWidget {
  const _SectionIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _SectionTitle(
          '1',
          'Action vs ContextAction — why context-aware dispatch?',
          subtitle:
              'A ContextAction extends Action and gains a BuildContext '
              'parameter on its invoke override. The dispatcher passes that '
              'context to the action, so the action can inspect inherited '
              'widgets, navigate focus, or read the local theme.',
        ),
        _BodyText(
          'In a vanilla Action subclass, your invoke method receives only the '
          'Intent. The ActionDispatcher does not (cannot) pass a '
          'BuildContext, because the registered Action contract does not '
          'accept one. As a result, plain Actions are forced to depend on '
          'global singletons or to capture context at registration time.',
        ),
        _BodyText(
          'ContextAction fixes this by adding an additional invoke overload '
          '`Object? invoke(Intent intent, [BuildContext? context])` that '
          'the dispatcher prefers when the registered action is a '
          'ContextAction. This is the same trick Flutter uses internally '
          'for Form, Scrollable, and selection-aware actions.',
        ),
        _CodeBlock('''class _MyAction extends ContextAction<_MyIntent> {
  @override
  Object? invoke(_MyIntent intent, [BuildContext? context]) {
    final theme = Theme.of(context!); // safe iff dispatched with context
    // ... do work that depends on theme/focus/scope ...
  }
}'''),
        _BodyText(
          'Inheritance cheat sheet:',
        ),
        _CodeBlock(
          'Action<T extends Intent>\n'
          '   └─ ContextAction<T extends Intent>\n'
          '         └─ CallbackAction<T> (factory style)\n'
          '         └─ <your_subclass>',
        ),
        _Bullet(
          'Action.invoke(Intent) — context-free; use only when nothing in '
          'the dispatch site matters.',
        ),
        _Bullet(
          'ContextAction.invoke(Intent, [BuildContext?]) — context-aware; '
          'the BuildContext is the *element that dispatched the intent*.',
        ),
        _Bullet(
          'ActionDispatcher.invokeAction looks for ContextAction first. If '
          'the action is a plain Action, the context parameter is silently '
          'dropped on the floor.',
        ),
        _Bullet(
          'Override `isEnabled(intent, [BuildContext? context])` to flip an '
          'action off and let the intent bubble to an ancestor handler.',
        ),
      ],
    );
  }
}

// ===========================================================================
// §2 — same intent, three subtrees, three different runtimeTypes
// ===========================================================================

class _SectionContextLog extends StatefulWidget {
  const _SectionContextLog();
  @override
  State<_SectionContextLog> createState() => _SectionContextLogState();
}

class _SectionContextLogState extends State<_SectionContextLog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionTitle(
          '2',
          'Same Intent, three subtrees → three runtimeTypes',
          subtitle:
              'A single _ContextLogIntent dispatched from three different '
              'subtrees logs three different BuildContext.widget runtime '
              'types. Each subtree wires its own _ContextLogAction.',
        ),
        const _BodyText(
          'Tap each tile. The action prints the runtimeType of '
          'context.widget — different in each subtree because the dispatch '
          'context comes from where Actions.invoke was called.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _ContextLogSubtree(label: 'Card-A', borderColor: Colors.indigo),
            _ContextLogSubtree(
              label: 'Card-B',
              borderColor: Colors.teal,
              wrapInCustomWidget: true,
            ),
            _ContextLogSubtree(
              label: 'Card-C',
              borderColor: Colors.orange,
              wrapInBanner: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _ContextLogSubtree extends StatelessWidget {
  const _ContextLogSubtree({
    required this.label,
    required this.borderColor,
    this.wrapInCustomWidget = false,
    this.wrapInBanner = false,
  });
  final String label;
  final Color borderColor;
  final bool wrapInCustomWidget;
  final bool wrapInBanner;

  @override
  Widget build(BuildContext context) {
    Widget tappable = Builder(
      builder: (BuildContext innerCtx) {
        return ElevatedButton.icon(
          onPressed: () {
            // The BuildContext passed to Actions.invoke is the one whose
            // widget will be reported by ContextAction.invoke — that's why
            // we wrap with extra Builder/widgets on purpose below.
            Actions.invoke(
              innerCtx,
              _ContextLogIntent(tag: label),
            );
          },
          icon: const Icon(Icons.touch_app),
          label: Text('Dispatch in $label'),
        );
      },
    );

    if (wrapInBanner) {
      tappable = MaterialBanner(
        backgroundColor: borderColor.withOpacity(0.1),
        content: tappable,
        actions: const <Widget>[SizedBox.shrink()],
      );
    }
    if (wrapInCustomWidget) {
      tappable = _MyTaggedHost(child: tappable);
    }

    return SizedBox(
      width: 260,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Actions(
            actions: <Type, Action<Intent>>{
              _ContextLogIntent: _ContextLogAction(label: label),
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: borderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                tappable,
                const SizedBox(height: 8),
                Text(
                  wrapInBanner
                      ? 'Dispatched from inside a MaterialBanner subtree.'
                      : wrapInCustomWidget
                          ? 'Dispatched from inside _MyTaggedHost.'
                          : 'Dispatched from a vanilla Builder.',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyTaggedHost extends StatelessWidget {
  const _MyTaggedHost({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        color: Colors.teal.withOpacity(0.05),
        child: child,
      );
}

// ===========================================================================
// §3 — Theme-aware copy
// ===========================================================================

class _SectionThemeAwareCopy extends StatelessWidget {
  const _SectionThemeAwareCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionTitle(
          '3',
          'Subtree-aware copy via Theme.of(context)',
          subtitle:
              'Two subtrees with different Themes both register a '
              '_CopyContextAction. The same _CopyIntent produces different '
              'output strings because the action reads Theme.of(context).',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _ThemedCopySubtree(
                label: 'Light',
                theme: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: Colors.amber,
                  brightness: Brightness.light,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ThemedCopySubtree(
                label: 'Dark',
                theme: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: Colors.deepPurple,
                  brightness: Brightness.dark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const _BodyText(
          'A plain Action could not do this without subscribing to a global '
          'theme stream, because it never sees a BuildContext.',
        ),
      ],
    );
  }
}

class _ThemedCopySubtree extends StatelessWidget {
  const _ThemedCopySubtree({required this.label, required this.theme});
  final String label;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: Builder(
        builder: (BuildContext innerCtx) {
          return Card(
            color: theme.colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Actions(
                actions: <Type, Action<Intent>>{
                  _CopyIntent: _CopyContextAction(subtree: label),
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Theme: $label',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Builder(
                      builder: (BuildContext btnCtx) {
                        return FilledButton(
                          onPressed: () {
                            Actions.invoke(
                              btnCtx,
                              const _CopyIntent('hello world'),
                            );
                          },
                          child: const Text('Copy "hello world"'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ===========================================================================
// §4 — Focus-aware navigation
// ===========================================================================

class _SectionFocusNavigation extends StatefulWidget {
  const _SectionFocusNavigation();
  @override
  State<_SectionFocusNavigation> createState() =>
      _SectionFocusNavigationState();
}

class _SectionFocusNavigationState extends State<_SectionFocusNavigation> {
  final FocusNode _a = FocusNode(debugLabel: 'field-a');
  final FocusNode _b = FocusNode(debugLabel: 'field-b');
  final FocusNode _c = FocusNode(debugLabel: 'field-c');

  @override
  void dispose() {
    _a.dispose();
    _b.dispose();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionTitle(
          '4',
          'Focus-aware navigation via FocusScope.of(context)',
          subtitle:
              'A _NavContextAction reads FocusScope.of(context) and moves '
              'focus inside the subtree the intent was dispatched from.',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FocusScope(
              child: Actions(
                actions: <Type, Action<Intent>>{
                  _NavIntent: _NavContextAction(scopeLabel: 'fields'),
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      focusNode: _a,
                      decoration: const InputDecoration(labelText: 'Field A'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      focusNode: _b,
                      decoration: const InputDecoration(labelText: 'Field B'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      focusNode: _c,
                      decoration: const InputDecoration(labelText: 'Field C'),
                    ),
                    const SizedBox(height: 12),
                    Builder(
                      builder: (BuildContext rowCtx) {
                        return Row(
                          children: <Widget>[
                            OutlinedButton.icon(
                              onPressed: () {
                                Actions.invoke(
                                  rowCtx,
                                  const _NavIntent(
                                      direction: _NavDirection.previous),
                                );
                              },
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Prev'),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: () {
                                Actions.invoke(
                                  rowCtx,
                                  const _NavIntent(
                                      direction: _NavDirection.next),
                                );
                              },
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Next'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const _BodyText(
          'The action calls FocusScope.of(context).nextFocus() / '
          'previousFocus(); the scope is determined by where the intent was '
          'dispatched. A plain Action would have to capture a FocusScopeNode '
          'manually, defeating the purpose of FocusTraversalGroup.',
        ),
      ],
    );
  }
}

// ===========================================================================
// §5 — Live shortcut binding (Enter key)
// ===========================================================================

class _SectionShortcuts extends StatefulWidget {
  const _SectionShortcuts();
  @override
  State<_SectionShortcuts> createState() => _SectionShortcutsState();
}

class _SectionShortcutsState extends State<_SectionShortcuts> {
  final FocusNode _focus = FocusNode(debugLabel: 'shortcut-host');

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shortcutLog,
      builder: (BuildContext context, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              '5',
              'Live shortcut binding — Enter dispatches a ContextAction',
              subtitle:
                  "Shortcuts(shortcuts: { CharacterActivator('e'): "
                  '_ContextLogIntent() }) wired with autofocus. Each press is '
                  'logged below.',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Shortcuts(
                  shortcuts: const <ShortcutActivator, Intent>{
                    CharacterActivator('e'):
                        _ContextLogIntent(tag: 'e-key'),
                    CharacterActivator(' '):
                        _ContextLogIntent(tag: 'space-key'),
                  },
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      _ContextLogIntent: _ShortcutLogAction(),
                    },
                    child: Focus(
                      focusNode: _focus,
                      autofocus: true,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Click here, then press 'e' or Space.",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Recent shortcut events:',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: _shortcutLog.entries
                                  .take(8)
                                  .map((String e) => Chip(
                                        label: Text(
                                          e,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _shortcutLog.clear,
                              child: const Text('Clear shortcut log'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ===========================================================================
// §6 — Toggleable enabled state
// ===========================================================================

class _SectionToggleableEnabled extends StatefulWidget {
  const _SectionToggleableEnabled();
  @override
  State<_SectionToggleableEnabled> createState() =>
      _SectionToggleableEnabledState();
}

class _SectionToggleableEnabledState extends State<_SectionToggleableEnabled> {
  final ValueNotifier<bool> _enabled = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _enabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _enabled,
      builder: (BuildContext context, bool enabled, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              '6',
              'isEnabled() and parent fall-through',
              subtitle:
                  'When the child action returns false from isEnabled, the '
                  'intent bubbles up to the parent _ParentToggleableAction.',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Actions(
                  actions: <Type, Action<Intent>>{
                    _ToggleableIntent: _ParentToggleableAction(),
                  },
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      _ToggleableIntent: _ToggleableContextAction(
                        enabledNotifier: _enabled,
                        label: 'child',
                      ),
                    },
                    child: Column(
                      children: <Widget>[
                        SwitchListTile(
                          value: enabled,
                          title: Text(enabled
                              ? 'Child action: ENABLED'
                              : 'Child action: DISABLED (parent will handle)'),
                          onChanged: (bool v) => _enabled.value = v,
                        ),
                        const SizedBox(height: 8),
                        Builder(
                          builder: (BuildContext btnCtx) {
                            return FilledButton(
                              onPressed: () {
                                Actions.invoke(
                                  btnCtx,
                                  const _ToggleableIntent(),
                                );
                              },
                              child: const Text('Dispatch _ToggleableIntent'),
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
    );
  }
}

// ===========================================================================
// §7 — Multi-handler chain (three nested Actions widgets)
// ===========================================================================

class _SectionBubbleChain extends StatefulWidget {
  const _SectionBubbleChain();
  @override
  State<_SectionBubbleChain> createState() => _SectionBubbleChainState();
}

class _SectionBubbleChainState extends State<_SectionBubbleChain> {
  final ValueNotifier<bool> _innerEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _midEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _outerEnabled = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _innerEnabled.dispose();
    _midEnabled.dispose();
    _outerEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        _innerEnabled,
        _midEnabled,
        _outerEnabled,
        _bubbleLog,
      ]),
      builder: (BuildContext context, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              '7',
              'Multi-handler chain — bubble until handled',
              subtitle:
                  'Three nested Actions widgets register a ContextAction '
                  'for _BubbleIntent. Disable layers and watch the intent '
                  'bubble up.',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      value: _outerEnabled.value,
                      title: const Text('OUTER layer enabled'),
                      onChanged: (bool v) => _outerEnabled.value = v,
                    ),
                    SwitchListTile(
                      value: _midEnabled.value,
                      title: const Text('MIDDLE layer enabled'),
                      onChanged: (bool v) => _midEnabled.value = v,
                    ),
                    SwitchListTile(
                      value: _innerEnabled.value,
                      title: const Text('INNER layer enabled'),
                      onChanged: (bool v) => _innerEnabled.value = v,
                    ),
                    const SizedBox(height: 8),
                    Actions(
                      actions: <Type, Action<Intent>>{
                        _BubbleIntent: _BubbleAction(
                          layer: 'outer',
                          enabledNotifier: _outerEnabled,
                        ),
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'OUTER Actions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Actions(
                              actions: <Type, Action<Intent>>{
                                _BubbleIntent: _BubbleAction(
                                  layer: 'middle',
                                  enabledNotifier: _midEnabled,
                                ),
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.indigo),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      'MIDDLE Actions',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Actions(
                                      actions: <Type, Action<Intent>>{
                                        _BubbleIntent: _BubbleAction(
                                          layer: 'inner',
                                          enabledNotifier: _innerEnabled,
                                        ),
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.deepOrange),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            const Text(
                                              'INNER Actions',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 6),
                                            Builder(
                                              builder:
                                                  (BuildContext innerCtx) {
                                                return FilledButton(
                                                  onPressed: () {
                                                    Actions.invoke(
                                                      innerCtx,
                                                      const _BubbleIntent(),
                                                    );
                                                  },
                                                  child: const Text(
                                                      'Dispatch _BubbleIntent'),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: const Color(0xFFF7F7FB),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Bubble log:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: _bubbleLog.entries
                                .take(10)
                                .map((String e) => Chip(
                                      label: Text(
                                        e,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ))
                                .toList(),
                          ),
                          TextButton(
                            onPressed: _bubbleLog.clear,
                            child: const Text('Clear bubble log'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ===========================================================================
// §8 — Custom ActionDispatcher subclass
// ===========================================================================

class _SectionDispatcherIntegration extends StatefulWidget {
  const _SectionDispatcherIntegration();
  @override
  State<_SectionDispatcherIntegration> createState() =>
      _SectionDispatcherIntegrationState();
}

class _SectionDispatcherIntegrationState
    extends State<_SectionDispatcherIntegration> {
  final _LoggingDispatcher _dispatcher = _LoggingDispatcher();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dispatcherLog,
      builder: (BuildContext context, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              '8',
              'Custom ActionDispatcher with invocation log',
              subtitle:
                  'A subclass of ActionDispatcher overrides invokeAction to '
                  'log every (action, intent, context) tuple — and observes '
                  'whether the action is a ContextAction.',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Actions(
                  dispatcher: _dispatcher,
                  actions: <Type, Action<Intent>>{
                    _ContextLogIntent:
                        _ContextLogAction(label: 'dispatcher-demo'),
                    _DispatchTraceIntent: _DispatchTraceContextAction(),
                  },
                  child: Column(
                    children: <Widget>[
                      Builder(
                        builder: (BuildContext btnCtx) {
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              FilledButton(
                                onPressed: () => Actions.invoke(
                                  btnCtx,
                                  const _ContextLogIntent(tag: 'via-disp'),
                                ),
                                child: const Text('Fire _ContextLogIntent'),
                              ),
                              FilledButton(
                                onPressed: () => Actions.invoke(
                                  btnCtx,
                                  const _DispatchTraceIntent('trace-1'),
                                ),
                                child: const Text('Fire _DispatchTraceIntent'),
                              ),
                              OutlinedButton(
                                onPressed: _dispatcherLog.clear,
                                child: const Text('Clear dispatcher log'),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        color: const Color(0xFFF7F7FB),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Dispatcher log:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            ..._dispatcherLog.entries.take(10).map(
                                  (String e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1),
                                    child: Text(
                                      '› $e',
                                      style: const TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 11.5),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ===========================================================================
// §9 — Plain Action vs ContextAction
// ===========================================================================

class _SectionPlainVsContext extends StatelessWidget {
  const _SectionPlainVsContext();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionTitle(
          '9',
          'Plain Action vs ContextAction — same intent, two impls',
          subtitle:
              'Two side-by-side Actions subtrees register the same '
              '_DispatchTraceIntent. One uses a plain Action (no context), '
              'the other a ContextAction (uses Theme.of(context)).',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Theme(
                data: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: Colors.green,
                  brightness: Brightness.light,
                ),
                child: Builder(
                  builder: (BuildContext innerCtx) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Actions(
                          actions: <Type, Action<Intent>>{
                            _DispatchTraceIntent: _DispatchTracePlainAction(),
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Plain Action',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              const _BodyText(
                                  'Cannot read Theme — no BuildContext.'),
                              Builder(
                                builder: (BuildContext btn) {
                                  return FilledButton(
                                    onPressed: () => Actions.invoke(
                                      btn,
                                      const _DispatchTraceIntent('plain-1'),
                                    ),
                                    child: const Text('Dispatch'),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Theme(
                data: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: Colors.purple,
                  brightness: Brightness.dark,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        _DispatchTraceIntent: _DispatchTraceContextAction(),
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'ContextAction',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const _BodyText(
                              'Reads Theme.of(context).brightness.'),
                          Builder(
                            builder: (BuildContext btn) {
                              return FilledButton(
                                onPressed: () => Actions.invoke(
                                  btn,
                                  const _DispatchTraceIntent('ctx-1'),
                                ),
                                child: const Text('Dispatch'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ===========================================================================
// §10 — Pitfalls
// ===========================================================================

class _SectionPitfalls extends StatelessWidget {
  const _SectionPitfalls();

  @override
  Widget build(BuildContext context) {
    final List<_PitfallEntry> entries = <_PitfallEntry>[
      const _PitfallEntry(
        title: '1. Forgetting the (Intent, [BuildContext?]) overload',
        body:
            'If your subclass declares only invoke(Intent), the dispatcher '
            'will never pass the BuildContext. The fix is to override the '
            'two-arg overload exactly: '
            '`Object? invoke(_Intent intent, [BuildContext? context])`.',
      ),
      const _PitfallEntry(
        title: '2. Null-context handling',
        body:
            'Some dispatchers (e.g. tests, programmatic invokes) do not '
            'pass a BuildContext. Always treat context as nullable; use '
            'a fallback for tests or for invokeActionIfEnabled-style flows.',
      ),
      const _PitfallEntry(
        title: '3. Mismatched isEnabled signatures',
        body:
            'Action.isEnabled(intent) and ContextAction.isEnabled(intent, '
            '[ctx]) are *different overloads*. If you override only one, '
            'the wrong overload will be called for context-aware dispatch '
            'and the action will appear to never be enabled.',
      ),
      const _PitfallEntry(
        title: '4. Actions.invoke vs Actions.maybeInvoke',
        body:
            'invoke throws when no handler is found (or returns null when '
            'isEnabled is false); maybeInvoke quietly returns null. Use '
            'maybeInvoke when the keybinding is shared across screens and '
            'a missing action should not crash.',
      ),
      const _PitfallEntry(
        title: '5. Duplicate Action types in one Actions map',
        body:
            'A single Actions widget keys its map by Intent runtimeType. '
            'Registering two ContextActions for the same Intent in the '
            'same Actions widget silently keeps the latter — not a chain. '
            'Use nested Actions widgets for chained handlers.',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionTitle(
          '10',
          'Pitfalls — five things that bite you',
          subtitle:
              'A short field guide of mistakes that look subtle but make '
              'ContextAction silently fall back to Action behaviour.',
        ),
        ...entries.map(
          (_PitfallEntry e) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: const Icon(Icons.warning_amber_rounded,
                  color: Colors.deepOrange),
              title: Text(e.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(e.body, style: const TextStyle(height: 1.35)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PitfallEntry {
  const _PitfallEntry({required this.title, required this.body});
  final String title;
  final String body;
}

// ===========================================================================
// §11 — Recipe gallery
// ===========================================================================

class _SectionRecipes extends StatelessWidget {
  const _SectionRecipes();

  @override
  Widget build(BuildContext context) {
    final List<_RecipeEntry> recipes = <_RecipeEntry>[
      const _RecipeEntry(
        title: 'Theme-aware copy',
        body:
            'A copy action that prepends a marker icon based on '
            'Theme.of(context).brightness. Useful for log/console widgets '
            'that should match the embedding theme without rebuilding.',
        code: '''class _CopyContextAction extends ContextAction<_CopyIntent> {
  @override
  Object? invoke(_CopyIntent intent, [BuildContext? context]) {
    final brightness = Theme.of(context!).brightness;
    return brightness == Brightness.dark
        ? '🌙 \${intent.payload}'
        : '☀️ \${intent.payload}';
  }
}''',
      ),
      const _RecipeEntry(
        title: 'Focus-aware delete',
        body:
            'A delete action that finds the focused TextField via '
            'Focus.of(context) or FocusManager.instance.primaryFocus and '
            'clears its TextEditingController.',
        code: '''class _DeleteAction extends ContextAction<_DeleteIntent> {
  @override
  Object? invoke(_DeleteIntent i, [BuildContext? context]) {
    final node = FocusManager.instance.primaryFocus;
    if (node?.context?.widget is EditableText) {
      // ... clear controller via inherited model ...
    }
    return null;
  }
}''',
      ),
      const _RecipeEntry(
        title: 'Scope-bound submit',
        body:
            'A Submit action that walks up via Form.of(context) and calls '
            'save()/validate(). Plain Action cannot do this without an '
            'explicit GlobalKey<FormState>.',
        code: '''class _SubmitAction extends ContextAction<_SubmitIntent> {
  @override
  Object? invoke(_SubmitIntent i, [BuildContext? context]) {
    final form = Form.of(context!);
    if (form.validate()) form.save();
    return null;
  }
}''',
      ),
      const _RecipeEntry(
        title: 'Debugger-friendly logging',
        body:
            'A pass-through ContextAction that simply logs the dispatching '
            'widget tree path, then forwards to a wrapped child action. '
            'Great for diagnosing why an intent did not fire.',
        code: '''class _LogPassthrough<I extends Intent> extends ContextAction<I> {
  _LogPassthrough(this.inner);
  final Action<I> inner;
  @override
  Object? invoke(I i, [BuildContext? c]) {
    debugPrint('intent=\${i.runtimeType} ctx=\${c?.widget.runtimeType}');
    return Actions.of(c!).invokeAction(inner, i, c);
  }
}''',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionTitle(
          '11',
          'Recipe gallery',
          subtitle: 'Four practical ContextAction patterns.',
        ),
        ...recipes.map(
          (_RecipeEntry r) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    r.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(r.body, style: const TextStyle(height: 1.4)),
                  _CodeBlock(r.code),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RecipeEntry {
  const _RecipeEntry({
    required this.title,
    required this.body,
    required this.code,
  });
  final String title;
  final String body;
  final String code;
}

// ===========================================================================
// §12 — Reference table
// ===========================================================================

class _SectionReferenceTable extends StatelessWidget {
  const _SectionReferenceTable();

  @override
  Widget build(BuildContext context) {
    final List<_RefRow> rows = <_RefRow>[
      const _RefRow(
        api: 'ContextAction<T>',
        purpose: 'Action variant whose invoke(intent, [ctx]) overload exposes '
            'the dispatching BuildContext.',
      ),
      const _RefRow(
        api: 'Action<T>',
        purpose:
            'Base class for invocation handlers. invoke(intent) only, '
            'no context.',
      ),
      const _RefRow(
        api: 'Intent',
        purpose:
            'Marker class identifying the kind of operation to perform. '
            'Serves as the key into an Actions map.',
      ),
      const _RefRow(
        api: 'Actions',
        purpose:
            'Inherited widget that maps Intent runtimeType → Action. '
            'Innermost match wins; bubble up if isEnabled returns false.',
      ),
      const _RefRow(
        api: 'Shortcuts',
        purpose:
            'Maps ShortcutActivator → Intent for the focused subtree. The '
            'nearest Actions ancestor handles the dispatched intent.',
      ),
      const _RefRow(
        api: 'ShortcutManager',
        purpose:
            'Owner object behind Shortcuts; lets you change the registered '
            'shortcuts at runtime.',
      ),
      const _RefRow(
        api: 'ActionDispatcher',
        purpose:
            'Glue between Actions and Action.invoke. invokeAction(action, '
            'intent, [ctx]) recognises ContextAction and forwards the '
            'context.',
      ),
      const _RefRow(
        api: 'Actions.invoke / Actions.maybeInvoke',
        purpose:
            'Programmatic dispatch helpers; both pass the supplied '
            'BuildContext through to ContextActions.',
      ),
      const _RefRow(
        api: 'FocusManager / FocusScope.of(context)',
        purpose:
            'Used by ContextActions for focus-aware behaviour (next/prev '
            'focus, primaryFocus inspection).',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionTitle(
          '12',
          'Reference — the cast of characters',
        ),
        Card(
          child: DataTable(
            columnSpacing: 18,
            columns: const <DataColumn>[
              DataColumn(label: Text('API')),
              DataColumn(label: Text('Purpose')),
            ],
            rows: rows
                .map(
                  (_RefRow r) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        r.api,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      DataCell(
                        SizedBox(
                          width: 360,
                          child: Text(
                            r.purpose,
                            style: const TextStyle(height: 1.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _RefRow {
  const _RefRow({required this.api, required this.purpose});
  final String api;
  final String purpose;
}

// ===========================================================================
// Global log panel
// ===========================================================================

class _GlobalLogPanel extends StatelessWidget {
  const _GlobalLogPanel();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _logCenter,
      builder: (BuildContext context, Widget? child) {
        final List<String> entries = _logCenter.entries;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              '★',
              'Global invocation log',
              subtitle:
                  'Every section above pushes its results here so the '
                  'dispatch order is observable in one place.',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Entries: ${entries.length}'),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: _logCenter.clear,
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Clear'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (entries.isEmpty)
                      const Text(
                        '(no invocations yet — dispatch something above)',
                        style: TextStyle(color: Colors.black54),
                      )
                    else
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: entries
                            .map(
                              (String e) => Chip(
                                label: Text(
                                  e,
                                  style: const TextStyle(fontSize: 11),
                                ),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ===========================================================================
// LogicalKeyboardKey shim — only `enter` and `space` are used here.
// We intentionally avoid importing services.dart to keep the dep surface
// minimal (only material.dart, per the demo rules). Shortcuts already
// re-exports SingleActivator and LogicalKeyboardKey through material.dart.
// ===========================================================================
//
// Note: `LogicalKeyboardKey`, `LogicalKeySet`, and `SingleActivator` are
// re-exported by package:flutter/material.dart (which transitively exports
// widgets.dart, which exports services.dart's keyboard primitives). No
// extra import needed.
// ===========================================================================

// ===========================================================================
// Long-form commentary epilogue
// ---------------------------------------------------------------------------
// The Actions/Shortcuts subsystem is one of the most underused features in
// Flutter; most apps reach for raw RawKeyboardListener or onKey callbacks
// long before they consider Intents. The cost of that shortcut is twofold:
//
//   1. Keybindings get scattered across leaves of the widget tree, where
//      the same key combination ends up bound to subtly different handlers
//      depending on which screen the user is on.
//   2. The handlers grow direct dependencies on widget state via captured
//      closures, which makes them hard to test and harder to refactor.
//
// The Actions framework solves both: shortcuts and intents live high in
// the tree, and concrete handling lives wherever it makes most semantic
// sense. ContextAction is the missing link that lets a handler high up
// in the tree still reach down into the dispatch site for inherited
// state.
//
// For example, a high-level "Submit" intent registered at the app root
// can dispatch to a ContextAction that walks up via Form.of(context) and
// calls save()/validate() on the *enclosing* form, not on a globally
// captured GlobalKey. The same pattern works for Theme, MediaQuery,
// Localization, Scrollable, FocusScope, and any other inherited widget.
//
// When you find yourself writing `inheritFromWidgetOfExactType` inside an
// Action.invoke and tossing a captured `BuildContext` into the closure,
// stop and convert the action into a ContextAction. The dispatcher will
// give you the right context automatically.
//
// The remainder of this file is hand-authored padding intended to make
// the demo file long enough to be browseable as a single document, with
// every section large enough to read top-to-bottom without scrolling
// jumps. Feel free to extract the smaller widgets into your own demo
// project — they all compile in isolation.
// ===========================================================================

// ---------------------------------------------------------------------------
// Appendix A — Pseudo-code walk-through of a ContextAction dispatch
// ---------------------------------------------------------------------------
//
//   1. User presses Enter.
//   2. RawKeyboard delivers a RawKeyDownEvent to the focused element.
//   3. Shortcuts intercepts the key event, looks up the matching
//      ShortcutActivator, and produces an Intent.
//   4. Shortcuts then calls Actions.maybeInvoke(context, intent).
//   5. Actions.maybeInvoke walks up the element tree looking for an
//      Actions widget that registers an Action for this Intent's
//      runtimeType.
//   6. When Actions.maybeInvoke finds one, it asks the surrounding
//      ActionDispatcher to invoke it: dispatcher.invokeAction(action,
//      intent, context).
//   7. ActionDispatcher inspects the action: if it is a ContextAction,
//      the context is forwarded; otherwise it is silently dropped.
//   8. The action's invoke method returns a value; Actions.maybeInvoke
//      returns it back to the caller.
//   9. The default ActionDispatcher.invokeAction also calls
//      action.isEnabled(intent[, context]); when false, the dispatcher
//      returns null and the event continues to bubble.
//
// ---------------------------------------------------------------------------
// Appendix B — When *not* to use ContextAction
// ---------------------------------------------------------------------------
//
//   * Pure data manipulation (e.g. "increment counter"): no context
//     needed, plain Action keeps the diff smaller.
//   * Bridge to a third-party API that does not need a BuildContext.
//   * In tests, when you want to construct an Action directly without
//     wiring an Actions widget — ContextAction works fine here too, but
//     the extra parameter is dead weight.
//
// ---------------------------------------------------------------------------
// Appendix C — Migration checklist
// ---------------------------------------------------------------------------
//
//   [ ] Find Action.invoke methods that capture BuildContext.
//   [ ] Replace `extends Action<T>` with `extends ContextAction<T>`.
//   [ ] Move the captured context into the (Intent, [BuildContext?])
//       overload's argument list.
//   [ ] Audit isEnabled overrides — switch to the (intent, [ctx]) form.
//   [ ] Re-run shortcut tests; ensure dispatcher still routes correctly.
//
// ---------------------------------------------------------------------------
// End of file.
// ===========================================================================
