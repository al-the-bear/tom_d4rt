// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual deep demo: AndroidPointerProperties from package:flutter/services.dart.
//
// This script paints a long-form, hand-authored portrait of the per-pointer
// descriptor used by Android's MotionEvent replay path. It is intentionally
// verbose so the analyzer-free interpreter has plenty of literal widget tree
// to chew through without surprises (no setState, no async, no controllers).
//
// AndroidPointerProperties wraps two integers: `id` (a stable index used to
// match a pointer across DOWN/MOVE/UP) and `toolType` (an enum-like int
// indicating the input device family — finger, stylus, mouse, eraser, ...).
// Companion class AndroidPointerCoords carries the geometry: x, y, pressure,
// size, the touchMajor/touchMinor ellipse, the toolMajor/toolMinor ellipse
// and orientation (radians, stylus tilt direction).
//
// Together they are the bricks of an AndroidMotionEvent that Flutter's
// platform views layer translates into PointerEvents on the framework side.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Theme constants
// ---------------------------------------------------------------------------

const Color kAndroidGreen = Color(0xFFA4C639);
const Color kAndroidGreenDark = Color(0xFF6E8E1F);
const Color kInkDeep = Color(0xFF0F1A12);
const Color kInkSoft = Color(0xFF1F2A22);
const Color kPaper = Color(0xFFF6F8F4);
const Color kPaperDim = Color(0xFFE6ECE2);
const Color kAccentStylus = Color(0xFF3D7BD6);
const Color kAccentMouse = Color(0xFF8B5CF6);
const Color kAccentEraser = Color(0xFFEF5A6F);
const Color kAccentFinger = Color(0xFFE7A33A);
const Color kAccentUnknown = Color(0xFF7A7A7A);
const Color kGridLine = Color(0xFFCBD3C5);

// ---------------------------------------------------------------------------
// Tool type integer constants (mirrors Android's MotionEvent.TOOL_TYPE_*).
// AndroidPointerProperties.toolType uses raw ints; named constants help.
// ---------------------------------------------------------------------------

const int kToolTypeUnknown = 0;
const int kToolTypeFinger = 1;
const int kToolTypeStylus = 2;
const int kToolTypeMouse = 3;
const int kToolTypeEraser = 4;

String toolTypeLabel(int t) {
  switch (t) {
    case kToolTypeUnknown:
      return 'TOOL_TYPE_UNKNOWN';
    case kToolTypeFinger:
      return 'TOOL_TYPE_FINGER';
    case kToolTypeStylus:
      return 'TOOL_TYPE_STYLUS';
    case kToolTypeMouse:
      return 'TOOL_TYPE_MOUSE';
    case kToolTypeEraser:
      return 'TOOL_TYPE_ERASER';
    default:
      return 'TOOL_TYPE_?';
  }
}

Color toolTypeColor(int t) {
  switch (t) {
    case kToolTypeFinger:
      return kAccentFinger;
    case kToolTypeStylus:
      return kAccentStylus;
    case kToolTypeMouse:
      return kAccentMouse;
    case kToolTypeEraser:
      return kAccentEraser;
    default:
      return kAccentUnknown;
  }
}

IconData toolTypeIcon(int t) {
  switch (t) {
    case kToolTypeFinger:
      return Icons.touch_app_rounded;
    case kToolTypeStylus:
      return Icons.edit_rounded;
    case kToolTypeMouse:
      return Icons.mouse_rounded;
    case kToolTypeEraser:
      return Icons.auto_fix_off_rounded;
    default:
      return Icons.help_outline_rounded;
  }
}

// ---------------------------------------------------------------------------
// Sample pointer descriptor — bundles AndroidPointerProperties with
// AndroidPointerCoords plus a friendly story for the demo cards.
// ---------------------------------------------------------------------------

class SamplePointer {
  const SamplePointer({
    required this.title,
    required this.story,
    required this.props,
    required this.coords,
    required this.color,
  });

  final String title;
  final String story;
  final AndroidPointerProperties props;
  final AndroidPointerCoords coords;
  final Color color;
}

