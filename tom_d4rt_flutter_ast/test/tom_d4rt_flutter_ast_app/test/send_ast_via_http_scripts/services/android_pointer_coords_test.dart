// Deep visual demo for AndroidPointerCoords / PointerData / PointerEvent.
// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Theme constants — "Stylus pipeline reference card" palette
// ---------------------------------------------------------------------------

const Color kInkDeep = Color(0xFF0B1020);
const Color kInkMid = Color(0xFF14203A);
const Color kInkSoft = Color(0xFF1E2C4A);
const Color kPaper = Color(0xFFF4F6FB);
const Color kPaperDim = Color(0xFFE2E7F2);
const Color kPaperEdge = Color(0xFFC8D0E0);
const Color kAccentStylus = Color(0xFF3D7BD6);
const Color kAccentStylusDeep = Color(0xFF1F4FA8);
const Color kAccentEraser = Color(0xFFEF5A6F);
const Color kAccentFinger = Color(0xFFE7A33A);
const Color kAccentMouse = Color(0xFF8B5CF6);
const Color kAccentInverted = Color(0xFF26B79A);
const Color kAccentGrid = Color(0xFFB7C2D6);
const Color kAccentWarn = Color(0xFFE0B341);
const Color kAccentInfo = Color(0xFF5A9DF0);
const Color kAccentSuccess = Color(0xFF2EAA75);
const Color kAccentDanger = Color(0xFFD8424F);
const Color kAccentDim = Color(0xFF6B7794);

const double kCard = 18.0;
const double kPad = 16.0;
const double kGap = 12.0;

const TextStyle kHeadline = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w800,
  color: kPaper,
  letterSpacing: -0.5,
);

const TextStyle kTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: kInkDeep,
  letterSpacing: -0.2,
);

const TextStyle kSubtitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kAccentDim,
  letterSpacing: 0.4,
);

const TextStyle kBody = TextStyle(
  fontSize: 13.5,
  height: 1.45,
  color: kInkMid,
);

const TextStyle kMono = TextStyle(
  fontFamily: "monospace",
  fontSize: 12,
  color: kInkSoft,
  height: 1.4,
);

const TextStyle kMonoLight = TextStyle(
  fontFamily: "monospace",
  fontSize: 11.5,
  color: kAccentDim,
);

const TextStyle kLabel = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: kAccentDim,
  letterSpacing: 1.2,
);

const TextStyle kChip = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: kPaper,
  letterSpacing: 0.6,
);

// ---------------------------------------------------------------------------
// Pointer / tool type constants — mirrors Android MotionEvent toolType ints.
// ---------------------------------------------------------------------------

const int kToolTypeUnknown = 0;
const int kToolTypeFinger = 1;
const int kToolTypeStylus = 2;
const int kToolTypeMouse = 3;
const int kToolTypeEraser = 4;
const int kToolTypeInverted = 5;

String toolTypeLabel(int t) {
  switch (t) {
    case kToolTypeFinger:
      return "TOOL_TYPE_FINGER";
    case kToolTypeStylus:
      return "TOOL_TYPE_STYLUS";
    case kToolTypeMouse:
      return "TOOL_TYPE_MOUSE";
    case kToolTypeEraser:
      return "TOOL_TYPE_ERASER";
    case kToolTypeInverted:
      return "TOOL_TYPE_INVERTED";
    default:
      return "TOOL_TYPE_UNKNOWN";
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
    case kToolTypeInverted:
      return kAccentInverted;
    default:
      return kAccentDim;
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
    case kToolTypeInverted:
      return Icons.flip_camera_android_rounded;
    default:
      return Icons.help_outline_rounded;
  }
}

// ---------------------------------------------------------------------------
// Sample pointer record — pre-computed mock data; no live input
// ---------------------------------------------------------------------------

class PointerSample {
  const PointerSample({
    required this.label,
    required this.toolType,
    required this.x,
    required this.y,
    required this.pressure,
    required this.size,
    required this.orientation,
    required this.tilt,
    required this.distance,
    required this.touchMajor,
    required this.touchMinor,
    required this.toolMajor,
    required this.toolMinor,
    required this.note,
  });

  final String label;
  final int toolType;
  final double x;
  final double y;
  final double pressure;
  final double size;
  final double orientation;
  final double tilt;
  final double distance;
  final double touchMajor;
  final double touchMinor;
  final double toolMajor;
  final double toolMinor;
  final String note;
}

const List<PointerSample> kSamples = <PointerSample>[
  PointerSample(
    label: "Finger tap",
    toolType: kToolTypeFinger,
    x: 412.3,
    y: 678.9,
    pressure: 0.62,
    size: 0.41,
    orientation: 0.0,
    tilt: 0.0,
    distance: 0.0,
    touchMajor: 28.4,
    touchMinor: 22.1,
    toolMajor: 24.0,
    toolMinor: 19.2,
    note: "Capacitive contact, near-circular ellipse",
  ),
  PointerSample(
    label: "Stylus press",
    toolType: kToolTypeStylus,
    x: 540.0,
    y: 312.0,
    pressure: 0.81,
    size: 0.18,
    orientation: 0.61,
    tilt: 0.34,
    distance: 0.0,
    touchMajor: 5.1,
    touchMinor: 5.0,
    toolMajor: 4.6,
    toolMinor: 4.5,
    note: "Active pen on glass, tilt south-east",
  ),
  PointerSample(
    label: "Stylus hover",
    toolType: kToolTypeStylus,
    x: 540.2,
    y: 308.4,
    pressure: 0.0,
    size: 0.06,
    orientation: 0.59,
    tilt: 0.36,
    distance: 18.0,
    touchMajor: 0.0,
    touchMinor: 0.0,
    toolMajor: 3.8,
    toolMinor: 3.6,
    note: "Above-surface hover; distance>0, pressure=0",
  ),
  PointerSample(
    label: "Eraser drag",
    toolType: kToolTypeEraser,
    x: 220.0,
    y: 410.5,
    pressure: 0.55,
    size: 0.34,
    orientation: -1.21,
    tilt: 0.42,
    distance: 0.0,
    touchMajor: 18.0,
    touchMinor: 14.0,
    toolMajor: 16.2,
    toolMinor: 12.4,
    note: "Pen flipped — button + tilt reversed",
  ),
  PointerSample(
    label: "Mouse click",
    toolType: kToolTypeMouse,
    x: 1024.0,
    y: 200.0,
    pressure: 1.0,
    size: 0.0,
    orientation: 0.0,
    tilt: 0.0,
    distance: 0.0,
    touchMajor: 0.0,
    touchMinor: 0.0,
    toolMajor: 0.0,
    toolMinor: 0.0,
    note: "Indirect device — coords from cursor, not contact",
  ),
  PointerSample(
    label: "Inverted pen",
    toolType: kToolTypeInverted,
    x: 612.4,
    y: 488.1,
    pressure: 0.48,
    size: 0.22,
    orientation: 2.11,
    tilt: 0.51,
    distance: 0.0,
    touchMajor: 7.3,
    touchMinor: 7.1,
    toolMajor: 6.8,
    toolMinor: 6.5,
    note: "Pen held tip-up, eraser end down",
  ),
];

