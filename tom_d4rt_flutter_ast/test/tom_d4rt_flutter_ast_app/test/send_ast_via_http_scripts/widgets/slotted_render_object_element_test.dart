// D4rt deep visual demo: SlottedRenderObjectElement<SlotType, ChildType>.
// Element-tier focus: the element that sits BETWEEN the widget (which carries
// slot → Widget? mappings) and the render object (which holds slot → RO?
// children). This file stays strictly on the element-tier angle; the RO-mixin
// and widget-mixin and concrete widget are handled in sibling demos 413/414/415.
//
// Scenes in order:
//   1. _SroeHero             — CustomPainter: animated signal flow along copper
//                              traces between a widget-tier node (top), the
//                              element junction box (middle), and the render
//                              tree node (bottom). The element is the junction.
//   2. _SroeLiveWiring       — live slotted widget with 3 slots (Header, Body,
//                              Footer) where each slot can be swapped between
//                              _SroeLeafA / _SroeLeafB / _SroeLeafC or removed
//                              entirely. Parent State tally counters track
//                              "rebuilds" (same type → RO preserved, element
//                              updated) vs "destroy+mount" (type changed →
//                              element and RO reconstructed).
//   3. _SroeWiringDiagram    — CustomPainter showing widget tree / element
//                              tree / render tree columns with annotated
//                              method arrows: update(Widget) flows from widget
//                              tier into element; insertRenderObjectChild
//                              flows from element down into render tier;
//                              visitChildren loops within the element tier.
//   4. _SroeMethodTable      — DataTable: visitChildren, forgetChild,
//                              insertRenderObjectChild, moveRenderObjectChild,
//                              removeRenderObjectChild, mount, update, unmount.
//   5. _SroeRebuildVsPreserve— two side-by-side panels rendered with
//                              phosphor-brass glow outlines distinguishing
//                              destroyed-and-remounted children (dim copper,
//                              no brass halo) vs updated-in-place children
//                              (bright brass halo, copper fill).
//   6. _SroeQuotedImpl       — quoted-code card: faithful pseudo-impl of
//                              update(covariant SlottedMultiChildRenderObjectWidget
//                              <SlotType, ChildType> newWidget) walking
//                              widget.slots and calling updateChild(oldElement,
//                              newWidget, slot) with copper syntax accents.
//   7. _SroePitfallCard      — pitfall: usually don't subclass. The framework
//                              creates the element from createElement() on
//                              SlottedMultiChildRenderObjectWidget; subclassing
//                              only when you need bespoke slot storage.
//
// Aesthetic — Element-Tier Slot Wiring. Copper + navy + brass, electrical
// engineering vibe: terminal blocks, circuit traces, signal propagation
// arrows, phosphor glow for "alive" nodes.
//
// Harness contract: top-level `dynamic build(BuildContext context)` returning
// a MaterialApp. No main(), no runApp().

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ============================================================================
// Palette — copper / navy / brass. Top-level constants prefixed with kSroe to
// avoid colliding with sibling 413 / 414 / 415 demo files, which use their own
// palette names.
// ============================================================================

const Color kSroeCopper = Color(0xFFB87333);
const Color kSroeCopperBright = Color(0xFFD08A4A);
const Color kSroeCopperDeep = Color(0xFF8A5423);
const Color kSroeCopperShadow = Color(0xFF5C3715);
const Color kSroeNavy = Color(0xFF0B2545);
const Color kSroeNavyDeep = Color(0xFF06172E);
const Color kSroeNavySoft = Color(0xFF1B3760);
const Color kSroeNavyFog = Color(0xFF2C4A75);
const Color kSroeBrass = Color(0xFFE8C547);
const Color kSroeBrassBright = Color(0xFFF6DC6B);
const Color kSroeBrassDim = Color(0xFFB89B2E);
const Color kSroePhosphor = Color(0xFFA8F0C6);
const Color kSroePhosphorDim = Color(0xFF4FA57A);
const Color kSroePaper = Color(0xFFF2EEDF);
const Color kSroePaperDeep = Color(0xFFE4DEC4);
const Color kSroeTraceGreen = Color(0xFF3A7C3A);
const Color kSroeSolder = Color(0xFFC5B69A);
const Color kSroeInk = Color(0xFF11182B);
const Color kSroeDanger = Color(0xFFCF5C36);

// Spacing.
const double kSroeGapXS = 4;
const double kSroeGapS = 8;
const double kSroeGapM = 12;
const double kSroeGapL = 20;
const double kSroeGapXL = 32;

// Radii.
const double kSroeRadiusS = 6;
const double kSroeRadiusM = 10;
const double kSroeRadiusL = 16;

// ============================================================================
// Typography — kept local so we don't depend on global theming.
// ============================================================================

TextStyle _sroeHeroTitle() => const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w800,
  color: kSroeBrass,
  letterSpacing: 0.3,
);

TextStyle _sroeHeroSub() => const TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: kSroeSolder,
  letterSpacing: 0.4,
  height: 1.35,
);

TextStyle _sroeSectionTitle() => const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: kSroeNavy,
  letterSpacing: 0.2,
);

TextStyle _sroeSectionSub() => const TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w500,
  color: kSroeNavyFog,
  height: 1.35,
);

TextStyle _sroeBodyInk() => const TextStyle(
  fontSize: 13,
  color: kSroeNavy,
  height: 1.4,
);

TextStyle _sroeBodyMuted() => const TextStyle(
  fontSize: 12,
  color: kSroeNavyFog,
  height: 1.35,
);

TextStyle _sroeMono() => const TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: kSroeCopperDeep,
  height: 1.35,
);

TextStyle _sroeTerminalTag() => const TextStyle(
  fontFamily: 'monospace',
  fontSize: 10,
  fontWeight: FontWeight.w700,
  color: kSroeBrass,
  letterSpacing: 0.8,
);

TextStyle _sroeSlotLabel() => const TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: kSroePaper,
  letterSpacing: 0.6,
);

// ============================================================================
// Harness entry.
// ============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SlottedRenderObjectElement — Element-Tier Slot Wiring',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kSroePaper,
      colorScheme: const ColorScheme.light(
        primary: kSroeNavy,
        onPrimary: kSroePaper,
        secondary: kSroeCopper,
        onSecondary: kSroeNavy,
        surface: kSroePaper,
        onSurface: kSroeNavy,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: kSroeNavy),
      ),
      dividerColor: kSroeCopper.withValues(alpha: 0.35),
    ),
    home: const _SroeRoot(),
  );
}

// ============================================================================
// Root scaffold — fixed AppBar over a scrolling column of scenes.
// ============================================================================

class _SroeRoot extends StatelessWidget {
  const _SroeRoot();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSroePaper,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: _SroeAppBar(),
      ),
      body: const _SroeScroll(),
    );
  }
}

