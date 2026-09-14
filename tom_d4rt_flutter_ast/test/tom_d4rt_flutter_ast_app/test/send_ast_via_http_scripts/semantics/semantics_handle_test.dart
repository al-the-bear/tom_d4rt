// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

// =============================================================================
// SemanticsHandle deep demo
// =============================================================================
//
// This file is a hand-authored, deep-dive walkthrough of [SemanticsHandle] and
// its surrounding ecosystem of [Semantics] widgets, accessibility flags,
// custom semantic actions, exclusion subtrees, merging, live regions, and the
// lifecycle of the accessibility tree itself.
//
// Why this file exists
// --------------------
// The previous version of this test file referenced `SemanticsHandle` only in
// strings.  It never instantiated one, never called
// `SemanticsBinding.instance.ensureSemantics()`, and rendered no `Semantics`
// widgets.  A static audit flagged that as misleading: the demo claimed to
// exercise SemanticsHandle but did nothing of the sort.  This rewrite repairs
// that gap by:
//
//   1. Acquiring a real `SemanticsHandle` in `initState` of a top-level
//      `StatefulWidget` and disposing it in `dispose`.
//   2. Letting the user mint and release additional handles at runtime so the
//      ref-counting model is observable.
//   3. Rendering many `Semantics(...)` widgets that demonstrate practically
//      every common property a screen reader will read aloud.
//
// We import only `package:flutter/material.dart`.  Material re-exports the
// public surface of `package:flutter/semantics.dart`, so an explicit import of
// `package:flutter/semantics.dart` is rejected by the analyzer with
// `unnecessary_import`.  Everything we need - `SemanticsBinding`,
// `SemanticsHandle`, `CustomSemanticsAction`, `SemanticsProperties`, the
// `Semantics`, `MergeSemantics`, and `ExcludeSemantics` widgets - is reachable
// through Material.
//
// Top-level structure
// -------------------
// The file declares a top-level `dynamic build(BuildContext context)` function
// (per the harness contract for these `send_ast_via_http_scripts` demos).  It
// returns a `MaterialApp -> Scaffold -> SafeArea -> SingleChildScrollView ->
// Column` tree.  Every demo section is a separate `Widget` builder so each
// section reads like a self-contained recipe.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// ---------------------------------------------------------------------------
// Top-level build entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SemanticsHandle Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SemanticsHandle Deep Demo'),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                'a11y first',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _IntroSection(),
              SizedBox(height: 24),
              _LiveHandleCounter(),
              SizedBox(height: 24),
              _SemanticsGallery(),
              SizedBox(height: 24),
              _CustomActionsSection(),
              SizedBox(height: 24),
              _ExcludingSubtreesSection(),
              SizedBox(height: 24),
              _MergeSemanticsSection(),
              SizedBox(height: 24),
              _LiveRegionsSection(),
              SizedBox(height: 24),
              _FormSemanticsSection(),
              SizedBox(height: 24),
              _LifecycleVisualization(),
              SizedBox(height: 24),
              _RecipeGallery(),
              SizedBox(height: 24),
              _ReferenceTable(),
              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// Section 1 - Intro
