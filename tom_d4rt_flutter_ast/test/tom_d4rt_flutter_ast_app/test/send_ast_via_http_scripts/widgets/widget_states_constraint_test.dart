// D4rt test script: Deep Demo — WidgetStatesConstraint
// -----------------------------------------------------------------------------
// Logic-gate laboratory exploration of `WidgetStatesConstraint`, the Flutter
// mixin-class that powers compound predicates over a Set<WidgetState>. Each
// WidgetState value implements WidgetStatesConstraint; the overloaded
// operators `&`, `|`, and `~` compose new constraint objects that still
// answer the single-method contract `bool isSatisfiedBy(Set<WidgetState>)`.
//
// This file renders a giant predicate-tower studio where toggleable state
// chips feed a live network of AND/OR/NOT gates. Lamps glow green when the
// current constraint evaluates to true against the user-selected state set,
// and red when false. A CustomPainter draws the wiring between state chips
// and gate nodes, and pulses travel along "hot" paths when the animation
// controller ticks.
//
// Sections:
//   1. Dossier / preamble cards.
//   2. Anatomy — mixin declaration, isSatisfiedBy signature, operator table.
//   3. State-toggle panel — chips for every WidgetState + current-set badge.
//   4. Live predicate tower — gate nodes + wiring painter + pulsing signal.
//   5. Operator cards — truth tables for `&`, `|`, `~`.
//   6. Constraint-in-a-map — WidgetStateColor.fromMap showcase.
//   7. First-match rule — reordered map demonstration.
//   8. Custom constraint — a `states.length.isEven` predicate in a map.
//   9. Recipe cards — focused-and-not-disabled ring, hovered-or-selected, etc.
//  10. Comparison — WidgetStatesConstraint vs WidgetState vs custom predicate.
//  11. Glossary / epilogue.
//
// D4rt harness contract: no main()/runApp(); top-level `build(context)`
// returns a MaterialApp whose home is a single stateful widget that owns the
// toggleable state set and animation controller.
// -----------------------------------------------------------------------------

import 'dart:math' as math;

import 'package:flutter/material.dart';

// =============================================================================
// Theme — logic-gate laboratory palette
// =============================================================================

class _WsctTheme {
  static const Color bench = Color(0xFF0E1621);
  static const Color benchDeep = Color(0xFF091018);
  static const Color panel = Color(0xFF17243A);
  static const Color panelAlt = Color(0xFF1E2D44);
  static const Color card = Color(0xFF1B2A40);
  static const Color wire = Color(0xFF6B9BD6);
  static const Color wireDim = Color(0xFF35547F);
  static const Color wireHot = Color(0xFFF0D37A);
  static const Color lampOn = Color(0xFF4BE07A);
  static const Color lampOff = Color(0xFFE04B5A);
  static const Color lampIdle = Color(0xFF5C6B80);
  static const Color ink = Color(0xFFE6ECF5);
  static const Color inkSoft = Color(0xFFB4C0D3);
  static const Color inkMute = Color(0xFF7A8699);
  static const Color accent = Color(0xFFF4A94A);
  static const Color accentCool = Color(0xFF7ED3C9);
  static const Color trace = Color(0xFF3B5A86);
  static const Color divider = Color(0xFF2A3C55);
  static const Color chipIdle = Color(0xFF2A3A53);
  static const Color chipActive = Color(0xFFF0D37A);
  static const Color chipActiveInk = Color(0xFF1A1608);
  static const Color warn = Color(0xFFE27A3F);
  static const Color good = Color(0xFF4BE07A);
  static const Color bad = Color(0xFFE04B5A);
}

// =============================================================================
// Helpers — human-readable labels for a WidgetState and a Set<WidgetState>
// =============================================================================

String _wsLabel(WidgetState s) {
  switch (s) {
    case WidgetState.hovered:
      return 'hovered';
    case WidgetState.focused:
      return 'focused';
    case WidgetState.pressed:
      return 'pressed';
    case WidgetState.dragged:
      return 'dragged';
    case WidgetState.selected:
      return 'selected';
    case WidgetState.scrolledUnder:
      return 'scrolledUnder';
    case WidgetState.disabled:
      return 'disabled';
    case WidgetState.error:
      return 'error';
  }
}

String _wsShort(WidgetState s) {
  switch (s) {
    case WidgetState.hovered:
      return 'hover';
    case WidgetState.focused:
      return 'focus';
    case WidgetState.pressed:
      return 'press';
    case WidgetState.dragged:
      return 'drag';
    case WidgetState.selected:
      return 'sel';
    case WidgetState.scrolledUnder:
      return 'scroll';
    case WidgetState.disabled:
      return 'disabl';
    case WidgetState.error:
      return 'err';
  }
}

const List<WidgetState> _kAllStates = <WidgetState>[
  WidgetState.hovered,
  WidgetState.focused,
  WidgetState.pressed,
  WidgetState.dragged,
  WidgetState.selected,
  WidgetState.scrolledUnder,
  WidgetState.disabled,
  WidgetState.error,
];

String _setLabel(Set<WidgetState> states) {
  if (states.isEmpty) return '{}';
  final ordered = _kAllStates.where(states.contains).map(_wsShort).toList();
  return '{${ordered.join(", ")}}';
}

// =============================================================================
// Custom constraint — parity of the incoming state set
// =============================================================================

/// A user-defined constraint that is satisfied whenever the set of active
/// widget states has an even count (0, 2, 4, …). Demonstrates that
/// WidgetStatesConstraint is just an interface: anything implementing
/// `isSatisfiedBy` participates in the compositional algebra.
class _WsctEven implements WidgetStatesConstraint {
  const _WsctEven();

  @override
  bool isSatisfiedBy(Set<WidgetState> states) => states.length.isEven;

  @override
  String toString() => 'EvenCount';
}

/// A second custom constraint: at least N states are active. Useful as a
/// "busy enough" signal when wiring several interactions together.
class _WsctAtLeast implements WidgetStatesConstraint {
  final int n;
  const _WsctAtLeast(this.n);

  @override
  bool isSatisfiedBy(Set<WidgetState> states) => states.length >= n;

  @override
  String toString() => 'AtLeast($n)';
}

// =============================================================================
// Model — a single labeled constraint row in the predicate tower
// =============================================================================

class _WsctGate {
  final String id;
  final String expression;
  final String description;
  final WidgetStatesConstraint constraint;
  final List<WidgetState> participatingStates;
  final String kind; // 'atom', 'not', 'and', 'or', 'any', 'custom'

  const _WsctGate({
    required this.id,
    required this.expression,
    required this.description,
    required this.constraint,
    required this.participatingStates,
    required this.kind,
  });
}

// =============================================================================
// Entry point: d4rt harness `build` function
// =============================================================================

dynamic build(BuildContext context) {
  debugPrint('WidgetStatesConstraint deep demo building');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WidgetStatesConstraint — Logic Gate Lab',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _WsctTheme.bench,
      primaryColor: _WsctTheme.accent,
      colorScheme: const ColorScheme.dark(
        primary: _WsctTheme.accent,
        secondary: _WsctTheme.wire,
        surface: _WsctTheme.card,
        onSurface: _WsctTheme.ink,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _WsctTheme.ink, fontSize: 14),
        bodySmall: TextStyle(color: _WsctTheme.inkSoft, fontSize: 12),
        titleMedium: TextStyle(
          color: _WsctTheme.ink,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: _WsctTheme.ink,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      dividerColor: _WsctTheme.divider,
    ),
    home: const _WsctHome(),
  );
}

// =============================================================================
// Top-level stateful shell
// =============================================================================