class _SroeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: kSroeNavyDeep,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSroeGapL,
            vertical: kSroeGapS,
          ),
          child: Row(
            children: [
              const _SroeAppBarBadge(),
              const SizedBox(width: kSroeGapM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SlottedRenderObjectElement<SlotType, ChildType>',
                      style: _sroeHeroTitle().copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'element-tier slot wiring · 416 · between widget-tier and render-tier',
                      style: _sroeHeroSub().copyWith(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const _SroeAppBarBadge(trailing: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _SroeAppBarBadge extends StatelessWidget {
  const _SroeAppBarBadge({this.trailing = false});

  final bool trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: kSroeNavySoft,
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: kSroeCopper, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: kSroeCopper.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 0.5,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        trailing ? 'RO' : 'EL',
        style: _sroeTerminalTag().copyWith(fontSize: 12),
      ),
    );
  }
}

class _SroeScroll extends StatelessWidget {
  const _SroeScroll();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        kSroeGapL,
        kSroeGapL,
        kSroeGapL,
        kSroeGapXL,
      ),
      children: const [
        _SroeHero(),
        SizedBox(height: kSroeGapXL),
        _SroeLiveWiring(),
        SizedBox(height: kSroeGapXL),
        _SroeWiringDiagramCard(),
        SizedBox(height: kSroeGapXL),
        _SroeMethodTable(),
        SizedBox(height: kSroeGapXL),
        _SroeRebuildVsPreserve(),
        SizedBox(height: kSroeGapXL),
        _SroeQuotedImpl(),
        SizedBox(height: kSroeGapXL),
        _SroePitfallCard(),
        SizedBox(height: kSroeGapXL),
        _SroeFooter(),
      ],
    );
  }
}

// ============================================================================
// Scene 1 — Hero with animated signal flow along copper traces.
// The element is drawn as a JUNCTION BOX in the middle, with copper traces
// leading up to a widget-tier terminal and down to a render-tier terminal.
// Sparks travel along the traces to depict update(newWidget) → element →
// insertRenderObjectChild(slot) signal propagation.
// ============================================================================

class _SroeHero extends StatefulWidget {
  const _SroeHero();

  @override
  State<_SroeHero> createState() => _SroeHeroState();
}

class _SroeHeroState extends State<_SroeHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kSroeRadiusL),
      child: Container(
        height: 320,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kSroeNavyDeep, kSroeNavy, kSroeNavySoft],
          ),
          border: Border.all(color: kSroeCopper, width: 1.1),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _ctrl,
                builder: (ctx, _) => CustomPaint(
                  painter: _SroeHeroPainter(_ctrl.value),
                ),
              ),
            ),
            Positioned(
              left: kSroeGapL,
              top: kSroeGapL,
              right: kSroeGapL,
              child: _SroeHeroTitleBlock(),
            ),
            Positioned(
              right: kSroeGapL,
              bottom: kSroeGapL,
              child: _SroeHeroLegend(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SroeHeroTitleBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kSroeGapS,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: kSroeCopper.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(kSroeRadiusS),
            border: Border.all(
              color: kSroeCopper.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Text(
            'ELEMENT-TIER · 416 · JUNCTION BOX',
            style: _sroeTerminalTag(),
          ),
        ),
        const SizedBox(height: kSroeGapS),
        Text('Signal flow — widget → element → render', style: _sroeHeroTitle()),
        const SizedBox(height: 4),
        SizedBox(
          width: 440,
          child: Text(
            'The SlottedRenderObjectElement is the wiring between the widget '
            'tree and the render tree. Every rebuild, update(newWidget) arrives '
            'at the junction; the element walks slots and decides whether to '
            'update, destroy, or insert children into the render object.',
            style: _sroeHeroSub(),
          ),
        ),
      ],
    );
  }
}

class _SroeHeroLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSroeGapM,
        vertical: kSroeGapS,
      ),
      decoration: BoxDecoration(
        color: kSroeNavyDeep.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: kSroeCopper.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SroeLegendRow(
            swatch: kSroeCopper,
            label: 'copper trace · widget→element→RO',
          ),
          const SizedBox(height: 3),
          _SroeLegendRow(
            swatch: kSroeBrass,
            label: 'brass spark · live update signal',
          ),
          const SizedBox(height: 3),
          _SroeLegendRow(
            swatch: kSroePhosphor,
            label: 'phosphor · element preserved in place',
          ),
          const SizedBox(height: 3),
          _SroeLegendRow(
            swatch: kSroeDanger,
            label: 'red bolt · child destroyed & remounted',
          ),
        ],
      ),
    );
  }
}

class _SroeLegendRow extends StatelessWidget {
  const _SroeLegendRow({required this.swatch, required this.label});

  final Color swatch;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: swatch,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: swatch.withValues(alpha: 0.6),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: kSroeGapS),
        Text(
          label,
          style: _sroeHeroSub().copyWith(
            color: kSroePaper.withValues(alpha: 0.9),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _SroeHeroPainter extends CustomPainter {
  _SroeHeroPainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    _paintGrid(canvas, size);
    _paintTraces(canvas, size);
    _paintNodes(canvas, size);
    _paintSparks(canvas, size);
  }

  void _paintGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kSroeCopper.withValues(alpha: 0.06)
      ..strokeWidth = 0.5;
    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _paintTraces(Canvas canvas, Size size) {
    final widgetY = size.height * 0.20;
    final elementY = size.height * 0.55;
    final renderY = size.height * 0.88;
    final centerX = size.width * 0.5;

    final tracePaint = Paint()
      ..color = kSroeCopper
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..color = kSroeCopperBright.withValues(alpha: 0.35)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // Widget tier → element junction — 3 traces from 3 widget-slot terminals.
    for (int i = 0; i < 3; i++) {
      final xWidget = size.width * (0.22 + i * 0.14);
      final xJunction = centerX + (i - 1) * 24;
      final path = Path()
        ..moveTo(xWidget, widgetY)
        ..cubicTo(
          xWidget,
          widgetY + 40,
          xJunction,
          elementY - 40,
          xJunction,
          elementY - 18,
        );
      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, tracePaint);
    }

    // Element junction → render tier.
    for (int i = 0; i < 3; i++) {
      final xRender = size.width * (0.64 + i * 0.10);
      final xJunction = centerX + (i - 1) * 24;
      final path = Path()
        ..moveTo(xJunction, elementY + 18)
        ..cubicTo(
          xJunction,
          elementY + 60,
          xRender,
          renderY - 40,
          xRender,
          renderY,
        );
      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, tracePaint);
    }
  }

  void _paintNodes(Canvas canvas, Size size) {
    final widgetY = size.height * 0.20;
    final elementY = size.height * 0.55;
    final renderY = size.height * 0.88;

    // Widget terminals.
    for (int i = 0; i < 3; i++) {
      final x = size.width * (0.22 + i * 0.14);
      _paintTerminal(
        canvas,
        Offset(x, widgetY),
        label: ['Header', 'Body', 'Footer'][i],
        accent: kSroeCopper,
      );
    }

    // Render terminals.
    for (int i = 0; i < 3; i++) {
      final x = size.width * (0.64 + i * 0.10);
      _paintTerminal(
        canvas,
        Offset(x, renderY),
        label: 'RO${i + 1}',
        accent: kSroeBrass,
      );
    }

    // Element junction box.
    final cx = size.width * 0.5;
    final junctionRect = Rect.fromCenter(
      center: Offset(cx, elementY),
      width: 170,
      height: 48,
    );
    final rr = RRect.fromRectAndRadius(
      junctionRect,
      const Radius.circular(kSroeRadiusS),
    );
    canvas.drawRRect(
      rr,
      Paint()..color = kSroeNavy,
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..color = kSroeBrass
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );
    // Phosphor halo on the junction.
    canvas.drawRRect(
      rr.inflate(4),
      Paint()
        ..color = kSroeBrass.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    // Junction label.
    _paintText(
      canvas,
      'SlottedRenderObjectElement',
      junctionRect.center,
      style: _sroeTerminalTag().copyWith(fontSize: 11),
      align: TextAlign.center,
    );
  }

  void _paintTerminal(
    Canvas canvas,
    Offset center, {
    required String label,
    required Color accent,
  }) {
    final rect = Rect.fromCenter(center: center, width: 72, height: 22);
    final rr = RRect.fromRectAndRadius(rect, const Radius.circular(3));
    canvas.drawRRect(
      rr,
      Paint()..color = kSroeNavySoft,
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    _paintText(
      canvas,
      label,
      rect.center,
      style: _sroeTerminalTag().copyWith(
        color: accent,
        fontSize: 10,
      ),
      align: TextAlign.center,
    );
  }

  void _paintSparks(Canvas canvas, Size size) {
    final widgetY = size.height * 0.20;
    final elementY = size.height * 0.55;
    final renderY = size.height * 0.88;
    final centerX = size.width * 0.5;
    final sparkPaint = Paint()
      ..color = kSroeBrassBright
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      final phase = (t + i * 0.33) % 1.0;
      // Upper trace spark — from widget tier down to junction.
      if (phase < 0.5) {
        final local = phase * 2;
        final xWidget = size.width * (0.22 + i * 0.14);
        final xJunction = centerX + (i - 1) * 24;
        final p = _cubicPoint(
          Offset(xWidget, widgetY),
          Offset(xWidget, widgetY + 40),
          Offset(xJunction, elementY - 40),
          Offset(xJunction, elementY - 18),
          local,
        );
        canvas.drawCircle(p, 3, sparkPaint);
        canvas.drawCircle(
          p,
          6,
          Paint()
            ..color = kSroeBrassBright.withValues(alpha: 0.45)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
        );
      } else {
        // Lower trace spark — from junction down to RO tier.
        final local = (phase - 0.5) * 2;
        final xRender = size.width * (0.64 + i * 0.10);
        final xJunction = centerX + (i - 1) * 24;
        final p = _cubicPoint(
          Offset(xJunction, elementY + 18),
          Offset(xJunction, elementY + 60),
          Offset(xRender, renderY - 40),
          Offset(xRender, renderY),
          local,
        );
        canvas.drawCircle(p, 3, sparkPaint);
        canvas.drawCircle(
          p,
          6,
          Paint()
            ..color = kSroePhosphor.withValues(alpha: 0.35)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
        );
      }
    }
  }

  Offset _cubicPoint(Offset p0, Offset p1, Offset p2, Offset p3, double t) {
    final u = 1 - t;
    final x = u * u * u * p0.dx +
        3 * u * u * t * p1.dx +
        3 * u * t * t * p2.dx +
        t * t * t * p3.dx;
    final y = u * u * u * p0.dy +
        3 * u * u * t * p1.dy +
        3 * u * t * t * p2.dy +
        t * t * t * p3.dy;
    return Offset(x, y);
  }

  void _paintText(
    Canvas canvas,
    String text,
    Offset center, {
    required TextStyle style,
    TextAlign align = TextAlign.left,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: align,
    )..layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _SroeHeroPainter old) => old.t != t;
}