// ---------------------------------------------------------------------------
// build entry point — a single static dynamic build(BuildContext) function.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('AndroidPointerProperties visual deep demo');
  print('=' * 56);
  final samples = buildSampleSet();
  for (final s in samples) {
    print(
      '${s.title}: id=${s.props.id} toolType=${s.props.toolType} '
      '(${toolTypeLabel(s.props.toolType)})',
    );
  }
  print('=' * 56);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AndroidPointerProperties — Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: kPaper,
      primaryColor: kAndroidGreen,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: kInkDeep, fontSize: 14),
      ),
    ),
    home: Scaffold(
      backgroundColor: kPaper,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSection(),
            const SectionGap(),
            const AnatomySection(),
            const SectionGap(),
            const ToolTypeEnumSection(),
            const SectionGap(),
            SamplePointerGrid(samples: samples),
            const SectionGap(),
            const OrientationSection(),
            const SectionGap(),
            const RelatedTypesSection(),
            const SectionGap(),
            const CrossPlatformMappingSection(),
            const SectionGap(),
            const SyntheticMotionRecipeSection(),
            const SectionGap(),
            const PitfallsSection(),
            const SectionGap(),
            const FooterSection(),
          ],
        ),
      ),
    ),
  );
}

List<SamplePointer> buildSampleSet() {
  return <SamplePointer>[
    SamplePointer(
      title: 'Index finger tap',
      story:
          'A single soft tap near the centre of the screen. Pressure ~0.55, '
          'touch ellipse roughly circular.',
      props: AndroidPointerProperties(id: 0, toolType: kToolTypeFinger),
      coords: AndroidPointerCoords(
        orientation: 0.0,
        pressure: 0.55,
        size: 0.40,
        toolMajor: 14.0,
        toolMinor: 12.0,
        touchMajor: 18.0,
        touchMinor: 17.0,
        x: 240.0,
        y: 360.0,
      ),
      color: kAccentFinger,
    ),
    SamplePointer(
      title: 'Thumb press',
      story:
          'A heavier thumb press from the lower-right; broader contact ellipse, '
          'higher pressure.',
      props: AndroidPointerProperties(id: 1, toolType: kToolTypeFinger),
      coords: AndroidPointerCoords(
        orientation: 0.30,
        pressure: 0.85,
        size: 0.65,
        toolMajor: 22.0,
        toolMinor: 18.0,
        touchMajor: 28.0,
        touchMinor: 22.0,
        x: 410.0,
        y: 720.0,
      ),
      color: kAccentFinger,
    ),
    SamplePointer(
      title: 'Stylus tilt',
      story:
          'An active pen with tilt — narrow tool ellipse, orientation > 0 marks '
          'the lean direction.',
      props: AndroidPointerProperties(id: 2, toolType: kToolTypeStylus),
      coords: AndroidPointerCoords(
        orientation: 0.85,
        pressure: 0.42,
        size: 0.10,
        toolMajor: 4.0,
        toolMinor: 3.5,
        touchMajor: 6.0,
        touchMinor: 5.5,
        x: 150.0,
        y: 220.0,
      ),
      color: kAccentStylus,
    ),
    SamplePointer(
      title: 'Hover mouse',
      story:
          'Mouse cursor without a button down — pressure 0, but still reported '
          'with id and toolType.',
      props: AndroidPointerProperties(id: 3, toolType: kToolTypeMouse),
      coords: AndroidPointerCoords(
        orientation: 0.0,
        pressure: 0.0,
        size: 0.05,
        toolMajor: 2.0,
        toolMinor: 2.0,
        touchMajor: 0.0,
        touchMinor: 0.0,
        x: 540.0,
        y: 100.0,
      ),
      color: kAccentMouse,
    ),
    SamplePointer(
      title: 'Stylus eraser',
      story:
          'The pen flipped over — same physical device, different toolType '
          '(TOOL_TYPE_ERASER) and a new id.',
      props: AndroidPointerProperties(id: 4, toolType: kToolTypeEraser),
      coords: AndroidPointerCoords(
        orientation: -0.55,
        pressure: 0.30,
        size: 0.20,
        toolMajor: 8.0,
        toolMinor: 7.0,
        touchMajor: 12.0,
        touchMinor: 10.5,
        x: 320.0,
        y: 480.0,
      ),
      color: kAccentEraser,
    ),
    SamplePointer(
      title: 'Unknown source',
      story:
          'A test event from an unknown input device — toolType = 0 reminds '
          'consumers to fall back to defaults.',
      props: AndroidPointerProperties(id: 5, toolType: kToolTypeUnknown),
      coords: AndroidPointerCoords(
        orientation: 0.0,
        pressure: 0.5,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 14.0,
        touchMinor: 14.0,
        x: 300.0,
        y: 300.0,
      ),
      color: kAccentUnknown,
    ),
  ];
}

// ---------------------------------------------------------------------------
// Reusable layout primitives
// ---------------------------------------------------------------------------

