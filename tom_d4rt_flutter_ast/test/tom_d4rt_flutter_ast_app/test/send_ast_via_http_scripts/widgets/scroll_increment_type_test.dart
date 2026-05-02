// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// ScrollIncrementType — Line vs Page (live enum demo)
// ---------------------------------------------------------------------------
// This demo binds the `ScrollIncrementType` enum (values `line` and `page`) to
// real, compiled Dart logic. The enum drives:
//   * switch arms inside calculators
//   * construction of `ScrollIncrementDetails` per controller jump
//   * comparison-based UI styling (==)
//   * iteration via `ScrollIncrementType.values`
//   * `ScrollIncrementCalculator` callbacks of the typedef shape
//       double Function(ScrollIncrementDetails)
//
// Flutter defaults: `line` ≈ 50 logical px, `page` ≈ 80% of viewport.
// ---------------------------------------------------------------------------

const Color kCobalt = Color(0xFF1B3A9B);
const Color kLemon = Color(0xFFF6E05E);
const Color kCream = Color(0xFFFEF8EC);
const Color kInk = Color(0xFF1A1A2E);
const Color kLineColor = Color(0xFF2A6DF4);
const Color kPageColor = Color(0xFFEA7A2C);
const Color kMuted = Color(0xFF5C5C70);

// ---------------------------------------------------------------------------
// Helpers that consume `ScrollIncrementType` live.
// ---------------------------------------------------------------------------

Color colorForType(ScrollIncrementType type) {
  switch (type) {
    case ScrollIncrementType.line:
      return kLineColor;
    case ScrollIncrementType.page:
      return kPageColor;
  }
}

String labelForType(ScrollIncrementType type) {
  switch (type) {
    case ScrollIncrementType.line:
      return 'line';
    case ScrollIncrementType.page:
      return 'page';
  }
}

String tagFor(ScrollIncrementType type) => 'ScrollIncrementType.${type.name}';

IconData iconForType(ScrollIncrementType type) {
  switch (type) {
    case ScrollIncrementType.line:
      return Icons.short_text;
    case ScrollIncrementType.page:
      return Icons.menu_book_outlined;
  }
}

String defaultPxDescription(ScrollIncrementType type) {
  switch (type) {
    case ScrollIncrementType.line:
      return '~50 logical pixels';
    case ScrollIncrementType.page:
      return '~80% of viewport dimension';
  }
}

String bindingFor(ScrollIncrementType type) {
  switch (type) {
    case ScrollIncrementType.line:
      return 'ArrowUp / ArrowDown / ArrowLeft / ArrowRight';
    case ScrollIncrementType.page:
      return 'PageUp / PageDown (and Space in web reading)';
  }
}

// A real `ScrollIncrementCalculator` (typedef:
// `double Function(ScrollIncrementDetails details)`).
double defaultCalculator(ScrollIncrementDetails details) {
  switch (details.type) {
    case ScrollIncrementType.line:
      return 50.0;
    case ScrollIncrementType.page:
      return details.metrics.viewportDimension * 0.8;
  }
}

double compactCalculator(ScrollIncrementDetails details) {
  switch (details.type) {
    case ScrollIncrementType.line:
      return 24.0;
    case ScrollIncrementType.page:
      return details.metrics.viewportDimension * 0.5;
  }
}

double spaciousCalculator(ScrollIncrementDetails details) {
  switch (details.type) {
    case ScrollIncrementType.line:
      return 96.0;
    case ScrollIncrementType.page:
      return details.metrics.viewportDimension * 1.0;
  }
}

// Holder for a calculator + its name, so widgets can render which one is
// active without losing access to the live function.
class CalcProfile {
  const CalcProfile(this.name, this.calc, this.description);
  final String name;
  final ScrollIncrementCalculator calc;
  final String description;
}

const List<CalcProfile> kProfiles = <CalcProfile>[
  CalcProfile('compact', compactCalculator,
      'Tight 24 px lines and half-viewport pages.'),
  CalcProfile('standard', defaultCalculator,
      'Flutter defaults: 50 px lines and 80% viewport pages.'),
  CalcProfile('spacious', spaciousCalculator,
      'Generous 96 px lines and full-viewport pages.'),
];

