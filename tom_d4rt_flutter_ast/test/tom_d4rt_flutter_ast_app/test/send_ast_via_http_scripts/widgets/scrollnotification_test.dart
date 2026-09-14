// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the Flutter ScrollNotification family.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a static poster that walks the reader through the
// life-cycle of scroll notifications during a single drag gesture. Eight
// thematic sections cover:
//
//   1. Hero intro - what a ScrollNotification is, the bubbling mechanism,
//      the Notification/NotificationListener<T> dispatch path.
//   2. Class-hierarchy CustomPainter - Notification -> LayoutChangedNotification
//      -> ScrollNotification -> the five concrete subtypes, plus the parallel
//      ScrollMetricsNotification track.
//   3. Timeline CustomPainter - a single scroll gesture rendered on a
//      horizontal time axis with notification markers (ScrollStart, multiple
//      ScrollUpdate, an optional Overscroll, ScrollEnd, and a trailing
//      UserScrollNotification when direction settles to idle).
//   4. ScrollMetrics anatomy table - pixels, minScrollExtent, maxScrollExtent,
//      viewportDimension, axisDirection, atEdge, outOfRange, extentBefore,
//      extentInside, extentAfter.
//   5. Overscroll panel - leading vs trailing edges drawn with arrow
//      indicators, ScrollDirection enum chips, BouncingScrollPhysics vs
//      ClampingScrollPhysics contrast.
//   6. NotificationListener<T> dispatch + depth diagram - nested boxes
//      showing how depth increments at every nested Scrollable, with the
//      predicate hook and the bool-return-cancels-bubbling rule called out.
//   7. Six code-snippet cards - idiomatic patterns and gotchas: typed
//      filter, depth==0 guard, ScrollNotificationObserver, dispatch from
//      a custom scrollable, do-not-call-setState-during-build, ScrollMetrics
//      reading from notification.metrics.
//   8. ScrollController vs ScrollNotification comparison + pitfalls panel
//      (PrimaryScrollController traps, nested Scrollables, the cost of
//      LayoutBuilder under NotificationListener, premature absorption).
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no live
// `AnimationController`, no real `NotificationListener` that mutates state.
// The dispatch diagram is drawn purely as boxes and arrows so the page
// stays a static poster suitable for D4rt's single-shot `build()`.
import 'dart:math' as math;
import 'dart:ui' show FontFeature, PathMetric;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// We pick literal ARGB values so the demo is theme-independent. The palette
// borrows from the "ocean cyan on porcelain" mood since the scroll system
// thinks in terms of axes, currents, and edges - all maritime metaphors.
const Color _kCanvas = Color(0xFFF3F6FA);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF7F9FC);
const Color _kCardDark = Color(0xFF0F172A);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF0F172A);
const Color _kInkSecondary = Color(0xFF334155);
const Color _kInkTertiary = Color(0xFF94A3B8);
const Color _kInkOnDark = Color(0xFFE2E8F0);
const Color _kInkOnDarkSecondary = Color(0xFF94A3B8);
const Color _kAccent = Color(0xFF0EA5E9); // sky-500
const Color _kAccentSoft = Color(0xFFE0F2FE);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kAccentOcean = Color(0xFF0284C7);
const Color _kAccentDeep = Color(0xFF0C4A6E);
const Color _kEdgeLeading = Color(0xFFF59E0B);
const Color _kEdgeTrailing = Color(0xFFE11D48);
const Color _kCodeBg = Color(0xFF0F172A);
const Color _kCodeText = Color(0xFFE2E8F0);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF64748B);

const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kBodySoftStyle = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoInlineStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.3,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE BUILDER HELPERS
// ---------------------------------------------------------------------------
// Helpers are top-level private functions returning Widgets. They are kept
// out of StatelessWidget subclasses so the file can be read top-to-bottom.

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 30.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(
  String title, {
  String? subtitle,
  Color titleColor = _kInk,
  Color subtitleColor = _kInkSecondary,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF1E293B)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: valueColour,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletList(List<String> items, {Color bulletColour = _kAccent}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items.map((String s) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 6.0, right: 8.0),
              child: Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: bulletColour,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(child: Text(s, style: _kBodySoftStyle)),
          ],
        ),
      );
    }).toList(),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------
Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0C4A6E), Color(0xFF0284C7), Color(0xFF06B6D4)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x330C4A6E),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'package:flutter/widgets.dart',
                style: TextStyle(
                  color: Color(0xFFE0F2FE),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'scroll_notification.dart',
                style: TextStyle(
                  color: Color(0xFFE0F2FE),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'ScrollNotification Family',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Start, Update, End, Overscroll, UserScroll and the dispatch path '
          'through NotificationListener<T> - one bubbling timeline.',
          style: TextStyle(
            color: Color(0xFFE0F2FE),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('ScrollStart', colour: const Color(0xFFFDE68A)),
            _pill('ScrollUpdate', colour: const Color(0xFF93C5FD)),
            _pill('ScrollEnd', colour: const Color(0xFFA7F3D0)),
            _pill('Overscroll', colour: const Color(0xFFFBCFE8)),
            _pill('UserScroll', colour: const Color(0xFFC4B5FD)),
            _pill('ScrollMetrics', colour: const Color(0xFFFCD34D)),
          ],
        ),
      ],
    ),
  );
}