// ============================================================================
// Scene 2 — Live wiring. A minimal SlottedMultiChildRenderObjectWidget with
// three named slots (header, body, footer). Each slot has three controls:
//   · A: use leaf of type _SroeLeafWidgetA
//   · B: use leaf of type _SroeLeafWidgetB
//   · C: use leaf of type _SroeLeafWidgetC
//   · –: remove the slot entirely
// When the widget type in a slot STAYS the same, the element calls updateChild
// with the existing child element → RO preserved; when the type CHANGES, the
// old element is destroyed and a fresh one is mounted → counted as a rebuild.
// Tally counters are kept in _SroeLiveWiringState (parent State) via a
// _SroeSlotTelemetry value-object map keyed by slot id.
// ============================================================================

enum _SroeSlotId { header, body, footer }

enum _SroeLeafKind { none, a, b, c }

class _SroeSlotTelemetry {
  _SroeSlotTelemetry();
  int preservedUpdates = 0;
  int destroyedMounts = 0;
  int currentGenerationId = 0;
}

class _SroeLiveWiring extends StatefulWidget {
  const _SroeLiveWiring();

  @override
  State<_SroeLiveWiring> createState() => _SroeLiveWiringState();
}

class _SroeLiveWiringState extends State<_SroeLiveWiring> {
  final Map<_SroeSlotId, _SroeLeafKind> _slots = {
    _SroeSlotId.header: _SroeLeafKind.a,
    _SroeSlotId.body: _SroeLeafKind.b,
    _SroeSlotId.footer: _SroeLeafKind.c,
  };
  final Map<_SroeSlotId, _SroeLeafKind> _prevSlots = {
    _SroeSlotId.header: _SroeLeafKind.a,
    _SroeSlotId.body: _SroeLeafKind.b,
    _SroeSlotId.footer: _SroeLeafKind.c,
  };
  final Map<_SroeSlotId, _SroeSlotTelemetry> _tally = {
    _SroeSlotId.header: _SroeSlotTelemetry(),
    _SroeSlotId.body: _SroeSlotTelemetry(),
    _SroeSlotId.footer: _SroeSlotTelemetry(),
  };
  int _nudge = 0;

  void _assign(_SroeSlotId slot, _SroeLeafKind next) {
    setState(() {
      final prev = _slots[slot] ?? _SroeLeafKind.none;
      final tally = _tally[slot]!;
      if (prev == next) {
        // Same kind → element will diff, RO preserved, updates in place.
        tally.preservedUpdates += 1;
      } else if (prev != _SroeLeafKind.none && next != _SroeLeafKind.none) {
        // Different leaf kind → element destroyed, new one mounted.
        tally.destroyedMounts += 1;
        tally.currentGenerationId += 1;
      } else if (prev == _SroeLeafKind.none && next != _SroeLeafKind.none) {
        // Slot was empty → fresh mount.
        tally.destroyedMounts += 1;
        tally.currentGenerationId += 1;
      } else {
        // Next is none → element unmount.
        tally.destroyedMounts += 1;
        tally.currentGenerationId += 1;
      }
      _prevSlots[slot] = prev;
      _slots[slot] = next;
      _nudge += 1;
    });
  }

  void _nudgeAll() {
    setState(() {
      for (final id in _SroeSlotId.values) {
        _tally[id]!.preservedUpdates += 1;
      }
      _nudge += 1;
    });
  }

  void _resetAll() {
    setState(() {
      for (final id in _SroeSlotId.values) {
        _tally[id] = _SroeSlotTelemetry();
      }
      _nudge += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SroeCard(
      title: 'Live element wiring — toggle slots, watch tallies',
      subtitle:
          'Each slot preserves its element when the widget type is the same, '
          'destroying + remounting when the type changes. The RO beneath is '
          'updated in place when preserved; rebuilt when remounted.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: kSroeGapS),
          _SroeLiveToolbar(
            onNudge: _nudgeAll,
            onReset: _resetAll,
          ),
          const SizedBox(height: kSroeGapM),
          _SroeLiveSurface(
            slots: _slots,
            tally: _tally,
            nudge: _nudge,
            onAssign: _assign,
          ),
        ],
      ),
    );
  }
}

class _SroeLiveToolbar extends StatelessWidget {
  const _SroeLiveToolbar({required this.onNudge, required this.onReset});

  final VoidCallback onNudge;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SroeToolbarButton(
          label: 'nudge all · preserve',
          icon: Icons.bolt,
          tint: kSroeBrass,
          onPressed: onNudge,
        ),
        const SizedBox(width: kSroeGapS),
        _SroeToolbarButton(
          label: 'reset tallies',
          icon: Icons.restart_alt,
          tint: kSroeCopper,
          onPressed: onReset,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kSroeGapS,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: kSroeNavy.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(kSroeRadiusS),
            border: Border.all(
              color: kSroeNavy.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            'element-tier · live',
            style: _sroeTerminalTag().copyWith(color: kSroeNavy),
          ),
        ),
      ],
    );
  }
}