// ---------------------------------------------------------------------------
// Top-level build entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Android Pointer Coords — Visual Reference",
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: kPaper,
      fontFamily: "Roboto",
    ),
    home: Scaffold(
      backgroundColor: kPaper,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _IntroSection(),
            SizedBox(height: 24),
            _PointerAnatomySection(),
            SizedBox(height: 24),
            _PressureCurvesSection(),
            SizedBox(height: 24),
            _TiltGeometrySection(),
            SizedBox(height: 24),
            _ToolTypeMatrixSection(),
            SizedBox(height: 24),
            _EventFlowSection(),
            SizedBox(height: 24),
            _CoordsTableSection(),
            SizedBox(height: 24),
            _OrientationGlyphSection(),
            SizedBox(height: 24),
            _QuirksPanelSection(),
            SizedBox(height: 24),
            _AccessibilitySection(),
            SizedBox(height: 24),
            _FooterSection(),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — INTRO HERO
// ===========================================================================

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(28, 26, 28, 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kCard + 4),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kInkDeep,
            kInkMid,
            kAccentStylusDeep,
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInkDeep.withValues(alpha: 0.45),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: kAccentStylus.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: kAccentStylus.withValues(alpha: 0.55),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "REFERENCE CARD",
                        style: kChip.copyWith(color: kAccentStylus),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: kPaper.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "FLUTTER 3.27+",
                        style: kChip,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Text(
                  "Android Pointer Coords",
                  style: kHeadline,
                ),
                SizedBox(height: 6),
                Text(
                  "From raw MotionEvent samples to Flutter PointerEvent",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kPaper.withValues(alpha: 0.78),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "This is a static, hand-painted reference of every value an Android pointer event carries before Flutter's PointerEventConverter normalises it: position, pressure, tilt, orientation, tool ellipse, and tool type. No live sensors — every number is a curated mock.",
                  style: TextStyle(
                    fontSize: 13.5,
                    color: kPaper.withValues(alpha: 0.86),
                    height: 1.55,
                  ),
                ),
                SizedBox(height: 22),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    _HeroStat(label: "FIELDS", value: "13"),
                    _HeroStat(label: "TOOL TYPES", value: "6"),
                    _HeroStat(label: "SAMPLES", value: "6"),
                    _HeroStat(label: "RADIANS", value: "−π..π"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 22),
          Expanded(
            flex: 5,
            child: _HeroDiagram(),
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPaper.withValues(alpha: 0.08),
        border: Border.all(
          color: kPaper.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: kLabel.copyWith(color: kPaper.withValues(alpha: 0.7)),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: kPaper,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroDiagram extends StatelessWidget {
  const _HeroDiagram();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.05,
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kCard),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              kInkMid.withValues(alpha: 0.9),
              kInkSoft.withValues(alpha: 0.75),
            ],
          ),
          border: Border.all(
            color: kAccentStylus.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: _GridBackdrop()),
            Positioned(
              left: 30,
              top: 30,
              child: _ContactEllipse(
                color: kAccentStylus,
                major: 70,
                minor: 22,
                angle: 0.55,
              ),
            ),
            Positioned(
              right: 18,
              bottom: 18,
              child: _ContactEllipse(
                color: kAccentFinger,
                major: 90,
                minor: 60,
                angle: -0.3,
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: _AxisBadge(label: "X", color: kAccentInfo),
            ),
            Positioned(
              left: 16,
              top: 60,
              child: RotatedBox(
                quarterTurns: 3,
                child: _AxisBadge(label: "Y", color: kAccentSuccess),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: kAccentStylus.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text("CONTACT ELLIPSE", style: kChip.copyWith(fontSize: 9)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridBackdrop extends StatelessWidget {
  const _GridBackdrop();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(8, (int row) {
        return Expanded(
          child: Row(
            children: List<Widget>.generate(8, (int col) {
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: kAccentGrid.withValues(alpha: 0.10),
                        width: 0.5,
                      ),
                      bottom: BorderSide(
                        color: kAccentGrid.withValues(alpha: 0.10),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

class _ContactEllipse extends StatelessWidget {
  const _ContactEllipse({
    required this.color,
    required this.major,
    required this.minor,
    required this.angle,
  });
  final Color color;
  final double major;
  final double minor;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: major,
        height: minor,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(major / 2),
          gradient: RadialGradient(
            colors: <Color>[
              color.withValues(alpha: 0.85),
              color.withValues(alpha: 0.10),
            ],
          ),
          border: Border.all(
            color: color.withValues(alpha: 0.9),
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class _AxisBadge extends StatelessWidget {
  const _AxisBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color, width: 1.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 2 — POINTER ANATOMY (field-by-field exploded view)
// ===========================================================================

class _PointerAnatomySection extends StatelessWidget {
  const _PointerAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "ANATOMY",
      title: "Inside a single PointerCoords sample",
      blurb: "Every Android MotionEvent carries one PointerCoords per active pointer. These are the 9 numbers in that record (plus the index/id from PointerProperties).",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _AnatomyDiagram(),
          SizedBox(height: 22),
          _FieldGrid(),
        ],
      ),
    );
  }
}

class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kCard),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kPaperDim,
            kPaper,
          ],
        ),
        border: Border.all(color: kPaperEdge, width: 1),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Outer dashed circle = tool ellipse
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kAccentMouse.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                ),
                // touch ellipse
                Transform.rotate(
                  angle: 0.6,
                  child: Container(
                    width: 160,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      gradient: RadialGradient(
                        colors: <Color>[
                          kAccentStylus.withValues(alpha: 0.55),
                          kAccentStylus.withValues(alpha: 0.05),
                        ],
                      ),
                      border: Border.all(
                        color: kAccentStylus,
                        width: 1.6,
                      ),
                    ),
                  ),
                ),
                // contact dot
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kAccentDanger,
                    border: Border.all(color: kPaper, width: 2),
                  ),
                ),
                // (x,y) label
                Positioned(
                  left: 110,
                  top: 90,
                  child: _AnnotationDot(label: "(x, y)", color: kAccentDanger),
                ),
                Positioned(
                  right: 20,
                  top: 30,
                  child: _AnnotationDot(label: "toolMajor", color: kAccentMouse),
                ),
                Positioned(
                  left: 14,
                  bottom: 14,
                  child: _AnnotationDot(label: "touchMajor", color: kAccentStylus),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _Legend(color: kAccentDanger, label: "(x, y)", desc: "device pixel position"),
                SizedBox(height: 10),
                _Legend(color: kAccentStylus, label: "touchMajor/Minor", desc: "skin/stylus contact ellipse"),
                SizedBox(height: 10),
                _Legend(color: kAccentMouse, label: "toolMajor/Minor", desc: "tool footprint ellipse"),
                SizedBox(height: 10),
                _Legend(color: kAccentSuccess, label: "orientation", desc: "ellipse rotation in radians"),
                SizedBox(height: 10),
                _Legend(color: kAccentWarn, label: "pressure / size", desc: "force estimate (0..1)"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnotationDot extends StatelessWidget {
  const _AnnotationDot({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: kPaper,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label, required this.desc});
  final Color color;
  final String label;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 4),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: kBody,
              children: <TextSpan>[
                TextSpan(
                  text: label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kInkDeep,
                    fontFamily: "monospace",
                    fontSize: 12,
                  ),
                ),
                TextSpan(text: "  —  " + desc),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FieldGrid extends StatelessWidget {
  const _FieldGrid();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        _FieldCard(
          name: "x",
          unit: "device px",
          range: "0..screenW",
          color: kAccentInfo,
          icon: Icons.swap_horiz_rounded,
          blurb: "Horizontal coordinate in device pixels, post any orientation transform applied by the windowing layer.",
        ),
        _FieldCard(
          name: "y",
          unit: "device px",
          range: "0..screenH",
          color: kAccentSuccess,
          icon: Icons.swap_vert_rounded,
          blurb: "Vertical coordinate. Y grows downward on Android, matching framebuffer convention.",
        ),
        _FieldCard(
          name: "pressure",
          unit: "normalised",
          range: "0.0..1.0",
          color: kAccentWarn,
          icon: Icons.water_drop_rounded,
          blurb: "Estimated force. For capacitive panels often derived from contact area. 1.0 means \"saturated\".",
        ),
        _FieldCard(
          name: "size",
          unit: "normalised",
          range: "0.0..1.0",
          color: kAccentEraser,
          icon: Icons.adjust_rounded,
          blurb: "Approximate scaled contact size. Less precise than the explicit ellipse fields below.",
        ),
        _FieldCard(
          name: "orientation",
          unit: "radians",
          range: "−π/2..π/2",
          color: kAccentStylus,
          icon: Icons.rotate_right_rounded,
          blurb: "Rotation of the touch ellipse. 0 means major-axis points along screen +Y.",
        ),
        _FieldCard(
          name: "tilt",
          unit: "radians",
          range: "0..π/2",
          color: kAccentMouse,
          icon: Icons.architecture_rounded,
          blurb: "Stylus tilt from the surface normal. 0 = perpendicular, π/2 = parallel to screen.",
        ),
        _FieldCard(
          name: "distance",
          unit: "device px",
          range: ">= 0",
          color: kAccentInverted,
          icon: Icons.height_rounded,
          blurb: "Hover distance for tools that report it. Non-zero distance + zero pressure = hover sample.",
        ),
        _FieldCard(
          name: "touchMajor",
          unit: "device px",
          range: ">= 0",
          color: kAccentStylusDeep,
          icon: Icons.crop_landscape_rounded,
          blurb: "Long axis of the contact patch ellipse. Pulled from MotionEvent.AXIS_TOUCH_MAJOR.",
        ),
        _FieldCard(
          name: "touchMinor",
          unit: "device px",
          range: ">= 0",
          color: kAccentStylus,
          icon: Icons.crop_portrait_rounded,
          blurb: "Short axis of the contact ellipse. Always <= touchMajor by definition.",
        ),
        _FieldCard(
          name: "toolMajor",
          unit: "device px",
          range: ">= 0",
          color: kAccentMouse,
          icon: Icons.expand_rounded,
          blurb: "Long axis of the tool footprint. Larger than touchMajor for fat fingers, smaller for styluses.",
        ),
        _FieldCard(
          name: "toolMinor",
          unit: "device px",
          range: ">= 0",
          color: kAccentEraser,
          icon: Icons.compress_rounded,
          blurb: "Short axis of the tool footprint. Pairs with toolMajor to describe pen vs finger shape.",
        ),
        _FieldCard(
          name: "toolType",
          unit: "enum int",
          range: "0..5",
          color: kAccentFinger,
          icon: Icons.category_rounded,
          blurb: "Tool family. Lives on AndroidPointerProperties but always travels with coords.",
        ),
      ],
    );
  }
}

class _FieldCard extends StatelessWidget {
  const _FieldCard({
    required this.name,
    required this.unit,
    required this.range,
    required this.color,
    required this.icon,
    required this.blurb,
  });

  final String name;
  final String unit;
  final String range;
  final Color color;
  final IconData icon;
  final String blurb;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.08),
            color.withValues(alpha: 0.18),
          ],
        ),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontFamily: "monospace",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kInkDeep,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              _MetaPill(label: unit, color: color),
              SizedBox(width: 6),
              _MetaPill(label: range, color: color),
            ],
          ),
          SizedBox(height: 10),
          Text(
            blurb,
            style: kBody.copyWith(fontSize: 12, color: kInkSoft, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: "monospace",
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// ===========================================================================
// Shared card shell used by most sections
// ===========================================================================

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.eyebrow,
    required this.title,
    required this.blurb,
    required this.child,
    this.accent = kAccentStylus,
  });

  final String eyebrow;
  final String title;
  final String blurb;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 22, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kCard + 2),
        color: kPaper,
        border: Border.all(color: kPaperEdge, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInkDeep.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 4,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 10),
              Text(
                eyebrow,
                style: kLabel.copyWith(color: accent),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(title, style: kTitle),
          SizedBox(height: 6),
          Text(blurb, style: kBody),
          SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 3 — PRESSURE CURVES
// ===========================================================================

class _PressureCurvesSection extends StatelessWidget {
  const _PressureCurvesSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "PRESSURE",
      accent: kAccentWarn,
      title: "Stylus pressure ramps",
      blurb: "Hand-drawn pressure profiles across the press-down phase of a stylus stroke. Each row is one stroke; the bars are sampled pressure values at successive timesteps. Numbers are mock data.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _PressureRow(
            name: "Soft sketch",
            color: kAccentInfo,
            curve: <double>[0.05, 0.10, 0.16, 0.20, 0.26, 0.30, 0.32, 0.28, 0.22, 0.14, 0.07, 0.02],
          ),
          SizedBox(height: 12),
          _PressureRow(
            name: "Linear ramp",
            color: kAccentStylus,
            curve: <double>[0.08, 0.16, 0.24, 0.32, 0.40, 0.48, 0.56, 0.64, 0.72, 0.80, 0.88, 0.96],
          ),
          SizedBox(height: 12),
          _PressureRow(
            name: "Quick stab",
            color: kAccentEraser,
            curve: <double>[0.10, 0.38, 0.72, 0.94, 0.98, 0.92, 0.70, 0.42, 0.18, 0.08, 0.04, 0.02],
          ),
          SizedBox(height: 12),
          _PressureRow(
            name: "Calligraphy hold",
            color: kAccentSuccess,
            curve: <double>[0.20, 0.45, 0.62, 0.70, 0.74, 0.76, 0.78, 0.77, 0.74, 0.70, 0.66, 0.60],
          ),
          SizedBox(height: 12),
          _PressureRow(
            name: "Tremor stroke",
            color: kAccentMouse,
            curve: <double>[0.32, 0.40, 0.34, 0.45, 0.38, 0.50, 0.41, 0.55, 0.44, 0.58, 0.49, 0.60],
          ),
          SizedBox(height: 18),
          _PressureLegend(),
        ],
      ),
    );
  }
}

