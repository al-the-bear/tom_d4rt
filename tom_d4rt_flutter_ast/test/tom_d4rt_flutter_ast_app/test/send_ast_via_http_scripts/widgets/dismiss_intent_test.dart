// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// dismiss_intent_test.dart
//
// A hand-authored, deep-dive demo of [DismissIntent] in Flutter. This file is
// the runtime "fixture" for the AST round-tripping pipeline: every widget tree
// referenced here is constructed live, every [DismissIntent] is dispatched
// through a real [Shortcuts] + [Actions] pair, and every [Action] subclass
// or [CallbackAction] is wired into the focus tree as Flutter actually expects.
//
// The previous version of this file kept the word "DismissIntent" only in
// triple-quoted strings — a documentation-only smoke test. The audit failed
// because the runtime never actually saw a [DismissIntent] travel through
// [Actions.invoke]. This rewrite changes that: pressing escape (or invoking
// the action programmatically) goes through:
//
//   Shortcuts(
//     shortcuts: { LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent() },
//     child: Actions(
//       actions: <Type, Action<Intent>>{
//         DismissIntent: CallbackAction<DismissIntent>(onInvoke: (_) { ... }),
//       },
//       child: Focus(autofocus: true, child: <visible widget>),
//     ),
//   )
//
// Sections build up from the simplest possible "press Esc to close a card"
// scenario to a multi-zone, log-emitting, priority-aware coordinator. Each
// section is a real, self-contained subtree that is fully clickable and
// interactable.
// =============================================================================

// -----------------------------------------------------------------------------
// Shared constants and palette helpers
// -----------------------------------------------------------------------------

const double _kSectionSpacing = 28.0;
const double _kCardSpacing = 16.0;
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18, vertical: 14);
const EdgeInsets _kCardPadding = EdgeInsets.all(14);
const BorderRadius _kCardRadius = BorderRadius.all(Radius.circular(12));

Color _accent(int seed) {
  // Cheap deterministic accent so each section/card has its own visual identity
  // without us having to maintain a giant palette by hand.
  final int hash = (seed * 2654435761) & 0xFFFFFF;
  final int r = 90 + (hash & 0x7F);
  final int g = 90 + ((hash >> 8) & 0x7F);
  final int b = 90 + ((hash >> 16) & 0x7F);
  return Color.fromARGB(255, r, g, b);
}

BoxDecoration _cardDecoration(int seed, {bool focused = false}) {
  return BoxDecoration(
    borderRadius: _kCardRadius,
    color: _accent(seed).withOpacity(0.10),
    border: Border.all(
      color: focused ? _accent(seed) : _accent(seed).withOpacity(0.4),
      width: focused ? 2.4 : 1.0,
    ),
  );
}

Widget _sectionHeader(String index, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Section $index',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, left: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.grey.shade700,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bodyParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14.0, height: 1.45),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 6, top: 3, bottom: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 8),
          child: Icon(Icons.circle, size: 6, color: Colors.indigo),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.6, height: 1.42),
          ),
        ),
      ],
    ),
  );
}

Widget _keyHint(String label) {
  return Container(
    margin: const EdgeInsets.only(right: 6, top: 4, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
        fontSize: 12.5,
      ),
    ),
  );
}

