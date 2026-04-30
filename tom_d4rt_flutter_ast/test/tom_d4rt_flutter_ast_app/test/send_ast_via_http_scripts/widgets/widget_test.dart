import 'dart:math' as math;

import 'package:flutter/material.dart';

// =====================================================================
// Museum of Widgets — Cabinet of Curiosities
// A deep visual tour of Flutter's `Widget` abstract class and its
// extended family: StatelessWidget, StatefulWidget, RenderObjectWidget,
// ProxyWidget, InheritedWidget, and the Key identity system.
//
// This file follows the D4rt AST harness contract:
//   - single top-level `build(BuildContext)` returning a MaterialApp
//   - no main(), no runApp()
//   - self-contained, with all helpers private (_Wgm* prefix)
//   - late fields only inside State.initState() for AnimationControllers
//
// Style: Victorian natural-history museum. Brass-trimmed specimen
// cabinets, deep emerald-green velvet backdrops, ivory label cards,
// and gilded plaques. Two hand-written CustomPainters do the heavy
// visual lifting. One AnimationController drives the lifecycle clock.
// =====================================================================

// ---------------------------------------------------------------------
// Palette — emerald, brass, ivory
// ---------------------------------------------------------------------
const Color _wgmEmeraldDeep = Color(0xFF0B3A2E);
const Color _wgmEmerald = Color(0xFF1A5C48);
const Color _wgmEmeraldBright = Color(0xFF2F8B6B);
const Color _wgmBrass = Color(0xFFC9A24A);
const Color _wgmBrassLight = Color(0xFFE7CB82);
const Color _wgmBrassDark = Color(0xFF8C6B22);
const Color _wgmIvory = Color(0xFFF5EAD3);
const Color _wgmIvoryDim = Color(0xFFE6D8B8);
const Color _wgmInk = Color(0xFF2B1E10);
const Color _wgmWood = Color(0xFF5A3820);
const Color _wgmWoodDark = Color(0xFF3A2414);
const Color _wgmRuby = Color(0xFF8A1C1C);
const Color _wgmVelvet = Color(0xFF123A2C);

// ---------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Museum of Widgets',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _wgmEmeraldDeep,
      primaryColor: _wgmBrass,
      colorScheme: const ColorScheme.dark(
        primary: _wgmBrass,
        secondary: _wgmBrassLight,
        surface: _wgmEmerald,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _wgmIvory, fontSize: 14),
        bodySmall: TextStyle(color: _wgmIvoryDim, fontSize: 12),
        titleLarge: TextStyle(
          color: _wgmBrassLight,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
        titleMedium: TextStyle(
          color: _wgmBrass,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    ),
    home: const _WgmMuseumHome(),
  );
}

