// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// Visual deep demo: the Flutter Row widget.
//
// Row is a thin horizontal specialization of Flex. Internally Flex hands the
// real layout work to RenderFlex, which knows about main axis (horizontal,
// for Row), cross axis (vertical), flex factors, and the various alignment
// enums. Understanding Row therefore means understanding RenderFlex.
//
// This file walks through every public lever Row exposes, and the visual
// effect each one has on three colored boxes laid out on a track ruler.
// Read it top to bottom; it is meant to be a hand-illustrated reference
// card, not a snippet collection.
//
// Single static `dynamic build(BuildContext)` entry. No runApp, no state,
// no controllers, no async. Everything below is drawn by composing widgets
// that are normally available to a Flutter UI builder.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color _kInkPrimary = Color(0xFF0F172A);
const Color _kInkSecondary = Color(0xFF334155);
const Color _kInkMuted = Color(0xFF64748B);
const Color _kPaper = Color(0xFFF8FAFC);
const Color _kPaperRaised = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFCBD5E1);
const Color _kRule = Color(0xFFE2E8F0);

const Color _kAccentRed = Color(0xFFEF4444);
const Color _kAccentOrange = Color(0xFFF97316);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentGreen = Color(0xFF10B981);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentBlue = Color(0xFF3B82F6);
const Color _kAccentIndigo = Color(0xFF6366F1);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kAccentPink = Color(0xFFEC4899);
const Color _kAccentSlate = Color(0xFF475569);

const double _kCardWidth = 760.0;
const double _kSectionGap = 28.0;

// ---------------------------------------------------------------------------
// Typography helpers
// ---------------------------------------------------------------------------

TextStyle _privateTitleStyle() {
  return TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: _kInkPrimary,
    letterSpacing: -0.4,
    height: 1.15,
  );
}

TextStyle _privateSubtitleStyle() {
  return TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    color: _kInkSecondary,
    height: 1.4,
  );
}

TextStyle _privateSectionStyle() {
  return TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: _kInkPrimary,
    letterSpacing: -0.2,
  );
}

TextStyle _privateBodyStyle() {
  return TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
    color: _kInkSecondary,
    height: 1.45,
  );
}

TextStyle _privateLabelStyle() {
  return TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: _kInkSecondary,
    letterSpacing: 0.4,
  );
}

TextStyle _privateMonoStyle({Color? color, double size = 12.5}) {
  return TextStyle(
    fontSize: size,
    fontFamily: 'monospace',
    color: color ?? _kInkPrimary,
    height: 1.35,
  );
}

TextStyle _privateChipStyle() {
  return TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.6,
  );
}

// ---------------------------------------------------------------------------
// Card chrome
// ---------------------------------------------------------------------------

Widget _privateCard({required Widget child, EdgeInsets? padding}) {
  return Container(
    width: _kCardWidth,
    padding: padding ?? EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: _kPaperRaised,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kBorder, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _kInkPrimary.withValues(alpha: 0.05),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: child,
  );
}

Widget _privateSectionHeader(String index, String title, String subtitle) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 38.0,
        height: 38.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _kInkPrimary,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          index,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      SizedBox(width: 14.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _privateSectionStyle()),
            SizedBox(height: 4.0),
            Text(subtitle, style: _privateBodyStyle()),
          ],
        ),
      ),
    ],
  );
}

Widget _privateChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(999.0),
    ),
    child: Text(text, style: _privateChipStyle()),
  );
}

Widget _privateDivider() {
  return Container(
    height: 1.0,
    color: _kRule,
    margin: EdgeInsets.symmetric(vertical: 14.0),
  );
}

Widget _privateCallout({
  required String title,
  required String body,
  required Color tint,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.0, color: tint),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: _kInkPrimary,
                ),
              ),
              SizedBox(height: 4.0),
              Text(body, style: _privateBodyStyle()),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Track ruler — the horizontal "stage" we lay Row demos on
// ---------------------------------------------------------------------------

Widget _privateTrack({required double width, required Widget child}) {
  return Container(
    width: width,
    height: 70.0,
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kBorder, width: 1.0),
    ),
    child: child,
  );
}

