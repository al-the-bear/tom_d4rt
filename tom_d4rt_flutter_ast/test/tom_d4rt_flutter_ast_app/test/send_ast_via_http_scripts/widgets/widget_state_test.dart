// Deep visual demo: WidgetState - the eight-valued enum from
// package:flutter/widgets.dart that implements WidgetStatesConstraint and
// powers every WidgetStateProperty/WidgetStateMap resolver across Material.
//
// Theme: a mid-century mission-control console. A dark brushed-steel panel
// carries amber, teal and crimson annunciator lamps, rivets, engraved
// plaques and boolean-gate circuit diagrams. The reader cruises through
// ten sections - Dossier, Anatomy, Live Annunciator, Set Algebra, Constraint
// Composition, Resolver Showcase, Material Catalog, Recipes, Comparison,
// Glossary - each instrumented off of a single live Set<WidgetState>.
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Palette - brushed steel, amber/teal/crimson annunciators, engraved brass.
// ═══════════════════════════════════════════════════════════════════════════

class _WstPalette {
  const _WstPalette._();
  static const Color panelBlack = Color(0xFF0E1113);
  static const Color panelSteel = Color(0xFF1B2126);
  static const Color panelSteelLight = Color(0xFF2A3138);
  static const Color panelSeam = Color(0xFF05080A);
  static const Color rivet = Color(0xFF3A4249);
  static const Color rivetGlint = Color(0xFF8FA0AD);
  static const Color brassLabel = Color(0xFFC7A15A);
  static const Color brassLabelBright = Color(0xFFE6C781);
  static const Color brassLabelDark = Color(0xFF7D5E2C);
  static const Color engraveIvory = Color(0xFFE6E1CE);
  static const Color engraveIvoryDim = Color(0xFFAFAA94);
  static const Color lampAmber = Color(0xFFFFB93A);
  static const Color lampAmberDeep = Color(0xFFC88920);
  static const Color lampTeal = Color(0xFF35C4B8);
  static const Color lampCrimson = Color(0xFFE03A2C);
  static const Color lampCrimsonDeep = Color(0xFF921E14);
  static const Color lampGreen = Color(0xFF4FD06A);
  static const Color lampBlue = Color(0xFF4C9BE0);
  static const Color lampViolet = Color(0xFFB46CE0);
  static const Color lampMagenta = Color(0xFFE05CB0);
  static const Color wireDim = Color(0xFF3E4A54);
  static const Color wireLive = Color(0xFFFFD26A);
  static const Color wireHot = Color(0xFFFF7043);
  static const Color codeBg = Color(0xFF08090B);
  static const Color codeFg = Color(0xFFD9E1E8);
  static const Color codeKeyword = Color(0xFFE06C75);
  static const Color codeString = Color(0xFF98C379);
  static const Color codeType = Color(0xFF61AFEF);
  static const Color codeComment = Color(0xFF5C6370);
  static const Color codePunct = Color(0xFFABB2BF);
  static const Color paperLabel = Color(0xFFE8DEBE);
}

// ═══════════════════════════════════════════════════════════════════════════
// Top-level notifiers drive the live annunciator surface and dependents.
// ═══════════════════════════════════════════════════════════════════════════

final ValueNotifier<Set<WidgetState>> _wstLiveStates =
    ValueNotifier<Set<WidgetState>>(<WidgetState>{});
final ValueNotifier<Set<WidgetState>> _wstAlgebraA =
    ValueNotifier<Set<WidgetState>>(<WidgetState>{
  WidgetState.hovered,
  WidgetState.focused,
});
final ValueNotifier<Set<WidgetState>> _wstAlgebraB =
    ValueNotifier<Set<WidgetState>>(<WidgetState>{
  WidgetState.focused,
  WidgetState.selected,
});
final ValueNotifier<int> _wstExpressionIndex = ValueNotifier<int>(0);

void _wstToggle(ValueNotifier<Set<WidgetState>> n, WidgetState s) {
  final Set<WidgetState> next = <WidgetState>{...n.value};
  if (next.contains(s)) {
    next.remove(s);
  } else {
    next.add(s);
  }
  n.value = next;
}

// ═══════════════════════════════════════════════════════════════════════════
// Canonical ordered list of the eight WidgetState enum values.
// ═══════════════════════════════════════════════════════════════════════════

const List<WidgetState> _wstAllStates = <WidgetState>[
  WidgetState.hovered,
  WidgetState.focused,
  WidgetState.pressed,
  WidgetState.dragged,
  WidgetState.selected,
  WidgetState.scrolledUnder,
  WidgetState.disabled,
  WidgetState.error,
];

String _wstStateName(WidgetState s) {
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

Color _wstStateLampColor(WidgetState s) {
  switch (s) {
    case WidgetState.hovered:
      return _WstPalette.lampAmber;
    case WidgetState.focused:
      return _WstPalette.lampTeal;
    case WidgetState.pressed:
      return _WstPalette.lampCrimson;
    case WidgetState.dragged:
      return _WstPalette.lampViolet;
    case WidgetState.selected:
      return _WstPalette.lampGreen;
    case WidgetState.scrolledUnder:
      return _WstPalette.lampBlue;
    case WidgetState.disabled:
      return _WstPalette.rivetGlint;
    case WidgetState.error:
      return _WstPalette.lampMagenta;
  }
}

IconData _wstStateIcon(WidgetState s) {
  switch (s) {
    case WidgetState.hovered:
      return Icons.mouse_outlined;
    case WidgetState.focused:
      return Icons.center_focus_strong_outlined;
    case WidgetState.pressed:
      return Icons.touch_app_outlined;
    case WidgetState.dragged:
      return Icons.drag_indicator;
    case WidgetState.selected:
      return Icons.check_circle_outline;
    case WidgetState.scrolledUnder:
      return Icons.swap_vert_outlined;
    case WidgetState.disabled:
      return Icons.block_outlined;
    case WidgetState.error:
      return Icons.error_outline;
  }
}

String _wstSetRepr(Set<WidgetState> set) {
  if (set.isEmpty) return '{ }';
  final List<String> names = <String>[
    for (final WidgetState s in _wstAllStates)
      if (set.contains(s)) _wstStateName(s),
  ];
  return '{ ${names.join(', ')} }';
}

// ═══════════════════════════════════════════════════════════════════════════
// Entry point - single top-level dynamic build() returns a MaterialApp.
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) => const _WstApp();

class _WstApp extends StatelessWidget {
  const _WstApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _WstPalette.panelBlack,
        colorScheme: const ColorScheme.dark(
          primary: _WstPalette.brassLabel,
          onPrimary: _WstPalette.panelBlack,
          secondary: _WstPalette.lampAmber,
          surface: _WstPalette.panelSteel,
          onSurface: _WstPalette.engraveIvory,
          error: _WstPalette.lampCrimson,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            color: _WstPalette.engraveIvory,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: _WstPalette.engraveIvory,
            letterSpacing: 0.8,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            color: _WstPalette.engraveIvory,
          ),
          bodyMedium: TextStyle(
            height: 1.45,
            color: _WstPalette.engraveIvoryDim,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: _WstPalette.brassLabelBright,
          ),
        ),
      ),
      home: const _WstHome(),
    );
  }
}

class _WstHome extends StatelessWidget {
  const _WstHome();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _WstPalette.panelSteel,
          elevation: 0,
          title: const _WstTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _WstTabBar(),
          ),
        ),
        body: Stack(children: const <Widget>[
          Positioned.fill(child: _WstBackdrop()),
          Positioned.fill(child: _WstBody()),
        ]),
      ),
    );
  }
}

class _WstTitle extends StatelessWidget {
  const _WstTitle();
  @override
  Widget build(BuildContext context) {
    return Row(children: const <Widget>[
      Icon(Icons.settings_remote_outlined, color: _WstPalette.brassLabel, size: 28),
      SizedBox(width: 12),
      Text(
        'WidgetState · Mission-Control Annunciator',
        style: TextStyle(
          color: _WstPalette.engraveIvory,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
      ),
    ]);
  }
}

class _WstTabBar extends StatelessWidget {
  const _WstTabBar();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _WstPalette.panelSeam,
      child: const TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: _WstPalette.brassLabel,
        labelColor: _WstPalette.brassLabelBright,
        unselectedLabelColor: _WstPalette.engraveIvoryDim,
        tabs: <Tab>[
          Tab(icon: Icon(Icons.description_outlined), text: 'Dossier'),
          Tab(icon: Icon(Icons.account_tree_outlined), text: 'Anatomy'),
          Tab(icon: Icon(Icons.light_mode_outlined), text: 'Annunciator'),
          Tab(icon: Icon(Icons.calculate_outlined), text: 'Set Algebra'),
          Tab(icon: Icon(Icons.memory_outlined), text: 'Composition'),
          Tab(icon: Icon(Icons.palette_outlined), text: 'Resolvers'),
          Tab(icon: Icon(Icons.widgets_outlined), text: 'Catalog'),
          Tab(icon: Icon(Icons.restaurant_menu_outlined), text: 'Recipes'),
          Tab(icon: Icon(Icons.compare_arrows_outlined), text: 'Comparison'),
          Tab(icon: Icon(Icons.menu_book_outlined), text: 'Glossary'),
        ],
      ),
    );
  }
}

class _WstBody extends StatelessWidget {
  const _WstBody();
  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: <Widget>[
      _WstDossierTab(),
      _WstAnatomyTab(),
      _WstAnnunciatorTab(),
      _WstSetAlgebraTab(),
      _WstCompositionTab(),
      _WstResolversTab(),
      _WstCatalogTab(),
      _WstRecipesTab(),
      _WstComparisonTab(),
      _WstGlossaryTab(),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Backdrop painter - rivets, panel seams, soft glow ring.
// ═══════════════════════════════════════════════════════════════════════════

class _WstBackdrop extends StatelessWidget {
  const _WstBackdrop();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WstPanelBackdropPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _WstPanelBackdropPainter extends CustomPainter {
  _WstPanelBackdropPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint steel = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _WstPalette.panelSteelLight,
          _WstPalette.panelSteel,
          _WstPalette.panelBlack,
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, steel);

    // Soft glow ring centered horizontally.
    final Offset glowCenter = Offset(size.width * 0.5, size.height * 0.35);
    final double glowRadius = size.shortestSide * 0.55;
    final Paint glow = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _WstPalette.lampAmber.withValues(alpha: 0.10),
          _WstPalette.lampAmber.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: glowCenter, radius: glowRadius));
    canvas.drawCircle(glowCenter, glowRadius, glow);

