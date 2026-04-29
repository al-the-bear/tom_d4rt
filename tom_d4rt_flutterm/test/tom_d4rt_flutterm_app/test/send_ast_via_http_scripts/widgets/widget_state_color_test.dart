// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Chameleon Terrarium — WidgetStateColor Deep Demo
//
// SUBJECT
// -------
// `WidgetStateColor` is an ABSTRACT class declared in
// `package:flutter/src/widgets/widget_state.dart` (exported via
// `widgets.dart` and `material.dart`). It extends `Color` and implements
// `WidgetStateProperty<Color>`. Two factory constructors exist:
//
//   • `WidgetStateColor.resolveWith(WidgetPropertyResolver<Color> cb)`
//       returns a private `_WidgetStateColor`. The `cb` is evaluated
//       once for the empty state set, and the resulting ARGB is fed to
//       the `Color` super constructor so that *any* code that reads the
//       raw ARGB channels still sees a sensible default.
//
//   • `const WidgetStateColor.fromMap(WidgetStateMap<Color> map)` —
//       `WidgetStateMap<T> = Map<WidgetStatesConstraint, T>`. The map
//       is scanned in insertion order; the first constraint that is
//       satisfied by the resolver's state set wins. `WidgetState.any`
//       is a sentinel `WidgetStatesConstraint` that matches every
//       state set and is normally placed last as a fallback.
//
// THE COLOR SUBCLASS TRICK
// ------------------------
// Because `WidgetStateColor` extends `Color`, you can hand an instance
// to any Color-typed field. Interactive code that understands
// `WidgetStateProperty` will call `resolve(states)` and see the
// state-specific color; non-interactive code that just reads `.value`,
// `.red`, `.green`, `.blue`, or `.alpha` receives the default color
// baked into the super constructor. That is the "Color subclass trick":
// one object, two API surfaces, zero ceremony.
//
// HARNESS CONTRACT
// ----------------
// This script runs inside the d4rt AST harness. Exactly one top-level
// `dynamic build(BuildContext context)` entry point, returning a
// `MaterialApp`. No `main()`, no `runApp()`, no top-level mutable state,
// no `late` fields outside of State subclasses that opt into lifecycle
// methods.
//
// THEME — Chameleon Terrarium
// ---------------------------
// A hand-painted glass tank sits in the middle of the viewport. Mossy
// rocks heap on one side, sandy pebbles drift across the floor, and a
// large-eyed chameleon clings to a branch. Its base colour is a real
// `WidgetStateColor`; hovering, pressing, or flipping a "disabled"
// toggle causes the chameleon to shift through greens, ambers, and
// muted greys — exactly the mechanism production widgets use.
//
//   glass       = #E6F1ED   — soft greenish tank highlight
//   glassRim    = #9FB8AD   — glass edge shadow
//   sand        = #E8D6A3   — floor pebbles / sandy tans
//   sandDeep    = #C2A76B   — darker pebble / shadow
//   mossLight   = #8FB06B   — moss on rocks
//   mossDark    = #3E5B2E   — deep shadow in moss clumps
//   leafLight   = #A3C68F   — foliage highlight
//   leafDark    = #274E1B   — foliage shadow / leaf spine
//   branchLight = #8B6B4A   — branch highlight
//   branchDark  = #4D3A24   — branch shadow
//   skin        = #6FAE52   — baseline chameleon green
//   skinHot     = #D97E3C   — aggressive amber (hovered)
//   skinGlow    = #F3B545   — excited yellow (pressed)
//   skinDim     = #8A8F7C   — disabled muddy grey-green
//   skinError   = #C65353   — error red-coral
//   skinFocus   = #7AB6C4   — focus-ring cyan patch
//   ink         = #1E2A1C   — text on light backgrounds
//   inkSoft     = #4B5944   — muted label text
//   cream       = #FFF8E7   — card background / paper
//   shell       = #F3E8C8   — recipe card background
//   stroke      = #C2B483   — hairline separators

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// D4RT-SCRIPT-LIMITATION: layout cascade (Fa1 C3-deferred sub-pocket)
//
// Emits 9 FE in a single cascade:
//   - "BoxConstraints forces an infinite height" provided to
//     `RenderConstrainedBox`'s layout()
//   - "RenderBox was not laid out" on RenderFlex (×2),
//     RenderRepaintBoundary, sliver_multi_box_adaptor.dart:629
//     ('child.hasSize' assertion)
//   - "Null check operator used on a null value" (×2) — the layout
//     pass tries to read `firstChild`/`lastChild` of a sliver that
//     never sized.
//
// Triggered by the chameleon terrarium's wide horizontally-scrolling
// strip, which uses `Row(crossAxisAlignment: stretch)` with
// `Expanded` children inside a `SliverToBoxAdapter` inside a
// `CustomScrollView`. The Sliver protocol gives unbounded vertical
// extent which Row(stretch) cannot resolve, so every grandchild
// fails to lay out and the null-check operator hits in the
// downstream paint walk.
//
// Closing route documented in interpreter_unfixable.md §Fa1-N1
// (C3 sub-pocket): drop `crossAxisAlignment: stretch` (use
// `crossAxisAlignment: start`) and let each card decide its own
// height, or pin a finite parent height with
// `SliverToBoxAdapter(child: SizedBox(height: <fixed>, child: Row(...)))`.
// Deferred — the visual demo's hero strip leans on the stretched
// row to align card chrome; a non-trivial visual rework.
//
// Sentinel: test/fa1_bisect_test.dart [fa1-2250-sentinel].

// ---------------------------------------------------------------------------
// Palette constants — declared once so every widget in the file uses the
// same colors. Literal `Color(0xFF...)` keeps the palette deterministic
// and avoids drift between scenes.
// ---------------------------------------------------------------------------
const Color _kGlass = Color(0xFFE6F1ED);
const Color _kGlassRim = Color(0xFF9FB8AD);
const Color _kSand = Color(0xFFE8D6A3);
const Color _kSandDeep = Color(0xFFC2A76B);
const Color _kMossLight = Color(0xFF8FB06B);
const Color _kMossDark = Color(0xFF3E5B2E);
const Color _kLeafLight = Color(0xFFA3C68F);
const Color _kLeafDark = Color(0xFF274E1B);
const Color _kBranchLight = Color(0xFF8B6B4A);
const Color _kBranchDark = Color(0xFF4D3A24);
const Color _kSkin = Color(0xFF6FAE52);
const Color _kSkinHot = Color(0xFFD97E3C);
const Color _kSkinGlow = Color(0xFFF3B545);
const Color _kSkinDim = Color(0xFF8A8F7C);
const Color _kSkinError = Color(0xFFC65353);
const Color _kSkinFocus = Color(0xFF7AB6C4);
const Color _kInk = Color(0xFF1E2A1C);
const Color _kInkSoft = Color(0xFF4B5944);
const Color _kCream = Color(0xFFFFF8E7);
const Color _kShell = Color(0xFFF3E8C8);
const Color _kStroke = Color(0xFFC2B483);
const Color _kHighlight = Color(0xFFFBF3D9);

// ---------------------------------------------------------------------------
// Entry point — invoked exactly once per test script by the d4rt AST
// harness. Returns a fully self-contained `MaterialApp`.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('[Wsc] build() — WidgetStateColor chameleon-terrarium demo');
  return const _WscApp();
}

// ---------------------------------------------------------------------------
// Root MaterialApp. The entire demo is a single scrolling page. Theming
// is intentionally warm, paper-like, and hand-drawn — WidgetStateColor
// is subtle enough that a loud theme would drown it out.
// ---------------------------------------------------------------------------
class _WscApp extends StatelessWidget {
  const _WscApp();