class SectionGap extends StatelessWidget {
  const SectionGap({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(height: 32);
}

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.accent = kAndroidGreen,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPaperDim),
        boxShadow: [
          BoxShadow(
            color: kInkDeep.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 28,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: kInkDeep,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: kInkSoft,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class TagPill extends StatelessWidget {
  const TagPill({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class CodeBlock extends StatelessWidget {
  const CodeBlock({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kInkDeep,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: kPaper,
          height: 1.45,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HERO SECTION — Android phone outline with a finger pointer landing on it.
// ---------------------------------------------------------------------------

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kInkDeep, kInkSoft],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kAndroidGreen.withValues(alpha: 0.20),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    TagPill(
                      text: 'package:flutter/services.dart',
                      color: kAndroidGreen,
                    ),
                    SizedBox(width: 8),
                    TagPill(
                      text: 'platform_views',
                      color: kAccentStylus,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'AndroidPointerProperties',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The per-pointer descriptor of an Android MotionEvent.\n'
                  'Two integers — id and toolType — that anchor every touch '
                  'across its DOWN, MOVE and UP frames.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: const [
                    HeroChip(text: 'id : int', color: kAccentFinger),
                    HeroChip(text: 'toolType : int', color: kAccentStylus),
                    HeroChip(
                      text: 'paired with AndroidPointerCoords',
                      color: kAndroidGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 4,
            child: AspectRatio(
              aspectRatio: 0.55,
              child: CustomPaint(painter: HeroPhonePainter()),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroChip extends StatelessWidget {
  const HeroChip({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class HeroPhonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final body = Paint()..color = const Color(0xFF202820);
    final bezel = Paint()..color = const Color(0xFF0A0F0A);
    final glass = Paint()..color = const Color(0xFF223326);
    final outline = Paint()
      ..color = kAndroidGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final phone = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.10, h * 0.05, w * 0.80, h * 0.90),
      Radius.circular(w * 0.10),
    );
    canvas.drawRRect(phone, body);
    canvas.drawRRect(phone, outline);

    final screen = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.16, h * 0.10, w * 0.68, h * 0.80),
      Radius.circular(w * 0.05),
    );
    canvas.drawRRect(screen, bezel);
    canvas.drawRRect(screen.deflate(3), glass);

    // Speaker slit
    final speaker = Rect.fromCenter(
      center: Offset(w * 0.50, h * 0.085),
      width: w * 0.18,
      height: 3,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(speaker, const Radius.circular(2)),
      Paint()..color = const Color(0xFF0F1A12),
    );

    // Grid lines on screen
    final grid = Paint()
      ..color = kAndroidGreen.withValues(alpha: 0.18)
      ..strokeWidth = 0.6;
    for (int i = 1; i < 6; i++) {
      final y = h * 0.10 + (h * 0.80) * (i / 6);
      canvas.drawLine(Offset(w * 0.18, y), Offset(w * 0.82, y), grid);
    }
    for (int i = 1; i < 4; i++) {
      final x = w * 0.16 + (w * 0.68) * (i / 4);
      canvas.drawLine(Offset(x, h * 0.10), Offset(x, h * 0.90), grid);
    }

    // Touch ellipse + ripple
    final touchCenter = Offset(w * 0.55, h * 0.55);
    final ringPaints = <Paint>[
      Paint()
        ..color = kAndroidGreen.withValues(alpha: 0.10)
        ..style = PaintingStyle.fill,
      Paint()
        ..color = kAndroidGreen.withValues(alpha: 0.18)
        ..style = PaintingStyle.fill,
      Paint()
        ..color = kAndroidGreen.withValues(alpha: 0.32)
        ..style = PaintingStyle.fill,
    ];
    canvas.drawCircle(touchCenter, w * 0.18, ringPaints[0]);
    canvas.drawCircle(touchCenter, w * 0.13, ringPaints[1]);
    canvas.drawCircle(touchCenter, w * 0.08, ringPaints[2]);

    // Finger pointer caricature (an oval over the touch spot)
    final fingerPath = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(w * 0.55, h * 0.50),
          width: w * 0.22,
          height: h * 0.32,
        ),
      );
    canvas.drawPath(fingerPath, Paint()..color = const Color(0xFFEFC9A4));
    canvas.drawPath(
      fingerPath,
      Paint()
        ..color = const Color(0xFFB18260)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    // Fingernail
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.55, h * 0.40),
        width: w * 0.10,
        height: h * 0.05,
      ),
      Paint()..color = const Color(0xFFFFE8D2),
    );

    // id / toolType callouts
    _drawCallout(
      canvas,
      Offset(w * 0.20, h * 0.30),
      'id: 0',
      kAccentFinger,
    );
    _drawCallout(
      canvas,
      Offset(w * 0.20, h * 0.74),
      'toolType: 1',
      kAccentStylus,
    );
  }

  void _drawCallout(Canvas canvas, Offset at, String text, Color c) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final r = Rect.fromLTWH(
      at.dx,
      at.dy,
      tp.width + 12,
      tp.height + 6,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(6)),
      Paint()..color = c.withValues(alpha: 0.18),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(6)),
      Paint()
        ..color = c
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    tp.paint(canvas, Offset(at.dx + 6, at.dy + 3));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// ANATOMY SECTION — labelled diagram of AndroidPointerProperties(id, toolType)
// ---------------------------------------------------------------------------

class AnatomySection extends StatelessWidget {
  const AnatomySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'Anatomy',
      subtitle:
          'AndroidPointerProperties is a flat pair of named integers. Both '
          'fields are required; both have well-defined zero defaults on the '
          'Android side that Flutter mirrors.',
      accent: kAndroidGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPaper,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kPaperDim),
            ),
            child: const AnatomyDiagram(),
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: AnatomyField(
                  fieldName: 'id',
                  fieldType: 'int',
                  description:
                      'Pointer index. Stable across DOWN -> MOVE -> UP for the '
                      'same physical contact. Reused after release.',
                  example: 'id: 0, 1, 2, ...',
                  color: kAccentFinger,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: AnatomyField(
                  fieldName: 'toolType',
                  fieldType: 'int',
                  description:
                      'Input device family encoded as one of TOOL_TYPE_* '
                      'constants. 1 = finger, 2 = stylus, 3 = mouse, ...',
                  example: 'toolType: 2 (stylus)',
                  color: kAccentStylus,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnatomyDiagram extends StatelessWidget {
  const AnatomyDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: CustomPaint(painter: AnatomyDiagramPainter()),
    );
  }
}

class AnatomyDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final boxFill = Paint()..color = kAndroidGreen.withValues(alpha: 0.10);
    final boxStroke = Paint()
      ..color = kAndroidGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Outer constructor box
    final outer = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.05, h * 0.20, w * 0.90, h * 0.60),
      const Radius.circular(14),
    );
    canvas.drawRRect(outer, boxFill);
    canvas.drawRRect(outer, boxStroke);