Widget _heroIntroCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'What is a ScrollNotification?',
          subtitle:
              'A ScrollNotification is a Notification subclass dispatched by a '
              'Scrollable as its viewport scrolls. The notification bubbles up '
              'the widget tree and can be intercepted by any ancestor '
              'NotificationListener<T> with a matching type filter.',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'There is no global ScrollManager. The dispatch path is the build '
            'tree itself: a notification walks from the Scrollable that emitted '
            'it toward the root, hitting every NotificationListener on the '
            'way. Each listener\'s onNotification callback can return true to '
            'cancel further propagation. The notification carries .metrics '
            '(a ScrollMetrics snapshot), .depth (how many nested Scrollables '
            'have been crossed), and a .context to the dispatching element.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: _kInk,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _bulletList(const <String>[
                'Notification: dispatch(BuildContext) walks ancestors.',
                'ScrollNotification.depth: # of nested Scrollables crossed.',
                'ScrollNotification.metrics: ScrollMetrics snapshot.',
                'ScrollNotification.context: dispatching element (nullable).',
              ]),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _bulletList(const <String>[
                'ScrollStartNotification: drag begins or programmatic start.',
                'ScrollUpdateNotification: pixels changed; dragDetails optional.',
                'OverscrollNotification: pixels would exceed extent; ovDelta.',
                'ScrollEndNotification: rest reached; dragDetails optional.',
                'UserScrollNotification: ScrollDirection changed.',
                'ScrollMetricsNotification: viewport dims changed, no scroll.',
              ]),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - CLASS HIERARCHY (CustomPainter)
// ---------------------------------------------------------------------------
class _HierarchyPainter extends CustomPainter {
  const _HierarchyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = _kInkTertiary
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final Paint boxFill = Paint()
      ..color = _kCardBg
      ..style = PaintingStyle.fill;
    final Paint accentFill = Paint()
      ..color = _kAccentSoft
      ..style = PaintingStyle.fill;
    final Paint subtypeFill = Paint()
      ..color = const Color(0xFFFFF7ED)
      ..style = PaintingStyle.fill;

    // Top row: Notification (root)
    final Rect notif = Rect.fromCenter(
      center: Offset(size.width * 0.5, 28.0),
      width: 180.0,
      height: 38.0,
    );
    _drawBox(canvas, notif, accentFill, stroke, 'Notification', _kAccentDeep,
        bold: true);

    // Row 2: LayoutChangedNotification
    final Rect layoutChanged = Rect.fromCenter(
      center: Offset(size.width * 0.5, 96.0),
      width: 240.0,
      height: 38.0,
    );
    _drawBox(canvas, layoutChanged, boxFill, stroke,
        'LayoutChangedNotification', _kInk);
    _drawArrow(canvas, Offset(notif.center.dx, notif.bottom),
        Offset(layoutChanged.center.dx, layoutChanged.top), stroke);

    // Row 3a: ScrollNotification (left branch)
    final Rect scrollNotif = Rect.fromCenter(
      center: Offset(size.width * 0.32, 168.0),
      width: 200.0,
      height: 38.0,
    );
    _drawBox(canvas, scrollNotif, accentFill, stroke, 'ScrollNotification',
        _kAccentDeep, bold: true);
    _drawArrow(
        canvas,
        Offset(layoutChanged.left + 60.0, layoutChanged.bottom),
        Offset(scrollNotif.center.dx, scrollNotif.top),
        stroke);

    // Row 3b: ScrollMetricsNotification (right branch, sibling of
    // ScrollNotification but extends LayoutChangedNotification directly).
    final Rect metricsNotif = Rect.fromCenter(
      center: Offset(size.width * 0.72, 168.0),
      width: 240.0,
      height: 38.0,
    );
    _drawBox(canvas, metricsNotif, subtypeFill, stroke,
        'ScrollMetricsNotification', _kAccentAmber, bold: true);
    _drawArrow(
        canvas,
        Offset(layoutChanged.right - 60.0, layoutChanged.bottom),
        Offset(metricsNotif.center.dx, metricsNotif.top),
        stroke);

    // Subtype lane (5 boxes below ScrollNotification).
    const List<String> kSubtypes = <String>[
      'ScrollStartNotification',
      'ScrollUpdateNotification',
      'OverscrollNotification',
      'ScrollEndNotification',
      'UserScrollNotification',
    ];
    const List<Color> kSubtypeColours = <Color>[
      Color(0xFFFDE68A),
      Color(0xFF93C5FD),
      Color(0xFFFBCFE8),
      Color(0xFFA7F3D0),
      Color(0xFFC4B5FD),
    ];
    final double laneTop = 240.0;
    final double laneStep = 44.0;
    for (int i = 0; i < kSubtypes.length; i++) {
      final double y = laneTop + i * laneStep;
      final Rect r = Rect.fromCenter(
        center: Offset(size.width * 0.32, y),
        width: 220.0,
        height: 34.0,
      );
      final Paint p = Paint()..color = kSubtypeColours[i];
      _drawBox(canvas, r, p, stroke, kSubtypes[i], _kInk);
      // Bracket from ScrollNotification down to each subtype.
      final Offset start = Offset(scrollNotif.left + 30.0, scrollNotif.bottom);
      _drawElbow(canvas, start, Offset(r.left, r.center.dy), stroke);
    }
  }

  void _drawBox(
    Canvas canvas,
    Rect rect,
    Paint fill,
    Paint stroke,
    String label,
    Color textColour, {
    bool bold = false,
  }) {
    final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(8.0));
    canvas.drawRRect(rr, fill);
    canvas.drawRRect(rr, stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: textColour,
          fontSize: 12.5,
          fontFamily: 'monospace',
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width - 12.0);
    tp.paint(
      canvas,
      Offset(rect.center.dx - tp.width / 2.0, rect.center.dy - tp.height / 2.0),
    );
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Paint stroke) {
    canvas.drawLine(from, to, stroke);
    final Path p = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(to.dx - 4.0, to.dy - 6.0)
      ..lineTo(to.dx + 4.0, to.dy - 6.0)
      ..close();
    final Paint headFill = Paint()..color = _kInkTertiary;
    canvas.drawPath(p, headFill);
  }

  void _drawElbow(Canvas canvas, Offset from, Offset to, Paint stroke) {
    final Path path = Path()
      ..moveTo(from.dx, from.dy)
      ..lineTo(from.dx, to.dy)
      ..lineTo(to.dx, to.dy);
    canvas.drawPath(path, stroke);
    // Small dot at the destination tip.
    final Paint dot = Paint()..color = _kInkTertiary;
    canvas.drawCircle(to, 2.5, dot);
  }

  @override
  bool shouldRepaint(_HierarchyPainter oldDelegate) => false;
}