class _PressureRow extends StatelessWidget {
  const _PressureRow({
    required this.name,
    required this.color,
    required this.curve,
  });
  final String name;
  final Color color;
  final List<double> curve;

  @override
  Widget build(BuildContext context) {
    final List<Widget> bars = <Widget>[];
    for (int i = 0; i < curve.length; i++) {
      final double v = curve[i];
      bars.add(Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 60 * v,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      color.withValues(alpha: 0.55),
                      color,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3),
              Text(
                v.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: "monospace",
                  fontSize: 8.5,
                  color: kAccentDim,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kPaperDim.withValues(alpha: 0.6),
        border: Border.all(color: kPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kInkDeep,
                ),
              ),
              SizedBox(width: 10),
              Text(
                curve.length.toString() + " samples",
                style: kMonoLight,
              ),
              Spacer(),
              Text(
                "max " + _maxOf(curve).toStringAsFixed(2),
                style: kMonoLight,
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 76,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars,
            ),
          ),
        ],
      ),
    );
  }

  double _maxOf(List<double> xs) {
    double m = 0.0;
    for (final double x in xs) {
      if (x > m) m = x;
    }
    return m;
  }
}

class _PressureLegend extends StatelessWidget {
  const _PressureLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kAccentWarn.withValues(alpha: 0.10),
            kAccentWarn.withValues(alpha: 0.04),
          ],
        ),
        border: Border.all(color: kAccentWarn.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.info_rounded, size: 18, color: kAccentWarn),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Android reports pressure as a normalised float. Capacitive panels often clamp or saturate near 1.0; styluses use force sensors and can produce smooth, monotonic ramps. Flutter's PointerEvent.pressure preserves the same scale.",
              style: kBody.copyWith(color: kInkSoft),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4 — TILT GEOMETRY
