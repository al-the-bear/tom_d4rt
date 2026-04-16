// D4rt deep visual demo — KeyboardListener.
//
// KeyboardListener is the modern, unified replacement for the deprecated
// RawKeyboardListener. It hooks into Flutter's HardwareKeyboard pipeline
// and delivers KeyEvent instances (KeyDownEvent, KeyRepeatEvent, KeyUpEvent)
// whenever its attached FocusNode has primary focus.
//
// Constructor:
//   KeyboardListener({
//     Key? key,
//     required FocusNode focusNode,
//     bool autofocus = false,
//     bool includeSemantics = true,
//     ValueChanged<KeyEvent>? onKeyEvent,
//     required Widget child,
//   })
//
// Deeply visual tour: hero banner, live listener, KeyEvent family cheat
// sheet, key matcher, modifier state, Ctrl+S shortcut, comparison with
// RawKeyboardListener/Focus.onKeyEvent/Shortcuts, pipeline diagram,
// pitfalls, API cheat sheet.  Stateless-only; top-level ValueNotifiers
// and a top-level FocusNode power the ValueListenableBuilders.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Top-level observables and singletons.
// A stateless demo uses final top-level instances to preserve identity across
// rebuilds — KeyboardListener in particular needs a stable FocusNode.
// ---------------------------------------------------------------------------
final FocusNode _focus = FocusNode(debugLabel: 'keyboard-listener-demo');
final FocusNode _shortcutFocus = FocusNode(debugLabel: 'shortcut-demo');
final ValueNotifier<List<String>> _log = ValueNotifier<List<String>>(
  <String>[
    'Focus the card above and start typing.',
    'Every KeyEvent appears here: Down, Repeat, Up.',
  ],
);
final ValueNotifier<LogicalKeyboardKey?> _lastMatch =
    ValueNotifier<LogicalKeyboardKey?>(null);
final ValueNotifier<int> _matchPulse = ValueNotifier<int>(0);
final ValueNotifier<Set<LogicalKeyboardKey>> _modifiers =
    ValueNotifier<Set<LogicalKeyboardKey>>(<LogicalKeyboardKey>{});
final ValueNotifier<int> _savedTick = ValueNotifier<int>(0);
final ValueNotifier<int> _keyCount = ValueNotifier<int>(0);

// Capture the last seen event so the cheat sheet can show live fields.
final ValueNotifier<_EventSnapshot?> _lastEvent =
    ValueNotifier<_EventSnapshot?>(null);

// Hard cap so the log list does not grow forever.
const int _kMaxLogEntries = 120;

// The matcher chip set — keys we light up when matched.
const List<LogicalKeyboardKey> _matchKeys = <LogicalKeyboardKey>[
  LogicalKeyboardKey.enter,
  LogicalKeyboardKey.escape,
  LogicalKeyboardKey.space,
  LogicalKeyboardKey.arrowLeft,
  LogicalKeyboardKey.arrowRight,
  LogicalKeyboardKey.arrowUp,
  LogicalKeyboardKey.arrowDown,
];

// ---------------------------------------------------------------------------
// Event snapshot — small value object capturing the latest KeyEvent so the
// cheat-sheet tab can show the same fields the user just produced.
// ---------------------------------------------------------------------------
class _EventSnapshot {
  const _EventSnapshot({
    required this.kind,
    required this.logicalLabel,
    required this.physicalLabel,
    required this.character,
    required this.timeStamp,
  });
  final String kind;
  final String logicalLabel;
  final String physicalLabel;
  final String character;
  final Duration timeStamp;
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F51B5),
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'KeyboardListener Tour',
    theme: theme,
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('KeyboardListener'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.keyboard_alt_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.graphic_eq), text: 'Live listener'),
              Tab(icon: Icon(Icons.library_books_outlined), text: 'KeyEvent'),
              Tab(icon: Icon(Icons.filter_center_focus), text: 'Matcher'),
              Tab(icon: Icon(Icons.tune), text: 'Modifiers'),
              Tab(icon: Icon(Icons.save_alt), text: 'Shortcut'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Compare'),
              Tab(icon: Icon(Icons.account_tree_outlined), text: 'Pipeline'),
              Tab(icon: Icon(Icons.report_gmailerrorred), text: 'Pitfalls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _LiveListenerTab(),
            _KeyEventFamilyTab(),
            _MatcherTab(),
            _ModifiersTab(),
            _ShortcutTab(),
            _ComparisonTab(),
            _PipelineTab(),
            _PitfallsTab(),
          ],
        ),
        bottomNavigationBar: const _ApiCheatSheet(),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Event handler used by both the live-listener tab and the shortcut tab.
// Extracts a normalized snapshot, appends to the log, updates modifier set,
// and pulses the matcher notifier when a well-known key arrives.
// ---------------------------------------------------------------------------
void _recordEvent(KeyEvent event) {
  final String kind;
  if (event is KeyDownEvent) {
    kind = 'Down';
  } else if (event is KeyRepeatEvent) {
    kind = 'Repeat';
  } else if (event is KeyUpEvent) {
    kind = 'Up';
  } else {
    kind = 'Event';
  }
  final String logicalLabel = event.logicalKey.keyLabel.isEmpty
      ? event.logicalKey.debugName ?? 'unknown'
      : event.logicalKey.keyLabel;
  final String physicalLabel = event.physicalKey.debugName ?? 'unknown';
  final String character = event.character ?? '';
  final _EventSnapshot snap = _EventSnapshot(
    kind: kind,
    logicalLabel: logicalLabel,
    physicalLabel: physicalLabel,
    character: character,
    timeStamp: event.timeStamp,
  );
  _lastEvent.value = snap;
  _keyCount.value = _keyCount.value + 1;
  // Modifier snapshot pulled straight from HardwareKeyboard.
  final Set<LogicalKeyboardKey> pressed =
      HardwareKeyboard.instance.logicalKeysPressed;
  _modifiers.value = <LogicalKeyboardKey>{
    for (final LogicalKeyboardKey k in pressed)
      if (_isModifier(k)) k,
  };
  // Update the matcher highlight when a known key is pressed.
  if (event is KeyDownEvent || event is KeyRepeatEvent) {
    for (final LogicalKeyboardKey match in _matchKeys) {
      if (match == event.logicalKey) {
        _lastMatch.value = match;
        _matchPulse.value = _matchPulse.value + 1;
        break;
      }
    }
  }
  // Build the log entry.
  final String charSuffix = character.isEmpty ? '' : '  "$character"';
  final String entry = '$kind ${_pretty(logicalLabel)}$charSuffix';
  final List<String> next = List<String>.from(_log.value)..add(entry);
  if (next.length > _kMaxLogEntries) {
    next.removeRange(0, next.length - _kMaxLogEntries);
  }
  _log.value = next;
}

