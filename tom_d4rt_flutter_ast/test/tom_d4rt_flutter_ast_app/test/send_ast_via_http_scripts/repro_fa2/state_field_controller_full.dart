// ignore_for_file: avoid_print, unused_local_variable, unused_element
// D4rt deep visual demo (Fa2 family): The ScrollController-in-State pattern.
//
// This file is a hand-authored corpus entry for the d4rt flutter-test runner.
// It renders a fully styled, scrollable poster that teaches the canonical
// pattern at the heart of the Fa2 hypothesis family:
//
//     A ScrollController is OWNED by a StatefulWidget's State object
//     (created in initState or as a final field, disposed in dispose),
//     and is THREADED DOWN through a chain of StatelessWidgets which
//     simply forward it to a scroll surface (ListView, GridView,
//     SingleChildScrollView, CustomScrollView).
//
// The script is 100% static: build() is called exactly once, no setState
// drives updates, there are no Timers, no AnimationControllers, no async
// rebuild loops. ScrollController instances ARE constructed and threaded
// into real ListView / SingleChildScrollView / GridView / CustomScrollView
// widgets, since those are static scroll surfaces here.
//
// Reference style: see services/spellcheck_test.dart for the section-card,
// painter, and tone idioms this file mirrors.

import 'package:flutter/material.dart';
import 'dart:math' as math;

// ─────────────────────────────────────────────────────────────────────────
// Painter: draws the controller-ownership tree as a labelled diagram.
//   StatefulWidget → State → final ScrollController _ctl = … →
//   passed into _Forward1 → _Forward2 → ListView.controller
// ─────────────────────────────────────────────────────────────────────────
class _OwnershipTreePainter extends CustomPainter {
  _OwnershipTreePainter({
    required this.nodeFill,
    required this.nodeStroke,
    required this.edgeColor,
    required this.labelColor,
    required this.accentColor,
  });

  final Color nodeFill;
  final Color nodeStroke;
  final Color edgeColor;
  final Color labelColor;
  final Color accentColor;

  static const List<String> _nodes = <String>[
    'StatefulWidget (_DemoHost)',
    'State<_DemoHost> (_DemoHostState)',
    'final ScrollController _ctl = ScrollController()',
    'StatelessWidget _ForwardA (controller: _ctl)',
    'StatelessWidget _ForwardB (controller: controller)',
    'ListView.builder(controller: controller, …)',
  ];

