// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// flow_test.dart
// =====================================================================
// A deep visual demo of the Flutter `Flow` widget, hand-authored for the
// d4rt analyzer-free interpreter test app. Because the d4rt interpreter
// cannot coerce a user subclass back through a bridged abstract type
// (priority-1 broken cluster), we DO NOT subclass FlowDelegate here.
// Instead each section depicts the visual output that a real
// FlowDelegate.paintChildren would produce, using static Stack +
// Positioned + Transform compositions, accompanied by an inline code
// snippet (rendered as monospaced Text) so the demo doubles as a
// teaching reference.
// =====================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// SECTION DATA CLASSES
// ---------------------------------------------------------------------
// Lightweight const-friendly value carriers used by the visual sections.
// Keeping these top-level avoids closure-captured data and makes the
// composition fully declarative — which keeps the d4rt interpreter
// happy.
// ---------------------------------------------------------------------

class _RadialEntry {
  final IconData icon;
  final Color tint;
  final String label;
  const _RadialEntry(this.icon, this.tint, this.label);
}

class _FanCard {
  final String title;
  final String subtitle;
  final Color base;
  const _FanCard(this.title, this.subtitle, this.base);
}

class _CascadeTile {
  final String letter;
  final Color top;
  final Color bottom;
  const _CascadeTile(this.letter, this.top, this.bottom);
}

class _HexCell {
  final String label;
  final Color color;
  final double weight; // 0..1 — affects opacity
  const _HexCell(this.label, this.color, this.weight);
}

class _ParallaxLayer {
  final String title;
  final double depth; // simulated z translation, 0 = far, 1 = near
  final Color tint;
  final IconData icon;
  const _ParallaxLayer(this.title, this.depth, this.tint, this.icon);
}

class _ApiRow {
  final String name;
  final String signature;
  final String purpose;
  const _ApiRow(this.name, this.signature, this.purpose);
}

class _ComparisonRow {
  final String widget;
  final String layoutModel;
  final String repaintCost;
  final String bestFor;
  const _ComparisonRow(this.widget, this.layoutModel, this.repaintCost, this.bestFor);
}

class _TipCard {
  final String title;
  final String body;
  final IconData icon;
  final Color accent;
  const _TipCard(this.title, this.body, this.icon, this.accent);
}

// ---------------------------------------------------------------------
// SHARED STYLE TOKENS
// ---------------------------------------------------------------------
// Centralising paint values keeps the script visually consistent without
// the price of a const ThemeData (which the interpreter would have to
// rehydrate eagerly).
// ---------------------------------------------------------------------

const Color _kInk = Color(0xFF0E1422);
const Color _kCanvas = Color(0xFFF6F4EE);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kSubtle = Color(0xFF6F7689);
const Color _kAccent = Color(0xFF4F46E5);
const Color _kHotPink = Color(0xFFEC4899);
const Color _kTeal = Color(0xFF0EA5A4);
const Color _kAmber = Color(0xFFF59E0B);
const Color _kEmerald = Color(0xFF10B981);
const Color _kCobalt = Color(0xFF1D4ED8);
const Color _kSlate = Color(0xFF1F2937);

const TextStyle _kMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  height: 1.45,
  color: Color(0xFFE6EDF3),
);

// =====================================================================
// ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  print('[flow_test] === BEGIN deep visual demo of Flutter Flow widget ===');
  print('[flow_test] interpreter mode: depicting paintChildren output via Stack + Transform');

  final List<Widget> sections = <Widget>[
    _buildPageHeader(),
    _buildAnatomyDiagram(),
    _buildRadialMenuSection(),
    _buildFanOutSection(),
    _buildCascadeSection(),
    _buildHexGridSection(),
    _buildParallaxSection(),
    _buildFlowDelegateApiCard(),
    _buildComparisonTable(),
    _buildWhenToUseTipCards(),
    _buildPaintChildrenWalkthrough(),
    _buildFooter(),
  ];

  print('[flow_test] composed ${sections.length} top-level sections');

  return Scaffold(
    backgroundColor: _kCanvas,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 0 — PAGE HEADER
// =====================================================================

Widget _buildPageHeader() {
  print('[flow_test] section 0: page header');
  return Container(
    margin: const EdgeInsets.only(bottom: 28),
    padding: const EdgeInsets.fromLTRB(28, 30, 28, 32),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF111827), Color(0xFF1E293B), Color(0xFF312E81)],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withValues(alpha: 0.35),
          blurRadius: 28,
          offset: const Offset(0, 18),
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
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFF4F46E5), Color(0xFFEC4899)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _kAccent.withValues(alpha: 0.45),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(Icons.scatter_plot, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Flutter Flow',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Custom-painted children driven by FlowDelegate.paintChildren',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFFCBD5E1),
                      height: 1.35,
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
          children: <Widget>[
            _headerPill('decoupled layout & paint', _kAccent),
            _headerPill('repaint without relayout', _kHotPink),
            _headerPill('per-child transform matrix', _kAmber),
            _headerPill('paintChildren driven', _kEmerald),
          ],
        ),
      ],
    ),
  );
}

