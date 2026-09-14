// ignore_for_file: avoid_print
// Deep visual demo: WidgetStateMapper<T> - the static-map engine that powers
// WidgetStateProperty.fromMap, WidgetStateColor.fromMap and friends. It walks
// an ordered Map<WidgetStatesConstraint, T> and returns the first entry whose
// constraint is satisfied by the current Set<WidgetState>.
//
// Theme: a switchboard operator's console - mahogany panel, brass bezels,
// plug/socket matrix, indicator lamps. Each "state" is a cable plugged into
// a port; the mapper is the operator deciding which line to connect.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// D4rt bridge workaround: bridged TickerProvider mixins cannot be used as mixin
mixin _WsmTickerShim<T extends StatefulWidget> on State<T> implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

// ═══════════════════════════════════════════════════════════════════════════
// Switchboard palette - mahogany, brass, ivory, amber, cable reds and blues.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmPalette {
  const _WsmPalette._();
  static const Color mahogany = Color(0xFF3B1F17);
  static const Color mahoganyLight = Color(0xFF5A2F22);
  static const Color mahoganyDark = Color(0xFF23130E);
  static const Color brass = Color(0xFFB58A3C);
  static const Color brassBright = Color(0xFFDDB060);
  static const Color brassDark = Color(0xFF6E4F1D);
  static const Color ivory = Color(0xFFE9DFC7);
  static const Color ivoryDim = Color(0xFFB8AE94);
  static const Color lampAmber = Color(0xFFFFB545);
  static const Color lampRed = Color(0xFFE03A2C);
  static const Color lampGreen = Color(0xFF5CC46A);
  static const Color lampBlue = Color(0xFF4A8FD6);
  static const Color cableRed = Color(0xFFA93226);
  static const Color cableYellow = Color(0xFFC6A319);
  static const Color paperLabel = Color(0xFFEFE4C6);
}

// ═══════════════════════════════════════════════════════════════════════════
// Top-level notifiers drive the demo surface.
// ═══════════════════════════════════════════════════════════════════════════

final ValueNotifier<Set<WidgetState>> _wsmMatrixStates =
    ValueNotifier<Set<WidgetState>>(<WidgetState>{});
final ValueNotifier<Set<WidgetState>> _wsmFirstMatchStates =
    ValueNotifier<Set<WidgetState>>(<WidgetState>{});
final ValueNotifier<Set<WidgetState>> _wsmGenericStates =
    ValueNotifier<Set<WidgetState>>(<WidgetState>{});
final ValueNotifier<Set<WidgetState>> _wsmCompositionStates =
    ValueNotifier<Set<WidgetState>>(<WidgetState>{});

void _wsmToggle(ValueNotifier<Set<WidgetState>> n, WidgetState s) {
  final Set<WidgetState> next = <WidgetState>{...n.value};
  if (next.contains(s)) {
    next.remove(s);
  } else {
    next.add(s);
  }
  n.value = next;
}

// ═══════════════════════════════════════════════════════════════════════════
// Entry point
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) => const _WsmApp();

class _WsmApp extends StatelessWidget {
  const _WsmApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _WsmPalette.mahoganyDark,
        colorScheme: const ColorScheme.dark(
          primary: _WsmPalette.brass,
          onPrimary: _WsmPalette.mahoganyDark,
          secondary: _WsmPalette.lampAmber,
          surface: _WsmPalette.mahogany,
          onSurface: _WsmPalette.ivory,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: _WsmPalette.ivory,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: _WsmPalette.ivory,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            color: _WsmPalette.ivory,
          ),
          bodyMedium: TextStyle(
            height: 1.4,
            color: _WsmPalette.ivoryDim,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: _WsmPalette.brassBright,
          ),
        ),
      ),
      home: const _WsmHome(),
    );
  }
}

class _WsmHome extends StatelessWidget {
  const _WsmHome();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _WsmPalette.mahogany,
          elevation: 0,
          title: const _WsmTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: _WsmTabBar(),
          ),
        ),
        body: const _WsmBody(),
      ),
    );
  }
}

class _WsmTitle extends StatelessWidget {
  const _WsmTitle();
  @override
  Widget build(BuildContext context) {
    return Row(children: const <Widget>[
      Icon(Icons.settings_input_component, color: _WsmPalette.brass, size: 28),
      SizedBox(width: 12),
      Text('WidgetStateMapper<T> - Switchboard Console',
          style: TextStyle(
            color: _WsmPalette.ivory,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          )),
    ]);
  }
}

class _WsmTabBar extends StatelessWidget {
  const _WsmTabBar();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _WsmPalette.mahoganyDark,
      child: const TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: _WsmPalette.brass,
        labelColor: _WsmPalette.brassBright,
        unselectedLabelColor: _WsmPalette.ivoryDim,
        tabs: <Tab>[
          Tab(icon: Icon(Icons.description_outlined), text: 'Dossier'),
          Tab(icon: Icon(Icons.account_tree_outlined), text: 'Anatomy'),
          Tab(icon: Icon(Icons.grid_on_outlined), text: 'Socket Matrix'),
          Tab(icon: Icon(Icons.sort), text: 'First Match'),
          Tab(icon: Icon(Icons.category_outlined), text: 'Generics'),
          Tab(icon: Icon(Icons.call_merge_outlined), text: 'Constraints'),
          Tab(icon: Icon(Icons.touch_app_outlined), text: 'Wired'),
          Tab(icon: Icon(Icons.restaurant_menu_outlined), text: 'Recipes'),
          Tab(icon: Icon(Icons.compare_arrows_outlined), text: 'Compare'),
          Tab(icon: Icon(Icons.menu_book_outlined), text: 'Glossary'),
        ],
      ),
    );
  }
}

class _WsmBody extends StatelessWidget {
  const _WsmBody();
  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: <Widget>[
      _WsmDossierTab(),
      _WsmAnatomyTab(),
      _WsmMatrixTab(),
      _WsmFirstMatchTab(),
      _WsmGenericsTab(),
      _WsmConstraintsTab(),
      _WsmWiredTab(),
      _WsmRecipesTab(),
      _WsmCompareTab(),
      _WsmGlossaryTab(),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared ornaments - brass bezels, mahogany panels, plaque labels, lamps.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmPanel extends StatelessWidget {
  const _WsmPanel({
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_WsmPalette.mahoganyLight, _WsmPalette.mahogany],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _WsmPalette.brass, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x66000000), blurRadius: 12, offset: Offset(0, 6)),
          BoxShadow(color: Color(0x22DDB060), blurRadius: 2, offset: Offset(0, -1)),
        ],
      ),
      child: child,
    );
  }
}

class _WsmPlaque extends StatelessWidget {
  const _WsmPlaque({required this.title, this.subtitle});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_WsmPalette.brassDark, _WsmPalette.brass, _WsmPalette.brassDark],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x55000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(title,
            style: const TextStyle(
              color: _WsmPalette.mahoganyDark,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              fontSize: 15,
            )),
        if (subtitle != null) ...<Widget>[
          const SizedBox(height: 2),
          Text(subtitle!,
              style: const TextStyle(
                color: _WsmPalette.mahogany,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 11,
              )),
        ],
      ]),
    );
  }
}

class _WsmSection extends StatelessWidget {
  const _WsmSection({required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        _WsmPlaque(title: title, subtitle: subtitle),
        const SizedBox(height: 16),
        child,
      ]),
    );
  }
}

class _WsmLamp extends StatelessWidget {
  const _WsmLamp({
    required this.lit,
    this.color = _WsmPalette.lampAmber,
    this.size = 18,
  });
  final bool lit;
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            lit ? color : const Color(0xFF2A1F14),
            lit ? color.withValues(alpha: 0.5) : const Color(0xFF1A120C),
            _WsmPalette.mahoganyDark,
          ],
          stops: const <double>[0.0, 0.55, 1.0],
        ),
        border: Border.all(color: _WsmPalette.brassDark, width: 1.2),
        boxShadow: lit
            ? <BoxShadow>[
                BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 8, spreadRadius: 1),
              ]
            : const <BoxShadow>[],
      ),
    );
  }
}

class _WsmSocket extends StatelessWidget {
  const _WsmSocket({required this.plugged});
  final bool plugged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: <Color>[_WsmPalette.mahoganyDark, Color(0xFF0A0604)],
          stops: <double>[0.3, 1.0],
        ),
        border: Border.all(color: _WsmPalette.brass, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x88000000), blurRadius: 3, offset: Offset(1, 2)),
        ],
      ),
      child: plugged
          ? Center(
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: <Color>[_WsmPalette.cableRed, Color(0xFF5A1A10)],
                  ),
                  border: Border.all(color: _WsmPalette.brassBright, width: 1),
                ),
              ),
            )
          : null,
    );
  }
}

class _WsmCodeBlock extends StatelessWidget {
  const _WsmCodeBlock({required this.code});
  final String code;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E0806),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _WsmPalette.brassDark, width: 1),
      ),
      child: Text(code,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: _WsmPalette.paperLabel,
            fontSize: 12,
            height: 1.45,
          )),
    );
  }
}

class _WsmBullet extends StatelessWidget {
  const _WsmBullet({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 10),
          child: _WsmLamp(lit: true, size: 8),
        ),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                color: _WsmPalette.ivoryDim,
                fontSize: 13,
                height: 1.4,
              )),
        ),
      ]),
    );
  }
}

