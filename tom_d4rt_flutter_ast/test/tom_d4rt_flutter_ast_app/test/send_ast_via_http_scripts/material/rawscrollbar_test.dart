// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for RawScrollbar, Scrollbar,
// CupertinoScrollbar and ScrollbarThemeData
// Showcases every public parameter with live mini scrollable lists.
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ---------------------------------------------------------------------------
// Shared visual helpers
// ---------------------------------------------------------------------------

Color paletteAt(int index) {
  final List<Color> palette = <Color>[
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFEF6C00),
    Color(0xFFAD1457),
    Color(0xFF6A1B9A),
    Color(0xFF00838F),
    Color(0xFF4E342E),
    Color(0xFF37474F),
  ];
  return palette[index % palette.length];
}

Color tintAt(int index, double opacity) {
  return paletteAt(index).withOpacity(opacity);
}

Widget buildSectionDivider(String title, String subtitle, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.fromLTRB(0, 28, 0, 12),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[accent, accent.withOpacity(0.55)],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.35),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.line_axis, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.92),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

Widget buildExplanationCard(String title, String body, IconData icon,
    Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.06),
      border: Border.all(color: accent.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: accent, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: accent,
                ),
              ),
              SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildParameterPill(String name, String value, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 6, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.45)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          ': ',
          style: TextStyle(fontSize: 11, color: color),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget buildSampleScrollContent(int seed, int rows) {
  final List<Widget> items = <Widget>[];
  for (int i = 0; i < rows; i++) {
    items.add(
      Container(
        height: 44,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: tintAt(seed + i, 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 14,
              backgroundColor: paletteAt(seed + i),
              child: Text(
                '${i + 1}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Scroll row #${i + 1} for seed $seed',
                style: TextStyle(fontSize: 13),
              ),
            ),
            Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
  return Column(children: items);
}

Widget buildHorizontalSample(int seed, int cards) {
  final List<Widget> items = <Widget>[];
  for (int i = 0; i < cards; i++) {
    items.add(
      Container(
        width: 110,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: tintAt(seed + i, 0.18),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: paletteAt(seed + i)),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_module, color: paletteAt(seed + i)),
            SizedBox(height: 6),
            Text(
              'Card ${i + 1}',
              style: TextStyle(
                color: paletteAt(seed + i),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Row(children: items);
}

Widget framedScrollbar({
  required String label,
  required Widget scrollbar,
  required Color accent,
  double height = 180,
  double width = double.infinity,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withOpacity(0.5), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.08),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.12),
            borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.swap_vert, color: accent, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(6),
          child: scrollbar,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: RawScrollbar parameter gallery
// ---------------------------------------------------------------------------

Widget buildRawScrollbarGallery() {
  print('Section 1: Building RawScrollbar parameter gallery.');

  final ScrollController c1 = ScrollController();
  final ScrollController c2 = ScrollController();
  final ScrollController c3 = ScrollController();
  final ScrollController c4 = ScrollController();
  final ScrollController c5 = ScrollController();
  final ScrollController c6 = ScrollController();

  final Widget baseline = RawScrollbar(
    controller: c1,
    child: SingleChildScrollView(
      controller: c1,
      child: buildSampleScrollContent(0, 18),
    ),
  );

  final Widget visibleThumb = RawScrollbar(
    controller: c2,
    thumbVisibility: true,
    thumbColor: paletteAt(2),
    child: SingleChildScrollView(
      controller: c2,
      child: buildSampleScrollContent(1, 18),
    ),
  );

  final Widget thickThumb = RawScrollbar(
    controller: c3,
    thumbVisibility: true,
    thickness: 14.0,
    thumbColor: paletteAt(3).withOpacity(0.85),
    radius: Radius.circular(6),
    child: SingleChildScrollView(
      controller: c3,
      child: buildSampleScrollContent(2, 18),
    ),
  );

  final Widget radiusedThumb = RawScrollbar(
    controller: c4,
    thumbVisibility: true,
    thickness: 10.0,
    thumbColor: paletteAt(4),
    radius: Radius.circular(20),
    child: SingleChildScrollView(
      controller: c4,
      child: buildSampleScrollContent(3, 18),
    ),
  );

  final Widget paddedThumb = RawScrollbar(
    controller: c5,
    thumbVisibility: true,
    thickness: 8.0,
    thumbColor: paletteAt(5),
    radius: Radius.circular(4),
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 4),
    mainAxisMargin: 6,
    crossAxisMargin: 3,
    child: SingleChildScrollView(
      controller: c5,
      child: buildSampleScrollContent(4, 18),
    ),
  );

  final Widget minLengthThumb = RawScrollbar(
    controller: c6,
    thumbVisibility: true,
    thickness: 9.0,
    thumbColor: paletteAt(6),
    minThumbLength: 60,
    minOverscrollLength: 36,
    radius: Radius.circular(3),
    child: SingleChildScrollView(
      controller: c6,
      child: buildSampleScrollContent(5, 24),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '1. RawScrollbar parameter gallery',
        'Each tile demonstrates a single parameter of RawScrollbar in isolation.',
        paletteAt(0),
      ),
      buildExplanationCard(
        'RawScrollbar',
        'RawScrollbar is the foundation widget for showing a thumb that '
            'tracks a Scrollable. It exposes a wide surface of styling knobs '
            '— thumbColor, thickness, radius, padding, axis margins, '
            'minThumbLength, fade durations, and more — and is the base for '
            'Material Scrollbar and CupertinoScrollbar.',
        Icons.linear_scale,
        paletteAt(0),
      ),
      Wrap(
        children: <Widget>[
          buildParameterPill('thumbVisibility', 'bool', paletteAt(0)),
          buildParameterPill('thickness', 'double', paletteAt(0)),
          buildParameterPill('radius', 'Radius', paletteAt(0)),
          buildParameterPill('minThumbLength', 'double', paletteAt(0)),
          buildParameterPill('minOverscrollLength', 'double', paletteAt(0)),
          buildParameterPill('mainAxisMargin', 'double', paletteAt(0)),
          buildParameterPill('crossAxisMargin', 'double', paletteAt(0)),
        ],
      ),
      framedScrollbar(
        label: 'Baseline RawScrollbar (defaults, thumb hidden)',
        accent: paletteAt(0),
        scrollbar: baseline,
      ),
      framedScrollbar(
        label: 'thumbVisibility: true + thumbColor',
        accent: paletteAt(2),
        scrollbar: visibleThumb,
      ),
      framedScrollbar(
        label: 'thickness: 14, radius: 6',
        accent: paletteAt(3),
        scrollbar: thickThumb,
      ),
      framedScrollbar(
        label: 'radius: 20 (pill shape)',
        accent: paletteAt(4),
        scrollbar: radiusedThumb,
      ),
      framedScrollbar(
        label: 'padding + mainAxisMargin + crossAxisMargin',
        accent: paletteAt(5),
        scrollbar: paddedThumb,
      ),
      framedScrollbar(
        label: 'minThumbLength: 60, minOverscrollLength: 36',
        accent: paletteAt(6),
        scrollbar: minLengthThumb,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Fade timing / animation parameters
// ---------------------------------------------------------------------------

Widget buildFadeSection() {
  print('Section 2: Building fade and timing parameters.');

  final ScrollController f1 = ScrollController();
  final ScrollController f2 = ScrollController();
  final ScrollController f3 = ScrollController();
  final ScrollController f4 = ScrollController();

  final Widget snappy = RawScrollbar(
    controller: f1,
    thumbColor: paletteAt(1),
    fadeDuration: Duration(milliseconds: 80),
    timeToFade: Duration(milliseconds: 400),
    child: SingleChildScrollView(
      controller: f1,
      child: buildSampleScrollContent(7, 18),
    ),
  );

  final Widget defaultFade = RawScrollbar(
    controller: f2,
    thumbColor: paletteAt(2),
    fadeDuration: Duration(milliseconds: 300),
    timeToFade: Duration(milliseconds: 600),
    child: SingleChildScrollView(
      controller: f2,
      child: buildSampleScrollContent(8, 18),
    ),
  );

  final Widget lazy = RawScrollbar(
    controller: f3,
    thumbColor: paletteAt(3),
    fadeDuration: Duration(milliseconds: 800),
    timeToFade: Duration(seconds: 2),
    child: SingleChildScrollView(
      controller: f3,
      child: buildSampleScrollContent(9, 18),
    ),
  );

  final Widget pressed = RawScrollbar(
    controller: f4,
    thumbColor: paletteAt(4),
    thumbVisibility: true,
    pressDuration: Duration(milliseconds: 350),
    fadeDuration: Duration(milliseconds: 200),
    timeToFade: Duration(milliseconds: 500),
    child: SingleChildScrollView(
      controller: f4,
      child: buildSampleScrollContent(10, 18),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '2. Fade durations and press duration',
        'fadeDuration, timeToFade and pressDuration influence how the thumb '
            'appears, lingers, and reacts to drag-press gestures.',
        paletteAt(1),
      ),
      buildExplanationCard(
        'fadeDuration',
        'How long the thumb takes to fade in or out. Lower values give a '
            'snappier, more aggressive feel.',
        Icons.timer,
        paletteAt(1),
      ),
      buildExplanationCard(
        'timeToFade',
        'How long the thumb stays visible after scroll activity ends before '
            'starting to fade out.',
        Icons.hourglass_bottom,
        paletteAt(2),
      ),
      buildExplanationCard(
        'pressDuration',
        'How long a user must hold on the thumb before drag interactions are '
            'considered. Used to differentiate scroll grabs from taps.',
        Icons.touch_app,
        paletteAt(3),
      ),
      framedScrollbar(
        label: 'Snappy: fade 80ms, hold 400ms',
        accent: paletteAt(1),
        scrollbar: snappy,
      ),
      framedScrollbar(
        label: 'Default-ish: fade 300ms, hold 600ms',
        accent: paletteAt(2),
        scrollbar: defaultFade,
      ),
      framedScrollbar(
        label: 'Lazy: fade 800ms, hold 2000ms',
        accent: paletteAt(3),
        scrollbar: lazy,
      ),
      framedScrollbar(
        label: 'pressDuration: 350ms (drag-only after hold)',
        accent: paletteAt(4),
        scrollbar: pressed,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Track visibility and track styling
// ---------------------------------------------------------------------------

Widget buildTrackSection() {
  print('Section 3: Building track visibility and track styling.');

  final ScrollController t1 = ScrollController();
  final ScrollController t2 = ScrollController();
  final ScrollController t3 = ScrollController();
  final ScrollController t4 = ScrollController();

  final Widget trackOnly = RawScrollbar(
    controller: t1,
    thumbVisibility: true,
    trackVisibility: true,
    thumbColor: paletteAt(0),
    trackColor: paletteAt(0).withOpacity(0.18),
    trackBorderColor: paletteAt(0).withOpacity(0.5),
    thickness: 10,
    radius: Radius.circular(4),
    trackRadius: Radius.circular(4),
    child: SingleChildScrollView(
      controller: t1,
      child: buildSampleScrollContent(11, 18),
    ),
  );

  final Widget trackHighContrast = RawScrollbar(
    controller: t2,
    thumbVisibility: true,
    trackVisibility: true,
    thumbColor: Colors.black,
    trackColor: Colors.amber.shade200,
    trackBorderColor: Colors.amber.shade700,
    thickness: 12,
    radius: Radius.circular(2),
    trackRadius: Radius.circular(2),
    child: SingleChildScrollView(
      controller: t2,
      child: buildSampleScrollContent(12, 18),
    ),
  );

  final Widget trackTall = RawScrollbar(
    controller: t3,
    thumbVisibility: true,
    trackVisibility: true,
    thumbColor: paletteAt(5),
    trackColor: paletteAt(5).withOpacity(0.12),
    trackBorderColor: paletteAt(5).withOpacity(0.6),
    thickness: 8,
    radius: Radius.circular(8),
    trackRadius: Radius.circular(8),
    minThumbLength: 80,
    child: SingleChildScrollView(
      controller: t3,
      child: buildSampleScrollContent(13, 30),
    ),
  );

  final Widget trackInvisible = RawScrollbar(
    controller: t4,
    thumbVisibility: true,
    trackVisibility: false,
    thumbColor: paletteAt(6),
    thickness: 6,
    radius: Radius.circular(3),
    child: SingleChildScrollView(
      controller: t4,
      child: buildSampleScrollContent(14, 18),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '3. Track visibility and styling',
        'trackVisibility, trackColor, trackBorderColor and trackRadius shape '
            'the rail behind the thumb.',
        paletteAt(2),
      ),
      buildExplanationCard(
        'trackVisibility',
        'When true, the scroll track is painted behind the thumb whenever the '
            'thumb is visible. Use trackColor/trackBorderColor for styling.',
        Icons.format_align_justify,
        paletteAt(2),
      ),
      framedScrollbar(
        label: 'Soft tinted track + matching thumb',
        accent: paletteAt(0),
        scrollbar: trackOnly,
      ),
      framedScrollbar(
        label: 'High contrast amber track / black thumb',
        accent: Colors.amber.shade800,
        scrollbar: trackHighContrast,
      ),
      framedScrollbar(
        label: 'Long content, minThumbLength: 80',
        accent: paletteAt(5),
        scrollbar: trackTall,
      ),
      framedScrollbar(
        label: 'trackVisibility: false (thumb only)',
        accent: paletteAt(6),
        scrollbar: trackInvisible,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Scrollbar shape catalog and shape parameter
// ---------------------------------------------------------------------------

Widget buildShapeSection() {
  print('Section 4: Building shape catalog.');

  final ScrollController s1 = ScrollController();
  final ScrollController s2 = ScrollController();
  final ScrollController s3 = ScrollController();
  final ScrollController s4 = ScrollController();

  final OutlinedBorder stadiumShape = StadiumBorder(
    side: BorderSide(color: paletteAt(0), width: 1),
  );

  final OutlinedBorder beveledShape = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: BorderSide(color: paletteAt(2), width: 1),
  );

  final OutlinedBorder roundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: paletteAt(4), width: 1),
  );

  final OutlinedBorder circleShape = CircleBorder(
    side: BorderSide(color: paletteAt(6), width: 1),
  );

  final Widget stadiumBar = RawScrollbar(
    controller: s1,
    thumbVisibility: true,
    thickness: 16,
    thumbColor: paletteAt(0).withOpacity(0.85),
    shape: stadiumShape,
    child: SingleChildScrollView(
      controller: s1,
      child: buildSampleScrollContent(15, 20),
    ),
  );

  final Widget beveledBar = RawScrollbar(
    controller: s2,
    thumbVisibility: true,
    thickness: 14,
    thumbColor: paletteAt(2).withOpacity(0.85),
    shape: beveledShape,
    child: SingleChildScrollView(
      controller: s2,
      child: buildSampleScrollContent(16, 20),
    ),
  );

  final Widget roundedBar = RawScrollbar(
    controller: s3,
    thumbVisibility: true,
    thickness: 12,
    thumbColor: paletteAt(4).withOpacity(0.85),
    shape: roundedShape,
    child: SingleChildScrollView(
      controller: s3,
      child: buildSampleScrollContent(17, 20),
    ),
  );

  final Widget circleBar = RawScrollbar(
    controller: s4,
    thumbVisibility: true,
    thickness: 18,
    thumbColor: paletteAt(6).withOpacity(0.85),
    shape: circleShape,
    minThumbLength: 60,
    child: SingleChildScrollView(
      controller: s4,
      child: buildSampleScrollContent(18, 20),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '4. Scrollbar shape catalog',
        'The `shape` parameter accepts an OutlinedBorder. Stadium, beveled, '
            'rounded and circle borders all change the thumb silhouette.',
        paletteAt(3),
      ),
      buildExplanationCard(
        'shape: OutlinedBorder',
        'When non-null, `shape` overrides `radius` and produces the thumb '
            'shape directly. Useful for unusual scrollbar identities.',
        Icons.category,
        paletteAt(3),
      ),
      framedScrollbar(
        label: 'StadiumBorder shape',
        accent: paletteAt(0),
        scrollbar: stadiumBar,
      ),
      framedScrollbar(
        label: 'BeveledRectangleBorder shape',
        accent: paletteAt(2),
        scrollbar: beveledBar,
      ),
      framedScrollbar(
        label: 'RoundedRectangleBorder shape',
        accent: paletteAt(4),
        scrollbar: roundedBar,
      ),
      framedScrollbar(
        label: 'CircleBorder shape (with minThumbLength)',
        accent: paletteAt(6),
        scrollbar: circleBar,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: scrollbarOrientation and horizontal scrollbars
// ---------------------------------------------------------------------------

Widget buildOrientationSection() {
  print('Section 5: Building scrollbarOrientation showcase.');

  final ScrollController o1 = ScrollController();
  final ScrollController o2 = ScrollController();
  final ScrollController o3 = ScrollController();
  final ScrollController o4 = ScrollController();

  final Widget leftOriented = RawScrollbar(
    controller: o1,
    thumbVisibility: true,
    thumbColor: paletteAt(0),
    thickness: 10,
    radius: Radius.circular(6),
    scrollbarOrientation: ScrollbarOrientation.left,
    child: SingleChildScrollView(
      controller: o1,
      child: buildSampleScrollContent(19, 16),
    ),
  );

  final Widget rightOriented = RawScrollbar(
    controller: o2,
    thumbVisibility: true,
    thumbColor: paletteAt(2),
    thickness: 10,
    radius: Radius.circular(6),
    scrollbarOrientation: ScrollbarOrientation.right,
    child: SingleChildScrollView(
      controller: o2,
      child: buildSampleScrollContent(20, 16),
    ),
  );

  final Widget topOriented = RawScrollbar(
    controller: o3,
    thumbVisibility: true,
    thumbColor: paletteAt(4),
    thickness: 10,
    radius: Radius.circular(6),
    scrollbarOrientation: ScrollbarOrientation.top,
    child: SingleChildScrollView(
      controller: o3,
      scrollDirection: Axis.horizontal,
      child: buildHorizontalSample(0, 12),
    ),
  );

  final Widget bottomOriented = RawScrollbar(
    controller: o4,
    thumbVisibility: true,
    thumbColor: paletteAt(6),
    thickness: 10,
    radius: Radius.circular(6),
    scrollbarOrientation: ScrollbarOrientation.bottom,
    child: SingleChildScrollView(
      controller: o4,
      scrollDirection: Axis.horizontal,
      child: buildHorizontalSample(2, 12),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '5. scrollbarOrientation and horizontal scrolling',
        'ScrollbarOrientation.left / right / top / bottom places the rail on '
            'each side of the scrollable.',
        paletteAt(4),
      ),
      buildExplanationCard(
        'ScrollbarOrientation',
        'A four-value enum (left, right, top, bottom). When the scroll '
            'direction is vertical, left or right are valid; when horizontal, '
            'top or bottom. Default depends on TextDirection.',
        Icons.swap_horiz,
        paletteAt(4),
      ),
      framedScrollbar(
        label: 'orientation: left (vertical scroll)',
        accent: paletteAt(0),
        scrollbar: leftOriented,
      ),
      framedScrollbar(
        label: 'orientation: right (vertical scroll)',
        accent: paletteAt(2),
        scrollbar: rightOriented,
      ),
      framedScrollbar(
        label: 'orientation: top (horizontal scroll)',
        accent: paletteAt(4),
        scrollbar: topOriented,
        height: 140,
      ),
      framedScrollbar(
        label: 'orientation: bottom (horizontal scroll)',
        accent: paletteAt(6),
        scrollbar: bottomOriented,
        height: 140,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: interactive vs non-interactive + notificationPredicate
// ---------------------------------------------------------------------------

bool acceptDepthZero(ScrollNotification notification) {
  return notification.depth == 0;
}

bool acceptAnyDepth(ScrollNotification notification) {
  return notification.depth >= 0;
}

bool acceptVerticalOnly(ScrollNotification notification) {
  final ScrollMetrics metrics = notification.metrics;
  return metrics.axis == Axis.vertical;
}

Widget buildInteractiveSection() {
  print('Section 6: Building interactive vs non-interactive section.');

  final ScrollController i1 = ScrollController();
  final ScrollController i2 = ScrollController();
  final ScrollController i3 = ScrollController();
  final ScrollController i4 = ScrollController();

  final Widget interactiveBar = RawScrollbar(
    controller: i1,
    thumbVisibility: true,
    interactive: true,
    thumbColor: paletteAt(0),
    thickness: 12,
    radius: Radius.circular(6),
    notificationPredicate: acceptDepthZero,
    child: SingleChildScrollView(
      controller: i1,
      child: buildSampleScrollContent(21, 22),
    ),
  );

  final Widget passiveBar = RawScrollbar(
    controller: i2,
    thumbVisibility: true,
    interactive: false,
    thumbColor: paletteAt(2),
    thickness: 12,
    radius: Radius.circular(6),
    notificationPredicate: acceptDepthZero,
    child: SingleChildScrollView(
      controller: i2,
      child: buildSampleScrollContent(22, 22),
    ),
  );

  final Widget anyDepthBar = RawScrollbar(
    controller: i3,
    thumbVisibility: true,
    interactive: true,
    thumbColor: paletteAt(4),
    thickness: 10,
    radius: Radius.circular(4),
    notificationPredicate: acceptAnyDepth,
    child: SingleChildScrollView(
      controller: i3,
      child: buildSampleScrollContent(23, 22),
    ),
  );

  final Widget axisBoundBar = RawScrollbar(
    controller: i4,
    thumbVisibility: true,
    interactive: true,
    thumbColor: paletteAt(6),
    thickness: 10,
    radius: Radius.circular(4),
    notificationPredicate: acceptVerticalOnly,
    child: SingleChildScrollView(
      controller: i4,
      child: buildSampleScrollContent(24, 22),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '6. interactive + notificationPredicate',
        'interactive enables click/drag of the thumb; notificationPredicate '
            'filters which ScrollNotification objects the scrollbar listens to.',
        paletteAt(5),
      ),
      buildExplanationCard(
        'interactive',
        'When true (default on desktop) the thumb is clickable / draggable. '
            'When false the scrollbar is decorative only.',
        Icons.gesture,
        paletteAt(5),
      ),
      buildExplanationCard(
        'notificationPredicate',
        'A `bool Function(ScrollNotification)` filter. Default is depth==0. '
            'Override to listen to nested scrollables or specific axes.',
        Icons.filter_alt,
        paletteAt(0),
      ),
      framedScrollbar(
        label: 'interactive: true, depth==0',
        accent: paletteAt(0),
        scrollbar: interactiveBar,
      ),
      framedScrollbar(
        label: 'interactive: false (decorative)',
        accent: paletteAt(2),
        scrollbar: passiveBar,
      ),
      framedScrollbar(
        label: 'notificationPredicate: any depth',
        accent: paletteAt(4),
        scrollbar: anyDepthBar,
      ),
      framedScrollbar(
        label: 'notificationPredicate: vertical axis only',
        accent: paletteAt(6),
        scrollbar: axisBoundBar,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Material Scrollbar (the high level descendant)
// ---------------------------------------------------------------------------

Widget buildMaterialScrollbarSection() {
  print('Section 7: Building Material Scrollbar showcase.');

  final ScrollController m1 = ScrollController();
  final ScrollController m2 = ScrollController();
  final ScrollController m3 = ScrollController();
  final ScrollController m4 = ScrollController();

  final Widget defaultBar = Scrollbar(
    controller: m1,
    child: SingleChildScrollView(
      controller: m1,
      child: buildSampleScrollContent(25, 18),
    ),
  );

  final Widget alwaysOn = Scrollbar(
    controller: m2,
    thumbVisibility: true,
    trackVisibility: true,
    thickness: 10.0,
    radius: Radius.circular(6),
    child: SingleChildScrollView(
      controller: m2,
      child: buildSampleScrollContent(26, 18),
    ),
  );

  final Widget pressBar = Scrollbar(
    controller: m3,
    thumbVisibility: true,
    interactive: true,
    thickness: 12.0,
    radius: Radius.circular(4),
    notificationPredicate: acceptDepthZero,
    child: SingleChildScrollView(
      controller: m3,
      child: buildSampleScrollContent(27, 18),
    ),
  );

  final Widget themedBar = Theme(
    data: ThemeData(
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.dragged)) {
              return paletteAt(0);
            }
            if (states.contains(WidgetState.hovered)) {
              return paletteAt(2);
            }
            return paletteAt(4).withOpacity(0.7);
          },
        ),
        trackColor: WidgetStateProperty.all<Color>(
          paletteAt(4).withOpacity(0.12),
        ),
        trackBorderColor: WidgetStateProperty.all<Color>(
          paletteAt(4).withOpacity(0.4),
        ),
        thickness: WidgetStateProperty.all<double>(14.0),
        radius: Radius.circular(8.0),
        thumbVisibility: WidgetStateProperty.all<bool>(true),
        trackVisibility: WidgetStateProperty.all<bool>(true),
        interactive: true,
        crossAxisMargin: 4.0,
        mainAxisMargin: 8.0,
        minThumbLength: 48.0,
      ),
    ),
    child: Scrollbar(
      controller: m4,
      child: SingleChildScrollView(
        controller: m4,
        child: buildSampleScrollContent(28, 18),
      ),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '7. Material Scrollbar',
        'Scrollbar is the platform-aware Material wrapper around RawScrollbar. '
            'It picks up styling from ScrollbarThemeData via Theme.of(context).',
        paletteAt(6),
      ),
      buildExplanationCard(
        'Scrollbar',
        'Use Scrollbar by default in Material apps. It applies platform '
            'conventions (e.g. desktop vs touch) and reads from '
            'ScrollbarThemeData. Most parameters mirror RawScrollbar.',
        Icons.dashboard_customize,
        paletteAt(6),
      ),
      framedScrollbar(
        label: 'Scrollbar default',
        accent: paletteAt(0),
        scrollbar: defaultBar,
      ),
      framedScrollbar(
        label: 'thumbVisibility + trackVisibility',
        accent: paletteAt(2),
        scrollbar: alwaysOn,
      ),
      framedScrollbar(
        label: 'interactive: true + notificationPredicate',
        accent: paletteAt(4),
        scrollbar: pressBar,
      ),
      framedScrollbar(
        label: 'Themed via ScrollbarThemeData (WidgetStateProperty)',
        accent: paletteAt(6),
        scrollbar: themedBar,
        height: 200,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: CupertinoScrollbar
// ---------------------------------------------------------------------------

Widget buildCupertinoScrollbarSection() {
  print('Section 8: Building CupertinoScrollbar showcase.');

  final ScrollController cu1 = ScrollController();
  final ScrollController cu2 = ScrollController();
  final ScrollController cu3 = ScrollController();
  final ScrollController cu4 = ScrollController();

  final Widget defaultCupertino = CupertinoScrollbar(
    controller: cu1,
    child: SingleChildScrollView(
      controller: cu1,
      child: buildSampleScrollContent(29, 18),
    ),
  );

  final Widget thickCupertino = CupertinoScrollbar(
    controller: cu2,
    thumbVisibility: true,
    thickness: 6.0,
    thicknessWhileDragging: 12.0,
    radius: Radius.circular(3),
    radiusWhileDragging: Radius.circular(6),
    child: SingleChildScrollView(
      controller: cu2,
      child: buildSampleScrollContent(30, 18),
    ),
  );

  final Widget cupertinoInteractive = CupertinoScrollbar(
    controller: cu3,
    thumbVisibility: true,
    thickness: 8.0,
    thicknessWhileDragging: 16.0,
    radius: Radius.circular(4),
    radiusWhileDragging: Radius.circular(8),
    notificationPredicate: acceptDepthZero,
    child: SingleChildScrollView(
      controller: cu3,
      child: buildSampleScrollContent(31, 18),
    ),
  );

  final Widget cupertinoTiming = CupertinoScrollbar(
    controller: cu4,
    thumbVisibility: true,
    thickness: 5.0,
    thicknessWhileDragging: 10.0,
    radius: Radius.circular(2.5),
    radiusWhileDragging: Radius.circular(5),
    notificationPredicate: acceptAnyDepth,
    child: SingleChildScrollView(
      controller: cu4,
      child: buildSampleScrollContent(32, 18),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '8. CupertinoScrollbar',
        'CupertinoScrollbar adds iOS-style thicknessWhileDragging and '
            'radiusWhileDragging on top of RawScrollbar.',
        paletteAt(7),
      ),
      buildExplanationCard(
        'CupertinoScrollbar',
        'Designed to mimic iOS scroll indicators: thin while idle, expands '
            'while dragging. Extra parameters thicknessWhileDragging and '
            'radiusWhileDragging encode this animation.',
        Icons.phone_iphone,
        paletteAt(7),
      ),
      framedScrollbar(
        label: 'CupertinoScrollbar default',
        accent: paletteAt(0),
        scrollbar: defaultCupertino,
      ),
      framedScrollbar(
        label: 'thickness 6 -> 12 while dragging',
        accent: paletteAt(2),
        scrollbar: thickCupertino,
      ),
      framedScrollbar(
        label: 'thickness 8 -> 16, depth==0',
        accent: paletteAt(4),
        scrollbar: cupertinoInteractive,
      ),
      framedScrollbar(
        label: 'thickness 5 -> 10, any depth',
        accent: paletteAt(6),
        scrollbar: cupertinoTiming,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: ScrollbarThemeData reference table
// ---------------------------------------------------------------------------

Widget buildThemeReferenceRow(String parameter, String type, String purpose,
    Color accent) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: accent.withOpacity(0.2)),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            parameter,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: accent,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            type,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            purpose,
            style: TextStyle(color: Colors.grey.shade900, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget buildThemeReferenceTable() {
  print('Section 9: Building ScrollbarThemeData reference table.');

  final Color accent = paletteAt(0);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '9. ScrollbarThemeData reference',
        'Quick map of ScrollbarThemeData parameters to their types and '
            'purposes. Each value is a WidgetStateProperty where applicable.',
        accent,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withOpacity(0.4)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.12),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(11)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text('parameter',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: accent)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text('type',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: accent)),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('purpose',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: accent)),
                  ),
                ],
              ),
            ),
            buildThemeReferenceRow(
              'thumbColor',
              'WidgetStateProperty<Color?>',
              'Resolves the thumb color by scroll/hover/drag state.',
              accent,
            ),
            buildThemeReferenceRow(
              'trackColor',
              'WidgetStateProperty<Color?>',
              'Resolves the rail/track color.',
              accent,
            ),
            buildThemeReferenceRow(
              'trackBorderColor',
              'WidgetStateProperty<Color?>',
              'Resolves the rail border color.',
              accent,
            ),
            buildThemeReferenceRow(
              'thickness',
              'WidgetStateProperty<double?>',
              'Resolves the thumb thickness in logical pixels.',
              accent,
            ),
            buildThemeReferenceRow(
              'thumbVisibility',
              'WidgetStateProperty<bool?>',
              'Forces the thumb to be visible by state.',
              accent,
            ),
            buildThemeReferenceRow(
              'trackVisibility',
              'WidgetStateProperty<bool?>',
              'Forces the track to be visible by state.',
              accent,
            ),
            buildThemeReferenceRow(
              'radius',
              'Radius?',
              'Static radius applied to the thumb corners.',
              accent,
            ),
            buildThemeReferenceRow(
              'interactive',
              'bool?',
              'Whether the thumb is draggable.',
              accent,
            ),
            buildThemeReferenceRow(
              'crossAxisMargin',
              'double?',
              'Inset between the thumb and the scroll view edge.',
              accent,
            ),
            buildThemeReferenceRow(
              'mainAxisMargin',
              'double?',
              'Inset along the scroll direction.',
              accent,
            ),
            buildThemeReferenceRow(
              'minThumbLength',
              'double?',
              'Minimum thumb length even with very tall content.',
              accent,
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 10: ScrollMetrics anatomy & WidgetStateProperty composition
// ---------------------------------------------------------------------------

Widget buildMetricsRow(String label, String value, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.05),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent.withOpacity(0.25)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildScrollMetricsAnatomy() {
  print('Section 10: Building ScrollMetrics anatomy.');

  final ScrollMetrics sampleMetrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1200.0,
    pixels: 320.0,
    viewportDimension: 480.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 2.0,
  );

  final double extentBeforeRatio =
      sampleMetrics.extentBefore / (sampleMetrics.maxScrollExtent + 1);
  final double extentInsideRatio =
      sampleMetrics.extentInside / sampleMetrics.viewportDimension;

  final Color accent = paletteAt(3);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '10. ScrollMetrics anatomy',
        'The scrollbar consumes ScrollMetrics from its Scrollable to render '
            'the thumb. Below is a representative ScrollMetrics snapshot.',
        accent,
      ),
      buildExplanationCard(
        'ScrollMetrics',
        'A read-only snapshot of a scroll position. Provides minScrollExtent, '
            'maxScrollExtent, viewportDimension, pixels, axis, '
            'extentBefore/extentInside/extentAfter and the axisDirection.',
        Icons.straighten,
        accent,
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildMetricsRow(
              'minScrollExtent',
              sampleMetrics.minScrollExtent.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'maxScrollExtent',
              sampleMetrics.maxScrollExtent.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'viewportDimension',
              sampleMetrics.viewportDimension.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'pixels',
              sampleMetrics.pixels.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'axis',
              sampleMetrics.axis.toString(),
              accent,
            ),
            buildMetricsRow(
              'axisDirection',
              sampleMetrics.axisDirection.toString(),
              accent,
            ),
            buildMetricsRow(
              'extentBefore',
              sampleMetrics.extentBefore.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'extentInside',
              sampleMetrics.extentInside.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'extentAfter',
              sampleMetrics.extentAfter.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'devicePixelRatio',
              sampleMetrics.devicePixelRatio.toStringAsFixed(1),
              accent,
            ),
            buildMetricsRow(
              'extentBefore / max ratio',
              extentBeforeRatio.toStringAsFixed(3),
              accent,
            ),
            buildMetricsRow(
              'extentInside / viewport ratio',
              extentInsideRatio.toStringAsFixed(3),
              accent,
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 11: WidgetStateProperty<Color> live preview
// ---------------------------------------------------------------------------

Color resolveStatefulThumb(Set<WidgetState> states) {
  if (states.contains(WidgetState.dragged)) {
    return paletteAt(0);
  }
  if (states.contains(WidgetState.hovered)) {
    return paletteAt(2);
  }
  if (states.contains(WidgetState.pressed)) {
    return paletteAt(4);
  }
  return paletteAt(6).withOpacity(0.75);
}

Widget buildStateSwatch(String label, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget buildWidgetStatePreview() {
  print('Section 11: Building WidgetStateProperty<Color> preview.');

  final Set<WidgetState> idle = <WidgetState>{};
  final Set<WidgetState> hover = <WidgetState>{WidgetState.hovered};
  final Set<WidgetState> pressed = <WidgetState>{WidgetState.pressed};
  final Set<WidgetState> dragged = <WidgetState>{WidgetState.dragged};

  final Color idleColor = resolveStatefulThumb(idle);
  final Color hoverColor = resolveStatefulThumb(hover);
  final Color pressedColor = resolveStatefulThumb(pressed);
  final Color draggedColor = resolveStatefulThumb(dragged);

  final WidgetStateProperty<Color> property =
      WidgetStateProperty.resolveWith<Color>(resolveStatefulThumb);

  final Color resolvedIdle = property.resolve(idle);
  final Color resolvedHover = property.resolve(hover);
  final Color resolvedPressed = property.resolve(pressed);
  final Color resolvedDragged = property.resolve(dragged);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '11. WidgetStateProperty<Color> preview',
        'ScrollbarThemeData uses WidgetStateProperty<T> to resolve values '
            'against the current set of WidgetState values.',
        paletteAt(2),
      ),
      buildExplanationCard(
        'WidgetStateProperty<Color>',
        'A function-shaped value. The scrollbar passes the current scroll '
            'thumb state (idle/hovered/dragged/pressed) and receives a Color '
            'in return. Here we resolve four representative states.',
        Icons.palette,
        paletteAt(2),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: paletteAt(2).withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Direct resolveStatefulThumb() calls:',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: paletteAt(2),
              ),
            ),
            SizedBox(height: 6),
            Wrap(
              children: <Widget>[
                buildStateSwatch('idle', idleColor),
                buildStateSwatch('hovered', hoverColor),
                buildStateSwatch('pressed', pressedColor),
                buildStateSwatch('dragged', draggedColor),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'WidgetStateProperty.resolve(...) calls:',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: paletteAt(2),
              ),
            ),
            SizedBox(height: 6),
            Wrap(
              children: <Widget>[
                buildStateSwatch('idle', resolvedIdle),
                buildStateSwatch('hovered', resolvedHover),
                buildStateSwatch('pressed', resolvedPressed),
                buildStateSwatch('dragged', resolvedDragged),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 12: Visual anatomy diagram
// ---------------------------------------------------------------------------

Widget buildAnatomyDiagram() {
  print('Section 12: Building visual anatomy diagram.');

  final Color accent = paletteAt(4);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionDivider(
        '12. Scrollbar anatomy diagram',
        'A miniature reference of the scrollbar parts: track, thumb, margins, '
            'and the thumbnail-sized scrollable view.',
        accent,
      ),
      Container(
        height: 240,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withOpacity(0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Scrollable viewport',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: accent.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          children: <Widget>[
                            for (int i = 0; i < 4; i++)
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: tintAt(i, 0.18),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'row ${i + 1}',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 32,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8),
                  Container(
                    width: 6,
                    height: 12,
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: Container(
                      width: 12,
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.12),
                        border: Border.all(color: accent.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Container(
                            width: 12,
                            height: 70,
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Legend',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                  SizedBox(height: 8),
                  buildStateSwatch('track', accent.withOpacity(0.5)),
                  buildStateSwatch('thumb', accent),
                  buildStateSwatch('content', tintAt(2, 0.6)),
                  SizedBox(height: 6),
                  Text(
                    'Margins and padding apply between the track and the '
                    'viewport edge.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Top-level entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== RawScrollbar / Scrollbar / CupertinoScrollbar demo start ===');

  final Widget header = Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[paletteAt(0), paletteAt(4)],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paletteAt(0).withOpacity(0.3),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.white, size: 32),
            SizedBox(width: 12),
            Text(
              'Scrollbar family deep dive',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'RawScrollbar -> Scrollbar (Material) -> CupertinoScrollbar.\n'
          'This demo enumerates every public parameter visually and shows a '
          'ScrollbarThemeData reference table plus a ScrollMetrics anatomy.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.94),
            fontSize: 14,
          ),
        ),
      ],
    ),
  );

  print('Header built.');

  final Widget section1 = buildRawScrollbarGallery();
  print('Section 1 ready.');

  final Widget section2 = buildFadeSection();
  print('Section 2 ready.');

  final Widget section3 = buildTrackSection();
  print('Section 3 ready.');

  final Widget section4 = buildShapeSection();
  print('Section 4 ready.');

  final Widget section5 = buildOrientationSection();
  print('Section 5 ready.');

  final Widget section6 = buildInteractiveSection();
  print('Section 6 ready.');

  final Widget section7 = buildMaterialScrollbarSection();
  print('Section 7 ready.');

  final Widget section8 = buildCupertinoScrollbarSection();
  print('Section 8 ready.');

  final Widget section9 = buildThemeReferenceTable();
  print('Section 9 ready.');

  final Widget section10 = buildScrollMetricsAnatomy();
  print('Section 10 ready.');

  final Widget section11 = buildWidgetStatePreview();
  print('Section 11 ready.');

  final Widget section12 = buildAnatomyDiagram();
  print('Section 12 ready.');

  final Widget footer = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18, bottom: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: paletteAt(7).withOpacity(0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paletteAt(7).withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.check_circle, color: paletteAt(7), size: 22),
            SizedBox(width: 8),
            Text(
              'Demo complete',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: paletteAt(7),
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Twelve sections covered RawScrollbar parameters, fade/press '
          'durations, track styling, shape, scrollbarOrientation, '
          'interactivity, Material Scrollbar, CupertinoScrollbar, '
          'ScrollbarThemeData reference, ScrollMetrics anatomy, '
          'WidgetStateProperty<Color> resolution, and a visual anatomy.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
        ),
      ],
    ),
  );

  print('=== RawScrollbar / Scrollbar / CupertinoScrollbar demo end ===');

  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    appBar: AppBar(
      title: Text('Scrollbar family deep dive'),
      backgroundColor: paletteAt(0),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        header,
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        footer,
      ],
    ),
  );
}