// ===========================================================================

class _TiltGeometrySection extends StatelessWidget {
  const _TiltGeometrySection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "TILT GEOMETRY",
      accent: kAccentMouse,
      title: "Stylus tilt — direction and magnitude",
      blurb: "Tilt is reported as one scalar (the angle off-normal). Orientation tells you which compass direction the pen is leaning toward. These chevrons illustrate eight cardinal tilt directions.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _TiltCompass(),
          SizedBox(height: 18),
          _TiltMagnitudeRow(),
        ],
      ),
    );
  }
}

class _TiltCompass extends StatelessWidget {
  const _TiltCompass();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kCard),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            kInkDeep,
            kInkMid,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kAccentMouse.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
          ),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kAccentMouse.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kAccentMouse.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          _CompassRay(angle: 0.0, label: "0", magnitude: 0.45),
          _CompassRay(angle: 0.785, label: "π/4", magnitude: 0.35),
          _CompassRay(angle: 1.57, label: "π/2", magnitude: 0.55),
          _CompassRay(angle: 2.355, label: "3π/4", magnitude: 0.40),
          _CompassRay(angle: 3.14, label: "π", magnitude: 0.50),
          _CompassRay(angle: -2.355, label: "−3π/4", magnitude: 0.30),
          _CompassRay(angle: -1.57, label: "−π/2", magnitude: 0.42),
          _CompassRay(angle: -0.785, label: "−π/4", magnitude: 0.38),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kAccentMouse,
              border: Border.all(color: kPaper, width: 2),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompassRay extends StatelessWidget {
  const _CompassRay({
    required this.angle,
    required this.label,
    required this.magnitude,
  });
  final double angle;
  final String label;
  final double magnitude;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 200,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 70 * magnitude,
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    kAccentMouse.withValues(alpha: 0.1),
                    kAccentMouse,
                  ],
                ),
              ),
            ),
            SizedBox(width: 4),
            Transform.rotate(
              angle: -angle,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: kAccentMouse.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: "monospace",
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: kPaper,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TiltMagnitudeRow extends StatelessWidget {
  const _TiltMagnitudeRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: _TiltCell(deg: 0, label: "Perpendicular", desc: "Pen straight up; no tilt component.")),
        SizedBox(width: 12),
        Expanded(child: _TiltCell(deg: 15, label: "Comfortable", desc: "Typical handwriting grip; gentle lean.")),
        SizedBox(width: 12),
        Expanded(child: _TiltCell(deg: 35, label: "Shading", desc: "Side-of-tip stroke for soft shading effects.")),
        SizedBox(width: 12),
        Expanded(child: _TiltCell(deg: 60, label: "Extreme", desc: "Near-flat; reported but rarely physical.")),
      ],
    );
  }
}