class _SroeToolbarButton extends StatelessWidget {
  const _SroeToolbarButton({
    required this.label,
    required this.icon,
    required this.tint,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color tint;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(kSroeRadiusS),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kSroeGapM,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: kSroePaperDeep,
          borderRadius: BorderRadius.circular(kSroeRadiusS),
          border: Border.all(color: tint.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: tint),
            const SizedBox(width: kSroeGapXS),
            Text(
              label,
              style: _sroeBodyInk().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SroeLiveSurface extends StatelessWidget {
  const _SroeLiveSurface({
    required this.slots,
    required this.tally,
    required this.nudge,
    required this.onAssign,
  });

  final Map<_SroeSlotId, _SroeLeafKind> slots;
  final Map<_SroeSlotId, _SroeSlotTelemetry> tally;
  final int nudge;
  final void Function(_SroeSlotId, _SroeLeafKind) onAssign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSroeGapM),
      decoration: BoxDecoration(
        color: kSroeNavy,
        borderRadius: BorderRadius.circular(kSroeRadiusM),
        border: Border.all(color: kSroeCopper.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SroeTriSlotFrame(slots: slots, nudge: nudge),
          const SizedBox(height: kSroeGapM),
          _SroeTallyRowBank(slots: slots, tally: tally, onAssign: onAssign),
        ],
      ),
    );
  }
}

class _SroeTriSlotFrame extends StatelessWidget {
  const _SroeTriSlotFrame({required this.slots, required this.nudge});

  final Map<_SroeSlotId, _SroeLeafKind> slots;
  final int nudge;

  @override
  Widget build(BuildContext context) {
    return _SroeSlottedFrameWidget(
      headerWidget: _widgetFor(_SroeSlotId.header),
      bodyWidget: _widgetFor(_SroeSlotId.body),
      footerWidget: _widgetFor(_SroeSlotId.footer),
    );
  }

  Widget? _widgetFor(_SroeSlotId id) {
    final kind = slots[id] ?? _SroeLeafKind.none;
    switch (kind) {
      case _SroeLeafKind.none:
        return null;
      case _SroeLeafKind.a:
        return _SroeLeafWidgetA(slotId: id, pulse: nudge);
      case _SroeLeafKind.b:
        return _SroeLeafWidgetB(slotId: id, pulse: nudge);
      case _SroeLeafKind.c:
        return _SroeLeafWidgetC(slotId: id, pulse: nudge);
    }
  }
}

// ----------------------------------------------------------------------------
// Minimal SlottedMultiChildRenderObjectWidget subclass with three named slots.
// The framework creates the SlottedRenderObjectElement for us via
// createElement(); we DON'T subclass the element (see pitfall card scene 7).
// ----------------------------------------------------------------------------

class _SroeSlottedFrameWidget
    extends SlottedMultiChildRenderObjectWidget<_SroeSlotId, RenderBox> {
  const _SroeSlottedFrameWidget({
    this.headerWidget,
    this.bodyWidget,
    this.footerWidget,
  });

  final Widget? headerWidget;
  final Widget? bodyWidget;
  final Widget? footerWidget;

  @override
  Iterable<_SroeSlotId> get slots => _SroeSlotId.values;

  @override
  Widget? childForSlot(_SroeSlotId slot) {
    switch (slot) {
      case _SroeSlotId.header:
        return headerWidget;
      case _SroeSlotId.body:
        return bodyWidget;
      case _SroeSlotId.footer:
        return footerWidget;
    }
  }

  @override
  SlottedContainerRenderObjectMixin<_SroeSlotId, RenderBox>
      createRenderObject(BuildContext context) {
    return _SroeFrameRender();
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _SroeFrameRender renderObject,
  ) {
    // No configuration beyond children; nothing to do.
  }
}

class _SroeFrameRender extends RenderBox
    with SlottedContainerRenderObjectMixin<_SroeSlotId, RenderBox> {
  RenderBox? get _header => childForSlot(_SroeSlotId.header);
  RenderBox? get _body => childForSlot(_SroeSlotId.body);
  RenderBox? get _footer => childForSlot(_SroeSlotId.footer);

  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      ?_header,
      ?_body,
      ?_footer,
    ];
  }

  @override
  void performLayout() {
    final w = constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
    final childConstraints =
        BoxConstraints(minWidth: w, maxWidth: w, minHeight: 0, maxHeight: 96);
    double y = 0;
    for (final ch in <RenderBox?>[_header, _body, _footer]) {
      if (ch == null) continue;
      ch.layout(childConstraints, parentUsesSize: true);
      final data = ch.parentData;
      if (data is BoxParentData) {
        data.offset = Offset(0, y);
      }
      y += ch.size.height + 8;
    }
    size = Size(w, math.max(64, y));
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = BoxParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    for (final ch in children) {
      final d = ch.parentData;
      if (d is BoxParentData) {
        context.paintChild(ch, offset + d.offset);
      }
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final ch in children) {
      final d = ch.parentData;
      if (d is! BoxParentData) continue;
      final hit = result.addWithPaintOffset(
        offset: d.offset,
        position: position,
        hitTest: (r, p) => ch.hitTest(r, position: p),
      );
      if (hit) return true;
    }
    return false;
  }
}

// ----------------------------------------------------------------------------
// Leaf widgets — three distinct widget types. Keeping them distinct is the
// whole point of the demo: _SroeLeafWidgetA.canUpdate(A) == true preserves
// the element (RO kept), whereas _SroeLeafWidgetA → _SroeLeafWidgetB forces
// the old element out and inflates a new one (destroy+mount).
// ----------------------------------------------------------------------------

class _SroeLeafWidgetA extends StatelessWidget {
  const _SroeLeafWidgetA({required this.slotId, required this.pulse});
  final _SroeSlotId slotId;
  final int pulse;

  @override
  Widget build(BuildContext context) {
    return _SroeLeafBody(
      label: 'A · ${slotId.name}',
      color: kSroeCopper,
      accent: kSroeBrass,
      pulse: pulse,
      tag: 'LeafA',
    );
  }
}

class _SroeLeafWidgetB extends StatelessWidget {
  const _SroeLeafWidgetB({required this.slotId, required this.pulse});
  final _SroeSlotId slotId;
  final int pulse;

  @override
  Widget build(BuildContext context) {
    return _SroeLeafBody(
      label: 'B · ${slotId.name}',
      color: kSroeNavySoft,
      accent: kSroePhosphor,
      pulse: pulse,
      tag: 'LeafB',
    );
  }
}

class _SroeLeafWidgetC extends StatelessWidget {
  const _SroeLeafWidgetC({required this.slotId, required this.pulse});
  final _SroeSlotId slotId;
  final int pulse;

  @override
  Widget build(BuildContext context) {
    return _SroeLeafBody(
      label: 'C · ${slotId.name}',
      color: kSroeBrass,
      accent: kSroeCopperBright,
      pulse: pulse,
      tag: 'LeafC',
    );
  }
}

class _SroeLeafBody extends StatelessWidget {
  const _SroeLeafBody({
    required this.label,
    required this.color,
    required this.accent,
    required this.pulse,
    required this.tag,
  });