  @override
  Widget build(BuildContext context) {
    debugPrint('[Wsc] building MaterialApp');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chameleon Terrarium — WidgetStateColor',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: _kCream,
        colorScheme: const ColorScheme.light(
          primary: _kMossDark,
          secondary: _kSkinHot,
          surface: _kShell,
          error: _kSkinError,
          onPrimary: _kCream,
          onSecondary: _kInk,
          onSurface: _kInk,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _kInk, height: 1.4),
          bodySmall: TextStyle(color: _kInkSoft, height: 1.35),
          titleLarge: TextStyle(
            color: _kMossDark,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
          titleMedium: TextStyle(
            color: _kInk,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
          titleSmall: TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
          labelLarge: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: const CardThemeData(
          color: _kShell,
          surfaceTintColor: _kShell,
          elevation: 0,
        ),
        dividerColor: _kStroke,
      ),
      home: const _WscHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscHome — owns state shared across the demo: the current live state
// set for the chameleon tile, the disabled/error/selected toggles, the
// button interaction counters, and the animation controller used by the
// animated-gradient section. Because a single StatefulWidget holds it
// all, the log and headline read a consistent snapshot.
// ---------------------------------------------------------------------------
class _WscHome extends StatefulWidget {
  const _WscHome();

  @override
  State<_WscHome> createState() => _WscHomeState();
}

class _WscHomeState extends State<_WscHome> with TickerProviderStateMixin {
  // --- live chameleon tile state -------------------------------------
  bool _hovered = false;
  bool _pressed = false;
  bool _focused = false;
  bool _disabled = false;
  bool _selected = false;
  bool _error = false;
  bool _dragged = false;

  // --- animated gradient controller ----------------------------------
  late final AnimationController _blendCtrl;
  late final AnimationController _tongueCtrl;

  // --- button showcase counters --------------------------------------
  int _filledTaps = 0;
  int _elevatedTaps = 0;
  int _outlinedTaps = 0;

  // --- scrolling event log -------------------------------------------
  final List<_WscEvent> _log = <_WscEvent>[];
  static const int _kLogLimit = 24;

  @override
  void initState() {
    super.initState();
    debugPrint('[Wsc] initState — spin up controllers');
    _blendCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _tongueCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _record('init', 'home mounted');
  }

  @override
  void dispose() {
    debugPrint('[Wsc] dispose — kill controllers');
    _blendCtrl.dispose();
    _tongueCtrl.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------
  // The LIVE chameleon skin — a real WidgetStateColor created once and
  // fed to the tile. Note: because `.resolveWith` has already evaluated
  // the empty state set, reading `baseSkin.value` gives the default
  // green. Reading `baseSkin.resolve(states)` gives the correct color.
  // This is the "Color subclass trick" in its clearest form.
  // -------------------------------------------------------------------
  WidgetStateColor get liveSkin => WidgetStateColor.resolveWith((
    Set<WidgetState> states,
  ) {
    if (states.contains(WidgetState.disabled)) {
      return _kSkinDim;
    }
    if (states.contains(WidgetState.error)) {
      return _kSkinError;
    }
    if (states.contains(WidgetState.pressed)) {
      return _kSkinGlow;
    }
    if (states.contains(WidgetState.hovered)) {
      return _kSkinHot;
    }
    if (states.contains(WidgetState.dragged)) {
      return _kBranchLight;
    }
    if (states.contains(WidgetState.focused)) {
      return _kSkinFocus;
    }
    if (states.contains(WidgetState.selected)) {
      return _kMossLight;
    }
    return _kSkin;
  });

  // -------------------------------------------------------------------
  // The MAP-BASED chameleon skin — same intent, different constructor.
  // `WidgetState.any` is the catch-all fallback; because map order
  // matters, disabled/error shadow everything else.
  // -------------------------------------------------------------------
  WidgetStateColor get mapSkin => WidgetStateColor.fromMap(
    <WidgetStatesConstraint, Color>{
      WidgetState.disabled: _kSkinDim,
      WidgetState.error: _kSkinError,
      WidgetState.pressed: _kSkinGlow,
      WidgetState.hovered: _kSkinHot,
      WidgetState.focused: _kSkinFocus,
      WidgetState.selected: _kMossLight,
      WidgetState.any: _kSkin,
    },
  );

  // -------------------------------------------------------------------
  // Compose the live state set from the boolean toggles / pointer.
  // -------------------------------------------------------------------
  Set<WidgetState> get _liveStates {
    final Set<WidgetState> s = <WidgetState>{};
    if (_disabled) s.add(WidgetState.disabled);
    if (_error) s.add(WidgetState.error);
    if (_pressed) s.add(WidgetState.pressed);
    if (_hovered) s.add(WidgetState.hovered);
    if (_focused) s.add(WidgetState.focused);
    if (_selected) s.add(WidgetState.selected);
    if (_dragged) s.add(WidgetState.dragged);
    return s;
  }

  void _setHovered(bool v) {
    if (_hovered == v) return;
    setState(() {
      _hovered = v;
      _record('hover', v ? 'enter' : 'leave');
    });
  }

  void _setPressed(bool v) {
    if (_pressed == v) return;
    setState(() {
      _pressed = v;
      _record('press', v ? 'down' : 'up');
    });
  }

  void _toggleFocus() {
    setState(() {
      _focused = !_focused;
      _record('focus', _focused ? 'gained' : 'lost');
    });
  }

  void _toggleDisabled() {
    setState(() {
      _disabled = !_disabled;
      _record('disabled', _disabled ? 'yes' : 'no');
    });
  }

  void _toggleSelected() {
    setState(() {
      _selected = !_selected;
      _record('selected', _selected ? 'yes' : 'no');
    });
  }

  void _toggleError() {
    setState(() {
      _error = !_error;
      _record('error', _error ? 'yes' : 'no');
    });
  }

  void _toggleDragged() {
    setState(() {
      _dragged = !_dragged;
      _record('dragged', _dragged ? 'yes' : 'no');
    });
  }

  void _flickTongue() {
    debugPrint('[Wsc] tongue flick');
    _tongueCtrl.forward(from: 0.0);
    _record('tongue', 'flick');
  }

  void _bumpFilled() {
    setState(() {
      _filledTaps += 1;
      _record('filled', 'tap #$_filledTaps');
    });
  }

  void _bumpElevated() {
    setState(() {
      _elevatedTaps += 1;
      _record('elevated', 'tap #$_elevatedTaps');
    });
  }

  void _bumpOutlined() {
    setState(() {
      _outlinedTaps += 1;
      _record('outlined', 'tap #$_outlinedTaps');
    });
  }

  void _record(String kind, String detail) {
    _log.insert(0, _WscEvent(kind, detail));
    if (_log.length > _kLogLimit) {
      _log.removeRange(_kLogLimit, _log.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[Wsc] home build — states=${_liveStates.toList()}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _kShell,
        foregroundColor: _kMossDark,
        elevation: 0,
        title: const Text(
          'Chameleon Terrarium — WidgetStateColor Deep Demo',
          style: TextStyle(
            color: _kMossDark,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _WscBadge(
              label: _disabled ? 'DISABLED' : 'LIVE',
              color: _disabled ? _kSkinDim : _kMossLight,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: <Widget>[
          const _WscSectionHeader(
            eyebrow: 'DOSSIER',
            title: 'What is WidgetStateColor?',
            blurb:
                'A Color that knows the current WidgetState set. Feed it to any '
                'Color-typed field; widgets that understand WidgetStateProperty '
                'will call resolve(states).',
          ),
          const SizedBox(height: 10),
          const _WscDossier(),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'ANATOMY',
            title: 'Hierarchy, factories, resolve',
            blurb:
                'WidgetStateColor extends Color and implements '
                'WidgetStateProperty<Color>. Two factories produce concrete '
                'instances: resolveWith() and fromMap().',
          ),
          const SizedBox(height: 10),
          const _WscAnatomy(),
          const SizedBox(height: 18),
          _WscSectionHeader(
            eyebrow: 'LIVE TILE',
            title: 'Hover, press, toggle — the chameleon shifts',
            blurb:
                'One real WidgetStateColor drives the chameleon skin. The '
                'resolved color is painted onto the terrarium below. Current '
                'state set: ${_formatStates(_liveStates)}.',
          ),
          const SizedBox(height: 10),
          _WscChameleonTile(
            states: _liveStates,
            skin: liveSkin,
            tongueCtrl: _tongueCtrl,
            onHover: _setHovered,
            onPressedChanged: _setPressed,
            onTap: _flickTongue,
          ),
          const SizedBox(height: 12),
          _WscStateToggles(
            focused: _focused,
            disabled: _disabled,
            selected: _selected,
            error: _error,
            dragged: _dragged,
            onFocus: _toggleFocus,
            onDisabled: _toggleDisabled,
            onSelected: _toggleSelected,
            onError: _toggleError,
            onDragged: _toggleDragged,
          ),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'CONSTRUCTORS',
            title: 'fromMap vs resolveWith',
            blurb:
                'Two equivalent chameleon skins, built with different '
                'constructors. fromMap is declarative; resolveWith is '
                'procedural.',
          ),
          const SizedBox(height: 10),
          _WscFromMapVsResolveWith(
            states: _liveStates,
            resolveWithSkin: liveSkin,
            mapSkin: mapSkin,
          ),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'SWATCH GRID',
            title: 'One skin, nine pinned state sets',
            blurb:
                'Every tile in the grid resolves the SAME WidgetStateColor '
                'against a different pinned state set. No interaction; just '
                'direct resolve() calls.',
          ),
          const SizedBox(height: 10),
          _WscSwatchGrid(skin: liveSkin),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'BUTTON THEMES',
            title: 'Real buttons, real state properties',
            blurb:
                'Each button below is themed with '
                'WidgetStateColor.resolveWith(...) and responds to pointer '
                'state through the framework, not through local booleans.',
          ),
          const SizedBox(height: 10),
          _WscButtonShowcase(
            filledTaps: _filledTaps,
            elevatedTaps: _elevatedTaps,
            outlinedTaps: _outlinedTaps,
            onFilled: _bumpFilled,
            onElevated: _bumpElevated,
            onOutlined: _bumpOutlined,
          ),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'ANIMATED GRADIENT',
            title: 'Color blending with an AnimationController',
            blurb:
                'A WidgetStateColor resolves a target color; an '
                'AnimationController blends between that target and a second '
                'anchor color on a 4-second loop.',
          ),
          const SizedBox(height: 10),
          _WscAnimatedGradient(
            states: _liveStates,
            skin: liveSkin,
            controller: _blendCtrl,
          ),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'RECIPES',
            title: 'Five ready-to-paste patterns',
            blurb:
                'Compact cards, each a self-contained recipe using '
                'WidgetStateColor for a production concern.',
          ),
          const SizedBox(height: 10),
          const _WscRecipes(),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'COMPARISON',
            title: 'WidgetStateColor vs the alternatives',
            blurb:
                'How WidgetStateColor stacks up against MaterialStateColor, '
                'plain Color, and WidgetStateProperty<Color>.',
          ),
          const SizedBox(height: 10),
          const _WscComparison(),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'EVENT LOG',
            title: 'Recent interactions',
            blurb:
                'Insertion-ordered ring buffer. Newest events appear at the '
                'top; older events fade into the paper.',
          ),
          const SizedBox(height: 10),
          _WscEventLog(events: _log),
          const SizedBox(height: 18),
          const _WscSectionHeader(
            eyebrow: 'GLOSSARY',
            title: 'Terms you will meet in the source',
            blurb:
                'Plain-English definitions for every symbol touched above.',
          ),
          const SizedBox(height: 10),
          const _WscGlossary(),
          const SizedBox(height: 18),
          const _WscEpilogue(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

String _formatStates(Set<WidgetState> s) {
  if (s.isEmpty) return '{} (idle)';
  final List<String> parts = s.map((WidgetState e) => e.name).toList();
  parts.sort();
  return '{${parts.join(", ")}}';
}

// ---------------------------------------------------------------------------
// Log record. The harness never stores anything to disk; the log lives
// entirely in _WscHomeState memory.
// ---------------------------------------------------------------------------
class _WscEvent {
  const _WscEvent(this.kind, this.detail);
  final String kind;
  final String detail;
}

// ---------------------------------------------------------------------------
// _WscSectionHeader — consistent header block used between sections. The
// eyebrow is a small uppercase label; the title is the main heading; the
// blurb is one or two sentences of rationale. All three degrade gracefully
// if the string is long.
// ---------------------------------------------------------------------------
class _WscSectionHeader extends StatelessWidget {
  const _WscSectionHeader({
    required this.eyebrow,
    required this.title,
    required this.blurb,
  });

  final String eyebrow;
  final String title;
  final String blurb;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 18,
              decoration: BoxDecoration(
                color: _kMossDark,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              eyebrow,
              style: const TextStyle(
                color: _kMossDark,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: _kInk,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          blurb,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _WscBadge — small pill used in the app bar to signal LIVE vs DISABLED.
// ---------------------------------------------------------------------------
class _WscBadge extends StatelessWidget {
  const _WscBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscDossier — six preamble cards that introduce WidgetStateColor without
// demanding that the reader understand WidgetStateProperty yet.
// ---------------------------------------------------------------------------
class _WscDossier extends StatelessWidget {
  const _WscDossier();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const <Widget>[
        _WscDossierCard(
          icon: Icons.color_lens_outlined,
          title: 'A Color that listens',
          body:
              'WidgetStateColor is-a Color and is-a WidgetStateProperty<Color>. '
              'One instance can be passed anywhere a Color or a '
              'WidgetStateProperty<Color> is expected.',
        ),
        _WscDossierCard(
          icon: Icons.functions,
          title: 'resolve(states) is the contract',
          body:
              'The single abstract method is Color resolve(Set<WidgetState> '
              'states). Widgets that understand the protocol call it every '
              'time their interaction state changes.',
        ),
        _WscDossierCard(
          icon: Icons.lightbulb_outline,
          title: 'Two factories',
          body:
              'resolveWith((states) => ...) for procedural logic; fromMap({...}) '
              'for declarative maps keyed by WidgetStatesConstraint.',
        ),
        _WscDossierCard(
          icon: Icons.palette_outlined,
          title: 'Color subclass trick',
          body:
              'Because WidgetStateColor extends Color, non-stateful code that '
              'reads .value still works; it just sees the default color baked '
              'into the super constructor.',
        ),
        _WscDossierCard(
          icon: Icons.star_border,
          title: 'Symmetric with WidgetState',
          body:
              'The companion enum WidgetState declares hovered, focused, '
              'pressed, dragged, selected, scrolledUnder, disabled, and error. '
              'WidgetState.any is a catch-all constraint.',
        ),
        _WscDossierCard(
          icon: Icons.auto_awesome_outlined,
          title: 'Drop-in for ButtonStyle',
          body:
              'ButtonStyle.backgroundColor, foregroundColor, overlayColor, '
              'IconButton.overlayColor, Switch.trackColor — every one of '
              'these takes a WidgetStateColor happily.',
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _WscDossierCard — small rounded rect with an icon, a title, and a body.
// Width is responsive via Wrap; each card fits three per row on wide
// viewports, two on medium, one on narrow.
// ---------------------------------------------------------------------------
class _WscDossierCard extends StatelessWidget {
  const _WscDossierCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 230,
        maxWidth: 320,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kShell,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kStroke, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: _kMossDark, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscAnatomy — renders the class hierarchy diagram, the factory list,
// the resolve() signature, and a boxed "gotcha" card.
// ---------------------------------------------------------------------------
class _WscAnatomy extends StatelessWidget {
  const _WscAnatomy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _WscAnatomyHierarchy(),
        SizedBox(height: 10),
        _WscAnatomyFactories(),
        SizedBox(height: 10),
        _WscAnatomyGotcha(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _WscAnatomyHierarchy — ASCII-style diagram rendered with styled rows.
// ---------------------------------------------------------------------------
class _WscAnatomyHierarchy extends StatelessWidget {
  const _WscAnatomyHierarchy();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Class hierarchy',
            style: TextStyle(
              color: _kMossDark,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          _hRow('Object', 0, false),
          _hRow('└─ Color', 1, false),
          _hRow('   └─ WidgetStateColor  (abstract)', 2, true),
          _hRow('      ├─ _WidgetStateColor        (from resolveWith)', 3, false),
          _hRow('      ├─ _WidgetStateColorMapper  (from fromMap)', 3, false),
          _hRow('      └─ _WidgetStateColorTransparent (static .transparent)', 3, false),
          const SizedBox(height: 10),
          const Text(
            'Implements: WidgetStateProperty<Color>',
            style: TextStyle(
              color: _kInkSoft,
              fontFamily: 'monospace',
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Abstract method: Color resolve(Set<WidgetState> states)',
            style: TextStyle(
              color: _kInkSoft,
              fontFamily: 'monospace',
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _hRow(String text, int indent, bool highlight) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 8.0, top: 2, bottom: 2),
      child: Text(
        text,
        style: TextStyle(
          color: highlight ? _kMossDark : _kInk,
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: highlight ? FontWeight.w800 : FontWeight.w500,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscAnatomyFactories — two side-by-side signature cards.
// ---------------------------------------------------------------------------
class _WscAnatomyFactories extends StatelessWidget {
  const _WscAnatomyFactories();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: _sigCard(
            'resolveWith',
            'factory WidgetStateColor.resolveWith(\n'
                '  WidgetPropertyResolver<Color> callback,\n'
                ')',
            'Callback shape: Color Function(Set<WidgetState>). The callback '
                'is invoked once with the empty set to seed the Color '
                'superclass default, then again on every resolve() call.',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _sigCard(
            'fromMap',
            'const factory WidgetStateColor.fromMap(\n'
                '  WidgetStateMap<Color> map,\n'
                ')',
            'Map shape: Map<WidgetStatesConstraint, Color>. Constraints are '
                'tried in insertion order; first match wins. Use '
                'WidgetState.any as the last key for a total function.',
          ),
        ),
      ],
    );
  }

  Widget _sigCard(String title, String sig, String note) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kHighlight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _kMossDark,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            sig,
            style: const TextStyle(
              color: _kInk,
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            note,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscAnatomyGotcha — the "reads as default" warning card.
// ---------------------------------------------------------------------------
class _WscAnatomyGotcha extends StatelessWidget {
  const _WscAnatomyGotcha();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSkinGlow.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSkinHot, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Icon(Icons.warning_amber_outlined, color: _kSkinHot, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Gotcha: raw ARGB reads return the default',
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'If your code does skin.value or skin.red, you get the '
                  'color baked into the super-constructor call — NOT the '
                  'state-specific color. Interactive code must go through '
                  'skin.resolve(states). This is intentional: it lets the '
                  'same object behave sensibly in both APIs.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
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

// ---------------------------------------------------------------------------
// _WscChameleonTile — the headline live demo. A MouseRegion + Listener
// wrap a Stack; the Stack contains the CustomPainter terrarium below and
// the painted chameleon above. The chameleon's skin color is supplied by
// the caller; we don't recompute it here so the tile is testable with
// any WidgetStateColor.
// ---------------------------------------------------------------------------
class _WscChameleonTile extends StatelessWidget {
  const _WscChameleonTile({
    required this.states,
    required this.skin,
    required this.tongueCtrl,
    required this.onHover,
    required this.onPressedChanged,
    required this.onTap,
  });

  final Set<WidgetState> states;
  final WidgetStateColor skin;
  final AnimationController tongueCtrl;
  final ValueChanged<bool> onHover;
  final ValueChanged<bool> onPressedChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color resolved = skin.resolve(states);
    final bool disabled = states.contains(WidgetState.disabled);
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kStroke, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.pets_outlined,
                color: _kMossDark,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Live chameleon — hover / press / tap',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              _WscColorChip(color: resolved, label: 'resolved'),
            ],
          ),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: disabled
                ? SystemMouseCursors.forbidden
                : SystemMouseCursors.click,
            onEnter: disabled ? null : (_) => onHover(true),
            onExit: disabled ? null : (_) => onHover(false),
            child: Listener(
              onPointerDown: disabled ? null : (_) => onPressedChanged(true),
              onPointerUp: disabled ? null : (_) {
                onPressedChanged(false);
                onTap();
              },
              onPointerCancel: disabled ? null : (_) => onPressedChanged(false),
              child: SizedBox(
                height: 260,
                child: AnimatedBuilder(
                  animation: tongueCtrl,
                  builder: (BuildContext context, Widget? child) {
                    return CustomPaint(
                      painter: _WscTerrariumPainter(
                        skinColor: resolved,
                        tongueProgress: tongueCtrl.value,
                        disabled: disabled,
                        pressed: states.contains(WidgetState.pressed),
                        hovered: states.contains(WidgetState.hovered),
                      ),
                      child: const SizedBox.expand(),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _WscStateChips(states: states),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscTerrariumPainter — the big CustomPainter. Paints (back-to-front):
//   1. Glass tank bevel
//   2. Sandy floor + pebbles
//   3. Mossy rocks on the left
//   4. Leafy foliage on the right
//   5. Branch diagonally across
//   6. Chameleon body on the branch (uses skinColor)
//   7. Chameleon tongue (tongueProgress in [0,1])
// Every value is deterministic given the input size — no random jitter
// after construction, so layout is stable between frames.
// ---------------------------------------------------------------------------
class _WscTerrariumPainter extends CustomPainter {
  _WscTerrariumPainter({
    required this.skinColor,
    required this.tongueProgress,
    required this.disabled,
    required this.pressed,
    required this.hovered,
  });

  final Color skinColor;
  final double tongueProgress;
  final bool disabled;
  final bool pressed;
  final bool hovered;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;

    // 1 — glass tank background and bevel.
    final Paint glass = Paint()
      ..shader = ui.Gradient.linear(
        bounds.topLeft,
        bounds.bottomRight,
        <Color>[_kGlass, _kCream, _kGlass],
        <double>[0.0, 0.55, 1.0],
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bounds.deflate(2), const Radius.circular(12)),
      glass,
    );

    final Paint rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = _kGlassRim;
    canvas.drawRRect(
      RRect.fromRectAndRadius(bounds.deflate(3), const Radius.circular(12)),
      rim,
    );

    // Inner bevel highlight across the top.
    final Paint bevel = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(bounds.left + 10, bounds.top + 8),
      Offset(bounds.right - 10, bounds.top + 8),
      bevel,
    );

    // 2 — sandy floor. Painted as a gentle dune curve so the rocks sit
    // on something believable.
    final double floorY = size.height * 0.78;
    final Path sand = Path()
      ..moveTo(bounds.left, floorY)
      ..quadraticBezierTo(
        size.width * 0.35,
        floorY - 14,
        size.width * 0.62,
        floorY + 4,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        floorY + 16,
        bounds.right,
        floorY - 6,
      )
      ..lineTo(bounds.right, bounds.bottom)
      ..lineTo(bounds.left, bounds.bottom)
      ..close();
    final Paint sandFill = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, floorY),
        Offset(0, bounds.bottom),
        <Color>[_kSand, _kSandDeep],
      );
    canvas.drawPath(sand, sandFill);

    // Sprinkled pebbles. The positions use a deterministic pseudo-random
    // walk keyed off the loop index, so they stay put across rebuilds.
    final math.Random pebRng = math.Random(1337);
    for (int i = 0; i < 26; i++) {
      final double px = pebRng.nextDouble() * size.width;
      final double jitter = (pebRng.nextDouble() - 0.5) * 12;
      final double py = floorY + 6 + pebRng.nextDouble() * (size.height - floorY - 10);
      final double pr = 1.5 + pebRng.nextDouble() * 3.0;
      canvas.drawCircle(
        Offset(px, py + jitter),
        pr,
        Paint()..color = _kSandDeep.withValues(alpha: 0.55),
      );
    }

    // 3 — mossy rocks, left cluster.
    _drawRock(canvas, Offset(size.width * 0.12, floorY - 4), 32, 18);
    _drawRock(canvas, Offset(size.width * 0.22, floorY - 10), 22, 14);
    _drawRock(canvas, Offset(size.width * 0.06, floorY + 4), 24, 12);

    // 4 — foliage, right cluster. A handful of overlapping leaves fan
    // out from the back corner.
    _drawLeafCluster(canvas, Offset(size.width * 0.82, size.height * 0.32));
    _drawLeafCluster(canvas, Offset(size.width * 0.90, size.height * 0.55));
    _drawLeafCluster(canvas, Offset(size.width * 0.72, size.height * 0.22));

    // 5 — branch.
    final Path branch = Path()
      ..moveTo(size.width * 0.10, size.height * 0.62)
      ..cubicTo(
        size.width * 0.32, size.height * 0.40,
        size.width * 0.58, size.height * 0.50,
        size.width * 0.82, size.height * 0.30,
      );
    final Paint branchFill = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 18
      ..color = _kBranchDark;
    canvas.drawPath(branch, branchFill);
    final Paint branchHi = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8
      ..color = _kBranchLight;
    canvas.drawPath(branch, branchHi);

    // 6 — chameleon body, drawn on the branch.
    _drawChameleon(canvas, size);

    // 7 — tongue flick on top of everything.
    if (tongueProgress > 0.001) {
      _drawTongue(canvas, size);
    }

    // Optional hover halo.
    if (hovered && !disabled) {
      final Paint halo = Paint()
        ..color = skinColor.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(_chameleonHead(size), 36, halo);
    }
  }

  void _drawRock(Canvas canvas, Offset center, double rx, double ry) {
    final Paint rockFill = Paint()..color = _kMossDark;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      rockFill,
    );
    final Paint mossFill = Paint()..color = _kMossLight;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - ry * 0.6),
        width: rx * 1.6,
        height: ry * 0.8,
      ),
      mossFill,
    );
    // speckles
    final math.Random rng = math.Random(center.dx.toInt() + center.dy.toInt());
    for (int i = 0; i < 6; i++) {
      final double sx = center.dx + (rng.nextDouble() - 0.5) * rx * 1.4;
      final double sy = center.dy + (rng.nextDouble() - 0.6) * ry * 1.1;
      canvas.drawCircle(
        Offset(sx, sy),
        1.1,
        Paint()..color = _kLeafDark.withValues(alpha: 0.7),
      );
    }
  }

  void _drawLeafCluster(Canvas canvas, Offset anchor) {
    for (int i = 0; i < 5; i++) {
      final double angle = -math.pi / 2 + (i - 2) * 0.35;
      final double len = 34 + (i.isEven ? 4 : 0);
      final Offset tip = Offset(
        anchor.dx + math.cos(angle) * len,
        anchor.dy + math.sin(angle) * len,
      );
      _drawLeaf(canvas, anchor, tip, i.isEven ? _kLeafLight : _kLeafDark);
    }
  }

  void _drawLeaf(Canvas canvas, Offset base, Offset tip, Color fill) {
    final Offset mid = Offset(
      (base.dx + tip.dx) / 2,
      (base.dy + tip.dy) / 2,
    );
    final double dx = tip.dx - base.dx;
    final double dy = tip.dy - base.dy;
    final double len = math.sqrt(dx * dx + dy * dy);
    if (len < 0.001) return;
    final Offset norm = Offset(-dy / len, dx / len);
    final double w = 10;
    final Path p = Path()
      ..moveTo(base.dx, base.dy)
      ..quadraticBezierTo(
        mid.dx + norm.dx * w,
        mid.dy + norm.dy * w,
        tip.dx,
        tip.dy,
      )
      ..quadraticBezierTo(
        mid.dx - norm.dx * w,
        mid.dy - norm.dy * w,
        base.dx,
        base.dy,
      )
      ..close();
    canvas.drawPath(p, Paint()..color = fill);
    // spine
    canvas.drawLine(
      base,
      tip,
      Paint()
        ..color = _kLeafDark.withValues(alpha: 0.6)
        ..strokeWidth = 1.2,
    );
  }

  Offset _chameleonBody(Size size) =>
      Offset(size.width * 0.52, size.height * 0.48);

  Offset _chameleonHead(Size size) =>
      Offset(size.width * 0.64, size.height * 0.40);

  void _drawChameleon(Canvas canvas, Size size) {
    final Offset body = _chameleonBody(size);
    final Offset head = _chameleonHead(size);

    // Curled tail trailing off the branch.
    final Path tail = Path()
      ..moveTo(body.dx - 30, body.dy + 4)
      ..cubicTo(
        body.dx - 60, body.dy - 8,
        body.dx - 72, body.dy + 22,
        body.dx - 52, body.dy + 28,
      );
    canvas.drawPath(
      tail,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 9
        ..color = skinColor,
    );
    // Tail highlight.
    canvas.drawPath(
      tail,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3
        ..color = Colors.white.withValues(alpha: 0.22),
    );

    // Body — an elongated oval.
    final Rect bodyRect = Rect.fromCenter(
      center: body,
      width: 96,
      height: 42,
    );
    canvas.drawOval(bodyRect, Paint()..color = skinColor);

    // Belly highlight.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(body.dx, body.dy + 8),
        width: 70,
        height: 14,
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.14),
    );

    // Back crest — triangular scales along the top.
    final Path crest = Path();
    for (int i = 0; i < 7; i++) {
      final double t = i / 6;
      final double cx = body.dx - 38 + t * 76;
      final double cy = body.dy - 21 - (i.isEven ? 6 : 2);
      crest.addPolygon(<Offset>[
        Offset(cx, cy),
        Offset(cx + 6, body.dy - 18),
        Offset(cx - 6, body.dy - 18),
      ], true);
    }
    canvas.drawPath(crest, Paint()..color = _darken(skinColor, 0.25));

    // Two legs visible.
    final Paint legPaint = Paint()
      ..color = _darken(skinColor, 0.15)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;
    canvas.drawLine(
      Offset(body.dx - 16, body.dy + 14),
      Offset(body.dx - 22, body.dy + 34),
      legPaint,
    );
    canvas.drawLine(
      Offset(body.dx + 18, body.dy + 14),
      Offset(body.dx + 22, body.dy + 36),
      legPaint,
    );

    // Head.
    canvas.drawOval(
      Rect.fromCenter(center: head, width: 46, height: 36),
      Paint()..color = skinColor,
    );
    // Horned ridge on the back of the head.
    final Path ridge = Path()
      ..moveTo(head.dx - 10, head.dy - 14)
      ..lineTo(head.dx - 18, head.dy - 22)
      ..lineTo(head.dx - 2, head.dy - 16)
      ..close();
    canvas.drawPath(ridge, Paint()..color = _darken(skinColor, 0.3));

    // Eye — a big turret.
    final Offset eye = Offset(head.dx + 6, head.dy - 6);
    canvas.drawCircle(eye, 9, Paint()..color = _darken(skinColor, 0.1));
    canvas.drawCircle(eye, 6, Paint()..color = _kCream);
    canvas.drawCircle(
      Offset(eye.dx + (hovered ? 2 : 0), eye.dy),
      3,
      Paint()..color = _kInk,
    );
    canvas.drawCircle(
      Offset(eye.dx + (hovered ? 2 : 0) - 1, eye.dy - 1),
      1,
      Paint()..color = _kCream,
    );

    // Mouth — a small arc, grinning wider when pressed.
    final Rect mouthRect = Rect.fromCenter(
      center: Offset(head.dx + 14, head.dy + 6),
      width: 14,
      height: pressed ? 10 : 4,
    );
    canvas.drawArc(
      mouthRect,
      0,
      math.pi,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = _kInk,
    );

    // Disabled wash — grey veil on top.
    if (disabled) {
      canvas.drawOval(
        bodyRect,
        Paint()..color = _kSkinDim.withValues(alpha: 0.4),
      );
    }
  }

  void _drawTongue(Canvas canvas, Size size) {
    final Offset head = _chameleonHead(size);
    final double reach = 70 * _easeOutBack(tongueProgress);
    final Offset tip = Offset(head.dx + 24 + reach, head.dy + 2);
    final Paint tongue = Paint()
      ..color = const Color(0xFFE35B7A)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    canvas.drawLine(Offset(head.dx + 20, head.dy + 6), tip, tongue);
    canvas.drawCircle(tip, 5, Paint()..color = const Color(0xFFE35B7A));
    canvas.drawCircle(
      Offset(tip.dx - 1, tip.dy - 1),
      1.5,
      Paint()..color = Colors.white.withValues(alpha: 0.7),
    );
  }

  double _easeOutBack(double t) {
    const double c1 = 1.70158;
    const double c3 = c1 + 1.0;
    final double x = t - 1;
    return 1 + c3 * x * x * x + c1 * x * x;
  }

  Color _darken(Color c, double amount) {
    final double r = (c.r * 255.0 * (1 - amount)).clamp(0.0, 255.0);
    final double g = (c.g * 255.0 * (1 - amount)).clamp(0.0, 255.0);
    final double b = (c.b * 255.0 * (1 - amount)).clamp(0.0, 255.0);
    return Color.fromARGB(
      (c.a * 255.0).round(),
      r.round(),
      g.round(),
      b.round(),
    );
  }

  @override
  bool shouldRepaint(covariant _WscTerrariumPainter old) {
    return old.skinColor != skinColor ||
        old.tongueProgress != tongueProgress ||
        old.disabled != disabled ||
        old.pressed != pressed ||
        old.hovered != hovered;
  }
}

// ---------------------------------------------------------------------------
// _WscColorChip — a little pill showing a swatch and its label. Used in
// chips, swatch grid, and the tile.
// ---------------------------------------------------------------------------
class _WscColorChip extends StatelessWidget {
  const _WscColorChip({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kHighlight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kStroke, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: _kInk, width: 0.6),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _kInk,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscStateChips — horizontal wrap of the currently-active states. Idle
// is rendered as a muted chip so the row is never empty.
// ---------------------------------------------------------------------------
class _WscStateChips extends StatelessWidget {
  const _WscStateChips({required this.states});

  final Set<WidgetState> states;

  @override
  Widget build(BuildContext context) {
    final List<WidgetState> ordered = states.toList()
      ..sort((WidgetState a, WidgetState b) => a.name.compareTo(b.name));
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        if (ordered.isEmpty)
          const _WscInlineChip(label: 'idle (empty set)', color: _kMossLight),
        for (final WidgetState s in ordered)
          _WscInlineChip(label: s.name, color: _colorForState(s)),
      ],
    );
  }

  static Color _colorForState(WidgetState s) {
    switch (s) {
      case WidgetState.hovered:
        return _kSkinHot;
      case WidgetState.pressed:
        return _kSkinGlow;
      case WidgetState.focused:
        return _kSkinFocus;
      case WidgetState.disabled:
        return _kSkinDim;
      case WidgetState.error:
        return _kSkinError;
      case WidgetState.selected:
        return _kMossLight;
      case WidgetState.dragged:
        return _kBranchLight;
      case WidgetState.scrolledUnder:
        return _kSandDeep;
    }
  }
}

class _WscInlineChip extends StatelessWidget {
  const _WscInlineChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _darken(color),
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static Color _darken(Color c) {
    final double r = (c.r * 255.0 * 0.45).clamp(0.0, 255.0);
    final double g = (c.g * 255.0 * 0.45).clamp(0.0, 255.0);
    final double b = (c.b * 255.0 * 0.45).clamp(0.0, 255.0);
    return Color.fromARGB(255, r.round(), g.round(), b.round());
  }
}

// ---------------------------------------------------------------------------
// _WscStateToggles — five toggle buttons that flip WidgetState booleans
// in _WscHomeState.
// ---------------------------------------------------------------------------
class _WscStateToggles extends StatelessWidget {
  const _WscStateToggles({
    required this.focused,
    required this.disabled,
    required this.selected,
    required this.error,
    required this.dragged,
    required this.onFocus,
    required this.onDisabled,
    required this.onSelected,
    required this.onError,
    required this.onDragged,
  });

  final bool focused;
  final bool disabled;
  final bool selected;
  final bool error;
  final bool dragged;
  final VoidCallback onFocus;
  final VoidCallback onDisabled;
  final VoidCallback onSelected;
  final VoidCallback onError;
  final VoidCallback onDragged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        _toggle('focused', focused, onFocus),
        _toggle('disabled', disabled, onDisabled),
        _toggle('selected', selected, onSelected),
        _toggle('error', error, onError),
        _toggle('dragged', dragged, onDragged),
      ],
    );
  }

  Widget _toggle(String label, bool on, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: on ? _kMossDark : _kShell,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kStroke, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              on ? Icons.check_box_outlined : Icons.check_box_outline_blank,
              size: 16,
              color: on ? _kCream : _kInkSoft,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: on ? _kCream : _kInk,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscFromMapVsResolveWith — side-by-side cards showing the two
// constructor styles producing equivalent behaviour.
// ---------------------------------------------------------------------------
class _WscFromMapVsResolveWith extends StatelessWidget {
  const _WscFromMapVsResolveWith({
    required this.states,
    required this.resolveWithSkin,
    required this.mapSkin,
  });

  final Set<WidgetState> states;
  final WidgetStateColor resolveWithSkin;
  final WidgetStateColor mapSkin;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: _constructorCard(
            title: 'resolveWith (procedural)',
            code: "WidgetStateColor.resolveWith(\n"
                "  (states) {\n"
                "    if (states.contains(WidgetState.disabled))\n"
                "      return dim;\n"
                "    if (states.contains(WidgetState.pressed))\n"
                "      return glow;\n"
                "    if (states.contains(WidgetState.hovered))\n"
                "      return hot;\n"
                "    return base;\n"
                "  },\n"
                ")",
            resolved: resolveWithSkin.resolve(states),
            stripe: resolveWithSkin.resolve(states),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _constructorCard(
            title: 'fromMap (declarative)',
            code: "WidgetStateColor.fromMap({\n"
                "  WidgetState.disabled: dim,\n"
                "  WidgetState.error: err,\n"
                "  WidgetState.pressed: glow,\n"
                "  WidgetState.hovered: hot,\n"
                "  WidgetState.focused: focus,\n"
                "  WidgetState.selected: light,\n"
                "  WidgetState.any: base,\n"
                "})",
            resolved: mapSkin.resolve(states),
            stripe: mapSkin.resolve(states),
          ),
        ),
      ],
    );
  }

  Widget _constructorCard({
    required String title,
    required String code,
    required Color resolved,
    required Color stripe,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _kShell,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: stripe,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: _kInk,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  code,
                  style: const TextStyle(
                    color: _kInk,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const Text(
                      'resolved →',
                      style: TextStyle(
                        color: _kInkSoft,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: resolved,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: _kInk, width: 0.8),
                      ),
                    ),
                  ],
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
// _WscSwatchGrid — 3x3 grid of pinned state sets, each using the same
// WidgetStateColor to render the background of a small card.
// ---------------------------------------------------------------------------
class _WscSwatchGrid extends StatelessWidget {
  const _WscSwatchGrid({required this.skin});

  final WidgetStateColor skin;

  static const List<_SwatchPin> _pins = <_SwatchPin>[
    _SwatchPin('idle', <WidgetState>{}),
    _SwatchPin('hovered', <WidgetState>{WidgetState.hovered}),
    _SwatchPin('pressed', <WidgetState>{WidgetState.pressed}),
    _SwatchPin('hover+press', <WidgetState>{
      WidgetState.hovered,
      WidgetState.pressed,
    }),
    _SwatchPin('focused', <WidgetState>{WidgetState.focused}),
    _SwatchPin('disabled', <WidgetState>{WidgetState.disabled}),
    _SwatchPin('selected', <WidgetState>{WidgetState.selected}),
    _SwatchPin('error', <WidgetState>{WidgetState.error}),
    _SwatchPin('dragged', <WidgetState>{WidgetState.dragged}),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.8,
      children: <Widget>[
        for (final _SwatchPin pin in _pins)
          _SwatchTile(pin: pin, color: skin.resolve(pin.states)),
      ],
    );
  }
}

class _SwatchPin {
  const _SwatchPin(this.label, this.states);
  final String label;
  final Set<WidgetState> states;
}

class _SwatchTile extends StatelessWidget {
  const _SwatchTile({required this.pin, required this.color});

  final _SwatchPin pin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kInk.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            pin.label,
            style: const TextStyle(
              color: _kInk,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            '#${_hex(color)}',
            style: const TextStyle(
              color: _kInk,
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  static String _hex(Color c) {
    String two(int v) => v.toRadixString(16).padLeft(2, '0').toUpperCase();
    final int r = (c.r * 255.0).round();
    final int g = (c.g * 255.0).round();
    final int b = (c.b * 255.0).round();
    return two(r) + two(g) + two(b);
  }
}

// ---------------------------------------------------------------------------
// _WscButtonShowcase — three Material buttons, each styled with a real
// WidgetStateColor.resolveWith call. Counters under each button confirm
// that taps reach the callback.
// ---------------------------------------------------------------------------
class _WscButtonShowcase extends StatelessWidget {
  const _WscButtonShowcase({
    required this.filledTaps,
    required this.elevatedTaps,
    required this.outlinedTaps,
    required this.onFilled,
    required this.onElevated,
    required this.onOutlined,
  });

  final int filledTaps;
  final int elevatedTaps;
  final int outlinedTaps;
  final VoidCallback onFilled;
  final VoidCallback onElevated;
  final VoidCallback onOutlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: <Widget>[
          _ButtonColumn(
            label: 'FilledButton',
            taps: filledTaps,
            button: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.disabled)) return _kSkinDim;
                  if (states.contains(WidgetState.pressed)) return _kMossDark;
                  if (states.contains(WidgetState.hovered)) return _kSkinHot;
                  return _kMossLight;
                }),
                foregroundColor: WidgetStateColor.resolveWith(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return _kInkSoft;
                    }
                    return _kInk;
                  },
                ),
              ),
              onPressed: onFilled,
              child: const Text('Eat a fly'),
            ),
          ),
          _ButtonColumn(
            label: 'ElevatedButton',
            taps: elevatedTaps,
            button: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.disabled)) return _kSkinDim;
                  if (states.contains(WidgetState.pressed)) return _kSkinGlow;
                  if (states.contains(WidgetState.hovered)) return _kSkinHot;
                  return _kShell;
                }),
                foregroundColor: const WidgetStatePropertyAll<Color>(_kInk),
              ),
              onPressed: onElevated,
              child: const Text('Change branch'),
            ),
          ),
          _ButtonColumn(
            label: 'OutlinedButton',
            taps: outlinedTaps,
            button: OutlinedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateColor.resolveWith((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.disabled)) return _kSkinDim;
                  if (states.contains(WidgetState.pressed)) return _kSkinGlow;
                  if (states.contains(WidgetState.hovered)) return _kSkinHot;
                  return _kMossDark;
                }),
                side: WidgetStateProperty.resolveWith<BorderSide>((
                  Set<WidgetState> states,
                ) {
                  Color c = _kMossDark;
                  if (states.contains(WidgetState.disabled)) c = _kSkinDim;
                  if (states.contains(WidgetState.pressed)) c = _kSkinGlow;
                  if (states.contains(WidgetState.hovered)) c = _kSkinHot;
                  return BorderSide(color: c, width: 1.4);
                }),
              ),
              onPressed: onOutlined,
              child: const Text('Blink slowly'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonColumn extends StatelessWidget {
  const _ButtonColumn({
    required this.label,
    required this.taps,
    required this.button,
  });

  final String label;
  final int taps;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _kMossDark,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        button,
        const SizedBox(height: 6),
        Text(
          'taps: $taps',
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _WscAnimatedGradient — takes the live state set and blends its
// resolved color with a slow-oscillating companion color using an
// AnimationController. This shows that a WidgetStateColor can serve as
// one endpoint of a Color.lerp without any special plumbing.
// ---------------------------------------------------------------------------
class _WscAnimatedGradient extends StatelessWidget {
  const _WscAnimatedGradient({
    required this.states,
    required this.skin,
    required this.controller,
  });

  final Set<WidgetState> states;
  final WidgetStateColor skin;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final double t = Curves.easeInOut.transform(controller.value);
          final Color a = skin.resolve(states);
          final Color b = Color.lerp(_kLeafLight, _kLeafDark, t) ?? _kLeafLight;
          final Color mid = Color.lerp(a, b, t) ?? a;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _WscColorChip(color: a, label: 'skin'),
                  const SizedBox(width: 6),
                  _WscColorChip(color: b, label: 'anchor'),
                  const SizedBox(width: 6),
                  _WscColorChip(color: mid, label: 'blend'),
                  const Spacer(),
                  Text(
                    't=${t.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: <Color>[a, mid, b],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscRecipes — five boxed recipe cards. Each card has a tiny live
// example and a compact code block.
// ---------------------------------------------------------------------------
class _WscRecipes extends StatelessWidget {
  const _WscRecipes();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _WscRecipeCard(
          index: 1,
          title: 'Input-field border color',
          body:
              'Border changes hue when the field is focused or in an error '
              'state. One WidgetStateColor wraps the conditional logic.',
          code:
              "InputDecoration(\n"
              "  enabledBorder: OutlineInputBorder(\n"
              "    borderSide: BorderSide(\n"
              "      color: WidgetStateColor.resolveWith((s) {\n"
              "        if (s.contains(WidgetState.error)) return red;\n"
              "        if (s.contains(WidgetState.focused)) return cyan;\n"
              "        return grey;\n"
              "      }),\n"
              "    ),\n"
              "  ),\n"
              ")",
        ),
        SizedBox(height: 10),
        _WscRecipeCard(
          index: 2,
          title: 'Hover highlight on a custom card',
          body:
              'A card with a WidgetStateColor background. Wrap in '
              'MouseRegion and translate pointer events into the state set '
              'you pass to resolve().',
          code:
              "final bg = WidgetStateColor.fromMap({\n"
              "  WidgetState.hovered: amber,\n"
              "  WidgetState.any: cream,\n"
              "});\n"
              "// bg.resolve({WidgetState.hovered}) == amber",
        ),
        SizedBox(height: 10),
        _WscRecipeCard(
          index: 3,
          title: 'Error-state warning ring',
          body:
              'Reuse a single WidgetStateColor across BorderSide, text '
              'color, and icon color so every error visual stays in sync.',
          code:
              "final warn = WidgetStateColor.resolveWith(\n"
              "  (s) => s.contains(WidgetState.error)\n"
              "      ? Colors.redAccent\n"
              "      : Colors.transparent,\n"
              ");",
        ),
        SizedBox(height: 10),
        _WscRecipeCard(
          index: 4,
          title: 'Pressed ripple overlay',
          body:
              'Feed a WidgetStateColor to ButtonStyle.overlayColor. The '
              'framework adds pressed/hovered flags as the user interacts.',
          code:
              "ButtonStyle(\n"
              "  overlayColor: WidgetStateColor.resolveWith((s) {\n"
              "    if (s.contains(WidgetState.pressed))\n"
              "      return Colors.black26;\n"
              "    if (s.contains(WidgetState.hovered))\n"
              "      return Colors.black12;\n"
              "    return Colors.transparent;\n"
              "  }),\n"
              ")",
        ),
        SizedBox(height: 10),
        _WscRecipeCard(
          index: 5,
          title: 'Disabled muting for text',
          body:
              'Wrap text in DefaultTextStyle and let a WidgetStateColor '
              'supply the body color so disabled screens dim themselves.',
          code:
              "final ink = WidgetStateColor.resolveWith(\n"
              "  (s) => s.contains(WidgetState.disabled)\n"
              "      ? Colors.grey.shade600\n"
              "      : Colors.black,\n"
              ");",
        ),
      ],
    );
  }
}

class _WscRecipeCard extends StatelessWidget {
  const _WscRecipeCard({
    required this.index,
    required this.title,
    required this.body,
    required this.code,
  });

  final int index;
  final String title;
  final String body;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kShell,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _kMossDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: _kCream,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kStroke, width: 0.6),
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: _kInk,
                fontFamily: 'monospace',
                fontSize: 11.8,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscComparison — four-column table comparing WidgetStateColor with
// plain Color, MaterialStateColor (deprecated alias), and
// WidgetStateProperty<Color>.
// ---------------------------------------------------------------------------
class _WscComparison extends StatelessWidget {
  const _WscComparison();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      child: Column(
        children: const <Widget>[
          _CompareHeader(),
          _CompareRow(
            label: 'Returns per-state color?',
            a: 'yes',
            b: 'yes (alias)',
            c: 'no',
            d: 'yes',
          ),
          _CompareRow(
            label: 'Is-a Color (can be passed to Color fields)?',
            a: 'yes',
            b: 'yes',
            c: 'yes',
            d: 'no',
          ),
          _CompareRow(
            label: 'Implements WidgetStateProperty<Color>?',
            a: 'yes',
            b: 'yes',
            c: 'no',
            d: 'yes',
          ),
          _CompareRow(
            label: 'Reads raw ARGB correctly?',
            a: 'default only',
            b: 'default only',
            c: 'yes',
            d: 'n/a',
          ),
          _CompareRow(
            label: 'Deprecated?',
            a: 'no',
            b: 'yes',
            c: 'no',
            d: 'no',
          ),
          _CompareRow(
            label: 'Factories',
            a: 'resolveWith / fromMap',
            b: 'resolveWith / fromMap',
            c: 'const ctors',
            d: 'resolveWith / all / fromMap',
          ),
        ],
      ),
    );
  }
}