    // Horizontal panel seams.
    final Paint seamDark = Paint()
      ..color = _WstPalette.panelSeam
      ..strokeWidth = 1.2;
    final Paint seamLight = Paint()
      ..color = _WstPalette.panelSteelLight.withValues(alpha: 0.55)
      ..strokeWidth = 0.6;
    final List<double> seams = <double>[0.18, 0.42, 0.70, 0.92];
    for (final double s in seams) {
      final double y = size.height * s;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), seamDark);
      canvas.drawLine(Offset(0, y + 1.4), Offset(size.width, y + 1.4), seamLight);
    }

    // Rivet grid in the margins.
    _paintRivets(canvas, size);
  }

  void _paintRivets(Canvas canvas, Size size) {
    final Paint rivetBase = Paint()..color = _WstPalette.rivet;
    final Paint rivetGlint = Paint()..color = _WstPalette.rivetGlint;
    const double margin = 14;
    const double step = 72;
    for (double x = margin; x < size.width; x += step) {
      for (double y = margin; y < size.height; y += step) {
        final bool onMargin = x < margin * 2 ||
            x > size.width - margin * 2 ||
            y < margin * 2 ||
            y > size.height - margin * 2;
        if (!onMargin) continue;
        canvas.drawCircle(Offset(x, y), 3.2, rivetBase);
        canvas.drawCircle(Offset(x - 0.8, y - 0.8), 1.0, rivetGlint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WstPanelBackdropPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared ornaments - panels, plaques, section frames, chips, code blocks.
// ═══════════════════════════════════════════════════════════════════════════

class _WstPanel extends StatelessWidget {
  const _WstPanel({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.accent = _WstPalette.brassLabel,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color accent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_WstPalette.panelSteelLight, _WstPalette.panelSteel],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.75), width: 1.4),
        boxShadow: <BoxShadow>[
          const BoxShadow(
            color: Color(0x80000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
          BoxShadow(
            color: accent.withValues(alpha: 0.15),
            blurRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _WstPlaque extends StatelessWidget {
  const _WstPlaque({required this.title, this.subtitle});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            _WstPalette.brassLabelDark,
            _WstPalette.brassLabel,
            _WstPalette.brassLabelDark,
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x55000000), blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _WstPalette.panelBlack,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.6,
              fontSize: 15,
            ),
          ),
          if (subtitle != null) ...<Widget>[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: const TextStyle(
                color: _WstPalette.panelSteel,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _WstSection extends StatelessWidget {
  const _WstSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final String title;
  final String subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _WstPlaque(title: title, subtitle: subtitle),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _WstStateChip extends StatelessWidget {
  const _WstStateChip({required this.state, this.active = true});
  final WidgetState state;
  final bool active;
  @override
  Widget build(BuildContext context) {
    final Color c = _wstStateLampColor(state);
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active
            ? c.withValues(alpha: 0.18)
            : _WstPalette.panelSeam.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: active ? c : _WstPalette.rivet,
          width: 1.2,
        ),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Icon(_wstStateIcon(state), color: active ? c : _WstPalette.engraveIvoryDim, size: 14),
        const SizedBox(width: 6),
        Text(
          _wstStateName(state),
          style: TextStyle(
            fontFamily: 'monospace',
            color: active ? _WstPalette.engraveIvory : _WstPalette.engraveIvoryDim,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ]),
    );
  }
}

class _WstCodeBlock extends StatelessWidget {
  const _WstCodeBlock({required this.lines, this.caption});
  final List<_WstCodeLine> lines;
  final String? caption;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: _WstPalette.codeBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _WstPalette.rivet.withValues(alpha: 0.6),
          width: 1,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        if (caption != null) ...<Widget>[
          Text(
            caption!,
            style: const TextStyle(
              color: _WstPalette.brassLabelBright,
              fontSize: 11,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
        ],
        for (final _WstCodeLine line in lines) line,
      ]),
    );
  }
}

class _WstCodeLine extends StatelessWidget {
  const _WstCodeLine(this.spans);
  final List<InlineSpan> spans;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'monospace',
            color: _WstPalette.codeFg,
            fontSize: 12.5,
            height: 1.5,
          ),
          children: spans,
        ),
      ),
    );
  }
}

TextSpan _kw(String s) => TextSpan(
      text: s,
      style: const TextStyle(color: _WstPalette.codeKeyword, fontWeight: FontWeight.w700),
    );
TextSpan _ty(String s) => TextSpan(
      text: s,
      style: const TextStyle(color: _WstPalette.codeType),
    );
TextSpan _str(String s) => TextSpan(
      text: s,
      style: const TextStyle(color: _WstPalette.codeString),
    );
TextSpan _cm(String s) => TextSpan(
      text: s,
      style: const TextStyle(color: _WstPalette.codeComment, fontStyle: FontStyle.italic),
    );
TextSpan _pt(String s) => TextSpan(
      text: s,
      style: const TextStyle(color: _WstPalette.codePunct),
    );
TextSpan _tx(String s) => TextSpan(text: s);

// ═══════════════════════════════════════════════════════════════════════════
// Section 1 - DOSSIER. Six cards introducing WidgetState.
// ═══════════════════════════════════════════════════════════════════════════

class _WstDossierTab extends StatelessWidget {
  const _WstDossierTab();
  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'DOSSIER · CASE FILE WIDGETSTATE',
      subtitle: 'field handbook - six briefings before the console flight',
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints bc) {
        final bool wide = bc.maxWidth > 880;
        final int cols = wide ? 3 : (bc.maxWidth > 520 ? 2 : 1);
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: <Widget>[
            for (final _WstDossierCardData d in _wstDossierCards)
              SizedBox(
                width: (bc.maxWidth - (cols - 1) * 16) / cols,
                child: _WstDossierCard(data: d),
              ),
          ],
        );
      }),
    );
  }
}

class _WstDossierCardData {
  const _WstDossierCardData({
    required this.index,
    required this.title,
    required this.icon,
    required this.accent,
    required this.body,
  });
  final int index;
  final String title;
  final IconData icon;
  final Color accent;
  final String body;
}

const List<_WstDossierCardData> _wstDossierCards = <_WstDossierCardData>[
  _WstDossierCardData(
    index: 1,
    title: 'What is WidgetState?',
    icon: Icons.help_outline,
    accent: _WstPalette.lampAmber,
    body: 'WidgetState is the eight-valued Dart enum exported from '
        'package:flutter/widgets.dart and re-exported by package:flutter/'
        'material.dart. It replaced MaterialState in Flutter 3.19 and is now '
        'the canonical vocabulary for interactive state across every '
        'Material-family widget. Every value models a single orthogonal axis '
        'of a widgets current interactive condition.',
  ),
  _WstDossierCardData(
    index: 2,
    title: 'The eight values',
    icon: Icons.format_list_numbered,
    accent: _WstPalette.lampTeal,
    body: 'The enum declares, in order: hovered, focused, pressed, dragged, '
        'selected, scrolledUnder, disabled, error. Each is emitted by some '
        'subset of widgets. They are not mutually exclusive - a Checkbox can '
        'simultaneously be hovered, focused and pressed while also being '
        'selected.',
  ),
  _WstDossierCardData(
    index: 3,
    title: 'Doubles as a constraint',
    icon: Icons.verified_outlined,
    accent: _WstPalette.lampGreen,
    body: 'WidgetState implements WidgetStatesConstraint, so any one value '
        'can be used directly as a Map key in a WidgetStateMap, or as a '
        'predicate in WidgetStateProperty.fromMap. The constraint returns '
        'true when the value is contained in the supplied Set<WidgetState>.',
  ),
  _WstDossierCardData(
    index: 4,
    title: 'Logical operators & | ~',
    icon: Icons.memory,
    accent: _WstPalette.lampCrimson,
    body: 'Because WidgetState implements WidgetStatesConstraint, the & '
        '(AND), | (OR) and ~ (NOT) operators return composable constraints. '
        'hovered & ~disabled means "hovered and not disabled"; pressed | '
        'focused means "pressed or focused". Constraints can be nested '
        'arbitrarily and evaluated against a live Set<WidgetState>.',
  ),
  _WstDossierCardData(
    index: 5,
    title: 'WidgetState.any catch-all',
    icon: Icons.all_inclusive,
    accent: _WstPalette.lampBlue,
    body: 'WidgetStatesConstraint.any - re-exported as WidgetState.any in '
        'practice - is the sentinel constraint whose isSatisfiedBy method '
        'always returns true. It is the idiomatic default clause at the '
        'bottom of a WidgetStateMap, the fallback branch when no other key '
        'matches.',
  ),
  _WstDossierCardData(
    index: 6,
    title: 'Material emitters',
    icon: Icons.widgets_outlined,
    accent: _WstPalette.lampViolet,
    body: 'ElevatedButton, FilledButton, TextButton, OutlinedButton emit '
        'hovered/focused/pressed/disabled. Checkbox and Switch add selected. '
        'Sliders emit dragged. Chips may emit selected and disabled. '
        'NestedScrollView and SliverAppBar emit scrolledUnder. Form fields '
        'emit error. The enum is the contract the entire Material catalog '
        'agrees on.',
  ),
];

class _WstDossierCard extends StatelessWidget {
  const _WstDossierCard({required this.data});
  final _WstDossierCardData data;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: data.accent,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: data.accent.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: data.accent, width: 1.2),
              ),
              child: Icon(data.icon, color: data.accent, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              '§ ${data.index}',
              style: TextStyle(
                fontFamily: 'monospace',
                color: data.accent,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ]),
          const SizedBox(height: 12),
          Text(
            data.title,
            style: TextStyle(
              color: _WstPalette.engraveIvory,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                data.accent.withValues(alpha: 0.8),
                data.accent.withValues(alpha: 0.1),
              ]),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.body,
            style: const TextStyle(
              color: _WstPalette.engraveIvoryDim,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 2 - ANATOMY. Enum signature code block plus interpretation table.
// ═══════════════════════════════════════════════════════════════════════════

class _WstAnatomyTab extends StatelessWidget {
  const _WstAnatomyTab();
  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'ANATOMY · ENUM SIGNATURE',
      subtitle: 'eight values, one contract, ratified by WidgetStatesConstraint',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _WstPanel(
            accent: _WstPalette.brassLabel,
            child: _WstCodeBlock(
              caption: 'package:flutter/src/widgets/widget_state.dart',
              lines: <_WstCodeLine>[
                _WstCodeLine(<InlineSpan>[
                  _cm('// The eight orthogonal interactive states Material widgets emit.'),
                ]),
                _WstCodeLine(<InlineSpan>[
                  _kw('enum '),
                  _ty('WidgetState'),
                  _tx(' '),
                  _kw('implements '),
                  _ty('WidgetStatesConstraint'),
                  _pt(' {'),
                ]),
                _WstCodeLine(<InlineSpan>[_tx('  hovered'), _pt(',')]),
                _WstCodeLine(<InlineSpan>[_tx('  focused'), _pt(',')]),
                _WstCodeLine(<InlineSpan>[_tx('  pressed'), _pt(',')]),
                _WstCodeLine(<InlineSpan>[_tx('  dragged'), _pt(',')]),
                _WstCodeLine(<InlineSpan>[_tx('  selected'), _pt(',')]),
                _WstCodeLine(<InlineSpan>[_tx('  scrolledUnder'), _pt(',')]),
                _WstCodeLine(<InlineSpan>[_tx('  disabled'), _pt(',')]),
                _WstCodeLine(<InlineSpan>[_tx('  error'), _pt(';')]),
                _WstCodeLine(<InlineSpan>[_tx('')]),
                _WstCodeLine(<InlineSpan>[
                  _pt('  @override'),
                ]),
                _WstCodeLine(<InlineSpan>[
                  _tx('  '),
                  _ty('bool'),
                  _tx(' '),
                  _pt('isSatisfiedBy('),
                  _ty('Set'),
                  _pt('<'),
                  _ty('WidgetState'),
                  _pt('> states) => states.contains('),
                  _kw('this'),
                  _pt(');'),
                ]),
                _WstCodeLine(<InlineSpan>[_pt('}')]),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _WstPanel(
            accent: _WstPalette.lampTeal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'VALUE TABLE',
                  style: TextStyle(
                    color: _WstPalette.brassLabelBright,
                    fontSize: 11,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                _WstAnatomyTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WstAnatomyTable extends StatelessWidget {
  const _WstAnatomyTable();
  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>['#', 'VALUE', 'MEANING', 'TYPICAL EMITTER', 'CATALOG CONSUMER'],
      <String>['0', 'hovered', 'pointer is over the hit-region', 'InkWell, Button, Chip', 'ButtonStyle.backgroundColor'],
      <String>['1', 'focused', 'widget owns the primary focus', 'Focusable, TextField', 'ButtonStyle.overlayColor'],
      <String>['2', 'pressed', 'primary pointer button is down', 'InkWell, Button', 'InkWell splash, overlayColor'],
      <String>['3', 'dragged', 'an active drag gesture is in flight', 'Slider, DraggableScrollbar', 'SliderThemeData.thumbColor'],
      <String>['4', 'selected', 'toggleable widget is in the on state', 'Checkbox, Radio, Switch, Chip', 'CheckboxTheme.fillColor'],
      <String>['5', 'scrolledUnder', 'scrollable content has scrolled under', 'NestedScrollView, SliverAppBar', 'AppBarTheme.backgroundColor'],
      <String>['6', 'disabled', 'onPressed / onChanged is null', 'Every interactive widget', 'ButtonStyle.foregroundColor'],
      <String>['7', 'error', 'current input is in an error condition', 'FormField, TextField', 'InputDecorationTheme.borderColor'],
    ];
    return Column(children: <Widget>[
      for (int i = 0; i < rows.length; i++)
        _WstAnatomyRow(row: rows[i], header: i == 0, zebra: i.isOdd),
    ]);
  }
}

class _WstAnatomyRow extends StatelessWidget {
  const _WstAnatomyRow({required this.row, required this.header, required this.zebra});
  final List<String> row;
  final bool header;
  final bool zebra;
  @override
  Widget build(BuildContext context) {
    final Color bg = header
        ? _WstPalette.panelBlack
        : (zebra ? _WstPalette.panelSteel : _WstPalette.panelSteelLight);
    final Color fg = header ? _WstPalette.brassLabelBright : _WstPalette.engraveIvory;
    final TextStyle style = TextStyle(
      fontFamily: 'monospace',
      color: header ? fg : _WstPalette.engraveIvoryDim,
      fontSize: header ? 11 : 12,
      fontWeight: header ? FontWeight.w800 : FontWeight.w500,
      letterSpacing: header ? 1.4 : 0.2,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: _WstPalette.panelSeam.withValues(alpha: 0.8))),
      ),
      child: Row(children: <Widget>[
        SizedBox(width: 24, child: Text(row[0], style: style.copyWith(color: fg))),
        SizedBox(width: 120, child: Text(row[1], style: style.copyWith(color: fg, fontWeight: header ? FontWeight.w800 : FontWeight.w700))),
        Expanded(flex: 3, child: Text(row[2], style: style)),
        Expanded(flex: 2, child: Text(row[3], style: style)),
        Expanded(flex: 2, child: Text(row[4], style: style)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 3 - LIVE ANNUNCIATOR. Centerpiece.
// 4x2 lamp grid, side-rail toggles, live Set<WidgetState> readouts.
// ═══════════════════════════════════════════════════════════════════════════

class _WstAnnunciatorTab extends StatefulWidget {
  const _WstAnnunciatorTab();
  @override
  State<_WstAnnunciatorTab> createState() => _WstAnnunciatorTabState();
}

class _WstAnnunciatorTabState extends State<_WstAnnunciatorTab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'ANNUNCIATOR · LIVE CONSOLE',
      subtitle: 'toggle the side-rail switches to light the eight lamps',
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wstLiveStates,
        builder: (BuildContext context, Set<WidgetState> states, Widget? _) {
          return LayoutBuilder(builder: (BuildContext context, BoxConstraints bc) {
            final bool wide = bc.maxWidth > 880;
            final Widget grid = _WstLampGrid(states: states, pulse: _pulse);
            final Widget rail = _WstSideRail(states: states);
            final Widget readouts = _WstReadouts(states: states);
            if (wide) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(flex: 3, child: grid),
                      const SizedBox(width: 16),
                      SizedBox(width: 280, child: rail),
                    ],
                  ),
                  const SizedBox(height: 16),
                  readouts,
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                grid,
                const SizedBox(height: 16),
                rail,
                const SizedBox(height: 16),
                readouts,
              ],
            );
          });
        },
      ),
    );
  }
}

