import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Top-level state: no StatefulWidget required.
// ──────────────────────────────────────────────────────────────────────────────

/// Tracks the ID of the currently focused traversal card.
final ValueNotifier<String> _focusedCardId = ValueNotifier<String>('none');

/// Log of programmatic traversal invocations (tab 3).
final ValueNotifier<List<String>> _invokeLog =
    ValueNotifier<List<String>>(<String>[]);

/// Whether the skip-focus demo (tab 6) should skip item 3.
final ValueNotifier<bool> _skipEnabled = ValueNotifier<bool>(true);

// ──────────────────────────────────────────────────────────────────────────────
// Entry point
// ──────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: const _NextFocusIntentDemo(),
  );
}

// ──────────────────────────────────────────────────────────────────────────────
// Root shell
// ──────────────────────────────────────────────────────────────────────────────

class _NextFocusIntentDemo extends StatelessWidget {
  const _NextFocusIntentDemo();

  static const List<_TabSpec> _tabs = <_TabSpec>[
    _TabSpec(icon: Icons.info_outline, label: 'Overview'),
    _TabSpec(icon: Icons.grid_view, label: 'Live Grid'),
    _TabSpec(icon: Icons.touch_app, label: 'Invoke'),
    _TabSpec(icon: Icons.workspaces, label: 'Groups'),
    _TabSpec(icon: Icons.sort, label: 'Order'),
    _TabSpec(icon: Icons.block, label: 'Skip'),
    _TabSpec(icon: Icons.account_tree, label: 'Diagram'),
    _TabSpec(icon: Icons.list_alt, label: 'Catalog'),
    _TabSpec(icon: Icons.warning_amber, label: 'Pitfalls'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NextFocusIntent & PreviousFocusIntent'),
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs
                .map(
                  (t) => Tab(
                    icon: Icon(t.icon),
                    text: t.label,
                  ),
                )
                .toList(),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _Tab1Overview(),
            _Tab2LiveGrid(),
            _Tab3ProgrammaticInvoke(),
            _Tab4FocusGroups(),
            _Tab5CustomOrder(),
            _Tab6SkipFocus(),
            _Tab7Diagram(),
            _Tab8Catalog(),
            _Tab9Pitfalls(),
          ],
        ),
      ),
    );
  }
}

class _TabSpec {
  const _TabSpec({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

// ──────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ──────────────────────────────────────────────────────────────────────────────

/// Standard scrollable page padding.
Widget _page({required List<Widget> children}) {
  return ListView(
    padding: const EdgeInsets.all(20),
    children: children,
  );
}

/// Large section heading.
Widget _heading(String text, ColorScheme cs) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: cs.primary,
        ),
      ),
    );

/// Sub-heading.
Widget _subheading(String text, ColorScheme cs) => Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: cs.secondary,
        ),
      ),
    );

/// Body paragraph.
Widget _body(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: const TextStyle(fontSize: 14, height: 1.55)),
    );

/// Inline monospace chip.
Widget _chip(String code, ColorScheme cs) => Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: cs.onSecondaryContainer,
        ),
      ),
    );

/// A coloured info card.
Widget _infoCard({
  required String title,
  required String body,
  required ColorScheme cs,
  IconData icon = Icons.info_outline,
}) =>
    Card(
      color: cs.primaryContainer,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: cs.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

/// Divider with a label.
Widget _sectionDivider(String label) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );

// ──────────────────────────────────────────────────────────────────────────────
// Tab 1 — Overview / Hero Banner
// ──────────────────────────────────────────────────────────────────────────────

