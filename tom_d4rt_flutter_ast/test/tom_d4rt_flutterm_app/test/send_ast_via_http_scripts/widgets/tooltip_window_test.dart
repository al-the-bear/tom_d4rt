// Deep visual demo for the Flutter framework class `TooltipWindow`.
//
// `TooltipWindow` is marked `@internal` inside
// `package:flutter/src/widgets/_window.dart` and is only usable when the
// experimental windowing API is enabled. Because this demo runs inside the
// d4rt AST harness (not a custom engine build), we cannot instantiate
// `TooltipWindow` directly. Instead, the file documents *what a tooltip
// window is* and lights up the behaviour it ultimately supports through the
// public `Tooltip` widget surface: trigger modes, positioning, richMessage,
// durations, semantics and feedback.
//
// This file is authored for the `tom_d4rt_flutterm` test corpus — it is
// consumed by the AST serialisation harness, not by `flutter_test`. The
// harness calls the top-level `build(BuildContext)` function and renders the
// resulting `MaterialApp`.
//
// No emojis anywhere. Forest-green / cream / charcoal palette throughout.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
//  Palette — a small, deliberate forest-green / cream / charcoal set. Every
//  visual element in the demo picks from here so the long scroll feels like
//  one document rather than a collection of scratch widgets.
// ---------------------------------------------------------------------------

class _TwObsPalette {
  const _TwObsPalette._();

  // Deep forest backgrounds.
  static const Color canvas = Color(0xFF0F1A14);
  static const Color canvasRaised = Color(0xFF16241C);
  static const Color canvasSunken = Color(0xFF0A120D);

  // Forest greens (primary accents).
  static const Color forestDeep = Color(0xFF1F3A2B);
  static const Color forestMid = Color(0xFF2E5E42);
  static const Color forestBright = Color(0xFF4C8C63);
  static const Color mossLight = Color(0xFF8DB892);

  // Cream (text + highlight).
  static const Color cream = Color(0xFFF2EAD3);
  static const Color creamSoft = Color(0xFFE3D9BE);
  static const Color creamMuted = Color(0xFFB8AF94);

  // Charcoal (bodies + borders).
  static const Color charcoalInk = Color(0xFF1B1F1C);
  static const Color charcoalLine = Color(0xFF2A312B);
  static const Color charcoalSoft = Color(0xFF3A413B);

  // Accents for status / highlights.
  static const Color amber = Color(0xFFE6B566);
  static const Color rust = Color(0xFFBC5A3A);
  static const Color sage = Color(0xFFA6C9A4);
}

// ---------------------------------------------------------------------------
//  build() — the d4rt harness entry point. Produces a single `MaterialApp`
//  whose home is `_TwObsRoot`. Nothing else runs at top level.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TooltipWindow Observatory',
    theme: _buildObservatoryTheme(),
    home: const _TwObsRoot(),
  );
}

ThemeData _buildObservatoryTheme() {
  final ThemeData base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: _TwObsPalette.canvas,
    colorScheme: base.colorScheme.copyWith(
      primary: _TwObsPalette.forestBright,
      onPrimary: _TwObsPalette.cream,
      secondary: _TwObsPalette.amber,
      onSecondary: _TwObsPalette.charcoalInk,
      surface: _TwObsPalette.canvasRaised,
      onSurface: _TwObsPalette.cream,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: _TwObsPalette.cream,
      displayColor: _TwObsPalette.cream,
      fontFamilyFallback: const <String>['Roboto', 'sans-serif'],
    ),
    tooltipTheme: const TooltipThemeData(
      textStyle: TextStyle(
        color: _TwObsPalette.cream,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        color: Color(0xCC1F3A2B),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      waitDuration: Duration(milliseconds: 400),
      showDuration: Duration(milliseconds: 2200),
      preferBelow: true,
      verticalOffset: 22,
    ),
    dividerColor: _TwObsPalette.charcoalLine,
  );
}

// ---------------------------------------------------------------------------
//  _TwObsRoot — top-level Scaffold. It is stateful because the app bar
//  advertises a global "mute all tooltips" toggle that propagates into every
//  chapter through an inherited widget. This keeps chapters independent while
//  still reacting to a single master control.
// ---------------------------------------------------------------------------

class _TwObsRoot extends StatefulWidget {
  const _TwObsRoot();

  @override
  State<_TwObsRoot> createState() => _TwObsRootState();
}

class _TwObsRootState extends State<_TwObsRoot> {
  bool _globallyMuted = false;
  int _lastTriggerCount = 0;
  final GlobalKey _scrollKey = GlobalKey();
  final ScrollController _scroll = ScrollController();