class _WstLampGrid extends StatelessWidget {
  const _WstLampGrid({required this.states, required this.pulse});
  final Set<WidgetState> states;
  final AnimationController pulse;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: _WstPalette.lampAmber,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            const Icon(Icons.light_mode_outlined, color: _WstPalette.lampAmber, size: 16),
            const SizedBox(width: 8),
            Text(
              'ANNUNCIATOR PANEL · 4 × 2',
              style: TextStyle(
                color: _WstPalette.brassLabelBright,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.8,
              ),
            ),
          ]),
          const SizedBox(height: 12),
          LayoutBuilder(builder: (BuildContext context, BoxConstraints bc) {
            final int cols = bc.maxWidth > 560 ? 4 : (bc.maxWidth > 320 ? 2 : 1);
            final double w = (bc.maxWidth - (cols - 1) * 12) / cols;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                for (final WidgetState s in _wstAllStates)
                  SizedBox(
                    width: w,
                    child: _WstLampCard(
                      state: s,
                      lit: states.contains(s),
                      pulse: pulse,
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _WstLampCard extends StatelessWidget {
  const _WstLampCard({
    required this.state,
    required this.lit,
    required this.pulse,
  });
  final WidgetState state;
  final bool lit;
  final AnimationController pulse;
  @override
  Widget build(BuildContext context) {
    final Color c = _wstStateLampColor(state);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_WstPalette.panelSteelLight, _WstPalette.panelSteel],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: lit ? c : _WstPalette.rivet,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedBuilder(
            animation: pulse,
            builder: (BuildContext context, Widget? child) {
              final double t = lit ? pulse.value : 0.0;
              return SizedBox(
                height: 72,
                width: double.infinity,
                child: CustomPaint(
                  painter: _WstLampGlowPainter(color: c, lit: lit, phase: t),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(children: <Widget>[
            Icon(_wstStateIcon(state), color: lit ? c : _WstPalette.engraveIvoryDim, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _wstStateName(state),
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: lit ? _WstPalette.engraveIvory : _WstPalette.engraveIvoryDim,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 4),
          Text(
            lit ? 'LIT' : 'DARK',
            style: TextStyle(
              fontFamily: 'monospace',
              color: lit ? c : _WstPalette.rivet,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _WstLampGlowPainter extends CustomPainter {
  _WstLampGlowPainter({required this.color, required this.lit, required this.phase});
  final Color color;
  final bool lit;
  final double phase;
  @override
  void paint(Canvas canvas, Size size) {
    final Rect r = Offset.zero & size;
    final Offset c = r.center;
    final double base = math.min(size.width, size.height) * 0.40;
    final double bulbRadius = base;
    // Housing cup.
    final Paint cup = Paint()
      ..shader = RadialGradient(
        center: Alignment.topLeft,
        colors: <Color>[
          _WstPalette.panelSteelLight,
          _WstPalette.panelSteel,
          _WstPalette.panelBlack,
        ],
      ).createShader(r);
    canvas.drawRRect(
      RRect.fromRectAndRadius(r.deflate(2), const Radius.circular(10)),
      cup,
    );
    // Bulb glass.
    final Color bulbColor = lit
        ? Color.lerp(color, _WstPalette.paperLabel, 0.15 + 0.20 * phase)!
        : _WstPalette.panelSeam;
    final Paint bulb = Paint()
      ..shader = RadialGradient(
        center: Alignment.topLeft,
        colors: <Color>[
          bulbColor,
          lit ? color.withValues(alpha: 0.6) : _WstPalette.panelSeam,
          _WstPalette.panelBlack,
        ],
        stops: const <double>[0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: c, radius: bulbRadius));
    canvas.drawCircle(c, bulbRadius, bulb);
    // Glow halo (only lit).
    if (lit) {
      final Paint halo = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            color.withValues(alpha: 0.55 + 0.25 * phase),
            color.withValues(alpha: 0.10),
            Colors.transparent,
          ],
          stops: const <double>[0.0, 0.55, 1.0],
        ).createShader(
            Rect.fromCircle(center: c, radius: bulbRadius * (1.8 + 0.3 * phase)));
      canvas.drawCircle(c, bulbRadius * (1.8 + 0.3 * phase), halo);
    }
    // Specular highlight.
    final Paint spec = Paint()
      ..color = _WstPalette.paperLabel.withValues(alpha: lit ? 0.65 : 0.10);
    canvas.drawCircle(
      c.translate(-bulbRadius * 0.35, -bulbRadius * 0.35),
      bulbRadius * 0.22,
      spec,
    );
    // Bezel ring.
    final Paint bezel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = _WstPalette.brassLabel.withValues(alpha: 0.65);
    canvas.drawCircle(c, bulbRadius + 1, bezel);
  }

  @override
  bool shouldRepaint(covariant _WstLampGlowPainter oldDelegate) =>
      oldDelegate.lit != lit ||
      oldDelegate.phase != phase ||
      oldDelegate.color != color;
}

class _WstSideRail extends StatelessWidget {
  const _WstSideRail({required this.states});
  final Set<WidgetState> states;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: _WstPalette.lampTeal,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(children: <Widget>[
              const Icon(Icons.toggle_on_outlined, color: _WstPalette.lampTeal, size: 16),
              const SizedBox(width: 8),
              Text(
                'STATE TOGGLES',
                style: TextStyle(
                  color: _WstPalette.brassLabelBright,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 4),
          for (final WidgetState s in _wstAllStates)
            _WstRailRow(state: s, lit: states.contains(s)),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(children: <Widget>[
              _WstMiniButton(
                label: 'CLEAR',
                icon: Icons.clear_all,
                onTap: () => _wstLiveStates.value = <WidgetState>{},
              ),
              const SizedBox(width: 8),
              _WstMiniButton(
                label: 'ALL',
                icon: Icons.select_all,
                onTap: () =>
                    _wstLiveStates.value = <WidgetState>{..._wstAllStates},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _WstRailRow extends StatelessWidget {
  const _WstRailRow({required this.state, required this.lit});
  final WidgetState state;
  final bool lit;
  @override
  Widget build(BuildContext context) {
    final Color c = _wstStateLampColor(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: SwitchListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6),
        title: Row(children: <Widget>[
          Icon(_wstStateIcon(state), size: 16, color: lit ? c : _WstPalette.engraveIvoryDim),
          const SizedBox(width: 8),
          Text(
            _wstStateName(state),
            style: TextStyle(
              fontFamily: 'monospace',
              color: lit ? _WstPalette.engraveIvory : _WstPalette.engraveIvoryDim,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ]),
        value: lit,
        activeThumbColor: c,
        activeTrackColor: c.withValues(alpha: 0.35),
        onChanged: (bool _) => _wstToggle(_wstLiveStates, state),
      ),
    );
  }
}

class _WstMiniButton extends StatelessWidget {
  const _WstMiniButton({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: _WstPalette.brassLabel.withValues(alpha: 0.6)),
            borderRadius: BorderRadius.circular(6),
            color: _WstPalette.panelBlack.withValues(alpha: 0.5),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Icon(icon, size: 14, color: _WstPalette.brassLabelBright),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                color: _WstPalette.brassLabelBright,
                fontSize: 11,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _WstReadouts extends StatelessWidget {
  const _WstReadouts({required this.states});
  final Set<WidgetState> states;

  static final Map<WidgetStatesConstraint, Color> _resolverMap =
      <WidgetStatesConstraint, Color>{
    WidgetState.error: _WstPalette.lampCrimson,
    WidgetState.disabled: _WstPalette.rivetGlint,
    WidgetState.pressed: _WstPalette.lampAmberDeep,
    WidgetState.hovered: _WstPalette.lampAmber,
    WidgetState.focused: _WstPalette.lampTeal,
    WidgetState.selected: _WstPalette.lampGreen,
    WidgetState.dragged: _WstPalette.lampViolet,
    WidgetState.scrolledUnder: _WstPalette.lampBlue,
    WidgetState.any: _WstPalette.engraveIvoryDim,
  };

  Color _resolveColor(Set<WidgetState> s) {
    for (final MapEntry<WidgetStatesConstraint, Color> e in _resolverMap.entries) {
      if (e.key.isSatisfiedBy(s)) return e.value;
    }
    return _WstPalette.engraveIvoryDim;
  }

  String _matchedKeyLabel(Set<WidgetState> s) {
    for (final MapEntry<WidgetStatesConstraint, Color> e in _resolverMap.entries) {
      if (e.key.isSatisfiedBy(s)) {
        final WidgetStatesConstraint k = e.key;
        if (k is WidgetState) return _wstStateName(k);
        if (identical(k, WidgetState.any)) return 'WidgetState.any';
        return k.toString();
      }
    }
    return '(no match)';
  }

  bool _compositeExpression(Set<WidgetState> s) {
    // hovered & ~disabled
    return (WidgetState.hovered & ~WidgetState.disabled).isSatisfiedBy(s);
  }

  @override
  Widget build(BuildContext context) {
    final Color resolved = _resolveColor(states);
    final String matched = _matchedKeyLabel(states);
    final bool composite = _compositeExpression(states);
    return _WstPanel(
      accent: _WstPalette.lampAmber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'LIVE READOUT',
            style: TextStyle(
              color: _WstPalette.brassLabelBright,
              fontSize: 11,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          // Pill row.
          Wrap(children: <Widget>[
            for (final WidgetState s in _wstAllStates)
              if (states.contains(s)) _WstStateChip(state: s, active: true),
            if (states.isEmpty)
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  '(empty Set<WidgetState>)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _WstPalette.engraveIvoryDim,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ]),
          const SizedBox(height: 8),
          _WstReadoutLine(
            label: 'Set<WidgetState>',
            value: _wstSetRepr(states),
          ),
          _WstReadoutLine(
            label: 'hovered & ~disabled',
            value: composite ? 'true' : 'false',
            highlight: composite ? _WstPalette.lampGreen : _WstPalette.lampCrimson,
          ),
          _WstReadoutLine(
            label: 'WidgetStateMap match',
            value: matched,
            highlight: _WstPalette.lampAmber,
          ),
          const SizedBox(height: 10),
          Row(children: <Widget>[
            Text(
              'resolver -> ',
              style: TextStyle(
                fontFamily: 'monospace',
                color: _WstPalette.engraveIvoryDim,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 40,
              height: 24,
              decoration: BoxDecoration(
                color: resolved,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _WstPalette.brassLabel, width: 1),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '#${resolved.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
              style: TextStyle(
                fontFamily: 'monospace',
                color: _WstPalette.engraveIvory,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _WstReadoutLine extends StatelessWidget {
  const _WstReadoutLine({
    required this.label,
    required this.value,
    this.highlight,
  });
  final String label;
  final String value;
  final Color? highlight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              color: _WstPalette.brassLabel,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              color: highlight ?? _WstPalette.engraveIvory,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 4 - SET ALGEBRA PLAYGROUND.
// contains / add / remove / union / intersection / difference.
// ═══════════════════════════════════════════════════════════════════════════

class _WstSetAlgebraTab extends StatelessWidget {
  const _WstSetAlgebraTab();
  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'SET ALGEBRA · PLAYGROUND',
      subtitle: 'dart:core Set<WidgetState> operators, live on two source sets',
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wstAlgebraA,
        builder: (BuildContext context, Set<WidgetState> a, Widget? _) {
          return ValueListenableBuilder<Set<WidgetState>>(
            valueListenable: _wstAlgebraB,
            builder: (BuildContext context, Set<WidgetState> b, Widget? _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _WstSetBuilder(
                    label: 'SET A',
                    accent: _WstPalette.lampAmber,
                    set: a,
                    onToggle: (WidgetState s) => _wstToggle(_wstAlgebraA, s),
                  ),
                  const SizedBox(height: 12),
                  _WstSetBuilder(
                    label: 'SET B',
                    accent: _WstPalette.lampTeal,
                    set: b,
                    onToggle: (WidgetState s) => _wstToggle(_wstAlgebraB, s),
                  ),
                  const SizedBox(height: 16),
                  _WstAlgebraCards(a: a, b: b),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _WstSetBuilder extends StatelessWidget {
  const _WstSetBuilder({
    required this.label,
    required this.accent,
    required this.set,
    required this.onToggle,
  });
  final String label;
  final Color accent;
  final Set<WidgetState> set;
  final ValueChanged<WidgetState> onToggle;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: accent,
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Icon(Icons.circle, size: 10, color: accent),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            _wstSetRepr(set),
            style: TextStyle(
              fontFamily: 'monospace',
              color: _WstPalette.engraveIvory,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ]),
        const SizedBox(height: 10),
        Wrap(children: <Widget>[
          for (final WidgetState s in _wstAllStates)
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => onToggle(s),
              child: _WstStateChip(state: s, active: set.contains(s)),
            ),
        ]),
      ]),
    );
  }
}

class _WstAlgebraCards extends StatelessWidget {
  const _WstAlgebraCards({required this.a, required this.b});
  final Set<WidgetState> a;
  final Set<WidgetState> b;
  @override
  Widget build(BuildContext context) {
    final List<_WstAlgebraEntry> entries = <_WstAlgebraEntry>[
      _WstAlgebraEntry(
        op: 'A.contains(hovered)',
        result: a.contains(WidgetState.hovered) ? 'true' : 'false',
        chips: <WidgetState>{},
        diff: <WidgetState>{},
        boolean: true,
        boolValue: a.contains(WidgetState.hovered),
      ),
      _WstAlgebraEntry(
        op: 'A.add(error)',
        chips: <WidgetState>{...a, WidgetState.error},
        diff: a.contains(WidgetState.error) ? <WidgetState>{} : <WidgetState>{WidgetState.error},
      ),
      _WstAlgebraEntry(
        op: 'A.remove(hovered)',
        chips: <WidgetState>{...a}..remove(WidgetState.hovered),
        diff: a.contains(WidgetState.hovered) ? <WidgetState>{WidgetState.hovered} : <WidgetState>{},
        removed: true,
      ),
      _WstAlgebraEntry(
        op: 'A ∪ B  (union)',
        chips: a.union(b),
        diff: a.union(b).difference(a),
      ),
      _WstAlgebraEntry(
        op: 'A ∩ B  (intersection)',
        chips: a.intersection(b),
        diff: <WidgetState>{},
        kept: true,
      ),
      _WstAlgebraEntry(
        op: 'A \\ B  (difference)',
        chips: a.difference(b),
        diff: a.intersection(b),
        removed: true,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final _WstAlgebraEntry e in entries) ...<Widget>[
          _WstAlgebraCard(entry: e),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _WstAlgebraEntry {
  _WstAlgebraEntry({
    required this.op,
    required this.chips,
    required this.diff,
    this.removed = false,
    this.kept = false,
    this.boolean = false,
    this.boolValue = false,
    this.result,
  });
  final String op;
  final Set<WidgetState> chips;
  final Set<WidgetState> diff;
  final bool removed;
  final bool kept;
  final bool boolean;
  final bool boolValue;
  final String? result;
}

class _WstAlgebraCard extends StatelessWidget {
  const _WstAlgebraCard({required this.entry});
  final _WstAlgebraEntry entry;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: _WstPalette.brassLabel,
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _WstPalette.codeBg,
              border: Border.all(color: _WstPalette.brassLabel),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Icon(
              _opIcon(entry.op),
              color: _WstPalette.brassLabelBright,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              entry.op,
              style: TextStyle(
                fontFamily: 'monospace',
                color: _WstPalette.engraveIvory,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (entry.boolean)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: (entry.boolValue ? _WstPalette.lampGreen : _WstPalette.lampCrimson)
                    .withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: entry.boolValue ? _WstPalette.lampGreen : _WstPalette.lampCrimson,
                ),
              ),
              child: Text(
                entry.result ?? (entry.boolValue ? 'true' : 'false'),
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: entry.boolValue ? _WstPalette.lampGreen : _WstPalette.lampCrimson,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
        ]),
        if (!entry.boolean) ...<Widget>[
          const SizedBox(height: 10),
          Wrap(children: <Widget>[
            for (final WidgetState s in _wstAllStates)
              if (entry.chips.contains(s))
                _WstAlgebraChip(
                  state: s,
                  highlight: entry.diff.contains(s) && !entry.removed,
                ),
            for (final WidgetState s in _wstAllStates)
              if (entry.removed && entry.diff.contains(s))
                _WstAlgebraChip(state: s, highlight: true, strikeout: true),
          ]),
        ],
      ]),
    );
  }

  IconData _opIcon(String op) {
    if (op.contains('contains')) return Icons.search;
    if (op.contains('add')) return Icons.add;
    if (op.contains('remove')) return Icons.remove;
    if (op.contains('∪')) return Icons.call_merge;
    if (op.contains('∩')) return Icons.join_inner_outlined;
    if (op.contains('\\')) return Icons.call_split;
    return Icons.functions;
  }
}

class _WstAlgebraChip extends StatelessWidget {
  const _WstAlgebraChip({
    required this.state,
    this.highlight = false,
    this.strikeout = false,
  });
  final WidgetState state;
  final bool highlight;
  final bool strikeout;
  @override
  Widget build(BuildContext context) {
    final Color c = _wstStateLampColor(state);
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: highlight
            ? c.withValues(alpha: strikeout ? 0.10 : 0.28)
            : c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: highlight ? c : c.withValues(alpha: 0.5),
          width: highlight ? 1.8 : 1.0,
        ),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Icon(_wstStateIcon(state), color: c, size: 14),
        const SizedBox(width: 6),
        Text(
          _wstStateName(state),
          style: TextStyle(
            fontFamily: 'monospace',
            color: _WstPalette.engraveIvory,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            decoration: strikeout ? TextDecoration.lineThrough : TextDecoration.none,
            decorationColor: _WstPalette.lampCrimson,
          ),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 5 - CONSTRAINT COMPOSITION. Boolean-gate circuit diagrams.
// ═══════════════════════════════════════════════════════════════════════════

class _WstCompositionTab extends StatefulWidget {
  const _WstCompositionTab();
  @override
  State<_WstCompositionTab> createState() => _WstCompositionTabState();
}

class _WstCompositionTabState extends State<_WstCompositionTab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glow;

  @override
  void initState() {
    super.initState();
    _glow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  static final List<_WstExpression> _expressions = <_WstExpression>[
    _WstExpression(
      label: 'pressed & hovered',
      build: () => WidgetState.pressed & WidgetState.hovered,
      tree: _WstGateNode.and(
        left: _WstGateNode.input(WidgetState.pressed),
        right: _WstGateNode.input(WidgetState.hovered),
      ),
    ),
    _WstExpression(
      label: 'selected | focused',
      build: () => WidgetState.selected | WidgetState.focused,
      tree: _WstGateNode.or(
        left: _WstGateNode.input(WidgetState.selected),
        right: _WstGateNode.input(WidgetState.focused),
      ),
    ),
    _WstExpression(
      label: '~disabled & error',
      build: () => (~WidgetState.disabled) & WidgetState.error,
      tree: _WstGateNode.and(
        left: _WstGateNode.not(_WstGateNode.input(WidgetState.disabled)),
        right: _WstGateNode.input(WidgetState.error),
      ),
    ),
    _WstExpression(
      label: '(hovered | focused) & ~disabled',
      build: () => (WidgetState.hovered | WidgetState.focused) & ~WidgetState.disabled,
      tree: _WstGateNode.and(
        left: _WstGateNode.or(
          left: _WstGateNode.input(WidgetState.hovered),
          right: _WstGateNode.input(WidgetState.focused),
        ),
        right: _WstGateNode.not(_WstGateNode.input(WidgetState.disabled)),
      ),
    ),
    _WstExpression(
      label: 'pressed & selected & ~error',
      build: () => WidgetState.pressed & WidgetState.selected & ~WidgetState.error,
      tree: _WstGateNode.and(
        left: _WstGateNode.and(
          left: _WstGateNode.input(WidgetState.pressed),
          right: _WstGateNode.input(WidgetState.selected),
        ),
        right: _WstGateNode.not(_WstGateNode.input(WidgetState.error)),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'COMPOSITION · BOOLEAN GATES',
      subtitle: '& / | / ~ form a full constraint algebra painted as gate trees',
      child: ValueListenableBuilder<int>(
        valueListenable: _wstExpressionIndex,
        builder: (BuildContext context, int idx, Widget? _) {
          return ValueListenableBuilder<Set<WidgetState>>(
            valueListenable: _wstLiveStates,
            builder: (BuildContext context, Set<WidgetState> states, Widget? _) {
              final _WstExpression expr = _expressions[idx % _expressions.length];
              final bool satisfied = expr.build().isSatisfiedBy(states);
              return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                _WstPanel(
                  accent: _WstPalette.lampTeal,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text(
                      'SELECT EXPRESSION',
                      style: TextStyle(
                        color: _WstPalette.brassLabelBright,
                        fontSize: 11,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
                      for (int i = 0; i < _expressions.length; i++)
                        ChoiceChip(
                          label: Text(
                            _expressions[i].label,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          selected: i == idx,
                          selectedColor: _WstPalette.lampTeal.withValues(alpha: 0.3),
                          backgroundColor: _WstPalette.panelBlack,
                          side: BorderSide(
                            color: i == idx ? _WstPalette.lampTeal : _WstPalette.rivet,
                          ),
                          labelStyle: TextStyle(
                            color: i == idx ? _WstPalette.lampTeal : _WstPalette.engraveIvoryDim,
                          ),
                          onSelected: (bool _) => _wstExpressionIndex.value = i,
                        ),
                    ]),
                  ]),
                ),
                const SizedBox(height: 14),
                _WstPanel(
                  accent: satisfied ? _WstPalette.lampGreen : _WstPalette.lampCrimson,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                        'GATE DIAGRAM',
                        style: TextStyle(
                          color: _WstPalette.brassLabelBright,
                          fontSize: 11,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (satisfied ? _WstPalette.lampGreen : _WstPalette.lampCrimson)
                              .withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: satisfied ? _WstPalette.lampGreen : _WstPalette.lampCrimson,
                          ),
                        ),
                        child: Text(
                          satisfied ? 'OUTPUT = 1' : 'OUTPUT = 0',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: satisfied ? _WstPalette.lampGreen : _WstPalette.lampCrimson,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    AnimatedBuilder(
                      animation: _glow,
                      builder: (BuildContext context, Widget? _) {
                        return SizedBox(
                          height: 260,
                          child: CustomPaint(
                            painter: _WstGateTreePainter(
                              tree: expr.tree,
                              states: states,
                              phase: _glow.value,
                            ),
                            child: Container(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _WstCodeBlock(lines: <_WstCodeLine>[
                      _WstCodeLine(<InlineSpan>[
                        _kw('final '),
                        _ty('WidgetStatesConstraint'),
                        _tx(' c = '),
                        _tx(expr.label),
                        _pt(';'),
                      ]),
                      _WstCodeLine(<InlineSpan>[
                        _kw('final '),
                        _ty('bool'),
                        _tx(' result = c.isSatisfiedBy(states); '),
                        _cm('// ${satisfied ? 'true' : 'false'}'),
                      ]),
                    ]),
                  ]),
                ),
              ]);
            },
          );
        },
      ),
    );
  }
}

class _WstExpression {
  _WstExpression({required this.label, required this.build, required this.tree});
  final String label;
  final WidgetStatesConstraint Function() build;
  final _WstGateNode tree;
}

enum _WstGateKind { input, notGate, andGate, orGate }

class _WstGateNode {
  _WstGateNode._({
    required this.kind,
    this.state,
    this.left,
    this.right,
    this.child,
  });
  factory _WstGateNode.input(WidgetState s) =>
      _WstGateNode._(kind: _WstGateKind.input, state: s);
  factory _WstGateNode.not(_WstGateNode child) =>
      _WstGateNode._(kind: _WstGateKind.notGate, child: child);
  factory _WstGateNode.and({required _WstGateNode left, required _WstGateNode right}) =>
      _WstGateNode._(kind: _WstGateKind.andGate, left: left, right: right);
  factory _WstGateNode.or({required _WstGateNode left, required _WstGateNode right}) =>
      _WstGateNode._(kind: _WstGateKind.orGate, left: left, right: right);
  final _WstGateKind kind;
  final WidgetState? state;
  final _WstGateNode? left;
  final _WstGateNode? right;
  final _WstGateNode? child;

  bool evaluate(Set<WidgetState> s) {
    switch (kind) {
      case _WstGateKind.input:
        return s.contains(state!);
      case _WstGateKind.notGate:
        return !child!.evaluate(s);
      case _WstGateKind.andGate:
        return left!.evaluate(s) && right!.evaluate(s);
      case _WstGateKind.orGate:
        return left!.evaluate(s) || right!.evaluate(s);
    }
  }
}

class _WstGateTreePainter extends CustomPainter {
  _WstGateTreePainter({required this.tree, required this.states, required this.phase});
  final _WstGateNode tree;
  final Set<WidgetState> states;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    // Layout: assign depths to nodes left-to-right, inputs on the left edge.
    final List<_WstGateNode> inputs = <_WstGateNode>[];
    _collectInputs(tree, inputs);
    final double inputSpacing = size.height / (inputs.length + 1);
    final Map<_WstGateNode, Offset> positions = <_WstGateNode, Offset>{};
    for (int i = 0; i < inputs.length; i++) {
      positions[inputs[i]] = Offset(24, inputSpacing * (i + 1));
    }
    _layout(tree, size, positions, inputs);

    // Draw wires (post-order so children before parents).
    _drawWires(canvas, tree, positions);
    // Draw nodes.
    _drawNode(canvas, tree, positions);

    // Output wire.
    final Offset rootPos = positions[tree]!;
    final bool rootLit = tree.evaluate(states);
    final Paint outWire = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = rootLit
          ? Color.lerp(_WstPalette.wireLive, _WstPalette.wireHot, phase)!
          : _WstPalette.wireDim;
    canvas.drawLine(
      rootPos.translate(38, 0),
      Offset(size.width - 18, rootPos.dy),
      outWire,
    );
    final Paint outTerm = Paint()..color = rootLit ? _WstPalette.lampGreen : _WstPalette.lampCrimson;
    canvas.drawCircle(Offset(size.width - 18, rootPos.dy), 7, outTerm);
  }

  void _collectInputs(_WstGateNode n, List<_WstGateNode> out) {
    switch (n.kind) {
      case _WstGateKind.input:
        out.add(n);
        break;
      case _WstGateKind.notGate:
        _collectInputs(n.child!, out);
        break;
      case _WstGateKind.andGate:
      case _WstGateKind.orGate:
        _collectInputs(n.left!, out);
        _collectInputs(n.right!, out);
        break;
    }
  }

  void _layout(
    _WstGateNode n,
    Size size,
    Map<_WstGateNode, Offset> pos,
    List<_WstGateNode> inputs,
  ) {
    switch (n.kind) {
      case _WstGateKind.input:
        break;
      case _WstGateKind.notGate:
        _layout(n.child!, size, pos, inputs);
        final Offset c = pos[n.child!]!;
        pos[n] = Offset(c.dx + 90, c.dy);
        break;
      case _WstGateKind.andGate:
      case _WstGateKind.orGate:
        _layout(n.left!, size, pos, inputs);
        _layout(n.right!, size, pos, inputs);
        final Offset l = pos[n.left!]!;
        final Offset r = pos[n.right!]!;
        pos[n] = Offset(math.max(l.dx, r.dx) + 110, (l.dy + r.dy) / 2);
        break;
    }
  }

  void _drawWires(Canvas canvas, _WstGateNode n, Map<_WstGateNode, Offset> pos) {
    switch (n.kind) {
      case _WstGateKind.input:
        return;
      case _WstGateKind.notGate:
        _drawWires(canvas, n.child!, pos);
        _wire(canvas, pos[n.child!]!.translate(28, 0), pos[n]!.translate(-22, 0),
            n.child!.evaluate(states));
        break;
      case _WstGateKind.andGate:
      case _WstGateKind.orGate:
        _drawWires(canvas, n.left!, pos);
        _drawWires(canvas, n.right!, pos);
        final Offset myIn1 = pos[n]!.translate(-30, -14);
        final Offset myIn2 = pos[n]!.translate(-30, 14);
        _wire(canvas, pos[n.left!]!.translate(28, 0), myIn1, n.left!.evaluate(states));
        _wire(canvas, pos[n.right!]!.translate(28, 0), myIn2, n.right!.evaluate(states));
        break;
    }
  }

  void _wire(Canvas canvas, Offset a, Offset b, bool live) {
    final Paint p = Paint()
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..color = live
          ? Color.lerp(_WstPalette.wireLive, _WstPalette.wireHot, phase * 0.6)!
          : _WstPalette.wireDim;
    final Path path = Path()..moveTo(a.dx, a.dy);
    final double mid = (a.dx + b.dx) / 2;
    path.cubicTo(mid, a.dy, mid, b.dy, b.dx, b.dy);
    canvas.drawPath(path, p);
  }

  void _drawNode(Canvas canvas, _WstGateNode n, Map<_WstGateNode, Offset> pos) {
    final Offset p = pos[n]!;
    final bool lit = n.evaluate(states);
    switch (n.kind) {
      case _WstGateKind.input:
        _drawInputTerm(canvas, p, n.state!, lit);
        break;
      case _WstGateKind.notGate:
        _drawWires(canvas, n.child!, pos);
        _drawNode(canvas, n.child!, pos);
        _drawNotGate(canvas, p, lit);
        break;
      case _WstGateKind.andGate:
        _drawNode(canvas, n.left!, pos);
        _drawNode(canvas, n.right!, pos);
        _drawAndGate(canvas, p, lit);
        break;
      case _WstGateKind.orGate:
        _drawNode(canvas, n.left!, pos);
        _drawNode(canvas, n.right!, pos);
        _drawOrGate(canvas, p, lit);
        break;
    }
  }

  void _drawInputTerm(Canvas canvas, Offset p, WidgetState s, bool lit) {
    final Color c = _wstStateLampColor(s);
    final Paint pin = Paint()..color = lit ? c : _WstPalette.rivet;
    canvas.drawCircle(p, 8, pin);
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = _WstPalette.brassLabel.withValues(alpha: 0.8);
    canvas.drawCircle(p, 9, ring);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: _wstStateName(s),
        style: TextStyle(
          fontFamily: 'monospace',
          color: lit ? _WstPalette.engraveIvory : _WstPalette.engraveIvoryDim,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, p.translate(-tp.width - 12, -tp.height / 2));
  }

  void _drawNotGate(Canvas canvas, Offset p, bool lit) {
    final Paint body = Paint()
      ..style = PaintingStyle.fill
      ..color = lit ? _WstPalette.lampCrimson.withValues(alpha: 0.2) : _WstPalette.panelSteelLight;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = lit ? _WstPalette.lampCrimson : _WstPalette.rivetGlint;
    final Path tri = Path()
      ..moveTo(p.dx - 22, p.dy - 16)
      ..lineTo(p.dx - 22, p.dy + 16)
      ..lineTo(p.dx + 14, p.dy)
      ..close();
    canvas.drawPath(tri, body);
    canvas.drawPath(tri, stroke);
    canvas.drawCircle(p.translate(20, 0), 4, stroke);
    _label(canvas, p.translate(-8, -4), 'NOT', lit ? _WstPalette.lampCrimson : _WstPalette.engraveIvoryDim);
  }

  void _drawAndGate(Canvas canvas, Offset p, bool lit) {
    final Rect body = Rect.fromCenter(center: p, width: 52, height: 42);
    final Paint fill = Paint()
      ..color = lit ? _WstPalette.lampGreen.withValues(alpha: 0.18) : _WstPalette.panelSteelLight;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = lit ? _WstPalette.lampGreen : _WstPalette.rivetGlint;
    final Path path = Path()
      ..moveTo(body.left, body.top)
      ..lineTo(body.left + 16, body.top)
      ..arcToPoint(
        Offset(body.left + 16, body.bottom),
        radius: Radius.circular(body.height / 2 + 4),
        clockwise: true,
      )
      ..lineTo(body.left, body.bottom)
      ..close();
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    _label(canvas, p.translate(-14, -4), 'AND', lit ? _WstPalette.lampGreen : _WstPalette.engraveIvoryDim);
  }

  void _drawOrGate(Canvas canvas, Offset p, bool lit) {
    final Rect body = Rect.fromCenter(center: p, width: 58, height: 42);
    final Paint fill = Paint()
      ..color = lit ? _WstPalette.lampAmber.withValues(alpha: 0.18) : _WstPalette.panelSteelLight;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = lit ? _WstPalette.lampAmber : _WstPalette.rivetGlint;
    final Path path = Path()
      ..moveTo(body.left, body.top)
      ..quadraticBezierTo(body.left + 14, p.dy, body.left, body.bottom)
      ..quadraticBezierTo(body.left + 18, body.bottom - 2, body.right, p.dy)
      ..quadraticBezierTo(body.left + 18, body.top + 2, body.left, body.top)
      ..close();
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    _label(canvas, p.translate(-10, -4), 'OR', lit ? _WstPalette.lampAmber : _WstPalette.engraveIvoryDim);
  }

  void _label(Canvas canvas, Offset p, String text, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: 'monospace',
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, p);
  }

  @override
  bool shouldRepaint(covariant _WstGateTreePainter oldDelegate) =>
      oldDelegate.states != states ||
      oldDelegate.phase != phase ||
      oldDelegate.tree != tree;
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 6 - RESOLVER SHOWCASE. Four live WidgetStateProperty resolvers.
// ═══════════════════════════════════════════════════════════════════════════

class _WstResolversTab extends StatelessWidget {
  const _WstResolversTab();

  static final WidgetStateProperty<Color> _resolveWith =
      WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
    if (s.contains(WidgetState.error)) return _WstPalette.lampCrimson;
    if (s.contains(WidgetState.disabled)) return _WstPalette.rivetGlint;
    if (s.contains(WidgetState.pressed)) return _WstPalette.lampAmberDeep;
    if (s.contains(WidgetState.hovered)) return _WstPalette.lampAmber;
    if (s.contains(WidgetState.focused)) return _WstPalette.lampTeal;
    if (s.contains(WidgetState.selected)) return _WstPalette.lampGreen;
    if (s.contains(WidgetState.dragged)) return _WstPalette.lampViolet;
    if (s.contains(WidgetState.scrolledUnder)) return _WstPalette.lampBlue;
    return _WstPalette.engraveIvoryDim;
  });

  static final WidgetStateColor _stateColor =
      WidgetStateColor.fromMap(<WidgetStatesConstraint, Color>{
    WidgetState.error: _WstPalette.lampCrimson,
    WidgetState.disabled: _WstPalette.rivetGlint,
    WidgetState.pressed: _WstPalette.lampCrimsonDeep,
    WidgetState.hovered | WidgetState.focused: _WstPalette.lampAmber,
    WidgetState.selected: _WstPalette.lampGreen,
    WidgetState.any: _WstPalette.engraveIvoryDim,
  });

  static const WidgetStatePropertyAll<Color> _all =
      WidgetStatePropertyAll<Color>(_WstPalette.brassLabel);

  static final WidgetStateProperty<Color> _legacy =
      WidgetStateProperty.all<Color>(_WstPalette.lampTeal);

  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'RESOLVERS · PROPERTY TYPES',
      subtitle: 'four constructors that produce a color from the live state set',
      child: ValueListenableBuilder<Set<WidgetState>>(
        valueListenable: _wstLiveStates,
        builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
          final Color a = _resolveWith.resolve(s);
          final Color b = _stateColor.resolve(s);
          final Color c = _all.resolve(s);
          final Color d = _legacy.resolve(s);
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            _WstResolverCard(
              title: 'WidgetStateProperty.resolveWith<Color>',
              caption: 'imperative - walk the set in priority order',
              color: a,
              codeLines: <_WstCodeLine>[
                _WstCodeLine(<InlineSpan>[
                  _ty('WidgetStateProperty'),
                  _pt('.resolveWith<'),
                  _ty('Color'),
                  _pt('>(('),
                  _ty('Set'),
                  _pt('<'),
                  _ty('WidgetState'),
                  _pt('> s) {'),
                ]),
                _WstCodeLine(<InlineSpan>[
                  _tx('  '),
                  _kw('if '),
                  _pt('(s.contains('),
                  _ty('WidgetState'),
                  _pt('.error)) '),
                  _kw('return '),
                  _ty('Color'),
                  _pt('('),
                  _str('0xFFE03A2C'),
                  _pt(');'),
                ]),
                _WstCodeLine(<InlineSpan>[
                  _tx('  '),
                  _cm('// ... more priority branches ...'),
                ]),
                _WstCodeLine(<InlineSpan>[_pt('});')]),
              ],
            ),
            const SizedBox(height: 12),
            _WstResolverCard(
              title: 'WidgetStateColor.fromMap',
              caption: 'declarative - first satisfied constraint wins',
              color: b,
              codeLines: <_WstCodeLine>[
                _WstCodeLine(<InlineSpan>[
                  _ty('WidgetStateColor'),
                  _pt('.fromMap(<'),
                  _ty('WidgetStatesConstraint'),
                  _pt(', '),
                  _ty('Color'),
                  _pt('>{'),
                ]),
                _WstCodeLine(<InlineSpan>[
                  _tx('  '),
                  _ty('WidgetState'),
                  _pt('.error: '),
                  _ty('Color'),
                  _pt('('),
                  _str('0xFFE03A2C'),
                  _pt('),'),
                ]),
                _WstCodeLine(<InlineSpan>[
                  _tx('  '),
                  _ty('WidgetState'),
                  _pt('.hovered | '),
                  _ty('WidgetState'),
                  _pt('.focused: amber,'),
                ]),
                _WstCodeLine(<InlineSpan>[
                  _tx('  '),
                  _ty('WidgetStatesConstraint'),
                  _pt('.any: grey,'),
                ]),
                _WstCodeLine(<InlineSpan>[_pt('});')]),
              ],
            ),
            const SizedBox(height: 12),
            _WstResolverCard(
              title: 'WidgetStatePropertyAll<Color>',
              caption: 'constant - same value for every state set',
              color: c,
              codeLines: <_WstCodeLine>[
                _WstCodeLine(<InlineSpan>[
                  _kw('const '),
                  _ty('WidgetStatePropertyAll'),
                  _pt('<'),
                  _ty('Color'),
                  _pt('>(brass);'),
                ]),
              ],
            ),
            const SizedBox(height: 12),
            _WstResolverCard(
              title: 'WidgetStateProperty.all<Color>',
              caption: 'legacy factory - wraps a constant value at runtime',
              color: d,
              codeLines: <_WstCodeLine>[
                _WstCodeLine(<InlineSpan>[
                  _ty('WidgetStateProperty'),
                  _pt('.all<'),
                  _ty('Color'),
                  _pt('>(teal);'),
                ]),
              ],
            ),
          ]);
        },
      ),
    );
  }
}

class _WstResolverCard extends StatelessWidget {
  const _WstResolverCard({
    required this.title,
    required this.caption,
    required this.color,
    required this.codeLines,
  });
  final String title;
  final String caption;
  final Color color;
  final List<_WstCodeLine> codeLines;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: color,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _WstPalette.brassLabel, width: 1.4),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: 10,
                ),
              ],
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
                    fontFamily: 'monospace',
                    color: _WstPalette.engraveIvory,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  caption,
                  style: const TextStyle(
                    color: _WstPalette.engraveIvoryDim,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _WstPalette.brassLabelBright,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
        const SizedBox(height: 10),
        _WstCodeBlock(lines: codeLines),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 7 - MATERIAL CATALOG. Real widgets, captioned with emitted states.
// ═══════════════════════════════════════════════════════════════════════════

class _WstCatalogTab extends StatefulWidget {
  const _WstCatalogTab();
  @override
  State<_WstCatalogTab> createState() => _WstCatalogTabState();
}

class _WstCatalogTabState extends State<_WstCatalogTab> {
  bool _checkbox = false;
  bool _switch = false;
  int _radio = 0;
  double _slider = 0.4;
  final TextEditingController _text = TextEditingController(text: 'hello');
  final TextEditingController _err = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    _err.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'CATALOG · MATERIAL CONSUMERS',
      subtitle: 'eight flagship widgets and the WidgetState values they emit',
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
        _WstCatalogCard(
          title: 'ElevatedButton',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.pressed,
            WidgetState.disabled,
          ],
          child: Row(children: <Widget>[
            ElevatedButton(onPressed: () {}, child: const Text('press')),
            const SizedBox(width: 10),
            const ElevatedButton(onPressed: null, child: Text('disabled')),
          ]),
        ),
        const SizedBox(height: 12),
        _WstCatalogCard(
          title: 'FilledButton · OutlinedButton · TextButton',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.pressed,
            WidgetState.disabled,
          ],
          child: Wrap(spacing: 10, runSpacing: 10, children: <Widget>[
            FilledButton(onPressed: () {}, child: const Text('filled')),
            OutlinedButton(onPressed: () {}, child: const Text('outlined')),
            TextButton(onPressed: () {}, child: const Text('text')),
          ]),
        ),
        const SizedBox(height: 12),
        _WstCatalogCard(
          title: 'Checkbox',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.pressed,
            WidgetState.selected,
            WidgetState.disabled,
            WidgetState.error,
          ],
          child: Row(children: <Widget>[
            Checkbox(value: _checkbox, onChanged: (bool? v) => setState(() => _checkbox = v ?? false)),
            Checkbox(value: true, isError: true, onChanged: (bool? v) {}),
            const Checkbox(value: false, onChanged: null),
          ]),
        ),
        const SizedBox(height: 12),
        _WstCatalogCard(
          title: 'Switch',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.pressed,
            WidgetState.selected,
            WidgetState.disabled,
          ],
          child: Row(children: <Widget>[
            Switch(value: _switch, onChanged: (bool v) => setState(() => _switch = v)),
            const SizedBox(width: 10),
            const Switch(value: false, onChanged: null),
          ]),
        ),
        const SizedBox(height: 12),
        _WstCatalogCard(
          title: 'Radio<int>',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.pressed,
            WidgetState.selected,
            WidgetState.disabled,
          ],
          child: RadioGroup<int>(
            groupValue: _radio,
            onChanged: (int? v) => setState(() => _radio = v ?? 0),
            child: Row(children: const <Widget>[
              Radio<int>(value: 0),
              Radio<int>(value: 1),
              Radio<int>(value: 2),
            ]),
          ),
        ),
        const SizedBox(height: 12),
        _WstCatalogCard(
          title: 'FilterChip · ChoiceChip',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.pressed,
            WidgetState.selected,
            WidgetState.disabled,
          ],
          child: Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
            FilterChip(label: const Text('A'), selected: _checkbox, onSelected: (bool v) => setState(() => _checkbox = v)),
            ChoiceChip(label: const Text('B'), selected: !_checkbox, onSelected: (bool _) => setState(() => _checkbox = !_checkbox)),
            const Chip(label: Text('static')),
          ]),
        ),
        const SizedBox(height: 12),
        _WstCatalogCard(
          title: 'Slider',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.dragged,
            WidgetState.disabled,
          ],
          child: Slider(
            value: _slider,
            onChanged: (double v) => setState(() => _slider = v),
          ),
        ),
        const SizedBox(height: 12),
        _WstCatalogCard(
          title: 'TextField',
          emitted: const <WidgetState>[
            WidgetState.hovered,
            WidgetState.focused,
            WidgetState.disabled,
            WidgetState.error,
          ],
          child: Column(children: <Widget>[
            TextField(
              controller: _text,
              decoration: const InputDecoration(labelText: 'normal', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _err,
              decoration: const InputDecoration(
                labelText: 'error state',
                border: OutlineInputBorder(),
                errorText: 'required',
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _WstCatalogCard extends StatelessWidget {
  const _WstCatalogCard({
    required this.title,
    required this.emitted,
    required this.child,
  });
  final String title;
  final List<WidgetState> emitted;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: _WstPalette.lampTeal,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: _WstPalette.engraveIvory,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(children: <Widget>[
          for (final WidgetState s in emitted) _WstStateChip(state: s, active: true),
        ]),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _WstPalette.panelBlack.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _WstPalette.rivet),
          ),
          child: child,
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 8 - RECIPES. Seven code-and-preview recipe cards.
// ═══════════════════════════════════════════════════════════════════════════

class _WstRecipesTab extends StatelessWidget {
  const _WstRecipesTab();
  @override
  Widget build(BuildContext context) {
    return _WstSection(
      title: 'RECIPES · COMMON PATTERNS',
      subtitle: 'seven idioms that appear across production Flutter code',
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
        _WstRecipeCard(
          title: 'Conditional color by state',
          body: 'The canonical recipe - a WidgetStateProperty picks a color '
              'based on the most interesting state in the set.',
          accent: _WstPalette.lampAmber,
          code: <_WstCodeLine>[
            _WstCodeLine(<InlineSpan>[_kw('final '), _ty('ButtonStyle'), _tx(' style = '), _ty('ButtonStyle'), _pt('(')]),
            _WstCodeLine(<InlineSpan>[_tx('  backgroundColor: '), _ty('WidgetStateProperty'), _pt('.resolveWith(('), _ty('Set'), _pt('<'), _ty('WidgetState'), _pt('> s) {')]),
            _WstCodeLine(<InlineSpan>[_tx('    '), _kw('if '), _pt('(s.contains('), _ty('WidgetState'), _pt('.pressed)) '), _kw('return '), _tx('amberDeep;')]),
            _WstCodeLine(<InlineSpan>[_tx('    '), _kw('if '), _pt('(s.contains('), _ty('WidgetState'), _pt('.hovered)) '), _kw('return '), _tx('amber;')]),
            _WstCodeLine(<InlineSpan>[_tx('    '), _kw('return '), _tx('base;')]),
            _WstCodeLine(<InlineSpan>[_pt('  }),')]),
            _WstCodeLine(<InlineSpan>[_pt(');')]),
          ],
          preview: const _WstRecipePreviewColor(),
        ),
        const SizedBox(height: 12),
        _WstRecipeCard(
          title: 'Disabled greyscale',
          body: 'Drop chroma entirely when disabled is in the set - an '
              'accessibility-forward pattern used by Material ink.',
          accent: _WstPalette.rivetGlint,
          code: <_WstCodeLine>[
            _WstCodeLine(<InlineSpan>[_ty('WidgetStateProperty'), _pt('.resolveWith(('), _ty('Set'), _pt('<'), _ty('WidgetState'), _pt('> s) {')]),
            _WstCodeLine(<InlineSpan>[_tx('  '), _kw('if '), _pt('(s.contains('), _ty('WidgetState'), _pt('.disabled)) '), _kw('return '), _ty('Colors'), _pt('.grey;')]),
            _WstCodeLine(<InlineSpan>[_tx('  '), _kw('return '), _tx('brand;')]),
            _WstCodeLine(<InlineSpan>[_pt('});')]),
          ],
          preview: const _WstRecipePreviewDisabled(),
        ),
        const SizedBox(height: 12),
        _WstRecipeCard(
          title: 'Error shake-highlight',
          body: 'When error toggles on, paint a warning ring that other '
              'states never reach - error always wins priority.',
          accent: _WstPalette.lampCrimson,
          code: <_WstCodeLine>[
            _WstCodeLine(<InlineSpan>[_kw('final '), _ty('Color'), _tx(' border = s.contains('), _ty('WidgetState'), _pt('.error)')]),
            _WstCodeLine(<InlineSpan>[_tx('    ? '), _ty('Colors'), _pt('.red : '), _ty('Colors'), _pt('.transparent;')]),
          ],
          preview: const _WstRecipePreviewError(),
        ),
        const SizedBox(height: 12),
        _WstRecipeCard(
          title: 'Pressed scale-down',
          body: 'Tactile recipe: scale 0.97 while pressed is in the set. '
              'Triggers haptic affordance without a custom gesture.',
          accent: _WstPalette.lampViolet,
          code: <_WstCodeLine>[
            _WstCodeLine(<InlineSpan>[_ty('AnimatedScale'), _pt('(')]),
            _WstCodeLine(<InlineSpan>[_tx('  scale: s.contains('), _ty('WidgetState'), _pt('.pressed) ? '), _str('0.97'), _pt(' : '), _str('1.0'), _pt(',')]),
            _WstCodeLine(<InlineSpan>[_tx('  duration: '), _ty('Duration'), _pt('(milliseconds: '), _str('120'), _pt('),')]),
            _WstCodeLine(<InlineSpan>[_pt(');')]),
          ],
          preview: const _WstRecipePreviewScale(),
        ),
        const SizedBox(height: 12),
        _WstRecipeCard(
          title: 'Hover halo',
          body: 'Paint a soft amber halo around the child while hovered is '
              'present - simulates an aura without a tooltip.',
          accent: _WstPalette.lampAmberDeep,
          code: <_WstCodeLine>[
            _WstCodeLine(<InlineSpan>[_ty('AnimatedContainer'), _pt('(')]),
            _WstCodeLine(<InlineSpan>[_tx('  decoration: '), _ty('BoxDecoration'), _pt('(boxShadow: <'), _ty('BoxShadow'), _pt('>[')]),
            _WstCodeLine(<InlineSpan>[_tx('    '), _kw('if '), _pt('(s.contains('), _ty('WidgetState'), _pt('.hovered))')]),
            _WstCodeLine(<InlineSpan>[_tx('      '), _ty('BoxShadow'), _pt('(color: amber, blurRadius: '), _str('16'), _pt('),')]),
            _WstCodeLine(<InlineSpan>[_tx('  ]),')]),
            _WstCodeLine(<InlineSpan>[_pt(');')]),
          ],
          preview: const _WstRecipePreviewHalo(),
        ),
        const SizedBox(height: 12),
        _WstRecipeCard(
          title: 'Selected check-mark reveal',
          body: 'Toggles a subtle check-mark only while selected is live. '
              'Keeps chrome minimal in the off state.',
          accent: _WstPalette.lampGreen,
          code: <_WstCodeLine>[
            _WstCodeLine(<InlineSpan>[_ty('AnimatedOpacity'), _pt('(')]),
            _WstCodeLine(<InlineSpan>[_tx('  opacity: s.contains('), _ty('WidgetState'), _pt('.selected) ? '), _str('1'), _pt(' : '), _str('0'), _pt(',')]),
            _WstCodeLine(<InlineSpan>[_tx('  duration: '), _ty('Duration'), _pt('(milliseconds: '), _str('180'), _pt('),')]),
            _WstCodeLine(<InlineSpan>[_tx('  child: '), _ty('Icon'), _pt('('), _ty('Icons'), _pt('.check),')]),
            _WstCodeLine(<InlineSpan>[_pt(');')]),
          ],
          preview: const _WstRecipePreviewCheck(),
        ),
        const SizedBox(height: 12),
        _WstRecipeCard(
          title: 'Dragged cursor cue',
          body: 'Swap the mouse cursor while dragged is in the set so the '
              'gesture has affordance across the whole widget tree.',
          accent: _WstPalette.lampViolet,
          code: <_WstCodeLine>[
            _WstCodeLine(<InlineSpan>[_ty('WidgetStateMouseCursor'), _pt('.clickable; '), _cm('// resolves grab while dragged')]),
          ],
          preview: const _WstRecipePreviewCursor(),
        ),
      ]),
    );
  }
}

class _WstRecipeCard extends StatelessWidget {
  const _WstRecipeCard({
    required this.title,
    required this.body,
    required this.accent,
    required this.code,
    required this.preview,
  });
  final String title;
  final String body;
  final Color accent;
  final List<_WstCodeLine> code;
  final Widget preview;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: accent,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints bc) {
        final bool wide = bc.maxWidth > 640;
        final Widget meta = Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _WstPalette.engraveIvory,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: _WstPalette.engraveIvoryDim,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          _WstCodeBlock(lines: code),
        ]);
        if (wide) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(flex: 3, child: meta),
            const SizedBox(width: 14),
            SizedBox(width: 170, child: preview),
          ]);
        }
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          meta,
          const SizedBox(height: 10),
          preview,
        ]);
      }),
    );
  }
}

class _WstRecipePreviewColor extends StatelessWidget {
  const _WstRecipePreviewColor();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wstLiveStates,
      builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
        Color c = _WstPalette.engraveIvoryDim;
        if (s.contains(WidgetState.pressed)) {
          c = _WstPalette.lampAmberDeep;
        } else if (s.contains(WidgetState.hovered)) {
          c = _WstPalette.lampAmber;
        } else if (s.contains(WidgetState.focused)) {
          c = _WstPalette.lampTeal;
        }
        return _WstPreviewBox(color: c, label: _wstSetRepr(s));
      },
    );
  }
}

class _WstRecipePreviewDisabled extends StatelessWidget {
  const _WstRecipePreviewDisabled();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wstLiveStates,
      builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
        final Color c = s.contains(WidgetState.disabled)
            ? _WstPalette.rivetGlint
            : _WstPalette.lampAmber;
        return _WstPreviewBox(color: c, label: s.contains(WidgetState.disabled) ? 'disabled' : 'enabled');
      },
    );
  }
}

class _WstRecipePreviewError extends StatelessWidget {
  const _WstRecipePreviewError();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wstLiveStates,
      builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
        final bool err = s.contains(WidgetState.error);
        return Container(
          height: 90,
          decoration: BoxDecoration(
            color: _WstPalette.panelBlack,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: err ? _WstPalette.lampCrimson : _WstPalette.rivet,
              width: err ? 3 : 1,
            ),
            boxShadow: <BoxShadow>[
              if (err) BoxShadow(color: _WstPalette.lampCrimson.withValues(alpha: 0.5), blurRadius: 16),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            err ? 'ERROR!' : 'OK',
            style: TextStyle(
              fontFamily: 'monospace',
              color: err ? _WstPalette.lampCrimson : _WstPalette.lampGreen,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
            ),
          ),
        );
      },
    );
  }
}