Widget _hierarchyCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Class hierarchy',
          subtitle:
              'ScrollNotification is one of two branches that descend from '
              'LayoutChangedNotification. The five concrete subtypes are '
              'what NotificationListener<T> ends up filtering on.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 460.0,
          child: CustomPaint(
            painter: const _HierarchyPainter(),
            size: const Size(double.infinity, 460.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: const <Widget>[
            _LegendDot(label: 'abstract', colour: _kAccent),
            _LegendDot(label: 'subtype', colour: _kAccentAmber),
            _LegendDot(label: 'sibling track', colour: _kAccentRose),
          ],
        ),
      ],
    ),
  );
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.label, required this.colour});

  final String label;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6.0),
        Text(label, style: _kCaptionStyle),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 - TIMELINE OF A SCROLL GESTURE (CustomPainter)
// ---------------------------------------------------------------------------
// We render a single user-driven drag gesture as a horizontal time axis,
// with notification markers placed at the moments they would be dispatched.
// This is purely a diagram - no real scroll activity is taking place.

class _TimelineEvent {
  const _TimelineEvent({
    required this.label,
    required this.t,
    required this.colour,
    required this.symbol,
    this.deltaPx,
    this.overscrollPx,
  });

  final String label;
  final double t; // 0.0 .. 1.0 along the timeline
  final Color colour;
  final String symbol;
  final double? deltaPx;
  final double? overscrollPx;
}

const List<_TimelineEvent> _kEvents = <_TimelineEvent>[
  _TimelineEvent(
    label: 'UserScroll(forward)',
    t: 0.04,
    colour: Color(0xFFC4B5FD),
    symbol: 'U',
  ),
  _TimelineEvent(
    label: 'ScrollStart',
    t: 0.08,
    colour: Color(0xFFFDE68A),
    symbol: 'S',
  ),
  _TimelineEvent(
    label: 'ScrollUpdate +12',
    t: 0.18,
    colour: Color(0xFF93C5FD),
    symbol: 'u',
    deltaPx: 12.0,
  ),
  _TimelineEvent(
    label: 'ScrollUpdate +18',
    t: 0.28,
    colour: Color(0xFF93C5FD),
    symbol: 'u',
    deltaPx: 18.0,
  ),
  _TimelineEvent(
    label: 'ScrollUpdate +24',
    t: 0.38,
    colour: Color(0xFF93C5FD),
    symbol: 'u',
    deltaPx: 24.0,
  ),
  _TimelineEvent(
    label: 'Overscroll +6',
    t: 0.48,
    colour: Color(0xFFFBCFE8),
    symbol: 'O',
    overscrollPx: 6.0,
  ),
  _TimelineEvent(
    label: 'ScrollUpdate +9',
    t: 0.58,
    colour: Color(0xFF93C5FD),
    symbol: 'u',
    deltaPx: 9.0,
  ),
  _TimelineEvent(
    label: 'ScrollUpdate +3',
    t: 0.70,
    colour: Color(0xFF93C5FD),
    symbol: 'u',
    deltaPx: 3.0,
  ),
  _TimelineEvent(
    label: 'ScrollEnd',
    t: 0.84,
    colour: Color(0xFFA7F3D0),
    symbol: 'E',
  ),
  _TimelineEvent(
    label: 'UserScroll(idle)',
    t: 0.94,
    colour: Color(0xFFC4B5FD),
    symbol: 'U',
  ),
];

class _TimelinePainter extends CustomPainter {
  const _TimelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double padLeft = 14.0;
    final double padRight = 14.0;
    final double axisY = size.height - 60.0;
    final double laneTop = 40.0;

    // Axis line.
    final Paint axis = Paint()
      ..color = _kInkTertiary
      ..strokeWidth = 1.4;
    canvas.drawLine(Offset(padLeft, axisY),
        Offset(size.width - padRight, axisY), axis);

    // Tick marks every 10%.
    for (int i = 0; i <= 10; i++) {
      final double x = padLeft +
          (size.width - padLeft - padRight) * (i / 10.0);
      canvas.drawLine(
        Offset(x, axisY - 4.0),
        Offset(x, axisY + 4.0),
        Paint()..color = _kInkTertiary,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${(i * 100 / 10).round()}ms',
          style: const TextStyle(
            color: _kInkTertiary,
            fontSize: 9.5,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2.0, axisY + 6.0));
    }

