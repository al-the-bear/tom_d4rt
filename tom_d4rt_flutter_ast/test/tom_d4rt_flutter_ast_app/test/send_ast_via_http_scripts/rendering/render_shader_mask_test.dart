// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: ShaderMask deep demo
// =============================================================================
// SHADERMASK DEEP DEMO
// -----------------------------------------------------------------------------
// This script visually exercises the ShaderMask widget across a wide variety
// of real-world configurations. Every section is hand-authored, fully static
// (no AnimationController, no setState, no .animate() calls), and intended to
// serve both as a smoke test for the Flutter AST execution path and as a
// standalone tutorial for the widget's API surface.
//
// What ShaderMask does, in plain English:
//   1. The child is painted opaquely into an offscreen layer (saveLayer).
//   2. A Shader produced by `shaderCallback(rect)` is composited onto that
//      layer using the supplied BlendMode.
//   3. The resulting masked image is then drawn at the position of the child.
// The most common BlendMode is `srcIn`, which keeps only the parts of the
// shader that overlap opaque pixels of the child -- producing the well-known
// "gradient text" effect.
// =============================================================================
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// =============================================================================
// HELPERS -- color palettes, gradient builders, label widgets, badge cards.
// Each helper returns a Widget so the build() method below can stay readable.
// =============================================================================

const Color kInk = Color(0xFF1F2933);
const Color kInkSoft = Color(0xFF52606D);
const Color kInkFaint = Color(0xFF9AA5B1);
const Color kPaper = Color(0xFFF5F7FA);
const Color kPaperDark = Color(0xFFE4E7EB);
const Color kAccent = Color(0xFF5C6AC4);
const Color kAccentWarm = Color(0xFFF59E0B);
const Color kAccentCool = Color(0xFF06B6D4);
const Color kAccentRose = Color(0xFFEC4899);
const Color kAccentLime = Color(0xFF84CC16);
const Color kAccentViolet = Color(0xFF8B5CF6);

