// ignore_for_file: avoid_print, deprecated_member_use, prefer_const_constructors, sort_child_properties_last
// D4rt deep visual demo: WidgetOrderTraversalPolicy.
//
// Theme: Conductor's baton / orchestra seating chart.
// Palette: maroon, gold, parchment, ink — evocative of a concert program.
//
// Contents:
//   1. Dossier / preamble (concept cards).
//   2. Live focusable orchestra seat grid wrapped in a
//      FocusTraversalGroup(policy: WidgetOrderTraversalPolicy()).
//   3. Policy comparison playground — Widget / Reading / Ordered — each
//      with its own controls and a CustomPainter baton trail connecting
//      current focus to previous focus.
//   4. Traversal log — every focus change, newest first.
//   5. Directional traversal card demonstrating arrow-key navigation
//      powered by DirectionalFocusTraversalPolicyMixin.
//   6. FocusTraversalOrder interaction — why WidgetOrder ignores it.
//   7. Recipe cards — default forms, multi-column grids, skipping
//      focusables, conditional skipping, DPad navigation.
//   8. Glossary / epilogue.
//
// The demo is a single top-level `dynamic build(BuildContext context)`
// returning MaterialApp. No main(), no runApp().
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Theme — Conductor's baton / orchestra seating chart
// ─────────────────────────────────────────────────────────────────────────────

const Color _kMaroon = Color(0xFF5A1A2B);
const Color _kMaroonDeep = Color(0xFF3A0F1D);
const Color _kMaroonLight = Color(0xFF7E2A3F);
const Color _kGold = Color(0xFFD4A43C);
const Color _kGoldDeep = Color(0xFF9A7820);
const Color _kGoldPale = Color(0xFFF4E1A8);
const Color _kParchment = Color(0xFFF6EFE0);
const Color _kParchmentDeep = Color(0xFFE9DFC5);
const Color _kInk = Color(0xFF2A1A12);
const Color _kInkFade = Color(0xFF5A4A3A);
const Color _kFelt = Color(0xFF2F1520);
const Color _kBatonTrail = Color(0xFFE6C560);
const Color _kAccentTeal = Color(0xFF2C6E7F);
const Color _kAccentRose = Color(0xFFB14A5B);

// ─────────────────────────────────────────────────────────────────────────────
// Top-level log sink — append-only traversal journal shared by the three
// comparison panels (tab-independent, still rebuilt on focus change).
// ─────────────────────────────────────────────────────────────────────────────

class _WotpLogEntry {
  _WotpLogEntry({
    required this.index,
    required this.stamp,
    required this.policy,
    required this.from,
    required this.to,
    required this.reason,
  });

  final int index;
  final DateTime stamp;
  final String policy;
  final String from;
  final String to;
  final String reason;
}

final ValueNotifier<List<_WotpLogEntry>> _wotpLog =
    ValueNotifier<List<_WotpLogEntry>>(<_WotpLogEntry>[]);
int _wotpLogCounter = 0;

void _logFocusChange({
  required String policy,
  required String from,
  required String to,
  required String reason,
}) {
  if (from == to) return;
  _wotpLogCounter += 1;
  final entry = _WotpLogEntry(
    index: _wotpLogCounter,
    stamp: DateTime.now(),
    policy: policy,
    from: from,
    to: to,
    reason: reason,
  );
  final next = <_WotpLogEntry>[entry, ..._wotpLog.value];
  if (next.length > 40) {
    next.removeRange(40, next.length);
  }
  _wotpLog.value = next;
}