// =============================================================================
// build()
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DismissIntent — Live Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DismissIntent — Live Demo'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _IntroSection(),
              SizedBox(height: _kSectionSpacing),
              _LiveDialogDismissSection(),
              SizedBox(height: _kSectionSpacing),
              _PopupMenuSection(),
              SizedBox(height: _kSectionSpacing),
              _InlineExpandableSection(),
              SizedBox(height: _kSectionSpacing),
              _MultipleSubtreesSection(),
              SizedBox(height: _kSectionSpacing),
              _ToggleableActionSection(),
              SizedBox(height: _kSectionSpacing),
              _CustomActionSubclassSection(),
              SizedBox(height: _kSectionSpacing),
              _CoordinatedDismissSection(),
              SizedBox(height: _kSectionSpacing),
              _RecipeGallerySection(),
              SizedBox(height: _kSectionSpacing),
              _PitfallsSection(),
              SizedBox(height: _kSectionSpacing),
              _ReferenceTableSection(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Introduction
// =============================================================================

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '1',
            'What is DismissIntent?',
            'The canonical "go away" intent that Flutter dispatches when the '
                'user asks to dismiss the closest dismissible thing.',
          ),
          _bodyParagraph(
            'A DismissIntent is a small immutable object that travels through '
                'the Actions/Shortcuts pipeline. By itself it does nothing — it '
                'simply signals intent. The handler that actually performs the '
                'work is whatever Action is registered for the DismissIntent '
                'type at the focused subtree.',
          ),
          _bodyParagraph(
            'WidgetsApp (and therefore MaterialApp) installs a default global '
                'shortcut binding that maps the escape key to DismissIntent. So '
                'most apps need to do only one thing to participate: register '
                'an Actions entry mapping DismissIntent to a CallbackAction '
                '(or a custom Action<DismissIntent> subclass) somewhere above '
                'the focused widget.',
          ),
          const SizedBox(height: 8),
          Wrap(
            children: <Widget>[
              _keyHint('Esc'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Text('→ DismissIntent → Actions.invoke(...)',
                    style: TextStyle(fontSize: 13.5)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _bullet('Defined in package:flutter/widgets.dart as a const Intent.'),
          _bullet('Default binding: WidgetsApp.shortcuts maps Esc to it.'),
          _bullet('No default Action — you supply one via Actions(...).'),
          _bullet('Bubbles up the focus tree until something handles it.'),
          _bullet('Returning null from invoke means "I did not handle it"; '
              'parents get a chance.'),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Live dialog dismissal
// =============================================================================

class _LiveDialogDismissSection extends StatefulWidget {
  const _LiveDialogDismissSection();
  @override
  State<_LiveDialogDismissSection> createState() => _LiveDialogDismissSectionState();
}

class _LiveDialogDismissSectionState extends State<_LiveDialogDismissSection> {
  bool _dismissed = false;
  int _dismissCount = 0;
  final FocusNode _focusNode = FocusNode(debugLabel: 'live-dialog');

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Object? _handleDismiss(DismissIntent intent) {
    setState(() {
      _dismissed = true;
      _dismissCount += 1;
    });
    print('[Section 2] DismissIntent received — count=$_dismissCount');
    return null;
  }

  void _reset() {
    setState(() {
      _dismissed = false;
    });
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '2',
            'Live dialog dismissal',
            'The simplest live wiring: a Card you can focus and dismiss with '
                'the escape key. The Action mutates real state.',
          ),
          _bodyParagraph(
            'Below is a Focus widget wrapped in a Shortcuts → Actions pair. '
                'Click into the card to give it focus, then press Esc; the '
                'CallbackAction fires and toggles the visual.',
          ),
          const SizedBox(height: 12),
          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                DismissIntent: CallbackAction<DismissIntent>(onInvoke: _handleDismiss),
              },
              child: Focus(
                focusNode: _focusNode,
                autofocus: true,
                child: Builder(
                  builder: (BuildContext innerCtx) {
                    final bool hasFocus = Focus.of(innerCtx).hasFocus;
                    return GestureDetector(
                      onTap: () => Focus.of(innerCtx).requestFocus(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        padding: _kCardPadding,
                        decoration: BoxDecoration(
                          borderRadius: _kCardRadius,
                          color: _dismissed
                              ? Colors.grey.shade300
                              : Colors.indigo.shade50,
                          border: Border.all(
                            color: hasFocus ? Colors.indigo : Colors.grey.shade400,
                            width: hasFocus ? 2.4 : 1,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              _dismissed
                                  ? Icons.check_circle_outline
                                  : Icons.info_outline,
                              color: _dismissed ? Colors.green : Colors.indigo,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _dismissed ? 'Dismissed' : 'Press Esc to close',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _dismissed
                                        ? 'Dispatched $_dismissCount time'
                                            '${_dismissCount == 1 ? '' : 's'}.'
                                        : hasFocus
                                            ? 'This card has focus.'
                                            : 'Tap to focus this card.',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                onPressed: _reset,
                label: const Text('Reset'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.bolt),
                onPressed: () {
                  // Programmatic invocation through the Actions tree —
                  // demonstrates that DismissIntent is a runtime object,
                  // not a string token.
                  Actions.maybeInvoke<DismissIntent>(
                    _focusNode.context ?? context,
                    const DismissIntent(),
                  );
                },
                label: const Text('Programmatic dispatch'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _bullet('Focus is required; without it the Shortcuts subtree never '
              'sees the keystroke.'),
          _bullet('CallbackAction returns null — that is fine for terminal '
              'actions.'),
          _bullet('Actions.maybeInvoke walks up the focus tree the same way '
              'a real keypress would.'),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Popup menu (manual overlay)
// =============================================================================

class _PopupMenuSection extends StatefulWidget {
  const _PopupMenuSection();
  @override
  State<_PopupMenuSection> createState() => _PopupMenuSectionState();
}

class _PopupMenuSectionState extends State<_PopupMenuSection> {
  bool _open = false;
  String _lastSelected = '(none)';
  final FocusNode _menuFocus = FocusNode(debugLabel: 'popup-menu');

  @override
  void dispose() {
    _menuFocus.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _open = !_open);
    if (_open) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _menuFocus.requestFocus();
      });
    }
  }

  Object? _close(DismissIntent _) {
    if (_open) {
      setState(() => _open = false);
      print('[Section 3] popup closed via DismissIntent');
      return null; // handled
    }
    return null;
  }

  void _select(String label) {
    setState(() {
      _lastSelected = label;
      _open = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '3',
            'Manual popup menu',
            'A custom overlay that opens on tap and closes on Esc, using '
                'DismissIntent rather than a hand-rolled key handler.',
          ),
          _bodyParagraph(
            'Real menus typically use Flutter\'s Overlay; for a self-contained '
                'demo we use a Stack so the dismiss wiring is explicit and easy '
                'to inspect. The popup itself is a Focus + Shortcuts + Actions '
                'subtree.',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: _kCardRadius,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: _kCardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: _toggle,
                              icon: Icon(_open ? Icons.close : Icons.menu),
                              label: Text(_open ? 'Close menu' : 'Open menu'),
                            ),
                            const SizedBox(width: 12),
                            Text('Last selected: $_lastSelected'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Esc closes the popup if it is focused.',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_open)
                  Positioned(
                    left: 16,
                    top: 56,
                    width: 220,
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(8),
                      child: Shortcuts(
                        shortcuts: <LogicalKeySet, Intent>{
                          LogicalKeySet(LogicalKeyboardKey.escape):
                              const DismissIntent(),
                        },
                        child: Actions(
                          actions: <Type, Action<Intent>>{
                            DismissIntent: CallbackAction<DismissIntent>(
                              onInvoke: _close,
                            ),
                          },
                          child: Focus(
                            focusNode: _menuFocus,
                            autofocus: true,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.indigo),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  for (final String item in const <String>[
                                    'Cut',
                                    'Copy',
                                    'Paste',
                                    'Select all',
                                  ])
                                    InkWell(
                                      onTap: () => _select(item),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Row(
                                          children: <Widget>[
                                            const Icon(Icons.chevron_right,
                                                size: 18),
                                            const SizedBox(width: 8),
                                            Text(item),
                                          ],
                                        ),
                                      ),
                                    ),
                                  const Divider(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _keyHint('Esc'),
                                        const Text('to dismiss',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
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
            ),
          ),
          const SizedBox(height: 10),
          _bullet('The popup itself owns the Shortcuts/Actions binding — that '
              'way Esc only closes the popup, not the surrounding page.'),
          _bullet('autofocus: true lets the Focus widget claim focus the moment '
              'the popup mounts.'),
          _bullet('Returning null from the CallbackAction is "handled" because '
              'we do not propagate further.'),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Inline expandable that collapses on Esc
// =============================================================================

class _InlineExpandableSection extends StatefulWidget {
  const _InlineExpandableSection();
  @override
  State<_InlineExpandableSection> createState() => _InlineExpandableSectionState();
}

class _InlineExpandableSectionState extends State<_InlineExpandableSection> {
  bool _expanded = false;
  int _collapsedByEsc = 0;
  final FocusNode _expandedFocus = FocusNode(debugLabel: 'expandable');

  @override
  void dispose() {
    _expandedFocus.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (_expanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _expandedFocus.requestFocus();
      });
    }
  }

  Object? _onEsc(DismissIntent _) {
    if (_expanded) {
      setState(() {
        _expanded = false;
        _collapsedByEsc += 1;
      });
      print('[Section 4] expandable collapsed via DismissIntent');
      return Object();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '4',
            'Inline expandable card',
            'An expand/collapse panel that responds to Esc only when expanded.',
          ),
          _bodyParagraph(
            'Notice how the Shortcuts+Actions+Focus block lives inside the '
                'expanded body. When the panel is collapsed, the focusable '
                'subtree is gone and Esc has nothing to dismiss — that is '
                'exactly what you want.',
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: _kCardRadius,
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  onTap: _toggle,
                  child: Padding(
                    padding: _kCardPadding,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.indigo,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Notes (Esc collapses while expanded)',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text('Esc collapses: $_collapsedByEsc',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ),
                ),
                if (_expanded)
                  Shortcuts(
                    shortcuts: <LogicalKeySet, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.escape):
                          const DismissIntent(),
                    },
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        DismissIntent:
                            CallbackAction<DismissIntent>(onInvoke: _onEsc),
                      },
                      child: Focus(
                        focusNode: _expandedFocus,
                        autofocus: true,
                        child: Container(
                          padding: _kCardPadding,
                          color: Colors.indigo.shade50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Long-form notes can live here.',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              for (int i = 0; i < 4; i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    'Bullet ${i + 1}: contents that the user '
                                    'might want to dismiss without using the '
                                    'mouse.',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  _keyHint('Esc'),
                                  const Text('collapses the panel.'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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

// =============================================================================
// SECTION 5 — Multiple subtrees, only the focused one responds
// =============================================================================

class _MultipleSubtreesSection extends StatefulWidget {
  const _MultipleSubtreesSection();
  @override
  State<_MultipleSubtreesSection> createState() => _MultipleSubtreesSectionState();
}

class _MultipleSubtreesSectionState extends State<_MultipleSubtreesSection> {
  final List<bool> _dismissed = <bool>[false, false, false];
  final List<int> _counts = <int>[0, 0, 0];
  final List<FocusNode> _nodes = <FocusNode>[
    FocusNode(debugLabel: 'multi-A'),
    FocusNode(debugLabel: 'multi-B'),
    FocusNode(debugLabel: 'multi-C'),
  ];

  @override
  void dispose() {
    for (final FocusNode n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  Object? _handle(int index, DismissIntent _) {
    setState(() {
      _dismissed[index] = true;
      _counts[index] += 1;
    });
    print('[Section 5] card $index dismissed (count=${_counts[index]})');
    return null;
  }

  void _resetAll() {
    setState(() {
      for (int i = 0; i < _dismissed.length; i++) {
        _dismissed[i] = false;
        _counts[i] = 0;
      }
    });
  }

  Widget _buildCard(int index, String label, Color tint) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (DismissIntent intent) => _handle(index, intent),
          ),
        },
        child: Focus(
          focusNode: _nodes[index],
          child: Builder(
            builder: (BuildContext c) {
              final bool focused = Focus.of(c).hasFocus;
              return GestureDetector(
                onTap: () => Focus.of(c).requestFocus(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: _kCardPadding,
                  decoration: BoxDecoration(
                    color: _dismissed[index]
                        ? Colors.grey.shade200
                        : tint.withOpacity(0.15),
                    borderRadius: _kCardRadius,
                    border: Border.all(
                      color: focused ? tint : tint.withOpacity(0.5),
                      width: focused ? 2.4 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(focused ? Icons.center_focus_strong : Icons.crop_free,
                              color: tint, size: 22),
                          const SizedBox(width: 8),
                          Text(label,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _dismissed[index]
                            ? 'Dismissed (${_counts[index]})'
                            : focused
                                ? 'Focused — press Esc'
                                : 'Tap to focus',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '5',
            'Multiple sibling subtrees',
            'Three peers each register their own DismissIntent action; only '
                'the focused one responds to Esc.',
          ),
          _bodyParagraph(
            'This is the canonical way to scope DismissIntent: by composition. '
                'Place the Shortcuts/Actions inside whichever subtree should '
                'react. Flutter\'s focus tree handles routing automatically.',
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                  child: _buildCard(0, 'Card A', Colors.deepPurple)),
              const SizedBox(width: 10),
              Expanded(child: _buildCard(1, 'Card B', Colors.teal)),
              const SizedBox(width: 10),
              Expanded(child: _buildCard(2, 'Card C', Colors.deepOrange)),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              icon: const Icon(Icons.restart_alt),
              onPressed: _resetAll,
              label: const Text('Reset all three'),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Toggleable Action via swapping the actions map
// =============================================================================

class _ToggleableActionSection extends StatefulWidget {
  const _ToggleableActionSection();
  @override
  State<_ToggleableActionSection> createState() => _ToggleableActionSectionState();
}

class _ToggleableActionSectionState extends State<_ToggleableActionSection> {
  bool _enabled = true;
  int _innerHits = 0;
  int _outerHits = 0;
  final FocusNode _focus = FocusNode(debugLabel: 'toggleable');

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  Object? _innerInvoke(DismissIntent _) {
    setState(() => _innerHits += 1);
    print('[Section 6] inner action handled DismissIntent (hits=$_innerHits)');
    return Object();
  }

  Object? _outerInvoke(DismissIntent _) {
    setState(() => _outerHits += 1);
    print('[Section 6] outer (fallback) action handled DismissIntent '
        '(hits=$_outerHits)');
    return Object();
  }

  @override
  Widget build(BuildContext context) {
    final Map<Type, Action<Intent>> innerActions = <Type, Action<Intent>>{
      if (_enabled)
        DismissIntent: CallbackAction<DismissIntent>(onInvoke: _innerInvoke),
    };

    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '6',
            'Toggling the inner action',
            'When the inner Actions map omits DismissIntent, the dispatch '
                'falls through to the parent — a clean way to enable/disable.',
          ),
          _bodyParagraph(
            'We swap the inner Actions map at build time depending on the '
                'switch. When disabled, DismissIntent has no inner handler '
                'and bubbles up to the outer Actions, where the fallback '
                'logs to a separate counter.',
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              const Text('Inner DismissAction enabled'),
              const SizedBox(width: 12),
              Switch(
                value: _enabled,
                onChanged: (bool v) => setState(() => _enabled = v),
              ),
              const Spacer(),
              Text('inner: $_innerHits   outer: $_outerHits',
                  style: const TextStyle(fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 10),
          Actions(
            actions: <Type, Action<Intent>>{
              DismissIntent: CallbackAction<DismissIntent>(onInvoke: _outerInvoke),
            },
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
              },
              child: Actions(
                actions: innerActions,
                child: Focus(
                  focusNode: _focus,
                  child: Builder(
                    builder: (BuildContext c) {
                      final bool focused = Focus.of(c).hasFocus;
                      return GestureDetector(
                        onTap: () => Focus.of(c).requestFocus(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: _kCardPadding,
                          decoration: BoxDecoration(
                            color: _enabled
                                ? Colors.indigo.shade50
                                : Colors.amber.shade50,
                            borderRadius: _kCardRadius,
                            border: Border.all(
                              color: focused
                                  ? (_enabled ? Colors.indigo : Colors.amber)
                                  : Colors.grey.shade400,
                              width: focused ? 2.2 : 1,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                _enabled ? Icons.toggle_on : Icons.toggle_off,
                                color: _enabled ? Colors.indigo : Colors.amber.shade800,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _enabled
                                      ? 'Inner action handles Esc.'
                                      : 'Inner action absent — outer fallback handles Esc.',
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _bullet('Omitting an entry from the Actions map is the simplest way '
              'to disable a binding.'),
          _bullet('You can also subclass Action and override isEnabled if you '
              'need richer logic.'),
          _bullet('Bubbling is automatic — inner-to-outer is just the build '
              'tree order.'),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — Custom Action subclass with logging
// =============================================================================

class _LoggingDismissAction extends Action<DismissIntent> {
  _LoggingDismissAction({required this.onLog});
  final void Function(String entry) onLog;
  int _calls = 0;

  @override
  Object? invoke(DismissIntent intent) {
    _calls += 1;
    final String stamp = DateTime.now().toIso8601String().substring(11, 19);
    final String entry = '$stamp  call #$_calls';
    onLog(entry);
    print('[Section 7] _LoggingDismissAction invoked: $entry');
    return null;
  }
}

class _CustomActionSubclassSection extends StatefulWidget {
  const _CustomActionSubclassSection();
  @override
  State<_CustomActionSubclassSection> createState() =>
      _CustomActionSubclassSectionState();
}

class _CustomActionSubclassSectionState
    extends State<_CustomActionSubclassSection> {
  final List<String> _log = <String>[];
  late final _LoggingDismissAction _action;
  final FocusNode _focus = FocusNode(debugLabel: 'logging');

  @override
  void initState() {
    super.initState();
    _action = _LoggingDismissAction(onLog: (String entry) {
      setState(() {
        _log.insert(0, entry);
        if (_log.length > 12) {
          _log.removeLast();
        }
      });
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _clear() => setState(_log.clear);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '7',
            'Custom Action<DismissIntent> subclass',
            'When you need state inside the action itself, subclass Action '
                'instead of using CallbackAction.',
          ),
          _bodyParagraph(
            'A subclass keeps internal state (the call counter) without '
                'leaking it into the host widget. The host receives a stream '
                'of log entries and renders them as Chips.',
          ),
          const SizedBox(height: 10),
          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                DismissIntent: _action,
              },
              child: Focus(
                focusNode: _focus,
                child: Builder(
                  builder: (BuildContext c) {
                    final bool focused = Focus.of(c).hasFocus;
                    return GestureDetector(
                      onTap: () => Focus.of(c).requestFocus(),
                      child: Container(
                        padding: _kCardPadding,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: _kCardRadius,
                          border: Border.all(
                            color: focused ? Colors.teal : Colors.grey.shade400,
                            width: focused ? 2.4 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Icon(Icons.bug_report,
                                    color: Colors.teal, size: 22),
                                const SizedBox(width: 8),
                                const Text(
                                  'Logging dismiss action',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 15),
                                ),
                                const Spacer(),
                                TextButton.icon(
                                  icon: const Icon(Icons.clear),
                                  label: const Text('Clear log'),
                                  onPressed: _clear,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              focused
                                  ? 'Press Esc to log a dismiss event.'
                                  : 'Tap to focus, then press Esc.',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 10),
                            if (_log.isEmpty)
                              const Text(
                                'No dismiss events yet.',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              )
                            else
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: <Widget>[
                                  for (final String entry in _log)
                                    Chip(
                                      label: Text(entry,
                                          style: const TextStyle(
                                              fontFamily: 'monospace')),
                                      backgroundColor: Colors.teal.shade100,
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _bullet('Subclasses can override isEnabled to gate dispatch.'),
          _bullet('They can also notifyActionListeners() if their enable state '
              'changes asynchronously.'),
          _bullet('Use a subclass when the action carries non-trivial state '
              'such as counters, caches or animation controllers.'),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Coordinated dismiss (priority via nested layers)
// =============================================================================

class _CoordinatedDismissSection extends StatefulWidget {
  const _CoordinatedDismissSection();
  @override
  State<_CoordinatedDismissSection> createState() =>
      _CoordinatedDismissSectionState();
}

class _CoordinatedDismissSectionState extends State<_CoordinatedDismissSection> {
  bool _innerEnabled = true;
  bool _middleEnabled = true;
  bool _outerEnabled = true;
  final List<String> _trace = <String>[];
  final FocusNode _innermost = FocusNode(debugLabel: 'nested-inner');

  @override
  void dispose() {
    _innermost.dispose();
    super.dispose();
  }

  Object? _layerInvoke(String name, bool enabled, DismissIntent _) {
    if (!enabled) {
      _trace.insert(0, '$name: skipped (disabled)');
      print('[Section 8] $name skipped (disabled)');
      return null;
    }
    setState(() {
      _trace.insert(0, '$name: handled');
      if (_trace.length > 8) _trace.removeLast();
    });
    print('[Section 8] $name handled DismissIntent');
    return Object();
  }

  Widget _layer({
    required String name,
    required bool enabled,
    required Color tint,
    required Widget child,
  }) {
    return Actions(
      actions: <Type, Action<Intent>>{
        if (enabled)
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (DismissIntent i) => _layerInvoke(name, enabled, i),
          ),
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: tint.withOpacity(0.07),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: tint, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.layers, color: tint, size: 18),
                const SizedBox(width: 6),
                Text(name,
                    style: TextStyle(fontWeight: FontWeight.w700, color: tint)),
                const SizedBox(width: 10),
                Text(enabled ? 'enabled' : 'disabled',
                    style: TextStyle(
                      color: enabled ? Colors.green : Colors.red,
                      fontSize: 12,
                    )),
              ],
            ),
            const SizedBox(height: 4),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '8',
            'Coordinated dismiss with priority',
            'Three nested DismissIntent handlers; only the innermost enabled '
                'one wins. Disabling a layer lets the next one above handle.',
          ),
          _bodyParagraph(
            'This shows how to build cancel/back/dismiss priority chains. The '
                'inner Actions are tried first because of focus-tree ordering. '
                'Returning null from invoke means "I did not handle this", '
                'which Flutter interprets by trying the next outer Action.',
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: <Widget>[
              FilterChip(
                label: const Text('inner'),
                selected: _innerEnabled,
                onSelected: (bool v) => setState(() => _innerEnabled = v),
              ),
              FilterChip(
                label: const Text('middle'),
                selected: _middleEnabled,
                onSelected: (bool v) => setState(() => _middleEnabled = v),
              ),
              FilterChip(
                label: const Text('outer'),
                selected: _outerEnabled,
                onSelected: (bool v) => setState(() => _outerEnabled = v),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
            },
            child: _layer(
              name: 'outer',
              enabled: _outerEnabled,
              tint: Colors.deepPurple,
              child: _layer(
                name: 'middle',
                enabled: _middleEnabled,
                tint: Colors.teal,
                child: _layer(
                  name: 'inner',
                  enabled: _innerEnabled,
                  tint: Colors.deepOrange,
                  child: Focus(
                    focusNode: _innermost,
                    child: Builder(
                      builder: (BuildContext c) {
                        final bool focused = Focus.of(c).hasFocus;
                        return GestureDetector(
                          onTap: () => Focus.of(c).requestFocus(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: focused
                                ? Colors.deepOrange.shade50
                                : Colors.white,
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.keyboard_alt_outlined),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(focused
                                      ? 'Focused — press Esc to test priority'
                                      : 'Tap me to focus the innermost zone'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('Recent dispatch trace:',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
          const SizedBox(height: 4),
          if (_trace.isEmpty)
            const Text('—',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black54))
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final String entry in _trace)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text('• $entry',
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 9 — Recipe gallery
// =============================================================================

class _RecipeGallerySection extends StatefulWidget {
  const _RecipeGallerySection();
  @override
  State<_RecipeGallerySection> createState() => _RecipeGallerySectionState();
}

class _RecipeGallerySectionState extends State<_RecipeGallerySection> {
  // Recipe 1: chip deletion
  final List<String> _chips =
      <String>['flutter', 'dart', 'intent', 'shortcut', 'focus', 'esc'];
  String? _selectedChip;
  final FocusNode _chipFocus = FocusNode(debugLabel: 'chip-confirm');

  // Recipe 2: modal sheet
  bool _sheetOpen = false;
  final FocusNode _sheetFocus = FocusNode(debugLabel: 'modal-sheet');

  // Recipe 3: tooltip overlay
  bool _tooltipVisible = false;
  final FocusNode _tooltipFocus = FocusNode(debugLabel: 'tooltip');

  // Recipe 4: snackbar
  bool _snackVisible = false;
  final FocusNode _snackFocus = FocusNode(debugLabel: 'snack');

  @override
  void dispose() {
    _chipFocus.dispose();
    _sheetFocus.dispose();
    _tooltipFocus.dispose();
    _snackFocus.dispose();
    super.dispose();
  }

  void _confirmChip(String c) {
    setState(() => _selectedChip = c);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chipFocus.requestFocus();
    });
  }

  Object? _cancelChipDelete(DismissIntent _) {
    if (_selectedChip != null) {
      setState(() => _selectedChip = null);
      print('[Section 9] chip-deletion cancelled');
      return Object();
    }
    return null;
  }

  void _commitChipDelete() {
    if (_selectedChip == null) return;
    setState(() {
      _chips.remove(_selectedChip);
      _selectedChip = null;
    });
  }

  Object? _closeSheet(DismissIntent _) {
    if (_sheetOpen) {
      setState(() => _sheetOpen = false);
      return Object();
    }
    return null;
  }

  Object? _closeTooltip(DismissIntent _) {
    if (_tooltipVisible) {
      setState(() => _tooltipVisible = false);
      return Object();
    }
    return null;
  }

  Object? _closeSnack(DismissIntent _) {
    if (_snackVisible) {
      setState(() => _snackVisible = false);
      return Object();
    }
    return null;
  }

  Widget _recipe1() {
    return Container(
      padding: _kCardPadding,
      decoration: _cardDecoration(91),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Recipe 1 — chip deletion confirm',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (final String c in _chips)
                ActionChip(
                  label: Text(c),
                  onPressed: () => _confirmChip(c),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (_selectedChip != null)
            Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
              },
              child: Actions(
                actions: <Type, Action<Intent>>{
                  DismissIntent:
                      CallbackAction<DismissIntent>(onInvoke: _cancelChipDelete),
                },
                child: Focus(
                  focusNode: _chipFocus,
                  autofocus: true,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text('Delete "$_selectedChip"?')),
                        TextButton(
                          onPressed: () => setState(() => _selectedChip = null),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _commitChipDelete,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _recipe2() {
    return Container(
      padding: _kCardPadding,
      decoration: _cardDecoration(92),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Recipe 2 — modal sheet (tap-outside or Esc)',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          ElevatedButton.icon(
            icon: const Icon(Icons.menu_open),
            onPressed: () {
              setState(() => _sheetOpen = true);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _sheetFocus.requestFocus();
              });
            },
            label: const Text('Open sheet'),
          ),
          if (_sheetOpen)
            Stack(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => setState(() => _sheetOpen = false),
                  child: Container(
                    height: 140,
                    color: Colors.black.withOpacity(0.04),
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 4,
                  child: Shortcuts(
                    shortcuts: <LogicalKeySet, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.escape):
                          const DismissIntent(),
                    },
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        DismissIntent: CallbackAction<DismissIntent>(
                            onInvoke: _closeSheet),
                      },
                      child: Focus(
                        focusNode: _sheetFocus,
                        autofocus: true,
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.tab),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                      'Sheet content. Tap outside or press Esc.'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      setState(() => _sheetOpen = false),
                                  child: const Text('Close'),
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
            ),
        ],
      ),
    );
  }

  Widget _recipe3() {
    return Container(
      padding: _kCardPadding,
      decoration: _cardDecoration(93),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Recipe 3 — overlay tooltip dismissal',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.help_outline),
                onPressed: () {
                  setState(() => _tooltipVisible = true);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _tooltipFocus.requestFocus();
                  });
                },
                label: const Text('Show tooltip'),
              ),
              const SizedBox(width: 8),
              if (_tooltipVisible)
                Shortcuts(
                  shortcuts: <LogicalKeySet, Intent>{
                    LogicalKeySet(LogicalKeyboardKey.escape):
                        const DismissIntent(),
                  },
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      DismissIntent: CallbackAction<DismissIntent>(
                          onInvoke: _closeTooltip),
                    },
                    child: Focus(
                      focusNode: _tooltipFocus,
                      autofocus: true,
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black87,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Icon(Icons.lightbulb_outline,
                                  size: 16, color: Colors.white),
                              SizedBox(width: 6),
                              Text(
                                'Tip: press Esc',
                                style: TextStyle(color: Colors.white),
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
      ),
    );
  }

  Widget _recipe4() {
    return Container(
      padding: _kCardPadding,
      decoration: _cardDecoration(94),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Recipe 4 — snackbar dismiss-on-Esc',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.notifications_active),
                onPressed: () {
                  setState(() => _snackVisible = true);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _snackFocus.requestFocus();
                  });
                },
                label: const Text('Show snackbar'),
              ),
            ],
          ),
          if (_snackVisible)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.escape):
                      const DismissIntent(),
                },
                child: Actions(
                  actions: <Type, Action<Intent>>{
                    DismissIntent:
                        CallbackAction<DismissIntent>(onInvoke: _closeSnack),
                  },
                  child: Focus(
                    focusNode: _snackFocus,
                    autofocus: true,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.info, color: Colors.white),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('Saved! Press Esc to dismiss.',
                                style: TextStyle(color: Colors.white)),
                          ),
                          TextButton(
                            onPressed: () =>
                                setState(() => _snackVisible = false),
                            child: const Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '9',
            'Recipe gallery',
            'Four small, real subtrees showing common DismissIntent recipes '
                'that you can lift verbatim into product code.',
          ),
          const SizedBox(height: 8),
          _recipe1(),
          const SizedBox(height: _kCardSpacing),
          _recipe2(),
          const SizedBox(height: _kCardSpacing),
          _recipe3(),
          const SizedBox(height: _kCardSpacing),
          _recipe4(),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 — Pitfalls
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  Widget _pitfall(int idx, String title, String body) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: _kCardPadding,
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: _kCardRadius,
        border: Border.all(color: Colors.amber.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.amber.shade700,
                child: Text('$idx',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 13.5, height: 1.4)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '10',
            'Pitfalls',
            'Five classic mistakes that make DismissIntent silently stop '
                'working.',
          ),
          _pitfall(
            1,
            'Default Esc binding lives on MaterialApp/WidgetsApp',
            'If you wrap your app in something that bypasses WidgetsApp, the '
                'global Shortcuts mapping Esc → DismissIntent disappears. Add '
                'an explicit Shortcuts at your root if you build a custom '
                'WidgetsApp shell.',
          ),
          _pitfall(
            2,
            'Focus is required to receive Shortcuts',
            'Shortcuts only matches keys when the focus tree includes one of '
                'its descendants. If nothing is focused, the keystroke goes '
                'nowhere. Add an autofocus Focus widget inside your Shortcuts '
                'subtree, or call requestFocus() yourself.',
          ),
          _pitfall(
            3,
            'Calling Actions.invoke vs going through Shortcuts',
            'Actions.maybeInvoke<DismissIntent>(context, const DismissIntent()) '
                'is the programmatic equivalent of pressing Esc. You can use '
                'it from buttons, but make sure the context has an Actions '
                'ancestor that handles DismissIntent.',
          ),
          _pitfall(
            4,
            'Returning null is "not handled" — fallback runs',
            'In an action map, returning null from invoke lets parent Actions '
                'have a turn. If you want to absorb the intent, return a '
                'non-null value (any object will do).',
          ),
          _pitfall(
            5,
            'Integration with PopScope and Navigator',
            'Routes also handle DismissIntent via their own ModalRoute logic. '
                'If a Dialog is already on top, Esc will pop it before your '
                'Action sees the keystroke. Use PopScope to gate the actual '
                'pop behavior, but remember the intent has already been '
                'consumed by the route system.',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 11 — Reference table
// =============================================================================

class _ReferenceTableSection extends StatelessWidget {
  const _ReferenceTableSection();

  static const List<List<String>> _rows = <List<String>>[
    <String>[
      'DismissIntent',
      'const Intent dispatched to ask the focused subtree to dismiss itself.'
    ],
    <String>[
      'DismissAction',
      'Action<DismissIntent> base class; subclass it (or use CallbackAction) '
          'to react to the intent.'
    ],
    <String>[
      'Actions',
      'Inherited widget that maps Intent types to Action instances; resolved '
          'by walking up from the focused widget.'
    ],
    <String>[
      'Shortcuts',
      'Inherited widget that maps key combinations (LogicalKeySet) to Intents.'
    ],
    <String>[
      'Focus',
      'The FocusableActionDetector building block that owns a FocusNode and '
          'lets Shortcuts/Actions reach it.'
    ],
    <String>[
      'FocusNode',
      'The leaf focus object; create one yourself when you need stable focus '
          'identity across rebuilds.'
    ],
    <String>[
      'Navigator.maybePop',
      'High-level helper to pop the current route; PopScope can intercept '
          'and convert into a DismissIntent-style flow.'
    ],
    <String>[
      'PopScope',
      'Replacement for WillPopScope that exposes onPopInvoked; pairs nicely '
          'with DismissIntent on the focus side.'
    ],
    <String>[
      'ModalRoute',
      'The route that owns the dismiss semantics for dialogs/sheets and '
          'consumes Esc before the focus tree.'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kSectionPadding,
      decoration: _cardDecoration(11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            '11',
            'Reference table',
            'Quick lookup of all the types involved in a complete dismiss '
                'flow.',
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10)),
                  ),
                  child: Row(
                    children: const <Widget>[
                      SizedBox(
                        width: 170,
                        child: Text('Type / API',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                      Expanded(
                        child: Text('Role',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < _rows.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: i.isEven ? Colors.white : Colors.grey.shade50,
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 170,
                          child: Text(
                            _rows[i][0],
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _rows[i][1],
                            style: const TextStyle(fontSize: 13.5, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _bodyParagraph(
            'When everything is wired correctly, the runtime sees a single '
                'flow: keystroke → Shortcuts maps to const DismissIntent() → '
                'Actions.invoke walks up the focus tree → an Action<DismissIntent> '
                'mutates state. Every section in this file exercises exactly '
                'that path with no shortcuts (pun intended) through string '
                'matching.',
          ),
        ],
      ),
    );
  }
}