class _WsmStateChip extends StatelessWidget {
  const _WsmStateChip({
    required this.label,
    required this.active,
    required this.onTap,
    this.color = _WsmPalette.lampAmber,
  });
  final String label;
  final bool active;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? color.withValues(alpha: 0.22) : _WsmPalette.mahoganyDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? color : _WsmPalette.brassDark,
            width: active ? 1.6 : 1,
          ),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _WsmLamp(lit: active, color: color, size: 10),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                color: active ? _WsmPalette.ivory : _WsmPalette.ivoryDim,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              )),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1: Dossier / Preamble - six operator briefing cards.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmDossierTab extends StatelessWidget {
  const _WsmDossierTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'OPERATOR DOSSIER',
      subtitle: 'Mapping widget states to resolved values, the disciplined way',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmDossierCard(
          number: '01',
          title: 'What WidgetStateMapper<T> is',
          lead: 'A generic, immutable resolver that walks an ordered map.',
          body:
              'WidgetStateMapper<T> is a const-constructible implementation of '
              'WidgetStateProperty<T> backed by a Map<WidgetStatesConstraint, T>. '
              'When a consumer asks it to resolve a value for a particular set of '
              'active widget states, it iterates the map in declaration order and '
              'returns the first entry whose constraint is satisfied. Think of it '
              'as a switchboard lookup table - one row per rule, first green lamp '
              'wins.',
          icon: Icons.description_outlined,
        ),
        SizedBox(height: 14),
        _WsmDossierCard(
          number: '02',
          title: 'The generic parameter T',
          lead: 'Any value type can be mapped - Color, double, String, TextStyle, BorderSide...',
          body:
              'The T in WidgetStateMapper<T> is the produced value. The same '
              'resolution machinery powers WidgetStateColor.fromMap (T = Color), '
              'WidgetStateTextStyle.fromMap (T = TextStyle), WidgetStateBorderSide '
              '(T = BorderSide?), and the generic WidgetStateProperty.fromMap<S>. '
              'The mapper itself is value-agnostic - it never inspects T beyond '
              'returning it.',
          icon: Icons.category_outlined,
        ),
        SizedBox(height: 14),
        _WsmDossierCard(
          number: '03',
          title: 'How resolve walks the map',
          lead: 'Declaration order, first-match-wins, no fallback.',
          body:
              'resolve(Set<WidgetState> states) iterates map.entries. For each '
              'entry it calls constraint.isSatisfiedBy(states). The first true '
              'returns the associated value. If the walk finishes without a '
              'match, the mapper throws an ArgumentError. Responsible operators '
              'therefore terminate every map with WidgetState.any (or an '
              'equivalent catch-all) as an insurance line to ground.',
          icon: Icons.list_alt_outlined,
        ),
        SizedBox(height: 14),
        _WsmDossierCard(
          number: '04',
          title: 'Relation to WidgetStateProperty',
          lead: 'Mapper = static-map strategy; resolveWith = functional strategy.',
          body:
              'WidgetStateProperty has three siblings: WidgetStatePropertyAll '
              '(constant value), WidgetStateProperty.resolveWith (a function '
              'that takes a state set and returns T), and WidgetStateProperty.'
              'fromMap which delegates to WidgetStateMapper. Use the mapper '
              'when your decision table is declarative - you can read it top to '
              'bottom like a circuit diagram.',
          icon: Icons.account_tree_outlined,
        ),
        SizedBox(height: 14),
        _WsmDossierCard(
          number: '05',
          title: 'Constraint composition',
          lead: 'WidgetState values AND compound expressions are both accepted.',
          body:
              'Keys are of type WidgetStatesConstraint. A bare WidgetState '
              '(e.g. WidgetState.hovered) is treated as a single-state '
              'predicate. Compound expressions use the operators & (both), '
              '| (either), and ~ (not), e.g. WidgetState.hovered & '
              '~WidgetState.disabled. WidgetState.any is a universal match, '
              'suitable as the terminal default.',
          icon: Icons.call_merge_outlined,
        ),
        SizedBox(height: 14),
        _WsmDossierCard(
          number: '06',
          title: 'Why operators prefer it',
          lead: 'Declarative, const, auditable, cheap.',
          body:
              'A const WidgetStateMapper is a cheap, shareable value. Reviewers '
              'can read the map like a specification. Unit tests can call '
              'resolve(stateSet) directly without instantiating a widget. And '
              'because ordering is explicit, the behaviour is deterministic - '
              'no closure to step through, no hidden branches.',
          icon: Icons.verified_outlined,
        ),
      ]),
    );
  }
}

class _WsmDossierCard extends StatelessWidget {
  const _WsmDossierCard({
    required this.number,
    required this.title,
    required this.lead,
    required this.body,
    required this.icon,
  });
  final String number;
  final String title;
  final String lead;
  final String body;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: <Color>[_WsmPalette.brassBright, _WsmPalette.brassDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: _WsmPalette.ivory, width: 1.4),
          ),
          child: Center(
            child: Text(number,
                style: const TextStyle(
                  color: _WsmPalette.mahoganyDark,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                )),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Icon(icon, color: _WsmPalette.brassBright, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                      color: _WsmPalette.ivory,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    )),
              ),
            ]),
            const SizedBox(height: 6),
            Text(lead,
                style: const TextStyle(
                  color: _WsmPalette.lampAmber,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 10),
            Text(body,
                style: const TextStyle(
                  color: _WsmPalette.ivoryDim,
                  fontSize: 13,
                  height: 1.5,
                )),
          ]),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2: Anatomy - class declaration, typedef, resolve signature, rules.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmAnatomyTab extends StatelessWidget {
  const _WsmAnatomyTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'ANATOMY',
      subtitle: 'The class declaration line by line',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmAnatomyBlock(
          heading: 'Class declaration',
          note: 'from package:flutter/src/widgets/widget_state.dart',
          code:
              '@immutable\n'
              'class WidgetStateMapper<T> implements WidgetStateProperty<T> {\n'
              '  const WidgetStateMapper(this.map);\n'
              '\n'
              '  final WidgetStateMap<T> map;\n'
              '\n'
              '  @override\n'
              '  T resolve(Set<WidgetState> states) {\n'
              '    for (final MapEntry<WidgetStatesConstraint, T> entry\n'
              '        in map.entries) {\n'
              '      if (entry.key.isSatisfiedBy(states)) {\n'
              '        return entry.value;\n'
              '      }\n'
              '    }\n'
              '    throw ArgumentError(\n'
              '      \'The current set of material states is not satisfied by \'\n'
              '      \'any of the provided WidgetStatesConstraints in the Map.\\n\'\n'
              '      \'  states: \$states\\n\'\n'
              '      \'  constraints: \${map.keys}\',\n'
              '    );\n'
              '  }\n'
              '}',
        ),
        SizedBox(height: 14),
        _WsmAnatomyBlock(
          heading: 'WidgetStateMap typedef',
          note: 'same file - ordered, keyed on constraints',
          code: 'typedef WidgetStateMap<T> = Map<WidgetStatesConstraint, T>;',
        ),
        SizedBox(height: 14),
        _WsmAnatomyBlock(
          heading: 'resolve signature',
          note: 'overrides WidgetStateProperty<T>.resolve',
          code: 'T resolve(Set<WidgetState> states);',
        ),
        SizedBox(height: 14),
        _WsmAnatomyRuleCard(
          title: 'Rule 1 - First match wins',
          text:
              'Iteration happens on map.entries which preserves insertion order '
              'for LinkedHashMap (Dart default). Order the map from MOST specific '
              'to LEAST specific.',
          icon: Icons.looks_one_outlined,
        ),
        SizedBox(height: 10),
        _WsmAnatomyRuleCard(
          title: 'Rule 2 - Always provide a catch-all',
          text:
              'If no constraint matches, resolve throws ArgumentError. Include '
              'WidgetState.any as the final entry to guarantee a default.',
          icon: Icons.looks_two_outlined,
        ),
        SizedBox(height: 10),
        _WsmAnatomyRuleCard(
          title: 'Rule 3 - Constraints are composable',
          text:
              'The keys may be single WidgetState values or expressions built '
              'from the &, |, and ~ operators on WidgetStatesConstraint.',
          icon: Icons.looks_3_outlined,
        ),
        SizedBox(height: 10),
        _WsmAnatomyRuleCard(
          title: 'Rule 4 - The mapper is const and value-typed',
          text:
              'If T and the constraint keys are const-expressions, the mapper '
              'itself can be a constant and reused across rebuilds without '
              'allocation.',
          icon: Icons.looks_4_outlined,
        ),
      ]),
    );
  }
}

class _WsmAnatomyBlock extends StatelessWidget {
  const _WsmAnatomyBlock({
    required this.heading,
    required this.note,
    required this.code,
  });
  final String heading;
  final String note;
  final String code;
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          const Icon(Icons.code, color: _WsmPalette.brassBright, size: 18),
          const SizedBox(width: 8),
          Text(heading,
              style: const TextStyle(
                color: _WsmPalette.ivory,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              )),
        ]),
        const SizedBox(height: 4),
        Text(note,
            style: const TextStyle(
              color: _WsmPalette.ivoryDim,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            )),
        const SizedBox(height: 10),
        _WsmCodeBlock(code: code),
      ]),
    );
  }
}

class _WsmAnatomyRuleCard extends StatelessWidget {
  const _WsmAnatomyRuleCard({
    required this.title,
    required this.text,
    required this.icon,
  });
  final String title;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      padding: const EdgeInsets.all(14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Icon(icon, color: _WsmPalette.lampAmber, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(title,
                style: const TextStyle(
                  color: _WsmPalette.ivory,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                )),
            const SizedBox(height: 4),
            Text(text,
                style: const TextStyle(
                  color: _WsmPalette.ivoryDim,
                  fontSize: 12,
                  height: 1.4,
                )),
          ]),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3: Socket Matrix - live, responsive grid of sockets. Each state is a
// port that can be plugged. A WidgetStateMapper<Color> resolves the jack color.
// The top matched rule pulses via an AnimationController.
// ═══════════════════════════════════════════════════════════════════════════

const List<_WsmStateDescriptor> _wsmStateCatalog = <_WsmStateDescriptor>[
  _WsmStateDescriptor(
      state: WidgetState.hovered,
      label: 'HOVERED',
      color: _WsmPalette.lampBlue,
      letter: 'H'),
  _WsmStateDescriptor(
      state: WidgetState.focused,
      label: 'FOCUSED',
      color: _WsmPalette.lampGreen,
      letter: 'F'),
  _WsmStateDescriptor(
      state: WidgetState.pressed,
      label: 'PRESSED',
      color: _WsmPalette.lampAmber,
      letter: 'P'),
  _WsmStateDescriptor(
      state: WidgetState.selected,
      label: 'SELECTED',
      color: _WsmPalette.brassBright,
      letter: 'S'),
  _WsmStateDescriptor(
      state: WidgetState.disabled,
      label: 'DISABLED',
      color: Color(0xFF8A7A60),
      letter: 'D'),
  _WsmStateDescriptor(
      state: WidgetState.dragged,
      label: 'DRAGGED',
      color: _WsmPalette.cableYellow,
      letter: 'G'),
  _WsmStateDescriptor(
      state: WidgetState.scrolledUnder,
      label: 'SCROLLED',
      color: _WsmPalette.cableRed,
      letter: 'U'),
  _WsmStateDescriptor(
      state: WidgetState.error,
      label: 'ERROR',
      color: _WsmPalette.lampRed,
      letter: 'E'),
];

class _WsmStateDescriptor {
  const _WsmStateDescriptor({
    required this.state,
    required this.label,
    required this.color,
    required this.letter,
  });
  final WidgetState state;
  final String label;
  final Color color;
  final String letter;
}

class _WsmMatrixTab extends StatelessWidget {
  const _WsmMatrixTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'SOCKET MATRIX',
      subtitle: 'Live resolver - toggle ports, watch the mapper pick a line',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmMatrixIntro(),
        SizedBox(height: 14),
        _WsmMatrixBoard(),
        SizedBox(height: 14),
        _WsmMatrixRuleTable(),
      ]),
    );
  }
}

class _WsmMatrixIntro extends StatelessWidget {
  const _WsmMatrixIntro();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        Text('How to read this board',
            style: TextStyle(
              color: _WsmPalette.ivory,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: 8),
        _WsmBullet(
            text:
                'Each socket below represents a WidgetState. Plug it in to add it to the state set.'),
        _WsmBullet(
            text:
                'The mapper walks its rule list top to bottom. The first rule whose constraint is satisfied wins.'),
        _WsmBullet(
            text:
                'The winning rule row pulses. The resolved Color fills the large monitor lamp.'),
      ]),
    );
  }
}

class _WsmMatrixBoard extends StatefulWidget {
  const _WsmMatrixBoard();
  @override
  State<_WsmMatrixBoard> createState() => _WsmMatrixBoardState();
}