  final String label;
  final Color color;
  final Color accent;
  final int pulse;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSroeGapM,
        vertical: kSroeGapS,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: accent, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.45),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.9),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: kSroeGapS),
          Expanded(
            child: Text(
              label,
              style: _sroeSlotLabel(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              '$tag · p=$pulse',
              style: _sroeTerminalTag().copyWith(fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Tally rows — each slot has three leaf buttons + a "remove" button, plus
// live counters for preserved-updates and destroyed-mounts.
// ----------------------------------------------------------------------------

class _SroeTallyRowBank extends StatelessWidget {
  const _SroeTallyRowBank({
    required this.slots,
    required this.tally,
    required this.onAssign,
  });

  final Map<_SroeSlotId, _SroeLeafKind> slots;
  final Map<_SroeSlotId, _SroeSlotTelemetry> tally;
  final void Function(_SroeSlotId, _SroeLeafKind) onAssign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final id in _SroeSlotId.values) ...[
          _SroeTallyRow(
            slotId: id,
            current: slots[id] ?? _SroeLeafKind.none,
            telemetry: tally[id]!,
            onAssign: (k) => onAssign(id, k),
          ),
          if (id != _SroeSlotId.footer) const SizedBox(height: kSroeGapS),
        ],
      ],
    );
  }
}

class _SroeTallyRow extends StatelessWidget {
  const _SroeTallyRow({
    required this.slotId,
    required this.current,
    required this.telemetry,
    required this.onAssign,
  });

  final _SroeSlotId slotId;
  final _SroeLeafKind current;
  final _SroeSlotTelemetry telemetry;
  final void Function(_SroeLeafKind) onAssign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSroeGapS),
      decoration: BoxDecoration(
        color: kSroeNavyDeep,
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: kSroeCopper.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: kSroeCopper.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: kSroeCopper.withValues(alpha: 0.5)),
            ),
            alignment: Alignment.center,
            child: Text(
              slotId.name.toUpperCase(),
              style: _sroeTerminalTag(),
            ),
          ),
          const SizedBox(width: kSroeGapS),
          _SroeLeafButton(
            kind: _SroeLeafKind.a,
            current: current,
            onPressed: () => onAssign(_SroeLeafKind.a),
          ),
          _SroeLeafButton(
            kind: _SroeLeafKind.b,
            current: current,
            onPressed: () => onAssign(_SroeLeafKind.b),
          ),
          _SroeLeafButton(
            kind: _SroeLeafKind.c,
            current: current,
            onPressed: () => onAssign(_SroeLeafKind.c),
          ),
          _SroeLeafButton(
            kind: _SroeLeafKind.none,
            current: current,
            onPressed: () => onAssign(_SroeLeafKind.none),
          ),
          const Spacer(),
          _SroeCounterChip(
            label: 'preserved',
            value: telemetry.preservedUpdates,
            color: kSroePhosphor,
          ),
          const SizedBox(width: kSroeGapXS),
          _SroeCounterChip(
            label: 'destroyed',
            value: telemetry.destroyedMounts,
            color: kSroeDanger,
          ),
          const SizedBox(width: kSroeGapXS),
          _SroeCounterChip(
            label: 'gen',
            value: telemetry.currentGenerationId,
            color: kSroeBrass,
          ),
        ],
      ),
    );
  }
}