// ─────────────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('WidgetOrderTraversalPolicy deep demo executing');
  print('=' * 70);
  print('Class:    WidgetOrderTraversalPolicy');
  print('Library:  package:flutter/src/widgets/focus_traversal.dart');
  print('Extends:  FocusTraversalPolicy with DirectionalFocusTraversalPolicyMixin');
  print('Ctor:     WidgetOrderTraversalPolicy({requestFocusCallback})');
  print('Default:  used by FocusTraversalGroup when no policy is passed');
  print('Order:    widget tree declaration order (not visual reading order)');
  print('Siblings: ReadingOrderTraversalPolicy, OrderedTraversalPolicy');
  print('=' * 70);
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WidgetOrderTraversalPolicy — Conductor\'s Baton',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kParchment,
      fontFamily: null,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kMaroon,
        brightness: Brightness.light,
        primary: _kMaroon,
        secondary: _kGold,
        surface: _kParchment,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _kMaroonDeep,
        foregroundColor: _kGoldPale,
        elevation: 0,
      ),
      tabBarTheme: const TabBarThemeData(
        indicatorColor: _kGold,
        labelColor: _kGoldPale,
        unselectedLabelColor: Color(0xFFD8C8A8),
      ),
    ),
    home: const _WotpHome(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Root shell — tabbed layout with a baton-backdrop CustomPaint header.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpHome extends StatefulWidget {
  const _WotpHome();

  @override
  State<_WotpHome> createState() => _WotpHomeState();
}

class _WotpHomeState extends State<_WotpHome>
    with TickerProviderStateMixin {
  static const List<_WotpTabSpec> _tabs = <_WotpTabSpec>[
    _WotpTabSpec(icon: Icons.menu_book_rounded, label: 'Dossier'),
    _WotpTabSpec(icon: Icons.event_seat_rounded, label: 'Seat Grid'),
    _WotpTabSpec(icon: Icons.compare_arrows_rounded, label: 'Playground'),
    _WotpTabSpec(icon: Icons.receipt_long_rounded, label: 'Log'),
    _WotpTabSpec(icon: Icons.explore_rounded, label: 'Directional'),
    _WotpTabSpec(icon: Icons.linear_scale_rounded, label: 'Order Marker'),
    _WotpTabSpec(icon: Icons.restaurant_menu_rounded, label: 'Recipes'),
    _WotpTabSpec(icon: Icons.spellcheck_rounded, label: 'Glossary'),
  ];

  late final TabController _tabController;
  late final AnimationController _batonController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _batonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _batonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kParchment,
      appBar: AppBar(
        title: const Text(
          'WidgetOrderTraversalPolicy — Conductor\'s Baton',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _tabs
                .map(
                  (t) => Tab(
                    icon: Icon(t.icon, size: 18),
                    text: t.label,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      body: Column(
        children: [
          _WotpBatonBackdrop(controller: _batonController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const <Widget>[
                _WotpDossierTab(),
                _WotpSeatGridTab(),
                _WotpPlaygroundTab(),
                _WotpLogTab(),
                _WotpDirectionalTab(),
                _WotpOrderMarkerTab(),
                _WotpRecipesTab(),
                _WotpGlossaryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WotpTabSpec {
  const _WotpTabSpec({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

// ─────────────────────────────────────────────────────────────────────────────
// Header — a CustomPaint baton backdrop with a drifting golden stroke.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpBatonBackdrop extends StatelessWidget {
  const _WotpBatonBackdrop({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _WotpBatonBackdropPainter(phase: controller.value),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Focus traversal follows the score — widget-tree order, not visual order.',
                  style: TextStyle(
                    color: _kGoldPale,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WotpBatonBackdropPainter extends CustomPainter {
  _WotpBatonBackdropPainter({required this.phase});
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = LinearGradient(
        colors: const [_kMaroonDeep, _kMaroon, _kMaroonDeep],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // Subtle horizontal felt lines — like the wood grain of a stage.
    final grain = Paint()
      ..color = _kFelt.withValues(alpha: 0.35)
      ..strokeWidth = 1;
    for (double y = 6; y < size.height; y += 14) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grain);
    }

    // Baton curve — a sinusoid sweeping left-to-right.
    final path = Path();
    const steps = 120;
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = t * size.width;
      final y = size.height / 2 +
          math.sin((t * 4 * math.pi) + (phase * 2 * math.pi)) * 10;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final baton = Paint()
      ..color = _kBatonTrail.withValues(alpha: 0.85)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, baton);

    // Baton tip — a small glowing circle tracing the curve.
    final tipX = phase * size.width;
    final tipY = size.height / 2 +
        math.sin((phase * 4 * math.pi) + (phase * 2 * math.pi)) * 10;
    final glow = Paint()
      ..color = _kGold.withValues(alpha: 0.55)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(tipX, tipY), 7, glow);
    final tip = Paint()..color = _kGoldPale;
    canvas.drawCircle(Offset(tipX, tipY), 3, tip);
  }

  @override
  bool shouldRepaint(covariant _WotpBatonBackdropPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared card chrome — parchment card with gold edge.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpCard extends StatelessWidget {
  const _WotpCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
    this.accent = _kMaroon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kGoldDeep.withValues(alpha: 0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: _kMaroonDeep.withValues(alpha: 0.12),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent, accent.withValues(alpha: 0.72)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _kGoldPale.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: _kGoldPale.withValues(alpha: 0.55)),
                  ),
                  child: Icon(icon, color: _kGoldPale, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: _kGoldPale,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              color: _kGoldPale.withValues(alpha: 0.82),
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
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

class _WotpDivider extends StatelessWidget {
  const _WotpDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _kGoldDeep.withValues(alpha: 0.0),
            _kGoldDeep.withValues(alpha: 0.6),
            _kGoldDeep.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

class _WotpTag extends StatelessWidget {
  const _WotpTag({
    required this.label,
    this.color = _kMaroon,
    this.textColor = _kGoldPale,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kGoldDeep.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _WotpBullet extends StatelessWidget {
  const _WotpBullet({required this.text, this.glyph = '•'});
  final String text;
  final String glyph;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              glyph,
              style: const TextStyle(
                color: _kGoldDeep,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kInk,
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

class _WotpCodeBlock extends StatelessWidget {
  const _WotpCodeBlock({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kMaroonDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kGoldDeep.withValues(alpha: 0.55)),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: _kGoldPale,
          fontSize: 12,
          fontFamily: 'monospace',
          height: 1.45,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 1 — Dossier / preamble.
// Six+ cards explaining focus traversal, where WidgetOrderTraversalPolicy
// fits, and why "widget order" may differ from "reading order".
// ─────────────────────────────────────────────────────────────────────────────

class _WotpDossierTab extends StatelessWidget {
  const _WotpDossierTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
      children: const <Widget>[
        _WotpDossierIntro(),
        _WotpDossierWhatIsFocus(),
        _WotpDossierWhyWidgetOrder(),
        _WotpDossierConstructor(),
        _WotpDossierTreeVsReading(),
        _WotpDossierWhenToUse(),
        _WotpDossierRelatedPolicies(),
        _WotpDossierAlgorithm(),
        _WotpDossierPitfalls(),
      ],
    );
  }
}

class _WotpDossierIntro extends StatelessWidget {
  const _WotpDossierIntro();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'The conductor\'s baton follows the score',
      subtitle: 'An introduction to widget-order focus traversal',
      icon: Icons.music_note_rounded,
      accent: _kMaroonDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'WidgetOrderTraversalPolicy is Flutter\'s most predictable focus '
            'policy: it visits focus nodes in the order they appear in the '
            'widget tree. For developers familiar with the element tree — '
            'the "score" — this is like following the conductor\'s baton '
            'from one marked measure to the next, left to right across the '
            'page, never leaping based on visual geometry.',
            style: TextStyle(fontSize: 13, height: 1.55, color: _kInk),
          ),
          SizedBox(height: 10),
          _WotpBullet(
            text: 'Default policy for FocusTraversalGroup when none is given.',
          ),
          _WotpBullet(
            text: 'Uses DirectionalFocusTraversalPolicyMixin for arrow keys.',
          ),
          _WotpBullet(
            text: 'Ignores explicit FocusTraversalOrder markers — those are '
                'honored only by OrderedTraversalPolicy.',
          ),
          _WotpBullet(
            text: 'Deterministic: two identical widget trees always produce '
                'the same Tab order.',
          ),
        ],
      ),
    );
  }
}

class _WotpDossierWhatIsFocus extends StatelessWidget {
  const _WotpDossierWhatIsFocus();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'What is focus traversal?',
      subtitle: 'FocusNode, FocusScope, FocusManager, FocusTraversalPolicy',
      icon: Icons.account_tree_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Flutter manages focus through a tree of FocusNodes rooted at '
            'FocusManager.instance.rootScope. Every widget that can receive '
            'keyboard input — TextField, button, Focus, FocusableActionDetector — '
            'owns or attaches a FocusNode. When the user presses Tab, Flutter '
            'asks the ambient FocusTraversalPolicy which node should gain '
            'focus next.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          SizedBox(height: 8),
          _WotpBullet(
            text: 'FocusNode — one point in the focus tree; may be focused.',
          ),
          _WotpBullet(
            text: 'FocusScopeNode — groups children; has focusedChild.',
          ),
          _WotpBullet(
            text: 'FocusTraversalGroup — selects the policy for a subtree.',
          ),
          _WotpBullet(
            text: 'FocusTraversalPolicy — sortDescendants, findFirst/Last, '
                'inDirection, next/previous.',
          ),
        ],
      ),
    );
  }
}

class _WotpDossierWhyWidgetOrder extends StatelessWidget {
  const _WotpDossierWhyWidgetOrder();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Why widget order?',
      subtitle: 'Predictable, stable, tree-local',
      icon: Icons.format_list_numbered_rounded,
      accent: _kMaroonLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'The widget tree is the source of truth. When you declare '
            'Column(children: [a, b, c]), you expect Tab to go a → b → c. '
            'WidgetOrderTraversalPolicy guarantees exactly that — even when '
            'absolute positioning, Transform, or Directionality would have '
            'placed the widgets differently on screen.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          SizedBox(height: 8),
          _WotpBullet(text: 'Stable across reflows and layout variants.'),
          _WotpBullet(text: 'Does not care about pixels — only tree order.'),
          _WotpBullet(text: 'Easy to reason about when composing.'),
          _WotpBullet(
            text: 'May surprise users with RTL text, where reading order '
                'runs right-to-left but widget order stays the same.',
          ),
        ],
      ),
    );
  }
}

class _WotpDossierConstructor extends StatelessWidget {
  const _WotpDossierConstructor();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Constructor',
      subtitle: 'WidgetOrderTraversalPolicy({requestFocusCallback})',
      icon: Icons.code_rounded,
      accent: _kAccentTeal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _WotpBullet(
            text: 'No positional arguments — fully default-constructible.',
          ),
          _WotpBullet(
            text: 'requestFocusCallback (optional): customize the mechanism '
                'used to request focus; useful when you need to scroll the '
                'target into view or animate focus transitions.',
          ),
          _WotpBullet(
            text: 'Inherits sortDescendants, findFirstFocus, findLastFocus, '
                'next, previous, and inDirection from FocusTraversalPolicy.',
          ),
          _WotpCodeBlock(
            code: 'FocusTraversalGroup(\n'
                '  policy: WidgetOrderTraversalPolicy(),\n'
                '  child: Column(\n'
                '    children: [field1, field2, field3, submitButton],\n'
                '  ),\n'
                ');',
          ),
        ],
      ),
    );
  }
}

class _WotpDossierTreeVsReading extends StatelessWidget {
  const _WotpDossierTreeVsReading();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Widget order ≠ reading order',
      subtitle: 'When the two diverge',
      icon: Icons.swap_horiz_rounded,
      accent: _kAccentRose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Imagine a Stack where a top-left overlay widget is declared '
            'AFTER a bottom-right background button. Widget order sends '
            'focus to the background first; reading order would visit the '
            'overlay first.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _wotpMiniPanel(
                  title: 'Widget order',
                  orderLabels: ['1. background', '2. overlay (on top)'],
                  color: _kMaroon,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _wotpMiniPanel(
                  title: 'Reading order',
                  orderLabels: ['1. overlay (on top)', '2. background'],
                  color: _kAccentTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const _WotpBullet(
            text: 'Columns and Rows almost always match reading order.',
          ),
          const _WotpBullet(
            text: 'Stacks, overlays, Positioned widgets, and Transforms can '
                'break the alignment.',
          ),
          const _WotpBullet(
            text: 'RTL Directionality flips reading order but NOT widget '
                'order — pick the policy that matches user expectation.',
          ),
        ],
      ),
    );
  }

  Widget _wotpMiniPanel({
    required String title,
    required List<String> orderLabels,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          ...orderLabels.map(
            (l) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                l,
                style: const TextStyle(fontSize: 12, color: _kInk),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WotpDossierWhenToUse extends StatelessWidget {
  const _WotpDossierWhenToUse();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'When should you choose WidgetOrderTraversalPolicy?',
      subtitle: 'The Tab order mirrors declaration order',
      icon: Icons.rule_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _WotpBullet(
            glyph: '✓',
            text: 'Simple forms: name / email / password stacked in a Column.',
          ),
          _WotpBullet(
            glyph: '✓',
            text: 'Grids that are declared in the same order you want users '
                'to Tab through — row by row.',
          ),
          _WotpBullet(
            glyph: '✓',
            text: 'You want the Tab order to be refactor-stable — moving '
                'a widget in source changes the order.',
          ),
          _WotpBullet(
            glyph: '✓',
            text: 'LTR-only layouts where reading and widget orders coincide.',
          ),
          SizedBox(height: 8),
          _WotpBullet(
            glyph: '✗',
            text: 'RTL or mixed bidirectional UI — prefer ReadingOrder.',
          ),
          _WotpBullet(
            glyph: '✗',
            text: 'You need explicit, non-tree Tab ordering — use '
                'OrderedTraversalPolicy with FocusTraversalOrder markers.',
          ),
        ],
      ),
    );
  }
}

class _WotpDossierRelatedPolicies extends StatelessWidget {
  const _WotpDossierRelatedPolicies();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Related focus traversal policies',
      subtitle: 'A family of FocusTraversalPolicy subclasses',
      icon: Icons.family_restroom_rounded,
      accent: _kGoldDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _WotpPolicyRow(
            name: 'WidgetOrderTraversalPolicy',
            byline: 'Widget-tree declaration order. Default.',
            color: _kMaroon,
          ),
          _WotpPolicyRow(
            name: 'ReadingOrderTraversalPolicy',
            byline:
                'Sort by on-screen position — top-to-bottom, start-to-end, '
                'respecting Directionality.',
            color: _kAccentTeal,
          ),
          _WotpPolicyRow(
            name: 'OrderedTraversalPolicy',
            byline: 'Honor FocusTraversalOrder markers (Numeric or Lexical). '
                'Falls back to a secondary policy for unordered nodes.',
            color: _kAccentRose,
          ),
          _WotpPolicyRow(
            name: 'DirectionalFocusTraversalPolicyMixin',
            byline:
                'Adds inDirection (arrow keys) to any FocusTraversalPolicy. '
                'Mixed into all three concrete policies above.',
            color: _kGoldDeep,
          ),
        ],
      ),
    );
  }
}

class _WotpPolicyRow extends StatelessWidget {
  const _WotpPolicyRow({
    required this.name,
    required this.byline,
    required this.color,
  });