class _WsmMatrixBoardState extends State<_WsmMatrixBoard>
    with _WsmTickerShim {
  late final AnimationController _pulse;
  late final AnimationController _idle;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _idle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    _idle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      padding: const EdgeInsets.all(20),
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wsmMatrixStates,
        builder: (BuildContext context, Set<WidgetState> states, _) {
          final _WsmMatrixResolution r = _wsmResolveMatrix(states);
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            _WsmMatrixMonitor(
              resolution: r,
              states: states,
              pulse: _pulse,
              idle: _idle,
            ),
            const SizedBox(height: 16),
            const Text('PORTS',
                style: TextStyle(
                  color: _WsmPalette.brassBright,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  fontSize: 12,
                )),
            const SizedBox(height: 10),
            _WsmMatrixPortStrip(states: states),
          ]);
        },
      ),
    );
  }
}

class _WsmMatrixMonitor extends StatelessWidget {
  const _WsmMatrixMonitor({
    required this.resolution,
    required this.states,
    required this.pulse,
    required this.idle,
  });
  final _WsmMatrixResolution resolution;
  final Set<WidgetState> states;
  final AnimationController pulse;
  final AnimationController idle;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      AnimatedBuilder(
        animation: Listenable.merge(<Listenable>[pulse, idle]),
        builder: (BuildContext context, _) {
          final double pulseValue = 0.6 + 0.4 * pulse.value;
          final double swing = math.sin(idle.value * math.pi * 2) * 4;
          return Transform.translate(
            offset: Offset(0, swing),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    resolution.color.withValues(alpha: pulseValue),
                    resolution.color.withValues(alpha: 0.35),
                    _WsmPalette.mahoganyDark,
                  ],
                  stops: const <double>[0.0, 0.55, 1.0],
                ),
                border: Border.all(color: _WsmPalette.brass, width: 3),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: resolution.color.withValues(alpha: 0.55 * pulseValue),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(resolution.tag,
                    style: const TextStyle(
                      color: _WsmPalette.mahoganyDark,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      letterSpacing: 1.5,
                    )),
              ),
            ),
          );
        },
      ),
      const SizedBox(width: 18),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const Text('RESOLVED',
              style: TextStyle(
                color: _WsmPalette.brassBright,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                fontSize: 12,
              )),
          const SizedBox(height: 4),
          Text(resolution.label,
              style: const TextStyle(
                color: _WsmPalette.ivory,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              )),
          const SizedBox(height: 4),
          Text(resolution.matchedRule,
              style: const TextStyle(
                color: _WsmPalette.lampAmber,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _WsmPalette.mahoganyDark,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _WsmPalette.brassDark, width: 1),
            ),
            child: Text(
              states.isEmpty ? 'states: { }' : 'states: { ${states.map(_wsmShort).join(', ')} }',
              style: const TextStyle(
                color: _WsmPalette.ivoryDim,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ]),
      ),
    ]);
  }
}

String _wsmShort(WidgetState s) {
  if (s == WidgetState.hovered) return 'hovered';
  if (s == WidgetState.focused) return 'focused';
  if (s == WidgetState.pressed) return 'pressed';
  if (s == WidgetState.selected) return 'selected';
  if (s == WidgetState.disabled) return 'disabled';
  if (s == WidgetState.dragged) return 'dragged';
  if (s == WidgetState.scrolledUnder) return 'scrolledUnder';
  if (s == WidgetState.error) return 'error';
  return s.toString();
}

class _WsmMatrixPortStrip extends StatelessWidget {
  const _WsmMatrixPortStrip({required this.states});
  final Set<WidgetState> states;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        for (final _WsmStateDescriptor d in _wsmStateCatalog)
          _WsmPortJack(descriptor: d, active: states.contains(d.state)),
      ],
    );
  }
}

class _WsmPortJack extends StatelessWidget {
  const _WsmPortJack({required this.descriptor, required this.active});
  final _WsmStateDescriptor descriptor;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _wsmToggle(_wsmMatrixStates, descriptor.state),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 88,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? descriptor.color.withValues(alpha: 0.18)
              : _WsmPalette.mahoganyDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? descriptor.color : _WsmPalette.brassDark,
            width: active ? 1.6 : 1,
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _WsmSocket(plugged: active),
          const SizedBox(height: 8),
          Text(descriptor.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: active ? _WsmPalette.ivory : _WsmPalette.ivoryDim,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              )),
          const SizedBox(height: 3),
          _WsmLamp(
              lit: active,
              color: descriptor.color,
              size: 8),
        ]),
      ),
    );
  }
}

class _WsmMatrixResolution {
  const _WsmMatrixResolution({
    required this.color,
    required this.label,
    required this.matchedRule,
    required this.tag,
    required this.matchedIndex,
  });
  final Color color;
  final String label;
  final String matchedRule;
  final String tag;
  final int matchedIndex;
}

// The canonical mapper for the matrix demo. Declaration order matters.
// Kept as a top-level const so the demo can also iterate the same map
// (WidgetStateMapper exposes resolve but not its internal map publicly).
const Map<WidgetStatesConstraint, _WsmMatrixEntry> _wsmMatrixMap =
    <WidgetStatesConstraint, _WsmMatrixEntry>{
  WidgetState.error: _WsmMatrixEntry(
    color: _WsmPalette.lampRed,
    label: 'Fault line - line 108',
    rule: 'WidgetState.error',
    tag: 'ERR',
  ),
  WidgetState.disabled: _WsmMatrixEntry(
    color: Color(0xFF6E6555),
    label: 'Muted - circuit grounded',
    rule: 'WidgetState.disabled',
    tag: 'OFF',
  ),
  WidgetState.dragged: _WsmMatrixEntry(
    color: _WsmPalette.cableYellow,
    label: 'Cable in transit',
    rule: 'WidgetState.dragged',
    tag: 'DRG',
  ),
  WidgetState.pressed: _WsmMatrixEntry(
    color: _WsmPalette.lampAmber,
    label: 'Key depressed',
    rule: 'WidgetState.pressed',
    tag: 'PRS',
  ),
  WidgetState.selected: _WsmMatrixEntry(
    color: _WsmPalette.brassBright,
    label: 'Circuit selected',
    rule: 'WidgetState.selected',
    tag: 'SEL',
  ),
  WidgetState.hovered: _WsmMatrixEntry(
    color: _WsmPalette.lampBlue,
    label: 'Finger approaching',
    rule: 'WidgetState.hovered',
    tag: 'HOV',
  ),
  WidgetState.focused: _WsmMatrixEntry(
    color: _WsmPalette.lampGreen,
    label: 'Line cued',
    rule: 'WidgetState.focused',
    tag: 'FOC',
  ),
  WidgetState.scrolledUnder: _WsmMatrixEntry(
    color: _WsmPalette.cableRed,
    label: 'Board slid under',
    rule: 'WidgetState.scrolledUnder',
    tag: 'SCR',
  ),
  WidgetState.any: _WsmMatrixEntry(
    color: Color(0xFF8A7A60),
    label: 'Idle - nothing plugged',
    rule: 'WidgetState.any (default)',
    tag: 'IDL',
  ),
};

WidgetStateMapper<_WsmMatrixEntry> _wsmMatrixMapper() =>
    const WidgetStateMapper<_WsmMatrixEntry>(_wsmMatrixMap);

class _WsmMatrixEntry {
  const _WsmMatrixEntry({
    required this.color,
    required this.label,
    required this.rule,
    required this.tag,
  });
  final Color color;
  final String label;
  final String rule;
  final String tag;
}

_WsmMatrixResolution _wsmResolveMatrix(Set<WidgetState> states) {
  final WidgetStateMapper<_WsmMatrixEntry> mapper = _wsmMatrixMapper();
  final _WsmMatrixEntry entry = mapper.resolve(states);
  final List<WidgetStatesConstraint> keys = _wsmMatrixMap.keys.toList();
  int matchedIndex = keys.length - 1;
  for (int i = 0; i < keys.length; i++) {
    if (keys[i].isSatisfiedBy(states)) {
      matchedIndex = i;
      break;
    }
  }
  return _WsmMatrixResolution(
    color: entry.color,
    label: entry.label,
    matchedRule: entry.rule,
    tag: entry.tag,
    matchedIndex: matchedIndex,
  );
}

class _WsmMatrixRuleTable extends StatelessWidget {
  const _WsmMatrixRuleTable();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wsmMatrixStates,
        builder: (BuildContext context, Set<WidgetState> states, _) {
          final List<MapEntry<WidgetStatesConstraint, _WsmMatrixEntry>> rows =
              _wsmMatrixMap.entries.toList();
          final _WsmMatrixResolution r = _wsmResolveMatrix(states);
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('RULE TABLE (declaration order)',
                style: TextStyle(
                  color: _WsmPalette.brassBright,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                )),
            const SizedBox(height: 10),
            for (int i = 0; i < rows.length; i++)
              _WsmRuleRow(
                index: i + 1,
                rule: rows[i].value.rule,
                value: rows[i].value.label,
                color: rows[i].value.color,
                matched: i == r.matchedIndex,
                satisfied: rows[i].key.isSatisfiedBy(states),
              ),
          ]);
        },
      ),
    );
  }
}

class _WsmRuleRow extends StatelessWidget {
  const _WsmRuleRow({
    required this.index,
    required this.rule,
    required this.value,
    required this.color,
    required this.matched,
    required this.satisfied,
  });
  final int index;
  final String rule;
  final String value;
  final Color color;
  final bool matched;
  final bool satisfied;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: matched ? color.withValues(alpha: 0.22) : _WsmPalette.mahoganyDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: matched ? color : _WsmPalette.brassDark,
          width: matched ? 1.6 : 1,
        ),
      ),
      child: Row(children: <Widget>[
        SizedBox(
          width: 22,
          child: Text('$index.',
              style: const TextStyle(
                color: _WsmPalette.brassBright,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              )),
        ),
        _WsmLamp(
            lit: matched,
            color: matched ? color : (satisfied ? _WsmPalette.lampGreen : _WsmPalette.brassDark),
            size: 10),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(rule,
              style: const TextStyle(
                color: _WsmPalette.ivory,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              )),
        ),
        Expanded(
          flex: 3,
          child: Text(value,
              style: const TextStyle(
                color: _WsmPalette.ivoryDim,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              )),
        ),
        if (matched)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text('WINS',
                style: TextStyle(
                  color: _WsmPalette.lampAmber,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  letterSpacing: 1.4,
                )),
          ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 4: First Match demonstration. Five overlapping constraints illustrate
// how reordering the SAME rule set produces DIFFERENT resolved values.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmFirstMatchTab extends StatelessWidget {
  const _WsmFirstMatchTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'FIRST MATCH',
      subtitle: 'Declaration order is the rule - reorder and the winner changes',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmPanel(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text('The overlapping rule set',
                style: TextStyle(
                  color: _WsmPalette.ivory,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(height: 8),
            _WsmBullet(
                text:
                    'We define five entries with deliberately overlapping constraints.'),
            _WsmBullet(
                text:
                    'Each entry has a color and a short label describing the rule.'),
            _WsmBullet(
                text:
                    'Toggle WidgetStates below and watch the FIRST satisfied rule light up.'),
          ]),
        ),
        SizedBox(height: 14),
        _WsmFirstMatchStateBar(),
        SizedBox(height: 14),
        _WsmFirstMatchList(),
        SizedBox(height: 14),
        _WsmFirstMatchReorderNote(),
      ]),
    );
  }
}

