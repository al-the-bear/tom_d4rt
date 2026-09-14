// ignore_for_file: avoid_print
// D4rt deep-demo script: WidgetStateOutlinedBorder
// Visual demonstration of Flutter's WidgetStateOutlinedBorder mixin-class.
//
// WidgetStateOutlinedBorder (package:flutter/src/widgets/widget_state.dart,
// re-exported via package:flutter/widgets.dart and package:flutter/material
// .dart) is an abstract mixin class declared as:
//
//   abstract mixin class WidgetStateOutlinedBorder
//       extends OutlinedBorder
//       implements WidgetStateProperty<OutlinedBorder?>
//
// It plugs the WidgetState machinery (hovered, pressed, focused, selected,
// disabled, error, …) into any slot that expects an OutlinedBorder — button
// shapes, chip shapes, toggle buttons, dialog frames, …  You subclass it, or
// in practice call the static:
//
//   factory WidgetStateOutlinedBorder.fromMap(
//       WidgetStateMap<OutlinedBorder?> map)
//
// which returns a private _WidgetStateOutlinedBorderMapper that walks the
// map's WidgetStatesConstraint keys against a Set<WidgetState> and emits the
// matching OutlinedBorder?.  Because the class extends OutlinedBorder, a
// _WidgetStateOutlinedBorderMapper instance can be handed to a
// ButtonStyle.shape, ChipThemeData.shape, InputDecoration.border, and so on,
// even though it is really a resolver in disguise.
//
// Theme : Mint die-cast — a coin minting workshop.  Brass press, mahogany
//         press-bed, pewter medallions, stamped rims.  Each interaction
//         state swaps the medallion silhouette: rounded-rect → stadium →
//         circle → star → beveled.
// Prefix: _Wsob  (e.g. _WsobHome, _WsobMedallion).
//
// In the d4rt interpreter the mapper resolves just as well as on native
// Flutter, because the WidgetStateProperty.resolve call is a plain method
// dispatch.  We pair the real WidgetStateOutlinedBorder.fromMap with a set
// of pseudo-state toggles so the demo is deterministic even without a host
// pointer stream.

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ─────────────────────── palette & theme tokens ──────────────────────
//
// Top-level const fields keep them usable inside const constructors.

const String _wsobPaletteName = 'Mint Die-Cast';

const Color _wsobMahogany = Color(0xFF5B2A1B);
const Color _wsobMahoganyDeep = Color(0xFF3A1A10);
const Color _wsobBrass = Color(0xFFC8A15A);
const Color _wsobBrassBright = Color(0xFFE7C179);
const Color _wsobBrassDeep = Color(0xFF8A6B2E);
const Color _wsobPewter = Color(0xFFB6BCC2);
const Color _wsobPewterEdge = Color(0xFF5A6068);
const Color _wsobCream = Color(0xFFF6F2E9);
const Color _wsobInk = Color(0xFF1A1410);
const Color _wsobMute = Color(0xFF6D5B48);
const Color _wsobAccent = Color(0xFFD4691E);
const Color _wsobSuccess = Color(0xFF2E7D32);
const Color _wsobError = Color(0xFFB71C1C);
const Color _wsobPaper = Color(0xFFF3EADA);
const Color _wsobPaperEdge = Color(0xFFD9CBAA);

// ─────────────────────── pseudo-state model ──────────────────────────
//
// We do not rely on real pointer events from the host — the interpreter
// cannot guarantee them.  Instead, a simple enum drives the resolved shape
// and allows the live medallion press to be walked deterministically.

enum _WsobPseudoState {
  idle,
  hovered,
  focused,
  pressed,
  selected,
  disabled,
  error,
}

extension _WsobPseudoStateX on _WsobPseudoState {
  String get label {
    switch (this) {
      case _WsobPseudoState.idle:
        return 'idle';
      case _WsobPseudoState.hovered:
        return 'hovered';
      case _WsobPseudoState.focused:
        return 'focused';
      case _WsobPseudoState.pressed:
        return 'pressed';
      case _WsobPseudoState.selected:
        return 'selected';
      case _WsobPseudoState.disabled:
        return 'disabled';
      case _WsobPseudoState.error:
        return 'error';
    }
  }

  Set<WidgetState> get asSet {
    switch (this) {
      case _WsobPseudoState.idle:
        return <WidgetState>{};
      case _WsobPseudoState.hovered:
        return <WidgetState>{WidgetState.hovered};
      case _WsobPseudoState.focused:
        return <WidgetState>{WidgetState.focused};
      case _WsobPseudoState.pressed:
        return <WidgetState>{WidgetState.pressed};
      case _WsobPseudoState.selected:
        return <WidgetState>{WidgetState.selected};
      case _WsobPseudoState.disabled:
        return <WidgetState>{WidgetState.disabled};
      case _WsobPseudoState.error:
        return <WidgetState>{WidgetState.error};
    }
  }

  IconData get icon {
    switch (this) {
      case _WsobPseudoState.idle:
        return Icons.circle_outlined;
      case _WsobPseudoState.hovered:
        return Icons.mouse_outlined;
      case _WsobPseudoState.focused:
        return Icons.center_focus_strong_outlined;
      case _WsobPseudoState.pressed:
        return Icons.touch_app_outlined;
      case _WsobPseudoState.selected:
        return Icons.check_circle_outline;
      case _WsobPseudoState.disabled:
        return Icons.block_outlined;
      case _WsobPseudoState.error:
        return Icons.error_outline;
    }
  }

  Color get tint {
    switch (this) {
      case _WsobPseudoState.idle:
        return _wsobPewter;
      case _WsobPseudoState.hovered:
        return _wsobBrassBright;
      case _WsobPseudoState.focused:
        return _wsobBrass;
      case _WsobPseudoState.pressed:
        return _wsobAccent;
      case _WsobPseudoState.selected:
        return _wsobSuccess;
      case _WsobPseudoState.disabled:
        return _wsobMute;
      case _WsobPseudoState.error:
        return _wsobError;
    }
  }
}

// ─────────────────────── shape catalogue ─────────────────────────────

enum _WsobShapeKind {
  rounded,
  stadium,
  circle,
  continuousRect,
  beveled,
  star,
}

extension _WsobShapeKindX on _WsobShapeKind {
  String get label {
    switch (this) {
      case _WsobShapeKind.rounded:
        return 'RoundedRectangleBorder';
      case _WsobShapeKind.stadium:
        return 'StadiumBorder';
      case _WsobShapeKind.circle:
        return 'CircleBorder';
      case _WsobShapeKind.continuousRect:
        return 'ContinuousRectangleBorder';
      case _WsobShapeKind.beveled:
        return 'BeveledRectangleBorder';
      case _WsobShapeKind.star:
        return 'StarBorder';
    }
  }

  String get tagline {
    switch (this) {
      case _WsobShapeKind.rounded:
        return 'Straight sides, circular-arc corners';
      case _WsobShapeKind.stadium:
        return 'Two semicircles joined by straight edges';
      case _WsobShapeKind.circle:
        return 'Perfect circle, radius derived from bounds';
      case _WsobShapeKind.continuousRect:
        return 'Squircle-style corner blending';
      case _WsobShapeKind.beveled:
        return 'Chamfered corners, straight bevels';
      case _WsobShapeKind.star:
        return 'N-point star with inner-radius ratio';
    }
  }

  String get params {
    switch (this) {
      case _WsobShapeKind.rounded:
        return 'borderRadius: 24';
      case _WsobShapeKind.stadium:
        return '(no radius — derived from bounds)';
      case _WsobShapeKind.circle:
        return 'eccentricity: 0.0';
      case _WsobShapeKind.continuousRect:
        return 'borderRadius: 28';
      case _WsobShapeKind.beveled:
        return 'borderRadius: 14';
      case _WsobShapeKind.star:
        return 'points: 5 (defaults for rest)';
    }
  }

  IconData get icon {
    switch (this) {
      case _WsobShapeKind.rounded:
        return Icons.crop_square_outlined;
      case _WsobShapeKind.stadium:
        return Icons.horizontal_rule_outlined;
      case _WsobShapeKind.circle:
        return Icons.circle_outlined;
      case _WsobShapeKind.continuousRect:
        return Icons.blur_on_outlined;
      case _WsobShapeKind.beveled:
        return Icons.change_history_outlined;
      case _WsobShapeKind.star:
        return Icons.star_outline;
    }
  }