class _WstRecipePreviewScale extends StatelessWidget {
  const _WstRecipePreviewScale();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wstLiveStates,
      builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
        final bool pressed = s.contains(WidgetState.pressed);
        return SizedBox(
          height: 90,
          child: Center(
            child: AnimatedScale(
              scale: pressed ? 0.92 : 1.0,
              duration: const Duration(milliseconds: 180),
              child: Container(
                width: 110,
                height: 50,
                decoration: BoxDecoration(
                  color: pressed ? _WstPalette.lampCrimson : _WstPalette.lampViolet,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  pressed ? 'PRESSED' : 'IDLE',
                  style: TextStyle(
                    color: _WstPalette.engraveIvory,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WstRecipePreviewHalo extends StatelessWidget {
  const _WstRecipePreviewHalo();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wstLiveStates,
      builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
        final bool hov = s.contains(WidgetState.hovered);
        return Container(
          height: 90,
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            width: 110,
            height: 50,
            decoration: BoxDecoration(
              color: _WstPalette.panelSteelLight,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                if (hov) BoxShadow(color: _WstPalette.lampAmber.withValues(alpha: 0.75), blurRadius: 22, spreadRadius: 2),
              ],
              border: Border.all(color: hov ? _WstPalette.lampAmber : _WstPalette.rivet),
            ),
            alignment: Alignment.center,
            child: Text(
              hov ? 'HOVERED' : 'idle',
              style: TextStyle(
                color: hov ? _WstPalette.lampAmber : _WstPalette.engraveIvoryDim,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WstRecipePreviewCheck extends StatelessWidget {
  const _WstRecipePreviewCheck();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wstLiveStates,
      builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
        final bool sel = s.contains(WidgetState.selected);
        return Container(
          height: 90,
          alignment: Alignment.center,
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: sel ? _WstPalette.lampGreen.withValues(alpha: 0.22) : _WstPalette.panelSteelLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: sel ? _WstPalette.lampGreen : _WstPalette.rivet),
              ),
              child: AnimatedOpacity(
                opacity: sel ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 220),
                child: const Icon(Icons.check, color: _WstPalette.lampGreen),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              sel ? 'SELECTED' : 'unselected',
              style: TextStyle(
                fontFamily: 'monospace',
                color: sel ? _WstPalette.lampGreen : _WstPalette.engraveIvoryDim,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        );
      },
    );
  }
}

class _WstRecipePreviewCursor extends StatelessWidget {
  const _WstRecipePreviewCursor();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<WidgetState>>(
      valueListenable: _wstLiveStates,
      builder: (BuildContext context, Set<WidgetState> s, Widget? _) {
        final bool drag = s.contains(WidgetState.dragged);
        return Container(
          height: 90,
          decoration: BoxDecoration(
            color: _WstPalette.panelBlack,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: drag ? _WstPalette.lampViolet : _WstPalette.rivet),
          ),
          alignment: Alignment.center,
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Icon(drag ? Icons.open_with : Icons.mouse_outlined, color: drag ? _WstPalette.lampViolet : _WstPalette.engraveIvoryDim),
            const SizedBox(width: 8),
            Text(
              drag ? 'grab' : 'default',
              style: TextStyle(
                fontFamily: 'monospace',
                color: drag ? _WstPalette.lampViolet : _WstPalette.engraveIvoryDim,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        );
      },
    );
  }
}

class _WstPreviewBox extends StatelessWidget {
  const _WstPreviewBox({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _WstPalette.brassLabel, width: 1.2),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          color: _WstPalette.panelBlack,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 9 - COMPARISON. Four-row table against alternative state models.
// ═══════════════════════════════════════════════════════════════════════════

class _WstComparisonTab extends StatelessWidget {
  const _WstComparisonTab();
  @override
  Widget build(BuildContext context) {
    const List<_WstComparisonRow> rows = <_WstComparisonRow>[
      _WstComparisonRow(
        name: 'WidgetState',
        typeRepr: 'enum WidgetState',
        strengths: 'Typed · composable via & | ~ · resolver-ready · '
            'canonical across Material',
        weaknesses: 'Requires Flutter 3.19+, a small set (8 values) '
            'closed by design',
        verdict: 'RECOMMENDED',
        verdictColor: _WstPalette.lampGreen,
      ),
      _WstComparisonRow(
        name: 'MaterialState (deprecated)',
        typeRepr: 'enum MaterialState',
        strengths: 'Shipped in Flutter since 1.9 · widely documented',
        weaknesses: 'Soft-deprecated in 3.19 · typedef alias to WidgetState · '
            'expected to be removed in a future stable',
        verdict: 'LEGACY',
        verdictColor: _WstPalette.lampAmber,
      ),
      _WstComparisonRow(
        name: 'bool-gated ad-hoc',
        typeRepr: 'bool hover, focus, pressed;',
        strengths: 'Trivially simple for a single widget · no imports',
        weaknesses: 'No composition · no shared vocabulary · explodes on '
            'state count · theming integration is impossible',
        verdict: 'AVOID',
        verdictColor: _WstPalette.lampCrimson,
      ),
      _WstComparisonRow(
        name: 'Set<String> sentinels',
        typeRepr: "Set<String> = {'hover', 'disabled'};",
        strengths: 'Extensible at runtime · no compile-time enum edits',
        weaknesses: 'No static checking · typos are silent · no resolver '
            'protocol · does not implement WidgetStatesConstraint',
        verdict: 'ANTI-PATTERN',
        verdictColor: _WstPalette.lampMagenta,
      ),
    ];
    return _WstSection(
      title: 'COMPARISON · STATE MODELS',
      subtitle: 'why WidgetState won the interactive-state design space',
      child: Column(children: <Widget>[
        for (final _WstComparisonRow r in rows) ...<Widget>[
          _WstComparisonCard(row: r),
          const SizedBox(height: 12),
        ],
      ]),
    );
  }
}

class _WstComparisonRow {
  const _WstComparisonRow({
    required this.name,
    required this.typeRepr,
    required this.strengths,
    required this.weaknesses,
    required this.verdict,
    required this.verdictColor,
  });
  final String name;
  final String typeRepr;
  final String strengths;
  final String weaknesses;
  final String verdict;
  final Color verdictColor;
}

class _WstComparisonCard extends StatelessWidget {
  const _WstComparisonCard({required this.row});
  final _WstComparisonRow row;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: row.verdictColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Text(
              row.name,
              style: const TextStyle(
                color: _WstPalette.engraveIvory,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: row.verdictColor.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: row.verdictColor),
            ),
            child: Text(
              row.verdict,
              style: TextStyle(
                fontFamily: 'monospace',
                color: row.verdictColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                fontSize: 11,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 6),
        _WstCodeBlock(lines: <_WstCodeLine>[
          _WstCodeLine(<InlineSpan>[_tx(row.typeRepr)]),
        ]),
        const SizedBox(height: 10),
        _WstComparisonBullet(icon: Icons.check_circle_outline, color: _WstPalette.lampGreen, label: 'Strengths', body: row.strengths),
        const SizedBox(height: 6),
        _WstComparisonBullet(icon: Icons.report_problem_outlined, color: _WstPalette.lampCrimson, label: 'Weaknesses', body: row.weaknesses),
      ]),
    );
  }
}

class _WstComparisonBullet extends StatelessWidget {
  const _WstComparisonBullet({
    required this.icon,
    required this.color,
    required this.label,
    required this.body,
  });
  final IconData icon;
  final Color color;
  final String label;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 8),
      SizedBox(
        width: 88,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
      ),
      Expanded(
        child: Text(
          body,
          style: const TextStyle(
            color: _WstPalette.engraveIvoryDim,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Section 10 - GLOSSARY. Ten-plus entries.
// ═══════════════════════════════════════════════════════════════════════════

class _WstGlossaryTab extends StatelessWidget {
  const _WstGlossaryTab();
  @override
  Widget build(BuildContext context) {
    const List<_WstGlossaryEntry> entries = <_WstGlossaryEntry>[
      _WstGlossaryEntry(
        term: 'WidgetState',
        pronunciation: '/ˈwɪdʒɪt steɪt/',
        body: 'The eight-valued enum in package:flutter/widgets.dart - the '
            'canonical vocabulary for interactive state across the Material '
            'catalog. Implements WidgetStatesConstraint so any value is also '
            'a constraint.',
      ),
      _WstGlossaryEntry(
        term: 'WidgetStatesConstraint',
        pronunciation: '/kənˈstreɪnt/',
        body: 'Abstract interface describing any predicate over a '
            'Set<WidgetState>. Exposes isSatisfiedBy(Set<WidgetState>) -> '
            'bool, plus & | ~ operators that return new constraint objects.',
      ),
      _WstGlossaryEntry(
        term: 'WidgetStateProperty<T>',
        pronunciation: '/ˈprɒpəti/',
        body: 'A single-method protocol: T resolve(Set<WidgetState>). Every '
            'Material widget accepts these instead of plain T to support '
            'state-sensitive theming.',
      ),
      _WstGlossaryEntry(
        term: 'WidgetStateMap<T>',
        pronunciation: '/mæp/',
        body: 'Typedef for Map<WidgetStatesConstraint, T>. Passed to '
            'WidgetStateProperty.fromMap to construct a declarative '
            'state-driven property - first satisfied key wins.',
      ),
      _WstGlossaryEntry(
        term: 'WidgetStateMapper<T>',
        pronunciation: '/ˈmæpə/',
        body: 'The engine that walks a WidgetStateMap top-to-bottom, '
            'applying each constraint to the current state set. Underpins '
            'WidgetStateProperty.fromMap and WidgetStateColor.fromMap.',
      ),
      _WstGlossaryEntry(
        term: 'WidgetStateColor',
        pronunciation: '/ˈkʌlə/',
        body: 'Abstract subclass of Color that also implements '
            'WidgetStateProperty<Color>. Allows an API field typed Color to '
            'accept a live resolver without loosening the signature.',
      ),
      _WstGlossaryEntry(
        term: 'resolve()',
        pronunciation: '/rɪˈzɒlv/',
        body: 'The protocol method T WidgetStateProperty<T>.resolve('
            'Set<WidgetState>). Invoked by Material widgets once per '
            'interactive frame to compute the current visual value.',
      ),
      _WstGlossaryEntry(
        term: '& | ~ operators',
        pronunciation: '/ˈɒpəreɪtəz/',
        body: 'Operators on WidgetStatesConstraint. & is logical AND; | is '
            'logical OR; ~ is logical NOT. Returned objects are themselves '
            'constraints and can be nested arbitrarily.',
      ),
      _WstGlossaryEntry(
        term: 'WidgetState.any',
        pronunciation: '/ˈɛni/',
        body: 'Sentinel WidgetStatesConstraint whose isSatisfiedBy always '
            'returns true. Idiomatic catch-all at the bottom of a '
            'WidgetStateMap or a resolver.',
      ),
      _WstGlossaryEntry(
        term: 'MaterialState (deprecated)',
        pronunciation: '/məˈtɪərɪəl/',
        body: 'The Flutter 1.9+ predecessor of WidgetState. As of Flutter '
            '3.19 MaterialState is a deprecated typedef that aliases '
            'WidgetState. New code should prefer WidgetState directly.',
      ),
      _WstGlossaryEntry(
        term: 'Set<WidgetState>',
        pronunciation: '/sɛt/',
        body: 'The frame-local snapshot passed into every resolver. A '
            'widget accumulates its current states and passes the set down '
            'to WidgetStateProperty.resolve on every build.',
      ),
      _WstGlossaryEntry(
        term: 'WidgetStatePropertyAll<T>',
        pronunciation: '/ɔːl/',
        body: 'Const constructor for a resolver that returns the same T for '
            'every possible Set<WidgetState>. Preferred over the legacy '
            'WidgetStateProperty.all factory.',
      ),
    ];
    return _WstSection(
      title: 'GLOSSARY · LEXICON',
      subtitle: 'twelve terms you need before the flight deck debrief',
      child: Column(children: <Widget>[
        for (final _WstGlossaryEntry e in entries) ...<Widget>[
          _WstGlossaryCard(entry: e),
          const SizedBox(height: 10),
        ],
      ]),
    );
  }
}

class _WstGlossaryEntry {
  const _WstGlossaryEntry({
    required this.term,
    required this.pronunciation,
    required this.body,
  });
  final String term;
  final String pronunciation;
  final String body;
}

class _WstGlossaryCard extends StatelessWidget {
  const _WstGlossaryCard({required this.entry});
  final _WstGlossaryEntry entry;
  @override
  Widget build(BuildContext context) {
    return _WstPanel(
      accent: _WstPalette.brassLabel,
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          Text(
            entry.term,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _WstPalette.engraveIvory,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            entry.pronunciation,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _WstPalette.brassLabelBright,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Container(
          height: 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              _WstPalette.brassLabel,
              Colors.transparent,
            ]),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          entry.body,
          style: const TextStyle(
            color: _WstPalette.engraveIvoryDim,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ]),
    );
  }
}