class _WsmFirstMatchStateBar extends StatelessWidget {
  const _WsmFirstMatchStateBar();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      padding: const EdgeInsets.all(14),
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wsmFirstMatchStates,
        builder: (BuildContext context, Set<WidgetState> states, _) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('TOGGLE STATES',
                style: TextStyle(
                  color: _WsmPalette.brassBright,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                )),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
              for (final _WsmStateDescriptor d in _wsmStateCatalog)
                _WsmStateChip(
                  label: d.label,
                  active: states.contains(d.state),
                  onTap: () => _wsmToggle(_wsmFirstMatchStates, d.state),
                  color: d.color,
                ),
            ]),
          ]);
        },
      ),
    );
  }
}

const List<_WsmFirstMatchEntry> _wsmFirstMatchEntries = <_WsmFirstMatchEntry>[
  _WsmFirstMatchEntry(
    key: 'error-first',
    label: 'error wins everything else',
    expression: 'WidgetState.error',
    color: _WsmPalette.lampRed,
    note: 'Errors outrank selection, hover, focus, press.',
  ),
  _WsmFirstMatchEntry(
    key: 'disabled-second',
    label: 'disabled mutes the panel',
    expression: 'WidgetState.disabled',
    color: Color(0xFF6E6555),
    note: 'Second in line - disabled + hover still routes here.',
  ),
  _WsmFirstMatchEntry(
    key: 'pressed-and-selected',
    label: 'pressed + selected co-highlight',
    expression: 'WidgetState.pressed & WidgetState.selected',
    color: _WsmPalette.brassBright,
    note: 'Specific compound rule, placed before the single ones.',
  ),
  _WsmFirstMatchEntry(
    key: 'pressed',
    label: 'pressed alone',
    expression: 'WidgetState.pressed',
    color: _WsmPalette.lampAmber,
    note: 'Would eclipse the compound rule above if moved higher.',
  ),
  _WsmFirstMatchEntry(
    key: 'any',
    label: 'default catch-all',
    expression: 'WidgetState.any',
    color: _WsmPalette.lampBlue,
    note: 'Always true - guarantees resolve never throws.',
  ),
];

class _WsmFirstMatchEntry {
  const _WsmFirstMatchEntry({
    required this.key,
    required this.label,
    required this.expression,
    required this.color,
    required this.note,
  });
  final String key;
  final String label;
  final String expression;
  final Color color;
  final String note;
}

final Map<WidgetStatesConstraint, Color> _wsmFirstMatchColorMap =
    <WidgetStatesConstraint, Color>{
  WidgetState.error: _WsmPalette.lampRed,
  WidgetState.disabled: const Color(0xFF6E6555),
  WidgetState.pressed & WidgetState.selected: _WsmPalette.brassBright,
  WidgetState.pressed: _WsmPalette.lampAmber,
  WidgetState.any: _WsmPalette.lampBlue,
};

int _wsmFirstMatchResolveIndex(Set<WidgetState> states) {
  // Build the mapper to demonstrate it works alongside the legend list.
  final WidgetStateMapper<Color> mapper =
      WidgetStateMapper<Color>(_wsmFirstMatchColorMap);
  // Ensure resolve works and returns a valid value (exercise the API).
  mapper.resolve(states);
  final List<WidgetStatesConstraint> keys =
      _wsmFirstMatchColorMap.keys.toList();
  for (int i = 0; i < keys.length; i++) {
    if (keys[i].isSatisfiedBy(states)) return i;
  }
  return keys.length - 1;
}

class _WsmFirstMatchList extends StatelessWidget {
  const _WsmFirstMatchList();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wsmFirstMatchStates,
        builder: (BuildContext context, Set<WidgetState> states, _) {
          final int winner = _wsmFirstMatchResolveIndex(states);
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('ORDERED MAP (declaration order)',
                style: TextStyle(
                  color: _WsmPalette.brassBright,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                )),
            const SizedBox(height: 10),
            for (int i = 0; i < _wsmFirstMatchEntries.length; i++)
              _WsmFirstMatchRow(
                position: i + 1,
                entry: _wsmFirstMatchEntries[i],
                matched: i == winner,
                satisfied: _wsmEvaluateExpression(
                    _wsmFirstMatchEntries[i].key, states),
                skipped: i < winner,
                dead: i > winner,
              ),
          ]);
        },
      ),
    );
  }
}

bool _wsmEvaluateExpression(String key, Set<WidgetState> states) {
  switch (key) {
    case 'error-first':
      return states.contains(WidgetState.error);
    case 'disabled-second':
      return states.contains(WidgetState.disabled);
    case 'pressed-and-selected':
      return states.contains(WidgetState.pressed) &&
          states.contains(WidgetState.selected);
    case 'pressed':
      return states.contains(WidgetState.pressed);
    case 'any':
      return true;
  }
  return false;
}

class _WsmFirstMatchRow extends StatelessWidget {
  const _WsmFirstMatchRow({
    required this.position,
    required this.entry,
    required this.matched,
    required this.satisfied,
    required this.skipped,
    required this.dead,
  });
  final int position;
  final _WsmFirstMatchEntry entry;
  final bool matched;
  final bool satisfied;
  final bool skipped;
  final bool dead;

  @override
  Widget build(BuildContext context) {
    Color border = _WsmPalette.brassDark;
    Color bg = _WsmPalette.mahoganyDark;
    String tag = '';
    Color tagColor = _WsmPalette.ivoryDim;
    if (matched) {
      border = entry.color;
      bg = entry.color.withValues(alpha: 0.22);
      tag = 'WINS';
      tagColor = _WsmPalette.lampAmber;
    } else if (skipped) {
      tag = 'SKIP';
      tagColor = const Color(0xFF8A7A60);
    } else if (dead) {
      tag = 'DEAD';
      tagColor = const Color(0xFF5C5240);
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border, width: matched ? 1.6 : 1),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SizedBox(
          width: 24,
          child: Text('$position.',
              style: const TextStyle(
                color: _WsmPalette.brassBright,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              )),
        ),
        _WsmLamp(
            lit: matched,
            color: matched
                ? entry.color
                : (satisfied ? _WsmPalette.lampGreen : _WsmPalette.brassDark),
            size: 12),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(entry.expression,
                style: const TextStyle(
                  color: _WsmPalette.ivory,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(height: 2),
            Text(entry.label,
                style: const TextStyle(
                  color: _WsmPalette.lampAmber,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                )),
            const SizedBox(height: 2),
            Text(entry.note,
                style: const TextStyle(
                  color: _WsmPalette.ivoryDim,
                  fontSize: 11,
                )),
          ]),
        ),
        if (tag.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _WsmPalette.mahoganyDark,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: tagColor, width: 1),
            ),
            child: Text(tag,
                style: TextStyle(
                  color: tagColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  letterSpacing: 1.4,
                )),
          ),
      ]),
    );
  }
}

class _WsmFirstMatchReorderNote extends StatelessWidget {
  const _WsmFirstMatchReorderNote();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        Text('Order matters - try these thought experiments',
            style: TextStyle(
              color: _WsmPalette.ivory,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: 8),
        _WsmBullet(
            text:
                'If WidgetState.any were first, every other rule would be dead code.'),
        _WsmBullet(
            text:
                'If WidgetState.pressed were placed above the compound pressed & selected rule, the compound rule would never light up.'),
        _WsmBullet(
            text:
                'Because error is first, even adding selected or pressed will not change the verdict while error is set.'),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 5: Generic-type showcase - three mappers side by side.
//   * WidgetStateMapper<Color>   - drives a background
//   * WidgetStateMapper<double>  - drives a rotation angle
//   * WidgetStateMapper<String>  - drives a display label
// ═══════════════════════════════════════════════════════════════════════════

class _WsmGenericsTab extends StatelessWidget {
  const _WsmGenericsTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'GENERIC TYPES',
      subtitle: 'Same resolver class, different value types',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmGenericsIntro(),
        SizedBox(height: 14),
        _WsmGenericsStateBar(),
        SizedBox(height: 14),
        _WsmGenericsShowcase(),
        SizedBox(height: 14),
        _WsmGenericsCodeShelf(),
      ]),
    );
  }
}

class _WsmGenericsIntro extends StatelessWidget {
  const _WsmGenericsIntro();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        Text('One algorithm, many value types',
            style: TextStyle(
              color: _WsmPalette.ivory,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: 8),
        _WsmBullet(
            text:
                'WidgetStateMapper is generic; T is carried through unchanged.'),
        _WsmBullet(
            text:
                'Reusing the pattern for Color, double, String, BorderSide etc. keeps the styling language consistent.'),
        _WsmBullet(
            text:
                'All three mappers below share the same state set; toggle states and every lane reacts.'),
      ]),
    );
  }
}

class _WsmGenericsStateBar extends StatelessWidget {
  const _WsmGenericsStateBar();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      padding: const EdgeInsets.all(14),
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wsmGenericStates,
        builder: (BuildContext context, Set<WidgetState> states, _) {
          return Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
            for (final _WsmStateDescriptor d in _wsmStateCatalog)
              _WsmStateChip(
                label: d.label,
                active: states.contains(d.state),
                onTap: () => _wsmToggle(_wsmGenericStates, d.state),
                color: d.color,
              ),
          ]);
        },
      ),
    );
  }
}

WidgetStateMapper<Color> _wsmGenericColorMapper() {
  return const WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{
    WidgetState.error: _WsmPalette.lampRed,
    WidgetState.disabled: Color(0xFF5C5240),
    WidgetState.pressed: _WsmPalette.lampAmber,
    WidgetState.selected: _WsmPalette.brassBright,
    WidgetState.hovered: _WsmPalette.lampBlue,
    WidgetState.focused: _WsmPalette.lampGreen,
    WidgetState.any: _WsmPalette.mahogany,
  });
}

WidgetStateMapper<double> _wsmGenericAngleMapper() {
  return const WidgetStateMapper<double>(<WidgetStatesConstraint, double>{
    WidgetState.error: 0.0,
    WidgetState.disabled: 0.0,
    WidgetState.pressed: 0.25,
    WidgetState.dragged: -0.25,
    WidgetState.selected: 0.08,
    WidgetState.hovered: -0.05,
    WidgetState.focused: 0.02,
    WidgetState.any: 0.0,
  });
}

WidgetStateMapper<String> _wsmGenericLabelMapper() {
  return const WidgetStateMapper<String>(<WidgetStatesConstraint, String>{
    WidgetState.error: 'FAULT',
    WidgetState.disabled: 'OFFLINE',
    WidgetState.pressed: 'CONNECTING',
    WidgetState.dragged: 'ROUTING',
    WidgetState.selected: 'PATCHED',
    WidgetState.hovered: 'READY',
    WidgetState.focused: 'CUED',
    WidgetState.scrolledUnder: 'UNDER-PANEL',
    WidgetState.any: 'IDLE',
  });
}