LinearGradient warmGradient() {
  return LinearGradient(
    colors: [
      Color(0xFFFF6B6B),
      Color(0xFFFFD166),
      Color(0xFFFF9A8B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

LinearGradient coolGradient() {
  return LinearGradient(
    colors: [
      Color(0xFF06B6D4),
      Color(0xFF3B82F6),
      Color(0xFF6366F1),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

LinearGradient monochromeGradient() {
  return LinearGradient(
    colors: [
      Color(0xFF111827),
      Color(0xFF6B7280),
      Color(0xFFE5E7EB),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}

LinearGradient sunsetGradient() {
  return LinearGradient(
    colors: [
      Color(0xFFFAD0C4),
      Color(0xFFFFD1FF),
      Color(0xFFA18CD1),
      Color(0xFF6A85B6),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

LinearGradient forestGradient() {
  return LinearGradient(
    colors: [
      Color(0xFF134E5E),
      Color(0xFF71B280),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

LinearGradient candyGradient() {
  return LinearGradient(
    colors: [
      Color(0xFFFF9A9E),
      Color(0xFFFAD0C4),
      Color(0xFFFAD0C4),
      Color(0xFFFFDDE1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

BoxDecoration outlinedCard({Color? tint}) {
  final Color base = tint ?? kAccent;
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14.0),
    border: Border.all(color: base.withValues(alpha: 0.35), width: 1.0),
    boxShadow: [
      BoxShadow(
        color: base.withValues(alpha: 0.14),
        blurRadius: 18.0,
        offset: Offset(0.0, 8.0),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 4.0,
        offset: Offset(0.0, 2.0),
      ),
    ],
  );
}

Widget sectionHeader(
  String number,
  String title,
  String subtitle,
  IconData icon,
  Color tint,
) {
  return Container(
    margin: EdgeInsets.only(top: 36.0, bottom: 16.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          tint.withValues(alpha: 0.18),
          tint.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border(
        left: BorderSide(color: tint, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: tint.withValues(alpha: 0.5),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 22.0),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Section $number',
                    style: TextStyle(
                      fontSize: 11.0,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                      color: tint,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 4.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: kInkFaint,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'shader_mask.dart',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: kInkSoft,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: kInk,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13.0, color: kInkSoft),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget chipLabel(String text, Color tint, {IconData? icon}) {
  final children = <Widget>[];
  if (icon != null) {
    children.add(Icon(icon, size: 12.0, color: tint));
    children.add(SizedBox(width: 4.0));
  }
  children.add(
    Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: tint,
        letterSpacing: 0.4,
      ),
    ),
  );
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget codeSnippet(String text, {Color? tint}) {
  final Color t = tint ?? kAccent;
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: t.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: Color(0xFFE2E8F0),
        height: 1.5,
      ),
    ),
  );
}

Widget calloutLine(IconData icon, String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.0, color: color),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12.5, color: kInkSoft, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 builder -- Linear gradient text variants
// =============================================================================

Widget gradientHeadline(String text, LinearGradient gradient, double fontSize) {
  return ShaderMask(
    shaderCallback: (Rect bounds) => gradient.createShader(bounds),
    blendMode: BlendMode.srcIn,
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.0,
        // Color must be opaque white-ish for srcIn to work; the gradient
        // replaces those opaque pixels.
        color: Colors.white,
      ),
    ),
  );
}

Widget gradientTextVariantCard(
  String label,
  String sample,
  LinearGradient gradient,
  Color cardTint,
  IconData icon,
) {
  return Container(
    width: 260.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(18.0),
    decoration: outlinedCard(tint: cardTint),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: cardTint, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 11.0,
                color: cardTint,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        gradientHeadline(sample, gradient, 36.0),
        SizedBox(height: 10.0),
        Container(
          height: 6.0,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'BlendMode.srcIn keeps gradient pixels only where the text is opaque.',
          style: TextStyle(fontSize: 11.0, color: kInkSoft, height: 1.4),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3 builder -- radial fade-out card
// =============================================================================

Widget radialFadeCard() {
  return Container(
    width: 320.0,
    height: 220.0,
    decoration: outlinedCard(tint: kAccentRose),
    clipBehavior: Clip.antiAlias,
    child: ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment(0.0, -0.4),
          radius: 1.1,
          colors: [
            Colors.white,
            Colors.white,
            Colors.transparent,
          ],
          stops: [0.0, 0.55, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFCE7F3),
              Color(0xFFFBCFE8),
              Color(0xFFF9A8D4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.coffee, color: kAccentRose, size: 22.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Morning brew',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: kInk,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'A subtle radial mask makes the lower portion fade out '
                'without painting any actual gradient on top of the card. '
                'Useful for non-rectangular vignettes.',
                style: TextStyle(fontSize: 12.0, color: kInkSoft, height: 1.4),
              ),
              Spacer(),
              Row(
                children: [
                  chipLabel('dstIn', kAccentRose, icon: Icons.layers),
                  SizedBox(width: 6.0),
                  chipLabel(
                    'Radial',
                    kAccentRose,
                    icon: Icons.radio_button_checked,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 4 builder -- sweep gradient halo
// =============================================================================

Widget sweepHalo({double size = 180.0, IconData icon = Icons.bolt}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: kAccentViolet.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: ShaderMask(
      shaderCallback: (Rect bounds) {
        return SweepGradient(
          colors: [
            Color(0xFF8B5CF6),
            Color(0xFFEC4899),
            Color(0xFFF59E0B),
            Color(0xFF06B6D4),
            Color(0xFF8B5CF6),
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Icon(icon, size: size * 0.45, color: Colors.white),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 5 builder -- BlendMode catalogue (3x3 grid)
// =============================================================================

Widget blendModeCell(
  String label,
  BlendMode mode,
  Color srcColor,
  Color dstColor,
) {
  return Container(
    margin: EdgeInsets.all(6.0),
    width: 130.0,
    height: 130.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kPaperDark, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment(0.3, -0.2),
                radius: 0.8,
                colors: [srcColor, srcColor.withValues(alpha: 0.0)],
                stops: [0.0, 1.0],
              ).createShader(bounds);
            },
            blendMode: mode,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dstColor, dstColor.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.brightness_2,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          color: kPaper,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: kInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget blendModeCatalogue() {
  final Color src = kAccentWarm;
  final Color dst = kAccentCool;

  final row0 = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      blendModeCell('srcIn', BlendMode.srcIn, src, dst),
      blendModeCell('srcOut', BlendMode.srcOut, src, dst),
      blendModeCell('srcATop', BlendMode.srcATop, src, dst),
    ],
  );
  final row1 = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      blendModeCell('dstIn', BlendMode.dstIn, src, dst),
      blendModeCell('dstOut', BlendMode.dstOut, src, dst),
      blendModeCell('dstATop', BlendMode.dstATop, src, dst),
    ],
  );
  final row2 = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      blendModeCell('xor', BlendMode.xor, src, dst),
      blendModeCell('modulate', BlendMode.modulate, src, dst),
      blendModeCell('multiply', BlendMode.multiply, src, dst),
    ],
  );

  return Column(children: [row0, row1, row2]);
}

// =============================================================================
// SECTION 6 builder -- edge-fade scroll list mock
// =============================================================================

Widget edgeFadeListItem(int index, IconData icon, String name, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.14),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: kInk,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'Item #${index + 1} - tap to expand',
                style: TextStyle(fontSize: 11.0, color: kInkFaint),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: kInkFaint, size: 18.0),
      ],
    ),
  );
}

Widget edgeFadeListMock() {
  final items = <Widget>[
    edgeFadeListItem(
      0,
      Icons.assignment,
      'Compose a quarterly retrospective',
      kAccent,
    ),
    edgeFadeListItem(
      1,
      Icons.build,
      'Refactor the gradient builder cache',
      kAccentWarm,
    ),
    edgeFadeListItem(
      2,
      Icons.science,
      'Add unit tests for ShaderMask paths',
      kAccentCool,
    ),
    edgeFadeListItem(
      3,
      Icons.menu_book,
      'Document the BlendMode catalogue',
      kAccentRose,
    ),
    edgeFadeListItem(
      4,
      Icons.brush,
      'Sketch the spotlight effect mockup',
      kAccentLime,
    ),
    edgeFadeListItem(
      5,
      Icons.checklist,
      'Review Friday deployment checklist',
      kAccentViolet,
    ),
    edgeFadeListItem(
      6,
      Icons.school,
      'Prepare onboarding slides for design',
      kAccent,
    ),
    edgeFadeListItem(
      7,
      Icons.note_alt,
      'Annotate API parameter reference',
      kAccentWarm,
    ),
  ];

  return Container(
    width: 360.0,
    height: 320.0,
    decoration: outlinedCard(tint: kAccentLime),
    clipBehavior: Clip.antiAlias,
    child: ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
            Colors.black,
            Colors.transparent,
          ],
          stops: [0.0, 0.12, 0.88, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        children: items,
      ),
    ),
  );
}

// =============================================================================
// SECTION 7 builder -- spotlight effect over a busy backdrop
// =============================================================================

Widget backdropTile(IconData icon, Color color) {
  return Expanded(
    child: AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Icon(icon, color: Colors.white, size: 28.0),
        ),
      ),
    ),
  );
}

Widget busyBackdrop() {
  // Build a "busy" backdrop using stacked gradient swatches and icons. This
  // mimics a photo without requiring any asset files.
  final row0 = Expanded(
    child: Row(
      children: [
        backdropTile(Icons.star, Color(0xFFEF4444)),
        backdropTile(Icons.favorite, Color(0xFFF59E0B)),
        backdropTile(Icons.flash_on, Color(0xFF10B981)),
      ],
    ),
  );
  final row1 = Expanded(
    child: Row(
      children: [
        backdropTile(Icons.water_drop, Color(0xFF3B82F6)),
        backdropTile(Icons.diamond, Color(0xFF8B5CF6)),
        backdropTile(Icons.local_fire_department, Color(0xFFEC4899)),
      ],
    ),
  );
  final row2 = Expanded(
    child: Row(
      children: [
        backdropTile(Icons.spa, Color(0xFF14B8A6)),
        backdropTile(Icons.cake, Color(0xFFF97316)),
        backdropTile(Icons.celebration, Color(0xFF6366F1)),
      ],
    ),
  );
  return Column(children: [row0, row1, row2]);
}

Widget spotlightSection() {
  return Container(
    width: 380.0,
    height: 380.0,
    decoration: outlinedCard(tint: kAccent),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment(0.1, -0.1),
                radius: 0.55,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0.0, 0.65, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: busyBackdrop(),
          ),
        ),
        Positioned(
          left: 16.0,
          bottom: 16.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lightbulb, color: kAccentWarm, size: 16.0),
                SizedBox(width: 6.0),
                Text(
                  'Spotlight via dstIn',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 16.0,
          top: 16.0,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kAccent.withValues(alpha: 0.4),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Icon(Icons.center_focus_strong, color: kAccent, size: 22.0),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 builder -- API parameter reference card
// =============================================================================

Widget apiParameterRow(
  String name,
  String type,
  String description,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kPaperDark, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: kAccent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, size: 18.0, color: kAccent),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: kInk,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: kInkFaint, width: 1.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: kInkSoft,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(fontSize: 12.0, color: kInkSoft, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget apiReferenceCard() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: outlinedCard(tint: kAccentCool),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: kAccentCool, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'ShaderMask API parameters',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kInk,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        apiParameterRow(
          'shaderCallback',
          'Shader Function(Rect)',
          'Called with the bounds of the child during paint. Return a Shader '
              '(typically via Gradient.createShader). Allowed to return any '
              'dart:ui Shader subclass: gradients, image shaders, fragment '
              'shaders.',
          Icons.functions,
        ),
        apiParameterRow(
          'blendMode',
          'BlendMode',
          'Defaults to BlendMode.modulate. Common picks: srcIn for gradient '
              'text, dstIn for masking the child, srcATop for tinting opaque '
              'pixels of the child while preserving alpha.',
          Icons.layers,
        ),
        apiParameterRow(
          'child',
          'Widget?',
          'The widget that gets painted into the offscreen layer. The shader '
              'is then composited on top using blendMode.',
          Icons.widgets,
        ),
        SizedBox(height: 14.0),
        codeSnippet(
          'ShaderMask(\n'
          '  shaderCallback: (Rect bounds) {\n'
          '    return const LinearGradient(\n'
          '      colors: [Colors.purple, Colors.cyan],\n'
          '    ).createShader(bounds);\n'
          '  },\n'
          '  blendMode: BlendMode.srcIn,\n'
          '  child: const Text("Hello"),\n'
          ')',
          tint: kAccentCool,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9 builder -- pitfalls panel
// =============================================================================

Widget pitfallsPanel() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFF7ED),
          Color(0xFFFFEDD5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kAccentWarm.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: kAccentWarm.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: kAccentWarm, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & gotchas',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kInk,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        calloutLine(
          Icons.speed,
          'ShaderMask requires a saveLayer() during paint. saveLayer is one '
          'of the most expensive operations in Flutter; use it sparingly and '
          'avoid stacking multiple ShaderMasks inside scrolling lists.',
          kAccentWarm,
        ),
        calloutLine(
          Icons.opacity,
          'BlendMode.srcIn requires the child to paint opaque pixels into the '
          'layer. Translucent text (e.g. color: Colors.black54) will produce '
          'unexpectedly washed-out gradients.',
          kAccentWarm,
        ),
        calloutLine(
          Icons.visibility_off,
          'Wrapping a ShaderMask in Opacity does NOT compose cleanly: Opacity '
          'forces another saveLayer and changes the alpha of the masked '
          'output. Use a Color with non-1.0 alpha inside the gradient stops '
          'instead of nesting Opacity.',
          kAccentWarm,
        ),
        calloutLine(
          Icons.crop_free,
          'The Rect passed to shaderCallback is the bounds of the child after '
          'layout. It is not the bounds of the screen or the parent. Pass it '
          'directly to Gradient.createShader to get pixel-aligned results.',
          kAccentWarm,
        ),
        calloutLine(
          Icons.image_not_supported,
          'ShaderMask does not work well with platform views (HtmlElementView, '
          'AndroidView). Those views are composited above Flutter content and '
          'cannot participate in saveLayer-based effects.',
          kAccentWarm,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 builder -- See also references
// =============================================================================

Widget seeAlsoTile(
  IconData icon,
  String title,
  String description,
  Color tint,
) {
  return Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: tint.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: tint, size: 22.0),
        ),
        SizedBox(height: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: kInk,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.5, color: kInkSoft, height: 1.4),
        ),
      ],
    ),
  );
}

Widget seeAlsoSection() {
  return Wrap(
    children: [
      seeAlsoTile(
        Icons.blur_on,
        'BackdropFilter',
        'Applies an ImageFilter (blur, color matrix) to whatever is painted '
        'BEHIND the child. Different effect: it transforms existing pixels '
        'rather than masking the child.',
        kAccentCool,
      ),
      seeAlsoTile(
        Icons.crop,
        'ClipPath',
        'Clips the child to an arbitrary Path. Use this when you want a hard '
        'edge instead of a smooth gradient mask.',
        kAccentRose,
      ),
      seeAlsoTile(
        Icons.image,
        'Image (with shader)',
        'Use Paint().shader together with a CustomPainter for fine-grained '
        'control. ShaderMask is the declarative shortcut for the common case.',
        kAccentLime,
      ),
      seeAlsoTile(
        Icons.gradient,
        'Gradient.createShader',
        'The lower-level call ShaderMask delegates to. Always pass it the '
        'rect from the shaderCallback for correctly-aligned gradients.',
        kAccentViolet,
      ),
      seeAlsoTile(
        Icons.color_lens,
        'ColorFiltered',
        'Cheaper than ShaderMask when you just need a constant ColorFilter '
        '(e.g. saturation, matrix). Avoids saveLayer in many cases.',
        kAccentWarm,
      ),
      seeAlsoTile(
        Icons.texture,
        'FragmentProgram',
        'Custom GLSL shaders via FragmentProgram.fromAsset. The resulting '
        'FragmentShader can be returned directly from shaderCallback.',
        kAccent,
      ),
    ],
  );
}

// =============================================================================
// MAIN BUILD METHOD
// =============================================================================

dynamic build(BuildContext context) {
  print('ShaderMask Deep Demo executing');
  print('  ui.PointMode reference (sanity import): ${ui.PointMode.points}');

  // -------------------------------------------------------------------------
  // SECTION 1: Hero header
  // -------------------------------------------------------------------------
  print('=== Section 1: Hero header ===');

  final Widget heroHeader = Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16.0),
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF111827),
          Color(0xFF1F2937),
          Color(0xFF312E81),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF312E81).withValues(alpha: 0.5),
          blurRadius: 30.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(Icons.gradient, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Text(
              'WIDGET DEEP DEMO',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white.withValues(alpha: 0.7),
                letterSpacing: 2.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        gradientHeadline('ShaderMask', warmGradient(), 56.0),
        SizedBox(height: 12.0),
        Text(
          'A widget that applies a Shader to the painted output of its child '
          'using a configurable BlendMode. The child is rendered into an '
          'offscreen layer; the shader is then composited onto that layer '
          'before the result is drawn into the parent.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.85),
            height: 1.6,
          ),
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            chipLabel('shaderCallback', kAccentWarm, icon: Icons.functions),
            chipLabel('blendMode', kAccentRose, icon: Icons.layers),
            chipLabel('saveLayer', kAccentCool, icon: Icons.speed),
            chipLabel('declarative', kAccentLime, icon: Icons.bolt),
            chipLabel('compositing', kAccentViolet, icon: Icons.brush),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2: Linear gradient text demos
  // -------------------------------------------------------------------------
  print('=== Section 2: Gradient text variants ===');

  final Widget gradientTextRow = Wrap(
    alignment: WrapAlignment.center,
    children: [
      gradientTextVariantCard(
        'Warm',
        'Aurora',
        warmGradient(),
        kAccentWarm,
        Icons.local_fire_department,
      ),
      gradientTextVariantCard(
        'Cool',
        'Ocean',
        coolGradient(),
        kAccentCool,
        Icons.water_drop,
      ),
      gradientTextVariantCard(
        'Mono',
        'Slate',
        monochromeGradient(),
        kInk,
        Icons.contrast,
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 3: Radial fade-out card
  // -------------------------------------------------------------------------
  print('=== Section 3: Radial fade-out card ===');

  final Widget radialFadeRow = Wrap(
    alignment: WrapAlignment.center,
    children: [
      radialFadeCard(),
      Container(
        width: 320.0,
        height: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(20.0),
        decoration: outlinedCard(tint: kAccentRose),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tune, color: kAccentRose, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'How dstIn works',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: kInk,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'BlendMode.dstIn keeps only the pixels of the destination '
              '(the child) where the source (the shader) is opaque. By '
              'using a transparent radial gradient, the child fades to '
              'nothing along the gradient direction.',
              style: TextStyle(fontSize: 12.0, color: kInkSoft, height: 1.5),
            ),
            SizedBox(height: 12.0),
            codeSnippet(
              'shaderCallback: (rect) =>\n'
              '  RadialGradient(\n'
              '    colors: [white, transparent],\n'
              '  ).createShader(rect)\n'
              'blendMode: BlendMode.dstIn',
              tint: kAccentRose,
            ),
          ],
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 4: Sweep gradient halo
  // -------------------------------------------------------------------------
  print('=== Section 4: Sweep gradient halo ===');

  final Widget sweepHaloRow = Container(
    padding: EdgeInsets.all(20.0),
    decoration: outlinedCard(tint: kAccentViolet),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        sweepHalo(size: 130.0, icon: Icons.bolt),
        sweepHalo(size: 160.0, icon: Icons.auto_awesome),
        sweepHalo(size: 130.0, icon: Icons.flare),
      ],
    ),
  );

  final Widget sweepExplanation = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kPaperDark, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: kAccentViolet, size: 18.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'A SweepGradient revolves around a centre point. With '
            'BlendMode.srcATop the gradient tints the icon while preserving '
            'the original alpha, producing the colourful halo effect '
            'commonly used for AI / energy / "magic" affordances.',
            style: TextStyle(fontSize: 12.5, color: kInkSoft, height: 1.5),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5: Blend mode catalogue
  // -------------------------------------------------------------------------
  print('=== Section 5: BlendMode catalogue ===');

  final Widget blendCatalogue = Column(
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: candyGradient(),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(Icons.palette, color: kInk, size: 18.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Same source (warm radial) and destination (cool linear) '
                'composited under nine different BlendModes:',
                style: TextStyle(
                  fontSize: 12.5,
                  color: kInk,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      blendModeCatalogue(),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 6: Edge-fade scroll list
  // -------------------------------------------------------------------------
  print('=== Section 6: Edge-fade scroll list ===');

  final Widget edgeFadeRow = Wrap(
    alignment: WrapAlignment.center,
    children: [
      edgeFadeListMock(),
      Container(
        width: 360.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(20.0),
        decoration: outlinedCard(tint: kAccentLime),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.swap_vert, color: kAccentLime, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Why fade scroll edges?',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: kInk,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'A vertical 4-stop linear gradient (transparent -> opaque -> '
              'opaque -> transparent) used as a dstIn mask hides items as '
              'they reach the top or bottom of the scroll viewport. This '
              'avoids the harsh "cut-off" look that a plain ClipRect '
              'produces and signals scrollability without adding '
              'scrollbars.',
              style: TextStyle(fontSize: 12.0, color: kInkSoft, height: 1.5),
            ),
            SizedBox(height: 12.0),
            codeSnippet(
              'ShaderMask(\n'
              '  shaderCallback: (r) => LinearGradient(\n'
              '    begin: Alignment.topCenter,\n'
              '    end: Alignment.bottomCenter,\n'
              '    colors: const [\n'
              '      Colors.transparent,\n'
              '      Colors.black,\n'
              '      Colors.black,\n'
              '      Colors.transparent,\n'
              '    ],\n'
              '    stops: const [0, 0.12, 0.88, 1],\n'
              '  ).createShader(r),\n'
              '  blendMode: BlendMode.dstIn,\n'
              '  child: ListView(...),\n'
              ')',
              tint: kAccentLime,
            ),
          ],
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 7: Spotlight effect
  // -------------------------------------------------------------------------
  print('=== Section 7: Spotlight effect ===');

  final Widget spotlightRow = Wrap(
    alignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      spotlightSection(),
      Container(
        width: 320.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(20.0),
        decoration: outlinedCard(tint: kAccent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.center_focus_weak, color: kAccent, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Anatomy of a spotlight',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: kInk,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            calloutLine(
              Icons.layers,
              'Stack the busy backdrop, the masked layer, and any caption '
              'overlays as separate Stack children. Only the masked layer '
              'pays the saveLayer cost.',
              kAccent,
            ),
            calloutLine(
              Icons.adjust,
              'Tweak the radial gradient stops (0.0 / 0.65 / 1.0) to control '
              'how sharp the spotlight edge feels. A small inner-stop range '
              'gives a hard light; a wide range gives a soft halo.',
              kAccent,
            ),
            calloutLine(
              Icons.location_on,
              'Move the spotlight by changing the RadialGradient.center '
              'alignment. Animating that alignment via implicit '
              'AnimatedAlign is a cheap way to create a moving torch effect '
              'without an AnimationController.',
              kAccent,
            ),
          ],
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 8: API parameter reference card
  // -------------------------------------------------------------------------
  print('=== Section 8: API parameter reference ===');
  final Widget apiRef = apiReferenceCard();

  // -------------------------------------------------------------------------
  // SECTION 9: Pitfalls panel
  // -------------------------------------------------------------------------
  print('=== Section 9: Pitfalls panel ===');
  final Widget pitfalls = pitfallsPanel();

  // -------------------------------------------------------------------------
  // SECTION 10: See also references
  // -------------------------------------------------------------------------
  print('=== Section 10: See also ===');
  final Widget seeAlso = seeAlsoSection();

  // -------------------------------------------------------------------------
  // FOOTER -- summary
  // -------------------------------------------------------------------------
  final Widget footer = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 32.0, bottom: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: forestGradient(),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF134E5E).withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.flag, color: Colors.white, size: 22.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'End of demo',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'You have just seen ShaderMask used for gradient text, edge '
                'fades, sweep halos, blend-mode demonstrations, scroll-edge '
                'masks, spotlights, API references, pitfalls, and pointers '
                'to related widgets.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.white.withValues(alpha: 0.92),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // FINAL ASSEMBLY
  // -------------------------------------------------------------------------
  print('=== Assembling final tree ===');

  return Container(
    color: kPaper,
    padding: EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heroHeader,
          sectionHeader(
            '02',
            'Linear gradient text',
            'Three palettes, one BlendMode (srcIn). Glyphs become canvases.',
            Icons.text_fields,
            kAccentWarm,
          ),
          gradientTextRow,
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: sunsetGradient(),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFA18CD1).withValues(alpha: 0.4),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.tips_and_updates, color: kInk, size: 20.0),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Tip: pass a Color (e.g. Colors.white) to the underlying '
                    'Text style; the gradient replaces those pixels via '
                    'BlendMode.srcIn. Translucent text colours will mute '
                    'the gradient.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: kInk,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          sectionHeader(
            '03',
            'Radial fade-out',
            'BlendMode.dstIn turns alpha gradients into vignette masks.',
            Icons.blur_on,
            kAccentRose,
          ),
          radialFadeRow,
          sectionHeader(
            '04',
            'Sweep gradient halo',
            'A SweepGradient + srcATop tints icons into rainbow medallions.',
            Icons.auto_awesome,
            kAccentViolet,
          ),
          sweepHaloRow,
          sweepExplanation,
          sectionHeader(
            '05',
            'BlendMode catalogue',
            'Same source and destination compared under nine modes.',
            Icons.grid_view,
            kAccentCool,
          ),
          blendCatalogue,
          sectionHeader(
            '06',
            'Edge-fade scroll list',
            'Hide list items as they enter and leave the viewport.',
            Icons.format_list_bulleted,
            kAccentLime,
          ),
          edgeFadeRow,
          sectionHeader(
            '07',
            'Spotlight effect',
            'Reveal a circular region of a busy backdrop using dstIn.',
            Icons.center_focus_strong,
            kAccent,
          ),
          spotlightRow,
          sectionHeader(
            '08',
            'API parameter reference',
            'shaderCallback, blendMode, child -- the three knobs you tune.',
            Icons.api,
            kAccentCool,
          ),
          apiRef,
          sectionHeader(
            '09',
            'Pitfalls & gotchas',
            'saveLayer cost, Opacity composition, platform views, alpha.',
            Icons.warning_amber,
            kAccentWarm,
          ),
          pitfalls,
          sectionHeader(
            '10',
            'See also',
            'Related widgets and lower-level APIs worth knowing.',
            Icons.menu_book,
            kAccentViolet,
          ),
          seeAlso,
          footer,
        ],
      ),
    ),
  );
}
