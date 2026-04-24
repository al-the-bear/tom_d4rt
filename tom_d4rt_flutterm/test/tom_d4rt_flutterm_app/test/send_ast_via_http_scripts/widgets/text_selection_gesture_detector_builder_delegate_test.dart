// =========================================================================
// Deep Demo — TextSelectionGestureDetectorBuilderDelegate
// -------------------------------------------------------------------------
// Theme: "Gesture Bridge Works" — a civil-engineering aesthetic in which
// the abstract delegate plays the role of a cable-stay bridge connecting
// the EditableText on one bank to the TextSelectionGestureDetector on the
// other. The mustard pulses travelling along the cables represent the
// high-level gesture signals (onSingleTapUp, onDoubleTapDown, ...) flowing
// from the detector to the EditableTextState identified by the delegate's
// editableTextKey.
//
// Subject under demonstration
// ---------------------------
// TextSelectionGestureDetectorBuilderDelegate is an abstract interface
// declared in Flutter's widgets/text_selection.dart. It has exactly three
// read-only getters:
//
//   abstract class TextSelectionGestureDetectorBuilderDelegate {
//     GlobalKey<EditableTextState> get editableTextKey;
//     bool get forcePressEnabled;
//     bool get selectionEnabled;
//   }
//
// A TextSelectionGestureDetectorBuilder consumes an instance of that
// delegate in its single-argument constructor:
//
//   TextSelectionGestureDetectorBuilder({required this.delegate});
//
// The builder uses the delegate to:
//   * locate the current EditableTextState via editableTextKey.currentState
//   * skip wiring onForcePressStart/End when forcePressEnabled is false
//   * suppress selection-affecting callbacks when selectionEnabled is false
//
// Typical pattern: the State object of a widget that builds an EditableText
// implements this interface itself and passes `this` to the builder. This
// demo follows the explicit composition pattern instead — we define a
// concrete class `_TsgdbdBridgeDelegate` whose sole responsibility is the
// three getters, and feed it into the builder. That keeps the contract
// visible and makes it easier to reason about the interface surface.
//
// Structure of this file
// ----------------------
//   1. Public AST entry point:              dynamic build(BuildContext)
//   2. Hero bridge painter:                 _TsgdbdBridgePainter
//   3. Signal-flow diagram painter:         _TsgdbdSignalFlowPainter
//   4. Concrete delegate:                   _TsgdbdBridgeDelegate
//   5. Integrated stage (selection on):     _TsgdbdStage
//   6. Suppressed stage (selection off):    _TsgdbdSuppressedStage
//   7. Scaffold/theme wrapper:              _TsgdbdApp
//   8. Information cards (API, pitfall, method directory, DataTable)
//
// Hard constraints honoured
// -------------------------
//   * No ignore directives, no analysis_options tweaks.
//   * Private classes prefixed with `_Tsgdbd`.
//   * Uses `debugPrint`, `.withValues(alpha:)`, `.r/.g/.b/.a` accessors.
//   * The concrete `_TsgdbdBridgeDelegate implements
//     TextSelectionGestureDetectorBuilderDelegate` — fully compile-checked
//     against the Flutter 3.41.6 interface declared in
//     packages/flutter/lib/src/widgets/text_selection.dart.
//   * EditableText is wired with focusNode + controller + style +
//     cursorColor + backgroundCursorColor + onChanged, which is the
//     recommended minimal integration for a gesture demo.
// =========================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

// -------------------------------------------------------------------------
// Theme palette — shared across all painters and cards.
// -------------------------------------------------------------------------
const Color _tsgdbdTeal = Color(0xFF1F6E8C);
const Color _tsgdbdMustard = Color(0xFFE0B248);
const Color _tsgdbdCream = Color(0xFFF5EEE0);
const Color _tsgdbdNavy = Color(0xFF0E2232);
const Color _tsgdbdTealDeep = Color(0xFF14536B);
const Color _tsgdbdMustardGlow = Color(0xFFF2C969);
const Color _tsgdbdCreamDim = Color(0xFFE4D9BF);
const Color _tsgdbdSlate = Color(0xFF2A3B49);

// -------------------------------------------------------------------------
// AST harness entry point.
//
// The d4rt harness invokes `build(BuildContext)` and expects a Widget.
// We return a MaterialApp whose home is our top-level `_TsgdbdApp`.
// -------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('[Tsgdbd] build() — constructing Gesture Bridge Works demo');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Gesture Bridge Works',
    home: _TsgdbdApp(),
  );
}

// =========================================================================
// _TsgdbdApp — root scaffold.
// =========================================================================
class _TsgdbdApp extends StatefulWidget {
  const _TsgdbdApp();

  @override
  State<_TsgdbdApp> createState() => _TsgdbdAppState();
}