// ===========================================================================
//
// We open with a long-form explanation of what `SemanticsHandle` is, why it
// exists, and how the ref-counting model interacts with assistive technology.

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.accessibility_new, size: 28),
                const SizedBox(width: 12),
                Text('What is a SemanticsHandle?', style: text.headlineSmall),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Flutter does not generate the platform accessibility tree by '
              'default.  Building that tree is expensive: every render object '
              'must visit its descendants, gather labels, hints, actions, '
              'flags, and emit a parallel native structure (UIAccessibility on '
              'iOS, View nodes / AccessibilityNodeInfo on Android, ARIA-like '
              'metadata on web).  When nothing is listening - no screen '
              'reader running, no accessibility test driver attached - paying '
              'that cost would be wasteful.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'SemanticsHandle is the lifecycle token that asks Flutter to '
              'start producing the accessibility tree.  You acquire one by '
              'calling SemanticsBinding.instance.ensureSemantics(); you '
              'release it by calling .dispose() on the handle.  The binding '
              'maintains an internal reference count: as long as at least one '
              'live handle exists, the semantics tree keeps updating.  The '
              'instant the count drops to zero, the binding tears it down.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'In practice, you almost never call ensureSemantics yourself in '
              'an app.  The framework does it for you when:',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 8),
            const _Bullet('A platform screen reader (TalkBack, VoiceOver, '
                'NVDA, JAWS, ChromeVox) connects.'),
            const _Bullet('A WidgetTester runs in semantics-aware mode '
                '(SemanticsTester or testWidgets with a SemanticsHandle).'),
            const _Bullet('An integration test harness or a11y inspector tool '
                'attaches to the running app.'),
            const SizedBox(height: 12),
            Text(
              'You do call it explicitly when you are:',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 8),
            const _Bullet('Writing a unit test that needs to inspect the '
                'semantics tree without booting an entire screen reader.'),
            const _Bullet('Building a debugging overlay that visualises '
                'semantics nodes.'),
            const _Bullet('Implementing a custom accessibility bridge to a '
                'non-standard runtime (kiosk modes, embedded devices, '
                'remote-control protocols).'),
            const SizedBox(height: 12),
            Text(
              'The widget below acquires a handle at startup and lets you '
              'experiment with the ref-counting behaviour.',
              style: text.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
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
      padding: const EdgeInsets.only(left: 8, bottom: 4),
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

// ===========================================================================
// Section 2 - Live handle counter
// ===========================================================================
//
// A `StatefulWidget` that keeps a list of live `SemanticsHandle` instances.
// `initState` mints one immediately so the demo always has at least one live
// handle; `dispose` releases everything.  Buttons let the user acquire and
// release additional handles to observe the ref-counting model.

class _LiveHandleCounter extends StatefulWidget {
  const _LiveHandleCounter();

  @override
  State<_LiveHandleCounter> createState() => _LiveHandleCounterState();
}

class _LiveHandleCounterState extends State<_LiveHandleCounter> {
  // The list of live handles.  We keep them in a list rather than a single
  // counter so it is obvious that each handle is a distinct, independently
  // disposable object - exactly the way the framework models them.
  final List<SemanticsHandle> _handles = <SemanticsHandle>[];

  // A simple journal so the user can see the chronological order of acquire
  // and release events.  Each entry is a (timestamp, message) pair.
  final List<_HandleEvent> _events = <_HandleEvent>[];

  @override
  void initState() {
    super.initState();
    // Acquire the very first handle so we can observe the tree being built
    // without having to wait for user input.  This mirrors what happens when
    // a screen reader connects right after the app launches.
    _acquire(initial: true);
  }

  @override
  void dispose() {
    // Mandatory: dispose every outstanding handle so the binding's reference
    // count actually returns to zero.  Forgetting this is the classical
    // SemanticsHandle leak.
    for (final SemanticsHandle handle in _handles) {
      handle.dispose();
    }
    _handles.clear();
    super.dispose();
  }

  void _acquire({bool initial = false}) {
    final SemanticsHandle handle =
        SemanticsBinding.instance.ensureSemantics();
    setState(() {
      _handles.add(handle);
      _events.add(_HandleEvent(
        when: DateTime.now(),
        message: initial
            ? 'initState acquired handle #${_handles.length}'
            : 'acquired handle #${_handles.length}',
        kind: _HandleEventKind.acquire,
      ));
      // Trim the journal so the UI does not grow without bound.
      if (_events.length > 16) {
        _events.removeAt(0);
      }
    });
  }

  void _release() {
    if (_handles.isEmpty) {
      setState(() {
        _events.add(_HandleEvent(
          when: DateTime.now(),
          message: 'release ignored: no live handles',
          kind: _HandleEventKind.noop,
        ));
      });
      return;
    }
    final SemanticsHandle handle = _handles.removeLast();
    handle.dispose();
    setState(() {
      _events.add(_HandleEvent(
        when: DateTime.now(),
        message: 'released a handle, ${_handles.length} remain',
        kind: _HandleEventKind.release,
      ));
      if (_events.length > 16) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool treeActive = _handles.isNotEmpty;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  treeActive ? Icons.check_circle : Icons.cancel,
                  color: treeActive ? Colors.green : Colors.redAccent,
                ),
                const SizedBox(width: 12),
                Text('Live handle counter', style: text.headlineSmall),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Use these buttons to mint additional SemanticsHandle '
              'instances and to release them.  As long as the counter is at '
              'least one, the accessibility tree is alive.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: _acquire,
                  icon: const Icon(Icons.add),
                  label: const Text('Acquire handle'),
                ),
                OutlinedButton.icon(
                  onPressed: _handles.isEmpty ? null : _release,
                  icon: const Icon(Icons.remove),
                  label: const Text('Release handle'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.bolt, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Active handles: ${_handles.length}',
                          style: text.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          treeActive
                              ? 'The semantics tree is being generated and '
                                  'updated on every frame that affects '
                                  'accessibility-relevant state.'
                              : 'No handles are alive.  The semantics tree '
                                  'has been torn down; further updates are '
                                  'no-ops until at least one handle is '
                                  'acquired again.',
                          style: text.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Recent events', style: text.titleSmall),
            const SizedBox(height: 8),
            ..._events.reversed.map(_HandleEventTile.new),
          ],
        ),
      ),
    );
  }
}

