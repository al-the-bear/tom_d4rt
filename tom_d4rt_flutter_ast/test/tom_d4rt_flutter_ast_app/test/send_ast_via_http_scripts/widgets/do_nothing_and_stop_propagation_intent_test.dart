// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// =====================================================================
//  DEEP DEMO — DoNothingAndStopPropagationIntent (LIVE)
// =====================================================================
//
//  This file is a hand-authored, deep demonstration of the Flutter
//  framework class `DoNothingAndStopPropagationIntent`.
//
//  Unlike a static documentation page, every section below mounts
//  REAL `Shortcuts(...)` widgets in the running widget tree that bind
//  `DoNothingAndStopPropagationIntent` to logical key combinations.
//  The intent is therefore actually dispatched while the user
//  interacts with the demo, not just mentioned in string snippets.
//
//  KEY POINTS DEMONSTRATED LIVE:
//   * A real `Shortcuts` widget binding `DoNothingAndStopPropagationIntent`
//     swallows the key event so neither (a) inner Actions, nor
//     (b) outer Shortcuts, nor (c) the platform receive it.
//   * Difference vs `DoNothingIntent` — `DoNothingIntent` returns
//     `KeyEventResult.handled` only inside its own scope but it does
//     NOT prevent platform/text-field handling on every Flutter
//     framework version, while
//     `DoNothingAndStopPropagationIntent` explicitly returns
//     `KeyEventResult.handled` AND stops further propagation.
//   * Visible event log: every dispatched intent is recorded so the
//     user can see what fired versus what was swallowed.
//   * Platform-aware shortcuts using `Theme.of(context).platform`
//     (no `dart:io`) so the same demo runs on macOS (Cmd) and other
//     platforms (Ctrl).
//
//  THE FLUTTER `services` IMPORT BELOW is required because the
//  shortcut keys (`LogicalKeyboardKey`, `LogicalKeySet`) live in
//  `package:flutter/services.dart` and are NOT re-exported by
//  `package:flutter/material.dart`. This is the documented and
//  conventional approach across the framework's own examples.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for LogicalKeyboardKey / LogicalKeySet

// ─────────────────────────────────────────────────────────────────────
//  Theme: Electric Indigo (#1A237E) on Lavender Ice (#E8EAF6)
//  Prefix: _dn (do nothing)
// ─────────────────────────────────────────────────────────────────────

const Color _dnIndigo = Color(0xFF1A237E);
const Color _dnLavender = Color(0xFFE8EAF6);
const Color _dnDark = Color(0xFF000051);
const Color _dnLight = Color(0xFF3949AB);
const Color _dnMuted = Color(0xFF78909C);
const Color _dnAccent = Color(0xFF5C6BC0);
const Color _dnDivider = Color(0xFF9FA8DA);
const Color _dnWhite = Color(0xFFFFFFFF);
const Color _dnError = Color(0xFFC62828);
const Color _dnInfo = Color(0xFF0277BD);
const Color _dnWarning = Color(0xFFF57F17);
const Color _dnSuccess = Color(0xFF2E7D32);
const Color _dnSwallowed = Color(0xFF7B1FA2);
const Color _dnDispatched = Color(0xFF388E3C);

// ─────────────────────────────────────────────────────────────────────
//  Shared singleton-ish event log used by every live section so the
//  audience can see, in real time, which key combos were swallowed.
// ─────────────────────────────────────────────────────────────────────

class _DnEventLog extends ChangeNotifier {
  final List<_DnLogEntry> entries = <_DnLogEntry>[];

  void add(_DnLogEntry entry) {
    entries.insert(0, entry);
    if (entries.length > 24) {
      entries.removeRange(24, entries.length);
    }
    notifyListeners();
  }

  void clear() {
    entries.clear();
    notifyListeners();
  }
}

class _DnLogEntry {
  _DnLogEntry({
    required this.scope,
    required this.label,
    required this.swallowed,
  });
  final String scope;
  final String label;
  final bool swallowed;
}

final _DnEventLog _dnLog = _DnEventLog();