    _label(
      canvas,
      Offset(w * 0.05, h * 0.04),
      'AndroidPointerProperties(',
      const TextStyle(
        color: kInkDeep,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    );
    _label(
      canvas,
      Offset(w * 0.05, h * 0.86),
      ')',
      const TextStyle(
        color: kInkDeep,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    );

    // Two field cards
    _fieldCard(
      canvas,
      Rect.fromLTWH(w * 0.10, h * 0.32, w * 0.36, h * 0.40),
      'id: int',
      kAccentFinger,
    );
    _fieldCard(
      canvas,
      Rect.fromLTWH(w * 0.54, h * 0.32, w * 0.36, h * 0.40),
      'toolType: int',
      kAccentStylus,
    );
  }

  void _label(Canvas canvas, Offset at, String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  void _fieldCard(Canvas canvas, Rect r, String text, Color c) {
    final rr = RRect.fromRectAndRadius(r, const Radius.circular(10));
    canvas.drawRRect(rr, Paint()..color = c.withValues(alpha: 0.15));
    canvas.drawRRect(
      rr,
      Paint()
        ..color = c
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.w800,
          fontSize: 14,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AnatomyField extends StatelessWidget {
  const AnatomyField({
    super.key,
    required this.fieldName,
    required this.fieldType,
    required this.description,
    required this.example,
    required this.color,
  });

  final String fieldName;
  final String fieldType;
  final String description;
  final String example;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                fieldName,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              TagPill(text: fieldType, color: color),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: kInkSoft,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: kInkDeep,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              example,
              style: const TextStyle(
                color: kPaper,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TOOL TYPE ENUM SECTION — five cards, one per TOOL_TYPE_*.
// ---------------------------------------------------------------------------

class ToolTypeEnumSection extends StatelessWidget {
  const ToolTypeEnumSection({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = <_ToolTypeEntry>[
      const _ToolTypeEntry(
        value: kToolTypeUnknown,
        title: 'UNKNOWN',
        description:
            'Source could not be classified. Treat coordinates as untrusted.',
      ),
      const _ToolTypeEntry(
        value: kToolTypeFinger,
        title: 'FINGER',
        description:
            'Capacitive finger contact. The dominant case on phones and tablets.',
      ),
      const _ToolTypeEntry(
        value: kToolTypeStylus,
        title: 'STYLUS',
        description:
            'Active or passive pen. Often delivers pressure and orientation.',
      ),
      const _ToolTypeEntry(
        value: kToolTypeMouse,
        title: 'MOUSE',
        description:
            'External pointing device. Typically pressure 0 unless a button is held.',
      ),
      const _ToolTypeEntry(
        value: kToolTypeERaser_,
        title: 'ERASER',
        description:
            'The flipped-pen end of a stylus. New id, but same physical tool.',
      ),
    ];
    return SectionContainer(
      title: 'Tool type enum',
      subtitle:
          'AndroidPointerProperties.toolType is an int, but only a small set '
          'of values are meaningful. Always compare against named constants.',
      accent: kAccentStylus,
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: entries.map(_buildCard).toList(),
      ),
    );
  }

  Widget _buildCard(_ToolTypeEntry e) {
    final color = toolTypeColor(e.value);
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(toolTypeIcon(e.value), color: color, size: 22),
              ),
              Text(
                e.value.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            e.title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: color,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'TOOL_TYPE_${e.title}',
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: kInkSoft,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            e.description,
            style: const TextStyle(
              fontSize: 12,
              color: kInkSoft,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: constant_identifier_names
const int kToolTypeERaser_ = kToolTypeEraser;

class _ToolTypeEntry {
  const _ToolTypeEntry({
    required this.value,
    required this.title,
    required this.description,
  });

  final int value;
  final String title;
  final String description;
}

// ---------------------------------------------------------------------------
// SAMPLE POINTER GRID — 6 cards with literal AndroidPointerProperties /
// AndroidPointerCoords plus a "fingerprint" thumbnail.
// ---------------------------------------------------------------------------

class SamplePointerGrid extends StatelessWidget {
  const SamplePointerGrid({super.key, required this.samples});

  final List<SamplePointer> samples;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'Sample pointers',
      subtitle:
          'Six concrete pointer descriptors, each rendered with its '
          'fingerprint thumbnail. Concentric rings visualise pressure, the '
          'inner ellipse depicts touchMajor/touchMinor.',
      accent: kAccentFinger,
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: samples.map((s) => SamplePointerCard(sample: s)).toList(),
      ),
    );
  }
}

class SamplePointerCard extends StatelessWidget {
  const SamplePointerCard({super.key, required this.sample});

  final SamplePointer sample;

  @override
  Widget build(BuildContext context) {
    final p = sample.props;
    final c = sample.coords;
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: sample.color.withValues(alpha: 0.40)),
        boxShadow: [
          BoxShadow(
            color: sample.color.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                toolTypeIcon(p.toolType),
                color: sample.color,
                size: 22,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  sample.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: kInkDeep,
                  ),
                ),
              ),
              TagPill(
                text: 'id ${p.id}',
                color: sample.color,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            sample.story,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: CustomPaint(
                  painter: FingerprintPainter(coords: c, color: sample.color),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PropertyRow(
                      name: 'toolType',
                      value:
                          '${p.toolType} (${toolTypeLabel(p.toolType)})',
                    ),
                    PropertyRow(
                      name: 'x, y',
                      value:
                          '${c.x.toStringAsFixed(1)}, ${c.y.toStringAsFixed(1)}',
                    ),
                    PropertyRow(
                      name: 'pressure',
                      value: c.pressure.toStringAsFixed(2),
                    ),
                    PropertyRow(
                      name: 'size',
                      value: c.size.toStringAsFixed(2),
                    ),
                    PropertyRow(
                      name: 'touchM',
                      value:
                          '${c.touchMajor.toStringAsFixed(1)} / ${c.touchMinor.toStringAsFixed(1)}',
                    ),
                    PropertyRow(
                      name: 'toolM',
                      value:
                          '${c.toolMajor.toStringAsFixed(1)} / ${c.toolMinor.toStringAsFixed(1)}',
                    ),
                    PropertyRow(
                      name: 'orient',
                      value:
                          '${c.orientation.toStringAsFixed(2)} rad',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PropertyRow extends StatelessWidget {
  const PropertyRow({
    super.key,
    required this.name,
    required this.value,
  });

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: kInkSoft,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: kInkDeep,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FingerprintPainter extends CustomPainter {
  FingerprintPainter({required this.coords, required this.color});

  final AndroidPointerCoords coords;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    // background pad
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        const Radius.circular(14),
      ),
      Paint()..color = kPaper,
    );

    // grid lines
    final grid = Paint()
      ..color = kGridLine
      ..strokeWidth = 0.6;
    for (int i = 1; i < 4; i++) {
      canvas.drawLine(
        Offset(0, h * i / 4),
        Offset(w, h * i / 4),
        grid,
      );
      canvas.drawLine(
        Offset(w * i / 4, 0),
        Offset(w * i / 4, h),
        grid,
      );
    }

    // pressure rings — outer to inner
    final p = coords.pressure.clamp(0.0, 1.0);
    for (int i = 4; i >= 1; i--) {
      final r = (w * 0.45) * (i / 4) * (0.4 + p * 0.6);
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()..color = color.withValues(alpha: 0.10 + 0.10 * (4 - i)),
      );
    }

    // touch ellipse
    final tMaj = (coords.touchMajor / 30.0).clamp(0.05, 1.0) * (w * 0.40);
    final tMin = (coords.touchMinor / 30.0).clamp(0.05, 1.0) * (w * 0.40);
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(coords.orientation);
    final touchRect = Rect.fromCenter(
      center: Offset.zero,
      width: tMaj * 2,
      height: tMin * 2,
    );
    canvas.drawOval(
      touchRect,
      Paint()..color = color.withValues(alpha: 0.55),
    );
    canvas.drawOval(
      touchRect,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    canvas.restore();

    // crosshair at logical (x,y) — projected into thumbnail by clamping
    final px = (coords.x % w).clamp(4.0, w - 4.0);
    final py = (coords.y % h).clamp(4.0, h - 4.0);
    final crossPaint = Paint()
      ..color = kInkDeep.withValues(alpha: 0.55)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(px - 5, py), Offset(px + 5, py), crossPaint);
    canvas.drawLine(Offset(px, py - 5), Offset(px, py + 5), crossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// ORIENTATION SECTION — small vector arrow showing stylus tilt direction.
// ---------------------------------------------------------------------------

class OrientationSection extends StatelessWidget {
  const OrientationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final samples = <double>[
      -1.4,
      -0.8,
      -0.3,
      0.0,
      0.3,
      0.8,
      1.4,
    ];
    return SectionContainer(
      title: 'Orientation (stylus tilt)',
      subtitle:
          'AndroidPointerCoords.orientation is in radians. 0 means the major '
          'axis points "up" relative to the device. Negative is left-leaning, '
          'positive is right-leaning.',
      accent: kAccentStylus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 160,
            child: Row(
              children: samples
                  .map(
                    (a) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: OrientationArrow(angle: a),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 14),
          const CodeBlock(
            code:
                '// Stylus tilted hard right\n'
                'final tilted = AndroidPointerCoords(\n'
                '  orientation: 1.2,   // radians\n'
                '  pressure: 0.35,\n'
                '  size: 0.10,\n'
                '  toolMajor: 4.0,  toolMinor: 3.5,\n'
                '  touchMajor: 6.0, touchMinor: 5.5,\n'
                '  x: 100.0, y: 200.0,\n'
                ');',
          ),
        ],
      ),
    );
  }
}

class OrientationArrow extends StatelessWidget {
  const OrientationArrow({super.key, required this.angle});

  final double angle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kAccentStylus.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kAccentStylus.withValues(alpha: 0.30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomPaint(
              painter: ArrowPainter(angle: angle),
              size: const Size.square(80),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${angle.toStringAsFixed(2)} rad',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: kAccentStylus,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  ArrowPainter({required this.angle});

  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = size.shortestSide * 0.40;

    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()..color = kAccentStylus.withValues(alpha: 0.10),
    );
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()
        ..color = kAccentStylus.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    final shaft = Paint()
      ..color = kAccentStylus
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, radius * 0.7), Offset(0, -radius * 0.7), shaft);
    final headPath = Path()
      ..moveTo(0, -radius * 0.85)
      ..lineTo(-6, -radius * 0.55)
      ..lineTo(6, -radius * 0.55)
      ..close();
    canvas.drawPath(headPath, Paint()..color = kAccentStylus);
    canvas.restore();

    // Origin marker
    canvas.drawCircle(
      Offset(cx, cy),
      2.2,
      Paint()..color = kInkDeep,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// RELATED TYPES SECTION — a flow from AndroidMotionEvent to its inner lists.
// ---------------------------------------------------------------------------

class RelatedTypesSection extends StatelessWidget {
  const RelatedTypesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'Related types',
      subtitle:
          'AndroidPointerProperties never travels alone. It shows up inside '
          'AndroidMotionEvent alongside parallel AndroidPointerCoords entries.',
      accent: kAndroidGreenDark,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kPaper,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kPaperDim),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: TypeBox(
                    title: 'AndroidMotionEvent',
                    fields: [
                      'downTime: int',
                      'eventTime: int',
                      'action: int',
                      'pointerCount: int',
                      'pointerProperties: List<AndroidPointerProperties>',
                      'pointerCoords: List<AndroidPointerCoords>',
                      'metaState: int',
                      'buttonState: int',
                      'xPrecision: double',
                      'yPrecision: double',
                      'deviceId: int',
                      'edgeFlags: int',
                      'source: int',
                      'flags: int',
                      'motionEventId: int?',
                    ],
                    color: kAndroidGreenDark,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    children: [
                      TypeBox(
                        title: 'AndroidPointerProperties',
                        fields: const [
                          'id: int',
                          'toolType: int',
                        ],
                        color: kAccentFinger,
                      ),
                      const SizedBox(height: 12),
                      TypeBox(
                        title: 'AndroidPointerCoords',
                        fields: const [
                          'orientation: double',
                          'pressure: double',
                          'size: double',
                          'toolMajor: double',
                          'toolMinor: double',
                          'touchMajor: double',
                          'touchMinor: double',
                          'x: double',
                          'y: double',
                        ],
                        color: kAccentStylus,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Both list fields are parallel: pointerProperties[i] describes '
              'the same logical pointer as pointerCoords[i].',
              style: TextStyle(
                color: kInkSoft,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TypeBox extends StatelessWidget {
  const TypeBox({
    super.key,
    required this.title,
    required this.fields,
    required this.color,
  });

  final String title;
  final List<String> fields;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: color,
            ),
          ),
          const Divider(height: 14),
          ...fields.map(
            (f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Text(
                f,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: kInkSoft,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CROSS-PLATFORM MAPPING SECTION — Android tool types -> Flutter PointerEvent.
// ---------------------------------------------------------------------------

class CrossPlatformMappingSection extends StatelessWidget {
  const CrossPlatformMappingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = <_MappingRow>[
      const _MappingRow(
        toolType: kToolTypeUnknown,
        flutterKind: 'PointerDeviceKind.unknown',
        notes:
            'Defensive fallback — treat as low-confidence input.',
      ),
      const _MappingRow(
        toolType: kToolTypeFinger,
        flutterKind: 'PointerDeviceKind.touch',
        notes:
            'The standard finger touch path. Pressure may be reported.',
      ),
      const _MappingRow(
        toolType: kToolTypeStylus,
        flutterKind: 'PointerDeviceKind.stylus',
        notes:
            'Stylus path; orientation and tilt forwarded to the framework.',
      ),
      const _MappingRow(
        toolType: kToolTypeMouse,
        flutterKind: 'PointerDeviceKind.mouse',
        notes:
            'Hover events surface as PointerHoverEvent in Flutter.',
      ),
      const _MappingRow(
        toolType: kToolTypeEraser,
        flutterKind: 'PointerDeviceKind.invertedStylus',
        notes:
            'Same physical pen, but exposed as inverted on the framework side.',
      ),
    ];
    return SectionContainer(
      title: 'Cross-platform mapping',
      subtitle:
          'How Flutter\'s engine maps each Android toolType into the framework\'s '
          'PointerEvent.kind values.',
      accent: kAccentMouse,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPaper,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kPaperDim),
            ),
            child: Column(
              children: [
                const _MappingHeader(),
                ...rows.map((r) => _MappingTile(row: r)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MappingHeader extends StatelessWidget {
  const _MappingHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: kInkSoft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 42,
            child: Text(
              '#',
              style: TextStyle(
                color: kPaper,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              'TOOL_TYPE_*',
              style: TextStyle(
                color: kPaper,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              'PointerDeviceKind',
              style: TextStyle(
                color: kPaper,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'notes',
              style: TextStyle(
                color: kPaper,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MappingTile extends StatelessWidget {
  const _MappingTile({required this.row});
  final _MappingRow row;

  @override
  Widget build(BuildContext context) {
    final color = toolTypeColor(row.toolType);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: kPaperDim),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 42,
            child: Text(
              row.toolType.toString(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                color: color,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              toolTypeLabel(row.toolType),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: kInkDeep,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              row.flutterKind,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.notes,
              style: const TextStyle(
                fontSize: 12,
                color: kInkSoft,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MappingRow {
  const _MappingRow({
    required this.toolType,
    required this.flutterKind,
    required this.notes,
  });

  final int toolType;
  final String flutterKind;
  final String notes;
}

// ---------------------------------------------------------------------------
// SYNTHETIC MOTION RECIPE SECTION — full code listing for an event.
// ---------------------------------------------------------------------------

class SyntheticMotionRecipeSection extends StatelessWidget {
  const SyntheticMotionRecipeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'Recipe — synthetic AndroidMotionEvent',
      subtitle:
          'How to assemble a two-finger DOWN event for an AndroidViewController '
          'replay path. Note the parallel lists and the matching count.',
      accent: kAndroidGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          CodeBlock(
            code:
                'final pointers = <AndroidPointerProperties>[\n'
                '  AndroidPointerProperties(id: 0, toolType: 1), // finger\n'
                '  AndroidPointerProperties(id: 1, toolType: 1), // finger\n'
                '];\n'
                '\n'
                'final coords = <AndroidPointerCoords>[\n'
                '  AndroidPointerCoords(\n'
                '    orientation: 0.0, pressure: 0.5, size: 0.4,\n'
                '    toolMajor: 14, toolMinor: 12,\n'
                '    touchMajor: 18, touchMinor: 17,\n'
                '    x: 240, y: 360,\n'
                '  ),\n'
                '  AndroidPointerCoords(\n'
                '    orientation: 0.0, pressure: 0.5, size: 0.5,\n'
                '    toolMajor: 16, toolMinor: 14,\n'
                '    touchMajor: 22, touchMinor: 19,\n'
                '    x: 410, y: 720,\n'
                '  ),\n'
                '];\n'
                '\n'
                'final event = AndroidMotionEvent(\n'
                '  downTime: 0,\n'
                '  eventTime: 16,\n'
                '  action: 0,            // ACTION_DOWN\n'
                '  pointerCount: pointers.length,\n'
                '  pointerProperties: pointers,\n'
                '  pointerCoords: coords,\n'
                '  metaState: 0,\n'
                '  buttonState: 0,\n'
                '  xPrecision: 1.0,\n'
                '  yPrecision: 1.0,\n'
                '  deviceId: 0,\n'
                '  edgeFlags: 0,\n'
                '  source: 0,\n'
                '  flags: 0,\n'
                ');',
          ),
          SizedBox(height: 14),
          Text(
            'pointerProperties.length must equal pointerCoords.length must '
            'equal pointerCount, otherwise the engine refuses to forward the '
            'event.',
            style: TextStyle(
              color: kInkSoft,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PITFALLS SECTION
// ---------------------------------------------------------------------------

class PitfallsSection extends StatelessWidget {
  const PitfallsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_Pitfall>[
      const _Pitfall(
        title: 'id is an index, not an identity',
        description:
            'Android reuses pointer ids after release. Treat them as a slot '
            'number, not a fingerprint of a specific finger.',
        icon: Icons.swap_horiz_rounded,
        color: kAccentFinger,
      ),
      const _Pitfall(
        title: 'toolType is just an int',
        description:
            'Always compare against named constants like TOOL_TYPE_STYLUS '
            'instead of the literal number, even though both are equivalent.',
        icon: Icons.code_rounded,
        color: kAccentStylus,
      ),
      const _Pitfall(
        title: 'Eraser swaps id',
        description:
            'Flipping a pen often closes the stylus pointer and opens a new '
            'eraser one with a fresh id. Don\'t assume continuity.',
        icon: Icons.auto_fix_off_rounded,
        color: kAccentEraser,
      ),
      const _Pitfall(
        title: 'pointerCoords[i] is parallel',
        description:
            'pointerProperties[i] and pointerCoords[i] always describe the '
            'same logical pointer for index i.',
        icon: Icons.format_list_numbered_rounded,
        color: kAccentMouse,
      ),
      const _Pitfall(
        title: 'orientation is in radians',
        description:
            'AndroidPointerCoords.orientation is radians, not degrees. Convert '
            'before showing values to humans.',
        icon: Icons.rotate_right_rounded,
        color: kAndroidGreenDark,
      ),
      const _Pitfall(
        title: 'Mouse hover has pressure 0',
        description:
            'A hovering mouse still produces events but with zero pressure. '
            'Don\'t use pressure as a "is the button down" check.',
        icon: Icons.mouse_rounded,
        color: kAccentMouse,
      ),
    ];
    return SectionContainer(
      title: 'Pitfalls',
      subtitle:
          'Six recurring traps when authoring or interpreting AndroidPointerProperties data.',
      accent: kAccentEraser,
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: items.map((p) => PitfallCard(item: p)).toList(),
      ),
    );
  }
}

class PitfallCard extends StatelessWidget {
  const PitfallCard({super.key, required this.item});
  final _Pitfall item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: item.color.withValues(alpha: 0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, color: item.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: item.color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: const TextStyle(
                    color: kInkSoft,
                    fontSize: 12,
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
}

class _Pitfall {
  const _Pitfall({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

// ---------------------------------------------------------------------------
// FOOTER SECTION
// ---------------------------------------------------------------------------

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kInkDeep,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kAndroidGreen.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.android_rounded,
              color: kAndroidGreen,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AndroidPointerProperties — visual deep demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hand-authored fixture for the analyzer-free interpreter '
                  'corpus. No async, no controllers, no setState — just a '
                  'long, deliberate widget tree.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              TagPill(text: 'services.dart', color: kAndroidGreen),
              SizedBox(height: 6),
              TagPill(text: 'platform_views', color: kAccentStylus),
            ],
          ),
        ],
      ),
    );
  }
}
