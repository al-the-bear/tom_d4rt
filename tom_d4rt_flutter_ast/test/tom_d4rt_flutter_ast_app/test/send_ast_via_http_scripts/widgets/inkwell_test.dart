// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - InkWell & InkResponse Atelier
// Theme: "Ink Response Atelier" - a curated workshop documenting every touch
// feedback surface of InkWell / InkResponse for the bridged interpreter.
import 'package:flutter/material.dart';

// =============================================================================
// HERO HEADER BANNER
// =============================================================================

Widget _heroBanner() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
          Color(0xFF880E4F),
        ],
        stops: [0.0, 0.35, 0.7, 1.0],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'ATELIER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'WIDGETS · MATERIAL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Ink Response Atelier',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A curated workshop of InkWell, InkResponse, splash & highlight surfaces',
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 15.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 18.0),
        Row(
          children: [
            _heroChip('InkWell'),
            SizedBox(width: 8.0),
            _heroChip('InkResponse'),
            SizedBox(width: 8.0),
            _heroChip('Splash'),
            SizedBox(width: 8.0),
            _heroChip('Highlight'),
            SizedBox(width: 8.0),
            _heroChip('Hover'),
            SizedBox(width: 8.0),
            _heroChip('Focus'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0x22FFFFFF),
      border: Border.all(color: Color(0x66FFFFFF), width: 1.0),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  );
}

// =============================================================================
// CONCEPT OVERVIEW
// =============================================================================

Widget _conceptOverview() {
  return Container(
    margin: EdgeInsets.all(20.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.0,
              height: 24.0,
              color: Color(0xFF4A148C),
            ),
            SizedBox(width: 10.0),
            Text(
              'About this atelier',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'InkWell and InkResponse are the canonical Material Design touch '
          'feedback widgets. They paint splash, highlight, hover and focus '
          'effects on top of an underlying Material widget. This atelier '
          'documents every visual surface and gesture callback in eleven '
          'curated sections.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.55,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 14.0),
        _conceptRow(
          Color(0xFF1A237E),
          'Material parent requirement',
          'InkWell must sit inside a Material ancestor — the ink is painted '
              'on the Material surface, not on the widget itself.',
        ),
        _conceptRow(
          Color(0xFF311B92),
          'Layered visual feedback',
          'Four distinct layers can be customised: splashColor (ripple), '
              'highlightColor (press tint), hoverColor (mouse over) and '
              'focusColor (keyboard focus).',
        ),
        _conceptRow(
          Color(0xFF4A148C),
          'Shape & clipping',
          'borderRadius and customBorder define the clip used for the ripple. '
              'Use ShapeBorder subclasses to match the underlying shape.',
        ),
        _conceptRow(
          Color(0xFF880E4F),
          'InkResponse vs InkWell',
          'InkResponse is the lower-level primitive; InkWell is just '
              'InkResponse with containedInkWell=true and a default highlight.',
        ),
      ],
    ),
  );
}