void _recordShortcut(KeyEvent event) {
  // A very small Ctrl+S detector.  Mirror events into the modifier set so
  // users can see Ctrl light up while they hold it.
  final Set<LogicalKeyboardKey> pressed =
      HardwareKeyboard.instance.logicalKeysPressed;
  _modifiers.value = <LogicalKeyboardKey>{
    for (final LogicalKeyboardKey k in pressed)
      if (_isModifier(k)) k,
  };
  if (event is KeyDownEvent &&
      event.logicalKey == LogicalKeyboardKey.keyS &&
      (pressed.contains(LogicalKeyboardKey.controlLeft) ||
          pressed.contains(LogicalKeyboardKey.controlRight) ||
          pressed.contains(LogicalKeyboardKey.control))) {
    _savedTick.value = _savedTick.value + 1;
  }
}

bool _isModifier(LogicalKeyboardKey key) {
  return key == LogicalKeyboardKey.shift ||
      key == LogicalKeyboardKey.shiftLeft ||
      key == LogicalKeyboardKey.shiftRight ||
      key == LogicalKeyboardKey.control ||
      key == LogicalKeyboardKey.controlLeft ||
      key == LogicalKeyboardKey.controlRight ||
      key == LogicalKeyboardKey.alt ||
      key == LogicalKeyboardKey.altLeft ||
      key == LogicalKeyboardKey.altRight ||
      key == LogicalKeyboardKey.meta ||
      key == LogicalKeyboardKey.metaLeft ||
      key == LogicalKeyboardKey.metaRight;
}

String _pretty(String raw) {
  if (raw.length <= 18) return raw;
  return '${raw.substring(0, 16)}…';
}

// ===========================================================================
// SECTION 1 · Hero banner
// ===========================================================================
class _HeroTab extends StatelessWidget {
  const _HeroTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeroBanner(scheme: s),
        const SizedBox(height: 20),
        _SectionCard(
          icon: Icons.info_outline,
          accent: s.primary,
          title: 'What it is',
          body: 'KeyboardListener is the modern, unified key-event widget. '
              'It replaces RawKeyboardListener and routes KeyEvents from '
              'Flutter\'s HardwareKeyboard pipeline through a FocusNode '
              'to an onKeyEvent callback.',
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.code_outlined,
          accent: s.secondary,
          title: 'Constructor',
          body: 'KeyboardListener({\n'
              '  Key? key,\n'
              '  required FocusNode focusNode,\n'
              '  bool autofocus = false,\n'
              '  bool includeSemantics = true,\n'
              '  ValueChanged<KeyEvent>? onKeyEvent,\n'
              '  required Widget child,\n'
              '})',
          mono: true,
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.bolt_outlined,
          accent: s.tertiary,
          title: 'The KeyEvent model',
          body: 'A single sealed hierarchy:\n'
              '• KeyDownEvent — key pressed for the first time.\n'
              '• KeyRepeatEvent — OS auto-repeat while held.\n'
              '• KeyUpEvent — key released.\n'
              'All three expose logicalKey, physicalKey, character, '
              'timeStamp and share a common pipeline.',
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.rule,
          accent: s.primary,
          title: 'Why prefer it',
          body: '• Unified events across all platforms.\n'
              '• Synthesized events fix stuck-key bugs.\n'
              '• Accurate modifier state via HardwareKeyboard.\n'
              '• First-class support in modern Flutter.',
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.lightbulb_outline,
          accent: s.secondary,
          title: 'When to reach for it',
          body: '• Custom focusable widgets that need raw keys.\n'
              '• Games, drawing tools, terminal emulators.\n'
              '• Research/IDE UIs needing both char and code info.\n'
              '• Lightweight local shortcuts without a Shortcuts map.',
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[scheme.primary, scheme.tertiary],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.keyboard_alt_outlined,
                  color: scheme.onPrimary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'KeyboardListener',
                      style: TextStyle(
                        color: scheme.onPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Unified KeyEvents via FocusNode and HardwareKeyboard',
                      style: TextStyle(
                        color: scheme.onPrimary.withValues(alpha: 0.85),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const <Widget>[
              _HeroChip(label: 'KeyDownEvent'),
              _HeroChip(label: 'KeyRepeatEvent'),
              _HeroChip(label: 'KeyUpEvent'),
              _HeroChip(label: 'FocusNode gated'),
              _HeroChip(label: 'HardwareKeyboard'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: s.onPrimary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: s.onPrimary.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: s.onPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
    this.mono = false,
  });
  final IconData icon;
  final Color accent;
  final String title;
  final String body;
  final bool mono;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              fontSize: mono ? 12 : 13,
              height: mono ? 1.45 : 1.4,
              fontFamily: mono ? 'monospace' : null,
              color: s.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2 · Live KeyboardListener demo
// ===========================================================================
class _LiveListenerTab extends StatelessWidget {
  const _LiveListenerTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _LiveHeader(scheme: s),
          const SizedBox(height: 16),
          // The actual KeyboardListener wired to the top-level FocusNode.
          KeyboardListener(
            focusNode: _focus,
            autofocus: true,
            includeSemantics: true,
            onKeyEvent: _recordEvent,
            child: const _FocusableSurface(),
          ),
          const SizedBox(height: 18),
          _LiveToolbar(),
          const SizedBox(height: 18),
          const _LogPanel(),
          const SizedBox(height: 18),
          _LiveExplainer(scheme: s),
        ],
      ),
    );
  }
}