  final String name;
  final String byline;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    byline,
                    style: const TextStyle(
                      color: _kInk,
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

class _WotpDossierAlgorithm extends StatelessWidget {
  const _WotpDossierAlgorithm();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'The sortDescendants algorithm',
      subtitle: 'How WidgetOrderTraversalPolicy produces its list',
      icon: Icons.functions_rounded,
      accent: _kMaroonDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _WotpBullet(
            glyph: '1',
            text: 'Walk the Element tree, collecting all traversable FocusNodes '
                'within the current FocusTraversalGroup scope.',
          ),
          _WotpBullet(
            glyph: '2',
            text: 'Preserve the order nodes were attached — which corresponds '
                'to their position in the widget tree.',
          ),
          _WotpBullet(
            glyph: '3',
            text: 'Filter out unfocusable/disabled nodes.',
          ),
          _WotpBullet(
            glyph: '4',
            text: 'Return the resulting list. next() / previous() / '
                'findFirstFocus() / findLastFocus() use this list.',
          ),
          SizedBox(height: 8),
          Text(
            'Because the traversal order equals attachment order, moving a '
            'widget earlier in a Column will immediately move it earlier in '
            'the Tab order. This is what makes WidgetOrderTraversalPolicy '
            'the most refactor-faithful policy.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
        ],
      ),
    );
  }
}