Widget _conceptRow(Color color, String title, String body) {
  return Padding(
    padding: EdgeInsets.only(top: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF212121),
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 13.0,
                  height: 1.4,
                  color: Color(0xFF616161),
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
// SHARED BUILDING BLOCKS
// =============================================================================

Widget _sectionBanner(int number, String title, String subtitle, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [color, color.withOpacity(0.65)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0x44FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            number.toString().padLeft(2, '0'),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color(0xDDFFFFFF),
                  fontSize: 13.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard(
  Color color,
  String label,
  List<List<String>> bullets,
) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #117, P5(a)):
  // Flutter forbids `borderRadius` on a `Border(...)` with non-uniform colors
  // (here: thick colored `left` + thin neutral `top/right/bottom`). Refactor
  // to canonical pattern: ClipRRect > IntrinsicHeight > Row(stretch, [accent
  // strip Container, Expanded(Padding(content))]) with a uniform
  // `Border.all`. Preserves the visual: colored left accent strip, light
  // border on the other sides, rounded right-side corners only.
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      ),
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.06),
            border: Border.all(color: color.withOpacity(0.2), width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(width: 4.0, color: color),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'RECIPE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bullets.map((b) {
            return Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '▸ ',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: '${b[0]}: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF212121),
                            ),
                          ),
                          TextSpan(text: b[1]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _comparisonTable(
  Color color,
  String title,
  List<String> headers,
  List<List<String>> rows,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
    decoration: BoxDecoration(
      border: Border.all(color: color.withOpacity(0.4), width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          color: color.withOpacity(0.05),
          child: Row(
            children: headers.map((h) {
              return Expanded(
                child: Text(
                  h,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF424242),
                    letterSpacing: 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Column(
          children: rows.asMap().entries.map((entry) {
            final i = entry.key;
            final r = entry.value;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              color: i.isEven ? Colors.white : Color(0xFFFAFAFA),
              child: Row(
                children: r.map((cell) {
                  return Expanded(
                    child: Text(
                      cell,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF424242),
                        height: 1.35,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _splashOverlay({
  required Color splashColor,
  required Alignment center,
  required double radiusFactor,
}) {
  return Positioned.fill(
    child: IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: center,
            radius: radiusFactor,
            colors: [
              splashColor.withOpacity(0.55),
              splashColor.withOpacity(0.35),
              splashColor.withOpacity(0.12),
              splashColor.withOpacity(0.0),
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
      ),
    ),
  );
}

Widget _highlightOverlay(Color color) {
  return Positioned.fill(
    child: IgnorePointer(
      child: Container(color: color.withOpacity(0.18)),
    ),
  );
}

Widget _focusRing(Color color, BorderRadius radius) {
  return Positioned.fill(
    child: IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: color, width: 2.5),
        ),
      ),
    ),
  );
}

Widget _stateBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withOpacity(0.5), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 10.0,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      ),
    ),
  );
}

// =============================================================================
// SECTION 1: INKWELL BASIC TAP
// =============================================================================

Widget _section1Basic() {
  final palette = _Section1Palette();
  return Column(
    children: [
      _sectionBanner(
        1,
        'InkWell Basic Tap',
        'The default ripple and highlight on a Material surface',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resting state',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: palette.muted,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Material(
              color: palette.surface,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.touch_app, color: palette.primary, size: 20.0),
                      SizedBox(width: 10.0),
                      Text(
                        'Tap me — observe the ripple',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: palette.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Mid-ripple snapshot (simulated)',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: palette.muted,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Material(
              color: palette.surface,
              borderRadius: BorderRadius.circular(8.0),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.water_drop,
                              color: palette.primary, size: 20.0),
                          SizedBox(width: 10.0),
                          Text(
                            'Ripple captured at t=0.55',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: palette.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _splashOverlay(
                    splashColor: palette.primary,
                    center: Alignment(-0.3, 0.0),
                    radiusFactor: 0.9,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              children: [
                _stateBadge('IDLE', palette.muted),
                SizedBox(width: 6.0),
                _stateBadge('PRESSING', palette.primary),
                SizedBox(width: 6.0),
                _stateBadge('RELEASED', palette.accent),
              ],
            ),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'Minimum viable InkWell',
        [
          ['Material', 'wrap your InkWell so the ink has a surface to paint on'],
          ['onTap', 'must be non-null for the widget to be enabled'],
          ['borderRadius', 'should match the parent Material for clean clipping'],
        ],
      ),
    ],
  );
}

class _Section1Palette {
  final primary = Color(0xFF1976D2);
  final accent = Color(0xFF42A5F5);
  final background = Color(0xFFE3F2FD);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFBBDEFB);
  final text = Color(0xFF0D47A1);
  final muted = Color(0xFF546E7A);
}

// =============================================================================
// SECTION 2: CUSTOM SPLASH COLOR
// =============================================================================

Widget _section2Splash() {
  final palette = _Section2Palette();
  final samples = <List<dynamic>>[
    ['Crimson', Color(0xFFE53935), Alignment(-0.5, 0.0)],
    ['Amber', Color(0xFFFFB300), Alignment(0.0, 0.0)],
    ['Teal', Color(0xFF00897B), Alignment(0.5, 0.2)],
    ['Indigo', Color(0xFF3949AB), Alignment(0.2, -0.3)],
  ];

  return Column(
    children: [
      _sectionBanner(
        2,
        'Custom Splash Color',
        'splashColor paints the expanding ripple wave',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: samples.map<Widget>((s) {
            final name = s[0] as String;
            final color = s[1] as Color;
            final pos = s[2] as Alignment;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Material(
                color: palette.surface,
                borderRadius: BorderRadius.circular(10.0),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      splashColor: color.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 18.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28.0,
                              height: 28.0,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 14.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$name splash',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: palette.text,
                                    ),
                                  ),
                                  Text(
                                    'splashColor: ${color.value.toRadixString(16).toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: palette.muted,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: palette.muted),
                          ],
                        ),
                      ),
                    ),
                    _splashOverlay(
                      splashColor: color,
                      center: pos,
                      radiusFactor: 0.85,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      _recipeCard(
        palette.primary,
        'Customising splashColor',
        [
          ['Opacity', 'always use opacity ≤ 0.5 so underlying content remains visible'],
          ['Theme override', 'theme-wide via ThemeData.splashColor for app-wide tone'],
          ['Brand colors', 'pair with brand primary for instantly-recognisable feedback'],
        ],
      ),
      _comparisonTable(
        palette.primary,
        'Splash color guidance by surface',
        ['Surface', 'Recommended', 'Avoid'],
        [
          ['Light card', 'Primary @0.30', 'Pure black @1.0'],
          ['Dark card', 'White @0.20', 'Saturated colors'],
          ['Colored bg', 'White @0.30', 'Same-hue color'],
          ['Glass', 'Accent @0.25', 'Opaque overlay'],
        ],
      ),
    ],
  );
}

class _Section2Palette {
  final primary = Color(0xFF6A1B9A);
  final accent = Color(0xFF8E24AA);
  final background = Color(0xFFF3E5F5);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFE1BEE7);
  final text = Color(0xFF4A148C);
  final muted = Color(0xFF6D4C7E);
}

// =============================================================================
// SECTION 3: HIGHLIGHT COLOR
// =============================================================================

Widget _section3Highlight() {
  final palette = _Section3Palette();
  return Column(
    children: [
      _sectionBanner(
        3,
        'Highlight Color',
        'highlightColor tints the surface while pressed',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _highlightDemo(
                    palette,
                    'Resting',
                    null,
                    Icons.radio_button_unchecked,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _highlightDemo(
                    palette,
                    'Pressed',
                    palette.accent,
                    Icons.radio_button_checked,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Row(
              children: [
                Expanded(
                  child: _highlightDemo(
                    palette,
                    'Soft',
                    Color(0xFFFFCC80).withOpacity(0.3),
                    Icons.brightness_low,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _highlightDemo(
                    palette,
                    'Strong',
                    Color(0xFFFF7043).withOpacity(0.5),
                    Icons.brightness_high,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'When to customise highlightColor',
        [
          ['Press feedback', 'use a tone darker than splashColor for tactile depth'],
          ['Transparent', 'Colors.transparent disables the highlight layer entirely'],
          ['Long-press', 'highlight remains while onLongPress is being awaited'],
        ],
      ),
    ],
  );
}

Widget _highlightDemo(
  _Section3Palette palette,
  String label,
  Color? highlight,
  IconData icon,
) {
  return Material(
    color: palette.surface,
    borderRadius: BorderRadius.circular(10.0),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        InkWell(
          onTap: () {},
          highlightColor: highlight,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 14.0),
            child: Column(
              children: [
                Icon(icon, color: palette.primary, size: 30.0),
                SizedBox(height: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: palette.text,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (highlight != null) _highlightOverlay(highlight),
      ],
    ),
  );
}

class _Section3Palette {
  final primary = Color(0xFFE65100);
  final accent = Color(0xFFFB8C00);
  final background = Color(0xFFFFF3E0);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFFFE0B2);
  final text = Color(0xFFBF360C);
  final muted = Color(0xFF8D6E63);
}

// =============================================================================
// SECTION 4: HOVER COLOR
// =============================================================================

Widget _section4Hover() {
  final palette = _Section4Palette();
  return Column(
    children: [
      _sectionBanner(
        4,
        'Hover Color',
        'hoverColor: the tint applied when the cursor enters',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mouse-hover cycle (simulated snapshots)',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: palette.muted,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 12.0),
            _hoverRow(palette, 'Cursor away', null, Icons.mouse_outlined),
            SizedBox(height: 8.0),
            _hoverRow(palette, 'Cursor entering',
                palette.accent.withOpacity(0.15), Icons.east),
            SizedBox(height: 8.0),
            _hoverRow(palette, 'Hover fully on',
                palette.accent.withOpacity(0.28), Icons.fullscreen),
            SizedBox(height: 8.0),
            _hoverRow(palette, 'Cursor leaving',
                palette.accent.withOpacity(0.10), Icons.west),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'Designing hover affordances',
        [
          ['Subtle', 'desktop convention: opacity 0.04–0.12'],
          ['Pointer', 'pair with MouseRegion if you need cursor changes'],
          ['Animate', 'transitions are handled internally by InkWell'],
        ],
      ),
    ],
  );
}

Widget _hoverRow(
  _Section4Palette palette,
  String label,
  Color? hoverTint,
  IconData icon,
) {
  return Material(
    color: palette.surface,
    borderRadius: BorderRadius.circular(10.0),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        InkWell(
          onTap: () {},
          onHover: (h) {},
          hoverColor: hoverTint ?? Color(0x00000000),
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                Icon(icon, color: palette.primary, size: 20.0),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: palette.text,
                    ),
                  ),
                ),
                if (hoverTint != null)
                  _stateBadge('HOVER', palette.primary)
                else
                  _stateBadge('IDLE', palette.muted),
              ],
            ),
          ),
        ),
        if (hoverTint != null)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(color: hoverTint),
            ),
          ),
      ],
    ),
  );
}

class _Section4Palette {
  final primary = Color(0xFF00695C);
  final accent = Color(0xFF26A69A);
  final background = Color(0xFFE0F2F1);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFB2DFDB);
  final text = Color(0xFF004D40);
  final muted = Color(0xFF607D8B);
}

// =============================================================================
// SECTION 5: FOCUS COLOR
// =============================================================================

Widget _section5Focus() {
  final palette = _Section5Palette();
  return Column(
    children: [
      _sectionBanner(
        5,
        'Focus Color',
        'focusColor: keyboard-focus tint for accessibility',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: [
            _focusRow(palette, 'Item A', false, false),
            SizedBox(height: 8.0),
            _focusRow(palette, 'Item B', true, true),
            SizedBox(height: 8.0),
            _focusRow(palette, 'Item C', false, false),
            SizedBox(height: 8.0),
            _focusRow(palette, 'Item D', false, false),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'Keyboard focus best practices',
        [
          ['canRequestFocus', 'set to false to opt out of focus navigation'],
          ['autofocus', 'use sparingly — only on the first input of a screen'],
          ['focusColor', 'must meet WCAG contrast against the surface'],
        ],
      ),
      _comparisonTable(
        palette.primary,
        'Focus vs hover semantics',
        ['Property', 'Hover', 'Focus'],
        [
          ['Trigger', 'Mouse enter', 'Tab key / requestFocus()'],
          ['Persistent', 'No — leaves on exit', 'Yes — until another widget'],
          ['Accessibility', 'Optional', 'Required (WCAG 2.4.7)'],
          ['Color', 'hoverColor', 'focusColor'],
        ],
      ),
    ],
  );
}

Widget _focusRow(
  _Section5Palette palette,
  String label,
  bool focused,
  bool autoFocus,
) {
  return Material(
    color: palette.surface,
    borderRadius: BorderRadius.circular(10.0),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        InkWell(
          onTap: () {},
          focusColor: palette.accent.withOpacity(0.18),
          autofocus: autoFocus,
          canRequestFocus: true,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                Icon(
                  focused ? Icons.adjust : Icons.circle_outlined,
                  color: focused ? palette.primary : palette.muted,
                  size: 20.0,
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: focused ? FontWeight.w800 : FontWeight.w500,
                      color: focused ? palette.text : palette.muted,
                    ),
                  ),
                ),
                if (focused) _stateBadge('FOCUSED', palette.primary),
              ],
            ),
          ),
        ),
        if (focused)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(color: palette.accent.withOpacity(0.18)),
            ),
          ),
        if (focused) _focusRing(palette.primary, BorderRadius.circular(10.0)),
      ],
    ),
  );
}