class _TiltCell extends StatelessWidget {
  const _TiltCell({required this.deg, required this.label, required this.desc});
  final int deg;
  final String label;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final double rad = deg * 3.1415926 / 180.0;
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kPaperDim,
            kPaper,
          ],
        ),
        border: Border.all(color: kPaperEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 38,
                height: 38,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: 38,
                      height: 2,
                      color: kAccentGrid,
                    ),
                    Transform.rotate(
                      angle: -rad,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 3,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              kAccentStylusDeep,
                              kAccentStylus,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    deg.toString() + "°",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: kInkDeep,
                      fontFamily: "monospace",
                    ),
                  ),
                  Text(label, style: kSubtitle.copyWith(fontSize: 11)),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(desc, style: kBody.copyWith(fontSize: 11.5)),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 5 — TOOL TYPE MATRIX
// ===========================================================================

class _ToolTypeMatrixSection extends StatelessWidget {
  const _ToolTypeMatrixSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "TOOL TYPES",
      accent: kAccentFinger,
      title: "What each tool reports — comparison matrix",
      blurb: "Different input devices populate different fields. A stylus carries tilt; a mouse skips touch ellipse fields entirely. Use this table to know which values to trust.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _ToolMatrixHeader(),
          _ToolMatrixRow(
            toolType: kToolTypeFinger,
            pressure: _Cell.full("0.1..1.0"),
            ellipse: _Cell.full("large"),
            tilt: _Cell.none(),
            distance: _Cell.none(),
            hover: _Cell.none(),
          ),
          _ToolMatrixRow(
            toolType: kToolTypeStylus,
            pressure: _Cell.full("0.0..1.0"),
            ellipse: _Cell.full("small"),
            tilt: _Cell.full("0..π/2"),
            distance: _Cell.full("hover px"),
            hover: _Cell.full("yes"),
          ),
          _ToolMatrixRow(
            toolType: kToolTypeEraser,
            pressure: _Cell.full("0.0..1.0"),
            ellipse: _Cell.full("small"),
            tilt: _Cell.full("0..π/2"),
            distance: _Cell.full("hover px"),
            hover: _Cell.full("yes"),
          ),
          _ToolMatrixRow(
            toolType: kToolTypeMouse,
            pressure: _Cell.partial("1.0 or 0"),
            ellipse: _Cell.none(),
            tilt: _Cell.none(),
            distance: _Cell.none(),
            hover: _Cell.partial("via move"),
          ),
          _ToolMatrixRow(
            toolType: kToolTypeInverted,
            pressure: _Cell.full("0.0..1.0"),
            ellipse: _Cell.full("medium"),
            tilt: _Cell.full("0..π/2"),
            distance: _Cell.full("hover px"),
            hover: _Cell.full("yes"),
          ),
          _ToolMatrixRow(
            toolType: kToolTypeUnknown,
            pressure: _Cell.partial("often 1"),
            ellipse: _Cell.none(),
            tilt: _Cell.none(),
            distance: _Cell.none(),
            hover: _Cell.none(),
          ),
        ],
      ),
    );
  }
}

class _Cell {
  const _Cell({required this.symbol, required this.note, required this.color});
  final IconData symbol;
  final String note;
  final Color color;