// ---------------------------------------------------------------------
// Museum home — scroll container over the backdrop painter
// ---------------------------------------------------------------------
class _WgmMuseumHome extends StatelessWidget {
  const _WgmMuseumHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _wgmEmeraldDeep,
      body: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(
              painter: _WgmCabinetBackdropPainter(),
            ),
          ),
          SafeArea(
            // Fa1 — C22 ListView replacement to avoid the
            // SingleChildScrollView + Column(stretch) infinite-height
            // cascade. Outer ConstrainedBox(maxWidth: 1200) was a
            // design constraint preserved by Center+ConstrainedBox.
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  children: const <Widget>[
                    _WgmMarquee(),
                    SizedBox(height: 28),
                    _WgmSection1Dossier(),
                    SizedBox(height: 36),
                    _WgmSection2Anatomy(),
                    SizedBox(height: 36),
                    _WgmSection3ThreeTree(),
                    SizedBox(height: 36),
                    _WgmSection4SubclassGallery(),
                    SizedBox(height: 36),
                    _WgmSection5KeyPlayground(),
                    SizedBox(height: 36),
                    _WgmSection6Lifecycle(),
                    SizedBox(height: 36),
                    _WgmSection7CanUpdate(),
                    SizedBox(height: 36),
                    _WgmSection8Composition(),
                    SizedBox(height: 36),
                    _WgmSection9Recipes(),
                    SizedBox(height: 36),
                    _WgmSection10Comparison(),
                    SizedBox(height: 36),
                    _WgmSection11Glossary(),
                    SizedBox(height: 48),
                    _WgmColophon(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Marquee — title plaque at the top of the exhibit
// ---------------------------------------------------------------------
class _WgmMarquee extends StatelessWidget {
  const _WgmMarquee();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wgmWoodDark, _wgmWood, _wgmWoodDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wgmBrass, width: 3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: <Color>[_wgmBrassLight, _wgmBrass, _wgmBrassDark],
              ),
              border: Border.all(color: _wgmIvory, width: 2),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'W',
              style: TextStyle(
                color: _wgmInk,
                fontSize: 34,
                fontWeight: FontWeight.w900,
                fontFamily: 'serif',
              ),
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'MUSEUM OF WIDGETS',
                  style: TextStyle(
                    color: _wgmBrassLight,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'A Cabinet of Curiosities for the Abstract Class '
                  'at the Root of the Flutter Tree',
                  style: TextStyle(
                    color: _wgmIvoryDim,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    _WgmBrassPip(),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'est. widgets.dart  ·  package:flutter/widgets.dart',
                        style: TextStyle(
                          color: _wgmBrass,
                          fontFamily: 'monospace',
                          fontSize: 12,
                          letterSpacing: 0.6,
                        ),
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

class _WgmBrassPip extends StatelessWidget {
  const _WgmBrassPip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[_wgmBrassLight, _wgmBrassDark],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Shared UI primitives
// ---------------------------------------------------------------------

class _WgmSectionHeader extends StatelessWidget {
  const _WgmSectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: _wgmEmerald,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _wgmBrass, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: <Color>[_wgmBrassLight, _wgmBrass, _wgmBrassDark],
              ),
              border: Border.all(color: _wgmIvory, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              index.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: _wgmInk,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'serif',
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _wgmBrassLight,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _wgmIvoryDim,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
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

class _WgmCard extends StatelessWidget {
  const _WgmCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.accent = _wgmBrass,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _wgmVelvet,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _WgmLabelCard extends StatelessWidget {
  const _WgmLabelCard({
    required this.title,
    required this.body,
    this.icon,
  });

  final String title;
  final String body;
  final IconData? icon;

  Color get accent => _wgmBrass;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wgmIvory, _wgmIvoryDim],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 16, color: accent),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _wgmInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(height: 1, color: accent.withValues(alpha: 0.4)),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: _wgmInk,
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _WgmCodeBlock extends StatelessWidget {
  const _WgmCodeBlock({required this.code, this.comment});

  final String code;
  final String? comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1A14),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _wgmBrassDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            code,
            style: const TextStyle(
              color: _wgmBrassLight,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.45,
            ),
          ),
          if (comment != null) ...<Widget>[
            const SizedBox(height: 8),
            Text(
              '// $comment',
              style: TextStyle(
                color: _wgmEmeraldBright.withValues(alpha: 0.9),
                fontFamily: 'monospace',
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Cabinet backdrop painter — woodgrain, brass pins, gilt scrollwork
// ---------------------------------------------------------------------
class _WgmCabinetBackdropPainter extends CustomPainter {
  const _WgmCabinetBackdropPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Base emerald wash
    final Paint base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_wgmEmeraldDeep, _wgmVelvet, _wgmEmeraldDeep],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Offset.zero & size, base);

    // Vertical woodgrain panels along the edges
    final Paint plank = Paint()..color = _wgmWoodDark;
    const double panelWidth = 80;
    final Rect leftPanel = Rect.fromLTWH(0, 0, panelWidth, size.height);
    final Rect rightPanel = Rect.fromLTWH(
      size.width - panelWidth,
      0,
      panelWidth,
      size.height,
    );
    canvas.drawRect(leftPanel, plank);
    canvas.drawRect(rightPanel, plank);

    // Grain lines
    final Paint grain = Paint()
      ..color = _wgmWood.withValues(alpha: 0.45)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    final math.Random rng = math.Random(17);
    for (int i = 0; i < 40; i++) {
      final double y = rng.nextDouble() * size.height;
      final Path p1 = Path()
        ..moveTo(4, y)
        ..quadraticBezierTo(
          panelWidth * 0.5,
          y + rng.nextDouble() * 20 - 10,
          panelWidth - 4,
          y + rng.nextDouble() * 10 - 5,
        );
      canvas.drawPath(p1, grain);
      final Path p2 = Path()
        ..moveTo(size.width - panelWidth + 4, y)
        ..quadraticBezierTo(
          size.width - panelWidth * 0.5,
          y + rng.nextDouble() * 20 - 10,
          size.width - 4,
          y + rng.nextDouble() * 10 - 5,
        );
      canvas.drawPath(p2, grain);
    }

    // Brass pins along the panels
    final Paint pinBase = Paint()..color = _wgmBrassDark;
    final Paint pinHi = Paint()..color = _wgmBrassLight;
    for (double y = 30; y < size.height; y += 46) {
      _drawPin(canvas, Offset(panelWidth - 14, y), pinBase, pinHi);
      _drawPin(canvas, Offset(size.width - panelWidth + 14, y), pinBase, pinHi);
    }

    // Gilt scrollwork in the corners
    _drawScroll(canvas, const Offset(110, 40), 52);
    _drawScroll(canvas, Offset(size.width - 110, 40), -52);
    _drawScroll(canvas, Offset(110, size.height - 40), 52, flipY: true);
    _drawScroll(canvas, Offset(size.width - 110, size.height - 40), -52,
        flipY: true);

    // Velvet texture — subtle diagonal hatching
    final Paint hatch = Paint()
      ..color = _wgmEmerald.withValues(alpha: 0.08)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    for (double i = -size.height; i < size.width; i += 18) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), hatch);
    }
  }

  void _drawPin(Canvas canvas, Offset c, Paint base, Paint hi) {
    canvas.drawCircle(c, 4.5, base);
    canvas.drawCircle(c.translate(-1, -1), 1.6, hi);
  }

  void _drawScroll(Canvas canvas, Offset c, double r, {bool flipY = false}) {
    final Paint gold = Paint()
      ..color = _wgmBrass.withValues(alpha: 0.55)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final double sign = flipY ? -1 : 1;
    final Path p = Path()
      ..moveTo(c.dx, c.dy)
      ..quadraticBezierTo(
        c.dx + r * 0.5,
        c.dy - r * 0.6 * sign,
        c.dx + r,
        c.dy - r * 0.2 * sign,
      )
      ..quadraticBezierTo(
        c.dx + r * 1.4,
        c.dy + r * 0.2 * sign,
        c.dx + r * 0.9,
        c.dy + r * 0.7 * sign,
      )
      ..quadraticBezierTo(
        c.dx + r * 0.4,
        c.dy + r * 0.5 * sign,
        c.dx,
        c.dy + r * 0.3 * sign,
      );
    canvas.drawPath(p, gold);
    canvas.drawCircle(c.translate(r * 0.5, -r * 0.1 * sign), 3.0,
        Paint()..color = _wgmBrassLight.withValues(alpha: 0.7));
  }

  @override
  bool shouldRepaint(covariant _WgmCabinetBackdropPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// SECTION 1 — Dossier
// Seven curated label cards describing Widget's essential character
// ---------------------------------------------------------------------
class _WgmSection1Dossier extends StatelessWidget {
  const _WgmSection1Dossier();

  @override
  Widget build(BuildContext context) {
    const List<_WgmDossierEntry> entries = <_WgmDossierEntry>[
      _WgmDossierEntry(
        title: 'I. Abstract Root',
        body: 'Widget is declared `abstract class Widget` and cannot be '
            'instantiated directly. It is the ultimate ancestor of every '
            'UI element in Flutter, from Text to Scaffold to MaterialApp.',
        icon: Icons.account_tree,
      ),
      _WgmDossierEntry(
        title: 'II. Immutable Configuration',
        body: 'A Widget is not the on-screen UI — it is an immutable '
            'description of a configuration. The Element owns the mutable '
            'state, and the RenderObject owns the actual pixels.',
        icon: Icons.lock_outline,
      ),
      _WgmDossierEntry(
        title: 'III. Three-Tree Architecture',
        body: 'Flutter maintains three parallel trees: Widgets (configurations), '
            'Elements (inflated instances), and RenderObjects (layout/paint). '
            'Widgets are frequently discarded; Elements are reused aggressively.',
        icon: Icons.view_column,
      ),
      _WgmDossierEntry(
        title: 'IV. Rebuilds on Replacement',
        body: 'When a parent returns a different Widget instance, the framework '
            'compares runtimeType and key. If compatible, the existing Element is '
            'updated in place with the new Widget; otherwise it is inflated anew.',
        icon: Icons.refresh,
      ),
      _WgmDossierEntry(
        title: 'V. Identity via runtimeType + Key',
        body: 'Widget.canUpdate returns true iff oldWidget.runtimeType == '
            'newWidget.runtimeType && oldWidget.key == newWidget.key. '
            'Keys let you stabilize identity across reshuffles.',
        icon: Icons.vpn_key,
      ),
      _WgmDossierEntry(
        title: 'VI. Five Major Subclass Families',
        body: 'StatelessWidget, StatefulWidget, RenderObjectWidget, ProxyWidget, '
            'and the InheritedWidget / ParentDataWidget tribes that live inside '
            'ProxyWidget. Almost every Flutter type descends from one of these.',
        icon: Icons.family_restroom,
      ),
      _WgmDossierEntry(
        title: 'VII. Common Pitfalls',
        body: 'Do not mutate fields on a built Widget — always replace. Provide '
            'keys for children in dynamic lists. Avoid expensive work in build(). '
            'Never call setState from build() or from an unmounted State.',
        icon: Icons.warning_amber,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 1,
          title: 'DOSSIER',
          subtitle: 'Seven essential facts about the root class of the tree',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final int columns = constraints.maxWidth > 900
                ? 3
                : constraints.maxWidth > 560
                    ? 2
                    : 1;
            return _WgmGrid(
              columns: columns,
              gap: 14,
              children: entries
                  .map((_WgmDossierEntry e) => _WgmLabelCard(
                        title: e.title,
                        body: e.body,
                        icon: e.icon,
                      ))
                  .toList(growable: false),
            );
          },
        ),
      ],
    );
  }
}

class _WgmDossierEntry {
  const _WgmDossierEntry({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final IconData icon;
}

class _WgmGrid extends StatelessWidget {
  const _WgmGrid({
    required this.columns,
    required this.gap,
    required this.children,
  });

  final int columns;
  final double gap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < children.length; i += columns) {
      final List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < columns; j++) {
        if (j > 0) rowChildren.add(SizedBox(width: gap));
        if (i + j < children.length) {
          rowChildren.add(Expanded(child: children[i + j]));
        } else {
          rowChildren.add(const Expanded(child: SizedBox.shrink()));
        }
      }
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rowChildren,
        ),
      ));
      if (i + columns < children.length) {
        rows.add(SizedBox(height: gap));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 2 — Anatomy
// The abstract class signature and its key API surface
// ---------------------------------------------------------------------
class _WgmSection2Anatomy extends StatelessWidget {
  const _WgmSection2Anatomy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 2,
          title: 'ANATOMY',
          subtitle: 'The abstract class, its constructor, and its key members',
        ),
        const SizedBox(height: 16),
        _WgmCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Class declaration',
                style: TextStyle(
                  color: _wgmBrassLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              const _WgmCodeBlock(
                code: 'abstract class Widget with DiagnosticableTreeMixin {\n'
                    '  const Widget({ this.key });\n'
                    '  final Key? key;\n'
                    '  @protected\n'
                    '  Element createElement();\n'
                    '  static bool canUpdate(Widget oldWidget, Widget newWidget) {\n'
                    '    return oldWidget.runtimeType == newWidget.runtimeType\n'
                    '        && oldWidget.key == newWidget.key;\n'
                    '  }\n'
                    '  @override\n'
                    '  String toStringShort() => key == null\n'
                    '      ? \'\$runtimeType\' : \'\$runtimeType-\$key\';\n'
                    '}',
                comment:
                    'Immutable configuration node. Every subclass must supply '
                    'a createElement() implementation.',
              ),
              const SizedBox(height: 18),
              const Text(
                'Key members',
                style: TextStyle(
                  color: _wgmBrassLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final int columns = constraints.maxWidth > 780 ? 2 : 1;
                  return _WgmGrid(
                    columns: columns,
                    gap: 10,
                    children: const <Widget>[
                      _WgmAnatomyRow(
                        member: 'key',
                        kind: 'final Key?',
                        desc: 'Identity marker used by canUpdate. Null by '
                            'default; provide one to stabilize identity.',
                      ),
                      _WgmAnatomyRow(
                        member: 'createElement()',
                        kind: 'Element Function()',
                        desc: 'Factory for the Element backing this Widget. '
                            'The only method every concrete subclass must '
                            'implement.',
                      ),
                      _WgmAnatomyRow(
                        member: 'canUpdate(old,new)',
                        kind: 'static bool',
                        desc: 'Decides whether an existing Element can be '
                            'reused for a new Widget. True iff same type '
                            'and same key.',
                      ),
                      _WgmAnatomyRow(
                        member: 'runtimeType',
                        kind: 'Type',
                        desc: 'Inherited from Object. Together with key '
                            'forms the identity pair the framework checks '
                            'every frame.',
                      ),
                      _WgmAnatomyRow(
                        member: 'toStringShallow()',
                        kind: 'String',
                        desc: 'Debug helper for the Widget Inspector. Shows '
                            'runtimeType plus optional key and joins '
                            'immediate diagnostic properties.',
                      ),
                      _WgmAnatomyRow(
                        member: 'debugFillProperties()',
                        kind: 'void',
                        desc: 'Override to surface properties in the devtools '
                            'inspector. Enables DiagnosticsNode tree.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WgmAnatomyRow extends StatelessWidget {
  const _WgmAnatomyRow({
    required this.member,
    required this.kind,
    required this.desc,
  });

  final String member;
  final String kind;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _wgmEmeraldDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _wgmBrassDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                member,
                style: const TextStyle(
                  color: _wgmBrassLight,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: _wgmBrassDark.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  kind,
                  style: const TextStyle(
                    color: _wgmIvoryDim,
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(
              color: _wgmIvory,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 3 — Three-tree diagram
// Widget tree, Element tree, RenderObject tree side by side
// ---------------------------------------------------------------------
class _WgmSection3ThreeTree extends StatelessWidget {
  const _WgmSection3ThreeTree();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 3,
          title: 'THE THREE TREES',
          subtitle: 'Widget → Element → RenderObject, hand-drawn in three columns',
        ),
        const SizedBox(height: 16),
        _WgmCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'A single Text(\'Hi\') produces three parallel nodes. The '
                'Widget describes, the Element manages, the RenderObject '
                'lays out and paints.',
                style: TextStyle(
                  color: _wgmIvory,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              AspectRatio(
                aspectRatio: 2.1,
                child: CustomPaint(
                  painter: _WgmThreeTreePainter(),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: const <Widget>[
                  _WgmLegendSwatch(color: Color(0xFF3E8EAD), label: 'Widget'),
                  SizedBox(width: 14),
                  _WgmLegendSwatch(color: _wgmBrass, label: 'Element'),
                  SizedBox(width: 14),
                  _WgmLegendSwatch(color: _wgmEmeraldBright, label: 'RenderObject'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WgmLegendSwatch extends StatelessWidget {
  const _WgmLegendSwatch({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: _wgmIvoryDim, width: 0.6),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _wgmIvory,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _WgmThreeTreePainter extends CustomPainter {
  const _WgmThreeTreePainter();

  static const Color _widgetColor = Color(0xFF3E8EAD);
  static const Color _elementColor = _wgmBrass;
  static const Color _renderColor = _wgmEmeraldBright;

  @override
  void paint(Canvas canvas, Size size) {
    // Parchment background
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          _wgmIvory.withValues(alpha: 0.94),
          _wgmIvoryDim.withValues(alpha: 0.94),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final RRect rr =
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8));
    canvas.drawRRect(rr, bg);

    // Column headers
    final double colW = size.width / 3;
    final List<String> headers = <String>['Widget tree', 'Element tree', 'RenderObject tree'];
    final List<Color> headerColors = <Color>[_widgetColor, _elementColor, _renderColor];
    for (int i = 0; i < 3; i++) {
      final Rect headerRect =
          Rect.fromLTWH(colW * i + 10, 12, colW - 20, 28);
      final Paint hp = Paint()..color = headerColors[i];
      canvas.drawRRect(
        RRect.fromRectAndRadius(headerRect, const Radius.circular(6)),
        hp,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: headers[i],
          style: const TextStyle(
            color: _wgmInk,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: colW - 20);
      tp.paint(canvas,
          Offset(colW * i + 10 + (colW - 20 - tp.width) / 2, 18));
    }

    // Nodes — same vertical positions across columns
    final List<_WgmTreeNode> widgetNodes = <_WgmTreeNode>[
      _WgmTreeNode('MaterialApp', 0.18),
      _WgmTreeNode('Scaffold', 0.35),
      _WgmTreeNode('Center', 0.52),
      _WgmTreeNode("Text('Hi')", 0.75),
    ];
    final List<_WgmTreeNode> elementNodes = <_WgmTreeNode>[
      _WgmTreeNode('StatefulElement', 0.18),
      _WgmTreeNode('StatefulElement', 0.35),
      _WgmTreeNode('SingleChildRenderObjectElement', 0.52),
      _WgmTreeNode('LeafRenderObjectElement', 0.75),
    ];
    final List<_WgmTreeNode> renderNodes = <_WgmTreeNode>[
      _WgmTreeNode('(none)', 0.18),
      _WgmTreeNode('(none)', 0.35),
      _WgmTreeNode('RenderPositionedBox', 0.52),
      _WgmTreeNode('RenderParagraph', 0.75),
    ];

    _drawTreeColumn(canvas, size, 0, widgetNodes, _widgetColor);
    _drawTreeColumn(canvas, size, 1, elementNodes, _elementColor);
    _drawTreeColumn(canvas, size, 2, renderNodes, _renderColor);

    // Horizontal "creates / owns" arrows at the Text level
    _drawHorizontalArrow(
      canvas,
      Offset(colW * 0.78, size.height * 0.75),
      Offset(colW * 1.22, size.height * 0.75),
      'createElement()',
    );
    _drawHorizontalArrow(
      canvas,
      Offset(colW * 1.78, size.height * 0.75),
      Offset(colW * 2.22, size.height * 0.75),
      'createRenderObject()',
    );

    // Footer caption
    final TextPainter caption = TextPainter(
      text: const TextSpan(
        text:
            'Widgets are thrown away each frame; Elements persist and are '
            'patched in place; RenderObjects own layout and paint.',
        style: TextStyle(
          color: _wgmInk,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 24);
    caption.paint(canvas, Offset(12, size.height - caption.height - 10));
  }

  void _drawTreeColumn(
    Canvas canvas,
    Size size,
    int col,
    List<_WgmTreeNode> nodes,
    Color color,
  ) {
    final double colW = size.width / 3;
    final double x = colW * col + 20;
    final double w = colW - 40;

    // Connecting spine
    final Paint spine = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    if (nodes.length > 1) {
      canvas.drawLine(
        Offset(x + w / 2, size.height * nodes.first.yFrac + 18),
        Offset(x + w / 2, size.height * nodes.last.yFrac - 6),
        spine,
      );
    }

    for (final _WgmTreeNode n in nodes) {
      final double cy = size.height * n.yFrac;
      final Rect r = Rect.fromCenter(
        center: Offset(x + w / 2, cy),
        width: w,
        height: 28,
      );
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(6));
      final Paint fill = Paint()..color = color.withValues(alpha: 0.18);
      final Paint stroke = Paint()
        ..color = color
        ..strokeWidth = 1.4
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, stroke);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: TextStyle(
            color: _wgmInk.withValues(alpha: 0.95),
            fontSize: 11.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: w - 8);
      tp.paint(canvas, Offset(x + w / 2 - tp.width / 2, cy - tp.height / 2));
    }
  }

  void _drawHorizontalArrow(Canvas canvas, Offset a, Offset b, String label) {
    final Paint line = Paint()
      ..color = _wgmRuby.withValues(alpha: 0.7)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;
    canvas.drawLine(a, b, line);
    // arrowhead
    final Path arrow = Path()
      ..moveTo(b.dx, b.dy)
      ..lineTo(b.dx - 7, b.dy - 4)
      ..lineTo(b.dx - 7, b.dy + 4)
      ..close();
    canvas.drawPath(arrow, Paint()..color = _wgmRuby.withValues(alpha: 0.85));
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: _wgmRuby,
          fontSize: 10,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: (b.dx - a.dx).abs());
    tp.paint(canvas, Offset((a.dx + b.dx) / 2 - tp.width / 2, a.dy - 16));
  }

  @override
  bool shouldRepaint(covariant _WgmThreeTreePainter oldDelegate) => false;
}

class _WgmTreeNode {
  const _WgmTreeNode(this.label, this.yFrac);
  final String label;
  final double yFrac;
}

// ---------------------------------------------------------------------
// SECTION 4 — Subclass gallery
// Five pedestals, each hosting a live example of a subclass family
// ---------------------------------------------------------------------
class _WgmSection4SubclassGallery extends StatelessWidget {
  const _WgmSection4SubclassGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 4,
          title: 'SUBCLASS GALLERY',
          subtitle: 'Five pedestals, each with a living specimen',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final int columns = constraints.maxWidth > 1000
                ? 5
                : constraints.maxWidth > 700
                    ? 3
                    : constraints.maxWidth > 420
                        ? 2
                        : 1;
            final List<Widget> pedestals = <Widget>[
              _WgmPedestal(
                family: 'StatelessWidget',
                scientific: 'Widgeta immutabilis',
                caption: 'Builds purely from constructor fields. '
                    'Its build() is a function of its inputs. No internal state.',
                accent: const Color(0xFF6AA9C4),
                child: const _WgmGreetingCard(name: 'Dr. Hopper'),
              ),
              _WgmPedestal(
                family: 'StatefulWidget',
                scientific: 'Widgeta mutans',
                caption: 'Paired with a State<T> object that holds the '
                    'mutable fields and calls setState() to trigger rebuilds.',
                accent: _wgmBrass,
                child: const _WgmCounterBadge(),
              ),
              _WgmPedestal(
                family: 'RenderObjectWidget',
                scientific: 'Widgeta picta',
                caption: 'A leaf or container that creates a RenderObject '
                    'directly — responsible for layout and paint.',
                accent: _wgmEmeraldBright,
                child: SizedBox(
                  width: 120,
                  height: 60,
                  child: CustomPaint(painter: _WgmSwirlPainter()),
                ),
              ),
              _WgmPedestal(
                family: 'InheritedWidget',
                scientific: 'Widgeta propagans',
                caption: 'Efficiently propagates data down the tree. '
                    'Descendants that depend on it rebuild when it updates.',
                accent: const Color(0xFFB98AC4),
                child: const _WgmThemeInspector(),
              ),
              _WgmPedestal(
                family: 'ProxyWidget',
                scientific: 'Widgeta delegans',
                caption: 'Wraps a single child to contribute metadata. '
                    'IconTheme, DefaultTextStyle, and InheritedWidget all ride on it.',
                accent: const Color(0xFFE09B7A),
                child: IconTheme(
                  data: const IconThemeData(
                    color: _wgmIvory,
                    size: 28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.star),
                      SizedBox(width: 6),
                      Icon(Icons.auto_awesome),
                      SizedBox(width: 6),
                      Icon(Icons.eco),
                    ],
                  ),
                ),
              ),
            ];
            return _WgmGrid(columns: columns, gap: 14, children: pedestals);
          },
        ),
      ],
    );
  }
}

class _WgmPedestal extends StatelessWidget {
  const _WgmPedestal({
    required this.family,
    required this.scientific,
    required this.caption,
    required this.accent,
    required this.child,
  });

  final String family;
  final String scientific;
  final String caption;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[_wgmVelvet, _wgmEmeraldDeep],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Display area
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: _wgmEmeraldDeep.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: accent.withValues(alpha: 0.5)),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Center(child: child),
          ),
          const SizedBox(height: 10),
          // Pedestal base
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _wgmBrassDark,
                  _wgmBrass,
                  _wgmBrassDark,
                ],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              family,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _wgmInk,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            scientific,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accent,
              fontStyle: FontStyle.italic,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _wgmIvoryDim,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// Pedestal exhibit: a StatelessWidget
class _WgmGreetingCard extends StatelessWidget {
  const _WgmGreetingCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wgmIvory, _wgmIvoryDim],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _wgmBrass, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.waving_hand, color: _wgmBrassDark, size: 20),
          const SizedBox(height: 4),
          Text(
            'Hello, $name',
            style: const TextStyle(
              color: _wgmInk,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// Pedestal exhibit: a StatefulWidget
class _WgmCounterBadge extends StatefulWidget {
  const _WgmCounterBadge();

  @override
  State<_WgmCounterBadge> createState() => _WgmCounterBadgeState();
}

class _WgmCounterBadgeState extends State<_WgmCounterBadge> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: <Color>[_wgmBrassLight, _wgmBrass, _wgmBrassDark],
            ),
            border: Border.all(color: _wgmIvory, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            '$_count',
            style: const TextStyle(
              color: _wgmInk,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 24,
          child: ElevatedButton(
            onPressed: () => setState(() => _count++),
            style: ElevatedButton.styleFrom(
              backgroundColor: _wgmBrass,
              foregroundColor: _wgmInk,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(0, 24),
              textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            child: const Text('setState'),
          ),
        ),
      ],
    );
  }
}

// Pedestal exhibit: a RenderObjectWidget (via CustomPaint)
class _WgmSwirlPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = _wgmEmeraldBright;
    final Offset c = Offset(size.width / 2, size.height / 2);
    final Path path = Path();
    for (double t = 0; t < math.pi * 4; t += 0.1) {
      final double r = t * 3;
      final Offset o = c + Offset(math.cos(t) * r, math.sin(t) * r * 0.6);
      if (t == 0) {
        path.moveTo(o.dx, o.dy);
      } else {
        path.lineTo(o.dx, o.dy);
      }
    }
    canvas.drawPath(path, p);
    canvas.drawCircle(c, 3, Paint()..color = _wgmBrassLight);
  }

  @override
  bool shouldRepaint(covariant _WgmSwirlPainter oldDelegate) => false;
}

// Pedestal exhibit: InheritedWidget reader (Theme + MediaQuery)
class _WgmThemeInspector extends StatelessWidget {
  const _WgmThemeInspector();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mq = MediaQuery.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _kvRow('primary', '#${theme.primaryColor.r.toInt().toRadixString(16).padLeft(2, '0')}'
            '${theme.primaryColor.g.toInt().toRadixString(16).padLeft(2, '0')}'
            '${theme.primaryColor.b.toInt().toRadixString(16).padLeft(2, '0')}'),
        _kvRow('dpr', mq.devicePixelRatio.toStringAsFixed(2)),
        _kvRow('pxPerLP', '1.00'),
      ],
    );
  }

  Widget _kvRow(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$k: ',
            style: const TextStyle(
              color: _wgmIvoryDim,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
          Text(
            v,
            style: const TextStyle(
              color: _wgmBrassLight,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 5 — Key identity playground
// Reorder three stateful children with/without ValueKey
// and watch the counters follow (or not) the items
// ---------------------------------------------------------------------
class _WgmSection5KeyPlayground extends StatefulWidget {
  const _WgmSection5KeyPlayground();

  @override
  State<_WgmSection5KeyPlayground> createState() =>
      _WgmSection5KeyPlaygroundState();
}

class _WgmSection5KeyPlaygroundState extends State<_WgmSection5KeyPlayground> {
  List<_WgmKeyItem> _items = <_WgmKeyItem>[
    _WgmKeyItem('Fossil', Icons.auto_stories, const Color(0xFFB98AC4)),
    _WgmKeyItem('Feather', Icons.flutter_dash, const Color(0xFF6AA9C4)),
    _WgmKeyItem('Flower', Icons.local_florist, const Color(0xFFE09B7A)),
  ];
  bool _useKeys = true;

  void _swap(int a, int b) {
    setState(() {
      final _WgmKeyItem tmp = _items[a];
      _items = List<_WgmKeyItem>.from(_items);
      _items[a] = _items[b];
      _items[b] = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 5,
          title: 'KEY IDENTITY PLAYGROUND',
          subtitle: 'Reorder children; watch counters travel — or not',
        ),
        const SizedBox(height: 16),
        _WgmCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.vpn_key, color: _wgmBrassLight, size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Use ValueKey',
                    style: TextStyle(
                      color: _wgmIvory,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: _useKeys,
                    activeThumbColor: _wgmBrassLight,
                    activeTrackColor: _wgmBrass,
                    inactiveThumbColor: _wgmIvoryDim,
                    inactiveTrackColor: _wgmEmeraldDeep,
                    onChanged: (bool v) => setState(() => _useKeys = v),
                  ),
                  const Spacer(),
                  Text(
                    _useKeys
                        ? 'Counters FOLLOW items'
                        : 'Counters STAY at positions',
                    style: TextStyle(
                      color: _useKeys ? _wgmEmeraldBright : _wgmRuby,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < _items.length; i++) ...<Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          _WgmReorderArrows(
                            canLeft: i > 0,
                            canRight: i < _items.length - 1,
                            onLeft: () => _swap(i, i - 1),
                            onRight: () => _swap(i, i + 1),
                          ),
                          const SizedBox(height: 6),
                          _WgmKeyedChild(
                            key: _useKeys
                                ? ValueKey<String>(_items[i].name)
                                : null,
                            item: _items[i],
                            slot: i,
                          ),
                        ],
                      ),
                    ),
                    if (i < _items.length - 1) const SizedBox(width: 12),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _wgmEmeraldDeep,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _wgmBrassDark, width: 1),
                ),
                child: const Text(
                  'Without keys, Widget.canUpdate looks only at runtimeType. '
                  'The first slot keeps its Element regardless of content, so '
                  'the counter stays put. With ValueKey, the framework matches '
                  'by key and moves the Element (and its State) with the item.',
                  style: TextStyle(
                    color: _wgmIvory,
                    fontSize: 12.5,
                    height: 1.4,
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

class _WgmKeyItem {
  _WgmKeyItem(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
}

class _WgmReorderArrows extends StatelessWidget {
  const _WgmReorderArrows({
    required this.canLeft,
    required this.canRight,
    required this.onLeft,
    required this.onRight,
  });

  final bool canLeft;
  final bool canRight;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _btn(Icons.arrow_back, canLeft, onLeft),
        const SizedBox(width: 6),
        _btn(Icons.arrow_forward, canRight, onRight),
      ],
    );
  }

  Widget _btn(IconData icon, bool enabled, VoidCallback cb) {
    return InkWell(
      onTap: enabled ? cb : null,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: enabled
              ? _wgmBrass.withValues(alpha: 0.25)
              : _wgmEmeraldDeep.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: enabled
                ? _wgmBrass
                : _wgmBrassDark.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled
              ? _wgmBrassLight
              : _wgmIvoryDim.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

class _WgmKeyedChild extends StatefulWidget {
  const _WgmKeyedChild({super.key, required this.item, required this.slot});

  final _WgmKeyItem item;
  final int slot;

  @override
  State<_WgmKeyedChild> createState() => _WgmKeyedChildState();
}

class _WgmKeyedChildState extends State<_WgmKeyedChild> {
  int _localCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _wgmEmeraldDeep.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: widget.item.color, width: 1.4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(widget.item.icon, color: widget.item.color, size: 32),
          const SizedBox(height: 4),
          Text(
            widget.item.name,
            style: TextStyle(
              color: widget.item.color,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'slot #${widget.slot}',
            style: const TextStyle(
              color: _wgmIvoryDim,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => setState(() => _localCounter++),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _wgmBrass,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'local: $_localCounter',
                style: const TextStyle(
                  color: _wgmInk,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 6 — Lifecycle diagram
// Animated clock cycling through StatefulWidget lifecycle stages
// ---------------------------------------------------------------------
class _WgmSection6Lifecycle extends StatefulWidget {
  const _WgmSection6Lifecycle();

  @override
  State<_WgmSection6Lifecycle> createState() => _WgmSection6LifecycleState();
}

class _WgmSection6LifecycleState extends State<_WgmSection6Lifecycle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _playing = true;

  static const List<_WgmLifecycleStage> _stages = <_WgmLifecycleStage>[
    _WgmLifecycleStage('createState', 'factory on StatefulWidget'),
    _WgmLifecycleStage('initState', 'one-time setup, subscriptions'),
    _WgmLifecycleStage('didChangeDependencies', 'after InheritedWidget changes'),
    _WgmLifecycleStage('build', 'return the Widget subtree'),
    _WgmLifecycleStage('didUpdateWidget', 'parent supplied a new Widget'),
    _WgmLifecycleStage('setState', 'schedules another build'),
    _WgmLifecycleStage('build', 'rebuild'),
    _WgmLifecycleStage('deactivate', 'Element removed from tree'),
    _WgmLifecycleStage('dispose', 'release resources, cancel timers'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _playing = !_playing;
      if (_playing) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 6,
          title: 'LIFECYCLE CLOCK',
          subtitle: 'StatefulWidget lifecycle — animated in brass and ink',
        ),
        const SizedBox(height: 16),
        _WgmCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: _togglePlay,
                    icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                    label: Text(_playing ? 'Pause' : 'Play'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _wgmBrass,
                      foregroundColor: _wgmInk,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'The pointer sweeps the dial and the active stage is '
                      'highlighted. Each stage is a method on State<T>.',
                      style: TextStyle(color: _wgmIvory, fontSize: 12.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              AspectRatio(
                aspectRatio: 1.9,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return CustomPaint(
                      painter: _WgmLifecyclePainter(
                        progress: _controller.value,
                        stages: _stages,
                      ),
                      child: const SizedBox.expand(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  final int active =
                      (_controller.value * _stages.length).floor() %
                          _stages.length;
                  return _WgmLifecycleLegend(
                    stages: _stages,
                    active: active,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WgmLifecycleStage {
  const _WgmLifecycleStage(this.name, this.note);
  final String name;
  final String note;
}

class _WgmLifecycleLegend extends StatelessWidget {
  const _WgmLifecycleLegend({required this.stages, required this.active});

  final List<_WgmLifecycleStage> stages;
  final int active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth > 800 ? 3 : 1;
        return _WgmGrid(
          columns: columns,
          gap: 8,
          children: <Widget>[
            for (int i = 0; i < stages.length; i++)
              _legendRow(stages[i], i == active),
          ],
        );
      },
    );
  }

  Widget _legendRow(_WgmLifecycleStage s, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: active ? _wgmBrass.withValues(alpha: 0.22) : _wgmEmeraldDeep,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: active ? _wgmBrassLight : _wgmBrassDark.withValues(alpha: 0.5),
          width: active ? 1.6 : 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? _wgmBrassLight : _wgmBrassDark,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              s.name,
              style: TextStyle(
                color: active ? _wgmBrassLight : _wgmIvoryDim,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              s.note,
              style: TextStyle(
                color: active ? _wgmIvory : _wgmIvoryDim,
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WgmLifecyclePainter extends CustomPainter {
  _WgmLifecyclePainter({required this.progress, required this.stages});

  final double progress;
  final List<_WgmLifecycleStage> stages;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) * 0.42;

    // Parchment dial background
    final Paint bg = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _wgmIvory.withValues(alpha: 0.96),
          _wgmIvoryDim.withValues(alpha: 0.94),
          _wgmWood.withValues(alpha: 0.5),
        ],
        stops: const <double>[0.0, 0.78, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius + 24));
    canvas.drawCircle(center, radius + 16, bg);

    // Outer brass ring
    canvas.drawCircle(
      center,
      radius + 16,
      Paint()
        ..color = _wgmBrass
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );
    canvas.drawCircle(
      center,
      radius + 10,
      Paint()
        ..color = _wgmBrassDark
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke,
    );

    // Stage wedges
    final int n = stages.length;
    final int activeStage = (progress * n).floor() % n;
    for (int i = 0; i < n; i++) {
      final double a0 = -math.pi / 2 + (i / n) * math.pi * 2;
      final double a1 = -math.pi / 2 + ((i + 1) / n) * math.pi * 2;
      final Path wedge = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(
          center.dx + math.cos(a0) * radius,
          center.dy + math.sin(a0) * radius,
        )
        ..arcToPoint(
          Offset(
            center.dx + math.cos(a1) * radius,
            center.dy + math.sin(a1) * radius,
          ),
          radius: Radius.circular(radius),
          largeArc: false,
        )
        ..close();

      final Paint wedgeFill = Paint()
        ..color = i == activeStage
            ? _wgmBrass.withValues(alpha: 0.35)
            : (i.isEven
                ? _wgmEmerald.withValues(alpha: 0.12)
                : _wgmEmerald.withValues(alpha: 0.04));
      canvas.drawPath(wedge, wedgeFill);
      canvas.drawPath(
        wedge,
        Paint()
          ..color = _wgmBrassDark.withValues(alpha: 0.55)
          ..strokeWidth = 0.8
          ..style = PaintingStyle.stroke,
      );

      // Stage label around dial
      final double midA = (a0 + a1) / 2;
      final Offset labelPos = Offset(
        center.dx + math.cos(midA) * (radius * 0.76),
        center.dy + math.sin(midA) * (radius * 0.76),
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: stages[i].name,
          style: TextStyle(
            color: i == activeStage ? _wgmRuby : _wgmInk,
            fontFamily: 'monospace',
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 110);
      tp.paint(canvas,
          labelPos.translate(-tp.width / 2, -tp.height / 2));
    }

    // Tick marks
    for (int i = 0; i < n; i++) {
      final double a = -math.pi / 2 + (i / n) * math.pi * 2;
      final Offset p1 =
          center + Offset(math.cos(a) * radius, math.sin(a) * radius);
      final Offset p2 = center +
          Offset(math.cos(a) * (radius + 10), math.sin(a) * (radius + 10));
      canvas.drawLine(
        p1,
        p2,
        Paint()
          ..color = _wgmBrassDark
          ..strokeWidth = 1.4,
      );
    }

    // Sweeping hand
    final double handAngle = -math.pi / 2 + progress * math.pi * 2;
    final Offset handTip =
        center + Offset(math.cos(handAngle) * radius * 0.92,
            math.sin(handAngle) * radius * 0.92);
    canvas.drawLine(
      center,
      handTip,
      Paint()
        ..color = _wgmRuby
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(handTip, 5,
        Paint()..color = _wgmRuby.withValues(alpha: 0.9));
    canvas.drawCircle(center, 8,
        Paint()..color = _wgmBrassDark);
    canvas.drawCircle(center, 5,
        Paint()..color = _wgmBrassLight);

    // Center label
    final TextPainter title = TextPainter(
      text: TextSpan(
        text: 'State<T>\nlifecycle',
        style: TextStyle(
          color: _wgmInk.withValues(alpha: 0.7),
          fontSize: 10,
          fontFamily: 'serif',
          fontStyle: FontStyle.italic,
          height: 1.1,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 100);
    title.paint(canvas,
        Offset(center.dx - title.width / 2, center.dy + 14));
  }

  @override
  bool shouldRepaint(covariant _WgmLifecyclePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ---------------------------------------------------------------------
// SECTION 7 — Immutability & canUpdate
// Three side-by-side cards: reuse, reuse, rebuild
// ---------------------------------------------------------------------
class _WgmSection7CanUpdate extends StatelessWidget {
  const _WgmSection7CanUpdate();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 7,
          title: 'IMMUTABILITY & canUpdate',
          subtitle: 'Three cases the framework must handle every frame',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final int columns = constraints.maxWidth > 860 ? 3 : 1;
            return _WgmGrid(
              columns: columns,
              gap: 14,
              children: const <Widget>[
                _WgmCanUpdateCard(
                  badge: 'REUSE',
                  badgeColor: _wgmEmeraldBright,
                  title: 'Same type · Same key',
                  oldWidget: 'Text("A", key: ValueKey("x"))',
                  newWidget: 'Text("B", key: ValueKey("x"))',
                  canUpdate: true,
                  effect: 'Element is reused. '
                      'updateRenderObject() swaps the displayed string. '
                      'No Element destroyed, no State thrown away.',
                ),
                _WgmCanUpdateCard(
                  badge: 'REUSE',
                  badgeColor: _wgmEmeraldBright,
                  title: 'Same type · Both keys null',
                  oldWidget: 'Container(color: red)',
                  newWidget: 'Container(color: blue)',
                  canUpdate: true,
                  effect: 'Null keys compare equal under == . '
                      'Same runtimeType means canUpdate returns true. '
                      'Element is reused, RenderObject repaints.',
                ),
                _WgmCanUpdateCard(
                  badge: 'REBUILD',
                  badgeColor: _wgmRuby,
                  title: 'Different type · any key',
                  oldWidget: 'Text("A")',
                  newWidget: 'Icon(Icons.ac_unit)',
                  canUpdate: false,
                  effect: 'Old Element is deactivated + disposed, '
                      'new Element is inflated. Any State<T> on the '
                      'old subtree is lost forever.',
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _WgmCanUpdateCard extends StatelessWidget {
  const _WgmCanUpdateCard({
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.oldWidget,
    required this.newWidget,
    required this.canUpdate,
    required this.effect,
  });

  final String badge;
  final Color badgeColor;
  final String title;
  final String oldWidget;
  final String newWidget;
  final bool canUpdate;
  final String effect;

  @override
  Widget build(BuildContext context) {
    return _WgmCard(
      accent: badgeColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: _wgmInk,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _wgmIvory,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _WgmCodeBlock(code: 'old: $oldWidget\nnew: $newWidget'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: canUpdate
                  ? _wgmEmerald.withValues(alpha: 0.35)
                  : _wgmRuby.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: badgeColor),
            ),
            child: Text(
              'Widget.canUpdate → ${canUpdate ? "true" : "false"}',
              style: const TextStyle(
                color: _wgmBrassLight,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            effect,
            style: const TextStyle(
              color: _wgmIvoryDim,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 8 — Composition variations
// Same UI, three different implementations
// ---------------------------------------------------------------------
class _WgmSection8Composition extends StatelessWidget {
  const _WgmSection8Composition();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 8,
          title: 'COMPOSITION VARIATIONS',
          subtitle: 'Same status card, three implementations — all identical',
        ),
        const SizedBox(height: 16),
        _WgmCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints constraints) {
                  final int columns = constraints.maxWidth > 720 ? 3 : 1;
                  return _WgmGrid(
                    columns: columns,
                    gap: 14,
                    children: const <Widget>[
                      _WgmVariantShowcase(
                        label: '(i) Raw composition',
                        note: 'Row/Column/Container inlined in parent build()',
                        snippet: 'Container(\n'
                            '  child: Row(children: [\n'
                            '    Icon(Icons.wb_sunny),\n'
                            '    Text("72°F"),\n'
                            '  ]),\n'
                            ')',
                        impl: _WgmStatusRaw(),
                      ),
                      _WgmVariantShowcase(
                        label: '(ii) Extracted StatelessWidget',
                        note: 'Named type, reusable, easier to test',
                        snippet: 'class _StatusCard extends\n'
                            '    StatelessWidget {\n'
                            '  final String temp;\n'
                            '  Widget build(ctx) => ... ;\n'
                            '}',
                        impl: _WgmStatusCard(temp: '72°F'),
                      ),
                      _WgmVariantShowcase(
                        label: '(iii) StatefulWidget w/ cached derivation',
                        note: 'Caches the formatted string in setState step',
                        snippet: 'class _StatusCardS extends\n'
                            '    StatefulWidget {...}\n'
                            '// cached: _formatted = \\n'
                            '//   compute(widget.temp);',
                        impl: _WgmStatusCardCached(temp: '72°F'),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _wgmEmeraldDeep,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _wgmBrassDark),
                ),
                child: const Text(
                  'Visually identical. The difference is in the Element tree: '
                  '(i) is a sequence of anonymous Elements under the parent; '
                  '(ii) and (iii) each insert one extra ComponentElement '
                  'node that can be diffed as a unit.',
                  style: TextStyle(
                    color: _wgmIvory,
                    fontSize: 12.5,
                    height: 1.4,
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

class _WgmVariantShowcase extends StatelessWidget {
  const _WgmVariantShowcase({
    required this.label,
    required this.note,
    required this.snippet,
    required this.impl,
  });

  final String label;
  final String note;
  final String snippet;
  final Widget impl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _wgmEmeraldDeep.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wgmBrassDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: _wgmBrassLight,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            note,
            style: const TextStyle(
              color: _wgmIvoryDim,
              fontStyle: FontStyle.italic,
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 10),
          _WgmCodeBlock(code: snippet),
          const SizedBox(height: 10),
          Align(alignment: Alignment.center, child: impl),
        ],
      ),
    );
  }
}

// Variant (i) — raw composition
class _WgmStatusRaw extends StatelessWidget {
  const _WgmStatusRaw();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wgmIvory, _wgmIvoryDim],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wgmBrass, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Icon(Icons.wb_sunny, color: _wgmBrassDark, size: 22),
          SizedBox(width: 8),
          Text(
            '72°F · clear',
            style: TextStyle(
              color: _wgmInk,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// Variant (ii) — extracted StatelessWidget
class _WgmStatusCard extends StatelessWidget {
  const _WgmStatusCard({required this.temp});

  final String temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wgmIvory, _wgmIvoryDim],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wgmBrass, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.wb_sunny, color: _wgmBrassDark, size: 22),
          const SizedBox(width: 8),
          Text(
            '$temp · clear',
            style: const TextStyle(
              color: _wgmInk,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// Variant (iii) — StatefulWidget with cached derivation
class _WgmStatusCardCached extends StatefulWidget {
  const _WgmStatusCardCached({required this.temp});

  final String temp;

  @override
  State<_WgmStatusCardCached> createState() => _WgmStatusCardCachedState();
}

class _WgmStatusCardCachedState extends State<_WgmStatusCardCached> {
  String _formatted = '';

  @override
  void initState() {
    super.initState();
    _formatted = _compute(widget.temp);
  }

  @override
  void didUpdateWidget(covariant _WgmStatusCardCached oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.temp != widget.temp) {
      _formatted = _compute(widget.temp);
    }
  }

  String _compute(String raw) => '$raw · clear';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wgmIvory, _wgmIvoryDim],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wgmBrass, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.wb_sunny, color: _wgmBrassDark, size: 22),
          const SizedBox(width: 8),
          Text(
            _formatted,
            style: const TextStyle(
              color: _wgmInk,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 9 — Recipes
// Seven practical cards
// ---------------------------------------------------------------------
class _WgmSection9Recipes extends StatelessWidget {
  const _WgmSection9Recipes();

  @override
  Widget build(BuildContext context) {
    const List<_WgmRecipe> recipes = <_WgmRecipe>[
      _WgmRecipe(
        title: '1. Stateless vs Stateful',
        body: 'Default to StatelessWidget. Promote to StatefulWidget only '
            'when the widget must hold mutable data across frames that '
            'cannot be lifted to the parent.',
        icon: Icons.tune,
      ),
      _WgmRecipe(
        title: '2. Extract an InheritedWidget',
        body: 'When many descendants need the same data and you want '
            'O(1) lookup via Theme.of()-style APIs. Pair it with '
            'updateShouldNotify for fine-grained rebuilds.',
        icon: Icons.account_tree,
      ),
      _WgmRecipe(
        title: '3. GlobalKey across subtrees',
        body: 'Use sparingly. GlobalKey lets you obtain a BuildContext or '
            'State from outside the subtree, e.g. Form.of(context) or '
            'moving a widget between parents.',
        icon: Icons.public,
      ),
      _WgmRecipe(
        title: '4. PageStorageKey',
        body: 'Save scroll offsets across route pushes. Attach a '
            'PageStorageKey to Scrollables whose position you want to '
            'restore when the page re-enters the tree.',
        icon: Icons.save,
      ),
      _WgmRecipe(
        title: '5. ValueKey in long lists',
        body: 'Give list items a stable identity so reorder/delete '
            'animations look right and stateful children keep their '
            'internal state when reshuffled.',
        icon: Icons.format_list_numbered,
      ),
      _WgmRecipe(
        title: '6. const constructors',
        body: 'Prefer `const Widget(...)`. const widgets compare '
            'identically, so canUpdate is effectively free and rebuilds '
            'can be skipped deeper in the tree.',
        icon: Icons.flash_on,
      ),
      _WgmRecipe(
        title: '7. Keep build() pure & fast',
        body: 'No I/O, no timers, no mutating external state. build() '
            'runs potentially many times per frame; expensive work '
            'belongs in initState, didChangeDependencies, or an async '
            'future resolved outside build().',
        icon: Icons.speed,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 9,
          title: 'RECIPES',
          subtitle: 'Seven practical patterns from the field',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final int columns = constraints.maxWidth > 900
                ? 3
                : constraints.maxWidth > 560
                    ? 2
                    : 1;
            return _WgmGrid(
              columns: columns,
              gap: 14,
              children: recipes
                  .map((_WgmRecipe r) => _WgmLabelCard(
                        title: r.title,
                        body: r.body,
                        icon: r.icon,
                      ))
                  .toList(growable: false),
            );
          },
        ),
      ],
    );
  }
}

class _WgmRecipe {
  const _WgmRecipe({
    required this.title,
    required this.body,
    required this.icon,
  });
  final String title;
  final String body;
  final IconData icon;
}

// ---------------------------------------------------------------------
// SECTION 10 — Comparison
// Widget vs other UI paradigms
// ---------------------------------------------------------------------
class _WgmSection10Comparison extends StatelessWidget {
  const _WgmSection10Comparison();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>[
        'Aspect',
        'Flutter Widget',
        'Canvas / RenderObject',
        'Imperative UI (single setState at root)',
        'Reactive MV-* view model',
      ],
      <String>[
        'Model',
        'Immutable configuration tree',
        'Mutable render graph',
        'Mutable root widget + manual diffing',
        'Observables + data bindings',
      ],
      <String>[
        'Rebuild unit',
        'Subtree below the changed widget',
        'Layer / render object',
        'Entire tree',
        'Views bound to changed observables',
      ],
      <String>[
        'Identity',
        'runtimeType + Key (canUpdate)',
        'Object identity of RenderObject',
        'Manual lookup by ID',
        'ViewModel reference',
      ],
      <String>[
        'Why Flutter picks Widgets',
        'Composable, declarative, cheap to allocate, cache-friendly diffing',
        'Too low-level for app code',
        'Easy to start, hard to scale',
        'Useful pattern — but still lives inside the Widget layer',
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 10,
          title: 'COMPARISON',
          subtitle: 'Widget vs RenderObject, imperative UI, reactive view models',
        ),
        const SizedBox(height: 16),
        _WgmCard(
          padding: const EdgeInsets.all(14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: _wgmEmeraldDeep,
              child: Column(
                children: <Widget>[
                  for (int r = 0; r < rows.length; r++)
                    _row(rows[r], isHeader: r == 0, index: r),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _row(List<String> cells, {required bool isHeader, required int index}) {
    return Container(
      decoration: BoxDecoration(
        color: isHeader
            ? _wgmBrass.withValues(alpha: 0.28)
            : (index.isEven
                ? _wgmVelvet
                : _wgmEmerald.withValues(alpha: 0.2)),
        border: Border(
          bottom: BorderSide(
            color: _wgmBrassDark.withValues(alpha: 0.5),
            width: 0.6,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 2 : 3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: _wgmBrassDark.withValues(alpha: 0.35),
                      width: 0.6,
                    ),
                  ),
                ),
                child: Text(
                  cells[i],
                  style: TextStyle(
                    color: isHeader
                        ? _wgmBrassLight
                        : (i == 0 ? _wgmBrassLight : _wgmIvory),
                    fontSize: isHeader ? 12.5 : 12,
                    fontWeight: isHeader || i == 0
                        ? FontWeight.w800
                        : FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 11 — Glossary + epilogue
// ---------------------------------------------------------------------
class _WgmSection11Glossary extends StatelessWidget {
  const _WgmSection11Glossary();

  @override
  Widget build(BuildContext context) {
    const List<_WgmGlossEntry> entries = <_WgmGlossEntry>[
      _WgmGlossEntry(term: 'Widget',
          def: 'Abstract base class; immutable description of a UI node.'),
      _WgmGlossEntry(term: 'Element',
          def: 'Inflated instance of a Widget. Owns position in the tree '
              'and wiring to the RenderObject.'),
      _WgmGlossEntry(term: 'RenderObject',
          def: 'Performs layout, paint, hit-testing. Lives in the render '
              'tree beneath Elements.'),
      _WgmGlossEntry(term: 'StatelessWidget',
          def: 'Widget whose build() depends solely on its constructor '
              'arguments and ambient InheritedWidgets.'),
      _WgmGlossEntry(term: 'StatefulWidget',
          def: 'Widget paired with a State<T> object. The State survives '
              'across rebuilds driven by the parent.'),
      _WgmGlossEntry(term: 'State',
          def: 'Mutable object associated with a StatefulElement. Hosts '
              'setState, lifecycle hooks, and local data.'),
      _WgmGlossEntry(term: 'RenderObjectWidget',
          def: 'Widget that creates/updates a RenderObject directly, e.g. '
              'RichText, CustomPaint, Opacity.'),
      _WgmGlossEntry(term: 'ProxyWidget',
          def: 'Widget that delegates to a single child while contributing '
              'ambient data or parent data — superclass of InheritedWidget.'),
      _WgmGlossEntry(term: 'InheritedWidget',
          def: 'ProxyWidget that efficiently propagates immutable data '
              'down the tree via an InheritedElement.'),
      _WgmGlossEntry(term: 'Key',
          def: 'Identity marker on a Widget. Ensures the framework matches '
              'Widgets to Elements across rebuilds in predictable ways.'),
      _WgmGlossEntry(term: 'ValueKey',
          def: 'Key comparing wrapped value via == . Typical choice for '
              'list items keyed by their data.'),
      _WgmGlossEntry(term: 'GlobalKey',
          def: 'Unique across the whole app. Allows cross-subtree lookup '
              'of Element, BuildContext, or State.'),
      _WgmGlossEntry(term: 'canUpdate',
          def: 'static bool that returns true iff oldWidget and newWidget '
              'share runtimeType and key. The reuse oracle.'),
      _WgmGlossEntry(term: 'runtimeType',
          def: 'Dart type of the object. Combined with key to decide '
              'whether an Element can be reused.'),
      _WgmGlossEntry(term: 'build()',
          def: 'Function returning the subtree for the current frame. '
              'Must be pure and fast.'),
      _WgmGlossEntry(term: 'BuildContext',
          def: 'Handle to the current Element. Used to look up ancestors, '
              'InheritedWidgets, and sizes.'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WgmSectionHeader(
          index: 11,
          title: 'GLOSSARY & EPILOGUE',
          subtitle: 'Sixteen terms every Flutter practitioner should know',
        ),
        const SizedBox(height: 16),
        _WgmCard(
          padding: const EdgeInsets.all(18),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int columns = constraints.maxWidth > 900
                  ? 2
                  : 1;
              return _WgmGrid(
                columns: columns,
                gap: 8,
                children: <Widget>[
                  for (final _WgmGlossEntry e in entries) _glossRow(e),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _WgmCard(
          accent: _wgmBrassLight,
          padding: const EdgeInsets.all(18),
          child: const Text(
            'Epilogue — The widget tree is the Flutter programming model\'s '
            'cornerstone because it is the one abstraction through which '
            'every other concept passes. Layout, painting, accessibility, '
            'hit-testing, navigation, theming, and state all negotiate with '
            'the Widget layer. Its beauty is that almost everything is '
            'just another Widget: MaterialApp is a Widget, Theme is a '
            'Widget, Navigator is a Widget, even MediaQuery is a Widget. '
            'Because of that uniform substrate, Flutter developers compose '
            'behavior the same way they compose appearance — by nesting '
            'immutable configuration nodes and letting the framework '
            'reconcile them against a patient Element tree that is already '
            'doing most of the work.',
            style: TextStyle(
              color: _wgmIvory,
              fontSize: 13,
              height: 1.55,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _glossRow(_WgmGlossEntry e) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _wgmEmeraldDeep,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: _wgmBrassDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            e.term,
            style: const TextStyle(
              color: _wgmBrassLight,
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            e.def,
            style: const TextStyle(
              color: _wgmIvory,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _WgmGlossEntry {
  const _WgmGlossEntry({required this.term, required this.def});
  final String term;
  final String def;
}

// ---------------------------------------------------------------------
// Colophon
// ---------------------------------------------------------------------
class _WgmColophon extends StatelessWidget {
  const _WgmColophon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: _wgmWoodDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _wgmBrassDark, width: 1.5),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.book, color: _wgmBrassLight, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Museum of Widgets — a Dart/Flutter deep-dive, assembled by '
              'hand for the D4rt AST harness. Two painters, one animation '
              'controller, and a deep respect for the abstract class that '
              'started it all.',
              style: TextStyle(
                color: _wgmIvoryDim,
                fontStyle: FontStyle.italic,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const _WgmBrassPip(),
        ],
      ),
    );
  }
}