Widget _privateRuler({required double width}) {
  // Ten-tick ruler matching the track width. We assemble it with a Row of
  // ticks to keep the visual self-explanatory.
  final List<Widget> ticks = <Widget>[];
  for (int i = 0; i <= 10; i++) {
    ticks.add(
      Container(
        width: 1.0,
        height: i % 5 == 0 ? 8.0 : 5.0,
        color: _kInkMuted.withValues(alpha: 0.55),
      ),
    );
    if (i < 10) {
      ticks.add(Expanded(child: SizedBox.shrink()));
    }
  }
  return Container(
    width: width,
    padding: EdgeInsets.only(top: 4.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: ticks,
        ),
        SizedBox(height: 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('0', style: _privateMonoStyle(color: _kInkMuted, size: 9.5)),
            Text('25%', style: _privateMonoStyle(color: _kInkMuted, size: 9.5)),
            Text('50%', style: _privateMonoStyle(color: _kInkMuted, size: 9.5)),
            Text('75%', style: _privateMonoStyle(color: _kInkMuted, size: 9.5)),
            Text('100%',
                style: _privateMonoStyle(color: _kInkMuted, size: 9.5)),
          ],
        ),
      ],
    ),
  );
}

Widget _privateBox({
  required double width,
  required double height,
  required Color color,
  String? label,
}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: label == null
        ? null
        : Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
            ),
          ),
  );
}