  factory _Cell.full(String note) {
    return _Cell(
      symbol: Icons.check_circle_rounded,
      note: note,
      color: kAccentSuccess,
    );
  }
  factory _Cell.partial(String note) {
    return _Cell(
      symbol: Icons.error_rounded,
      note: note,
      color: kAccentWarn,
    );
  }
  factory _Cell.none() {
    return _Cell(
      symbol: Icons.remove_circle_outline_rounded,
      note: "—",
      color: kAccentDim,
    );
  }
}

class _ToolMatrixHeader extends StatelessWidget {
  const _ToolMatrixHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kInkDeep,
            kInkMid,
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 4, child: Text("Tool", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 3, child: Text("Pressure", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 3, child: Text("Ellipse", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 3, child: Text("Tilt", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 3, child: Text("Distance", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 3, child: Text("Hover", style: kLabel.copyWith(color: kPaper))),
        ],
      ),
    );
  }
}

class _ToolMatrixRow extends StatelessWidget {
  const _ToolMatrixRow({
    required this.toolType,
    required this.pressure,
    required this.ellipse,
    required this.tilt,
    required this.distance,
    required this.hover,
  });

  final int toolType;
  final _Cell pressure;
  final _Cell ellipse;
  final _Cell tilt;
  final _Cell distance;
  final _Cell hover;

  @override
  Widget build(BuildContext context) {
    final Color c = toolTypeColor(toolType);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kPaperEdge, width: 1),
          left: BorderSide(color: kPaperEdge, width: 1),
          right: BorderSide(color: kPaperEdge, width: 1),
        ),
        color: kPaper,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(toolTypeIcon(toolType), size: 14, color: c),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    toolTypeLabel(toolType),
                    style: TextStyle(
                      fontFamily: "monospace",
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: kInkDeep,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 3, child: _CellWidget(cell: pressure)),
          Expanded(flex: 3, child: _CellWidget(cell: ellipse)),
          Expanded(flex: 3, child: _CellWidget(cell: tilt)),
          Expanded(flex: 3, child: _CellWidget(cell: distance)),
          Expanded(flex: 3, child: _CellWidget(cell: hover)),
        ],
      ),
    );
  }
}

class _CellWidget extends StatelessWidget {
  const _CellWidget({required this.cell});
  final _Cell cell;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(cell.symbol, size: 14, color: cell.color),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            cell.note,
            style: TextStyle(
              fontFamily: "monospace",
              fontSize: 11,
              color: cell.color == kAccentDim ? kAccentDim : kInkSoft,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 6 — EVENT FLOW (boxes + arrows journey diagram)
// ===========================================================================

class _EventFlowSection extends StatelessWidget {
  const _EventFlowSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "EVENT JOURNEY",
      accent: kAccentInfo,
      title: "From hardware sample to PointerEvent",
      blurb: "An Android touch sample crosses many layers before a Flutter widget sees it. Each box is one transformation; arrows show data flow.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _FlowStage(
            num: "1",
            color: kAccentDanger,
            title: "Driver / HAL",
            blurb: "Touch IC fires interrupt. Linux input driver maps raw values to MotionEvent axes.",
            icon: Icons.developer_board_rounded,
          ),
          _FlowArrow(label: "raw axes"),
          _FlowStage(
            num: "2",
            color: kAccentEraser,
            title: "InputDispatcher",
            blurb: "Native dispatcher batches samples and routes them to the focused window.",
            icon: Icons.alt_route_rounded,
          ),
          _FlowArrow(label: "MotionEvent"),
          _FlowStage(
            num: "3",
            color: kAccentWarn,
            title: "FlutterView (JVM)",
            blurb: "Decodes MotionEvent into a PointerData buffer; bundles toolType, pressure, tilt, ellipse.",
            icon: Icons.layers_rounded,
          ),
          _FlowArrow(label: "PointerData[]"),
          _FlowStage(
            num: "4",
            color: kAccentSuccess,
            title: "Engine (C++)",
            blurb: "Forwards the packet to the Dart isolate via the platform message channel.",
            icon: Icons.memory_rounded,
          ),
          _FlowArrow(label: "ui.PointerDataPacket"),
          _FlowStage(
            num: "5",
            color: kAccentStylus,
            title: "PointerEventConverter",
            blurb: "Normalises units (px → logical px, radians stay), recognises device kind, emits PointerEvents.",
            icon: Icons.transform_rounded,
          ),
          _FlowArrow(label: "PointerEvent"),
          _FlowStage(
            num: "6",
            color: kAccentMouse,
            title: "GestureBinding / arena",
            blurb: "Hit-tests against the render tree; arena resolves which recognizer wins.",
            icon: Icons.sports_kabaddi_rounded,
          ),
          _FlowArrow(label: "callback"),
          _FlowStage(
            num: "7",
            color: kAccentInverted,
            title: "Widget callback",
            blurb: "onTap / onPanUpdate / Listener.onPointerMove fires with sanitised Flutter units.",
            icon: Icons.widgets_rounded,
          ),
        ],
      ),
    );
  }
}

class _FlowStage extends StatelessWidget {
  const _FlowStage({
    required this.num,
    required this.color,
    required this.title,
    required this.blurb,
    required this.icon,
  });
  final String num;
  final Color color;
  final String title;
  final String blurb;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            color.withValues(alpha: 0.08),
            color.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Text(
              num,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: kPaper,
              ),
            ),
          ),
          SizedBox(width: 14),
          Icon(icon, color: color, size: 22),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kInkDeep,
                  ),
                ),
                SizedBox(height: 3),
                Text(blurb, style: kBody.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  width: 2,
                  height: 14,
                  color: kAccentGrid,
                ),
                Icon(Icons.arrow_drop_down_rounded, color: kAccentGrid, size: 22),
              ],
            ),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: kPaperDim,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: kPaperEdge, width: 1),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: "monospace",
                fontSize: 10.5,
                color: kAccentDim,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7 — COORDS SAMPLE TABLE