  OutlinedBorder borderWithSide(BorderSide side) {
    switch (this) {
      case _WsobShapeKind.rounded:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: side,
        );
      case _WsobShapeKind.stadium:
        return StadiumBorder(side: side);
      case _WsobShapeKind.circle:
        return CircleBorder(side: side);
      case _WsobShapeKind.continuousRect:
        return ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: side,
        );
      case _WsobShapeKind.beveled:
        return BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: side,
        );
      case _WsobShapeKind.star:
        return StarBorder(points: 5, side: side);
    }
  }
}

// ─────────────────────── tiny model types ────────────────────────────

class _WsobDossierCard {
  final String title;
  final String body;
  final IconData icon;
  final Color accent;
  const _WsobDossierCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
  });
}

class _WsobRecipe {
  final String title;
  final String stateExpr;
  final String shapeExpr;
  final String explanation;
  final IconData icon;
  final Color accent;
  const _WsobRecipe({
    required this.title,
    required this.stateExpr,
    required this.shapeExpr,
    required this.explanation,
    required this.icon,
    required this.accent,
  });
}

class _WsobGlossaryEntry {
  final String term;
  final String definition;
  const _WsobGlossaryEntry({
    required this.term,
    required this.definition,
  });
}

class _WsobComparisonRow {
  final String feature;
  final String wsob;
  final String plain;
  final String legacy;
  final String conditional;
  const _WsobComparisonRow({
    required this.feature,
    required this.wsob,
    required this.plain,
    required this.legacy,
    required this.conditional,
  });
}

// ═════════════════════════════════════════════════════════════════════
// PAINTERS
// ═════════════════════════════════════════════════════════════════════

/// Paints the mint-press bed: mahogany slab with brass rivets and a circular
/// stamping cradle.  Used as the backdrop for the "Live medallion press"
/// section.
class _WsobPressBedPainter extends CustomPainter {
  final double pulse;
  final Color mahogany;
  final Color mahoganyDeep;
  final Color brass;
  final Color brassDeep;

  const _WsobPressBedPainter({
    required this.pulse,
    required this.mahogany,
    required this.mahoganyDeep,
    required this.brass,
    required this.brassDeep,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    // Mahogany slab with radial darkening towards the edges.
    final Paint wood = Paint()
      ..shader = RadialGradient(
        colors: <Color>[mahogany, mahoganyDeep],
        stops: const <double>[0.0, 1.0],
      ).createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      wood,
    );

    // Wood grain — horizontal sinusoidal striations.
    final Paint grain = Paint()
      ..color = mahoganyDeep.withValues(alpha: 0.24)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 14; i++) {
      final double y = (i + 0.5) * size.height / 14.0;
      final Path p = Path()..moveTo(6, y);
      for (double x = 6; x <= size.width - 6; x += 6) {
        final double wy = y +
            math.sin((x / size.width) * math.pi * 3 + i * 0.7) * 1.4;
        p.lineTo(x, wy);
      }
      canvas.drawPath(p, grain);
    }

    // Brass rivets at the four corners.
    final List<Offset> rivetCenters = <Offset>[
      Offset(18, 18),
      Offset(size.width - 18, 18),
      Offset(18, size.height - 18),
      Offset(size.width - 18, size.height - 18),
    ];
    for (final Offset c in rivetCenters) {
      _drawRivet(canvas, c, 7.0);
    }

    // Central stamping cradle — a circular cavity glowing warm during the
    // press pulse.
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double cradleRadius = math.min(size.width, size.height) * 0.36;

    final Paint cradleGlow = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          brass.withValues(alpha: 0.28 + 0.18 * pulse),
          mahoganyDeep.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: cradleRadius * 1.3),
      );
    canvas.drawCircle(center, cradleRadius * 1.3, cradleGlow);

    final Paint cradle = Paint()
      ..color = mahoganyDeep.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, cradleRadius, cradle);

    final Paint cradleRim = Paint()
      ..color = brass.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    canvas.drawCircle(center, cradleRadius, cradleRim);

    // Tick marks around the cradle, like an alignment bezel.
    final Paint tick = Paint()
      ..color = brassDeep.withValues(alpha: 0.75)
      ..strokeWidth = 1.3;
    for (int i = 0; i < 24; i++) {
      final double a = (i / 24.0) * math.pi * 2;
      final Offset o1 = center +
          Offset(math.cos(a) * (cradleRadius + 6), math.sin(a) * (cradleRadius + 6));
      final Offset o2 = center +
          Offset(
            math.cos(a) * (cradleRadius + (i % 3 == 0 ? 14 : 10)),
            math.sin(a) * (cradleRadius + (i % 3 == 0 ? 14 : 10)),
          );
      canvas.drawLine(o1, o2, tick);
    }

    // Pulsing crosshair in the cradle center.
    final Paint cross = Paint()
      ..color = brass.withValues(alpha: 0.4 + 0.45 * pulse)
      ..strokeWidth = 1.6;
    canvas.drawLine(
      center + const Offset(-14, 0),
      center + const Offset(14, 0),
      cross,
    );
    canvas.drawLine(
      center + const Offset(0, -14),
      center + const Offset(0, 14),
      cross,
    );
  }

  void _drawRivet(Canvas canvas, Offset c, double r) {
    final Paint base = Paint()
      ..shader = RadialGradient(
        colors: <Color>[brass, brassDeep],
      ).createShader(Rect.fromCircle(center: c, radius: r));
    canvas.drawCircle(c, r, base);
    final Paint hi = Paint()..color = Colors.white.withValues(alpha: 0.45);
    canvas.drawCircle(c + const Offset(-1.8, -1.8), r * 0.33, hi);
    final Paint rim = Paint()
      ..color = brassDeep.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    canvas.drawCircle(c, r, rim);
  }

  @override
  bool shouldRepaint(covariant _WsobPressBedPainter old) =>
      old.pulse != pulse;
}

/// Paints the hierarchy diagram showing
/// ShapeBorder → OutlinedBorder → WidgetStateOutlinedBorder and the known
/// concrete subclasses branching off.
class _WsobHierarchyPainter extends CustomPainter {
  final Color lineColor;
  final Color accentColor;
  final Color labelColor;

  const _WsobHierarchyPainter({
    required this.lineColor,
    required this.accentColor,
    required this.labelColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = lineColor
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final Paint nodePaint = Paint()
      ..color = lineColor.withValues(alpha: 0.18);
    final Paint nodeStroke = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final Paint accentPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.20);
    final Paint accentStroke = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Top node: ShapeBorder
    final Rect top = Rect.fromCenter(
      center: Offset(size.width / 2, 26),
      width: 150,
      height: 34,
    );
    _drawLabelBox(canvas, top, 'ShapeBorder',
        fill: nodePaint, stroke: nodeStroke, labelColor: labelColor);

    // Middle node: OutlinedBorder
    final Rect mid = Rect.fromCenter(
      center: Offset(size.width / 2, 84),
      width: 170,
      height: 34,
    );
    _drawLabelBox(canvas, mid, 'OutlinedBorder',
        fill: nodePaint, stroke: nodeStroke, labelColor: labelColor);

    // Accent node: WidgetStateOutlinedBorder
    final Rect wsob = Rect.fromCenter(
      center: Offset(size.width / 2, 144),
      width: 240,
      height: 38,
    );
    _drawLabelBox(canvas, wsob, 'WidgetStateOutlinedBorder',
        fill: accentPaint, stroke: accentStroke, labelColor: labelColor);

    // Edges: top → mid, mid → wsob
    canvas.drawLine(
      Offset(size.width / 2, top.bottom),
      Offset(size.width / 2, mid.top),
      line,
    );
    canvas.drawLine(
      Offset(size.width / 2, mid.bottom),
      Offset(size.width / 2, wsob.top),
      line,
    );

    // Leaf subclasses — a row under wsob.
    final List<String> leaves = <String>[
      'Rounded',
      'Stadium',
      'Circle',
      'Continuous',
      'Beveled',
      'Star',
    ];
    final double leafY = 210;
    final double leafTop = 196;
    final double leafBot = 228;
    final double step = size.width / (leaves.length + 1);
    for (int i = 0; i < leaves.length; i++) {
      final double cx = step * (i + 1);
      final Rect leafRect = Rect.fromLTRB(cx - 34, leafTop, cx + 34, leafBot);
      _drawLabelBox(canvas, leafRect, leaves[i],
          fill: nodePaint, stroke: nodeStroke, labelColor: labelColor);
      canvas.drawLine(
        Offset(size.width / 2, wsob.bottom),
        Offset(cx, leafY - 16),
        line,
      );
    }
  }

