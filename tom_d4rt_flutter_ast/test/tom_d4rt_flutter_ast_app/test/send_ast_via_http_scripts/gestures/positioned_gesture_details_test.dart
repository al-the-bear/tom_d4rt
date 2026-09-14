// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// =============================================================================
// Positioned Gesture Details — Deep Visual Demo
// -----------------------------------------------------------------------------
// Flutter's gesture system carries a family of immutable *Details records that
// snapshot the state of a pointer at a particular phase of a gesture. They are
// handed to the GestureDetector callbacks (onTapDown, onLongPressStart,
// onScaleUpdate, onPanUpdate, ...) so that user code can read where the
// pointer is, what kind of device produced the event, and (for end events)
// how fast it was moving.
//
// This file is a hand-written demo that visualises the twelve core positioned
// *Details classes and their common shape:
//
//   * TapDownDetails              — finger has just landed, may become a tap
//   * TapUpDetails                — finger has lifted within the tap budget
//   * LongPressStartDetails       — finger has been held long enough
//   * LongPressMoveUpdateDetails  — finger has moved while still held
//   * LongPressEndDetails         — finger has lifted after a long press
//   * ScaleStartDetails           — pinch / pan recogniser engaged
//   * ScaleUpdateDetails          — pinch / pan progressing
//   * ScaleEndDetails             — pinch / pan released
//   * DragDownDetails             — pointer down, drag may begin
//   * DragStartDetails            — drag has been confirmed
//   * DragUpdateDetails           — drag is moving
//   * DragEndDetails              — drag has been released
//
// The shared anatomy of every positioned details record is:
//
//   globalPosition : Offset            — screen coordinates (top-left of the
//                                        window or hit-test root)
//   localPosition  : Offset            — coordinates relative to the receiving
//                                        widget's RenderBox top-left
//   kind           : PointerDeviceKind — touch / mouse / stylus / trackpad / ...
//
// And contrasts with these *non-positional* fields that only some siblings
// carry:
//
//   force / pressure : double — how hard the finger is pressing (touch/stylus)
//   velocity         : Velocity — instantaneous pixels-per-second (DragEnd)
//
// The demo is intentionally static: a single dynamic build(BuildContext) entry
// returns a MaterialApp tree, no setState, no controllers, no async, no
// streams. Sample *Details instances are constructed at file scope and merely
// rendered. This way the structure of the data is the lesson.
// =============================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// CONSTANT PALETTE
// -----------------------------------------------------------------------------
// All colours used by the demo, gathered into one place so the tone of the
// document stays consistent. We avoid .withOpacity per the project rules and
// rely on Color.fromARGB / pre-defined colour constants instead.
// -----------------------------------------------------------------------------

const Color kBgDeep = Color(0xFF0F1722);
const Color kBgPanel = Color(0xFF182334);
const Color kBgPanelAlt = Color(0xFF1F2C40);
const Color kBgCard = Color(0xFF243349);
const Color kBgCardSoft = Color(0xFF2C3D55);
const Color kInk = Color(0xFFE6EEF8);
const Color kInkDim = Color(0xFFA5B3C7);
const Color kInkFaint = Color(0xFF6B7B92);

const Color kAccentTap = Color(0xFF4FC3F7);
const Color kAccentLong = Color(0xFFFFB74D);
const Color kAccentScale = Color(0xFFBA68C8);
const Color kAccentDrag = Color(0xFF81C784);

const Color kGridLine = Color(0xFF2A3A52);
const Color kGridLineMajor = Color(0xFF3F5677);
const Color kGridStage = Color(0xFF11192A);

const Color kFingerprint = Color(0xFF7AC4F2);
const Color kFingerprintDim = Color(0xFF345A7E);

// =============================================================================
// DATA RECORDS
// =============================================================================
// These small data classes give the demo something to render without bringing
// in any state or async machinery. They are pure const-friendly value holders.
// =============================================================================

class DetailsCardData {
  final String typeName;
  final String tagline;
  final List<String> fields;
  final String literal;
  final Color accent;
  final IconData icon;
  const DetailsCardData({
    required this.typeName,
    required this.tagline,
    required this.fields,
    required this.literal,
    required this.accent,
    required this.icon,
  });
}

class KindCardData {
  final PointerDeviceKind kind;
  final String label;
  final String story;
  final IconData icon;
  final Color tint;
  const KindCardData({
    required this.kind,
    required this.label,
    required this.story,
    required this.icon,
    required this.tint,
  });
}

class TrajectoryStop {
  final String label;
  final Offset point;
  final Color tint;
  const TrajectoryStop({
    required this.label,
    required this.point,
    required this.tint,
  });
}

class TrajectoryCardData {
  final String title;
  final String detailsType;
  final String story;
  final Color accent;
  final IconData icon;
  final List<TrajectoryStop> stops;
  final List<String> literalLines;
  const TrajectoryCardData({
    required this.title,
    required this.detailsType,
    required this.story,
    required this.accent,
    required this.icon,
    required this.stops,
    required this.literalLines,
  });
}

class CallbackRowData {
  final String callback;
  final String detailsType;
  final String summary;
  final Color tint;
  final IconData icon;
  const CallbackRowData({
    required this.callback,
    required this.detailsType,
    required this.summary,
    required this.tint,
    required this.icon,
  });
}

class PitfallEntry {
  final String title;
  final String detail;
  final IconData icon;
  final Color tint;
  const PitfallEntry({
    required this.title,
    required this.detail,
    required this.icon,
    required this.tint,
  });
}

// =============================================================================
// SAMPLE DETAILS LITERALS
// =============================================================================
// We construct a representative instance of every positioned *Details class so
// the demo has real Dart values to introspect. They live at file scope so the
// sections below can pull them in without rebuilding state.
// =============================================================================

const Offset kSampleGlobalA = Offset(120.0, 84.0);
const Offset kSampleLocalA = Offset(40.0, 24.0);
const Offset kSampleGlobalB = Offset(220.0, 160.0);
const Offset kSampleLocalB = Offset(140.0, 100.0);
const Offset kSampleGlobalC = Offset(310.0, 268.0);
const Offset kSampleLocalC = Offset(230.0, 208.0);

final TapDownDetails kSampleTapDown = TapDownDetails(
  globalPosition: kSampleGlobalA,
  localPosition: kSampleLocalA,
  kind: PointerDeviceKind.touch,
);

final TapUpDetails kSampleTapUp = TapUpDetails(
  globalPosition: kSampleGlobalA,
  localPosition: kSampleLocalA,
  kind: PointerDeviceKind.touch,
);