Widget _headerPill(String text, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(999),
      color: tint.withValues(alpha: 0.18),
      border: Border.all(color: tint.withValues(alpha: 0.55), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: tint,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 1 — WHAT FLOW IS FOR — ANATOMY DIAGRAM
// =====================================================================

Widget _buildAnatomyDiagram() {
  print('[flow_test] section 1: anatomy diagram');
  return _section(
    badge: '01 ANATOMY',
    title: 'What is the Flow widget for?',
    summary:
        'Flow gives you a custom delegate that paints each child with its own '
        'transform matrix. Layout is computed once; transforms can be repainted '
        'without re-running layout — ideal for high-frequency animation of many '
        'children that share constraints.',
    body: Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 230,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          _kAccent.withValues(alpha: 0.06),
                          _kHotPink.withValues(alpha: 0.06),
                        ],
                      ),
                      border: Border.all(color: _kAccent.withValues(alpha: 0.18)),
                    ),
                  ),
                ),
                const Positioned(
                  top: 14,
                  left: 18,
                  child: Text(
                    'parent box (Flow)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _kAccent,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 60,
                  child: _anatomyChild('child #0', Icons.tag, _kCobalt, 1.0, 0),
                ),
                Positioned(
                  left: 130,
                  top: 110,
                  child: _anatomyChild('child #1', Icons.bolt, _kHotPink, 0.92, -0.18),
                ),
                Positioned(
                  left: 220,
                  top: 60,
                  child: _anatomyChild('child #2', Icons.api, _kAmber, 1.04, 0.12),
                ),
                Positioned(
                  left: 310,
                  top: 130,
                  child: _anatomyChild('child #3', Icons.auto_awesome, _kEmerald, 0.86, 0.32),
                ),
                Positioned(
                  right: 22,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _kInk,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'paintChild(i, transform: M_i)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _codeCard(
            title: 'Equivalent FlowDelegate sketch',
            lines: const <String>[
              'class _Demo extends FlowDelegate {',
              '  @override',
              '  void paintChildren(FlowPaintingContext ctx) {',
              '    for (int i = 0; i < ctx.childCount; i++) {',
              '      final m = Matrix4.identity()',
              '        ..translate(positions[i].dx, positions[i].dy)',
              '        ..scale(scales[i])',
              '        ..rotateZ(angles[i]);',
              '      ctx.paintChild(i, transform: m);',
              '    }',
              '  }',
              '  @override',
              '  bool shouldRepaint(covariant _Demo old) =>',
              '    old.positions != positions || old.scales != scales;',
              '}',
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _anatomyChild(String name, IconData icon, Color tint, double scale, double rotation) {
  return Transform.rotate(
    angle: rotation,
    child: Transform.scale(
      scale: scale,
      child: Container(
        width: 86,
        height: 76,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              tint.withValues(alpha: 0.95),
              tint.withValues(alpha: 0.55),
            ],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: tint.withValues(alpha: 0.38),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 2 — RADIAL / ORBITAL MENU
// =====================================================================

Widget _buildRadialMenuSection() {
  print('[flow_test] section 2: radial / orbital menu');

  final List<_RadialEntry> entries = <_RadialEntry>[
    _RadialEntry(Icons.home_filled, _kAccent, 'home'),
    _RadialEntry(Icons.search, _kHotPink, 'search'),
    _RadialEntry(Icons.favorite, _kAmber, 'love'),
    _RadialEntry(Icons.notifications, _kEmerald, 'alerts'),
    _RadialEntry(Icons.bookmark, _kCobalt, 'save'),
    _RadialEntry(Icons.share, _kTeal, 'share'),
    _RadialEntry(Icons.settings, _kSlate, 'settings'),
    _RadialEntry(Icons.person, _kHotPink, 'profile'),
  ];

  // Pick a fixed t — represents an AlwaysStoppedAnimation<double>(t).
  const double t = 0.85;
  const double radius = 110;
  const Offset center = Offset(180, 150);

  final List<Widget> orbiters = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final _RadialEntry entry = entries[i];
    final double slice = (math.pi * 2) / entries.length;
    final double angle = slice * i - math.pi / 2;
    final double dx = center.dx + math.cos(angle) * radius * t;
    final double dy = center.dy + math.sin(angle) * radius * t;

    orbiters.add(
      Positioned(
        left: dx - 28,
        top: dy - 28,
        child: Transform.rotate(
          angle: angle + math.pi / 2,
          child: _orbitalNode(entry),
        ),
      ),
    );
  }

  return _section(
    badge: '02 RADIAL',
    title: 'Radial / orbital menu',
    summary:
        'A classic Flow use case. Each child sits on a circle around an anchor. '
        'When animated, only the transform matrices change — children never '
        'relayout, so it stays smooth even with many entries.',
    body: Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 320,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const RadialGradient(
                        colors: <Color>[Color(0xFFFDF2F8), Color(0xFFFEF3C7)],
                        radius: 0.9,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _OrbitRingPainter(center: center, radius: radius * t),
                  ),
                ),
                Positioned(
                  left: center.dx - 36,
                  top: center.dy - 36,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: <Color>[Color(0xFF4F46E5), Color(0xFFEC4899)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _kAccent.withValues(alpha: 0.4),
                          blurRadius: 22,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 32),
                  ),
                ),
                ...orbiters,
                Positioned(
                  right: 14,
                  top: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _kInk.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      't = 0.85 (AlwaysStoppedAnimation)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _codeCard(
            title: 'paintChildren — radial layout',
            lines: const <String>[
              'void paintChildren(FlowPaintingContext ctx) {',
              '  final n = ctx.childCount;',
              '  final r = radius * progress.value;',
              '  for (int i = 0; i < n; i++) {',
              '    final a = (2 * pi / n) * i - pi / 2;',
              '    final dx = ctx.size.width  / 2 + cos(a) * r;',
              '    final dy = ctx.size.height / 2 + sin(a) * r;',
              '    ctx.paintChild(i,',
              '      transform: Matrix4.identity()',
              '        ..translate(dx - 28, dy - 28)',
              '        ..rotateZ(a + pi / 2));',
              '  }',
              '}',
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _orbitalNode(_RadialEntry entry) {
  return Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: entry.tint.withValues(alpha: 0.45),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
      border: Border.all(color: entry.tint.withValues(alpha: 0.65), width: 2),
    ),
    child: Icon(entry.icon, color: entry.tint, size: 24),
  );
}

class _OrbitRingPainter extends CustomPainter {
  final Offset center;
  final double radius;
  const _OrbitRingPainter({required this.center, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dashed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = _kAccent.withValues(alpha: 0.45);
    const int segments = 60;
    for (int i = 0; i < segments; i++) {
      if (i.isOdd) continue;
      final double a0 = (math.pi * 2) * (i / segments);
      final double a1 = (math.pi * 2) * ((i + 1) / segments);
      final Offset p0 = Offset(center.dx + math.cos(a0) * radius, center.dy + math.sin(a0) * radius);
      final Offset p1 = Offset(center.dx + math.cos(a1) * radius, center.dy + math.sin(a1) * radius);
      canvas.drawLine(p0, p1, dashed);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitRingPainter old) => old.radius != radius || old.center != center;
}

// =====================================================================
// SECTION 3 — FAN-OUT CARDS
// =====================================================================

Widget _buildFanOutSection() {
  print('[flow_test] section 3: fan-out cards');

  final List<_FanCard> cards = <_FanCard>[
    _FanCard('Discover',  'curated picks',     _kAccent),
    _FanCard('Trending',  'hot this week',     _kHotPink),
    _FanCard('For you',   'tuned to taste',    _kAmber),
    _FanCard('Friends',   'social activity',   _kEmerald),
    _FanCard('Saved',     'your library',      _kCobalt),
  ];

  const double fanRadius = 200;
  const double spread = math.pi / 2.4; // total angular spread
  const Offset pivot = Offset(180, 280);

  final List<Widget> fanned = <Widget>[];
  for (int i = 0; i < cards.length; i++) {
    final _FanCard card = cards[i];
    final double t = cards.length == 1 ? 0.5 : i / (cards.length - 1);
    final double angle = -spread / 2 + spread * t;
    final double dx = pivot.dx + math.sin(angle) * fanRadius - 70;
    final double dy = pivot.dy - math.cos(angle) * fanRadius;
    fanned.add(
      Positioned(
        left: dx,
        top: dy,
        child: Transform.rotate(
          angle: angle,
          alignment: Alignment.bottomCenter,
          child: _fanCard(card),
        ),
      ),
    );
  }

  return _section(
    badge: '03 FAN-OUT',
    title: 'Fan-out cards',
    summary:
        'Cards rotate around a virtual pivot below the visible area, like a deck '
        'of playing cards held in one hand. paintChildren computes a rotation + '
        'translation matrix per card; layout never re-runs.',
    body: Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 290,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Color(0xFFEEF2FF), Color(0xFFFDF2F8)],
                      ),
                    ),
                  ),
                ),
                ...fanned,
                Positioned(
                  left: pivot.dx - 6,
                  top: pivot.dy - 6,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _kInk,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                Positioned(
                  left: pivot.dx + 14,
                  top: pivot.dy - 8,
                  child: const Text(
                    'pivot',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      color: _kInk,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _codeCard(
            title: 'paintChildren — fan-out',
            lines: const <String>[
              'void paintChildren(FlowPaintingContext ctx) {',
              '  final n = ctx.childCount;',
              '  for (int i = 0; i < n; i++) {',
              '    final t = n == 1 ? 0.5 : i / (n - 1);',
              '    final a = -spread/2 + spread * t;',
              '    final m = Matrix4.identity()',
              '      ..translate(pivot.dx + sin(a)*radius - 70,',
              '                  pivot.dy - cos(a)*radius)',
              '      ..rotateZ(a);',
              '    ctx.paintChild(i, transform: m);',
              '  }',
              '}',
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _fanCard(_FanCard card) {
  return Container(
    width: 140,
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          card.base.withValues(alpha: 0.95),
          card.base.withValues(alpha: 0.65),
        ],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: card.base.withValues(alpha: 0.4),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ],
      border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.4),
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.style, color: Colors.white, size: 20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              card.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              card.subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 4 — STAGGERED CASCADE TILES
// =====================================================================

Widget _buildCascadeSection() {
  print('[flow_test] section 4: staggered cascade tiles');

  final List<_CascadeTile> tiles = <_CascadeTile>[
    _CascadeTile('A', _kAccent,  _kCobalt),
    _CascadeTile('B', _kHotPink, _kAmber),
    _CascadeTile('C', _kAmber,   _kEmerald),
    _CascadeTile('D', _kEmerald, _kTeal),
    _CascadeTile('E', _kTeal,    _kAccent),
    _CascadeTile('F', _kCobalt,  _kHotPink),
    _CascadeTile('G', _kSlate,   _kAccent),
    _CascadeTile('H', _kHotPink, _kEmerald),
  ];

  // Stagger by index — fixed t per tile reads as a "frozen frame" of the
  // typical Flow staircase.
  const double cellW = 78;
  const double cellH = 78;

  final List<Widget> staircase = <Widget>[];
  for (int i = 0; i < tiles.length; i++) {
    final _CascadeTile tile = tiles[i];
    final double x = i * (cellW * 0.55);
    final double y = i * 14.0 + math.sin(i.toDouble() * 0.7) * 8.0 + 30.0;
    final double scale = 1.0 - (i * 0.03);
    final double rot = math.sin(i.toDouble() * 0.5) * 0.06;
    staircase.add(
      Positioned(
        left: x,
        top: y,
        child: Transform.rotate(
          angle: rot,
          child: Transform.scale(
            scale: scale,
            child: _cascadeTile(tile, i, cellW, cellH),
          ),
        ),
      ),
    );
  }

  return _section(
    badge: '04 CASCADE',
    title: 'Staggered cascade tiles',
    summary:
        'Each tile gets its own translation, scale and slight rotation. With a '
        'real Flow + AnimationController this turns into a staircase that '
        'cascades on enter. Here we freeze it at one snapshot.',
    body: Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 220,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _kInk.withValues(alpha: 0.04),
                      border: Border.all(color: _kInk.withValues(alpha: 0.08)),
                    ),
                  ),
                ),
                ...staircase,
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              _legendDot(_kAccent, 'index 0..n'),
              const SizedBox(width: 14),
              _legendDot(_kHotPink, 'rotation = sin(i·0.5)·0.06'),
              const SizedBox(width: 14),
              _legendDot(_kEmerald, 'scale = 1 − i·0.03'),
            ],
          ),
          const SizedBox(height: 14),
          _codeCard(
            title: 'paintChildren — cascade',
            lines: const <String>[
              'void paintChildren(FlowPaintingContext ctx) {',
              '  for (int i = 0; i < ctx.childCount; i++) {',
              '    final m = Matrix4.identity()',
              '      ..translate(i * 0.55 * cellW,',
              '                  i * 14 + sin(i*0.7)*8 + 30)',
              '      ..scale(1 - i*0.03)',
              '      ..rotateZ(sin(i*0.5)*0.06);',
              '    ctx.paintChild(i, transform: m);',
              '  }',
              '}',
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _cascadeTile(_CascadeTile tile, int index, double w, double h) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[tile.top, tile.bottom],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tile.top.withValues(alpha: 0.5),
          blurRadius: 12,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            tile.letter,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 22,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'i=$index',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _legendDot(Color color, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(fontSize: 11.5, color: _kSlate, fontFamily: 'monospace')),
    ],
  );
}

// =====================================================================
// SECTION 5 — HEX TILE GRID
// =====================================================================

Widget _buildHexGridSection() {
  print('[flow_test] section 5: hex tile grid');

  final List<_HexCell> cells = <_HexCell>[
    _HexCell('A1', _kAccent,  0.95),
    _HexCell('A2', _kHotPink, 0.85),
    _HexCell('A3', _kAmber,   0.70),
    _HexCell('A4', _kEmerald, 0.55),
    _HexCell('B1', _kCobalt,  0.92),
    _HexCell('B2', _kTeal,    0.78),
    _HexCell('B3', _kAccent,  0.62),
    _HexCell('B4', _kHotPink, 0.50),
    _HexCell('C1', _kAmber,   0.88),
    _HexCell('C2', _kEmerald, 0.74),
    _HexCell('C3', _kCobalt,  0.60),
    _HexCell('C4', _kTeal,    0.45),
    _HexCell('D1', _kSlate,   0.82),
    _HexCell('D2', _kAccent,  0.68),
    _HexCell('D3', _kHotPink, 0.54),
  ];

  const double hexSize = 50;
  const double rowSpacing = 44;
  const double colSpacing = 56;
  const int cols = 5;

  final List<Widget> hexes = <Widget>[];
  for (int i = 0; i < cells.length; i++) {
    final int row = i ~/ cols;
    final int col = i % cols;
    final double x = col * colSpacing + (row.isOdd ? colSpacing / 2 : 0) + 24;
    final double y = row * rowSpacing + 24;
    hexes.add(
      Positioned(
        left: x,
        top: y,
        child: _hexCell(cells[i], hexSize),
      ),
    );
  }

  return _section(
    badge: '05 HEX GRID',
    title: 'Hex tile grid',
    summary:
        'Hex grids stagger every other row by half a cell. Flow shines here '
        'because the layout math is simple but uniform — paintChildren just '
        'computes (col, row) → (x, y) for every child.',
    body: Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xFFFEFCE8), Color(0xFFECFDF5)],
                      ),
                    ),
                  ),
                ),
                ...hexes,
              ],
            ),
          ),
          const SizedBox(height: 14),
          _codeCard(
            title: 'paintChildren — hex grid',
            lines: const <String>[
              'void paintChildren(FlowPaintingContext ctx) {',
              '  for (int i = 0; i < ctx.childCount; i++) {',
              '    final r = i ~/ cols;',
              '    final c = i %  cols;',
              '    final dx = c * colSpacing + (r.isOdd ? colSpacing/2 : 0);',
              '    final dy = r * rowSpacing;',
              '    ctx.paintChild(i, transform:',
              '      Matrix4.identity()..translate(dx, dy));',
              '  }',
              '}',
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _hexCell(_HexCell cell, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: <Color>[
          cell.color.withValues(alpha: cell.weight),
          cell.color.withValues(alpha: cell.weight * 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: Colors.white, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cell.color.withValues(alpha: 0.35),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Text(
        cell.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 6 — PARALLAX DEPTH CARDS
// =====================================================================

Widget _buildParallaxSection() {
  print('[flow_test] section 6: parallax depth cards');

  final List<_ParallaxLayer> layers = <_ParallaxLayer>[
    _ParallaxLayer('Background', 0.0, _kCobalt,  Icons.landscape),
    _ParallaxLayer('Mid clouds', 0.25, _kAccent, Icons.cloud),
    _ParallaxLayer('Mountains',  0.5, _kEmerald, Icons.terrain),
    _ParallaxLayer('Trees',      0.75, _kAmber,  Icons.park),
    _ParallaxLayer('Foreground', 1.0, _kHotPink, Icons.local_florist),
  ];

  const Offset center = Offset(170, 130);

  final List<Widget> stack = <Widget>[];
  for (int i = 0; i < layers.length; i++) {
    final _ParallaxLayer layer = layers[i];
    final double z = layer.depth; // 0..1
    final double offsetX = (z - 0.5) * 60;
    final double offsetY = (z - 0.5) * 24;
    final double scale = 0.7 + z * 0.45;
    final double opacity = 0.35 + z * 0.6;

    stack.add(
      Positioned(
        left: center.dx + offsetX - (140 * scale) / 2,
        top: center.dy + offsetY - (78 * scale) / 2,
        child: Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: scale,
            child: _parallaxCard(layer),
          ),
        ),
      ),
    );
  }

  return _section(
    badge: '06 PARALLAX',
    title: 'Parallax depth cards',
    summary:
        'Simulating z-translation: layers further away are smaller, dimmer and '
        'translated less. Flow lets you bake all of this into one transform '
        'matrix per child — no Stack-of-Stacks rebuild on every frame.',
    body: Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 240,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Color(0xFF0B1225), Color(0xFF1E293B)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'simulated z-axis · zRange=240',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.white70,
                        fontSize: 10.5,
                      ),
                    ),
                  ),
                ),
                ...stack,
              ],
            ),
          ),
          const SizedBox(height: 14),
          _codeCard(
            title: 'paintChildren — parallax z-stack',
            lines: const <String>[
              'void paintChildren(FlowPaintingContext ctx) {',
              '  for (int i = 0; i < ctx.childCount; i++) {',
              '    final z = depths[i];',
              '    final s = 0.7 + z * 0.45;',
              '    final m = Matrix4.identity()',
              '      ..translate(center.dx + (z-0.5) * 60,',
              '                  center.dy + (z-0.5) * 24)',
              '      ..scale(s)',
              '      ..setEntry(3, 2, 0.001) // perspective',
              '      ..translate(0.0, 0.0, -zRange * (1 - z));',
              '    ctx.paintChild(i, transform: m,',
              '      opacity: (0.35 + z * 0.6).clamp(0.0, 1.0));',
              '  }',
              '}',
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _parallaxCard(_ParallaxLayer layer) {
  return Container(
    width: 140,
    height: 78,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          layer.tint,
          layer.tint.withValues(alpha: 0.7),
        ],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 16,
          offset: const Offset(0, 9),
        ),
      ],
    ),
    padding: const EdgeInsets.all(10),
    child: Row(
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(layer.icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                layer.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'z = ${layer.depth.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 7 — FLOWDELEGATE API REFERENCE CARD
// =====================================================================

Widget _buildFlowDelegateApiCard() {
  print('[flow_test] section 7: FlowDelegate API surface');

  final List<_ApiRow> rows = <_ApiRow>[
    _ApiRow(
      'paintChildren',
      'void paintChildren(FlowPaintingContext context)',
      'Required. Iterate ctx.childCount and call ctx.paintChild(i, transform: ..., opacity: ...) for each child.',
    ),
    _ApiRow(
      'getSize',
      'Size getSize(BoxConstraints constraints)',
      'Override to control the Flow widget\'s own size given its parent constraints. Defaults to constraints.biggest.',
    ),
    _ApiRow(
      'shouldRepaint',
      'bool shouldRepaint(covariant FlowDelegate old)',
      'Required. Return true when only paint inputs changed (e.g. an Animation tick). No relayout occurs.',
    ),
    _ApiRow(
      'shouldRelayout',
      'bool shouldRelayout(covariant FlowDelegate old)',
      'Return true when child constraints / sizes must be recomputed. Defaults to false — that is the perf win.',
    ),
    _ApiRow(
      'getConstraintsForChild',
      'BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints)',
      'Override to give a specific child its own BoxConstraints. Otherwise children get parent\'s constraints.',
    ),
  ];

  return _section(
    badge: '07 API',
    title: 'FlowDelegate API surface',
    summary:
        'The five hooks you implement. paintChildren and shouldRepaint are '
        'mandatory; the others have sensible defaults. The interpreter cannot '
        'subclass FlowDelegate, but here is the API you would target.',
    body: Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < rows.length; i++) _apiRow(rows[i], i, rows.length),
          const SizedBox(height: 18),
          _codeCard(
            title: 'Calling Flow in your widget tree',
            lines: const <String>[
              'Flow(',
              '  delegate: _MyDelegate(progress: animation),',
              '  children: <Widget>[',
              '    for (final entry in entries)',
              '      _Bubble(entry: entry),',
              '  ],',
              ')',
              '',
              '// Flow.unwrapped variant exists for cases where you do not want',
              '// the implicit RepaintBoundary around children.',
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _apiRow(_ApiRow row, int index, int total) {
  final bool last = index == total - 1;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: last ? Colors.transparent : _kInk.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _kAccent.withValues(alpha: 0.12),
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: _kAccent,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                row.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                  color: _kInk,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kInk.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  row.signature,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: _kSlate,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                row.purpose,
                style: const TextStyle(
                  color: _kSubtle,
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

// =====================================================================
// SECTION 8 — COMPARISON TABLE
// =====================================================================

Widget _buildComparisonTable() {
  print('[flow_test] section 8: comparison table');

  final List<_ComparisonRow> rows = <_ComparisonRow>[
    _ComparisonRow(
      'Flow',
      'delegate.paintChildren picks transforms',
      'cheap — repaint without relayout',
      'animated transforms over many children',
    ),
    _ComparisonRow(
      'Stack',
      'children laid out by Positioned / alignment',
      'cheap layout, but children rebuild on changes',
      'static overlapping UI, hero-style overlays',
    ),
    _ComparisonRow(
      'Wrap',
      'flow into rows that wrap on overflow',
      'relayout on child size change',
      'tag clouds, chip groups, responsive lists',
    ),
    _ComparisonRow(
      'CustomMultiChildLayout',
      'delegate.performLayout positions LayoutId',
      'relayout per delegate change',
      'complex one-off layouts where layout depends on child sizes',
    ),
  ];

  return _section(
    badge: '08 COMPARE',
    title: 'Flow vs Stack vs Wrap vs CustomMultiChildLayout',
    summary:
        'These four are easy to confuse. The headline: Flow decouples layout '
        'from painting so you can change transforms cheaply, while the others '
        'either hard-bake positions or re-run layout.',
    body: Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        children: <Widget>[
          _comparisonHeaderRow(),
          for (int i = 0; i < rows.length; i++) _comparisonDataRow(rows[i], i),
        ],
      ),
    ),
  );
}

Widget _comparisonHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kInk.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        _comparisonHeaderCell('widget', flex: 2),
        _comparisonHeaderCell('layout model', flex: 3),
        _comparisonHeaderCell('repaint cost', flex: 3),
        _comparisonHeaderCell('best for', flex: 3),
      ],
    ),
  );
}

Widget _comparisonHeaderCell(String text, {required int flex}) {
  return Expanded(
    flex: flex,
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 11,
        color: _kSlate,
        letterSpacing: 1.3,
      ),
    ),
  );
}