class _WsmGenericsShowcase extends StatelessWidget {
  const _WsmGenericsShowcase();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wsmGenericStates,
      builder: (BuildContext context, Set<WidgetState> states, _) {
        final Color c = _wsmGenericColorMapper().resolve(states);
        final double angle = _wsmGenericAngleMapper().resolve(states);
        final String label = _wsmGenericLabelMapper().resolve(states);
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool narrow = constraints.maxWidth < 640;
            final Widget colorCard =
                _WsmGenericCard(title: 'Color', typeParam: 'WidgetStateMapper<Color>', child: _WsmColorDisc(color: c));
            final Widget angleCard =
                _WsmGenericCard(title: 'Angle (double)', typeParam: 'WidgetStateMapper<double>', child: _WsmAngleDial(angle: angle));
            final Widget labelCard =
                _WsmGenericCard(title: 'Label (String)', typeParam: 'WidgetStateMapper<String>', child: _WsmLabelPanel(label: label));
            if (narrow) {
              return Column(children: <Widget>[
                colorCard,
                const SizedBox(height: 12),
                angleCard,
                const SizedBox(height: 12),
                labelCard,
              ]);
            }
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Expanded(child: colorCard),
              const SizedBox(width: 12),
              Expanded(child: angleCard),
              const SizedBox(width: 12),
              Expanded(child: labelCard),
            ]);
          },
        );
      },
    );
  }
}

class _WsmGenericCard extends StatelessWidget {
  const _WsmGenericCard({
    required this.title,
    required this.typeParam,
    required this.child,
  });
  final String title;
  final String typeParam;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(title,
            style: const TextStyle(
              color: _WsmPalette.ivory,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            )),
        Text(typeParam,
            style: const TextStyle(
              color: _WsmPalette.lampAmber,
              fontSize: 11,
              fontStyle: FontStyle.italic,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 14),
        Center(child: child),
      ]),
    );
  }
}

class _WsmColorDisc extends StatelessWidget {
  const _WsmColorDisc({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            color,
            Color.alphaBlend(color.withValues(alpha: 0.4), _WsmPalette.mahoganyDark),
            _WsmPalette.mahoganyDark,
          ],
          stops: const <double>[0.0, 0.6, 1.0],
        ),
        border: Border.all(color: _WsmPalette.brass, width: 3),
        boxShadow: <BoxShadow>[
          BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 14, spreadRadius: 1),
        ],
      ),
    );
  }
}

class _WsmAngleDial extends StatelessWidget {
  const _WsmAngleDial({required this.angle});
  final double angle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: <Color>[_WsmPalette.mahoganyLight, _WsmPalette.mahoganyDark],
            ),
            border: Border.all(color: _WsmPalette.brass, width: 3),
          ),
        ),
        AnimatedRotation(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          turns: angle,
          child: CustomPaint(
            size: const Size(130, 130),
            painter: _WsmDialNeedlePainter(),
          ),
        ),
        Container(
          width: 14,
          height: 14,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: _WsmPalette.brassBright,
          ),
        ),
        Positioned(
          bottom: 10,
          child: Text('${(angle * 360).toStringAsFixed(0)}°',
              style: const TextStyle(
                color: _WsmPalette.lampAmber,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              )),
        ),
      ]),
    );
  }
}

class _WsmDialNeedlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..color = _WsmPalette.lampAmber
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, Offset(center.dx, center.dy - size.height / 2 + 14), paint);
    final Paint tick = Paint()
      ..color = _WsmPalette.brassDark
      ..strokeWidth = 1.5;
    for (int i = 0; i < 12; i++) {
      final double a = i * math.pi / 6;
      final Offset p1 = center + Offset(math.cos(a), math.sin(a)) * (size.width / 2 - 4);
      final Offset p2 = center + Offset(math.cos(a), math.sin(a)) * (size.width / 2 - 12);
      canvas.drawLine(p1, p2, tick);
    }
  }

  @override
  bool shouldRepaint(covariant _WsmDialNeedlePainter oldDelegate) => false;
}

class _WsmLabelPanel extends StatelessWidget {
  const _WsmLabelPanel({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _WsmPalette.mahoganyDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _WsmPalette.brass, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x77000000), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const Text('STATUS',
            style: TextStyle(
              color: _WsmPalette.brassBright,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.4,
            )),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          child: Text(label,
              key: ValueKey<String>(label),
              style: const TextStyle(
                color: _WsmPalette.lampAmber,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 1.6,
              )),
        ),
      ]),
    );
  }
}

class _WsmGenericsCodeShelf extends StatelessWidget {
  const _WsmGenericsCodeShelf();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        Text('Three mappers, one pattern',
            style: TextStyle(
              color: _WsmPalette.ivory,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: 8),
        _WsmCodeBlock(code:
            'const WidgetStateMapper<Color> background =\n'
            '    WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{\n'
            '  WidgetState.error: Colors.red,\n'
            '  WidgetState.disabled: Colors.grey,\n'
            '  WidgetState.pressed: Colors.amber,\n'
            '  WidgetState.hovered: Colors.blueGrey,\n'
            '  WidgetState.any: Colors.brown,\n'
            '});'),
        SizedBox(height: 10),
        _WsmCodeBlock(code:
            'const WidgetStateMapper<double> rotation =\n'
            '    WidgetStateMapper<double>(<WidgetStatesConstraint, double>{\n'
            '  WidgetState.pressed: 0.25,\n'
            '  WidgetState.dragged: -0.25,\n'
            '  WidgetState.any: 0.0,\n'
            '});'),
        SizedBox(height: 10),
        _WsmCodeBlock(code:
            'const WidgetStateMapper<String> label =\n'
            '    WidgetStateMapper<String>(<WidgetStatesConstraint, String>{\n'
            '  WidgetState.error: "FAULT",\n'
            '  WidgetState.disabled: "OFFLINE",\n'
            '  WidgetState.any: "IDLE",\n'
            '});'),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 6: Constraint composition. Demonstrate & | ~ with boolean trees painted
// by a CustomPainter. The active state set highlights satisfied nodes.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmConstraintsTab extends StatelessWidget {
  const _WsmConstraintsTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'CONSTRAINT COMPOSITION',
      subtitle: 'Build predicates with & (and), | (or), ~ (not)',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmConstraintStateBar(),
        SizedBox(height: 14),
        _WsmConstraintCard(
          title: 'hovered AND NOT disabled',
          expression: 'WidgetState.hovered & ~WidgetState.disabled',
          rationale: 'Hover effects should switch off when the control is disabled.',
          op: _WsmOp.and,
          a: _WsmLeaf.hovered,
          b: _WsmLeaf.notDisabled,
        ),
        SizedBox(height: 12),
        _WsmConstraintCard(
          title: 'focused OR selected',
          expression: 'WidgetState.focused | WidgetState.selected',
          rationale: 'Either signal highlights the row for accessibility readers.',
          op: _WsmOp.or,
          a: _WsmLeaf.focused,
          b: _WsmLeaf.selected,
        ),
        SizedBox(height: 12),
        _WsmConstraintCard(
          title: 'NOT error',
          expression: '~WidgetState.error',
          rationale: 'Default branch - everything that is not an error.',
          op: _WsmOp.not,
          a: _WsmLeaf.error,
          b: null,
        ),
        SizedBox(height: 12),
        _WsmConstraintCard(
          title: 'pressed AND (hovered OR focused)',
          expression: 'WidgetState.pressed & (WidgetState.hovered | WidgetState.focused)',
          rationale: 'Composite - outer AND, inner OR. Parentheses clarify priority.',
          op: _WsmOp.andGroup,
          a: _WsmLeaf.pressed,
          b: _WsmLeaf.hoveredOrFocused,
        ),
      ]),
    );
  }
}

class _WsmConstraintStateBar extends StatelessWidget {
  const _WsmConstraintStateBar();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      padding: const EdgeInsets.all(14),
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wsmCompositionStates,
        builder: (BuildContext context, Set<WidgetState> states, _) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('TOGGLE STATES TO EVALUATE',
                style: TextStyle(
                  color: _WsmPalette.brassBright,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                )),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
              for (final _WsmStateDescriptor d in _wsmStateCatalog)
                _WsmStateChip(
                  label: d.label,
                  active: states.contains(d.state),
                  onTap: () => _wsmToggle(_wsmCompositionStates, d.state),
                  color: d.color,
                ),
            ]),
          ]);
        },
      ),
    );
  }
}

enum _WsmOp { and, or, not, andGroup }

enum _WsmLeaf {
  hovered,
  notDisabled,
  focused,
  selected,
  error,
  pressed,
  hoveredOrFocused,
}

bool _wsmEvalLeaf(_WsmLeaf leaf, Set<WidgetState> s) {
  switch (leaf) {
    case _WsmLeaf.hovered:
      return s.contains(WidgetState.hovered);
    case _WsmLeaf.notDisabled:
      return !s.contains(WidgetState.disabled);
    case _WsmLeaf.focused:
      return s.contains(WidgetState.focused);
    case _WsmLeaf.selected:
      return s.contains(WidgetState.selected);
    case _WsmLeaf.error:
      return s.contains(WidgetState.error);
    case _WsmLeaf.pressed:
      return s.contains(WidgetState.pressed);
    case _WsmLeaf.hoveredOrFocused:
      return s.contains(WidgetState.hovered) || s.contains(WidgetState.focused);
  }
}

String _wsmLeafLabel(_WsmLeaf leaf) {
  switch (leaf) {
    case _WsmLeaf.hovered:
      return 'hovered';
    case _WsmLeaf.notDisabled:
      return '~disabled';
    case _WsmLeaf.focused:
      return 'focused';
    case _WsmLeaf.selected:
      return 'selected';
    case _WsmLeaf.error:
      return 'error';
    case _WsmLeaf.pressed:
      return 'pressed';
    case _WsmLeaf.hoveredOrFocused:
      return 'hovered | focused';
  }
}