  void _bumpTrigger() {
    setState(() => _lastTriggerCount += 1);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scroll.hasClients) {
      _scroll.animateTo(
        0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _TwObsGlobalState(
      muted: _globallyMuted,
      triggerCount: _lastTriggerCount,
      onTrigger: _bumpTrigger,
      child: Scaffold(
        backgroundColor: _TwObsPalette.canvas,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _scrollToTop,
          backgroundColor: _TwObsPalette.forestMid,
          foregroundColor: _TwObsPalette.cream,
          icon: const Icon(Icons.vertical_align_top_rounded),
          label: const Text('Back to top'),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _TwObsPalette.canvasSunken,
      foregroundColor: _TwObsPalette.cream,
      elevation: 0,
      title: const Text(
        'TooltipWindow Observatory',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Mute all tooltips',
                style: TextStyle(
                  color: _TwObsPalette.creamSoft,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              Switch(
                value: _globallyMuted,
                activeThumbColor: _TwObsPalette.amber,
                activeTrackColor: _TwObsPalette.forestDeep,
                inactiveThumbColor: _TwObsPalette.creamMuted,
                inactiveTrackColor: _TwObsPalette.charcoalSoft,
                onChanged: (bool v) => setState(() => _globallyMuted = v),
              ),
            ],
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(height: 2, color: _TwObsPalette.forestDeep),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scrollbar(
      controller: _scroll,
      child: SingleChildScrollView(
        key: _scrollKey,
        controller: _scroll,
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 96),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _TwObsPreambleChapter(),
            SizedBox(height: 28),
            _TwObsTriggerModeChapter(),
            SizedBox(height: 28),
            _TwObsPositioningStudio(),
            SizedBox(height: 28),
            _TwObsRichMessageChapter(),
            SizedBox(height: 28),
            _TwObsDurationLab(),
            SizedBox(height: 28),
            _TwObsSemanticsChapter(),
            SizedBox(height: 28),
            _TwObsThemePlayground(),
            SizedBox(height: 28),
            _TwObsMultiAnchorChapter(),
            SizedBox(height: 28),
            _TwObsDiagnosticsChapter(),
            SizedBox(height: 28),
            _TwObsEpilogueChapter(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  _TwObsGlobalState — InheritedWidget carrying the "mute all" flag plus a
//  trigger counter. Child chapters consult this to decide whether to render
//  real `Tooltip` widgets or inert placeholder captions.
// ---------------------------------------------------------------------------

class _TwObsGlobalState extends InheritedWidget {
  const _TwObsGlobalState({
    required this.muted,
    required this.triggerCount,
    required this.onTrigger,
    required super.child,
  });

  final bool muted;
  final int triggerCount;
  final VoidCallback onTrigger;

  static _TwObsGlobalState of(BuildContext context) {
    final _TwObsGlobalState? result =
        context.dependOnInheritedWidgetOfExactType<_TwObsGlobalState>();
    assert(result != null, '_TwObsGlobalState not found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_TwObsGlobalState old) =>
      muted != old.muted || triggerCount != old.triggerCount;
}

// ---------------------------------------------------------------------------
//  Shared visual primitives. These are used by every chapter so the whole
//  document feels typographically coherent.
// ---------------------------------------------------------------------------

class _TwObsChapterCard extends StatelessWidget {
  const _TwObsChapterCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.prose,
    required this.body,
    this.accent = _TwObsPalette.forestBright,
  });

  final int index;
  final String title;
  final String subtitle;
  final List<String> prose;
  final Widget body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _TwObsPalette.canvasRaised,
            Color.lerp(_TwObsPalette.canvasRaised, accent, 0.06)!,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _TwObsPalette.charcoalLine, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 22, 26, 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _TwObsChapterHeader(
              index: index,
              title: title,
              subtitle: subtitle,
              accent: accent,
            ),
            const SizedBox(height: 14),
            for (final String p in prose) ...<Widget>[
              Text(
                p,
                style: const TextStyle(
                  color: _TwObsPalette.creamSoft,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 10),
            Divider(color: _TwObsPalette.charcoalLine, height: 1),
            const SizedBox(height: 18),
            body,
          ],
        ),
      ),
    );
  }
}

class _TwObsChapterHeader extends StatelessWidget {
  const _TwObsChapterHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final String idx = index.toString().padLeft(2, '0');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _TwObsPalette.forestDeep,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent, width: 1.4),
          ),
          child: Text(
            idx,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 16,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _TwObsPalette.cream,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TwObsMiniCard extends StatelessWidget {
  const _TwObsMiniCard({
    required this.title,
    required this.child,
    this.footer,
    this.accent = _TwObsPalette.forestBright,
  });

  final String title;
  final Widget child;
  final String? footer;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _TwObsPalette.cream,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
          if (footer != null) ...<Widget>[
            const SizedBox(height: 10),
            Text(
              footer!,
              style: const TextStyle(
                color: _TwObsPalette.creamMuted,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TwObsKeyValueRow extends StatelessWidget {
  const _TwObsKeyValueRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
  bool get emphasise => false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: _TwObsPalette.creamMuted,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: emphasise ? _TwObsPalette.amber : _TwObsPalette.cream,
                fontSize: 12.5,
                fontWeight: emphasise ? FontWeight.w700 : FontWeight.w500,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TwObsBadge extends StatelessWidget {
  const _TwObsBadge({
    required this.label,
    this.color = _TwObsPalette.forestMid,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _colorForText(color),
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Color _colorForText(Color c) {
    // Light-ish badge text on forest backgrounds — cream offers the best
    // contrast without looking washed out on dark surfaces.
    return _TwObsPalette.cream;
  }
}

// ---------------------------------------------------------------------------
//  Chapter 1 — Preamble
// ---------------------------------------------------------------------------

class _TwObsPreambleChapter extends StatelessWidget {
  const _TwObsPreambleChapter();

  @override
  Widget build(BuildContext context) {
    return _TwObsChapterCard(
      index: 1,
      title: 'What is a TooltipWindow?',
      subtitle: 'A window-layer host for tooltip content',
      accent: _TwObsPalette.forestBright,
      prose: const <String>[
        'TooltipWindow is an @internal StatelessWidget inside '
            'package:flutter/src/widgets/_window.dart. Its job is to own a '
            'dedicated native window that carries a tooltip\'s rendered '
            'child, driven by a TooltipWindowController.',
        'Because it lives behind Flutter\'s experimental windowing API, most '
            'applications never construct one directly. They instead author '
            'Tooltip widgets whose positioning, fade, dismissal and '
            'accessibility ultimately flow through the tooltip-window layer '
            'when the platform supports it.',
        'This observatory therefore demonstrates the public surface of '
            'Tooltip — the knobs a developer actually turns — while noting '
            'which knobs map to which layer of the tooltip stack.',
      ],
      body: const _TwObsPreambleBody(),
    );
  }
}

class _TwObsPreambleBody extends StatelessWidget {
  const _TwObsPreambleBody();

  @override
  Widget build(BuildContext context) {
    final _TwObsGlobalState globals = _TwObsGlobalState.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const <Widget>[
            _TwObsBadge(label: '@internal'),
            _TwObsBadge(
                label: 'StatelessWidget', color: _TwObsPalette.forestBright),
            _TwObsBadge(label: 'window-layer', color: _TwObsPalette.amber),
            _TwObsBadge(label: 'experimental', color: _TwObsPalette.rust),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            final bool wide = c.maxWidth > 620;
            final List<Widget> cards = <Widget>[
              const _TwObsMiniCard(
                title: 'Controller',
                footer: 'Creates and destroys the backing window.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _TwObsKeyValueRow(
                      label: 'type',
                      value: 'TooltipWindowController',
                    ),
                    _TwObsKeyValueRow(
                      label: 'role',
                      value: 'lifecycle + geometry',
                    ),
                    _TwObsKeyValueRow(
                      label: 'delegate',
                      value: 'TooltipWindowControllerDelegate',
                    ),
                  ],
                ),
              ),
              const _TwObsMiniCard(
                title: 'Scope',
                footer: 'Inherited access for descendants.',
                accent: _TwObsPalette.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _TwObsKeyValueRow(
                      label: 'widget',
                      value: 'WindowScope',
                    ),
                    _TwObsKeyValueRow(
                      label: 'inherited',
                      value: 'BaseWindowController',
                    ),
                    _TwObsKeyValueRow(
                      label: 'aspects',
                      value: 'size · title · state',
                    ),
                  ],
                ),
              ),
              const _TwObsMiniCard(
                title: 'Public surrogate',
                footer:
                    'What you actually wire up in app code.',
                accent: _TwObsPalette.sage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _TwObsKeyValueRow(
                      label: 'widget',
                      value: 'Tooltip',
                    ),
                    _TwObsKeyValueRow(
                      label: 'theme',
                      value: 'TooltipTheme',
                    ),
                    _TwObsKeyValueRow(
                      label: 'trigger',
                      value: 'TooltipTriggerMode',
                    ),
                  ],
                ),
              ),
            ];
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < cards.length; i++) ...<Widget>[
                    Expanded(child: cards[i]),
                    if (i != cards.length - 1) const SizedBox(width: 12),
                  ],
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (int i = 0; i < cards.length; i++) ...<Widget>[
                  cards[i],
                  if (i != cards.length - 1) const SizedBox(height: 12),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        _TwObsPreambleDiagram(muted: globals.muted),
      ],
    );
  }
}

class _TwObsPreambleDiagram extends StatelessWidget {
  const _TwObsPreambleDiagram({required this.muted});
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Stack overview',
            style: TextStyle(
              color: _TwObsPalette.cream,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          _TwObsStackRow(
            label: 'Native OS window (TooltipWindowController)',
            color: _TwObsPalette.charcoalSoft,
          ),
          _TwObsStackRow(
            label: 'TooltipWindow → WindowScope → View',
            color: _TwObsPalette.forestDeep,
          ),
          _TwObsStackRow(
            label: 'Tooltip (public widget) + TooltipTheme',
            color: _TwObsPalette.forestMid,
          ),
          _TwObsStackRow(
            label: 'Your anchor widget (IconButton, Text, Card…)',
            color: _TwObsPalette.forestBright,
            highlight: !muted,
          ),
          const SizedBox(height: 10),
          Text(
            muted
                ? 'Global mute is on — tooltips throughout this demo are '
                    'disabled, so the anchor row is shown dimmed to reflect '
                    'the runtime state.'
                : 'Hover, long-press or focus the anchor row in later '
                    'chapters to see this stack in action.',
            style: const TextStyle(
              color: _TwObsPalette.creamMuted,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TwObsStackRow extends StatelessWidget {
  const _TwObsStackRow({
    required this.label,
    required this.color,
    this.highlight = false,
  });

  final String label;
  final Color color;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: highlight ? 0.9 : 0.55),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: highlight
                ? _TwObsPalette.amber
                : _TwObsPalette.charcoalSoft,
            width: highlight ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              highlight ? Icons.bolt_rounded : Icons.layers_rounded,
              size: 16,
              color: _TwObsPalette.cream.withValues(alpha: 0.9),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: _TwObsPalette.cream,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter 2 — Trigger-mode gallery
// ---------------------------------------------------------------------------

class _TwObsTriggerModeChapter extends StatefulWidget {
  const _TwObsTriggerModeChapter();

  @override
  State<_TwObsTriggerModeChapter> createState() =>
      _TwObsTriggerModeChapterState();
}

class _TwObsTriggerModeChapterState extends State<_TwObsTriggerModeChapter> {
  TooltipTriggerMode _lastTriggered = TooltipTriggerMode.longPress;
  int _manualShownCount = 0;
  final GlobalKey<TooltipState> _manualKey = GlobalKey<TooltipState>();

  void _markTriggered(TooltipTriggerMode mode) {
    setState(() => _lastTriggered = mode);
    _TwObsGlobalState.of(context).onTrigger();
  }

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    return _TwObsChapterCard(
      index: 2,
      title: 'Trigger-mode gallery',
      subtitle: 'longPress · tap · manual',
      accent: _TwObsPalette.amber,
      prose: const <String>[
        'TooltipTriggerMode decides which pointer gesture causes the tooltip '
            'window to display. The Material-default on touch is longPress; '
            'mouse hover always shows regardless of trigger mode.',
        'The three cards below each use a different mode. A live readout at '
            'the bottom records which mode fired last so you can see how the '
            'tooltip-window layer is activated in each case.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c) {
              final bool wide = c.maxWidth > 640;
              final List<Widget> cards = <Widget>[
                _buildTriggerCard(
                  title: 'longPress',
                  description:
                      'Press and hold the target. Default on touch surfaces; '
                      'mouse hover also shows it.',
                  mode: TooltipTriggerMode.longPress,
                  icon: Icons.touch_app_rounded,
                  muted: muted,
                ),
                _buildTriggerCard(
                  title: 'tap',
                  description:
                      'A single tap opens the tooltip. Useful for info '
                      'glyphs that double as affordances.',
                  mode: TooltipTriggerMode.tap,
                  icon: Icons.ads_click_rounded,
                  muted: muted,
                ),
                _buildTriggerCard(
                  title: 'manual',
                  description:
                      'Only opens when you call TooltipState.ensureTooltipVisible(). '
                      'Wire it to explicit UI.',
                  mode: TooltipTriggerMode.manual,
                  icon: Icons.pan_tool_alt_rounded,
                  muted: muted,
                ),
              ];
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < cards.length; i++) ...<Widget>[
                      Expanded(child: cards[i]),
                      if (i != cards.length - 1) const SizedBox(width: 12),
                    ],
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (int i = 0; i < cards.length; i++) ...<Widget>[
                    cards[i],
                    if (i != cards.length - 1) const SizedBox(height: 12),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          _buildManualShowRow(muted: muted),
          const SizedBox(height: 18),
          _buildReadout(),
        ],
      ),
    );
  }

  Widget _buildTriggerCard({
    required String title,
    required String description,
    required TooltipTriggerMode mode,
    required IconData icon,
    required bool muted,
  }) {
    final Widget anchor = Container(
      height: 96,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _TwObsPalette.forestDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.forestMid, width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 28, color: _TwObsPalette.amber),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: _TwObsPalette.cream,
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

    final Widget wrapped = muted
        ? anchor
        : Tooltip(
            message: 'Activated via $title',
            triggerMode: mode,
            key: mode == TooltipTriggerMode.manual ? _manualKey : null,
            onTriggered: () => _markTriggered(mode),
            waitDuration: const Duration(milliseconds: 250),
            showDuration: const Duration(seconds: 2),
            child: anchor,
          );

    return _TwObsMiniCard(
      title: 'TooltipTriggerMode.$title',
      accent: _TwObsPalette.amber,
      footer: description,
      child: wrapped,
    );
  }

  Widget _buildManualShowRow({required bool muted}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.settings_remote_rounded,
              color: _TwObsPalette.amber, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Programmatic reveal — manual trigger requires an explicit '
              'call to ensureTooltipVisible() on the TooltipState.',
              style: TextStyle(
                color: _TwObsPalette.creamSoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: muted
                ? null
                : () {
                    final bool? ok =
                        _manualKey.currentState?.ensureTooltipVisible();
                    if (ok ?? false) {
                      setState(() => _manualShownCount += 1);
                    }
                  },
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Show manual tooltip'),
            style: FilledButton.styleFrom(
              backgroundColor: _TwObsPalette.forestMid,
              foregroundColor: _TwObsPalette.cream,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadout() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _TwObsPalette.forestDeep.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.forestMid),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.analytics_rounded,
              color: _TwObsPalette.mossLight, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: _TwObsPalette.cream,
                  fontSize: 13,
                  height: 1.4,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Last trigger mode fired: '),
                  TextSpan(
                    text: _lastTriggered.name,
                    style: const TextStyle(
                      color: _TwObsPalette.amber,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const TextSpan(text: '  ·  manual shows: '),
                  TextSpan(
                    text: _manualShownCount.toString(),
                    style: const TextStyle(
                      color: _TwObsPalette.sage,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter 3 — Positioning studio
// ---------------------------------------------------------------------------

class _TwObsPositioningStudio extends StatefulWidget {
  const _TwObsPositioningStudio();

  @override
  State<_TwObsPositioningStudio> createState() =>
      _TwObsPositioningStudioState();
}

class _TwObsPositioningStudioState extends State<_TwObsPositioningStudio> {
  bool _preferBelow = true;
  double _verticalOffset = 24;
  double _margin = 10;
  double _padding = 12;
  Alignment _anchorAlignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    return _TwObsChapterCard(
      index: 3,
      title: 'Positioning studio',
      subtitle: 'preferBelow · verticalOffset · margin',
      accent: _TwObsPalette.sage,
      prose: const <String>[
        'The tooltip-window layer is responsible for placing content so it '
            'does not clip out of the screen. Tooltip exposes three knobs '
            'that steer this process: preferBelow, verticalOffset and '
            'margin.',
        'Adjust the sliders to see how the anchor in the stage responds. '
            'preferBelow only flips when the tooltip cannot fit in the '
            'preferred direction, so dragging the anchor near the top or '
            'bottom edge of the stage is a good way to see the fallback.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildControls(),
          const SizedBox(height: 18),
          _buildStage(muted: muted),
          const SizedBox(height: 12),
          _buildSummary(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.swap_vert_rounded,
                  color: _TwObsPalette.sage, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'preferBelow — hint the framework to place content below',
                  style: TextStyle(
                    color: _TwObsPalette.cream,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Switch(
                value: _preferBelow,
                activeThumbColor: _TwObsPalette.sage,
                activeTrackColor: _TwObsPalette.forestDeep,
                inactiveThumbColor: _TwObsPalette.creamMuted,
                inactiveTrackColor: _TwObsPalette.charcoalSoft,
                onChanged: (bool v) => setState(() => _preferBelow = v),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildSlider(
            label: 'verticalOffset',
            value: _verticalOffset,
            min: 0,
            max: 60,
            divisions: 12,
            onChanged: (double v) => setState(() => _verticalOffset = v),
          ),
          _buildSlider(
            label: 'margin',
            value: _margin,
            min: 0,
            max: 48,
            divisions: 12,
            onChanged: (double v) => setState(() => _margin = v),
          ),
          _buildSlider(
            label: 'padding',
            value: _padding,
            min: 0,
            max: 32,
            divisions: 8,
            onChanged: (double v) => setState(() => _padding = v),
          ),
          const SizedBox(height: 6),
          const Text(
            'Anchor alignment inside the stage',
            style: TextStyle(
              color: _TwObsPalette.cream,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Alignment>[
              Alignment.topLeft,
              Alignment.topCenter,
              Alignment.topRight,
              Alignment.centerLeft,
              Alignment.center,
              Alignment.centerRight,
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              Alignment.bottomRight,
            ].map((Alignment a) {
              final bool selected = a == _anchorAlignment;
              return OutlinedButton(
                onPressed: () => setState(() => _anchorAlignment = a),
                style: OutlinedButton.styleFrom(
                  backgroundColor: selected
                      ? _TwObsPalette.forestMid
                      : _TwObsPalette.canvasRaised,
                  foregroundColor: _TwObsPalette.cream,
                  side: BorderSide(
                    color: selected
                        ? _TwObsPalette.sage
                        : _TwObsPalette.charcoalSoft,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                ),
                child: Text(
                  _alignmentName(a),
                  style: const TextStyle(fontSize: 11),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: _TwObsPalette.creamSoft,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: _TwObsPalette.sage,
                inactiveTrackColor: _TwObsPalette.charcoalSoft,
                thumbColor: _TwObsPalette.amber,
                overlayColor:
                    _TwObsPalette.amber.withValues(alpha: 0.15),
                valueIndicatorColor: _TwObsPalette.forestDeep,
                valueIndicatorTextStyle:
                    const TextStyle(color: _TwObsPalette.cream),
              ),
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: value.toStringAsFixed(1),
                onChanged: onChanged,
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              value.toStringAsFixed(1),
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: _TwObsPalette.amber,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _alignmentName(Alignment a) {
    if (a == Alignment.topLeft) return 'top-left';
    if (a == Alignment.topCenter) return 'top';
    if (a == Alignment.topRight) return 'top-right';
    if (a == Alignment.centerLeft) return 'left';
    if (a == Alignment.center) return 'center';
    if (a == Alignment.centerRight) return 'right';
    if (a == Alignment.bottomLeft) return 'bottom-left';
    if (a == Alignment.bottomCenter) return 'bottom';
    if (a == Alignment.bottomRight) return 'bottom-right';
    return 'custom';
  }

  Widget _buildStage({required bool muted}) {
    final Widget anchor = Container(
      width: 110,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            _TwObsPalette.forestMid,
            _TwObsPalette.forestBright,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _TwObsPalette.forestDeep.withValues(alpha: 0.6),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        'Anchor',
        style: TextStyle(
          color: _TwObsPalette.cream,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );

    final Widget tooltipWrapped = muted
        ? anchor
        : Tooltip(
            message:
                'preferBelow=$_preferBelow · offset=${_verticalOffset.toStringAsFixed(0)} · margin=${_margin.toStringAsFixed(0)}',
            preferBelow: _preferBelow,
            verticalOffset: _verticalOffset,
            margin: EdgeInsets.all(_margin),
            padding: EdgeInsets.all(_padding),
            waitDuration: const Duration(milliseconds: 350),
            showDuration: const Duration(seconds: 3),
            child: anchor,
          );

    return Container(
      height: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _TwObsGridPainter(),
            ),
          ),
          Align(
            alignment: _anchorAlignment,
            child: tooltipWrapped,
          ),
          Positioned(
            left: 10,
            top: 10,
            child: _TwObsBadge(
              label: 'stage',
              color: _TwObsPalette.sage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Wrap(
        spacing: 14,
        runSpacing: 8,
        children: <Widget>[
          _TwObsBadge(
            label: 'preferBelow=$_preferBelow',
            color: _TwObsPalette.sage,
          ),
          _TwObsBadge(
            label: 'offset=${_verticalOffset.toStringAsFixed(0)}',
            color: _TwObsPalette.forestBright,
          ),
          _TwObsBadge(
            label: 'margin=${_margin.toStringAsFixed(0)}',
            color: _TwObsPalette.amber,
          ),
          _TwObsBadge(
            label: 'padding=${_padding.toStringAsFixed(0)}',
            color: _TwObsPalette.mossLight,
          ),
          _TwObsBadge(
            label: 'alignment=${_alignmentName(_anchorAlignment)}',
            color: _TwObsPalette.rust,
          ),
        ],
      ),
    );
  }
}

class _TwObsGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = _TwObsPalette.charcoalLine.withValues(alpha: 0.6)
      ..strokeWidth = 1;
    const double step = 20;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final Paint cross = Paint()
      ..color = _TwObsPalette.forestDeep
      ..strokeWidth = 1.4;
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      cross,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      cross,
    );
  }

  @override
  bool shouldRepaint(covariant _TwObsGridPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//  Chapter 4 — Rich message showcase
// ---------------------------------------------------------------------------

class _TwObsRichMessageChapter extends StatelessWidget {
  const _TwObsRichMessageChapter();

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    return _TwObsChapterCard(
      index: 4,
      title: 'Rich-message showcase',
      subtitle: 'richMessage · decoration · textStyle',
      accent: _TwObsPalette.amber,
      prose: const <String>[
        'Tooltip can carry either a plain message or an InlineSpan tree via '
            'richMessage. The rich form lets you mix styles, inline icons '
            'and WidgetSpan content — all still rendered inside the tooltip '
            'window layer.',
        'Hover or long-press any of the cards below. Each demonstrates a '
            'different rich-message recipe with a matching decoration.',
      ],
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints c) {
          final bool wide = c.maxWidth > 720;
          final List<Widget> items = <Widget>[
            _buildRichEntry(
              title: 'Inline icon + label',
              description:
                  'WidgetSpan hosts an icon next to styled text.',
              anchorLabel: 'Hover me',
              richMessage: const TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.bolt_rounded,
                      size: 16,
                      color: _TwObsPalette.amber,
                    ),
                  ),
                  TextSpan(text: '  Fast shortcut — '),
                  TextSpan(
                    text: 'Ctrl+K',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: _TwObsPalette.amber,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: _TwObsPalette.forestDeep.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _TwObsPalette.amber),
              ),
              muted: muted,
            ),
            _buildRichEntry(
              title: 'Multi-line explanation',
              description: 'Titles, paragraph text and a code hint.',
              anchorLabel: 'Explain',
              richMessage: const TextSpan(
                style: TextStyle(
                  color: _TwObsPalette.cream,
                  fontSize: 13,
                  height: 1.4,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Save to library\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _TwObsPalette.sage,
                    ),
                  ),
                  TextSpan(
                      text: 'Keeps a local copy so it remains '
                          'searchable while offline. Paired with '),
                  TextSpan(
                    text: 'autoSync',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: _TwObsPalette.amber,
                    ),
                  ),
                  TextSpan(text: ' it also reconciles on reconnect.'),
                ],
              ),
              decoration: BoxDecoration(
                color: _TwObsPalette.charcoalInk.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _TwObsPalette.sage, width: 1.2),
              ),
              muted: muted,
            ),
            _buildRichEntry(
              title: 'Compact metric',
              description: 'Headline number with a caption row.',
              anchorLabel: 'Metric',
              richMessage: const TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: '42.7ms\n',
                    style: TextStyle(
                      color: _TwObsPalette.cream,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: 'P95 tooltip render latency',
                    style: TextStyle(
                      color: _TwObsPalette.creamMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[
                    _TwObsPalette.forestDeep,
                    _TwObsPalette.forestMid,
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              muted: muted,
            ),
            _buildRichEntry(
              title: 'Warning tone',
              description: 'Rust accent for destructive affordances.',
              anchorLabel: 'Danger',
              richMessage: const TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: _TwObsPalette.rust,
                    ),
                  ),
                  TextSpan(
                    text: '  This action is permanent',
                    style: TextStyle(
                      color: _TwObsPalette.cream,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: _TwObsPalette.canvasSunken,
                border: Border.all(color: _TwObsPalette.rust, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              muted: muted,
            ),
          ];
          if (wide) {
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.1,
              children: items,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < items.length; i++) ...<Widget>[
                items[i],
                if (i != items.length - 1) const SizedBox(height: 12),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildRichEntry({
    required String title,
    required String description,
    required String anchorLabel,
    required InlineSpan richMessage,
    required BoxDecoration decoration,
    required bool muted,
  }) {
    final Widget anchor = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _TwObsPalette.forestDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _TwObsPalette.forestMid),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.info_outline_rounded,
              color: _TwObsPalette.amber, size: 16),
          const SizedBox(width: 6),
          Text(
            anchorLabel,
            style: const TextStyle(
              color: _TwObsPalette.cream,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );

    final Widget wrapped = muted
        ? anchor
        : Tooltip(
            richMessage: richMessage,
            decoration: decoration,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            waitDuration: const Duration(milliseconds: 250),
            showDuration: const Duration(seconds: 3),
            preferBelow: true,
            child: anchor,
          );

    return _TwObsMiniCard(
      title: title,
      accent: _TwObsPalette.amber,
      footer: description,
      child: Align(
        alignment: Alignment.centerLeft,
        child: wrapped,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter 5 — Duration lab
// ---------------------------------------------------------------------------

class _TwObsDurationLab extends StatefulWidget {
  const _TwObsDurationLab();

  @override
  State<_TwObsDurationLab> createState() => _TwObsDurationLabState();
}

class _TwObsDurationLabState extends State<_TwObsDurationLab>
    with SingleTickerProviderStateMixin {
  double _waitMs = 400;
  double _showMs = 2200;
  double _exitMs = 100;
  Timer? _countdownTimer;
  DateTime? _shownAt;
  Duration _remaining = Duration.zero;
  bool _liveCountdown = false;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    final DateTime now = DateTime.now();
    _shownAt = now;
    _remaining = Duration(milliseconds: _showMs.round());
    setState(() => _liveCountdown = true);
    _countdownTimer = Timer.periodic(const Duration(milliseconds: 80), (
      Timer t,
    ) {
      final DateTime start = _shownAt!;
      final Duration elapsed = DateTime.now().difference(start);
      final Duration total = Duration(milliseconds: _showMs.round());
      if (elapsed >= total) {
        t.cancel();
        setState(() {
          _liveCountdown = false;
          _remaining = Duration.zero;
        });
        return;
      }
      setState(() => _remaining = total - elapsed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    return _TwObsChapterCard(
      index: 5,
      title: 'Duration lab',
      subtitle: 'waitDuration · showDuration · exitDuration',
      accent: _TwObsPalette.rust,
      prose: const <String>[
        'waitDuration is the hover delay before a tooltip opens. '
            'showDuration is the display time after the pointer leaves. '
            'exitDuration is the minimum time the tooltip stays visible '
            'once the pointer moves away.',
        'Use the sliders below, then hover the lab anchor to watch the '
            'live countdown next to it. The tooltip-window layer owns '
            'these timers so they remain independent of widget rebuilds.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildSlider('waitDuration (ms)', _waitMs, 0, 1500, 15,
              (double v) => setState(() => _waitMs = v)),
          _buildSlider('showDuration (ms)', _showMs, 500, 8000, 30,
              (double v) => setState(() => _showMs = v)),
          _buildSlider('exitDuration (ms)', _exitMs, 0, 1000, 10,
              (double v) => setState(() => _exitMs = v)),
          const SizedBox(height: 14),
          _buildAnchorRow(muted: muted),
          const SizedBox(height: 14),
          _buildCountdownBar(),
          const SizedBox(height: 14),
          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    int divisions,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: const TextStyle(
                color: _TwObsPalette.creamSoft,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: _TwObsPalette.rust,
                inactiveTrackColor: _TwObsPalette.charcoalSoft,
                thumbColor: _TwObsPalette.amber,
                overlayColor:
                    _TwObsPalette.rust.withValues(alpha: 0.18),
              ),
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: value.toStringAsFixed(0),
                onChanged: onChanged,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              value.toStringAsFixed(0),
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: _TwObsPalette.amber,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnchorRow({required bool muted}) {
    final Widget anchor = Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            _TwObsPalette.rust,
            _TwObsPalette.forestMid,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Icon(Icons.timer_outlined, color: _TwObsPalette.cream),
          SizedBox(width: 8),
          Text(
            'Hover the lab anchor',
            style: TextStyle(
              color: _TwObsPalette.cream,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );

    final Widget wrapped = muted
        ? anchor
        : Tooltip(
            message:
                'Open for ${_showMs.toStringAsFixed(0)} ms after you leave',
            waitDuration: Duration(milliseconds: _waitMs.round()),
            showDuration: Duration(milliseconds: _showMs.round()),
            exitDuration: Duration(milliseconds: _exitMs.round()),
            onTriggered: _startCountdown,
            child: anchor,
          );

    return Row(
      children: <Widget>[
        wrapped,
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _TwObsPalette.canvasSunken,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _TwObsPalette.charcoalLine),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  _liveCountdown
                      ? 'Remaining: ${(_remaining.inMilliseconds).clamp(0, 999999)} ms'
                      : 'Idle — trigger the tooltip to start the countdown.',
                  style: const TextStyle(
                    color: _TwObsPalette.cream,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  minHeight: 6,
                  value: _liveCountdown
                      ? (_remaining.inMilliseconds / _showMs).clamp(0, 1)
                      : 0,
                  backgroundColor: _TwObsPalette.charcoalSoft,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(_TwObsPalette.amber),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownBar() {
    final String humanWait = '${_waitMs.toStringAsFixed(0)}ms';
    final String humanShow = '${_showMs.toStringAsFixed(0)}ms';
    final String humanExit = '${_exitMs.toStringAsFixed(0)}ms';
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: <Widget>[
        _TwObsBadge(
            label: 'wait=$humanWait', color: _TwObsPalette.forestBright),
        _TwObsBadge(label: 'show=$humanShow', color: _TwObsPalette.amber),
        _TwObsBadge(label: 'exit=$humanExit', color: _TwObsPalette.rust),
      ],
    );
  }

  Widget _buildTimeline() {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: CustomPaint(
        painter: _TwObsTimelinePainter(
          wait: _waitMs,
          show: _showMs,
          exit: _exitMs,
        ),
      ),
    );
  }
}

class _TwObsTimelinePainter extends CustomPainter {
  _TwObsTimelinePainter({
    required this.wait,
    required this.show,
    required this.exit,
  });

  final double wait;
  final double show;
  final double exit;

  @override
  void paint(Canvas canvas, Size size) {
    final double total = wait + show + exit;
    if (total <= 0) {
      return;
    }
    final double w1 = size.width * (wait / total);
    final double w2 = size.width * (show / total);
    final double w3 = size.width * (exit / total);
    final double y = size.height / 2;
    final Paint base = Paint()..color = _TwObsPalette.charcoalSoft;
    canvas.drawRect(Rect.fromLTWH(0, y - 10, size.width, 20), base);

    final Paint waitPaint = Paint()..color = _TwObsPalette.forestBright;
    canvas.drawRect(Rect.fromLTWH(0, y - 10, w1, 20), waitPaint);

    final Paint showPaint = Paint()..color = _TwObsPalette.amber;
    canvas.drawRect(Rect.fromLTWH(w1, y - 10, w2, 20), showPaint);

    final Paint exitPaint = Paint()..color = _TwObsPalette.rust;
    canvas.drawRect(Rect.fromLTWH(w1 + w2, y - 10, w3, 20), exitPaint);

    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
    );
    void drawLabel(String text, double centerX, Color color) {
      tp.text = TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      );
      tp.layout();
      tp.paint(canvas, Offset(centerX - tp.width / 2, y + 14));
    }

    drawLabel('wait', w1 / 2, _TwObsPalette.forestBright);
    drawLabel('show', w1 + w2 / 2, _TwObsPalette.amber);
    drawLabel('exit', w1 + w2 + w3 / 2, _TwObsPalette.rust);
  }

  @override
  bool shouldRepaint(covariant _TwObsTimelinePainter old) =>
      old.wait != wait || old.show != show || old.exit != exit;
}

// ---------------------------------------------------------------------------
//  Chapter 6 — Semantics & feedback
// ---------------------------------------------------------------------------

class _TwObsSemanticsChapter extends StatefulWidget {
  const _TwObsSemanticsChapter();

  @override
  State<_TwObsSemanticsChapter> createState() => _TwObsSemanticsChapterState();
}

class _TwObsSemanticsChapterState extends State<_TwObsSemanticsChapter> {
  bool _excludeFromSemantics = false;
  bool _enableFeedback = true;
  bool _lastFeedbackFired = false;

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    return _TwObsChapterCard(
      index: 6,
      title: 'Semantics & feedback',
      subtitle: 'excludeFromSemantics · enableFeedback',
      accent: _TwObsPalette.mossLight,
      prose: const <String>[
        'Screen readers announce the tooltip message by default; '
            'excludeFromSemantics hides it. Haptic/audio feedback is '
            'controlled independently via enableFeedback.',
        'Toggle the switches and trigger the anchor to see the effective '
            'semantics label update. The feedback indicator lights up '
            'whenever the platform fires a long-press feedback event.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTogglesRow(),
          const SizedBox(height: 14),
          _buildAnchor(muted: muted),
          const SizedBox(height: 14),
          _buildReadout(),
        ],
      ),
    );
  }

  Widget _buildTogglesRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildToggleTile(
            title: 'excludeFromSemantics',
            description:
                'When true, the tooltip message is omitted from the '
                'a11y tree.',
            value: _excludeFromSemantics,
            onChanged: (bool v) =>
                setState(() => _excludeFromSemantics = v),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildToggleTile(
            title: 'enableFeedback',
            description:
                'Long-press haptic / audio feedback via the platform.',
            value: _enableFeedback,
            onChanged: (bool v) => setState(() => _enableFeedback = v),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _TwObsPalette.cream,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                ),
              ),
              Switch(
                value: value,
                activeThumbColor: _TwObsPalette.mossLight,
                activeTrackColor: _TwObsPalette.forestDeep,
                inactiveThumbColor: _TwObsPalette.creamMuted,
                inactiveTrackColor: _TwObsPalette.charcoalSoft,
                onChanged: onChanged,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: _TwObsPalette.creamMuted,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnchor({required bool muted}) {
    final Widget button = ElevatedButton.icon(
      onPressed: () {
        HapticFeedback.selectionClick();
        setState(() => _lastFeedbackFired = _enableFeedback);
      },
      icon: const Icon(Icons.accessibility_new_rounded),
      label: const Text('Semantics anchor'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _TwObsPalette.forestMid,
        foregroundColor: _TwObsPalette.cream,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );

    final Widget wrapped = muted
        ? button
        : Tooltip(
            message: 'Accessible label for this control',
            excludeFromSemantics: _excludeFromSemantics,
            enableFeedback: _enableFeedback,
            waitDuration: const Duration(milliseconds: 250),
            child: button,
          );

    return Row(
      children: <Widget>[
        wrapped,
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _TwObsPalette.canvasSunken,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _TwObsPalette.charcoalLine),
            ),
            child: Text(
              _excludeFromSemantics
                  ? 'Semantics label: (tooltip excluded) — only the anchor '
                      'advertises itself to screen readers.'
                  : 'Semantics label: "Accessible label for this control" — '
                      'both the anchor and the tooltip message participate.',
              style: const TextStyle(
                color: _TwObsPalette.cream,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadout() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _TwObsPalette.forestDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.forestMid),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            _lastFeedbackFired
                ? Icons.vibration_rounded
                : Icons.do_disturb_alt_rounded,
            color:
                _lastFeedbackFired ? _TwObsPalette.amber : _TwObsPalette.rust,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _lastFeedbackFired
                  ? 'Feedback fired on the last tap — enableFeedback=true.'
                  : 'No feedback on the last tap — either enableFeedback is '
                      'false or the anchor has not been tapped yet.',
              style: const TextStyle(
                color: _TwObsPalette.cream,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter 7 — Theme playground
// ---------------------------------------------------------------------------

class _TwObsThemePlayground extends StatefulWidget {
  const _TwObsThemePlayground();

  @override
  State<_TwObsThemePlayground> createState() => _TwObsThemePlaygroundState();
}

class _TwObsThemePlaygroundState extends State<_TwObsThemePlayground> {
  _TwObsThemeVariant _variant = _TwObsThemeVariant.forest;

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    return _TwObsChapterCard(
      index: 7,
      title: 'Theme playground',
      subtitle: 'TooltipTheme recipes',
      accent: _TwObsPalette.forestBright,
      prose: const <String>[
        'TooltipThemeData bundles defaults for every Tooltip in a subtree — '
            'decoration, padding, textStyle, durations and more. The tooltip '
            'window layer honours these without requiring per-widget config.',
        'Pick a variant below to override the ambient TooltipTheme for the '
            'anchor row. The selected variant is shown as JSON so you can '
            'see exactly which fields changed.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildVariantSelector(),
          const SizedBox(height: 14),
          _buildAnchorRow(muted: muted),
          const SizedBox(height: 14),
          _buildJsonPreview(),
        ],
      ),
    );
  }

  Widget _buildVariantSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _TwObsThemeVariant.values.map((_TwObsThemeVariant v) {
        final bool selected = v == _variant;
        return ChoiceChip(
          selected: selected,
          onSelected: (_) => setState(() => _variant = v),
          label: Text(v.display),
          labelStyle: TextStyle(
            color: selected
                ? _TwObsPalette.charcoalInk
                : _TwObsPalette.cream,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
          ),
          selectedColor: _TwObsPalette.amber,
          backgroundColor: _TwObsPalette.canvasSunken,
          side: BorderSide(
            color: selected
                ? _TwObsPalette.amber
                : _TwObsPalette.charcoalSoft,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnchorRow({required bool muted}) {
    final _TwObsThemeDescriptor desc = _descriptorFor(_variant);
    final List<String> labels = <String>[
      'Alpha',
      'Bravo',
      'Charlie',
      'Delta',
    ];
    return TooltipTheme(
      data: desc.themeData,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _TwObsPalette.canvasSunken,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _TwObsPalette.charcoalLine),
        ),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: labels.map((String label) {
            final Widget chip = Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _TwObsPalette.forestDeep,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: _TwObsPalette.forestMid),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: _TwObsPalette.cream,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
            );
            if (muted) {
              return chip;
            }
            return Tooltip(
              message: '${desc.display} tooltip on $label',
              child: chip,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildJsonPreview() {
    final _TwObsThemeDescriptor desc = _descriptorFor(_variant);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _TwObsPalette.charcoalInk,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Text(
        desc.jsonPreview,
        style: const TextStyle(
          color: _TwObsPalette.sage,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.45,
        ),
      ),
    );
  }

  _TwObsThemeDescriptor _descriptorFor(_TwObsThemeVariant v) {
    switch (v) {
      case _TwObsThemeVariant.forest:
        return const _TwObsThemeDescriptor(
          display: 'Forest',
          themeData: TooltipThemeData(
            decoration: BoxDecoration(
              color: Color(0xEE1F3A2B),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0xFF4C8C63)),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            textStyle: TextStyle(color: Color(0xFFF2EAD3), fontSize: 13),
            waitDuration: Duration(milliseconds: 300),
            showDuration: Duration(milliseconds: 1800),
            preferBelow: true,
          ),
          jsonPreview: '{\n'
              '  "variant": "forest",\n'
              '  "decoration.color": "#1F3A2B (alpha 0xEE)",\n'
              '  "decoration.border": "#4C8C63",\n'
              '  "padding": "12 x 8",\n'
              '  "textStyle.color": "#F2EAD3",\n'
              '  "waitDuration": "300ms",\n'
              '  "showDuration": "1800ms",\n'
              '  "preferBelow": true\n'
              '}',
        );
      case _TwObsThemeVariant.amber:
        return const _TwObsThemeDescriptor(
          display: 'Amber ribbon',
          themeData: TooltipThemeData(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFFE6B566), Color(0xFFBC5A3A)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            textStyle: TextStyle(
              color: Color(0xFF1B1F1C),
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
            waitDuration: Duration(milliseconds: 200),
            showDuration: Duration(milliseconds: 2400),
            preferBelow: false,
            verticalOffset: 18,
          ),
          jsonPreview: '{\n'
              '  "variant": "amber_ribbon",\n'
              '  "decoration": "gradient(#E6B566 -> #BC5A3A)",\n'
              '  "padding": "14 x 10",\n'
              '  "textStyle.weight": "w800",\n'
              '  "waitDuration": "200ms",\n'
              '  "showDuration": "2400ms",\n'
              '  "preferBelow": false,\n'
              '  "verticalOffset": 18\n'
              '}',
        );
      case _TwObsThemeVariant.terminal:
        return const _TwObsThemeDescriptor(
          display: 'Terminal',
          themeData: TooltipThemeData(
            decoration: BoxDecoration(
              color: Color(0xFF0A120D),
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0xFF8DB892)),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            textStyle: TextStyle(
              color: Color(0xFF8DB892),
              fontFamily: 'monospace',
              fontSize: 12,
            ),
            waitDuration: Duration(milliseconds: 120),
            showDuration: Duration(milliseconds: 4000),
            preferBelow: true,
          ),
          jsonPreview: '{\n'
              '  "variant": "terminal",\n'
              '  "decoration.color": "#0A120D",\n'
              '  "decoration.border": "#8DB892",\n'
              '  "padding": "10 x 6",\n'
              '  "textStyle.font": "monospace",\n'
              '  "waitDuration": "120ms",\n'
              '  "showDuration": "4000ms"\n'
              '}',
        );
      case _TwObsThemeVariant.parchment:
        return const _TwObsThemeDescriptor(
          display: 'Parchment',
          themeData: TooltipThemeData(
            decoration: BoxDecoration(
              color: Color(0xFFF2EAD3),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0xFFBC5A3A), width: 1.2),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            textStyle: TextStyle(
              color: Color(0xFF1B1F1C),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            waitDuration: Duration(milliseconds: 350),
            showDuration: Duration(milliseconds: 2200),
            preferBelow: true,
          ),
          jsonPreview: '{\n'
              '  "variant": "parchment",\n'
              '  "decoration.color": "#F2EAD3",\n'
              '  "decoration.border": "#BC5A3A (w=1.2)",\n'
              '  "boxShadow": "0x55000000 blur=8 dy=3",\n'
              '  "padding": "14 x 9",\n'
              '  "textStyle.color": "#1B1F1C",\n'
              '  "waitDuration": "350ms",\n'
              '  "showDuration": "2200ms"\n'
              '}',
        );
    }
  }
}

enum _TwObsThemeVariant {
  forest('Forest'),
  amber('Amber ribbon'),
  terminal('Terminal'),
  parchment('Parchment');

  const _TwObsThemeVariant(this.display);
  final String display;
}

class _TwObsThemeDescriptor {
  const _TwObsThemeDescriptor({
    required this.display,
    required this.themeData,
    required this.jsonPreview,
  });

  final String display;
  final TooltipThemeData themeData;
  final String jsonPreview;
}

// ---------------------------------------------------------------------------
//  Chapter 8 — Multi-anchor constellations
// ---------------------------------------------------------------------------

class _TwObsMultiAnchorChapter extends StatelessWidget {
  const _TwObsMultiAnchorChapter();

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    return _TwObsChapterCard(
      index: 8,
      title: 'Multi-anchor constellations',
      subtitle: 'dense UI, shared theme, distinct messages',
      accent: _TwObsPalette.sage,
      prose: const <String>[
        'Real applications usually host many tooltip anchors at once — '
            'toolbars, data grids, status bars. The tooltip window layer is '
            'responsible for ensuring at most one tooltip is visible at a '
            'time while still supporting fast hover-to-hover transitions.',
        'This chapter lays out three dense surfaces to exercise that path: a '
            'toolbar, a cell grid and a status bar. Hover between anchors '
            'quickly to see the transition behaviour.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildToolbar(muted: muted),
          const SizedBox(height: 14),
          _buildGrid(muted: muted),
          const SizedBox(height: 14),
          _buildStatusBar(muted: muted),
        ],
      ),
    );
  }

  Widget _buildToolbar({required bool muted}) {
    final List<_TwObsToolbarItem> items = <_TwObsToolbarItem>[
      _TwObsToolbarItem(
          icon: Icons.folder_open_rounded, label: 'Open', hint: 'Ctrl+O'),
      _TwObsToolbarItem(
          icon: Icons.save_rounded, label: 'Save', hint: 'Ctrl+S'),
      _TwObsToolbarItem(
          icon: Icons.undo_rounded, label: 'Undo', hint: 'Ctrl+Z'),
      _TwObsToolbarItem(
          icon: Icons.redo_rounded, label: 'Redo', hint: 'Ctrl+Shift+Z'),
      _TwObsToolbarItem(
          icon: Icons.search_rounded, label: 'Find', hint: 'Ctrl+F'),
      _TwObsToolbarItem(
          icon: Icons.settings_rounded,
          label: 'Settings',
          hint: 'Ctrl+,'),
      _TwObsToolbarItem(
          icon: Icons.help_outline_rounded, label: 'Help', hint: 'F1'),
    ];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Row(
        children: <Widget>[
          for (final _TwObsToolbarItem item in items)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _buildToolbarButton(item: item, muted: muted),
            ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton({
    required _TwObsToolbarItem item,
    required bool muted,
  }) {
    final Widget button = IconButton(
      onPressed: () {},
      icon: Icon(item.icon, color: _TwObsPalette.cream, size: 20),
      style: IconButton.styleFrom(
        backgroundColor: _TwObsPalette.forestDeep,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    if (muted) {
      return button;
    }
    return Tooltip(
      richMessage: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '${item.label}\n',
            style: const TextStyle(
              color: _TwObsPalette.cream,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          TextSpan(
            text: item.hint,
            style: const TextStyle(
              color: _TwObsPalette.amber,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ],
      ),
      waitDuration: const Duration(milliseconds: 180),
      showDuration: const Duration(milliseconds: 1500),
      child: button,
    );
  }

  Widget _buildGrid({required bool muted}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 110,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.6,
        ),
        itemCount: 18,
        itemBuilder: (BuildContext context, int index) {
          final double ratio = (index + 1) / 18;
          final int percent = (ratio * 100).round();
          final Widget cell = Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color.lerp(
                    _TwObsPalette.forestDeep,
                    _TwObsPalette.forestBright,
                    ratio,
                  )!,
                  _TwObsPalette.forestMid,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '$percent%',
              style: const TextStyle(
                color: _TwObsPalette.cream,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                fontFamily: 'monospace',
              ),
            ),
          );
          if (muted) {
            return cell;
          }
          return Tooltip(
            message: 'Cell ${index.toString().padLeft(2, '0')} · $percent%',
            waitDuration: const Duration(milliseconds: 150),
            showDuration: const Duration(milliseconds: 1400),
            child: cell,
          );
        },
      ),
    );
  }

  Widget _buildStatusBar({required bool muted}) {
    Widget statusChip({
      required IconData icon,
      required String label,
      required String tooltipText,
      required Color color,
    }) {
      final Widget chip = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: color.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: _TwObsPalette.cream,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
      if (muted) {
        return chip;
      }
      return Tooltip(
        message: tooltipText,
        waitDuration: const Duration(milliseconds: 200),
        showDuration: const Duration(milliseconds: 1600),
        child: chip,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          statusChip(
            icon: Icons.cloud_done_rounded,
            label: 'online',
            tooltipText: 'Connected to cluster · 18ms RTT',
            color: _TwObsPalette.forestBright,
          ),
          statusChip(
            icon: Icons.battery_full_rounded,
            label: '96%',
            tooltipText: 'Battery 96% · est. 4h 10m',
            color: _TwObsPalette.sage,
          ),
          statusChip(
            icon: Icons.wifi_rounded,
            label: 'wifi',
            tooltipText: 'SSID: tom-ops · signal -52dBm',
            color: _TwObsPalette.amber,
          ),
          statusChip(
            icon: Icons.memory_rounded,
            label: '1.2GB',
            tooltipText: 'Process RSS · peak 1.6GB',
            color: _TwObsPalette.mossLight,
          ),
          statusChip(
            icon: Icons.bug_report_rounded,
            label: '0 bugs',
            tooltipText: 'No open issues on current branch',
            color: _TwObsPalette.rust,
          ),
        ],
      ),
    );
  }
}

class _TwObsToolbarItem {
  const _TwObsToolbarItem({
    required this.icon,
    required this.label,
    required this.hint,
  });
  final IconData icon;
  final String label;
  final String hint;
}

// ---------------------------------------------------------------------------
//  Chapter 9 — Diagnostics & debug probe
// ---------------------------------------------------------------------------

class _TwObsDiagnosticsChapter extends StatefulWidget {
  const _TwObsDiagnosticsChapter();

  @override
  State<_TwObsDiagnosticsChapter> createState() =>
      _TwObsDiagnosticsChapterState();
}

class _TwObsDiagnosticsChapterState extends State<_TwObsDiagnosticsChapter> {
  final List<_TwObsLogEntry> _log = <_TwObsLogEntry>[
    _TwObsLogEntry(
      kind: _TwObsLogKind.info,
      message:
          'Diagnostics probe ready — trigger the probe anchor to record events.',
      at: DateTime.now(),
    ),
  ];

  void _append(_TwObsLogEntry entry) {
    setState(() {
      _log.insert(0, entry);
      if (_log.length > 30) {
        _log.removeRange(30, _log.length);
      }
    });
    debugPrint(
      '[TwObs] ${entry.at.toIso8601String()} ${entry.kind.name} ${entry.message}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool muted = _TwObsGlobalState.of(context).muted;
    final int triggerCount = _TwObsGlobalState.of(context).triggerCount;
    return _TwObsChapterCard(
      index: 9,
      title: 'Diagnostics & debug probe',
      subtitle: 'onTriggered · rolling log · metrics',
      accent: _TwObsPalette.amber,
      prose: const <String>[
        'Tooltip exposes an onTriggered callback that fires every time a '
            'tooltip transitions to the visible state. It is the cheapest '
            'seam for wiring telemetry, debounced analytics or QA '
            'instrumentation.',
        'The probe below writes to a bounded in-memory log and emits a '
            'debugPrint line for each event so you can correlate with the '
            'console. It also surfaces the app-wide trigger count carried '
            'by the global inherited state.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildMetricsRow(triggerCount: triggerCount),
          const SizedBox(height: 14),
          _buildProbeRow(muted: muted),
          const SizedBox(height: 14),
          _buildLogView(),
        ],
      ),
    );
  }

  Widget _buildMetricsRow({required int triggerCount}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildMetricTile(
            label: 'Global triggers',
            value: triggerCount.toString(),
            color: _TwObsPalette.forestBright,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricTile(
            label: 'Probe events',
            value: _log
                .where((_TwObsLogEntry e) => e.kind == _TwObsLogKind.event)
                .length
                .toString(),
            color: _TwObsPalette.amber,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricTile(
            label: 'Probe errors',
            value: _log
                .where((_TwObsLogEntry e) => e.kind == _TwObsLogKind.error)
                .length
                .toString(),
            color: _TwObsPalette.rust,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: _TwObsPalette.creamMuted,
              fontSize: 11.5,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProbeRow({required bool muted}) {
    final Widget probe = Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: _TwObsPalette.forestDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _TwObsPalette.amber),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Icon(Icons.sensors_rounded, color: _TwObsPalette.amber),
          SizedBox(width: 8),
          Text(
            'Probe anchor',
            style: TextStyle(
              color: _TwObsPalette.cream,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );

    final Widget wrapped = muted
        ? probe
        : Tooltip(
            message:
                'onTriggered will push an entry into the rolling log',
            waitDuration: const Duration(milliseconds: 250),
            showDuration: const Duration(milliseconds: 1800),
            onTriggered: () {
              _append(
                _TwObsLogEntry(
                  kind: _TwObsLogKind.event,
                  message: 'Tooltip shown on probe anchor',
                  at: DateTime.now(),
                ),
              );
            },
            child: probe,
          );

    return Row(
      children: <Widget>[
        wrapped,
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: () {
            _append(
              _TwObsLogEntry(
                kind: _TwObsLogKind.info,
                message: 'Manual info entry inserted',
                at: DateTime.now(),
              ),
            );
          },
          icon: const Icon(Icons.add_circle_outline_rounded),
          label: const Text('Insert info'),
          style: FilledButton.styleFrom(
            backgroundColor: _TwObsPalette.forestMid,
            foregroundColor: _TwObsPalette.cream,
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: () {
            _append(
              _TwObsLogEntry(
                kind: _TwObsLogKind.error,
                message: 'Synthetic error recorded',
                at: DateTime.now(),
              ),
            );
          },
          icon: const Icon(Icons.error_outline_rounded),
          label: const Text('Insert error'),
          style: OutlinedButton.styleFrom(
            foregroundColor: _TwObsPalette.rust,
            side: const BorderSide(color: _TwObsPalette.rust),
          ),
        ),
      ],
    );
  }

  Widget _buildLogView() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _TwObsPalette.charcoalInk,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: ListView.separated(
        itemCount: _log.length,
        separatorBuilder: (_, _) => const SizedBox(height: 6),
        itemBuilder: (BuildContext context, int index) {
          final _TwObsLogEntry e = _log[index];
          final Color accent;
          final IconData icon;
          switch (e.kind) {
            case _TwObsLogKind.info:
              accent = _TwObsPalette.sage;
              icon = Icons.info_outline_rounded;
              break;
            case _TwObsLogKind.event:
              accent = _TwObsPalette.amber;
              icon = Icons.bolt_rounded;
              break;
            case _TwObsLogKind.error:
              accent = _TwObsPalette.rust;
              icon = Icons.error_outline_rounded;
              break;
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: accent, size: 14),
              const SizedBox(width: 8),
              SizedBox(
                width: 86,
                child: Text(
                  _formatTs(e.at),
                  style: const TextStyle(
                    color: _TwObsPalette.creamMuted,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  e.message,
                  style: TextStyle(
                    color: _TwObsPalette.cream,
                    fontSize: 12.5,
                    fontWeight: e.kind == _TwObsLogKind.error
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatTs(DateTime t) {
    String two(int n) => n.toString().padLeft(2, '0');
    String three(int n) => n.toString().padLeft(3, '0');
    return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}.${three(t.millisecond)}';
  }
}

enum _TwObsLogKind { info, event, error }

class _TwObsLogEntry {
  _TwObsLogEntry({
    required this.kind,
    required this.message,
    required this.at,
  });

  final _TwObsLogKind kind;
  final String message;
  final DateTime at;
}

// ---------------------------------------------------------------------------
//  Chapter 10 — Epilogue
// ---------------------------------------------------------------------------

class _TwObsEpilogueChapter extends StatelessWidget {
  const _TwObsEpilogueChapter();

  @override
  Widget build(BuildContext context) {
    return _TwObsChapterCard(
      index: 10,
      title: 'Epilogue',
      subtitle: 'when to reach for a TooltipWindow',
      accent: _TwObsPalette.mossLight,
      prose: const <String>[
        'In an overwhelming majority of cases, Tooltip plus TooltipTheme is '
            'the right answer. Reach for the experimental TooltipWindow '
            'surface only when you genuinely need the tooltip to live in a '
            'separate native window — for example in multi-window desktop '
            'shells or plugin hosts that clip overlays aggressively.',
        'For everything else, the knobs surfaced in this observatory cover '
            'the design space: trigger mode, positioning, rich content, '
            'durations, semantics, feedback, theming and instrumentation.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildDecisionTable(),
          const SizedBox(height: 14),
          _buildChecklist(),
          const SizedBox(height: 14),
          _buildFootprint(),
        ],
      ),
    );
  }

  Widget _buildDecisionTable() {
    final List<List<String>> rows = <List<String>>[
      <String>['Single-window desktop', 'Tooltip + TooltipTheme'],
      <String>['Mobile app (hover + long-press)', 'Tooltip (default)'],
      <String>['Web (hover-first)', 'Tooltip (waitDuration 200-400ms)'],
      <String>['Plugin host with clipping', 'TooltipWindow (experimental)'],
      <String>['Multi-window IDE overlays', 'TooltipWindow (experimental)'],
      <String>['Highly custom chrome', 'OverlayPortal (not Tooltip)'],
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Decision matrix',
            style: TextStyle(
              color: _TwObsPalette.cream,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < rows.length; i++) ...<Widget>[
            _buildDecisionRow(rows[i], index: i),
            if (i != rows.length - 1)
              Divider(
                color: _TwObsPalette.charcoalLine,
                height: 12,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildDecisionRow(List<String> row, {required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 240,
            child: Text(
              row.first,
              style: const TextStyle(
                color: _TwObsPalette.creamSoft,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.last,
              style: const TextStyle(
                color: _TwObsPalette.amber,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklist() {
    final List<String> items = <String>[
      'Keep waitDuration short on desktop (200-400ms); longer on touch.',
      'Set preferBelow=false for status bars at the bottom of the window.',
      'Never wrap critical semantics labels inside excludeFromSemantics=true.',
      'Use richMessage for keyboard shortcut hints with monospace glyphs.',
      'Share defaults via TooltipTheme instead of per-call overrides.',
      'Instrument with onTriggered for QA rather than patching Tooltip.',
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _TwObsPalette.canvasSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _TwObsPalette.charcoalLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Checklist',
            style: TextStyle(
              color: _TwObsPalette.cream,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          for (final String it in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: _TwObsPalette.mossLight,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      it,
                      style: const TextStyle(
                        color: _TwObsPalette.cream,
                        fontSize: 12.5,
                        height: 1.45,
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

  Widget _buildFootprint() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            _TwObsPalette.forestDeep,
            _TwObsPalette.forestMid,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.park_rounded,
            color: _TwObsPalette.amber,
            size: 28,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'TooltipWindow is a small piece of the tooltip stack, but it '
              'is the piece that turns an overlay into a first-class window. '
              'Touch it only when you need that distinction — otherwise '
              'stay with Tooltip and let the framework do the right thing.',
              style: TextStyle(
                color: _TwObsPalette.cream,
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