class _SroeLeafButton extends StatelessWidget {
  const _SroeLeafButton({
    required this.kind,
    required this.current,
    required this.onPressed,
  });
  final _SroeLeafKind kind;
  final _SroeLeafKind current;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final active = kind == current;
    final tint = _tintOf(kind);
    final label = _labelOf(kind);
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(3),
        onTap: onPressed,
        child: Container(
          width: 28,
          height: 26,
          decoration: BoxDecoration(
            color: active
                ? tint.withValues(alpha: 0.85)
                : kSroeNavy.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: active ? kSroeBrass : tint.withValues(alpha: 0.5),
              width: active ? 1.6 : 1,
            ),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: kSroeBrass.withValues(alpha: 0.6),
                      blurRadius: 6,
                    ),
                  ]
                : const [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: _sroeTerminalTag().copyWith(
              color: active ? kSroeNavyDeep : kSroePaper,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  static Color _tintOf(_SroeLeafKind k) {
    switch (k) {
      case _SroeLeafKind.a:
        return kSroeCopper;
      case _SroeLeafKind.b:
        return kSroeNavySoft;
      case _SroeLeafKind.c:
        return kSroeBrass;
      case _SroeLeafKind.none:
        return kSroeDanger;
    }
  }

  static String _labelOf(_SroeLeafKind k) {
    switch (k) {
      case _SroeLeafKind.a:
        return 'A';
      case _SroeLeafKind.b:
        return 'B';
      case _SroeLeafKind.c:
        return 'C';
      case _SroeLeafKind.none:
        return '–';
    }
  }
}

class _SroeCounterChip extends StatelessWidget {
  const _SroeCounterChip({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: _sroeTerminalTag().copyWith(
              color: color,
              fontSize: 9,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$value',
            style: _sroeMono().copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Shared card shell — navy header strip with copper bezel, paper body.
// ============================================================================

class _SroeCard extends StatelessWidget {
  const _SroeCard({
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
      decoration: BoxDecoration(
        color: kSroePaper,
        borderRadius: BorderRadius.circular(kSroeRadiusL),
        border: Border.all(color: kSroeCopper.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: kSroeNavy.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
              kSroeGapL,
              kSroeGapM,
              kSroeGapL,
              kSroeGapM,
            ),
            decoration: BoxDecoration(
              color: kSroeNavy,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(kSroeRadiusL),
                topRight: Radius.circular(kSroeRadiusL),
              ),
              border: Border(
                bottom: BorderSide(
                  color: kSroeCopper,
                  width: 1.2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: _sroeSectionTitle().copyWith(color: kSroeBrass),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: _sroeSectionSub().copyWith(
                    color: kSroePaper.withValues(alpha: 0.75),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kSroeGapL),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Scene 3 — Wiring diagram CustomPainter.
// Three columns: widget tier | element tier | render tier. Arrows between
// them annotated with method names that fire across that edge.
// ============================================================================

class _SroeWiringDiagramCard extends StatelessWidget {
  const _SroeWiringDiagramCard();

  @override
  Widget build(BuildContext context) {
    return _SroeCard(
      title: 'Wiring diagram — method flow across tiers',
      subtitle:
          'Widget tier carries slot→Widget? mappings. Element tier is the '
          'junction that diffs per slot. Render tier is where children are '
          'actually inserted, moved, removed.',
      child: SizedBox(
        height: 360,
        child: CustomPaint(
          painter: _SroeWiringDiagramPainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _SroeWiringDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _paintBoard(canvas, size);
    _paintTierLanes(canvas, size);
    _paintArrows(canvas, size);
    _paintLabels(canvas, size);
  }

  void _paintBoard(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()..color = kSroePaperDeep,
    );
    final grid = Paint()
      ..color = kSroeNavy.withValues(alpha: 0.04)
      ..strokeWidth = 0.5;
    const step = 18.0;
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
  }

  void _paintTierLanes(Canvas canvas, Size size) {
    final colWidth = size.width / 3;
    const lanes = <_SroeLaneSpec>[
      _SroeLaneSpec(
        title: 'WIDGET TIER',
        subtitle: 'slot → Widget?',
        items: [
          'SlottedMultiChildRenderObjectWidget',
          '  · slots (Iterable<SlotType>)',
          '  · childForSlot(SlotType)',
          '  · createElement() → element',
          '  · createRenderObject(ctx)',
        ],
        accent: kSroeCopper,
      ),
      _SroeLaneSpec(
        title: 'ELEMENT TIER',
        subtitle: 'slot → Element?',
        items: [
          'SlottedRenderObjectElement',
          '  · mount(parent, newSlot)',
          '  · update(newWidget)',
          '  · visitChildren(visitor)',
          '  · forgetChild(child)',
          '  · unmount()',
        ],
        accent: kSroeBrass,
      ),
      _SroeLaneSpec(
        title: 'RENDER TIER',
        subtitle: 'slot → RO?',
        items: [
          'SlottedContainerRenderObjectMixin',
          '  · childForSlot(SlotType)',
          '  · children (Iterable<RO>)',
          '  · insertRenderObjectChild',
          '  · moveRenderObjectChild',
          '  · removeRenderObjectChild',
        ],
        accent: kSroeNavy,
      ),
    ];

    for (int i = 0; i < 3; i++) {
      final rect = Rect.fromLTWH(
        colWidth * i + 8,
        10,
        colWidth - 16,
        size.height - 20,
      );
      _paintLane(canvas, rect, lanes[i]);
    }
  }

  void _paintLane(Canvas canvas, Rect rect, _SroeLaneSpec spec) {
    final rr = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(kSroeRadiusS),
    );
    canvas.drawRRect(
      rr,
      Paint()..color = Colors.white.withValues(alpha: 0.7),
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..color = spec.accent.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    // Header strip.
    final header = Rect.fromLTWH(rect.left, rect.top, rect.width, 28);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        header,
        topLeft: const Radius.circular(kSroeRadiusS),
        topRight: const Radius.circular(kSroeRadiusS),
      ),
      Paint()..color = spec.accent.withValues(alpha: 0.9),
    );
    _paintText(
      canvas,
      spec.title,
      Offset(header.left + 10, header.top + 6),
      style: _sroeTerminalTag().copyWith(
        color:
            spec.accent == kSroeBrass ? kSroeNavyDeep : kSroePaper,
      ),
    );
    _paintText(
      canvas,
      spec.subtitle,
      Offset(rect.left + 10, rect.top + 36),
      style: _sroeBodyMuted().copyWith(fontSize: 10.5),
    );

    double y = rect.top + 56;
    for (final item in spec.items) {
      _paintText(
        canvas,
        item,
        Offset(rect.left + 10, y),
        style: _sroeMono().copyWith(
          fontSize: 10.5,
          color: item.startsWith('  ') ? kSroeNavyFog : kSroeNavy,
          fontWeight:
              item.startsWith('  ') ? FontWeight.w400 : FontWeight.w700,
        ),
      );
      y += 18;
    }
  }

  void _paintArrows(Canvas canvas, Size size) {
    final colWidth = size.width / 3;

    // update(Widget newWidget) — widget tier → element tier.
    _paintArrow(
      canvas,
      Offset(colWidth - 8, 90),
      Offset(colWidth + 8, 90),
      label: 'update(newWidget)',
      accent: kSroeCopper,
    );
    // visitChildren loop within element lane.
    _paintLoop(
      canvas,
      Offset(colWidth + colWidth / 2, 190),
      radius: 24,
      label: 'visitChildren(visitor)',
      accent: kSroeBrass,
    );
    // insertRenderObjectChild — element tier → render tier.
    _paintArrow(
      canvas,
      Offset(colWidth * 2 - 8, 120),
      Offset(colWidth * 2 + 8, 120),
      label: 'insertRenderObjectChild',
      accent: kSroeBrass,
    );
    _paintArrow(
      canvas,
      Offset(colWidth * 2 - 8, 160),
      Offset(colWidth * 2 + 8, 160),
      label: 'moveRenderObjectChild',
      accent: kSroeBrass,
    );
    _paintArrow(
      canvas,
      Offset(colWidth * 2 - 8, 200),
      Offset(colWidth * 2 + 8, 200),
      label: 'removeRenderObjectChild',
      accent: kSroeDanger,
    );
    // forgetChild — within element lane (self arrow).
    _paintArrow(
      canvas,
      Offset(colWidth + 12, 250),
      Offset(colWidth * 2 - 12, 250),
      label: 'forgetChild(child)',
      accent: kSroeCopperDeep,
    );
  }

  void _paintArrow(
    Canvas canvas,
    Offset from,
    Offset to, {
    required String label,
    required Color accent,
  }) {
    final paint = Paint()
      ..color = accent
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(from, to, paint);

    // Arrowhead.
    const headLen = 8.0;
    final dir = to - from;
    final len = dir.distance == 0 ? 1.0 : dir.distance;
    final ux = dir.dx / len;
    final uy = dir.dy / len;
    final head1 = Offset(to.dx - ux * headLen - uy * 4, to.dy - uy * headLen + ux * 4);
    final head2 = Offset(to.dx - ux * headLen + uy * 4, to.dy - uy * headLen - ux * 4);
    final headPath = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(head1.dx, head1.dy)
      ..lineTo(head2.dx, head2.dy)
      ..close();
    canvas.drawPath(headPath, Paint()..color = accent);

    _paintText(
      canvas,
      label,
      Offset((from.dx + to.dx) / 2 - 70, from.dy - 18),
      style: _sroeMono().copyWith(color: accent, fontSize: 10),
    );
  }

  void _paintLoop(
    Canvas canvas,
    Offset center, {
    required double radius,
    required String label,
    required Color accent,
  }) {
    final paint = Paint()
      ..color = accent
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 1.7, false, paint);
    // Arrowhead at the end of the arc.
    final angle = -math.pi / 2 + math.pi * 1.7;
    final tip = Offset(
      center.dx + math.cos(angle) * radius,
      center.dy + math.sin(angle) * radius,
    );
    canvas.drawCircle(tip, 3, Paint()..color = accent);
    _paintText(
      canvas,
      label,
      Offset(center.dx - 80, center.dy + radius + 4),
      style: _sroeMono().copyWith(color: accent, fontSize: 10),
    );
  }

  void _paintLabels(Canvas canvas, Size size) {
    // Left rail marker.
    _paintText(
      canvas,
      'method flow',
      Offset(8, size.height - 20),
      style: _sroeTerminalTag().copyWith(color: kSroeNavyFog),
    );
  }

  void _paintText(
    Canvas canvas,
    String text,
    Offset topLeft, {
    required TextStyle style,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, topLeft);
  }

  @override
  bool shouldRepaint(covariant _SroeWiringDiagramPainter old) => false;
}

class _SroeLaneSpec {
  const _SroeLaneSpec({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.accent,
  });
  final String title;
  final String subtitle;
  final List<String> items;
  final Color accent;
}

// ============================================================================
// Scene 4 — Method directory DataTable.
// ============================================================================

class _SroeMethodTable extends StatelessWidget {
  const _SroeMethodTable();

  @override
  Widget build(BuildContext context) {
    return _SroeCard(
      title: 'Method directory — element-tier surface area',
      subtitle:
          'Every row below is a method the element implements or forwards '
          'to its render object. Ordering matches the life of a slot entry: '
          'mount → update → visit/forget → insert/move/remove → unmount.',
      child: _SroeMethodDataTable(),
    );
  }
}

class _SroeMethodDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const rows = <List<String>>[
      [
        'mount',
        'Element',
        'Inflates child widgets per slot into elements, then forwards into RO.',
      ],
      [
        'update',
        'Element',
        'Receives newWidget; walks slots and calls updateChild per slot.',
      ],
      [
        'updateChild',
        'Element · framework',
        'For each slot: reuse existing element if Widget.canUpdate matches.',
      ],
      [
        'visitChildren',
        'Element',
        'Yields every live child element across all occupied slots in order.',
      ],
      [
        'forgetChild',
        'Element',
        'Called by framework to detach a child that was deactivated elsewhere.',
      ],
      [
        'insertRenderObjectChild',
        'Element → RO',
        'Inserts a freshly-mounted RO child into the RO at the supplied slot.',
      ],
      [
        'moveRenderObjectChild',
        'Element → RO',
        'Reassigns a preserved RO child from one slot to another slot.',
      ],
      [
        'removeRenderObjectChild',
        'Element → RO',
        'Detaches a RO child from its slot when the element is dropped.',
      ],
      [
        'unmount',
        'Element',
        'Tears the element down; the framework disposes the RO afterward.',
      ],
    ];
    return _SroeRawDataTable(
      columns: const ['method', 'tier', 'responsibility'],
      rows: rows,
    );
  }
}

class _SroeRawDataTable extends StatelessWidget {
  const _SroeRawDataTable({required this.columns, required this.rows});
  final List<String> columns;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSroePaperDeep,
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: kSroeCopper.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kSroeGapM,
              vertical: kSroeGapS,
            ),
            decoration: BoxDecoration(
              color: kSroeNavy,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(kSroeRadiusS),
                topRight: Radius.circular(kSroeRadiusS),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    columns[0],
                    style: _sroeTerminalTag(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    columns[1],
                    style: _sroeTerminalTag(),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    columns[2],
                    style: _sroeTerminalTag(),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kSroeGapM,
                vertical: 8,
              ),
              color: i.isEven
                  ? Colors.white.withValues(alpha: 0.35)
                  : Colors.white.withValues(alpha: 0.15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i][0],
                      style: _sroeMono().copyWith(
                        color: kSroeCopperDeep,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i][1],
                      style: _sroeBodyMuted(),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text(
                      rows[i][2],
                      style: _sroeBodyInk(),
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

// ============================================================================
// Scene 5 — Rebuild vs preserve. Two parallel panels. One shows a leaf being
// destroyed and remounted (dim copper, red bolt), the other shows a leaf
// being updated in place (bright brass halo, phosphor accents).
// ============================================================================

class _SroeRebuildVsPreserve extends StatefulWidget {
  const _SroeRebuildVsPreserve();

  @override
  State<_SroeRebuildVsPreserve> createState() =>
      _SroeRebuildVsPreserveState();
}

class _SroeRebuildVsPreserveState extends State<_SroeRebuildVsPreserve>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          setState(() => _tick += 1);
          _ctrl.forward(from: 0);
        }
      });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SroeCard(
      title: 'Rebuild vs preserve — two parallel slot stories',
      subtitle:
          'Left: element destroyed and a fresh one mounted (different widget '
          'type in the same slot). Right: element updated in place (same '
          'widget type, new configuration).',
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (ctx, _) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _SroeDestroyPanel(tick: _tick, t: _ctrl.value),
            ),
            const SizedBox(width: kSroeGapM),
            Expanded(
              child: _SroePreservePanel(tick: _tick, t: _ctrl.value),
            ),
          ],
        ),
      ),
    );
  }
}

class _SroeDestroyPanel extends StatelessWidget {
  const _SroeDestroyPanel({required this.tick, required this.t});
  final int tick;
  final double t;

  @override
  Widget build(BuildContext context) {
    final generation = tick;
    final fade = (1 - t).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(kSroeGapM),
      decoration: BoxDecoration(
        color: kSroeNavyDeep,
        borderRadius: BorderRadius.circular(kSroeRadiusM),
        border: Border.all(color: kSroeDanger.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt, color: kSroeDanger, size: 14),
              const SizedBox(width: 4),
              Text(
                'DESTROY + MOUNT',
                style: _sroeTerminalTag().copyWith(color: kSroeDanger),
              ),
              const Spacer(),
              Text(
                'gen=$generation',
                style: _sroeMono().copyWith(color: kSroeDanger),
              ),
            ],
          ),
          const SizedBox(height: kSroeGapS),
          Stack(
            children: [
              Opacity(
                opacity: fade,
                child: _SroePanelLeaf(
                  label: 'LeafA · prev',
                  fill: kSroeCopperShadow,
                  accent: kSroeDanger,
                  glow: false,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: t,
                    child: _SroePanelLeaf(
                      label: 'LeafB · fresh mount',
                      fill: kSroeNavySoft,
                      accent: kSroePhosphor,
                      glow: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kSroeGapS),
          _SroePanelFootnote(
            text:
                'Widget type changed → canUpdate() == false → element.unmount() → '
                'framework inflates new element → insertRenderObjectChild(slot).',
            tint: kSroeDanger,
          ),
        ],
      ),
    );
  }
}

class _SroePreservePanel extends StatelessWidget {
  const _SroePreservePanel({required this.tick, required this.t});
  final int tick;
  final double t;

  @override
  Widget build(BuildContext context) {
    final haloStrength = 0.4 + 0.4 * math.sin(t * math.pi);
    return Container(
      padding: const EdgeInsets.all(kSroeGapM),
      decoration: BoxDecoration(
        color: kSroeNavyDeep,
        borderRadius: BorderRadius.circular(kSroeRadiusM),
        border: Border.all(color: kSroeBrass.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: kSroeBrass.withValues(alpha: haloStrength),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.flash_on, color: kSroeBrass, size: 14),
              const SizedBox(width: 4),
              Text(
                'UPDATE IN PLACE',
                style: _sroeTerminalTag().copyWith(color: kSroeBrass),
              ),
              const Spacer(),
              Text(
                'tick=$tick',
                style: _sroeMono().copyWith(color: kSroeBrass),
              ),
            ],
          ),
          const SizedBox(height: kSroeGapS),
          _SroePanelLeaf(
            label: 'LeafA · updated',
            fill: kSroeCopper,
            accent: kSroeBrass,
            glow: true,
          ),
          const SizedBox(height: kSroeGapS),
          _SroePanelFootnote(
            text:
                'Same widget type → canUpdate() == true → element.update(newWidget) → '
                'RO is UPDATED, not re-inserted. Identity preserved.',
            tint: kSroeBrass,
          ),
        ],
      ),
    );
  }
}