class _TsgdbdAppState extends State<_TsgdbdApp>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    debugPrint('[Tsgdbd] _TsgdbdAppState.initState');
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    debugPrint('[Tsgdbd] _TsgdbdAppState.dispose');
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _tsgdbdNavy,
        colorScheme: const ColorScheme.dark(
          primary: _tsgdbdTeal,
          secondary: _tsgdbdMustard,
          surface: _tsgdbdNavy,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _tsgdbdCream),
          bodyLarge: TextStyle(color: _tsgdbdCream),
          titleLarge: TextStyle(color: _tsgdbdCream),
        ),
      ),
      child: Scaffold(
        backgroundColor: _tsgdbdNavy,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _TsgdbdHeroHeader(controller: _pulseController),
                const SizedBox(height: 22),
                const _TsgdbdIntroCard(),
                const SizedBox(height: 20),
                _TsgdbdSectionHeading(
                  ordinal: '01',
                  title: 'Interface surface',
                  subtitle: 'Three getters, no more, no less.',
                ),
                const SizedBox(height: 12),
                const _TsgdbdApiCard(),
                const SizedBox(height: 20),
                _TsgdbdSectionHeading(
                  ordinal: '02',
                  title: 'Live integration — selection enabled',
                  subtitle:
                      'Concrete delegate wired through builder into EditableText.',
                ),
                const SizedBox(height: 12),
                const _TsgdbdStage(
                  title: 'Bridge A — selection ON, force press OFF',
                  selectionEnabled: true,
                  forcePressEnabled: false,
                  accent: _tsgdbdMustard,
                ),
                const SizedBox(height: 24),
                _TsgdbdSectionHeading(
                  ordinal: '03',
                  title: 'Companion — selection suppressed',
                  subtitle:
                      'Same interface, different configuration. No text selection.',
                ),
                const SizedBox(height: 12),
                const _TsgdbdSuppressedStage(),
                const SizedBox(height: 24),
                _TsgdbdSectionHeading(
                  ordinal: '04',
                  title: 'Signal-flow diagram',
                  subtitle:
                      'Gesture → Detector → Delegate → EditableTextState.',
                ),
                const SizedBox(height: 12),
                _TsgdbdSignalFlowCard(controller: _pulseController),
                const SizedBox(height: 24),
                _TsgdbdSectionHeading(
                  ordinal: '05',
                  title: 'Method directory',
                  subtitle:
                      'Delegate properties and the builder callbacks they gate.',
                ),
                const SizedBox(height: 12),
                const _TsgdbdMethodDirectory(),
                const SizedBox(height: 24),
                _TsgdbdSectionHeading(
                  ordinal: '06',
                  title: 'Pitfall',
                  subtitle: 'One delegate, one key, one EditableTextState.',
                ),
                const SizedBox(height: 12),
                const _TsgdbdPitfallCard(),
                const SizedBox(height: 24),
                const _TsgdbdFooter(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// _TsgdbdHeroHeader — animated cable-stay bridge with mustard pulses.
// =========================================================================
class _TsgdbdHeroHeader extends StatelessWidget {
  const _TsgdbdHeroHeader({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              _tsgdbdNavy,
              _tsgdbdTealDeep.withValues(alpha: 0.9),
              _tsgdbdTeal.withValues(alpha: 0.7),
            ],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _tsgdbdMustard,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'GESTURE BRIDGE WORKS',
                  style: TextStyle(
                    color: _tsgdbdMustardGlow,
                    letterSpacing: 3.2,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  'Flutter 3.41.6',
                  style: TextStyle(
                    color: _tsgdbdCream.withValues(alpha: 0.7),
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'TextSelectionGestureDetectorBuilderDelegate',
              style: TextStyle(
                color: _tsgdbdCream,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'A three-getter abstract contract that connects an '
              'EditableText to the Flutter selection-gesture pipeline.',
              style: TextStyle(
                color: _tsgdbdCream.withValues(alpha: 0.82),
                fontSize: 13.5,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            AspectRatio(
              aspectRatio: 16 / 7,
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext ctx, Widget? child) {
                  return CustomPaint(
                    painter: _TsgdbdBridgePainter(progress: controller.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                _TsgdbdLegendDot(
                  color: _tsgdbdTeal,
                  label: 'pier / detector',
                ),
                const SizedBox(width: 14),
                _TsgdbdLegendDot(
                  color: _tsgdbdMustard,
                  label: 'signal pulse',
                ),
                const SizedBox(width: 14),
                _TsgdbdLegendDot(
                  color: _tsgdbdCream,
                  label: 'deck / EditableText',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TsgdbdLegendDot extends StatelessWidget {
  const _TsgdbdLegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: _tsgdbdCream.withValues(alpha: 0.78),
            fontSize: 11,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// _TsgdbdBridgePainter — cable-stay bridge with travelling mustard pulses.
//
// Geometry:
//   * Two tapered teal pylons rising from the deck.
//   * A horizontal deck (cream) at the lower third of the canvas.
//   * Cables (cream-dim) fanning from the pylon tops to anchor points on
//     the deck on both sides of each pylon.
//   * Mustard pulses travelling along each cable, phase-shifted by cable
//     index so the ensemble reads as a flowing signal.
//   * Small navy ripples under the deck for water surface.
// =========================================================================
class _TsgdbdBridgePainter extends CustomPainter {
  _TsgdbdBridgePainter({required this.progress});

  final double progress;

  static const int _cablesPerSide = 6;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    _paintSky(canvas, size);
    _paintWater(canvas, size);

    final double deckY = h * 0.78;
    final double pylonLeftX = w * 0.28;
    final double pylonRightX = w * 0.72;
    final double pylonTopY = h * 0.10;
    final double pylonBaseY = deckY;

    _paintDeck(canvas, size, deckY);
    _paintPylon(canvas, pylonLeftX, pylonTopY, pylonBaseY, w);
    _paintPylon(canvas, pylonRightX, pylonTopY, pylonBaseY, w);

    _paintCableFan(
      canvas: canvas,
      pylonX: pylonLeftX,
      pylonTopY: pylonTopY,
      deckY: deckY,
      leftEdge: w * 0.06,
      rightEdge: w * 0.48,
      phaseOffset: 0.00,
    );
    _paintCableFan(
      canvas: canvas,
      pylonX: pylonRightX,
      pylonTopY: pylonTopY,
      deckY: deckY,
      leftEdge: w * 0.52,
      rightEdge: w * 0.94,
      phaseOffset: 0.33,
    );

    _paintTitleTicks(canvas, size, deckY);
  }

  void _paintSky(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          _tsgdbdNavy,
          _tsgdbdTealDeep.withValues(alpha: 0.7),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  void _paintWater(Canvas canvas, Size size) {
    final double h = size.height;
    final Paint waterPaint = Paint()
      ..color = _tsgdbdNavy.withValues(alpha: 0.8);
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.80, size.width, h * 0.20),
      waterPaint,
    );
    final Paint ripple = Paint()
      ..color = _tsgdbdTeal.withValues(alpha: 0.35)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 6; i++) {
      final double y = h * 0.82 + i * (h * 0.02);
      final Path ripplePath = Path()..moveTo(0, y);
      for (double x = 0; x <= size.width; x += 6) {
        final double phase = (progress * 2 * math.pi) + i * 0.8;
        final double dy =
            math.sin((x / size.width) * math.pi * 6 + phase) * 1.6;
        ripplePath.lineTo(x, y + dy);
      }
      canvas.drawPath(ripplePath, ripple);
    }
  }

  void _paintDeck(Canvas canvas, Size size, double deckY) {
    final Paint deckPaint = Paint()
      ..color = _tsgdbdCream.withValues(alpha: 0.92);
    final Rect deck = Rect.fromLTWH(0, deckY, size.width, 6);
    canvas.drawRect(deck, deckPaint);

    final Paint shadow = Paint()
      ..color = _tsgdbdNavy.withValues(alpha: 0.5);
    canvas.drawRect(
      Rect.fromLTWH(0, deckY + 6, size.width, 2),
      shadow,
    );

    final Paint guard = Paint()
      ..color = _tsgdbdMustard.withValues(alpha: 0.6)
      ..strokeWidth = 1.1;
    for (double x = 4; x < size.width; x += 12) {
      canvas.drawLine(
        Offset(x, deckY),
        Offset(x, deckY - 3),
        guard,
      );
    }
  }

  void _paintPylon(
    Canvas canvas,
    double x,
    double topY,
    double baseY,
    double width,
  ) {
    final Path pylon = Path()
      ..moveTo(x - 3, topY)
      ..lineTo(x + 3, topY)
      ..lineTo(x + 9, baseY)
      ..lineTo(x - 9, baseY)
      ..close();
    final Paint pylonPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          _tsgdbdTeal,
          _tsgdbdTealDeep,
        ],
      ).createShader(
        Rect.fromLTWH(x - 10, topY, 20, baseY - topY),
      );
    canvas.drawPath(pylon, pylonPaint);

    final Paint crown = Paint()..color = _tsgdbdMustardGlow;
    canvas.drawCircle(Offset(x, topY), 4.0, crown);
    canvas.drawCircle(
      Offset(x, topY),
      8.0,
      Paint()..color = _tsgdbdMustard.withValues(alpha: 0.25),
    );

    // Truss cross-braces on the pylon.
    final Paint brace = Paint()
      ..color = _tsgdbdCreamDim.withValues(alpha: 0.4)
      ..strokeWidth = 0.8;
    const int braceCount = 5;
    for (int i = 1; i <= braceCount; i++) {
      final double t = i / (braceCount + 1);
      final double braceY = topY + (baseY - topY) * t;
      final double halfWidth = 4 + (9 - 4) * t;
      canvas.drawLine(
        Offset(x - halfWidth, braceY),
        Offset(x + halfWidth, braceY),
        brace,
      );
    }
  }

  void _paintCableFan({
    required Canvas canvas,
    required double pylonX,
    required double pylonTopY,
    required double deckY,
    required double leftEdge,
    required double rightEdge,
    required double phaseOffset,
  }) {
    final Paint cablePaint = Paint()
      ..color = _tsgdbdCreamDim.withValues(alpha: 0.55)
      ..strokeWidth = 0.9;

    // Left-of-pylon cables.
    for (int i = 0; i < _cablesPerSide; i++) {
      final double t = (i + 1) / (_cablesPerSide + 1);
      final double anchorX = pylonX - (pylonX - leftEdge) * t;
      final Offset start = Offset(pylonX, pylonTopY + 2);
      final Offset end = Offset(anchorX, deckY - 1);
      canvas.drawLine(start, end, cablePaint);
      _paintPulseOnCable(
        canvas: canvas,
        start: start,
        end: end,
        phase: phaseOffset + i * 0.09,
      );
    }
    // Right-of-pylon cables.
    for (int i = 0; i < _cablesPerSide; i++) {
      final double t = (i + 1) / (_cablesPerSide + 1);
      final double anchorX = pylonX + (rightEdge - pylonX) * t;
      final Offset start = Offset(pylonX, pylonTopY + 2);
      final Offset end = Offset(anchorX, deckY - 1);
      canvas.drawLine(start, end, cablePaint);
      _paintPulseOnCable(
        canvas: canvas,
        start: start,
        end: end,
        phase: phaseOffset + 0.5 + i * 0.09,
      );
    }
  }

  void _paintPulseOnCable({
    required Canvas canvas,
    required Offset start,
    required Offset end,
    required double phase,
  }) {
    final double effective = (progress + phase) % 1.0;
    final Offset position = Offset.lerp(start, end, effective)!;
    final double glowRadius = 3.5 + 1.5 * math.sin(effective * math.pi);
    final Paint glow = Paint()
      ..color = _tsgdbdMustard.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.2);
    canvas.drawCircle(position, glowRadius + 2.0, glow);
    final Paint core = Paint()..color = _tsgdbdMustardGlow;
    canvas.drawCircle(position, glowRadius, core);
  }

  void _paintTitleTicks(Canvas canvas, Size size, double deckY) {
    final Paint tick = Paint()
      ..color = _tsgdbdCream.withValues(alpha: 0.4)
      ..strokeWidth = 0.6;
    const int tickCount = 24;
    for (int i = 0; i < tickCount; i++) {
      final double t = i / (tickCount - 1);
      final double x = size.width * 0.04 + size.width * 0.92 * t;
      final bool tall = i % 4 == 0;
      canvas.drawLine(
        Offset(x, deckY + 8),
        Offset(x, deckY + (tall ? 14 : 11)),
        tick,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TsgdbdBridgePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// =========================================================================
// _TsgdbdBridgeDelegate — concrete implementation of the Flutter interface.
//
// This class carries the full weight of the demo: it is the only type that
// actually implements `TextSelectionGestureDetectorBuilderDelegate`. All
// three getters are satisfied by final fields set in the constructor.
//
// In real widgets, this role is usually played by the State of a
// StatefulWidget wrapping the EditableText. Doing it as a standalone
// class here makes the three-member contract very easy to read.
// =========================================================================
class _TsgdbdBridgeDelegate implements TextSelectionGestureDetectorBuilderDelegate {
  _TsgdbdBridgeDelegate({
    required this.editableTextKey,
    required this.forcePressEnabled,
    required this.selectionEnabled,
  });

  @override
  final GlobalKey<EditableTextState> editableTextKey;

  @override
  final bool forcePressEnabled;

  @override
  final bool selectionEnabled;

  @override
  String toString() {
    return '_TsgdbdBridgeDelegate('
        'key: ${editableTextKey.hashCode.toRadixString(16)}, '
        'forcePress: $forcePressEnabled, '
        'selection: $selectionEnabled)';
  }
}

// =========================================================================
// _TsgdbdStage — the primary integration showcase.
//
// Each stage owns:
//   * a GlobalKey<EditableTextState>                 (required by delegate)
//   * a TextEditingController + FocusNode            (EditableText needs them)
//   * a concrete _TsgdbdBridgeDelegate instance
//   * a TextSelectionGestureDetectorBuilder wrapping that delegate
//   * a live action log populated from onChanged/onSelectionChanged events
//
// The EditableText is wrapped by the builder's buildGestureDetector() so
// that every gesture recognised by the TextSelectionGestureDetector is
// routed through the delegate-aware pipeline.
// =========================================================================
class _TsgdbdStage extends StatefulWidget {
  const _TsgdbdStage({
    required this.title,
    required this.selectionEnabled,
    required this.forcePressEnabled,
    required this.accent,
  });

  final String title;
  final bool selectionEnabled;
  final bool forcePressEnabled;
  final Color accent;

  @override
  State<_TsgdbdStage> createState() => _TsgdbdStageState();
}

class _TsgdbdStageState extends State<_TsgdbdStage> {
  // The key required by the delegate. Identifies one EditableTextState.
  final GlobalKey<EditableTextState> _editableKey =
      GlobalKey<EditableTextState>(debugLabel: 'tsgdbd-stage-a');
  final TextEditingController _controller = TextEditingController(
    text: 'Signals travel along the cables from detector to delegate.',
  );
  final FocusNode _focusNode = FocusNode(debugLabel: 'tsgdbd-stage-a-focus');

  late final _TsgdbdBridgeDelegate _delegate;
  late final TextSelectionGestureDetectorBuilder _builder;

  final List<_TsgdbdLogEntry> _log = <_TsgdbdLogEntry>[];
  static const int _logLimit = 12;

  @override
  void initState() {
    super.initState();
    debugPrint('[Tsgdbd] _TsgdbdStageState.initState (${widget.title})');
    _delegate = _TsgdbdBridgeDelegate(
      editableTextKey: _editableKey,
      forcePressEnabled: widget.forcePressEnabled,
      selectionEnabled: widget.selectionEnabled,
    );
    _builder = TextSelectionGestureDetectorBuilder(delegate: _delegate);
    _controller.addListener(_onControllerTick);
    _focusNode.addListener(_onFocusTick);
    _appendLog('stage constructed', _TsgdbdLogKind.lifecycle);
  }

  @override
  void dispose() {
    debugPrint('[Tsgdbd] _TsgdbdStageState.dispose (${widget.title})');
    _controller.removeListener(_onControllerTick);
    _focusNode.removeListener(_onFocusTick);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onControllerTick() {
    final TextSelection sel = _controller.selection;
    if (!sel.isValid) {
      return;
    }
    if (sel.isCollapsed) {
      _appendLog(
        'caret at offset ${sel.baseOffset}',
        _TsgdbdLogKind.caret,
      );
    } else {
      _appendLog(
        'selection [${sel.start}..${sel.end}]',
        _TsgdbdLogKind.selection,
      );
    }
  }

  void _onFocusTick() {
    _appendLog(
      _focusNode.hasFocus ? 'focus acquired' : 'focus released',
      _TsgdbdLogKind.focus,
    );
  }

  void _onChanged(String value) {
    _appendLog(
      'onChanged — length=${value.length}',
      _TsgdbdLogKind.edit,
    );
  }

  void _onSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    _appendLog(
      'onSelectionChanged — cause=${cause ?? "unknown"}, '
      'range=[${selection.start}..${selection.end}]',
      _TsgdbdLogKind.selection,
    );
  }

  void _appendLog(String message, _TsgdbdLogKind kind) {
    if (!mounted) {
      return;
    }
    setState(() {
      _log.insert(
        0,
        _TsgdbdLogEntry(
          timestamp: DateTime.now(),
          message: message,
          kind: kind,
        ),
      );
      if (_log.length > _logLimit) {
        _log.removeRange(_logLimit, _log.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget editable = EditableText(
      key: _editableKey,
      controller: _controller,
      focusNode: _focusNode,
      style: const TextStyle(
        color: _tsgdbdCream,
        fontSize: 15,
        height: 1.35,
      ),
      cursorColor: _tsgdbdMustard,
      backgroundCursorColor: _tsgdbdCream,
      maxLines: 3,
      minLines: 2,
      selectionColor: widget.accent.withValues(alpha: 0.35),
      enableInteractiveSelection: widget.selectionEnabled,
      onChanged: _onChanged,
      onSelectionChanged: _onSelectionChanged,
      selectionControls: materialTextSelectionControls,
    );

    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdSlate.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: widget.accent.withValues(alpha: 0.55)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: widget.accent,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: widget.accent.withValues(alpha: 0.6),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: _tsgdbdCream,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _tsgdbdNavy.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _tsgdbdCream.withValues(alpha: 0.15),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: _builder.buildGestureDetector(
              behavior: HitTestBehavior.translucent,
              child: editable,
            ),
          ),
          const SizedBox(height: 14),
          _TsgdbdDelegatePropertyRow(delegate: _delegate, accent: widget.accent),
          const SizedBox(height: 14),
          _TsgdbdLogPanel(entries: _log, accent: widget.accent),
          const SizedBox(height: 10),
          _TsgdbdStageFooter(
            delegate: _delegate,
            controller: _controller,
            focusNode: _focusNode,
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// _TsgdbdDelegatePropertyRow — live readout of the three interface getters.
// =========================================================================
class _TsgdbdDelegatePropertyRow extends StatelessWidget {
  const _TsgdbdDelegatePropertyRow({
    required this.delegate,
    required this.accent,
  });

  final _TsgdbdBridgeDelegate delegate;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _TsgdbdPropertyTile(
            label: 'editableTextKey',
            value: '#${delegate.editableTextKey.hashCode.toRadixString(16)}',
            accent: accent,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TsgdbdPropertyTile(
            label: 'forcePressEnabled',
            value: delegate.forcePressEnabled ? 'true' : 'false',
            accent: accent,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TsgdbdPropertyTile(
            label: 'selectionEnabled',
            value: delegate.selectionEnabled ? 'true' : 'false',
            accent: accent,
          ),
        ),
      ],
    );
  }
}

class _TsgdbdPropertyTile extends StatelessWidget {
  const _TsgdbdPropertyTile({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdNavy.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.65),
              fontSize: 10,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// _TsgdbdLogEntry + _TsgdbdLogPanel — live action log.
// =========================================================================
enum _TsgdbdLogKind {
  lifecycle,
  focus,
  caret,
  selection,
  edit,
}

class _TsgdbdLogEntry {
  _TsgdbdLogEntry({
    required this.timestamp,
    required this.message,
    required this.kind,
  });

  final DateTime timestamp;
  final String message;
  final _TsgdbdLogKind kind;

  Color get color {
    switch (kind) {
      case _TsgdbdLogKind.lifecycle:
        return _tsgdbdCream;
      case _TsgdbdLogKind.focus:
        return _tsgdbdMustardGlow;
      case _TsgdbdLogKind.caret:
        return _tsgdbdTeal;
      case _TsgdbdLogKind.selection:
        return _tsgdbdMustard;
      case _TsgdbdLogKind.edit:
        return _tsgdbdCreamDim;
    }
  }

  String get label {
    switch (kind) {
      case _TsgdbdLogKind.lifecycle:
        return 'LIFE';
      case _TsgdbdLogKind.focus:
        return 'FOCUS';
      case _TsgdbdLogKind.caret:
        return 'CARET';
      case _TsgdbdLogKind.selection:
        return 'SEL';
      case _TsgdbdLogKind.edit:
        return 'EDIT';
    }
  }
}

class _TsgdbdLogPanel extends StatelessWidget {
  const _TsgdbdLogPanel({required this.entries, required this.accent});

  final List<_TsgdbdLogEntry> entries;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdNavy.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.list_alt, size: 14, color: accent),
              const SizedBox(width: 6),
              Text(
                'ACTION LOG — last ${entries.length}',
                style: TextStyle(
                  color: _tsgdbdCream.withValues(alpha: 0.75),
                  fontSize: 11,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'no gestures captured yet — tap, double-tap or long-press the text above',
                style: TextStyle(
                  color: _tsgdbdCream.withValues(alpha: 0.5),
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            )
          else
            for (final _TsgdbdLogEntry entry in entries)
              _TsgdbdLogRow(entry: entry),
        ],
      ),
    );
  }
}

class _TsgdbdLogRow extends StatelessWidget {
  const _TsgdbdLogRow({required this.entry});

  final _TsgdbdLogEntry entry;

  String _formatTime(DateTime dt) {
    final String hh = dt.hour.toString().padLeft(2, '0');
    final String mm = dt.minute.toString().padLeft(2, '0');
    final String ss = dt.second.toString().padLeft(2, '0');
    final String ms = (dt.millisecond ~/ 10).toString().padLeft(2, '0');
    return '$hh:$mm:$ss.$ms';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _formatTime(entry.timestamp),
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.55),
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: entry.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: entry.color.withValues(alpha: 0.5),
                width: 0.6,
              ),
            ),
            child: Text(
              entry.label,
              style: TextStyle(
                color: entry.color,
                fontFamily: 'monospace',
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              entry.message,
              style: TextStyle(
                color: _tsgdbdCream.withValues(alpha: 0.88),
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// _TsgdbdStageFooter — toolbar showing colour channels of the accent.
//
// Uses `.r/.g/.b/.a` on Color as requested.
// =========================================================================
class _TsgdbdStageFooter extends StatelessWidget {
  const _TsgdbdStageFooter({
    required this.delegate,
    required this.controller,
    required this.focusNode,
  });

  final _TsgdbdBridgeDelegate delegate;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    const Color channelAccent = _tsgdbdMustard;
    final String rStr = channelAccent.r.toStringAsFixed(2);
    final String gStr = channelAccent.g.toStringAsFixed(2);
    final String bStr = channelAccent.b.toStringAsFixed(2);
    final String aStr = channelAccent.a.toStringAsFixed(2);
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdNavy.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: <Widget>[
          Text(
            'accent channels — r=$rStr g=$gStr b=$bStr a=$aStr',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.55),
              fontFamily: 'monospace',
              fontSize: 10.5,
            ),
          ),
          const Spacer(),
          Text(
            focusNode.hasFocus ? 'focused' : 'blur',
            style: TextStyle(
              color: focusNode.hasFocus
                  ? _tsgdbdMustardGlow
                  : _tsgdbdCream.withValues(alpha: 0.5),
              fontSize: 10.5,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'chars=${controller.text.length}',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.6),
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// _TsgdbdSuppressedStage — companion demo with selection suppressed.
// =========================================================================
class _TsgdbdSuppressedStage extends StatelessWidget {
  const _TsgdbdSuppressedStage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _TsgdbdStage(
          title: 'Bridge B — selection OFF, force press ON',
          selectionEnabled: false,
          forcePressEnabled: true,
          accent: _tsgdbdTeal,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _tsgdbdTealDeep.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _tsgdbdTeal.withValues(alpha: 0.6)),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.info_outline,
                  color: _tsgdbdMustardGlow, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'With selectionEnabled=false the builder avoids wiring the '
                  'selection-affecting handlers (onSingleLongTapStart, '
                  'onDragSelectionStart, …). The EditableText above still '
                  'accepts keyboard input but no visible selection will '
                  'appear from long-press gestures. forcePressEnabled=true '
                  'additionally attaches onForcePressStart/End on supported '
                  'hardware (iOS 3D-touch).',
                  style: TextStyle(
                    color: _tsgdbdCream.withValues(alpha: 0.85),
                    fontSize: 12.5,
                    height: 1.35,
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

// =========================================================================
// _TsgdbdIntroCard — orientation for the reader.
// =========================================================================
class _TsgdbdIntroCard extends StatelessWidget {
  const _TsgdbdIntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdSlate.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _tsgdbdCream.withValues(alpha: 0.18)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _tsgdbdMustard.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.architecture,
                  color: _tsgdbdMustardGlow,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Why this interface matters',
                  style: TextStyle(
                    color: _tsgdbdCream,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Custom text-editing widgets — TextField alternatives, code '
            'editors, inline rich inputs — all need to plug into the '
            'standard iOS/Material selection-gesture pipeline without '
            'rewriting it. The pipeline expects a delegate that answers '
            'three questions: which EditableText are you targeting, do you '
            'want force-press handling, and do you want selection at all.',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.82),
              fontSize: 13.2,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Satisfy those three questions and the builder handles taps, '
            'double-taps, long-presses, drag selections, context menus and '
            'magnifier invocation on your behalf — cross-platform.',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.7),
              fontSize: 12.5,
              height: 1.45,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// _TsgdbdSectionHeading — consistent section header with ordinal.
// =========================================================================
class _TsgdbdSectionHeading extends StatelessWidget {
  const _TsgdbdSectionHeading({
    required this.ordinal,
    required this.title,
    required this.subtitle,
  });

  final String ordinal;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _tsgdbdMustard.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _tsgdbdMustard.withValues(alpha: 0.55)),
          ),
          alignment: Alignment.center,
          child: Text(
            ordinal,
            style: const TextStyle(
              color: _tsgdbdMustardGlow,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _tsgdbdCream,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: _tsgdbdCream.withValues(alpha: 0.65),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// _TsgdbdApiCard — quoted interface and constructor signatures.
// =========================================================================
class _TsgdbdApiCard extends StatelessWidget {
  const _TsgdbdApiCard();

  static const String _interfaceSource = '''abstract class TextSelectionGestureDetectorBuilderDelegate {
  /// [GlobalKey] to the [EditableText] for which the
  /// [TextSelectionGestureDetectorBuilder] will build a
  /// [TextSelectionGestureDetector].
  GlobalKey<EditableTextState> get editableTextKey;

  /// Whether the text field should respond to force presses.
  bool get forcePressEnabled;

  /// Whether the user may select text in the text field.
  bool get selectionEnabled;
}''';

  static const String _builderSignature =
      '''class TextSelectionGestureDetectorBuilder {
  TextSelectionGestureDetectorBuilder({required this.delegate});

  @protected
  final TextSelectionGestureDetectorBuilderDelegate delegate;

  Widget buildGestureDetector({
    Key? key,
    HitTestBehavior? behavior,
    required Widget child,
  });
}''';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdNavy.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _tsgdbdMustard.withValues(alpha: 0.45)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.code, color: _tsgdbdMustardGlow, size: 16),
              const SizedBox(width: 8),
              Text(
                'API — as seen in text_selection.dart',
                style: TextStyle(
                  color: _tsgdbdMustardGlow,
                  fontSize: 12,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _TsgdbdCodeBlock(source: _interfaceSource),
          const SizedBox(height: 12),
          _TsgdbdCodeBlock(source: _builderSignature),
          const SizedBox(height: 10),
          Text(
            'The builder only needs this three-getter slice of the owning '
            'widget\'s state. Any class — State, plain Dart object, '
            'InheritedModel proxy — that can answer all three questions '
            'is a valid delegate.',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.75),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TsgdbdCodeBlock extends StatelessWidget {
  const _TsgdbdCodeBlock({required this.source});

  final String source;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF081623),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tsgdbdTeal.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(12),
      child: SelectableText(
        source,
        style: const TextStyle(
          color: _tsgdbdCream,
          fontSize: 12,
          fontFamily: 'monospace',
          height: 1.45,
        ),
      ),
    );
  }
}

// =========================================================================
// _TsgdbdSignalFlowCard + _TsgdbdSignalFlowPainter — labelled diagram.
// =========================================================================
class _TsgdbdSignalFlowCard extends StatelessWidget {
  const _TsgdbdSignalFlowCard({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdTealDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _tsgdbdTeal.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Signal flow from finger to EditableTextState',
            style: TextStyle(
              color: _tsgdbdMustardGlow,
              fontSize: 12.5,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 16 / 8,
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext ctx, Widget? child) {
                return CustomPaint(
                  painter:
                      _TsgdbdSignalFlowPainter(progress: controller.value),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Arrows illustrate the hand-off chain. Each hop consumes a bit '
            'of context and emits a more semantic message to the next — '
            'from raw pointer events to "select word at offset 42".',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.75),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TsgdbdSignalFlowPainter extends CustomPainter {
  _TsgdbdSignalFlowPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double nodeW = w * 0.20;
    final double nodeH = h * 0.48;
    final double midY = h * 0.50;
    final List<_TsgdbdFlowNode> nodes = <_TsgdbdFlowNode>[
      _TsgdbdFlowNode(
        center: Offset(w * 0.12, midY),
        title: 'Gesture',
        subtitle: 'finger / mouse',
        color: _tsgdbdMustard,
      ),
      _TsgdbdFlowNode(
        center: Offset(w * 0.37, midY),
        title: 'Detector',
        subtitle: 'TextSelectionGestureDetector',
        color: _tsgdbdCream,
      ),
      _TsgdbdFlowNode(
        center: Offset(w * 0.63, midY),
        title: 'Delegate',
        subtitle: 'TextSelectionGestureDetectorBuilderDelegate',
        color: _tsgdbdTeal,
      ),
      _TsgdbdFlowNode(
        center: Offset(w * 0.88, midY),
        title: 'EditableTextState',
        subtitle: 'via editableTextKey.currentState',
        color: _tsgdbdMustardGlow,
      ),
    ];

    for (final _TsgdbdFlowNode node in nodes) {
      _paintNode(canvas, node, nodeW, nodeH);
    }

    for (int i = 0; i < nodes.length - 1; i++) {
      _paintArrow(
        canvas: canvas,
        from: nodes[i].center + Offset(nodeW * 0.5, 0),
        to: nodes[i + 1].center - Offset(nodeW * 0.5, 0),
        label: _arrowLabel(i),
        phase: i * 0.25,
      );
    }
  }

  String _arrowLabel(int i) {
    switch (i) {
      case 0:
        return 'raw pointer';
      case 1:
        return 'delegate?';
      case 2:
        return 'currentState';
      default:
        return '';
    }
  }

  void _paintNode(Canvas canvas, _TsgdbdFlowNode node, double w, double h) {
    final Rect rect = Rect.fromCenter(
      center: node.center,
      width: w,
      height: h,
    );
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    final Paint fill = Paint()..color = node.color.withValues(alpha: 0.2);
    final Paint border = Paint()
      ..color = node.color.withValues(alpha: 0.85)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rrect, fill);
    canvas.drawRRect(rrect, border);

    final TextPainter titleTp = TextPainter(
      text: TextSpan(
        text: node.title,
        style: TextStyle(
          color: node.color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: w - 6);
    titleTp.paint(
      canvas,
      Offset(node.center.dx - titleTp.width / 2,
          node.center.dy - titleTp.height - 1),
    );

    final TextPainter subTp = TextPainter(
      text: TextSpan(
        text: node.subtitle,
        style: TextStyle(
          color: _tsgdbdCream.withValues(alpha: 0.72),
          fontSize: 8.5,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: w - 6);
    subTp.paint(
      canvas,
      Offset(node.center.dx - subTp.width / 2,
          node.center.dy + 2),
    );
  }

  void _paintArrow({
    required Canvas canvas,
    required Offset from,
    required Offset to,
    required String label,
    required double phase,
  }) {
    final Paint line = Paint()
      ..color = _tsgdbdMustard.withValues(alpha: 0.7)
      ..strokeWidth = 1.2;
    canvas.drawLine(from, to, line);

    // Arrow head.
    final double angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const double headLen = 7;
    final Offset headLeft = to +
        Offset(
          -headLen * math.cos(angle - math.pi / 7),
          -headLen * math.sin(angle - math.pi / 7),
        );
    final Offset headRight = to +
        Offset(
          -headLen * math.cos(angle + math.pi / 7),
          -headLen * math.sin(angle + math.pi / 7),
        );
    final Path head = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(headLeft.dx, headLeft.dy)
      ..lineTo(headRight.dx, headRight.dy)
      ..close();
    canvas.drawPath(head, Paint()..color = _tsgdbdMustardGlow);

    // Pulse travelling along the arrow.
    final double t = (progress + phase) % 1.0;
    final Offset pulsePos = Offset.lerp(from, to, t)!;
    canvas.drawCircle(
      pulsePos,
      3.6,
      Paint()..color = _tsgdbdMustardGlow,
    );
    canvas.drawCircle(
      pulsePos,
      6.5,
      Paint()
        ..color = _tsgdbdMustard.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5),
    );

    // Label above arrow.
    final TextPainter labelTp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: _tsgdbdCream.withValues(alpha: 0.8),
          fontSize: 9.5,
          fontFamily: 'monospace',
          letterSpacing: 0.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final Offset labelPos = Offset(
      (from.dx + to.dx) / 2 - labelTp.width / 2,
      (from.dy + to.dy) / 2 - labelTp.height - 6,
    );
    labelTp.paint(canvas, labelPos);
  }

  @override
  bool shouldRepaint(covariant _TsgdbdSignalFlowPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _TsgdbdFlowNode {
  _TsgdbdFlowNode({
    required this.center,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final Offset center;
  final String title;
  final String subtitle;
  final Color color;
}

// =========================================================================
// _TsgdbdMethodDirectory — DataTable of the three delegate properties plus
// the principal builder callbacks gated by them.
// =========================================================================
class _TsgdbdMethodDirectory extends StatelessWidget {
  const _TsgdbdMethodDirectory();

  static const List<_TsgdbdDirectoryRow> _rows = <_TsgdbdDirectoryRow>[
    _TsgdbdDirectoryRow(
      member: 'editableTextKey',
      kind: 'getter',
      returns: 'GlobalKey<EditableTextState>',
      role: 'Locate the EditableTextState to dispatch selection ops to.',
    ),
    _TsgdbdDirectoryRow(
      member: 'forcePressEnabled',
      kind: 'getter',
      returns: 'bool',
      role:
          'Gates onForcePressStart and onForcePressEnd in buildGestureDetector.',
    ),
    _TsgdbdDirectoryRow(
      member: 'selectionEnabled',
      kind: 'getter',
      returns: 'bool',
      role:
          'Gates selection-affecting callbacks (long-press, drag-select, …).',
    ),
    _TsgdbdDirectoryRow(
      member: 'onSingleTapUp',
      kind: 'builder callback',
      returns: 'TapDragUpCallback?',
      role: 'Position caret at tap location; defer keyboard show.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onDoubleTapDown',
      kind: 'builder callback',
      returns: 'TapDragDownCallback?',
      role: 'Select the word at the double-tap location.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onTripleTapDown',
      kind: 'builder callback',
      returns: 'TapDragDownCallback?',
      role: 'Select the entire line at the triple-tap location.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onSingleLongTapStart',
      kind: 'builder callback',
      returns: 'GestureLongPressStartCallback?',
      role: 'Begin long-press selection; show magnifier on mobile.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onSingleLongTapMoveUpdate',
      kind: 'builder callback',
      returns: 'GestureLongPressMoveUpdateCallback?',
      role: 'Extend selection while the long-press drags.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onSingleLongTapEnd',
      kind: 'builder callback',
      returns: 'GestureLongPressEndCallback?',
      role: 'Finalise long-press selection; hide magnifier.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onForcePressStart',
      kind: 'builder callback',
      returns: 'GestureForcePressStartCallback?',
      role: 'Only wired when delegate.forcePressEnabled is true.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onForcePressEnd',
      kind: 'builder callback',
      returns: 'GestureForcePressEndCallback?',
      role: 'Only wired when delegate.forcePressEnabled is true.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onDragSelectionStart',
      kind: 'builder callback',
      returns: 'GestureTapDragStartCallback?',
      role: 'Begin drag-extend selection.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onDragSelectionUpdate',
      kind: 'builder callback',
      returns: 'GestureTapDragUpdateCallback?',
      role: 'Continue drag-extend selection.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onDragSelectionEnd',
      kind: 'builder callback',
      returns: 'GestureTapDragEndCallback?',
      role: 'Finalise drag-extend selection.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onSecondaryTap',
      kind: 'builder callback',
      returns: 'GestureTapCallback?',
      role: 'Trigger secondary action — usually context menu.',
    ),
    _TsgdbdDirectoryRow(
      member: 'onSecondaryTapDown',
      kind: 'builder callback',
      returns: 'GestureTapDownCallback?',
      role: 'Capture secondary-button press location for menu placement.',
    ),
    _TsgdbdDirectoryRow(
      member: 'buildGestureDetector',
      kind: 'builder method',
      returns: 'Widget',
      role: 'Wrap an EditableText child with a TextSelectionGestureDetector.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdSlate.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _tsgdbdCream.withValues(alpha: 0.18)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.view_list, color: _tsgdbdMustardGlow, size: 16),
              const SizedBox(width: 8),
              Text(
                'DIRECTORY — delegate properties + gated callbacks',
                style: TextStyle(
                  color: _tsgdbdMustardGlow,
                  fontSize: 11.5,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 18,
              headingRowColor: WidgetStateProperty.all(
                _tsgdbdNavy.withValues(alpha: 0.7),
              ),
              dataRowColor: WidgetStateProperty.resolveWith(
                (Set<WidgetState> states) {
                  return _tsgdbdNavy.withValues(alpha: 0.25);
                },
              ),
              headingTextStyle: const TextStyle(
                color: _tsgdbdMustardGlow,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
                letterSpacing: 0.6,
              ),
              dataTextStyle: TextStyle(
                color: _tsgdbdCream.withValues(alpha: 0.88),
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
              columns: const <DataColumn>[
                DataColumn(label: Text('MEMBER')),
                DataColumn(label: Text('KIND')),
                DataColumn(label: Text('RETURNS')),
                DataColumn(label: Text('ROLE')),
              ],
              rows: <DataRow>[
                for (final _TsgdbdDirectoryRow r in _rows)
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(
                          r.member,
                          style: const TextStyle(
                            color: _tsgdbdMustard,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      DataCell(Text(r.kind)),
                      DataCell(
                        Text(
                          r.returns,
                          style: TextStyle(
                            color: _tsgdbdTeal,
                            fontFamily: 'monospace',
                            // force tint via Color channels (.r/.g/.b/.a used)
                            backgroundColor: Color.fromARGB(
                              ((_tsgdbdTeal.a) * 40).round().clamp(0, 255),
                              (_tsgdbdTeal.r * 255).round().clamp(0, 255),
                              (_tsgdbdTeal.g * 255).round().clamp(0, 255),
                              (_tsgdbdTeal.b * 255).round().clamp(0, 255),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 340),
                          child: Text(
                            r.role,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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

class _TsgdbdDirectoryRow {
  const _TsgdbdDirectoryRow({
    required this.member,
    required this.kind,
    required this.returns,
    required this.role,
  });

  final String member;
  final String kind;
  final String returns;
  final String role;
}

// =========================================================================
// _TsgdbdPitfallCard — the shared-key anti-pattern.
// =========================================================================
class _TsgdbdPitfallCard extends StatelessWidget {
  const _TsgdbdPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF4A1A1A).withValues(alpha: 0.55),
            _tsgdbdNavy.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _tsgdbdMustard.withValues(alpha: 0.7)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _tsgdbdMustard.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: _tsgdbdMustardGlow,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Pitfall — do not share the same editableTextKey',
                  style: TextStyle(
                    color: _tsgdbdMustardGlow,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'TextSelectionGestureDetectorBuilder assumes editableTextKey '
            'uniquely identifies one EditableTextState. If two delegates '
            'return the same GlobalKey, only one EditableText can be '
            'mounted at a time — the second mount throws a duplicate-key '
            'error — and even if you arrange them sequentially, gestures '
            'directed at one delegate will be routed to the first '
            'EditableText that happens to be present in the tree.',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.85),
              fontSize: 12.8,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Rule: one delegate instance owns one GlobalKey<EditableTextState>. '
            'Create the key inside the widget that owns the delegate, not as '
            'a shared top-level constant.',
            style: TextStyle(
              color: _tsgdbdCream.withValues(alpha: 0.7),
              fontSize: 12,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          _TsgdbdCodeBlock(
            source:
                '// GOOD — one key per delegate\nfinal key = GlobalKey<EditableTextState>();\nfinal delegate = _TsgdbdBridgeDelegate(\n  editableTextKey: key,\n  forcePressEnabled: false,\n  selectionEnabled: true,\n);\n\n// BAD — sharing across two delegates\nfinal shared = GlobalKey<EditableTextState>();\nfinal d1 = _TsgdbdBridgeDelegate(editableTextKey: shared, /*...*/);\nfinal d2 = _TsgdbdBridgeDelegate(editableTextKey: shared, /*...*/);',
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// _TsgdbdFooter — closing band.
// =========================================================================
class _TsgdbdFooter extends StatelessWidget {
  const _TsgdbdFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tsgdbdTealDeep.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _tsgdbdMustard.withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          const Icon(Icons.all_inclusive,
              color: _tsgdbdMustardGlow, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Gesture Bridge Works — delegate + builder + EditableText. '
              'A minimal interface that carries a surprising amount of '
              'load-bearing behaviour.',
              style: TextStyle(
                color: _tsgdbdCream.withValues(alpha: 0.85),
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// End of file.
// =========================================================================