Widget _comparisonDataRow(_ComparisonRow row, int index) {
  final bool flow = row.widget == 'Flow';
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: _kInk.withValues(alpha: 0.08), width: 1),
      ),
      color: flow ? _kAccent.withValues(alpha: 0.06) : Colors.transparent,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            row.widget,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: flow ? _kAccent : _kInk,
              fontSize: 13.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(flex: 3, child: _cell(row.layoutModel)),
        Expanded(flex: 3, child: _cell(row.repaintCost)),
        Expanded(flex: 3, child: _cell(row.bestFor)),
      ],
    ),
  );
}

Widget _cell(String text) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        color: _kSlate,
        height: 1.4,
      ),
    ),
  );
}

// =====================================================================
// SECTION 9 — WHEN TO USE FLOW — TIP CARDS
// =====================================================================

Widget _buildWhenToUseTipCards() {
  print('[flow_test] section 9: tip cards');

  final List<_TipCard> tips = <_TipCard>[
    _TipCard(
      'Many children, same constraints',
      'If all children share the same BoxConstraints and you only need to vary '
      'their position/scale/rotation per frame, Flow is the most efficient choice.',
      Icons.dashboard_customize,
      _kAccent,
    ),
    _TipCard(
      'High-frequency animation',
      'Because shouldRepaint=true does NOT trigger relayout, you can drive Flow '
      'from an AnimationController without paying layout cost every tick.',
      Icons.animation,
      _kHotPink,
    ),
    _TipCard(
      'Geometric layouts',
      'Radial menus, fan layouts, hex grids, polar charts — anywhere positions '
      'are computed from a closed-form expression of (i, n, t).',
      Icons.scatter_plot,
      _kAmber,
    ),
    _TipCard(
      'Avoid for content sizing',
      'If the layout itself depends on children\'s intrinsic sizes (e.g. text '
      'wrapping decisions), use Wrap or CustomMultiChildLayout instead.',
      Icons.warning_amber_rounded,
      _kEmerald,
    ),
    _TipCard(
      'Use FlowPaintingContext.paintChild(opacity:)',
      'Per-child opacity is built in. No need to wrap each child in an Opacity '
      'widget — saves a full layer in the engine.',
      Icons.opacity,
      _kCobalt,
    ),
    _TipCard(
      'Keep paintChildren pure',
      'Treat paintChildren like a render function: read inputs, paint, return. '
      'Mutating state inside paintChildren leads to subtle frame skips.',
      Icons.functions,
      _kTeal,
    ),
  ];

  // Two-column grid using Wrap for natural responsive break.
  return _section(
    badge: '09 TIPS',
    title: 'When to reach for Flow',
    summary:
        'Six rules of thumb — print these on a sticky note for quick reference '
        'next time the team is choosing between Stack, Wrap and Flow.',
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        for (int i = 0; i < tips.length; i++)
          SizedBox(
            width: 320,
            child: _tipCard(tips[i], i),
          ),
      ],
    ),
  );
}