Widget _privateCaptionedRow({
  required String caption,
  required String code,
  required Widget row,
  required double trackWidth,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(caption,
              style: _privateLabelStyle().copyWith(color: _kInkPrimary)),
          SizedBox(width: 10.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kPaper,
                border: Border.all(color: _kBorder, width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                code,
                style: _privateMonoStyle(color: _kInkSecondary, size: 11.0),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 6.0),
      _privateTrack(width: trackWidth, child: row),
      SizedBox(height: 2.0),
      _privateRuler(width: trackWidth),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Hero card
// ---------------------------------------------------------------------------

Widget _privateHeroIllustration() {
  // A stylized "horizontal flex" — three boxes on a track with arrows at the
  // edges signaling the main-axis direction.
  return Container(
    width: _kCardWidth - 44.0,
    height: 120.0,
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kBorder, width: 1.0),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.arrow_back, size: 18.0, color: _kInkMuted),
            SizedBox(width: 6.0),
            Expanded(
              child: Container(
                height: 2.0,
                color: _kInkMuted.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(width: 6.0),
            Text('main axis (horizontal)', style: _privateLabelStyle()),
            SizedBox(width: 6.0),
            Expanded(
              child: Container(
                height: 2.0,
                color: _kInkMuted.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(width: 6.0),
            Icon(Icons.arrow_forward, size: 18.0, color: _kInkMuted),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _privateBox(
                width: 70.0, height: 50.0, color: _kAccentRed, label: 'A'),
            _privateBox(
                width: 70.0, height: 50.0, color: _kAccentBlue, label: 'B'),
            _privateBox(
                width: 70.0, height: 50.0, color: _kAccentGreen, label: 'C'),
          ],
        ),
      ],
    ),
  );
}

Widget _privateHeroCard() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _privateChip('WIDGET', _kAccentBlue),
                      SizedBox(width: 6.0),
                      _privateChip('LAYOUT', _kAccentIndigo),
                      SizedBox(width: 6.0),
                      _privateChip('FLEX', _kAccentViolet),
                    ],
                  ),
                  SizedBox(height: 14.0),
                  Text('Row', style: _privateTitleStyle()),
                  SizedBox(height: 6.0),
                  Text(
                    'A horizontal Flex. Children share the main axis '
                    'according to their flex factor and alignment, '
                    'and stack along the cross axis according to '
                    'crossAxisAlignment.',
                    style: _privateSubtitleStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.0),
            Container(
              width: 64.0,
              height: 64.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kAccentBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(Icons.view_week_rounded,
                  size: 34.0, color: _kAccentBlue),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        _privateHeroIllustration(),
        SizedBox(height: 16.0),
        Row(
          children: [
            _privateChip('Flex', _kAccentSlate),
            SizedBox(width: 6.0),
            _privateChip('RenderFlex', _kAccentSlate),
            SizedBox(width: 6.0),
            _privateChip('Expanded', _kAccentTeal),
            SizedBox(width: 6.0),
            _privateChip('Flexible', _kAccentTeal),
            SizedBox(width: 6.0),
            _privateChip('Spacer', _kAccentTeal),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Anatomy panel
// ---------------------------------------------------------------------------

Widget _privateAnatomyDiagram() {
  return Container(
    width: _kCardWidth - 44.0,
    height: 200.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kBorder, width: 1.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, size: 16.0, color: _kAccentBlue),
            SizedBox(width: 6.0),
            Text('main axis →', style: _privateLabelStyle()),
            Expanded(child: SizedBox.shrink()),
            Text('← cross axis', style: _privateLabelStyle()),
            SizedBox(width: 6.0),
            Icon(Icons.swap_vert, size: 16.0, color: _kAccentPink),
          ],
        ),
        SizedBox(height: 12.0),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 30.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_upward,
                        size: 14.0,
                        color: _kAccentPink.withValues(alpha: 0.7)),
                    Text('cross',
                        style: _privateMonoStyle(
                            color: _kAccentPink, size: 9.5)),
                    Icon(Icons.arrow_downward,
                        size: 14.0,
                        color: _kAccentPink.withValues(alpha: 0.7)),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: _kPaperRaised,
                    border: Border.all(
                        color: _kAccentBlue.withValues(alpha: 0.4), width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back,
                          size: 14.0,
                          color: _kAccentBlue.withValues(alpha: 0.7)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _privateBox(
                                width: 56.0,
                                height: 90.0,
                                color: _kAccentRed,
                                label: '1'),
                            _privateBox(
                                width: 56.0,
                                height: 60.0,
                                color: _kAccentGreen,
                                label: '2'),
                            _privateBox(
                                width: 56.0,
                                height: 75.0,
                                color: _kAccentBlue,
                                label: '3'),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward,
                          size: 14.0,
                          color: _kAccentBlue.withValues(alpha: 0.7)),
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

Widget _privateAnatomyCard() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '1',
          'Anatomy of a Row',
          'Two perpendicular axes govern layout: main (horizontal) and '
              'cross (vertical).',
        ),
        SizedBox(height: 16.0),
        _privateAnatomyDiagram(),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateCallout(
                title: 'Main axis',
                body: 'Children are placed left-to-right '
                    '(or right-to-left if textDirection is rtl). '
                    'mainAxisAlignment + flex factors decide spacing.',
                tint: _kAccentBlue,
                icon: Icons.east,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _privateCallout(
                title: 'Cross axis',
                body: 'Vertical placement of each child. '
                    'crossAxisAlignment chooses start, end, center, '
                    'stretch, or baseline.',
                tint: _kAccentPink,
                icon: Icons.south,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — mainAxisAlignment gallery
// ---------------------------------------------------------------------------

Widget _privateMainAxisRow(MainAxisAlignment alignment) {
  return Row(
    mainAxisAlignment: alignment,
    children: [
      _privateBox(
          width: 54.0, height: 40.0, color: _kAccentRed, label: 'A'),
      _privateBox(
          width: 54.0, height: 40.0, color: _kAccentBlue, label: 'B'),
      _privateBox(
          width: 54.0, height: 40.0, color: _kAccentGreen, label: 'C'),
    ],
  );
}

Widget _privateMainAxisCard() {
  const double trackWidth = _kCardWidth - 44.0 - 24.0;
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '2',
          'mainAxisAlignment',
          'How free space along the main axis is distributed when '
              'mainAxisSize is max and there are no flex children.',
        ),
        SizedBox(height: 18.0),
        _privateCaptionedRow(
          caption: 'start',
          code: 'MainAxisAlignment.start',
          trackWidth: trackWidth,
          row: _privateMainAxisRow(MainAxisAlignment.start),
        ),
        SizedBox(height: 14.0),
        _privateCaptionedRow(
          caption: 'end',
          code: 'MainAxisAlignment.end',
          trackWidth: trackWidth,
          row: _privateMainAxisRow(MainAxisAlignment.end),
        ),
        SizedBox(height: 14.0),
        _privateCaptionedRow(
          caption: 'center',
          code: 'MainAxisAlignment.center',
          trackWidth: trackWidth,
          row: _privateMainAxisRow(MainAxisAlignment.center),
        ),
        SizedBox(height: 14.0),
        _privateCaptionedRow(
          caption: 'spaceBetween',
          code: 'MainAxisAlignment.spaceBetween',
          trackWidth: trackWidth,
          row: _privateMainAxisRow(MainAxisAlignment.spaceBetween),
        ),
        SizedBox(height: 14.0),
        _privateCaptionedRow(
          caption: 'spaceAround',
          code: 'MainAxisAlignment.spaceAround',
          trackWidth: trackWidth,
          row: _privateMainAxisRow(MainAxisAlignment.spaceAround),
        ),
        SizedBox(height: 14.0),
        _privateCaptionedRow(
          caption: 'spaceEvenly',
          code: 'MainAxisAlignment.spaceEvenly',
          trackWidth: trackWidth,
          row: _privateMainAxisRow(MainAxisAlignment.spaceEvenly),
        ),
        _privateDivider(),
        _privateCallout(
          title: 'spaceBetween vs spaceAround vs spaceEvenly',
          body: 'spaceBetween puts no space at the ends. spaceAround puts '
              'half-gaps at the ends. spaceEvenly distributes one full gap '
              'at every position, including the ends.',
          tint: _kAccentIndigo,
          icon: Icons.straighten,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — crossAxisAlignment gallery
// ---------------------------------------------------------------------------

Widget _privateCrossRow(CrossAxisAlignment alignment, {bool baseline = false}) {
  if (baseline) {
    return Row(
      crossAxisAlignment: alignment,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          width: 70.0,
          color: _kAccentRed.withValues(alpha: 0.15),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Text('Aa',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: _kAccentRed,
              )),
        ),
        SizedBox(width: 6.0),
        Container(
          width: 70.0,
          color: _kAccentBlue.withValues(alpha: 0.15),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Text('Bb',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: _kAccentBlue,
              )),
        ),
        SizedBox(width: 6.0),
        Container(
          width: 70.0,
          color: _kAccentGreen.withValues(alpha: 0.15),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Text('Cc',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                color: _kAccentGreen,
              )),
        ),
      ],
    );
  }
  return Row(
    crossAxisAlignment: alignment,
    children: [
      _privateBox(
          width: 50.0, height: 60.0, color: _kAccentRed, label: '60'),
      SizedBox(width: 8.0),
      _privateBox(
          width: 50.0, height: 30.0, color: _kAccentBlue, label: '30'),
      SizedBox(width: 8.0),
      _privateBox(
          width: 50.0, height: 45.0, color: _kAccentGreen, label: '45'),
    ],
  );
}

