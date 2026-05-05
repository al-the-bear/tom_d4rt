// D4rt deep-demo: a hand-authored visual exploration of the Alignment value
// class from package:flutter/painting.dart.
//
// This file is intentionally complementary to the existing widgets/align_test
// demo. Where align_test.dart focuses on the Align *widget*, this one drills
// into Alignment as a value class: its coordinate space, named constants,
// arithmetic operators (+, -, *, /, ~/, %, unary -), helpers like inscribe,
// withinRect, alongOffset, alongSize, the static lerp, AlignmentDirectional
// resolution, and out-of-unit-square use cases.
//
// The script is intended to be sent over the AST/HTTP bridge, evaluated by
// the d4rt interpreter, and rendered inside the test host application. It
// avoids any imperative concurrency primitives (no Future/Timer/await), no
// stateful widgets, no animation controllers, and no print statements. The
// build() function returns a Scaffold whose body is a SingleChildScrollView
// with a long, sectioned column showcasing every facet of Alignment.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette: a deliberately distinct lime/emerald scheme to set this demo apart
// from the deep-blue/cyan palette used by widgets/align_test.dart.
// ---------------------------------------------------------------------------

const Color kBgPage = Color(0xFFF4FBF1);
const Color kBgPanel = Color(0xFFFFFFFF);
const Color kBgPanelAlt = Color(0xFFEBF5E5);
const Color kBgFrame = Color(0xFFD8ECCD);
const Color kBgInk = Color(0xFF14241B);
const Color kInkPrimary = Color(0xFF1F3A29);
const Color kInkSecondary = Color(0xFF345A41);
const Color kInkMuted = Color(0xFF607F6C);
const Color kAccentLime = Color(0xFF8BC640);
const Color kAccentLimeDeep = Color(0xFF6BA12C);
const Color kAccentEmerald = Color(0xFF1FA86E);
const Color kAccentEmeraldDeep = Color(0xFF137A4D);
const Color kAccentTeal = Color(0xFF2DA89E);
const Color kAccentMint = Color(0xFF7FD7B0);
const Color kAccentSpring = Color(0xFFB6E26E);
const Color kAccentForest = Color(0xFF274F2E);
const Color kAccentAmber = Color(0xFFD4A028);
const Color kAccentRose = Color(0xFFD2548A);
const Color kAccentClay = Color(0xFFB0613B);
const Color kBorderSoft = Color(0xFFCFE3C2);
const Color kBorderStrong = Color(0xFF9DBE8E);

// ---------------------------------------------------------------------------
// Tiny value classes used by the various sections. All fields are final and
// constructors are const so the entire tree can be built with const literals
// where reasonable.
// ---------------------------------------------------------------------------

class ConstantSample {
  final String label;
  final Alignment value;
  final Color tint;
  const ConstantSample(this.label, this.value, this.tint);
}

class OperatorSample {
  final String title;
  final String expression;
  final Alignment lhs;
  final Alignment rhs;
  final Alignment result;
  final Color tint;
  final String note;
  const OperatorSample(
    this.title,
    this.expression,
    this.lhs,
    this.rhs,
    this.result,
    this.tint,
    this.note,
  );
}

class InscribeSample {
  final String label;
  final Alignment alignment;
  final Size childSize;
  final Rect parent;
  final Color tint;
  const InscribeSample(
    this.label,
    this.alignment,
    this.childSize,
    this.parent,
    this.tint,
  );
}

class AlongSample {
  final String label;
  final Alignment alignment;
  final String kind; // 'offset' or 'size'
  final Offset reference; // Offset or Size flattened to width/height
  final Color tint;
  const AlongSample(
    this.label,
    this.alignment,
    this.kind,
    this.reference,
    this.tint,
  );
}

class LerpFrame {
  final String label;
  final double t;
  final Alignment a;
  final Alignment b;
  final Color tint;
  const LerpFrame(this.label, this.t, this.a, this.b, this.tint);
}

class DirectionalSample {
  final String label;
  final AlignmentDirectional value;
  final Color tint;
  const DirectionalSample(this.label, this.value, this.tint);
}

class OutsideSample {
  final String label;
  final Alignment alignment;
  final String narrative;
  final Color tint;
  const OutsideSample(
    this.label,
    this.alignment,
    this.narrative,
    this.tint,
  );
}

class UseCaseCard {
  final String title;
  final String summary;
  final List<String> snippet;
  final Color tint;
  const UseCaseCard(this.title, this.summary, this.snippet, this.tint);
}

class CaveatCard {
  final String title;
  final String body;
  final Color tint;
  const CaveatCard(this.title, this.body, this.tint);
}

// ---------------------------------------------------------------------------
// Sample data tables. These are split out so each section's intent is easy
// to scan and so the build() function can stay declarative.
// ---------------------------------------------------------------------------