Widget _tipCard(_TipCard tip, int index) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: _kCard,
      border: Border.all(color: tip.accent.withValues(alpha: 0.32), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tip.accent.withValues(alpha: 0.12),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: <Color>[
                tip.accent,
                tip.accent.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(tip.icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: tip.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'tip ${index + 1}',
                      style: TextStyle(
                        color: tip.accent,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                tip.title,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                tip.body,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _kSubtle,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 10 — paintChildren WALKTHROUGH (DARK CODE CARD)
// =====================================================================

Widget _buildPaintChildrenWalkthrough() {
  print('[flow_test] section 10: paintChildren walkthrough');

  return _section(
    badge: '10 WALKTHROUGH',
    title: 'Inside paintChildren — step by step',
    summary:
        'A full annotated example. The signature, the loop, the matrix '
        'composition, and the sneaky parts: opacity, child clipping, and the '
        'shouldRepaint contract.',
    body: Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF0F172A), Color(0xFF1E1B4B)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F57),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF28C840),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'flow_delegate.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Color(0xFFE6EDF3),
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _codeLine('1', 'class _RadialMenuDelegate extends FlowDelegate {', _kHotPink),
          _codeLine('2', '  _RadialMenuDelegate({required this.progress, required this.radius})', _kInk),
          _codeLine('3', '      : super(repaint: progress);  // listen for ticks', _kAmber),
          _codeLine('4', '', _kInk),
          _codeLine('5', '  final Animation<double> progress;', _kInk),
          _codeLine('6', '  final double radius;', _kInk),
          _codeLine('7', '', _kInk),
          _codeLine('8', '  @override', _kEmerald),
          _codeLine('9', '  void paintChildren(FlowPaintingContext ctx) {', _kAccent),
          _codeLine('10', '    final n = ctx.childCount;', _kInk),
          _codeLine('11', '    for (int i = 0; i < n; i++) {', _kInk),
          _codeLine('12', '      final a = (2 * pi / n) * i - pi / 2;', _kInk),
          _codeLine('13', '      final r = radius * progress.value;', _kInk),
          _codeLine('14', '      final dx = ctx.size.width  / 2 + cos(a) * r;', _kInk),
          _codeLine('15', '      final dy = ctx.size.height / 2 + sin(a) * r;', _kInk),
          _codeLine('16', '      final m = Matrix4.identity()..translate(dx, dy);', _kInk),
          _codeLine('17', '      ctx.paintChild(i,', _kInk),
          _codeLine('18', '        transform: m,', _kInk),
          _codeLine('19', '        opacity: progress.value);  // per-child opacity!', _kAmber),
          _codeLine('20', '    }', _kInk),
          _codeLine('21', '  }', _kAccent),
          _codeLine('22', '', _kInk),
          _codeLine('23', '  @override', _kEmerald),
          _codeLine('24', '  bool shouldRepaint(covariant _RadialMenuDelegate old) =>', _kAccent),
          _codeLine('25', '    old.radius != radius;  // animation ticks come via repaint:', _kInk),
          _codeLine('26', '', _kInk),
          _codeLine('27', '  @override', _kEmerald),
          _codeLine('28', '  bool shouldRelayout(covariant _RadialMenuDelegate old) => false;', _kAccent),
          _codeLine('29', '}', _kHotPink),
          const SizedBox(height: 18),
          _walkthroughCallout(
            label: 'super(repaint: animation)',
            text: 'Subscribes the delegate to a Listenable. Every tick triggers paint, NOT layout.',
            color: _kAmber,
          ),
          _walkthroughCallout(
            label: 'ctx.paintChild(i, opacity: ...)',
            text: 'Per-child opacity is part of the API. Using Flow this way avoids one Opacity layer per child.',
            color: _kEmerald,
          ),
          _walkthroughCallout(
            label: 'shouldRelayout = false',
            text: 'The whole point of Flow. Children keep their previous Sizes; only paint runs.',
            color: _kHotPink,
          ),
        ],
      ),
    ),
  );
}