class _WsctHome extends StatefulWidget {
  const _WsctHome();

  @override
  State<_WsctHome> createState() => _WsctHomeState();
}

class _WsctHomeState extends State<_WsctHome>
    with SingleTickerProviderStateMixin {
  // The authoritative Set<WidgetState> used to evaluate every predicate on
  // the page. Toggling a chip mutates this set and triggers a rebuild.
  final Set<WidgetState> _current = <WidgetState>{
    WidgetState.focused,
    WidgetState.hovered,
  };

  // Map-order toggle for the first-match-rule section.
  bool _flippedMapOrder = false;

  // Whether to show raw boolean under each gate lamp.
  bool _showRawBoolean = true;

  // Whether to draw wires from chips to gates.
  bool _drawWires = true;

  // Animation controller drives the "signal pulse" traveling along satisfied
  // wires and the soft pulse on the lamp glow.
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  void _toggleState(WidgetState s) {
    setState(() {
      if (_current.contains(s)) {
        _current.remove(s);
      } else {
        _current.add(s);
      }
    });
  }

  void _clearAll() {
    setState(_current.clear);
  }

  void _selectAll() {
    setState(() {
      _current
        ..clear()
        ..addAll(_kAllStates);
    });
  }

  void _presetFocusedHover() {
    setState(() {
      _current
        ..clear()
        ..addAll(<WidgetState>{WidgetState.focused, WidgetState.hovered});
    });
  }

  void _presetPressedSelected() {
    setState(() {
      _current
        ..clear()
        ..addAll(<WidgetState>{WidgetState.pressed, WidgetState.selected});
    });
  }

  void _presetDisabledError() {
    setState(() {
      _current
        ..clear()
        ..addAll(<WidgetState>{WidgetState.disabled, WidgetState.error});
    });
  }

  // ---------------------------------------------------------------------------
  // Predicate tower definitions — the list of expressions evaluated live.
  // ---------------------------------------------------------------------------

  List<_WsctGate> _towerGates() {
    return <_WsctGate>[
      _WsctGate(
        id: 'atom-hover',
        expression: 'WidgetState.hovered',
        description: 'Atomic constraint: true iff `hovered` is in the set.',
        constraint: WidgetState.hovered,
        participatingStates: const <WidgetState>[WidgetState.hovered],
        kind: 'atom',
      ),
      _WsctGate(
        id: 'not-disabled',
        expression: '~WidgetState.disabled',
        description: 'NOT gate: satisfied while `disabled` is absent.',
        constraint: ~WidgetState.disabled,
        participatingStates: const <WidgetState>[WidgetState.disabled],
        kind: 'not',
      ),
      _WsctGate(
        id: 'focus-or-selected',
        expression: 'WidgetState.focused | WidgetState.selected',
        description: 'OR gate: either focus or selection lights the lamp.',
        constraint: WidgetState.focused | WidgetState.selected,
        participatingStates: const <WidgetState>[
          WidgetState.focused,
          WidgetState.selected,
        ],
        kind: 'or',
      ),
      _WsctGate(
        id: 'press-and-not-disabled',
        expression: 'WidgetState.pressed & ~WidgetState.disabled',
        description: 'AND gate with a negated input: interactive press only.',
        constraint: WidgetState.pressed & ~WidgetState.disabled,
        participatingStates: const <WidgetState>[
          WidgetState.pressed,
          WidgetState.disabled,
        ],
        kind: 'and',
      ),
      _WsctGate(
        id: 'compound',
        expression:
            '(WidgetState.focused | WidgetState.hovered) & ~WidgetState.error',
        description:
            'Compound expression — OR fused with an AND NOT. Focus or hover,'
            ' but never in error.',
        constraint: (WidgetState.focused | WidgetState.hovered) &
            ~WidgetState.error,
        participatingStates: const <WidgetState>[
          WidgetState.focused,
          WidgetState.hovered,
          WidgetState.error,
        ],
        kind: 'and',
      ),
      const _WsctGate(
        id: 'any',
        expression: 'WidgetState.any',
        description: 'The sentinel constraint — always true, any input.',
        constraint: WidgetState.any,
        participatingStates: <WidgetState>[],
        kind: 'any',
      ),
      _WsctGate(
        id: 'custom-even',
        expression: '_WsctEven() /* length.isEven */',
        description:
            'Custom mixin-class constraint: satisfied when the state set has'
            ' an even number of entries.',
        constraint: const _WsctEven(),
        participatingStates: const <WidgetState>[],
        kind: 'custom',
      ),
      _WsctGate(
        id: 'custom-atleast3',
        expression: '_WsctAtLeast(3)',
        description: 'Custom constraint: true when 3+ states are active.',
        constraint: const _WsctAtLeast(3),
        participatingStates: const <WidgetState>[],
        kind: 'custom',
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final gates = _towerGates();
    return Scaffold(
      backgroundColor: _WsctTheme.bench,
      appBar: AppBar(
        backgroundColor: _WsctTheme.benchDeep,
        elevation: 0,
        title: const Text(
          'WidgetStatesConstraint — Logic Gate Lab',
          style: TextStyle(
            color: _WsctTheme.ink,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Clear all',
            onPressed: _clearAll,
            icon: const Icon(Icons.clear_all, color: _WsctTheme.ink),
          ),
          IconButton(
            tooltip: 'Select all',
            onPressed: _selectAll,
            icon: const Icon(Icons.select_all, color: _WsctTheme.ink),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: _buildDossier()),
          SliverToBoxAdapter(child: _buildAnatomy()),
          SliverToBoxAdapter(child: _buildStatePanel()),
          SliverToBoxAdapter(child: _buildTowerSection(gates)),
          SliverToBoxAdapter(child: _buildOperatorCards()),
          SliverToBoxAdapter(child: _buildMapShowcase()),
          SliverToBoxAdapter(child: _buildFirstMatchSection()),
          SliverToBoxAdapter(child: _buildCustomConstraintSection()),
          SliverToBoxAdapter(child: _buildRecipeCards()),
          SliverToBoxAdapter(child: _buildComparisonSection()),
          SliverToBoxAdapter(child: _buildGlossary()),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1 — Dossier / preamble
  // ---------------------------------------------------------------------------

  Widget _buildDossier() {
    const entries = <_WsctDossierEntry>[
      _WsctDossierEntry(
        title: 'What is WidgetStatesConstraint?',
        body:
            'A mixin-class that abstracts "predicate over a Set<WidgetState>".'
            ' The single method `isSatisfiedBy(Set<WidgetState> states)`'
            ' returns a boolean. Anything that mixes it in becomes a'
            ' first-class constraint.',
        icon: Icons.bubble_chart_outlined,
      ),
      _WsctDossierEntry(
        title: 'Why a mixin-class?',
        body:
            'Because both the `WidgetState` enum values and user-defined'
            ' classes need to satisfy the same interface. The mixin form lets'
            ' the framework add default operator overloads while still being'
            ' implemented by an enum.',
        icon: Icons.extension_outlined,
      ),
      _WsctDossierEntry(
        title: 'How do operators compose?',
        body:
            'The `&`, `|`, and `~` operators return new WidgetStatesConstraint'
            ' objects. Evaluation is deferred: each call builds a node that'
            ' re-evaluates its children in `isSatisfiedBy`.',
        icon: Icons.account_tree_outlined,
      ),
      _WsctDossierEntry(
        title: 'The `any` sentinel',
        body:
            '`WidgetState.any` is a constraint that returns true for every'
            ' input set. It is the idiomatic fallback key inside a'
            ' WidgetStateMap — listed last so earlier, more specific entries'
            ' win.',
        icon: Icons.all_inclusive,
      ),
      _WsctDossierEntry(
        title: 'Where does it show up?',
        body:
            'As the key type of WidgetStateMap<T>, which powers'
            ' WidgetStateColor.fromMap, WidgetStateTextStyle.fromMap, and the'
            ' various theme `fromMap` constructors that let you describe a'
            ' resolved value as a list of (constraint, value) pairs.',
        icon: Icons.layers_outlined,
      ),
      _WsctDossierEntry(
        title: 'Predicate algebra',
        body:
            'Combine constraints as you would booleans. `A & B` evaluates both'
            ' children and returns their AND; `A | B` their OR; `~A` its NOT.'
            ' The algebra is total: every expression reduces to a single'
            ' WidgetStatesConstraint that answers isSatisfiedBy.',
        icon: Icons.functions,
      ),
      _WsctDossierEntry(
        title: 'Cheap to evaluate',
        body:
            'Each operator node stores its operands and evaluates them on'
            ' demand. There is no reduction to a canonical form, so you can'
            ' build large expressions without worrying about allocation cost'
            ' at call sites.',
        icon: Icons.speed,
      ),
    ];
    return _WsctSection(
      index: 1,
      title: 'Dossier',
      subtitle: 'A seven-card briefing on the constraint abstraction',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
        child: Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final e in entries) _WsctDossierCard(entry: e),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2 — Anatomy
  // ---------------------------------------------------------------------------

  Widget _buildAnatomy() {
    return _WsctSection(
      index: 2,
      title: 'Anatomy',
      subtitle: 'Mixin declaration, signature, operator table',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _WsctCodeBlock(
              heading: 'Mixin-class declaration (flutter/widgets)',
              code:
                  'mixin class WidgetStatesConstraint {\n'
                  '  bool isSatisfiedBy(Set<WidgetState> states);\n'
                  '\n'
                  '  WidgetStatesConstraint operator &(\n'
                  '      WidgetStatesConstraint other) => _WidgetStateAnd(this, other);\n'
                  '  WidgetStatesConstraint operator |(\n'
                  '      WidgetStatesConstraint other) => _WidgetStateOr(this, other);\n'
                  '  WidgetStatesConstraint operator ~() => _WidgetStateNot(this);\n'
                  '}',
            ),
            SizedBox(height: 12),
            _WsctCodeBlock(
              heading: 'Atomic satisfaction',
              code:
                  'enum WidgetState implements WidgetStatesConstraint {\n'
                  '  hovered, focused, pressed, dragged, selected,\n'
                  '  scrolledUnder, disabled, error, any;\n'
                  '\n'
                  '  @override\n'
                  '  bool isSatisfiedBy(Set<WidgetState> states) =>\n'
                  '      this == any ? true : states.contains(this);\n'
                  '}',
            ),
            SizedBox(height: 12),
            _WsctOperatorTable(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3 — State-toggle panel
  // ---------------------------------------------------------------------------

  Widget _buildStatePanel() {
    final setText = _setLabel(_current);
    return _WsctSection(
      index: 3,
      title: 'State toggle panel',
      subtitle: 'Toggle chips to change the Set<WidgetState> fed to every gate',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Container(
          decoration: BoxDecoration(
            color: _WsctTheme.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _WsctTheme.divider),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.toggle_on_outlined,
                      color: _WsctTheme.accent, size: 22),
                  const SizedBox(width: 10),
                  const Text(
                    'Active widget states',
                    style: TextStyle(
                      color: _WsctTheme.ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  _WsctSetBadge(label: setText),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  for (final s in _kAllStates)
                    _WsctStateChip(
                      state: s,
                      active: _current.contains(s),
                      onTap: () => _toggleState(s),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  _WsctAction(
                    label: 'Clear',
                    icon: Icons.clear,
                    onTap: _clearAll,
                  ),
                  _WsctAction(
                    label: 'All on',
                    icon: Icons.done_all,
                    onTap: _selectAll,
                  ),
                  _WsctAction(
                    label: 'Preset: focus+hover',
                    icon: Icons.center_focus_strong_outlined,
                    onTap: _presetFocusedHover,
                  ),
                  _WsctAction(
                    label: 'Preset: press+select',
                    icon: Icons.touch_app_outlined,
                    onTap: _presetPressedSelected,
                  ),
                  _WsctAction(
                    label: 'Preset: disabled+error',
                    icon: Icons.error_outline,
                    onTap: _presetDisabledError,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  _WsctToggle(
                    label: 'Show raw boolean',
                    value: _showRawBoolean,
                    onChanged: (v) => setState(() => _showRawBoolean = v),
                  ),
                  const SizedBox(width: 18),
                  _WsctToggle(
                    label: 'Draw chip→gate wires',
                    value: _drawWires,
                    onChanged: (v) => setState(() => _drawWires = v),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4 — Live predicate tower
  // ---------------------------------------------------------------------------

  Widget _buildTowerSection(List<_WsctGate> gates) {
    return _WsctSection(
      index: 4,
      title: 'Live predicate tower',
      subtitle:
          'Each row is a WidgetStatesConstraint; lamp is green when satisfied',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: AnimatedBuilder(
          animation: _pulseCtrl,
          builder: (context, _) {
            return _WsctGateTower(
              gates: gates,
              current: _current,
              showRawBoolean: _showRawBoolean,
              drawWires: _drawWires,
              pulse: _pulseCtrl.value,
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5 — Operator cards
  // ---------------------------------------------------------------------------

  Widget _buildOperatorCards() {
    return _WsctSection(
      index: 5,
      title: 'Operator truth tables',
      subtitle: 'How `&`, `|`, and `~` compose constraints',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Wrap(
          spacing: 14,
          runSpacing: 14,
          children: const <Widget>[
            _WsctOperatorCard(
              symbol: '&',
              name: 'AND',
              summary:
                  'Satisfied when BOTH children are satisfied for the same'
                  ' state set.',
              table: <List<String>>[
                <String>['A', 'B', 'A & B'],
                <String>['0', '0', '0'],
                <String>['0', '1', '0'],
                <String>['1', '0', '0'],
                <String>['1', '1', '1'],
              ],
              example:
                  'WidgetState.pressed & ~WidgetState.disabled\n'
                  '  // "interactive press": pressed AND not disabled.',
            ),
            _WsctOperatorCard(
              symbol: '|',
              name: 'OR',
              summary:
                  'Satisfied when AT LEAST ONE child is satisfied. The second'
                  ' operand is only evaluated when the first is false.',
              table: <List<String>>[
                <String>['A', 'B', 'A | B'],
                <String>['0', '0', '0'],
                <String>['0', '1', '1'],
                <String>['1', '0', '1'],
                <String>['1', '1', '1'],
              ],
              example:
                  'WidgetState.focused | WidgetState.hovered\n'
                  '  // "drawing attention": focus OR hover.',
            ),
            _WsctOperatorCard(
              symbol: '~',
              name: 'NOT',
              summary:
                  'Satisfied when the child is NOT satisfied. Useful as a'
                  ' filter to exclude states like disabled or error.',
              table: <List<String>>[
                <String>['A', '~A'],
                <String>['0', '1'],
                <String>['1', '0'],
              ],
              example:
                  '~WidgetState.disabled\n'
                  '  // "is interactive": disabled must be absent.',
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 6 — WidgetStateColor.fromMap showcase
  // ---------------------------------------------------------------------------

  Widget _buildMapShowcase() {
    final color = WidgetStateColor.fromMap(<WidgetStatesConstraint, Color>{
      WidgetState.disabled: _WsctTheme.lampIdle,
      WidgetState.error: _WsctTheme.lampOff,
      WidgetState.pressed & ~WidgetState.disabled: _WsctTheme.accent,
      WidgetState.hovered | WidgetState.focused: _WsctTheme.wire,
      WidgetState.selected: _WsctTheme.accentCool,
      WidgetState.any: _WsctTheme.inkMute,
    });
    final resolved = color.resolve(_current);
    final entries = <_WsctMapEntry>[
      _WsctMapEntry(
          expression: 'WidgetState.disabled',
          color: _WsctTheme.lampIdle,
          satisfied: WidgetState.disabled.isSatisfiedBy(_current)),
      _WsctMapEntry(
          expression: 'WidgetState.error',
          color: _WsctTheme.lampOff,
          satisfied: WidgetState.error.isSatisfiedBy(_current)),
      _WsctMapEntry(
          expression: 'pressed & ~disabled',
          color: _WsctTheme.accent,
          satisfied: (WidgetState.pressed & ~WidgetState.disabled)
              .isSatisfiedBy(_current)),
      _WsctMapEntry(
          expression: 'hovered | focused',
          color: _WsctTheme.wire,
          satisfied: (WidgetState.hovered | WidgetState.focused)
              .isSatisfiedBy(_current)),
      _WsctMapEntry(
          expression: 'WidgetState.selected',
          color: _WsctTheme.accentCool,
          satisfied: WidgetState.selected.isSatisfiedBy(_current)),
      _WsctMapEntry(
          expression: 'WidgetState.any',
          color: _WsctTheme.inkMute,
          satisfied: WidgetState.any.isSatisfiedBy(_current)),
    ];
    return _WsctSection(
      index: 6,
      title: 'Constraint-in-a-map',
      subtitle:
          'WidgetStateColor.fromMap resolves by first matching constraint',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: _WsctMapShowcase(entries: entries, resolved: resolved),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 7 — First-match rule
  // ---------------------------------------------------------------------------

  Widget _buildFirstMatchSection() {
    final entriesA = <_WsctFirstMatchEntry>[
      _WsctFirstMatchEntry(
        expression: 'WidgetState.error',
        color: _WsctTheme.lampOff,
        satisfied: WidgetState.error.isSatisfiedBy(_current),
      ),
      _WsctFirstMatchEntry(
        expression: 'WidgetState.pressed',
        color: _WsctTheme.accent,
        satisfied: WidgetState.pressed.isSatisfiedBy(_current),
      ),
      _WsctFirstMatchEntry(
        expression: 'WidgetState.any',
        color: _WsctTheme.inkMute,
        satisfied: true,
      ),
    ];
    final entriesB = <_WsctFirstMatchEntry>[
      _WsctFirstMatchEntry(
        expression: 'WidgetState.pressed',
        color: _WsctTheme.accent,
        satisfied: WidgetState.pressed.isSatisfiedBy(_current),
      ),
      _WsctFirstMatchEntry(
        expression: 'WidgetState.error',
        color: _WsctTheme.lampOff,
        satisfied: WidgetState.error.isSatisfiedBy(_current),
      ),
      _WsctFirstMatchEntry(
        expression: 'WidgetState.any',
        color: _WsctTheme.inkMute,
        satisfied: true,
      ),
    ];
    final active = _flippedMapOrder ? entriesB : entriesA;
    final Color resolvedA = _firstMatch(entriesA);
    final Color resolvedB = _firstMatch(entriesB);
    return _WsctSection(
      index: 7,
      title: 'First-match rule',
      subtitle: 'The order of entries in a WidgetStateMap is load-bearing',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Container(
          decoration: BoxDecoration(
            color: _WsctTheme.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _WsctTheme.divider),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Same constraints, different order — different resolved color.',
                style: TextStyle(
                  color: _WsctTheme.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _WsctOrderedMap(
                      label: 'Map A (error first)',
                      entries: entriesA,
                      resolved: resolvedA,
                      active: identical(active, entriesA),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _WsctOrderedMap(
                      label: 'Map B (pressed first)',
                      entries: entriesB,
                      resolved: resolvedB,
                      active: identical(active, entriesB),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  _WsctAction(
                    label: _flippedMapOrder
                        ? 'Use Map A'
                        : 'Use Map B',
                    icon: Icons.swap_horiz,
                    onTap: () => setState(
                        () => _flippedMapOrder = !_flippedMapOrder),
                  ),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text(
                      'The first constraint whose isSatisfiedBy returns true'
                      ' wins. Put specific cases first and `any` last.',
                      style: TextStyle(
                        color: _WsctTheme.inkSoft,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _firstMatch(List<_WsctFirstMatchEntry> entries) {
    for (final e in entries) {
      if (e.satisfied) return e.color;
    }
    return _WsctTheme.inkMute;
  }

  // ---------------------------------------------------------------------------
  // Section 8 — Custom constraint
  // ---------------------------------------------------------------------------

  Widget _buildCustomConstraintSection() {
    final even = const _WsctEven();
    final atLeast = const _WsctAtLeast(3);
    final color = WidgetStateColor.fromMap(<WidgetStatesConstraint, Color>{
      atLeast: _WsctTheme.wireHot,
      even: _WsctTheme.accentCool,
      WidgetState.any: _WsctTheme.lampIdle,
    });
    final resolved = color.resolve(_current);
    return _WsctSection(
      index: 8,
      title: 'Custom constraints',
      subtitle:
          'Your own classes mix in WidgetStatesConstraint and join the algebra',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Container(
          decoration: BoxDecoration(
            color: _WsctTheme.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _WsctTheme.divider),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _WsctCodeBlock(
                heading: 'Definition',
                code:
                    'class _WsctEven implements WidgetStatesConstraint {\n'
                    '  const _WsctEven();\n'
                    '  @override\n'
                    '  bool isSatisfiedBy(Set<WidgetState> states) =>\n'
                    '      states.length.isEven;\n'
                    '}',
              ),
              const SizedBox(height: 12),
              const _WsctCodeBlock(
                heading: 'Another — "at least N"',
                code:
                    'class _WsctAtLeast implements WidgetStatesConstraint {\n'
                    '  final int n;\n'
                    '  const _WsctAtLeast(this.n);\n'
                    '  @override\n'
                    '  bool isSatisfiedBy(Set<WidgetState> states) =>\n'
                    '      states.length >= n;\n'
                    '}',
              ),
              const SizedBox(height: 12),
              _WsctCustomDemo(
                even: even.isSatisfiedBy(_current),
                atLeast3: atLeast.isSatisfiedBy(_current),
                currentCount: _current.length,
                resolved: resolved,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 9 — Recipe cards
  // ---------------------------------------------------------------------------

  Widget _buildRecipeCards() {
    final recipes = <_WsctRecipe>[
      _WsctRecipe(
        title: 'Focused-and-not-disabled ring',
        expression:
            'WidgetState.focused & ~WidgetState.disabled',
        body:
            'A classic a11y ring: draw only when the control is focused AND'
            ' still interactive.',
        satisfied: (WidgetState.focused & ~WidgetState.disabled)
            .isSatisfiedBy(_current),
      ),
      _WsctRecipe(
        title: 'Hovered-or-selected highlight',
        expression: 'WidgetState.hovered | WidgetState.selected',
        body:
            'One color for "currently attracting attention" — hovered or'
            ' already selected.',
        satisfied: (WidgetState.hovered | WidgetState.selected)
            .isSatisfiedBy(_current),
      ),
      _WsctRecipe(
        title: 'Error-suppressing dimmer',
        expression: '~WidgetState.error & ~WidgetState.disabled',
        body:
            'Neutral state: useful as a base when both error and disabled'
            ' take priority over it.',
        satisfied: (~WidgetState.error & ~WidgetState.disabled)
            .isSatisfiedBy(_current),
      ),
      _WsctRecipe(
        title: 'Pressed-and-selected deeper variant',
        expression: 'WidgetState.pressed & WidgetState.selected',
        body:
            'The "double-down" visual — a selected chip is being pressed,'
            ' pick a deeper tone.',
        satisfied: (WidgetState.pressed & WidgetState.selected)
            .isSatisfiedBy(_current),
      ),
      _WsctRecipe(
        title: 'Any fallback',
        expression: 'WidgetState.any',
        body:
            'Always-true entry. Put it last in a map; earlier entries match'
            ' more specific conditions first.',
        satisfied: true,
      ),
      _WsctRecipe(
        title: 'Interactive press',
        expression: 'WidgetState.pressed & ~WidgetState.disabled',
        body:
            'Visual feedback only when a press is actually allowed. Prevents'
            ' press visuals from appearing on disabled controls.',
        satisfied: (WidgetState.pressed & ~WidgetState.disabled)
            .isSatisfiedBy(_current),
      ),
      _WsctRecipe(
        title: 'Scrolled-under tint',
        expression: 'WidgetState.scrolledUnder',
        body:
            'Atomic constraint — fires when content has scrolled under a'
            ' surface (app bar, sliver).',
        satisfied: WidgetState.scrolledUnder.isSatisfiedBy(_current),
      ),
    ];
    return _WsctSection(
      index: 9,
      title: 'Recipe cards',
      subtitle: 'Seven ready-made constraints you will reuse',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final r in recipes) _WsctRecipeCard(recipe: r),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 10 — Comparison
  // ---------------------------------------------------------------------------

  Widget _buildComparisonSection() {
    return _WsctSection(
      index: 10,
      title: 'Comparison',
      subtitle:
          'WidgetStatesConstraint vs WidgetState vs custom predicate function',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Container(
          decoration: BoxDecoration(
            color: _WsctTheme.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _WsctTheme.divider),
          ),
          padding: const EdgeInsets.all(18),
          child: const _WsctComparisonTable(),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 11 — Glossary / epilogue
  // ---------------------------------------------------------------------------

  Widget _buildGlossary() {
    return _WsctSection(
      index: 11,
      title: 'Glossary & epilogue',
      subtitle: 'Terms and parting guidance',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Container(
          decoration: BoxDecoration(
            color: _WsctTheme.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _WsctTheme.divider),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _WsctGlossaryEntry(
                term: 'WidgetState',
                def:
                    'The enum of interaction states: hovered, focused,'
                    ' pressed, dragged, selected, scrolledUnder, disabled,'
                    ' error. Also implements WidgetStatesConstraint.',
              ),
              SizedBox(height: 8),
              _WsctGlossaryEntry(
                term: 'WidgetStatesConstraint',
                def:
                    'The mixin-class interface for any boolean predicate over'
                    ' a Set<WidgetState>. Method: isSatisfiedBy(states).',
              ),
              SizedBox(height: 8),
              _WsctGlossaryEntry(
                term: 'Set<WidgetState>',
                def:
                    'The current active interaction-state set passed to'
                    ' isSatisfiedBy by the framework when resolving a value.',
              ),
              SizedBox(height: 8),
              _WsctGlossaryEntry(
                term: 'WidgetStateMap<T>',
                def:
                    'A Map<WidgetStatesConstraint, T>. Entries are scanned in'
                    ' insertion order; the first constraint that matches wins.',
              ),
              SizedBox(height: 8),
              _WsctGlossaryEntry(
                term: 'WidgetState.any',
                def:
                    'Sentinel whose isSatisfiedBy always returns true. Used as'
                    ' the terminal fallback in a WidgetStateMap.',
              ),
              SizedBox(height: 8),
              _WsctGlossaryEntry(
                term: 'Operator node',
                def:
                    'An internal object produced by `&`, `|`, or `~` that'
                    ' holds its operands and defers evaluation until asked.',
              ),
              SizedBox(height: 14),
              Text(
                'Rule of thumb: reach for WidgetStatesConstraint whenever you'
                ' would otherwise write a long chain of `if` statements to'
                ' decide a visual property. It reads like boolean algebra and'
                ' composes with the rest of the Material resolver machinery.',
                style: TextStyle(
                  color: _WsctTheme.inkSoft,
                  fontSize: 13,
                  height: 1.4,
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
// Section shell — numbered header with subtitle and slot
// =============================================================================

class _WsctSection extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final Widget child;

  const _WsctSection({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: _WsctTheme.accent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x55000000),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: _WsctTheme.benchDeep,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
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
                      style: const TextStyle(
                        color: _WsctTheme.ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _WsctTheme.inkSoft,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _WsctTheme.accent.withValues(alpha: 0.9),
                  _WsctTheme.accent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

// =============================================================================
// Dossier card
// =============================================================================

class _WsctDossierEntry {
  final String title;
  final String body;
  final IconData icon;
  const _WsctDossierEntry({
    required this.title,
    required this.body,
    required this.icon,
  });
}

class _WsctDossierCard extends StatelessWidget {
  final _WsctDossierEntry entry;
  const _WsctDossierCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240, maxWidth: 330),
      child: Container(
        decoration: BoxDecoration(
          color: _WsctTheme.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _WsctTheme.divider),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _WsctTheme.benchDeep,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(entry.icon, size: 16, color: _WsctTheme.accent),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    entry.title,
                    style: const TextStyle(
                      color: _WsctTheme.ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              entry.body,
              style: const TextStyle(
                color: _WsctTheme.inkSoft,
                fontSize: 12.5,
                height: 1.38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Code block
// =============================================================================

class _WsctCodeBlock extends StatelessWidget {
  final String heading;
  final String code;

  const _WsctCodeBlock({required this.heading, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsctTheme.benchDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _WsctTheme.divider),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.code, size: 16, color: _WsctTheme.accent),
              const SizedBox(width: 8),
              Text(
                heading,
                style: const TextStyle(
                  color: _WsctTheme.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _WsctTheme.bench,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _WsctTheme.divider),
            ),
            child: SelectableText(
              code,
              style: const TextStyle(
                color: _WsctTheme.ink,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.42,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Operator table
// =============================================================================

class _WsctOperatorTable extends StatelessWidget {
  const _WsctOperatorTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsctTheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _WsctTheme.divider),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _WsctOperatorTableRow(
            symbol: 'A & B',
            name: 'AND',
            description: 'true iff both A and B are satisfied',
          ),
          SizedBox(height: 6),
          _WsctOperatorTableRow(
            symbol: 'A | B',
            name: 'OR',
            description: 'true iff at least one of A or B is satisfied',
          ),
          SizedBox(height: 6),
          _WsctOperatorTableRow(
            symbol: '~A',
            name: 'NOT',
            description: 'true iff A is not satisfied',
          ),
          SizedBox(height: 6),
          _WsctOperatorTableRow(
            symbol: 'WidgetState.any',
            name: 'ANY',
            description: 'always satisfied; used as fallback',
          ),
        ],
      ),
    );
  }
}

class _WsctOperatorTableRow extends StatelessWidget {
  final String symbol;
  final String name;
  final String description;

  const _WsctOperatorTableRow({
    required this.symbol,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: _WsctTheme.benchDeep,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            symbol,
            style: const TextStyle(
              color: _WsctTheme.accent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 54,
          child: Text(
            name,
            style: const TextStyle(
              color: _WsctTheme.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: _WsctTheme.inkSoft,
              fontSize: 12.5,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// State chip
// =============================================================================

class _WsctStateChip extends StatelessWidget {
  final WidgetState state;
  final bool active;
  final VoidCallback onTap;

  const _WsctStateChip({
    required this.state,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = active ? _WsctTheme.chipActive : _WsctTheme.chipIdle;
    final fg = active ? _WsctTheme.chipActiveInk : _WsctTheme.ink;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: active ? _WsctTheme.accent : _WsctTheme.divider,
            width: active ? 1.4 : 1.0,
          ),
          boxShadow: active
              ? const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x55F0D37A),
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: active ? _WsctTheme.lampOn : _WsctTheme.lampIdle,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: _WsctTheme.benchDeep, width: 1),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _wsLabel(state),
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Current-set pill badge
// =============================================================================

class _WsctSetBadge extends StatelessWidget {
  final String label;
  const _WsctSetBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _WsctTheme.benchDeep,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _WsctTheme.accent.withValues(alpha: 0.6)),
      ),
      child: Text(
        'states = $label',
        style: const TextStyle(
          color: _WsctTheme.accent,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

// =============================================================================
// Action button
// =============================================================================

class _WsctAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _WsctAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: _WsctTheme.panelAlt,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _WsctTheme.divider),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: _WsctTheme.accent, size: 15),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: _WsctTheme.ink,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Toggle switch row
// =============================================================================

class _WsctToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _WsctToggle({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: _WsctTheme.accent,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _WsctTheme.inkSoft,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Operator card — a &, |, ~ truth-table card
// =============================================================================

class _WsctOperatorCard extends StatelessWidget {
  final String symbol;
  final String name;
  final String summary;
  final List<List<String>> table;
  final String example;

  const _WsctOperatorCard({
    required this.symbol,
    required this.name,
    required this.summary,
    required this.table,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 260, maxWidth: 340),
      child: Container(
        decoration: BoxDecoration(
          color: _WsctTheme.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _WsctTheme.divider),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _WsctTheme.benchDeep,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _WsctTheme.accent),
                  ),
                  child: Text(
                    symbol,
                    style: const TextStyle(
                      color: _WsctTheme.accent,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'monospace',
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: const TextStyle(
                    color: _WsctTheme.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              summary,
              style: const TextStyle(
                color: _WsctTheme.inkSoft,
                fontSize: 12.5,
                height: 1.38,
              ),
            ),
            const SizedBox(height: 12),
            _WsctTruthTable(rows: table),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _WsctTheme.bench,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _WsctTheme.divider),
              ),
              child: Text(
                example,
                style: const TextStyle(
                  color: _WsctTheme.ink,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.42,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WsctTruthTable extends StatelessWidget {
  final List<List<String>> rows;
  const _WsctTruthTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int r = 0; r < rows.length; r++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
            decoration: BoxDecoration(
              color: r == 0
                  ? _WsctTheme.benchDeep
                  : (r.isOdd ? _WsctTheme.panel : _WsctTheme.panelAlt),
              borderRadius: BorderRadius.circular(4),
            ),
            margin: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              children: <Widget>[
                for (final cell in rows[r])
                  Expanded(
                    child: Text(
                      cell,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: r == 0 ? FontWeight.w800 : FontWeight.w600,
                        color: r == 0
                            ? _WsctTheme.accent
                            : (cell == '1'
                                ? _WsctTheme.good
                                : (cell == '0'
                                    ? _WsctTheme.inkMute
                                    : _WsctTheme.ink)),
                        fontSize: 12.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

// =============================================================================
// Gate tower — list of gates with chip→gate wires and pulsing lamps
// =============================================================================

class _WsctGateTower extends StatelessWidget {
  final List<_WsctGate> gates;
  final Set<WidgetState> current;
  final bool showRawBoolean;
  final bool drawWires;
  final double pulse;

  const _WsctGateTower({
    required this.gates,
    required this.current,
    required this.showRawBoolean,
    required this.drawWires,
    required this.pulse,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final rowHeight = 96.0;
        final topPadding = 64.0;
        final height = topPadding + gates.length * rowHeight + 20;
        return Container(
          decoration: BoxDecoration(
            color: _WsctTheme.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _WsctTheme.divider),
          ),
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                if (drawWires)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _WsctWiringPainter(
                        gates: gates,
                        current: current,
                        pulse: pulse,
                        rowHeight: rowHeight,
                        topPadding: topPadding,
                      ),
                    ),
                  ),
                // Header chip row — small indicator chips at the top.
                Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: _WsctTowerHeader(current: current),
                ),
                // Gate rows.
                for (int i = 0; i < gates.length; i++)
                  Positioned(
                    top: topPadding + i * rowHeight,
                    left: 0,
                    right: 0,
                    height: rowHeight,
                    child: _WsctGateRow(
                      gate: gates[i],
                      current: current,
                      showRawBoolean: showRawBoolean,
                      pulse: pulse,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// Tower header — mini indicator chips above the wiring.
// -----------------------------------------------------------------------------

class _WsctTowerHeader extends StatelessWidget {
  final Set<WidgetState> current;
  const _WsctTowerHeader({required this.current});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final n = _kAllStates.length;
        final slot = width / n;
        return SizedBox(
          height: 44,
          child: Stack(
            children: <Widget>[
              for (int i = 0; i < n; i++)
                Positioned(
                  left: i * slot,
                  width: slot,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _WsctMiniIndicator(
                      state: _kAllStates[i],
                      active: current.contains(_kAllStates[i]),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _WsctMiniIndicator extends StatelessWidget {
  final WidgetState state;
  final bool active;
  const _WsctMiniIndicator({required this.state, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: active ? _WsctTheme.wireHot : _WsctTheme.wireDim,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: _WsctTheme.benchDeep, width: 1.4),
            boxShadow: active
                ? const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x88F0D37A),
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _wsShort(state),
          style: TextStyle(
            color: active ? _WsctTheme.accent : _WsctTheme.inkMute,
            fontWeight: FontWeight.w700,
            fontSize: 10.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Gate row — label, expression pill, lamp, raw-boolean box
// -----------------------------------------------------------------------------

class _WsctGateRow extends StatelessWidget {
  final _WsctGate gate;
  final Set<WidgetState> current;
  final bool showRawBoolean;
  final double pulse;

  const _WsctGateRow({
    required this.gate,
    required this.current,
    required this.showRawBoolean,
    required this.pulse,
  });

  @override
  Widget build(BuildContext context) {
    final satisfied = gate.constraint.isSatisfiedBy(current);
    final glow = satisfied
        ? 0.5 + 0.5 * math.sin(pulse * 2 * math.pi)
        : 0.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Kind tag.
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: _kindColor(gate.kind).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kindColor(gate.kind)),
            ),
            alignment: Alignment.center,
            child: Text(
              gate.kind.toUpperCase(),
              style: TextStyle(
                color: _kindColor(gate.kind),
                fontWeight: FontWeight.w800,
                fontSize: 10.5,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Expression + description.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _WsctTheme.benchDeep,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    gate.expression,
                    style: const TextStyle(
                      color: _WsctTheme.accent,
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  gate.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _WsctTheme.inkSoft,
                    fontSize: 12,
                    height: 1.32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Lamp.
          _WsctLamp(satisfied: satisfied, glow: glow),
          if (showRawBoolean) ...<Widget>[
            const SizedBox(width: 10),
            Container(
              width: 52,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: satisfied ? _WsctTheme.good : _WsctTheme.bad,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                satisfied ? 'true' : 'false',
                style: TextStyle(
                  color: satisfied
                      ? _WsctTheme.benchDeep
                      : _WsctTheme.bench,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _kindColor(String kind) {
    switch (kind) {
      case 'atom':
        return _WsctTheme.wire;
      case 'and':
        return _WsctTheme.accent;
      case 'or':
        return _WsctTheme.accentCool;
      case 'not':
        return _WsctTheme.warn;
      case 'any':
        return _WsctTheme.good;
      case 'custom':
        return _WsctTheme.wireHot;
    }
    return _WsctTheme.inkSoft;
  }
}

// -----------------------------------------------------------------------------
// Lamp — stylized indicator with inner highlight and outer glow.
// -----------------------------------------------------------------------------

class _WsctLamp extends StatelessWidget {
  final bool satisfied;
  final double glow;

  const _WsctLamp({required this.satisfied, required this.glow});

  @override
  Widget build(BuildContext context) {
    final color = satisfied ? _WsctTheme.lampOn : _WsctTheme.lampOff;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _WsctTheme.benchDeep,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: satisfied ? 0.25 + 0.55 * glow : 0.25),
            blurRadius: satisfied ? 8 + 14 * glow : 6,
            spreadRadius: satisfied ? 1 + 2 * glow : 0.5,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                color.withValues(alpha: satisfied ? 1.0 : 0.85),
                color.withValues(alpha: 0.0),
              ],
              stops: const <double>[0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CustomPainter — draws chip→gate wires with pulses on satisfied paths.
// -----------------------------------------------------------------------------

class _WsctWiringPainter extends CustomPainter {
  final List<_WsctGate> gates;
  final Set<WidgetState> current;
  final double pulse;
  final double rowHeight;
  final double topPadding;

  _WsctWiringPainter({
    required this.gates,
    required this.current,
    required this.pulse,
    required this.rowHeight,
    required this.topPadding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final n = _kAllStates.length;
    final slot = size.width / n;
    // Chip anchor Y: 36 px below the top.
    final chipY = 28.0;
    // Gate anchor X: the lamp column sits towards the right side.
    final gateAnchorX = size.width - 78;
    for (int g = 0; g < gates.length; g++) {
      final gate = gates[g];
      final rowCenterY = topPadding + g * rowHeight + rowHeight / 2;
      final satisfied = gate.constraint.isSatisfiedBy(current);
      for (final s in gate.participatingStates) {
        final idx = _kAllStates.indexOf(s);
        if (idx < 0) continue;
        final chipX = idx * slot + slot / 2;
        final wireColor = satisfied
            ? _WsctTheme.wireHot
            : (current.contains(s) ? _WsctTheme.wire : _WsctTheme.wireDim);
        final paint = Paint()
          ..color = wireColor.withValues(alpha: satisfied ? 0.85 : 0.55)
          ..strokeWidth = satisfied ? 2.2 : 1.4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        final path = Path()
          ..moveTo(chipX, chipY)
          ..cubicTo(
            chipX,
            chipY + (rowCenterY - chipY) * 0.55,
            gateAnchorX,
            chipY + (rowCenterY - chipY) * 0.45,
            gateAnchorX,
            rowCenterY,
          );
        canvas.drawPath(path, paint);
        // Pulse dot travels along the path on satisfied wires.
        if (satisfied) {
          final metrics = path.computeMetrics().toList();
          if (metrics.isNotEmpty) {
            final metric = metrics.first;
            final t = (pulse + (g * 0.12) + (idx * 0.07)) % 1.0;
            final tangent = metric.getTangentForOffset(metric.length * t);
            if (tangent != null) {
              final dotPaint = Paint()..color = _WsctTheme.wireHot;
              canvas.drawCircle(tangent.position, 3.2, dotPaint);
              final haloPaint = Paint()
                ..color = _WsctTheme.wireHot.withValues(alpha: 0.25)
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
              canvas.drawCircle(tangent.position, 6.8, haloPaint);
            }
          }
        }
      }
    }
    // Draw a subtle vertical rail near the gate anchor column.
    final rail = Paint()
      ..color = _WsctTheme.trace.withValues(alpha: 0.6)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(gateAnchorX, topPadding - 8),
      Offset(gateAnchorX, topPadding + gates.length * rowHeight - 8),
      rail,
    );
  }

  @override
  bool shouldRepaint(covariant _WsctWiringPainter old) {
    return old.gates != gates ||
        old.current != current ||
        old.pulse != pulse ||
        old.rowHeight != rowHeight ||
        old.topPadding != topPadding;
  }
}

// =============================================================================
// Map showcase — WidgetStateColor.fromMap driving a live swatch
// =============================================================================

class _WsctMapEntry {
  final String expression;
  final Color color;
  final bool satisfied;

  const _WsctMapEntry({
    required this.expression,
    required this.color,
    required this.satisfied,
  });
}

class _WsctMapShowcase extends StatelessWidget {
  final List<_WsctMapEntry> entries;
  final Color resolved;

  const _WsctMapShowcase({required this.entries, required this.resolved});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsctTheme.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _WsctTheme.divider),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.map_outlined,
                  color: _WsctTheme.accent, size: 20),
              const SizedBox(width: 8),
              const Text(
                'WidgetStateColor.fromMap',
                style: TextStyle(
                  color: _WsctTheme.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              _WsctSwatch(color: resolved, label: 'resolved'),
            ],
          ),
          const SizedBox(height: 12),
          for (final entry in entries) _WsctMapRow(entry: entry),
          const SizedBox(height: 8),
          const Text(
            'The resolver calls `isSatisfiedBy(states)` on each key in order and'
            ' returns the first match. Because `WidgetState.any` is always'
            ' satisfied, it acts as the terminal fallback.',
            style: TextStyle(color: _WsctTheme.inkSoft, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

class _WsctMapRow extends StatelessWidget {
  final _WsctMapEntry entry;
  const _WsctMapRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: entry.satisfied
                  ? _WsctTheme.good
                  : _WsctTheme.inkMute.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _WsctTheme.divider),
            ),
            alignment: Alignment.center,
            child: entry.satisfied
                ? const Icon(Icons.check,
                    size: 13, color: _WsctTheme.benchDeep)
                : const SizedBox.shrink(),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _WsctTheme.benchDeep,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                entry.expression,
                style: const TextStyle(
                  color: _WsctTheme.accent,
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _WsctSwatch(color: entry.color, label: null),
        ],
      ),
    );
  }
}

class _WsctSwatch extends StatelessWidget {
  final Color color;
  final String? label;
  const _WsctSwatch({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 36,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _WsctTheme.divider),
          ),
        ),
        if (label != null) ...<Widget>[
          const SizedBox(width: 6),
          Text(
            label!,
            style: const TextStyle(
              color: _WsctTheme.inkSoft,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

// =============================================================================
// First-match rule — two ordered maps with the same entries
// =============================================================================

class _WsctFirstMatchEntry {
  final String expression;
  final Color color;
  final bool satisfied;

  const _WsctFirstMatchEntry({
    required this.expression,
    required this.color,
    required this.satisfied,
  });
}

class _WsctOrderedMap extends StatelessWidget {
  final String label;
  final List<_WsctFirstMatchEntry> entries;
  final Color resolved;
  final bool active;

  const _WsctOrderedMap({
    required this.label,
    required this.entries,
    required this.resolved,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    int? winnerIndex;
    for (int i = 0; i < entries.length; i++) {
      if (entries[i].satisfied) {
        winnerIndex = i;
        break;
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: active ? _WsctTheme.card : _WsctTheme.panelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active ? _WsctTheme.accent : _WsctTheme.divider,
          width: active ? 1.4 : 1.0,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(
                  color: _WsctTheme.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              _WsctSwatch(color: resolved, label: null),
            ],
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < entries.length; i++)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: i == winnerIndex
                    ? _WsctTheme.benchDeep
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: i == winnerIndex
                      ? _WsctTheme.accent
                      : _WsctTheme.divider,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    '${i + 1}.',
                    style: TextStyle(
                      color: i == winnerIndex
                          ? _WsctTheme.accent
                          : _WsctTheme.inkMute,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      entries[i].expression,
                      style: TextStyle(
                        color: i == winnerIndex
                            ? _WsctTheme.accent
                            : _WsctTheme.ink,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: i == winnerIndex
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: entries[i].satisfied
                          ? _WsctTheme.good
                          : _WsctTheme.inkMute.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: entries[i].satisfied
                        ? const Icon(Icons.check,
                            size: 12, color: _WsctTheme.benchDeep)
                        : null,
                  ),
                  const SizedBox(width: 6),
                  _WsctSwatch(color: entries[i].color, label: null),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// Custom constraint demo — live evaluation badges
// =============================================================================

class _WsctCustomDemo extends StatelessWidget {
  final bool even;
  final bool atLeast3;
  final int currentCount;
  final Color resolved;

  const _WsctCustomDemo({
    required this.even,
    required this.atLeast3,
    required this.currentCount,
    required this.resolved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsctTheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _WsctTheme.divider),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.functions,
                  color: _WsctTheme.accent, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Live custom evaluation',
                style: TextStyle(
                  color: _WsctTheme.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _WsctTheme.benchDeep,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'states.length = $currentCount',
                  style: const TextStyle(
                    color: _WsctTheme.accent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _WsctBooleanRow(
            label: '_WsctEven().isSatisfiedBy(states)',
            satisfied: even,
          ),
          const SizedBox(height: 6),
          _WsctBooleanRow(
            label: '_WsctAtLeast(3).isSatisfiedBy(states)',
            satisfied: atLeast3,
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              const Text(
                'Resolved color in map: ',
                style: TextStyle(
                  color: _WsctTheme.inkSoft,
                  fontSize: 12.5,
                ),
              ),
              _WsctSwatch(color: resolved, label: null),
              const SizedBox(width: 8),
              const Flexible(
                child: Text(
                  '(atLeast(3) first, then even, then any)',
                  style: TextStyle(
                    color: _WsctTheme.inkMute,
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WsctBooleanRow extends StatelessWidget {
  final String label;
  final bool satisfied;
  const _WsctBooleanRow({required this.label, required this.satisfied});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: satisfied ? _WsctTheme.good : _WsctTheme.bad,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            satisfied ? 'T' : 'F',
            style: TextStyle(
              color: satisfied ? _WsctTheme.benchDeep : _WsctTheme.bench,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: _WsctTheme.ink,
              fontFamily: 'monospace',
              fontSize: 12.5,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Recipe cards
// =============================================================================

class _WsctRecipe {
  final String title;
  final String expression;
  final String body;
  final bool satisfied;

  const _WsctRecipe({
    required this.title,
    required this.expression,
    required this.body,
    required this.satisfied,
  });
}

class _WsctRecipeCard extends StatelessWidget {
  final _WsctRecipe recipe;
  const _WsctRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 260, maxWidth: 340),
      child: Container(
        decoration: BoxDecoration(
          color: _WsctTheme.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: recipe.satisfied
                ? _WsctTheme.good.withValues(alpha: 0.6)
                : _WsctTheme.divider,
            width: recipe.satisfied ? 1.4 : 1.0,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color:
                        recipe.satisfied ? _WsctTheme.good : _WsctTheme.lampOff,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: recipe.satisfied
                        ? const <BoxShadow>[
                            BoxShadow(
                              color: Color(0x884BE07A),
                              blurRadius: 6,
                            ),
                          ]
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recipe.title,
                    style: const TextStyle(
                      color: _WsctTheme.ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
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
                color: _WsctTheme.benchDeep,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _WsctTheme.divider),
              ),
              child: Text(
                recipe.expression,
                style: const TextStyle(
                  color: _WsctTheme.accent,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              recipe.body,
              style: const TextStyle(
                color: _WsctTheme.inkSoft,
                fontSize: 12.5,
                height: 1.38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Comparison table — WidgetStatesConstraint vs alternatives
// =============================================================================

class _WsctComparisonTable extends StatelessWidget {
  const _WsctComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _WsctComparisonHeader(),
        _WsctComparisonRow(
          topic: 'What it is',
          ws: 'Enum of 8 interaction states.',
          wsc: 'Mixin-class wrapping a `isSatisfiedBy(Set)` predicate.',
          fn: 'Plain `bool Function(Set<WidgetState>)` callback.',
        ),
        _WsctComparisonRow(
          topic: 'Composition',
          ws: 'None — atomic.',
          wsc: 'Closed under `&`, `|`, `~`. Builds a tree of nodes.',
          fn: 'Manual composition in Dart — no algebraic operators.',
        ),
        _WsctComparisonRow(
          topic: 'Works as map key',
          ws: 'Yes (it IS a WidgetStatesConstraint).',
          wsc: 'Yes — it is the declared key type.',
          fn: 'No — WidgetStateMap keys must implement the mixin.',
        ),
        _WsctComparisonRow(
          topic: 'Extensibility',
          ws: 'Fixed enum — cannot add cases.',
          wsc: 'Open — mix it into any class for custom predicates.',
          fn: 'Open — any closure works where a function is expected.',
        ),
        _WsctComparisonRow(
          topic: 'Typical use',
          ws: 'Report current interaction state of a widget.',
          wsc: 'Describe when a resolved value should apply.',
          fn: 'Ad-hoc checks in callbacks (e.g. onChanged filters).',
        ),
        _WsctComparisonRow(
          topic: 'When to reach for it',
          ws: 'You need the value of one state right now.',
          wsc: 'You are filling a WidgetStateMap or building a resolver.',
          fn: 'You have a one-off check that never leaves the function.',
        ),
      ],
    );
  }
}

class _WsctComparisonHeader extends StatelessWidget {
  const _WsctComparisonHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _WsctTheme.benchDeep,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              'Topic',
              style: TextStyle(
                color: _WsctTheme.accent,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'WidgetState',
              style: TextStyle(
                color: _WsctTheme.accent,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'WidgetStatesConstraint',
              style: TextStyle(
                color: _WsctTheme.accent,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Custom predicate fn',
              style: TextStyle(
                color: _WsctTheme.accent,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WsctComparisonRow extends StatelessWidget {
  final String topic;
  final String ws;
  final String wsc;
  final String fn;

  const _WsctComparisonRow({
    required this.topic,
    required this.ws,
    required this.wsc,
    required this.fn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _WsctTheme.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _WsctTheme.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              topic,
              style: const TextStyle(
                color: _WsctTheme.accent,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ws,
              style: const TextStyle(
                color: _WsctTheme.ink,
                fontSize: 12.5,
                height: 1.38,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              wsc,
              style: const TextStyle(
                color: _WsctTheme.ink,
                fontSize: 12.5,
                height: 1.38,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              fn,
              style: const TextStyle(
                color: _WsctTheme.inkSoft,
                fontSize: 12.5,
                height: 1.38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Glossary entry
// =============================================================================

class _WsctGlossaryEntry extends StatelessWidget {
  final String term;
  final String def;

  const _WsctGlossaryEntry({required this.term, required this.def});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 170,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: _WsctTheme.benchDeep,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            term,
            style: const TextStyle(
              color: _WsctTheme.accent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              def,
              style: const TextStyle(
                color: _WsctTheme.inkSoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