final LongPressStartDetails kSampleLongStart = LongPressStartDetails(
  globalPosition: kSampleGlobalB,
  localPosition: kSampleLocalB,
);

final LongPressMoveUpdateDetails kSampleLongMove = LongPressMoveUpdateDetails(
  globalPosition: Offset(240.0, 174.0),
  localPosition: Offset(160.0, 114.0),
  offsetFromOrigin: Offset(20.0, 14.0),
  localOffsetFromOrigin: Offset(20.0, 14.0),
);

final LongPressEndDetails kSampleLongEnd = LongPressEndDetails(
  globalPosition: Offset(245.0, 178.0),
  localPosition: Offset(165.0, 118.0),
  velocity: Velocity(pixelsPerSecond: Offset(12.0, 4.0)),
);

final ScaleStartDetails kSampleScaleStart = ScaleStartDetails(
  focalPoint: Offset(180.0, 220.0),
  localFocalPoint: Offset(80.0, 120.0),
  pointerCount: 2,
);

final ScaleUpdateDetails kSampleScaleUpdate = ScaleUpdateDetails(
  focalPoint: Offset(190.0, 232.0),
  localFocalPoint: Offset(90.0, 132.0),
  scale: 1.45,
  horizontalScale: 1.5,
  verticalScale: 1.4,
  rotation: 0.32,
  pointerCount: 2,
  focalPointDelta: Offset(10.0, 12.0),
);

final ScaleEndDetails kSampleScaleEnd = ScaleEndDetails(
  velocity: Velocity(pixelsPerSecond: Offset(80.0, -40.0)),
  scaleVelocity: 0.9,
  pointerCount: 0,
);

final DragDownDetails kSampleDragDown = DragDownDetails(
  globalPosition: kSampleGlobalC,
  localPosition: kSampleLocalC,
);

final DragStartDetails kSampleDragStart = DragStartDetails(
  globalPosition: kSampleGlobalC,
  localPosition: kSampleLocalC,
  sourceTimeStamp: Duration(milliseconds: 320),
  kind: PointerDeviceKind.touch,
);

final DragUpdateDetails kSampleDragUpdate = DragUpdateDetails(
  globalPosition: Offset(330.0, 290.0),
  localPosition: Offset(250.0, 230.0),
  delta: Offset(20.0, 22.0),
  primaryDelta: null,
  sourceTimeStamp: Duration(milliseconds: 360),
);

// Cluster C28 FIX: dy must be 0 when primaryVelocity == dx
// (DragEndDetails asserts primaryVelocity matches one axis with the
// other axis being zero).
final DragEndDetails kSampleDragEnd = DragEndDetails(
  globalPosition: Offset(360.0, 320.0),
  localPosition: Offset(280.0, 260.0),
  velocity: Velocity(pixelsPerSecond: Offset(420.0, 0.0)),
  primaryVelocity: 420.0,
);

// =============================================================================
// CARD GALLERY DATA
// =============================================================================
// Twelve cards, one per positioned details class, ordered by gesture family:
// tap → long press → scale → drag.
// =============================================================================

const List<DetailsCardData> kDetailsCards = <DetailsCardData>[
  DetailsCardData(
    typeName: 'TapDownDetails',
    tagline: 'Finger landed, tap may begin',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
      'kind: PointerDeviceKind?',
    ],
    literal:
        'TapDownDetails(\n  globalPosition: Offset(120, 84),\n  localPosition: Offset(40, 24),\n  kind: PointerDeviceKind.touch,\n)',
    accent: kAccentTap,
    icon: Icons.touch_app,
  ),
  DetailsCardData(
    typeName: 'TapUpDetails',
    tagline: 'Finger lifted in tap budget',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
      'kind: PointerDeviceKind',
    ],
    literal:
        'TapUpDetails(\n  globalPosition: Offset(120, 84),\n  localPosition: Offset(40, 24),\n  kind: PointerDeviceKind.touch,\n)',
    accent: kAccentTap,
    icon: Icons.check_circle_outline,
  ),
  DetailsCardData(
    typeName: 'LongPressStartDetails',
    tagline: 'Press held past threshold',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
    ],
    literal:
        'LongPressStartDetails(\n  globalPosition: Offset(220, 160),\n  localPosition: Offset(140, 100),\n)',
    accent: kAccentLong,
    icon: Icons.timer,
  ),
  DetailsCardData(
    typeName: 'LongPressMoveUpdateDetails',
    tagline: 'Held finger drifted',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
      'offsetFromOrigin: Offset',
      'localOffsetFromOrigin: Offset',
    ],
    literal:
        'LongPressMoveUpdateDetails(\n  globalPosition: Offset(240, 174),\n  localPosition: Offset(160, 114),\n  offsetFromOrigin: Offset(20, 14),\n  localOffsetFromOrigin: Offset(20, 14),\n)',
    accent: kAccentLong,
    icon: Icons.open_with,
  ),
  DetailsCardData(
    typeName: 'LongPressEndDetails',
    tagline: 'Held finger released',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
      'velocity: Velocity',
    ],
    literal:
        'LongPressEndDetails(\n  globalPosition: Offset(245, 178),\n  localPosition: Offset(165, 118),\n  velocity: Velocity(pixelsPerSecond: Offset(12, 4)),\n)',
    accent: kAccentLong,
    icon: Icons.outlined_flag,
  ),
  DetailsCardData(
    typeName: 'ScaleStartDetails',
    tagline: 'Pinch / pan engaged',
    fields: <String>[
      'focalPoint: Offset',
      'localFocalPoint: Offset',
      'pointerCount: int',
    ],
    literal:
        'ScaleStartDetails(\n  focalPoint: Offset(180, 220),\n  localFocalPoint: Offset(80, 120),\n  pointerCount: 2,\n)',
    accent: kAccentScale,
    icon: Icons.zoom_out_map,
  ),
  DetailsCardData(
    typeName: 'ScaleUpdateDetails',
    tagline: 'Pinch / pan progressing',
    fields: <String>[
      'focalPoint: Offset',
      'localFocalPoint: Offset',
      'scale, horizontalScale, verticalScale: double',
      'rotation: double',
      'focalPointDelta: Offset',
      'pointerCount: int',
    ],
    literal:
        'ScaleUpdateDetails(\n  focalPoint: Offset(190, 232),\n  localFocalPoint: Offset(90, 132),\n  scale: 1.45,\n  rotation: 0.32,\n  focalPointDelta: Offset(10, 12),\n  pointerCount: 2,\n)',
    accent: kAccentScale,
    icon: Icons.rotate_90_degrees_ccw,
  ),
  DetailsCardData(
    typeName: 'ScaleEndDetails',
    tagline: 'Pinch / pan released',
    fields: <String>[
      'velocity: Velocity',
      'scaleVelocity: double',
      'pointerCount: int',
    ],
    literal:
        'ScaleEndDetails(\n  velocity: Velocity(pixelsPerSecond: Offset(80, -40)),\n  scaleVelocity: 0.9,\n  pointerCount: 0,\n)',
    accent: kAccentScale,
    icon: Icons.flight_land,
  ),
  DetailsCardData(
    typeName: 'DragDownDetails',
    tagline: 'Pointer down, drag may begin',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
    ],
    literal:
        'DragDownDetails(\n  globalPosition: Offset(310, 268),\n  localPosition: Offset(230, 208),\n)',
    accent: kAccentDrag,
    icon: Icons.south_east,
  ),
  DetailsCardData(
    typeName: 'DragStartDetails',
    tagline: 'Drag confirmed',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
      'sourceTimeStamp: Duration?',
      'kind: PointerDeviceKind?',
    ],
    literal:
        'DragStartDetails(\n  globalPosition: Offset(310, 268),\n  localPosition: Offset(230, 208),\n  sourceTimeStamp: Duration(milliseconds: 320),\n  kind: PointerDeviceKind.touch,\n)',
    accent: kAccentDrag,
    icon: Icons.play_arrow,
  ),
  DetailsCardData(
    typeName: 'DragUpdateDetails',
    tagline: 'Drag moving',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
      'delta: Offset',
      'primaryDelta: double?',
      'sourceTimeStamp: Duration?',
    ],
    literal:
        'DragUpdateDetails(\n  globalPosition: Offset(330, 290),\n  localPosition: Offset(250, 230),\n  delta: Offset(20, 22),\n  sourceTimeStamp: Duration(milliseconds: 360),\n)',
    accent: kAccentDrag,
    icon: Icons.swap_calls,
  ),
  DetailsCardData(
    typeName: 'DragEndDetails',
    tagline: 'Drag released',
    fields: <String>[
      'globalPosition: Offset',
      'localPosition: Offset',
      'velocity: Velocity',
      'primaryVelocity: double?',
    ],
    literal:
        'DragEndDetails(\n  globalPosition: Offset(360, 320),\n  localPosition: Offset(280, 260),\n  velocity: Velocity(pixelsPerSecond: Offset(420, 0)),\n  primaryVelocity: 420,\n)',
    accent: kAccentDrag,
    icon: Icons.flag,
  ),
];