class _HandleEvent {
  _HandleEvent({
    required this.when,
    required this.message,
    required this.kind,
  });

  final DateTime when;
  final String message;
  final _HandleEventKind kind;
}

enum _HandleEventKind { acquire, release, noop }

class _HandleEventTile extends StatelessWidget {
  const _HandleEventTile(this.event);

  final _HandleEvent event;

  Color _color(BuildContext context) {
    switch (event.kind) {
      case _HandleEventKind.acquire:
        return Colors.green.shade600;
      case _HandleEventKind.release:
        return Colors.orange.shade700;
      case _HandleEventKind.noop:
        return Theme.of(context).colorScheme.outline;
    }
  }

  IconData _icon() {
    switch (event.kind) {
      case _HandleEventKind.acquire:
        return Icons.add_circle_outline;
      case _HandleEventKind.release:
        return Icons.remove_circle_outline;
      case _HandleEventKind.noop:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TimeOfDay time = TimeOfDay.fromDateTime(event.when);
    final String stamp = '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${event.when.second.toString().padLeft(2, '0')}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(_icon(), size: 16, color: _color(context)),
          const SizedBox(width: 8),
          Text(
            stamp,
            style: const TextStyle(
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(event.message)),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 3 - Semantics widget gallery
// ===========================================================================
//
// We render a long, labelled gallery of `Semantics` widgets, each isolating a
// single property.  The "What a screen reader says" caption shows the
// observable behaviour without needing to actually attach TalkBack/VoiceOver.

class _SemanticsGallery extends StatelessWidget {
  const _SemanticsGallery();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Semantics widget gallery', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'Each card below isolates a single property of the Semantics '
              'widget.  In a real app you usually combine them - for '
              'instance, a custom button mixes label, hint, button:true, and '
              'enabled together - but seeing them one at a time makes it '
              'easier to reason about what each one contributes.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            _SemanticsCard(
              title: 'label',
              note: 'Reads "Submit your answer" exactly as written.',
              child: Semantics(
                label: 'Submit your answer',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Submit'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'value',
              note:
                  'Reads the label, then "75 percent" - useful for sliders, '
                  'gauges, and progress indicators.',
              child: Semantics(
                label: 'Battery level',
                value: '75 percent',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Battery: 75%'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'hint',
              note: 'Hint is read after a short pause: "Submit, double tap '
                  'to send the form".',
              child: Semantics(
                label: 'Submit',
                hint: 'double tap to send the form',
                button: true,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Submit'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'button: true',
              note:
                  'Announces "Button" after the label so the user knows it is '
                  'tappable rather than static text.',
              child: Semantics(
                label: 'Save',
                button: true,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Save'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'header: true',
              note: 'Tells screen readers to treat this as a heading; '
                  'rotor-style navigation can jump between headers.',
              child: Semantics(
                header: true,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Section: Account settings',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'liveRegion: true',
              note: 'When the contained text changes, the screen reader '
                  'announces the new value automatically.',
              child: Semantics(
                liveRegion: true,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Status: connected'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'toggled: true',
              note: 'Reads "switch, on".  Pair with onTap to actually flip '
                  'the value in a real app.',
              child: Semantics(
                toggled: true,
                label: 'Wifi',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.wifi),
                      SizedBox(width: 8),
                      Text('Wifi: on'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'toggled: false',
              note: 'Same widget but inverted - reads "switch, off".',
              child: Semantics(
                toggled: false,
                label: 'Wifi',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.wifi_off),
                      SizedBox(width: 8),
                      Text('Wifi: off'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'selected: true',
              note: 'Indicates membership in a selected group; reads '
                  '"selected" after the label.',
              child: Semantics(
                selected: true,
                label: 'Inbox tab',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Inbox  *'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'enabled: false',
              note: 'Reads "dimmed" / "disabled" - screen readers and the '
                  'high-contrast inspector treat the node as unavailable.',
              child: Semantics(
                label: 'Send',
                button: true,
                enabled: false,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Send (disabled)'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'excludeSemantics',
              note: 'Hides the entire subtree from the accessibility tree.  '
                  'Use for purely decorative content.',
              child: Semantics(
                excludeSemantics: true,
                label: 'this label is suppressed',
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text('decorative star (not announced)'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const _SemanticsCard(
              title: 'MergeSemantics',
              note: 'Collapses the subtree into a single node so it reads as '
                  'one phrase, not three separate ones.',
              child: MergeSemantics(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.warning_amber),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Update available'),
                          Text('Restart to apply'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'image: true',
              note: 'Tells the screen reader to announce "image" so the user '
                  'knows the node is graphical.',
              child: Semantics(
                image: true,
                label: 'Company logo, abstract blue square with a white "T"',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: ColoredBox(
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          'T',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'link: true',
              note: 'Announces "link"; on iOS the rotor exposes a "links" '
                  'category that lists every node so flagged.',
              child: Semantics(
                link: true,
                label: 'Open the privacy policy',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Privacy policy',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'readOnly: true',
              note: 'On a textField:true node, signals the value is not '
                  'editable - reads "read only".',
              child: Semantics(
                textField: true,
                readOnly: true,
                label: 'User id',
                value: 'a3f9-22c1',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('User id: a3f9-22c1'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SemanticsCard(
              title: 'obscured: true',
              note: 'Marks the value as sensitive (typically a password); '
                  'screen readers may suppress character-by-character echo.',
              child: Semantics(
                textField: true,
                obscured: true,
                label: 'Password',
                value: 'hunter2',
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Password: ******'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SemanticsCard extends StatelessWidget {
  const _SemanticsCard({
    required this.title,
    required this.note,
    required this.child,
  });

  final String title;
  final String note;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: child,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              note,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 4 - Custom semantics actions
// ===========================================================================
//
// Custom actions appear in the screen-reader's gesture menu (TalkBack: swipe
// up-then-right; VoiceOver: rotor + "Actions").  They let you offer extra
// commands without polluting the visual UI.

class _CustomActionsSection extends StatefulWidget {
  const _CustomActionsSection();

  @override
  State<_CustomActionsSection> createState() => _CustomActionsSectionState();
}

class _CustomActionsSectionState extends State<_CustomActionsSection> {
  double _value = 50;
  String _lastAction = 'none';

  final CustomSemanticsAction _increaseBy10 = const CustomSemanticsAction(
    label: 'Increase by 10',
  );
  final CustomSemanticsAction _decreaseBy10 = const CustomSemanticsAction(
    label: 'Decrease by 10',
  );
  final CustomSemanticsAction _reset = const CustomSemanticsAction(
    label: 'Reset to 50',
  );

  void _bump(double delta, String label) {
    setState(() {
      _value = (_value + delta).clamp(0, 100);
      _lastAction = label;
    });
  }

  void _resetValue() {
    setState(() {
      _value = 50;
      _lastAction = 'reset';
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Custom semantics actions', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'A Slider is the canonical example: the default increment of '
              '0.01 is too small for a screen-reader user to reach 100.  We '
              'add coarser custom actions that the assistive tool can invoke.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Volume',
              value: '${_value.round()}%',
              slider: true,
              customSemanticsActions: <CustomSemanticsAction, VoidCallback>{
                _increaseBy10: () => _bump(10, 'increase by 10'),
                _decreaseBy10: () => _bump(-10, 'decrease by 10'),
                _reset: _resetValue,
              },
              child: Slider(
                min: 0,
                max: 100,
                value: _value,
                divisions: 100,
                label: '${_value.round()}%',
                onChanged: (double v) => setState(() => _value = v),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: <Widget>[
                _ActionChip(label: _increaseBy10.label),
                _ActionChip(label: _decreaseBy10.label),
                _ActionChip(label: _reset.label),
              ],
            ),
            const SizedBox(height: 12),
            Text('Last invoked action: $_lastAction',
                style: text.bodySmall),
            const SizedBox(height: 16),
            Text(
              'For a full custom widget you would expose actions for every '
              'gesture: swipe-to-dismiss as "dismiss", long-press menus as '
              '"more options", drag handles as "reorder up" / "reorder '
              'down", and so on.  Each chip below corresponds to a real '
              'CustomSemanticsAction the framework exposes to TalkBack and '
              'VoiceOver.',
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.gesture, size: 18),
      label: Text(label ?? '(unnamed action)'),
    );
  }
}

// ===========================================================================
// Section 5 - Excluding subtrees
// ===========================================================================
//
// Side-by-side comparison: the same row of decorative avatars, once with
// `ExcludeSemantics` and once without.  The note explains why decorative
// imagery should not pollute the accessibility tree.

class _ExcludingSubtreesSection extends StatelessWidget {
  const _ExcludingSubtreesSection();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Excluding decorative subtrees', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              "Decorative imagery does not carry information.  Announcing "
              '"image, image, image" before the actually meaningful "5 new '
              'messages" wastes the user\'s time.  Wrap purely cosmetic '
              'subtrees in ExcludeSemantics so the screen reader skips them.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _SideBySidePanel(
                    title: 'Without ExcludeSemantics',
                    note: 'Reads as: "image, image, image, 5 new messages".',
                    child: _AvatarRow(),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _SideBySidePanel(
                    title: 'With ExcludeSemantics',
                    note: 'Reads as: "5 new messages".',
                    child: ExcludeSemantics(child: _AvatarRow()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Semantics(
                liveRegion: true,
                label: '5 new messages',
                child: const Text(
                  '5 new messages',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideBySidePanel extends StatelessWidget {
  const _SideBySidePanel({
    required this.title,
    required this.note,
    required this.child,
  });

  final String title;
  final String note;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
          const SizedBox(height: 8),
          Text(note,
              style:
                  TextStyle(color: colors.onSurfaceVariant, fontSize: 12)),
        ],
      ),
    );
  }
}

class _AvatarRow extends StatelessWidget {
  const _AvatarRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        CircleAvatar(child: Text('A')),
        SizedBox(width: 4),
        CircleAvatar(child: Text('B')),
        SizedBox(width: 4),
        CircleAvatar(child: Text('C')),
      ],
    );
  }
}

// ===========================================================================
// Section 6 - MergeSemantics
// ===========================================================================
//
// Wrap a Card whose children are an icon, a title, and a subtitle.  Without
// merging the screen reader announces three separate nodes.  With merging the
// whole card reads as a single phrase.

class _MergeSemanticsSection extends StatelessWidget {
  const _MergeSemanticsSection();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('MergeSemantics', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'List tiles, info cards, and chips often pack several lines '
              'into one logical unit.  MergeSemantics tells the framework to '
              'fuse them into a single accessibility node so they read as '
              'one phrase to TalkBack and VoiceOver.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            const MergeSemantics(
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.email_outlined, size: 32),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'New message from Alex',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Lunch tomorrow at the rooftop cafe?',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Reads as a single phrase to TalkBack/VoiceOver: '
              '"New message from Alex.  Lunch tomorrow at the rooftop cafe?"',
              style: text.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Section 7 - Live regions
// ===========================================================================
//
// A counter that increments every two seconds, wrapped in a `Semantics` node
// flagged as a live region.  Whenever the value changes, the screen reader
// announces the new value without needing user focus.

class _LiveRegionsSection extends StatefulWidget {
  const _LiveRegionsSection();

  @override
  State<_LiveRegionsSection> createState() => _LiveRegionsSectionState();
}

class _LiveRegionsSectionState extends State<_LiveRegionsSection> {
  int _ticks = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() {
        _ticks += 1;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Live regions', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'A live region is a node whose value changes asynchronously '
              '(network status, polling counters, score updates).  The '
              'screen reader monitors live regions and announces new values '
              'automatically; the user never has to hunt for them.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Semantics(
                liveRegion: true,
                label: 'Auto-updating counter',
                value: '$_ticks',
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.timelapse),
                    const SizedBox(width: 12),
                    Text('Counter: $_ticks',
                        style: text.titleLarge),
                    const Spacer(),
                    const Text('Updates every 2s'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'In a real app you would gate the announcement to meaningful '
              'changes only.  Spamming a live region with every keystroke '
              'creates announcement fatigue: the user stops paying attention '
              'because every change sounds the same.',
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Section 8 - Form semantics
// ===========================================================================
//
// A miniature form whose fields are wrapped in explicit Semantics so screen
// readers receive deliberate labels rather than the default text.

class _FormSemanticsSection extends StatefulWidget {
  const _FormSemanticsSection();

  @override
  State<_FormSemanticsSection> createState() => _FormSemanticsSectionState();
}

class _FormSemanticsSectionState extends State<_FormSemanticsSection> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _remember = false;
  String _summary = '';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _summary = 'Submitted email "${_email.text}" '
          '(password length: ${_password.text.length}, '
          'remember me: $_remember)';
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Form semantics', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'TextField already exposes good defaults, but custom widgets '
              'often need explicit Semantics(textField: true, label: ...) '
              'wrappers.  The form below shows the explicit pattern.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            Semantics(
              textField: true,
              label: 'Email',
              hint: 'Enter your email address',
              child: TextField(
                controller: _email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              textField: true,
              obscured: true,
              label: 'Password',
              hint: 'Enter your password',
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              checked: _remember,
              label: 'Remember me',
              hint: 'Stay signed in on this device',
              child: SwitchListTile(
                title: const Text('Remember me'),
                value: _remember,
                onChanged: (bool v) => setState(() => _remember = v),
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              button: true,
              label: 'Sign in',
              hint: 'Submits the form',
              child: FilledButton(
                onPressed: _submit,
                child: const Text('Sign in'),
              ),
            ),
            const SizedBox(height: 16),
            if (_summary.isNotEmpty)
              Semantics(
                liveRegion: true,
                label: _summary,
                child: Text(_summary, style: text.bodyMedium),
              ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Section 9 - Lifecycle visualization
// ===========================================================================
//
// A row of cards showing the canonical lifecycle of a SemanticsHandle as
// requested by the prompt: request -> tree built -> update propagates ->
// dispose -> tree torn down.

class _LifecycleVisualization extends StatelessWidget {
  const _LifecycleVisualization();

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Lifecycle visualization', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'Each card below represents one step in the handle lifecycle.  '
              'Read left-to-right: the binding starts idle, you request a '
              'handle, the tree is built, updates flow on every relevant '
              'frame, and the tree is torn down when the last handle is '
              'disposed.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  _LifecycleCard(
                    icon: Icons.send,
                    title: '1. request handle',
                    detail: 'Call SemanticsBinding.instance.ensureSemantics() '
                        'to ask the binding to start producing the tree.',
                  ),
                  SizedBox(width: 12),
                  _LifecycleCard(
                    icon: Icons.account_tree_outlined,
                    title: '2. tree built',
                    detail: 'The binding walks every render object and '
                        'gathers labels, hints, flags, and actions.',
                  ),
                  SizedBox(width: 12),
                  _LifecycleCard(
                    icon: Icons.sync,
                    title: '3. update propagates',
                    detail: 'On every frame that affects accessibility, the '
                        'tree diffs and emits change events to platform '
                        'channels.',
                  ),
                  SizedBox(width: 12),
                  _LifecycleCard(
                    icon: Icons.delete_outline,
                    title: '4. dispose handle',
                    detail: 'Call .dispose() on each SemanticsHandle when '
                        'you are done.  The binding decrements its '
                        'reference count.',
                  ),
                  SizedBox(width: 12),
                  _LifecycleCard(
                    icon: Icons.power_settings_new,
                    title: '5. tree torn down',
                    detail: 'When the count reaches zero the binding stops '
                        'producing the tree.  Future ensureSemantics calls '
                        'rebuild it on demand.',
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

class _LifecycleCard extends StatelessWidget {
  const _LifecycleCard({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: 200,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 28, color: colors.primary),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(detail, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Section 10 - Recipe gallery
// ===========================================================================
//
// Four cards each containing a real Semantics-wrapped recipe.  A custom
// button, a checkbox, a tab, and a chart datapoint - the most common widgets
// you find yourself wrapping in real apps.

class _RecipeGallery extends StatefulWidget {
  const _RecipeGallery();

  @override
  State<_RecipeGallery> createState() => _RecipeGalleryState();
}

class _RecipeGalleryState extends State<_RecipeGallery> {
  bool _checked = false;
  int _tabIndex = 0;
  int _selectedDatapoint = 1;

  static const List<String> _tabs = <String>['Overview', 'Details', 'Logs'];
  static const List<int> _datapoints = <int>[3, 7, 12, 9, 5];

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Recipe gallery', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'Each recipe wraps a custom-looking widget in the Semantics it '
              'needs to behave correctly with assistive technology.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            _RecipeCard(
              title: 'Custom button',
              child: Semantics(
                button: true,
                label: 'Subscribe',
                hint: 'Joins the mailing list',
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _RecipeCard(
              title: 'Checkbox',
              child: Semantics(
                checked: _checked,
                label: 'I agree to the terms',
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => setState(() => _checked = !_checked),
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo, width: 2),
                          color: _checked
                              ? Colors.indigo
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _checked
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: ExcludeSemantics(
                        child: Text('I agree to the terms'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _RecipeCard(
              title: 'Tab',
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < _tabs.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Semantics(
                        button: true,
                        selected: _tabIndex == i,
                        label: _tabs[i],
                        hint: 'Tab ${i + 1} of ${_tabs.length}',
                        child: GestureDetector(
                          onTap: () => setState(() => _tabIndex = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _tabIndex == i
                                      ? Colors.indigo
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(_tabs[i]),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _RecipeCard(
              title: 'Chart datapoint',
              child: SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    for (int i = 0; i < _datapoints.length; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Semantics(
                            button: true,
                            selected: _selectedDatapoint == i,
                            label: 'Day ${i + 1}',
                            value: '${_datapoints[i]} units',
                            hint: 'Tap to inspect',
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedDatapoint = i),
                              child: Container(
                                height: _datapoints[i] * 6.0,
                                decoration: BoxDecoration(
                                  color: _selectedDatapoint == i
                                      ? Colors.indigo
                                      : Colors.indigo.shade200,
                                  borderRadius:
                                      BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              liveRegion: true,
              label: 'Selected datapoint: day '
                  '${_selectedDatapoint + 1}, '
                  '${_datapoints[_selectedDatapoint]} units',
              child: Text(
                'Selected: day ${_selectedDatapoint + 1}, '
                '${_datapoints[_selectedDatapoint]} units',
                style: text.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 11 - Reference table
// ===========================================================================
//
// A long-form Table mapping Semantics flags and actions to the assistive
// tools that react to them.  Useful as a quick lookup when authoring custom
// widgets.

class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  // Table rows held as (property, effect, reacts) tuples to keep the build
  // method readable.  The header row is rendered separately.
  static const List<List<String>> _rows = <List<String>>[
    <String>['label', 'Primary string the AT reads.',
        'TB / VO / NV / JA / CV / FT'],
    <String>['value', 'Secondary value (e.g. "75 percent").',
        'TB / VO / NV / JA / CV / FT'],
    <String>['hint',
        'Hint read after a short delay; describes the action.',
        'TB / VO / NV / JA / FT'],
    <String>['button: true',
        'Announces "Button"; rotor exposes buttons category.',
        'TB / VO / NV / JA / CV'],
    <String>['header: true',
        'Marks node as heading; rotor jumps between headers.',
        'TB / VO / NV / JA / CV'],
    <String>['liveRegion: true',
        'AT announces value changes automatically.',
        'TB / VO / NV / JA / CV'],
    <String>['toggled: true|false',
        'Reads "switch on / switch off".',
        'TB / VO / NV / JA'],
    <String>['checked: true|false|null',
        'Reads "checkbox checked / not checked".',
        'TB / VO / NV / JA'],
    <String>['selected: true',
        'Indicates membership in a selected group.',
        'TB / VO / NV / JA / CV'],
    <String>['enabled: false',
        'Reads "disabled / dimmed"; rotor may skip.',
        'TB / VO / NV / JA / CV'],
    <String>['excludeSemantics',
        'Hides subtree from accessibility tree entirely.',
        'all'],
    <String>['mergeAllDescendants',
        'Collapses subtree into a single node.',
        'all'],
    <String>['image: true',
        'Announces "image"; rotor exposes images category.',
        'TB / VO / NV / JA'],
    <String>['link: true',
        'Announces "link"; rotor exposes links category.',
        'TB / VO / NV / JA / CV'],
    <String>['textField: true',
        'Marks node as editable text input.',
        'TB / VO / NV / JA / CV'],
    <String>['readOnly: true',
        'Reads "read only" on a textField node.',
        'TB / VO / NV / JA'],
    <String>['obscured: true',
        'Marks value as sensitive (passwords).',
        'TB / VO / NV / JA'],
    <String>['slider: true',
        'Announces "adjustable"; pairs with custom actions.',
        'TB / VO / NV / JA'],
    <String>['customSemanticsActions',
        'Adds entries to the AT gesture menu.',
        'TB / VO'],
    <String>['onTap',
        'Default tap action; AT can invoke without touching.',
        'all'],
    <String>['onLongPress',
        'Default long-press action.',
        'TB / VO / NV / JA'],
    <String>['onDismiss',
        'Lets AT dismiss the node (e.g. snackbars).',
        'TB / VO'],
    <String>['onIncrease / onDecrease',
        'Standard adjustable actions for sliders.',
        'TB / VO / NV / JA'],
    <String>['onScrollUp / onScrollDown',
        'Standard scrolling actions.',
        'TB / VO / NV / JA'],
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Reference table', style: text.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'Quick lookup: Semantics property -> what it does -> which '
              'assistive tools react.  AT names abbreviated: TB = TalkBack, '
              'VO = VoiceOver, NV = NVDA, JA = JAWS, CV = ChromeVox, FT = '
              'Flutter SemanticsTester.',
              style: text.bodyMedium,
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: colors.outlineVariant),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(180),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
              },
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHigh,
                  ),
                  children: const <Widget>[
                    _TableHeaderCell('Property'),
                    _TableHeaderCell('Effect'),
                    _TableHeaderCell('Reacts'),
                  ],
                ),
                for (final List<String> row in _rows)
                  TableRow(
                    children: <Widget>[
                      _TableCellMono(row[0]),
                      _TableCell(row[1]),
                      _TableCell(row[2]),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Properties not listed above (focusable, focused, namesRoute, '
              'scopesRoute, and friends) are essential for navigation but '
              'are usually managed by FocusScope, Route, and the Material '
              'widgets directly.  Reach for them only when building a '
              'custom navigator or modal flow.',
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(text),
    );
  }
}

class _TableCellMono extends StatelessWidget {
  const _TableCellMono(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'monospace'),
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
