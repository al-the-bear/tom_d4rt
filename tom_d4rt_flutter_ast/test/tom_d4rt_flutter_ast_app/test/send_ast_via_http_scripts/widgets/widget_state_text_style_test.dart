// D4rt test script: Typographic Foundry — WidgetStateTextStyle Deep Demo
//
// SUBJECT
// -------
// `WidgetStateTextStyle` is declared in
// `package:flutter/src/widgets/widget_state.dart`:
//
//   abstract class WidgetStateTextStyle extends TextStyle
//       implements WidgetStateProperty<TextStyle> {
//     const WidgetStateTextStyle();
//     const factory WidgetStateTextStyle.resolveWith(
//       WidgetPropertyResolver<TextStyle> callback) = _WidgetStateTextStyle;
//     const factory WidgetStateTextStyle.fromMap(
//       WidgetStateMap<TextStyle> map) = _WidgetTextStyleMapper;
//     @override
//     TextStyle resolve(Set<WidgetState> states);
//   }
//
// The class extends `TextStyle`, so it may be assigned anywhere a plain
// `TextStyle` is expected. If the consumer understands `WidgetStateProperty`,
// it will call `resolve(states)` with the current interactive state set and
// use the returned `TextStyle`. Otherwise the inherited `TextStyle` fields
// (empty / defaults) come through.
//
// Two factory patterns:
//
//   • `WidgetStateTextStyle.resolveWith(cb)` — imperative resolver.
//   • `WidgetStateTextStyle.fromMap({...})` — declarative
//     `Map<WidgetStatesConstraint, TextStyle>`. The map is scanned in
//     insertion order; the first key satisfied by the state set wins.
//     End with `WidgetState.any` as a fallback.
//
// Deprecated predecessor: `MaterialStateTextStyle` (same contract,
// old Material 2 naming).
//
// Typical consumers:
//   • `ButtonStyle.textStyle`
//   • `ChipThemeData.labelStyle`
//   • `MenuButtonThemeData`
//   • `TextField`/`InputDecoration.labelStyle`
//
// HARNESS CONTRACT
// ----------------
// This script runs inside the d4rt AST harness: exactly one top-level
// `dynamic build(BuildContext context)` returning a `MaterialApp`.
// No `main()`, no `runApp()`, no top-level mutable state.
// `late` fields only inside `State.initState`, disposed in `dispose`.
//
// THEME — Typographic Foundry
// ---------------------------
// A Bauhaus-era letterpress foundry: lead-grey cast-iron chassis, ink-black
// background, warm paper inserts, cinnabar and saffron swatches. A
// CustomPainter backdrop draws composing-stick rails, a second painter
// draws specimen frames and roller bars. Every section riffs on the
// printing-press metaphor while keeping the programmatic model clearly
// visible.
//
//   ink         = #0E0B08  — deepest background ink
//   soot        = #1B1815  — body background
//   iron        = #2D2A27  — cast-iron chassis
//   ironLight   = #3E3A36  — chassis highlight
//   lead        = #5B5853  — lead type face
//   leadLight   = #7C7A75  — lead highlight / hairline
//   paper       = #F1E7CF  — warm cream paper insert
//   paperDeep   = #E1D3A8  — darker paper
//   paperGrime  = #B7A880  — aged page edge
//   cinnabar    = #C23A25  — red accent
//   saffron     = #E39A1C  — orange-yellow accent
//   moss        = #6B7F3A  — secondary accent
//   slate       = #3F4A55  — cool secondary accent
//   bone        = #F7EEDB  — brightest paper
//   ribbon      = #8B1A13  — deep red ribbon
//   rail        = #A5956A  — composing-stick rail

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants. The foundry theme is tuned: warm paper sits on cold
// iron, with two saturated accents (cinnabar + saffron) that each pick out
// a single structural role (errors / highlights).
// ---------------------------------------------------------------------------
const Color _kInk = Color(0xFF0E0B08);
const Color _kSoot = Color(0xFF1B1815);
const Color _kIron = Color(0xFF2D2A27);
const Color _kIronLight = Color(0xFF3E3A36);
const Color _kLead = Color(0xFF5B5853);
const Color _kLeadLight = Color(0xFF7C7A75);
const Color _kPaper = Color(0xFFF1E7CF);
const Color _kPaperDeep = Color(0xFFE1D3A8);
const Color _kPaperGrime = Color(0xFFB7A880);
const Color _kCinnabar = Color(0xFFC23A25);
const Color _kSaffron = Color(0xFFE39A1C);
const Color _kBone = Color(0xFFF7EEDB);
const Color _kRibbon = Color(0xFF8B1A13);
const Color _kRail = Color(0xFFA5956A);

// ---------------------------------------------------------------------------
// Entry point — the one function the d4rt AST harness calls.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('[Wsts] build() — WidgetStateTextStyle typographic foundry');
  return const _WstsApp();
}

// ---------------------------------------------------------------------------
// Root MaterialApp. The entire demo is a single scrolling page.
// ---------------------------------------------------------------------------
class _WstsApp extends StatelessWidget {
  const _WstsApp();