const List<ConstantSample> kConstantSamples = <ConstantSample>[
  ConstantSample('topLeft', Alignment.topLeft, kAccentLime),
  ConstantSample('topCenter', Alignment.topCenter, kAccentLimeDeep),
  ConstantSample('topRight', Alignment.topRight, kAccentEmerald),
  ConstantSample('centerLeft', Alignment.centerLeft, kAccentEmeraldDeep),
  ConstantSample('center', Alignment.center, kAccentTeal),
  ConstantSample('centerRight', Alignment.centerRight, kAccentMint),
  ConstantSample('bottomLeft', Alignment.bottomLeft, kAccentSpring),
  ConstantSample('bottomCenter', Alignment.bottomCenter, kAccentForest),
  ConstantSample('bottomRight', Alignment.bottomRight, kAccentAmber),
];

const List<OperatorSample> kOperatorSamples = <OperatorSample>[
  OperatorSample(
    'addition',
    'topLeft + bottomRight',
    Alignment.topLeft,
    Alignment.bottomRight,
    Alignment(0.0, 0.0),
    kAccentLime,
    '(-1,-1) + (1,1) cancels to the geometric center.',
  ),
  OperatorSample(
    'scaling',
    'topRight * 0.5',
    Alignment.topRight,
    Alignment(0.5, 0.5),
    Alignment(0.5, -0.5),
    kAccentEmerald,
    'Scalar multiplication shrinks the offset toward (0,0).',
  ),
  OperatorSample(
    'unary minus',
    '-Alignment(0.7, 0.4)',
    Alignment(0.7, 0.4),
    Alignment(-0.7, -0.4),
    Alignment(-0.7, -0.4),
    kAccentTeal,
    'Negation reflects through the center.',
  ),
  OperatorSample(
    'division',
    'Alignment(1, 1) / 2',
    Alignment(1.0, 1.0),
    Alignment(2.0, 2.0),
    Alignment(0.5, 0.5),
    kAccentMint,
    'Componentwise division by a scalar.',
  ),
  OperatorSample(
    'translation',
    'bottomLeft + Alignment(0.2, -0.3)',
    Alignment.bottomLeft,
    Alignment(0.2, -0.3),
    Alignment(-0.8, 0.7),
    kAccentSpring,
    'Useful for nudging a child slightly off a named corner.',
  ),
  OperatorSample(
    'subtraction',
    'topCenter - bottomCenter',
    Alignment.topCenter,
    Alignment.bottomCenter,
    Alignment(0.0, -2.0),
    kAccentAmber,
    'A vector pointing two units up — leaves the unit square.',
  ),
];

const List<InscribeSample> kInscribeSamples = <InscribeSample>[
  InscribeSample(
    'topLeft',
    Alignment.topLeft,
    Size(48.0, 36.0),
    Rect.fromLTWH(0.0, 0.0, 220.0, 120.0),
    kAccentLime,
  ),
  InscribeSample(
    'center',
    Alignment.center,
    Size(48.0, 36.0),
    Rect.fromLTWH(0.0, 0.0, 220.0, 120.0),
    kAccentEmerald,
  ),
  InscribeSample(
    'bottomRight',
    Alignment.bottomRight,
    Size(48.0, 36.0),
    Rect.fromLTWH(0.0, 0.0, 220.0, 120.0),
    kAccentTeal,
  ),
  InscribeSample(
    'custom (0.3, -0.6)',
    Alignment(0.3, -0.6),
    Size(60.0, 28.0),
    Rect.fromLTWH(0.0, 0.0, 220.0, 120.0),
    kAccentRose,
  ),
];

const List<AlongSample> kAlongSamples = <AlongSample>[
  AlongSample(
    'topLeft.alongOffset(Offset(120, 80))',
    Alignment.topLeft,
    'offset',
    Offset(120.0, 80.0),
    kAccentLime,
  ),
  AlongSample(
    'bottomRight.alongOffset(Offset(120, 80))',
    Alignment.bottomRight,
    'offset',
    Offset(120.0, 80.0),
    kAccentEmerald,
  ),
  AlongSample(
    'center.alongSize(Size(120, 80))',
    Alignment.center,
    'size',
    Offset(120.0, 80.0),
    kAccentTeal,
  ),
  AlongSample(
    'Alignment(0.4, -0.8).alongSize(Size(120, 80))',
    Alignment(0.4, -0.8),
    'size',
    Offset(120.0, 80.0),
    kAccentMint,
  ),
];