class _SroePanelLeaf extends StatelessWidget {
  const _SroePanelLeaf({
    required this.label,
    required this.fill,
    required this.accent,
    required this.glow,
  });
  final String label;
  final Color fill;
  final Color accent;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: accent, width: 1.4),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: 0.6),
                  blurRadius: 12,
                ),
              ]
            : const [],
      ),
      child: Text(
        label,
        style: _sroeSlotLabel(),
      ),
    );
  }
}

class _SroePanelFootnote extends StatelessWidget {
  const _SroePanelFootnote({required this.text, required this.tint});
  final String text;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSroeGapS),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: tint.withValues(alpha: 0.6)),
      ),
      child: Text(
        text,
        style: _sroeBodyInk().copyWith(
          color: kSroePaper,
          fontSize: 11.5,
          height: 1.4,
        ),
      ),
    );
  }
}

// ============================================================================
// Scene 6 — Quoted implementation card. A faithful pseudo-impl of
//   @override
//   void update(covariant SlottedMultiChildRenderObjectWidget<SlotType,
//               ChildType> newWidget) {
//     super.update(newWidget);
//     assert(widget == newWidget);
//     _updateChildren();
//   }
// with _updateChildren() walking widget.slots and calling updateChild on each.
// Rendered as a terminal-style block with copper syntax accents.
// ============================================================================

class _SroeQuotedImpl extends StatelessWidget {
  const _SroeQuotedImpl();