class _WsmConstraintCard extends StatelessWidget {
  const _WsmConstraintCard({
    required this.title,
    required this.expression,
    required this.rationale,
    required this.op,
    required this.a,
    required this.b,
  });
  final String title;
  final String expression;
  final String rationale;
  final _WsmOp op;
  final _WsmLeaf a;
  final _WsmLeaf? b;

  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wsmCompositionStates,
        builder: (BuildContext context, Set<WidgetState> states, _) {
          final bool aVal = _wsmEvalLeaf(a, states);
          final bool bVal = b == null ? false : _wsmEvalLeaf(b!, states);
          final bool result = _wsmEvalOp(op, aVal, bVal);
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text(title,
                      style: const TextStyle(
                        color: _WsmPalette.ivory,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      )),
                  Text(expression,
                      style: const TextStyle(
                        color: _WsmPalette.lampAmber,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'monospace',
                      )),
                ]),
              ),
              _WsmResultBadge(value: result),
            ]),
            const SizedBox(height: 4),
            Text(rationale,
                style: const TextStyle(
                  color: _WsmPalette.ivoryDim,
                  fontSize: 12,
                )),
            const SizedBox(height: 10),
            SizedBox(
              height: 160,
              child: CustomPaint(
                size: const Size(double.infinity, 160),
                painter: _WsmBoolTreePainter(
                  op: op,
                  a: a,
                  b: b,
                  aVal: aVal,
                  bVal: bVal,
                  result: result,
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

bool _wsmEvalOp(_WsmOp op, bool a, bool b) {
  switch (op) {
    case _WsmOp.and:
      return a && b;
    case _WsmOp.or:
      return a || b;
    case _WsmOp.not:
      return !a;
    case _WsmOp.andGroup:
      return a && b;
  }
}

class _WsmResultBadge extends StatelessWidget {
  const _WsmResultBadge({required this.value});
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: value
            ? _WsmPalette.lampGreen.withValues(alpha: 0.22)
            : _WsmPalette.mahoganyDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: value ? _WsmPalette.lampGreen : _WsmPalette.brassDark,
          width: 1.4,
        ),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _WsmLamp(lit: value, color: _WsmPalette.lampGreen, size: 10),
        const SizedBox(width: 6),
        Text(value ? 'SATISFIED' : 'NOT MET',
            style: TextStyle(
              color: value ? _WsmPalette.lampGreen : _WsmPalette.ivoryDim,
              fontWeight: FontWeight.w900,
              fontSize: 11,
              letterSpacing: 1.2,
            )),
      ]),
    );
  }
}

class _WsmBoolTreePainter extends CustomPainter {
  _WsmBoolTreePainter({
    required this.op,
    required this.a,
    required this.b,
    required this.aVal,
    required this.bVal,
    required this.result,
  });
  final _WsmOp op;
  final _WsmLeaf a;
  final _WsmLeaf? b;
  final bool aVal;
  final bool bVal;
  final bool result;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = _WsmPalette.brassDark
      ..strokeWidth = 2;
    final Paint activeLine = Paint()
      ..color = _WsmPalette.lampAmber
      ..strokeWidth = 2.4;

    final Offset root = Offset(size.width / 2, 24);
    final Offset leftLeaf = Offset(size.width * 0.25, size.height - 40);
    final Offset rightLeaf = Offset(size.width * 0.75, size.height - 40);
    final bool binary = op != _WsmOp.not;

    // Edges
    if (binary) {
      canvas.drawLine(root, leftLeaf, aVal ? activeLine : linePaint);
      canvas.drawLine(root, rightLeaf, bVal ? activeLine : linePaint);
    } else {
      canvas.drawLine(root, Offset(size.width / 2, size.height - 40),
          aVal ? activeLine : linePaint);
    }

    // Root node (operator)
    _paintNode(canvas, root, _wsmOpSymbol(op), result);

    // Leaves
    if (binary) {
      _paintLeaf(canvas, leftLeaf, _wsmLeafLabel(a), aVal);
      if (b != null) {
        _paintLeaf(canvas, rightLeaf, _wsmLeafLabel(b!), bVal);
      }
    } else {
      _paintLeaf(canvas, Offset(size.width / 2, size.height - 40),
          _wsmLeafLabel(a), aVal);
    }
  }

  void _paintNode(Canvas canvas, Offset center, String label, bool active) {
    final Paint bg = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          active ? _WsmPalette.lampAmber : _WsmPalette.brassDark,
          _WsmPalette.mahoganyDark,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 22));
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = active ? _WsmPalette.lampAmber : _WsmPalette.brass;
    canvas.drawCircle(center, 22, bg);
    canvas.drawCircle(center, 22, border);
    final TextPainter tp = TextPainter(
      text: TextSpan(
          text: label,
          style: const TextStyle(
            color: _WsmPalette.mahoganyDark,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          )),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _paintLeaf(Canvas canvas, Offset center, String label, bool active) {
    final Rect r = Rect.fromCenter(center: center, width: 150, height: 36);
    final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
    final Paint bg = Paint()
      ..color = active
          ? _WsmPalette.lampGreen.withValues(alpha: 0.22)
          : _WsmPalette.mahoganyDark;
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = active ? _WsmPalette.lampGreen : _WsmPalette.brassDark;
    canvas.drawRRect(rr, bg);
    canvas.drawRRect(rr, border);
    final TextPainter tp = TextPainter(
      text: TextSpan(
          text: label,
          style: TextStyle(
            color: active ? _WsmPalette.ivory : _WsmPalette.ivoryDim,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          )),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  String _wsmOpSymbol(_WsmOp op) {
    switch (op) {
      case _WsmOp.and:
        return '&';
      case _WsmOp.or:
        return '|';
      case _WsmOp.not:
        return '~';
      case _WsmOp.andGroup:
        return '&';
    }
  }

  @override
  bool shouldRepaint(covariant _WsmBoolTreePainter oldDelegate) {
    return oldDelegate.aVal != aVal ||
        oldDelegate.bVal != bVal ||
        oldDelegate.result != result ||
        oldDelegate.op != op;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 7: Live wired component - a real ElevatedButton whose backgroundColor is
// a WidgetStateMapper<Color>. The console also draws switchboard cabling via a
// CustomPainter, routing imaginary patch cords from a rack above the button.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmWiredTab extends StatelessWidget {
  const _WsmWiredTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'LIVE WIRED COMPONENT',
      subtitle: 'A real ElevatedButton styled by WidgetStateMapper<Color>',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmWiredIntro(),
        SizedBox(height: 14),
        _WsmWiredStage(),
        SizedBox(height: 14),
        _WsmWiredCode(),
      ]),
    );
  }
}

class _WsmWiredIntro extends StatelessWidget {
  const _WsmWiredIntro();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        Text('From map to material',
            style: TextStyle(
              color: _WsmPalette.ivory,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: 8),
        _WsmBullet(
            text:
                'ButtonStyle accepts WidgetStateProperty<T>; our mapper implements that interface.'),
        _WsmBullet(
            text:
                'Hover, focus (via Focus traversal), or press the button to observe the resolver.'),
        _WsmBullet(
            text:
                'The cable diagram above traces the active plug from port to jack via a CustomPainter.'),
      ]),
    );
  }
}

class _WsmWiredStage extends StatefulWidget {
  const _WsmWiredStage();
  @override
  State<_WsmWiredStage> createState() => _WsmWiredStageState();
}

class _WsmWiredStageState extends State<_WsmWiredStage>
    with _WsmTickerShim {
  final ValueNotifier<bool> _hovered = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _focused = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _pressed = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _enabled = ValueNotifier<bool>(true);
  late final AnimationController _idle;

  @override
  void initState() {
    super.initState();
    _idle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();
  }

  @override
  void dispose() {
    _hovered.dispose();
    _focused.dispose();
    _pressed.dispose();
    _enabled.dispose();
    _idle.dispose();
    super.dispose();
  }

  static final WidgetStateMapper<Color> _bg =
      WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{
    WidgetState.disabled: const Color(0xFF4D4637),
    WidgetState.pressed: _WsmPalette.lampAmber,
    WidgetState.hovered & ~WidgetState.disabled: _WsmPalette.lampBlue,
    WidgetState.focused: _WsmPalette.lampGreen,
    WidgetState.any: _WsmPalette.brass,
  });

  static final WidgetStateMapper<Color> _fg =
      WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{
    WidgetState.disabled: _WsmPalette.ivoryDim,
    WidgetState.pressed: _WsmPalette.mahoganyDark,
    WidgetState.hovered: _WsmPalette.ivory,
    WidgetState.any: _WsmPalette.mahoganyDark,
  });

  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        AnimatedBuilder(
          animation: Listenable.merge(<Listenable>[_hovered, _focused, _pressed, _enabled, _idle]),
          builder: (BuildContext context, _) {
            return SizedBox(
              height: 180,
              child: CustomPaint(
                size: const Size(double.infinity, 180),
                painter: _WsmCableRoutePainter(
                  hovered: _hovered.value,
                  focused: _focused.value,
                  pressed: _pressed.value,
                  enabled: _enabled.value,
                  idle: _idle.value,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 18),
        Center(
          child: FocusableActionDetector(
            onShowHoverHighlight: (bool v) => _hovered.value = v,
            onShowFocusHighlight: (bool v) => _focused.value = v,
            child: Listener(
              onPointerDown: (_) => _pressed.value = true,
              onPointerUp: (_) => _pressed.value = false,
              onPointerCancel: (_) => _pressed.value = false,
              child: ValueListenableBuilder<bool>(
                valueListenable: _enabled,
                builder: (BuildContext context, bool enabled, _) {
                  return ElevatedButton(
                    onPressed: enabled ? () {} : null,
                    style: ButtonStyle(
                      backgroundColor: _bg,
                      foregroundColor: _fg,
                      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                      ),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: _WsmPalette.brassDark, width: 2),
                        ),
                      ),
                      textStyle: const WidgetStatePropertyAll<TextStyle>(
                        TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.4,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    child: const Text('PATCH LINE 7'),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(children: <Widget>[
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: _enabled,
              builder: (BuildContext context, bool on, _) {
                return SwitchListTile(
                  title: const Text('Button enabled',
                      style: TextStyle(color: _WsmPalette.ivory)),
                  subtitle: const Text('Toggle to observe the disabled rule',
                      style: TextStyle(color: _WsmPalette.ivoryDim)),
                  value: on,
                  activeThumbColor: _WsmPalette.lampAmber,
                  inactiveTrackColor: _WsmPalette.mahoganyDark,
                  onChanged: (bool v) => _enabled.value = v,
                );
              },
            ),
          ),
        ]),
        _WsmWiredLiveReadout(
          hovered: _hovered,
          focused: _focused,
          pressed: _pressed,
          enabled: _enabled,
        ),
      ]),
    );
  }
}

class _WsmWiredLiveReadout extends StatelessWidget {
  const _WsmWiredLiveReadout({
    required this.hovered,
    required this.focused,
    required this.pressed,
    required this.enabled,
  });
  final ValueNotifier<bool> hovered;
  final ValueNotifier<bool> focused;
  final ValueNotifier<bool> pressed;
  final ValueNotifier<bool> enabled;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[hovered, focused, pressed, enabled]),
      builder: (BuildContext context, _) {
        final Set<WidgetState> s = <WidgetState>{
          if (hovered.value) WidgetState.hovered,
          if (focused.value) WidgetState.focused,
          if (pressed.value) WidgetState.pressed,
          if (!enabled.value) WidgetState.disabled,
        };
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _WsmPalette.mahoganyDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _WsmPalette.brassDark, width: 1),
          ),
          child: Row(children: <Widget>[
            _WsmLamp(lit: hovered.value, color: _WsmPalette.lampBlue, size: 10),
            const SizedBox(width: 6),
            const Text('H', style: TextStyle(color: _WsmPalette.ivoryDim)),
            const SizedBox(width: 14),
            _WsmLamp(lit: focused.value, color: _WsmPalette.lampGreen, size: 10),
            const SizedBox(width: 6),
            const Text('F', style: TextStyle(color: _WsmPalette.ivoryDim)),
            const SizedBox(width: 14),
            _WsmLamp(lit: pressed.value, color: _WsmPalette.lampAmber, size: 10),
            const SizedBox(width: 6),
            const Text('P', style: TextStyle(color: _WsmPalette.ivoryDim)),
            const SizedBox(width: 14),
            _WsmLamp(lit: !enabled.value, color: _WsmPalette.lampRed, size: 10),
            const SizedBox(width: 6),
            const Text('D', style: TextStyle(color: _WsmPalette.ivoryDim)),
            const Spacer(),
            Text('states: ${s.isEmpty ? '{}' : '{${s.map(_wsmShort).join(', ')}}'}',
                style: const TextStyle(
                  color: _WsmPalette.lampAmber,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                )),
          ]),
        );
      },
    );
  }
}