const List<LerpFrame> kLerpFrames = <LerpFrame>[
  LerpFrame('t=0.0', 0.0, Alignment(-1.0, -1.0), Alignment(0.8, 0.6),
      kAccentLime),
  LerpFrame('t≈0.17', 1.0 / 6.0, Alignment(-1.0, -1.0), Alignment(0.8, 0.6),
      kAccentLimeDeep),
  LerpFrame('t≈0.33', 2.0 / 6.0, Alignment(-1.0, -1.0), Alignment(0.8, 0.6),
      kAccentEmerald),
  LerpFrame('t=0.5', 0.5, Alignment(-1.0, -1.0), Alignment(0.8, 0.6),
      kAccentTeal),
  LerpFrame('t≈0.67', 4.0 / 6.0, Alignment(-1.0, -1.0), Alignment(0.8, 0.6),
      kAccentMint),
  LerpFrame('t≈0.83', 5.0 / 6.0, Alignment(-1.0, -1.0), Alignment(0.8, 0.6),
      kAccentSpring),
  LerpFrame('t=1.0', 1.0, Alignment(-1.0, -1.0), Alignment(0.8, 0.6),
      kAccentAmber),
];

const List<DirectionalSample> kDirectionalSamples = <DirectionalSample>[
  DirectionalSample('topStart', AlignmentDirectional.topStart, kAccentLime),
  DirectionalSample(
      'topCenter', AlignmentDirectional.topCenter, kAccentEmerald),
  DirectionalSample('topEnd', AlignmentDirectional.topEnd, kAccentTeal),
  DirectionalSample(
      'centerStart', AlignmentDirectional.centerStart, kAccentMint),
  DirectionalSample('center', AlignmentDirectional.center, kAccentSpring),
  DirectionalSample('centerEnd', AlignmentDirectional.centerEnd, kAccentAmber),
  DirectionalSample('bottomStart', AlignmentDirectional.bottomStart,
      kAccentRose),
  DirectionalSample('bottomCenter', AlignmentDirectional.bottomCenter,
      kAccentClay),
  DirectionalSample(
      'bottomEnd', AlignmentDirectional.bottomEnd, kAccentForest),
];

const List<OutsideSample> kOutsideSamples = <OutsideSample>[
  OutsideSample(
    'Alignment(2, 0)',
    Alignment(2.0, 0.0),
    'One full extra width to the right of the parent — the child sits '
        'beyond the right edge.',
    kAccentLime,
  ),
  OutsideSample(
    'Alignment(-2, 0)',
    Alignment(-2.0, 0.0),
    'Same magnitude, mirrored to the left of the parent.',
    kAccentEmerald,
  ),
  OutsideSample(
    'Alignment(0, 2)',
    Alignment(0.0, 2.0),
    'A full extra height below the parent — handy with Transform.translate '
        'for slide-in effects.',
    kAccentTeal,
  ),
  OutsideSample(
    'Alignment(0, -2)',
    Alignment(0.0, -2.0),
    'A full extra height above. Combined with lerp this models offstage '
        'starting positions.',
    kAccentMint,
  ),
];

const List<UseCaseCard> kUseCaseCards = <UseCaseCard>[
  UseCaseCard(
    'Stack child positioning',
    'Use Alignment in Align children of a Stack to anchor overlays without '
        'computing absolute coordinates.',
    <String>[
      'Stack(',
      '  children: <Widget>[',
      '    Container(width: 200, height: 200, color: bg),',
      '    const Align(',
      '      alignment: Alignment(0.6, -0.6),',
      '      child: Badge(),',
      '    ),',
      '  ],',
      ')',
    ],
    kAccentLime,
  ),
  UseCaseCard(
    'Tween<Alignment> on a transition',
    'Drive AlignTransition or Tween<Alignment> with named constants to '
        'animate between corners using lerp under the hood.',
    <String>[
      'final Tween<Alignment> tween = Tween<Alignment>(',
      '  begin: Alignment.topLeft,',
      '  end: Alignment.bottomRight,',
      ');',
      '// Tween.transform(t) -> Alignment.lerp(begin, end, t)',
    ],
    kAccentEmerald,
  ),
  UseCaseCard(
    'Gradient.begin / Gradient.end',
    'LinearGradient takes Alignment values to describe its direction in the '
        'unit square — (-1,-1) to (1,1) is a top-left to bottom-right sweep.',
    <String>[
      'const LinearGradient(',
      '  begin: Alignment.topLeft,',
      '  end: Alignment.bottomRight,',
      '  colors: <Color>[Colors.lime, Colors.green],',
      ')',
    ],
    kAccentTeal,
  ),
  UseCaseCard(
    'BoxDecoration image alignment',
    'When a DecorationImage uses fit: BoxFit.none or scale > 1, alignment '
        'controls the focal point: Alignment(-0.5, 0) emphasizes the left.',
    <String>[
      'BoxDecoration(',
      '  image: DecorationImage(',
      '    image: provider,',
      '    alignment: Alignment(-0.5, 0.0),',
      '    fit: BoxFit.cover,',
      '  ),',
      ')',
    ],
    kAccentMint,
  ),
];