// =============================================================================
// POINTERDEVICEKIND CARDS
// =============================================================================

const List<KindCardData> kKindCards = <KindCardData>[
  KindCardData(
    kind: PointerDeviceKind.touch,
    label: 'touch',
    story: 'Finger on a touchscreen — supports pressure on some devices.',
    icon: Icons.touch_app,
    tint: Color(0xFF4FC3F7),
  ),
  KindCardData(
    kind: PointerDeviceKind.mouse,
    label: 'mouse',
    story: 'A two- or three-button mouse — has hover, no pressure.',
    icon: Icons.mouse,
    tint: Color(0xFFB0BEC5),
  ),
  KindCardData(
    kind: PointerDeviceKind.stylus,
    label: 'stylus',
    story: 'A pen / digitiser — pressure, tilt, sometimes barrel buttons.',
    icon: Icons.edit,
    tint: Color(0xFFFFB74D),
  ),
  KindCardData(
    kind: PointerDeviceKind.invertedStylus,
    label: 'invertedStylus',
    story: 'Stylus held tip-up (eraser end) — same hardware, different intent.',
    icon: Icons.cleaning_services,
    tint: Color(0xFFE57373),
  ),
  KindCardData(
    kind: PointerDeviceKind.trackpad,
    label: 'trackpad',
    story: 'Multi-finger trackpad gesture — distinct from raw touch.',
    icon: Icons.touch_app_outlined,
    tint: Color(0xFF81C784),
  ),
  KindCardData(
    kind: PointerDeviceKind.unknown,
    label: 'unknown',
    story: 'Source could not be classified — handle defensively.',
    icon: Icons.help_outline,
    tint: Color(0xFF9E9E9E),
  ),
];

// =============================================================================
// SAMPLE TRAJECTORIES
// =============================================================================

const List<TrajectoryCardData> kTrajectoryCards = <TrajectoryCardData>[
  TrajectoryCardData(
    title: 'Tap at (100, 200)',
    detailsType: 'TapDownDetails / TapUpDetails',
    story: 'A single brief contact — same point twice, milliseconds apart.',
    accent: kAccentTap,
    icon: Icons.touch_app,
    stops: <TrajectoryStop>[
      TrajectoryStop(
        label: 'down',
        point: Offset(100.0, 200.0),
        tint: kAccentTap,
      ),
      TrajectoryStop(
        label: 'up',
        point: Offset(100.0, 200.0),
        tint: kAccentTap,
      ),
    ],
    literalLines: <String>[
      'TapDownDetails(',
      '  globalPosition: Offset(100, 200),',
      '  localPosition: Offset(100, 200),',
      '  kind: PointerDeviceKind.touch,',
      ')',
      'TapUpDetails(',
      '  globalPosition: Offset(100, 200),',
      '  localPosition: Offset(100, 200),',
      '  kind: PointerDeviceKind.touch,',
      ')',
    ],
  ),
  TrajectoryCardData(
    title: 'Long-press at (50, 50)',
    detailsType: 'LongPressStart / End',
    story: 'A press held in place; start and end land on the same point.',
    accent: kAccentLong,
    icon: Icons.timer,
    stops: <TrajectoryStop>[
      TrajectoryStop(
        label: 'start',
        point: Offset(50.0, 50.0),
        tint: kAccentLong,
      ),
      TrajectoryStop(
        label: 'end',
        point: Offset(50.0, 50.0),
        tint: kAccentLong,
      ),
    ],
    literalLines: <String>[
      'LongPressStartDetails(',
      '  globalPosition: Offset(50, 50),',
      '  localPosition: Offset(50, 50),',
      ')',
      'LongPressEndDetails(',
      '  globalPosition: Offset(50, 50),',
      '  localPosition: Offset(50, 50),',
      '  velocity: Velocity.zero,',
      ')',
    ],
  ),
  TrajectoryCardData(
    title: 'Drag from (10, 10) to (300, 400)',
    detailsType: 'DragStart / Update / End',
    story: 'A long diagonal drag — three details snapshots from one gesture.',
    accent: kAccentDrag,
    icon: Icons.swap_calls,
    stops: <TrajectoryStop>[
      TrajectoryStop(
        label: 'start',
        point: Offset(10.0, 10.0),
        tint: kAccentDrag,
      ),
      TrajectoryStop(
        label: 'mid',
        point: Offset(155.0, 205.0),
        tint: kAccentDrag,
      ),
      TrajectoryStop(
        label: 'end',
        point: Offset(300.0, 400.0),
        tint: kAccentDrag,
      ),
    ],
    literalLines: <String>[
      'DragStartDetails(',
      '  globalPosition: Offset(10, 10),',
      '  localPosition: Offset(10, 10),',
      '  kind: PointerDeviceKind.touch,',
      ')',
      'DragUpdateDetails(',
      '  globalPosition: Offset(155, 205),',
      '  localPosition: Offset(155, 205),',
      '  delta: Offset(145, 195),',
      ')',
      'DragEndDetails(',
      '  globalPosition: Offset(300, 400),',
      '  localPosition: Offset(300, 400),',
      '  velocity: Velocity(pixelsPerSecond: Offset(420, 540)),',
      ')',
    ],
  ),
];