// ===========================================================================

class _CoordsTableSection extends StatelessWidget {
  const _CoordsTableSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "SAMPLE TABLE",
      accent: kAccentStylusDeep,
      title: "Canned PointerCoords samples",
      blurb: "Six hand-curated samples — one per device class. These values are pre-computed mocks: no live input feeds this table.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SampleTableHeader(),
          for (final PointerSample s in kSamples) _SampleTableRow(sample: s),
          SizedBox(height: 14),
          _SampleTableFootnote(),
        ],
      ),
    );
  }
}

class _SampleTableHeader extends StatelessWidget {
  const _SampleTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kAccentStylusDeep,
            kInkMid,
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 5, child: Text("LABEL / TOOL", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 3, child: Text("X, Y", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 2, child: Text("PRESS", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 2, child: Text("ORIENT", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 2, child: Text("TILT", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 2, child: Text("DIST", style: kLabel.copyWith(color: kPaper))),
          Expanded(flex: 3, child: Text("ELLIPSE", style: kLabel.copyWith(color: kPaper))),
        ],
      ),
    );
  }
}

class _SampleTableRow extends StatelessWidget {
  const _SampleTableRow({required this.sample});
  final PointerSample sample;

  @override
  Widget build(BuildContext context) {
    final Color c = toolTypeColor(sample.toolType);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: kPaper,
        border: Border(
          left: BorderSide(color: kPaperEdge, width: 1),
          right: BorderSide(color: kPaperEdge, width: 1),
          bottom: BorderSide(color: kPaperEdge, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 26,
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                SizedBox(width: 10),
                Icon(toolTypeIcon(sample.toolType), color: c, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sample.label,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: kInkDeep,
                        ),
                      ),
                      Text(
                        toolTypeLabel(sample.toolType),
                        style: TextStyle(
                          fontFamily: "monospace",
                          fontSize: 9.5,
                          color: kAccentDim,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "(" + sample.x.toStringAsFixed(1) + ", " + sample.y.toStringAsFixed(1) + ")",
              style: kMono,
            ),
          ),
          Expanded(
            flex: 2,
            child: _ValueChip(value: sample.pressure.toStringAsFixed(2), color: kAccentWarn),
          ),
          Expanded(
            flex: 2,
            child: _ValueChip(value: sample.orientation.toStringAsFixed(2), color: kAccentStylus),
          ),
          Expanded(
            flex: 2,
            child: _ValueChip(value: sample.tilt.toStringAsFixed(2), color: kAccentMouse),
          ),
          Expanded(
            flex: 2,
            child: _ValueChip(value: sample.distance.toStringAsFixed(1), color: kAccentInverted),
          ),
          Expanded(
            flex: 3,
            child: Text(
              sample.touchMajor.toStringAsFixed(1) + " x " + sample.touchMinor.toStringAsFixed(1),
              style: kMono,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueChip extends StatelessWidget {
  const _ValueChip({required this.value, required this.color});
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: TextStyle(
          fontFamily: "monospace",
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _SampleTableFootnote extends StatelessWidget {
  const _SampleTableFootnote();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.lightbulb_rounded, size: 16, color: kAccentWarn),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            "Reading row 3: the stylus hover sample has pressure=0 but distance=18 — the canonical sign of a non-contact hover frame.",
            style: kBody.copyWith(fontSize: 12, color: kInkSoft, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 8 — ORIENTATION GLYPHS
// ===========================================================================

class _OrientationGlyphSection extends StatelessWidget {
  const _OrientationGlyphSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "ORIENTATION GLYPHS",
      accent: kAccentSuccess,
      title: "Ellipse rotation cheat-sheet",
      blurb: "Orientation is the angle of the touch ellipse's major axis relative to screen +Y. The glyphs below show ellipses at named angles.",
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          _OrientGlyph(angle: -1.57, label: "−π/2", note: "rotated 90° CCW"),
          _OrientGlyph(angle: -0.785, label: "−π/4", note: "leaning NW"),
          _OrientGlyph(angle: 0.0, label: "0", note: "aligned with +Y"),
          _OrientGlyph(angle: 0.393, label: "π/8", note: "slight NE lean"),
          _OrientGlyph(angle: 0.785, label: "π/4", note: "diagonal NE"),
          _OrientGlyph(angle: 1.178, label: "3π/8", note: "near horizontal"),
          _OrientGlyph(angle: 1.57, label: "π/2", note: "horizontal"),
          _OrientGlyph(angle: 2.356, label: "3π/4", note: "diagonal SE-flipped"),
        ],
      ),
    );
  }
}

class _OrientGlyph extends StatelessWidget {
  const _OrientGlyph({
    required this.angle,
    required this.label,
    required this.note,
  });
  final double angle;
  final String label;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.fromLTRB(10, 14, 10, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            kPaperDim,
            kPaper,
          ],
        ),
        border: Border.all(color: kPaperEdge, width: 1),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 76,
            child: Center(
              child: Transform.rotate(
                angle: angle,
                child: Container(
                  width: 76,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: RadialGradient(
                      colors: <Color>[
                        kAccentSuccess.withValues(alpha: 0.6),
                        kAccentSuccess.withValues(alpha: 0.05),
                      ],
                    ),
                    border: Border.all(color: kAccentSuccess, width: 1.4),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: "monospace",
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: kInkDeep,
            ),
          ),
          SizedBox(height: 4),
          Text(
            note,
            style: kSubtitle.copyWith(fontSize: 10.5, letterSpacing: 0.2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9 — QUIRKS PANEL
// ===========================================================================

class _QuirksPanelSection extends StatelessWidget {
  const _QuirksPanelSection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "QUIRKS",
      accent: kAccentDanger,
      title: "Things Android does that surprise people",
      blurb: "Real-world traps when you read PointerCoords directly. Each card is a gotcha plus what to do about it.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _QuirkCard(
            level: "WARN",
            color: kAccentWarn,
            icon: Icons.warning_amber_rounded,
            title: "Pressure 1.0 is not always physical",
            body: "Some panels saturate at the moment of finger-down. Treat 1.0 as \"at-least full\" rather than \"exactly full\".",
          ),
          SizedBox(height: 10),
          _QuirkCard(
            level: "WARN",
            color: kAccentDanger,
            icon: Icons.error_rounded,
            title: "Y grows down, not up",
            body: "Coordinates use framebuffer convention. A pointer at y=0 is at the top edge, not the bottom.",
          ),
          SizedBox(height: 10),
          _QuirkCard(
            level: "INFO",
            color: kAccentInfo,
            icon: Icons.info_rounded,
            title: "Mouse events skip ellipse fields",
            body: "TOOL_TYPE_MOUSE leaves touchMajor/Minor and toolMajor/Minor at zero. Don't read them.",
          ),
          SizedBox(height: 10),
          _QuirkCard(
            level: "WARN",
            color: kAccentWarn,
            icon: Icons.cyclone_rounded,
            title: "Orientation wraps at ±π/2",
            body: "Some devices clamp orientation to [−π/2, π/2]; an ellipse rotated past that is mirrored, not wrapped.",
          ),
          SizedBox(height: 10),
          _QuirkCard(
            level: "INFO",
            color: kAccentSuccess,
            icon: Icons.check_circle_rounded,
            title: "Distance is hover height",
            body: "Distance is non-zero only during hover. While in contact it should drop to exactly 0.",
          ),
          SizedBox(height: 10),
          _QuirkCard(
            level: "WARN",
            color: kAccentEraser,
            icon: Icons.bug_report_rounded,
            title: "Tilt is one scalar, not two",
            body: "Android reports tilt as a single angle off the surface normal. Use orientation to know the lean direction.",
          ),
          SizedBox(height: 10),
          _QuirkCard(
            level: "INFO",
            color: kAccentMouse,
            icon: Icons.science_rounded,
            title: "Batched historical samples",
            body: "MotionEvent.getHistoricalX/Y exposes inter-frame samples. PointerCoords reflects only the latest one in this view.",
          ),
        ],
      ),
    );
  }
}

class _QuirkCard extends StatelessWidget {
  const _QuirkCard({
    required this.level,
    required this.color,
    required this.icon,
    required this.title,
    required this.body,
  });
  final String level;
  final Color color;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        level,
                        style: kChip.copyWith(fontSize: 9, letterSpacing: 1.0),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: kInkDeep,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(body, style: kBody.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 10 — ACCESSIBILITY
// ===========================================================================

class _AccessibilitySection extends StatelessWidget {
  const _AccessibilitySection();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      eyebrow: "ACCESSIBILITY",
      accent: kAccentInverted,
      title: "Pointer data and assistive input",
      blurb: "Accessibility services synthesise pointer events too. Designing around the same fields keeps gesture handling robust for switch access, TalkBack explore-by-touch, and external pointing devices.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _A11yRow(
            color: kAccentInfo,
            icon: Icons.accessible_forward_rounded,
            title: "Explore by touch",
            blurb: "TalkBack drags a virtual finger across the UI. Pressure and ellipse will be defaults; rely on (x, y) only.",
          ),
          SizedBox(height: 10),
          _A11yRow(
            color: kAccentStylus,
            icon: Icons.switch_access_shortcut_rounded,
            title: "Switch Access",
            blurb: "Synthesises tap events from external switches. ToolType is FINGER even though no finger touches the screen.",
          ),
          SizedBox(height: 10),
          _A11yRow(
            color: kAccentSuccess,
            icon: Icons.keyboard_rounded,
            title: "Bluetooth keyboard / D-pad",
            blurb: "Navigation events are not pointer events; they go through the focus system instead. Don't try to fake them.",
          ),
          SizedBox(height: 10),
          _A11yRow(
            color: kAccentWarn,
            icon: Icons.gesture_rounded,
            title: "Magnification gestures",
            blurb: "Triple-tap and pan from the magnifier still reach the app as standard PointerEvents — be tolerant of large coordinate jumps.",
          ),
          SizedBox(height: 10),
          _A11yRow(
            color: kAccentMouse,
            icon: Icons.bluetooth_searching_rounded,
            title: "External mouse / trackpad",
            blurb: "Treat TOOL_TYPE_MOUSE specially: no ellipse, no tilt. Use hover state to drive cursor affordances.",
          ),
        ],
      ),
    );
  }
}