const List<CaveatCard> kCaveatCards = <CaveatCard>[
  CaveatCard(
    'Alignment vs AlignmentDirectional',
    'Alignment uses absolute x: -1 = left, +1 = right. AlignmentDirectional '
        'uses start/end and only resolves to absolute coordinates after '
        'resolve(textDirection). Mixing the two without resolution is a '
        'common source of layout bugs in RTL languages.',
    kAccentLime,
  ),
  CaveatCard(
    'Alignment.lerp passes through null',
    'When either argument is null, Alignment.lerp returns the other scaled '
        'by t (or 1-t). This makes it usable in Tween<Alignment?> but means '
        'you cannot use it as a strict "between two known points" function.',
    kAccentEmerald,
  ),
  CaveatCard(
    'resolve is a no-op for Alignment',
    'Alignment already lives in absolute LTR-style space, so resolve(...) '
        'returns this unchanged. The method exists so you can treat any '
        'AlignmentGeometry uniformly via the base type.',
    kAccentTeal,
  ),
  CaveatCard(
    'Operators preserve type',
    'Adding two Alignment values yields an Alignment. Adding an Alignment '
        'to an AlignmentDirectional yields a generic AlignmentGeometry that '
        'still needs resolution before it can be applied.',
    kAccentMint,
  ),
  CaveatCard(
    'Newbie pitfall: (0,0) is the center',
    'Many developers expect (0,0) to be top-left. In Alignment it is the '
        'center; the top-left is (-1,-1). When porting from CSS-style '
        'fractional coordinates, remember to remap with x*2-1, y*2-1.',
    kAccentSpring,
  ),
];

// ---------------------------------------------------------------------------
// Custom painters. Kept small so the d4rt interpreter does not need to deal
// with anything exotic — only Path, Paint, drawLine, drawCircle, drawRect.
// ---------------------------------------------------------------------------

class CoordinatePlanePainter extends CustomPainter {
  final Color axis;
  final Color grid;
  final Color border;
  const CoordinatePlanePainter({
    required this.axis,
    required this.grid,
    required this.border,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      borderPaint,
    );

    final Paint gridPaint = Paint()
      ..color = grid
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.75;
    final double stepX = size.width / 4.0;
    final double stepY = size.height / 4.0;
    for (int i = 1; i < 4; i = i + 1) {
      final double dx = stepX * i.toDouble();
      final double dy = stepY * i.toDouble();
      canvas.drawLine(Offset(dx, 0.0), Offset(dx, size.height), gridPaint);
      canvas.drawLine(Offset(0.0, dy), Offset(size.width, dy), gridPaint);
    }

    final Paint axisPaint = Paint()
      ..color = axis
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25;
    canvas.drawLine(
      Offset(0.0, size.height / 2.0),
      Offset(size.width, size.height / 2.0),
      axisPaint,
    );
    canvas.drawLine(
      Offset(size.width / 2.0, 0.0),
      Offset(size.width / 2.0, size.height),
      axisPaint,
    );
  }

  @override
  bool shouldRepaint(CoordinatePlanePainter oldDelegate) {
    return oldDelegate.axis != axis ||
        oldDelegate.grid != grid ||
        oldDelegate.border != border;
  }
}