Widget _codeLine(String number, String code, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 26,
          child: Text(
            number,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF64748B),
            ),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            code.isEmpty ? ' ' : code,
            style: _kMono.copyWith(
              color: accent == _kInk ? const Color(0xFFE6EDF3) : accent,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _walkthroughCallout({required String label, required String text, required Color color}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 4,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFFE6EDF3),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 11 — FOOTER
// =====================================================================

Widget _buildFooter() {
  print('[flow_test] section 11: footer');
  return Container(
    margin: const EdgeInsets.only(top: 18),
    padding: const EdgeInsets.fromLTRB(28, 26, 28, 26),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF1F5F9), Color(0xFFE0E7FF)],
      ),
      border: Border.all(color: _kAccent.withValues(alpha: 0.18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _kAccent,
              ),
              child: const Icon(Icons.flag, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Text(
                'In summary',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                  color: _kInk,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Flow is Flutter\'s answer to "I have many children, they share constraints, '
          'and I want to animate their transforms cheaply." Implement a FlowDelegate, '
          'override paintChildren and shouldRepaint, pass an Animation via repaint: in '
          'super(), and you get a layout-free per-frame paint pipeline.\n\n'
          'For the d4rt interpreter test app, Flow itself cannot be exercised through a '
          'user subclass of FlowDelegate, so this demo paints the equivalent output '
          'using Stack + Positioned + Transform — the same matrices the real delegate '
          'would emit, just composed declaratively.',
          style: TextStyle(
            color: _kSlate,
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _footerChip('Flow', _kAccent),
            _footerChip('FlowDelegate', _kHotPink),
            _footerChip('FlowPaintingContext', _kAmber),
            _footerChip('paintChildren', _kEmerald),
            _footerChip('Matrix4', _kCobalt),
            _footerChip('shouldRepaint', _kTeal),
          ],
        ),
      ],
    ),
  );
}

Widget _footerChip(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(999),
      color: color.withValues(alpha: 0.14),
      border: Border.all(color: color.withValues(alpha: 0.55)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

// =====================================================================
// SHARED LAYOUT HELPERS
// =====================================================================

Widget _section({
  required String badge,
  required String title,
  required String summary,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _kAccent.withValues(alpha: 0.12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: _kAccent,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 1,
                color: _kInk.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: _kInk,
            letterSpacing: -0.4,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          summary,
          style: const TextStyle(
            color: _kSubtle,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        body,
      ],
    ),
  );
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: _kCard,
    border: Border.all(color: _kInk.withValues(alpha: 0.08)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: _kInk.withValues(alpha: 0.06),
        blurRadius: 18,
        offset: const Offset(0, 10),
      ),
    ],
  );
}

Widget _codeCard({required String title, required List<String> lines}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: const Color(0xFF0F172A),
      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: Color(0xFFFF5F57), shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: Color(0xFFFFBD2E), shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: Color(0xFF28C840), shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFCBD5E1),
                fontSize: 11.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < lines.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 22,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFF475569),
                      fontSize: 10.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    lines[i].isEmpty ? ' ' : lines[i],
                    style: _kMono,
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}