    // Drag-region shaded band (the period during which finger is down).
    final double dragStart = padLeft +
        (size.width - padLeft - padRight) * 0.08;
    final double dragEnd =
        padLeft + (size.width - padLeft - padRight) * 0.84;
    final Paint bandFill = Paint()
      ..color = _kAccent.withOpacity(0.08);
    canvas.drawRect(
      Rect.fromLTRB(dragStart, laneTop - 6.0, dragEnd, axisY - 6.0),
      bandFill,
    );
    final Paint bandBorder = Paint()
      ..color = _kAccent.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(
      Rect.fromLTRB(dragStart, laneTop - 6.0, dragEnd, axisY - 6.0),
      bandBorder,
    );
    final TextPainter dragLabel = TextPainter(
      text: const TextSpan(
        text: 'pointer down (drag active)',
        style: TextStyle(
          color: _kAccentDeep,
          fontSize: 10.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    dragLabel.paint(canvas,
        Offset(dragStart + 6.0, laneTop - 6.0 + 4.0));

    // Event markers.
    for (int i = 0; i < _kEvents.length; i++) {
      final _TimelineEvent ev = _kEvents[i];
      final double x = padLeft +
          (size.width - padLeft - padRight) * ev.t;
      // Vertical stem from axis to label-lane.
      canvas.drawLine(
        Offset(x, axisY),
        Offset(x, axisY - 40.0),
        Paint()
          ..color = ev.colour.withOpacity(0.7)
          ..strokeWidth = 1.5,
      );
      // Circle marker.
      final Paint markFill = Paint()..color = ev.colour;
      final Paint markStroke = Paint()
        ..color = _kInk
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(Offset(x, axisY - 40.0), 9.0, markFill);
      canvas.drawCircle(Offset(x, axisY - 40.0), 9.0, markStroke);
      final TextPainter sym = TextPainter(
        text: TextSpan(
          text: ev.symbol,
          style: const TextStyle(
            color: _kInk,
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      sym.paint(canvas,
          Offset(x - sym.width / 2.0, axisY - 40.0 - sym.height / 2.0));

      // Slanted label above marker.
      final TextPainter label = TextPainter(
        text: TextSpan(
          text: ev.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 10.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      // Stagger vertically by index parity to avoid overlap.
      final double labelY =
          axisY - 60.0 - (i.isEven ? 0.0 : 22.0);
      label.paint(canvas, Offset(x - label.width / 2.0, labelY));
    }
  }

  @override
  bool shouldRepaint(_TimelinePainter oldDelegate) => false;
}

Widget _timelineCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Timeline of a single gesture',
          subtitle:
              'One drag, ~1 second of wall clock. UserScroll(forward) fires '
              'just before ScrollStart, then a stream of ScrollUpdate, one '
              'Overscroll at the edge, ScrollEnd, and finally '
              'UserScroll(idle) when the ball lock releases.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 220.0,
          child: CustomPaint(
            painter: const _TimelinePainter(),
            size: const Size(double.infinity, 220.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Read order top-to-bottom: every marker on this axis is a real '
            'dispatch() call inside ScrollPosition.didStartScroll, '
            'didUpdateScrollPositionBy, didOverscrollBy, didEndScroll, and '
            'didUpdateScrollDirection respectively. A NotificationListener '
            'pinned to the root would see exactly this sequence.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - SCROLLMETRICS ANATOMY TABLE
// ---------------------------------------------------------------------------
Widget _metricsAnatomyCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ScrollMetrics anatomy',
          subtitle:
              'Every ScrollNotification carries an immutable .metrics value. '
              'These are the eleven fields you can read without owning a '
              'ScrollController.',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _MetricRow(
                name: 'pixels',
                type: 'double',
                desc: 'Current scroll offset; range [minScrollExtent, '
                    'maxScrollExtent] when in-range.',
              ),
              _MetricRow(
                name: 'minScrollExtent',
                type: 'double',
                desc: 'Smallest valid pixels value; usually 0.0.',
              ),
              _MetricRow(
                name: 'maxScrollExtent',
                type: 'double',
                desc: 'Largest valid pixels value; depends on content size.',
              ),
              _MetricRow(
                name: 'viewportDimension',
                type: 'double',
                desc: 'Visible scroll-axis size; the "window" length.',
              ),
              _MetricRow(
                name: 'axisDirection',
                type: 'AxisDirection',
                desc: 'down / up / right / left; combines axis and direction.',
              ),
              _MetricRow(
                name: 'axis',
                type: 'Axis',
                desc: 'Derived: Axis.vertical or Axis.horizontal.',
              ),
              _MetricRow(
                name: 'atEdge',
                type: 'bool',
                desc: 'pixels == minScrollExtent || pixels == maxScrollExtent.',
              ),
              _MetricRow(
                name: 'outOfRange',
                type: 'bool',
                desc: 'pixels < minScrollExtent || pixels > maxScrollExtent; '
                    'true during overscroll on bouncing physics.',
              ),
              _MetricRow(
                name: 'extentBefore',
                type: 'double',
                desc: 'pixels - minScrollExtent; how far above viewport.',
              ),
              _MetricRow(
                name: 'extentInside',
                type: 'double',
                desc: 'min(viewportDimension, max-min); typical = viewport.',
              ),
              _MetricRow(
                name: 'extentAfter',
                type: 'double',
                desc: 'maxScrollExtent - pixels; remaining content below.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Note: ScrollMetrics is immutable; the notification snapshots it at '
          'dispatch time. Reading metrics.pixels later through a controller '
          'may give a different value. For UI overlays driven by ScrollMetrics, '
          'always use the metrics from the notification rather than the live '
          'controller.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.name,
    required this.type,
    required this.desc,
  });

  final String name;
  final String type;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140.0,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: _kAccentDeep,
              ),
            ),
          ),
          SizedBox(
            width: 130.0,
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: _kAccentAmber,
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: _kInk,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 - OVERSCROLL EDGES PANEL
// ---------------------------------------------------------------------------
class _OverscrollPainter extends CustomPainter {
  const _OverscrollPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double mid = size.width / 2.0;
    final double viewportLeft = mid - 110.0;
    final double viewportRight = mid + 110.0;
    final double viewportTop = 60.0;
    final double viewportBottom = size.height - 70.0;

    final Paint viewportFill = Paint()
      ..color = const Color(0xFFF8FAFC);
    final Paint viewportStroke = Paint()
      ..color = _kInkSecondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final RRect viewportRR = RRect.fromRectAndRadius(
      Rect.fromLTRB(viewportLeft, viewportTop, viewportRight, viewportBottom),
      const Radius.circular(10.0),
    );
    canvas.drawRRect(viewportRR, viewportFill);
    canvas.drawRRect(viewportRR, viewportStroke);

    // Viewport label.
    final TextPainter vpLabel = TextPainter(
      text: const TextSpan(
        text: 'viewport',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    vpLabel.paint(
        canvas,
        Offset((viewportLeft + viewportRight) / 2.0 - vpLabel.width / 2.0,
            (viewportTop + viewportBottom) / 2.0 - vpLabel.height / 2.0));

    // Leading edge (top) - arrow pointing up out of viewport.
    final Paint leadingPaint = Paint()
      ..color = _kEdgeLeading
      ..strokeWidth = 2.5;
    canvas.drawLine(
      Offset(mid, viewportTop),
      Offset(mid, viewportTop - 30.0),
      leadingPaint,
    );
    _arrowHead(canvas, Offset(mid, viewportTop - 30.0),
        _kEdgeLeading, pointingUp: true);
    final TextPainter leadLbl = TextPainter(
      text: const TextSpan(
        text: 'leading edge\n'
            'pixels < minScrollExtent\n'
            'overscroll = pixels - minScrollExtent (negative)',
        style: TextStyle(
          color: _kInk,
          fontSize: 11.0,
          fontFamily: 'monospace',
          height: 1.45,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 220.0);
    leadLbl.paint(
        canvas,
        Offset(mid + 20.0, viewportTop - 36.0));

    // Trailing edge (bottom).
    final Paint trailingPaint = Paint()
      ..color = _kEdgeTrailing
      ..strokeWidth = 2.5;
    canvas.drawLine(
      Offset(mid, viewportBottom),
      Offset(mid, viewportBottom + 30.0),
      trailingPaint,
    );
    _arrowHead(canvas, Offset(mid, viewportBottom + 30.0),
        _kEdgeTrailing, pointingUp: false);
    final TextPainter trailLbl = TextPainter(
      text: const TextSpan(
        text: 'trailing edge\n'
            'pixels > maxScrollExtent\n'
            'overscroll = pixels - maxScrollExtent (positive)',
        style: TextStyle(
          color: _kInk,
          fontSize: 11.0,
          fontFamily: 'monospace',
          height: 1.45,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 220.0);
    trailLbl.paint(canvas,
        Offset(mid + 20.0, viewportBottom + 14.0));

    // ScrollDirection wedge labels on left.
    final TextPainter dirLbl = TextPainter(
      text: const TextSpan(
        text: 'ScrollDirection\n'
            '  idle\n'
            '  forward\n'
            '  reverse',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 11.0,
          fontFamily: 'monospace',
          height: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 160.0);
    dirLbl.paint(canvas, Offset(viewportLeft - 150.0, viewportTop + 8.0));

    // Inside-viewport tick scale.
    final Paint tickPaint = Paint()
      ..color = _kInkTertiary
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 4; i++) {
      final double y = viewportTop +
          (viewportBottom - viewportTop) * (i / 4.0);
      canvas.drawLine(
        Offset(viewportLeft - 4.0, y),
        Offset(viewportLeft + 4.0, y),
        tickPaint,
      );
    }
  }

  void _arrowHead(Canvas canvas, Offset tip, Color colour,
      {required bool pointingUp}) {
    final Path p = Path()..moveTo(tip.dx, tip.dy);
    if (pointingUp) {
      p
        ..lineTo(tip.dx - 6.0, tip.dy + 10.0)
        ..lineTo(tip.dx + 6.0, tip.dy + 10.0)
        ..close();
    } else {
      p
        ..lineTo(tip.dx - 6.0, tip.dy - 10.0)
        ..lineTo(tip.dx + 6.0, tip.dy - 10.0)
        ..close();
    }
    canvas.drawPath(p, Paint()..color = colour);
  }

  @override
  bool shouldRepaint(_OverscrollPainter oldDelegate) => false;
}

Widget _overscrollCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'OverscrollNotification & edges',
          subtitle:
              'OverscrollNotification fires when the physics simulation '
              'requests pixels outside [min, max]. ClampingScrollPhysics '
              'absorbs it into a glow; BouncingScrollPhysics lets pixels '
              'leave range and reports outOfRange == true.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 320.0,
          child: CustomPaint(
            painter: const _OverscrollPainter(),
            size: const Size(double.infinity, 320.0),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(child: _physicsBadge(
              title: 'ClampingScrollPhysics',
              subtitle: 'Android default. Overscroll absorbed as glow. '
                  'metrics.pixels stays in range; OverscrollNotification still '
                  'fires with the unconsumed delta.',
              colour: _kAccentGreen,
            )),
            const SizedBox(width: 10.0),
            Expanded(child: _physicsBadge(
              title: 'BouncingScrollPhysics',
              subtitle: 'iOS default. pixels leaves [min, max]; outOfRange '
                  'becomes true; OverscrollNotification reports the moment '
                  'of leaving range.',
              colour: _kAccentBlue,
            )),
          ],
        ),
      ],
    ),
  );
}

Widget _physicsBadge({
  required String title,
  required String subtitle,
  required Color colour,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: colour,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6.0),
        Text(subtitle, style: _kBodySoftStyle),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - NOTIFICATIONLISTENER<T> DISPATCH & DEPTH DIAGRAM
// ---------------------------------------------------------------------------
class _DispatchPainter extends CustomPainter {
  const _DispatchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const List<_NestEntry> nest = <_NestEntry>[
      _NestEntry(
        label: 'root NotificationListener<ScrollNotification>',
        subtitle: 'depth filter: only depth == 0',
        colour: _kAccent,
        isListener: true,
      ),
      _NestEntry(
        label: 'Scaffold (no listener)',
        subtitle: 'pure visual ancestor',
        colour: _kInkTertiary,
        isListener: false,
      ),
      _NestEntry(
        label: 'NotificationListener<ScrollUpdateNotification>',
        subtitle: 'typed filter: only Update events',
        colour: _kAccentBlue,
        isListener: true,
      ),
      _NestEntry(
        label: 'PageView (Scrollable - emitter A)',
        subtitle: 'emits at depth 0',
        colour: _kAccentTeal,
        isListener: false,
      ),
      _NestEntry(
        label: 'NotificationListener<ScrollNotification>',
        subtitle: 'sees both depths; usually returns false',
        colour: _kAccentViolet,
        isListener: true,
      ),
      _NestEntry(
        label: 'ListView (nested Scrollable - emitter B)',
        subtitle: 'emits at depth 0; bubbles -> depth 1 above',
        colour: _kAccentRose,
        isListener: false,
      ),
    ];

    final double pad = 18.0;
    final double topGap = 10.0;
    final double itemHeight = 50.0;
    final double width = size.width - 20.0;
    final double left = 10.0;
    double cur = topGap;

    for (int i = 0; i < nest.length; i++) {
      final _NestEntry e = nest[i];
      final double innerLeft = left + i * pad;
      final double innerWidth = width - i * pad * 2.0;
      final Rect r = Rect.fromLTWH(
        innerLeft,
        cur,
        innerWidth,
        size.height - cur - (nest.length - i) * pad - 10.0,
      );
      final Paint fill = Paint()
        ..color = e.colour.withOpacity(e.isListener ? 0.08 : 0.04);
      final Paint stroke = Paint()
        ..color = e.colour.withOpacity(e.isListener ? 0.7 : 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = e.isListener ? 1.6 : 1.0;
      if (!e.isListener) {
        stroke.color = e.colour.withOpacity(0.5);
      }
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(8.0));
      canvas.drawRRect(rr, fill);
      // Dashed stroke for non-listeners, solid for listeners.
      if (e.isListener) {
        canvas.drawRRect(rr, stroke);
      } else {
        _drawDashedRRect(canvas, rr, stroke);
      }
      // Label inside.
      final TextPainter labelTp = TextPainter(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: e.label,
              style: TextStyle(
                color: _kInk,
                fontSize: 11.5,
                fontFamily: 'monospace',
                fontWeight: e.isListener ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            TextSpan(
              text: '\n${e.subtitle}',
              style: const TextStyle(
                color: _kInkSecondary,
                fontSize: 10.5,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: innerWidth - 16.0);
      labelTp.paint(canvas, Offset(innerLeft + 8.0, cur + 6.0));
      cur += itemHeight;
    }

    // Upward bubble arrows on left margin.
    final Paint arrowPaint = Paint()
      ..color = _kAccentDeep
      ..strokeWidth = 1.4;
    for (int i = nest.length - 1; i > 0; i--) {
      final double y = topGap + i * itemHeight + 20.0;
      final double y2 = topGap + (i - 1) * itemHeight + 20.0;
      canvas.drawLine(Offset(6.0, y), Offset(6.0, y2), arrowPaint);
    }
    // Single arrow head at the top.
    final Path head = Path()
      ..moveTo(6.0, topGap + 8.0)
      ..lineTo(3.0, topGap + 16.0)
      ..lineTo(9.0, topGap + 16.0)
      ..close();
    canvas.drawPath(head, Paint()..color = _kAccentDeep);

    // Depth annotation on the right side.
    final TextPainter depthTp = TextPainter(
      text: const TextSpan(
        text: 'bubbles up\n'
            'depth++ at each\n'
            'enclosing Scrollable',
        style: TextStyle(
          color: _kAccentDeep,
          fontSize: 10.0,
          fontFamily: 'monospace',
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 160.0);
    depthTp.paint(canvas, Offset(size.width - 130.0, 14.0));
  }

  void _drawDashedRRect(Canvas canvas, RRect rr, Paint stroke) {
    final Path full = Path()..addRRect(rr);
    final Path dashed = Path();
    for (final PathMetric metric in full.computeMetrics()) {
      double dist = 0.0;
      while (dist < metric.length) {
        final double next = math.min(dist + 5.0, metric.length);
        dashed.addPath(metric.extractPath(dist, next), Offset.zero);
        dist = next + 4.0;
      }
    }
    canvas.drawPath(dashed, stroke);
  }

  @override
  bool shouldRepaint(_DispatchPainter oldDelegate) => false;
}

class _NestEntry {
  const _NestEntry({
    required this.label,
    required this.subtitle,
    required this.colour,
    required this.isListener,
  });

  final String label;
  final String subtitle;
  final Color colour;
  final bool isListener;
}

Widget _dispatchCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'NotificationListener<T> dispatch & depth',
          subtitle:
              'A notification bubbles from the dispatching Scrollable up the '
              'build tree. Every nested Scrollable encountered along the way '
              'increments .depth. Typed listeners filter by runtime type; '
              'returning true cancels further bubbling.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 380.0,
          child: CustomPaint(
            painter: const _DispatchPainter(),
            size: const Size(double.infinity, 380.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Solid borders = NotificationListener nodes. Dashed borders = '
            'inert ancestors. Each emitter dispatches at depth 0; the moment '
            'the notification crosses an enclosing Scrollable, depth becomes '
            '1, then 2, and so on. The classic "intercept only my own '
            'Scrollable" pattern is `(n) => n.depth == 0`.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - CODE SNIPPETS
// ---------------------------------------------------------------------------
Widget _codeSnippetsSection() {
  return Column(
    children: <Widget>[
      _codeBlock(
        title: 'typed_filter.dart',
        '// Listen only to ScrollUpdate, ignore other ScrollNotification types.\n'
        'NotificationListener<ScrollUpdateNotification>(\n'
        '  onNotification: (ScrollUpdateNotification n) {\n'
        '    debugPrint(\'updated by \${n.scrollDelta} to \${n.metrics.pixels}\');\n'
        '    return false; // let it bubble; we are observers, not absorbers.\n'
        '  },\n'
        '  child: ListView(children: items),\n'
        ');',
      ),
      _codeBlock(
        title: 'depth_zero_guard.dart',
        '// Only react to the outer-most Scrollable we wrap.\n'
        'NotificationListener<ScrollNotification>(\n'
        '  onNotification: (ScrollNotification n) {\n'
        '    if (n.depth != 0) return false; // ignore nested scrollables\n'
        '    if (n is ScrollEndNotification) {\n'
        '      // Persist last position, fire analytics, etc.\n'
        '    }\n'
        '    return false;\n'
        '  },\n'
        '  child: const _MyPage(),\n'
        ');',
      ),
      _codeBlock(
        title: 'observer.dart',
        '// ScrollNotificationObserver - shared across multiple widgets.\n'
        '// Used internally by AppBar to react to a NestedScrollView body.\n'
        'final ScrollNotificationObserverState? obs =\n'
        '    ScrollNotificationObserver.maybeOf(context);\n'
        'obs?.addListener((ScrollNotification n) {\n'
        '  // Listener is registered for the lifetime of the State.\n'
        '});',
      ),
      _codeBlock(
        title: 'dispatch_custom.dart',
        '// Dispatch a manual notification from a custom scrollable wrapper.\n'
        'void notify(ScrollPosition pos, BuildContext ctx) {\n'
        '  UserScrollNotification(\n'
        '    metrics: pos.copyWith(),\n'
        '    context: ctx,\n'
        '    direction: ScrollDirection.forward,\n'
        '  ).dispatch(ctx);\n'
        '}',
      ),
      _codeBlock(
        title: 'gotcha_no_setstate.dart',
        '// AVOID: do not call setState() synchronously inside onNotification\n'
        '// for non-end events; you will rebuild during the scroll frame and\n'
        '// race the engine.\n'
        'onNotification: (ScrollUpdateNotification n) {\n'
        '  // BAD: setState(() => _y = n.metrics.pixels);\n'
        '  // GOOD: store into a ValueNotifier, let listeners rebuild.\n'
        '  _scrollY.value = n.metrics.pixels;\n'
        '  return false;\n'
        '}',
      ),
      _codeBlock(
        title: 'metrics_snapshot.dart',
        '// metrics.pixels is the snapshot at dispatch time. Always read it\n'
        '// from the notification, not from a sibling ScrollController, to\n'
        '// avoid one-frame lag.\n'
        'onNotification: (ScrollNotification n) {\n'
        '  final ScrollMetrics m = n.metrics;\n'
        '  final double progress = m.maxScrollExtent <= m.minScrollExtent\n'
        '      ? 0.0\n'
        '      : (m.pixels - m.minScrollExtent) /\n'
        '          (m.maxScrollExtent - m.minScrollExtent);\n'
        '  return false;\n'
        '}',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - COMPARISON & PITFALLS
// ---------------------------------------------------------------------------
Widget _comparisonTableCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ScrollController vs ScrollNotification',
          subtitle:
              'Two ways to observe scrolling. Controllers push imperative '
              'commands and read live state; notifications are pull-style '
              'and ancestor-friendly.',
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kHairline),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              _ComparisonRow.header(),
              const _ComparisonRow(
                axis: 'Bind to widget',
                controller: 'Yes (one-to-many via PrimaryScrollController)',
                notification: 'No - any ancestor listener catches them',
              ),
              const _ComparisonRow(
                axis: 'Reads live offset',
                controller: 'Yes via controller.offset',
                notification: 'Only at notification dispatch (snapshot)',
              ),
              const _ComparisonRow(
                axis: 'Can issue jumpTo/animateTo',
                controller: 'Yes',
                notification: 'No - read-only signal',
              ),
              const _ComparisonRow(
                axis: 'Lifetime',
                controller: 'Must be disposed by owner',
                notification: 'Stateless; no lifetime',
              ),
              const _ComparisonRow(
                axis: 'Nested Scrollables',
                controller: 'Must be attached to a single position',
                notification: 'Distinguished via .depth',
              ),
              const _ComparisonRow(
                axis: 'Fires before drag',
                controller: 'No (only positions can be observed)',
                notification: 'UserScrollNotification(forward) fires first',
              ),
              const _ComparisonRow(
                axis: 'Sees overscroll',
                controller: 'Via position.outOfRange polling',
                notification: 'OverscrollNotification gives the delta',
              ),
              const _ComparisonRow(
                axis: 'Rebuild cost',
                controller: 'Listenable, rebuilds opt-in',
                notification: 'No rebuild unless listener calls setState',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.axis,
    required this.controller,
    required this.notification,
  }) : _isHeader = false;

  const _ComparisonRow.header()
      : axis = 'Axis',
        controller = 'ScrollController',
        notification = 'ScrollNotification',
        _isHeader = true;

  final String axis;
  final String controller;
  final String notification;
  final bool _isHeader;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = TextStyle(
      fontSize: 12.5,
      fontFamily: 'monospace',
      color: _isHeader ? _kAccentDeep : _kInk,
      fontWeight: _isHeader ? FontWeight.w700 : FontWeight.w500,
      height: 1.4,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _isHeader ? _kCardSoft : null,
        border: const Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140.0,
            child: Text(axis, style: base),
          ),
          Expanded(
            child: Text(
              controller,
              style: base.copyWith(color: _isHeader ? _kAccentDeep : _kInk),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              notification,
              style: base.copyWith(color: _isHeader ? _kAccentDeep : _kInk),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _pitfallsCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Pitfalls panel',
          subtitle:
              'Eight footguns that surface only after the demo ships. Each '
              'has a one-line antidote.',
        ),
        const SizedBox(height: 14.0),
        Column(
          children: const <Widget>[
            _PitfallEntry(
              colour: _kAccentRose,
              title: 'Forgot the depth==0 guard',
              body: 'A NotificationListener high in the tree captures all '
                  'nested Scrollables too. Inner ListView updates fire the '
                  'outer page-tracker. Fix: filter by n.depth == 0.',
            ),
            _PitfallEntry(
              colour: _kAccentAmber,
              title: 'PrimaryScrollController collision',
              body: 'A Scaffold body and a SliverList both adopt the ambient '
                  'PrimaryScrollController, both dispatch notifications. The '
                  'outer listener sees interleaved frames from two emitters.',
            ),
            _PitfallEntry(
              colour: _kAccentBlue,
              title: 'Returning true accidentally',
              body: 'onNotification: (n) { someWork(); return true; } cancels '
                  'bubbling. A higher listener (e.g. SliverAppBar\'s) goes '
                  'silent. Return false unless absorption is intentional.',
            ),
            _PitfallEntry(
              colour: _kAccentTeal,
              title: 'setState during ScrollUpdate',
              body: 'Calling setState in onScrollUpdate triggers a rebuild '
                  'every frame of the gesture. Route via ValueNotifier or '
                  'an AnimatedBuilder instead.',
            ),
            _PitfallEntry(
              colour: _kAccentViolet,
              title: 'Reading metrics later',
              body: 'metrics is captured at dispatch time. Storing the '
                  'notification reference and reading n.metrics.pixels in a '
                  'microtask still gives the snapshot, not the live value.',
            ),
            _PitfallEntry(
              colour: _kAccentGreen,
              title: 'Mistaking OverscrollNotification for ScrollEnd',
              body: 'OverscrollNotification fires during a drag too; it is '
                  'not an end-of-gesture signal. Pair it with a ScrollEnd '
                  'listener if you care about gesture completion.',
            ),
            _PitfallEntry(
              colour: _kAccentDeep,
              title: 'Listening for type erased to ScrollNotification',
              body: 'NotificationListener<Notification> catches the type but '
                  'loses the static guarantees. Always pick the narrowest '
                  'type that satisfies the use-case.',
            ),
            _PitfallEntry(
              colour: _kInkSecondary,
              title: 'UserScrollNotification fires twice',
              body: 'Once at the very start of a drag (forward / reverse) '
                  'and once again at the end (idle). If you want only the '
                  'start, gate on direction != ScrollDirection.idle.',
            ),
          ],
        ),
      ],
    ),
  );
}

class _PitfallEntry extends StatelessWidget {
  const _PitfallEntry({
    required this.colour,
    required this.title,
    required this.body,
  });

  final Color colour;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colour.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colour.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.warning_amber_rounded,
                color: colour, size: 16.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: colour,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(body, style: _kBodySoftStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
Widget _cheatSheetFooter() {
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Surface area of the ScrollNotification family at a glance.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 12.0),
        _cheatGroup('subtypes', const <String>[
          'ScrollStartNotification',
          'ScrollUpdateNotification',
          'ScrollEndNotification',
          'OverscrollNotification',
          'UserScrollNotification',
          'ScrollMetricsNotification',
        ], const Color(0xFF7DD3FC)),
        _cheatGroup('listener', const <String>[
          'NotificationListener<T>',
          'onNotification',
          'return true == cancel',
          'return false == bubble',
        ], const Color(0xFFFCD34D)),
        _cheatGroup('payload', const <String>[
          'n.metrics',
          'n.depth',
          'n.context',
          'n.scrollDelta',
          'n.overscroll',
          'n.direction',
        ], const Color(0xFFA7F3D0)),
        _cheatGroup('ScrollMetrics', const <String>[
          'pixels',
          'min/maxScrollExtent',
          'viewportDimension',
          'axisDirection',
          'atEdge',
          'outOfRange',
          'extentBefore / Inside / After',
        ], const Color(0xFFFBCFE8)),
        _cheatGroup('observer', const <String>[
          'ScrollNotificationObserver',
          'ScrollNotificationObserver.maybeOf(context)',
          'addListener / removeListener',
        ], const Color(0xFFC4B5FD)),
      ],
    ),
  );
}

Widget _cheatGroup(String title, List<String> labels, Color tint) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: labels.map((String s) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: tint.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(color: tint.withOpacity(0.4)),
              ),
              child: Text(
                s,
                style: TextStyle(
                  color: tint,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// PAGE ASSEMBLY
// ---------------------------------------------------------------------------
Widget _scrollNotificationPoster() {
  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroBanner(),
          _sectionHeader(
            1,
            'Intro & dispatch model',
            'ScrollNotification rides the build tree, not a global manager.',
          ),
          _heroIntroCard(),
          _sectionDivider(),
          _sectionHeader(
            2,
            'Class hierarchy',
            'Notification -> LayoutChangedNotification -> ScrollNotification.',
          ),
          _hierarchyCard(),
          _sectionDivider(),
          _sectionHeader(
            3,
            'Gesture timeline',
            'One drag, ten dispatches. Read left-to-right.',
          ),
          _timelineCard(),
          _sectionDivider(),
          _sectionHeader(
            4,
            'ScrollMetrics anatomy',
            'Eleven snapshot fields available through n.metrics.',
          ),
          _metricsAnatomyCard(),
          _sectionDivider(),
          _sectionHeader(
            5,
            'Overscroll edges',
            'Leading vs trailing, ClampingScrollPhysics vs BouncingScrollPhysics.',
          ),
          _overscrollCard(),
          _sectionDivider(),
          _sectionHeader(
            6,
            'Listener dispatch & depth',
            'Nested Scrollables bump .depth on the way up.',
          ),
          _dispatchCard(),
          _sectionDivider(),
          _sectionHeader(
            7,
            'Code recipes',
            'Six idioms, copy-paste ready.',
          ),
          _codeSnippetsSection(),
          _sectionDivider(),
          _sectionHeader(
            8,
            'Comparison & pitfalls',
            'Controller vs notification, eight footguns.',
          ),
          _comparisonTableCard(),
          _pitfallsCard(),
          const SizedBox(height: 18.0),
          _cheatSheetFooter(),
          const SizedBox(height: 28.0),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
// D4rt invokes `build(BuildContext)` exactly once. Everything above is
// const-friendly and side-effect-free; no controllers, no Timers, no async.
// The page is a pure projection of the ScrollNotification surface area.

dynamic build(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: MediaQuery(
      data: const MediaQueryData(),
      child: _scrollNotificationPoster(),
    ),
  );
}