  @override
  Widget build(BuildContext context) {
    debugPrint('[Wsts] build MaterialApp');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Typographic Foundry — WidgetStateTextStyle',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _kSoot,
        colorScheme: const ColorScheme.dark(
          primary: _kSaffron,
          secondary: _kCinnabar,
          surface: _kIron,
          error: _kCinnabar,
          onPrimary: _kInk,
          onSecondary: _kBone,
          onSurface: _kPaper,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _kPaper, height: 1.4, fontSize: 14),
          bodySmall: TextStyle(
            color: _kPaperGrime,
            height: 1.35,
            fontSize: 12.5,
          ),
          titleLarge: TextStyle(
            color: _kSaffron,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
          titleMedium: TextStyle(
            color: _kBone,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
          titleSmall: TextStyle(
            color: _kPaperGrime,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
          labelLarge: TextStyle(
            color: _kBone,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: const CardThemeData(
          color: _kIron,
          surfaceTintColor: _kIron,
          elevation: 0,
        ),
        dividerColor: _kLead,
      ),
      home: const _WstsHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// _WstsHome — holds all demo-wide state: the live state chip toggles, the
// sweep animation controller, and the button-indicator pulse controllers.
// Every section below consumes slices of this single state bag.
// ---------------------------------------------------------------------------
class _WstsHome extends StatefulWidget {
  const _WstsHome();

  @override
  State<_WstsHome> createState() => _WstsHomeState();
}

class _WstsHomeState extends State<_WstsHome>
    with TickerProviderStateMixin {
  // --- live specimen state toggles -----------------------------------
  bool _hovered = false;
  bool _pressed = false;
  bool _focused = false;
  bool _selected = false;
  bool _disabled = false;
  bool _error = false;
  bool _dragged = false;

  // --- animation controllers -----------------------------------------
  late final AnimationController _sweepCtrl;
  late final AnimationController _pulseCtrl;
  late final AnimationController _rollerCtrl;

  // --- specimen text -------------------------------------------------
  static const String _kSpecimen = 'Hamburgefontsiv 1234 &?!';
  static const String _kPangram =
      'The quick brown fox jumps over the lazy dog';

  @override
  void initState() {
    super.initState();
    debugPrint('[Wsts] initState — controllers online');
    _sweepCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _rollerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    debugPrint('[Wsts] dispose — controllers parked');
    _sweepCtrl.dispose();
    _pulseCtrl.dispose();
    _rollerCtrl.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------
  // Build a `Set<WidgetState>` from the current toggle state so that the
  // same set can be passed to every WidgetStateTextStyle in the demo.
  // -------------------------------------------------------------------
  Set<WidgetState> get _liveStates {
    final Set<WidgetState> s = <WidgetState>{};
    if (_hovered) s.add(WidgetState.hovered);
    if (_pressed) s.add(WidgetState.pressed);
    if (_focused) s.add(WidgetState.focused);
    if (_selected) s.add(WidgetState.selected);
    if (_disabled) s.add(WidgetState.disabled);
    if (_error) s.add(WidgetState.error);
    if (_dragged) s.add(WidgetState.dragged);
    return s;
  }

  void _toggleHovered() => setState(() => _hovered = !_hovered);
  void _togglePressed() => setState(() => _pressed = !_pressed);
  void _toggleFocused() => setState(() => _focused = !_focused);
  void _toggleSelected() => setState(() => _selected = !_selected);
  void _toggleDisabled() => setState(() => _disabled = !_disabled);
  void _toggleError() => setState(() => _error = !_error);
  void _toggleDragged() => setState(() => _dragged = !_dragged);

  // -------------------------------------------------------------------
  // The canonical live WidgetStateTextStyle used in the specimen block.
  // Demonstrates a rich `resolveWith` body: fontSize scaling, weight,
  // color, letter-spacing, decoration.
  // -------------------------------------------------------------------
  WidgetStateTextStyle get liveStyle =>
      WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        double size = 42;
        FontWeight weight = FontWeight.w700;
        Color color = _kPaper;
        double spacing = 1.2;
        TextDecoration decoration = TextDecoration.none;
        FontStyle style = FontStyle.normal;
        String? family;

        if (states.contains(WidgetState.disabled)) {
          color = _kLeadLight;
          decoration = TextDecoration.lineThrough;
          weight = FontWeight.w400;
        } else if (states.contains(WidgetState.error)) {
          color = _kCinnabar;
          weight = FontWeight.w900;
          spacing = 1.8;
        } else if (states.contains(WidgetState.pressed)) {
          color = _kSaffron;
          weight = FontWeight.w900;
          size = 46;
          spacing = 2.0;
          family = 'monospace';
        } else if (states.contains(WidgetState.hovered)) {
          color = _kBone;
          style = FontStyle.italic;
          weight = FontWeight.w700;
          spacing = 1.6;
        } else if (states.contains(WidgetState.dragged)) {
          color = _kSaffron;
          size = 50;
        } else if (states.contains(WidgetState.focused)) {
          color = _kSaffron;
          weight = FontWeight.w800;
          decoration = TextDecoration.underline;
        } else if (states.contains(WidgetState.selected)) {
          color = _kBone;
          weight = FontWeight.w900;
          spacing = 4.0;
        }

        return TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
          letterSpacing: spacing,
          decoration: decoration,
          decorationColor: color,
          fontStyle: style,
          fontFamily: family,
          height: 1.1,
        );
      });

  // -------------------------------------------------------------------
  // Equivalent style built with the fromMap factory. Includes a
  // composite WidgetStatesConstraint (pressed & selected).
  // -------------------------------------------------------------------
  WidgetStateTextStyle get liveMapStyle =>
      WidgetStateTextStyle.fromMap(<WidgetStatesConstraint, TextStyle>{
        WidgetState.disabled: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w400,
          color: _kLeadLight,
          letterSpacing: 1.2,
          decoration: TextDecoration.lineThrough,
          height: 1.1,
        ),
        WidgetState.error: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w900,
          color: _kCinnabar,
          letterSpacing: 1.8,
          height: 1.1,
        ),
        WidgetState.pressed & WidgetState.selected: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: _kCinnabar,
          letterSpacing: 3.0,
          fontFamily: 'monospace',
          height: 1.1,
        ),
        WidgetState.pressed: const TextStyle(
          fontSize: 46,
          fontWeight: FontWeight.w900,
          color: _kSaffron,
          letterSpacing: 2.0,
          fontFamily: 'monospace',
          height: 1.1,
        ),
        WidgetState.hovered: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          color: _kBone,
          letterSpacing: 1.6,
          fontStyle: FontStyle.italic,
          height: 1.1,
        ),
        WidgetState.focused: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w800,
          color: _kSaffron,
          letterSpacing: 1.2,
          decoration: TextDecoration.underline,
          height: 1.1,
        ),
        WidgetState.selected: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w900,
          color: _kBone,
          letterSpacing: 4.0,
          height: 1.1,
        ),
        WidgetState.any: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          color: _kPaper,
          letterSpacing: 1.2,
          height: 1.1,
        ),
      });

  @override
  Widget build(BuildContext context) {
    final Set<WidgetState> states = _liveStates;
    final TextStyle resolved = liveStyle.resolve(states);
    return Scaffold(
      backgroundColor: _kSoot,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rollerCtrl,
              builder: (BuildContext ctx, Widget? child) {
                return CustomPaint(
                  painter: _WstsFoundryBackdropPainter(
                    progress: _rollerCtrl.value,
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              // Fa1 — C22 ListView replacement to avoid the
              // SingleChildScrollView + Column(stretch) infinite-height cascade.
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                children: <Widget>[
                  const _WstsMasthead(),
                    const SizedBox(height: 32),
                    const _WstsDossier(),
                    const SizedBox(height: 32),
                    const _WstsAnatomy(),
                    const SizedBox(height: 32),
                    _WstsLiveSpecimen(
                      states: states,
                      style: resolved,
                      hovered: _hovered,
                      pressed: _pressed,
                      focused: _focused,
                      selected: _selected,
                      disabled: _disabled,
                      error: _error,
                      dragged: _dragged,
                      onHovered: _toggleHovered,
                      onPressed: _togglePressed,
                      onFocused: _toggleFocused,
                      onSelected: _toggleSelected,
                      onDisabled: _toggleDisabled,
                      onError: _toggleError,
                      onDragged: _toggleDragged,
                    ),
                    const SizedBox(height: 32),
                    _WstsFactoryDuel(
                      resolveWithStyle: liveStyle,
                      mapStyle: liveMapStyle,
                      states: states,
                    ),
                    const SizedBox(height: 32),
                    _WstsButtonGallery(pulse: _pulseCtrl),
                    const SizedBox(height: 32),
                    const _WstsChipShowcase(),
                    const SizedBox(height: 32),
                    _WstsSweep(sweep: _sweepCtrl),
                    const SizedBox(height: 32),
                    const _WstsRecipes(),
                    const SizedBox(height: 32),
                    const _WstsComparison(),
                    const SizedBox(height: 32),
                    const _WstsGlossary(),
                    const SizedBox(height: 24),
                    const _WstsEpilogue(),
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
// Masthead — the top-of-page banner with a stamp-inked title, a running
// subtitle, and a hairline divider. Hand-drawn via CustomPaint so the ink
// smudges look like a real letterpress pull rather than a digital label.
// ---------------------------------------------------------------------------
class _WstsMasthead extends StatelessWidget {
  const _WstsMasthead();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: BoxDecoration(
        color: _kIron,
        border: Border.all(color: _kLead, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.55),
            blurRadius: 18,
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
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _kCinnabar,
                  border: Border.all(color: _kRibbon, width: 2),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'W',
                  style: TextStyle(
                    color: _kBone,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0,
                    height: 1,
                    fontFamily: 'serif',
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Typographic Foundry',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'A WidgetStateTextStyle deep demonstration — hand set.',
                      style: TextStyle(
                        color: _kPaperGrime,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _kSaffron,
                  border: Border.all(color: _kRibbon, width: 1.2),
                ),
                child: const Text(
                  'VOLUME I',
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: _kLead),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: const <Widget>[
              _WstsMetaChip(label: 'subject', value: 'WidgetStateTextStyle'),
              _WstsMetaChip(label: 'extends', value: 'TextStyle'),
              _WstsMetaChip(
                label: 'implements',
                value: 'WidgetStateProperty<TextStyle>',
              ),
              _WstsMetaChip(label: 'factories', value: 'resolveWith · fromMap'),
              _WstsMetaChip(label: 'sections', value: '10'),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small metadata chip — label + value. Used across the masthead and a few
// other headers.
// ---------------------------------------------------------------------------
class _WstsMetaChip extends StatelessWidget {
  const _WstsMetaChip({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: _kPaperGrime,
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: _kPaper,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// A section shell — number + title + kicker text + child content. Used by
// every major section so their chrome stays consistent.
// ---------------------------------------------------------------------------
class _WstsSection extends StatelessWidget {
  const _WstsSection({
    required this.number,
    required this.title,
    required this.kicker,
    required this.child,
  });

  final String number;
  final String title;
  final String kicker;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: _kIron,
        border: Border.all(color: _kLead, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _kSaffron,
                  border: Border.all(color: _kRibbon, width: 1.4),
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 1,
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
                        color: _kBone,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      kicker,
                      style: const TextStyle(
                        color: _kPaperGrime,
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: _kLead),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 — DOSSIER. Six cards describing the subject. Each card has an
// icon-like ornament, a title, and a paragraph. Laid out in a two-column
// wrap so long prose stays readable.
// ---------------------------------------------------------------------------
class _WstsDossier extends StatelessWidget {
  const _WstsDossier();

  static const List<_WstsDossierCard> _cards = <_WstsDossierCard>[
    _WstsDossierCard(
      ornament: '§1',
      title: 'What it is',
      body:
          'WidgetStateTextStyle is an abstract subclass of TextStyle that '
          'also implements WidgetStateProperty<TextStyle>. A single object '
          'serves two audiences: code that reads it as a plain TextStyle '
          'sees the default, while code that calls resolve(states) receives '
          'a state-specific style.',
    ),
    _WstsDossierCard(
      ornament: 'fn',
      title: 'resolveWith factory',
      body:
          'WidgetStateTextStyle.resolveWith(cb) wraps a callback of type '
          'WidgetPropertyResolver<TextStyle>, i.e. TextStyle Function('
          'Set<WidgetState>). Great for imperative logic with guard '
          'clauses, early exits, or computed fields derived from states.',
    ),
    _WstsDossierCard(
      ornament: '{..}',
      title: 'fromMap factory',
      body:
          'WidgetStateTextStyle.fromMap({...}) takes a '
          'WidgetStateMap<TextStyle> = Map<WidgetStatesConstraint, '
          'TextStyle>. Entries are scanned in insertion order; the first '
          'constraint satisfied by the state set wins. End with '
          'WidgetState.any as the fallback.',
    ),
    _WstsDossierCard(
      ornament: 'Aa',
      title: 'Plain TextStyle face',
      body:
          'Because the class extends TextStyle, any code path that just '
          'copies it with .copyWith(...) or merges it sees the empty '
          'default. Only WidgetStateProperty-aware consumers call resolve. '
          'This dual identity is the whole point of the subclass trick.',
    ),
    _WstsDossierCard(
      ornament: '→',
      title: 'First-match rule',
      body:
          'In fromMap, map order is significant. Put more-specific '
          'constraints (pressed & selected, disabled) before broader '
          'ones (hovered, focused) and finish with WidgetState.any. '
          'Composite constraints are built with &, |, and ~.',
    ),
    _WstsDossierCard(
      ornament: '×',
      title: 'Canonical consumers',
      body:
          'ButtonStyle.textStyle, ChipThemeData.labelStyle, '
          'MenuButtonThemeData, TabBarTheme.labelStyle, and '
          'InputDecoration.labelStyle all accept '
          'WidgetStateProperty<TextStyle>. Feed a WidgetStateTextStyle '
          'there and the widget will resolve it per-state for you.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '01',
      title: 'Dossier',
      kicker: 'Six briefs on the shape and intent of the class.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints bc) {
          final double w = bc.maxWidth;
          final int cols = w > 860 ? 3 : (w > 560 ? 2 : 1);
          final double gap = 14;
          final double tileW =
              (w - (cols - 1) * gap) / cols;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: <Widget>[
              for (final _WstsDossierCard c in _cards)
                SizedBox(width: tileW, child: c),
            ],
          );
        },
      ),
    );
  }
}

class _WstsDossierCard extends StatelessWidget {
  const _WstsDossierCard({
    required this.ornament,
    required this.title,
    required this.body,
  });
  final String ornament;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: _kPaper,
        border: Border.all(color: _kPaperGrime, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _kInk,
                  border: Border.all(color: _kCinnabar, width: 1.4),
                ),
                alignment: Alignment.center,
                child: Text(
                  ornament,
                  style: const TextStyle(
                    color: _kSaffron,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    height: 1,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF3A3326),
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 — ANATOMY. Monospace code block with the class declaration
// verbatim from the SDK plus a table mapping WidgetPropertyResolver
// argument pieces to their meaning.
// ---------------------------------------------------------------------------
class _WstsAnatomy extends StatelessWidget {
  const _WstsAnatomy();

  static const String _source =
      'abstract class WidgetStateTextStyle extends TextStyle\n'
      '    implements WidgetStateProperty<TextStyle> {\n'
      '  const WidgetStateTextStyle();\n'
      '\n'
      '  // Imperative factory — a callback resolves the style.\n'
      '  const factory WidgetStateTextStyle.resolveWith(\n'
      '    WidgetPropertyResolver<TextStyle> callback,\n'
      '  ) = _WidgetStateTextStyle;\n'
      '\n'
      '  // Declarative factory — a map resolves the style.\n'
      '  const factory WidgetStateTextStyle.fromMap(\n'
      '    WidgetStateMap<TextStyle> map,\n'
      '  ) = _WidgetTextStyleMapper;\n'
      '\n'
      '  @override\n'
      '  TextStyle resolve(Set<WidgetState> states);\n'
      '}\n'
      '\n'
      '// Supporting typedefs (approximate, from widget_state.dart):\n'
      '// typedef WidgetPropertyResolver<T> =\n'
      '//     T Function(Set<WidgetState> states);\n'
      '// typedef WidgetStateMap<T> = Map<WidgetStatesConstraint, T>;';

  static const List<List<String>> _argRows = <List<String>>[
    <String>[
      'states',
      'Set<WidgetState>',
      'The live interactive state set of the consumer. Empty set '
          'usually means "idle / default". Contains zero or more of: '
          'hovered, pressed, focused, selected, disabled, error, dragged, '
          'scrolledUnder.',
    ],
    <String>[
      'return',
      'TextStyle',
      'Must be non-null for the default (empty) state; for fromMap, the '
          'final WidgetState.any entry guarantees it. Returned style is '
          'applied to the consumer widget\'s text.',
    ],
    <String>[
      'contains(WidgetState.pressed)',
      'bool',
      'Typical guard used inside resolveWith callbacks to prioritise '
          'one state over another. The order of checks is the priority.',
    ],
    <String>[
      'WidgetState.pressed & WidgetState.selected',
      'WidgetStatesConstraint',
      'A composite constraint satisfied only if the state set contains '
          'BOTH members. Use it as a key in fromMap for two-state styles.',
    ],
    <String>[
      '~WidgetState.disabled',
      'WidgetStatesConstraint',
      'The negation of a constraint. Matches any state set that does '
          'NOT satisfy the base constraint.',
    ],
    <String>[
      'WidgetState.any',
      'WidgetStatesConstraint',
      'A sentinel that matches every possible state set. Put it last '
          'in a fromMap so it plays the role of the default branch.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '02',
      title: 'Anatomy',
      kicker: 'Class shape, typedefs, and argument reference.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kInk,
              border: Border.all(color: _kCinnabar, width: 1.2),
            ),
            child: const SelectableText(
              _source,
              style: TextStyle(
                color: _kBone,
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.5,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: _kPaper,
              border: Border.all(color: _kPaperGrime, width: 1),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: const BoxDecoration(
                    color: _kPaperDeep,
                    border: Border(
                      bottom: BorderSide(color: _kPaperGrime, width: 1),
                    ),
                  ),
                  child: const Row(
                    children: <Widget>[
                      SizedBox(
                        width: 190,
                        child: Text(
                          'TOKEN',
                          style: TextStyle(
                            color: _kInk,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Text(
                          'TYPE',
                          style: TextStyle(
                            color: _kInk,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'MEANING',
                          style: TextStyle(
                            color: _kInk,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < _argRows.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: i.isEven ? _kPaper : _kBone,
                      border: const Border(
                        bottom: BorderSide(color: _kPaperGrime, width: 0.6),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 190,
                          child: Text(
                            _argRows[i][0],
                            style: const TextStyle(
                              color: _kInk,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: Text(
                            _argRows[i][1],
                            style: const TextStyle(
                              color: _kRibbon,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _argRows[i][2],
                            style: const TextStyle(
                              color: Color(0xFF3A3326),
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
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

// ---------------------------------------------------------------------------
// SECTION 3 — LIVE SPECIMEN. A large display-type card morphs its weight,
// color, letter-spacing, decoration, and size as state chips toggle. A
// side panel lists the resolved TextStyle field-by-field.
// ---------------------------------------------------------------------------
class _WstsLiveSpecimen extends StatelessWidget {
  const _WstsLiveSpecimen({
    required this.states,
    required this.style,
    required this.hovered,
    required this.pressed,
    required this.focused,
    required this.selected,
    required this.disabled,
    required this.error,
    required this.dragged,
    required this.onHovered,
    required this.onPressed,
    required this.onFocused,
    required this.onSelected,
    required this.onDisabled,
    required this.onError,
    required this.onDragged,
  });

  final Set<WidgetState> states;
  final TextStyle style;
  final bool hovered;
  final bool pressed;
  final bool focused;
  final bool selected;
  final bool disabled;
  final bool error;
  final bool dragged;
  final VoidCallback onHovered;
  final VoidCallback onPressed;
  final VoidCallback onFocused;
  final VoidCallback onSelected;
  final VoidCallback onDisabled;
  final VoidCallback onError;
  final VoidCallback onDragged;

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '03',
      title: 'Live Specimen Block',
      kicker:
          'Toggle the state chips. The resolved TextStyle redraws the slug.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints bc) {
          final bool wide = bc.maxWidth >= 860;
          final Widget specimen = _buildSpecimen(context);
          final Widget panel = _buildResolvedPanel(context);
          final Widget chips = _buildChipRow();
          if (wide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                chips,
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(flex: 3, child: specimen),
                    const SizedBox(width: 16),
                    Expanded(flex: 2, child: panel),
                  ],
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              chips,
              const SizedBox(height: 16),
              specimen,
              const SizedBox(height: 16),
              panel,
            ],
          );
        },
      ),
    );
  }

  Widget _buildChipRow() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        _StateChip(label: 'hovered', on: hovered, onTap: onHovered),
        _StateChip(label: 'pressed', on: pressed, onTap: onPressed),
        _StateChip(label: 'focused', on: focused, onTap: onFocused),
        _StateChip(label: 'selected', on: selected, onTap: onSelected),
        _StateChip(label: 'disabled', on: disabled, onTap: onDisabled),
        _StateChip(label: 'error', on: error, onTap: onError),
        _StateChip(label: 'dragged', on: dragged, onTap: onDragged),
      ],
    );
  }

  Widget _buildSpecimen(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _kPaper,
        border: Border.all(color: _kPaperGrime, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.45),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const _WstsFrameCorner(corner: _FrameCorner.topLeft),
              Expanded(
                child: Container(height: 1, color: _kPaperGrime),
              ),
              const _WstsFrameCorner(corner: _FrameCorner.topRight),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
            child: SizedBox(
              width: double.infinity,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
                style: style,
                child: const Text(
                  _WstsHomeState._kSpecimen,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              const _WstsFrameCorner(corner: _FrameCorner.bottomLeft),
              Expanded(
                child: Container(height: 1, color: _kPaperGrime),
              ),
              const _WstsFrameCorner(corner: _FrameCorner.bottomRight),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            states.isEmpty
                ? 'states = { }  (idle / default)'
                : 'states = ${_setString(states)}',
            style: const TextStyle(
              color: _kIronLight,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResolvedPanel(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>['fontSize', style.fontSize?.toStringAsFixed(1) ?? '—'],
      <String>['fontWeight', _weightName(style.fontWeight)],
      <String>['color', _colorHex(style.color)],
      <String>['letterSpacing', style.letterSpacing?.toStringAsFixed(2) ?? '—'],
      <String>['decoration', _decorationName(style.decoration)],
      <String>['fontStyle', style.fontStyle?.name ?? 'normal'],
      <String>['fontFamily', style.fontFamily ?? 'default'],
      <String>['height', style.height?.toStringAsFixed(2) ?? '—'],
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kInk,
        border: Border.all(color: _kCinnabar, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'RESOLVED STYLE',
            style: TextStyle(
              color: _kSaffron,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.6,
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: _kLead),
          const SizedBox(height: 10),
          for (final List<String> r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    child: Text(
                      r[0],
                      style: const TextStyle(
                        color: _kPaperGrime,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      r[1],
                      style: const TextStyle(
                        color: _kBone,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
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

  static String _setString(Set<WidgetState> s) {
    final List<String> names =
        s.map((WidgetState e) => e.name).toList()..sort();
    return '{ ${names.join(', ')} }';
  }

  static String _weightName(FontWeight? w) {
    if (w == null) return '—';
    if (w == FontWeight.w100) return 'w100';
    if (w == FontWeight.w200) return 'w200';
    if (w == FontWeight.w300) return 'w300';
    if (w == FontWeight.w400) return 'w400 (normal)';
    if (w == FontWeight.w500) return 'w500';
    if (w == FontWeight.w600) return 'w600';
    if (w == FontWeight.w700) return 'w700 (bold)';
    if (w == FontWeight.w800) return 'w800';
    if (w == FontWeight.w900) return 'w900 (black)';
    return 'w${w.value}';
  }

  static String _decorationName(TextDecoration? d) {
    if (d == null || d == TextDecoration.none) return 'none';
    if (d == TextDecoration.underline) return 'underline';
    if (d == TextDecoration.lineThrough) return 'lineThrough';
    if (d == TextDecoration.overline) return 'overline';
    return d.toString();
  }

  static String _colorHex(Color? c) {
    if (c == null) return '—';
    final int r = (c.r * 255).round() & 0xFF;
    final int g = (c.g * 255).round() & 0xFF;
    final int b = (c.b * 255).round() & 0xFF;
    final int a = (c.a * 255).round() & 0xFF;
    String h(int v) => v.toRadixString(16).padLeft(2, '0').toUpperCase();
    return '#${h(a)}${h(r)}${h(g)}${h(b)}';
  }
}

// ---------------------------------------------------------------------------
// Small toggle chip used by the specimen. Renders as paper-on-iron when off
// and saffron-on-ink when on. The border turns cinnabar when on.
// ---------------------------------------------------------------------------
class _StateChip extends StatelessWidget {
  const _StateChip({
    required this.label,
    required this.on,
    required this.onTap,
  });
  final String label;
  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: on ? _kSaffron : _kIronLight,
          border: Border.all(
            color: on ? _kRibbon : _kLead,
            width: 1.2,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: on ? _kInk : _kPaperGrime,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
        ),
      ),
    );
  }
}

enum _FrameCorner { topLeft, topRight, bottomLeft, bottomRight }

// ---------------------------------------------------------------------------
// _WstsFrameCorner — small decorative L-shape painted with a CustomPainter
// (_WstsFrameCornerPainter) for the specimen frame. Second custom painter
// in the file, as required by the brief.
// ---------------------------------------------------------------------------
class _WstsFrameCorner extends StatelessWidget {
  const _WstsFrameCorner({required this.corner});
  final _FrameCorner corner;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(
        painter: _WstsFrameCornerPainter(corner: corner),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 — FACTORY DUEL. Two cards side-by-side: resolveWith versus
// fromMap. The two styles should produce equivalent behaviour for the
// current state set. The fromMap version also demonstrates a composite
// WidgetState.pressed & WidgetState.selected rule.
// ---------------------------------------------------------------------------
class _WstsFactoryDuel extends StatelessWidget {
  const _WstsFactoryDuel({
    required this.resolveWithStyle,
    required this.mapStyle,
    required this.states,
  });

  final WidgetStateTextStyle resolveWithStyle;
  final WidgetStateTextStyle mapStyle;
  final Set<WidgetState> states;

  static const String _resolveSource =
      'final resolveWithStyle =\n'
      '    WidgetStateTextStyle.resolveWith((states) {\n'
      '  if (states.contains(WidgetState.disabled)) return _dim;\n'
      '  if (states.contains(WidgetState.error))    return _red;\n'
      '  if (states.contains(WidgetState.pressed))  return _amber;\n'
      '  if (states.contains(WidgetState.hovered))  return _italic;\n'
      '  if (states.contains(WidgetState.focused))  return _under;\n'
      '  if (states.contains(WidgetState.selected)) return _fat;\n'
      '  return _base;\n'
      '});';

  static const String _mapSource =
      'final mapStyle = WidgetStateTextStyle.fromMap({\n'
      '  WidgetState.disabled: _dim,\n'
      '  WidgetState.error:    _red,\n'
      '  WidgetState.pressed & WidgetState.selected: _amberFat,\n'
      '  WidgetState.pressed:  _amber,\n'
      '  WidgetState.hovered:  _italic,\n'
      '  WidgetState.focused:  _under,\n'
      '  WidgetState.selected: _fat,\n'
      '  WidgetState.any:      _base,\n'
      '});';

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '04',
      title: 'fromMap vs resolveWith',
      kicker: 'Two factories, one intent. Map order matters — always.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints bc) {
          final bool wide = bc.maxWidth >= 720;
          final Widget left = _buildFactoryCard(
            title: 'resolveWith',
            subtitle: 'Imperative · callback-based',
            source: _resolveSource,
            resolved: resolveWithStyle.resolve(states),
          );
          final Widget right = _buildFactoryCard(
            title: 'fromMap',
            subtitle: 'Declarative · insertion-order scan',
            source: _mapSource,
            resolved: mapStyle.resolve(states),
          );
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: left),
                const SizedBox(width: 16),
                Expanded(child: right),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              left,
              const SizedBox(height: 16),
              right,
            ],
          );
        },
      ),
    );
  }

  Widget _buildFactoryCard({
    required String title,
    required String subtitle,
    required String source,
    required TextStyle resolved,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _kSoot,
        border: Border.all(color: _kLead, width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _kSaffron,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: _kBone,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: _kPaperGrime,
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kInk,
              border: Border.all(color: _kLead, width: 1),
            ),
            child: Text(
              source,
              style: const TextStyle(
                color: _kBone,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            decoration: BoxDecoration(
              color: _kPaper,
              border: Border.all(color: _kPaperGrime, width: 1),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: resolved.copyWith(fontSize: 18),
              child: const Text(_WstsHomeState._kPangram),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 — BUTTON THEME GALLERY. Real ElevatedButton / FilledButton /
// OutlinedButton / TextButton, each with ButtonStyle.textStyle wired to a
// WidgetStateTextStyle. Each has an animated indicator strip below driven
// by the shared pulse controller.
// ---------------------------------------------------------------------------
class _WstsButtonGallery extends StatelessWidget {
  const _WstsButtonGallery({required this.pulse});
  final AnimationController pulse;

  // The textStyle for every button. Pressed/hovered/focused/disabled all
  // map to distinct TextStyles so the text itself reacts to user input.
  static WidgetStateTextStyle get _buttonTextStyle =>
      WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            fontStyle: FontStyle.italic,
          );
        }
        if (states.contains(WidgetState.pressed)) {
          return const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.6,
          );
        }
        if (states.contains(WidgetState.hovered)) {
          return const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
          );
        }
        if (states.contains(WidgetState.focused)) {
          return const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            decoration: TextDecoration.underline,
          );
        }
        return const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        );
      });

  @override
  Widget build(BuildContext context) {
    final List<_ButtonEntry> entries = <_ButtonEntry>[
      _ButtonEntry(
        kind: 'ElevatedButton',
        builder: (VoidCallback onTap) => ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: _kSaffron,
            foregroundColor: _kInk,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ).copyWith(textStyle: _buttonTextStyle),
          child: const Text('COMPOSE STICK'),
        ),
      ),
      _ButtonEntry(
        kind: 'FilledButton',
        builder: (VoidCallback onTap) => FilledButton(
          onPressed: onTap,
          style: FilledButton.styleFrom(
            backgroundColor: _kCinnabar,
            foregroundColor: _kBone,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ).copyWith(textStyle: _buttonTextStyle),
          child: const Text('INK FORME'),
        ),
      ),
      _ButtonEntry(
        kind: 'OutlinedButton',
        builder: (VoidCallback onTap) => OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: _kSaffron,
            side: const BorderSide(color: _kSaffron, width: 1.4),
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ).copyWith(textStyle: _buttonTextStyle),
          child: const Text('SET PROOF'),
        ),
      ),
      _ButtonEntry(
        kind: 'TextButton',
        builder: (VoidCallback onTap) => TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: _kBone,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: const RoundedRectangleBorder(),
          ).copyWith(textStyle: _buttonTextStyle),
          child: const Text('READ COPY'),
        ),
      ),
    ];
    return _WstsSection(
      number: '05',
      title: 'Button Theme Gallery',
      kicker:
          'Real buttons with ButtonStyle.textStyle wired to a '
          'WidgetStateTextStyle.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints bc) {
          final int cols = bc.maxWidth > 760 ? 4 : (bc.maxWidth > 420 ? 2 : 1);
          final double gap = 12;
          final double w = (bc.maxWidth - (cols - 1) * gap) / cols;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: <Widget>[
              for (final _ButtonEntry e in entries)
                SizedBox(
                  width: w,
                  child: _ButtonGalleryTile(entry: e, pulse: pulse),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ButtonEntry {
  const _ButtonEntry({required this.kind, required this.builder});
  final String kind;
  final Widget Function(VoidCallback onTap) builder;
}

class _ButtonGalleryTile extends StatefulWidget {
  const _ButtonGalleryTile({required this.entry, required this.pulse});
  final _ButtonEntry entry;
  final AnimationController pulse;

  @override
  State<_ButtonGalleryTile> createState() => _ButtonGalleryTileState();
}

class _ButtonGalleryTileState extends State<_ButtonGalleryTile> {
  int _taps = 0;

  void _bump() {
    setState(() => _taps += 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSoot,
        border: Border.all(color: _kLead, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.entry.kind,
            style: const TextStyle(
              color: _kPaperGrime,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: widget.entry.builder(_bump),
          ),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: widget.pulse,
            builder: (BuildContext ctx, Widget? _) {
              return SizedBox(
                height: 10,
                child: CustomPaint(
                  painter: _PulseStripPainter(progress: widget.pulse.value),
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            'taps: $_taps',
            style: const TextStyle(
              color: _kLeadLight,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6 — CHIP THEME SHOWCASE. A local `Theme` override sets
// `ChipThemeData.labelStyle` to a WidgetStateTextStyle.fromMap with three
// entries. The four chip variants (FilterChip, ChoiceChip, ActionChip,
// InputChip) all inherit the state-reactive label style.
// ---------------------------------------------------------------------------
class _WstsChipShowcase extends StatefulWidget {
  const _WstsChipShowcase();

  @override
  State<_WstsChipShowcase> createState() => _WstsChipShowcaseState();
}

class _WstsChipShowcaseState extends State<_WstsChipShowcase> {
  bool _filter = true;
  bool _choice = false;
  bool _inputActive = true;

  @override
  Widget build(BuildContext context) {
    // C15: ChipThemeData.labelStyle is typed `TextStyle?` and Flutter's
    // chip implementation calls `labelStyle.merge(...)` directly on it
    // (see `material/chip.dart:1375`) without `WidgetStateProperty`
    // resolution — so a `WidgetStateTextStyle.fromMap(...)` value (which
    // is a `WidgetStateMapper<TextStyle>` whose `noSuchMethod` throws on
    // any call other than `resolve`) cannot be used directly as a chip
    // label style. This is a real-Flutter limitation, not a d4rt issue.
    // Build the map declaratively, then resolve it once for the empty
    // state set so the showcase still demonstrates the `fromMap` factory
    // surface while feeding the chip a static `TextStyle` it can merge.
    final WidgetStateTextStyle chipLabelMapper =
        WidgetStateTextStyle.fromMap(<WidgetStatesConstraint, TextStyle>{
      WidgetState.disabled: const TextStyle(
        color: _kLeadLight,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.lineThrough,
      ),
      WidgetState.selected: const TextStyle(
        color: _kInk,
        fontSize: 13,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
      WidgetState.hovered: const TextStyle(
        color: _kCinnabar,
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
      ),
      WidgetState.any: const TextStyle(
        color: _kBone,
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    });
    final TextStyle chipLabel = chipLabelMapper.resolve(<WidgetState>{});

    final ChipThemeData baseChipTheme = ChipTheme.of(context);
    final ChipThemeData tuned = baseChipTheme.copyWith(
      backgroundColor: _kIron,
      selectedColor: _kSaffron,
      disabledColor: _kIronLight,
      side: const BorderSide(color: _kLead, width: 1),
      shape: const RoundedRectangleBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      labelStyle: chipLabel,
      secondaryLabelStyle: chipLabel,
      checkmarkColor: _kInk,
      showCheckmark: true,
    );

    return _WstsSection(
      number: '06',
      title: 'Chip Theme Showcase',
      kicker:
          'ChipThemeData.labelStyle = WidgetStateTextStyle.fromMap. Four '
          'chip variants, one style source.',
      child: Theme(
        data: Theme.of(context).copyWith(chipTheme: tuned),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                FilterChip(
                  label: const Text('FilterChip'),
                  selected: _filter,
                  onSelected: (bool v) => setState(() => _filter = v),
                ),
                ChoiceChip(
                  label: const Text('ChoiceChip'),
                  selected: _choice,
                  onSelected: (bool v) => setState(() => _choice = v),
                ),
                ActionChip(
                  label: const Text('ActionChip'),
                  onPressed: () {
                    debugPrint('[Wsts] action chip tapped');
                  },
                ),
                InputChip(
                  label: const Text('InputChip'),
                  selected: _inputActive,
                  onSelected: (bool v) => setState(() => _inputActive = v),
                  onDeleted: () {
                    setState(() => _inputActive = false);
                  },
                ),
                const FilterChip(
                  label: Text('disabled'),
                  selected: false,
                  onSelected: null,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kSoot,
                border: Border.all(color: _kLead, width: 1),
              ),
              child: const Text(
                'Each chip reads `labelStyle` from the ChipTheme. Because '
                'the labelStyle is a WidgetStateTextStyle, the label text '
                'redraws on selection, hover, and disabled — no per-chip '
                'wiring required.',
                style: TextStyle(
                  color: _kPaper,
                  fontSize: 12.5,
                  height: 1.45,
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
// SECTION 7 — ANIMATED SWEEP. A TweenAnimationBuilder<double> cycles
// through idle → hovered → pressed → selected → disabled, quantising
// progress into a Set<WidgetState>, resolving the TextStyle, and rendering
// a specimen that interpolates via TextStyle.lerp for the in-between
// frames.
// ---------------------------------------------------------------------------
class _WstsSweep extends StatelessWidget {
  const _WstsSweep({required this.sweep});
  final AnimationController sweep;

  static const List<_SweepPhase> _phases = <_SweepPhase>[
    _SweepPhase(
      name: 'idle',
      states: <WidgetState>{},
    ),
    _SweepPhase(
      name: 'hovered',
      states: <WidgetState>{WidgetState.hovered},
    ),
    _SweepPhase(
      name: 'pressed',
      states: <WidgetState>{WidgetState.pressed},
    ),
    _SweepPhase(
      name: 'selected',
      states: <WidgetState>{WidgetState.selected},
    ),
    _SweepPhase(
      name: 'disabled',
      states: <WidgetState>{WidgetState.disabled},
    ),
  ];

  // Sweep style — distinct TextStyles per-phase so interpolation has
  // something interesting to blend through.
  static WidgetStateTextStyle get _sweepStyle =>
      WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            color: _kLeadLight,
            letterSpacing: 1.0,
            decoration: TextDecoration.lineThrough,
            height: 1.15,
          );
        }
        if (states.contains(WidgetState.pressed)) {
          return const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: _kSaffron,
            letterSpacing: 2.4,
            fontFamily: 'monospace',
            height: 1.15,
          );
        }
        if (states.contains(WidgetState.hovered)) {
          return const TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w700,
            color: _kBone,
            letterSpacing: 1.6,
            fontStyle: FontStyle.italic,
            height: 1.15,
          );
        }
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: _kBone,
            letterSpacing: 3.2,
            height: 1.15,
          );
        }
        return const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: _kPaper,
          letterSpacing: 1.0,
          height: 1.15,
        );
      });

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '07',
      title: 'Animated Sweep',
      kicker:
          'TweenAnimationBuilder quantises progress into states and '
          'interpolates the resolved TextStyle.',
      child: AnimatedBuilder(
        animation: sweep,
        builder: (BuildContext ctx, Widget? _) {
          final double t = sweep.value * _phases.length;
          final int idxA = t.floor() % _phases.length;
          final int idxB = (idxA + 1) % _phases.length;
          final double local = t - t.floor();
          final _SweepPhase a = _phases[idxA];
          final _SweepPhase b = _phases[idxB];
          final TextStyle sa = _sweepStyle.resolve(a.states);
          final TextStyle sb = _sweepStyle.resolve(b.states);
          final TextStyle lerped =
              TextStyle.lerp(sa, sb, Curves.easeInOut.transform(local)) ?? sa;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  for (int i = 0; i < _phases.length; i++) ...<Widget>[
                    Expanded(
                      child: _SweepPhaseLamp(
                        label: _phases[i].name,
                        active: i == idxA,
                        next: i == idxB,
                        progress: local,
                      ),
                    ),
                    if (i != _phases.length - 1) const SizedBox(width: 6),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  color: _kPaper,
                  border: Border.all(color: _kPaperGrime, width: 1),
                ),
                child: Text(
                  _WstsHomeState._kSpecimen,
                  style: lerped,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'blend ${a.name} → ${b.name}  '
                't=${local.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: _kLeadLight,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SweepPhase {
  const _SweepPhase({required this.name, required this.states});
  final String name;
  final Set<WidgetState> states;
}

class _SweepPhaseLamp extends StatelessWidget {
  const _SweepPhaseLamp({
    required this.label,
    required this.active,
    required this.next,
    required this.progress,
  });
  final String label;
  final bool active;
  final bool next;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final Color base = active
        ? Color.lerp(_kSaffron, _kCinnabar, progress) ?? _kSaffron
        : (next
            ? Color.lerp(_kIronLight, _kSaffron, progress) ?? _kIronLight
            : _kIronLight);
    final Color textColor = active || (next && progress > 0.6)
        ? _kInk
        : _kPaperGrime;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: base,
        border: Border.all(
          color: active ? _kRibbon : _kLead,
          width: active ? 1.6 : 1,
        ),
      ),
      child: Center(
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: textColor,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.6,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 8 — RECIPES. Seven recipe cards, each with a state trigger, a
// code excerpt describing the TextStyle adjustment, and a live mini
// preview rendered with the exact style. Clicking the preview toggles the
// recipe's trigger state so the reader can see the effect.
// ---------------------------------------------------------------------------
class _WstsRecipes extends StatefulWidget {
  const _WstsRecipes();

  @override
  State<_WstsRecipes> createState() => _WstsRecipesState();
}

class _WstsRecipesState extends State<_WstsRecipes> {
  final List<bool> _flags = List<bool>.filled(7, false);

  static final List<_Recipe> _recipes = <_Recipe>[
    _Recipe(
      title: 'Emphasis on focus',
      trigger: WidgetState.focused,
      triggerLabel: 'focused',
      snippet:
          'WidgetState.focused: TextStyle(\n'
          '  fontWeight: FontWeight.w900,\n'
          '  decoration: TextDecoration.underline,\n'
          '),',
      base: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      active: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w900,
        decoration: TextDecoration.underline,
      ),
      sample: 'Pay attention to me.',
    ),
    _Recipe(
      title: 'Red on error',
      trigger: WidgetState.error,
      triggerLabel: 'error',
      snippet:
          'WidgetState.error: TextStyle(\n'
          '  color: Colors.red.shade700,\n'
          '  fontWeight: FontWeight.w800,\n'
          '),',
      base: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      active: const TextStyle(
        color: _kCinnabar,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
      sample: 'Required field.',
    ),
    _Recipe(
      title: 'Strikethrough on disabled',
      trigger: WidgetState.disabled,
      triggerLabel: 'disabled',
      snippet:
          'WidgetState.disabled: TextStyle(\n'
          '  color: Colors.grey,\n'
          '  decoration: TextDecoration.lineThrough,\n'
          '),',
      base: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      active: const TextStyle(
        color: _kLeadLight,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.lineThrough,
      ),
      sample: 'This option is unavailable.',
    ),
    _Recipe(
      title: 'Uppercase feel on selected',
      trigger: WidgetState.selected,
      triggerLabel: 'selected',
      snippet:
          'WidgetState.selected: TextStyle(\n'
          '  fontWeight: FontWeight.w900,\n'
          '  letterSpacing: 3.6,\n'
          '),',
      base: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      active: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w900,
        letterSpacing: 3.6,
      ),
      sample: 'CHOSEN FACE',
    ),
    _Recipe(
      title: 'Serif → monospace on pressed',
      trigger: WidgetState.pressed,
      triggerLabel: 'pressed',
      snippet:
          'WidgetState.pressed: TextStyle(\n'
          '  fontFamily: \'monospace\',\n'
          '  fontWeight: FontWeight.w800,\n'
          '),',
      base: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontFamily: 'serif',
      ),
      active: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w800,
      ),
      sample: 'fixed width under the thumb',
    ),
    _Recipe(
      title: 'Italic on hovered',
      trigger: WidgetState.hovered,
      triggerLabel: 'hovered',
      snippet:
          'WidgetState.hovered: TextStyle(\n'
          '  fontStyle: FontStyle.italic,\n'
          '),',
      base: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      active: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
      sample: 'lean into the pointer',
    ),
    _Recipe(
      title: 'Size bump on dragged',
      trigger: WidgetState.dragged,
      triggerLabel: 'dragged',
      snippet:
          'WidgetState.dragged: TextStyle(\n'
          '  fontSize: 22,\n'
          '  fontWeight: FontWeight.w800,\n'
          '),',
      base: const TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      active: const TextStyle(
        color: _kInk,
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
      sample: 'grabbed and growing',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '08',
      title: 'Recipes',
      kicker:
          'Seven copy-pastable TextStyle rules. Tap a preview to toggle '
          'the trigger state.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints bc) {
          final int cols = bc.maxWidth > 980 ? 3 : (bc.maxWidth > 620 ? 2 : 1);
          final double gap = 12;
          final double w = (bc.maxWidth - (cols - 1) * gap) / cols;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: <Widget>[
              for (int i = 0; i < _recipes.length; i++)
                SizedBox(
                  width: w,
                  child: _RecipeCard(
                    recipe: _recipes[i],
                    active: _flags[i],
                    onToggle: () {
                      setState(() => _flags[i] = !_flags[i]);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.trigger,
    required this.triggerLabel,
    required this.snippet,
    required this.base,
    required this.active,
    required this.sample,
  });
  final String title;
  final WidgetState trigger;
  final String triggerLabel;
  final String snippet;
  final TextStyle base;
  final TextStyle active;
  final String sample;
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.recipe,
    required this.active,
    required this.onToggle,
  });
  final _Recipe recipe;
  final bool active;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final WidgetStateTextStyle wss =
        WidgetStateTextStyle.fromMap(<WidgetStatesConstraint, TextStyle>{
      recipe.trigger: recipe.active,
      WidgetState.any: recipe.base,
    });
    final Set<WidgetState> states =
        active ? <WidgetState>{recipe.trigger} : <WidgetState>{};
    final TextStyle resolved = wss.resolve(states);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kPaper,
        border: Border.all(color: _kPaperGrime, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: active ? _kCinnabar : _kPaperDeep,
                  border: Border.all(
                    color: active ? _kRibbon : _kPaperGrime,
                    width: 1,
                  ),
                ),
                child: Text(
                  recipe.triggerLabel.toUpperCase(),
                  style: TextStyle(
                    color: active ? _kBone : _kInk,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kInk,
              border: Border.all(color: _kLead, width: 1),
            ),
            child: Text(
              recipe.snippet,
              style: const TextStyle(
                color: _kBone,
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: onToggle,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: _kBone,
                border: Border.all(color: _kPaperGrime, width: 1),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                style: resolved,
                child: Text(recipe.sample),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            active ? 'tap again to reset' : 'tap to activate trigger',
            style: const TextStyle(
              color: _kIronLight,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9 — COMPARISON. Four-row table contrasting WidgetStateTextStyle
// with plain TextStyle, WidgetStatePropertyAll<TextStyle>, the deprecated
// MaterialStateTextStyle, and an inline conditional-ternary TextStyle.
// ---------------------------------------------------------------------------
class _WstsComparison extends StatelessWidget {
  const _WstsComparison();

  static const List<List<String>> _rows = <List<String>>[
    <String>[
      'WidgetStateTextStyle',
      'abstract class, extends TextStyle, '
          'implements WidgetStateProperty<TextStyle>',
      'Reacts to all WidgetStates. Works anywhere a TextStyle is accepted '
          '(default path) AND anywhere a WidgetStateProperty<TextStyle> is '
          'accepted (resolved path).',
      'Dynamic state styling — the canonical choice.',
    ],
    <String>[
      'Plain TextStyle',
      'class TextStyle',
      'Single immutable value. No awareness of WidgetState. Consumers '
          'using WidgetStateProperty will wrap via WidgetStatePropertyAll.',
      'Static styling with no hover / pressed / disabled variation.',
    ],
    <String>[
      'WidgetStatePropertyAll<TextStyle>',
      'class WidgetStatePropertyAll<T> '
          'implements WidgetStateProperty<T>',
      'Wraps a single TextStyle so it satisfies the '
          'WidgetStateProperty<TextStyle> signature. resolve(states) '
          'always returns that one value.',
      'Opting into the WidgetStateProperty API without actually varying '
          'per-state — a bridge style.',
    ],
    <String>[
      'MaterialStateTextStyle (deprecated)',
      'deprecated typedef / class predating the WidgetState rename',
      'Same contract, older Material-2-era naming. Accepts the same '
          'resolver callbacks. Tooling warns to switch to '
          'WidgetStateTextStyle.',
      'Legacy code only — replace with WidgetStateTextStyle.',
    ],
    <String>[
      'Inline conditional TextStyle',
      'ad-hoc expression',
      'e.g. `style: isSelected ? bold : regular`. Works only where you '
          'own the build method; can not be passed to ButtonStyle or '
          'ChipThemeData, because those need WidgetStateProperty.',
      'Tiny local toggles. Breaks down the moment Material widgets ask '
          'for a WidgetStateProperty<TextStyle>.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '09',
      title: 'Comparison',
      kicker: 'When to reach for WidgetStateTextStyle and when not to.',
      child: Container(
        decoration: BoxDecoration(
          color: _kPaper,
          border: Border.all(color: _kPaperGrime, width: 1),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: _kPaperDeep,
                border: Border(
                  bottom: BorderSide(color: _kPaperGrime, width: 1),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 180,
                    child: Text(
                      'API',
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      'SHAPE',
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'BEHAVIOUR',
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'USE WHEN',
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < _rows.length; i++)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: i.isEven ? _kPaper : _kBone,
                  border: const Border(
                    bottom: BorderSide(color: _kPaperGrime, width: 0.6),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 180,
                      child: Text(
                        _rows[i][0],
                        style: const TextStyle(
                          color: _kRibbon,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: Text(
                        _rows[i][1],
                        style: const TextStyle(
                          color: _kInk,
                          fontSize: 11.5,
                          fontFamily: 'monospace',
                          height: 1.45,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _rows[i][2],
                        style: const TextStyle(
                          color: Color(0xFF3A3326),
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 200,
                      child: Text(
                        _rows[i][3],
                        style: const TextStyle(
                          color: _kIron,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          height: 1.45,
                        ),
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

// ---------------------------------------------------------------------------
// SECTION 10 — GLOSSARY. Ten terms, each with a one-sentence definition
// plus a short clarification. Rendered as a two-column definition list.
// ---------------------------------------------------------------------------
class _WstsGlossary extends StatelessWidget {
  const _WstsGlossary();

  static const List<List<String>> _terms = <List<String>>[
    <String>[
      'WidgetStateTextStyle',
      'Abstract subclass of TextStyle that also implements '
          'WidgetStateProperty<TextStyle>. The subject of this demo.',
    ],
    <String>[
      'TextStyle',
      'Immutable description of font family, size, weight, color, '
          'decoration, spacing, and more. The supertype of the demo class.',
    ],
    <String>[
      'WidgetStateProperty<T>',
      'Interface with `T resolve(Set<WidgetState> states)`. The common '
          'contract of every state-reactive theme value.',
    ],
    <String>[
      'WidgetStateMap<T>',
      'Typedef `Map<WidgetStatesConstraint, T>`. Passed to `.fromMap` '
          'factories; first-matching key wins.',
    ],
    <String>[
      'resolve(states)',
      'The method consumers call to pick the per-state value. For '
          'WidgetStateTextStyle, returns a TextStyle.',
    ],
    <String>[
      'WidgetStateTextStyle.fromMap',
      'Declarative factory. Keys are WidgetStatesConstraint; the first '
          'satisfied key wins. End with WidgetState.any as fallback.',
    ],
    <String>[
      'WidgetStateTextStyle.resolveWith',
      'Imperative factory taking a callback `TextStyle Function('
          'Set<WidgetState> states)`. Good for complex, computed logic.',
    ],
    <String>[
      'WidgetStatesConstraint',
      'Interface for keys in a WidgetStateMap. WidgetState enum values '
          'implement it; &, |, ~ build composites.',
    ],
    <String>[
      'MaterialStateTextStyle (deprecated)',
      'Old Material-2 predecessor. Same contract, replaced by '
          'WidgetStateTextStyle with the broader WidgetState rename.',
    ],
    <String>[
      'WidgetState.any',
      'Sentinel constraint that matches every state set. Place it last '
          'in a fromMap to behave as the default branch.',
    ],
    <String>[
      'WidgetPropertyResolver<T>',
      'Typedef `T Function(Set<WidgetState> states)`. The callback type '
          'accepted by `.resolveWith`.',
    ],
    <String>[
      'WidgetStatePropertyAll<T>',
      'Lightweight wrapper that returns the same value regardless of '
          'state. Useful for opting into the WidgetStateProperty API.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _WstsSection(
      number: '10',
      title: 'Glossary',
      kicker: 'Terms this chapter relied on, collected in one spread.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints bc) {
          final int cols = bc.maxWidth > 720 ? 2 : 1;
          final double gap = 12;
          final double w = (bc.maxWidth - (cols - 1) * gap) / cols;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: <Widget>[
              for (final List<String> t in _terms)
                SizedBox(
                  width: w,
                  child: _GlossaryEntry(term: t[0], body: t[1]),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _GlossaryEntry extends StatelessWidget {
  const _GlossaryEntry({required this.term, required this.body});
  final String term;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSoot,
        border: Border.all(color: _kLead, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            term,
            style: const TextStyle(
              color: _kSaffron,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              color: _kPaper,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// EPILOGUE — closing narrative that ties the foundry metaphor back to the
// programmatic model.
// ---------------------------------------------------------------------------
class _WstsEpilogue extends StatelessWidget {
  const _WstsEpilogue();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _kInk,
        border: Border.all(color: _kSaffron, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Epilogue — Closing the Chase',
            style: TextStyle(
              color: _kSaffron,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: _kLead),
          const SizedBox(height: 10),
          const Text(
            'A letterpress shop keeps its types sorted in cases, its '
            'inks in pans, and its rollers on a rack. When a compositor '
            'sets copy, the same physical letter is lifted out of the '
            'case, locked into a chase, and inked under a different '
            'colour or under a different pressure depending on the '
            'proof being pulled. The slug does not change; its '
            'treatment does.',
            style: TextStyle(color: _kBone, fontSize: 13.5, height: 1.6),
          ),
          SizedBox(height: 10),
          Text(
            'WidgetStateTextStyle is that discipline expressed in code. '
            'The TextStyle identity travels through the theme; its '
            'treatment is chosen by the resolver when the chase is '
            'locked — that is, when the widget reports its current '
            'Set<WidgetState>. resolveWith is the foreman, reading '
            'proofs and barking orders; fromMap is the printed '
            'schedule on the shop wall, rules stacked in priority from '
            'top to bottom, ending with the house default.',
            style: TextStyle(color: _kPaper, fontSize: 13, height: 1.55),
          ),
          SizedBox(height: 10),
          Text(
            'Pin this page above your composing stick. The next time '
            'your ButtonStyle wants a textStyle, reach for a '
            'WidgetStateTextStyle; ink the foundry once, print a '
            'thousand proofs.',
            style: TextStyle(color: _kPaperGrime, fontSize: 12.5, height: 1.55),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CUSTOM PAINTERS
// ---------------------------------------------------------------------------

// _WstsFoundryBackdropPainter — the ambient background. Draws the
// composing-stick rails along the left/right margins, a slow-rolling ink
// roller across the top, scattered ink splatters, and a subtle type-case
// grid. Progress (0..1) drives the roller position.
class _WstsFoundryBackdropPainter extends CustomPainter {
  _WstsFoundryBackdropPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kSoot;
    canvas.drawRect(Offset.zero & size, bg);

    // --- subtle cast-iron vignette -----------------------------------
    final Rect vRect = Offset.zero & size;
    final Paint vignette = Paint()
      ..shader = ui.Gradient.radial(
        size.center(Offset.zero),
        size.longestSide * 0.75,
        <Color>[
          _kSoot,
          _kInk.withValues(alpha: 0.85),
        ],
        <double>[0.4, 1.0],
      );
    canvas.drawRect(vRect, vignette);

    // --- type-case grid ---------------------------------------------
    final Paint grid = Paint()
      ..color = _kIronLight.withValues(alpha: 0.22)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    const double cell = 64;
    for (double x = 0; x < size.width; x += cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += cell) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // --- composing-stick rails (left & right) ------------------------
    final Paint rail = Paint()
      ..color = _kRail.withValues(alpha: 0.35)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    const double inset = 18;
    canvas.drawLine(
      Offset(inset, 0),
      Offset(inset, size.height),
      rail,
    );
    canvas.drawLine(
      Offset(size.width - inset, 0),
      Offset(size.width - inset, size.height),
      rail,
    );
    // rail notch ticks
    final Paint tick = Paint()
      ..color = _kRail.withValues(alpha: 0.5)
      ..strokeWidth = 1.2;
    for (double y = 20; y < size.height; y += 28) {
      canvas.drawLine(Offset(inset - 4, y), Offset(inset + 4, y), tick);
      canvas.drawLine(
        Offset(size.width - inset - 4, y),
        Offset(size.width - inset + 4, y),
        tick,
      );
    }

    // --- rolling ink roller bar across the top ----------------------
    final double rollerY = 56;
    final Paint rollerBody = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, rollerY - 12),
        Offset(0, rollerY + 12),
        <Color>[_kLead, _kIronLight, _kLead],
        <double>[0.0, 0.5, 1.0],
      );
    final RRect rollerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(inset + 8, rollerY - 10, size.width - (inset + 8) * 2, 20),
      const Radius.circular(10),
    );
    canvas.drawRRect(rollerRect, rollerBody);
    final Paint rollerEdge = Paint()
      ..color = _kInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(rollerRect, rollerEdge);
    // roller hubs on each end — they rotate with progress
    final double hubR = 14;
    final Offset hubL = Offset(inset + 8, rollerY);
    final Offset hubR_ = Offset(size.width - inset - 8, rollerY);
    final Paint hub = Paint()..color = _kCinnabar;
    canvas.drawCircle(hubL, hubR, hub);
    canvas.drawCircle(hubR_, hubR, hub);
    final Paint hubLine = Paint()
      ..color = _kBone
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final double ang = progress * math.pi * 2;
    canvas.drawLine(
      hubL,
      hubL + Offset(math.cos(ang) * hubR, math.sin(ang) * hubR),
      hubLine,
    );
    canvas.drawLine(
      hubR_,
      hubR_ +
          Offset(math.cos(-ang) * hubR, math.sin(-ang) * hubR),
      hubLine,
    );

    // --- ink splatters scattered across the background ---------------
    final math.Random rng = math.Random(42);
    final Paint splatter = Paint();
    for (int i = 0; i < 38; i++) {
      final double x = rng.nextDouble() * size.width;
      final double y = rng.nextDouble() * size.height;
      final double r = 1.2 + rng.nextDouble() * 3.0;
      final Color c = i.isEven
          ? _kCinnabar.withValues(alpha: 0.08 + rng.nextDouble() * 0.1)
          : _kSaffron.withValues(alpha: 0.06 + rng.nextDouble() * 0.08);
      splatter.color = c;
      canvas.drawCircle(Offset(x, y), r, splatter);
    }

    // --- faint baseline rule near bottom -----------------------------
    final Paint baseline = Paint()
      ..color = _kLead.withValues(alpha: 0.45)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(inset, size.height - 48),
      Offset(size.width - inset, size.height - 48),
      baseline,
    );
    canvas.drawLine(
      Offset(inset, size.height - 24),
      Offset(size.width - inset, size.height - 24),
      baseline,
    );
  }

  @override
  bool shouldRepaint(covariant _WstsFoundryBackdropPainter old) {
    return old.progress != progress;
  }
}

// _WstsFrameCornerPainter — small L-shape used at the specimen frame
// corners. Hand-drawn with two strokes and a filled square at the
// vertex. Second CustomPainter in this file (requirement).
class _WstsFrameCornerPainter extends CustomPainter {
  _WstsFrameCornerPainter({required this.corner});
  final _FrameCorner corner;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = _kInk
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    final Paint dot = Paint()..color = _kCinnabar;

    final double len = math.min(size.width, size.height) - 2;
    late Offset v; // vertex
    late Offset h1; // horizontal arm end
    late Offset h2; // vertical arm end
    switch (corner) {
      case _FrameCorner.topLeft:
        v = const Offset(1, 1);
        h1 = Offset(1 + len, 1);
        h2 = Offset(1, 1 + len);
        break;
      case _FrameCorner.topRight:
        v = Offset(size.width - 1, 1);
        h1 = Offset(size.width - 1 - len, 1);
        h2 = Offset(size.width - 1, 1 + len);
        break;
      case _FrameCorner.bottomLeft:
        v = Offset(1, size.height - 1);
        h1 = Offset(1 + len, size.height - 1);
        h2 = Offset(1, size.height - 1 - len);
        break;
      case _FrameCorner.bottomRight:
        v = Offset(size.width - 1, size.height - 1);
        h1 = Offset(size.width - 1 - len, size.height - 1);
        h2 = Offset(size.width - 1, size.height - 1 - len);
        break;
    }
    canvas.drawLine(v, h1, stroke);
    canvas.drawLine(v, h2, stroke);
    canvas.drawRect(
      Rect.fromCenter(center: v, width: 5, height: 5),
      dot,
    );
  }

  @override
  bool shouldRepaint(covariant _WstsFrameCornerPainter old) {
    return old.corner != corner;
  }
}

// _PulseStripPainter — the little indicator strip beneath each button in
// the button gallery. Draws segmented bars that ripple from left to right
// as progress advances.
class _PulseStripPainter extends CustomPainter {
  _PulseStripPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const int segments = 18;
    final double segW = size.width / segments;
    final Paint p = Paint();
    for (int i = 0; i < segments; i++) {
      final double t = (i / segments) - progress;
      final double d = (t - t.floorToDouble());
      final double e = (1 - d).clamp(0.0, 1.0);
      final double intensity = math.pow(e, 3).toDouble();
      final Color c = Color.lerp(_kIronLight, _kSaffron, intensity) ??
          _kIronLight;
      p.color = c;
      canvas.drawRect(
        Rect.fromLTWH(i * segW + 1, 0, segW - 2, size.height),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PulseStripPainter old) {
    return old.progress != progress;
  }
}