class _LiveHeader extends StatelessWidget {
  const _LiveHeader({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.graphic_eq, color: scheme.onPrimaryContainer, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Live KeyEvent stream',
                  style: TextStyle(
                    color: scheme.onPrimaryContainer,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'The card below is wrapped in a KeyboardListener with '
                  'autofocus: true. Every KeyEvent is forwarded to a '
                  'shared onKeyEvent that prints a line in the log.',
                  style: TextStyle(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.85),
                    fontSize: 12,
                    height: 1.4,
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

class _FocusableSurface extends StatelessWidget {
  const _FocusableSurface();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _focus.requestFocus,
      child: AnimatedBuilder(
        animation: _focus,
        builder: (BuildContext ctx, Widget? _) {
          final bool hasFocus = _focus.hasFocus;
          return Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  hasFocus
                      ? s.primary.withValues(alpha: 0.95)
                      : s.surfaceContainerHighest,
                  hasFocus
                      ? s.tertiary.withValues(alpha: 0.9)
                      : s.surfaceContainerHigh,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: hasFocus ? s.primary : s.outlineVariant,
                width: 2,
              ),
              boxShadow: hasFocus
                  ? <BoxShadow>[
                      BoxShadow(
                        color: s.primary.withValues(alpha: 0.30),
                        blurRadius: 22,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : <BoxShadow>[],
            ),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: hasFocus
                        ? s.onPrimary.withValues(alpha: 0.22)
                        : s.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    hasFocus ? Icons.keyboard : Icons.keyboard_alt_outlined,
                    color: hasFocus ? s.onPrimary : s.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        hasFocus ? 'Focused — press any key' : 'Tap to focus',
                        style: TextStyle(
                          color: hasFocus ? s.onPrimary : s.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        hasFocus
                            ? 'KeyboardListener is routing events to the log.'
                            : 'Click/tap the card to give it primary focus.',
                        style: TextStyle(
                          color: hasFocus
                              ? s.onPrimary.withValues(alpha: 0.9)
                              : s.onSurfaceVariant,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<int>(
                        valueListenable: _keyCount,
                        builder: (BuildContext ctx, int count, Widget? _) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: hasFocus
                                  ? s.onPrimary.withValues(alpha: 0.22)
                                  : s.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '$count events seen',
                              style: TextStyle(
                                color: hasFocus ? s.onPrimary : s.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LiveToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        FilledButton.tonalIcon(
          onPressed: () {
            _log.value = <String>[
              'Log cleared. Type something to refill it.',
            ];
            _keyCount.value = 0;
          },
          icon: const Icon(Icons.delete_sweep_outlined),
          label: const Text('Clear log'),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: _focus.requestFocus,
          icon: const Icon(Icons.center_focus_strong_outlined),
          label: const Text('Request focus'),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: _focus.unfocus,
          icon: const Icon(Icons.do_not_disturb_on_outlined),
          label: const Text('Unfocus'),
        ),
        const Spacer(),
        Icon(Icons.info_outline, size: 18, color: s.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(
          'Try holding a key for KeyRepeatEvent',
          style: TextStyle(fontSize: 11, color: s.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _LogPanel extends StatelessWidget {
  const _LogPanel();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: s.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: s.outlineVariant),
      ),
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.article_outlined, color: s.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                'KeyEvent log',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: s.onSurface,
                ),
              ),
              const Spacer(),
              ValueListenableBuilder<List<String>>(
                valueListenable: _log,
                builder: (BuildContext ctx, List<String> entries, Widget? _) {
                  return Text(
                    '${entries.length} lines',
                    style: TextStyle(
                      fontSize: 11,
                      color: s.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _log,
              builder: (BuildContext ctx, List<String> entries, Widget? _) {
                return ListView.builder(
                  reverse: true,
                  itemCount: entries.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    final String entry = entries[entries.length - 1 - i];
                    return _LogLine(text: entry);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LogLine extends StatelessWidget {
  const _LogLine({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    Color dot = s.primary;
    if (text.startsWith('Down')) {
      dot = s.primary;
    } else if (text.startsWith('Repeat')) {
      dot = s.secondary;
    } else if (text.startsWith('Up')) {
      dot = s.tertiary;
    } else {
      dot = s.outline;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5, right: 10),
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveExplainer extends StatelessWidget {
  const _LiveExplainer({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.school_outlined,
      accent: scheme.primary,
      title: 'What is happening',
      body: '1. Flutter registers a single KeyboardListener with the '
          'framework.\n'
          '2. A FocusNode — _focus — is attached to it.\n'
          '3. autofocus: true requests primary focus on first build.\n'
          '4. HardwareKeyboard emits KeyEvents for every physical press.\n'
          '5. The framework routes events only while _focus has focus.\n'
          '6. onKeyEvent is called synchronously with a typed KeyEvent.',
    );
  }
}

// ===========================================================================
// SECTION 3 · KeyEvent family cheat sheet
// ===========================================================================
class _KeyEventFamilyTab extends StatelessWidget {
  const _KeyEventFamilyTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.library_books_outlined,
          accent: s.primary,
          title: 'The KeyEvent hierarchy',
          body: 'All key events extend KeyEvent. The three concrete leaves '
              'give KeyboardListener everything it needs to model a '
              'keyboard without exposing platform quirks.',
        ),
        const SizedBox(height: 14),
        const _KeyEventCard(
          kind: 'KeyEvent',
          subtitle: 'Sealed base class',
          accent: Color(0xFF3F51B5),
          icon: Icons.grain,
          description: 'The shared supertype. Every instance exposes '
              'logicalKey, physicalKey, character, and timeStamp. '
              'KeyboardListener.onKeyEvent receives exactly this type; '
              'use pattern matching or is-checks to reach the subtypes.',
          fields: <_CheatField>[
            _CheatField(name: 'logicalKey',
                type: 'LogicalKeyboardKey',
                note: 'The key meaning — A, Enter, ArrowUp.'),
            _CheatField(name: 'physicalKey',
                type: 'PhysicalKeyboardKey',
                note: 'Where the key sits on the keyboard.'),
            _CheatField(name: 'character',
                type: 'String?',
                note: 'The composed character, e.g. "a", "A", null.'),
            _CheatField(name: 'timeStamp',
                type: 'Duration',
                note: 'Epoch-like timestamp of the event.'),
          ],
        ),
        const SizedBox(height: 14),
        const _KeyEventCard(
          kind: 'KeyDownEvent',
          subtitle: 'First-time press',
          accent: Color(0xFF2E7D32),
          icon: Icons.keyboard_arrow_down,
          description: 'Delivered exactly once when a key transitions from '
              'up to down. Use for actions that should not repeat: '
              'triggering a menu, firing a weapon, starting a drag.',
          fields: <_CheatField>[
            _CheatField(name: 'logicalKey',
                type: 'LogicalKeyboardKey',
                note: 'Meaning at press time.'),
            _CheatField(name: 'character',
                type: 'String?',
                note: 'Best-effort text input for this press.'),
            _CheatField(name: 'synthesized',
                type: 'bool',
                note: 'True when framework synthesized the event.'),
            _CheatField(name: 'deviceType',
                type: 'KeyEventDeviceType',
                note: 'Platform hint for the source device.'),
          ],
        ),
        const SizedBox(height: 14),
        const _KeyEventCard(
          kind: 'KeyRepeatEvent',
          subtitle: 'Auto-repeat while held',
          accent: Color(0xFFEF6C00),
          icon: Icons.repeat,
          description: 'Emitted by the OS while the key is held. The '
              'cadence depends on OS repeat settings; Flutter does not '
              'synthesize repeats. Useful for scrolling by arrow keys, '
              'text cursor navigation, or game input.',
          fields: <_CheatField>[
            _CheatField(name: 'logicalKey',
                type: 'LogicalKeyboardKey',
                note: 'Same as the down event.'),
            _CheatField(name: 'character',
                type: 'String?',
                note: 'May differ from Down if modifiers toggled.'),
            _CheatField(name: 'timeStamp',
                type: 'Duration',
                note: 'Updated per repeat tick.'),
            _CheatField(name: 'synthesized',
                type: 'bool',
                note: 'Usually false — repeats come from the OS.'),
          ],
        ),
        const SizedBox(height: 14),
        const _KeyEventCard(
          kind: 'KeyUpEvent',
          subtitle: 'Key released',
          accent: Color(0xFFAD1457),
          icon: Icons.keyboard_arrow_up,
          description: 'Sent when the key returns to the up state. Flutter '
              'synthesizes this event if the OS missed it (e.g. focus '
              'change while held) so modifier state stays consistent.',
          fields: <_CheatField>[
            _CheatField(name: 'logicalKey',
                type: 'LogicalKeyboardKey',
                note: 'Key released.'),
            _CheatField(name: 'character',
                type: 'String?',
                note: 'Often null on up events.'),
            _CheatField(name: 'synthesized',
                type: 'bool',
                note: 'True when the framework filled in a missed up.'),
            _CheatField(name: 'timeStamp',
                type: 'Duration',
                note: 'Time the release reached the framework.'),
          ],
        ),
        const SizedBox(height: 16),
        _LastEventPanel(scheme: s),
      ],
    );
  }
}

class _CheatField {
  const _CheatField({
    required this.name,
    required this.type,
    required this.note,
  });
  final String name;
  final String type;
  final String note;
}

class _KeyEventCard extends StatelessWidget {
  const _KeyEventCard({
    required this.kind,
    required this.subtitle,
    required this.accent,
    required this.icon,
    required this.description,
    required this.fields,
  });
  final String kind;
  final String subtitle;
  final Color accent;
  final IconData icon;
  final String description;
  final List<_CheatField> fields;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      kind,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: s.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: s.onSurface,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < fields.length; i++)
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: i == fields.length - 1 ? 0 : 10),
                    child: _FieldRow(field: fields[i], accent: accent),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.field, required this.accent});
  final _CheatField field;
  final Color accent;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            field.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            field.type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: s.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            field.note,
            style: TextStyle(
              fontSize: 12,
              height: 1.3,
              color: s.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _LastEventPanel extends StatelessWidget {
  const _LastEventPanel({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder<_EventSnapshot?>(
        valueListenable: _lastEvent,
        builder: (BuildContext ctx, _EventSnapshot? snap, Widget? _) {
          if (snap == null) {
            return Row(
              children: <Widget>[
                Icon(Icons.history_toggle_off,
                    color: scheme.onPrimaryContainer),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'No event captured yet. Visit the Live listener tab, '
                    'press a key, then come back here.',
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.history, color: scheme.onPrimaryContainer),
                  const SizedBox(width: 10),
                  Text(
                    'Last captured event',
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _snapRow('kind', snap.kind),
              _snapRow('logicalKey', snap.logicalLabel),
              _snapRow('physicalKey', snap.physicalLabel),
              _snapRow('character',
                  snap.character.isEmpty ? '(none)' : '"${snap.character}"'),
              _snapRow('timeStamp',
                  '${snap.timeStamp.inMilliseconds} ms'),
            ],
          );
        },
      ),
    );
  }

  Widget _snapRow(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              k,
              style: TextStyle(
                color: scheme.onPrimaryContainer.withValues(alpha: 0.8),
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4 · Key matcher
// ===========================================================================
class _MatcherTab extends StatelessWidget {
  const _MatcherTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.filter_center_focus,
          accent: s.primary,
          title: 'Recognizing specific keys',
          body: 'Compare event.logicalKey to well-known LogicalKeyboardKey '
              'constants. The chips below pulse whenever their key '
              'arrives in the live listener stream.',
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: s.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: s.outlineVariant),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Keys we watch',
                style: TextStyle(
                  color: s.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<LogicalKeyboardKey?>(
                valueListenable: _lastMatch,
                builder:
                    (BuildContext ctx, LogicalKeyboardKey? active, Widget? _) {
                  return ValueListenableBuilder<int>(
                    valueListenable: _matchPulse,
                    builder: (BuildContext ctx, int pulse, Widget? _) {
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: <Widget>[
                          for (final LogicalKeyboardKey k in _matchKeys)
                            _MatcherChip(
                              keyRef: k,
                              active: k == active,
                              pulse: pulse,
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 18),
              _MatchIndicator(scheme: s),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.bolt_outlined,
          accent: s.secondary,
          title: 'Pattern for matchers',
          body: 'if (event is KeyDownEvent &&\n'
              '    event.logicalKey == LogicalKeyboardKey.enter) {\n'
              '  _submit();\n'
              '}',
          mono: true,
        ),
      ],
    );
  }
}

class _MatcherChip extends StatelessWidget {
  const _MatcherChip({
    required this.keyRef,
    required this.active,
    required this.pulse,
  });
  final LogicalKeyboardKey keyRef;
  final bool active;
  final int pulse;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    final IconData icon = _iconFor(keyRef);
    final String label = _labelFor(keyRef);
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 380),
      tween: Tween<double>(begin: 1.0, end: active ? 1.08 : 1.0),
      key: ValueKey<String>('$label-$pulse-$active'),
      builder: (BuildContext ctx, double scale, Widget? child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active ? s.primary : s.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active ? s.primary : s.outlineVariant,
            width: active ? 2 : 1,
          ),
          boxShadow: active
              ? <BoxShadow>[
                  BoxShadow(
                    color: s.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : <BoxShadow>[],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: active ? s.onPrimary : s.primary,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: active ? s.onPrimary : s.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(LogicalKeyboardKey k) {
    if (k == LogicalKeyboardKey.enter) return Icons.keyboard_return;
    if (k == LogicalKeyboardKey.escape) return Icons.close;
    if (k == LogicalKeyboardKey.space) return Icons.space_bar;
    if (k == LogicalKeyboardKey.arrowLeft) return Icons.arrow_back;
    if (k == LogicalKeyboardKey.arrowRight) return Icons.arrow_forward;
    if (k == LogicalKeyboardKey.arrowUp) return Icons.arrow_upward;
    if (k == LogicalKeyboardKey.arrowDown) return Icons.arrow_downward;
    return Icons.keyboard;
  }

  String _labelFor(LogicalKeyboardKey k) {
    if (k == LogicalKeyboardKey.enter) return 'Enter';
    if (k == LogicalKeyboardKey.escape) return 'Escape';
    if (k == LogicalKeyboardKey.space) return 'Space';
    if (k == LogicalKeyboardKey.arrowLeft) return 'ArrowLeft';
    if (k == LogicalKeyboardKey.arrowRight) return 'ArrowRight';
    if (k == LogicalKeyboardKey.arrowUp) return 'ArrowUp';
    if (k == LogicalKeyboardKey.arrowDown) return 'ArrowDown';
    return k.keyLabel;
  }
}

class _MatchIndicator extends StatelessWidget {
  const _MatchIndicator({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LogicalKeyboardKey?>(
      valueListenable: _lastMatch,
      builder: (BuildContext ctx, LogicalKeyboardKey? k, Widget? _) {
        return ValueListenableBuilder<int>(
          valueListenable: _matchPulse,
          builder: (BuildContext ctx, int pulse, Widget? _) {
            return TweenAnimationBuilder<double>(
              key: ValueKey<int>(pulse),
              tween: Tween<double>(begin: 0.25, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (BuildContext ctx, double t, Widget? _) {
                final double alpha = (1.0 - t).clamp(0.0, 1.0);
                return Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: scheme.primary
                        .withValues(alpha: k == null ? 0.06 : 0.1 + alpha * 0.4),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: scheme.primary.withValues(
                          alpha: k == null ? 0.15 : 0.4 + alpha * 0.6),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    k == null ? 'Awaiting a watched key' : 'Matched: ${_name(k)}',
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String _name(LogicalKeyboardKey k) {
    if (k == LogicalKeyboardKey.enter) return 'Enter';
    if (k == LogicalKeyboardKey.escape) return 'Escape';
    if (k == LogicalKeyboardKey.space) return 'Space';
    if (k == LogicalKeyboardKey.arrowLeft) return 'ArrowLeft';
    if (k == LogicalKeyboardKey.arrowRight) return 'ArrowRight';
    if (k == LogicalKeyboardKey.arrowUp) return 'ArrowUp';
    if (k == LogicalKeyboardKey.arrowDown) return 'ArrowDown';
    return k.keyLabel;
  }
}

// ===========================================================================
// SECTION 5 · Modifier state
// ===========================================================================
class _ModifiersTab extends StatelessWidget {
  const _ModifiersTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.tune,
          accent: s.primary,
          title: 'HardwareKeyboard.instance.logicalKeysPressed',
          body: 'Each callback sees a fresh snapshot of the set of keys '
              'currently held. Reading it inside onKeyEvent is the '
              'idiomatic way to know which modifiers apply to a press.',
        ),
        const SizedBox(height: 14),
        const _ModifierBoard(),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.keyboard_command_key,
          accent: s.secondary,
          title: 'Typical recipe',
          body: 'final pressed = HardwareKeyboard.instance.logicalKeysPressed;\n'
              'final bool shift = pressed.contains(LogicalKeyboardKey.shiftLeft)\n'
              '    || pressed.contains(LogicalKeyboardKey.shiftRight);\n'
              'final bool ctrl = pressed.contains(LogicalKeyboardKey.controlLeft)\n'
              '    || pressed.contains(LogicalKeyboardKey.controlRight);',
          mono: true,
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.warning_amber_outlined,
          accent: s.tertiary,
          title: 'Why not event.isShiftPressed?',
          body: 'KeyEvent deliberately drops the per-event modifier flags '
              'that RawKeyEvent carried. The canonical source is now '
              'HardwareKeyboard, which tracks state across the whole '
              'application and stays consistent with synthesized events.',
        ),
      ],
    );
  }
}

class _ModifierBoard extends StatelessWidget {
  const _ModifierBoard();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: s.outlineVariant),
      ),
      padding: const EdgeInsets.all(18),
      child: ValueListenableBuilder<Set<LogicalKeyboardKey>>(
        valueListenable: _modifiers,
        builder:
            (BuildContext ctx, Set<LogicalKeyboardKey> held, Widget? _) {
          final bool shift = held.contains(LogicalKeyboardKey.shift) ||
              held.contains(LogicalKeyboardKey.shiftLeft) ||
              held.contains(LogicalKeyboardKey.shiftRight);
          final bool ctrl = held.contains(LogicalKeyboardKey.control) ||
              held.contains(LogicalKeyboardKey.controlLeft) ||
              held.contains(LogicalKeyboardKey.controlRight);
          final bool alt = held.contains(LogicalKeyboardKey.alt) ||
              held.contains(LogicalKeyboardKey.altLeft) ||
              held.contains(LogicalKeyboardKey.altRight);
          final bool meta = held.contains(LogicalKeyboardKey.meta) ||
              held.contains(LogicalKeyboardKey.metaLeft) ||
              held.contains(LogicalKeyboardKey.metaRight);
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _ModChip(
                        label: 'Shift', active: shift, icon: Icons.arrow_upward),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ModChip(
                        label: 'Ctrl',
                        active: ctrl,
                        icon: Icons.keyboard_control_key),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _ModChip(
                        label: 'Alt', active: alt, icon: Icons.alt_route),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ModChip(
                        label: 'Meta',
                        active: meta,
                        icon: Icons.keyboard_command_key),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                held.isEmpty
                    ? 'No modifiers currently held.'
                    : 'Held: ${held.map((LogicalKeyboardKey k) => k.keyLabel).join(', ')}',
                style: TextStyle(
                  color: s.onSurfaceVariant,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ModChip extends StatelessWidget {
  const _ModChip({
    required this.label,
    required this.active,
    required this.icon,
  });
  final String label;
  final bool active;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: active ? s.primary : s.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: active ? s.primary : s.outlineVariant,
          width: active ? 2 : 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            active ? Icons.check_circle : icon,
            color: active ? s.onPrimary : s.primary,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: active ? s.onPrimary : s.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            active ? 'held' : 'free',
            style: TextStyle(
              color: active
                  ? s.onPrimary.withValues(alpha: 0.9)
                  : s.onSurfaceVariant,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 6 · Shortcut implementation — Ctrl+S
// ===========================================================================
class _ShortcutTab extends StatelessWidget {
  const _ShortcutTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionCard(
            icon: Icons.save_alt,
            accent: s.primary,
            title: 'Local shortcut with KeyboardListener',
            body: 'A second KeyboardListener hosts its own FocusNode and '
                'looks for Ctrl+S on every KeyDownEvent. When matched, a '
                'top-level counter ticks; a TweenAnimationBuilder flashes '
                'a "Saved" badge for one second.',
          ),
          const SizedBox(height: 18),
          KeyboardListener(
            focusNode: _shortcutFocus,
            autofocus: false,
            onKeyEvent: _recordShortcut,
            child: _ShortcutSurface(scheme: s),
          ),
          const SizedBox(height: 18),
          const _SavedBadge(),
          const SizedBox(height: 18),
          _SectionCard(
            icon: Icons.code_outlined,
            accent: s.secondary,
            title: 'Implementation sketch',
            body: 'KeyboardListener(\n'
                '  focusNode: _focus,\n'
                '  autofocus: true,\n'
                '  onKeyEvent: (KeyEvent e) {\n'
                '    if (e is KeyDownEvent && e.logicalKey == LogicalKeyboardKey.keyS) {\n'
                '      final pressed = HardwareKeyboard.instance.logicalKeysPressed;\n'
                '      final bool ctrl = pressed.contains(LogicalKeyboardKey.controlLeft)\n'
                '          || pressed.contains(LogicalKeyboardKey.controlRight);\n'
                '      if (ctrl) _save();\n'
                '    }\n'
                '  },\n'
                '  child: _Editor(),\n'
                ')',
            mono: true,
          ),
          const SizedBox(height: 14),
          _SectionCard(
            icon: Icons.compare_arrows,
            accent: s.tertiary,
            title: 'When to prefer Shortcuts/Actions',
            body: 'For an app-wide chord that can be rebound, grouped with '
                'others, or routed through Actions, reach for the '
                'Shortcuts + Actions widgets. KeyboardListener is best '
                'for a single widget that owns its own tiny shortcut.',
          ),
        ],
      ),
    );
  }
}

class _ShortcutSurface extends StatelessWidget {
  const _ShortcutSurface({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _shortcutFocus.requestFocus,
      child: AnimatedBuilder(
        animation: _shortcutFocus,
        builder: (BuildContext ctx, Widget? _) {
          final bool focused = _shortcutFocus.hasFocus;
          return Container(
            height: 140,
            decoration: BoxDecoration(
              color: focused
                  ? scheme.secondaryContainer
                  : scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: focused ? scheme.secondary : scheme.outlineVariant,
                width: focused ? 2 : 1,
              ),
            ),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: <Widget>[
                Icon(
                  focused ? Icons.edit : Icons.touch_app_outlined,
                  color: focused ? scheme.onSecondaryContainer : scheme.primary,
                  size: 30,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        focused
                            ? 'Focused — press Ctrl + S'
                            : 'Tap here to focus, then press Ctrl + S',
                        style: TextStyle(
                          color: focused
                              ? scheme.onSecondaryContainer
                              : scheme.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Ctrl+S triggers a one-second "Saved" flash via '
                        'TweenAnimationBuilder.',
                        style: TextStyle(
                          color: focused
                              ? scheme.onSecondaryContainer
                                  .withValues(alpha: 0.85)
                              : scheme.onSurfaceVariant,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SavedBadge extends StatelessWidget {
  const _SavedBadge();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ValueListenableBuilder<int>(
      valueListenable: _savedTick,
      builder: (BuildContext ctx, int tick, Widget? _) {
        if (tick == 0) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: s.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.save_outlined, color: s.onSurfaceVariant),
                const SizedBox(width: 10),
                Text(
                  'No save yet — press Ctrl+S while the card is focused.',
                  style: TextStyle(
                    color: s.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }
        return TweenAnimationBuilder<double>(
          key: ValueKey<int>(tick),
          tween: Tween<double>(begin: 1.0, end: 0.0),
          duration: const Duration(milliseconds: 1000),
          builder: (BuildContext ctx, double t, Widget? _) {
            final double alpha = t.clamp(0.0, 1.0);
            return Opacity(
              opacity: 0.25 + alpha * 0.75,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color.lerp(
                      s.surfaceContainerHigh, s.primary, alpha),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: s.primary.withValues(alpha: 0.3 * alpha),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check_circle, color: s.onPrimary),
                    const SizedBox(width: 10),
                    Text(
                      'Saved ($tick)',
                      style: TextStyle(
                        color: s.onPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ===========================================================================
// SECTION 7 · Comparison table
// ===========================================================================
class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    final List<_CompareRow> rows = <_CompareRow>[
      const _CompareRow(
        mechanism: 'KeyboardListener',
        modernStatus: 'Current',
        eventType: 'KeyEvent',
        focusModel: 'FocusNode',
        bubbling: 'Always consumes — no bubbling',
      ),
      const _CompareRow(
        mechanism: 'RawKeyboardListener',
        modernStatus: 'Deprecated',
        eventType: 'RawKeyEvent',
        focusModel: 'FocusNode',
        bubbling: 'Bubble via onKey returning KeyEventResult',
      ),
      const _CompareRow(
        mechanism: 'Focus.onKeyEvent',
        modernStatus: 'Current',
        eventType: 'KeyEvent',
        focusModel: 'FocusNode (inline)',
        bubbling: 'Return KeyEventResult to bubble or consume',
      ),
      const _CompareRow(
        mechanism: 'Shortcuts + Actions',
        modernStatus: 'Current — preferred for chords',
        eventType: 'Intents (abstract)',
        focusModel: 'FocusNode via Actions scope',
        bubbling: 'Dispatches Intent up the Actions tree',
      ),
    ];
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.compare_arrows,
          accent: s.primary,
          title: 'Four ways to read keyboard input',
          body: 'Each mechanism trades off verbosity, routing flexibility '
              'and app-wide coordination. KeyboardListener is the small, '
              'local option for one widget that needs raw KeyEvents.',
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: s.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: s.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              _CompareHeader(scheme: s),
              for (int i = 0; i < rows.length; i++)
                _CompareRowTile(row: rows[i], odd: i.isOdd),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.lightbulb_outline,
          accent: s.secondary,
          title: 'Rule of thumb',
          body: '• Single widget, simple key reading → KeyboardListener.\n'
              '• Needs to bubble or cooperate → Focus.onKeyEvent.\n'
              '• App-wide, rebindable chord → Shortcuts + Actions.\n'
              '• Legacy project stuck on RawKeyEvent → plan to migrate.',
        ),
      ],
    );
  }
}

class _CompareRow {
  const _CompareRow({
    required this.mechanism,
    required this.modernStatus,
    required this.eventType,
    required this.focusModel,
    required this.bubbling,
  });
  final String mechanism;
  final String modernStatus;
  final String eventType;
  final String focusModel;
  final String bubbling;
}

class _CompareHeader extends StatelessWidget {
  const _CompareHeader({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: scheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text('Mechanism',
                style: _headerStyle(scheme.onPrimary)),
          ),
          Expanded(
            flex: 2,
            child: Text('Status',
                style: _headerStyle(scheme.onPrimary)),
          ),
          Expanded(
            flex: 2,
            child: Text('Event',
                style: _headerStyle(scheme.onPrimary)),
          ),
          Expanded(
            flex: 2,
            child: Text('Focus',
                style: _headerStyle(scheme.onPrimary)),
          ),
          Expanded(
            flex: 3,
            child: Text('Bubbling',
                style: _headerStyle(scheme.onPrimary)),
          ),
        ],
      ),
    );
  }

  TextStyle _headerStyle(Color c) => TextStyle(
        color: c,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      );
}

class _CompareRowTile extends StatelessWidget {
  const _CompareRowTile({required this.row, required this.odd});
  final _CompareRow row;
  final bool odd;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      color: odd ? s.surfaceContainerHigh : s.surface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row.mechanism,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: s.primary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.modernStatus,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.eventType,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.focusModel,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.bubbling,
              style: const TextStyle(fontSize: 11, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8 · Pipeline diagram via CustomPainter
// ===========================================================================
class _PipelineTab extends StatelessWidget {
  const _PipelineTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.account_tree_outlined,
          accent: s.primary,
          title: 'From hardware to onKeyEvent',
          body: 'Flutter normalizes every physical key via a pipeline. '
              'KeyboardListener sits near the end: it subscribes to the '
              'FocusManager so it only fires while its FocusNode has '
              'primary focus.',
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.1,
          child: Container(
            decoration: BoxDecoration(
              color: s.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: s.outlineVariant),
            ),
            padding: const EdgeInsets.all(14),
            child: CustomPaint(
              painter: _PipelinePainter(scheme: s),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.format_list_numbered,
          accent: s.secondary,
          title: 'Stage by stage',
          body: '1. Keyboard hardware sends a scancode to the OS.\n'
              '2. OS delivers a platform keyboard message to Flutter.\n'
              '3. HardwareKeyboard normalizes it into a KeyEvent.\n'
              '4. FocusManager routes the event to the focused path.\n'
              '5. FocusNode hands it to KeyboardListener if attached.\n'
              '6. KeyboardListener invokes onKeyEvent in your widget.',
        ),
      ],
    );
  }
}

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter({required this.scheme});
  final ColorScheme scheme;

  static const List<String> _stages = <String>[
    'Keyboard hardware',
    'Platform message',
    'HardwareKeyboard',
    'FocusManager',
    'FocusNode',
    'KeyboardListener',
    'onKeyEvent',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surface;
    canvas.drawRect(Offset.zero & size, bg);

    final double cellHeight = (size.height - 40) / _stages.length;
    final double cellWidth = size.width - 32;
    final Paint arrow = Paint()
      ..color = scheme.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint node = Paint()..color = scheme.primaryContainer;
    final Paint nodeBorder = Paint()
      ..color = scheme.primary
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < _stages.length; i++) {
      final double top = 20 + i * cellHeight;
      final Rect rect = Rect.fromLTWH(16, top, cellWidth, cellHeight - 18);
      final RRect rrect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(10),
      );
      canvas.drawRRect(rrect, node);
      canvas.drawRRect(rrect, nodeBorder);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${i + 1}.  ${_stages[i]}',
          style: TextStyle(
            color: scheme.onPrimaryContainer,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: rect.width - 16);
      tp.paint(canvas, Offset(rect.left + 12, rect.center.dy - tp.height / 2));
      if (i < _stages.length - 1) {
        final double arrowX = size.width / 2;
        final double arrowY1 = rect.bottom + 2;
        final double arrowY2 = rect.bottom + 16;
        canvas.drawLine(
          Offset(arrowX, arrowY1),
          Offset(arrowX, arrowY2),
          arrow,
        );
        // Arrow head
        final Path head = Path()
          ..moveTo(arrowX, arrowY2 + 4)
          ..lineTo(arrowX - 5, arrowY2 - 2)
          ..lineTo(arrowX + 5, arrowY2 - 2)
          ..close();
        canvas.drawPath(head, Paint()..color = scheme.primary);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter old) =>
      old.scheme != scheme;
}

// ===========================================================================
// SECTION 9 · Pitfalls
// ===========================================================================
class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.report_gmailerrorred,
          accent: s.error,
          title: 'Common traps',
          body: 'Most reports of "KeyboardListener doesn\'t fire" trace '
              'back to one of the three issues below. The framework is '
              'working correctly; focus or ancestor widgets are not.',
        ),
        const SizedBox(height: 16),
        _Pitfall(
          accent: s.error,
          icon: Icons.center_focus_strong_outlined,
          title: '1. Focus never obtained',
          body: 'KeyboardListener only receives events while its FocusNode '
              'has primary focus. A child tap handler, a text field, or a '
              'higher-priority FocusScope can silently steal it. Debug by '
              'watching focusNode.hasFocus.',
          fix: 'Call focusNode.requestFocus() from a GestureDetector on '
              'tap, or use autofocus: true at the top of the relevant '
              'FocusScope.',
        ),
        const SizedBox(height: 14),
        _Pitfall(
          accent: s.tertiary,
          icon: Icons.auto_fix_high,
          title: '2. Missing autofocus',
          body: 'When the widget enters the tree but no one requests focus, '
              'KeyboardListener stays silent until the user clicks. Users '
              'often assume the demo is broken.',
          fix: 'Pass autofocus: true, or drive focus explicitly via '
              'FocusScope.of(context).requestFocus(_focus) in a Builder.',
        ),
        const SizedBox(height: 14),
        _Pitfall(
          accent: s.primary,
          icon: Icons.alt_route,
          title: '3. Expecting events to bubble',
          body: 'Unlike Focus.onKeyEvent, KeyboardListener does not let you '
              'return KeyEventResult.ignored to pass the event upward. '
              'onKeyEvent is fire-and-forget — it cannot stop an ancestor '
              'from handling the key afterwards.',
          fix: 'Use Focus or FocusableActionDetector when you need to '
              'control bubbling; reserve KeyboardListener for '
              '"I only want to look at these keys, no routing concerns".',
        ),
        const SizedBox(height: 14),
        _SectionCard(
          icon: Icons.troubleshoot,
          accent: s.secondary,
          title: 'Debug checklist',
          body: '• Print focusNode.hasFocus in the build method.\n'
              '• Verify HardwareKeyboard.instance is not disabled.\n'
              '• Confirm no ancestor FocusScope steals primary focus.\n'
              '• Ensure the widget is actually in the tree (not behind '
              'an Offstage or a hidden Route).',
        ),
      ],
    );
  }
}

class _Pitfall extends StatelessWidget {
  const _Pitfall({
    required this.accent,
    required this.icon,
    required this.title,
    required this.body,
    required this.fix,
  });
  final Color accent;
  final IconData icon;
  final String title;
  final String body;
  final String fix;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.build_circle_outlined, color: accent, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fix,
                    style: TextStyle(
                      color: s.onSurface,
                      fontSize: 12,
                      height: 1.4,
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

// ===========================================================================
// SECTION 10 · API cheat sheet (bottom nav)
// ===========================================================================
class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: s.surfaceContainerHighest,
        border: Border(top: BorderSide(color: s.outlineVariant)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book_outlined, size: 18, color: s.primary),
              const SizedBox(width: 8),
              Text(
                'API cheat sheet',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: s.onSurface,
                ),
              ),
              const Spacer(),
              Text(
                'package:flutter/widgets.dart',
                style: TextStyle(
                  fontSize: 11,
                  color: s.onSurfaceVariant,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _ApiPill(
                label: 'KeyboardListener',
                detail: '{focusNode, autofocus, onKeyEvent, child}',
              ),
              _ApiPill(
                label: 'KeyEvent',
                detail: 'logicalKey • physicalKey • character • timeStamp',
              ),
              _ApiPill(
                label: 'KeyDownEvent',
                detail: 'first press',
              ),
              _ApiPill(
                label: 'KeyRepeatEvent',
                detail: 'auto-repeat',
              ),
              _ApiPill(
                label: 'KeyUpEvent',
                detail: 'release',
              ),
              _ApiPill(
                label: 'HardwareKeyboard.instance',
                detail: 'logicalKeysPressed',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ApiPill extends StatelessWidget {
  const _ApiPill({required this.label, required this.detail});
  final String label;
  final String detail;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: s.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: s.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: s.primary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 6),
          Text(
            detail,
            style: TextStyle(
              color: s.onSurface,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