// =============================================================================
// CALLBACK ROW DATA
// =============================================================================

const List<CallbackRowData> kCallbackRows = <CallbackRowData>[
  CallbackRowData(
    callback: 'onTapDown(TapDownDetails)',
    detailsType: 'TapDownDetails',
    summary: 'Pointer landed; user can confirm or cancel.',
    tint: kAccentTap,
    icon: Icons.touch_app,
  ),
  CallbackRowData(
    callback: 'onTapUp(TapUpDetails)',
    detailsType: 'TapUpDetails',
    summary: 'Pointer lifted within tap budget — fires before onTap.',
    tint: kAccentTap,
    icon: Icons.check,
  ),
  CallbackRowData(
    callback: 'onLongPressStart(LongPressStartDetails)',
    detailsType: 'LongPressStartDetails',
    summary: 'Press has been held long enough to count as long-press.',
    tint: kAccentLong,
    icon: Icons.timer,
  ),
  CallbackRowData(
    callback: 'onLongPressMoveUpdate(LongPressMoveUpdateDetails)',
    detailsType: 'LongPressMoveUpdateDetails',
    summary: 'Held finger drifted; offsetFromOrigin tells you how far.',
    tint: kAccentLong,
    icon: Icons.open_with,
  ),
  CallbackRowData(
    callback: 'onLongPressEnd(LongPressEndDetails)',
    detailsType: 'LongPressEndDetails',
    summary: 'Held finger lifted; velocity describes flick direction.',
    tint: kAccentLong,
    icon: Icons.flag,
  ),
  CallbackRowData(
    callback: 'onScaleStart(ScaleStartDetails)',
    detailsType: 'ScaleStartDetails',
    summary: 'Scale recogniser engaged; focalPoint is the gesture centre.',
    tint: kAccentScale,
    icon: Icons.zoom_out_map,
  ),
  CallbackRowData(
    callback: 'onScaleUpdate(ScaleUpdateDetails)',
    detailsType: 'ScaleUpdateDetails',
    summary: 'scale / rotation deltas relative to onScaleStart.',
    tint: kAccentScale,
    icon: Icons.rotate_right,
  ),
  CallbackRowData(
    callback: 'onScaleEnd(ScaleEndDetails)',
    detailsType: 'ScaleEndDetails',
    summary: 'Pointers lifted; velocity reports the fling at release.',
    tint: kAccentScale,
    icon: Icons.flight_land,
  ),
  CallbackRowData(
    callback: 'onPanDown(DragDownDetails)',
    detailsType: 'DragDownDetails',
    summary: 'Pointer down — drag *might* begin.',
    tint: kAccentDrag,
    icon: Icons.south_east,
  ),
  CallbackRowData(
    callback: 'onPanStart(DragStartDetails)',
    detailsType: 'DragStartDetails',
    summary: 'Recogniser confirmed the drag.',
    tint: kAccentDrag,
    icon: Icons.play_arrow,
  ),
  CallbackRowData(
    callback: 'onPanUpdate(DragUpdateDetails)',
    detailsType: 'DragUpdateDetails',
    summary: 'Drag is moving; delta is per-frame translation.',
    tint: kAccentDrag,
    icon: Icons.swap_calls,
  ),
  CallbackRowData(
    callback: 'onPanEnd(DragEndDetails)',
    detailsType: 'DragEndDetails',
    summary: 'Drag released; velocity drives a fling animation.',
    tint: kAccentDrag,
    icon: Icons.flag_circle,
  ),
];

// =============================================================================
// PITFALL ENTRIES
// =============================================================================

const List<PitfallEntry> kPitfalls = <PitfallEntry>[
  PitfallEntry(
    title: 'globalPosition is in screen coords',
    detail:
        'It is measured from the top-left of the window / hit-test root, NOT '
        'your widget. Reaching for it to position children locally usually '
        'produces values that are too large.',
    icon: Icons.crop_free,
    tint: kAccentTap,
  ),
  PitfallEntry(
    title: 'localPosition is in widget coords',
    detail:
        'It is measured from the top-left of the RenderBox that owns the '
        'recogniser. Use this when you want to draw or hit-test inside that '
        'widget without manual conversion.',
    icon: Icons.crop_square,
    tint: kAccentLong,
  ),
  PitfallEntry(
    title: 'Convert with RenderBox.globalToLocal',
    detail:
        'If you only have globalPosition (e.g. from a Listener at the root), '
        'fetch the target RenderBox via the BuildContext and call '
        'globalToLocal(details.globalPosition) to obtain local coordinates.',
    icon: Icons.transform,
    tint: kAccentScale,
  ),
  PitfallEntry(
    title: 'kind may be null on older details',
    detail:
        'Some *Details (DragDownDetails, LongPressStartDetails) do not expose '
        'kind. If you need to discriminate device kind there, capture it from '
        'the previous beat in the gesture chain and store it locally.',
    icon: Icons.help_outline,
    tint: kAccentDrag,
  ),
  PitfallEntry(
    title: 'velocity is only on End details',
    detail:
        'DragEndDetails / LongPressEndDetails / ScaleEndDetails carry a '
        'Velocity. Update / Move details give you delta or focalPointDelta '
        'instead — to estimate velocity mid-gesture you must compute dt.',
    icon: Icons.speed,
    tint: kAccentTap,
  ),
  PitfallEntry(
    title: 'force / pressure is not exposed here',
    detail:
        'Pressure data lives on the raw PointerEvent, not on the gesture '
        '*Details. If you need it, attach a Listener and read '
        'PointerDownEvent.pressure directly.',
    icon: Icons.water_drop,
    tint: kAccentLong,
  ),
];