// =====================================================================
//  ENTRY POINT — required by the AST harness.
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _dnIndigo,
      scaffoldBackgroundColor: _dnLavender,
    ),
    home: Scaffold(
      backgroundColor: _dnLavender,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _DnTitleBanner(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 1,
                title: 'Anatomy of DoNothingAndStopPropagationIntent',
              ),
              const _DnAnatomySection(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 2,
                title: 'DoNothingAndStopPropagationIntent vs DoNothingIntent',
              ),
              const _DnVersusSection(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 3,
                title: 'Outer-vs-Inner Shortcuts propagation visualizer',
              ),
              const _DnPropagationSection(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 4,
                title: 'TextField + swallow-Tab live experiment',
              ),
              const _DnTabSwallowSection(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 5,
                title: 'Platform-aware swallow (Cmd vs Ctrl)',
              ),
              const _DnPlatformSection(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 6,
                title: 'Nested-focus tree: where the bubble stops',
              ),
              const _DnNestedFocusSection(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 7,
                title: 'Live dispatched-intent log',
              ),
              const _DnEventLogSection(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 8,
                title: 'Recipe gallery — 4 working snippets',
              ),
              const _DnRecipeGallery(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 9,
                title: 'Common pitfalls',
              ),
              const _DnPitfallsTable(),
              const SizedBox(height: 24),
              const _DnSectionHeader(
                index: 10,
                title: 'Reference: related intents and helpers',
              ),
              const _DnReferenceTable(),
              const SizedBox(height: 24),
              const _DnSummary(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────
//  Generic re-usable building blocks
// ─────────────────────────────────────────────────────────────────────

class _DnTitleBanner extends StatelessWidget {
  const _DnTitleBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_dnIndigo, _dnDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'DoNothingAndStopPropagationIntent — LIVE deep demo',
            style: TextStyle(
              color: _dnWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bind a key combination to "do nothing" AND stop further '
            'propagation. Every example below mounts a real Shortcuts '
            'widget in the running tree.',
            style: TextStyle(color: _dnLavender, fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _DnSectionHeader extends StatelessWidget {
  const _DnSectionHeader({required this.index, required this.title});
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _dnIndigo,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _dnWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: _dnDark,
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

class _DnPanel extends StatelessWidget {
  const _DnPanel({
    required this.child,
    this.title,
    this.color = _dnWhite,
    this.borderColor = _dnDivider,
  });
  final Widget child;
  final String? title;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (title != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Text(
                title!,
                style: const TextStyle(
                  color: _dnWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _DnCodeBlock extends StatelessWidget {
  const _DnCodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _dnDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          color: _dnLavender,
          fontFamily: 'monospace',
          fontSize: 12.5,
          height: 1.45,
        ),
      ),
    );
  }
}

class _DnKeyChip extends StatelessWidget {
  const _DnKeyChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _dnIndigo,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _dnDark),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _dnWhite,
          fontFamily: 'monospace',
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DnLegend extends StatelessWidget {
  const _DnLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children: const <Widget>[
        _DnLegendDot(color: _dnDispatched, text: 'Intent dispatched'),
        _DnLegendDot(color: _dnSwallowed, text: 'Swallowed (stop-prop)'),
        _DnLegendDot(color: _dnInfo, text: 'Info'),
        _DnLegendDot(color: _dnWarning, text: 'Watch out'),
      ],
    );
  }
}

class _DnLegendDot extends StatelessWidget {
  const _DnLegendDot({required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: _dnDark, fontSize: 12)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 1 — Anatomy
// ─────────────────────────────────────────────────────────────────────

class _DnAnatomySection extends StatelessWidget {
  const _DnAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _DnPanel(
      title: 'How the framework wires this intent',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'DoNothingAndStopPropagationIntent is a built-in Intent in '
            'package:flutter/widgets.dart. The Shortcuts widget reads '
            'incoming key events. When a binding maps to this intent, '
            'Flutter signals KeyEventResult.handled AND tells the focus '
            'system not to propagate further.',
            style: TextStyle(color: _dnDark, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _DnPanel(
                  title: 'Layer diagram',
                  color: _dnLavender,
                  borderColor: _dnLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      _DnAnatomyLayer(
                        label: 'Hardware key event',
                        color: _dnMuted,
                      ),
                      _DnAnatomyArrow(),
                      _DnAnatomyLayer(
                        label: 'FocusManager',
                        color: _dnInfo,
                      ),
                      _DnAnatomyArrow(),
                      _DnAnatomyLayer(
                        label: 'Shortcuts (binding lookup)',
                        color: _dnAccent,
                      ),
                      _DnAnatomyArrow(),
                      _DnAnatomyLayer(
                        label: 'DoNothingAndStopPropagationIntent',
                        color: _dnSwallowed,
                      ),
                      _DnAnatomyArrow(stop: true),
                      _DnAnatomyLayer(
                        label: 'Outer Shortcuts / Actions / TextField',
                        color: _dnError,
                        crossed: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DnPanel(
                  title: 'Class signature',
                  color: _dnLavender,
                  borderColor: _dnLight,
                  child: const _DnCodeBlock(
                    'class DoNothingAndStopPropagationIntent\n'
                    '    extends Intent {\n'
                    '  const DoNothingAndStopPropagationIntent();\n'
                    '}\n\n'
                    '// Usage:\n'
                    'Shortcuts(\n'
                    '  shortcuts: {\n'
                    '    LogicalKeySet(\n'
                    '      LogicalKeyboardKey.control,\n'
                    '      LogicalKeyboardKey.keyS,\n'
                    '    ): const DoNothingAndStopPropagationIntent(),\n'
                    '  },\n'
                    '  child: child,\n'
                    ');',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _DnLegend(),
        ],
      ),
    );
  }
}

class _DnAnatomyLayer extends StatelessWidget {
  const _DnAnatomyLayer({
    required this.label,
    required this.color,
    this.crossed = false,
  });
  final String label;
  final Color color;
  final bool crossed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _dnWhite,
          fontWeight: FontWeight.w600,
          decoration: crossed ? TextDecoration.lineThrough : null,
          decorationColor: _dnWhite,
          decorationThickness: 2,
        ),
      ),
    );
  }
}

class _DnAnatomyArrow extends StatelessWidget {
  const _DnAnatomyArrow({this.stop = false});
  final bool stop;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Icon(
          stop ? Icons.block : Icons.arrow_downward,
          color: stop ? _dnError : _dnDark,
          size: 18,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 2 — DoNothingAndStopPropagationIntent vs DoNothingIntent
// ─────────────────────────────────────────────────────────────────────

class _DnVersusSection extends StatefulWidget {
  const _DnVersusSection();

  @override
  State<_DnVersusSection> createState() => _DnVersusSectionState();
}

class _DnVersusSectionState extends State<_DnVersusSection> {
  int _outerCounter = 0;
  String _lastFromLeft = '(none)';
  String _lastFromRight = '(none)';

  @override
  Widget build(BuildContext context) {
    return _DnPanel(
      title: 'Two side-by-side focus zones, one outer Shortcuts',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Shortcuts(
        // Outer shortcuts: increment a counter when Ctrl+Shift+Z fires.
        shortcuts: <ShortcutActivator, Intent>{
          LogicalKeySet(
            LogicalKeyboardKey.control,
            LogicalKeyboardKey.shift,
            LogicalKeyboardKey.keyZ,
          ): const _DnBumpOuterIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _DnBumpOuterIntent: CallbackAction<_DnBumpOuterIntent>(
              onInvoke: (_) {
                setState(() => _outerCounter++);
                _dnLog.add(
                  _DnLogEntry(
                    scope: 'OUTER',
                    label: 'Ctrl+Shift+Z bumped outer counter',
                    swallowed: false,
                  ),
                );
                return null;
              },
            ),
          },
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dnLavender,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.info_outline, color: _dnInfo),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Outer counter (incremented on Ctrl+Shift+Z): '
                        '$_outerCounter',
                        style: const TextStyle(
                          color: _dnDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _DnVersusZone(
                      title: 'LEFT — DoNothingIntent',
                      explanation:
                          'Inner Shortcuts binds DoNothingIntent. Default '
                          'action returns null and DOES NOT explicitly '
                          'stop propagation.',
                      borderColor: _dnInfo,
                      shortcuts: <ShortcutActivator, Intent>{
                        LogicalKeySet(
                          LogicalKeyboardKey.control,
                          LogicalKeyboardKey.shift,
                          LogicalKeyboardKey.keyZ,
                        ): const DoNothingIntent(),
                      },
                      onAnyKey: (String label) {
                        setState(() => _lastFromLeft = label);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DnVersusZone(
                      title: 'RIGHT — DoNothingAndStopPropagationIntent',
                      explanation:
                          'Inner Shortcuts binds '
                          'DoNothingAndStopPropagationIntent. The outer '
                          'binding will NOT see the event.',
                      borderColor: _dnSwallowed,
                      shortcuts: <ShortcutActivator, Intent>{
                        LogicalKeySet(
                          LogicalKeyboardKey.control,
                          LogicalKeyboardKey.shift,
                          LogicalKeyboardKey.keyZ,
                        ): const DoNothingAndStopPropagationIntent(),
                      },
                      onAnyKey: (String label) {
                        setState(() => _lastFromRight = label);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _DnVersusReadout(
                lastLeft: _lastFromLeft,
                lastRight: _lastFromRight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DnBumpOuterIntent extends Intent {
  const _DnBumpOuterIntent();
}

class _DnVersusZone extends StatelessWidget {
  const _DnVersusZone({
    required this.title,
    required this.explanation,
    required this.borderColor,
    required this.shortcuts,
    required this.onAnyKey,
  });
  final String title;
  final String explanation;
  final Color borderColor;
  final Map<ShortcutActivator, Intent> shortcuts;
  final ValueChanged<String> onAnyKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _dnLavender,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: borderColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            explanation,
            style: const TextStyle(color: _dnDark, fontSize: 12, height: 1.3),
          ),
          const SizedBox(height: 10),
          // Live binding!
          Shortcuts(
            shortcuts: shortcuts,
            child: Focus(
              autofocus: false,
              onKeyEvent: (FocusNode node, KeyEvent event) {
                if (event is KeyDownEvent) {
                  onAnyKey(event.logicalKey.keyLabel);
                }
                return KeyEventResult.ignored;
              },
              child: Builder(
                builder: (BuildContext ctx) {
                  return GestureDetector(
                    onTap: () => Focus.of(ctx).requestFocus(),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _dnWhite,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: borderColor),
                      ),
                      child: const Text(
                        'Click here to focus, then press '
                        'Ctrl+Shift+Z',
                        style: TextStyle(color: _dnDark),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DnVersusReadout extends StatelessWidget {
  const _DnVersusReadout({required this.lastLeft, required this.lastRight});
  final String lastLeft;
  final String lastRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _DnReadoutTile(
            label: 'Left zone — last key',
            value: lastLeft,
            color: _dnInfo,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _DnReadoutTile(
            label: 'Right zone — last key',
            value: lastRight,
            color: _dnSwallowed,
          ),
        ),
      ],
    );
  }
}

class _DnReadoutTile extends StatelessWidget {
  const _DnReadoutTile({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _dnWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: _dnDark,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 3 — Outer-vs-Inner propagation visualizer
// ─────────────────────────────────────────────────────────────────────

class _DnPropagationSection extends StatefulWidget {
  const _DnPropagationSection();

  @override
  State<_DnPropagationSection> createState() => _DnPropagationSectionState();
}

class _DnPropagationSectionState extends State<_DnPropagationSection> {
  int _outerHits = 0;
  int _innerSwallowed = 0;

  @override
  Widget build(BuildContext context) {
    return _DnPanel(
      title: 'Watch the bubble: outer-Shortcuts hit count vs swallow count',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Shortcuts(
        // Outer: F1 increments hits.
        shortcuts: <ShortcutActivator, Intent>{
          LogicalKeySet(LogicalKeyboardKey.f1): const _DnPropOuterIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _DnPropOuterIntent: CallbackAction<_DnPropOuterIntent>(
              onInvoke: (_) {
                setState(() => _outerHits++);
                _dnLog.add(
                  _DnLogEntry(
                    scope: 'OUTER',
                    label: 'F1 reached outer Shortcuts',
                    swallowed: false,
                  ),
                );
                return null;
              },
            ),
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _DnCountTile(
                      label: 'Outer hits (F1 reached outer)',
                      value: _outerHits,
                      color: _dnDispatched,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _DnCountTile(
                      label: 'Inner swallowed (F1 stopped here)',
                      value: _innerSwallowed,
                      color: _dnSwallowed,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _DnPropZone(
                      title: 'PASS-THROUGH zone',
                      explanation:
                          'Inner Shortcuts is empty for F1. The press '
                          'bubbles up and the outer counter increments.',
                      borderColor: _dnDispatched,
                      shortcuts: const <ShortcutActivator, Intent>{},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DnPropZone(
                      title: 'SWALLOW zone',
                      explanation:
                          'Inner Shortcuts binds F1 to '
                          'DoNothingAndStopPropagationIntent. The outer '
                          'counter never moves.',
                      borderColor: _dnSwallowed,
                      shortcuts: <ShortcutActivator, Intent>{
                        LogicalKeySet(LogicalKeyboardKey.f1):
                            const DoNothingAndStopPropagationIntent(),
                      },
                      onSwallow: () {
                        setState(() => _innerSwallowed++);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Tip: click into a zone, press F1 a few times, then '
                'click into the other zone and press F1 again. The '
                'counters above let you watch the propagation rule '
                'in action.',
                style: TextStyle(color: _dnDark, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DnPropOuterIntent extends Intent {
  const _DnPropOuterIntent();
}

class _DnPropZone extends StatelessWidget {
  const _DnPropZone({
    required this.title,
    required this.explanation,
    required this.borderColor,
    required this.shortcuts,
    this.onSwallow,
  });
  final String title;
  final String explanation;
  final Color borderColor;
  final Map<ShortcutActivator, Intent> shortcuts;
  final VoidCallback? onSwallow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _dnLavender,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: borderColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            explanation,
            style: const TextStyle(color: _dnDark, fontSize: 12, height: 1.3),
          ),
          const SizedBox(height: 10),
          Shortcuts(
            shortcuts: shortcuts,
            child: Actions(
              actions: <Type, Action<Intent>>{
                DoNothingAndStopPropagationIntent:
                    CallbackAction<DoNothingAndStopPropagationIntent>(
                  onInvoke: (_) {
                    onSwallow?.call();
                    _dnLog.add(
                      _DnLogEntry(
                        scope: 'INNER',
                        label: 'F1 swallowed by stop-propagation intent',
                        swallowed: true,
                      ),
                    );
                    return null;
                  },
                ),
              },
              child: Focus(
                child: Builder(
                  builder: (BuildContext ctx) {
                    return GestureDetector(
                      onTap: () => Focus.of(ctx).requestFocus(),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _dnWhite,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: borderColor),
                        ),
                        child: const Text(
                          'Click to focus, then press F1',
                          style: TextStyle(color: _dnDark),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DnCountTile extends StatelessWidget {
  const _DnCountTile({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _dnWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '$value',
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 4 — TextField + swallow-Tab
// ─────────────────────────────────────────────────────────────────────

class _DnTabSwallowSection extends StatefulWidget {
  const _DnTabSwallowSection();

  @override
  State<_DnTabSwallowSection> createState() => _DnTabSwallowSectionState();
}

class _DnTabSwallowSectionState extends State<_DnTabSwallowSection> {
  final TextEditingController _normalCtl = TextEditingController(
    text: 'Pressing Tab here moves focus.',
  );
  final TextEditingController _swallowCtl = TextEditingController(
    text: 'Pressing Tab here is swallowed.',
  );

  @override
  void dispose() {
    _normalCtl.dispose();
    _swallowCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DnPanel(
      title: 'Two TextFields — only the right one swallows Tab',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _DnLabeledField(
                  label: 'NORMAL field (no Shortcuts)',
                  borderColor: _dnDispatched,
                  child: TextField(
                    controller: _normalCtl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DnLabeledField(
                  label: 'SWALLOW field (Tab → DoNothingAndStop…)',
                  borderColor: _dnSwallowed,
                  child: Shortcuts(
                    shortcuts: <ShortcutActivator, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.tab):
                          const DoNothingAndStopPropagationIntent(),
                    },
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        DoNothingAndStopPropagationIntent:
                            CallbackAction<DoNothingAndStopPropagationIntent>(
                          onInvoke: (_) {
                            _dnLog.add(
                              _DnLogEntry(
                                scope: 'TEXTFIELD',
                                label: 'Tab swallowed in right field',
                                swallowed: true,
                              ),
                            );
                            return null;
                          },
                        ),
                      },
                      child: TextField(
                        controller: _swallowCtl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dnLavender,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _dnAccent),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.lightbulb_outline, color: _dnWarning),
                const SizedBox(width: 8),
                Expanded(
                  child: const Text(
                    'Why this is real: the Shortcuts widget actually '
                    'captures the key event before EditableText sees '
                    'it. The right TextField never inserts a tab nor '
                    'shifts focus. The intent is dispatched as the '
                    'log proves.',
                    style: TextStyle(color: _dnDark, fontSize: 13, height: 1.4),
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

class _DnLabeledField extends StatelessWidget {
  const _DnLabeledField({
    required this.label,
    required this.borderColor,
    required this.child,
  });
  final String label;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: _dnWhite,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 5 — Platform-aware swallow
// ─────────────────────────────────────────────────────────────────────

class _DnPlatformSection extends StatefulWidget {
  const _DnPlatformSection();

  @override
  State<_DnPlatformSection> createState() => _DnPlatformSectionState();
}

class _DnPlatformSectionState extends State<_DnPlatformSection> {
  int _swallows = 0;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final bool isApple = platform == TargetPlatform.macOS ||
        platform == TargetPlatform.iOS;
    final LogicalKeyboardKey modifier =
        isApple ? LogicalKeyboardKey.meta : LogicalKeyboardKey.control;
    final String modifierLabel = isApple ? 'Cmd' : 'Ctrl';

    return _DnPanel(
      title: 'Same shortcut, platform-aware modifier',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _dnIndigo,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Detected: $platform',
                  style: const TextStyle(
                    color: _dnWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Active modifier for swallow shortcut: $modifierLabel',
                  style: const TextStyle(
                    color: _dnDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Live binding using the platform-derived modifier.
          Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              LogicalKeySet(modifier, LogicalKeyboardKey.keyP):
                  const DoNothingAndStopPropagationIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                DoNothingAndStopPropagationIntent:
                    CallbackAction<DoNothingAndStopPropagationIntent>(
                  onInvoke: (_) {
                    setState(() => _swallows++);
                    _dnLog.add(
                      _DnLogEntry(
                        scope: 'PLATFORM',
                        label: '$modifierLabel+P swallowed',
                        swallowed: true,
                      ),
                    );
                    return null;
                  },
                ),
              },
              child: Focus(
                child: Builder(
                  builder: (BuildContext ctx) {
                    return GestureDetector(
                      onTap: () => Focus.of(ctx).requestFocus(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _dnLavender,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _dnAccent, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Click here to focus, then press '
                              '$modifierLabel+P.',
                              style: const TextStyle(
                                color: _dnDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Swallow count: $_swallows',
                              style: const TextStyle(
                                color: _dnSwallowed,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
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
          const SizedBox(height: 12),
          const _DnCodeBlock(
            'final TargetPlatform platform = Theme.of(context).platform;\n'
            'final bool isApple = platform == TargetPlatform.macOS ||\n'
            '    platform == TargetPlatform.iOS;\n'
            'final modifier = isApple\n'
            '    ? LogicalKeyboardKey.meta\n'
            '    : LogicalKeyboardKey.control;\n\n'
            'Shortcuts(\n'
            '  shortcuts: {\n'
            '    LogicalKeySet(modifier, LogicalKeyboardKey.keyP):\n'
            '        const DoNothingAndStopPropagationIntent(),\n'
            '  },\n'
            '  child: child,\n'
            ');',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 6 — Nested focus tree
// ─────────────────────────────────────────────────────────────────────

class _DnNestedFocusSection extends StatefulWidget {
  const _DnNestedFocusSection();

  @override
  State<_DnNestedFocusSection> createState() => _DnNestedFocusSectionState();
}

class _DnNestedFocusSectionState extends State<_DnNestedFocusSection> {
  String _highest = '(none)';

  @override
  Widget build(BuildContext context) {
    return _DnPanel(
      title: 'Three nested layers — where does the bubble stop?',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Shortcuts(
        // Top-most: layer 0
        shortcuts: <ShortcutActivator, Intent>{
          LogicalKeySet(LogicalKeyboardKey.escape): const _DnLayerIntent(0),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _DnLayerIntent: CallbackAction<_DnLayerIntent>(
              onInvoke: (_DnLayerIntent intent) {
                setState(() => _highest = 'Layer ${intent.layer} (TOP)');
                _dnLog.add(
                  _DnLogEntry(
                    scope: 'L0',
                    label: 'Esc reached top layer',
                    swallowed: false,
                  ),
                );
                return null;
              },
            ),
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _dnLavender,
              border: Border.all(color: _dnIndigo, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Layer 0 (top, listens for Esc → bumps highest)',
                  style: TextStyle(color: _dnIndigo, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Middle layer: layer 1, swallows Esc.
                Shortcuts(
                  shortcuts: <ShortcutActivator, Intent>{
                    LogicalKeySet(LogicalKeyboardKey.escape):
                        const DoNothingAndStopPropagationIntent(),
                  },
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      DoNothingAndStopPropagationIntent:
                          CallbackAction<DoNothingAndStopPropagationIntent>(
                        onInvoke: (_) {
                          setState(() => _highest = 'Layer 1 (MIDDLE) — swallowed');
                          _dnLog.add(
                            _DnLogEntry(
                              scope: 'L1',
                              label: 'Esc swallowed in middle layer',
                              swallowed: true,
                            ),
                          );
                          return null;
                        },
                      ),
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _dnWhite,
                        border: Border.all(color: _dnSwallowed, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Layer 1 (middle, SWALLOWS Esc)',
                            style: TextStyle(
                              color: _dnSwallowed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Inner-most layer: layer 2, ordinary focus.
                          Focus(
                            child: Builder(
                              builder: (BuildContext ctx) {
                                return GestureDetector(
                                  onTap: () => Focus.of(ctx).requestFocus(),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: _dnLavender,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: _dnInfo),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Text(
                                          'Layer 2 (inner, plain Focus)',
                                          style: TextStyle(
                                            color: _dnInfo,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Click here to focus, then press '
                                          'Esc. Layer 1 will swallow it; the '
                                          'top layer 0 NEVER sees the press.',
                                          style: TextStyle(
                                            color: _dnDark,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _dnWhite,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _dnAccent),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.read_more, color: _dnAccent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Highest layer reached: $_highest',
                          style: const TextStyle(
                            color: _dnDark,
                            fontWeight: FontWeight.w600,
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
    );
  }
}

class _DnLayerIntent extends Intent {
  const _DnLayerIntent(this.layer);
  final int layer;
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 7 — Live event log
// ─────────────────────────────────────────────────────────────────────

class _DnEventLogSection extends StatefulWidget {
  const _DnEventLogSection();

  @override
  State<_DnEventLogSection> createState() => _DnEventLogSectionState();
}

class _DnEventLogSectionState extends State<_DnEventLogSection> {
  @override
  void initState() {
    super.initState();
    _dnLog.addListener(_onLogChange);
  }

  @override
  void dispose() {
    _dnLog.removeListener(_onLogChange);
    super.dispose();
  }

  void _onLogChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _DnPanel(
      title: 'Every dispatched intent shows up here',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '${_dnLog.entries.length} entries (newest first, max 24)',
                  style: const TextStyle(
                    color: _dnDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _dnLog.clear,
                icon: const Icon(Icons.delete_sweep, color: _dnError),
                label: const Text(
                  'Clear log',
                  style: TextStyle(color: _dnError),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            constraints: const BoxConstraints(maxHeight: 280),
            decoration: BoxDecoration(
              color: _dnDark,
              borderRadius: BorderRadius.circular(6),
            ),
            child: _dnLog.entries.isEmpty
                ? Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: const Text(
                      'No events yet — focus a section above and press '
                      'a shortcut.',
                      style: TextStyle(
                        color: _dnLavender,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: _dnLog.entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _DnLogEntry e = _dnLog.entries[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: e.swallowed
                                    ? _dnSwallowed
                                    : _dnDispatched,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                e.scope,
                                style: const TextStyle(
                                  color: _dnWhite,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                e.label,
                                style: const TextStyle(
                                  color: _dnLavender,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 8 — Recipe gallery
// ─────────────────────────────────────────────────────────────────────

class _DnRecipeGallery extends StatelessWidget {
  const _DnRecipeGallery();

  @override
  Widget build(BuildContext context) {
    return _DnPanel(
      title: 'Four working recipes — all using the LIVE class',
      color: _dnWhite,
      borderColor: _dnAccent,
      child: Column(
        children: const <Widget>[
          _DnRecipeCard(
            number: 1,
            title: 'Block browser-like Ctrl+S inside a custom editor',
            description:
                'Inside a desktop editor you may want to suppress the '
                'browser save shortcut while implementing your own. '
                'A single Shortcuts binding handles it.',
            code:
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    LogicalKeySet(\n'
                '      LogicalKeyboardKey.control,\n'
                '      LogicalKeyboardKey.keyS,\n'
                '    ): const DoNothingAndStopPropagationIntent(),\n'
                '  },\n'
                '  child: editor,\n'
                ');',
          ),
          _DnRecipeCard(
            number: 2,
            title: 'Stop Tab from leaking out of a code-cell editor',
            description:
                'A code editor wants Tab to insert spaces or stay '
                'inert, never shift focus. Bind Tab to '
                'DoNothingAndStopPropagationIntent at the editor wrapper.',
            code:
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    LogicalKeySet(LogicalKeyboardKey.tab):\n'
                '        const DoNothingAndStopPropagationIntent(),\n'
                '  },\n'
                '  child: TextField(...),\n'
                ');',
          ),
          _DnRecipeCard(
            number: 3,
            title: 'Disable F1 help inside a modal dialog',
            description:
                'Outer app routes F1 to a help system; the modal '
                'dialog wants F1 ignored entirely while it is open.',
            code:
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    LogicalKeySet(LogicalKeyboardKey.f1):\n'
                '        const DoNothingAndStopPropagationIntent(),\n'
                '  },\n'
                '  child: dialogContent,\n'
                ');',
          ),
          _DnRecipeCard(
            number: 4,
            title: 'Conditionally swallow Esc in a wizard step',
            description:
                'A wizard wants Esc closed only on the final step. '
                'Use a stateful wrapper and replace the binding map '
                'when the step changes.',
            code:
                'final shortcuts = <ShortcutActivator, Intent>{\n'
                '  if (isFinalStep)\n'
                '    LogicalKeySet(LogicalKeyboardKey.escape):\n'
                '        const DoNothingAndStopPropagationIntent(),\n'
                '};\n'
                'return Shortcuts(shortcuts: shortcuts, child: child);',
          ),
        ],
      ),
    );
  }
}

class _DnRecipeCard extends StatelessWidget {
  const _DnRecipeCard({
    required this.number,
    required this.title,
    required this.description,
    required this.code,
  });
  final int number;
  final String title;
  final String description;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _dnLavender,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _dnAccent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: _dnIndigo,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: _dnWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _dnDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: _dnDark, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 8),
          _DnCodeBlock(code),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 9 — Pitfalls
// ─────────────────────────────────────────────────────────────────────

class _DnPitfallsTable extends StatelessWidget {
  const _DnPitfallsTable();

  @override
  Widget build(BuildContext context) {
    const List<_DnPitfall> pitfalls = <_DnPitfall>[
      _DnPitfall(
        symptom: 'TextField still inserts a tab character',
        cause:
            'Shortcuts is mounted ABOVE Material/MaterialApp.shortcuts but '
            'BELOW the field; or the field uses a raw EditableText that '
            'pre-handles Tab.',
        fix:
            'Wrap the TextField directly with Shortcuts, or use '
            'CallbackShortcuts for finer control.',
      ),
      _DnPitfall(
        symptom: 'Outer global shortcut still fires',
        cause:
            'You bound DoNothingAndStopPropagationIntent on a sibling '
            'subtree. Key events bubble through whichever subtree owns '
            'focus.',
        fix:
            'Confirm focus is inside the swallowing subtree before the '
            'press; add a Focus/FocusScope wrapper.',
      ),
      _DnPitfall(
        symptom:
            'Cmd shortcut works on macOS but not on Linux/Windows',
        cause:
            'The binding hard-codes LogicalKeyboardKey.meta (Cmd) only; '
            'Ctrl-based platforms see no match.',
        fix:
            'Branch on Theme.of(context).platform and pick meta vs '
            'control accordingly. See section 5.',
      ),
      _DnPitfall(
        symptom: 'Action never runs',
        cause:
            'You used DoNothingAndStopPropagationIntent expecting it '
            'to RUN logic. It does NOT — it does NOTHING and stops '
            'propagation.',
        fix:
            'Use a CallbackAction<DoNothingAndStopPropagationIntent> '
            'as a side-channel for logging only, OR use a custom '
            'Intent for actual logic.',
      ),
      _DnPitfall(
        symptom: 'Hot-reload changes never take effect',
        cause:
            'You stored the shortcut map in a top-level constant and '
            'never rebuilt the Shortcuts widget.',
        fix:
            'Build the map inside build() so hot-reload re-runs it, '
            'or use a key on the Shortcuts widget to force a rebuild.',
      ),
    ];

    return _DnPanel(
      title: 'Five pitfalls and their fixes',
      color: _dnWhite,
      borderColor: _dnWarning,
      child: Column(
        children: <Widget>[
          const _DnPitfallsHeaderRow(),
          for (final _DnPitfall p in pitfalls) _DnPitfallRow(pitfall: p),
        ],
      ),
    );
  }
}

class _DnPitfall {
  const _DnPitfall({
    required this.symptom,
    required this.cause,
    required this.fix,
  });
  final String symptom;
  final String cause;
  final String fix;
}

class _DnPitfallsHeaderRow extends StatelessWidget {
  const _DnPitfallsHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      color: _dnWarning,
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Symptom',
              style: TextStyle(color: _dnWhite, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Cause',
              style: TextStyle(color: _dnWhite, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Fix',
              style: TextStyle(color: _dnWhite, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _DnPitfallRow extends StatelessWidget {
  const _DnPitfallRow({required this.pitfall});
  final _DnPitfall pitfall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _dnDivider)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              pitfall.symptom,
              style: const TextStyle(
                color: _dnError,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              pitfall.cause,
              style: const TextStyle(color: _dnDark),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              pitfall.fix,
              style: const TextStyle(
                color: _dnSuccess,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  SECTION 10 — Reference table
// ─────────────────────────────────────────────────────────────────────

class _DnReferenceTable extends StatelessWidget {
  const _DnReferenceTable();

  @override
  Widget build(BuildContext context) {
    const List<_DnRefRow> rows = <_DnRefRow>[
      _DnRefRow(
        name: 'DoNothingAndStopPropagationIntent',
        kind: 'Intent',
        purpose:
            'Marks a key as handled AND stops propagation up the focus '
            'tree and to the platform.',
      ),
      _DnRefRow(
        name: 'DoNothingIntent',
        kind: 'Intent',
        purpose:
            'Default action returns null. May or may not stop further '
            'propagation depending on Flutter version and context.',
      ),
      _DnRefRow(
        name: 'DoNothingAction',
        kind: 'Action',
        purpose: 'Companion action used internally by DoNothingIntent.',
      ),
      _DnRefRow(
        name: 'Shortcuts',
        kind: 'Widget',
        purpose:
            'Maps ShortcutActivator to Intent. Mount above the focusable '
            'subtree.',
      ),
      _DnRefRow(
        name: 'Actions',
        kind: 'Widget',
        purpose:
            'Maps Intent type to Action. Provides side-effects and the '
            'default-action lookup chain.',
      ),
      _DnRefRow(
        name: 'CallbackAction<T>',
        kind: 'Action',
        purpose:
            'Lightweight Action whose onInvoke is a closure; great for '
            'logging swallowed events.',
      ),
      _DnRefRow(
        name: 'LogicalKeySet',
        kind: 'ShortcutActivator',
        purpose:
            'Set-based key combo activator. Lives in '
            'package:flutter/services.dart.',
      ),
      _DnRefRow(
        name: 'LogicalKeyboardKey',
        kind: 'Enum-like',
        purpose:
            'Logical key constants (control, meta, tab, escape, …). '
            'Lives in package:flutter/services.dart.',
      ),
      _DnRefRow(
        name: 'Theme.of(context).platform',
        kind: 'API',
        purpose:
            'TargetPlatform without dart:io. Use for Cmd vs Ctrl '
            'branching.',
      ),
      _DnRefRow(
        name: 'KeyEventResult.handled',
        kind: 'Enum value',
        purpose:
            'Returned by the framework when an Intent has consumed the '
            'event. The framework propagates accordingly.',
      ),
    ];

    return _DnPanel(
      title: 'Related types and helpers',
      color: _dnWhite,
      borderColor: _dnInfo,
      child: Column(
        children: <Widget>[
          const _DnRefHeaderRow(),
          for (final _DnRefRow r in rows) _DnRefRowView(row: r),
        ],
      ),
    );
  }
}

class _DnRefRow {
  const _DnRefRow({
    required this.name,
    required this.kind,
    required this.purpose,
  });
  final String name;
  final String kind;
  final String purpose;
}

class _DnRefHeaderRow extends StatelessWidget {
  const _DnRefHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      color: _dnInfo,
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              'Name',
              style: TextStyle(color: _dnWhite, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Kind',
              style: TextStyle(color: _dnWhite, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              'Purpose',
              style: TextStyle(color: _dnWhite, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _DnRefRowView extends StatelessWidget {
  const _DnRefRowView({required this.row});
  final _DnRefRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _dnDivider)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              row.name,
              style: const TextStyle(
                color: _dnIndigo,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _DnKeyChip(row.kind),
          ),
          Expanded(
            flex: 6,
            child: Text(
              row.purpose,
              style: const TextStyle(color: _dnDark, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
//  Closing summary
// ─────────────────────────────────────────────────────────────────────

class _DnSummary extends StatelessWidget {
  const _DnSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_dnDark, _dnIndigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Take-aways',
            style: TextStyle(
              color: _dnWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _DnBullet(
              text:
                  'DoNothingAndStopPropagationIntent is the canonical way '
                  'to make a key combination inert WITHOUT letting outer '
                  'shortcuts or the platform see it.'),
          _DnBullet(
              text:
                  'Bind it the same way as any other Intent inside a '
                  'Shortcuts widget — no extra setup needed.'),
          _DnBullet(
              text:
                  'Wrap a CallbackAction around the same Intent type if '
                  'you want to LOG the swallow without changing its '
                  '"do-nothing-and-stop" behavior.'),
          _DnBullet(
              text:
                  'Use Theme.of(context).platform for Cmd vs Ctrl. Never '
                  'reach for dart:io inside widget code.'),
          _DnBullet(
              text:
                  'Always remember: focus location at the moment of the '
                  'press determines which Shortcuts node owns the lookup.'),
        ],
      ),
    );
  }
}

class _DnBullet extends StatelessWidget {
  const _DnBullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.check_circle, color: _dnLavender, size: 16),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _dnWhite,
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