  void _drawLabelBox(
    Canvas canvas,
    Rect rect,
    String label, {
    required Paint fill,
    required Paint stroke,
    required Color labelColor,
  }) {
    final RRect r = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(r, fill);
    canvas.drawRRect(r, stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: labelColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width - 4);
    tp.paint(
      canvas,
      Offset(
        rect.left + (rect.width - tp.width) / 2,
        rect.top + (rect.height - tp.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _WsobHierarchyPainter old) => false;
}

/// Paints a small radial burst behind the live medallion, intensifying when
/// the press animation peaks.
class _WsobBurstPainter extends CustomPainter {
  final double pulse;
  final Color accent;

  const _WsobBurstPainter({required this.pulse, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double r = math.min(size.width, size.height) / 2;
    final Paint p = Paint()
      ..color = accent.withValues(alpha: 0.15 + 0.25 * pulse)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 36; i++) {
      final double a = (i / 36.0) * math.pi * 2;
      final double len = r * (0.55 + 0.12 * math.sin(pulse * math.pi + i));
      canvas.drawLine(
        center + Offset(math.cos(a) * r * 0.25, math.sin(a) * r * 0.25),
        center + Offset(math.cos(a) * len, math.sin(a) * len),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WsobBurstPainter old) =>
      old.pulse != pulse;
}

// ═════════════════════════════════════════════════════════════════════
// build() — script entry point (d4rt AST harness).
// ═════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return const _WsobApp();
}

// ═════════════════════════════════════════════════════════════════════
// APP ROOT
// ═════════════════════════════════════════════════════════════════════

class _WsobApp extends StatelessWidget {
  const _WsobApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WidgetStateOutlinedBorder — $_wsobPaletteName',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _wsobBrass,
          primary: _wsobBrass,
          onPrimary: _wsobInk,
          secondary: _wsobAccent,
          surface: _wsobPaper,
          onSurface: _wsobInk,
          error: _wsobError,
        ),
        scaffoldBackgroundColor: _wsobPaper,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _wsobInk, fontSize: 13.5),
          titleMedium: TextStyle(
            color: _wsobInk,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            color: _wsobInk,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: const _WsobHome(),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// HOME — stateful, drives the pseudo-state and animation controllers.
// ═════════════════════════════════════════════════════════════════════

class _WsobHome extends StatefulWidget {
  const _WsobHome();

  @override
  State<_WsobHome> createState() => _WsobHomeState();
}

class _WsobHomeState extends State<_WsobHome>
    with TickerProviderStateMixin {
  late final AnimationController _pressController;
  late final AnimationController _morphController;

  _WsobPseudoState _liveState = _WsobPseudoState.idle;
  _WsobShapeKind _comparisonLeft = _WsobShapeKind.rounded;
  _WsobShapeKind _comparisonRight = _WsobShapeKind.star;
  bool _selectedChip = false;
  bool _filterChip = true;

  final List<String> _eventLog = <String>[];

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _logEvent('demo:init');
  }

  @override
  void dispose() {
    _pressController.dispose();
    _morphController.dispose();
    super.dispose();
  }

  void _logEvent(String kind) {
    _eventLog.insert(0, '${DateTime.now().toIso8601String()}  $kind');
    if (_eventLog.length > 10) {
      _eventLog.removeLast();
    }
  }

  void _pickState(_WsobPseudoState s) {
    setState(() {
      _liveState = s;
      _logEvent('state:${s.label}');
    });
  }

  void _pickLeft(_WsobShapeKind k) {
    setState(() {
      _comparisonLeft = k;
      _logEvent('morph.left:${k.label}');
    });
  }

  void _pickRight(_WsobShapeKind k) {
    setState(() {
      _comparisonRight = k;
      _logEvent('morph.right:${k.label}');
    });
  }

  void _toggleSelectedChip() {
    setState(() {
      _selectedChip = !_selectedChip;
      _logEvent('choice:$_selectedChip');
    });
  }

  void _toggleFilterChip() {
    setState(() {
      _filterChip = !_filterChip;
      _logEvent('filter:$_filterChip');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _wsobPaper,
      appBar: AppBar(
        backgroundColor: _wsobMahogany,
        foregroundColor: _wsobBrassBright,
        elevation: 0,
        title: const Text(
          'WidgetStateOutlinedBorder — Mint Die-Cast',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(child: _WsobDossier()),
            const SliverToBoxAdapter(child: _WsobAnatomy()),
            SliverToBoxAdapter(
              child: _WsobLivePress(
                state: _liveState,
                onPick: _pickState,
                pressController: _pressController,
              ),
            ),
            const SliverToBoxAdapter(child: _WsobShapeLibrary()),
            const SliverToBoxAdapter(child: _WsobButtonShowcase()),
            SliverToBoxAdapter(
              child: _WsobChipShowcase(
                selected: _selectedChip,
                onToggleSelected: _toggleSelectedChip,
                filtered: _filterChip,
                onToggleFilter: _toggleFilterChip,
              ),
            ),
            SliverToBoxAdapter(
              child: _WsobMorphSection(
                controller: _morphController,
                left: _comparisonLeft,
                right: _comparisonRight,
                onPickLeft: _pickLeft,
                onPickRight: _pickRight,
              ),
            ),
            const SliverToBoxAdapter(child: _WsobComparisonTable()),
            const SliverToBoxAdapter(child: _WsobRecipeCards()),
            SliverToBoxAdapter(
              child: _WsobEventLog(entries: List<String>.from(_eventLog)),
            ),
            const SliverToBoxAdapter(child: _WsobGlossary()),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 1 — Dossier / Preamble
// ═════════════════════════════════════════════════════════════════════

class _WsobDossier extends StatelessWidget {
  const _WsobDossier();

  @override
  Widget build(BuildContext context) {
    const List<_WsobDossierCard> cards = <_WsobDossierCard>[
      _WsobDossierCard(
        icon: Icons.auto_awesome_outlined,
        accent: _wsobBrass,
        title: 'What is WidgetStateOutlinedBorder?',
        body:
            'An abstract mixin-class that lets an OutlinedBorder respond to '
            'widget state: hovered, focused, pressed, selected, disabled, '
            'error, scrolledUnder, dragged.  Hand it anywhere an '
            'OutlinedBorder is accepted and Flutter will resolve the shape '
            'per-state at paint time.',
      ),
      _WsobDossierCard(
        icon: Icons.account_tree_outlined,
        accent: _wsobAccent,
        title: 'Hierarchy',
        body:
            'ShapeBorder (abstract paintable edge) → OutlinedBorder (adds '
            'a BorderSide slot) → WidgetStateOutlinedBorder (also implements '
            'WidgetStateProperty<OutlinedBorder?>).  Because the mixin class '
            'IS an OutlinedBorder, the framework can carry the resolver '
            'through API surfaces that expect a concrete border.',
      ),
      _WsobDossierCard(
        icon: Icons.settings_suggest_outlined,
        accent: _wsobSuccess,
        title: 'Why stateful borders?',
        body:
            'A single OutlinedBorder is fine for static decoration, but '
            'interactive controls need the shape to morph with interaction. '
            'Enlarging the radius on hover, switching to a star on focus, '
            'dropping to a muted stadium on disabled — all without writing '
            'an InkWell + AnimatedContainer + Offstage sandwich.',
      ),
      _WsobDossierCard(
        icon: Icons.map_outlined,
        accent: _wsobBrassDeep,
        title: 'The .fromMap entry point',
        body:
            'WidgetStateOutlinedBorder.fromMap(WidgetStateMap<OutlinedBorder?>) '
            'returns a private _WidgetStateOutlinedBorderMapper.  The map '
            'keys are WidgetStatesConstraint (WidgetState.hovered, '
            'WidgetState.any, compound predicates), values are the resolved '
            'OutlinedBorder?.  Unlike the BorderSide / Color mappers, there '
            'is no resolveWith factory — fromMap is the canonical path.',
      ),
      _WsobDossierCard(
        icon: Icons.layers_outlined,
        accent: _wsobError,
        title: 'Where it slots in',
        body:
            'ButtonStyle.shape (the official home), ChipThemeData.shape, '
            'FilterChip/ChoiceChip.shape, Dialog.shape, Card.shape, '
            'InputDecoration borders (via adapters), OutlinedButton.styleFrom '
            'shape argument.  Anywhere the API wants an OutlinedBorder, you '
            'can pass a state-driven one.',
      ),
      _WsobDossierCard(
        icon: Icons.construction_outlined,
        accent: _wsobMute,
        title: 'Deprecated legacy alias',
        body:
            'MaterialStateOutlinedBorder is the pre-M3 name and is kept as a '
            'deprecated typedef / subclass for migration.  New code should '
            'always prefer WidgetStateOutlinedBorder; the legacy class is '
            'not expected to gain new features and its reification into the '
            'Material namespace clashes with non-Material usage.',
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wsobMahogany, _wsobMahoganyDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wsobMahoganyDeep.withValues(alpha: 0.45),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _wsobBrass.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _wsobBrass, width: 1.2),
                ),
                child: const Icon(
                  Icons.monetization_on_outlined,
                  color: _wsobBrassBright,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'WidgetStateOutlinedBorder',
                      style: TextStyle(
                        color: _wsobBrassBright,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Stateful shape resolution for any OutlinedBorder slot',
                      style: TextStyle(
                        color: _wsobCream,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _wsobBrass.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _wsobBrass, width: 1),
                ),
                child: const Text(
                  'widgets / material',
                  style: TextStyle(
                    color: _wsobBrassBright,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Preamble — six cards introducing the mixin, its hierarchy, '
            'entry points, and common slots.  The live press below operates '
            'on a real WidgetStateOutlinedBorder.fromMap instance.',
            style: TextStyle(color: _wsobCream, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final int columns = cons.maxWidth >= 900
                  ? 3
                  : cons.maxWidth >= 560
                      ? 2
                      : 1;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: cards.map((_WsobDossierCard c) {
                  final double w =
                      (cons.maxWidth - (columns - 1) * 12) / columns;
                  return SizedBox(
                    width: w,
                    child: _WsobDossierCardView(card: c),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WsobDossierCardView extends StatelessWidget {
  final _WsobDossierCard card;
  const _WsobDossierCardView({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wsobCream.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: card.accent.withValues(alpha: 0.65),
          width: 1.3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: card.accent.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(card.icon, color: card.accent, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  card.title,
                  style: const TextStyle(
                    color: _wsobBrassBright,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            card.body,
            style: const TextStyle(
              color: _wsobCream,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 2 — Anatomy
// ═════════════════════════════════════════════════════════════════════

class _WsobAnatomy extends StatelessWidget {
  const _WsobAnatomy();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wsobMahoganyDeep.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _WsobSectionHeader(
            icon: Icons.account_tree_outlined,
            accent: _wsobBrassDeep,
            title: 'Section 2 — Anatomy',
            subtitle: 'Hierarchy, declaration, fromMap factory',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final bool wide = cons.maxWidth >= 720;
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 3, child: _WsobAnatomyDeclaration()),
                    const SizedBox(width: 14),
                    Expanded(flex: 4, child: _WsobAnatomyHierarchy()),
                  ],
                );
              }
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _WsobAnatomyDeclaration(),
                  SizedBox(height: 14),
                  _WsobAnatomyHierarchy(),
                ],
              );
            },
          ),
          const SizedBox(height: 14),
          _WsobAnatomyFactoryCard(),
        ],
      ),
    );
  }
}

class _WsobAnatomyDeclaration extends StatelessWidget {
  const _WsobAnatomyDeclaration();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wsobPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Declaration',
            style: TextStyle(
              color: _wsobInk,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          _WsobCodeBlock(
            code:
                'abstract mixin class WidgetStateOutlinedBorder\n'
                '    extends OutlinedBorder\n'
                '    implements WidgetStateProperty<OutlinedBorder?> {\n'
                '  const WidgetStateOutlinedBorder();\n\n'
                '  factory WidgetStateOutlinedBorder.fromMap(\n'
                '    WidgetStateMap<OutlinedBorder?> map,\n'
                '  ) = _WidgetStateOutlinedBorderMapper;\n\n'
                '  @override\n'
                '  OutlinedBorder? resolve(Set<WidgetState> states);\n'
                '}',
          ),
          SizedBox(height: 10),
          Text(
            'The mixin class keyword lets concrete subclasses "mix in" this '
            'type while also keeping it usable as a plain abstract base. '
            'The private _WidgetStateOutlinedBorderMapper implementation is '
            'what .fromMap returns.',
            style: TextStyle(
              color: _wsobMute,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _WsobAnatomyHierarchy extends StatelessWidget {
  const _WsobAnatomyHierarchy();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wsobPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Hierarchy diagram',
            style: TextStyle(
              color: _wsobInk,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 244,
            child: CustomPaint(
              painter: _WsobHierarchyPainter(
                lineColor: _wsobMute,
                accentColor: _wsobAccent,
                labelColor: _wsobInk,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Top row is the abstract backbone; the accent box marks the '
            'mixin class we are demonstrating; the bottom row lists the '
            'OutlinedBorder subclasses you can return.',
            style: TextStyle(color: _wsobMute, fontSize: 11.5, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _WsobAnatomyFactoryCard extends StatelessWidget {
  const _WsobAnatomyFactoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wsobPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'The .fromMap factory',
            style: TextStyle(
              color: _wsobInk,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          _WsobCodeBlock(
            code:
                'final OutlinedBorder shape = WidgetStateOutlinedBorder.fromMap(\n'
                '  <WidgetStatesConstraint, OutlinedBorder?>{\n'
                '    WidgetState.disabled: StadiumBorder(\n'
                '      side: BorderSide(color: muted, width: 1),\n'
                '    ),\n'
                '    WidgetState.error: RoundedRectangleBorder(\n'
                '      borderRadius: BorderRadius.circular(6),\n'
                '      side: BorderSide(color: errColor, width: 2),\n'
                '    ),\n'
                '    WidgetState.pressed: CircleBorder(\n'
                '      side: BorderSide(color: accent, width: 3),\n'
                '    ),\n'
                '    WidgetState.selected: StarBorder(\n'
                '      points: 5,\n'
                '      side: BorderSide(color: gold, width: 2),\n'
                '    ),\n'
                '    WidgetState.hovered: RoundedRectangleBorder(\n'
                '      borderRadius: BorderRadius.circular(28),\n'
                '      side: BorderSide(color: brass, width: 1.5),\n'
                '    ),\n'
                '    WidgetState.any: RoundedRectangleBorder(\n'
                '      borderRadius: BorderRadius.circular(24),\n'
                '      side: BorderSide(color: pewter, width: 1),\n'
                '    ),\n'
                '  },\n'
                ');',
          ),
          SizedBox(height: 10),
          Text(
            'Keys are evaluated top-to-bottom.  Put the narrowest predicates '
            'first and WidgetState.any last as a fallback.  Values may be '
            'null to fall through to the framework default.',
            style: TextStyle(color: _wsobMute, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Reusable building blocks — section header, code block, pill, medallion
// ═════════════════════════════════════════════════════════════════════

class _WsobSectionHeader extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final String title;
  final String subtitle;
  const _WsobSectionHeader({
    required this.icon,
    required this.accent,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent, width: 1.2),
          ),
          child: Icon(icon, color: accent, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _wsobInk,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _wsobMute,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WsobCodeBlock extends StatelessWidget {
  final String code;
  const _WsobCodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _wsobMahoganyDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _wsobBrassDeep, width: 1),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: _wsobBrassBright,
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.45,
        ),
      ),
    );
  }
}

class _WsobPill extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  const _WsobPill({
    required this.label,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, color: color, size: 13),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// A medallion rendered inside a `Material` whose `shape` is actually a live
/// `WidgetStateOutlinedBorder.fromMap`.  When the `state` changes the shape
/// resolves on the next paint — this is the headline feature of the demo.
class _WsobMedallion extends StatelessWidget {
  final _WsobPseudoState state;
  final double size;
  final double pressPulse;
  const _WsobMedallion({
    required this.state,
    required this.size,
    required this.pressPulse,
  });

  @override
  Widget build(BuildContext context) {
    final OutlinedBorder border = _buildStateBorder().resolve(state.asSet) ??
        const RoundedRectangleBorder();
    final Color fill = state.tint.withValues(alpha: 0.18);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: size * 1.4,
          height: size * 1.4,
          child: CustomPaint(
            painter: _WsobBurstPainter(
              pulse: pressPulse,
              accent: state.tint,
            ),
          ),
        ),
        Material(
          color: fill,
          elevation: state == _WsobPseudoState.pressed ? 1 : 6,
          shadowColor: _wsobMahoganyDeep.withValues(alpha: 0.55),
          shape: border,
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(state.icon, size: 28, color: state.tint),
                  const SizedBox(height: 4),
                  Text(
                    state.label.toUpperCase(),
                    style: TextStyle(
                      color: state.tint,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  WidgetStateOutlinedBorder _buildStateBorder() {
    return WidgetStateOutlinedBorder.fromMap(
      <WidgetStatesConstraint, OutlinedBorder?>{
        WidgetState.disabled: StadiumBorder(
          side: BorderSide(color: _wsobMute, width: 1.0),
        ),
        WidgetState.error: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: _wsobError, width: 2.0),
        ),
        WidgetState.selected: StarBorder(
          points: 5,
          side: BorderSide(color: _wsobSuccess, width: 2.2),
        ),
        WidgetState.pressed: CircleBorder(
          side: BorderSide(color: _wsobAccent, width: 3.0),
        ),
        WidgetState.focused: StarBorder(
          points: 5,
          side: BorderSide(color: _wsobBrass, width: 2.5),
        ),
        WidgetState.hovered: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: _wsobBrassBright, width: 1.6),
        ),
        WidgetState.any: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: _wsobPewter, width: 1.2),
        ),
      },
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 3 — Live medallion press
// ═════════════════════════════════════════════════════════════════════

class _WsobLivePress extends StatelessWidget {
  final _WsobPseudoState state;
  final ValueChanged<_WsobPseudoState> onPick;
  final AnimationController pressController;
  const _WsobLivePress({
    required this.state,
    required this.onPick,
    required this.pressController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WsobSectionHeader(
            icon: Icons.precision_manufacturing_outlined,
            accent: _wsobAccent,
            title: 'Section 3 — Live medallion press',
            subtitle:
                'A Material whose shape is a WidgetStateOutlinedBorder.fromMap',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final bool wide = cons.maxWidth >= 640;
              final Widget press = _WsobPressBed(
                state: state,
                controller: pressController,
              );
              final Widget toggles = _WsobStatePicker(
                current: state,
                onPick: onPick,
              );
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 4, child: press),
                    const SizedBox(width: 14),
                    Expanded(flex: 3, child: toggles),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  press,
                  const SizedBox(height: 14),
                  toggles,
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'The Material above is rendered with shape: '
            'WidgetStateOutlinedBorder.fromMap(...).  Each toggle changes '
            'the Set<WidgetState> handed to the resolver, and the '
            'OutlinedBorder returned is reapplied to the Material.',
            style: TextStyle(color: _wsobMute, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _WsobPressBed extends StatelessWidget {
  final _WsobPseudoState state;
  final AnimationController controller;
  const _WsobPressBed({required this.state, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext ctx, Widget? child) {
          final double t = controller.value;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(
                  painter: _WsobPressBedPainter(
                    pulse: t,
                    mahogany: _wsobMahogany,
                    mahoganyDeep: _wsobMahoganyDeep,
                    brass: _wsobBrass,
                    brassDeep: _wsobBrassDeep,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -4 + 6 * (1 - t)),
                child: _WsobMedallion(
                  state: state,
                  size: 118,
                  pressPulse: t,
                ),
              ),
              Positioned(
                left: 14,
                top: 14,
                child: _WsobPill(
                  label: 'resolve(${state.label})',
                  color: _wsobBrassBright,
                  icon: Icons.tune_outlined,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _WsobStatePicker extends StatelessWidget {
  final _WsobPseudoState current;
  final ValueChanged<_WsobPseudoState> onPick;
  const _WsobStatePicker({required this.current, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wsobPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Pick pseudo-state',
            style: TextStyle(
              color: _wsobInk,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _WsobPseudoState.values
                .map(
                  (_WsobPseudoState s) => _WsobStateToggle(
                    state: s,
                    selected: s == current,
                    onTap: () => onPick(s),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          const Divider(color: _wsobPaperEdge, height: 1),
          const SizedBox(height: 10),
          Text(
            'Current set: ${current.asSet.map((WidgetState w) => w.toString().split('.').last).join(', ').isEmpty ? '(empty — idle)' : current.asSet.map((WidgetState w) => w.toString().split('.').last).join(', ')}',
            style: const TextStyle(
              color: _wsobMute,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _WsobStateToggle extends StatelessWidget {
  final _WsobPseudoState state;
  final bool selected;
  final VoidCallback onTap;
  const _WsobStateToggle({
    required this.state,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color tint = state.tint;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? tint.withValues(alpha: 0.18)
              : _wsobPaper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? tint : _wsobPaperEdge,
            width: selected ? 1.6 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(state.icon, size: 14, color: tint),
            const SizedBox(width: 6),
            Text(
              state.label,
              style: TextStyle(
                color: selected ? tint : _wsobInk,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 4 — Shape library
// ═════════════════════════════════════════════════════════════════════

class _WsobShapeLibrary extends StatelessWidget {
  const _WsobShapeLibrary();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WsobSectionHeader(
            icon: Icons.dashboard_customize_outlined,
            accent: _wsobSuccess,
            title: 'Section 4 — OutlinedBorder shape library',
            subtitle: 'Each concrete subclass with its parameter summary',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final int columns = cons.maxWidth >= 900
                  ? 3
                  : cons.maxWidth >= 560
                      ? 2
                      : 1;
              final List<_WsobShapeKind> kinds = _WsobShapeKind.values;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: kinds.map((_WsobShapeKind k) {
                  final double w =
                      (cons.maxWidth - (columns - 1) * 12) / columns;
                  return SizedBox(
                    width: w,
                    child: _WsobShapeLibraryCard(kind: k),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WsobShapeLibraryCard extends StatelessWidget {
  final _WsobShapeKind kind;
  const _WsobShapeLibraryCard({required this.kind});

  @override
  Widget build(BuildContext context) {
    final OutlinedBorder border = kind.borderWithSide(
      const BorderSide(color: _wsobBrassDeep, width: 1.5),
    );
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wsobPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(kind.icon, color: _wsobBrassDeep, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  kind.label,
                  style: const TextStyle(
                    color: _wsobInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Material(
              color: _wsobBrass.withValues(alpha: 0.16),
              shape: border,
              elevation: 0,
              child: const SizedBox(
                width: 90,
                height: 64,
                child: Center(
                  child: Icon(
                    Icons.token_outlined,
                    color: _wsobBrassDeep,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            kind.tagline,
            style: const TextStyle(
              color: _wsobInk,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            kind.params,
            style: const TextStyle(
              color: _wsobMute,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 5 — Button theme showcase
// ═════════════════════════════════════════════════════════════════════

class _WsobButtonShowcase extends StatelessWidget {
  const _WsobButtonShowcase();

  @override
  Widget build(BuildContext context) {
    final WidgetStateOutlinedBorder buttonShape =
        WidgetStateOutlinedBorder.fromMap(
      <WidgetStatesConstraint, OutlinedBorder?>{
        WidgetState.disabled: const StadiumBorder(
          side: BorderSide(color: _wsobMute, width: 1.0),
        ),
        WidgetState.pressed: const CircleBorder(
          side: BorderSide(color: _wsobAccent, width: 3.0),
        ),
        WidgetState.hovered: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: const BorderSide(color: _wsobBrassBright, width: 1.6),
        ),
        WidgetState.focused: StarBorder(
          points: 5,
          side: const BorderSide(color: _wsobBrass, width: 2.0),
        ),
        WidgetState.any: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: _wsobPewterEdge, width: 1.0),
        ),
      },
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WsobSectionHeader(
            icon: Icons.smart_button_outlined,
            accent: _wsobBrass,
            title: 'Section 5 — Button theme showcase',
            subtitle:
                'ButtonStyle.shape wired to WidgetStateOutlinedBorder.fromMap',
          ),
          const SizedBox(height: 12),
          const _WsobCodeBlock(
            code:
                'ButtonStyle(\n'
                '  shape: WidgetStateOutlinedBorder.fromMap(<..., OutlinedBorder?>{\n'
                '    WidgetState.disabled: StadiumBorder(side: muted),\n'
                '    WidgetState.pressed : CircleBorder(side: accent),\n'
                '    WidgetState.hovered : RoundedRect(28, brass),\n'
                '    WidgetState.focused : StarBorder(points: 5, brass),\n'
                '    WidgetState.any     : RoundedRect(14, pewter),\n'
                '  }),\n'
                ')',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: _wsobInk,
                  side: const BorderSide(color: _wsobBrassDeep, width: 1.2),
                ).copyWith(
                  shape: WidgetStateProperty.all<OutlinedBorder?>(
                    buttonShape.resolve(<WidgetState>{}),
                  ),
                ),
                child: const Text('Outlined (idle)'),
              ),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: _wsobBrass,
                  foregroundColor: _wsobInk,
                ).copyWith(
                  shape: WidgetStateProperty.all<OutlinedBorder?>(
                    buttonShape.resolve(<WidgetState>{WidgetState.hovered}),
                  ),
                ),
                child: const Text('Filled (hovered resolve)'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _wsobAccent,
                  foregroundColor: _wsobCream,
                ).copyWith(
                  shape: WidgetStateProperty.all<OutlinedBorder?>(
                    buttonShape.resolve(<WidgetState>{WidgetState.focused}),
                  ),
                ),
                child: const Text('Elevated (focused resolve)'),
              ),
              FilledButton(
                onPressed: null,
                style: FilledButton.styleFrom(
                  disabledBackgroundColor:
                      _wsobMute.withValues(alpha: 0.25),
                  disabledForegroundColor: _wsobMute,
                ).copyWith(
                  shape: WidgetStateProperty.all<OutlinedBorder?>(
                    buttonShape.resolve(<WidgetState>{WidgetState.disabled}),
                  ),
                ),
                child: const Text('Disabled'),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: _wsobAccent,
                  side: const BorderSide(color: _wsobAccent, width: 2),
                ).copyWith(
                  shape: WidgetStateProperty.all<OutlinedBorder?>(
                    buttonShape.resolve(<WidgetState>{WidgetState.pressed}),
                  ),
                ),
                child: const Text('Pressed resolve'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Each button above is rendered with a shape computed by calling '
            '`resolve(Set<WidgetState>)` directly on the mapper — simulating '
            'what the framework will do at paint time for the real pointer '
            'state.',
            style: TextStyle(color: _wsobMute, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 6 — Chip showcase
// ═════════════════════════════════════════════════════════════════════

class _WsobChipShowcase extends StatelessWidget {
  final bool selected;
  final VoidCallback onToggleSelected;
  final bool filtered;
  final VoidCallback onToggleFilter;

  const _WsobChipShowcase({
    required this.selected,
    required this.onToggleSelected,
    required this.filtered,
    required this.onToggleFilter,
  });

  @override
  Widget build(BuildContext context) {
    final WidgetStateOutlinedBorder chipShape =
        WidgetStateOutlinedBorder.fromMap(
      <WidgetStatesConstraint, OutlinedBorder?>{
        WidgetState.selected: StarBorder(
          points: 5,
          side: const BorderSide(color: _wsobSuccess, width: 2),
        ),
        WidgetState.disabled: const StadiumBorder(
          side: BorderSide(color: _wsobMute, width: 1),
        ),
        WidgetState.any: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: _wsobBrassDeep, width: 1.2),
        ),
      },
    );

    final OutlinedBorder? choiceShape = chipShape.resolve(
      selected ? <WidgetState>{WidgetState.selected} : <WidgetState>{},
    );
    final OutlinedBorder? filterShape = chipShape.resolve(
      filtered ? <WidgetState>{WidgetState.selected} : <WidgetState>{},
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WsobSectionHeader(
            icon: Icons.token_outlined,
            accent: _wsobAccent,
            title: 'Section 6 — Chip showcase',
            subtitle:
                'ChoiceChip / FilterChip toggled → star when selected',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              ChoiceChip(
                label: const Text('Die A'),
                selected: selected,
                onSelected: (_) => onToggleSelected(),
                shape: choiceShape,
                selectedColor: _wsobSuccess.withValues(alpha: 0.25),
                backgroundColor: _wsobPaper,
              ),
              ChoiceChip(
                label: const Text('Die B'),
                selected: !selected,
                onSelected: (_) => onToggleSelected(),
                shape: chipShape.resolve(
                  !selected
                      ? <WidgetState>{WidgetState.selected}
                      : <WidgetState>{},
                ),
                selectedColor: _wsobSuccess.withValues(alpha: 0.25),
                backgroundColor: _wsobPaper,
              ),
              FilterChip(
                label: const Text('Embossing'),
                selected: filtered,
                onSelected: (_) => onToggleFilter(),
                shape: filterShape,
                selectedColor: _wsobSuccess.withValues(alpha: 0.25),
                backgroundColor: _wsobPaper,
              ),
              FilterChip(
                label: const Text('Rim-knurl'),
                selected: !filtered,
                onSelected: (_) => onToggleFilter(),
                shape: chipShape.resolve(
                  !filtered
                      ? <WidgetState>{WidgetState.selected}
                      : <WidgetState>{},
                ),
                selectedColor: _wsobSuccess.withValues(alpha: 0.25),
                backgroundColor: _wsobPaper,
              ),
              const Chip(
                label: Text('Disabled'),
                shape: StadiumBorder(
                  side: BorderSide(color: _wsobMute, width: 1),
                ),
                backgroundColor: Color(0x22B6BCC2),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Toggling a chip swaps its shape from RoundedRect(20) to '
            'StarBorder(points: 5).  The same mapper is used for both '
            'ChoiceChip and FilterChip — no chip-specific code required.',
            style: TextStyle(color: _wsobMute, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 7 — Morph animation
// ═════════════════════════════════════════════════════════════════════

class _WsobMorphSection extends StatelessWidget {
  final AnimationController controller;
  final _WsobShapeKind left;
  final _WsobShapeKind right;
  final ValueChanged<_WsobShapeKind> onPickLeft;
  final ValueChanged<_WsobShapeKind> onPickRight;

  const _WsobMorphSection({
    required this.controller,
    required this.left,
    required this.right,
    required this.onPickLeft,
    required this.onPickRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WsobSectionHeader(
            icon: Icons.sync_alt_outlined,
            accent: _wsobAccent,
            title: 'Section 7 — Shape morph animation',
            subtitle:
                'ShapeBorder.lerp(leftShape, rightShape, controller.value)',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final bool wide = cons.maxWidth >= 620;
              final Widget stage = _WsobMorphStage(
                controller: controller,
                left: left,
                right: right,
              );
              final Widget pickers = _WsobMorphPickers(
                left: left,
                right: right,
                onPickLeft: onPickLeft,
                onPickRight: onPickRight,
              );
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 5, child: stage),
                    const SizedBox(width: 14),
                    Expanded(flex: 4, child: pickers),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  stage,
                  const SizedBox(height: 14),
                  pickers,
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'The controller drives a t ∈ [0, 1] between two OutlinedBorders. '
            'ShapeBorder.lerp handles incompatible pairs by falling back to '
            'a generic linear blend; the frame is still renderable.',
            style: TextStyle(color: _wsobMute, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _WsobMorphStage extends StatelessWidget {
  final AnimationController controller;
  final _WsobShapeKind left;
  final _WsobShapeKind right;

  const _WsobMorphStage({
    required this.controller,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext ctx, Widget? child) {
          final double t = Curves.easeInOutCubic.transform(controller.value);
          final OutlinedBorder a = left.borderWithSide(
            const BorderSide(color: _wsobBrassDeep, width: 2),
          );
          final OutlinedBorder b = right.borderWithSide(
            const BorderSide(color: _wsobAccent, width: 2),
          );
          final ShapeBorder? blended = ShapeBorder.lerp(a, b, t);
          final OutlinedBorder final0 = blended is OutlinedBorder
              ? blended
              : a;
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _wsobPaper,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _wsobPaperEdge, width: 1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Material(
                  color: _wsobBrass.withValues(alpha: 0.12),
                  shape: final0,
                  elevation: 4,
                  shadowColor: _wsobMahoganyDeep.withValues(alpha: 0.45),
                  child: const SizedBox(
                    width: 180,
                    height: 130,
                    child: Center(
                      child: Icon(
                        Icons.token_outlined,
                        color: _wsobBrassDeep,
                        size: 36,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: _WsobPill(
                    label: 't = ${t.toStringAsFixed(2)}',
                    color: _wsobAccent,
                    icon: Icons.timer_outlined,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: _WsobPill(
                    label: '${left.label} → ${right.label}',
                    color: _wsobBrassDeep,
                    icon: Icons.compare_arrows_outlined,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _WsobMorphPickers extends StatelessWidget {
  final _WsobShapeKind left;
  final _WsobShapeKind right;
  final ValueChanged<_WsobShapeKind> onPickLeft;
  final ValueChanged<_WsobShapeKind> onPickRight;

  const _WsobMorphPickers({
    required this.left,
    required this.right,
    required this.onPickLeft,
    required this.onPickRight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _WsobMorphPickerColumn(
          title: 'Start shape',
          accent: _wsobBrassDeep,
          current: left,
          onPick: onPickLeft,
        ),
        const SizedBox(height: 10),
        _WsobMorphPickerColumn(
          title: 'End shape',
          accent: _wsobAccent,
          current: right,
          onPick: onPickRight,
        ),
      ],
    );
  }
}

class _WsobMorphPickerColumn extends StatelessWidget {
  final String title;
  final Color accent;
  final _WsobShapeKind current;
  final ValueChanged<_WsobShapeKind> onPick;

  const _WsobMorphPickerColumn({
    required this.title,
    required this.accent,
    required this.current,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _wsobPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.tune_outlined, color: accent, size: 15),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _WsobShapeKind.values
                .map(
                  (_WsobShapeKind k) => InkWell(
                    onTap: () => onPick(k),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: k == current
                            ? accent.withValues(alpha: 0.18)
                            : _wsobCream,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: k == current ? accent : _wsobPaperEdge,
                          width: k == current ? 1.4 : 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(k.icon, size: 12, color: accent),
                          const SizedBox(width: 5),
                          Text(
                            k.label.replaceAll('Border', ''),
                            style: TextStyle(
                              color: _wsobInk,
                              fontSize: 11,
                              fontWeight: k == current
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 8 — Comparison table
// ═════════════════════════════════════════════════════════════════════

class _WsobComparisonTable extends StatelessWidget {
  const _WsobComparisonTable();

  @override
  Widget build(BuildContext context) {
    const List<_WsobComparisonRow> rows = <_WsobComparisonRow>[
      _WsobComparisonRow(
        feature: 'Stateful',
        wsob: 'yes (via resolve)',
        plain: 'no — static',
        legacy: 'yes (pre-M3 name)',
        conditional: 'yes, but manual',
      ),
      _WsobComparisonRow(
        feature: 'Entry point',
        wsob: '.fromMap factory',
        plain: 'ctor of subclass',
        legacy: '.fromMap (deprec)',
        conditional: 'if/else in build',
      ),
      _WsobComparisonRow(
        feature: 'Type',
        wsob: 'OutlinedBorder',
        plain: 'OutlinedBorder',
        legacy: 'OutlinedBorder',
        conditional: 'OutlinedBorder',
      ),
      _WsobComparisonRow(
        feature: 'Drives ButtonStyle?',
        wsob: 'direct',
        plain: 'direct',
        legacy: 'direct',
        conditional: 'via WrappedState',
      ),
      _WsobComparisonRow(
        feature: 'Migration status',
        wsob: 'preferred (M3+)',
        plain: 'always fine',
        legacy: 'deprecated alias',
        conditional: 'escape hatch',
      ),
      _WsobComparisonRow(
        feature: 'Verbosity',
        wsob: 'low — map literal',
        plain: 'minimal',
        legacy: 'low — map literal',
        conditional: 'high — state-aware',
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WsobSectionHeader(
            icon: Icons.compare_outlined,
            accent: _wsobBrassDeep,
            title: 'Section 8 — Comparison',
            subtitle:
                'WSOB vs plain OutlinedBorder vs MaterialStateOutlinedBorder '
                'vs conditional switching',
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: _wsobPaper,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _wsobPaperEdge, width: 1),
            ),
            child: Column(
              children: <Widget>[
                const _WsobComparisonHeader(),
                ...List<Widget>.generate(rows.length, (int i) {
                  return _WsobComparisonRowView(
                    row: rows[i],
                    alt: i.isEven,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WsobComparisonHeader extends StatelessWidget {
  const _WsobComparisonHeader();

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
      color: _wsobCream,
      fontWeight: FontWeight.w800,
      fontSize: 11,
      letterSpacing: 0.3,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: const BoxDecoration(
        color: _wsobMahogany,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: const Row(
        children: <Widget>[
          Expanded(flex: 3, child: Text('Feature', style: style)),
          Expanded(flex: 4, child: Text('WSOB', style: style)),
          Expanded(flex: 3, child: Text('plain', style: style)),
          Expanded(flex: 3, child: Text('legacy', style: style)),
          Expanded(flex: 3, child: Text('conditional', style: style)),
        ],
      ),
    );
  }
}

class _WsobComparisonRowView extends StatelessWidget {
  final _WsobComparisonRow row;
  final bool alt;
  const _WsobComparisonRowView({required this.row, required this.alt});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: _wsobInk, fontSize: 11.5);
    const TextStyle featureStyle = TextStyle(
      color: _wsobInk,
      fontSize: 11.5,
      fontWeight: FontWeight.w700,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      color: alt ? _wsobPaper : _wsobCream,
      child: Row(
        children: <Widget>[
          Expanded(flex: 3, child: Text(row.feature, style: featureStyle)),
          Expanded(flex: 4, child: Text(row.wsob, style: style)),
          Expanded(flex: 3, child: Text(row.plain, style: style)),
          Expanded(flex: 3, child: Text(row.legacy, style: style)),
          Expanded(flex: 3, child: Text(row.conditional, style: style)),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 9 — Recipe cards
// ═════════════════════════════════════════════════════════════════════

class _WsobRecipeCards extends StatelessWidget {
  const _WsobRecipeCards();

  @override
  Widget build(BuildContext context) {
    const List<_WsobRecipe> recipes = <_WsobRecipe>[
      _WsobRecipe(
        icon: Icons.star_outline,
        accent: _wsobSuccess,
        title: 'Selected → star',
        stateExpr: 'WidgetState.selected',
        shapeExpr:
            'StarBorder(points: 5, side: BorderSide(gold, 2))',
        explanation:
            'The classic celebratory shape for an active choice.  Keep the '
            'side width around 2 so the star silhouette reads cleanly at '
            'typical chip sizes.',
      ),
      _WsobRecipe(
        icon: Icons.center_focus_strong_outlined,
        accent: _wsobBrass,
        title: 'Focused → star + thicker ring',
        stateExpr: 'WidgetState.focused',
        shapeExpr: 'StarBorder(points: 5, side: BorderSide(brass, 2.5))',
        explanation:
            'Accessibility guideline: focused elements must have a visually '
            'distinctive outline.  Bumping the side width to 2.5 on the '
            'star gives keyboard users a crisp anchor.',
      ),
      _WsobRecipe(
        icon: Icons.block_outlined,
        accent: _wsobMute,
        title: 'Disabled → muted stadium',
        stateExpr: 'WidgetState.disabled',
        shapeExpr: 'StadiumBorder(side: BorderSide(mutedGrey, 1))',
        explanation:
            'A low-contrast, rounded silhouette tells the user "this is '
            'here but not actionable".  Stadium works well because it does '
            'not compete visually with the active shapes.',
      ),
      _WsobRecipe(
        icon: Icons.error_outline,
        accent: _wsobError,
        title: 'Error → tiny-radius rectangle',
        stateExpr: 'WidgetState.error',
        shapeExpr:
            'RoundedRectangleBorder(borderRadius: 6, side: err2)',
        explanation:
            'Sharp corners read as "something is wrong" in the M3 shape '
            'language.  Combine with a red 2-px side for a strong signal '
            'without reaching for an icon.',
      ),
      _WsobRecipe(
        icon: Icons.touch_app_outlined,
        accent: _wsobAccent,
        title: 'Pressed → shrunken circle',
        stateExpr: 'WidgetState.pressed',
        shapeExpr: 'CircleBorder(side: BorderSide(accent, 3))',
        explanation:
            'A circle with a thicker side produces a satisfying "puck" '
            'feel during a press.  Works particularly well on square-ish '
            'targets where the shape change is obvious.',
      ),
      _WsobRecipe(
        icon: Icons.mouse_outlined,
        accent: _wsobBrassBright,
        title: 'Hovered → larger radius',
        stateExpr: 'WidgetState.hovered',
        shapeExpr: 'RoundedRectangleBorder(borderRadius: 28, brassBright)',
        explanation:
            'The softest possible expansion cue for desktop-class hover. '
            'Keep the radius bump modest (≤ 6 px) so pointer-in / pointer-'
            'out do not feel jittery.',
      ),
      _WsobRecipe(
        icon: Icons.layers_outlined,
        accent: _wsobBrassDeep,
        title: 'Fallback → rounded pewter',
        stateExpr: 'WidgetState.any',
        shapeExpr: 'RoundedRectangleBorder(borderRadius: 24, pewter)',
        explanation:
            'Always include a WidgetState.any entry as the final fallback '
            '— without it, unmatched states return null and the framework '
            'may paint an unrelated default.',
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _wsobCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _wsobPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WsobSectionHeader(
            icon: Icons.receipt_long_outlined,
            accent: _wsobAccent,
            title: 'Section 9 — Recipes',
            subtitle: 'Seven patterns for WidgetStateOutlinedBorder.fromMap',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final int columns = cons.maxWidth >= 920
                  ? 3
                  : cons.maxWidth >= 620
                      ? 2
                      : 1;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: recipes.map((_WsobRecipe r) {
                  final double w =
                      (cons.maxWidth - (columns - 1) * 12) / columns;
                  return SizedBox(
                    width: w,
                    child: _WsobRecipeCardView(recipe: r),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WsobRecipeCardView extends StatelessWidget {
  final _WsobRecipe recipe;
  const _WsobRecipeCardView({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: _wsobPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: recipe.accent, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: recipe.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(recipe.icon, color: recipe.accent, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    color: _wsobInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recipe.stateExpr,
            style: TextStyle(
              color: recipe.accent,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            recipe.shapeExpr,
            style: const TextStyle(
              color: _wsobMahogany,
              fontSize: 10.5,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            recipe.explanation,
            style: const TextStyle(
              color: _wsobInk,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Event log — last interactions (small supporting section)
// ═════════════════════════════════════════════════════════════════════

class _WsobEventLog extends StatelessWidget {
  final List<String> entries;
  const _WsobEventLog({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _wsobMahoganyDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wsobBrassDeep, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.receipt_outlined,
                color: _wsobBrassBright,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Event log',
                style: TextStyle(
                  color: _wsobBrassBright,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              _WsobPill(
                label: '${entries.length} event(s)',
                color: _wsobBrass,
                icon: Icons.bolt_outlined,
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (entries.isEmpty)
            const Text(
              '(no events yet — tap a state toggle or a chip)',
              style: TextStyle(
                color: _wsobCream,
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Column(
              children: entries
                  .map(
                    (String e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        e,
                        style: const TextStyle(
                          color: _wsobBrassBright,
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 10 — Glossary / epilogue
// ═════════════════════════════════════════════════════════════════════

class _WsobGlossary extends StatelessWidget {
  const _WsobGlossary();

  @override
  Widget build(BuildContext context) {
    const List<_WsobGlossaryEntry> entries = <_WsobGlossaryEntry>[
      _WsobGlossaryEntry(
        term: 'WidgetStateOutlinedBorder',
        definition:
            'Abstract mixin class extending OutlinedBorder and '
            'implementing WidgetStateProperty<OutlinedBorder?>.  Pass it '
            'anywhere an OutlinedBorder is expected.',
      ),
      _WsobGlossaryEntry(
        term: '.fromMap(...)',
        definition:
            'Factory that wraps a WidgetStateMap<OutlinedBorder?> in a '
            'private mapper.  Map keys are WidgetStatesConstraint, values '
            'are OutlinedBorder?.',
      ),
      _WsobGlossaryEntry(
        term: 'resolve(Set<WidgetState>)',
        definition:
            'Walks the map top-to-bottom and returns the first value whose '
            'constraint is satisfied by the incoming state set.',
      ),
      _WsobGlossaryEntry(
        term: 'WidgetState.any',
        definition:
            'Sentinel predicate that matches every state set.  Use as the '
            'last map entry to guarantee a fallback shape.',
      ),
      _WsobGlossaryEntry(
        term: 'OutlinedBorder',
        definition:
            'Abstract base for borders that have a BorderSide.  Known '
            'subclasses: RoundedRectangleBorder, StadiumBorder, '
            'CircleBorder, ContinuousRectangleBorder, '
            'BeveledRectangleBorder, StarBorder.',
      ),
      _WsobGlossaryEntry(
        term: 'ShapeBorder.lerp(a, b, t)',
        definition:
            'Interpolates between two shape borders.  When the pair is '
            'incompatible the framework falls back to a generic blend and '
            'returns something renderable.',
      ),
      _WsobGlossaryEntry(
        term: 'MaterialStateOutlinedBorder',
        definition:
            'Deprecated pre-M3 alias for WidgetStateOutlinedBorder.  Kept '
            'for migration; new code should not depend on it.',
      ),
      _WsobGlossaryEntry(
        term: 'ButtonStyle.shape',
        definition:
            'WidgetStateProperty<OutlinedBorder?> slot on ButtonStyle. A '
            'WidgetStateOutlinedBorder can be supplied directly.',
      ),
      _WsobGlossaryEntry(
        term: 'StarBorder(points: 5)',
        definition:
            'Star-shaped OutlinedBorder with 5 points.  Additional fields '
            '(innerRadiusRatio, pointRounding, squash) default to sensible '
            'values.',
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wsobMahoganyDeep, _wsobMahogany],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wsobMahoganyDeep.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _wsobBrass.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _wsobBrass, width: 1.2),
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: _wsobBrassBright,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Section 10 — Glossary & epilogue',
                  style: TextStyle(
                    color: _wsobBrassBright,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Closing reference.  Keep these terms handy when reading '
            'Flutter source or migrating Material 2 code.',
            style: TextStyle(
              color: _wsobCream,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14),
          ...entries.map(
            (_WsobGlossaryEntry g) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: _wsobCream.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _wsobBrass.withValues(alpha: 0.55),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      g.term,
                      style: const TextStyle(
                        color: _wsobBrassBright,
                        fontWeight: FontWeight.w800,
                        fontSize: 12.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      g.definition,
                      style: const TextStyle(
                        color: _wsobCream,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '— End of demo.  The live Material above is wired to a real '
            'WidgetStateOutlinedBorder.fromMap; every pseudo-state toggle '
            'funnels through the resolver.',
            style: TextStyle(
              color: _wsobBrassBright,
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