// =============================================================================
// PAINTERS
// =============================================================================
// Two stateless CustomPainters: a coordinate grid (used by the hero and the
// trajectory cards) and a stylised fingerprint (used in the hero header).
// =============================================================================

class CoordinateGridPainter extends CustomPainter {
  final int columns;
  final int rows;
  final double majorEvery;
  const CoordinateGridPainter({
    required this.columns,
    required this.rows,
    this.majorEvery = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()..color = kGridStage;
    canvas.drawRect(Offset.zero & size, bgPaint);
    final Paint minor = Paint()
      ..color = kGridLine
      ..strokeWidth = 1.0;
    final Paint major = Paint()
      ..color = kGridLineMajor
      ..strokeWidth = 1.4;
    final double cellW = size.width / columns;
    final double cellH = size.height / rows;
    for (int c = 0; c <= columns; c++) {
      final double x = c * cellW;
      final Paint p = c % majorEvery.toInt() == 0 ? major : minor;
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), p);
    }
    for (int r = 0; r <= rows; r++) {
      final double y = r * cellH;
      final Paint p = r % majorEvery.toInt() == 0 ? major : minor;
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CoordinateGridPainter old) =>
      old.columns != columns || old.rows != rows;
}

class FingerprintPainter extends CustomPainter {
  final Color tint;
  const FingerprintPainter({required this.tint});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset centre = Offset(size.width / 2.0, size.height / 2.0);
    final Paint stroke = Paint()
      ..color = tint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    final Paint dim = Paint()
      ..color = kFingerprintDim
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    for (int i = 0; i < 8; i++) {
      final double r = 8.0 + i * 7.0;
      final Rect rect = Rect.fromCenter(
        center: centre,
        width: r * 2.0,
        height: r * 2.4,
      );
      canvas.drawArc(rect, -2.6 - i * 0.04, 2.4 + i * 0.05, false,
          i.isEven ? stroke : dim);
    }
    final Paint dot = Paint()..color = tint;
    canvas.drawCircle(centre, 3.0, dot);
  }

  @override
  bool shouldRepaint(covariant FingerprintPainter old) => old.tint != tint;
}

class TrajectoryPainter extends CustomPainter {
  final List<TrajectoryStop> stops;
  final Color accent;
  final double maxX;
  final double maxY;
  const TrajectoryPainter({
    required this.stops,
    required this.accent,
    required this.maxX,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = kGridStage;
    canvas.drawRect(Offset.zero & size, bg);
    final Paint grid = Paint()
      ..color = kGridLine
      ..strokeWidth = 1.0;
    for (int i = 1; i < 6; i++) {
      final double x = size.width * i / 6.0;
      final double y = size.height * i / 6.0;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    if (stops.isEmpty) return;
    final List<Offset> mapped = stops.map((TrajectoryStop s) {
      final double dx = (s.point.dx / maxX).clamp(0.0, 1.0) * size.width;
      final double dy = (s.point.dy / maxY).clamp(0.0, 1.0) * size.height;
      return Offset(dx, dy);
    }).toList();
    if (mapped.length > 1) {
      final Paint line = Paint()
        ..color = accent
        ..strokeWidth = 2.2
        ..style = PaintingStyle.stroke;
      final Path path = Path()..moveTo(mapped.first.dx, mapped.first.dy);
      for (int i = 1; i < mapped.length; i++) {
        path.lineTo(mapped[i].dx, mapped[i].dy);
      }
      canvas.drawPath(path, line);
    }
    for (int i = 0; i < mapped.length; i++) {
      final Paint fill = Paint()..color = stops[i].tint;
      final Paint ring = Paint()
        ..color = kInk
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawCircle(mapped[i], 6.0, fill);
      canvas.drawCircle(mapped[i], 6.0, ring);
    }
  }

  @override
  bool shouldRepaint(covariant TrajectoryPainter old) =>
      old.stops != stops || old.accent != accent;
}

class AnatomyDiagramPainter extends CustomPainter {
  const AnatomyDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint screenBg = Paint()..color = kBgPanelAlt;
    final Rect screenRect =
        Rect.fromLTWH(8.0, 8.0, size.width - 16.0, size.height - 16.0);
    canvas.drawRRect(
        RRect.fromRectAndRadius(screenRect, Radius.circular(8.0)), screenBg);
    final Paint widgetBg = Paint()..color = kBgCard;
    final Rect widgetRect = Rect.fromLTWH(
      screenRect.left + 60.0,
      screenRect.top + 60.0,
      screenRect.width * 0.55,
      screenRect.height * 0.55,
    );
    canvas.drawRRect(
        RRect.fromRectAndRadius(widgetRect, Radius.circular(6.0)), widgetBg);
    final Paint widgetEdge = Paint()
      ..color = kAccentTap
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(
        RRect.fromRectAndRadius(widgetRect, Radius.circular(6.0)), widgetEdge);
    final Offset finger = Offset(
      widgetRect.left + widgetRect.width * 0.45,
      widgetRect.top + widgetRect.height * 0.55,
    );
    final Paint fingerFill = Paint()..color = kAccentDrag;
    final Paint fingerRing = Paint()
      ..color = kInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(finger, 8.0, fingerFill);
    canvas.drawCircle(finger, 8.0, fingerRing);

    final Paint guide = Paint()
      ..color = kInkFaint
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(screenRect.left, finger.dy), finger, guide);
    canvas.drawLine(Offset(finger.dx, screenRect.top), finger, guide);
    final Paint local = Paint()
      ..color = kAccentLong
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(widgetRect.left, finger.dy), finger, local);
    canvas.drawLine(Offset(finger.dx, widgetRect.top), finger, local);