class _WsmCableRoutePainter extends CustomPainter {
  _WsmCableRoutePainter({
    required this.hovered,
    required this.focused,
    required this.pressed,
    required this.enabled,
    required this.idle,
  });
  final bool hovered;
  final bool focused;
  final bool pressed;
  final bool enabled;
  final double idle;

  @override
  void paint(Canvas canvas, Size size) {
    // Header rack - row of four ports up top.
    final double rackY = 18;
    final double rackStep = size.width / 5;
    for (int i = 0; i < 4; i++) {
      final Offset p = Offset(rackStep * (i + 1), rackY);
      _drawRackPort(canvas, p, i, hovered, focused, pressed, !enabled);
    }

    // Single destination plug near the bottom center, feeding the button.
    final Offset dest = Offset(size.width / 2, size.height - 14);
    _drawRackPort(canvas, dest, 4, false, false, false, false);

    // Choose the "winning" source and draw a cable with a sine swing.
    final int activeIndex = _winningIndex();
    final Offset source = Offset(rackStep * (activeIndex + 1), rackY);
    _drawCable(canvas, source, dest, _winningColor(), idle);
  }

  void _drawRackPort(Canvas canvas, Offset center, int idx, bool h, bool f, bool p, bool d) {
    final Paint ring = Paint()
      ..color = _WsmPalette.brass
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint hole = Paint()
      ..shader = RadialGradient(
        colors: <Color>[_WsmPalette.mahoganyDark, Colors.black],
      ).createShader(Rect.fromCircle(center: center, radius: 10));
    canvas.drawCircle(center, 10, hole);
    canvas.drawCircle(center, 10, ring);
    // indicator lamp above
    Color lamp = _WsmPalette.brassDark;
    switch (idx) {
      case 0:
        lamp = h ? _WsmPalette.lampBlue : _WsmPalette.brassDark;
        break;
      case 1:
        lamp = f ? _WsmPalette.lampGreen : _WsmPalette.brassDark;
        break;
      case 2:
        lamp = p ? _WsmPalette.lampAmber : _WsmPalette.brassDark;
        break;
      case 3:
        lamp = d ? _WsmPalette.lampRed : _WsmPalette.brassDark;
        break;
      case 4:
        lamp = _WsmPalette.brassBright;
        break;
    }
    final Paint lampPaint = Paint()..color = lamp;
    canvas.drawCircle(center.translate(0, -18), 4, lampPaint);
    if (idx != 4) {
      final Paint glow = Paint()
        ..color = lamp.withValues(alpha: lamp == _WsmPalette.brassDark ? 0.0 : 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(center.translate(0, -18), 7, glow);
    }
    // label
    final List<String> labels = <String>['H', 'F', 'P', 'D', 'OUT'];
    final TextPainter tp = TextPainter(
      text: TextSpan(
          text: labels[idx],
          style: const TextStyle(
            color: _WsmPalette.brassBright,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          )),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center.translate(-tp.width / 2, 14));
  }

  void _drawCable(Canvas canvas, Offset from, Offset to, Color color, double idle) {
    final double swing = math.sin(idle * math.pi * 2) * 8;
    final Offset ctrl1 = Offset(from.dx + swing, (from.dy + to.dy) / 2 + 20);
    final Offset ctrl2 = Offset(to.dx - swing, (from.dy + to.dy) / 2 + 40);
    final Path path = Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(ctrl1.dx, ctrl1.dy, ctrl2.dx, ctrl2.dy, to.dx, to.dy);
    final Paint shadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path, shadow);
    final Paint core = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, core);
    final Paint sheen = Paint()
      ..color = _WsmPalette.ivory.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, sheen);
  }

  int _winningIndex() {
    if (!enabled) return 3;
    if (pressed) return 2;
    if (hovered) return 0;
    if (focused) return 1;
    return 4;
  }

  Color _winningColor() {
    if (!enabled) return _WsmPalette.lampRed;
    if (pressed) return _WsmPalette.lampAmber;
    if (hovered) return _WsmPalette.lampBlue;
    if (focused) return _WsmPalette.lampGreen;
    return _WsmPalette.brass;
  }

  @override
  bool shouldRepaint(covariant _WsmCableRoutePainter oldDelegate) {
    return oldDelegate.hovered != hovered ||
        oldDelegate.focused != focused ||
        oldDelegate.pressed != pressed ||
        oldDelegate.enabled != enabled ||
        oldDelegate.idle != idle;
  }
}

class _WsmWiredCode extends StatelessWidget {
  const _WsmWiredCode();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        Text('The ButtonStyle used above',
            style: TextStyle(
              color: _WsmPalette.ivory,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: 8),
        _WsmCodeBlock(code:
            'static final WidgetStateMapper<Color> _bg =\n'
            '    WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{\n'
            '  WidgetState.disabled: Color(0xFF4D4637),\n'
            '  WidgetState.pressed: lampAmber,\n'
            '  WidgetState.hovered & ~WidgetState.disabled: lampBlue,\n'
            '  WidgetState.focused: lampGreen,\n'
            '  WidgetState.any: brass,\n'
            '});\n'
            '\n'
            'ElevatedButton(\n'
            '  onPressed: enabled ? () {} : null,\n'
            '  style: ButtonStyle(backgroundColor: _bg, ...),\n'
            '  child: Text(\'PATCH LINE 7\'),\n'
            ')'),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 8: Recipe cards - five common mapper patterns.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmRecipesTab extends StatelessWidget {
  const _WsmRecipesTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'RECIPE CARDS',
      subtitle: 'Five idiomatic shapes you will write over and over',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmRecipeCard(
          number: 'RCP-01',
          title: 'Selected + Hovered highlight',
          blurb:
              'A common control pattern: a selected item that brightens further on hover.',
          code:
              'const WidgetStateMapper<Color> bg =\n'
              '    WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{\n'
              '  WidgetState.selected & WidgetState.hovered: Color(0xFFFFD580),\n'
              '  WidgetState.selected: Color(0xFFE0A040),\n'
              '  WidgetState.hovered: Color(0x22FFFFFF),\n'
              '  WidgetState.any: Colors.transparent,\n'
              '});',
          icon: Icons.star_outline,
          color: _WsmPalette.brassBright,
        ),
        SizedBox(height: 12),
        _WsmRecipeCard(
          number: 'RCP-02',
          title: 'Error override',
          blurb:
              'An error state must dominate every other look. Place it FIRST.',
          code:
              'const WidgetStateMapper<Color> border =\n'
              '    WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{\n'
              '  WidgetState.error: Colors.redAccent,\n'
              '  WidgetState.focused: Colors.blue,\n'
              '  WidgetState.any: Colors.black12,\n'
              '});',
          icon: Icons.error_outline,
          color: _WsmPalette.lampRed,
        ),
        SizedBox(height: 12),
        _WsmRecipeCard(
          number: 'RCP-03',
          title: 'Disabled muting',
          blurb:
              'Use ~WidgetState.disabled on interactive entries so hovers stay off.',
          code:
              'const WidgetStateMapper<Color> fg =\n'
              '    WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{\n'
              '  WidgetState.disabled: Color(0x66000000),\n'
              '  WidgetState.hovered & ~WidgetState.disabled: Colors.white,\n'
              '  WidgetState.any: Colors.white70,\n'
              '});',
          icon: Icons.block,
          color: Color(0xFF8A7A60),
        ),
        SizedBox(height: 12),
        _WsmRecipeCard(
          number: 'RCP-04',
          title: 'Focus halo',
          blurb:
              'A dedicated ring for keyboard focus using a BorderSide mapper.',
          code:
              'const WidgetStateMapper<BorderSide> halo =\n'
              '    WidgetStateMapper<BorderSide>(<WidgetStatesConstraint, BorderSide>{\n'
              '  WidgetState.focused: BorderSide(color: Colors.cyan, width: 3),\n'
              '  WidgetState.any: BorderSide.none,\n'
              '});',
          icon: Icons.center_focus_strong_outlined,
          color: _WsmPalette.lampGreen,
        ),
        SizedBox(height: 12),
        _WsmRecipeCard(
          number: 'RCP-05',
          title: 'Pressed darken',
          blurb:
              'Apply a darker shade when pressed, still modifiable by selection or hover.',
          code:
              'const WidgetStateMapper<Color> bg =\n'
              '    WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{\n'
              '  WidgetState.pressed: Color(0xFF243B55),\n'
              '  WidgetState.hovered: Color(0xFF34495E),\n'
              '  WidgetState.any: Color(0xFF2C3E50),\n'
              '});',
          icon: Icons.touch_app_outlined,
          color: _WsmPalette.lampAmber,
        ),
        SizedBox(height: 12),
        _WsmRecipeCard(
          number: 'RCP-06',
          title: 'Text style combo',
          blurb:
              'TextStyle interpolation via WidgetStateMapper<TextStyle>.',
          code:
              'const WidgetStateMapper<TextStyle> label =\n'
              '    WidgetStateMapper<TextStyle>(<WidgetStatesConstraint, TextStyle>{\n'
              '  WidgetState.selected: TextStyle(fontWeight: FontWeight.w900),\n'
              '  WidgetState.disabled: TextStyle(color: Colors.black38),\n'
              '  WidgetState.any: TextStyle(fontWeight: FontWeight.w600),\n'
              '});',
          icon: Icons.text_fields_outlined,
          color: _WsmPalette.lampBlue,
        ),
      ]),
    );
  }
}