class CrosshairPainter extends CustomPainter {
  final Color color;
  const CrosshairPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final double cx = size.width / 2.0;
    final double cy = size.height / 2.0;
    canvas.drawLine(Offset(cx, 0.0), Offset(cx, size.height), paint);
    canvas.drawLine(Offset(0.0, cy), Offset(size.width, cy), paint);
    canvas.drawCircle(Offset(cx, cy), size.width * 0.28, paint);
  }

  @override
  bool shouldRepaint(CrosshairPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

// ---------------------------------------------------------------------------
// Helpers that map an Alignment value to a pixel position inside a frame.
// Alignment.alongSize handles the math but we recompute it manually so the
// reader can compare expected vs actual.
// ---------------------------------------------------------------------------

Offset alignmentToFrameCenter(Alignment a, Size frame) {
  final double cx = frame.width / 2.0 + a.x * (frame.width / 2.0);
  final double cy = frame.height / 2.0 + a.y * (frame.height / 2.0);
  return Offset(cx, cy);
}

// ---------------------------------------------------------------------------
// Reusable building blocks. Each helper returns a Widget and is intentionally
// stateless and pure: same inputs, same output.
// ---------------------------------------------------------------------------

Widget buildSectionHeader(String index, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: const BoxDecoration(
            color: kAccentEmerald,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kInkSecondary,
                  fontSize: 13.0,
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

Widget buildPanel({required Widget child, EdgeInsetsGeometry? padding}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
    padding: padding ?? const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: child,
  );
}

Widget buildTextLine(String text, {Color? color, double size = 13.0}) {
  return Text(
    text,
    style: TextStyle(
      color: color ?? kInkSecondary,
      fontSize: size,
      height: 1.45,
    ),
  );
}

Widget buildMonoLine(String text, {Color? color}) {
  return Text(
    text,
    style: TextStyle(
      color: color ?? kInkPrimary,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w600,
      fontSize: 12.5,
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Hero header with gradient and crosshair.
// ---------------------------------------------------------------------------

Widget buildHeroHeader() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
    padding: const EdgeInsets.fromLTRB(22.0, 24.0, 22.0, 26.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kAccentLime, kAccentEmerald],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentEmeraldDeep.withValues(alpha: 0.20),
          blurRadius: 20.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 64.0,
          height: 64.0,
          child: CustomPaint(
            painter: CrosshairPainter(
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Alignment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'A 2D coordinate where (-1,-1) is top-left, (0,0) is center, '
                'and (1,1) is bottom-right. Plus arithmetic, lerp, inscribe, '
                'alongOffset/alongSize, and AlignmentDirectional resolution.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'package:flutter/painting.dart  ::  class Alignment '
                'extends AlignmentGeometry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: Coordinate system diagram.
// ---------------------------------------------------------------------------

Widget buildCornerLabel(String text, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: kBorderStrong),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: kInkPrimary,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

Widget buildCoordinatePlane(Alignment sample, Color tint, double frameSize) {
  final Offset dot =
      alignmentToFrameCenter(sample, Size(frameSize, frameSize));
  return SizedBox(
    width: frameSize,
    height: frameSize,
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: kBgFrame,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: CoordinatePlanePainter(
              axis: kInkSecondary,
              grid: kBorderStrong,
              border: kBorderSoft,
            ),
          ),
        ),
        buildCornerLabel('(-1,-1)', Alignment.topLeft),
        buildCornerLabel('(0,-1)', Alignment.topCenter),
        buildCornerLabel('(1,-1)', Alignment.topRight),
        buildCornerLabel('(-1,0)', Alignment.centerLeft),
        buildCornerLabel('(0,0)', Alignment.center),
        buildCornerLabel('(1,0)', Alignment.centerRight),
        buildCornerLabel('(-1,1)', Alignment.bottomLeft),
        buildCornerLabel('(0,1)', Alignment.bottomCenter),
        buildCornerLabel('(1,1)', Alignment.bottomRight),
        Positioned(
          left: dot.dx - 9.0,
          top: dot.dy - 9.0,
          width: 18.0,
          height: 18.0,
          child: Container(
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: tint.withValues(alpha: 0.45),
                  blurRadius: 8.0,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCoordinateDiagramSection() {
  const Alignment sample = Alignment(0.3, -0.6);
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
    child: Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: kBgPanel,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: kBorderSoft),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildCoordinatePlane(sample, kAccentEmerald, 280.0),
          const SizedBox(width: 18.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Coordinate space',
                  style: TextStyle(
                    color: kInkPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                buildTextLine(
                  'Alignment is a 2D unit-square coordinate. Both axes range '
                  'from -1 (top/left) to +1 (bottom/right) with (0,0) at the '
                  'center. The sample dot below shows '
                  'Alignment(0.3, -0.6).',
                ),
                const SizedBox(height: 10.0),
                buildMonoLine('const sample = Alignment(0.3, -0.6);'),
                buildMonoLine('// sample.x = 0.3   sample.y = -0.6'),
                const SizedBox(height: 10.0),
                buildTextLine(
                  'Mapping to a 280×280 frame with center at (140, 140):',
                ),
                const SizedBox(height: 6.0),
                buildMonoLine('cx = 140 + 0.3 * 140  = 182'),
                buildMonoLine('cy = 140 + -0.6 * 140 = 56'),
                const SizedBox(height: 10.0),
                buildTextLine(
                  'This linear mapping is exactly what Alignment.alongSize '
                  'and Alignment.inscribe perform internally.',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: Constants reference grid.
// ---------------------------------------------------------------------------

Widget buildConstantChip(ConstantSample sample) {
  return Container(
    width: 196.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
            color: sample.tint,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Alignment.${sample.label}',
                style: const TextStyle(
                  color: kInkPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                '(${sample.value.x.toStringAsFixed(0)}, '
                '${sample.value.y.toStringAsFixed(0)})',
                style: const TextStyle(
                  color: kInkMuted,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildConstantsSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Named constants',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'Alignment exposes nine static constants that form a 3×3 grid. '
          'They are the named touchpoints of the unit square.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            for (final ConstantSample c in kConstantSamples)
              buildConstantChip(c),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Operator showcase.
// ---------------------------------------------------------------------------

Widget buildSmallPlane(Alignment a, Color tint, {double frame = 100.0}) {
  final Offset dot = alignmentToFrameCenter(a, Size(frame, frame));
  return SizedBox(
    width: frame,
    height: frame,
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: kBgFrame,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: CoordinatePlanePainter(
              axis: kInkSecondary,
              grid: kBorderStrong,
              border: kBorderSoft,
            ),
          ),
        ),
        Positioned(
          left: dot.dx - 7.0,
          top: dot.dy - 7.0,
          width: 14.0,
          height: 14.0,
          child: Container(
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildOperatorPanel(OperatorSample sample) {
  return Container(
    width: 320.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: sample.tint,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sample.title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        buildMonoLine(sample.expression),
        const SizedBox(height: 4.0),
        buildMonoLine(
          '= (${sample.result.x.toStringAsFixed(2)}, '
          '${sample.result.y.toStringAsFixed(2)})',
          color: sample.tint,
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            buildSmallPlane(sample.lhs, kAccentSlateMute()),
            const SizedBox(width: 6.0),
            const Icon(Icons.arrow_forward, size: 16.0, color: kInkMuted),
            const SizedBox(width: 6.0),
            buildSmallPlane(sample.result, sample.tint),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          sample.note,
          style: const TextStyle(
            color: kInkMuted,
            fontSize: 11.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Color kAccentSlateMute() {
  return const Color(0xFF8FA39A);
}

Widget buildOperatorSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Arithmetic operators',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'Alignment overloads +, -, *, /, ~/, %, and unary -. The result is '
          'always another Alignment with componentwise arithmetic. The left '
          'plane shows the original input; the right plane shows the result.',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: <Widget>[
            for (final OperatorSample o in kOperatorSamples)
              buildOperatorPanel(o),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: inscribe showcase.
// ---------------------------------------------------------------------------

Widget buildInscribePanel(InscribeSample sample) {
  final Rect inscribed = sample.alignment.inscribe(
    sample.childSize,
    sample.parent,
  );
  return Container(
    width: 320.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'inscribe @ ${sample.label}',
          style: const TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 6.0),
        buildMonoLine(
          'Alignment(${sample.alignment.x.toStringAsFixed(2)}, '
          '${sample.alignment.y.toStringAsFixed(2)})',
        ),
        buildMonoLine(
          '.inscribe(Size(${sample.childSize.width.toStringAsFixed(0)}, '
          '${sample.childSize.height.toStringAsFixed(0)}), parent)',
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: sample.parent.width,
          height: sample.parent.height,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: kBgFrame,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: kBorderStrong),
                  ),
                ),
              ),
              Positioned(
                left: inscribed.left,
                top: inscribed.top,
                width: inscribed.width,
                height: inscribed.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: sample.tint.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        buildMonoLine(
          '-> Rect.fromLTWH('
          '${inscribed.left.toStringAsFixed(1)}, '
          '${inscribed.top.toStringAsFixed(1)}, '
          '${inscribed.width.toStringAsFixed(0)}, '
          '${inscribed.height.toStringAsFixed(0)})',
          color: sample.tint,
        ),
      ],
    ),
  );
}

Widget buildInscribeSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Alignment.inscribe',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'inscribe(Size, Rect) places a rectangle of the given size inside '
          'the parent, anchored according to the alignment. The result is '
          'the absolute Rect of the inscribed child.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            for (final InscribeSample s in kInscribeSamples)
              buildInscribePanel(s),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: alongOffset / alongSize showcase.
// ---------------------------------------------------------------------------

Widget buildAlongPanel(AlongSample sample) {
  final Offset offset = sample.kind == 'offset'
      ? sample.alignment.alongOffset(sample.reference)
      : sample.alignment.alongSize(
          Size(sample.reference.dx, sample.reference.dy),
        );
  const double plane = 160.0;
  // For visualization, anchor the origin in the center of the plane and draw
  // the resulting offset as a vector from origin.
  final Offset start = const Offset(plane / 2.0, plane / 2.0);
  // Scale offset down so it fits inside the plane (its magnitude can exceed
  // half the plane size in some cases).
  final double maxAbs =
      (offset.dx.abs() > offset.dy.abs() ? offset.dx.abs() : offset.dy.abs())
          .clamp(1.0, double.infinity);
  final double scale = (plane / 2.0 - 12.0) / maxAbs;
  final Offset end = Offset(
    start.dx + offset.dx * scale,
    start.dy + offset.dy * scale,
  );
  return Container(
    width: 340.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          sample.label,
          style: const TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 13.0,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: plane,
          height: plane,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: kBgFrame,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: CoordinatePlanePainter(
                    axis: kInkSecondary,
                    grid: kBorderStrong,
                    border: kBorderSoft,
                  ),
                ),
              ),
              Positioned(
                left: start.dx - 4.0,
                top: start.dy - 4.0,
                width: 8.0,
                height: 8.0,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: kInkPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: end.dx - 7.0,
                top: end.dy - 7.0,
                width: 14.0,
                height: 14.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: sample.tint,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        buildMonoLine(
          '= Offset(${offset.dx.toStringAsFixed(1)}, '
          '${offset.dy.toStringAsFixed(1)})',
          color: sample.tint,
        ),
      ],
    ),
  );
}

Widget buildAlongSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'alongOffset & alongSize',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'alongOffset(other) returns an Offset where each axis is the '
          'corresponding component of other multiplied by alignment. '
          'alongSize(size) is the same idea against a Size, used internally '
          'when laying out children inside containers.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            for (final AlongSample a in kAlongSamples) buildAlongPanel(a),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: lerp showcase strip.
// ---------------------------------------------------------------------------

Widget buildLerpFrame(LerpFrame frame) {
  final Alignment? lerped = Alignment.lerp(frame.a, frame.b, frame.t);
  final Alignment effective = lerped ?? frame.a;
  return Container(
    width: 130.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          frame.label,
          style: const TextStyle(
            color: kInkSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6.0),
        buildSmallPlane(effective, frame.tint, frame: 110.0),
        const SizedBox(height: 6.0),
        buildMonoLine(
          '(${effective.x.toStringAsFixed(2)},'
          ' ${effective.y.toStringAsFixed(2)})',
          color: frame.tint,
        ),
      ],
    ),
  );
}

Widget buildLerpSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Alignment.lerp(a, b, t)',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'Static lerp interpolates componentwise. Tweens, AnimatedAlign, '
          'and AlignTransition all rely on it. Below: the path from '
          '(-1,-1) to (0.8, 0.6) sampled at seven values of t.',
        ),
        const SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (final LerpFrame f in kLerpFrames) buildLerpFrame(f),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: AlignmentDirectional comparison.
// ---------------------------------------------------------------------------

Widget buildDirectionalChip(
  DirectionalSample sample,
  TextDirection direction,
) {
  final Alignment resolved = sample.value.resolve(direction);
  return Container(
    width: 220.0,
    margin: const EdgeInsets.all(5.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: sample.tint,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'AlignmentDirectional.${sample.label}',
                style: const TextStyle(
                  color: kInkPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                '${direction == TextDirection.ltr ? 'LTR' : 'RTL'} -> '
                '(${resolved.x.toStringAsFixed(1)}, '
                '${resolved.y.toStringAsFixed(1)})',
                style: const TextStyle(
                  color: kInkSecondary,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDirectionalColumn(String title, TextDirection direction) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kBgPanelAlt,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: kBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: kInkPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            children: <Widget>[
              for (final DirectionalSample s in kDirectionalSamples)
                buildDirectionalChip(s, direction),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildDirectionalSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AlignmentDirectional comparison',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'AlignmentDirectional uses start/end instead of left/right. Call '
          'resolve(textDirection) to obtain a concrete Alignment. Use '
          'AlignmentDirectional when your UI must flip in RTL languages '
          '(badges, leading icons). Use Alignment when the position is '
          'absolute regardless of writing direction (e.g. a watermark in the '
          'top-left of an exported image).',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildDirectionalColumn(
              'TextDirection.ltr  ->  resolve()',
              TextDirection.ltr,
            ),
            buildDirectionalColumn(
              'TextDirection.rtl  ->  resolve()',
              TextDirection.rtl,
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9: outside-the-unit-square.
// ---------------------------------------------------------------------------

Widget buildOutsidePanel(OutsideSample sample) {
  const double plane = 160.0;
  // We deliberately don't clamp — show that the dot escapes the visible
  // frame, illustrating positions beyond [-1, 1].
  final Offset dot =
      alignmentToFrameCenter(sample.alignment, const Size(plane, plane));
  return Container(
    width: 320.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          sample.label,
          style: const TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 13.5,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8.0),
        ClipRect(
          child: SizedBox(
            width: 280.0,
            height: 180.0,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 60.0,
                  top: 10.0,
                  child: SizedBox(
                    width: plane,
                    height: plane,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: kBgFrame,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: CustomPaint(
                            painter: CoordinatePlanePainter(
                              axis: kInkSecondary,
                              grid: kBorderStrong,
                              border: kBorderSoft,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 60.0 + dot.dx - 8.0,
                  top: 10.0 + dot.dy - 8.0,
                  width: 16.0,
                  height: 16.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: sample.tint,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: sample.tint.withValues(alpha: 0.45),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          sample.narrative,
          style: const TextStyle(
            color: kInkSecondary,
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget buildOutsideSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Beyond the unit square',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'Alignment is not clamped to [-1, 1]. Values outside that range '
          'place the child off-parent — useful for transitions, parallax, '
          'and Transform.translate-style positioning. The plane outline in '
          'each panel marks the unit square; the dot can sit outside it.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            for (final OutsideSample s in kOutsideSamples)
              buildOutsidePanel(s),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10: real-world usage cards.
// ---------------------------------------------------------------------------

Widget buildUseCaseCard(UseCaseCard card) {
  return Container(
    width: 360.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: card.tint,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                card.title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          card.summary,
          style: const TextStyle(
            color: kInkSecondary,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kBgInk,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String line in card.snippet)
                Text(
                  line,
                  style: const TextStyle(
                    color: Color(0xFFD8ECCD),
                    fontFamily: 'monospace',
                    fontSize: 11.5,
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

Widget buildUseCaseSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Real-world usage',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'Alignment shows up across the framework: Stack overlays, '
          'transition tweens, gradient direction, and BoxDecoration image '
          'anchoring all consume Alignment values.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            for (final UseCaseCard c in kUseCaseCards) buildUseCaseCard(c),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11: caveats.
// ---------------------------------------------------------------------------

Widget buildCaveatCard(CaveatCard card) {
  return Container(
    width: 360.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: card.tint,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                card.title,
                style: const TextStyle(
                  color: kInkPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          card.body,
          style: const TextStyle(
            color: kInkSecondary,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget buildCaveatsSection() {
  return buildPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Caveats and pitfalls',
          style: TextStyle(
            color: kInkPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildTextLine(
          'Even a value class as small as Alignment hides a few footguns. '
          'These cards collect the ones that bite most often.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            for (final CaveatCard c in kCaveatCards) buildCaveatCard(c),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 12: footer takeaways.
// ---------------------------------------------------------------------------

Widget buildFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 28.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kBgInk,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Takeaways',
          style: TextStyle(
            color: kAccentSpring,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '• Alignment is a unit-square coordinate centered at (0,0); '
          'top-left is (-1,-1).',
          style: TextStyle(
            color: Color(0xFFEAF6E1),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        Text(
          '• Operators are componentwise — combine named constants with '
          'small fractional offsets to nudge.',
          style: TextStyle(
            color: Color(0xFFEAF6E1),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        Text(
          '• inscribe / alongOffset / alongSize convert Alignment into '
          'pixel-space rects and offsets.',
          style: TextStyle(
            color: Color(0xFFEAF6E1),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        Text(
          '• Alignment.lerp powers every animated alignment in the '
          'framework.',
          style: TextStyle(
            color: Color(0xFFEAF6E1),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        Text(
          '• Reach for AlignmentDirectional whenever start/end semantics '
          'matter; otherwise prefer Alignment.',
          style: TextStyle(
            color: Color(0xFFEAF6E1),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        Text(
          '• Values outside [-1, 1] are valid — they place the child '
          'beyond the parent, which is great for transitions.',
          style: TextStyle(
            color: Color(0xFFEAF6E1),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Top-level build entrypoint.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kBgPage,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeroHeader(),
          buildSectionHeader(
            '1',
            'Coordinate system',
            'A 280x280 plane with axis lines, nine corner labels, and a dot '
                'at (0.3, -0.6).',
          ),
          buildCoordinateDiagramSection(),
          buildSectionHeader(
            '2',
            'Named constants',
            'The 3x3 grid of static Alignment constants.',
          ),
          buildConstantsSection(),
          buildSectionHeader(
            '3',
            'Operators',
            'Addition, subtraction, scaling, division, and unary negation.',
          ),
          buildOperatorSection(),
          buildSectionHeader(
            '4',
            'inscribe',
            'Place a child of a given size inside a parent rect, anchored '
                'by Alignment.',
          ),
          buildInscribeSection(),
          buildSectionHeader(
            '5',
            'alongOffset and alongSize',
            'Project an Alignment onto an Offset or Size to get an absolute '
                'pixel offset.',
          ),
          buildAlongSection(),
          buildSectionHeader(
            '6',
            'lerp',
            'Static Alignment.lerp(a, b, t) sampled across seven values of '
                't between two corners.',
          ),
          buildLerpSection(),
          buildSectionHeader(
            '7',
            'AlignmentDirectional',
            'Side-by-side LTR and RTL resolution, with a note on when to '
                'prefer each.',
          ),
          buildDirectionalSection(),
          buildSectionHeader(
            '8',
            'Outside the unit square',
            'Values beyond +/-1 place the child off-parent — useful for '
                'slide-in transitions.',
          ),
          buildOutsideSection(),
          buildSectionHeader(
            '9',
            'Real-world usage',
            'Stack children, Tween<Alignment>, gradient direction, and '
                'BoxDecoration image anchoring.',
          ),
          buildUseCaseSection(),
          buildSectionHeader(
            '10',
            'Caveats',
            'Common pitfalls — directional vs absolute, lerp null-handling, '
                'and the (0,0)-vs-(-1,-1) confusion.',
          ),
          buildCaveatsSection(),
          buildFooter(),
        ],
      ),
    ),
  );
}