class _Tab1Overview extends StatelessWidget {
  const _Tab1Overview();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        // Hero banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[cs.primary, cs.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.keyboard_tab, color: cs.onPrimary, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'NextFocusIntent &\nPreviousFocusIntent',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: cs.onPrimary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Tab → moves focus forward through the widget tree.\n'
                'Shift+Tab ← moves focus backward.\n'
                'Both dispatch intents consumed by registered Actions.',
                style: TextStyle(
                  fontSize: 14,
                  color: cs.onPrimary.withValues(alpha: 0.92),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        _heading('What is NextFocusIntent?', cs),
        _body(
          'NextFocusIntent is a built-in Flutter Intent class that represents '
          'the user\'s desire to move keyboard focus to the next focusable widget '
          'in the traversal order. It is fired automatically when the user presses '
          'Tab, but it can also be invoked programmatically using '
          'Actions.invoke(context, const NextFocusIntent()).',
        ),
        _body(
          'Internally, the default NextFocusAction calls '
          'FocusTraversalPolicy.next(primaryFocus!) on the enclosing '
          'FocusTraversalGroup, advancing the primary focus one step forward in '
          'the policy-defined order.',
        ),

        _subheading('PreviousFocusIntent', cs),
        _body(
          'PreviousFocusIntent is the mirror image: it moves focus backward '
          '(Shift+Tab). Its default action calls '
          'FocusTraversalPolicy.previous(primaryFocus!).',
        ),

        _sectionDivider('Keyboard model'),

        _heading('The Tab / Shift+Tab Keyboard Model', cs),
        _body(
          'Flutter\'s focus system is built around a tree of FocusNode objects. '
          'At any moment, exactly one node holds "primary focus". Pressing Tab '
          'triggers the following pipeline:',
        ),
        _infoCard(
          title: 'Step 1 — Key event captured',
          body: 'The hardware Tab key press is delivered as a KeyDownEvent to '
              'the Shortcuts widget (or a lower-level RawKeyboardListener).',
          cs: cs,
          icon: Icons.keyboard,
        ),
        _infoCard(
          title: 'Step 2 — Shortcut maps key to intent',
          body: 'The built-in WidgetsApp Shortcuts map '
              'LogicalKeyboardKey.tab → NextFocusIntent() and '
              'Shift+Tab → PreviousFocusIntent().',
          cs: cs,
          icon: Icons.swap_horiz,
        ),
        _infoCard(
          title: 'Step 3 — Actions handler fires',
          body: 'The nearest Actions widget in the tree that registers a handler '
              'for NextFocusIntent (default: NextFocusAction) receives the intent.',
          cs: cs,
          icon: Icons.flash_on,
        ),
        _infoCard(
          title: 'Step 4 — FocusTraversalPolicy advances',
          body: 'NextFocusAction calls policy.next(node), which uses the active '
              'FocusTraversalPolicy (ReadingOrderTraversalPolicy by default) to '
              'determine the next node.',
          cs: cs,
          icon: Icons.route,
        ),
        _infoCard(
          title: 'Step 5 — Focus is transferred',
          body: 'The selected node calls requestFocus(), making it the new primary '
              'focus and triggering any hasFocus listeners.',
          cs: cs,
          icon: Icons.center_focus_strong,
        ),

        _sectionDivider('Traversal policies'),

        _heading('Focus Traversal Policies', cs),
        _body(
          'A FocusTraversalPolicy defines the ordering rule used by next() and '
          'previous(). Flutter ships several policies:',
        ),
        ...<_PolicyRow>[
          _PolicyRow(
            'ReadingOrderTraversalPolicy',
            'Default. Left-to-right, top-to-bottom reading order.',
          ),
          _PolicyRow(
            'WidgetOrderTraversalPolicy',
            'Traverses in widget-tree insertion order.',
          ),
          _PolicyRow(
            'OrderedTraversalPolicy',
            'Uses FocusTraversalOrder annotations for custom ordering.',
          ),
          _PolicyRow(
            'DirectionalFocusTraversalPolicyMixin',
            'Supports arrow-key directional focus movement.',
          ),
        ].map((r) => _PolicyCard(row: r, cs: cs)),

        const SizedBox(height: 20),
        _subheading('FocusTraversalGroup', cs),
        _body(
          'Wrapping a subtree in a FocusTraversalGroup isolates its traversal '
          'scope. Tab cycles through the group before moving to sibling groups. '
          'Each group can have its own policy, enabling mixed policies in one UI.',
        ),
      ],
    );
  }
}

class _PolicyRow {
  const _PolicyRow(this.name, this.description);
  final String name;
  final String description;
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({required this.row, required this.cs});
  final _PolicyRow row;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.tertiaryContainer,
          child: Icon(Icons.schema, color: cs.tertiary, size: 18),
        ),
        title: Text(
          row.name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(row.description, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 2 — Live Focus Traversal Demo
// ──────────────────────────────────────────────────────────────────────────────

class _Tab2LiveGrid extends StatelessWidget {
  const _Tab2LiveGrid();

  static const List<_CardSpec> _cards = <_CardSpec>[
    _CardSpec(id: 'A', label: 'Alpha', color: Color(0xFF5C6BC0)),
    _CardSpec(id: 'B', label: 'Beta', color: Color(0xFF26A69A)),
    _CardSpec(id: 'C', label: 'Gamma', color: Color(0xFFEF5350)),
    _CardSpec(id: 'D', label: 'Delta', color: Color(0xFFAB47BC)),
    _CardSpec(id: 'E', label: 'Epsilon', color: Color(0xFFFF7043)),
    _CardSpec(id: 'F', label: 'Zeta', color: Color(0xFF42A5F5)),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('Live Focus Traversal Grid', cs),
        _body(
          'Six focusable cards are arranged in a 2-column grid. Press Tab to '
          'move focus forward (A → B → C → D → E → F → A …). Press Shift+Tab '
          'to move backward. The active card\'s border glows with an accent ring.',
        ),
        _infoCard(
          title: 'Interaction tip',
          body: 'Click any card first to seed focus, then use Tab/Shift+Tab. '
              'The status bar below the grid shows which card is focused.',
          cs: cs,
          icon: Icons.touch_app,
        ),
        const SizedBox(height: 12),
        // Status bar
        ValueListenableBuilder<String>(
          valueListenable: _focusedCardId,
          builder: (context, id, _) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.center_focus_strong, color: cs.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Focused card: ',
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
                Text(
                  id == 'none' ? '(none — click a card)' : 'Card $id',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // 2-column grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: _cards
              .map((spec) => _FocusCard(spec: spec))
              .toList(),
        ),
        const SizedBox(height: 20),
        _subheading('How it works', cs),
        _body(
          'Each card is a FocusableActionDetector that wraps a GestureDetector. '
          'When focus enters or exits, the card reports its ID to _focusedCardId '
          '(a top-level ValueNotifier). The glow border is driven by '
          'AnimatedContainer using the hasFocus flag from the FocusNode callbacks.',
        ),
        _body(
          'The grid uses the default ReadingOrderTraversalPolicy, so Tab moves '
          'from A→B→C→D→E→F in left-to-right, row-by-row reading order.',
        ),
        _subheading('Relevant APIs', cs),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: <Widget>[
            _chip('FocusableActionDetector', cs),
            _chip('FocusNode', cs),
            _chip('FocusNode.hasFocus', cs),
            _chip('ReadingOrderTraversalPolicy', cs),
            _chip('NextFocusIntent', cs),
            _chip('PreviousFocusIntent', cs),
          ],
        ),
      ],
    );
  }
}

class _CardSpec {
  const _CardSpec({
    required this.id,
    required this.label,
    required this.color,
  });
  final String id;
  final String label;
  final Color color;
}