class _WsmRecipeCard extends StatelessWidget {
  const _WsmRecipeCard({
    required this.number,
    required this.title,
    required this.blurb,
    required this.code,
    required this.icon,
    required this.color,
  });
  final String number;
  final String title;
  final String blurb;
  final String code;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: <Color>[color, color.withValues(alpha: 0.6)],
              ),
              border: Border.all(color: _WsmPalette.ivory, width: 1.2),
            ),
            child: Icon(icon, color: _WsmPalette.mahoganyDark, size: 22),
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(number,
                style: const TextStyle(
                  color: _WsmPalette.lampAmber,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  fontSize: 11,
                )),
            Text(title,
                style: const TextStyle(
                  color: _WsmPalette.ivory,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                )),
          ]),
        ]),
        const SizedBox(height: 8),
        Text(blurb,
            style: const TextStyle(
              color: _WsmPalette.ivoryDim,
              fontSize: 12,
              height: 1.45,
            )),
        const SizedBox(height: 10),
        _WsmCodeBlock(code: code),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 9: Comparison table - Mapper vs fromMap vs resolveWith vs All.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmCompareTab extends StatelessWidget {
  const _WsmCompareTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'COMPARE STRATEGIES',
      subtitle: 'When to reach for each member of the WidgetStateProperty family',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmCompareTableCard(),
        SizedBox(height: 14),
        _WsmCompareDetailCard(
          title: 'WidgetStateMapper<T>',
          subtitle: 'const, declarative, static map',
          code:
              'const WidgetStateMapper<Color>(<WidgetStatesConstraint, Color>{\n'
              '  WidgetState.error: Colors.red,\n'
              '  WidgetState.hovered: Colors.blue,\n'
              '  WidgetState.any: Colors.black12,\n'
              '});',
          use:
              'Choose this when your rules are fixed at compile time and readable as a lookup table.',
          icon: Icons.grid_on_outlined,
        ),
        SizedBox(height: 10),
        _WsmCompareDetailCard(
          title: 'WidgetStateProperty.fromMap<T>',
          subtitle: 'factory that returns a WidgetStateMapper',
          code:
              'WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color>{\n'
              '  WidgetState.error: Colors.red,\n'
              '  WidgetState.any: Colors.black12,\n'
              '});',
          use:
              'Same machinery as WidgetStateMapper - use when you want to stay at the WidgetStateProperty level.',
          icon: Icons.factory_outlined,
        ),
        SizedBox(height: 10),
        _WsmCompareDetailCard(
          title: 'WidgetStateProperty.resolveWith<T>',
          subtitle: 'imperative / functional strategy',
          code:
              'WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {\n'
              '  if (s.contains(WidgetState.error)) return Colors.red;\n'
              '  if (s.contains(WidgetState.hovered)) return Colors.blue;\n'
              '  return Colors.black12;\n'
              '});',
          use:
              'Pick this when logic is dynamic - depends on closed-over values, theme, or async state.',
          icon: Icons.functions,
        ),
        SizedBox(height: 10),
        _WsmCompareDetailCard(
          title: 'WidgetStatePropertyAll<T>',
          subtitle: 'constant - same value for every state',
          code: 'const WidgetStatePropertyAll<double>(2.0);',
          use:
              'The minimum-ceremony option for a value that never changes with state.',
          icon: Icons.circle_outlined,
        ),
      ]),
    );
  }
}

class _WsmCompareTableCard extends StatelessWidget {
  const _WsmCompareTableCard();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('SIDE BY SIDE',
            style: TextStyle(
              color: _WsmPalette.brassBright,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            )),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(color: _WsmPalette.brassDark, width: 1),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(180),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
          },
          children: const <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: _WsmPalette.mahoganyDark),
              children: <Widget>[
                _WsmTh(text: 'Aspect'),
                _WsmTh(text: 'Mapper<T>'),
                _WsmTh(text: 'fromMap<T>'),
                _WsmTh(text: 'resolveWith<T>'),
                _WsmTh(text: 'All<T>'),
              ],
            ),
            TableRow(children: <Widget>[
              _WsmTd(text: 'Strategy', bold: true),
              _WsmTd(text: 'Static map'),
              _WsmTd(text: 'Static map (factory)'),
              _WsmTd(text: 'Function'),
              _WsmTd(text: 'Constant'),
            ]),
            TableRow(children: <Widget>[
              _WsmTd(text: 'const?', bold: true),
              _WsmTd(text: 'Yes'),
              _WsmTd(text: 'No (factory)'),
              _WsmTd(text: 'No (closure)'),
              _WsmTd(text: 'Yes'),
            ]),
            TableRow(children: <Widget>[
              _WsmTd(text: 'Order matters?', bold: true),
              _WsmTd(text: 'Yes - first match wins'),
              _WsmTd(text: 'Yes'),
              _WsmTd(text: 'Whatever you code'),
              _WsmTd(text: 'N/A'),
            ]),
            TableRow(children: <Widget>[
              _WsmTd(text: 'Reviewability', bold: true),
              _WsmTd(text: 'Very high'),
              _WsmTd(text: 'High'),
              _WsmTd(text: 'Medium - control flow'),
              _WsmTd(text: 'Trivial'),
            ]),
            TableRow(children: <Widget>[
              _WsmTd(text: 'Dynamic values', bold: true),
              _WsmTd(text: 'Awkward - all keys are constants'),
              _WsmTd(text: 'Awkward'),
              _WsmTd(text: 'Natural'),
              _WsmTd(text: 'N/A'),
            ]),
            TableRow(children: <Widget>[
              _WsmTd(text: 'Throws on no match?', bold: true),
              _WsmTd(text: 'Yes - add WidgetState.any'),
              _WsmTd(text: 'Yes'),
              _WsmTd(text: 'Only if your function does'),
              _WsmTd(text: 'Never'),
            ]),
            TableRow(children: <Widget>[
              _WsmTd(text: 'Allocation per rebuild', bold: true),
              _WsmTd(text: 'None (if const)'),
              _WsmTd(text: 'Low'),
              _WsmTd(text: 'One closure'),
              _WsmTd(text: 'None'),
            ]),
          ],
        ),
      ]),
    );
  }
}

class _WsmTh extends StatelessWidget {
  const _WsmTh({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text,
          style: const TextStyle(
            color: _WsmPalette.brassBright,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          )),
    );
  }
}

class _WsmTd extends StatelessWidget {
  const _WsmTd({required this.text, this.bold = false});
  final String text;
  final bool bold;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text,
          style: TextStyle(
            color: bold ? _WsmPalette.ivory : _WsmPalette.ivoryDim,
            fontSize: 11,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
            height: 1.35,
          )),
    );
  }
}

class _WsmCompareDetailCard extends StatelessWidget {
  const _WsmCompareDetailCard({
    required this.title,
    required this.subtitle,
    required this.code,
    required this.use,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final String code;
  final String use;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Icon(icon, color: _WsmPalette.brassBright, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(title,
                  style: const TextStyle(
                    color: _WsmPalette.ivory,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  )),
              Text(subtitle,
                  style: const TextStyle(
                    color: _WsmPalette.lampAmber,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  )),
            ]),
          ),
        ]),
        const SizedBox(height: 10),
        _WsmCodeBlock(code: code),
        const SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const Icon(Icons.lightbulb_outline,
              color: _WsmPalette.lampAmber, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(use,
                style: const TextStyle(
                  color: _WsmPalette.ivoryDim,
                  fontSize: 12,
                  height: 1.4,
                )),
          ),
        ]),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 10: Glossary / epilogue.
// ═══════════════════════════════════════════════════════════════════════════

class _WsmGlossaryTab extends StatelessWidget {
  const _WsmGlossaryTab();
  @override
  Widget build(BuildContext context) {
    return _WsmSection(
      title: 'GLOSSARY & EPILOGUE',
      subtitle: 'Vocabulary for the switchboard operator',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        _WsmGlossaryEntry(
          term: 'WidgetState',
          def:
              'An enum of recognized UI interaction states: hovered, focused, pressed, disabled, selected, dragged, error, scrolledUnder.',
        ),
        _WsmGlossaryEntry(
          term: 'WidgetStatesConstraint',
          def:
              'A predicate over a Set<WidgetState>. Implemented by WidgetState itself and by expressions built with &, |, ~.',
        ),
        _WsmGlossaryEntry(
          term: 'WidgetStateMap<T>',
          def:
              'A typedef for Map<WidgetStatesConstraint, T>. The backing store of WidgetStateMapper.',
        ),
        _WsmGlossaryEntry(
          term: 'WidgetStateMapper<T>',
          def:
              'Generic resolver that walks a WidgetStateMap<T> in order and returns the first value whose key is satisfied.',
        ),
        _WsmGlossaryEntry(
          term: 'WidgetStateProperty<T>',
          def:
              'The abstract interface that WidgetStateMapper implements. Widgets consume this type for state-aware styling.',
        ),
        _WsmGlossaryEntry(
          term: 'WidgetState.any',
          def:
              'A catch-all WidgetStatesConstraint that is always satisfied. Use it as the final map entry to prevent resolve from throwing.',
        ),
        _WsmGlossaryEntry(
          term: 'First-match-wins',
          def:
              'The iteration rule: the first constraint to report isSatisfiedBy(states) == true supplies the value.',
        ),
        _WsmGlossaryEntry(
          term: 'isSatisfiedBy',
          def:
              'The single abstract method on WidgetStatesConstraint. Returns true if the constraint is met by a state set.',
        ),
        _WsmGlossaryEntry(
          term: 'Compound constraint',
          def:
              'A constraint built from operators: & (and), | (or), ~ (not). Applied to WidgetStatesConstraint values.',
        ),
        _WsmGlossaryEntry(
          term: 'resolveWith',
          def:
              'An alternative WidgetStateProperty factory that takes a closure instead of a map.',
        ),
        SizedBox(height: 14),
        _WsmEpilogueCard(),
      ]),
    );
  }
}

class _WsmGlossaryEntry extends StatelessWidget {
  const _WsmGlossaryEntry({required this.term, required this.def});
  final String term;
  final String def;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _WsmPanel(
        padding: const EdgeInsets.all(12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 10),
            child: _WsmLamp(lit: true, color: _WsmPalette.brassBright, size: 10),
          ),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(term,
                  style: const TextStyle(
                    color: _WsmPalette.ivory,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'monospace',
                  )),
              const SizedBox(height: 3),
              Text(def,
                  style: const TextStyle(
                    color: _WsmPalette.ivoryDim,
                    fontSize: 12,
                    height: 1.45,
                  )),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _WsmEpilogueCard extends StatelessWidget {
  const _WsmEpilogueCard();
  @override
  Widget build(BuildContext context) {
    return _WsmPanel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
        Row(children: <Widget>[
          Icon(Icons.auto_stories_outlined,
              color: _WsmPalette.brassBright, size: 22),
          SizedBox(width: 10),
          Text('Signing off',
              style: TextStyle(
                color: _WsmPalette.ivory,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              )),
        ]),
        SizedBox(height: 10),
        Text(
          'WidgetStateMapper<T> is the quiet workhorse under most Flutter state-aware '
          'styling: ButtonStyle, SwitchThemeData, FilterChip, NavigationRail, and so on. '
          'Once you grasp the ordered-map mental model - and terminate every mapper with '
          'WidgetState.any - state-driven appearance becomes a series of short, declarative '
          'tables. Read them top to bottom like a patchboard; the mapper does the rest.',
          style: TextStyle(
            color: _WsmPalette.ivoryDim,
            fontSize: 13,
            height: 1.55,
          ),
        ),
        SizedBox(height: 10),
        _WsmBullet(
            text:
                'Declare maps in most-specific to least-specific order.'),
        _WsmBullet(text: 'Always end with WidgetState.any.'),
        _WsmBullet(
            text:
                'Prefer const mappers at module scope for allocation-free reuse.'),
        _WsmBullet(
            text:
                'Reach for resolveWith only when the logic is genuinely dynamic.'),
      ]),
    );
  }
}