Widget _privateCrossCard() {
  const double trackWidth = _kCardWidth - 44.0 - 24.0;
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '3',
          'crossAxisAlignment',
          'How children are placed perpendicular to the main axis. '
              'Demo children have heights 60, 30, 45.',
        ),
        SizedBox(height: 18.0),
        _privateCaptionedRow(
          caption: 'start',
          code: 'CrossAxisAlignment.start',
          trackWidth: trackWidth,
          row: _privateCrossRow(CrossAxisAlignment.start),
        ),
        SizedBox(height: 14.0),
        _privateCaptionedRow(
          caption: 'end',
          code: 'CrossAxisAlignment.end',
          trackWidth: trackWidth,
          row: _privateCrossRow(CrossAxisAlignment.end),
        ),
        SizedBox(height: 14.0),
        _privateCaptionedRow(
          caption: 'center',
          code: 'CrossAxisAlignment.center',
          trackWidth: trackWidth,
          row: _privateCrossRow(CrossAxisAlignment.center),
        ),
        SizedBox(height: 14.0),
        Text('stretch', style: _privateLabelStyle()),
        SizedBox(height: 4.0),
        Text(
          'CrossAxisAlignment.stretch — children must have null height '
          'in the cross axis. We force a fixed-height track here.',
          style: _privateBodyStyle(),
        ),
        SizedBox(height: 6.0),
        _privateTrack(
          width: trackWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 50.0,
                color: _kAccentRed,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
              ),
              Container(
                width: 50.0,
                color: _kAccentBlue,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
              ),
              Container(
                width: 50.0,
                color: _kAccentGreen,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _privateRuler(width: trackWidth),
        SizedBox(height: 18.0),
        Text('baseline', style: _privateLabelStyle()),
        SizedBox(height: 4.0),
        Text(
          'CrossAxisAlignment.baseline + textBaseline aligns the text '
          'baselines of children that report one (typically Text).',
          style: _privateBodyStyle(),
        ),
        SizedBox(height: 6.0),
        Container(
          width: trackWidth,
          height: 70.0,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: _kPaper,
            border: Border.all(color: _kBorder, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child:
              _privateCrossRow(CrossAxisAlignment.baseline, baseline: true),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — mainAxisSize panel
// ---------------------------------------------------------------------------

Widget _privateSizePanel() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('mainAxisSize.max', style: _privateLabelStyle()),
            SizedBox(height: 4.0),
            Text(
              'Default. The Row claims as much horizontal space as its '
              'parent gives it — typically the full width of the screen.',
              style: _privateBodyStyle(),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: _kPaper,
                border: Border.all(
                    color: _kAccentBlue.withValues(alpha: 0.6), width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _privateBox(
                      width: 40.0,
                      height: 40.0,
                      color: _kAccentRed,
                      label: 'A'),
                  SizedBox(width: 6.0),
                  _privateBox(
                      width: 40.0,
                      height: 40.0,
                      color: _kAccentGreen,
                      label: 'B'),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              '↑ The Row stretches across; free space sits to the right.',
              style: _privateMonoStyle(color: _kInkMuted, size: 11.0),
            ),
          ],
        ),
      ),
      SizedBox(width: 14.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('mainAxisSize.min', style: _privateLabelStyle()),
            SizedBox(height: 4.0),
            Text(
              'The Row hugs its children. Its width is the sum of children '
              'plus any explicit gaps. Useful inside Wrap, Chip, etc.',
              style: _privateBodyStyle(),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: _kPaper,
                border: Border.all(
                    color: _kAccentPink.withValues(alpha: 0.6), width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _privateBox(
                      width: 40.0,
                      height: 40.0,
                      color: _kAccentRed,
                      label: 'A'),
                  SizedBox(width: 6.0),
                  _privateBox(
                      width: 40.0,
                      height: 40.0,
                      color: _kAccentGreen,
                      label: 'B'),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              '↑ The Row is exactly as wide as A + gap + B.',
              style: _privateMonoStyle(color: _kInkMuted, size: 11.0),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _privateSizeCard() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '4',
          'mainAxisSize',
          'Whether the Row claims the full width of its parent or hugs '
              'its children.',
        ),
        SizedBox(height: 18.0),
        _privateSizePanel(),
        SizedBox(height: 14.0),
        _privateCallout(
          title: 'Common bug',
          body: 'mainAxisSize.min combined with Expanded throws — Expanded '
              'demands all leftover space, but min refuses to take any '
              'in the first place.',
          tint: _kAccentRed,
          icon: Icons.error_outline,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Expanded / Flexible / Spacer distribution
// ---------------------------------------------------------------------------

Widget _privateFlexLabel(String s, Color c) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      s,
      style: TextStyle(
        fontSize: 11.0,
        fontFamily: 'monospace',
        color: c,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _privateFlexCard() {
  const double trackWidth = _kCardWidth - 44.0 - 24.0;
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '5',
          'Expanded · Flexible · Spacer',
          'Flex children get a slice of the leftover space. Their slice '
              'is proportional to the flex factor.',
        ),
        SizedBox(height: 18.0),
        Text('1 : 1 : 1 — three Expanded children with default flex',
            style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        _privateTrack(
          width: trackWidth,
          child: Row(
            children: [
              Expanded(
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentRed),
              ),
              Expanded(
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentBlue),
              ),
              Expanded(
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentGreen),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text('2 : 1 : 1 — first child is twice as wide',
            style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        _privateTrack(
          width: trackWidth,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentRed),
              ),
              Expanded(
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentBlue),
              ),
              Expanded(
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentGreen),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text('1 : 2 : 3 — staircase widths', style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        _privateTrack(
          width: trackWidth,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentRed),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentBlue),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentGreen),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text('Fixed | Spacer | Fixed — useful for app bars',
            style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        _privateTrack(
          width: trackWidth,
          child: Row(
            children: [
              SizedBox(width: 6.0),
              _privateBox(
                  width: 60.0,
                  height: 44.0,
                  color: _kAccentRed,
                  label: 'L'),
              Spacer(),
              _privateBox(
                  width: 60.0,
                  height: 44.0,
                  color: _kAccentGreen,
                  label: 'R'),
              SizedBox(width: 6.0),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text('Expanded(flex: 2) + plain SizedBox + Expanded',
            style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        _privateTrack(
          width: trackWidth,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentRed),
              ),
              SizedBox(
                width: 80.0,
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentAmber),
              ),
              Expanded(
                child: Container(
                    height: 44.0,
                    margin: EdgeInsets.all(4.0),
                    color: _kAccentGreen),
              ),
            ],
          ),
        ),
        _privateDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateCallout(
                title: 'Expanded',
                body: 'Forces the child to fill the available slice along '
                    'the main axis. Equivalent to Flexible(fit: tight).',
                tint: _kAccentBlue,
                icon: Icons.unfold_more,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _privateCallout(
                title: 'Flexible',
                body: 'Lets the child be smaller than its slice if its '
                    'intrinsic width is smaller. Default fit is loose.',
                tint: _kAccentTeal,
                icon: Icons.linear_scale,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _privateCallout(
                title: 'Spacer',
                body: 'A no-paint Expanded. Use it to push siblings apart '
                    'without rendering anything visible.',
                tint: _kAccentViolet,
                icon: Icons.space_bar,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — textDirection ltr vs rtl
// ---------------------------------------------------------------------------

Widget _privateDirectionDemo({required TextDirection direction}) {
  return Container(
    height: 80.0,
    decoration: BoxDecoration(
      color: _kPaper,
      border: Border.all(color: _kBorder, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.all(8.0),
    child: Row(
      textDirection: direction,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _privateBox(
            width: 50.0, height: 50.0, color: _kAccentRed, label: '1'),
        SizedBox(width: 6.0),
        _privateBox(
            width: 50.0, height: 50.0, color: _kAccentBlue, label: '2'),
        SizedBox(width: 6.0),
        _privateBox(
            width: 50.0, height: 50.0, color: _kAccentGreen, label: '3'),
      ],
    ),
  );
}

Widget _privateDirectionCard() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '6',
          'textDirection',
          'Picks which end of the row is "start". '
              'Defaults to the ambient Directionality.',
        ),
        SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TextDirection.ltr (default)',
                      style: _privateLabelStyle()),
                  SizedBox(height: 6.0),
                  _privateDirectionDemo(direction: TextDirection.ltr),
                  SizedBox(height: 6.0),
                  Text(
                    'children: [1, 2, 3] flow left → right',
                    style: _privateMonoStyle(color: _kInkMuted, size: 11.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TextDirection.rtl', style: _privateLabelStyle()),
                  SizedBox(height: 6.0),
                  _privateDirectionDemo(direction: TextDirection.rtl),
                  SizedBox(height: 6.0),
                  Text(
                    'children: [1, 2, 3] flow right → left',
                    style: _privateMonoStyle(color: _kInkMuted, size: 11.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _privateCallout(
          title: 'verticalDirection',
          body: 'Affects which end is "start" along the cross axis. '
              'Defaults to VerticalDirection.down — top is the start.',
          tint: _kAccentSlate,
          icon: Icons.import_export,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — textBaseline example
// ---------------------------------------------------------------------------

Widget _privateBaselineCard() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '7',
          'textBaseline',
          'Required when crossAxisAlignment is baseline. The Row aligns '
              'children on a chosen typographic baseline.',
        ),
        SizedBox(height: 18.0),
        Text('Without baseline (default — center)', style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: _kPaper,
            border: Border.all(color: _kBorder, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('42',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w800,
                    color: _kInkPrimary,
                  )),
              SizedBox(width: 6.0),
              Text('°C',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: _kInkSecondary,
                  )),
              SizedBox(width: 14.0),
              Text('today',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _kInkMuted,
                  )),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text('With baseline alignment', style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: _kAccentBlue.withValues(alpha: 0.05),
            border: Border.all(
                color: _kAccentBlue.withValues(alpha: 0.4), width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('42',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w800,
                    color: _kInkPrimary,
                  )),
              SizedBox(width: 6.0),
              Text('°C',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: _kInkSecondary,
                  )),
              SizedBox(width: 14.0),
              Text('today',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _kInkMuted,
                  )),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          '↑ Notice how the bottoms of "42", "°C" and "today" line up on '
          'the alphabetic baseline.',
          style: _privateBodyStyle(),
        ),
        SizedBox(height: 12.0),
        _privateCallout(
          title: 'Baseline only works with Text',
          body: 'A widget reports a baseline only if it computes one (Text '
              'does, Container does not). Mixing non-Text children under '
              'CrossAxisAlignment.baseline produces unexpected results.',
          tint: _kAccentAmber,
          icon: Icons.text_fields,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Overflow simulation
// ---------------------------------------------------------------------------

Widget _privateStripes({required double width}) {
  // Hand-drawn yellow-and-black overflow stripes using a Row of Containers.
  // We pick a stripe width and fill until the requested width is reached.
  const double stripe = 8.0;
  final int count = (width / stripe).ceil();
  final List<Widget> bars = <Widget>[];
  for (int i = 0; i < count; i++) {
    bars.add(
      Container(
        width: stripe,
        color: i.isEven ? Color(0xFFFACC15) : _kInkPrimary,
      ),
    );
  }
  return ClipRect(
    child: SizedBox(
      width: width,
      height: 14.0,
      child: Row(children: bars),
    ),
  );
}

Widget _privateOverflowCard() {
  const double trackWidth = _kCardWidth - 44.0 - 24.0;
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '8',
          'Overflow',
          'When children together demand more than the Row\'s width, '
              'Flutter draws the trademark yellow-and-black stripes.',
        ),
        SizedBox(height: 18.0),
        Text('A — children fit comfortably (no overflow)',
            style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        _privateTrack(
          width: trackWidth,
          child: Row(
            children: [
              SizedBox(width: 6.0),
              _privateBox(
                  width: 90.0,
                  height: 44.0,
                  color: _kAccentRed,
                  label: '90'),
              SizedBox(width: 6.0),
              _privateBox(
                  width: 90.0,
                  height: 44.0,
                  color: _kAccentBlue,
                  label: '90'),
              SizedBox(width: 6.0),
              _privateBox(
                  width: 90.0,
                  height: 44.0,
                  color: _kAccentGreen,
                  label: '90'),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Text('B — children too wide (simulated overflow)',
            style: _privateLabelStyle()),
        SizedBox(height: 6.0),
        Container(
          width: trackWidth,
          height: 70.0,
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentRed, width: 1.5),
          ),
          child: ClipRect(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      _privateBox(
                          width: 220.0,
                          height: 44.0,
                          color: _kAccentRed,
                          label: '220'),
                      SizedBox(width: 6.0),
                      _privateBox(
                          width: 220.0,
                          height: 44.0,
                          color: _kAccentBlue,
                          label: '220'),
                      SizedBox(width: 6.0),
                      _privateBox(
                          width: 220.0,
                          height: 44.0,
                          color: _kAccentGreen,
                          label: '220'),
                    ],
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _privateStripes(width: 18.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A RIGHT OVERFLOWED BY 116 PIXELS — Flutter\'s familiar warning.',
          style: _privateMonoStyle(color: _kAccentRed, size: 11.0),
        ),
        _privateDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateCallout(
                title: 'Fix 1 — Expanded / Flexible',
                body: 'Wrap one or more children in Expanded so they share '
                    'the available width instead of demanding their '
                    'intrinsic width.',
                tint: _kAccentTeal,
                icon: Icons.straighten,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _privateCallout(
                title: 'Fix 2 — Wrap',
                body: 'Replace Row with Wrap to push overflowing children '
                    'onto a new line. Wrap supports horizontal and '
                    'vertical run direction.',
                tint: _kAccentIndigo,
                icon: Icons.wrap_text,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _privateCallout(
                title: 'Fix 3 — Scroll',
                body: 'Wrap the Row in a SingleChildScrollView with '
                    'scrollDirection: Axis.horizontal to reveal '
                    'overflow on demand.',
                tint: _kAccentBlue,
                icon: Icons.swipe,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Recipe code listing
// ---------------------------------------------------------------------------

Widget _privateCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kInkPrimary,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        color: Color(0xFFE2E8F0),
        height: 1.55,
      ),
    ),
  );
}

Widget _privateRecipeCard() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '9',
          'Recipe — App-bar style Row',
          'A common pattern: leading icon, expanding title, trailing '
              'actions. Uses Expanded for the title so the actions stay '
              'pinned to the right edge.',
        ),
        SizedBox(height: 18.0),
        Container(
          height: 56.0,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: _kAccentBlue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.menu, color: Colors.white, size: 22.0),
              SizedBox(width: 14.0),
              Expanded(
                child: Text(
                  'Inbox',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(Icons.search, color: Colors.white, size: 22.0),
              SizedBox(width: 16.0),
              Icon(Icons.notifications_none, color: Colors.white, size: 22.0),
              SizedBox(width: 16.0),
              Icon(Icons.more_vert, color: Colors.white, size: 22.0),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        _privateCodeBlock(
          'Row(\n'
          '  crossAxisAlignment: CrossAxisAlignment.center,\n'
          '  children: [\n'
          '    Icon(Icons.menu),\n'
          '    SizedBox(width: 14),\n'
          '    Expanded(child: Text(\'Inbox\')),\n'
          '    Icon(Icons.search),\n'
          '    SizedBox(width: 16),\n'
          '    Icon(Icons.notifications_none),\n'
          '    SizedBox(width: 16),\n'
          '    Icon(Icons.more_vert),\n'
          '  ],\n'
          ')',
        ),
        SizedBox(height: 12.0),
        _privateCallout(
          title: 'Why Expanded on the title?',
          body: 'Without it, Text would shrink to its intrinsic width and '
              'the trailing icons would crowd against the title. '
              'Expanded forces the title to absorb the leftover space, '
              'pinning the actions to the right.',
          tint: _kAccentIndigo,
          icon: Icons.lightbulb_outline,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11 — Pitfalls
// ---------------------------------------------------------------------------

Widget _privatePitfallTile({
  required String title,
  required String body,
  required IconData icon,
  required Color color,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    margin: EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: _kInkPrimary,
                  )),
              SizedBox(height: 4.0),
              Text(body, style: _privateBodyStyle()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privatePitfallCard() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privateSectionHeader(
          '10',
          'Pitfalls',
          'Common mistakes when laying out with Row.',
        ),
        SizedBox(height: 16.0),
        _privatePitfallTile(
          title: 'Row inside an unconstrained-width parent',
          body: 'A Row inside a Column whose parent has no bounded width '
              '(or inside an unconstrained Stack, ListView, etc.) gets '
              'infinite max width. mainAxisSize.max + Expanded then '
              'throws BoxConstraints forces an infinite width. Fix: '
              'wrap the parent in IntrinsicWidth or constrain the Row.',
          icon: Icons.warning_amber,
          color: _kAccentAmber,
        ),
        _privatePitfallTile(
          title: 'mainAxisSize.min vs Expanded',
          body: 'Expanded asks for "all leftover space", but mainAxisSize.'
              'min refuses to claim leftover space. The two are mutually '
              'exclusive. Either drop Expanded, or switch to '
              'mainAxisSize.max.',
          icon: Icons.dangerous,
          color: _kAccentRed,
        ),
        _privatePitfallTile(
          title: 'Baseline only works with Text',
          body: 'CrossAxisAlignment.baseline expects each child to report '
              'a typographic baseline. Container, SizedBox and Image '
              'do not — only Text and a few Text-derivative widgets do. '
              'Mixing breaks alignment.',
          icon: Icons.report_gmailerrorred,
          color: _kAccentOrange,
        ),
        _privatePitfallTile(
          title: 'IntrinsicWidth + flex children = O(N²) layout',
          body: 'Wrapping a Row in IntrinsicWidth forces the Row to '
              'compute the intrinsic width of every flex child, which '
              'is expensive. Avoid in deep trees or long lists.',
          icon: Icons.speed,
          color: _kAccentViolet,
        ),
        _privatePitfallTile(
          title: 'Forgetting textDirection in widget tests',
          body: 'A bare Row outside a Directionality (e.g. inside a '
              'widget test that does not pump a MaterialApp) throws. '
              'Either pass textDirection explicitly or wrap in '
              'Directionality.',
          icon: Icons.translate,
          color: _kAccentTeal,
        ),
        _privatePitfallTile(
          title: 'Row vs Wrap',
          body: 'Row never wraps. If children must flow onto another '
              'line when they would otherwise overflow, swap Row for '
              'Wrap. Wrap also offers spacing and runSpacing.',
          icon: Icons.wrap_text,
          color: _kAccentIndigo,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 12 — Footer
// ---------------------------------------------------------------------------

Widget _privateFooter() {
  return _privateCard(
    padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kAccentBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(Icons.view_week_rounded,
                  color: _kAccentBlue, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Row',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: _kInkPrimary,
                    )),
                SizedBox(height: 2.0),
                Text(
                  'package:flutter/widgets.dart · extends Flex',
                  style: _privateMonoStyle(color: _kInkMuted, size: 11.5),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _privateChip('end of demo', _kInkPrimary),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Compose all sections
// ---------------------------------------------------------------------------

Widget _privateBody() {
  return Container(
    color: _kPaper,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _privateHeroCard(),
        SizedBox(height: _kSectionGap),
        _privateAnatomyCard(),
        SizedBox(height: _kSectionGap),
        _privateMainAxisCard(),
        SizedBox(height: _kSectionGap),
        _privateCrossCard(),
        SizedBox(height: _kSectionGap),
        _privateSizeCard(),
        SizedBox(height: _kSectionGap),
        _privateFlexCard(),
        SizedBox(height: _kSectionGap),
        _privateDirectionCard(),
        SizedBox(height: _kSectionGap),
        _privateBaselineCard(),
        SizedBox(height: _kSectionGap),
        _privateOverflowCard(),
        SizedBox(height: _kSectionGap),
        _privateRecipeCard(),
        SizedBox(height: _kSectionGap),
        _privatePitfallCard(),
        SizedBox(height: _kSectionGap),
        _privateFooter(),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Row · Visual Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccentBlue),
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: _kInkPrimary),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: _privateBody(),
      ),
    ),
  );
}