// ---------------------------------------------------------------------------
// Top-level build — d4rt AST harness entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollIncrementType Catalog',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kCobalt,
        primary: kCobalt,
        secondary: kLemon,
        surface: kCream,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w800,
          fontSize: 26,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.45,
        ),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: kCobalt,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ScrollIncrementType — Line vs Page',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.2),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'enum · 2 values',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 48),
          child: _CatalogColumn(),
        ),
      ),
    ),
  );
}

class _CatalogColumn extends StatelessWidget {
  const _CatalogColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeroHeader(),
        SizedBox(height: 28),
        _LiveScrollersSection(),
        SizedBox(height: 28),
        _CalculatorLab(),
        SizedBox(height: 28),
        _PixelDeltaSection(),
        SizedBox(height: 28),
        _KeyMappingSection(),
        SizedBox(height: 28),
        _EnumValueCards(),
        SizedBox(height: 28),
        _ComparatorStrip(),
        SizedBox(height: 28),
        _SwitchTutorial(),
        SizedBox(height: 28),
        _TeachingPanel(),
        SizedBox(height: 28),
        _UseCasesStrip(),
        SizedBox(height: 28),
        _FooterSummary(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Hero header
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isDesktop = platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux ||
        platform == TargetPlatform.windows;
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kCobalt, kCobalt.withValues(alpha: 0.88)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: kCobalt.withValues(alpha: 0.25),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _heroPill(kLemon, 'Flutter · widgets', kInk),
              const SizedBox(width: 12),
              _heroPill(
                Colors.white.withValues(alpha: 0.18),
                'enum ScrollIncrementType { line, page }',
                Colors.white,
                mono: true,
              ),
              const SizedBox(width: 12),
              _heroPill(
                Colors.white.withValues(alpha: 0.12),
                isDesktop ? 'desktop keys live' : 'mobile · button-driven',
                Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'ScrollIncrementType — Line vs Page',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A `ScrollIntent` carries a `ScrollIncrementType`, and a '
            '`ScrollIncrementCalculator` reads it from `ScrollIncrementDetails` '
            'to decide how far to scroll. This catalog wires the enum to live '
            'controllers, switch statements, and equality checks.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              for (final t in ScrollIncrementType.values) ...[
                Expanded(child: _enumChip(t)),
                if (t != ScrollIncrementType.values.last)
                  const SizedBox(width: 12),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroPill(Color bg, String text, Color fg, {bool mono = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 0.3,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );
  }

  Widget _enumChip(ScrollIncrementType t) {
    final c = colorForType(t);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: c.withValues(alpha: 0.6), width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(iconForType(t), color: c, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tagFor(t),
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  defaultPxDescription(t),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
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
// Live scrollers — both controllers driven by `ScrollIncrementCalculator`s
// receiving real `ScrollIncrementDetails` whose `.type` is the enum value.
// ---------------------------------------------------------------------------

class _LiveScrollersSection extends StatefulWidget {
  const _LiveScrollersSection();

  @override
  State<_LiveScrollersSection> createState() => _LiveScrollersSectionState();
}

class _LiveScrollersSectionState extends State<_LiveScrollersSection> {
  final ScrollController _ctrlA = ScrollController();
  final ScrollController _ctrlB = ScrollController();
  ScrollIncrementType _lastType = ScrollIncrementType.line;
  double _lastDelta = 0;
  String _lastSide = 'idle';

  @override
  void dispose() {
    _ctrlA.dispose();
    _ctrlB.dispose();
    super.dispose();
  }

  // Construct a real `ScrollIncrementDetails` from a controller's metrics
  // and the chosen enum value, then run it through the default calculator.
  double _runIncrement(
    ScrollController c,
    ScrollIncrementType type,
    double dir,
    String side,
  ) {
    if (!c.hasClients) return 0;
    final details = ScrollIncrementDetails(type: type, metrics: c.position);
    final amount = defaultCalculator(details);
    final target =
        (c.offset + dir * amount).clamp(0.0, c.position.maxScrollExtent);
    final delta = (target - c.offset).abs();
    c.animateTo(
      target,
      duration: Duration(
        milliseconds: type == ScrollIncrementType.line ? 180 : 260,
      ),
      curve: Curves.easeOutCubic,
    );
    setState(() {
      _lastType = type;
      _lastDelta = delta;
      _lastSide = side;
    });
    print('[live] side=$side type=${type.name} delta=${delta.toStringAsFixed(1)}');
    return delta;
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§1  Live scrollers',
      subtitle:
          'Each list view gets its own controller. The buttons below '
          'construct a real ScrollIncrementDetails and feed it through '
          'defaultCalculator(...) — a true ScrollIncrementCalculator.',
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ScrollerCard(
                  type: ScrollIncrementType.line,
                  controller: _ctrlA,
                  count: 40,
                  onJump: (dir) => _runIncrement(
                    _ctrlA,
                    ScrollIncrementType.line,
                    dir,
                    'left',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ScrollerCard(
                  type: ScrollIncrementType.page,
                  controller: _ctrlB,
                  count: 40,
                  onJump: (dir) => _runIncrement(
                    _ctrlB,
                    ScrollIncrementType.page,
                    dir,
                    'right',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _LastJumpBanner(
            type: _lastType,
            delta: _lastDelta,
            side: _lastSide,
          ),
        ],
      ),
    );
  }
}

class _ScrollerCard extends StatelessWidget {
  const _ScrollerCard({
    required this.type,
    required this.controller,
    required this.count,
    required this.onJump,
  });

  final ScrollIncrementType type;
  final ScrollController controller;
  final int count;
  final ValueChanged<double> onJump;

  @override
  Widget build(BuildContext context) {
    final accent = colorForType(type);
    final title = switch (type) {
      ScrollIncrementType.line => 'Arrow keys → line increments',
      ScrollIncrementType.page => 'Page keys → page increments',
    };
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(iconForType(type), color: accent, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  tagFor(type),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    fontSize: 10.5,
                    color: kMuted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 240,
            child: ListView.builder(
              controller: controller,
              padding: const EdgeInsets.symmetric(vertical: 6),
              itemCount: count,
              itemBuilder: (context, i) {
                return Container(
                  height: 44,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: i.isEven ? kCream : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: accent,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Tile #${i + 1} · ${labelForType(type)} demo row',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kInk,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: _TriggerButton(
                    label: 'up',
                    icon: Icons.arrow_upward,
                    color: accent,
                    onTap: () => onJump(-1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TriggerButton(
                    label: 'down',
                    icon: Icons.arrow_downward,
                    color: accent,
                    onTap: () => onJump(1),
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

class _TriggerButton extends StatelessWidget {
  const _TriggerButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LastJumpBanner extends StatelessWidget {
  const _LastJumpBanner({
    required this.type,
    required this.delta,
    required this.side,
  });

  final ScrollIncrementType type;
  final double delta;
  final String side;

  @override
  Widget build(BuildContext context) {
    final color = colorForType(type);
    final label = switch (type) {
      ScrollIncrementType.line => 'line → fine nudge',
      ScrollIncrementType.page => 'page → big leap',
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.bolt, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            'last jump · ',
            style: TextStyle(color: kMuted, fontWeight: FontWeight.w600),
          ),
          Text(
            tagFor(type),
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '($side · $label)',
            style: const TextStyle(color: kInk, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            '${delta.toStringAsFixed(1)} px',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Calculator lab — pick a profile, see what the calculator returns for
// each enum value when given a real ScrollIncrementDetails.
// ---------------------------------------------------------------------------

class _CalculatorLab extends StatefulWidget {
  const _CalculatorLab();

  @override
  State<_CalculatorLab> createState() => _CalculatorLabState();
}

class _CalculatorLabState extends State<_CalculatorLab> {
  final ScrollController _labCtrl = ScrollController();
  CalcProfile _profile = kProfiles[1];
  ScrollIncrementType _focused = ScrollIncrementType.line;
  String _log = 'Pick a profile and fire an increment.';

  @override
  void dispose() {
    _labCtrl.dispose();
    super.dispose();
  }

  void _fire(ScrollIncrementType type, double dir) {
    if (!_labCtrl.hasClients) return;
    final details =
        ScrollIncrementDetails(type: type, metrics: _labCtrl.position);
    final amount = _profile.calc(details);
    final target = (_labCtrl.offset + dir * amount)
        .clamp(0.0, _labCtrl.position.maxScrollExtent);
    final delta = (target - _labCtrl.offset).abs();
    _labCtrl.animateTo(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
    setState(() {
      _focused = type;
      _log = '${_profile.name}(${tagFor(type)}) → '
          '${amount.toStringAsFixed(1)} px (delta ${delta.toStringAsFixed(1)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§2  Calculator lab',
      subtitle:
          'Three real ScrollIncrementCalculator implementations branch on '
          'details.type. Pick one and fire either enum value into a live '
          'controller; the readout shows the value the switch arm returned.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final p in kProfiles) ...[
                Expanded(
                  child: _ProfileChip(
                    profile: p,
                    selected: identical(p, _profile),
                    onTap: () => setState(() => _profile = p),
                  ),
                ),
                if (p != kProfiles.last) const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 16),
          _PreviewMatrix(profile: _profile, focused: _focused),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kCobalt.withValues(alpha: 0.18)),
            ),
            child: ListView.builder(
              controller: _labCtrl,
              padding: const EdgeInsets.all(8),
              itemCount: 60,
              itemBuilder: (context, i) {
                final isHeader = i % 8 == 0;
                return Container(
                  height: 38,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: isHeader
                        ? kLemon.withValues(alpha: 0.5)
                        : kCream,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: kCobalt.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Text(
                    isHeader
                        ? 'Section ${(i ~/ 8) + 1}'
                        : 'Row ${i + 1} content',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kInk,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final t in ScrollIncrementType.values) ...[
                Expanded(
                  child: _TriggerButton(
                    label: '${labelForType(t)} ▲',
                    icon: Icons.keyboard_arrow_up,
                    color: colorForType(t),
                    onTap: () => _fire(t, -1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TriggerButton(
                    label: '${labelForType(t)} ▼',
                    icon: Icons.keyboard_arrow_down,
                    color: colorForType(t),
                    onTap: () => _fire(t, 1),
                  ),
                ),
                if (t != ScrollIncrementType.values.last)
                  const SizedBox(width: 12),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.terminal, color: kLemon, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _log,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
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

class _ProfileChip extends StatelessWidget {
  const _ProfileChip({
    required this.profile,
    required this.selected,
    required this.onTap,
  });

  final CalcProfile profile;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? kCobalt : kCobalt.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? kCobalt : kCobalt.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.name,
              style: TextStyle(
                color: selected ? Colors.white : kCobalt,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              profile.description,
              style: TextStyle(
                color: selected
                    ? Colors.white.withValues(alpha: 0.85)
                    : kMuted,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Build a fake ScrollMetrics-bearing details by reusing a real position when
// available; fall back to a synthesized FixedScrollMetrics for preview math.
class _PreviewMatrix extends StatelessWidget {
  const _PreviewMatrix({required this.profile, required this.focused});

  final CalcProfile profile;
  final ScrollIncrementType focused;

  @override
  Widget build(BuildContext context) {
    final metrics = FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 4000,
      pixels: 0,
      viewportDimension: 600,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 1.0,
    );
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kCobalt.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calculate_outlined,
                  color: kCobalt, size: 18),
              const SizedBox(width: 8),
              Text(
                '${profile.name}(details) preview · viewport=600',
                style: const TextStyle(
                  color: kCobalt,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final t in ScrollIncrementType.values)
            _previewRow(t, metrics),
        ],
      ),
    );
  }

  Widget _previewRow(ScrollIncrementType t, ScrollMetrics m) {
    final details = ScrollIncrementDetails(type: t, metrics: m);
    final value = profile.calc(details);
    final color = colorForType(t);
    final isFocused = t == focused;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isFocused ? 0.25 : 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: color.withValues(alpha: isFocused ? 0.7 : 0.3),
                width: isFocused ? 1.5 : 1,
              ),
            ),
            child: Text(
              tagFor(t),
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final ratio = (value / 600.0).clamp(0.0, 1.0);
                return Stack(
                  children: [
                    Container(
                      height: 18,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      height: 18,
                      width: constraints.maxWidth * ratio,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 64,
            child: Text(
              '${value.toStringAsFixed(1)} px',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pixel delta section — visualizes typical line vs page deltas.
// ---------------------------------------------------------------------------

class _PixelDeltaSection extends StatelessWidget {
  const _PixelDeltaSection();

  @override
  Widget build(BuildContext context) {
    final metrics = FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 5000,
      pixels: 0,
      viewportDimension: 720,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 1.0,
    );
    return _SectionShell(
      title: '§3  Pixel-delta overlay',
      subtitle:
          'Compares what every profile returns for both enum values, side by '
          'side. The bars are drawn at the same scale (max = 720 px viewport).',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final p in kProfiles)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ProfileBars(profile: p, metrics: metrics, axisMax: 720),
            ),
        ],
      ),
    );
  }
}

class _ProfileBars extends StatelessWidget {
  const _ProfileBars({
    required this.profile,
    required this.metrics,
    required this.axisMax,
  });

  final CalcProfile profile;
  final ScrollMetrics metrics;
  final double axisMax;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kCobalt.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'profile: ${profile.name}',
            style: const TextStyle(
              color: kCobalt,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8),
          for (final t in ScrollIncrementType.values)
            _bar(t, profile.calc(
              ScrollIncrementDetails(type: t, metrics: metrics),
            )),
        ],
      ),
    );
  }

  Widget _bar(ScrollIncrementType t, double value) {
    final color = colorForType(t);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(
              labelForType(t),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, c) {
                final ratio = (value / axisMax).clamp(0.0, 1.0);
                return Stack(
                  children: [
                    Container(
                      height: 16,
                      width: c.maxWidth,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      height: 16,
                      width: c.maxWidth * ratio,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          color,
                          color.withValues(alpha: 0.55),
                        ]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              '${value.toStringAsFixed(0)} px',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
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

// ---------------------------------------------------------------------------
// Key mapping — each row carries an enum value (or null) and uses
// equality / switch to color and label itself.
// ---------------------------------------------------------------------------

class _KeyMappingSection extends StatelessWidget {
  const _KeyMappingSection();

  @override
  Widget build(BuildContext context) {
    final rows = <_MapRow>[
      const _MapRow('ArrowUp / ArrowDown', ScrollIncrementType.line,
          'Default vertical line increment.'),
      const _MapRow('ArrowLeft / ArrowRight', ScrollIncrementType.line,
          'Horizontal line increment for horizontal scrollables.'),
      const _MapRow('PageUp / PageDown', ScrollIncrementType.page,
          'Full viewport jump — fast vertical navigation.'),
      const _MapRow('Space (web reading)', ScrollIncrementType.page,
          'Page-style scroll when the focused widget ignores Space.'),
      const _MapRow('Home / End', null,
          'Jumps to extremes — not carried by ScrollIncrementType.'),
    ];
    return _SectionShell(
      title: '§4  Key → enum mapping',
      subtitle:
          'Built-in shortcuts dispatch ScrollIntents carrying a '
          'ScrollIncrementType. Rows with no type fall outside the enum.',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: kCobalt.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text('Key(s)',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: kCobalt,
                      )),
                ),
                SizedBox(
                  width: 110,
                  child: Text('Enum value',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: kCobalt,
                      )),
                ),
                Expanded(
                  child: Text('Note',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: kCobalt,
                      )),
                ),
              ],
            ),
          ),
          for (final r in rows) r,
        ],
      ),
    );
  }
}

class _MapRow extends StatelessWidget {
  const _MapRow(this.keys, this.type, this.note);

  final String keys;
  final ScrollIncrementType? type;
  final String note;

  @override
  Widget build(BuildContext context) {
    final color = type == null ? kMuted : colorForType(type!);
    final label = type == null ? '—' : tagFor(type!);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kCobalt.withValues(alpha: 0.08))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              keys,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: kInk,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                color: kMuted,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Enum value cards — generated by iterating ScrollIncrementType.values.
// ---------------------------------------------------------------------------

class _EnumValueCards extends StatelessWidget {
  const _EnumValueCards();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§5  Enum values',
      subtitle:
          'One card per ScrollIncrementType.values entry. Everything on the '
          'card — color, defaults, binding — is derived via switch on the '
          'enum value at build time.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final t in ScrollIncrementType.values) ...[
            Expanded(child: _ValueCard(type: t)),
            if (t != ScrollIncrementType.values.last)
              const SizedBox(width: 16),
          ],
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({required this.type});

  final ScrollIncrementType type;

  @override
  Widget build(BuildContext context) {
    final color = colorForType(type);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              tagFor(type),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            labelForType(type),
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.6,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'default · ${defaultPxDescription(type)}',
            style: const TextStyle(
              color: kMuted,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            switch (type) {
              ScrollIncrementType.line =>
                'Precise, one-step nudges for reading list rows, grid cells, '
                    'form fields — anywhere the user wants fine control over '
                    'position.',
              ScrollIncrementType.page =>
                'Broad leaps through long content — documents, logs, '
                    'timelines. Matches desktop-OS expectations of '
                    '"page down".'
            },
            style: const TextStyle(
              color: kInk,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard, size: 14, color: color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    bindingFor(type),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      fontSize: 11,
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

// ---------------------------------------------------------------------------
// Comparator strip — equality checks between the user's selection and the
// values of ScrollIncrementType. All branding is derived live from the enum.
// ---------------------------------------------------------------------------

class _ComparatorStrip extends StatefulWidget {
  const _ComparatorStrip();

  @override
  State<_ComparatorStrip> createState() => _ComparatorStripState();
}

class _ComparatorStripState extends State<_ComparatorStrip> {
  ScrollIncrementType _selected = ScrollIncrementType.line;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§6  Comparator strip',
      subtitle:
          'Tap a chip to set the selected enum value. Each row reports '
          '`selected == ScrollIncrementType.x` using a real comparison and '
          'styles itself accordingly.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final t in ScrollIncrementType.values) ...[
                Expanded(
                  child: _SelectChip(
                    type: t,
                    selected: _selected == t,
                    onTap: () => setState(() => _selected = t),
                  ),
                ),
                if (t != ScrollIncrementType.values.last)
                  const SizedBox(width: 10),
              ],
            ],
          ),
          const SizedBox(height: 14),
          for (final t in ScrollIncrementType.values)
            _CompareRow(selected: _selected, candidate: t),
        ],
      ),
    );
  }
}

class _SelectChip extends StatelessWidget {
  const _SelectChip({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final ScrollIncrementType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = colorForType(type);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? color : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: selected ? 2 : 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconForType(type),
                color: selected ? Colors.white : color, size: 18),
            const SizedBox(width: 8),
            Text(
              tagFor(type),
              style: TextStyle(
                color: selected ? Colors.white : color,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({required this.selected, required this.candidate});

  final ScrollIncrementType selected;
  final ScrollIncrementType candidate;

  @override
  Widget build(BuildContext context) {
    final equal = selected == candidate;
    final color = colorForType(candidate);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: equal ? color.withValues(alpha: 0.18) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: equal
              ? color.withValues(alpha: 0.6)
              : kCobalt.withValues(alpha: 0.15),
          width: equal ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            equal ? Icons.check_circle : Icons.radio_button_unchecked,
            color: equal ? color : kMuted,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'selected == ${tagFor(candidate)}',
              style: TextStyle(
                color: equal ? color : kInk,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: equal ? color : kMuted.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              equal ? 'true' : 'false',
              style: TextStyle(
                color: equal ? Colors.white : kMuted,
                fontWeight: FontWeight.w800,
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

// ---------------------------------------------------------------------------
// Switch tutorial — explanatory tile that itself runs switch arms live.
// ---------------------------------------------------------------------------

class _SwitchTutorial extends StatelessWidget {
  const _SwitchTutorial();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§7  Switch tutorial',
      subtitle:
          'A canonical pattern: branch on details.type in your '
          'ScrollIncrementCalculator. Below, the live runtime values are '
          'computed from a real ScrollIncrementDetails for both arms.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'double myCalc(ScrollIncrementDetails d) {\n'
              '  switch (d.type) {\n'
              '    case ScrollIncrementType.line:\n'
              '      return 50.0;\n'
              '    case ScrollIncrementType.page:\n'
              '      return d.metrics.viewportDimension * 0.8;\n'
              '  }\n'
              '}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 14),
          for (final t in ScrollIncrementType.values)
            _ArmRow(type: t),
        ],
      ),
    );
  }
}

class _ArmRow extends StatelessWidget {
  const _ArmRow({required this.type});

  final ScrollIncrementType type;

  @override
  Widget build(BuildContext context) {
    final metrics = FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 5000,
      pixels: 0,
      viewportDimension: 800,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 1.0,
    );
    final details = ScrollIncrementDetails(type: type, metrics: metrics);
    final value = defaultCalculator(details);
    final color = colorForType(type);
    final summary = switch (type) {
      ScrollIncrementType.line =>
        'returns the constant 50.0 — independent of metrics.',
      ScrollIncrementType.page =>
        'returns viewportDimension * 0.8 — here, 800 × 0.8 = ${(800 * 0.8).toStringAsFixed(0)}.',
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'case ${tagFor(type)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary,
                  style: const TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'live value: ${value.toStringAsFixed(1)} px',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    fontSize: 12,
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
// Teaching panel
// ---------------------------------------------------------------------------

class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    final tiles = <_TeachingTile>[
      _TeachingTile(
        icon: Icons.settings_suggest,
        title: 'Defaults matter',
        body:
            'Flutter ships defaults of ${defaultPxDescription(ScrollIncrementType.line)} '
            'and ${defaultPxDescription(ScrollIncrementType.page)}. Override '
            'only when you have a real UX rationale — users have muscle '
            'memory for these.',
        color: kCobalt,
      ),
      _TeachingTile(
        icon: Icons.accessibility_new,
        title: 'Respect assistive tech',
        body:
            'Screen readers and switch devices assume predictable '
            '${tagFor(ScrollIncrementType.line)} and '
            '${tagFor(ScrollIncrementType.page)} increments. Surprising '
            'deltas break predictability and hurt accessibility.',
        color: kLineColor,
      ),
      _TeachingTile(
        icon: Icons.alt_route,
        title: 'Branch on the enum',
        body:
            'Inside a custom ScrollIncrementCalculator, switch on '
            'details.type — return fine-grained values for '
            '${tagFor(ScrollIncrementType.line)} and viewport-based jumps '
            'for ${tagFor(ScrollIncrementType.page)}.',
        color: kPageColor,
      ),
    ];
    return _SectionShell(
      title: '§8  Teaching panel',
      subtitle:
          'Design considerations when customising scroll increment behaviour.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < tiles.length; i++) ...[
            Expanded(child: tiles[i]),
            if (i < tiles.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class _TeachingTile extends StatelessWidget {
  const _TeachingTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: kInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Use cases strip — every tile carries a ScrollIncrementType (or null).
// ---------------------------------------------------------------------------

class _UseCasesStrip extends StatelessWidget {
  const _UseCasesStrip();

  @override
  Widget build(BuildContext context) {
    final tiles = <_UseCaseTile>[
      const _UseCaseTile(
        icon: Icons.chat_bubble_outline,
        title: 'Long chat logs',
        body: 'Arrow keys step one message; PageDown jumps to the next batch.',
        type: ScrollIncrementType.line,
      ),
      const _UseCaseTile(
        icon: Icons.menu_book_outlined,
        title: 'Document readers',
        body: 'Pages advance one screen at a time for fast reading.',
        type: ScrollIncrementType.page,
      ),
      const _UseCaseTile(
        icon: Icons.grid_on_outlined,
        title: 'Data tables',
        body: 'Line scroll walks row-by-row; pages advance whole screens.',
        type: ScrollIncrementType.line,
      ),
      const _UseCaseTile(
        icon: Icons.view_carousel_outlined,
        title: 'Paged onboarding',
        body: 'Page increments align naturally with one-screen walkthroughs.',
        type: ScrollIncrementType.page,
      ),
    ];
    return _SectionShell(
      title: '§9  Use cases',
      subtitle: 'Common places where the line/page distinction matters.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < tiles.length; i++) ...[
            Expanded(child: tiles[i]),
            if (i < tiles.length - 1) const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.type,
  });

  final IconData icon;
  final String title;
  final String body;
  final ScrollIncrementType type;

  @override
  Widget build(BuildContext context) {
    final color = colorForType(type);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  labelForType(type),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              color: kInk,
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
// Footer summary — bullets generated from ScrollIncrementType.values.
// ---------------------------------------------------------------------------

class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kInk.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kLemon,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.summarize_outlined,
                  color: kInk,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Summary — two values, one clean contract',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final t in ScrollIncrementType.values)
            _FooterBullet(
              type: t,
              text: switch (t) {
                ScrollIncrementType.line =>
                  'Fine, predictable ~50 px nudges. Bound to the arrow keys '
                      'and to assistive-tech single-step commands.',
                ScrollIncrementType.page =>
                  'Viewport-sized leaps (~80%). Bound to PageUp/PageDown and '
                      'to Space in web reading contexts.'
              },
            ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified, color: kLemon, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ScrollIncrementType is intentionally tiny — two values, '
                    'one job: carry the magnitude-semantics of a ScrollIntent '
                    'from key press to ScrollAction.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
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

class _FooterBullet extends StatelessWidget {
  const _FooterBullet({required this.type, required this.text});

  final ScrollIncrementType type;
  final String text;

  @override
  Widget build(BuildContext context) {
    final color = colorForType(type);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            margin: const EdgeInsets.only(right: 8, top: 1),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              labelForType(type),
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section shell.
// ---------------------------------------------------------------------------

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kCobalt.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: kCobalt.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kCobalt,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: kMuted,
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