class _Section5Palette {
  final primary = Color(0xFF2E7D32);
  final accent = Color(0xFF66BB6A);
  final background = Color(0xFFE8F5E9);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFC8E6C9);
  final text = Color(0xFF1B5E20);
  final muted = Color(0xFF78909C);
}

// =============================================================================
// SECTION 6: CUSTOM BORDER SHAPES
// =============================================================================

Widget _section6CustomBorder() {
  final palette = _Section6Palette();
  return Column(
    children: [
      _sectionBanner(
        6,
        'Custom Border Shapes',
        'customBorder clips the ripple to any ShapeBorder',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: [
            _stadiumDemo(palette),
            SizedBox(height: 14.0),
            _circleDemo(palette),
            SizedBox(height: 14.0),
            _roundedRectDemo(palette),
            SizedBox(height: 14.0),
            _beveledDemo(palette),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'Matching the clip to the shape',
        [
          ['Stadium', 'great for pill-shaped action buttons'],
          ['Circle', 'use for icon buttons — combine with radius for ripple size'],
          ['RoundedRectangle', 'most common; mirror your card shape'],
          ['Custom', 'any ShapeBorder works — including BeveledRectangleBorder'],
        ],
      ),
      _comparisonTable(
        palette.primary,
        'borderRadius vs customBorder',
        ['Property', 'borderRadius', 'customBorder'],
        [
          ['Type', 'BorderRadius', 'ShapeBorder'],
          ['Flexibility', 'Rectangles only', 'Any ShapeBorder'],
          ['When', 'Simple rounded rects', 'Pills, circles, custom'],
          ['Wins if both set', 'customBorder takes priority', '—'],
        ],
      ),
    ],
  );
}

Widget _stadiumDemo(_Section6Palette palette) {
  return Material(
    color: palette.surface,
    shape: StadiumBorder(),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        InkWell(
          onTap: () {},
          customBorder: StadiumBorder(),
          splashColor: palette.accent.withOpacity(0.4),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 14.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.play_arrow, color: palette.primary, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Stadium Border',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: palette.text,
                  ),
                ),
                SizedBox(width: 100.0),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: StadiumBorder()),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.4, 0.0),
                    radius: 0.7,
                    colors: [
                      palette.accent.withOpacity(0.5),
                      palette.accent.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _circleDemo(_Section6Palette palette) {
  return Material(
    color: palette.surface,
    shape: CircleBorder(),
    clipBehavior: Clip.antiAlias,
    child: SizedBox(
      width: 80.0,
      height: 80.0,
      child: Stack(
        children: [
          InkWell(
            onTap: () {},
            customBorder: CircleBorder(),
            splashColor: palette.accent.withOpacity(0.45),
            radius: 50.0,
            child: Center(
              child: Icon(Icons.favorite, color: palette.primary, size: 28.0),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.8,
                      colors: [
                        palette.accent.withOpacity(0.45),
                        palette.accent.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _roundedRectDemo(_Section6Palette palette) {
  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
  );
  return Material(
    color: palette.surface,
    shape: shape,
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        InkWell(
          onTap: () {},
          customBorder: shape,
          splashColor: palette.accent.withOpacity(0.4),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
            child: Row(
              children: [
                Icon(Icons.crop_square, color: palette.primary, size: 22.0),
                SizedBox(width: 12.0),
                Text(
                  'Rounded Rectangle (16)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: palette.text,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: shape),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-0.4, 0.0),
                    radius: 0.75,
                    colors: [
                      palette.accent.withOpacity(0.4),
                      palette.accent.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _beveledDemo(_Section6Palette palette) {
  final shape = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );
  return Material(
    color: palette.surface,
    shape: shape,
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        InkWell(
          onTap: () {},
          customBorder: shape,
          splashColor: palette.accent.withOpacity(0.4),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
            child: Row(
              children: [
                Icon(Icons.diamond_outlined,
                    color: palette.primary, size: 22.0),
                SizedBox(width: 12.0),
                Text(
                  'Beveled Rectangle',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: palette.text,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: shape),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.3, -0.2),
                    radius: 0.8,
                    colors: [
                      palette.accent.withOpacity(0.4),
                      palette.accent.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _Section6Palette {
  final primary = Color(0xFFAD1457);
  final accent = Color(0xFFEC407A);
  final background = Color(0xFFFCE4EC);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFF8BBD0);
  final text = Color(0xFF880E4F);
  final muted = Color(0xFF8E5566);
}

// =============================================================================
// SECTION 7: RADIUS VARIATIONS
// =============================================================================

Widget _section7Radius() {
  final palette = _Section7Palette();
  final radii = <double>[20.0, 40.0, 60.0, 80.0, 100.0];

  return Column(
    children: [
      _sectionBanner(
        7,
        'Radius Variations',
        'radius caps the maximum reach of the ripple',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ripple radius preview at t=0.7',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: palette.muted,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: radii.map<Widget>((r) {
                return Column(
                  children: [
                    Material(
                      color: palette.surface,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        width: 56.0,
                        height: 56.0,
                        child: Stack(
                          children: [
                            InkResponse(
                              onTap: () {},
                              radius: r,
                              splashColor: palette.accent.withOpacity(0.4),
                              child: Center(
                                child: Text(
                                  r.toInt().toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    color: palette.text,
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      center: Alignment.center,
                                      radius: (r / 100.0).clamp(0.3, 1.0),
                                      colors: [
                                        palette.accent.withOpacity(0.5),
                                        palette.accent.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'r=${r.toInt()}',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: palette.muted,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'Tuning the radius',
        [
          ['Default', 'when null, the radius fills the parent bounds'],
          ['IconButton', 'flutter uses a fixed radius around 24.0 by default'],
          ['Custom', 'set explicitly for circular ripples on irregular widgets'],
        ],
      ),
    ],
  );
}

class _Section7Palette {
  final primary = Color(0xFF283593);
  final accent = Color(0xFF5C6BC0);
  final background = Color(0xFFE8EAF6);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFC5CAE9);
  final text = Color(0xFF1A237E);
  final muted = Color(0xFF546E7A);
}

// =============================================================================
// SECTION 8: CONTAINED INKWELL
// =============================================================================

Widget _section8Contained() {
  final palette = _Section8Palette();
  return Column(
    children: [
      _sectionBanner(
        8,
        'Contained Ink Splash',
        'containedInkWell + highlightShape — bounded vs unbounded ripples',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _containedDemo(
                    palette,
                    'containedInkWell: true',
                    true,
                    BoxShape.rectangle,
                    Icons.check_box_outlined,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _containedDemo(
                    palette,
                    'containedInkWell: false',
                    false,
                    BoxShape.circle,
                    Icons.radio_button_unchecked,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFFFFFDE7),
                border: Border.all(color: Color(0xFFFFE082), width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline,
                      color: Color(0xFFFF8F00), size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'InkWell is just InkResponse with containedInkWell=true '
                      'and a rectangular highlightShape. Use InkResponse '
                      'directly for circular, unbounded ripples (e.g. IconButton).',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF6D4C41),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'Bounded vs unbounded',
        [
          ['Bounded', 'ripple is clipped to the child bounds — typical for cards'],
          ['Unbounded', 'ripple expands past child — typical for icon buttons'],
          ['highlightShape', 'rectangle vs circle changes the press tint shape'],
        ],
      ),
    ],
  );
}

Widget _containedDemo(
  _Section8Palette palette,
  String label,
  bool contained,
  BoxShape shape,
  IconData icon,
) {
  return Material(
    color: palette.surface,
    borderRadius:
        shape == BoxShape.rectangle ? BorderRadius.circular(10.0) : null,
    shape: shape == BoxShape.circle ? CircleBorder() : null,
    clipBehavior: Clip.antiAlias,
    child: SizedBox(
      height: 110.0,
      child: Stack(
        children: [
          InkResponse(
            onTap: () {},
            containedInkWell: contained,
            highlightShape: shape,
            splashColor: palette.accent.withOpacity(0.4),
            radius: contained ? null : 80.0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: palette.primary, size: 28.0),
                  SizedBox(height: 6.0),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: palette.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  shape: shape,
                  borderRadius: shape == BoxShape.rectangle
                      ? BorderRadius.circular(10.0)
                      : null,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: contained ? 0.6 : 0.95,
                    colors: [
                      palette.accent.withOpacity(0.45),
                      palette.accent.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Section8Palette {
  final primary = Color(0xFF00838F);
  final accent = Color(0xFF26C6DA);
  final background = Color(0xFFE0F7FA);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFB2EBF2);
  final text = Color(0xFF006064);
  final muted = Color(0xFF607D8B);
}

// =============================================================================
// SECTION 9: SPLASH FACTORY
// =============================================================================

Widget _section9SplashFactory() {
  final palette = _Section9Palette();
  return Column(
    children: [
      _sectionBanner(
        9,
        'Splash Factory',
        'splashFactory swaps the entire ripple implementation',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: [
            _factoryDemo(
              palette,
              'InkSplash (default)',
              InkSplash.splashFactory,
              'Classic Material radial ripple',
              Alignment(-0.3, 0.0),
              0.7,
            ),
            SizedBox(height: 10.0),
            _factoryDemo(
              palette,
              'InkRipple',
              InkRipple.splashFactory,
              'Newer Material 3 ripple — smoother, broader',
              Alignment(0.0, 0.0),
              0.85,
            ),
            SizedBox(height: 10.0),
            _factoryDemo(
              palette,
              'NoSplash',
              NoSplash.splashFactory,
              'Disables the splash effect entirely',
              Alignment(0.0, 0.0),
              0.0,
            ),
          ],
        ),
      ),
      _recipeCard(
        palette.primary,
        'Choosing a splashFactory',
        [
          ['InkSplash', 'the historical default — sharp ripple edge'],
          ['InkRipple', 'modern softer ripple — paired with Material 3'],
          ['NoSplash', 'when you want feedback only via highlight/hover'],
          ['Custom', 'subclass InteractiveInkFeatureFactory for brand effects'],
        ],
      ),
    ],
  );
}

Widget _factoryDemo(
  _Section9Palette palette,
  String name,
  InteractiveInkFeatureFactory factory,
  String description,
  Alignment splashCenter,
  double splashRadius,
) {
  return Material(
    color: palette.surface,
    borderRadius: BorderRadius.circular(10.0),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        InkWell(
          onTap: () {},
          splashFactory: factory,
          splashColor: palette.accent.withOpacity(0.45),
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: palette.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.water,
                      color: palette.primary, size: 20.0),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                          color: palette.text,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: palette.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (splashRadius > 0.0)
          _splashOverlay(
            splashColor: palette.accent,
            center: splashCenter,
            radiusFactor: splashRadius,
          ),
      ],
    ),
  );
}

class _Section9Palette {
  final primary = Color(0xFF4527A0);
  final accent = Color(0xFF7E57C2);
  final background = Color(0xFFEDE7F6);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFD1C4E9);
  final text = Color(0xFF311B92);
  final muted = Color(0xFF5E548E);
}

// =============================================================================
// SECTION 10: INKWELL VS INKRESPONSE
// =============================================================================

Widget _section10InkVsResponse() {
  final palette = _Section10Palette();
  return Column(
    children: [
      _sectionBanner(
        10,
        'InkWell vs InkResponse',
        'Side-by-side comparison of the two primitives',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _inkWellSide(palette)),
                SizedBox(width: 12.0),
                Expanded(child: _inkResponseSide(palette)),
              ],
            ),
          ],
        ),
      ),
      _comparisonTable(
        palette.primary,
        'API surface comparison',
        ['Feature', 'InkWell', 'InkResponse'],
        [
          ['Default highlightShape', 'rectangle', 'circle'],
          ['containedInkWell', 'true (forced)', 'false (default)'],
          ['radius', 'bounded to child', 'free / configurable'],
          ['Typical use', 'cards, list rows', 'icon buttons'],
          ['Subclass relation', 'extends InkResponse', '—'],
          ['Default highlight', 'rectangular tint', 'circular tint'],
        ],
      ),
      _recipeCard(
        palette.primary,
        'When to pick which',
        [
          ['InkWell', 'almost always — for card-shaped, rectangular targets'],
          ['InkResponse', 'when you need a circular ripple that spills past child'],
          ['Material first', 'both require a Material ancestor — wrap accordingly'],
        ],
      ),
    ],
  );
}

Widget _inkWellSide(_Section10Palette palette) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: palette.primary,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          'InkWell',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Material(
        color: palette.surface,
        borderRadius: BorderRadius.circular(10.0),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 110.0,
          child: Stack(
            children: [
              InkWell(
                onTap: () {},
                splashColor: palette.accent.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.all(14.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.square_outlined,
                            color: palette.primary, size: 30.0),
                        SizedBox(height: 6.0),
                        Text(
                          'Rectangular',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: palette.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _splashOverlay(
                splashColor: palette.accent,
                center: Alignment(0.0, 0.0),
                radiusFactor: 0.7,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _inkResponseSide(_Section10Palette palette) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: palette.accent,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          'InkResponse',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Material(
        color: palette.surface,
        shape: CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 110.0,
          width: 110.0,
          child: Stack(
            children: [
              InkResponse(
                onTap: () {},
                splashColor: palette.accent.withOpacity(0.4),
                highlightShape: BoxShape.circle,
                radius: 60.0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle_outlined,
                          color: palette.accent, size: 30.0),
                      SizedBox(height: 6.0),
                      Text(
                        'Circular',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: palette.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.8,
                        colors: [
                          palette.accent.withOpacity(0.45),
                          palette.accent.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _Section10Palette {
  final primary = Color(0xFFBF360C);
  final accent = Color(0xFFFF7043);
  final background = Color(0xFFFBE9E7);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFFFCCBC);
  final text = Color(0xFF6D2917);
  final muted = Color(0xFF8D6E63);
}

// =============================================================================
// SECTION 11: GESTURE CALLBACK TAXONOMY
// =============================================================================

Widget _section11Gestures() {
  final palette = _Section11Palette();
  final gestures = <List<dynamic>>[
    ['onTap', 'Simple click / tap', Icons.touch_app, palette.primary],
    ['onDoubleTap', 'Two quick taps in succession', Icons.double_arrow,
        Color(0xFF1565C0)],
    ['onLongPress', 'Press and hold ~500ms', Icons.timer, Color(0xFF2E7D32)],
    ['onTapDown', 'Pointer goes down', Icons.arrow_downward,
        Color(0xFF6A1B9A)],
    ['onTapUp', 'Pointer goes up', Icons.arrow_upward, Color(0xFFAD1457)],
    ['onTapCancel', 'Gesture cancelled mid-press', Icons.cancel,
        Color(0xFFC62828)],
    ['onHover', 'Mouse enters / leaves', Icons.mouse, Color(0xFF00838F)],
    ['onFocusChange', 'Focus gained or lost', Icons.center_focus_strong,
        Color(0xFF4527A0)],
    ['onSecondaryTap', 'Right-click', Icons.swap_horiz, Color(0xFFEF6C00)],
    ['onSecondaryTapDown', 'Right-click pointer down', Icons.south_east,
        Color(0xFFD84315)],
    ['onSecondaryTapUp', 'Right-click pointer up', Icons.north_west,
        Color(0xFF5D4037)],
    ['onHighlightChanged', 'Highlight state toggled', Icons.flash_on,
        Color(0xFFFB8C00)],
  ];

  return Column(
    children: [
      _sectionBanner(
        11,
        'Gesture Callback Taxonomy',
        'Every gesture pin you can attach to an InkWell',
        palette.primary,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: palette.border, width: 1.0),
        ),
        child: Column(
          children: gestures.map<Widget>((g) {
            final name = g[0] as String;
            final desc = g[1] as String;
            final icon = g[2] as IconData;
            final color = g[3] as Color;
            return Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Material(
                color: palette.surface,
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () {},
                  onDoubleTap: () {},
                  onLongPress: () {},
                  onSecondaryTap: () {},
                  onTapCancel: () {},
                  onHover: (h) {},
                  onFocusChange: (f) {},
                  onHighlightChanged: (h) {},
                  onTapDown: (d) {},
                  onTapUp: (d) {},
                  onSecondaryTapDown: (d) {},
                  onSecondaryTapUp: (d) {},
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32.0,
                          height: 32.0,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Icon(icon, color: color, size: 18.0),
                        ),
                        SizedBox(width: 12.0),
                        SizedBox(
                          width: 150.0,
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w800,
                              color: palette.text,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            desc,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: palette.muted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      _comparisonTable(
        palette.primary,
        'Primary vs secondary tap',
        ['Action', 'Primary', 'Secondary'],
        [
          ['Button', 'Left-click / touch', 'Right-click'],
          ['Callback', 'onTap', 'onSecondaryTap'],
          ['Down', 'onTapDown', 'onSecondaryTapDown'],
          ['Up', 'onTapUp', 'onSecondaryTapUp'],
          ['Mobile', 'Tap', 'Long-press menu (platform-specific)'],
        ],
      ),
      _recipeCard(
        palette.primary,
        'Gesture binding tips',
        [
          ['Enable check', 'InkWell needs at least one non-null callback'],
          ['onTapCancel', 'use to revert visual state if the gesture aborts'],
          ['Conflicts', 'avoid wrapping in GestureDetector with overlapping callbacks'],
          ['Disabled', 'pass null to every callback to disable feedback entirely'],
        ],
      ),
    ],
  );
}

class _Section11Palette {
  final primary = Color(0xFF5D4037);
  final accent = Color(0xFF8D6E63);
  final background = Color(0xFFEFEBE9);
  final surface = Color(0xFFFFFFFF);
  final border = Color(0xFFD7CCC8);
  final text = Color(0xFF3E2723);
  final muted = Color(0xFF6D4C41);
}

// =============================================================================
// GLOSSARY PANEL
// =============================================================================

Widget _glossaryPanel() {
  final glossary = <List<String>>[
    ['Material', 'Ancestor widget on which the ink is painted; required.'],
    ['InkWell', 'Rectangular touch feedback widget; subclass of InkResponse.'],
    ['InkResponse', 'Lower-level primitive supporting any shape and radius.'],
    ['splashColor', 'The color of the expanding ripple wave.'],
    ['highlightColor', 'The color of the surface tint while pressed.'],
    ['hoverColor', 'The color tint applied when a mouse pointer enters.'],
    ['focusColor', 'The color tint applied when the widget has keyboard focus.'],
    ['customBorder', 'A ShapeBorder used to clip the ripple to a shape.'],
    ['borderRadius', 'Rectangle-only convenience for clipping the ripple.'],
    ['radius', 'Maximum radius the ripple may reach.'],
    ['containedInkWell', 'Whether the ripple is clipped to the child bounds.'],
    ['highlightShape', 'Rectangle or circle — the shape of the press tint.'],
    ['splashFactory', 'Factory that creates the ripple feature; swap to NoSplash to disable.'],
    ['InkSplash.splashFactory', 'Classic Material radial ripple.'],
    ['InkRipple.splashFactory', 'Modern Material 3 broader ripple.'],
    ['NoSplash.splashFactory', 'Disables the splash entirely while keeping highlights.'],
    ['onTap', 'Single primary tap callback; required to enable the widget.'],
    ['onDoubleTap', 'Two quick primary taps callback.'],
    ['onLongPress', 'Press-and-hold callback (~500ms).'],
    ['onTapDown', 'Pointer-down moment for the primary tap.'],
    ['onTapUp', 'Pointer-up moment for the primary tap.'],
    ['onTapCancel', 'Fires when a gesture is interrupted before completion.'],
    ['onHover', 'Mouse enter/leave callback receiving a bool.'],
    ['onFocusChange', 'Focus gained/lost callback receiving a bool.'],
    ['onSecondaryTap', 'Right-click / secondary pointer tap callback.'],
    ['onHighlightChanged', 'Notification when the highlight state toggles.'],
    ['canRequestFocus', 'Whether the widget participates in focus navigation.'],
    ['autofocus', 'Whether the widget should focus itself on mount.'],
    ['excludeFromSemantics', 'Whether to hide the widget from screen readers.'],
  ];

  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Color(0xFF4A148C), size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Glossary',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Every term used in this atelier, with one-line definitions.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xFF616161),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        Column(
          children: glossary.map((g) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: Color(0xFFEEEEEE), width: 1.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180.0,
                    child: Text(
                      g[0],
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4A148C),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      g[1],
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF424242),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// =============================================================================
// EPILOGUE
// =============================================================================

Widget _epilogue() {
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 28.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A237E),
          Color(0xFF4A148C),
          Color(0xFF880E4F),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFFFFD54F), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Atelier complete',
              style: TextStyle(
                color: Color(0xFFFFD54F),
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Eleven studies in ink',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'From a single onTap to the full taxonomy of secondary gestures, '
          'every visual surface and callback of InkWell and InkResponse has '
          'been catalogued. The bridged interpreter can now exercise each '
          'one with confidence.',
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 14.0,
            height: 1.55,
          ),
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0x22FFFFFF),
            border: Border.all(color: Color(0x55FFFFFF), width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Color(0xFFFFD54F), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Remember: ink is painted on the Material above, never on '
                  'the InkWell child — always wrap with Material first.',
                  style: TextStyle(
                    color: Color(0xEEFFFFFF),
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                    height: 1.45,
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
// ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Ink Response Atelier',
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heroBanner(),
            _conceptOverview(),
            _section1Basic(),
            _section2Splash(),
            _section3Highlight(),
            _section4Hover(),
            _section5Focus(),
            _section6CustomBorder(),
            _section7Radius(),
            _section8Contained(),
            _section9SplashFactory(),
            _section10InkVsResponse(),
            _section11Gestures(),
            _glossaryPanel(),
            _epilogue(),
          ],
        ),
      ),
    ),
  );
}