    final TextPainter labelGlobal = TextPainter(
      text: TextSpan(
        text: 'globalPosition',
        style: TextStyle(color: kInkDim, fontSize: 11.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    labelGlobal.paint(canvas, Offset(screenRect.left + 6.0, finger.dy + 6.0));
    final TextPainter labelLocal = TextPainter(
      text: TextSpan(
        text: 'localPosition',
        style: TextStyle(color: kAccentLong, fontSize: 11.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    labelLocal.paint(canvas, Offset(widgetRect.left + 6.0, finger.dy + 6.0));
    final TextPainter labelKind = TextPainter(
      text: TextSpan(
        text: 'kind: PointerDeviceKind.touch',
        style: TextStyle(color: kAccentDrag, fontSize: 11.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    labelKind.paint(canvas, Offset(finger.dx + 14.0, finger.dy - 14.0));
  }

  @override
  bool shouldRepaint(covariant AnatomyDiagramPainter old) => false;
}

// =============================================================================
// SECTION HELPERS
// =============================================================================

Widget sectionTitle(String index, String title, String subtitle, Color tint) {
  return Container(
    padding: EdgeInsets.fromLTRB(16.0, 28.0, 16.0, 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            index,
            style: TextStyle(
              color: kBgDeep,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: kInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(color: kInkDim, fontSize: 13.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget sectionPanel({required Widget child, EdgeInsets? padding}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: padding ?? EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kBgPanel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBgPanelAlt, width: 1.0),
    ),
    child: child,
  );
}

Widget pillBadge(String text, Color tint) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: kBgDeep,
        fontWeight: FontWeight.w700,
        fontSize: 11.0,
      ),
    ),
  );
}

Widget codeBlock(String code, {Color tint = kAccentDrag}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kBgDeep,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tint, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        color: kInk,
        fontFamily: 'monospace',
        fontSize: 11.5,
        height: 1.4,
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — HERO
// =============================================================================

Widget buildHero() {
  return Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF1B2A40), Color(0xFF0F1722)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kAccentTap, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 160.0,
          height: 160.0,
          decoration: BoxDecoration(
            color: kBgDeep,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: kFingerprintDim, width: 1.0),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(
                  painter: CoordinateGridPainter(columns: 10, rows: 10),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: FingerprintPainter(tint: kFingerprint),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Positioned Gesture Details',
                style: TextStyle(
                  color: kInk,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'TapDown · TapUp · LongPress* · Scale* · Drag*',
                style: TextStyle(color: kAccentTap, fontSize: 13.0),
              ),
              SizedBox(height: 12.0),
              Text(
                'Each gesture phase carries an immutable record. The shared '
                'spine is globalPosition + localPosition + kind; the family '
                'specific extras (delta, velocity, scale, focalPoint, '
                'offsetFromOrigin) describe what makes that phase distinct.',
                style: TextStyle(color: kInkDim, fontSize: 13.0, height: 1.5),
              ),
              SizedBox(height: 12.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: <Widget>[
                  pillBadge('globalPosition', kAccentTap),
                  pillBadge('localPosition', kAccentLong),
                  pillBadge('kind', kAccentDrag),
                  pillBadge('velocity', kAccentScale),
                  pillBadge('force / pressure (raw)', Color(0xFFFFD54F)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — FIELD ANATOMY
// =============================================================================

Widget buildAnatomy() {
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Anatomy of a positioned details record',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Screen frame represents the window; inner panel is your widget. '
          'The blue dot is the pointer contact. Grey guides hit the screen '
          'edge (globalPosition); orange guides hit the widget edge '
          '(localPosition). Pointer kind is reported alongside.',
          style: TextStyle(color: kInkDim, fontSize: 12.5, height: 1.5),
        ),
        SizedBox(height: 12.0),
        SizedBox(
          height: 220.0,
          child: CustomPaint(
            painter: AnatomyDiagramPainter(),
            size: Size.infinite,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(
              child: anatomyLegend(
                'globalPosition',
                'Top-left of the window. Measured in logical pixels.',
                kInkDim,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: anatomyLegend(
                'localPosition',
                'Top-left of the widget that received the gesture.',
                kAccentLong,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: anatomyLegend(
                'kind',
                'PointerDeviceKind enum — touch, mouse, stylus, ...',
                kAccentDrag,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget anatomyLegend(String label, String body, Color tint) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tint, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: tint,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(color: kInkDim, fontSize: 11.5, height: 1.4),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3 — 4x3 CARD GALLERY
// =============================================================================

Widget buildGallery() {
  final List<Widget> rows = <Widget>[];
  for (int r = 0; r < 3; r++) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < 4; c++) {
      final int idx = r * 4 + c;
      if (idx >= kDetailsCards.length) {
        cells.add(Expanded(child: SizedBox.shrink()));
      } else {
        cells.add(Expanded(child: detailsCard(kDetailsCards[idx])));
      }
      if (c < 3) cells.add(SizedBox(width: 10.0));
    }
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #28, P1):
    // Stretch-Row in the 4x3 details-card gallery inside the unbounded
    // SingleChildScrollView — wrap in IntrinsicHeight so Expanded cells
    // share the tallest card's height with finite constraints.
    rows.add(IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cells,
      ),
    ));
    if (r < 2) rows.add(SizedBox(height: 10.0));
  }
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Twelve positioned *Details classes',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Constructor signature, fields, and a sample literal for each.',
          style: TextStyle(color: kInkDim, fontSize: 12.5),
        ),
        SizedBox(height: 12.0),
        ...rows,
      ],
    ),
  );
}

Widget detailsCard(DetailsCardData data) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: data.accent, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(data.icon, color: data.accent, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                data.typeName,
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          data.tagline,
          style: TextStyle(
            color: kInkDim,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        for (final String f in data.fields)
          Padding(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Text(
              '· $f',
              style: TextStyle(
                color: kInkFaint,
                fontSize: 10.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: kBgDeep,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            data.literal,
            style: TextStyle(
              color: kInk,
              fontSize: 9.5,
              fontFamily: 'monospace',
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4 — POINTERDEVICEKIND ENUM PANEL
// =============================================================================

Widget buildKindPanel() {
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PointerDeviceKind',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Discriminator on most positioned details. Lets you branch on input '
          'modality without inspecting raw PointerEvents.',
          style: TextStyle(color: kInkDim, fontSize: 12.5),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final KindCardData k in kKindCards) kindChip(k),
          ],
        ),
      ],
    ),
  );
}

Widget kindChip(KindCardData k) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: k.tint, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #28, P3):
        // The longest label here ('PointerDeviceKind.invertedStylus' — 32
        // chars at 12pt monospace) plus the icon + gap exceeded the
        // 200-px inner width of the 220-wide kindChip, causing a ~13-px
        // RenderFlex overflow on the right. Wrap the Text in an Expanded
        // so it soft-wraps to the available width instead.
        Row(
          children: <Widget>[
            Icon(k.icon, color: k.tint, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'PointerDeviceKind.${k.label}',
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          k.story,
          style: TextStyle(color: kInkDim, fontSize: 11.5, height: 1.35),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5 — COORDINATE-SYSTEM DIAGRAM (stage = window, panel = widget)
// =============================================================================

Widget buildCoordinateSystem() {
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Coordinate systems: stage vs panel',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'globalPosition lives in the stage (the window) and grows from the '
          'top-left of the screen. localPosition lives in the panel (the '
          'widget) and grows from the top-left of its RenderBox.',
          style: TextStyle(color: kInkDim, fontSize: 12.5, height: 1.5),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 240.0,
          decoration: BoxDecoration(
            color: kBgPanelAlt,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(
                  painter: CoordinateGridPainter(columns: 12, rows: 8),
                ),
              ),
              Positioned(
                left: 80.0,
                top: 50.0,
                width: 240.0,
                height: 140.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: kBgCard,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: kAccentLong, width: 1.4),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CustomPaint(
                          painter: CoordinateGridPainter(columns: 6, rows: 4),
                        ),
                      ),
                      Positioned(
                        left: 110.0,
                        top: 70.0,
                        child: Container(
                          width: 14.0,
                          height: 14.0,
                          decoration: BoxDecoration(
                            color: kAccentDrag,
                            shape: BoxShape.circle,
                            border: Border.all(color: kInk, width: 1.4),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6.0,
                        top: 6.0,
                        child: Text(
                          'panel (widget)\n(0,0) — RenderBox local',
                          style: TextStyle(color: kAccentLong, fontSize: 10.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 6.0,
                top: 6.0,
                child: Text(
                  'stage (window)\n(0,0) — global',
                  style: TextStyle(color: kAccentTap, fontSize: 11.0),
                ),
              ),
              Positioned(
                right: 8.0,
                bottom: 6.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: kBgDeep,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: kAccentDrag, width: 1.0),
                  ),
                  child: Text(
                    'pointer:\n  global = (190, 120)\n  local  = (110, 70)',
                    style: TextStyle(
                      color: kInk,
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                    ),
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

// =============================================================================
// SECTION 6 — SAMPLE TRAJECTORY CARDS
// =============================================================================

Widget buildTrajectories() {
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sample trajectories',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Three concrete pointer journeys, each rendered on a coordinate grid '
          'and accompanied by the *Details literal that would be emitted.',
          style: TextStyle(color: kInkDim, fontSize: 12.5, height: 1.5),
        ),
        SizedBox(height: 12.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #28, P1):
        // Stretch-Row in the trajectory-card grid inside the unbounded
        // SingleChildScrollView — wrap in IntrinsicHeight.
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < kTrajectoryCards.length; i++) ...<Widget>[
                Expanded(child: trajectoryCard(kTrajectoryCards[i])),
                if (i < kTrajectoryCards.length - 1) SizedBox(width: 10.0),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget trajectoryCard(TrajectoryCardData data) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: data.accent, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(data.icon, color: data.accent, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                data.title,
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0),
        Text(
          data.detailsType,
          style: TextStyle(
            color: data.accent,
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          data.story,
          style: TextStyle(
            color: kInkDim,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            height: 1.35,
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 130.0,
          child: CustomPaint(
            painter: TrajectoryPainter(
              stops: data.stops,
              accent: data.accent,
              maxX: 400.0,
              maxY: 420.0,
            ),
            size: Size.infinite,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: kBgDeep,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String l in data.literalLines)
                Text(
                  l,
                  style: TextStyle(
                    color: kInk,
                    fontFamily: 'monospace',
                    fontSize: 9.5,
                    height: 1.35,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7 — VELOCITY DECONSTRUCTION
// =============================================================================

Widget buildVelocity() {
  final Velocity sample = Velocity(pixelsPerSecond: Offset(420.0, 180.0));
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'velocity (DragEndDetails)',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'On release, DragEndDetails / LongPressEndDetails / ScaleEndDetails '
          'expose a Velocity. It wraps a single Offset of pixels per second; '
          'sign tells you direction along each axis.',
          style: TextStyle(color: kInkDim, fontSize: 12.5, height: 1.5),
        ),
        SizedBox(height: 12.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #28, P1):
        // Stretch-Row pairs a codeBlock with a velocity-card inside the
        // unbounded vertical viewport — wrap in IntrinsicHeight so both
        // Expanded columns receive a finite shared height.
        IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #28, P3):
              // The half-width Expanded slot only holds ~336 px of inner
              // content; the original 50-char monospace lines exceeded
              // that, and Text could not soft-wrap them because they
              // contain no breakable whitespace. Reformat to split at
              // natural language boundaries so every line fits.
              child: codeBlock(
                'class Velocity {\n'
                '  final Offset pixelsPerSecond;\n'
                '  const Velocity({\n'
                '    required this.pixelsPerSecond,\n'
                '  });\n'
                '  Velocity clampMagnitude(\n'
                '    double min,\n'
                '    double max,\n'
                '  );\n'
                '  static const Velocity zero =\n'
                '      Velocity(\n'
                '    pixelsPerSecond: Offset.zero,\n'
                '  );\n'
                '}',
                tint: kAccentDrag,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: kBgCard,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: kAccentDrag, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'sample',
                      style: TextStyle(
                        color: kAccentDrag,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'Velocity(pixelsPerSecond: Offset(420, 180))',
                      style: TextStyle(
                        color: kInk,
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    velocityRow('dx (px/s)',
                        sample.pixelsPerSecond.dx.toStringAsFixed(1)),
                    velocityRow('dy (px/s)',
                        sample.pixelsPerSecond.dy.toStringAsFixed(1)),
                    velocityRow('|v| (px/s)',
                        sample.pixelsPerSecond.distance.toStringAsFixed(1)),
                    velocityRow('direction (rad)',
                        sample.pixelsPerSecond.direction.toStringAsFixed(2)),
                  ],
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

Widget velocityRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            label,
            style: TextStyle(
              color: kInkDim,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: kInk,
            fontSize: 11.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 — RELATIONSHIP TO GestureDetector CALLBACKS
// =============================================================================

Widget buildCallbackTable() {
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Relationship to GestureDetector callbacks',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'GestureDetector exposes one callback per gesture phase, each '
          'parameterised on the matching *Details record. Picking the right '
          'callback IS picking the right details type.',
          style: TextStyle(color: kInkDim, fontSize: 12.5, height: 1.5),
        ),
        SizedBox(height: 12.0),
        for (final CallbackRowData row in kCallbackRows) callbackRow(row),
      ],
    ),
  );
}

Widget callbackRow(CallbackRowData row) {
  return Container(
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: row.tint, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(row.icon, color: row.tint, size: 16.0),
        SizedBox(width: 8.0),
        SizedBox(
          width: 280.0,
          child: Text(
            row.callback,
            style: TextStyle(
              color: kInk,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 200.0,
          child: Text(
            row.detailsType,
            style: TextStyle(
              color: row.tint,
              fontFamily: 'monospace',
              fontSize: 11.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            row.summary,
            style: TextStyle(color: kInkDim, fontSize: 11.5, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9 — RECIPE
// =============================================================================

Widget buildRecipe() {
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Recipe — capture details from a real GestureDetector',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A live (but inert) GestureDetector wired to onTapDown — its '
          'callback would receive a TapDownDetails. The right column shows '
          'the source listing.',
          style: TextStyle(color: kInkDim, fontSize: 12.5, height: 1.5),
        ),
        SizedBox(height: 12.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #28, P1):
        // Stretch-Row pairs a GestureDetector sandbox with a code listing
        // inside the unbounded vertical viewport — wrap in IntrinsicHeight
        // so both Expanded columns get a finite shared height.
        IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: kBgCard,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: kAccentTap, width: 1.0),
                ),
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {},
                  onLongPressStart: (LongPressStartDetails details) {},
                  onPanStart: (DragStartDetails details) {},
                  child: Container(
                    height: 140.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kBgPanelAlt,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: kAccentDrag, width: 1.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.touch_app, color: kAccentTap, size: 32.0),
                        SizedBox(height: 6.0),
                        Text(
                          'GestureDetector',
                          style: TextStyle(
                            color: kInk,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          'onTapDown / onLongPressStart / onPanStart',
                          style: TextStyle(
                            color: kInkDim,
                            fontSize: 10.5,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              flex: 2,
              child: codeBlock(
                "GestureDetector(\n"
                "  onTapDown: (TapDownDetails d) {\n"
                "    // d.globalPosition - Offset, screen coords\n"
                "    // d.localPosition  - Offset, widget coords\n"
                "    // d.kind           - PointerDeviceKind\n"
                "  },\n"
                "  onLongPressStart: (LongPressStartDetails d) {\n"
                "    // d.globalPosition / d.localPosition\n"
                "  },\n"
                "  onPanStart: (DragStartDetails d) {\n"
                "    // d.globalPosition / d.localPosition\n"
                "    // d.sourceTimeStamp - Duration?\n"
                "    // d.kind            - PointerDeviceKind?\n"
                "  },\n"
                "  onPanUpdate: (DragUpdateDetails d) {\n"
                "    // d.delta          - Offset, per-frame translation\n"
                "    // d.primaryDelta   - double?, axis projection\n"
                "  },\n"
                "  onPanEnd: (DragEndDetails d) {\n"
                "    // d.velocity         - Velocity\n"
                "    // d.primaryVelocity  - double?\n"
                "  },\n"
                "  child: Container(/* ... */),\n"
                ");",
                tint: kAccentTap,
              ),
            ),
          ],
        ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 — PITFALLS
// =============================================================================

Widget buildPitfalls() {
  return sectionPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Pitfalls and conversions',
          style: TextStyle(
            color: kInk,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Six recurring traps when handling positioned details — read this '
          'before reaching for globalPosition by reflex.',
          style: TextStyle(color: kInkDim, fontSize: 12.5),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final PitfallEntry p in kPitfalls) pitfallCard(p),
          ],
        ),
        SizedBox(height: 12.0),
        codeBlock(
          '// Convert globalPosition to widget-local coordinates manually:\n'
          'final RenderBox box = context.findRenderObject() as RenderBox;\n'
          'final Offset local = box.globalToLocal(details.globalPosition);\n'
          '// Inverse: box.localToGlobal(localPosition) returns an Offset in\n'
          '// stage coordinates suitable for OverlayEntries / dialogs.',
          tint: kAccentScale,
        ),
      ],
    ),
  );
}

Widget pitfallCard(PitfallEntry p) {
  return Container(
    width: 320.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: p.tint, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(p.icon, color: p.tint, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                p.title,
                style: TextStyle(
                  color: kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          p.detail,
          style: TextStyle(color: kInkDim, fontSize: 11.5, height: 1.4),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11 — FOOTER
// =============================================================================

Widget buildFooter() {
  return Container(
    margin: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 24.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kBgCard, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.info_outline, color: kAccentTap, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            'Positioned gesture details · TapDown / TapUp / LongPressStart / '
            'LongPressMoveUpdate / LongPressEnd / ScaleStart / ScaleUpdate / '
            'ScaleEnd / DragDown / DragStart / DragUpdate / DragEnd — every '
            'one carries globalPosition + localPosition; many add kind, '
            'velocity, delta or focalPoint.',
            style: TextStyle(color: kInkDim, fontSize: 11.5, height: 1.4),
          ),
        ),
        SizedBox(width: 8.0),
        pillBadge('static demo', kAccentDrag),
      ],
    ),
  );
}

// =============================================================================
// ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Positioned Gesture Details — Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBgDeep,
      primaryColor: kAccentTap,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: kInk, fontSize: 13.0),
      ),
    ),
    home: Scaffold(
      backgroundColor: kBgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHero(),
              sectionTitle(
                '1',
                'Field anatomy',
                'globalPosition vs localPosition vs kind on a screen-and-widget mockup.',
                kAccentTap,
              ),
              buildAnatomy(),
              sectionTitle(
                '2',
                'Twelve positioned *Details classes',
                'A 4×3 gallery — signature, fields and a sample literal each.',
                kAccentLong,
              ),
              buildGallery(),
              sectionTitle(
                '3',
                'PointerDeviceKind enum',
                'How details records discriminate input modality.',
                kAccentScale,
              ),
              buildKindPanel(),
              sectionTitle(
                '4',
                'Coordinate systems',
                'Stage = window (global), panel = widget (local).',
                kAccentDrag,
              ),
              buildCoordinateSystem(),
              sectionTitle(
                '5',
                'Sample trajectories',
                'Tap, long-press and drag rendered on a coordinate grid.',
                kAccentTap,
              ),
              buildTrajectories(),
              sectionTitle(
                '6',
                'Velocity (DragEndDetails)',
                'Deconstructing pixelsPerSecond into magnitude and direction.',
                kAccentScale,
              ),
              buildVelocity(),
              sectionTitle(
                '7',
                'GestureDetector callbacks',
                'Each callback is parameterised on a matching *Details type.',
                kAccentLong,
              ),
              buildCallbackTable(),
              sectionTitle(
                '8',
                'Recipe',
                'Real GestureDetector capturing TapDown / LongPressStart / PanStart.',
                kAccentDrag,
              ),
              buildRecipe(),
              sectionTitle(
                '9',
                'Pitfalls',
                'Six recurring traps and a globalToLocal conversion snippet.',
                kAccentTap,
              ),
              buildPitfalls(),
              buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