  static const List<String> _badges = <String>[
    'owner',
    'lifecycle',
    'field',
    'pass-down',
    'pass-down',
    'scroll surface',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double rowHeight = size.height / _nodes.length;
    final Paint nodePaint = Paint()..color = nodeFill;
    final Paint strokePaint = Paint()
      ..color = nodeStroke
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final Paint edgePaint = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < _nodes.length; i++) {
      final double cy = rowHeight * i + rowHeight / 2;
      final RRect node = RRect.fromRectAndRadius(
        Rect.fromLTWH(10, cy - 16, size.width - 20, 32),
        const Radius.circular(8),
      );
      canvas.drawRRect(node, nodePaint);
      canvas.drawRRect(node, strokePaint);

      // Badge pill on the right.
      final TextPainter badge = TextPainter(
        text: TextSpan(
          text: _badges[i],
          style: TextStyle(
            color: accentColor,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      badge.layout(maxWidth: size.width);
      final double badgeW = badge.width + 14;
      final RRect badgeRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width - 12 - badgeW, cy - 9, badgeW, 18),
        const Radius.circular(9),
      );
      final Paint badgeFill = Paint()..color = accentColor.withValues(alpha: 0.14);
      canvas.drawRRect(badgeRect, badgeFill);
      badge.paint(
          canvas, Offset(size.width - 12 - badgeW + 7, cy - badge.height / 2));

      // Label on the left.
      final TextPainter label = TextPainter(
        text: TextSpan(
          text: _nodes[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      );
      label.layout(maxWidth: size.width - badgeW - 36);
      label.paint(canvas, Offset(20, cy - label.height / 2));

      if (i < _nodes.length - 1) {
        final double startY = cy + 16;
        final double endY = cy + rowHeight - 16;
        canvas.drawLine(
            Offset(size.width / 2, startY), Offset(size.width / 2, endY), edgePaint);
        final Path arrow = Path()
          ..moveTo(size.width / 2 - 5, endY - 5)
          ..lineTo(size.width / 2, endY)
          ..lineTo(size.width / 2 + 5, endY - 5);
        canvas.drawPath(arrow, edgePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _OwnershipTreePainter old) {
    return old.nodeFill != nodeFill ||
        old.nodeStroke != nodeStroke ||
        old.edgeColor != edgeColor ||
        old.labelColor != labelColor ||
        old.accentColor != accentColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: draws a static "lifecycle ribbon" — initState → build → dispose.
// ─────────────────────────────────────────────────────────────────────────
class _LifecycleRibbonPainter extends CustomPainter {
  _LifecycleRibbonPainter({
    required this.barColor,
    required this.markerColor,
    required this.labelColor,
  });

  final Color barColor;
  final Color markerColor;
  final Color labelColor;

  static const List<String> _phases = <String>[
    'createState',
    'initState\n(create _ctl)',
    'build\n(pass _ctl down)',
    'didUpdateWidget\n(keep _ctl)',
    'dispose\n(_ctl.dispose())',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height / 2;
    final Paint barPaint = Paint()
      ..color = barColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(16, midY), Offset(size.width - 16, midY), barPaint);

    final double stride = (size.width - 32) / (_phases.length - 1);
    final Paint dotPaint = Paint()..color = markerColor;
    for (int i = 0; i < _phases.length; i++) {
      final double cx = 16 + stride * i;
      canvas.drawCircle(Offset(cx, midY), 7, dotPaint);
      canvas.drawCircle(
          Offset(cx, midY),
          7,
          Paint()
            ..color = Colors.white
            ..strokeWidth = 1.6
            ..style = PaintingStyle.stroke);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _phases[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: stride - 6);
      tp.paint(canvas, Offset(cx - tp.width / 2, midY + 14));
    }
  }

  @override
  bool shouldRepaint(covariant _LifecycleRibbonPainter old) {
    return old.barColor != barColor ||
        old.markerColor != markerColor ||
        old.labelColor != labelColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Forward chain: Stateless widgets that simply pass a controller down.
// These mirror the Fa2 pattern — pass-by-reference through const ctors.
// ─────────────────────────────────────────────────────────────────────────
class _ForwardA extends StatelessWidget {
  final ScrollController controller;
  final Widget Function(ScrollController) child;
  const _ForwardA({required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return _ForwardB(controller: controller, child: child);
  }
}

class _ForwardB extends StatelessWidget {
  final ScrollController controller;
  final Widget Function(ScrollController) child;
  const _ForwardB({required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return _ForwardC(controller: controller, child: child);
  }
}

class _ForwardC extends StatelessWidget {
  final ScrollController controller;
  final Widget Function(ScrollController) child;
  const _ForwardC({required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return child(controller);
  }
}

// ─────────────────────────────────────────────────────────────────────────
// The owning StatefulWidget. It creates ScrollController instances in its
// State, and renders the entire poster. Inside, every scroll surface
// receives a controller threaded through the _ForwardA → _ForwardC chain.
// ─────────────────────────────────────────────────────────────────────────
class _DemoHost extends StatefulWidget {
  const _DemoHost({required this.body});
  final Widget Function(BuildContext, _ControllerBag) body;

  @override
  State<_DemoHost> createState() => _DemoHostState();
}

/// A bag of pre-built ScrollController instances owned by the State above.
class _ControllerBag {
  _ControllerBag({
    required this.listCtl,
    required this.singleCtl,
    required this.gridCtl,
    required this.sliverCtl,
    required this.codeListCtl,
    required this.pitfallCtl,
  });
  final ScrollController listCtl;
  final ScrollController singleCtl;
  final ScrollController gridCtl;
  final ScrollController sliverCtl;
  final ScrollController codeListCtl;
  final ScrollController pitfallCtl;
}

class _DemoHostState extends State<_DemoHost> {
  // The Fa2 pattern: ScrollController owned as a final State field. Created
  // here at field-init time (equivalent semantics to creating in initState
  // for a single, never-replaced controller). Disposed in dispose().
  final ScrollController _listCtl = ScrollController();
  final ScrollController _singleCtl = ScrollController();
  final ScrollController _gridCtl = ScrollController();
  final ScrollController _sliverCtl = ScrollController();
  final ScrollController _codeListCtl = ScrollController();
  final ScrollController _pitfallCtl = ScrollController();

  @override
  void dispose() {
    // Strict dispose order: detach listeners (none here), then dispose
    // each controller. Never call dispose more than once.
    _listCtl.dispose();
    _singleCtl.dispose();
    _gridCtl.dispose();
    _sliverCtl.dispose();
    _codeListCtl.dispose();
    _pitfallCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ControllerBag bag = _ControllerBag(
      listCtl: _listCtl,
      singleCtl: _singleCtl,
      gridCtl: _gridCtl,
      sliverCtl: _sliverCtl,
      codeListCtl: _codeListCtl,
      pitfallCtl: _pitfallCtl,
    );
    return widget.body(context, bag);
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Top-level harness: MaterialApp → _DemoHost → Scaffold → SafeArea → poster.
// ─────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ─── Palette: indigo / teal / amber ───
  const Color indigo = Color(0xFF4F46E5);
  const Color indigoDeep = Color(0xFF312E81);
  const Color indigoLight = Color(0xFFE0E7FF);
  const Color teal = Color(0xFF0D9488);
  const Color tealDeep = Color(0xFF134E4A);
  const Color tealLight = Color(0xFFCCFBF1);
  const Color amber = Color(0xFFD97706);
  const Color amberDeep = Color(0xFF92400E);
  const Color amberLight = Color(0xFFFEF3C7);
  const Color rose = Color(0xFFE11D48);
  const Color roseDeep = Color(0xFF881337);
  const Color roseLight = Color(0xFFFFE4E6);
  const Color slate = Color(0xFF334155);
  const Color slateDeep = Color(0xFF0F172A);
  const Color slateLight = Color(0xFFE2E8F0);
  const Color paper = Color(0xFFF8FAFC);
  const Color sky = Color(0xFF0EA5E9);

  print('===== STATE-FIELD SCROLL CONTROLLER DEEP VISUAL DEMO =====');
  print('Pattern: ScrollController owned in State, threaded through');
  print('         a chain of StatelessWidgets into scroll surfaces.');

  // ─── Local widget helpers ────────────────────────────────────────────

  Widget sectionBanner(String number, String title, List<Color> gradient) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 28, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.45),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.18),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.55),
                width: 1.4,
              ),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget proseBox(String text, {Color? bg, Color? border}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border ?? slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: indigo.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          height: 1.55,
          color: slateDeep.withValues(alpha: 0.92),
        ),
      ),
    );
  }

  Widget infoCard(String heading, Widget content,
      {List<Color>? headerGradient, Color? bodyColor}) {
    final List<Color> gradient = headerGradient ?? <Color>[indigoDeep, indigo];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bodyColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.07),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.10),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              heading,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14), child: content),
        ],
      ),
    );
  }

  Widget dataRow(String label, String value, {Color? labelColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: labelColor ?? slateDeep,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: slate),
            ),
          ),
        ],
      ),
    );
  }

  Widget chipTag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: bg.withValues(alpha: 0.30),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }

  Widget ribbonBadge(String label, Color bg, Color fg, {IconData? icon}) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: bg.withValues(alpha: 0.45),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 13, color: fg),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: fg,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget pillRow(List<Widget> children) {
    return Wrap(spacing: 0, runSpacing: 0, children: children);
  }

  Widget codeSnippetCard(String title, String code, {Color? accent}) {
    final Color a = accent ?? sky;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: slateDeep,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: a.withValues(alpha: 0.18),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: a.withValues(alpha: 0.20),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFB7185),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCD34D),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34D399),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12,
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget antiPatternCard(String title, String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: roseDeep,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: rose.withValues(alpha: 0.30),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: rose.withValues(alpha: 0.30),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.warning_amber_rounded,
                    size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.94),
                fontSize: 12,
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget scrollSurfaceCard({
    required String title,
    required String surfaceType,
    required Widget child,
    required Color accent,
    required Color accentDeep,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.07),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[accentDeep, accent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.45),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    surfaceType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: slateDeep.withValues(alpha: 0.78),
                ),
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

  // ───────────────────────────────────────────────────────────────────────
  // Section 1 — Intro: why controllers belong in State, not in build()
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 1] Intro — why a ScrollController belongs in State');

  final Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '01',
        'Why a ScrollController Belongs in State',
        <Color>[indigoDeep, indigo],
      ),
      proseBox(
        'A ScrollController is a long-lived listenable: it carries '
        '`ScrollPosition` objects that are attached when a scroll view '
        'mounts and detached when it unmounts. If you construct a '
        'ScrollController inside a build() method, you would get a brand '
        'new instance on every rebuild, the old one would never be '
        'disposed, listeners would silently leak, and any `position` calls '
        'would crash because the previous attachment is gone. The correct '
        'home for a controller is therefore a State field — created once '
        'when the State is first constructed (or in initState), and '
        'disposed exactly once when the State is removed from the tree.',
      ),
      proseBox(
        'Once owned by State, the controller is passed DOWN through the '
        'widget tree as a constructor argument. The intermediate widgets '
        'are typically StatelessWidgets: they hold a reference to the '
        'controller, but never create or dispose it. This is the entire '
        'Fa2 pattern: one owner, many forwarders, one scroll surface at '
        'the bottom of the chain. The interpreter test runner exercises '
        'this exact shape because it stresses identity-preservation '
        'across const-stateless ctors and the State lifecycle.',
      ),
      infoCard(
        'Pattern at a glance',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('owner', 'State<_DemoHost> field _listCtl, …'),
            dataRow('created', 'field-init / initState (NOT build)'),
            dataRow('passed via', 'const StatelessWidget chain'),
            dataRow('consumed by', 'ListView / SCSV / GridView / CSV'),
            dataRow('disposed', 'State.dispose() — exactly once'),
            dataRow('rebuild cost', 'zero — controller identity preserved'),
          ],
        ),
        headerGradient: <Color>[indigoDeep, indigo],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 2 — Ownership tree diagram (CustomPainter)
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 2] Ownership tree diagram');

  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '02',
        'Ownership Tree — From State Field to Scroll Surface',
        <Color>[indigo, teal],
      ),
      proseBox(
        'The diagram below visualises the chain. Read it top-to-bottom: a '
        'StatefulWidget at the root owns a State object; the State holds '
        'a `final ScrollController _ctl` field; that field is forwarded '
        'into a StatelessWidget which forwards it into another '
        'StatelessWidget, and so on, until a ListView at the bottom binds '
        'it via its `controller:` argument. Each row is annotated with a '
        'role badge — owner, lifecycle, field, pass-down, scroll surface '
        '— so that you can scan the diagram and immediately see which '
        'widget is responsible for which part of the contract.',
      ),
      Container(
        height: 320,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[paper, indigoLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: indigoLight),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: indigo.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CustomPaint(
          painter: _OwnershipTreePainter(
            nodeFill: Colors.white,
            nodeStroke: indigo,
            edgeColor: indigoDeep,
            labelColor: slateDeep,
            accentColor: indigoDeep,
          ),
        ),
      ),
      infoCard(
        'Chain identity facts',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('identity', 'Same Dart object end-to-end'),
            dataRow('==',
                'Forwarded ref compares == to the State field at every level'),
            dataRow('hashCode', 'Stable for the entire State lifetime'),
            dataRow('mount/unmount',
                'Controller survives unrelated child rebuilds'),
            dataRow('passing style', 'Constructor arg on const Stateless'),
            dataRow('null safety',
                'Required, non-nullable; never lazily-built'),
          ],
        ),
        headerGradient: <Color>[indigo, teal],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 3 — Lifecycle ribbon (CustomPainter)
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 3] Lifecycle ribbon');

  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '03',
        'State Lifecycle — Where the Controller Comes and Goes',
        <Color>[teal, indigo],
      ),
      proseBox(
        'The ribbon below sketches the five lifecycle moments that matter '
        'to a ScrollController owned by State. `createState` is invoked '
        'when the framework first inflates the StatefulWidget; '
        '`initState` is your earliest chance to construct or attach '
        'listeners; `build` is where the controller flows down through '
        'StatelessWidgets to a scroll surface; `didUpdateWidget` runs '
        'whenever the parent rebuilds the StatefulWidget but the State '
        'instance is preserved (so the controller is kept!); and '
        '`dispose` is where you finally release the controller. Each '
        'phase has exactly one correct controller action — get those '
        'right and the leak surface vanishes.',
      ),
      Container(
        height: 130,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: teal.withValues(alpha: 0.10),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CustomPaint(
          painter: _LifecycleRibbonPainter(
            barColor: teal,
            markerColor: tealDeep,
            labelColor: slateDeep,
          ),
        ),
      ),
      infoCard(
        'Lifecycle rules-of-thumb',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('createState', 'Return your State — no controller yet'),
            dataRow('initState',
                'Construct ScrollController (or use a field initialiser)'),
            dataRow('build', 'Pass _ctl down; do NOT construct new one'),
            dataRow('didUpdateWidget',
                'Compare old/new widget; controller usually unchanged'),
            dataRow('dispose',
                'Call _ctl.dispose() exactly once before super.dispose()'),
            dataRow('reassemble', 'Optional: keep the controller'),
          ],
        ),
        headerGradient: <Color>[teal, tealDeep],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 4 — Static API surface (controller introspection)
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 4] Static API surface');

  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '04',
        'Controller API — What the Surfaces Expose',
        <Color>[indigo, rose],
      ),
      proseBox(
        'Once attached to a scroll view, a ScrollController exposes a '
        'small but powerful API. `hasClients` tells you whether any '
        'ScrollPosition is currently attached; reading `position` or '
        '`offset` before this is true throws. The cards below show the '
        'API surface as labelled rows — the demo does NOT read live '
        'values (this is a static render), but it does construct real '
        'controllers, so in a real app the row values would update '
        'whenever the scroll view scrolled. The pills below summarise '
        'common return-type categories.',
      ),
      infoCard(
        'ScrollController API summary',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('hasClients', 'bool — at least one position attached'),
            dataRow('positions', 'Iterable<ScrollPosition>'),
            dataRow('position', 'ScrollPosition — throws when 0 or >1'),
            dataRow('offset', 'double — shorthand for position.pixels'),
            dataRow('initialScrollOffset', 'double — what we started at'),
            dataRow('keepScrollOffset', 'bool — restore after pop'),
            dataRow('debugLabel', 'String? — for diagnostics'),
            dataRow('addListener', 'void Function(VoidCallback)'),
            dataRow('removeListener', 'void Function(VoidCallback)'),
            dataRow('dispose', 'void — call exactly once'),
          ],
        ),
        headerGradient: <Color>[indigo, rose],
      ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: paper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Common return-type pills',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: slateDeep,
              ),
            ),
            const SizedBox(height: 10),
            pillRow(<Widget>[
              ribbonBadge('bool', tealLight, tealDeep,
                  icon: Icons.check_circle_outline),
              ribbonBadge('double', indigoLight, indigoDeep,
                  icon: Icons.numbers),
              ribbonBadge('Iterable<…>', amberLight, amberDeep,
                  icon: Icons.list_alt),
              ribbonBadge('ScrollPosition', roseLight, roseDeep,
                  icon: Icons.swap_vert),
              ribbonBadge('VoidCallback', slateLight, slateDeep,
                  icon: Icons.notifications_none),
            ]),
          ],
        ),
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 5 — Gallery of mock scroll surfaces (real controllers attached)
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 5] Gallery of mock scroll surfaces');

  // Static data for the gallery: short, deterministic, no time-based fields.
  final List<String> listItems = <String>[
    'Inbox', 'Drafts', 'Sent', 'Snoozed', 'Important', 'Starred',
    'Chats', 'Scheduled', 'All mail', 'Spam', 'Trash', 'Templates',
  ];
  final List<String> gridTiles = <String>[
    'Today', 'Tomorrow', 'Week', 'Month', 'Year', 'Custom',
    'Tag A', 'Tag B', 'Tag C', 'Tag D', 'Tag E', 'Tag F',
  ];
  final List<String> sliverHeaders = <String>[
    'Pinned', 'Recent', 'Archive', 'Older',
  ];

  // The gallery itself must consume the controllers from the State. We
  // therefore wrap it in a _DemoHost so the State can vend the bag.
  Widget surfaceGallery() {
    return _DemoHost(
      body: (BuildContext ctx, _ControllerBag bag) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sectionBanner(
              '05',
              'Scroll Surface Gallery — Real Controllers, Static Data',
              <Color>[rose, amber],
            ),
            proseBox(
              'The cards below each render a real Flutter scroll surface '
              'with a ScrollController attached. Every controller was '
              'created in the parent _DemoHost\'s State and is being '
              'threaded down through the _ForwardA → _ForwardB → '
              '_ForwardC StatelessWidget chain — you can see that chain '
              'in the source. The data shown inside each surface is '
              'short and deterministic; nothing scrolls automatically. '
              'In a real app these widgets would be live, but here they '
              'demonstrate the pass-down pattern visually.',
            ),

            // Surface A: ListView.builder
            scrollSurfaceCard(
              title: 'ListView.builder — vertical scrolling list',
              surfaceType: 'controller: bag.listCtl',
              subtitle:
                  'Threaded through _ForwardA → _ForwardB → _ForwardC. '
                  'The controller binds to a single ScrollPosition produced '
                  'by the list\'s internal viewport.',
              accent: indigo,
              accentDeep: indigoDeep,
              child: SizedBox(
                height: 220,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slateLight),
                  ),
                  child: _ForwardA(
                    controller: bag.listCtl,
                    child: (ScrollController c) => ListView.builder(
                      controller: c,
                      itemCount: listItems.length,
                      itemBuilder: (BuildContext ctx2, int i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: i.isEven ? Colors.white : indigoLight,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: slateLight),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: indigo.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: indigoDeep,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  listItems[i],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: slateDeep,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right,
                                  size: 16,
                                  color: slate.withValues(alpha: 0.6)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Surface B: SingleChildScrollView
            scrollSurfaceCard(
              title: 'SingleChildScrollView — long static child',
              surfaceType: 'controller: bag.singleCtl',
              subtitle:
                  'One ScrollPosition for one Column of arbitrary widgets. '
                  'Useful for tall settings panes, walls of prose, and '
                  'any tree without obvious item-based geometry.',
              accent: teal,
              accentDeep: tealDeep,
              child: SizedBox(
                height: 220,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slateLight),
                  ),
                  child: _ForwardA(
                    controller: bag.singleCtl,
                    child: (ScrollController c) => SingleChildScrollView(
                      controller: c,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int i = 0; i < 14; i++)
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: i.isEven ? Colors.white : tealLight,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: slateLight),
                              ),
                              child: Text(
                                'Paragraph ${i + 1} — controller stays the '
                                'same identity across rebuilds of this '
                                'column. The State owns it; this Column is '
                                'just a child of a forwarder.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  height: 1.45,
                                  color: slateDeep,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Surface C: GridView
            scrollSurfaceCard(
              title: 'GridView.count — two-dimensional scroll surface',
              surfaceType: 'controller: bag.gridCtl',
              subtitle:
                  'Same ScrollController contract: one position attached '
                  'to a vertical viewport, regardless of how many '
                  'columns the cross axis renders.',
              accent: amber,
              accentDeep: amberDeep,
              child: SizedBox(
                height: 240,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slateLight),
                  ),
                  child: _ForwardA(
                    controller: bag.gridCtl,
                    child: (ScrollController c) => GridView.count(
                      controller: c,
                      crossAxisCount: 3,
                      padding: const EdgeInsets.all(8),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: <Widget>[
                        for (int i = 0; i < gridTiles.length; i++)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: i.isEven
                                    ? <Color>[amberLight, amber]
                                    : <Color>[indigoLight, indigo],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: (i.isEven ? amber : indigo)
                                      .withValues(alpha: 0.30),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                gridTiles[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Surface D: CustomScrollView with slivers
            scrollSurfaceCard(
              title: 'CustomScrollView — multiple slivers, one controller',
              surfaceType: 'controller: bag.sliverCtl',
              subtitle:
                  'Even with several SliverList / SliverToBoxAdapter '
                  'children, a single ScrollController binds the whole '
                  'CustomScrollView\'s viewport. Identity stays one-to-one.',
              accent: rose,
              accentDeep: roseDeep,
              child: SizedBox(
                height: 260,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slateLight),
                  ),
                  child: _ForwardA(
                    controller: bag.sliverCtl,
                    child: (ScrollController c) => CustomScrollView(
                      controller: c,
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[roseDeep, rose],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Sliver header — CustomScrollView',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        for (int h = 0; h < sliverHeaders.length; h++)
                          SliverToBoxAdapter(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.fromLTRB(
                                      8, 4, 8, 2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: roseLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    sliverHeaders[h],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: roseDeep,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                                for (int j = 0; j < 3; j++)
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: slateLight),
                                    ),
                                    child: Text(
                                      '${sliverHeaders[h]} item ${j + 1}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: slateDeep,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Surface E: a second ListView (deep chain)
            scrollSurfaceCard(
              title: 'ListView (deep chain) — code-style entries',
              surfaceType: 'controller: bag.codeListCtl',
              subtitle:
                  'Same shape, different data. Demonstrates a parallel '
                  'controller used independently — State can own as many '
                  'as the surfaces in the tree need.',
              accent: sky,
              accentDeep: indigoDeep,
              child: SizedBox(
                height: 220,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slateLight),
                  ),
                  child: _ForwardA(
                    controller: bag.codeListCtl,
                    child: (ScrollController c) => ListView(
                      controller: c,
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        for (int i = 0; i < 18; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: slateDeep,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '\$ controller.offset // line ${i + 1}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.92),
                                fontSize: 11.5,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Surface F: ListView showing pitfall avoidance
            scrollSurfaceCard(
              title: 'ListView (pitfall guard) — short, scroll-once',
              surfaceType: 'controller: bag.pitfallCtl',
              subtitle:
                  'A short list whose controller is, again, owned by the '
                  'host State. Pitfall cards in Section 7 reference this '
                  'controller by name when illustrating misuse vs use.',
              accent: tealDeep,
              accentDeep: slateDeep,
              child: SizedBox(
                height: 170,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slateLight),
                  ),
                  child: _ForwardA(
                    controller: bag.pitfallCtl,
                    child: (ScrollController c) => ListView(
                      controller: c,
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        for (int i = 0; i < 6; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: i.isEven ? Colors.white : tealLight,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: slateLight),
                            ),
                            child: Text(
                              'Pitfall demo row ${i + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                color: slateDeep,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // Section 6 — Static "live values" panel (no real reads, labelled rows)
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 6] Static live-values panel');

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '06',
        'Static API Surface — As If Read Live',
        <Color>[amber, indigoDeep],
      ),
      proseBox(
        'In a live app you would typically combine the controller with a '
        '`ListenableBuilder` (or `AnimatedBuilder`) to read `offset`, '
        '`position.pixels`, `position.atEdge`, `position.outOfRange`, and '
        '`hasClients`. The rows below are the API surface, labelled — '
        'this demo does not subscribe to the controller because every '
        'rebuild is forbidden by the Fa2 envelope. Each pill on the '
        'right indicates the family of guard you would need before '
        'reading the field in production code.',
      ),
      infoCard(
        'Read-only API rows (static labelling)',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('controller.hasClients',
                'bool — guard required before .position'),
            dataRow('controller.offset',
                'double — equivalent to position.pixels'),
            dataRow('controller.position.pixels',
                'double — current scroll offset'),
            dataRow('controller.position.minScrollExtent',
                'double — usually 0.0'),
            dataRow('controller.position.maxScrollExtent',
                'double — viewport-dependent'),
            dataRow('controller.position.atEdge',
                'bool — pixels at min or max?'),
            dataRow('controller.position.outOfRange',
                'bool — overscrolled past extents?'),
            dataRow('controller.position.userScrollDirection',
                'ScrollDirection — last user gesture'),
            dataRow('controller.position.isScrollingNotifier',
                'ValueListenable<bool>'),
          ],
        ),
        headerGradient: <Color>[amber, amberDeep],
      ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: paper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Guard pills — read these before touching position',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: slateDeep,
              ),
            ),
            const SizedBox(height: 10),
            pillRow(<Widget>[
              ribbonBadge('hasClients ✓', tealLight, tealDeep,
                  icon: Icons.verified),
              ribbonBadge('mounted ✓', indigoLight, indigoDeep,
                  icon: Icons.power_settings_new),
              ribbonBadge('positions.length == 1', amberLight, amberDeep,
                  icon: Icons.exposure_zero),
              ribbonBadge('!disposed', roseLight, roseDeep,
                  icon: Icons.do_not_disturb_on),
            ]),
          ],
        ),
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 7 — Pitfalls and dispose ordering
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 7] Pitfalls');

  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '07',
        'Pitfalls — Five Ways to Misuse a ScrollController',
        <Color>[rose, slateDeep],
      ),
      proseBox(
        'The same five mistakes appear over and over in real-world code, '
        'and each one breaks a different invariant of the State / '
        'StatelessWidget contract. The anti-pattern cards below mirror '
        'production bug reports: construct-in-build, share-across-mounts, '
        'read-before-attach, dispose-too-early, dispose-twice. Each card '
        'is paired with its idiomatic counterpart so that the contrast '
        'is unmistakable.',
      ),
      antiPatternCard(
        'PITFALL 1 — Owning a controller from build()',
        '// BAD\n'
        'Widget build(BuildContext context) {\n'
        '  final ctl = ScrollController(); // new every rebuild!\n'
        '  return ListView(controller: ctl, …);\n'
        '}\n'
        '// Effect: leak + listener pile-up + position never attaches\n'
        '// twice the same way. Tests flicker. Profiler explodes.',
      ),
      codeSnippetCard(
        'good_1.dart — own it in State',
        '// GOOD\n'
        'class _MyState extends State<_MyWidget> {\n'
        '  final ScrollController _ctl = ScrollController();\n'
        '\n'
        '  @override\n'
        '  void dispose() {\n'
        '    _ctl.dispose();\n'
        '    super.dispose();\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  Widget build(BuildContext c) =>\n'
        '      ListView(controller: _ctl, …);\n'
        '}\n',
        accent: teal,
      ),
      antiPatternCard(
        'PITFALL 2 — Sharing one controller across two mounted ListViews',
        '// BAD\n'
        'ListView(controller: _ctl, …),\n'
        'ListView(controller: _ctl, …), // boom: positions == 2\n'
        '// Effect: controller.position throws — "ScrollController\n'
        '// attached to multiple scroll views."',
      ),
      codeSnippetCard(
        'good_2.dart — one controller per mounted surface',
        '// GOOD — one controller per scroll surface that needs one\n'
        'final ScrollController _aCtl = ScrollController();\n'
        'final ScrollController _bCtl = ScrollController();\n'
        '\n'
        'ListView(controller: _aCtl, …),\n'
        'ListView(controller: _bCtl, …),\n',
        accent: indigo,
      ),
      antiPatternCard(
        'PITFALL 3 — Reading position before clients attach',
        '// BAD\n'
        '@override\n'
        'void initState() {\n'
        '  super.initState();\n'
        '  _ctl = ScrollController();\n'
        '  final px = _ctl.position.pixels; // throws — no clients yet\n'
        '}',
      ),
      codeSnippetCard(
        'good_3.dart — guard with hasClients',
        '// GOOD\n'
        'void readOffset() {\n'
        '  if (!_ctl.hasClients) return; // attached?\n'
        '  final double px = _ctl.position.pixels;\n'
        '  // … use px safely\n'
        '}\n',
        accent: amber,
      ),
      antiPatternCard(
        'PITFALL 4 — Disposing in didUpdateWidget instead of dispose',
        '// BAD\n'
        '@override\n'
        'void didUpdateWidget(_MyWidget old) {\n'
        '  super.didUpdateWidget(old);\n'
        '  _ctl.dispose(); // controller killed mid-life\n'
        '  _ctl = ScrollController();\n'
        '}\n'
        '// Effect: any listener that survived now references a dead\n'
        '// controller; .position calls throw "used after dispose".',
      ),
      codeSnippetCard(
        'good_4.dart — only dispose in State.dispose',
        '// GOOD\n'
        '@override\n'
        'void dispose() {\n'
        '  _ctl.dispose(); // exactly once, at the end\n'
        '  super.dispose();\n'
        '}\n',
        accent: rose,
      ),
      antiPatternCard(
        'PITFALL 5 — Double-disposing a controller',
        '// BAD\n'
        '@override\n'
        'void dispose() {\n'
        '  _ctl.dispose();\n'
        '  _ctl.dispose(); // second call throws in debug\n'
        '  super.dispose();\n'
        '}',
      ),
      codeSnippetCard(
        'good_5.dart — single, ordered dispose',
        '// GOOD\n'
        '@override\n'
        'void dispose() {\n'
        '  _ctl.removeListener(_onScroll); // detach listeners first\n'
        '  _ctl.dispose();                 // then dispose once\n'
        '  super.dispose();                // last call\n'
        '}\n',
        accent: tealDeep,
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 8 — Idiomatic full example: a complete StatefulWidget
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 8] Idiomatic complete example');

  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '08',
        'Idiomatic Full Example — Owner, Forwarders, Surface',
        <Color>[indigoDeep, teal],
      ),
      proseBox(
        'The snippet below is the complete, canonical, "just type this" '
        'shape: one StatefulWidget owner, two StatelessWidget '
        'forwarders, one ListView surface. Read it top-to-bottom. Note '
        'how the controller never escapes the StatelessWidgets except '
        'as a constructor argument — they hold a reference, they pass it '
        'down, and they do nothing else with it. This is the exact '
        'pattern the Fa2 family of repros exercises in the interpreter.',
      ),
      codeSnippetCard(
        'idiomatic_full.dart',
        'class Pager extends StatefulWidget {\n'
        '  const Pager({super.key});\n'
        '  @override\n'
        '  State<Pager> createState() => _PagerState();\n'
        '}\n'
        '\n'
        'class _PagerState extends State<Pager> {\n'
        '  // OWNER: created once, lives as long as this State.\n'
        '  final ScrollController _ctl = ScrollController();\n'
        '\n'
        '  @override\n'
        '  void dispose() {\n'
        '    _ctl.dispose();\n'
        '    super.dispose();\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  Widget build(BuildContext c) =>\n'
        '      _OuterWrap(controller: _ctl);\n'
        '}\n'
        '\n'
        'class _OuterWrap extends StatelessWidget {\n'
        '  final ScrollController controller;\n'
        '  const _OuterWrap({required this.controller});\n'
        '  @override\n'
        '  Widget build(BuildContext c) =>\n'
        '      _InnerWrap(controller: controller);\n'
        '}\n'
        '\n'
        'class _InnerWrap extends StatelessWidget {\n'
        '  final ScrollController controller;\n'
        '  const _InnerWrap({required this.controller});\n'
        '  @override\n'
        '  Widget build(BuildContext c) => ListView.builder(\n'
        '    controller: controller,            // BINDS HERE\n'
        '    itemCount: 50,\n'
        '    itemBuilder: (BuildContext c, int i) =>\n'
        '        ListTile(title: Text("item \$i")),\n'
        '  );\n'
        '}\n',
        accent: indigo,
      ),
      infoCard(
        'Why this shape',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('owner', '_PagerState — the only place dispose() lives'),
            dataRow('forwarders',
                '_OuterWrap, _InnerWrap — const, ref-only, no state'),
            dataRow('surface', 'ListView.builder — binds via controller:'),
            dataRow('identity', 'one ScrollController for the whole tree'),
            dataRow('rebuild safe', 'controller never recreated in build()'),
          ],
        ),
        headerGradient: <Color>[teal, indigoDeep],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 9 — Decision table: which surface, which controller policy
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 9] Decision table');

  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '09',
        'Decision Table — Which Surface Needs a Controller?',
        <Color>[teal, rose],
      ),
      proseBox(
        'You do not always need an explicit ScrollController. If a '
        'scroll surface is fire-and-forget — show a list, never read '
        'its offset — you can omit `controller:` entirely and Flutter '
        'will create a PrimaryScrollController-managed default. The '
        'table below summarises when to own one in State versus when '
        'to let the framework own it. The right column lists the '
        'minimal Fa2 wiring (final State field + StatelessWidget '
        'pass-down) so you can copy it directly.',
      ),
      infoCard(
        'When to own a ScrollController',
        DataTable(
          headingRowColor: WidgetStateProperty.all(indigoLight),
          columnSpacing: 12,
          headingTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: indigoDeep,
          ),
          dataTextStyle: const TextStyle(fontSize: 11, color: slateDeep),
          columns: const <DataColumn>[
            DataColumn(label: Text('need')),
            DataColumn(label: Text('own one?')),
            DataColumn(label: Text('wiring')),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Read offset')),
              DataCell(Text('yes')),
              DataCell(Text('State field')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Programmatic scrollTo')),
              DataCell(Text('yes')),
              DataCell(Text('State field')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Sync two lists')),
              DataCell(Text('yes (two)')),
              DataCell(Text('Two State fields')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Pixel-driven UI')),
              DataCell(Text('yes')),
              DataCell(Text('State field + listener')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Just show content')),
              DataCell(Text('no')),
              DataCell(Text('Omit controller:')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('NestedScrollView')),
              DataCell(Text('framework-owned')),
              DataCell(Text('Use innerController')),
            ]),
          ],
        ),
        headerGradient: <Color>[indigo, teal],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 10 — Diagram math: why the chain is O(depth)
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 10] Chain depth math');

  final List<String> depthExamples = <String>[
    'depth 1: Owner → ListView',
    'depth 2: Owner → Wrap → ListView',
    'depth 3: Owner → Wrap → Wrap → ListView',
    'depth 4: Owner → Wrap → Wrap → Wrap → ListView',
    'depth N: Owner → (Wrap × N-1) → ListView',
  ];

  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '10',
        'Chain Depth — O(depth) Pass-Down Is Cheap',
        <Color>[amberDeep, teal],
      ),
      proseBox(
        'Threading a controller through N StatelessWidgets costs you N '
        'constructor arguments and zero allocations of the controller '
        'itself. Because each forwarder is `const` and stateless, the '
        'framework can reuse its Element across rebuilds, so the cost '
        'of the chain at build-time is bounded by `math.max(1, depth)` '
        'object reads. The list below illustrates a few depths. Real '
        'apps almost always live at depth 2–4.',
      ),
      infoCard(
        'Depth examples',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final String s in depthExamples)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.arrow_right,
                        size: 14, color: amberDeep),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        s,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: slateDeep,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            dataRow('math.max(1, depth)',
                '${math.max(1, depthExamples.length)} (this demo)'),
            dataRow('amortised cost', 'O(1) per rebuild after the first'),
          ],
        ),
        headerGradient: <Color>[amberDeep, amber],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 11 — Glossary
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 11] Glossary');

  final Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '11',
        'Glossary — Quick Reference',
        <Color>[indigoDeep, slate],
      ),
      proseBox(
        'A glossary keyed off the types this file exercises. Treat each '
        'definition as the contract between Flutter\'s SDK and the '
        'wider corpus — terms here line up with dartdoc wording so that '
        'a reader switching between this file and the source tree never '
        'sees contradictions. Use the glossary when a section above '
        'refers to a term you have not internalised yet.',
      ),
      infoCard(
        'Definitions',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('StatefulWidget',
                'Widget whose configuration produces a State object'),
            dataRow('State<T>',
                'Mutable, long-lived companion of a StatefulWidget'),
            dataRow('ScrollController',
                'Listenable owner of one or more ScrollPositions'),
            dataRow('ScrollPosition',
                'Per-viewport scrolling state attached to a controller'),
            dataRow('StatelessWidget',
                'Pure function of its inputs; no mutable state'),
            dataRow('ListView',
                'Linear scroll surface; accepts a controller'),
            dataRow('SingleChildScrollView',
                'Wrap-one-child scroll surface; accepts a controller'),
            dataRow('GridView',
                'Two-axis scroll surface; accepts a controller'),
            dataRow('CustomScrollView',
                'Sliver-based scroll surface; accepts a controller'),
            dataRow('dispose()',
                'State teardown; the one place to release controllers'),
            dataRow('hasClients',
                'Whether at least one ScrollPosition is attached'),
            dataRow('Fa2',
                'Repro family — State-owned controller, Stateless chain'),
          ],
        ),
        headerGradient: <Color>[indigoDeep, indigo],
      ),
    ],
  );

  print('===== END STATE-FIELD SCROLL CONTROLLER DEEP VISUAL DEMO =====');

  // ─── Assemble the harness ───
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: indigoDeep,
      colorScheme: ColorScheme.fromSeed(seedColor: indigoDeep),
      scaffoldBackgroundColor: paper,
    ),
    home: Scaffold(
      backgroundColor: paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[indigoDeep, indigo, teal],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: indigoDeep.withValues(alpha: 0.40),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: teal.withValues(alpha: 0.20),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ScrollController in State — Deep Visual Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Fa2 family — owner StatefulWidget, pass-down through '
                      'StatelessWidget chain, bound to a scroll surface.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              section1,
              section2,
              section3,
              section4,
              surfaceGallery(),
              section6,
              section7,
              section8,
              section9,
              section10,
              section11,
            ],
          ),
        ),
      ),
    ),
  );
}