class _WotpDossierPitfalls extends StatelessWidget {
  const _WotpDossierPitfalls();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Pitfalls',
      subtitle: 'Where users get surprised',
      icon: Icons.warning_amber_rounded,
      accent: _kAccentRose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _WotpBullet(
            text: 'Stacks and overlays: the last child paints on top but is '
                'still visited last.',
          ),
          _WotpBullet(
            text: 'Conditional children: removing a focusable mid-tree '
                'shifts every subsequent Tab index.',
          ),
          _WotpBullet(
            text: 'Nested FocusTraversalGroups: each group has its own '
                'sortDescendants. The outer group visits the group as a '
                'unit after descending into it.',
          ),
          _WotpBullet(
            text: 'Directionality: arrow keys (inDirection) still respect '
                'the ambient Directionality even though Tab does not.',
          ),
          _WotpBullet(
            text: 'FocusTraversalOrder markers are IGNORED — use '
                'OrderedTraversalPolicy if you need them.',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 2 — Live focusable orchestra seat grid.
// A grid of FocusableActionDetectors wrapped in a
// FocusTraversalGroup(policy: WidgetOrderTraversalPolicy()). Buttons drive
// traversal via primaryFocus.nextFocus() / previousFocus() / requestFocus().
// Each focused card shows a gold halo.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpSeatGridTab extends StatefulWidget {
  const _WotpSeatGridTab();

  @override
  State<_WotpSeatGridTab> createState() => _WotpSeatGridTabState();
}

class _WotpSeatGridTabState extends State<_WotpSeatGridTab>
    with TickerProviderStateMixin {
  static const int _rowCount = 4;
  static const int _colCount = 6;
  static const int _nodeCount = _rowCount * _colCount;

  late final List<FocusNode> _nodes;
  late final List<String> _seatLabels;
  late final FocusNode _groupRoot;
  late final AnimationController _haloController;

  int _focusedIndex = -1;
  int _previousFocusedIndex = -1;
  String _lastReason = 'Press Next / Previous / First / Last to begin.';

  @override
  void initState() {
    super.initState();
    _groupRoot = FocusNode(debugLabel: 'WotpSeatGridRoot', skipTraversal: true);
    _nodes = List<FocusNode>.generate(
      _nodeCount,
      (i) => FocusNode(debugLabel: 'Seat-${i + 1}'),
    );
    _seatLabels = List<String>.generate(_nodeCount, (i) {
      final row = String.fromCharCode(65 + i ~/ _colCount); // A, B, C, ...
      final col = (i % _colCount) + 1;
      return '$row$col';
    });
    for (int i = 0; i < _nodes.length; i++) {
      final capturedIndex = i;
      _nodes[i].addListener(() => _handleFocusChange(capturedIndex));
    }
    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _haloController.dispose();
    for (final n in _nodes) {
      n.dispose();
    }
    _groupRoot.dispose();
    super.dispose();
  }

  void _handleFocusChange(int i) {
    if (!_nodes[i].hasFocus) return;
    if (_focusedIndex == i) return;
    final prev = _focusedIndex;
    final prevLabel = prev < 0 ? '(none)' : _seatLabels[prev];
    final toLabel = _seatLabels[i];
    setState(() {
      _previousFocusedIndex = prev;
      _focusedIndex = i;
    });
    _logFocusChange(
      policy: 'WidgetOrder',
      from: prevLabel,
      to: toLabel,
      reason: _lastReason,
    );
  }

  void _invokeNext() {
    setState(() => _lastReason = 'nextFocus()');
    if (_focusedIndex < 0) {
      _requestIndex(0, reason: 'first via nextFocus()');
      return;
    }
    FocusManager.instance.primaryFocus?.nextFocus();
  }

  void _invokePrevious() {
    setState(() => _lastReason = 'previousFocus()');
    if (_focusedIndex < 0) {
      _requestIndex(_nodeCount - 1, reason: 'last via previousFocus()');
      return;
    }
    FocusManager.instance.primaryFocus?.previousFocus();
  }

  void _invokeFirst() {
    _requestIndex(0, reason: 'requestFocus() → first');
  }

  void _invokeLast() {
    _requestIndex(_nodeCount - 1, reason: 'requestFocus() → last');
  }

  void _requestIndex(int i, {required String reason}) {
    setState(() => _lastReason = reason);
    _nodes[i].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
      children: [
        _WotpCard(
          title: 'Live focusable orchestra seat grid',
          subtitle:
              '$_nodeCount seats in a FocusTraversalGroup(policy: WidgetOrderTraversalPolicy())',
          icon: Icons.event_seat_rounded,
          accent: _kMaroonDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The seats below are declared row-by-row as a series of '
                'Rows inside a Column — the widget tree order is A1, A2, '
                '… A6, B1, B2, … F6. Tab through them or use the action '
                'bar. The focused seat glows gold; the previously focused '
                'seat stays marked with a dim rosette.',
                style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
              ),
              const _WotpDivider(),
              _wotpActionBar(),
              const SizedBox(height: 14),
              _wotpLegend(),
              const SizedBox(height: 14),
              FocusTraversalGroup(
                policy: WidgetOrderTraversalPolicy(),
                child: Focus(
                  focusNode: _groupRoot,
                  child: Column(
                    children: List<Widget>.generate(_rowCount, (r) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: List<Widget>.generate(_colCount, (c) {
                            final idx = r * _colCount + c;
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: _WotpSeatCard(
                                  label: _seatLabels[idx],
                                  index: idx,
                                  focusNode: _nodes[idx],
                                  isFocused: _focusedIndex == idx,
                                  isPrevious: _previousFocusedIndex == idx,
                                  haloController: _haloController,
                                  onTap: () => _requestIndex(
                                    idx,
                                    reason:
                                        'tap requestFocus() on ${_seatLabels[idx]}',
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _wotpReadout(),
            ],
          ),
        ),
        _WotpCard(
          title: 'What happens under the hood',
          subtitle: 'nextFocus / previousFocus / requestFocus',
          icon: Icons.settings_rounded,
          accent: _kGoldDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _WotpBullet(
                text: 'primaryFocus.nextFocus() asks the ambient policy '
                    '(here, WidgetOrderTraversalPolicy) for the next node '
                    'in its sorted list, wrapping at the end.',
              ),
              _WotpBullet(
                text: 'primaryFocus.previousFocus() walks the list backwards.',
              ),
              _WotpBullet(
                text: 'FocusNode.requestFocus() focuses a specific node '
                    'regardless of the traversal order.',
              ),
              _WotpBullet(
                text: 'Because the policy is WidgetOrder, the order is '
                    'exactly A1 → A2 → … → A6 → B1 → … → F6. No surprises.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _wotpActionBar() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _WotpActionButton(
          icon: Icons.first_page_rounded,
          label: 'First',
          onPressed: _invokeFirst,
        ),
        _WotpActionButton(
          icon: Icons.navigate_before_rounded,
          label: 'Previous',
          onPressed: _invokePrevious,
        ),
        _WotpActionButton(
          icon: Icons.navigate_next_rounded,
          label: 'Next',
          onPressed: _invokeNext,
        ),
        _WotpActionButton(
          icon: Icons.last_page_rounded,
          label: 'Last',
          onPressed: _invokeLast,
        ),
      ],
    );
  }

  Widget _wotpLegend() {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: const [
        _WotpLegendChip(
          color: _kGold,
          label: 'Currently focused',
        ),
        _WotpLegendChip(
          color: _kAccentRose,
          label: 'Previously focused',
        ),
        _WotpLegendChip(
          color: _kParchmentDeep,
          label: 'Idle seat',
          textColor: _kInk,
        ),
      ],
    );
  }

  Widget _wotpReadout() {
    final current =
        _focusedIndex < 0 ? '(none)' : _seatLabels[_focusedIndex];
    final previous =
        _previousFocusedIndex < 0 ? '(none)' : _seatLabels[_previousFocusedIndex];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kMaroonDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGoldDeep.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _wotpReadoutRow('Focused', current),
          _wotpReadoutRow('Previous', previous),
          _wotpReadoutRow('Last action', _lastReason),
        ],
      ),
    );
  }

  Widget _wotpReadoutRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                color: _kGoldPale,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _kGoldPale,
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

class _WotpSeatCard extends StatelessWidget {
  const _WotpSeatCard({
    required this.label,
    required this.index,
    required this.focusNode,
    required this.isFocused,
    required this.isPrevious,
    required this.haloController,
    required this.onTap,
  });

  final String label;
  final int index;
  final FocusNode focusNode;
  final bool isFocused;
  final bool isPrevious;
  final AnimationController haloController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: haloController,
      builder: (context, _) {
        final haloGlow = isFocused ? (0.5 + haloController.value * 0.5) : 0.0;
        return FocusableActionDetector(
          focusNode: focusNode,
          onFocusChange: (_) {},
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: isFocused
                    ? _kGoldPale
                    : (isPrevious
                        ? _kAccentRose.withValues(alpha: 0.15)
                        : _kParchmentDeep),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isFocused
                      ? _kGold
                      : (isPrevious
                          ? _kAccentRose
                          : _kGoldDeep.withValues(alpha: 0.35)),
                  width: isFocused ? 2.4 : 1.1,
                ),
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: _kGold.withValues(alpha: haloGlow),
                          blurRadius: 14,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: isFocused
                          ? _kMaroonDeep
                          : (isPrevious ? _kAccentRose : _kInk),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '#${index + 1}',
                    style: TextStyle(
                      color: isFocused
                          ? _kMaroonDeep.withValues(alpha: 0.7)
                          : _kInkFade,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WotpActionButton extends StatelessWidget {
  const _WotpActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: _kMaroon,
        foregroundColor: _kGoldPale,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: _kGoldDeep.withValues(alpha: 0.5)),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _WotpLegendChip extends StatelessWidget {
  const _WotpLegendChip({
    required this.color,
    required this.label,
    this.textColor = _kInk,
  });

  final Color color;
  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 3 — Policy comparison playground.
// Three side-by-side panels show the same nine focusables laid out with
// WidgetOrder / Reading / Ordered. Each panel has its own Next/Prev/First
// buttons and a CustomPainter baton trail connecting the current focus
// centre to the previous focus centre.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpPlaygroundTab extends StatefulWidget {
  const _WotpPlaygroundTab();

  @override
  State<_WotpPlaygroundTab> createState() => _WotpPlaygroundTabState();
}

class _WotpPlaygroundTabState extends State<_WotpPlaygroundTab>
    with TickerProviderStateMixin {
  static const int _panelCount = 3;
  static const int _nodesPerPanel = 9;

  final List<GlobalKey> _panelKeys =
      List<GlobalKey>.generate(_panelCount, (_) => GlobalKey());
  final List<List<GlobalKey>> _nodeKeys = List<List<GlobalKey>>.generate(
    _panelCount,
    (_) => List<GlobalKey>.generate(_nodesPerPanel, (_) => GlobalKey()),
  );
  final List<List<FocusNode>> _nodes = List<List<FocusNode>>.generate(
    _panelCount,
    (p) => List<FocusNode>.generate(
      _nodesPerPanel,
      (i) => FocusNode(debugLabel: 'P$p-${i + 1}'),
    ),
  );
  final List<int> _focusedIndex = List<int>.filled(_panelCount, -1);
  final List<int> _previousFocusedIndex = List<int>.filled(_panelCount, -1);
  late final AnimationController _batonController;

  static const List<String> _panelNames = <String>[
    'WidgetOrderTraversalPolicy',
    'ReadingOrderTraversalPolicy',
    'OrderedTraversalPolicy',
  ];
  static const List<Color> _panelAccents = <Color>[
    _kMaroon,
    _kAccentTeal,
    _kAccentRose,
  ];

  @override
  void initState() {
    super.initState();
    _batonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    for (int p = 0; p < _panelCount; p++) {
      for (int i = 0; i < _nodesPerPanel; i++) {
        final panelIndex = p;
        final nodeIndex = i;
        _nodes[p][i]
            .addListener(() => _handleFocusChange(panelIndex, nodeIndex));
      }
    }
  }

  @override
  void dispose() {
    _batonController.dispose();
    for (final list in _nodes) {
      for (final n in list) {
        n.dispose();
      }
    }
    super.dispose();
  }

  void _handleFocusChange(int panel, int i) {
    if (!_nodes[panel][i].hasFocus) return;
    if (_focusedIndex[panel] == i) return;
    final prev = _focusedIndex[panel];
    final prevLabel = prev < 0 ? '(none)' : '#${prev + 1}';
    setState(() {
      _previousFocusedIndex[panel] = prev;
      _focusedIndex[panel] = i;
    });
    _logFocusChange(
      policy: _shortPolicyName(panel),
      from: prevLabel,
      to: '#${i + 1}',
      reason: 'nextFocus / requestFocus in ${_panelNames[panel]}',
    );
    _batonController.forward(from: 0.0);
  }

  String _shortPolicyName(int panel) {
    switch (panel) {
      case 0:
        return 'WidgetOrder';
      case 1:
        return 'ReadingOrder';
      case 2:
        return 'Ordered';
      default:
        return 'Unknown';
    }
  }

  FocusTraversalPolicy _policyFor(int panel) {
    switch (panel) {
      case 0:
        return WidgetOrderTraversalPolicy();
      case 1:
        return ReadingOrderTraversalPolicy();
      case 2:
        return OrderedTraversalPolicy();
      default:
        return WidgetOrderTraversalPolicy();
    }
  }

  void _invokeNext(int panel) {
    if (_focusedIndex[panel] < 0) {
      _nodes[panel][0].requestFocus();
      return;
    }
    final current = _nodes[panel][_focusedIndex[panel]];
    if (current.hasFocus) {
      current.nextFocus();
    } else {
      current.requestFocus();
    }
  }

  void _invokePrevious(int panel) {
    if (_focusedIndex[panel] < 0) {
      _nodes[panel][_nodesPerPanel - 1].requestFocus();
      return;
    }
    final current = _nodes[panel][_focusedIndex[panel]];
    if (current.hasFocus) {
      current.previousFocus();
    } else {
      current.requestFocus();
    }
  }

  void _invokeFirst(int panel) {
    _nodes[panel][0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
      children: [
        _WotpCard(
          title: 'Policy comparison playground',
          subtitle:
              'Same nine focusables — three different traversal policies',
          icon: Icons.compare_arrows_rounded,
          accent: _kMaroonDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Each panel contains nine focusables arranged in a 3×3 grid. '
                'The widgets are declared top-to-bottom, left-to-right, but '
                'the panels use different traversal policies. Watch the '
                'golden baton trail connect the previous focus to the '
                'current one — the shape of the trail reveals how each '
                'policy chooses what comes next.',
                style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
              ),
              SizedBox(height: 8),
              _WotpBullet(
                text: 'WidgetOrder: 1→2→3→4→5→6→7→8→9 (declaration).',
              ),
              _WotpBullet(
                text: 'ReadingOrder: top-to-bottom, LTR — visually equal in '
                    'this layout, but the algorithm is different.',
              ),
              _WotpBullet(
                text: 'Ordered: respects FocusTraversalOrder markers. The '
                    'third panel reverses odd indices with NumericFocusOrder.',
              ),
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            final children = List<Widget>.generate(_panelCount, (p) {
              return _buildPlaygroundPanel(p);
            });
            return wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children
                        .map((c) => Expanded(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: c,
                            )))
                        .toList(),
                  )
                : Column(
                    children: children
                        .map((c) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: c,
                            ))
                        .toList(),
                  );
          },
        ),
      ],
    );
  }

  Widget _buildPlaygroundPanel(int p) {
    final accent = _panelAccents[p];
    return _WotpCard(
      title: _panelNames[p],
      subtitle: p == 2
          ? 'Odd indices reversed via NumericFocusOrder'
          : 'Nine focusables, shared layout',
      icon: p == 0
          ? Icons.format_list_numbered_rounded
          : (p == 1 ? Icons.menu_book_rounded : Icons.swap_vert_rounded),
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPanelActionRow(p),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: _batonController,
            builder: (context, _) {
              return CustomPaint(
                foregroundPainter: _WotpBatonTrailPainter(
                  panelKey: _panelKeys[p],
                  nodeKeys: _nodeKeys[p],
                  currentIndex: _focusedIndex[p],
                  previousIndex: _previousFocusedIndex[p],
                  progress: _batonController.value,
                  accent: accent,
                ),
                child: RepaintBoundary(
                  key: _panelKeys[p],
                  child: FocusTraversalGroup(
                    policy: _policyFor(p),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: _buildPlaygroundGrid(p),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _buildPanelReadout(p),
        ],
      ),
    );
  }

  Widget _buildPlaygroundGrid(int p) {
    return Column(
      children: List<Widget>.generate(3, (row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: List<Widget>.generate(3, (col) {
              final i = row * 3 + col;
              final child = Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildPlaygroundNode(p, i),
                ),
              );
              if (p == 2 && i.isOdd) {
                // For the Ordered panel, give odd-indexed nodes reversed
                // numeric focus order so that 2,4,6,8 come before 1,3,5,7,9.
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FocusTraversalOrder(
                      order: NumericFocusOrder(i.toDouble()),
                      child: _buildPlaygroundNode(p, i),
                    ),
                  ),
                );
              }
              if (p == 2 && i.isEven) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FocusTraversalOrder(
                      order: NumericFocusOrder(100.0 + i),
                      child: _buildPlaygroundNode(p, i),
                    ),
                  ),
                );
              }
              return child;
            }),
          ),
        );
      }),
    );
  }

  Widget _buildPlaygroundNode(int p, int i) {
    final isFocused = _focusedIndex[p] == i;
    final isPrevious = _previousFocusedIndex[p] == i;
    return FocusableActionDetector(
      focusNode: _nodes[p][i],
      onFocusChange: (_) {},
      child: GestureDetector(
        onTap: () => _nodes[p][i].requestFocus(),
        child: Container(
          key: _nodeKeys[p][i],
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isFocused
                ? _kGoldPale
                : (isPrevious
                    ? _panelAccents[p].withValues(alpha: 0.18)
                    : _kParchmentDeep),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isFocused
                  ? _kGold
                  : (isPrevious
                      ? _panelAccents[p]
                      : _kGoldDeep.withValues(alpha: 0.3)),
              width: isFocused ? 2 : 1,
            ),
          ),
          child: Text(
            '#${i + 1}',
            style: TextStyle(
              color: isFocused
                  ? _kMaroonDeep
                  : (isPrevious ? _panelAccents[p] : _kInk),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanelActionRow(int p) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _WotpActionButton(
          icon: Icons.first_page_rounded,
          label: 'First',
          onPressed: () => _invokeFirst(p),
        ),
        _WotpActionButton(
          icon: Icons.navigate_before_rounded,
          label: 'Prev',
          onPressed: () => _invokePrevious(p),
        ),
        _WotpActionButton(
          icon: Icons.navigate_next_rounded,
          label: 'Next',
          onPressed: () => _invokeNext(p),
        ),
      ],
    );
  }

  Widget _buildPanelReadout(int p) {
    final current =
        _focusedIndex[p] < 0 ? '(none)' : '#${_focusedIndex[p] + 1}';
    final previous = _previousFocusedIndex[p] < 0
        ? '(none)'
        : '#${_previousFocusedIndex[p] + 1}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _kMaroonDeep,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'prev: $previous',
            style: const TextStyle(
              color: _kGoldPale,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            'focus: $current',
            style: TextStyle(
              color: _kGold,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _WotpBatonTrailPainter extends CustomPainter {
  _WotpBatonTrailPainter({
    required this.panelKey,
    required this.nodeKeys,
    required this.currentIndex,
    required this.previousIndex,
    required this.progress,
    required this.accent,
  });

  final GlobalKey panelKey;
  final List<GlobalKey> nodeKeys;
  final int currentIndex;
  final int previousIndex;
  final double progress;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    if (currentIndex < 0 || previousIndex < 0) return;
    final panelBox = panelKey.currentContext?.findRenderObject() as RenderBox?;
    final fromBox =
        nodeKeys[previousIndex].currentContext?.findRenderObject() as RenderBox?;
    final toBox =
        nodeKeys[currentIndex].currentContext?.findRenderObject() as RenderBox?;
    if (panelBox == null || fromBox == null || toBox == null) return;
    if (!panelBox.attached || !fromBox.attached || !toBox.attached) return;

    Offset centerOf(RenderBox box) {
      final topLeft = box.localToGlobal(Offset.zero);
      final panelTopLeft = panelBox.localToGlobal(Offset.zero);
      return topLeft - panelTopLeft + Offset(box.size.width / 2, box.size.height / 2);
    }

    final from = centerOf(fromBox);
    final to = centerOf(toBox);

    // Control point above the midpoint, bending like a conductor's baton.
    final mid = Offset((from.dx + to.dx) / 2, (from.dy + to.dy) / 2);
    final control = mid + const Offset(0, -30);

    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..quadraticBezierTo(control.dx, control.dy, to.dx, to.dy);

    final trail = Paint()
      ..color = _kBatonTrail.withValues(alpha: 0.55 + progress * 0.35)
      ..strokeWidth = 2.2 + progress * 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, trail);

    final glow = Paint()
      ..color = accent.withValues(alpha: 0.35 + progress * 0.4)
      ..strokeWidth = 4.4 + progress * 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path, glow);

    // Tip — interpolates along the curve driven by progress.
    final t = progress.clamp(0.0, 1.0);
    final p = _quadraticPoint(from, control, to, t);
    final tipGlow = Paint()
      ..color = _kGold.withValues(alpha: 0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(p, 7, tipGlow);
    final tip = Paint()..color = _kGoldPale;
    canvas.drawCircle(p, 3.4, tip);

    // Arrowhead at the destination.
    final dir = (to - from);
    final len = dir.distance.clamp(0.0001, double.infinity);
    final unit = Offset(dir.dx / len, dir.dy / len);
    final normal = Offset(-unit.dy, unit.dx);
    final ah = to - unit * 10;
    final headPath = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(ah.dx + normal.dx * 5, ah.dy + normal.dy * 5)
      ..lineTo(ah.dx - normal.dx * 5, ah.dy - normal.dy * 5)
      ..close();
    canvas.drawPath(headPath, Paint()..color = _kGold);
  }

  Offset _quadraticPoint(Offset a, Offset b, Offset c, double t) {
    final u = 1 - t;
    final x = u * u * a.dx + 2 * u * t * b.dx + t * t * c.dx;
    final y = u * u * a.dy + 2 * u * t * b.dy + t * t * c.dy;
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant _WotpBatonTrailPainter oldDelegate) =>
      oldDelegate.currentIndex != currentIndex ||
      oldDelegate.previousIndex != previousIndex ||
      oldDelegate.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 4 — Traversal log.
// A scrollable table of every focus change recorded by the playground/grid.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpLogTab extends StatelessWidget {
  const _WotpLogTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
      children: [
        _WotpCard(
          title: 'Traversal log',
          subtitle: 'Every focus change — newest first',
          icon: Icons.receipt_long_rounded,
          accent: _kMaroonDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Each row is one focus transition captured by listening to '
                'FocusNode.addListener on the seat grid and playground '
                'panels. The log is kept to the most recent forty entries.',
                style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
              ),
              const _WotpDivider(),
              _wotpLogHeader(),
              ValueListenableBuilder<List<_WotpLogEntry>>(
                valueListenable: _wotpLog,
                builder: (context, entries, _) {
                  if (entries.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No focus changes yet. Open the Seat Grid or '
                          'Playground tabs and press Next / Prev.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _kInkFade,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: entries
                        .map((e) => _wotpLogRow(e))
                        .toList(growable: false),
                  );
                },
              ),
            ],
          ),
        ),
        _WotpCard(
          title: 'How the log is built',
          subtitle: 'FocusNode listeners → top-level ValueNotifier',
          icon: Icons.info_outline_rounded,
          accent: _kGoldDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _WotpBullet(
                text: 'Each FocusNode used in the demo has an attached '
                    'listener that fires on every hasFocus change.',
              ),
              _WotpBullet(
                text: 'When a node gains focus, the listener pushes an '
                    'entry into a top-level ValueNotifier<List<_WotpLogEntry>>.',
              ),
              _WotpBullet(
                text: 'A ValueListenableBuilder rebuilds the log list '
                    'without the parent having to carry state — the log '
                    'survives tab switches.',
              ),
              _WotpBullet(
                text: 'The entry records policy name, from-label, to-label, '
                    'and a human-readable reason (nextFocus, requestFocus, …).',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _wotpLogHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kMaroonDeep,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          SizedBox(width: 32, child: Text('#', style: _wotpLogHeaderStyle)),
          SizedBox(width: 90, child: Text('time', style: _wotpLogHeaderStyle)),
          SizedBox(width: 92, child: Text('policy', style: _wotpLogHeaderStyle)),
          SizedBox(width: 70, child: Text('from', style: _wotpLogHeaderStyle)),
          SizedBox(width: 20, child: Text('→', style: _wotpLogHeaderStyle)),
          SizedBox(width: 60, child: Text('to', style: _wotpLogHeaderStyle)),
          Expanded(child: Text('reason', style: _wotpLogHeaderStyle)),
        ],
      ),
    );
  }

  static const TextStyle _wotpLogHeaderStyle = TextStyle(
    color: _kGoldPale,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    fontFamily: 'monospace',
    letterSpacing: 0.3,
  );

  Widget _wotpLogRow(_WotpLogEntry e) {
    final hh = e.stamp.hour.toString().padLeft(2, '0');
    final mm = e.stamp.minute.toString().padLeft(2, '0');
    final ss = e.stamp.second.toString().padLeft(2, '0');
    final ms = e.stamp.millisecond.toString().padLeft(3, '0');
    final timeStr = '$hh:$mm:$ss.$ms';
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: e.index.isEven ? _kParchmentDeep : _kParchment,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kGoldDeep.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text('${e.index}', style: _wotpLogCellMono(_kInkFade)),
          ),
          SizedBox(
            width: 90,
            child: Text(timeStr, style: _wotpLogCellMono(_kInkFade)),
          ),
          SizedBox(
            width: 92,
            child: Text(e.policy, style: _wotpLogCellMono(_kMaroonDeep)),
          ),
          SizedBox(
            width: 70,
            child: Text(e.from, style: _wotpLogCellMono(_kInk)),
          ),
          const SizedBox(
            width: 20,
            child: Text('→',
                style:
                    TextStyle(color: _kGoldDeep, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 60,
            child: Text(e.to,
                style: _wotpLogCellMono(_kMaroonDeep,
                    fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Text(e.reason,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 11,
                )),
          ),
        ],
      ),
    );
  }

  TextStyle _wotpLogCellMono(Color color,
      {FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      color: color,
      fontSize: 11,
      fontFamily: 'monospace',
      fontWeight: fontWeight,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 5 — Directional traversal.
// Demonstrates DirectionalFocusTraversalPolicyMixin.inDirection via arrow
// buttons wired to primaryFocus.focusInDirection(TraversalDirection.up/...).
// Also flips Directionality between LTR and RTL.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpDirectionalTab extends StatefulWidget {
  const _WotpDirectionalTab();

  @override
  State<_WotpDirectionalTab> createState() => _WotpDirectionalTabState();
}

class _WotpDirectionalTabState extends State<_WotpDirectionalTab>
    with TickerProviderStateMixin {
  static const int _rowCount = 3;
  static const int _colCount = 4;
  static const int _nodeCount = _rowCount * _colCount;

  late final List<FocusNode> _nodes;
  late final AnimationController _pulse;
  TextDirection _direction = TextDirection.ltr;
  int _focusedIndex = -1;
  String _lastMove = 'Use arrow buttons to steer focus.';

  @override
  void initState() {
    super.initState();
    _nodes = List<FocusNode>.generate(
      _nodeCount,
      (i) => FocusNode(debugLabel: 'Dir-${i + 1}'),
    );
    for (int i = 0; i < _nodes.length; i++) {
      final capturedIndex = i;
      _nodes[i].addListener(() => _handleFocusChange(capturedIndex));
    }
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    for (final n in _nodes) {
      n.dispose();
    }
    _pulse.dispose();
    super.dispose();
  }

  void _handleFocusChange(int i) {
    if (!_nodes[i].hasFocus) return;
    if (_focusedIndex == i) return;
    final prev = _focusedIndex;
    setState(() => _focusedIndex = i);
    _logFocusChange(
      policy: 'WidgetOrder+Directional',
      from: prev < 0 ? '(none)' : 'd${prev + 1}',
      to: 'd${i + 1}',
      reason: _lastMove,
    );
  }

  void _move(TraversalDirection d) {
    setState(() => _lastMove = 'focusInDirection(${_dirLabel(d)})');
    if (_focusedIndex < 0) {
      _nodes[0].requestFocus();
      return;
    }
    FocusManager.instance.primaryFocus?.focusInDirection(d);
  }

  String _dirLabel(TraversalDirection d) {
    switch (d) {
      case TraversalDirection.up:
        return 'up';
      case TraversalDirection.down:
        return 'down';
      case TraversalDirection.left:
        return 'left';
      case TraversalDirection.right:
        return 'right';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
      children: [
        _WotpCard(
          title: 'Directional traversal',
          subtitle: 'DirectionalFocusTraversalPolicyMixin.inDirection',
          icon: Icons.explore_rounded,
          accent: _kMaroonDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Arrow keys do NOT follow widget-tree order — they walk the '
                'focus graph by visual geometry. WidgetOrderTraversalPolicy '
                'inherits this behaviour from the mixin, so you can '
                'combine a deterministic Tab order with intuitive arrow-key '
                'navigation.',
                style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
              ),
              const SizedBox(height: 10),
              _wotpDirectionControls(),
              const SizedBox(height: 10),
              _wotpDirectionToggle(),
              const _WotpDivider(),
              Directionality(
                textDirection: _direction,
                child: FocusTraversalGroup(
                  policy: WidgetOrderTraversalPolicy(),
                  child: Column(
                    children: List<Widget>.generate(_rowCount, (r) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: List<Widget>.generate(_colCount, (c) {
                            final idx = r * _colCount + c;
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: _wotpDirectionalNode(idx),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kMaroonDeep,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'last move: $_lastMove   •   focused: ${_focusedIndex < 0 ? "(none)" : "d${_focusedIndex + 1}"}',
                  style: const TextStyle(
                    color: _kGoldPale,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        _WotpCard(
          title: 'Directional + widget order',
          subtitle: 'How the two interact',
          icon: Icons.auto_awesome_rounded,
          accent: _kAccentTeal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _WotpBullet(
                text: 'Tab → uses sortDescendants (widget order).',
              ),
              _WotpBullet(
                text: 'Arrow keys → use the mixin\'s inDirection algorithm '
                    'which picks the closest focus node in the given '
                    'direction using a projected geometric scoring function.',
              ),
              _WotpBullet(
                text: 'Directionality flips "forward" for Tab in some '
                    'policies, but NOT for WidgetOrder — it still uses the '
                    'widget tree order.',
              ),
              _WotpBullet(
                text: 'Arrow keys always mirror the on-screen geometry, '
                    'and do respect Directionality (left/right flip when '
                    'Directionality.rtl).',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _wotpDirectionControls() {
    Widget btn(IconData icon, TraversalDirection d, String label) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: _WotpActionButton(
          icon: icon,
          label: label,
          onPressed: () => _move(d),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [btn(Icons.keyboard_arrow_up_rounded, TraversalDirection.up, 'Up')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btn(Icons.keyboard_arrow_left_rounded, TraversalDirection.left, 'Left'),
            btn(Icons.keyboard_arrow_right_rounded, TraversalDirection.right, 'Right'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btn(Icons.keyboard_arrow_down_rounded, TraversalDirection.down, 'Down')
          ],
        ),
      ],
    );
  }

  Widget _wotpDirectionToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Directionality:',
          style: TextStyle(fontSize: 12, color: _kInk, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Text('LTR'),
          selected: _direction == TextDirection.ltr,
          onSelected: (_) =>
              setState(() => _direction = TextDirection.ltr),
          selectedColor: _kGoldPale,
          backgroundColor: _kParchmentDeep,
          labelStyle: TextStyle(
            color: _direction == TextDirection.ltr ? _kMaroonDeep : _kInk,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('RTL'),
          selected: _direction == TextDirection.rtl,
          onSelected: (_) =>
              setState(() => _direction = TextDirection.rtl),
          selectedColor: _kGoldPale,
          backgroundColor: _kParchmentDeep,
          labelStyle: TextStyle(
            color: _direction == TextDirection.rtl ? _kMaroonDeep : _kInk,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _wotpDirectionalNode(int i) {
    final isFocused = _focusedIndex == i;
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        return FocusableActionDetector(
          focusNode: _nodes[i],
          onFocusChange: (_) {},
          child: GestureDetector(
            onTap: () => _nodes[i].requestFocus(),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isFocused ? _kGoldPale : _kParchmentDeep,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isFocused ? _kGold : _kGoldDeep.withValues(alpha: 0.3),
                  width: isFocused ? 2 : 1,
                ),
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: _kGold.withValues(
                              alpha: 0.3 + _pulse.value * 0.4),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Text(
                'd${i + 1}',
                style: TextStyle(
                  color: isFocused ? _kMaroonDeep : _kInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 6 — FocusTraversalOrder interaction.
// Explains that WidgetOrderTraversalPolicy ignores FocusTraversalOrder
// markers, and what to do instead (OrderedTraversalPolicy).
// ─────────────────────────────────────────────────────────────────────────────

class _WotpOrderMarkerTab extends StatefulWidget {
  const _WotpOrderMarkerTab();

  @override
  State<_WotpOrderMarkerTab> createState() => _WotpOrderMarkerTabState();
}

class _WotpOrderMarkerTabState extends State<_WotpOrderMarkerTab> {
  late final List<FocusNode> _nodesWidget;
  late final List<FocusNode> _nodesOrdered;
  int _focusedWidget = -1;
  int _focusedOrdered = -1;

  @override
  void initState() {
    super.initState();
    _nodesWidget = List<FocusNode>.generate(
      5,
      (i) => FocusNode(debugLabel: 'OM-W-${i + 1}'),
    );
    _nodesOrdered = List<FocusNode>.generate(
      5,
      (i) => FocusNode(debugLabel: 'OM-O-${i + 1}'),
    );
    for (int i = 0; i < _nodesWidget.length; i++) {
      final capturedIndex = i;
      _nodesWidget[i].addListener(() {
        if (_nodesWidget[capturedIndex].hasFocus) {
          setState(() => _focusedWidget = capturedIndex);
        }
      });
      _nodesOrdered[i].addListener(() {
        if (_nodesOrdered[capturedIndex].hasFocus) {
          setState(() => _focusedOrdered = capturedIndex);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final n in _nodesWidget) {
      n.dispose();
    }
    for (final n in _nodesOrdered) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
      children: [
        _WotpCard(
          title: 'FocusTraversalOrder & WidgetOrderTraversalPolicy',
          subtitle: 'Why the marker is ignored here',
          icon: Icons.linear_scale_rounded,
          accent: _kMaroonDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'FocusTraversalOrder is a marker widget that attaches a '
                'FocusOrder (e.g. NumericFocusOrder(3.14) or '
                'LexicalFocusOrder("b")) to a descendant focus node. The '
                'marker is read by OrderedTraversalPolicy. '
                'WidgetOrderTraversalPolicy does NOT read this marker — it '
                'uses tree position only.',
                style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
              ),
              SizedBox(height: 8),
              _WotpBullet(
                text: 'Wrapping a child in FocusTraversalOrder under a '
                    'WidgetOrderTraversalPolicy has no effect on Tab order.',
              ),
              _WotpBullet(
                text: 'To honor explicit order, swap the policy to '
                    'OrderedTraversalPolicy. Its secondary policy defaults '
                    'to ReadingOrderTraversalPolicy.',
              ),
              _WotpBullet(
                text: 'NumericFocusOrder sorts by double; LexicalFocusOrder '
                    'sorts by String.',
              ),
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 820;
            final left = _buildIgnoredMarkerPanel();
            final right = _buildHonoredMarkerPanel();
            return wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: left),
                      const SizedBox(width: 12),
                      Expanded(child: right),
                    ],
                  )
                : Column(children: [left, const SizedBox(height: 10), right]);
          },
        ),
        _WotpCard(
          title: 'Code comparison',
          subtitle: 'Same markers — different policy',
          icon: Icons.code_rounded,
          accent: _kAccentTeal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _WotpCodeBlock(
                code: '// MARKERS IGNORED: tree order prevails.\n'
                    'FocusTraversalGroup(\n'
                    '  policy: WidgetOrderTraversalPolicy(),\n'
                    '  child: Column(\n'
                    '    children: [\n'
                    '      FocusTraversalOrder(\n'
                    '        order: NumericFocusOrder(99),\n'
                    '        child: alphaField, // still visited FIRST\n'
                    '      ),\n'
                    '      betaField,           // still visited SECOND\n'
                    '    ],\n'
                    '  ),\n'
                    ');',
              ),
              SizedBox(height: 6),
              _WotpCodeBlock(
                code: '// MARKERS HONORED: NumericFocusOrder sorts it.\n'
                    'FocusTraversalGroup(\n'
                    '  policy: OrderedTraversalPolicy(),\n'
                    '  child: Column(\n'
                    '    children: [\n'
                    '      FocusTraversalOrder(\n'
                    '        order: NumericFocusOrder(99),\n'
                    '        child: alphaField, // visited LAST\n'
                    '      ),\n'
                    '      FocusTraversalOrder(\n'
                    '        order: NumericFocusOrder(1),\n'
                    '        child: betaField, // visited FIRST\n'
                    '      ),\n'
                    '    ],\n'
                    '  ),\n'
                    ');',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIgnoredMarkerPanel() {
    return _WotpCard(
      title: 'WidgetOrderTraversalPolicy',
      subtitle: 'FocusTraversalOrder ignored',
      icon: Icons.not_interested_rounded,
      accent: _kMaroon,
      child: Column(
        children: [
          const Text(
            'Tab order here is 1 → 2 → 3 → 4 → 5 no matter what order markers '
            'we declare.',
            style: TextStyle(fontSize: 12, color: _kInk, height: 1.5),
          ),
          const SizedBox(height: 8),
          FocusTraversalGroup(
            policy: WidgetOrderTraversalPolicy(),
            child: Column(
              children: List<Widget>.generate(5, (i) {
                final order = 5 - i; // declare in reverse visually
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: FocusTraversalOrder(
                    order: NumericFocusOrder(order.toDouble()),
                    child: _markerNode(
                      'ignored #${i + 1} (marker=$order)',
                      _nodesWidget[i],
                      _focusedWidget == i,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 6),
          _WotpActionButton(
            icon: Icons.navigate_next_rounded,
            label: 'Next',
            onPressed: () {
              if (_focusedWidget < 0) {
                _nodesWidget[0].requestFocus();
              } else {
                _nodesWidget[_focusedWidget].nextFocus();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHonoredMarkerPanel() {
    return _WotpCard(
      title: 'OrderedTraversalPolicy',
      subtitle: 'FocusTraversalOrder honored',
      icon: Icons.check_circle_outline_rounded,
      accent: _kAccentTeal,
      child: Column(
        children: [
          const Text(
            'Same declarations — but Tab order follows NumericFocusOrder. '
            'Watch Tab jump to the marker=1 node first.',
            style: TextStyle(fontSize: 12, color: _kInk, height: 1.5),
          ),
          const SizedBox(height: 8),
          FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Column(
              children: List<Widget>.generate(5, (i) {
                final order = 5 - i;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: FocusTraversalOrder(
                    order: NumericFocusOrder(order.toDouble()),
                    child: _markerNode(
                      'ordered #${i + 1} (marker=$order)',
                      _nodesOrdered[i],
                      _focusedOrdered == i,
                      accent: _kAccentTeal,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 6),
          _WotpActionButton(
            icon: Icons.navigate_next_rounded,
            label: 'Next',
            onPressed: () {
              if (_focusedOrdered < 0) {
                _nodesOrdered[0].requestFocus();
              } else {
                _nodesOrdered[_focusedOrdered].nextFocus();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _markerNode(String label, FocusNode node, bool focused,
      {Color accent = _kMaroon}) {
    return FocusableActionDetector(
      focusNode: node,
      onFocusChange: (_) {},
      child: GestureDetector(
        onTap: () => node.requestFocus(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: focused ? _kGoldPale : _kParchmentDeep,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: focused ? _kGold : accent.withValues(alpha: 0.35),
              width: focused ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: focused ? _kMaroonDeep : _kInk,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 7 — Recipe cards.
// Five practical patterns using WidgetOrderTraversalPolicy.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpRecipesTab extends StatelessWidget {
  const _WotpRecipesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
      children: const [
        _WotpRecipeDefaultForm(),
        _WotpRecipeMultiColumnGrid(),
        _WotpRecipeSkipFocusable(),
        _WotpRecipeConditionalSkip(),
        _WotpRecipeDpad(),
        _WotpRecipeNestedGroups(),
      ],
    );
  }
}

class _WotpRecipeDefaultForm extends StatelessWidget {
  const _WotpRecipeDefaultForm();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Recipe 1 — Default form',
      subtitle: 'Nothing to configure: use the built-in default',
      icon: Icons.assignment_outlined,
      accent: _kMaroonDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'A naked Column of fields already uses WidgetOrderTraversalPolicy '
            'by default — there\'s no need to wrap it in FocusTraversalGroup.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          _WotpCodeBlock(
            code: 'Column(\n'
                '  children: [\n'
                '    TextField(decoration: InputDecoration(labelText: "Name")),\n'
                '    TextField(decoration: InputDecoration(labelText: "Email")),\n'
                '    TextField(decoration: InputDecoration(labelText: "Password"),\n'
                '              obscureText: true),\n'
                '    ElevatedButton(onPressed: submit, child: Text("Sign in")),\n'
                '  ],\n'
                ');',
          ),
          _WotpBullet(text: 'Tab order: Name → Email → Password → Sign in.'),
          _WotpBullet(
            text: 'Shift+Tab walks back. autofocus: true on the first '
                'field gives a sensible starting state.',
          ),
        ],
      ),
    );
  }
}

class _WotpRecipeMultiColumnGrid extends StatelessWidget {
  const _WotpRecipeMultiColumnGrid();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Recipe 2 — Multi-column grid',
      subtitle: 'Tab travels row-by-row because that\'s how you declared it',
      icon: Icons.grid_view_rounded,
      accent: _kAccentTeal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'If your widget tree declares Rows inside a Column, widget order '
            'naturally flows left-to-right within a row, then down. This is '
            'what WidgetOrderTraversalPolicy gives you for free.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          _WotpCodeBlock(
            code: 'FocusTraversalGroup(\n'
                '  policy: WidgetOrderTraversalPolicy(),\n'
                '  child: Column(\n'
                '    children: [\n'
                '      Row(children: [field(0), field(1), field(2)]),\n'
                '      Row(children: [field(3), field(4), field(5)]),\n'
                '      Row(children: [field(6), field(7), field(8)]),\n'
                '    ],\n'
                '  ),\n'
                ');',
          ),
          _WotpBullet(text: 'Tab order: 0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8.'),
          _WotpBullet(
            text: 'If you need column-major order instead, swap the Columns '
                'and Rows in your tree — the policy will follow.',
          ),
        ],
      ),
    );
  }
}

class _WotpRecipeSkipFocusable extends StatelessWidget {
  const _WotpRecipeSkipFocusable();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Recipe 3 — Skipping a focusable',
      subtitle: 'skipTraversal on FocusNode',
      icon: Icons.skip_next_rounded,
      accent: _kAccentRose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Setting FocusNode.skipTraversal = true excludes the node from '
            'the policy\'s sortDescendants output. The node is still '
            'focusable programmatically (requestFocus), but Tab hops past it.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          _WotpCodeBlock(
            code: 'final skipMe = FocusNode(skipTraversal: true);\n'
                'FocusTraversalGroup(\n'
                '  policy: WidgetOrderTraversalPolicy(),\n'
                '  child: Column(\n'
                '    children: [\n'
                '      Focus(focusNode: a, child: ...),\n'
                '      Focus(focusNode: skipMe, child: ...),\n'
                '      Focus(focusNode: c, child: ...),\n'
                '    ],\n'
                '  ),\n'
                ');',
          ),
          _WotpBullet(text: 'Tab order: a → c (skipMe is invisible to Tab).'),
          _WotpBullet(
            text: 'Use skipTraversal when a focusable is informational '
                '(e.g. a copyable readonly badge) and shouldn\'t interrupt '
                'keyboard flow.',
          ),
        ],
      ),
    );
  }
}

class _WotpRecipeConditionalSkip extends StatelessWidget {
  const _WotpRecipeConditionalSkip();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Recipe 4 — Conditional skipping',
      subtitle: 'ExcludeFocus & ExcludeFocusTraversal',
      icon: Icons.visibility_off_rounded,
      accent: _kGoldDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'For conditional exclusion of an entire subtree, wrap it in '
            'ExcludeFocusTraversal(excluding: true, child: …). WidgetOrder\'s '
            'sortDescendants will omit those descendants while still allowing '
            'ExcludeFocus(excluding: false, …) siblings to participate.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          _WotpCodeBlock(
            code: 'ExcludeFocusTraversal(\n'
                '  excluding: _readonlyMode,\n'
                '  child: advancedControls,\n'
                ');',
          ),
          _WotpBullet(
            text: 'Useful for wizards, accordions, and modal drawers: hide '
                'the collapsed section from Tab until expanded.',
          ),
          _WotpBullet(
            text: 'For full focus blocking (not just traversal) use '
                'ExcludeFocus, which also prevents requestFocus from '
                'entering the subtree.',
          ),
        ],
      ),
    );
  }
}

class _WotpRecipeDpad extends StatelessWidget {
  const _WotpRecipeDpad();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Recipe 5 — DPad / remote navigation',
      subtitle: 'Arrow keys on TV / game controller',
      icon: Icons.gamepad_rounded,
      accent: _kAccentTeal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'TV and game-controller apps navigate with arrow / DPad keys. '
            'WidgetOrderTraversalPolicy inherits '
            'DirectionalFocusTraversalPolicyMixin, so arrow keys just work. '
            'Wrap your root in Shortcuts/Actions to translate additional '
            'keys (e.g. gamepad DPad) into TraversalDirection.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          _WotpCodeBlock(
            code: 'Shortcuts(\n'
                '  shortcuts: const <ShortcutActivator, Intent>{\n'
                '    SingleActivator(LogicalKeyboardKey.gameButtonA):\n'
                '        ActivateIntent(),\n'
                '    SingleActivator(LogicalKeyboardKey.arrowUp):\n'
                '        DirectionalFocusIntent(TraversalDirection.up),\n'
                '    SingleActivator(LogicalKeyboardKey.arrowDown):\n'
                '        DirectionalFocusIntent(TraversalDirection.down),\n'
                '  },\n'
                '  child: FocusTraversalGroup(\n'
                '    policy: WidgetOrderTraversalPolicy(),\n'
                '    child: appRoot,\n'
                '  ),\n'
                ');',
          ),
        ],
      ),
    );
  }
}

class _WotpRecipeNestedGroups extends StatelessWidget {
  const _WotpRecipeNestedGroups();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Recipe 6 — Nested traversal groups',
      subtitle: 'Composable Tab order',
      icon: Icons.layers_rounded,
      accent: _kMaroonLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Nested FocusTraversalGroups form a tree. Tab traverses the '
            'outer group; when focus enters a nested group, Tab walks the '
            'inner group\'s sortDescendants. When the inner group is '
            'exhausted, Tab resumes in the outer group.',
            style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
          ),
          _WotpCodeBlock(
            code: 'FocusTraversalGroup(\n'
                '  policy: WidgetOrderTraversalPolicy(),\n'
                '  child: Column(\n'
                '    children: [\n'
                '      outerA,\n'
                '      FocusTraversalGroup(\n'
                '        // inner group can use a different policy.\n'
                '        policy: ReadingOrderTraversalPolicy(),\n'
                '        child: Wrap(children: [i1, i2, i3]),\n'
                '      ),\n'
                '      outerB,\n'
                '    ],\n'
                '  ),\n'
                ');',
          ),
          _WotpBullet(
            text: 'Tab order: outerA → i1 → i2 → i3 → outerB.',
          ),
          _WotpBullet(
            text: 'Mix policies freely — WidgetOrder outside, Reading '
                'inside a Wrap, Ordered inside a grid with markers.',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 8 — Glossary / epilogue.
// ─────────────────────────────────────────────────────────────────────────────

class _WotpGlossaryTab extends StatelessWidget {
  const _WotpGlossaryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 40),
      children: const [
        _WotpGlossaryHeader(),
        _WotpGlossaryEntries(),
        _WotpGlossaryCrossReferences(),
        _WotpGlossaryEpilogue(),
      ],
    );
  }
}

class _WotpGlossaryHeader extends StatelessWidget {
  const _WotpGlossaryHeader();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Glossary',
      subtitle: 'Tiny dictionary of terms used across this demo',
      icon: Icons.spellcheck_rounded,
      accent: _kMaroonDeep,
      child: const Text(
        'The terms below appear throughout the Flutter focus system. '
        'Knowing them makes WidgetOrderTraversalPolicy feel obvious — it is '
        'just one of several policies that share a common vocabulary.',
        style: TextStyle(fontSize: 13, height: 1.5, color: _kInk),
      ),
    );
  }
}

class _WotpGlossaryEntries extends StatelessWidget {
  const _WotpGlossaryEntries();

  @override
  Widget build(BuildContext context) {
    const entries = <_WotpGlossaryEntry>[
      _WotpGlossaryEntry(
        term: 'FocusNode',
        definition:
            'A node in the focus tree. Owns attach/detach lifecycle and '
            'listeners. Has properties hasFocus, hasPrimaryFocus, '
            'skipTraversal, canRequestFocus, and debugLabel.',
      ),
      _WotpGlossaryEntry(
        term: 'FocusScopeNode',
        definition:
            'A FocusNode subtype representing a scope. Knows its '
            'focusedChild — the descendant that will be refocused when the '
            'scope regains focus.',
      ),
      _WotpGlossaryEntry(
        term: 'FocusManager',
        definition:
            'Singleton that orchestrates all focus traffic. '
            'FocusManager.instance.primaryFocus returns the node that '
            'currently owns input.',
      ),
      _WotpGlossaryEntry(
        term: 'FocusTraversalPolicy',
        definition:
            'Abstract base class that defines sortDescendants, '
            'findFirstFocus, findLastFocus, next, previous, and '
            'inDirection. WidgetOrderTraversalPolicy is one of its '
            'concrete subclasses.',
      ),
      _WotpGlossaryEntry(
        term: 'FocusTraversalGroup',
        definition:
            'The scope that ties a FocusTraversalPolicy to a subtree. '
            'Without it, the ambient policy (default: '
            'ReadingOrderTraversalPolicy in some platforms; WidgetOrder '
            'by default in framework code) applies.',
      ),
      _WotpGlossaryEntry(
        term: 'FocusTraversalOrder',
        definition:
            'A marker InheritedWidget that attaches a FocusOrder '
            '(NumericFocusOrder or LexicalFocusOrder) to a descendant '
            'focus node. Read only by OrderedTraversalPolicy.',
      ),
      _WotpGlossaryEntry(
        term: 'DirectionalFocusTraversalPolicyMixin',
        definition:
            'Provides inDirection — the arrow-key / DPad algorithm. '
            'Mixed into WidgetOrderTraversalPolicy, '
            'ReadingOrderTraversalPolicy, and OrderedTraversalPolicy.',
      ),
      _WotpGlossaryEntry(
        term: 'TraversalDirection',
        definition:
            'Enum with up, down, left, right. Consumed by focusInDirection '
            'and DirectionalFocusIntent.',
      ),
      _WotpGlossaryEntry(
        term: 'skipTraversal',
        definition:
            'FocusNode flag. true means sortDescendants omits this node '
            'from Tab navigation; requestFocus still works.',
      ),
      _WotpGlossaryEntry(
        term: 'ExcludeFocusTraversal',
        definition:
            'Widget that excludes a subtree from traversal while keeping '
            'it focusable programmatically.',
      ),
      _WotpGlossaryEntry(
        term: 'ExcludeFocus',
        definition:
            'Widget that fully removes a subtree from the focus system — '
            'neither traversal nor requestFocus works.',
      ),
      _WotpGlossaryEntry(
        term: 'FocusableActionDetector',
        definition:
            'Widget that combines Focus + Actions + Shortcuts + '
            'MouseRegion — the building block for keyboard-operable '
            'components.',
      ),
      _WotpGlossaryEntry(
        term: 'requestFocusCallback',
        definition:
            'Optional callback passed to the policy constructor. Lets '
            'you customize how focus is requested (e.g., to trigger a '
            'scroll-into-view).',
      ),
    ];
    return _WotpCard(
      title: 'Terms',
      subtitle: '${entries.length} definitions',
      icon: Icons.list_rounded,
      accent: _kGoldDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final e in entries) _WotpGlossaryRow(entry: e),
        ],
      ),
    );
  }
}

class _WotpGlossaryEntry {
  const _WotpGlossaryEntry({required this.term, required this.definition});
  final String term;
  final String definition;
}

class _WotpGlossaryRow extends StatelessWidget {
  const _WotpGlossaryRow({required this.entry});
  final _WotpGlossaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kParchmentDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: _kGoldDeep, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.term,
            style: const TextStyle(
              color: _kMaroonDeep,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              letterSpacing: 0.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              entry.definition,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WotpGlossaryCrossReferences extends StatelessWidget {
  const _WotpGlossaryCrossReferences();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Cross-references',
      subtitle: 'Where to read next',
      icon: Icons.link_rounded,
      accent: _kAccentTeal,
      child: Wrap(
        children: const [
          _WotpTag(label: 'FocusNode', color: _kMaroon),
          _WotpTag(label: 'FocusScopeNode', color: _kMaroon),
          _WotpTag(label: 'FocusManager', color: _kMaroon),
          _WotpTag(label: 'FocusTraversalGroup', color: _kAccentTeal),
          _WotpTag(label: 'FocusTraversalPolicy', color: _kAccentTeal),
          _WotpTag(label: 'FocusTraversalOrder', color: _kAccentRose),
          _WotpTag(label: 'NumericFocusOrder', color: _kAccentRose),
          _WotpTag(label: 'LexicalFocusOrder', color: _kAccentRose),
          _WotpTag(label: 'DirectionalFocusTraversalPolicyMixin',
              color: _kGoldDeep),
          _WotpTag(label: 'TraversalDirection', color: _kGoldDeep),
          _WotpTag(label: 'ExcludeFocus', color: _kMaroonLight),
          _WotpTag(label: 'ExcludeFocusTraversal', color: _kMaroonLight),
          _WotpTag(label: 'FocusableActionDetector', color: _kMaroonDeep),
          _WotpTag(
            label: 'WidgetOrderTraversalPolicy',
            color: _kGold,
            textColor: _kMaroonDeep,
          ),
        ],
      ),
    );
  }
}

class _WotpGlossaryEpilogue extends StatelessWidget {
  const _WotpGlossaryEpilogue();

  @override
  Widget build(BuildContext context) {
    return _WotpCard(
      title: 'Epilogue — the conductor lowers the baton',
      subtitle: 'Closing thoughts',
      icon: Icons.nights_stay_rounded,
      accent: _kMaroonDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'WidgetOrderTraversalPolicy is the policy you reach for when '
            'you want Tab order to mirror source code. It is the default '
            'behaviour for FocusTraversalGroup without an explicit policy, '
            'and it plays nicely with arrow keys because of the directional '
            'mixin baked into the base class.',
            style: TextStyle(fontSize: 13, height: 1.6, color: _kInk),
          ),
          SizedBox(height: 8),
          Text(
            'If your layout is a plain Column or a row-major Wrap, Widget '
            'order will feel identical to Reading order — a useful coincidence '
            'that lets you enable RTL later by swapping the policy, not the '
            'tree. If your tree declares widgets out of visual order (Stacks, '
            'Positioned, overlays), prefer Reading order so focus follows the '
            'eye. If you need hand-authored Tab order, reach for '
            'OrderedTraversalPolicy and its FocusTraversalOrder markers.',
            style: TextStyle(fontSize: 13, height: 1.6, color: _kInk),
          ),
          SizedBox(height: 12),
          _WotpBullet(
            text: 'Keep the widget tree readable — traversal will follow.',
          ),
          _WotpBullet(
            text: 'Prefer skipTraversal for single-node exclusions, '
                'ExcludeFocusTraversal for subtree exclusions.',
          ),
          _WotpBullet(
            text: 'Use DirectionalFocusIntent for arrow keys; Tab continues '
                'to use the policy\'s widget-order sort.',
          ),
          _WotpBullet(
            text: 'Remember: no policy is universally best. Match the '
                'policy to user expectation, not to convenience.',
          ),
          SizedBox(height: 12),
          Text(
            '— finis —',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: _kGoldDeep,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