class _CompareHeader extends StatelessWidget {
  const _CompareHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kHighlight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'aspect',
              style: TextStyle(
                color: _kMossDark,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Expanded(child: _HeaderCell('WidgetStateColor')),
          Expanded(child: _HeaderCell('MaterialStateColor')),
          Expanded(child: _HeaderCell('Color')),
          Expanded(child: _HeaderCell('WSProp<Color>')),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: _kInk,
        fontSize: 11.5,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.label,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });
  final String label;
  final String a;
  final String b;
  final String c;
  final String d;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: _kStroke, width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: _cell(a)),
          Expanded(child: _cell(b)),
          Expanded(child: _cell(c)),
          Expanded(child: _cell(d)),
        ],
      ),
    );
  }

  Widget _cell(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: _kInkSoft,
        fontSize: 11.5,
        fontFamily: 'monospace',
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscEventLog — newest-first ring buffer rendered as a paper strip.
// ---------------------------------------------------------------------------
class _WscEventLog extends StatelessWidget {
  const _WscEventLog({required this.events});

  final List<_WscEvent> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: events.isEmpty
          ? const Text(
              '(no events yet — try hovering the chameleon)',
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < events.length; i++)
                  _logRow(events[i], i),
              ],
            ),
    );
  }

  Widget _logRow(_WscEvent e, int i) {
    final double fade = 1.0 - (i / 30.0);
    final double alpha = fade.clamp(0.35, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _kMossLight.withValues(alpha: 0.35 * alpha),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              e.kind,
              style: TextStyle(
                color: _kInk.withValues(alpha: alpha),
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              e.detail,
              style: TextStyle(
                color: _kInkSoft.withValues(alpha: alpha),
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscGlossary — plain-English definitions for every symbol touched.
// ---------------------------------------------------------------------------
class _WscGlossary extends StatelessWidget {
  const _WscGlossary();

  static const List<List<String>> _entries = <List<String>>[
    <String>[
      'WidgetStateColor',
      'Abstract Color subclass that implements WidgetStateProperty<Color>. '
          'Its single abstract method Color resolve(Set<WidgetState>) lets '
          'widgets derive a color from the current interaction state.',
    ],
    <String>[
      'WidgetStateProperty<T>',
      'Interface with a single method T resolve(Set<WidgetState>). Buttons, '
          'switches, chips, and menus read properties through this interface '
          'so they can respond to interaction.',
    ],
    <String>[
      'WidgetState',
      'Enum of interaction states: hovered, focused, pressed, dragged, '
          'selected, scrolledUnder, disabled, error. Framework widgets add '
          'and remove members as the user interacts.',
    ],
    <String>[
      'WidgetStatesConstraint',
      'Something that can answer "does this state set satisfy me?". Every '
          'WidgetState value is itself a constraint (matches when present); '
          'WidgetState.any matches unconditionally.',
    ],
    <String>[
      'WidgetStateMap<T>',
      'Typedef for Map<WidgetStatesConstraint, T>. Used by fromMap to '
          'declare per-state overrides with explicit insertion order.',
    ],
    <String>[
      'WidgetPropertyResolver<T>',
      'Typedef for T Function(Set<WidgetState>). The callback shape '
          'expected by resolveWith.',
    ],
    <String>[
      'WidgetStateColor.resolveWith',
      'Factory that builds a WidgetStateColor from a procedural callback. '
          'Evaluated once with {} to seed the Color super-constructor.',
    ],
    <String>[
      'WidgetStateColor.fromMap',
      'Const factory that builds a WidgetStateColor from a '
          'WidgetStateMap<Color>. First matching constraint wins.',
    ],
    <String>[
      'WidgetStateColor.transparent',
      'A pre-built WidgetStateColor that resolves to Color(0x00000000) for '
          'every state set.',
    ],
    <String>[
      'MaterialStateColor',
      'Deprecated typedef retained for backward compatibility. New code '
          'should use WidgetStateColor. Signatures and semantics are '
          'identical.',
    ],
    <String>[
      'ButtonStyle.backgroundColor',
      'A WidgetStateProperty<Color?>. Accepts a WidgetStateColor without '
          'any further wrapping because WidgetStateColor implements the '
          'property interface.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kShell,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final List<String> e in _entries) _entry(e[0], e[1]),
        ],
      ),
    );
  }

  Widget _entry(String term, String def) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: _kInk, fontSize: 12.5, height: 1.4),
          children: <TextSpan>[
            TextSpan(
              text: '$term — ',
              style: const TextStyle(
                color: _kMossDark,
                fontWeight: FontWeight.w800,
              ),
            ),
            TextSpan(
              text: def,
              style: const TextStyle(color: _kInkSoft),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WscEpilogue — closing paragraph. Reminds the reader that
// WidgetStateColor is a composition primitive, not a theme in itself.
// ---------------------------------------------------------------------------
class _WscEpilogue extends StatelessWidget {
  const _WscEpilogue();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kStroke, width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Epilogue',
            style: TextStyle(
              color: _kMossDark,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'WidgetStateColor is a composition primitive. It is not a '
            'theme, not a design system, not a palette. It is a Color that '
            'happens to remember how to answer a simple question: "given '
            'this set of interaction states, which color do I return?". '
            'Used well, it is the quietest piece of state-aware code in a '
            'Flutter app; used poorly, it becomes a tangle of branching '
            'inside ButtonStyle. The chameleon demonstrates the first use '
            'case. Everything else in this file is commentary.',
            style: TextStyle(color: _kInk, fontSize: 13, height: 1.5),
          ),
          SizedBox(height: 8),
          Text(
            'Further reading: the framework source for '
            'WidgetStateColor is in package:flutter/src/widgets/widget_state.dart. '
            'Look for the private _WidgetStateColor, _WidgetStateColorMapper, '
            'and _WidgetStateColorTransparent classes; they are all under '
            '80 lines and reward careful reading.',
            style: TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.45),
          ),
        ],
      ),
    );
  }
}