class _A11yRow extends StatelessWidget {
  const _A11yRow({
    required this.color,
    required this.icon,
    required this.title,
    required this.blurb,
  });
  final Color color;
  final IconData icon;
  final String title;
  final String blurb;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kPaper,
        border: Border.all(color: kPaperEdge, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  color.withValues(alpha: 0.32),
                  color.withValues(alpha: 0.12),
                ],
              ),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kInkDeep,
                  ),
                ),
                SizedBox(height: 4),
                Text(blurb, style: kBody.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 11 — FOOTER
// ===========================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kCard + 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kInkDeep,
            kAccentStylusDeep,
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kPaper.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kPaper.withValues(alpha: 0.25)),
            ),
            child: Icon(Icons.touch_app_rounded, color: kPaper, size: 26),
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Pointer-data anatomy — end of reference card",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: kPaper,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "All numbers above are hand-curated mock values. Real PointerCoords data lives behind PointerEventConverter and flows through GestureBinding before reaching your widgets.",
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: kPaper.withValues(alpha: 0.82),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("v1.0", style: kLabel.copyWith(color: kPaper.withValues(alpha: 0.75))),
              SizedBox(height: 4),
              Text(
                "D4rt deep demo",
                style: TextStyle(
                  fontSize: 11,
                  color: kPaper.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