  @override
  Widget build(BuildContext context) {
    return _SroeCard(
      title: 'Quoted pseudo-impl — update(covariant newWidget)',
      subtitle:
          'The element forwards to super.update, then re-walks every slot and '
          'asks the framework to updateChild per slot. The framework decides '
          'preserve-vs-mount using Widget.canUpdate on the old/new pair.',
      child: _SroeCodeBlock(
        lines: const [
          _SroeCodeLine('  @override'),
          _SroeCodeLine('  void update('),
          _SroeCodeLine('    covariant SlottedMultiChildRenderObjectWidget<', kind: _SroeSyn.type),
          _SroeCodeLine('      SlotType, ChildType', kind: _SroeSyn.type),
          _SroeCodeLine('    > newWidget,', kind: _SroeSyn.type),
          _SroeCodeLine('  ) {'),
          _SroeCodeLine('    super.update(newWidget);'),
          _SroeCodeLine('    assert(widget == newWidget);'),
          _SroeCodeLine('    _updateChildren();'),
          _SroeCodeLine('  }'),
          _SroeCodeLine(''),
          _SroeCodeLine('  void _updateChildren() {'),
          _SroeCodeLine('    final Set<SlotType> seen = <SlotType>{};', kind: _SroeSyn.decl),
          _SroeCodeLine('    for (final SlotType slot in widget.slots) {'),
          _SroeCodeLine('      seen.add(slot);'),
          _SroeCodeLine('      final Widget? w = widget.childForSlot(slot);'),
          _SroeCodeLine('      final Element? old = _slotToChild[slot];'),
          _SroeCodeLine('      final Element? next = updateChild(old, w, slot);', kind: _SroeSyn.call),
          _SroeCodeLine('      if (next != null) {'),
          _SroeCodeLine('        _slotToChild[slot] = next;'),
          _SroeCodeLine('      } else {'),
          _SroeCodeLine('        _slotToChild.remove(slot);'),
          _SroeCodeLine('      }'),
          _SroeCodeLine('    }'),
          _SroeCodeLine('    // Garbage-collect slots that went away.', kind: _SroeSyn.comment),
          _SroeCodeLine('    _slotToChild.removeWhere('),
          _SroeCodeLine('      (slot, _) {'),
          _SroeCodeLine('        final gone = !seen.contains(slot);', kind: _SroeSyn.decl),
          _SroeCodeLine('        if (gone) deactivateChild(_slotToChild[slot]!);', kind: _SroeSyn.call),
          _SroeCodeLine('        return gone;'),
          _SroeCodeLine('      },'),
          _SroeCodeLine('    );'),
          _SroeCodeLine('  }'),
        ],
      ),
    );
  }
}

enum _SroeSyn { normal, type, decl, call, comment }

class _SroeCodeLine {
  const _SroeCodeLine(this.text, {this.kind = _SroeSyn.normal});
  final String text;
  final _SroeSyn kind;

  Color get tint {
    switch (kind) {
      case _SroeSyn.type:
        return kSroeCopperBright;
      case _SroeSyn.decl:
        return kSroeBrass;
      case _SroeSyn.call:
        return kSroePhosphor;
      case _SroeSyn.comment:
        return kSroeSolder;
      case _SroeSyn.normal:
        return kSroePaper;
    }
  }
}

class _SroeCodeBlock extends StatelessWidget {
  const _SroeCodeBlock({required this.lines});
  final List<_SroeCodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSroeGapM),
      decoration: BoxDecoration(
        color: kSroeNavyDeep,
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: kSroeCopper.withValues(alpha: 0.55)),
        boxShadow: [
          BoxShadow(
            color: kSroeCopper.withValues(alpha: 0.18),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: kSroeCopper,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: kSroeBrass,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: kSroePhosphor,
                  shape: BoxShape.circle,
                ),
              ),
              const Spacer(),
              Text(
                'slotted_render_object_element.dart · pseudo',
                style: _sroeTerminalTag().copyWith(fontSize: 9),
              ),
            ],
          ),
          const SizedBox(height: kSroeGapS),
          for (int i = 0; i < lines.length; i++)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28,
                  child: Text(
                    '${i + 1}',
                    textAlign: TextAlign.right,
                    style: _sroeMono().copyWith(
                      color: kSroeNavyFog,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(width: kSroeGapS),
                Expanded(
                  child: Text(
                    lines[i].text.isEmpty ? ' ' : lines[i].text,
                    style: _sroeMono().copyWith(
                      color: lines[i].tint,
                      fontWeight: lines[i].kind == _SroeSyn.decl
                          ? FontWeight.w700
                          : FontWeight.w400,
                      fontSize: 12.5,
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

// ============================================================================
// Scene 7 — Pitfall card. You usually don't subclass SlottedRenderObjectElement.
// ============================================================================

class _SroePitfallCard extends StatelessWidget {
  const _SroePitfallCard();

  @override
  Widget build(BuildContext context) {
    return _SroeCard(
      title: 'Pitfall — don\'t subclass SlottedRenderObjectElement',
      subtitle:
          'The framework manufactures the element for you when the widget\'s '
          'createElement() is called. Subclassing the element is almost never '
          'what you want; extend the widget and the RO-mixin instead.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SroePitfallRow(
            icon: Icons.warning_amber_rounded,
            tint: kSroeDanger,
            title: 'You wrote `class MyElement extends SlottedRenderObjectElement`',
            body:
                'The widget already has a built-in createElement() that '
                'returns a well-tuned element. Overriding it forces you to '
                're-implement slot storage, visit order, and the insert/move/'
                'remove triad — all of which the default handles correctly.',
          ),
          const SizedBox(height: kSroeGapS),
          _SroePitfallRow(
            icon: Icons.check_circle_outline,
            tint: kSroePhosphorDim,
            title: 'Preferred — override the widget & the RO-mixin',
            body:
                'Implement `SlottedMultiChildRenderObjectWidget.slots` and '
                '`childForSlot`, and in the RO mixin override `children` plus '
                'layout/paint. Leave the element alone — the framework creates '
                'and maintains it for you.',
          ),
          const SizedBox(height: kSroeGapS),
          _SroePitfallRow(
            icon: Icons.info_outline,
            tint: kSroeBrass,
            title: 'If you truly must subclass',
            body:
                'Only valid reason: bespoke slot storage (e.g. non-hashable '
                'slot identities). Even then, override only mount/update/'
                'forgetChild/visitChildren — keep insert/move/remove as '
                'pass-throughs that call `super`.',
          ),
        ],
      ),
    );
  }
}

class _SroePitfallRow extends StatelessWidget {
  const _SroePitfallRow({
    required this.icon,
    required this.tint,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color tint;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSroeGapM),
      decoration: BoxDecoration(
        color: kSroePaperDeep,
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: tint.withValues(alpha: 0.7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(kSroeRadiusS),
              border: Border.all(color: tint),
            ),
            child: Icon(icon, color: tint, size: 18),
          ),
          const SizedBox(width: kSroeGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: _sroeSectionTitle().copyWith(
                    fontSize: 14,
                    color: kSroeNavy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(body, style: _sroeBodyInk()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Footer — compact attribution strip.
// ============================================================================

class _SroeFooter extends StatelessWidget {
  const _SroeFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSroeGapL,
        vertical: kSroeGapM,
      ),
      decoration: BoxDecoration(
        color: kSroeNavy,
        borderRadius: BorderRadius.circular(kSroeRadiusS),
        border: Border.all(color: kSroeCopper.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: kSroePhosphor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kSroePhosphor.withValues(alpha: 0.8),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: kSroeGapS),
          Expanded(
            child: Text(
              'element-tier slot wiring · junction box between widget and render trees',
              style: _sroeHeroSub().copyWith(
                fontSize: 11.5,
                color: kSroePaper.withValues(alpha: 0.75),
              ),
            ),
          ),
          Text(
            '416 / 4',
            style: _sroeTerminalTag().copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