class _FocusCard extends StatelessWidget {
  const _FocusCard({required this.spec});
  final _CardSpec spec;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Focus(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _focusedCardId.value = spec.id;
        } else if (_focusedCardId.value == spec.id) {
          _focusedCardId.value = 'none';
        }
      },
      child: ValueListenableBuilder<String>(
        valueListenable: _focusedCardId,
        builder: (context, focused, _) {
          final hasFocus = focused == spec.id;
          return GestureDetector(
            onTap: () => focusNode.requestFocus(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: spec.color.withValues(alpha: hasFocus ? 1.0 : 0.75),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: hasFocus ? Colors.white : Colors.transparent,
                  width: hasFocus ? 3 : 0,
                ),
                boxShadow: hasFocus
                    ? <BoxShadow>[
                        BoxShadow(
                          color: spec.color.withValues(alpha: 0.7),
                          blurRadius: 16,
                          spreadRadius: 3,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    spec.id,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    spec.label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                  if (hasFocus)
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.center_focus_strong,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 3 — Programmatic Invoke
// ──────────────────────────────────────────────────────────────────────────────

class _Tab3ProgrammaticInvoke extends StatelessWidget {
  const _Tab3ProgrammaticInvoke();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('Programmatic Focus Traversal', cs),
        _body(
          'Instead of pressing Tab/Shift+Tab, you can invoke traversal from '
          'code using Actions.invoke(). This is useful for accessibility tools, '
          'custom keyboard overlays, and gaming-style directional focus controls.',
        ),
        _body(
          'Call Actions.invoke(context, const NextFocusIntent()) anywhere in '
          'the widget tree that has an ancestor Actions widget registering a '
          'NextFocusAction handler — which WidgetsApp provides by default.',
        ),
        _subheading('Live demo', cs),
        _body(
          'The buttons below call Actions.invoke() directly. The log shows each '
          'traversal event with a timestamp.',
        ),
        const SizedBox(height: 8),
        _InvokeDemo(),
        const SizedBox(height: 20),
        _subheading('Code pattern', cs),
        _CodeBlock(
          code: '''// Move focus forward programmatically:
Actions.invoke(context, const NextFocusIntent());

// Move focus backward programmatically:
Actions.invoke(context, const PreviousFocusIntent());''',
          cs: cs,
        ),
        _subheading('When to use programmatic invocation', cs),
        _infoCard(
          title: 'Custom keyboard overlays',
          body: 'Virtual keyboards on embedded or kiosk devices that have no '
              'physical Tab key.',
          cs: cs,
          icon: Icons.keyboard,
        ),
        _infoCard(
          title: 'Gamepad navigation',
          body: 'Map d-pad right → NextFocusIntent and d-pad left → '
              'PreviousFocusIntent for gamepad-driven UI.',
          cs: cs,
          icon: Icons.sports_esports,
        ),
        _infoCard(
          title: 'Accessibility helpers',
          body: 'Screen-reader companion overlays that expose previous/next '
              'buttons for motor-impaired users.',
          cs: cs,
          icon: Icons.accessibility_new,
        ),
        _infoCard(
          title: 'Automated UI tests',
          body: 'Drive focus in widget tests without synthesizing raw key events.',
          cs: cs,
          icon: Icons.science,
        ),
      ],
    );
  }
}

class _InvokeDemo extends StatelessWidget {
  _InvokeDemo();

  final List<FocusNode> _nodes = List.generate(4, (_) => FocusNode());
  final List<String> _labels = const <String>['One', 'Two', 'Three', 'Four'];

  void _addLog(String msg) {
    final now = TimeOfDay.now();
    final entry = '${now.hour.toString().padLeft(2, "0")}:'
        '${now.minute.toString().padLeft(2, "0")} — $msg';
    _invokeLog.value = <String>[entry, ..._invokeLog.value].take(8).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Focusable row
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < 3 ? 8 : 0),
                child: Focus(
                  focusNode: _nodes[i],
                  child: ValueListenableBuilder<String>(
                    valueListenable: _focusedCardId,
                    builder: (context, focused2, ignored) {
                      final hasFocus = _nodes[i].hasFocus;
                      return GestureDetector(
                        onTap: () {
                          _nodes[i].requestFocus();
                          _addLog('Tapped: ${_labels[i]}');
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: 60,
                          decoration: BoxDecoration(
                            color: hasFocus
                                ? cs.primaryContainer
                                : cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  hasFocus ? cs.primary : cs.outlineVariant,
                              width: hasFocus ? 2.5 : 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _labels[i],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: hasFocus
                                    ? cs.primary
                                    : cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        // Buttons
        Row(
          children: <Widget>[
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  _addLog('← PreviousFocusIntent invoked');
                  Actions.invoke(context, const PreviousFocusIntent());
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Prev Focus'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  _addLog('→ NextFocusIntent invoked');
                  Actions.invoke(context, const NextFocusIntent());
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next Focus'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Log
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.list_alt, size: 16, color: cs.secondary),
                  const SizedBox(width: 6),
                  Text(
                    'Traversal log',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cs.secondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<List<String>>(
                valueListenable: _invokeLog,
                builder: (context, log, _) {
                  if (log.isEmpty) {
                    return Text(
                      'No events yet — click a cell, then press a button.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: cs.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: log
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 4 — FocusTraversalGroup
// ──────────────────────────────────────────────────────────────────────────────

class _Tab4FocusGroups extends StatelessWidget {
  const _Tab4FocusGroups();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('FocusTraversalGroup', cs),
        _body(
          'FocusTraversalGroup creates an isolated scope for Tab traversal. '
          'When focus is inside a group, Tab cycles through all focusable '
          'descendants of that group before moving to sibling groups.',
        ),
        _body(
          'Each group can specify its own policy, so one group might use '
          'ReadingOrderTraversalPolicy while another uses OrderedTraversalPolicy.',
        ),
        _infoCard(
          title: 'Why groups?',
          body: 'They prevent Tab from accidentally jumping into unrelated '
              'form sections, sidebars, or modal overlays. They also allow '
              'independent traversal policies per region.',
          cs: cs,
          icon: Icons.workspaces_outlined,
        ),
        const SizedBox(height: 16),
        _subheading('Live Demo — Two groups side by side', cs),
        _body(
          'Group A (left, blue) contains 3 items. Group B (right, green) '
          'contains 3 items. Tab cycles A1→A2→A3 within group A, then moves '
          'to B1→B2→B3, then back to A1.',
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FocusTraversalGroup(
                policy: ReadingOrderTraversalPolicy(),
                child: _GroupBox(
                  title: 'Group A',
                  color: cs.primaryContainer,
                  borderColor: cs.primary,
                  items: const <String>['A1', 'A2', 'A3'],
                  cs: cs,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FocusTraversalGroup(
                policy: ReadingOrderTraversalPolicy(),
                child: _GroupBox(
                  title: 'Group B',
                  color: cs.tertiaryContainer,
                  borderColor: cs.tertiary,
                  items: const <String>['B1', 'B2', 'B3'],
                  cs: cs,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _subheading('Code pattern', cs),
        _CodeBlock(
          code: '''FocusTraversalGroup(
  policy: ReadingOrderTraversalPolicy(),
  child: Column(
    children: [
      TextField(decoration: InputDecoration(labelText: 'First')),
      TextField(decoration: InputDecoration(labelText: 'Second')),
      TextField(decoration: InputDecoration(labelText: 'Third')),
    ],
  ),
)''',
          cs: cs,
        ),
        _subheading('Nested groups', cs),
        _body(
          'FocusTraversalGroups can be nested. Inner groups are traversed '
          'as a unit from the outer group\'s perspective — Tab enters the '
          'inner group as one step, then traverses within it.',
        ),
        _subheading('describesFocusPolicy', cs),
        _body(
          'Set describesFocusPolicy: false on a FocusTraversalGroup if you '
          'only want to scope traversal without overriding the ancestor policy. '
          'This is rarely needed but useful for wrappers.',
        ),
      ],
    );
  }
}

class _GroupBox extends StatelessWidget {
  const _GroupBox({
    required this.title,
    required this.color,
    required this.borderColor,
    required this.items,
    required this.cs,
  });
  final String title;
  final Color color;
  final Color borderColor;
  final List<String> items;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: borderColor,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _GroupItem(label: item, borderColor: borderColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({required this.label, required this.borderColor});
  final String label;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          return GestureDetector(
            onTap: () => Focus.of(context).requestFocus(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: hasFocus
                    ? borderColor.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: hasFocus ? borderColor : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: hasFocus ? borderColor : Colors.black54,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 5 — Custom Traversal Order
// ──────────────────────────────────────────────────────────────────────────────

class _Tab5CustomOrder extends StatelessWidget {
  const _Tab5CustomOrder();

  // Custom order: display position ≠ traversal order.
  // Display: 1 2 3
  //          4 5 6
  // Traversal order assigned: A(1)=1, B(2)=4, C(3)=2, D(4)=5, E(5)=3, F(6)=6
  static const List<_OrderedCard> _cards = <_OrderedCard>[
    _OrderedCard(displayLabel: 'A', traversalOrder: 1, color: Color(0xFF5C6BC0)),
    _OrderedCard(displayLabel: 'B', traversalOrder: 4, color: Color(0xFF26A69A)),
    _OrderedCard(displayLabel: 'C', traversalOrder: 2, color: Color(0xFFEF5350)),
    _OrderedCard(displayLabel: 'D', traversalOrder: 5, color: Color(0xFFAB47BC)),
    _OrderedCard(displayLabel: 'E', traversalOrder: 3, color: Color(0xFFFF7043)),
    _OrderedCard(displayLabel: 'F', traversalOrder: 6, color: Color(0xFF42A5F5)),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('OrderedTraversalPolicy', cs),
        _body(
          'OrderedTraversalPolicy lets you assign explicit traversal order '
          'numbers to focusable widgets using FocusTraversalOrder. The policy '
          'sorts nodes by their NumericFocusOrder value, so Tab follows the '
          'assigned numbers regardless of widget-tree position.',
        ),
        _infoCard(
          title: 'Use case',
          body: 'Form fields that span multiple visual columns but should be '
              'traversed in a logical sequence (e.g., left column first, then '
              'right column) regardless of layout order.',
          cs: cs,
          icon: Icons.view_column,
        ),
        const SizedBox(height: 16),
        _subheading('Live demo — numbers show traversal order', cs),
        _body(
          'Cards display their visual label (A–F) and their traversal order '
          'number. Tab follows the order number, not the visual layout. '
          'Expected traversal: A(1) → C(2) → E(3) → B(4) → D(5) → F(6).',
        ),
        const SizedBox(height: 8),
        FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: _cards
                .map((card) => _OrderedFocusCard(card: card))
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        _subheading('Traversal sequence', cs),
        Wrap(
          spacing: 6,
          children: ([..._cards]
                ..sort((a, b) => a.traversalOrder.compareTo(b.traversalOrder)))
              .map((c) => _chip('Step ${c.traversalOrder}: card ${c.displayLabel}', cs))
              .toList(),
        ),
        const SizedBox(height: 20),
        _subheading('Code pattern', cs),
        _CodeBlock(
          code: '''FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Row(children: [
    FocusTraversalOrder(
      order: NumericFocusOrder(1),
      child: MyFocusableWidget(),
    ),
    FocusTraversalOrder(
      order: NumericFocusOrder(3),
      child: MyFocusableWidget(),
    ),
    FocusTraversalOrder(
      order: NumericFocusOrder(2),
      child: MyFocusableWidget(),
    ),
  ]),
)''',
          cs: cs,
        ),
        _subheading('LexicalFocusOrder vs NumericFocusOrder', cs),
        _body(
          'NumericFocusOrder uses a double for ordering. LexicalFocusOrder '
          'uses a String and sorts lexicographically. Both implement FocusOrder. '
          'They cannot be mixed within the same FocusTraversalGroup.',
        ),
      ],
    );
  }
}

class _OrderedCard {
  const _OrderedCard({
    required this.displayLabel,
    required this.traversalOrder,
    required this.color,
  });
  final String displayLabel;
  final int traversalOrder;
  final Color color;
}

class _OrderedFocusCard extends StatelessWidget {
  const _OrderedFocusCard({required this.card});
  final _OrderedCard card;

  @override
  Widget build(BuildContext context) {
    return FocusTraversalOrder(
      order: NumericFocusOrder(card.traversalOrder.toDouble()),
      child: Focus(
        child: Builder(
          builder: (context) {
            final hasFocus = Focus.of(context).hasFocus;
            return GestureDetector(
              onTap: () => Focus.of(context).requestFocus(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: card.color.withValues(alpha: hasFocus ? 1.0 : 0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasFocus ? Colors.white : Colors.transparent,
                    width: hasFocus ? 3 : 0,
                  ),
                  boxShadow: hasFocus
                      ? <BoxShadow>[
                          BoxShadow(
                            color: card.color.withValues(alpha: 0.6),
                            blurRadius: 14,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        card.displayLabel,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '# ${card.traversalOrder}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                    if (hasFocus)
                      const Positioned(
                        bottom: 6,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Icon(
                            Icons.center_focus_strong,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 6 — Skip-Focus Item
// ──────────────────────────────────────────────────────────────────────────────

class _Tab6SkipFocus extends StatelessWidget {
  const _Tab6SkipFocus();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('Skipping Items in Traversal', cs),
        _body(
          'Sometimes a widget should remain visually present and even interactive '
          'via mouse/touch, but should not participate in keyboard Tab traversal. '
          'Flutter provides two independent mechanisms for this:',
        ),
        _infoCard(
          title: 'skipTraversal = true',
          body: 'The FocusNode.skipTraversal property excludes a node from '
              'Tab-key traversal while leaving it fully focusable by direct '
              'request (e.g. mouse click or requestFocus()).',
          cs: cs,
          icon: Icons.skip_next,
        ),
        _infoCard(
          title: 'canRequestFocus = false',
          body: 'Prevents the node from receiving focus at all — neither by '
              'traversal nor by direct request. Use for decorative or disabled '
              'widgets that must never have focus.',
          cs: cs,
          icon: Icons.block,
        ),
        const SizedBox(height: 16),
        _subheading('Live demo', cs),
        _body(
          'Five items are shown. Item 3 has skipTraversal toggled by the switch '
          'below. When the switch is ON, Tab skips item 3 and goes 1→2→4→5. '
          'When OFF, Tab visits all five items in order.',
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _skipEnabled,
          builder: (context, skipOn, _) => Column(
            children: <Widget>[
              SwitchListTile(
                value: skipOn,
                onChanged: (v) => _skipEnabled.value = v,
                title: const Text('Skip item 3 in traversal'),
                subtitle: Text(
                  skipOn
                      ? 'Item 3: skipTraversal = true'
                      : 'Item 3: skipTraversal = false (normal)',
                ),
              ),
              const SizedBox(height: 10),
              ...List.generate(5, (i) {
                final index = i + 1;
                final skip = skipOn && index == 3;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _SkipItem(
                    index: index,
                    skip: skip,
                    cs: cs,
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _subheading('Code pattern — skipTraversal', cs),
        _CodeBlock(
          code: '''Focus(
  skipTraversal: true,
  child: Card(
    child: ListTile(
      title: Text('Skipped in Tab order'),
    ),
  ),
)''',
          cs: cs,
        ),
        _subheading('Code pattern — canRequestFocus', cs),
        _CodeBlock(
          code: '''Focus(
  canRequestFocus: false,
  child: DecorativeWidget(),
)''',
          cs: cs,
        ),
        _subheading('Differences at a glance', cs),
        Table(
          border: TableBorder.all(color: cs.outlineVariant),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.5),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: cs.primaryContainer),
              children: <Widget>[
                _tableCell('Property', bold: true),
                _tableCell('Tab skips?', bold: true),
                _tableCell('Click focusable?', bold: true),
              ],
            ),
            TableRow(children: <Widget>[
              _tableCell('(default)'),
              _tableCell('No'),
              _tableCell('Yes'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('skipTraversal = true'),
              _tableCell('Yes'),
              _tableCell('Yes'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('canRequestFocus = false'),
              _tableCell('Yes'),
              _tableCell('No'),
            ]),
          ],
        ),
      ],
    );
  }
}

Widget _tableCell(String text, {bool bold = false}) => Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
          fontFamily: bold ? null : 'monospace',
        ),
      ),
    );

class _SkipItem extends StatelessWidget {
  const _SkipItem({
    required this.index,
    required this.skip,
    required this.cs,
  });
  final int index;
  final bool skip;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: skip,
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          return GestureDetector(
            onTap: () => Focus.of(context).requestFocus(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: skip
                    ? cs.errorContainer.withValues(alpha: 0.3)
                    : (hasFocus
                        ? cs.primaryContainer
                        : cs.surfaceContainerHighest),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: hasFocus
                      ? cs.primary
                      : (skip ? cs.error : cs.outlineVariant),
                  width: hasFocus ? 2 : 1,
                ),
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: hasFocus ? cs.primary : cs.outlineVariant,
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: hasFocus ? cs.onPrimary : cs.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Item $index${skip ? " — SKIPPED in Tab order" : ""}',
                      style: TextStyle(
                        fontWeight: hasFocus ? FontWeight.w700 : FontWeight.normal,
                        color: skip ? cs.error : cs.onSurface,
                      ),
                    ),
                  ),
                  if (hasFocus)
                    Icon(Icons.center_focus_strong, color: cs.primary, size: 18),
                  if (skip)
                    Icon(Icons.block, color: cs.error, size: 18),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 7 — Diagram (CustomPainter)
// ──────────────────────────────────────────────────────────────────────────────

class _Tab7Diagram extends StatelessWidget {
  const _Tab7Diagram();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('Intent Dispatch Flow', cs),
        _body(
          'The diagram below shows the exact call chain from hardware key press '
          'to FocusTraversalPolicy when Tab is pressed.',
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 420,
          child: CustomPaint(
            painter: _FlowDiagramPainter(cs: cs),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 20),
        _subheading('Step-by-step explanation', cs),
        ...<_DiagramStep>[
          _DiagramStep(
            number: '1',
            title: 'Tab KeyDownEvent',
            detail: 'Hardware event enters Flutter engine → HardwareKeyboard → '
                'KeyEventManager → routed to focused widget subtree.',
          ),
          _DiagramStep(
            number: '2',
            title: 'Shortcuts widget',
            detail: 'Matches LogicalKeyboardKey.tab (and shift+tab) against its '
                'bindings map. Produces a NextFocusIntent (or PreviousFocusIntent).',
          ),
          _DiagramStep(
            number: '3',
            title: 'NextFocusIntent',
            detail: 'A plain const Intent subclass with no fields. Acts as a '
                'typed message identifying the desired action.',
          ),
          _DiagramStep(
            number: '4',
            title: 'Actions widget',
            detail: 'Walks up the element tree to find the nearest Actions '
                'registration for NextFocusIntent. WidgetsApp registers '
                'NextFocusAction globally.',
          ),
          _DiagramStep(
            number: '5',
            title: 'NextFocusAction.invoke()',
            detail: 'Retrieves primaryFocus and calls '
                'primaryFocus!.nextFocus() which delegates to the traversal policy.',
          ),
          _DiagramStep(
            number: '6',
            title: 'FocusTraversalPolicy.next()',
            detail: 'Computes the sorted list of eligible focusable descendants '
                'of the nearest FocusTraversalGroup and selects the next one. '
                'Then calls node.requestFocus().',
          ),
        ].map((s) => _DiagramStepCard(step: s, cs: cs)),
        const SizedBox(height: 20),
        _subheading('PreviousFocusIntent — mirror path', cs),
        _body(
          'The same flow applies for PreviousFocusIntent/PreviousFocusAction, '
          'but FocusTraversalPolicy.previous() is called instead of next().',
        ),
      ],
    );
  }
}

class _DiagramStep {
  const _DiagramStep({
    required this.number,
    required this.title,
    required this.detail,
  });
  final String number;
  final String title;
  final String detail;
}

class _DiagramStepCard extends StatelessWidget {
  const _DiagramStepCard({required this.step, required this.cs});
  final _DiagramStep step;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.primary,
          child: Text(
            step.number,
            style: TextStyle(
              color: cs.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        title: Text(
          step.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(step.detail, style: const TextStyle(fontSize: 12)),
        isThreeLine: true,
      ),
    );
  }
}

class _FlowDiagramPainter extends CustomPainter {
  const _FlowDiagramPainter({required this.cs});
  final ColorScheme cs;

  static const List<String> _labels = <String>[
    'Tab KeyDownEvent',
    'Shortcuts',
    'NextFocusIntent',
    'Actions',
    'NextFocusAction',
    'FocusTraversalPolicy.next()',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final boxW = size.width - 40;
    const boxH = 46.0;
    const gapH = 24.0;
    const totalItems = 6;
    final totalH = totalItems * boxH + (totalItems - 1) * gapH;
    final startY = (size.height - totalH) / 2;
    final boxX = 20.0;

    final fillPaint = Paint()..color = cs.primaryContainer;
    final borderPaint = Paint()
      ..color = cs.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    final arrowPaint = Paint()
      ..color = cs.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final arrowFillPaint = Paint()
      ..color = cs.primary
      ..style = PaintingStyle.fill;

    for (int i = 0; i < totalItems; i++) {
      final top = startY + i * (boxH + gapH);
      final rect = Rect.fromLTWH(boxX, top, boxW, boxH);
      final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(10));

      // Alternate fill shade for first box
      if (i == 0) {
        canvas.drawRRect(
          rRect,
          Paint()..color = cs.tertiaryContainer,
        );
        canvas.drawRRect(
          rRect,
          Paint()
            ..color = cs.tertiary
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.8,
        );
      } else if (i == totalItems - 1) {
        canvas.drawRRect(
          rRect,
          Paint()..color = cs.secondaryContainer,
        );
        canvas.drawRRect(
          rRect,
          Paint()
            ..color = cs.secondary
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.8,
        );
      } else {
        canvas.drawRRect(rRect, fillPaint);
        canvas.drawRRect(rRect, borderPaint);
      }

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: _labels[i],
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 20);

      textPainter.paint(
        canvas,
        Offset(
          boxX + (boxW - textPainter.width) / 2,
          top + (boxH - textPainter.height) / 2,
        ),
      );

      // Draw arrow between boxes
      if (i < totalItems - 1) {
        final arrowStartY = top + boxH;
        final arrowEndY = top + boxH + gapH;
        final midX = boxX + boxW / 2;

        canvas.drawLine(
          Offset(midX, arrowStartY + 2),
          Offset(midX, arrowEndY - 8),
          arrowPaint,
        );

        // Arrowhead
        final path = Path()
          ..moveTo(midX, arrowEndY)
          ..lineTo(midX - 7, arrowEndY - 10)
          ..lineTo(midX + 7, arrowEndY - 10)
          ..close();
        canvas.drawPath(path, arrowFillPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FlowDiagramPainter oldDelegate) => false;
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 8 — Intent Catalog
// ──────────────────────────────────────────────────────────────────────────────

class _Tab8Catalog extends StatelessWidget {
  const _Tab8Catalog();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('Focus-Related Intent Catalog', cs),
        _body(
          'Flutter ships several Intent subclasses specifically for focus '
          'management. All live in flutter/services.dart or flutter/widgets.dart '
          'and are registered in WidgetsApp by default.',
        ),
        const SizedBox(height: 8),
        ...<_IntentSpec>[
          _IntentSpec(
            name: 'NextFocusIntent',
            trigger: 'Tab',
            action: 'NextFocusAction',
            policy: 'policy.next()',
            description:
                'Moves primary focus to the next focusable node in the '
                'traversal order defined by the active FocusTraversalPolicy.',
            color: const Color(0xFF5C6BC0),
          ),
          _IntentSpec(
            name: 'PreviousFocusIntent',
            trigger: 'Shift+Tab',
            action: 'PreviousFocusAction',
            policy: 'policy.previous()',
            description:
                'Moves primary focus to the previous focusable node, '
                'reversing the traversal direction.',
            color: const Color(0xFF26A69A),
          ),
          _IntentSpec(
            name: 'RequestFocusIntent',
            trigger: '(programmatic)',
            action: 'RequestFocusAction',
            policy: 'node.requestFocus()',
            description:
                'Directly requests focus for a specific FocusNode passed '
                'as a constructor argument. Bypasses traversal policy.',
            color: const Color(0xFFEF5350),
          ),
          _IntentSpec(
            name: 'NextPageFocusIntent',
            trigger: '(platform)',
            action: 'NextPageFocusAction',
            policy: 'policy.next() × page',
            description:
                'Advances focus by a page in paged widgets (e.g., long forms). '
                'Not triggered by Tab on desktop by default.',
            color: const Color(0xFFAB47BC),
          ),
          _IntentSpec(
            name: 'PreviousPageFocusIntent',
            trigger: '(platform)',
            action: 'PreviousPageFocusAction',
            policy: 'policy.previous() × page',
            description:
                'Moves focus backward by a page. Symmetric to NextPageFocusIntent.',
            color: const Color(0xFFFF7043),
          ),
        ].map((spec) => _IntentCatalogCard(spec: spec, cs: cs)),
        const SizedBox(height: 20),
        _subheading('RequestFocusIntent example', cs),
        _CodeBlock(
          code: '''// Focus a specific node directly:
final myNode = FocusNode();
// ...
Actions.invoke(
  context,
  RequestFocusIntent(myNode),
);''',
          cs: cs,
        ),
        _subheading('Overriding intent handling', cs),
        _body(
          'You can replace the default action for any of these intents by '
          'wrapping your subtree in an Actions widget:',
        ),
        _CodeBlock(
          code: '''Actions(
  actions: {
    NextFocusIntent: CallbackAction<NextFocusIntent>(
      onInvoke: (intent) {
        // Custom logic before or after advancing focus
        myAnalytics.logTabPress();
        return Actions.invoke(context, intent);
      },
    ),
  },
  child: MySubtree(),
)''',
          cs: cs,
        ),
      ],
    );
  }
}

class _IntentSpec {
  const _IntentSpec({
    required this.name,
    required this.trigger,
    required this.action,
    required this.policy,
    required this.description,
    required this.color,
  });
  final String name;
  final String trigger;
  final String action;
  final String policy;
  final String description;
  final Color color;
}

class _IntentCatalogCard extends StatelessWidget {
  const _IntentCatalogCard({required this.spec, required this.cs});
  final _IntentSpec spec;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: spec.color,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              spec.name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(spec.description, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: <Widget>[
                    _metaBadge('Trigger: ${spec.trigger}', cs),
                    _metaBadge('Action: ${spec.action}', cs),
                    _metaBadge('Policy: ${spec.policy}', cs),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaBadge(String label, ColorScheme cs) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: cs.onSurfaceVariant,
          ),
        ),
      );
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 9 — Pitfalls
// ──────────────────────────────────────────────────────────────────────────────

class _Tab9Pitfalls extends StatelessWidget {
  const _Tab9Pitfalls();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _page(
      children: <Widget>[
        _heading('Common Pitfalls', cs),
        _body(
          'Focus traversal in Flutter is powerful but has several gotchas. '
          'The three most common are described below with explanations and fixes.',
        ),
        const SizedBox(height: 8),

        // Pitfall 1
        _PitfallCard(
          number: '1',
          title: 'No FocusTraversalGroup in subtree',
          symptom:
              'Tab jumps seemingly randomly between unrelated UI regions, '
              'including areas you don\'t intend to include in the same traversal scope.',
          cause:
              'Without a FocusTraversalGroup, the traversal policy covers the '
              'entire widget tree under WidgetsApp. Every focusable widget — '
              'from app bar actions to drawer items — is included in the same '
              'flat traversal list.',
          fix:
              'Wrap each logical region (form, toolbar, sidebar) in its own '
              'FocusTraversalGroup. Tab will then cycle within each group '
              'before advancing to the next.',
          fixCode: '''FocusTraversalGroup(
  policy: ReadingOrderTraversalPolicy(),
  child: MyForm(),
)''',
          cs: cs,
        ),

        // Pitfall 2
        _PitfallCard(
          number: '2',
          title: 'Circular focus trap',
          symptom:
              'Tab never leaves a particular region — the user is "trapped" '
              'inside a dialog, dropdown, or custom overlay.',
          cause:
              'A FocusTraversalGroup wrapping a modal correctly keeps focus '
              'inside, but if there is no mechanism to dismiss the modal via '
              'keyboard (Escape key handler), the user has no keyboard escape route.',
          fix:
              'Always pair a trapping FocusTraversalGroup with a keyboard '
              'dismissal shortcut (usually Escape → pop route or close overlay). '
              'Flutter\'s Dialog and AlertDialog do this automatically.',
          fixCode: '''Shortcuts(
  shortcuts: {
    LogicalKeySet(LogicalKeyboardKey.escape):
        const DismissIntent(),
  },
  child: Actions(
    actions: {
      DismissIntent: CallbackAction<DismissIntent>(
        onInvoke: (_) => Navigator.pop(context),
      ),
    },
    child: MyModal(),
  ),
)''',
          cs: cs,
        ),

        // Pitfall 3
        _PitfallCard(
          number: '3',
          title: 'skipTraversal but still focusable',
          symptom:
              'A widget set to skip Tab traversal still receives focus when '
              'the user clicks it or when other code calls requestFocus(). '
              'This confuses screen-reader users.',
          cause:
              'skipTraversal = true only removes the node from the Tab key '
              'traversal list. The node\'s canRequestFocus is still true, so '
              'direct focus requests succeed. This is intentional for some '
              'use cases (e.g., a label that can show a tooltip when focused '
              'via click) but is a bug if the widget is truly disabled.',
          fix:
              'For disabled widgets, set both skipTraversal = true AND '
              'canRequestFocus = false. Alternatively, use ExcludeFocus which '
              'excludes the entire subtree from focus.',
          fixCode: '''// Completely unfocusable subtree:
ExcludeFocus(
  excluding: isDisabled,
  child: MySubtree(),
)

// Or per-node:
Focus(
  skipTraversal: true,
  canRequestFocus: false,
  child: DisabledWidget(),
)''',
          cs: cs,
        ),

        const SizedBox(height: 20),
        _heading('API Cheat Sheet', cs),
        _subheading('Core intents', cs),
        Table(
          border: TableBorder.all(color: cs.outlineVariant),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(2),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: cs.primaryContainer),
              children: <Widget>[
                _tableCell('Intent', bold: true),
                _tableCell('Default trigger', bold: true),
              ],
            ),
            TableRow(children: <Widget>[
              _tableCell('NextFocusIntent'),
              _tableCell('Tab'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('PreviousFocusIntent'),
              _tableCell('Shift+Tab'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('RequestFocusIntent(node)'),
              _tableCell('programmatic'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('NextPageFocusIntent'),
              _tableCell('platform-defined'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('PreviousPageFocusIntent'),
              _tableCell('platform-defined'),
            ]),
          ],
        ),
        const SizedBox(height: 16),
        _subheading('Core actions', cs),
        Table(
          border: TableBorder.all(color: cs.outlineVariant),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(2.5),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: cs.primaryContainer),
              children: <Widget>[
                _tableCell('Action', bold: true),
                _tableCell('What it calls', bold: true),
              ],
            ),
            TableRow(children: <Widget>[
              _tableCell('NextFocusAction'),
              _tableCell('primaryFocus!.nextFocus()'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('PreviousFocusAction'),
              _tableCell('primaryFocus!.previousFocus()'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('RequestFocusAction'),
              _tableCell('intent.focusNode.requestFocus()'),
            ]),
          ],
        ),
        const SizedBox(height: 16),
        _subheading('Key traversal properties', cs),
        Table(
          border: TableBorder.all(color: cs.outlineVariant),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(3),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: cs.primaryContainer),
              children: <Widget>[
                _tableCell('Property / Widget', bold: true),
                _tableCell('Purpose', bold: true),
              ],
            ),
            TableRow(children: <Widget>[
              _tableCell('FocusNode.skipTraversal'),
              _tableCell('Exclude from Tab, allow direct focus'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('FocusNode.canRequestFocus'),
              _tableCell('Disallow focus entirely'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('FocusTraversalGroup'),
              _tableCell('Scope + policy per region'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('FocusTraversalOrder'),
              _tableCell('Explicit order annotation'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('OrderedTraversalPolicy'),
              _tableCell('Sort by FocusTraversalOrder'),
            ]),
            TableRow(children: <Widget>[
              _tableCell('ExcludeFocus'),
              _tableCell('Exclude subtree from all focus'),
            ]),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.symptom,
    required this.cause,
    required this.fix,
    required this.fixCode,
    required this.cs,
  });
  final String number;
  final String title;
  final String symptom;
  final String cause;
  final String fix;
  final String fixCode;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: cs.errorContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 14,
                  backgroundColor: cs.error,
                  child: Text(
                    number,
                    style: TextStyle(
                      color: cs.onError,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onErrorContainer,
                    ),
                  ),
                ),
                Icon(Icons.warning_amber, color: cs.error),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _pitfallRow('Symptom', symptom, Icons.bug_report, cs),
                const SizedBox(height: 8),
                _pitfallRow('Cause', cause, Icons.search, cs),
                const SizedBox(height: 8),
                _pitfallRow('Fix', fix, Icons.check_circle, cs),
                const SizedBox(height: 10),
                _CodeBlock(code: fixCode, cs: cs),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pitfallRow(
    String label,
    String text,
    IconData icon,
    ColorScheme cs,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 16, color: cs.secondary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(text, style: const TextStyle(fontSize: 12, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Shared: code block widget
// ──────────────────────────────────────────────────────────────────────────────

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code, required this.cs});
  final String code;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFCDD6F4),
          height: 1.55,
        ),
      ),
    );
  }
}
